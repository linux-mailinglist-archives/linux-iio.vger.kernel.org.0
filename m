Return-Path: <linux-iio+bounces-18400-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD096A94F50
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 12:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3F16167717
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 10:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F5420CCE4;
	Mon, 21 Apr 2025 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWJP9rWH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844F714658C;
	Mon, 21 Apr 2025 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745230608; cv=none; b=WKgV5x3KjjXXqx5xzHsGCz+qeLHuS/rDin9BgWXwJQhdxFlB9bvM1/8x82fSNn3hhzLLobT+zpEfkZgsszUeIrtqL1Sv5cRTZBDFr7vqU4VRu6FFlp6ZVrNFjbuzARgFI1ezfxRC6mOO+nZHJacoWNFiWVD7lkQl2S5XNqQaJ/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745230608; c=relaxed/simple;
	bh=xhjnF2yWUOPLWpYB/sG9bvUoeOYj4o6fed/kiEyZNCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B6iaHo1FJhud+V4xRzTVeY22SbkvbYL8mRwRtpjxl+FMi0H5ZClhSxCEPBIChpw/uv7aO7CNVMDXGrtbNE8wDdEf1I0iLpUH8QUmhGLdY3EZ5KPF54XQnxyB3nrfAzqsi4YL9iHLovOSaM30lVWpTCvTLEkBpgoevIYlc0UaYp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWJP9rWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1433DC4CEE4;
	Mon, 21 Apr 2025 10:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745230608;
	bh=xhjnF2yWUOPLWpYB/sG9bvUoeOYj4o6fed/kiEyZNCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MWJP9rWH1s6igmdGH02bzkUY6qLI1SYiQW41EG8E4JgvCJx4AMv03UBoyDkhHTmKJ
	 QOkrCN5Lu7wrIpc3WdOGktC/mTwoSUytQhL7rR/4CVtHgwGieCLNbziU/pL49gGvDl
	 al0NJ+fVY5qwUEZbHM2YYJhP6Sl0kzREJ+Tur+PMTt9KtsYkF9Iz0n7jd9VdPO2d4H
	 K3kbeXUiTa8Je7fQXZTqjjvjnuauWzFW87FmcEFA3qc19pkjrlto65TdFeZrzkdnWp
	 vWYK9PYnrpoKko8dG4Y/AEWl75IHaveek5Al8GPNRggQyk1U1tguf6SW88UoMtQ00d
	 KOyvb46aaxieA==
