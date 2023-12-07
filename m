Return-Path: <linux-iio+bounces-713-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3C4808806
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 13:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9C291F22611
	for <lists+linux-iio@lfdr.de>; Thu,  7 Dec 2023 12:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FA43C46F;
	Thu,  7 Dec 2023 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlRd9n9R"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E291A3D0AE
	for <linux-iio@vger.kernel.org>; Thu,  7 Dec 2023 12:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F4CBC433AB;
	Thu,  7 Dec 2023 12:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701952769;
	bh=aABzGggrvD0XhW2lKGWU/oWZ4Hed3lPtMeOJmZ/Wt5Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FlRd9n9RtP9d6ZoqFPY28GAabR+ByS9EFOywwTN15eUAbPmdrSD1d5Qm8efcDB9bC
	 hA5x9kS3/c63OWC523zQrfE15uDhSE1UXKQvt6UWsGhXI03TzFTIPQOavf/R3pc3A/
	 ojwBofHEEy19bBp9y96zlU9eUx5Xss0qQfIuyrh6i3nTGBQuYYc15eRDuetu/fhlGD
	 4hqSOP/E3ntsrB8dTGxP7R7b8EYCBqV7Z9Ran5dxyVU3zd2Ia/ZZL8oXmHtZAouJLo
	 vEoCT2oPTcIt8Sk+3eYhJ49cn3FazStDYHM+yH2AqwrNt8VKUQQ8Tr31qxtqG6VTmH
	 6igH6yXBvFSdg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD7EC10F09;
	Thu,  7 Dec 2023 12:39:29 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 07 Dec 2023 13:39:31 +0100
Subject: [PATCH v2 8/8] iio: adc: adi-axi-adc: convert to regmap
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231207-iio-backend-prep-v2-8-a4a33bc4d70e@analog.com>
References: <20231207-iio-backend-prep-v2-0-a4a33bc4d70e@analog.com>
In-Reply-To: <20231207-iio-backend-prep-v2-0-a4a33bc4d70e@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701952767; l=4831;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=ey/6CMRvNpLRnhwev6g9elWLuN6NjDAcgBWhuHS/xe0=;
 b=vya9zRUMhCS4T+se37Z2KFkNnao+lne9BBQwH3NyYHajGli1J1M3dtPkLnRY/anWTlHWpXLYv
 +I9DYCLrj0vCYn3sCOxV3judJEHWe6K+fJYCCL11XkPgHrkYZWTXBLT
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

Use MMIO regmap interface. It makes things easier for manipulating bits.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 85 ++++++++++++++++++++++++++-----------------
 1 file changed, 52 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index ae83ada7f9f2..c247ff1541d2 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -14,6 +14,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 
 #include <linux/iio/iio.h>
@@ -62,7 +63,7 @@ struct adi_axi_adc_state {
 	struct mutex				lock;
 
 	struct adi_axi_adc_client		*client;
-	void __iomem				*regs;
+	struct regmap				*regmap;
 };
 
 struct adi_axi_adc_client {
@@ -90,19 +91,6 @@ void *adi_axi_adc_conv_priv(struct adi_axi_adc_conv *conv)
 }
 EXPORT_SYMBOL_NS_GPL(adi_axi_adc_conv_priv, IIO_ADI_AXI);
 
