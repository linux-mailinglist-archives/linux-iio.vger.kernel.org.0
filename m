Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD3E418F260
	for <lists+linux-iio@lfdr.de>; Mon, 23 Mar 2020 11:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgCWKIF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Mar 2020 06:08:05 -0400
Received: from mga11.intel.com ([192.55.52.93]:15612 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727788AbgCWKIF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Mar 2020 06:08:05 -0400
IronPort-SDR: Sg+y2jnnMrQEKuHky3rKutFLSzwSwgh3nVopkeqSwOK0TlxDMmfKOEOoXrnuz6TMx+r/0RIqzB
 u1ghCVnwqGtA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 03:08:04 -0700
IronPort-SDR: ngdJoNPBGS+fwYwfybWSd+DHgQVQbYXdQfmF8wRNvPL5seYC07Q02SBJA/t6dTxLcvMAgNRxEP
 ypgZaS1GoQvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,296,1580803200"; 
   d="scan'208";a="325524965"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 23 Mar 2020 03:08:00 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1jGK02-00CD6J-CV; Mon, 23 Mar 2020 12:08:02 +0200
Date:   Mon, 23 Mar 2020 12:08:02 +0200
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/5] iio: pressure: bmp280: Tolerate IRQ before
 registering
Message-ID: <20200323100802.GG1922688@smile.fi.intel.com>
References: <20200317101813.30829-1-andriy.shevchenko@linux.intel.com>
 <20200322171216.3260cd37@archlinux>
 <CAHp75VcUPSmCnKFSm8y6Nq_qCcMHHihACC+49FyzrawAqMjQDA@mail.gmail.com>
 <20200323094018.00002190@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323094018.00002190@Huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 23, 2020 at 09:40:18AM +0000, Jonathan Cameron wrote:
> On Sun, 22 Mar 2020 23:15:13 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Sun, Mar 22, 2020 at 7:14 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > > On Tue, 17 Mar 2020 12:18:09 +0200
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> > > > -     if (data->use_eoc)
> > > > -             init_completion(&data->done);
> > > > +     reinit_completion(&data->done);  
> > >
> > > reinit on the completion when we don't even have an interrupt
> > > (hence data->use_eoc == false) seems excessive.  Why did
> > > you drop the conditional?  
> > 
> > It's harmless and gives less code I believe.
> > But if you insist I can put it back.
> > 
> 
> I agree it's harmless but breaks the logical flow by doing
> something unnecessary so either we need a comment to say that
> or easier option, just put the condition back in.

I will do this for v2.
Thank you for review!

-- 
With Best Regards,
Andy Shevchenko


