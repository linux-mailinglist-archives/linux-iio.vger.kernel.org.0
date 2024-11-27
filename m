Return-Path: <linux-iio+bounces-12725-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0879DA433
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 09:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 063E2B26B77
	for <lists+linux-iio@lfdr.de>; Wed, 27 Nov 2024 08:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E5F1917E7;
	Wed, 27 Nov 2024 08:54:03 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10F9154C12
	for <linux-iio@vger.kernel.org>; Wed, 27 Nov 2024 08:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732697643; cv=none; b=tmOkT1SElvcdxeGC2/UQSHoZYbo0WGeJrRBRNIlCC6KjyKWj1buSbok2zB2j+eT21yiZ55vEZdfhng66caEtXux2Yaa5ed3eeMASLdx0n9Csd4xsyStsTGfZ462PTLvKdoIoAp7SedIjU+s3X+9AMfOFiKMOwcpCg6epnCD33Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732697643; c=relaxed/simple;
	bh=YfgpoTDd4KRWX9QYXR4+HGyPFUeAuWa72g0EH8fO3D4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=tbb3hVUcicX/B1ScFyNRzKBEJnPfgs99HGasQUg7BZvAJcyLN2SdH4oMBC4hOI1O7ydmHtKqwmJD4IMOVALW0QTD+/vCyZGlmv3YnJTqlC0mrELZdV2I/0+1ew4kmaLpPNd6g8z6wO4tVk6dHMF0GxcJAPLaq4KKIs+24kniGdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-320-eUu2RzI3O8WJKx3gHkW80w-1; Wed, 27 Nov 2024 08:53:58 +0000
X-MC-Unique: eUu2RzI3O8WJKx3gHkW80w-1
X-Mimecast-MFC-AGG-ID: eUu2RzI3O8WJKx3gHkW80w
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 27 Nov
 2024 08:53:49 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 27 Nov 2024 08:53:49 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jakob Hauser' <jahau@rocketmail.com>, Jonathan Cameron
	<jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
CC: Linus Walleij <linus.walleij@linaro.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>
Subject: RE: [PATCH] iio: magnetometer: yas530: Use signed integer type for
 clamp limits
Thread-Topic: [PATCH] iio: magnetometer: yas530: Use signed integer type for
 clamp limits
Thread-Index: AQHbQFyZWpVb6JGTu0SOPl1PuO8j1LLK0lfw
Date: Wed, 27 Nov 2024 08:53:49 +0000
Message-ID: <a28168acf9374c60902cdb5aa7608dee@AcuMS.aculab.com>
References: <20241126234021.19749-1-jahau.ref@rocketmail.com>
 <20241126234021.19749-1-jahau@rocketmail.com>
In-Reply-To: <20241126234021.19749-1-jahau@rocketmail.com>
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
X-Mimecast-MFC-PROC-ID: GCQIciNWIumsP9zKeUNSYboaflliYxO-Ec34kRekpmw_1732697637
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Jakob Hauser <jahau@rocketmail.com>
> Sent: 26 November 2024 23:40
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

I think you also need to say that the unsigned divide generates erronous
values on 32bit systems and that the clamp() call result is ignored.

>=20
> Declaring a signed integer with a value of BIT(13) allows to use it more
> specifically as a negative value on the lower clamp limit.
>=20
> While at it, replace all BIT(13) in the function yas537_measure() by the =
signed
> integer.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202411230458.dhZwh3TT-lkp@i=
ntel.com/
> Fixes: 65f79b501030 ("iio: magnetometer: yas530: Add YAS537 variant")
> Cc: David Laight <david.laight@aculab.com>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> ---
> The patch is based on torvalds/linux v6.12.
>=20
> The calculation lines h[0], h[1] and h[2] exceed the limit of 80 characte=
rs per
> line. In terms of readability I would prefer to keep it that way.
> ---
>  drivers/iio/magnetometer/yamaha-yas530.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magne=
tometer/yamaha-yas530.c
> index 65011a8598d3..938b35536e0d 100644
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
> +=09=09=09clamp_val(h[i], -half_range, half_range - 1);
> +=09=09=09xy1y2[i] =3D h[i] + half_range;

NAK - that still ignores the result of clamp.
and it should be clamp() not clamp_val().

=09David

>  =09=09}
>  =09}
>=20
> --
> 2.43.0

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


