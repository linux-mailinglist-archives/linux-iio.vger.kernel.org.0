Return-Path: <linux-iio+bounces-8949-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC3C967C3E
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 22:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CFEF1F2166A
	for <lists+linux-iio@lfdr.de>; Sun,  1 Sep 2024 20:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBAC13AD18;
	Sun,  1 Sep 2024 20:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpuhVWpE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DB113AA27;
	Sun,  1 Sep 2024 20:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725224079; cv=none; b=iMAYo796ErXZ/cT33h34mK0DeLE6KKdhjZHmCOVKDW+SnGlzQjo4DCA66S8HXSbhWp72hJceK1DHdpddIdekcOHaSxJJJ171l3iatjb8UadhWYWVL3alINME4R9sYC+RSqDvpOTKZUDPEZifApBuZPsW4TwR6fJCF2sDiJIzeHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725224079; c=relaxed/simple;
	bh=fgpz/K/du0AWMxjxt4lD0Kuz3y751SnPLrya5tlsQT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnQCJfNGoeIIBsnu9LjVDHltEHu9s1L5BC7rRzK9EHcvvNRgEIZL0oM6Y97lqFgmLdPBTVWfjWiHuOlU18sOZZXY3hM/LlCj5RP8t9JrmAMUZoRdm9R7Vo7xUv6HpS6YLCQCbz1fLg4zAhRhmH5Vz+fms8wqbCf35hAMJ8xXjaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpuhVWpE; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-45685a3b1d8so29263131cf.1;
        Sun, 01 Sep 2024 13:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725224076; x=1725828876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8d5ZmyufjPSGkAltJkR0m1wXBlz58+lzT0sISs+lQSg=;
        b=WpuhVWpEfEgcUWtyaATBs4TOXIPsnzUctZDzBezQTC21frnv8o1U+mBSCTwOJKR6gX
         lcCNRG62CKjgilNC2iYJDalVfCy+TVM/WX2xLWfY4j+W9KzUp3dNw1FRpECtmknbs0yH
         bBkpV4C/nieBwybBrDM2mB8N01QN+Wo9EbFVf5t63cTU3h4xZsdifwxvHcwknrQM5Lib
         EGMXJXK5lrP5lxWp3Bhsy1TE0l+ZdkKnFO9If5mWBaSQPpHF+cR5URiHMyseUYHwDubw
         Y1Mi0sZ2EqC9ydZz3xxHGtSycBz/mHzGxYINg8UwT6nbF7TlQ5NXcbT0jOGrymX8yVRB
         uP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725224076; x=1725828876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8d5ZmyufjPSGkAltJkR0m1wXBlz58+lzT0sISs+lQSg=;
        b=Ag/qOMoPLRne7whZScCbELgcIqxdJB2FpiLXxf9zEjhSdkxoYy/1bUTeSXWP39iAIQ
         iPXkeC/EWrSa0gfZWxcE4U9GooD3HP3b7FATQqBF67qy0+RySoGlrEL2UPfnzhEBaOTo
         OfuzRkb61z82KE65FAXCOoOJv6Zi9AHi/My6BXQKs0qQXSsrZJ0pDiS/8mNFzOjaZ4UJ
         VDhPiePe67fRN51VRrP27Df7A3ixTrw18epAHlOJSn+cuXMzmI92e0yX58mODOcKOPJy
         jy7b+OzAPs2Gbi6NWNowkHgKu8sM9HedJkN7sG+xeED90D+b/dhxUC4zL8KDCWLL19pe
         vaUA==
