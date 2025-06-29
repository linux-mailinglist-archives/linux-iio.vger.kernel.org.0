Return-Path: <linux-iio+bounces-21137-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35379AECF9E
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 20:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1D01891D66
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 18:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE0D238D54;
	Sun, 29 Jun 2025 18:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oN3H9d9W"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A2649625
	for <linux-iio@vger.kernel.org>; Sun, 29 Jun 2025 18:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751222624; cv=none; b=USVo/TZyB0UN1dnlVB2C+TNjeLHYVsCB1EjFMtZAT8PFBrR8qvLiWZ1pCVUV61nTHjlcv/L8sP8TBiChNKrY3hFXwV00Nyhlzx501Np9Fm9iVluiPWdbPYJG9O0WOFruCKV2pnR9InNNqQxVS9WumBZjx+D++P/VpaEF/4mr9Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751222624; c=relaxed/simple;
	bh=fHpdz9zZ7xVat8v2GURb0uLpC2gVJk3ZqhE5g1LuvM8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uDhDS+iXOwZe9dtCtigqGPSv3lqzZ7MV4ThXw10IlMP5MKc1xiVRCG7OXm5GI7of3iSlNP15jKzXs27Lc799ONFslKX9eEBc4DPaDwGcQzFChb7kGR/WJfqS9mVx1GqyoBnYc9hzKCDvQZTgxpBILXiKyqmtQtnKB+PmoFl++qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oN3H9d9W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27368C4CEEB;
	Sun, 29 Jun 2025 18:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751222623;
	bh=fHpdz9zZ7xVat8v2GURb0uLpC2gVJk3ZqhE5g1LuvM8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oN3H9d9W5gTPjjtiiz+neH0mGDjuCB5829d86Vcjm/OvYp34HjMhh22FLv9x/yuGv
	 D2qkyZGcbO2pqVqRUc2tblaP7pgmLjJ3Z7CRFCaLh0RvduYzlHgKuP+C9Q5sbcQOZB
	 Ou7cMT9ifK2AQti6pIYxm6LBoFtrvPl1aFF/Ujn90DHY5RyN7CCpHSj5IDTbSebt3r
	 cO802PyBo5/6SiZ1wce9XBa5RPLbW8sI4KWbxhGQ9B2VCXOHvrJfgxMGTwcdUAknla
	 g/n4VPEFCXj9l5InG0JaHoDWXM/hepRfO0NkPTgLiSZMSjTO8vpu9Kmhu9UU7eZdcv
	 l5YSkD7Jcaxrg==
Date: Sun, 29 Jun 2025 19:43:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: accel: kionix-kx022a: Apply approximate iwyu
 principles to includes
Message-ID: <20250629194336.34a03946@jic23-huawei>
In-Reply-To: <20250629183649.184479-1-jic23@kernel.org>
References: <20250629183649.184479-1-jic23@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 29 Jun 2025 19:36:49 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Motivated by the W=1 warning about export.h that was introduced this cycle
> this is an attempt to apply an approximation of the principles of including
> whatever is used in the file directly.
> 
> Helped by the include-what-you-use tool.
> 
> Reasoning:
> - Drop linux/moduleparam.h as completely unused.
> - linux/array_size.h for ARRAY_SIZE()
> - linux/bitmap.h for for_each_set_bit
> - linux/errno.h for error codes.
> - linux/export.h for EXPORT_SYMBOL*()
> - linux/math64.h for do_div - alternative would be asm/div64.h
> - linux/minmax.h for min()
> - linux/sysfs.h for sysfs_emit()
> - linux/time64.h for USEC_PER_MSEC
> - linux/iio/buffer.h for iio_push_to_buffers_with_timestamp()
> - asm/byteorder.h for le16_to_cpu()
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> 
> I picked this one fairly randomly as an example but longer term I'd like
> to look through at least all new drivers with this in mind + all the ones
> that are currently messing up my W=1 build logs.
> 
> Note I've been very descriptive in this patch to allow people to suggest
> better alternatives for some of the ones that aren't entirely obvious.
> 
Helpfully I had a script lying around from 2021:
https://lore.kernel.org/all/20211003153306.391766-1-jic23@kernel.org/

Just for reference I used iwyu with: 

make LLVM=1 LOCALVERSION= W=1 -j12 C=1 CHECK=include-what-you-use CHECKFLAGS="-Xiwyu --no_default_mappings -Xiwyu --mapping_file=iio.imp"

