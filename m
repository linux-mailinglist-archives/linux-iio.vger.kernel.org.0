Return-Path: <linux-iio+bounces-13500-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2EF9F244B
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 15:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ECDC164FE3
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2024 14:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A99518E373;
	Sun, 15 Dec 2024 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYmsKz/p"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA461805A;
	Sun, 15 Dec 2024 14:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734271835; cv=none; b=SrSEA3cijZy9Q3GAzMXzqRPFF0YQS3fpzipfJ5674vKM6hWNVHUZywFsnZPOD8HJ8hx6KuUVAFAFVnlNljUEiio5tXbKFzDXJKMYXEjYS3CZ2hrW1aDaAEetEgT4Xp0LjKVa0dmELDJn4aQ/s9z8EUcVqHhi6nrQhSvf6mckNOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734271835; c=relaxed/simple;
	bh=Ugt82RAiwmx4n7n5jRLgGBhD/IdHRmG1Grv/4HCIsK4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L3bge84uAvl0KxjMHtWnajff0CJ3166y9Iah+B64NGKlX1Qxi51TDtxWbzuOnrpn5EcEvZZqOMuDhsuZisfuq93q07uZpl328Lj8vcIlcvjMCsAEx1O/cmhHS0sTXnucWX6h5WNyMro+MVxshmMm6UwdT2Qh+vP1xP3wB4Ol8mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYmsKz/p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93956C4CECE;
	Sun, 15 Dec 2024 14:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734271835;
	bh=Ugt82RAiwmx4n7n5jRLgGBhD/IdHRmG1Grv/4HCIsK4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DYmsKz/p8aD42joolfp3Z4n/GCB+OzMwy1faMGhL0NJOXQC1xpnRqe0eYJ8x/em5I
	 YVrA1lY85UZmHaLeK+2QYysldr6GxN07yFh3f83ZePPkUd2axra0kYSbpdVxJgBdZl
	 BuD9shXH6z/iMrW56rVpwBYtIAu6eKDm04tE3J6kJv5WcELk2dVmHwDvisM+QCL6l8
	 w+wcFfAR1eNj57XMbqpElUuwGBdAl/jzERIjKxxtfxCqqIZpKav2+8Cpph1IGCuhrF
	 vWOgvOsJ1jKTeN5Jut8CXyWoet1YOlx1MH8JpOqPyPJG6GmGl/LEfQqWV/VXi+qIss
	 xkDjJTewuEfoA==
Date: Sun, 15 Dec 2024 14:10:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v7 1/7] iio: accel: adxl345: add function to switch
 measuring mode
Message-ID: <20241215141027.6ee70828@jic23-huawei>
In-Reply-To: <CAFXKEHamiip3fVp1HNX4DZSzNnc7bMOQNg1RKsY45NbFymzr7g@mail.gmail.com>
References: <20241213211909.40896-1-l.rubusch@gmail.com>
	<20241213211909.40896-2-l.rubusch@gmail.com>
	<20241214120227.56b885fa@jic23-huawei>
	<CAFXKEHamiip3fVp1HNX4DZSzNnc7bMOQNg1RKsY45NbFymzr7g@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 15 Dec 2024 10:41:12 +0100
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> On Sat, Dec 14, 2024 at 1:02=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Fri, 13 Dec 2024 21:19:03 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Replace the powerup / powerdown functions by a generic function to put
> > > the sensor in STANDBY, or MEASURE mode. When configuring the FIFO for
> > > several features of the accelerometer, it is recommended to put
> > > measuring in STANDBY mode.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com> =20
> > Mostly in the interests of trimming down the queue of patches in flight
> > and because this one has been fine for a few versions without significa=
nt
> > comment.
> >
> > Applied this patch to the togreg branch of iio.git and pushed out initi=
ally
> > as testing to let 0-day take a look.
> > =20
>=20
> Question here: you applied this patch now to the iio branch. Now,
> Christophe Jaillet pointed still something out that could be improved,
> the function could be shortened to, e.g.
>=20
> +static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
> +{
> +     unsigned int val =3D en ? ADXL345_POWER_CTL_MEASURE :
> ADXL345_POWER_CTL_STANDBY;
> +
> +     return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
> +}
>=20
> Should I present an improved patch? Or, in case this was urgent, would
> it require an additional patch/fix? What would be the way to deal with
> such fixes immediately after "applied"?
>=20
Send me a patch on top. I may well squash it into the original (particularly
if you stick a note on that being sensible under the --- for the patch!)