-static void adi_axi_adc_write(struct adi_axi_adc_state *st,
-			      unsigned int reg,
-			      unsigned int val)
-{
-	iowrite32(val, st->regs + reg);
-}
-
-static unsigned int adi_axi_adc_read(struct adi_axi_adc_state *st,
-				     unsigned int reg)
-{
-	return ioread32(st->regs + reg);
-}
-
 static int adi_axi_adc_config_dma_buffer(struct device *dev,
 					 struct iio_dev *indio_dev)
 {
@@ -163,17 +151,20 @@ static int adi_axi_adc_update_scan_mode(struct iio_dev *indio_dev,
 {
 	struct adi_axi_adc_state *st = iio_priv(indio_dev);
 	struct adi_axi_adc_conv *conv = &st->client->conv;
-	unsigned int i, ctrl;
+	unsigned int i;
+	int ret;
 
 	for (i = 0; i < conv->chip_info->num_channels; i++) {
-		ctrl = adi_axi_adc_read(st, ADI_AXI_REG_CHAN_CTRL(i));
-
 		if (test_bit(i, scan_mask))
-			ctrl |= ADI_AXI_REG_CHAN_CTRL_ENABLE;
+			ret = regmap_set_bits(st->regmap,
+					      ADI_AXI_REG_CHAN_CTRL(i),
+					      ADI_AXI_REG_CHAN_CTRL_ENABLE);
 		else
-			ctrl &= ~ADI_AXI_REG_CHAN_CTRL_ENABLE;
-
-		adi_axi_adc_write(st, ADI_AXI_REG_CHAN_CTRL(i), ctrl);
+			ret = regmap_clear_bits(st->regmap,
+						ADI_AXI_REG_CHAN_CTRL(i),
+						ADI_AXI_REG_CHAN_CTRL_ENABLE);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -310,21 +301,32 @@ static int adi_axi_adc_setup_channels(struct device *dev,
 	}
 
 	for (i = 0; i < conv->chip_info->num_channels; i++) {
-		adi_axi_adc_write(st, ADI_AXI_REG_CHAN_CTRL(i),
-				  ADI_AXI_REG_CHAN_CTRL_DEFAULTS);
+		ret = regmap_write(st->regmap, ADI_AXI_REG_CHAN_CTRL(i),
+				   ADI_AXI_REG_CHAN_CTRL_DEFAULTS);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
 }
 
-static void axi_adc_reset(struct adi_axi_adc_state *st)
+static int axi_adc_reset(struct adi_axi_adc_state *st)
 {
-	adi_axi_adc_write(st, ADI_AXI_REG_RSTN, 0);
+	int ret;
+
+	ret = regmap_write(st->regmap, ADI_AXI_REG_RSTN, 0);
+	if (ret)
+		return ret;
+
 	mdelay(10);
-	adi_axi_adc_write(st, ADI_AXI_REG_RSTN, ADI_AXI_REG_RSTN_MMCM_RSTN);
+	ret = regmap_write(st->regmap, ADI_AXI_REG_RSTN,
+			   ADI_AXI_REG_RSTN_MMCM_RSTN);
+	if (ret)
+		return ret;
+
 	mdelay(10);
-	adi_axi_adc_write(st, ADI_AXI_REG_RSTN,
-			  ADI_AXI_REG_RSTN_RSTN | ADI_AXI_REG_RSTN_MMCM_RSTN);
+	return regmap_write(st->regmap, ADI_AXI_REG_RSTN,
+			    ADI_AXI_REG_RSTN_RSTN | ADI_AXI_REG_RSTN_MMCM_RSTN);
 }
 
 static void adi_axi_adc_cleanup(void *data)
@@ -335,12 +337,20 @@ static void adi_axi_adc_cleanup(void *data)
 	module_put(cl->dev->driver->owner);
 }
 
+static const struct regmap_config axi_adc_regmap_config = {
+	.val_bits = 32,
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.max_register = 0x0800,
+};
+
 static int adi_axi_adc_probe(struct platform_device *pdev)
 {
 	struct adi_axi_adc_conv *conv;
 	struct iio_dev *indio_dev;
 	struct adi_axi_adc_client *cl;
 	struct adi_axi_adc_state *st;
+	void __iomem *base;
 	unsigned int ver;
 	int ret;
 
@@ -361,15 +371,24 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 	cl->state = st;
 	mutex_init(&st->lock);
 
-	st->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(st->regs))
-		return PTR_ERR(st->regs);
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	st->regmap = devm_regmap_init_mmio(&pdev->dev, base,
+					   &axi_adc_regmap_config);
+	if (IS_ERR(st->regmap))
+		return PTR_ERR(st->regmap);
 
 	conv = &st->client->conv;
 
-	axi_adc_reset(st);
+	ret = axi_adc_reset(st);
+	if (ret)
+		return ret;
 
-	ver = adi_axi_adc_read(st, ADI_AXI_REG_VERSION);
+	ret = regmap_read(st->regmap, ADI_AXI_REG_VERSION, &ver);
+	if (ret)
+		return ret;
 
 	if (cl->info->version > ver) {
 		dev_err(&pdev->dev,

-- 
2.43.0


