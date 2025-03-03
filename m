Return-Path: <linux-iio+bounces-16256-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64197A4BD55
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 12:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90601898E24
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 11:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646621F3FE4;
	Mon,  3 Mar 2025 11:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pikron.com header.i=@pikron.com header.b="fkw75lrZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx-8.mail.web4u.cz (smtp7.web4u.cz [81.91.87.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5001EDA37;
	Mon,  3 Mar 2025 11:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.91.87.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999694; cv=none; b=J/W7F8yByk27nAiMUxvnwDX5OnnzC2LGkFnvWvS6YYobjjGFPfrz9fOaecSbNLq/0UTMXYd6pyUh6L/SfGCY9PbHlTHxEqYFSxxNbSBsbcEBYDpN7JiAeQAgNalWDJ9+b2M+Go55U3X+nqBfLqFsaKCXLgQiaW8qeFi2MN/8U0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999694; c=relaxed/simple;
	bh=rp41BOFtQ7C7me3CYdJaPDZTzEvF2oNKglulTnCRJf0=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Content-Type:Content-Disposition:Message-Id; b=Xdk4AVwxvcPE0BvRgZ4ewp87sT55lN82UrcElY6tYGAC8OUZqE3TXbSd5mVen/kfwtDIOGrNdP2bkUk+xcapYznqbO1zr23NcbmIFQuc85XKZ5eppt6CHToZrFExoDR/1ig60bPsXRW1vLWgLWeSU4FWTPjuJTG/f+FEZ0Z7QK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pikron.com; spf=pass smtp.mailfrom=pikron.com; dkim=pass (2048-bit key) header.d=pikron.com header.i=@pikron.com header.b=fkw75lrZ; arc=none smtp.client-ip=81.91.87.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pikron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pikron.com
Received: from mx-8.mail.web4u.cz (localhost [127.0.0.1])
	by mx-8.mail.web4u.cz (Postfix) with ESMTP id 4399E200E91;
	Mon,  3 Mar 2025 12:01:17 +0100 (CET)
Received: from baree.pikron.com (unknown [84.242.78.234])
	(Authenticated sender: ppisa@pikron.com)
	by mx-8.mail.web4u.cz (Postfix) with ESMTPA id BD8C7200B79;
	Mon,  3 Mar 2025 12:01:16 +0100 (CET)
From: Pavel Pisa <ppisa@pikron.com>
Organization: PiKRON Ltd.
To: David Jander <david@protonic.nl>
Subject: Re: [RFC PATCH 1/7] drivers: Add motion control subsystem
Date: Mon, 3 Mar 2025 12:01:33 +0100
User-Agent: KMail/1.9.10
Cc: David Lechner <dlechner@baylibre.com>,
 linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org,
 Nuno Sa <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Carsten Emde <c.emde@osadl.org>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Pavel Machek <pavel@ucw.cz>
References: <20250227162823.3585810-1-david@protonic.nl> <7fb93572-3ef4-47f2-b505-669af742dee5@baylibre.com> <20250303093611.325b4fb6@erd003.prtnl>
In-Reply-To: <20250303093611.325b4fb6@erd003.prtnl>
X-KMail-QuotePrefix: > 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202503031201.33686.ppisa@pikron.com>
X-Pylter4U-dkim-type: user
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pikron.com;
	i=@pikron.com; q=dns/txt; s=w4u; t=1740999677; h=from : date : to :
	subject; bh=rp41BOFtQ7C7me3CYdJaPDZTzEvF2oNKglulTnCRJf0=;
	b=fkw75lrZqGMof2+pt7nRzKQOuM2FrXLo603MoXmpPOxXOemvPoBpWxdzI0RBII6oe6tJd
	5xR5biHF81yl2lycSLr+yq/uYvAUl6qpqvuz6/xokaaklfz5/KLgJHMhPn0ErWQlGHw9kyW
	PILfcYxCyvf7z7cDdKd1aiTr1WrSwGTZu6m9XW33qpOVpz4hDJ0agNeseE9oXuP7MJD2Cxx
	2FuaGGgGEX8SXdl3pMdYnIniOeEWItVESk9Cb1dQ6XH9Qu3MA19IW0UR2Zy3dF/jS1GxZ+s
	cHIo+mjfLArauWxNgklKjtvv+0AgbOpYqJUuWRuLSo9vt+OSFwY299fnkT9A==
