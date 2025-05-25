Return-Path: <linux-iio+bounces-19866-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5994CAC3406
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 12:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE102189367E
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 10:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106141EFFA6;
	Sun, 25 May 2025 10:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDNfP4Ua"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE25F135A53;
	Sun, 25 May 2025 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748170654; cv=none; b=SXAy83cRzFW1CkRB8scHufMaOKDzTG8HR+60W0A8efQyn24+cHYNS0IjE2hR5jNmv5CY0Sbgy3dXJZouEephjblSDhBOfuq0iGMy591Gunwts9O+4Rcc/m5Zxk37FmphSZlK22H26n63VDCeDTZgn37GZXvA+Yf5rIVku8Jr+gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748170654; c=relaxed/simple;
	bh=0OYO6u/Jddg+2dKnEuoJSWHziDqIsrHImj0ZLh6ZKdA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m6Rm5NvGK1QMrQcIzLvdD0a/NVhnqmgns0GEie89SmydX9pbJY3ln6xtjDkNxjUqWFrpAYrDtyX4Lar3nq6eNMUqobPYkEntnpOx9u+uUFf4xTCQas/rROPIqKrxypm/oHm/gjIUIF+Tk00AWy+oGHZAWKuLliuYiDxvN/VX164=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDNfP4Ua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EEFC4CEEA;
	Sun, 25 May 2025 10:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748170654;
	bh=0OYO6u/Jddg+2dKnEuoJSWHziDqIsrHImj0ZLh6ZKdA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kDNfP4Ua+DhV12BoH+I/PzMHZFqae9ppum/TZGCyFOTdUlHgvx/P80ko4wVGPJDcC
	 q+af2Vc4ebH3/E63ZhbCbyGaF2oLhSYLBXNCjdcVV2g9g8lW+iumptiDeTVqHgTS/p
	 dTN9d+RG8Dug9XO1V1btzqDiNx97UoHpro8b+xMZBSeWDSO+nFfykFQRJCJ4k9poE+
	 zwfFjsaJI/BI5Rv8FPN6Yb59Bt6sP3FtIXOfmAqIZEbfoGS2gFl19PeJiUEiHs/ZpQ
	 Hz2MtCiLfOF3NPYE+Q7945e8+/5VmL4JOqcx7iCBHpV/IQ3l1Y/ztRGB5S20XTU7zg
	 YI4/bpIlQBB3Q==
Date: Sun, 25 May 2025 11:57:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>,
 <nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linus.walleij@linaro.org>,
 <brgl@bgdev.pl>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v3 10/10] iio: adc: ad4170: Add support for weigh scale
 and RTD sensors
Message-ID: <20250525115723.7b05b8ad@jic23-huawei>
In-Reply-To: <c6d82e15c2b638ab40e7c8ef68b3bef959ce2946.1747083143.git.marcelo.schmitt@analog.com>
References: <cover.1747083143.git.marcelo.schmitt@analog.com>
	<c6d82e15c2b638ab40e7c8ef68b3bef959ce2946.1747083143.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 May 2025 09:36:47 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> The AD4170 design has features to aid interfacing with weigh scale and RTD
> sensors that are expected to be setup with external circuitry for proper
> sensor operation. A key characteristic of those sensors is that the circuit
> they are in must be excited with a pair of signals. The external circuit
> can be excited either by voltage supply or by AD4170 excitation signals.
> The sensor can then be read through a different pair of lines that are
> connected to AD4170 ADC.
> 
> Configure AD4170 to handle external circuit sensors.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

A few comments inline.  In general this is in a good shape subject
to us figuring out the right dt-binding.

Jonathan


