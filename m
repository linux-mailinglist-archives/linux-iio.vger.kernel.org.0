Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B834326FF
	for <lists+linux-iio@lfdr.de>; Mon, 18 Oct 2021 21:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhJRTFI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 Oct 2021 15:05:08 -0400
Received: from mga04.intel.com ([192.55.52.120]:22880 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231234AbhJRTFI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 18 Oct 2021 15:05:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="227111594"
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; 
   d="scan'208";a="227111594"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 12:02:27 -0700
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; 
   d="scan'208";a="566192249"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.159])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 12:02:23 -0700
Received: from andy by smile with local (Exim 4.95)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1mcXtc-000IvV-Jz;
        Mon, 18 Oct 2021 22:02:04 +0300
Date:   Mon, 18 Oct 2021 22:02:04 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Maxim Levitsky <maximlevitsky@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-realtek-soc@lists.infradead.org,
        Oder Chiou <oder_chiou@realtek.com>,
        Ping-Ke Shih <pkshih@realtek.com>, nic_swsd@realtek.com,
        Derek Fang <derek.fang@realtek.com>,
        Hayes Wang <hayeswang@realtek.com>,
        Kailang Yang <kailang@realtek.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        LKML <linux-kernel@vger.kernel.org>, info@ayaneo.com
Subject: Re: BMI160 accelerometer on AyaNeo tablet
Message-ID: <YW3ErLKGtmyhSFd3@smile.fi.intel.com>
References: <CACAwPwb7edLzX-KO1XVNWuQ3w=U0BfA=_kwiGCjZOpKfZpc2pw@mail.gmail.com>
 <CACAwPwYQHRcrabw9=0tvenPzAcwwW1pTaR6a+AEWBF9Hqf_wXQ@mail.gmail.com>
 <CAHp75VcEZ19zUU-Ps=kAYJDX1bkxmOqmHii36HE2ujC3gROkNQ@mail.gmail.com>
 <CACAwPwaj_ekK6j9S4CRu6tRTPyjffgDhL3UFnhoYSyJSkAkmpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACAwPwaj_ekK6j9S4CRu6tRTPyjffgDhL3UFnhoYSyJSkAkmpw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 18, 2021 at 09:02:40PM +0300, Maxim Levitsky wrote:
> I also suspect a mistake from the hardware vendors.
> 
> I attached all DSDT decompiled, which shows that they indeed use that
> ID, and I also attached the windows driver .INF which was published on
> their website  with the driver (https://www.ayaneo.com/downloads)
> 
> They are a small startup so they might have used the realtek ID by mistake.
> I added them to the CC.

Thank you for sharing. Seems they indeed used (deliberately or not) the wrong
ID. So there are questions I have:
- Is the firmware available in the wild?
- Do they plan to update firmware to fix this?
- Can we make sure that guys got their mistake and will be more careful
  in the future?

Realtek probably should make this ID marked somehow broken and not use
in their products in case the answer to the first of the above question
is "yes". (Of course in case the ID will be used for solely PCI enumerated
product there will be no conflict, I just propose to be on the safest side,
but remark should be made somewhere).

> BTW, I also notice a rotation matrix embedded in DSTD, but the linux's
> BMI160 driver doesn't recognize it.

This is done by the commit 8a0672003421 ("iio: accel: bmc150: Get
mount-matrix from ACPI") which needs to be amended to take care about
more devices, somewhere in drivers/iio/industialio-acpi.c ? Jonathan,
Hans, what do you think?

P.S. As I said, the commit message and the code (in the comments) should
be very well elaborated and only accepted in case the firmware is already
in the wild on the market.

-- 
With Best Regards,
Andy Shevchenko


