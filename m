Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149A777C81F
	for <lists+linux-iio@lfdr.de>; Tue, 15 Aug 2023 08:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbjHOGuY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Aug 2023 02:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbjHOGuE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Aug 2023 02:50:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA96E72;
        Mon, 14 Aug 2023 23:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692082202; x=1723618202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nugSoOMVhXKAgZNoYsdlfrm/JS7i7WhX4hszrHVtbPc=;
  b=bPmIVIecPT6wO+ARErIt4iRo05zWBPlp4icIFEeKKrFGiJJr5iOs4Q9o
   Ip1FDORZ7S2kzyecIt1eyQFcXQBd8uhtRa8RDPhtySwLUXeJ6LZLRrBBb
   1lOiDA+RW0YDoVxQSkAwsJR9kPCJatC4rQ8HsNp6oiWNipQW5liM70joz
   yPdcz5bnKoIokfLFQxH4EtdzZUNnFqjObr0QakNolsQtfamblMtp913Yl
   wZKyciAKIi0kH+8HApPZgiSIZt+nrnS86P6QKTVyFCHCH/DMdFpNUnTLH
   GoWKrNaG0bkBX9bGskXx2u0c+LH0vIZQnYMTHk0x9x3G5WwseM+MouDuq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="436111532"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="436111532"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 23:50:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="1064357666"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="1064357666"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 14 Aug 2023 23:49:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVnsK-0074vv-2f;
        Tue, 15 Aug 2023 09:49:56 +0300
Date:   Tue, 15 Aug 2023 09:49:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: magnetometer: yamaha-yas530: Drop enum
 chip_ids
Message-ID: <ZNsgFG2aL78IKbYq@smile.fi.intel.com>
References: <20230812065741.20990-1-biju.das.jz@bp.renesas.com>
 <20230812065741.20990-3-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812065741.20990-3-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Aug 12, 2023 at 07:57:41AM +0100, Biju Das wrote:
> Drop the unnecessary enum chip_ids by splitting the array
> yas5xx_chip_info_tbl[] as individual variables.

In my opinion this is an unneeded churn.
I leave this to Jonathan to decide.

-- 
With Best Regards,
Andy Shevchenko


