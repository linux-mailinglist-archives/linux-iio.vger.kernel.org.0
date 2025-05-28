Return-Path: <linux-iio+bounces-19981-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C94AC61B8
	for <lists+linux-iio@lfdr.de>; Wed, 28 May 2025 08:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95203B2316
	for <lists+linux-iio@lfdr.de>; Wed, 28 May 2025 06:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38D4213244;
	Wed, 28 May 2025 06:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OWatpCnL"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01646210F65;
	Wed, 28 May 2025 06:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748412836; cv=none; b=VfOKHw+6lr9GqGgVo/af/Ccch6yIrn+mHenNLaZwVRZSPEPjcTin7YuxEVclsQn5ul8UiJvwykzzUz4SlQxqUvEZc1pXYlfP2mqYOE3KXQGouDCagJQrZyDW5y0ALa/7p/HhEWgmGlaeXk3X9MhiyzAClh3IFm4KDwCpDyl4YbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748412836; c=relaxed/simple;
	bh=timdkqszBy9pRJGN5hJ0FwkI0yGkdV1tziqvIcqNk+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cFviUiGYJEN3VFKhftELR2cfOFsIPdbpLkJRgMON2+dm7rlgXNSsGbbETF6N8hUv/PPbgp8V3JSSS9T5WUkxzZgv86u6oXoeULNxZAwnyVPkQh3wte5yf8UKNlT2cF9yOexL8yu8G57v/OXSj5ZToBXWE+ZpdGPYYYj/z4vmB9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OWatpCnL; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1748412835; x=1779948835;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=timdkqszBy9pRJGN5hJ0FwkI0yGkdV1tziqvIcqNk+w=;
  b=OWatpCnLvhiWTMp8VyDL6TI8fIOdj8xuzcAGLjSwkvk9JAQO3d1IrmAl
   7ltb/OetaXvVcSckB+aPKzL0fYfwSRmv0VbiJ/wgk9XBIXtMLh4tLO2as
   X7sA1UsMydlPF7U/wSAqFGI0uJz7NU4boLrLH/l3dWInWZbO/uPS7WZ6d
   UjrL4fntwtUaIZIf/N5yOoXfSnMI2y7kmG9qDsnHWl7VjEuHP56MgC+pV
   GOe+U5oOl3xMjEggJPVkRSnS0aeMJ4osLxCf5bBORtCXLghPaBiPhoV7M
   1SIcmKjqt4p6Bs9rFR4FZcrSJCrp5UIxnpuCuK3m0viQKSv9rFF9KO15O
   Q==;
X-CSE-ConnectionGUID: Na4ii3iOTbObYzT6z7QrlA==
X-CSE-MsgGUID: /JIRnDJ9QduRg7sJME2snQ==
X-IronPort-AV: E=Sophos;i="6.15,320,1739862000"; 
   d="scan'208";a="42149725"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 May 2025 23:13:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 27 May 2025 23:13:23 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Tue, 27 May 2025 23:13:20 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Wed, 28 May 2025 11:43:05 +0530
Subject: [PATCH 2/2] counter: microchip-tcb-capture: Add DMA support for
 TC_RAB register reads
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250528-mchp-tcb-dma-v1-2-083a41fb7b51@microchip.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748412791; l=5988;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=timdkqszBy9pRJGN5hJ0FwkI0yGkdV1tziqvIcqNk+w=;
 b=kPxGwSciC4VTlx2DjWq3wGdOzg0lsJ2YPOQbl09O2vKiubiXkJp0NNdYlmqYdQtozf2ws0mrT
 dhSgpNfyYhMDglCAnrOIjUz24hCHa9UU4MXRWgLVVcf1Q8F0yXkqeEC
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

Add optional DMA-based data transfer support to read the TC_RAB register,
which provides the next unread captured value from either RA or RB. This
improves performance and offloads CPU when mchp,use-dma-cap is enabled in
the device tree.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
 drivers/counter/microchip-tcb-capture.c | 110 +++++++++++++++++++++++++++++++-
 include/soc/at91/atmel_tcb.h            |   1 +
 2 files changed, 108 insertions(+), 3 deletions(-)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 9634da75bd1a..fa177edc6803 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -6,6 +6,9 @@
  */
 #include <linux/clk.h>
 #include <linux/counter.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
@@ -28,9 +31,19 @@
 #define ATMEL_TC_QDEN			BIT(8)
 #define ATMEL_TC_POSEN			BIT(9)
 
+struct mchp_tc_dma {
+	struct dma_chan *chan;
+	struct dma_slave_config slave_cfg;
+	u32 *buf;
+	dma_addr_t addr;
+	phys_addr_t phy_addr;
+	bool enabled;
+};
+
 struct mchp_tc_data {
 	const struct atmel_tcb_config *tc_cfg;
 	struct platform_device *pdev;
+	struct mchp_tc_dma dma;
 	struct regmap *regmap;
 	void __iomem *base;
 	int qdec_mode;
@@ -74,6 +87,61 @@ static struct counter_synapse mchp_tc_count_synapses[] = {
 	}
 };
 
