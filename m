Return-Path: <linux-iio+bounces-18658-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D42A9CEF4
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 18:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040E41C01DB4
	for <lists+linux-iio@lfdr.de>; Fri, 25 Apr 2025 16:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA4B1D799D;
	Fri, 25 Apr 2025 16:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="S+1mFjNo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5A21A9B48
	for <linux-iio@vger.kernel.org>; Fri, 25 Apr 2025 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599736; cv=none; b=hGVrgliyW+XOjPF4+c6P7OzsIusvzlyiLO9Xjf2SqG+WA+j54azCN0fWCnIqYwlNAy6N0VOu0LwEAjNQ4gBLQkjRJHQkIqnQ87bm+S6NfxlA5hu+kvHbvYtKVnraU2FqLUpOtwNvc9uoSn5UeRD1snEkPdZOpEFJr6RMFVnVPHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599736; c=relaxed/simple;
	bh=c15FFBPD7cNvnTIPdQ5+juScxMHwHHTCTtUUxiHwRb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A4V0m3QoRCZ2SCoSZIwOsy1kmzOvlxBjNs1WbLuymIUpDI5kPFbDaZZ3+vnbBmvcZ96J8JO+3h3Zg+mXZrBQRVXSM+LLhmHCzFZoxsZYs69LtMl1y0HvaqNKIzHBWhwuYRZYH66jRzthCmsiqIPu2gZBiEvTWdU5lf5s+YgFu8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=S+1mFjNo; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6063462098eso1593254eaf.0
        for <linux-iio@vger.kernel.org>; Fri, 25 Apr 2025 09:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745599732; x=1746204532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CM7pkW59Di0UBQjeqif68Oa7w1/ZL8a21NMk5X8frN4=;
        b=S+1mFjNo8qP7aOqG1fVYDJuCoQq3x3vS7J2dKEWgkYInBwiVfS9e4vVLQw4uK4aVv6
         N6u9DD71/AZUcf0lmTGDDF5vr1SGlujUuem8J1HHjbmblXVvTM3M5j6ODiD33QQY15C+
         b+KTWuufeUfmJKgfyqEaUEMYP8GGy7cdCKQyXeDvd1Xg5+TPgIdD/IQ9IFq9TR3/cy+m
         rb+2RoaYyvr+jaAgIRaUX1JT7Xy9H+63+Sjib7KhxkJhsiTQzlGWCGKIhqZuycbQRlIl
         nTt/VWsh9aDuUDa4hKBqEVYryeX7hYgyl+MOPsEXcGWCUYeLsQEIlhZDu1U68GzM0Rs8
         +lqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745599732; x=1746204532;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CM7pkW59Di0UBQjeqif68Oa7w1/ZL8a21NMk5X8frN4=;
        b=RtR9Xbe7sVOLjlLnOGsXQjyR0oRFasEqTpRXQi2RKaB6WhwVKsZE/GH7okRg/oHcOF
         k5ApQQp6EvsmsNdxvpra4RXFJww10UJW99y2SZQHqeHcsqO0ZeJB9TKp7mlQ9SGAGlok
         WZN+BbKtmG0g+Jy8O/uNwsWZr2E9xpUMBlD3K2tM2RF3p2kdOQDzFhl9SGEHD9pdhLFV
         sn8gTDKTvTnAQkas/lREeRuPhUqTcM8b3zq/iYsgumFx9VGB8IQU98xpIChe/79xo+6L
         zK/uk5iR1VWBzgrlV1vnuoI7EVyA6X7gus8qj69N8cXjzfF4dv3+YMuOaam5CseUiol0
         ecQw==
X-Gm-Message-State: AOJu0YxOfxWGJSFHNuzjpNKV4Ls50lPnksbTnWi4M4poX8nrRREcvXYC
	VP3qcb4DRteL+itJ2wX/vWF8wQ1OsfH+B250nah0NbwB3lKg3dV32XEz/96pTmk=
X-Gm-Gg: ASbGncve2FhU/TbXRSjvjt95qRoXtKY40FFazv4mvNcPMzTJrWrM59RpdeDZXQnRAWR
	8zwu5f0CUTd/XypqXBoa2esDkgGG7n0qbUY1wBepaBPF3owAzNgunuAmcbgIG4GJ7P9Il6r8/kd
	IKD2ZuWG3V0DGXTUKSdE6FRhyOgRabMLlTwc09x3tGeEQaXcdX6xtxgXfENhNJCxkgdZIrmbf1W
	3rQ77WdqTY1J/fQcub+haaBQo8rYthJzuk2zNFFTovEySmABnDkEdSr+L8JXr0qT1mG9a7CzKd4
	HStdjWsgZ3GlLvV5rjP1oGCwGMNl3drW+zy9Lxe7lznX0AUeSZP3H7ji8VzeMhZG4bvTpPsHEPG
	7mkqhgs+cjwFi
X-Google-Smtp-Source: AGHT+IGXBjZEMb6oKJCjIeICJiGbotHapg4FiIPE7YJa4TjKE5cyC25jAcVAxl93P7C72iNDQS5JhA==
X-Received: by 2002:a05:6820:180a:b0:603:ca2a:5e90 with SMTP id 006d021491bc7-606527ba384mr1635346eaf.0.1745599732379;
        Fri, 25 Apr 2025 09:48:52 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:96a3:e28:3f6:dbac? ([2600:8803:e7e4:1d00:96a3:e28:3f6:dbac])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-60646864241sm786879eaf.7.2025.04.25.09.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 09:48:52 -0700 (PDT)
Message-ID: <8ea9b3b7-1896-470e-9c7e-023d4ea248bc@baylibre.com>
Date: Fri, 25 Apr 2025 11:48:50 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/3] iio: dac: ad3530r: Add driver for AD3530R and
 AD3531R
To: Kim Seer Paller <kimseer.paller@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250425-togreg-v6-0-47b6f9878ae5@analog.com>
 <20250425-togreg-v6-3-47b6f9878ae5@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250425-togreg-v6-3-47b6f9878ae5@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/25/25 7:54 AM, Kim Seer Paller wrote:
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

Reviewed-by: David Lechner <dlechner@baylibre.com>

Just a few small things in the latest changes that could be improved...


> +#define AD3530R_SLD_TRIG_A			BIT(7)
> +#define AD3530R_OUTPUT_CONTROL_RANGE		BIT(2)
> +#define AD3530R_REFERENCE_CONTROL_SEL		BIT(0)
> +#define AD3530R_REG_VAL_MASK			GENMASK(15, 0)
> +#define AD3530R_OP_MODE_CHAN_MSK(chan)		(GENMASK(1, 0) << 2 * chan)

For safety:

#define AD3530R_OP_MODE_CHAN_MSK(chan)		(GENMASK(1, 0) << 2 * (chan))

...

> +static ssize_t ad3530r_set_dac_powerdown(struct iio_dev *indio_dev,
> +					 uintptr_t private,
> +					 const struct iio_chan_spec *chan,
> +					 const char *buf, size_t len)
> +{
> +	struct ad3530r_state *st = iio_priv(indio_dev);
> +	int ret;
> +	unsigned int mask, val, reg, pdmode;
> +	bool powerdown;
> +
> +	ret = kstrtobool(buf, &powerdown);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&st->lock);
> +	mask = AD3530R_OP_MODE_CHAN_MSK(chan->channel);
> +	reg = chan->channel < AD3531R_MAX_CHANNELS ?
> +	      AD3530R_OUTPUT_OPERATING_MODE_0 :
> +	      AD3530R_OUTPUT_OPERATING_MODE_1;
> +	pdmode = powerdown ? st->chan[chan->channel].powerdown_mode : 0;
> +	val = pdmode << 2 * chan->channel;

#define field_prep(_mask, _val)	(((_val) << (ffs(_mask) - 1)) & (_mask))

	mask = AD3530R_OP_MODE_CHAN_MSK(chan->channel);
	val = field_prep(mask, pdmode);


(Maybe someday this will be standardized: https://lore.kernel.org/all/cover.1739540679.git.geert+renesas@glider.be/)

> +
> +	ret = regmap_update_bits(st->regmap, reg, mask, val);
> +	if (ret)
> +		return ret;
> +
> +	st->chan[chan->channel].powerdown = powerdown;
> +
> +	return len;
> +}

...

> +static int ad3530r_setup(struct ad3530r_state *st, int vref)
> +{
> +	struct device *dev = regmap_get_device(st->regmap);
> +	struct gpio_desc *reset_gpio;
> +	int i, ret;
> +	u8 range_multiplier, val;
> +
> +	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(reset_gpio),
> +				     "Failed to get reset GPIO\n");
> +
> +	if (reset_gpio) {
> +		/* Perform hardware reset */
> +		fsleep(1 * USEC_PER_MSEC);
> +		gpiod_set_value_cansleep(reset_gpio, 0);
> +	} else {
> +		/* Perform software reset */
> +		ret = regmap_update_bits(st->regmap, AD3530R_INTERFACE_CONFIG_A,
> +					 AD3530R_SW_RESET, AD3530R_SW_RESET);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	fsleep(10 * USEC_PER_MSEC);
> +
> +	range_multiplier = 1;
> +	if (device_property_read_bool(dev, "adi,range-double")) {
> +		ret = regmap_set_bits(st->regmap, AD3530R_OUTPUT_CONTROL_0,
> +				      AD3530R_OUTPUT_CONTROL_RANGE);
> +		if (ret)
> +			return ret;
> +
> +		range_multiplier = 2;
> +	}
> +
> +	if (st->chip_info->internal_ref_support && vref == 0) {

At this point, we've already validated that if vref == 0 then
st->chip_info->internal_ref_support is true, so the check here is a bit
redundant.

> +		ret = regmap_set_bits(st->regmap, AD3530R_REFERENCE_CONTROL_0,
> +				      AD3530R_REFERENCE_CONTROL_SEL);
> +		if (ret)
> +			return ret;
> +
> +		st->vref_mV = range_multiplier * AD3530R_INTERNAL_VREF_mV;
> +	}
> +
> +	if (vref > 0)
> +		st->vref_mV = range_multiplier * vref / MILLI;

And we've already validated that vref >= 0. So slightly simpler would be:


	if (external_vref_uV) 
		st->vref_mV = range_multiplier * external_vref_uV / MILLI;
	} else {
		ret = regmap_set_bits(st->regmap, AD3530R_REFERENCE_CONTROL_0,
				      AD3530R_REFERENCE_CONTROL_SEL);
		if (ret)
			return ret;

		st->vref_mV = range_multiplier * AD3530R_INTERNAL_VREF_mV;
	}


(I also renamed vref to external_vref_uV to make it more obvious where the value
is coming from and what the units are)


