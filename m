Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE9D24D337
	for <lists+linux-iio@lfdr.de>; Fri, 21 Aug 2020 12:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgHUKvf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Aug 2020 06:51:35 -0400
Received: from mga07.intel.com ([134.134.136.100]:26746 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728218AbgHUKvZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Aug 2020 06:51:25 -0400
IronPort-SDR: QfG2kwKXAUpGt/bbPReZCfSA/Nfi/bj2vo8KqIF4OvjmW6eQyb3NzqNi+VJeLjCWwpzeB82ul7
 ibrBae9w6KIA==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="219800997"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="219800997"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 03:51:24 -0700
IronPort-SDR: emp+PiYWpmZnAXCHODRvwRxv6bYsWXhzCA/k6wD/LcuxCXUXXMig+vBUxPjZK3dffZbJnIBOH7
 wCtvYqPT0iwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="327730791"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 21 Aug 2020 03:51:21 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k94dj-00AK4V-2U; Fri, 21 Aug 2020 13:51:19 +0300
Date:   Fri, 21 Aug 2020 13:51:19 +0300
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
Message-ID: <20200821105119.GL1891694@smile.fi.intel.com>
References: <20200820185110.17828-1-brgl@bgdev.pl>
 <20200820185110.17828-2-brgl@bgdev.pl>
 <20200821081555.GG1891694@smile.fi.intel.com>
 <CAMRc=Me=D1cOsaRqK-BwHT7f-_=3=eciduA=G95FfE2e_XUWfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=Me=D1cOsaRqK-BwHT7f-_=3=eciduA=G95FfE2e_XUWfg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Aug 21, 2020 at 10:59:19AM +0200, Bartosz Golaszewski wrote:
> On Fri, Aug 21, 2020 at 10:35 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Aug 20, 2020 at 08:51:08PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

...

> > > +static struct devres *to_devres(void *data)
> > > +{
> > > +     return data - ALIGN(sizeof(struct devres), ARCH_KMALLOC_MINALIGN);
> > > +}
> > > +
> > > +static size_t devres_data_size(size_t total_size)
> > > +{
> > > +     return total_size - ALIGN(sizeof(struct devres), ARCH_KMALLOC_MINALIGN);
> > > +}
> >
> > I'm fine with above, but here is a side note, perhaps
> >
> >         offsetof(struct devres, data)
> >
> > will be more practical (no duplication of alignment and hence slightly better
> > maintenance)? (Note, I didn't check if it provides the correct result)
> >
> 
> Hi Andy,
> 
> The data pointer in struct devres is defined as:
> 
>     u8 __aligned(ARCH_KMALLOC_MINALIGN) data[];
> 
> And this value (assigned the value of ARCH_DMA_MINALIGN) varies from
> one arch to another. I wasn't really sure if offsetof() would work for
> every case so I went with something very explicit.

I have checked with a small program simulating to_devres() with your variant,
offsetof() and container_of().

The result is this: if MINALIGN < sizeof(long) and since struct is unpacked the
offsetof(), and thus container_of(), gives correct result, while ALIGN()
approach mistakenly moves pointer too back.

Test results
~~~~~~~~~~~~
sizeof(devres), ALIGN(data), resulting 3 pointers against NULL followed by
actual pointer of allocated struct and 3 pointers against it.

% for i in 1 2 4; do gcc -O2 -Wall -DSZ=$i -o test test.c && ./test | head -n1; done
szof: 24 a: 24 0xffffffffffffffe8 0xffffffffffffffef 0xffffffffffffffef, 0x55a3aa91e2a0: 0x55a3aa91e299 0x55a3aa91e2a0 0x55a3aa91e2a0
szof: 24 a: 24 0xffffffffffffffe8 0xffffffffffffffee 0xffffffffffffffee, 0x563d7b88b2a0: 0x563d7b88b29a 0x563d7b88b2a0 0x563d7b88b2a0
szof: 24 a: 24 0xffffffffffffffe8 0xffffffffffffffec 0xffffffffffffffec, 0x557d08cf82a0: 0x557d08cf829c 0x557d08cf82a0 0x557d08cf82a0

% for i in 1 2 4; do gcc -m32 -O2 -Wall -DSZ=$i -o test test.c && ./test | head -n1; done
szof: 12 a: 12 0xfffffff4 0xfffffff7 0xfffffff7, 0x584301a0: 0x5843019d 0x584301a0 0x584301a0
szof: 12 a: 12 0xfffffff4 0xfffffff6 0xfffffff6, 0x57bd61a0: 0x57bd619e 0x57bd61a0 0x57bd61a0
szof: 12 a: 12 0xfffffff4 0xfffffff4 0xfffffff4, 0x56b491a0: 0x56b491a0 0x56b491a0 0x56b491a0

I think you need to change this to use container_of() and offsetof().

> > Another side note: do we have existing users of these helpers?
> 
> Which ones? Because I assume you're not referring to the ones I'm
> adding in this patch. :)

Opposite, the ones you are introduced here. Meaning that we might convert
existing user(s) in the separate change(s) later on.

-- 
With Best Regards,
Andy Shevchenko


