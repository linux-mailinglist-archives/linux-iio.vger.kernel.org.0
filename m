Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23B76102205
	for <lists+linux-iio@lfdr.de>; Tue, 19 Nov 2019 11:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbfKSKXg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Nov 2019 05:23:36 -0500
Received: from mga05.intel.com ([192.55.52.43]:57512 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbfKSKXg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 19 Nov 2019 05:23:36 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 02:23:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,322,1569308400"; 
   d="scan'208";a="215511808"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2019 02:23:33 -0800
Received: from andy by smile with local (Exim 4.93-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iX0fU-000297-Vj; Tue, 19 Nov 2019 12:23:32 +0200
Date:   Tue, 19 Nov 2019 12:23:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: adc: intel_mrfld_adc: Allocating too much data in
 probe()
Message-ID: <20191119102332.GC32742@smile.fi.intel.com>
References: <20191119062124.kgwg7ujxe6k2ft3o@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119062124.kgwg7ujxe6k2ft3o@kili.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Nov 19, 2019 at 09:21:24AM +0300, Dan Carpenter wrote:
> This probe function is passing the wrong size to devm_iio_device_alloc().
> It is supposed to be the size of the private data.  Fortunately,
> sizeof(*indio_dev) is larger than sizeof(struct mrfld_adc) so it doesn't
> cause a runtime problem.
> 

Ah, indeed, thanks for fixing this!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: a7118662734a ("iio: adc: intel_mrfld_adc: Add Basin Cove ADC driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/iio/adc/intel_mrfld_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/intel_mrfld_adc.c b/drivers/iio/adc/intel_mrfld_adc.c
> index 67d096f8180d..c35a1beb817c 100644
> --- a/drivers/iio/adc/intel_mrfld_adc.c
> +++ b/drivers/iio/adc/intel_mrfld_adc.c
> @@ -185,7 +185,7 @@ static int mrfld_adc_probe(struct platform_device *pdev)
>  	int irq;
>  	int ret;
>  
> -	indio_dev = devm_iio_device_alloc(dev, sizeof(*indio_dev));
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(struct mrfld_adc));

Many drivers use sizeof(*adc) form, but I'm okay with either.

>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> -- 
> 2.11.0
> 

-- 
With Best Regards,
Andy Shevchenko


