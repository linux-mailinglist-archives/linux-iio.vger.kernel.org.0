Return-Path: <linux-iio+bounces-26283-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E56F1C68DB6
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 11:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 4A1712AA4A
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 10:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AC2343D8A;
	Tue, 18 Nov 2025 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F8oHLuGA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qVDb6tv/"
X-Original-To: linux-iio@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A0B346E4C;
	Tue, 18 Nov 2025 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763461828; cv=none; b=ZqOqWwXt3JTAcGyHSZaWuQNI+1+KUko7YH65G4pV9VcegFsSe8BVCukvqd07JROcJXC70SQV9tyau7ax43n+nlBmU4WAGxyHp4QnLf0syJdvFyFC/sRVMa2pFsowpuUZ7zZ0Fcu346wgSL5m58beYY1UnC5QpoYS56DEK1vLSXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763461828; c=relaxed/simple;
	bh=byCrX0eQkLFdGGy7c64agpdOAecHHq27PAIo3HB0P6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rae4F3kGR2BVikH6hfXjfvAsRNlDZ1m+QPlUBiVxViGDBxNNYdvdL8c9nqM+uyFzeB1drrnAEGEMChfwOtHJdhh43/1bsHO24V+j6SOnN3JN8OHek3tnEXUhe23R5G92uuHmWFJoY9l16Wl9yz6az/DzgI+dJb9TDfE0FiX9mcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F8oHLuGA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qVDb6tv/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Nov 2025 11:30:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763461823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/PXxhzl5P2ZgPyxLJkLxuOMSgUgRbZTFJJj5rKiSnw=;
	b=F8oHLuGA7oo3EnhvD8VPIfJaYpPXvOLbAeEBi25BSsnfvrto+HmmstasfvusshAUy2IqrZ
	PZ0oAKinKAwEl+Yz8ktcmOJmAQZLlBaur6+hxunF23PmHwnFKSvWx0i3qNaEmnRWJ3zDgk
	oLjZCwm97cShG7vXEO/y6UiS3czKyF9fIqtLCVCQyuitq1B4YRakvLwzqGrJUMZqGOHeUm
	chizflFLPVaEodDwnRxHRni98qcbB5A5vsIduy5TMvIysIqmnW7JiQV8gPHemLp5A6hh26
	+k1YJGNckwrYhwuLBQJ4nQeQx7t4R4jl53uOS7h5tyGlYKZ6+hfOZXYbJW8mUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763461823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/PXxhzl5P2ZgPyxLJkLxuOMSgUgRbZTFJJj5rKiSnw=;
	b=qVDb6tv/YgGbvE/zkmel7mpNO7m3hhprFW56uIcX+uwq9a80m30qdYMPF8F+QiU3nnqjV5
	X1SvCyTtzxTeocAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-iio@vger.kernel.org, William Breathitt Gray <wbg@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] counter: interrupt-cnt: Drop IRQF_NO_THREAD flag
Message-ID: <20251118103022.1FY-iKhs@linutronix.de>
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

On 2025-11-18 09:35:48 [+0100], A. Sverdlin wrote:
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

I would recommend to trim the commit message to what is required in
terms of describing the problem you faced. This backtrace contains a lot
noise and is not relevant.
The problem is that IRQF_NO_THREAD does not allow threading the
interrupt handler. Using spinlock_t in non-threaded (atomic) context is
not allowed and is reported by lockdep.

> ... and Sebastian correctly points out. Remove IRQF_NO_THREAD as an
> alternative to switching to raw_spinlock_t, because the latter would limit
> all potential nested locks to raw_spinlock_t only.
Correct.

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/all/20251117151314.xwLAZrWY@linutronix.de/
> Fixes: a55ebd47f21f ("counter: add IRQ or GPIO based counter")
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

Sebastian

