Return-Path: <linux-iio+bounces-18450-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD863A95201
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 15:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9F161894D01
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434E4263F5D;
	Mon, 21 Apr 2025 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHBJZJxF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A1E265CCF;
	Mon, 21 Apr 2025 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243519; cv=none; b=q3qU0nB1rRO80XNyQcVHzNBtcIz4R6yMZvIeQT9NnqKgaLIhfvLdeZI6fWLCT03yJmLe/NrwPk7uOFqmfWis11QX2AMJoVDhs9+aN0hCkzMkCNsBIbiZTgs+ja5V/Mxyc9OTiIC94odveEbhhGSCr8iJ/Ph0/P/FGmFKaN4aHFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243519; c=relaxed/simple;
	bh=XHD5eA9xaklG7sjRpB1N5p1j7MCk5KvdlNPAy+eg8e4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jhyeKgt1T8CA03riGQVdp2SN+HnDqTnvj2vFGmRvG99aq+IE0rv7VT6z0Zy4vKjpwi60FgyimAA8V7CQdrOf5ZRlaRD1XEDmtTri0Pe+JfQzW4bNhwKV1nb6kluZjfdfcUoTYqV8nqb+u/bl4PAajDznl9euQYcLRdxr8eqKEOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHBJZJxF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C600C4CEE4;
	Mon, 21 Apr 2025 13:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745243518;
	bh=XHD5eA9xaklG7sjRpB1N5p1j7MCk5KvdlNPAy+eg8e4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bHBJZJxFvfm5oAVFOwNv+gPLmP4UIY07SREhtXVSMIGbO+TqDhq4VNhPCv0K3Fyh3
	 K7CcALNoQSznT5bQUHPLFx+i82o0NM5OylheNLpG7uGm1Ah9iY320aqnp420HO4m75
	 cNu/iSNQPN+tY4q6t3UvR3sO+qpJVfCZo7SbBv+ILigc/exZ1SVFcr6zYfGiu3+5cz
	 PrsG5KaA3E/m8PfN61vPwZUYnHfY0Xr+ckAuapzbBoQ41yr/+P68XszR+2bUc1Od2b
	 Yd3+ZowIwLls/AYAfkOzQrW1iZoeljpPN9nC+pIT4pEv+eeF2Sd38LP4npXpaC/m42
	 jaR2o1GWNjiLA==
Date: Mon, 21 Apr 2025 14:51:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v6 05/11] iio: accel: adxl345: add freefall feature
Message-ID: <20250421145152.22f42bc6@jic23-huawei>
In-Reply-To: <CAFXKEHaG2EBkoc5Zx=oCEePA3nwApRWAg1pGsQ-_68OY2esYVQ@mail.gmail.com>
References: <20250414184245.100280-1-l.rubusch@gmail.com>
	<20250414184245.100280-6-l.rubusch@gmail.com>
	<20250418192254.0becd27d@jic23-huawei>
	<CAFXKEHZNmUsUmheyDdh1bDDf97-7ZTpsm2xqqbwT+hq3K58F5A@mail.gmail.com>
	<20250421111641.1cb83848@jic23-huawei>
	<CAFXKEHaG2EBkoc5Zx=oCEePA3nwApRWAg1pGsQ-_68OY2esYVQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 21 Apr 2025 15:31:19 +0200
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> On Mon, Apr 21, 2025 at 12:16=E2=80=AFPM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> >
> > On Sun, 20 Apr 2025 23:26:47 +0200
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Happy Easter!
> > >
> > > On Fri, Apr 18, 2025 at 8:23=E2=80=AFPM Jonathan Cameron <jic23@kerne=
l.org> wrote: =20
> > > >
> > > > On Mon, 14 Apr 2025 18:42:39 +0000
> > > > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > > > =20
> > > > > Add the freefall detection of the sensor together with a threshol=
d and
> > > > > time parameter. A freefall event is detected if the measuring sig=
nal
> > > > > falls below the threshold.
> > > > >
> > > > > Introduce a freefall threshold stored in regmap cache, and a free=
fall
> > > > > time, having the scaled time value stored as a member variable in=
 the
