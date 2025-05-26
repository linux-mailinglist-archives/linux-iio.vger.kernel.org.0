Return-Path: <linux-iio+bounces-19929-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DD2AC3D87
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 12:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65DFF3A68D7
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 10:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2111F2B90;
	Mon, 26 May 2025 10:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LT+VaS5U"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E217C3C465;
	Mon, 26 May 2025 10:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748253646; cv=none; b=m5Aoifkt4E+dBsyxLI0tcCJ3W4caaJn+GgJDw3cIT5keZxqcqomwJ2XrcH8DoU5euQYxt4FYNvhQMvlBea44PJ5373IX0tKVUi2k1LzrfiatQxH4vqvBKPFYIGJ0iTuEr48R2WRSWZ4c4sPMsOEsAMa2ToNTrlIT5KfcU3L7iek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748253646; c=relaxed/simple;
	bh=QMOcHQKOixiFHCCoUumVRhB/j/Jn50UQw+FeHbfYf5o=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WwdlFHxFUbzZFfkSLQ7e06dX/LFrD9JbCIgtQ2efeTOgdULPJn9Ij++IlcImXE7yGMifWvt3v2VUWe/l+WauJ7+4Q2NGTfj4143mDcZXFG7A+DDTjYVD/XMSGZkme6j6XPJpnpRCbpD6VefRPXrPsdfaC0eC0/EjBip6gu4jIxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LT+VaS5U; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso15495335e9.3;
        Mon, 26 May 2025 03:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748253643; x=1748858443; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eicpoJrb0fZY7y6sTaFmu8OzAD0wjIi85iAmFVAlBtI=;
        b=LT+VaS5UnPpdKYgaw5Kaw/J9v0z3bPhwiItt8SV3p34PhuHvOWqG0BSNVLmeYTLgG6
         qzop3xIMQuJzD3rPjMe0BqU/vwoWTq8F+qzqwfelC5QXDMNFkdE9FLkesHJAP5Aqm80O
         G6tkOGrRzvcfcHma75f0a01xs+57V4jhtOzvnwHr1Rp7bqoI1kJJIfcsH/zjBfEjRQqt
         GNq1nXyuU0pjY4CMnd7rhmKHfxrrBD8cCtCUNh/xlkuT02ldHrWjs+QxpvC6Y+InliGl
         T/fxbadhIsrDgfZIvVO/nfJLhOhHpgRbUFHDQ7N52Z7WGBfsqWkh8TA7HtIt82snYHLQ
         xzWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748253643; x=1748858443;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eicpoJrb0fZY7y6sTaFmu8OzAD0wjIi85iAmFVAlBtI=;
        b=EswfiIKxrsOGqQyxMKpqbXa6Mbbku6DL1qwzX0Kg+4yYnrKMeczrYPfr9auLYZ4zdI
         kzlgDtppJXZnEsw6nyJFaf7h9q419LNayqPGVUdZ/qY0SXvO4Fsymud7APCuZccb9XYl
         UqGyR3HR1EtCb+vJ7PvahjV8urmmJclMqc9k8xS0h9vBCMY9nn5KtOds83Pg58JFrQuj
         n/uHhZNV3YQdl7llvpJXhyNXZgl9ywIEOlo1TkAnhFgd41ovKNQJjmjJVds/KOU87k7I
         ztKeqZ5U3IMhDcgmW3Uz/KkYfH6ik00VJqf/ULcNXTDAeqLOJouEjLpkm90vn3TdiSnf
         lQzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEPg7mBkiBHIkkYmy9qhrv1ug1GfiUBWhKKNpqAGM2/zvX/j1ETAdT56H+fO4lB5iGIKFckgmRowLbC86u@vger.kernel.org, AJvYcCVYsnJEjoFhrDDNrIt2QWlcBiGk7Doxw4onOuvASRBNZ0BMRLYFC3LQCw2KjzgesjbeaB3G/1M4LlNZ@vger.kernel.org, AJvYcCWz3RRAPOqqyj6H5wffPpCnXJdEiQRjLMn4CmfrsDHFWfmgh9oa7ZB+RFaOcCGRqRr019v7NQ1pSezQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwXLMDVcSP0tncqwSLp4VKJVEhejQFQnD/DwufZNSloDRJOrrq4
	PbsqyhkmnGDeFKWSF2qaVokgtuVjmG2voNl/UzgHBrpd14CMybNKzq/P
X-Gm-Gg: ASbGnctOe8gVbJaj/TU66IR4ASfTKiR2p0VEyeHV8kluQdMpeWLhLEWcTlOCV+gBEA1
	hvgD28hU7XsaHG/L8KdztKnOTEpoFsE+sPHB72x40HsegwUUEMwEK5VdDZhK6adqx+IfAyn8juz
	atPtUuqO5/ibufxua7Dh1rNsXyeTatzRU0o4R5uDbQRFTHfDG3afV/lwgjZr5LGbBlLKccJGKaE
	OOwZS6WXESzqGfGnRm6FpeNnymYQMX6m1sfnss6LsyGMgX797Tuq8yfJUhGmNiiizFkmL4scUpa
	X2Fb3dclOH9929FUsPOfDZSJ6APC1r3oPzzaQVfsUCafNrYYAMWnU2Jp
