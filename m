Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73A75CCFED
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 11:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfJFJVB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 05:21:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbfJFJVB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 05:21:01 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A83CD2133F;
        Sun,  6 Oct 2019 09:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570353660;
        bh=0WtAsuS/TiU4jZenpVJSY0nsQ8it454+moPErCiK4Co=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WgoZOepcMPVy/cHDegVhR9iIzYIel8Ti8HWpjVnfW7obsPErqmGnjdrQ3MDFD1Bza
         9laurD8I4iGBEH8HB1+lyCOWct2GMTZWkNW4/+NcJoj62ujwXEZ2i3dtmhxi6wu4ZU
         t4Ls9EEchF6lelTe0o5UG/9PqaDZFvxymsUet1d4=
Date:   Sun, 6 Oct 2019 10:20:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/10] iio: imu: adis16400: rework locks using ADIS
 library's state lock
Message-ID: <20191006102056.686fdd06@archlinux>
In-Reply-To: <20190926111812.15957-9-alexandru.ardelean@analog.com>
References: <20190926111812.15957-1-alexandru.ardelean@analog.com>
        <20190926111812.15957-9-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 26 Sep 2019 14:18:10 +0300
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change removes the use of indio_dev's mlock in favor using the state
> lock from the ADIS library.
> 
> The set_freq() & get_freq() hooks are unlocked, so they require specific
> locking. That is because in some cases the get_freq() hook is used in
> combination with adis16400_set_filter().
> 
> In cases where only one read/write is done, the functions that hold the
> state lock are used.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis16400.c | 51 ++++++++++++++++++-------------------
>  1 file changed, 25 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16400.c b/drivers/iio/imu/adis16400.c
> index 0575ff706bd4..e042a2aabf6b 100644
> --- a/drivers/iio/imu/adis16400.c
> +++ b/drivers/iio/imu/adis16400.c
> @@ -162,6 +162,7 @@ struct adis16400_chip_info {
>  	unsigned int accel_scale_micro;
>  	int temp_scale_nano;
>  	int temp_offset;
> +	/* set_freq() & get_freq() need to avoid using ADIS lib's state lock */
>  	int (*set_freq)(struct adis16400_state *st, unsigned int freq);
>  	int (*get_freq)(struct adis16400_state *st);
>  };
> @@ -326,7 +327,7 @@ static int adis16334_get_freq(struct adis16400_state *st)
>  	int ret;
>  	uint16_t t;
>  
> -	ret = adis_read_reg_16(&st->adis, ADIS16400_SMPL_PRD, &t);
> +	ret = __adis_read_reg_16(&st->adis, ADIS16400_SMPL_PRD, &t);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -350,7 +351,7 @@ static int adis16334_set_freq(struct adis16400_state *st, unsigned int freq)
>  	t <<= ADIS16334_RATE_DIV_SHIFT;
>  	t |= ADIS16334_RATE_INT_CLK;
>  
> -	return adis_write_reg_16(&st->adis, ADIS16400_SMPL_PRD, t);
> +	return __adis_write_reg_16(&st->adis, ADIS16400_SMPL_PRD, t);
>  }
>  
>  static int adis16400_get_freq(struct adis16400_state *st)
> @@ -358,7 +359,7 @@ static int adis16400_get_freq(struct adis16400_state *st)
>  	int sps, ret;
>  	uint16_t t;
>  
> -	ret = adis_read_reg_16(&st->adis, ADIS16400_SMPL_PRD, &t);
> +	ret = __adis_read_reg_16(&st->adis, ADIS16400_SMPL_PRD, &t);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -390,7 +391,7 @@ static int adis16400_set_freq(struct adis16400_state *st, unsigned int freq)
>  	else
>  		st->adis.spi->max_speed_hz = ADIS16400_SPI_FAST;
>  
> -	return adis_write_reg_8(&st->adis, ADIS16400_SMPL_PRD, val);
> +	return __adis_write_reg_8(&st->adis, ADIS16400_SMPL_PRD, val);
>  }
>  
>  static const unsigned int adis16400_3db_divisors[] = {
> @@ -404,7 +405,7 @@ static const unsigned int adis16400_3db_divisors[] = {
>  	[7] = 200, /* Not a valid setting */
>  };
>  
> -static int adis16400_set_filter(struct iio_dev *indio_dev, int sps, int val)
> +static int __adis16400_set_filter(struct iio_dev *indio_dev, int sps, int val)
>  {
>  	struct adis16400_state *st = iio_priv(indio_dev);
>  	uint16_t val16;
> @@ -415,11 +416,11 @@ static int adis16400_set_filter(struct iio_dev *indio_dev, int sps, int val)
>  			break;
>  	}
>  
> -	ret = adis_read_reg_16(&st->adis, ADIS16400_SENS_AVG, &val16);
> +	ret = __adis_read_reg_16(&st->adis, ADIS16400_SENS_AVG, &val16);
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = adis_write_reg_16(&st->adis, ADIS16400_SENS_AVG,
> +	ret = __adis_write_reg_16(&st->adis, ADIS16400_SENS_AVG,
>  					 (val16 & ~0x07) | i);
>  	return ret;
>  }
> @@ -507,32 +508,31 @@ static int adis16400_write_raw(struct iio_dev *indio_dev,
>  	struct iio_chan_spec const *chan, int val, int val2, long info)
>  {
>  	struct adis16400_state *st = iio_priv(indio_dev);
> +	struct mutex *slock = &st->adis.state_lock;
>  	int ret, sps;
>  
>  	switch (info) {
>  	case IIO_CHAN_INFO_CALIBBIAS:
> -		mutex_lock(&indio_dev->mlock);
>  		ret = adis_write_reg_16(&st->adis,
>  				adis16400_addresses[chan->scan_index], val);
> -		mutex_unlock(&indio_dev->mlock);
>  		return ret;
>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>  		/*
>  		 * Need to cache values so we can update if the frequency
>  		 * changes.
>  		 */
> -		mutex_lock(&indio_dev->mlock);
> +		mutex_lock(slock);
>  		st->filt_int = val;
>  		/* Work out update to current value */
>  		sps = st->variant->get_freq(st);
>  		if (sps < 0) {
> -			mutex_unlock(&indio_dev->mlock);
> +			mutex_unlock(slock);
>  			return sps;
>  		}
>  
> -		ret = adis16400_set_filter(indio_dev, sps,
> +		ret = __adis16400_set_filter(indio_dev, sps,
>  			val * 1000 + val2 / 1000);
> -		mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(slock);
>  		return ret;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		sps = val * 1000 + val2 / 1000;
> @@ -540,9 +540,9 @@ static int adis16400_write_raw(struct iio_dev *indio_dev,
>  		if (sps <= 0)
>  			return -EINVAL;
>  
> -		mutex_lock(&indio_dev->mlock);
> +		mutex_lock(slock);
>  		ret = st->variant->set_freq(st, sps);
> -		mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(slock);
>  		return ret;
>  	default:
>  		return -EINVAL;
> @@ -553,6 +553,7 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
>  	struct iio_chan_spec const *chan, int *val, int *val2, long info)
>  {
>  	struct adis16400_state *st = iio_priv(indio_dev);
> +	struct mutex *slock = &st->adis.state_lock;
>  	int16_t val16;
>  	int ret;
>  
> @@ -596,10 +597,8 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  		}
>  	case IIO_CHAN_INFO_CALIBBIAS:
> -		mutex_lock(&indio_dev->mlock);
>  		ret = adis_read_reg_16(&st->adis,
>  				adis16400_addresses[chan->scan_index], &val16);
> -		mutex_unlock(&indio_dev->mlock);
>  		if (ret)
>  			return ret;
>  		val16 = sign_extend32(val16, 11);
> @@ -610,27 +609,27 @@ static int adis16400_read_raw(struct iio_dev *indio_dev,
>  		*val = st->variant->temp_offset;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> -		mutex_lock(&indio_dev->mlock);
> +		mutex_lock(slock);
>  		/* Need both the number of taps and the sampling frequency */
> -		ret = adis_read_reg_16(&st->adis,
> +		ret = __adis_read_reg_16(&st->adis,
>  						ADIS16400_SENS_AVG,
>  						&val16);
>  		if (ret < 0) {
> -			mutex_unlock(&indio_dev->mlock);
> +			mutex_unlock(slock);
>  			return ret;
>  		}
>  		ret = st->variant->get_freq(st);
> -		if (ret >= 0) {
> -			ret /= adis16400_3db_divisors[val16 & 0x07];
> -			*val = ret / 1000;
> -			*val2 = (ret % 1000) * 1000;
> -		}
> -		mutex_unlock(&indio_dev->mlock);
> +		mutex_unlock(slock);
>  		if (ret < 0)
>  			return ret;
> +		ret /= adis16400_3db_divisors[val16 & 0x07];
> +		*val = ret / 1000;
> +		*val2 = (ret % 1000) * 1000;
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> +		mutex_lock(slock);
>  		ret = st->variant->get_freq(st);
> +		mutex_unlock(slock);
>  		if (ret < 0)
>  			return ret;
>  		*val = ret / 1000;

