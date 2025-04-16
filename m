Return-Path: <linux-iio+bounces-18178-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED09BA90C35
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 21:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 003B217523D
	for <lists+linux-iio@lfdr.de>; Wed, 16 Apr 2025 19:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE03224B10;
	Wed, 16 Apr 2025 19:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="y4DORVsb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2467F2222B0
	for <linux-iio@vger.kernel.org>; Wed, 16 Apr 2025 19:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744831397; cv=none; b=byuialWPjL1urt6sNxsIoc2MUpCePW8saZIT65vF4SqWo7/FooCAa3uMpGrrx5Wj5VoclZ+vx+3ulbv1CimMVdpzYbPqZju+bUGsxsjCb3CvkG9/VpMfpkq4wugpEfO2WWz70GycaeDocTyFd2BPMmRCday6Lqea3c8L9ln83FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744831397; c=relaxed/simple;
	bh=n6HiIgF4wrJtBV7F514mTUclegysW2D8sxy0uun1FX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iPxduB+UnIY34tUK7P1rWcbi3zbvBE7yO0774T1dWxQOuWLuP3xa74mqWoPrbhUeEsZ99DHxEnLB+HxFIJYW6cAgGlCx/h7GWHAExaY/NnhSQiB+VCvC7Ndv1Wm1jljY8K0psAOGwhUnDo/AlHZxZQW2MaqgYFQWQxM/CZTqWZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=y4DORVsb; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-72c7336ed99so2265348a34.0
        for <linux-iio@vger.kernel.org>; Wed, 16 Apr 2025 12:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744831393; x=1745436193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vS5xUACcNCCrBpVNgHTyKpBRi3GuyJnUtbCmTpMSgjo=;
        b=y4DORVsbGxzB+9HYKmO4nebLhOFxxK735baofKE6wiCSXo4UAnftk5pZ1pDQIswYje
         Qq8Ux0ybMM7wjVP7ZT0QuKpcrvJXmcACYdi5Fr2W/z2zkCPHXxOivdX7Tar1Es9SlqwS
         xetxJvupLzVRUY0De+lY8MKHwBqhW0UOmwtzUN97OEmx9QOkQG+Ewre0SbbMuIB+xKMF
         0TlAOXv8Iqbz2dOyfhmzAVFjOxR2H7E8Jok+tAli7ZjAG8E5c2Sdd/wB5fnxzBC2z6Me
         T0OCVXo2ep4w3e72G+ra+oqxWKUsdbsYcimbkQpNgTsQHOPaZIUNgczIU0FCLVoa2Jbk
         pPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744831393; x=1745436193;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vS5xUACcNCCrBpVNgHTyKpBRi3GuyJnUtbCmTpMSgjo=;
        b=cqbhntkwfYXgWMxynKdIs5MGGJaKRZ6ko3CKTvkWeOaUjfdhHtG/Bm+vMwGs+aSZKQ
         gyxoy0Mga9sHcFhlN4KYGM4AVKQq+G8207S8nYu7dMTdaxOdKa8/Q8ZCRi6D3+tyIzkz
         yhnTmiKb6NLxvaQx0+0ufgTJhEQs8UwwcsaC1VVaxxQpW+v9+XH120PjfyK26Arpu+9S
         N6yQg7jH0lSrNjYqL3z8j/Aj3jA6K68nUr4TX91IHK8w6la4f+RtxVDOyQeC6MBd70zW
         h0QdduzwDJJpCdEC18IXziY4RcROWNDnp99fNIRYs1OjZ7RT3qXjMlSJQk6QaQWhxZrk
         XdMQ==
X-Gm-Message-State: AOJu0YzKolmN6HNSetUMNl3ZM08pNfTcnEWlp4toDJilc+K6WNEAXSro
	phE2COmaFNejyHRZyTgP5nnIhqMguzyaWp9v1bq2qqHz4xY6cuzil9LiIy6Kga8=
X-Gm-Gg: ASbGnctfbDiO9Q6HdKr7XmyAlwIWMJPSYbIwa7Esy5NPp+HkpdcA3mWM9Fup2Ivre/0
	iFUrYZ8+7viKSnqWDJhmc2rnM/qp2D+qIRpGrvtI2zYRWLXLNA/5tljlptsKfKDWd320ef4o9gc
	z2+jrXe295cuZY8/tjS12FhiJbaZQTFsb/sLILQ7cd3GPQvP1rb6c1J0BrtEnco9LQLVc4PrATc
	E5S1zMA7K8rvlFp4tgA5VNpUS3Q9YSMj9mlwzXmfczJMHchYFetIU9vhZpjeaB+lHEeRcWBW1Wf
	3otc+MhKVhpB5YXvwmyhTZNdXO6GHVKjzyd2o5znU4Qyq4tAzvHso79VwUHEa82kXV75sh6Cr+W
	LS8RgcOSweuSwvsBR6A==
X-Google-Smtp-Source: AGHT+IEshEuTpaRy2hRNUwgWJpOdGegeC8MYC6hqw3ipqrtukkPUoJAPGJ2kj6WGEl4JAoEPRqdOFA==
X-Received: by 2002:a05:6830:b94:b0:72b:9724:6a82 with SMTP id 46e09a7af769-72ec6cdfe8cmr1972036a34.17.1744831393135;
        Wed, 16 Apr 2025 12:23:13 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:58f0:670c:6b15:7fd3? ([2600:8803:e7e4:1d00:58f0:670c:6b15:7fd3])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-604a5bce487sm482389eaf.24.2025.04.16.12.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 12:23:12 -0700 (PDT)
