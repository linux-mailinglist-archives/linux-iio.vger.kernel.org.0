Return-Path: <linux-iio+bounces-23622-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27341B3EF07
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 21:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF49A2C1091
	for <lists+linux-iio@lfdr.de>; Mon,  1 Sep 2025 19:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCD326A1B6;
	Mon,  1 Sep 2025 19:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="anZilxAG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D737D32F76C;
	Mon,  1 Sep 2025 19:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756756511; cv=none; b=jLQtcWSEq8S5qfabh2GLRy4luAoP6rypYC1cMbLBEoo/2RMGH82qH6Dr0lOxylgpYzYRzag/F+IZd05jXWkw1bT8AzoHvUGvdLSDiXCBW9ZYsjGTbfL649w7X6r2I1yVHEXhaY6nTeHGqQw09b9DwcxX3QODDK6xI3+yIxpY2SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756756511; c=relaxed/simple;
	bh=G1WjPdsugVOgEk+OX4im96JVnrA/SLcGoEuuE/qOURU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpNKYXIJe1XDYTmCF3OFbR7xXpO9Ms9L33IzR+5L8fNKTRa4/XrFer/ridlW13scMr8QImwsB5cBX/0dVDgLksG6XLDoKOKipJVgkff52pk9cmRbpsQuGr0mdb11hXKsxDs2bIfzp5HYoB8jQ2XffqnZZCme/uEkPUrqzuN8BHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=anZilxAG; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from localhost.localdomain (unknown [IPv6:2a02:2f0e:3503:4a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 93251173BEB;
	Mon, 01 Sep 2025 22:47:55 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1756756075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QxV2feckogM6L0+/fBWV7fSTSoPnrkAPSEcYxMpb1kQ=;
	b=anZilxAGRpL6K8t0lFk1SZbmVpN5zgrxAnbDvK3CZbL4YAIWShJkZqQRWEVqYhXLNxKCN7
	AePNt4E2JkZ1PfONB1V2/3WewnaDEmy55UuSTIvdC48W2u3xC6UXEiO8+yriVjZKWWNwJc
	4XiTGyw05rTwDsYMBCs6na4fUa1mIDiY2bW0mh7xd41hkaYbZvOcazP5Z5q3FRBgqJDK9j
	PkNTx56A5yEpKE8SlVc7+LF7YoeuypS9bdwjeHPF66E8B2AcO5OLBDGyB5xN0N+BS1a5r6
	0pj/p3m4ecj4qxRVao8/y5Zti4D37GHiTez9bJ2ZfqLvCbbl3tIeGop1QaOGYA==
From: Petre Rodan <petre.rodan@subdimension.ro>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Petre Rodan <petre.rodan@subdimension.ro>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH 03/10] iio: accel: BMA220 migrate to regmap API
Date: Mon,  1 Sep 2025 22:47:29 +0300
Message-ID: <20250901194742.11599-4-petre.rodan@subdimension.ro>
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

Switch to regmap API.

Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
---
 drivers/iio/accel/Kconfig       |   2 +
 drivers/iio/accel/bma220.h      |   5 +-
 drivers/iio/accel/bma220_core.c | 417 ++++++++++++++++++++++++++------
 drivers/iio/accel/bma220_spi.c  |  12 +-
 4 files changed, 354 insertions(+), 82 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 2cc3075e2688..9b6c35b75948 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -218,6 +218,7 @@ config BMA180

 config BMA220
 	tristate "Bosch BMA220 3-Axis Accelerometer Driver"
+	select REGMAP
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	select BMA220_SPI if SPI
@@ -231,6 +232,7 @@ config BMA220

 config BMA220_SPI
 	tristate
+	select REGMAP_SPI
 	depends on BMA220

 config BMA400
diff --git a/drivers/iio/accel/bma220.h b/drivers/iio/accel/bma220.h
index 0606cf478f5f..5eefa9749d33 100644
--- a/drivers/iio/accel/bma220.h
+++ b/drivers/iio/accel/bma220.h
@@ -8,10 +8,13 @@
 #ifndef _BMA220_H
 #define _BMA220_H

+#include <linux/regmap.h>
+
 #include <linux/iio/iio.h>

+extern const struct regmap_config bma220_spi_regmap_config;
 extern const struct dev_pm_ops bma220_pm_ops;

-int bma220_common_probe(struct spi_device *dev);
+int bma220_common_probe(struct device *dev, struct regmap *regmap, int irq);

 #endif
diff --git a/drivers/iio/accel/bma220_core.c b/drivers/iio/accel/bma220_core.c
index 60fd35637d2d..e6dac2e1cf4d 100644
--- a/drivers/iio/accel/bma220_core.c
+++ b/drivers/iio/accel/bma220_core.c
@@ -3,31 +3,133 @@
  * BMA220 Digital triaxial acceleration sensor driver
  *
  * Copyright (c) 2016,2020 Intel Corporation.
+ * Copyright (c) 2025 Petre Rodan  <petre.rodan@subdimension.ro>
  */

 #include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/cleanup.h>
+#include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/types.h>
-#include <linux/spi/spi.h>

-#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>

+#include "bma220.h"
+
+/*
+ * Read-Only Registers
+ */
+
+/* ID registers */
 #define BMA220_REG_ID				0x00
+#define BMA220_REG_REVISION_ID			0x01
+
+/* Acceleration registers */
 #define BMA220_REG_ACCEL_X			0x02
 #define BMA220_REG_ACCEL_Y			0x03
 #define BMA220_REG_ACCEL_Z			0x04
+
+/*
+ * Read-write configuration registers
+ */
+#define BMA220_REG_CONF0			0x05
+#define BMA220_HIGH_DUR_MSK			GENMASK(5, 0)
+#define BMA220_HIGH_HY_MSK			GENMASK(7, 6)
+#define BMA220_REG_CONF1			0x06
+#define BMA220_HIGH_TH_MSK			GENMASK(3, 0)
+#define BMA220_LOW_TH_MSK			GENMASK(7, 4)
+#define BMA220_REG_CONF2			0x07
+#define BMA220_LOW_DUR_MSK			GENMASK(5, 0)
+#define BMA220_LOW_HY_MSK			GENMASK(7, 6)
+#define BMA220_REG_CONF3			0x08
+#define BMA220_TT_DUR_MSK			GENMASK(2, 0)
+#define BMA220_TT_TH_MSK			GENMASK(6, 3)
+#define BMA220_TT_FILT_MSK			BIT(7)
+#define BMA220_REG_CONF4			0x09
+#define BMA220_SLOPE_DUR_MSK			GENMASK(1, 0)
+#define BMA220_SLOPE_TH_MSK			GENMASK(5, 2)
+#define BMA220_SLOPE_FILT_MSK			BIT(6)
+#define BMA220_ORIENT_EX_MSK			BIT(7)
+#define BMA220_REG_CONF5			0x0a
+#define BMA220_TT_SAMP_MSK			GENMASK(1, 0)
+#define BMA220_ORIENT_BLOCKING_MSK		GENMASK(3, 2)
+#define BMA220_TIP_EN_MSK			BIT(4)
+
+/*
+ * Read-only interrupt flags
+ */
+#define BMA220_REG_IF0				0x0b
+/* interrupt flags */
+#define BMA220_IF_HIGH_SIGN			BIT(0)
+#define BMA220_IF_HIGH_FIRST_Z			BIT(1)
+#define BMA220_IF_HIGH_FIRST_Y			BIT(2)
+#define BMA220_IF_HIGH_FIRST_X			BIT(3)
+#define BMA220_IF_ORIENT_INT			BIT(7)
+
+#define BMA220_REG_IF1				0x0c
+/* interrupt flags */
+#define BMA220_IF_SLOPE				BIT(0)
+#define BMA220_IF_DRDY				BIT(1)
+#define BMA220_IF_HIGH				BIT(2)
+#define BMA220_IF_LOW				BIT(3)
+#define BMA220_IF_TT				BIT(4)
+
+/*
+ * Read-write interrupt enable configuration registers
+ */
+#define BMA220_REG_IE0				0x0d
+#define BMA220_INT_EN_TAP_Z_MSK			BIT(0)
+#define BMA220_INT_EN_TAP_Y_MSK			BIT(1)
+#define BMA220_INT_EN_TAP_X_MSK			BIT(2)
+#define BMA220_INT_EN_SLOPE_Z_MSK		BIT(3)
+#define BMA220_INT_EN_SLOPE_Y_MSK		BIT(4)
+#define BMA220_INT_EN_SLOPE_X_MSK		BIT(5)
+#define BMA220_INT_EN_ORIENT_MSK		BIT(6)
+#define BMA220_INT_EN_DRDY_MSK			BIT(7)
+#define BMA220_REG_IE1				0x0e
+#define BMA220_INT_EN_HIGH_Z_MSK		BIT(0)
+#define BMA220_INT_EN_HIGH_Y_MSK		BIT(1)
+#define BMA220_INT_EN_HIGH_X_MSK		BIT(2)
+#define BMA220_INT_EN_LOW_MSK			BIT(3)
+#define BMA220_INT_LATCH_MSK			GENMASK(6, 4)
+#define BMA220_INT_LATCH_MAX			0x7
+#define BMA220_INT_RST_MSK			BIT(7)
+#define BMA220_INT_LATCH_LEN			8
+#define BMA220_REG_IE2				0x0f
+
+/*
+ * Read-write configuration registers
+ */
+#define BMA220_REG_FILTER			0x10
 #define BMA220_REG_RANGE			0x11
+#define BMA220_REG_WDT				0x17
+#define BMA220_WDT_MASK				GENMASK(2, 1)
+#define BMA220_WDT_OFF				0x0
+#define BMA220_WDT_1MS				BIT(1)
+#define BMA220_WDT_10MS				GENMASK(1, 0)
+/*
+ * Read-only state change registers
+ */
 #define BMA220_REG_SUSPEND			0x18
+#define BMA220_REG_SOFTRESET			0x19

 #define BMA220_CHIP_ID				0xDD
-#define BMA220_READ_MASK			BIT(7)
 #define BMA220_RANGE_MASK			GENMASK(1, 0)
+#define BMA220_FILTER_MASK			GENMASK(3, 0)
 #define BMA220_SUSPEND_SLEEP			0xFF
 #define BMA220_SUSPEND_WAKE			0x00

@@ -61,14 +163,16 @@ static const int bma220_scale_table[][2] = {
 };

 struct bma220_data {
-	struct spi_device *spi_device;
+	struct device *dev;
+	struct regmap *regmap;
 	struct mutex lock;
+	u8 range_idx;
+	struct iio_trigger *trig;
 	struct {
 		s8 chans[3];
 		/* Ensure timestamp is naturally aligned. */
 		aligned_s64 timestamp;
-	} scan;
-	u8 tx_buf[2] __aligned(IIO_DMA_MINALIGN);
+	} scan __aligned(IIO_DMA_MINALIGN);
 };

 static const struct iio_chan_spec bma220_channels[] = {
@@ -78,35 +182,81 @@ static const struct iio_chan_spec bma220_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };

