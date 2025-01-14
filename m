Return-Path: <linux-iio+bounces-14347-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F129A107A9
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 14:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 662A718880CE
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 13:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0BC2361F4;
	Tue, 14 Jan 2025 13:23:12 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C77229627;
	Tue, 14 Jan 2025 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736860992; cv=none; b=ncgO7qnTeW71YJBfdNAgUmnKYhaA953mmUaXk7Tc6AaWDu+ct+zVxeymWkA4OogS6Xo5ZPRITF52AuyW8om/xx6P2S2XzxViJBIywgNioWzk93Wpm7s+0LVYgsybutEbPpUE39MKqXS2JrdZPgonWFnvPE3cS0Bzi4SUKSSfIVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736860992; c=relaxed/simple;
	bh=uLpRw8X8vLSs1oY/jSn9oruLtF7zoiEu+57tdk3J3Lk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tgSMXbHcr9Vb4sb8E0UWHjE56by2+qByiocpW8i6nXOo0/vDaujWBXQguqRcnYhrynkBUAgEMMP1nWgTH/RcIRTKHzXcpzpOxtG0kmXW8soUGwKmsy7sQj59hCw0qOohU50w9gvU7m7Orc4tWN7L+c3e9z0bNm9IrjjfGkFie90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YXVC85q5Fz6FGWS;
	Tue, 14 Jan 2025 21:21:40 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CE8BF14022E;
	Tue, 14 Jan 2025 21:23:07 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 14 Jan
 2025 14:23:07 +0100
Date: Tue, 14 Jan 2025 13:23:06 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Matti Vaittinen
	<mazziesaccount@gmail.com>, Jonathan Cameron <jic23@kernel.org>, "Lars-Peter
 Clausen" <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] iio: light: veml3235: extend regmap to add cache
Message-ID: <20250114132306.00005358@huawei.com>
In-Reply-To: <CAHp75Ven01nuqM=PXpPN+XHi1r8AS=j7kRM16KtvAr1kZbjvfQ@mail.gmail.com>
References: <20241224-veml3235_scale-v2-0-2e1286846c77@gmail.com>
	<20241224-veml3235_scale-v2-3-2e1286846c77@gmail.com>
	<Z4PdP1ZWkd_YgzJF@surfacebook.localdomain>
	<D7082ZE34NTT.DHC0Y5220527@gmail.com>
	<CAHp75Vd5LdP7+ndresVv5STN2zrC3S5puDhcACyEk7MbLA0hgA@mail.gmail.com>
	<D708DGNQA4MO.1DD0OCM1TOHS2@gmail.com>
	<CAHp75Ven01nuqM=PXpPN+XHi1r8AS=j7kRM16KtvAr1kZbjvfQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sun, 12 Jan 2025 20:50:41 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Jan 12, 2025 at 6:21=E2=80=AFPM Javier Carrasco
> <javier.carrasco.cruz@gmail.com> wrote:
> > On Sun Jan 12, 2025 at 5:11 PM CET, Andy Shevchenko wrote: =20
> > > On Sun, Jan 12, 2025 at 6:07=E2=80=AFPM Javier Carrasco
> > > <javier.carrasco.cruz@gmail.com> wrote: =20
> > > > On Sun Jan 12, 2025 at 4:18 PM CET, Andy Shevchenko wrote: =20
> > > > > Tue, Dec 24, 2024 at 11:59:02AM +0100, Javier Carrasco kirjoitti:=
 =20
> > > > > > The configuration and ID registers are not volatile and are not=
 affected
> > > > > > by read operations (i.e. not precious), making them suitable to=
 be
> > > > > > cached in order to reduce the number of accesses to the device.=
 =20
>=20
> ...
>=20
> > > > > > +   .cache_type =3D REGCACHE_RBTREE, =20
> > > > >
> > > > > Any specific reason why this is NOT a maple tree? =20
> > > >
> > > > I followed the most common approach in IIO (52 RBTREE vs 2 MAPLE), =
=20
> > >
> > > But it's historical and can't be taken as an argument.
> > > =20
> > > > assuming that the "low-end systems" comment for the different REGCA=
CHE_*
> > > > applies well to the typical systems that will make use of this driv=
er,
> > > > and many others under IIO. I considered that *possible* performance
> > > > advantage for low-end systems above other considerations, like the
> > > > general rule about using maple tree. =20
> > >
> > > https://elixir.bootlin.com/linux/v6.13-rc3/source/include/linux/regma=
p.h#L58
> > >
> > > "Any new caches
> > >  * should usually use the maple tree cache unless they specifically
> > >  * require that there are never any allocations at runtime and can't
> > >  * provide defaults in which case they should use the flat cache."
> > >
> > > Can you reconsider? =20
> >
> > That was exactly the comment I referenced, actually the part about
> > low-end systems that appears right after what you highlighted.
> >
> > I have nothing against switching to MAPLE, if that is preferred even if
> > the main user of this driver will be a low-end system. I think that IIO
> > is a typical subsystem that addresses needs for very low-end systems
> > that are sometimes slightly more powerful than a microcontroller, but on
> > the other hand I am by no means an expert, and if MAPLE is the way to go
> > here as well, I will send a follow-up patch for it. =20
>=20
> Ah, I see now. Okay, I leave it then to Jonathan as I am okay with any
> choice as long as it's understood and justified.

For a fairly small regmap, I doubt there is a strong reason to care about t=
he choice.
So stick to what you have.  For future drivers we can reassess as makes sen=
se.

Jonathan

>=20
>=20


