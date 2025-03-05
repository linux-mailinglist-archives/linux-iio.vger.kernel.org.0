Return-Path: <linux-iio+bounces-16420-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA0FA50110
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 14:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 800793A3F5E
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 13:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D946824BC05;
	Wed,  5 Mar 2025 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2N9zCYQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F4F248898;
	Wed,  5 Mar 2025 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741182312; cv=none; b=l8zwGfuUrgA3uAbVq2w0JujbC7+b8XIr4+9UqWB40Mdb/Ytm7PmxiTrKtiLMEPm7tfhO/rKGB5UBzS3KCx9Z/JPg8ikB88/s/RNXyADlRIe4phXs7SAbGaN5VwC0fpKFuerRLD6h5bsJwQaJhU2GrqVY2YHMIri5mJzi8EfjpL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741182312; c=relaxed/simple;
	bh=NtUoC0VQyUdE370wsFKvWqUjQFFfXTqScOu1x2M24Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ll5jLvRsZPc6vEZe5l4/HcwjywUrtEMDcsabA/xVGUf0QWHQL6im85w0q+KCPMXKorBAm4no7El+eCF9w8xWiGL29qOk57ldZy7aNnwVaXCuwWwqUx4vHCdHPs1VMoPCwo4HxNMOJXUl4Vi7+/Qjw7gSVInu7eKfxIIKq5lI2kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2N9zCYQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80314C4CEEA;
	Wed,  5 Mar 2025 13:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741182311;
	bh=NtUoC0VQyUdE370wsFKvWqUjQFFfXTqScOu1x2M24Uc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b2N9zCYQiyKajWKuPAN7A9e2NlmNSFw1jku5bIiRlE51oWAQR8XOLEJpKvIemJ9KY
	 0ngWi+lb83jrmf6KLujUcnf4ZNhzStSBXsp7MpXJDRpTXEzYJwzrq94B8UIEKjDWmv
	 d5hqUlARJ0qQ2CN3rQoe1SSP34o2XeC1w5Ln5VAMsbExuivTSHTT6mBoqvH5VpT6Wk
	 J+jqeZwzxADD25eKACQB2spsApEe0QAdzWaAd6+tGzlz3X94/MvZeWDwnt59GAx2aA
	 Ep3H6mWIzYhMeATj/JYBfmQEicHfEUuIohkSZQ5da0nFREPv/B4VNah4ioTDHb4vZw
	 kB8oK6lYGsIMA==
Date: Wed, 5 Mar 2025 13:44:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>, Daniel
 Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Helge
 Deller <deller@gmx.de>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-leds@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mfd: lm3533: convert to use OF
