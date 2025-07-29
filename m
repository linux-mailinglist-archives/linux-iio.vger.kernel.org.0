Return-Path: <linux-iio+bounces-22133-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DADDB152DC
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 20:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F1C3189070F
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jul 2025 18:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBDC23A9AE;
	Tue, 29 Jul 2025 18:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iw6z2d5o"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788BD220F20;
	Tue, 29 Jul 2025 18:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753814035; cv=none; b=hpN+XigVon+YmH4CSb0H5xJ97BMA74LIxNFbRRbRCbd0qUeuJNpOFmvA568X6YGXYdVuRLZSOEgTCyP5vX+Ac6a9YOnwim6jz1bby2q5fI8dWdypTXIv29WPfEluvhh5pkpnTF0+ZM6TzqywhIhdrVm0L0fJHFyP6NUiE2IWlQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753814035; c=relaxed/simple;
	bh=FfmG+/ox5q3uqtSfboKBXxhfHoGl1QfrJVQn9mXO/I4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HY9PdbW694C9Ad2r7CuZlBTc+DMJ3VV9F7egE/youBJclOouhG0GDRglflmQuuNDv31NOuSV/Nue2OMQDiEoB5WjKBKz53jK8aNb6qfaW0JuKJZzIziG8ERsB2N8u0YUeTxriDaJabCVfNN464HrcjZURyEAyuuisiNXERCbUq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iw6z2d5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30FA8C4CEEF;
	Tue, 29 Jul 2025 18:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753814034;
	bh=FfmG+/ox5q3uqtSfboKBXxhfHoGl1QfrJVQn9mXO/I4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iw6z2d5oU6rdL5tcs/PfBXXX9FT4iaGpl4YKixnbC0sjs82rMM6FMS2771h1yudf4
	 HTy5DkTTULqGxSyHOiVCQ73j+P2Cc0QeBKaisYZYLTzMG33EsnSmNzWokN/F7ocO66
	 jTbQV84lSw6uIwLLqLwywyH/Qo+2PHuUBPQIh2l24BxX+klhwETvJW82LqTICW6CFC
	 BquhsNtTiOQvZsoCDdZs8mkd37JMHXAkWNJWk023nnddNqqoEHLYWHVYC/79D5LHua
	 +f8/cvE05YQIeVFOjECio9BBOsLwiuLApmKDj35OTvrlYkBz2dGjil5hFUphQk82J/
	 48WwhRpweWDkg==
Date: Tue, 29 Jul 2025 19:33:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Jean Delvare
 <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org, Andy Shevchenko
 <andy@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 3/7] iio: Add in-kernel API for events
Message-ID: <20250729193346.39791223@jic23-huawei>
In-Reply-To: <0ccf7735-6a2c-473a-ab67-ae0c5ff9a335@linux.dev>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
	<20250715012023.2050178-4-sean.anderson@linux.dev>
	<d8e5c8fbeaee42e9e0708460c47bd68053cd8710.camel@gmail.com>
	<9b187e7f-a116-4aea-a9a6-b9222562868d@linux.dev>
	<20250727172126.35d0a477@jic23-huawei>
	<0ccf7735-6a2c-473a-ab67-ae0c5ff9a335@linux.dev>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 28 Jul 2025 18:44:30 -0400
Sean Anderson <sean.anderson@linux.dev> wrote:

