Return-Path: <linux-iio+bounces-26388-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4D7C7D421
	for <lists+linux-iio@lfdr.de>; Sat, 22 Nov 2025 17:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 097B14E0F50
	for <lists+linux-iio@lfdr.de>; Sat, 22 Nov 2025 16:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2C428C84A;
	Sat, 22 Nov 2025 16:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TpAKt8VQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7D72773D9
	for <linux-iio@vger.kernel.org>; Sat, 22 Nov 2025 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763830328; cv=none; b=XpWUyVDbHMaFrtRRm+54wsCE083N65DxHCf1G7xa2PqqDv7oMnwWHbcbC48Btfvb0ikQ+Puz4WyMK+n08jU3Vgg+JcR5rvPxyalTaY2wA6nI9HJupSW0Gpqp+v2MYYL2h53kMdbsINrFQmPU4BxgpE/O7AvIixmr6vUq+Sv+jkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763830328; c=relaxed/simple;
	bh=nGheMCBm4X7XH3dYoS6fRfFcwblqlpoRtoJlx7coLJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Mw+cxxk+pj1fIsMY6iblUJbP4veLVdmlv1aL2vk7mh2fxn9ShxsJWn4+NU3wGYDPg9c3HbPmgxJJlbdYrO7H+8s5nxoYRkLT630HU/BHFuMNVYWDtoNoOwuy5LgHIr7Hz+1qKcSn9jIs7DpbEgnVRsyDg+kRcU9RuYzdLVM3p8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TpAKt8VQ; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7c71cca8fc2so1793839a34.1
        for <linux-iio@vger.kernel.org>; Sat, 22 Nov 2025 08:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763830324; x=1764435124; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sh8hHOP9drovdg2rt4Vvr6IFk9L/VFH0Ch9O0TTw990=;
        b=TpAKt8VQuEiDOqSC7eVoeTXjzBumJrEmbmr0L+5S0LbfyZRO1kxxCQPrbs0NO5zL6f
         Xx3kq8CWz+L2gAAIWIo3caHkinni75OekZvhKdFIkosxmPSzm/4rC3YTVPVM9GS5bMEh
         xsIozaG6CH2lA7t6Iwsd3yUprikpCwtSpS4ZQF1x0J1zTRfP2FvRgxqLrOnwS5EZISFv
         0KfewPwF4/BUPVwLdYWMRNOoTUvf8MEOsISAwI0LwuAiIXt2kgGNLTI7Ii/k1zSXzgZX
         ft5TRORLysNnleDl35njfVrMVgRPIdGYugzEOeHBjv9QKvMryJxHCYQn7lkb7cvBsCkf
         49FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763830324; x=1764435124;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sh8hHOP9drovdg2rt4Vvr6IFk9L/VFH0Ch9O0TTw990=;
        b=sDUijYzBv2LCiFpqYL6se5cshYklioSv4JkcqneXorZWQj1u/BExcXAg/xAsgQLn/c
         1lZYroNKW9JzEalKRYJNPrzaHWgD2b5cAj6bf06JG4ZOUwkfjOfCrRmdQL/L6qhQUUs1
         solBQSI4AaxlSeeYgK06414zrkMvSeWpfcqoqz5uzDXVdHiJ25fpwPrHhZI6YyvIzV4P
         7i1j4+p6ZAajdIcoB6frgGfTroqvqaqyApBP9y094IGtMQ8yM+8A5OQ8qK1xfkeWgOpE
         3lBDtd6IMblNMhX/NqWb5MeVuMDFZ4Vif0dgDupbKyxL1suBQg2MazyJEpaklHtl3jb1
         L+Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVZ7FkzZ3/6V7t/QojhoUJ/zBY2toFHi2CqMFGk2/dKLARt/mqQNvPWp5BImKwQboUpES/RcUm1/60=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPKlmS8BSWn/IaH4UOlLU5KF61sdRvSSikhS6RxVQbeEM4vOWS
	ZcaLIci9d4G6udfMVwDcmRa/2auZQgHbc0r0c+maR6J92M/nntD5BMAUAw2wGffFpv4=
