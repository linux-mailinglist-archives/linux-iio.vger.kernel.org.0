Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3AEC326DA5
	for <lists+linux-iio@lfdr.de>; Sat, 27 Feb 2021 16:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhB0PqO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Feb 2021 10:46:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:49662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230102AbhB0PqN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Feb 2021 10:46:13 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0ED764DE8;
        Sat, 27 Feb 2021 15:45:29 +0000 (UTC)
Date:   Sat, 27 Feb 2021 15:45:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Michael.Hennerich@analog.com, nuno.sa@analog.com,
        dragos.bogdan@analog.com,
        Mircea Caprioru <mircea.caprioru@analog.com>,
        Mihail Chindris <Mihail.Chindris@analog.com>,
        robh+dt@kernel.org
Subject: Re: [PATCH v2 5/5] iio: dac: ad5686: Add PWM as a trigger source
Message-ID: <20210227154525.42a2c321@archlinux>
In-Reply-To: <49654dc0-5c6b-2fdc-1e48-22e4b07a4165@metafoo.de>
References: <20210217083438.37865-1-alexandru.ardelean@analog.com>
        <20210217083438.37865-6-alexandru.ardelean@analog.com>
        <20210218140506.02b28d8a@archlinux>
        <49654dc0-5c6b-2fdc-1e48-22e4b07a4165@metafoo.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 23 Feb 2021 17:37:40 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 2/18/21 3:05 PM, Jonathan Cameron wrote:
> > On Wed, 17 Feb 2021 10:34:38 +0200
> > Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
> >  
> >> From: Mircea Caprioru <mircea.caprioru@analog.com>
> >>
> >> A PWM signal will be used as a trigger source to have a deterministic
> >> sampling frequency since this family of DAC has no hardware interrupt
> >> source.
> >>
> >> This feature is made optional however, as there are some board setups where
> >> this isn't used.
> >>  
> > So this is taking a very generic setup, but then implementing it
> > as a bit of a hack within the driver.
> >
> > It's effectively a PWM connected up to an instance
> > of iio/triggers/iio-trig-interrupt.c
> >
> > Now, I've not looked at that trigger driver for a while, so you may well
> > need to figure out how to add a binding to instantiate it.
> > (looks like no one has used it since board file days, or via instantiation
> > from another driver).
> >
> > It's a slightly odd corner case as what it reflects is that we have
> > an interrupt available that is intended to drive some sort of data
> > capture or output (it's a trigger signal) - but exactly what is done
> > is a runtime configurable.  In this particular case that interrupt
> > is hooked up to a PWM and we also want to represent that.
> >
> > The fact it's being driven via a PWM is interesting but we should be
> > able to extend that trigger driver to optionally accept a pwm provider
> > and if it has one provide frequency control.
> >
> > Binding might look something like the following..
> >
> > interrupt-trigger {
> >     interrupts = <>;
> >     pwms = <&pwm 0 4000 PWM_POLARITY_INVERTED>;	
> > };
> >
> > @Rob, what do you think of this odd beast?
> >
> > So all in all, this generic facility needs a generic implementation, not
> > one buried in a driver.
> >
> > Another open question here is whether you really can't just use an hrtimer
> > to get similar precision?  Way back at the dawn of time in IIO we had
> > code to use the RTC periodic ticks as a trigger with the theory that they
> > would give very precise and even timing.  In the end it turned out that
> > hrtimers worked just as well (and RTCs drivers emulated the periodic
> > ticks via hrtimers, dropping their use of the hardware periodic timers).
> >  
> The way this DAC works is that it has a "latch" pin and some shadow 
> registers. The way this is supposed to be used is that you update the 
> shadow registers and then when the there is a rising edge on the latch 
> pin all the shadow register values are transferred to DAC output registers.
> 
> This means if you hook up a periodic signal like a PWM or clock to the 
> latch pin you can generate very precise waveforms that have much lower 
> jitter than when using a hrtimer since there is no variable interrupt 
> latency for the update step itself. This is useful when generating 
> periodic signals.
> 
> But you could for example also use a GPIO to update multiple discrete 
> DACs at the same time.
> 
> This is not specific to this particular chip. There are quite a few ADI 
> (and probably from other vendors) precision DACs that have this 
> functionality. I agree that this should be a some sort of generic 
> trigger helper module.
> 
> Now for the implementation since there is a direct connection between 
> the PWM and the DAC I think it makes sense to describe this connection 
> in the DT. After all if there is no connection this will not work.

Thanks for the detailed description. That makes a lot more sense. 

This is some sort of hybrid of the hardware internal triggers
we have for some SoC ADCs and wiring up a gpio pin to trigger the latch
signal.   PWM is one valid way of wiring it up (possibly most sensible
one), but not necessarily the only one.
I guess the one behind element is also a bit non intuitive (data is
put in place on previous interrupt / edge but latched on the next
one)

Hmm. If we makes sure the binding is cleanly defined, we could do
a driver specific implementation for now, with the option to figure
something else out later.

Exactly how to do this needs some thought...
+ lifting this description of hot it works into the patch description
would help :)

Jonathan

> 
> As for the interrupt, most PWM controllers do have the ability to 
> generate an IRQ by themselves once per period. There should be not need 
> for a hardware loopback. Unfortunately the PWM framework does not have a 
> mechanism yet to expose those IRQs and register a callback.
> 
> A similar feature btw exists for many of the ADCs and we did have this 
> special Blackfin PWM trigger[1] back in the day to support this. The 
> bfin PWM trigger driver essentially implements what I'm describing 
> above, but without using the PWM framework.



> 
> - Lars
> 
> [1] 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/staging/iio/trigger/iio-trig-bfin-timer.c?h=v3.15
> 

