Return-Path: <linux-iio+bounces-20820-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E04CAAE2A75
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 19:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27826188F882
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 17:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAF321FF21;
	Sat, 21 Jun 2025 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtcxbVY5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C1039FCE;
	Sat, 21 Jun 2025 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750526028; cv=none; b=t4ZmHU8xLxg6jH0QWlNX6suLksPf5GkJm+IXlfgom+fBYb2q/u+TSZJI4LCW3V4j0b+CoE7jwWi8LQ4zIpxlvvD4tBLS0eQtCiH9XNh4FW2hE6JzfucM14AhtSlDTzaZpUuzt3K7NFkJdUnsyoHdhbJ70H1pbdyPPuovWCE0ROI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750526028; c=relaxed/simple;
	bh=lvT6pah/8tMihrRud+kdGk+RX76wGL1s+4E/f+JJp6E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fxk1Qj7mayAIKOe08PHFWlE1gYi621MmgLiRfYHdj50ZiaI0MKjbqNX5ZZrVmLY6appEpb7CGPE/pYvD7TJ5mZ0Ey+eQbt4G0XWWGyAGwBoGQ6+TXBp0jN9bZ7I2NNDcUN0zbrQbW6ffJ5IAQx5x1+QHJvEgEUcBammMqxHypwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtcxbVY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6D9C4CEE7;
	Sat, 21 Jun 2025 17:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750526027;
	bh=lvT6pah/8tMihrRud+kdGk+RX76wGL1s+4E/f+JJp6E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WtcxbVY5LhnLEb5uns95DL0tpvX9bVYV6oBS0yYClNpvNO/dDWJOPcw5o2B9rwL9+
	 1AyrW/MR1AA2I1F1rCyHzMbWC2DwzTuRbJpUvWyDX88g401CuYw8tmwKwiRM1BHnaT
	 yHi62bv+n8MeIh0sa/l7SdMMe+iGBo2yBRKqRsjGGDDnfG6UCiITA7oCwMYTSnP6Mu
	 CTX/mBecaW/0NAznXkvxi/4sphYT1/16H7iiB/4lsnpP26TsGzmR1yEmO/to5en4t/
	 Xg0zS8mN2cANreRfAoyJVtNChyIMM0y/0srq67TFOHiES5zKMVaXFD2gtioWqhSANS
	 lZUD/O2OY/coQ==
Date: Sat, 21 Jun 2025 18:13:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: imu: inv_icm42600: Convert to uXX and sXX
 integer types
Message-ID: <20250621181339.0331ab8b@jic23-huawei>
In-Reply-To: <CAHp75Ve0aQLaRS1-J5WoCxUAfX+Y=s2oj4ZkVvUG1XysXopZxw@mail.gmail.com>
References: <20250616090423.575736-1-andriy.shevchenko@linux.intel.com>
	<FR3P281MB1757C6A610D39EA737A19EFBCE70A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
	<CAHp75Ve68H448v3Tgv930yoMYCCKVC3kefuP+Rermj7SaiP41g@mail.gmail.com>
	<FR3P281MB175775DBE90C5469637F3C66CE73A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
	<CAHp75Ve0aQLaRS1-J5WoCxUAfX+Y=s2oj4ZkVvUG1XysXopZxw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Jun 2025 21:33:46 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Jun 17, 2025 at 5:43=E2=80=AFPM Jean-Baptiste Maneyrol
> <Jean-Baptiste.Maneyrol@tdk.com> wrote:
> > >From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > >Sent: Monday, June 16, 2025 16:33
> > >On Mon, Jun 16, 2025 at 5:16=E2=80=AFPM Jean-Baptiste Maneyrol
> > ><Jean-Baptiste.Maneyrol@tdk.com> wrote:
> > > =20
> > >> thanks a lot for having done all the work. =20
> > >
> > >Please, avoid top-posting!
> > > =20
> > >> Do you think it is possible to add a fixes tag so it can be backport=
ed to ease automatic backport of further patches?
> > >> Otherwise for sure all further fixes will have to be backported manu=
ally. =20
> > >
> > >The idea behind the series that it may depend on some kind of
> > >cleanups. In such a case (according to Greg KH) no need to have Fixes
> > >tag on a cleanup, because it's confusing. On the contrary the
> > >infrastructure for stable kernels will catch this up. You need to
> > >follow the Documentation on how to submit for stable (basically the
> > >main hint is to use stable@ in the Cc line _inside_ the commit
> > >message, as a tag).
> > > =20
> > >> The driver code is full of intXX_t and uintXX_t types which is
> > >> not the pattern we use in the IIO subsystem. Switch the driver
> > >> to use kernel internal types for that. No functional changes. =20
>=20
> > >> As noted before the pattern is used in less than 10% files in IIO,
> > >> So it's safe to assume that IIO prefers uXX/sXX types over C99 ones.=
 =20
> > > =20
> >
> > it is good for me if we can add Cc to stable.
> > I don't know if I need to add the Cc tag here or when a fixed patch will
> > require the rework. In doubt, here it is.
> >
> > Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> > Cc: stable@vger.kernel.org =20
>=20
> It makes no sense here. This is a standalone change. It's not part of
> any "fixes" series. You need to attach this patch to your series as
> patch 1 and mark Cc stable all of the patches.
>=20

I think this is hypothetical at the moment as the only series outstanding
is the WOM one which isn't a fix.  So I don't think this patch will
ever end up carrying a stable tag.  However, first time we get a fix
that needs it, if Greg etc don't sort it out anyway (they often do!)
then a simple mail to stable@vger.kernel.org to tell them to pick this
and the fix will resolve it.

For now I'll queue this patch up and ask for a rebase on the WOM
series on top of it.

It crossed with David's series doing {} to replace explicit memsets
so needed a tiny bit of hand tweaking.
Pushed out as testing for 0-day to look at.

Thanks,

Jonathan