X-Gm-Gg: ASbGnctW3Ogu2YplYkE61Sg5pwWwrZzkH+OqR5CJFqmKFWj4j30YaxXbGGPWeHUJ39L
	CkfX0llAh/Icr8i1X+CQFJD+6i9HphuVWrMTs8NUAslAid+Ea7SdF+tZ5IIrUM05tLcnOzX33rH
	+0AA+K9qM6BtsAaYq/v5q9vqnhh1E9bBFV1ZC7TF38YxCsD62uDmZwA47UHfbun/deVp4fxd9wu
	ICggf9/RJRxYW/AjZVfXsIya779NOojZNKX8zENCG9BlOqeSM85Zhc/CoLQTtAbmdHWjjA1YGW9
	A5y/2dThQnBJRbS4OUdvhe0yvbnVIOsByZpWyKhpqxK0pEfy3cbOxRv1c1uSkcHLLCCbB48o1u9
	WkJEJAfn8jF5mGdp3I7N9UjiO1sZ5ZmBvKPTicUjM82wYJJZdv+UqQ7h+817xekFMF20DOskI7R
	p3m9i4ighHGM/wkh5+bAyshGjNseGkFYgIq3TCD05LtpU+2DqiyPRffJ6IYBp6
X-Google-Smtp-Source: AGHT+IHa/+72L6QVdDNfQguUxKv6/KAvvwPNWGbh2YzhtqwmZUQcLI9Z8RvvWR2PM29rkEMtk6Csaw==
X-Received: by 2002:a05:6830:43ab:b0:7c6:ca92:3621 with SMTP id 46e09a7af769-7c798db1dfdmr3366576a34.22.1763830323867;
        Sat, 22 Nov 2025 08:52:03 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:e782:93d8:7c2f:f9df? ([2600:8803:e7e4:500:e782:93d8:7c2f:f9df])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c78d32cbd9sm3523534a34.11.2025.11.22.08.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Nov 2025 08:52:02 -0800 (PST)
Message-ID: <68452dcc-027a-4170-b9f5-2b064972b618@baylibre.com>
Date: Sat, 22 Nov 2025 10:52:00 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] iio: amplifiers: adl8113: add driver support
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251121095204.18574-1-antoniu.miclaus@analog.com>
 <20251121095204.18574-3-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20251121095204.18574-3-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/25 3:52 AM, Antoniu Miclaus wrote:
> Add support for adl8113 10MHz to 12GHz Low Noise Amplifier with
> 10MHz to 14GHz bypass switches.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> 
> Changes in v4:
> - Replace signal_path sysfs attribute with hardwaregain-only control
> - Add support for external bypass amplifiers via DT properties
> - Introduce dynamic gain configuration system with adl8113_gain_config structure
> ---
>  drivers/iio/amplifiers/Kconfig   |  12 ++
>  drivers/iio/amplifiers/Makefile  |   1 +
>  drivers/iio/amplifiers/adl8113.c | 277 +++++++++++++++++++++++++++++++
>  3 files changed, 290 insertions(+)
>  create mode 100644 drivers/iio/amplifiers/adl8113.c
> 
> diff --git a/drivers/iio/amplifiers/Kconfig b/drivers/iio/amplifiers/Kconfig
> index 55eb16b32f6c..a8a604863eed 100644
> --- a/drivers/iio/amplifiers/Kconfig
> +++ b/drivers/iio/amplifiers/Kconfig
> @@ -36,6 +36,18 @@ config ADA4250
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ada4250.
>  
> +config ADL8113
> +	tristate "Analog Devices ADL8113 Low Noise Amplifier"
> +	depends on GPIOLIB
> +	help
> +	  Say yes here to build support for Analog Devices ADL8113 Low Noise
> +	  Amplifier with integrated bypass switches. The device supports four
> +	  operation modes controlled by GPIO pins: internal amplifier,
> +	  internal bypass, and two external bypass modes.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called adl8113.
> +
>  config HMC425
>  	tristate "Analog Devices HMC425A and similar GPIO Gain Amplifiers"
>  	depends on GPIOLIB
> diff --git a/drivers/iio/amplifiers/Makefile b/drivers/iio/amplifiers/Makefile
> index 2126331129cf..0a76443be1aa 100644
> --- a/drivers/iio/amplifiers/Makefile
> +++ b/drivers/iio/amplifiers/Makefile
> @@ -6,4 +6,5 @@
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AD8366) += ad8366.o
>  obj-$(CONFIG_ADA4250) += ada4250.o
> +obj-$(CONFIG_ADL8113) += adl8113.o
>  obj-$(CONFIG_HMC425) += hmc425a.o
> diff --git a/drivers/iio/amplifiers/adl8113.c b/drivers/iio/amplifiers/adl8113.c
> new file mode 100644
> index 000000000000..118789aa2c19
> --- /dev/null
> +++ b/drivers/iio/amplifiers/adl8113.c
> @@ -0,0 +1,277 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ADL8113 Low Noise Amplifier with integrated bypass switches
> + *
> + * Copyright 2025 Analog Devices Inc.
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +
> +enum adl8113_signal_path {
> +	ADL8113_INTERNAL_AMP,
> +	ADL8113_INTERNAL_BYPASS,
> +	ADL8113_EXTERNAL_A,
> +	ADL8113_EXTERNAL_B,
> +};
> +
> +struct adl8113_gain_config {
> +	enum adl8113_signal_path path;
> +	int gain_db;
> +	int va;
> +	int vb;
> +};
> +
> +struct adl8113_state {
> +	struct gpio_desc *gpio_va;
> +	struct gpio_desc *gpio_vb;
> +	struct adl8113_gain_config *gain_configs;
> +	int num_gain_configs;
> +	enum adl8113_signal_path current_path;
> +};
> +
> +static const char * const adl8113_supply_names[] = {
> +	"vdd1",
> +	"vdd2",
> +	"vss2"
> +};

