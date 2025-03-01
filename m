Return-Path: <linux-iio+bounces-16218-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF397A4A856
	for <lists+linux-iio@lfdr.de>; Sat,  1 Mar 2025 04:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F0E67A96C7
	for <lists+linux-iio@lfdr.de>; Sat,  1 Mar 2025 03:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812631ADC9B;
	Sat,  1 Mar 2025 03:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/gnFiBd"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5C32CA8;
	Sat,  1 Mar 2025 03:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740800087; cv=none; b=sRSqzYprrzm1nx3BsOZyQnPI1KRwehfdwq7+X8roKScg7MFfBrrgEEZPvv0mXqGOu8U/wp59v/KTGg8lvqO/Zfj6NmEwffZmKTx3wCnCK7Af5nVlyQJ9G6Rrj6jp0slSCGHcNmw8HqEEYuhdReTh1gJI3zHFL5HXmFHKPHrodhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740800087; c=relaxed/simple;
	bh=tAJNw2MDGLpKl93xpuAYLKLGIAWdQ8TUaSUVndweFds=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NujZjFcwn9hNyO8sfkJuYgyaqP0XIhYZc//yDhB3BvuURhWCIQKVXxqCmWcNSXm1fusZCaT5CV7kVpF8WXq5uhd3S7F0UCWUHOE5exHbZouC0Hv+HOwk6w4x+wEXJRFoJsOTnz40NSjcS2rDrAd1nAP8BZZYbCxtvbr0dHXjm3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/gnFiBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0621C4CEDD;
	Sat,  1 Mar 2025 03:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740800086;
	bh=tAJNw2MDGLpKl93xpuAYLKLGIAWdQ8TUaSUVndweFds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r/gnFiBdbhTk77m8x/7T1N/RoHmTyTOKUTDeoExUeG4jKnOq8Tpg8FFPQuwH3bKao
	 P3MOpQIAwXjstduqGjiPsGBtNXUMiz9O4bxgOZn9LD7ot1HEIzFwtqAJweK/B0Ak2E
	 KgdctjEidl/MBfbo1jM58cxjw0Z6jn41DSnRaZVuA2CLsHbpS4j8v0pVXigTgxR2gW
	 8gQbsAGIq74G5GSAULbsVqYY4RpEeDM3iFRF5dc3ES91q+EuWTKGwN7/YU2KDS+NP8
	 TSicT6qcMniR2lbbRAFazOug50agdl53DgU/94NEvV3N6ErUh5+47VwJUxsRvM8P5i
	 Imgfft+VZaVlA==
Date: Sat, 1 Mar 2025 03:34:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan
 Hunter <jonathanh@nvidia.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Emil Gedenryd
 <emil.gedenryd@axis.com>, Arthur Becker <arthur.becker@sentec.com>, Mudit
 Sharma <muditsharma.info@gmail.com>, Per-Daniel Olsson
 <perdaniel.olsson@axis.com>, Subhajit Ghosh
 <subhajit.ghosh@tweaklogic.com>, Ivan Orlov <ivan.orlov0322@gmail.com>,
 David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: light: Add support for AL3000a illuminance
 sensor
Message-ID: <20250301033428.34b71e4d@jic23-huawei>
In-Reply-To: <CAPVz0n1xCFKzCFf7oM0vYKLQX1eb4_JnehVNPz0Cpxfb5COfsA@mail.gmail.com>
References: <20250217140336.107476-1-clamor95@gmail.com>
	<20250217140336.107476-3-clamor95@gmail.com>
	<20250222125335.177fc746@jic23-huawei>
	<CAPVz0n3YHgct6x_3-mhzmTOTejLj19xDLm9C8Dqe-GHv8fJBrA@mail.gmail.com>
	<20250222172536.5fb73658@jic23-huawei>
	<CAPVz0n1xCFKzCFf7oM0vYKLQX1eb4_JnehVNPz0Cpxfb5COfsA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 22 Feb 2025 19:27:22 +0200
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> =D1=81=D0=B1, 22 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 19:25 Jo=
nathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Sat, 22 Feb 2025 14:56:41 +0200
> > Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> > =20
> > > =D1=81=D0=B1, 22 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 14:5=
3 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5: =20
> > > >
> > > > On Mon, 17 Feb 2025 16:03:35 +0200
> > > > Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> > > > =20
> > > > > AL3000a is a simple I2C-based ambient light sensor, which is
> > > > > closely related to AL3010 and AL3320a, but has significantly
> > > > > different way of processing data generated by the sensor.
> > > > >
> > > > > Tested-by: Robert Eckelmann <longnoserob@gmail.com>
> > > > > Tested-by: Antoni Aloy Torrens <aaloytorrens@gmail.com>
> > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > Reviewed-by: David Heidelberg <david@ixit.cz> =20
> > > >
> > > > Whilst I am confused by earlier statements about not
> > > > having information on the conversion to illuminance values, I'm
> > > > going to assume the look up table in here is based on some
> > > > reasonable data from somewhere and hence that this is a sensor
> > > > with appropriate filtering of the light to be able to do a non line=
ar
> > > > conversion from the value read and standard light curves.
> > > >
> > > > As such the IIO_LIGHT channel type is fine for this device.
> > > > =20
> > >
> > > Thank you, but IIO_INTENSITY may be proper channel as well, after your
> > > explanations. If you wish, I may upload v5 with swapping LIGHT with
> > > INTENSITY. =20
> >
> > Where does the lux_table set of values come from?
> > That seems to be key question for this driver.
> > =20
>=20
> 3.1.10 kernel driver for this device
Ok. So until we know otherwise let us trust that data as being
correct.

