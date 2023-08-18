Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA73780E89
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 17:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377940AbjHRPCt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 11:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377967AbjHRPC1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 11:02:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B704208;
        Fri, 18 Aug 2023 08:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692370944; x=1723906944;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4kg3YLMTq4NIJG6aPg8QwWavjOLHO3JetKCUu1y86QY=;
  b=VF3UnL7LjJD/FFb3ZaUeD4n9Dc7Z3sFjU9MIXDp5s5icW22hBhbx1OiH
   uR5Y45sT+6lEAWJvFV6232gKXXZ1QMFN3xEg8MpiCzRBpDb3MuU+A3Bli
   HmhpPE4jZfdGp1zwLzf/A5tSeDs6MHdbPhpHeIKu/k9KtNkazB4lYCj1h
   jIsElnJh555xH8HCVwHpHQN3j9xSMo1YhfuQPFoJuJ07758DHkUi6GrL7
   f51dFIXqb1BpNch3jHOAQMCVl4D/GbBMA9OOZsjEzK4zVUjwVGM5OG6LA
   EoeBlHiH/P1NCU5ofSlLsrDiuqruPMvle11IIHGN+TODT7NPdzIID9pkY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="437028355"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="437028355"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 08:01:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="908909465"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="908909465"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 18 Aug 2023 08:01:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qX0yw-00CyBb-30;
        Fri, 18 Aug 2023 18:01:46 +0300
Date:   Fri, 18 Aug 2023 18:01:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] iio: magnetometer: ak8975: Sort OF table
Message-ID: <ZN+H2qiRxMh/x2In@smile.fi.intel.com>
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
 <20230818075600.24277-6-biju.das.jz@bp.renesas.com>
 <ZN9WVvo+pixspCsw@smile.fi.intel.com>
 <OS0PR01MB5922F95816931D3392CDAB8A861BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922F95816931D3392CDAB8A861BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
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

On Fri, Aug 18, 2023 at 11:39:03AM +0000, Biju Das wrote:
> > On Fri, Aug 18, 2023 at 08:56:00AM +0100, Biju Das wrote:
> > > Sort OF table alphabetically by compatibles.
> > 
> > > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Wrong, I haven't suggested that. See comment to the previous patch.
> > 
> > And this is definitely wrong as Geert explained already why.
> > You need to fix the code that handles the ID table first.
> 
> That rule applicable only for fallback. I checked bindings and there are no fallbacks.

You can't check the _whole_ world, so you checked only bindings that are in tree.
But it doesn't matter as a user somewhere may use something you have no access to.

-- 
With Best Regards,
Andy Shevchenko


