Return-Path: <linux-iio+bounces-24077-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96F9B561FB
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 17:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A87117FE15
	for <lists+linux-iio@lfdr.de>; Sat, 13 Sep 2025 15:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317B32F7455;
	Sat, 13 Sep 2025 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="INDpckuq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8622F4A18;
	Sat, 13 Sep 2025 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757778019; cv=none; b=HVLgTQQ/X9NA/4pYv2OAOuvwdgdvHYusYIQiu8uqk5MeWHGC1lMAo62TgIVO6en4HnmSED/70Ypp41LlGhLSzovtL1jF4un6kKLyYFiYK/0kKe4gte370etQfk4ItJjaCLYsIlVqbzCJPk18qOL92hMPRSS/8ujsGrVkG2QK/aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757778019; c=relaxed/simple;
	bh=cuM5TiHwvZpA7h/CSYN/B/E+9xrSArcAg0vkWZF5ufQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dS8El0Lo8sR5EHwSdn0nrsNVaIq35xCkFv+mId1x7c5v80e2NQFu2zx3aUDsLwC5ehaxBEwexNDUA6gZcM5LTmerHqGr/QCeYb9FasxcGyaAZZglyPTrF2WYpBKFgPnz1MyepCFq8J7a9eKFh/iwu/UxAlgPuRlTt089QvD9VaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=INDpckuq; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3e0c:5b00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id DF0BD173BF5;
	Sat, 13 Sep 2025 18:40:09 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757778010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6huP1+nDLI6k63MLOBg+p3mMtklkrrDFP4PDjhhA+HY=;
	b=INDpckuqk8KzuU/WMbEStnxdM9v9vreu7stAEofT5iibFHDcxZeXGDioTyNrklYzJut4G7
	Y7WKi5Bhid9Z/2ZKPAPiDDcnbvDOU3b8b7L+9ry6FZsGZBElcvWy8XSE56cTL5HQLv39dT
	+o7CMuMHPfZTakdftRAZuWmc+BcqHT1Zu/5qYf9OURgzR5fHNUUjwWnSMO0i1b6mUMP+Q5
	m52yJsX8b/CsY/1QQ4E70KKZSs9czp5BRn3mPd6DKj7+697wSz97woWAsLPKKoj+9Tel6F
	M8otqLMCntTPBe1R/EeIVxdaypzg4jROeuyXx6oyuh45rCJLM5xFdCGuGxBCBQ==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Sat, 13 Sep 2025 18:39:34 +0300
Subject: [PATCH v3 13/18] iio: accel: bma220: add i2c module
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-b4-bma220_improvements-v3-13-0b97279b4e45@subdimension.ro>
References: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
In-Reply-To: <20250913-b4-bma220_improvements-v3-0-0b97279b4e45@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Petre Rodan <petre.rodan@subdimension.ro>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5792;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=cuM5TiHwvZpA7h/CSYN/B/E+9xrSArcAg0vkWZF5ufQ=;
 b=owEBbQKS/ZANAwAIAc8mmZmETn8wAcsmYgBoxZBSPHeQXexz+vuK/+v9D7WJP8iTm9jWDL43E
 g3Lxs6GageJAjMEAAEIAB0WIQTYCn/BdhUZNew+X6nPJpmZhE5/MAUCaMWQUgAKCRDPJpmZhE5/
 MNwHD/sF+6U1IxphyNaEDfaLzGOg6zVo1GcSGsnB/Axj5ZwZDKe5yqHKeNuXUQ6Ww7b7qGpokHM
 s6ygWNJ9Ktkklmt9CB5Q4LnNX569m0WJrjCc5+kTwuzGc3kvqcZu0dXugQWzfejR0Hmjq2GydV/
 C9wduQvYNLf4HdPa9oLdS4zOvLXpA8hWei09XZrclDxkihWwelWkbOciaZ6kwyHymeezyUMo1CZ
 21EbNtqe3KAu6DbIpPFgUVnogm4VOmcMYQlymrUSxk+uz8NhBW8zsRkGWgW5UZ/KzTGJ9BD3SQK
 PdSLkbWWc2wChT1YN+fIVYxn87ncf/7VeNZWTOcNZjtAhwLRgBMcU0+zzry1+6V98FqCYVl84iv
 M7YiCWOyG1qxSJXMZwoDq8cJ+U9k+PkbDYFUKYI9hWTTUcrpH6tScBYGElAEIRmv4hGsBSWeopR
 kZ+g9c06ROe2YOfx9QlyLDzxhutAyXQ+vVq+zMpgqExdLS7d3eQi7wdXd+Mx6RTlqlDIbiA/3DA
 1DX4eYGylhw3rHYHzfGe/FBWW1CvLb6FPh8GM9S/LSkNffYPDVKJVSgyGewzqUEC4GF6Or6LZRk
 GVSGD7OavG/pkU3p/jakGkyA7HXKNkzrEvJXjJ19VWr4To5yxZ0FCk9L4qzIYoiTNaIe9WJW2pm
 308mn28uG154LOQ==
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
index f9f4fa3daf33665f07f8bf073468dff070b46d74..a5127e997b1f970a86bd3394ed566b3a92a8ee1c 100644
--- a/drivers/iio/accel/bma220.h
+++ b/drivers/iio/accel/bma220.h
@@ -11,6 +11,7 @@
 #include <linux/pm.h>
 #include <linux/regmap.h>
 
+extern const struct regmap_config bma220_i2c_regmap_config;
 extern const struct regmap_config bma220_spi_regmap_config;
 extern const struct dev_pm_ops bma220_pm_ops;
 
diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index 3252fb2d7fdcc84431ef19f5dbac8be01060e036..5eef47151501119ab792aab6a511938a16c1ade1 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -174,6 +174,24 @@ const struct regmap_config bma220_spi_regmap_config = {
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


