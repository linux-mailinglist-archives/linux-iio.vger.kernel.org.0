Return-Path: <linux-iio+bounces-4994-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3978C3871
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 23:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6748E1F21EC0
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 21:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2164F5731F;
	Sun, 12 May 2024 21:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I7RblVRb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE29535A8;
	Sun, 12 May 2024 21:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715547908; cv=none; b=D0aGxAwmCXMfxamrks5K43QnV0nBDT2UkL1TMmymeCDyodcflFNbT9uZeWJZ93S12oeNnEMc5wYj4mniOtaAu8W4jtDThTj8XjLQQIhE+16zKaWsmUuMxydc65Bi67PrIUDjFiJIxr7D5MJXkm1uJlAmq9OQ1g4i/CB9HIeAObY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715547908; c=relaxed/simple;
	bh=kSkVCT7EdLVTKYXJtysBjB3fkXxJDOE82W+bUwZ79IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJbVXhxU8MUUHgyxG+aBkGRSW5cA9ZlPJV2NeCPzZ0+NNHf12uWmhKjAYkvs22XszidtGMn2QyzSruZpqwW1WrxFPnRr9bH/b0ez+YQBFKaUaOl+6aP7VGd5LMouqbRy5DMUvkoesKnv6yBtSnvye3uf4mzKKYQnTt9N6h2VG+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I7RblVRb; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f449ea8e37so3186085b3a.3;
        Sun, 12 May 2024 14:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715547906; x=1716152706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXNmcPYYZhWu8dfgwHkSNbCKCKZlU7WbCoJiDALHIBk=;
        b=I7RblVRbOoEgbw/KA2moujX0nWOUrqWGi2dzAieFYoRPYTCtiDbROcQEbql5Mhzm+O
         QMjoNaCq0MOkPXmmOe/c1q/N73vQ/76moQg0zS3c1gJ2JdbdzJWqD20Euf2ScvYzX7j0
         MjkIje0gfFzISRP3SBZ291b2yKKA2BnqaTDrhO6mrmUVG2brAgG6FszYleDSSVB1FWcy
         Ulg/21hdfelAVhseRkGs50geJJvJI/gCNGXlShkefGn9gdCur3KHzz41wt2FovG8uccU
         814g5Pe94S5Gc4yNay7PukfwAGUKDMVkA/0mhCPaWXxuBGXoYd0fAnbhD7IPu2TiKZ9I
         jzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715547906; x=1716152706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXNmcPYYZhWu8dfgwHkSNbCKCKZlU7WbCoJiDALHIBk=;
        b=E0/lc0W2Pe/irqJK/EkXOskFVvBgi3//4UHnDQj5WoSSpVqWK7EpHpnukCUmPE49mb
         EcFdwU8u6WSfQLCMtHOYIflqp1kFtRTVFQv6u4kxniJxYwaN5D4WpsV0TazbX3bY8wlE
         25bwGGvzAH9faQp8C4LvTPJdUfBy/AhCfF5+4d81MUIVjMBXbFoNY+5yG4Es7DQth6tJ
         8ftFwbvMelSTqFM8NFdRhu+oGEM79dpsENBiwChdfe7yzJj193EJ/QC7THVC0jC4I7ew
         DlL0t4pJD3e5EhZaS0gp7iC4SAbPmyVRlzqxPVARJjq+nt7+pSTfIRIOPheALlWKi41P
         vMFw==
X-Forwarded-Encrypted: i=1; AJvYcCU8/RFmchEFiwbRi8Se2v46U6A2Anu7e68lrG4feDAh5B5yvOpLMHdW+BihF+7AyYWasNPm55XBUmpaZkuXBmCyTNXjSRqbazK1oGMA/4917x+0evCqgOS7fGt7pz2kqgjezVkN+yMZ1OPlerD6/OFFGwzNX1n9xkBvT7OfnNDvkpoEmQ==
X-Gm-Message-State: AOJu0YzR7a+xaeDr7kdXjqkauFslAnZ0Ug6R9SJ3IWjhxJ/A9M30On2T
	nEJzD239udHy2RV7494V93CzXSG372zwPrdq1JEllWYytw6XSDTS
X-Google-Smtp-Source: AGHT+IGzaD/0+5Qb3qAhJKM4iwNxi364QizOs80liqzRSfAHkvCZLGZ/L2ddZIkGxYYvaXg3b5g0HQ==
X-Received: by 2002:a05:6a20:1008:b0:1af:abef:c620 with SMTP id adf61e73a8af0-1afde0ecc9bmr11838750637.35.1715547906414;
        Sun, 12 May 2024 14:05:06 -0700 (PDT)
