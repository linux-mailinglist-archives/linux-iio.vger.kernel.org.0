Return-Path: <linux-iio+bounces-22696-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE711B25718
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 00:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD431C814BF
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 22:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BAC2E092F;
	Wed, 13 Aug 2025 22:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="szHced91"
X-Original-To: linux-iio@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AFB26CE2B;
	Wed, 13 Aug 2025 22:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755125929; cv=none; b=I3mqZrK5GPHX717GwDWDgdU5eZ2as0u63Qu2SpfTqEMlkMGxxo18k0lABnmALvbJl1jK/gXt/G5UeM9HpxJIi2fY3G0/l0ZAMUdqZAcBSwsI1RIWBEelLvBO9Qx0+4FGYFujG5bZa+twwl+9BTZZo7nTjuuN4yDnQ3kRYma/P5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755125929; c=relaxed/simple;
	bh=BWl5Ni9oAG/vT86wSHxw6vjQGz1VD+7DoWvmJWYV23Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BHvAasmBaH1ZYInPg2cal6/KcpLMfSxq4D7sfsRx2xsiOiL65Ka/nFlOSa/WEJUYWuEpbFY4PPjrtTy0KlQxgWMoaWX5d9axVpNyn/8Joz3R5eyZOdE9KHqDeaYt61Yv20wmOdLTs/lv2b3rILw/lskKcjbh16zleQxOzlo0Syc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=szHced91; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DMwfLb1798725;
	Wed, 13 Aug 2025 17:58:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755125921;
	bh=ouibXNAKPpw4uMgEAy01Uv1jJgMVTtPjn5+ele7LZbw=;
	h=From:To:CC:Subject:Date;
	b=szHced91c212HS2T0uudsYmIifs5VCPPyXzbFrc3NoR2y7LqnwAYXH0yS4cPR8kpY
	 js8pja3CIYiERpbpcJmeYC52zkwBY8P/YTnMzg7Le4PNICazANOoSZGOZtUzlPv4QO
	 X2anAS4lIkWSaxczeHc8TeSUI6FWDOF2gHNdPWbo=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DMwfkr390334
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 17:58:41 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 17:58:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 17:58:41 -0500
Received: from lelvem-mr05.itg.ti.com ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DMwfwZ2683333;
	Wed, 13 Aug 2025 17:58:41 -0500
From: Andrew Davis <afd@ti.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 1/6] iio: health: afe4403: Do not store dev pointer in device struct
Date: Wed, 13 Aug 2025 17:58:35 -0500
Message-ID: <20250813225840.576305-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The device *dev is only used in probe(), so no need to store it
in the device local data struct. In all the places in probe()
we did use that, just use a new local variable for the same.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/iio/health/afe4403.c | 46 +++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index 30d3f984b0323..99bf1bcbea40d 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -58,7 +58,6 @@ static const struct reg_field afe4403_reg_fields[] = {
 
 /**
  * struct afe4403_data - AFE4403 device instance data
- * @dev: Device structure
  * @spi: SPI device handle
  * @regmap: Register map of the device
  * @fields: Register fields of the device
@@ -68,7 +67,6 @@ static const struct reg_field afe4403_reg_fields[] = {
  * @buffer: Used to construct data layout to push into IIO buffer.
  */
 struct afe4403_data {
-	struct device *dev;
 	struct spi_device *spi;
 	struct regmap *regmap;
 	struct regmap_field *fields[F_MAX_FIELDS];
@@ -460,63 +458,63 @@ static DEFINE_SIMPLE_DEV_PM_OPS(afe4403_pm_ops, afe4403_suspend,
 
 static int afe4403_probe(struct spi_device *spi)
 {
+	struct device *dev = &spi->dev;
 	struct iio_dev *indio_dev;
 	struct afe4403_data *afe;
 	int i, ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*afe));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*afe));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	afe = iio_priv(indio_dev);
 	spi_set_drvdata(spi, indio_dev);
 
