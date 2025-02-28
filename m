Return-Path: <linux-iio+bounces-16199-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAF0A49D4E
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 16:24:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1CDE1765AB
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 15:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0E51C07F5;
	Fri, 28 Feb 2025 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pikron.com header.i=@pikron.com header.b="KUPmilYt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx-8.mail.web4u.cz (smtp7.web4u.cz [81.91.87.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04D11EF361;
	Fri, 28 Feb 2025 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.91.87.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740756210; cv=none; b=RhhfZvCjVCvmLhUjZfeFkFyvmez4DepDkz0Ztev4dDcQ3TdZprt81uW4hEtmOLScySBseL9HodV7vMPYYTc1M/XsIwKq0uq9xRmj/yqRA1yBmSOQyxzH1AvLsbeI7F50kniL6Yc2IvQJlCkRrg6wkQZmuLXEv62PpJGFt0uhNbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740756210; c=relaxed/simple;
	bh=SMUr9EM8SL4DA3cCpntjmBZv6lTlmeXUyR0XO+0eHLs=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id; b=Ntm+2oLfyRnUtGwH5WDPDuabf/A1tnK6ku2gR8sjJDfcaARjO8A8NEQ/BwDcZ+Vc8fY8mu2kGByHB+QxuhgrKJ6mX3weWWynyXKMGyHWlskMcDYPfyHWoGrmJhDJrSG1hc6Lc+d+mawpTiM6tej0m36MXLaH59b7qRzAWisV0a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pikron.com; spf=pass smtp.mailfrom=pikron.com; dkim=pass (2048-bit key) header.d=pikron.com header.i=@pikron.com header.b=KUPmilYt; arc=none smtp.client-ip=81.91.87.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pikron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pikron.com
Received: from mx-8.mail.web4u.cz (localhost [127.0.0.1])
	by mx-8.mail.web4u.cz (Postfix) with ESMTP id 88C601FFDE5;
	Fri, 28 Feb 2025 16:23:19 +0100 (CET)
Received: from baree.pikron.com (unknown [84.242.78.234])
	(Authenticated sender: ppisa@pikron.com)
	by mx-8.mail.web4u.cz (Postfix) with ESMTPA id 1873D1FF6D4;
	Fri, 28 Feb 2025 16:23:19 +0100 (CET)
From: Pavel Pisa <ppisa@pikron.com>
Organization: PiKRON Ltd.
To: David Jander <david@protonic.nl>
Subject: Re: [RFC PATCH 0/7] Add Linux Motion Control subsystem
Date: Fri, 28 Feb 2025 16:23:33 +0100
User-Agent: KMail/1.9.10
Cc: linux-kernel@vger.kernel.org,
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
 Carsten Emde <c.emde@osadl.org>
References: <20250227162823.3585810-1-david@protonic.nl> <202502281035.57489.ppisa@pikron.com> <20250228125727.7f892552@erd003.prtnl>
In-Reply-To: <20250228125727.7f892552@erd003.prtnl>
X-KMail-QuotePrefix: > 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <202502281623.33695.ppisa@pikron.com>
X-Pylter4U-dkim-type: user
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pikron.com;
	i=@pikron.com; q=dns/txt; s=w4u; t=1740756199; h=from : date : to :
	subject; bh=SMUr9EM8SL4DA3cCpntjmBZv6lTlmeXUyR0XO+0eHLs=;
	b=KUPmilYtMRTwzIHoH8K0vcKHBbpXKL3zax1UWdwtX7NbAGTiWDxtPvdlJYXr4mcychR/w
	IFaCEtsxlyVRGB2spgYaOu7m8Vz7/i6YJTtMNBkCiVOWohGGPiyXY44UPICw9ELDJPALmC6
	563Wuzi9ektOqKZEDK23m5JW2moa795UDKR5pvuwLP04BqgKld4YTFuY304umhZ36/SNwRc
	dibWxPU6zcspkZxcBLb5VoYViiRfauVtQFMpxJtGsTCEF1m15Y1Ue79HpmzZIKBXVCGBeiz
	oiV91q026jkC2oIKCCkhSEz/uVFLqUQpU4bguqeLPYGA60jBidjSlpM4aHIQ==
