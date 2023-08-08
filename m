Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8B4773F60
	for <lists+linux-iio@lfdr.de>; Tue,  8 Aug 2023 18:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbjHHQqU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Aug 2023 12:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbjHHQpY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Aug 2023 12:45:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A39B44454;
        Tue,  8 Aug 2023 08:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691510182; x=1723046182;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n3aj6xVdycgio2ipgHBrYjt9IawzFOYxekYmT8ZR1lo=;
  b=JoknEg9FMgnmIKQD2SrDTnuwR3VV0MdQ9rb3mev6MkSyJtwdPVujzsZL
   DRRNcha6SJRv6I2hCUqE4gqoZPZgTC5UspUBl/8uQnGiovFAmeO5syAAs
   P1k58z2HMaXzo41Qh1LLvJscGhQXdMgENRnFXiVgLOV2lLdPVCavN9Vlk
   63BVQsoqb3jNw4OEas0Qq++aOmpwKYLEL9DKjiosfn08LYqz/5D9ZbnyI
   GWm0EoWlwTHnZHiUj+pMfSIQBCUDDW36STlHD7QI845COuxkfD5NwdggY
   T/jnzupFL3pC5SdR+lZxllizxulBqM7XZXayXoPEq9xBjV6y4nRVU4LZN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="437146979"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="437146979"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 06:04:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="708243673"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="708243673"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 08 Aug 2023 06:04:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qTMNv-008whr-24;
        Tue, 08 Aug 2023 16:04:27 +0300
Date:   Tue, 8 Aug 2023 16:04:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, Peter Rosin <peda@axentia.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andi Shyti <andi.shyti@kernel.org>,
        Jakob Hauser <jahau@rocketmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: magnetometer: yamaha-yas530: Use
 i2c_get_match_data()
Message-ID: <ZNI9WyNM7CZlw/ik@smile.fi.intel.com>
References: <20230807172548.258247-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807172548.258247-1-biju.das.jz@bp.renesas.com>
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

On Mon, Aug 07, 2023 at 06:25:47PM +0100, Biju Das wrote:
> Simplify the probe() by replacing device_get_match_data() with
> i2c_get_match_data().

> While at it, drop unnecessary enum chip_ids by splitting the array
> yas5xx_chip_info_tbl[] as individual variables.

This should be in a separate change.
Personally I see no point in doing this.

-- 
With Best Regards,
Andy Shevchenko


