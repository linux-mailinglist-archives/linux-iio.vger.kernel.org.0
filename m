Return-Path: <linux-iio+bounces-19598-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F4AAB9F80
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 17:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 552801712DE
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 15:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1541A5BBA;
	Fri, 16 May 2025 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NWpl4Eyj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EE9A32
	for <linux-iio@vger.kernel.org>; Fri, 16 May 2025 15:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747408088; cv=none; b=XM0t6JZzKAGzwTcs1wvQ9hmAntGodAaOyM70YLFGdUORESTq6fDlI3OIkBz1OtoNDjTcnV845OmGapBnEH8bOJ2gZAbDg0Yj2ZeyhM5Ar+YGEliJKcTt7RhBGUrOEoDVnxHoxfxa4/fc5/uPJ0JcoqWdTtad8B1joUe4Lw38ScQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747408088; c=relaxed/simple;
	bh=+C9rliT9maPpOK+GxOt04e2p68bMN3HFz26gAv08lBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RrWP4KP96T1PpjQGcnKfGCJXAEb8XiLFOXgzlq4iy5L6wustl7p64ious104tyYyLswrQ17dEu6eSKx6Ue4juTnpuFFbtD5koRSejmlMgeVY02whGLZdeqFrLxI55P0/vGxHSoQ6iQNj1eFVZ6uJ/VnF6uthJwQ5eKEjAyWRdlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NWpl4Eyj; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2c76a1b574cso108943fac.2
        for <linux-iio@vger.kernel.org>; Fri, 16 May 2025 08:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747408085; x=1748012885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FcGygX5l2vdAVsI9oNrygA+RGWDoDNg1xUQgMWaAqhY=;
        b=NWpl4EyjzlmCIDauezvHz3H4Op4RtkJXh3/ZtbXs1l2kXHdLwjULsI24kX0ZZIlK7H
         hC+QoAL5pkm2b4oZ/TKYDQAs1Uzn3KL11TgXMoZy6HrgtDm2VOOhxGS/HEoiU4d7NwnJ
         H0HZMmbthXTWxhdFiihKI52Wx+OTwTIlW8t/2OAT6FIDkY2BDgCSeDaAOlWAWOlujAS4
         exf2YIZo6tcaAz75oJxEyhEfTFSy6rM29RbYIg5ZYHYXx7H2W2CMdRU2jS+CRFzavrD7
         P7xNN6O5qy/RFK9wxQdRdvZwn5+UjHB11r7JsDnsJQnB84D8X9wRqqtEGqSmjReuy6AP
         MU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747408085; x=1748012885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FcGygX5l2vdAVsI9oNrygA+RGWDoDNg1xUQgMWaAqhY=;
        b=hf7K0shl8Kd1BWlqBFX9DOEz1NFalZ3EblITi6GS3ZiBnCZTcP/on48Dp2zj6lFgtt
         z1L2L9DKwqm+IYEvA7FIn9vsOeOh8ZMtctdLszpoXXFdGxp2WhKGNpFhRBWgvnqZyUwG
         st4KpnVXxZRcQa1tcrZTrHgUaBdQiCtgwRHx6fVZ3Jp3DS2x1SbhOPvfmnMc7w6wW6z4
         E/OQgdEzQkx03WP4LzCdgmn9CfsCniXuez8IWWD45N6QGfs1dl2vwo1N/uQDs2yT154S
         2NAbEACUDw2BfCl1atB2tJpb/3xxZPr/aLOkXJfsTEWXkJwl87f0N/VVd5Oa0nuKmLIy
         RR6g==
X-Forwarded-Encrypted: i=1; AJvYcCXilDULYFbIANmPRMvf8cmBjnAQJo700qqwT0VlVPyp8FIvf+V9nugVpck+TiiyXq4rKDI0YqO3RqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9dr5UNftgYfC8laPzBF7stSuPAxN+186iXHQZX/7ZfRChTHg0
	iqG5xZm4v/bsAlUVm9RTWTVtwElednyc0Rh1l7Ty8pP7u/bP/yeI2dz0f7eSjtEfqdI=
