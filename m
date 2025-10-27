Return-Path: <linux-iio+bounces-25468-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21453C0E212
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 14:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A28D04F9235
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 13:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E6B23E34C;
	Mon, 27 Oct 2025 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6JXYwhi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B0823278D;
	Mon, 27 Oct 2025 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761572295; cv=none; b=mb+qaArMYbEj8Ca7lni+i37tM970R2ICIOc2p46BI61WnFL8P5nALIWmufh4uEwq/Yz3Usfr3fZXi6InNtMFFaqIcu96rDisVrrfQIQ0zr89mmJGtzY2iy1beX8TvVO4rInXY0G2OZYShT2eJbwrUZlHMbPIjWCb5W2Vl3m3ZsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761572295; c=relaxed/simple;
	bh=zSptyYtFfKSNjdrCkurPmb000eL/ldikUBQsQMghc4A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l59FYHoiDajOtjo9SHoO5NYGpqmhHlbo5+fT7zaJf+sn+Ci+wy6biikYVYAhPU+NGFuxhUoRD35pWhBt81kQ/+sm5qAvJ3KqJWEhD08mOvb0Dymtl7C/MnR4FXiC49D1z+s1YNYrHQdu5erwyWO7jJYI/wrTivKzXQ2p3yiotqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6JXYwhi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68B2C4CEF1;
	Mon, 27 Oct 2025 13:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761572293;
	bh=zSptyYtFfKSNjdrCkurPmb000eL/ldikUBQsQMghc4A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u6JXYwhiPTtbRbre+25SUFNxnlONKFtnf6ZepA8Sh0l5GOXAbe9Pby0wh59jARz1i
	 98eicKGjUyzQwlMq91etT4h1G0myaFcx/g3zjzaBjEW3S7Msm6cZYHRoeigvdUwVNi
	 0ZXGGBBJeKPUDBxUKuNcTOt8DXnMWCYeNtsZaM61s9V3RaosmVNqiwft/WpBdbqk8F
	 g5GrgqWqGjQnBSZV9siJE18MbElSApk6vDSAlnYauoNywozCUcRVFdhxCM7L8b29VP
	 yLYz15SyRMK1zC3kheJ2em7CuvI2Emi+qHHh3t4fzvlGN8wRj+oJIjqH9G8eFgQl7U
	 ULbvoigDnX/aw==
Date: Mon, 27 Oct 2025 13:38:06 +0000
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
Message-ID: <20251027133806.5e4368bc@jic23-huawei>
In-Reply-To: <aP8tvj_IPbv65m0T@smile.fi.intel.com>
References: <abf45488369cbcce6298cc0ea19c0b3a24-10-25intel.com@sslemail.net>
	<aPs9HdeTZKoqFqdk@smile.fi.intel.com>
	<68fc4591.1.gk94qBPVZajhk94q@inspur.com>
	<aP8tvj_IPbv65m0T@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Oct 2025 10:30:54 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, Oct 25, 2025 at 11:36:45AM +0800, Gary Chu(=E6=A5=9A=E5=85=89=E5=
=BA=86) wrote:
> > >On Fri, Oct 24, 2025 at 03:38:23PM +0800, Chu Guangqing wrote: =20
> > >> The maple tree register cache is based on a much more modern data st=
ructure
> > >> than the rbtree cache and makes optimisation choices which are proba=
bly
> > >> more appropriate for modern systems than those made by the rbtree ca=
che. =20
>=20
> ...
>=20
> > >>   .reg_defaults =3D apds9960_reg_defaults,
> > >>   .num_reg_defaults =3D ARRAY_SIZE(apds9960_reg_defaults), =20
> > >
> > >^^^^ Be careful with such cases, the cache implementations may behave
> > >differently. Have you tested this on the actual HW?
> > > =20
> > We have conducted tests on some hardware, and performance improvements =
were observed,
> >  though tests have not been carried out on all hardware models.
> > Neither rbtree nor maple tree directly depends on hardware types (such =
as CPU or peripheral
> >  models). Instead, they rely on the address distribution characteristic=
s (discrete/continuous)
> >  of hardware registers. The optimal cache type is determined by the har=
dware layout.
> > Red-black trees excel at individual operations on discrete addresses, w=
hile Maple Trees are
> >  proficient in range operations on contiguous addresses. =20
>=20
> It's not about the low-level cache implementation, it's about regmap
> abstraction implementation that might differ from cache to cache
> implementations. This all in regard how the cold cache is getting filled =
up.
> There is a separate discussion (unrelated to the topic of your series) wh=
ere
> this was brought up.

I appreciate these things can be hard to track down with lots of threads in=
 flight
but any chance of a reference for that? I'd be a little surprised if these =
uses
are complicated enough to hit corner cases but would like to know more.
I've taken a few similar changes in the past thinking there would be no
practical difference.

Jonathan



> That's why I asked how this was tested.
>=20
> In any case, up to Jonathan, but I had to rise a potential misbehave, so =
in my
> opinion this kind of corner cases needs to be tested on real HW.
>=20
> > >>   .max_register =3D APDS9960_REG_GFIFO_DIR(RIGHT),
> > >> - .cache_type =3D REGCACHE_RBTREE,
> > >> + .cache_type =3D REGCACHE_MAPLE,
> > >>  }; =20
>=20


