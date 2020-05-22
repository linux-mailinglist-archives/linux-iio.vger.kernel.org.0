Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A316F1DDCFE
	for <lists+linux-iio@lfdr.de>; Fri, 22 May 2020 04:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgEVCDT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 21 May 2020 22:03:19 -0400
Received: from sender4-op-o13.zoho.com ([136.143.188.13]:17355 "EHLO
        sender4-op-o13.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgEVCDT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 May 2020 22:03:19 -0400
X-Greylist: delayed 920 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 May 2020 22:03:18 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1590112060; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=TtWG8bOr+l2cUzQQQuH/C/1bxKX3zjQcNMGq62xqEz3ei1OunWd8WfPp1wgsTI31qWURYQy+ZzE0wftaW14nw0M4ufHT9u5GFf84YCx5ut4ffTpnOIfhLnmRd0b7ILYCDF/HhBrgtQvILzKgDLvb6TCH6WwIjXpJszNEtUWysU8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1590112060; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=x3B2RQ6ZO76BbbxGVulJCWNjzrXHXwCUoOG5Y58uDiw=; 
        b=Y4f74Zu2sQI0/eG9D3GONIp2kRZQDSHGQ/rx2VXWzvTFap0LfmOtAFbobk+XhOhucXfUmGA29it6EckGnzYjd1V46vWXF9euNLHdH+PVTw2MPqdhDsSnAlQg/Udqamom7iOEtlU502CnrMzCIjwSQzCPBrOI3yNGzGqvJYbFIxo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from gothmog.test (pool-96-255-47-18.washdc.fios.verizon.net [96.255.47.18]) by mx.zohomail.com
        with SMTPS id 15901120579821002.9855844976217; Thu, 21 May 2020 18:47:37 -0700 (PDT)
From:   Dan Robertson <dan@dlrobertson.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, Dan Robertson <dan@dlrobertson.com>
Message-ID: <20200522014634.28505-2-dan@dlrobertson.com>
Subject: [PATCH 1/1] iio: accel: bma400: add support for bma400 spi
Date:   Fri, 22 May 2020 01:46:34 +0000
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522014634.28505-1-dan@dlrobertson.com>
References: <20200522014634.28505-1-dan@dlrobertson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add basic support for the Bosch Sensortec BMA400 3-axes ultra-low power
accelerometer when configured to use SPI.

Signed-off-by: Dan Robertson <dan@dlrobertson.com>
---
 drivers/iio/accel/Kconfig      |   8 ++-
 drivers/iio/accel/Makefile     |   1 +
 drivers/iio/accel/bma400_spi.c | 126 +++++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/accel/bma400_spi.c

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 24ebe9e76915..cb4ef367e5fa 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -116,18 +116,24 @@ config BMA400
 	tristate "Bosch BMA400 3-Axis Accelerometer Driver"
 	select REGMAP
 	select BMA400_I2C if I2C
+	select BMA400_SPI if I2C
 	help
 	  Say Y here if you want to build a driver for the Bosch BMA400
 	  triaxial acceleration sensor.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called bma400_core and you will also get
-	  bma400_i2c if I2C is enabled.
+	  bma400_i2c if I2C is enabled and bma400_spi if SPI is
+	  enabled.
 
 config BMA400_I2C
 	tristate
 	depends on BMA400
 
+config BMA400_SPI
+	tristate
+	depends on BMA400
+
 config BMC150_ACCEL
 	tristate "Bosch BMC150 Accelerometer Driver"
 	select IIO_BUFFER
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 3a051cf37f40..4f6c1ebe13b0 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_BMA180) += bma180.o
 obj-$(CONFIG_BMA220) += bma220_spi.o
 obj-$(CONFIG_BMA400) += bma400_core.o
 obj-$(CONFIG_BMA400_I2C) += bma400_i2c.o
+obj-$(CONFIG_BMA400_SPI) += bma400_spi.o
 obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
 obj-$(CONFIG_BMC150_ACCEL_I2C) += bmc150-accel-i2c.o
 obj-$(CONFIG_BMC150_ACCEL_SPI) += bmc150-accel-spi.o
