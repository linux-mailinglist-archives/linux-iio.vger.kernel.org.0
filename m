Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C079743060D
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 03:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244817AbhJQB6N (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 16 Oct 2021 21:58:13 -0400
Received: from vern.gendns.com ([98.142.107.122]:48318 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235366AbhJQB6M (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Oct 2021 21:58:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eg3PSBzSaLZdxDSxvMTx8Ko3kMWj/4TAV4PDzuDIlOo=; b=Uv9YHvk+CgvDqLY7JrxFS4iwuu
        NTihF2NUnOgx64H4zbdoK2sBy/X7X6qPxRRBeu1KWCVwJtXMxTHbPPoTIk8VmLoiSswErZ5UJ7x60
        ej5EUH5qqUomrxKQplFq8oTJs4ve1R4fqYp1sfYmcvNb12ea9FPsOD+qfz+O2fX/0/a9mck2FgnEp
        thsCm9BCwDWxHOCdG8FAWP98ZkGzUIKv4mjbcCEi0YN4TNvAs23Ms1Xs7YiSFajbegC438Le2n0Ms
        +jOIGR9PyaQ5cc/9fBcXEVrBFRLxvifRKEPDvYYBEgEH1foHCX86ALb7YJVP65pVUSPdRBHt7NMHF
        4vYvvxdQ==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:41624 helo=freyr.lechnology.com)
        by vern.gendns.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <david@lechnology.com>)
        id 1mbv45-0004D2-T4; Sat, 16 Oct 2021 21:34:19 -0400
From:   David Lechner <david@lechnology.com>
To:     linux-iio@vger.kernel.org
Cc:     David Lechner <david@lechnology.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] counter/ti-eqep: add support for unit timer
Date:   Sat, 16 Oct 2021 20:33:38 -0500
Message-Id: <20211017013343.3385923-4-david@lechnology.com>
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

This adds support to the TI eQEP counter driver for the Unit Timer.
The Unit Timer is a device-level extension that provides a timer to be
used for speed calculations. The sysfs interface for the Unit Timer is
new and will be documented in a later commit. It contains a R/W time
attribute for the current time, a R/W period attribute for the timeout
period and a R/W enable attribute to start/stop the timer. It also
implements a timeout event on the chrdev interface that is triggered
each time the period timeout is reached.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/counter/ti-eqep.c    | 132 ++++++++++++++++++++++++++++++++++-
 include/uapi/linux/counter.h |   2 +
 2 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index 9881e5115da6..a4a5a4486329 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/clk.h>
 #include <linux/counter.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -131,6 +132,7 @@ enum ti_eqep_count_func {
 
 struct ti_eqep_cnt {
 	struct counter_device counter;
+	unsigned long sysclkout_rate;
 	struct regmap *regmap32;
 	struct regmap *regmap16;
 };
@@ -298,6 +300,9 @@ static int ti_eqep_events_configure(struct counter_device *counter)
 		case COUNTER_EVENT_DIRECTION_CHANGE:
 			qeint |= QEINT_QDC;
 			break;
+		case COUNTER_EVENT_TIMEOUT:
+			qeint |= QEINT_UTO;
+			break;
 		}
 	}
 
@@ -311,6 +316,7 @@ static int ti_eqep_watch_validate(struct counter_device *counter,
 	case COUNTER_EVENT_OVERFLOW:
 	case COUNTER_EVENT_UNDERFLOW:
 	case COUNTER_EVENT_DIRECTION_CHANGE:
+	case COUNTER_EVENT_TIMEOUT:
 		return 0;
 	default:
 		return -EINVAL;
@@ -457,6 +463,106 @@ static struct counter_count ti_eqep_counts[] = {
 	},
 };
 
