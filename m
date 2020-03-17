Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78C7F188482
	for <lists+linux-iio@lfdr.de>; Tue, 17 Mar 2020 13:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgCQMwY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 08:52:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:64540 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgCQMwX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Mar 2020 08:52:23 -0400
IronPort-SDR: HhErm2z9RVL1gIquMreT5oktdmOuTdb5Ulq7e/WakwBHfwEFCtgYLtU13kD87rLs8sei3WuC3N
 Z++00FWGYRdA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 05:52:22 -0700
IronPort-SDR: agMZD3CRjW1p6dDuFc80F0YaKgfJXV7/sAUsP04jLr1wQHbR/NzTkOFYRfFj/SpiZGhURdfcqz
 puLd4E60LzjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,564,1574150400"; 
   d="scan'208";a="236318784"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 17 Mar 2020 05:52:21 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jEBhn-00ASUo-Gs; Tue, 17 Mar 2020 14:52:23 +0200
Date:   Tue, 17 Mar 2020 14:52:23 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org, lars@metafoo.de,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [PATCH] iio: buffer: re-introduce bitmap_zalloc() for trialmask
Message-ID: <20200317125223.GC1922688@smile.fi.intel.com>
References: <20200317123621.27722-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317123621.27722-1-alexandru.ardelean@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 17, 2020 at 02:36:21PM +0200, Alexandru Ardelean wrote:
> Commit 3862828a903d3 ("iio: buffer: Switch to bitmap_zalloc()") introduced
> bitmap_alloc(), but commit 20ea39ef9f2f9 ("iio: Fix scan mask selection")
> reverted it.
> 
> This change adds it back. The only difference is that it's adding
> bitmap_zalloc(). There might be some changes later that would require
> initializing it to zero. In any case, now it's already zero-ing the
> trialmask.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/industrialio-buffer.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 4ada5592aa2b..5ff34ce8b6a2 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -316,8 +316,7 @@ static int iio_scan_mask_set(struct iio_dev *indio_dev,
>  	const unsigned long *mask;
>  	unsigned long *trialmask;
>  
> -	trialmask = kcalloc(BITS_TO_LONGS(indio_dev->masklength),
> -			    sizeof(*trialmask), GFP_KERNEL);
> +	trialmask = bitmap_zalloc(indio_dev->masklength, GFP_KERNEL);
>  	if (trialmask == NULL)
>  		return -ENOMEM;
>  	if (!indio_dev->masklength) {
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


