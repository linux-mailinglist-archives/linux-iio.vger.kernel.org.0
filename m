Return-Path: <linux-iio+bounces-25868-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D556FC315E3
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 15:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA4943A5929
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 14:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C214722D7B0;
	Tue,  4 Nov 2025 14:00:21 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF39E20F079
	for <linux-iio@vger.kernel.org>; Tue,  4 Nov 2025 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264821; cv=none; b=HdYT7PIWMalD9b9kDahOkpERu0IQ5N8kweta30zI3JML6KxwW1HxntFU9QJ0yPJnZddB0poTtZvOvg9z7JrobwJG1m7qyL3qHczgRswCsFr5f+hYIl2VKR3WEGdv9Y/zqVvCTainkUWopsf/RAwDES7/Yw9uZ9RPk55K6tYPRBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264821; c=relaxed/simple;
	bh=+8vGqe2wlT1ox/p958E6fM1MWAa6j4IK7GeIxFDy9Ao=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q83WP20B/6l/i+X1me2XZ3HpkU6PcRufi55dA9mMMKZBQQ8F7M8MzcZo1tQaeROGfzgArjk4KU+LspAlEsPmCh18ZtoISRScYW/ESa48pefVyEvwffH5c/UCXp/Gi/JDkZ5YytE1U+QJIii6RZUl/dAfVR/VaaeWl+LXlyHaezs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d197v0M57zHnGhW;
	Tue,  4 Nov 2025 22:00:11 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 829A414037D;
	Tue,  4 Nov 2025 22:00:14 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 4 Nov
 2025 14:00:08 +0000
Date: Tue, 4 Nov 2025 14:00:07 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
CC: Andy Shevchenko <andriy.shevchenko@intel.com>, Jonathan Cameron
	<jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?= via B4 Relay
	<devnull+nuno.sa.analog.com@kernel.org>, <nuno.sa@analog.com>,
	<linux-iio@vger.kernel.org>, Michael Hennerich
	<Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, "Andy
 Shevchenko" <andy@kernel.org>
Subject: Re: [PATCH v3 06/10] iio: dac: ad5446: Separate I2C/SPI into
 different drivers
Message-ID: <20251104140007.00006f20@huawei.com>
In-Reply-To: <94c042be7ef7842f057d87d466ad7fffb17581ed.camel@gmail.com>
References: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
	<20251031-dev-add-ad5542-v3-6-d3541036c0e6@analog.com>
	<20251101164612.449606c2@jic23-huawei>
	<aQhcFl4fE5Akn397@smile.fi.intel.com>
	<3c82c959e714ec8507d2c28494bb24d9146cfee3.camel@gmail.com>
	<aQkC4kev0hR9-yQU@smile.fi.intel.com>
	<94c042be7ef7842f057d87d466ad7fffb17581ed.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 04 Nov 2025 07:44:13 +0000
Nuno S=E1 <noname.nuno@gmail.com> wrote:

> On Mon, 2025-11-03 at 21:30 +0200, Andy Shevchenko wrote:
> > On Mon, Nov 03, 2025 at 10:40:20AM +0000, Nuno S=E1 wrote: =20
> > > On Mon, 2025-11-03 at 09:39 +0200, Andy Shevchenko wrote: =20
> > > > On Sat, Nov 01, 2025 at 04:46:12PM +0000, Jonathan Cameron wrote: =
=20
> > > > > On Fri, 31 Oct 2025 12:31:27 +0000
> > > > > Nuno S=E1 via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wr=
ote: =20
> >=20
> > ...
> >  =20
> > > > > > +	st->d16 =3D cpu_to_be16(val); =20
> > > > >=20
> > > > > Should have an include for this.=A0 Probably
> > > > >=20
> > > > > linux/byteorder/generic.h
> > > > > though the kernel (and iio) has a random mix of that and
> > > > > asm/byteorder.h =20
> > >=20
> > > Yeah, I did tried linux/byteorder/generic.h but it fails to compile i=
f it's the
> > > first=20
> > > thing we include so I did not wanted to go that way :) =20
> > > > Can somebody go and fix all of them to be asm/byteorder.h? Yeah, it=
 might need
> > > > some thinking as in some _rare_ cases the author might imply the ex=
plicit
> > > > choice of the algo in use. But then it might be problematic on some
> > > > architectures
> > > > as well...
> > > >  =20
> > > > > Hmm. linux/unaligned.h is using asm/byteorder.h so maybe that's t=
he better
> > > > > choice =20
> > > >=20
> > > > Yes. =20
> > >=20
> > > Hmm, so linux/unaligned.h or asm/byteorder.h? For the spi version I d=
o have
> > > linux/unaligned.h beacuse we use some APIs but for i2c there's no use=
 on
> > > unaligned so
> > > it feels a bit odd to include it? =20
> >=20
> > Maybe I misread what Jonathan said, but I meant that asm/byteorder.h is=
 a
> > better choice over other *byteorder*.h variants. =20
>=20
> Ack. I was the one that got confused with your reply so I wanted to confi=
rm
> before v4.
>=20
I only meant that it was probably right choice in unaligned.h to use asm/by=
teorder.h
So definitely agree fixing all cases up to use asm/byteorder.h is the way
to go based on Andy's feedback.

unaligned.h is only appropriate if the calls made are all the unaligned var=
iants.
If it's a mix, should include that and asm/byteorder.h

Thanks,

Jonathan

> - Nuno S=E1
>=20


