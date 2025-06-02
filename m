Return-Path: <linux-iio+bounces-20168-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85258ACB9EA
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 19:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8464026F9
	for <lists+linux-iio@lfdr.de>; Mon,  2 Jun 2025 16:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460AE226556;
	Mon,  2 Jun 2025 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dv3qoIOH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258D722424C
	for <linux-iio@vger.kernel.org>; Mon,  2 Jun 2025 16:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748883595; cv=none; b=nQKM08BlENuNQbZux3awQTLRtk03aS6NjQodMhGjo6fn4tBSBOS6IPVxEV75hm3Me9cAOXyzi3kMKqkiGA5uy5DwxPfkJy0x4TT2ZeDof4ixA2liEWlb8a+DjuSz0UG+D9C4ZoxlwIbTanwU/zPj3otGONo6297XiVAy5wBrvt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748883595; c=relaxed/simple;
	bh=hLCMau5YMSaezYEkZcAjhmTJs0p51SrcKofyLoyP440=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TczePxqFBcWZgHGcaaJE/R//7qhSkXf+6es6Y5JDDlpHwwB1luNXbrq+D4aisr969fwBK9JYfINhxv0A5vUbXhaZtVlBttRQokVrBUrDZPsGZwsASjRErCDqXRIj2nMekvcR0mXyuctnTQ7YYsaNlwT89R2rtRc5gjxv8gCo+/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dv3qoIOH; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-60658e1fedfso2462732eaf.2
        for <linux-iio@vger.kernel.org>; Mon, 02 Jun 2025 09:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748883590; x=1749488390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZJRDMPbYGvRNvOHiecbSgnd1erK2y/8jb60RJvda/SU=;
        b=dv3qoIOH0h8m+Pn2pxY8cb6KU+8AoQDSnjeGQ9ZgIsndpTlonW3CgbbbP87A4IYmRv
         ldp27SnTmJ7QhHkIR8XuGlHpHUNjfeUk7uwz8D7PoBexUNrCoBZZ/cnioFvgOY2TCu60
         0gXjexEz2if/U8L5VRyTf4oimLH6j6N4tWbe+/Co644JTvOfgyktgAqDW4Re3v4+ADWd
         sDXOAKBozExBm8onrG8ks/iXRw+vXUD39efxmyuMnDd7q3UVmsWW5YvHmG6m9hljePBY
         aS4UrCe2ckCh+OECSsGSc6ZgEWFsbECsI2IC/RQj/YhzuHI8j4RvW/sRDoAj2NFZg9vr
         TzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748883590; x=1749488390;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJRDMPbYGvRNvOHiecbSgnd1erK2y/8jb60RJvda/SU=;
        b=B62UoOz9dpwSekkomkWbeZLIs0X71Ts92vJVt8vr+ytQ1caC+hPDY1CeucVz0+FU/J
         iafFgIEOnQek7CPwMmT09JZJ+M38AD8p31osBFnDMtYOlmj9DDx4HOLDMDobKEPMHHOi
         gNzMAD6vBMU1pcxZQOW2lQohssRSKj7ao/sdo6xz8W9j61oPsZLw4ddsLF316hWTKQeq
         SE2tW+HxeqJsc9tPUL3+07t3bYT2atBgDvIhBZZ0aIFP/bMdJIhJ+xGLm3smeOgwvU/6
         9nRWPBq+rSjfgUMH1C8dZLUzLoCEa/+4bgJstnZftEQ3/e0GA1PwlQaHIZFWaMjv7UPx
         Xyzw==
X-Forwarded-Encrypted: i=1; AJvYcCUNclahOC1jmOCAhafy0UXFpCJaAJBUEGDycGs4cAtvlg8QzllXttK/dKzqAoDKNFZREUrVsMkBy3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkMfmvi9i32MQHd71PEz+UxsxuQg3hk1IHcn/dY/iPFYwVFvh8
	769K9ev/sq4MkIHO44uucXRK8rhHs59IWmOjbLwJ/H6NIGNcFf4GooJ8Dc4bxq48670=
