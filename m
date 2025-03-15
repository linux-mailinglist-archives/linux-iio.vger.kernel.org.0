Return-Path: <linux-iio+bounces-16867-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FB6A630E7
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 18:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC9C316F054
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 17:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AC32045B8;
	Sat, 15 Mar 2025 17:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpI50qqU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF70D63CB;
	Sat, 15 Mar 2025 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742060550; cv=none; b=lZYT/zhIuNza1I+Dnwvv/NmnxYP/5CLKBXfOi8NK3WXuPO+w9/Cz3Hm60oWbfRHmtlZdXuhPpisUD4gMl4p7yFbuUQYOe9cOJ3Cg/ZbsUhyjCwN5qe83eCY+A8xG+P6dqFhtegPH8+2wbCMorhLxRaCDTriEIW0NCzyYfOfoDRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742060550; c=relaxed/simple;
	bh=szgdwMsGtDIKf3CL1gaMQaofrSxxILEvd+smnp1DGys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LvTYc+ExMTdVSbkxHcQZ8gMLdLV99/RNg1J/5V29Gom1z16MRlv3RHxAT6nuuUblhKs8lF83YnfaT/Cv/L1yrNM1Aze+g297E2kaxUTLLavbRUGa3RClpb4sGCOf7FINiWg9O6yrf3A8In/G69+nW2Z1yDor3q9VLkWtm4zt8P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpI50qqU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71839C4CEE5;
	Sat, 15 Mar 2025 17:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742060550;
	bh=szgdwMsGtDIKf3CL1gaMQaofrSxxILEvd+smnp1DGys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WpI50qqUZCYukDYHIfiih1AFvNMO6LmGwCv+X7zc2vjo499RQ2CC2AC5Ln1iuIySn
	 WaoPUz/qftcE4H99D0sSuXr5pk7nR0afxkiR9RZRY1+GKAATY+yNGX7EtTIM89LpBO
	 rnh296Umd8mk3ITVT6qB65Sj5ZWiuL2z0QzZ0sYuQST8ryzZYHuTGG3bg6UEsjEDbl
	 sU5yjAcm0QgYufoCtYlTUCAtucrrupwfQHuf9xjv6/L0YdpHXgXuRaKk2SnifWOw1O
	 mEDdmvguCiaQKd62W5nexSUKAZE3kH9J4wLs3APHneAvpFFyiBUcESpK9gX1IT89pf
	 ELuLsehZzAGXQ==
Date: Sat, 15 Mar 2025 17:42:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v3 06/15] iio: accel: adxl345: add single tap feature
Message-ID: <20250315174224.0be43524@jic23-huawei>
In-Reply-To: <CAFXKEHbV-PP8jLiW2+7Jc00Q_DWjoj==a7MOO=nE6_t-2wbCCQ@mail.gmail.com>
References: <20250220104234.40958-1-l.rubusch@gmail.com>
	<20250220104234.40958-7-l.rubusch@gmail.com>
	<20250302121436.32f96b35@jic23-huawei>
	<CAFXKEHbV-PP8jLiW2+7Jc00Q_DWjoj==a7MOO=nE6_t-2wbCCQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Mar 2025 17:29:08 +0100
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Hi Jonathan,
>=20
> I prepared, reorganized and tested a v4 patch set. Given that I see
> how busy you must be these days with current increased mail traffic
> just in IIO ML when I compare it to some years ago,
> I don't want to bother you too much.

Thanks!  It's a travel heavy month which always messes with finding
time for reviews.  Too much bored time on planes with not enough space
to open a laptop properly!

> Some particular doubts I will inline down below. If possible with your
> work flow and to avoid giving you extra work, I'd like to ask you to
> read the questions here, but to give your answers right to the
> v4 patch set (so, i.e. after having seen the current state of source).
> It also should make my points
> a bit clearer. Anyway, this is just my idea, since I'm always happy
> about any feedback!

I might reply there as well, but it's easy to put a few comments here.

