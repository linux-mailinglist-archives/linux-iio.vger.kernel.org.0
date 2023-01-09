Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B2A662472
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jan 2023 12:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbjAILmh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Jan 2023 06:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbjAILmF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jan 2023 06:42:05 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2965A5F82
        for <linux-iio@vger.kernel.org>; Mon,  9 Jan 2023 03:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673264524; x=1704800524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lDjaCWUzdYwYNkS/MTZUwYBYKzaOJgpic2tzkvbPb/c=;
  b=mGzYYBZx57hS7PFhvaKqUn10yawokxE84KcMPEO7Mw6LVTrwfhPyEdMG
   KCixf9UQSrei0vD8lNq1yt3RAi9SjfF/iJQ/W5tJ4QQq33sW1uEvEpYK6
   6zeRoZzv076HFZnNv1qgt3b4+YwE/cJuRSygWEQ05dGhaElACFVd8gEft
   hwkACkWbtnUuUogcpolXPuX8O+b3lrqXk2QNR5up9cnqt+he4uBc2Qb0+
   PGw4v8junflD9V8ShCnhNMPsMa6qqSGCOzJksbAJ542wOR4SNROQOumcp
   xq4SldYsa1SYFQzyyNvY16uvZzGhmd/XS8zccmuVpmn2rfQoLhxpEDchC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="320553951"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="320553951"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 03:42:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10584"; a="901974078"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="901974078"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 09 Jan 2023 03:42:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pEqXQ-006Myg-2p;
        Mon, 09 Jan 2023 13:42:00 +0200
Date:   Mon, 9 Jan 2023 13:42:00 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Derek John Clark <derekjohn.clark@gmail.com>,
        linux-iio@vger.kernel.org,
        =?iso-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: BMI0160/260 conflicts
Message-ID: <Y7v9iPcebF9RTSOn@smile.fi.intel.com>
References: <CAFqHKTm2WRNkcSoBEE=oNbfu_9d9RagQHLydmv6q1=snO_MXyA@mail.gmail.com>
 <20230108115341.6929e7c5@jic23-huawei>
 <Y7v8yE8+cXZIDUvw@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7v8yE8+cXZIDUvw@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jan 09, 2023 at 01:38:48PM +0200, Andy Shevchenko wrote:
> On Sun, Jan 08, 2023 at 11:53:41AM +0000, Jonathan Cameron wrote:
> > On Sat, 7 Jan 2023 19:51:59 -0800
> > Derek John Clark <derekjohn.clark@gmail.com> wrote:

...

> > > Remediation:
> > > I have reached out to the aforementioned companies about releasing
> > > updated BIOS for each of the respective models to correct the DSDT
> > > ID's. AYANEO and GPD seem receptive as they have each provided beta
> > > BIOS for testing. 
> > 
> > Great.  Hopefully that means that the scope of problem devices from
> > these manufacturers is not going to grow too much going forwards!
> 
> Wow, you have Ayaneo response?! Unbelievable!
> If they answering to you, can you ping them on [1] please?

TL;DR: They are using Realtek's ACPI HID for the Bosch sensor device.

> [1]: https://lore.kernel.org/lkml/CACAwPwYQHRcrabw9=0tvenPzAcwwW1pTaR6a+AEWBF9Hqf_wXQ@mail.gmail.com/

-- 
With Best Regards,
Andy Shevchenko


