Return-Path: <linux-iio+bounces-19948-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF01AC435A
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 19:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD5DE7AAE6A
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 17:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB7323F26B;
	Mon, 26 May 2025 17:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CORWmKat"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D93C20C038;
	Mon, 26 May 2025 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748279718; cv=none; b=mclyKn9rmwRtA6QJ1nrNRBwOLCe21aPStQLF5q+KnIvXXixe0otQDCFyWpsMzkyqbHfNCRUoRllch8Uhzl3gzWjb61N4rCukra0ad3wE8nijU66GXwiu4AVz8srLq4uB9DD8kKvKc8FnCTEMqrzOcFQIvsny9iHiRFIi4IKeAMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748279718; c=relaxed/simple;
	bh=pfsFF7BpAY3n3Qf9e396Rf5DRmX/signbkQkMULVops=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LG4IVnhK8i/jWSxjbUwhOkUsPOITHpVKw5gFmPJ9SdUKLwH90dS8QMncJYa12obGxpVhmZXiYh9Y9UKtHq1VBO1u3DdKc5c8fCqzDamb2r4ApgdHZF0Abrq78iXZbLBK6llZsT3ZEv1TyS8LcC56nDC0tyyDPwHc+r+i3TVYpjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CORWmKat; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18903C4CEE7;
	Mon, 26 May 2025 17:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748279715;
	bh=pfsFF7BpAY3n3Qf9e396Rf5DRmX/signbkQkMULVops=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CORWmKatw7aPIYw/4Gk67yAhIcZsgOT55fVqR4ihMEKucmXVD+vDjgLZTq+53rg0P
	 Sx9Q8vwNgUUQSV5s8+GRDu3AEpvpFHTDrpSt4A5cHWY66zU5NUst80WSZqC0AjEmXp
	 t38jpnG+urKbV88ZO56dc5faJ2Jydei+w+IHcJRKEacSWcBO4GNase7y6L8fTUl4jf
	 qKj48ituQnUCK4jUTA+Eu7r8F3l5uMiZ3iK1jcNSrefAyFtK6w+O7l2TTjtlUcxv3E
	 N+WDzTUU3l5zgZTLYk1LpTziFC+o9t2INP1cqEM/NcA5iCgNW+5/7uk7SdLR4imASW
	 EFKoJ07llistQ==
Date: Mon, 26 May 2025 18:15:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gyeyoung Baek <gye976@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/9] iio: buffer: Fix checkpatch.pl warning
Message-ID: <20250526181508.6203c21a@jic23-huawei>
In-Reply-To: <CAKbEznvdKJx_t2OcYfAJuAP8FVpTjup63Ct6aFvSYuK=-B061A@mail.gmail.com>
References: <20250519-timestamp-v1-0-fcb4f6c2721c@gmail.com>
	<20250519-timestamp-v1-1-fcb4f6c2721c@gmail.com>
	<20250525183528.14877bd2@jic23-huawei>
	<CAKbEznvdKJx_t2OcYfAJuAP8FVpTjup63Ct6aFvSYuK=-B061A@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 26 May 2025 14:30:41 +0900
Gyeyoung Baek <gye976@gmail.com> wrote:

> On Mon, May 26, 2025 at 2:35=E2=80=AFAM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Mon, 19 May 2025 23:25:53 +0900
> > Gyeyoung Baek <gye976@gmail.com> wrote:
> > =20
> > > Remove the following trivial warning:
> > > "WARNING: Block comments should align the * on each line"
> > >
> > > Signed-off-by: Gyeyoung Baek <gye976@gmail.com> =20
> > Applied.
> >
> > As a general rule don't send unrelated cleanup in an RFC series
> > doing something interesting!  They might get missed. =20
>=20
> Well, since the patches modify the same file, I considered them
> dependent and grouped them into a single series. But now realize it
> would be more appropriate to split patches logically.
> Thanks for pointing it out.
If there was a chance of a merge conflict I'd agree with you
but I'd be very surprised to see one with this change given where
it is in the file.

No problem though, the only result of too much grouping is
things might not go in as quickly!

Jonathan

>=20
> Gyeyoung
>=20
> > Jonathan =20
> > > ---
> > >  drivers/iio/buffer/industrialio-triggered-buffer.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/dri=
vers/iio/buffer/industrialio-triggered-buffer.c
> > > index c06515987e7a..9bf75dee7ff8 100644
> > > --- a/drivers/iio/buffer/industrialio-triggered-buffer.c
> > > +++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
> > > @@ -1,5 +1,5 @@
> > >  // SPDX-License-Identifier: GPL-2.0-only
> > > - /*
> > > +/*
> > >   * Copyright (c) 2012 Analog Devices, Inc.
> > >   *  Author: Lars-Peter Clausen <lars@metafoo.de>
> > >   */
> > > =20
> > =20
>=20