There is always a window in which I'm happy to rebase (or pull a patch
if we get feedback needing bigger changes) because I typically give
at least half a week for 0-day to poke the tree before I make a potential
mess in linux-next.  Ultimately I'll rebase after that for a sufficiently
serious issue but for something like this I'll just apply the patch on top
once it's out for linux-next to pick up.

Jonathan

> Best,
> L
>=20
> > Thanks
> >
> > Jonathan
> > =20
> > > ---
> > >  drivers/iio/accel/adxl345_core.c | 42 +++++++++++++++++++++++-------=
--
> > >  1 file changed, 30 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adx=
l345_core.c
> > > index 88df9547b..b48bc838c 100644
> > > --- a/drivers/iio/accel/adxl345_core.c
> > > +++ b/drivers/iio/accel/adxl345_core.c
> > > @@ -138,6 +138,34 @@ static int adxl345_write_raw_get_fmt(struct iio_=
dev *indio_dev,
> > >       }
> > >  }
> > >
> > > +/**
> > > + * adxl345_set_measure_en() - Enable and disable measuring.
> > > + *
> > > + * @st: The device data.
> > > + * @en: Enable measurements, else standby mode.
> > > + *
> > > + * For lowest power operation, standby mode can be used. In standby =
mode,
> > > + * current consumption is supposed to be reduced to 0.1uA (typical).=
 In this
> > > + * mode no measurements are made. Placing the device into standby mo=
de
> > > + * preserves the contents of FIFO.
> > > + *
> > > + * Return: Returns 0 if successful, or a negative error value.
> > > + */
> > > +static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
> > > +{
> > > +     unsigned int val =3D 0;
> > > +
> > > +     val =3D (en) ? ADXL345_POWER_CTL_MEASURE : ADXL345_POWER_CTL_ST=
ANDBY;
> > > +     return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
> > > +}
> > > +
> > > +static void adxl345_powerdown(void *ptr)
> > > +{
> > > +     struct adxl345_state *st =3D ptr;
> > > +
> > > +     adxl345_set_measure_en(st, false);
> > > +}
> > > +
> > >  static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
> > >  "0.09765625 0.1953125 0.390625 0.78125 1.5625 3.125 6.25 12.5 25 50 =
100 200 400 800 1600 3200"
> > >  );
> > > @@ -158,16 +186,6 @@ static const struct iio_info adxl345_info =3D {
> > >       .write_raw_get_fmt      =3D adxl345_write_raw_get_fmt,
> > >  };
> > >
> > > -static int adxl345_powerup(void *regmap)
> > > -{
> > > -     return regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWE=
R_CTL_MEASURE);
> > > -}
> > > -
> > > -static void adxl345_powerdown(void *regmap)
> > > -{
> > > -     regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_S=
TANDBY);
> > > -}
> > > -
> > >  /**
> > >   * adxl345_core_probe() - Probe and setup for the accelerometer.
> > >   * @dev:     Driver model representation of the device
> > > @@ -237,11 +255,11 @@ int adxl345_core_probe(struct device *dev, stru=
ct regmap *regmap,
> > >                                    regval, ADXL345_DEVID);
> > >
> > >       /* Enable measurement mode */
> > > -     ret =3D adxl345_powerup(st->regmap);
> > > +     ret =3D adxl345_set_measure_en(st, true);
> > >       if (ret < 0)
> > >               return dev_err_probe(dev, ret, "Failed to enable measur=
ement mode\n");
> > >
> > > -     ret =3D devm_add_action_or_reset(dev, adxl345_powerdown, st->re=
gmap);
> > > +     ret =3D devm_add_action_or_reset(dev, adxl345_powerdown, st);
> > >       if (ret < 0)
> > >               return ret;
> > > =20
> > =20


