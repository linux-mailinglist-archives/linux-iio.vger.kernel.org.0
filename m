Return-Path: <linux-iio+bounces-3630-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F2E8806BA
	for <lists+linux-iio@lfdr.de>; Tue, 19 Mar 2024 22:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 969F0284717
	for <lists+linux-iio@lfdr.de>; Tue, 19 Mar 2024 21:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A083FBB1;
	Tue, 19 Mar 2024 21:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhZJ8egh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FE63FBB3
	for <linux-iio@vger.kernel.org>; Tue, 19 Mar 2024 21:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710883685; cv=none; b=qeV6JsSLL52++rXIS2IpRmx94sq6xUtfoNfkw3rd+d656x1wGc3OzvI9jodt768OvbYZKTaSOBerk/LbsAxlERgsPl23EpUDCsApOLgYV+NpS5YjKSj35c1IKMDMkKRTUGdm5Eiuh2vCXxX+C1ON4Tstb7fbHsQ4G2PM9cchr5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710883685; c=relaxed/simple;
	bh=13+Mn6Z2UDv6xEP66ALMY5mJJhZQcCd0r4gVSWdT5HU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y/HcWQq4qaE4r1jJKiY+RdR5pygxQS8rz8XGNPFQQwRcveKr5q8tHnqn1XJ6z+u89vcHUyYTnbvGbfb8sBfeP/4ljbm+PXFFaYwOSv6BB6ebklFs2YDCp8usPS+p7iukXs406gtyzBHOI2FZrk4lSMKozxXSu65rTZeR7O5nzqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhZJ8egh; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a46ba938de0so403167666b.3
        for <linux-iio@vger.kernel.org>; Tue, 19 Mar 2024 14:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710883681; x=1711488481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ob8mFoTmG9ZxpfffQqyjIgPUeljaNOnkH+8KoFKPT2U=;
        b=XhZJ8eghrl4Cea1vw3MqZW5u43tnYWQMy1ZaRiJassU1IAhO4BywkHAWrHQ+vpplfS
         /tGBj/kqo+JLgH1yVMcCnkrJgc5qrh9uq1Wf0jA4NnwEH2mq4w4aPMumFV9JEXIVhXrF
         rG8HEEAjzr687Kb3rea6TJvMoELaR6EfBF2lIedWGpRAFwa1xZ8vcAFfoJ93KfJHOsef
         LFN3RNva6Kw3xcSRXuh0LCQBcjbjlKzk2D9XECbzad8+TqvWeDNqvzDRojGJ9Ix/Q7cV
         PvcoY4ztZ8uzNj00iOFw0pZL3USs7D+W+rXpxIAdvfIlljlvx5lredegjt2PLETXnTnZ
         O9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710883681; x=1711488481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ob8mFoTmG9ZxpfffQqyjIgPUeljaNOnkH+8KoFKPT2U=;
        b=vM+VHU2FphRV+2QyGbk+DlRfnL3Y3Pkhea7qXP8/uJRoxKxlDJoaJrxDj2jecTV322
         dNo0JtHD9QVIndIXRsMXYM2wehOjKF3nlxq8zpSo/kmXyK1LuprFtVUqLkvFYK524vRa
         rA8TZ7tHvL7JzaE6EuFpmpPLw9A9G2h4yhvr6ClrdSr5DM67dnOsz9H4FZjXpKX08YeK
         R0oOZJFur0nXVYdUyrSXg/MQYbRjVB1GznQCGd3VC5jokgTMdMFzrtu1SUQovAIKnUts
         R7oiP5W6ZJyZNa4TzybD7n1pXpblbKc2s+PNPbPlveQ+C+9jd3nsDIDSkPTddNSgvhne
         ID6w==
X-Gm-Message-State: AOJu0YzkjxtI5Jqw1Wvs4v2m0Jry3eft4yynyvkWAXMOv20DQlDhBWic
	2ohLvpgKPBca1r1Sf/li877UbmAiVPozB2fxuL+H1u4/MR6vj6jW