+static int ti_eqep_unit_timer_time_read(struct counter_device *counter,
+				       u64 *value)
+{
+	struct ti_eqep_cnt *priv = counter->priv;
+	u32 qutmr;
+
+	regmap_read(priv->regmap32, QUTMR, &qutmr);
+
+	/* convert timer ticks to nanoseconds */
+	*value = mul_u64_u32_div(qutmr, NSEC_PER_SEC, priv->sysclkout_rate);
+
+	return 0;
+}
+
+static int ti_eqep_unit_timer_time_write(struct counter_device *counter,
+					u64 value)
+{
+	struct ti_eqep_cnt *priv = counter->priv;
+	u32 qutmr;
+
+	/* convert nanoseconds to timer ticks */
+	qutmr = value = mul_u64_u32_div(value, priv->sysclkout_rate, NSEC_PER_SEC);
+	if (qutmr != value)
+		return -ERANGE;
+
+	regmap_write(priv->regmap32, QUTMR, qutmr);
+
+	return 0;
+}
+
+static int ti_eqep_unit_timer_period_read(struct counter_device *counter,
+					  u64 *value)
+{
+	struct ti_eqep_cnt *priv = counter->priv;
+	u32 quprd;
+
+	regmap_read(priv->regmap32, QUPRD, &quprd);
+
+	/* convert timer ticks to nanoseconds */
+	*value = mul_u64_u32_div(quprd, NSEC_PER_SEC, priv->sysclkout_rate);
+
+	return 0;
+}
+
+static int ti_eqep_unit_timer_period_write(struct counter_device *counter,
+					   u64 value)
+{
+	struct ti_eqep_cnt *priv = counter->priv;
+	u32 quprd;
+
+	/* convert nanoseconds to timer ticks */
+	quprd = value = mul_u64_u32_div(value, priv->sysclkout_rate, NSEC_PER_SEC);
+	if (quprd != value)
+		return -ERANGE;
+
+	/* protect against infinite unit timeout interrupts */
+	if (quprd == 0)
+		return -EINVAL;
+
+	regmap_write(priv->regmap32, QUPRD, quprd);
+
+	return 0;
+}
+
+static int ti_eqep_unit_timer_enable_read(struct counter_device *counter,
+					  u8 *value)
+{
+	struct ti_eqep_cnt *priv = counter->priv;
+	u32 qepctl;
+
+	regmap_read(priv->regmap16, QEPCTL, &qepctl);
+	*value = !!(qepctl & QEPCTL_UTE);
+
+	return 0;
+}
+
+static int ti_eqep_unit_timer_enable_write(struct counter_device *counter,
+					   u8 value)
+{
+	struct ti_eqep_cnt *priv = counter->priv;
+
+	if (value)
+		regmap_set_bits(priv->regmap16, QEPCTL, QEPCTL_UTE);
+	else
+		regmap_clear_bits(priv->regmap16, QEPCTL, QEPCTL_UTE);
+
+	return 0;
+}
+
+static struct counter_comp ti_eqep_device_ext[] = {
+	COUNTER_COMP_DEVICE_U64("unit_timer_time", ti_eqep_unit_timer_time_read,
+				ti_eqep_unit_timer_time_write),
+	COUNTER_COMP_DEVICE_U64("unit_timer_period",
+				ti_eqep_unit_timer_period_read,
+				ti_eqep_unit_timer_period_write),
+	COUNTER_COMP_DEVICE_BOOL("unit_timer_enable",
+				 ti_eqep_unit_timer_enable_read,
+				 ti_eqep_unit_timer_enable_write),
+};
+
 static irqreturn_t ti_eqep_irq_handler(int irq, void *dev_id)
 {
 	struct ti_eqep_cnt *priv = dev_id;
@@ -474,6 +580,8 @@ static irqreturn_t ti_eqep_irq_handler(int irq, void *dev_id)
 	if (qflg & QFLG_QDC)
 		counter_push_event(counter, COUNTER_EVENT_DIRECTION_CHANGE, 0);
 
+	if (qflg & QFLG_UTO)
+		counter_push_event(counter, COUNTER_EVENT_TIMEOUT, 0);
 
 	regmap_set_bits(priv->regmap16, QCLR, ~0);
 
@@ -500,6 +608,7 @@ static int ti_eqep_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct ti_eqep_cnt *priv;
+	struct clk *clk;
 	void __iomem *base;
 	int err;
 	int irq;
@@ -508,6 +617,24 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	clk = devm_clk_get(dev, "sysclkout");
+	if (IS_ERR(clk)) {
+		if (PTR_ERR(clk) != -EPROBE_DEFER)
+			dev_err(dev, "failed to get sysclkout");
+		return PTR_ERR(clk);
+	}
+
+	priv->sysclkout_rate = clk_get_rate(clk);
+	if (priv->sysclkout_rate == 0) {
+		dev_err(dev, "failed to get sysclkout rate");
+		/* prevent divide by zero */
+		priv->sysclkout_rate = 1;
+		/*
+		 * This error is not expected and the driver is mostly usable
+		 * without clock rate anyway, so don't exit here.
+		 */
+	}
+
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
@@ -536,6 +663,8 @@ static int ti_eqep_probe(struct platform_device *pdev)
 	priv->counter.ops = &ti_eqep_counter_ops;
 	priv->counter.counts = ti_eqep_counts;
 	priv->counter.num_counts = ARRAY_SIZE(ti_eqep_counts);
+	priv->counter.ext = ti_eqep_device_ext;
+	priv->counter.num_ext = ARRAY_SIZE(ti_eqep_device_ext);
 	priv->counter.signals = ti_eqep_signals;
 	priv->counter.num_signals = ARRAY_SIZE(ti_eqep_signals);
 	priv->counter.priv = priv;
@@ -552,10 +681,11 @@ static int ti_eqep_probe(struct platform_device *pdev)
 
 	/*
 	 * We can end up with an interupt infinite loop (interrupts triggered
-	 * as soon as they are cleared) if we leave this at the default value
+	 * as soon as they are cleared) if we leave these at the default value
 	 * of 0 and events are enabled.
 	 */
 	regmap_write(priv->regmap32, QPOSMAX, UINT_MAX);
+	regmap_write(priv->regmap32, QUPRD, UINT_MAX);
 
 	err = counter_register(&priv->counter);
 	if (err < 0) {
diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
index 36dd3b474d09..640d9719b88c 100644
--- a/include/uapi/linux/counter.h
+++ b/include/uapi/linux/counter.h
@@ -63,6 +63,8 @@ enum counter_event_type {
 	COUNTER_EVENT_INDEX,
 	/* Direction change detected */
 	COUNTER_EVENT_DIRECTION_CHANGE,
+	/* Timer exceeded timeout */
+	COUNTER_EVENT_TIMEOUT,
 };
 
 /**
-- 
2.25.1