X-Gm-Gg: ASbGncurkKZqCe77LHBcW9V7kyE+K/L2Ov36cuGPtw4V2lY6n060xFZP622Eojd+Gaq
	04JLbSORcrm7WQD34gyv3tNkW2Cg4+W4ycFc+hK/1BAbvlevrkkT9JRJpVY/SD8mbAImhB/nB5d
	M4B60xmaeFdZTiCzsfOoScOroeuBgxksSzp8aVtLeBhylWeoM64Obbat3706W3Cz7jxaEv3sDRe
	qRRRAocWP0VZ8sGYoD4FzUxAbXS64zpmCu2DyfKOHt6g0FdwRcCrUYsPQMB9T1ZsLv/ydFz/LS/
	RPwo8o2xYmMQulPUiLIUo2oEekMXTs9uOubSrNqKqfPsN6VhCzOvU2ZCtHXJZJsjU5WL0gQwz0h
	Ge3jzAVPJpvKeXCr6PGhdlZHFNykJ
X-Google-Smtp-Source: AGHT+IGQwFXBT/2VEHi6WvcZQOXd5gzFS9vQRZKOYXx2obpDoZmVJN74wDAhDg3cd0XCPg1AOp9EdQ==
X-Received: by 2002:a05:6871:878f:b0:2c2:3eb4:e53 with SMTP id 586e51a60fabf-2e9216a6b5emr7938765fac.37.1748883590051;
        Mon, 02 Jun 2025 09:59:50 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:74f4:5886:86e1:3bcf? ([2600:8803:e7e4:1d00:74f4:5886:86e1:3bcf])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2e906c213e0sm1875447fac.47.2025.06.02.09.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 09:59:49 -0700 (PDT)
Message-ID: <f582c6fd-6216-4f6f-8024-ae4a0d28fbbb@baylibre.com>
Date: Mon, 2 Jun 2025 11:59:48 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] iio: adc: ad7405: add ad7405 driver
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Tobias Sperling <tobias.sperling@softing.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250602134349.1930891-1-pop.ioan-daniel@analog.com>
 <20250602134349.1930891-6-pop.ioan-daniel@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250602134349.1930891-6-pop.ioan-daniel@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/2/25 8:43 AM, Pop Ioan Daniel wrote:
> Add support for the AD7405/ADUM770x, a high performance isolated ADC,
> 1-channel, 16-bit with a second-order Σ-Δ modulator that converts an
> analog input signal into a high speed, single-bit data stream.
> 
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> ---
> changes in v5:
>  - add range checking for dec_rate
>  - remove ad7405_get_scale function
>  - check for negative values in ad7405_write_raw function
>  - remove unuseful comment
>  - remove indio_dev -> dev.parent = dev
>  - fix IIO_CHAN_INFO_OFFSET
>  - add struct mutex lock
>  drivers/iio/adc/Kconfig  |  10 ++
>  drivers/iio/adc/Makefile |   1 +
>  drivers/iio/adc/ad7405.c | 256 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 267 insertions(+)
>  create mode 100644 drivers/iio/adc/ad7405.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index ad06cf556785..43af2070e27f 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -251,6 +251,16 @@ config AD7380
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad7380.
>  
> +config AD7405
> +	tristate "Analog Device AD7405 ADC Driver"
> +	depends on IIO_BACKEND
> +	help
> +	  Say yes here to build support for Analog Devices AD7405, ADUM7701,
> +	  ADUM7702, ADUM7703 analog to digital converters (ADC).
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called ad7405.
> +
>  config AD7476
>  	tristate "Analog Devices AD7476 1-channel ADCs driver and other similar devices from AD and TI"
>  	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 07d4b832c42e..8115f30b7862 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_AD7291) += ad7291.o
>  obj-$(CONFIG_AD7292) += ad7292.o
>  obj-$(CONFIG_AD7298) += ad7298.o
>  obj-$(CONFIG_AD7380) += ad7380.o
> +obj-$(CONFIG_AD7405) += ad7405.o
>  obj-$(CONFIG_AD7476) += ad7476.o
>  obj-$(CONFIG_AD7606_IFACE_PARALLEL) += ad7606_par.o
>  obj-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
> diff --git a/drivers/iio/adc/ad7405.c b/drivers/iio/adc/ad7405.c
> new file mode 100644
> index 000000000000..6199a6661ff5
> --- /dev/null
> +++ b/drivers/iio/adc/ad7405.c
> @@ -0,0 +1,256 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices AD7405 driver
> + *
> + * Copyright 2025 Analog Devices Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/util_macros.h>
> +#include <linux/mutex.h>
> +
> +#include <linux/iio/backend.h>
> +#include <linux/iio/iio.h>
> +
> +static const unsigned int ad7405_dec_rates[] = {
> +	4096, 2048, 1024, 512, 256, 128, 64, 32,
> +};

