Return-Path: <linux-iio+bounces-5868-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 757238FD65E
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 21:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E2B51C2266E
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 19:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C6514D2B2;
	Wed,  5 Jun 2024 19:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3e4aV1ev"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FE1143C4D
	for <linux-iio@vger.kernel.org>; Wed,  5 Jun 2024 19:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717615240; cv=none; b=TVGSu0ikeu7h9iCxyzBQtGdAI4AraITWE9VuQu7XbLKZbsvVxlbWyNi5GAcBlvd8hggKQOUyYIEErjgZbihRib03bnHB/Was3D2BbeByrX6b90KLtfHnBVHZYlFD3DI0DV5RdfM8Wky2SeCZePvQkkwO3WwtgxgqOgjx2odqWo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717615240; c=relaxed/simple;
	bh=m0A8Os4JRcrEklhstPH8+Wk4gcYcCylU3uB5smFRT9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BkoP04sci+I9yhBsbaFyjv42epPk+4Yq2MpcZNgotqdMWZ3ZOqX6D1M2a9qHZrBn+9e3/K0Re6OS+auieLtrtAiGxJsMdJYyIxJhQcHluIEcI1kwSUIce6ircCB64WttQ/L/Ja8HoH9DnQpp4h1VXss03fJ4XwBSAoKTo8Ogex0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3e4aV1ev; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6f72b8db7deso62518a34.2
        for <linux-iio@vger.kernel.org>; Wed, 05 Jun 2024 12:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717615237; x=1718220037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P7yPzmFt4narA62dyrwurUrMEHdNxvKzIrZhKVkzQzM=;
        b=3e4aV1evTFTJK6XP/zgTMthReCO/s4cpimEhcYXj7QSqM67eQg8GHqducGSaIzA4SM
         XuI8rOVYq9f7mG37GuxI2F/CoqXGasPq4Jz0v0xteX+QqAWNW+lN/XKN6KgdvllALgbA
         36uqw2K1GtkCTzFMLF5aHMUqjm0GUz5VmPbtIQvOan7xeHNqSNAb8M8yLar4j0/MnrTJ
         VwLrJfNS2oqAa0/rroiVUa8PC+6PX3/OTAnTSpIBGEV7Z5eTmmQKCzBHLayjxMPYOob5
         hpBTDo2gpCQ6E0hVuFCbHjVU41ygT2dgzLJFXTiNBASIbQrAv15p11d5K+rLYRWlQ0B1
         X0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717615237; x=1718220037;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P7yPzmFt4narA62dyrwurUrMEHdNxvKzIrZhKVkzQzM=;
        b=DQfdRmPrysuIS7mmB39pjECxEfShfLO8luGfaRFGEiO62//xNEC6FvAo9W74UnDB1M
         n4DOdlNqEu/YnI1UIaxcMXJarqXhhQSwuzZ/HlHtY/7AOeCB03VQnLjI2VB6qMNJAzYV
         2/gECVi+s/Jo2h+foROtQYjLj8msFLxKWqF53AAITRiqXdvzMTf9nXVRo++nT3Us5Gr5
         eChbVCtFIdJAKGzZoiyaTlOKLgbn65APYblT+qs+UKsnSxHAsjYYAlqe5twtttDM3JyJ
         XuqvQ0cZFwO3+I3EMeiYbKkRhbABYOfNNhCDgC0O/LDL11/5fAxwElZYWfTvKrFHFEjp
         3cqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrsY63fidBdnr/RSz6CxzjcO7M4hPUd8xH6v7lvi9YcJqPw3eT/VYm/LResuBoM0zfQTgB4NOFi0XuibuxDKqIv+TiXI5ftjEp
X-Gm-Message-State: AOJu0YwjdVgvqzbnyBKJN8UplKae64KKdAoueiNYPbJwgM1gjh3tmaQx
	s+KgVqxf5RmEdXHtXLEaq68yIpRZCA7CFTLGrTweGXr66Z2SAgB8K8laTT4W2Vg=
X-Google-Smtp-Source: AGHT+IFPbUU6YKE2BszN3PiBcsStVD6lNw4Ihlq5+1ZbpZCd1hStrGgyjam9r7NUR7cSC7E+Vq7DYA==
X-Received: by 2002:a05:6871:54d:b0:24c:a8e6:34e7 with SMTP id 586e51a60fabf-251226fa10fmr4189542fac.26.1717615236881;
        Wed, 05 Jun 2024 12:20:36 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-251fc4df2fasm206501fac.32.2024.06.05.12.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 12:20:36 -0700 (PDT)
