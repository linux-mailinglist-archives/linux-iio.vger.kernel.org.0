Return-Path: <linux-iio+bounces-20819-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2F3AE2A6F
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 19:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9417A18941BD
	for <lists+linux-iio@lfdr.de>; Sat, 21 Jun 2025 17:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D411221D80;
	Sat, 21 Jun 2025 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRe4QcE4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252E0199BC;
	Sat, 21 Jun 2025 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750525658; cv=none; b=dl8Ri9D9NMs1q0sWwukv64FJsHL0OghgDlIv5RylSS9wGyqYL4EVjc7OoaSU7DfIy2LAt+7fVQk8qe/vXdjb/1dEANfwL8s/FANnCUBeq92MY/LbQMRbLvWRDhHphZubj60jI8rp1cDueLOScuz3gzDOfAXWB8GjcAYADkHQ+yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750525658; c=relaxed/simple;
	bh=DbcR1PO1qUZZWnti6SWzrt52wc+r7RAs3ZfcCuAnuSU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lDTPfn6qRzpYBjCB9ndGnbnoEK07ffWiyGmXf/E04gGb4houSUn9kfZC8805qA6iE2mPODkKDavmAr8o2GHraKUOjou+hwh31OOjJQASUJ/naReC5c9qfLTab8y5IrnVy2nK0Y7bO75D7zlZpVia0euZ+bKVBdMrhCogQb6CvmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRe4QcE4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77539C4CEE7;
	Sat, 21 Jun 2025 17:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750525656;
	bh=DbcR1PO1qUZZWnti6SWzrt52wc+r7RAs3ZfcCuAnuSU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QRe4QcE4wV75YvwpTGNkwEldPvAlGjsQZTW2oUMLPvDmQMObsEy3Cr+jfu8BjTzc9
	 xQbW2lqHjHNyQ/gdt1GAJHM7qgczIHBnLZUtgXJgaYe47wvBZfjC8F9rY9fq+IdIAL
	 MGGUUTf6OeB/ix7l2l7yZ7XreQAk0bSfXs/nPiJxwD8rpg7+9ks36xyLvlXMGtaP/X
	 OEoanX9P3BTtyBo7aPhAiTNTYzkq0VDExNM+zfZYOErPplmJXyr0VoVNUFX5vrUm7m
	 /2eioWFWxUWsePSF0TdQAhsIOLY5+NR1TSi1XUAAY1lHjx7tboVBoaWvFd3+5cp6h1
	 jJni8R+c/tvEQ==
Date: Sat, 21 Jun 2025 18:07:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] iio: imu: inv_icm42600: add WoM support
Message-ID: <20250621180730.2b517019@jic23-huawei>
In-Reply-To: <FR3P281MB175789F6AADF5D0D15BC89A1CE70A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20250613-losd-3-inv-icm42600-add-wom-support-v4-0-7e5f554201bf@tdk.com>
	<20250613-losd-3-inv-icm42600-add-wom-support-v4-1-7e5f554201bf@tdk.com>
	<20250614135304.10d0fee9@jic23-huawei>
	<FR3P281MB175789F6AADF5D0D15BC89A1CE70A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 16 Jun 2025 07:42:16 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> >
> >________________________________________
> >From:=C2=A0Jonathan Cameron <jic23@kernel.org>
> >Sent:=C2=A0Saturday, June 14, 2025 14:53
> >To:=C2=A0Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.mane=
yrol.tdk.com@kernel.org>
> >Cc:=C2=A0Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; Lars-P=
eter Clausen <lars@metafoo.de>; David Lechner <dlechner@baylibre.com>; Nuno=
 S=C3=A1 <nuno.sa@analog.com>; Andy Shevchenko <andy@kernel.org>; linux-iio=
