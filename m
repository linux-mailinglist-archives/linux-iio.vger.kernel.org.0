Return-Path: <linux-iio+bounces-24651-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EDEBB37D2
	for <lists+linux-iio@lfdr.de>; Thu, 02 Oct 2025 11:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08AC519C304D
	for <lists+linux-iio@lfdr.de>; Thu,  2 Oct 2025 09:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0B3307AC4;
	Thu,  2 Oct 2025 09:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Y98/U6fT"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D6030505B;
	Thu,  2 Oct 2025 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759397836; cv=none; b=GCJ2mFajeGUEZO0GolR+T5YXggzzMOMLEDN50FXOgFCyf916hBP6eq5ZwNEhT1iib/gHEZWaKdzM934p5DsE4iFrDd4p6lcc+Ms+QMIBz9OnmI7UUry+I6GQg8XCYSEjOdgUtNHjdTJLXKPO7zXGbEi5eRGwa7nCQb5kZ+04VSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759397836; c=relaxed/simple;
	bh=lw6I7CSBu6LrNrtzqq8Kzhj1MMC2oe1O5zTWUZoMZ7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEjZuXqghUghjbNv0RnYQ2IIJoAXGhxrl3SbuW7uwgoQaoY0htyFPLMhLZh0Ft/Ug0pNgSezcSsKtS3ewsMd5VQZlbovnW6meTEnAjSogUV3aTTAdqRN+9cGLgF4QRX9Yq9KQQvFNGWi0fgZAgQKBxvjfVUv63ldzbE+j4YyFh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Y98/U6fT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759397832;
	bh=lw6I7CSBu6LrNrtzqq8Kzhj1MMC2oe1O5zTWUZoMZ7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y98/U6fTHbBGVQVbQBsknHGDCkK87xme+wvLuih1zD12NLlozRbQf+19TNXIbxR0J
	 rPwjjfiyQJJyFFxenqHORiDKCJ/H8gDRBZeeq5/EhVaYX7nuHh41QjdMjZDXj0eXUZ
	 sJqa5+IjqKZ3v68eoqNk5hr577KkPrxCQNbeAsDwuUhK1ffs+WRAAqxEq2ZP8hTPw2
	 cG8XeMh2iu2AWfDvJVrfsS0oKgOLYJ8HUFLoAQzVS+BIht2lpCXGwTqqP4ciYf+NNi
	 CPpHV9rfCRwF1mFqJkfP9Ji7ccMzIoSmcXu3Ctni6Vk9DybyAKpqf/ANDgnUPOZZWQ
	 EoA+aFfsF22NQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1CD0617E13B9;
	Thu,  2 Oct 2025 11:37:11 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: sboyd@kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	srini@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	sre@kernel.org,
	krzysztof.kozlowski@linaro.org,
	u.kleine-koenig@baylibre.com,
	angelogioacchino.delregno@collabora.com,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com,
	wenst@chromium.org,
	casey.connolly@linaro.org,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v5 6/7] iio: adc: qcom-spmi-iadc: Migrate to devm_spmi_subdevice_alloc_and_add()
Date: Thu,  2 Oct 2025 11:36:56 +0200
Message-ID: <20251002093657.2055332-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002093657.2055332-1-angelogioacchino.delregno@collabora.com>
References: <20251002093657.2055332-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Qualcomm PMICs integrate an Current ADC device, reachable
in a specific address range over SPMI.

Instead of using the parent SPMI device (the main PMIC) as a kind
of syscon in this driver, register a new SPMI sub-device and
initialize its own regmap with this sub-device's specific base
address, retrieved from the devicetree.

This allows to stop manually adding the register base address to
every R/W call in this driver, as this can be, and is now, handled
by the regmap API instead.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iio/adc/qcom-spmi-iadc.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-iadc.c b/drivers/iio/adc/qcom-spmi-iadc.c
index b64a8a407168..67096952b229 100644
--- a/drivers/iio/adc/qcom-spmi-iadc.c
+++ b/drivers/iio/adc/qcom-spmi-iadc.c
@@ -16,6 +16,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
+#include <linux/spmi.h>
 
 /* IADC register and bit definition */
 #define IADC_REVISION2				0x1
