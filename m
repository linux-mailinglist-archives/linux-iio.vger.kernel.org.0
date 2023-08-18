Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE496780E8B
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 17:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244236AbjHRPDV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 11:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378010AbjHRPDJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 11:03:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E43421F;
        Fri, 18 Aug 2023 08:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692370983; x=1723906983;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ss2Z7zgfUBBvbH5A/gD0Pb240y4NZAR4L3A157sLIX0=;
  b=FtY32EtAbxGbCDuvspdP+6M2TcRccu71H8VOxifIXxmpWwmvU95y+X5U
   49G524rGQl0G14h0wVrS2Pf2TNKn+FsIlPur8ApRw5jpOZ4R7eMj+Bz4Q
   P3RpzFdslnHsJSdAcVlHkwVIgmPx0YtnZIlBVQXJkGclmf8iMicrG3DKo
   URBwNykQZ3ienVhO870mWBMKjvETyhhuA0BSiMIg6LTaY2QolgH7DD0i9
   NCBguDmUUoOklRKP4u1NCEZZIRRR2XeFcutul543TnJmjzL4w0Ly36oKx
   cwbc8ZO1Fbvx/lLoP4JiIrOPt6vjwYrTuRtMbMt3RWeIGkg1lgfi6YJnV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="404100524"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="404100524"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 08:02:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="764584031"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="764584031"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 18 Aug 2023 08:02:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qX0zk-00Czxc-1b;
        Fri, 18 Aug 2023 18:02:36 +0300
Date:   Fri, 18 Aug 2023 18:02:36 +0300
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
Subject: Re: [PATCH v2 4/5] iio: magnetometer: ak8975: Drop deprecated enums
 from OF table
Message-ID: <ZN+IDGfc0MJfqOV9@smile.fi.intel.com>
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
 <20230818075600.24277-5-biju.das.jz@bp.renesas.com>
 <ZN9WCKQ/hv4zKfsK@smile.fi.intel.com>
 <OS0PR01MB5922F93ABF408AA9037A8EAC861BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922F93ABF408AA9037A8EAC861BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Aug 18, 2023 at 11:40:37AM +0000, Biju Das wrote:
> Hi Andy Shevchenko,
> 
> > Subject: Re: [PATCH v2 4/5] iio: magnetometer: ak8975: Drop deprecated
> > enums from OF table
> > 
> > On Fri, Aug 18, 2023 at 08:55:59AM +0100, Biju Das wrote:
> > > Drop deprecated enums from OF table as corresponding entries are
> > > removed from bindings and it also saves memory.
> > 
> > You can't do this.
> > 
> > Only sorting by "prefixed first" criteria is possible.
> 
> The rule applies only for fallback compatible. I checked bindings and I don't
> find any fallback compatibles. All compatibles are just enums. Am I missing
> anything here??

Yes. As per above patch. The _whole_ world is not under your / our control.
NAK to this change, sorry.

-- 
With Best Regards,
Andy Shevchenko


