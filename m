Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669064E3BEE
	for <lists+linux-iio@lfdr.de>; Tue, 22 Mar 2022 10:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiCVJvr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Mar 2022 05:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbiCVJvq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2022 05:51:46 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120401AF05
        for <linux-iio@vger.kernel.org>; Tue, 22 Mar 2022 02:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647942619; x=1679478619;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0Jc0ThQnjoPmQsBxzwdNTyvjHsL0XX4h7vq5KKQzaKs=;
  b=TaJnnqS5SVHBoiOsIGCEbWcBKuX3aVY1b3/qDWO6Pnj2OCAxW0gElR8E
   eGfsnCyLKxrcKmnEE9EYAWvWQAh4ctYH2LkMHjfzvOQQT5jL7kEuKEp2p
   n/1wr4bxEItczft+oB4hj9ipUusyqlCRnBwG0FV9brexJ4p48q4wVIg37
   pFgsKL11QBbUWlDTt9ciLUuYphIyNWPUHHd6CAJ2VyY3AHE8V1DbagssM
   d5mkUCaVMATut9gz3eUZFnJgw5Tjc4Qv1FrE4ch6e6uGVL3z5xD3u63Kt
   gHOZp5e5BcXm1OWRRSF9/YEXJbYUtldDStqmeILwfUFtCxobseBT2yWK+
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="282609849"
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="282609849"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 02:50:17 -0700
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="500513121"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 02:50:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nWb90-004UNC-Ry;
        Tue, 22 Mar 2022 11:49:38 +0200
Date:   Tue, 22 Mar 2022 11:49:38 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc:     Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: core: WARN in case sample bits do not fit storage
 bits
Message-ID: <YjmbstSwzbu5ZdBg@smile.fi.intel.com>
References: <20220320181542.168147-1-marex@denx.de>
 <YjhWIN6GsuhPskrs@smile.fi.intel.com>
 <8b6f00be-c520-45c3-4497-d0fc310ff52f@denx.de>
 <Yjijg7m+TnaMs519@smile.fi.intel.com>
 <30a13541-0ffb-a537-e943-3751b7fd316b@denx.de>
 <bd7f7b9853cbea30740af14d29a46f1a9f93a2a7.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd7f7b9853cbea30740af14d29a46f1a9f93a2a7.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 22, 2022 at 08:43:10AM +0100, Nuno Sá wrote:
> On Mon, 2022-03-21 at 20:46 +0100, Marek Vasut wrote:
> > On 3/21/22 17:10, Andy Shevchenko wrote:
> > > On Mon, Mar 21, 2022 at 03:46:51PM +0100, Marek Vasut wrote:
> > > > On 3/21/22 11:40, Andy Shevchenko wrote:
> > > > > On Sun, Mar 20, 2022 at 07:15:42PM +0100, Marek Vasut wrote:
> > > > > > Add runtime check to verify whether storagebits are at least
> > > > > > as big
> > > > > > as shifted realbits. This should help spot broken drivers
> > > > > > which may
> > > > > > set realbits + shift above storagebits.
> > > > > 
> > > > > Thanks!
> > > > > 
> > > > > ...
> > > > > 
> > > > > > +                       /* Verify that sample bits fit into
> > > > > > storage */
> > > > > > +                       WARN_ON(channels[i].scan_type.storage
> > > > > > bits <
> > > > > > +                               channels[i].scan_type.realbit
> > > > > > s +
> > > > > > +                               channels[i].scan_type.shift);
> > > > > 
> > > > > Not sure WARN is a good level (it might be fatal on some setups
> > > > > and we won't that),
> > > > > besides the fact that we may use dev_WARN(). Perhaps dev_warn()
> > > > > would suffice?
> > > > 
> > > > I was actually thinking about BUG(), but that might crash
> > > > existing systems.
> > > > I think we want a strong indicator that something wrong is going
> > > > on which
> > > > must be fixed and the splat produced by WARN_ON() is a good
> > > > indicator of
> > > > that. It also does not crash existing systems,
> > > 
> > > It does crash _some_ of them, unfortunately.
> > 
> > Details please ?
> > 
> > WARN_ON() shouldn't cause crash outright, or do I miss something ?
> 
> Arghh, completely forgot about this... Andy is right, maybe there are
> other cases (in which case, it would be nice to share :D), but this one
> is definitely one of them:
> 
> https://elixir.bootlin.com/linux/latest/source/kernel/panic.c#L579
> 
> You can have a cmdline parameter to panic on _WARN() and some systems
> may have it.

Yes, I meant panic on warning.

And I can't imagine that this driver can be system critical to the extent
that we have to crash the system.

> That said, the "nice" stack_dump using WARN is way more explicit about
> saying that something is seriously wrong and must be fixed. dev_warn()
> is easier to ignore... But surely it is not nice to brick existing
> systems.  
> 
> Not really sure here...

-- 
With Best Regards,
Andy Shevchenko


