Return-Path: <linux-iio+bounces-22167-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B69B171A3
	for <lists+linux-iio@lfdr.de>; Thu, 31 Jul 2025 14:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B11F67A5B40
	for <lists+linux-iio@lfdr.de>; Thu, 31 Jul 2025 12:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC282C08DB;
	Thu, 31 Jul 2025 12:59:33 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A4A1E50E;
	Thu, 31 Jul 2025 12:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753966773; cv=none; b=GiNpylMWNIILjQECdvUCly9bCFWkTopt3cCHwsmhSWYpG7AHSlRl+PLHzN+CCYpb+D+HYQ/DK5zcBJrBtjL3EdBr6C9fsMIuOki0gPP35Q/DB7skqTlnOR0OngX//FdhyknDB83cyIWao0oXmauO849yoZmlWhhxC6xA8iSEjsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753966773; c=relaxed/simple;
	bh=XSOS+UZ9IKleq/K0LcM2Wi6Hy3xaj835z9KG/vLfA0s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M7AxXoqel9Wxw5sT+LVB7AkCHundoUVggWQG4X3FD0reeR6ShzUMjBt55Tf2tBD+j5QR9wGC+EHNHBHdLzWCgVeahpuCApOkQIbrecljIeIwJRrN3rzuEhSrchEkLAoIDlngUgYr/CP2aYK6xvQ+6f1DcRjHq0MPqFxlCgePLLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bt8JG2hN3z6D9Pm;
	Thu, 31 Jul 2025 20:57:50 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D74C31400D9;
	Thu, 31 Jul 2025 20:59:27 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 31 Jul
 2025 14:59:27 +0200
Date: Thu, 31 Jul 2025 13:59:25 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Sean Anderson <sean.anderson@linux.dev>
CC: Jonathan Cameron <jic23@kernel.org>, Nuno =?ISO-8859-1?Q?S=E1?=
	<noname.nuno@gmail.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck
	<linux@roeck-us.net>, <linux-iio@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, <linux-kernel@vger.kernel.org>,
	David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 3/7] iio: Add in-kernel API for events
Message-ID: <20250731135925.00007e5d@huawei.com>
In-Reply-To: <edb59657-ced2-4557-afe5-07bd83af848e@linux.dev>
References: <20250715012023.2050178-1-sean.anderson@linux.dev>
	<20250715012023.2050178-4-sean.anderson@linux.dev>
	<d8e5c8fbeaee42e9e0708460c47bd68053cd8710.camel@gmail.com>
	<9b187e7f-a116-4aea-a9a6-b9222562868d@linux.dev>
	<20250727172126.35d0a477@jic23-huawei>
	<0ccf7735-6a2c-473a-ab67-ae0c5ff9a335@linux.dev>
	<20250729193346.39791223@jic23-huawei>
	<edb59657-ced2-4557-afe5-07bd83af848e@linux.dev>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 29 Jul 2025 16:09:20 -0400
Sean Anderson <sean.anderson@linux.dev> wrote:

> On 7/29/25 14:33, Jonathan Cameron wrote:
> > On Mon, 28 Jul 2025 18:44:30 -0400
> > Sean Anderson <sean.anderson@linux.dev> wrote:
> >  =20
> >> On 7/27/25 12:21, Jonathan Cameron wrote: =20
> >> > On Tue, 15 Jul 2025 12:52:19 -0400
> >> > Sean Anderson <sean.anderson@linux.dev> wrote:
> >> >    =20
> >> >> On 7/15/25 07:09, Nuno S=E1 wrote:   =20
> >> >> > On Mon, 2025-07-14 at 21:20 -0400, Sean Anderson wrote:     =20
> >> >> >> Add an API to notify consumers about events. Events still need t=
o be
> >> >> >> enabled using the iio_read_event/iio_write_event functions. Of c=
ourse,
> >> >> >> userspace can also manipulate the enabled events. I don't think =
this is
> >> >> >> too much of an issue, since userspace can also manipulate the ev=
ent
> >> >> >> thresholds. But enabling events may cause existing programs to be
> >> >> >> surprised when they get something unexpected. Maybe we should se=
t the
> >> >> >> interface as busy when there are any in-kernel listeners?
> >> >> >>      =20
> >> >> >=20
> >> >> > Sensible question. I'm not that familiar with events but I suspec=
t is not
> >> >> > trivial (if doable) to do a similar approach as with buffers? Wit=
h buffers, an
> >> >> > inkernal consumer get's it's own buffer object (that goes into a =
list of active
> >> >> > buffers in the iio device) with all channels enabled and then we =
demux the
> >> >> > appropriate channels for each consumer.     =20
> >> >>=20
> >> >> For in-kernel consumers I think it's reasonable to expect them to h=
andle
> >> >> events they didn't explicitly enable. I'm not sure about userspace
> >> >> consumers.   =20
> >> >=20
> >> > This already happens because we don't have a demux equivalent (what =
we do
> >> > for buffered data flow) so if a device only has a single enable bit =
that covers
> >> > multiple events (annoyingly common for accelerometers for example) t=
hen
> >> > userspace will get events it didn't ask for.   We 'could' fix that,
> >> > but it's never really been worth the effort.
> >> >=20
> >> > Events tend to be low data rate so an occasionally extra is rather d=
ifferent
> >> > to having to have much larger data buffers to handle a range of chan=
nels you
> >> > never asked for.
> >> >=20
> >> > Lets be careful to document this behaviour as 'may enable extra even=
ts'
> >> > as then if we decide later to do demux type stuff we won't be breaki=
ng ABI.
> >> > No one will mind getting fewer spurious events due to a core improve=
ment.   =20
> >>=20
> >> Where would this get documented? =20
> >=20
> > Starting point will be in the docs for the ABI that asks for any events=
 at all.
