Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CBE3A79DB
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jun 2021 11:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhFOJPo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Jun 2021 05:15:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:37905 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230502AbhFOJPn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 15 Jun 2021 05:15:43 -0400
IronPort-SDR: NWETHXH8amMskh3h9bBfdwrDy6efTtvad/xzfYp+NPMLVXzMbeKBQAw2IgUYmyjRXcVeN+Z7Ob
 P+RIoHLmb6gg==
X-IronPort-AV: E=McAfee;i="6200,9189,10015"; a="193070737"
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="193070737"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 02:13:38 -0700
IronPort-SDR: t+Spk6a99V3Q61bnkehOej8nH5Xu4cq9SSk/dTC4hndjcH7Z+5CDvMfgbKCtXjVd+gaGyVArSc
 sa8ZEeFrE3Sg==
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="484400137"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 02:13:34 -0700
Subject: Re: [PATCH 00/12] iio:accel: Header Cleanups.
To:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
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
References: <20210611171355.202903-1-jic23@kernel.org>
 <CAHp75VdXBQ6FryYrizD=Aw1PPWpLw=2wE-z3vyvwT1A7Ks-Rsw@mail.gmail.com>
 <20210611192303.755392d1@jic23-huawei>
 <CAHp75Vf4DkjGPyneWbOqY-8SC=iSn2V1C3-Vm-batF8wCq=eCw@mail.gmail.com>
 <20210611201903.751cdaf0@jic23-huawei>
 <CAHp75Vfs0GdijtzU=Akw6Am1Cp2fO1=46kt0awBOWVeCAAK=nA@mail.gmail.com>
 <20210611211054.749c801b@jic23-huawei>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <83fa6bcc-6946-5f79-c676-f93827c27fe1@intel.com>
Date:   Tue, 15 Jun 2021 17:13:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20210611211054.749c801b@jic23-huawei>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 6/12/21 4:10 AM, Jonathan Cameron wrote:
> On Fri, 11 Jun 2021 22:36:52 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
>> On Fri, Jun 11, 2021 at 10:17 PM Jonathan Cameron <jic23@kernel.org> wrote:
>>> On Fri, 11 Jun 2021 21:35:06 +0300
>>> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>>> On Fri, Jun 11, 2021 at 9:21 PM Jonathan Cameron <jic23@kernel.org> wrote:
>>>>> On Fri, 11 Jun 2021 20:48:08 +0300
>>>>> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>> ...
>>
>>>> But I understand you and not insisting that you have to go with it. My
>>>> point is that...
>>>>   
>>>>> I 'could' just drop the kernel.h where added on the basis we were clearly
>>>>> getting it indirectly. I've not included a whole bunch of other suggestions
>>>>> on that basis.
>>>> (Which is probably not a good idea, because explicit in this case is
>>>> better than implicit, i.e. kernel.h is not guaranteed to be included
>>>> by other headers and I have long standing work to actually make sure
>>>> that most of the headers won't require kernel.h!)
>>> I think I was unclear, what I was proposing was not to touch includes of
>>> kernel.h at all. So not make anything worse, but also not make it any better.
>>> Where added in this set, kernel.h was for things directly in kernel.h,
>>> not the files it includes.
>> Ah, that's good! That was my main point of worry.
>>
>>>>> Note I didn't include a whole bunch of other headers on the basis
>>>>> they were a bit more esoteric.
>>>>>
>>>>> To give an idea of how noisy this is here's the output another file...
>>>> ...the tool simply doesn't know anything about kernel and header
>>>> guarantees. That's why it tries play dumb.
>>>>
>>>> If you would like to continue with this, please drop the removal of
>>>> the headers that are not guaranteed to be included by others
>>>> (excluding kernel.h from the equation).
>>> This is where the confusion lies... I haven't done that (subject to bugs
>>> of course)
>>>   
>>>> Otherwise it will become
>>>> someone else's problem to _reinstantiate_ all those headers, and since
>>>> I already had a headache with panic.h, I won't repeat it. Still no tag
>>>> from me, although no explicit NAK (actually opposite, no explicit ACK
>>>> because of the dependencies), you just really need to spend more time
>>>> on this.
>>> I've not removed any headers on the basis they were guaranteed to be
>>> included by others. The tool assumes the opposite model - everything
>>> should be explicitly included directly in the file where it's used.
>>> For some files it lists 50+ headers.
>>> These patches are very conservative on that front.
>>>
>>> What I haven't done is included everything under the sun that wasn't
>>> already included.  e.g. I've not included
>>> linux/device/driver.h on the basis it is definitely included by
>>> linux/device.h and that seems very unlikely to change.
>>>
>>> There are some corner cases that are more interesting - such as whether
>>> we can rely on interrupt.h always including irqreturn.h.  Plenty of IIO
>>> drivers don't call anything in interrupt.h because of various wrappers but
>>> do use the return values. So in this case we could switch many of them
>>> to the more specific header, but I haven't done that yet.
>> I guess you may consider a guarantee there.
>>
>> Actually what kernel header mess misses right now is the list of those
>> guarantees.
>>
>> But you see there cases like
>>
>> using dev_err() and struct device * in the same C file, what do you include?
>>
>> Temptation is to go with device.h, but I would go with
>>
>> #include <linux/dev_printk.h>
>>
>> struct device;
>>
>> Not sure if that tool can handle this kind of use.
> It does.  I decided it was a step too far and didn't act on this one
> for da311.c, but here is an example of that case.
>
> drivers/iio/accel/da311.c should add these lines:
> #include "asm-generic/errno-base.h"  // for EINVAL, ENODEV, ENOMEM
> #include "asm-generic/int-ll64.h"    // for u8, u16
> #include "generated/autoconf.h"      // for CONFIG_PM_SLEEP
> #include "linux/dev_printk.h"        // for dev_err
> #include "linux/iio/types.h"         // for IIO_CHAN_INFO_RAW, IIO_CHAN_INFO...
> #include "linux/kernel.h"            // for ARRAY_SIZE
> #include "linux/pm.h"                // for SIMPLE_DEV_PM_OPS
> #include "linux/stddef.h"            // for false, true
> #include "linux/types.h"             // for bool
> #include "vdso/bits.h"               // for BIT
> struct device;
>
> If we can teach the tool (or post process it a bit) about places we
> want to do something beyond the direct (e.g. asm-generic/ernrno-base.h)
> that would make it much more useful.  Even then I think we'll want
> a human in the loop.

