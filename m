Return-Path: <linux-iio+bounces-15978-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EBFA40AA5
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 18:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59F1B189DB14
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 17:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7AB20AF88;
	Sat, 22 Feb 2025 17:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gY+oOA88"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC963206F21;
	Sat, 22 Feb 2025 17:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740245257; cv=none; b=gpzND+1IkXdiUooQX31A5z6yev2thQGqp0Y+INZj5XkVCJxMP2WqUeUz79/6GeAXh/15m7ZmVAWShOPpbJLs8QpEJPr/kxp3YPfVpMHmMDwT6edD2QIo3pi38ssNtefCT0q71eY4JB0+Gz+Z57cxImxu9HjpACaDWz27mAkLLug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740245257; c=relaxed/simple;
	bh=kTto4xIKc9Je695ZIz56kxuh+GmQXgr0EbFNnTRPPEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E7w/JoKUZBUuZUeBApv4ojWlZAsGGCDcUVGFmwiyYjN64S9ve1rxYhsYJZHTwcx6u11pu+Jxnj64PyWEHknJrm7nmI7HEJWCSOVI+OpjHikNw3MyX4occYvkxsZioYSGyUyIsIgonrELPLOKQyASymcGXgzEr+thezFn+Uixy6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gY+oOA88; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38f265c6cb0so1574588f8f.2;
        Sat, 22 Feb 2025 09:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740245254; x=1740850054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbsnDqo+jKFfG9OjzvRLLLNExokXEbWLQJQYr/9dkCM=;
        b=gY+oOA88Lc/E++ExHm7d/DiODlhWMywe1EploJ827SszK9obAfGPeZJp00eETlq3Bb
         ISOctJsyl1aqMaDRL/gMzP0CMjwTw74nRJgbhE9vHrUos6ivwS4E7A1kggCXB+FTJBHv
         G1Le/L6dHKKxwtEo/YAJOWEJpjHf/4j9DLiZcI/KV0goQM+36JAE+R6Dml/+8Bx7i8Wm
         9FPaURoZp166YzDaCcb0u0vr71//wRRGp/9oF86Q5J+uukP1KipzDUIUYeknGzwGWjCr
         qbDnMxAJV7sU7zzvZpGupaCO98PHMsb73W8I8m8JUD396/gIGoFXR9+4NMmTRlKbIsOK
         fRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740245254; x=1740850054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KbsnDqo+jKFfG9OjzvRLLLNExokXEbWLQJQYr/9dkCM=;
        b=EjnYOGg4cJcjNU78b5MzNX1ruEOG6NRsT9XvF8uBUyj9VuR9qZ6Ai4G6l1b8XFZ9TN
         FToeykXmKgvmm0uB4zOjJHTuuwsxIQcWsmwdQGb6UCzEWAjvI8KddSqj4EA6T+oZ28er
         7XCOZ9cMjPhpgoTMw8+roUXVEJtvXNxL9zHf7mN6xXZW1M0duyuZohEmmSrBg53lQsM9
         byW89sbBtp49DNX+oCU4ha6x11dh8U7nZXHhgNGVJIyt6EuTLlij12ZfxS7ramX6VKeb
         wR3UIPV/1DQs64UUl2s6PcLyNJVN4B+JyXtFB1as5GSZvESCA1PMTzSJVCx/MqX6Qx36
         /0sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIO24nTwiIgzPiVkzRsmO2rygHksYKY84dFM7o6WHNXJU0R1VIniC8oBk5bqJeQlzcf727IEa/SEBC@vger.kernel.org, AJvYcCWBjenEUfQPY+Kj5g6v2m3gyEpaYEnJ6Gv5rwtZ0fNke1bU2u23TsCFlZz/8ANHunVNMbbg6Os5li7rlaBh@vger.kernel.org, AJvYcCXMJxcIyciuhMkzrALe/mtwTYL6XNYiTViR3+D41fDB1XYGLKyXQmoPN3Jh7Wb9Zhrkln33HGqDS+WES5M=@vger.kernel.org, AJvYcCXiBAy1OjptAj7AxGz8eH30X9sl2VF8h5Od1co/rTRBRuXtazbkokMb9uhx4rHyfwB+F+aSnRjTSUP1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8/DDL35WQXv7JfGKkyGcZqJLBMnEJlcIcko3pyxtMYumaBRG0
	iGEDAh/adEl9Mg2LdhInsCFXlsWA81BMDG7S2AfpHB8bO6jcdeZ2xb2zDdyBmB0jMUetEkpDb3M
	WPGp1W3KIgck5v6fTIfVIDKnHqq0=
