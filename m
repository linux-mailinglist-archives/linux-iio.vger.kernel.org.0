Return-Path: <linux-iio+bounces-9994-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2066198CB8D
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 05:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0F71C21DAF
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2024 03:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F247101E6;
	Wed,  2 Oct 2024 03:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFbTKjJy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30A618049;
	Wed,  2 Oct 2024 03:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727840206; cv=none; b=Mgx9kzKzHEp1gkp23vuLyC0xMCwVmiW40D9vVEgloEPClLp93y8Ty6nnXjuJMVZZf7+09JoObMyrvXp0imRpimOjO7VQzfBTaWY6VmUxoWU9cLqI4VAdanzRGKUz8mrKkI2Ei7bGV3zKWXiUPHz5zxCd/jdISOw4+Dszd1hsq2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727840206; c=relaxed/simple;
	bh=L4NzGFQcO6PX+KJV0Ui6Rmjl8d+ZZBqDVW7zHm4NBwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FdrBd+gibXa5INdwy1q5cKAvVtfljh9TNgb7187S6bLe2NRAVKPblntKROx1DyiF/MtJ/iH24YPiahx9m0cMYl/M66RMJy4oxhBm2ShR6phFePuAYmphG50v2sDJQ5zkilMSNqzGk920sU8hNITA70vDKuiaEMtl/XwshsIWeFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFbTKjJy; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cb29ff33c5so57336626d6.2;
        Tue, 01 Oct 2024 20:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727840203; x=1728445003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bV3u9CcluYyYwNmKPnJnslG0Jl3Fd+oK5lR5WfckDS8=;
        b=HFbTKjJyaFpaRIFtBz5Ufrnx+xeEQhzXtlPjUgHcdm3KxD6uC6yqX0TmOcLfnGiu48
         /ju9RwTuJHLymYnMF1AOd07kbs2wF3EVbF24ZwEj9p+n04pO4uSqtSRz2P2NaevWEhnX
         f/O5krVxl3AeMMsqFcDC++aHXmesgciEDlcg87TPGPhf60MGHo+sI4TNslAg3S/ZD6ci
         v2lG15HsyObhqEz+dtBb7+twau3euFqSYu8EsAaDCN4FfNWwR6xmVPkpQjKLSKc252y9
         UYLqapdTqKuOIMaVsS8KZe+UqYlUfuL1Vlwi3VyxNiVHRPte3FTIutES+f5EXQX6uRjP
         Dj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727840203; x=1728445003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bV3u9CcluYyYwNmKPnJnslG0Jl3Fd+oK5lR5WfckDS8=;
        b=BaxP0qqaxmIT+RJ+vUoFaz14gJJhg+thmxaZbA8FX2nRkF+vMM1FJ/WlQepe5DcbQ9
         zTYtoZ+LONAwdyc1kDTVjRC5pJSHepW+RW4oW+fX3VlfGZTBv2jtLsOyt9T1vawESQUK
         V5/MUJbs4CqNKhIAOv9hKkHDr9aZtrGHfyWwNY9V5UR65qBM2UnR1hM8ZURVLuyvgq85
         4bdLusYa6svnHvw7iIHZjUv9AN11On6rdR2DM6G1wMJf1lMjeBRMxbyY2oKLtuXU4SF6
         Cjbos9VGF0Ie3UfAXdJUn+Fh6v6eedZsSIFL8CCBkIPCHieLPuCCSCqywDklPcVrH50+
         heVw==
X-Forwarded-Encrypted: i=1; AJvYcCXajHhktKlDWwfi4KAZOHpGgFemd73fo0VJKFOmkO6C3hEPgmI1kXxlsiZmNkLQqrhnOhbpBB8Atzo=@vger.kernel.org, AJvYcCXy3DT/tsy4+kIlHla0VqiQGnwLCwG5BTSk27+uZiCoXro1M1nmaMkWvR/NQIa6XM9S3uNiGe3KK3bBJwgN@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4br4HsLbelO/0io+S202cW34uYRsX4Zw2ouPeIxLgp9tmy3A0
	RkpobfLvbG1JSEs4FiiGSKPEbAR5GJtgKbmbElxZ5R2R9ikNQLIn
