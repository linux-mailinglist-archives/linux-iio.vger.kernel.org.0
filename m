Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052694BB95A
	for <lists+linux-iio@lfdr.de>; Fri, 18 Feb 2022 13:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiBRMlF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Feb 2022 07:41:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiBRMlD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Feb 2022 07:41:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F77B299263
        for <linux-iio@vger.kernel.org>; Fri, 18 Feb 2022 04:40:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A244C61F8E
        for <linux-iio@vger.kernel.org>; Fri, 18 Feb 2022 12:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E4FC340E9;
        Fri, 18 Feb 2022 12:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645188045;
        bh=447Z2uPdSgP72gfhdNG1g+g7LR9jArs6W2l5yeJlDsQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rnQ2dO6aIaSrjuzsl0op3TaWsug5wuj4K1RyZJHOrh0zGPbwyytwWyo/kTDe5hQnJ
         VH1d3FcRlfGXHs71N7qoSuSrXmRktIHqtZ1aBviLcgoikv3d8OQpdq/RgYI2o3tu2X
         Yn2JI1ql1zcShLCgPeZrYbO/wugN6/xjxS8T6ByhBZOHaMyQTJgd1hs/n3sGtOgpn9
         RTOU+M8MmTfTg6hvTd3c+80uw+5PAULm1aRvmbW99fbCSRaoQCuOuStBt23F7SadTh
         bSPMlSLU+kaM04K+Jdw8k+Z9YfAxE59DLtJxw3IrbR9B/4hcSjfpk2iZ1/9MtWJlUa
         bVVdNZe3SjzbQ==
Date:   Fri, 18 Feb 2022 12:47:33 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/7] cros_ec_sensors: Drop unused IIO header includes
Message-ID: <20220218124733.3604f9a5@jic23-huawei>
In-Reply-To: <20211003121711.279736-1-jic23@kernel.org>
References: <20211003121711.279736-1-jic23@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun,  3 Oct 2021 13:17:04 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The include-what-you-use tool allows for automated detection of
> unused headers + those that are used directly in a file but not included.
> 
> There are cases where the exact includes are debatable or perhaps the
> tool indicates a place where we should look to split up a large header.

Hi All,

I still have this series outstanding in patchwork.  Might need a rebase
by now, but in meantime if anyone cros_ec related could take a look
that would be great.  Note this series is just dropping unused headers
so should be uncontroversial!

Thanks,

Jonathan