X-Gm-Gg: ASbGncv6KOavgKP6HLQW/M9lZNQE9A4nVJhoO+NWrpGM1R6Oow9UJb3kAwoHiFFBEFz
	kruBGnI6hYS6zU/yIyRA3jV6uUrqYbFPeEZ6ZrHGYYNbdNs9WcjYrb5HoNHTzY3uUDRxBe9MYOa
	SvezR+SH7j
X-Google-Smtp-Source: AGHT+IHTghOHN6kJstZnfUDas3illVWVKVD1L/KYEQOwU4ukfEOZ1p5i3lCyE5jNp0NA+6QNzUegyMxRltNkAdNG1UI=
X-Received: by 2002:a05:6000:1541:b0:38d:d767:364 with SMTP id
 ffacd0b85a97d-38f70789915mr5506556f8f.13.1740245253661; Sat, 22 Feb 2025
 09:27:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217140336.107476-1-clamor95@gmail.com> <20250217140336.107476-3-clamor95@gmail.com>
 <20250222125335.177fc746@jic23-huawei> <CAPVz0n3YHgct6x_3-mhzmTOTejLj19xDLm9C8Dqe-GHv8fJBrA@mail.gmail.com>
 <20250222172536.5fb73658@jic23-huawei>
In-Reply-To: <20250222172536.5fb73658@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 22 Feb 2025 19:27:22 +0200
X-Gm-Features: AWEUYZkvzLoKnhe8MH6tySC-2B2ZPIvM1dNMIpsUstCBCrCwQzT8EZK5RGz6gdI
Message-ID: <CAPVz0n1xCFKzCFf7oM0vYKLQX1eb4_JnehVNPz0Cpxfb5COfsA@mail.gmail.com>
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

=D1=81=D0=B1, 22 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 19:25 Jona=
than Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sat, 22 Feb 2025 14:56:41 +0200
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > =D1=81=D0=B1, 22 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 14:53 =
Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Mon, 17 Feb 2025 16:03:35 +0200
> > > Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> > >
> > > > AL3000a is a simple I2C-based ambient light sensor, which is
> > > > closely related to AL3010 and AL3320a, but has significantly
> > > > different way of processing data generated by the sensor.
> > > >
> > > > Tested-by: Robert Eckelmann <longnoserob@gmail.com>
> > > > Tested-by: Antoni Aloy Torrens <aaloytorrens@gmail.com>
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > Reviewed-by: David Heidelberg <david@ixit.cz>
> > >
> > > Whilst I am confused by earlier statements about not
> > > having information on the conversion to illuminance values, I'm
> > > going to assume the look up table in here is based on some
> > > reasonable data from somewhere and hence that this is a sensor
> > > with appropriate filtering of the light to be able to do a non linear
> > > conversion from the value read and standard light curves.
> > >
> > > As such the IIO_LIGHT channel type is fine for this device.
> > >
> >
> > Thank you, but IIO_INTENSITY may be proper channel as well, after your
> > explanations. If you wish, I may upload v5 with swapping LIGHT with
> > INTENSITY.
>
> Where does the lux_table set of values come from?
> That seems to be key question for this driver.
>

3.1.10 kernel driver for this device

> >
> > > Applied patches 1 and 2 to the togreg branch of iio.git.
> > > Note that I'll initially push this out as testing to allow
> > > the autobuilders to see if they can find any issues that we missed.
> > > Patch 3 will need to go via the appropriate SoC tree as normal.
> > >
> > > Jonathan
> > >
> > > > ---
> > > >  drivers/iio/light/Kconfig   |  10 ++
> > > >  drivers/iio/light/Makefile  |   1 +
> > > >  drivers/iio/light/al3000a.c | 209 ++++++++++++++++++++++++++++++++=
++++
> > > >  3 files changed, 220 insertions(+)
> > > >  create mode 100644 drivers/iio/light/al3000a.c
> > > >
> > > > diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> > > > index 29ffa8491927..37f83e1d8893 100644
> > > > --- a/drivers/iio/light/Kconfig
> > > > +++ b/drivers/iio/light/Kconfig
> > > > @@ -43,6 +43,16 @@ config ADUX1020
> > > >        To compile this driver as a module, choose M here: the
> > > >        module will be called adux1020.
> > > >
> > > > +config AL3000A
> > > > +     tristate "AL3000a ambient light sensor"
> > > > +     depends on I2C
> > > > +     help
> > > > +       Say Y here if you want to build a driver for the Dyna Image=
 AL3000a
