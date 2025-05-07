Return-Path: <linux-iio+bounces-19259-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0229AAAEC59
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 21:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DCA97B4E0B
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 19:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89B128E59A;
	Wed,  7 May 2025 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESTpkDNz"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E9228E58E;
	Wed,  7 May 2025 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746646833; cv=none; b=NGecs5hlvJ2h4U+NCA/n2pKQNO+/ZKS/QfG+BC6Q5wTSIBhNnO3kQOVi8YajhoSH7xYkB+RVy71ncdY48OZL4KLu7SXul/IpQZwf4bak7fb3OtLdwwyW6FqQI/w3QrvnwmkyOnYrgqpA64oo/Vgot4HSI2hYrTf2HxJWNBj9+AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746646833; c=relaxed/simple;
	bh=D/3gOi2CH+wi0Y+aWfbbkPYfVXKsIwOG9/O0AWWeqQo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iD50HC7BYlaEfmrs1MgHhX/S1/xzadAN0gYUwH+zt/8tvyt192OVuEjSoGym7Ws9gkNVR8FdL7Z+zgEA8/yoM41LgRg4v/6YtUBS9iop1l6Zs34/31BB3GpunNial8hX6nX78ePYMNl89+EXUeJ5zURjfkyTc8/GmSoJPfVELlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESTpkDNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805E0C4CEF2;
	Wed,  7 May 2025 19:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746646833;
	bh=D/3gOi2CH+wi0Y+aWfbbkPYfVXKsIwOG9/O0AWWeqQo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ESTpkDNzq6c+NKmNNak0M1cBMMsAQPkptEVBgsuslyVhFoS9brLtyXVIoABqKDZmT
	 /GCcxVq3gvmE7IWbeiRnD2mPlCCiZuV3oBRoOJKWojiocgzImjNVajpebXbCJ4Grcu
	 KSSAbffn5lCobBmjchYlCwxf+XwXsvz/3dOd6psbgzKFsTKzLEA/5Sx5KDjzKHRBKZ
	 0L3BBGQm2Nihn//kADkW8c0rbbg9H6IPcng2LvxV+1G3QFHpEoovd7pBE85DVLQDWI
	 7i1iYUSpnArtFzH9pPMZZfxSpDYElBaKn4OC5Yqyevbdjodu3A9ccem4WW5h0Y6G84
	 HRfib6OH5wrdw==
Date: Wed, 7 May 2025 20:40:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gyeyoung Baek <gye976@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: trigger: Add validation to reject devices
 requiring top half
Message-ID: <20250507204026.11a260ef@jic23-huawei>
In-Reply-To: <CAKbEznvZ3BHJK8TjGg7MR2dDMtWk+gZ5SewF_u_J0=Nw6c082Q@mail.gmail.com>
References: <20250503190044.32511-1-gye976@gmail.com>
	<20250504152441.13772899@jic23-huawei>
	<CAKbEznvZ3BHJK8TjGg7MR2dDMtWk+gZ5SewF_u_J0=Nw6c082Q@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 7 May 2025 00:55:27 +0900
Gyeyoung Baek <gye976@gmail.com> wrote:

> Hello Jonathan, thank you for the review.
> I would appreciate it if you could review my additional comments.
>=20
> On Sun, May 4, 2025 at 11:24=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Sun,  4 May 2025 04:00:43 +0900
> > Gyeyoung Baek <gye976@gmail.com> wrote:
> > =20
> > > Some device drivers implement top-half handler,
> > > which is not compatible with threaded handler trigger.
> > > This patch adds a validation function to reject such devices,
> > > allowing only iio_pollfunc_store_time(). =20
> >
> > This needs more reasoning.  What makes it not work?
> > + what do we mean by not compatible?
> > I'd expect at least a reference to it using iio_trigger_poll_nested()
> > directly. =20
>=20
> Of course, even if the IIO device registers a top-half,
> `iio_trigger_poll_nested()` ignores the top-half and only calls the
> bottom-half, so it works properly.
> What I misunderstood here is that I thought there were other IIO
> devices implementing a top-half other than
> `iio_pollfunc_store_time()`. So I assumed that the TODO was to block
> those.
> I had confused it with the IIO trigger's top-half handler, apologies
> for the confusion.