X-Google-Smtp-Source: AGHT+IEY734lGjF2PH+1XYbWjUoMsYYW6NCFKbWKvInUJ19FXWDG/hnxbx2OqdSDs9r/F8x0zPqPdA==
X-Received: by 2002:a17:907:9710:b0:a46:a3dc:3359 with SMTP id jg16-20020a170907971000b00a46a3dc3359mr9283491ejc.46.1710883681362;
        Tue, 19 Mar 2024 14:28:01 -0700 (PDT)
Received: from a989ef099cc9.v.cablecom.net (46-126-232-210.dynamic.hispeed.ch. [46.126.232.210])
        by smtp.gmail.com with ESMTPSA id a3-20020a17090640c300b00a46a4a14555sm4402518ejk.86.2024.03.19.14.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 14:28:01 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH 1/2] iio: adxl345: add spi-3wire
Date: Tue, 19 Mar 2024 21:27:12 +0000
Message-Id: <20240319212713.257600-2-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240319212713.257600-1-l.rubusch@gmail.com>
References: <20240319212713.257600-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds the spi-3wire feature and adds general refactoring to the
iio driver.

The patch moves driver wide constants and fields into the
header. Thereby reduces redundant info struct definitions.
Allows to pass a function pointer from SPI/I2C specific probe,
and smaller refactorings. A regmap_update_bits() in the core
file replaces the regmap_write() to format_data.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h      |  44 +++++++++++-
 drivers/iio/accel/adxl345_core.c | 116 +++++++++++++++++--------------
 drivers/iio/accel/adxl345_i2c.c  |  30 ++++----
 drivers/iio/accel/adxl345_spi.c  |  50 ++++++++-----
 4 files changed, 153 insertions(+), 87 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index 284bd387c..01493c999 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -8,6 +8,39 @@
 #ifndef _ADXL345_H_
 #define _ADXL345_H_
 
+#include <linux/iio/iio.h>
+
+/* ADXL345 register definitions */
+#define ADXL345_REG_DEVID		0x00
+#define ADXL345_REG_OFSX		0x1E
+#define ADXL345_REG_OFSY		0x1F
+#define ADXL345_REG_OFSZ		0x20
+#define ADXL345_REG_OFS_AXIS(index)	(ADXL345_REG_OFSX + (index))
+#define ADXL345_REG_BW_RATE		0x2C
+#define ADXL345_REG_POWER_CTL		0x2D
+#define ADXL345_REG_DATA_FORMAT		0x31
+#define ADXL345_REG_DATAX0		0x32
+#define ADXL345_REG_DATAY0		0x34
+#define ADXL345_REG_DATAZ0		0x36
+#define ADXL345_REG_DATA_AXIS(index)	\
+	(ADXL345_REG_DATAX0 + (index) * sizeof(__le16))
+
+#define ADXL345_BW_RATE			GENMASK(3, 0)
+#define ADXL345_BASE_RATE_NANO_HZ	97656250LL
+
+#define ADXL345_POWER_CTL_MEASURE	BIT(3)
+#define ADXL345_POWER_CTL_STANDBY	0x00
+
+#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3) /* Up to 13-bits resolution */
+#define ADXL345_DATA_FORMAT_SPI         BIT(6) /* spi-3wire */
+#define ADXL345_DATA_FORMAT_2G		0
+#define ADXL345_DATA_FORMAT_4G		1
+#define ADXL345_DATA_FORMAT_8G		2
+#define ADXL345_DATA_FORMAT_16G		3
+#define ADXL345_DATA_FORMAT_MSK		~((u8) BIT(6)) /* ignore spi-3wire */
+
+#define ADXL345_DEVID			0xE5
+
 /*
  * In full-resolution mode, scale factor is maintained at ~4 mg/LSB
  * in all g ranges.
@@ -23,11 +56,20 @@
  */
 #define ADXL375_USCALE	480000
 
+enum adxl345_device_type {
+	ADXL345,
+	ADXL375,
+};
+
 struct adxl345_chip_info {
 	const char *name;
 	int uscale;
 };
 
