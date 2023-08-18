Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6ABF780B27
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 13:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376669AbjHRLak (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 07:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376780AbjHRLag (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 07:30:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773ADE5F;
        Fri, 18 Aug 2023 04:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692358235; x=1723894235;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PrONJLhgrjbzdGO9sKwMcgZsolw++83bRtJ2eXr0XKU=;
  b=L4c0xMOPdQTO/MvMasyg0N3J+Q8NG2pGijcx2clbPL51Z6jSa94SLnf+
   ptRr6/zb0+cghDU8kq5LNCGlGWZ6os5yd4KVETC3IRqpV3jOJqk84WEaI
   EqIFUbBGEq0XY2A8bbPkJy530eu8LAHi4YrvsQTWdNjdQsi13Wm6dTktG
   dAgexxLZ2Cf9mOVUliP1+bKkuwOQkU3zd5G21Fanvi/lrtSlphOBhM4aZ
   q8R8kVuI6X9P4qbCH0K+3fJhSptdoy28JuiP/VWkBeVPEPaHxa8RfJsRG
   RPQYvOcY9qPU6hlRxNKo1ZFQNV2sgHaWgv5felZlVJc0IcUcsplPnqY3c
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="352670153"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="352670153"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 04:30:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="770112047"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="770112047"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 18 Aug 2023 04:30:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWxgU-005pOX-2V;
        Fri, 18 Aug 2023 14:30:30 +0300
Date:   Fri, 18 Aug 2023 14:30:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: magnetometer: ak8975: Sort OF table
Message-ID: <ZN9WVvo+pixspCsw@smile.fi.intel.com>
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
 <20230818075600.24277-6-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818075600.24277-6-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Aug 18, 2023 at 08:56:00AM +0100, Biju Das wrote:
> Sort OF table alphabetically by compatibles.

> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Wrong, I haven't suggested that. See comment to the previous patch.

And this is definitely wrong as Geert explained already why.
You need to fix the code that handles the ID table first.

-- 
With Best Regards,
Andy Shevchenko


