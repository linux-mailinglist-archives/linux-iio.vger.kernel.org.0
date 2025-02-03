Return-Path: <linux-iio+bounces-14937-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5E4A2601D
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 17:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 621CD1887E9E
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 16:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B82020B213;
	Mon,  3 Feb 2025 16:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="jSafp3RF"
X-Original-To: linux-iio@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8A020B1FF;
	Mon,  3 Feb 2025 16:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738600305; cv=none; b=hkAg4PNgCaY9E2t3B3NMnZs1jTGAlvkDJjBjY0eHZQOCz61oLOczxg4APjtCOR+fDLtqVzoL/VcllgugFHQ/8uOabawaeQJQaUSVk6Nj7Shc50Je/NQm+TDOQ50tEHgP/Y0/TkrxIOQnHwt+dqQevbxttHXOZCJRVs9Zy5pCml8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738600305; c=relaxed/simple;
	bh=7WvY97rkPcYSy7FrflV4pcouYWVuho/aOp5zXo4+asI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h4CsOGajL+jNNSQPIQDvaqVQ9/vn0EBg14nrNk0TWX3ec55/7RL2qs5RIFhVs3wZ/vwPBsQVZyE0llKiBm6ZmqBOPUOHBiKCSUFCdgy92Gf3QoUExULo9XWVS8yu71jK24uzE9dUgbvg3Q0174hCaEf9nEB8GVtpXZ1o182JTWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=jSafp3RF; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 5ECEBA0E6F;
	Mon,  3 Feb 2025 17:31:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=QtYOwxhJTx1c2Lg+XxDXfdFoZZ1VSsrERd5VI5gDt44=; b=
	jSafp3RFz7Ra9BwVl/pKUEynT3E7/l4NiLaliLgryZiWmxsLgzIFGUNzUdQ2CiYa
	JLiwItIZfq6Yrnn0MKarPVvo4m4qQZhUX+nzsTdF1WFTWRQQWyu/V3NkNiVv2B8l
	UWkPRdscvaBMee2YMXxA6eLluDcrOVcuHHOjXlIP8bGK/FSDlWGaGwviakevvOiC
	eKudxH0iUhOowd/Bd2XAhYFn4Jy+cjnkWATO7nQ/nIPnjA02/2zIYO8AAWyMMpNE
	6A9To7onpiUHF1FA5kwZTT9aavToSqGrO7ykKvy4ze8Hot1QuMpu435CdvRUdV/t
	4TjHQHroNNmArdsdRK5PlfnxpWFDTWOTnN1eP3FzsoKHZJyTJLXoB6muuss1rlcb
	AYhyFxGyKLmnHtpSd0nDiEhTl7KwIUkfJyF5146k68s+jGzo/09lk6R78LwecpkR
	HDbc+uHvk+wdJr2AZhbDEPEdogclvBYepRxdBdybTxpU+ij8IyVK/BjBi3Aw1I8p
	23yWESF/1rCNeSGE/HTzXO7TzoMJ0rWBoUKFdim9Jmc+FSaei5SYZO55SfuPObnd
	m86lAK85FzqM3Y+bkpO1MMkxBQ+C1bDbT5K80RB821Sc5nzfHxe49z/bIqSFFb5w
	Q5wq8uUy2TclIfZAFQJ/1h9dSp+iLjDzNv8YIDSfLQI=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>, "Kamel
 Bouhara" <kamel.bouhara@bootlin.com>, William Breathitt Gray <wbg@kernel.org>
Subject: [PATCH v2 1/2] counter: microchip-tcb-capture: Add IRQ handling
Date: Mon, 3 Feb 2025 17:29:52 +0100
Message-ID: <20250203162955.102559-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1738600298;VERSION=7984;MC=2545913080;ID=183984;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852667064

Add interrupt servicing to allow userspace to wait for a trigger event.

Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---

Notes:
    New in v2

 drivers/counter/microchip-tcb-capture.c | 60 +++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 2f096a5b973d..316755c7659a 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -6,10 +6,12 @@
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
 #include <soc/at91/atmel_tcb.h>
@@ -18,6 +20,8 @@
 				 ATMEL_TC_ETRGEDG_RISING | ATMEL_TC_LDBDIS | \
 				 ATMEL_TC_LDBSTOP)
 
+#define ATMEL_TC_DEF_IRQS	(ATMEL_TC_ETRGS | ATMEL_TC_COVFS)
+
 #define ATMEL_TC_QDEN			BIT(8)
 #define ATMEL_TC_POSEN			BIT(9)
 
@@ -27,6 +31,7 @@ struct mchp_tc_data {
 	int qdec_mode;
 	int num_channels;
 	int channel[2];
+	int irq;
 };
 
 static const enum counter_function mchp_tc_count_functions[] = {
@@ -294,6 +299,54 @@ static const struct of_device_id atmel_tc_of_match[] = {
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
+		counter_push_event(counter, COUNTER_EVENT_CHANGE_OF_STATE, 0);
+	if (sr & ATMEL_TC_COVFS)
+		counter_push_event(counter, COUNTER_EVENT_OVERFLOW, 0);
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
@@ -378,6 +431,13 @@ static int mchp_tc_probe(struct platform_device *pdev)
 	counter->num_signals = ARRAY_SIZE(mchp_tc_count_signals);
 	counter->signals = mchp_tc_count_signals;
 
+	priv->irq = of_irq_get(np->parent, 0);
+	if (priv->irq > 0) {
+		ret = mchp_tc_irq_enable(counter);
+		if (ret < 0)
+			return dev_err_probe(&pdev->dev, ret, "Failed to set up IRQ");
+	}
+
 	ret = devm_counter_add(&pdev->dev, counter);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "Failed to add counter\n");
-- 
2.48.1



