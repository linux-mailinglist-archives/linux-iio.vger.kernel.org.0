Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE504666EE0
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jan 2023 11:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbjALKBD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Jan 2023 05:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbjALKAd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Jan 2023 05:00:33 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DBFF20
        for <linux-iio@vger.kernel.org>; Thu, 12 Jan 2023 01:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673517523; x=1705053523;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=J7UJYgWM00AsQsv11Dw81/WxF8coYtdiHlxqo3bwu4M=;
  b=VOwXi70YsZReh/Ay19wBUpnhMfu2Z5ihJxv0x7iSAR/+BtcZWRI+ZfBH
   FkbbIVU4h2NuEcR95FTYqgEVkyDmK3h1VVeERcSPW7T42dpZGFZBI8NkA
   tNsSV1ENnfPt8t4hQSirDgji21WsbH4+1BTgjTB8J61d1VLM6I6jnZLzR
   j/+U7pUOwKVPLj8FHgrXOxQ1AolROubmU6OAmoQ9JqsRVo8QeXSrZEytM
   SnAGhh+Ege1qw7vsyCzbsWmRb0JuyHlJkphBXxbBJiEd5GkK3tT9ssJO6
   d5AeWWUOXK5/X6SxN2cG7NRzDleReVTExosxutaNCO1S4fdwiqt0n+E7R
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="321354454"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="321354454"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 01:58:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="831634538"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="831634538"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 12 Jan 2023 01:58:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pFuM3-007zAc-1B;
        Thu, 12 Jan 2023 11:58:39 +0200
Date:   Thu, 12 Jan 2023 11:58:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     liudk@softwincn.com
Cc:     Derek John Clark <derekjohn.clark@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        =?iso-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: Re: BMI0160/260 conflicts
Message-ID: <Y7/Zz5AOFnXSFAgS@smile.fi.intel.com>
References: <CAFqHKTm2WRNkcSoBEE=oNbfu_9d9RagQHLydmv6q1=snO_MXyA@mail.gmail.com>
 <20230108115341.6929e7c5@jic23-huawei>
 <Y7v8yE8+cXZIDUvw@smile.fi.intel.com>
 <CAFqHKTkKYfmVr7DE25SC-S=p=GxVAcCx9ypOL=Mm_mi=Qsp-yg@mail.gmail.com>
 <Y7xO+WDQkvXIxvnw@smile.fi.intel.com>
 <CAFqHKT=5vFE2nrVDLqZ_edxxFin7iKe4go-vvmGseSY2EdizjQ@mail.gmail.com>
 <Y7x91ELtcOLmYoH/@smile.fi.intel.com>
 <E0791B6D696C82E2+202301110931264482331@softwincn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E0791B6D696C82E2+202301110931264482331@softwincn.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jan 11, 2023 at 09:31:27AM +0800, liudk@softwincn.com wrote:
> HI：
>     We have been verifying the BMI0160 ACPI ID on WIN4. If there is no problem with the verification, it will be updated to WinMax2 synchronously. At present, the feedback is that the chip of BMI 260 under Linux does not seem to be able to use the driver of BMI 160, and we are still trying the latest Linux driver

Thank you for confirming the ID. The devices discussed in the thread [1] below
have the Realtek ID (in accordance with PCI and ACPI specifications). I hope
that that is fixed now.

> 中软赢科技术有限公司
> 软件部     刘德康
> 电话： 18674743475
> 地址： 深圳市南山区软件产业基地4D栋1006
>  
> From: Andy Shevchenko
> Date: 2023-01-10 04:49
> To: Derek John Clark
> CC: Jonathan Cameron; linux-iio; Joaquín Ignacio Aramendía; Hans de Goede; liudk
> Subject: Re: BMI0160/260 conflicts
> On Mon, Jan 09, 2023 at 11:04:38AM -0800, Derek John Clark wrote:
> > They typically communicate through discord or whatsapp. I've sent them
> > the link for the thread a few times and I've asked for an email
> > address I can CC on the LKML so we'll see if they provide one. I don't
> > think this will be an issue, from them at least, in the future. For a
> > bit of history, the original tablet was designed by a different team
> > which they were obligated to finish through an IndieGoGo campaign
> > after the company was bought out halfway through production. All
> > subsequent releases from AyaNeo (7 models by my count) have all used
> > the BMI0160 ACPI ID. I'm personally more concerned personally with GPD
> > having released new products over a year later using the same Realtek
> > ACPI ID, and currently sending out engineering sample units of a
> > second model. I've included my GPD contact in this thread for their
> > awareness.
>  
> Thank you very much for this effort!
>  
> Btw, feel free to tell them if they need any assistance in ACPI understanding
> they may publicly or privately ask me and other Linux kernel developers from
> Intel related to ACPI (see MAINTAINERS for that list).
>  
> > On Mon, Jan 9, 2023 at 9:29 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Mon, Jan 09, 2023 at 07:42:01AM -0800, Derek John Clark wrote:
> > > > On Mon, Jan 9, 2023 at 3:38 AM Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > >
> > > > > On Sun, Jan 08, 2023 at 11:53:41AM +0000, Jonathan Cameron wrote:
> > > > > > On Sat, 7 Jan 2023 19:51:59 -0800
> > > > > > Derek John Clark <derekjohn.clark@gmail.com> wrote:

...

> > > > > > > Remediation:
> > > > > > > I have reached out to the aforementioned companies about releasing
> > > > > > > updated BIOS for each of the respective models to correct the DSDT
> > > > > > > ID's. AYANEO and GPD seem receptive as they have each provided beta
> > > > > > > BIOS for testing.
> > > > > >
> > > > > > Great.  Hopefully that means that the scope of problem devices from
> > > > > > these manufacturers is not going to grow too much going forwards!
> > > > >
> > > > > Wow, you have Ayaneo response?! Unbelievable!
> > > > > If they answering to you, can you ping them on [1] please?

[1]: https://lore.kernel.org/lkml/CACAwPwYQHRcrabw9=0tvenPzAcwwW1pTaR6a+AEWBF9Hqf_wXQ@mail.gmail.com/

> > > > I've been knocking on this door for a few months now. They recently
> > > > sent me a test BIOS with the alleged fix for testing. Hopefully they
> > > > do a wide release once it is fully validated.
> > >
> > > At least they reacted to your knock, that's why I'm asking you to ping them so
> > > they would know that they have an issue with the ACPI ID for the accelerometer
> > > device.

-- 
With Best Regards,
Andy Shevchenko


