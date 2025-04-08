Return-Path: <linux-iio+bounces-17839-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F589A81748
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 22:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2DE4E21DE
	for <lists+linux-iio@lfdr.de>; Tue,  8 Apr 2025 20:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFF1254867;
	Tue,  8 Apr 2025 20:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Sj/4cfnU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E0B253B65
	for <linux-iio@vger.kernel.org>; Tue,  8 Apr 2025 20:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744145858; cv=none; b=CcQTYHKA8Fan4l6FtSnj9FFQWjLV7NrDuldO4/2nCw7Ncygbz1oXdjH5wFvlJ3TTRZzYZ88a2pij2aMBNDJk3kOl6zTjuIW3sTyfa2WQ7tXxmi+FH7tGbX7ynzQHjlmu18SOq3MJIDUl0GT/2Huw3/a55/f+SDkWcGUYcpnr4gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744145858; c=relaxed/simple;
	bh=B0U8Vcv6k5qxhGHDsdzLC2/NIe+68/brTmvtgy4STLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GfrD0VttXmtg5xUcuGjTSRWwitQBgLTTC8Aja6tgNcWFogYG2HUvByXCyy1fXPeLymzqcCcCYoeC2llQJemIar+sxaTvFCvJAMfVIjLO3ks6oNjcnkFZwT+sTNEAVt4ej2oWFSYKEibFwa6DqcYO1G19RF/lDMR4jhqD6erKUwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Sj/4cfnU; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2cc57330163so3309221fac.2
        for <linux-iio@vger.kernel.org>; Tue, 08 Apr 2025 13:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744145855; x=1744750655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qaDwk/rTlVSzsAVLqKNpTmTzHrcmKNMZwL+bLzgU1Zk=;
        b=Sj/4cfnULqihiPhTRrz3Nv+H/oDTZPtC+lrlNRZ5xKJXe7W/5rB0b7MuO5aih2GSD2
         8Iczj9QWcdACZPWbDIubjlMgr8SuSSa8w3M2/VXt/TF+pVHe36TKaLlrPkJ1O98yeuLD
         miYoC9Rps5SF3HZgdnjPl97ZQYazK+Sg2g3Ka+q8govKVNKNwHhadJplz2HbIid62cJ+
         jabkTQ2BchZoo0899Xa8m45TeffJgilaJPtvHMjwS15VDcXCoFRySpDY/rwlOg+6tWFF
         Gv0HDArYoO4Uv6e2kiRedEpZzGrNpOy/aBdzdEHC1K0cg69LIhPC+tct39jY8w6ym5Qz
         dnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744145855; x=1744750655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qaDwk/rTlVSzsAVLqKNpTmTzHrcmKNMZwL+bLzgU1Zk=;
        b=bU5RO6loMlW8UYDgihqtjeaENyPvP0PAVkhWF3vA0/fBCVvSbs5x1K87LTMUmC31od
         X1imA1l7e2nzUpXx11hAKb/FM8HfOX/oGDNVWhRXmMiFRki6l9ZtU1jsxbGwzJfaPWqb
         +Ydrg/kYz9xAEjt8cLc2Jw0j6to9Jr/1YD3owToQ0zUDnR6/M7ln0CnHlTSAE6iMzxjQ
         BbgoeWzTcspc+mhh17Nv2DYnlykrXQnd98H1goCklbM190CVKWNiobXwnt7ZlZ7qjraf
         +zpCYzmfLZu7KMNVMW1rhqGRB+Z6+HQbE9kcrTZvBotbrO2DdXN753R8VZTcHEQYTYnd
         RDHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqhvEo6ORnXGY4ZlWh0iF98AsNhltfl8eOv/qy0CWDpdNPh8x7v9qf45McAe+NE1kEJ3TMnWh9nJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzyfnS7eNjPduWX7IH7/NkyqUrFqiCp2KSi0ECHoEG+eVFgTBM
	kVqR8Lj8JQaqWKP/A8aHNNz3wFlUw8nmpmEKFWYeJAuZrwt34vvN/NW6TVV2OiM=
