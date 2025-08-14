Return-Path: <linux-iio+bounces-22743-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD588B26F97
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 21:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 974C15E7BE8
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 19:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B6F22541C;
	Thu, 14 Aug 2025 19:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MyHhOdAo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9677FB665
	for <linux-iio@vger.kernel.org>; Thu, 14 Aug 2025 19:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755199157; cv=none; b=udUpP3TBbEwTNVW5adRMLwYivgSbvyBxr7jIkxSzQkN6tFhd1RGarSzlqXojTFMtePoniIRKzfz1zE19YKbf3jydqerKT8aCFRqr3isDrtw5V26WBrzD3RGOaK8/lvzFVGNrvis5Crtk5er1YLRWVnWDAnqLytf+ayC4x8Ds6RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755199157; c=relaxed/simple;
	bh=/3Oi3VazqyGm0PeORCVjsiqkf6UkknyKmJJsa4Pofvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bUOnWCsNlUbhHtmXrVfQUDA5GLll6I32xOocMg9t52ZzOVrtZ7JCaZTjw+4IND+1m2qYNTds3tEEzKXucUZ7dRKmYjNwnoZM79KSvxAzKrxRsiyHSyq/pHjX4j1eaVfdYj+T1k6wgbExQVbeOiTpHPxAm8GAlgN76PYKTjvTomA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MyHhOdAo; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-61bd4e47ee4so739032eaf.3
        for <linux-iio@vger.kernel.org>; Thu, 14 Aug 2025 12:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755199154; x=1755803954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lKpvExu7aXzMVLXuKaV0X/F1bQZBD6Xg+Sr7F0G9AWM=;
        b=MyHhOdAoB+eaDGl6rvDLn7KG8fVcXIAXlPjpGbAifNBsWORNx0/eJcU3J47uO444Ui
         3tHTAz0Zs9oDB5LfbrJ3hjjx1h11db9FxGyKJ047Zu8FsLDsUdqxPXhbpHk3J+mNxshR
         mZeR2f6cG1kT4rPTGb0kJjs9I+CLkPwLJTQ+rBlTlwEOA9tX9pSKzW1rTDmqYCiFZqbK
         mX1dTQ2qHINM/OTii5N9PqQognM5PtFsmrR7Q6/27+a28stz7BbXUMjGaROjnnK3jjIl
         l/iaFrCOU+DnQ5q0ylhH/arkLjYQ3KFmJKF+nwOVocztICuBXQCpK4glsM8BEG3Mw5HB
         7YrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755199154; x=1755803954;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lKpvExu7aXzMVLXuKaV0X/F1bQZBD6Xg+Sr7F0G9AWM=;
        b=hxEm+Ik7C3JYCqX/U/03xJM8moKGXuq0u9EJPfuzjF+LTk15+jf+OsOn1wt5rrI5C5
         w2UA3zPmUy+okKTEJ7e6/BF/Eo8Zpl3sEyHxjrrOhLx7r5ESBVgySptKIKYxLZf+F5RL
         qJG8N7Yiqyx76gw3qbJ+EnWe+TiEvemtLYl/t5nLHc5U8IIjiR7DEOd4rvUpyoUvFpd4
         0SUU3qqn1gdigc340gHsM4sWTpPp3HU94wckH+auN6vmJz/d84qaQX6KYkmlzWVyq7Ja
         bk8CI8eH82/FuQ/Hr6t6x/7P9DQEDrrDtz7QKCztHg+1QsEgX/+qKlLPwwE1Av0cLNm1
         FZCg==
X-Gm-Message-State: AOJu0Ywdt6x2RIb8+TEJxSgjHjWIYR422ty4mWnHO3ufpsWKsU5nhOzo
	9J+dkQfucx1P7X5hDRi6NUonvYLhR8i8EUPZq/THyo4EoLyrNpXt/i56ZQz+WnGSDjE=
