Return-Path: <linux-iio+bounces-6946-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E68917F43
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 13:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D329D2813AF
	for <lists+linux-iio@lfdr.de>; Wed, 26 Jun 2024 11:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB94C17D37E;
	Wed, 26 Jun 2024 11:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klbJ08a5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA8F149C52;
	Wed, 26 Jun 2024 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719400244; cv=none; b=Q6w6mKEiqcnht42SWXAgleqZJXkho+sa12shuu0hhR0YYyb68S8qzkYDg7GZukSkdsSfP4PYrzAgVEMkry2YYW7U58n2AF6XzRnXigjjz7p1ruszjAlb3nElg1d8gc8FauRPTmuVdfVasTEIQbqxRQsBri0KGecpof99vtZj/y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719400244; c=relaxed/simple;
	bh=y5GB7iZxGrVNLx9zEM0w79I4bjgFC4YG83muA1Hj6Bk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tj79gNNSvwcGFQ+cnDb6avSSdzx742ozxHoQQGRc8ssIQ2fKQM4tFiFc4mtk41eAUIZJv+++g4xFybr+lpcEnrdUQmvoJnOd5EJsUJGhVBZoYklE/z0H0tW1FKHHJ8L6E3+tJB6/HB3dOGgBtfEpu2Kl95mhmxRp6gIt+AJrDOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klbJ08a5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-424aa70fbc4so7789705e9.1;
        Wed, 26 Jun 2024 04:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719400241; x=1720005041; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=87aPA93jqh73LcqxNsHjq/adaWYJgqncVxDTzkIZqG8=;
        b=klbJ08a5DwBldfYtpOoyLy+u0qv5o4wd0bJQKMRlWHu5QJyzQzD6aB/OJqatzIKTua
         tUc9mGWepimJ4KWkJXS81Y16x/AQSFnKB+WElkDu8Iepn8P9hL+ce5wCDAZLQvC83AsI
         TQ5XU+JoIrgTaQ8a66/FdhG5j+FV1Jqgd6JUmmVprrH7wOy3OnROhSL1cIhN+xCAvbVW
         V7pXVzVV2A414qHDLfMM+Pptfg67LMYZAxhJBP1hNmRSFwOmdszcPP55YOcQR8qqsWFb
         mbY/sck6qGUo81zjdCBirNRIvWXcjqhUEwg5jbbBDZ4s9iZg+o7dMAIlU//d18l77o2v
         n27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719400241; x=1720005041;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=87aPA93jqh73LcqxNsHjq/adaWYJgqncVxDTzkIZqG8=;
        b=bOq9z1dw+gCiQ22kDqLJPTkFkTg2TvCFsjtJ51ZVL7FmvXnPDr34U3zFYKDQ9WM6ML
         4rt/2Iq0cXmxGySRYyh7tkMXx12yGT5j7J2HzXCQsiPJue0s7U6rl3sVcQz6zJz3UYyN
         qKfIk40b6316GvipUSW0e+QUV+1/rcYCJbqq510PrZSLkXYkMiXGbOtAZpsFnlmI82JP
         1fOXaG6lxTPQGmBoVcXf87PPf83FS/e2SQEmBgM0m9NgGUpb4AGWqN/SoG9GuLKcktqY
         iBjV9A3OVLesWvyUjHOGAK3Cyls48PNhkNarTX7zPALQGTZeqzTlC6p/ZjQlMFyKckY7
         NC0g==
X-Forwarded-Encrypted: i=1; AJvYcCWYi1iE+A1KeeR1mJI/HvvC+VTKLrAQuKy3ABfZNIRxWXfjPK0D1ZqLrS+gP+3gVm3JzF7xWb8WDC4upjJ6HdvONmUaEeOgNyVqQ2d4wuPRw/DowrngAhTHWGJ46SXVHAQCL+pTEPY5Kf6HzzEEXMB7EFEPf9gmxp5gtC0qoqUYfVenVA==
X-Gm-Message-State: AOJu0Yw0vcdYrlJHpHxoCK5Uio9lCFaYF81VV3cEtW4fJ6mYp7U/YVWE
	WbXcPuvg3SxZ5GnEKsSFDu4SoMPxSThEP2VeTV32CGvV8zUdHJs3
X-Google-Smtp-Source: AGHT+IEf52+IKIte1UwZtSbMg1MFU4zo8snbtBy8CVYafBcPTevpxEZODaBrOTFHM9OTyO9pQ8/dxA==
X-Received: by 2002:a05:600c:5686:b0:423:668:4c39 with SMTP id 5b1f17b1804b1-4248cc18115mr76449425e9.1.1719400241030;
        Wed, 26 Jun 2024 04:10:41 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c8280962sm21609355e9.34.2024.06.26.04.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 04:10:40 -0700 (PDT)
Message-ID: <2c8127ab4e26cc3b12793c942435ccd6cb9f5432.camel@gmail.com>
Subject: Re: [PATCH v4 5/5] iio: dac: ltc2664: Add driver for LTC2664 and
 LTC2672
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Kim Seer Paller <kimseer.paller@analog.com>,
 linux-kernel@vger.kernel.org,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Lars-Peter Clausen <lars@metafoo.de>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Dimitri
 Fedrau <dima.fedrau@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Michael
 Hennerich <michael.hennerich@analog.com>
