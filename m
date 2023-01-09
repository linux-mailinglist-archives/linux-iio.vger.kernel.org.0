Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B6066245B
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jan 2023 12:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbjAILjG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Jan 2023 06:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbjAILiw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jan 2023 06:38:52 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D484399
        for <linux-iio@vger.kernel.org>; Mon,  9 Jan 2023 03:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673264332; x=1704800332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jYOU7Wxoz99M6sPPOw0NfO1v9pqHg7er2jQ5vPwGTw8=;
  b=Cdz11F2DbiRGnOSoNTWjP02I6w+GzvJ1YlzLPNT99E5oWRJUjJ9DXtoh
   /mMNtdywUJnj1tP/If/VCcX/hFUJb+DR+4ElzbLLCpHVNpiS65PmPbec0
   CGFEoK0FAyiIwwyMsXcKCfwiuXAl3X6SdmGZRMs1zYNrsTxOVkXTol3Ld
   6LipZ3AzUd7IDLdQoYlO8fCTOJPeEbslD00PvkpD5p0rE/OXw5LTpBMpm
   12W2Nfp8B0VokkG4v5zRe/4/euZOXkjtWbJBxlW7ZFkr6x3j3weaTWVJt
   p1CeCZTTFEfqqJ7mIavSHpb1rZgHNd7uR6n2ei4WFmN76lGwqPFbf9Uz5
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="303214060"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="303214060"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 03:38:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="689007240"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="689007240"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 09 Jan 2023 03:38:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pEqUK-006MuB-22;
        Mon, 09 Jan 2023 13:38:48 +0200
Date:   Mon, 9 Jan 2023 13:38:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Derek John Clark <derekjohn.clark@gmail.com>,
        linux-iio@vger.kernel.org,
        =?iso-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: BMI0160/260 conflicts
Message-ID: <Y7v8yE8+cXZIDUvw@smile.fi.intel.com>
References: <CAFqHKTm2WRNkcSoBEE=oNbfu_9d9RagQHLydmv6q1=snO_MXyA@mail.gmail.com>
 <20230108115341.6929e7c5@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230108115341.6929e7c5@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jan 08, 2023 at 11:53:41AM +0000, Jonathan Cameron wrote:
> On Sat, 7 Jan 2023 19:51:59 -0800
> Derek John Clark <derekjohn.clark@gmail.com> wrote:

...

> > Remediation:
> > I have reached out to the aforementioned companies about releasing
> > updated BIOS for each of the respective models to correct the DSDT
> > ID's. AYANEO and GPD seem receptive as they have each provided beta
> > BIOS for testing. 
> 
> Great.  Hopefully that means that the scope of problem devices from
> these manufacturers is not going to grow too much going forwards!

Wow, you have Ayaneo response?! Unbelievable!
If they answering to you, can you ping them on [1] please?

[1]: https://lore.kernel.org/lkml/CACAwPwYQHRcrabw9=0tvenPzAcwwW1pTaR6a+AEWBF9Hqf_wXQ@mail.gmail.com/

-- 
With Best Regards,
Andy Shevchenko


