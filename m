Return-Path: <linux-iio+bounces-12850-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 471FD9DF03B
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 12:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62704160F28
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 11:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926621917FE;
	Sat, 30 Nov 2024 11:41:12 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5211F148838
	for <linux-iio@vger.kernel.org>; Sat, 30 Nov 2024 11:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732966872; cv=none; b=UK2Wav3ByO+jj286tRzE6m2Te5rv8Edtd3cnmuU21gt3Rvlvbfhb0fKWvTe8bflA6/YDJh7zw8uj1gzfgFI35lQenPOdCZjCL7Uo7m2jENT/oFDU5B1fTgIvZhEsKp9DAhYTIcv0CgrGINx1jjhIBPp/J/9q/EWvELmAzYO3dKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732966872; c=relaxed/simple;
	bh=ZkgM0jh3bG1eg6LsqeL9J5DryQDqaeaGQHF+dekYHLg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=ATpUEtqv6C5bFtQqqTTOjxCVzd/ZtlLrP6vblukyvG9Omgd3ZCQNBvg8VvmhpXHj6xXjaMKu6xSYis1RDQZEaNAcselhOe+Ccw1uuVtq/MMbOjV5ty08eWNDtcla0uOhotUyMRgoa7oCZ8TILdzYEV+VR7QMc2YtDinvdwWcgxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-275-FE_uBcOWMd6AjZiYwVeYLA-1; Sat, 30 Nov 2024 11:41:06 +0000
X-MC-Unique: FE_uBcOWMd6AjZiYwVeYLA-1
X-Mimecast-MFC-AGG-ID: FE_uBcOWMd6AjZiYwVeYLA
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 30 Nov
 2024 11:40:45 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 30 Nov 2024 11:40:45 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jakob Hauser' <jahau@rocketmail.com>, Jonathan Cameron
	<jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Andrew Morton
	<akpm@linux-foundation.org>
CC: Linus Walleij <linus.walleij@linaro.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>
Subject: RE: [PATCH v2] iio: magnetometer: yas530: Use signed integer type for
 clamp limits
Thread-Topic: [PATCH v2] iio: magnetometer: yas530: Use signed integer type
 for clamp limits
Thread-Index: AQHbQqUs2JSj3AGLWkSCiQkgtAYVhLLPsp/w
Date: Sat, 30 Nov 2024 11:40:45 +0000
Message-ID: <9f5793f03c2440d2aa18630469df06df@AcuMS.aculab.com>
References: <11609b2243c295d65ab4d47e78c239d61ad6be75.1732914810.git.jahau@rocketmail.com>
 <11609b2243c295d65ab4d47e78c239d61ad6be75.1732914810.git.jahau@rocketmail.com>
In-Reply-To: <11609b2243c295d65ab4d47e78c239d61ad6be75.1732914810.git.jahau@rocketmail.com>
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
X-Mimecast-MFC-PROC-ID: dWiqrudVhKPgNyTXvm-7D-nQUzXRxsWmnxKw8_UV4Uw_1732966866
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Jakob Hauser

Copying Andrew M - he might want to take this through his mm tree.

> Sent: 29 November 2024 21:25
>=20
> In the function yas537_measure() there is a clamp_val() with limits of
> -BIT(13) and  BIT(13) - 1. The input clamp value h[] is of type s32. The =
BIT()
> is of type unsigned long integer due to its define in include/vdso/bits.h=
.
> The lower limit -BIT(13) is recognized as -8192 but expressed as an unsig=
ned
> long integer. The size of an unsigned long integer differs between 32-bit=
 and
