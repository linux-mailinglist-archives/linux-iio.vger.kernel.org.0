Return-Path: <linux-iio+bounces-17257-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD53A6E317
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 20:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574303A82B0
	for <lists+linux-iio@lfdr.de>; Mon, 24 Mar 2025 19:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDC9189520;
	Mon, 24 Mar 2025 19:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BTEcgDij"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3B52641E9
	for <linux-iio@vger.kernel.org>; Mon, 24 Mar 2025 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742843381; cv=none; b=kbgG0V7uOPURLPSegrguPiykhbt29jY8JFDFDX2K838TFyBPcgZiLQ0lRTNTdDufojQ2RDOA/zUEiVEQ1iDTWeVtmm2073u0DosW/O3xjySdLY7RmGid/mwtPm4nEBQwXgsGjmhq1tMi3hC9YiJFxv6qvZlMiqheGSsXNb/d0AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742843381; c=relaxed/simple;
	bh=4e+oFu9Q6wUXTrgtXS5M+E3pj/8zp3lm10t7a5Qm2k0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RiLK7KY4AmGeYRZk+VZAYiDaIpIgI7KweeDlnP70u7QCWM1M/CRmWVhP3Mig293XFpTRZyz6AE/w4+ajs+sODhoPnQMKttesoqAxkJrbxTtCFcxD2eHHp17EEFBiNxMbVvuKT8HL3sgiXmnU4uOSuPYaU9K/FxB8icHhdyJsksE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BTEcgDij; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5fc6cd89f85so2594465eaf.1
        for <linux-iio@vger.kernel.org>; Mon, 24 Mar 2025 12:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742843378; x=1743448178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H0zdoAwcwDLSwtGfrTRWrJHFn7hMD5+WG40QGfQorTg=;
        b=BTEcgDijjBC6I+SBOnJmpd7WNHRipzJHrLQEcCQFQZHbXniqog9Acugf+nBc4s4xnS
         HKgL+bwXhdgVwZka6XjsPpERuGHqeOk8+U2gWegifh3B6EaGsMHrAUr5xAMm/It9IJ9k
         vdsgsLnY+wL6Tv0RTny40PRSVCkhxlO8bFaYa/yRdB57UZZCoOPSNK3fPJOBp/zbe6XG
         42opKZorStXqU5pggyfwhV2l0i0puR+x7w8fpGklkev8G+D3G55bGq7tJv3jpz1x/jEc
         c/xwu6TWCkWD4znFZLDqkWFkCyYgy4XjpykKE9D8zqKGz9fBf4pURdsTFPOLW7m5Clo2
         1l4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742843378; x=1743448178;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H0zdoAwcwDLSwtGfrTRWrJHFn7hMD5+WG40QGfQorTg=;
        b=eba1Wo05erMvRUVzRZB3hdQ+N7AwcxWsI8G7PGRDe7V1AjjsgUpouj+LSQ9tyNZ+QE
         xarAaQk9eLVWTJca7FZ2apwcfKawD09+hMsV0aW68nnHCxXx72mF1KKNb4uUW3m+Crsz
         MVFZRqwfJO/EYVNpGUVsSRMR+sxc/GlU3JYpWGA8Wgh3Amo1oCbSoC/+YdqxPM9NyzE9
         Gsb7CvFFUlT76ZlB4tu3a7hLByTXx/pl/LaCs2xyfWXrM5uVD0AQQwJEO3Zmum6vCi5j
         Z/VbnLdLBrLwAdznxxw7uTVFIzl1qWyKJhPCW4e9CD1hJsy6RSoWRRDFEvJL0lfE1cA2
         Cr5A==
X-Forwarded-Encrypted: i=1; AJvYcCXYMh5D+OdtsVQ+efmY2w5FynsPFSXq2NP0Yhl9gpgYi+JbKvLpK9YzfSjs/lUgg/fMeRg+vSD24Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsy+zStvlw8pk6DsdhEVDrKO3/gtKRhz2E51DgIvDZ8lW6GJBE
	rB+iFF2NP28bdfJoQ3zUm7jCXlZJIWoUoNvtGmK8UM12rQTGX9+w54Ys4tY43ME=
X-Gm-Gg: ASbGncuUBEmPXq9Cmzkqbu63W+oqV7a5mv16PJveZLvJ0fEmdoCugqxdy76dJxrva/w
	acMf+OGn5ekcvJB0U7tioAxz70al85iE2mJl+QOmFFQZh8doX1v+IqY5GkpbS0mDsx1GxU1qmgd
	A4ASMY12bJdnNNNjQ5g//z2OQ0gczyry+ln97qvAjzTp/B09ehzvR9D8ImQOVgNIh6PjECduikc
	7zqE7RJiqiVhEwqtcKs6l6fccdyhPS0GEqNYVkVVHeJf35yxoy4ss2vic9iuR7o2OtOYLQZvqt8
	WbP96b75Go3qI7I/sVVgKqwo/lV05I78EIbC5qMq5R5PWK5LB+bcLtDL8BNpKzK0OnzdV4hgz1Q
	eUp4V4g==
