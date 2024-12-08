Return-Path: <linux-iio+bounces-13234-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9CD9E86F7
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 18:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7BF6188260D
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 17:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F2317A58C;
	Sun,  8 Dec 2024 17:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsP/eHrl"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C99614658C;
	Sun,  8 Dec 2024 17:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733677810; cv=none; b=hKCOxLuWb7ZmDejZOQr32tJ9DMQEGFBDaVKO+Old+6MGgmh8G2ojHzGfvFb7mcjmlfq3utqb2fRiHE3GvxBEfPFvJnutpeYVKkg416YXURSlpjTtrldNPHpPOBJke690Mi7pZec7WquC+QmK/gci3IWkJgvr0hEy31T7qOdHf7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733677810; c=relaxed/simple;
	bh=KF8nbs+k0tFoE1SZ40LOhno5q9rxhSVZ249lTbeBlnA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=icfdZclKszaJ/yeJNn8poFUnM2sZWS+zw1LNgUZEmeZJB/AVBf5DivYW07DBmmEuoOv42vSNbW7lIDraNw79/Ihd4/VeIVcMi8IPFLggzfNpR3xy/VhijcJWKPfn35KZLj1mlqtxxMx5o6l8sA9UhVNHjAVYYbAbiHb4LEAgajQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsP/eHrl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C05C4CED2;
	Sun,  8 Dec 2024 17:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733677809;
	bh=KF8nbs+k0tFoE1SZ40LOhno5q9rxhSVZ249lTbeBlnA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jsP/eHrl/Ng+QAqedYRBLU4HSpqfWDBIRJ0lxWobs4ySjYs4N9OWPJ5dAQQTMtw21
	 9M+zDDmwLWK+NTWoAHOhYGHbT6TYxZNZcYDrJJh2NKqY/D1xsgY/QwD6qK2FzdIyJw
	 G453NcA1wQeyI+xG2lGFpCg5kwQUwqhjqoegk0RDOO7Mvfr+Bs9eMu/IxeQiErrLdQ
	 BHBZ34K09uryxWB5kZFYCRx3+IzjNf7/nkTXw9B6lr3AYcGADQ1OK/FvsBO0TIwzFd
	 Kmko0nQTF/PFGszKouIUg3HPAPQuJ0xNCQ1e7y5VPdO0XBItldnpeFntjAvVUBxTL6
	 UmDjkQgR+4R+Q==
Date: Sun, 8 Dec 2024 17:10:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, gregkh@linuxfoundation.org, "Rafael J. Wysocki"
 <rafael@kernel.org>
Subject: Re: [PATCH v1 1/2] driver core: Split devres APIs to
 device/devres.h
Message-ID: <20241208171001.4994e749@jic23-huawei>
In-Reply-To: <20241203195340.855879-2-andriy.shevchenko@linux.intel.com>
References: <20241203195340.855879-1-andriy.shevchenko@linux.intel.com>
	<20241203195340.855879-2-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Dec 2024 21:48:51 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> device.h is a huge header which is hard to follow and easy to miss
> something. Improve that by splitting devres APIs to device/devres.h.
> 
> In particular this helps to speedup the build of the code that includes
> device.h solely for a devres APIs.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/device.h        | 122 +--------------------------------
>  include/linux/device/devres.h | 124 ++++++++++++++++++++++++++++++++++
>  2 files changed, 127 insertions(+), 119 deletions(-)
>  create mode 100644 include/linux/device/devres.h
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 667cb6db9019..ad8ffbfc8651 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -12,6 +12,7 @@
>  #ifndef _DEVICE_H_
>  #define _DEVICE_H_
>  
> +#include <linux/cleanup.h>
>  #include <linux/dev_printk.h>
>  #include <linux/energy_model.h>
>  #include <linux/ioport.h>
> @@ -26,11 +27,11 @@
>  #include <linux/atomic.h>
>  #include <linux/uidgid.h>
>  #include <linux/gfp.h>
> -#include <linux/overflow.h>
> +
Unrelated change.
>  #include <linux/device/bus.h>
>  #include <linux/device/class.h>
> +#include <linux/device/devres.h>
>  #include <linux/device/driver.h>
> -#include <linux/cleanup.h>
This header movement is unrelated.

