Return-Path: <linux-iio+bounces-19525-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31206AB7F2B
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 09:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1F84A180F
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 07:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB901FDA89;
	Thu, 15 May 2025 07:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9UJxZya"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB8510FD;
	Thu, 15 May 2025 07:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747295385; cv=none; b=I1f9oWptH/kFAy1PT0l2XY7eiO64rUAM1eFLhYbRHVlkJ3uv/8OFyGp51S41AWzKv+ysUinr5A8qnrgS6nbvn7h/9AeIf1bAo762o/OjQiBL+7nG4l9D2gLjwkVx4SD3HiQonPKMU3l40tEazGGCa+lm+6HHFRk9Cq0UXPwIcbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747295385; c=relaxed/simple;
	bh=3jzzyKoPVNBte10yueh+3cKhOlijEv98gMIVxapULC4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GmQS/+hVZSpmWGwzIxy39luWZYaQc0wwZbjqMueMNNH//sX8lYp1PfkrbhJJyv8tC6OjLyaQwZegI8539KyFx/Nw9a9IggQVEESNaDYSp4Q9T8dlyv8+WNbGYA+n2fwmkJYDP7wZCprWCr4NSdmtBuhdq5nyKGUvuVHFcjjyY1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9UJxZya; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745E7C4CEE7;
	Thu, 15 May 2025 07:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747295384;
	bh=3jzzyKoPVNBte10yueh+3cKhOlijEv98gMIVxapULC4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u9UJxZya60202wNrLNq2xs/u/QwHHwiTkHlp3gKc65I8fZ8BLs0qZnQFGjnE2XL0q
	 VjO9rk3erH8FhkyjehvKzB5xsZPiuu79VBd4aN1Fd8TagXuQ2G5q5Q19A1p9IFdvGF
	 bgQD1G/3ZaIMvbd3aK6+Sk6Cs7mN6evcrn6ZkqkGlvzmUPLShlpr1BDmLaE1A4seL2
	 pUf8X5Ur+4h0gNbhD9MLnGIO/lWq6ZOqiidr1P4pb4X9LqMh3oGIS99X9bcK/Y/ka5
	 5tRayH7eHZFamv4QblXVj73hJs0RE8t/15UUbwR6L/7bTVI+hYU6CQmvULirHc4tKm
	 J55KSWWq45kpw==
Date: Thu, 15 May 2025 08:49:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gyeyoung Baek <gye976@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: trigger: Add validation to reject devices
 requiring top half
Message-ID: <20250515084937.432fd168@jic23-huawei>
In-Reply-To: <CAKbEznuG6-+cKOOVSvyw30Qra_6yVruA0cvpcK5Gqp2_kcPHcw@mail.gmail.com>
References: <20250503190044.32511-1-gye976@gmail.com>
	<20250504152441.13772899@jic23-huawei>
	<CAKbEznvZ3BHJK8TjGg7MR2dDMtWk+gZ5SewF_u_J0=Nw6c082Q@mail.gmail.com>
	<20250507204026.11a260ef@jic23-huawei>
	<CAKbEznuG6-+cKOOVSvyw30Qra_6yVruA0cvpcK5Gqp2_kcPHcw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 12 May 2025 00:47:39 +0900
Gyeyoung Baek <gye976@gmail.com> wrote:

> Hello Jonathan,
> I=E2=80=99ve referred to your previous comments and implemented the ideas.
> Thank you for your earlier feedback.
> I now have a few follow-up questions and would appreciate your
> thoughts on the below points.
>=20
> On Thu, May 8, 2025 at 4:40=E2=80=AFAM Jonathan Cameron <jic23@kernel.org=
> wrote:
> >
> > On Wed, 7 May 2025 00:55:27 +0900
> > Gyeyoung Baek <gye976@gmail.com> wrote: =20
>=20
> > I'd take a different approach (slightly) though it's more effort.
> >
> > Step 1. Tidy up current situation.
> >
> > Patch to convert all existing calls to devm_iio_triggered_buffer_setup()
> > and iio_triggered_buffer_setup() to not take a top half function but re=
place
> > that variable with a bool early_timestamp or something along those line=
s.
> > Replace the h in struct iio_poll_func with a similarly named bool.
> > Bunch of plumbing to make that all get filled in correctly.
> >
> > Then in iio_trigger_attach_pollfunc() check that bool and if appropriate
> > pass iio_pollfunc_store_time() it to request_threaded_irq() =20
>=20
> Now we have both the existing `devm_iio_triggered_buffer_setup()`,
> and a new version with the additional arguments of that.
> Should these two coexist for compatibility, or should the before one
> be replaced by the new one?