-int adxl345_core_probe(struct device *dev, struct regmap *regmap);
+extern const struct adxl345_chip_info adxl3x5_chip_info[];
+
+int adxl345_core_probe(struct device *dev, struct regmap *regmap,
+		       const struct adxl345_chip_info *chip_info,
+		       int (*setup)(struct device*, struct regmap*));
 
 #endif /* _ADXL345_H_ */
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 8bd30a23e..3c0e14b41 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -17,38 +17,9 @@
 
 #include "adxl345.h"
 
-#define ADXL345_REG_DEVID		0x00
-#define ADXL345_REG_OFSX		0x1e
-#define ADXL345_REG_OFSY		0x1f
-#define ADXL345_REG_OFSZ		0x20
-#define ADXL345_REG_OFS_AXIS(index)	(ADXL345_REG_OFSX + (index))
-#define ADXL345_REG_BW_RATE		0x2C
-#define ADXL345_REG_POWER_CTL		0x2D
-#define ADXL345_REG_DATA_FORMAT		0x31
-#define ADXL345_REG_DATAX0		0x32
-#define ADXL345_REG_DATAY0		0x34
-#define ADXL345_REG_DATAZ0		0x36
-#define ADXL345_REG_DATA_AXIS(index)	\
-	(ADXL345_REG_DATAX0 + (index) * sizeof(__le16))
-
-#define ADXL345_BW_RATE			GENMASK(3, 0)
-#define ADXL345_BASE_RATE_NANO_HZ	97656250LL
-
-#define ADXL345_POWER_CTL_MEASURE	BIT(3)
-#define ADXL345_POWER_CTL_STANDBY	0x00
-
-#define ADXL345_DATA_FORMAT_FULL_RES	BIT(3) /* Up to 13-bits resolution */
-#define ADXL345_DATA_FORMAT_2G		0
-#define ADXL345_DATA_FORMAT_4G		1
-#define ADXL345_DATA_FORMAT_8G		2
-#define ADXL345_DATA_FORMAT_16G		3
-
-#define ADXL345_DEVID			0xE5
-
 struct adxl345_data {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
-	u8 data_range;
 };
 
 #define ADXL345_CHANNEL(index, axis) {					\
@@ -62,6 +33,18 @@ struct adxl345_data {
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
 }
 
+const struct adxl345_chip_info adxl3x5_chip_info[] = {
+	[ADXL345] = {
+		.name = "adxl345",
+		.uscale = ADXL345_USCALE,
+	},
+	[ADXL375] = {
+		.name = "adxl375",
+		.uscale = ADXL375_USCALE,
+	},
+};
+EXPORT_SYMBOL_NS_GPL(adxl3x5_chip_info, IIO_ADXL345);
+
 static const struct iio_chan_spec adxl345_channels[] = {
 	ADXL345_CHANNEL(0, X),
 	ADXL345_CHANNEL(1, Y),
@@ -197,14 +180,21 @@ static void adxl345_powerdown(void *regmap)
 	regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_STANDBY);
 }
 
-int adxl345_core_probe(struct device *dev, struct regmap *regmap)
+static int adxl345_setup(struct device *dev, struct adxl345_data *data,
+			 int (*setup)(struct device*, struct regmap*))
 {
-	struct adxl345_data *data;
-	struct iio_dev *indio_dev;
 	u32 regval;
 	int ret;
 
-	ret = regmap_read(regmap, ADXL345_REG_DEVID, &regval);
+	/* Perform bus specific settings if available */
+	if (setup) {
+		ret = setup(dev, data->regmap);
+		if (ret)
+			return ret;
+	}
+
+	/* Read out DEVID */
+	ret = regmap_read(data->regmap, ADXL345_REG_DEVID, &regval);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Error reading device ID\n");
 
@@ -212,37 +202,61 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap)
 		return dev_err_probe(dev, -ENODEV, "Invalid device ID: %x, expected %x\n",
 				     regval, ADXL345_DEVID);
 
