Return-Path: <linux-iio+bounces-16254-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B810A4BCD4
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 11:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41AF93A784F
	for <lists+linux-iio@lfdr.de>; Mon,  3 Mar 2025 10:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223651F4603;
	Mon,  3 Mar 2025 10:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="FAgTM+AD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp15.bhosted.nl (smtp15.bhosted.nl [94.124.121.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058B31F4192
	for <linux-iio@vger.kernel.org>; Mon,  3 Mar 2025 10:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998722; cv=none; b=ohrwbJq5hkodEHTlCF41i5bQIqQcjVCKukMLDjk9rV2sd0mMuhcdyxMIIuxAm0XKWybZqKJtnd/QMmnjRDx68EVKaHULT4ufry+WgyRnaOI/kZkJXIDUOnbDYVSORMAnIFEeoWvhIDqMEN5Nr6XSrUUJdUJAH07sfrypMR3CyO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998722; c=relaxed/simple;
	bh=pynGxo4XXmEs7yOlWDF8XBGKq+XhR05TaEZa28BkT+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mays6S/bdPQHKrZ3F2ATBWEGPSthzXAsSQPGF6JOeOZV1hwJmo3W1blLVYteVTFFn6kOlpkAK1Pi32M2CSmKbmMpztwFobncl306L6COalnDDvcOZz5GQhDbr46mVuSjuqD04IuiEDy3pfCQ15RhFsee3qt72gglXWy4u5s0GA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=FAgTM+AD; arc=none smtp.client-ip=94.124.121.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=Qv3LQFoyzeVaS+B1CyxR62OcrtYUFb1G+ImO7n/MAEM=;
	b=FAgTM+AD9/uZHGNzyeo7ropgMTrjWuN6tajamIaeZY+HqtdOIyS+14xZKDu1CbAjgTJ9A4vSlZRf+
	 4dYG6I5yt9Lc9EyKXpxRVGyHnNFMtF3WUs64UxqLwu3pOIJeRl4Me1PqvwXycuDZbv0by7iLAxXH4T
	 NEzGyOH4mSc2LNFO0bW+P/5WGzse69Rqrf7HVKug/tzKQmMG2Sr3QXaNAp6MM5o1so3Kfl/s14mCEd
	 7PRM+vKtUU7iWa831fLLt4vpZiCCyY6pm8kNbwM1RwhF9RUI3eqMTNjhaDGsRDkxvM6b3DRPYqZEkP
	 v40bH4XPP2GK8tC2PZc0K92PvO9TmfA==
X-MSG-ID: 93bddd82-f81c-11ef-a39b-00505681446f
Date: Mon, 3 Mar 2025 11:45:08 +0100
From: David Jander <david@protonic.nl>
To: Pavel Pisa <ppisa@pikron.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Nuno Sa
 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Carsten Emde <c.emde@osadl.org>
Subject: Re: [RFC PATCH 0/7] Add Linux Motion Control subsystem
Message-ID: <20250303114508.311c28f6@erd003.prtnl>
In-Reply-To: <202502281623.33695.ppisa@pikron.com>
References: <20250227162823.3585810-1-david@protonic.nl>
	<202502281035.57489.ppisa@pikron.com>
	<20250228125727.7f892552@erd003.prtnl>
	<202502281623.33695.ppisa@pikron.com>
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


Hi Pavel,

On Fri, 28 Feb 2025 16:23:33 +0100
Pavel Pisa <ppisa@pikron.com> wrote:

> Hello David,
> 
> On Friday 28 of February 2025 12:57:27 David Jander wrote:
> > Dear Pavel,
> >
> > Thanks a lot for starting the discussion...
> >
> > On Fri, 28 Feb 2025 10:35:57 +0100
> >
> > Pavel Pisa <ppisa@pikron.com> wrote:  
> > > Hello David and others
> > >
> > > On Thursday 27 of February 2025 17:28:16 David Jander wrote:  
> > > > Request for comments on: adding the Linux Motion Control subsystem to
> > > > the kernel.  
> > >
> > > I have noticed on Phoronix, that the new system is emerging.  
> >
> > Being featured on Phoronix on day one wasn't on my bingo card for this
> > year, to be honest... :-)
> >  
> > > This is area where I have lot (more than 30 years) of experience
> > > at my company and I have done even lot with my studnets at university.
> > > I have big interest that this interface fits our use neeeds
> > > and offers for future integration of our already open-source
> > > systems/components.  
> >
> > This is very impressive and I am honored to have gotten your attention. I
> > am looking forward to discussing this, although I am not sure whether all
> > of this should happen here on LKML?  
> 
> We should move somewhere else and invite people from Linux
> CNC etc...

