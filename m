Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFA77CF3DE
	for <lists+linux-iio@lfdr.de>; Thu, 19 Oct 2023 11:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjJSJSR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Oct 2023 05:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJSJSQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Oct 2023 05:18:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F34B8;
        Thu, 19 Oct 2023 02:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697707095; x=1729243095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5i9OR/guoAxNwK42kvV+t2qtEL/5y/se/ZqcB4/kj8Q=;
  b=KcVwbAaknAXXkdJa9I5DDI3SI5gp7a+9v/fIC5m5EpmAua6rqSxqFspI
   2tj3QN3v5PnuSt5AYMNopyXgribg+61G2cStbC9NOaTyq7QUeZnG9viFc
   X5SEpLw3Sc1fO9EhxRiC6T3RTIo1tTDvB/aoyjrq0qS0LsFucU/tyY9ti
   hyLvCFpQQCMlrvuM4Sf9L77oIMnW5+a+SAYQAUcxB7I4dGJMQH1gL7Y7r
   LbwPTbZV3GbNrIYLo55TVbXKpPnFIdn85N+n+9YpBxEKqK5dg93yepa+e
   Cq3dx0Oqq5eAeZAf4P1tzz+0pv3bHc0FbHxZ3whvToygkJX4j6+nDVSLE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="383431453"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="383431453"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 02:18:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="880569518"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="880569518"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 02:18:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qtPAP-00000006ovM-0WHd;
        Thu, 19 Oct 2023 12:18:09 +0300
Date:   Thu, 19 Oct 2023 12:18:08 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     =?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>,
        Jonathan Cameron <jic23@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] iio: magnetometer: ak8975: Convert enum->pointer
 for data in the match tables
Message-ID: <ZTD0UN4+wQjguCDF@smile.fi.intel.com>
References: <20230818075600.24277-1-biju.das.jz@bp.renesas.com>
 <20230818075600.24277-2-biju.das.jz@bp.renesas.com>
 <5e0d2716fb757d408ebe77cb132ae242ef3aa470.camel@apitzsch.eu>
 <CAMuHMdUTxQym7+vYPtnvMQeH8GKSk0iOyuMnLkgr3LH1E8TTYA@mail.gmail.com>
 <20231018204533.39399b0b@jic23-huawei>
 <82b99e17f45b09623eeaed12e4fac12609c15426.camel@apitzsch.eu>
 <TYCPR01MB11269EEF17ABCE541CC7B38CE86D4A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <TYCPR01MB11269D21D7DD5356A64E5679586D4A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCPR01MB11269D21D7DD5356A64E5679586D4A@TYCPR01MB11269.jpnprd01.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Oct 19, 2023 at 07:08:23AM +0000, Biju Das wrote:
> > Subject: RE: [PATCH v2 1/5] iio: magnetometer: ak8975: Convert enum-

...

> > As mentioned in the patch.
> > /* If enumerated via firmware node, fix the ABI */
> > 
> > Looks like this issue is not introduced by this patch.
> > The previous code uses device_get_match_data() which returns a match as it
> > uses DT node and it uses dev_name(&client->dev) instead of id->name;
> > 
> > Am I missing anything here? If it is just a test program, can it be fixed??
> > 
> > Please correct me if I am wrong.
> 
> I just realized that there is no .data in previous code for OF tables.
> 
> Maybe we should add a check, if it is DT node, return id->name?
> 
> Is there any API to distinguish DT node from ACPI??

Of course, but I discourage people to use that, you have to have a very good
justification why you need it (and this case doesn't sound good enough to me,
or please elaborate). Hence I leave it as a homework to find those APIs.

-- 
With Best Regards,
Andy Shevchenko


