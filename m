Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A5C77CE71
	for <lists+linux-iio@lfdr.de>; Tue, 15 Aug 2023 16:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234105AbjHOOuq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Aug 2023 10:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237570AbjHOOue (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Aug 2023 10:50:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A98593;
        Tue, 15 Aug 2023 07:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692111033; x=1723647033;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X+EiVyZFDqSQ5zUVzAqRBGeF1alwr/VBM/Fe03Ltu/c=;
  b=QBEtWdZ16dcqd4jFSmK0BBerJm2+//hli/XobuEAU2BeDbQn9B90rLPn
   9PGr1HexMwK50IU2XSMnyY4Da/8HAI29yUmE98/kIQu+2YewGba2GewDn
   GdTERJbcuXGeABlwIBR5dK4bP+3RjhiIWTRy57+hEal70m+8Fuk4WXEMy
   N+IncGDzUbRWBSzGb5ZH2wM9ARo5juux/DkNF2v5rrva4Tie0hRFRRO1G
   uKUsR9rNSulvquqcMcptIkrLmRwWeYjBn4RoG1f3UGvLIWxikNJr1ZaWt
   Z7hORNo08F9PL5lyhoJ0t3Awxlfq2a/2Mx2oesxuicM7w6DXD2Fhb1SMi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="436190011"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="436190011"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 07:50:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="733871311"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="733871311"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 15 Aug 2023 07:50:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVvNM-005yQP-1j;
        Tue, 15 Aug 2023 17:50:28 +0300
Date:   Tue, 15 Aug 2023 17:50:28 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: vz89x: Convert enum->pointer for data in
 the match tables
Message-ID: <ZNuQtIMqbK/74kvI@smile.fi.intel.com>
References: <20230812172718.232718-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812172718.232718-1-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 12, 2023 at 06:27:18PM +0100, Biju Das wrote:
> Convert enum->pointer for data in the match tables, so that
> device_get_match_data() can do match against OF/ACPI/I2C tables, once i2c
> bus type match support added to it.
> 
> Replace enum->struct *vz89x_chip_data for data in the match table. Simplify
> the probe() by replacing device_get_match_data() and ID lookup for
> retrieving data by i2c_get_match_data().

> While at it, drop unused variables id and chip_id from probe().

So, I'm not going to repeat, you have to fix this in all commit messages like
this.

Otherwise,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


