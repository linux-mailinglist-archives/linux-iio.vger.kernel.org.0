Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10EC724D09E
	for <lists+linux-iio@lfdr.de>; Fri, 21 Aug 2020 10:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgHUIfl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Aug 2020 04:35:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:62770 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbgHUIfj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 21 Aug 2020 04:35:39 -0400
IronPort-SDR: 473IjoKoSUySt7XxSerjKtpL6iZBXxpCmGyzfmrrMpAygYiGX/PRP8DzUz3NKGGBnO/QsWDCh9
 aOolRDmSCPlQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="143124538"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="143124538"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 01:35:38 -0700
IronPort-SDR: kPINq9ixWXyPpch7brhxnjMiBn6ePSw4V+gQnwsz0I5/NakVFttvyHIM9Z+bHNE0Nqf18ENI3v
 F+cuKaXVHgOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="327705621"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 21 Aug 2020 01:35:35 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k92DL-00AI66-Dw; Fri, 21 Aug 2020 11:15:55 +0300
Date:   Fri, 21 Aug 2020 11:15:55 +0300
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
Subject: Re: [PATCH v8 1/3] devres: provide devm_krealloc()
Message-ID: <20200821081555.GG1891694@smile.fi.intel.com>
References: <20200820185110.17828-1-brgl@bgdev.pl>
 <20200820185110.17828-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820185110.17828-2-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 20, 2020 at 08:51:08PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Implement the managed variant of krealloc(). This function works with
> all memory allocated by devm_kmalloc() (or devres functions using it
> implicitly like devm_kmemdup(), devm_kstrdup() etc.).
> 
> Managed realloc'ed chunks can be manually released with devm_kfree().
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> +static struct devres *to_devres(void *data)
> +{
> +	return data - ALIGN(sizeof(struct devres), ARCH_KMALLOC_MINALIGN);
> +}
> +
> +static size_t devres_data_size(size_t total_size)
> +{
> +	return total_size - ALIGN(sizeof(struct devres), ARCH_KMALLOC_MINALIGN);
> +}

I'm fine with above, but here is a side note, perhaps

	offsetof(struct devres,	data)

will be more practical (no duplication of alignment and hence slightly better
maintenance)? (Note, I didn't check if it provides the correct result)

Another side note: do we have existing users of these helpers?

-- 
With Best Regards,
Andy Shevchenko


