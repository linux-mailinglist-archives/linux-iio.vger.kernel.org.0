Return-Path: <linux-iio+bounces-226-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 168697F2A14
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 11:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47FC91C20BCD
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 10:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7D747771;
	Tue, 21 Nov 2023 10:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWHlDPZS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ED63D965;
	Tue, 21 Nov 2023 10:17:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D646CC4AF6B;
	Tue, 21 Nov 2023 10:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700561839;
	bh=w6aQ9dJ5B6A8WMrSgkXahhVY43m64ehi3h3s9hglcJk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GWHlDPZSag9moXGZ2SzcH0A/BFpBnGgI49r6aKEecwtiepRerBvLc2WjxE+bsRuPx
	 EmMLfyWDFv3usmQmBiEV8+jFvVnCVYEr8iy/I+y0WK1ZrhlBKaOduK/OxR+k34lvic
	 c3iEsL4ph7wQKoBy5x49VtBd2ZGKaW92LIsZS2VfMKR+Kp8i1OUdCgX9PG5EPnuPZ5
	 A2FPPRPY6sJhGBJQ7oW0+7Nb2Plv0blQ7RrJSgBNTTqsKpOcD+wqAN1RVtjByvXZlZ
	 QmZCMicD1P1L3WZX+U8ZaueS9brtIQMBnSSSLJFcXfDn9VIY7byl3OG8WVZ809coGE
	 Pd/vlxJJEheDw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C2AC61D93;
	Tue, 21 Nov 2023 10:17:19 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 21 Nov 2023 11:20:24 +0100
Subject: [PATCH 11/12] iio: adc: adi-axi-adc: convert to regmap
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-dev-iio-backend-v1-11-6a3d542eba35@analog.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
In-Reply-To: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-iio@vger.kernel.org
Cc: Olivier MOYSAN <olivier.moysan@foss.st.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700562016; l=4779;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=witdRDz1cNzA31LTYx4ngUVPfznr1OJ+tr958N00ncU=;
 b=DJEjy0HuPOzh+OG74+/E+esscrYisc3cu17cYfi2HXQltkRL+4tqKlxaxtoX6hKj2Abj5vCGY
 64h0BLWKAdfD/RVpiMXPd7GlHi7hWwnHbrahjFBLOZEPwz/nOSOCS2s
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

Use MMIO regmap interface. It makes things easier for manipulating bits.

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
2.42.1