Received: from localhost.localdomain ([189.101.162.253])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340a447391sm6534865a12.3.2024.05.12.14.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 14:05:06 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
To: jic23@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lars@metafoo.de,
	christophe.jaillet@wanadoo.fr,
	gerald.loacker@wolfvision.net,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] iio: chemical: add driver for ENS160 sensor
Date: Sun, 12 May 2024 18:04:39 -0300
Message-ID: <20240512210444.30824-4-gustavograzs@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240512210444.30824-1-gustavograzs@gmail.com>
References: <20240512210444.30824-1-gustavograzs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ScioSense ENS160 is a digital metal oxide multi-gas sensor, designed
for indoor air quality monitoring. The driver supports readings of
CO2 and VOC, and can be accessed via both SPI and I2C.

Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
 drivers/iio/chemical/Kconfig       |  22 +++
 drivers/iio/chemical/Makefile      |   3 +
 drivers/iio/chemical/ens160.h      |   9 ++
 drivers/iio/chemical/ens160_core.c | 227 +++++++++++++++++++++++++++++
 drivers/iio/chemical/ens160_i2c.c  |  68 +++++++++
 drivers/iio/chemical/ens160_spi.c  |  69 +++++++++
 6 files changed, 398 insertions(+)
 create mode 100644 drivers/iio/chemical/ens160.h
 create mode 100644 drivers/iio/chemical/ens160_core.c
 create mode 100644 drivers/iio/chemical/ens160_i2c.c
 create mode 100644 drivers/iio/chemical/ens160_spi.c

diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index 02649ab81..e407afab8 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -76,6 +76,28 @@ config CCS811
 	  Say Y here to build I2C interface support for the AMS
 	  CCS811 VOC (Volatile Organic Compounds) sensor
 
+config ENS160
+	tristate "ScioSense ENS160 sensor driver"
+	depends on (I2C || SPI)
+	select REGMAP
+	select ENS160_I2C if I2C
+	select ENS160_SPI if SPI
+	help
+	  Say yes here to build support for ScioSense ENS160 multi-gas sensor.
+
+	  This driver can also be built as a module. If so, the module for I2C
+	  would be called ens160_i2c and ens160_spi for SPI support.
+
+config ENS160_I2C
+	tristate
+	depends on I2C && ENS160
+	select REGMAP_I2C
+
+config ENS160_SPI
+	tristate
+	depends on SPI && ENS160
+	select REGMAP_SPI
+
 config IAQCORE
 	tristate "AMS iAQ-Core VOC sensors"
 	depends on I2C
diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
index 2f3dee8bb..4866db06b 100644
--- a/drivers/iio/chemical/Makefile
+++ b/drivers/iio/chemical/Makefile
@@ -11,6 +11,9 @@ obj-$(CONFIG_BME680) += bme680_core.o
 obj-$(CONFIG_BME680_I2C) += bme680_i2c.o
 obj-$(CONFIG_BME680_SPI) += bme680_spi.o
 obj-$(CONFIG_CCS811)		+= ccs811.o
+obj-$(CONFIG_ENS160) += ens160_core.o
+obj-$(CONFIG_ENS160_I2C) += ens160_i2c.o
+obj-$(CONFIG_ENS160_SPI) += ens160_spi.o
 obj-$(CONFIG_IAQCORE)		+= ams-iaq-core.o
 obj-$(CONFIG_PMS7003) += pms7003.o
 obj-$(CONFIG_SCD30_CORE) += scd30_core.o