@vger.kernel.org <linux-iio@vger.kernel.org>; linux-kernel@vger.kernel.org =
<linux-kernel@vger.kernel.org>
> >Subject:=C2=A0Re: [PATCH v4 1/2] iio: imu: inv_icm42600: add WoM support
> >=C2=A0
> >This Message Is From an External Sender
> >This message came from outside your organization.
> >=C2=A0
> >On Fri, 13 Jun 2025 09:34:26 +0200
> >Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.=
com@kernel.org> wrote:
> > =20
> >> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> >>=20
> >> Add WoM as accel roc rising x|y|z event.
> >>=20
> >> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>=
 =20
> >Hi Jean-Baptiste.
> >
> >A couple of comments inline.
> >Ideally pull the movement of the timestamp struct to before the DMA safe
> >buffers to a precursor patch.   That is a bit subtle to have hiding in h=
ere.
> >
> >The guards thing can be for next time you are doing a cleanup series on =
this
> >driver if you prefer.
> >
> >Jonathan =20
>=20
> Hello Jonathan,
>=20
> concerning the full driver rewrite asked by Andy to switch to uXX/sXX ker=
nel types,
> can I put it inside this series?

Sure.

>=20
> Otherwise, should it be in a separate patch and perhaps with a fixed tag =
so it
> can be backported to enable automatic backport of further fix patches?

It shouldn't be fixes tagged as that won't be a fix as such.
Backport wise we might need to call it out the first time something is based
on it but the stable maintainers are pretty good at spotting these sorts
of broad mechanical changes that enable a later fix so they'll probably just
pick it up when needed.

>=20
> Or can it be after this series is accepted? I would prefer that.

I want the end result with the kernel types, but not that fussed on orderin=
g.
Whilst it may seem churn heavy this stuff is usually reasonably easy to
result when fixes cross such a patch.

I'll catch up with the other thread as I see there is already such a patch
being discussed.
> >>  /**
> >>   *  struct inv_icm42600_state - driver state variables
> >>   *  @lock:		lock for serializing multiple registers access.
> >> @@ -148,9 +156,10 @@ struct inv_icm42600_suspended {
> >>   *  @suspended:		suspended sensors configuration.
> >>   *  @indio_gyro:	gyroscope IIO device.
> >>   *  @indio_accel:	accelerometer IIO device.
> >> - *  @buffer:		data transfer buffer aligned for DMA.
> >> - *  @fifo:		FIFO management structure.
> >>   *  @timestamp:		interrupt timestamps.
> >> + *  @apex:		APEX (Advanced Pedometer and Event detection) management
> >> + *  @fifo:		FIFO management structure.
> >> + *  @buffer:		data transfer buffer aligned for DMA.
> >>   */
> >>  struct inv_icm42600_state {
> >>  	struct mutex lock;
> >> @@ -164,12 +173,13 @@ struct inv_icm42600_state {
> >>  	struct inv_icm42600_suspended suspended;
> >>  	struct iio_dev *indio_gyro;
> >>  	struct iio_dev *indio_accel;
> >> -	uint8_t buffer[2] __aligned(IIO_DMA_MINALIGN);
> >> -	struct inv_icm42600_fifo fifo;
> >>  	struct {
> >>  		int64_t gyro;
> >>  		int64_t accel;
> >>  	} timestamp; =20
> >This was a bit subtle and had me going for a minute.
> >The timestamp should never have been at this location in the structure b=
ecause
> >it's mid way through various regions with forced alignment.  It isn't ac=
tually a bug
> >I think though (beyond unnecessary padding) because the fifo struct obey=
ed c spec rule
> >that anything after it must be aligned to it's largest aligned element w=
hich was
> >IIO_DMA_MINALIGN.
> >
> >Maybe move this in a precursor patch where you can talk about whether it=
 was a problem
> >or not? =20
>=20
> I can move it in a separate patch at the beginning of the series. This fi=
x was asked
> by you to avoid potential hard bugs, but it dates sorry.

yeah. I was wrong I think but definitely subtle kind of code that we don't =
want
if we can avoid it.  A precursor tidying it up with the reasoning would be =
good
from a reviewability point of view.

Jonathan

