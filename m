Return-Path: <linux-iio+bounces-9343-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 673299709A1
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 22:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 157B32822F7
	for <lists+linux-iio@lfdr.de>; Sun,  8 Sep 2024 20:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F4F176231;
	Sun,  8 Sep 2024 20:09:18 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFFE38DD6
	for <linux-iio@vger.kernel.org>; Sun,  8 Sep 2024 20:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725826158; cv=none; b=ACrNhf8ylkqasKVq8Vwm/dBjjNvISzBsGCpiyPWZi9adE02yBbmbeZdqqAeUWpnKOZr8DlLTB2Es5y+l/PW7pKdmFN/uEHRx3MllYSQxsKlQSJaGpHGbafmBCmn2iNPUHiDvLGQoFqL4rs8iXt9g7KInvmgeUbj7T78jIzVkxE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725826158; c=relaxed/simple;
	bh=p6VaXswkVMt+/nrO+3llC0ajxrizwRKM0gGd5YcZkL0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=lf4m6f6kjcrfLZixIytZrxob8QtJtmqoUN0AOfEvAH8g2cwExQDYAoiVCgtt49BodcdF+rBt1C4QDfNR61/r1aSlFmUpNYkERTPMC93Dxhrub6St4j2CKXYdkhqZ0hp+3Wg/Cq2GQfywdAkalNtyitXHxh/tzRqKiG9e0qHrauQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-189-DlpiOEDTPwewvHdPb7wYIQ-1; Sun, 08 Sep 2024 21:09:14 +0100
X-MC-Unique: DlpiOEDTPwewvHdPb7wYIQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 8 Sep
 2024 21:08:23 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 8 Sep 2024 21:08:23 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Andy Shevchenko' <andy.shevchenko@gmail.com>, zhangjiao2
	<zhangjiao2@cmss.chinamobile.com>
CC: "wbg@kernel.org" <wbg@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tools/counter: close fd when exit
Thread-Topic: [PATCH] tools/counter: close fd when exit
Thread-Index: AQHa/lexq8tEdkkcmk+AF8q7qW17QrJOWESw
Date: Sun, 8 Sep 2024 20:08:23 +0000
Message-ID: <e1259039a99d4f23958c4380e5c0b11f@AcuMS.aculab.com>
References: <20240903080121.5294-1-zhangjiao2@cmss.chinamobile.com>
 <ZteZiKKsAYmGdu0s@surfacebook.localdomain>
In-Reply-To: <ZteZiKKsAYmGdu0s@surfacebook.localdomain>
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
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Andy Shevchenko
> Sent: 04 September 2024 00:20
>=20
> Tue, Sep 03, 2024 at 04:01:21PM +0800, zhangjiao2 kirjoitti:
> > From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> >
> > close fd when exit the program
>=20
> Please, mind English grammar and punctuation.
> Also this doesn't state what the problem is.

After all, when the program exits the kernel closes all the files.

> >  =09=09if (ret =3D=3D -1) {
> >  =09=09=09fprintf(stderr, "Error adding watches[%d]: %s\n", i,
> >  =09=09=09=09strerror(errno));
> > +=09=09=09close(fd);
>=20
> Since fd is not used in the messaging it's better to close it before prin=
ting
> anything. Ditto for other cases.

Unless close() decides to change errno...

>=20
> ...
>=20
> >  =09=09if (ret !=3D sizeof(event_data)) {
> >  =09=09=09fprintf(stderr, "Failed to read event data\n");
> > +=09=09=09close(fd);
>=20
> >  =09=09=09return -EIO;
>=20
> Side note: This will return garbage to the userspace. Should be
>=20
> =09=09=09return EIO;

If that is the return value from main() it is equally invalid.
Valid return values are 0..255 but 128..255 are likely to be
interpreted as 'killed by a signal'.
So really you only get 0..127.
Mostly used as 0 =3D> success and 1 =3D> failure.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