Message-ID: <80b27cb8-eb57-416e-aeeb-9975d299a30c@baylibre.com>
Date: Wed, 5 Jun 2024 14:20:35 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 9/9] iio: adc: ad7173: Add support for AD411x devices
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dumitru Ceclan <mitrutzceclan@gmail.com>
References: <20240603-ad4111-v5-0-9a9c54d9ac78@analog.com>
 <20240603-ad4111-v5-9-9a9c54d9ac78@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240603-ad4111-v5-9-9a9c54d9ac78@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/3/24 11:23 AM, Dumitru Ceclan via B4 Relay wrote:
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
> ---
>  drivers/iio/adc/ad7173.c | 328 ++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 296 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index fb18acc83f39..45784e4bd27e 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -1,8 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * AD717x family SPI ADC driver
> + * AD717x and AD411x family SPI ADC driver
>   *
>   * Supported devices:
> + *  AD4111/AD4112/AD4114/AD4115/AD4116
>   *  AD7172-2/AD7172-4/AD7173-8/AD7175-2
>   *  AD7175-8/AD7176-2/AD7177-2
>   *
> @@ -82,6 +83,11 @@
>  #define AD7175_2_ID			0x0cd0
>  #define AD7172_4_ID			0x2050
>  #define AD7173_ID			0x30d0
> +#define AD4111_ID			AD7173_ID
> +#define AD4112_ID			AD7173_ID
> +#define AD4114_ID			AD7173_ID
> +#define AD4116_ID			0x34d0
> +#define AD4115_ID			0x38d0
>  #define AD7175_8_ID			0x3cd0
>  #define AD7177_ID			0x4fd0
>  #define AD7173_ID_MASK			GENMASK(15, 4)
> @@ -112,6 +118,7 @@
>  
>  #define AD7173_GPO12_DATA(x)	BIT((x) + 0)
>  #define AD7173_GPO23_DATA(x)	BIT((x) + 4)
> +#define AD4111_GPO01_DATA(x)	BIT((x) + 6)
>  #define AD7173_GPO_DATA(x)	((x) < 2 ? AD7173_GPO12_DATA(x) : AD7173_GPO23_DATA(x))
>  
>  #define AD7173_INTERFACE_DATA_STAT	BIT(6)
> @@ -130,26 +137,52 @@
>  #define AD7173_VOLTAGE_INT_REF_uV	2500000
>  #define AD7173_TEMP_SENSIIVITY_uV_per_C	477
>  #define AD7177_ODR_START_VALUE		0x07
> +#define AD4111_SHUNT_RESISTOR_OHM	50
> +#define AD4111_DIVIDER_RATIO		10
> +#define AD4111_CURRENT_CHAN_CUTOFF	16
> +#define AD4111_VINCOM_INPUT		0X10

nit: odd to have upper-case X in 0x10

> +
> +/* pin <  num_voltage_in is a normal voltage input */
> +/* pin >= num_voltage_in_div is a voltge input without a divider */

spelling: voltage

> +#define AD4111_IS_VINCOM_MISMATCH(pin1, pin2) ((pin1) == AD4111_VINCOM_INPUT && \
> +					       (pin2) < st->info->num_voltage_in && \
> +					       (pin2) >= st->info->num_voltage_in_div)
>  
>  #define AD7173_FILTER_ODR0_MASK		GENMASK(5, 0)
>  #define AD7173_MAX_CONFIGS		8
>  
> +enum ad4111_current_channels {
> +	AD4111_CURRENT_IN0P_IN0N,
> +	AD4111_CURRENT_IN1P_IN1N,
> +	AD4111_CURRENT_IN2P_IN2N,
> +	AD4111_CURRENT_IN3P_IN3N,
> +};

Not sure this enum adds much since IN0 is 0, IN1 is 1, etc.
and it is only used as the index in the array initializer.

> +
>  struct ad7173_device_info {
>  	const unsigned int *sinc5_data_rates;
>  	unsigned int num_sinc5_data_rates;
>  	unsigned int odr_start_value;
> +	/*
> +	 * AD4116 has both inputs with a voltage divider and without.
> +	 * These inputs cannot be mixed in the channel configuration.
> +	 * Does not include the VINCOM input.
> +	 */
> +	unsigned int num_voltage_in_div;
>  	unsigned int num_channels;
>  	unsigned int num_configs;
> -	unsigned int num_inputs;
> +	unsigned int num_voltage_in;
>  	unsigned int clock;
>  	unsigned int id;
>  	char *name;
> +	bool has_current_inputs;
> +	bool has_vincom_input;
>  	bool has_temp;
>  	/* ((AVDD1 − AVSS)/5) */
>  	bool has_common_input;
>  	bool has_input_buf;
>  	bool has_int_ref;
>  	bool has_ref2;
> +	bool higher_gpio_bits;
>  	u8 num_gpios;
>  };
>  

