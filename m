Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58DD24D37C
	for <lists+linux-iio@lfdr.de>; Fri, 21 Aug 2020 13:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgHULEL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Aug 2020 07:04:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:50153 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgHULEL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Aug 2020 07:04:11 -0400
IronPort-SDR: fRbEQ4nk4e9JMPTVyNlX6jWYsfKF6ZENSzlo/Ba5VzRUSve0v1OHhU4i8eK2+/nLidgp6YLeLk
 b0Wl9uztwiuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="240329777"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="240329777"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 04:04:09 -0700
IronPort-SDR: uPIWNjKsgmbTmy5qFnQmjlcXjSPlC9PcnJM8fhrBao6WeY3rUFZ9ULanV04N/M1SeF1IQ6zCSW
 XOvQ5hAYzzlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="327733294"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 21 Aug 2020 04:04:05 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k94q3-00AKBu-B3; Fri, 21 Aug 2020 14:04:03 +0300
Date:   Fri, 21 Aug 2020 14:04:03 +0300
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
Subject: Re: [PATCH v8 1/3] devres: provide devm_krealloc()
Message-ID: <20200821110403.GP1891694@smile.fi.intel.com>
References: <20200820185110.17828-1-brgl@bgdev.pl>
 <20200820185110.17828-2-brgl@bgdev.pl>
 <20200821081555.GG1891694@smile.fi.intel.com>
 <CAMRc=Me=D1cOsaRqK-BwHT7f-_=3=eciduA=G95FfE2e_XUWfg@mail.gmail.com>
 <20200821105119.GL1891694@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821105119.GL1891694@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Aug 21, 2020 at 01:51:19PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 21, 2020 at 10:59:19AM +0200, Bartosz Golaszewski wrote:
> > On Fri, Aug 21, 2020 at 10:35 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Aug 20, 2020 at 08:51:08PM +0200, Bartosz Golaszewski wrote:

...

> > > > +static struct devres *to_devres(void *data)
> > > > +{
> > > > +     return data - ALIGN(sizeof(struct devres), ARCH_KMALLOC_MINALIGN);
> > > > +}
> > > > +
> > > > +static size_t devres_data_size(size_t total_size)
> > > > +{
> > > > +     return total_size - ALIGN(sizeof(struct devres), ARCH_KMALLOC_MINALIGN);
> > > > +}

> > The data pointer in struct devres is defined as:
> > 
> >     u8 __aligned(ARCH_KMALLOC_MINALIGN) data[];
> > 
> > And this value (assigned the value of ARCH_DMA_MINALIGN) varies from
> > one arch to another. I wasn't really sure if offsetof() would work for
> > every case so I went with something very explicit.
> 
> I have checked with a small program simulating to_devres() with your variant,
> offsetof() and container_of().
> 
> The result is this: if MINALIGN < sizeof(long) and since struct is unpacked the
> offsetof(), and thus container_of(), gives correct result, while ALIGN()
> approach mistakenly moves pointer too back.

...

> I think you need to change this to use container_of() and offsetof().

To be clear, there is probably no real problem, except unlikely possible
MINALIGN=4 on 64-bit arch, but for sake of the correctness.


-- 
With Best Regards,
Andy Shevchenko


