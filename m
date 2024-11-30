Return-Path: <linux-iio+bounces-12904-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A259DF339
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 22:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7169416208E
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 20:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9CF1AAE37;
	Sat, 30 Nov 2024 20:59:56 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1631AA783
	for <linux-iio@vger.kernel.org>; Sat, 30 Nov 2024 20:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733000396; cv=none; b=ilY+BNfQUTEZx3fKjBMAboZaKNeYBXYcvDPMbLxLPct3JHz68ydOdRkJzzQU+GKXx8yku5PA6val/j57HoQyp8h7/A75769Pf92ayI4ZL0A/5LyWBoMGQkE9yzWOefmZ9+8yj7AJLbyXXyQ7cNQpeIhtpTh+Z0eNuT34e9G+LgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733000396; c=relaxed/simple;
	bh=0eC4wahbEpJua5w4+HZsPJFJkIuaWQ09tXvwMB92WKA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=simJcbnHO43m45/Po3jLNuN/mAd3BoxPaCEGKtoQkBGlV4qZkQRgYR49UiNU8vNl0u4zCzLnH6k4Pn2NjufyUvuiwacChJaK1sBhGwpXWfvTt60V/8ibDPYpEvQHcmb3eSCpXLXBVTRSQ9VhBI4Qif7O6DE6zQE9hLCefjOVVmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-108-JqFvTQhZOQClzMhxbYBVeA-1; Sat, 30 Nov 2024 20:59:44 +0000
X-MC-Unique: JqFvTQhZOQClzMhxbYBVeA-1
X-Mimecast-MFC-AGG-ID: JqFvTQhZOQClzMhxbYBVeA
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 30 Nov
 2024 20:59:22 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 30 Nov 2024 20:59:22 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jonathan Cameron' <jic23@kernel.org>
CC: 'Jakob Hauser' <jahau@rocketmail.com>, Lars-Peter Clausen
	<lars@metafoo.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Walleij
	<linus.walleij@linaro.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>
Subject: RE: [PATCH v2] iio: magnetometer: yas530: Use signed integer type for
 clamp limits
Thread-Topic: [PATCH v2] iio: magnetometer: yas530: Use signed integer type
 for clamp limits
Thread-Index: AQHbQqUs2JSj3AGLWkSCiQkgtAYVhLLPsp/wgAAyLwCAAGnPcA==
Date: Sat, 30 Nov 2024 20:59:22 +0000
Message-ID: <6f2c9946a9fe4b40ac7dd5a66003c8c4@AcuMS.aculab.com>
References: <11609b2243c295d65ab4d47e78c239d61ad6be75.1732914810.git.jahau@rocketmail.com>
	<11609b2243c295d65ab4d47e78c239d61ad6be75.1732914810.git.jahau@rocketmail.com>
	<9f5793f03c2440d2aa18630469df06df@AcuMS.aculab.com>
 <20241130143506.53973e40@jic23-huawei>
In-Reply-To: <20241130143506.53973e40@jic23-huawei>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cotkg1OsWUSvdKM8oAtmCdorLLr6m__Fv7dWPiSN8zs_1733000384
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Jonathan Cameron
> Sent: 30 November 2024 14:35
>=20
> On Sat, 30 Nov 2024 11:40:45 +0000
> David Laight <David.Laight@ACULAB.COM> wrote:
>=20
> > From: Jakob Hauser
> >
> > Copying Andrew M - he might want to take this through his mm tree.
>=20
> I'm confused. Why?
>=20
> Looks like a local bug in an IIO driver.  What am I missing?

The build test bot picked it up because a change to minmax.h that Andrew
committed to the mm tree showed up the bug.
To avoid W=3D1 builds failing Andrew had applied a temporary 'fix'.
So he needs to be in the loop at least.
I don't know the actual procedure :-)

=09David


