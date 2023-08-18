Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E2A780B16
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 13:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376645AbjHRL0u (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 07:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376704AbjHRL0k (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 07:26:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB5A3ABB;
        Fri, 18 Aug 2023 04:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692357999; x=1723893999;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8aylAJ9eb1SSdLqGagCLBUMuY4LBqeyA68ALlf1iudM=;
  b=W4Rtx/cjF927j8POdRr/2fuRynGbYaMGJYlCA+rEo5rnl1VmeCp/X4Pr
   uKz2tsX5v7RjxNu26Cg0PPptj9dC/P29ZY5L7cXdwD/5/18QxwadLWxvM
   P3mrJU71qTsKWfTMc+DD15LpR4tPMM39l2qioVReGtRdDJMLBVux0Qg75
   SXcXLCw8hxOPJPv8DtbZy3+dpuJ9uvMyDfTMfNunoSOYJrNg42xKRLiEe
   J++l3IFCoQIrfeNzpMXOh4VTKSX/6e/L7hiB3K5ZYbTprA1Gv0icrJFDE
   spoQdbJl9wkHODuukebTrVwbjSmdGNQMl9LfD+h+k/QfF/wiZrcZA82tU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="376839999"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="376839999"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 04:26:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="728580156"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="728580156"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 18 Aug 2023 04:26:36 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWxcg-005gp2-0f;
        Fri, 18 Aug 2023 14:26:34 +0300
Date:   Fri, 18 Aug 2023 14:26:33 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 1/5] iio: magnetometer: ak8975: Convert enum->pointer
 for data in the match tables
Message-ID: <ZN9VaeuYln7Lp8ht@smile.fi.intel.com>
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
 <20230818075600.24277-2-biju.das.jz@bp.renesas.com>
 <ZN9VLNdIe4PE/CSR@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN9VLNdIe4PE/CSR@smile.fi.intel.com>
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

On Fri, Aug 18, 2023 at 02:25:32PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 18, 2023 at 08:55:56AM +0100, Biju Das wrote:

...

> So, why have you ignored my comments against v1?

Ah, I see now, it has not been ignored, sorry, the implementation in the
following patches...

-- 
With Best Regards,
Andy Shevchenko