X-W4U-Auth: 48527e7b6ad7b2fc3518ae0b30b416756382dec5

Hello David,

On Friday 28 of February 2025 12:57:27 David Jander wrote:
> Dear Pavel,
>
> Thanks a lot for starting the discussion...
>
> On Fri, 28 Feb 2025 10:35:57 +0100
>
> Pavel Pisa <ppisa@pikron.com> wrote:
> > Hello David and others
> >
> > On Thursday 27 of February 2025 17:28:16 David Jander wrote:
> > > Request for comments on: adding the Linux Motion Control subsystem to
> > > the kernel.
> >
> > I have noticed on Phoronix, that the new system is emerging.
>
> Being featured on Phoronix on day one wasn't on my bingo card for this
> year, to be honest... :-)
>
> > This is area where I have lot (more than 30 years) of experience
> > at my company and I have done even lot with my studnets at university.
> > I have big interest that this interface fits our use neeeds
> > and offers for future integration of our already open-source
> > systems/components.
>
> This is very impressive and I am honored to have gotten your attention. I
> am looking forward to discussing this, although I am not sure whether all
> of this should happen here on LKML?

We should move somewhere else and invite people from Linux
CNC etc...

GitHub project would work well if there is not some reluctance
to commercially controlled and closed environment.

Gitlab even in Gitlab.com case has option to move to own
infrastructure in the future. We have Gitlab at university,
companies I work with has Gitlab instances. But I think that
we should stay on neutral ground.

The critical is some central hub where links to specific
mailinglist etc. can be placed. May it be we can ask
Linux foundation to provide wiki space for Linux Motion Control
Subsystem same as it is for RT

  https://wiki.linuxfoundation.org/realtime/start

We can ask OSADL.org as likely neutral space...

Or wiki at kernel.org, may it the most neutral...

 https://www.wiki.kernel.org/

I am not in the core teams but may it be there on LKLM
somebody would suggest the direction. I can ask people
from OSADL, CIPS, RT projects etc. directly...

But I am not the authority and would be happy if somebody
steers us.

To not load others, if there is no response then I suggest
to limit followup e-mails only to linux-iio and those
who already communicated in this thread.

> > This is preliminary reply, I want to find time for more discussion
> > and analysis (which is quite hard during summer term where I have
> > lot of teaching and even ongoing project now).
> >
> > I would like to discuse even future subsystem evolution
> > which would allow coordinates axes groups creation, smooth
> > segments based on N-th order splines incremental attachment,
> > the path planning and re-planning if the target changes
> > as reaction to camera or other sensor needs etc.
>
> Right now LMC should be able to support hardware that has multiple channels
> (axes) per device. Its UAPI can describe position-based movements and
> time-based movements along any arbitrary combination of those channels
> using a pre-defined speed/acceleration profile.
>
> The profiles can be specified as an arbitrary number of speed and
> acceleration values. The idea is to describe a segmented profile with
> different acceleration values for segments between two different speed
> values. Simple examples are trapezoidal (accelerate from (near-)zero to
> Vmax with A1, and decelerate from Vmax back to zero with D1), dual-slope or
> S-curve, but the UAPI in theory permits an arbitrary number of segments if
> the underlying hardware supports it.

Yes, when I have read that it reminded me my API between non-RT
and RT control task in Linux and IRQs in sysless case of our system.

> I have some ideas for future extensions to the API that make coordinated
> multi-channel movements a bit easier, but that will not be in the initial
> push of LMC: For example torque-limit profiles for controlled torque
> movements, usable for example in sliding door controllers with AC machines
> or BLDC motors; or an ioctl to send a distance vector to a selected number
> of channels at once and apply a motion profile to the whole coordinated
> movement. In the current version you have to set up the distances and
> profiles for the individual channels and then trigger the start of the
> motion, which is more cumbersome. You can already use the finish event of a
> preceding motion to trigger the next one though.

It would worth to have some commands queue for specified
(prefigured/setup) xis group.

Our system allows to add segments to the group queue but the
timing for segment only specifies shortest time in which it can
be executed.

Then there is three passes optimization then.

