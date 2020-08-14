Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94EBC24480A
	for <lists+linux-iio@lfdr.de>; Fri, 14 Aug 2020 12:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgHNKbk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 14 Aug 2020 06:31:40 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2604 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726012AbgHNKbj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 14 Aug 2020 06:31:39 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 7D261B755104A40B5844;
        Fri, 14 Aug 2020 11:31:37 +0100 (IST)
Received: from localhost (10.52.125.31) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Fri, 14 Aug
 2020 11:31:37 +0100
Date:   Fri, 14 Aug 2020 11:30:08 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Christian Eggers <ceggers@arri.de>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: hrtimer-trigger: Mark hrtimer to expire in
 hard interrupt context
Message-ID: <20200814113008.00002733@Huawei.com>
In-Reply-To: <4236c3e3-6c7b-a4fc-3d25-1edf4eebec3e@metafoo.de>
References: <20200813075358.13310-1-lars@metafoo.de>
        <20200813091107.kjelslak2jxkkc42@linutronix.de>
        <930e6dc4-df6f-416b-0df3-dab7177af974@metafoo.de>
        <20200813112741.grdytusuwrlskpwa@linutronix.de>
        <877du2louq.fsf@nanos.tec.linutronix.de>
        <20200813155519.00000684@Huawei.com>
        <4236c3e3-6c7b-a4fc-3d25-1edf4eebec3e@metafoo.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.125.31]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 14 Aug 2020 07:24:52 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 8/13/20 4:55 PM, Jonathan Cameron wrote:
> > On Thu, 13 Aug 2020 14:19:57 +0200
> > Thomas Gleixner <tglx@linutronix.de> wrote:
> >  
> >> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:  
> >>> On 2020-08-13 11:46:30 [+0200], Lars-Peter Clausen wrote:  
> >>>> If you are running with forced IRQ threads the only thing that will then
> >>>> happen in the actual hard IRQ context is the launching of the IRQ threads.
> >>>> Th e IRQ handler of the device driver will run in a threaded IRQ.  
> >>> So if it is really just the wakeup of the IRQ-thread then it should be
> >>> okay.
> >>> One thing: iio_trigger_poll() may invoke iio_trigger_notify_done(). This
> >>> would invoke trig->ops->try_reenable callback if available.
> >>> I grepped and found
> >>> - bma180_trig_try_reen()
> >>>    It appears to perform i2c_smbus_read_byte_data() and smbus sounds
> >>>    sleeping. I don't know if it attempts to acquire any spinlock_t but it
> >>>    will be wrong on RT.  
> >> It's wrong even on !RT. i2c reads cannot be invoked from hard interrupt
> >> context.
> >>  
> > We would hit this (and resulting warnings) all the time if it actually
> > happened, so my suspicion is that it doesn't.
> >
> > I think the path doesn't actually exist although it looks at first glance like it does.
> >
> > The interrupt can only be enabled if there is someone using the trigger.
> > Thus usecount will be non zero and for at least one element
> > trig->subirq[i].enabled == true
> >
> > So we will decrement trig->usecount in the call to iio_trigger_notify_done
> > but never reach 0 thus the call to trig->ops->try_reenable never happens
> > in the hard interrupt context.  
> 
> I think there is a race condition here. If a consumer is disabled 
> concurrently with iio_trigger_poll() there is a chance that `enabled` is 
> false for all consumers.
> 
> The odds of this happening are very low, but there is nothing that 
> prevents it. 

A consumer disable should have previously resulted in the trigger stopping
(or do we have he ordering wrong there?)  Might be worth checking that, but
see below, as I think we can stop it having harmful effects anyway.

> 
> >
> > It does happen later when which ever driver we triggered finishes the
> > threaded part of it's handler and calls iio_trigger_notify_done, but that
> > is fine.
> >
> > Assuming people agree with my analysis it would be good to make it explicit
> > that we cannot hit the problem path.
> >
> > Perhaps call a new iio_trigger_notify_no_needed() that simply does
> > the decrement without test, or does it with test and spits out a
> > warning if we hit 0.  
> 
> I think we need to re-think the whole try_reenable() functionality. 
> Looking at it I think there are more issues here.
> 
> For example lets say we call iio_trigger_notify_done() from the threaded 
> handler and try_reenable() returns true. We'd now call 
> iio_trigger_poll() from the threaded context, which is wrong.

The history behind that functionality was some early devices which were using
level interrupts tied to edge interrupts.  One of our earliest drivers had to
do a dance with checking a gpio to avoid stalling.   That went away a long
time ago when we basically concluded that platform was too broken to support
interrupts on.

Probably would have helped if try_reenable returned a bool as then people wouldn't
have returned error codes via it which is completely wrong as it stands (though
handy given what I suggest below)

From a quick look.
bma180, bmc150, kxcjk1013, mxc4005m bmg180, kmx61, bmc150
all only fail if an error occurs in an bus access. That's a bug.

at91 never returns anything other than 0.

So I think we can probably rip the iio_trigger_poll call out entirely
and replace it with an error message, or push an error message into
the drivers and drop the check of the value of try_reenable.

> 
> There is also the issue that iio_trigger_poll() effectively can end up 
> calling itself recursively indefinitely via the 
> iio_trigger_notify_done() chain, which might not be the best thing in 
> hard IRQ context.
> 

:) Indeed unwise.  I think the only driver that could in theory do this
that we had a long time back had a counter in the try_reen to give
up if it happened more than a few times.

Jonathan