> >=20
> > Also useful to add some thing to Documentation/IIO though there are lot=
s of
> > other things those docs don't yet cover :( =20
>=20
> Notably the whole events API :l
>=20
> >>  =20
> >> >>    =20
> >> >> > Independent of the above, we can argue that having both inkernel =
and userspace
> >> >> > changing thresholds is ok (I mean, there's nothing stopping two u=
serspace apps
> >> >> > doing that) but we should likely be careful with enabling/disabli=
ng. If multiple
> >> >> > consumers enable the same event, one of them disabling it should =
not disable it
> >> >> > for all the consumers, right?     =20
> >> >>=20
> >> >> Right now the HWMON consumer never permanently disable events to av=
oid this
> >> >> issue. It does toggle the enable to determine if an alarm should st=
ay
> >> >> enabled:
> >> >>              ________
> >> >> condition __/        \________
> >> >>           _____    ____    ___
> >> >> enable         \__/    \__/
> >> >>=20
> >> >> event       |     |
> >> >>              __    ____
> >> >> alarm     __/  \__/    \_____
> >> >>=20
> >> >> read           1       1    0
> >> >>=20
> >> >> I suppose this could also be done by comparing the raw threshold to=
 the
> >> >> channel.   =20
> >> >=20
> >> > I wonder if we should add the option to do a 'get_exclusive' or simi=
lar
> >> > to block the IIO user interfaces if something critical is using the =
device.
> >> >=20
> >> > If we were for instance to use this to block the IOCTL to get the ev=
ents
> >> > fd then any built in driver etc will almost certainly load before an=
yone
> >> > can call the ioctl so it will fairly cleanly block things.   =20
> >>=20
> >> This is how it currently works for userspace. Only one process can cre=
ate
> >> the event fd, and everyone else gets -EBUSY.
> >>=20
> >> Of course, it would be pretty surprising to have an IIO device where
> >> some channels were used by userspace and others were used by hwmon and
> >> then have your daemon stop working after you update your kernel because
> >> now the hwmon driver takes exclusive event access. =20
> >=20
> > True.  I wonder how many boards we don't know about are using the iio-h=
wmon
> > bridge. We can check the ones in kernel for whether they grab all the
> > channels (which would rule this out).
> >
> > Another things we could do is have an opt in from the IIO driver.
> > That way only 'new' drivers would have this behaviour.  Not nice though=
. =20
>=20
> I would really like for this to "just work" if at all possible, so an
> opt-out would be preferable. Maybe a hwmon module parameter.
>=20
> But I think we can do better:
>=20
> - Both kernel/userspace can/should handle unexpected events
>   - This includes extra (synthetic) events.
> - Both kernel/userspace mostly just want to enable events
> - Disabling events is not as important because of the previous bullet.
> - But losing events is probably bad so we want to ensure we trigger
>   events at the same places they would have been triggered before.
>=20
> So maybe we have an implementation where
>=20
> - Enabling an event disables the backing event before re-enabling it if
>   there are any existing users
> - Disabling an event only disables the backing event if all users are
>   gone
>=20
> It could look something like
>=20
> iio_sysfs_event_set(event, val):
>     if val:
>         if !event.user_enable
>             disable(event)
>         enable(event)
>     else if !event.kernel_enables
>         disable(event)
>     event.user_enable =3D val
>=20
> iio_inkern_event_set(event, val):
>     if val:
>         if event.kernel_enables++ || event.user_enable
>             disable(event)
>         enable(event)
>     else if !--event.kernel_enables && !event.user_enable:
>         disable(event)

Something like that should work.  We'll need to be careful
to gate any push towards userspace on it waiting for something.

Given we only send them when IIO_BUSY_BIT_POS is set on the
event interface (which happens on requesting the fd) I think
we may be fine already.

Jonathan

>=20
> --Sean
>=20
> >>=20
> >> I originally had kernel users read from the kfifo just like userspace,
> >> but I was concerned about the above scenario.
> >>  =20
> >=20
> > yeah, always a problem to retrofit policy.
> >  =20
> >> --Sean
> >>  =20
> >  =20
>=20
>=20


