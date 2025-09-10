Return-Path: <linux-iio+bounces-23920-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA52BB51031
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 09:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023C61C80695
	for <lists+linux-iio@lfdr.de>; Wed, 10 Sep 2025 08:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE2230FF36;
	Wed, 10 Sep 2025 07:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="53JYks8t"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8046E30F800;
	Wed, 10 Sep 2025 07:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491094; cv=none; b=lnRbY+oS/6YhxcrmNaHlXl5lU5YYocOyBGt5PX+urshUyiOmsqAdj3IUocUWYNDsc7f+fBqAm9c3VQN0Yhz6JkvDrlO+ykPDOnyB3dThg0wxWF8qCjBv4qGkM6T9PBiv3jEC4P6T9GVwQXX9l4D/YkPe2yuAUE/Pd0Vbl+NXn4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491094; c=relaxed/simple;
	bh=RTZw4uDnll1cZJo23ly7UvXXjnqrpFWaLvHw980X6B4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XMBXR6h5HBqu6BMoOdgNuH/sM+15sJeLHh1lsp/zNpVEpEgY6MRuNIEpWOuPeq88d2clXf8s64bRuEkyFBmYNir1RBo7nSKBZAuNuOdaJKYLLZzXNQfWTdl57RTMKHRRFgFnKGBULFpti1oz7MMHBwud3q7aRpONihwUscTK2j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=53JYks8t; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from [10.212.0.13] (unknown [IPv6:2a02:2f0e:3503:4a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 2378F173BF1;
	Wed, 10 Sep 2025 10:58:05 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757491085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hux/M/0FgLpbyrxaPAKanHcmyeYQoBgJs8k97/CVXwM=;
	b=53JYks8t0+deSdSZhFtm/LY8Y/qgMuekQ7+BKcwRDoWUOmzULDC2djmKkiI3Hff5RQmwt2
	jjUI3OppNNJGb3xCyqE3vhGYzAqe7neyKA1Wef42wzylXfRKZq6iGDxIaIdzdlan7aMBP/
	FTMnsoZ70CK+HZYibvFp+Xe6c/SVVhGu0JLeerkTJuQLB3UanAf+p3TJ+yIHL6UKvuNcfN
	omE5GgmUxIhuOVP6GSbi1brWBTmw6Yi0bySS0KkTfwIBiTKvEb0osdi/hT6F4saedZhWi2
	9CDhNXfiLci446io8NYqXNHw+kC6hPS3RGZTqdyX/bomh43bqE4AZ4j91L0P1w==
From: Petre Rodan <petre.rodan@subdimension.ro>
Date: Wed, 10 Sep 2025 10:57:14 +0300
Subject: [PATCH v2 09/14] iio: accel: bma220: add i2c module
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-bma220_improvements-v2-9-e23f4f2b9745@subdimension.ro>
References: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
In-Reply-To: <20250910-bma220_improvements-v2-0-e23f4f2b9745@subdimension.ro>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5661;
 i=petre.rodan@subdimension.ro; h=from:subject:message-id;
 bh=RTZw4uDnll1cZJo23ly7UvXXjnqrpFWaLvHw980X6B4=;
 b=owEBbQKS/ZANAwAIAc8mmZmETn8wAcsmYgBowS+Hw8rlEeIDTwdyHE4qi5gTZmyv1TaFC3nDd
 TeIJl2Ncb2JAjMEAAEIAB0WIQTYCn/BdhUZNew+X6nPJpmZhE5/MAUCaMEvhwAKCRDPJpmZhE5/
 MCYJEAC6Qy2lhMqXyUOmErnn+myXgdYx3+/Kcz5t8yiarQ4LC1+oTkOzYlmqOsSdGjh1Ol+tdRS
 W2amQ2AzEBAbA3RQSCKVL5cu2VUjGT3re/Md2XkQOVWgXUJSQFBC3FtAeQAR6G9rvkz4l2IYFPX
 kHn2kar7vMxRfdg7JdnGXyuUs1H7G/KuNr8v8vwdEzSuk2K1ERSGzizVyy/fF2fbjVpDx2xllXp
 wuK0gQ40How26Hp1iS7B6HaA/MG+NOnZuylfarZpgF1BO7aod0umVPbInlnJcGPhB9MYjKTcURi
 lx/4tM9HqSJHA56aXYnYubVVLBPK/UJ/BBzlB8PDwJzmY57SkzSVxsh2xXFjhw6xxXMe9E2rO29
 HOrany/ASNyX6jOJkm6rsLGKlkIUbN4JesMWgqD/UJ4rFO/KbRDg0+7cQMB6UKGVB7DSgVCx3KQ
 6HIZH/JrYMGj0e70wFYlGJkOFwuHJ/YG8SCisfPzquC+UeNy3GltFekoTr9z7617doov3YxK9km
 xqqMwGU/lHuBwh0NmzKCqBYm3XKIEIngAiHy+ca9FZS80Lp+tCPzumvgG8+UkQC0xwe/f6NhgtO
 z3+prBH2gQoyC/TNqNmUrOvkPB0kRaowvg0eEFwWQcSeldT+qv8zkqGpN5lMztIAFZG0JTBYF8V
 B7YhOkh1NrkKYRA==
X-Developer-Key: i=petre.rodan@subdimension.ro; a=openpgp;
 fpr=D80A7FC176151935EC3E5FA9CF269999844E7F30

Add the bma220_i2c module.

Note that this kernel module transparently shifts all register addresses
1 bit to the left, so all functions will operate based on the SPI memory
map.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
no change
---
 drivers/iio/accel/Kconfig       |  9 +++++-
 drivers/iio/accel/Makefile      |  1 +
 drivers/iio/accel/bma220.h      |  1 +
 drivers/iio/accel/bma220_core.c | 18 ++++++++++++
 drivers/iio/accel/bma220_i2c.c  | 61 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 9b6c35b759481df5ff3c91856f8783357d25de80..b3c5b0b7a406ec0cec531a122af424cb8ec57703 100644
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
index f9f4fa3daf33665f07f8bf073468dff070b46d74..384557d10d5613b7d829c6666f3da06de219277a 100644
--- a/drivers/iio/accel/bma220.h
+++ b/drivers/iio/accel/bma220.h
@@ -12,6 +12,7 @@
 #include <linux/regmap.h>
 
 extern const struct regmap_config bma220_spi_regmap_config;
+extern const struct regmap_config bma220_i2c_regmap_config;
 extern const struct dev_pm_ops bma220_pm_ops;
 
 int bma220_common_probe(struct device *dev, struct regmap *regmap, int irq);
diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index 4d8b65ea737a2d5fe74f98da13a582a80874a5af..191074d8618ea2638f69283781b8677921876681 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -175,6 +175,24 @@ const struct regmap_config bma220_spi_regmap_config = {
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
index 0000000000000000000000000000000000000000..2b63949ea64ee11421e76a2e7c868a922d1f9a12
--- /dev/null
+++ b/drivers/iio/accel/bma220_i2c.c
@@ -0,0 +1,61 @@
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


