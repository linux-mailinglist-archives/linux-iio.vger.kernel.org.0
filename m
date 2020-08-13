Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF3A243954
	for <lists+linux-iio@lfdr.de>; Thu, 13 Aug 2020 13:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgHML1p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 13 Aug 2020 07:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgHML1o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Aug 2020 07:27:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE96C061757
        for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2020 04:27:44 -0700 (PDT)
Date:   Thu, 13 Aug 2020 13:27:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597318063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CFP3PIp6DHRFBywTyc+gcTV8pYXmkO76zYTsiYYkL4c=;
        b=xT5DWhjRD4t2jnTG9cG3/PKmLFoB307AuJDGdfef8gLO+lUwd7hVHwPJIcFAHr8fwfCIry
        JQv8c4S0LM+a59jQG6D3mrQM5CbZcMQ9HeaIyjxTdbQYzujE4fdqMX2MNJXwD/LIzPS+Xp
        5X8bj9n3mYqNmm+9OKYbk3qGPjQ1j8CT5y+s167alGEi8ig1R7CaxxOq102fCjm7UI3p2c
        a/lkORvaBQ70nO6UFJfw9e+QAB2GfQaJy2UE+mPcd60nwlha9zQ/0GvCd8AQKrUJHt8Ri6
        nTtAEzUzmWrUpr8Wj8oe8C/o7tBjY9pInKKojZ7SOlXdAXk78R/MAFCg7NOKtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597318063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CFP3PIp6DHRFBywTyc+gcTV8pYXmkO76zYTsiYYkL4c=;
        b=LMPp1nnVbZhJmAYKMEKqw0o7QlJ76MUvNnSP1wCSuK9ctQauO5EgUJA4T9hPoTcKQKE2H8
        VPnhbjop4uMioaAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Christian Eggers <ceggers@arri.de>, linux-iio@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH 1/2] iio: hrtimer-trigger: Mark hrtimer to expire in hard
 interrupt context
Message-ID: <20200813112741.grdytusuwrlskpwa@linutronix.de>
References: <20200813075358.13310-1-lars@metafoo.de>
 <20200813091107.kjelslak2jxkkc42@linutronix.de>
 <930e6dc4-df6f-416b-0df3-dab7177af974@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <930e6dc4-df6f-416b-0df3-dab7177af974@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2020-08-13 11:46:30 [+0200], Lars-Peter Clausen wrote:
> 
> It should not affect the IRQ handlers of individual drivers. The hrtimer
> triggers acts like an IRQ chip and will call generic_handle_irq() to
> multiplex the interrupt handling onto all consumers. As far as I understand
> it there is a requirement that generic_handle_irq() is called in hard irq
> context, even with PREEMT_RT=y.

That is correct.

> If you are running with forced IRQ threads the only thing that will then
> happen in the actual hard IRQ context is the launching of the IRQ threads.
> Th e IRQ handler of the device driver will run in a threaded IRQ.

So if it is really just the wakeup of the IRQ-thread then it should be
okay.
One thing: iio_trigger_poll() may invoke iio_trigger_notify_done(). This
would invoke trig->ops->try_reenable callback if available.
I grepped and found
- bma180_trig_try_reen() 
  It appears to perform i2c_smbus_read_byte_data() and smbus sounds
  sleeping. I don't know if it attempts to acquire any spinlock_t but it
  will be wrong on RT.

- bmc150_accel_trig_try_reen()
  This one has mutex_lock() which is wrong even on !RT in this context
  (unless the previous `if' saves us).

- mxc4005_trigger_try_reen()
  This one uses regmap_write(). regmap internally uses a lock and the
  config does not disable / provide a lock. This means
  regmap_lock_mutex() is used (or regmap_lock_spinlock() in case of
  bus->fast_io but I doubt it with i2c).

Am I looking somehow wrong at this or did just nobody try the
combination of one of the three drivers here together with the hrtimer
trigger?

> > 
> > Has this change (including the second patch in thread) been tested on RT
> > in terms of locking and latency?
> 
> It has not been tested in terms of latency. But like I said if you are
> running with forced IRQ threads the effect should be minimal.
> 
> Without this patch there is an correctness issue when PREEMT_RT=y since
> generic_handle_irq() runs with interrupts on which breaks its internal
> assumptions.

I'm trying to understand the scope of the change. As I said above, if it
is just wakeup of the thread, then it is fine. I have memory of people
running iio drivers (or triggers) in hardirq-context for $reason and try
avoid something like this.

Sebastian