So the aim will be to replace the existing function.=20
How to get there is indeed an excellent question.

I'd want to do it in one go, but as it affects a lot of drivers a=20
single patch is probably not appropriate.

So we'd introduce something like
devm_iio_triggered_buffer_setup2() with new parameters

Move everything over to that then a single patch to remove
the old function and rename it all back to the original.

Alternatively we could find a reasonable alternative name to avoid
that 'rename all at the end' patch.

devm_iio_triggered_buf_setup() perhaps? =20

>=20
> > Step 2. Make what you want work cleanly now we only have that one handl=
er.
> >
> > In iio_trigger_poll_nested() we can't know if that flag is set and I'm =
not
> > really keen on trying to get to this from elsewhere. We have previously=
 considered
> > solving this case via whether the timestamp is set or not in the thread=
ed
> > handler. I've never like that much as in theory timestamp 0 is valid (w=
as
> > a while ago). The rpr0521 light sensor has handling for this. =20
>=20
> What I'm trying to do is a mechanism where device drivers can
> automatically get timestamps without manually handling them =E2=80=94 sim=
ply
> by setting a argument to indicate whether to capture the timestamp in
> the tophalf or bottomhalf.
>=20
> But there are cases like the rpr0521 where the driver sets the
> timestamp manually within its own trigger.
> Would it make sense to extend this to automatically set the timestamp
> in cases where the driver uses its own trigger as well?
> To that, I believe we would need a unified interface that can cover
> all trigger types (e.g., interrupt, software trigger) that invoke
> poll() or poll_nested().
> Would it be the right direction?
> Or would it be more appropriate to consider only the top/bottom of a
> consumer device?

I'd like to avoid grabbing the timestamp for particular drivers
that never need it (as they want to grab it in the thread for
reasons of how they work - typically the capture only starts
when then write to the device).  Other than that I'm not against
having it grabbed in drivers that 'sometimes' need it whether
or not it turns out they do.

The dance is that we can't see the right information in poll / poll_nested
so the best we can do is see if someone already filled in the
timestamp in the handler we are currently running.  For that we need
a flag alongside the pollfunc timestamp.  Care will be needed to ensure
there are no races though as we might clear that flag just after another
top half interrupt has been taken on a different cpu core.

I'm not sure yet exactly how this will work.  Needs some experimenting
and thought.

J
>=20
> > I wonder if the following would work.
> >
> > In iio_trigger_attach_poll_func() we have access to the trigger and
> > the pollfunc.  So if the pollfunc flag for wanting an early timestamp i=
s set and
> > we know the trigger is going to use iio_poll_trigger_nested() then we c=
ould
> > wrap the registered handler in a local one that calls the iio_pollfunc_=
store_time()
> >
> > The additional magic needed here is that today we don't know that about=
 the trigger.
> > So we'd need to add a bool to the struct iio_trig to indicate it and se=
t that
> > for all drivers that use iio_trigger_poll_nested()   bool nested; will =
do.
> >
> > It's not perfect as there are driver that do iio_trigger_poll() and iio=
_trigger_poll_nested()
> > depending on path. To handle those we'd need a flag to say don't overwr=
ite my timestamp.
> > at91-sama5d2-adc.c is the first one I found. =20
>=20
> > There are ways to make even that work but lets skip that for now as the=
y'd
> > slightly complicate things. That driver won't call the timestamp captur=
e in
> > some paths but it doesn't today so we are no worse off. =20
>=20
> --
> Regards,
> Gyeyoung

