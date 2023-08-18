Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2AB780E5F
	for <lists+linux-iio@lfdr.de>; Fri, 18 Aug 2023 16:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377909AbjHROzs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Aug 2023 10:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377885AbjHROzW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Aug 2023 10:55:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A56CD;
        Fri, 18 Aug 2023 07:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692370521; x=1723906521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SSWK8vSsrhVvA90RydFX4rb3pSBPwKMVlvJ9bXY5/Xc=;
  b=O69mtDeS65+U37ausSsAnOkVUuj0FpUzB5My73p9LEfifWVlgocyE5ee
   b2PxzsWxGlb0xqMo5ovU3rF+wXOP9U6ZoMslD3Kw1dED1aS0Zn36hPfkX
   nh+lup1j/rbCYOalKngbqHDLwpHFniSfmZFXjGgr2ePQ49TXU9L5jTIg8
   U+vGBJj9GriFJL8fuiZ0Z4KIuiFGCIkrBOt9ICj0jjvRJBYKCf4O/2VY3
   eajxOACa+6NsoHiRcSEoQfSPNM1/B7iGop1zHDeDj/qzV2Q+7qEj3FHkk
   b9joTNRHKxrQ7KfcU1Oaj4649qMx3LmoL2al6AeBf0HoxhVbLZSpK8xGW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="353421829"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="353421829"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 07:55:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="981680819"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="981680819"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 18 Aug 2023 07:55:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qX0sR-00CkCr-21;
        Fri, 18 Aug 2023 17:55:03 +0300
Date:   Fri, 18 Aug 2023 17:55:03 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: max1363: Use i2c_get_match_data()
Message-ID: <ZN+GR5+NdUqtnM93@smile.fi.intel.com>
References: <20230812072419.42645-1-biju.das.jz@bp.renesas.com>
 <ZNslJ44ivDGKR6b1@smile.fi.intel.com>
 <OS0PR01MB59223B11C14FE29FEE9CF080861BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS0PR01MB59223B11C14FE29FEE9CF080861BA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
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

On Fri, Aug 18, 2023 at 02:48:45PM +0000, Biju Das wrote:
> > On Sat, Aug 12, 2023 at 08:24:19AM +0100, Biju Das wrote:

...

> > > +#define MAX1363_ID_TABLE(_name, cfg) {				\
> > > +	.name = _name,						\
> > > +	.driver_data = (kernel_ulong_t)&max1363_chip_info_tbl[cfg],	\
> > > +}
> > 
> > Just use them directly, like in 4 lines each instead of a single one.
> > 
> > 	{
> > 		.name = max1361,
> > 		.driver_data = (kernel_ulong_t)&max1363_chip_info_tbl[max1361]
> > 	},
> > 
> > or this, but it's almost 100 characters.
> 
> OK, will create a separate patch for this change.
> 
> Worst case, we can drop named fields?? (.name and .driver_data)

I wouldn't do that as the goal in kernel is to use C99 initialized more
and not less.

-- 
With Best Regards,
Andy Shevchenko


