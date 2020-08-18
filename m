Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47252480D8
	for <lists+linux-iio@lfdr.de>; Tue, 18 Aug 2020 10:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgHRIkY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Aug 2020 04:40:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:40448 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgHRIkX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 Aug 2020 04:40:23 -0400
IronPort-SDR: Bw3/UnTlecjrMYlphDcIdI6ukoDIGKabc40cSWk3elHbBXsVNVo19bBu+WHNqqaSp115D7pR9w
 PiJa1+tHUoCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="216388137"
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="216388137"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 01:40:22 -0700
IronPort-SDR: ZfQNn4ykMKuJGH4oqBnip9509BvoKhkE19++1eEWzlMEvYjXDHPJxm35N6ah0BYqxebZvr2VV2
 J3r5/xOjR9zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,326,1592895600"; 
   d="scan'208";a="326668086"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 18 Aug 2020 01:40:19 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k7wvU-009bYR-P5; Tue, 18 Aug 2020 11:25:00 +0300
Date:   Tue, 18 Aug 2020 11:25:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v7 1/3] devres: provide devm_krealloc()
Message-ID: <20200818082500.GB1891694@smile.fi.intel.com>
References: <20200817170535.17041-1-brgl@bgdev.pl>
 <20200817170535.17041-2-brgl@bgdev.pl>
 <20200817173908.GS1891694@smile.fi.intel.com>
 <CAMRc=MdaaWhV_ZKHgWy_Gxkp=jMuZcwqpoE8Ya_84n9ZT5O31A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MdaaWhV_ZKHgWy_Gxkp=jMuZcwqpoE8Ya_84n9ZT5O31A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 17, 2020 at 10:02:05PM +0200, Bartosz Golaszewski wrote:
> On Mon, Aug 17, 2020 at 7:43 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Aug 17, 2020 at 07:05:33PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

...

> > > +static struct devres *to_devres(void *data)
> > > +{
> > > +     return (struct devres *)((u8 *)data - ALIGN(sizeof(struct devres),
> > > +                                                 ARCH_KMALLOC_MINALIGN));
> >
> > Do you really need both explicit castings?
> >
> 
> Yeah, we can probably drop the (struct devres *) here.

void * -> u8 * here is also not needed, it is considered byte access IIRC.

> > > +}

...

> >  - hasn't gone while you run a ksize()?

> At some point you need to draw a line. In the end: how do you
> guarantee a devres buffer hasn't been freed when you're using it? In
> my comment to the previous version of this patch I clarified that we
> need to protect all modifications of the devres linked list - we must
> not realloc a chunk that contains the links without taking the
> spinlock but also we must not call alloc() funcs with GFP_KERNEL with
> spinlock taken. The issue we could run into is: someone modifies the
> linked list by adding/removing other managed resources, not modifying
> this one.
> 
> The way this function works now guarantees it but other than that:
> it's up to the users to not free memory they're actively using.

Thanks for clarification. I agree.

-- 
With Best Regards,
Andy Shevchenko