X-Gm-Gg: ASbGnctEV/fLMPdNw/T5JZNomqkp5nG3dJ+m3t1r+bSgi9o6wUYP3YVgWUbmAYTh5af
	0E0FuE3BpGwiW8HV9dY9675PjTAvUEUjx0Yxs2Sq7eXLY4H7jmVTik/vjqrbSSsLIHGO6kagw8z
	niRH8iO6A8uBhEiBU+4lPt/Znh7xpkmWQZxV+RN2Bd3PH4i00Zcp7Ck3wYHfFlBsk6RlU6/kpBa
	2JawpiXKKcXI6jMMNG6nju0zAf6ppjsRivrY03mOrCQENZ6LrhWDMQOaBtO4g1y0xzV2KXQsl79
	dVmA0UtMOaiRQl2MJ5Dl8NjCHy1Hx1EI5ntS1489K3b+Tu9h08DvJMJVE1wDhasychXauf14o1G
	i3dooVA==
X-Google-Smtp-Source: AGHT+IFjFgG+zdclxE9RrlgDOAhQBgIkljxsFYN0IeA14TkzF0YKGa8T/thY5EwoXPtKqouGqj5skw==
X-Received: by 2002:a05:6870:9e8e:b0:2c2:2e8e:202b with SMTP id 586e51a60fabf-2d08dd8bb09mr368582fac.10.1744145855062;
        Tue, 08 Apr 2025 13:57:35 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72e6515c0b7sm582787a34.1.2025.04.08.13.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 13:57:34 -0700 (PDT)
Message-ID: <25291cca-a456-4f6c-8aac-466cd6124683@baylibre.com>
Date: Tue, 8 Apr 2025 15:57:32 -0500
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
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250408132120.836461-3-sbellary@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/8/25 8:21 AM, Sukrut Bellary wrote:
> The adcxx4s communicates with a host processor via an SPI/Microwire Bus
> interface. The device family responds with 12-bit data, of which the LSB
> bits are transmitted by the lower resolution devices as 0.
> The unavailable bits are 0 in LSB.
> Shift is calculated per resolution and used in scaling and
> raw data read.

Could improve the line wrapping in the commit message if there is a v4.

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
> 
> Tested only with ti-adc102s051 on BegalePlay SBC.
> https://www.beagleboard.org/boards/beagleplay
> 
> Co-developed-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Sukrut Bellary <sbellary@baylibre.com>
> ---

I didn't see any serious issues, just some room for more polish...

> Changes in v3: 
>         - used be16_to_cpu() for the endian conversion.
>         - used config index enum while setting up the adc128_config[]
> 
> - Link to v2: 
>         https://lore.kernel.org/lkml/20231022031203.632153-1-sukrut.bellary@linux.com/
> 
> Changes in v2:
>         - Arranged of_device_id and spi_device_id in numeric order.
>         - Used enum to index into adc128_config.
>         - Reorder adc128_config in alphabetical.
>         - Include channel resolution information.
>         - Shift is calculated per resolution and used in scaling and 
>         raw data read.
> 
> - Link to v1: https://lore.kernel.org/all/20220701042919.18180-1-nm@ti.com/
> ---
>  drivers/iio/adc/ti-adc128s052.c | 149 ++++++++++++++++++++++++--------
>  1 file changed, 112 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index a456ea78462f..d4b76fd85abd 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -7,6 +7,22 @@
>   * https://www.ti.com/lit/ds/symlink/adc128s052.pdf
>   * https://www.ti.com/lit/ds/symlink/adc122s021.pdf
>   * https://www.ti.com/lit/ds/symlink/adc124s021.pdf
> + *
> + * The adcxx4s communicates with a host processor via an SPI/Microwire Bus
> + * interface. This driver supports the whole family of devices with a name
> + * ADC<bb><c>S<sss>, where
> + * bb is the resolution in number of bits (8, 10, 12)
> + * c is the number of channels (1, 2, 4, 8)
> + * sss is the maximum conversion speed (021 for 200 kSPS, 051 for 500 kSPS
> + * and 101 for 1 MSPS)

Looks like odd line wrapping. I assume bullet points were meant here?

* ... where:
* - bb is ...
* - c is ...
* - sss is ...

