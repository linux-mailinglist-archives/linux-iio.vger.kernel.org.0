Return-Path: <linux-iio+bounces-5415-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 122B28D2957
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 02:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD773283260
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 00:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7815323AD;
	Wed, 29 May 2024 00:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0ciBV4j"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800E6D2F0;
	Wed, 29 May 2024 00:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716941721; cv=none; b=iR/5AmmQUcmiBWi5p3x8ihpo7N12TrbgIWjki/u2uNv8t/OpItBsA2WiSRWh4z3wC4TnXbcDPk8SeL2JvuHUVg/4OL9UM6O8vVZeWeqdsZQ214TxJkwAfoQ0i2Qygr8X68N5g6sTtNZYXXlF4IBfVFwoKl7a/wUb7KGkHMhLNs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716941721; c=relaxed/simple;
	bh=aKoJCOs1Woeh8RdLIYash1hOrt6afgr9uJF1cIhvJ8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tOlXIdmM8c7sCilcimvGscagP1MWXwqecaYltpuSvfRRSOjiqOfi8Mvfx52SF1GLknIqCHB0CD/27KUBZAR9CpCrQgizbG3+rVL3T0DfkRiGKcup9VCuPEU/+R8mAGAkyO5Yjf39OjTA9wCrx7JzwxBywukFpSRJhjdyi+HIEXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0ciBV4j; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f8eba8f25eso1227986b3a.3;
        Tue, 28 May 2024 17:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716941719; x=1717546519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxhkVsRfSLouyfn4DzHsYv8zXpT26ihwNdIUpDqu4NA=;
        b=c0ciBV4jjazwiLX7kk4u4LxUdgEwIpf2PCGvuWjiPzaYykD+WORATh8dmzq0DI95a6
         1foSWrmJ2ojU89HF0fB4ny25j9qX/rCxWrKxMbo6EDu+2mHe97KTv0/DG61XjO3izvkJ
         VY8Gj+gzJbSTb8Luy25KfRJTRFRbLsdlDBPrELWMl4xVeuneTAk8B5PuGiH0Tw2sqily
         cg92mc0BrNuFL9RJBpam8fpfYiDAB+J3DKFyYChE0zFPiddcH2Fr3VNY++qKK78TJH83
         TDOZHKyzSeADvpw2ZL2J8vDVlJiYN0v3tHjQfv80hAidDqLgnsNWCpQuxX4EQHEcob2Z
         dyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716941719; x=1717546519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LxhkVsRfSLouyfn4DzHsYv8zXpT26ihwNdIUpDqu4NA=;
        b=CjTHXqGeq+5Zh3OO7gAg79/mdiZJoxdyB8rRBcgmEZmiw7S95qJ6bhYxeJ7IK4dmUw
         YHOkBs8lx91JMSpjnIbyW0w5vHrUZT+6VeyDNoOBQhMfHlj1PHEJIjOZv7e34SFCCgdA
         m5DKAIl4OQnd0AJ6Sh1k9/wAFuKFT5VXY4KtDfBeeEXIKZEykjkZ4DLEiBn3hOfk7TFJ
         dOUUKirjI8wBjn2PvlNXI9JqnanFKYPW4M5vqOR2IpkwMLJZ1EiOkyclAudcnS5OtSU/
         q/mnuCruEwWNiGQnq/mHPfKr17rFlmA99HzZIRkzbEXDI+v5UU9fgLpaQUTnkClL2Wq8
         GbyA==
X-Forwarded-Encrypted: i=1; AJvYcCUB7+nACOuh1+DubIgW/D41Xh87qjlzUiwRHUmzmHai7g+3i1f9e1NrMk8PJxW0jNfSwJVCkku7QkbRSHJwWrcqOexbsFInt73P+HTZutOEGxQoYL1N3VQ24vDKDYSa+NV8y+N66uod8nBgseiQ34hiUZk3bi3c6XeKjyAtl84gbspE6g==
X-Gm-Message-State: AOJu0Yzh+gPwx/b1gxhkXTzoWmeDoc5rsX4SyY51uZ4p7AuylgK6QZHM
	8QKpuNmzk8341JtJVtdAHVpJ2z9lC4gqkXlRtuGZwH2J5VOen61CAOCrdRKSgt0=
