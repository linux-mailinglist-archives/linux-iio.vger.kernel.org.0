Return-Path: <linux-iio+bounces-16180-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E45A4959C
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 10:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8AB3BC6CF
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 09:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BD825A2B2;
	Fri, 28 Feb 2025 09:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pikron.com header.i=@pikron.com header.b="0QkQRLEx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx-8.mail.web4u.cz (smtp7.web4u.cz [81.91.87.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B021DDC34;
	Fri, 28 Feb 2025 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.91.87.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735688; cv=none; b=L7d9yfvvR3Nfs9RZKRF2i9IcJpKb3ozZt+2SLfIam0j3ytJarBPpsWmBXgiWopg3Tg9uJ7+utc2JObsgRidYPbRCZEDop9ko6DPskN+OPwldSB/8i5PIguO5eLKqXyJk3adiWt2pfi6T4KL9H4iKDSHcax9Wxrz4gbBFCYetWkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735688; c=relaxed/simple;
	bh=NbgIo2upAoY+E8YQmTdaxd5tpt9z/Nf4FDHwVhJ1kQE=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Content-Disposition:Message-Id:Content-Type; b=Q4vea8qMITtN6Yy++vUlf/ON4mRSnUe3NHvGj+tSXbnUSulJWgvLwpNv+3/sJH1UCLNyI8Z9KZuUXZzE4Dowe7LnnGIwu9Q33sQlVkeVEg4YsLRYe4jpENLThsgYomkG7TJ1pPPZ4Vjtfmes4ZYZW60puhi1Cbxu51KqVBM8Qf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pikron.com; spf=pass smtp.mailfrom=pikron.com; dkim=pass (2048-bit key) header.d=pikron.com header.i=@pikron.com header.b=0QkQRLEx; arc=none smtp.client-ip=81.91.87.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pikron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pikron.com
Received: from mx-8.mail.web4u.cz (localhost [IPv6:::1])
	by mx-8.mail.web4u.cz (Postfix) with ESMTP id 4E2FE1FFB55;
	Fri, 28 Feb 2025 10:35:42 +0100 (CET)
Received: from baree.pikron.com (unknown [84.242.78.234])
	(Authenticated sender: ppisa@pikron.com)
	by mx-8.mail.web4u.cz (Postfix) with ESMTPA id E8DAB1FF7D1;
	Fri, 28 Feb 2025 10:35:41 +0100 (CET)
From: Pavel Pisa <ppisa@pikron.com>
To: David Jander <david@protonic.nl>
Subject: Re: [RFC PATCH 0/7] Add Linux Motion Control subsystem
Date: Fri, 28 Feb 2025 10:35:57 +0100
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
 Oleksij Rempel <o.rempel@pengutronix.de>
References: <20250227162823.3585810-1-david@protonic.nl>
In-Reply-To: <20250227162823.3585810-1-david@protonic.nl>
X-KMail-QuotePrefix: > 
Organization: PiKRON Ltd.
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <202502281035.57489.ppisa@pikron.com>
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Pylter4U-dkim-type: user
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pikron.com;
	i=@pikron.com; q=dns/txt; s=w4u; t=1740735342; h=from : date : to :
	subject; bh=NbgIo2upAoY+E8YQmTdaxd5tpt9z/Nf4FDHwVhJ1kQE=;
	b=0QkQRLExcMx4K2vq26qDKFMHUb990ebV/VMnpE1swxSmZbXVVns/k91DjqHg5EvrRSxmT
	In6EkJGYaBlBklTUhPIX8ssSM2Sr691rm5vA3O3YqCKGfOIBY9o+oNP4EDf7ozV0msnmDt/
	pGqbTJh+LEwmOokKyGcu/NouH4bCJDh/NBsLBKkg6Vgsef18A6t4d4QhJuT4nZNOz55yw4d
	Y0+B1fdyvnoxUIA6M5FSqZJh+/FWD5oEZ/mpnudQ3N8+lamtiktodX+yEIUFK0LkkgZcs06
	g/rlXdMRpX+Cnc/bJ8fGmi3gm+3YpCiWFRPdHELFw74qs69E+BNUrd3kMtSA==
