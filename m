Return-Path: <linux-iio+bounces-27070-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE15ACBB192
	for <lists+linux-iio@lfdr.de>; Sat, 13 Dec 2025 17:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B423E30019DE
	for <lists+linux-iio@lfdr.de>; Sat, 13 Dec 2025 16:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A278B242D8E;
	Sat, 13 Dec 2025 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dETTlPF3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593F6381C4;
	Sat, 13 Dec 2025 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765645052; cv=none; b=O9IgQskZCBAtYm6HyYZBf6dXmXRsNny/a+QZ8HVVs2AY0TEQHUS0SnHxrpAaIz29jex2ZwU7OCMuLtporpNXoUqA0w4L2BNIiApyTLcg8Sr5V57azvn4nFAfBl8bC5BCQRReojidf0LElsPr5Q2p3AtWzXBmuJdbh4S+llGAOWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765645052; c=relaxed/simple;
	bh=JDR3x0gFMqvNKk8GJNNBhZ8GAtTDToO1ukIK84PNFZc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dw/1FVR73G3RVW5lcfsPe/cpAav7K1L2sZXgE0l3VLYWmuvFIiuoBKm/mAqQBt453FFjEuobAEHcHDrGa6ZDxTWsAfF0N2KzYuDmmFaRIixbnNOxuCmMoOZuvlMGT0MvL5KVNPxG21XhW96DE2FSCcEwKIrLKPcKWr23VQupjhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dETTlPF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EEBC4CEF7;
	Sat, 13 Dec 2025 16:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765645051;
	bh=JDR3x0gFMqvNKk8GJNNBhZ8GAtTDToO1ukIK84PNFZc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dETTlPF3HnpkP6wwCE2xZwAALBuxeQRLOQLcmvUI+pvmTx+OGtpVrPzLlJcd81kzf
	 zTAcV0cnzhaCXajVCP+t5u9+tJ21ZpVjYQsu2pqlwFUR6jzfnbXk8dZSpzI9nGk/GE
	 n6cZ8iCOIIqwERmwKZPl/5aYl3/b+hB4ta2YKKxFLqrE1ZcVJI2OWPEj1+MJTzC1+0
	 Im04TFjF1ooC9JT/ItI5+aCPSYGw5+/4rUiX8wJFzjNmdObdqz+oECAUGYL59vAywI
	 bPP7BHrkU6/fZTkMfQLsWcEmN3GRHjTwzXxSiJApyhFg3Z2ceCa4HW25Hi1aH7HSvK
	 WbBQ82EBBJPlQ==
Date: Sat, 13 Dec 2025 16:57:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Peter Rosin <peda@axentia.se>, Guenter Roeck <linux@roeck-us.net>,
 <linux-iio@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
Subject: Re: lockdep splat involving iio-hwmon and iio-rescale drivers
Message-ID: <20251213165723.762035e4@jic23-huawei>
In-Reply-To: <87ms3nu9m7.fsf@prevas.dk>
References: <87qzt2tnlu.fsf@prevas.dk>
	<17697c17-753e-46a4-8e57-107dc744f18d@roeck-us.net>
	<ced7efb0-02eb-f1b0-9033-e546ca302f1d@axentia.se>
	<307296eb-e5b4-705b-6851-53cecb87a69c@axentia.se>
	<87ms3nu9m7.fsf@prevas.dk>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Dec 2025 14:12:48 +0100
Rasmus Villemoes <ravi@prevas.dk> wrote:

> On Thu, Dec 11 2025, Peter Rosin <peda@axentia.se> wrote:
> 
> > 2025-12-10 at 23:54, Peter Rosin wrote:  
> >> Before commit 3092bde731ca ("iio: inkern: move to the cleanup.h
> >> magic") I think this could have been solved with a number of:
> >> 
> >> -	mutex_lock(&iio_dev_opaque->info_exist_lock);
> >> +	mutex_lock_nested(&iio_dev_opaque->info_exist_lock);  
> >
> > Oops, we need something clever for the (missing) subclass
> > argument to the mutex_lock_nested() calls, which I simply forgot
> > all about. It should have been:
> >
> > +	mutex_lock_nested(&iio_dev_opaque->info_exist_lock, *subclass*);
> >
> > I don't know what sane subclasses there are. One thing could be
> > the recursion depth, but I don't think we want to keep track of that
> > just for lockdep? Another is to use one lockdep class for every
> > info_exist_lock, but that can generate a lot of lockdep classes...  

Either option should work but agreed tracking depth when
we otherwise don't care about it feels excessive.
We already have classes for the other major internal lock in IIO devices (mlock)

https://elixir.bootlin.com/linux/v6.18.1/source/drivers/iio/industrialio-core.c#L1722

I'm a bit curious we haven't seen many reports of this one. Whilst
there are relatively few IIO drivers that consume other IIO driver provided
channels it's also not a particularly new thing.

> 
> It doesn't seem to me that that info_exist_lock is the proper
> mechanism for whatever it is it is protecting against.
> 
> I'm not even sure it's needed, because if the device could be
> unregistered while somebody has a reference to it, why is it even
> allowed to take that lock in the first place (i.e., why is the memory
> containing the info_exist_lock guaranteed to still be valid)?

It's to protect against racing with setting of iio_dev->info to NULL.
The iio_dev itself is reference counted so it should always be safe
to do this lookup. Note that use of info == NULL isn't about accessing
info alone, but as a general gate on device has gone away (but
structures are still there until all consumers - in kernel or userspace
- are done).

In theory at least all consumers use proxy functions that check that
and error out if the thing being consumed has gone away.  Those that
are sleeping on anything are woken up and return errors.

Sure there are other approaches to providing that protection and
there was an attempt to do a generic solution a while back. I lost
track of where that got to.  Might be worth a revisit at some point.

For now though a lockdep class per instance seems the way to go to me.

Jonathan


> 
> But, since I'm not going to propose just ripping it out, perhaps a
> better approach would be something like what the gpio subsystem did in
> d83cee3d2bb1 ("gpio: protect the pointer to gpio_chip in gpio_device
> with SRCU"), at least superficially it seems to be about a similar
> problem.
> 
> Rasmus


