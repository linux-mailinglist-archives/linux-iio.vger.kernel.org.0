Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52792918FA
	for <lists+linux-iio@lfdr.de>; Sun, 18 Aug 2019 20:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfHRSkw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Aug 2019 14:40:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbfHRSkw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Aug 2019 14:40:52 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF4A52184E;
        Sun, 18 Aug 2019 18:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566153650;
        bh=IzLuU7aLx3isK4ATez3DhfzL5FP0RFpSiuc9vgWMVOs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jasCXr/w1xGMD77jeZQgE/KEjTY/s3h7wg25+J3w0G4+5i57GsU8MXF/n8YoYSuZL
         9kw9aWhCnrY4g9z+6CGoCEE8jajMzAl/WhpNmwPBb+bQGHQ1xyGeh61S49/0RtSQT2
         rLSk8PpGSbM4MDoKZEV9J1M07I8ii2W6ZloAUXiM=
Date:   Sun, 18 Aug 2019 19:34:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <stefan.popa@analog.com>,
        <lars@metafoo.de>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH V3 1/4] staging: iio: adc: ad7192: Add
 low_pass_3db_filter_frequency
Message-ID: <20190818193450.6995d678@archlinux>
In-Reply-To: <20190814073150.4602-1-mircea.caprioru@analog.com>
References: <20190814073150.4602-1-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 14 Aug 2019 10:31:47 +0300
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> By adding this option we are able to remove the sync3 field and dt binding.
> When setting the required cutoff frequency we also determine the ADC
> configuration for chop and sync filter.
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
A few things turned up in my x86_64 test build for this one.

I've fixed them up as below and applied to the togreg branch of iio.git
and pushed out as testing for the autobuilders to see what else I missed ;)

Thanks,

Jonathan

