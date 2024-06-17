Return-Path: <linux-iio+bounces-6425-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D45C790BBBE
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 22:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82F79281DA9
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 20:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE9818FC90;
	Mon, 17 Jun 2024 20:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ortWfGPH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227461684BB;
	Mon, 17 Jun 2024 20:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718654952; cv=none; b=eMHasDFGibbKLn8Sv2A49P5UD9BcUntSHphfNWgA0/bSJ3tiGLJeG1Eevx8GzGHRuUcNTn8cSjcVrZR+YGA4gfQlE1woCqeg3imjVPjYJaD4aTjgMapcVGR75A5uE8NQVRAuWeNCPA5JDKtROCpYc7/9Lrn/XFRWnRfHHkbx3hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718654952; c=relaxed/simple;
	bh=PaIwXTtMekaj3Gv+ZkdLhymam1BV2Xw0/GRJanlgKQU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqEIZBWdv+7cYrBX2/grVs3Od+63urzisxIW3PmrVBC4LXEUju/+hmEdwXwh/TViPArUhJWLWungv3YyGM6SGDO/GMjc3e1npCXqiun6OHYkIkXoaO5pXRHsOErvwhRdNFNeQjKKmDQsT7U1hAKbJKg/U/hzuakOXBarW5ydUxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ortWfGPH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC7EC2BD10;
	Mon, 17 Jun 2024 20:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718654951;
	bh=PaIwXTtMekaj3Gv+ZkdLhymam1BV2Xw0/GRJanlgKQU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ortWfGPHbxUnGF2mNIPw2IEH/7vZZRHLMG9rqSdAET4FvWmlzqE28Jr5CSeTmVzvi
	 iuZVxQEjfbZmMxhJvnno2a2SOr89l7i5GYgH7OWxqDpuUrgiOejO1ZpYOSFwLu469y
	 C3U1eoZAbtsuf7jRLVCFMsIbIdu/Mc03Q1pY7Di28qVJQpGHPe8oY9xm9POPkdKojy
	 1aLlURVTAVt+hbH//S1LvTLHUb5xR4o6hl2cq63HXy1FE6PbYYT7EZ8eKNFedJBKrv
	 V85fT5FYZe4vbF+Rs7qYSwxAnRbdcpcgArXVE21rjyRcIaLk2r7Gkkch2g+09n9G1o
	 rOvgcZl8gt8Rg==
Date: Mon, 17 Jun 2024 21:09:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <jpaulo.silvagoncalves@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>,
 =?UTF-8?B?Sm/Do28=?= Paulo =?UTF-8?B?R29uw6dhbHZlcw==?=
 <joao.goncalves@toradex.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matti Vaittinen <mazziesaccount@gmail.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: trigger: Fix condition for own trigger
Message-ID: <20240617210904.73774b39@jic23-huawei>
In-Reply-To: <Zm6yrnDwSye85Hl1@livingston.pivistrello.it>
References: <20240614143658.3531097-1-jpaulo.silvagoncalves@gmail.com>
	<20240615115018.2b73d6b3@jic23-huawei>
	<Zm6yrnDwSye85Hl1@livingston.pivistrello.it>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 16 Jun 2024 11:38:54 +0200
Francesco Dolcini <francesco@dolcini.it> wrote:

> On Sat, Jun 15, 2024 at 11:50:18AM +0100, Jonathan Cameron wrote:
> > On Fri, 14 Jun 2024 11:36:58 -0300
> > Jo=C3=A3o Paulo Gon=C3=A7alves <jpaulo.silvagoncalves@gmail.com> wrote:
> >  =20
> > > From: Jo=C3=A3o Paulo Gon=C3=A7alves <joao.goncalves@toradex.com>
> > >=20
> > > The condition for checking if triggers belong to the same IIO device =
to
> > > set attached_own_device is currently inverted, causing
> > > iio_trigger_using_own() to return an incorrect value. Fix it by testi=
ng
> > > for the correct return value of iio_validate_own_trigger().
> > >=20
> > > Cc: stable@vger.kernel.org
> > > Fixes: 517985ebc531 ("iio: trigger: Add simple trigger_validation hel=
per")
> > > Signed-off-by: Jo=C3=A3o Paulo Gon=C3=A7alves <joao.goncalves@toradex=
.com> =20
>=20
> Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
>=20
> >=20
> > Ouch.  Can you give an example of resulting user visible result? That
> > will help people decide whether to pick this up for their distro kernels
> > etc.  In some cases, looks like we'll get garbage timestamps and in oth=
ers
> > may get stale data (or garbage). =20
>=20
> This was noticed while me and Joao were working on the ads1119 driver you
> have been recently reviewing. We wanted to use iio_trigger_using_own()
> and it was not behaving the right way. We looked into it and found the bu=
g.
>=20
> Given that I do not know the exact impact on the drivers that are using t=
his
> function.
>=20
> > Odd no one has noticed this in the past whilst testing those dependent
> > features in particular drivers and I worry a little that we may have bu=
gs
> > in the users as a result of iio_trigger_using_own() reporting the inver=
se
> > of the intended. I've take a quick look at the users and 'think' they a=
re
> > ok, but would definitely like a few others to confirm. =20
>=20
> All the users of iio_trigger_using_own() are older than the commit that
> introduced the bug, it is safe to assume that they need the fix and
> are expecting the function to behave the same way is documented and it was
> before the bug was introduced.
>=20
> The broken commit is not that old and less than 10 IIO drivers are using =
this
> function. Given that I think that is not that odd that it took 1 year to =
find
> the bug.

Yes. Long tail of IIO devices that are used on the sort of board that only
gets a kernel update once in a while and well behind mainline.  So indeed
not that surprising :(=20

Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

>=20
> Francesco
>=20


