Return-Path: <linux-iio+bounces-13181-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A559E79E9
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 21:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942FC1882FF7
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 20:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CE11F3D3A;
	Fri,  6 Dec 2024 20:14:38 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956921C54B8
	for <linux-iio@vger.kernel.org>; Fri,  6 Dec 2024 20:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733516078; cv=none; b=FcACHc/X2MzUzhWvrnfF3qU4qovqcbNeMtvjv2SquHsoB0RLVi73WdI3/b4DybqBZN9RkiYuMnxfkMHaNwQAtLxgmWM78CBQVNzYB98LvUYDzeOUT+Jh/DxUaj9T/KDb+o6E60E9rM4EZQKxj6KGedVnWxsZvmgwHbwvL1AQfNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733516078; c=relaxed/simple;
	bh=crdrIU87cmRDRZn0i0zAKUBSB8zhN6TjPShRglgziQc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Zhzz31g4/r7TKLccOvMxXFfHfClFPfNMDJTv3gFUnUGbDPznJTGUowUquOGNQ+65AI3zLb4PfgOnSTvtgPDtnwWApzyDlGuT/tyrDxJ4okE97djOn40x+p6KKVXcaYm0fYclNYW6XEunn6Ej92fcDOyg0wre/RvEoU8L+5O22sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-265-SKHl7LnjO8e01avqgVl2jQ-1; Fri, 06 Dec 2024 20:14:33 +0000
X-MC-Unique: SKHl7LnjO8e01avqgVl2jQ-1
X-Mimecast-MFC-AGG-ID: SKHl7LnjO8e01avqgVl2jQ
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 6 Dec
 2024 20:13:46 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 6 Dec 2024 20:13:46 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Rosin
	<peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
	<lars@metafoo.de>
Subject: RE: [PATCH v1 1/4] iio: afe: rescale: Don't use ^ for booleans
Thread-Topic: [PATCH v1 1/4] iio: afe: rescale: Don't use ^ for booleans
Thread-Index: AQHbRezm1jhKv1T7YkOoxbKwnK16YbLZNdEggAAi1wCAAEqwwA==
Date: Fri, 6 Dec 2024 20:13:46 +0000
Message-ID: <2a7a87267feb4c35ad9ef493236b6035@AcuMS.aculab.com>
References: <20241204013620.862943-1-andriy.shevchenko@linux.intel.com>
 <20241204013620.862943-2-andriy.shevchenko@linux.intel.com>
 <88f281a31d8342c691b2a6b2666d4e91@AcuMS.aculab.com>
 <Z1MWBsCJsTHsqNey@smile.fi.intel.com>
In-Reply-To: <Z1MWBsCJsTHsqNey@smile.fi.intel.com>
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
X-Mimecast-MFC-PROC-ID: JKGgs8D22nhMwOVkKQYx9Zns8g_i6bGPC4DnQXDftcY_1733516072
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: 'Andy Shevchenko'
> Sent: 06 December 2024 15:20
...
> ...
>=20
> > >  =09=09 * If only one of the rescaler elements or the schan scale is
> > >  =09=09 * negative, the combined scale is negative.
> > >  =09=09 */
> > > -=09=09if (neg ^ ((rescale->numerator < 0) ^ (rescale->denominator < =
0))) {
> > > +=09=09if (neg !=3D (rescale->numerator < 0 || rescale->denominator <=
 0)) {
> >
> > That is wrong, the || would also need to be !=3D.
>=20
> Why do you think so? Maybe it's comment(s) that is(are) wrong?

The old code certainly negates for each of them - so you can get the double
and triple negative cases.
So believe the code not the comment.
>=20
> > Which will all generate real pile of horrid code.
> > (I think the x86 version will stun you.)
>=20
> I think your remark is based on something, can you show the output to ela=
borate
> what exactly becomes horrible in this case?

Ok it isn't quite as bad as I thought because all the compilers will use xo=
r
for the equality test on sign bits. See https://www.godbolt.org/z/qxz5KPcTh
So changing ^ to !=3D makes no difference at all.

But f3() shows the sort of thing that can happen.
Sometimes made worse because the x86 SETcc instruction only set 8bit regist=
ers.
(Odd since they got added for the 386)

=09David

>=20
> > I'm guessing that somewhere there is a:
> > =09neg =3D value < 0;
>=20
> Nope.
>=20
> > Provided all the values are the same size (eg int/s32), in which case:
> > =09neg =3D value;
> > ...
> > =09if ((neg ^ rescale->numerator ^ rescale->denominator) < 0)
> > will be the desired test.
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