X-Google-Smtp-Source: AGHT+IHLTLy9CNseakdYC7EkLXEGTVDYpBTWCMMDmkf9orXTFrvpWUQIEIhnTRcR7U8IRZV0WNLuyw==
X-Received: by 2002:a05:6214:5904:b0:6cb:3279:f0ac with SMTP id 6a1803df08f44-6cb819f5f7dmr28859896d6.24.1727840203529;
        Tue, 01 Oct 2024 20:36:43 -0700 (PDT)
Received: from localhost.localdomain (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cb3b66cdddsm56089696d6.88.2024.10.01.20.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 20:36:42 -0700 (PDT)
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 1/1] iio: imu: bmi270: Add spi driver for bmi270 imu
Date: Tue,  1 Oct 2024 23:36:22 -0400
Message-ID: <20241002033628.681812-1-lanzano.alex@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement SPI driver for the Bosch BMI270 6-axis IMU. Provide raw read
write access to acceleration and angle velocity measurements via the SPI
interface on the device.

Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
---

Changes in v2:
- Remove unnecessary __le16 sample variable out of priv data
- Add static to regmap_config structures
- Sort includes in bmi270_spi.c alphabetically
- Rename "context" argument for spi regmap functions to "spi" and use it directly
- Replace spi_write with spi_write_then_read to ensure bounce buffer is
always used

---
 drivers/iio/imu/bmi270/Kconfig       | 12 ++++
 drivers/iio/imu/bmi270/Makefile      |  1 +
 drivers/iio/imu/bmi270/bmi270.h      |  1 +
 drivers/iio/imu/bmi270/bmi270_core.c | 10 +---
 drivers/iio/imu/bmi270/bmi270_i2c.c  |  7 ++-
 drivers/iio/imu/bmi270/bmi270_spi.c  | 86 ++++++++++++++++++++++++++++
 6 files changed, 109 insertions(+), 8 deletions(-)
 create mode 100644 drivers/iio/imu/bmi270/bmi270_spi.c

diff --git a/drivers/iio/imu/bmi270/Kconfig b/drivers/iio/imu/bmi270/Kconfig
index a8db44187286..0ffd29794fda 100644
--- a/drivers/iio/imu/bmi270/Kconfig
+++ b/drivers/iio/imu/bmi270/Kconfig
@@ -18,3 +18,15 @@ config BMI270_I2C
 
 	  This driver can also be built as a module. If so, the module will be
 	  called bmi270_i2c.
+
+config BMI270_SPI
+	tristate "Bosch BMI270 SPI driver"
+	depends on SPI
+	select BMI270
+	select REGMAP_SPI
+	help
+	  Enable support for the Bosch BMI270 6-Axis IMU connected to SPI
+	  interface.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called bmi270_spi.
diff --git a/drivers/iio/imu/bmi270/Makefile b/drivers/iio/imu/bmi270/Makefile
index ab4acaaee6d2..d96c96fc3d83 100644
--- a/drivers/iio/imu/bmi270/Makefile
+++ b/drivers/iio/imu/bmi270/Makefile
@@ -4,3 +4,4 @@
 #
 obj-$(CONFIG_BMI270) += bmi270_core.o
 obj-$(CONFIG_BMI270_I2C) += bmi270_i2c.o
+obj-$(CONFIG_BMI270_SPI) += bmi270_spi.o
diff --git a/drivers/iio/imu/bmi270/bmi270.h b/drivers/iio/imu/bmi270/bmi270.h
index 608b29ea58a3..8ac20ad7ee94 100644
--- a/drivers/iio/imu/bmi270/bmi270.h
+++ b/drivers/iio/imu/bmi270/bmi270.h
@@ -4,6 +4,7 @@
 #define BMI270_H_
 
 #include <linux/regmap.h>