X-Gm-Gg: ASbGncsL8SWBptH5CbekZw4rTXu6BFoNst2c3GgzPnPuJu/2M7M55iVDWjuOes8SRxM
	4QIbz/qL8ozO/W4uvw9+agT+ESl5iCcNwaN4SDekagThlpUVeECoEv2T/hnLL/orft/itq4Q368
	IJxp+oIIvWS+s37UH90td5IKRZSW9pl7K8qoq5UkP4AfM6an9I7Swv01XOn3MqLlVWVw3baTKgI
	95VVQcGzPVIwNt514o4xVS0Ze5jUtqkdE3QlFIQK511/5rHSoeIGf2LWr911AaxlFyAMJ4hMevw
	8GrASkTCBwEe0OLDkAqQo/LX7ZI1dmvlWwuOYHm+pXPc7E4EmdMWpYgXaeGlLpILC2bRwDCwASf
	b8TCTZc718lbwqTYxUKgGA2+qvt1tuW3TRH8Lq9EBmkJfqk3Y4dd7CT9am7VVFLQpzVN3wdUkAw
	8=
X-Google-Smtp-Source: AGHT+IHxBlU8JZPfMMJtvM979h02jPySYJMewnbLlNqo4fjxMOlippIrgeq9IW091eL4W/Zoa+r99A==
X-Received: by 2002:a05:6808:2197:b0:433:fa92:69e9 with SMTP id 5614622812f47-435e051f643mr2916773b6e.34.1755199153544;
        Thu, 14 Aug 2025 12:19:13 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:2d9b:959c:3c59:5831? ([2600:8803:e7e4:1d00:2d9b:959c:3c59:5831])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-435ce856832sm1237911b6e.23.2025.08.14.12.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 12:19:13 -0700 (PDT)
Message-ID: <31dea455-f5c4-47a9-9ba8-6a284b12ccfe@baylibre.com>
Date: Thu, 14 Aug 2025 14:19:12 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] iio: adc: ltc2497: add temperature sensor support
To: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250814-ltc2495-v3-0-c2a6cecd6b99@gmail.com>
 <20250814-ltc2495-v3-3-c2a6cecd6b99@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250814-ltc2495-v3-3-c2a6cecd6b99@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/25 6:00 AM, Yusuf Alper Bilgin wrote:
