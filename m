Return-Path: <linux-iio+bounces-5587-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3838D71A7
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 21:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32611B21495
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 19:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D7915445B;
	Sat,  1 Jun 2024 19:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUZPoPkr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F957107A8;
	Sat,  1 Jun 2024 19:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717269565; cv=none; b=RpiSIEOTRloannDLg0Kserok6e6XBT/5TerwHMI7Vc/IcwezwqBOo0Pm8skKwxtBZdh9ZowcdPP5IHaw4kx+/F5oBD4tO05mjT0U6bmAD0xxRc3xbPRAmCHhPq92By7fQcP91CD/xX49cuWJhHU/wfykE0ZK2hyp4MtFob0xXb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717269565; c=relaxed/simple;
	bh=b96M1WLmy90tY8YQYgQlC7pZFCvJjG+Yyb309G5LS3M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TW/0eH69Y0n4/Wsr+kakkJ364YPU7S5Ze0DvLGGVcpnr+nXUl+BpfE3UyXdS92ISWE47iZfomwS9usUwELLGF5M5dsdcw9DnrCM4nJwQmYc2l9+ErZMMxQM7DOEkcb3EM7TZaqdCoiEDngEbOnE9urRcIHgqJ+5RVaZiOlDN/yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUZPoPkr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F58C116B1;
	Sat,  1 Jun 2024 19:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717269564;
	bh=b96M1WLmy90tY8YQYgQlC7pZFCvJjG+Yyb309G5LS3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YUZPoPkrCgk1sGamLeQ5w+dzMa99RAtPvbFPRKFFI/msw0aNZxz4uwpzaqR5gacOW
	 7d2uOXmms8VgDtl+zTt5pE+Ry9BTH4BI9L5Pnn97L6rqsiictNRdT9/2ZQ9eQrskrf
	 s2gJQb2W/xmaGtRDaqcH4ZbWRLikxPTxLEk+XztgoczgJMsnLIzoHitYtymT2Tg95L
	 zdvHHwtLH+QluwGXkmbXhKUyivF6FpmiQPmEKK8DOp45ET3SlSYliayHiZGlWZx76P
	 C944mEExymcVLTFLt3Vn6h2kc9nWXHmMWfQxtnu+xEvKJd9K47B5M7r2JWggjFZBIm
	 We+F00GvDzJMg==
Date: Sat, 1 Jun 2024 20:19:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dumitru Ceclan via B4 Relay
 <devnull+dumitru.ceclan.analog.com@kernel.org>
Cc: dumitru.ceclan@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: Re: [PATCH v4 6/6] iio: adc: ad7173: Add support for AD411x devices
Message-ID: <20240601201912.32fe3524@jic23-huawei>
In-Reply-To: <20240531-ad4111-v4-6-64607301c057@analog.com>
References: <20240531-ad4111-v4-0-64607301c057@analog.com>
	<20240531-ad4111-v4-6-64607301c057@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 May 2024 22:42:32 +0300
Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org> wrote:

> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
> 
> Add support for AD4111/AD4112/AD4114/AD4115/AD4116.
> 
> The AD411X family encompasses a series of low power, low noise, 24-bit,
> sigma-delta analog-to-digital converters that offer a versatile range of
> specifications.
> 
> This family of ADCs integrates an analog front end suitable for processing
> both fully differential and single-ended, bipolar voltage inputs
> addressing a wide array of industrial and instrumentation requirements.
> 
> - All ADCs have inputs with a precision voltage divider with a division
>   ratio of 10.
> - AD4116 has 5 low level inputs without a voltage divider.
> - AD4111 and AD4112 support current inputs (0 mA to 20 mA) using a 50ohm
>   shunt resistor.
> 
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
Hi Dumitru,

A follow on comment on the validation code.
Also there is some good docs for the sampling frequency but are they
actually related to the rest of this change?  They also raise
questions about ABI compliance that we may want to deal with as
a follow up patch.

A few other trivial things inline.

This is looking pretty good, so hopefully we'll get the last few corners
sorted in v5.

Thanks,

Jonathan


> ---
>  drivers/iio/adc/ad7173.c | 336 +++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 307 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index ed8ff8c5f343..91ff984eedf4 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -1,8 +1,9 @@

>  #define AD7173_INTERFACE_DATA_STAT	BIT(6)
> @@ -125,26 +132,46 @@
>  #define AD7173_VOLTAGE_INT_REF_uV	2500000
>  #define AD7173_TEMP_SENSIIVITY_uV_per_C	477
>  #define AD7177_ODR_START_VALUE		0x07
> +#define AD4111_SHUNT_RESISTOR_OHM	50
> +#define AD4111_DIVIDER_RATIO		10
> +#define AD411X_VCOM_INPUT		0X10

AD4111_VCOM_INPUT . Looks like one wildcard escaped an earlier edit?