+#include <linux/iio/iio.h>
 
 struct device;
 struct bmi270_data {
diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index 8e45343d6472..638ce2c30d0e 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -66,12 +66,6 @@ enum bmi270_scan {
 	BMI270_SCAN_GYRO_Z,
 };
 
-const struct regmap_config bmi270_regmap_config = {
-	.reg_bits = 8,
-	.val_bits = 8,
-};
-EXPORT_SYMBOL_NS_GPL(bmi270_regmap_config, IIO_BMI270);
-
 static int bmi270_get_data(struct bmi270_data *bmi270_device,
 			   int chan_type, int axis, int *val)
 {
@@ -90,7 +84,9 @@ static int bmi270_get_data(struct bmi270_data *bmi270_device,
 		return -EINVAL;
 	}
 
-	ret = regmap_bulk_read(bmi270_device->regmap, reg, &sample, sizeof(sample));
+	ret = regmap_bulk_read(bmi270_device->regmap, reg,
+			       &sample,
+			       sizeof(sample));
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
index f70dee2d8a64..e9025d22d5cc 100644
--- a/drivers/iio/imu/bmi270/bmi270_i2c.c
+++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
@@ -9,12 +9,17 @@
 
 #include "bmi270.h"
 
+static const struct regmap_config bmi270_i2c_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
 static int bmi270_i2c_probe(struct i2c_client *client)
 {
 	struct regmap *regmap;
 	struct device *dev = &client->dev;
 
-	regmap = devm_regmap_init_i2c(client, &bmi270_regmap_config);
+	regmap = devm_regmap_init_i2c(client, &bmi270_i2c_regmap_config);
 	if (IS_ERR(regmap))
 		return dev_err_probe(dev, PTR_ERR(regmap),
 				     "Failed to init i2c regmap");
diff --git a/drivers/iio/imu/bmi270/bmi270_spi.c b/drivers/iio/imu/bmi270/bmi270_spi.c
new file mode 100644
index 000000000000..34d5ba6273bb
--- /dev/null
+++ b/drivers/iio/imu/bmi270/bmi270_spi.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+#include <linux/iio/iio.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+#include "bmi270.h"
+
+/*
+ * The following two functions are taken from the BMI323 spi driver code.
+ * In section 6.4 of the BMI270 data it specifies that after a read
+ * operation the first data byte from the device is a dummy byte
+ */
+static int bmi270_regmap_spi_read(void *spi, const void *reg_buf,
+				  size_t reg_size, void *val_buf,
+				  size_t val_size)
+{
+	return spi_write_then_read(spi, reg_buf, reg_size, val_buf, val_size);
+}
+
+static int bmi270_regmap_spi_write(void *spi, const void *data,
+				   size_t count)
+{
+	u8 *data_buff = (u8 *)data;
+
+	/*
+	 * Remove the extra pad byte since its only needed for the read
+	 * operation
+	 */
+	data_buff[1] = data_buff[0];
+	return spi_write_then_read(spi, data_buff + 1, count - 1, NULL, 0);
+}
+
+static const struct regmap_bus bmi270_regmap_bus = {
+	.read = bmi270_regmap_spi_read,
+	.write = bmi270_regmap_spi_write,
+};
+
+static const struct regmap_config bmi270_spi_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.pad_bits = 8,
+	.read_flag_mask = BIT(7),
+};
+
+static int bmi270_spi_probe(struct spi_device *spi)
+{
+	struct regmap *regmap;
+	struct device *dev = &spi->dev;
+
+	regmap = devm_regmap_init(dev, &bmi270_regmap_bus, dev,
+				  &bmi270_spi_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to init i2c regmap");
+
+	return bmi270_core_probe(dev, regmap);
+}
+
+static const struct spi_device_id bmi270_spi_id[] = {
+	{ "bmi270" },
+	{ }
+};
+
+static const struct of_device_id bmi270_of_match[] = {
+	{ .compatible = "bosch,bmi270" },
+	{ }
+};
+
+static struct spi_driver bmi270_spi_driver = {
+	.driver = {
+		.name = "bmi270",
+		.of_match_table = bmi270_of_match,
+	},
+	.probe = bmi270_spi_probe,
+	.id_table = bmi270_spi_id,
+};
+module_spi_driver(bmi270_spi_driver);
+
+MODULE_AUTHOR("Alex Lanzano");
+MODULE_DESCRIPTION("BMI270 driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_BMI270);
-- 
2.46.2


