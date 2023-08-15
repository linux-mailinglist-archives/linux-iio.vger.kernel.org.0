Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E87277CE75
	for <lists+linux-iio@lfdr.de>; Tue, 15 Aug 2023 16:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237654AbjHOOvT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Aug 2023 10:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237798AbjHOOvQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Aug 2023 10:51:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABDEC5;
        Tue, 15 Aug 2023 07:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692111076; x=1723647076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SlxIG1t1zHiuAHK0lG/tm8QB6Kl2oFgoK6M33JtZt2Y=;
  b=SMpTSycJ9Lbh+WHVduDNNdkqx5dYDIAYxCUnOZP5qGnGmPBOjjF3pb/s
   /o42l4je3BhH1eBsEirvM1h+gLGjoenzGKhIEbwWsSn8PibmdJBZVOISM
   CAsuQ6Mg2owU1WFKkGPiUI58ku51JGK+ukr48j2WYSd6ntpBj53nzc2jY
   XxirUy9NTPeJ0DM2VQALijuI+07ygvboNiPEZiYmD/y/dpjV2tr+7ShF3
   YZCEczFaSg5kvaZx0n+Dc7wddUxNEubsQ+xVIw28nr+WV2e5zzw54Xqjy
   Ikv+2++PWK9c0vcODK04GjNgUiYl32niaLe0b6oJQDq6AD8aoU4eV8SmT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="372289353"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="372289353"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 07:51:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="907627336"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="907627336"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 15 Aug 2023 07:51:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVvO2-005zyI-2k;
        Tue, 15 Aug 2023 17:51:10 +0300
Date:   Tue, 15 Aug 2023 17:51:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: ms5637: Use i2c_get_match_data()
Message-ID: <ZNuQ3s6u4ycNNIUf@smile.fi.intel.com>
References: <20230812180700.246314-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812180700.246314-1-biju.das.jz@bp.renesas.com>
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

On Sat, Aug 12, 2023 at 07:07:00PM +0100, Biju Das wrote:
> Replace device_get_match_data() and id lookup for retrieving match data
> by i2c_get_match_data().
> 
> While at it, drop ununsed variable id from probe().

With commit message fixed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


