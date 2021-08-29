Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386173FAD1A
	for <lists+linux-iio@lfdr.de>; Sun, 29 Aug 2021 18:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbhH2QSy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Aug 2021 12:18:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235624AbhH2QSx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Aug 2021 12:18:53 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CCA760ED4;
        Sun, 29 Aug 2021 16:17:58 +0000 (UTC)
Date:   Sun, 29 Aug 2021 17:21:13 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3.1 2/3] iio: chemical: Add Senseair Sunrise 006-0-007
 driver
Message-ID: <20210829172113.10f3cd27@jic23-huawei>
In-Reply-To: <CAHp75Vc4gSEn_3=5ixWr4WFyKwXDMMC8SaoBkZNotZ+GP6wMWA@mail.gmail.com>
References: <20210822184927.94673-3-jacopo@jmondi.org>
        <20210823073639.13688-1-jacopo@jmondi.org>
        <YSNdywXOuzYMCbJa@smile.fi.intel.com>
        <20210823090610.hr6a7wjhkpyuupxv@uno.localdomain>
        <YSNs8Oo+1oMZ5TJS@smile.fi.intel.com>
        <20210823101911.4kzsdolwxdrpnyxt@uno.localdomain>
        <CAHp75Vc4gSEn_3=5ixWr4WFyKwXDMMC8SaoBkZNotZ+GP6wMWA@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 23 Aug 2021 14:09:21 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Mon, Aug 23, 2021 at 1:20 PM Jacopo Mondi <jacopo@jmondi.org> wrote:
> > On Mon, Aug 23, 2021 at 12:40:00PM +0300, Andy Shevchenko wrote:  
> > > On Mon, Aug 23, 2021 at 11:06:10AM +0200, Jacopo Mondi wrote:  
> > > > On Mon, Aug 23, 2021 at 11:35:23AM +0300, Andy Shevchenko wrote:  
> > > > > On Mon, Aug 23, 2021 at 09:36:39AM +0200, Jacopo Mondi wrote:  
> 
> ...
> 
> > > > > > +       errors = (const unsigned long *)&value;  
> > > > >
> > > > > Yes, it takes a pointer, but in your case it will oops the kernel quite likely.  
> > > >
> > > > The usage of a pointer kind of puzzled me in first place, and I found
> > > > no pattern to copy in the existing code base. I have probbaly not
> > > > looked hard enough ?
> > > >  
> > > > >   unsigned long errors;
> > > > >
> > > > >   ...
> > > > >
> > > > >   errors = value;
> > > > >   for_each_set_bit(..., &errors, ...)  
> > > >
> > > > I can do so but, for my education mostly, why do you think it would
> > > > oops ? '*errors' is a pointer to a variable allocated on the stack as
> > > > much as 'errors' you suggested is a local stack variable. I might be a
> > > > bit slow today, but I'm missing the difference. FWIW I tested the
> > > > function, even if there were no error bits set at the moment I tested, but
> > > > the for_each_set_bit() macro was indeed run.  
> > >
> > > Because you theoretically access bytes behind 16-bit. That castings just ugly
> > > and compiler should warn you about if it is clever enough.  
> >
> > I don't think there's such a risk as I limit the search space to
> > ARRAY_SIZE(error_codes), but I agree the cast is ugly and I'll change
> > to what you suggested  
> 
> More for the sake of education. Actually it's not theoretical. Some
> architectures may not access longs on unaligned (16-bit) addresses.
> So, yes, oops is probable.
> Another example is reading the long to the register. This can cross
> the page boundary and produce fault (again) oops.

For extra giggles, (and I'm half asleep today so may have this backwards)
what it the platform is big endian and you do this?  I'm fairly sure it will
walk the bits from low to high and so the first access will be off the end
of your shorter type being as it will be at addr + sizeof (long) - 1 bit 7.

> 
> > > If you found it in the existing code, please, fix it there, so quite bad
> > > pattern won't spread.  
> >
> > My point was that I was not able to find any pattern to copy from :)
> >  
> > > > > > +       for_each_set_bit(i, errors, ARRAY_SIZE(error_codes))
> > > > > > +               len += sysfs_emit_at(buf, len, "%s ", sunrise_error_statuses[i]);  
> 

