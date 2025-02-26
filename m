Return-Path: <linux-iio+bounces-16105-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB44AA46CFF
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 22:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54E8018874E0
	for <lists+linux-iio@lfdr.de>; Wed, 26 Feb 2025 21:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55445257AD7;
	Wed, 26 Feb 2025 21:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rWish0Fu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46602512CF
	for <linux-iio@vger.kernel.org>; Wed, 26 Feb 2025 21:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740603960; cv=none; b=P1DsA6q+RNj22AQzlXwOaJp2qmOBgEHeN86sGoPph6ppVEFAg97l7XCHGDVEwE5dEnYhtfWbeGqXxNCcBmDObKSzL37vKwnd2sg2Ej5X9etgjNU4UPDzF9m5ZZdgnMf70usMdB70rZW4Lk4HW3dxE0GZKvGQzZ8ryN4q9Zd7aiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740603960; c=relaxed/simple;
	bh=OQ666NG5jCE1OfYjrmw9+4V7dPyvkjrCq3loV0fqcOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cgl6/cRQcls/QWzeh1V5lCR8L0p1HBxMopt3gCxoCv38ej1U3vfjJKyoMXTpkgwrEGzruQFCiXC7RiQLS7nFb3191l7MeJcRazYPrhj167/Ao35J89zbZ/2mMejmA945sXFUkLnstlOAjyLq2DshhQPT3de8Rs49K8yIobXs0ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rWish0Fu; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2bcca6aa8e1so114768fac.1
        for <linux-iio@vger.kernel.org>; Wed, 26 Feb 2025 13:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740603956; x=1741208756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o09uRDtCYwgyIJbqw/UUSd68XyAamMofq9wAGxBe/xs=;
        b=rWish0Fu4/JhHv8401dqNc2ZrxzANmvx4g7Pyzq9+kF4ytfbYrJhKW2DX25Mk4w4on
         y2dD9MDW583ZzDReODQXFwXkuWeYS9IZDryI12ohXY9XN1scWNWPHgb8I/po9KcTZUtV
         h1lilItbnU4QVRi9Aq6jNtPM3d9hmRYT1Qrxakv5VvNdALp+JX+n1jAvd0W395y6q7pv
         W0TQfeE+kY45nvRnk6kHjqoIQZa7eLxIfH2gTw3f8VDVLJ/G8gv9hoXMD2EIkEyGlh8g
         +GAt7UorQYLm0sFK8HbJrgsCe5tojH45lcT4hAUr7xj2LQ5odcBKfRU/LrkHgwJbQbMl
         DODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740603956; x=1741208756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o09uRDtCYwgyIJbqw/UUSd68XyAamMofq9wAGxBe/xs=;
        b=q4WW8fNBhnyCnEGfC6aYkR59bDgr8g69RsY/fX55rZCBVemg6K+rZCd0Ak1GAXZ0pi
         3pWCBqaUk2senbBTEiNHHcoWWd9cRz3a9sBWA3L7CriPZlx6BV8bDqB/YdFyvwcNx4p3
         KjcE4zKXndJrkv9l0VXSY8j2rs0kVcOW8Rq9nU470Fn5+Fd/8UxPhTMiYwQrM4NhlS+m
         HjglYKuTnnfnyzEaevEIyyo/LfwKwpX0pjw2jEJF4y82hEy4SPjyQXNdIj2HMRYTldbi
         0IwUATuCmBCNUptcBoHa+hDFKz7ZQi3MxztojFwu73hAOD2xz2xvRshvwSCF5RSYw/3f
         rVFw==
X-Forwarded-Encrypted: i=1; AJvYcCUytNRsQNbluBaZIRODmF1ULm+R4GM0LLhSukcZZt0WKab1n46kmcv7SvMGEek8yetqPMTP/tGdJjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsKDmRjhRGEeMSGpb6pQPLRV4W6P0BKrTAemOgr1yTiqnqKr9N
	HpR8JKP3fYmjiyNzCjuD1+tU9dXyZYE8i3UyPxCV7gahvA2fmoGnS0maK70xXwM=
