Return-Path: <linux-iio+bounces-15939-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC4FA40880
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 13:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E7219C1FDC
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 12:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D984B20AF85;
	Sat, 22 Feb 2025 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIT/BlcN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F53F20967D;
	Sat, 22 Feb 2025 12:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740229019; cv=none; b=PWENsZeiw/d7pB5cx8AxRx1cY7yOayJ59P8Y7BTQytB7yT+f3p328GHsX6heodcOORTf4tz0eqd5UYmcKkevIEcvK4qOTduW2Nxpm4xZilD5Ab+k0Onqw+JaMBW49ollI6qWGrbCamTjWZXaH8f9iJmrVnucV52Xwck6ko0a7R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740229019; c=relaxed/simple;
	bh=8IZ/LbmxijnwnS5Wk6zqCUEixdVeyxsSt3Ay3oPXIEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdRTSSKWlA60y/y7d2vNeTAQiIzraCB0sL/qrSOP/3IdOUiUOPb+ZyiL1YHJ/7VJbW9RGSvS7OY6Lm8NczKu9agZjRfyUNjfPtddbN3ohN5pPdPhtJP8GayeKZkfhYw/qqVB6rlnKQ+SPdA2Xf4JrYdq06AllJ723b+hs5Vs6bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIT/BlcN; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38f3486062eso2536841f8f.0;
        Sat, 22 Feb 2025 04:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740229012; x=1740833812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nq5GyUaIYlDRd3EDDEZEOqHSDPdiQgTSfqb5SMQ2Bcs=;
        b=HIT/BlcNYFsFHKemEAesDcbqVlXckZoxAc5MN9rxml7MWjoU2/h1Zs1xMnTPVQaCRz
         bD1YHYHcZkshZYQKcnVUx92XrvdeJ6mmWQjwT7z0UazKF7dh6nMZmUomarZrn6LUpWbd
         wBwn/gj5WdsUW6hnTq7+D9W+c7aN7irqEnYOYJYA0bGAvYzUDvRiPeqN+JWJe0arE/0r
         d0moqdH4UyaHuCWys4OxEp2NCyT4keNBoDT0MFVrGSs6v2k62VEQvYlTcwmZx0BTf6Mm
         V6EqdLJTE0PV1lnyYyBs4SnGlfa9DailCovEz+2X8jIhXw6V8TCAKABgbEola6saZnB8
         TyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740229012; x=1740833812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nq5GyUaIYlDRd3EDDEZEOqHSDPdiQgTSfqb5SMQ2Bcs=;
        b=qmn9nJcYGhAPtVLsj/EdSw1QolL/jgYunZWA5VK+q4+PVFxwsWzGDvWmrBmqrG0ITt
         96hlEu4X2ofW2Fq/UBOuZ+w9mCpxpQq3JOWB4M3wCCw59MYYxrKqJNlNcTkSdURscgn1
         k2beBaAOoNwo18+FT1NNpvG3os5P9W6PQuhzINEnexNsvhxgn3rUYVJzqNtaaxlGpFTX
         sy1cYM9wYdXL5d3hW/EJqE3hX2/f3bmzXy1FupzJLB7p95A9WBRy1akA9R4hxQEffyi+
         hJOr1HfN11ZWtSuwQcyh4rRdxRYiDl10iAcZ4J5FWAjcMq9JMJJwij30nRC0xV5m7brW
         x59A==
