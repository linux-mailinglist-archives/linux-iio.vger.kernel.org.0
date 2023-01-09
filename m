Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53289662CBC
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jan 2023 18:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbjAIRbM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Jan 2023 12:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237558AbjAIRai (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jan 2023 12:30:38 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE6F59F9D
        for <linux-iio@vger.kernel.org>; Mon,  9 Jan 2023 09:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673285374; x=1704821374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ggMkZKRaIbxeNNVHZTfcztaxl5cauMSuyOG88q1pQSY=;
  b=EM4XghrZnZZvp1Abl7KX3i9D1TWMu6iQ2uLfXyhbHHWhYWqcUkfSlTZY
   hFI5aNAUj69RcCTNg2oeaajQ6MDDEVKre06G4Jf5/kWKmiovjnT+TyaMX
   7WkbKsxjyJLZn5JI5UmVmlSKC0yE5RA/mXYRKHya/Tozy2cuXd3cX6/Wn
   Idlxs5TqjpZemsNQ+PloiJ2ZefR8s3N3zp2ePxwHJh8JlQLbFmaTvw1QA
   a/EiQByXr2m48N5vwJMKE5rL0+N67HElI//A2lcfiPjs3BnwmQ+0PvRTi
   S/OPIBNI1A95BgLzHp0/d1mpPQLvF3CNbRDNl1qEsIshOO9+jMXD9Y64V
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="321634182"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="321634182"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 09:29:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="606670769"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="606670769"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP; 09 Jan 2023 09:29:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pEvxh-006dCb-1i;
        Mon, 09 Jan 2023 19:29:29 +0200
Date:   Mon, 9 Jan 2023 19:29:29 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Derek John Clark <derekjohn.clark@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        =?iso-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: BMI0160/260 conflicts
Message-ID: <Y7xO+WDQkvXIxvnw@smile.fi.intel.com>
References: <CAFqHKTm2WRNkcSoBEE=oNbfu_9d9RagQHLydmv6q1=snO_MXyA@mail.gmail.com>
 <20230108115341.6929e7c5@jic23-huawei>
 <Y7v8yE8+cXZIDUvw@smile.fi.intel.com>
 <CAFqHKTkKYfmVr7DE25SC-S=p=GxVAcCx9ypOL=Mm_mi=Qsp-yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqHKTkKYfmVr7DE25SC-S=p=GxVAcCx9ypOL=Mm_mi=Qsp-yg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jan 09, 2023 at 07:42:01AM -0800, Derek John Clark wrote:
> On Mon, Jan 9, 2023 at 3:38 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Sun, Jan 08, 2023 at 11:53:41AM +0000, Jonathan Cameron wrote:
> > > On Sat, 7 Jan 2023 19:51:59 -0800
> > > Derek John Clark <derekjohn.clark@gmail.com> wrote:

...

> > > > Remediation:
> > > > I have reached out to the aforementioned companies about releasing
> > > > updated BIOS for each of the respective models to correct the DSDT
> > > > ID's. AYANEO and GPD seem receptive as they have each provided beta
> > > > BIOS for testing.
> > >
> > > Great.  Hopefully that means that the scope of problem devices from
> > > these manufacturers is not going to grow too much going forwards!
> >
> > Wow, you have Ayaneo response?! Unbelievable!
> > If they answering to you, can you ping them on [1] please?
> >
> > [1]: https://lore.kernel.org/lkml/CACAwPwYQHRcrabw9=0tvenPzAcwwW1pTaR6a+AEWBF9Hqf_wXQ@mail.gmail.com/

> I've been knocking on this door for a few months now. They recently
> sent me a test BIOS with the alleged fix for testing. Hopefully they
> do a wide release once it is fully validated.

At least they reacted to your knock, that's why I'm asking you to ping them so
they would know that they have an issue with the ACPI ID for the accelerometer
device.

-- 
With Best Regards,
Andy Shevchenko


