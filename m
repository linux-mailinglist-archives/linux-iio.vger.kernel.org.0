Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2228B311E79
	for <lists+linux-iio@lfdr.de>; Sat,  6 Feb 2021 16:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhBFPhY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Feb 2021 10:37:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:50172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229683AbhBFPhW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Feb 2021 10:37:22 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D12C64E4A;
        Sat,  6 Feb 2021 15:36:39 +0000 (UTC)
Date:   Sat, 6 Feb 2021 15:36:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] iio: adc: ad7124: allow 16 channels
Message-ID: <20210206153635.3f8884ad@archlinux>
In-Reply-To: <20210204113551.68744-2-alexandru.tachici@analog.com>
References: <20210204113551.68744-1-alexandru.tachici@analog.com>
        <20210204113551.68744-2-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 4 Feb 2021 13:35:50 +0200
<alexandru.tachici@analog.com> wrote:

> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> AD7124-8 can have up to 16 pseudo-differential channels
> enabled simultaneously and only 8 configurations. In this
> scenario we cannot assign one configuration per channel,
> some channels will have to share configurations like, ODR,
> gain and filter parameters.
> 
> This patch allows the user to specify channels and configurations
> separately in device-tree and assign, if needed, the same
> configuration to multiple channels.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
A couple of minor comments, but the big question is whether this is a
good approach to take in general - discussion on that in reply
to the cover letter.

Jonathan

> ---
>  drivers/iio/adc/ad7124.c | 183 +++++++++++++++++++++++----------------
>  1 file changed, 109 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 766c73333604..0df88bea336f 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -86,6 +86,12 @@
>  #define AD7124_SINC3_FILTER 2
>  #define AD7124_SINC4_FILTER 0
>  
> +#define AD7124_CONF_ADDR_OFFSET	20
> +#define AD7124_MAX_CONFIGS	8
> +#define AD7124_MAX_CHANNELS	16
> +
> +#define AD7124_REG_NO 57

What's this for?

