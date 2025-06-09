Return-Path: <linux-iio+bounces-20326-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A988AD198C
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jun 2025 10:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBA1C16497A
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jun 2025 08:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9081E281357;
	Mon,  9 Jun 2025 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgjjuUsp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628C88BFF;
	Mon,  9 Jun 2025 08:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749456347; cv=none; b=k21A0idgsAibP+2ozqDFD50qM3UF3N9LqulxoipaCR0DtJu0aDKKQfVzyHB3Ceb+k/IsKF0w+lsTP/EKfOQl7Vc3d20mEfZs8Xl9teMdEgX8ZgknPuiEZiIIOdNreiWopLZ72Hh5Iew1fbUbpP0nniREo8r8BHlwm5jFgQS/uaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749456347; c=relaxed/simple;
	bh=qBueEC1npTtSkmELi7i3Sm8KHkbtYZnM410acM1mAOk=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tv7a8cccX2B1NeKQYSLXT+I/8VvRnzzyEz9Me37bJi16bRh28WpCF7uPnQnrXQUaXV42hMhWhOALZCqOQsJp39gnVKOR77lVm+4PS+0rs3eXnREnNe8/05vKPka7ZL78N87eq6FKjjP36XlXKCr1VRXr/5OYmKy1P1z3OBpTwGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgjjuUsp; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so3434246f8f.1;
        Mon, 09 Jun 2025 01:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749456344; x=1750061144; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4pmFUtt6uVLHg5W7x8YNczKB/YrG77/k0XSv5YhRDg=;
        b=BgjjuUspxxV+P6qWT+MWOPRKjfH05cUdyThxUE0ollYUMAU4K5Ivegq6oxb0yVwd48
         S5M/ZvETisrCgEuotqnajQ4bjnnuCiXvTXsFAYoHEFYK7T4mkHl1W+rzw2XIygyrepS7
         7T9WnfEwf9XEn6K9/5O4N0YLAeNvgucnzqV4edetgcy8MBYH3psxsWDLYC/VoSwuyQ8n
         XNGUGZkdGWpcSE7AQeRZ8+0VpD7g+rn2I5UQncN+b7tG2SMbPA/4tck+UCRiBFOroUa3
         QCyEDz+JhCwnDiJy4f0xbg4uqMRKasFpovacOc6z3Gg9vAOaKMshx7PnXN5VH00EQbVw
         OpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749456344; x=1750061144;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r4pmFUtt6uVLHg5W7x8YNczKB/YrG77/k0XSv5YhRDg=;
        b=vZjM7pv1A3COzpFsiQ8DUpokE7XB8Aa9HXCzUybIOdsXLtqybKWSKdd3UI1W9oC5QB
         3dbindTuXYRtjUwiFEJOx4prHe0GKWPp17AtfciGO2JnQvGjram7jFhbI5f9RZVifnTz
         LccCXmi0/wXZBRyeQZXwFj6UM2uarfNTBsPHRG0znfRdXfcBL0utedWPKU3JzdH48m2h
         NSV/ZrgAdFzC2kiBkptjUhV3vu+aDYwT6e+BbAf4vRtjIaoZe467cQpEddz0fCxG2Geq
         pFkdX2yT3WB5dMnXKPl8Rdohru3l7dWEyi2xB1vaTgKishhN7La6eIV5f9ORD6FAuOEH
         mWQw==
X-Forwarded-Encrypted: i=1; AJvYcCUNMiLORBL6Cy99u/8N7NGGy0GXZKKIRpQXd6AkiLKJ+ddi65vmAZmGSv3BZzOwE+9/eupZ3uQDnWa9@vger.kernel.org, AJvYcCVduFjl9WOtVgu4cfkfu/xnjTss8Qyv4FhuKOefE6sOPKXK8XoCQTNSXkUrcT3T49pHOvl6UKdobEEF@vger.kernel.org, AJvYcCW6UeFdFv7+V9ZuOBBeasfH+8vGYY1AxlIo7x2DqU2M4dUkKU6YirqHQXB4kPCWXG3bKN+gMjcLIBGJuCwD@vger.kernel.org
X-Gm-Message-State: AOJu0YytdyJKHEyNm3mgFtg1X7c0eXzzNCubf++ujwj32fucGPWMCUEY
	df+Amyw5orAdjGQe0sIRptFQgNZC/oUQL7vwocKKZyTI7DGLoLRMIO/d