X-Forwarded-Encrypted: i=1; AJvYcCULXDAVybb6CjHEefqEFS4PMZ0o1eDvRlcwaJQjoQVDPQ9VzRhsaXKAlVdW0Ok0q4rJf/N1qJQEw8+xMtKO@vger.kernel.org, AJvYcCWNriGqfCAS7GBYVHipVO3DFVF2qeB9O5CB6SQT5yccVMTQEX2dlhn6hzQiNEOoLN16TdMF1vw3zULs@vger.kernel.org, AJvYcCWy9wAs93ufeuU9ItB36l3UhIKd1oGaqCGWHzaijfwlz1lUdzjmE1+xNRNnH6+Q+FxVCY+8WIaLyJ5U@vger.kernel.org
X-Gm-Message-State: AOJu0YwiATzBg2AJN8paIPvONQVrKSqnS5SpenGp7UU02bkZs1XhtUYG
	O6ND5+fzOVi6DROfhk6n3SgwZ2Jf2YGN9M2o2/6G5OZMULfJWNE4
X-Google-Smtp-Source: AGHT+IGe+m0ngwWa/9LuNh6QGcoShwtMapdjKC0IK9dQeXveuCulr5ShJkYBeupLe57znXjtFEPKgg==
X-Received: by 2002:a05:622a:4ac6:b0:457:c9fe:8eed with SMTP id d75a77b69052e-457c9fe8ffemr60908421cf.29.1725224076241;
        Sun, 01 Sep 2024 13:54:36 -0700 (PDT)