Datasheet says recommended power on sequence is VDD_SW, VSS, VDD_PA.
Don't know why they used different names for just that one section
in the datasheet, but at least vss2 should go in the middle. Not
sure which VSS is which though.

> +
> +static int adl8113_set_path(struct adl8113_state *st,
> +			    enum adl8113_signal_path path)
> +{
> +	int va, vb;
> +
> +	/* Determine GPIO values based on signal path */
> +	switch (path) {
> +	case ADL8113_INTERNAL_AMP:
> +		va = 0; vb = 0; /* Internal amplifier */
> +		break;
> +	case ADL8113_INTERNAL_BYPASS:
> +		va = 1; vb = 1; /* Internal bypass */
> +		break;
> +	case ADL8113_EXTERNAL_A:
> +		va = 0; vb = 1; /* External bypass A */
> +		break;
> +	case ADL8113_EXTERNAL_B:
> +		va = 1; vb = 0; /* External bypass B */
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

This could be simplified by using a gpiod array.

> +
> +	gpiod_set_value(st->gpio_va, va);
> +	gpiod_set_value(st->gpio_vb, vb);

This doesn't need to be atomic, so we can use the _cansleep() versions of
the gpio functions.

> +	st->current_path = path;
> +	return 0;
> +}
> +
> +static int adl8113_find_gain_config(struct adl8113_state *st, int gain_db)
> +{
> +	int i;
> +
> +	for (i = 0; i < st->num_gain_configs; i++) {
> +		if (st->gain_configs[i].gain_db == gain_db)
> +			return i;
> +	}
> +	return -EINVAL;
> +}
> +
> +static const struct iio_chan_spec adl8113_channels[] = {
> +	{
> +		.type = IIO_VOLTAGE,
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_HARDWAREGAIN),
> +		.indexed = 1,
> +		.channel = 0,

.indexed and .channel have no effect for shared_by_type so can be
omitted.

> +	},
> +};
> +
> +static int adl8113_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct adl8113_state *st = iio_priv(indio_dev);
> +	int i;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		/* Find current gain configuration */
> +		for (i = 0; i < st->num_gain_configs; i++) {
> +			if (st->gain_configs[i].path == st->current_path) {
> +				*val = st->gain_configs[i].gain_db;
> +				*val2 = 0;
> +				return IIO_VAL_INT_PLUS_MICRO_DB;
> +			}
> +		}
> +		return -EINVAL;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int adl8113_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct adl8113_state *st = iio_priv(indio_dev);
> +	int config_idx;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_HARDWAREGAIN:
> +		if (val2 != 0)
> +			return -EINVAL;
> +
> +		config_idx = adl8113_find_gain_config(st, val);
> +		if (config_idx < 0)
> +			return -EINVAL;

			return config_idx; 

would be more typical.