The first pass is performed at the insertion time. It checks and
finds normalized change of speeds  (divided by maximal accel/deccel
of given axis) at vertex and finds limiting exes, one which accelerates
the most and another which needs to decelerate the most. Then it
computes speed discontinuity at the given sample period and it limits
maximal final speed of the preceding segment such way, that the speed
change is kept under COORDDISCONT multiple of accel/decel step. This
way, if the straight segments are almost in line, the small change
of the direction is not limiting the speed. The discontinuity is
computed same way for the vertex between two N-order spline segments,
but optimally computed spline segments can be joint with such
discontinuity near to zero. This non RT computation as well as all
non-RT a RT one on the control unit side is done in the fixed
math (the most 32-bits, sometime 64-bits). Actual code of this
pass are the functions pxmc_coordmv_seg_add(), pxmc_coordmv_seg_add_line()
and pxmc_coordmv_seg_add_spline()

  https://gitlab.com/pikron/sw-base/pxmc/-/blob/master/libs4c/pxmc_coordmv/coordmv_base.c?ref_type=heads#L394

The new segment final vertex limiting speed and planned speed are
set to zero.

In the second pass, the queue of segments is examined from the last
added one and its initial planned vertex/edge speed is updated,
increased up to the minimum of limit give by discontinuity and
the limit to decelerate over segment to the planned final speed
of the segment. If the start vertex limit is increased then
the algorithm proceeds with previous segment

 https://gitlab.com/pikron/sw-base/pxmc/-/blob/master/libs4c/pxmc_coordmv/coordmv_base.c?ref_type=heads#L682

There are some rules and trick to do that long free in the respect
to the IRQ executor etc...

Then the actual execution at the sampling frequency advances
the normalized parameter going through segment from 0 to 2^32
in 2^32 modulo arithmetic. The increase is limited by smallest
maximal speed of the axes recomputed over distance to parameter
change and maximal allowed accelerations recomputed to the parameter
change. Then the final speed is limited by to final deceleration
to the end of the segment the pxmc_coordmv_upda() in

  https://gitlab.com/pikron/sw-base/pxmc/-/blob/master/libs4c/pxmc_coordmv/coordmv_base.c?ref_type=heads#L351

Then the actual positions of the axes are computed based on the
parameter, see pxmc_coordmv_line_gen() or pxmc_coordmv_spline_gen()

  https://gitlab.com/pikron/sw-base/pxmc/-/blob/master/libs4c/pxmc_coordmv/coordmv_base.c?ref_type=heads#L87
  https://gitlab.com/pikron/sw-base/pxmc/-/blob/master/libs4c/pxmc_coordmv/coordmv_base.c?ref_type=heads#L151
 
This approach ensures that if non RT part or even some commander,
in demo case python sending segments to be added over 19200 bit/s
serial line, does not keep with the segments execution, then
the robot will stop at the final position without exceeding deceleration
at any axis. So it is safe, even busback in some axis can control
slow down or even slight move back in the parameter etc... but
with system/actuator/tool keeping the path.

If there is interrest I would find more detailed description
of the optimizations and computations. I have even code for
its testing and checking correctness on the command line.

> Another idea that has been floating in my head is to make a "virtual"
> motion device driver that combines individual "real" single-channel
> hardware drivers into one multi-channel device, but I am unsure whether it
> is really needed. It all depends on the latency limit differences between
> kernel-space and user-space whether there is something to gain.

In the fact this is the similar idea programmed and in use 25 years
already. All computation is in 32-bit units specific for the each axis
and only in fixed arithmetic. Some problem was fast 64-bit root square
at that time.  All has been computed on 21 MHz CPU with 16-bit bus with
no caches with instrauctions taking from 2 to many cycles. It was capable
to do that for all eight axes plus some other control tasks as flashing
lights at specific positions for example for gems inspections by camera
connected to PC and then cotrolling their sorting to the right pocket by air
streams by MARS 8 control unit when it advanced to given location etc.
So some parts of the code has been rewritten to assembly. But today,
even on not so fast LPC4088 it can do this and D-Q PMSM motors
control without need of assembly optimizations. 