> ---
> Changelog V2:
> - no changes here
> 
> Changelog V3:
> - no changes here
> 
>  drivers/staging/iio/adc/ad7192.c | 148 +++++++++++++++++++++++++++----
>  1 file changed, 132 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index 81ea2639c67c..d58ce08f3693 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -143,6 +143,10 @@
>  #define AD7192_EXT_FREQ_MHZ_MAX	5120000
>  #define AD7192_INT_FREQ_MHZ	4915200
>  
> +#define AD7192_NO_SYNC_FILTER	1
> +#define AD7192_SYNC3_FILTER	3
> +#define AD7192_SYNC4_FILTER	4
> +
>  /* NOTE:
>   * The AD7190/2/5 features a dual use data out ready DOUT/RDY output.
>   * In order to avoid contentions on the SPI bus, it's therefore necessary
> @@ -250,7 +254,7 @@ static int ad7192_of_clock_select(struct ad7192_state *st)
>  static int ad7192_setup(struct ad7192_state *st, struct device_node *np)
>  {
>  	struct iio_dev *indio_dev = spi_get_drvdata(st->sd.spi);
> -	bool rej60_en, sinc3_en, refin2_en, chop_en;
> +	bool rej60_en, refin2_en;
>  	bool buf_en, bipolar, burnout_curr_en;
>  	unsigned long long scale_uv;
>  	int i, ret, id;
> @@ -282,24 +286,12 @@ static int ad7192_setup(struct ad7192_state *st, struct device_node *np)
>  	if (rej60_en)
>  		st->mode |= AD7192_MODE_REJ60;
>  
> -	sinc3_en = of_property_read_bool(np, "adi,sinc3-filter-enable");
> -	if (sinc3_en)
> -		st->mode |= AD7192_MODE_SINC3;
> -
>  	refin2_en = of_property_read_bool(np, "adi,refin2-pins-enable");
>  	if (refin2_en && st->devid != ID_AD7195)
>  		st->conf |= AD7192_CONF_REFSEL;
>  
> -	chop_en = of_property_read_bool(np, "adi,chop-enable");
> -	if (chop_en) {
> -		st->conf |= AD7192_CONF_CHOP;
> -		if (sinc3_en)
> -			st->f_order = 3; /* SINC 3rd order */
> -		else
> -			st->f_order = 4; /* SINC 4th order */
> -	} else {
> -		st->f_order = 1;
> -	}
> +	st->conf &= ~AD7192_CONF_CHOP;
> +	st->f_order = AD7192_NO_SYNC_FILTER;
>  
>  	buf_en = of_property_read_bool(np, "adi,buffer-enable");
>  	if (buf_en)
> @@ -311,7 +303,7 @@ static int ad7192_setup(struct ad7192_state *st, struct device_node *np)
>  
>  	burnout_curr_en = of_property_read_bool(np,
>  						"adi,burnout-currents-enable");
> -	if (burnout_curr_en && buf_en && !chop_en) {
> +	if (burnout_curr_en && buf_en) {
>  		st->conf |= AD7192_CONF_BURN;
>  	} else if (burnout_curr_en) {
>  		dev_warn(&st->sd.spi->dev,
> @@ -409,6 +401,49 @@ static ssize_t ad7192_set(struct device *dev,
>  	return ret ? ret : len;
>  }
>  
> +static void ad7192_get_available_filter_freq(struct ad7192_state *st,
> +						    int *freq)
> +{
> +	unsigned int fadc;
> +
> +	/* Formulas for filter at page 25 of the datasheet */
> +	fadc = DIV_ROUND_CLOSEST(st->fclk,
> +				 AD7192_SYNC4_FILTER * AD7192_MODE_RATE(st->mode));
> +	freq[0] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
> +
> +	fadc = DIV_ROUND_CLOSEST(st->fclk,
> +				 AD7192_SYNC3_FILTER * AD7192_MODE_RATE(st->mode));
> +	freq[1] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
> +
> +	fadc = DIV_ROUND_CLOSEST(st->fclk, AD7192_MODE_RATE(st->mode));
> +	freq[2] = DIV_ROUND_CLOSEST(fadc * 230, 1024);
> +	freq[3] = DIV_ROUND_CLOSEST(fadc * 272, 1024);
> +}
> +
> +static int ad7192_show_filter_avail(struct device *dev,

ssize_t for a show function return type.

> +				    struct device_attribute *attr,
> +				    char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct ad7192_state *st = iio_priv(indio_dev);
> +	unsigned int freq_avail[4], i;
> +	size_t len = 0;
> +
> +	ad7192_get_available_filter_freq(st, freq_avail);
> +
> +	for (i = 0; i < ARRAY_SIZE(freq_avail); i++)
> +		len += scnprintf(buf + len, PAGE_SIZE - len,
> +				 "%d.%d ", freq_avail[i] / 1000,
> +				 freq_avail[i] % 1000);
> +
> +	buf[len - 1] = '\n';
> +
> +	return len;
> +}
> +
> +static IIO_DEVICE_ATTR(filter_low_pass_3db_frequency_available,
> +		       0444, ad7192_show_filter_avail, NULL, 0);
> +
>  static IIO_DEVICE_ATTR(bridge_switch_en, 0644,
>  		       ad7192_show_bridge_switch, ad7192_set,
>  		       AD7192_REG_GPOCON);
> @@ -418,6 +453,7 @@ static IIO_DEVICE_ATTR(ac_excitation_en, 0644,
>  		       AD7192_REG_MODE);
>  
>  static struct attribute *ad7192_attributes[] = {
> +	&iio_dev_attr_filter_low_pass_3db_frequency_available.dev_attr.attr,
>  	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
>  	&iio_dev_attr_ac_excitation_en.dev_attr.attr,
>  	NULL
> @@ -428,6 +464,7 @@ static const struct attribute_group ad7192_attribute_group = {
>  };
>  
>  static struct attribute *ad7195_attributes[] = {
> +	&iio_dev_attr_filter_low_pass_3db_frequency_available.dev_attr.attr,
>  	&iio_dev_attr_bridge_switch_en.dev_attr.attr,
>  	NULL
>  };
> @@ -441,6 +478,74 @@ static unsigned int ad7192_get_temp_scale(bool unipolar)
>  	return unipolar ? 2815 * 2 : 2815;
>  }
>  
> +static int ad7192_set_3db_filter_freq(struct ad7192_state *st,
> +				      int val, int val2)
> +{
> +	int freq_avail[4], i, ret, idx, freq;
> +	unsigned int diff_new, diff_old;
> +
At least some compilers are unable to tell idx is always intialized.

> +	diff_old = U32_MAX;
> +	freq = val * 1000 + val2;
> +
> +	ad7192_get_available_filter_freq(st, freq_avail);
> +
> +	for (i = 0; i < ARRAY_SIZE(freq_avail); i++) {
> +		diff_new = abs(freq - freq_avail[i]);
> +		if (diff_new < diff_old) {
> +			diff_old = diff_new;
> +			idx = i;
> +		}
> +	}
> +
> +	switch (idx) {
> +	case 0:
> +		st->f_order = AD7192_SYNC4_FILTER;
> +		st->mode &= ~AD7192_MODE_SINC3;
> +
> +		st->conf |= AD7192_CONF_CHOP;
> +		break;
> +	case 1:
> +		st->f_order = AD7192_SYNC3_FILTER;
> +		st->mode |= AD7192_MODE_SINC3;
> +
> +		st->conf |= AD7192_CONF_CHOP;
> +		break;
> +	case 2:
> +		st->f_order = AD7192_NO_SYNC_FILTER;
> +		st->mode &= ~AD7192_MODE_SINC3;
> +
> +		st->conf &= ~AD7192_CONF_CHOP;
> +		break;
> +	case 3:
> +		st->f_order = AD7192_NO_SYNC_FILTER;
> +		st->mode |= AD7192_MODE_SINC3;
> +
> +		st->conf &= ~AD7192_CONF_CHOP;
> +		break;
> +	}
> +
> +	ret = ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
> +	if (ret < 0)
> +		return ret;
> +
> +	return ad_sd_write_reg(&st->sd, AD7192_REG_CONF, 3, st->conf);
> +}
> +
> +static int ad7192_get_3db_filter_freq(struct ad7192_state *st)
> +{
> +	unsigned int fadc;
> +
> +	fadc = DIV_ROUND_CLOSEST(st->fclk,
> +				 st->f_order * AD7192_MODE_RATE(st->mode));
> +
> +	if (st->conf & AD7192_CONF_CHOP)
> +		return DIV_ROUND_CLOSEST(fadc * 240, 1024);
> +	if (st->mode & AD7192_MODE_SINC3)
> +		return DIV_ROUND_CLOSEST(fadc * 272, 1024);
> +	else
> +		return DIV_ROUND_CLOSEST(fadc * 230, 1024);
> +}
> +
>  static int ad7192_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan,
>  			   int *val,
> @@ -481,6 +586,10 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
>  		*val = st->fclk /
>  			(st->f_order * 1024 * AD7192_MODE_RATE(st->mode));
>  		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		*val = ad7192_get_3db_filter_freq(st);
> +		*val2 = 1000;
> +		return IIO_VAL_FRACTIONAL;
>  	}
>  
>  	return -EINVAL;
> @@ -535,6 +644,9 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
>  		st->mode |= AD7192_MODE_RATE(div);
>  		ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
>  		break;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		ret = ad7192_set_3db_filter_freq(st, val, val2 / 1000);
> +		break;
>  	default:
>  		ret = -EINVAL;
>  	}
> @@ -553,6 +665,8 @@ static int ad7192_write_raw_get_fmt(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT_PLUS_NANO;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		return IIO_VAL_INT_PLUS_MICRO;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -653,6 +767,8 @@ static int ad7192_channels_config(struct iio_dev *indio_dev)
>  
>  	for (i = 0; i < indio_dev->num_channels; i++) {
>  		*chan = channels[i];
> +		chan->info_mask_shared_by_all |=
> +			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY);
>  		if (chan->type != IIO_TEMP)
>  			chan->info_mask_shared_by_type_available |=
>  				BIT(IIO_CHAN_INFO_SCALE);

