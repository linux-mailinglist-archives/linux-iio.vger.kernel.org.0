Return-Path: <linux-iio+bounces-16185-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7A4A4989E
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 12:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700083B6958
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 11:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C416E2620CC;
	Fri, 28 Feb 2025 11:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="nKefsDd7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [94.124.121.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316D3260372
	for <linux-iio@vger.kernel.org>; Fri, 28 Feb 2025 11:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740743854; cv=none; b=YrIe+ENBHdGxOIxVpC5tbf3JSTfkfTb6w1WtJSyKLg+sH+fBFfqb7ZkQKts1wxY1GRZFAn6C3hpqG3A7abu0MUJEo9cKC8ugAykxBF0M9T3piKwjd+0qsVPJqtQGIYV8WEACHpaUzjTWwCVXxu1MF7t7l8eQzxGa46w84tY9io4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740743854; c=relaxed/simple;
	bh=RvFAS78f+99HBNR6SzbLni87srDvuljh18ChZseS+KU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UupCjvCvHhX4A339sSBtBQzWJtf6fi9id7NF/ufTHJyoPyqHv6tJcWAOXOHMRUrwuNtGZZeKG+8hJkwQesWkGG2ks/5KqIVRTFkOSlHwgf5DBJ56h2xvW3S4hQWZfUvehPoVDrszyLvr9zuUzctTC5yRqVEf5n9TKENpcNMqn8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=nKefsDd7; arc=none smtp.client-ip=94.124.121.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=vRFSBkesq/C2LJZo8naM/Q1cNr1mZmsYkaQzEjX9zhk=;
	b=nKefsDd72p1gTkAq1a7G+hEFjAE5L6lgg8cegGBpZQQzWMszwhaWsbIajEMPMzlnWkeWbY9NztDg9
	 O+Js9zCsksKfw3Jnfdq4tpLC0VPA7dkeYSco4yWWhISm0kav1YSNJJIygduSKWjmKZHQhk9t2ax9IN
	 OToCnnLTchBVZnQ0ZkRqaAWze2pWs4aVEYK4pZ5hrPzUQaRoHocx5w/hFB+5SoDf8caOUN6RkzT/+J
	 06/v612F7A3E9BKf0U4Eo5HnR0KWHNl8hSDeya5zZNzjuNs7ncmY7rkFC8UIk95t8wBnJQ0Jk27SN9
	 XeeIcsCmpFEcDwhwcTvgNzcPyzq6oMg==
X-MSG-ID: 2e5f1d48-f5cb-11ef-b5ca-0050568164d1
Date: Fri, 28 Feb 2025 12:57:27 +0100
From: David Jander <david@protonic.nl>
To: Pavel Pisa <ppisa@pikron.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Nuno Sa
 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>
Subject: Re: [RFC PATCH 0/7] Add Linux Motion Control subsystem
Message-ID: <20250228125727.7f892552@erd003.prtnl>
In-Reply-To: <202502281035.57489.ppisa@pikron.com>
References: <20250227162823.3585810-1-david@protonic.nl>
	<202502281035.57489.ppisa@pikron.com>
Organization: Protonic Holland
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Dear Pavel,

Thanks a lot for starting the discussion...

On Fri, 28 Feb 2025 10:35:57 +0100
Pavel Pisa <ppisa@pikron.com> wrote:

> Hello David and others
> 
> On Thursday 27 of February 2025 17:28:16 David Jander wrote:
> > Request for comments on: adding the Linux Motion Control subsystem to the
> > kernel.  
> 
> I have noticed on Phoronix, that the new system is emerging.

Being featured on Phoronix on day one wasn't on my bingo card for this year, to
be honest... :-)

> This is area where I have lot (more than 30 years) of experience
> at my company and I have done even lot with my studnets at university.
> I have big interest that this interface fits our use neeeds
> and offers for future integration of our already open-source
> systems/components.

This is very impressive and I am honored to have gotten your attention. I am
looking forward to discussing this, although I am not sure whether all of this
should happen here on LKML?

> This is preliminary reply, I want to find time for more discussion
> and analysis (which is quite hard during summer term where I have
> lot of teaching and even ongoing project now).
> 
> I would like to discuse even future subsystem evolution
> which would allow coordinates axes groups creation, smooth
> segments based on N-th order splines incremental attachment,
> the path planning and re-planning if the target changes
> as reaction to camera or other sensor needs etc.

Right now LMC should be able to support hardware that has multiple channels
(axes) per device. Its UAPI can describe position-based movements and
time-based movements along any arbitrary combination of those channels using a
pre-defined speed/acceleration profile.

The profiles can be specified as an arbitrary number of speed and acceleration
values. The idea is to describe a segmented profile with different
acceleration values for segments between two different speed values. Simple
examples are trapezoidal (accelerate from (near-)zero to Vmax with A1, and
decelerate from Vmax back to zero with D1), dual-slope or S-curve, but the
UAPI in theory permits an arbitrary number of segments if the underlying
hardware supports it.

