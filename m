Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B44643061D
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 03:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244855AbhJQB6z (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Oct 2021 21:58:55 -0400
Received: from vern.gendns.com ([98.142.107.122]:48390 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244893AbhJQB6r (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Oct 2021 21:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qRC0A3Ueoyv+zoqErrv6IS9gEd/4WrGP0FipcWDXCLU=; b=de9TKt6uXudRmo0ZN9rICTrV7n
        fNdMyu86kCqcKjAmOmCTrzWtcuoN1BypHHuqdhxOuEn2n+Gr1DAHKhS/XZx9J1pq2hfqUCaNGpYtL
        +Mv+uwLsEDTp9j8JTGf9iVPZ+l4PNentrECTCLRZoN6DYYhuCfj6J7teMyiYntYAsTV+EJQ2NeKwv
        3PbO89saPH76+OqCO76q3fsE1arf4Fnv8lvgd9S/1lkV+7KORBpsSeMc/5N+jQw/tu8T4ifHSOwdF
        L8DdFBYzVHNYZFspMSG9bEKlQBee32bNf/X2/lu4kIEZmB+J9NNTDaipo9pWH8wNGQZe36AC8MXNX
        L8l1pAtw==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:41624 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1mbv44-0004D2-Cb; Sat, 16 Oct 2021 21:34:18 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-iio@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] counter/ti-eqep: implement over/underflow events
Date:   Sat, 16 Oct 2021 20:33:36 -0500
Message-Id: <20211017013343.3385923-2-david@lechnology.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211017013343.3385923-1-david@lechnology.com>
References: <20211017013343.3385923-1-david@lechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds support to the TI eQEP counter driver for subscribing to
overflow and underflow events using the counter chrdev interface.

Since this is the first event added, this involved adding an irq
handler. Also, additional range checks had to be added to the ceiling
attribute to avoid infinite interrupts.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/counter/ti-eqep.c | 119 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 117 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index 09817c953f9a..b7c79435e127 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -7,6 +7,7 @@
 
 #include <linux/bitops.h>
 #include <linux/counter.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -67,6 +68,44 @@
 #define QEPCTL_UTE		BIT(1)
 #define QEPCTL_WDE		BIT(0)
 
+#define QEINT_UTO		BIT(11)
+#define QEINT_IEL		BIT(10)
+#define QEINT_SEL		BIT(9)
+#define QEINT_PCM		BIT(8)
+#define QEINT_PCR		BIT(7)
+#define QEINT_PCO		BIT(6)
+#define QEINT_PCU		BIT(5)
+#define QEINT_WTO		BIT(4)
+#define QEINT_QDC		BIT(3)
+#define QEINT_PHE		BIT(2)
+#define QEINT_PCE		BIT(1)
+
+#define QFLG_UTO		BIT(11)
+#define QFLG_IEL		BIT(10)
+#define QFLG_SEL		BIT(9)
+#define QFLG_PCM		BIT(8)
+#define QFLG_PCR		BIT(7)
+#define QFLG_PCO		BIT(6)
+#define QFLG_PCU		BIT(5)
+#define QFLG_WTO		BIT(4)
+#define QFLG_QDC		BIT(3)
+#define QFLG_PHE		BIT(2)
+#define QFLG_PCE		BIT(1)
+#define QFLG_INT		BIT(0)
+
+#define QCLR_UTO		BIT(11)
+#define QCLR_IEL		BIT(10)
+#define QCLR_SEL		BIT(9)
+#define QCLR_PCM		BIT(8)
+#define QCLR_PCR		BIT(7)
+#define QCLR_PCO		BIT(6)
+#define QCLR_PCU		BIT(5)
+#define QCLR_WTO		BIT(4)
+#define QCLR_QDC		BIT(3)
+#define QCLR_PHE		BIT(2)
+#define QCLR_PCE		BIT(1)
+#define QCLR_INT		BIT(0)
+
 /* EQEP Inputs */
 enum {
 	TI_EQEP_SIGNAL_QEPA,	/* QEPA/XCLK */
@@ -233,12 +272,46 @@ static int ti_eqep_action_read(struct counter_device *counter,
 	}
 }
 
+static int ti_eqep_events_configure(struct counter_device *counter)
+{
+	struct ti_eqep_cnt *priv = counter->priv;
+	struct counter_event_node *event_node;
+	u32 qeint = 0;
+
+	list_for_each_entry(event_node, &counter->events_list, l) {
+		switch (event_node->event) {
+		case COUNTER_EVENT_OVERFLOW:
+			qeint |= QEINT_PCO;
+			break;
+		case COUNTER_EVENT_UNDERFLOW:
+			qeint |= QEINT_PCU;
+			break;
+		}
+	}
+
+	return regmap_write_bits(priv->regmap16, QEINT, ~0, qeint);
+}
+
+static int ti_eqep_watch_validate(struct counter_device *counter,
+				  const struct counter_watch *watch)
+{
+	switch (watch->event) {
+	case COUNTER_EVENT_OVERFLOW:
+	case COUNTER_EVENT_UNDERFLOW:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct counter_ops ti_eqep_counter_ops = {
 	.count_read	= ti_eqep_count_read,
 	.count_write	= ti_eqep_count_write,
 	.function_read	= ti_eqep_function_read,
 	.function_write	= ti_eqep_function_write,
 	.action_read	= ti_eqep_action_read,
+	.events_configure = ti_eqep_events_configure,
+	.watch_validate	= ti_eqep_watch_validate,
 };
 
 static int ti_eqep_position_ceiling_read(struct counter_device *counter,
@@ -260,11 +333,17 @@ static int ti_eqep_position_ceiling_write(struct counter_device *counter,
 					  u64 ceiling)
 {
 	struct ti_eqep_cnt *priv = counter->priv;
+	u32 qposmax = ceiling;
 
-	if (ceiling != (u32)ceiling)
+	/* ensure that value fits in 32-bit register */
+	if (qposmax != ceiling)
 		return -ERANGE;
 
-	regmap_write(priv->regmap32, QPOSMAX, ceiling);
+	/* protect against infinite overflow interrupts */
+	if (qposmax == 0)
+		return -EINVAL;
+
+	regmap_write(priv->regmap32, QPOSMAX, qposmax);
 
 	return 0;
 }
@@ -349,6 +428,25 @@ static struct counter_count ti_eqep_counts[] = {
 	},
 };
 
+static irqreturn_t ti_eqep_irq_handler(int irq, void *dev_id)
+{
+	struct ti_eqep_cnt *priv = dev_id;
+	struct counter_device *counter = &priv->counter;
+	u32 qflg;
+
+	regmap_read(priv->regmap16, QFLG, &qflg);
+
+	if (qflg & QFLG_PCO)
+		counter_push_event(counter, COUNTER_EVENT_OVERFLOW, 0);
+
+	if (qflg & QFLG_PCU)
+		counter_push_event(counter, COUNTER_EVENT_UNDERFLOW, 0);
+
+	regmap_set_bits(priv->regmap16, QCLR, ~0);
+
+	return IRQ_HANDLED;
+}
+
 static const struct regmap_config ti_eqep_regmap32_config = {
 	.name = "32-bit",
 	.reg_bits = 32,
@@ -371,6 +469,7 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	struct ti_eqep_cnt *priv;
 	void __iomem *base;
 	int err;
+	int irq;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -390,6 +489,15 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->regmap16))
 		return PTR_ERR(priv->regmap16);
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	err = devm_request_threaded_irq(dev, irq, NULL, ti_eqep_irq_handler,
+					IRQF_ONESHOT, dev_name(dev), priv);
+	if (err < 0)
+		return err;
+
 	priv->counter.name = dev_name(dev);
 	priv->counter.parent = dev;
 	priv->counter.ops = &ti_eqep_counter_ops;
@@ -409,6 +517,13 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
+	/*
+	 * We can end up with an interupt infinite loop (interrupts triggered
+	 * as soon as they are cleared) if we leave this at the default value
+	 * of 0 and events are enabled.
+	 */
+	regmap_write(priv->regmap32, QPOSMAX, UINT_MAX);
+
 	err = counter_register(&priv->counter);
 	if (err < 0) {
 		pm_runtime_put_sync(dev);
-- 
2.25.1

