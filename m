Return-Path: <linux-iio+bounces-16367-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64102A4E593
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 17:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D79016FB49
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 16:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA42B281358;
	Tue,  4 Mar 2025 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="muU3Xo/F"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F3C27D773;
	Tue,  4 Mar 2025 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103549; cv=none; b=VvFRwss7JqLVFFsMIjAVQ0P5w+A0wK3YPYBU7mF8tgUQoQLp5p1FEpAkR69Hrf0oNth7cq+SUaZG++wn726+sZ8EURsNn3FagaSInyexci/34GkdMTylSpbY30YeOtlVmPXCDa9b9kwk399yspZtdJIEdodQrUE1kgqi80erwAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103549; c=relaxed/simple;
	bh=NR/dd+UuncK//fJsLZUc9HBFp6I4bdXZLeq9pi32EsY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dHCXDTYyqJPQz0mapTXBRZCGsTTPm5K48DUEzZ3XGh2PxGjfPKIRJqi1Lq4RtXbggZjY2XnDQD38R1YeG4rNyxsYX5G3dR7ML/mjGg53UK+oz0sa+qlntjv1J7uZBwQlaCCz3bszBIVvJs+VpwEOxrj7wx740OOY+KYJmhHYa9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=muU3Xo/F; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id C4BF5A0433;
	Tue,  4 Mar 2025 16:52:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=5dTjSfqKK0R8bH627adq
	ctcxC4syGnvamM8bnp4FMho=; b=muU3Xo/Fvxv2UOYdmwROavNw0Ju2gIH4N5Os
	cTU1R4sOTSvjobUkpWS72EKr5RD9R2gINJ/V7mx9D9LykHSQRbDglEHFKuFLYNEa
	8JQ1x82/28EDXk95hcjYgV6ScFB658NKtsoaAoqXYdsLaGLg249YEZHJW7TFD1QC
	H6v04PylOGdDzS2oNx0Nj+jePNWpmMynoFnWqkThmO/28Amw3LQoCIB9D37+F9Jo
	CLxFSPkCc5M7YUDlQHXwqCK+NlE0ysPqoOtied+IIp07+dI272IH3FIPNINvjjoH
	LdxMEC+kJGDpvffme306vudIW5ZkaKL6OQdbEevq6mZeae7Ozoa4oyHXw7lcfMFt
	/bLTR66EMZfADnuqyTFHZY02z6M8gR9pT8MkrQ96GKL6rp/QuzyQv38OP4WanmU6
	CNv0HMLabmaEJ8DG4VmWiiGzQOaf/heVpGJ4WBvHnUj00WzORR8FYGSzwXfhq9xA
	XsnkL9SpOF4JuXMhcwR4Yhtz6Vd0xrWgcNSLybw7agX4R69yVyBk429Q4AIu55ct
	IrZZjITWgwGFLyDoaKg5PPMQ7takZ7K2teKznqhhYEf5CSgtjWp1nMX5IWq9RuZ7
	54JFwuLL0pwtzrMv4PtIJizDv+wklKcd58C65Fz0L4tXSjy/JNmKjrXyryDTRiMP
	SehyA8k=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-iio@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, "Kamel
 Bouhara" <kamel.bouhara@bootlin.com>, William Breathitt Gray <wbg@kernel.org>
Subject: [PATCH v7 1/2] counter: microchip-tcb-capture: Add IRQ handling
Date: Tue, 4 Mar 2025 16:51:51 +0100
Message-ID: <20250304155156.374150-2-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304155156.374150-1-csokas.bence@prolan.hu>
References: <20250304155156.374150-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1741103543;VERSION=7985;MC=1607386707;ID=1544447;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852637264

Add interrupt servicing to allow userspace to wait for the following:
* Change-of-state caused by external trigger
* Capture of timer value into RA/RB
* Compare to RC register
* Overflow

Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---

Notes:
    New in v2
    Changes in v3:
    * Add IRQs for Capture events (from next patch)
    * Add IRQ for RC Compare
    * Add events as bullet points to commit msg
    Changes in v4:
    * Add uapi header, names for the event channels
    * Add check for -EPROBE_DEFER from `of_irq_get()`
    Changes in v5:
    * Split out UAPI header introduction
    Changes in v7:
    * Revert split-out
    * Drop `enum counter_mchp_signals` from UAPI
    * Change enums to #define's in UAPI header

 MAINTAINERS                                   |  1 +
 drivers/counter/microchip-tcb-capture.c       | 75 +++++++++++++++++++
 .../linux/counter/microchip-tcb-capture.h     | 34 +++++++++
 3 files changed, 110 insertions(+)
 create mode 100644 include/uapi/linux/counter/microchip-tcb-capture.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e047e20fbd8..d1d264210690 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15579,6 +15579,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	drivers/counter/microchip-tcb-capture.c
+F:	include/uapi/linux/counter/microchip-tcb-capture.h
 
 MICROCHIP USB251XB DRIVER
 M:	Richard Leitner <richard.leitner@skidata.com>
diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 2f096a5b973d..cc12c2e2113a 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -6,18 +6,24 @@
  */
 #include <linux/clk.h>
 #include <linux/counter.h>
+#include <linux/interrupt.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <uapi/linux/counter/microchip-tcb-capture.h>
 #include <soc/at91/atmel_tcb.h>
 
 #define ATMEL_TC_CMR_MASK	(ATMEL_TC_LDRA_RISING | ATMEL_TC_LDRB_FALLING | \
 				 ATMEL_TC_ETRGEDG_RISING | ATMEL_TC_LDBDIS | \
 				 ATMEL_TC_LDBSTOP)
 
