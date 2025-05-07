Return-Path: <linux-iio+bounces-19256-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B535AAEC34
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 21:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB9598359F
	for <lists+linux-iio@lfdr.de>; Wed,  7 May 2025 19:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384B328BAAE;
	Wed,  7 May 2025 19:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euS0UZLR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F85428983F
	for <linux-iio@vger.kernel.org>; Wed,  7 May 2025 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746646357; cv=none; b=kUYutn8xMNUUaUKztoY4bx4vzhDpHJcHIwjnDSE9C9xk0YFeGKam8GBswn8gVbEb3lMYF60KOAaNRz0QWJkjldfRs5QGW8hktbpmy1G2izLeR+s/LgJ02f34K1vNbG4GwnS9f65LffPJQrlyz6yxPWQcjvQw4ys6qCxlwqYrDAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746646357; c=relaxed/simple;
	bh=NBLKEWz/wBwrhF43UTvL2O4g10+i5QFaSLvdKGK4WBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7De4aslRnftjItTX8xTJpasEPe+1XFUpjAhijV6UIv02NR0qp560PWWWVkdo9clrVKlN5NLONGp85OUP9H/fhGC0n8atVPau1Seh0wt0pXx1hxDVKcUom8d96tDh8qeS6A3fAgdTLuLQrZSmlhTCinutzBrC5WZWo6DtEdJVH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euS0UZLR; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22e76850b80so2056755ad.1
        for <linux-iio@vger.kernel.org>; Wed, 07 May 2025 12:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746646353; x=1747251153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNvlrQTfkUE4VjZeS+CNUr0U0EyaT9djQU9Ki8xeVdY=;
        b=euS0UZLR3t0KJg6WwRvXhju3VxDwl3O/RobU4Br9HLZkWHEwBN93fGHuuP3X4fzclq
         ddnTl9jcxv6bgz+G8+gdyZCvjcz6zBGNmri2gfWcQ++kSNN4JrSVBLgojuNb9eNPAt+k
         LyC+1+y5fO4r+fKwtoUaahdYtJOkF6kM53o1cCmwG1UPk72bAmSNVzX9jA+UWCeY1ewC
         QJk3ZySxl6l/+nfQMvEKpOAhJ5eUZqA+1ENX5Pt7NrY9QpQvteR5cFPPeO4QBNCb62Ej
         xyVVH9jECfPgvJzkMl2bu8EgVXLio2xgTy03FSMQ47l8QEt+ed+26yiLavlVNjGIlwaq
         PpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746646353; x=1747251153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNvlrQTfkUE4VjZeS+CNUr0U0EyaT9djQU9Ki8xeVdY=;
        b=VKyONMKv+ZCriS0I/H1ia9ODV1VC3+XQynmYjrrGxJzkbg5G/dNdX2rbRBG2Z/RtW6
         LjRQij1BbfJPolbHxxPpiErq+xXH8ZvZ8nq059JstjhJeYlt6VIiu9RYdA/mU4vbeJwH
         4FeJHujnrnK2IC2FDwOmoVCwN/lPjS5Ne/7CErih70Kq1y9buhFu9LWmz1/uI2NYqwca
         q3dIVNZJQ0RaOrYa6ZFz1TC4ECWUBFnrQnBn7XkR3q4TB/FX24NH1hADP4hFfu8k/92O
         4ErDbNCfWfviB1wH+FSGZbFz1QTqBt6gLkHPCrB0qxx51/KNS87QHfKSUbMlHiuSo9Eu
         rI4A==
X-Gm-Message-State: AOJu0YzbyP3feQgvJ5zwgPT40AVxM52Db0k0BoVAD377O9d8mVmpxB4Q
	LUBO18wp/cBzfUrZiIv5ho24JOKSNOFGe8jldKzCb2fKDvm50W/8mXetXs7dz3A=
