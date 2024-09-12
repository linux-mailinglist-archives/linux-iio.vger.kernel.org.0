Return-Path: <linux-iio+bounces-9473-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9AA97735D
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 23:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FAD71C217AC
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 21:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D8D1C2326;
	Thu, 12 Sep 2024 21:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XouL1JKa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D147B1C230B;
	Thu, 12 Sep 2024 21:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726175316; cv=none; b=lFDgp0cOd+n/0I0R+KBu0RmhU2hxBVx7ShTDZ8sGmxap6Cq0Icy3PooPxKjOZCXsut6sjb3jD9fPAJ8lb0OHD/DspfA+aitanD5oru9dCa2UVGe2uBc+wpY4ngG7lpX09PfVuvBDn+TfWLnspB3UVFcWmkHQSA1GaatBPmR1Ot8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726175316; c=relaxed/simple;
	bh=ieHwLUC9d6q8xQr5disSuxjgKgTbTb+ZKNlT5Ay+g3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sER1bsZ3gabilJq5wudaKMIBjPgpwKYmuJEbT/SmsJ6zmbJI7uthJspm9dbsaRIqrDGxLZNAt7wT3A63SJMrLj9xIbfQl5EJe4PIEqje5iCIcYATFfE/58IcFFQz/NM+0OjscAT1I0nNBOHVD0BxTpnKIqxNpITZ6nVL47UOAVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XouL1JKa; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-458366791aaso7535871cf.1;
        Thu, 12 Sep 2024 14:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726175313; x=1726780113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWGcVBwkznJABkAETYE0dHWkQaBh3wiEtxDU0kr5FCg=;
        b=XouL1JKatVpY/M1h8f1d4yRrrL2zJZSVNweyR+mVE7EeMqZEf2q4c56VN6IYaCYE7Y
         p0ThDr+6GUz56wQlyiXazXV5Ur6Ya1njrfbR2Qy0f84fUARlHSfS4pxaZlbtylT4D+lV
         Sn+rP+t2ba+PpS9yaBEd5wwZs0VIrCWGuigALM+tEnZeJHOuNPzReMfsOapm5U5dI7pJ
         /knunJrLZguciFnC9OkWHV5K6g9scWJ+7WGaIdliklqNX63uhBi2Uu0hHtaAWuzna8CO
         OuQl9oO+RpQIHANWKspEh4QPhywZ2/QGTxw4hrYmbqOgMQGYAFbEoXXWL7cfEOg+IDqd
         7+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726175313; x=1726780113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWGcVBwkznJABkAETYE0dHWkQaBh3wiEtxDU0kr5FCg=;
        b=e0omqUWlInAKH1t+nGxKyDpeYlHaa1QW371ZN/IWpTZjT/qfOxCYLg2qYYcFYZqLUQ
         KhK5Kg96YSaK1VIoB/bWqq4mcvtjB6YgVaNniVm1cV/ZsHjHE+PntGAuAMuWHttD0Ic4
         Y1QTRcXyHlifYdMAQ6uTDPzaqYf/Thqch6AUtbzkmIuOi8asmBS0jBRFvyiElfvbCKK0
         KtDjrG6Giw2bFkTpYDBSsmR75ItWd3pv+SU6BHHXmn78AhcAXKqGyedVAsWZi6K32MRK
         1bNZdSnXkGO/Kmc+PX8fUtb2RwMtqxmUMX3pUL18l4OtKnT3PPU7LcrZ/m/J07cDIf76
         Qx2A==
X-Forwarded-Encrypted: i=1; AJvYcCUKtiv4arelSxEBruFLE/x4ltYys25YS0luX7x9jScPtnmwncFz+o5wXrV9hV6SATftj+fr7qRUHLi3t2uW@vger.kernel.org, AJvYcCXAc0VeE7BSVQUGCzxSx/bePWnSbyp91JA5KhU8CYJFrsmBEuwlnln9A7fylpbVibVOz7UavGBuD9B1@vger.kernel.org, AJvYcCXl0N2aL8jim3t0ApptMw/0okKdcpXMPzacLWMXAqywAEgtqqIZqgJvjgtu/W6pBUGU3+G1eJGUafgz@vger.kernel.org
X-Gm-Message-State: AOJu0Yz63Y/k8tUdbBu3Iy/Z8L1LLKTlkaidHOEletyP3g50NVKuEZ2G
	scuY9PlvJrYvnRKfSE1WlvN5/R5XXVf8GiGWRNzpFVVkmrk39Q08
X-Google-Smtp-Source: AGHT+IEyx7DLcAZYCVxmvINhsoaNuLuBoEO1wBAvMi1ptSILKdKqi9Npz8PHOAXOigv0gPPMhp9fSQ==
X-Received: by 2002:a05:622a:2997:b0:458:441c:7d4b with SMTP id d75a77b69052e-458603cbf32mr52000061cf.46.1726175313390;
        Thu, 12 Sep 2024 14:08:33 -0700 (PDT)
Received: from localhost.localdomain (117.sub-174-193-5.myvzw.com. [174.193.5.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45822e613eesm56959721cf.12.2024.09.12.14.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 14:08:32 -0700 (PDT)
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
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] iio: imu: Add i2c driver for bmi270 imu
Date: Thu, 12 Sep 2024 17:07:19 -0400
Message-ID: <20240912210749.3080157-3-lanzano.alex@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912210749.3080157-1-lanzano.alex@gmail.com>
References: <20240912210749.3080157-1-lanzano.alex@gmail.com>
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
 drivers/iio/imu/bmi270/bmi270_core.c | 258 +++++++++++++++++++++++++++
 drivers/iio/imu/bmi270/bmi270_i2c.c  |  48 +++++
 8 files changed, 404 insertions(+)
 create mode 100644 drivers/iio/imu/bmi270/Kconfig
 create mode 100644 drivers/iio/imu/bmi270/Makefile
 create mode 100644 drivers/iio/imu/bmi270/bmi270.h
 create mode 100644 drivers/iio/imu/bmi270/bmi270_core.c
 create mode 100644 drivers/iio/imu/bmi270/bmi270_i2c.c

diff --git a/MAINTAINERS b/MAINTAINERS
index dd4588838d90..faf109ae60eb 100644
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
index 000000000000..319e5601d9e7
--- /dev/null
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+#include <linux/firmware.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/bitfield.h>
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
+	/* After disabling advanced power save, all registers are accessible after a 450us delay
+	 * This delay is specified in table A of the datasheet.
+	 */
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
+	/* Wait at least 140ms for the device to complete configuration.
+	 * This delay is specified in table C of the datasheet.
+	 */
+	usleep_range(140000, 160000);
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