I agree.

> GitHub project would work well if there is not some reluctance
> to commercially controlled and closed environment.

I am open to suggestions. I just happen to have a github account and also have
my code there:

https://github.com/yope/linux/tree/mainline-lmc-preparation

> Gitlab even in Gitlab.com case has option to move to own
> infrastructure in the future. We have Gitlab at university,
> companies I work with has Gitlab instances. But I think that
> we should stay on neutral ground.
> 
> The critical is some central hub where links to specific
> mailinglist etc. can be placed. May it be we can ask
> Linux foundation to provide wiki space for Linux Motion Control
> Subsystem same as it is for RT
> 
>   https://wiki.linuxfoundation.org/realtime/start
> 
> We can ask OSADL.org as likely neutral space...

That sounds really great. We were bronze members of OSADL, so maybe that's a
good idea. I see you added Carsten Emde in CC ;-)

> Or wiki at kernel.org, may it the most neutral...
> 
>  https://www.wiki.kernel.org/

Yes, that may be even a better place than OSADL.

> I am not in the core teams but may it be there on LKLM
> somebody would suggest the direction. I can ask people
> from OSADL, CIPS, RT projects etc. directly...
> 
> But I am not the authority and would be happy if somebody
> steers us.
> 
> To not load others, if there is no response then I suggest
> to limit followup e-mails only to linux-iio and those
> who already communicated in this thread.

Agree. This will probably be my last reply to this thread with LMKL in CC.

Is there anybody here willing to help with contact information?

> > > This is preliminary reply, I want to find time for more discussion
> > > and analysis (which is quite hard during summer term where I have
> > > lot of teaching and even ongoing project now).
> > >
> > > I would like to discuse even future subsystem evolution
> > > which would allow coordinates axes groups creation, smooth
> > > segments based on N-th order splines incremental attachment,
> > > the path planning and re-planning if the target changes
> > > as reaction to camera or other sensor needs etc.  
> >
> > Right now LMC should be able to support hardware that has multiple channels
> > (axes) per device. Its UAPI can describe position-based movements and
> > time-based movements along any arbitrary combination of those channels
> > using a pre-defined speed/acceleration profile.
> >
> > The profiles can be specified as an arbitrary number of speed and
> > acceleration values. The idea is to describe a segmented profile with
> > different acceleration values for segments between two different speed
> > values. Simple examples are trapezoidal (accelerate from (near-)zero to
> > Vmax with A1, and decelerate from Vmax back to zero with D1), dual-slope or
> > S-curve, but the UAPI in theory permits an arbitrary number of segments if
> > the underlying hardware supports it.  
> 
> Yes, when I have read that it reminded me my API between non-RT
> and RT control task in Linux and IRQs in sysless case of our system.
>
> > I have some ideas for future extensions to the API that make coordinated
> > multi-channel movements a bit easier, but that will not be in the initial
> > push of LMC: For example torque-limit profiles for controlled torque
> > movements, usable for example in sliding door controllers with AC machines
> > or BLDC motors; or an ioctl to send a distance vector to a selected number
> > of channels at once and apply a motion profile to the whole coordinated
> > movement. In the current version you have to set up the distances and
> > profiles for the individual channels and then trigger the start of the
> > motion, which is more cumbersome. You can already use the finish event of a
> > preceding motion to trigger the next one though.  
> 
> It would worth to have some commands queue for specified
> (prefigured/setup) xis group.

I thought about this, and while queuing commands for a 3D printer seems like a
great idea, since it is strictly feed-forward for the most part, queuing
commands in the kernel is complicating things a lot when you also want to be
able to react to real-time events in user-space, like end-stop switches and
such. I think the current GPIO UAPI with support for epoll events is
fantastic, and people should use it. :-)

OTOH, I think that the speed and timing accuracy with which one would send
individual movement commands (vectors or splines) to a motion controller is
perfectly adequate for user-space, specially if you have the option of a
1-deep queue like this mechanism of triggering the next movement when the
current one finishes, which basically gives you the time the current movement
takes as latency-slack for user-space. I think that is enough, but let me know
if you disagree. Maybe it is possible to make the N-dimensional vector
interface (optionally) queued?

