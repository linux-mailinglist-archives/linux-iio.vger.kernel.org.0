Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9BB3F487E
	for <lists+linux-iio@lfdr.de>; Mon, 23 Aug 2021 12:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbhHWKTI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Aug 2021 06:19:08 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:33967 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235993AbhHWKTH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Aug 2021 06:19:07 -0400
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 60B19240008;
        Mon, 23 Aug 2021 10:18:21 +0000 (UTC)
Date:   Mon, 23 Aug 2021 12:19:11 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3.1 2/3] iio: chemical: Add Senseair Sunrise 006-0-007
 driver
Message-ID: <20210823101911.4kzsdolwxdrpnyxt@uno.localdomain>
References: <20210822184927.94673-3-jacopo@jmondi.org>
 <20210823073639.13688-1-jacopo@jmondi.org>
 <YSNdywXOuzYMCbJa@smile.fi.intel.com>
 <20210823090610.hr6a7wjhkpyuupxv@uno.localdomain>
 <YSNs8Oo+1oMZ5TJS@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YSNs8Oo+1oMZ5TJS@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello,

On Mon, Aug 23, 2021 at 12:40:00PM +0300, Andy Shevchenko wrote:
> On Mon, Aug 23, 2021 at 11:06:10AM +0200, Jacopo Mondi wrote:
> > On Mon, Aug 23, 2021 at 11:35:23AM +0300, Andy Shevchenko wrote:
> > > On Mon, Aug 23, 2021 at 09:36:39AM +0200, Jacopo Mondi wrote:
>
> ...
>
> > > Thanks for this intermediate update, looks much better.
> > > So, there are a few comments below and we are almost ready.
> >
> > Thanks, I would also like feedback on the usage of channel's
> > ext_info to handle calibration instead of using raw attributes as
> > suggested by Matt
>
> Better to wait for Jonathan.
>
> ...
>
> > > > +	depends on SYSFS
> >
> > Do you think I need this ? The driver includes iio/sysfs.h but I found
> > no symbol nor dependency for that
>
> Ditto.
>
> ...
>
> > > Also, since it's one time use, please drop the definition completely and use
> > > literal in-place.
>
> > I got two usages
> >         ...
> > 	iio_dev->name = DRIVER_NAME;
> >
> >         ...
> > 	.driver = {
> > 		.name = DRIVER_NAME,
> >
> > Is it ok to keep it ?
>
> Ah, okay then!
>
> ...
>
> > > > +	errors = (const unsigned long *)&value;
> > >
> > > Yes, it takes a pointer, but in your case it will oops the kernel quite likely.
> >
> > The usage of a pointer kind of puzzled me in first place, and I found
> > no pattern to copy in the existing code base. I have probbaly not
> > looked hard enough ?
> >
> > > 	unsigned long errors;
> > >
> > > 	...
> > >
> > > 	errors = value;
> > > 	for_each_set_bit(..., &errors, ...)
> >
> > I can do so but, for my education mostly, why do you think it would
> > oops ? '*errors' is a pointer to a variable allocated on the stack as
> > much as 'errors' you suggested is a local stack variable. I might be a
> > bit slow today, but I'm missing the difference. FWIW I tested the
> > function, even if there were no error bits set at the moment I tested, but
> > the for_each_set_bit() macro was indeed run.
>
> Because you theoretically access bytes behind 16-bit. That castings just ugly
> and compiler should warn you about if it is clever enough.

I don't think there's such a risk as I limit the search space to
ARRAY_SIZE(error_codes), but I agree the cast is ugly and I'll change
to what you suggested

>
> If you found it in the existing code, please, fix it there, so quite bad
> pattern won't spread.
>

My point was that I was not able to find any pattern to copy from :)

> > > > +	for_each_set_bit(i, errors, ARRAY_SIZE(error_codes))
> > > > +		len += sysfs_emit_at(buf, len, "%s ", sunrise_error_statuses[i]);
>
> ...
>
> > > > +static struct regmap_config sunrise_regmap_config = {
> > > > +	.reg_bits = 8,
> > > > +	.val_bits = 8,
> > >
> > > Does it need a lock?
> > > (I think it does, but I would like to confirm)
> >
> > You know, I had the same doubt, but the description of a few fields of
> > struct regmap_config lead me to think there's a locking mechanism
> > already inplace
>
> Exactly! But see below.
>
> >  * @disable_locking: This regmap is either protected by external means or
> >  *                   is guaranteed not to be accessed from multiple threads.
> >  *                   Don't use any locking mechanisms.
> >  * @lock:	  Optional lock callback (overrides regmap's default lock
> >  *		  function, based on spinlock or mutex).
> >
> > As you can see 'lock' is option and is said to override regmap's default
> > lock functions. Locking seems to have be disabled explicitely
> > through 'disable_locking' too. I was then expecting a reference to a
> > locally declared mutex/spinlock to be passed through regmap_config
> > if the regmap's locking mechanism requires driver-allocated locking
> > primitives. This suggests to me there's an internal locking.
> >
> > In facts, regmap's core seems to have an internal mutex and a built-in
> > locking mechanism, as shown by __regmap_init(), which selects the
> > opportune locking primitive according to how regmap_config is
> > initialized. In our case it seems it relies on the usage of the
> > regmap_lock_mutex() and regmap_unlock_mutex() functions, which use
> > struct regmap.mutex.
> >
> > I think we're then safe locking-wise, do you agree ?
>
> My point is do you need regmap locking mechanism to be used or not?
>

Oh I see, sorry for the useless digression, you were asking if I
should not disable locking, not the other way around!

Anyway, there's a risk for a concurrent read/write when in example
reading the error status and triggering a calibration. There's no
locking at the driver level in those functions as they do not access
shared driver's fields, but on the wire there might be conflicting
transactions, so I think I should keep locking in place.

Thanks
   j

> > That said, as I'm not pushing to have the driver accepted for this
> > merge window, for which we might be late already, I would wait for
> > comments on the usage of the ext_channel abstraction from IIO people
> > before submitting a new version if that's fine with everyone.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