There were...  I'm rather surprised that there are none any more!

>=20
> ---
>=20
> > It's unfortunately hard to tell whether a top half handler is
> > actually needed or not.  As a follow up question, what cases do we have
> > of top half / interrupt context handlers other than iio_pollfunc_store_=
time()? =20
>=20
> No, it seems that `iio_pollfunc_store_time()` is the only top-half
> handler for IIO devices.
Excellent.

>=20
> ---
>=20
> > Maybe we don't need this code to be this complex any more at all
> > (i.e. could it become a flag to say whether the timestamp is useful or =
not)
> > rather than registering the callback. =20
>=20
> my new understanding of TODO is as follows:
>     - Since `iio_loop_thread()` can only call
> `iio_trigger_poll_nested()` and not `iio_trigger_poll()`,
>       if the connected IIO device expects a top half such as
> `iio_pollfunc_store_time()`,
>       then `iio_loop_thread()` needs to directly call
> `iio_pollfunc_store_time().`

I'd take a different approach (slightly) though it's more effort.

Step 1. Tidy up current situation.

Patch to convert all existing calls to devm_iio_triggered_buffer_setup()
and iio_triggered_buffer_setup() to not take a top half function but replace
that variable with a bool early_timestamp or something along those lines.
Replace the h in struct iio_poll_func with a similarly named bool.
Bunch of plumbing to make that all get filled in correctly.

Then in iio_trigger_attach_pollfunc() check that bool and if appropriate
pass iio_pollfunc_store_time() it to request_threaded_irq()

Step 2. Make what you want work cleanly now we only have that one handler.

In iio_trigger_poll_nested() we can't know if that flag is set and I'm not
really keen on trying to get to this from elsewhere. We have previously con=
sidered
solving this case via whether the timestamp is set or not in the threaded
handler. I've never like that much as in theory timestamp 0 is valid (was
a while ago). The rpr0521 light sensor has handling for this.

I wonder if the following would work.

In iio_trigger_attach_poll_func() we have access to the trigger and
the pollfunc.  So if the pollfunc flag for wanting an early timestamp is se=
t and
we know the trigger is going to use iio_poll_trigger_nested() then we could
wrap the registered handler in a local one that calls the iio_pollfunc_stor=
e_time()

The additional magic needed here is that today we don't know that about the=
 trigger.
So we'd need to add a bool to the struct iio_trig to indicate it and set th=
at
for all drivers that use iio_trigger_poll_nested()   bool nested; will do.

It's not perfect as there are driver that do iio_trigger_poll() and iio_tri=
gger_poll_nested()
depending on path. To handle those we'd need a flag to say don't overwrite =
my timestamp.
at91-sama5d2-adc.c is the first one I found.

There are ways to make even that work but lets skip that for now as they'd
slightly complicate things. That driver won't call the timestamp capture in
some paths but it doesn't today so we are no worse off.

Jonathan


>=20
> Would my understanding be correct?
>=20
> ---
>=20
> > >
> > > +/*
> > > + * Protect against connection of devices that 'need' the top half
> > > + * handler.
> > > + */
> > > +static int iio_loop_trigger_validate_device(struct iio_trigger *trig,
> > > +                                             struct iio_dev *indio_d=
ev)
> > > +{
> > > +     struct iio_poll_func *pf =3D indio_dev->pollfunc;
> > > +
> > > +     /* Only iio timestamp grabbing is allowed. */
> > > +     if (pf->h && pf->h !=3D iio_pollfunc_store_time) =20
> >
> > Why is iio_pollfunc_store_time useable here?  It's not going to store t=
he
> > time if we don't call it...  We could special case it probably but we'd
> > need to ensure the call is actually made. =20
>=20
> Yes, If my new understanding is correct, `iio_loop_thread()` needs to
> call `iio_pollfunc_store_time()` directly,
> depending on whether the IIO device's top-half is NULL or
> `iio_pollfunc_store_time()`.
Yes. But it doesn't have direct access to the required pollfunc.


>=20
> --
> Regards,
> Gyeyoung
>=20