I agree both are good but probably want to be a separate patch.

Otherwise this seems sensible to me, but your cc list seems a little short!

Greg and Rafael seems a good starting point so I've added them.

Jonathan


>  #include <asm/device.h>
>  
>  struct device;
> @@ -281,123 +282,6 @@ int __must_check device_create_bin_file(struct device *dev,
>  void device_remove_bin_file(struct device *dev,
>  			    const struct bin_attribute *attr);
>  
> -/* device resource management */
> -typedef void (*dr_release_t)(struct device *dev, void *res);
> -typedef int (*dr_match_t)(struct device *dev, void *res, void *match_data);
> -
> -void *__devres_alloc_node(dr_release_t release, size_t size, gfp_t gfp,
> -			  int nid, const char *name) __malloc;
> -#define devres_alloc(release, size, gfp) \
> -	__devres_alloc_node(release, size, gfp, NUMA_NO_NODE, #release)
> -#define devres_alloc_node(release, size, gfp, nid) \
> -	__devres_alloc_node(release, size, gfp, nid, #release)
> -
> -void devres_for_each_res(struct device *dev, dr_release_t release,
> -			 dr_match_t match, void *match_data,
> -			 void (*fn)(struct device *, void *, void *),
> -			 void *data);
> -void devres_free(void *res);
> -void devres_add(struct device *dev, void *res);
> -void *devres_find(struct device *dev, dr_release_t release,
> -		  dr_match_t match, void *match_data);
> -void *devres_get(struct device *dev, void *new_res,
> -		 dr_match_t match, void *match_data);
> -void *devres_remove(struct device *dev, dr_release_t release,
> -		    dr_match_t match, void *match_data);
> -int devres_destroy(struct device *dev, dr_release_t release,
> -		   dr_match_t match, void *match_data);
> -int devres_release(struct device *dev, dr_release_t release,
> -		   dr_match_t match, void *match_data);
> -
> -/* devres group */
> -void * __must_check devres_open_group(struct device *dev, void *id, gfp_t gfp);
> -void devres_close_group(struct device *dev, void *id);
> -void devres_remove_group(struct device *dev, void *id);
> -int devres_release_group(struct device *dev, void *id);
> -
> -/* managed devm_k.alloc/kfree for device drivers */
> -void *devm_kmalloc(struct device *dev, size_t size, gfp_t gfp) __alloc_size(2);
> -void *devm_krealloc(struct device *dev, void *ptr, size_t size,
> -		    gfp_t gfp) __must_check __realloc_size(3);
> -__printf(3, 0) char *devm_kvasprintf(struct device *dev, gfp_t gfp,
> -				     const char *fmt, va_list ap) __malloc;
> -__printf(3, 4) char *devm_kasprintf(struct device *dev, gfp_t gfp,
> -				    const char *fmt, ...) __malloc;
> -static inline void *devm_kzalloc(struct device *dev, size_t size, gfp_t gfp)
> -{
> -	return devm_kmalloc(dev, size, gfp | __GFP_ZERO);
> -}
> -static inline void *devm_kmalloc_array(struct device *dev,
> -				       size_t n, size_t size, gfp_t flags)
> -{
> -	size_t bytes;
> -
> -	if (unlikely(check_mul_overflow(n, size, &bytes)))
> -		return NULL;
> -
> -	return devm_kmalloc(dev, bytes, flags);
> -}
> -static inline void *devm_kcalloc(struct device *dev,
> -				 size_t n, size_t size, gfp_t flags)
> -{
> -	return devm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
> -}
> -static inline __realloc_size(3, 4) void * __must_check
> -devm_krealloc_array(struct device *dev, void *p, size_t new_n, size_t new_size, gfp_t flags)
> -{
> -	size_t bytes;
> -
> -	if (unlikely(check_mul_overflow(new_n, new_size, &bytes)))
> -		return NULL;
> -
> -	return devm_krealloc(dev, p, bytes, flags);
> -}
> -
> -void devm_kfree(struct device *dev, const void *p);
> -char *devm_kstrdup(struct device *dev, const char *s, gfp_t gfp) __malloc;
> -const char *devm_kstrdup_const(struct device *dev, const char *s, gfp_t gfp);
> -void *devm_kmemdup(struct device *dev, const void *src, size_t len, gfp_t gfp)
> -	__realloc_size(3);
> -
> -unsigned long devm_get_free_pages(struct device *dev,
> -				  gfp_t gfp_mask, unsigned int order);
> -void devm_free_pages(struct device *dev, unsigned long addr);
> -
> -#ifdef CONFIG_HAS_IOMEM
> -void __iomem *devm_ioremap_resource(struct device *dev,
> -				    const struct resource *res);
> -void __iomem *devm_ioremap_resource_wc(struct device *dev,
> -				       const struct resource *res);
> -
> -void __iomem *devm_of_iomap(struct device *dev,
> -			    struct device_node *node, int index,
> -			    resource_size_t *size);
> -#else
> -
> -static inline
> -void __iomem *devm_ioremap_resource(struct device *dev,
> -				    const struct resource *res)
> -{
> -	return ERR_PTR(-EINVAL);
> -}
> -
> -static inline
> -void __iomem *devm_ioremap_resource_wc(struct device *dev,
> -				       const struct resource *res)
> -{
> -	return ERR_PTR(-EINVAL);
> -}
> -
> -static inline
> -void __iomem *devm_of_iomap(struct device *dev,
> -			    struct device_node *node, int index,
> -			    resource_size_t *size)
> -{
> -	return ERR_PTR(-EINVAL);
> -}
> -
> -#endif
> -
>  /* allows to add/remove a custom action to devres stack */
>  void devm_remove_action(struct device *dev, void (*action)(void *), void *data);
>  void devm_release_action(struct device *dev, void (*action)(void *), void *data);
> diff --git a/include/linux/device/devres.h b/include/linux/device/devres.h
> new file mode 100644
> index 000000000000..128d65defafc
> --- /dev/null
> +++ b/include/linux/device/devres.h
> @@ -0,0 +1,124 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _DEVICE_DEVRES_H_
> +#define _DEVICE_DEVRES_H_
> +
> +#include <linux/err.h>
> +#include <linux/gfp_types.h>
> +#include <linux/numa.h>
> +#include <linux/overflow.h>
> +#include <linux/stdarg.h>
> +#include <linux/types.h>
> +
> +struct device;
> +struct device_node;
> +struct resource;
> +
> +/* device resource management */
> +typedef void (*dr_release_t)(struct device *dev, void *res);
> +typedef int (*dr_match_t)(struct device *dev, void *res, void *match_data);
> +
> +void * __malloc
> +__devres_alloc_node(dr_release_t release, size_t size, gfp_t gfp, int nid, const char *name);
> +#define devres_alloc(release, size, gfp) \
> +	__devres_alloc_node(release, size, gfp, NUMA_NO_NODE, #release)
> +#define devres_alloc_node(release, size, gfp, nid) \
> +	__devres_alloc_node(release, size, gfp, nid, #release)
> +
> +void devres_for_each_res(struct device *dev, dr_release_t release,
> +			 dr_match_t match, void *match_data,
> +			 void (*fn)(struct device *, void *, void *),
> +			 void *data);
> +void devres_free(void *res);
> +void devres_add(struct device *dev, void *res);
> +void *devres_find(struct device *dev, dr_release_t release, dr_match_t match, void *match_data);
> +void *devres_get(struct device *dev, void *new_res, dr_match_t match, void *match_data);
> +void *devres_remove(struct device *dev, dr_release_t release, dr_match_t match, void *match_data);
> +int devres_destroy(struct device *dev, dr_release_t release, dr_match_t match, void *match_data);
> +int devres_release(struct device *dev, dr_release_t release, dr_match_t match, void *match_data);
> +
> +/* devres group */
> +void * __must_check devres_open_group(struct device *dev, void *id, gfp_t gfp);
> +void devres_close_group(struct device *dev, void *id);
> +void devres_remove_group(struct device *dev, void *id);
> +int devres_release_group(struct device *dev, void *id);
> +
> +/* managed devm_k.alloc/kfree for device drivers */
> +void * __alloc_size(2)
> +devm_kmalloc(struct device *dev, size_t size, gfp_t gfp);
> +void * __must_check __realloc_size(3)
> +devm_krealloc(struct device *dev, void *ptr, size_t size, gfp_t gfp);
> +static inline void *devm_kzalloc(struct device *dev, size_t size, gfp_t gfp)
> +{
> +	return devm_kmalloc(dev, size, gfp | __GFP_ZERO);
> +}
> +static inline void *devm_kmalloc_array(struct device *dev, size_t n, size_t size, gfp_t flags)
> +{
> +	size_t bytes;
> +
> +	if (unlikely(check_mul_overflow(n, size, &bytes)))
> +		return NULL;
> +
> +	return devm_kmalloc(dev, bytes, flags);
> +}
> +static inline void *devm_kcalloc(struct device *dev, size_t n, size_t size, gfp_t flags)
> +{
> +	return devm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
> +}
> +static inline __realloc_size(3, 4) void * __must_check
> +devm_krealloc_array(struct device *dev, void *p, size_t new_n, size_t new_size, gfp_t flags)
> +{
> +	size_t bytes;
> +
> +	if (unlikely(check_mul_overflow(new_n, new_size, &bytes)))
> +		return NULL;
> +
> +	return devm_krealloc(dev, p, bytes, flags);
> +}
> +
> +void devm_kfree(struct device *dev, const void *p);
> +
> +void * __realloc_size(3)
> +devm_kmemdup(struct device *dev, const void *src, size_t len, gfp_t gfp);
> +
> +char * __malloc
> +devm_kstrdup(struct device *dev, const char *s, gfp_t gfp);
> +const char *devm_kstrdup_const(struct device *dev, const char *s, gfp_t gfp);
> +char * __printf(3, 0) __malloc
> +devm_kvasprintf(struct device *dev, gfp_t gfp, const char *fmt, va_list ap);
> +char * __printf(3, 4) __malloc
> +devm_kasprintf(struct device *dev, gfp_t gfp, const char *fmt, ...);
> +
> +unsigned long devm_get_free_pages(struct device *dev, gfp_t gfp_mask, unsigned int order);
> +void devm_free_pages(struct device *dev, unsigned long addr);
> +
> +#ifdef CONFIG_HAS_IOMEM
> +
> +void __iomem *devm_ioremap_resource(struct device *dev, const struct resource *res);
> +void __iomem *devm_ioremap_resource_wc(struct device *dev, const struct resource *res);
> +
> +void __iomem *devm_of_iomap(struct device *dev, struct device_node *node, int index,
> +			    resource_size_t *size);
> +#else
> +
> +static inline
> +void __iomem *devm_ioremap_resource(struct device *dev, const struct resource *res)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +static inline
> +void __iomem *devm_ioremap_resource_wc(struct device *dev, const struct resource *res)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +static inline
> +void __iomem *devm_of_iomap(struct device *dev, struct device_node *node, int index,
> +			    resource_size_t *size)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +#endif
> +
> +#endif /* _DEVICE_DEVRES_H_ */


