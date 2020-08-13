Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4D3243C06
	for <lists+linux-iio@lfdr.de>; Thu, 13 Aug 2020 16:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgHMO4x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Aug 2020 10:56:53 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2601 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726167AbgHMO4w (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 Aug 2020 10:56:52 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 7FFBFF56EC2F74FBFECB;
        Thu, 13 Aug 2020 15:56:50 +0100 (IST)
Received: from localhost (10.52.122.216) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 13 Aug
 2020 15:56:49 +0100
Date:   Thu, 13 Aug 2020 15:55:19 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Christian Eggers" <ceggers@arri.de>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: hrtimer-trigger: Mark hrtimer to expire in
 hard interrupt context
Message-ID: <20200813155519.00000684@Huawei.com>
In-Reply-To: <877du2louq.fsf@nanos.tec.linutronix.de>
References: <20200813075358.13310-1-lars@metafoo.de>
        <20200813091107.kjelslak2jxkkc42@linutronix.de>
        <930e6dc4-df6f-416b-0df3-dab7177af974@metafoo.de>
        <20200813112741.grdytusuwrlskpwa@linutronix.de>
        <877du2louq.fsf@nanos.tec.linutronix.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.122.216]
X-ClientProxiedBy: lhreml741-chm.china.huawei.com (10.201.108.191) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 13 Aug 2020 14:19:57 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
> > On 2020-08-13 11:46:30 [+0200], Lars-Peter Clausen wrote:  
> >> If you are running with forced IRQ threads the only thing that will then
> >> happen in the actual hard IRQ context is the launching of the IRQ threads.
> >> Th e IRQ handler of the device driver will run in a threaded IRQ.  
> >
> > So if it is really just the wakeup of the IRQ-thread then it should be
> > okay.
> > One thing: iio_trigger_poll() may invoke iio_trigger_notify_done(). This
> > would invoke trig->ops->try_reenable callback if available.
> > I grepped and found
> > - bma180_trig_try_reen() 
> >   It appears to perform i2c_smbus_read_byte_data() and smbus sounds
> >   sleeping. I don't know if it attempts to acquire any spinlock_t but it
> >   will be wrong on RT.  
> 
> It's wrong even on !RT. i2c reads cannot be invoked from hard interrupt
> context.
> 

We would hit this (and resulting warnings) all the time if it actually
happened, so my suspicion is that it doesn't.

I think the path doesn't actually exist although it looks at first glance like it does.

The interrupt can only be enabled if there is someone using the trigger.
Thus usecount will be non zero and for at least one element 
trig->subirq[i].enabled == true

So we will decrement trig->usecount in the call to iio_trigger_notify_done
but never reach 0 thus the call to trig->ops->try_reenable never happens
in the hard interrupt context.

It does happen later when which ever driver we triggered finishes the
threaded part of it's handler and calls iio_trigger_notify_done, but that
is fine.

Assuming people agree with my analysis it would be good to make it explicit
that we cannot hit the problem path.  

Perhaps call a new iio_trigger_notify_no_needed() that simply does
the decrement without test, or does it with test and spits out a
warning if we hit 0.

Jonathan

