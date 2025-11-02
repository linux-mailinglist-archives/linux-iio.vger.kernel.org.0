Return-Path: <linux-iio+bounces-25804-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C76C28EF0
	for <lists+linux-iio@lfdr.de>; Sun, 02 Nov 2025 13:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38B1188C3E1
	for <lists+linux-iio@lfdr.de>; Sun,  2 Nov 2025 12:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF27726B973;
	Sun,  2 Nov 2025 12:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qv0dNXbl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBD6212B3D;
	Sun,  2 Nov 2025 12:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762085518; cv=none; b=TNuhTgWgoCXv1P7X7B1YgIpKmvzjNFKP8JMXlgHGbO3wlQHVugIt+xsZMKIKg+PVBwPo23mHdOGwMgmiP9Z7ltcGh2hSjg1q89+ARS6CXPkAIjV+Bo20+ydtZ3X9ilcOkh6z5P5nCyRqLdbNkEyxiP+LG9ZbhW5PJFM4xUL+1do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762085518; c=relaxed/simple;
	bh=5NVmm6EqUk/gllIoBohqIWSKedJXqcdaNi1p/vwhZaI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bq+ls6c21JGij6bkInoh2KoHyjU7i52IhrFlrmBAaMj54t7ttm2V2ZEonP4lHvLTjIcKgOP8jMaoWsyK3mmbSx1RR9xy/5kz59ZNIn2LhLcpie4bABBt1vox3p3FkxZNwG3E5YHrfoWEUNxyh0gVv9ppHRWYFd3EEO/UiUe7Stg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qv0dNXbl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A12C4CEF7;
	Sun,  2 Nov 2025 12:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762085518;
	bh=5NVmm6EqUk/gllIoBohqIWSKedJXqcdaNi1p/vwhZaI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qv0dNXblLWul+JiNLUPm3nQk+eimY9Kk5x5VV7ga8JiJgvT8SmM7uZqx6W+k7Xop0
	 kdVwlg7VminscSjXn/l/SynUzAmMAacwhlI3S7KuBOLYw1HF9Fa4RH0WOi3dmol9f7
	 pF4ndtbcyr4aCw9wGxK9wkThym0Ak5jT/FAxS3KJfNEUjiMAh4hNq0it4DVD0/tYK0
	 VqmOpNPSV1yTRX6Hqp5BSrZA6bcOz4NajePYc+rE/MfcZyXzs7vjxBbr0Kuyr64MZX
	 pkpczIE+OYDHiOG9ccpRebCgaAwiSPZCNKZFhgwfw/niwfOPuKaWFMfWWnInkAsv20
	 LWrinndBwQwlA==
Date: Sun, 2 Nov 2025 12:11:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: "Gary =?UTF-8?B?Q2h1?=(=?UTF-8?B?5qWa5YWJ5bqG?=)"
 <chuguangqing@inspur.com>, lars <lars@metafoo.de>, "Michael.Hennerich"
 <Michael.Hennerich@analog.com>, dlechner <dlechner@baylibre.com>, "nuno.sa"
 <nuno.sa@analog.com>, andy <andy@kernel.org>, "subhajit.ghosh"
 <subhajit.ghosh@tweaklogic.com>, "javier.carrasco.cruz"
 <javier.carrasco.cruz@gmail.com>, linux-iio <linux-iio@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] iio: light: apds9960: convert to use maple tree
 register cache
Message-ID: <20251102121151.6120fef2@jic23-huawei>
In-Reply-To: <aQB6cFpTsBssGej3@smile.fi.intel.com>
References: <abf45488369cbcce6298cc0ea19c0b3a24-10-25intel.com@sslemail.net>
	<aPs9HdeTZKoqFqdk@smile.fi.intel.com>
	<68fc4591.1.gk94qBPVZajhk94q@inspur.com>
	<aP8tvj_IPbv65m0T@smile.fi.intel.com>
	<20251027133806.5e4368bc@jic23-huawei>
	<aQB6cFpTsBssGej3@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Oct 2025 10:10:24 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Oct 27, 2025 at 01:38:06PM +0000, Jonathan Cameron wrote:
> > On Mon, 27 Oct 2025 10:30:54 +0200
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote: =20
> > > On Sat, Oct 25, 2025 at 11:36:45AM +0800, Gary Chu(=E6=A5=9A=E5=85=89=
=E5=BA=86) wrote: =20
> > > > >On Fri, Oct 24, 2025 at 03:38:23PM +0800, Chu Guangqing wrote:   =
=20
> > > > >> The maple tree register cache is based on a much more modern dat=
a structure
> > > > >> than the rbtree cache and makes optimisation choices which are p=
robably
> > > > >> more appropriate for modern systems than those made by the rbtre=
e cache.   =20
>=20
> ...
>=20
> > > > >>   .reg_defaults =3D apds9960_reg_defaults,
> > > > >>   .num_reg_defaults =3D ARRAY_SIZE(apds9960_reg_defaults),   =20
> > > > >
> > > > >^^^^ Be careful with such cases, the cache implementations may beh=
ave
> > > > >differently. Have you tested this on the actual HW?
> > > > >   =20
> > > > We have conducted tests on some hardware, and performance improveme=
nts were observed,
> > > >  though tests have not been carried out on all hardware models.
> > > > Neither rbtree nor maple tree directly depends on hardware types (s=
uch as CPU or peripheral
> > > >  models). Instead, they rely on the address distribution characteri=
stics (discrete/continuous)
> > > >  of hardware registers. The optimal cache type is determined by the=
 hardware layout.
> > > > Red-black trees excel at individual operations on discrete addresse=
s, while Maple Trees are
> > > >  proficient in range operations on contiguous addresses.   =20
> > >=20
> > > It's not about the low-level cache implementation, it's about regmap
> > > abstraction implementation that might differ from cache to cache
> > > implementations. This all in regard how the cold cache is getting fil=
led up.
> > > There is a separate discussion (unrelated to the topic of your series=
) where
> > > this was brought up. =20
> >=20
> > I appreciate these things can be hard to track down with lots of thread=
s in flight
> > but any chance of a reference for that? I'd be a little surprised if th=
ese uses
> > are complicated enough to hit corner cases but would like to know more.
> > I've taken a few similar changes in the past thinking there would be no
> > practical difference. =20
>=20
> Sure, it appeared in the discussion of v2 of the following patch:
> https://lore.kernel.org/linux-gpio/20251009132651.649099-2-bigunclemax@gm=
ail.com/

Thanks - that's useful info.

Here the uses are all simple and I can't see any likelihood of problems + w=
e've
had a bunch of these changes from RBTREE to MAPLE in the past without issue.

So applied

Thanks,

Jonathan

>=20
> > > That's why I asked how this was tested.
> > >=20
> > > In any case, up to Jonathan, but I had to rise a potential misbehave,=
 so in my
> > > opinion this kind of corner cases needs to be tested on real HW.
> > >  =20
> > > > >>   .max_register =3D APDS9960_REG_GFIFO_DIR(RIGHT),
> > > > >> - .cache_type =3D REGCACHE_RBTREE,
> > > > >> + .cache_type =3D REGCACHE_MAPLE,
> > > > >>  };   =20
>=20