X-W4U-Auth: 6d837edb5481f0a52c30bdd377b5c8816508d003

Hello Davids,

On Monday 03 of March 2025 09:36:11 David Jander wrote:
> On Fri, 28 Feb 2025 16:36:41 -0600
>
> David Lechner <dlechner@baylibre.com> wrote:
> > On 2/27/25 10:28 AM, David Jander wrote:
> > > The Linux Motion Control subsystem (LMC) is a new driver subsystem for
> > > peripheral devices that control mechanical motion in some form or
> > > another. This could be different kinds of motors (stepper, DC, AC, SRM,
> > > BLDC...) or even linear actuators.
> > > The subsystem presents a unified UAPI for those devices, based on char
> > > devices with ioctl's.
> > > It can make use of regular gpio's to function as trigger inputs, like
> > > end-stops, fixed position- or motion start triggers and also generate
> > > events not only to user-space but also to the IIO subsystem in the form
> > > of IIO triggers.
> > >
> > > Signed-off-by: David Jander <david@protonic.nl>
> > > ---
> > >  MAINTAINERS                     |   8 +
> > >  drivers/Kconfig                 |   2 +
> > >  drivers/Makefile                |   2 +
> > >  drivers/motion/Kconfig          |  19 +
> > >  drivers/motion/Makefile         |   3 +
> > >  drivers/motion/motion-core.c    | 823 ++++++++++++++++++++++++++++++++
> > >  drivers/motion/motion-core.h    | 172 +++++++
> > >  drivers/motion/motion-helpers.c | 590 +++++++++++++++++++++++
> > >  drivers/motion/motion-helpers.h |  23 +
> > >  include/uapi/linux/motion.h     | 229 +++++++++
> > >  10 files changed, 1871 insertions(+)
> >
> > Ooof, this is really a lot for one patch. Makes it hard to review. 500
> > lines in a patch is much easier to digest.
>
> Sorry for that. I wouldn't know how to split up this patch to make it any
> easier. It's just a complete new subsystem, and I think it is the bare
> minimum to start and also to give a good idea of what it is supposed to be
> able to do.
>
> > But before commenting on the details of the code I have some more
> > high-level comments. As I mentioned in my reply to the cover letter, I've
> > gone through the exercise of writing some motor control divers in the
> > Linux kernel that have been used by 1000s of people that used them to
> > build everything imaginable using LEGO robotics over the last 10+ years.
> >
> > From what I see here (I didn't have time to really get into the details
> > of it yet, so maybe missed some important details), it looks like you are
> > trying to do motor control stuff in the kernel so that the interface for
> > a basic H-bridge will be close to the same as a fancy stepper motor
> > controller. We tried doing something very similar because it sounds like
> > a really nice thing to do. The kernel does everything and makes it really
> > easy for the users. But what we actually found is that it is not possible
> > to make a solution in the kernel that can handle every possible use case.
> > In the end, we wished that we had a much more low-level interface to the
> > motor controllers to give us more flexibility for the many different
> > types of applications this ended up getting used for. Having to modify
> > the kernel for your use case is too high of a bar for most users and not
> > practical even if you are a kernel hacker.
>
> The idea for LMC is to be able to support hardware that realistically can
> be used by an OS as complex as the Linux kernel. There are a lot of motor
> controllers out there that suit that category, like the TMC5240 chip for
> example. But also many bigger systems, like the ones Pavel Pisa works with.
> That said, I think the Linux kernel on modestly modern SoC's, like the
> STM32MP1xx is pretty capable of doing more than that, but we have to draw
> the line somewhere. Like I hinted in the cover letter, I think it might
> even be possible to do crazy stuff like bit-banging STEP/DIR type
> controllers in the kernel, possibly aided by PREEMPT_RT, but that is not
> the main purpose of LMC.

I look even to take into account these options for the hobbyist projects.
But stepper motors drivers step, dir interface is really demanding
case. With microstepping it can require pulse control with frequency
100 kHz or even MHz and corresponding jitter demand. So that is really
not area for PREEMPT_RT in userspace nor kernel space.