Received: from localhost.localdomain (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682c9a148sm34148231cf.32.2024.09.01.13.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 13:54:35 -0700 (PDT)
From: Alex Lanzano <lanzano.alex@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Ramona Gradinariu <ramona.bolboaca13@gmail.com>,
	Nuno Sa <nuno.sa@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: imu: Add i2c driver for bmi270 imu
Date: Sun,  1 Sep 2024 16:53:24 -0400
Message-ID: <20240901205354.3201261-3-lanzano.alex@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901205354.3201261-1-lanzano.alex@gmail.com>
References: <20240901205354.3201261-1-lanzano.alex@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add initial i2c support for the Bosch BMI270 6-axis IMU.
Provides raw read access to acceleration and angle velocity measurements
via iio channels. Device configuration requires firmware provided by
Bosch and is requested and load from userspace.

Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>
---
 MAINTAINERS                          |   7 +
 drivers/iio/imu/Kconfig              |   1 +
 drivers/iio/imu/Makefile             |   1 +
 drivers/iio/imu/bmi270/Kconfig       |  22 ++
 drivers/iio/imu/bmi270/Makefile      |   6 +
 drivers/iio/imu/bmi270/bmi270.h      |  18 ++
 drivers/iio/imu/bmi270/bmi270_core.c | 322 +++++++++++++++++++++++++++
 drivers/iio/imu/bmi270/bmi270_i2c.c  |  56 +++++
 8 files changed, 433 insertions(+)
 create mode 100644 drivers/iio/imu/bmi270/Kconfig
 create mode 100644 drivers/iio/imu/bmi270/Makefile
 create mode 100644 drivers/iio/imu/bmi270/bmi270.h
 create mode 100644 drivers/iio/imu/bmi270/bmi270_core.c
 create mode 100644 drivers/iio/imu/bmi270/bmi270_i2c.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 417c6751c0dc..3d4a6f52bae6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3966,6 +3966,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
 F:	drivers/iio/accel/bma400*
 
+BOSCH SENSORTEC BMI270 IMU IIO DRIVER
+M:	Alex Lanzano <lanzano.alex@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/imu/bosch,bmi270.yaml
+F:	drivers/iio/imu/bmi270/
+
 BOSCH SENSORTEC BMI323 IMU IIO DRIVER
 M:	Jagath Jog J <jagathjog1996@gmail.com>
 L:	linux-iio@vger.kernel.org
diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
index 782fb80e44c2..489dd898830b 100644
--- a/drivers/iio/imu/Kconfig
+++ b/drivers/iio/imu/Kconfig
@@ -53,6 +53,7 @@ config ADIS16480
 	  ADIS16485, ADIS16488 inertial sensors.
 
 source "drivers/iio/imu/bmi160/Kconfig"
+source "drivers/iio/imu/bmi270/Kconfig"
 source "drivers/iio/imu/bmi323/Kconfig"
 source "drivers/iio/imu/bno055/Kconfig"
 
diff --git a/drivers/iio/imu/Makefile b/drivers/iio/imu/Makefile
index 7e2d7d5c3b7b..79f83ea6f644 100644
--- a/drivers/iio/imu/Makefile
+++ b/drivers/iio/imu/Makefile
@@ -15,6 +15,7 @@ adis_lib-$(CONFIG_IIO_ADIS_LIB_BUFFER) += adis_buffer.o
 obj-$(CONFIG_IIO_ADIS_LIB) += adis_lib.o
 
 obj-y += bmi160/
+obj-y += bmi270/
 obj-y += bmi323/
 obj-y += bno055/
 
diff --git a/drivers/iio/imu/bmi270/Kconfig b/drivers/iio/imu/bmi270/Kconfig
new file mode 100644
index 000000000000..05e13c67db57
--- /dev/null
+++ b/drivers/iio/imu/bmi270/Kconfig
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# BMI270 IMU driver
+#
+
+config BMI270
+	tristate
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+
+config BMI270_I2C
+	tristate "Bosch BMI270 I2C driver"
+	depends on I2C
+	select BMI270
+	select REGMAP_I2C
+	help
+	  Enable support for the Bosch BMI270 6-Axis IMU connected to I2C
+	  interface.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called bmi270_i2c.
+
diff --git a/drivers/iio/imu/bmi270/Makefile b/drivers/iio/imu/bmi270/Makefile
new file mode 100644
index 000000000000..ab4acaaee6d2
--- /dev/null
+++ b/drivers/iio/imu/bmi270/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for Bosch BMI270 IMU
+#
+obj-$(CONFIG_BMI270) += bmi270_core.o
+obj-$(CONFIG_BMI270_I2C) += bmi270_i2c.o
diff --git a/drivers/iio/imu/bmi270/bmi270.h b/drivers/iio/imu/bmi270/bmi270.h
new file mode 100644
index 000000000000..52e806529748
--- /dev/null
+++ b/drivers/iio/imu/bmi270/bmi270.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef BMI270_H_
+#define BMI270_H_
+
+#include <linux/iio/iio.h>
+
+struct bmi270_data {
+	struct device *dev;
+	struct regmap *regmap;
+};
+
+extern const struct regmap_config bmi270_regmap_config;
+
+int bmi270_core_probe(struct device *dev, struct regmap *regmap,
+		      const char *name, bool use_spi);
+
+#endif  /* BMI270_H_ */
diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
new file mode 100644
index 000000000000..f8c53e8e35a2
--- /dev/null
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -0,0 +1,322 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+#include <linux/firmware.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include "bmi270.h"
+
+#define BMI270_CHIP_ID 0x24
+#define BMI270_INIT_DATA_FILE "bmi270-init-data.fw"
+
+enum bmi270_registers {
+	BMI270_REG_CHIP_ID = 0x00,
+	BMI270_REG_INTERNAL_STATUS = 0x21,
+	BMI270_REG_ACC_CONF = 0x40,
+	BMI270_REG_GYR_CONF = 0x42,
+	BMI270_REG_INIT_CTRL = 0x59,
+	BMI270_REG_INIT_DATA = 0x5e,
+	BMI270_REG_PWR_CONF = 0x7c,
+	BMI270_REG_PWR_CTRL = 0x7d,
+};
+
+enum bmi270_scan {
+	BMI270_SCAN_ACCEL_X,
+	BMI270_SCAN_ACCEL_Y,
+	BMI270_SCAN_ACCEL_Z,
+	BMI270_SCAN_GYRO_X,
+	BMI270_SCAN_GYRO_Y,
+	BMI270_SCAN_GYRO_Z,
+};
+
+const struct regmap_config bmi270_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+EXPORT_SYMBOL_NS_GPL(bmi270_regmap_config, IIO_BMI270);
+
+static int bmi270_get_data(struct bmi270_data *bmi270_device,
+			   int chan_type, int axis, int *val)
+{
+	__le16 sample;
+	int reg;
+
+	switch (chan_type) {
+	case IIO_ACCEL:
+		reg = 0xc + (axis - IIO_MOD_X) * sizeof(sample);
+		break;
+	case IIO_ANGL_VEL:
+		reg = 0x12 + (axis - IIO_MOD_X) * sizeof(sample);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_bulk_read(bmi270_device->regmap, reg, &sample, sizeof(sample));
+	*val = sign_extend32(le16_to_cpu(sample), 15);
+
+	return 0;
+}
+
+static int bmi270_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct bmi270_data *bmi270_device = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		bmi270_get_data(bmi270_device, chan->type, chan->channel2, val);
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct iio_info bmi270_info = {
+	.read_raw = bmi270_read_raw,
+};
+
+static const struct iio_chan_spec bmi270_channels[] = {
+	{
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_X,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
+			BIT(IIO_CHAN_INFO_FREQUENCY),
+		.scan_index = BMI270_SCAN_ACCEL_X,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
+	},
+	{
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_Y,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
+			BIT(IIO_CHAN_INFO_FREQUENCY),
+		.scan_index = BMI270_SCAN_ACCEL_Y,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
+	},
+	{
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_Z,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
+			BIT(IIO_CHAN_INFO_FREQUENCY),
+		.scan_index = BMI270_SCAN_ACCEL_Z,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
+	},
+	{
+		.type = IIO_ANGL_VEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_X,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
+			BIT(IIO_CHAN_INFO_FREQUENCY),
+		.scan_index = BMI270_SCAN_GYRO_X,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
+	},
+	{
+		.type = IIO_ANGL_VEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_Y,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
+			BIT(IIO_CHAN_INFO_FREQUENCY),
+		.scan_index = BMI270_SCAN_GYRO_Y,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
+
+	},
+	{
+		.type = IIO_ANGL_VEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_Z,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
+			BIT(IIO_CHAN_INFO_FREQUENCY),
+		.scan_index = BMI270_SCAN_GYRO_Z,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
+	},
+};
+
+static int bmi270_validate_chip_id(struct bmi270_data *bmi270_device)
+{
+	int chip_id;
+	int ret;
+	struct device *dev = bmi270_device->dev;
+	struct regmap *regmap = bmi270_device->regmap;
+
+	ret = regmap_read(regmap, BMI270_REG_CHIP_ID, &chip_id);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read chip id");
+
+	if (chip_id != BMI270_CHIP_ID)
+		return dev_err_probe(dev, -ENODEV, "Invalid chip id");
+
+	return 0;
+}
+
+static int bmi270_write_init_data(struct bmi270_data *bmi270_device)
+{
+	int pwr_conf = 0;
+	int ret;
+	int status = 0;
+	const struct firmware *init_data;
+	struct device *dev = bmi270_device->dev;
+	struct regmap *regmap = bmi270_device->regmap;
+
+	ret = regmap_read(regmap, BMI270_REG_PWR_CONF, &pwr_conf);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read power configuration");
+
+	pwr_conf &=  0xfffffffe;
+	ret = regmap_write(regmap, BMI270_REG_PWR_CONF, pwr_conf);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to write power configuration");
+
+	usleep_range(450, 1000);
+
+	ret = regmap_write(regmap, BMI270_REG_INIT_CTRL, 0x0);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to prepare device to load init data");
+
+	ret = request_firmware(&init_data, BMI270_INIT_DATA_FILE, dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to load init data file");
+
+	ret = regmap_bulk_write(regmap, BMI270_REG_INIT_DATA,
+				init_data->data, init_data->size);
+	release_firmware(init_data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to write init data");
+
+	ret = regmap_write(regmap, BMI270_REG_INIT_CTRL, 0x1);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to stop device initialization");
+
+	usleep_range(20000, 55000);
+
+	ret = regmap_read(regmap, BMI270_REG_INTERNAL_STATUS, &status);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read internal status");
+
+	if (status != 1)
+		return dev_err_probe(dev, -ENODEV, "Device failed to initialize");
+
+	return 0;
+}
+
+static int bmi270_configure_imu(struct bmi270_data *bmi270_device)
+{
+	int ret;
+	struct device *dev = bmi270_device->dev;
+	struct regmap *regmap = bmi270_device->regmap;
+
+	ret = regmap_write(regmap, BMI270_REG_PWR_CTRL, 0x0e);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable accelerometer and gyroscope");
+
+	ret = regmap_write(regmap, BMI270_REG_ACC_CONF, 0xa8);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to configure accelerometer");
+
+	ret = regmap_write(regmap, BMI270_REG_GYR_CONF, 0xa9);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to configure gyroscope");
+
+	ret = regmap_write(regmap, BMI270_REG_PWR_CONF, 0x02);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set power configuration");
+
+	return 0;
+}
+
+static int bmi270_chip_init(struct bmi270_data *bmi270_device)
+{
+	int ret;
+
+	ret = bmi270_validate_chip_id(bmi270_device);
+	if (ret)
+		return ret;
+
+	ret = bmi270_write_init_data(bmi270_device);
+	if (ret)
+		return ret;
+
+	ret = bmi270_configure_imu(bmi270_device);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+int bmi270_core_probe(struct device *dev, struct regmap *regmap,
+		      const char *name, bool use_spi)
+{
+	int ret;
+	struct bmi270_data *bmi270_device;
+	struct iio_dev *indio_dev;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(struct bmi270_data *));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	bmi270_device = iio_priv(indio_dev);
+	bmi270_device->dev = dev;
+	bmi270_device->regmap = regmap;
+
+	dev_set_drvdata(dev, indio_dev);
+
+	ret = bmi270_chip_init(bmi270_device);
+	if (ret)
+		return ret;
+
+	indio_dev->channels = bmi270_channels;
+	indio_dev->num_channels = ARRAY_SIZE(bmi270_channels);
+	indio_dev->name = name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &bmi270_info;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+EXPORT_SYMBOL_NS_GPL(bmi270_core_probe, IIO_BMI270);
+
+MODULE_AUTHOR("Alex Lanzano");
+MODULE_DESCRIPTION("BMI270 driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
new file mode 100644
index 000000000000..2a18c3af92d2
--- /dev/null
+++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include "bmi270.h"
+
+static int bmi270_i2c_probe(struct i2c_client *client)
+{
+	const char *name;
+	struct regmap *regmap;
+	struct device *dev = &client->dev;
+	const struct i2c_device_id *id;
+
+	regmap = devm_regmap_init_i2c(client, &bmi270_regmap_config);
+	if (IS_ERR(regmap)) {
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to init i2c regmap");
+	}
+
+	id = i2c_client_get_device_id(client);
+	if (id)
+		name = id->name;
+	else
+		name = dev_name(dev);
+
+	return bmi270_core_probe(dev, regmap, name, false);
+}
+
+static const struct i2c_device_id bmi270_i2c_id[] = {
+	{"bmi270", 0},
+	{}
+};
+
+static const struct of_device_id bmi270_of_match[] = {
+	{.compatible = "bosch,bmi270"},
+	{},
+};
+
+static struct i2c_driver bmi270_i2c_driver = {
+	.driver = {
+		.name = "bmi270_i2c",
+		.of_match_table = bmi270_of_match,
+	},
+	.probe = bmi270_i2c_probe,
+	.id_table = bmi270_i2c_id,
+};
+module_i2c_driver(bmi270_i2c_driver);
+
+MODULE_AUTHOR("Alex Lanzano");
+MODULE_DESCRIPTION("BMI270 driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_BMI270);
-- 
2.46.0