> Our system allows to add segments to the group queue but the
> timing for segment only specifies shortest time in which it can
> be executed.
> 
> Then there is three passes optimization then.
> 
> The first pass is performed at the insertion time. It checks and
> finds normalized change of speeds  (divided by maximal accel/deccel
> of given axis) at vertex and finds limiting exes, one which accelerates
> the most and another which needs to decelerate the most. Then it
> computes speed discontinuity at the given sample period and it limits
> maximal final speed of the preceding segment such way, that the speed
> change is kept under COORDDISCONT multiple of accel/decel step. This
> way, if the straight segments are almost in line, the small change
> of the direction is not limiting the speed. The discontinuity is
> computed same way for the vertex between two N-order spline segments,
> but optimally computed spline segments can be joint with such
> discontinuity near to zero. This non RT computation as well as all
> non-RT a RT one on the control unit side is done in the fixed
> math (the most 32-bits, sometime 64-bits). Actual code of this
> pass are the functions pxmc_coordmv_seg_add(), pxmc_coordmv_seg_add_line()
> and pxmc_coordmv_seg_add_spline()

Yes, this maps very well with what I had in mind when designing LMC. I haven't
thought about supporting engines capable of real-time spline interpolation
because I hadn't seen one before. I thought that just dividing a spline into
(many) linear segments would be good enough, but if there are motion engines
that can handle spline parameters, I guess we should try to support that.

The motion profiles LMC supports have 2 extra parameters for limiting speed
discontinuities which can be found in many common motion engines: tvmax and
tvzero.

https://github.com/yope/linux/blob/mainline-lmc-preparation/include/uapi/linux/motion.h#L146

Tvmax is important for situations where the maximum speed of a given profile
is not reached because the distance is too short. It will make sure there is
at least some period of constant speed before decelerating again.

Tvzero is important for motions that starts accelerating into an opposite
direction of a preceding motion, to insert a minimum time at zero velocity.

But I guess you are more than familiar with these, since they are pretty
common concepts. ;-)

>   https://gitlab.com/pikron/sw-base/pxmc/-/blob/master/libs4c/pxmc_coordmv/coordmv_base.c?ref_type=heads#L394
> 
> The new segment final vertex limiting speed and planned speed are
> set to zero.
> 
> In the second pass, the queue of segments is examined from the last
> added one and its initial planned vertex/edge speed is updated,
> increased up to the minimum of limit give by discontinuity and
> the limit to decelerate over segment to the planned final speed
> of the segment. If the start vertex limit is increased then
> the algorithm proceeds with previous segment

AFAICS, these are all motion planning tasks that should be done in user-space,
right?

>  https://gitlab.com/pikron/sw-base/pxmc/-/blob/master/libs4c/pxmc_coordmv/coordmv_base.c?ref_type=heads#L682
> 
> There are some rules and trick to do that long free in the respect
> to the IRQ executor etc...
> 
> Then the actual execution at the sampling frequency advances
> the normalized parameter going through segment from 0 to 2^32
> in 2^32 modulo arithmetic. The increase is limited by smallest
> maximal speed of the axes recomputed over distance to parameter
> change and maximal allowed accelerations recomputed to the parameter
> change. Then the final speed is limited by to final deceleration
> to the end of the segment the pxmc_coordmv_upda() in
> 
>   https://gitlab.com/pikron/sw-base/pxmc/-/blob/master/libs4c/pxmc_coordmv/coordmv_base.c?ref_type=heads#L351

AFAICS, this is probably better done in the controller itself, right?

The most complex math I feel comfortable doing in kernel space is converting a
distance-based motion given a trapezoidal acceleration profile (whith its
limiting factors tvmin and tvmax, see above) into a time based motion:

https://github.com/yope/linux/blob/mainline-lmc-preparation/drivers/motion/motion-helpers.c#L515

This is a helper function for drivers that want to use the internal time-based
ramp generator.

>[...]
> > Another idea that has been floating in my head is to make a "virtual"
> > motion device driver that combines individual "real" single-channel
> > hardware drivers into one multi-channel device, but I am unsure whether it
> > is really needed. It all depends on the latency limit differences between
> > kernel-space and user-space whether there is something to gain.  
> 
> In the fact this is the similar idea programmed and in use 25 years
> already. All computation is in 32-bit units specific for the each axis
> and only in fixed arithmetic. Some problem was fast 64-bit root square
> at that time.  All has been computed on 21 MHz CPU with 16-bit bus with
> no caches with instrauctions taking from 2 to many cycles. It was capable
> to do that for all eight axes plus some other control tasks as flashing
> lights at specific positions for example for gems inspections by camera
> connected to PC and then cotrolling their sorting to the right pocket by air
> streams by MARS 8 control unit when it advanced to given location etc.
> So some parts of the code has been rewritten to assembly. But today,
> even on not so fast LPC4088 it can do this and D-Q PMSM motors
> control without need of assembly optimizations.