-static inline int bma220_read_reg(struct spi_device *spi, u8 reg)
-{
-	return spi_w8r8(spi, reg | BMA220_READ_MASK);
-}
-
 static const unsigned long bma220_accel_scan_masks[] = {
 	BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
 	0
 };

+static bool bma220_is_writable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case BMA220_REG_CONF0:
+	case BMA220_REG_CONF1:
+	case BMA220_REG_CONF2:
+	case BMA220_REG_CONF3:
+	case BMA220_REG_CONF4:
+	case BMA220_REG_CONF5:
+	case BMA220_REG_IE0:
+	case BMA220_REG_IE1:
+	case BMA220_REG_IE2:
+	case BMA220_REG_FILTER:
+	case BMA220_REG_RANGE:
+	case BMA220_REG_WDT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool bma220_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	/* Don't cache any registers. */
+	return true;
+}
+
+const struct regmap_config bma220_spi_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.read_flag_mask = BIT(7),
+	.max_register = BMA220_REG_SOFTRESET,
+	.cache_type = REGCACHE_MAPLE,
+	.writeable_reg = bma220_is_writable_reg,
+	.volatile_reg = bma220_is_volatile_reg,
+};
+EXPORT_SYMBOL_NS(bma220_spi_regmap_config, "IIO_BOSCH_BMA220");
+
+static int bma220_data_rdy_trigger_set_state(struct iio_trigger *trig,
+					     bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct bma220_data *data = iio_priv(indio_dev);
+
+	guard(mutex)(&data->lock);
+	return regmap_update_bits(data->regmap, BMA220_REG_IE0,
+				  BMA220_INT_EN_DRDY_MSK,
+				  FIELD_PREP(BMA220_INT_EN_DRDY_MSK, state));
+}
+
+static const struct iio_trigger_ops bma220_trigger_ops = {
+	.set_trigger_state = &bma220_data_rdy_trigger_set_state,
+	.validate_device = &iio_trigger_validate_own_device,
+};
+
 static irqreturn_t bma220_trigger_handler(int irq, void *p)
 {
 	int ret;
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bma220_data *data = iio_priv(indio_dev);
-	struct spi_device *spi = data->spi_device;

-	mutex_lock(&data->lock);
-	data->tx_buf[0] = BMA220_REG_ACCEL_X | BMA220_READ_MASK;
-	ret = spi_write_then_read(spi, data->tx_buf, 1, &data->scan.chans,
-				  ARRAY_SIZE(bma220_channels) - 1);
+	ret = regmap_bulk_read(data->regmap, BMA220_REG_ACCEL_X,
+			       &data->scan.chans,
+			       sizeof(data->scan.chans));
 	if (ret < 0)
-		goto err;
+		return IRQ_NONE;

 	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan),
