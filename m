Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B84301C4D
	for <lists+linux-iio@lfdr.de>; Sun, 24 Jan 2021 14:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbhAXNoI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 24 Jan 2021 08:44:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:47804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbhAXNoH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Jan 2021 08:44:07 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD660227BF;
        Sun, 24 Jan 2021 13:43:24 +0000 (UTC)
Date:   Sun, 24 Jan 2021 13:43:21 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH 2/4] iio: adis16480: fix pps mode sampling frequency
 math
Message-ID: <20210124134321.713aa5ce@archlinux>
In-Reply-To: <20210121114954.64156-3-nuno.sa@analog.com>
References: <20210121114954.64156-1-nuno.sa@analog.com>
        <20210121114954.64156-3-nuno.sa@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 21 Jan 2021 12:49:52 +0100
Nuno Sá <nuno.sa@analog.com> wrote:

> When using PPS mode, the input clock needs to be scaled so that we have
> an IMU sample rate between (optimally) 4000 and 4250. After this, we can
> use the decimation filter to lower the sampling rate in order to get what
> the user wants. Optimally, the user sample rate is a multiple of both the
> IMU sample rate and the input clock. Hence, calculating the sync_scale
> dynamically gives us better chances of achieving a perfect/integer value
> for DEC_RATE. The math here is:
>  1. lcm of the input clock and the desired output rate.
>  2. get the highest multiple of the previous result lower than the adis
>     max rate.
>  3. The last result becomes the IMU sample rate. Use that to calculate
>     SYNC_SCALE and DEC_RATE (to get the user output rate).
> 
> Fixes: 326e2357553d3 ("iio: imu: adis16480: Add support for external clock")
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>

As this is a fix, please move the refactor of the lock to after this patch.
We don't really want to need to backport that patch in order to apply this
to older kernels.

I'll reply to the cover letter as to what might make sense to do for
the case where we are potentially running the sensor too slow.

Otherwise, patch looks fine to me.

Jonathan