> Support for reading the internal temperature sensor on LTC2495 and
> LTC2499 via a standard IIO temperature channel.
> 
> Signed-off-by: Yusuf Alper Bilgin <y.alperbilgin@gmail.com>
> ---
>  drivers/iio/adc/ltc2497-core.c | 141 ++++++++++++++++++++++++++++++-----------
>  drivers/iio/adc/ltc2497.c      |  28 +++++++-
>  drivers/iio/adc/ltc2497.h      |  15 +++++
>  3 files changed, 145 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
> index 2dc5c704426949a4ec62c42591d6c2c40ffb79cc..bbb7948f81933ee35103e37cb2ba94354f61b32e 100644
> --- a/drivers/iio/adc/ltc2497-core.c
> +++ b/drivers/iio/adc/ltc2497-core.c
> @@ -12,6 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/units.h>
>  
>  #include "ltc2497.h"
>  
> @@ -95,10 +96,53 @@ static int ltc2497core_read_raw(struct iio_dev *indio_dev,
>  		if (ret < 0)
>  			return ret;
>  
> -		*val = ret / 1000;
> -		*val2 = ddata->chip_info->resolution + 1;
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			*val = ret / 1000;
> +			*val2 = ddata->chip_info->resolution + 1;
> +
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +
> +		case IIO_TEMP:
> +			if (!ddata->chip_info->has_temp_channel)
> +				return -EINVAL;
> +
> +			/*
> +			 * The datasheet formula to get Temperature in Celsius is:
> +			 * Temp_C = (DATAOUT * Vref_V / temp_scale) - 273
> +			 *
> +			 * To match the IIO framework's model of (raw + offset) * scale,
> +			 * and to get the final result in millidegrees Celsius:
> +			 *
> +			 * Temp_mC = ((DATAOUT * Vref_mV / temp_scale_mV) - 273) * 1000
> +			 * Temp_mC = (DATAOUT - (273 * temp_scale_mV / Vref_mv)) * 1000 *
> +			 *           Vref_mV / temp_scale_mV
> +			 *
> +			 * This gives us:
> +			 * scale  = Vref_mV * 1000 / temp_scale_mV
> +			 * offset = -273 * temp_scale / Vref_mV
> +			 */

Probably don't need quite so much comments here. TBH, I though just the
comment in struct ltc2497_chip_info was enough.

> +			*val = ret;
> +			*val2 = ddata->chip_info->temp_scale_mV;
> +
> +			return IIO_VAL_FRACTIONAL;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (chan->type != IIO_TEMP)
> +			return -EINVAL;
> +
> +		/* see the calculation above. Offset with (-273 * temp_scale / Vref) */
> +		ret = regulator_get_voltage(ddata->ref);
> +		if (ret < 0)
> +			return ret;
>  
> -		return IIO_VAL_FRACTIONAL_LOG2;
> +		*val = kelvin_to_celsius(0) * ddata->chip_info->temp_scale_mV;
> +		*val2 = ret / 1000;
> +
> +		return IIO_VAL_FRACTIONAL;
>  
>  	default:
>  		return -EINVAL;
> @@ -126,39 +170,56 @@ static int ltc2497core_read_raw(struct iio_dev *indio_dev,
>  	.differential = 1, \
>  }
>  
> +#define LTC2497_TEMPERATURE_CHAN \
> +{												\
> +	.type = IIO_TEMP,									\
> +	.channel = 0,										\

No need for channel if indexed == 0.

> +	.address = (LTC2497_ENABLE_TEMPERATURE_CONV),						\

Since this can't be used the same was as the voltage address
field, not sure it makes sense to set this. Later, we can
just check the channel.type instead.

> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),						\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET),	\
> +}
> +
> +#define LTC2497_VOLTAGE_CHANNEL_LIST \
> +	LTC2497_CHAN(0, LTC2497_SGL, "CH0"),			\
> +	LTC2497_CHAN(1, LTC2497_SGL, "CH1"),			\
> +	LTC2497_CHAN(2, LTC2497_SGL, "CH2"),			\
> +	LTC2497_CHAN(3, LTC2497_SGL, "CH3"),			\
> +	LTC2497_CHAN(4, LTC2497_SGL, "CH4"),			\
> +	LTC2497_CHAN(5, LTC2497_SGL, "CH5"),			\
> +	LTC2497_CHAN(6, LTC2497_SGL, "CH6"),			\
> +	LTC2497_CHAN(7, LTC2497_SGL, "CH7"),			\
> +	LTC2497_CHAN(8, LTC2497_SGL, "CH8"),			\
> +	LTC2497_CHAN(9, LTC2497_SGL, "CH9"),			\
> +	LTC2497_CHAN(10, LTC2497_SGL, "CH10"),			\
> +	LTC2497_CHAN(11, LTC2497_SGL, "CH11"),			\
> +	LTC2497_CHAN(12, LTC2497_SGL, "CH12"),			\
> +	LTC2497_CHAN(13, LTC2497_SGL, "CH13"),			\
> +	LTC2497_CHAN(14, LTC2497_SGL, "CH14"),			\
> +	LTC2497_CHAN(15, LTC2497_SGL, "CH15"),			\
> +	LTC2497_CHAN_DIFF(0, LTC2497_DIFF),			\
> +	LTC2497_CHAN_DIFF(1, LTC2497_DIFF),			\
> +	LTC2497_CHAN_DIFF(2, LTC2497_DIFF),			\
> +	LTC2497_CHAN_DIFF(3, LTC2497_DIFF),			\
> +	LTC2497_CHAN_DIFF(4, LTC2497_DIFF),			\
> +	LTC2497_CHAN_DIFF(5, LTC2497_DIFF),			\
> +	LTC2497_CHAN_DIFF(6, LTC2497_DIFF),			\
> +	LTC2497_CHAN_DIFF(7, LTC2497_DIFF),			\
> +	LTC2497_CHAN_DIFF(0, LTC2497_DIFF | LTC2497_SIGN),	\
> +	LTC2497_CHAN_DIFF(1, LTC2497_DIFF | LTC2497_SIGN),	\
> +	LTC2497_CHAN_DIFF(2, LTC2497_DIFF | LTC2497_SIGN),	\
> +	LTC2497_CHAN_DIFF(3, LTC2497_DIFF | LTC2497_SIGN),	\
> +	LTC2497_CHAN_DIFF(4, LTC2497_DIFF | LTC2497_SIGN),	\
> +	LTC2497_CHAN_DIFF(5, LTC2497_DIFF | LTC2497_SIGN),	\
> +	LTC2497_CHAN_DIFF(6, LTC2497_DIFF | LTC2497_SIGN),	\
> +	LTC2497_CHAN_DIFF(7, LTC2497_DIFF | LTC2497_SIGN)
> +
>  static const struct iio_chan_spec ltc2497core_channel[] = {
> -	LTC2497_CHAN(0, LTC2497_SGL, "CH0"),
> -	LTC2497_CHAN(1, LTC2497_SGL, "CH1"),
> -	LTC2497_CHAN(2, LTC2497_SGL, "CH2"),
> -	LTC2497_CHAN(3, LTC2497_SGL, "CH3"),
> -	LTC2497_CHAN(4, LTC2497_SGL, "CH4"),
> -	LTC2497_CHAN(5, LTC2497_SGL, "CH5"),
> -	LTC2497_CHAN(6, LTC2497_SGL, "CH6"),
> -	LTC2497_CHAN(7, LTC2497_SGL, "CH7"),
> -	LTC2497_CHAN(8, LTC2497_SGL, "CH8"),
> -	LTC2497_CHAN(9, LTC2497_SGL, "CH9"),
> -	LTC2497_CHAN(10, LTC2497_SGL, "CH10"),
> -	LTC2497_CHAN(11, LTC2497_SGL, "CH11"),
> -	LTC2497_CHAN(12, LTC2497_SGL, "CH12"),
> -	LTC2497_CHAN(13, LTC2497_SGL, "CH13"),
> -	LTC2497_CHAN(14, LTC2497_SGL, "CH14"),
> -	LTC2497_CHAN(15, LTC2497_SGL, "CH15"),
> -	LTC2497_CHAN_DIFF(0, LTC2497_DIFF),
> -	LTC2497_CHAN_DIFF(1, LTC2497_DIFF),
> -	LTC2497_CHAN_DIFF(2, LTC2497_DIFF),
> -	LTC2497_CHAN_DIFF(3, LTC2497_DIFF),
> -	LTC2497_CHAN_DIFF(4, LTC2497_DIFF),
> -	LTC2497_CHAN_DIFF(5, LTC2497_DIFF),
> -	LTC2497_CHAN_DIFF(6, LTC2497_DIFF),
> -	LTC2497_CHAN_DIFF(7, LTC2497_DIFF),
> -	LTC2497_CHAN_DIFF(0, LTC2497_DIFF | LTC2497_SIGN),
> -	LTC2497_CHAN_DIFF(1, LTC2497_DIFF | LTC2497_SIGN),
> -	LTC2497_CHAN_DIFF(2, LTC2497_DIFF | LTC2497_SIGN),
> -	LTC2497_CHAN_DIFF(3, LTC2497_DIFF | LTC2497_SIGN),
> -	LTC2497_CHAN_DIFF(4, LTC2497_DIFF | LTC2497_SIGN),
> -	LTC2497_CHAN_DIFF(5, LTC2497_DIFF | LTC2497_SIGN),
> -	LTC2497_CHAN_DIFF(6, LTC2497_DIFF | LTC2497_SIGN),
> -	LTC2497_CHAN_DIFF(7, LTC2497_DIFF | LTC2497_SIGN),
> +	LTC2497_VOLTAGE_CHANNEL_LIST,
> +};
> +
> +static const struct iio_chan_spec ltc2497core_channel_with_temperature[] = {
> +	LTC2497_VOLTAGE_CHANNEL_LIST,
> +	LTC2497_TEMPERATURE_CHAN,
>  };
>  
>  static const struct iio_info ltc2497core_info = {
> @@ -182,8 +243,14 @@ int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
>  
>  	indio_dev->info = &ltc2497core_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->channels = ltc2497core_channel;
> -	indio_dev->num_channels = ARRAY_SIZE(ltc2497core_channel);
> +
> +	if (ddata->chip_info->has_temp_channel) {
> +		indio_dev->channels = ltc2497core_channel_with_temperature;
> +		indio_dev->num_channels = ARRAY_SIZE(ltc2497core_channel_with_temperature);
> +	} else {
> +		indio_dev->channels = ltc2497core_channel;
> +		indio_dev->num_channels = ARRAY_SIZE(ltc2497core_channel);
> +	}
>  
>  	ret = ddata->result_and_measure(ddata, LTC2497_CONFIG_DEFAULT, NULL);
>  	if (ret < 0)
> diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> index 8f4665547b5b0d32084599f8557c40102c37a4ce..07fced79aeead3778964b114d479fdcb643c16df 100644
> --- a/drivers/iio/adc/ltc2497.c
> +++ b/drivers/iio/adc/ltc2497.c
> @@ -86,8 +86,28 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
>  			return 0;
>  	}
>  
> -	ret = i2c_smbus_write_byte(st->client,
> -				   LTC2497_ENABLE | address);
> +	/*
> +	 * Chips with temperature sensor support (e.g., LTC2495/LTC2499)
> +	 * require a two-byte command format to select any channel.
> +	 *
> +	 * To read the internal temperature, LTC2497_ENABLE_TEMPERATURE_CONV
> +	 * is sent as the second byte. To read a voltage channel, LTC2497_EN2
> +	 * is sent, which sets the default configuration: simultaneous 50/60Hz
> +	 * rejection, 1x speed, and gain=1.
> +	 *
> +	 * Chips without this feature use a standard single-byte command.
> +	 */
> +	if (ddata->chip_info->has_temp_channel) {
> +		if (address == LTC2497_ENABLE_TEMPERATURE_CONV)

Here we can just check the channel type.

> +			ret = i2c_smbus_write_byte_data(st->client, LTC2497_ENABLE,
> +							LTC2497_ENABLE_TEMPERATURE_CONV);

And use LTC2497_EN2 | LTC2497_IM here.

> +		else
> +			ret = i2c_smbus_write_byte_data(st->client, LTC2497_ENABLE | address,
> +							LTC2497_EN2);
> +	} else {
> +		ret = i2c_smbus_write_byte(st->client, LTC2497_ENABLE | address);
> +	}
> +
>  	if (ret)
>  		dev_err(&st->client->dev, "i2c transfer failed: %pe\n",
>  			ERR_PTR(ret));
> @@ -135,6 +155,8 @@ static const struct ltc2497_chip_info ltc2497_info[] = {
>  	[TYPE_LTC2495] = {
>  		.resolution = 16,
>  		.name = "ltc2495",
> +		.has_temp_channel = true,
> +		.temp_scale_mV = 12250,
>  	},
>  	[TYPE_LTC2497] = {
>  		.resolution = 16,
> @@ -143,6 +165,8 @@ static const struct ltc2497_chip_info ltc2497_info[] = {
>  	[TYPE_LTC2499] = {
>  		.resolution = 24,
>  		.name = "ltc2499",
> +		.has_temp_channel = true,
> +		.temp_scale_mV = 1570000,
>  	},
>  };
>  
> diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
> index 64e81c95a3dd05911b6717c09ac0560c9f47f304..65f406bc61c24b912de4beed604a074b3ea9df91 100644
> --- a/drivers/iio/adc/ltc2497.h
> +++ b/drivers/iio/adc/ltc2497.h
> @@ -3,10 +3,25 @@
>  #define LTC2497_ENABLE			0xA0
>  #define LTC2497_CONFIG_DEFAULT		LTC2497_ENABLE
>  #define LTC2497_CONVERSION_TIME_MS	150ULL
> +#define LTC2497_EN2			BIT(7)
> +/* Enable the internal temperature sensor */
> +#define LTC2497_IM                      BIT(6)

These should go directly above:

#define LTC2497_SGL			BIT(4)

in the .c file. No need to have them in the header.


> +/* Second command byte value to initiate a temperature conversion */
> +#define LTC2497_ENABLE_TEMPERATURE_CONV	(LTC2497_EN2 | LTC2497_IM)

This macro seems odd. We usually don't make macros for combined bits
like this. And the way it is being used in the code feels a bit odd
as well. We can probably rework the code to not need it as suggested
in some of the comments above.

>  
>  struct ltc2497_chip_info {
>  	u32 resolution;
>  	const char *name;
> +	/*
> +	 * Represents the datasheet constant from the temperature formula:
> +	 * T_Kelvin = (DATAOUT * Vref) / temp_scale, where Vref is in Volts.
> +	 *
> +	 * To allow the driver to use Vref in millivolts for the calculation
> +	 * and also to avoid floating points, this stored value represents the
> +	 * datasheet constant scaled by 1000.
> +	 */
> +	u32 temp_scale_mV;
> +	bool has_temp_channel;
>  };
>  
>  struct ltc2497core_driverdata {
> 