X-W4U-Auth: 97ac9a752b3279d18e8ca4239a53ca07301eee61

Hello David and others

On Thursday 27 of February 2025 17:28:16 David Jander wrote:
> Request for comments on: adding the Linux Motion Control subsystem to the
> kernel.

I have noticed on Phoronix, that the new system is emerging.
This is area where I have lot (more than 30 years) of experience
at my company and I have done even lot with my studnets at university.
I have big interest that this interface fits our use neeeds
and offers for future integration of our already open-source
systems/components.

This is preliminary reply, I want to find time for more discussion
and analysis (which is quite hard during summer term where I have
lot of teaching and even ongoing project now).

I would like to discuse even future subsystem evolution
which would allow coordinates axes groups creation, smooth
segments based on N-th order splines incremental attachment,
the path planning and re-planning if the target changes
as reaction to camera or other sensor needs etc.

At this moment I have interrest if there is site which
would start to collect these ideas and where can be
some references added.

I think that I have quite some stuff to offer.

To have idea about my direction of thinking and needs
of interface I would provide some references even
to our often commercially sold but mostly conceived
as hobby projects.

Coordinated axes groups movement with incremental spline
segment addition into command queue (our COORDMV componet
of PXMC library) is demonstrated on old BOSCH SR 450 SCARA
system. The robot has never fully worked at Skoda Auto
with original BOSH control unit. But when it has been donated
to Czech Technical University, we have build control
unit at my copany based on Motorola 68376 MCU in around
2000 year. I have later paid one student to prepare
demo in Python to demonstrate the system.

You can click on video

  MARS 8 BigBot and Robot Bosch SR 450 Drawing Roses 
  http://pikron.com/pages/products/motion_control.html

The related python application is there

  https://github.com/cvut/pyrocon

In the far future, I can imagine that it can connect
to proposed LMC API and achieve the same results.

The related control unit MARS 8 page

  http://pikron.com/pages/products/motion_control/mars_8.html

CPU board for museum or curiosity

  http://pikron.com/pages/products/cpu_boards/mo_cpu1.html

The firmware main application

  https://gitlab.com/pikron/projects/mo_cpu1/mars-mo_cpu1

which uses our PXMC motion control library

  https://gitlab.com/pikron/sw-base/pxmc

There is basic documentation for it on its site

  https://pxmc.org/
  https://pxmc.org/files/pxmc.pdf

It is used in system less environment on the MARS 8 system
and actual control at fixed sampling frequency is done
in timer interrupt at 1 kHz.

More such units serve our studnets to control CRS
A465 robots for more than 20 years already.
Their original control units have broken by age...

The same library has been used in our design of HW and SW
for infusion systems (MSP430 + iMX1 with RTEMS)

  https://pikron.com/pages/devel/medinst.html

HPL systems (LPC1768 HW)

  http://pikron.com/pages/products/hplc/lcp_5024.html

and on newer system less LPC4088 + Xilinx XC6SLX9
system used for example for more ESA and ADS projects

  https://www.esa.int/ESA_Multimedia/Images/2023/06/W-band_on_the_run
  https://github.com/esa/lxrmount
  
https://gitlab.com/pikron/projects/lx_cpu/rocon-commander/-/wikis/lxr-lisa-com

The LX_RoCoN is based on FPGA design with up to 8 IRC inputs, 16 arbitrarily
assignable PWM H-bridge output, TUMBL (open source Microblaze variant) 
co-processor
for up to four electronic commutations for PMSM, stepper or IRC equipped 
steppers
there 

  https://gitlab.com/pikron/projects/lx_cpu/lx-rocon

The commutation ((forward + inverse) x (Park + Clarke)) by co-processor
runs on PMW frequency (20 kHz), D+Q current PI, position PID and COORMV
at 4 kHz.