Message-ID: <20250305134455.2843f603@jic23-huawei>
In-Reply-To: <CAPVz0n0jaR=UM7WbBs3zM-cZzuaPVWBjf4Q7i82hvxtXg2oCzQ@mail.gmail.com>
References: <20250224114815.146053-1-clamor95@gmail.com>
	<20250224114815.146053-3-clamor95@gmail.com>
	<20250228085927.GM824852@google.com>
	<CAPVz0n0jaR=UM7WbBs3zM-cZzuaPVWBjf4Q7i82hvxtXg2oCzQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Feb 2025 11:30:51 +0200
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> =D0=BF=D1=82, 28 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 10:59 Le=
e Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Mon, 24 Feb 2025, Svyatoslav Ryhel wrote:
> > =20
> > > Remove platform data and fully relay on OF and device tree
> > > parsing and binding devices.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  drivers/iio/light/lm3533-als.c      |  40 ++++---
> > >  drivers/leds/leds-lm3533.c          |  46 +++++---
> > >  drivers/mfd/lm3533-core.c           | 159 ++++++++------------------=
--
> > >  drivers/video/backlight/lm3533_bl.c |  71 ++++++++++---
> > >  include/linux/mfd/lm3533.h          |  35 +-----
> > >  5 files changed, 164 insertions(+), 187 deletions(-)
> > >
> > > diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm353=
3-als.c
> > > index 99f0b903018c..cb52965e93c6 100644
> > > --- a/drivers/iio/light/lm3533-als.c
> > > +++ b/drivers/iio/light/lm3533-als.c
> > > @@ -16,9 +16,12 @@
> > >  #include <linux/module.h>
> > >  #include <linux/mutex.h>
> > >  #include <linux/mfd/core.h>
> > > +#include <linux/mod_devicetable.h>
> > >  #include <linux/platform_device.h>
> > > +#include <linux/property.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/uaccess.h>
> > > +#include <linux/units.h>
> > >
> > >  #include <linux/mfd/lm3533.h>
> > >
> > > @@ -56,6 +59,9 @@ struct lm3533_als {
> > >
> > >       atomic_t zone;
> > >       struct mutex thresh_mutex;
> > > +
> > > +     unsigned pwm_mode:1;            /* PWM input mode (default anal=
og) */
> > > +     u8 r_select;                    /* 1 - 127 (ignored in PWM-mode=
) */
> > >  };
> > >
> > >
> > > @@ -753,18 +759,17 @@ static int lm3533_als_set_resistor(struct lm353=
3_als *als, u8 val)
> > >       return 0;
> > >  }
> > >
> > > -static int lm3533_als_setup(struct lm3533_als *als,
> > > -                         const struct lm3533_als_platform_data *pdat=
a)
> > > +static int lm3533_als_setup(struct lm3533_als *als)
> > >  {
> > >       int ret;
> > >
> > > -     ret =3D lm3533_als_set_input_mode(als, pdata->pwm_mode);
> > > +     ret =3D lm3533_als_set_input_mode(als, als->pwm_mode);
> > >       if (ret)
> > >               return ret;
> > >
> > >       /* ALS input is always high impedance in PWM-mode. */
> > > -     if (!pdata->pwm_mode) {
> > > -             ret =3D lm3533_als_set_resistor(als, pdata->r_select);
> > > +     if (!als->pwm_mode) {
> > > +             ret =3D lm3533_als_set_resistor(als, als->r_select); =20
> >
> > You're already passing 'als'.
> >
> > Just teach lm3533_als_set_resistor that 'r_select' is now contained.
> > =20
>=20
> This is not scope of this patchset. I was already accused in too much
> changes which make it unreadable. This patchset is dedicated to
> swapping platform data to use of the device tree. NOT improving
> functions, NOT rewriting arbitrary mechanics. If you feed a need for
> this change, then propose a followup. I need from this driver only one
> thing, that it could work with device tree. But it seems that it is
> better that it just rots in the garbage bin until removed cause no one
> cared.

This is not an unreasonable request as you added r_select to als.
Perhaps it belongs in a separate follow up patch.  However
it is worth remembering the motivation here is that you want get
this code upstream, the maintainers don't have that motivation.

Greg KH has given various talks on the different motivations in the
past. It maybe worth a watch.


>=20
> > >               if (ret)
> > >                       return ret;
> > >       }
> > > @@ -828,22 +833,16 @@ static const struct iio_info lm3533_als_info =
=3D {
> > >
> > >  static int lm3533_als_probe(struct platform_device *pdev)
> > >  {
> > > -     const struct lm3533_als_platform_data *pdata;
> > >       struct lm3533 *lm3533;
> > >       struct lm3533_als *als;
> > >       struct iio_dev *indio_dev;
> > > +     u32 val; =20
> >
> > Value of what, potatoes?
> > =20
>=20
> Oranges.

A well named variable would avoid need for any discussion of
what it is the value of.

>=20
> > >       int ret;
> > >
> > >       lm3533 =3D dev_get_drvdata(pdev->dev.parent);
> > >       if (!lm3533)
> > >               return -EINVAL;
> > >
> > > -     pdata =3D dev_get_platdata(&pdev->dev);
> > > -     if (!pdata) {
> > > -             dev_err(&pdev->dev, "no platform data\n");
> > > -             return -EINVAL;
> > > -     }
> > > -
> > >       indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*als));
> > >       if (!indio_dev)
> > >               return -ENOMEM;
> > > @@ -864,13 +863,21 @@ static int lm3533_als_probe(struct platform_dev=
ice *pdev)
> > >
> > >       platform_set_drvdata(pdev, indio_dev);
> > >
> > > +     val =3D 200 * KILO; /* 200kOhm */ =20
> >
> > Better to #define magic numbers; DEFAULT_{DESCRIPTION}_OHMS
> > =20
>=20
> Why? that is not needed.
If this variable had a more useful name there would be no need for
the comment either.

	val_resitor_ohms =3D 200 * KILLO;

or similar.

>=20
> > > +     device_property_read_u32(&pdev->dev, "ti,resistor-value-ohm", &=
val);
> > > +
> > > +     /* Convert resitance into R_ALS value with 2v / 10uA * R */ =20
> >
> > Because ...
> > =20
>=20
> BACAUSE the device DOES NOT understand human readable values, only 0s
> and 1s, hence mOhms must be converted into value lm3533 chip can
> understand.
A comment that gave the motivation would be much more useful than
repeating the maths.

/* Convert resistance to equivalent register value */

>=20
> > > +     als->r_select =3D DIV_ROUND_UP(2 * MICRO, 10 * val);
> > > +
> > > +     als->pwm_mode =3D device_property_read_bool(&pdev->dev, "ti,pwm=
-mode");
> > > +
> > >       if (als->irq) {
> > >               ret =3D lm3533_als_setup_irq(als, indio_dev);
> > >               if (ret)
> > >                       return ret;
> > >       }
> > >
> > > -     ret =3D lm3533_als_setup(als, pdata);
> > > +     ret =3D lm3533_als_setup(als);
> > >       if (ret)
> > >               goto err_free_irq;
> > >
> > > @@ -907,9 +914,16 @@ static void lm3533_als_remove(struct platform_de=
vice *pdev)
> > >               free_irq(als->irq, indio_dev);
> > >  }
> > >
> > > +static const struct of_device_id lm3533_als_match_table[] =3D {
> > > +     { .compatible =3D "ti,lm3533-als" },
> > > +     { }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, lm3533_als_match_table);
> > > +
> > >  static struct platform_driver lm3533_als_driver =3D {
> > >       .driver =3D {
> > >               .name   =3D "lm3533-als",
> > > +             .of_match_table =3D lm3533_als_match_table,
> > >       },
> > >       .probe          =3D lm3533_als_probe,
> > >       .remove         =3D lm3533_als_remove,

Anyhow, I'm short on time so only looking at the IIO related part.

Jonathan

