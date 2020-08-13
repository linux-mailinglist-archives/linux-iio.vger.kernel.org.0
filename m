Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7080224375D
	for <lists+linux-iio@lfdr.de>; Thu, 13 Aug 2020 11:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHMJLL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Aug 2020 05:11:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57260 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgHMJLK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Aug 2020 05:11:10 -0400
Date:   Thu, 13 Aug 2020 11:11:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597309868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u1ofwUaJfXVsst7xInv3rmQwnZTyXPn3unh704usPlo=;
        b=FJoRXef3OEKb7xAJrnSs0JzII2EUTbrAS6jQHTVQSyfAfvWuzQ+5Igp8S93PR165gTojC8
        hPsJgPN8B9ErHfUOl41p5MAklaPTVyv8Zp7Sz9TLWhhLtjeHEGKwkfaZtiP0Tr2iV/0FaQ
        E1gI11ztRu0TAysNAOIJl4d/cGiRqFFcYGfl6kSeiOMjzOirYAqov2hizP7G492x0rV02E
        kj7d03kMbClTMq66t6/r7hhczx7B9hI7zUVOlEOb/QaGpFS3RWFiI09xy3qsaanji3o6Bg
        0/4+2kufcYDUVKHJ/6cfWxOjB3/Ca2u2MDbJfa6OcRtjidYoaan3c+KdNi0xlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597309868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u1ofwUaJfXVsst7xInv3rmQwnZTyXPn3unh704usPlo=;
        b=3DLbnarHbbIv7ASm6wob7RPP8forJCZjV+0vavYBSkBFb+kjuh2xoEPGM2do0c3L7V5PVR
        Rp17zoQmBz4tBpDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Christian Eggers <ceggers@arri.de>, linux-iio@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH 1/2] iio: hrtimer-trigger: Mark hrtimer to expire in hard
 interrupt context
Message-ID: <20200813091107.kjelslak2jxkkc42@linutronix.de>
References: <20200813075358.13310-1-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200813075358.13310-1-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2020-08-13 09:53:57 [+0200], Lars-Peter Clausen wrote:
> On PREEMPT_RT enabled kernels unmarked hrtimers are moved into soft
> interrupt expiry mode by default.
> 
> The IIO hrtimer-trigger needs to run in hard interrupt context since it
> will end up calling generic_handle_irq() which has the requirement to run
> in hard interrupt context.
> 
> Explicitly specify that the timer needs to run in hard interrupt context by
> using the HRTIMER_MODE_REL_HARD flag.

No, I don't think that this is good. It basically renders threaded-irqs
in context of IIO useless. This also requires that the IRQ-handler in
question runs with IRQs disabled / uses raw_spinlock_t which is in not
good idea either.

Has this change (including the second patch in thread) been tested on RT
in terms of locking and latency?

> Fixes: f5c2f0215e36 ("hrtimer: Move unmarked hrtimers to soft interrupt expiry on RT")
> Reported-by: Christian Eggers <ceggers@arri.de>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/iio/trigger/iio-trig-hrtimer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/trigger/iio-trig-hrtimer.c b/drivers/iio/trigger/iio-trig-hrtimer.c
> index f59bf8d58586..b11ca915fcb2 100644
> --- a/drivers/iio/trigger/iio-trig-hrtimer.c
> +++ b/drivers/iio/trigger/iio-trig-hrtimer.c
> @@ -132,7 +132,7 @@ static struct iio_sw_trigger *iio_trig_hrtimer_probe(const char *name)
>  	trig_info->swt.trigger->ops = &iio_hrtimer_trigger_ops;
>  	trig_info->swt.trigger->dev.groups = iio_hrtimer_attr_groups;
>  
> -	hrtimer_init(&trig_info->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +	hrtimer_init(&trig_info->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
>  	trig_info->timer.function = iio_hrtimer_trig_handler;
>  
>  	trig_info->sampling_frequency = HRTIMER_DEFAULT_SAMPLING_FREQUENCY;

Sebastian
