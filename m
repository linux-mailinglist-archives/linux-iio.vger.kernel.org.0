Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0DD4D671C
	for <lists+linux-iio@lfdr.de>; Fri, 11 Mar 2022 18:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbiCKRFg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Mar 2022 12:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiCKRFf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Mar 2022 12:05:35 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1DC1D638D
        for <linux-iio@vger.kernel.org>; Fri, 11 Mar 2022 09:04:32 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="316332282"
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="316332282"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 09:04:10 -0800
X-IronPort-AV: E=Sophos;i="5.90,174,1643702400"; 
   d="scan'208";a="511438489"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 09:04:09 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1nSifn-00FTY7-6O;
        Fri, 11 Mar 2022 19:03:27 +0200
Date:   Fri, 11 Mar 2022 19:03:26 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 4/6] iio: adc: ti-ads1015: Deduplicate channel macros
Message-ID: <YiuA3jvbpkSQfuFM@smile.fi.intel.com>
References: <20220310003402.490478-1-marex@denx.de>
 <20220310003402.490478-4-marex@denx.de>
 <YioKZ6EZvYHOOFMe@smile.fi.intel.com>
 <082e1654-74b7-aed2-4915-f8dd304540d6@denx.de>
 <CAHp75VfDv5CE0cDSBDeMeWj4ub1JV9o-jPpqhLvwnmmN+=WJ0Q@mail.gmail.com>
 <1504edf0-5773-781a-1a4f-056f57dfbf15@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504edf0-5773-781a-1a4f-056f57dfbf15@denx.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 11, 2022 at 12:33:49PM +0100, Marek Vasut wrote:
> On 3/11/22 12:29, Andy Shevchenko wrote:
> > On Fri, Mar 11, 2022 at 1:55 AM Marek Vasut <marex@denx.de> wrote:
> > > On 3/10/22 15:25, Andy Shevchenko wrote:
> > > > On Thu, Mar 10, 2022 at 01:34:00AM +0100, Marek Vasut wrote:

...

> > > > > -            .realbits = 12,                                 \
> > > > > +            .realbits = (_realbits),                        \
> > > > >               .storagebits = 16,                              \
> > > > 
> > > > This seems inconsistent a bit. What if the next chip wants to have more than
> > > > 16 bits in realbits?
> > > 
> > > When such a chip exists, this can be parametrized as well.
> > 
> > Yes, My point is that it's error prone.
> 
> Won't IIO core warn if realbits > storagebits ?

If it's the case, then it's very good!

...

> > > > I see two options:
> > > > 1) add static assert to make sure realbits <= storagebits;
> > > 
> > > Does static_assert work in array of structures (I don't think it does) ?
> > 
> > You can check, but IIRC some of the macros have it. Don't remember the
> > details, though.
> 
> I already checked before replying, hence my question, as I didn't find a way
> to make it work.

It seems that current use cases have it either in functions or in
the expressions as ({...}). I dunno if the result of ({...}) can be
a data structure or compound literal.

-- 
With Best Regards,
Andy Shevchenko


