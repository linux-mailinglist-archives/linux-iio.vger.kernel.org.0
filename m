Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2946EDBD08
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2019 07:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391558AbfJRF3Y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Fri, 18 Oct 2019 01:29:24 -0400
Received: from sender4-op-o19.zoho.com ([136.143.188.19]:17955 "EHLO
        sender4-op-o19.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731644AbfJRF3V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Oct 2019 01:29:21 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571370216; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=YCRVinFw8t5oKVvLbdXP6XgHDeU+WO0CPbgFEJjmVMMQ0VqCZtFfLlNXf6mO8Y/i2NslJXGsuhv+ybjKb1T+h28OniKckBlO39ThOUGFW945kWAO71BP1UjAfJZkVQK7wVPHWFM/FrwJTUj8nEpA8+NbcHCZqb0XMO3RdPP7FMM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1571370216; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=6MskQEhx6kymIQZbpaRQXTXSI/FPBLqFAoa95NwG0cw=; 
        b=Fl/OLlnPmfwE9sHQf9N5nM30BKdRxTE3QltLmLqhvEmoFCjOtbePzk/7rOsxbsjLlelDgB9ddLLZ6DPT6Uidtmo0oK69ufhDycCQNgKKX6Pd8tgC1n/d0Zp3ph/KgfJ/jB96QpMvfYf/+qK0GbwAsE2Wnna8FTvVSIJBNfIeK6I=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=dlrobertson.com;
        spf=pass  smtp.mailfrom=dan@dlrobertson.com;
        dmarc=pass header.from=<dan@dlrobertson.com> header.from=<dan@dlrobertson.com>
Received: from nessie.verizon.net (pool-100-15-144-194.washdc.fios.verizon.net [100.15.144.194]) by mx.zohomail.com
        with SMTPS id 1571370214903996.2599052810858; Thu, 17 Oct 2019 20:43:34 -0700 (PDT)
From:   Dan Robertson <dan@dlrobertson.com>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Dan Robertson <dan@dlrobertson.com>
Message-ID: <20191018031848.18538-3-dan@dlrobertson.com>
Subject: [PATCH v4 2/2] iio: (bma400) add driver for the BMA400
Date:   Fri, 18 Oct 2019 03:18:48 +0000
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191018031848.18538-1-dan@dlrobertson.com>
References: <20191018031848.18538-1-dan@dlrobertson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add a IIO driver for the Bosch BMA400 3-axes ultra-low power accelerometer.
The driver supports reading from the acceleration and temperature
registers. The driver also supports reading and configuring the output data
rate, oversampling ratio, and scale.

Signed-off-by: Dan Robertson <dan@dlrobertson.com>
---
 drivers/iio/accel/Kconfig       |  18 +
 drivers/iio/accel/Makefile      |   2 +
 drivers/iio/accel/bma400.h      |  85 ++++
 drivers/iio/accel/bma400_core.c | 796 ++++++++++++++++++++++++++++++++
 drivers/iio/accel/bma400_i2c.c  |  60 +++
 5 files changed, 961 insertions(+)
 create mode 100644 drivers/iio/accel/bma400.h
 create mode 100644 drivers/iio/accel/bma400_core.c
 create mode 100644 drivers/iio/accel/bma400_i2c.c

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 9b9656ce37e6..a1081b902d16 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -112,6 +112,24 @@ config BMA220
 	  To compile this driver as a module, choose M here: the
 	  module will be called bma220_spi.
 
+config BMA400
+	tristate "Bosch BMA400 3-Axis Accelerometer Driver"
+	depends on I2C
+	select REGMAP
+	select BMA400_I2C if (I2C)
+	help
+	  Say Y here if you want to build a driver for the Bosch BMA400
+	  triaxial acceleration sensor.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called bma400_core and you will also get
+	  bma400_i2c for I2C.
+
+config BMA400_I2C
+	tristate
+	depends on BMA400
+	select REGMAP_I2C
+
 config BMC150_ACCEL
 	tristate "Bosch BMC150 Accelerometer Driver"
 	select IIO_BUFFER
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 56bd0215e0d4..3a051cf37f40 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -14,6 +14,8 @@ obj-$(CONFIG_ADXL372_I2C) += adxl372_i2c.o
 obj-$(CONFIG_ADXL372_SPI) += adxl372_spi.o
 obj-$(CONFIG_BMA180) += bma180.o
 obj-$(CONFIG_BMA220) += bma220_spi.o
+obj-$(CONFIG_BMA400) += bma400_core.o
+obj-$(CONFIG_BMA400_I2C) += bma400_i2c.o
 obj-$(CONFIG_BMC150_ACCEL) += bmc150-accel-core.o
 obj-$(CONFIG_BMC150_ACCEL_I2C) += bmc150-accel-i2c.o
 obj-$(CONFIG_BMC150_ACCEL_SPI) += bmc150-accel-spi.o
diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
new file mode 100644
index 000000000000..3a3860220a68
--- /dev/null
+++ b/drivers/iio/accel/bma400.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * bma400.h - Register constants and other forward declarations
+ *            needed by the bma400 sources.
+ *
+ * Copyright 2019 Dan Robertson <dan@dlrobertson.com>
+ */
+
+#ifndef _BMA400_H_
+#define _BMA400_H_
+
+#include <linux/regmap.h>
+
+/*
+ * Read-Only Registers
+ */
+
+/* Status and ID registers */
+#define BMA400_CHIP_ID_REG      0x00
+#define BMA400_ERR_REG          0x02
+#define BMA400_STATUS_REG       0x03
+
+/* Acceleration registers */
+#define BMA400_X_AXIS_LSB_REG   0x04
+#define BMA400_X_AXIS_MSB_REG   0x05
+#define BMA400_Y_AXIS_LSB_REG   0x06
+#define BMA400_Y_AXIS_MSB_REG   0x07
+#define BMA400_Z_AXIS_LSB_REG   0x08
+#define BMA400_Z_AXIS_MSB_REG   0x09
+
+/* Sensor time registers */
+#define BMA400_SENSOR_TIME0     0x0a
+#define BMA400_SENSOR_TIME1     0x0b
+#define BMA400_SENSOR_TIME2     0x0c
+
+/* Event and interrupt registers */
+#define BMA400_EVENT_REG        0x0d
+#define BMA400_INT_STAT0_REG    0x0e
+#define BMA400_INT_STAT1_REG    0x0f
+#define BMA400_INT_STAT2_REG    0x10
+
+/* Temperature register */
+#define BMA400_TEMP_DATA_REG    0x11
+
+/* FIFO length and data registers */
+#define BMA400_FIFO_LENGTH0_REG 0x12
+#define BMA400_FIFO_LENGTH1_REG 0x13
+#define BMA400_FIFO_DATA_REG    0x14
+
+/* Step count registers */
+#define BMA400_STEP_CNT0_REG    0x15
+#define BMA400_STEP_CNT1_REG    0x16
+#define BMA400_STEP_CNT3_REG    0x17
+#define BMA400_STEP_STAT_REG    0x18
+
+/*
+ * Read-write configuration registers
+ */
+#define BMA400_ACC_CONFIG0_REG  0x19
+#define BMA400_ACC_CONFIG1_REG  0x1a
+#define BMA400_ACC_CONFIG2_REG  0x1b
+#define BMA400_CMD_REG          0x7e
+
+/* Chip ID of BMA 400 devices found in the chip ID register. */
+#define BMA400_ID_REG_VAL       0x90
+
+#define BMA400_TWO_BITS_MASK    0x03
+#define BMA400_LP_OSR_MASK      0x60
+#define BMA400_NP_OSR_MASK      0x30
+#define BMA400_ACC_ODR_MASK     0x0f
+#define BMA400_ACC_SCALE_MASK   0xc0
+
+#define BMA400_LP_OSR_SHIFT     0x05
+#define BMA400_NP_OSR_SHIFT     0x04
+#define BMA400_SCALE_SHIFT      0x06
+
+#define BMA400_ACC_ODR_MIN      0x05
+
+extern const struct regmap_config bma400_regmap_config;
+
+int bma400_probe(struct device *dev, struct regmap *regmap, const char *name);
+
+int bma400_remove(struct device *dev);
+
+#endif
diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
new file mode 100644
index 000000000000..80f1ee6713fa
--- /dev/null
+++ b/drivers/iio/accel/bma400_core.c
@@ -0,0 +1,796 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * bma400_core.c - Core IIO driver for Bosch BMA400 triaxial acceleration
+ *                 sensor. Used by bma400-i2c.
+ *
+ * Copyright 2019 Dan Robertson <dan@dlrobertson.com>
+ *
+ * TODO:
+ *  - Support for power management
+ *  - Support events and interrupts
+ *  - Create channel the step count
+ *  - Create channel for sensor time
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/bitops.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#include "bma400.h"
+
+/*
+ * The G-range selection may be one of 2g, 4g, 8, or 16g. The scale may
+ * be selected with the acc_range bits of the ACC_CONFIG1 register.
+ */
+static const int bma400_scale_table[] = {
+	0, 38344,
+	0, 76590,
+	0, 153277,
+	0, 306457
+};
+
+static const int bma400_osr_table[] = { 0, 1, 3 };
+
+/* See the ACC_CONFIG1 section of the datasheet */
+static const int bma400_sample_freqs[] = {
+	12,  500000,
+	25,  0,
+	50,  0,
+	100, 0,
+	200, 0,
+	400, 0,
+	800, 0,
+};
+
+/* See the ACC_CONFIG0 section of the datasheet */
+enum bma400_power_mode {
+	POWER_MODE_SLEEP   = 0x00,
+	POWER_MODE_LOW     = 0x01,
+	POWER_MODE_NORMAL  = 0x02,
+	POWER_MODE_INVALID = 0x03,
+};
+
+struct bma400_sample_freq {
+	int hz;
+	int uhz;
+};
+
+struct bma400_data {
+	struct device *dev;
+	struct mutex mutex; /* data register lock */
+	struct iio_mount_matrix orientation;
+	struct regmap *regmap;
+	enum bma400_power_mode power_mode;
+	struct bma400_sample_freq sample_freq;
+	int oversampling_ratio;
+	int scale;
+};
+
+static bool bma400_is_writable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case BMA400_CHIP_ID_REG:
+	case BMA400_ERR_REG:
+	case BMA400_STATUS_REG:
+	case BMA400_X_AXIS_LSB_REG:
+	case BMA400_X_AXIS_MSB_REG:
+	case BMA400_Y_AXIS_LSB_REG:
+	case BMA400_Y_AXIS_MSB_REG:
+	case BMA400_Z_AXIS_LSB_REG:
+	case BMA400_Z_AXIS_MSB_REG:
+	case BMA400_SENSOR_TIME0:
+	case BMA400_SENSOR_TIME1:
+	case BMA400_SENSOR_TIME2:
+	case BMA400_EVENT_REG:
+	case BMA400_INT_STAT0_REG:
+	case BMA400_INT_STAT1_REG:
+	case BMA400_INT_STAT2_REG:
+	case BMA400_TEMP_DATA_REG:
+	case BMA400_FIFO_LENGTH0_REG:
+	case BMA400_FIFO_LENGTH1_REG:
+	case BMA400_FIFO_DATA_REG:
+	case BMA400_STEP_CNT0_REG:
+	case BMA400_STEP_CNT1_REG:
+	case BMA400_STEP_CNT3_REG:
+	case BMA400_STEP_STAT_REG:
+		return false;
+	default:
+		return true;
+	}
+}
+
+static bool bma400_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case BMA400_ERR_REG:
+	case BMA400_STATUS_REG:
+	case BMA400_X_AXIS_LSB_REG:
+	case BMA400_X_AXIS_MSB_REG:
+	case BMA400_Y_AXIS_LSB_REG:
+	case BMA400_Y_AXIS_MSB_REG:
+	case BMA400_Z_AXIS_LSB_REG:
+	case BMA400_Z_AXIS_MSB_REG:
+	case BMA400_SENSOR_TIME0:
+	case BMA400_SENSOR_TIME1:
+	case BMA400_SENSOR_TIME2:
+	case BMA400_EVENT_REG:
+	case BMA400_INT_STAT0_REG:
+	case BMA400_INT_STAT1_REG:
+	case BMA400_INT_STAT2_REG:
+	case BMA400_TEMP_DATA_REG:
+	case BMA400_FIFO_LENGTH0_REG:
+	case BMA400_FIFO_LENGTH1_REG:
+	case BMA400_FIFO_DATA_REG:
+	case BMA400_STEP_CNT0_REG:
+	case BMA400_STEP_CNT1_REG:
+	case BMA400_STEP_CNT3_REG:
+	case BMA400_STEP_STAT_REG:
+		return true;
+	default:
+		return false;
+	}
+}
+
+const struct regmap_config bma400_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = BMA400_CMD_REG,
+	.cache_type = REGCACHE_RBTREE,
+	.writeable_reg = bma400_is_writable_reg,
+	.volatile_reg = bma400_is_volatile_reg,
+};
+EXPORT_SYMBOL(bma400_regmap_config);
+
+static const struct iio_mount_matrix *
+bma400_accel_get_mount_matrix(const struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan)
+{
+	struct bma400_data *data = iio_priv(indio_dev);
+
+	return &data->orientation;
+}
+
+static const struct iio_chan_spec_ext_info bma400_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, bma400_accel_get_mount_matrix),
+	{ }
+};
+
+#define BMA400_ACC_CHANNEL(_axis) { \
+	.type = IIO_ACCEL, \
+	.modified = 1, \
+	.channel2 = IIO_MOD_##_axis, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
+		BIT(IIO_CHAN_INFO_SCALE) | \
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
+		BIT(IIO_CHAN_INFO_SCALE) | \
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
+	.ext_info = bma400_ext_info, \
+}
+
+static const struct iio_chan_spec bma400_channels[] = {
+	BMA400_ACC_CHANNEL(X),
+	BMA400_ACC_CHANNEL(Y),
+	BMA400_ACC_CHANNEL(Z),
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	},
+};
+
+static int bma400_get_temp_reg(struct bma400_data *data, int *val, int *val2)
+{
+	int ret;
+	int host_temp;
+	unsigned int raw_temp;
+
+	if (data->power_mode == POWER_MODE_SLEEP)
+		return -EBUSY;
+
+	ret = regmap_read(data->regmap, BMA400_TEMP_DATA_REG, &raw_temp);
+
+	if (ret < 0)
+		return ret;
+
+	host_temp = sign_extend32(raw_temp, 7);
+	/*
+	 * The formula for the TEMP_DATA register in the datasheet
+	 * is: x * 0.5 + 23
+	 */
+	*val = (host_temp >> 1) + 23;
+	*val2 = (host_temp & 0x1) * 500000;
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int bma400_get_accel_reg(struct bma400_data *data,
+				const struct iio_chan_spec *chan,
+				int *val)
+{
+	int ret;
+	int lsb_reg;
+	__le16 raw_accel;
+
+	if (data->power_mode == POWER_MODE_SLEEP)
+		return -EBUSY;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		lsb_reg = BMA400_X_AXIS_LSB_REG;
+		break;
+	case IIO_MOD_Y:
+		lsb_reg = BMA400_Y_AXIS_LSB_REG;
+		break;
+	case IIO_MOD_Z:
+		lsb_reg = BMA400_Z_AXIS_LSB_REG;
+		break;
+	default:
+		dev_err(data->dev, "invalid axis channel modifier");
+		return -EINVAL;
+	}
+
+	/* bulk read two registers, with the base being the LSB register */
+	ret = regmap_bulk_read(data->regmap, lsb_reg, &raw_accel,
+			       sizeof(raw_accel));
+	if (ret < 0)
+		return ret;
+
+	*val = sign_extend32(le16_to_cpu(raw_accel), 11);
+	return IIO_VAL_INT;
+}
+
+static int bma400_get_accel_output_data_rate(struct bma400_data *data)
+{
+	int ret;
+	unsigned int val;
+	unsigned int odr;
+	int idx;
+
+	switch (data->power_mode) {
+	case POWER_MODE_LOW:
+		/*
+		 * Runs at a fixed rate in low-power mode. See section 4.3
+		 * in the datasheet.
+		 */
+		data->sample_freq.hz = bma400_sample_freqs[2];
+		data->sample_freq.uhz = bma400_sample_freqs[3];
+		return 0;
+	case POWER_MODE_NORMAL:
+		/*
+		 * In normal mode the ODR can be found in the ACC_CONFIG1
+		 * register.
+		 */
+		ret = regmap_read(data->regmap, BMA400_ACC_CONFIG1_REG, &val);
+		if (ret < 0)
+			goto error;
+
+		odr = (val & BMA400_ACC_ODR_MASK);
+		if (odr < BMA400_ACC_ODR_MIN) {
+			dev_err(data->dev, "invalid ODR=%x", odr);
+			ret = -EINVAL;
+			goto error;
+		}
+
+		idx = (odr - BMA400_ACC_ODR_MIN) * 2;
+
+		if (idx + 1 >= ARRAY_SIZE(bma400_sample_freqs)) {
+			dev_err(data->dev, "sample freq index is too high");
+			ret = -EINVAL;
+			goto error;
+		}
+
+		data->sample_freq.hz = bma400_sample_freqs[idx];
+		data->sample_freq.uhz = bma400_sample_freqs[idx + 1];
+		return 0;
+	case POWER_MODE_SLEEP:
+		data->sample_freq.hz = 0;
+		data->sample_freq.uhz = 0;
+		return 0;
+	default:
+		ret = 0;
+		goto error;
+	}
+error:
+	data->sample_freq.hz = -1;
+	data->sample_freq.uhz = -1;
+	return ret;
+}
+
+static int bma400_set_accel_output_data_rate(struct bma400_data *data,
+					     int hz, int uhz)
+{
+	int ret;
+	unsigned int odr;
+	unsigned int val;
+	int i;
+
+	for (i = 0; i + 1 < ARRAY_SIZE(bma400_sample_freqs); i += 2) {
+		if (bma400_sample_freqs[i] == hz &&
+		    bma400_sample_freqs[i + 1] == uhz)
+			break;
+	}
+
+	if (i + 1 >= ARRAY_SIZE(bma400_sample_freqs))
+		return -EINVAL;
+
+	ret = regmap_read(data->regmap, BMA400_ACC_CONFIG1_REG, &val);
+
+	if (ret < 0)
+		return ret;
+
+	/* preserve the range and normal mode osr */
+	odr = (~BMA400_ACC_ODR_MASK & val) | (i / 2 + BMA400_ACC_ODR_MIN);
+
+	ret = regmap_write(data->regmap, BMA400_ACC_CONFIG1_REG, odr);
+	if (ret < 0)
+		return ret;
+
+	data->sample_freq.hz = bma400_sample_freqs[i];
+	data->sample_freq.uhz = bma400_sample_freqs[i + 1];
+	return 0;
+}
+
+static int bma400_get_accel_oversampling_ratio(struct bma400_data *data)
+{
+	unsigned int val;
+	unsigned int osr;
+	int ret;
+
+	/*
+	 * The oversampling ratio is stored in a different register
+	 * based on the power-mode. In normal mode the OSR is stored
+	 * in ACC_CONFIG1. In low-power mode it is stored in
+	 * ACC_CONFIG0.
+	 */
+	switch (data->power_mode) {
+	case POWER_MODE_LOW:
+		ret = regmap_read(data->regmap, BMA400_ACC_CONFIG0_REG, &val);
+		if (ret < 0) {
+			data->oversampling_ratio = -1;
+			return ret;
+		}
+
+		osr = (val & BMA400_LP_OSR_MASK) >> BMA400_LP_OSR_SHIFT;
+
+		data->oversampling_ratio = osr;
+		return 0;
+	case POWER_MODE_NORMAL:
+		ret = regmap_read(data->regmap, BMA400_ACC_CONFIG1_REG, &val);
+		if (ret < 0) {
+			data->oversampling_ratio = -1;
+			return ret;
+		}
+
+		osr = (val & BMA400_NP_OSR_MASK) >> BMA400_NP_OSR_SHIFT;
+
+		data->oversampling_ratio = osr;
+		return 0;
+	case POWER_MODE_SLEEP:
+		data->oversampling_ratio = 0;
+		return 0;
+	default:
+		data->oversampling_ratio = -1;
+		return 0;
+	}
+}
+
+static int bma400_set_accel_oversampling_ratio(struct bma400_data *data,
+					       int val)
+{
+	int ret;
+	unsigned int acc_config;
+
+	if (val & ~BMA400_TWO_BITS_MASK)
+		return -EINVAL;
+
+	/*
+	 * The oversampling ratio is stored in a different register
+	 * based on the power-mode.
+	 */
+	switch (data->power_mode) {
+	case POWER_MODE_LOW:
+		ret = regmap_read(data->regmap, BMA400_ACC_CONFIG0_REG,
+				  &acc_config);
+		if (ret < 0)
+			return ret;
+
+		ret = regmap_write(data->regmap, BMA400_ACC_CONFIG0_REG,
+				   (acc_config & ~BMA400_LP_OSR_MASK) |
+				   (val << BMA400_LP_OSR_SHIFT));
+		if (ret < 0) {
+			dev_err(data->dev, "Failed to write out OSR");
+			return ret;
+		}
+
+		data->oversampling_ratio = val;
+		return 0;
+	case POWER_MODE_NORMAL:
+		ret = regmap_read(data->regmap, BMA400_ACC_CONFIG1_REG,
+				  &acc_config);
+		if (ret < 0)
+			return ret;
+
+		ret = regmap_write(data->regmap, BMA400_ACC_CONFIG1_REG,
+				   (acc_config & ~BMA400_NP_OSR_MASK) |
+				   (val << BMA400_NP_OSR_SHIFT));
+		if (ret < 0) {
+			dev_err(data->dev, "Failed to write out OSR");
+			return ret;
+		}
+
+		data->oversampling_ratio = val;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+	return ret;
+}
+
+static int bma400_get_accel_scale(struct bma400_data *data)
+{
+	int idx;
+	int ret;
+	unsigned int val;
+
+	ret = regmap_read(data->regmap, BMA400_ACC_CONFIG1_REG, &val);
+	if (ret < 0)
+		return ret;
+
+	idx = (((val & BMA400_ACC_SCALE_MASK) >> BMA400_SCALE_SHIFT) * 2) + 1;
+	if (idx >= ARRAY_SIZE(bma400_scale_table))
+		return -EINVAL;
+
+	data->scale = bma400_scale_table[idx];
+
+	return 0;
+}
+
+static int bma400_get_accel_scale_idx(struct bma400_data *data, int val)
+{
+	int i;
+
+	for (i = 1; i < ARRAY_SIZE(bma400_scale_table); i += 2) {
+		if (bma400_scale_table[i] == val)
+			return i - 1;
+	}
+	return -EINVAL;
+}
+
+static int bma400_set_accel_scale(struct bma400_data *data, unsigned int val)
+{
+	int ret;
+	int idx;
+	unsigned int acc_config;
+
+	ret = regmap_read(data->regmap, BMA400_ACC_CONFIG1_REG, &acc_config);
+	if (ret < 0)
+		return ret;
+
+	idx = bma400_get_accel_scale_idx(data, val);
+
+	if (idx < 0)
+		return idx;
+
+	ret = regmap_write(data->regmap, BMA400_ACC_CONFIG1_REG,
+			   (acc_config & ~BMA400_ACC_SCALE_MASK) |
+			   ((idx / 2) << BMA400_SCALE_SHIFT));
+	if (ret < 0)
+		return ret;
+
+	data->scale = val;
+	return 0;
+}
+
+static int bma400_get_power_mode(struct bma400_data *data)
+{
+	int ret;
+	unsigned int val;
+
+	ret = regmap_read(data->regmap, BMA400_STATUS_REG, &val);
+	if (ret < 0) {
+		dev_err(data->dev, "Failed to read status register");
+		return ret;
+	}
+
+	data->power_mode = (val >> 1) & BMA400_TWO_BITS_MASK;
+
+	return 0;
+}
+
+static int bma400_set_power_mode(struct bma400_data *data,
+				 enum bma400_power_mode mode)
+{
+	int ret;
+	unsigned int val;
+
+	ret = regmap_read(data->regmap, BMA400_ACC_CONFIG0_REG, &val);
+	if (ret < 0)
+		return ret;
+
+	if (data->power_mode == mode)
+		return 0;
+
+	if (mode == POWER_MODE_INVALID)
+		return -EINVAL;
+
+	/* Preserve the low-power oversample ratio etc */
+	ret = regmap_write(data->regmap, BMA400_ACC_CONFIG0_REG,
+			   mode | (val & ~BMA400_TWO_BITS_MASK));
+
+	if (ret < 0) {
+		dev_err(data->dev, "Failed to write to power-mode");
+		return ret;
+	}
+
+	data->power_mode = mode;
+
+	/*
+	 * Update our cached osr and odr based on the new
+	 * power-mode.
+	 */
+	bma400_get_accel_output_data_rate(data);
+	bma400_get_accel_oversampling_ratio(data);
+
+	return 0;
+}
+
+static int bma400_init(struct bma400_data *data)
+{
+	int ret;
+	unsigned int val;
+
+	/* Try to read chip_id register. It must return 0x90. */
+	ret = regmap_read(data->regmap, BMA400_CHIP_ID_REG, &val);
+
+	if (ret < 0) {
+		dev_err(data->dev, "Failed to read chip id register: %x!", ret);
+		return ret;
+	} else if (val != BMA400_ID_REG_VAL) {
+		dev_err(data->dev, "CHIP ID MISMATCH: %x!", ret);
+		return -ENODEV;
+	}
+
+	ret = bma400_get_power_mode(data);
+	if (ret < 0) {
+		dev_err(data->dev, "Failed to get the initial power-mode!");
+		return ret;
+	}
+
+	if (data->power_mode != POWER_MODE_NORMAL) {
+		ret = bma400_set_power_mode(data, POWER_MODE_NORMAL);
+		if (ret < 0) {
+			dev_err(data->dev, "Failed to wake up the device!");
+			return ret;
+		}
+		/*
+		 * TODO: The datasheet waits 1500us here in the example, but
+		 * lists 2/ODR as the wakeup time.
+		 */
+		usleep_range(1500, 20000);
+	}
+
+	ret = bma400_get_accel_output_data_rate(data);
+	if (ret < 0)
+		return ret;
+
+	ret = bma400_get_accel_oversampling_ratio(data);
+	if (ret < 0)
+		return ret;
+
+	ret = bma400_get_accel_scale(data);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Once the interrupt engine is supported we might use the
+	 * data_src_reg, but for now ensure this is set to the
+	 * variable ODR filter selectable by the sample frequency
+	 * channel.
+	 */
+	return regmap_write(data->regmap, BMA400_ACC_CONFIG2_REG, 0x00);
+}
+
+static int bma400_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan, int *val,
+			   int *val2, long mask)
+{
+	struct bma400_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+		mutex_lock(&data->mutex);
+		ret = bma400_get_temp_reg(data, val, val2);
+		mutex_unlock(&data->mutex);
+		return ret;
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&data->mutex);
+		ret = bma400_get_accel_reg(data, chan, val);
+		mutex_unlock(&data->mutex);
+		return ret;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		switch (chan->type) {
+		case IIO_ACCEL:
+			if (data->sample_freq.hz < 0)
+				return -EINVAL;
+
+			*val = data->sample_freq.hz;
+			*val2 = data->sample_freq.uhz;
+			return IIO_VAL_INT_PLUS_MICRO;
+		case IIO_TEMP:
+			/*
+			 * Runs at a fixed sampling frequency. See Section 4.4
+			 * of the datasheet.
+			 */
+			*val = 6;
+			*val2 = 250000;
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+		*val2 = data->scale;
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		/*
+		 * TODO: We could avoid this logic and returning -EINVAL here if
+		 * we set both the low-power and normal mode OSR registers when
+		 * we configure the device.
+		 */
+		if (data->oversampling_ratio < 0)
+			return -EINVAL;
+
+		*val = data->oversampling_ratio;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bma400_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*vals = bma400_scale_table;
+		*length = ARRAY_SIZE(bma400_scale_table);
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*type = IIO_VAL_INT;
+		*vals = bma400_osr_table;
+		*length = ARRAY_SIZE(bma400_osr_table);
+		return IIO_AVAIL_RANGE;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*vals = bma400_sample_freqs;
+		*length = ARRAY_SIZE(bma400_sample_freqs);
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bma400_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int val, int val2,
+			    long mask)
+{
+	int ret;
+	struct bma400_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		/*
+		 * The sample frequency is readonly for the temperature
+		 * register and a fixed value in low-power mode.
+		 */
+		if (chan->type != IIO_ACCEL)
+			return -EINVAL;
+
+		mutex_lock(&data->mutex);
+		ret = bma400_set_accel_output_data_rate(data, val, val2);
+		mutex_unlock(&data->mutex);
+		return ret;
+	case IIO_CHAN_INFO_SCALE:
+		if (val != 0)
+			return -EINVAL;
+
+		mutex_lock(&data->mutex);
+		ret = bma400_set_accel_scale(data, val2);
+		mutex_unlock(&data->mutex);
+		return ret;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		mutex_lock(&data->mutex);
+		ret = bma400_set_accel_oversampling_ratio(data, val);
+		mutex_unlock(&data->mutex);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bma400_write_raw_get_fmt(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan,
+				    long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info bma400_info = {
+	.read_raw          = bma400_read_raw,
+	.read_avail        = bma400_read_avail,
+	.write_raw         = bma400_write_raw,
+	.write_raw_get_fmt = bma400_write_raw_get_fmt,
+};
+
+int bma400_probe(struct device *dev, struct regmap *regmap, const char *name)
+{
+	int ret;
+	struct bma400_data *data;
+	struct iio_dev *indio_dev;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->regmap = regmap;
+	data->dev = dev;
+
+	ret = bma400_init(data);
+	if (ret < 0)
+		return ret;
+
+	ret = iio_read_mount_matrix(dev, "mount-matrix", &data->orientation);
+	if (ret)
+		return ret;
+
+	mutex_init(&data->mutex);
+	indio_dev->dev.parent = dev;
+	indio_dev->name = name;
+	indio_dev->info = &bma400_info;
+	indio_dev->channels = bma400_channels;
+	indio_dev->num_channels = ARRAY_SIZE(bma400_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	dev_set_drvdata(dev, indio_dev);
+
+	return iio_device_register(indio_dev);
+}
+EXPORT_SYMBOL(bma400_probe);
+
+int bma400_remove(struct device *dev)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct bma400_data *data = iio_priv(indio_dev);
+
+	mutex_lock(&data->mutex);
+	ret = bma400_set_power_mode(data, POWER_MODE_SLEEP);
+	mutex_unlock(&data->mutex);
+
+	iio_device_unregister(indio_dev);
+
+	return ret;
+}
+EXPORT_SYMBOL(bma400_remove);
+
+MODULE_AUTHOR("Dan Robertson <dan@dlrobertson.com>");
+MODULE_DESCRIPTION("Bosch BMA400 triaxial acceleration sensor");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/accel/bma400_i2c.c b/drivers/iio/accel/bma400_i2c.c
new file mode 100644
index 000000000000..d1029e8ccd1d
--- /dev/null
+++ b/drivers/iio/accel/bma400_i2c.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * bma400_i2c.c - I2C IIO driver for Bosch BMA400 triaxial acceleration sensor.
+ *
+ * Copyright 2019 Dan Robertson <dan@dlrobertson.com>
+ *
+ * I2C address is either 0x14 or 0x15 depending on SDO
+ */
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include "bma400.h"
+
+static int bma400_i2c_probe(struct i2c_client *client,
+			    const struct i2c_device_id *id)
+{
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(client, &bma400_regmap_config);
+
+	if (!regmap)
+		return -ENOMEM;
+
+	return bma400_probe(&client->dev, regmap, id->name);
+}
+
+static int bma400_i2c_remove(struct i2c_client *client)
+{
+	return bma400_remove(&client->dev);
+}
+
+static const struct i2c_device_id bma400_i2c_ids[] = {
+	{ "bma400", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, bma400_i2c_ids);
+
+static const struct of_device_id bma400_of_i2c_match[] = {
+	{ .compatible = "bosch,bma400" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bma400_of_i2c_match);
+
+static struct i2c_driver bma400_i2c_driver = {
+	.driver = {
+		.name = "bma400",
+		.of_match_table = bma400_of_i2c_match,
+	},
+	.probe    = bma400_i2c_probe,
+	.remove   = bma400_i2c_remove,
+	.id_table = bma400_i2c_ids,
+};
+
+module_i2c_driver(bma400_i2c_driver);
+
+MODULE_AUTHOR("Dan Robertson <dan@dlrobertson.com>");
+MODULE_DESCRIPTION("Bosch BMA400 triaxial acceleration sensor");
+MODULE_LICENSE("GPL v2");