On the other hand, I can imagine that some SoftMAC like controller
for Raspberry Pi 1 to 4 to combine its specific DMA and GPIO
capabilities could be good target for some LMC like abstraction.
Doing DMA from userspace is pain for regular users, yes we use
that for Marek Peca's Zlogan https://github.com/eltvor/zlogan
and other projects, but that is not for users which I see
between our studnets to attempt to stepper motors by step, dir
from RPi without previous RT knowledge. The question is if the
API to RPi and its DMA should be covered by kernel LMC
or some more generic DMA interface.

I have found some links for students working on the
project (it is project led by my colleagues not mine,

  https://github.com/hzeller/rpi-gpio-dma-demo

  https://github.com/innot/AdvPiStepper

  https://github.com/richardghirst/PiBits/tree/master/ServoBlaster

I would be happy for pointers for alive and newwer project
if somebody has some more links for these kind of users.

I prefer other approaches myself, i.e. small RTOS based
solution with background and IRQ tasks and D/Q control
where the risk to lose step is much smaller, because you
control at sin, cos level, so you have more time at high
speeds where current control is not realized on these MHz
periods required by dumb step, dir driver with microstepping.
Se my previously reported project SaMoCon project for
idea. It has four outputs per each axis and can drive
PMSM, DC, stepper etc... 

  https://gitlab.fel.cvut.cz/otrees/motion/samocon

The PID or even D-Q DC, PMSM and may it be stepper
motors at something like 5 kHz is achievable
in userspace or kernel RT_REEMPT therad. May it be
even with commutation for stepper, but 20 kHz
is probably only for kernel and not for professional
use according to my taste. If the commutation
is pushed even to small FPGA, then some interface
as NuttX FOC

  https://nuttx.apache.org/docs/12.1.0/components/drivers/character/foc.html

is good match and yes, proposed LMC pushes much more
complexity into the kernel. 

But for these people who want to stuck on step, dir
because it is like that should be done in 3D printers
and other hobbits world could profit a lot from
some segments list controlled motion and I can image
to combine it with that RPi or some simple FPGA
block on Zynq, Beagle or iCE40 connected to SPI.

So I see value of some unification under LMC  

> The main purpose is to talk to controllers that 
> can receive motion profiles and execute movements (semi-)autonomously.
> Going just one step lower is the simple PWM based driver in this patch set:
> It takes the execution of the profile into the kernel by using a HRTIMER to
> sample the profile curve using a sample period of 20ms, which is fast
> enough for most applications while not imposing a high CPU load on the
> kernel on slower CPU cores.
> motion-helper.c contains the trapezoidal ramp generator code that can be
> used by any LMC driver that can work with speed information but doesn't
> have its own ramp generator in hardware. It could be extended to support
> other type of profiles if needed in the future, which would automatically
> upgrade all drivers that use it.

I agree, but on the other hand, the optimal combination of HW and matching 
upper abstraction level is extremely variable, and finding a good API for 
LMC, which would not be a root to stumble upon in the future, is a really 
demanding task. On the other hand, if some, even suboptimal, solution is 
available in staging drivers kernel area without guarantee of having fixed 
API forever, then it can evolve slowly to something valuable. There would be 
incompatible changes, but the transition can be smooth. 

So may it be some COMEDI like approach. And there should be matching
userspace library which could choose between APIs at different level
of abstraction according to the target HW and some these APIs can
be emulated by SoftMAC approach in the kernel. Usually for there
more hobbits like solutions.

I would personally tend to something like our PXMC at these API
level but I am predetermined/skewed as author and its 25 years
use and connection to older assembly API with more than 30 years
history.

But I hope I am critical enough to be able to say what is problematic
on our design and what can be designed better today. I.e. there
is compromise to keep all positions 32 bits, sometimes even
reduced to allows IRC sensors position subdivision on ramps
generators side, some there is often range reduced to +/-2^23
bits. On the other hand, all is computed in modulo arithmetic,
so there is no problem to control speed for infinite time...
For very precise and slow syringe piston control in infusion
systems, we have used 32 bits position where 8 bits have been
fractions and in generators another short extended fractions
to 24 bits. It has been able to run with this precision
even on 16-bit MSP430. But if that is ported and used in our
solutions on 32-bit ARMs or even 64-bit chips like PoalFire,
then it loses purpose... So it would worth to reinvent/redefine
APIs...

But I would tend to this userspace lib and multiple API levels
approach... 

> > When writing kernel drivers for this sort of thing, I think the rule of
> > thumb should be to keep the driver as "thin" as possible. If the hardware
> > doesn't provide a feature, the kernel should not be trying to emulate it.
>
> In general I would agree with this, but in this case some limited
> "emulation" seems adequate. As a rule of thumb, code is better placed in an
> FPGA/uC, the kernel or in user-space according to its latency requirements.
> Microsecond stuff shouldn't be done on the application SoC at all,

Sure

> millisecond stuff (or maybe 100s of microseconds if you like) can be done
> in the kernel, 10s of milliseconds or slower is good for user-space. A very
> general guideline.

I would be open to higher frequencies in userspace with PREEMPT_RT
on Zynq, iMX6,7,8,9 or AM3,4,... industrial targetting hardware.
We have run complex Simulik generated models on x86 at 30 kHz
many years ago without missing code. But with our Simulink RT
target https://github.com/aa4cc/ert_linux not with Mathwork's
offer. But even serious, rich company came to us to solve their
problems on RPi with CAN controller on SPI with sticking
on Mathwork's delivered Windows supported target and it has been
problem

https://dspace.cvut.cz/bitstream/handle/10467/68605/F3-DP-2017-Prudek-Martin-Dp_2017_prudek_martin.pdf

So if we speak about enthusiasts with common x86 without
SMI interrupt checking before buying the motherboard or even
attempting to use laptops or sticking on Raspberry Pi where
some versions have used FIQ to solve HW deficiencies, then
I would agree to stay even with PREEMP_RT on safe side
i.e. under 1 kHz... 

> So if you have a device that can take a speed-setpoint but doesn't have a
> ramp generator, that is not a device that LMC is made for in the first
> place, but still pretty usable if we do the ramp generator in the kernel.
> To steal Pavel's analogy: Think of the TMC5240 driver as a FullMAC Wifi
> device and the simple PWM driver as a SoftMAC Wifi device.
> For an LMC device, same as for a wifi interface, we want to talk TCP/IP to
> it from user-space, not radio-packets. ;-)

