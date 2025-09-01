Return-Path: <linux-iio+bounces-23623-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DFAB3EF09
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 21:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD968486239
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 19:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7519426CE0C;
	Mon,  1 Sep 2025 19:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="s2GmO+iR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7460225402;
	Mon,  1 Sep 2025 19:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756756511; cv=none; b=Qau1fsBE4Sw0vrwup1Ehybv2XBF1VfN9W7+BYmNcnvZxy/wVD3YH7lOpDK9IqGx6s24xa6FRjJhYiYr+6hmnB9QE8Qn7s27+O+2dcoJkJ3ZxSzsD4jFBfkA2UplGfd53bQsvKCF8OGveLT6X62hZB0wlDvIR0D5AJafqQ3PW1W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756756511; c=relaxed/simple;
	bh=HxLnuwlpIvhxBUkcMu9dmGedl2oDpN1v3IY49t+ADuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AXE1w9vODtsxvgaKjT5Cshr99GbdJbRXss/irBSDE+FGMn+gfev71FQSUCdrrL5lepPK3eRLMH0S2dLaMpSuHhf5a2ZK7MELUzFKO33ec6V3uXz4EAB1Ze4DNQCFwqPD3ySXvRFQtvEa/YymJwuHJORaddnYMuQXEoCBotLjHc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=s2GmO+iR; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [IPv6:2a02:2f0e:3503:4a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 08617173BEA;
	Mon, 01 Sep 2025 22:47:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1756756075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKpdVryC7+viduYUhoamo/u5TejWB2/LQJTHiVSdYAw=;
	b=s2GmO+iRqL6NRkt6I9Q0ePO+Ffd5qHsTUxoQyADJxFkdpLDyrnCJod1Bg7NFwBNWyQuHnR
	3MjZjZfyHLfXcfMmLVY36B9qQKUqf+Z/EimQZVonnD42cLtxiIKcQOcb5gy2MS//FaW9iw
	NN2Xka2txJxixPZjDgBtvVpeBpI6CiT9RnW3VhRumBXElwbXZLzDVxr/32EgDcY2Pew44d
	8Wlvvmu+v74D/secBE1qUPpTLOd/bIVJ5LmE46l5+QuxKDltE8nheJUBHLTjw3XgPe7M3Y
	LtcL9tBFr2Uz5hk6f6ilREDEuFg5dzo/9o558ja8HYqbuoK6k/0VkxNPSwCGiQ==
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH 02/10] iio: accel: BMA220 split original spi driver
Date: Mon,  1 Sep 2025 22:47:28 +0300
Message-ID: <20250901194742.11599-3-petre.rodan@subdimension.ro>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250901194742.11599-1-petre.rodan@subdimension.ro>
References: <20250901194742.11599-1-petre.rodan@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split original driver from bma220_spi.c into bma220_core.c and bma220.h
with a minimal number of changes in preparation for the next patches.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 drivers/iio/accel/Kconfig       |   9 +-
 drivers/iio/accel/Makefile      |   3 +-
 drivers/iio/accel/bma220.h      |  17 ++
 drivers/iio/accel/bma220_core.c | 310 ++++++++++++++++++++++++++++++++
 drivers/iio/accel/bma220_spi.c  | 309 ++-----------------------------
 5 files changed, 354 insertions(+), 294 deletions(-)
 create mode 100644 drivers/iio/accel/bma220.h
 create mode 100644 drivers/iio/accel/bma220_core.c

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 8c3f7cf55d5f..2cc3075e2688 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -218,15 +218,20 @@ config BMA180

 config BMA220
 	tristate "Bosch BMA220 3-Axis Accelerometer Driver"
-	depends on SPI
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
+	select BMA220_SPI if SPI
 	help
 	  Say yes here to add support for the Bosch BMA220 triaxial
 	  acceleration sensor.

 	  To compile this driver as a module, choose M here: the