X-Gm-Gg: ASbGnctyoRyieRYb2j0riyVbsF3s1g++UO1RuM+WBwwpdT+noLZC37mH9OhxAZDU9v7
	XDF4YYHwshxMN+hrezAbgmiL1KjjZySY8lt2l/qA5U0gOOTn8aitOLHmH+axTaxtsbJBRbmvRkL
	WQ19TfOfAL2EaGuDbnm7tmPuJCpSsMkiYngqZHmoiifurJk9QEjaBq7nAIgt7Ca0924sZXnjFPZ
	Jtub+RF/6XhjOn88qQ8FrurjnBQmGJHY5x7+sM9jQ4oJbpgqEvlSBRO5ij5UbSLGNlQEyL45ioV
	Aem8vtjAgNd5EaTq35o1VG8nzV6qzUSsi23UTcRjSMqM+YzmyoJj+78G29hK
X-Google-Smtp-Source: AGHT+IEsepi9bX5ur6UOWNVFv2aWixAkHEB+SxPo0S6SENhgsSW8uxy0SU0DFzCwiQ61kcp0ZSuTBg==
X-Received: by 2002:a17:902:da84:b0:224:11fc:40c0 with SMTP id d9443c01a7336-22e85613e2amr9161915ad.11.1746646352731;
        Wed, 07 May 2025 12:32:32 -0700 (PDT)
Received: from localhost.localdomain ([103.205.130.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15228f62sm97769815ad.168.2025.05.07.12.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 12:32:32 -0700 (PDT)
From: Brajesh Patil <brajeshpatil11@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	marcelo.schmitt1@gmail.com,
	dlechner@baylibre.com,
	Brajesh Patil <brajeshpatil11@gmail.com>
Subject: [PATCH v1 1/3] iio: magnetometer: qmc5883l: add support for QMC5883L sensor
Date: Wed,  7 May 2025 20:32:17 +0100
Message-Id: <20250507193219.52965-2-brajeshpatil11@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250507193219.52965-1-brajeshpatil11@gmail.com>
References: <20250507193219.52965-1-brajeshpatil11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Brajesh Patil <brajeshpatil11@gmail.com>
---
 .../iio/magnetometer/qst,qmc5883l.yaml        |  52 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/iio/magnetometer/Kconfig              |  13 +
 drivers/iio/magnetometer/Makefile             |   2 +
 drivers/iio/magnetometer/qmc5883l.c           | 471 ++++++++++++++++++
 5 files changed, 540 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/qst,qmc5883l.yaml
 create mode 100644 drivers/iio/magnetometer/qmc5883l.c

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/qst,qmc5883l.yaml b/Documentation/devicetree/bindings/iio/magnetometer/qst,qmc5883l.yaml
new file mode 100644
index 000000000000..a2e6982a177d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/qst,qmc5883l.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/qst,qmc5883l.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: QST QMC5883L 3-Axis Magnetometer
+
+maintainers:
+  - Brajesh Patil <brajeshpatil11@gmail.com>
+
+description: |
+  The QMC5883L is a 3-axis magnetic sensor with I2C interface. It provides
+  measurements of magnetic field strength along X, Y and Z axes, as well as
+  temperature readings.
+
+properties:
+  compatible:
+    const: qst,qmc5883l
+
+  reg:
+    maxItems: 1
+    description: I2C slave address (0x0d)
+
+  mount-matrix:
+    description: |
+      A 3x3 rotation matrix describing how the magnetometer is mounted
+      on the device. This is used to orient the sensor measurements
+      to match the device's coordinate system.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        magnetometer@0d {
+            compatible = "qst,qmc5883l";
+            reg = <0x0d>;
+            mount-matrix = "1", "0", "0",
+                           "0", "1", "0",
+                           "0", "0", "1";
+        };
+    };
+...
+
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 86f6a19b28ae..b306950ebea8 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1236,6 +1236,8 @@ patternProperties:
     description: Shenzhen QiShenglong Industrialist Co., Ltd.
   "^qnap,.*":
     description: QNAP Systems, Inc.
+  "^qst,.*":
+    description: QST Corporation Ltd.
   "^quanta,.*":
     description: Quanta Computer Inc.
   "^radxa,.*":
diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 3debf1320ad1..68a6ba9b9b68 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -206,6 +206,19 @@ config SENSORS_HMC5843_SPI
 	  - hmc5843_core (core functions)
 	  - hmc5843_spi (support for HMC5983)
 
