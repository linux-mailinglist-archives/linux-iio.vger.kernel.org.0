Return-Path: <linux-iio+bounces-14537-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE93A19AFF
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2025 23:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 277457A47F9
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2025 22:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745E31CAA83;
	Wed, 22 Jan 2025 22:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ddvNibj0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385441C5D4F
	for <linux-iio@vger.kernel.org>; Wed, 22 Jan 2025 22:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737585518; cv=none; b=sscc+JWns1hWhDztKRr0hCTXDpSkIgX+kxEwmUSO8QLnbcRuDwVOrtunjyffPBg6HESM2xrvRqnxe4wgyFK83pP3yCzcIFXUfKHM1rVBND7ao7CtXcF0G1RX5PBbE3aaGEqYWCL11PwRRsEKTVsK2tB1qrJazrjYcoUEM8Wd7CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737585518; c=relaxed/simple;
	bh=0nxmpyERqqyM+JO/ny6OIQ7+EPITpwuz+As7elXRXSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nstd+HVVt9rE9XGJlKRgAN+cduzE4XT+7Iw9QXiGGz3oOidaSLWRDFTDQO0zf1BUY9a+T2dTx3ZIEN7qcWON4N8ToJRu8HfDWGYXWfPTTT2Ild9C9651tkx4+wCUjCPvuC48jNz1oFUYDXftTuyeVZ3Oqj1l7C7X1HzEp2hwJdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ddvNibj0; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3eba5848ee4so114432b6e.3
        for <linux-iio@vger.kernel.org>; Wed, 22 Jan 2025 14:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1737585513; x=1738190313; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7bt9cL9wr0lXMGAtdLduMq4eacOv/CjujW2/TZvHg78=;
        b=ddvNibj0qqpx/Cy/CKdaVGAWd8qOT/ftc7ZbWthBG2BU/ttGjYB2NDAyVnBkjedylJ
         ERJDQUNfqVZGgqOhTyhT/54l5AFuyk60nhBDnEp9LIkHE+MLR59GQAwEKGs/Tg/NAr9k
         tliWIZRy1KHtgCStHepVe29nh7KSakLvfkS+x2fgHJYI88FIOWcnXI1j4V+V6PGRhr9o
         FLTOr/uCnbiXFhEN6+KxZdeAnnWbTO+OSLFsdt9Vgsm7SixJlWVBOMEnwyVxH2LYU7ld
         KyLhgTNkPpYsWYgYJhhaXUVpbcFqgGByurXyGzHixGzkpptl2kh3u65rUzESp4GNZLcj
         XiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737585513; x=1738190313;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7bt9cL9wr0lXMGAtdLduMq4eacOv/CjujW2/TZvHg78=;
        b=AmzdptoLDQ+OWN/wJV28CZtr/hppUdWlX0s8lXjt3y0r4QHP3Jh5VwzqtnOsVmekSm
         USQ+5qIT3PWiEC63v4lQNRn+Womio8Pu63lalNEBGk5fT4dp0C5Ix9m3K8Ud8/fEnQ71
         t94AFpQFYmoEK03g7OTec2/WuFz0epkm+8uK4wwRDRrKCO7ctipeZsRffO8btZtu5YSX
         eWBHb1oC37669SXoqegB7XkjesXmkk/dhEvlFe6rV0Sgsx74+VnsvSDW2kxhht+2XJM+
         QWgFREWsAnX7Jg+t2L2QFOtqufVGWqoh/FSmYzwtKcfAnBgMFrWQJjwIjDyQ5SZWwrQC
         eEMA==
X-Forwarded-Encrypted: i=1; AJvYcCXNMS7XuboVY24drPwz7p2cmBqEK7LNxySkR7ouuNiotE9wvlgB/wUtRwDJVoMVXEfSaO+BfwbxWIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy28xdVAk0xUEbp8lhZYpMR3QyCMbpvN+vYPmp1ETbrYNdoQwFp
	0wGF0KJc4xxgVxTJNCUau7/QcwhJ50PIQfp/2aq/N3eRsT6+6cbZCyQj7Dt4Rw4=
X-Gm-Gg: ASbGncuIOBwUxMHccrfBojbluikdO2e5FDaa945Lp/t75mx5bHYfczZWv8Verprh5cX
	unzY5/bBHvi02Fz7ky7VH1BGdXox+pP6vN7KCxrWHnjU/tXmMpO3Jg7p+yELwDQPMdBsZJph8kR
	Z/XH+CNooPaEa38QTWYTJc7cLFAGmyv7VJgYA1IYqK+cRfuir4WONIOINjjbHOzbwnVXQ1dbYs5
	+Bjzaq+cy+J6L3Sb7hGzuaVQloKg1KvX+25cI2dOl45KZOJGlBETrmH7FvEIyWOxZlfSQ8/5UWc
	mOrV1XF6irEwIL4f4ZyJ3r3PJ4c0tpo=
