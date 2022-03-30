Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3114EC77A
	for <lists+linux-iio@lfdr.de>; Wed, 30 Mar 2022 16:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347555AbiC3OzO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 30 Mar 2022 10:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347668AbiC3Oyh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Mar 2022 10:54:37 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CF64B1D0
        for <linux-iio@vger.kernel.org>; Wed, 30 Mar 2022 07:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648651967; x=1680187967;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h+kpo0IzEnXiF5ibFqqkWNafwNzcqM+4NGAOasFLGMw=;
  b=fyQAnuSBN89mv1w7miL4LGkH8tzIjGrFYZz6AFOIp7ZJPjvu83Yje7vL
   fxi2bv4UNL0IWOml7Gn4pJi9rm22SRR+PWLduOHw75YXI4BIwO1/P71GT
   wUSUSKOUD1fRmu67xCNG4Ne6B0g3M2EEqpEjEXmXsDYwmqL6Nvt1YAwv0
   /psDmRFhrR6jSNcWGeuSbmYpSbUhHlFCRhLLVhOtuiY4rNllbWXn4nXmh
   WL1DBnmPV6T6Ll1EYpcpTSqDpGxjtEbXQ2q5xSb0+QVI39LWj1h0J+QPO
   ZZ4O1qsgbhfhUNm3Jj5s3tI/C52SPL99j3xnjSFDl56+Pgo1/gnCI6iUR
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="284470320"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="284470320"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 07:52:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="639753020"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 07:52:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1nZZgD-009Scr-Ai;
        Wed, 30 Mar 2022 17:52:13 +0300
Date:   Wed, 30 Mar 2022 17:52:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3] iio: core: Print error in case sample bits do not fit
 storage bits
Message-ID: <YkRunZ15S5noNYbJ@smile.fi.intel.com>
References: <20220328195307.154422-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328195307.154422-1-marex@denx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 28, 2022 at 09:53:07PM +0200, Marek Vasut wrote:
> Add runtime check to verify whether storagebits are at least as big
> as shifted realbits. This should help spot broken drivers which may
> set realbits + shift above storagebits.

Let's go with it.
Reviewed-by: Andy Shevchenko <andy@kernel.org>

> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> V2: Use dev_err() instead as WARN_ON() may panic() the kernel on existing machines
> V3: Abort probe and return -EINVAL in case this condition is triggered
> ---
>  drivers/iio/industrialio-buffer.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index b078eb2f3c9de..75a1c57b49102 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1629,6 +1629,19 @@ static int __iio_buffer_alloc_sysfs_and_mask(struct iio_buffer *buffer,
>  			if (channels[i].scan_index < 0)
>  				continue;
>  
> +			/* Verify that sample bits fit into storage */
> +			if (channels[i].scan_type.storagebits <
> +			    channels[i].scan_type.realbits +
> +			    channels[i].scan_type.shift) {
> +				dev_err(&indio_dev->dev,
> +					"Channel %d storagebits (%d) < shifted realbits (%d + %d)\n",
> +					i, channels[i].scan_type.storagebits,
> +					channels[i].scan_type.realbits,
> +					channels[i].scan_type.shift);
> +				ret = -EINVAL;
> +				goto error_cleanup_dynamic;
> +			}
> +
>  			ret = iio_buffer_add_channel_sysfs(indio_dev, buffer,
>  							 &channels[i]);
>  			if (ret < 0)
> -- 
> 2.35.1
> 

-- 
With Best Regards,
Andy Shevchenko