-				    pf->timestamp);
-err:
-	mutex_unlock(&data->lock);
+				    iio_get_time_ns(indio_dev));
 	iio_trigger_notify_done(indio_dev->trig);

 	return IRQ_HANDLED;
@@ -117,59 +267,66 @@ static int bma220_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long mask)
 {
 	int ret;
-	u8 range_idx;
+	u8 index;
+	unsigned int reg;
 	struct bma220_data *data = iio_priv(indio_dev);

 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = bma220_read_reg(data->spi_device, chan->address);
+		ret = regmap_read(data->regmap, chan->address, &reg);
 		if (ret < 0)
 			return -EINVAL;
-		*val = sign_extend32(ret >> chan->scan_type.shift,
+		*val = sign_extend32(reg >> chan->scan_type.shift,
 				     chan->scan_type.realbits - 1);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		ret = bma220_read_reg(data->spi_device, BMA220_REG_RANGE);
-		if (ret < 0)
-			return ret;
-		range_idx = ret & BMA220_RANGE_MASK;
-		*val = bma220_scale_table[range_idx][0];
-		*val2 = bma220_scale_table[range_idx][1];
+		index = data->range_idx;
+		*val = bma220_scale_table[index][0];
+		*val2 = bma220_scale_table[index][1];
 		return IIO_VAL_INT_PLUS_MICRO;
 	}

 	return -EINVAL;
 }