> +#define AD4111_CURRENT_CHAN_CUTOFF	16
>  
> @@ -736,6 +918,21 @@ static int ad7173_write_raw(struct iio_dev *indio_dev,
>  		return ret;
>  
>  	switch (info) {
> +	/*
> +	 * This attribute sets the sampling frequency to each channel individually.

frequency for each channel?

> +	 * There are no issues for raw or buffered reads of an individual channel.
> +	 *
> +	 * When multiple channels are enabled in buffered mode, the effective
> +	 * sampling rate of a channel is lowered in correlation to the number
> +	 * of channels enabled and the sampling rate of the other channels.
> +	 *
> +	 * Example: 3 channels enabled with rates CH1:6211sps CH2,CH3:10sps
> +	 * While the reading of CH1 takes only 0.16ms, the reading of CH2 and CH3
> +	 * will take 100ms each.
> +	 *
> +	 * This will cause the reading of CH1 to be actually done once every
> +	 * 200.16ms, an effective rate of 4.99sps.

Hmm. This is a bit unfortunate as if I understand correctly that's not really what
people will expect when they configure the sampling frequency.  However I can't immediately
think of a better solution.  You could let userspace write a value that is cached
then attempt to get as near as possible as channels are enabled.

Still this looks like a documentation enhancement of existing behavior
in which case any functional change can be in a future patch.
However I don't think the docs update belongs in this patch unless
I'm missing some reason for it?

> +	 */
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		freq = val * MILLI + val2 / MILLI;
>  		for (i = st->info->odr_start_value; i < st->info->num_sinc5_data_rates - 1; i++)
> @@ -916,13 +1113,34 @@ static int ad7173_register_clk_provider(struct iio_dev *indio_dev)
>  					   &st->int_clk_hw);
>  }
>  
> +static int ad4111_validate_current_ain(struct ad7173_state *st,
> +				       const unsigned int ain[AD7173_NO_AINS_PER_CHANNEL])
> +{
> +	struct device *dev = &st->sd.spi->dev;
> +
> +	if (!st->info->has_current_inputs)
> +		return dev_err_probe(dev, -EINVAL,
> +			"Model %s does not support current channels\n",
> +			st->info->name);
> +
> +	if (ain[0] >= ARRAY_SIZE(ad4111_current_channel_config))
> +		return dev_err_probe(dev, -EINVAL,
> +			"For current channels single-channel must be <[0-3]>\n");
> +
> +	return 0;
> +}
> +
>  static int ad7173_validate_voltage_ain_inputs(struct ad7173_state *st,
>  					      const unsigned int ain[AD7173_NO_AINS_PER_CHANNEL])
>  {
Ah. So this got more complex. I'm not convinced it makes the loop worthwhile though.
>  	struct device *dev = &st->sd.spi->dev;
> +	bool ain_selects_normal_input[] = {
> +		ain[0] < st->info->num_voltage_in,
> +		ain[1] < st->info->num_voltage_in
> +	};
>  
>  	for (int i = 0; i < AD7173_NO_AINS_PER_CHANNEL; i++) {
> -		if (ain[i] < st->info->num_inputs)
> +		if (ain_selects_normal_input[i])
>  			continue;
>  
>  		if (ain[i] == AD7173_AIN_REF_POS || ain[i] == AD7173_AIN_REF_NEG)
> @@ -933,11 +1151,27 @@ static int ad7173_validate_voltage_ain_inputs(struct ad7173_state *st,
>  		    st->info->has_common_input)
>  			continue;
>  
> +		if (st->info->has_vcom_input && ain[i] == AD411X_VCOM_INPUT) {
I'd missed this earlier, but wild cares in defines often bite us.  Better
just to pick a part as who knows what other 411X devices will turn up
in future.

> +			if (ain_selects_normal_input[(i + 1) % 2] &&
> +			    ain[(i + 1) % 2] >= st->info->num_voltage_in_div)

This logic looks too complex to me.  Add a comment on what is actually being checked.
Given i is 0 or 1, looks like you are just saying to check the other value.
Maybe with it is cleaner in the unrolled version I suggested earlier
Something like.

	if (st->info->has_vcom_input) {
		if (ain0 == AD411X_VCOM_INPUT &&
		    ain1 < st->info->num_voltage_in && /* Normal input */
		    ain1 >= st->info->num_voltage_in_div) /* Not a divider */
			return dev_err_probe(...)

		if (ain1 == AD11X_VCOM_INPUT &&
		    ain0 < st->....

		
	}

> +				return dev_err_probe(dev, -EINVAL,
> +					"VCOM must be paired with inputs having divider.\n");
> +
> +			continue;
> +		}
> +
>  		return dev_err_probe(dev, -EINVAL,
>  			"Input pin number out of range for pair (%d %d).\n",
>  			ain[0], ain[1]);
>  	}
>  
> +	if ((ain_selects_normal_input[0] && ain_selects_normal_input[1]) &&
Set of brackets that don't add anything to logic in the line above.

> +	    ((ain[0] >= st->info->num_voltage_in_div) !=
> +	     (ain[1] >= st->info->num_voltage_in_div)))
> +		return dev_err_probe(dev, -EINVAL,
> +			"Both inputs must either have a voltage divider or not have: (%d %d).\n",
> +			ain[0], ain[1]);
> +
>  	return 0;
>  }
>  
> @@ -968,7 +1202,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>  	struct device *dev = indio_dev->dev.parent;
>  	struct iio_chan_spec *chan_arr, *chan;
>  	unsigned int ain[AD7173_NO_AINS_PER_CHANNEL], chan_index = 0;
> -	int ref_sel, ret, num_channels;
> +	int ref_sel, ret, is_current_chan, num_channels;
>  
>  	num_channels = device_get_child_node_count(dev);
>  
> @@ -1015,15 +1249,41 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>  
>  	device_for_each_child_node_scoped(dev, child) {
>  		chan = &chan_arr[chan_index];
> +		*chan = ad7173_channel_template;
>  		chan_st_priv = &chans_st_arr[chan_index];
>  		ret = fwnode_property_read_u32_array(child, "diff-channels",
>  						     ain, ARRAY_SIZE(ain));
> -		if (ret)
> -			return ret;
> +		if (ret) {
> +			ret = fwnode_property_read_u32_array(child, "single-channel",
> +							     ain, 1);
> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +					"Channel must define one of diff-channels or single-channel.\n");
>  
> -		ret = ad7173_validate_voltage_ain_inputs(st, ain);
> -		if (ret)
> -			return ret;
> +			is_current_chan = fwnode_property_read_bool(child, "adi,current-channel");
> +		} else {
> +			chan->differential = true;
> +		}
> +
> +		if (is_current_chan) {
> +			ret = ad4111_validate_current_ain(st, ain);
> +			if (ret)
> +				return ret;
> +			is_current_chan = true;
> +			ain[1] = 0;
Set here and overwritten below?  That is correct code, but not nice to read
as we'd expect this to maintain as single meaning throughout whereas it
changes as we go through this function.
> +		} else {
> +			if (!chan->differential) {
> +				ret = fwnode_property_read_u32_array(child,
> +					"adi,common-mode-channel", ain + 1, 1);
> +				if (ret)
> +					return dev_err_probe(dev, ret,
> +						"adi,common-mode-channel must be defined for single-ended channels.\n");
> +			}
> +			ret = ad7173_validate_voltage_ain_inputs(st, ain);
> +			if (ret)
> +				return ret;
> +			is_current_chan = false;
> +		}
>  
>  		ret = fwnode_property_match_property_string(child,
>  							    "adi,reference-select",
> @@ -1042,22 +1302,30 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>  			st->adc_mode |= AD7173_ADC_MODE_REF_EN;
>  		chan_st_priv->cfg.ref_sel = ref_sel;
>  
> -		*chan = ad7173_channel_template;
>  		chan->address = chan_index;
>  		chan->scan_index = chan_index;
>  		chan->channel = ain[0];
>  		chan->channel2 = ain[1];
> -		chan->differential = true;
> -
> -		chan_st_priv->ain = AD7173_CH_ADDRESS(ain[0], ain[1]);
>  		chan_st_priv->chan_reg = chan_index;
>  		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
>  		chan_st_priv->cfg.odr = 0;
> -
>  		chan_st_priv->cfg.bipolar = fwnode_property_read_bool(child, "bipolar");
> +

Trivial: Why the white space change?
Previously this nicely grouped the bipolar check with a use of it, now they
are separated.

>  		if (chan_st_priv->cfg.bipolar)
>  			chan->info_mask_separate |= BIT(IIO_CHAN_INFO_OFFSET);
>  
> +		if (is_current_chan) {
> +			chan->type = IIO_CURRENT;
> +			chan->differential = false;
> +			ain[1] = FIELD_GET(AD7173_CH_SETUP_AINNEG_MASK,
> +					   ad4111_current_channel_config[ain[0]]);

Above, ain[1] is set to 0 for current channels. Why do that if it is going to be
overwritten here?  I think the issue is that you needed ain[1] = 0 so
chan->channel2 = 0.  That rather implies these should not be using the same
local variable.  I think I'd either set chan->channel, and chan->channel2 up
where the ain[0]/ain[1] are set above, or use a different local variable
for what goes in them.

> +			ain[0] = FIELD_GET(AD7173_CH_SETUP_AINPOS_MASK,
> +					   ad4111_current_channel_config[ain[0]]);
> +		} else {
> +			chan_st_priv->cfg.input_buf = st->info->has_input_buf;
> +		}
> +		chan_st_priv->ain = AD7173_CH_ADDRESS(ain[0], ain[1]);
> +
>  		chan_index++;
>  	}
>  	return 0;


