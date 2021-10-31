Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACBA440FAD
	for <lists+linux-iio@lfdr.de>; Sun, 31 Oct 2021 18:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhJaRKJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 31 Oct 2021 13:10:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229838AbhJaRKI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 31 Oct 2021 13:10:08 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF284604D2;
        Sun, 31 Oct 2021 17:07:35 +0000 (UTC)
Date:   Sun, 31 Oct 2021 17:12:06 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RFC PATCH 00/11] IIO: Bring core header includes up to date.
Message-ID: <20211031171206.75960513@jic23-huawei>
In-Reply-To: <20211031170854.6990d79e@jic23-huawei>
References: <20211003153306.391766-1-jic23@kernel.org>
        <20211031170854.6990d79e@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 31 Oct 2021 17:08:54 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun,  3 Oct 2021 16:32:55 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > The includes from the various IIO core files have bitrotted
> > over time (and probably were not great in the first place).  
> 
> Given ongoing churn in core kernel includes as Andy cleans them up, I've
> pushed this particular work out on a branch at 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=iio-iwyu-cleanups
> 
> This will get me 0-day exposure and allow me to keep moving these
> forwards as the core kernel headers change.
> 
> I would like to start merging 'some' of these in the meantime and
> there are some precursor cleanup patches that I'll pull out separately.
> 
> Perhaps most 'useful' is the top patch in that branch which is the iwyu
> mapping file I've put together to get it to make more reasonable suggestions.
> Note that there are some cases where the answer isn't obvious and some
> where you can't push iwyu to do the right thing.
> 
> One example is struct regmap which is deliberately opaque.
> iwyu always wants a forwards definition of it in all files where pointers
> to it occur, but personally I think including linux/regmap.h is sufficient
> as that will always have the forwards definition needed.
> 
> Note this branch will rebase frequently and may well eat babies.
> In particularly I will be cherry picking Andy and anyone else's work
> to the top of it and making changes through the rest of the patches as
> that affects them.
> 
> I'm not particularly expecting feedback, but I do want to avoid duplicate
> work.  I'm also likely to 'fixing' new code as it comes in based on this
> toolchain - I may main in reviews or just fix it whilst applying (and tell
> people obviously!)
> 
> Long term plan here is to bring consistency to includes with benefits
> of resilience and hopefully reducing just how much code is actually pulled
> in whilst compiling.

I forgot to mention that I've take a stricter view since doing this series
so it needs an update even in the tree above. This mostly affects 
err.h, errno.h, stddef.h and types.h

