Return-Path: <linux-iio+bounces-4221-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0658A3C14
	for <lists+linux-iio@lfdr.de>; Sat, 13 Apr 2024 11:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0EF1C20F9F
	for <lists+linux-iio@lfdr.de>; Sat, 13 Apr 2024 09:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D026321B4;
	Sat, 13 Apr 2024 09:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHyawyMA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D6B944F
	for <linux-iio@vger.kernel.org>; Sat, 13 Apr 2024 09:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713002256; cv=none; b=GhPREYr9ZS2DsHyKi/XqoOUm3/liiXm36eI5Al6O1DMnOuK6snd3eSMQt73JiuCHe81Dj6nZift3BjacQcjD/jwn7hViguvNjoOT3yvChhCPGxdZwGR2GYRmKwSO/RBnfveOXS9gH/C0zj9CV8esTqw2QSbuTDcOn+8NSfYHYEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713002256; c=relaxed/simple;
	bh=5TCpA8ew81UhM0lxVxEChQUgzY9NGfa2bIgPxQqMia8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTqPBJnBGwiAYaGiDUJW1FLGPm7H1tNTl8CmvgKFT+mN79AKWusmX4+xkA98kIlZAy48VnnsxDi2CSfnC/0hYeDwFZSAkhxaIF6l6RbAehDgoYG3S26ur8h2xJtpX0RlibK1c8IAGpw9K3++OdqwQgfi3kVBkdox+UJ6si9rxKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHyawyMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22556C4AF11;
	Sat, 13 Apr 2024 09:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713002256;
	bh=5TCpA8ew81UhM0lxVxEChQUgzY9NGfa2bIgPxQqMia8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vHyawyMAbydITsZH3vE+1OG7VtbrMtURT8hc4QEyeWYXRMqt+FPAGr6UVB6NK/U7e
	 8jOJxfVr/X4CM22PBy24sRH4Nmb7M22pgD+oPY97A9OamAzKnyULqGiepZRzKrtt1j
	 TyMPav84rtghsq1di9jT79e9WQcnajOQNaipzyQOltFd0exXtF8GTbkeZ6MmcMKeZQ
	 wpgQn5s6JSFuKowBggYNc7tdvIDC6jHKcRQpKtgLLVO8IK7Y1b4yBAC7yJlgCtpotL
	 9X4VJitYiXIMkjT4W6/Fgpoa9X0QFPQXHBSenOI64YW6+lOiFBqQiMwieXMuGDLx25
	 nqkwABsBKb+zA==
Date: Sat, 13 Apr 2024 10:57:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, Marius Cristea <marius.cristea@microchip.com>,
 Mihail Chindris <mihail.chindris@analog.com>, Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>, Kim Seer Paller <kimseer.paller@analog.com>,
 Dumitru Ceclan <mitrutzceclan@gmail.com>, Cosmin Tanislav
 <demonsingur@gmail.com>, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH 1/8] iio: adc: ab8500-gpadc: Allow COMPILE_TEST builds
Message-ID: <20240413105722.74490765@jic23-huawei>
In-Reply-To: <CACRpkdbJ372YEuGOQOFNA9r_Xnbh4SdUvRiX-ExF1mxhP9tAkw@mail.gmail.com>
References: <20240330190849.1321065-1-jic23@kernel.org>
	<20240330190849.1321065-2-jic23@kernel.org>
	<CACRpkdZzOi5vv6yxqheqGZAZYBLTEL-uB=dt-i6ByDEhF6H0Kw@mail.gmail.com>
	<20240405113622.00000896@Huawei.com>
	<20240406112744.64f53089@jic23-huawei>
	<CACRpkdbJ372YEuGOQOFNA9r_Xnbh4SdUvRiX-ExF1mxhP9tAkw@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Apr 2024 11:16:17 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Sat, Apr 6, 2024 at 12:27=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> > On Fri, 5 Apr 2024 11:36:22 +0100
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > =20
> > > On Thu, 4 Apr 2024 13:36:15 +0200
> > > Linus Walleij <linus.walleij@linaro.org> wrote:
> > > =20
> > > > On Sat, Mar 30, 2024 at 8:09=E2=80=AFPM Jonathan Cameron <jic23@ker=
nel.org> wrote:
> > > > =20
> > > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > >
> > > > > The dependencies on various ab8500 components prevent this driver
> > > > > being useful but they don't seem to prevent it being built.
> > > > > Improve build coverage by allowing COMPILE_TEST.
> > > > >
> > > > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> =20
> > > >
> > > > ...but I think AB8500_CORE is a hard requirement because
> > > > <linux/mfd/abx500.h> does not provide register accessor stubs?
> > > > =20
> > > hmm. I clearly didn't test enough.  Ah well, I'll drop this one. =20
> > > > Yours,
> > > > Linus Walleij =20
> >
> > Tested again, nope, AB8500_CORE isn't needed as far as I can tell. =20
>=20
> Oh? Weird.

>=20
> > What register accessor stubs were you referring to? There are some call=
s for debug dumps
> > in that header, but those aren't used by the ADC driver. =20
>=20
> <linux/mfd/abx500.h> has for example:
> (...)
> int abx500_get_register_interruptible(struct device *dev, u8 bank, u8 reg,
>         u8 *value);
> (...)
>=20
> and the ADC driver has:
>=20
>         /* Check if ADC is not busy, lock and proceed */
>         do {
>                 ret =3D abx500_get_register_interruptible(gpadc->dev,
>                         AB8500_GPADC, AB8500_GPADC_STAT_REG, &val);
>=20
>=20
> $ git grep abx500_get_register_interruptible include/linux/
> include/linux/mfd/abx500.h:int
> abx500_get_register_interruptible(struct device *dev, u8 bank, u8 reg,
>=20
> No stubs! I think there is just some other Kconfig stuff bringing the
> AB8500 MFD core into
> the build at any attempt.

ah got it.  AB8500_CORE isn't needed, but ABX500_CORE is and that's indirec=
tly
depended on by AB8500_CORE.  How about I change the dependency to
depends on ABX500_CORE && (AB8500_REGULATOR || COMPILE_TEST) instead?

As ABX500_CORE doesn't have a horrible indirect arch dependency that
AB8500_CORE does via db8500-prcmu.  I can build it on x86 but obviously
would want to hit this with a lot more build tests.

DB8500_PRCMU has some stubs but not a complete enough set to allow
AB5800_CORE to build.  Could fix that but it's a bigger change than
relaxing requirements of the ADC driver to the ones needed for building.

Jonathan


>=20
> Yours,
> Linus Walleij