X-Google-Smtp-Source: AGHT+IHbHJS2ELGvP1HWTkIv85XUyoptAROmV7RaFDSIwXC/XQCS78dgMcqkqcEWANU8rVY19XdwKA==
X-Received: by 2002:a05:6820:2486:b0:601:afda:cddd with SMTP id 006d021491bc7-602345ef325mr6350812eaf.4.1742843377911;
        Mon, 24 Mar 2025 12:09:37 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-60234710c7dsm1281811eaf.14.2025.03.24.12.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 12:09:36 -0700 (PDT)
Message-ID: <4e18f195-fec2-4562-bbe5-69ff465e44d9@baylibre.com>
Date: Mon, 24 Mar 2025 14:09:34 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] iio: adc: ad7405: add ad7405 driver
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Guillaume Stols <gstols@baylibre.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Dumitru Ceclan <mitrutzceclan@gmail.com>,
 Matteo Martelli <matteomartelli3@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Alisa-Dariana Roman <alisadariana@gmail.com>,
 Michael Walle <michael@walle.cc>, Herve Codina <herve.codina@bootlin.com>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Dragos Bogdan <dragos.bogdan@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250324090813.2775011-1-pop.ioan-daniel@analog.com>
 <20250324090813.2775011-6-pop.ioan-daniel@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <20250324090813.2775011-6-pop.ioan-daniel@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/24/25 4:08 AM, Pop Ioan Daniel wrote:
> Add support for the AD7405/ADUM770x, a high performance isolated ADC,
> 1-channel, 16-bit with a second-order Σ-Δ modulator that converts an
> analog input signal into a high speed, single-bit data stream.
> 

Dragos is listed as the MODULE_AUTHOR, so would expect to see Co-developed-by:
and Signed-off-by: tags for him as well, assuming he wrote some of this code.

More info: https://docs.kernel.org/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> ---
>  drivers/iio/adc/Kconfig  |  10 ++
>  drivers/iio/adc/Makefile |   1 +
>  drivers/iio/adc/ad7405.c | 301 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 312 insertions(+)
>  create mode 100644 drivers/iio/adc/ad7405.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index f64b5faeb257..321a1ee7304f 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -203,6 +203,16 @@ config AD7380
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called ad7380.
>  
> +config AD7405
> +	tristate "Analog Device AD7405 ADC Driver"
> +	select IIO_BACKEND
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
> index ee19afba62b7..0c3c1c69b6b4 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_AD7291) += ad7291.o
>  obj-$(CONFIG_AD7292) += ad7292.o
>  obj-$(CONFIG_AD7298) += ad7298.o
>  obj-$(CONFIG_AD7380) += ad7380.o
> +obj-$(CONFIG_AD7405) += ad7405.o
>  obj-$(CONFIG_AD7476) += ad7476.o
>  obj-$(CONFIG_AD7606_IFACE_PARALLEL) += ad7606_par.o
>  obj-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
> diff --git a/drivers/iio/adc/ad7405.c b/drivers/iio/adc/ad7405.c
> new file mode 100644
> index 000000000000..40fe072369d5
> --- /dev/null
> +++ b/drivers/iio/adc/ad7405.c
> @@ -0,0 +1,301 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices AD7405 driver
> + *
> + * Copyright 2025 Analog Devices Inc.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/log2.h>
> +#include <linux/clk.h>
> +#include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/backend.h>
> +#include <linux/util_macros.h>
> +#include <linux/regulator/consumer.h>

Sort the includes in alphabetical order. And prune headers that aren't used
like log2.h and of.h.

