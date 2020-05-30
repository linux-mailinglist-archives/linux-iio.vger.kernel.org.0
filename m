Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01471E9349
	for <lists+linux-iio@lfdr.de>; Sat, 30 May 2020 21:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgE3TLM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 30 May 2020 15:11:12 -0400
Received: from sender4-op-o17.zoho.com ([136.143.188.17]:17726 "EHLO
        sender4-op-o17.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbgE3TLM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 May 2020 15:11:12 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590865835; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=nJe8zH8yDo3vFHfPDXXGSuOgH2dYZWM/jk1dIxyeCnKcZ0IS9u1S7Cf16VgV73vLlGkWKSP3SZcd/2J8mI4c22OaICkHz2xyItAr791+FKrysVqRCv39PNPDyBFE24phjtgny4lLaZ2imUVkyTKkBs9cLacdPcw9EQV70UzFp/4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1590865835; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=hOKnJMB07RmP9so6a84tsCDdNTWvFiSY6deGj4c9nOw=; 
        b=BF45zUVvuWQZtXojQ4htxd2wVpbq/ii+Qvqg2XnmtM1TkUQclPYfk5AGJidYQNOKbOpFF8cOAs6YlSdxEw65eUKwGhbxa98N+dlUBNxk+7h63Wu0LSZlh4z11jcw15yFQ2zbSF1sSf3MYPvD4DGy/gDjRAlVfJ3hjD8GlE6OQpg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from gothmog.test (pool-108-48-181-150.washdc.fios.verizon.net [108.48.181.150]) by mx.zohomail.com
        with SMTPS id 1590865833693525.2384703616822; Sat, 30 May 2020 12:10:33 -0700 (PDT)
From:   Dan Robertson <dan@dlrobertson.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, Dan Robertson <dan@dlrobertson.com>
Message-ID: <20200530191010.4302-2-dan@dlrobertson.com>
Subject: [PATCH v2 1/1] iio: accel: bma400: add support for bma400 spi
Date:   Sat, 30 May 2020 19:10:10 +0000
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200530191010.4302-1-dan@dlrobertson.com>
References: <20200530191010.4302-1-dan@dlrobertson.com>
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
 drivers/iio/accel/bma400_spi.c | 120 +++++++++++++++++++++++++++++++++
 3 files changed, 128 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/accel/bma400_spi.c

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 1080637ca40e..2e0c62c39155 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -116,18 +116,24 @@ config BMA400
 	tristate "Bosch BMA400 3-Axis Accelerometer Driver"
 	select REGMAP
 	select BMA400_I2C if I2C
+	select BMA400_SPI if SPI
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
index 000000000000..7c2825904e08
--- /dev/null
+++ b/drivers/iio/accel/bma400_spi.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SPI IIO driver for Bosch BMA400 triaxial acceleration sensor.
+ *
+ * Copyright 2020 Dan Robertson <dan@dlrobertson.com>
+ *
+ */
+#include <linux/bits.h>
+#include <linux/init.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
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
+	u8 result[BMA400_SPI_READ_BUFFER_SIZE];
+	ssize_t status;
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
+	const struct spi_device_id *id = spi_get_device_id(spi);
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
+	 * return garbage. As the datasheet recommends, the
+	 * chip ID register will be read here and checked
+	 * again in the following probe.
+	 */
+	ret = regmap_read(regmap, BMA400_CHIP_ID_REG, &val);
+	if (ret)
+		dev_err(&spi->dev, "Failed to read chip id register\n");
+
+	return bma400_probe(&spi->dev, regmap, id->name);
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
+MODULE_AUTHOR("Dan Robertson <dan@dlrobertson.com>");
+MODULE_DESCRIPTION("Bosch BMA400 triaxial acceleration sensor (SPI)");
+MODULE_LICENSE("GPL");

