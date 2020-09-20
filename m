Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A695D2716FB
	for <lists+linux-iio@lfdr.de>; Sun, 20 Sep 2020 20:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgITSPv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Sep 2020 14:15:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgITSPv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 Sep 2020 14:15:51 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4701320870;
        Sun, 20 Sep 2020 18:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600625750;
        bh=tZRsigpDglxGgIaX1+i/DqqlH5/4n/TAd1u7E5HtsSY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MkbCHDIqWRtnEhwrdaH645m1hRy5E198Q9mSvukeSZV5CvJbO6UJ7uUtj7G1HPgJ+
         oO4OUynWR2Rb1WVcztOwtk0zeyFYVGMBBlkcv1fO+qEyb3KHzS6HBwFXQICgOljbhx
         OhUKXQJEXav8jnMURsnWW+9XzUALhQy5uNT/aijw=
Date:   Sun, 20 Sep 2020 19:15:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Christian Eggers <ceggers@arri.de>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: hrtimer-trigger: Mark hrtimer to expire in
 hard interrupt context
Message-ID: <20200920191545.4ed79276@archlinux>
In-Reply-To: <20200814113008.00002733@Huawei.com>
References: <20200813075358.13310-1-lars@metafoo.de>
        <20200813091107.kjelslak2jxkkc42@linutronix.de>
        <930e6dc4-df6f-416b-0df3-dab7177af974@metafoo.de>
        <20200813112741.grdytusuwrlskpwa@linutronix.de>
        <877du2louq.fsf@nanos.tec.linutronix.de>
        <20200813155519.00000684@Huawei.com>
        <4236c3e3-6c7b-a4fc-3d25-1edf4eebec3e@metafoo.de>
        <20200814113008.00002733@Huawei.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 14 Aug 2020 11:30:08 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Fri, 14 Aug 2020 07:24:52 +0200
> Lars-Peter Clausen <lars@metafoo.de> wrote:
> 
> > On 8/13/20 4:55 PM, Jonathan Cameron wrote:  
> > > On Thu, 13 Aug 2020 14:19:57 +0200
> > > Thomas Gleixner <tglx@linutronix.de> wrote:
> > >    
> > >> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:    
> > >>> On 2020-08-13 11:46:30 [+0200], Lars-Peter Clausen wrote:    
> > >>>> If you are running with forced IRQ threads the only thing that will then
> > >>>> happen in the actual hard IRQ context is the launching of the IRQ threads.
> > >>>> Th e IRQ handler of the device driver will run in a threaded IRQ.    
> > >>> So if it is really just the wakeup of the IRQ-thread then it should be
> > >>> okay.
> > >>> One thing: iio_trigger_poll() may invoke iio_trigger_notify_done(). This
> > >>> would invoke trig->ops->try_reenable callback if available.
> > >>> I grepped and found
> > >>> - bma180_trig_try_reen()
> > >>>    It appears to perform i2c_smbus_read_byte_data() and smbus sounds
> > >>>    sleeping. I don't know if it attempts to acquire any spinlock_t but it
> > >>>    will be wrong on RT.    
> > >> It's wrong even on !RT. i2c reads cannot be invoked from hard interrupt
> > >> context.
> > >>    
> > > We would hit this (and resulting warnings) all the time if it actually
> > > happened, so my suspicion is that it doesn't.
> > >
> > > I think the path doesn't actually exist although it looks at first glance like it does.
> > >
> > > The interrupt can only be enabled if there is someone using the trigger.
> > > Thus usecount will be non zero and for at least one element
> > > trig->subirq[i].enabled == true
> > >
> > > So we will decrement trig->usecount in the call to iio_trigger_notify_done
> > > but never reach 0 thus the call to trig->ops->try_reenable never happens
> > > in the hard interrupt context.    
> > 
> > I think there is a race condition here. If a consumer is disabled 
> > concurrently with iio_trigger_poll() there is a chance that `enabled` is 
> > false for all consumers.
> > 
> > The odds of this happening are very low, but there is nothing that 
> > prevents it.   
> 
> A consumer disable should have previously resulted in the trigger stopping
> (or do we have he ordering wrong there?)  Might be worth checking that, but
> see below, as I think we can stop it having harmful effects anyway.
> 
> >   
> > >
> > > It does happen later when which ever driver we triggered finishes the
> > > threaded part of it's handler and calls iio_trigger_notify_done, but that
> > > is fine.
> > >
> > > Assuming people agree with my analysis it would be good to make it explicit
> > > that we cannot hit the problem path.
> > >
> > > Perhaps call a new iio_trigger_notify_no_needed() that simply does
> > > the decrement without test, or does it with test and spits out a
> > > warning if we hit 0.    
> > 
> > I think we need to re-think the whole try_reenable() functionality. 
> > Looking at it I think there are more issues here.
> > 
> > For example lets say we call iio_trigger_notify_done() from the threaded 
> > handler and try_reenable() returns true. We'd now call 
> > iio_trigger_poll() from the threaded context, which is wrong.  
> 
> The history behind that functionality was some early devices which were using
> level interrupts tied to edge interrupts.  One of our earliest drivers had to
> do a dance with checking a gpio to avoid stalling.   That went away a long
> time ago when we basically concluded that platform was too broken to support
> interrupts on.
> 
> Probably would have helped if try_reenable returned a bool as then people wouldn't
> have returned error codes via it which is completely wrong as it stands (though
> handy given what I suggest below)
> 
> From a quick look.
> bma180, bmc150, kxcjk1013, mxc4005m bmg180, kmx61, bmc150
> all only fail if an error occurs in an bus access. That's a bug.
> 
> at91 never returns anything other than 0.
> 
> So I think we can probably rip the iio_trigger_poll call out entirely
> and replace it with an error message, or push an error message into
> the drivers and drop the check of the value of try_reenable.
> 
> > 
> > There is also the issue that iio_trigger_poll() effectively can end up 
> > calling itself recursively indefinitely via the 
> > iio_trigger_notify_done() chain, which might not be the best thing in 
> > hard IRQ context.
> >   
> 
> :) Indeed unwise.  I think the only driver that could in theory do this
> that we had a long time back had a counter in the try_reen to give
> up if it happened more than a few times.
>

A quick update on this one. I've sent out a fix for the try_reenable()
patch.  Short version is that we no longer let it fail as no one correctly
used that path anyway anymore.

https://lore.kernel.org/linux-iio/20200920132548.196452-2-jic23@kernel.org/T/#u

My understanding is that resolves the open question on this series.
I'd like to get both issues resolved, so if people have a chance to look
that would be great.

Thanks,

Jonathan
  
> Jonathan
> 
> 