> +
> +#define AD7405_DEFAULT_DEC_RATE 1024
> +
> +const unsigned int ad7405_dec_rates[] = {
> +		4096, 2048, 1024, 512, 256, 128, 64, 32,
> +};
> +
> +struct ad7405_chip_info {
> +	const char *name;
> +	unsigned int num_channels;
> +	unsigned int max_rate;
> +	unsigned int min_rate;
> +	struct iio_chan_spec channel[3];

Currently, all chips only have one channel, so we can leave out num_channels
and not use an array for the single struct iio_chan_spec.

> +	const unsigned long *available_mask;
> +};
> +
> +struct ad7405_state {
> +	struct iio_backend *back;
> +	struct clk *axi_clk_gen;

Just call it clk. Also, if we don't need to access it outside of probe, we
don't need it in this struct.

> +	/* lock to protect multiple accesses to the device registers */
> +	struct mutex lock;
> +	struct regmap *regmap;

These are not used, so should be removed.

> +	struct iio_info iio_info;

Don't need to have a copy in this struct.

> +	const struct ad7405_chip_info *info;
> +	unsigned int sample_frequency_tbl[ARRAY_SIZE(ad7405_dec_rates)];
> +	unsigned int sample_frequency;
> +	unsigned int ref_frequency;
> +};
> +
> +static void ad7405_fill_samp_freq_table(struct ad7405_state *st)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(ad7405_dec_rates); i++)
> +		st->sample_frequency_tbl[i] = DIV_ROUND_CLOSEST_ULL(st->ref_frequency, ad7405_dec_rates[i]);

Wrap to 80 chars.

> +}
> +
> +static int ad7405_set_sampling_rate(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    unsigned int samp_rate)
> +{
> +	struct ad7405_state *st = iio_priv(indio_dev);
> +	unsigned int dec_rate, idx;
> +	int ret;
> +
> +	dec_rate = DIV_ROUND_CLOSEST_ULL(st->ref_frequency, samp_rate);
> +
> +	idx = find_closest_descending(dec_rate, ad7405_dec_rates,
> +				      ARRAY_SIZE(ad7405_dec_rates));
> +
> +	    dec_rate = ad7405_dec_rates[idx];
> +
> +	ret = iio_backend_set_dec_rate(st->back, dec_rate);
> +	if (ret)
> +		return ret;
> +
> +	st->sample_frequency = DIV_ROUND_CLOSEST_ULL(st->ref_frequency, dec_rate);
> +
> +	return 0;
> +}
> +
> +static int ad7405_update_scan_mode(struct iio_dev *indio_dev,
> +				   const unsigned long *scan_mask)
> +{
> +	struct ad7405_state *st = iio_priv(indio_dev);
> +	unsigned int c;
> +	int ret;
> +
> +	for (c = 0; c < indio_dev->num_channels; c++) {
> +		if (test_bit(c, scan_mask))
> +			ret = iio_backend_chan_enable(st->back, c);
> +		else
> +			ret = iio_backend_chan_disable(st->back, c);
> +		if (ret)
> +			return ret;
> +	}
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
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +			*val = st->sample_frequency;
> +
> +			return IIO_VAL_INT;
> +	default:
> +			return -EINVAL;
> +	}
> +}
> +
> +static int ad7405_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int val,
> +			    int val2, long info)
> +{
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +

Need to return -EINVAL on val = 0 to avoid divide by zero crash.

> +			return ad7405_set_sampling_rate(indio_dev, chan, val);
> +
> +	default:
> +			return -EINVAL;
> +	}
> +}
> +
> +static int ad7405_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +				 const int **vals, int *type, int *length,
> +				 long info)
> +{
> +	struct ad7405_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +			*vals = st->sample_frequency_tbl;
> +			*length = ARRAY_SIZE(st->sample_frequency_tbl);
> +			*type = IIO_VAL_INT;
> +			return IIO_AVAIL_LIST;
> +	default:
> +			return -EINVAL;
> +	}
> +}

./scripts/checkpatch.pl should be catching issues with indentation style in the
functions above.

> +
> +static const struct iio_info ad7405_iio_info = {
> +	.read_raw = &ad7405_read_raw,
> +	.write_raw = &ad7405_write_raw,
> +	.read_avail = &ad7405_read_avail,
> +	.update_scan_mode = ad7405_update_scan_mode,
> +};
> +
> +#define AD7405_IIO_CHANNEL(_chan, _bits, _sign)		  \

chan, bits and sign are always the same, so we could omit these paramters.

> +	{ .type = IIO_VOLTAGE,					  \

We need info_mask_shared_by_type (or _separate) with IIO_CHAN_INFO_SCALE and
IIO_CHAN_INFO_OFFSET flags so that userspace knows how to convert raw data to
the standard unit of millivolts.

> +	  .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +	  .info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +	  .indexed = 1,						 \
> +	  .channel = _chan,					 \

Also needs .scan_index = _chan, .differential = 1, .channel2 = _chan + 1,

> +	  .scan_type = {				\
> +		.sign = _sign,				\
> +		.realbits = _bits,			\
> +		.storagebits = 16,			\
> +		.shift = 0,				\
> +	  },						\
> +	}
> +
> +static const unsigned long ad7405_channel_masks[] = {
> +		BIT(0),
> +		0,
> +};