Somebody mentioned to me ASICy Nova MCX314 or NPM PCD4541
as reaction to my discussion, I am not sure about their API,
but may it be some segmented API with fast, guaranteed,
IRQ driven switch/preparation of next segment would support
for LMC API.

> > So for an
> > H-bridge I would want something that just provides a way to tell it I
> > want fast-decay mode with some normalized duty cycle between -1 and 1
> > (obviously we will have to multiply this by some factor since the kernel
> > doesn't do floating point). A duty cycle of 0 will "brake" the motor. And
> > then we would need one more control parameter to tell it to remove power
> > completely to "coast" the motor. I guess this is what the "basic_run" and
> > "basic_stop" are other than the run seems to have speed instead of duty
> > cycle? The kernel shouldn't be trying to convert this duty cycle to speed
> > or have a background task that tries to provide an acceleration profile
> > or turn off the power after some time. Just let the kernel provide
> > direct, low-level access to the hardware and let userspace handle all of
> > the rest in a way that makes the most sense for the specific application.
> > Sometimes they might not even be connected to a motor! With the LEGO
> > MINDSTORMS and BeableBone Blue, the H-bridge outputs are hot-pluggable,
> > so they can even be connected to things like LEDs or used as a general
> > power supply. (A reason to call this subsystem "actuation" rather than
> > "motion".)
>
> LMC aims to offer a common interface to different sorts of motion devices
> (think different types of motors), so offering access to the lowest level
> of each device is kinda defeating of that purpose. Nevertheless, all of the
> things you mention are possible with LMC. The relationship between speed
> and the PWM duty-cycle of a simple DC motor H-bridge for example, is
> determined by the speed_conv* and accel_conv* parameters. If you want a 1:1
> relation, just make them 1 in your device tree.

But you need full PID or even current D-Q multiple PI and procession,
sines, cosines for commutation etc. to connect higher level with lower
level. We have all these in fixed point and focused on processing
not only in RTOSes kernel but even in IRQs. So it can be done
in Linux kernel as we ported, demonstrated it in GNU/Linux userspace...

> OTOH, if you had only a duty-cycle setting from user-space, you would need
> to have code that generates an acceleration profile in user-space, which
> would be a much higher CPU load and have a much higher latency jitter, much
> more likely to cause mechanical and audible effects than if done in the
> kernel. It's still possible though.
> And talking about mis-using a motor driver for something else, that's
> exactly what one of our customers is doing with a DC motor H-bridge via
> LMC. They just set each output to 0% or 100% duty-cycle (max speed without
> profile) to control 2 warning lights.
>
> > Another way of putting this is that it was very tempting to model the
> > actual motor in the kernel. But that didn't work well because there are
> > so many different kinds of motors and related mechanical systems that you
> > can connect to the same motor driver chip.
>
> Yes, but on the other side, you have many different driver chips that all
> control motors that do the same thing: move in different directions with
> different speeds and different acceleration profiles. As a user, I want to
> be able to tell that to the motor in the same sense as I want to send a
> data through an ethernet interface without having to know what kind of
> interface I have to an extend reasonably possible. Of course each
> motor/driver has different limitations (just as different network
> interfaces have), and more often than not I will have to know some of those
> in user-space, but the whole idea of a subsystem UAPI is to abstract as
> much as possible of that from user-space.
>
> With LMC I could easily swap a stepper motor for a BLDC or DC motor for
> example. If they have an encoder to provide accurate position feedback, it
> could even work as well as a stepper for many applications. No changes in
> user-space code required.
>
> > So the driver really should just be for the
> > H-bridge chip itself and not care about the motor. And the rest can be
> > put in a libmotion userspace library and have that be the convenient API
> > for users that want to get something up and running quickly.
>
> I get your point, and from the standpoint of Lego hardware and hobby
> tinkerers doing all sorts of stuff with it, I can understand the desire to
> have low-level access from user-space to the H-bridge. It is similar to how
> Raspberry-pi exposes direct access to their GPIO controllers to user-space.
> It is nice for tinkerers, but it is inadequate for anything else, not to
> mention potentially unsafe. I remember when I first installed Linux on my
> PC in 1994, we had the X server access the video card directly from
> user-space. That was a really bad idea. ;-)

