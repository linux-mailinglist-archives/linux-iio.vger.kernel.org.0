Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8872814B0
	for <lists+linux-iio@lfdr.de>; Fri,  2 Oct 2020 16:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgJBOKn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Oct 2020 10:10:43 -0400
Received: from mailout07.rmx.de ([94.199.90.95]:33466 "EHLO mailout07.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387777AbgJBOKn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 2 Oct 2020 10:10:43 -0400
Received: from kdin01.retarus.com (kdin01.dmz1.retloc [172.19.17.48])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout07.rmx.de (Postfix) with ESMTPS id 4C2sMz3hFTzBwQT
        for <linux-iio@vger.kernel.org>; Fri,  2 Oct 2020 16:10:39 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin01.retarus.com (Postfix) with ESMTPS id 4C2sMr6DdMz2yqg
        for <linux-iio@vger.kernel.org>; Fri,  2 Oct 2020 16:10:32 +0200 (CEST)
Received: from n95hx1g2.localnet (192.168.54.29) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Fri, 2 Oct
 2020 16:10:10 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: hrtimer-trigger: Mark hrtimer to expire in hard interrupt context
Date:   Fri, 2 Oct 2020 16:10:09 +0200
Message-ID: <1672856.66Rh2xUnMN@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <20200921105703.000048b3@Huawei.com>
References: <20200813075358.13310-1-lars@metafoo.de> <5007153.c9bsiqU2ZW@n95hx1g2> <20200921105703.000048b3@Huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.29]
X-RMX-ID: 20201002-161034-4C2sMr6DdMz2yqg-0@kdin01
X-RMX-SOURCE: 217.111.95.66
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Monday, 21 September 2020, 11:57:03 CEST, Jonathan Cameron wrote:
> On Mon, 21 Sep 2020 09:17:26 +0200
> 
> Christian Eggers <ceggers@arri.de> wrote:
> > Tested together with
> > 
> > - iio: Fix: Do not poll the driver again if try_reenable() callback
> > returns non 0. and
> > - iio:trigger: rename try_reenable() to reenable() plus return void
> > 
> > on latest mainline (without PREEMPT_RT). The original WARN_ONCE() in
> > kernel/irq/handle.c:159 was not raised anymore. But even without the
> > current patches, this warning is not shown (as this problem only applies
> > to -RT).
> > 
> > Currently I haven't ported a RT kernel > 5.4 for my board, so I cannot
> > check with current RT. On 5.4. there the patches seem not to work fully
> > as kernel/timer/hrtimer.c is not up to date enough.
> > 
> > Sorry for being not very helpful...
> 
> Thanks for at least trying!

I've just ported my BSP to v5.9-rc7-rt10. It looks like your patch misses one 
additional change in iio_trig_hrtimer_set_state():

-		hrtimer_start(&trig_info->timer, trig_info->period,
-			      HRTIMER_MODE_REL);
+		hrtimer_start(&trig_info->timer, trig_info->period,
+			      HRTIMER_MODE_REL_HARD);

Without this, WARN_ON_ONCE() in kernel/time/hrtimer.c:1133 will be hit:

WARN_ON_ONCE(!(mode & HRTIMER_MODE_HARD) ^ !timer->is_hard);

So the mode HRTIMER_MODE_REL_HARD is required for hrtimer_init() (will be 
stored in timer->is_hard) and for hrtimer_start().

Best regards
Christian



