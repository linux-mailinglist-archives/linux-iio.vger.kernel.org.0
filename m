Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663B12723DF
	for <lists+linux-iio@lfdr.de>; Mon, 21 Sep 2020 14:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgIUM1b (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Sep 2020 08:27:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51518 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgIUM1b (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Sep 2020 08:27:31 -0400
Date:   Mon, 21 Sep 2020 14:27:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600691250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R9oR2AcUU2p21/m9XVlzisuiwJE37zWCmqlPRb24xLA=;
        b=VRHaPrwU34aPWJVE2LtUhc75MUt23Pt0BkTfSFw0egN9mb4Ql9+Ah138eRPU3zQwERa6Om
        1YvRpC2sK6tE6q+8gzXxsP2HiiPQwyMOlDq5yh+kiPiCR2n94+QvW8kwmlS+vgyzTFWIkm
        6IdUVGWglqj8vceH5PAs+MhHmK6iw3vLNJgl1+xIMUVcMLWgnswuMBTUFFn7cR/UF5/vIw
        xg79c2UTWi/6BRFfiQbpG/3d+y69QirzqSZ4zQJBTePA8v8Xz1TUCB2ogaDUwBjM0T8BMU
        R/OXvF2EadCCd0DgqOOZT2KHxe96gH853Hf53hdFtAHaNExGzHVxQYwL5OpUZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600691250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R9oR2AcUU2p21/m9XVlzisuiwJE37zWCmqlPRb24xLA=;
        b=30ak4LWr+0KUpTVRgGvm5fYNiPrfzl7xQTONaBTrZ/pVmG6BEPOae45Q17Ehn6tSWlQVK9
        d34ydAUa1EPQdtAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Christian Eggers <ceggers@arri.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: hrtimer-trigger: Mark hrtimer to expire in hard
 interrupt context
Message-ID: <20200921122728.xaamqfkt5wrbppuy@linutronix.de>
References: <20200813075358.13310-1-lars@metafoo.de>
 <20200814113008.00002733@Huawei.com>
 <20200920191545.4ed79276@archlinux>
 <5007153.c9bsiqU2ZW@n95hx1g2>
 <20200921105703.000048b3@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200921105703.000048b3@Huawei.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2020-09-21 10:57:03 [+0100], Jonathan Cameron wrote:
> So looking at this the other way, are there any significant risks associated
> with this change?  If not I'm tempted to queue them up and we have the rcX
> time to fix anything we've missed (just like every other patch!)

I've been told that it only performs IRQ-thread wake-ups in hard-IRQ
context. This is fine then.

Looking at the other series where ->try_renable() got renamed. It still
looks like bmc150_accel_trig_try_reen() may acquire a mutex. Is it still
the case or do I miss something essential?

> Jonathan

Sebastian