+static void mchp_tc_dma_remove(void *data)
+{
+	struct mchp_tc_data *priv = data;
+
+	if (priv->dma.buf)
+		dma_free_coherent(&priv->pdev->dev, sizeof(u32),
+				  priv->dma.buf, priv->dma.addr);
+
+	if (priv->dma.chan)
+		dma_release_channel(priv->dma.chan);
+}
+
+static int mchp_tc_dma_transfer(struct mchp_tc_data *priv, u32 *val)
+{
+	struct dma_async_tx_descriptor *desc;
+	struct device *dev = &priv->pdev->dev;
+	dma_cookie_t cookie;
+	int ret;
+
+	ret = dmaengine_slave_config(priv->dma.chan, &priv->dma.slave_cfg);
+	if (ret) {
+		dev_err(dev, "DMA slave_config failed (%d)\n", ret);
+		return ret;
+	}
+
+	desc = dmaengine_prep_dma_memcpy(priv->dma.chan,
+					 priv->dma.addr,
+					 priv->dma.slave_cfg.src_addr,
+					 sizeof(u32),
+					 DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
+	if (!desc) {
+		dev_err(dev, "DMA prep descriptor failed\n");
+		return -ENOMEM;
+	}
+
+	cookie = dmaengine_submit(desc);
+	if (dma_submit_error(cookie)) {
+		dev_err(dev, "DMA submit error (%d)\n", cookie);
+		return cookie ?: -EIO;
+	}
+
+	dma_async_issue_pending(priv->dma.chan);
+
+	ret = dma_sync_wait(priv->dma.chan, cookie);
+	if (ret) {
+		dev_err(dev, "DMA transfer timed out (%d)\n", ret);
+		return ret;
+	}
+
+	/* Retrieve the 32-bit value the engine just copied */
+	*val = le32_to_cpu(*(u32 *)priv->dma.buf);
+
+	return 0;
+}
+
 static int mchp_tc_count_function_read(struct counter_device *counter,
 				       struct counter_count *count,
 				       enum counter_function *function)
@@ -260,20 +328,25 @@ static int mchp_tc_count_cap_read(struct counter_device *counter,
 				  struct counter_count *count, size_t idx, u64 *val)
 {
 	struct mchp_tc_data *const priv = counter_priv(counter);
-	u32 cnt;
+	u32 cnt, reg_offset;
 	int ret;
 
 	switch (idx) {
 	case COUNTER_MCHP_EXCAP_RA:
-		ret = regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], RA), &cnt);
+		reg_offset = ATMEL_TC_REG((priv->channel[0]), RA);
 		break;
 	case COUNTER_MCHP_EXCAP_RB:
-		ret = regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], RB), &cnt);
+		reg_offset = ATMEL_TC_REG((priv->channel[0]), RB);
 		break;
 	default:
 		return -EINVAL;
 	}
 
+	if (!priv->dma.enabled)
+		ret = regmap_read(priv->regmap, reg_offset, &cnt);
+	else
+		ret = mchp_tc_dma_transfer(priv, &cnt);
+
 	if (ret < 0)
 		return ret;
 
@@ -578,6 +651,7 @@ static int mchp_tc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	priv->dma.phy_addr = parent_res->start;
 	priv->tc_cfg = tcb_config;
 	priv->regmap = regmap;
 	priv->pdev = pdev;
@@ -589,6 +663,36 @@ static int mchp_tc_probe(struct platform_device *pdev)
 	counter->num_signals = ARRAY_SIZE(mchp_tc_count_signals);
 	counter->signals = mchp_tc_count_signals;
 
+	/* Check the dma flag */
+	priv->dma.enabled = of_property_read_bool(np, "mchp,use-dma-cap") ? true : false;
+
+	if (priv->dma.enabled) {
+		/* Initialise DMA */
+		priv->dma.buf = dma_alloc_coherent(&pdev->dev, sizeof(u32),
+						   &priv->dma.addr, GFP_KERNEL);
+		if (!priv->dma.buf)
+			return -ENOMEM;
+
+		priv->dma.chan = dma_request_chan(&parent_pdev->dev, "rx");
+		if (IS_ERR(priv->dma.chan))
+			return -EINVAL;
+
+		dev_info(&pdev->dev, "Using %s (rx) for DMA transfers\n",
+			 dma_chan_name(priv->dma.chan));
+
+		/* Configure DMA channel to read TC AB register */
+		priv->dma.slave_cfg.direction = DMA_DEV_TO_MEM;
+		priv->dma.slave_cfg.src_addr = priv->dma.phy_addr + ATMEL_TC_REG(priv->channel[0],
+										 RAB);
+		priv->dma.slave_cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		priv->dma.slave_cfg.src_maxburst = 1;
+		priv->dma.slave_cfg.dst_maxburst = 1;
+
+		ret = devm_add_action_or_reset(&pdev->dev, mchp_tc_dma_remove, priv);
+		if (ret)
+			return ret;
+	}
+
 	i = of_irq_get(np->parent, 0);
 	if (i == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
diff --git a/include/soc/at91/atmel_tcb.h b/include/soc/at91/atmel_tcb.h
index 26b56a07bd1f..9fad7f58a56a 100644
--- a/include/soc/at91/atmel_tcb.h
+++ b/include/soc/at91/atmel_tcb.h
@@ -243,6 +243,7 @@ extern const u8 atmel_tc_divisors[5];
 #define ATMEL_TC_RA	0x14		/* register A */
 #define ATMEL_TC_RB	0x18		/* register B */
 #define ATMEL_TC_RC	0x1c		/* register C */
+#define ATMEL_TC_RAB	0x0c		/* register AB */
 
 #define ATMEL_TC_SR	0x20		/* status (read-only) */
 /* Status-only flags */

-- 
2.43.0


