Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1997725772C
	for <lists+linux-iio@lfdr.de>; Mon, 31 Aug 2020 12:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgHaKRf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 31 Aug 2020 06:17:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:10127 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbgHaKRf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 31 Aug 2020 06:17:35 -0400
IronPort-SDR: Wu3sGQ/Upvbg6GA4EF5UN2c1NhDp2F24+9/QQSFvbur8lH/lI5mokq/rqCparjmDOhlXvhAics
 Od5jpyFkbaMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="144620496"
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="144620496"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 03:17:34 -0700
IronPort-SDR: tFKIJfU1+Gs8rTKUROWweRktanRTMF2gKmOArNIZx0Xl4KUicM+sa2mLwB78N50N60p7O3HDiZ
 1Q3gWHg/LC4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="330644173"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 31 Aug 2020 03:17:33 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1kCgsU-00CyVW-Tn; Mon, 31 Aug 2020 13:17:30 +0300
Date:   Mon, 31 Aug 2020 13:17:30 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 5/8] iio: accel: bma220: Drop ACPI_PTR() and
 accompanying ifdeffery
Message-ID: <20200831101730.GD1891694@smile.fi.intel.com>
References: <20200831090813.78841-1-andriy.shevchenko@linux.intel.com>
 <20200831090813.78841-5-andriy.shevchenko@linux.intel.com>
 <20200831101908.52cb216e@archlinux>
 <CAHp75Ve=p2fNWWAJ5SpQNfA0rH9vDg27YZhFh4vJgzXVhHxL8w@mail.gmail.com>
 <20200831105504.2837cdb1@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831105504.2837cdb1@archlinux>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 31, 2020 at 10:55:04AM +0100, Jonathan Cameron wrote:
> On Mon, 31 Aug 2020 12:39:10 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Mon, Aug 31, 2020 at 12:19 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > > On Mon, 31 Aug 2020 12:08:10 +0300
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > >  
> > > > The driver is quite likely used only on ACPI based platforms and
> > > > rarely build with CONFIG_ACPI=n. Even though, the few dozens of bytes
> > > > is better than ugly ifdeffery and inclusion of heavy header.  
> > >
> > > Given this part is readily available on maker type break out boards
> > > I doubt it is mostly ACPI.  Rest of the comment is fine though.  
> > 
> > In-kernel use seems only ACPI (I grepped for pure SPI driver by name
> > and didn't find anything).
> > I hope we will have DT support for that as well (basically means
> > adding OF ID table).
> > 
> 
> Good to add the explicit DT support, but I think the nasty fallback is
> still in place in which the old style ID table is used if we get a match
> without manufacturer ID.
> 
> So should be possible to instantiate it from DT even without the table.

True, but as I said, there is no evidence that there is a single user in kernel.

-- 
With Best Regards,
Andy Shevchenko