where iio.imp is from a few years ago and contains:
	{ include: ["\"linux/sizes.h\"", "private", <linux/sizes.h>, "public"] },
	{ include: ["\"linux/slab.h\"", "private", <linux/slab.h>, "public"] },
	{ include: ["\"linux/spinlock.h\"", "private", <linux/spinlock.h>, "public"] },
	{ include: ["\"linux/spinlock_types.h\"", "private", <linux/spinlock.h>, "public"] },
	{ include: ["\"linux/spi/spi.h\"", "private", <linux/spi/spi.h>, "public"] },
	{ include: ["\"linux/stat.h\"", "private", <linux/stat.h>, "public"] },
	{ include: ["\"linux/stdarg.h\"", "private", <linux/stdarg.h>, "public"] },
	{ include: ["\"linux/stddef.h\"", "private", <linux/stddef.h>, "public"] },
	{ include: ["\"linux/string.h\"", "private", <linux/string.h>, "public"] },
	{ include: ["\"linux/stringify.h\"", "private", <linux/stringify.h>, "public"] },
	{ include: ["\"linux/sysfs.h\"", "private", <linux/sysfs.h>, "public"] },
	{ include: ["\"linux/types.h\"", "private", <linux/types.h>, "public"] },
	{ include: ["\"linux/uuid.h\"", "private", <linux/uuid.h>, "public"] },
	{ include: ["\"linux/sched.h\"", "private", <linux/sched.h>, "public"] },
	{ include: ["\"linux/wait.h\"", "private", <linux/wait.h>, "public"] },
	{ include: ["\"linux/workqueue.h\"", "private", <linux/workqueue.h>, "public"] },
	{ include: ["\"asm-generic/int-ll64.h\"", "private", <linux/types.h>, "public"] },	
	{ include: ["\"linux/device.h\"", "private", <linux/device.h>, "public"] },
	{ include: ["\"linux/dev_printk.h\"", "private", <linux/device.h>, "public"] },
	{ include: ["\"linux/device/bus.h\"", "private", <linux/device.h>, "public"] },
	{ include: ["\"linux/device/driver.h\"", "private", <linux/device.h>, "public"] },
	{ include: ["\"linux/bits.h\"", "private", <linux/bits.h>, "public"] },	
	{ include: ["\"vdso/bits.h\"", "private", <linux/bits.h>, "public"] },
	{ include: ["\"vdso/limits.h\"", "private", <linux/limits.h>, "public"] },
	{ include: ["\"linux/limits.h\"", "private", <linux/limits.h>, "public"] },
	{ include: ["\"vdso/ktime.h\"", "private", <linux/ktime.h>, "public"] },
	{ include: ["\"linux/ktime.h\"", "private", <linux/ktime.h>, "public"] },
	{ include: ["\"vdso/time64.h\"", "private", <linux/time64.h>, "public"] },
	{ include: ["\"linux/time.h\"", "private", <linux/time.h>, "public"] },
	{ include: ["\"linux/timer.h\"", "private", <linux/timer.h>, "public"] }
]

Clear this needs a few upates, like mutex_types.h -> mutex.h and
probably devres.h->device.h


output was:

drivers/iio/accel/kionix-kx022a.c should add these lines:                                                                               
#include <asm/byteorder.h>               // for le16_to_cpu                                                                             
#include <asm/div64.h>                   // for do_div                                                                                  
#include <linux/bitmap.h>                // for for_each_set_bit                                                                        
#include <linux/compiler.h>              // for __aligned                                                                               
#include <linux/errno.h>                 // for EINVAL, EBUSY, ENOMEM, ENODEV                                     
#include <linux/export.h>                // for EXPORT_SYMBOL_NS_GPL                                                      
#include <linux/iio/buffer.h>            // for iio_push_to_buffers_with_tim...                                         
#include <linux/minmax.h>                // for __cmp_op_min, min, __cmp_op_max                                           
#include <linux/stddef.h>                // for false, true, NULL                                                                       
#include <linux/sysfs.h>                 // for sysfs_emit                                                                              
#include <linux/time64.h>                // for USEC_PER_MSEC, NSEC_PER_MSEC                                            
#include "linux/array_size.h"            // for ARRAY_SIZE                                                                              
#include "linux/device/devres.h"         // for devm_kasprintf                                                                          
#include "linux/gfp_types.h"             // for GFP_KERNEL                                                                              
#include "linux/mutex_types.h"           // for mutex                                                                                   
                                                                                                                                        