X-Gm-Gg: ASbGnctVZWy+6M/1RS/kGVaa/RFZLWOFlXCVeKgN5p8jhACArF0i+JbUBneJyGUdiqN
	te+g2jAUWpkrWdW/lYvzKp+2TcWoy1pkJx2bPOVZGxhVVb5BKkrRRe4w52gVdnpCyoI1XhIpJj9
	4c8hvo85WKnD/4xfpwf0C/Bbn77FwfsIjA0eu8GB3uaYlY6uHayeTVSfSZ+/qLKYqeR5Evjmenu
	eYjSCuiYFogMnF6fYZ3NVi1cstrn4HDATBOcGXNJKcVWQP8u/T8vhptJBNpjzOyCdsMXjXE0hte
	msju7SD8tcM0OpIfR9EbhN8ijxHkAuIV0sz73ozHzpxyUWWAaXQqjz5HyfGjXKkoqcOGYQ==
X-Google-Smtp-Source: AGHT+IFJe1aAG/zR94PMwun2u1CVvSTjTfcD2GhSf5CGaS/aanunWwMpiCYGfPHjpJfuCjV0E4XjfA==
X-Received: by 2002:a05:6000:2304:b0:3a4:f6f2:65e9 with SMTP id ffacd0b85a97d-3a531434393mr9663520f8f.19.1749456343376;
        Mon, 09 Jun 2025 01:05:43 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5323b6612sm8761209f8f.41.2025.06.09.01.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 01:05:42 -0700 (PDT)
Message-ID: <930768920f83bf720f660f65050ef61d16610766.camel@gmail.com>
Subject: Re: [PATCH v7 5/5] iio: adc: ad7405: add ad7405 driver
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
 <mazziesaccount@gmail.com>, Angelo Dureghello <adureghello@baylibre.com>,
 Guillaume Stols	 <gstols@baylibre.com>, Tobias Sperling
 <tobias.sperling@softing.com>,  Marcelo Schmitt
 <marcelo.schmitt@analog.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Alisa-Dariana Roman	 <alisadariana@gmail.com>, Ramona Alexandra Nechita
 <ramona.nechita@analog.com>,  Herve Codina <herve.codina@bootlin.com>,
 AngeloGioacchino Del Regno	 <angelogioacchino.delregno@collabora.com>,
 Thomas Bonnefille	 <thomas.bonnefille@bootlin.com>, =?ISO-8859-1?Q?Jo=E3o?=
 Paulo =?ISO-8859-1?Q?Gon=E7alves?=	 <joao.goncalves@toradex.com>,
 linux-iio@vger.kernel.org, 	devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Mon, 09 Jun 2025 09:05:48 +0100
In-Reply-To: <20250605150948.3091827-6-pop.ioan-daniel@analog.com>
References: <20250605150948.3091827-1-pop.ioan-daniel@analog.com>
	 <20250605150948.3091827-6-pop.ioan-daniel@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-05 at 18:09 +0300, Pop Ioan Daniel wrote:
> Add support for the AD7405/ADUM770x, a high performance isolated ADC,
> 1-channel, 16-bit with a second-order =CE=A3-=CE=94 modulator that conver=
ts an
> analog input signal into a high speed, single-bit data stream.
>=20
> Signed-off-by: Pop Ioan Daniel <pop.ioan-daniel@analog.com>
> ---

