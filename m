Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E0A271F7C
	for <lists+linux-iio@lfdr.de>; Mon, 21 Sep 2020 11:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgIUJ6o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Sep 2020 05:58:44 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2897 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726326AbgIUJ6n (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 21 Sep 2020 05:58:43 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 7B239BE51E25D89791C6;
        Mon, 21 Sep 2020 10:58:42 +0100 (IST)
Received: from localhost (10.52.121.13) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 21 Sep
 2020 10:58:42 +0100
Date:   Mon, 21 Sep 2020 10:57:03 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Christian Eggers <ceggers@arri.de>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: hrtimer-trigger: Mark hrtimer to expire in
 hard interrupt context
Message-ID: <20200921105703.000048b3@Huawei.com>
In-Reply-To: <5007153.c9bsiqU2ZW@n95hx1g2>
References: <20200813075358.13310-1-lars@metafoo.de>
        <20200814113008.00002733@Huawei.com>
        <20200920191545.4ed79276@archlinux>
        <5007153.c9bsiqU2ZW@n95hx1g2>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.13]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 21 Sep 2020 09:17:26 +0200
Christian Eggers <ceggers@arri.de> wrote:

> Tested together with
> 
> - iio: Fix: Do not poll the driver again if try_reenable() callback returns non 0.
> and 
> - iio:trigger: rename try_reenable() to reenable() plus return void
> 
> on latest mainline (without PREEMPT_RT). The original WARN_ONCE() in
> kernel/irq/handle.c:159 was not raised anymore. But even without the current
> patches, this warning is not shown (as this problem only applies to -RT).
> 
> Currently I haven't ported a RT kernel > 5.4 for my board, so I cannot check
> with current RT. On 5.4. there the patches seem not to work fully as 
> kernel/timer/hrtimer.c is not up to date enough.
> 
> Sorry for being not very helpful...
Thanks for at least trying!

So looking at this the other way, are there any significant risks associated
with this change?  If not I'm tempted to queue them up and we have the rcX
time to fix anything we've missed (just like every other patch!)

Jonathan

> 
> Best regards
> Christian
> 
> On Sunday, 20 September 2020, 20:15:45 CEST, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > As we no longer support a try again if we cannot reenable the trigger
> > rename the function to reflect this.   Also we don't do anything with
> > the value returned so stop it returning anything.  For the few drivers
> > that didn't already print an error message in this patch, add such
> > a print.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Christian Oder <me@myself5.de>
> > Cc: Eugen Hristev <eugen.hristev@microchip.com>
> > Cc: Nishant Malpani <nish.malpani25@gmail.com>
> > Cc: Daniel Baluta <daniel.baluta@oss.nxp.com>
> > ---  
> 
> 
> 