Date: Wed, 26 Jun 2024 13:14:32 +0200
In-Reply-To: <20240619064904.73832-6-kimseer.paller@analog.com>
References: <20240619064904.73832-1-kimseer.paller@analog.com>
	 <20240619064904.73832-6-kimseer.paller@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-19 at 14:49 +0800, Kim Seer Paller wrote:
> LTC2664 4 channel, 12-/16-Bit Voltage Output SoftSpan DAC
> LTC2672 5 channel, 12-/16-Bit Current Output Softspan DAC
>=20
> Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> ---

Just minor nits... Anyways:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/dac/Kconfig=C2=A0=C2=A0 |=C2=A0 11 +
> =C2=A0drivers/iio/dac/Makefile=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/dac/ltc2664.c | 755 +++++++++++++++++++++++++++++++++++=
+++
> =C2=A04 files changed, 768 insertions(+)
> =C2=A0create mode 100644 drivers/iio/dac/ltc2664.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f4a5b5bc8ccc..7a02d9a196fb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13082,6 +13082,7 @@ S:	Supported
> =C2=A0W:	https://ez.analog.com/linux-software-drivers
> =C2=A0F:	Documentation/devicetree/bindings/iio/dac/adi,ltc2664.yaml
> =C2=A0F:	Documentation/devicetree/bindings/iio/dac/adi,ltc2672.yaml
> +F:	drivers/iio/dac/ltc2664.c
> =C2=A0
> =C2=A0LTC2688 IIO DAC DRIVER
> =C2=A0M:	Nuno S=C3=A1 <nuno.sa@analog.com>
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index fb48dddbcc20..3a7691db3998 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -371,6 +371,17 @@ config LTC2632
> =C2=A0	=C2=A0 To compile this driver as a module, choose M here: the
> =C2=A0	=C2=A0 module will be called ltc2632.
> =C2=A0
> +config LTC2664
> +	tristate "Analog Devices LTC2664 and LTC2672 DAC SPI driver"
> +	depends on SPI
> +	select REGMAP
> +	help
> +	=C2=A0 Say yes here to build support for Analog Devices
> +	=C2=A0 LTC2664 and LTC2672 converters (DAC).
> +
> +	=C2=A0 To compile this driver as a module, choose M here: the
> +	=C2=A0 module will be called ltc2664.
> +
> =C2=A0config M62332
> =C2=A0	tristate "Mitsubishi M62332 DAC driver"
> =C2=A0	depends on I2C
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 8432a81a19dc..2cf148f16306 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -37,6 +37,7 @@ obj-$(CONFIG_DS4424) +=3D ds4424.o
> =C2=A0obj-$(CONFIG_LPC18XX_DAC) +=3D lpc18xx_dac.o
> =C2=A0obj-$(CONFIG_LTC1660) +=3D ltc1660.o
> =C2=A0obj-$(CONFIG_LTC2632) +=3D ltc2632.o
> +obj-$(CONFIG_LTC2664) +=3D ltc2664.o
> =C2=A0obj-$(CONFIG_LTC2688) +=3D ltc2688.o
> =C2=A0obj-$(CONFIG_M62332) +=3D m62332.o
> =C2=A0obj-$(CONFIG_MAX517) +=3D max517.o
> diff --git a/drivers/iio/dac/ltc2664.c b/drivers/iio/dac/ltc2664.c
> new file mode 100644
> index 000000000000..9b73b9c6a7a7
> --- /dev/null
> +++ b/drivers/iio/dac/ltc2664.c
> @@ -0,0 +1,755 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * LTC2664 4 channel, 12-/16-Bit Voltage Output SoftSpan DAC driver
> + * LTC2672 5 channel, 12-/16-Bit Current Output Softspan DAC driver
> + *
> + * Copyright 2024 Analog Devices Inc.
> + */
> +
>=20

...

> +
> +static int ltc2664_dac_code_read(struct ltc2664_state *st, u32 chan, u32
> input,
> +				 u32 *code)
> +{
> +	guard(mutex)(&st->lock);
> +	*code =3D st->channels[chan].raw[input];
> +
> +	return 0;

no need for an error code...

...

>=20
> +static int ltc2664_probe(struct spi_device *spi)
> +{
> +	static const char * const regulators[] =3D { "vcc", "iovcc", "v-neg" };
> +	const struct ltc2664_chip_info *chip_info;
> +	struct device *dev =3D &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ltc2664_state *st;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +	st->spi =3D spi;
> +
> +	chip_info =3D spi_get_device_match_data(spi);
> +	if (!chip_info)
> +		return -ENODEV;
> +
> +	st->chip_info =3D chip_info;
> +
> +	mutex_init(&st->lock);
> +
> +	st->regmap =3D devm_regmap_init_spi(spi, &ltc2664_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to init regmap");
> +
> +	ret =3D devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulators),
> +					=C2=A0=C2=A0=C2=A0=C2=A0 regulators);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable
> regulators\n");
> +
> +	ret =3D devm_regulator_get_enable_read_voltage(dev, "ref");
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to get vref
> voltage\n");
> +	else if (ret =3D=3D -ENODEV)
> +		st->vref_mv =3D chip_info->internal_vref_mv;
> +	else
> +		st->vref_mv =3D ret / 1000;

This could be:
if (ret < 0 && ret !=3D -ENODEV)
	return ret;

st->vref_mv =3D ret > 0 ? ret / 1000 :  chip_info->internal_vref_mv;

- Nuno S=C3=A1