> I think it is best to keep this initial version more limited in scope
> though, as long as the needed extensions are possible in the future without
> breaking existing UAPI.

Yes, but I would be happy if the API is designed such way, that
it is not obstacle when it would be extended and I have idea
what would be such further goal for these applications
I have already solved and running for decades at industry
level.

> So I propose: Let's craft a draft UAPI (in a different place, not on LKML)
> that can do everything we can come up with and then reduce it to the basics
> for the first version. Otherwise it will get too complex to review, I'm
> afraid.

Yes, I agree.

To have some idea of the command set of our system, there is documentation
in English for our older system which was capable to control three
axes by 8-bit 80552

   http://cmp.felk.cvut.cz/~pisa/mars/mars_man_en.pdf

Unfortunately, I need to translate manual with coordinated
movement to English still, but command set is listed
(by unit itself) there

  https://cmp.felk.cvut.cz/~pisa/mars8/mo_help.txt

There is even PXMC documented in Konrad Skup's thesis  

  https://wiki.control.fel.cvut.cz/mediawiki/images/8/83/Dp_2007_skup_konrad.pdf

I hoped and have received a promise from my former colleague
leading the thesis based on my company's documentation
and code that the text will be a base for the open documentation
for the  https://www.pxmc.org/ site. I have fulfilled my
part, bought the domain, and opened the PXMC code.
However, he and his student did not mention the source
of the code in my company; instead, they sold the text for
commercial (paid only) publication and access. So, my hopes
to build community has faded in the stream of need to real
projects that need to be solved. So broader introduction
to the community has been postponed... by 18 years...

> > At this moment I have interrest if there is site which
> > would start to collect these ideas and where can be
> > some references added.
>
> I may put this on github and create a wiki there if you think that's a good
> enough place to discuss?

If there is no feedback with better place to my initial
list of options, I am OK with project group on GitHub
where the initial project will be located with Wiki
and issue tracker to start the communication
and I would be happy to participate (as my time, teaching,
projects allows).

> > I think that I have quite some stuff to offer.
>
> That would be great! Looking forward to it :-)
>
> > To have idea about my direction of thinking and needs
> > of interface I would provide some references even
> > to our often commercially sold but mostly conceived
> > as hobby projects.
>
> I'll have to take some time to look into those more closely. My own
> experience as far as FOSS or OSHW concerns includes the reprap Kamaq
> project:
>
> https://reprap.org/wiki/Kamaq

OK, nice target but I would like to support 5 D CNCs with
precise machining, haptic human machine systems etc...
with DC, stepper and PMSM motors with vector control
high resolution positional feedback etc. We control for
example up to 30 kg spherical lenses positioning in
the interferometric system with precision of micro fractions.
The system allows inspection which thanks to multiple
angles reaches lens surface reconstruction at level of
nanometres 

  https://toptec.eu/export/sites/toptec/.content/projects/finished/measuring-instrument.pdf

We use optical linear sensors combined with 10k per revolution
incremental sensors on the cheap stepper motor actuators and
precise mechanics.. and more tricks... And I can see use
of some cheap linux board, i.e. Zynq, Beagle-V Fire,
which I have on my table, there in future...

> TL;DR: It is a 3D printer running only Linux and the whole controller
> software is entirely written in python (except for very little Cython/C
> code). This is still my 3D printer on which I satisfy all of my 3D print
> needs. I will need to port it to LMC one day.
>
> > Coordinated axes groups movement with incremental spline
> > segment addition into command queue (our COORDMV componet
> > of PXMC library) is demonstrated on old BOSCH SR 450 SCARA
> > system. The robot has never fully worked at Skoda Auto
> > with original BOSH control unit. But when it has been donated
> > to Czech Technical University, we have build control
> > unit at my copany based on Motorola 68376 MCU in around
> > 2000 year. I have later paid one student to prepare
> > demo in Python to demonstrate the system.
> >
> > You can click on video
> >
> >   MARS 8 BigBot and Robot Bosch SR 450 Drawing Roses
> >   http://pikron.com/pages/products/motion_control.html
>
> Very impressive! Can you explain how the spline-segment information could
> be conveyed to the controller? Does the controller really do an
> infinitesimal spline interpolation, or does it create many small linear
> vectors?