X-Gm-Gg: ASbGncs0mznzMbMaKLzYhBIdLyqg8gIC2BEdlKfC1onooNjI8n3ZS68GEGwN/QbDysB
	g91bIgq+yA7pU5AXlT1mzA1nKpDYI2yGeyDlVMbfqMm/68xlMNxriXOQlaGHC54E5ZdQsgDUkpk
	1XTbWEaxoBPeYidzcerr89Gv0jB3t4+MmJ6zkimyss8C1uU4YjlewpbMcWu3WsHlq61/9j3rbYP
	PL00WY0ltOiLwcPCFjkUG/ZI/K4y+LyX1ZNVugO0w64X0kOW3gHbuvboVm9ieJxrIhDIX08KrVB
	hQ4Dx1MChoIVY5pspUXN3svfD0vXh8j6YiyNEKgMrqkLZXQARHI0DfKT6AeC+FZj3fZr2V1mx/K
	wvueY33q5tHnm7AdrAWLM/5BYrtIP+shyUGcc
X-Google-Smtp-Source: AGHT+IGWNv56q5Riz1yHs8SwNE/HTEU8+7oaotMCudi13efC0XmFU7Vb8h1emD165glwN0/lsRuhrQ==
X-Received: by 2002:a05:6871:d285:b0:2c1:650b:fc86 with SMTP id 586e51a60fabf-2e3c8171a44mr1515082fac.1.1747408084646;
        Fri, 16 May 2025 08:08:04 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:d2f:9b08:7c22:3090? ([2600:8803:e7e4:1d00:d2f:9b08:7c22:3090])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-734f6a82109sm376154a34.28.2025.05.16.08.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 08:08:04 -0700 (PDT)
Message-ID: <ef807996-af5b-4b53-a81b-931ae49a6214@baylibre.com>
Date: Fri, 16 May 2025 10:08:03 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] iio: adc: ad7405: add ad7405 driver
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
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Esteban Blanc <eblanc@baylibre.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250516105810.3028541-1-pop.ioan-daniel@analog.com>
 <20250516105810.3028541-5-pop.ioan-daniel@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250516105810.3028541-5-pop.ioan-daniel@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/16/25 5:58 AM, Pop Ioan Daniel wrote:
> Add support for the AD7405/ADUM770x, a high performance isolated ADC,
> 1-channel, 16-bit with a second-order Σ-Δ modulator that converts an
> analog input signal into a high speed, single-bit data stream.
> 
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> ---
> changes in v3:
>  - edit ad7405_chip_info struct instances
>  - remove lock
>  - add implementation for IIO_CHAN_INFO_SCALE
>  - use IIO_CHAN_INFO_OVERSAMPLING_RATIO for controlling the decimation rate
>  - use IIO_CHAN_INFO_SAMP_FREQ for read-only
>  - remove dem_clk_get_enabled() function
>  - remove chip_info variable from probe function
>  - fix indentation
>  - remove max_rate
>  - rename ad7405_set_sampling_rate in ad7405_det_dec_rate
> add adum7702 and adum7703 chip_info
>  drivers/iio/adc/Kconfig  |  10 ++
>  drivers/iio/adc/Makefile |   1 +
>  drivers/iio/adc/ad7405.c | 276 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 287 insertions(+)
>  create mode 100644 drivers/iio/adc/ad7405.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index ad06cf556785..6ed1042636d9 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -251,6 +251,16 @@ config AD7380
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad7380.
>  
> +config AD7405
> +	tristate "Analog Device AD7405 ADC Driver"
> +	select IIO_BACKEND

It might make more sense to make this "depends" instead of "select".
Otherwise, this will show up for everyone, even if they can't actually
use it because they don't have a backend.

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
> index 000000000000..1a96a283ab01
> --- /dev/null
> +++ b/drivers/iio/adc/ad7405.c
> @@ -0,0 +1,276 @@
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
> +
> +#include <linux/iio/backend.h>
> +#include <linux/iio/iio.h>
> +
> +static const unsigned int ad7405_scale_table[][2] = {
> +	{640, 0},
> +};
> +
> +static const unsigned int adum7702_scale_table[][2] = {
> +	{128, 0},
> +};

Are there future plans for these scale tables? I don't see the point
since we only use the first number.

Also, it would make more sense to use the datasheet numbers of 320 and 64.
Otherwise, we need an explanation of where these values come from.