> On 7/27/25 12:21, Jonathan Cameron wrote:
> > On Tue, 15 Jul 2025 12:52:19 -0400
> > Sean Anderson <sean.anderson@linux.dev> wrote:
> >  =20
> >> On 7/15/25 07:09, Nuno S=C3=A1 wrote: =20
> >> > On Mon, 2025-07-14 at 21:20 -0400, Sean Anderson wrote:   =20
> >> >> Add an API to notify consumers about events. Events still need to be
> >> >> enabled using the iio_read_event/iio_write_event functions. Of cour=
se,
> >> >> userspace can also manipulate the enabled events. I don't think thi=
s is
> >> >> too much of an issue, since userspace can also manipulate the event
> >> >> thresholds. But enabling events may cause existing programs to be
> >> >> surprised when they get something unexpected. Maybe we should set t=
he
> >> >> interface as busy when there are any in-kernel listeners?
> >> >>    =20
> >> >=20
> >> > Sensible question. I'm not that familiar with events but I suspect i=
s not
> >> > trivial (if doable) to do a similar approach as with buffers? With b=
uffers, an
> >> > inkernal consumer get's it's own buffer object (that goes into a lis=
t of active
> >> > buffers in the iio device) with all channels enabled and then we dem=
ux the
> >> > appropriate channels for each consumer.   =20
> >>=20
> >> For in-kernel consumers I think it's reasonable to expect them to hand=
le
> >> events they didn't explicitly enable. I'm not sure about userspace
> >> consumers. =20
> >=20
> > This already happens because we don't have a demux equivalent (what we =
do
> > for buffered data flow) so if a device only has a single enable bit tha=
t covers
> > multiple events (annoyingly common for accelerometers for example) then
> > userspace will get events it didn't ask for.   We 'could' fix that,
> > but it's never really been worth the effort.
> >=20
> > Events tend to be low data rate so an occasionally extra is rather diff=
erent
> > to having to have much larger data buffers to handle a range of channel=
s you
> > never asked for.
> >=20
> > Lets be careful to document this behaviour as 'may enable extra events'
> > as then if we decide later to do demux type stuff we won't be breaking =
ABI.
> > No one will mind getting fewer spurious events due to a core improvemen=
t. =20
>=20
> Where would this get documented?

Starting point will be in the docs for the ABI that asks for any events at =
all.

Also useful to add some thing to Documentation/IIO though there are lots of
other things those docs don't yet cover :(

>=20
> >>  =20
> >> > Independent of the above, we can argue that having both inkernel and=
 userspace
> >> > changing thresholds is ok (I mean, there's nothing stopping two user=
space apps
> >> > doing that) but we should likely be careful with enabling/disabling.=
 If multiple
> >> > consumers enable the same event, one of them disabling it should not=
 disable it
> >> > for all the consumers, right?   =20
> >>=20
> >> Right now the HWMON consumer never permanently disable events to avoid=
 this
> >> issue. It does toggle the enable to determine if an alarm should stay
> >> enabled:
> >>              ________
> >> condition __/        \________
> >>           _____    ____    ___
> >> enable         \__/    \__/
> >>=20
> >> event       |     |
> >>              __    ____
> >> alarm     __/  \__/    \_____
> >>=20
> >> read           1       1    0
> >>=20
> >> I suppose this could also be done by comparing the raw threshold to the
> >> channel. =20
> >=20
> > I wonder if we should add the option to do a 'get_exclusive' or similar
> > to block the IIO user interfaces if something critical is using the dev=
ice.
> >=20
> > If we were for instance to use this to block the IOCTL to get the events
> > fd then any built in driver etc will almost certainly load before anyone
> > can call the ioctl so it will fairly cleanly block things. =20
>=20
> This is how it currently works for userspace. Only one process can create
> the event fd, and everyone else gets -EBUSY.
>=20
> Of course, it would be pretty surprising to have an IIO device where
> some channels were used by userspace and others were used by hwmon and
> then have your daemon stop working after you update your kernel because
> now the hwmon driver takes exclusive event access.

True.  I wonder how many boards we don't know about are using the iio-hwmon
bridge. We can check the ones in kernel for whether they grab all the
channels (which would rule this out).

Another things we could do is have an opt in from the IIO driver.
That way only 'new' drivers would have this behaviour.  Not nice though.

>=20
> I originally had kernel users read from the kfifo just like userspace,
> but I was concerned about the above scenario.
>=20

yeah, always a problem to retrofit policy.

> --Sean
>=20


