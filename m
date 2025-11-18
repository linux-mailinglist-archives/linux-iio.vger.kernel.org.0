Return-Path: <linux-iio+bounces-26279-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8BBC6876E
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 10:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 944382A64C
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 09:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480FB30F932;
	Tue, 18 Nov 2025 09:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="aI27Mqaw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AB73112BD
	for <linux-iio@vger.kernel.org>; Tue, 18 Nov 2025 09:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457392; cv=none; b=tC42A4+uYEhlOzaBugzM1CoNGpM4XuWHi1U99s38RRrsWBLJP/p+rGOet/2MGvtvXDQCmbyCo0NAdbcL8gy/8m9AxD4T2vGESyvB6+pi6qEWttgVN4MXtedHRAUNPgkuHjFnhsvigfGDABo3FoKCWKep5q/AiiWOX+T7ctAdLas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457392; c=relaxed/simple;
	bh=HlvJh/d+H01RMGcaIajlUtWn0/55klvBZdKu9AtWwd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f+nojdlUIkIfPyuYf8mrtFL0BLadJXHxPXVb7oNapgwVzV3Js+WM/ftDKYQtrfGRRqoPumuHbkKrOP+r4nj18oGiB+p5hXtGLePfMXWnZav0nvi71wste5fNZpHFchb8D18GWgLhdfyLG+gUFumgcEbdEcOgoPEyq2ioBkOzwiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=aI27Mqaw; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20251118083607d89b452e7400020763
        for <linux-iio@vger.kernel.org>;
        Tue, 18 Nov 2025 09:36:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=N8PWbhNGE835ewlSJOR81Jz9u85SnjicOh3tRt55o+E=;
 b=aI27Mqaw7RFigT111R6iaEUr4MsS2aJ1nZLHD5bIOVh0MvO0UJnFM8mvfufuaLoXRx1ij4
 h+0KMWJv/4z2GCCmd2y6SkQn9Fj0AexzMkZV0upWSsrl7BhZoNwPTA2LcyV0hBPTm1hmjEc+
 uXgl10jTJ2n+KxHrY9FdTlBhG05CdWp4OnyJnoEOgbSlMzgls8tCGJ+SGxvY9XW5eLvbJPlu
 TpnsnLXPsSaQcOiiGmVliBaB51S1PfFOI5DhtLDRYyEalaf+5FqyYAa9shmmO0H8vWhNybIO
 r0KvyJzFCR4UDESVNvnfx5wZqlREgJy1w0nxaah2aK1IpiQ2UfwN9H/A==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-iio@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	William Breathitt Gray <wbg@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH] counter: interrupt-cnt: Drop IRQF_NO_THREAD flag
Date: Tue, 18 Nov 2025 09:35:48 +0100
Message-ID: <20251118083603.778626-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

An IRQ handler can either be IRQF_NO_THREAD or acquire spinlock_t, as
CONFIG_PROVE_RAW_LOCK_NESTING warns:
=============================
[ BUG: Invalid wait context ]
6.18.0-rc1+git... #1
-----------------------------
some-user-space-process/1251 is trying to lock:
(&counter->events_list_lock){....}-{3:3}, at: counter_push_event [counter]
other info that might help us debug this:
context-{2:2}
no locks held by some-user-space-process/....
stack backtrace:
CPU: 0 UID: 0 PID: 1251 Comm: some-user-space-process 6.18.0-rc1+git... #1 PREEMPT
Call trace:
 show_stack (C)
 dump_stack_lvl
 dump_stack
 __lock_acquire
 lock_acquire
 _raw_spin_lock_irqsave
 counter_push_event [counter]
 interrupt_cnt_isr [interrupt_cnt]
 __handle_irq_event_percpu
 handle_irq_event
 handle_simple_irq
 handle_irq_desc
 generic_handle_domain_irq
 gpio_irq_handler
 handle_irq_desc
 generic_handle_domain_irq
 gic_handle_irq
 call_on_irq_stack
 do_interrupt_handler
 el0_interrupt
 __el0_irq_handler_common
 el0t_64_irq_handler
 el0t_64_irq

... and Sebastian correctly points out. Remove IRQF_NO_THREAD as an
alternative to switching to raw_spinlock_t, because the latter would limit
all potential nested locks to raw_spinlock_t only.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20251117151314.xwLAZrWY@linutronix.de/
Fixes: a55ebd47f21f ("counter: add IRQ or GPIO based counter")
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/counter/interrupt-cnt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
index 6c0c1d2d7027d..e6100b5fb082e 100644
--- a/drivers/counter/interrupt-cnt.c
+++ b/drivers/counter/interrupt-cnt.c
@@ -229,8 +229,7 @@ static int interrupt_cnt_probe(struct platform_device *pdev)
 
 	irq_set_status_flags(priv->irq, IRQ_NOAUTOEN);
 	ret = devm_request_irq(dev, priv->irq, interrupt_cnt_isr,
-			       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
-			       dev_name(dev), counter);
+			       IRQF_TRIGGER_RISING, dev_name(dev), counter);
 	if (ret)
 		return ret;
 
-- 
2.51.1