Message-ID: <ef90f91a-c5eb-46ce-934f-93ff1a18af14@baylibre.com>
Date: Wed, 16 Apr 2025 14:23:11 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] iio: dac: ad3530r: Add driver for AD3530R and
 AD3531R
To: Kim Seer Paller <kimseer.paller@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250412-togreg-v4-0-cb9e5309b99d@analog.com>
 <20250412-togreg-v4-3-cb9e5309b99d@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250412-togreg-v4-3-cb9e5309b99d@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/12/25 12:57 AM, Kim Seer Paller wrote:
> The AD3530/AD3530R (8-channel) and AD3531/AD3531R (4-channel) are
> low-power, 16-bit, buffered voltage output DACs with software-
> programmable gain controls, providing full-scale output spans of 2.5V or
> 5V for reference voltages of 2.5V. These devices operate from a single
> 2.7V to 5.5V supply and are guaranteed monotonic by design. The "R"
> variants include a 2.5V, 5ppm/°C internal reference, which is disabled
> by default.
> 
> Support for monitoring internal die temperature, output voltages, and
> current of a selected channel via the MUXOUT pin using an external ADC
> is currently not implemented.
> 
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---

Looks very good now. :-)

A made a few comments but maybe nothing serious enough to require a v5.

> diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..ffa04f678b86d8da6f5e47c35c265b6648121843
> --- /dev/null
> +++ b/drivers/iio/dac/ad3530r.c
> @@ -0,0 +1,506 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AD3530R/AD3530 8-channel, 16-bit Voltage Output DAC Driver
> + * AD3531R/AD3531 4-channel, 16-bit Voltage Output DAC Driver
> + *
> + * Copyright 2025 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/kernel.h>

Usually, we try to avoid including kernel.h - it includes too much.

> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +
...

> +
> +static int ad3530r_setup(struct ad3530r_state *st, int vref,
> +			 bool has_external_vref)
> +{
> +	struct device *dev = regmap_get_device(st->regmap);
> +	struct gpio_desc *reset_gpio;
> +	int i, ret;
> +	bool has_range_multiplier;
> +
> +	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(reset_gpio),
> +				     "Failed to get reset GPIO\n");
> +
> +	if (reset_gpio) {
> +		/* Perform hardware reset */
> +		fsleep(1000);
> +		gpiod_set_value_cansleep(reset_gpio, 0);
> +	} else {
> +		/* Perform software reset */
> +		ret = regmap_update_bits(st->regmap, AD3530R_INTERFACE_CONFIG_A,
> +					 AD3530R_SW_RESET, AD3530R_SW_RESET);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	fsleep(10000);
> +
> +	has_range_multiplier = false;
> +	if (device_property_present(dev, "adi,range-double")) {

Since this is a flag, I think device_property_read_bool() is preferred.

> +		ret = regmap_set_bits(st->regmap, AD3530R_OUTPUT_CONTROL_0,
> +				      AD3530R_OUTPUT_CONTROL_RANGE);
> +		if (ret)
> +			return ret;
> +
> +		has_range_multiplier = true;
> +	}
> +
> +	if (!has_external_vref && st->chip_info->internal_ref_support) {
> +		ret = regmap_set_bits(st->regmap, AD3530R_REFERENCE_CONTROL_0,
> +				      AD3530R_REFERENCE_CONTROL_SEL);
> +		if (ret)
> +			return ret;
> +
> +		st->vref_mv = has_range_multiplier ?
> +			      2 * AD3530R_INTERNAL_VREF_MV :
> +			      AD3530R_INTERNAL_VREF_MV;
> +	}
> +
> +	if (has_external_vref)
> +		st->vref_mv = has_range_multiplier ? 2 * vref / 1000 : vref / 1000;
> +

I think this would be simpler as:

	st->vref_mv = range_multiplier * vref / 1000;

where range_multiplier is 1 or 2.

> +	/* Set operating mode to normal operation. */
> +	ret = regmap_write(st->regmap, AD3530R_OUTPUT_OPERATING_MODE_0,
> +			   AD3530R_NORMAL_OPERATION);
> +	if (ret)
> +		return ret;
> +
> +	if (st->chip_info->num_channels > AD3531R_MAX_CHANNELS) {
> +		ret = regmap_write(st->regmap, AD3530R_OUTPUT_OPERATING_MODE_1,
> +				   AD3530R_NORMAL_OPERATION);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	for (i = 0; i < st->chip_info->num_channels; i++)
> +		st->chan[i].powerdown_mode = AD3530R_POWERDOWN_32K;
> +
> +	st->ldac_gpio = devm_gpiod_get_optional(dev, "ldac", GPIOD_OUT_HIGH);

I guess it doesn't matter which state this starts in but GPIOD_OUT_LOW seems
more natural since we toggle it high the low later.

> +	if (IS_ERR(st->ldac_gpio))
> +		return dev_err_probe(dev, PTR_ERR(st->ldac_gpio),
> +				     "Failed to get ldac GPIO\n");
> +
> +	return 0;
> +}
> +