Jonathan

>=20
> > > =20
> > > > Applied patches 1 and 2 to the togreg branch of iio.git.
> > > > Note that I'll initially push this out as testing to allow
> > > > the autobuilders to see if they can find any issues that we missed.
> > > > Patch 3 will need to go via the appropriate SoC tree as normal.
> > > >
> > > > Jonathan
> > > > =20
> > > > > ---
> > > > >  drivers/iio/light/Kconfig   |  10 ++
> > > > >  drivers/iio/light/Makefile  |   1 +
> > > > >  drivers/iio/light/al3000a.c | 209 ++++++++++++++++++++++++++++++=
++++++
> > > > >  3 files changed, 220 insertions(+)
> > > > >  create mode 100644 drivers/iio/light/al3000a.c
> > > > >
> > > > > diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> > > > > index 29ffa8491927..37f83e1d8893 100644
> > > > > --- a/drivers/iio/light/Kconfig
> > > > > +++ b/drivers/iio/light/Kconfig
> > > > > @@ -43,6 +43,16 @@ config ADUX1020
> > > > >        To compile this driver as a module, choose M here: the
> > > > >        module will be called adux1020.
> > > > >
> > > > > +config AL3000A
> > > > > +     tristate "AL3000a ambient light sensor"
> > > > > +     depends on I2C
> > > > > +     help
> > > > > +       Say Y here if you want to build a driver for the Dyna Ima=
ge AL3000a
> > > > > +       ambient light sensor.
> > > > > +
> > > > > +       To compile this driver as a module, choose M here: the
> > > > > +       module will be called al3000a.
> > > > > +
> > > > >  config AL3010
> > > > >       tristate "AL3010 ambient light sensor"
> > > > >       depends on I2C
> > > > > diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makef=
ile
> > > > > index f14a37442712..03f10786273a 100644
> > > > > --- a/drivers/iio/light/Makefile
> > > > > +++ b/drivers/iio/light/Makefile
> > > > > @@ -7,6 +7,7 @@
> > > > >  obj-$(CONFIG_ACPI_ALS)               +=3D acpi-als.o
> > > > >  obj-$(CONFIG_ADJD_S311)              +=3D adjd_s311.o
> > > > >  obj-$(CONFIG_ADUX1020)               +=3D adux1020.o
> > > > > +obj-$(CONFIG_AL3000A)                +=3D al3000a.o
> > > > >  obj-$(CONFIG_AL3010)         +=3D al3010.o
> > > > >  obj-$(CONFIG_AL3320A)                +=3D al3320a.o
> > > > >  obj-$(CONFIG_APDS9300)               +=3D apds9300.o
> > > > > diff --git a/drivers/iio/light/al3000a.c b/drivers/iio/light/al30=
00a.c
> > > > > new file mode 100644
> > > > > index 000000000000..e2fbb1270040
> > > > > --- /dev/null
> > > > > +++ b/drivers/iio/light/al3000a.c
> > > > > @@ -0,0 +1,209 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > +#include <linux/array_size.h>
> > > > > +#include <linux/bitfield.h>
> > > > > +#include <linux/device.h>
> > > > > +#include <linux/err.h>
> > > > > +#include <linux/i2c.h>
> > > > > +#include <linux/mod_devicetable.h>
> > > > > +#include <linux/module.h>
> > > > > +#include <linux/pm.h>
> > > > > +#include <linux/regmap.h>
> > > > > +#include <linux/regulator/consumer.h>
> > > > > +#include <linux/types.h>
> > > > > +
> > > > > +#include <linux/iio/iio.h>
> > > > > +
> > > > > +#define AL3000A_REG_SYSTEM           0x00
> > > > > +#define AL3000A_REG_DATA             0x05
> > > > > +
> > > > > +#define AL3000A_CONFIG_ENABLE                0x00
> > > > > +#define AL3000A_CONFIG_DISABLE               0x0b
> > > > > +#define AL3000A_CONFIG_RESET         0x0f
> > > > > +#define AL3000A_GAIN_MASK            GENMASK(5, 0)
> > > > > +
> > > > > +/*
> > > > > + * These are pre-calculated lux values based on possible output =
of sensor
> > > > > + * (range 0x00 - 0x3F)
> > > > > + */
> > > > > +static const u32 lux_table[] =3D {
> > > > > +     1, 1, 1, 2, 2, 2, 3, 4,                                 /* =
0 - 7 */
> > > > > +     4, 5, 6, 7, 9, 11, 13, 16,                              /* =
8 - 15 */
> > > > > +     19, 22, 27, 32, 39, 46, 56, 67,                         /* =
16 - 23 */
> > > > > +     80, 96, 116, 139, 167, 200, 240, 289,                   /* =
24 - 31 */
> > > > > +     347, 416, 499, 600, 720, 864, 1037, 1245,               /* =
32 - 39 */
> > > > > +     1495, 1795, 2155, 2587, 3105, 3728, 4475, 5373,         /* =
40 - 47 */
> > > > > +     6450, 7743, 9296, 11160, 13397, 16084, 19309, 23180,    /* =
48 - 55 */
> > > > > +     27828, 33408, 40107, 48148, 57803, 69393, 83306, 100000 /* =
56 - 63 */
> > > > > +}; =20
> > > > =20
> > =20
>=20