X-Google-Smtp-Source: AGHT+IFyPQ4Wmke7I/ldBmQ9xIXo1pz+RbcwWPzddrOPwodQoUH2HBPsO/ug0U9yclj2a7jniWZ4gA==
X-Received: by 2002:a05:6000:2585:b0:3a3:5918:bb9e with SMTP id ffacd0b85a97d-3a4cb4b8792mr6363492f8f.59.1748253642985;
        Mon, 26 May 2025 03:00:42 -0700 (PDT)
Received: from [100.73.1.233] ([185.128.9.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4c90624cfsm8194980f8f.62.2025.05.26.03.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 03:00:42 -0700 (PDT)
Message-ID: <4a357e2412efe86cd9efc46baeb2e5d475e29515.camel@gmail.com>
Subject: Re: [PATCH v4 6/6] iio: adc: ad7405: add ad7405 driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Pop Ioan Daniel <pop.ioan-daniel@analog.com>, Lars-Peter Clausen	
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron	 <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring	 <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Sergiu Cuciurean <sergiu.cuciurean@analog.com>, 
 Dragos Bogdan <dragos.bogdan@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Olivier Moysan	 <olivier.moysan@foss.st.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,  Matti Vaittinen
 <mazziesaccount@gmail.com>, Tobias Sperling <tobias.sperling@softing.com>,
 Alisa-Dariana Roman	 <alisadariana@gmail.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, 	linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 26 May 2025 11:00:45 +0100
In-Reply-To: <20250519140220.81489-7-pop.ioan-daniel@analog.com>
References: <20250519140220.81489-1-pop.ioan-daniel@analog.com>
	 <20250519140220.81489-7-pop.ioan-daniel@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-05-19 at 17:02 +0300, Pop Ioan Daniel wrote:
> Add support for the AD7405/ADUM770x, a high performance isolated ADC,
> 1-channel, 16-bit with a second-order =CE=A3-=CE=94 modulator that conver=
ts an
> analog input signal into a high speed, single-bit data stream.
>=20
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> ---

Hi,

Just a couple of notes from me...
=20
> changes in v4:
> =C2=A0- changes in "depends on" instead of "select" for IIO_BACKEND in Kc=
onfig
> =C2=A0- remove scale_tables variables
> =C2=A0- remove sample_frequency_tbl, sample_frequency
> =C2=A0- remove ad7405_fill_samp_freq_table function
> =C2=A0- rewrite ad7405_get_scale function as suggested
> =C2=A0- make sampling_frequency read-only
> =C2=A0- implement IIO_CHAN_INFO_OFFSET as suggested
> =C2=A0- fix code style
>=20
> =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0 10 ++
> =C2=A0drivers/iio/adc/Makefile |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/ad7405.c | 250 ++++++++++++++++++++++++++++++++++++=
+++
> =C2=A03 files changed, 261 insertions(+)
> =C2=A0create mode 100644 drivers/iio/adc/ad7405.c
>=20
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index ad06cf556785..43af2070e27f 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -251,6 +251,16 @@ config AD7380
> =C2=A0	=C2=A0 To compile this driver as a module, choose M here: the modu=
le will
> be
> =C2=A0	=C2=A0 called ad7380.
> =C2=A0
> +config AD7405
> +	tristate "Analog Device AD7405 ADC Driver"
> +	depends on IIO_BACKEND
> +	help
> +	=C2=A0 Say yes here to build support for Analog Devices AD7405, ADUM770=
1,
> +	=C2=A0 ADUM7702, ADUM7703 analog to digital converters (ADC).
> +
> +	=C2=A0 To compile this driver as a module, choose M here: the module wi=
ll
> be
> +	=C2=A0 called ad7405.
> +
> =C2=A0config AD7476
> =C2=A0	tristate "Analog Devices AD7476 1-channel ADCs driver and other
> similar devices from AD and TI"
> =C2=A0	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 07d4b832c42e..8115f30b7862 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_AD7291) +=3D ad7291.o
> =C2=A0obj-$(CONFIG_AD7292) +=3D ad7292.o
> =C2=A0obj-$(CONFIG_AD7298) +=3D ad7298.o
> =C2=A0obj-$(CONFIG_AD7380) +=3D ad7380.o
> +obj-$(CONFIG_AD7405) +=3D ad7405.o
> =C2=A0obj-$(CONFIG_AD7476) +=3D ad7476.o
> =C2=A0obj-$(CONFIG_AD7606_IFACE_PARALLEL) +=3D ad7606_par.o
> =C2=A0obj-$(CONFIG_AD7606_IFACE_SPI) +=3D ad7606_spi.o
> diff --git a/drivers/iio/adc/ad7405.c b/drivers/iio/adc/ad7405.c
> new file mode 100644
> index 000000000000..fb249c83b87b
> --- /dev/null
> +++ b/drivers/iio/adc/ad7405.c
> @@ -0,0 +1,250 @@
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
> +static const unsigned int ad7405_dec_rates[] =3D {
> +	4096, 2048, 1024, 512, 256, 128, 64, 32,
> +};
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
> +	unsigned int ref_frequency;
> +	unsigned int dec_rate;
> +};
> +
> +static int ad7405_set_dec_rate(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec *chan=
,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int dec_rate)
> +{
> +	struct ad7405_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	ret =3D iio_backend_oversampling_ratio_set(st->back, chan->scan_index,
> dec_rate);
> +	if (ret)
> +		return ret;
> +
> +	st->dec_rate =3D dec_rate;
> +
> +	return 0;
> +}
> +
> +static int ad7405_get_scale(struct ad7405_state *st, int *val, int *val2=
)
> +{
> +	*val =3D st->info->full_scale_mv;
> +	*val2 =3D st->info->channel.scan_type.realbits - 1;
> +
> +	return IIO_VAL_FRACTIONAL_LOG2;
> +}
> +
> +static int ad7405_read_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0 const struct iio_chan_spec *chan, int *val,
> +			=C2=A0=C2=A0 int *val2, long info)
> +{
> +	struct ad7405_state *st =3D iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return ad7405_get_scale(st, val, val2);
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*val =3D st->dec_rate;

I'm typically picky with this but I really think that we need a lock to be =
used
here and in ad7405_set_dec_rate(). Alternatively we could add
iio_backend_oversampling_ratio_get() but I would likely avoid a new op just=
 for
this.

> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val =3D DIV_ROUND_CLOSEST_ULL(st->ref_frequency, st-
> >dec_rate);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val =3D 2 << (st->info->channel.scan_type.realbits - 1);
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad7405_write_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan, int val,
> +			=C2=A0=C2=A0=C2=A0 int val2, long info)
> +{
> +	switch (info) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		return ad7405_set_dec_rate(indio_dev, chan, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad7405_read_avail(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 const int **vals, int *type, int *length,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 long info)
> +{
> +	switch (info) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*vals =3D ad7405_dec_rates;
> +		*length =3D ARRAY_SIZE(ad7405_dec_rates);
> +		*type =3D IIO_VAL_INT;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info ad7405_iio_info =3D {
> +	.read_raw =3D &ad7405_read_raw,
> +	.write_raw =3D &ad7405_write_raw,
> +	.read_avail =3D &ad7405_read_avail,
> +};
> +
> +#define AD7405_IIO_CHANNEL {					\
> +	.type =3D IIO_VOLTAGE,					\
> +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |	\
> +			BIT(IIO_CHAN_INFO_OFFSET),		\
> +	.info_mask_shared_by_all =3D IIO_CHAN_INFO_SAMP_FREQ |	\
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
> +	.info_mask_shared_by_all_available =3D			\
> +			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
> +	.indexed =3D 1,						\
> +	.channel =3D 0,						\
> +	.channel2 =3D 1,						\
> +	.differential =3D 1,					\
> +	.scan_index =3D 0,					\
> +	.scan_type =3D {						\
> +		.sign =3D 'u',					\
> +		.realbits =3D 16,					\
> +		.storagebits =3D 16,				\
> +	},							\
> +}
> +
> +static const struct ad7405_chip_info ad7405_chip_info =3D {
> +	.name =3D "AD7405",
> +	.full_scale_mv =3D 320,
> +	.channel =3D AD7405_IIO_CHANNEL,
> +};
> +
> +static const struct ad7405_chip_info adum7701_chip_info =3D {
> +	.name =3D "ADUM7701",
> +	.full_scale_mv =3D 320,
> +	.channel =3D AD7405_IIO_CHANNEL,
> +};
> +
> +static const struct ad7405_chip_info adum7702_chip_info =3D {
> +	.name =3D "ADUM7702",
> +	.full_scale_mv =3D 64,
> +	.channel =3D AD7405_IIO_CHANNEL,
> +};
> +
> +static const struct ad7405_chip_info adum7703_chip_info =3D {
> +	.name =3D "ADUM7703",
> +	.full_scale_mv =3D 320,
> +	.channel =3D AD7405_IIO_CHANNEL,
> +};
> +
> +static const char * const ad7405_power_supplies[] =3D {
> +	"vdd1",	"vdd2",
> +};
> +
> +static int ad7405_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad7405_state *st;
> +	struct clk *clk;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +
> +	st->info =3D device_get_match_data(dev);
> +	if (!st->info)
> +		return dev_err_probe(dev, -EINVAL, "no chip info\n");
> +
> +	ret =3D devm_regulator_bulk_get_enable(dev,
> ARRAY_SIZE(ad7405_power_supplies),
> +					=C2=A0=C2=A0=C2=A0=C2=A0 ad7405_power_supplies);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get and enable
> supplies");
> +
> +	clk =3D devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	st->ref_frequency =3D clk_get_rate(clk);
> +	if (!st->ref_frequency)
> +		return -EINVAL;
> +
> +	indio_dev->dev.parent =3D dev;

no need for the above

- Nuno S=C3=A1