It looks lilke this should be a range, not a list. The driver
currently allows any value to be passed to the backend, not
just these values.

Or if these are the only values that make sense for this
ADC chip even if the backend allows other values, then
we should do more checking in this driver to ensure only
these values can be passed to the backend.

> +
> +struct ad7405_chip_info {
> +	const char *name;
> +	struct iio_chan_spec channel;
> +	const unsigned int full_scale_mv;
> +};
> +
> +struct ad7405_state {
> +	struct iio_backend *back;
> +	const struct ad7405_chip_info *info;
> +	/*
> +	 *Synchronize access to members the of driver state, and ensure
> +	 *atomicity of consecutive regmap operations.

There is no regmap.

> +	 */
> +	struct mutex lock;

This is never initalized.

> +	unsigned int ref_frequency;
> +	unsigned int dec_rate;
> +};
> +
> +static int ad7405_set_dec_rate(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       unsigned int dec_rate)
> +{
> +	struct ad7405_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	guard(mutex)(&st->lock);

Why not iio_device_claim_direct() instead? Seems like it could be
probalamatic if this was changed in the middle of a buffered read.

> +
> +	if (dec_rate > 4096 || dec_rate < 32)
> +		return -EINVAL;
> +
> +	ret = iio_backend_oversampling_ratio_set(st->back, chan->scan_index, dec_rate);
> +	if (ret)
> +		return ret;
> +
> +	st->dec_rate = dec_rate;
> +
> +	return 0;
> +}
> +
> +static int ad7405_read_raw(struct iio_dev *indio_dev,
> +			   const struct iio_chan_spec *chan, int *val,
> +			   int *val2, long info)
> +{
> +	struct ad7405_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = st->info->full_scale_mv;
> +		*val2 = st->info->channel.scan_type.realbits - 1;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*val = st->dec_rate;
> +		guard(mutex)(&st->lock);

Taking the mutex here does nothing. Maybe it was meant to go before
*val = st->dec_rate;

But I'm not sure that is really necessary. 

> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = DIV_ROUND_CLOSEST_ULL(st->ref_frequency, st->dec_rate);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = -(1 << (st->info->channel.scan_type.realbits - 1));
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad7405_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int val,
> +			    int val2, long info)
> +{
> +	switch (info) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		if (val < 0)
> +			return -EINVAL;
> +		return ad7405_set_dec_rate(indio_dev, chan, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad7405_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type, int *length,
> +			     long info)
> +{
> +	switch (info) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*vals = ad7405_dec_rates;
> +		*length = ARRAY_SIZE(ad7405_dec_rates);
> +		*type = IIO_VAL_INT;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info ad7405_iio_info = {
> +	.read_raw = &ad7405_read_raw,
> +	.write_raw = &ad7405_write_raw,
> +	.read_avail = &ad7405_read_avail,
> +};
> +
> +#define AD7405_IIO_CHANNEL {					\
> +	.type = IIO_VOLTAGE,					\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
> +			BIT(IIO_CHAN_INFO_OFFSET),		\
> +	.info_mask_shared_by_all = IIO_CHAN_INFO_SAMP_FREQ |	\
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
> +	.info_mask_shared_by_all_available =			\
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
> +	.indexed = 1,						\
> +	.channel = 0,						\
> +	.channel2 = 1,						\
> +	.differential = 1,					\
> +	.scan_index = 0,					\
> +	.scan_type = {						\
> +		.sign = 'u',					\
> +		.realbits = 16,					\
> +		.storagebits = 16,				\
> +	},							\
> +}
> +
> +static const struct ad7405_chip_info ad7405_chip_info = {
> +	.name = "AD7405",

In all the other ADI drivers, the name is lower case, so we should
to the same here to be consistent.

> +	.full_scale_mv = 320,
> +	.channel = AD7405_IIO_CHANNEL,
> +};
> +
> +static const struct ad7405_chip_info adum7701_chip_info = {
> +	.name = "ADUM7701",
> +	.full_scale_mv = 320,
> +	.channel = AD7405_IIO_CHANNEL,
> +};
> +
> +static const struct ad7405_chip_info adum7702_chip_info = {
> +	.name = "ADUM7702",
> +	.full_scale_mv = 64,
> +	.channel = AD7405_IIO_CHANNEL,
> +};
> +
> +static const struct ad7405_chip_info adum7703_chip_info = {
> +	.name = "ADUM7703",
> +	.full_scale_mv = 320,
> +	.channel = AD7405_IIO_CHANNEL,
> +};
> +
> +static const char * const ad7405_power_supplies[] = {
> +	"vdd1",	"vdd2",
> +};
> +
> +static int ad7405_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad7405_state *st;
> +	struct clk *clk;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	st->info = device_get_match_data(dev);
> +	if (!st->info)
> +		return dev_err_probe(dev, -EINVAL, "no chip info\n");
> +
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ad7405_power_supplies),
> +					     ad7405_power_supplies);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get and enable supplies");
> +
> +	clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	st->ref_frequency = clk_get_rate(clk);
> +	if (!st->ref_frequency)
> +		return -EINVAL;
> +
> +	indio_dev->name = st->info->name;
> +	indio_dev->channels = &st->info->channel;
> +	indio_dev->num_channels = 1;
> +	indio_dev->info = &ad7405_iio_info;
> +
> +	st->back = devm_iio_backend_get(dev, NULL);
> +	if (IS_ERR(st->back))
> +		return dev_err_probe(dev, PTR_ERR(st->back),
> +				     "failed to get IIO backend");
> +
> +	ret = iio_backend_chan_enable(st->back, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_backend_enable(dev, st->back);
> +	if (ret)
> +		return ret;
> +

Would not hurt to have a comment explaining why 256 is chosen for the
default value.

> +	ret = ad7405_set_dec_rate(indio_dev, &indio_dev->channels[0], 256);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct of_device_id ad7405_of_match[] = {
> +	{ .compatible = "adi,ad7405", .data = &ad7405_chip_info, },
> +	{ .compatible = "adi,adum7701", .data = &adum7701_chip_info, },
> +	{ .compatible = "adi,adum7702", .data = &adum7702_chip_info, },
> +	{ .compatible = "adi,adum7703", .data = &adum7703_chip_info, },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad7405_of_match);
> +
> +static struct platform_driver ad7405_driver = {
> +	.driver = {
> +		.name = "ad7405",
> +		.owner = THIS_MODULE,
> +		.of_match_table = ad7405_of_match,
> +	},
> +	.probe = ad7405_probe,
> +};
> +module_platform_driver(ad7405_driver);
> +
> +MODULE_AUTHOR("Dragos Bogdan <dragos.bogdan@analog.com>");
> +MODULE_AUTHOR("Pop Ioan Daniel <pop.ioan-daniel@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD7405 driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_BACKEND");


