Return-Path: <linux-iio+bounces-16124-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E4EA481AB
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 15:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A112189F2AB
	for <lists+linux-iio@lfdr.de>; Thu, 27 Feb 2025 14:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E81235361;
	Thu, 27 Feb 2025 14:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="uB1+dInF"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAAB233D91;
	Thu, 27 Feb 2025 14:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740666481; cv=none; b=piO7V209JQoRqApo8TslSbxaW4KNBhMvm3It/3w547he6HPTczOsEJd1B7YW/Q+b+eh9Btoig7druK3igIHMa4oCP3JB3Rc4ky91g+J9fpT85X8Mo2pkOMgTTc65Q9qQk5ptqQ2M/9uxcUxrroVf2D84jbxmKT7JKzNii4BakPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740666481; c=relaxed/simple;
	bh=vH3/XuWuI9Es2C9TCwLKToujZ1sQCqicWg4VWeASNP8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K1S/eXLTWfv5aB8dfr5f+ONbixJA49LK8ubbWe38gmX95LZTqhBWzQW3R6EG9KkQPH9gFCfmywOvPKNhccbEdD/nUy+zQxlvFUDqmxQCdMABk2ALtm8Q7uHCU/nyVG9EgggE6OSyaEKmfzp6QJ9herD+vnA5O8onHauTAJ3B1vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=uB1+dInF; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 6E7D2A0D6D;
	Thu, 27 Feb 2025 15:27:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=d7fmU8TJDq6KTOuPGSb8
	jkfqdk5VnvNn0zD+r2C2d+k=; b=uB1+dInFmyAOvQ2vWGPI3vdq4CTOxTGjWggw
	htDxDEgGcf9pns1HIPksWuGIUaItMg0fQ7gfrZTlKQmWGYArhwCZo+KtqVl0Azyj
	XbFdxAAYmOZ3zYo6jt+9B0BMAxEZ2g22B0hhFbbNn3VFjxtqkSy+SWpucZIAzpHP
	vhsEuTCanrmL1ytOVr37wAZraeDRcjklxRVFntTwcS0llBiuXvKlJ1WFhFouRmbo
	IDsMVcdR0ohMOm1d0kx/lD059Xzeho4pZK5cCX3Y2AJQj/WYczif4O5NmH+6yF9F
	Ba/iHuy3SREszlHOEqJOU6r+gTpGqlYaLpAhWZ0VPzIYD/p3szC5KDpgVp6UAgFt
	F+RkCqYvh1kNOjhTVejltRKNR9Ag4DfAoYfIsx9hhjzbnJmgj8t0ewp4BLUule0w
	kvSjX3VBBLCWbnwJOEz2n0fIdXJP9Z7B/f0VAz7cEbiK/9VzJoEe6lhaLxhxd97i
	XcDiZOXrOFouzcJl/j6UlFvzrkr/UskrC3JANTm4TfJ5HVnV5LjARyJ5OsOfaTnA
	7h+k/gXKQmPpyu06rW37eG6RizJe+R3/bDWOXrx0adhoM7+nrOVUuHijKC9WITqf
	dnGFNHV+yvalF/OozJc/tJz3dyUNT8A9i6qRorPGJqyKgFZaiceWGD0K0UhXuAvZ
	bSoaoeA=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, "Kamel
 Bouhara" <kamel.bouhara@bootlin.com>, William Breathitt Gray <wbg@kernel.org>
Subject: [PATCH v5 2/3] counter: microchip-tcb-capture: Add IRQ handling
Date: Thu, 27 Feb 2025 15:27:47 +0100
Message-ID: <20250227142751.61496-3-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227142751.61496-1-csokas.bence@prolan.hu>
References: <20250227142751.61496-1-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1740666476;VERSION=7985;MC=1421377409;ID=1450430;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD94852637760

Add interrupt servicing to allow userspace to wait for the following events:
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

 drivers/counter/microchip-tcb-capture.c       | 75 +++++++++++++++++++
 .../linux/counter/microchip-tcb-capture.h     | 18 +++++
 2 files changed, 93 insertions(+)

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
index 7bda5fdef19b..ee72f1463594 100644
--- a/include/uapi/linux/counter/microchip-tcb-capture.h
+++ b/include/uapi/linux/counter/microchip-tcb-capture.h
@@ -12,6 +12,17 @@
  * Count 0
  * \__  Synapse 0 -- Signal 0 (Channel A, i.e. TIOA)
  * \__  Synapse 1 -- Signal 1 (Channel B, i.e. TIOB)
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
  */
 
 enum counter_mchp_signals {
@@ -19,4 +30,11 @@ enum counter_mchp_signals {
 	COUNTER_MCHP_SIG_TIOB,
 };
 
+enum counter_mchp_event_channels {
+	COUNTER_MCHP_EVCHN_CV = 0,
+	COUNTER_MCHP_EVCHN_RA = 0,
+	COUNTER_MCHP_EVCHN_RB,
+	COUNTER_MCHP_EVCHN_RC,
+};
+
 #endif /* _UAPI_COUNTER_MCHP_TCB_H_ */
-- 
2.48.1