+config SENSORS_QMC5883L
+	tristate "QST QMC5883L 3-Axis Magnetometer"
+	depends on I2C
+	select REGMAP_I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say Y here to build support for the QST QMC5883L 3-axis magnetometer
+          through its I2C interface.
+
+          To compile this driver as a module, choose M here: the module will be
+          called qmc5883l.
+
 config SENSORS_RM3100
 	tristate
 	select IIO_BUFFER
diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
index 9297723a97d8..90a45f17020a 100644
--- a/drivers/iio/magnetometer/Makefile
+++ b/drivers/iio/magnetometer/Makefile
@@ -27,6 +27,8 @@ obj-$(CONFIG_SENSORS_HMC5843)		+= hmc5843_core.o
 obj-$(CONFIG_SENSORS_HMC5843_I2C)	+= hmc5843_i2c.o
 obj-$(CONFIG_SENSORS_HMC5843_SPI)	+= hmc5843_spi.o
 
+obj-$(CONFIG_SENSORS_QMC5883L) += qmc5883l.o
+
 obj-$(CONFIG_SENSORS_RM3100)		+= rm3100-core.o
 obj-$(CONFIG_SENSORS_RM3100_I2C)	+= rm3100-i2c.o
 obj-$(CONFIG_SENSORS_RM3100_SPI)	+= rm3100-spi.o
