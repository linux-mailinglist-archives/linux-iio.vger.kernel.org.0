Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4563F47C6
	for <lists+linux-iio@lfdr.de>; Mon, 23 Aug 2021 11:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbhHWJkw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Aug 2021 05:40:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:12525 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235791AbhHWJkv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Aug 2021 05:40:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10084"; a="217096394"
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="217096394"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 02:40:08 -0700
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="492637851"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 02:40:06 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mI6Qy-00CjSH-Iz; Mon, 23 Aug 2021 12:40:00 +0300
Date:   Mon, 23 Aug 2021 12:40:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3.1 2/3] iio: chemical: Add Senseair Sunrise 006-0-007
 driver
Message-ID: <YSNs8Oo+1oMZ5TJS@smile.fi.intel.com>
References: <20210822184927.94673-3-jacopo@jmondi.org>
 <20210823073639.13688-1-jacopo@jmondi.org>
 <YSNdywXOuzYMCbJa@smile.fi.intel.com>
 <20210823090610.hr6a7wjhkpyuupxv@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823090610.hr6a7wjhkpyuupxv@uno.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 23, 2021 at 11:06:10AM +0200, Jacopo Mondi wrote:
> On Mon, Aug 23, 2021 at 11:35:23AM +0300, Andy Shevchenko wrote:
> > On Mon, Aug 23, 2021 at 09:36:39AM +0200, Jacopo Mondi wrote:

...

> > Thanks for this intermediate update, looks much better.
> > So, there are a few comments below and we are almost ready.
> 
> Thanks, I would also like feedback on the usage of channel's
> ext_info to handle calibration instead of using raw attributes as
> suggested by Matt

Better to wait for Jonathan.

...

> > > +	depends on SYSFS
> 
> Do you think I need this ? The driver includes iio/sysfs.h but I found
> no symbol nor dependency for that

Ditto.

...

> > Also, since it's one time use, please drop the definition completely and use
> > literal in-place.

> I got two usages
>         ...
> 	iio_dev->name = DRIVER_NAME;
> 
>         ...
> 	.driver = {
> 		.name = DRIVER_NAME,
> 
> Is it ok to keep it ?

Ah, okay then!

...

> > > +	errors = (const unsigned long *)&value;
> >
> > Yes, it takes a pointer, but in your case it will oops the kernel quite likely.
> 
> The usage of a pointer kind of puzzled me in first place, and I found
> no pattern to copy in the existing code base. I have probbaly not
> looked hard enough ?
> 
> > 	unsigned long errors;
> >
> > 	...
> >
> > 	errors = value;
> > 	for_each_set_bit(..., &errors, ...)
> 
> I can do so but, for my education mostly, why do you think it would
> oops ? '*errors' is a pointer to a variable allocated on the stack as
> much as 'errors' you suggested is a local stack variable. I might be a
> bit slow today, but I'm missing the difference. FWIW I tested the
> function, even if there were no error bits set at the moment I tested, but
> the for_each_set_bit() macro was indeed run.

Because you theoretically access bytes behind 16-bit. That castings just ugly
and compiler should warn you about if it is clever enough.

If you found it in the existing code, please, fix it there, so quite bad
pattern won't spread.

> > > +	for_each_set_bit(i, errors, ARRAY_SIZE(error_codes))
> > > +		len += sysfs_emit_at(buf, len, "%s ", sunrise_error_statuses[i]);

...

> > > +static struct regmap_config sunrise_regmap_config = {
> > > +	.reg_bits = 8,
> > > +	.val_bits = 8,
> >
> > Does it need a lock?
> > (I think it does, but I would like to confirm)
> 
> You know, I had the same doubt, but the description of a few fields of
> struct regmap_config lead me to think there's a locking mechanism
> already inplace

Exactly! But see below.

>  * @disable_locking: This regmap is either protected by external means or
>  *                   is guaranteed not to be accessed from multiple threads.
>  *                   Don't use any locking mechanisms.
>  * @lock:	  Optional lock callback (overrides regmap's default lock
>  *		  function, based on spinlock or mutex).
> 
> As you can see 'lock' is option and is said to override regmap's default
> lock functions. Locking seems to have be disabled explicitely
> through 'disable_locking' too. I was then expecting a reference to a
> locally declared mutex/spinlock to be passed through regmap_config
> if the regmap's locking mechanism requires driver-allocated locking
> primitives. This suggests to me there's an internal locking.
> 
> In facts, regmap's core seems to have an internal mutex and a built-in
> locking mechanism, as shown by __regmap_init(), which selects the
> opportune locking primitive according to how regmap_config is
> initialized. In our case it seems it relies on the usage of the
> regmap_lock_mutex() and regmap_unlock_mutex() functions, which use
> struct regmap.mutex.
> 
> I think we're then safe locking-wise, do you agree ?

My point is do you need regmap locking mechanism to be used or not?

> That said, as I'm not pushing to have the driver accepted for this
> merge window, for which we might be late already, I would wait for
> comments on the usage of the ext_channel abstraction from IIO people
> before submitting a new version if that's fine with everyone.

-- 
With Best Regards,
Andy Shevchenko