> +
> +		return adl8113_set_path(st, st->gain_configs[config_idx].path);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info adl8113_info = {
> +	.read_raw = adl8113_read_raw,
> +	.write_raw = adl8113_write_raw,
> +};
> +
> +static int adl8113_init_gain_configs(struct device *dev, struct adl8113_state *st)
> +{
> +	int external_a_gain, external_b_gain;
> +	int num_configs = 2; /* Always have internal amp and internal bypass */
> +	int i = 0;
> +
> +	/* Check for optional external bypass amplifier gains */
> +	if (!device_property_read_u32(dev, "adi,external-bypass-a-gain-db",
> +				      &external_a_gain))

Looks like we could just use device_property_present() here.

> +		num_configs++;
> +
> +	if (!device_property_read_u32(dev, "adi,external-bypass-b-gain-db",
> +				      &external_b_gain))
> +		num_configs++;
> +
> +	st->gain_configs = devm_kcalloc(dev, num_configs,
> +					sizeof(*st->gain_configs), GFP_KERNEL);
> +	if (!st->gain_configs)
> +		return -ENOMEM;
> +
> +	/* Always include internal amplifier (14dB) */
> +	st->gain_configs[i].path = ADL8113_INTERNAL_AMP;
> +	st->gain_configs[i].gain_db = 14;
> +	i++;
> +
> +	/* Always include internal bypass (0dB) */
> +	st->gain_configs[i].path = ADL8113_INTERNAL_BYPASS;
> +	st->gain_configs[i].gain_db = 0;

The datasheet says there is actually a loss here. In one place it
says 2.2dB and in another 1.8db.

So it would make sense for this to be -2.

> +	i++;
> +
> +	/* Add external bypass A if configured */
> +	if (!device_property_read_u32(dev, "adi,external-bypass-a-gain-db",
> +				      &external_a_gain)) {
> +		st->gain_configs[i].path = ADL8113_EXTERNAL_A;
> +		st->gain_configs[i].gain_db = external_a_gain;
> +		i++;
> +	}
> +
> +	/* Add external bypass B if configured */
> +	if (!device_property_read_u32(dev, "adi,external-bypass-b-gain-db",
> +				      &external_b_gain)) {
> +		st->gain_configs[i].path = ADL8113_EXTERNAL_B;
> +		st->gain_configs[i].gain_db = external_b_gain;
> +		i++;
> +	}
> +
> +	st->num_gain_configs = num_configs;

The datasheet mentioned switching to a bypass with nothing connected for
testing, so it could make sense that if there is a free config, add one
more with gain of INT_MIN (for near-infinite attenuation) to allow that
if needed.

> +
> +	/* Check for duplicate gain values */
> +	for (i = 0; i < num_configs - 1; i++) {
> +		for (int j = i + 1; j < num_configs; j++) {

This type of inline variable declaration is usually avoided in the kernel.

> +			if (st->gain_configs[i].gain_db == st->gain_configs[j].gain_db) {
> +				dev_err(dev, "Duplicate gain values not allowed: %d dB\n",
> +					st->gain_configs[i].gain_db);
> +				return -EINVAL;

Should be OK to use dev_err_probe() here.

> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int adl8113_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct adl8113_state *st;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	st->gpio_va = devm_gpiod_get(dev, "va", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->gpio_va))
> +		return dev_err_probe(dev, PTR_ERR(st->gpio_va),
> +				     "failed to get VA GPIO\n");
> +
> +	st->gpio_vb = devm_gpiod_get(dev, "vb", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->gpio_vb))
> +		return dev_err_probe(dev, PTR_ERR(st->gpio_vb),
> +				     "failed to get VB GPIO\n");
> +
> +	ret = devm_regulator_bulk_get_enable(dev,
> +					     ARRAY_SIZE(adl8113_supply_names),
> +					     adl8113_supply_names);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to get and enable supplies\n");
> +
> +	/* Initialize gain configurations from devicetree */
> +	ret = adl8113_init_gain_configs(dev, st);
> +	if (ret)
> +		return ret;
> +
> +	/* Initialize to internal amplifier path (14dB) */
> +	ret = adl8113_set_path(st, ADL8113_INTERNAL_AMP);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->info = &adl8113_info;
> +	indio_dev->name = "adl8113";
> +	indio_dev->channels = adl8113_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(adl8113_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;

This doesn't do single conversions, so no INDIO_DIRECT_MODE (or any
other mode).

> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct of_device_id adl8113_of_match[] = {
> +	{ .compatible = "adi,adl8113" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, adl8113_of_match);
> +
> +static struct platform_driver adl8113_driver = {
> +	.driver = {
> +		.name = "adl8113",
> +		.of_match_table = adl8113_of_match,
> +	},
> +	.probe = adl8113_probe,
> +};
> +
> +module_platform_driver(adl8113_driver);
> +
> +MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices ADL8113 Low Noise Amplifier");
> +MODULE_LICENSE("GPL");