X-Google-Smtp-Source: AGHT+IHxTtm0NCW5ptLZcDpW2fE3UCEZIzaY9Y6XQ1sO/kIQU5Zq3hpZQpJMhugzaCF/G+UUQJlOuw==
X-Received: by 2002:a05:6870:2a42:b0:29e:719b:7837 with SMTP id 586e51a60fabf-2b1c08bb3f8mr12621545fac.13.1737585513087;
        Wed, 22 Jan 2025 14:38:33 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7249b4852e0sm4082079a34.52.2025.01.22.14.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 14:38:31 -0800 (PST)
Message-ID: <c3846c9f-e804-4def-b400-c8220efdecf7@baylibre.com>
Date: Wed, 22 Jan 2025 16:38:29 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: adc: ad7191: add AD7191
To: Alisa-Dariana Roman <alisadariana@gmail.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>
References: <20250122132821.126600-1-alisa.roman@analog.com>
 <20250122132821.126600-3-alisa.roman@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250122132821.126600-3-alisa.roman@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/22/25 7:20 AM, Alisa-Dariana Roman wrote:
> AD7191 is a pin-programmable, ultralow noise 24-bit sigma-delta ADC

ultra-low

> designed for precision bridge sensor measurements. It features two
> differential analog input channels, selectable output rates,
> programmable gain, internal temperature sensor and simultaneous
> 50Hz/60Hz rejection.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---

...

> diff --git a/drivers/iio/adc/ad7191.c b/drivers/iio/adc/ad7191.c
> new file mode 100644
> index 000000000000..dd8151ad3f3f
> --- /dev/null
> +++ b/drivers/iio/adc/ad7191.c
> @@ -0,0 +1,570 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AD7191 ADC driver
> + *
> + * Copyright 2025 Analog Devices Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/adc/ad_sigma_delta.h>

prefer alphabetical order

> +
> +#define ad_sigma_delta_to_ad7191(sigmad)	container_of((sigmad), struct ad7191_state, sd)
> +
> +#define AD7191_TEMP_CODES_PER_DEGREE	2815
> +
> +#define AD7191_EXT_CLK_ENABLE		0
> +#define AD7191_INT_CLK_ENABLE		1
> +
> +#define AD7191_CHAN_MASK		BIT(0)
> +#define AD7191_TEMP_MASK		BIT(1)
> +
> +#define AD7191_MAX_ODR_STATE		3
> +#define AD7191_MAX_PGA_STATE		3
> +
> +enum ad7191_channel {
> +	AD7191_CH_AIN1_AIN2 = 0,

0 isn't needed here.

> +	AD7191_CH_AIN3_AIN4,
> +	AD7191_CH_TEMP
> +};
> +
> +/*
> + * NOTE:
> + * The AD7191 features a dual-use data out ready DOUT/RDY output.
> + * In order to avoid contentions on the SPI bus, it's therefore necessary
> + * to use SPI bus locking.
> + *
> + * The DOUT/RDY output must also be wired to an interrupt-capable GPIO.

Probably worth mentioning that the SPI controller CS gets wired to PDOWN pin
on the ADC here since that isn't very obvious.

> + */
> +
> +struct ad7191_state {
> +	struct ad_sigma_delta		sd;
> +	struct mutex			lock; // to protect sensor state
> +
> +	struct gpio_descs		*odr_gpios;
> +	struct gpio_descs		*pga_gpios;
> +	struct gpio_desc		*temp_gpio;
> +	struct gpio_desc		*chan_gpio;
> +	struct gpio_desc		*clksel_gpio;
> +
> +	u16				int_vref_mv;
> +	u32				pga_state;
> +	u32				scale_avail[4][2];
> +	u32				odr_state;
> +	u32				samp_freq_avail[4];
> +
> +	struct clk			*mclk;
> +	u32				clksel_state;
> +};
> +
> +static int ad7191_set_channel(struct ad_sigma_delta *sd, unsigned int channel)

Would be less confusing to me if the channel parameter was changed to "address"
since the actual value is the channel spec .address field.

