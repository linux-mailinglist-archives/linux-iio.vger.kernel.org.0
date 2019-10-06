Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAB4CCF79
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2019 10:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfJFIof (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Oct 2019 04:44:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:46532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfJFIof (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 6 Oct 2019 04:44:35 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1516C2084D;
        Sun,  6 Oct 2019 08:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570351474;
        bh=Qf2wrEgOiBLE4CvRNCZMKzOomxtdyr42HQz7czSbh/Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZUa+8iqqCOY9u9t6rIWLLiN44mhLkXg/U6bB3USOYcapHN5mQjCmUp1QGu2MZTxaR
         S73/1eaqnVMPLVPID1dZCiFJPQUZcCQQ4hZPefE+0mhtnhFNX+SRfxwWV5sbXWn+xZ
         yV0Q0nUEKvYFASLrkf7C4RMHydUrr0DWNh+nUze8=
Date:   Sun, 6 Oct 2019 09:44:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, benjamin.gaignard@linaro.org,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        David Lechner <david@lechnology.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: Re: [PATCH v3 0/2] Simplify count_read/count_write/signal_read
Message-ID: <20191006094417.602757a1@archlinux>
In-Reply-To: <20191005171938.GA7199@icarus>
References: <cover.1568816248.git.vilhelm.gray@gmail.com>
        <20191005153255.4290ce81@archlinux>
        <20191005171938.GA7199@icarus>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 5 Oct 2019 13:19:38 -0400
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> On Sat, Oct 05, 2019 at 03:33:08PM +0100, Jonathan Cameron wrote:
> > Hi William,
> > 
> > This all makes sense to me.  Do you want to wait for some more reviews
> > or should I pick them up now through IIO?  We are really early in
> > the cycle so plenty of time, unless there are new drivers coming you
> > want to use these from the start.
> > 
> > Thanks,
> > 
> > Jonathan  
> 
> Getting this in sooner would be better since that will save Fabien from
> having to introduce the COUNTER_COUNT_TALLY type in the cros_ec patch
> submission.
> 
> The only concern left now is that the TI eQEP driver needs to be updated
> as well for these changes, but it's not in the IIO testing branch yet.
> 
> Do you want to merge this patchset first, or wait until TI eQEP makes it
> into the testing branch? Alternatively, I can merge the cros_ec patchset
> and Intel QEP patchset into my personal repository when they are ready,
> then later submit a git pull request to you with these changes if you
> prefer that route.

OK, so I need to do a pull request to be able to move the testing branch
to the point where I can do the immutable branch needed for that TI set.
Should do that later this week. So I'll take the TI eQEP series at that
point. If you want to prep a version of this that includes this driver
that would be great.  Should be able to pull both in next weekend at
the latest.  If it takes a bit longer for you to be ready, no problem!

Thanks,

Jonathan



> 
> William Breathitt Gray
> 
> > On Wed, 18 Sep 2019 23:22:44 +0900
> > William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
> >   
> > > Changes in v3:
> > >  - Squash code changes to single patch to avoid compilation error
> > > 
> > > The changes in this patchset will not affect the userspace interface.
> > > Rather, these changes are intended to simplify the kernelspace Counter
> > > callbacks for counter device driver authors.
> > > 
> > > The following main changes are proposed:
> > > 
> > > * Retire the opaque counter_count_read_value/counter_count_write_value
> > >   structures and simply represent count data as an unsigned integer.
> > > 
> > > * Retire the opaque counter_signal_read_value structure and represent
> > >   Signal data as a counter_signal_value enum.
> > > 
> > > These changes should reduce some complexity and code in the use and
> > > implementation of the count_read, count_write, and signal_read
> > > callbacks.
> > > 
> > > The opaque structures for Count data and Signal data were introduced
> > > originally in anticipation of supporting various representations of
> > > counter data (e.g. arbitrary-precision tallies, floating-point spherical
> > > coordinate positions, etc). However, with the counter device drivers
> > > that have appeared, it's become apparent that utilizing opaque
> > > structures in kernelspace is not the best approach to take.
> > > 
> > > I believe it is best to let userspace applications decide how to
> > > interpret the count data they receive. There are a couple of reasons why
> > > it would be good to do so:
> > > 
> > > * Users use their devices in unexpected ways.
> > > 
> > >   For example, a quadrature encoder counter device is typically used to
> > >   keep track of the position of a motor, but a user could set the device
> > >   in a pulse-direction mode and instead use it to count sporadic rising
> > >   edges from an arbitrary signal line unrelated to positioning. Users
> > >   should have the freedom to decide what their data represents.
> > > 
> > > * Most counter devices represent data as unsigned integers anyway.
> > > 
> > >   For example, whether the device is a tally counter or position
> > >   counter, the count data is represented to the user as an unsigned
> > >   integer value. So specifying that one device is representing tallies
> > >   while the other specifies positions does not provide much utility from
> > >   an interface perspective.
> > > 
> > > For these reasons, the count_read and count_write callbacks have been
> > > redefined to pass count data directly as unsigned long instead of passed
> > > via opaque structures:
> > > 
> > >         count_read(struct counter_device *counter,
> > >                    struct counter_count *count, unsigned long *val);
> > >         count_write(struct counter_device *counter,
> > >                     struct counter_count *count, unsigned long val);
> > > 
> > > Similarly, the signal_read is redefined to pass Signal data directly as
> > > a counter_signal_value enum instead of via an opaque structure:
> > > 
> > >         signal_read(struct counter_device *counter,
> > >                     struct counter_signal *signal,
> > >                     enum counter_signal_value *val);
> > > 
> > > The counter_signal_value enum is simply the counter_signal_level enum
> > > redefined to remove the references to the Signal data "level" data type.
> > > 
> > > William Breathitt Gray (2):
> > >   counter: Simplify the count_read and count_write callbacks
> > >   docs: driver-api: generic-counter: Update Count and Signal data types
> > > 
> > >  Documentation/driver-api/generic-counter.rst |  22 ++--
> > >  drivers/counter/104-quad-8.c                 |  33 ++----
> > >  drivers/counter/counter.c                    | 101 +++----------------
> > >  drivers/counter/ftm-quaddec.c                |  14 +--
> > >  drivers/counter/stm32-lptimer-cnt.c          |   5 +-
> > >  drivers/counter/stm32-timer-cnt.c            |  17 +---
> > >  include/linux/counter.h                      |  74 ++------------
> > >  7 files changed, 53 insertions(+), 213 deletions(-)
> > >   
> >   