X-Google-Smtp-Source: AGHT+IHwoA+vIC3CqE092AsVG0c7CgoY1CT21mrANgivfs3ZXexulXkJUIP9ccnQ2Ryuzt7UKNWU6g==
X-Received: by 2002:a05:6a00:418a:b0:6ea:bb00:dbb6 with SMTP id d2e1a72fcca58-6f8f2d730abmr15813967b3a.8.1716941718585;
        Tue, 28 May 2024 17:15:18 -0700 (PDT)
Received: from localhost.localdomain ([189.101.162.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fbd3dea2sm6941433b3a.24.2024.05.28.17.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 17:15:18 -0700 (PDT)
From: Gustavo Silva <gustavograzs@gmail.com>
To: jic23@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lars@metafoo.de,
	christophe.jaillet@wanadoo.fr,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] iio: chemical: add driver for ENS160 sensor
Date: Tue, 28 May 2024 21:14:20 -0300
Message-ID: <20240529001504.33648-3-gustavograzs@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240529001504.33648-1-gustavograzs@gmail.com>
References: <20240529001504.33648-1-gustavograzs@gmail.com>
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

Datasheet: https://www.sciosense.com/wp-content/uploads/2023/12/ENS160-Datasheet.pdf

Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
changes in v2:
 - Make regmap bulk reads DMA safe by adding buffers to the end of
   iio_priv() struct and marking it __aligned(IIO_DMA_MINALIGN)
 - Remove unnecessary time delays
 - Use devm_add_action_or_reset() to register custom cleanup and delete
   the remove() function
 - Add missing register definition ENS160_REG_DATA_AQI
 - Use dev_err_probe() where applicable
 - Hardcode device name
 - Remove unnecessary dev_set_drvdata() call
 - Do not set driver_data to 0 in {spi,i2c}_device_id structs
 drivers/iio/chemical/Kconfig       |  22 +++
 drivers/iio/chemical/Makefile      |   3 +
 drivers/iio/chemical/ens160.h      |   7 +
 drivers/iio/chemical/ens160_core.c | 221 +++++++++++++++++++++++++++++
 drivers/iio/chemical/ens160_i2c.c  |  60 ++++++++
 drivers/iio/chemical/ens160_spi.c  |  60 ++++++++
 6 files changed, 373 insertions(+)
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
index 000000000..d0df15f08
--- /dev/null
+++ b/drivers/iio/chemical/ens160.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ENS160_H_
+#define ENS160_H_
+
+int devm_ens160_core_probe(struct device *dev, struct regmap *regmap,
+			   const char *name);
+#endif
diff --git a/drivers/iio/chemical/ens160_core.c b/drivers/iio/chemical/ens160_core.c
new file mode 100644
index 000000000..a535f62c4
--- /dev/null
+++ b/drivers/iio/chemical/ens160_core.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ScioSense ENS160 multi-gas sensor driver
+ *
+ * Copyright (c) 2024 Gustavo Silva <gustavograzs@gmail.com>
+ *
+ * Datasheet:
+ *  https://www.sciosense.com/wp-content/uploads/2023/12/ENS160-Datasheet.pdf
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
+#define ENS160_REG_DATA_AQI		0x21
+#define ENS160_REG_DATA_TVOC		0x22
+#define ENS160_REG_DATA_ECO2		0x24
+#define ENS160_REG_DATA_T		0x30
+#define ENS160_REG_DATA_RH		0x32
+#define ENS160_REG_GPR_READ4		0x4C
+
+#define ENS160_STATUS_VALIDITY_FLAG	GENMASK(3, 2)
+
+#define ENS160_STATUS_NORMAL		0x00
+
+struct ens160_data {
+	struct regmap *regmap;
+	u8 fw_version[3] __aligned(IIO_DMA_MINALIGN);
+	__le16 buf;
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
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_bulk_read(data->regmap, chan->address,
+					&data->buf, sizeof(data->buf));
+		if (ret)
+			return ret;
+		*val = le16_to_cpu(data->buf);
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
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
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
+static void ens160_set_idle(void *data)
+{
+	ens160_set_mode(data, ENS160_REG_MODE_IDLE);
+}
+
+static int ens160_chip_init(struct ens160_data *data)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	unsigned int status;
+	int ret;
+
+	ret = ens160_set_mode(data, ENS160_REG_MODE_RESET);
+	if (ret)
+		return ret;
+
+	ret = regmap_bulk_read(data->regmap, ENS160_REG_PART_ID, &data->buf,
+			       sizeof(data->buf));
+	if (ret)
+		return ret;
+
+	if (le16_to_cpu(data->buf) != ENS160_PART_ID)
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
+	ret = regmap_bulk_read(data->regmap, ENS160_REG_GPR_READ4,
+			       data->fw_version, sizeof(data->fw_version));
+	if (ret)
+		return ret;
+
+	dev_info(dev, "firmware version: %u.%u.%u\n", data->fw_version[2],
+		 data->fw_version[1], data->fw_version[0]);
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
+int devm_ens160_core_probe(struct device *dev, struct regmap *regmap,
+			   const char *name)
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
+	data->regmap = regmap;
+
+	indio_dev->name = name;
+	indio_dev->info = &ens160_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ens160_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ens160_channels);
+
+	ret = devm_add_action_or_reset(dev, ens160_set_idle, data);
+	if (ret)
+		return ret;
+
+	ret = ens160_chip_init(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "chip initialization failed\n");
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+EXPORT_SYMBOL_NS(devm_ens160_core_probe, IIO_ENS160);
+
+MODULE_AUTHOR("Gustavo Silva <gustavograzs@gmail.com>");
+MODULE_DESCRIPTION("ScioSense ENS160 driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/chemical/ens160_i2c.c b/drivers/iio/chemical/ens160_i2c.c
new file mode 100644
index 000000000..2f0b08e52
--- /dev/null
+++ b/drivers/iio/chemical/ens160_i2c.c
@@ -0,0 +1,60 @@
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
+	if (IS_ERR(regmap))
+		return dev_err_probe(&client->dev, PTR_ERR(regmap),
+				     "Failed to register i2c regmap\n");
+
+	return devm_ens160_core_probe(&client->dev, regmap, "ens160_i2c");
+}
+
+static const struct i2c_device_id ens160_i2c_id[] = {
+	{ "ens160" },
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
index 000000000..9a6c9c7e3
--- /dev/null
+++ b/drivers/iio/chemical/ens160_spi.c
@@ -0,0 +1,60 @@
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
+
+	regmap = devm_regmap_init_spi(spi, &ens160_regmap_spi_conf);
+	if (IS_ERR(regmap))
+		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
+				     "Failed to register spi regmap\n");
+
+	return devm_ens160_core_probe(&spi->dev, regmap, "ens160_spi");
+}
+
+static const struct of_device_id ens160_spi_of_match[] = {
+	{ .compatible = "sciosense,ens160" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ens160_spi_of_match);
+
+static const struct spi_device_id ens160_spi_id[] = {
+	{ "ens160" },
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
+	.id_table	= ens160_spi_id,
+};
+module_spi_driver(ens160_spi_driver);
+
+MODULE_AUTHOR("Gustavo Silva <gustavograzs@gmail.com>");
+MODULE_DESCRIPTION("ScioSense ENS160 SPI driver");
+MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IIO_ENS160);
-- 
2.45.1


