Return-Path: <linux-iio+bounces-18071-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EC6A87807
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 08:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BC5F170552
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 06:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB1B1A9B46;
	Mon, 14 Apr 2025 06:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3ZtqbCR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5941419A9;
	Mon, 14 Apr 2025 06:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744612812; cv=none; b=YUvKyTNwG8akDmdeNvXk4qCHSjJ4SRIOUov1ncK6lmnW+iI8LszG0+ABjC7NJCxcw/s5DP4+5UyhlG3Lxyw0Zf96DM4sp2/ITP16qbnlHRj5iOsv/08H6cByHek/grAaej5IYtpzFbJ9WP6tIS7wDzX5wxLPCtWVO5zsFf4ktyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744612812; c=relaxed/simple;
	bh=kfnjKMFZ2GPzUL1rrqAciGQykUgiMOgTaenXcHSbBPU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PpTSJH4Y8d5kIneEsNASTBRzgrF0tFMEwWqDXsDTF2FCGEeb2VO1DvIrChu7Bw63RHH8qK+FX76v+6exWtnNiI+Tyb0+ZcFZRpAXKnsfeP+ebQL5eZn0XdeDO3efCr0hD0/K+R5a9FZH7t8BhXhlvXV5Z1QFOeyNJLgmZKDKt9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3ZtqbCR; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30bfc79ad97so53423711fa.1;
        Sun, 13 Apr 2025 23:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744612808; x=1745217608; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+2iNlzdgL5vxyxuYkh8EZATDAc3DMADsVOTtwIzMOrI=;
        b=c3ZtqbCRlx0Uv54la+EEk9lPsz4msoSpyQzunnXrWMcONLHltrtLHwhfDTcm7l7ZhU
         OjRjHVLFpFKkMYKgLAlKNWN63zOTyagViXX+ICpId9B0EnL7EOumS0cCwwOg8l0HEblw
         CZOTjgUiX4HoNBBVDeSslKspjjfbX8XQC1zbvdNuvMlqPQ7a6mry6rVrK5XuAfcK1wEU
         mQzEs3jsjIE/MImwA5xPOfnq4hUzo+52K9RZFhZE2lLE9qG+8nLdUSpsyejR8mrVbsjD
         c/wDWmGz5NW/SHExD+bxHl3Qsm4Aa68UXFEHYoiatW8f4/00MqJZpmu0W7CQwwiKNxZ6
         d+cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744612808; x=1745217608;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+2iNlzdgL5vxyxuYkh8EZATDAc3DMADsVOTtwIzMOrI=;
        b=v+bz3WeAhNOrxuCaopMGGbPiyanNj6VL1ovDosIYP0k76eKTU+DYDyK9sVQ3Zpsjm/
         vtj/8rrsMqhiJTWXV9TF4WBpkdhjyiz+C0Y0imf+WONXVeGpxI7fB23KpxKeJcPPo+2b
         EcUKVNTg4f4ZWj4EacXrVgH+5xWlLmR19GLJ3wYKShX1G5IaWbf0eouuuQAydZ14K4BG
         1cd2LXWG6pvkYLFPd8/PSmGk5/MCpWSsloL7Ms2uU8CJww0hR0WKzoBpf5hp+G7V/bve
         2BbOV0gK++SGMOI7HlyQZL5K3ieDnbD1IfBG668Lvf6gRa0swfwlwgOEnDt7bAPM8D8l
         VBsw==
X-Forwarded-Encrypted: i=1; AJvYcCV6+ePN/rtnJOroyCg4TiKDkft9QWSF3RDIyFzpFSxZGP2tts6gS8dEzkymGuIm2sUS877F3hPVYZRwc5y2@vger.kernel.org, AJvYcCVWTXvoEPPfHJqzNfQtcLy8zvsG2rM/gAJm5Y5WbLHu2Okp6wHRiPKqtt0Jwr9i8Lvy4wbfvSr14rdd@vger.kernel.org, AJvYcCWoinFJ0SIf6D+oLwbBHTuykIGs2LeLLCTHxtv2/LSstCLcaxC8W9SUJy7VAb7O0XasxdjyOXo3wlYu@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+/QRRBghNhF3NUpP8t0XnYmBz0Q/oIxV0YlWwPNljPThl7Ksm
	0j+gMVuYDy1z7CK8WzLZnjukCHn3jOT4TDGthtJMBF5kbmemWTMhPI2N5w==