As I referenced above, the spines are interpreted at sampling frequency
all parameters are represented as 32-bit signed numbers etc...
So no conversion to the straight segments. The precise postions
are recomputed with even high resolution over IKT, then some
intervals of these points are interpolated by spline segments
with controlled error and these segments are send to the unit
to keep command FIFO full but not overflow it. Unit reports
how much space is left...

> LMC will try to limit math operations in kernel space as much as possible,
> so hopefully all the calculations can be done in user-space (or on the
> controller if that is the case).

All computation is fixed point only so no problem for the kernel
even for interrupt. But yes, on fully preemptive kernel where
user space task can be guaranteed to achieve 5 kHz sampling even
on cheaper ARM hardware, the interface to the kernel can be
only on D-Q PWM command and actual IRC and currents readback.

But if you have API for more intelligent controllers then there
s no problem to put there "SoftMAC" to represent dumb ones the
same way to userspace.

> Right now, my way of thinking was that of regular 3D printers which usually
> only implement G0/G1 G-codes (linear interpolation). G2/G3 (circular
> interpolation) doesn't sound practically very useful since it is special
> but not very flexible. Something like generalized spline interpolation
> sounds more valuable, but I hadn't seen any hardware that can do it.
>
> > The related python application is there
> >
> >   https://github.com/cvut/pyrocon
> >
> > In the far future, I can imagine that it can connect
> > to proposed LMC API and achieve the same results.
>
> Let's make it so!
>
> >[...]
> > which uses our PXMC motion control library
> >
> >   https://gitlab.com/pikron/sw-base/pxmc
> >
> > There is basic documentation for it on its site
> >
> >   https://pxmc.org/
> >   https://pxmc.org/files/pxmc.pdf
>
> At first glance, this looks like a piece of hardware that would fit as a
> LMC device. What needs to be determined is where the boundaries lie between
> controller firmware, kernel-space and user-space code.

I propose to have that boundary fully configurable.
So all can be implemented by software emulation
in the kernel if the sampling is under 5 or 10 kHz.
The interface from GNU/Linux system to hardware
is set PWM A, B, C, read actual IRC and currents.

Or some part can be moved to external controller
or FPGA with coprocessor (the commutation fits
in 2 kB of RISC-V C programmed firmware). 
I.e. 20  kHz or even faster Park, Clarke
transformations. In this case 4 to 10 kHz
command port would be D-Q PWM or current set points
and back IRC position, D-Q currents.

Or your proposed LMC interface can be delivered
allmost directly to more complex controller
which would realize whole segments processing.

> Generally speaking, as a rough guideline, microsecond work is better done
> in the controller firmware if possible. millisecond work can be done in the
> kernel and 10's or more millisecond work can be done in user-space,
> notwithstanding latency limit requirements of course.

OK, I agree, the RT_PREEMPT is requiremet and no broken
SMI on x86 HW. 1 kHz is enough for DC motors controller
robots to go all on Linux. 5 kHz for PMSM D-Q can be
done in kernel or even userspace with platform
suitable for PREEMPT_RT if without some issues.

Above 10 kHz should go to FPGA or external HW. 

> >[...]
> > So in general, I think that we have large portfolio
> > of building blocks which would allow to build motion,
> > robotic controllers, communications etc. and I would be happy
> > if they are reused and even some project conceived
> > together with others to join the forces.
>
> This sounds very interesting. Ideally one would end up with LMC capable of
> interfacing all of those devices.

Yes.

> > It would be ideal if the all motion control related
> > resources and links could be somehow collected
> > that wheel is not reinvented unnecessarily.
>
> I completely agree.
>
> > The most of my code is Mozilla, GPL etc... I have
> > right to relicence my company stuff if the license does
> > not fit. On the other hand, I do not intend to follow
> > such offers as of one well funded chip related association,
> > which offered us to relicense all to them with no retain
> > of any control and additional right and they would not
> > take care about the valuable project at all no looking
> > for funding etc... no promise for developmet etc...
> > So there are some limits.
>
> Understandable.

Best wishes,

                Pavel
-- 
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

