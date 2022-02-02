Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2534A75B2
	for <lists+linux-iio@lfdr.de>; Wed,  2 Feb 2022 17:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345813AbiBBQYV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Feb 2022 11:24:21 -0500
Received: from mga05.intel.com ([192.55.52.43]:12903 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239135AbiBBQYU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 2 Feb 2022 11:24:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643819060; x=1675355060;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ukjzdZ1LCQH1/e1Fw/IBXRZHdov9vWYpkFWNV439dD4=;
  b=FHUPLPGpejHTOhZ4tO4uAYZ33n+XWLnxaQNq4zDBjox9Jpc3nmdZ+1q1
   2GLFXZMhIXTgIt/8nZFzAJKR7P84Ket9lZAwIFOrOsipimRYqgYa1lPDT
   CY89suWLVBEp2LZXlIOU5ILX9NFlyAVqs1/7GqMQY7F0mD3VcTp+OecQI
   fcUL04s7PrusOJebxSh992sOaeMKJQ/nEydeWvPqX/XhWlMINxjuH7yWP
   mENj+6Obg3O+OciD9DNWriYVWfpwV4u6llmqJDKoY65mY8lr6CE+EkH2F
   nrqm3BD5exOuQoWAdgp6qr9zlqxywXleM4/nX1kmZ4hkzNUkwzU4a80zK
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="334313158"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="334313158"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 08:24:20 -0800
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="480154340"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 08:24:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nFIPZ-0008lT-Rm;
        Wed, 02 Feb 2022 18:23:13 +0200
Date:   Wed, 2 Feb 2022 18:23:13 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Maxim Levitsky <maximlevitsky@gmail.com>
Cc:     Hayes Wang <hayeswang@realtek.com>, nicfae@realtek.com,
        wlanfae@realtek.com, pctech@realtek.com, security@realtek.com,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Pkshih <pkshih@realtek.com>, nic_swsd <nic_swsd@realtek.com>,
        Derek =?utf-8?B?W+aWueW+t+e+qV0=?= <derek.fang@realtek.com>,
        Kailang <kailang@realtek.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "info@ayaneo.com" <info@ayaneo.com>, meakyi@ayaneo.com,
        software@ayaneo.com
Subject: Re: BMI160 accelerometer on AyaNeo tablet
Message-ID: <Yfqv8V6fZBnG5J5H@smile.fi.intel.com>
References: <CACAwPwauWAcin3Vj4cOM1uejrCz-eRX_3Hp_iZFap--yuXK0jg@mail.gmail.com>
 <Yeh564iHDXEzHXUQ@smile.fi.intel.com>
 <CACAwPwatbMjd9CLdFCWnND3FqT5ZtPJqEVC-Ohze+GoJ6ODqqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACAwPwatbMjd9CLdFCWnND3FqT5ZtPJqEVC-Ohze+GoJ6ODqqw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jan 23, 2022 at 07:22:46PM +0200, Maxim Levitsky wrote:
> Added software@ayaneo.com to CC ( I found this email on google).

I believe they both (Realtek and Aya-Neo) don't care about this.

This is really frustrating.

So, let's wait couple more weeks and if nothing happens, maybe we can submit
original ID with a huge comment on top (with a link to lore.kernel.org of this
discussion) that this is WRONG WRONG WRONG and must not be repeated.

> On Wed, Jan 19, 2022 at 10:53 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > +Cc: more Aya-Neo emails (please, share it with your legal, involved managers
> >      and engineers).
> >
> > On Wed, Jan 19, 2022 at 09:05:25PM +0200, Maxim Levitsky wrote:
> > > > Any news from Aya-Neo? Have you fixed and issued a new firmware, please?
> > >
> > > Nothing I heard of. Anything I can do to further help with this?
> >
> > Unfortunately we need to hear from the Aya-Neo, if they ever care about their
> > products. Without that it would make an unfortunate precedent which will open
> > a Pandora's box (means a green light on abusing ACPI specification and other's
> > IPs, yes, Intellectual Property in this case, as ID is an IP of the corresponding
> > vendor).
> >
> > I'm fine if Realtek doesn't care about their IDs to be (ab)used by somebody else,
> > the main problem here is on Aya-Neo side.
> >
> > Is there any engineer-to-engineer connection with Aya-Neo? Because using that
> > info@ address may be simply ignored / went to spam / etc.
> >
> > > On Tue, Nov 16, 2021 at 7:50 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > I filed the form, Cc'ed this to more people from Realtek, still no response on
> > > > the topic. Does Realtek really cares about their IDs?
> > > >
> > > > Any news from Aya-Neo? Have you fixed and issued a new firmware, please?
> > > >
> > > > On Wed, Oct 20, 2021 at 02:21:04PM +0300, Andy Shevchenko wrote:
> > > > > +Cc: another set of emails from Realtek as per Hayes' email.
> > > > >
> > > > > Please waterfall to the people inside Realtek who can answer the question.
> > > > > (Note, you may access this discussion in full via:
> > > > > https://lore.kernel.org/linux-iio/CACAwPwYQHRcrabw9=0tvenPzAcwwW1pTaR6a+AEWBF9Hqf_wXQ@mail.gmail.com/T/#u)
> > > > >
> > > > > The problem here is to have an official confirmation of what 10ec:5280
> > > > > ID is from Realtek's point of view.
> > > > >
> > > > > Context: the current discussion and a patch state that it's related
> > > > > to gyro sensor. Is it so?
> > > > >
> > > > > On Wed, Oct 20, 2021 at 10:36:12AM +0300, Andy Shevchenko wrote:
> > > > > > On Wednesday, October 20, 2021, Hayes Wang <hayeswang@realtek.com> wrote:
> > > > > > > Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > > > > > Sent: Tuesday, October 19, 2021 5:59 PM
> > > > >
> > > > > ...
> > > > >
> > > > > > > > > > Realtek probably should make this ID marked somehow broken and not
> > > > > > > use
> > > > > > > > > > in their products in case the answer to the first of the above
> > > > > > > question
> > > > > > > > > > is "yes". (Of course in case the ID will be used for solely PCI
> > > > > > > enumerated
> > > > > > > > > > product there will be no conflict, I just propose to be on the
> > > > > > > safest side,
> > > > > > > > > > but remark should be made somewhere).
> > > > > > > >
> > > > > > > > Any comments from Realtek, please?
> > > > > > >
> > > > > > > Excuse me. I don't know this device, so I don't know who I could forward.
> > > > > > > Maybe you could try our contract window from our web site.
> > > > > > > https://www.realtek.com/en/cu-1-en/cu-1-taiwan-en
> > > > > >
> > > > > > Thanks for reply. I will try my best, but I am afraid that what you suggest
> > > > > > will be a long loop (and I believe the people behind that form are not
> > > > > > technical, they probably won’t understand the topic). I think you may pull
> > > > > > strings inside much faster. Just ask somebody who is technical superior in
> > > > > > your team / organization. Ideally inside company you may have a dedicated
> > > > > > people who responsible for allocating PCI and ACPI IDs.
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> >

-- 
With Best Regards,
Andy Shevchenko