-	  module will be called bma220_spi.
+	  module will be called bma220_core and you will also get
+	  bma220_spi if SPI is enabled.
+
+config BMA220_SPI
+	tristate
+	depends on BMA220

 config BMA400
 	tristate "Bosch BMA400 3-Axis Accelerometer Driver"
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index ca8569e25aba..56a9f848f7f9 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -25,7 +25,8 @@ obj-$(CONFIG_ADXL380) += adxl380.o
 obj-$(CONFIG_ADXL380_I2C) += adxl380_i2c.o
 obj-$(CONFIG_ADXL380_SPI) += adxl380_spi.o
 obj-$(CONFIG_BMA180) += bma180.o
-obj-$(CONFIG_BMA220) += bma220_spi.o
+obj-$(CONFIG_BMA220) += bma220_core.o
+obj-$(CONFIG_BMA220_SPI) += bma220_spi.o
 obj-$(CONFIG_BMA400) += bma400_core.o
 obj-$(CONFIG_BMA400_I2C) += bma400_i2c.o
 obj-$(CONFIG_BMA400_SPI) += bma400_spi.o
diff --git a/drivers/iio/accel/bma220.h b/drivers/iio/accel/bma220.h
new file mode 100644
index 000000000000..0606cf478f5f
--- /dev/null
+++ b/drivers/iio/accel/bma220.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Forward declarations needed by the bma220 sources.
+ *
+ * Copyright 2025 Petre Rodan <petre.rodan@subdimension.ro>
+ */
+
+#ifndef _BMA220_H
+#define _BMA220_H
+
+#include <linux/iio/iio.h>
+
+extern const struct dev_pm_ops bma220_pm_ops;
+
+int bma220_common_probe(struct spi_device *dev);
+
+#endif
diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
new file mode 100644
index 000000000000..60fd35637d2d
--- /dev/null
+++ b/drivers/iio/accel/bma220_core.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * BMA220 Digital triaxial acceleration sensor driver
+ *
+ * Copyright (c) 2016,2020 Intel Corporation.
+ */
+
+#include <linux/bits.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/spi/spi.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#define BMA220_REG_ID				0x00
+#define BMA220_REG_ACCEL_X			0x02
+#define BMA220_REG_ACCEL_Y			0x03
+#define BMA220_REG_ACCEL_Z			0x04
+#define BMA220_REG_RANGE			0x11
+#define BMA220_REG_SUSPEND			0x18
+
+#define BMA220_CHIP_ID				0xDD
+#define BMA220_READ_MASK			BIT(7)
+#define BMA220_RANGE_MASK			GENMASK(1, 0)
+#define BMA220_SUSPEND_SLEEP			0xFF
+#define BMA220_SUSPEND_WAKE			0x00
+
+#define BMA220_DEVICE_NAME			"bma220"
+
+#define BMA220_ACCEL_CHANNEL(index, reg, axis) {			\
+	.type = IIO_ACCEL,						\
+	.address = reg,							\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.scan_index = index,						\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 6,						\
+		.storagebits = 8,					\
+		.shift = 2,						\
+		.endianness = IIO_CPU,					\
+	},								\
+}
+
+enum bma220_axis {
+	AXIS_X,
+	AXIS_Y,
+	AXIS_Z,
+};
+
+static const int bma220_scale_table[][2] = {
+	{0, 623000}, {1, 248000}, {2, 491000}, {4, 983000},
+};
+
+struct bma220_data {
+	struct spi_device *spi_device;
+	struct mutex lock;
+	struct {
+		s8 chans[3];
+		/* Ensure timestamp is naturally aligned. */
+		aligned_s64 timestamp;
+	} scan;
+	u8 tx_buf[2] __aligned(IIO_DMA_MINALIGN);
+};
+
+static const struct iio_chan_spec bma220_channels[] = {
+	BMA220_ACCEL_CHANNEL(0, BMA220_REG_ACCEL_X, X),
+	BMA220_ACCEL_CHANNEL(1, BMA220_REG_ACCEL_Y, Y),
+	BMA220_ACCEL_CHANNEL(2, BMA220_REG_ACCEL_Z, Z),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
+static inline int bma220_read_reg(struct spi_device *spi, u8 reg)
+{
+	return spi_w8r8(spi, reg | BMA220_READ_MASK);
+}
+
+static const unsigned long bma220_accel_scan_masks[] = {
+	BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
+	0
+};
+
+static irqreturn_t bma220_trigger_handler(int irq, void *p)
+{
+	int ret;
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct bma220_data *data = iio_priv(indio_dev);
+	struct spi_device *spi = data->spi_device;
+
+	mutex_lock(&data->lock);
+	data->tx_buf[0] = BMA220_REG_ACCEL_X | BMA220_READ_MASK;
+	ret = spi_write_then_read(spi, data->tx_buf, 1, &data->scan.chans,
+				  ARRAY_SIZE(bma220_channels) - 1);
+	if (ret < 0)
+		goto err;
+
+	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
+				    pf->timestamp);
+err:
+	mutex_unlock(&data->lock);
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int bma220_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	int ret;
+	u8 range_idx;
+	struct bma220_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = bma220_read_reg(data->spi_device, chan->address);
+		if (ret < 0)
+			return -EINVAL;
+		*val = sign_extend32(ret >> chan->scan_type.shift,
+				     chan->scan_type.realbits - 1);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		ret = bma220_read_reg(data->spi_device, BMA220_REG_RANGE);
+		if (ret < 0)
+			return ret;
+		range_idx = ret & BMA220_RANGE_MASK;
+		*val = bma220_scale_table[range_idx][0];
+		*val2 = bma220_scale_table[range_idx][1];
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+
+	return -EINVAL;
+}
+
+static int bma220_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	int i;
+	int ret;
+	int index = -1;
+	struct bma220_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		for (i = 0; i < ARRAY_SIZE(bma220_scale_table); i++)
+			if (val == bma220_scale_table[i][0] &&
+			    val2 == bma220_scale_table[i][1]) {
+				index = i;
+				break;
+			}
+		if (index < 0)
+			return -EINVAL;
+
+		mutex_lock(&data->lock);
+		data->tx_buf[0] = BMA220_REG_RANGE;
+		data->tx_buf[1] = index;
+		ret = spi_write(data->spi_device, data->tx_buf,
+				sizeof(data->tx_buf));
+		if (ret < 0)
+			dev_err(&data->spi_device->dev,
+				"failed to set measurement range\n");
+		mutex_unlock(&data->lock);
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int bma220_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (int *)bma220_scale_table;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*length = ARRAY_SIZE(bma220_scale_table) * 2;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info bma220_info = {
+	.read_raw		= bma220_read_raw,
+	.write_raw		= bma220_write_raw,
+	.read_avail		= bma220_read_avail,
+};
+
+static int bma220_init(struct spi_device *spi)
+{
+	int ret;
+
+	ret = bma220_read_reg(spi, BMA220_REG_ID);
+	if (ret != BMA220_CHIP_ID)
+		return -ENODEV;
+
+	/* Make sure the chip is powered on */
+	ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
+	if (ret == BMA220_SUSPEND_WAKE)
+		ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
+	if (ret < 0)
+		return ret;
+	if (ret == BMA220_SUSPEND_WAKE)
+		return -EBUSY;
+
+	return 0;
+}
+
+static int bma220_power(struct spi_device *spi, bool up)
+{
+	int i, ret;
+
+	/**
+	 * The chip can be suspended/woken up by a simple register read.
+	 * So, we need up to 2 register reads of the suspend register
+	 * to make sure that the device is in the desired state.
+	 */
+	for (i = 0; i < 2; i++) {
+		ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
+		if (ret < 0)
+			return ret;
+
+		if (up && ret == BMA220_SUSPEND_SLEEP)
+			return 0;
+
+		if (!up && ret == BMA220_SUSPEND_WAKE)
+			return 0;
+	}
+
+	return -EBUSY;
+}
+
+static void bma220_deinit(void *spi)
+{
+	bma220_power(spi, false);
+}
+
+int bma220_common_probe(struct spi_device *spi)
+{
+	int ret;
+	struct iio_dev *indio_dev;
+	struct bma220_data *data;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->spi_device = spi;
+	mutex_init(&data->lock);
+
+	indio_dev->info = &bma220_info;
+	indio_dev->name = BMA220_DEVICE_NAME;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = bma220_channels;
+	indio_dev->num_channels = ARRAY_SIZE(bma220_channels);
+	indio_dev->available_scan_masks = bma220_accel_scan_masks;
+
+	ret = bma220_init(data->spi_device);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&spi->dev, bma220_deinit, spi);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      bma220_trigger_handler, NULL);
+	if (ret < 0) {
+		dev_err(&spi->dev, "iio triggered buffer setup failed\n");
+		return ret;
+	}
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+EXPORT_SYMBOL_NS(bma220_common_probe, "IIO_BOSCH_BMA220");
+
+static int bma220_suspend(struct device *dev)
+{
+	struct spi_device *spi = to_spi_device(dev);
+
+	return bma220_power(spi, false);
+}
+
+static int bma220_resume(struct device *dev)
+{
+	struct spi_device *spi = to_spi_device(dev);
+
+	return bma220_power(spi, true);
+}
+EXPORT_NS_SIMPLE_DEV_PM_OPS(bma220_pm_ops, bma220_suspend, bma220_resume,
+			    IIO_BOSCH_BMA220);
+
+MODULE_AUTHOR("Tiberiu Breana <tiberiu.a.breana@intel.com>");
+MODULE_DESCRIPTION("BMA220 acceleration sensor driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index 01592eebf05b..be8348ad0a93 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -5,8 +5,8 @@
  * Copyright (c) 2016,2020 Intel Corporation.
  */

-#include <linux/bits.h>
-#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/errno.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/types.h>
@@ -14,295 +14,14 @@

 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
-#include <linux/iio/trigger_consumer.h>
-#include <linux/iio/triggered_buffer.h>

-#define BMA220_REG_ID				0x00
-#define BMA220_REG_ACCEL_X			0x02
-#define BMA220_REG_ACCEL_Y			0x03
-#define BMA220_REG_ACCEL_Z			0x04
-#define BMA220_REG_RANGE			0x11
-#define BMA220_REG_SUSPEND			0x18
+#include "bma220.h"

-#define BMA220_CHIP_ID				0xDD
-#define BMA220_READ_MASK			BIT(7)
-#define BMA220_RANGE_MASK			GENMASK(1, 0)
-#define BMA220_SUSPEND_SLEEP			0xFF
-#define BMA220_SUSPEND_WAKE			0x00
-
-#define BMA220_DEVICE_NAME			"bma220"
-
-#define BMA220_ACCEL_CHANNEL(index, reg, axis) {			\
-	.type = IIO_ACCEL,						\
-	.address = reg,							\
-	.modified = 1,							\
-	.channel2 = IIO_MOD_##axis,					\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
-	.scan_index = index,						\
-	.scan_type = {							\
-		.sign = 's',						\
-		.realbits = 6,						\
-		.storagebits = 8,					\
-		.shift = 2,						\
-		.endianness = IIO_CPU,					\
-	},								\
-}
-
-enum bma220_axis {
-	AXIS_X,
-	AXIS_Y,
-	AXIS_Z,
-};
-
-static const int bma220_scale_table[][2] = {
-	{0, 623000}, {1, 248000}, {2, 491000}, {4, 983000},
-};
-
-struct bma220_data {
-	struct spi_device *spi_device;
-	struct mutex lock;
-	struct {
-		s8 chans[3];
-		/* Ensure timestamp is naturally aligned. */
-		aligned_s64 timestamp;
-	} scan;
-	u8 tx_buf[2] __aligned(IIO_DMA_MINALIGN);
-};
-
-static const struct iio_chan_spec bma220_channels[] = {
-	BMA220_ACCEL_CHANNEL(0, BMA220_REG_ACCEL_X, X),
-	BMA220_ACCEL_CHANNEL(1, BMA220_REG_ACCEL_Y, Y),
-	BMA220_ACCEL_CHANNEL(2, BMA220_REG_ACCEL_Z, Z),
-	IIO_CHAN_SOFT_TIMESTAMP(3),
-};
-
-static inline int bma220_read_reg(struct spi_device *spi, u8 reg)
-{
-	return spi_w8r8(spi, reg | BMA220_READ_MASK);
-}
-
-static const unsigned long bma220_accel_scan_masks[] = {
-	BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
-	0
-};
-
-static irqreturn_t bma220_trigger_handler(int irq, void *p)
-{
-	int ret;
-	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->indio_dev;
-	struct bma220_data *data = iio_priv(indio_dev);
-	struct spi_device *spi = data->spi_device;
-
-	mutex_lock(&data->lock);
-	data->tx_buf[0] = BMA220_REG_ACCEL_X | BMA220_READ_MASK;
-	ret = spi_write_then_read(spi, data->tx_buf, 1, &data->scan.chans,
-				  ARRAY_SIZE(bma220_channels) - 1);
-	if (ret < 0)
-		goto err;
-
-	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
-				    pf->timestamp);
-err:
-	mutex_unlock(&data->lock);
-	iio_trigger_notify_done(indio_dev->trig);
-
-	return IRQ_HANDLED;
-}
-
-static int bma220_read_raw(struct iio_dev *indio_dev,
-			   struct iio_chan_spec const *chan,
-			   int *val, int *val2, long mask)
-{
-	int ret;
-	u8 range_idx;
-	struct bma220_data *data = iio_priv(indio_dev);
-
-	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
-		ret = bma220_read_reg(data->spi_device, chan->address);
-		if (ret < 0)
-			return -EINVAL;
-		*val = sign_extend32(ret >> chan->scan_type.shift,
-				     chan->scan_type.realbits - 1);
-		return IIO_VAL_INT;
-	case IIO_CHAN_INFO_SCALE:
-		ret = bma220_read_reg(data->spi_device, BMA220_REG_RANGE);
-		if (ret < 0)
-			return ret;
-		range_idx = ret & BMA220_RANGE_MASK;
-		*val = bma220_scale_table[range_idx][0];
-		*val2 = bma220_scale_table[range_idx][1];
-		return IIO_VAL_INT_PLUS_MICRO;
-	}
-
-	return -EINVAL;
-}
-
-static int bma220_write_raw(struct iio_dev *indio_dev,
-			    struct iio_chan_spec const *chan,
-			    int val, int val2, long mask)
-{
-	int i;
-	int ret;
-	int index = -1;
-	struct bma220_data *data = iio_priv(indio_dev);
-
-	switch (mask) {
-	case IIO_CHAN_INFO_SCALE:
-		for (i = 0; i < ARRAY_SIZE(bma220_scale_table); i++)
-			if (val == bma220_scale_table[i][0] &&
-			    val2 == bma220_scale_table[i][1]) {
-				index = i;
-				break;
-			}
-		if (index < 0)
-			return -EINVAL;
-
-		mutex_lock(&data->lock);
-		data->tx_buf[0] = BMA220_REG_RANGE;
-		data->tx_buf[1] = index;
-		ret = spi_write(data->spi_device, data->tx_buf,
-				sizeof(data->tx_buf));
-		if (ret < 0)
-			dev_err(&data->spi_device->dev,
-				"failed to set measurement range\n");
-		mutex_unlock(&data->lock);
-
-		return 0;
-	}
-
-	return -EINVAL;
-}
-
-static int bma220_read_avail(struct iio_dev *indio_dev,
-			     struct iio_chan_spec const *chan,
-			     const int **vals, int *type, int *length,
-			     long mask)
-{
-	switch (mask) {
-	case IIO_CHAN_INFO_SCALE:
-		*vals = (int *)bma220_scale_table;
-		*type = IIO_VAL_INT_PLUS_MICRO;
-		*length = ARRAY_SIZE(bma220_scale_table) * 2;
-		return IIO_AVAIL_LIST;
-	default:
-		return -EINVAL;
-	}
-}
-
-static const struct iio_info bma220_info = {
-	.read_raw		= bma220_read_raw,
-	.write_raw		= bma220_write_raw,
-	.read_avail		= bma220_read_avail,
-};
-
-static int bma220_init(struct spi_device *spi)
+static int bma220_spi_probe(struct spi_device *spi)
 {
-	int ret;
-
-	ret = bma220_read_reg(spi, BMA220_REG_ID);
-	if (ret != BMA220_CHIP_ID)
-		return -ENODEV;
-
-	/* Make sure the chip is powered on */
-	ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
-	if (ret == BMA220_SUSPEND_WAKE)
-		ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
-	if (ret < 0)
-		return ret;
-	if (ret == BMA220_SUSPEND_WAKE)
-		return -EBUSY;
-
-	return 0;
+	return bma220_common_probe(spi);
 }

