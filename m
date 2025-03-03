Return-Path: <linux-iio+bounces-16253-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C836A4B978
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 09:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8823D188CDDE
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 08:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4511EBFF7;
	Mon,  3 Mar 2025 08:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="WRach1XS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [94.124.121.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F6B1EB1BC
	for <linux-iio@vger.kernel.org>; Mon,  3 Mar 2025 08:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740990977; cv=none; b=bb8ZXoiRvs6exUusJKaWgMwcuzZD0tWVjhgmc4kymexOn2a9HzgST05fBQATl8TqJKKcyksYi209aX9vQVrlDzNz9xRE1dTgG0YjuWECs6DsxRwh/f4jWtuNtYwurRKGvQR00bm/PZeC/9+IQVpNbQ8diUEkraBGPGr8p3FWj4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740990977; c=relaxed/simple;
	bh=d1NYIkne731OE+4CRC6V4DUzMRnaaze2xrbzMMdG9Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TkztX9qyrLPLjrYgekC6F66fnvE3JywqUQfpQgZjyD6+IRK4ecF0oopIBWE5eQJDnyO8MqKW8ChaOhkk+rf7lBRHwVNYi2Nqu9SF68OHXCw1dM9sBUt00TiHO4Vk7UBegdWRubZT7MiGJmnfqqEbP+MtFuenFL1IUc6WDpJ9NLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=WRach1XS; arc=none smtp.client-ip=94.124.121.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=2/+XCEqvmukm9RwANq8BW3npMw0J+xX5amPy/WbdtVI=;
	b=WRach1XSFtAcDjazCArngNMW2cyrFOxXScIWFWWOdINqmaeWJan4lFn1LNjjIyXTpZq9065FqsLoP
	 +3itXZg8TJNqKfcXBnyDpumogBIoLOWnUbLWnirBnZzp0TpMQAmee2VLOmbe/mLSg3gA4mkwCdi+Xc
	 uY1xXfdpkFEll65qv87FM8/ltc8KARzlbgBXXcp4/G0fYNyDLrvL7Rtbyi9l2zrcltZf3GIS+qdDJX
	 bDLMv2sioDSzuZuV+zCX63FqdXkfHiIl7Xtbzlzd8QjbyjW9KfLuNPQd5iBWjo1WN3aKdaG54sCSdm
	 tBzPTtcvU5iGKGE4cMcCg0zAtYKbEdw==
X-MSG-ID: 8fdfc9e4-f80a-11ef-8b46-005056817704
Date: Mon, 3 Mar 2025 09:36:11 +0100
From: David Jander <david@protonic.nl>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Nuno Sa
 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Pavel Pisa <ppisa@pikron.com>
Subject: Re: [RFC PATCH 1/7] drivers: Add motion control subsystem
Message-ID: <20250303093611.325b4fb6@erd003.prtnl>
In-Reply-To: <7fb93572-3ef4-47f2-b505-669af742dee5@baylibre.com>
References: <20250227162823.3585810-1-david@protonic.nl>
	<20250227162823.3585810-2-david@protonic.nl>
	<7fb93572-3ef4-47f2-b505-669af742dee5@baylibre.com>
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

On Fri, 28 Feb 2025 16:36:41 -0600
David Lechner <dlechner@baylibre.com> wrote:

