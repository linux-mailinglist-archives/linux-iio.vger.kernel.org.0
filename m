Return-Path: <linux-iio+bounces-9495-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6BE977D39
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 12:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032371C2114D
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 10:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71151C2459;
	Fri, 13 Sep 2024 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTQjDxAd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2BC1A76A5;
	Fri, 13 Sep 2024 10:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726222968; cv=none; b=Qs9beEHYjz/DmH9YQ6RGvNBcspANad1j70FckRT69XSjtWRXpVm3M7aZkpedteQft2DSnDFOALxxfT2p1Xk0FmWKZyFeY7NufCmzP94X+WmZwrOVH4BR3kjMdVaUcOgSmqHuztu9TSeA3mWZiiduHZqDw/IhfiO9zEG5i+49gm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726222968; c=relaxed/simple;
	bh=d+am7IpLrw/wLFbiF7PXFW32yNnjEXo3zUw8bqjM3rs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BTJsy8Jj+t3dur55A/srrhETEtukHznH+6AEIN1MpNe9rS1W6StneLwbTUdtv52nazOqe8wkV+APacWf3zIUzp8g7r3Qvw03X1valqHOGBCKGBXUSVqUnMD94kyVjr8V07ozKY8RVx7U345WdVJWIoJfSzWD6vVqjpQjrUTE+VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTQjDxAd; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374d29ad870so565514f8f.3;
        Fri, 13 Sep 2024 03:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726222965; x=1726827765; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=18HJPmcqEXXyJvV8T8rWQko0aJG/egli0EmhKuMX3Mk=;
        b=LTQjDxAdl/q2eQ2glBp2rgOw1E0urzHHEVCvFOk1y3LAVd5LDERcPqWegWWtdnl/W6
         ugC/2Y/d47EwSizEXJy4OGw5AK007bUZzhr23p17fLT5tFtk3SLDYS2MLokoX0UsbT+o
         ErGahtobAQst6lUKITFKEPnlo9ZjNMaedwwRbIR3uGFi1lQXvhReT0FrRASQQKSlE15K
         5Ca2sOotekMkLvCcaZInmnPbe4Y8lVjPJpmNKm5tr2UvqJ/WI8zDt3cp4tQEGCWr6OP8
         AIeEWdcjEAtGP3g860wcNEy1CHStHouWVzBxuW+PR/5Ban5ctHaQLmjORtzdcd9cjnMx
         S0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726222965; x=1726827765;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=18HJPmcqEXXyJvV8T8rWQko0aJG/egli0EmhKuMX3Mk=;
        b=rQYiuYt121xzSDI9IQ1pdQyI/M1UdDcMc7WXsyYapxn0PoRmVj1xQyZcN3n8XzmlxD
         wMaWs7Bfc0ankAM9c14acSlF2BahWwGEljweOrxFWBrUn28/x+wg0NbkQMBoRoFGxvLw
         MZZ3nCqDSmAEwjKIslOiuWgWIBbG1cDwuJaWpjsrtas9qUJK4uGzT+6lXCu9NSdcayJE
         htMFVYVo8J3FvaYuI1eKd78M1qL490Q2D6QEoGvEVoswCooF3uaHv3T+qvV9xh6htq30
         honWgmSF/N1aMX58oS25Y9Pzmsuu20YUAkNJ7J2n2LElKZTVS8o4YI60bJlCeCmBPZVr
         eFPA==
X-Forwarded-Encrypted: i=1; AJvYcCU9Zwuv5U2DguA4BekHPjNRsSseY1f2w3kKjVtJIIAcYiCeKcLY9L/UF3mRwp0nXQfF47fZiFJx0eKc@vger.kernel.org, AJvYcCW8F+Q8ZbcakZN2x1kPkXQzJBvznHiuIeOLfYMPEoWtm2e5Oal6+csUsPtFC4RqIVsjQJGFnarvxTz9RBc2@vger.kernel.org, AJvYcCXjGJDbDjHERXn4iUZcaQxVxUaeBQScV36nESmGk7eGXsMl6LRUiyqqjS8Og5uwNWyYfMZ+9NSQhBYk@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2IFg0GaKC+L82XmvSzuqCVFR2cClJMKNlS3FCmXKaIGwXMg42
	b6i59NIT+6xLkV/I3CoprPX2GkrAmDNiOsjeGtdvlUUEC7Z5QCx10qit2ZthrtM=
X-Google-Smtp-Source: AGHT+IE2oRO8gzP3HuOLAgzaQwrEZIClU2McKF3cmYlx766LK0w97Dkkp1mnfnXoUl27u/X4QXioPQ==
X-Received: by 2002:a5d:4cc6:0:b0:368:5a8c:580b with SMTP id ffacd0b85a97d-378d61e2b19mr1428775f8f.19.1726222964101;
        Fri, 13 Sep 2024 03:22:44 -0700 (PDT)
