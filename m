Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFD63A4961
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 21:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhFKTTL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 15:19:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:51834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229824AbhFKTTK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 15:19:10 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67A11613CD;
        Fri, 11 Jun 2021 19:17:08 +0000 (UTC)
Date:   Fri, 11 Jun 2021 20:19:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aleksei Mamlin <mamlinav@gmail.com>,
        Dan Robertson <dan@dlrobertson.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Harinath Nampally <harinath922@gmail.com>,
        Jelle van der Waa <jelle@vdwaa.nl>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Sean Nyekjaer <sean@geanix.com>,
        Tomas Melin <tomas.melin@vaisala.com>
Subject: Re: [PATCH 00/12] iio:accel: Header Cleanups.
Message-ID: <20210611201903.751cdaf0@jic23-huawei>
In-Reply-To: <CAHp75Vf4DkjGPyneWbOqY-8SC=iSn2V1C3-Vm-batF8wCq=eCw@mail.gmail.com>
References: <20210611171355.202903-1-jic23@kernel.org>
        <CAHp75VdXBQ6FryYrizD=Aw1PPWpLw=2wE-z3vyvwT1A7Ks-Rsw@mail.gmail.com>
        <20210611192303.755392d1@jic23-huawei>
        <CAHp75Vf4DkjGPyneWbOqY-8SC=iSn2V1C3-Vm-batF8wCq=eCw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Jun 2021 21:35:06 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Jun 11, 2021 at 9:21 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > On Fri, 11 Jun 2021 20:48:08 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >  
> > > On Fri, Jun 11, 2021 at 8:14 PM Jonathan Cameron <jic23@kernel.org> wrote:  
> > > >
> > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > >
> > > > 0-day recently started running the include-what-you-use checker with LLVM builds.
> > > > After it identified a header we should have dropped in a particular patch,
> > > > I decided to experiment with it a little and see if it was useful for tidying
> > > > up includes that have gotten rather out of sync with the code over the years.
> > > >
> > > > Note the tool is something I'd only advocate using to give you hints on what
> > > > might want adjusting so each of these was done by hand inspection.
> > > >
> > > > I've grouped them by manufacturer as otherwise we would have a lot of patches.
> > > > Note that the big 'many device / device type' drivers have been done separately
> > > > so you won't see them in this series.
> > > >
> > > > I'm rather hoping this approach may ease getting reviews of these, but we
> > > > shall see.  If people have time to look at ones I haven't directly cc'd them
> > > > on that would be great. There are some drivers touched in here where I don't
> > > > know of a current maintainer.  
> > >
> > > Same comment as per staging series.
> > >
> > > I know that kernel.h provides some crucial everywhere used macros /
> > > helpers which are in the TODO list to be split.
> > >
> > > I would recommend dropping kernel.h from the drivers and see what's missed.
> > >
> > > These series probably need to be based on splitting out container_of()
> > > and ARRAY_SIZE() first.  
> >
> > Tool obligingly tells me at least one item from kernel.h and you have
> > the correct pair (occasionally it's the kernel specific string routines).
> > e.g.
> >  #include "linux/kernel.h"                         // for kstrtouint, ARRAY_SIZE  
> 
> Oh yes, kstrtox.h should be born (I have even somewhere in my tree the
> preliminary split).

That set definitely make sense to break out.

> 
> > > So, no tag from me for now (but I like the idea in general, and thanks
> > > for looking into this).
> > >  
> >
> > The tool is rather a blunderbuss for this job which makes it rather time
> > consuming to use.
> >
> > Splitting kernel.h up is a step beyond where I'm interested in going
> > at this stage because it's sure to involve a lot of bike shedding.  
> 
> Not really. There is a kind of consensus about the mentioned
> container_of() and ARRAY_SIZE() and similar to be split out from
> kernel.h.

Ah fair enough. I'd not caught the earlier discussion of this.

> 
> But I understand you and not insisting that you have to go with it. My
> point is that...
> 
> > I 'could' just drop the kernel.h where added on the basis we were clearly
> > getting it indirectly. I've not included a whole bunch of other suggestions
> > on that basis.  
> 
> (Which is probably not a good idea, because explicit in this case is
> better than implicit, i.e. kernel.h is not guaranteed to be included
> by other headers and I have long standing work to actually make sure
> that most of the headers won't require kernel.h!)

I think I was unclear, what I was proposing was not to touch includes of
kernel.h at all. So not make anything worse, but also not make it any better.
Where added in this set, kernel.h was for things directly in kernel.h,
not the files it includes.

> 
> > Note I didn't include a whole bunch of other headers on the basis
> > they were a bit more esoteric.
> >
> > To give an idea of how noisy this is here's the output another file...  
> 
> ...the tool simply doesn't know anything about kernel and header
> guarantees. That's why it tries play dumb.
> 
> If you would like to continue with this, please drop the removal of
> the headers that are not guaranteed to be included by others
> (excluding kernel.h from the equation).

This is where the confusion lies... I haven't done that (subject to bugs
of course)

> Otherwise it will become
> someone else's problem to _reinstantiate_ all those headers, and since
> I already had a headache with panic.h, I won't repeat it. Still no tag
> from me, although no explicit NAK (actually opposite, no explicit ACK
> because of the dependencies), you just really need to spend more time
> on this.

I've not removed any headers on the basis they were guaranteed to be
included by others. The tool assumes the opposite model - everything
should be explicitly included directly in the file where it's used.
For some files it lists 50+ headers.
These patches are very conservative on that front.

What I haven't done is included everything under the sun that wasn't
already included.  e.g. I've not included
linux/device/driver.h on the basis it is definitely included by
linux/device.h and that seems very unlikely to change.

There are some corner cases that are more interesting - such as whether
we can rely on interrupt.h always including irqreturn.h.  Plenty of IIO
drivers don't call anything in interrupt.h because of various wrappers but
do use the return values. So in this case we could switch many of them
to the more specific header, but I haven't done that yet.

So, in short, the headers for which includes are removed in this series are
not used at all in the files in question (unless I messed up of course!).

Jonathan

> 