>=20
> >
> > > Sent: 29 November 2024 21:25
> > >
> > > In the function yas537_measure() there is a clamp_val() with limits o=
f
> > > -BIT(13) and  BIT(13) - 1. The input clamp value h[] is of type s32. =
The BIT()
> > > is of type unsigned long integer due to its define in include/vdso/bi=
ts.h.
> > > The lower limit -BIT(13) is recognized as -8192 but expressed as an u=
nsigned
> > > long integer. The size of an unsigned long integer differs between 32=
-bit and
> > > 64-bit architectures. Converting this to type s32 may lead to undesir=
ed
> > > behavior.
> > >
> > > Additionally, in the calculation lines h[0], h[1] and h[2] the unsign=
ed long
> > > integer divisor BIT(13) causes an unsigned division, shifting the lef=
t-hand
> > > side of the equation back and forth, possibly ending up in large posi=
tive
> > > values instead of negative values on 32-bit architectures.
> > >
> > > To solve those two issues, declare a signed integer with a value of B=
IT(13).
> > >
> > > There is another omission in the clamp line: clamp_val() returns a va=
lue and
> > > it's going nowhere here. Self-assign it to h[i] to make use of the cl=
amp
> > > macro.
> > >
> > > Finally, replace clamp_val() macro by clamp() because after changing =
the limits
> > > from type unsigned long integer to signed integer it's fine that way.
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202411230458.dhZwh3TT-l=
kp@intel.com/
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202411282222.oF0B4110-l=
kp@intel.com/
> > > Fixes: 65f79b501030 ("iio: magnetometer: yas530: Add YAS537 variant")
> > > Cc: David Laight <david.laight@aculab.com>
> > > Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> >
> > Reviewed-by: David Laight <david.laight@aculab.com>
> >
> > I THINK all the other BIT() and GENMASK() are ok.
> > The code also rather heavily relies on u16 being promoted to 'signed in=
t'.
> >
> > =09David
> >
> >
> > > ---
> > > The patch is based on torvalds/linux v6.12.
> > >
> > > The calculation lines h[0], h[1] and h[2] exceed the limit of 80 char=
acters per
> > > line. In terms of readability I would prefer to keep it that way.
> > >
> > > Changes in v2:
> > >  - Self-assigned the clamp macro to h[i].
> > >  - Changed from clamp_val() macro to clamp().
> > >  - In commit message added issues on divisor BIT(13) and missing clam=
p
> > >    assignment.
> > >  - In tags added another (duplicate) report by the kernel test robot.
> > >
> > > Link to v1: https://lore.kernel.org/linux-iio/20241126234021.19749-1-=
jahau@rocketmail.com/T/#t
> > > ---
> > >  drivers/iio/magnetometer/yamaha-yas530.c | 13 +++++++------
> > >  1 file changed, 7 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/m=
agnetometer/yamaha-yas530.c
> > > index 65011a8598d3..c55a38650c0d 100644
> > > --- a/drivers/iio/magnetometer/yamaha-yas530.c
> > > +++ b/drivers/iio/magnetometer/yamaha-yas530.c
> > > @@ -372,6 +372,7 @@ static int yas537_measure(struct yas5xx *yas5xx, =
u16 *t, u16 *x, u16 *y1, u16
> *y
> > >  =09u8 data[8];
> > >  =09u16 xy1y2[3];
> > >  =09s32 h[3], s[3];
> > > +=09int half_range =3D BIT(13);
> > >  =09int i, ret;
> > >
> > >  =09mutex_lock(&yas5xx->lock);
> > > @@ -406,13 +407,13 @@ static int yas537_measure(struct yas5xx *yas5xx=
, u16 *t, u16 *x, u16 *y1,
> u16 *y
> > >  =09/* The second version of YAS537 needs to include calibration coef=
ficients */
> > >  =09if (yas5xx->version =3D=3D YAS537_VERSION_1) {
> > >  =09=09for (i =3D 0; i < 3; i++)
> > > -=09=09=09s[i] =3D xy1y2[i] - BIT(13);
> > > -=09=09h[0] =3D (c->k *   (128 * s[0] + c->a2 * s[1] + c->a3 * s[2]))=
 / BIT(13);
> > > -=09=09h[1] =3D (c->k * (c->a4 * s[0] + c->a5 * s[1] + c->a6 * s[2]))=
 / BIT(13);
> > > -=09=09h[2] =3D (c->k * (c->a7 * s[0] + c->a8 * s[1] + c->a9 * s[2]))=
 / BIT(13);
> > > +=09=09=09s[i] =3D xy1y2[i] - half_range;
> > > +=09=09h[0] =3D (c->k *   (128 * s[0] + c->a2 * s[1] + c->a3 * s[2]))=
 / half_range;
> > > +=09=09h[1] =3D (c->k * (c->a4 * s[0] + c->a5 * s[1] + c->a6 * s[2]))=
 / half_range;
> > > +=09=09h[2] =3D (c->k * (c->a7 * s[0] + c->a8 * s[1] + c->a9 * s[2]))=
 / half_range;
> > >  =09=09for (i =3D 0; i < 3; i++) {
> > > -=09=09=09clamp_val(h[i], -BIT(13), BIT(13) - 1);
> > > -=09=09=09xy1y2[i] =3D h[i] + BIT(13);
> > > +=09=09=09h[i] =3D clamp(h[i], -half_range, half_range - 1);
> > > +=09=09=09xy1y2[i] =3D h[i] + half_range;
> > >  =09=09}
> > >  =09}
> > >
> > > --
> > > 2.43.0
> >
> > -
> > Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, M=
K1 1PT, UK
> > Registration No: 1397386 (Wales)
> >

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