I'll update those in that tree sometime this week.
> 
> Thanks,
> 
> Jonathan
> 
> > 
> > This series is based loosely on the suggests the
> > include-what-you-use tool provides but with a lot of discretion applied.
> > Note that tool will tell you:
> > 1) What includes provide elements directly used in a given .c file.
> > 2) What includes are providing nothing that is directly used in the .c file.
> > 3) It will not follow 'include chains', then concept being that anything
> >    used should be defined in a header directly included.
> > It can't always distinguish between different paths to the header and
> > knows nothing about intended include structures in the kernel.
> > (for example including eventpoll.h directly is not intended to be safe,
> >  instead poll.h should be used).
> > 
> > In recent times a lot of code has moved around in IIO and as a result
> > often headers have gotten left behind or haven't made the move along
> > with the code they were there to support.
> > 
> > I made some decisions to reduce includes.
> > 
> > #include <linux/device.h>
> > can be assumed to bring in dev_printk.h and device/bus.h so don't include
> > those directly.
> > #include <linux/err.h>
> > is a good general header to bring in errno.h as well as the various
> > PTR_ERR() macros and similar.
> > #include <linux/poll.h>
> > brings in everything related to polling.
> > #include <linux/irq.h> or <linux/interrupt.h> as appropriate will bring
> > in irqreturn.h.
> > 
> > (probably some other cases I've forgotten about).
> > 
> > Andy has been working on breaking up some of the headers that tend to
> > get included everywhere because they are a pile of unrelated things.
> > Some impact of that can be seen in this series.
> > 
> > I would like to move IIO in the right direction even if we then end
> > up with some additional churn in future reflecting changes in the headers
> > we are using.  This is an RFC primarily because there is a lot of
> > 'interpretation' involved so I'd like to get high level feedback.
> > 
> > I've included below the suggestions iwyu made for reference.
> > As you can see the raw output is mostly useful for highlighting
> > things that should not be there and roughly what should be.
> > 
> > drivers/iio/buffer/kfifo_buf.c should add these lines:
> > #include <stddef.h>                  // for size_t, NULL
> > #include "asm-generic/errno-base.h"  // for EINVAL, EBUSY, ENOMEM
> > #include "linux/compiler_types.h"    // for __user, inline
> > #include "linux/errno.h"             // for ERESTARTSYS
> > #include "linux/export.h"            // for EXPORT_SYMBOL, EXPORT_SYMBOL_GPL
> > #include "linux/gfp.h"               // for GFP_KERNEL
> > #include "linux/log2.h"              // for roundup_pow_of_two
> > #include "linux/stddef.h"            // for true, false
> > #include "vdso/limits.h"             // for UINT_MAX
> > struct attribute;
> > 
> > drivers/iio/buffer/kfifo_buf.c should remove these lines:
> > - #include <linux/poll.h>  // lines 14-14
> > - #include <linux/sched.h>  // lines 13-13
> > - #include <linux/workqueue.h>  // lines 6-6
> > 
> > The full include-list for drivers/iio/buffer/kfifo_buf.c:
> > #include <linux/device.h>            // for devres_add, devres_free, devres_...
> > #include <linux/iio/buffer.h>        // for iio_device_attach_buffer
> > #include <linux/iio/buffer_impl.h>   // for iio_buffer, iio_buffer_init, iio...
> > #include <linux/iio/iio.h>           // for iio_dev, INDIO_BUFFER_SOFTWARE
> > #include <linux/iio/kfifo_buf.h>     // for devm_iio_kfifo_buffer_setup_ext
> > #include <linux/kernel.h>            // for container_of
> > #include <linux/kfifo.h>             // for __kfifo_alloc, kfifo_free, kfifo
> > #include <linux/module.h>            // for MODULE_LICENSE
> > #include <linux/mutex.h>             // for mutex_unlock, mutex_lock, mutex_...
> > #include <linux/slab.h>              // for kfree, kzalloc
> > #include <stddef.h>                  // for size_t, NULL
> > #include "asm-generic/errno-base.h"  // for EINVAL, EBUSY, ENOMEM
> > #include "linux/compiler_types.h"    // for __user, inline
> > #include "linux/errno.h"             // for ERESTARTSYS
> > #include "linux/export.h"            // for EXPORT_SYMBOL, EXPORT_SYMBOL_GPL
> > #include "linux/gfp.h"               // for GFP_KERNEL
> > #include "linux/log2.h"              // for roundup_pow_of_two
> > #include "linux/stddef.h"            // for true, false
> > #include "vdso/limits.h"             // for UINT_MAX
> > struct attribute;
> > 
> > drivers/iio/buffer/industrialio-buffer-cb.c should add these lines:
> > #include <stddef.h>                                  // for NULL, size_t
> > #include "asm-generic/bitops/instrumented-atomic.h"  // for set_bit
> > #include "asm-generic/errno-base.h"                  // for EINVAL, ENOMEM
> > #include "linux/bitmap.h"                            // for bitmap_free, bit...
> > #include "linux/dev_printk.h"                        // for dev_err
> > #include "linux/gfp.h"                               // for GFP_KERNEL
> > #include "linux/list.h"                              // for INIT_LIST_HEAD
> > struct device;
> > 
> > drivers/iio/buffer/industrialio-buffer-cb.c should remove these lines:
> > 
> > The full include-list for drivers/iio/buffer/industrialio-buffer-cb.c:
> > #include <linux/err.h>                               // for ERR_PTR, IS_ERR
> > #include <linux/export.h>                            // for EXPORT_SYMBOL_GPL
> > #include <linux/iio/buffer_impl.h>                   // for iio_buffer, iio_...
> > #include <linux/iio/consumer.h>                      // for iio_channel, iio...
> > #include <linux/iio/iio.h>                           // for INDIO_BUFFER_SOF...
> > #include <linux/kernel.h>                            // for container_of
> > #include <linux/module.h>                            // for MODULE_AUTHOR
> > #include <linux/slab.h>                              // for kfree, kzalloc
> > #include <stddef.h>                                  // for NULL, size_t
> > #include "asm-generic/bitops/instrumented-atomic.h"  // for set_bit
> > #include "asm-generic/errno-base.h"                  // for EINVAL, ENOMEM
> > #include "linux/bitmap.h"                            // for bitmap_free, bit...
> > #include "linux/dev_printk.h"                        // for dev_err
> > #include "linux/gfp.h"                               // for GFP_KERNEL
> > #include "linux/list.h"                              // for INIT_LIST_HEAD
> > struct device;
> > 
> > 
> > drivers/iio/buffer/industrialio-triggered-buffer.c should add these lines:
> > #include <stddef.h>                      // for NULL
> > #include "asm-generic/errno-base.h"      // for ENOMEM
> > #include "linux/device.h"                // for devm_add_action_or_reset
> > #include "linux/interrupt.h"             // for IRQF_ONESHOT
> > #include "linux/irqreturn.h"             // for irqreturn_t
> > struct attribute;
> > 
> > drivers/iio/buffer/industrialio-triggered-buffer.c should remove these lines:
> > - #include <linux/kernel.h>  // lines 7-7
> > 
> > The full include-list for drivers/iio/buffer/industrialio-triggered-buffer.c:
> > #include <linux/export.h>                // for EXPORT_SYMBOL, EXPORT_SYMBOL...
> > #include <linux/iio/buffer.h>            // for iio_device_attach_buffer
> > #include <linux/iio/buffer_impl.h>       // for iio_buffer
> > #include <linux/iio/iio.h>               // for iio_dev, iio_device_id, INDI...
> > #include <linux/iio/kfifo_buf.h>         // for iio_kfifo_free, iio_kfifo_al...
> > #include <linux/iio/trigger_consumer.h>  // for iio_dealloc_pollfunc, iio_al...
> > #include <linux/iio/triggered_buffer.h>  // for devm_iio_triggered_buffer_se...
> > #include <linux/module.h>                // for MODULE_AUTHOR, MODULE_DESCRI...
> > #include <stddef.h>                      // for NULL
> > #include "asm-generic/errno-base.h"      // for ENOMEM
> > #include "linux/device.h"                // for devm_add_action_or_reset
> > #include "linux/interrupt.h"             // for IRQF_ONESHOT
> > #include "linux/irqreturn.h"             // for irqreturn_t
> > struct attribute;
> > 
> > 
> > drivers/iio/industrialio-triggered-event.c should add these lines:
> > #include <stddef.h>                      // for NULL
> > #include "asm-generic/errno-base.h"      // for ENOMEM
> > #include "linux/interrupt.h"             // for IRQF_ONESHOT
> > #include "linux/irqreturn.h"             // for irqreturn_t
> > 
> > drivers/iio/industrialio-triggered-event.c should remove these lines:
> > - #include <linux/kernel.h>  // lines 6-6
> > 
> > The full include-list for drivers/iio/industrialio-triggered-event.c:
> > #include <linux/export.h>                // for EXPORT_SYMBOL
> > #include <linux/iio/iio.h>               // for iio_dev, iio_device_id, INDI...
> > #include <linux/iio/trigger_consumer.h>  // for iio_alloc_pollfunc, iio_deal...
> > #include <linux/iio/triggered_event.h>   // for iio_triggered_event_cleanup
> > #include <linux/module.h>                // for MODULE_AUTHOR, MODULE_DESCRI...
> > #include <stddef.h>                      // for NULL
> > #include "asm-generic/errno-base.h"      // for ENOMEM
> > #include "linux/interrupt.h"             // for IRQF_ONESHOT
> > #include "linux/irqreturn.h"             // for irqreturn_t
> > 
> > drivers/iio/industrialio-event.c should add these lines:
> > #include <asm/bitops.h>                              // for test_bit
> > #include <stddef.h>                                  // for NULL, size_t
> > #include <sys/types.h>                               // for ssize_t
> > #include "asm-generic/bitops/instrumented-atomic.h"  // for clear_bit, test_...
> > #include "asm-generic/errno-base.h"                  // for EINVAL, ENODEV
> > #include "asm-generic/fcntl.h"                       // for O_NONBLOCK, O_CL...
> > #include "asm-generic/int-ll64.h"                    // for s64, u64
> > #include "asm/string_64.h"                           // for memcpy
> > #include "linux/bitops.h"                            // for for_each_set_bit
> > #include "linux/compiler_types.h"                    // for __user, inline
> > #include "linux/errno.h"                             // for ERESTARTSYS
> > #include "linux/eventpoll.h"                         // for EPOLLIN, EPOLLRD...
> > #include "linux/export.h"                            // for EXPORT_SYMBOL
> > #include "linux/gfp.h"                               // for GFP_KERNEL
> > #include "linux/iio/events.h"                        // for iio_event_data
> > #include "linux/iio/types.h"                         // for iio_event_direction
> > #include "linux/kstrtox.h"                           // for strtobool
> > #include "linux/list.h"                              // for INIT_LIST_HEAD
> > #include "linux/mutex.h"                             // for mutex_lock_inter...
> > #include "linux/stddef.h"                            // for false, true
> > #include "linux/sysfs.h"                             // for attribute_group
> > #include "linux/types.h"                             // for list_head, bool
> > 
> > drivers/iio/industrialio-event.c should remove these lines:
> > - #include <linux/iio/events.h>  // lines 24-24
> > - #include <linux/module.h>  // lines 14-14
> > - #include <linux/sched.h>  // lines 16-16
> > 
> > The full include-list for drivers/iio/industrialio-event.c:
> > #include <asm/bitops.h>                              // for test_bit
> > #include <linux/anon_inodes.h>                       // for anon_inode_getfd
> > #include <linux/device.h>                            // for device_attribute
> > #include <linux/fs.h>                                // for file, noop_llseek
> > #include <linux/iio/iio-opaque.h>                    // for iio_dev_opaque
> > #include <linux/iio/iio.h>                           // for iio_dev, iio_eve...
> > #include <linux/iio/sysfs.h>                         // for iio_dev_attr
> > #include <linux/kernel.h>                            // for kasprintf, ARRAY...
> > #include <linux/kfifo.h>                             // for kfifo_is_empty
> > #include <linux/poll.h>                              // for poll_wait
> > #include <linux/slab.h>                              // for kfree, kcalloc
> > #include <linux/uaccess.h>                           // for copy_to_user
> > #include <linux/wait.h>                              // for init_waitqueue_head
> > #include <stddef.h>                                  // for NULL, size_t
> > #include <sys/types.h>                               // for ssize_t
> > #include "asm-generic/bitops/instrumented-atomic.h"  // for clear_bit, test_...
> > #include "asm-generic/errno-base.h"                  // for EINVAL, ENODEV
> > #include "asm-generic/fcntl.h"                       // for O_NONBLOCK, O_CL...
> > #include "asm-generic/int-ll64.h"                    // for s64, u64
> > #include "asm/string_64.h"                           // for memcpy
> > #include "iio_core.h"                                // for iio_free_chan_de...
> > #include "linux/bitops.h"                            // for for_each_set_bit
> > #include "linux/compiler_types.h"                    // for __user, inline
> > #include "linux/errno.h"                             // for ERESTARTSYS
> > #include "linux/eventpoll.h"                         // for EPOLLIN, EPOLLRD...
> > #include "linux/export.h"                            // for EXPORT_SYMBOL
> > #include "linux/gfp.h"                               // for GFP_KERNEL
> > #include "linux/iio/events.h"                        // for iio_event_data
> > #include "linux/iio/types.h"                         // for iio_event_direction
> > #include "linux/kstrtox.h"                           // for strtobool
> > #include "linux/list.h"                              // for INIT_LIST_HEAD
> > #include "linux/mutex.h"                             // for mutex_lock_inter...
> > #include "linux/stddef.h"                            // for false, true
> > #include "linux/sysfs.h"                             // for attribute_group
> > #include "linux/types.h"                             // for list_head, bool
> > 
> > drivers/iio/industrialio-core.c should add these lines:
> > #include <asm/bug.h>                                 // for WARN
> > #include <linux/ktime.h>                             // for ktime_get_bootti...
> > #include <stddef.h>                                  // for NULL, size_t
> > #include <stdint.h>                                  // for uintptr_t
> > #include <sys/types.h>                               // for ssize_t, dev_t
> > #include "asm-generic/bitops/instrumented-atomic.h"  // for clear_bit, test_...
> > #include "asm-generic/errno-base.h"                  // for EINVAL, EBUSY
> > #include "asm-generic/int-ll64.h"                    // for s64, u64
> > #include "asm/bug.h"                                 // for BUG
> > #include "asm/page_types.h"                          // for PAGE_SIZE
> > #include "asm/string_64.h"                           // for memcpy
> > #include "generated/autoconf.h"                      // for CONFIG_DEBUG_FS
> > #include "linux/align.h"                             // for ALIGN
> > #include "linux/bitops.h"                            // for for_each_set_bit
> > #include "linux/compiler_attributes.h"               // for fallthrough
> > #include "linux/compiler_types.h"                    // for __user
> > #include "linux/dev_printk.h"                        // for dev_err, dev_info
> > #include "linux/device/bus.h"                        // for bus_unregister
> > #include "linux/export.h"                            // for EXPORT_SYMBOL_GPL
> > #include "linux/gfp.h"                               // for GFP_KERNEL
> > #include "linux/hrtimer.h"                           // for hrtimer_resolution
> > #include "linux/iio/types.h"                         // for IIO_VAL_INT, IIO...
> > #include "linux/init.h"                              // for __exit, __init
> > #include "linux/kstrtox.h"                           // for kstrtoint
> > #include "linux/ktime.h"                             // for ktime_to_ns
> > #include "linux/list.h"                              // for INIT_LIST_HEAD
> > #include "linux/math.h"                              // for abs
> > #include "linux/math64.h"                            // for div_s64_rem, div...
> > #include "linux/minmax.h"                            // for min_t
> > #include "linux/of.h"                                // for of_get_property
> > #include "linux/printk.h"                            // for pr_err
> > #include "linux/stat.h"                              // for S_IRUGO, S_IWUSR
> > #include "linux/stddef.h"                            // for false, true
> > #include "linux/string.h"                            // for sysfs_streq, str...
> > #include "linux/sysfs.h"                             // for sysfs_emit_at
> > #include "linux/time.h"                              // for CLOCK_BOOTTIME
> > #include "linux/time64.h"                            // for timespec64_to_ns
> > #include "linux/timex.h"                             // for shift_right
> > #include "linux/types.h"                             // for list_head, bool
> > #include "linux/uaccess.h"                           // for copy_from_user
> > #include "vdso/ktime.h"                              // for LOW_RES_NSEC
> > struct iio_buffer;
> > 
> > drivers/iio/industrialio-core.c should remove these lines:
> > - #include <linux/anon_inodes.h>  // lines 24-24
> > - #include <linux/iio/buffer.h>  // lines 33-33
> > - #include <linux/iio/buffer_impl.h>  // lines 34-34
> > - #include <linux/iio/events.h>  // lines 32-32
> > - #include <linux/poll.h>  // lines 18-18
> > - #include <linux/sched.h>  // lines 20-20
> > - #include <linux/wait.h>  // lines 21-21
> > 
> > The full include-list for drivers/iio/industrialio-core.c:
> > #include <asm/bug.h>                                 // for WARN
> > #include <linux/cdev.h>                              // for cdev_init, cdev_...
> > #include <linux/debugfs.h>                           // for debugfs_create_dir
> > #include <linux/device.h>                            // for device, device_a...
> > #include <linux/err.h>                               // for IS_ERR, PTR_ERR
> > #include <linux/fs.h>                                // for noop_llseek, inode
> > #include <linux/idr.h>                               // for DEFINE_IDA, ida_...
> > #include <linux/iio/iio-opaque.h>                    // for iio_dev_opaque
> > #include <linux/iio/iio.h>                           // for iio_dev, iio_cha...
> > #include <linux/iio/sysfs.h>                         // for iio_dev_attr
> > #include <linux/kdev_t.h>                            // for MAJOR, MKDEV
> > #include <linux/kernel.h>                            // for kasprintf, sscanf
> > #include <linux/ktime.h>                             // for ktime_get_bootti...
> > #include <linux/module.h>                            // for MODULE_AUTHOR
> > #include <linux/mutex.h>                             // for mutex_unlock
> > #include <linux/property.h>                          // for device_property_...
> > #include <linux/slab.h>                              // for kfree, kzalloc
> > #include <stddef.h>                                  // for NULL, size_t
> > #include <stdint.h>                                  // for uintptr_t
> > #include <sys/types.h>                               // for ssize_t, dev_t
> > #include "asm-generic/bitops/instrumented-atomic.h"  // for clear_bit, test_...
> > #include "asm-generic/errno-base.h"                  // for EINVAL, EBUSY
> > #include "asm-generic/int-ll64.h"                    // for s64, u64
> > #include "asm/bug.h"                                 // for BUG
> > #include "asm/page_types.h"                          // for PAGE_SIZE
> > #include "asm/string_64.h"                           // for memcpy
> > #include "generated/autoconf.h"                      // for CONFIG_DEBUG_FS
> > #include "iio_core.h"                                // for iio_ioctl_handler
> > #include "iio_core_trigger.h"                        // for iio_device_regis...
> > #include "linux/align.h"                             // for ALIGN
> > #include "linux/bitops.h"                            // for for_each_set_bit
> > #include "linux/compiler_attributes.h"               // for fallthrough
> > #include "linux/compiler_types.h"                    // for __user
> > #include "linux/dev_printk.h"                        // for dev_err, dev_info
> > #include "linux/device/bus.h"                        // for bus_unregister
> > #include "linux/export.h"                            // for EXPORT_SYMBOL_GPL
> > #include "linux/gfp.h"                               // for GFP_KERNEL
> > #include "linux/hrtimer.h"                           // for hrtimer_resolution
> > #include "linux/iio/types.h"                         // for IIO_VAL_INT, IIO...
> > #include "linux/init.h"                              // for __exit, __init
> > #include "linux/kstrtox.h"                           // for kstrtoint
> > #include "linux/ktime.h"                             // for ktime_to_ns
> > #include "linux/list.h"                              // for INIT_LIST_HEAD
> > #include "linux/math.h"                              // for abs
> > #include "linux/math64.h"                            // for div_s64_rem, div...
> > #include "linux/minmax.h"                            // for min_t
> > #include "linux/of.h"                                // for of_get_property
> > #include "linux/printk.h"                            // for pr_err
> > #include "linux/stat.h"                              // for S_IRUGO, S_IWUSR
> > #include "linux/stddef.h"                            // for false, true
> > #include "linux/string.h"                            // for sysfs_streq, str...
> > #include "linux/sysfs.h"                             // for sysfs_emit_at
> > #include "linux/time.h"                              // for CLOCK_BOOTTIME
> > #include "linux/time64.h"                            // for timespec64_to_ns
> > #include "linux/timex.h"                             // for shift_right
> > #include "linux/types.h"                             // for list_head, bool
> > #include "linux/uaccess.h"                           // for copy_from_user
> > #include "vdso/ktime.h"                              // for LOW_RES_NSEC
> > struct iio_buffer;
> > 
> > drivers/iio/industrialio-configfs.c should add these lines:
> > #include "linux/export.h"    // for EXPORT_SYMBOL, THIS_MODULE
> > #include "linux/mutex.h"     // for mutex, __MUTEX_INITIALIZER
> > 
> > drivers/iio/industrialio-configfs.c should remove these lines:
> > - #include <linux/iio/configfs.h>  // lines 15-15
> > - #include <linux/iio/iio.h>  // lines 14-14
> > - #include <linux/kmod.h>  // lines 11-11
> > - #include <linux/slab.h>  // lines 12-12
> > 
> > The full include-list for drivers/iio/industrialio-configfs.c:
> > #include <linux/configfs.h>  // for configfs_subsystem, config_group_init
> > #include <linux/init.h>      // for __exit, __init
> > #include <linux/module.h>    // for MODULE_AUTHOR, MODULE_DESCRIPTION, MODUL...
> > #include "linux/export.h"    // for EXPORT_SYMBOL, THIS_MODULE
> > #include "linux/mutex.h"     // for mutex, __MUTEX_INITIALIZER
> > 
> > 
> > drivers/iio/inkern.c should add these lines:
> > #include <stddef.h>                  // for NULL, size_t
> > #include <stdint.h>                  // for uint32_t
> > #include <sys/types.h>               // for ssize_t
> > #include "asm-generic/errno-base.h"  // for ENODEV, EINVAL, ENOMEM
> > #include "asm-generic/int-ll64.h"    // for s64
> > #include "generated/autoconf.h"      // for CONFIG_OF
> > #include "linux/dev_printk.h"        // for dev_err
> > #include "linux/device.h"            // for devm_add_action_or_reset, dev_name
> > #include "linux/device/bus.h"        // for bus_find_device
> > #include "linux/errno.h"             // for EPROBE_DEFER
> > #include "linux/gfp.h"               // for GFP_KERNEL
> > #include "linux/iio/types.h"         // for iio_chan_info_enum, IIO_CHAN_INF...
> > #include "linux/list.h"              // for list_add_tail, list_del, list_fo...
> > #include "linux/math64.h"            // for div_s64
> > #include "linux/printk.h"            // for pr_err
> > #include "linux/string.h"            // for strcmp
> > #include "linux/types.h"             // for list_head
> > 
> > drivers/iio/inkern.c should remove these lines:
> > 
> > The full include-list for drivers/iio/inkern.c:
> > #include <linux/err.h>               // for ERR_PTR, IS_ERR, PTR_ERR
> > #include <linux/export.h>            // for EXPORT_SYMBOL_GPL
> > #include <linux/iio/consumer.h>      // for iio_channel, devm_iio_channel_get
> > #include <linux/iio/driver.h>        // for devm_iio_map_array_register, iio...
> > #include <linux/iio/iio-opaque.h>    // for iio_dev_opaque, to_iio_dev_opaque
> > #include <linux/iio/iio.h>           // for iio_dev, iio_device_put, iio_cha...
> > #include <linux/iio/machine.h>       // for iio_map
> > #include <linux/mutex.h>             // for mutex_unlock, mutex_lock, mutex
> > #include <linux/of.h>                // for of_phandle_args, of_parse_phandl...
> > #include <linux/slab.h>              // for kfree, kzalloc, kcalloc
> > #include <stddef.h>                  // for NULL, size_t
> > #include <stdint.h>                  // for uint32_t
> > #include <sys/types.h>               // for ssize_t
> > #include "asm-generic/errno-base.h"  // for ENODEV, EINVAL, ENOMEM
> > #include "asm-generic/int-ll64.h"    // for s64
> > #include "generated/autoconf.h"      // for CONFIG_OF
> > #include "iio_core.h"                // for iio_device_type
> > #include "linux/dev_printk.h"        // for dev_err
> > #include "linux/device.h"            // for devm_add_action_or_reset, dev_name
> > #include "linux/device/bus.h"        // for bus_find_device
> > #include "linux/errno.h"             // for EPROBE_DEFER
> > #include "linux/gfp.h"               // for GFP_KERNEL
> > #include "linux/iio/types.h"         // for iio_chan_info_enum, IIO_CHAN_INF...
> > #include "linux/list.h"              // for list_add_tail, list_del, list_fo...
> > #include "linux/math64.h"            // for div_s64
> > #include "linux/printk.h"            // for pr_err
> > #include "linux/string.h"            // for strcmp
> > #include "linux/types.h"             // for list_head
> > 
> > 
> > drivers/iio/industrialio-sw-device.c should add these lines:
> > #include <stddef.h>                  // for NULL
> > #include "asm-generic/errno-base.h"  // for EBUSY, EINVAL
> > #include "linux/err.h"               // for IS_ERR, ERR_CAST, ERR_PTR, PTR_ERR
> > #include "linux/export.h"            // for EXPORT_SYMBOL, THIS_MODULE
> > #include "linux/mutex.h"             // for mutex_lock, mutex_unlock, mutex
> > #include "linux/printk.h"            // for pr_err
> > #include "linux/string.h"            // for strlen, strcmp
> > #include "linux/types.h"             // for list_head
> > 
> > drivers/iio/industrialio-sw-device.c should remove these lines:
> > - #include <linux/kmod.h>  // lines 10-10
> > - #include <linux/slab.h>  // lines 12-12
> > 
> > The full include-list for drivers/iio/industrialio-sw-device.c:
> > #include <linux/configfs.h>          // for configfs_register_default_group
> > #include <linux/iio/configfs.h>      // for iio_configfs_subsys
> > #include <linux/iio/sw_device.h>     // for iio_sw_device_type, iio_sw_device
> > #include <linux/init.h>              // for __exit, __init
> > #include <linux/list.h>              // for list_add_tail, list_del, LIST_HEAD
> > #include <linux/module.h>            // for module_put, try_module_get, MODU...
> > #include <stddef.h>                  // for NULL
> > #include "asm-generic/errno-base.h"  // for EBUSY, EINVAL
> > #include "linux/err.h"               // for IS_ERR, ERR_CAST, ERR_PTR, PTR_ERR
> > #include "linux/export.h"            // for EXPORT_SYMBOL, THIS_MODULE
> > #include "linux/mutex.h"             // for mutex_lock, mutex_unlock, mutex
> > #include "linux/printk.h"            // for pr_err
> > #include "linux/string.h"            // for strlen, strcmp
> > #include "linux/types.h"             // for list_head
> > 
> > drivers/iio/industrialio-trigger.c should add these lines:
> > #include <asm/bug.h>                                 // for WARN_ON
> > #include <linux/irq.h>                               // for generic_handle_irq
> > #include <stdarg.h>                                  // for va_list
> > #include <stddef.h>                                  // for NULL, size_t
> > #include <sys/types.h>                               // for ssize_t
> > #include "asm-generic/bitops/instrumented-atomic.h"  // for clear_bit
> > #include "asm-generic/errno-base.h"                  // for EINVAL, EBUSY
> > #include "generated/autoconf.h"                      // for CONFIG_IIO_CONSU...
> > #include "linux/atomic/atomic-instrumented.h"        // for atomic_read, ato...
> > #include "linux/bitmap.h"                            // for bitmap_empty
> > #include "linux/compiler_attributes.h"               // for __printf
> > #include "linux/export.h"                            // for EXPORT_SYMBOL
> > #include "linux/gfp.h"                               // for GFP_KERNEL
> > #include "linux/irq.h"                               // for irq_data_get_irq...
> > #include "linux/irqreturn.h"                         // for irqreturn_t, IRQ...
> > #include "linux/log2.h"                              // for ilog2
> > #include "linux/module.h"                            // for module_put, __mo...
> > #include "linux/mutex.h"                             // for mutex_unlock
> > #include "linux/printk.h"                            // for pr_err
> > #include "linux/stat.h"                              // for S_IRUGO, S_IWUSR
> > #include "linux/stdarg.h"                            // for va_end, va_start
> > #include "linux/stddef.h"                            // for true, false
> > #include "linux/string.h"                            // for strcmp, sysfs_streq
> > #include "linux/sysfs.h"                             // for sysfs_emit, ATTR...
> > #include "linux/types.h"                             // for list_head, bool
> > 
> > drivers/iio/industrialio-trigger.c should remove these lines:
> > - #include <linux/err.h>  // lines 9-9
> > 
> > The full include-list for drivers/iio/industrialio-trigger.c:
> > #include <asm/bug.h>                                 // for WARN_ON
> > #include <linux/device.h>                            // for device, device_del
> > #include <linux/idr.h>                               // for ida_simple_remove
> > #include <linux/iio/iio-opaque.h>                    // for iio_dev_opaque
> > #include <linux/iio/iio.h>                           // for iio_dev, dev_to_...
> > #include <linux/iio/trigger.h>                       // for iio_trigger, iio...
> > #include <linux/iio/trigger_consumer.h>              // for iio_poll_func
> > #include <linux/interrupt.h>                         // for free_irq, reques...
> > #include <linux/irq.h>                               // for generic_handle_irq
> > #include <linux/kernel.h>                            // for kvasprintf, cont...
> > #include <linux/list.h>                              // for list_add_tail
> > #include <linux/slab.h>                              // for kfree, kmalloc
> > #include <stdarg.h>                                  // for va_list
> > #include <stddef.h>                                  // for NULL, size_t
> > #include <sys/types.h>                               // for ssize_t
> > #include "asm-generic/bitops/instrumented-atomic.h"  // for clear_bit
> > #include "asm-generic/errno-base.h"                  // for EINVAL, EBUSY
> > #include "generated/autoconf.h"                      // for CONFIG_IIO_CONSU...
> > #include "iio_core.h"                                // for iio_device_regis...
> > #include "iio_core_trigger.h"                        // for iio_device_regis...
> > #include "linux/atomic/atomic-instrumented.h"        // for atomic_read, ato...
> > #include "linux/bitmap.h"                            // for bitmap_empty
> > #include "linux/compiler_attributes.h"               // for __printf
> > #include "linux/export.h"                            // for EXPORT_SYMBOL
> > #include "linux/gfp.h"                               // for GFP_KERNEL
> > #include "linux/irq.h"                               // for irq_data_get_irq...
> > #include "linux/irqreturn.h"                         // for irqreturn_t, IRQ...
> > #include "linux/log2.h"                              // for ilog2
> > #include "linux/module.h"                            // for module_put, __mo...
> > #include "linux/mutex.h"                             // for mutex_unlock
> > #include "linux/printk.h"                            // for pr_err
> > #include "linux/stat.h"                              // for S_IRUGO, S_IWUSR
> > #include "linux/stdarg.h"                            // for va_end, va_start
> > #include "linux/stddef.h"                            // for true, false
> > #include "linux/string.h"                            // for strcmp, sysfs_streq
> > #include "linux/sysfs.h"                             // for sysfs_emit, ATTR...
> > #include "linux/types.h"                             // for list_head, bool
> > 
> > drivers/iio/industrialio-sw-trigger.c should add these lines:
> > #include <stddef.h>                  // for NULL
> > #include "asm-generic/errno-base.h"  // for EBUSY, EINVAL
> > #include "linux/err.h"               // for IS_ERR, ERR_CAST, ERR_PTR, PTR_ERR
> > #include "linux/export.h"            // for EXPORT_SYMBOL, THIS_MODULE
> > #include "linux/mutex.h"             // for mutex_lock, mutex_unlock, mutex
> > #include "linux/printk.h"            // for pr_err
> > #include "linux/string.h"            // for strlen, strcmp
> > #include "linux/types.h"             // for list_head
> > 
> > drivers/iio/industrialio-sw-trigger.c should remove these lines:
> > - #include <linux/kmod.h>  // lines 10-10
> > - #include <linux/slab.h>  // lines 12-12
> > 
> > The full include-list for drivers/iio/industrialio-sw-trigger.c:
> > #include <linux/configfs.h>          // for configfs_register_default_group
> > #include <linux/iio/configfs.h>      // for iio_configfs_subsys
> > #include <linux/iio/sw_trigger.h>    // for iio_sw_trigger_type, iio_sw_trigger
> > #include <linux/init.h>              // for __exit, __init
> > #include <linux/list.h>              // for list_add_tail, list_del, LIST_HEAD
> > #include <linux/module.h>            // for module_put, try_module_get, MODU...
> > #include <stddef.h>                  // for NULL
> > #include "asm-generic/errno-base.h"  // for EBUSY, EINVAL
> > #include "linux/err.h"               // for IS_ERR, ERR_CAST, ERR_PTR, PTR_ERR
> > #include "linux/export.h"            // for EXPORT_SYMBOL, THIS_MODULE
> > #include "linux/mutex.h"             // for mutex_lock, mutex_unlock, mutex
> > #include "linux/printk.h"            // for pr_err
> > #include "linux/string.h"            // for strlen, strcmp
> > #include "linux/types.h"             // for list_head
> > 
> > drivers/iio/industrialio-buffer.c should add these lines:
> > #include <asm/bitops.h>                              // for test_bit
> > #include <asm/bug.h>                                 // for WARN
> > #include <stddef.h>                                  // for size_t, NULL
> > #include <sys/types.h>                               // for ssize_t
> > #include "asm-generic/bitops/find.h"                 // for find_next_bit
> > #include "asm-generic/bitops/instrumented-atomic.h"  // for clear_bit, set_bit
> > #include "asm-generic/errno-base.h"                  // for ENOMEM, EINVAL
> > #include "asm-generic/fcntl.h"                       // for O_NONBLOCK, O_CL...
> > #include "asm-generic/int-ll64.h"                    // for u8
> > #include "asm/current.h"                             // for current
> > #include "asm/string_64.h"                           // for memcpy, memset
> > #include "linux/align.h"                             // for ALIGN
> > #include "linux/bitmap.h"                            // for bitmap_free, bit...
> > #include "linux/bitops.h"                            // for for_each_set_bit
> > #include "linux/compiler_types.h"                    // for __user
> > #include "linux/dev_printk.h"                        // for dev_dbg
> > #include "linux/errno.h"                             // for ERESTARTSYS
> > #include "linux/eventpoll.h"                         // for EPOLLIN, EPOLLRD...
> > #include "linux/gfp.h"                               // for GFP_KERNEL
> > #include "linux/iio/buffer.h"                        // for IIO_BUFFER_GET_F...
> > #include "linux/iio/types.h"                         // for IIO_TIMESTAMP
> > #include "linux/kconfig.h"                           // for __LITTLE_ENDIAN
> > #include "linux/kref.h"                              // for kref_get, kref_init
> > #include "linux/kstrtox.h"                           // for strtobool, kstrt...
> > #include "linux/list.h"                              // for list_empty, INIT...
> > #include "linux/math.h"                              // for roundup
> > #include "linux/minmax.h"                            // for max, min, min_t
> > #include "linux/mutex.h"                             // for mutex_lock, mute...
> > #include "linux/sched.h"                             // for MAX_SCHEDULE_TIM...
> > #include "linux/stat.h"                              // for S_IRUGO, S_IWUSR
> > #include "linux/stddef.h"                            // for false, true
> > #include "linux/string.h"                            // for kstrdup_const
> > #include "linux/sysfs.h"                             // for sysfs_emit, attr...
> > #include "linux/types.h"                             // for list_head, bool
> > #include "linux/uaccess.h"                           // for copy_from_user
> > #include "linux/wait.h"                              // for woken_wake_function
> > 
> > drivers/iio/industrialio-buffer.c should remove these lines:
> > - #include <linux/cdev.h>  // lines 18-18
> > 
> > The full include-list for drivers/iio/industrialio-buffer.c:
> > #include <asm/bitops.h>                              // for test_bit
> > #include <asm/bug.h>                                 // for WARN
> > #include <linux/anon_inodes.h>                       // for anon_inode_getfd
> > #include <linux/device.h>                            // for device_attribute
> > #include <linux/export.h>                            // for EXPORT_SYMBOL_GPL
> > #include <linux/file.h>                              // for put_unused_fd
> > #include <linux/fs.h>                                // for file, noop_llseek
> > #include <linux/iio/buffer.h>                        // for iio_device_attac...
> > #include <linux/iio/buffer_impl.h>                   // for iio_buffer, iio_...
> > #include <linux/iio/iio-opaque.h>                    // for iio_dev_opaque
> > #include <linux/iio/iio.h>                           // for iio_dev, iio_cha...
> > #include <linux/iio/sysfs.h>                         // for iio_dev_attr
> > #include <linux/kernel.h>                            // for ARRAY_SIZE, cont...
> > #include <linux/poll.h>                              // for poll_wait
> > #include <linux/sched/signal.h>                      // for signal_pending
> > #include <linux/slab.h>                              // for kfree, kzalloc
> > #include <stddef.h>                                  // for size_t, NULL
> > #include <sys/types.h>                               // for ssize_t
> > #include "asm-generic/bitops/find.h"                 // for find_next_bit
> > #include "asm-generic/bitops/instrumented-atomic.h"  // for clear_bit, set_bit
> > #include "asm-generic/errno-base.h"                  // for ENOMEM, EINVAL
> > #include "asm-generic/fcntl.h"                       // for O_NONBLOCK, O_CL...
> > #include "asm-generic/int-ll64.h"                    // for u8
> > #include "asm/current.h"                             // for current
> > #include "asm/string_64.h"                           // for memcpy, memset
> > #include "iio_core.h"                                // for __iio_add_chan_d...
> > #include "iio_core_trigger.h"                        // for iio_trigger_deta...
> > #include "linux/align.h"                             // for ALIGN
> > #include "linux/bitmap.h"                            // for bitmap_free, bit...
> > #include "linux/bitops.h"                            // for for_each_set_bit
> > #include "linux/compiler_types.h"                    // for __user
> > #include "linux/dev_printk.h"                        // for dev_dbg
> > #include "linux/errno.h"                             // for ERESTARTSYS
> > #include "linux/eventpoll.h"                         // for EPOLLIN, EPOLLRD...
> > #include "linux/gfp.h"                               // for GFP_KERNEL
> > #include "linux/iio/buffer.h"                        // for IIO_BUFFER_GET_F...
> > #include "linux/iio/types.h"                         // for IIO_TIMESTAMP
> > #include "linux/kconfig.h"                           // for __LITTLE_ENDIAN
> > #include "linux/kref.h"                              // for kref_get, kref_init
> > #include "linux/kstrtox.h"                           // for strtobool, kstrt...
> > #include "linux/list.h"                              // for list_empty, INIT...
> > #include "linux/math.h"                              // for roundup
> > #include "linux/minmax.h"                            // for max, min, min_t
> > #include "linux/mutex.h"                             // for mutex_lock, mute...
> > #include "linux/sched.h"                             // for MAX_SCHEDULE_TIM...
> > #include "linux/stat.h"                              // for S_IRUGO, S_IWUSR
> > #include "linux/stddef.h"                            // for false, true
> > #include "linux/string.h"                            // for kstrdup_const
> > #include "linux/sysfs.h"                             // for sysfs_emit, attr...
> > #include "linux/types.h"                             // for list_head, bool
> > #include "linux/uaccess.h"                           // for copy_from_user
> > #include "linux/wait.h"                              // for woken_wake_function
> > 
> > Jonathan Cameron (11):
> >   iio: industrialio-core: Reorder header includes to be alphabetical.
> >   iio: industrialio-core - Bring includes up to date.
> >   iio: industrialio-buffer.c: Bring includes up to date.
> >   iio: industrialio-event.c: Bring includes up to date.
> >   iio: industrialio-trigger.c: Bring includes up to date.
> >   iio: inkern: Bring includes up to date.
> >   iio: configfs: Bring includes up to date
> >   iio: misc core files: Bring includes up to date
> >   iio: industrialio-triggered-buffer: Bring includes up to date.
> >   iio: industrialio-buffer-cb: Bring includes up to date.
> >   iio: kfifo-buf.c: Bring includes up to date.
> > 
> >  drivers/iio/buffer/industrialio-buffer-cb.c   |  7 +++-
> >  .../buffer/industrialio-triggered-buffer.c    |  6 ++-
> >  drivers/iio/buffer/kfifo_buf.c                | 15 ++++---
> >  drivers/iio/industrialio-buffer.c             | 23 ++++++++--
> >  drivers/iio/industrialio-configfs.c           |  7 ++--
> >  drivers/iio/industrialio-core.c               | 42 ++++++++++++-------
> >  drivers/iio/industrialio-event.c              |  9 +++-
> >  drivers/iio/industrialio-sw-device.c          |  8 ++--
> >  drivers/iio/industrialio-sw-trigger.c         |  9 ++--
> >  drivers/iio/industrialio-trigger.c            | 15 +++++--
> >  drivers/iio/industrialio-triggered-event.c    |  3 +-
> >  drivers/iio/inkern.c                          |  7 +++-
> >  12 files changed, 107 insertions(+), 44 deletions(-)
> >   
> 