X-Forwarded-Encrypted: i=1; AJvYcCU/DDRpqhgVxRXkBEUvauqNdSnBwoCl6XK8ttdnCic1q+ugk2m8qGA7ha6YMpRsGQHwt8269i9XiYDbwClk@vger.kernel.org, AJvYcCWkLJwsorLPX0UVjbi4L2Wc3+yOQQQ0McaKpA8/U8xemax5tweqW2F4CnwT8URCrM/ar9xZOHwy8UXA@vger.kernel.org, AJvYcCWlY2NEK61xqt2rtGeXIQpFOKdH9QHZd/1Ml/Hjwp3ue2+ue52OK5jBXwaHWfmBCEa2TDbfR69yfmVAooM=@vger.kernel.org, AJvYcCXAft5Z2Y391XTnp0GqvafDe7TsPF2Ky+3J/a1NOPCn2b3SAeMDkIap8OXTZfFKGwswJZV3YV5C1deL@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnm3uFiOH4bJRuGxY0jo3BuKXFx31imznFGBOBGvWeKxQCT1gV
	AYXKRBeypXAtfa9iMjQbOpsDhgGQrJadfAidBZRZft++rCkJUICDbpXUFvgKuexOorUCU/9eS5L
	2+wtvmhx36xygZfb7yVmmw8d2S38=
X-Gm-Gg: ASbGnctO2VbvISDXXAXLVAevSVKhBrU2foQfKKp+dXU3NAWHppJiVg1b1w8RlW6EKbN
	o55b4Pzm/KzamQpuWqpB6Ll+DI/g0o4QOQFea48H1So+FtrJz1M4IKq39FYWc6Tnz6bWQY32DoA
	VVzYMaFLFr
X-Google-Smtp-Source: AGHT+IHIDggKR+yKK9D9Yyb6H424EqvU3hTegUkb9IhWsN5PEs7XQiqBrndBOt3+zJZjms5yK2EBcnBDUg39WTIHA8g=
X-Received: by 2002:a5d:6c6d:0:b0:38d:bccf:f342 with SMTP id
 ffacd0b85a97d-38f6f0b129amr6005515f8f.43.1740229012278; Sat, 22 Feb 2025
 04:56:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217140336.107476-1-clamor95@gmail.com> <20250217140336.107476-3-clamor95@gmail.com>
 <20250222125335.177fc746@jic23-huawei>
In-Reply-To: <20250222125335.177fc746@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 22 Feb 2025 14:56:41 +0200
X-Gm-Features: AWEUYZn4S_IPka8VLNc4ei4YIi0rnykTur_fXrhNkoBHkfkVFBhw8dfHxuvyBGI
Message-ID: <CAPVz0n3YHgct6x_3-mhzmTOTejLj19xDLm9C8Dqe-GHv8fJBrA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] iio: light: Add support for AL3000a illuminance sensor
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Emil Gedenryd <emil.gedenryd@axis.com>, 
	Arthur Becker <arthur.becker@sentec.com>, Mudit Sharma <muditsharma.info@gmail.com>, 
	Per-Daniel Olsson <perdaniel.olsson@axis.com>, Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, 
	Ivan Orlov <ivan.orlov0322@gmail.com>, David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D0=B1, 22 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 14:53 Jona=
than Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, 17 Feb 2025 16:03:35 +0200
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > AL3000a is a simple I2C-based ambient light sensor, which is
> > closely related to AL3010 and AL3320a, but has significantly
> > different way of processing data generated by the sensor.
> >
> > Tested-by: Robert Eckelmann <longnoserob@gmail.com>
> > Tested-by: Antoni Aloy Torrens <aaloytorrens@gmail.com>
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > Reviewed-by: David Heidelberg <david@ixit.cz>
>
> Whilst I am confused by earlier statements about not
> having information on the conversion to illuminance values, I'm
> going to assume the look up table in here is based on some
> reasonable data from somewhere and hence that this is a sensor
> with appropriate filtering of the light to be able to do a non linear
> conversion from the value read and standard light curves.
>
> As such the IIO_LIGHT channel type is fine for this device.
>

Thank you, but IIO_INTENSITY may be proper channel as well, after your
explanations. If you wish, I may upload v5 with swapping LIGHT with
INTENSITY.

