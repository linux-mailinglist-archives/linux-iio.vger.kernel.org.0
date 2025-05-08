Return-Path: <linux-iio+bounces-19288-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FEDAAF961
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 14:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A8439E2211
	for <lists+linux-iio@lfdr.de>; Thu,  8 May 2025 12:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022F02253AB;
	Thu,  8 May 2025 12:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4bbIlY/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9426223DE8;
	Thu,  8 May 2025 12:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746706149; cv=none; b=MekRknvXvo06tC2RgdBqowGl6D52Bp5LNylBkx92lrRkLk4z8oyGOGX0Y3fNZuJGUEp7JIjqrM737pMxt8/6xA41PvPR507SikXbVgg5Gr4IIQN+KFYxaq5kd9O2tLu4aku0QkIp7/fuCkj+1uekM3DGyW5nU3El+vuK5SBPxO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746706149; c=relaxed/simple;
	bh=Csz/OGaAcwb9SHXCJ/jwGCcg4+KucSAHSQv6Jhy3EJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=TR1Xq5i0YwisTPWxsQ65utV15h2vGLPFNdcTqMsc97fkv6doL4fy9K1K+7EuwIWYmhH7LzVgoSIdRG7KQh8jpzvXn6EwcTJnRE0wqyhvIqqUV8oWMLwz42HeYHdfbeSXcQoH+tJE2r0TGqlwJ9qGmIKNC+nuSM+3IIlHh+2fAGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4bbIlY/; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-736c062b1f5so972326b3a.0;
        Thu, 08 May 2025 05:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746706147; x=1747310947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PJPXuFuCD0iiDdigOASxSwSMcUG10mZEHAbIqetNzME=;
        b=E4bbIlY/sN6SB8ksqI1sAC0I3YsyGC1dC/UfYKvTgEcSqfZVnotkkiarl920GIxqbY
         W6OBtgUsClFnNDx4fGTTR0YnmoMIvCtppIktzoayJ+yem2+czxoMlxeX1JfzmAiAsVxU
         eoTp5HhTdX73RjkCSfiATxMaBKWFUIAq5OR0eXXpS/5iMmTXIc5t16c6v5ccA5JnH33X
         iYZAqXK5DKOnVnRf4CH32Ow76yfYGGR8YY5QQfeHFVFpvWoDTy/hXrlgXD9JRn/K9TMH
         X6VJ70oBc105UZNKJdAMgEXA8JI3ySJz/cSZnAsduDLeLA54evh4NuQphb3ldKsckNqp
         w/mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746706147; x=1747310947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PJPXuFuCD0iiDdigOASxSwSMcUG10mZEHAbIqetNzME=;
        b=sZjO/d/00JBQbGBxYGzmuglO6UQY5Yo9u7ECLR7eu4GPJYPs0sXPFW8WkSdM4v4iew
         xOS8ybTB+uyPC7644Y1iop31o7ejwxn22sTyt+vg8GiwTrgXFdTr+0ZkXgK0olTsfjOv
         kZGQXLRHeJOdqrz5aqYVKYnewPpHlPy9PsQ+hdZQC9uzc4t4McCTJT1XQ96mt13RuyDb
         PX2Lgmc4uhUfgvBiQ5sei+xoIWM/V8TS/eub6JiYKIlTMfz1XeWWBrRep1Fkx7J7Kga+
         8UCnad5H5+0HSz+q8N03rU6XRQEKU0G/o6FuycQPgwRTVOmtAxIlXI69pvYVxt7TMFJs
         I3iA==
X-Forwarded-Encrypted: i=1; AJvYcCUdirJtTfyN/ZZqBTdigqjwlFojmYw8ERRFymmIA9u52f1JT9t++P9cAy9mlvkPErDfejKQS+QLvh/OIbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOYm28eKoVX0yjO4QEJ655r3BiVUBNe+UzQf1IfoZdeZBHs9je
	hLfY3wF+1ydO7n8bn29gM0hX+oV1NbBiMsRE4s4zhPuc6C5LYDN1