diff --git a/drivers/iio/chemical/ens160.h b/drivers/iio/chemical/ens160.h
new file mode 100644
index 000000000..3fd079bc4
--- /dev/null
+++ b/drivers/iio/chemical/ens160.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ENS160_H_
+#define ENS160_H_
+
+int ens160_core_probe(struct device *dev, struct regmap *regmap,
+		      const char *name);
+void ens160_core_remove(struct device *dev);
+
+#endif
diff --git a/drivers/iio/chemical/ens160_core.c b/drivers/iio/chemical/ens160_core.c
new file mode 100644
index 000000000..25593420d
--- /dev/null
+++ b/drivers/iio/chemical/ens160_core.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ScioSense ENS160 multi-gas sensor driver
+ *
+ * Copyright (c) 2024 Gustavo Silva <gustavograzs@gmail.com>
+ *
+ * Data sheet:
+ *  https://www.sciosense.com/wp-content/uploads/2023/12/ENS160-Datasheet.pdf
+ *
+ */
+
+#include <linux/bitfield.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include "ens160.h"
+
+#define ENS160_PART_ID 0x160
+
+#define ENS160_BOOTING_TIME_MS 10U
+
+#define ENS160_REG_PART_ID	0x00
+
+#define ENS160_REG_OPMODE	0x10
+
+#define ENS160_REG_MODE_DEEP_SLEEP	0x00
+#define ENS160_REG_MODE_IDLE		0x01
+#define ENS160_REG_MODE_STANDARD	0x02
+#define ENS160_REG_MODE_RESET		0xF0
+
+#define ENS160_REG_COMMAND		0x12
+#define ENS160_REG_COMMAND_GET_APPVER	0x0E
+#define ENS160_REG_COMMAND_CLRGPR	0xCC
+
+#define ENS160_REG_TEMP_IN		0x13
+#define ENS160_REG_RH_IN		0x15
+#define ENS160_REG_DEVICE_STATUS	0x20
+#define ENS160_REG_DATA_TVOC		0x22
+#define ENS160_REG_DATA_ECO2		0x24
+#define ENS160_REG_DATA_T		0x30
+#define ENS160_REG_DATA_RH		0x32
+#define ENS160_REG_GPR_READ4		0x4C
+
+#define ENS160_STATUS_VALIDITY_FLAG	GENMASK(3, 2)
+
+#define ENS160_STATUS_NORMAL	0x00
+
+struct ens160_data {
+	struct regmap *regmap;
+};
+
+static const struct iio_chan_spec ens160_channels[] = {
+	{
+		.type = IIO_CONCENTRATION,
+		.channel2 = IIO_MOD_VOC,
+		.modified = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.address = ENS160_REG_DATA_TVOC,
+	},
+	{
+		.type = IIO_CONCENTRATION,
+		.channel2 = IIO_MOD_CO2,
+		.modified = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.address = ENS160_REG_DATA_ECO2,
+	},
+};
+
+static int ens160_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct ens160_data *data = iio_priv(indio_dev);
+	__le16 buf;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_bulk_read(data->regmap, chan->address,
+					&buf, sizeof(buf));
+		if (ret)
+			return ret;
+		*val = le16_to_cpu(buf);
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->channel2) {
+		case IIO_MOD_CO2:
+			/* The sensor reads CO2 data as ppm */
+			*val = 0;
+			*val2 = 100;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_MOD_VOC:
+			/* The sensor reads VOC data as ppb */
+			*val = 0;
+			*val2 = 100;
+			return IIO_VAL_INT_PLUS_NANO;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int ens160_set_mode(struct ens160_data *data, u8 mode)
+{
+	int ret;
+
+	ret = regmap_write(data->regmap, ENS160_REG_OPMODE, mode);
+	if (ret)
+		return ret;
+
+	msleep(ENS160_BOOTING_TIME_MS);
+
+	return 0;
+}
+
+static int ens160_chip_init(struct ens160_data *data)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	u8 fw_version[3];
+	__le16 part_id;
+	unsigned int status;
+	int ret;
+
+	ret = ens160_set_mode(data, ENS160_REG_MODE_RESET);
+	if (ret)
+		return ret;
+
+	ret = regmap_bulk_read(data->regmap, ENS160_REG_PART_ID, &part_id,
+			       sizeof(part_id));
+	if (ret)
+		return ret;
+
+	if (le16_to_cpu(part_id) != ENS160_PART_ID)
+		return -ENODEV;
+
+	ret = ens160_set_mode(data, ENS160_REG_MODE_IDLE);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(data->regmap, ENS160_REG_COMMAND,
+			   ENS160_REG_COMMAND_CLRGPR);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(data->regmap, ENS160_REG_COMMAND,
+			   ENS160_REG_COMMAND_GET_APPVER);
+	if (ret)
+		return ret;
+
+	msleep(ENS160_BOOTING_TIME_MS);
+
+	ret = regmap_bulk_read(data->regmap, ENS160_REG_GPR_READ4,
+			       fw_version, sizeof(fw_version));
+	if (ret)
+		return ret;
+
+	msleep(ENS160_BOOTING_TIME_MS);
+
+	dev_info(dev, "firmware version: %u.%u.%u\n", fw_version[2],
+		 fw_version[1], fw_version[0]);
+
+	ret = ens160_set_mode(data, ENS160_REG_MODE_STANDARD);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap, ENS160_REG_DEVICE_STATUS, &status);
+	if (ret)
+		return ret;
+
+	if (FIELD_GET(ENS160_STATUS_VALIDITY_FLAG, status)
+	    != ENS160_STATUS_NORMAL)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct iio_info ens160_info = {
+	.read_raw = ens160_read_raw,
+};
+
+int ens160_core_probe(struct device *dev, struct regmap *regmap,
+		      const char *name)
+{
+	struct ens160_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	dev_set_drvdata(dev, indio_dev);
+	data->regmap = regmap;
+
+	indio_dev->name = name;
+	indio_dev->info = &ens160_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ens160_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ens160_channels);
+
+	ret = ens160_chip_init(data);
+	if (ret) {
+		dev_err_probe(dev, ret, "chip initialization failed\n");
+		return ret;
+	}
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+EXPORT_SYMBOL_NS(ens160_core_probe, IIO_ENS160);
+
+void ens160_core_remove(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ens160_data *data = iio_priv(indio_dev);
+
+	ens160_set_mode(data, ENS160_REG_MODE_IDLE);
+}
+EXPORT_SYMBOL_NS(ens160_core_remove, IIO_ENS160);
+
+MODULE_AUTHOR("Gustavo Silva <gustavograzs@gmail.com>");
+MODULE_DESCRIPTION("ScioSense ENS160 driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/chemical/ens160_i2c.c b/drivers/iio/chemical/ens160_i2c.c
new file mode 100644
index 000000000..ee2b44184
--- /dev/null
+++ b/drivers/iio/chemical/ens160_i2c.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ScioSense ENS160 multi-gas sensor I2C driver
+ *
+ * Copyright (c) 2024 Gustavo Silva <gustavograzs@gmail.com>
+ *
+ * 7-Bit I2C slave address is:
+ *	- 0x52 if ADDR pin LOW
+ *	- 0x53 if ADDR pin HIGH
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include "ens160.h"
+
+static const struct regmap_config ens160_regmap_i2c_conf = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int ens160_i2c_probe(struct i2c_client *client)
+{
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(client, &ens160_regmap_i2c_conf);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "Failed to register i2c regmap %ld\n",
+			PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	return ens160_core_probe(&client->dev, regmap, client->name);
+}
+
+static void ens160_i2c_remove(struct i2c_client *client)
+{
+	ens160_core_remove(&client->dev);
+}
+
+static const struct i2c_device_id ens160_i2c_id[] = {
+	{ "ens160", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ens160_i2c_id);
+
+static const struct of_device_id ens160_of_i2c_match[] = {
+	{ .compatible = "sciosense,ens160" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ens160_of_i2c_match);
+
+static struct i2c_driver ens160_i2c_driver = {
+	.driver = {
+		.name		= "ens160_i2c",
+		.of_match_table	= ens160_of_i2c_match,
+	},
+	.probe = ens160_i2c_probe,
+	.remove = ens160_i2c_remove,
+	.id_table = ens160_i2c_id,
+};
+module_i2c_driver(ens160_i2c_driver);
+
+MODULE_AUTHOR("Gustavo Silva <gustavograzs@gmail.com>");
+MODULE_DESCRIPTION("ScioSense ENS160 I2C driver");
+MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_ENS160);
diff --git a/drivers/iio/chemical/ens160_spi.c b/drivers/iio/chemical/ens160_spi.c
new file mode 100644
index 000000000..effc4acee
--- /dev/null
+++ b/drivers/iio/chemical/ens160_spi.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ScioSense ENS160 multi-gas sensor SPI driver
+ *
+ * Copyright (c) 2024 Gustavo Silva <gustavograzs@gmail.com>
+ */
+
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+#include "ens160.h"
+
+#define ENS160_SPI_READ BIT(0)
+
+static const struct regmap_config ens160_regmap_spi_conf = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.reg_shift = -1,
+	.read_flag_mask = ENS160_SPI_READ,
+};
+
+static int ens160_spi_probe(struct spi_device *spi)
+{
+	struct regmap *regmap;
+	const struct spi_device_id *id = spi_get_device_id(spi);
+
+	regmap = devm_regmap_init_spi(spi, &ens160_regmap_spi_conf);
+	if (IS_ERR(regmap)) {
+		dev_err(&spi->dev, "Failed to register spi regmap: %pe\n",
+			regmap);
+		return PTR_ERR(regmap);
+	}
+
+	return ens160_core_probe(&spi->dev, regmap, id->name);
+}
+
+static void ens160_spi_remove(struct spi_device *spi)
+{
+	ens160_core_remove(&spi->dev);
+}
+
+static const struct of_device_id ens160_spi_of_match[] = {
+	{ .compatible = "sciosense,ens160" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ens160_spi_of_match);
+
+static const struct spi_device_id ens160_spi_id[] = {
+	{ "ens160", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ens160_spi_id);
+
+static struct spi_driver ens160_spi_driver = {
+	.driver = {
+		.name	= "ens160_spi",
+		.of_match_table = ens160_spi_of_match,
+	},
+	.probe		= ens160_spi_probe,
+	.remove		= ens160_spi_remove,
+	.id_table	= ens160_spi_id,
+};
+module_spi_driver(ens160_spi_driver);
+
+MODULE_AUTHOR("Gustavo Silva <gustavograzs@gmail.com>");
+MODULE_DESCRIPTION("ScioSense ENS160 SPI driver");
+MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_ENS160);
-- 
2.45.0