> > > > +       ambient light sensor.
> > > > +
> > > > +       To compile this driver as a module, choose M here: the
> > > > +       module will be called al3000a.
> > > > +
> > > >  config AL3010
> > > >       tristate "AL3010 ambient light sensor"
> > > >       depends on I2C
> > > > diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefil=
e
> > > > index f14a37442712..03f10786273a 100644
> > > > --- a/drivers/iio/light/Makefile
> > > > +++ b/drivers/iio/light/Makefile
> > > > @@ -7,6 +7,7 @@
> > > >  obj-$(CONFIG_ACPI_ALS)               +=3D acpi-als.o
> > > >  obj-$(CONFIG_ADJD_S311)              +=3D adjd_s311.o
> > > >  obj-$(CONFIG_ADUX1020)               +=3D adux1020.o
> > > > +obj-$(CONFIG_AL3000A)                +=3D al3000a.o
> > > >  obj-$(CONFIG_AL3010)         +=3D al3010.o
> > > >  obj-$(CONFIG_AL3320A)                +=3D al3320a.o
> > > >  obj-$(CONFIG_APDS9300)               +=3D apds9300.o
> > > > diff --git a/drivers/iio/light/al3000a.c b/drivers/iio/light/al3000=
a.c
> > > > new file mode 100644
> > > > index 000000000000..e2fbb1270040
> > > > --- /dev/null
> > > > +++ b/drivers/iio/light/al3000a.c
> > > > @@ -0,0 +1,209 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +#include <linux/array_size.h>
> > > > +#include <linux/bitfield.h>
> > > > +#include <linux/device.h>
> > > > +#include <linux/err.h>
> > > > +#include <linux/i2c.h>
> > > > +#include <linux/mod_devicetable.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/pm.h>
> > > > +#include <linux/regmap.h>
> > > > +#include <linux/regulator/consumer.h>
> > > > +#include <linux/types.h>
> > > > +
> > > > +#include <linux/iio/iio.h>
> > > > +
> > > > +#define AL3000A_REG_SYSTEM           0x00
> > > > +#define AL3000A_REG_DATA             0x05
> > > > +
> > > > +#define AL3000A_CONFIG_ENABLE                0x00
> > > > +#define AL3000A_CONFIG_DISABLE               0x0b
> > > > +#define AL3000A_CONFIG_RESET         0x0f
> > > > +#define AL3000A_GAIN_MASK            GENMASK(5, 0)
> > > > +
> > > > +/*
> > > > + * These are pre-calculated lux values based on possible output of=
 sensor
> > > > + * (range 0x00 - 0x3F)
> > > > + */
> > > > +static const u32 lux_table[] =3D {
> > > > +     1, 1, 1, 2, 2, 2, 3, 4,                                 /* 0 =
- 7 */
> > > > +     4, 5, 6, 7, 9, 11, 13, 16,                              /* 8 =
- 15 */
> > > > +     19, 22, 27, 32, 39, 46, 56, 67,                         /* 16=
 - 23 */
> > > > +     80, 96, 116, 139, 167, 200, 240, 289,                   /* 24=
 - 31 */
> > > > +     347, 416, 499, 600, 720, 864, 1037, 1245,               /* 32=
 - 39 */
> > > > +     1495, 1795, 2155, 2587, 3105, 3728, 4475, 5373,         /* 40=
 - 47 */
> > > > +     6450, 7743, 9296, 11160, 13397, 16084, 19309, 23180,    /* 48=
 - 55 */
> > > > +     27828, 33408, 40107, 48148, 57803, 69393, 83306, 100000 /* 56=
 - 63 */
> > > > +};
> > >
>

