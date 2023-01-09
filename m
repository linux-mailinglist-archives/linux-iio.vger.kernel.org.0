Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAF46631D6
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jan 2023 21:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbjAIUtm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Jan 2023 15:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237497AbjAIUtc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jan 2023 15:49:32 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266954D739
        for <linux-iio@vger.kernel.org>; Mon,  9 Jan 2023 12:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673297371; x=1704833371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iQEOoVg4QAanlcwZOadaNr6GPdeemZiLJWpWXLAhuPU=;
  b=Tec2UeM3ReNOF9dxAUA64hAHhpXkJ7h9DfcvjvmCn6fCPXAJvkLQQVdp
   J3BwP4BU0WTZngtpwH01fPnRCaQxdIDt0X7a8TieO7kUSJimu5hXxMCw7
   W8jylUGrk4v1U72nfK6E4exwVtK12k2a8i6TMhhyJ8/nl+ElOLOfUYToD
   1BzSwFNzdG1io1Tuc9evSO33n8cE3+oC06SmLjLzL9TpibSoPTkF+N8HY
   HWPyV3GDMr1fXzmRP8/gVBmrKEGEujqbCARKoYPhv1URy2vb8w2HEP/yF
   kLejQIyiebEE372DQra4EZ9PFab3ACoqOSbVhneyl0x37sUUMdcb3tuFJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="324982228"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="324982228"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 12:49:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="656801029"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="656801029"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 09 Jan 2023 12:49:25 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pEz5A-006iok-18;
        Mon, 09 Jan 2023 22:49:24 +0200
Date:   Mon, 9 Jan 2023 22:49:24 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Derek John Clark <derekjohn.clark@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        =?iso-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>, liudk@softwincn.com
Subject: Re: BMI0160/260 conflicts
Message-ID: <Y7x91ELtcOLmYoH/@smile.fi.intel.com>
References: <CAFqHKTm2WRNkcSoBEE=oNbfu_9d9RagQHLydmv6q1=snO_MXyA@mail.gmail.com>
 <20230108115341.6929e7c5@jic23-huawei>
 <Y7v8yE8+cXZIDUvw@smile.fi.intel.com>
 <CAFqHKTkKYfmVr7DE25SC-S=p=GxVAcCx9ypOL=Mm_mi=Qsp-yg@mail.gmail.com>
 <Y7xO+WDQkvXIxvnw@smile.fi.intel.com>
 <CAFqHKT=5vFE2nrVDLqZ_edxxFin7iKe4go-vvmGseSY2EdizjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqHKT=5vFE2nrVDLqZ_edxxFin7iKe4go-vvmGseSY2EdizjQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jan 09, 2023 at 11:04:38AM -0800, Derek John Clark wrote:
> They typically communicate through discord or whatsapp. I've sent them
> the link for the thread a few times and I've asked for an email
> address I can CC on the LKML so we'll see if they provide one. I don't
> think this will be an issue, from them at least, in the future. For a
> bit of history, the original tablet was designed by a different team
> which they were obligated to finish through an IndieGoGo campaign
> after the company was bought out halfway through production. All
> subsequent releases from AyaNeo (7 models by my count) have all used
> the BMI0160 ACPI ID. I'm personally more concerned personally with GPD
> having released new products over a year later using the same Realtek
> ACPI ID, and currently sending out engineering sample units of a
> second model. I've included my GPD contact in this thread for their
> awareness.

Thank you very much for this effort!

Btw, feel free to tell them if they need any assistance in ACPI understanding
they may publicly or privately ask me and other Linux kernel developers from
Intel related to ACPI (see MAINTAINERS for that list).

> On Mon, Jan 9, 2023 at 9:29 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Mon, Jan 09, 2023 at 07:42:01AM -0800, Derek John Clark wrote:
> > > On Mon, Jan 9, 2023 at 3:38 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > On Sun, Jan 08, 2023 at 11:53:41AM +0000, Jonathan Cameron wrote:
> > > > > On Sat, 7 Jan 2023 19:51:59 -0800
> > > > > Derek John Clark <derekjohn.clark@gmail.com> wrote:

...

> > > > > > Remediation:
> > > > > > I have reached out to the aforementioned companies about releasing
> > > > > > updated BIOS for each of the respective models to correct the DSDT
> > > > > > ID's. AYANEO and GPD seem receptive as they have each provided beta
> > > > > > BIOS for testing.
> > > > >
> > > > > Great.  Hopefully that means that the scope of problem devices from
> > > > > these manufacturers is not going to grow too much going forwards!
> > > >
> > > > Wow, you have Ayaneo response?! Unbelievable!
> > > > If they answering to you, can you ping them on [1] please?
> > > >
> > > > [1]: https://lore.kernel.org/lkml/CACAwPwYQHRcrabw9=0tvenPzAcwwW1pTaR6a+AEWBF9Hqf_wXQ@mail.gmail.com/
> >
> > > I've been knocking on this door for a few months now. They recently
> > > sent me a test BIOS with the alleged fix for testing. Hopefully they
> > > do a wide release once it is fully validated.
> >
> > At least they reacted to your knock, that's why I'm asking you to ping them so
> > they would know that they have an issue with the ACPI ID for the accelerometer
> > device.

-- 
With Best Regards,
Andy Shevchenko