It is questionable, some solution where kernel is RT, allows fast delivery
of data and events between kernel and userspace memory contexts,
like IO-uring and DRI, shared memory, PRIME buffers etc. is often
better than push of all into kernel. In the fact, today lot of graphic
stack is pushed directly into applications through acceleration API
libraries which talks directly with allocated context in GPUs
and the result is combined by compositor, again in userspace.

So this is not so convicing argument. But SoftMAC and 802.11
is the case which supports push of more levels of LMC
into kernel.

Anyway, the motion control is really broad area, there are companies
with experience with Linux in their highest range of CNC machines,
laser cutters, welding robots etc... So there is lot of prior
experience. Question is, how much they are willing to share.

But preparing some common guidelines and collect information
to not reinvent wheel again and again and then proposing
some more generally reusable APIs and drivers etc. would be
great win for all and would make GNU/Linux much easier
and cheaper usable in the are in future.

So my actual vote is to find location where the already
available knowledge and projects could be collected
and where input even from PREEMP_RT and other professionals
can be obtained...

May it be somebody from LinuxCNC should step in and may it
be there are such resources collected. Linux Foundation
or similar body should be contacted to check if such
project is already there. I am adding some PREEMP_RT
experts which I am in contact with, if they have idea
about right place for motion control on Linux discussion,
coordination.

Best wishes,

                Pavel
-
                Pavel Pisa

    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    company:    https://pikron.com/ PiKRON s.r.o.
    Kankovskeho 1235, 182 00 Praha 8, Czech Republic
    projects:   https://www.openhub.net/accounts/ppisa
    social:     https://social.kernel.org/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    RISC-V education: https://comparch.edu.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home

