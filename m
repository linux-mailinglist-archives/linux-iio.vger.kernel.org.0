Return-Path: <linux-iio+bounces-22700-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1B2B25717
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 00:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C2825A2ADE
	for <lists+linux-iio@lfdr.de>; Wed, 13 Aug 2025 22:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DAB30E837;
	Wed, 13 Aug 2025 22:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gkg6hW4C"
X-Original-To: linux-iio@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880B927602D;
	Wed, 13 Aug 2025 22:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755125930; cv=none; b=UHrLYMK5bxsOXMHjndtKHr4z7gT0Ojr4+X58EzKLposD5Jp5QM+m8U4av++TeMl9ivtYRNOSG2Cmv/DU25VxXVsL0cHgESJYDNWo/ojGWvHBQZrvPGcq14jSWe5h8zRrYjHBkfp2/QP7bX9Vdmeg/cclIRXFEQ9ffhFx4LhNXZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755125930; c=relaxed/simple;
	bh=50Gb0Cv9SpCx6KpyNhi7BXs2M/W44Ob0FCXBu9F7Wgc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WzPVjqa3DFAJrrhwV8lZ6v7VzUAQX0QFoJV0GTnM/AeEu2GJF5Z6qjOrArKP3cfxZUX94FPP/ubAVl7OonP0pIYjdNHE8yAUaiUx5Pz/rWSt6Ac3RCXaokR2R66vhZlmKo5nkpAqS28h5Ee0ihr1WuWVfB/IGVOSpOz+rj+grT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gkg6hW4C; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DMwg6n1746898;
	Wed, 13 Aug 2025 17:58:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755125922;
	bh=CUzvTxuHRjq/A0LXgtM9M1i/fkxIwWIM+2nDNcUDIqQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=gkg6hW4C1X3fizsbWS3IRsinB/zsGU1gn3L45tTOEQ47SQ64jZIHGzgTrFnnN1Hfv
	 jSh6yCVOZOc4Og8uvoRGigsUrji0LqhcVP6wXQdCKGViEJD/rUvV4Af781n1+9BE3b
	 JNBB5jARjEwGo3JOwDWXhn83Bjawze/TNRlEazBM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DMwgk3714037
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 17:58:42 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 17:58:42 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 17:58:42 -0500
Received: from lelvem-mr05.itg.ti.com ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DMwfwc2683333;
	Wed, 13 Aug 2025 17:58:42 -0500
From: Andrew Davis <afd@ti.com>
To: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 4/6] iio: health: afe4404: Do not store dev pointer in device struct
Date: Wed, 13 Aug 2025 17:58:38 -0500
Message-ID: <20250813225840.576305-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250813225840.576305-1-afd@ti.com>
References: <20250813225840.576305-1-afd@ti.com>
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
 drivers/iio/health/afe4404.c | 46 +++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index b2727effecaae..29e030943f599 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -77,7 +77,6 @@ static const struct reg_field afe4404_reg_fields[] = {
 
 /**
  * struct afe4404_data - AFE4404 device instance data
- * @dev: Device structure
  * @regmap: Register map of the device
  * @fields: Register fields of the device
  * @regulator: Pointer to the regulator for the IC
@@ -86,7 +85,6 @@ static const struct reg_field afe4404_reg_fields[] = {
  * @buffer: Used to construct a scan to push to the iio buffer.
  */
 struct afe4404_data {
-	struct device *dev;
 	struct regmap *regmap;
 	struct regmap_field *fields[F_MAX_FIELDS];
 	struct regulator *regulator;
@@ -468,62 +466,62 @@ static DEFINE_SIMPLE_DEV_PM_OPS(afe4404_pm_ops, afe4404_suspend,
 
 static int afe4404_probe(struct i2c_client *client)
 {
+	struct device *dev = &client->dev;
 	struct iio_dev *indio_dev;
 	struct afe4404_data *afe;
 	int i, ret;
 
-	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*afe));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*afe));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	afe = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 
-	afe->dev = &client->dev;
 	afe->irq = client->irq;
 
 	afe->regmap = devm_regmap_init_i2c(client, &afe4404_regmap_config);
 	if (IS_ERR(afe->regmap)) {
-		dev_err(afe->dev, "Unable to allocate register map\n");
+		dev_err(dev, "Unable to allocate register map\n");
 		return PTR_ERR(afe->regmap);
 	}
 
 	for (i = 0; i < F_MAX_FIELDS; i++) {
-		afe->fields[i] = devm_regmap_field_alloc(afe->dev, afe->regmap,
+		afe->fields[i] = devm_regmap_field_alloc(dev, afe->regmap,
 							 afe4404_reg_fields[i]);
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
-	ret = devm_add_action_or_reset(afe->dev, afe4404_regulator_disable, afe->regulator);
+	ret = devm_add_action_or_reset(dev, afe4404_regulator_disable, afe->regulator);
 	if (ret) {
-		dev_err(afe->dev, "Unable to enable regulator\n");
+		dev_err(dev, "Unable to enable regulator\n");
 		return ret;
 	}
 
 	ret = regmap_write(afe->regmap, AFE440X_CONTROL0,
 			   AFE440X_CONTROL0_SW_RESET);
 	if (ret) {
-		dev_err(afe->dev, "Unable to reset device\n");
+		dev_err(dev, "Unable to reset device\n");
 		return ret;
 	}
 
 	ret = regmap_multi_reg_write(afe->regmap, afe4404_reg_sequences,
 				     ARRAY_SIZE(afe4404_reg_sequences));
 	if (ret) {
-		dev_err(afe->dev, "Unable to set register defaults\n");
+		dev_err(dev, "Unable to set register defaults\n");
 		return ret;
 	}
 
@@ -534,45 +532,45 @@ static int afe4404_probe(struct i2c_client *client)
 	indio_dev->info = &afe4404_iio_info;
 
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
 						AFE4404_DRIVER_NAME,
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
 					      afe4404_trigger_handler, NULL);
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


