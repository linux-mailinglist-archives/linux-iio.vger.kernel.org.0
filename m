Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA7A27259F
	for <lists+linux-iio@lfdr.de>; Mon, 21 Sep 2020 15:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgIUNdr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Sep 2020 09:33:47 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2905 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726496AbgIUNdr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 21 Sep 2020 09:33:47 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id A78BCC3299A23FE33679;
        Mon, 21 Sep 2020 14:33:45 +0100 (IST)
Received: from localhost (10.52.121.13) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 21 Sep
 2020 14:33:45 +0100
Date:   Mon, 21 Sep 2020 14:32:06 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     Christian Eggers <ceggers@arri.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, Andy Duan <fugang.duan@nxp.com>
Subject: Re: [PATCH 1/2] iio: hrtimer-trigger: Mark hrtimer to expire in
 hard interrupt context
Message-ID: <20200921143206.00006b43@Huawei.com>
In-Reply-To: <20200921122728.xaamqfkt5wrbppuy@linutronix.de>
References: <20200813075358.13310-1-lars@metafoo.de>
        <20200814113008.00002733@Huawei.com>
        <20200920191545.4ed79276@archlinux>
        <5007153.c9bsiqU2ZW@n95hx1g2>
        <20200921105703.000048b3@Huawei.com>
        <20200921122728.xaamqfkt5wrbppuy@linutronix.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.13]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 21 Sep 2020 14:27:28 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2020-09-21 10:57:03 [+0100], Jonathan Cameron wrote:
> > So looking at this the other way, are there any significant risks associated
> > with this change?  If not I'm tempted to queue them up and we have the rcX
> > time to fix anything we've missed (just like every other patch!)  
> 
> I've been told that it only performs IRQ-thread wake-ups in hard-IRQ
> context. This is fine then.
> 
> Looking at the other series where ->try_renable() got renamed. It still
> looks like bmc150_accel_trig_try_reen() may acquire a mutex. Is it still
> the case or do I miss something essential?

True.  We could safely drop the mutex there as it's not doing anything useful,
but it can sleep anyway as it's doing a bus write.

So question is whether we can actually hit that path.  I think the reality is
no (almost - see below), even though it looks like it from a high level.

The path would be that we enter iio_trigger_poll() in interrupt context.
That will call generic_handle_irq() to trigger individual devices that are
using this trigger.
It will also call iio_trigger_notify_done() to decrement the counter for
spare outputs of the irq_chip().

It doesn't actually matter if the problem iio_trigger_notify_done()
(the one that results in a count of 0 and hence reenable()) occurs
as a result of generic_handle_irq() or the direct call of iio_trigger_notify_done()
either way it can only happen if we have any drivers calling iio_trigger_notify_done()
in interrupt context

Someone who is better at coccinelle than me could probably automate checking this.

Given this is always called after reading the data we should be safe for
any device that requires sleeping.  So that just leaves a few SoC ADCs to audit.
Thankfully most of them don't implement triggered buffers. Of the ones that do only
one doesn't call it from a threaded interrupt handler.

drivers/iio/adc/vf610-adc.c

However, there looks to be a lot more wrong in there than just this.
So normally for a device with a data ready signal like this we would hook
up as follows.

Data ready #1 -> IRQ chip (trigger) ->  Read sensor #1 + iio_trigger_notify_done()
                                    ->  Read sensor #2 + iio_trigger_notify_done()

(note that the read etc is normally in a thread - all we do in interrupt context is usually to
 grab a timestamp if that makes sense for a given sensor).

This driver does both of.
Data ready -> Read data from itself and call iio_trigger_notify_done()
IRQ chip for a different trigger -> Take a timestamp and never call iio_trigger_notify_done()
  or read any data for that matter.

Which won't do what we want at all.

Andy, if I have a go at fixing this are you able to test the result?
I think the simplest is probably to introduce a trigger to tie the two halves together.
We can set it as the default trigger so things should keep on working for existing users.

For more general case, we should probably have two functions.

iio_trigger_notify_done() which is only called from places we can sleep.
iio_trigger_notify_done_no_action() which only decrements the counter
(or given this is only called inside industrialio-trigger.c could just replace
 with atomic_dec(&trig->use_count)).

That change is about avoiding confusion rather than fixing a bug and I think
tangential to both of the currently changes.

Thanks Sebastian. You are certainly finding some rats holes in my code :)

Jonathan

> 
> > Jonathan  
> 
> Sebastian