+#define ATMEL_TC_DEF_IRQS	(ATMEL_TC_ETRGS | ATMEL_TC_COVFS | \
+				 ATMEL_TC_LDRAS | ATMEL_TC_LDRBS | ATMEL_TC_CPCS)
+
 #define ATMEL_TC_QDEN			BIT(8)
 #define ATMEL_TC_POSEN			BIT(9)
 
@@ -27,6 +33,7 @@ struct mchp_tc_data {
 	int qdec_mode;
 	int num_channels;
 	int channel[2];
+	int irq;
 };
 
 static const enum counter_function mchp_tc_count_functions[] = {
@@ -294,6 +301,65 @@ static const struct of_device_id atmel_tc_of_match[] = {
 	{ /* sentinel */ }
 };
 
+static irqreturn_t mchp_tc_isr(int irq, void *dev_id)
+{
+	struct counter_device *const counter = dev_id;
+	struct mchp_tc_data *const priv = counter_priv(counter);
+	u32 sr, mask;
+
+	regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], SR), &sr);
+	regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], IMR), &mask);
+
+	sr &= mask;
+	if (!(sr & ATMEL_TC_ALL_IRQ))
+		return IRQ_NONE;
+
+	if (sr & ATMEL_TC_ETRGS)
+		counter_push_event(counter, COUNTER_EVENT_CHANGE_OF_STATE,
+				   COUNTER_MCHP_EVCHN_CV);
+	if (sr & ATMEL_TC_LDRAS)
+		counter_push_event(counter, COUNTER_EVENT_CAPTURE,
+				   COUNTER_MCHP_EVCHN_RA);
+	if (sr & ATMEL_TC_LDRBS)
+		counter_push_event(counter, COUNTER_EVENT_CAPTURE,
+				   COUNTER_MCHP_EVCHN_RB);
+	if (sr & ATMEL_TC_CPCS)
+		counter_push_event(counter, COUNTER_EVENT_THRESHOLD,
+				   COUNTER_MCHP_EVCHN_RC);
+	if (sr & ATMEL_TC_COVFS)
+		counter_push_event(counter, COUNTER_EVENT_OVERFLOW,
+				   COUNTER_MCHP_EVCHN_CV);
+
+	return IRQ_HANDLED;
+}
+
+static void mchp_tc_irq_remove(void *ptr)
+{
+	struct mchp_tc_data *priv = ptr;
+
+	regmap_write(priv->regmap, ATMEL_TC_REG(priv->channel[0], IDR), ATMEL_TC_DEF_IRQS);
+}
+
+static int mchp_tc_irq_enable(struct counter_device *const counter)
+{
+	struct mchp_tc_data *const priv = counter_priv(counter);
+	int ret = devm_request_irq(counter->parent, priv->irq, mchp_tc_isr, 0,
+				   dev_name(counter->parent), counter);
+
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_write(priv->regmap, ATMEL_TC_REG(priv->channel[0], IER), ATMEL_TC_DEF_IRQS);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_add_action_or_reset(counter->parent, mchp_tc_irq_remove, priv);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static void mchp_tc_clk_remove(void *ptr)
 {
 	clk_disable_unprepare((struct clk *)ptr);
@@ -378,6 +444,15 @@ static int mchp_tc_probe(struct platform_device *pdev)
 	counter->num_signals = ARRAY_SIZE(mchp_tc_count_signals);
 	counter->signals = mchp_tc_count_signals;
 
+	priv->irq = of_irq_get(np->parent, 0);
+	if (priv->irq == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+	if (priv->irq > 0) {
+		ret = mchp_tc_irq_enable(counter);
+		if (ret < 0)
+			return dev_err_probe(&pdev->dev, ret, "Failed to set up IRQ");
+	}
+
 	ret = devm_counter_add(&pdev->dev, counter);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "Failed to add counter\n");
diff --git a/include/uapi/linux/counter/microchip-tcb-capture.h b/include/uapi/linux/counter/microchip-tcb-capture.h
new file mode 100644
index 000000000000..f3ef315fe9f6
--- /dev/null
+++ b/include/uapi/linux/counter/microchip-tcb-capture.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Channel numbers used by the microchip-tcb-capture driver
+ * Copyright (C) 2025 Bence Csókás
+ */
+#ifndef _UAPI_COUNTER_MCHP_TCB_H_
+#define _UAPI_COUNTER_MCHP_TCB_H_
+
+/*
+ * The driver defines the following components:
+ *
+ * Count 0
+ * \__  Synapse 0 -- Signal 0 (Channel A, i.e. TIOA)
+ * \__  Synapse 1 -- Signal 1 (Channel B, i.e. TIOB)
+ *
+ * It also supports the following events:
+ *
+ * Channel 0:
+ * - CV register changed
+ * - CV overflowed
+ * - RA captured
+ * Channel 1:
+ * - RB captured
+ * Channel 2:
+ * - RC compare triggered
+ */
+
+/* Event channels */
+#define COUNTER_MCHP_EVCHN_CV 0
+#define COUNTER_MCHP_EVCHN_RA 0
+#define COUNTER_MCHP_EVCHN_RB 1
+#define COUNTER_MCHP_EVCHN_RC 2
+
+#endif /* _UAPI_COUNTER_MCHP_TCB_H_ */
-- 
2.48.1