> 64-bit architectures. Converting this to type s32 may lead to undesired
> behavior.
>=20
> Additionally, in the calculation lines h[0], h[1] and h[2] the unsigned l=
ong
> integer divisor BIT(13) causes an unsigned division, shifting the left-ha=
nd
> side of the equation back and forth, possibly ending up in large positive
> values instead of negative values on 32-bit architectures.
>=20
> To solve those two issues, declare a signed integer with a value of BIT(1=
3).
>=20
> There is another omission in the clamp line: clamp_val() returns a value =
and
> it's going nowhere here. Self-assign it to h[i] to make use of the clamp
> macro.
>=20
> Finally, replace clamp_val() macro by clamp() because after changing the =
limits
> from type unsigned long integer to signed integer it's fine that way.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202411230458.dhZwh3TT-lkp@i=
ntel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202411282222.oF0B4110-lkp@i=
ntel.com/
> Fixes: 65f79b501030 ("iio: magnetometer: yas530: Add YAS537 variant")
> Cc: David Laight <david.laight@aculab.com>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>

Reviewed-by: David Laight <david.laight@aculab.com>

I THINK all the other BIT() and GENMASK() are ok.
The code also rather heavily relies on u16 being promoted to 'signed int'.

=09David


> ---
> The patch is based on torvalds/linux v6.12.
>=20
> The calculation lines h[0], h[1] and h[2] exceed the limit of 80 characte=
rs per
> line. In terms of readability I would prefer to keep it that way.
>=20
> Changes in v2:
>  - Self-assigned the clamp macro to h[i].
>  - Changed from clamp_val() macro to clamp().
>  - In commit message added issues on divisor BIT(13) and missing clamp
>    assignment.
>  - In tags added another (duplicate) report by the kernel test robot.
>=20
> Link to v1: https://lore.kernel.org/linux-iio/20241126234021.19749-1-jaha=
u@rocketmail.com/T/#t
> ---
>  drivers/iio/magnetometer/yamaha-yas530.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magne=
tometer/yamaha-yas530.c
> index 65011a8598d3..c55a38650c0d 100644
> --- a/drivers/iio/magnetometer/yamaha-yas530.c
> +++ b/drivers/iio/magnetometer/yamaha-yas530.c
> @@ -372,6 +372,7 @@ static int yas537_measure(struct yas5xx *yas5xx, u16 =
*t, u16 *x, u16 *y1, u16 *y
>  =09u8 data[8];
>  =09u16 xy1y2[3];
>  =09s32 h[3], s[3];
> +=09int half_range =3D BIT(13);
>  =09int i, ret;
>=20
>  =09mutex_lock(&yas5xx->lock);
> @@ -406,13 +407,13 @@ static int yas537_measure(struct yas5xx *yas5xx, u1=
6 *t, u16 *x, u16 *y1, u16 *y
>  =09/* The second version of YAS537 needs to include calibration coeffici=
ents */
>  =09if (yas5xx->version =3D=3D YAS537_VERSION_1) {
>  =09=09for (i =3D 0; i < 3; i++)
> -=09=09=09s[i] =3D xy1y2[i] - BIT(13);
> -=09=09h[0] =3D (c->k *   (128 * s[0] + c->a2 * s[1] + c->a3 * s[2])) / B=
IT(13);
> -=09=09h[1] =3D (c->k * (c->a4 * s[0] + c->a5 * s[1] + c->a6 * s[2])) / B=
IT(13);
> -=09=09h[2] =3D (c->k * (c->a7 * s[0] + c->a8 * s[1] + c->a9 * s[2])) / B=
IT(13);
> +=09=09=09s[i] =3D xy1y2[i] - half_range;
> +=09=09h[0] =3D (c->k *   (128 * s[0] + c->a2 * s[1] + c->a3 * s[2])) / h=
alf_range;
> +=09=09h[1] =3D (c->k * (c->a4 * s[0] + c->a5 * s[1] + c->a6 * s[2])) / h=
alf_range;
> +=09=09h[2] =3D (c->k * (c->a7 * s[0] + c->a8 * s[1] + c->a9 * s[2])) / h=
alf_range;
>  =09=09for (i =3D 0; i < 3; i++) {
> -=09=09=09clamp_val(h[i], -BIT(13), BIT(13) - 1);
> -=09=09=09xy1y2[i] =3D h[i] + BIT(13);
> +=09=09=09h[i] =3D clamp(h[i], -half_range, half_range - 1);
> +=09=09=09xy1y2[i] =3D h[i] + half_range;
>  =09=09}
>  =09}
>=20
> --
> 2.43.0

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