> +
>  enum ad7124_ids {
>  	ID_AD7124_4,
>  	ID_AD7124_8,
> @@ -136,21 +142,28 @@ struct ad7124_chip_info {
>  };
>  
>  struct ad7124_channel_config {
> +	bool enable;
> +	unsigned int nr;
>  	enum ad7124_ref_sel refsel;
>  	bool bipolar;
>  	bool buf_positive;
>  	bool buf_negative;
> -	unsigned int ain;
>  	unsigned int vref_mv;
>  	unsigned int pga_bits;
>  	unsigned int odr;
>  	unsigned int filter_type;
>  };
>  
> +struct ad7124_channel {
> +	struct ad7124_channel_config *cfg;
> +	unsigned int ain;
> +};
> +
>  struct ad7124_state {
>  	const struct ad7124_chip_info *chip_info;
>  	struct ad_sigma_delta sd;
> -	struct ad7124_channel_config *channel_config;
> +	struct ad7124_channel channels[AD7124_MAX_CHANNELS];
> +	struct ad7124_channel_config configs[AD7124_MAX_CONFIGS];
>  	struct regulator *vref[4];
>  	struct clk *mclk;
>  	unsigned int adc_control;
> @@ -243,8 +256,8 @@ static int ad7124_set_channel(struct ad_sigma_delta *sd, unsigned int channel)
>  	struct ad7124_state *st = container_of(sd, struct ad7124_state, sd);
>  	unsigned int val;
>  
> -	val = st->channel_config[channel].ain | AD7124_CHANNEL_EN(1) |
> -	      AD7124_CHANNEL_SETUP(channel);
> +	val = st->channels[channel].ain | AD7124_CHANNEL_EN(1) |
> +	      AD7124_CHANNEL_SETUP(st->channels[channel].cfg->nr);
>  
>  	return ad_sd_write_reg(&st->sd, AD7124_CHANNEL(channel), 2, val);
>  }
> @@ -280,14 +293,13 @@ static int ad7124_set_channel_odr(struct ad7124_state *st,
>  	else if (odr_sel_bits > 2047)
>  		odr_sel_bits = 2047;
>  
> -	ret = ad7124_spi_write_mask(st, AD7124_FILTER(channel),
> +	ret = ad7124_spi_write_mask(st, AD7124_FILTER(st->channels[channel].cfg->nr),
>  				    AD7124_FILTER_FS_MSK,
>  				    AD7124_FILTER_FS(odr_sel_bits), 3);
>  	if (ret < 0)
>  		return ret;
>  	/* fADC = fCLK / (FS[10:0] x 32) */
> -	st->channel_config[channel].odr =
> -		DIV_ROUND_CLOSEST(fclk, odr_sel_bits * 32);
> +	st->channels[channel].cfg->odr = DIV_ROUND_CLOSEST(fclk, odr_sel_bits * 32);
>  
>  	return 0;
>  }
> @@ -301,13 +313,13 @@ static int ad7124_set_channel_gain(struct ad7124_state *st,
>  
>  	res = ad7124_find_closest_match(ad7124_gain,
>  					ARRAY_SIZE(ad7124_gain), gain);
> -	ret = ad7124_spi_write_mask(st, AD7124_CONFIG(channel),
> +	ret = ad7124_spi_write_mask(st, AD7124_CONFIG(st->channels[channel].cfg->nr),
>  				    AD7124_CONFIG_PGA_MSK,
>  				    AD7124_CONFIG_PGA(res), 2);
>  	if (ret < 0)
>  		return ret;
>  
> -	st->channel_config[channel].pga_bits = res;
> +	st->channels[channel].cfg->pga_bits = res;
>  
>  	return 0;
>  }
> @@ -317,9 +329,9 @@ static int ad7124_get_3db_filter_freq(struct ad7124_state *st,
>  {
>  	unsigned int fadc;
>  
> -	fadc = st->channel_config[channel].odr;
> +	fadc = st->channels[channel].cfg->odr;
>  
> -	switch (st->channel_config[channel].filter_type) {
> +	switch (st->channels[channel].cfg->filter_type) {
>  	case AD7124_SINC3_FILTER:
>  		return DIV_ROUND_CLOSEST(fadc * 230, 1000);
>  	case AD7124_SINC4_FILTER:
> @@ -349,11 +361,11 @@ static int ad7124_set_3db_filter_freq(struct ad7124_state *st,
>  		new_odr = sinc3_3db_odr;
>  	}
>  
> -	if (st->channel_config[channel].filter_type != new_filter) {
> +	if (st->channels[channel].cfg->filter_type != new_filter) {
>  		int ret;
>  
> -		st->channel_config[channel].filter_type = new_filter;
> -		ret = ad7124_spi_write_mask(st, AD7124_FILTER(channel),
> +		st->channels[channel].cfg->filter_type = new_filter;
> +		ret = ad7124_spi_write_mask(st, AD7124_FILTER(st->channels[channel].cfg->nr),
>  					    AD7124_FILTER_TYPE_MSK,
>  					    AD7124_FILTER_TYPE_SEL(new_filter),
>  					    3);
> @@ -380,30 +392,30 @@ static int ad7124_read_raw(struct iio_dev *indio_dev,
>  		/* After the conversion is performed, disable the channel */
>  		ret = ad_sd_write_reg(&st->sd,
>  				      AD7124_CHANNEL(chan->address), 2,
> -				      st->channel_config[chan->address].ain |
> +				      st->channels[chan->address].ain |
>  				      AD7124_CHANNEL_EN(0));
>  		if (ret < 0)
>  			return ret;
>  
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		idx = st->channel_config[chan->address].pga_bits;
> -		*val = st->channel_config[chan->address].vref_mv;
> -		if (st->channel_config[chan->address].bipolar)
> +		idx = st->channels[chan->address].cfg->pga_bits;
> +		*val = st->channels[chan->address].cfg->vref_mv;
> +		if (st->channels[chan->address].cfg->bipolar)
>  			*val2 = chan->scan_type.realbits - 1 + idx;
>  		else
>  			*val2 = chan->scan_type.realbits + idx;
>  
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  	case IIO_CHAN_INFO_OFFSET:
> -		if (st->channel_config[chan->address].bipolar)
> +		if (st->channels[chan->address].cfg->bipolar)
>  			*val = -(1 << (chan->scan_type.realbits - 1));
>  		else
>  			*val = 0;
>  
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		*val = st->channel_config[chan->address].odr;
> +		*val = st->channels[chan->address].cfg->odr;
>  
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> @@ -431,12 +443,12 @@ static int ad7124_write_raw(struct iio_dev *indio_dev,
>  		if (val != 0)
>  			return -EINVAL;
>  
> -		if (st->channel_config[chan->address].bipolar)
> +		if (st->channels[chan->address].cfg->bipolar)
>  			full_scale = 1 << (chan->scan_type.realbits - 1);
>  		else
>  			full_scale = 1 << chan->scan_type.realbits;
>  
> -		vref = st->channel_config[chan->address].vref_mv * 1000000LL;
> +		vref = st->channels[chan->address].cfg->vref_mv * 1000000LL;
>  		res = DIV_ROUND_CLOSEST(vref, full_scale);
>  		gain = DIV_ROUND_CLOSEST(res, val2);
>  
> @@ -550,7 +562,7 @@ static int ad7124_check_chip_id(struct ad7124_state *st)
>  static int ad7124_init_channel_vref(struct ad7124_state *st,
>  				    unsigned int channel_number)
>  {
> -	unsigned int refsel = st->channel_config[channel_number].refsel;
> +	unsigned int refsel = st->channels[channel_number].cfg->refsel;
>  
>  	switch (refsel) {
>  	case AD7124_REFIN1:
> @@ -562,13 +574,13 @@ static int ad7124_init_channel_vref(struct ad7124_state *st,
>  				ad7124_ref_names[refsel]);
>  			return PTR_ERR(st->vref[refsel]);
>  		}
> -		st->channel_config[channel_number].vref_mv =
> +		st->channels[channel_number].cfg->vref_mv =
>  			regulator_get_voltage(st->vref[refsel]);
>  		/* Conversion from uV to mV */
> -		st->channel_config[channel_number].vref_mv /= 1000;
> +		st->channels[channel_number].cfg->vref_mv /= 1000;
>  		break;
>  	case AD7124_INT_REF:
> -		st->channel_config[channel_number].vref_mv = 2500;
> +		st->channels[channel_number].cfg->vref_mv = 2500;
>  		st->adc_control &= ~AD7124_ADC_CTRL_REF_EN_MSK;
>  		st->adc_control |= AD7124_ADC_CTRL_REF_EN(1);
>  		return ad_sd_write_reg(&st->sd, AD7124_ADC_CONTROL,
> @@ -587,14 +599,40 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
>  	struct ad7124_state *st = iio_priv(indio_dev);
>  	struct device_node *child;
>  	struct iio_chan_spec *chan;
> -	struct ad7124_channel_config *chan_config;
> -	unsigned int ain[2], channel = 0, tmp;
> +	unsigned int ain[2], config_nr = 0, channel = 0, tmp;
>  	int ret;
>  
> -	st->num_channels = of_get_available_child_count(np);
> -	if (!st->num_channels) {
> -		dev_err(indio_dev->dev.parent, "no channel children\n");
> -		return -ENODEV;
> +	/* parse configuration nodes */
> +	for_each_available_child_of_node(np, child) {
> +		ret = of_property_read_u32_array(child, "diff-channels", ain, 2);

Can we do something based on the child node name rather than a field potentially
within it?

> +		if (!ret) {
> +			st->num_channels++;
> +			continue;
> +		}
> +
> +		if (ret == -EINVAL) {
> +			ret = of_property_read_u32(child, "reg", &config_nr);
> +			if (ret)
> +				goto err;
> +
> +			config_nr -= AD7124_CONF_ADDR_OFFSET;
> +			st->configs[config_nr].enable = true;
> +			st->configs[config_nr].nr = config_nr;
> +			st->configs[config_nr].bipolar = of_property_read_bool(child, "bipolar");
> +
> +			ret = of_property_read_u32(child, "adi,reference-select", &tmp);
> +			if (ret)
> +				st->configs[config_nr].refsel = AD7124_INT_REF;
> +			else
> +				st->configs[config_nr].refsel = tmp;
> +
> +			st->configs[config_nr].buf_positive =
> +				of_property_read_bool(child, "adi,buffered-positive");
> +			st->configs[config_nr].buf_negative =
> +				of_property_read_bool(child, "adi,buffered-negative");
> +		} else {
> +			goto err;
> +		}
>  	}
>  
>  	chan = devm_kcalloc(indio_dev->dev.parent, st->num_channels,
> @@ -602,46 +640,43 @@ static int ad7124_of_parse_channel_config(struct iio_dev *indio_dev,
>  	if (!chan)
>  		return -ENOMEM;
>  
> -	chan_config = devm_kcalloc(indio_dev->dev.parent, st->num_channels,
> -				   sizeof(*chan_config), GFP_KERNEL);
> -	if (!chan_config)
> -		return -ENOMEM;
> -
>  	indio_dev->channels = chan;
>  	indio_dev->num_channels = st->num_channels;
> -	st->channel_config = chan_config;
>  
> +	/* parse channel nodes */
>  	for_each_available_child_of_node(np, child) {
> -		ret = of_property_read_u32(child, "reg", &channel);
> -		if (ret)
> -			goto err;
> -
> -		ret = of_property_read_u32_array(child, "diff-channels",
> -						 ain, 2);
> -		if (ret)
> -			goto err;
> -
> -		st->channel_config[channel].ain = AD7124_CHANNEL_AINP(ain[0]) |
> -						  AD7124_CHANNEL_AINM(ain[1]);
> -		st->channel_config[channel].bipolar =
> -			of_property_read_bool(child, "bipolar");
> -
> -		ret = of_property_read_u32(child, "adi,reference-select", &tmp);
> -		if (ret)
> -			st->channel_config[channel].refsel = AD7124_INT_REF;
> -		else
> -			st->channel_config[channel].refsel = tmp;
> -
> -		st->channel_config[channel].buf_positive =
> -			of_property_read_bool(child, "adi,buffered-positive");
> -		st->channel_config[channel].buf_negative =
> -			of_property_read_bool(child, "adi,buffered-negative");
> -
> -		chan[channel] = ad7124_channel_template;
> -		chan[channel].address = channel;
> -		chan[channel].scan_index = channel;
> -		chan[channel].channel = ain[0];
> -		chan[channel].channel2 = ain[1];
> +		ret = of_property_read_u32_array(child, "diff-channels", ain, 2);
> +		if (!ret) {
> +			ret = of_property_read_u32(child, "reg", &channel);
> +			if (ret)
> +				goto err;
> +
> +			ret = of_property_read_u32_array(child, "diff-channels", ain, 2);
> +			if (ret)
> +				goto err;
> +
> +			st->channels[channel].ain = AD7124_CHANNEL_AINP(ain[0]) |
> +						    AD7124_CHANNEL_AINM(ain[1]);
> +
> +			ret = of_property_read_u32(child, "adi,configuration", &config_nr);
> +			if (ret)
> +				goto err;
> +
> +			config_nr -= AD7124_CONF_ADDR_OFFSET;
> +			if (!st->configs[config_nr].enable) {
> +				dev_err(&st->sd.spi->dev, "Configuration %u not specified in DT.\n",
> +					config_nr);
> +				return -EINVAL;
> +			}
> +
> +			st->channels[channel].cfg = &st->configs[config_nr];
> +
> +			chan[channel] = ad7124_channel_template;
> +			chan[channel].address = channel;
> +			chan[channel].scan_index = channel;
> +			chan[channel].channel = ain[0];
> +			chan[channel].channel2 = ain[1];
> +		}
>  	}
>  
>  	return 0;
> @@ -678,7 +713,7 @@ static int ad7124_setup(struct ad7124_state *st)
>  		return ret;
>  
>  	for (i = 0; i < st->num_channels; i++) {
> -		val = st->channel_config[i].ain | AD7124_CHANNEL_SETUP(i);
> +		val = st->channels[i].ain | AD7124_CHANNEL_SETUP(i);
>  		ret = ad_sd_write_reg(&st->sd, AD7124_CHANNEL(i), 2, val);
>  		if (ret < 0)
>  			return ret;
> @@ -687,13 +722,13 @@ static int ad7124_setup(struct ad7124_state *st)
>  		if (ret < 0)
>  			return ret;
>  
> -		tmp = (st->channel_config[i].buf_positive << 1)  +
> -			st->channel_config[i].buf_negative;
> +		tmp = (st->channels[i].cfg->buf_positive << 1)  +
> +			st->channels[i].cfg->buf_negative;
>  
> -		val = AD7124_CONFIG_BIPOLAR(st->channel_config[i].bipolar) |
> -		      AD7124_CONFIG_REF_SEL(st->channel_config[i].refsel) |
> +		val = AD7124_CONFIG_BIPOLAR(st->channels[i].cfg->bipolar) |
> +		      AD7124_CONFIG_REF_SEL(st->channels[i].cfg->refsel) |
>  		      AD7124_CONFIG_IN_BUFF(tmp);
> -		ret = ad_sd_write_reg(&st->sd, AD7124_CONFIG(i), 2, val);
> +		ret = ad_sd_write_reg(&st->sd, AD7124_CONFIG(st->channels[i].cfg->nr), 2, val);
>  		if (ret < 0)
>  			return ret;
>  		/*