I think that if we support different kinds of profiles on N-dimensions with
support for spline parameters if the hardware supports it, we could solve for
any use-case without much complexity in the kernel.

> > I think it is best to keep this initial version more limited in scope
> > though, as long as the needed extensions are possible in the future without
> > breaking existing UAPI.  
> 
> Yes, but I would be happy if the API is designed such way, that
> it is not obstacle when it would be extended and I have idea
> what would be such further goal for these applications
> I have already solved and running for decades at industry
> level.

That's great. I am confident that with your help, we can make this API as
universally usable as possible, while still keeping it simple and generic.

> > So I propose: Let's craft a draft UAPI (in a different place, not on LKML)
> > that can do everything we can come up with and then reduce it to the basics
> > for the first version. Otherwise it will get too complex to review, I'm
> > afraid.  
> 
> Yes, I agree.
> 
> To have some idea of the command set of our system, there is documentation
> in English for our older system which was capable to control three
> axes by 8-bit 80552
> 
>    http://cmp.felk.cvut.cz/~pisa/mars/mars_man_en.pdf

This API looks pretty straight-forward, and should be easy to implement with
LMC. Controller specific settings in LMC are set using a sysfs attributes
interface. An example of the settings for the TMC5240:

https://github.com/yope/linux/blob/mainline-lmc-preparation/drivers/motion/tmc5240.c#L311

> > > At this moment I have interrest if there is site which
> > > would start to collect these ideas and where can be
> > > some references added.  
> >
> > I may put this on github and create a wiki there if you think that's a good
> > enough place to discuss?  
> 
> If there is no feedback with better place to my initial
> list of options, I am OK with project group on GitHub
> where the initial project will be located with Wiki
> and issue tracker to start the communication
> and I would be happy to participate (as my time, teaching,
> projects allows).

Sounds good. Let's see if we can get some attention from OSADL or Linux
Foundation. If you have some contacts there, I'd be great if you could help
get something set up. If not, we just use github or maybe even gitlab for now.

> > > I think that I have quite some stuff to offer.  
> >
> > That would be great! Looking forward to it :-)
> >  
> > > To have idea about my direction of thinking and needs
> > > of interface I would provide some references even
> > > to our often commercially sold but mostly conceived
> > > as hobby projects.  
> >
> > I'll have to take some time to look into those more closely. My own
> > experience as far as FOSS or OSHW concerns includes the reprap Kamaq
> > project:
> >
> > https://reprap.org/wiki/Kamaq  
> 
> OK, nice target but I would like to support 5 D CNCs with
> precise machining, haptic human machine systems etc...

Sure!

> with DC, stepper and PMSM motors with vector control
> high resolution positional feedback etc. We control for
> example up to 30 kg spherical lenses positioning in
> the interferometric system with precision of micro fractions.
> The system allows inspection which thanks to multiple
> angles reaches lens surface reconstruction at level of
> nanometres 
> 
>   https://toptec.eu/export/sites/toptec/.content/projects/finished/measuring-instrument.pdf
> 
> We use optical linear sensors combined with 10k per revolution
> incremental sensors on the cheap stepper motor actuators and
> precise mechanics.. and more tricks... And I can see use
> of some cheap linux board, i.e. Zynq, Beagle-V Fire,
> which I have on my table, there in future...

Yes, this sounds really awesome. It sounds like a great challenge for getting
LMC into a good enough shape for that sort of applications. It is exactly what
I had in mind.

>[...]
> As I referenced above, the spines are interpreted at sampling frequency
> all parameters are represented as 32-bit signed numbers etc...
> So no conversion to the straight segments. The precise postions
> are recomputed with even high resolution over IKT, then some
> intervals of these points are interpolated by spline segments
> with controlled error and these segments are send to the unit
> to keep command FIFO full but not overflow it. Unit reports
> how much space is left...
> 
> > LMC will try to limit math operations in kernel space as much as possible,
> > so hopefully all the calculations can be done in user-space (or on the
> > controller if that is the case).  
> 
> All computation is fixed point only so no problem for the kernel
> even for interrupt. But yes, on fully preemptive kernel where
> user space task can be guaranteed to achieve 5 kHz sampling even
> on cheaper ARM hardware, the interface to the kernel can be
> only on D-Q PWM command and actual IRC and currents readback.
> 
> But if you have API for more intelligent controllers then there
> s no problem to put there "SoftMAC" to represent dumb ones the
> same way to userspace.

That's exactly what I thought of. Thanks for the analogy, I am going to
shamelessly steal it from you if you don't mind ;-)