X-Gm-Gg: ASbGncu4jmgMHZ4z4JyEKrf2x8N+Inm9o4ljtUTNhSmmH/45egJuSZysQuNh+Z9lLIt
	fY7kQXvh7ut+WjCYO6KSMYFjsOjxSqr8hZo5D4ySFIXvx/4cg75vIKvGSCOn6xaSs2yG0P7dEqg
	s/wGfGzADOMkENT2KSX3nuo/pD7/xZ4lisFgCWgTORriW29eEX7G9ADvU0njfAh/m/XvXLrlCWc
	BSobSrnp0QIQ1cjXe0qpROKTw63Dx0jGqmPBkOx7wfBGAVXIEmQmTs86pgpJUPB0oJi3pnbj54T
	vwFnfddxhrplDz8NDgwwZH9AYd49AuW5i3cvYf/e+jwFWIRwv3l7d7k9T0ttEzA=
X-Google-Smtp-Source: AGHT+IGOAz4kMU87RYF1Qu8O9LpqktJWrIes0StSxvqfE905m8LEh3FP/0jywhp7j2RkUYBnhonKLw==
X-Received: by 2002:a05:6871:4e90:b0:29d:ca24:c044 with SMTP id 586e51a60fabf-2c10f189ad6mr5008673fac.8.1740603955681;
        Wed, 26 Feb 2025 13:05:55 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c15c1ac7a3sm1467fac.30.2025.02.26.13.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 13:05:54 -0800 (PST)
Message-ID: <83c5a120-bb59-4b6a-a922-17a2c2436e5f@baylibre.com>
Date: Wed, 26 Feb 2025 15:05:52 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] iio: adc: ad7191: add AD7191
To: Alisa-Dariana Roman <alisadariana@gmail.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>,
 "Rob Herring (Arm)" <robh@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ramona Gradinariu <ramona.bolboaca13@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
References: <20250226115451.249361-1-alisa.roman@analog.com>
 <20250226115451.249361-3-alisa.roman@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250226115451.249361-3-alisa.roman@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/26/25 5:53 AM, Alisa-Dariana Roman wrote:
> AD7191 is a pin-programmable, ultra-low noise 24-bit sigma-delta ADC
> designed for precision bridge sensor measurements. It features two
> differential analog input channels, selectable output rates,
> programmable gain, internal temperature sensor and simultaneous
> 50Hz/60Hz rejection.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
>  MAINTAINERS              |   1 +
>  drivers/iio/adc/Kconfig  |  10 +
>  drivers/iio/adc/Makefile |   1 +
>  drivers/iio/adc/ad7191.c | 553 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 565 insertions(+)
>  create mode 100644 drivers/iio/adc/ad7191.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ac1f61256932..87c491975ced 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1352,6 +1352,7 @@ L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml
> +F:	drivers/iio/adc/ad7191.c
>  
>  ANALOG DEVICES INC AD7192 DRIVER
>  M:	Alisa-Dariana Roman <alisa.roman@analog.com>
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 27413516216c..b7ae6e0ae0df 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -142,6 +142,16 @@ config AD7173
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad7173.
>  
> +config AD7191
> +	tristate "Analog Devices AD7191 ADC driver"
> +	depends on SPI
> +	select AD_SIGMA_DELTA
> +	help
> +	  Say yes here to build support for Analog Devices AD7191.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ad7191.
> +
>  config AD7192
>  	tristate "Analog Devices AD7192 and similar ADC driver"
>  	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 9f26d5eca822..3e918c3eec69 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_AD7091R5) += ad7091r5.o
>  obj-$(CONFIG_AD7091R8) += ad7091r8.o
>  obj-$(CONFIG_AD7124) += ad7124.o
>  obj-$(CONFIG_AD7173) += ad7173.o
> +obj-$(CONFIG_AD7191) += ad7191.o
>  obj-$(CONFIG_AD7192) += ad7192.o
>  obj-$(CONFIG_AD7266) += ad7266.o
>  obj-$(CONFIG_AD7280) += ad7280a.o
> diff --git a/drivers/iio/adc/ad7191.c b/drivers/iio/adc/ad7191.c
> new file mode 100644
> index 000000000000..f1eff7d095df
> --- /dev/null
> +++ b/drivers/iio/adc/ad7191.c
> @@ -0,0 +1,553 @@
> +// SPDX-License-Identifier: GPL-2.0

Prefer GPL-2.0-only or GPL-2.0-or-later depending on your intention.

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

