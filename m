Return-Path: <linux-iio+bounces-19982-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 529B1AC61C1
	for <lists+linux-iio@lfdr.de>; Wed, 28 May 2025 08:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC6C67B150A
	for <lists+linux-iio@lfdr.de>; Wed, 28 May 2025 06:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFDE212B02;
	Wed, 28 May 2025 06:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="aBy6t+UK"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F1C2F2F;
	Wed, 28 May 2025 06:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748412863; cv=none; b=hlhleCXwfjlaVAYHR4MhT/FfhJxRkixOawhXsbipxK2cVVcjIlCZiLBlZFzsTUWmpQ6uiIQ6vulnvw8XXfkRBzFvIYQ+ZtYwb5vra9pcrRhvyps+Fy7H7zN7N+XSe/5n76KY0HO2OUolYEnRQg3dEbvhYV/f+lchTlzkS0YzNNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748412863; c=relaxed/simple;
	bh=TktazPySSKGEf/0fslH0MvDKjlP70/UT5hkBSp27kl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rwyewbJO089Y34kBx991HDKvmH6cLKstpgpOo0eA49x397dUKwZELO+BblSz3Cy68t8auVz62hQo5YJYhpH4WVcBkgAPqVj/6tHz6wxipRVr4un//ITz9/HspNFBu93Z009BVvrGIrT5VuC6WLyEaEfPTwRHiIHB9anekmB804k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=aBy6t+UK; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1748412862; x=1779948862;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=TktazPySSKGEf/0fslH0MvDKjlP70/UT5hkBSp27kl0=;
  b=aBy6t+UKI1vVC/Cb9H+vKTlDu3X0VU77VYCchRQafKHPEredXGXl3cYW
   X4dZOTH+TJshMNbjFCVTN45ZmfipGaDSSJdYSp2Qi0p0n0sF7L0nfPat/
   zRUsmqO/zdFY1yppRfqN+Gwp08HomhENol7bmvfJ3rgIZaB+44XA7WByK
   be8uVKXmNmaq3+6bjnBJqrrNEzwGknzBVy4wseseHi67nVla+1LKIACOV
   OqiHoQG0NaUpz+mm6lr79gAwb7Jas2JP0mGAu7UM/pgc9WN/2jMfTC068
   FcZ0MDk1QrecoDsrSR+/pqdmTOFFNdGG7gLKulTfi2GUuOHtkLbl+Ohbw
   A==;
X-CSE-ConnectionGUID: eU1T+fZHR4iBV5joZbGgXA==
X-CSE-MsgGUID: 73BKs1QST4O0fd8eBA9Lwg==
X-IronPort-AV: E=Sophos;i="6.15,320,1739862000"; 
   d="scan'208";a="209641304"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 May 2025 23:14:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 27 May 2025 23:13:19 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Tue, 27 May 2025 23:13:16 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Wed, 28 May 2025 11:43:04 +0530
Subject: [PATCH 1/2] counter: microchip-tcb-capture: Retrieve and map
 parent base address
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250528-mchp-tcb-dma-v1-1-083a41fb7b51@microchip.com>
References: <20250528-mchp-tcb-dma-v1-0-083a41fb7b51@microchip.com>
In-Reply-To: <20250528-mchp-tcb-dma-v1-0-083a41fb7b51@microchip.com>
To: Kamel Bouhara <kamel.bouhara@bootlin.com>, William Breathitt Gray
	<wbg@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dharma Balasubiramani
	<dharma.b@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748412791; l=2336;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=TktazPySSKGEf/0fslH0MvDKjlP70/UT5hkBSp27kl0=;
 b=EAc2uHlbuqLve1VW5JZDmKi9XT9LMUfU0eHvGLFn/cY0hKmuGha2kLctmQ9DuSGgrd5GAJjeq
 iCD8XMsq//NDmlAV08a/pEX6qXjvlt8leFAbv+5H2ySrbly0AgOMCte
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

Retrieve the parent TCB controller's platform_device and map its MMIO
region using devm_ioremap_resource(). This allows direct register access
through a base address, which is required for features like DMA that need
physical addresses.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
 drivers/counter/microchip-tcb-capture.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 1a299d1f350b..9634da75bd1a 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -12,6 +12,7 @@
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <uapi/linux/counter/microchip-tcb-capture.h>
@@ -29,7 +30,9 @@
 
 struct mchp_tc_data {
 	const struct atmel_tcb_config *tc_cfg;
+	struct platform_device *pdev;
 	struct regmap *regmap;
+	void __iomem *base;
 	int qdec_mode;
 	int num_channels;
 	int channel[2];
@@ -479,6 +482,8 @@ static int mchp_tc_probe(struct platform_device *pdev)
 	const struct atmel_tcb_config *tcb_config;
 	const struct of_device_id *match;
 	struct counter_device *counter;
+	struct platform_device *parent_pdev;
+	struct resource *parent_res;
 	struct mchp_tc_data *priv;
 	char clk_name[7];
 	struct regmap *regmap;
@@ -491,6 +496,18 @@ static int mchp_tc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	priv = counter_priv(counter);
 
+	parent_pdev = of_find_device_by_node(np->parent);
+	if (!parent_pdev)
+		return -EPROBE_DEFER;
+
+	parent_res = platform_get_resource(parent_pdev, IORESOURCE_MEM, 0);
+	if (!parent_res)
+		return -EINVAL;
+
+	priv->base = devm_ioremap_resource(&parent_pdev->dev, parent_res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
 	match = of_match_node(atmel_tc_of_match, np->parent);
 	tcb_config = match->data;
 	if (!tcb_config) {
@@ -563,6 +580,7 @@ static int mchp_tc_probe(struct platform_device *pdev)
 
 	priv->tc_cfg = tcb_config;
 	priv->regmap = regmap;
+	priv->pdev = pdev;
 	counter->name = dev_name(&pdev->dev);
 	counter->parent = &pdev->dev;
 	counter->ops = &mchp_tc_ops;

-- 
2.43.0