diff --git a/drivers/iio/accel/bma400_spi.c b/drivers/iio/accel/bma400_spi.c
new file mode 100644
index 000000000000..d92b37e1a657
--- /dev/null
+++ b/drivers/iio/accel/bma400_spi.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SPI IIO driver for Bosch BMA400 triaxial acceleration sensor.
+ *
+ * Copyright 2020 Dan Robertson <dan@dlrobertson.com>
+ *
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+
+#include <linux/spi/spi.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include "bma400.h"
+
+#define BMA400_MAX_SPI_READ 2
+#define BMA400_SPI_READ_BUFFER_SIZE (BMA400_MAX_SPI_READ + 1)
+
+static int bma400_regmap_spi_read(void *context,
+				  const void *reg, size_t reg_size,
+				  void *val, size_t val_size)
+{
+	struct device *dev = context;
+	struct spi_device *spi = to_spi_device(dev);
+	ssize_t status;
+	/*
+	 * TODO(dlrobertson): What is a reasonable length to cap
+	 * this at.
+	 */
+	u8 result[BMA400_SPI_READ_BUFFER_SIZE];
+
+	if (val_size > BMA400_MAX_SPI_READ)
+		return -EINVAL;
+
+	status = spi_write_then_read(spi, reg, 1, result, val_size + 1);
+	if (status)
+		return status;
+
+	/*
+	 * From the BMA400 datasheet:
+	 *
+	 * > For a basic read operation two bytes have to be read and the first
+	 * > has to be dropped and the second byte must be interpreted.
+	 */
+	memcpy(val, result + 1, val_size);
+
+	return 0;
+}
+
+static int bma400_regmap_spi_write(void *context, const void *data,
+				   size_t count)
+{
+	struct device *dev = context;
+	struct spi_device *spi = to_spi_device(dev);
+
+	return spi_write(spi, data, count);
+}
+
+static struct regmap_bus bma400_regmap_bus = {
+	.read = bma400_regmap_spi_read,
+	.write = bma400_regmap_spi_write,
+	.read_flag_mask = BIT(7),
+	.max_raw_read = BMA400_MAX_SPI_READ,
+};
+
+static int bma400_spi_probe(struct spi_device *spi)
+{
+	struct regmap *regmap;
+	unsigned int val;
+	int ret;
+
+	regmap = devm_regmap_init(&spi->dev, &bma400_regmap_bus,
+				  &spi->dev, &bma400_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&spi->dev, "failed to create regmap\n");
+		return PTR_ERR(regmap);
+	}
+
+	/*
+	 * Per the bma400 datasheet, the first SPI read may
+	 * return garbage on the first read. The chip ID
+	 * register will be read and checked again in the
+	 * following probe.
+	 */
+	ret = regmap_read(regmap, BMA400_CHIP_ID_REG, &val);
+	if (ret)
+		dev_err(&spi->dev, "Failed to read chip id register\n");
+
+	return bma400_probe(&spi->dev, regmap, "bma400");
+}
+
+static int bma400_spi_remove(struct spi_device *spi)
+{
+	return bma400_remove(&spi->dev);
+}
+
+static const struct spi_device_id bma400_spi_ids[] = {
+	{ "bma400", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, bma400_spi_ids);
+
+static const struct of_device_id bma400_of_spi_match[] = {
+	{ .compatible = "bosch,bma400" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bma400_of_spi_match);
+
+static struct spi_driver bma400_spi_driver = {
+	.driver = {
+		.name = "bma400",
+		.of_match_table = bma400_of_spi_match,
+	},
+	.probe    = bma400_spi_probe,
+	.remove   = bma400_spi_remove,
+	.id_table = bma400_spi_ids,
+};
+
+module_spi_driver(bma400_spi_driver);
+
+MODULE_AUTHOR("Dan Robertson <dan@dlrobertson.com>");
+MODULE_DESCRIPTION("Bosch BMA400 triaxial acceleration sensor (SPI)");
+MODULE_LICENSE("GPL");

