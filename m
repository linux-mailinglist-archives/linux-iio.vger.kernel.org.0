Return-Path: <linux-iio+bounces-17481-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 065F3A76B22
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 17:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8C53B8A8C
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 15:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921751E5205;
	Mon, 31 Mar 2025 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="SDPlOkqA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B8E2147F2
	for <linux-iio@vger.kernel.org>; Mon, 31 Mar 2025 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743435220; cv=none; b=CSKJEiQBl+Ql22bGd9L3SjmyzYrlaKLo6xx6GfGZwgMSQlDnsK4x7iX1+jyIBmH0P1BfDdcVX09hQeW6eHlsqe4LrQ1MnoNDFLvMuP59YX5wu7Ll5h0jiIRMZfhLsmV7MYsQwmHX84rTvFABmWQssOuVGsDDjM+AtwWoyZ+FOE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743435220; c=relaxed/simple;
	bh=5SJWYCfWk1YAL1IX0C4+dCsC9NHMJGkuSl9toM7Vr5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NkjfOhMWLfc0qj6EZ0FHpD2b+GC8B3dljXsbN6fPNTVNoDvO/TyQyWuRwIZrzNR7vYXq8GZXBctJY/l3HlvXsruvYvF+h07FC8eYQRUfCEJMoMOgh/XKyV8eg5qwbe2UtLovupNos40a62bKmF6a4TCi5P8V7xn3GGZ6n72sJ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=SDPlOkqA; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202503311523247c08bb06d152883801
        for <linux-iio@vger.kernel.org>;
        Mon, 31 Mar 2025 17:23:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=7eiwFnwUgBmbRD9IxiOhHWh5SQuTCyH/HvCBFO7xT2A=;
 b=SDPlOkqAmIbLZR8Q3Hc0o5FlY/yggf6aGrdk/5RXn+qgO5oqAnwOWAjo+fb6C99fU9lW1n
 iY9VXgRQHqsGnxtXtmJZPZMoHrDbRspmDYchk97f4213cxU7mgqHLcL9D88jHF6GKnuxyYzF
 4Wcop+VU3AREHloJw8rFnyj8y65mJkIz6u0yM0l3JT+3YVZAjZ2qP9p/H18BlOI5fNXEam0Y
 l7rBv9wJg3LVSXMKnQLsfRjiT3ZN38lsQIeduEoIET880wkCnOSLbfc29KY4fohJIVMwBL2x
 4s6W/n+Zmu1N9/qVKjDGkB3j7UVmi/awvKtrpC/CfECYn+ExkTFBgTWg==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: linux-iio@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	William Breathitt Gray <wbg@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] counter: interrupt-cnt: Convert atomic_t -> atomic_long_t
Date: Mon, 31 Mar 2025 17:22:20 +0200
Message-ID: <20250331152222.2263776-1-alexander.sverdlin@siemens.com>
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

Convert the internal counter type to atomic_long_t, which:
- doesn't change much for existing in-tree users as they are 32-bit anyway
  (stm32/i.MX6)
- doesn't introduce performace penalty on 32-bit platforms
- provides 64-bit resolution on 64-bit platforms with virtually no
  preformance penalty

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/counter/interrupt-cnt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/counter/interrupt-cnt.c b/drivers/counter/interrupt-cnt.c
index 949598d51575a..8df5457b0a076 100644
--- a/drivers/counter/interrupt-cnt.c
+++ b/drivers/counter/interrupt-cnt.c
@@ -15,7 +15,7 @@
 #define INTERRUPT_CNT_NAME "interrupt-cnt"
 
 struct interrupt_cnt_priv {
-	atomic_t count;
+	atomic_long_t count;
 	struct gpio_desc *gpio;
 	int irq;
 	bool enabled;
@@ -29,7 +29,7 @@ static irqreturn_t interrupt_cnt_isr(int irq, void *dev_id)
 	struct counter_device *counter = dev_id;
 	struct interrupt_cnt_priv *priv = counter_priv(counter);
 
-	atomic_inc(&priv->count);
+	atomic_long_inc(&priv->count);
 
 	counter_push_event(counter, COUNTER_EVENT_CHANGE_OF_STATE, 0);
 
@@ -89,7 +89,7 @@ static int interrupt_cnt_read(struct counter_device *counter,
 {
 	struct interrupt_cnt_priv *priv = counter_priv(counter);
 
-	*val = atomic_read(&priv->count);
+	*val = atomic_long_read(&priv->count);
 
 	return 0;
 }
@@ -102,7 +102,7 @@ static int interrupt_cnt_write(struct counter_device *counter,
 	if (val != (typeof(priv->count.counter))val)
 		return -ERANGE;
 
-	atomic_set(&priv->count, val);
+	atomic_long_set(&priv->count, val);
 
 	return 0;
 }
-- 
2.49.0


