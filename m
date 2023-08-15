Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161E177CE6D
	for <lists+linux-iio@lfdr.de>; Tue, 15 Aug 2023 16:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237662AbjHOOuN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Aug 2023 10:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237683AbjHOOto (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Aug 2023 10:49:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED05C5;
        Tue, 15 Aug 2023 07:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692110984; x=1723646984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U1a9LYcXm1tbEJKoK+HhtRRodOjMrQscpdZ+lCsnGVU=;
  b=kFX7c64dcz4PSglKl9O1wWIAZKacLrjaXWnohAQzNFPOuQSTHzANka1o
   XNLtB17+3Y+P8ddvpcdVM1xTE0xTD2DeOBlMDs1e2MFPc6M9eKorf9Viu
   GeAnVlks+GrtJgIkpmwOtWaLxQ3TF6PUwHXXXc9NV1/mQm3TZakxUqu5D
   leZkGLIeEQhZAK6RjxXmP/G/GeSqJmJI4vwqnYbw4+ToJryoB24oGIqxJ
   fixnnrk21D9aTF9JHiIfPlzJZgeJD/zeJ72+vaQEV+lW9CiPhrXkD1F8A
   bUI2iB3Cj1nGdPjWoA8NCbTWQcaiKIXpBNXkbkZWa+SH2aONDFVGf1exq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="362441216"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="362441216"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 07:49:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="727397358"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="727397358"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 15 Aug 2023 07:49:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVvMZ-005wcD-0S;
        Tue, 15 Aug 2023 17:49:39 +0300
Date:   Tue, 15 Aug 2023 17:49:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Peter Rosin <peda@axentia.se>,
        Krzysztof =?utf-8?Q?Ha=C5=82asa?= <khalasa@piap.pl>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: atlas-sensor: Convert enum->pointer for
 data in the match tables
Message-ID: <ZNuQggfB1jxlL5cW@smile.fi.intel.com>
References: <20230812171330.226247-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812171330.226247-1-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 12, 2023 at 06:13:30PM +0100, Biju Das wrote:
> Convert enum->pointer for data in the match tables, so that
> device_get_match_data() can do match against OF/ACPI/I2C tables, once i2c
> bus type match support added to it.
> 
> Replace enum->struct *atlas_device for data in the match table. Simplify
> the probe() by replacing device_get_match_data() and ID lookup for
> retrieving data by i2c_get_match_data().
> 
> While at it, add const qualifier to struct atlas_device and drop unused
> id variable from probe().

Same comments for id variable removal.
With that addressed and below remark,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

>  static const struct of_device_id atlas_dt_ids[] = {
> -	{ .compatible = "atlas,ph-sm", .data = (void *)ATLAS_PH_SM, },
> -	{ .compatible = "atlas,ec-sm", .data = (void *)ATLAS_EC_SM, },
> -	{ .compatible = "atlas,orp-sm", .data = (void *)ATLAS_ORP_SM, },
> -	{ .compatible = "atlas,do-sm", .data = (void *)ATLAS_DO_SM, },
> -	{ .compatible = "atlas,rtd-sm", .data = (void *)ATLAS_RTD_SM, },
> +	{ .compatible = "atlas,ph-sm", .data = &atlas_devices[ATLAS_PH_SM], },
> +	{ .compatible = "atlas,ec-sm", .data = &atlas_devices[ATLAS_EC_SM], },
> +	{ .compatible = "atlas,orp-sm", .data = &atlas_devices[ATLAS_ORP_SM], },
> +	{ .compatible = "atlas,do-sm", .data = &atlas_devices[ATLAS_DO_SM], },
> +	{ .compatible = "atlas,rtd-sm", .data = &atlas_devices[ATLAS_RTD_SM], },

Now drop inner trailing commas.

>  	{ }
>  };

-- 
With Best Regards,
Andy Shevchenko