> 
> However, a simply step for IIO drivers at least is to reduce the inclusion
> of headers that do not need to be included in specific drivers.
> These typcially are unneeded because:
> a) They provide the definitions for an optional feature that the driver
>    does not use.
> b) The driver is using library like functionality that simplifies
>    a common case such as the iio-triggered-buffer approach and does
>    not therefore need access to the low level primatives.
> 
> Over time we have restructured many IIO drivers and often ended up
> with headers that were once needed no longer being used.
> 
> If reviewers would prefer that I also tidy up some of the other includes
> I'm happy to do that.  Note that manual inspection is absolutely
> required when using this tool as it is not 'kernel aware'.
> 
> Patch 1 is the perhaps the most controversial, but I would like to
> avoid drivers outside of IIO itself including IIO headers where that
> is possible and in this particularly case the include is not necessary.
> 
> For reference, the relevant include-what-you-use reports for these files is:
> 
> drivers/platform/chrome/cros_ec_sensorhub_ring.c should add these lines:
> #include <stddef.h>                                 // for NULL, size_t
> #include <stdint.h>                                 // for uint16_t, int16_t
> #include "asm-generic/errno-base.h"                 // for ENOMEM, EINVAL
> #include "asm-generic/int-ll64.h"                   // for s64, u16, u8, s16
> #include "asm/string_64.h"                          // for memcpy
> #include "linux/bitops.h"                           // for for_each_set_bit
> #include "linux/compiler_types.h"                   // for inline
> #include "linux/dev_printk.h"                       // for dev_warn, dev_dbg
> #include "linux/export.h"                           // for EXPORT_SYMBOL_GPL
> #include "linux/gfp.h"                              // for GFP_KERNEL
> #include "linux/ktime.h"                            // for ktime_t
> #include "linux/math.h"                             // for abs
> #include "linux/math64.h"                           // for div_s64, div64_s64
> #include "linux/mutex.h"                            // for mutex_unlock, mut...
> #include "linux/notifier.h"                         // for blocking_notifier...
> #include "linux/stddef.h"                           // for false, true
> #include "linux/types.h"                            // for bool
> #include "vdso/bits.h"                              // for BIT
> struct iio_dev;
> 
> drivers/platform/chrome/cros_ec_sensorhub_ring.c should remove these lines:
> - #include <linux/delay.h>  // lines 8-8
> - #include <linux/iio/iio.h>  // lines 10-10
> - #include <linux/module.h>  // lines 12-12
> - #include <linux/platform_device.h>  // lines 16-16
> - #include <linux/slab.h>  // lines 18-18
> 
> The full include-list for drivers/platform/chrome/cros_ec_sensorhub_ring.c:
> #include <linux/device.h>                           // for devm_kcalloc, dev...
> #include <linux/kernel.h>                           // for container_of
> #include <linux/platform_data/cros_ec_commands.h>   // for ec_response_motio...
> #include <linux/platform_data/cros_ec_proto.h>      // for cros_ec_cmd_xfer_...
> #include <linux/platform_data/cros_ec_sensorhub.h>  // for cros_ec_sensorhub
> #include <linux/sort.h>                             // for sort
> #include <stddef.h>                                 // for NULL, size_t
> #include <stdint.h>                                 // for uint16_t, int16_t
> #include "asm-generic/errno-base.h"                 // for ENOMEM, EINVAL
> #include "asm-generic/int-ll64.h"                   // for s64, u16, u8, s16
> #include "asm/string_64.h"                          // for memcpy
> #include "cros_ec_trace.h"                          // for trace_cros_ec_sen...
> #include "linux/bitops.h"                           // for for_each_set_bit
> #include "linux/compiler_types.h"                   // for inline
> #include "linux/dev_printk.h"                       // for dev_warn, dev_dbg
> #include "linux/export.h"                           // for EXPORT_SYMBOL_GPL
> #include "linux/gfp.h"                              // for GFP_KERNEL
> #include "linux/ktime.h"                            // for ktime_t
> #include "linux/math.h"                             // for abs
> #include "linux/math64.h"                           // for div_s64, div64_s64
> #include "linux/mutex.h"                            // for mutex_unlock, mut...
> #include "linux/notifier.h"                         // for blocking_notifier...
> #include "linux/stddef.h"                           // for false, true
> #include "linux/types.h"                            // for bool
> #include "vdso/bits.h"                              // for BIT
> struct iio_dev;
> 
> drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c should add these lines:
> #include <linux/bitops.h>                           // for fls
> #include <stddef.h>                                 // for NULL, size_t
> #include <stdint.h>                                 // for uintptr_t, int16_t
> #include <sys/types.h>                              // for ssize_t
> #include "asm-generic/errno-base.h"                 // for EINVAL, EIO, ENOMEM
> #include "asm-generic/int-ll64.h"                   // for u16, s16, u32, u8
> #include "asm/page_types.h"                         // for PAGE_SIZE
> #include "asm/string_64.h"                          // for memcpy, memset
> #include "linux/bitops.h"                           // for for_each_set_bit
> #include "linux/byteorder/generic.h"                // for le16_to_cpu
> #include "linux/compiler_attributes.h"              // for __maybe_unused
> #include "linux/dev_printk.h"                       // for dev_warn
> #include "linux/export.h"                           // for EXPORT_SYMBOL_GPL
> #include "linux/gfp.h"                              // for GFP_KERNEL
> #include "linux/iio/types.h"                        // for IIO_CHAN_INFO_SAM...
> #include "linux/irqreturn.h"                        // for IRQ_HANDLED, irqr...
> #include "linux/kstrtox.h"                          // for strtobool
> #include "linux/limits.h"                           // for U16_MAX
> #include "linux/minmax.h"                           // for max, min
> #include "linux/mutex.h"                            // for mutex_lock, mutex...
> #include "linux/pm.h"                               // for SIMPLE_DEV_PM_OPS
> #include "linux/time.h"                             // for CLOCK_BOOTTIME
> #include "linux/types.h"                            // for bool, __le16
> 
> drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c should remove these lines:
> - #include <linux/iio/trigger.h>  // lines 15-15
> - #include <linux/slab.h>  // lines 20-20
> 
> The full include-list for drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c:
> #include <linux/bitops.h>                           // for fls
> #include <linux/delay.h>                            // for msleep
> #include <linux/device.h>                           // for dev_get_drvdata
> #include <linux/iio/buffer.h>                       // for iio_push_to_buffe...
> #include <linux/iio/common/cros_ec_sensors_core.h>  // for cros_ec_sensors_c...
> #include <linux/iio/iio.h>                          // for iio_priv, iio_dev
> #include <linux/iio/kfifo_buf.h>                    // for devm_iio_kfifo_bu...
> #include <linux/iio/sysfs.h>                        // for iio_dev_attr, IIO...
> #include <linux/iio/trigger_consumer.h>             // for iio_trigger_notif...
> #include <linux/iio/triggered_buffer.h>             // for devm_iio_triggere...
> #include <linux/kernel.h>                           // for snprintf, sprintf
> #include <linux/module.h>                           // for MODULE_DESCRIPTION
> #include <linux/platform_data/cros_ec_commands.h>   // for ec_params_motion_...
> #include <linux/platform_data/cros_ec_proto.h>      // for cros_ec_device
> #include <linux/platform_data/cros_ec_sensorhub.h>  // for cros_ec_sensorhub...
> #include <linux/platform_device.h>                  // for platform_get_drvdata
> #include <stddef.h>                                 // for NULL, size_t
> #include <stdint.h>                                 // for uintptr_t, int16_t
> #include <sys/types.h>                              // for ssize_t
> #include "asm-generic/errno-base.h"                 // for EINVAL, EIO, ENOMEM
> #include "asm-generic/int-ll64.h"                   // for u16, s16, u32, u8
> #include "asm/page_types.h"                         // for PAGE_SIZE
> #include "asm/string_64.h"                          // for memcpy, memset
> #include "linux/bitops.h"                           // for for_each_set_bit
> #include "linux/byteorder/generic.h"                // for le16_to_cpu
> #include "linux/compiler_attributes.h"              // for __maybe_unused
> #include "linux/dev_printk.h"                       // for dev_warn
> #include "linux/export.h"                           // for EXPORT_SYMBOL_GPL
> #include "linux/gfp.h"                              // for GFP_KERNEL
> #include "linux/iio/types.h"                        // for IIO_CHAN_INFO_SAM...
> #include "linux/irqreturn.h"                        // for IRQ_HANDLED, irqr...
> #include "linux/kstrtox.h"                          // for strtobool
> #include "linux/limits.h"                           // for U16_MAX
> #include "linux/minmax.h"                           // for max, min
> #include "linux/mutex.h"                            // for mutex_lock, mutex...
> #include "linux/pm.h"                               // for SIMPLE_DEV_PM_OPS
> #include "linux/time.h"                             // for CLOCK_BOOTTIME
> #include "linux/types.h"                            // for bool, __le16
> 
> drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c should add these lines:
> #include <stddef.h>                                 // for NULL
> #include <stdint.h>                                 // for int16_t, uint16_t
> #include "asm-generic/errno-base.h"                 // for EINVAL, ENOMEM
> #include "asm-generic/errno.h"                      // for EOPNOTSUPP, EPROTO
> #include "asm-generic/int-ll64.h"                   // for s16, s64
> #include "linux/dev_printk.h"                       // for dev_err
> #include "linux/iio/types.h"                        // for IIO_CHAN_INFO_CAL...
> #include "linux/math64.h"                           // for div_s64
> #include "linux/mod_devicetable.h"                  // for platform_device_id
> #include "linux/mutex.h"                            // for mutex_lock, mutex...
> #include "linux/stddef.h"                           // for true
> #include "vdso/bits.h"                              // for BIT
> 
> drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c should remove these lines:
> - #include <linux/device.h>  // lines 11-11
> - #include <linux/iio/buffer.h>  // lines 12-12
> - #include <linux/iio/kfifo_buf.h>  // lines 15-15
> - #include <linux/iio/trigger_consumer.h>  // lines 16-16
> - #include <linux/iio/triggered_buffer.h>  // lines 17-17
> - #include <linux/kernel.h>  // lines 18-18
> - #include <linux/slab.h>  // lines 23-23
> 
> The full include-list for drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c:
> #include <linux/iio/common/cros_ec_sensors_core.h>  // for cros_ec_sensors_c...
> #include <linux/iio/iio.h>                          // for iio_chan_spec
> #include <linux/module.h>                           // for MODULE_DESCRIPTION
> #include <linux/platform_data/cros_ec_commands.h>   // for ec_params_motion_...
> #include <linux/platform_data/cros_ec_proto.h>      // for cros_ec_device
> #include <linux/platform_device.h>                  // for platform_device
> #include <stddef.h>                                 // for NULL
> #include <stdint.h>                                 // for int16_t, uint16_t
> #include "asm-generic/errno-base.h"                 // for EINVAL, ENOMEM
> #include "asm-generic/errno.h"                      // for EOPNOTSUPP, EPROTO
> #include "asm-generic/int-ll64.h"                   // for s16, s64
> #include "linux/dev_printk.h"                       // for dev_err
> #include "linux/iio/types.h"                        // for IIO_CHAN_INFO_CAL...
> #include "linux/math64.h"                           // for div_s64
> #include "linux/mod_devicetable.h"                  // for platform_device_id
> #include "linux/mutex.h"                            // for mutex_lock, mutex...
> #include "linux/stddef.h"                           // for true
> #include "vdso/bits.h"                              // for BIT
> 
> drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c should add these lines:
> #include <stddef.h>                                 // for NULL
> #include "asm-generic/errno-base.h"                 // for ENOMEM
> #include "asm-generic/int-ll64.h"                   // for s16
> #include "linux/dev_printk.h"                       // for dev_warn
> #include "linux/iio/types.h"                        // for IIO_ANGL, IIO_CHA...
> #include "linux/mod_devicetable.h"                  // for platform_device_id
> #include "linux/mutex.h"                            // for mutex_lock, mutex...
> #include "linux/stddef.h"                           // for false
> #include "vdso/bits.h"                              // for BIT
> 
> drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c should remove these lines:
> - #include <linux/delay.h>  // lines 13-13
> - #include <linux/device.h>  // lines 14-14
> - #include <linux/iio/buffer.h>  // lines 15-15
> - #include <linux/iio/kfifo_buf.h>  // lines 18-18
> - #include <linux/iio/trigger.h>  // lines 19-19
> - #include <linux/iio/trigger_consumer.h>  // lines 21-21
> - #include <linux/slab.h>  // lines 26-26
> 
> The full include-list for drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c:
> #include <linux/iio/common/cros_ec_sensors_core.h>  // for cros_ec_sensors_c...
> #include <linux/iio/iio.h>                          // for iio_priv, iio_dev
> #include <linux/iio/triggered_buffer.h>             // for devm_iio_triggere...
> #include <linux/kernel.h>                           // for ARRAY_SIZE
> #include <linux/module.h>                           // for MODULE_DESCRIPTION
> #include <linux/platform_data/cros_ec_commands.h>   // for ec_response_motio...
> #include <linux/platform_device.h>                  // for module_platform_d...
> #include <stddef.h>                                 // for NULL
> #include "asm-generic/errno-base.h"                 // for ENOMEM
> #include "asm-generic/int-ll64.h"                   // for s16
> #include "linux/dev_printk.h"                       // for dev_warn
> #include "linux/iio/types.h"                        // for IIO_ANGL, IIO_CHA...
> #include "linux/mod_devicetable.h"                  // for platform_device_id
> #include "linux/mutex.h"                            // for mutex_lock, mutex...
> #include "linux/stddef.h"                           // for false
> #include "vdso/bits.h"                              // for BIT
> 
> drivers/iio/accel/cros_ec_accel_legacy.c should add these lines:
> #include <asm/bug.h>                                // for WARN_ON
> #include <stddef.h>                                 // for NULL
> #include <stdint.h>                                 // for int16_t
> #include "asm-generic/errno-base.h"                 // for EINVAL, ENOMEM
> #include "asm-generic/int-ll64.h"                   // for s8, s16, u8
> #include "linux/bitops.h"                           // for for_each_set_bit
> #include "linux/dev_printk.h"                       // for dev_warn
> #include "linux/iio/types.h"                        // for IIO_CHAN_INFO_SAM...
> #include "linux/mutex.h"                            // for mutex_lock, mutex...
> #include "linux/stddef.h"                           // for true
> #include "vdso/bits.h"                              // for BIT
> 
> drivers/iio/accel/cros_ec_accel_legacy.c should remove these lines:
> - #include <linux/delay.h>  // lines 12-12
> - #include <linux/device.h>  // lines 13-13
> - #include <linux/iio/buffer.h>  // lines 14-14
> - #include <linux/iio/kfifo_buf.h>  // lines 17-17
> - #include <linux/iio/trigger_consumer.h>  // lines 18-18
> - #include <linux/iio/triggered_buffer.h>  // lines 19-19
> - #include <linux/slab.h>  // lines 22-22
> 
> The full include-list for drivers/iio/accel/cros_ec_accel_legacy.c:
> #include <asm/bug.h>                                // for WARN_ON
> #include <linux/iio/common/cros_ec_sensors_core.h>  // for CROS_EC_SENSOR_X
> #include <linux/iio/iio.h>                          // for iio_priv, iio_dev
> #include <linux/kernel.h>                           // for ARRAY_SIZE
> #include <linux/module.h>                           // for MODULE_ALIAS, MOD...
> #include <linux/platform_data/cros_ec_commands.h>   // for ec_params_motion_...
> #include <linux/platform_data/cros_ec_proto.h>      // for cros_ec_device
> #include <linux/platform_device.h>                  // for platform_device
> #include <stddef.h>                                 // for NULL
> #include <stdint.h>                                 // for int16_t
> #include "asm-generic/errno-base.h"                 // for EINVAL, ENOMEM
> #include "asm-generic/int-ll64.h"                   // for s8, s16, u8
> #include "linux/bitops.h"                           // for for_each_set_bit
> #include "linux/dev_printk.h"                       // for dev_warn
> #include "linux/iio/types.h"                        // for IIO_CHAN_INFO_SAM...
> #include "linux/mutex.h"                            // for mutex_lock, mutex...
> #include "linux/stddef.h"                           // for true
> #include "vdso/bits.h"                              // for BIT
> 
> drivers/iio/proximity/cros_ec_mkbp_proximity.c should add these lines:
> #include <stddef.h>                                // for NULL, size_t
> #include "asm-generic/errno-base.h"                // for EINVAL, ENOMEM
> #include "asm-generic/errno.h"                     // for EPROTO
> #include "asm-generic/int-ll64.h"                  // for u32, s64, u64, u8
> #include "asm-generic/unaligned.h"                 // for get_unaligned_le32
> #include "linux/compiler_attributes.h"             // for __maybe_unused
> #include "linux/dev_printk.h"                      // for dev_warn
> #include "linux/device.h"                          // for dev_get_drvdata
> #include "linux/device/driver.h"                   // for device_driver
> #include "linux/iio/types.h"                       // for IIO_PROXIMITY, IIO...
> #include "linux/ktime.h"                           // for ktime_to_ns
> #include "linux/mod_devicetable.h"                 // for of_device_id
> #include "linux/pm.h"                              // for SIMPLE_DEV_PM_OPS
> #include "linux/time.h"                            // for CLOCK_BOOTTIME
> #include "vdso/bits.h"                             // for BIT
> 
> drivers/iio/proximity/cros_ec_mkbp_proximity.c should remove these lines:
> - #include <asm/unaligned.h>  // lines 24-24
> - #include <linux/iio/sysfs.h>  // lines 22-22
> - #include <linux/of.h>  // lines 12-12
> - #include <linux/slab.h>  // lines 14-14
> 
> The full include-list for drivers/iio/proximity/cros_ec_mkbp_proximity.c:
> #include <linux/iio/events.h>                      // for IIO_UNMOD_EVENT_CODE
> #include <linux/iio/iio.h>                         // for iio_priv, iio_dev
> #include <linux/kernel.h>                          // for ARRAY_SIZE, contai...
> #include <linux/module.h>                          // for MODULE_DESCRIPTION
> #include <linux/mutex.h>                           // for mutex_lock, mutex_...
> #include <linux/notifier.h>                        // for blocking_notifier_...
> #include <linux/platform_data/cros_ec_commands.h>  // for ec_params_mkbp_info
> #include <linux/platform_data/cros_ec_proto.h>     // for cros_ec_device
> #include <linux/platform_device.h>                 // for platform_get_drvdata
> #include <linux/types.h>                           // for bool
> #include <stddef.h>                                // for NULL, size_t
> #include "asm-generic/errno-base.h"                // for EINVAL, ENOMEM
> #include "asm-generic/errno.h"                     // for EPROTO
> #include "asm-generic/int-ll64.h"                  // for u32, s64, u64, u8
> #include "asm-generic/unaligned.h"                 // for get_unaligned_le32
> #include "linux/compiler_attributes.h"             // for __maybe_unused
> #include "linux/dev_printk.h"                      // for dev_warn
> #include "linux/device.h"                          // for dev_get_drvdata
> #include "linux/device/driver.h"                   // for device_driver
> #include "linux/iio/types.h"                       // for IIO_PROXIMITY, IIO...
> #include "linux/ktime.h"                           // for ktime_to_ns
> #include "linux/mod_devicetable.h"                 // for of_device_id
> #include "linux/pm.h"                              // for SIMPLE_DEV_PM_OPS
> #include "linux/time.h"                            // for CLOCK_BOOTTIME
> #include "vdso/bits.h"                             // for BIT
> 
> drivers/iio/pressure/cros_ec_baro.c should add these lines:
> #include "asm-generic/errno-base.h"                 // for EINVAL, ENOMEM
> #include "asm-generic/int-ll64.h"                   // for s16, u16
> #include "linux/dev_printk.h"                       // for dev_warn
> #include "linux/iio/types.h"                        // for IIO_CHAN_INFO_SCALE
> #include "linux/mod_devicetable.h"                  // for platform_device_id
> #include "linux/mutex.h"                            // for mutex_lock, mutex...
> #include "linux/stddef.h"                           // for true
> #include "vdso/bits.h"                              // for BIT
> 
> drivers/iio/pressure/cros_ec_baro.c should remove these lines:
> - #include <linux/iio/buffer.h>  // lines 9-9
> - #include <linux/iio/kfifo_buf.h>  // lines 12-12
> - #include <linux/iio/trigger.h>  // lines 13-13
> - #include <linux/iio/trigger_consumer.h>  // lines 15-15
> - #include <linux/iio/triggered_buffer.h>  // lines 14-14
> - #include <linux/kernel.h>  // lines 16-16
> - #include <linux/slab.h>  // lines 18-18
> 
> The full include-list for drivers/iio/pressure/cros_ec_baro.c:
> #include <linux/device.h>                           // for dev_get_drvdata
> #include <linux/iio/common/cros_ec_sensors_core.h>  // for cros_ec_sensors_c...
> #include <linux/iio/iio.h>                          // for iio_chan_spec
> #include <linux/module.h>                           // for MODULE_DESCRIPTION
> #include <linux/platform_data/cros_ec_commands.h>   // for ec_params_motion_...
> #include <linux/platform_data/cros_ec_proto.h>      // for cros_ec_dev
> #include <linux/platform_device.h>                  // for module_platform_d...
> #include "asm-generic/errno-base.h"                 // for EINVAL, ENOMEM
> #include "asm-generic/int-ll64.h"                   // for s16, u16
> #include "linux/dev_printk.h"                       // for dev_warn
> #include "linux/iio/types.h"                        // for IIO_CHAN_INFO_SCALE
> #include "linux/mod_devicetable.h"                  // for platform_device_id
> #include "linux/mutex.h"                            // for mutex_lock, mutex...
> #include "linux/stddef.h"                           // for true
> #include "vdso/bits.h"                              // for BIT
> 
> drivers/iio/light/cros_ec_light_prox.c should add these lines:
> #include <stdint.h>                                 // for int16_t
> #include "asm-generic/errno-base.h"                 // for EINVAL, ENOMEM
> #include "asm-generic/int-ll64.h"                   // for s16, s64, u16
> #include "linux/dev_printk.h"                       // for dev_warn
> #include "linux/iio/types.h"                        // for IIO_CHAN_INFO_CAL...
> #include "linux/mod_devicetable.h"                  // for platform_device_id
> #include "linux/mutex.h"                            // for mutex_lock, mutex...
> #include "linux/stddef.h"                           // for true
> #include "vdso/bits.h"                              // for BIT
> 
> drivers/iio/light/cros_ec_light_prox.c should remove these lines:
> - #include <linux/device.h>  // lines 8-8
> - #include <linux/iio/buffer.h>  // lines 9-9
> - #include <linux/iio/kfifo_buf.h>  // lines 12-12
> - #include <linux/iio/trigger.h>  // lines 13-13
> - #include <linux/iio/trigger_consumer.h>  // lines 15-15
> - #include <linux/iio/triggered_buffer.h>  // lines 14-14
> - #include <linux/kernel.h>  // lines 16-16
> - #include <linux/platform_data/cros_ec_proto.h>  // lines 19-19
> - #include <linux/slab.h>  // lines 21-21
> 
> The full include-list for drivers/iio/light/cros_ec_light_prox.c:
> #include <linux/iio/common/cros_ec_sensors_core.h>  // for cros_ec_sensors_c...
> #include <linux/iio/iio.h>                          // for iio_chan_spec
> #include <linux/module.h>                           // for MODULE_DESCRIPTION
> #include <linux/platform_data/cros_ec_commands.h>   // for ec_params_motion_...
> #include <linux/platform_device.h>                  // for module_platform_d...
> #include <stdint.h>                                 // for int16_t
> #include "asm-generic/errno-base.h"                 // for EINVAL, ENOMEM
> #include "asm-generic/int-ll64.h"                   // for s16, s64, u16
> #include "linux/dev_printk.h"                       // for dev_warn
> #include "linux/iio/types.h"                        // for IIO_CHAN_INFO_CAL...
> #include "linux/mod_devicetable.h"                  // for platform_device_id
> #include "linux/mutex.h"                            // for mutex_lock, mutex...
> #include "linux/stddef.h"                           // for true
> #include "vdso/bits.h"                              // for BIT
> 
> Jonathan Cameron (7):
>   platform/chrome: cros_ec_sensorhub_ring - avoid including iio.h
>   iio: cros_ec_sensors: Remove excessive IIO includes
>   iio: accel: cros_ec_accel_legacy: Drop unused IIO includes
>   iio: cros_ec_lid_angle: Drop unused IIO includes.
>   iio: light: cros_ec_light_prox: Drop unused IIO includes.
>   iio: pressure: cros_ec_baro: Drop unused IIO headers.
>   iio: prox: cros_ec_mkbp: Drop unused IIO headers.
> 
>  drivers/iio/accel/cros_ec_accel_legacy.c                  | 3 ---
>  drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c    | 4 ----
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c      | 4 ----
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 1 -
>  drivers/iio/light/cros_ec_light_prox.c                    | 5 -----
>  drivers/iio/pressure/cros_ec_baro.c                       | 5 -----
>  drivers/iio/proximity/cros_ec_mkbp_proximity.c            | 1 -
>  drivers/platform/chrome/cros_ec_sensorhub_ring.c          | 3 ++-
>  8 files changed, 2 insertions(+), 24 deletions(-)
> 