-static int bma220_power(struct spi_device *spi, bool up)
-{
-	int i, ret;
-
-	/**
-	 * The chip can be suspended/woken up by a simple register read.
-	 * So, we need up to 2 register reads of the suspend register
-	 * to make sure that the device is in the desired state.
-	 */
-	for (i = 0; i < 2; i++) {
-		ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
-		if (ret < 0)
-			return ret;
-
-		if (up && ret == BMA220_SUSPEND_SLEEP)
-			return 0;
-
-		if (!up && ret == BMA220_SUSPEND_WAKE)
-			return 0;
-	}
-
-	return -EBUSY;
-}
-
-static void bma220_deinit(void *spi)
-{
-	bma220_power(spi, false);
-}
-
-static int bma220_probe(struct spi_device *spi)
-{
-	int ret;
-	struct iio_dev *indio_dev;
-	struct bma220_data *data;
-
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
-	if (!indio_dev)
-		return -ENOMEM;
-
-	data = iio_priv(indio_dev);
-	data->spi_device = spi;
-	mutex_init(&data->lock);
-
-	indio_dev->info = &bma220_info;
-	indio_dev->name = BMA220_DEVICE_NAME;
-	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->channels = bma220_channels;
-	indio_dev->num_channels = ARRAY_SIZE(bma220_channels);
-	indio_dev->available_scan_masks = bma220_accel_scan_masks;
-
-	ret = bma220_init(data->spi_device);
-	if (ret)
-		return ret;
-
-	ret = devm_add_action_or_reset(&spi->dev, bma220_deinit, spi);
-	if (ret)
-		return ret;
-
-	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
-					      iio_pollfunc_store_time,
-					      bma220_trigger_handler, NULL);
-	if (ret < 0) {
-		dev_err(&spi->dev, "iio triggered buffer setup failed\n");
-		return ret;
-	}
-
-	return devm_iio_device_register(&spi->dev, indio_dev);
-}
-
-static int bma220_suspend(struct device *dev)
-{
-	struct spi_device *spi = to_spi_device(dev);
-
-	return bma220_power(spi, false);
-}
-
-static int bma220_resume(struct device *dev)
-{
-	struct spi_device *spi = to_spi_device(dev);
-
-	return bma220_power(spi, true);
-}
-static DEFINE_SIMPLE_DEV_PM_OPS(bma220_pm_ops, bma220_suspend, bma220_resume);
-
 static const struct spi_device_id bma220_spi_id[] = {
 	{"bma220", 0},
 	{ }
@@ -314,17 +33,25 @@ static const struct acpi_device_id bma220_acpi_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, bma220_spi_id);

-static struct spi_driver bma220_driver = {
+static const struct of_device_id bma220_of_spi_match[] = {
+	{ .compatible = "bosch,bma220" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bma220_of_spi_match);
+
+static struct spi_driver bma220_spi_driver = {
 	.driver = {
 		.name = "bma220_spi",
 		.pm = pm_sleep_ptr(&bma220_pm_ops),
+		.of_match_table = bma220_of_spi_match,
 		.acpi_match_table = bma220_acpi_id,
 	},
-	.probe =            bma220_probe,
+	.probe =            bma220_spi_probe,
 	.id_table =         bma220_spi_id,
 };
-module_spi_driver(bma220_driver);
+module_spi_driver(bma220_spi_driver);

 MODULE_AUTHOR("Tiberiu Breana <tiberiu.a.breana@intel.com>");
-MODULE_DESCRIPTION("BMA220 acceleration sensor driver");
-MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("BMA220 triaxial acceleration sensor spi driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_BOSCH_BMA220");
--
2.49.1


