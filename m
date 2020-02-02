Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8BC14FE43
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2020 17:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgBBQWU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Feb 2020 11:22:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:57708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726907AbgBBQWU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Feb 2020 11:22:20 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB36920679;
        Sun,  2 Feb 2020 16:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580660539;
        bh=KNdyhD3w4yCdwrz3wHVgo4rj2j28SvdHOaIBi+5JM3A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wssfoGoRbDyGixeBuWYuQH5ygKNexFHrJzjYiVGaa//0uwq4zMSakCBYAS/pItZHi
         Zn3hin+BVfJ8RhmFeMH9Ter6c/W0acHW+WHlDbXkAOJwbVtJix6P0PZh0ks0wRWi8F
         n1KirtMK4D4mKlE1SUyrp/U0RTm2kbTrNuHTNRCc=
Date:   Sun, 2 Feb 2020 16:22:15 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ad7124: add 3db filter
Message-ID: <20200202162215.50915c83@archlinux>
In-Reply-To: <20200122085414.16950-1-alexandru.tachici@analog.com>
References: <20200122085414.16950-1-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Jan 2020 10:54:14 +0200
Alexandru Tachici <alexandru.tachici@analog.com> wrote:

> This patch adds the LOW_PASS_FILTER_3DB_FREQUENCY attribute
> in iio_chan_spec for each channel. The used filters are sinc3
> or sinc4. The filter type with the highest output data rate
> is used when setting a low pass frequency in the channel's sysfs.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7124.c | 69 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 68 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 52f45b13da4a..8f48c0581f02 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -70,6 +70,11 @@
>  /* AD7124_FILTER_X */
>  #define AD7124_FILTER_FS_MSK		GENMASK(10, 0)
>  #define AD7124_FILTER_FS(x)		FIELD_PREP(AD7124_FILTER_FS_MSK, x)
> +#define AD7124_FILTER_TYPE_MSK		GENMASK(23, 21)
> +#define AD7124_FILTER_TYPE_SEL(x)	FIELD_PREP(AD7124_FILTER_TYPE_MSK, x)
> +
> +#define AD7124_SINC3_FILTER 2
> +#define AD7124_SINC4_FILTER 0
>  
>  enum ad7124_ids {
>  	ID_AD7124_4,
> @@ -119,6 +124,7 @@ struct ad7124_channel_config {
>  	unsigned int vref_mv;
>  	unsigned int pga_bits;
>  	unsigned int odr;
> +	unsigned int filter_type;
>  };
>  
>  struct ad7124_state {
> @@ -138,7 +144,8 @@ static const struct iio_chan_spec ad7124_channel_template = {
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  		BIT(IIO_CHAN_INFO_SCALE) |
>  		BIT(IIO_CHAN_INFO_OFFSET) |
> -		BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
>  	.scan_type = {
>  		.sign = 'u',
>  		.realbits = 24,
> @@ -281,6 +288,58 @@ static int ad7124_set_channel_gain(struct ad7124_state *st,
>  	return 0;
>  }
>  
> +static int ad7124_get_3db_filter_freq(struct ad7124_state *st,
> +				      unsigned int channel)
> +{
> +	unsigned int fadc;
> +
> +	fadc = st->channel_config[channel].odr;
> +
> +	switch (st->channel_config[channel].filter_type) {
> +	case AD7124_SINC3_FILTER:
> +		return DIV_ROUND_CLOSEST(fadc * 230, 1000);
> +	case AD7124_SINC4_FILTER:
> +		return DIV_ROUND_CLOSEST(fadc * 262, 1000);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad7124_set_3db_filter_freq(struct ad7124_state *st,
> +				      unsigned int channel,
> +				      unsigned int freq)
> +{
> +	unsigned int sinc4_3db_odr;
> +	unsigned int sinc3_3db_odr;
> +	unsigned int new_filter;
> +	unsigned int new_odr;
> +
> +	sinc4_3db_odr = DIV_ROUND_CLOSEST(freq * 1000, 230);
> +	sinc3_3db_odr = DIV_ROUND_CLOSEST(freq * 1000, 262);
> +
> +	if (sinc4_3db_odr > sinc3_3db_odr) {
> +		new_filter = AD7124_SINC3_FILTER;
> +		new_odr = sinc4_3db_odr;
> +	} else {
> +		new_filter = AD7124_SINC4_FILTER;
> +		new_odr = sinc3_3db_odr;
> +	}
> +
> +	if (st->channel_config[channel].filter_type != new_filter) {
> +		int ret;
> +
> +		st->channel_config[channel].filter_type = new_filter;
> +		ret = ad7124_spi_write_mask(st, AD7124_FILTER(channel),
> +					    AD7124_FILTER_TYPE_MSK,
> +					    AD7124_FILTER_TYPE_SEL(new_filter),
> +					    3);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return ad7124_set_channel_odr(st, channel, new_odr);
> +}
> +
>  static int ad7124_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan,
>  			   int *val, int *val2, long info)
> @@ -322,6 +381,9 @@ static int ad7124_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		*val = st->channel_config[chan->address].odr;
>  
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		*val = ad7124_get_3db_filter_freq(st, chan->scan_index);
>  		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
> @@ -355,6 +417,11 @@ static int ad7124_write_raw(struct iio_dev *indio_dev,
>  		gain = DIV_ROUND_CLOSEST(res, val2);
>  
>  		return ad7124_set_channel_gain(st, chan->address, gain);
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		if (val2 != 0)
> +			return -EINVAL;
> +
> +		return ad7124_set_3db_filter_freq(st, chan->address, val);
>  	default:
>  		return -EINVAL;
>  	}

