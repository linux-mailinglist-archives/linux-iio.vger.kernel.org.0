Return-Path: <linux-iio+bounces-25742-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C3EC25023
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 13:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B5C3835120B
	for <lists+linux-iio@lfdr.de>; Fri, 31 Oct 2025 12:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689683491FE;
	Fri, 31 Oct 2025 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H71MXc2F"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217413491C5
	for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2025 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913862; cv=none; b=harKz0JnTG43+b1J6XNzjS3IQCmeNmgzhIgFu8zkeLlD4NjUXNxTSmp8gNmUfO2Ma4npzyod6krXuT7Q2xihvjtZkZUD8HwboOAtFruBA8BhTNtcLUTanlw46a1t76EgyDjqKrOhm/A9+DkERgBAjAqE891+bpwFnjzrkbwPrcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913862; c=relaxed/simple;
	bh=Z+xRsD0IHR7K66cqBHtCT4b5jYvnJFqNImw1jU3wYm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IyLx+dpyOH/YfQ3xfeO5V7yMtXp/cjJN9Yqvc4rwylkxJZJsH+wVPMjIHVy2rjccxwCPk924Txdk4SMSiZrR+ICbKFzgIwC31x46Xqt3nBZ/5raGaUCRhO4/a6tFLV+YvLscfL2sT86e0alr9MgPERDoU/mv6ng1yMz8Kt7cmrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H71MXc2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F20ACC4CEFB;
	Fri, 31 Oct 2025 12:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761913862;
	bh=Z+xRsD0IHR7K66cqBHtCT4b5jYvnJFqNImw1jU3wYm4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=H71MXc2FtsTserU31gkhJjEzfqgyAeEAAfKqym7L8IcoDbL8pqonfi4TsHE0hCNVp
	 6ybFyQnbecSkVBqBn7c3HoJeEhPiHP75djh3nfE86FcPHoxop87sgbVW213QipNm1S
	 S+QsbbuEFTRrKcShXtmPKXdwTBLKzsyfUN6zjNAqhiNfteGQ2rdVLhlNXdOVDfI0+X
	 f86nU0qG0gkgfzyfm9XLhBhhOZO9nC6jloxq/eAWbMRD1NdlQKF94ot3zTBs3hzqPX
	 gppej52rCXFe/QgBRPtdhxMZ9AQNIY420P5g7wL5xwLOYJ/0AKTlCUc0YKKI2OSl8y
	 Gvmwj2ymzhuWQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5D8CCF9FF;
	Fri, 31 Oct 2025 12:31:01 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 31 Oct 2025 12:31:27 +0000
Subject: [PATCH v3 06/10] iio: dac: ad5446: Separate I2C/SPI into different
 drivers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251031-dev-add-ad5542-v3-6-d3541036c0e6@analog.com>
References: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
In-Reply-To: <20251031-dev-add-ad5542-v3-0-d3541036c0e6@analog.com>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761913895; l=34957;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=2C5krzWUDBfAMrfMQhGJMnxp7OAyF6PyHB+Nr262ybE=;
 b=Fck2L8ySar6/8b7etdv11tMYk7y+vDm2m61WX1oCoymsXRAi0GYwyt7YmYrJ961pj/l5kQyDf
 8o/nZ45VQv6C7M7YsIWQq5utjYrgSCzYKegHOoe9YVCaRaxAF2DKPeT
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Properly separate the I2C and SPI drivers into two different drivers
living in their own source file (as usual). So that no need for the
hacky ifdefery.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 MAINTAINERS                  |   4 +
 drivers/iio/dac/Kconfig      |  31 ++-
 drivers/iio/dac/Makefile     |   2 +
 drivers/iio/dac/ad5446-i2c.c |  99 ++++++++++
 drivers/iio/dac/ad5446-spi.c | 252 ++++++++++++++++++++++++
 drivers/iio/dac/ad5446.c     | 447 +------------------------------------------
 drivers/iio/dac/ad5446.h     |  76 ++++++++
 7 files changed, 465 insertions(+), 446 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9654f0c25423..c845ad7307fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -447,6 +447,10 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
+F:	drivers/iio/dac/ad5446-i2c.c
+F:	drivers/iio/dac/ad5446-spi.c
+F:	drivers/iio/dac/ad5446.c
+F:	drivers/iio/dac/ad5446.h
 
 AD714X CAPACITANCE TOUCH SENSOR DRIVER (AD7142/3/7/8/7A)
 M:	Michael Hennerich <michael.hennerich@analog.com>
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index e0996dc014a3..7cd3caec1262 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -97,17 +97,32 @@ config AD5421
 	  ad5421.
 
 config AD5446
-	tristate "Analog Devices AD5446 and similar single channel DACs driver"
-	depends on (SPI_MASTER && I2C!=m) || I2C
+	tristate
+
+config AD5446_SPI
+	tristate "Analog Devices AD5446 and similar single channel DACs driver (SPI)"
+	depends on SPI
+	select AD5446
 	help
-	  Say yes here to build support for Analog Devices AD5300, AD5301, AD5310,
-	  AD5311, AD5320, AD5321, AD5444, AD5446, AD5450, AD5451, AD5452, AD5453,
-	  AD5512A, AD5541A, AD5542A, AD5543, AD5553, AD5600, AD5601, AD5602, AD5611,
-	  AD5612, AD5620, AD5621, AD5622, AD5640, AD5641, AD5660, AD5662 DACs
-	  as well as Texas Instruments DAC081S101, DAC101S101, DAC121S101.
+	  Say yes here to build support for Analog Devices AD5300, AD5310,
+	  AD5320, AD5444, AD5446, AD5450, AD5451, AD5452, AD5453, AD5512A,
+	  AD5541A, AD5542A, AD5543, AD5553, AD5600, AD5601, AD5611, AD5620,
+	  AD5621, AD5640, AD5641, AD5660, AD5662 DACs as well as
+	  Texas Instruments DAC081S101, DAC101S101, DAC121S101.
 
 	  To compile this driver as a module, choose M here: the
