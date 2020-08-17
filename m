Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182A8246F2B
	for <lists+linux-iio@lfdr.de>; Mon, 17 Aug 2020 19:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388952AbgHQRni (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 Aug 2020 13:43:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:15588 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389020AbgHQRng (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 17 Aug 2020 13:43:36 -0400
IronPort-SDR: 7qTGAf6WCxdsON/v/hgHw5/Ruc4bSQc7PZ9i29PEWvrfqNz+I8Kkgi/dNKxVCo72h9xmm4CruZ
 6ckFsnnnbj4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="152171570"
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="152171570"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 10:43:35 -0700
IronPort-SDR: EsGJDlG2Elfx4PTVo5feMiTZDFCT7ABc4DH894/gUpMct7O9/tuNSP2eKBlobYUnIYJDzVDwcx
 ONdxB+GKxpZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="326478021"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 17 Aug 2020 10:43:32 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k7j6C-009TgH-Dv; Mon, 17 Aug 2020 20:39:08 +0300
Date:   Mon, 17 Aug 2020 20:39:08 +0300
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
Subject: Re: [PATCH v7 1/3] devres: provide devm_krealloc()
Message-ID: <20200817173908.GS1891694@smile.fi.intel.com>
References: <20200817170535.17041-1-brgl@bgdev.pl>
 <20200817170535.17041-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817170535.17041-2-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 17, 2020 at 07:05:33PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Implement the managed variant of krealloc(). This function works with
> all memory allocated by devm_kmalloc() (or devres functions using it
> implicitly like devm_kmemdup(), devm_kstrdup() etc.).
> 
> Managed realloc'ed chunks can be manually released with devm_kfree().

Thanks for an update! My comments / questions below.

...

> +static struct devres *to_devres(void *data)
> +{
> +	return (struct devres *)((u8 *)data - ALIGN(sizeof(struct devres),
> +						    ARCH_KMALLOC_MINALIGN));

Do you really need both explicit castings?

> +}

...

> +	total_old_size = ksize(to_devres(ptr));

But how you can guarantee this pointer:
 - belongs to devres,
 - hasn't gone while you run a ksize()?

...

> +	new_dr = alloc_dr(devm_kmalloc_release,
> +			  total_new_size, gfp, dev_to_node(dev));

Can you move some parameters to the previous line?

> +	if (!new_dr)
> +		return NULL;

...

> +	spin_lock_irqsave(&dev->devres_lock, flags);
> +
> +	old_dr = find_dr(dev, devm_kmalloc_release, devm_kmalloc_match, ptr);
> +	if (!old_dr) {
> +		spin_unlock_irqrestore(&dev->devres_lock, flags);
> +		devres_free(new_dr);
> +		WARN(1, "Memory chunk not managed or managed by a different device.");
> +		return NULL;
> +	}
> +
> +	replace_dr(dev, &old_dr->node, &new_dr->node);
> +
> +	spin_unlock_irqrestore(&dev->devres_lock, flags);
> +
> +	memcpy(new_dr->data, old_dr->data, devres_data_size(total_old_size));

But new_dr may concurrently gone at this point, no? It means memcpy() should be
under spin lock.

-- 
With Best Regards,
Andy Shevchenko