> On 2/27/25 10:28 AM, David Jander wrote:
> > The Linux Motion Control subsystem (LMC) is a new driver subsystem for
> > peripheral devices that control mechanical motion in some form or another.
> > This could be different kinds of motors (stepper, DC, AC, SRM, BLDC...)
> > or even linear actuators.
> > The subsystem presents a unified UAPI for those devices, based on char
> > devices with ioctl's.
> > It can make use of regular gpio's to function as trigger inputs, like
> > end-stops, fixed position- or motion start triggers and also generate
> > events not only to user-space but also to the IIO subsystem in the form of
> > IIO triggers.
> > 
> > Signed-off-by: David Jander <david@protonic.nl>
> > ---
> >  MAINTAINERS                     |   8 +
> >  drivers/Kconfig                 |   2 +
> >  drivers/Makefile                |   2 +
> >  drivers/motion/Kconfig          |  19 +
> >  drivers/motion/Makefile         |   3 +
> >  drivers/motion/motion-core.c    | 823 ++++++++++++++++++++++++++++++++
> >  drivers/motion/motion-core.h    | 172 +++++++
> >  drivers/motion/motion-helpers.c | 590 +++++++++++++++++++++++
> >  drivers/motion/motion-helpers.h |  23 +
> >  include/uapi/linux/motion.h     | 229 +++++++++
> >  10 files changed, 1871 insertions(+)  
> 
> Ooof, this is really a lot for one patch. Makes it hard to review. 500 lines in
> a patch is much easier to digest.

Sorry for that. I wouldn't know how to split up this patch to make it any
easier. It's just a complete new subsystem, and I think it is the bare minimum
to start and also to give a good idea of what it is supposed to be able to do.

> But before commenting on the details of the code I have some more high-level
> comments. As I mentioned in my reply to the cover letter, I've gone through the
> exercise of writing some motor control divers in the Linux kernel that have been
> used by 1000s of people that used them to build everything imaginable using LEGO
> robotics over the last 10+ years.
> 
> From what I see here (I didn't have time to really get into the details of it
> yet, so maybe missed some important details), it looks like you are trying to
> do motor control stuff in the kernel so that the interface for a basic H-bridge
> will be close to the same as a fancy stepper motor controller. We tried doing
> something very similar because it sounds like a really nice thing to do. The
> kernel does everything and makes it really easy for the users. But what we
> actually found is that it is not possible to make a solution in the kernel that
> can handle every possible use case. In the end, we wished that we had a much
> more low-level interface to the motor controllers to give us more flexibility
> for the many different types of applications this ended up getting used for.
> Having to modify the kernel for your use case is too high of a bar for most
> users and not practical even if you are a kernel hacker.

The idea for LMC is to be able to support hardware that realistically can be
used by an OS as complex as the Linux kernel. There are a lot of motor
controllers out there that suit that category, like the TMC5240 chip for
example. But also many bigger systems, like the ones Pavel Pisa works with.
That said, I think the Linux kernel on modestly modern SoC's, like the
STM32MP1xx is pretty capable of doing more than that, but we have to draw the
line somewhere. Like I hinted in the cover letter, I think it might even be
possible to do crazy stuff like bit-banging STEP/DIR type controllers in the
kernel, possibly aided by PREEMPT_RT, but that is not the main purpose of LMC.
The main purpose is to talk to controllers that can receive motion profiles
and execute movements (semi-)autonomously. Going just one step lower is the
simple PWM based driver in this patch set: It takes the execution of the
profile into the kernel by using a HRTIMER to sample the profile curve using a
sample period of 20ms, which is fast enough for most applications while not
imposing a high CPU load on the kernel on slower CPU cores.
motion-helper.c contains the trapezoidal ramp generator code that can be used
by any LMC driver that can work with speed information but doesn't have its
own ramp generator in hardware. It could be extended to support other type of
profiles if needed in the future, which would automatically upgrade all
drivers that use it.

> When writing kernel drivers for this sort of thing, I think the rule of thumb
> should be to keep the driver as "thin" as possible. If the hardware doesn't
> provide a feature, the kernel should not be trying to emulate it.

In general I would agree with this, but in this case some limited "emulation"
seems adequate. As a rule of thumb, code is better placed in an FPGA/uC, the
kernel or in user-space according to its latency requirements. Microsecond
stuff shouldn't be done on the application SoC at all, millisecond stuff (or
maybe 100s of microseconds if you like) can be done in the kernel, 10s of
milliseconds or slower is good for user-space. A very general guideline.

