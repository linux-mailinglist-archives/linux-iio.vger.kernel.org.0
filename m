Return-Path: <linux-iio+bounces-9356-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0379B970CBE
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 06:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82C9B1F22698
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 04:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C341ACDE1;
	Mon,  9 Sep 2024 04:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7ffJ+Go"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9FF1662E9;
	Mon,  9 Sep 2024 04:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725856416; cv=none; b=K6KCdkMjc6zA7CnKSVWJ1ukrW0ckr+tx2tf1f2oOyVC3rxKDPkiAR7MPHOZI4BOLTJmaTxQGLyGOTzcgj5eCXGc1AdjrYsK1fa/ES5/TFHdXcRcSQllxQzHipL+aQ7c+4bEyv4UFdkOjkqxOrTXCCsrkNtIYHtg04aBOxDKeXKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725856416; c=relaxed/simple;
	bh=Itm99mEbsbAiDsQ/eF3isid7F4AVJBRXT1nqKZg3qbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RUIFOesfq/fF5oqQrN6rySZy/IOAAB7T0M8sS7tHHee6o8rN5tgMngVRTpRGLHl54VI7ZX4UABL2MhzgXOSEpNhy70w7sy9fLNXkmp3igpjwQSMryrb/Qn0rD+KgjqhRfLNH/Z1ZkLf9/mRsobE1ltld3mUcYxyPf1tt4a9CKB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7ffJ+Go; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7a99c99acf7so256716685a.1;
        Sun, 08 Sep 2024 21:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725856413; x=1726461213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNTWUwfA/k3YrIoE6v3oi+OEiKWMd/2cobrQnPcutvY=;
        b=e7ffJ+GoqqMYerfOHuwcQbmGtmH5x07j/rib0TrQ+ZL4DdZyrU/EDZRxoCKpbvuQJD
         dJ2/KApLL4N0UYhJlqwEuI0Bo6e+qd7UjFUSuUZIztSDnpyhQR2W4xwKujeWLZTADide
         JkRYihVM82FpQuLwau1bMbr8Ex97LY2b8DL2gPDl4+9w/IFLq/2ZizTxX7slcr+wT2tK
         6eNiFML1YWhI1EkDIfosYjPWmVlYtbd4JtwLj9K8X1Bi+8/RiIYJU7dJe5wzKW7Vdb1P
         Fw9fFaODgUoUW3NIDib383PeXPhbsLwVRfc0yWk/XFGLnKEmapQmo8xx640cZ5mehCvs
         +X0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725856413; x=1726461213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNTWUwfA/k3YrIoE6v3oi+OEiKWMd/2cobrQnPcutvY=;
        b=KbTjeZ6ag3gmI9Ju05+ZjIA831DJsOKyHi2HT6vgjSdqFTWwszGlc1Ytt1GefTqmEV
         CoerJXcUmQ/lOi6gnuFqdHmdvoeomhBcY2k7Px7Z5woZPSEfKdMe/i6y0TAmm7FdgPOo
         NsaJXlj4qD7zIKqZvKfEP3EPrSUm+SshFNt2O9ONRPcQ0r6ri8fP2rmtRP0bIQZM+/da
         vMrH4a0R/7w00QjVTw1Myz2zuOROWjuMR4N1We/h8W2CX+QKL7JuX1WLQ2HaZcAKCX2X
         CHo0mpOQvzcxr7A9rrYn3bpa4U1gFEW+HT0kDw52tXI3aodCsHs1Qp7C61dUZLuOhmBE
         /NHA==
X-Forwarded-Encrypted: i=1; AJvYcCUXbc0xOBPFt635XPS799NTRiatIgnAkV2l0zKC0BTOg75zHmzxIHan2oZCt91fTDPWBzumln0lOtwB@vger.kernel.org, AJvYcCUZx9YeMykSyWL1VZroVWIvKAixF1n+1SiXV2iV2VhLB/VuuzO/6/exSgl3bQnns0cLb/j13MCx4ULQmqt1@vger.kernel.org, AJvYcCUlIJST4TjVnUwjFr8UHCiULR4setIqgxpLVV1ocWzB0Jgf0UkciRY/8iPARQufhBQwi7Al+iI2nNvU@vger.kernel.org
X-Gm-Message-State: AOJu0YzUtpnFsZA6kAtTrQPIdtFPIC5/QUgCfDX6SXqtof9jBURVdK+r
	M4B0lxz/0WjDWSqr+hLykWuoo+KNevwLL3bfDKQdT5wM9wQHPb3cJux/OrDD