Hi,

The tool allows to correct the recommended headers, please see

https://github.com/include-what-you-use/include-what-you-use#how-to-correct-iwyu-mistakes

>
> I'm running an older version than 0-day has been using I think.
>
> +Cc 0-day person who kind of kicked this off :)
>
> Note the warning from 0-day was about a header no longer needing to be included
> (the mutex in the ADIS drivers got recently moved to a wrapper in the library).
> Those warnings are almost certain to be correct - and many of the removals
> in here are things that would have been picked up in similar circumstances.

Yes, 0day only detects useless headers experimentally, we're willing to 
extend the range
if include-what-you-use tool (or other tool) can output a more friendly 
header list.

Best Regards,
Rong Chen

>
> Note things can get a bit silly, even if technically correct...
> + it gets confused on where headers are coming from sometimes.
>
> The full include-list for drivers/iio/industrialio-core.c:
> #include <asm/bug.h>                                 // for WARN
> #include <linux/cdev.h>                              // for cdev_init, cdev_...
> #include <linux/debugfs.h>                           // for debugfs_create_dir
> #include <linux/device.h>                            // for device, device_a...
> #include <linux/err.h>                               // for IS_ERR, PTR_ERR
> #include <linux/fs.h>                                // for noop_llseek, inode
> #include <linux/idr.h>                               // for DEFINE_IDA, ida_...
> #include <linux/iio/iio-opaque.h>                    // for iio_dev_opaque
> #include <linux/iio/iio.h>                           // for iio_dev, iio_cha...
> #include <linux/iio/sysfs.h>                         // for iio_dev_attr
> #include <linux/kdev_t.h>                            // for MAJOR, MKDEV
> #include <linux/kernel.h>                            // for kasprintf, sscanf
> #include <linux/ktime.h>                             // for ktime_get_bootti...
> #include <linux/module.h>                            // for MODULE_AUTHOR
> #include <linux/mutex.h>                             // for mutex_unlock
> #include <linux/property.h>                          // for device_property_...
> #include <linux/slab.h>                              // for kfree, kzalloc
> #include <stddef.h>                                  // for NULL, size_t
> #include <stdint.h>                                  // for uintptr_t
> #include <sys/types.h>                               // for ssize_t, dev_t
> #include "asm-generic/bitops/instrumented-atomic.h"  // for clear_bit, test_...
> #include "asm-generic/errno-base.h"                  // for EINVAL, EBUSY
> #include "asm-generic/int-ll64.h"                    // for s64, u64
> #include "asm/bug.h"                                 // for BUG
> #include "asm/page_types.h"                          // for PAGE_SIZE
> #include "asm/string_64.h"                           // for memcpy
> #include "generated/autoconf.h"                      // for CONFIG_DEBUG_FS
> #include "iio_core.h"                                // for iio_ioctl_handler
> #include "iio_core_trigger.h"                        // for iio_device_regis...
> #include "linux/align.h"                             // for ALIGN
> #include "linux/bitops.h"                            // for for_each_set_bit
> #include "linux/compiler_attributes.h"               // for fallthrough
> #include "linux/compiler_types.h"                    // for __user
> #include "linux/dev_printk.h"                        // for dev_err, dev_info
> #include "linux/device/bus.h"                        // for bus_unregister
> #include "linux/export.h"                            // for EXPORT_SYMBOL_GPL
> #include "linux/gfp.h"                               // for GFP_KERNEL
> #include "linux/hrtimer.h"                           // for hrtimer_resolution
> #include "linux/iio/types.h"                         // for IIO_VAL_INT, IIO...
> #include "linux/init.h"                              // for __exit, __init
> #include "linux/ktime.h"                             // for ktime_to_ns
> #include "linux/list.h"                              // for INIT_LIST_HEAD
> #include "linux/math.h"                              // for abs
> #include "linux/math64.h"                            // for div_s64_rem, div...
> #include "linux/minmax.h"                            // for min_t
> #include "linux/of.h"                                // for of_get_property
> #include "linux/printk.h"                            // for pr_err
> #include "linux/stat.h"                              // for S_IRUGO, S_IWUSR
> #include "linux/stddef.h"                            // for false, true
> #include "linux/string.h"                            // for sysfs_streq, str...
> #include "linux/sysfs.h"                             // for sysfs_emit_at
> #include "linux/time.h"                              // for CLOCK_BOOTTIME
> #include "linux/time64.h"                            // for timespec64_to_ns
> #include "linux/timex.h"                             // for shift_right
> #include "linux/types.h"                             // for list_head, bool
> #include "linux/uaccess.h"                           // for copy_from_user
> #include "vdso/ktime.h"                              // for LOW_RES_NSEC
> struct iio_buffer;
>>> So, in short, the headers for which includes are removed in this series are
>>> not used at all in the files in question (unless I messed up of course!).
>> Cool! So, let bots and other people have more time on eyeballing this.
>> Will see how it goes.
> Sure.
>
> Jonathan