> +{
> +	struct ad7191_state *st = ad_sigma_delta_to_ad7191(sd);
> +	u8 temp_gpio_val, chan_gpio_val;
> +
> +	if (!FIELD_FIT(AD7191_CHAN_MASK | AD7191_TEMP_MASK, channel))
> +		return -EINVAL;
> +
> +	chan_gpio_val = FIELD_GET(AD7191_CHAN_MASK, channel);
> +	temp_gpio_val = FIELD_GET(AD7191_TEMP_MASK, channel);
> +
> +	gpiod_set_value(st->chan_gpio, chan_gpio_val);
> +	gpiod_set_value(st->temp_gpio, temp_gpio_val);
> +
> +	return 0;
> +}
> +
> +static int set_cs(struct ad_sigma_delta *sigma_delta, int pull_down)

Make it ad7191_set_cs() to be consistent. And "assert" is probably a more common
name instead of pull_down.

> +{
> +	struct spi_transfer t = {
> +		.len = 0,
> +		.cs_change = pull_down,
> +	};
> +	struct spi_message m;
> +
> +	spi_message_init(&m);
> +	spi_message_add_tail(&t, &m);

Can make this one line with spi_message_init_with_transfers().

> +
> +	return spi_sync_locked(sigma_delta->spi, &m);
> +}
> +
> +static int ad7191_set_mode(struct ad_sigma_delta *sd,
> +			   enum ad_sigma_delta_mode mode)
> +{
> +	struct ad7191_state *st = ad_sigma_delta_to_ad7191(sd);
> +
> +	switch (mode) {
> +	case AD_SD_MODE_CONTINUOUS:
> +	case AD_SD_MODE_SINGLE:
> +		return set_cs(&st->sd, 1);
> +	case AD_SD_MODE_IDLE:
> +		return set_cs(&st->sd, 0);
> +	default:
> +		return 0;

Should default return an error?

> +	}
> +}
> +
> +static const struct ad_sigma_delta_info ad7191_sigma_delta_info = {
> +	.set_channel = ad7191_set_channel,
> +	.set_mode = ad7191_set_mode,
> +	.has_registers = false,
> +};
> +
> +static int ad7191_init_regulators(struct iio_dev *indio_dev)
> +{
> +	struct ad7191_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->sd.spi->dev;
> +	int ret;
> +
> +	ret = devm_regulator_get_enable(dev, "avdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable specified AVdd supply\n");
> +
> +	ret = devm_regulator_get_enable(dev, "dvdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable specified DVdd supply\n");
> +
> +	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to get Vref voltage\n");
> +
> +	st->int_vref_mv = ret / 1000;
> +
> +	return 0;
> +}
> +
> +static int ad7191_gpio_setup(struct iio_dev *indio_dev)
> +{
> +	struct ad7191_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->sd.spi->dev;
> +
> +	if (device_property_read_u32(dev, "adi,odr-state", &st->odr_state) == 0) {

Usually we check for a specific error. Otherwise, if someone does something like
using a string instead of an int in the .dts file, we will get the default value
rather than an error.

> +		if (st->odr_state > AD7191_MAX_ODR_STATE)
> +			return dev_err_probe(dev, -EINVAL, "Invalid ODR state.\n");
> +
> +		dev_info(dev, "ODR is pin-strapped to %d\n", st->odr_state);

dev_dbg(). or remove it. we can get the info by reading the samping_frequency
attribute if needed.

> +		st->odr_gpios = NULL;
> +	} else {
> +		st->odr_gpios = devm_gpiod_get_array(dev, "odr", GPIOD_OUT_LOW);
> +		if (IS_ERR(st->odr_gpios))
> +			return dev_err_probe(dev, PTR_ERR(st->odr_gpios),
> +					     "Failed to get odr gpios.\n");
> +	}
> +
> +	if (device_property_read_u32(dev, "adi,pga-state", &st->pga_state) == 0) {
> +		if (st->odr_state > AD7191_MAX_PGA_STATE)

Looks like copy/paste mistake. Should be checking pga_state here.

> +			return dev_err_probe(dev, -EINVAL, "Invalid PGA state.\n");
> +
> +		dev_info(dev, "PGA is pin-strapped to %d\n", st->pga_state);
> +		st->pga_gpios = NULL;
> +	} else {
> +		st->pga_gpios = devm_gpiod_get_array(dev, "pga", GPIOD_OUT_LOW);
> +		if (IS_ERR(st->pga_gpios))
> +			return dev_err_probe(dev, PTR_ERR(st->pga_gpios),
> +					     "Failed to get pga gpios.\n");
> +	}
> +
> +	if (device_property_read_u32(dev, "adi,clksel-state", &st->clksel_state) == 0) {
> +		dev_info(dev, "CLKSEL is pin-strapped to %d\n", st->clksel_state);
> +		st->clksel_gpio = NULL;
> +	} else {
> +		st->clksel_gpio = devm_gpiod_get(dev, "clksel", GPIOD_OUT_HIGH);
> +		if (IS_ERR(st->clksel_gpio))
> +			return dev_err_probe(dev, PTR_ERR(st->clksel_gpio),
> +					     "Failed to get clksel gpio.\n");
> +	}
> +
> +	st->temp_gpio = devm_gpiod_get(dev, "temp", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->temp_gpio))
> +		return dev_err_probe(dev, PTR_ERR(st->temp_gpio),
> +				     "Failed to get temp gpio.\n");
> +
> +	st->chan_gpio = devm_gpiod_get(dev, "chan", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->chan_gpio))
> +		return dev_err_probe(dev, PTR_ERR(st->chan_gpio),
> +				     "Failed to get chan gpio.\n");
> +
> +	return 0;
> +}
> +
> +static int ad7191_clock_setup(struct ad7191_state *st)
> +{

As mentioned in the dt-bindings patch review, this could be simpified a bit if
we remove some of the reduant/unnecessary properties.

> +	struct device *dev = &st->sd.spi->dev;
> +	u8 clksel_value;
> +
> +	st->mclk = devm_clk_get_enabled(dev, "mclk");
> +	if (IS_ERR(st->mclk)) {
> +		if (PTR_ERR(st->mclk) != -ENOENT)
> +			return dev_err_probe(dev, PTR_ERR(st->mclk),
> +					     "Failed to get mclk.\n");
> +
> +		/*
> +		 * No external clock found, default to internal clock.
> +		 */
> +		clksel_value = AD7191_INT_CLK_ENABLE;
> +		if (!st->clksel_gpio && st->clksel_state != AD7191_INT_CLK_ENABLE)
> +			return dev_err_probe(dev, -EINVAL,
> +				"Invalid CLKSEL state. To use the internal clock, CLKSEL must be high.\n");
> +
> +		dev_info(dev, "Using internal clock.\n");
> +	} else {
> +		clksel_value = AD7191_EXT_CLK_ENABLE;
> +		if (!st->clksel_gpio && st->clksel_state != AD7191_EXT_CLK_ENABLE)
> +			return dev_err_probe(dev, -EINVAL,
> +				"Invalid CLKSEL state. To use the external clock, CLKSEL must be low.\n");
> +
> +		dev_info(dev, "Using external clock.\n");
> +	}
> +
> +	if (st->clksel_gpio)
> +		gpiod_set_value(st->clksel_gpio, clksel_value);
> +
> +	return 0;
> +}
> +
> +static int ad7191_setup(struct iio_dev *indio_dev, struct device *dev)
> +{
> +	struct ad7191_state *st = iio_priv(indio_dev);
> +	u64 scale_uv;
> +	const int gain[4] = {1, 8, 64, 128};
> +	int i, ret;
> +
> +	ret = ad7191_init_regulators(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7191_gpio_setup(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7191_clock_setup(st);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Sampling frequencies in Hz, available in the documentation, Table 5.
> +	 */
> +	st->samp_freq_avail[0] = 120;
> +	st->samp_freq_avail[1] = 60;
> +	st->samp_freq_avail[2] = 50;
> +	st->samp_freq_avail[3] = 10;

Looks like this one could just be static const data. Or if ODR pins are hard-
wired, maybe this should only have 1 value.

> +
> +	for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++) {
> +		scale_uv = ((u64)st->int_vref_mv * NANO) >>
> +			   (indio_dev->channels[0].scan_type.realbits - 1);
> +		do_div(scale_uv, gain[i]);
> +		st->scale_avail[i][1] = do_div(scale_uv, NANO);
> +		st->scale_avail[i][0] = scale_uv;

Same here, if gain pins are hard-wired, then the other options aren't really
available.

> +	}
> +
> +	return 0;
> +}
> +
> +static int ad7191_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan, int *val,
> +			   int *val2, long m)
> +{
> +	struct ad7191_state *st = iio_priv(indio_dev);
> +
> +	switch (m) {
> +	case IIO_CHAN_INFO_RAW:
> +		return ad_sigma_delta_single_conversion(indio_dev, chan, val);
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			guard(mutex)(&st->lock);
> +			*val = st->scale_avail[st->pga_state][0];
> +			*val2 = st->scale_avail[st->pga_state][1];
> +			return IIO_VAL_INT_PLUS_NANO;
> +		case IIO_TEMP:
> +			*val = 0;
> +			*val2 = NANO / AD7191_TEMP_CODES_PER_DEGREE;
> +			return IIO_VAL_INT_PLUS_NANO;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = -(1 << (chan->scan_type.realbits - 1));
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			return IIO_VAL_INT;
> +		case IIO_TEMP:
> +			*val -= 273 * AD7191_TEMP_CODES_PER_DEGREE;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = st->samp_freq_avail[st->odr_state];
> +		return IIO_VAL_INT;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ad7191_set_gain(struct ad7191_state *st, int gain_index)
> +{
> +	unsigned long value = gain_index;
> +
> +	if (!st->pga_gpios)
> +		return -EPERM;
> +
> +	st->pga_state = gain_index;
> +
> +	return gpiod_set_array_value(2, st->pga_gpios->desc,

Replace hard-coded 2 with st->pga_gpios->ndescs.

Also, gpiod_set_array_value_cansleep() should be OK.

> +				     st->pga_gpios->info, &value);
> +
> +	return 0;
> +}
> +
> +static int ad7191_set_samp_freq(struct ad7191_state *st, int samp_freq_index)
> +{
> +	unsigned long value = samp_freq_index;
> +
> +	if (!st->odr_gpios)
> +		return -EPERM;
> +
> +	st->odr_state = samp_freq_index;
> +
> +	return gpiod_set_array_value(2, st->odr_gpios->desc,
> +				     st->odr_gpios->info, &value);

ditto

> +}
> +
> +static int __ad7191_write_raw(struct ad7191_state *st,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	int i;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		guard(mutex)(&st->lock);
> +		for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++) {
> +			if (val2 != st->scale_avail[i][1])
> +				continue;
> +			return ad7191_set_gain(st, i);
> +		}
> +		return -EINVAL;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (!val)
> +			return -EINVAL;

This check seems reduandant since we would get the same result below without it.

> +
> +		guard(mutex)(&st->lock);
> +		for (i = 0; i < ARRAY_SIZE(st->samp_freq_avail); i++) {
> +			if (val != st->samp_freq_avail[i])
> +				continue;
> +			return ad7191_set_samp_freq(st, i);
> +		}
> +		return -EINVAL;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +

...

> +static const struct iio_chan_spec ad7191_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.address = AD7191_CH_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_OFFSET),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 24,
> +			.storagebits = 24,

IIO buffers are "natrually" aligned, so storagebits for anything > 16, <= 32 is
going to be a 32-bit integer.

> +			.endianness = IIO_BE,
> +		},
> +	},
> +	{
> +		.type = IIO_VOLTAGE,
> +		.differential = 1,
> +		.indexed = 1,
> +		.channel = 1,
> +		.channel2 = 2,
> +		.address = AD7191_CH_AIN1_AIN2,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_OFFSET),

