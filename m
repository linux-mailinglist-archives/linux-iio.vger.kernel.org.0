Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C088C232335
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jul 2020 19:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgG2RMi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 29 Jul 2020 13:12:38 -0400
Received: from mga09.intel.com ([134.134.136.24]:56217 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgG2RMi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 29 Jul 2020 13:12:38 -0400
IronPort-SDR: npehCSKej0B8TTOrWC9LCHq9kzT5oBLWP2FnNcmLEE1f/illdWDEZQe6pDBOC+VhkU0bf4Qnyl
 hFG2b+6hBDqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="152696472"
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; 
   d="scan'208";a="152696472"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 10:12:37 -0700
IronPort-SDR: oWkvcZTwpwl3OcUXiSbJgNuAG/RFXg7dr4ByMf1SNKGdhNosoSy8lSSWGobIcE7CXpoKm9Fngx
 GhuGhrHCmrIA==
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; 
   d="scan'208";a="464932285"
Received: from spandruv-mobl.amr.corp.intel.com ([10.255.229.136])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 10:12:36 -0700
Message-ID: <a870c6cc8a498e46d06106be9d83e4f7cbebf717.camel@linux.intel.com>
Subject: Re: [PATCH v3 03/27] iio:accel:bmc150-accel: Fix timestamp
 alignment and prevent data leak.
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date:   Wed, 29 Jul 2020 10:12:36 -0700
In-Reply-To: <20200722155103.979802-4-jic23@kernel.org>
References: <20200722155103.979802-1-jic23@kernel.org>
         <20200722155103.979802-4-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 2020-07-22 at 16:50 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> One of a class of bugs pointed out by Lars in a recent review.
> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> to the size of the timestamp (8 bytes).  This is not guaranteed in
> this driver which uses a 16 byte array of smaller elements on the
> stack.
> As Lars also noted this anti pattern can involve a leak of data to
> userspace and that indeed can happen here.  We close both issues by
> moving
> to a suitable structure in the iio_priv() data with alignment
> ensured by use of an explicit c structure.  This data is allocated
> with kzalloc so no data can leak appart from previous readings.
> 
> Fixes tag is beyond some major refactoring so likely manual
> backporting
> would be needed to get that far back.
> 
> Whilst the force alignment of the ts is not strictly necessary, it
> does make the code less fragile.
> 
> Fixes: 3bbec9773389 ("iio: bmc150_accel: add support for hardware
> fifo")
> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/iio/accel/bmc150-accel-core.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c
> b/drivers/iio/accel/bmc150-accel-core.c
> index 24864d9dfab5..48435865fdaf 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -189,6 +189,14 @@ struct bmc150_accel_data {
>  	struct mutex mutex;
>  	u8 fifo_mode, watermark;
>  	s16 buffer[8];
> +	/*
> +	 * Ensure there is sufficient space and correct alignment for
> +	 * the timestamp if enabled
> +	 */
> +	struct {
> +		__le16 channels[3];
> +		s64 ts __aligned(8);
> +	} scan;
>  	u8 bw_bits;
>  	u32 slope_dur;
>  	u32 slope_thres;
> @@ -922,15 +930,16 @@ static int __bmc150_accel_fifo_flush(struct
> iio_dev *indio_dev,
>  	 * now.
>  	 */
>  	for (i = 0; i < count; i++) {
> -		u16 sample[8];
>  		int j, bit;
>  
>  		j = 0;
>  		for_each_set_bit(bit, indio_dev->active_scan_mask,
>  				 indio_dev->masklength)
> -			memcpy(&sample[j++], &buffer[i * 3 + bit], 2);
> +			memcpy(&data->scan.channels[j++], &buffer[i * 3
> + bit],
> +			       sizeof(data->scan.channels[0]));
>  
> -		iio_push_to_buffers_with_timestamp(indio_dev, sample,
> tstamp);
> +		iio_push_to_buffers_with_timestamp(indio_dev, &data-
> >scan,
> +						   tstamp);
>  
>  		tstamp += sample_period;
>  	}

