Return-Path: <linux-iio+bounces-5797-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2F58FBF67
	for <lists+linux-iio@lfdr.de>; Wed,  5 Jun 2024 00:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C89FB2586A
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 22:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B37614D293;
	Tue,  4 Jun 2024 22:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bh+W6Me3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8496A14D71A;
	Tue,  4 Jun 2024 22:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717541893; cv=none; b=epiLqAIAhyS1V0u2l0UUxBHnQl5nslynPHlyVVpDBKShtK2OgUfj9jrMVhApNJq425JIHXLCZZ91rZjyJ/eAyFXVHwFOQJi3K7EQwD28AU80ou6KMGSjXNhMFzmXRx522qIGIGDLmH/Gac61vXV1/7xCr+6JxYl0I0LrdkpUZDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717541893; c=relaxed/simple;
	bh=p4bwZAWmp9vh/C/xRyTREFaRe34bl4hTR1TUB33SsEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hRM2Mp4uRvwRZ3FFppE4hqVaAutN5l+faJJg7YC0y5NF1myK6vNSQQUYbvq7XK4/DAoUvwXU+Y+kgYUGYoUTCXQyG1vbqTcD+YrQCtw1B96eNltiDZDJCZ13fY6BWndYYaKs510o5gYEXHlL99gePFh1cD1BEAAND5nt8zJGOJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bh+W6Me3; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7025b84c0daso2785411b3a.2;
        Tue, 04 Jun 2024 15:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717541891; x=1718146691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APNhbypR6az9KgaNvqpVnJMl5ILr3nA1zO1si5c55fA=;
        b=bh+W6Me3PtjXzle47ZkJh/BkejgzPtQiYWdvhCLEm/4S7ZYwA+I8GF6oYCR4IcqHKF
         ZQmdYOuz2VdVmrrhTbsB3LcyMYicANR5J4Cy0sHBNlHNmwUhnjS+VznzJqO4kTd/gGXv
         DEo3UheBE08yURmZBaBuyKaNfUFGaz2PY3NuUoknpkXAIsAb+GWhc5w3y/+1ie15ka+q
         HG81wwdgdTc4mrP9P0BL0T3kbUlgR9S4zfST/iAFONSs4IKwHjycos/qUu65haDo/htV
         8IIDG2v7M8lV6ldWmpez4iDHjVOcjQXhDnly3Q7IKouhon4rW7w45GoLk6eem2Fx+guF
         JMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717541891; x=1718146691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=APNhbypR6az9KgaNvqpVnJMl5ILr3nA1zO1si5c55fA=;
        b=HQZnzH+/xx4m6+gU1b5XPrbvlWRq8McaIpxHCNt4xt+9krGCrjuVENchsyDpSQ3WnK
         rtgTAi7Mu0a4g9vtX0Ro0D2izpvF8inEJ4DTfM0YoD6+zvLLI5owAfrJuP5MxdegwOfK
         /t39k4MqqfVcmSs4Pi9enk+WiOSVT5jDbBFR4LPxQBwb7glzf5GRDZmJG5h8SFMXzror
         7Sxgduv/qRUGog12UCVnqFwQzmVgP7pmcTeXlvW8d17B2DfS7tMTE20YYtQ8MxcNeSg3
         HzR1ngXMr/RWELiAIrhOVz4Q+DCUXqLrHlfTWbixGECm6/ouNs6WI77pD7N/DLnUoyA8
         lRow==
X-Forwarded-Encrypted: i=1; AJvYcCUQc68Ia6vE8p99JQvXSChPDhhTvbBdtH/asqhCg1yF/04Qxpr1B+hPoOINltDXfx9JVhIIvzCr0OZGl+8pSVnm9Cn4SM0HiW8JTGABK2ynnnsRV12LxyPHQI5U69SG5JskeAwkGioJXXT1U+BXZRbQ0hLm0JAilFoHTyetrL8+6Ezhwg==
X-Gm-Message-State: AOJu0Yw0SMuRlScarx5dBrJvDB6mB7VOE6+vu5ijWLnQQbAtj/ScAYZb
	lJ4gsa+YA2LJPeh5Y0t9m0ebIOqgg4yIvWPNl7ROkhgNG/2sfNhXGZmBxbEt
X-Google-Smtp-Source: AGHT+IFAOunI1dFYUNOt2HGENcb38JOKZjkXVXFaNfnGEG6354rffjZjnMw5yMsSOebJNscG/HcikA==
X-Received: by 2002:a05:6a00:4c0f:b0:6f3:e9bc:7ed3 with SMTP id d2e1a72fcca58-703e599fcdbmr1008693b3a.17.1717541890631;
        Tue, 04 Jun 2024 15:58:10 -0700 (PDT)
Received: from localhost.localdomain ([189.101.166.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7025a955dd1sm5312125b3a.64.2024.06.04.15.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 15:58:10 -0700 (PDT)
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
Subject: [PATCH v3 3/6] iio: chemical: add driver for ENS160 sensor
Date: Tue,  4 Jun 2024 19:57:27 -0300
Message-ID: <20240604225747.7212-4-gustavograzs@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604225747.7212-1-gustavograzs@gmail.com>
References: <20240604225747.7212-1-gustavograzs@gmail.com>
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
index 000000000..ae99a95c6
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
+#define ENS160_REG_PART_ID		0x00
+
+#define ENS160_REG_OPMODE		0x10
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
+				       &data->buf, sizeof(data->buf));
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
+	ret = devm_add_action_or_reset(dev, ens160_set_idle, data);
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
index 000000000..f885903fe
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
+	return devm_ens160_core_probe(&client->dev, regmap, "ens160");
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
+		.name		= "ens160",
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
index 000000000..40c68c5c4
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
+	return devm_ens160_core_probe(&spi->dev, regmap, "ens160");
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
+		.name	= "ens160",
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