A bit odd to have offset separate and scale by type, but I guess it isn't
wrong.

> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = 1,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 24,
> +			.storagebits = 24,
> +			.endianness = IIO_BE,
> +		},
> +	},
> +	{
> +		.type = IIO_VOLTAGE,
> +		.differential = 1,
> +		.indexed = 1,
> +		.channel = 3,
> +		.channel2 = 4,
> +		.address = AD7191_CH_AIN3_AIN4,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_OFFSET),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = 2,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 24,
> +			.storagebits = 24,
> +			.endianness = IIO_BE,
> +		},
> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +
> +static int ad7191_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct ad7191_state *st;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	if (!spi->irq) {
> +		dev_err(dev, "no IRQ?\n");
> +		return -ENODEV;

return dev_err_probe(...);

Or should we just let ad_sd_init() handle it?


> +	}
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = "ad7191";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ad7191_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ad7191_channels);
> +	indio_dev->info = &ad7191_info;
> +
> +	ad_sd_init(&st->sd, indio_dev, spi, &ad7191_sigma_delta_info);

Need to check return value.

> +
> +	ret = devm_ad_sd_setup_buffer_and_trigger(dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7191_setup(indio_dev, dev);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct of_device_id ad7191_of_match[] = {
> +	{
> +		.compatible = "adi,ad7191",
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad7191_of_match);
> +
> +static const struct spi_device_id ad7191_id_table[] = {
> +	{ "ad7191", 0 },

Could leave out the 0 here.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ad7191_id_table);
> +
> +static struct spi_driver ad7191_driver = {
> +	.driver = {
> +		.name = "ad7191",
> +		.of_match_table = ad7191_of_match,
> +	},
> +	.probe = ad7191_probe,

Still missing .id_table here.

> +};
> +module_spi_driver(ad7191_driver);
> +
> +MODULE_AUTHOR("Alisa-Dariana Roman <alisa.roman@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD7191 ADC");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(IIO_AD_SIGMA_DELTA);