I have some ideas for future extensions to the API that make coordinated
multi-channel movements a bit easier, but that will not be in the initial push
of LMC: For example torque-limit profiles for controlled torque movements,
usable for example in sliding door controllers with AC machines or BLDC
motors; or an ioctl to send a distance vector to a selected number of channels
at once and apply a motion profile to the whole coordinated movement. In the
current version you have to set up the distances and profiles for the
individual channels and then trigger the start of the motion, which is more
cumbersome. You can already use the finish event of a preceding motion to
trigger the next one though.

Another idea that has been floating in my head is to make a "virtual" motion
device driver that combines individual "real" single-channel hardware drivers
into one multi-channel device, but I am unsure whether it is really needed. It
all depends on the latency limit differences between kernel-space and
user-space whether there is something to gain.

I think it is best to keep this initial version more limited in scope though,
as long as the needed extensions are possible in the future without breaking
existing UAPI.

So I propose: Let's craft a draft UAPI (in a different place, not on LKML) that
can do everything we can come up with and then reduce it to the basics for the
first version. Otherwise it will get too complex to review, I'm afraid.

> At this moment I have interrest if there is site which
> would start to collect these ideas and where can be
> some references added.

I may put this on github and create a wiki there if you think that's a good
enough place to discuss?

> I think that I have quite some stuff to offer.

That would be great! Looking forward to it :-)

> To have idea about my direction of thinking and needs
> of interface I would provide some references even
> to our often commercially sold but mostly conceived
> as hobby projects.

I'll have to take some time to look into those more closely. My own experience
as far as FOSS or OSHW concerns includes the reprap Kamaq project:

https://reprap.org/wiki/Kamaq

TL;DR: It is a 3D printer running only Linux and the whole controller software
is entirely written in python (except for very little Cython/C code).
This is still my 3D printer on which I satisfy all of my 3D print needs. I
will need to port it to LMC one day.

> Coordinated axes groups movement with incremental spline
> segment addition into command queue (our COORDMV componet
> of PXMC library) is demonstrated on old BOSCH SR 450 SCARA
> system. The robot has never fully worked at Skoda Auto
> with original BOSH control unit. But when it has been donated
> to Czech Technical University, we have build control
> unit at my copany based on Motorola 68376 MCU in around
> 2000 year. I have later paid one student to prepare
> demo in Python to demonstrate the system.
> 
> You can click on video
> 
>   MARS 8 BigBot and Robot Bosch SR 450 Drawing Roses 
>   http://pikron.com/pages/products/motion_control.html

Very impressive! Can you explain how the spline-segment information could be
conveyed to the controller? Does the controller really do an infinitesimal
spline interpolation, or does it create many small linear vectors?

LMC will try to limit math operations in kernel space as much as possible, so
hopefully all the calculations can be done in user-space (or on the controller
if that is the case).

Right now, my way of thinking was that of regular 3D printers which usually
only implement G0/G1 G-codes (linear interpolation). G2/G3 (circular
interpolation) doesn't sound practically very useful since it is special but
not very flexible. Something like generalized spline interpolation sounds more
valuable, but I hadn't seen any hardware that can do it.

> The related python application is there
> 
>   https://github.com/cvut/pyrocon
> 
> In the far future, I can imagine that it can connect
> to proposed LMC API and achieve the same results.

Let's make it so!

>[...]
> which uses our PXMC motion control library
> 
>   https://gitlab.com/pikron/sw-base/pxmc
> 
> There is basic documentation for it on its site
> 
>   https://pxmc.org/
>   https://pxmc.org/files/pxmc.pdf

At first glance, this looks like a piece of hardware that would fit as a LMC
device. What needs to be determined is where the boundaries lie between
controller firmware, kernel-space and user-space code.

Generally speaking, as a rough guideline, microsecond work is better done in
the controller firmware if possible. millisecond work can be done in the kernel
and 10's or more millisecond work can be done in user-space, notwithstanding
latency limit requirements of course.

>[...]
> So in general, I think that we have large portfolio
> of building blocks which would allow to build motion,
> robotic controllers, communications etc. and I would be happy
> if they are reused and even some project conceived
> together with others to join the forces.

This sounds very interesting. Ideally one would end up with LMC capable of
interfacing all of those devices.

> It would be ideal if the all motion control related
> resources and links could be somehow collected
> that wheel is not reinvented unnecessarily.

I completely agree.

> The most of my code is Mozilla, GPL etc... I have
> right to relicence my company stuff if the license does
> not fit. On the other hand, I do not intend to follow
> such offers as of one well funded chip related association,
> which offered us to relicense all to them with no retain
> of any control and additional right and they would not
> take care about the valuable project at all no looking
> for funding etc... no promise for developmet etc...
> So there are some limits.

Understandable.

Best regards,

-- 
David Jander