> +
> +static const unsigned int ad7405_dec_rates[] = {
> +	4096, 2048, 1024, 512, 256, 128, 64, 32,
> +};
> +
> +struct ad7405_chip_info {
> +	const char *name;
> +	struct iio_chan_spec channel;
> +	const unsigned int (*scale_table)[2];
> +};
> +
> +struct ad7405_state {
> +	struct iio_backend *back;
> +	const struct ad7405_chip_info *info;

> +	unsigned int sample_frequency_tbl[ARRAY_SIZE(ad7405_dec_rates)];

This is written but never read, so can be removed.

> +	unsigned int sample_frequency;

This is unused and can be removed.

> +	unsigned int ref_frequency;
> +	unsigned int dec_rate;
> +};
> +
> +static void ad7405_fill_samp_freq_table(struct ad7405_state *st)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(ad7405_dec_rates); i++)
> +		st->sample_frequency_tbl[i] =
> +			DIV_ROUND_CLOSEST_ULL(st->ref_frequency, ad7405_dec_rates[i]);
> +}
> +
> +static int ad7405_set_dec_rate(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       unsigned int dec_rate)
> +{
> +	struct ad7405_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = iio_backend_oversampling_ratio_set(st->back, 0, dec_rate);

Should pass e.g. chan->scan_index here instead of 0. Otherwise chan param
is unused.

> +	if (ret)
> +		return ret;
> +
> +	st->dec_rate = dec_rate;
> +
> +	return 0;
> +}
> +
> +static int ad7405_get_scale(struct ad7405_state *st, int *val, int *val2)
> +{
> +	unsigned int tmp;
> +
> +	tmp = (st->info->scale_table[0][0] * 1000000ULL) >>
> +		    st->info->channel.scan_type.realbits;
> +	*val = tmp / 1000000;
> +	*val2 = tmp % 1000000;
> +
> +	return IIO_VAL_INT_PLUS_NANO;

As in the comment above about the scale_tables, the more typical way to do this
would be to store the full scale voltage in st->info->full_scale_mv (320 or 64),
then here:

	*val = st->info->full_scale_mv;
	*val2 = st->info->channel.scan_type.realbits - 1;

	return IIO_VAL_FRACTIONAL_LOG2;

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
> +		return ad7405_get_scale(st, val, val2);
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*val = st->dec_rate;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = DIV_ROUND_CLOSEST_ULL(st->ref_frequency, st->dec_rate);
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
> +		return ad7405_set_dec_rate(indio_dev, chan, val);
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (val < 1)
> +			return -EINVAL;
> +		return ad7405_set_dec_rate(indio_dev, chan, val);

I would be tempted to just leave the sampling_freqnecy read-only.
But if we want it to be writeable, we have to divide val by ref_freqnecy
to convert sampling freqnecy to decimation rate before calling
ad7405_set_dec_rate().

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

If we have a writeable sampling_frequency, the we should also have
case IIO_CHAN_INFO_SAMP_FREQ here. (But as above, I think not writeable
is fine, so this is OK as-is.)

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
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
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

Since the raw value is unsigned but we can measure negative
differences, it means we need to implement IIO_CHAN_INFO_OFFSET
with a value of 2 << 15 so that usespace knows what value
is 0 volts.

> +		.realbits = 16,					\
> +		.storagebits = 16,				\
> +	},							\
> +}
> +
> +static const struct ad7405_chip_info ad7405_chip_info = {
> +	.name = "AD7405",
> +	.scale_table = ad7405_scale_table,
> +	.channel = AD7405_IIO_CHANNEL,
> +};
> +
> +static const struct ad7405_chip_info adum7701_chip_info = {
> +	.name = "ADUM7701",
> +	.scale_table = ad7405_scale_table,
> +	.channel = AD7405_IIO_CHANNEL,
> +};
> +
> +static const struct ad7405_chip_info adum7702_chip_info = {
> +	.name = "ADUM7702",
> +	.scale_table = adum7702_scale_table,
> +	.channel = AD7405_IIO_CHANNEL,
> +};
> +
> +static const struct ad7405_chip_info adum7703_chip_info = {
> +	.name = "ADUM7703",
> +	.scale_table = ad7405_scale_table,
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
> +

nit: no blank line here

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
> +	ad7405_fill_samp_freq_table(st);
> +
> +	indio_dev->dev.parent = dev;
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
> +	ret = ad7405_set_dec_rate(indio_dev, &indio_dev->channels[0], 256);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +/* Match table for of_platform binding */
> +static const struct of_device_id ad7405_of_match[] = {
> +	{ .compatible = "adi,ad7405", .data = &ad7405_chip_info, },
> +	{ .compatible = "adi,adum7701", .data = &adum7701_chip_info, },
> +	{ .compatible = "adi,adum7702", .data = &adum7702_chip_info, },
> +	{ .compatible = "adi,adum7703", .data = &adum7703_chip_info, },
> +	{ },

no trailing comma please (iio subsystem style)

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


