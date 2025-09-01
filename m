Return-Path: <linux-iio+bounces-23621-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8762DB3EF04
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 21:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93B61A85F99
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 19:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CF4267B00;
	Mon,  1 Sep 2025 19:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="z4e2INzR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74C32580CA;
	Mon,  1 Sep 2025 19:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756756510; cv=none; b=Gq/G7mS1pGJYSY2XehoJSotc9mwo7kDmal6qHJt+z+EoxLY85WaI2/2YR1LyCcwFQs5MVlTfWxySZTyf+HnEQrKyu7FkfUdIJ0nM97PxvPzmd/9BsXfLom6U36zOLrYBAX02fcprxeUbFO3SvCyatF5fG1xEXhyO/Kb8gI0JmUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756756510; c=relaxed/simple;
	bh=tiZA4TdFvRoRUywLr07gSd71OMrtnadQIIVgAWv7o4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ks6nhAS943M5OFVTAhItsJb8DXSxfjGP1nuBWONDJQdDHH/xbJhXo5ahJlo1G/inrUN5aO7StS3fPgIcjt/KiSh3bLIkrC1wxawdRbgQag1gTQG+JW4srOP1/nbyYtf8D6uD1hAwOMfDCcM1p59ATdyWtsZpl8iYDYuG4Anj15s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=z4e2INzR; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [IPv6:2a02:2f0e:3503:4a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id D7D4D173BEC;
	Mon, 01 Sep 2025 22:47:55 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1756756076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A8j/QOXN0ugvgXWg9xQZTmkY/Q+gPIG4c4igm/P83LQ=;
	b=z4e2INzRV/MAHqiEbDA41yzf10tUE4IBe7mW/nYQvux3I6qXItt7kDgT/nrxUbdVKf87SZ
	vpvK/8VYnCPMWv5qazBUSmU4mLQQ/GGjbp0BtFZZ93IEg9snWEh3qgC3qvQMeGb78UiDGO
	OxUyM6VutQCbAslLOSjP0TxAlbHmqEukVslw4RnnGPE00IPURg99V4T8mnF/AmRPyq7sKW
	CToQxS7+qcM4M8KUiWmXQ6QVNNs/zg6XqpOKt/rYSf4P2xSlEU5RF932MhfA2kZIE1dA7w
	mS2ALcrgQX6Qt2bOSTFD7OQKSzFD/zAqTFh4vmbypdiAuYulWORBNpD6L4ySVA==
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH 04/10] iio: accel: BMA220 add i2c module
Date: Mon,  1 Sep 2025 22:47:30 +0300
Message-ID: <20250901194742.11599-5-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250901194742.11599-1-petre.rodan@subdimension.ro>
References: <20250901194742.11599-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add i2c module.
Note that the kernel module transparently shifts all register addresses
1 bit to the left, so all functions will operate based on the SPI memory
map.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 drivers/iio/accel/Kconfig       |  9 ++++-
 drivers/iio/accel/Makefile      |  1 +
 drivers/iio/accel/bma220.h      |  1 +
 drivers/iio/accel/bma220_core.c | 19 ++++++++++
 drivers/iio/accel/bma220_i2c.c  | 62 +++++++++++++++++++++++++++++++++
 5 files changed, 91 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/accel/bma220_i2c.c

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 9b6c35b75948..b3c5b0b7a406 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -221,6 +221,7 @@ config BMA220
 	select REGMAP
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
+	select BMA220_I2C if I2C
 	select BMA220_SPI if SPI
 	help
 	  Say yes here to add support for the Bosch BMA220 triaxial
@@ -228,7 +229,13 @@ config BMA220

 	  To compile this driver as a module, choose M here: the
 	  module will be called bma220_core and you will also get
-	  bma220_spi if SPI is enabled.
+	  bma220_i2c if I2C is enabled and bma220_spi if SPI is
+	  enabled.
+
+config BMA220_I2C
+	tristate
+	select REGMAP_I2C
+	depends on BMA220

 config BMA220_SPI
 	tristate
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 56a9f848f7f9..fa440a859283 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_ADXL380_I2C) += adxl380_i2c.o
 obj-$(CONFIG_ADXL380_SPI) += adxl380_spi.o
 obj-$(CONFIG_BMA180) += bma180.o
 obj-$(CONFIG_BMA220) += bma220_core.o