drivers/iio/accel/kionix-kx022a.c should remove these lines:                                                                            
- #include <linux/moduleparam.h>  // lines 13-13                                                                                        
                                                                                                                                        
The full include-list for drivers/iio/accel/kionix-kx022a.c:                                                                            
#include "kionix-kx022a.h"                                                                                                              
#include <asm/byteorder.h>               // for le16_to_cpu                                                                             
#include <asm/div64.h>                   // for do_div                                                                                  
#include <linux/bitmap.h>                // for for_each_set_bit                                                                        
#include <linux/cleanup.h>               // for guard                                                                                   
#include <linux/compiler.h>              // for __aligned                                                                               
#include <linux/delay.h>                 // for msleep                                                                                  
#include <linux/device.h>                // for dev_err_probe, dev_err, dev_...                                           
#include <linux/errno.h>                 // for EINVAL, EBUSY, ENOMEM, ENODEV                                    
#include <linux/export.h>                // for EXPORT_SYMBOL_NS_GPL                                                        
#include <linux/iio/buffer.h>            // for iio_push_to_buffers_with_tim...                                         
#include <linux/iio/iio.h>               // for iio_chan_info_enum, iio_endian                                      
#include <linux/iio/sysfs.h>             // for IIO_DEVICE_ATTR_RO                                                                      
#include <linux/iio/trigger.h>           // for devm_iio_trigger_register                                                  
#include <linux/iio/trigger_consumer.h>  // for iio_trigger_notify_done, iio...                                        
#include <linux/iio/triggered_buffer.h>  // for devm_iio_triggered_buffer_se...                                         
#include <linux/interrupt.h>             // for irqreturn, irqreturn_t, devm...                                 
#include <linux/minmax.h>                // for __cmp_op_min, min, __cmp_op_max                                      
#include <linux/module.h>                // for MODULE_AUTHOR, MODULE_DESCRI...                                   
#include <linux/mutex.h>                 // for mutex_unlock, mutex_lock                                     
#include <linux/property.h>              // for fwnode_irq_get_byname, dev_f...                                  
#include <linux/regmap.h>                // for regmap_range, regmap_set_bits                              
#include <linux/regulator/consumer.h>    // for devm_regulator_bulk_get_enable                                           
#include <linux/slab.h>                  // for kfree, kmalloc_array                                                                
#include <linux/stddef.h>                // for false, true, NULL                                                                       
#include <linux/string_choices.h>        // for str_on_off                                                                              
#include <linux/sysfs.h>                 // for sysfs_emit                                                                              
#include <linux/time64.h>                // for USEC_PER_MSEC, NSEC_PER_MSEC                                 
#include <linux/types.h>                 // for __le16, bool, int64_t, ssize_t                                   
#include <linux/units.h>                 // for MEGA                                                                                    
#include "linux/array_size.h"            // for ARRAY_SIZE                                                                              
#include "linux/device/devres.h"         // for devm_kasprintf                                                                          
#include "linux/gfp_types.h"             // for GFP_KERNEL                                                                              
#include "linux/mutex_types.h"           // for mutex
> ---
>  drivers/iio/accel/kionix-kx022a.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
> index 07dcf5f0599f..39485572a76b 100644
> --- a/drivers/iio/accel/kionix-kx022a.c
> +++ b/drivers/iio/accel/kionix-kx022a.c
> @@ -5,27 +5,37 @@
>   * ROHM/KIONIX accelerometer driver
>   */
>  
> +#include <linux/array_size.h>
> +#include <linux/bitmap.h>
>  #include <linux/cleanup.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/export.h>
>  #include <linux/interrupt.h>
> +#include <linux/math64.h>
> +#include <linux/minmax.h>
>  #include <linux/module.h>
> -#include <linux/moduleparam.h>
>  #include <linux/mutex.h>
>  #include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/string_choices.h>
> +#include <linux/sysfs.h>
> +#include <linux/time64.h>
>  #include <linux/types.h>
>  #include <linux/units.h>
>  
>  #include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/trigger.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
>  
> +#include <asm/byteorder.h>
> +
>  #include "kionix-kx022a.h"
>  
>  /*