-	  module will be called ad5446.
+	  module will be called ad5446-spi.
+
+config AD5446_I2C
+	tristate "Analog Devices AD5446 and similar single channel DACs driver (I2C)"
+	depends on I2C
+	select AD5446
+	help
+	  Say yes here to build support for Analog Devices AD5301, AD5311, AD5321,
+	  AD5602, AD5612, AD5622 DACs.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad5446-i2c.
 
 config AD5449
 	tristate "Analog Devices AD5449 and similar DACs driver"
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 3684cd52b7fa..e6ac4c67e337 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -15,6 +15,8 @@ obj-$(CONFIG_AD5624R_SPI) += ad5624r_spi.o
 obj-$(CONFIG_AD5064) += ad5064.o
 obj-$(CONFIG_AD5504) += ad5504.o
 obj-$(CONFIG_AD5446) += ad5446.o
+obj-$(CONFIG_AD5446_SPI) += ad5446-spi.o
+obj-$(CONFIG_AD5446_I2C) += ad5446-i2c.o
 obj-$(CONFIG_AD5449) += ad5449.o
 obj-$(CONFIG_AD5592R_BASE) += ad5592r-base.o
 obj-$(CONFIG_AD5592R) += ad5592r.o
diff --git a/drivers/iio/dac/ad5446-i2c.c b/drivers/iio/dac/ad5446-i2c.c
new file mode 100644
index 000000000000..9d1054c3dd8e
--- /dev/null
+++ b/drivers/iio/dac/ad5446-i2c.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AD5446 SPI I2C driver
+ *
+ * Copyright 2025 Analog Devices Inc.
+ */
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/i2c.h>
+
+#include "ad5446.h"
+
+static int ad5622_write(struct ad5446_state *st, unsigned int val)
+{
+	struct i2c_client *client = to_i2c_client(st->dev);
+	int ret;
+
+	st->d16 = cpu_to_be16(val);
+
+	ret = i2c_master_send_dmasafe(client, (char *)&st->d16, sizeof(st->d16));
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(st->d16))
+		return -EIO;
+
+	return 0;
+}
+
+static int ad5446_i2c_probe(struct i2c_client *i2c)
+{
+	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
+	const struct ad5446_chip_info *chip_info;
+
+	chip_info = i2c_get_match_data(i2c);
+	if (!chip_info)
+		return -ENODEV;
+
+	return ad5446_probe(&i2c->dev, id->name, chip_info);
+}
+
+/*
+ * ad5446_supported_i2c_device_ids:
+ * The AD5620/40/60 parts are available in different fixed internal reference
+ * voltage options. The actual part numbers may look differently
+ * (and a bit cryptic), however this style is used to make clear which
+ * parts are supported here.
+ */
+
+static const struct ad5446_chip_info ad5602_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(8, 16, 4),
+	.write = ad5622_write,
+};
+
+static const struct ad5446_chip_info ad5612_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(10, 16, 2),
+	.write = ad5622_write,
+};
+
+static const struct ad5446_chip_info ad5622_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 0),
+	.write = ad5622_write,
+};
+
+static const struct i2c_device_id ad5446_i2c_ids[] = {
+	{"ad5301", (kernel_ulong_t)&ad5602_chip_info},
+	{"ad5311", (kernel_ulong_t)&ad5612_chip_info},
+	{"ad5321", (kernel_ulong_t)&ad5622_chip_info},
+	{"ad5602", (kernel_ulong_t)&ad5602_chip_info},
+	{"ad5612", (kernel_ulong_t)&ad5612_chip_info},
+	{"ad5622", (kernel_ulong_t)&ad5622_chip_info},
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ad5446_i2c_ids);
+
+static const struct of_device_id ad5446_i2c_of_ids[] = {
+	{ .compatible = "adi,ad5301", .data = &ad5602_chip_info },
+	{ .compatible = "adi,ad5311", .data = &ad5612_chip_info },
+	{ .compatible = "adi,ad5321", .data = &ad5622_chip_info },
+	{ .compatible = "adi,ad5602", .data = &ad5602_chip_info },
+	{ .compatible = "adi,ad5612", .data = &ad5612_chip_info },
+	{ .compatible = "adi,ad5622", .data = &ad5622_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(OF, ad5446_i2c_of_ids);
+
+static struct i2c_driver ad5446_i2c_driver = {
+	.driver = {
+		.name	= "ad5446",
+		.of_match_table = ad5446_i2c_of_ids,
+	},
+	.probe = ad5446_i2c_probe,
+	.id_table = ad5446_i2c_ids,
+};
+module_i2c_driver(ad5446_i2c_driver);
+
+MODULE_AUTHOR("Nuno Sá <nuno.sa@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD5444/AD5446 I2C DACs");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_AD5446");
diff --git a/drivers/iio/dac/ad5446-spi.c b/drivers/iio/dac/ad5446-spi.c
new file mode 100644
index 000000000000..7419b17a455f
--- /dev/null
+++ b/drivers/iio/dac/ad5446-spi.c
@@ -0,0 +1,252 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AD5446 SPI DAC driver
+ *
+ * Copyright 2025 Analog Devices Inc.
+ */
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/spi/spi.h>
+#include <linux/unaligned.h>
+
+#include "ad5446.h"
+
+static int ad5446_write(struct ad5446_state *st, unsigned int val)
+{
+	struct spi_device *spi = to_spi_device(st->dev);
+
+	st->d16 = cpu_to_be16(val);
+
+	return spi_write(spi, &st->d16, sizeof(st->d16));
+}
+
+static int ad5660_write(struct ad5446_state *st, unsigned int val)
+{
+	struct spi_device *spi = to_spi_device(st->dev);
+
+	put_unaligned_be24(val, &st->d24[0]);
+
+	return spi_write(spi, st->d24, sizeof(st->d24));
+}
+
+static int ad5446_spi_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id = spi_get_device_id(spi);
+	const struct ad5446_chip_info *chip_info;
+
+	chip_info = spi_get_device_match_data(spi);
+	if (!chip_info)
+		return -ENODEV;
+
+	return ad5446_probe(&spi->dev, id->name, chip_info);
+}
+
+/*
+ * ad5446_supported_spi_device_ids:
+ * The AD5620/40/60 parts are available in different fixed internal reference
+ * voltage options. The actual part numbers may look differently
+ * (and a bit cryptic), however this style is used to make clear which
+ * parts are supported here.
+ */
+
+static const struct ad5446_chip_info ad5300_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(8, 16, 4),
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5310_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(10, 16, 2),
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5320_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 0),
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5444_chip_info = {
+	.channel = AD5446_CHANNEL(12, 16, 2),
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5446_chip_info = {
+	.channel = AD5446_CHANNEL(14, 16, 0),
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5450_chip_info = {
+	.channel = AD5446_CHANNEL(8, 16, 6),
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5451_chip_info = {
+	.channel = AD5446_CHANNEL(10, 16, 4),
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5541a_chip_info = {
+	.channel = AD5446_CHANNEL(16, 16, 0),
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5512a_chip_info = {
+	.channel = AD5446_CHANNEL(12, 16, 4),
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5553_chip_info = {
+	.channel = AD5446_CHANNEL(14, 16, 0),
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5600_chip_info = {
+	.channel = AD5446_CHANNEL(16, 16, 0),
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5601_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(8, 16, 6),
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5611_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(10, 16, 4),
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5621_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 2),
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5641_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(14, 16, 0),
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5620_2500_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 2),
+	.int_vref_mv = 2500,
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5620_1250_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 2),
+	.int_vref_mv = 1250,
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5640_2500_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(14, 16, 0),
+	.int_vref_mv = 2500,
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5640_1250_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(14, 16, 0),
+	.int_vref_mv = 1250,
+	.write = ad5446_write,
+};
+
+static const struct ad5446_chip_info ad5660_2500_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(16, 16, 0),
+	.int_vref_mv = 2500,
+	.write = ad5660_write,
+};
+
+static const struct ad5446_chip_info ad5660_1250_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(16, 16, 0),
+	.int_vref_mv = 1250,
+	.write = ad5660_write,
+};
+
+static const struct ad5446_chip_info ad5662_chip_info = {
+	.channel = AD5446_CHANNEL_POWERDOWN(16, 16, 0),
+	.write = ad5660_write,
+};
+
+static const struct spi_device_id ad5446_spi_ids[] = {
+	{"ad5300", (kernel_ulong_t)&ad5300_chip_info},
+	{"ad5310", (kernel_ulong_t)&ad5310_chip_info},
+	{"ad5320", (kernel_ulong_t)&ad5320_chip_info},
+	{"ad5444", (kernel_ulong_t)&ad5444_chip_info},
+	{"ad5446", (kernel_ulong_t)&ad5446_chip_info},
+	{"ad5450", (kernel_ulong_t)&ad5450_chip_info},
+	{"ad5451", (kernel_ulong_t)&ad5451_chip_info},
+	{"ad5452", (kernel_ulong_t)&ad5444_chip_info}, /* ad5452 is compatible to the ad5444 */
+	{"ad5453", (kernel_ulong_t)&ad5446_chip_info}, /* ad5453 is compatible to the ad5446 */
+	{"ad5512a", (kernel_ulong_t)&ad5512a_chip_info},
+	{"ad5541a", (kernel_ulong_t)&ad5541a_chip_info},
+	{"ad5542a", (kernel_ulong_t)&ad5541a_chip_info}, /* ad5541a and ad5542a are compatible */
+	{"ad5543", (kernel_ulong_t)&ad5541a_chip_info}, /* ad5541a and ad5543 are compatible */
+	{"ad5553", (kernel_ulong_t)&ad5553_chip_info},
+	{"ad5600", (kernel_ulong_t)&ad5600_chip_info},
+	{"ad5601", (kernel_ulong_t)&ad5601_chip_info},
+	{"ad5611", (kernel_ulong_t)&ad5611_chip_info},
+	{"ad5621", (kernel_ulong_t)&ad5621_chip_info},
+	{"ad5641", (kernel_ulong_t)&ad5641_chip_info},
+	{"ad5620-2500", (kernel_ulong_t)&ad5620_2500_chip_info}, /* AD5620/40/60: */
+	/* part numbers may look differently */
+	{"ad5620-1250", (kernel_ulong_t)&ad5620_1250_chip_info},
+	{"ad5640-2500", (kernel_ulong_t)&ad5640_2500_chip_info},
+	{"ad5640-1250", (kernel_ulong_t)&ad5640_1250_chip_info},
+	{"ad5660-2500", (kernel_ulong_t)&ad5660_2500_chip_info},
+	{"ad5660-1250", (kernel_ulong_t)&ad5660_1250_chip_info},
+	{"ad5662", (kernel_ulong_t)&ad5662_chip_info},
+	{"dac081s101", (kernel_ulong_t)&ad5300_chip_info}, /* compatible Texas Instruments chips */
+	{"dac101s101", (kernel_ulong_t)&ad5310_chip_info},
+	{"dac121s101", (kernel_ulong_t)&ad5320_chip_info},
+	{"dac7512", (kernel_ulong_t)&ad5320_chip_info},
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad5446_spi_ids);
+
+static const struct of_device_id ad5446_of_ids[] = {
+	{ .compatible = "adi,ad5300", .data = &ad5300_chip_info },
+	{ .compatible = "adi,ad5310", .data = &ad5310_chip_info },
+	{ .compatible = "adi,ad5320", .data = &ad5320_chip_info },
+	{ .compatible = "adi,ad5444", .data = &ad5444_chip_info },
+	{ .compatible = "adi,ad5446", .data = &ad5446_chip_info },
+	{ .compatible = "adi,ad5450", .data = &ad5450_chip_info },
+	{ .compatible = "adi,ad5451", .data = &ad5451_chip_info },
+	{ .compatible = "adi,ad5452", .data = &ad5444_chip_info },
+	{ .compatible = "adi,ad5453", .data = &ad5446_chip_info },
+	{ .compatible = "adi,ad5512a", .data = &ad5512a_chip_info },
+	{ .compatible = "adi,ad5541a", .data = &ad5541a_chip_info },
+	{ .compatible = "adi,ad5542a", .data = &ad5541a_chip_info },
+	{ .compatible = "adi,ad5543", .data = &ad5541a_chip_info },
+	{ .compatible = "adi,ad5553", .data = &ad5553_chip_info },
+	{ .compatible = "adi,ad5600", .data = &ad5600_chip_info },
+	{ .compatible = "adi,ad5601", .data = &ad5601_chip_info },
+	{ .compatible = "adi,ad5611", .data = &ad5611_chip_info },
+	{ .compatible = "adi,ad5621", .data = &ad5621_chip_info },
+	{ .compatible = "adi,ad5641", .data = &ad5641_chip_info },
+	{ .compatible = "adi,ad5620-2500", .data = &ad5620_2500_chip_info },
+	{ .compatible = "adi,ad5620-1250", .data = &ad5620_1250_chip_info },
+	{ .compatible = "adi,ad5640-2500", .data = &ad5640_2500_chip_info },
+	{ .compatible = "adi,ad5640-1250", .data = &ad5640_1250_chip_info },
+	{ .compatible = "adi,ad5660-2500", .data = &ad5660_2500_chip_info },
+	{ .compatible = "adi,ad5660-1250", .data = &ad5660_1250_chip_info },
+	{ .compatible = "adi,ad5662", .data = &ad5662_chip_info },
+	{ .compatible = "ti,dac081s101", .data = &ad5300_chip_info },
+	{ .compatible = "ti,dac101s101", .data = &ad5310_chip_info },
+	{ .compatible = "ti,dac121s101", .data = &ad5320_chip_info },
+	{ .compatible = "ti,dac7512", .data = &ad5320_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad5446_of_ids);
+
+static struct spi_driver ad5446_spi_driver = {
+	.driver = {
+		.name	= "ad5446",
+		.of_match_table = ad5446_of_ids,
+	},
+	.probe = ad5446_spi_probe,
+	.id_table = ad5446_spi_ids,
+};
+module_spi_driver(ad5446_spi_driver);
+
+MODULE_AUTHOR("Nuno Sá <nuno.sa@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD5444/AD5446 SPI DACs");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_AD5446");
diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index 0c318f23b6a4..790e24770062 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -1,10 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * AD5446 SPI DAC driver
+ * AD5446 CORE DAC driver
  *
  * Copyright 2010 Analog Devices Inc.
  */
 
+#include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/workqueue.h>
 #include <linux/device.h>
@@ -12,60 +13,19 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/list.h>
-#include <linux/spi/spi.h>
-#include <linux/i2c.h>
 #include <linux/regulator/consumer.h>
 #include <linux/err.h>
 #include <linux/module.h>
-#include <linux/mod_devicetable.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-#include <linux/unaligned.h>
+#include "ad5446.h"
 
 #define MODE_PWRDWN_1k		0x1
 #define MODE_PWRDWN_100k	0x2
 #define MODE_PWRDWN_TRISTATE	0x3
 
-/**
- * struct ad5446_state - driver instance specific data
- * @dev:		this device
- * @chip_info:		chip model specific constants, available modes etc
- * @vref_mv:		actual reference voltage used
- * @cached_val:		store/retrieve values during power down
- * @pwr_down_mode:	power down mode (1k, 100k or tristate)
- * @pwr_down:		true if the device is in power down
- * @lock:		lock to protect the data buffer during write ops
- */
-
-struct ad5446_state {
-	struct device		*dev;
-	const struct ad5446_chip_info	*chip_info;
-	unsigned short			vref_mv;
-	unsigned			cached_val;
-	unsigned			pwr_down_mode;
-	unsigned			pwr_down;
-	struct mutex			lock;
-	union {
-		__be16 d16;
-		u8 d24[3];
-	} __aligned(IIO_DMA_MINALIGN);
-};
-
-/**
- * struct ad5446_chip_info - chip specific information
- * @channel:		channel spec for the DAC
- * @int_vref_mv:	AD5620/40/60: the internal reference voltage
- * @write:		chip specific helper function to write to the register
- */
-
-struct ad5446_chip_info {
-	struct iio_chan_spec	channel;
-	u16			int_vref_mv;
-	int			(*write)(struct ad5446_state *st, unsigned val);
-};
-
 static const char * const ad5446_powerdown_modes[] = {
 	"1kohm_to_gnd", "100kohm_to_gnd", "three_state"
 };
@@ -136,7 +96,7 @@ static ssize_t ad5446_write_dac_powerdown(struct iio_dev *indio_dev,
 	return ret ? ret : len;
 }
 
-static const struct iio_chan_spec_ext_info ad5446_ext_info_powerdown[] = {
+const struct iio_chan_spec_ext_info ad5446_ext_info_powerdown[] = {
 	{
 		.name = "powerdown",
 		.read = ad5446_read_dac_powerdown,
@@ -147,28 +107,7 @@ static const struct iio_chan_spec_ext_info ad5446_ext_info_powerdown[] = {
 	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE, &ad5446_powerdown_mode_enum),
 	{ }
 };
-
-#define _AD5446_CHANNEL(bits, storage, _shift, ext) { \
-	.type = IIO_VOLTAGE, \
-	.indexed = 1, \
-	.output = 1, \
-	.channel = 0, \
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
-	.scan_type = { \
-		.sign = 'u', \
-		.realbits = (bits), \
-		.storagebits = (storage), \
-		.shift = (_shift), \
-		}, \
-	.ext_info = (ext), \
-}
-
-#define AD5446_CHANNEL(bits, storage, shift) \
-	_AD5446_CHANNEL(bits, storage, shift, NULL)
-
-#define AD5446_CHANNEL_POWERDOWN(bits, storage, shift) \
-	_AD5446_CHANNEL(bits, storage, shift, ad5446_ext_info_powerdown)
+EXPORT_SYMBOL_NS_GPL(ad5446_ext_info_powerdown, "IIO_AD5446");
 
 static int ad5446_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
@@ -223,8 +162,8 @@ static const struct iio_info ad5446_info = {
 	.write_raw = ad5446_write_raw,
 };
 
-static int ad5446_probe(struct device *dev, const char *name,
-			const struct ad5446_chip_info *chip_info)
+int ad5446_probe(struct device *dev, const char *name,
+		 const struct ad5446_chip_info *chip_info)
 {
 	struct ad5446_state *st;
 	struct iio_dev *indio_dev;
@@ -264,25 +203,7 @@ static int ad5446_probe(struct device *dev, const char *name,
 
 	return devm_iio_device_register(dev, indio_dev);
 }
-
-#if IS_ENABLED(CONFIG_SPI_MASTER)
-
-static int ad5446_write(struct ad5446_state *st, unsigned val)
-{
-	struct spi_device *spi = to_spi_device(st->dev);
-	st->d16 = cpu_to_be16(val);
-
-	return spi_write(spi, &st->d16, sizeof(st->d16));
-}
-
-static int ad5660_write(struct ad5446_state *st, unsigned val)
-{
-	struct spi_device *spi = to_spi_device(st->dev);
-
-	put_unaligned_be24(val, &st->d24[0]);
-
-	return spi_write(spi, st->d24, sizeof(st->d24));
-}
+EXPORT_SYMBOL_NS_GPL(ad5446_probe, "IIO_AD5446");
 
 /*
  * ad5446_supported_spi_device_ids:
@@ -292,356 +213,6 @@ static int ad5660_write(struct ad5446_state *st, unsigned val)
  * parts are supported here.
  */
 
-static const struct ad5446_chip_info ad5300_chip_info = {
-	.channel = AD5446_CHANNEL_POWERDOWN(8, 16, 4),
-	.write = ad5446_write,
-};
-
-static const struct ad5446_chip_info ad5310_chip_info = {
-	.channel = AD5446_CHANNEL_POWERDOWN(10, 16, 2),
-	.write = ad5446_write,
-};
-
-static const struct ad5446_chip_info ad5320_chip_info = {
-	.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 0),
-	.write = ad5446_write,
-};
-
-static const struct ad5446_chip_info ad5444_chip_info = {
-	.channel = AD5446_CHANNEL(12, 16, 2),
-	.write = ad5446_write,
-};
-
-static const struct ad5446_chip_info ad5446_chip_info = {
-	.channel = AD5446_CHANNEL(14, 16, 0),
-	.write = ad5446_write,
-};
-
-static const struct ad5446_chip_info ad5450_chip_info = {
-	.channel = AD5446_CHANNEL(8, 16, 6),
-	.write = ad5446_write,
-};
-
-static const struct ad5446_chip_info ad5451_chip_info = {
-	.channel = AD5446_CHANNEL(10, 16, 4),
-	.write = ad5446_write,
-};
-
-static const struct ad5446_chip_info ad5541a_chip_info = {
-	.channel = AD5446_CHANNEL(16, 16, 0),
-	.write = ad5446_write,
-};
-
-static const struct ad5446_chip_info ad5512a_chip_info = {
-	.channel = AD5446_CHANNEL(12, 16, 4),
-	.write = ad5446_write,
-};
-
-static const struct ad5446_chip_info ad5553_chip_info = {
-	.channel = AD5446_CHANNEL(14, 16, 0),
-	.write = ad5446_write,
-};
-
-static const struct ad5446_chip_info ad5600_chip_info = {
-	.channel = AD5446_CHANNEL(16, 16, 0),
-	.write = ad5446_write,
-};
-
-static const struct ad5446_chip_info ad5601_chip_info = {
-	.channel = AD5446_CHANNEL_POWERDOWN(8, 16, 6),
-	.write = ad5446_write,
-};
-
-static const struct ad5446_chip_info ad5611_chip_info = {
-	.channel = AD5446_CHANNEL_POWERDOWN(10, 16, 4),
-	.write = ad5446_write,
-};
-
-static const struct ad5446_chip_info ad5621_chip_info = {
-	.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 2),
-	.write = ad5446_write,
-};
-
-static const struct ad5446_chip_info ad5641_chip_info = {
-	.channel = AD5446_CHANNEL_POWERDOWN(14, 16, 0),
-	.write = ad5446_write,
-};
-
-static const struct ad5446_chip_info ad5620_2500_chip_info = {
-	.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 2),
-	.int_vref_mv = 2500,
-	.write = ad5446_write,
-};
-
-static const struct ad5446_chip_info ad5620_1250_chip_info = {
-	.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 2),
-	.int_vref_mv = 1250,
-	.write = ad5446_write,
-};
-
-static const struct ad5446_chip_info ad5640_2500_chip_info = {
-	.channel = AD5446_CHANNEL_POWERDOWN(14, 16, 0),
-	.int_vref_mv = 2500,
-	.write = ad5446_write,
-};
-
-static const struct ad5446_chip_info ad5640_1250_chip_info = {
-	.channel = AD5446_CHANNEL_POWERDOWN(14, 16, 0),
-	.int_vref_mv = 1250,
-	.write = ad5446_write,
-};
-
-static const struct ad5446_chip_info ad5660_2500_chip_info = {
-	.channel = AD5446_CHANNEL_POWERDOWN(16, 16, 0),
-	.int_vref_mv = 2500,
-	.write = ad5660_write,
-};
-
-static const struct ad5446_chip_info ad5660_1250_chip_info = {
-	.channel = AD5446_CHANNEL_POWERDOWN(16, 16, 0),
-	.int_vref_mv = 1250,
-	.write = ad5660_write,
-};
-
-static const struct ad5446_chip_info ad5662_chip_info = {
-	.channel = AD5446_CHANNEL_POWERDOWN(16, 16, 0),
-	.write = ad5660_write,
-};
-
-static const struct spi_device_id ad5446_spi_ids[] = {
-	{"ad5300", (kernel_ulong_t)&ad5300_chip_info},
-	{"ad5310", (kernel_ulong_t)&ad5310_chip_info},
-	{"ad5320", (kernel_ulong_t)&ad5320_chip_info},
-	{"ad5444", (kernel_ulong_t)&ad5444_chip_info},
-	{"ad5446", (kernel_ulong_t)&ad5446_chip_info},
-	{"ad5450", (kernel_ulong_t)&ad5450_chip_info},
-	{"ad5451", (kernel_ulong_t)&ad5451_chip_info},
-	{"ad5452", (kernel_ulong_t)&ad5444_chip_info}, /* ad5452 is compatible to the ad5444 */
-	{"ad5453", (kernel_ulong_t)&ad5446_chip_info}, /* ad5453 is compatible to the ad5446 */
-	{"ad5512a", (kernel_ulong_t)&ad5512a_chip_info},
-	{"ad5541a", (kernel_ulong_t)&ad5541a_chip_info},
-	{"ad5542a", (kernel_ulong_t)&ad5541a_chip_info}, /* ad5541a and ad5542a are compatible */
-	{"ad5543", (kernel_ulong_t)&ad5541a_chip_info}, /* ad5541a and ad5543 are compatible */
-	{"ad5553", (kernel_ulong_t)&ad5553_chip_info},
-	{"ad5600", (kernel_ulong_t)&ad5600_chip_info},
-	{"ad5601", (kernel_ulong_t)&ad5601_chip_info},
-	{"ad5611", (kernel_ulong_t)&ad5611_chip_info},
-	{"ad5621", (kernel_ulong_t)&ad5621_chip_info},
-	{"ad5641", (kernel_ulong_t)&ad5641_chip_info},
-	{"ad5620-2500", (kernel_ulong_t)&ad5620_2500_chip_info}, /* AD5620/40/60: */
-	/* part numbers may look differently */
-	{"ad5620-1250", (kernel_ulong_t)&ad5620_1250_chip_info},
-	{"ad5640-2500", (kernel_ulong_t)&ad5640_2500_chip_info},
-	{"ad5640-1250", (kernel_ulong_t)&ad5640_1250_chip_info},
-	{"ad5660-2500", (kernel_ulong_t)&ad5660_2500_chip_info},
-	{"ad5660-1250", (kernel_ulong_t)&ad5660_1250_chip_info},
-	{"ad5662", (kernel_ulong_t)&ad5662_chip_info},
-	{"dac081s101", (kernel_ulong_t)&ad5300_chip_info}, /* compatible Texas Instruments chips */
-	{"dac101s101", (kernel_ulong_t)&ad5310_chip_info},
-	{"dac121s101", (kernel_ulong_t)&ad5320_chip_info},
-	{"dac7512", (kernel_ulong_t)&ad5320_chip_info},
-	{ }
-};
-MODULE_DEVICE_TABLE(spi, ad5446_spi_ids);
-
-static const struct of_device_id ad5446_of_ids[] = {
-	{ .compatible = "adi,ad5300", .data = &ad5300_chip_info },
-	{ .compatible = "adi,ad5310", .data = &ad5310_chip_info },
-	{ .compatible = "adi,ad5320", .data = &ad5320_chip_info },
-	{ .compatible = "adi,ad5444", .data = &ad5444_chip_info },
-	{ .compatible = "adi,ad5446", .data = &ad5446_chip_info },
-	{ .compatible = "adi,ad5450", .data = &ad5450_chip_info },
-	{ .compatible = "adi,ad5451", .data = &ad5451_chip_info },
-	{ .compatible = "adi,ad5452", .data = &ad5444_chip_info },
-	{ .compatible = "adi,ad5453", .data = &ad5446_chip_info },
-	{ .compatible = "adi,ad5512a", .data = &ad5512a_chip_info },
-	{ .compatible = "adi,ad5541a", .data = &ad5541a_chip_info },
-	{ .compatible = "adi,ad5542a", .data = &ad5541a_chip_info },
-	{ .compatible = "adi,ad5543", .data = &ad5541a_chip_info },
-	{ .compatible = "adi,ad5553", .data = &ad5553_chip_info },
-	{ .compatible = "adi,ad5600", .data = &ad5600_chip_info },
-	{ .compatible = "adi,ad5601", .data = &ad5601_chip_info },
-	{ .compatible = "adi,ad5611", .data = &ad5611_chip_info },
-	{ .compatible = "adi,ad5621", .data = &ad5621_chip_info },
-	{ .compatible = "adi,ad5641", .data = &ad5641_chip_info },
-	{ .compatible = "adi,ad5620-2500", .data = &ad5620_2500_chip_info },
-	{ .compatible = "adi,ad5620-1250", .data = &ad5620_1250_chip_info },
-	{ .compatible = "adi,ad5640-2500", .data = &ad5640_2500_chip_info },
-	{ .compatible = "adi,ad5640-1250", .data = &ad5640_1250_chip_info },
-	{ .compatible = "adi,ad5660-2500", .data = &ad5660_2500_chip_info },
-	{ .compatible = "adi,ad5660-1250", .data = &ad5660_1250_chip_info },
-	{ .compatible = "adi,ad5662", .data = &ad5662_chip_info },
-	{ .compatible = "ti,dac081s101", .data = &ad5300_chip_info },
-	{ .compatible = "ti,dac101s101", .data = &ad5310_chip_info },
-	{ .compatible = "ti,dac121s101", .data = &ad5320_chip_info },
-	{ .compatible = "ti,dac7512", .data = &ad5320_chip_info },
-	{ }
-};
-MODULE_DEVICE_TABLE(of, ad5446_of_ids);
-
-static int ad5446_spi_probe(struct spi_device *spi)
-{
-	const struct spi_device_id *id = spi_get_device_id(spi);
-	const struct ad5446_chip_info *chip_info;
-
-	chip_info = spi_get_device_match_data(spi);
-	if (!chip_info)
-		return -ENODEV;
-
-	return ad5446_probe(&spi->dev, id->name, chip_info);
-}
-
-static struct spi_driver ad5446_spi_driver = {
-	.driver = {
-		.name	= "ad5446",
-		.of_match_table = ad5446_of_ids,
-	},
-	.probe		= ad5446_spi_probe,
-	.id_table	= ad5446_spi_ids,
-};
-
-static int __init ad5446_spi_register_driver(void)
-{
-	return spi_register_driver(&ad5446_spi_driver);
-}
-
-static void ad5446_spi_unregister_driver(void)
-{
-	spi_unregister_driver(&ad5446_spi_driver);
-}
-
-#else
-
-static inline int ad5446_spi_register_driver(void) { return 0; }
-static inline void ad5446_spi_unregister_driver(void) { }
-
-#endif
-
-#if IS_ENABLED(CONFIG_I2C)
-
-static int ad5622_write(struct ad5446_state *st, unsigned val)
-{
-	struct i2c_client *client = to_i2c_client(st->dev);
-	st->d16 = cpu_to_be16(val);
-	int ret;
-
-	ret = i2c_master_send_dmasafe(client, (char *)&st->d16, sizeof(st->d16));
-	if (ret < 0)
-		return ret;
-	if (ret != sizeof(st->d16))
-		return -EIO;
-
-	return 0;
-}
-
-/*
- * ad5446_supported_i2c_device_ids:
- * The AD5620/40/60 parts are available in different fixed internal reference
- * voltage options. The actual part numbers may look differently
- * (and a bit cryptic), however this style is used to make clear which
- * parts are supported here.
- */
-
-static const struct ad5446_chip_info ad5602_chip_info = {
-	.channel = AD5446_CHANNEL_POWERDOWN(8, 16, 4),
-	.write = ad5622_write,
-};
-
-static const struct ad5446_chip_info ad5612_chip_info = {
-	.channel = AD5446_CHANNEL_POWERDOWN(10, 16, 2),
-	.write = ad5622_write,
-};
-
-static const struct ad5446_chip_info ad5622_chip_info = {
-	.channel = AD5446_CHANNEL_POWERDOWN(12, 16, 0),
-	.write = ad5622_write,
-};
-
-static int ad5446_i2c_probe(struct i2c_client *i2c)
-{
-	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
-	const struct ad5446_chip_info *chip_info;
-
-	chip_info = i2c_get_match_data(i2c);
-	if (!chip_info)
-		return -ENODEV;
-
-	return ad5446_probe(&i2c->dev, id->name, chip_info);
-}
-
-static const struct i2c_device_id ad5446_i2c_ids[] = {
-	{"ad5301", (kernel_ulong_t)&ad5602_chip_info},
-	{"ad5311", (kernel_ulong_t)&ad5612_chip_info},
-	{"ad5321", (kernel_ulong_t)&ad5622_chip_info},
-	{"ad5602", (kernel_ulong_t)&ad5602_chip_info},
-	{"ad5612", (kernel_ulong_t)&ad5612_chip_info},
-	{"ad5622", (kernel_ulong_t)&ad5622_chip_info},
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, ad5446_i2c_ids);
-
-static const struct of_device_id ad5446_i2c_of_ids[] = {
-	{ .compatible = "adi,ad5301", .data = &ad5602_chip_info },
-	{ .compatible = "adi,ad5311", .data = &ad5612_chip_info },
-	{ .compatible = "adi,ad5321", .data = &ad5622_chip_info },
-	{ .compatible = "adi,ad5602", .data = &ad5602_chip_info },
-	{ .compatible = "adi,ad5612", .data = &ad5612_chip_info },
-	{ .compatible = "adi,ad5622", .data = &ad5622_chip_info },
-	{ }
-};
-MODULE_DEVICE_TABLE(OF, ad5446_i2c_of_ids);
-
-static struct i2c_driver ad5446_i2c_driver = {
-	.driver = {
-		   .name = "ad5446",
-		   .of_match_table = ad5446_i2c_of_ids,
-	},
-	.probe = ad5446_i2c_probe,
-	.id_table = ad5446_i2c_ids,
-};
-
-static int __init ad5446_i2c_register_driver(void)
-{
-	return i2c_add_driver(&ad5446_i2c_driver);
-}
-
-static void __exit ad5446_i2c_unregister_driver(void)
-{
-	i2c_del_driver(&ad5446_i2c_driver);
-}
-
-#else
-
-static inline int ad5446_i2c_register_driver(void) { return 0; }
-static inline void ad5446_i2c_unregister_driver(void) { }
-
-#endif
-
-static int __init ad5446_init(void)
-{
-	int ret;
-
-	ret = ad5446_spi_register_driver();
-	if (ret)
-		return ret;
-
-	ret = ad5446_i2c_register_driver();
-	if (ret) {
-		ad5446_spi_unregister_driver();
-		return ret;
-	}
-
-	return 0;
-}
-module_init(ad5446_init);
-
-static void __exit ad5446_exit(void)
-{
-	ad5446_i2c_unregister_driver();
-	ad5446_spi_unregister_driver();
-}
-module_exit(ad5446_exit);
-
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
-MODULE_DESCRIPTION("Analog Devices AD5444/AD5446 DAC");
+MODULE_DESCRIPTION("Analog Devices CORE AD5444/AD5446 DAC");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/dac/ad5446.h b/drivers/iio/dac/ad5446.h
new file mode 100644
index 000000000000..ee3d2c7d1764
--- /dev/null
+++ b/drivers/iio/dac/ad5446.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_AD5446_H
+#define _LINUX_AD5446_H
+
+#include <linux/bits.h>
+#include <linux/iio/iio.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+
+struct device;
+
+extern const struct iio_chan_spec_ext_info ad5446_ext_info_powerdown[];
+
+#define _AD5446_CHANNEL(bits, storage, _shift, ext) { \
+	.type = IIO_VOLTAGE, \
+	.indexed = 1, \
+	.output = 1, \
+	.channel = 0, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+	.scan_type = { \
+		.sign = 'u', \
+		.realbits = (bits), \
+		.storagebits = (storage), \
+		.shift = (_shift), \
+		}, \
+	.ext_info = (ext), \
+}
+
+#define AD5446_CHANNEL(bits, storage, shift) \
+	_AD5446_CHANNEL(bits, storage, shift, NULL)
+
+#define AD5446_CHANNEL_POWERDOWN(bits, storage, shift) \
+	_AD5446_CHANNEL(bits, storage, shift, ad5446_ext_info_powerdown)
+
+/**
+ * struct ad5446_state - driver instance specific data
+ * @dev:		this device
+ * @chip_info:		chip model specific constants, available modes etc
+ * @vref_mv:		actual reference voltage used
+ * @cached_val:		store/retrieve values during power down
+ * @pwr_down_mode:	power down mode (1k, 100k or tristate)
+ * @pwr_down:		true if the device is in power down
+ * @lock:		lock to protect the data buffer during write ops
+ */
+struct ad5446_state {
+	struct device *dev;
+	const struct ad5446_chip_info *chip_info;
+	unsigned short vref_mv;
+	unsigned int cached_val;
+	unsigned int pwr_down_mode;
+	unsigned int pwr_down;
+	/* mutex to protect device shared data */
+	struct mutex lock;
+	union {
+		__be16 d16;
+		u8 d24[3];
+	} __aligned(IIO_DMA_MINALIGN);
+};
+
+/**
+ * struct ad5446_chip_info - chip specific information
+ * @channel:		channel spec for the DAC
+ * @int_vref_mv:	AD5620/40/60: the internal reference voltage
+ * @write:		chip specific helper function to write to the register
+ */
+struct ad5446_chip_info {
+	struct iio_chan_spec channel;
+	u16 int_vref_mv;
+	int (*write)(struct ad5446_state *st, unsigned int val);
+};
+
+int ad5446_probe(struct device *dev, const char *name,
+		 const struct ad5446_chip_info *chip_info);
+
+#endif

-- 
2.51.0



