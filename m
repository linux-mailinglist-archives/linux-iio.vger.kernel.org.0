Return-Path: <linux-iio+bounces-26566-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9471FC95026
	for <lists+linux-iio@lfdr.de>; Sun, 30 Nov 2025 14:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7683E343188
	for <lists+linux-iio@lfdr.de>; Sun, 30 Nov 2025 13:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00938221F11;
	Sun, 30 Nov 2025 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vA4CIQsX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7952186A;
	Sun, 30 Nov 2025 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764511049; cv=none; b=QCmKSO+aJ0ggxAGCQteHjP0oHp+cOj3zg49OuPN7NIoK8uGQhajHck2BjApD1anyT/0rW9WbtPU/e5iqdUdPAIP5VmwZVsN4DIjoYQNBiaG99p6KNn3gDc0yMKgI3sQ4dOYp6flAfVND7/4JuzW5PAeIaGTEla5UaKkoM9Eb+ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764511049; c=relaxed/simple;
	bh=ZB0aNDoJbR7KCgkbpMsgbU9QCSi+qeVI22J87/0V+f8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aOHFLCvIzVUMZpUa//0oSdertBa8ZMC6qIJdlaR5gWFfkWZxFI7JgH6UxSlZs20h9kPwcyNKB7P3gHfYc4Wf2s4VYdC+79LYzOIIUQ97xVuz4SYo6jUCFRdLwr0lar2/SE8q/aYzGsV3LXENzzWcAAHV8/xodT57XmvW041Z8P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vA4CIQsX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCECC4CEF8;
	Sun, 30 Nov 2025 13:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764511049;
	bh=ZB0aNDoJbR7KCgkbpMsgbU9QCSi+qeVI22J87/0V+f8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vA4CIQsXW1L4TO5BVfBXEVECIfMvTvMFKYI34kOyc3emtoWAm3b4Nw3DjkNLvg7wU
	 hRh97yqTAgV39W29gpbrKLJJQnrzMHa4lCgaulS1VQ6PLRzexV1ft7Fp5Zt4XJ2sT3
	 jpSMidlm6qn7jYdM46Zfrv1KVJEtX8cumCQb5EMPrsx6HXX2NwQQrFn+sTWm8nS7jl
	 YWLXgvrZUNknYQl3lX0ofcdFAdcKHBS7Ydx/AMRHmc87OlcV5Uc4Zw7pB/XeDq8iY8
	 DKfxleei0pZeyMGlu/aUA/KPQRJY73EGgjo5qY0aRr2KwdOtZpi5pqxo3BDIau5wkU
	 kDgIqprbhR62A==
From: William Breathitt Gray <wbg@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-iio@vger.kernel.org,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: William Breathitt Gray <wbg@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	stable@vger.kernel.org
Subject: Re: [PATCH] counter: interrupt-cnt: Drop IRQF_NO_THREAD flag
Date: Sun, 30 Nov 2025 22:57:15 +0900
Message-ID: <176451098931.9836.4127167335264943589.b4-ty@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251118083603.778626-1-alexander.sverdlin@siemens.com>
References: <20251118083603.778626-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1397; i=wbg@kernel.org; h=from:subject:message-id; bh=Ivzz5NMzZaBZSReLzEG+Clk4t6mpdj6JIAG6CCrrIDc=; b=owGbwMvMwCW21SPs1D4hZW3G02pJDJk6viZaHmnftkhuu2LJZsYUsNpEWYSjyy9h+vszi0+KK OeV/1/XUcrCIMbFICumyNJrfvbug0uqGj9ezN8GM4eVCWQIAxenAExk8gKGfwr3T3BfcFz72F9q flPkq/ua8+XmOX7eoL07k0FCbfnHj5WMDGf8VJ6p5Z9dpCnGXXTbNd/jwYm9z7YwBCyyTJCekMF XxAwA
X-Developer-Key: i=wbg@kernel.org; a=openpgp; fpr=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
Content-Transfer-Encoding: 8bit


On Tue, 18 Nov 2025 09:35:48 +0100, A. Sverdlin wrote:
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
> [...]

Applied, thanks!

[1/1] counter: interrupt-cnt: Drop IRQF_NO_THREAD flag
      commit: 1ea0a54c0a1fac796b133253804e392cb44068c8

Best regards,
-- 
William Breathitt Gray <wbg@kernel.org>

