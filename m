Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3DDC38E438
	for <lists+linux-iio@lfdr.de>; Mon, 24 May 2021 12:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhEXKjb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 May 2021 06:39:31 -0400
Received: from mga17.intel.com ([192.55.52.151]:22082 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232673AbhEXKj0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 24 May 2021 06:39:26 -0400
IronPort-SDR: HiOoO0NCNTUfs0B8QSL5PJK8WLrsVm6tF4BgUi5sC46jab37rGePqMPbkj2hCo+VGUYxZsUEtJ
 IyC1rJntafWw==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="182222565"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="182222565"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 03:37:58 -0700
IronPort-SDR: tysfX2xsHNhaT582BPgHp9YNCwt5M3FIgIbdEMlrHylORmBwGlw40leH9cI/dfd8Gti8F+Zmpw
 q2kWQmIDv6IQ==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="546293554"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 03:37:55 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ll7y4-00EIV3-AX; Mon, 24 May 2021 13:37:52 +0300
Date:   Mon, 24 May 2021 13:37:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Denis Ciocca <denis.ciocca@st.com>,
        Daniel Drake <drake@endlessm.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH 1/5 v3] iio: st_sensors: Create extended attr macro
Message-ID: <YKuCACQYtsuDcyqv@smile.fi.intel.com>
References: <20210518230722.522446-1-linus.walleij@linaro.org>
 <323cc45a-6db2-8732-d3b0-784b1250d7f7@redhat.com>
 <20210522191527.228f795a@jic23-huawei>
 <CACRpkdZu0PjH4ciJMSRZ0bywYFjrfWvvfvcpxPQQ+4P=rTNmTw@mail.gmail.com>
 <20210524105042.00002e59@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210524105042.00002e59@Huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 24, 2021 at 10:50:42AM +0100, Jonathan Cameron wrote:
> On Mon, 24 May 2021 11:43:11 +0200
> Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > On Sat, May 22, 2021 at 8:14 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > 
> > > @Linus, for IIO stuff, please put a cover letter on series as it makes it
> > > easier for people to reply with things like this  
> > 
> > OK sorry about that, I'll try to keep it in mind.
> > 
> > > and still let me use b4
> > > without manual tweaking.  
> > 
> > b4 only need the patches to be sent in a thread which I
> > actually did, at least this works fine for me from here:
> > 
> > tmp]$ b4 am -t 20210518230722.522446-1-linus.walleij@linaro.org
> > Looking up https://lore.kernel.org/r/20210518230722.522446-1-linus.walleij%40linaro.org
> > Grabbing thread from lore.kernel.org/linux-iio
> > Analyzing 7 messages in the thread
> > ---
> > Writing ./v3_20210519_linus_walleij_iio_st_sensors_create_extended_attr_macro.mbx
> >   ✓ [PATCH 1/5 v3] iio: st_sensors: Create extended attr macro
> >     + Reviewed-by: Hans de Goede <hdegoede@redhat.com> (✓ DKIM/redhat.com)
> >   ✓ [PATCH 2/5 v3] iio: accel: st_sensors: Support generic mounting matrix
> >   ✓ [PATCH 3/5 v3] iio: accel: st_sensors: Stop copying channels
> >   ✓ [PATCH 4/5 v3] iio: magnetometer: st_magn: Support mount matrix
> >   ✓ [PATCH 5/5 v3] iio: gyro: st_gyro: Support mount matrix
> 
> That only adds the Reviewed-by for patch 1 which was not Hans'
> intention.  If the reply was to a cover letter it would apply to all of the patches.

It's easy to fix with `git filter-branch --msg-filter ...`.

-- 
With Best Regards,
Andy Shevchenko