Date: Mon, 21 Apr 2025 11:16:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v6 05/11] iio: accel: adxl345: add freefall feature
Message-ID: <20250421111641.1cb83848@jic23-huawei>
In-Reply-To: <CAFXKEHZNmUsUmheyDdh1bDDf97-7ZTpsm2xqqbwT+hq3K58F5A@mail.gmail.com>
References: <20250414184245.100280-1-l.rubusch@gmail.com>
	<20250414184245.100280-6-l.rubusch@gmail.com>
	<20250418192254.0becd27d@jic23-huawei>
	<CAFXKEHZNmUsUmheyDdh1bDDf97-7ZTpsm2xqqbwT+hq3K58F5A@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 20 Apr 2025 23:26:47 +0200
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Happy Easter!
>=20
> On Fri, Apr 18, 2025 at 8:23=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Mon, 14 Apr 2025 18:42:39 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Add the freefall detection of the sensor together with a threshold and
> > > time parameter. A freefall event is detected if the measuring signal
> > > falls below the threshold.
> > >
> > > Introduce a freefall threshold stored in regmap cache, and a freefall
> > > time, having the scaled time value stored as a member variable in the
> > > state instance.
> > > =20
> > Reading this I wondered whether we had the event code consistent for
> > freefall detectors... Or indeed inactivity ones (which are kind of simi=
larish)
> >
> > :( We don't it seems.  The issue is that
> > freefall is actually that all channels are simultaneously under the the=
 magnitude
> > threshold, not one of them.  So it should I think be
> > X_AND_Y_AND_Z not X_OR_Y_OR_Z
> > =20
>=20
> I change to X_AND_Y_AND_Z.
>=20
> > This is as opposed to activity detectors which tend to be any axis shows
> > activity and X_OR_Y_OR_Z applies.
> >
> > Anyhow upshot is I think I lead you astray on this and we should make t=
his
> > one IIO_MOD_X_AND_Y_AND_Z
> >
> > A few other things inline.
> >
> > Unfortunately we don't deal with these events that often so I forget
> > what we did before :(
> > =20
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > ---
> > >  drivers/iio/accel/adxl345_core.c | 125 +++++++++++++++++++++++++++++=
++
> > >  1 file changed, 125 insertions(+)
> > >
> > > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adx=
l345_core.c
> > > index c464c87033fb..ae02826e552b 100644
> > > --- a/drivers/iio/accel/adxl345_core.c
> > > +++ b/drivers/iio/accel/adxl345_core.c
> > > @@ -75,6 +75,7 @@ struct adxl345_state {
> > >       u32 tap_duration_us;
> > >       u32 tap_latent_us;
> > >       u32 tap_window_us;
> > > +     u32 ff_time_ms;
> > >
> > >       __le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned=
(IIO_DMA_MINALIGN);
> > >  };
> > > @@ -96,6 +97,14 @@ static struct iio_event_spec adxl345_events[] =3D {
> > >                       BIT(IIO_EV_INFO_RESET_TIMEOUT) |
> > >                       BIT(IIO_EV_INFO_TAP2_MIN_DELAY),
> > >       },
> > > +     {
> > > +             /* free fall */
> > > +             .type =3D IIO_EV_TYPE_MAG,
> > > +             .dir =3D IIO_EV_DIR_FALLING,
> > > +             .mask_shared_by_type =3D BIT(IIO_EV_INFO_ENABLE) |
> > > +                     BIT(IIO_EV_INFO_VALUE) |
> > > +                     BIT(IIO_EV_INFO_PERIOD),
> > > +     }, =20
> > This is creating separate per axis enables, values and period. Does tha=
t make
> > sense?  If not you need to spin a kind of virtual channel (with mod X_A=
ND_Y_AND_Z)
> > and add the events to it.
> >
> > See how the sca3000 does it for example. =20
>=20
> Hum, I'm not sure if I understand you correctly. In my driver, I'm
> using .mask_shared_by_type, and I verified there appears only one
> enable, one value and one period handle.
> # ls -l /sys/bus/iio/devices/iio:device0/events/
> total 0
> ...
> -rw-r--r-- 1 root root 4096 Apr 20 21:59 in_accel_mag_falling_en
> -rw-r--r-- 1 root root 4096 Apr 20 21:59 in_accel_mag_falling_period
> -rw-r--r-- 1 root root 4096 Apr 20 21:59 in_accel_mag_falling_value
> ...
>=20
> In the sources of sca3000.c I saw this setup with .mask_separate. So,
> there I'd expect to see separate enables per axis, or am I wrong? In
> the case of the ADXL345, there should only be one freefall enable (in
> my driver) and not per axis. So, isn't this what is currently there?
>=20
> So far I only adjust the or'ing to and'ing the axis for freefall.

So this is a messy corner of the ABI (because these are tricky to describe).
Shared by type usually means there is one attribute applying to all the
axis, but that they are reported separately, or potentially multiple events
/ _OR_ form used if we can distinguish exactly what the event is.

In this case there is no way for userspace to anticipate that the event
that might be generate is X_AND_Y_AND_Z.  So for this
the ABI solution we came up with is that virtual channel and separate.

So you get something along the lines of
in_accel_x&y&z_mag_falling_en
in_accel_x&y&z_mag_falling_period
etc

The tricky remaining corner is this only makes sense if we always enable
all axis (which is typical for a freefall detector). If we get a device
that oddly has per axis free fall enables, then it would be hard and I
might argue nonsense to enable them separately anyway.  Not true
here though I think.

Note that we may well have drivers using the ABI slightly differently for
freefall events which will be at least partly because I'd forgotten how
we resolved all this complexity long ago (that sca3000 driver is ancient!)
ABI like this is tricky to fix up, but we might want to consider some dupli=
cation
in those drivers so we standardize on one form for freefall (even if we hav=
e some
stray ABI from other possible solutions).

What we should definitely do is pull together some documentation on multi c=
hannel
event handling as the ABI docs are probably not enough.

Jonathan


