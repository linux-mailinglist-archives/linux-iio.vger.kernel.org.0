Return-Path: <linux-iio+bounces-12910-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DED079DF552
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 12:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83E26281130
	for <lists+linux-iio@lfdr.de>; Sun,  1 Dec 2024 11:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9379A138490;
	Sun,  1 Dec 2024 11:04:37 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3B83B1A1
	for <linux-iio@vger.kernel.org>; Sun,  1 Dec 2024 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733051077; cv=none; b=LfKz5p7wxd08t0yTgqn//5U+gAwrWfXZBr+SSEn7lqAeQ7MLI7e8fw7zljCgpgJW2nMONQCcSsUH5H7X6AayhLksckzadMzAja+uhgKYjJFXMiZGW7J5pRrBJ3CvbcQdE3FU7VydqE9tW56UrVSpBPhO08M1tjI8BvmvkzQaUsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733051077; c=relaxed/simple;
	bh=8PCK8noxfQxOLX2UgQKkA9FGoT5mmarNJdvRN7k9i/c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=tgWTyzV6TGKtQ2uuIlhbuklakfdhmn94BWIWnYsKORB9Djf1EP4ZkzGFaHITnh48NIcGvgHwr3YFUdKADf0nHDNEs2O6yjdKjZskvUXOmwEUwz2Vtzk8JhTO1kxKamIrcysmcl8/H5M1ip7NLqnAwJ6EHAeyLqhABbmaoMES8lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-81-UNdrD75uNSmZjokXFspD-w-1; Sun, 01 Dec 2024 11:04:32 +0000
X-MC-Unique: UNdrD75uNSmZjokXFspD-w-1
X-Mimecast-MFC-AGG-ID: UNdrD75uNSmZjokXFspD-w
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 1 Dec
 2024 11:04:07 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 1 Dec 2024 11:04:07 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Andrew Morton' <akpm@linux-foundation.org>
CC: 'Jonathan Cameron' <jic23@kernel.org>, 'Jakob Hauser'
	<jahau@rocketmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij
	<linus.walleij@linaro.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>
Subject: RE: [PATCH v2] iio: magnetometer: yas530: Use signed integer type for
 clamp limits
Thread-Topic: [PATCH v2] iio: magnetometer: yas530: Use signed integer type
 for clamp limits
Thread-Index: AQHbQqUs2JSj3AGLWkSCiQkgtAYVhLLPsp/wgAAyLwCAAGnPcIAAXpgAgACOp1A=
Date: Sun, 1 Dec 2024 11:04:07 +0000
Message-ID: <c7a32b6f17e54dae94c4f5d16fd04df8@AcuMS.aculab.com>
References: <11609b2243c295d65ab4d47e78c239d61ad6be75.1732914810.git.jahau@rocketmail.com>
	<11609b2243c295d65ab4d47e78c239d61ad6be75.1732914810.git.jahau@rocketmail.com>
	<9f5793f03c2440d2aa18630469df06df@AcuMS.aculab.com>
	<20241130143506.53973e40@jic23-huawei>
	<6f2c9946a9fe4b40ac7dd5a66003c8c4@AcuMS.aculab.com>
 <20241130183222.ecf271abffcff61b93bbae22@linux-foundation.org>
In-Reply-To: <20241130183222.ecf271abffcff61b93bbae22@linux-foundation.org>
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
X-Mimecast-MFC-PROC-ID: p_Yq_G08DrlkTISXlwAx711huP947k9tlBDE6HKtaho_1733051071
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Andrew Morton
> Sent: 01 December 2024 02:32
>=20
> On Sat, 30 Nov 2024 20:59:22 +0000 David Laight <David.Laight@ACULAB.COM>=
 wrote:
>=20
> > From: Jonathan Cameron
> > > Sent: 30 November 2024 14:35
> > >
> > > On Sat, 30 Nov 2024 11:40:45 +0000
> > > David Laight <David.Laight@ACULAB.COM> wrote:
> > >
> > > > From: Jakob Hauser
> > > >
> > > > Copying Andrew M - he might want to take this through his mm tree.
> > >
> > > I'm confused. Why?
> > >
> > > Looks like a local bug in an IIO driver.  What am I missing?
> >
> > The build test bot picked it up because a change to minmax.h that Andre=
w
> > committed to the mm tree showed up the bug.
> > To avoid W=3D1 builds failing Andrew had applied a temporary 'fix'.
> > So he needs to be in the loop at least.
> > I don't know the actual procedure :-)
>=20
> Jakob's minmax changes
> (https://lkml.kernel.org/r/c50365d214e04f9ba256d417c8bebbc0@AcuMS.aculab.=
com)
> are queued in mm.git for 6.14-rc1.  They require a yas530 fix to build.

Those are my changes, not Jakobs...
(Not that it makes much difference here)

=09David

> So as I need to carry this yas530 fix in mm.git I'd like to merge it as
> a hotfix for 6.13-rcX, sometime in the next week or two.  So please
> send acks!

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


