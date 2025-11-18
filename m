Return-Path: <linux-iio+bounces-26281-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B117C68A95
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 10:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FF264F0EA1
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 09:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4237B3074B3;
	Tue, 18 Nov 2025 09:54:51 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEEF2EA743
	for <linux-iio@vger.kernel.org>; Tue, 18 Nov 2025 09:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763459691; cv=none; b=j/NhdUV6j1wrVVjpKFjUlUzcnQTKymWojHhC2l+kx2xL+v2mcqoBhDQqk3AsCz1Xmok7bLWgJvj1v2cF6zSbygyJ8FXXAKilnfPMGMhxKtlNg7dpR4vPW3RPJ7IA4anMYVYJRtz6fOmDlI0I3MBPYyNql2rSgG1i9/itPhk70FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763459691; c=relaxed/simple;
	bh=04lIDrwEueqoNF1FBuMpRNyxK8Qa6McA1a3QAb2yqGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnKNUbVupw1UHvEMbUCKXaIegapLpVAie4I6EAFtrLdrBy/FyiN0iDwSiJ2s+4GCWp7CUgabuAFU9BkjPefFPpC/RkKBf1KymCHWpuPwX82tuJIcoiniY1dqdIbTaQKcYrHTkF3DfFtHsJe10uJdk2An7zOa9syNMfvikSecXUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vLIPe-0002Fj-NI; Tue, 18 Nov 2025 10:54:14 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vLIPd-0013pp-2g;
	Tue, 18 Nov 2025 10:54:13 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vLIPd-00AAvN-2F;
	Tue, 18 Nov 2025 10:54:13 +0100
Date: Tue, 18 Nov 2025 10:54:13 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"wbg@kernel.org" <wbg@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"paulmck@kernel.org" <paulmck@kernel.org>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] counter: interrupt-cnt: Drop IRQF_NO_THREAD flag
Message-ID: <aRxCRT-giHoZxaGU@pengutronix.de>
References: <20251118083603.778626-1-alexander.sverdlin@siemens.com>
 <aRw4mIZpWdsr9exb@pengutronix.de>
 <c23143c9edb2444e145849d46794d580715eeb8f.camel@siemens.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c23143c9edb2444e145849d46794d580715eeb8f.camel@siemens.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

On Tue, Nov 18, 2025 at 09:51:02AM +0000, Sverdlin, Alexander wrote:
> Hi Oleksij!
> 
> On Tue, 2025-11-18 at 10:12 +0100, Oleksij Rempel wrote:
> > > An IRQ handler can either be IRQF_NO_THREAD or acquire spinlock_t, as
> > > CONFIG_PROVE_RAW_LOCK_NESTING warns:
> > > =============================
> > > [ BUG: Invalid wait context ]
> > > 6.18.0-rc1+git... #1
> > > -----------------------------
> > > some-user-space-process/1251 is trying to lock:
> > > (&counter->events_list_lock){....}-{3:3}, at: counter_push_event [counter]
> > > other info that might help us debug this:
> > > context-{2:2}
> > > no locks held by some-user-space-process/....
> > > stack backtrace:
> > > CPU: 0 UID: 0 PID: 1251 Comm: some-user-space-process 6.18.0-rc1+git... #1 PREEMPT
> > > Call trace:
> > >   show_stack (C)
> > >   dump_stack_lvl
> > >   dump_stack
> > >   __lock_acquire
> > >   lock_acquire
> > >   _raw_spin_lock_irqsave
> > >   counter_push_event [counter]
> > >   interrupt_cnt_isr [interrupt_cnt]
> > >   __handle_irq_event_percpu
> > >   handle_irq_event
> > >   handle_simple_irq
> > >   handle_irq_desc
> > >   generic_handle_domain_irq
> > >   gpio_irq_handler
> > >   handle_irq_desc
> > >   generic_handle_domain_irq
> > >   gic_handle_irq
> > >   call_on_irq_stack
> > >   do_interrupt_handler
> > >   el0_interrupt
> > >   __el0_irq_handler_common
> > >   el0t_64_irq_handler
> > >   el0t_64_irq
> > > 
> > > ... and Sebastian correctly points out. Remove IRQF_NO_THREAD as an
> > > alternative to switching to raw_spinlock_t, because the latter would limit
> > > all potential nested locks to raw_spinlock_t only.
> > > 
> > > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > Cc: stable@vger.kernel.org
> > > Link: https://lore.kernel.org/all/20251117151314.xwLAZrWY@linutronix.de/
> > > Fixes: a55ebd47f21f ("counter: add IRQ or GPIO based counter")
> > > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> > > ---
> > >   drivers/counter/interrupt-cnt.c | 3 +--
> > >   1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
> > > index 6c0c1d2d7027d..e6100b5fb082e 100644
> > > --- a/drivers/counter/interrupt-cnt.c
> > > +++ b/drivers/counter/interrupt-cnt.c
> > > @@ -229,8 +229,7 @@ static int interrupt_cnt_probe(struct platform_device *pdev)
> > >   
> > >   	irq_set_status_flags(priv->irq, IRQ_NOAUTOEN);
> > >   	ret = devm_request_irq(dev, priv->irq, interrupt_cnt_isr,
> > > -			       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
> > > -			       dev_name(dev), counter);
> > > +			       IRQF_TRIGGER_RISING, dev_name(dev), counter);
> > >   	if (ret)
> > >   		return ret;
> > >   
> > 
> > Hm, I guess it will break the requirement to handle at least 10kHz
> > interrupts. May be we should move only counter_push_event() to the
> > thread? or using delayed worker?
> > 
> > Right now I do not have needed system for testing to come with better
> > proposal.
> 
> I thought about possible performance implications of the patch.
> But the performance regression would happen only with PREEMPT_RT.
> However, it must have been broken (and by that I mean really broken, like
> "scheduling in atomic") from the very beginning in PREEMPT_RT and
> I suppose your initial tests were performed not with PREEMPT_RT kernel.

Ack.

> So overall there shall be no possible performance regression in reality.

Ok, thank you!

Reviewed-by: Oleksij Rempel <o.rempel@pengutronix.de>

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

