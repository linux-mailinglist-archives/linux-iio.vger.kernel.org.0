Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B795F39FB8D
	for <lists+linux-iio@lfdr.de>; Tue,  8 Jun 2021 18:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbhFHQCn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Jun 2021 12:02:43 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3180 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbhFHQCn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jun 2021 12:02:43 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FzvtS4bWfz6K5lV;
        Tue,  8 Jun 2021 23:54:08 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 18:00:48 +0200
Received: from localhost (10.52.125.197) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 8 Jun 2021
 17:00:48 +0100
Date:   Tue, 8 Jun 2021 17:00:45 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        "Peter Meerwald" <pmeerw@pmeerw.net>
Subject: Re: atomic use is not atomic?
Message-ID: <20210608170045.00002d8f@Huawei.com>
In-Reply-To: <CAHp75VfAxduG91vu6uCt5VxN-AHRkZROCtXXo06wS74QnBgDqg@mail.gmail.com>
References: <CAHp75VfuoWi72b1wAYoJD_mF6+s-h7k7JCU3CFbEzuGtYBuCZA@mail.gmail.com>
        <eb9f9c75-98c9-0f93-7fd9-565061c78cf0@metafoo.de>
        <CAHp75VeC=trDNkhYbMpeCOYVRK124HPJNVX=tWmfy1Jh5akOzw@mail.gmail.com>
        <b79edabf-593f-81d3-0954-0557a7f73e57@metafoo.de>
        <CAHp75VfAxduG91vu6uCt5VxN-AHRkZROCtXXo06wS74QnBgDqg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.125.197]
X-ClientProxiedBy: lhreml722-chm.china.huawei.com (10.201.108.73) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 8 Jun 2021 16:30:16 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Jun 8, 2021 at 4:22 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
> > On 6/8/21 3:14 PM, Andy Shevchenko wrote:  
> > > On Tue, Jun 8, 2021 at 3:44 PM Lars-Peter Clausen <lars@metafoo.de> wrote:  
> > >> On 6/8/21 2:35 PM, Andy Shevchenko wrote:  
> > >>> Hi!
> > >>>
> > >>> Can anybody explain this code [1] in terms of atomicity?
> > >>>
> > >>>     if (!atomic_read(&trig->use_count)) {
> > >>>       atomic_set(&trig->use_count, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
> > >>>       ...
> > >>>     }
> > >>>
> > >>> AFAIU how atomics are supposed to work the above doesn't do anything
> > >>> atomically. I.o.w. use_count may be simple int with the same effect.
> > >>>  
> > >> The operations here do not require atomic access, it is just operating
> > >> on a atomic type. The atomic access is the atomic_dec_and_test() in
> > >> iio_trigger_notify_done().  
> > > So, between atomic_read and atomic_set somebody can call
> > > atomic_dec_and_test(), for example. Is it a problem to actually lose
> > > the value?
> > > Why are atomic types being used here when there is no atomicity guaranteed?  
> >
> > We know that if the value is zero that there are no more active
> > consumers. Then we set the value to the number of consumers, and then
> > launch the consumers, which will decrement the counter once they are done.  
> 
> So, why atomic type?

Intent is to avoid locking in the release path where a whole bunch of drivers will be
calling this async in their interrupt threads (via the irqchip that is used
to implement the trigger demux).  It might well be a bit of premature optimization!

The suspicious bit here is actually the atomic_read()
as (in the ideal world) we shouldn't be able to get here with out it being 0.

There are reasons that 'might' happen if we have a path where masking is tricky
or somewhat unreliable.  However in those cases, either we are 0 in which case
we won't get any more calls of atomic_dec_and_test() until after the value is
reset to a high value, or we aren't in which case we'll skip this interrupt
and wait for the next one.

> 
> I can see various races with this code.
> 
> For example, we have two CPUs calling the same function (because it's
> hardware driven model)

That's a driver bug if it happens.  This should be called from an interrupt
(probably a thread), possibly a software emulated interrupt, but whatever
it should be impossible to call it concurrently.

> 
> Imagine that one goes into counter 0 (just after the last notify done)
> followed by the atomic_set to something non-zero followed by a
> skipping trigger notification. Next time the loop won't be called,
> because nobody will reduce atomic to 0, right?
> Is it a possible scenario?
> 

Multiple entry in here shouldn't happen.

Having said that..

There is a race though which can happen if a driver has been a bit loose
on how it implements things and the hardware has some annoying 'optimizations'.

Imagine a device (A) that will not set a pulsed interrupt for data_ready again
until after a read of some particular register that is part of the data
read out (rather than a separate clear interrupt register).
This can be device A.

Now, if we aren't careful we have two devices running off the trigger.
The first has this read data to clear data_ready status approach, the
second is something slow (device B)

A gets done quickly, our counter goes to 1, but not 0 (as B is taking ages) and
we get the next data sample from A causing another interrupt.
Data_ready is set again but we never re read the data.

There are three solutions to this that various drivers use.
a) just prevent use of data_ready trigger for other devices via a validate_device() callback.
b) Have a try_reenable() callback for the trigger.  This is called after the counter
   goes to 0.  That causes an additional data read back and hence the extra scan of
   data is dropped (came too fast), but we will get the one after.
c) Grab data in the top level interrupt handler and stash it (thus the data_ready clear
   condition always happens). That data is the available to the driver in the trigger
   handler.  (after it's checked it's using it's own trigger).

This is fiddly and I'm fairly sure we have a few drivers that will fall
down this hole.  We've caught a few over the years though I'm too lazy
to find an example now!  Mostly these were found when someone decided
to use a data_ready from one sensor to trigger an entirely different one,
but not the sensor it was actually indicating data was ready on.

Jonathan

p.s. I suspect the number of people who actually use a data ready signal to trigger
     a different sensor is very small.  Mostly the multi trigger consumer is
     probably used with a hrtimer or similar trigger.  I cared about this case
     in my original application (grabbing pressure sensor data in parallel to
     an accelerometer in a sprinter's shoe ;)



