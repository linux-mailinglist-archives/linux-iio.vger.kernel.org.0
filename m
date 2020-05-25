Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A591E13B4
	for <lists+linux-iio@lfdr.de>; Mon, 25 May 2020 19:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388755AbgEYRwf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 May 2020 13:52:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:1874 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388621AbgEYRwf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 25 May 2020 13:52:35 -0400
IronPort-SDR: EYHir2+YA0lHUWWiX311pITdDVQg3ppPWkJ4n6c271eYuCie8HXw4GfeZ3banE3+Xkc3K5HC8L
 gsYt4EqyHdCQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2020 10:52:34 -0700
IronPort-SDR: N9eYChpweBH+Z2TwngucEBTFIUZL0lp+h6gGEjV1QsYUGzegPY7dxYs+ElThPUWs0DPz/9iYN5
 pxTqfMgqPSBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,434,1583222400"; 
   d="scan'208";a="254959989"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 25 May 2020 10:52:32 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jdHHA-008ptc-6p; Mon, 25 May 2020 20:52:36 +0300
Date:   Mon, 25 May 2020 20:52:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 19/25] iio:adc:ti-ads1015 Fix buffer element alignment
Message-ID: <20200525175236.GG1634618@smile.fi.intel.com>
References: <20200525170628.503283-1-jic23@kernel.org>
 <20200525170628.503283-20-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525170628.503283-20-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 25, 2020 at 06:06:22PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses an array of smaller elements on the stack.
> 
> Here we use an explicit structure and rely on that to enforce
> alignment on the stack.  Note there was never a data leak here
> due to the explicit memset.
> 
> Fixes: ecc24e72f437 ("iio: adc: Add TI ADS1015 ADC driver support")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/adc/ti-ads1015.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 5ea4f45d6bad..05853723dbdb 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -385,10 +385,14 @@ static irqreturn_t ads1015_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct ads1015_data *data = iio_priv(indio_dev);
> -	s16 buf[8]; /* 1x s16 ADC val + 3x s16 padding +  4x s16 timestamp */
> +	/* Ensure natural alignment for buffer elements */
> +	struct {
> +		s16 channel;
> +		s64 ts;
> +	} scan;

Hmm... On x86_32 and x86_64 this will give different padding. Is it okay from
iio_push_to_buffers_with_timestamp() point of view?

>  	int chan, ret, res;
>  
> -	memset(buf, 0, sizeof(buf));
> +	memset(&scan, 0, sizeof(scan));
>  
>  	mutex_lock(&data->lock);
>  	chan = find_first_bit(indio_dev->active_scan_mask,
> @@ -399,10 +403,10 @@ static irqreturn_t ads1015_trigger_handler(int irq, void *p)
>  		goto err;
>  	}
>  
> -	buf[0] = res;
> +	scan.channel = res;
>  	mutex_unlock(&data->lock);
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, buf,
> +	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
>  					   iio_get_time_ns(indio_dev));
>  
>  err:
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko


