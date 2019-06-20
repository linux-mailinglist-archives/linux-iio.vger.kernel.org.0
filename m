Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF064C9A2
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2019 10:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbfFTIna (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 20 Jun 2019 04:43:30 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:49557 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfFTIna (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Jun 2019 04:43:30 -0400
X-Originating-IP: 92.137.69.152
Received: from localhost (alyon-656-1-672-152.w92-137.abo.wanadoo.fr [92.137.69.152])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 1595CE0004;
        Thu, 20 Jun 2019 08:43:23 +0000 (UTC)
Date:   Thu, 20 Jun 2019 10:43:22 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Ladislav Michl <ladis@linux-mips.org>
Cc:     linux-iio@vger.kernel.org,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Georg Ottinger <g.ottinger@abatec.at>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [RFC] iio: adc: at91: fix acking DRDY irq (again)
Message-ID: <20190620084322.GV23549@piout.net>
References: <20190611115603.GA11086@lenoch>
 <20190612081419.GM25472@piout.net>
 <20190612093142.GA21203@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612093142.GA21203@lenoch>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/06/2019 11:31:42+0200, Ladislav Michl wrote:
> On Wed, Jun 12, 2019 at 10:15:33AM +0200, Alexandre Belloni wrote:
> > On 11/06/2019 13:56:03+0200, Ladislav Michl wrote:
> > > Driver also contains some code for TC triggers. How is that supposed to
> > > work? [**] The very same manual states in chapter 39.5.5:
> > >   "If one of the TIOA outputs is selected, the corresponding Timer Counter
> > >    channel must be programmed in Waveform Mode."
> > > There are two drivers touching TC: drivers/clocksource/timer-atmel-tcb.c
> > > and drivers/pwm/pwm-atmel-tcb.c, they seem to conflict each other and
> > 
> > They don't, they can work simultaneously, on different TCBs. I'm still
> > planning to rework pwm-atmel-tcb to switch it to the proper binding.
> 
> Is there any draft how should that "proper binding" look like?
> By "conflict" I mean DT can be written so both race for the same resource,
> while I would expect timer definition with PWM and ADC using its phandle.
> 

Last part of https://lore.kernel.org/lkml/20170530215139.9983-2-alexandre.belloni@free-electrons.com/

This is not yet upstream but I'm planning to resend sometime in July.


> > > none of them is anyhow related to ADC driver. Here it would seem
> > > appropriate to have TC MFD driver and allocate timers for ADC, PWM and
> > > clocksource from there.
> > 
> > No, MFD is way too late for clocksource, this would break some platforms.
> > 
> > However, there is definitively some timer framework that is missing to
> > allow handling of timers that are not used as clocksource/clockevent
> > devices. So indeed, there is a missing piece to make the TC trigger
> > work.
> 
> Can that be done similar way drivers/clocksource/timer-ti-dm.c is
> implemented or do you have something else in mind?
> 

Yes, something similar but this could probably be made more generic as
this would benefit many other platforms too (i.e broadcom, nxp,
amlogic).


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