> + *
> + * Complete datasheets are available at TI's website here:
> + *   https://www.ti.com/lit/gpn/adc<bb><c>s<sss>.pdf
> + *
> + * 8, 10, and 12 bits converters send 12-bit data with
> + * unavailable bits set to 0 in LSB.
> + * Shift is calculated per resolution and used in scaling and
> + * raw data read.
>   */
>  
>  #include <linux/err.h>
> @@ -53,7 +69,7 @@ static int adc128_adc_conversion(struct adc128 *adc, u8 channel)
>  	if (ret < 0)
>  		return ret;
>  
> -	return ((adc->buffer[0] << 8 | adc->buffer[1]) & 0xFFF);
> +	return be16_to_cpu(*((__be16 *)adc->buffer));
>  }
>  
>  static int adc128_read_raw(struct iio_dev *indio_dev,
> @@ -70,7 +86,8 @@ static int adc128_read_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  
> -		*val = ret;
> +		*val = (ret >> channel->scan_type.shift) &
> +			GENMASK(channel->scan_type.realbits - 1, 0);

It's a bit odd to do this here instead of in the helper function since
the helper function is doing some rearranging of bits already.

Could pass scan_type to the helper function and do it all in one
place.

>  		return IIO_VAL_INT;
>  
>  	case IIO_CHAN_INFO_SCALE:
> @@ -80,7 +97,7 @@ static int adc128_read_raw(struct iio_dev *indio_dev,
>  			return ret;
>  
>  		*val = ret / 1000;
> -		*val2 = 12;
> +		*val2 = channel->scan_type.realbits;
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  
>  	default:
> @@ -89,24 +106,34 @@ static int adc128_read_raw(struct iio_dev *indio_dev,
>  
>  }
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

It looks like storagebits is always 16, so we could drop that parameter.

> +			.shift = (12 - real_bits),			\
> +		},							\
>  	}
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
>  };
>  
>  static const struct iio_chan_spec adc122s021_channels[] = {
> @@ -121,10 +148,46 @@ static const struct iio_chan_spec adc124s021_channels[] = {
>  	ADC128_VOLTAGE_CHANNEL(3),
>  };
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
> +
>  static const struct adc128_configuration adc128_config[] = {

I would have rather removed the array here. Adding the enum just
makes lots more code to read without any technical benefit.

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
>  };

I.e. instead:

static const struct adc128_configuration adc08s021_config = {
	.channels = adc082s021_channels,
	.num_channels = ARRAY_SIZE(adc082s021_channels),
};

static const struct adc128_configuration adc10s021_config = {
	.channels = adc102s021_channels,
	.num_channels = ARRAY_SIZE(adc102s021_channels)
};

...

>  
>  static const struct iio_info adc128_info = {
> @@ -177,31 +240,43 @@ static int adc128_probe(struct spi_device *spi)
>  }
>  
>  static const struct of_device_id adc128_of_match[] = {
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
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, adc128_of_match);

It would be easier to see what is new and what is changed if we split out the
"cleanup" to a separate patch.

>  
>  static const struct spi_device_id adc128_id[] = {
> -	{ "adc128s052", (kernel_ulong_t)&adc128_config[0] },
> -	{ "adc122s021",	(kernel_ulong_t)&adc128_config[1] },
> -	{ "adc122s051",	(kernel_ulong_t)&adc128_config[1] },
> -	{ "adc122s101",	(kernel_ulong_t)&adc128_config[1] },
> -	{ "adc124s021", (kernel_ulong_t)&adc128_config[2] },
> -	{ "adc124s051", (kernel_ulong_t)&adc128_config[2] },
> -	{ "adc124s101", (kernel_ulong_t)&adc128_config[2] },
> +	{ "adc082s021", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_082S] },
> +	{ "adc082s051", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_082S] },
> +	{ "adc082s101", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_082S] },
> +	{ "adc102s021", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_102S] },
> +	{ "adc102s051", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_102S] },
> +	{ "adc102s101", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_102S] },
> +	{ "adc122s021",	(kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_122S] },
> +	{ "adc122s051",	(kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_122S] },
> +	{ "adc122s101",	(kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_122S] },
> +	{ "adc124s021", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_124S] },
> +	{ "adc124s051", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_124S] },
> +	{ "adc124s101", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_124S] },
> +	{ "adc128s052", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_128S] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, adc128_id);
>  
>  static const struct acpi_device_id adc128_acpi_match[] = {
> -	{ "AANT1280", (kernel_ulong_t)&adc128_config[2] },
> +	{ "AANT1280", (kernel_ulong_t)&adc128_config[ADC128_CONFIG_INDEX_124S] },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, adc128_acpi_match);