This should not be need since there is only one channel.

> +
> +static const struct ad7405_chip_info ad7405_chip_info = {
> +		.name = "AD7405",
> +		.max_rate = 625000UL,
> +		.min_rate = 4883UL,

Doesn't the max rate depend on the clock frequency? So not sure how useful it
is to specify this.

min_rate is not used anywhere, so can be omitted.

> +		.num_channels = 1,
> +		.channel = {
> +			AD7405_IIO_CHANNEL(0, 16, 'u'),
> +		},
> +		.available_mask = ad7405_channel_masks,
> +};
> +
> +static const struct ad7405_chip_info adum7701_chip_info = {
> +		.name = "ADUM7701",
> +		.max_rate = 656250UL,
> +		.min_rate = 5127UL,
> +		.num_channels = 1,
> +		.channel = {
> +			AD7405_IIO_CHANNEL(0, 16, 'u'),
> +		},
> +		.available_mask = ad7405_channel_masks,
> +};
> +
> +static const char * const ad7405_power_supplies[] = {
> +	"vdd1",	"vdd2",
> +};
> +
> +static int ad7405_probe(struct platform_device *pdev)
> +{
> +	const struct ad7405_chip_info *chip_info;
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad7405_state *st;
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
> +	chip_info = &ad7405_chip_info;

This uses the same chip info for all chips and ignores the .data in the module
device table.

> +
> +	platform_set_drvdata(pdev, indio_dev);

There is no platform_get_drvdata(), so this is unnecessary.

> +
> +	st->axi_clk_gen = devm_clk_get(dev, NULL);

Can be simplified to devm_clk_get_enabled().

> +	if (IS_ERR(st->axi_clk_gen))
> +		return PTR_ERR(st->axi_clk_gen);
> +
> +	ret = clk_prepare_enable(st->axi_clk_gen);
> +	if (ret)
> +		return ret;

Otherwise we also need to add something to disable_unprepare the clock when
the driver is removed.

> +
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ad7405_power_supplies),
> +					     ad7405_power_supplies);

I didn't see anything in the datasheet about power up sequencing, but typically
we would turn on power to the chip first before applying any other signals, like
the clock.

> +
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get and enable supplies");
> +
> +	st->ref_frequency = clk_get_rate(st->axi_clk_gen);

Should check for return value of 0 and raise an error, otherwise we would get
divide by zero crash later.

> +
> +	ad7405_fill_samp_freq_table(st);
> +
> +	indio_dev->dev.parent = dev;
> +	indio_dev->name = pdev->dev.of_node->name;

I think usually this is chip_info->name rather than the DT node name.

> +	indio_dev->modes = INDIO_DIRECT_MODE;

IIO_CHAN_INFO_RAW isn't implemented, so INDIO_DIRECT_MODE should not be set.

> +
> +	indio_dev->channels = chip_info->channel;
> +	indio_dev->num_channels = chip_info->num_channels;
> +
> +	st->iio_info = ad7405_iio_info;
> +	indio_dev->info = &st->iio_info;
> +
> +	st->back = devm_iio_backend_get(dev, NULL);
> +	if (IS_ERR(st->back))
> +		return dev_err_probe(dev, PTR_ERR(st->back),
> +				     "failed to get IIO backend");
> +
> +	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_backend_enable(dev, st->back);
> +	if (ret)
> +		return ret;
> +
> +	/* Reset all HDL Cores */
> +	iio_backend_disable(st->back);
> +	iio_backend_enable(st->back);

Seems like this would be redunant and should be done implicitly by
devm_iio_backend_enable() (i.e. disable in adi_axi_adc_probe() so that 
devm_iio_backend_enable() brings it out of reset).

> +
> +	ret = ad7405_set_sampling_rate(indio_dev, &indio_dev->channels[0],
> +				       chip_info->max_rate);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_device_register(dev, indio_dev);

Can just return directly here.

> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +/* Match table for of_platform binding */
> +static const struct of_device_id ad7405_of_match[] = {
> +	{ .compatible = "adi,ad7405", .data = &ad7405_chip_info, },
> +	{ .compatible = "adi,adum7701", .data = &adum7701_chip_info, },
> +	{ .compatible = "adi,adum7702", .data = &adum7701_chip_info, },
> +	{ .compatible = "adi,adum7703", .data = &adum7701_chip_info, },
> +	{ /* end of list */ },
> +};
> +
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
> +
> +module_platform_driver(ad7405_driver);
> +
> +MODULE_AUTHOR("Dragos Bogdan <dragos.bogdan@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD7405 driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_BACKEND");