diff --git a/drivers/iio/magnetometer/qmc5883l.c b/drivers/iio/magnetometer/qmc5883l.c
new file mode 100644
index 000000000000..9462794a51ef
--- /dev/null
+++ b/drivers/iio/magnetometer/qmc5883l.c
@@ -0,0 +1,471 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+/* Register Addresses */
+#define QMC5883L_DATA_OUT_LSB_REG   0x00
+#define QMC5883L_STATUS_REG         0x06
+#define QMC5883L_TEMP_OUT_LSB_REG   0x07
+#define QMC5883L_CONTROL_REG_1      0x09
+#define QMC5883L_CONTROL_REG_2      0x0A
+#define QMC5883L_FBR_REG            0x0B
+#define QMC5883L_CHIP_ID_REG        0x0D
+#define QMC5883L_CHIP_ID            0xFF
+
+/* Status Register Bits */
+#define QMC5883L_DRDY               0x01
+#define QMC5883L_OVL                0x02
+#define QMC5883L_DOR                0x04
+
+/* Control Register 1 Configuration Bits */
+/* Mode (bits [1:0]) */
+#define QMC5883L_MODE_STANDBY       0x00
+#define QMC5883L_MODE_CONT          0x01
+#define QMC5883L_MODE_MASK          0x03
+#define QMC5883L_MODE_SHIFT         0
+
+/* Output Data Rate - ODR (bits [3:2]) */
+#define QMC5883L_ODR_10HZ           0x00
+#define QMC5883L_ODR_50HZ           0x01
+#define QMC5883L_ODR_100HZ          0x02
+#define QMC5883L_ODR_200HZ          0x03
+#define QMC5883L_ODR_MASK           0x0C
+#define QMC5883L_ODR_SHIFT          2
+
+/* Full Scale Range - RNG (bits [5:4]) */
+#define QMC5883L_RNG_2G             0x00
+#define QMC5883L_RNG_8G             0x01
+#define QMC5883L_RNG_MASK           0x30
+#define QMC5883L_RNG_SHIFT          4
+
+/* Oversampling Ratio - OSR (bits [7:6]) */
+#define QMC5883L_OSR_512            0x00
+#define QMC5883L_OSR_256            0x01
+#define QMC5883L_OSR_128            0x02
+#define QMC5883L_OSR_64             0x03
+#define QMC5883L_OSR_MASK           0xC0
+#define QMC5883L_OSR_SHIFT          6
+
+static const int qmc5883l_odr_map[] = {
+	[QMC5883L_ODR_10HZ]  = 10,
+	[QMC5883L_ODR_50HZ]  = 50,
+	[QMC5883L_ODR_100HZ] = 100,
+	[QMC5883L_ODR_200HZ] = 200,
+};
+
+/**
+ * struct qmc5883l_data - device instance specific data
+ * @client: I2C client structure
+ * @lock: mutex to protect register access
+ * @regmap: register map of the device
+ * @scan: buffer for triggered data reading
+ */
+struct qmc5883l_data {
+	struct i2c_client *client;
+	struct mutex lock;
+	struct regmap *regmap;
+
+	struct {
+		__le16 chans[3];
+
+		s64 timestamp __aligned(8);
+	} scan;
+};
+
+static int qmc5883l_init(struct qmc5883l_data *data);
+static int qmc5883l_set_mode(struct qmc5883l_data *data, unsigned int mode);
+
+static int qmc5883l_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct qmc5883l_data *data = iio_priv(indio_dev);
+
+	return qmc5883l_set_mode(data, QMC5883L_MODE_CONT);
+}
+
+static int qmc5883l_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct qmc5883l_data *data = iio_priv(indio_dev);
+
+	return qmc5883l_set_mode(data, QMC5883L_MODE_STANDBY);
+}
+
+static const struct iio_buffer_setup_ops qmc5883l_buffer_setup_ops = {
+	.preenable	= qmc5883l_buffer_preenable,
+	.postdisable	= qmc5883l_buffer_postdisable,
+};
+
+/* Register map access tables */
+static const struct regmap_range qmc5883l_readable_ranges[] = {
+	regmap_reg_range(QMC5883L_DATA_OUT_LSB_REG, QMC5883L_CHIP_ID_REG),
+};
+
+static const struct regmap_access_table qmc5883l_readable_table = {
+	.yes_ranges = qmc5883l_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(qmc5883l_readable_ranges),
+};
+
+static const struct regmap_range qmc5883l_writable_ranges[] = {
+	regmap_reg_range(QMC5883L_CONTROL_REG_1, QMC5883L_FBR_REG),
+};
+
+static const struct regmap_access_table qmc5883l_writable_table = {
+	.yes_ranges = qmc5883l_writable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(qmc5883l_writable_ranges),
+};
+
+static const struct regmap_range qmc5883l_volatile_ranges[] = {
+	regmap_reg_range(QMC5883L_DATA_OUT_LSB_REG, QMC5883L_TEMP_OUT_LSB_REG + 1),
+};
+
+static const struct regmap_access_table qmc5883l_volatile_table = {
+	.yes_ranges = qmc5883l_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(qmc5883l_volatile_ranges),
+};
+
+static const struct regmap_config qmc5883l_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = QMC5883L_CHIP_ID_REG,
+
+	.rd_table = &qmc5883l_readable_table,
+	.wr_table = &qmc5883l_writable_table,
+	.volatile_table = &qmc5883l_volatile_table,
+
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static int qmc5883l_set_mode(struct qmc5883l_data *data, unsigned int mode)
+{
+	int ret;
+
+	mutex_lock(&data->lock);
+	ret = regmap_update_bits(data->regmap, QMC5883L_CONTROL_REG_1,
+				 QMC5883L_MODE_MASK, mode << QMC5883L_MODE_SHIFT);
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static int qmc5883l_wait_measurement(struct qmc5883l_data *data)
+{
+	int tries = 150;
+	unsigned int val;
+	int ret;
+
+	while (tries-- > 0) {
+		ret = regmap_read(data->regmap, QMC5883L_STATUS_REG, &val);
+		if (ret < 0)
+			return ret;
+
+		if (val & QMC5883L_OVL) {
+			dev_err(&data->client->dev, "data overflow\n");
+			return -EOVERFLOW;
+		}
+
+		if (val & QMC5883L_DRDY)
+			return 0;
+		usleep_range(5000, 6000);
+	}
+
+	dev_err(&data->client->dev, "data not ready\n");
+	return -EIO;
+}
+
+static int qmc5883l_read_measurement(struct qmc5883l_data *data,
+				     int idx, int *val)
+{
+	__le16 values[3];
+	int ret;
+
+	ret = qmc5883l_set_mode(data, QMC5883L_MODE_CONT);
+	if (ret < 0)
+		return ret;
+
+	ret = qmc5883l_wait_measurement(data);
+	if (ret < 0) {
+		qmc5883l_set_mode(data, QMC5883L_MODE_STANDBY);
+		return ret;
+	}
+
+	mutex_lock(&data->lock);
+	ret = regmap_bulk_read(data->regmap, QMC5883L_DATA_OUT_LSB_REG,
+			       values, sizeof(values));
+	mutex_unlock(&data->lock);
+
+	qmc5883l_set_mode(data, QMC5883L_MODE_STANDBY);
+	if (ret < 0)
+		return ret;
+
+	*val = sign_extend32(le16_to_cpu(values[idx]), 15);
+	return IIO_VAL_INT;
+}
+
+static int qmc5883l_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int *val, int *val2, long mask)
+{
+	struct qmc5883l_data *data = iio_priv(indio_dev);
+	unsigned int rval;
+	__le16 temp_val;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (chan->type == IIO_TEMP) {
+			ret = qmc5883l_set_mode(data, QMC5883L_MODE_CONT);
+			if (ret < 0)
+				return ret;
+
+			mutex_lock(&data->lock);
+			ret = regmap_bulk_read(data->regmap, QMC5883L_TEMP_OUT_LSB_REG,
+					       &temp_val, sizeof(temp_val));
+			mutex_unlock(&data->lock);
+
+			qmc5883l_set_mode(data, QMC5883L_MODE_STANDBY);
+
+			if (!ret)
+				*val = sign_extend32(le16_to_cpu(temp_val), 15);
+
+			return ret ? ret : IIO_VAL_INT;
+		}
+		return qmc5883l_read_measurement(data, chan->scan_index, val);
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type == IIO_TEMP) {
+			/* scale = 124 / 10000 = 0.0124 °C/LSB */
+			*val = 124;
+			*val2 = 10000;
+			return IIO_VAL_FRACTIONAL;
+		}
+		ret = regmap_read(data->regmap, QMC5883L_CONTROL_REG_1, &rval);
+		if (ret < 0)
+			return ret;
+		rval = (rval & QMC5883L_RNG_MASK) >> QMC5883L_RNG_SHIFT;
+		*val = (rval == 0) ? 12000 : 3000;  /* ±2G:12000, ±8G:3000 LSB/G */
+		*val2 = 0;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_OFFSET:
+		if (chan->type == IIO_TEMP) {
+			/* offset = 287661 / 100 = 2876.61 °C */
+			*val = 287661;
+			*val2 = 100;
+			return IIO_VAL_FRACTIONAL;
+		}
+		return -EINVAL;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = regmap_read(data->regmap, QMC5883L_CONTROL_REG_1, &rval);
+		if (ret < 0)
+			return ret;
+
+		rval = (rval & QMC5883L_ODR_MASK) >> QMC5883L_ODR_SHIFT;
+
+		if (rval >= ARRAY_SIZE(qmc5883l_odr_map) || !qmc5883l_odr_map[rval])
+			return -EINVAL;
+
+		*val = qmc5883l_odr_map[rval];
+		*val2 = 0;
+		return IIO_VAL_INT;
+	}
+	return -EINVAL;
+}
+
+static irqreturn_t qmc5883l_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct qmc5883l_data *data = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&data->lock);
+	ret = qmc5883l_wait_measurement(data);
+	if (ret < 0) {
+		mutex_unlock(&data->lock);
+		goto done;
+	}
+
+	ret = regmap_bulk_read(data->regmap, QMC5883L_DATA_OUT_LSB_REG,
+			       data->scan.chans, sizeof(data->scan.chans));
+	mutex_unlock(&data->lock);
+
+	if (ret < 0)
+		goto done;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
+					   iio_get_time_ns(indio_dev));
+
+done:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
+/* Channel definitions */
+#define QMC5883L_CHANNEL(axis, idx)             \
+{                           \
+	.type = IIO_MAGN,               \
+	.modified = 1,                  \
+	.channel2 = IIO_MOD_##axis,         \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),   \
+	.info_mask_shared_by_type =         \
+		BIT(IIO_CHAN_INFO_SCALE) |      \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),       \
+	.scan_index = idx,              \
+	.scan_type = {                  \
+		.sign = 's',                \
+		.realbits = 16,             \
+		.storagebits = 16,          \
+		.endianness = IIO_LE,           \
+	},                      \
+}
+
+static const struct iio_chan_spec qmc5883l_channels[] = {
+	QMC5883L_CHANNEL(X, 0),
+	QMC5883L_CHANNEL(Y, 1),
+	QMC5883L_CHANNEL(Z, 2),
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
+		.scan_index = -1,
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
+static int qmc5883l_init(struct qmc5883l_data *data)
+{
+	int ret;
+	u8 chip_id;
+	unsigned int chip_id_tmp;
+	unsigned int ctrl1;
+
+	ret = regmap_read(data->regmap, QMC5883L_CHIP_ID_REG, &chip_id_tmp);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Failed to read chip ID\n");
+		return ret;
+	}
+
+	chip_id = (u8)chip_id_tmp;
+	if (chip_id != QMC5883L_CHIP_ID) {
+		dev_err(&data->client->dev, "Invalid chip ID: 0x%02X (expected 0x%02X)\n",
+			chip_id, QMC5883L_CHIP_ID);
+		return -ENODEV;
+	}
+
+	mutex_lock(&data->lock);
+	ret = regmap_write(data->regmap, QMC5883L_FBR_REG, 0x01);
+	if (ret < 0)
+		goto unlock;
+
+	ctrl1 = (QMC5883L_OSR_64 << QMC5883L_OSR_SHIFT) |
+		(QMC5883L_RNG_2G << QMC5883L_RNG_SHIFT) |
+		(QMC5883L_ODR_50HZ << QMC5883L_ODR_SHIFT) |
+		(QMC5883L_MODE_STANDBY << QMC5883L_MODE_SHIFT);
+
+	ret = regmap_write(data->regmap, QMC5883L_CONTROL_REG_1, ctrl1);
+	if (ret < 0)
+		goto unlock;
+
+	mutex_unlock(&data->lock);
+	dev_dbg(&data->client->dev,
+		"Initialized with OSR=64, RNG=2G, ODR=50Hz, Mode=Standby\n");
+	return 0;
+
+unlock:
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
+static const struct iio_info qmc5883l_info = {
+	.read_raw = &qmc5883l_read_raw,
+};
+
+static const unsigned long qmc5883l_scan_masks[] = {0x7, 0};
+
+static int qmc5883l_probe(struct i2c_client *client)
+{
+	struct regmap *regmap;
+	struct qmc5883l_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	regmap = devm_regmap_init_i2c(client, &qmc5883l_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "Failed to initialize regmap\n");
+		return PTR_ERR(regmap);
+	}
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev) {
+		dev_err(&client->dev, "Failed to allocate iio device\n");
+		return -ENOMEM;
+	}
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+	data->regmap = regmap;
+	mutex_init(&data->lock);
+
+	indio_dev->name = "qmc5883l";
+	indio_dev->info = &qmc5883l_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = qmc5883l_channels;
+	indio_dev->num_channels = ARRAY_SIZE(qmc5883l_channels);
+	indio_dev->available_scan_masks = qmc5883l_scan_masks;
+
+	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
+					      NULL, &qmc5883l_trigger_handler,
+					      &qmc5883l_buffer_setup_ops);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to setup triggered buffer: %d\n", ret);
+		return ret;
+	}
+
+	ret = qmc5883l_init(data);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to initialize device: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_iio_device_register(&client->dev, indio_dev);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to register IIO device: %d\n", ret);
+		return ret;
+	}
+
+	i2c_set_clientdata(client, indio_dev);
+	return 0;
+}
+
+static const struct i2c_device_id qmc5883l_id[] = {
+	{ "qmc5883l", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, qmc5883l_id);
+
+static const struct of_device_id qmc5883l_of_match[] = {
+	{ .compatible = "qst,qmc5883l" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, qmc5883l_of_match);
+
+static struct i2c_driver qmc5883l_driver = {
+	.driver = {
+		.name = "qmc5883l",
+		.of_match_table = qmc5883l_of_match,
+	},
+	.id_table = qmc5883l_id,
+	.probe = qmc5883l_probe,
+};
+
+module_i2c_driver(qmc5883l_driver);
+
+MODULE_AUTHOR("Brajesh Patil <brajeshpatil11@gmail.com>");
+MODULE_DESCRIPTION("QMC5883L Driver");
+MODULE_LICENSE("GPL");
+
-- 
2.39.5