> Applied patches 1 and 2 to the togreg branch of iio.git.
> Note that I'll initially push this out as testing to allow
> the autobuilders to see if they can find any issues that we missed.
> Patch 3 will need to go via the appropriate SoC tree as normal.
>
> Jonathan
>
> > ---
> >  drivers/iio/light/Kconfig   |  10 ++
> >  drivers/iio/light/Makefile  |   1 +
> >  drivers/iio/light/al3000a.c | 209 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 220 insertions(+)
> >  create mode 100644 drivers/iio/light/al3000a.c
> >
> > diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> > index 29ffa8491927..37f83e1d8893 100644
> > --- a/drivers/iio/light/Kconfig
> > +++ b/drivers/iio/light/Kconfig
> > @@ -43,6 +43,16 @@ config ADUX1020
> >        To compile this driver as a module, choose M here: the
> >        module will be called adux1020.
> >
> > +config AL3000A
> > +     tristate "AL3000a ambient light sensor"
> > +     depends on I2C
> > +     help
> > +       Say Y here if you want to build a driver for the Dyna Image AL3=
000a
> > +       ambient light sensor.
> > +
> > +       To compile this driver as a module, choose M here: the
> > +       module will be called al3000a.
> > +
> >  config AL3010
> >       tristate "AL3010 ambient light sensor"
> >       depends on I2C
> > diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> > index f14a37442712..03f10786273a 100644
> > --- a/drivers/iio/light/Makefile
> > +++ b/drivers/iio/light/Makefile
> > @@ -7,6 +7,7 @@
> >  obj-$(CONFIG_ACPI_ALS)               +=3D acpi-als.o
> >  obj-$(CONFIG_ADJD_S311)              +=3D adjd_s311.o
> >  obj-$(CONFIG_ADUX1020)               +=3D adux1020.o
> > +obj-$(CONFIG_AL3000A)                +=3D al3000a.o
> >  obj-$(CONFIG_AL3010)         +=3D al3010.o
> >  obj-$(CONFIG_AL3320A)                +=3D al3320a.o
> >  obj-$(CONFIG_APDS9300)               +=3D apds9300.o
> > diff --git a/drivers/iio/light/al3000a.c b/drivers/iio/light/al3000a.c
> > new file mode 100644
> > index 000000000000..e2fbb1270040
> > --- /dev/null
> > +++ b/drivers/iio/light/al3000a.c
> > @@ -0,0 +1,209 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +#include <linux/array_size.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/i2c.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/pm.h>
> > +#include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/types.h>
> > +
> > +#include <linux/iio/iio.h>
> > +
> > +#define AL3000A_REG_SYSTEM           0x00
> > +#define AL3000A_REG_DATA             0x05
> > +
> > +#define AL3000A_CONFIG_ENABLE                0x00
> > +#define AL3000A_CONFIG_DISABLE               0x0b
> > +#define AL3000A_CONFIG_RESET         0x0f
> > +#define AL3000A_GAIN_MASK            GENMASK(5, 0)
> > +
> > +/*
> > + * These are pre-calculated lux values based on possible output of sen=
sor
> > + * (range 0x00 - 0x3F)
> > + */
> > +static const u32 lux_table[] =3D {
> > +     1, 1, 1, 2, 2, 2, 3, 4,                                 /* 0 - 7 =
*/
> > +     4, 5, 6, 7, 9, 11, 13, 16,                              /* 8 - 15=
 */
> > +     19, 22, 27, 32, 39, 46, 56, 67,                         /* 16 - 2=
3 */
> > +     80, 96, 116, 139, 167, 200, 240, 289,                   /* 24 - 3=
1 */
> > +     347, 416, 499, 600, 720, 864, 1037, 1245,               /* 32 - 3=
9 */
> > +     1495, 1795, 2155, 2587, 3105, 3728, 4475, 5373,         /* 40 - 4=
7 */
> > +     6450, 7743, 9296, 11160, 13397, 16084, 19309, 23180,    /* 48 - 5=
5 */
> > +     27828, 33408, 40107, 48148, 57803, 69393, 83306, 100000 /* 56 - 6=
3 */
> > +};
>

