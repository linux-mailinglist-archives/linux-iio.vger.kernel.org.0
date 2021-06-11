Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3323A4886
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jun 2021 20:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhFKSXU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Jun 2021 14:23:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230188AbhFKSXU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 11 Jun 2021 14:23:20 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78BF9613C6;
        Fri, 11 Jun 2021 18:21:13 +0000 (UTC)
Date:   Fri, 11 Jun 2021 19:23:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aleksei Mamlin <mamlinav@gmail.com>,
        Dan Robertson <dan@dlrobertson.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Harinath Nampally <harinath922@gmail.com>,
        Jelle van der Waa <jelle@vdwaa.nl>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Sean Nyekjaer <sean@geanix.com>,
        Tomas Melin <tomas.melin@vaisala.com>
Subject: Re: [PATCH 00/12] iio:accel: Header Cleanups.
Message-ID: <20210611192303.755392d1@jic23-huawei>
In-Reply-To: <CAHp75VdXBQ6FryYrizD=Aw1PPWpLw=2wE-z3vyvwT1A7Ks-Rsw@mail.gmail.com>
References: <20210611171355.202903-1-jic23@kernel.org>
        <CAHp75VdXBQ6FryYrizD=Aw1PPWpLw=2wE-z3vyvwT1A7Ks-Rsw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 11 Jun 2021 20:48:08 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Jun 11, 2021 at 8:14 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > 0-day recently started running the include-what-you-use checker with LLVM builds.
> > After it identified a header we should have dropped in a particular patch,
> > I decided to experiment with it a little and see if it was useful for tidying
> > up includes that have gotten rather out of sync with the code over the years.
> >
> > Note the tool is something I'd only advocate using to give you hints on what
> > might want adjusting so each of these was done by hand inspection.
> >
> > I've grouped them by manufacturer as otherwise we would have a lot of patches.
> > Note that the big 'many device / device type' drivers have been done separately
> > so you won't see them in this series.
> >
> > I'm rather hoping this approach may ease getting reviews of these, but we
> > shall see.  If people have time to look at ones I haven't directly cc'd them
> > on that would be great. There are some drivers touched in here where I don't
> > know of a current maintainer.  
> 
> Same comment as per staging series.
> 
> I know that kernel.h provides some crucial everywhere used macros /
> helpers which are in the TODO list to be split.
> 
> I would recommend dropping kernel.h from the drivers and see what's missed.
> 
> These series probably need to be based on splitting out container_of()
> and ARRAY_SIZE() first.

Tool obligingly tells me at least one item from kernel.h and you have
the correct pair (occasionally it's the kernel specific string routines).
e.g.
 #include "linux/kernel.h"                         // for kstrtouint, ARRAY_SIZE

> 
> So, no tag from me for now (but I like the idea in general, and thanks
> for looking into this).
> 

The tool is rather a blunderbuss for this job which makes it rather time
consuming to use.

Splitting kernel.h up is a step beyond where I'm interested in going
at this stage because it's sure to involve a lot of bike shedding.

I 'could' just drop the kernel.h where added on the basis we were clearly
getting it indirectly. I've not included a whole bunch of other suggestions
on that basis.

Note I didn't include a whole bunch of other headers on the basis
they were a bit more esoteric.

To give an idea of how noisy this is here's the output another file...

drivers/iio/trigger/stm32-timer-trigger.c should add these lines:
#include <stddef.h>                               // for NULL, size_t
#include <stdint.h>                               // for uintptr_t
#include <sys/types.h>                            // for ssize_t
#include "asm-generic/div64.h"                    // for do_div
#include "asm-generic/errno-base.h"               // for EINVAL, ENOMEM, EBUSY
#include "asm-generic/int-ll64.h"                 // for u32
#include "asm/page_types.h"                       // for PAGE_SIZE
#include "linux/clk.h"                            // for clk_enable, clk_dis...
#include "linux/compiler_attributes.h"            // for __maybe_unused
#include "linux/dev_printk.h"                     // for dev_err
#include "linux/device.h"                         // for dev_get_drvdata
#include "linux/device/driver.h"                  // for device_driver
#include "linux/export.h"                         // for EXPORT_SYMBOL
#include "linux/gfp.h"                            // for GFP_KERNEL
#include "linux/iio/types.h"                      // for IIO_CHAN_INFO_ENABLE
#include "linux/kernel.h"                         // for kstrtouint, ARRAY_SIZE
#include "linux/list.h"                           // for INIT_LIST_HEAD, lis...
#include "linux/mod_devicetable.h"                // for of_device_id
#include "linux/mutex.h"                          // for mutex_lock, mutex_u...
#include "linux/of.h"                             // for of_property_read_u32
#include "linux/pm.h"                             // for SIMPLE_DEV_PM_OPS
#include "linux/regmap.h"                         // for regmap_update_bits
#include "linux/stddef.h"                         // for true, false
#include "linux/string.h"                         // for strstr, strlen, str...
#include "linux/sysfs.h"                          // for sysfs_emit, attribu...
#include "linux/types.h"                          // for bool, list_head
#include "vdso/bits.h"                            // for BIT

drivers/iio/trigger/stm32-timer-trigger.c should remove these lines:

The full include-list for drivers/iio/trigger/stm32-timer-trigger.c:
#include <linux/iio/iio.h>                        // for iio_priv, IIO_SEPARATE
#include <linux/iio/sysfs.h>                      // for iio_dev_attr, IIO_D...
#include <linux/iio/timer/stm32-timer-trigger.h>  // for TIM4_TRGO, TIM1_TRGO
#include <linux/iio/trigger.h>                    // for iio_trigger, to_iio...
#include <linux/mfd/stm32-timers.h>               // for TIM_CR1, TIM_CR2
#include <linux/module.h>                         // for MODULE_ALIAS, MODUL...
#include <linux/of_device.h>                      // for of_match_device
#include <linux/platform_device.h>                // for platform_get_drvdata
#include <stddef.h>                               // for NULL, size_t
#include <stdint.h>                               // for uintptr_t
#include <sys/types.h>                            // for ssize_t
#include "asm-generic/div64.h"                    // for do_div
#include "asm-generic/errno-base.h"               // for EINVAL, ENOMEM, EBUSY
#include "asm-generic/int-ll64.h"                 // for u32
#include "asm/page_types.h"                       // for PAGE_SIZE
#include "linux/clk.h"                            // for clk_enable, clk_dis...
#include "linux/compiler_attributes.h"            // for __maybe_unused
#include "linux/dev_printk.h"                     // for dev_err
#include "linux/device.h"                         // for dev_get_drvdata
#include "linux/device/driver.h"                  // for device_driver
#include "linux/export.h"                         // for EXPORT_SYMBOL
#include "linux/gfp.h"                            // for GFP_KERNEL
#include "linux/iio/types.h"                      // for IIO_CHAN_INFO_ENABLE
#include "linux/kernel.h"                         // for kstrtouint, ARRAY_SIZE
#include "linux/list.h"                           // for INIT_LIST_HEAD, lis...
#include "linux/mod_devicetable.h"                // for of_device_id
#include "linux/mutex.h"                          // for mutex_lock, mutex_u...
#include "linux/of.h"                             // for of_property_read_u32
#include "linux/pm.h"                             // for SIMPLE_DEV_PM_OPS
#include "linux/regmap.h"                         // for regmap_update_bits
#include "linux/stddef.h"                         // for true, false
#include "linux/string.h"                         // for strstr, strlen, str...
#include "linux/sysfs.h"                          // for sysfs_emit, attribu...
#include "linux/types.h"                          // for bool, list_head
#include "vdso/bits.h"                            // for BIT
