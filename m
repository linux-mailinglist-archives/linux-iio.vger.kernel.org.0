Return-Path: <linux-iio+bounces-24746-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035CFBB96BB
	for <lists+linux-iio@lfdr.de>; Sun, 05 Oct 2025 15:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A678A3BA28B
	for <lists+linux-iio@lfdr.de>; Sun,  5 Oct 2025 13:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB654289E17;
	Sun,  5 Oct 2025 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="JViYTM8m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A1F287510;
	Sun,  5 Oct 2025 13:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759669993; cv=none; b=GnpZCixzBCjS2m6KQBupa9qW8AkNmlPVzS4ZvgheoKNpaaroR8C0uvARg/W2wi5PQWolpeRAjGW69EuPLBie9p0B2r3OUeZ0cwyK06a+RcVp+dUnIzgazJik8uaHqUOQYRdt30vEADPtVAYZqHN7ZTvQl2HJ6cDLNpO5b8nKs10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759669993; c=relaxed/simple;
	bh=fyAWAVu6a0MWVYQ7REnDBgC+wstOmeT/eyll7jggynk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iUcgKFNSdmbdM3yfVnRX69qpD5HPQLoc7pkxajVeTsxmqkHUlrbbCf4Shu2gO4q0F5E85coWNswI/AWZOqXPMsqu6kFhSmT2HYcaMhvr8GD7ll6SJ1a7TdlURlozLGXfgM3MX5xiOdAd7TXbVA2x7QFjK23IGOyKR4E9zcSkXHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=JViYTM8m; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 4B01F173BF6;
	Sun, 05 Oct 2025 16:13:05 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1759669985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IO1S6QvsJTbfcwfXyZeDa2iI8KrYmWc+Tp8aFfdD3Es=;
	b=JViYTM8mULS+EObL7smmxNSNtPW2LthkzDV/i6BwtYW5FPHkBOrZ1yYiAYHjYsSDXR9W9p
	LuQX3bMmPqXbntwNMidQFtIyu4GfbLNGdp3o/8QT3YmV8dSccfkkqi5q7ZYMEJXTu9xVdS
	9plXAMt2LoqywWA2Wu/ZwaPtXcuWAiGPhVO02AwBhY2gVtzQgNE6QIF8njnnNpEWfTaFIK
	RnrvgbU5y1IFSiSiiGa0hZ0HvE0Zh+/j8mIJH+WbardrWty6tAbJ9Qf0+SfSxNdx1EDeZQ
	vFlcQTsF2+EY29loS8g3XtPBcMsEWGon5nmjpCBu330tmwnzM+VuW9mD/HbBFw==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sun, 05 Oct 2025 16:12:23 +0300
Subject: [PATCH v4 14/19] iio: accel: bma220: add i2c module
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251005-b4-bma220_improvements-v4-14-0f449ba31585@subdimension.ro>
References: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
In-Reply-To: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5774;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=fyAWAVu6a0MWVYQ7REnDBgC+wstOmeT/eyll7jggynk=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFwTDlrQTBEQUFvQmRDc25wM
 k02U1dNQnl5WmlBR2ppYnM4OXpaTEdWaHZrNVZ5UURyUUFLQjcwCmQxWjhNRFR5eTVyZnhiZ2ov
 MUt0SDRrQ013UUFBUW9BSFJZaEJCb2ltQncrRGJ4UXBFNmlkM1FySjZkak9rbGoKQlFKbzRtN1B
 BQW9KRUhRcko2ZGpPa2xqNklvUC8wSER6eGJQVG1XNjAxZkg4RFhtcmY5amVKQVJhaFRSRnA4Tw
 piemZDOWNnRnhPSzB2UlpBblh3OW4vaXpxS2FGMnRUK2kyZ24zU1g2NWxQRStmSWdoWHdxeDg1d
 UhWMjBmbmNyClh6L0FoY3dyd3QvMjR4aW01OHJRbjVRWUs5UE5aM0lWVEhrNUcvNGZjcmk2NWQx
 VTRzZVkwNWxPTjRIUjhkeGUKUmlYWFNJSXJWZmk3R0tLbkZYU1RSWU9qMEEyZ2RhaVZwbVNscjZ
 DZmFEdGRDb1dVNzRWUTFLTnI0bkdNTjFuawpnQUJSS0laRDFTK0ZhQzNVdWh4TTRVL3ZaQUdtej
 d4MytoQ00ySGd1UGZmaUhETzI2QWVCdENIL1pjRWE5MmdiCmpmQXlVZ3NqTzNwOVZwanVNVThoQ
 XluWmtsSlMzUVZNNndQOW9iT1p1QklxNXdDcnZ0bFNnNWc3M1pCbWZBeTIKQ1o4M0s3Y1VCZm00
 K3FxVUlQTEcyNW9CRVRmN09oSU1Tc3ZMdGhZRjV1bFZ3dnJRU29GM0d5U0s0eUJhT2ZrcgpnOGU
 5ZTdCZkVvV3IydXBiQ2hjYnBMQmV5UGxEblh1RndIeUtUbEFNTHg0NGQ2WERRK0FMUlNwVm9OQ3
 BuRExzCnZFTUJEeHNWMVBkLzF2eVdCSmNIMjVIaUlUK0VKZE1FbFdrQS9yZmJvclptZTB0NFM0U
 U15YlRPdCtxNkdJY1cKcjliUld5V2lSU3VLdmhYTWZGNUE4UEhKZlVMQVJweS8xOUFIaXVVcU40
 NFFDUWl5TVpWaFlRM3Vqb3JMWnZ6RQpyejJMakdjeWhNVWpmTGdKMHovLzJxdWxhdVAzUkttK3k
 3UE4wdFFRT2ZkQjJEVk1ic0tZcFNaSHMvU2FZVVlqCmhiWmlNRFVWZkg4cTJ3PT0KPW1RZ2IKLS
 0tLS1FTkQgUEdQIE1FU1NBR0UtLS0tLQo=
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Add the bma220_i2c module.