Looks good. Just one thing that I guess Jonathan can tweak. With it,

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> changes in v7:
> =C2=A0- replace kernel.h with math64.h that define DIV_ROUND_CLOSEST_ULL(=
)
> =C2=A0- restructure ad7405_set_dec_rate function
> =C2=A0- fix indentation
> =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0 10 ++
> =C2=A0drivers/iio/adc/Makefile |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/ad7405.c | 259 ++++++++++++++++++++++++++++++++++++=
+++
> =C2=A03 files changed, 270 insertions(+)
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
> index 000000000000..c07b90fbd429
> --- /dev/null
> +++ b/drivers/iio/adc/ad7405.c
> @@ -0,0 +1,259 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Analog Devices AD7405 driver
> + *
> + * Copyright 2025 Analog Devices Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/math64.h>
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
> +static const unsigned int ad7405_dec_rates_range[] =3D {
> +	32, 1, 4096,
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
> +	if (dec_rate > 4096 || dec_rate < 32)
> +		return -EINVAL;
> +
> +	if (!iio_device_claim_direct(indio_dev))
> +		return -EBUSY;
> +
> +	ret =3D iio_backend_oversampling_ratio_set(st->back, chan->scan_index,
> dec_rate);
> +	iio_device_release_direct(indio_dev);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	st->dec_rate =3D dec_rate;
> +
> +	return 0;
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
> +		*val =3D st->info->full_scale_mv;
> +		*val2 =3D st->info->channel.scan_type.realbits - 1;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		*val =3D st->dec_rate;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val =3D DIV_ROUND_CLOSEST_ULL(st->ref_frequency, st-
> >dec_rate);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val =3D -(1 << (st->info->channel.scan_type.realbits - 1));
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
> +		if (val < 0)
> +			return -EINVAL;
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
> +		*vals =3D ad7405_dec_rates_range;
> +		*type =3D IIO_VAL_INT;
> +		return IIO_AVAIL_RANGE;
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
> +	.name =3D "ad7405",
> +	.full_scale_mv =3D 320,
> +	.channel =3D AD7405_IIO_CHANNEL,
> +};
> +
> +static const struct ad7405_chip_info adum7701_chip_info =3D {
> +	.name =3D "adum7701",
> +	.full_scale_mv =3D 320,
> +	.channel =3D AD7405_IIO_CHANNEL,
> +};
> +
> +static const struct ad7405_chip_info adum7702_chip_info =3D {
> +	.name =3D "adum7702",
> +	.full_scale_mv =3D 64,
> +	.channel =3D AD7405_IIO_CHANNEL,
> +};
> +
> +static const struct ad7405_chip_info adum7703_chip_info =3D {
> +	.name =3D "adum7703",
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
> +	indio_dev->name =3D st->info->name;
> +	indio_dev->channels =3D &st->info->channel;
> +	indio_dev->num_channels =3D 1;
> +	indio_dev->info =3D &ad7405_iio_info;
> +
> +	st->back =3D devm_iio_backend_get(dev, NULL);
> +	if (IS_ERR(st->back))
> +		return dev_err_probe(dev, PTR_ERR(st->back),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "failed to get IIO backend");
> +
> +	ret =3D iio_backend_chan_enable(st->back, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_iio_backend_request_buffer(dev, st->back, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_iio_backend_enable(dev, st->back);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Set 256 decimation rate. The default value in the AXI_ADC register
> +	 * is 0, so we set the register with a decimation rate value that is
> +	 * functional for all parts.
> +	 */
> +	ret =3D ad7405_set_dec_rate(indio_dev, &indio_dev->channels[0], 256);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct of_device_id ad7405_of_match[] =3D {
> +	{ .compatible =3D "adi,ad7405", .data =3D &ad7405_chip_info, },
> +	{ .compatible =3D "adi,adum7701", .data =3D &adum7701_chip_info, },
> +	{ .compatible =3D "adi,adum7702", .data =3D &adum7702_chip_info, },
> +	{ .compatible =3D "adi,adum7703", .data =3D &adum7703_chip_info, },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad7405_of_match);
> +
> +static struct platform_driver ad7405_driver =3D {
> +	.driver =3D {
> +		.name =3D "ad7405",
> +		.owner =3D THIS_MODULE,

Drop the above.

> +		.of_match_table =3D ad7405_of_match,
> +	},
> +	.probe =3D ad7405_probe,
> +};
> +module_platform_driver(ad7405_driver);
> +
> +MODULE_AUTHOR("Dragos Bogdan <dragos.bogdan@analog.com>");
> +MODULE_AUTHOR("Pop Ioan Daniel <pop.ioan-daniel@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD7405 driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_BACKEND");