That's also why I included 2 different drivers as example for LMC: One that
does all the fast computations in hardware, and one that uses a "SoftMAC", in
motion-helpers.c to generate time-based speed ramps from acceleration profiles.

But I think we should limit the "SoftMAC" device capabilities to basic
trapezoidal motion profiles, since it is not the main purpose of LMC to
convert the Linux kernel into a high-resolution, hard-RT motion-planning
engine... even if it is a tempting technical challenge to do so ;-)

> > Right now, my way of thinking was that of regular 3D printers which usually
> > only implement G0/G1 G-codes (linear interpolation). G2/G3 (circular
> > interpolation) doesn't sound practically very useful since it is special
> > but not very flexible. Something like generalized spline interpolation
> > sounds more valuable, but I hadn't seen any hardware that can do it.
> >  
> > > The related python application is there
> > >
> > >   https://github.com/cvut/pyrocon
> > >
> > > In the far future, I can imagine that it can connect
> > > to proposed LMC API and achieve the same results.  
> >
> > Let's make it so!
> >  
> > >[...]
> > > which uses our PXMC motion control library
> > >
> > >   https://gitlab.com/pikron/sw-base/pxmc
> > >
> > > There is basic documentation for it on its site
> > >
> > >   https://pxmc.org/
> > >   https://pxmc.org/files/pxmc.pdf  
> >
> > At first glance, this looks like a piece of hardware that would fit as a
> > LMC device. What needs to be determined is where the boundaries lie between
> > controller firmware, kernel-space and user-space code.  
> 
> I propose to have that boundary fully configurable.
> So all can be implemented by software emulation
> in the kernel if the sampling is under 5 or 10 kHz.
> The interface from GNU/Linux system to hardware
> is set PWM A, B, C, read actual IRC and currents.

5-10kHz in the kernel is quite demanding already, although I agree that it is
possible with many modern SoC's. The question is whether we really want to
go that far. It is starting to get to levels of stress where really a small
microcontroller of FPGA would be more adequate, don't you agree?

And also, for what purpose do you want to read currents in real-time in the
kernel? Isn't that something for closed-loop control inside a uC or FPGA?
Or do you mean just to report to user-space as a filtered average?
IRC (encoder feedback) could be implemented with timers that support
quadrature decoding, and I can certainly envision reading them out in the
kernel in order to have a simple PID controller adjust duty-cycle setpoint to
match a motion profile at a lower sample rate (1kHz or lower), but isn't that
more something for the controller hardware to do? Especially if done at even
higher sample-rates?
 
> Or some part can be moved to external controller
> or FPGA with coprocessor (the commutation fits
> in 2 kB of RISC-V C programmed firmware). 
> I.e. 20  kHz or even faster Park, Clarke
> transformations. In this case 4 to 10 kHz
> command port would be D-Q PWM or current set points
> and back IRC position, D-Q currents.
> 
> Or your proposed LMC interface can be delivered
> allmost directly to more complex controller
> which would realize whole segments processing.

I think the latter is more suitable for Linux.

Although, given the fact that many embedded Linux SoC's nowadays incorporate
small microcontroller cores that support the linux remoteproc interface, maybe
some drivers could make use of that for the hard-RT part. On a STM32MP15x SoC
for example there are advanced timers and ADC's that are very well suited for
motor-control applications. They can be used directly from Linux for
not-so-hard-and-fast RT applications, but potentially also for microsecond
work in the M4 core.
Let's first focus on the UAPI, and make the interface able to deal with these
kind of engines.

> > Generally speaking, as a rough guideline, microsecond work is better done
> > in the controller firmware if possible. millisecond work can be done in the
> > kernel and 10's or more millisecond work can be done in user-space,
> > notwithstanding latency limit requirements of course.  
> 
> OK, I agree, the RT_PREEMPT is requiremet and no broken
> SMI on x86 HW. 1 kHz is enough for DC motors controller
> robots to go all on Linux. 5 kHz for PMSM D-Q can be
> done in kernel or even userspace with platform
> suitable for PREEMPT_RT if without some issues.
> 
> Above 10 kHz should go to FPGA or external HW.

Yes, I agree. Although I'd lower the limits a bit to not make the drivers too
dependent on very specific hardware platforms.

> > >[...]
> > > So in general, I think that we have large portfolio
> > > of building blocks which would allow to build motion,
> > > robotic controllers, communications etc. and I would be happy
> > > if they are reused and even some project conceived
> > > together with others to join the forces.  
> >
> > This sounds very interesting. Ideally one would end up with LMC capable of
> > interfacing all of those devices.  
> 
> Yes.

Good. Let's do it ;-)
 
Best regards,

-- 
David Jander