>=20
> On Sun, Mar 2, 2025 at 1:14=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >
> > On Thu, 20 Feb 2025 10:42:25 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Add the single tap feature with a threshold in 62.5mg/LSB points and a
> > > scaled duration in us. Keep singletap threshold in regmap cache but
> > > the scaled value of duration in us as member variable.
> > >
> > > Both use IIO channels for individual enable of the x/y/z axis. Initia=
lizes
> > > threshold and duration with reasonable content. When an interrupt is
> > > caught it will be pushed to the according IIO channel.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > ---
> > >  drivers/iio/accel/adxl345_core.c | 364 +++++++++++++++++++++++++++++=
+-
> > >  1 file changed, 362 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adx=
l345_core.c
> > > index 0cee81bc1877..d05593c0d513 100644
> > > --- a/drivers/iio/accel/adxl345_core.c
> > > +++ b/drivers/iio/accel/adxl345_core.c
> > > @@ -8,6 +8,7 @@
> > >   */
> > >
> > >  #include <linux/bitfield.h>
> > > +#include <linux/bitops.h>
> > >  #include <linux/interrupt.h>
> > >  #include <linux/module.h>
> > >  #include <linux/property.h>
> > > @@ -17,6 +18,7 @@
> > >  #include <linux/iio/iio.h>
> > >  #include <linux/iio/sysfs.h>
> > >  #include <linux/iio/buffer.h>
> > > +#include <linux/iio/events.h>
> > >  #include <linux/iio/kfifo_buf.h>
> > >
> > >  #include "adxl345.h"
> > > @@ -31,6 +33,33 @@
> > >  #define ADXL345_INT1                 0
> > >  #define ADXL345_INT2                 1
> > >
> > > +#define ADXL345_REG_TAP_AXIS_MSK     GENMASK(2, 0) =20
> > This is a bit confusing.  Here we have a mask for axis that
> > has 3 bits. =20
> > > +
> > > +enum adxl345_axis {
> > > +     ADXL345_Z_EN =3D BIT(0),
> > > +     ADXL345_Y_EN =3D BIT(1),
> > > +     ADXL345_X_EN =3D BIT(2),
> > > +     /* Suppress double tap detection if value > tap threshold */
> > > +     ADXL345_TAP_SUPPRESS =3D BIT(3), =20
> > and here an enum that is closely related with 4. =20
>=20
> I see your point. There are several registers used in the sensor for
> directions. A status register for tap and activity directions, and a
> activity/inactivity direction register. For Tap, direction enables are
> stored using the suppress bit in the fourth position. All those
> locations use actually four bit. Partly the upper four, partly the
> lower four. That's why I use here four bit for reading and writing.
> The locations 0, 1, 2 then can be used directly. Location 3 only
> applies to tap detection.
>=20
> I'll keep this in v4 patches, and hope to understand you correctly
> that this is not a "real" issue?
I'd split the AXIS_MSK into two parts.  One with just the axes
(make it the | of the 3 separate bits) and another one with suppress bit.
I'm not sure an enum really helps. Maybe better to just have defines.


> > > +
> > > +static int adxl345_read_event_value(struct iio_dev *indio_dev,
> > > +                                 const struct iio_chan_spec *chan,
> > > +                                 enum iio_event_type type,
> > > +                                 enum iio_event_direction dir,
> > > +                                 enum iio_event_info info,
> > > +                                 int *val, int *val2)
> > > +{
> > > +     struct adxl345_state *st =3D iio_priv(indio_dev);
> > > +     unsigned int tap_threshold;
> > > +     int ret;
> > > +
> > > +     switch (type) {
> > > +     case IIO_EV_TYPE_GESTURE:
> > > +             switch (info) {
> > > +             case IIO_EV_INFO_VALUE:
> > > +                     /*
> > > +                      * The scale factor is 62.5mg/LSB (i.e. 0xFF =
=3D 16g) but
> > > +                      * not applied here. =20
> >
> > Maybe say why.
> > =20
>=20
> Usually I did scaling for the time values. Time values is something I
> can understand someone
> rather wants to configure in corresponding time units, such as [ms],
> [us] or [s] rather than bit
> values. For [mg] values, franckly speaking, I imagine this is a bit overk=
ill.
>=20
> The threshold quite often is rather expect to be higher or lower,
> depending a bit on variation of
> the measurements. In the context of this rather "cheap" sensor, I
> guess I'm not putting up a
> seismic instrument, but rather generic tap detection, freefall or
> general activity in a general
> purpose context such as gaming, or the like. Let me know if this
> assumption here is too lazy.

Generally event values would be matched to scale of _RAW but for a
gesture, it is indeed a rather vague thing.  I'll take a look at=20
the new code and think about this a bit.

Jonathan