> ---
>  drivers/iio/imu/adis16480.c | 120 ++++++++++++++++++++++++++----------
>  1 file changed, 86 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index dfe86c589325..7620822f3350 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -17,6 +17,7 @@
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
>  #include <linux/module.h>
> +#include <linux/lcm.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -312,7 +313,8 @@ static int adis16480_debugfs_init(struct iio_dev *indio_dev)
>  static int adis16480_set_freq(struct iio_dev *indio_dev, int val, int val2)
>  {
>  	struct adis16480 *st = iio_priv(indio_dev);
> -	unsigned int t, reg;
> +	unsigned int t, sample_rate = st->clk_freq;
> +	int ret;
>  
>  	if (val < 0 || val2 < 0)
>  		return -EINVAL;
> @@ -321,28 +323,63 @@ static int adis16480_set_freq(struct iio_dev *indio_dev, int val, int val2)
>  	if (t == 0)
>  		return -EINVAL;
>  
> +	adis_dev_lock(&st->adis);
>  	/*
> -	 * When using PPS mode, the rate of data collection is equal to the
> -	 * product of the external clock frequency and the scale factor in the
> -	 * SYNC_SCALE register.
> -	 * When using sync mode, or internal clock, the output data rate is
> -	 * equal with  the clock frequency divided by DEC_RATE + 1.
> +	 * When using PPS mode, the input clock needs to be scaled so that we have an IMU
> +	 * sample rate between (optimally) 4000 and 4250. After this, we can use the
> +	 * decimation filter to lower the sampling rate in order to get what the user wants.
> +	 * Optimally, the user sample rate is a multiple of both the IMU sample rate and
> +	 * the input clock. Hence, calculating the sync_scale dynamically gives us better
> +	 * chances of achieving a perfect/integer value for DEC_RATE. The math here is:
> +	 *	1. lcm of the input clock and the desired output rate.
> +	 *	2. get the highest multiple of the previous result lower than the adis max rate.
> +	 *	3. The last result becomes the IMU sample rate. Use that to calculate SYNC_SCALE
> +	 *	   and DEC_RATE (to get the user output rate)
>  	 */
>  	if (st->clk_mode == ADIS16480_CLK_PPS) {
> -		t = t / st->clk_freq;
> -		reg = ADIS16495_REG_SYNC_SCALE;
> -	} else {
> -		t = st->clk_freq / t;
> -		reg = ADIS16480_REG_DEC_RATE;
> +		unsigned long scaled_rate = lcm(st->clk_freq, t);
> +		int sync_scale;
> +		struct device *dev = &st->adis.spi->dev;
> +
> +		/*
> +		 * If lcm is bigger than the IMU maximum sampling rate there's no perfect
> +		 * solution. In this case, we get the highest multiple of the input clock
> +		 * lower that the IMU max sample rate.
> +		 */
> +		if (scaled_rate > st->chip_info->int_clk)
> +			scaled_rate = st->chip_info->int_clk / st->clk_freq * st->clk_freq;
> +		else
> +			scaled_rate = st->chip_info->int_clk / scaled_rate * scaled_rate;
> +
> +		/*
> +		 * This is not an hard requirement but it's not advised to run the IMU
> +		 * with a sample rate lower than 4000Hz due to possible undersampling
> +		 * issues so we will log a warning here. We could even force the rate
> +		 * to 4000 but some users might really want this...
> +		 */
> +		if (scaled_rate < 4000000)
> +			dev_warn(dev, "Possible undersampling issues due to sampling rate=%lu < 4000\n",
> +				 scaled_rate / 1000);
> +
> +		sync_scale = scaled_rate / st->clk_freq;
> +		ret = __adis_write_reg_16(&st->adis, ADIS16495_REG_SYNC_SCALE, sync_scale);
> +		if (ret)
> +			goto error;
> +
> +		sample_rate = scaled_rate;
>  	}
>  
> +	t = DIV_ROUND_CLOSEST(sample_rate, t);
> +	if (t)
> +		t--;
> +
>  	if (t > st->chip_info->max_dec_rate)
>  		t = st->chip_info->max_dec_rate;
>  
> -	if ((t != 0) && (st->clk_mode != ADIS16480_CLK_PPS))
> -		t--;
> -
> -	return adis_write_reg_16(&st->adis, reg, t);
> +	ret = __adis_write_reg_16(&st->adis, ADIS16480_REG_DEC_RATE, t);
> +error:
> +	adis_dev_unlock(&st->adis);
> +	return ret;
>  }
>  
>  static int adis16480_get_freq(struct iio_dev *indio_dev, int *val, int *val2)
> @@ -350,34 +387,35 @@ static int adis16480_get_freq(struct iio_dev *indio_dev, int *val, int *val2)
>  	struct adis16480 *st = iio_priv(indio_dev);
>  	uint16_t t;
>  	int ret;
> -	unsigned int freq;
> -	unsigned int reg;
> +	unsigned int freq, sample_rate = st->clk_freq;
>  
> -	if (st->clk_mode == ADIS16480_CLK_PPS)
> -		reg = ADIS16495_REG_SYNC_SCALE;
> -	else
> -		reg = ADIS16480_REG_DEC_RATE;
> +	adis_dev_lock(&st->adis);
>  
> -	ret = adis_read_reg_16(&st->adis, reg, &t);
> +	if (st->clk_mode == ADIS16480_CLK_PPS) {
> +		u16 sync_scale;
> +
> +		ret = __adis_read_reg_16(&st->adis, ADIS16495_REG_SYNC_SCALE, &sync_scale);
> +		if (ret)
> +			goto error;
> +
> +		sample_rate = st->clk_freq * sync_scale;
> +	}
> +
> +	ret = __adis_read_reg_16(&st->adis, ADIS16480_REG_DEC_RATE, &t);
>  	if (ret)
> -		return ret;
> +		goto error;
>  
> -	/*
> -	 * When using PPS mode, the rate of data collection is equal to the
> -	 * product of the external clock frequency and the scale factor in the
> -	 * SYNC_SCALE register.
> -	 * When using sync mode, or internal clock, the output data rate is
> -	 * equal with  the clock frequency divided by DEC_RATE + 1.
> -	 */
> -	if (st->clk_mode == ADIS16480_CLK_PPS)
> -		freq = st->clk_freq * t;
> -	else
> -		freq = st->clk_freq / (t + 1);
> +	adis_dev_unlock(&st->adis);
> +
> +	freq = DIV_ROUND_CLOSEST(sample_rate, (t + 1));
>  
>  	*val = freq / 1000;
>  	*val2 = (freq % 1000) * 1000;
>  
>  	return IIO_VAL_INT_PLUS_MICRO;
> +error:
> +	adis_dev_unlock(&st->adis);
> +	return ret;
>  }
>  
>  enum {
> @@ -1278,6 +1316,20 @@ static int adis16480_probe(struct spi_device *spi)
>  
>  		st->clk_freq = clk_get_rate(st->ext_clk);
>  		st->clk_freq *= 1000; /* micro */
> +		if (st->clk_mode == ADIS16480_CLK_PPS) {
> +			u16 sync_scale;
> +
> +			/*
> +			 * In PPS mode, the IMU sample rate is the clk_freq * sync_scale. Hence,
> +			 * default the IMU sample rate to the highest multiple of the input clock
> +			 * lower than the IMU max sample rate. The internal sample rate is the
> +			 * max...
> +			 */
> +			sync_scale = st->chip_info->int_clk / st->clk_freq;
> +			ret = __adis_write_reg_16(&st->adis, ADIS16495_REG_SYNC_SCALE, sync_scale);
> +			if (ret)
> +				return ret;
> +		}
>  	} else {
>  		st->clk_freq = st->chip_info->int_clk;
>  	}