+obj-$(CONFIG_BMA220_I2C) += bma220_i2c.o
 obj-$(CONFIG_BMA220_SPI) += bma220_spi.o
 obj-$(CONFIG_BMA400) += bma400_core.o
 obj-$(CONFIG_BMA400_I2C) += bma400_i2c.o
diff --git a/drivers/iio/accel/bma220.h b/drivers/iio/accel/bma220.h
index 5eefa9749d33..ae4b74514629 100644
--- a/drivers/iio/accel/bma220.h
+++ b/drivers/iio/accel/bma220.h
@@ -13,6 +13,7 @@
 #include <linux/iio/iio.h>

 extern const struct regmap_config bma220_spi_regmap_config;
+extern const struct regmap_config bma220_i2c_regmap_config;
 extern const struct dev_pm_ops bma220_pm_ops;

 int bma220_common_probe(struct device *dev, struct regmap *regmap, int irq);
diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index e6dac2e1cf4d..fae84823d52b 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -225,6 +225,25 @@ const struct regmap_config bma220_spi_regmap_config = {
 };
 EXPORT_SYMBOL_NS(bma220_spi_regmap_config, "IIO_BOSCH_BMA220");

+/*
+ * Based on the datasheet the memory map differs between the SPI and the I2C
+ * implementations. I2C register addresses are simply shifted to the left
+ * by 1 bit yet the register size remains unchanged.
+ * This driver employs the SPI memory map to correlate register names to
+ * addresses regardless of the bus type.
+ */
+
+const struct regmap_config bma220_i2c_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.reg_shift = -1,
+	.max_register = BMA220_REG_SOFTRESET,
+	.cache_type = REGCACHE_MAPLE,
+	.writeable_reg = bma220_is_writable_reg,
+	.volatile_reg = bma220_is_volatile_reg,
+};
+EXPORT_SYMBOL_NS(bma220_i2c_regmap_config, "IIO_BOSCH_BMA220");
+
 static int bma220_data_rdy_trigger_set_state(struct iio_trigger *trig,
 					     bool state)
 {
diff --git a/drivers/iio/accel/bma220_i2c.c b/drivers/iio/accel/bma220_i2c.c
new file mode 100644
index 000000000000..8a1644aac287
--- /dev/null
+++ b/drivers/iio/accel/bma220_i2c.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Bosch triaxial acceleration sensor
+ *
+ * Copyright (c) 2025 Petre Rodan <petre.rodan@subdimension.ro>
+ *
+ * Datasheet: https://media.digikey.com/pdf/Data%20Sheets/Bosch/BMA220.pdf
+ * I2C address is either 0x0b or 0x0a depending on CSB (pin 10)
+ */
+
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+#include <linux/iio/iio.h>
+
+#include "bma220.h"
+
+static int bma220_i2c_probe(struct i2c_client *client)
+{
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(client, &bma220_i2c_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "failed to create regmap\n");
+		return PTR_ERR(regmap);
+	}
+
+	return bma220_common_probe(&client->dev, regmap, client->irq);
+}
+
+static const struct of_device_id bma220_i2c_match[] = {
+	{ .compatible = "bosch,bma220" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bma220_i2c_match);
+
+static const struct i2c_device_id bma220_i2c_id[] = {
+	{ "bma220" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, bma220_i2c_id);
+
+static struct i2c_driver bma220_i2c_driver = {
+	.driver = {
+		.name = "bma220_i2c",
+		.pm = pm_sleep_ptr(&bma220_pm_ops),
+		.of_match_table = bma220_i2c_match,
+	},
+	.probe = bma220_i2c_probe,
+	.id_table = bma220_i2c_id,
+};
+module_i2c_driver(bma220_i2c_driver);
+
+MODULE_AUTHOR("Petre Rodan <petre.rodan@subdimension.ro>");
+MODULE_DESCRIPTION("Bosch triaxial acceleration sensor i2c driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_BOSCH_BMA220");
--
2.49.1


