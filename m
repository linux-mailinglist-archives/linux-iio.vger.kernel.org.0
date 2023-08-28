Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BB378B127
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 14:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjH1M4n (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 08:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjH1M4O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 08:56:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E33C3;
        Mon, 28 Aug 2023 05:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693227372; x=1724763372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vv6HncaZEIkidVNHs/w/oDTC2lXu+yxON6G+UR6Vi6k=;
  b=lV9wz4C8AO+8bNrS3KccAv4yWgFyrtU3HGwAQNL/nVGRjwMe120DC8tM
   mlEXgqutRS/Ryl4d1QTy6MLek1PpkCXVhBKr+ygYADOcK3r8OM5kT8rvh
   bREsi714305CwiBKQD91L98hec6RDCn+HQbiCiSt81EYp7PqELpF4eOov
   fmIbBXU+IIyAvCEuU0DyAOTzXzYeRu5w6HI5EO2paMOAC5ZkrRaHiu1AZ
   1+S9MDJaDkuauFM6KCnbwO/6JvwnRaV9TRgWcc01zDKqpFjWD1bnZtI81
   OxTjgcGtfzAsT9e90YmkmNE+An/FQYpFlGm4ps08WmixfCclfaPqmB9qb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="377821489"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="377821489"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 05:56:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="881927692"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP; 28 Aug 2023 05:56:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qabmo-001QLi-3C;
        Mon, 28 Aug 2023 15:56:06 +0300
Date:   Mon, 28 Aug 2023 15:56:06 +0300
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
        <linux-renesas-soc@vger.kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: Re: [PATCH v2] iio: chemical: vz89x: Convert enum->pointer for data
 in the match tables
Message-ID: <ZOyZZplqAIrDMEPN@smile.fi.intel.com>
References: <20230818190429.338065-1-biju.das.jz@bp.renesas.com>
 <20230828133525.5afaea4f@jic23-huawei>
 <OS0PR01MB59225F5472B4BE500429394C86E0A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS0PR01MB59225F5472B4BE500429394C86E0A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Aug 28, 2023 at 12:43:51PM +0000, Biju Das wrote:
> > On Fri, 18 Aug 2023 20:04:29 +0100
> > Biju Das <biju.das.jz@bp.renesas.com> wrote:

> > Make sure you cc the driver authors etc.
> 
> Normally, I ran a script against the patch to get details and additionally I
> add Geert, renesas-soc , Andy in Cc list.

I use [1] for the submissions and seems in 99.9% it works just as expected.
Can you compare the difference in the heuristics?

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

-- 
With Best Regards,
Andy Shevchenko