So if you have a device that can take a speed-setpoint but doesn't have a
ramp generator, that is not a device that LMC is made for in the first place,
but still pretty usable if we do the ramp generator in the kernel.
To steal Pavel's analogy: Think of the TMC5240 driver as a FullMAC Wifi device
and the simple PWM driver as a SoftMAC Wifi device.
For an LMC device, same as for a wifi interface, we want to talk TCP/IP to it
from user-space, not radio-packets. ;-)

> So for an
> H-bridge I would want something that just provides a way to tell it I want
> fast-decay mode with some normalized duty cycle between -1 and 1 (obviously we
> will have to multiply this by some factor since the kernel doesn't do floating
> point). A duty cycle of 0 will "brake" the motor. And then we would need one
> more control parameter to tell it to remove power completely to "coast" the
> motor. I guess this is what the "basic_run" and "basic_stop" are other than
> the run seems to have speed instead of duty cycle? The kernel shouldn't be
> trying to convert this duty cycle to speed or have a background task that tries
> to provide an acceleration profile or turn off the power after some time. Just
> let the kernel provide direct, low-level access to the hardware and let
> userspace handle all of the rest in a way that makes the most sense for the
> specific application. Sometimes they might not even be connected to a motor!
> With the LEGO MINDSTORMS and BeableBone Blue, the H-bridge outputs are
> hot-pluggable, so they can even be connected to things like LEDs or used as a
> general power supply. (A reason to call this subsystem "actuation" rather than
> "motion".)

LMC aims to offer a common interface to different sorts of motion devices
(think different types of motors), so offering access to the lowest level of
each device is kinda defeating of that purpose. Nevertheless, all of the
things you mention are possible with LMC. The relationship between speed and
the PWM duty-cycle of a simple DC motor H-bridge for example, is determined by
the speed_conv* and accel_conv* parameters. If you want a 1:1 relation, just
make them 1 in your device tree.
OTOH, if you had only a duty-cycle setting from user-space, you would need to
have code that generates an acceleration profile in user-space, which would be
a much higher CPU load and have a much higher latency jitter, much more likely
to cause mechanical and audible effects than if done in the kernel.
It's still possible though.
And talking about mis-using a motor driver for something else, that's exactly
what one of our customers is doing with a DC motor H-bridge via LMC. They just
set each output to 0% or 100% duty-cycle (max speed without profile) to control
2 warning lights.

> Another way of putting this is that it was very tempting to model the actual
> motor in the kernel. But that didn't work well because there are so many
> different kinds of motors and related mechanical systems that you can connect
> to the same motor driver chip.

Yes, but on the other side, you have many different driver chips that all
control motors that do the same thing: move in different directions with
different speeds and different acceleration profiles. As a user, I want to be
able to tell that to the motor in the same sense as I want to send a data
through an ethernet interface without having to know what kind of interface I
have to an extend reasonably possible. Of course each motor/driver has
different limitations (just as different network interfaces have), and more
often than not I will have to know some of those in user-space, but the whole
idea of a subsystem UAPI is to abstract as much as possible of that from
user-space.

With LMC I could easily swap a stepper motor for a BLDC or DC motor for
example. If they have an encoder to provide accurate position feedback, it
could even work as well as a stepper for many applications. No changes in
user-space code required.

> So the driver really should just be for the
> H-bridge chip itself and not care about the motor. And the rest can be put in
> a libmotion userspace library and have that be the convenient API for users
> that want to get something up and running quickly.

I get your point, and from the standpoint of Lego hardware and hobby tinkerers
doing all sorts of stuff with it, I can understand the desire to have
low-level access from user-space to the H-bridge. It is similar to how
Raspberry-pi exposes direct access to their GPIO controllers to user-space. It
is nice for tinkerers, but it is inadequate for anything else, not to mention
potentially unsafe. I remember when I first installed Linux on my PC in 1994,
we had the X server access the video card directly from user-space. That was a
really bad idea. ;-)

Best regards,

-- 
David Jander