Note that this kernel module transparently shifts all register addresses
1 bit to the left, so all functions will operate based on the SPI memory
map.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
v1->v2 no change
v2->v3
- depends I2C || SPI (David)
- change extern const struct order (David)
- remove unused includes (David)
v4 no change
---
 drivers/iio/accel/Kconfig       | 11 ++++++--
 drivers/iio/accel/Makefile      |  1 +
 drivers/iio/accel/bma220.h      |  1 +
 drivers/iio/accel/bma220_core.c | 18 +++++++++++++
 drivers/iio/accel/bma220_i2c.c  | 58 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 988fe4b1f9a52c2e671ea30d8590f25ee1685ac7..76911278fb217bd3e429c427b873fb7eae26420e 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -218,10 +218,11 @@ config BMA180
 
 config BMA220
 	tristate "Bosch BMA220 3-Axis Accelerometer Driver"
-	depends on SPI
+	depends on I2C || SPI
 	select REGMAP
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
+	select BMA220_I2C if I2C
 	select BMA220_SPI if SPI
 	help
 	  Say yes here to add support for the Bosch BMA220 triaxial
@@ -229,7 +230,13 @@ config BMA220
 
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
index 56a9f848f7f913633bc2a628c1ac5c9190774b9d..fa440a85928398fee927081f605595ba9fbc4ad9 100644
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
index 695f491bc5a03008f26fe8602ba633456159fb1d..e53ca63de54b4e81df0908b11d0fb7f03a86dbdc 100644
--- a/drivers/iio/accel/bma220.h
+++ b/drivers/iio/accel/bma220.h
@@ -13,6 +13,7 @@
 
 struct device;
 
+extern const struct regmap_config bma220_i2c_regmap_config;
 extern const struct regmap_config bma220_spi_regmap_config;
 extern const struct dev_pm_ops bma220_pm_ops;
 
diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index 42d5acce0a8387734d932c77fec9777a7a01f774..a3faf1f5ec6d79f2c6105697b404d6eb1f4501db 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -172,6 +172,24 @@ const struct regmap_config bma220_spi_regmap_config = {
 };
 EXPORT_SYMBOL_NS_GPL(bma220_spi_regmap_config, "IIO_BOSCH_BMA220");
 
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
+	.cache_type = REGCACHE_NONE,
+	.writeable_reg = bma220_is_writable_reg,
+};
+EXPORT_SYMBOL_NS_GPL(bma220_i2c_regmap_config, "IIO_BOSCH_BMA220");
+
 static irqreturn_t bma220_trigger_handler(int irq, void *p)
 {
 	int ret;
diff --git a/drivers/iio/accel/bma220_i2c.c b/drivers/iio/accel/bma220_i2c.c
new file mode 100644
index 0000000000000000000000000000000000000000..5dc7c38f53b3173ff43ca29b63132ec44e672cde
--- /dev/null
+++ b/drivers/iio/accel/bma220_i2c.c
@@ -0,0 +1,58 @@
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
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+#include "bma220.h"
+
+static int bma220_i2c_probe(struct i2c_client *client)
+{
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(client, &bma220_i2c_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(&client->dev, PTR_ERR(regmap),
+				     "failed to create regmap\n");
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