FPGA design has been started in the frame of the next thesis

  
https://dspace.cvut.cz/bitstream/handle/10467/23347/F3-DP-2014-Meloun-Martin-prace.pdf

More Linux, RTEMS, NuttX, etc. theses led by me there

  https://gitlab.fel.cvut.cz/otrees/org/-/wikis/theses-defend

More information often about RT, motion control there

   https://gitlab.fel.cvut.cz/otrees/org/-/wikis/knowbase

Back to the GNU/Linux

Experiment to run our PXMC library on Linux, demonstration on Raspberry Pi,
AM4300, Xilinx Zynq with DC and PMSM motors

  https://gitlab.com/pikron/projects/pxmc-linux

The HW with small FPGA implementing IRC, 3x PWM and current ADC
commanding and collection which is connected to Raspberry Pi
by SPI there

  https://gitlab.com/pikron/projects/rpi/rpi-mc-1

It is intended for demonstration to enthusiasts, not for
industry. (I am not happy to see H2 filling stations
controlled by RPi today...)

But the same code can be run on Xilinx Zynq with DC motor
peripheral

  
https://gitlab.fel.cvut.cz/canbus/zynq/zynq-can-sja1000-top/-/tree/master/system/ip/dcsimpledrv_1.0

and PMSM peripheral

  
https://gitlab.fel.cvut.cz/canbus/zynq/zynq-can-sja1000-top/-/tree/master/system/ip/pmsm_3pmdrv1_to_pins

but there are even more advanced option even for Linux.
The TUMBL coprocessor has been replaced by small RISC-V
developed in the frame of our Advanced Computer Architectures
course by my studnets

   https://gitlab.fel.cvut.cz/otrees/fpga/rvapo-vhdl

and the 3 phase motor peripheral has been combined
with this coprocessor on Zynq, So PREEMP_RT Linux (or even RETMS)
can deliver D and Q PWM values to shared memory and coprocessor
takes care about commutation at 20 kHz, then collects A, B, C
currents and convert them at 20 kHz to D Q and filters
them to deliver cumulative sum and accumulated samples
count to the slower Linux control loop. But ARM core can
access peripherals directly as well for debugging purposes
etc.

The Linux, RTEMS application source

  
https://gitlab.fel.cvut.cz/otrees/fpga/rvapo-apps/-/tree/master/apps/rvapo-pmsm
  
co-processor firware source

  
https://gitlab.fel.cvut.cz/otrees/fpga/rvapo-vhdl/-/blob/main/software/c/firmware_fresh/firmware.c

The 3-phase peripheral can be synthesized even by fully open source
tool chain to iCE40 and PMSM motor control has been demonstrated
even on cheap ICE-V Wireless (ESP32C3+iCE40)) with SW running NuttX

  https://gitlab.fel.cvut.cz/otrees/risc-v-esp32/ice-v-pmsm

We have tatgets for the most of these peripherals under Linux
and NuttX for pysimCoder

  https://github.com/robertobucher/pysimCoder

Some examples ow pysimCoder is used by independed
company there

  https://www.youtube.com/@robots5/videos

It is on NuttX, but on RPi and Zynq it works even better
on GNU/Linux.

So in general, I think that we have large portfolio
of building blocks which would allow to build motion,
robotic controllers, communications etc. and I would be happy
if they are reused and even some project conceived
together with others to join the forces.

It would be ideal if the all motion control related
resources and links could be somehow collected
that wheel is not reinvented unnecessarily.

The most of my code is Mozilla, GPL etc... I have
right to relicence my company stuff if the license does
not fit. On the other hand, I do not intend to follow
such offers as of one well funded chip related association,
which offered us to relicense all to them with no retain
of any control and additional right and they would not
take care about the valuable project at all no looking
for funding etc... no promise for developmet etc...
So there are some limits.

Best wishes,

                Pavel

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