+	/* Update data_format to full-resolution mode */
+	ret = regmap_update_bits(data->regmap, ADXL345_REG_DATA_FORMAT,
+				 ADXL345_DATA_FORMAT_MSK, ADXL345_DATA_FORMAT_FULL_RES);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to update data_format register\n");
+
+	/* Enable measurement mode */
+	ret = adxl345_powerup(data->regmap);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to enable measurement mode\n");
+
+	ret = devm_add_action_or_reset(dev, adxl345_powerdown, data->regmap);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+/**
+ * adxl345_core_probe() - probe and setup for the adxl345 accelerometer,
+ *                        also covers the adlx375 accelerometer
+ * @dev:	Driver model representation of the device
+ * @regmap:	Regmap instance for the device
+ * @setup:	Setup routine to be executed right before the standard device
+ *		setup, can also be set to NULL if not required
+ *
+ * Return: 0 on success, negative errno on error
+ */
+int adxl345_core_probe(struct device *dev, struct regmap *regmap,
+		       const struct adxl345_chip_info *chip_info,
+		       int (*setup)(struct device*, struct regmap*))
+{
+	struct adxl345_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
 	data->regmap = regmap;
-	/* Enable full-resolution mode */
-	data->data_range = ADXL345_DATA_FORMAT_FULL_RES;
-	data->info = device_get_match_data(dev);
-	if (!data->info)
-		return -ENODEV;
-
-	ret = regmap_write(data->regmap, ADXL345_REG_DATA_FORMAT,
-			   data->data_range);
-	if (ret < 0)
-		return dev_err_probe(dev, ret, "Failed to set data range\n");
+	data->info = chip_info;
 
-	indio_dev->name = data->info->name;
+	indio_dev->name = chip_info->name;
 	indio_dev->info = &adxl345_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = adxl345_channels;
 	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
 
-	/* Enable measurement mode */
-	ret = adxl345_powerup(data->regmap);
-	if (ret < 0)
-		return dev_err_probe(dev, ret, "Failed to enable measurement mode\n");
-
-	ret = devm_add_action_or_reset(dev, adxl345_powerdown, data->regmap);
-	if (ret < 0)
+	ret = adxl345_setup(dev, data, setup);
+	if (ret) {
+		dev_err(dev, "ADXL345 setup failed\n");
 		return ret;
+	}
 
 	return devm_iio_device_register(dev, indio_dev);
 }
diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
index a3084b0a8..3f882e2e0 100644
--- a/drivers/iio/accel/adxl345_i2c.c
+++ b/drivers/iio/accel/adxl345_i2c.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 
@@ -21,41 +22,36 @@ static const struct regmap_config adxl345_i2c_regmap_config = {
 
 static int adxl345_i2c_probe(struct i2c_client *client)
 {
+	const struct adxl345_chip_info *chip_data;
 	struct regmap *regmap;
 
+	/* Retrieve device data, i.e. the name, to pass it to the core */
+	chip_data = i2c_get_match_data(client);
+
 	regmap = devm_regmap_init_i2c(client, &adxl345_i2c_regmap_config);
 	if (IS_ERR(regmap))
-		return dev_err_probe(&client->dev, PTR_ERR(regmap), "Error initializing regmap\n");
+		return dev_err_probe(&client->dev, PTR_ERR(regmap),
+				     "Error initializing regmap\n");
 
-	return adxl345_core_probe(&client->dev, regmap);
+	return adxl345_core_probe(&client->dev, regmap, chip_data, NULL);
 }
 
-static const struct adxl345_chip_info adxl345_i2c_info = {
-	.name = "adxl345",
-	.uscale = ADXL345_USCALE,
-};
-
-static const struct adxl345_chip_info adxl375_i2c_info = {
-	.name = "adxl375",
-	.uscale = ADXL375_USCALE,
-};
-
 static const struct i2c_device_id adxl345_i2c_id[] = {
-	{ "adxl345", (kernel_ulong_t)&adxl345_i2c_info },
-	{ "adxl375", (kernel_ulong_t)&adxl375_i2c_info },
+	{ "adxl345", (kernel_ulong_t)&adxl3x5_chip_info[ADXL345] },
+	{ "adxl375", (kernel_ulong_t)&adxl3x5_chip_info[ADXL375] },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adxl345_i2c_id);
 
 static const struct of_device_id adxl345_of_match[] = {
-	{ .compatible = "adi,adxl345", .data = &adxl345_i2c_info },
-	{ .compatible = "adi,adxl375", .data = &adxl375_i2c_info },
+	{ .compatible = "adi,adxl345", .data = &adxl3x5_chip_info[ADXL345] },
+	{ .compatible = "adi,adxl375", .data = &adxl3x5_chip_info[ADXL375] },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adxl345_of_match);
 
 static const struct acpi_device_id adxl345_acpi_match[] = {
-	{ "ADS0345", (kernel_ulong_t)&adxl345_i2c_info },
+	{ "ADS0345", (kernel_ulong_t)&adxl3x5_chip_info[ADXL345] },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, adxl345_acpi_match);
diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
index 93ca349f1..e456b61c6 100644
--- a/drivers/iio/accel/adxl345_spi.c
+++ b/drivers/iio/accel/adxl345_spi.c
@@ -20,48 +20,62 @@ static const struct regmap_config adxl345_spi_regmap_config = {
 	.read_flag_mask = BIT(7) | BIT(6),
 };
 
+static int adxl345_spi_setup(struct device *dev, struct regmap *regmap)
+{
+	struct spi_device *spi = container_of(dev, struct spi_device, dev);
+	int ret;
+
+	if (spi->mode & SPI_3WIRE) {
+		ret = regmap_write(regmap, ADXL345_REG_DATA_FORMAT,
+				   ADXL345_DATA_FORMAT_SPI);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int adxl345_spi_probe(struct spi_device *spi)
 {
+	const struct adxl345_chip_info *chip_data;
 	struct regmap *regmap;
 
+	/* Retrieve device name to pass it as driver specific data */
+	chip_data = device_get_match_data(&spi->dev);
+	if (!chip_data)
+		chip_data = (const struct adxl345_chip_info *) spi_get_device_id(spi)->driver_data;
+
 	/* Bail out if max_speed_hz exceeds 5 MHz */
 	if (spi->max_speed_hz > ADXL345_MAX_SPI_FREQ_HZ)
 		return dev_err_probe(&spi->dev, -EINVAL, "SPI CLK, %d Hz exceeds 5 MHz\n",
 				     spi->max_speed_hz);
 
 	regmap = devm_regmap_init_spi(spi, &adxl345_spi_regmap_config);
-	if (IS_ERR(regmap))
-		return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing regmap\n");
+	if (IS_ERR(regmap)) {
+		dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing spi regmap: %ld\n",
+			      PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
 
-	return adxl345_core_probe(&spi->dev, regmap);
+	return adxl345_core_probe(&spi->dev, regmap, chip_data, &adxl345_spi_setup);
 }
 
-static const struct adxl345_chip_info adxl345_spi_info = {
-	.name = "adxl345",
-	.uscale = ADXL345_USCALE,
-};
-
-static const struct adxl345_chip_info adxl375_spi_info = {
-	.name = "adxl375",
-	.uscale = ADXL375_USCALE,
-};
-
 static const struct spi_device_id adxl345_spi_id[] = {
-	{ "adxl345", (kernel_ulong_t)&adxl345_spi_info },
-	{ "adxl375", (kernel_ulong_t)&adxl375_spi_info },
+	{ "adxl345", (kernel_ulong_t)&adxl3x5_chip_info[ADXL345] },
+	{ "adxl375", (kernel_ulong_t)&adxl3x5_chip_info[ADXL375] },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adxl345_spi_id);
 
 static const struct of_device_id adxl345_of_match[] = {
-	{ .compatible = "adi,adxl345", .data = &adxl345_spi_info },
-	{ .compatible = "adi,adxl375", .data = &adxl375_spi_info },
+	{ .compatible = "adi,adxl345", .data = &adxl3x5_chip_info[ADXL345] },
+	{ .compatible = "adi,adxl375", .data = &adxl3x5_chip_info[ADXL375] },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adxl345_of_match);
 
 static const struct acpi_device_id adxl345_acpi_match[] = {
-	{ "ADS0345", (kernel_ulong_t)&adxl345_spi_info },
+	{ "ADS0345", (kernel_ulong_t)&adxl3x5_chip_info[ADXL345] },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, adxl345_acpi_match);
-- 
2.25.1