-	afe->dev = &spi->dev;
 	afe->spi = spi;
 	afe->irq = spi->irq;
 
 	afe->regmap = devm_regmap_init_spi(spi, &afe4403_regmap_config);
 	if (IS_ERR(afe->regmap)) {
-		dev_err(afe->dev, "Unable to allocate register map\n");
+		dev_err(dev, "Unable to allocate register map\n");
 		return PTR_ERR(afe->regmap);
 	}
 
 	for (i = 0; i < F_MAX_FIELDS; i++) {
-		afe->fields[i] = devm_regmap_field_alloc(afe->dev, afe->regmap,
+		afe->fields[i] = devm_regmap_field_alloc(dev, afe->regmap,
 							 afe4403_reg_fields[i]);
 		if (IS_ERR(afe->fields[i])) {
-			dev_err(afe->dev, "Unable to allocate regmap fields\n");
+			dev_err(dev, "Unable to allocate regmap fields\n");
 			return PTR_ERR(afe->fields[i]);
 		}
 	}
 
-	afe->regulator = devm_regulator_get(afe->dev, "tx_sup");
+	afe->regulator = devm_regulator_get(dev, "tx_sup");
 	if (IS_ERR(afe->regulator))
-		return dev_err_probe(afe->dev, PTR_ERR(afe->regulator),
+		return dev_err_probe(dev, PTR_ERR(afe->regulator),
 				     "Unable to get regulator\n");
 
 	ret = regulator_enable(afe->regulator);
 	if (ret) {
-		dev_err(afe->dev, "Unable to enable regulator\n");
+		dev_err(dev, "Unable to enable regulator\n");
 		return ret;
 	}
-	ret = devm_add_action_or_reset(afe->dev, afe4403_regulator_disable, afe->regulator);
+	ret = devm_add_action_or_reset(dev, afe4403_regulator_disable, afe->regulator);
 	if (ret) {
-		dev_err(afe->dev, "Unable to add regulator disable action\n");
+		dev_err(dev, "Unable to add regulator disable action\n");
 		return ret;
 	}
 
 	ret = regmap_write(afe->regmap, AFE440X_CONTROL0,
 			   AFE440X_CONTROL0_SW_RESET);
 	if (ret) {
-		dev_err(afe->dev, "Unable to reset device\n");
+		dev_err(dev, "Unable to reset device\n");
 		return ret;
 	}
 
 	ret = regmap_multi_reg_write(afe->regmap, afe4403_reg_sequences,
 				     ARRAY_SIZE(afe4403_reg_sequences));
 	if (ret) {
-		dev_err(afe->dev, "Unable to set register defaults\n");
+		dev_err(dev, "Unable to set register defaults\n");
 		return ret;
 	}
 
@@ -527,45 +525,45 @@ static int afe4403_probe(struct spi_device *spi)
 	indio_dev->info = &afe4403_iio_info;
 
 	if (afe->irq > 0) {
-		afe->trig = devm_iio_trigger_alloc(afe->dev,
+		afe->trig = devm_iio_trigger_alloc(dev,
 						   "%s-dev%d",
 						   indio_dev->name,
 						   iio_device_id(indio_dev));
 		if (!afe->trig) {
-			dev_err(afe->dev, "Unable to allocate IIO trigger\n");
+			dev_err(dev, "Unable to allocate IIO trigger\n");
 			return -ENOMEM;
 		}
 
 		iio_trigger_set_drvdata(afe->trig, indio_dev);
 
-		ret = devm_iio_trigger_register(afe->dev, afe->trig);
+		ret = devm_iio_trigger_register(dev, afe->trig);
 		if (ret) {
-			dev_err(afe->dev, "Unable to register IIO trigger\n");
+			dev_err(dev, "Unable to register IIO trigger\n");
 			return ret;
 		}
 
-		ret = devm_request_threaded_irq(afe->dev, afe->irq,
+		ret = devm_request_threaded_irq(dev, afe->irq,
 						iio_trigger_generic_data_rdy_poll,
 						NULL, IRQF_ONESHOT,
 						AFE4403_DRIVER_NAME,
 						afe->trig);
 		if (ret) {
-			dev_err(afe->dev, "Unable to request IRQ\n");
+			dev_err(dev, "Unable to request IRQ\n");
 			return ret;
 		}
 	}
 
-	ret = devm_iio_triggered_buffer_setup(afe->dev, indio_dev,
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      &iio_pollfunc_store_time,
 					      afe4403_trigger_handler, NULL);
 	if (ret) {
-		dev_err(afe->dev, "Unable to setup buffer\n");
+		dev_err(dev, "Unable to setup buffer\n");
 		return ret;
 	}
 
-	ret = devm_iio_device_register(afe->dev, indio_dev);
+	ret = devm_iio_device_register(dev, indio_dev);
 	if (ret) {
-		dev_err(afe->dev, "Unable to register IIO device\n");
+		dev_err(dev, "Unable to register IIO device\n");
 		return ret;
 	}
 
-- 
2.39.2


