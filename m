Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C542377CE67
	for <lists+linux-iio@lfdr.de>; Tue, 15 Aug 2023 16:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237664AbjHOOsD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Aug 2023 10:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237762AbjHOOrj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Aug 2023 10:47:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186C393;
        Tue, 15 Aug 2023 07:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692110859; x=1723646859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f2YLNE377Fbd2/MGrL2lmyYkOz1OrMdtTQPS/IgUwbA=;
  b=Fjr00D1tpq9YSVK3vYna5OeEmblVC2FPqcJeduzCtotF2Xx0pCr++8VV
   NOZWlU+lZmob2oNTWARiOqOkNBsG9GJ4k8Khjd6ohqmrhwJwrz7ftinA+
   ETui2ASo9rm5YNHPMWCmivRSe7F4OeZgMJ3l5coTAvO5xcbcvZcVyv3if
   FklDqU3sFO5hEyx1tAM0p8JHzJs60r9AOzX+c2w0GPxK7mYR/A8jw33be
   snd4FYyUqHNdgpuel/FCopr6E2BeMgYe2ECU3m291cHOZ7645mSQxCqmh
   WVuDMDpHuCTa9n5U2m0J8rIGamY5TbHEH40q6JN/XlqxzqrvDGdammcq2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357259293"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="357259293"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 07:47:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="848084106"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="848084106"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 15 Aug 2023 07:47:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVvKY-005s5Z-09;
        Tue, 15 Aug 2023 17:47:34 +0300
Date:   Tue, 15 Aug 2023 17:47:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: atlas-ezo-sensor: Simplify probe()
Message-ID: <ZNuQBXtiuiRIsI8T@smile.fi.intel.com>
References: <20230812163425.206044-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812163425.206044-1-biju.das.jz@bp.renesas.com>
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

On Sat, Aug 12, 2023 at 05:34:25PM +0100, Biju Das wrote:
> Simplify the probe() by replacing device_get_match_data() and ID lookup
> match by i2c_get_match_data() as we have similar I2C and DT-based matching
> table.

> While at it, drop id variable from probe() as it is unused.

As somebody noticed, this "while at it" part is misleading.
It's integral part of the change.

With that fixed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


