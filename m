Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E1D3F007C
	for <lists+linux-iio@lfdr.de>; Wed, 18 Aug 2021 11:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbhHRJbh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 18 Aug 2021 05:31:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:11326 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233118AbhHRJaa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 18 Aug 2021 05:30:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="214442552"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="214442552"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 02:29:52 -0700
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="520880187"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 02:29:50 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mGHtH-00B404-V0; Wed, 18 Aug 2021 12:29:43 +0300
Date:   Wed, 18 Aug 2021 12:29:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: chemical: Add Senseair Sunrise 006-0-007 driver
Message-ID: <YRzTB/IsdcX/WpbL@smile.fi.intel.com>
References: <20210817154951.50208-1-jacopo@jmondi.org>
 <20210817154951.50208-3-jacopo@jmondi.org>
 <YRvqvt4qVVe1+K1/@smile.fi.intel.com>
 <20210818080213.d56phfmjlwbgzlca@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210818080213.d56phfmjlwbgzlca@uno.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Aug 18, 2021 at 10:02:13AM +0200, Jacopo Mondi wrote:
> On Tue, Aug 17, 2021 at 07:58:38PM +0300, Andy Shevchenko wrote:
> > On Tue, Aug 17, 2021 at 05:49:51PM +0200, Jacopo Mondi wrote:
> > > Add support for the Senseair Sunrise 006-0-0007 driver through the
> > > IIO subsystem.
> >
> > Datasheet tag / link?
> 
> It's reported in the bindings document, I can copy it here

Yes, please, as a tag

Datasheet: ...
Signed-of-by: ...

...

> > > +config SUNRISE
> >
> > Too generic name for configuration and module,
> 
> I got the same feeling but at the same time SUNRISE_006_0_0007 seems a
> bit too long. Would you suggest to go for that one ? Should I also
> rename the .c file accordingly ?

I would go with something like sunrise_air_6 or whatever part of the model.
I haven't read datasheet to propose better naming.

Also possible to have something like sunrise_air_meter.c (and corresponding
Kconfig).

...

> > > + * TODO: Add support for controllable EN pin
> > > + * TODO: Add support for single-shot operations by using the nDRY pin.
> >
> > Ditto.
> >
> > If it's not ready, then make it ready.
> 
> If I place myself in the perspective of someone interested in
> verifying support for this chip in linux, I would first be happy I
> found a driver for it, then I would even be happier if I got a clear
> notice of what features the driver supports and which ones are missing.
> Even more so if I look at bindings and find mention of two GPIO lines
> which I don't see handled in the driver. A TODO note would make it
> clear that those features are missing.
> 
> The "make it ready" it's a little bit a non-sense to me, can you count
> how many drivers support -all- the features a device provides ? In the
> test board I'm using those lines are not even wired, should I throw
> around code I cannot even test ?

My point is that TODO means that somebody is working or will work on this.
Is it the case? Then my comment applies, if not, replace this with something more
realistic, like
 * Feature list that driver does NOT support (yet):
 *  1) ...
 *  2) ...

...

> > > +	i2c_smbus_read_byte(client);
> >
> > Can you use regmap I²C API?
> 
> Do you think it's worth it ?
> I admit I never used regmap API so far, but I always got the
> impression that for such simple devices it's a bit an overkill. What
> benefit would it bring here ?

Some of nice features for debugging and tracing are in the generic support for
free. On top if even this will be part of multi-function device than you won;t
need to rewrite the driver. I would definitely go for it.

...

> > > +			return ret ? ret : IIO_VAL_INT;
> >
> > Can be written as
> >
> > 			return ret ?: IIO_VAL_INT;
> >
> > but up to maintainers.
> >
> 
> You know I never saw this syntax before ? :D
> I'll use it!

It's the C standard :-)

-- 
With Best Regards,
Andy Shevchenko


