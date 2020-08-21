Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD1E24D073
	for <lists+linux-iio@lfdr.de>; Fri, 21 Aug 2020 10:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgHUISr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Aug 2020 04:18:47 -0400
Received: from mga18.intel.com ([134.134.136.126]:61662 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgHUISp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Aug 2020 04:18:45 -0400
IronPort-SDR: RsAgte9kPmHpwDYmB08HGlkgYUQhUofyUNxuGPsQCIHW9vZTZYkMKD92icbqe9fxxulU8SKcfQ
 kEHxranHCn6w==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="143123071"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="143123071"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 01:18:44 -0700
IronPort-SDR: DZAu0Bhv0p82AgHROc21YY+qnN/ldKQDm/gj5dXq2i8T457KdSy/io9OmduhKgG2Cy+qf/o6SE
 YGkMNqe3N4eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="327702796"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 21 Aug 2020 01:18:42 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k92Fz-00AI7e-Sz; Fri, 21 Aug 2020 11:18:39 +0300
Date:   Fri, 21 Aug 2020 11:18:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v8 1/3] devres: provide devm_krealloc()
Message-ID: <20200821081839.GH1891694@smile.fi.intel.com>
References: <20200820185110.17828-1-brgl@bgdev.pl>
 <20200820185110.17828-2-brgl@bgdev.pl>
 <20200821081555.GG1891694@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821081555.GG1891694@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Aug 21, 2020 at 11:15:55AM +0300, Andy Shevchenko wrote:
> On Thu, Aug 20, 2020 at 08:51:08PM +0200, Bartosz Golaszewski wrote:

...

> > +static struct devres *to_devres(void *data)
> > +{
> > +	return data - ALIGN(sizeof(struct devres), ARCH_KMALLOC_MINALIGN);
> > +}
> > +
> > +static size_t devres_data_size(size_t total_size)
> > +{
> > +	return total_size - ALIGN(sizeof(struct devres), ARCH_KMALLOC_MINALIGN);
> > +}
> 
> I'm fine with above, but here is a side note, perhaps
> 
> 	offsetof(struct devres,	data)
> 
> will be more practical (no duplication of alignment and hence slightly better
> maintenance)? (Note, I didn't check if it provides the correct result)

And if the result is correct wouldn't be first a simple container_of() after
all?

> Another side note: do we have existing users of these helpers?

-- 
With Best Regards,
Andy Shevchenko