> > > > > state instance.
> > > > > =20
> > > > Reading this I wondered whether we had the event code consistent for
> > > > freefall detectors... Or indeed inactivity ones (which are kind of =
similarish)
> > > >
> > > > :( We don't it seems.  The issue is that
> > > > freefall is actually that all channels are simultaneously under the=
 the magnitude
> > > > threshold, not one of them.  So it should I think be
> > > > X_AND_Y_AND_Z not X_OR_Y_OR_Z
> > > > =20
> > >
> > > I change to X_AND_Y_AND_Z.
> > > =20
> > > > This is as opposed to activity detectors which tend to be any axis =
shows
> > > > activity and X_OR_Y_OR_Z applies.
> > > >
> > > > Anyhow upshot is I think I lead you astray on this and we should ma=
ke this
> > > > one IIO_MOD_X_AND_Y_AND_Z
> > > >
> > > > A few other things inline.
> > > >
> > > > Unfortunately we don't deal with these events that often so I forget
> > > > what we did before :(
> > > > =20
> > > > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > > > ---
> > > > >  drivers/iio/accel/adxl345_core.c | 125 +++++++++++++++++++++++++=
++++++
> > > > >  1 file changed, 125 insertions(+)
> > > > >
> > > > > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel=
/adxl345_core.c
> > > > > index c464c87033fb..ae02826e552b 100644
> > > > > --- a/drivers/iio/accel/adxl345_core.c
> > > > > +++ b/drivers/iio/accel/adxl345_core.c
> > > > > @@ -75,6 +75,7 @@ struct adxl345_state {
> > > > >       u32 tap_duration_us;
> > > > >       u32 tap_latent_us;
> > > > >       u32 tap_window_us;
> > > > > +     u32 ff_time_ms;
> > > > >
> > > > >       __le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __ali=
gned(IIO_DMA_MINALIGN);
> > > > >  };
> > > > > @@ -96,6 +97,14 @@ static struct iio_event_spec adxl345_events[] =
=3D {
> > > > >                       BIT(IIO_EV_INFO_RESET_TIMEOUT) |
> > > > >                       BIT(IIO_EV_INFO_TAP2_MIN_DELAY),
> > > > >       },
> > > > > +     {
> > > > > +             /* free fall */
> > > > > +             .type =3D IIO_EV_TYPE_MAG,
> > > > > +             .dir =3D IIO_EV_DIR_FALLING,
> > > > > +             .mask_shared_by_type =3D BIT(IIO_EV_INFO_ENABLE) |
> > > > > +                     BIT(IIO_EV_INFO_VALUE) |
> > > > > +                     BIT(IIO_EV_INFO_PERIOD),
> > > > > +     }, =20
> > > > This is creating separate per axis enables, values and period. Does=
 that make
> > > > sense?  If not you need to spin a kind of virtual channel (with mod=
 X_AND_Y_AND_Z)
> > > > and add the events to it.
> > > >
> > > > See how the sca3000 does it for example. =20
> > >
> > > Hum, I'm not sure if I understand you correctly. In my driver, I'm
> > > using .mask_shared_by_type, and I verified there appears only one
> > > enable, one value and one period handle.
> > > # ls -l /sys/bus/iio/devices/iio:device0/events/
> > > total 0
> > > ...
> > > -rw-r--r-- 1 root root 4096 Apr 20 21:59 in_accel_mag_falling_en
> > > -rw-r--r-- 1 root root 4096 Apr 20 21:59 in_accel_mag_falling_period
> > > -rw-r--r-- 1 root root 4096 Apr 20 21:59 in_accel_mag_falling_value
> > > ...
> > >
> > > In the sources of sca3000.c I saw this setup with .mask_separate. So,
> > > there I'd expect to see separate enables per axis, or am I wrong? In
> > > the case of the ADXL345, there should only be one freefall enable (in
> > > my driver) and not per axis. So, isn't this what is currently there?
> > >
> > > So far I only adjust the or'ing to and'ing the axis for freefall. =20
> >
> > So this is a messy corner of the ABI (because these are tricky to descr=
ibe).
> > Shared by type usually means there is one attribute applying to all the
> > axis, but that they are reported separately, or potentially multiple ev=
ents
> > / _OR_ form used if we can distinguish exactly what the event is.
> >
> > In this case there is no way for userspace to anticipate that the event
> > that might be generate is X_AND_Y_AND_Z.  So for this
> > the ABI solution we came up with is that virtual channel and separate.
> >
> > So you get something along the lines of
> > in_accel_x&y&z_mag_falling_en
> > in_accel_x&y&z_mag_falling_period
> > etc
> >
> > The tricky remaining corner is this only makes sense if we always enable
> > all axis (which is typical for a freefall detector). If we get a device
> > that oddly has per axis free fall enables, then it would be hard and I
> > might argue nonsense to enable them separately anyway.  Not true
> > here though I think.
> >
> > Note that we may well have drivers using the ABI slightly differently f=
or
> > freefall events which will be at least partly because I'd forgotten how
> > we resolved all this complexity long ago (that sca3000 driver is ancien=
t!)
> > ABI like this is tricky to fix up, but we might want to consider some d=
uplication
> > in those drivers so we standardize on one form for freefall (even if we=
 have some
> > stray ABI from other possible solutions).
> >
> > What we should definitely do is pull together some documentation on mul=
ti channel
> > event handling as the ABI docs are probably not enough.
> > =20
>=20
> As I (begin to) understand now, in case of the sca3000, the virtual
> channel is literally an extra channel. That means, we're talking
> probably about this here down below, right?
> ...
yes. That is what I was referring to.

>  512 static const struct iio_chan_spec sca3000_channels[] =3D {
>  513         SCA3000_CHAN(0, IIO_MOD_X),
>  514         SCA3000_CHAN(1, IIO_MOD_Y),
>  515         SCA3000_CHAN(2, IIO_MOD_Z),
>  516         {
>  517                 .type =3D IIO_ACCEL,
>  518                 .modified =3D 1,
>  519                 .channel2 =3D IIO_MOD_X_AND_Y_AND_Z,
>  520                 .scan_index =3D -1, /* Fake channel */
>  521                 .event_spec =3D &sca3000_freefall_event_spec,
>  522                 .num_event_specs =3D 1,
>  523         },
>  524 };
> ...
> <taken from sca3000.c>
>=20
> What's now missing for freefall and the ADXL345 and v7 in particular?
> - I need to provide a similar channel setup as in  the sca3000 snippet
> above, the virtual channel
> - I need to AND the axis for this channel
> - Now, with the virtual channel usage will be "separate" instead of
> "shared", which will result in a single enable handle in sysfs
>=20
> Is this correct?

Yes.  I think that's all correct.

>=20
> Sry, I needed to re-read your answer several times. What confuses me
> is still a bit the "virtual extra-channel".=20

I made up that term for it as there is no actual traditional channel
there.  I should have given a pointer to the actual iio_chan_spec entry.
Sorry about that!

>Probably, I need to build
> up a bit more practical experience with the channels. Providing just a
> single enable handle already looks good to me. I still don't grok
> entirely where this can be / is problematic in such case, but no need
> to explain it now in full detail. If the TODOs match at least with my
> understanding I will try to implement the above points.

These events are just a bit weird when aligned with the simpler ones
we tend to get on ADCs etc.  Giving userspace the best visibility we
can is always good.  Here it is possible to get that, but in some other
cases we haven't yet come up with a good generic ABI :(

Jonathan


>=20
> > Jonathan
> > =20


