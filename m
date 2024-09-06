Return-Path: <linux-iio+bounces-9255-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EA596F9A9
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 18:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0360E1C21A82
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 16:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3D71D47D9;
	Fri,  6 Sep 2024 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DX5bPJWQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9C41C9ECF;
	Fri,  6 Sep 2024 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725641637; cv=none; b=jIX9cjsIUtJDPQacHcoTDpDh6oUJT58HzZLav1rnCQaKB2AJ906Kr3arDclJyHXBZIKc4Jx/Y1KulWPT7iFa/Msfk64n2dOF9vIw7Q05U621/XRn2CdLTafUW3FE+NpjwdiC2W84KLfZd6tsJHN4uzAkBz7E47EhDNBc0SQ174w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725641637; c=relaxed/simple;
	bh=tNibDdNZJ9wtClxGYDm4aaoEUdmnXkc/L9Ojg84cZ9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjSV4zliMFiC6S5WqHJoz/gbVJjcl+3Los/+T8twIV0UmMvnnntLru6ayiKdSQQX77P9EPko6OLsHZy2/1TWNPz0DOcvqZYCv6N+UTi/tCOmzSoftiUGM7IhWZp/5gMDtwgqxygtGgumeapRO70UtYOcOqXSurfb/csKCaJTVHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DX5bPJWQ; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3df0f0b8111so1533920b6e.3;
        Fri, 06 Sep 2024 09:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725641635; x=1726246435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evGq+dNPZtxqlXo7uRptf1GAtrz/Svzioo49oGWfN34=;
        b=DX5bPJWQlojyAGErcst00ANzyTXBJDasH9a1wK5qZMFdm/92vBnvyIFxKHOUO1HetR
         L5MHn1iqvbXrM4+0mGO6JJGudaBcbwVzoDbSKQdCKOGDRoHnezlo5uxJxPW6m3ryOFYk
         WMUW4zpEM5Efm59hXpwTN6HVybvriL1P2CbYCwKXunxRDNyLl5OWsIKmFKJrDatmE9kV
         hpdjXtZ6r4qAFslp7QLYMz3PQW90vAxUXsvgiBM37QGwt/WC+4eVWHebFicq5ZaNKLtU
         aoDGLdKUJBtyey6taAI6N6BVcWAp5B8MGlWJAXf9gAwVr60Rteer5WGSqDDsn8nGQyVg
         14ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725641635; x=1726246435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evGq+dNPZtxqlXo7uRptf1GAtrz/Svzioo49oGWfN34=;
        b=eBBniGDWqI3vNWR4QYcvbWsWg8d/gvysfhcYrbmrBrojDO/sIwiXN5LEsaD8ajA45t
         Vp42VdrQVZOjmCV9jN/mICqRjvtlPCt89r1/c0m0DbSbkX9SjpbC3skyDSxoCmYWBKke
         UscfN4pyLKFO36IeqqXAlqPcu8CXBYPN0WeBzdFfWh6QM3eCX65rClMITt3XdV3HG+DT
         b5TvPQWotxNFz8QewlI0dsZtkgXuVUvmf8sRHPCOIAZuO3RZlguhztn1QzyGTmW5uMJA
         8KxAOJcXmtwdasBVHbHELPnGJtRmIHiTziXQXH5Q0mZRYbmbH0SMA3ZME20v4paYmgmV
         YzjA==
X-Forwarded-Encrypted: i=1; AJvYcCUWE4NkVU1FAqMBJhVVeElFsBonhU6tXEDPxjbYeLRStNsOLabWJmmNwwCEp7NF2VttdaaQveMML3pt@vger.kernel.org, AJvYcCXLQLugqukRJVip3KowVBRQyTGU48KkI1MfZQXnon8Xvu/kWOy7Gbqv3WotZkTTn5tU/O07nTXsFzr4@vger.kernel.org, AJvYcCXr794j7s37rS2xCND70evAhip0ITqipW8xoSoATiDCZCfgvzp/Qsa8SPfGyUN/yfdKEZz65MegX+5HZ0wc@vger.kernel.org
X-Gm-Message-State: AOJu0YzpA3LU6g9hOJDAIfPMc1h6IuKh+zAabOoIoGSFkmYuZ8i9MG6l
	wVV7yiTLigF7oxT8mvjLOcjIlSdyIV1QAFm7L3J/U6qA1WQNi7wX
X-Google-Smtp-Source: AGHT+IHYEN9MxkdT1iRzMQSYXW02am6KtYS1/HBAKPEJtwnz6PqZF1j9pl/kT3dAzHs6hcZFK67eIw==
X-Received: by 2002:a05:6808:1245:b0:3db:1b29:f28f with SMTP id 5614622812f47-3e029efe37bmr4799056b6e.24.1725641634954;
        Fri, 06 Sep 2024 09:53:54 -0700 (PDT)
Received: from localhost.localdomain (ool-1826d901.dyn.optonline.net. [24.38.217.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45801b36206sm17580121cf.29.2024.09.06.09.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 09:53:54 -0700 (PDT)
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
Subject: [PATCH v2 2/2] iio: imu: Add i2c driver for bmi270 imu
Date: Fri,  6 Sep 2024 12:52:51 -0400
Message-ID: <20240906165322.1745328-3-lanzano.alex@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240906165322.1745328-1-lanzano.alex@gmail.com>
References: <20240906165322.1745328-1-lanzano.alex@gmail.com>
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