> +
> +static int ad4170_setup_bridge(struct ad4170_state *st,
> +			       struct fwnode_handle *child,
> +			       struct ad4170_setup *setup, u32 *exc_pins,
> +			       int num_exc_pins, int exc_cur, bool ac_excited)
> +{
> +	unsigned long gpio_mask;
> +	int ret;
> +
> +	/*
> +	 * If a specific current is provided through
> +	 * adi,excitation-current-microamp, set excitation pins provided through
> +	 * adi,excitation-pins to excite the bridge circuit.
> +	 */
> +	if (exc_cur > 0)
> +		return ad4170_setup_current_src(st, child, setup, exc_pins,
> +						num_exc_pins, exc_cur,
> +						ac_excited);
> +
> +	/*
> +	 * Else, use predefined ACX1, ACX1 negated, ACX2, ACX2 negated signals
> +	 * to AC excite the bridge. Those signals are output on GPIO2, GPIO0,
> +	 * GPIO3, and GPIO1, respectively. If only two pins are specified for AC
> +	 * excitation, use ACX1 and ACX2 (GPIO2 and GPIO3).
> +	 *
> +	 * Also, to avoid any short-circuit condition when more than one channel
> +	 * is enabled, set GPIO2 and GPIO0 high, and set GPIO1 and GPIO3 low to
> +	 * DC excite the bridge whenever a channel without AC excitation is
> +	 * selected. That is needed because GPIO pins are controlled by the next
> +	 * highest priority GPIO function when a channel doesn't enable AC
> +	 * excitation. See datasheet Figure 113 Weigh Scale (AC Excitation) for
> +	 * an example circuit diagram.
> +	 */
> +	if (num_exc_pins == 2) {
> +		setup->misc |= FIELD_PREP(AD4170_MISC_CHOP_ADC_MSK, 0x3);
> +
> +		gpio_mask = AD4170_GPIO_MODE_GPIO3_MSK | AD4170_GPIO_MODE_GPIO2_MSK;
> +		ret = regmap_update_bits(st->regmap, AD4170_GPIO_MODE_REG, gpio_mask,
> +					 AD4170_GPIO_MODE_GPIO_OUTPUT << (2 * 3) |
> +					 AD4170_GPIO_MODE_GPIO_OUTPUT << (2 * 2));

Can we find a way to document relevance of 2 and 3 here?  Ideally

appropriate defines or similar.  Feels like a FIELD_PREP is appropriate.


> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_set_bits(st->regmap,
> +				      AD4170_GPIO_OUTPUT_REG,
> +				      BIT(3) | BIT(2));

These are also cryptic.  Probably some FIELD_PREP() here as well.

> +		if (ret)
> +			return ret;
> +
> +		st->gpio_fn[3] |= AD4170_GPIO_OUTPUT;
> +		st->gpio_fn[2] |= AD4170_GPIO_OUTPUT;
> +	} else {
> +		setup->misc |= FIELD_PREP(AD4170_MISC_CHOP_ADC_MSK, 0x2);
> +
> +		gpio_mask = AD4170_GPIO_MODE_GPIO3_MSK | AD4170_GPIO_MODE_GPIO2_MSK |
> +			    AD4170_GPIO_MODE_GPIO1_MSK | AD4170_GPIO_MODE_GPIO0_MSK;
> +		ret = regmap_update_bits(st->regmap, AD4170_GPIO_MODE_REG, gpio_mask,
> +					 AD4170_GPIO_MODE_GPIO_OUTPUT << (2 * 3) |
> +					 AD4170_GPIO_MODE_GPIO_OUTPUT << (2 * 2) |
> +					 AD4170_GPIO_MODE_GPIO_OUTPUT << (2 * 1) |
> +					 AD4170_GPIO_MODE_GPIO_OUTPUT << (2 * 0));

As above. FIELD_PREP()

> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_set_bits(st->regmap,
> +				      AD4170_GPIO_OUTPUT_REG,
> +				      BIT(3) | BIT(2) | BIT(1) | BIT(0));
> +		if (ret)
> +			return ret;
> +
> +		st->gpio_fn[3] |= AD4170_GPIO_OUTPUT;
> +		st->gpio_fn[2] |= AD4170_GPIO_OUTPUT;
> +		st->gpio_fn[1] |= AD4170_GPIO_OUTPUT;
> +		st->gpio_fn[0] |= AD4170_GPIO_OUTPUT;
> +	}
> +
> +	return 0;
> +}

