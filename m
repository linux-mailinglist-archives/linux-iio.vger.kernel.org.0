Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E802B6000
	for <lists+linux-iio@lfdr.de>; Tue, 17 Nov 2020 14:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbgKQNDF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Nov 2020 08:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbgKQNDF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Nov 2020 08:03:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30885C0613CF
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2020 05:03:05 -0800 (PST)
Date:   Tue, 17 Nov 2020 14:03:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605618183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zgcmkizIMeLfyDaY1D8XSGkBxQGtyBw+c/q0Z92cTEc=;
        b=cE13TM9BT3docm1OxpKwaAqqBT6G9j3/4qznTCEd7Wlw6Gy9vTzxsgi+9nTs/xCU8vXPrY
        SxStrGfH0u4HBtQYlsyjPVJx3Fvz/EZgDJ36Kw3qb3boFE6Y5FYQPYAgGTfVRYpDxp/4S1
        oskeUi339ac4WaSk0pOUFoyV9DAu+k/byItF5nyyLi1Lf01PF3XpqwQmCd5GQfvmfcXc/K
        sKOIt1xMFptZlIDOTRCsDB0wR4p5Jjif4jeOZ2M9I4rEmuAECQQiHNu2RhCShJ158tFp9I
        xO1rnbMFcLHfGdybfnRZdulmkNKnQ2wFOb4BvWrPPoHm0aS4ipbLNLujLuIziA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605618183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zgcmkizIMeLfyDaY1D8XSGkBxQGtyBw+c/q0Z92cTEc=;
        b=TqIiT2D+gaezfrEHYLfLClCHAPDtjhy06++ioUiR7sWzUmZPjV2AyaIwOr1m9MepyAt4XJ
        flsHrS6rNapWrNAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Christian Eggers <ceggers@arri.de>,
        Thomas Gleixner <tglx@linutronix.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: hrtimer-trigger: Mark hrtimer to expire in
 hard interrupt context
Message-ID: <20201117130301.724ybjgrqdlgfpxq@linutronix.de>
References: <20201117103751.16131-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201117103751.16131-1-lars@metafoo.de>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2020-11-17 11:37:50 [+0100], Lars-Peter Clausen wrote:
> On PREEMPT_RT enabled kernels unmarked hrtimers are moved into soft
> interrupt expiry mode by default.
> 
> The IIO hrtimer-trigger needs to run in hard interrupt context since it
> will end up calling generic_handle_irq() which has the requirement to run
> in hard interrupt context.
> 
> Explicitly specify that the timer needs to run in hard interrupt context by
> using the HRTIMER_MODE_REL_HARD flag.
> 
> Fixes: f5c2f0215e36 ("hrtimer: Move unmarked hrtimers to soft interrupt expiry on RT")
> Reported-by: Christian Eggers <ceggers@arri.de>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

If I remember correctly, this routine should only be used to poll the
primary handler. There were patches for the "other" possible things that
might happen so

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

for both.

Sebastian