+static int bma220_find_match(const int (*tbl)[2], const int n,
+			       const int val, const int val2)
+{
+	int i;
+
+	for (i = 0; i < n; i++) {
+		if (tbl[i][0] == val && tbl[i][1] == val2)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
 static int bma220_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int val, int val2, long mask)
 {
-	int i;
 	int ret;
 	int index = -1;
 	struct bma220_data *data = iio_priv(indio_dev);

+	guard(mutex)(&data->lock);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		for (i = 0; i < ARRAY_SIZE(bma220_scale_table); i++)
-			if (val == bma220_scale_table[i][0] &&
-			    val2 == bma220_scale_table[i][1]) {
-				index = i;
-				break;
-			}
+		index = bma220_find_match(bma220_scale_table,
+					  ARRAY_SIZE(bma220_scale_table),
+					  val, val2);
 		if (index < 0)
 			return -EINVAL;

-		mutex_lock(&data->lock);
-		data->tx_buf[0] = BMA220_REG_RANGE;
-		data->tx_buf[1] = index;
-		ret = spi_write(data->spi_device, data->tx_buf,
-				sizeof(data->tx_buf));
+		ret = regmap_update_bits(data->regmap, BMA220_REG_RANGE,
+					 BMA220_RANGE_MASK,
+					 FIELD_PREP(BMA220_RANGE_MASK, index));
 		if (ret < 0)
-			dev_err(&data->spi_device->dev,
+			dev_err(data->dev,
 				"failed to set measurement range\n");
-		mutex_unlock(&data->lock);
+		data->range_idx = index;

 		return 0;
 	}
@@ -199,69 +356,150 @@ static const struct iio_info bma220_info = {
 	.read_avail		= bma220_read_avail,
 };

-static int bma220_init(struct spi_device *spi)
+static int bma220_reset(struct bma220_data *data, bool up)
 {
-	int ret;
+	int i, ret;
+	unsigned int val;

-	ret = bma220_read_reg(spi, BMA220_REG_ID);
-	if (ret != BMA220_CHIP_ID)
-		return -ENODEV;
+	guard(mutex)(&data->lock);

-	/* Make sure the chip is powered on */
-	ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
-	if (ret == BMA220_SUSPEND_WAKE)
-		ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
-	if (ret < 0)
-		return ret;
-	if (ret == BMA220_SUSPEND_WAKE)
-		return -EBUSY;
+	/**
+	 * The chip can be reset by a simple register read.
+	 * We need up to 2 register reads of the softreset register
+	 * to make sure that the device is in the desired state.
+	 */
+	for (i = 0; i < 2; i++) {
+		ret = regmap_read(data->regmap, BMA220_REG_SOFTRESET, &val);
+		if (ret < 0)
+			return ret;

-	return 0;
+		if (up && (val == BMA220_SUSPEND_SLEEP))
+			return 0;
+
+		if (!up && (val == BMA220_SUSPEND_WAKE))
+			return 0;
+	}
+
+	return -EBUSY;
 }

-static int bma220_power(struct spi_device *spi, bool up)
+static int bma220_power(struct bma220_data *data, bool up)
 {
 	int i, ret;
+	unsigned int val;

+	guard(mutex)(&data->lock);
 	/**
 	 * The chip can be suspended/woken up by a simple register read.
 	 * So, we need up to 2 register reads of the suspend register
 	 * to make sure that the device is in the desired state.
 	 */
 	for (i = 0; i < 2; i++) {
-		ret = bma220_read_reg(spi, BMA220_REG_SUSPEND);
+		ret = regmap_read(data->regmap, BMA220_REG_SUSPEND, &val);
 		if (ret < 0)
 			return ret;

-		if (up && ret == BMA220_SUSPEND_SLEEP)
+		if (up && (val == BMA220_SUSPEND_SLEEP))
 			return 0;

-		if (!up && ret == BMA220_SUSPEND_WAKE)
+		if (!up && (val == BMA220_SUSPEND_WAKE))
 			return 0;
 	}

 	return -EBUSY;
 }

-static void bma220_deinit(void *spi)
+static int bma220_init(struct bma220_data *data)
+{
+	int ret;
+	unsigned int val;
+	static const char * const regulator_names[] = { "vddd", "vddio", "vdda" };
+
+	ret = devm_regulator_bulk_get_enable(data->dev,
+					     ARRAY_SIZE(regulator_names),
+					     regulator_names);
+	if (ret)
+		return dev_err_probe(data->dev, ret, "Failed to get regulators\n");
+
+	/* Try to read chip_id register. It must return 0xdd. */
+	ret = regmap_read(data->regmap, BMA220_REG_ID, &val);
+	if (ret) {
+		dev_err(data->dev, "Failed to read chip id register\n");
+		return ret;
+	}
+
+	if (val != BMA220_CHIP_ID)
+		return -ENODEV;
+
+	ret = bma220_power(data, true);
+	if (ret) {
+		dev_err(data->dev, "Failed to power-on chip\n");
+		return ret;
+	}
+
+	ret = bma220_reset(data, true);
+	if (ret) {
+		dev_err(data->dev, "Failed to soft reset chip\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void bma220_deinit(void *data_ptr)
 {
-	bma220_power(spi, false);
+	struct bma220_data *data = data_ptr;
+	int ret;
+
+	ret = bma220_power(data, false);
+	if (ret)
+		dev_warn(data->dev,
+			 "Failed to put device into suspend mode (%pe)\n",
+			 ERR_PTR(ret));
+}
+
+static irqreturn_t bma220_irq_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct bma220_data *data = iio_priv(indio_dev);
+	int rv;
+	u8 bma220_reg_if[2];
+
+	guard(mutex)(&data->lock);
+	rv = regmap_bulk_read(data->regmap, BMA220_REG_IF0, bma220_reg_if,
+			      sizeof(bma220_reg_if));
+	if (rv)
+		return IRQ_NONE;
+
+	if (FIELD_GET(BMA220_IF_DRDY, bma220_reg_if[1])) {
+		iio_trigger_poll_nested(data->trig);
+		goto done;
+	}
+
+done:
+
+	return IRQ_HANDLED;
 }

-int bma220_common_probe(struct spi_device *spi)
+int bma220_common_probe(struct device *dev, struct regmap *regmap, int irq)
 {
 	int ret;
 	struct iio_dev *indio_dev;
 	struct bma220_data *data;

-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;

 	data = iio_priv(indio_dev);
-	data->spi_device = spi;
-	mutex_init(&data->lock);
+	data->regmap = regmap;
+	data->dev = dev;
+
+	ret = bma220_init(data);
+	if (ret)
+		return ret;

+	mutex_init(&data->lock);
 	indio_dev->info = &bma220_info;
 	indio_dev->name = BMA220_DEVICE_NAME;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -269,38 +507,59 @@ int bma220_common_probe(struct spi_device *spi)
 	indio_dev->num_channels = ARRAY_SIZE(bma220_channels);
 	indio_dev->available_scan_masks = bma220_accel_scan_masks;

-	ret = bma220_init(data->spi_device);
-	if (ret)
-		return ret;
+	if (irq > 0) {
+		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
+						    indio_dev->name,
+						    iio_device_id(indio_dev));
+		if (!data->trig)
+			return -ENOMEM;
+
+		data->trig->ops = &bma220_trigger_ops;
+		iio_trigger_set_drvdata(data->trig, indio_dev);
+
+		ret = devm_iio_trigger_register(data->dev, data->trig);
+		if (ret)
+			return dev_err_probe(data->dev, ret,
+					     "iio trigger register fail\n");
+		indio_dev->trig = iio_trigger_get(data->trig);
+		ret = devm_request_threaded_irq(dev, irq, NULL,
+						&bma220_irq_handler,
+						IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+						indio_dev->name, indio_dev);
+		if (ret)
+			return dev_err_probe(data->dev, ret,
+					     "request irq %d failed\n", irq);
+	}

-	ret = devm_add_action_or_reset(&spi->dev, bma220_deinit, spi);
+	ret = devm_add_action_or_reset(data->dev, bma220_deinit, data);
 	if (ret)
 		return ret;

-	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
-					      iio_pollfunc_store_time,
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
 					      bma220_trigger_handler, NULL);
 	if (ret < 0) {
-		dev_err(&spi->dev, "iio triggered buffer setup failed\n");
+		dev_err(dev, "iio triggered buffer setup failed\n");
 		return ret;
 	}

-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS(bma220_common_probe, "IIO_BOSCH_BMA220");

 static int bma220_suspend(struct device *dev)
 {
-	struct spi_device *spi = to_spi_device(dev);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct bma220_data *data = iio_priv(indio_dev);

-	return bma220_power(spi, false);
+	return bma220_power(data, false);
 }

 static int bma220_resume(struct device *dev)
 {
-	struct spi_device *spi = to_spi_device(dev);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct bma220_data *data = iio_priv(indio_dev);

-	return bma220_power(spi, true);
+	return bma220_power(data, true);
 }
 EXPORT_NS_SIMPLE_DEV_PM_OPS(bma220_pm_ops, bma220_suspend, bma220_resume,
 			    IIO_BOSCH_BMA220);
diff --git a/drivers/iio/accel/bma220_spi.c b/drivers/iio/accel/bma220_spi.c
index be8348ad0a93..00e3fba9436d 100644
--- a/drivers/iio/accel/bma220_spi.c
+++ b/drivers/iio/accel/bma220_spi.c
@@ -9,17 +9,25 @@
 #include <linux/errno.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 #include <linux/types.h>
 #include <linux/spi/spi.h>

-#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>

 #include "bma220.h"

 static int bma220_spi_probe(struct spi_device *spi)
 {
-	return bma220_common_probe(spi);
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_spi(spi, &bma220_spi_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&spi->dev, "failed to create regmap\n");
+		return PTR_ERR(regmap);
+	}
+
+	return bma220_common_probe(&spi->dev, regmap, spi->irq);
 }

 static const struct spi_device_id bma220_spi_id[] = {
--
2.49.1


