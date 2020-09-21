Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05138271B4B
	for <lists+linux-iio@lfdr.de>; Mon, 21 Sep 2020 09:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgIUHTo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Sep 2020 03:19:44 -0400
Received: from mailout06.rmx.de ([94.199.90.92]:48852 "EHLO mailout06.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbgIUHTo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 21 Sep 2020 03:19:44 -0400
Received: from kdin02.retarus.com (kdin02.dmz1.retloc [172.19.17.49])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout06.rmx.de (Postfix) with ESMTPS id 4Bvwmr0RVSz9vLf
        for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2020 09:19:40 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin02.retarus.com (Postfix) with ESMTPS id 4Bvwmg2tSZz2TTMg
        for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2020 09:19:31 +0200 (CEST)
Received: from n95hx1g2.localnet (192.168.54.110) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 21 Sep
 2020 09:17:27 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/2] iio: hrtimer-trigger: Mark hrtimer to expire in hard interrupt context
Date:   Mon, 21 Sep 2020 09:17:26 +0200
Message-ID: <5007153.c9bsiqU2ZW@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <20200920191545.4ed79276@archlinux>
References: <20200813075358.13310-1-lars@metafoo.de> <20200814113008.00002733@Huawei.com> <20200920191545.4ed79276@archlinux>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.110]
X-RMX-ID: 20200921-091939-4Bvwmg2tSZz2TTMg-0@kdin02
X-RMX-SOURCE: 217.111.95.66
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Tested together with

- iio: Fix: Do not poll the driver again if try_reenable() callback returns non 0.
and 
- iio:trigger: rename try_reenable() to reenable() plus return void

on latest mainline (without PREEMPT_RT). The original WARN_ONCE() in
kernel/irq/handle.c:159 was not raised anymore. But even without the current
patches, this warning is not shown (as this problem only applies to -RT).

Currently I haven't ported a RT kernel > 5.4 for my board, so I cannot check
with current RT. On 5.4. there the patches seem not to work fully as 
kernel/timer/hrtimer.c is not up to date enough.

Sorry for being not very helpful...

Best regards
Christian

On Sunday, 20 September 2020, 20:15:45 CEST, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> As we no longer support a try again if we cannot reenable the trigger
> rename the function to reflect this.   Also we don't do anything with
> the value returned so stop it returning anything.  For the few drivers
> that didn't already print an error message in this patch, add such
> a print.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Christian Oder <me@myself5.de>
> Cc: Eugen Hristev <eugen.hristev@microchip.com>
> Cc: Nishant Malpani <nish.malpani25@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@oss.nxp.com>
> ---



