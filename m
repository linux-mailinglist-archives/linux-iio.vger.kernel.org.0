Return-Path: <linux-iio+bounces-22056-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2353B13062
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 18:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52F633B9C24
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 16:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF27421B9FE;
	Sun, 27 Jul 2025 16:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4Ouix4G"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75780EEC3;
	Sun, 27 Jul 2025 16:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753633294; cv=none; b=GC3zLrjorKF0PNghbN93QG1BlRB3WskzmbpAtOIIv+PqIg9lfTfIlZxy0/C6+twBIIU0aVbvt1sTXTRvcjkfsly+XDUOT1dQykiEdmECnQ2CErGWWfCiV67xiehbo4ALivwPWiU5G1hh7pcE/78+sHfb8t587qngtuubahjbQpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753633294; c=relaxed/simple;
	bh=hCjaLBzF7rPnqUMF9tY9upOLuEgqB8LxmyvF0dCoQ5s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SuLg2DALZ0yR6PGkrhdFhGo2BA89i+aCNIay9cLn7LvAIIql4llTS4ZkkjdE6nXsqDivS8qNXTCyxr8N264OizFhfh9rBFEKMQInxNOGVdUOv6PWTROmWfPlKCeyGS5uB8gUaM/Gr5seLfUDIUeNJcji5JhrZlcFbypJAycYAUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4Ouix4G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDA5C4CEEB;
	Sun, 27 Jul 2025 16:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753633294;
	bh=hCjaLBzF7rPnqUMF9tY9upOLuEgqB8LxmyvF0dCoQ5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M4Ouix4G+ncs+jRjgFz0MzMhWFuSzr3gRdrbDDBykG7z/qNFETeNpJRjyotQDlHL9
	 gM0Fa1Vugiejn3k8pnnLxoH7+0wTTZCq7Yc+TmjbzPmA6XTPUTYAo6elVfarn4b+5Y
	 JrnRtqoZgFVJA7cQKjnB0lt0QnUjcQeiqoDJGkLgcyrz4r9ACme8BER8rXF0XL0xkN
	 hp/DWESIVdziUMhSV4JL/pp7t4E0x0xUTUxb0TCizf+vV0MvfZ3BCwxLYL73cNBpro
	 Aa5edCgbKVju39rtwXyIyTMIWIPR3MUnt7Xp8JYHlPOIJjDlI0755j07e3gcQ1cGcl
	 0d422NyHB4gMg==
Date: Sun, 27 Jul 2025 17:21:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Jean Delvare
 <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
 linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org, Andy Shevchenko
 <andy@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 3/7] iio: Add in-kernel API for events
Message-ID: <20250727172126.35d0a477@jic23-huawei>
In-Reply-To: <9b187e7f-a116-4aea-a9a6-b9222562868d@linux.dev>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
	<20250715012023.2050178-4-sean.anderson@linux.dev>
	<d8e5c8fbeaee42e9e0708460c47bd68053cd8710.camel@gmail.com>
	<9b187e7f-a116-4aea-a9a6-b9222562868d@linux.dev>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Jul 2025 12:52:19 -0400
Sean Anderson <sean.anderson@linux.dev> wrote:

> On 7/15/25 07:09, Nuno S=C3=A1 wrote:
> > On Mon, 2025-07-14 at 21:20 -0400, Sean Anderson wrote: =20
> >> Add an API to notify consumers about events. Events still need to be
> >> enabled using the iio_read_event/iio_write_event functions. Of course,
> >> userspace can also manipulate the enabled events. I don't think this is
> >> too much of an issue, since userspace can also manipulate the event
> >> thresholds. But enabling events may cause existing programs to be
> >> surprised when they get something unexpected. Maybe we should set the
> >> interface as busy when there are any in-kernel listeners?
> >>  =20
> >=20
> > Sensible question. I'm not that familiar with events but I suspect is n=
ot
> > trivial (if doable) to do a similar approach as with buffers? With buff=
ers, an
> > inkernal consumer get's it's own buffer object (that goes into a list o=
f active
> > buffers in the iio device) with all channels enabled and then we demux =
the
> > appropriate channels for each consumer. =20
>=20
> For in-kernel consumers I think it's reasonable to expect them to handle
> events they didn't explicitly enable. I'm not sure about userspace
> consumers.

This already happens because we don't have a demux equivalent (what we do
for buffered data flow) so if a device only has a single enable bit that co=
vers
multiple events (annoyingly common for accelerometers for example) then
userspace will get events it didn't ask for.   We 'could' fix that,
but it's never really been worth the effort.

Events tend to be low data rate so an occasionally extra is rather different
to having to have much larger data buffers to handle a range of channels you
never asked for.

Lets be careful to document this behaviour as 'may enable extra events'
as then if we decide later to do demux type stuff we won't be breaking ABI.
No one will mind getting fewer spurious events due to a core improvement.

>=20
> > Independent of the above, we can argue that having both inkernel and us=
erspace
> > changing thresholds is ok (I mean, there's nothing stopping two userspa=
ce apps
> > doing that) but we should likely be careful with enabling/disabling. If=
 multiple
> > consumers enable the same event, one of them disabling it should not di=
sable it
> > for all the consumers, right? =20
>=20
> Right now the HWMON consumer never permanently disable events to avoid th=
is
> issue. It does toggle the enable to determine if an alarm should stay
> enabled:
>              ________
> condition __/        \________
>           _____    ____    ___
> enable         \__/    \__/
>=20
> event       |     |
>              __    ____
> alarm     __/  \__/    \_____
>=20
> read           1       1    0
>=20
> I suppose this could also be done by comparing the raw threshold to the
> channel.

I wonder if we should add the option to do a 'get_exclusive' or similar
to block the IIO user interfaces if something critical is using the device.

If we were for instance to use this to block the IOCTL to get the events
fd then any built in driver etc will almost certainly load before anyone
can call the ioctl so it will fairly cleanly block things.

Jonathan