X-Gm-Gg: ASbGncvBKVbA84veLsc5hxY3kfB/O/CU1JHEWzz6xaYJ3Ts+frL5TxGUvgF6oTrnjKe
	hYlclkTOrguRa7FKzWafc4udG+6zGEL6DbN8NUSe0f7pjS6Ox7P5+EF8ihKIXcP0UBk7yi3XhLp
	HrEx9jXERN9HHfjfpUukxup5bWDNgQl3ZKD3pmXMMFeviHtdZFHP6Ku5+vIh8OiFvF8K25/mux5
	la/2NkVVemDCfKPfFh59TBPJC+tTIm719d6/N6s28gm4/Ef292DcrxDboEvb6TCYE6eGI0ZRXzF
	0JeRYzdvsKThVjakT7V2DETdYucXKYyvNf+bNHewqrvTmI8Fs8LliKZcg1x1AduhZewp8+w=
X-Google-Smtp-Source: AGHT+IHZTtsWPIEAXH7ZyHjE0Zapo6dVGRkAUHHH3nbCsVkgBsnPTRzY5jpewmrOktehnTb6zntD/g==
X-Received: by 2002:a05:6a21:9016:b0:1f3:1d13:96b3 with SMTP id adf61e73a8af0-2159af285a9mr3805953637.5.1746706146911;
        Thu, 08 May 2025 05:09:06 -0700 (PDT)
Received: from localhost.localdomain ([103.205.130.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058d7a20bsm13503134b3a.10.2025.05.08.05.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 05:09:06 -0700 (PDT)
From: Brajesh Patil <brajeshpatil11@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt1@gmail.com,
	dlechner@baylibre.com,
	Brajesh Patil <brajeshpatil11@gmail.com>
Subject: [PATCH v2 3/5] iio: magnetometer: qmc5883l: Add initial driver support
Date: Thu,  8 May 2025 13:08:58 +0100
Message-Id: <20250508120900.114348-1-brajeshpatil11@gmail.com>
X-Mailer: git-send-email 2.39.5
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
 drivers/iio/magnetometer/Kconfig    |  13 +
 drivers/iio/magnetometer/Makefile   |   2 +
 drivers/iio/magnetometer/qmc5883l.c | 471 ++++++++++++++++++++++++++++
 3 files changed, 486 insertions(+)
 create mode 100644 drivers/iio/magnetometer/qmc5883l.c

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 3debf1320ad1..97f375c75ff8 100644
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
+	  through its I2C interface.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called qmc5883l.
+
 config SENSORS_RM3100
 	tristate
 	select IIO_BUFFER
diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
index 9297723a97d8..f51e7595f5e3 100644
--- a/drivers/iio/magnetometer/Makefile
+++ b/drivers/iio/magnetometer/Makefile
@@ -27,6 +27,8 @@ obj-$(CONFIG_SENSORS_HMC5843)		+= hmc5843_core.o
 obj-$(CONFIG_SENSORS_HMC5843_I2C)	+= hmc5843_i2c.o
 obj-$(CONFIG_SENSORS_HMC5843_SPI)	+= hmc5843_spi.o

+obj-$(CONFIG_SENSORS_QMC5883L)		+= qmc5883l.c
+
 obj-$(CONFIG_SENSORS_RM3100)		+= rm3100-core.o
 obj-$(CONFIG_SENSORS_RM3100_I2C)	+= rm3100-i2c.o
 obj-$(CONFIG_SENSORS_RM3100_SPI)	+= rm3100-spi.o
diff --git a/drivers/iio/magnetometer/qmc5883l.c b/drivers/iio/magnetometer/qmc5883l.c
new file mode 100644
index 000000000000..68597cdd0ca8
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
+	struct mutex lock; /* Protects sensor read/write operations */
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


