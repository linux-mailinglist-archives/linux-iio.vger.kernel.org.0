Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2795B54F49D
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jun 2022 11:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378259AbiFQJv0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jun 2022 05:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235905AbiFQJv0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jun 2022 05:51:26 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FBD6833A
        for <linux-iio@vger.kernel.org>; Fri, 17 Jun 2022 02:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655459485; x=1686995485;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k5CpSpIOuVHGlswE4Ld/X9EEQ1FEloxbehwfJWt5tMU=;
  b=fRl63yl9liAtd0b/tNHvlHsyLTRdnXWG0fIlxYwv+JOG3wkSBtJqprPZ
   2A0++QwiK81AzutTwR6RM/2u3B5ZacXDkCgEolIxe0Bv7zyyJk6fNjBxu
   4LkYogebWkV0UQCHZukdQM/OItkRv0evN2xXV8k5dVPMHk/GbSPRJHkII
   isWN5pmmOixuS2ufektZyvGx0fDO+L1paTYd/U0zeQ1AMAMMnsXXS636y
   mBWjVe2uvdX9TC0rFKrLZ/jhNhgf9op1topbikrsc4xVOaTA4hEpTXNdr
   ZG9aDkYJVjixFegvbY/0/qf9m1HxCjeoeHbUESZOhsTXXbL8N9KwW14a0
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="277042956"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="277042956"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 02:51:25 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="675432889"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 02:51:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1o28dM-000exB-4a;
        Fri, 17 Jun 2022 12:51:20 +0300
Date:   Fri, 17 Jun 2022 12:51:19 +0300
From:   "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     "N, Pandith" <pandith.n@intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "vilhelm.gray@gmail.com" <vilhelm.gray@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hall, Christopher S" <christopher.s.hall@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>,
        "T R, Thejesh Reddy" <thejesh.reddy.t.r@intel.com>
Subject: Re: Intel Timed-IO driver in IIO/Counter subsystem
Message-ID: <YqxOl8W2yzp9CcBP@smile.fi.intel.com>
References: <BYAPR11MB3240148739EBB945211DD77BE1AF9@BYAPR11MB3240.namprd11.prod.outlook.com>
 <44170bf8-5777-e30b-b74d-a6835b1937e2@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44170bf8-5777-e30b-b74d-a6835b1937e2@metafoo.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jun 17, 2022 at 09:22:09AM +0200, Lars-Peter Clausen wrote:
> On 6/17/22 08:37, N, Pandith wrote:
> > Hi,
> > 
> > We have a Intel Timed IO peripheral with following functionalities :
> > 
> > 1. Event capture capability - Captures event count and timestamp.
> > 2. Pulse generation - periodic or single event generation.
> > 3. Return cross-timestamp on request.
> > 
> > Timed IO device is being used in various Industrial use cases such as : time capture, synchronization, fan speed calculation etc.
> > 
> > IIO or counter subsystem seems to be suitable for timed-io driver.
> > 
> > Is it favourable to implement as part of IIO or counter subsystem ? Wanted to know your feedback.
> 
> That sounds like a mix of a counter and PPS device. Have you looked at the
> PPS subsystem[1]?

The newly HTE subsystem was proposed by Linus W. to be used for this case.

> [1] https://www.kernel.org/doc/html/latest/driver-api/pps.html

-- 
With Best Regards,
Andy Shevchenko