Received: from ?IPv6:2001:a61:341e:1201:c434:b5b1:98a6:efed? ([2001:a61:341e:1201:c434:b5b1:98a6:efed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc01d4617sm95916615e9.0.2024.09.13.03.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 03:22:43 -0700 (PDT)
Message-ID: <3c2e0d65225f20c04722f017f7866a47c346782e.camel@gmail.com>
Subject: Re: [PATCH 2/6] iio: adc: ad4030: add driver for ad4030-24
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Esteban Blanc
 <eblanc@baylibre.com>,  Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>,  Jonathan Cameron
 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Nuno Sa
 <nuno.sa@analog.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Date: Fri, 13 Sep 2024 12:22:43 +0200
In-Reply-To: <28fa2ba9-9b02-43ac-b070-85a173a5db60@baylibre.com>
References: <20240822-eblanc-ad4630_v1-v1-0-5c68f3327fdd@baylibre.com>
	 <20240822-eblanc-ad4630_v1-v1-2-5c68f3327fdd@baylibre.com>
	 <28fa2ba9-9b02-43ac-b070-85a173a5db60@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Esteban,

Just one remark...

On Thu, 2024-08-22 at 14:39 -0500, David Lechner wrote:
> On 8/22/24 7:45 AM, Esteban Blanc wrote:
> > This adds a new driver for the Analog Devices INC. AD4030-24 ADC.
> >=20
> > The driver implements basic support for the AD4030-24 1 channel
> > differential ADC with hardware gain and offset control.
> >=20
> > Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
> > ---
> > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0 13 +
> > =C2=A0drivers/iio/adc/Makefile |=C2=A0=C2=A0 1 +
> > =C2=A0drivers/iio/adc/ad4030.c | 854 ++++++++++++++++++++++++++++++++++=
+++++++++++++
> > =C2=A04 files changed, 869 insertions(+)
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f17c42bea19c..6a5a0e7b7a51 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -420,6 +420,7 @@ R:	Esteban Blanc <eblanc@baylibre.com>
> > =C2=A0S:	Supported
> > =C2=A0W:	https://ez.analog.com/linux-software-drivers
> > =C2=A0F:	Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> > +F:	drivers/iio/adc/ad4030.c
> > =C2=A0
> > =C2=A0AD5110 ANALOG DEVICES DIGITAL POTENTIOMETERS DRIVER
> > =C2=A0M:	Mugilraj Dhavachelvan <dmugil2000@gmail.com>
> > diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> > index 88e8ce2e78b3..f4bd05780f6f 100644
> > --- a/drivers/iio/adc/Kconfig
> > +++ b/drivers/iio/adc/Kconfig
> > @@ -33,6 +33,19 @@ config AD4000
> > =C2=A0	=C2=A0 To compile this driver as a module, choose M here: the mo=
dule will be
> > =C2=A0	=C2=A0 called ad4000.
> > =C2=A0
> > +config AD4030
> > +	tristate "Analog Device AD4630 ADC Driver"
> > +	depends on SPI
> > +	depends on GPIOLIB
> > +	select REGMAP_SPI
>=20
> It looks like we are just using REGMAP, not REGMAP_SPI.
>=20
> > +	select IIO_BUFFER
>=20
> And also select IIO_TRIGGERED_BUFFER?
>=20
> > +	help
> > +	=C2=A0 Say yes here to build support for Analog Devices AD4030 and AD=
4630
> > high speed
> > +	=C2=A0 SPI analog to digital converters (ADC).
> > +
> > +	=C2=A0 To compile this driver as a module, choose M here: the module =
will be
> > +	=C2=A0 called ad4030.
> > +
> > =C2=A0config AD4130
> > =C2=A0	tristate "Analog Device AD4130 ADC Driver"
> > =C2=A0	depends on SPI
> > diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> > index 8b80664c6d6b..0e4f833abf0b 100644
> > --- a/drivers/iio/adc/Makefile
> > +++ b/drivers/iio/adc/Makefile
> > @@ -7,6 +7,7 @@
> > =C2=A0obj-$(CONFIG_AB8500_GPADC) +=3D ab8500-gpadc.o
> > =C2=A0obj-$(CONFIG_AD_SIGMA_DELTA) +=3D ad_sigma_delta.o
> > =C2=A0obj-$(CONFIG_AD4000) +=3D ad4000.o
> > +obj-$(CONFIG_AD4030) +=3D ad4030.o
> > =C2=A0obj-$(CONFIG_AD4130) +=3D ad4130.o
> > =C2=A0obj-$(CONFIG_AD4695) +=3D ad4695.o
> > =C2=A0obj-$(CONFIG_AD7091R) +=3D ad7091r-base.o
> > diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> > new file mode 100644
> > index 000000000000..a981dce988e5
> > --- /dev/null
> > +++ b/drivers/iio/adc/ad4030.c
> > @@ -0,0 +1,854 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Analog Devices AD4030 and AD4630 ADC family driver.
> > + *
> > + * Copyright 2024 Analog Devices, Inc.
> > + * Copyright 2024 BayLibre, SAS
> > + *
> > + * based on code from:
> > + *	Analog Devices, Inc.
> > + *	=C2=A0 Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> > + *	=C2=A0 Nuno Sa <nuno.sa@analog.com>
> > + *	=C2=A0 Marcelo Schmitt <marcelo.schmitt@analog.com>
> > + *	=C2=A0 Liviu Adace <liviu.adace@analog.com>
> > + */
> > +	.type =3D IIO_VOLTAGE,						\
> > +	.indexed =3D 1,							\
> > +	.channel =3D _idx * 2 + 2,					\
> > +	.scan_index =3D _idx * 2 + 1,					\
> > +	.extend_name =3D "Channel" #_idx " common byte part",		\
>=20
> Labels are usually one word and reflect the datasheet name.
>=20
> Suggest `"common-mode" #_idx` or `"CM" #_idx` for this one.
>=20

Also, .extend_name is not to be used anymore... In the end of the day IIO w=
ill create
label files anyways but from what I remember about this, extend_name is not=
 to be
directly used this anymore (so other think it's still fine). Instead, use t=
he label
callback.

- Nuno S=C3=A1
>=20
>=20