X-Google-Smtp-Source: AGHT+IFJGRQX6PRJoLejI0Qd0YOruJmvqeC7p6SGhny/+oVCf9459TPZ1zsDZd5cI9SCC5B+fT7VPw==
X-Received: by 2002:a05:620a:1a09:b0:7a9:bcd1:5279 with SMTP id af79cd13be357-7a9bcd15378mr14757885a.18.1725856412706;
        Sun, 08 Sep 2024 21:33:32 -0700 (PDT)
Received: from localhost.localdomain (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a9a794559bsm180791685a.6.2024.09.08.21.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 21:33:31 -0700 (PDT)
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
Cc: skhan@linuxfoundation.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] iio: imu: Add i2c driver for bmi270 imu
Date: Mon,  9 Sep 2024 00:32:24 -0400
Message-ID: <20240909043254.611589-3-lanzano.alex@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909043254.611589-1-lanzano.alex@gmail.com>
References: <20240909043254.611589-1-lanzano.alex@gmail.com>
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
 drivers/iio/imu/bmi270/Kconfig       |  21 +++
 drivers/iio/imu/bmi270/Makefile      |   6 +
 drivers/iio/imu/bmi270/bmi270.h      |  62 +++++++
 drivers/iio/imu/bmi270/bmi270_core.c | 251 +++++++++++++++++++++++++++
 drivers/iio/imu/bmi270/bmi270_i2c.c  |  48 +++++
 8 files changed, 397 insertions(+)
 create mode 100644 drivers/iio/imu/bmi270/Kconfig
 create mode 100644 drivers/iio/imu/bmi270/Makefile
 create mode 100644 drivers/iio/imu/bmi270/bmi270.h
 create mode 100644 drivers/iio/imu/bmi270/bmi270_core.c
 create mode 100644 drivers/iio/imu/bmi270/bmi270_i2c.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a2184637a5d9..6612d27525b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3928,6 +3928,13 @@ S:	Maintained
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
index 000000000000..3f7b4ac30f00
--- /dev/null
+++ b/drivers/iio/imu/bmi270/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# BMI270 IMU driver
+#
+
+config BMI270
+	tristate
+	select IIO_BUFFER
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
index 000000000000..4af4098d8e82
--- /dev/null
+++ b/drivers/iio/imu/bmi270/bmi270.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef BMI270_H_
+#define BMI270_H_
+
+#include <linux/iio/iio.h>
+
+#define BMI270_CHIP_ID_REG				0x00
+#define BMI270_CHIP_ID_VAL				0x24
+#define BMI270_CHIP_ID_MSK				GENMASK(7, 0)
+
+#define BMI270_ACCEL_X_REG				0x0c
+#define BMI270_ANG_VEL_X_REG				0x12
+
+#define BMI270_INTERNAL_STATUS_REG			0x21
+#define BMI270_INTERNAL_STATUS_MSG_MSK			GENMASK(3, 0)
+#define BMI270_INTERNAL_STATUS_MSG_INIT_OK		0x01
+
+#define BMI270_INTERNAL_STATUS_AXES_REMAP_ERR_MSK	BIT(5)
+#define BMI270_INTERNAL_STATUS_ODR_50HZ_ERR_MSK		BIT(6)
+
+#define BMI270_ACC_CONF_REG				0x40
+#define BMI270_ACC_CONF_ODR_MSK				GENMASK(3, 0)
+#define BMI270_ACC_CONF_ODR_100HZ			0x08
+#define BMI270_ACC_CONF_BWP_MSK				GENMASK(6, 4)
+#define BMI270_ACC_CONF_BWP_NORMAL_MODE			0x02
+#define BMI270_ACC_CONF_FILTER_PERF_MSK			BIT(7)
+
+#define BMI270_GYR_CONF_REG				0x42
+#define BMI270_GYR_CONF_ODR_MSK				GENMASK(3, 0)
+#define BMI270_GYR_CONF_ODR_200HZ			0x09
+#define BMI270_GYR_CONF_BWP_MSK				GENMASK(5, 4)
+#define BMI270_GYR_CONF_BWP_NORMAL_MODE			0x02
+#define BMI270_GYR_CONF_NOISE_PERF_MSK			BIT(6)
+#define BMI270_GYR_CONF_FILTER_PERF_MSK			BIT(7)
+
+#define BMI270_INIT_CTRL_REG				0x59
+#define BMI270_INIT_CTRL_LOAD_DONE_MSK			BIT(0)
+
+#define BMI270_INIT_DATA_REG				0x5e
+
+#define BMI270_PWR_CONF_REG				0x7c
+#define BMI270_PWR_CONF_ADV_PWR_SAVE_MSK		BIT(0)
+#define BMI270_PWR_CONF_FIFO_WKUP_MSK			BIT(1)
+#define BMI270_PWR_CONF_FUP_EN_MSK			BIT(2)
+
+#define BMI270_PWR_CTRL_REG				0x7d
+#define BMI270_PWR_CTRL_AUX_EN_MSK			BIT(0)
+#define BMI270_PWR_CTRL_GYR_EN_MSK			BIT(1)
+#define BMI270_PWR_CTRL_ACCEL_EN_MSK			BIT(2)
+#define BMI270_PWR_CTRL_TEMP_EN_MSK			BIT(3)
+
+struct bmi270_data {
+	struct device *dev;
+	struct regmap *regmap;
+};
+
+extern const struct regmap_config bmi270_regmap_config;
+
+int bmi270_core_probe(struct device *dev, struct regmap *regmap);
+
+#endif  /* BMI270_H_ */
diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
new file mode 100644
index 000000000000..f0f83eb51dd2
--- /dev/null
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -0,0 +1,251 @@
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
+#define BMI270_INIT_DATA_FILE "bmi270-init-data.fw"
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
+	int ret;
+
+	switch (chan_type) {
+	case IIO_ACCEL:
+		reg = BMI270_ACCEL_X_REG + (axis - IIO_MOD_X) * sizeof(sample);
+		break;
+	case IIO_ANGL_VEL:
+		reg = BMI270_ANG_VEL_X_REG + (axis - IIO_MOD_X) * sizeof(sample);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_bulk_read(bmi270_device->regmap, reg, &sample, sizeof(sample));
+	if (ret)
+		return ret;
+
+	*val = sign_extend32(le16_to_cpu(sample), 15);
+
+	return 0;
+}
+
+static int bmi270_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	int ret;
+	struct bmi270_data *bmi270_device = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = bmi270_get_data(bmi270_device, chan->type, chan->channel2, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info bmi270_info = {
+	.read_raw = bmi270_read_raw,
+};
+
+#define BMI270_ACCEL_CHANNEL(_axis) {				\
+	.type = IIO_ACCEL,					\
+	.modified = 1,						\
+	.channel2 = IIO_MOD_##_axis,				\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
+	BIT(IIO_CHAN_INFO_FREQUENCY),				\
+}
+
+#define BMI270_ANG_VEL_CHANNEL(_axis) {				\
+	.type = IIO_ANGL_VEL,					\
+	.modified = 1,						\
+	.channel2 = IIO_MOD_##_axis,				\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
+	BIT(IIO_CHAN_INFO_FREQUENCY),				\
+}
+
+static const struct iio_chan_spec bmi270_channels[] = {
+	BMI270_ACCEL_CHANNEL(X),
+	BMI270_ACCEL_CHANNEL(Y),
+	BMI270_ACCEL_CHANNEL(Z),
+	BMI270_ANG_VEL_CHANNEL(X),
+	BMI270_ANG_VEL_CHANNEL(Y),
+	BMI270_ANG_VEL_CHANNEL(Z)
+};
+
+static int bmi270_validate_chip_id(struct bmi270_data *bmi270_device)
+{
+	int chip_id;
+	int ret;
+	struct device *dev = bmi270_device->dev;
+	struct regmap *regmap = bmi270_device->regmap;
+
+	ret = regmap_read(regmap, BMI270_CHIP_ID_REG, &chip_id);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read chip id");
+
+	if (chip_id != BMI270_CHIP_ID_VAL)
+		return dev_err_probe(dev, -ENODEV, "Invalid chip id 0x%x", chip_id);
+
+	return 0;
+}
+
+static int bmi270_write_calibration_data(struct bmi270_data *bmi270_device)
+{
+	int ret;
+	int status = 0;
+	const struct firmware *init_data;
+	struct device *dev = bmi270_device->dev;
+	struct regmap *regmap = bmi270_device->regmap;
+
+	ret = regmap_clear_bits(regmap, BMI270_PWR_CONF_REG, BMI270_PWR_CONF_ADV_PWR_SAVE_MSK);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to write power configuration");
+
+	usleep_range(450, 1000);
+
+	ret = regmap_clear_bits(regmap, BMI270_INIT_CTRL_REG, BMI270_INIT_CTRL_LOAD_DONE_MSK);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to prepare device to load init data");
+
+	ret = request_firmware(&init_data, BMI270_INIT_DATA_FILE, dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to load init data file");
+
+	ret = regmap_bulk_write(regmap, BMI270_INIT_DATA_REG,
+				init_data->data, init_data->size);
+	release_firmware(init_data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to write init data");
+
+	ret = regmap_set_bits(regmap, BMI270_INIT_CTRL_REG, BMI270_INIT_CTRL_LOAD_DONE_MSK);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to stop device initialization");
+
+	usleep_range(20000, 55000);
+
+	ret = regmap_read(regmap, BMI270_INTERNAL_STATUS_REG, &status);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read internal status");
+
+	if (status != BMI270_INTERNAL_STATUS_MSG_INIT_OK)
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
+	ret = regmap_set_bits(regmap, BMI270_PWR_CTRL_REG,
+			      BMI270_PWR_CTRL_AUX_EN_MSK |
+			      BMI270_PWR_CTRL_GYR_EN_MSK |
+			      BMI270_PWR_CTRL_ACCEL_EN_MSK);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable accelerometer and gyroscope");
+
+	ret = regmap_set_bits(regmap, BMI270_ACC_CONF_REG,
+			      FIELD_PREP(BMI270_ACC_CONF_ODR_MSK,
+					 BMI270_ACC_CONF_ODR_100HZ) |
+			      FIELD_PREP(BMI270_ACC_CONF_BWP_MSK,
+					 BMI270_ACC_CONF_BWP_NORMAL_MODE) |
+			      BMI270_PWR_CONF_ADV_PWR_SAVE_MSK);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to configure accelerometer");
+
+	ret = regmap_set_bits(regmap, BMI270_GYR_CONF_REG,
+			      FIELD_PREP(BMI270_GYR_CONF_ODR_MSK,
+					 BMI270_GYR_CONF_ODR_200HZ) |
+			      FIELD_PREP(BMI270_GYR_CONF_BWP_MSK,
+					 BMI270_GYR_CONF_BWP_NORMAL_MODE) |
+			      BMI270_PWR_CONF_ADV_PWR_SAVE_MSK);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to configure gyroscope");
+
+	/* Enable FIFO_WKUP, Disable ADV_PWR_SAVE and FUP_EN */
+	ret = regmap_write(regmap, BMI270_PWR_CONF_REG,
+			   BMI270_PWR_CONF_FIFO_WKUP_MSK);
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
+	ret = bmi270_write_calibration_data(bmi270_device);
+	if (ret)
+		return ret;
+
+	return bmi270_configure_imu(bmi270_device);
+}
+
+int bmi270_core_probe(struct device *dev, struct regmap *regmap)
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
+	ret = bmi270_chip_init(bmi270_device);
+	if (ret)
+		return ret;
+
+	indio_dev->channels = bmi270_channels;
+	indio_dev->num_channels = ARRAY_SIZE(bmi270_channels);
+	indio_dev->name = "bmi270";
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
index 000000000000..f70dee2d8a64
--- /dev/null
+++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/regmap.h>
+
+#include "bmi270.h"
+
+static int bmi270_i2c_probe(struct i2c_client *client)
+{
+	struct regmap *regmap;
+	struct device *dev = &client->dev;
+
+	regmap = devm_regmap_init_i2c(client, &bmi270_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to init i2c regmap");
+
+	return bmi270_core_probe(dev, regmap);
+}
+
+static const struct i2c_device_id bmi270_i2c_id[] = {
+	{ "bmi270", 0 },
+	{ }
+};
+
+static const struct of_device_id bmi270_of_match[] = {
+	{ .compatible = "bosch,bmi270" },
+	{ }
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


