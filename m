Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998D53528E9
	for <lists+linux-iio@lfdr.de>; Fri,  2 Apr 2021 11:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbhDBJgT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Apr 2021 05:36:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234559AbhDBJgO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 2 Apr 2021 05:36:14 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C935961103;
        Fri,  2 Apr 2021 09:36:10 +0000 (UTC)
Date:   Fri, 2 Apr 2021 10:36:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 0/2] iio: sx9310: Add debouncer-depth parameters
Message-ID: <20210402103621.7403af14@jic23-huawei>
In-Reply-To: <161732394517.2260335.9268876008128877361@swboyd.mtv.corp.google.com>
References: <20210328033639.1021599-1-gwendal@chromium.org>
        <161698755179.3012082.10332557476670862687@swboyd.mtv.corp.google.com>
        <CAPUE2usX-Tq2wyO4ekkAUaR6rRfJ3mZG3SQMqJbpzzUTMwd-0A@mail.gmail.com>
        <20210401141935.1fd2e15d@jic23-huawei>
        <161732394517.2260335.9268876008128877361@swboyd.mtv.corp.google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 01 Apr 2021 17:39:05 -0700
Stephen Boyd <swboyd@chromium.org> wrote:

> Quoting Jonathan Cameron (2021-04-01 06:19:35)
> > On Tue, 30 Mar 2021 17:38:03 -0700
> > Gwendal Grignou <gwendal@chromium.org> wrote:
> >   
> > > On Sun, Mar 28, 2021 at 8:12 PM Stephen Boyd <swboyd@chromium.org> wrote:  
> > > >
> > > > Quoting Gwendal Grignou (2021-03-27 20:36:37)    
> > > > > Semtech SX9310 SAR sensor has a debouncer filter: only when N
> > > > > measurements are above/below the far/close threshold an event is
> > > > > sent to the host.
> > > > > By default the debouncer is set to 2 events for the close to far
> > > > > transition and 1 event (no debounce) for far to close.
> > > > > It is a balance speed of detection and false positive avoidance.
> > > > >
> > > > > On some chromebooks, the debouncer is set to a larger number.
> > > > >
> > > > > This patch applies on top of commit 103d6ec82676 ("iio: sx9310: Support ACPI properties")    
> > > >
> > > > The near/far debounce settings are already supported via sysfs. Can you
> > > > use those instead of putting this into DT/ACPI? See
> > > > sx9310_read_far_debounce() and associated code.    
> > > Stephen, I missed you already proposed these bindings earlier
> > > [https://lore.kernel.org/linux-devicetree/20200906150247.3aaef3a3@archlinux/].
> > > After Jonathan inputs, it is done via sysfs interface
> > > [events/thresh_{falling|rising}_period].
> > > 
> > > The debounce parameters are in the same class as the other parameters
> > > already present in the DT. They are calculated during tests to meet
> > > FCC requirements, in particular the time it takes to detect a human
> > > body near the antennas.  
> 
> The same could be said for the threshold values but those are in sysfs.

Good point.

> 
> > > Depending on the SAR antenna design, it is a balance between lowering
> > > the debouncer "period" to raise an event as soon as possible, and
> > > increasing it to prevent false posible.
> > > 
> > > In addition to controlling it from sysfs, could it be acceptable to
> > > have it in DT/ACPI as well?
> > > In the meantime, I will make sure semtech,sx9310.yaml matches
> > > in_proximityX_hardwaregain_available and connect to that attribute.
> > >   
> 
> My understanding from the previous discussions with Jonathan was that
> anything that could be delayed until later should be done through sysfs.
> That's why only some properties are in DT, because they were used during
> initial compensation of the device that happens when the device driver
> probes. These other values like thresholds and debounce weren't required
> for that so I put them into sysfs.

My intent wasn't so much things that 'could' be delayed until later, but
rather the divide between policy (which should be in userspace control)
and hardware factors. We have a bit of an edge case here so not clear
cut.

I may well have been wrong in the past on this :(

Jonathan

> 
> > 
> > 
> > Ok, add something to make it clear that these effectively tied to the board
> > hardware because of this FCC requirement.
> > 
> > As long as that's clear the Rob is fine with the DT binding I don't mind.
> > 
> > Is there a requirement as a result of this FCC stuff that we should not
> > expose them to userspace control if they are provided in DT?
> > 
> > If so we should figure out a sensible way of doing that without breaking
> > the existing ABI.
> >  

