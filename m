Return-Path: <linux-iio+bounces-26278-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F60CC6874D
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 10:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 444CF2AB32
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 09:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7D1308F1F;
	Tue, 18 Nov 2025 09:13:10 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474F530E836
	for <linux-iio@vger.kernel.org>; Tue, 18 Nov 2025 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457190; cv=none; b=U3wMshl1Onbc6BOSnj3J7UqZeWFnx1+Oh6UVXwQv+o+trV1RLj2Df6r8JTGuDuTbULPglAiVCZwdUmB2fJU1LxFxoSFLGkLJe8DHUqRM9OJ7YGDruRo7LD9yXi0WfXuPYGt475A2m9/BNnqz0kahPV8vn4OVz51iJyeHWCoQeJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457190; c=relaxed/simple;
	bh=JY8g9+Iv96I59y5ev4BmnnuzHSlvp11V8wDFWmv8Pbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THQ4T7xzYdMHgZtS4p7F4iRFMznpdE/RnECRCthYLSJHUGo1lj7zmcddLiK6rRZy/HUuzZ2iGd13uZKW+b6m+fs+gm4iG7mv18fAERvluZUkqbZSzOfTxdrH2l0Mro3QZpKCio/oM2m/8kHL9J9RWQb+8gTupKdY+ERl3NoZjmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vLHli-00056w-O1; Tue, 18 Nov 2025 10:12:58 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vLHlg-0013co-2R;
	Tue, 18 Nov 2025 10:12:56 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vLHlg-00A9WL-1z;
	Tue, 18 Nov 2025 10:12:56 +0100
Date: Tue, 18 Nov 2025 10:12:56 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-iio@vger.kernel.org, Ahmad Fatoum <a.fatoum@pengutronix.de>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	William Breathitt Gray <wbg@kernel.org>
Subject: Re: [PATCH] counter: interrupt-cnt: Drop IRQF_NO_THREAD flag
Message-ID: <aRw4mIZpWdsr9exb@pengutronix.de>
References: <20251118083603.778626-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251118083603.778626-1-alexander.sverdlin@siemens.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

Hi Alexander,

On Tue, Nov 18, 2025 at 09:35:48AM +0100, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> An IRQ handler can either be IRQF_NO_THREAD or acquire spinlock_t, as
> CONFIG_PROVE_RAW_LOCK_NESTING warns:
> =============================
> [ BUG: Invalid wait context ]
> 6.18.0-rc1+git... #1
> -----------------------------
> some-user-space-process/1251 is trying to lock:
> (&counter->events_list_lock){....}-{3:3}, at: counter_push_event [counter]
> other info that might help us debug this:
> context-{2:2}
> no locks held by some-user-space-process/....
> stack backtrace:
> CPU: 0 UID: 0 PID: 1251 Comm: some-user-space-process 6.18.0-rc1+git... #1 PREEMPT
> Call trace:
>  show_stack (C)
>  dump_stack_lvl
>  dump_stack
>  __lock_acquire
>  lock_acquire
>  _raw_spin_lock_irqsave
>  counter_push_event [counter]
>  interrupt_cnt_isr [interrupt_cnt]
>  __handle_irq_event_percpu
>  handle_irq_event
>  handle_simple_irq
>  handle_irq_desc
>  generic_handle_domain_irq
>  gpio_irq_handler
>  handle_irq_desc
>  generic_handle_domain_irq
>  gic_handle_irq
>  call_on_irq_stack
>  do_interrupt_handler
>  el0_interrupt
>  __el0_irq_handler_common
>  el0t_64_irq_handler
>  el0t_64_irq
> 
> ... and Sebastian correctly points out. Remove IRQF_NO_THREAD as an
> alternative to switching to raw_spinlock_t, because the latter would limit
> all potential nested locks to raw_spinlock_t only.
> 
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/20251117151314.xwLAZrWY@linutronix.de/
> Fixes: a55ebd47f21f ("counter: add IRQ or GPIO based counter")
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
>  drivers/counter/interrupt-cnt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
> index 6c0c1d2d7027d..e6100b5fb082e 100644
> --- a/drivers/counter/interrupt-cnt.c
> +++ b/drivers/counter/interrupt-cnt.c
> @@ -229,8 +229,7 @@ static int interrupt_cnt_probe(struct platform_device *pdev)
>  
>  	irq_set_status_flags(priv->irq, IRQ_NOAUTOEN);
>  	ret = devm_request_irq(dev, priv->irq, interrupt_cnt_isr,
> -			       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
> -			       dev_name(dev), counter);
> +			       IRQF_TRIGGER_RISING, dev_name(dev), counter);
>  	if (ret)
>  		return ret;
>  

Hm, I guess it will break the requirement to handle at least 10kHz
interrupts. May be we should move only counter_push_event() to the
thread? or using delayed worker?

Right now I do not have needed system for testing to come with better
proposal.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