> +
> +static int ad4170_parse_external_sensor(struct ad4170_state *st,
> +					struct fwnode_handle *child,
> +					struct ad4170_setup *setup,
> +					struct iio_chan_spec *chan, u8 s_type)
> +{
> +	unsigned int num_exc_pins, exc_cur, reg_val;
> +	struct device *dev = &st->spi->dev;
> +	u32 pins[2], exc_pins[4];
> +	bool ac_excited, vbias;
> +	unsigned int i;
> +	int ret;
> +
> +	ret = fwnode_property_read_u32_array(child, "diff-channels", pins,
> +					     ARRAY_SIZE(pins));
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to read sensor diff-channels\n");
> +
> +	chan->differential = true;
> +	chan->channel = pins[0];
> +	chan->channel2 = pins[1];
> +
> +	ac_excited = fwnode_property_read_bool(child, "adi,excitation-ac");
> +
> +	num_exc_pins = fwnode_property_count_u32(child, "adi,excitation-pins");
> +	if (num_exc_pins != 1 && num_exc_pins != 2 && num_exc_pins != 4)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Invalid number of excitation pins\n");
> +
> +	ret = fwnode_property_read_u32_array(child, "adi,excitation-pins",
> +					     exc_pins, num_exc_pins);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to read adi,excitation-pins\n");
> +
> +	ret = ad4170_validate_excitation_pins(st, exc_pins, num_exc_pins);
> +	if (ret)
> +		return ret;
> +
> +	exc_cur = 0;
> +	ret = fwnode_property_read_u32(child, "adi,excitation-current-microamp",
> +				       &exc_cur);
> +	if (ret && s_type == AD4170_RTD_SENSOR)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to read adi,excitation-current-microamp\n");
> +
> +	for (i = 0; i < ARRAY_SIZE(ad4170_iout_current_ua_tbl); i++)
> +		if (ad4170_iout_current_ua_tbl[i] == exc_cur)
> +			break;
> +
> +	if (i == ARRAY_SIZE(ad4170_iout_current_ua_tbl))
> +		return dev_err_probe(dev, ret,
> +				     "Invalid excitation current: %uuA\n",
> +				     exc_cur);
> +
> +	/* Get the excitation current configuration value */
> +	exc_cur = ret;
> +
> +	if (s_type == AD4170_THERMOCOUPLE_SENSOR) {
> +		vbias = fwnode_property_read_bool(child, "adi,vbias");
> +		if (vbias) {
> +			st->pins_fn[chan->channel2] |= AD4170_PIN_VBIAS;
> +			reg_val = BIT(chan->channel2);
> +			return regmap_write(st->regmap, AD4170_V_BIAS_REG,
> +					    reg_val);
> +		}
> +	}
> +	if (s_type == AD4170_WEIGH_SCALE_SENSOR) {
> +		ret = ad4170_setup_bridge(st, child, setup, exc_pins,
> +					  num_exc_pins, exc_cur, ac_excited);

No {} needed as both single statements.


> +	} else {
> +		ret = ad4170_setup_rtd(st, child, setup, exc_pins, num_exc_pins,
> +				       exc_cur, ac_excited);
> +	}
> +	return ret;
> +}
> +
>  static int ad4170_parse_reference(struct ad4170_state *st,
>  				  struct fwnode_handle *child,
>  				  struct ad4170_setup *setup)
> @@ -1849,6 +2231,7 @@ static int ad4170_parse_channel_node(struct iio_dev *indio_dev,
>  	struct ad4170_state *st = iio_priv(indio_dev);
>  	struct device *dev = &st->spi->dev;
>  	struct ad4170_chan_info *chan_info;
> +	u8 s_type = AD4170_ADC_SENSOR;
>  	struct ad4170_setup *setup;
>  	struct iio_chan_spec *chan;
>  	unsigned int ch_reg;
> @@ -1880,10 +2263,32 @@ static int ad4170_parse_channel_node(struct iio_dev *indio_dev,
>  	if (ret)
>  		return ret;
>  
> -	ret = ad4170_parse_adc_channel_type(dev, child, chan);
> -	if (ret < 0)
> -		return ret;
> +	ret = fwnode_property_read_u8(child, "adi,sensor-type", &s_type);
use same pattern for handling defaults as I suggested in earlier patches.

	s_type = ADI4170_ADC_SESNOR;
	fwnode_property_read_u8(child, "adi,sensor-type", &s_type);
	if (s_type > ...

> +	if (!ret) {
> +		if (s_type > AD4170_THERMOCOUPLE_SENSOR)
> +			return dev_err_probe(dev, ret,
> +					     "Invalid adi,sensor-type: %u\n",
> +					     s_type);
> +	}
> +	switch (s_type) {
> +	case AD4170_ADC_SENSOR:
> +		ret = ad4170_parse_adc_channel_type(dev, child, chan);
> +		if (ret)
> +			return ret;
>  
> +		break;
> +	case AD4170_WEIGH_SCALE_SENSOR:
> +	case AD4170_THERMOCOUPLE_SENSOR:
> +	case AD4170_RTD_SENSOR:
> +		ret = ad4170_parse_external_sensor(st, child, setup, chan,
> +						   s_type);
> +		if (ret)
> +			return ret;
> +
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
>  	bipolar = fwnode_property_read_bool(child, "bipolar");
>  	setup->afe |= FIELD_PREP(AD4170_AFE_BIPOLAR_MSK, bipolar);
>  	if (bipolar)
> @@ -2087,6 +2492,12 @@ static int ad4170_parse_firmware(struct iio_dev *indio_dev)
>  	for (i = 0; i < AD4170_NUM_ANALOG_PINS; i++)
>  		st->pins_fn[i] = AD4170_PIN_UNASIGNED;M

UNASSIGNED
(obviously I missed this earlier)


>  
> +	for (i = 0; i < AD4170_NUM_GPIO_PINS; i++)
> +		st->gpio_fn[i] = AD4170_GPIO_UNASIGNED;

Same here.

> +
> +	for (i = 0; i < AD4170_NUM_CURRENT_SRC; i++)
> +		st->cur_src_pins[i] = AD4170_CURRENT_SRC_DISABLED;
> +
>  	/* On power on, device defaults to using SDO pin for data ready signal */
>  	st->int_pin_sel = AD4170_INT_PIN_SDO;
>  	ret = device_property_match_property_string(dev, "interrupt-names",


