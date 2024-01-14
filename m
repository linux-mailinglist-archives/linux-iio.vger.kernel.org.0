Return-Path: <linux-iio+bounces-1666-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0447A82D1BD
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jan 2024 18:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A3121F21548
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jan 2024 17:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FDFE56B;
	Sun, 14 Jan 2024 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wsv/i4Zh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF59D313
	for <linux-iio@vger.kernel.org>; Sun, 14 Jan 2024 17:39:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCF0C433C7;
	Sun, 14 Jan 2024 17:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705253960;
	bh=1c/tm1DwuhgIdoNFSOKa6wZ5Fe4R3GV1YEBiKhnrv8g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wsv/i4ZhImz7WAuHFtVgvGnlIe5tU4gvxzUvA6OgSBEF1jZDU0Hj83Z4jBznbE6az
	 LdeIXdLVeY5dZJRslfB5vkXLuVsRH1m7zyy+Ll+8R8JgW8bagTopsuIA7+RmpUe94b
	 HTwIhBso0+gvxZjHVo9wtvDmXPA/+/HOf+LOKaDVpnluvefPg9YFmo7Oz/pbXoBG76
	 v4VY9iPlVCTkJxm3WzJXI3KVxvEjlv+A1RuDONQ+Dtso9lzp+XsHdyQ6CNiYG3Amxq
	 MMYrk2LH2KdsDb59EWRF1eb/Ryc/5FjagdUkGXjLE6dZ2gjZXuimDtZydpocn2AjbM
	 MAROCbcthbScw==
Date: Sun, 14 Jan 2024 17:39:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RFC PATCH V2 00/10] IIO: Use the new cleanup.h magic
Message-ID: <20240114173909.1b8defec@jic23-huawei>
In-Reply-To: <20240114173336.360443cb@jic23-huawei>
References: <20231217173548.112701-1-jic23@kernel.org>
	<CAMknhBF1fyop-s38psUmKc8KVZ30psEtica3g2tZPczYN70=DA@mail.gmail.com>
	<20240114173336.360443cb@jic23-huawei>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 14 Jan 2024 17:33:36 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun, 17 Dec 2023 19:10:48 -0600
> David Lechner <dlechner@baylibre.com> wrote:
>=20
> > On Sun, Dec 17, 2023 at 11:36=E2=80=AFAM Jonathan Cameron <jic23@kernel=
.org> wrote: =20
> > >
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > A lot of the advantages of the automated cleanup added for locks and =
similar
> > > are not that useful in IIO unless we also deal with the
> > > iio_device_claim_direct_mode() / iio_device_release_direct_mode()
> > > calls that prevent IIO device drivers from transitioning into buffered
> > > mode whilst calls are in flight + prevent sysfs reads and writes from
> > > interfering with buffered capture if it is enabled.
> > >
> > > Relies on Peter Zilstra's conditional cleanup handling which is queued
> > > up for the merge window in the tip tree. This series is based on
> > > a merge of tip/master into iio/togreg.
> > >
> > > All comments welcome. If this looks positive I'll make use of it in a
> > > lot more drivers, but hopefully these give an idea of how it will wor=
k.
> > >
> > > The need to always handle what happens after
> > > iio_device_claim_direct_scoped() {} is a little irritating but the
> > > compiler will warn if you don't do it and it's not obvious how to
> > > let the compiler know the magic loop (hidden in the cleanup.h macros)
> > > always runs once.  Example:
> > >
> > >         iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
> > >                 return 42;
> > >         }
> > >         /* Can't actually get here, but compiler moans if no return v=
al */
> > >         return -EINVAL;   =20
> >=20
> > Maybe better would be?
> >=20
> >         unreachable(); =20
>=20
> Interesting thought, but there is very little precedence for using that i=
n the kernel.
> + I think it's a C23 feature so we'd be relying on whether gcc and clang =
happened
> to implement it rather than being sure it was available.

Ah. I'd missed the default implementation in compiler.h.
So let us fall back on the first argument of limited precedence.

J

>=20
> Jonathan
>=20
>=20
> >  =20
> > > }   =20
>=20