I think we tend to avoid including kernel.h since it includes way
more than we actually need.

> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/adc/ad_sigma_delta.h>
> +#include <linux/iio/iio.h>
> +
> +#define ad_sigma_delta_to_ad7191(sigmad)	\
> +	container_of((sigmad), struct ad7191_state, sd)
> +
> +#define AD7191_TEMP_CODES_PER_DEGREE	2815
> +
> +#define AD7191_EXT_CLK_ENABLE		0
> +#define AD7191_INT_CLK_ENABLE		1

Unused macros?

> +
> +#define AD7191_CHAN_MASK		BIT(0)
> +#define AD7191_TEMP_MASK		BIT(1)
> +
> +enum ad7191_channel {
> +	AD7191_CH_AIN1_AIN2,
> +	AD7191_CH_AIN3_AIN4,
> +	AD7191_CH_TEMP,
> +};
> +
> +/*
> + * NOTE:
> + * The AD7191 features a dual-use data out ready DOUT/RDY output.
> + * In order to avoid contentions on the SPI bus, it's therefore necessary
> + * to use SPI bus locking.
> + *
> + * The DOUT/RDY output must also be wired to an interrupt-capable GPIO.
> + *
> + * The SPI controller's chip select must be connected to the PDOWN pin
> + * of the ADC. When CS (PDOWN) is high, it powers down the device and
> + * resets the internal circuitry.
> + */
> +
> +struct ad7191_state {
> +	struct ad_sigma_delta		sd;
> +	struct mutex			lock; /* Protect device state */
> +
> +	struct gpio_descs		*odr_gpios;
> +	struct gpio_descs		*pga_gpios;
> +	struct gpio_desc		*temp_gpio;
> +	struct gpio_desc		*chan_gpio;
> +
> +	u16				int_vref_mv;
> +	const u32			(*scale_avail)[2];
> +	size_t				scale_avail_size;
> +	u32				scale_index;
> +	const u32			*samp_freq_avail;
> +	size_t				samp_freq_avail_size;
> +	u32				samp_freq_index;
> +
> +	struct clk			*mclk;
> +};
> +
> +static int ad7191_set_channel(struct ad_sigma_delta *sd, unsigned int address)
> +{
> +	struct ad7191_state *st = ad_sigma_delta_to_ad7191(sd);
> +	u8 temp_gpio_val, chan_gpio_val;
> +
> +	if (!FIELD_FIT(AD7191_CHAN_MASK | AD7191_TEMP_MASK, address))
> +		return -EINVAL;
> +
> +	chan_gpio_val = FIELD_GET(AD7191_CHAN_MASK, address);
> +	temp_gpio_val = FIELD_GET(AD7191_TEMP_MASK, address);
> +
> +	gpiod_set_value(st->chan_gpio, chan_gpio_val);
> +	gpiod_set_value(st->temp_gpio, temp_gpio_val);
> +
> +	return 0;
> +}
> +
> +static int ad7191_set_cs(struct ad_sigma_delta *sigma_delta, int assert)
> +{
> +	struct spi_transfer t = {
> +		.len = 0,
> +		.cs_change = assert,
> +	};
> +	struct spi_message m;
> +
> +	spi_message_init_with_transfers(&m, &t, 1);
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
> +		return ad7191_set_cs(&st->sd, 1);
> +	case AD_SD_MODE_IDLE:
> +		return ad7191_set_cs(&st->sd, 0);
> +	default:
> +		return -EINVAL;
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
> +static int ad7191_config_setup(struct iio_dev *indio_dev)
> +{
> +	struct ad7191_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->sd.spi->dev;
> +	/* Sampling frequencies in Hz, see Table 5 */
> +	static const u32 samp_freq[4] = { 120, 60, 50, 10 };
> +	/* Gain options, see Table 7 */
> +	const u32 gain[4] = { 1, 8, 64, 128 };
> +	static u32 scale_buffer[4][2];
> +	int odr_value, odr_index, pga_value, pga_index, i, ret;
> +	u64 scale_uv;
> +
> +	st->samp_freq_index = 0;
> +	st->scale_index = 0;
> +
> +	ret = device_property_read_u32(dev, "adi,odr-value", &odr_value);
> +	if (ret && ret != -EINVAL)
> +		return dev_err_probe(dev, ret, "Failed to get odr value.\n");
> +
> +	if (ret == -EINVAL) {
> +		st->odr_gpios = devm_gpiod_get_array(dev, "odr", GPIOD_OUT_LOW);
> +		if (IS_ERR(st->odr_gpios))
> +			return dev_err_probe(dev, PTR_ERR(st->odr_gpios),
> +					     "Failed to get odr gpios.\n");

Might also be worthwhile to check st->odr_gpios->ndescs to make sure we
have the right number.

> +
> +		st->samp_freq_avail = samp_freq;
> +		st->samp_freq_avail_size = ARRAY_SIZE(samp_freq);
> +	} else {
> +		for (i = 0; i < ARRAY_SIZE(samp_freq); i++) {
> +			if (odr_value != samp_freq[i])
> +				continue;
> +			odr_index = i;
> +			break;
> +		}
> +
> +		st->samp_freq_avail = &samp_freq[odr_index];
> +		st->samp_freq_avail_size = 1;
> +
> +		st->odr_gpios = NULL;
> +	}
> +
> +	mutex_lock(&st->lock);
> +
> +	for (i = 0; i < ARRAY_SIZE(scale_buffer); i++) {
> +		scale_uv = ((u64)st->int_vref_mv * NANO) >>
> +			(indio_dev->channels[0].scan_type.realbits - 1);
> +		do_div(scale_uv, gain[i]);
> +		scale_buffer[i][1] = do_div(scale_uv, NANO);
> +		scale_buffer[i][0] = scale_uv;

Just asthetics, but setting [0] before [1] seems more logical.

> +	}
> +
> +	mutex_unlock(&st->lock);
> +
> +	ret = device_property_read_u32(dev, "adi,pga-value", &pga_value);
> +	if (ret && ret != -EINVAL)
> +		return dev_err_probe(dev, ret, "Failed to get pga value.\n");
> +
> +	if (ret == -EINVAL) {
> +		st->pga_gpios = devm_gpiod_get_array(dev, "pga", GPIOD_OUT_LOW);
> +		if (IS_ERR(st->pga_gpios))
> +			return dev_err_probe(dev, PTR_ERR(st->pga_gpios),
> +					     "Failed to get pga gpios.\n");

Same comment about checking ndescs here.

> +
> +		st->scale_avail = scale_buffer;
> +		st->scale_avail_size = ARRAY_SIZE(scale_buffer);
> +	} else {
> +		for (i = 0; i < ARRAY_SIZE(gain); i++) {
> +			if (pga_value != gain[i])
> +				continue;
> +			pga_index = i;
> +			break;
> +		}
> +
> +		st->scale_avail = &scale_buffer[pga_index];
> +		st->scale_avail_size = 1;
> +
> +		st->pga_gpios = NULL;
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
> +	struct device *dev = &st->sd.spi->dev;
> +
> +	st->mclk = devm_clk_get_optional_enabled(dev, "mclk");
> +	if (IS_ERR(st->mclk))
> +		return dev_err_probe(dev, PTR_ERR(st->mclk),
> +				     "Failed to get mclk.\n");
> +
> +	return 0;
> +}
> +
> +static int ad7191_setup(struct iio_dev *indio_dev)
> +{
> +	struct ad7191_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = ad7191_init_regulators(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7191_config_setup(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	return ad7191_clock_setup(st);
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
> +		case IIO_VOLTAGE: {
> +			guard(mutex)(&st->lock);

I don't think the mutex helps here. The caller receives pointers to
these arrays and uses them _after_ this function returns so the mutex
will no longer be held while the arrays are actually being used.

As long as st->scale_avail is filled in during probe and never changes
after probe, we should not need to worry about any locking, so I think
it is OK to just drop the mutex from the driver.

> +			*val = st->scale_avail[st->scale_index][0];
> +			*val2 = st->scale_avail[st->scale_index][1];
> +			return IIO_VAL_INT_PLUS_NANO;
> +		}
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
> +		*val = st->samp_freq_avail[st->samp_freq_index];
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad7191_set_gain(struct ad7191_state *st, int gain_index)
> +{
> +	unsigned long value = gain_index;

Maybe a bit better style to not rely on implementation detail of bitmaps.
This can be replaced with:

	DECLARE_BITMAP(bitmap, 2) = { };

	bitmap_write(bitmap, gain_index, 0, 2);

> +
> +	st->scale_index = gain_index;
> +
> +	return gpiod_multi_set_value_cansleep(st->pga_gpios, &value);

	return gpiod_multi_set_value_cansleep(st->pga_gpios, bitmap);

> +}
> +
> +static int ad7191_set_samp_freq(struct ad7191_state *st, int samp_freq_index)
> +{
> +	unsigned long value = samp_freq_index;

ditto

> +
> +	st->samp_freq_index = samp_freq_index;
> +
> +	return gpiod_multi_set_value_cansleep(st->odr_gpios, &value);
> +}
> +
> +static int __ad7191_write_raw(struct ad7191_state *st,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	int i;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE: {
> +		if (!st->pga_gpios)
> +			return -EPERM;
> +		guard(mutex)(&st->lock);
> +		for (i = 0; i < st->scale_avail_size; i++) {
> +			if (val2 != st->scale_avail[i][1])
> +				continue;
> +			return ad7191_set_gain(st, i);

Could save a line by inverting the if and dropping the continue.

> +		}
> +		return -EINVAL;
> +	}
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		if (!st->odr_gpios)
> +			return -EPERM;
> +		guard(mutex)(&st->lock);
> +		for (i = 0; i < st->samp_freq_avail_size; i++) {
> +			if (val != st->samp_freq_avail[i])
> +				continue;
> +			return ad7191_set_samp_freq(st, i);
> +		}
> +		return -EINVAL;
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad7191_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int val, int val2,
> +			    long mask)
> +{
> +	struct ad7191_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = iio_device_claim_direct_mode(indio_dev);
> +	if (ret)
> +		return ret;

Jonathan's mass changes are in the togreg branch now, so we can do
the "new" way that works better with static checkers:

	if (!iio_device_claim_direct(indio_dev))
		return -EBUSY;

> +
> +	ret = __ad7191_write_raw(st, chan, val, val2, mask);
> +
> +	iio_device_release_direct_mode(indio_dev);

	iio_device_release_direct(indio_dev);

> +
> +	return ret;
> +}
> +
> +static int ad7191_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				    struct iio_chan_spec const *chan, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return IIO_VAL_INT_PLUS_NANO;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad7191_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, const int **vals,
> +			     int *type, int *length, long mask)
> +{
> +	struct ad7191_state *st = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals = (int *)st->scale_avail;
> +		*type = IIO_VAL_INT_PLUS_NANO;
> +		*length = st->scale_avail_size * 2;
> +		return IIO_AVAIL_LIST;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals = (int *)st->samp_freq_avail;
> +		*type = IIO_VAL_INT;
> +		*length = st->samp_freq_avail_size;
> +		return IIO_AVAIL_LIST;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static const struct iio_info ad7191_info = {
> +	.read_raw = ad7191_read_raw,
> +	.write_raw = ad7191_write_raw,
> +	.write_raw_get_fmt = ad7191_write_raw_get_fmt,
> +	.read_avail = ad7191_read_avail,
> +	.validate_trigger = ad_sd_validate_trigger,
> +};
> +
> +static const struct iio_chan_spec ad7191_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.address = AD7191_CH_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_OFFSET) |
> +				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 24,
> +			.storagebits = 32,
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
> +				      BIT(IIO_CHAN_INFO_OFFSET) |
> +				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = 1,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 24,
> +			.storagebits = 32,
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
> +				      BIT(IIO_CHAN_INFO_OFFSET) |
> +				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),
> +		.scan_index = 2,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 24,
> +			.storagebits = 32,
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
> +	ret = ad_sd_init(&st->sd, indio_dev, spi, &ad7191_sigma_delta_info);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_ad_sd_setup_buffer_and_trigger(dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7191_setup(indio_dev);
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

This could fit on one line.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad7191_of_match);
> +
> +static const struct spi_device_id ad7191_id_table[] = {
> +	{ "ad7191" },
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
> +	.id_table = ad7191_id_table,
> +};
> +module_spi_driver(ad7191_driver);
> +
> +MODULE_AUTHOR("Alisa-Dariana Roman <alisa.roman@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD7191 ADC");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(IIO_AD_SIGMA_DELTA);


