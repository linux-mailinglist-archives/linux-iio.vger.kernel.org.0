Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADFD453919
	for <lists+linux-iio@lfdr.de>; Tue, 16 Nov 2021 19:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239290AbhKPSD1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Nov 2021 13:03:27 -0500
Received: from mga02.intel.com ([134.134.136.20]:43722 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239285AbhKPSDZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Nov 2021 13:03:25 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="220983086"
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="220983086"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 09:49:33 -0800
X-IronPort-AV: E=Sophos;i="5.87,239,1631602800"; 
   d="scan'208";a="604396279"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2021 09:49:29 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mn2a8-007VTG-Sq;
        Tue, 16 Nov 2021 19:49:20 +0200
Date:   Tue, 16 Nov 2021 19:49:20 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hayes Wang <hayeswang@realtek.com>, nicfae@realtek.com,
        wlanfae@realtek.com, pctech@realtek.com, security@realtek.com
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Pkshih <pkshih@realtek.com>, nic_swsd <nic_swsd@realtek.com>,
        Derek =?utf-8?B?W+aWueW+t+e+qV0=?= <derek.fang@realtek.com>,
        Kailang <kailang@realtek.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "info@ayaneo.com" <info@ayaneo.com>
Subject: Re: BMI160 accelerometer on AyaNeo tablet
Message-ID: <YZPvIKYsEM4zPZp7@smile.fi.intel.com>
References: <CACAwPwb7edLzX-KO1XVNWuQ3w=U0BfA=_kwiGCjZOpKfZpc2pw@mail.gmail.com>
 <CACAwPwYQHRcrabw9=0tvenPzAcwwW1pTaR6a+AEWBF9Hqf_wXQ@mail.gmail.com>
 <CAHp75VcEZ19zUU-Ps=kAYJDX1bkxmOqmHii36HE2ujC3gROkNQ@mail.gmail.com>
 <CACAwPwaj_ekK6j9S4CRu6tRTPyjffgDhL3UFnhoYSyJSkAkmpw@mail.gmail.com>
 <YW3ErLKGtmyhSFd3@smile.fi.intel.com>
 <CACAwPwYrxxFstQgYHhPOhMwUz_5RprSuoPNHL7m9ft1i-N2icQ@mail.gmail.com>
 <CAHp75VdCF_Fhso-uS_4JL7a9X90_nQ5JcyCwpeLM3b-YKVqjYw@mail.gmail.com>
 <cd43fddcf9b74f6eaa4dd5a8cdd71bf2@realtek.com>
 <CAHp75VfB2FULb_jfQNg0wF9Z4jPkrKfmw6hSwtLg8Y1NhKks8g@mail.gmail.com>
 <YW/7oKPZORexnyN1@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YW/7oKPZORexnyN1@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I filed the form, Cc'ed this to more people from Realtek, still no response on
the topic. Does Realtek really cares about their IDs?

Any news from Aya-Neo? Have you fixed and issued a new firmware, please?

On Wed, Oct 20, 2021 at 02:21:04PM +0300, Andy Shevchenko wrote:
> +Cc: another set of emails from Realtek as per Hayes' email.
> 
> Please waterfall to the people inside Realtek who can answer the question.
> (Note, you may access this discussion in full via:
> https://lore.kernel.org/linux-iio/CACAwPwYQHRcrabw9=0tvenPzAcwwW1pTaR6a+AEWBF9Hqf_wXQ@mail.gmail.com/T/#u)
> 
> The problem here is to have an official confirmation of what 10ec:5280
> ID is from Realtek's point of view.
> 
> Context: the current discussion and a patch state that it's related
> to gyro sensor. Is it so?
> 
> On Wed, Oct 20, 2021 at 10:36:12AM +0300, Andy Shevchenko wrote:
> > On Wednesday, October 20, 2021, Hayes Wang <hayeswang@realtek.com> wrote:
> > > Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > Sent: Tuesday, October 19, 2021 5:59 PM
> 
> ...
> 
> > > > > > Realtek probably should make this ID marked somehow broken and not
> > > use
> > > > > > in their products in case the answer to the first of the above
> > > question
> > > > > > is "yes". (Of course in case the ID will be used for solely PCI
> > > enumerated
> > > > > > product there will be no conflict, I just propose to be on the
> > > safest side,
> > > > > > but remark should be made somewhere).
> > > >
> > > > Any comments from Realtek, please?
> > >
> > > Excuse me. I don't know this device, so I don't know who I could forward.
> > > Maybe you could try our contract window from our web site.
> > > https://www.realtek.com/en/cu-1-en/cu-1-taiwan-en
> > 
> > Thanks for reply. I will try my best, but I am afraid that what you suggest
> > will be a long loop (and I believe the people behind that form are not
> > technical, they probably won’t understand the topic). I think you may pull
> > strings inside much faster. Just ask somebody who is technical superior in
> > your team / organization. Ideally inside company you may have a dedicated
> > people who responsible for allocating PCI and ACPI IDs.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
With Best Regards,
Andy Shevchenko


