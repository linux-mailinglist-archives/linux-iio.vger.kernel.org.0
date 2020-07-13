Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5AFA21E0B4
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jul 2020 21:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgGMT3E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jul 2020 15:29:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:33435 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgGMT3E (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 13 Jul 2020 15:29:04 -0400
IronPort-SDR: mrhf7rNUC2PxeAUSiRbHkUa6TJXARkYUVczThuZRGn4ISqvksSUu8os3hD30XRXalc7CPEpdZx
 MSUwJGITUQ5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="128278626"
X-IronPort-AV: E=Sophos;i="5.75,348,1589266800"; 
   d="scan'208";a="128278626"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 12:29:04 -0700
IronPort-SDR: 7nnU7K24gRkjFEh2UkU1jeypUQx/rdcI1r7cJKYuqWXmY/BpvD9uFLeYYhdapQ2GcjQoBslpu0
 A9E/PUCiX57A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,348,1589266800"; 
   d="scan'208";a="485605105"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jul 2020 12:29:01 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jv48L-001eBY-Aq; Mon, 13 Jul 2020 22:29:01 +0300
Date:   Mon, 13 Jul 2020 22:29:01 +0300
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
Subject: Re: [PATCH v4 1/3] devres: provide devm_krealloc()
Message-ID: <20200713192901.GD3703480@smile.fi.intel.com>
References: <20200713145934.18243-1-brgl@bgdev.pl>
 <20200713145934.18243-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713145934.18243-2-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jul 13, 2020 at 04:59:32PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Implement the managed variant of krealloc(). This function works with
> all memory allocated by devm_kmalloc() (or devres functions using it
> implicitly like devm_kmemdup(), devm_kstrdup() etc.).
> 
> Managed realloc'ed chunks can be manually released with devm_kfree().
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  .../driver-api/driver-model/devres.rst        |  1 +
>  drivers/base/devres.c                         | 67 +++++++++++++++++++
>  include/linux/device.h                        |  2 +
>  3 files changed, 70 insertions(+)
> 
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
> index eaaaafc21134f..f318a5c0033c1 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -354,6 +354,7 @@ MEM
>    devm_kmalloc()
>    devm_kmalloc_array()
>    devm_kmemdup()
> +  devm_krealloc()
>    devm_kstrdup()
>    devm_kvasprintf()
>    devm_kzalloc()
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> index ed615d3b9cf15..1775d35462300 100644
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -837,6 +837,73 @@ void *devm_kmalloc(struct device *dev, size_t size, gfp_t gfp)
>  }
>  EXPORT_SYMBOL_GPL(devm_kmalloc);
>  
> +/**
> + * devm_krealloc - Resource-managed krealloc()
> + * @dev: Device to re-allocate memory for
> + * @ptr: Pointer to the memory chunk to re-allocate
> + * @new_size: New allocation size
> + * @gfp: Allocation gfp flags
> + *
> + * Managed krealloc(). Resizes the memory chunk allocated with devm_kmalloc().
> + * Behaves similarly to regular krealloc(): if @ptr is NULL or ZERO_SIZE_PTR,
> + * it's the equivalent of devm_kmalloc(). If new_size is zero, it returns

'it frees the previously allocated memory and returns'

> + * ZERO_SIZE_PTR. This function doesn't change the order in which the release
> + * callback for the re-alloc'ed devres will be called (except when falling back
> + * to devm_kmalloc()

'or when freeing resources when new_size is zero'

> ). The contents of the memory are preserved up to the
> + * lesser of new and old sizes.
> + */
> +void *devm_krealloc(struct device *dev, void *ptr, size_t new_size, gfp_t gfp)
> +{
> +	struct devres *old_dr, *new_dr;
> +	struct list_head old_head;
> +	unsigned long flags;
> +	size_t total_size;
> +	void *ret = NULL;
> +
> +	if (unlikely(!new_size)) {
> +		devm_kfree(dev, ptr);
> +		return ZERO_SIZE_PTR;
> +	}
> +
> +	if (unlikely(ZERO_OR_NULL_PTR(ptr)))
> +		return devm_kmalloc(dev, new_size, gfp);
> +
> +	if (WARN_ON(is_kernel_rodata((unsigned long)ptr)))
> +		/*
> +		 * We cannot reliably realloc a const string returned by
> +		 * devm_kstrdup_const().
> +		 */
> +		return NULL;
> +
> +	if (!check_dr_size(new_size, &total_size))
> +		return NULL;
> +
> +	spin_lock_irqsave(&dev->devres_lock, flags);
> +
> +	old_dr = find_dr(dev, devm_kmalloc_release, devm_kmalloc_match, ptr);
> +	if (!old_dr) {
> +		spin_unlock_irqrestore(&dev->devres_lock, flags);
> +		WARN(1, "Memory chunk not managed or managed by a different device.");
> +		return NULL;
> +	}
> +
> +	old_head = old_dr->node.entry;
> +
> +	new_dr = krealloc(old_dr, total_size, gfp);
> +	if (!new_dr) {
> +		spin_unlock_irqrestore(&dev->devres_lock, flags);
> +		return NULL;
> +	}
> +
> +	if (new_dr != old_dr)
> +		list_replace(&old_head, &new_dr->node.entry);
> +
> +	ret = new_dr->data;
> +	spin_unlock_irqrestore(&dev->devres_lock, flags);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(devm_krealloc);
> +
>  /**
>   * devm_kstrdup - Allocate resource managed space and
>   *                copy an existing string into that.
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 7322c51e9c0c7..f64f408431593 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -206,6 +206,8 @@ int devres_release_group(struct device *dev, void *id);
>  
>  /* managed devm_k.alloc/kfree for device drivers */
>  void *devm_kmalloc(struct device *dev, size_t size, gfp_t gfp) __malloc;

> +void *devm_krealloc(struct device *dev, void *ptr, size_t size,
> +		    gfp_t gfp) __must_check;

Strange indentation, also you can move __must_check to the beginning of the
declaration.


>  __printf(3, 0) char *devm_kvasprintf(struct device *dev, gfp_t gfp,
>  				     const char *fmt, va_list ap) __malloc;
>  __printf(3, 4) char *devm_kasprintf(struct device *dev, gfp_t gfp,
> -- 
> 2.26.1
> 

-- 
With Best Regards,
Andy Shevchenko