...

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

I guess OK for now, but could be nice to have num_current_inputs in chip_info.

> +		return dev_err_probe(dev, -EINVAL,
> +			"For current channels single-channel must be <[0-3]>\n");
> +
> +	return 0;
> +}
> +
>  static int ad7173_validate_voltage_ain_inputs(struct ad7173_state *st,
>  					      unsigned int ain0, unsigned int ain1)
>  {
> @@ -944,16 +1149,31 @@ static int ad7173_validate_voltage_ain_inputs(struct ad7173_state *st,
>  	bool special_input0, special_input1;
>  
>  	special_input0 = AD7173_IS_REF_INPUT(ain0) ||
> -			(AD7173_IS_COM_INPUT(ain0) && st->info->has_common_input);
> +			(AD7173_IS_COM_INPUT(ain0) && st->info->has_common_input) ||
> +			ain0 == AD4111_VINCOM_INPUT;
>  	special_input1 = AD7173_IS_REF_INPUT(ain1) ||
> -			(AD7173_IS_COM_INPUT(ain1) && st->info->has_common_input);
> +			(AD7173_IS_COM_INPUT(ain1) && st->info->has_common_input) ||
> +			ain1 == AD4111_VINCOM_INPUT;

Do we also need to check has_vincom_input here? Otherwise out of range
check below might succeed for chips that don't have this pin.

>  
> -	if ((ain0 >= st->info->num_inputs && !special_input0) ||
> -	    (ain1 >= st->info->num_inputs && !special_input1))
> +	if (st->info->has_vincom_input)
> +		if (AD4111_IS_VINCOM_MISMATCH(ain0, ain1) ||
> +		    AD4111_IS_VINCOM_MISMATCH(ain1, ain0))
> +			return dev_err_probe(dev, -EINVAL,
> +				"VINCOM must be paired with inputs having divider.\n");
> +
> +	if ((ain0 >= st->info->num_voltage_in && !special_input0) ||
> +	    (ain1 >= st->info->num_voltage_in && !special_input1))
>  		return dev_err_probe(dev, -EINVAL,
>  				     "Input pin number out of range for pair (%d %d).\n",
>  				     ain0, ain1);
>  
> +	if (!special_input0 && !special_input1 &&
> +	    ((ain0 >= st->info->num_voltage_in_div) !=
> +	     (ain1 >= st->info->num_voltage_in_div)))
> +		return dev_err_probe(dev, -EINVAL,
> +			"Both inputs must either have a voltage divider or not have: (%d %d).\n",
> +			ain0, ain1);
> +
>  	return 0;
>  }
>  
> @@ -984,7 +1204,7 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>  	struct device *dev = indio_dev->dev.parent;
>  	struct iio_chan_spec *chan_arr, *chan;
>  	unsigned int ain[AD7173_NO_AINS_PER_CHANNEL], chan_index = 0;
> -	int ref_sel, ret, num_channels;
> +	int ref_sel, ret, is_current_chan, num_channels;
>  
>  	num_channels = device_get_child_node_count(dev);
>  
> @@ -1031,15 +1251,40 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
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

Should this just be fwnode_property_read_u32()?

> +			if (ret)
> +				return dev_err_probe(dev, ret,
> +					"Channel must define one of diff-channels or single-channel.\n");
>  
> -		ret = ad7173_validate_voltage_ain_inputs(st, ain[0], ain[1]);
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

is_current_chan is already set, so this is redundant.

> +		} else {
> +			if (!chan->differential) {
> +				ret = fwnode_property_read_u32_array(child,
> +					"common-mode-channel", ain + 1, 1);

And here fwnode_property_read_u32()?

> +				if (ret)
> +					return dev_err_probe(dev, ret,
> +						"common-mode-channel must be defined for single-ended channels.\n");
> +			}
> +			ret = ad7173_validate_voltage_ain_inputs(st, ain[0], ain[1]);
> +			if (ret)
> +				return ret;
> +			is_current_chan = false;

Same here, reduandant is_current_chan.

> +		}
>  
>  		ret = fwnode_property_match_property_string(child,
>  							    "adi,reference-select",
> @@ -1058,14 +1303,9 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>  			st->adc_mode |= AD7173_ADC_MODE_REF_EN;
>  		chan_st_priv->cfg.ref_sel = ref_sel;
>  
> -		*chan = ad7173_channel_template;
>  		chan->address = chan_index;
>  		chan->scan_index = chan_index;
>  		chan->channel = ain[0];
> -		chan->channel2 = ain[1];
> -		chan->differential = true;
> -
> -		chan_st_priv->ain = AD7173_CH_ADDRESS(ain[0], ain[1]);
>  		chan_st_priv->chan_reg = chan_index;
>  		chan_st_priv->cfg.input_buf = st->info->has_input_buf;
>  		chan_st_priv->cfg.odr = 0;
> @@ -1074,6 +1314,20 @@ static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>  		if (chan_st_priv->cfg.bipolar)
>  			chan->info_mask_separate |= BIT(IIO_CHAN_INFO_OFFSET);
>  
> +		if (is_current_chan) {
> +			chan->type = IIO_CURRENT;
> +			chan->differential = false;
> +			chan->channel2 = 0;
> +			ain[1] = FIELD_GET(AD7173_CH_SETUP_AINNEG_MASK,
> +					   ad4111_current_channel_config[ain[0]]);
> +			ain[0] = FIELD_GET(AD7173_CH_SETUP_AINPOS_MASK,
> +					   ad4111_current_channel_config[ain[0]]);

Changing the meaning of ain here makes the code harder to understand.

How about just:

	chan_st_priv->ain = ad4111_current_channel_config[ain[0]];

here and mode the chan_st_priv->ain = below inside the else?


> +		} else {
> +			chan_st_priv->cfg.input_buf = st->info->has_input_buf;
> +			chan->channel2 = ain[1];
> +		}
> +		chan_st_priv->ain = AD7173_CH_ADDRESS(ain[0], ain[1]);
> +
>  		chan_index++;
>  	}
>  	return 0;
> @@ -1200,6 +1454,11 @@ static int ad7173_probe(struct spi_device *spi)
>  }
>  
>  static const struct of_device_id ad7173_of_match[] = {
> +	{ .compatible = "ad4111",	.data = &ad4111_device_info},
> +	{ .compatible = "ad4112",	.data = &ad4112_device_info},
> +	{ .compatible = "ad4114",	.data = &ad4114_device_info},
> +	{ .compatible = "ad4115",	.data = &ad4115_device_info},
> +	{ .compatible = "ad4116",	.data = &ad4116_device_info},
>  	{ .compatible = "adi,ad7172-2", .data = &ad7172_2_device_info},
>  	{ .compatible = "adi,ad7172-4", .data = &ad7172_4_device_info},
>  	{ .compatible = "adi,ad7173-8", .data = &ad7173_8_device_info},
> @@ -1212,6 +1471,11 @@ static const struct of_device_id ad7173_of_match[] = {
>  MODULE_DEVICE_TABLE(of, ad7173_of_match);
>  
>  static const struct spi_device_id ad7173_id_table[] = {
> +	{ "ad4111",   (kernel_ulong_t)&ad4111_device_info},
> +	{ "ad4112",   (kernel_ulong_t)&ad4112_device_info},
> +	{ "ad4114",   (kernel_ulong_t)&ad4114_device_info},
> +	{ "ad4115",   (kernel_ulong_t)&ad4115_device_info},
> +	{ "ad4116",   (kernel_ulong_t)&ad4116_device_info},
>  	{ "ad7172-2", (kernel_ulong_t)&ad7172_2_device_info},
>  	{ "ad7172-4", (kernel_ulong_t)&ad7172_4_device_info},
>  	{ "ad7173-8", (kernel_ulong_t)&ad7173_8_device_info},

nit: Same as in the other patch, space before }

> @@ -1236,5 +1500,5 @@ module_spi_driver(ad7173_driver);
>  MODULE_IMPORT_NS(IIO_AD_SIGMA_DELTA);
>  MODULE_AUTHOR("Lars-Peter Clausen <lars@metafo.de>");
>  MODULE_AUTHOR("Dumitru Ceclan <dumitru.ceclan@analog.com>");
> -MODULE_DESCRIPTION("Analog Devices AD7172/AD7173/AD7175/AD7176 ADC driver");
> +MODULE_DESCRIPTION("Analog Devices AD7173 and similar ADC driver");
>  MODULE_LICENSE("GPL");
> 