@@ -94,7 +95,6 @@
  * struct iadc_chip - IADC Current ADC device structure.
  * @regmap: regmap for register read/write.
  * @dev: This device pointer.
- * @base: base offset for the ADC peripheral.
  * @rsense: Values of the internal and external sense resister in micro Ohms.
  * @poll_eoc: Poll for end of conversion instead of waiting for IRQ.
  * @offset: Raw offset values for the internal and external channels.
@@ -105,7 +105,6 @@
 struct iadc_chip {
 	struct regmap	*regmap;
 	struct device	*dev;
-	u16		base;
 	bool		poll_eoc;
 	u32		rsense[2];
 	u16		offset[2];
@@ -119,7 +118,7 @@ static int iadc_read(struct iadc_chip *iadc, u16 offset, u8 *data)
 	unsigned int val;
 	int ret;
 
-	ret = regmap_read(iadc->regmap, iadc->base + offset, &val);
+	ret = regmap_read(iadc->regmap, offset, &val);
 	if (ret < 0)
 		return ret;
 
@@ -129,7 +128,7 @@ static int iadc_read(struct iadc_chip *iadc, u16 offset, u8 *data)
 
 static int iadc_write(struct iadc_chip *iadc, u16 offset, u8 data)
 {
-	return regmap_write(iadc->regmap, iadc->base + offset, data);
+	return regmap_write(iadc->regmap, offset, data);
 }
 
 static int iadc_reset(struct iadc_chip *iadc)
@@ -270,7 +269,7 @@ static int iadc_poll_wait_eoc(struct iadc_chip *iadc, unsigned int interval_us)
 
 static int iadc_read_result(struct iadc_chip *iadc, u16 *data)
 {
-	return regmap_bulk_read(iadc->regmap, iadc->base + IADC_DATA, data, 2);
+	return regmap_bulk_read(iadc->regmap, IADC_DATA, data, 2);
 }
 
 static int iadc_do_conversion(struct iadc_chip *iadc, int chan, u16 *data)
@@ -483,12 +482,19 @@ static const struct iio_chan_spec iadc_channels[] = {
 
 static int iadc_probe(struct platform_device *pdev)
 {
+	struct regmap_config iadc_regmap_config = {
+		.reg_bits = 16,
+		.val_bits = 8,
+		.max_register = 0x100,
+		.fast_io = true,
+	};
 	struct device_node *node = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
+	struct spmi_subdevice *sub_sdev;
+	struct spmi_device *sparent;
 	struct iio_dev *indio_dev;
 	struct iadc_chip *iadc;
 	int ret, irq_eoc;
-	u32 res;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*iadc));
 	if (!indio_dev)
@@ -497,18 +503,21 @@ static int iadc_probe(struct platform_device *pdev)
 	iadc = iio_priv(indio_dev);
 	iadc->dev = dev;
 
-	iadc->regmap = dev_get_regmap(dev->parent, NULL);
-	if (!iadc->regmap)
-		return -ENODEV;
+	sparent = to_spmi_device(dev->parent);
+	sub_sdev = devm_spmi_subdevice_alloc_and_add(dev, sparent);
+	if (IS_ERR(sub_sdev))
+		return PTR_ERR(sub_sdev);
 
 	init_completion(&iadc->complete);
 	mutex_init(&iadc->lock);
 
-	ret = of_property_read_u32(node, "reg", &res);
+	ret = of_property_read_u32(node, "reg", &iadc_regmap_config.reg_base);
 	if (ret < 0)
 		return -ENODEV;
 
-	iadc->base = res;
+	iadc->regmap = devm_regmap_init_spmi_ext(&sub_sdev->sdev, &iadc_regmap_config);
+	if (IS_ERR(iadc->regmap))
+		return PTR_ERR(iadc->regmap);
 
 	ret = iadc_version_check(iadc);
 	if (ret < 0)
@@ -584,3 +593,4 @@ MODULE_ALIAS("platform:qcom-spmi-iadc");
 MODULE_DESCRIPTION("Qualcomm SPMI PMIC current ADC driver");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Ivan T. Ivanov <iivanov@mm-sol.com>");
+MODULE_IMPORT_NS("SPMI");
-- 
2.51.0