X-Gm-Gg: ASbGncuTw/29uOmuqn4s2TGZ6aNYFgKwqTw+Z5s81jaqBKfI4a8gJ5x3amDNpezvaB7
	sacsUHguKdKpV59PYcLLASA2aeixlTHIdw7OO/SXOcC4S/rOcROs6zD8JS0DuR3dKvYHpPVAY0S
	RGfVOB6HbKPWAEyRPjCqEImPMKU9xuLzXksoH1/ZgPvu4mp2iSBGx/y2IivdioK9b5AawEKsFTR
	JvhlrsxG5E3RhYmCkL5ep+0G3225iClvFg5MjZIoQjsg9hYVHZvcP+bMUpzq1ODvnx4L+rSgE9x
	0UYEjUt+8Ovq811a/umbIqK9t7FGjF89KGiz5dBO+o5y2x1fO9Zqp+AmLnKB2+hUZ1z65ihY8/C
	FKRde8M/UZaXYXcPfzIVt9w==
X-Google-Smtp-Source: AGHT+IGizEHk2Etr2DFbJWSy2JbCLOrgaQJBOUGQZHu7DP2KAdeST9gjlwQ5wLgUqCVsV8eF9STNGA==
X-Received: by 2002:a05:6512:3f8:b0:54b:f99:776c with SMTP id 2adb3069b0e04-54cdb5ef0a0mr3848512e87.24.1744612807528;
        Sun, 13 Apr 2025 23:40:07 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d3d50260csm1044613e87.132.2025.04.13.23.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Apr 2025 23:40:05 -0700 (PDT)
Message-ID: <cb81cba4-0fa3-431a-924f-b362fd0c4638@gmail.com>
Date: Mon, 14 Apr 2025 09:40:03 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: adc: ti-adc128s052: Add lower resolution devices
 support
To: Sukrut Bellary <sbellary@baylibre.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Angelo Compagnucci <angelo.compagnucci@gmail.com>
Cc: Nishanth Menon <nm@ti.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250408132120.836461-1-sbellary@baylibre.com>
 <20250408132120.836461-3-sbellary@baylibre.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250408132120.836461-3-sbellary@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/04/2025 16:21, Sukrut Bellary wrote:
> The adcxx4s communicates with a host processor via an SPI/Microwire Bus
> interface. The device family responds with 12-bit data, of which the LSB
> bits are transmitted by the lower resolution devices as 0.
> The unavailable bits are 0 in LSB.
> Shift is calculated per resolution and used in scaling and
> raw data read.
> 
> Lets reuse the driver to support the family of devices with name
> ADC<bb><c>S<sss>, where
> * bb is the resolution in number of bits (8, 10, 12)
> * c is the number of channels (1, 2, 4, 8)
> * sss is the maximum conversion speed (021 for 200 kSPS, 051 for 500 kSPS
> and 101 for 1 MSPS)
> 
> Complete datasheets are available at TI's website here:
> https://www.ti.com/lit/gpn/adc<bb><c>s<sss>.pdf

I tried looking up:
https://www.ti.com/lit/gpn/adc102s051.pdf

> 
> Tested only with ti-adc102s051 on BegalePlay SBC.
> https://www.beagleboard.org/boards/beagleplay
> 
> Co-developed-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Sukrut Bellary <sbellary@baylibre.com>
> ---
> Changes in v3:
>          - used be16_to_cpu() for the endian conversion.
>          - used config index enum while setting up the adc128_config[]
> 
> - Link to v2:
>          https://lore.kernel.org/lkml/20231022031203.632153-1-sukrut.bellary@linux.com/
> 
> Changes in v2:
>          - Arranged of_device_id and spi_device_id in numeric order.
>          - Used enum to index into adc128_config.
>          - Reorder adc128_config in alphabetical.
>          - Include channel resolution information.
>          - Shift is calculated per resolution and used in scaling and
>          raw data read.
> 
> - Link to v1: https://lore.kernel.org/all/20220701042919.18180-1-nm@ti.com/
> ---
>   drivers/iio/adc/ti-adc128s052.c | 149 ++++++++++++++++++++++++--------
>   1 file changed, 112 insertions(+), 37 deletions(-)
> 

Hi dee Ho,

Thanks for improving this! It's always nice to be able to support more 
devices with small(ish) changes!

This looks good to me. I will take another, hopefully more in-depth look 
at the rebased version when available though.

I have just one comment for now, but it's not strictly related to this 
change. If you wish to go the extra mile, then I'd appreciated it. If 
not, then it can be re-worked later. Anyways, please, see below.

> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index a456ea78462f..d4b76fd85abd 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -7,6 +7,22 @@
>    * https://www.ti.com/lit/ds/symlink/adc128s052.pdf
>    * https://www.ti.com/lit/ds/symlink/adc122s021.pdf
>    * https://www.ti.com/lit/ds/symlink/adc124s021.pdf
> + *
> + * The adcxx4s communicates with a host processor via an SPI/Microwire Bus
> + * interface. This driver supports the whole family of devices with a name
> + * ADC<bb><c>S<sss>, where
> + * bb is the resolution in number of bits (8, 10, 12)
> + * c is the number of channels (1, 2, 4, 8)
> + * sss is the maximum conversion speed (021 for 200 kSPS, 051 for 500 kSPS
> + * and 101 for 1 MSPS)
> + *
> + * Complete datasheets are available at TI's website here:
> + *   https://www.ti.com/lit/gpn/adc<bb><c>s<sss>.pdf
> + *
> + * 8, 10, and 12 bits converters send 12-bit data with
> + * unavailable bits set to 0 in LSB.
> + * Shift is calculated per resolution and used in scaling and
> + * raw data read.
>    */
>   
>   #include <linux/err.h>
> @@ -53,7 +69,7 @@ static int adc128_adc_conversion(struct adc128 *adc, u8 channel)
>   	if (ret < 0)
>   		return ret;
>   
> -	return ((adc->buffer[0] << 8 | adc->buffer[1]) & 0xFFF);
> +	return be16_to_cpu(*((__be16 *)adc->buffer));
>   }
>   
>   static int adc128_read_raw(struct iio_dev *indio_dev,
> @@ -70,7 +86,8 @@ static int adc128_read_raw(struct iio_dev *indio_dev,
>   		if (ret < 0)
>   			return ret;
>   
> -		*val = ret;
> +		*val = (ret >> channel->scan_type.shift) &
> +			GENMASK(channel->scan_type.realbits - 1, 0);
>   		return IIO_VAL_INT;
>   
>   	case IIO_CHAN_INFO_SCALE:
> @@ -80,7 +97,7 @@ static int adc128_read_raw(struct iio_dev *indio_dev,
>   			return ret;
>   
>   		*val = ret / 1000;
> -		*val2 = 12;
> +		*val2 = channel->scan_type.realbits;
>   		return IIO_VAL_FRACTIONAL_LOG2;
>   
>   	default:
> @@ -89,24 +106,34 @@ static int adc128_read_raw(struct iio_dev *indio_dev,
>   
>   }
>   
> -#define ADC128_VOLTAGE_CHANNEL(num)	\
> -	{ \
> -		.type = IIO_VOLTAGE, \
> -		.indexed = 1, \
> -		.channel = (num), \
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> -		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) \
> +#define _ADC128_VOLTAGE_CHANNEL(num, real_bits, store_bits)		\
> +	{								\
> +		.type = IIO_VOLTAGE,					\
> +		.indexed = 1,						\
> +		.channel = (num),					\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +		.scan_index = (num),					\
> +		.scan_type = {						\
> +			.sign = 'u',					\
> +			.realbits = (real_bits),			\
> +			.storagebits = (store_bits),			\
> +			.shift = (12 - real_bits),			\
> +		},							\
>   	}
>   
> -static const struct iio_chan_spec adc128s052_channels[] = {
> -	ADC128_VOLTAGE_CHANNEL(0),
> -	ADC128_VOLTAGE_CHANNEL(1),
> -	ADC128_VOLTAGE_CHANNEL(2),
> -	ADC128_VOLTAGE_CHANNEL(3),
> -	ADC128_VOLTAGE_CHANNEL(4),
> -	ADC128_VOLTAGE_CHANNEL(5),
> -	ADC128_VOLTAGE_CHANNEL(6),
> -	ADC128_VOLTAGE_CHANNEL(7),
> +#define ADC082_VOLTAGE_CHANNEL(num) _ADC128_VOLTAGE_CHANNEL(num, 8, 16)
> +#define ADC102_VOLTAGE_CHANNEL(num) _ADC128_VOLTAGE_CHANNEL(num, 10, 16)
> +#define ADC128_VOLTAGE_CHANNEL(num) _ADC128_VOLTAGE_CHANNEL(num, 12, 16)
> +
> +static const struct iio_chan_spec adc082s021_channels[] = {
> +	ADC082_VOLTAGE_CHANNEL(0),
> +	ADC082_VOLTAGE_CHANNEL(1),
> +};
> +
> +static const struct iio_chan_spec adc102s021_channels[] = {
> +	ADC102_VOLTAGE_CHANNEL(0),
> +	ADC102_VOLTAGE_CHANNEL(1),
>   };
>   
>   static const struct iio_chan_spec adc122s021_channels[] = {
> @@ -121,10 +148,46 @@ static const struct iio_chan_spec adc124s021_channels[] = {
>   	ADC128_VOLTAGE_CHANNEL(3),
>   };
>   
> +static const struct iio_chan_spec adc128s052_channels[] = {
> +	ADC128_VOLTAGE_CHANNEL(0),
> +	ADC128_VOLTAGE_CHANNEL(1),
> +	ADC128_VOLTAGE_CHANNEL(2),
> +	ADC128_VOLTAGE_CHANNEL(3),
> +	ADC128_VOLTAGE_CHANNEL(4),
> +	ADC128_VOLTAGE_CHANNEL(5),
> +	ADC128_VOLTAGE_CHANNEL(6),
> +	ADC128_VOLTAGE_CHANNEL(7),
> +};
> +
> +enum adc128_configuration_index {
> +	ADC128_CONFIG_INDEX_082S,
> +	ADC128_CONFIG_INDEX_102S,
> +	ADC128_CONFIG_INDEX_122S,
> +	ADC128_CONFIG_INDEX_124S,
> +	ADC128_CONFIG_INDEX_128S,
> +};

I like the fact you added these indexes as it makes this a lot clearer. 
But...

> +
>   static const struct adc128_configuration adc128_config[] = {
> -	{ adc128s052_channels, ARRAY_SIZE(adc128s052_channels) },
> -	{ adc122s021_channels, ARRAY_SIZE(adc122s021_channels) },
> -	{ adc124s021_channels, ARRAY_SIZE(adc124s021_channels) },
> +	[ADC128_CONFIG_INDEX_082S] = {
> +		.channels = adc082s021_channels,
> +		.num_channels = ARRAY_SIZE(adc082s021_channels)
> +	},
> +	[ADC128_CONFIG_INDEX_102S] = {
> +		.channels = adc102s021_channels,
> +		.num_channels = ARRAY_SIZE(adc102s021_channels)
> +	},
> +	[ADC128_CONFIG_INDEX_122S] = {
> +		.channels = adc122s021_channels,
> +		.num_channels = ARRAY_SIZE(adc122s021_channels)
> +	},
> +	[ADC128_CONFIG_INDEX_124S] = {
> +		.channels = adc124s021_channels,
> +		.num_channels = ARRAY_SIZE(adc124s021_channels)
> +	},
> +	[ADC128_CONFIG_INDEX_128S] = {
> +		.channels = adc128s052_channels,
> +		.num_channels = ARRAY_SIZE(adc128s052_channels)
> +	},
>   };

... I don't really love this array. I believe the code would be clearer 
if this array was changed to individual structs because ...

>   
>   static const struct iio_info adc128_info = {
> @@ -177,31 +240,43 @@ static int adc128_probe(struct spi_device *spi)
>   }
>   
>   static const struct of_device_id adc128_of_match[] = {
> -	{ .compatible = "ti,adc128s052", .data = &adc128_config[0] },
> -	{ .compatible = "ti,adc122s021", .data = &adc128_config[1] },
> -	{ .compatible = "ti,adc122s051", .data = &adc128_config[1] },
> -	{ .compatible = "ti,adc122s101", .data = &adc128_config[1] },
> -	{ .compatible = "ti,adc124s021", .data = &adc128_config[2] },
> -	{ .compatible = "ti,adc124s051", .data = &adc128_config[2] },
> -	{ .compatible = "ti,adc124s101", .data = &adc128_config[2] },
> +	{ .compatible = "ti,adc082s021", .data = &adc128_config[ADC128_CONFIG_INDEX_082S] },
> +	{ .compatible = "ti,adc082s051", .data = &adc128_config[ADC128_CONFIG_INDEX_082S] },
> +	{ .compatible = "ti,adc082s101", .data = &adc128_config[ADC128_CONFIG_INDEX_082S] },
> +	{ .compatible = "ti,adc102s021", .data = &adc128_config[ADC128_CONFIG_INDEX_102S] },
> +	{ .compatible = "ti,adc102s051", .data = &adc128_config[ADC128_CONFIG_INDEX_102S] },
> +	{ .compatible = "ti,adc102s101", .data = &adc128_config[ADC128_CONFIG_INDEX_102S] },
> +	{ .compatible = "ti,adc122s021", .data = &adc128_config[ADC128_CONFIG_INDEX_122S] },
> +	{ .compatible = "ti,adc122s051", .data = &adc128_config[ADC128_CONFIG_INDEX_122S] },
> +	{ .compatible = "ti,adc122s101", .data = &adc128_config[ADC128_CONFIG_INDEX_122S] },
> +	{ .compatible = "ti,adc124s021", .data = &adc128_config[ADC128_CONFIG_INDEX_124S] },
> +	{ .compatible = "ti,adc124s051", .data = &adc128_config[ADC128_CONFIG_INDEX_124S] },
> +	{ .compatible = "ti,adc124s101", .data = &adc128_config[ADC128_CONFIG_INDEX_124S] },
> +	{ .compatible = "ti,adc128s052", .data = &adc128_config[ADC128_CONFIG_INDEX_128S] },

... here we could then directly refer to individual structs. That way we 
would not need to define the names for the array indexes (for clarity), 
or look up the individual array members based on magic numbers.

>   	{ /* sentinel */ },
>   };
>   MODULE_DEVICE_TABLE(of, adc128_of_match);

Yours,
	-- Matti

