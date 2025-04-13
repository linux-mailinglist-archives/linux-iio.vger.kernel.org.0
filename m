Return-Path: <linux-iio+bounces-18042-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DFBA8717C
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 12:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0757460478
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 10:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA44219C578;
	Sun, 13 Apr 2025 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOKLHQG7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9C614F9F9
	for <linux-iio@vger.kernel.org>; Sun, 13 Apr 2025 10:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744538742; cv=none; b=lWTAUktqDPiOTrIxj0qElv1b0FGj7wEhJSyWkVVzbyx0w7HKRUgQNO/cVt3+LEIN9HszlSiWors3CcZa5OfMo9P/u2K3UYI8fIOu1fpTcfIjYWDE1jotvqTJXYZ7xlK+DM+yBL5I2nl6AjRYYYcFwNoGdzENNkP7sByjZgOogXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744538742; c=relaxed/simple;
	bh=O1no7lCaHNxrO0UCLH+dps7aA9dW53Sh3K4IFV+cMUA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W70pixiH2ML/4Msb77NjXzSuGTBVk++borug+G457HD3ehkU8BJyHF6/i2KId7CQWeelnCmBSNEkx6d4I7tUgOkNAjic65iQF1tZmdv6gcWOdMouRonTzIp0fG6exwBg40SGS60sCsJvVXzDqywn62rYToqo5LodU6n70JY9J7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOKLHQG7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8114BC4CEDD;
	Sun, 13 Apr 2025 10:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744538742;
	bh=O1no7lCaHNxrO0UCLH+dps7aA9dW53Sh3K4IFV+cMUA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XOKLHQG7QQWmlARgzpuPZDdbCUUxtUU0uSzuOO3hqNm1FcQgpnrfdnFx9YBiD5MKY
	 t1kyzuOZMQgMGsNlcf+yrodoDlArKYCO/mCgdaTkq8ip4Nrhqr6ov8P0wa350B4ljC
	 rHz+1nwTW1pTW09hGJyQVW2ZR/MiFXrPbvn9RAmJOI2qVJ4M3ScW6h1XE9rIuLm6JR
	 J18AxUDmQ+htkec5gQvP5nbNPw3PUCTa4CM9ywTA1Ff+/xSlk/UMKAu+RcpiHYu0dN
	 j7UyBXk3pLvcVZ/HICZE7VykRbptoefzsYtCd5jjCdDOkzHnkmCgmW2qafyxGMV2hS
	 nTdHnSOQeI+2A==
Date: Sun, 13 Apr 2025 11:05:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= 
 <nuno.sa@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 06/20] iio: dummy: Use a fixed structure to build up
 scan to push to buffers.
Message-ID: <20250413110535.67c2ed35@jic23-huawei>
In-Reply-To: <29002c58344f88eaba95426a0e4bc45d3d70406b.camel@gmail.com>
References: <20250406172001.2167607-1-jic23@kernel.org>
	<20250406172001.2167607-7-jic23@kernel.org>
	<Z_OZgoORPl_6J01m@smile.fi.intel.com>
	<29002c58344f88eaba95426a0e4bc45d3d70406b.camel@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 07 Apr 2025 17:34:24 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2025-04-07 at 12:23 +0300, Andy Shevchenko wrote:
> > On Sun, Apr 06, 2025 at 06:19:47PM +0100, Jonathan Cameron wrote: =20
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >=20
> > > It has long been discouraged for drivers to make use of iio_dev->scan=
_bytes
> > > directly as that is an implementation detail of the core. As such our
> > > example driver should definitely not be doing so.
> > >=20
> > > A simple anonymous structure definition suffices here as even though
> > > we have a mixture of signed and unsigned channels only the signed ones
> > > use the full storage so the unsigned channels can used signed types as
> > > well. =20
> >=20
> > ...
> >  =20
> > > ---
> > > v2: Add a comment about stack buffers not being DMA safe. =20
> >  =20
> > > -	data =3D kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
> > > -	if (!data)
> > > -		goto done;
> > > +	/*
> > > +	 * Note that some buses such as SPI require DMA safe buffers which
> > > +	 * cannot be on the stack.
> > > +	 */
> > > +	struct {
> > > +		s16 data[ARRAY_SIZE(fakedata)];
> > > +		aligned_s64 timestamp;
> > > +	} scan; =20
> >=20
> > But why not continue using kmemdup() / kzalloc() for this and put
> > ithe comment there, which would make more sense? Then the device
> > driver developer will choose either to use the on-stack or heap one?
> >=20
> > Or didn't I get the idea behind all this? =20
>=20
> I think Jonathan means that if you need to do any SPI/I2c transfer as par=
t of
> your trigger handler, then do not use stack allocated variables. Since in=
 this
> example we have anything like that, things were simplified to use stack
> variables with a comment on top of it.

That was my thinking at the time.
However, I'm with Andy on this.  Why not illustrate the more complex case
and amend the comment to say that in other cases on the stack may be fine?

>=20
> - Nuno S=C3=A1


