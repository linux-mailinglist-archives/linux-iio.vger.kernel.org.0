Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FAD3608A5
	for <lists+linux-iio@lfdr.de>; Thu, 15 Apr 2021 13:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhDOLzt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Apr 2021 07:55:49 -0400
Received: from first.geanix.com ([116.203.34.67]:50688 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhDOLzt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 15 Apr 2021 07:55:49 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 79B734634FC;
        Thu, 15 Apr 2021 11:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1618487186; bh=UkmM6g2CzNnP1mAorrAuyBKeuD9SZIU0JQEnz6rx2Go=;
        h=From:To:Cc:Subject:Date;
        b=Px/MuZuyd1bcYUsqmAFoDSDfQZ57MijkVn8VeDgKkwxBqQfK9zyb7gOrHjO9VkvI2
         1CKqX67NB31rBiWZ/sj+b7FkU4oN/+qtqeqmKCubsG2kJ67poUMOUe87rfuQWMHaZ2
         oVy21mA33jifGlK20tCGyrOuoaJxJpX4Xk7oTZ+DzLYOQXtYurGmtFTnmYOWITSC9+
         CSbEPHkMEpDic9C0cwHKxjUe08JVRJ9J7FvbQxeITVnVApmVXrC44vYHSbVjLl9Gfi
         Uuk6Fp3r4YdPEXmX/NgcBeuG5hdgbl/DGRfL7v7cDVgANDr8nRR/j8c9w2B1LV3dNW
         Id8+pkHl172Kw==
From:   Sean Nyekjaer <sean@geanix.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>
Subject: [RFC PATCH 1/2] iio: accel: add support for FXLS8962AF/FXLS8964AF accelerometers
Date:   Thu, 15 Apr 2021 13:46:13 +0200
Message-Id: <20210415114614.1071928-1-sean@geanix.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on 93bd6fdb21b5
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add basic support for NXP FXLS8962AF/FXLS8964AF Automotive
accelerometers.
It will allow setting up scale/gain and reading x,y,z
axis.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
- Interrupt, buffered reads and events support is in the works.

 drivers/iio/accel/Kconfig           |  22 +
 drivers/iio/accel/Makefile          |   4 +
 drivers/iio/accel/fxls8962af-core.c | 739 ++++++++++++++++++++++++++++
 drivers/iio/accel/fxls8962af-i2c.c  |  67 +++
 drivers/iio/accel/fxls8962af-spi.c  |  72 +++
 drivers/iio/accel/fxls8962af.h      |  21 +
 6 files changed, 925 insertions(+)
 create mode 100644 drivers/iio/accel/fxls8962af-core.c
 create mode 100644 drivers/iio/accel/fxls8962af-i2c.c
 create mode 100644 drivers/iio/accel/fxls8962af-spi.c
 create mode 100644 drivers/iio/accel/fxls8962af.h

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 2e0c62c39155..c4b42024de42 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -370,6 +370,28 @@ config MMA8452
 	  To compile this driver as a module, choose M here: the module
 	  will be called mma8452.
 
+config FXLS8962AF
+	tristate "NXP FXLS8962AF and similar Accelerometers Driver"
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	select REGMAP
+	select FXLS8962AF_I2C if I2C
+	select FXLS8962AF_SPI if SPI
+	help
+	  Say yes here to build support for the NXP 3-axis automotive
+	  accelerometer FXLS8962AF/FXLS8964AF.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called fxls8962af.
+
+config FXLS8962AF_I2C
+	tristate
+	select REGMAP_I2C
+
+config FXLS8962AF_SPI
+	tristate
+	select REGMAP_SPI
+
 config MMA9551_CORE
 	tristate
 
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 4f6c1ebe13b0..3e48a9127863 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -40,6 +40,10 @@ obj-$(CONFIG_MMA7660)	+= mma7660.o
 
 obj-$(CONFIG_MMA8452)	+= mma8452.o
 
+obj-$(CONFIG_FXLS8962AF)	+= fxls8962af-core.o
+obj-$(CONFIG_FXLS8962AF_I2C)	+= fxls8962af-i2c.o
+obj-$(CONFIG_FXLS8962AF_SPI)	+= fxls8962af-spi.o
+
 obj-$(CONFIG_MMA9551_CORE)	+= mma9551_core.o
 obj-$(CONFIG_MMA9551)		+= mma9551.o
 obj-$(CONFIG_MMA9553)		+= mma9553.o
diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
new file mode 100644
index 000000000000..daee5b07ca49
--- /dev/null
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -0,0 +1,739 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021 Connected Cars A/S
+ */
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/delay.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
+#include <linux/regmap.h>
+
+#include "fxls8962af.h"
+
+#define FXLS8962AF_INT_STATUS			0x00
+#define FXLS8962AF_INT_STATUS_SRC_DRDY		BIT(7)
+#define FXLS8962AF_TEMP_OUT			0x01
+#define FXLS8962AF_VECM_LSB			0x02
+#define FXLS8962AF_OUT_X_LSB			0x04
+#define FXLS8962AF_OUT_Y_LSB			0x06
+#define FXLS8962AF_OUT_Z_LSB			0x08
+#define FXLS8962AF_BUF_STATUS			0x0b
+#define FXLS8962AF_BUF_X_LSB			0x0c
+#define FXLS8962AF_BUF_Y_LSB			0x0e
+#define FXLS8962AF_BUF_Z_LSB			0x10
+
+#define FXLS8962AF_PROD_REV			0x12
+#define FXLS8962AF_WHO_AM_I			0x13
+
+#define FXLS8962AF_SYS_MODE			0x14
+#define FXLS8962AF_SENS_CONFIG1			0x15
+#define FXLS8962AF_SENS_CONFIG1_ACTIVE		BIT(0)
+#define FXLS8962AF_SENS_CONFIG1_RST		BIT(7)
+#define FXLS8962AF_FSR_2G			0x0
+#define FXLS8962AF_FSR_4G			0x2
+#define FXLS8962AF_FSR_8G			0x4
+#define FXLS8962AF_FSR_16G			0x6
+#define FXLS8962AF_FSR_MASK			(BIT(2) | BIT(1))
+
+#define FXLS8962AF_SENS_CONFIG2			0x16
+#define FXLS8962AF_SENS_CONFIG3			0x17
+#define FXLS8962AF_SENS_CONFIG4			0x18
+#define FXLS8962AF_SENS_CONFIG5			0x19
+
+#define FXLS8962AF_WAKE_IDLE_LSB		0x1b
+#define FXLS8962AF_SLEEP_IDLE_LSB		0x1c
+#define FXLS8962AF_ASLP_COUNT_LSB		0x1e
+
+#define FXLS8962AF_INT_EN			0x20
+#define FXLS8962AF_INT_PIN_SEL			0x21
+
+#define FXLS8962AF_OFF_X			0x22
+#define FXLS8962AF_OFF_Y			0x23
+#define FXLS8962AF_OFF_Z			0x24
+
+#define FXLS8962AF_BUF_CONFIG1			0x26
+#define FXLS8962AF_BUF_CONFIG2			0x27
+
+#define FXLS8962AF_ORIENT_STATUS		0x28
+#define FXLS8962AF_ORIENT_CONFIG		0x29
+#define FXLS8962AF_ORIENT_DBCOUNT		0x2a
+#define FXLS8962AF_ORIENT_BF_ZCOMP		0x2b
+#define FXLS8962AF_ORIENT_THS_REG		0x2c
+
+#define FXLS8962AF_SDCD_INT_SRC1		0x2d
+#define FXLS8962AF_SDCD_INT_SRC2		0x2e
+#define FXLS8962AF_SDCD_CONFIG1			0x2f
+#define FXLS8962AF_SDCD_CONFIG2			0x30
+#define FXLS8962AF_SDCD_OT_DBCNT		0x31
+#define FXLS8962AF_SDCD_WT_DBCNT		0x32
+#define FXLS8962AF_SDCD_LTHS_LSB		0x33
+#define FXLS8962AF_SDCD_UTHS_LSB		0x35
+
+#define FXLS8962AF_SELF_TEST_CONFIG1		0x37
+#define FXLS8962AF_SELF_TEST_CONFIG2		0x38
+
+#define FXLS8962AF_MAX_REG			0x38
+
+#define FXLS8962AF_DEVICE_ID			0x62
+#define FXLS8964AF_DEVICE_ID			0x84
+
+#define FXLS8962AF_TEMP_CENTER_VAL		25
+
+#define FXLS8962AF_AXIS_TO_REG(axis)		(FXLS8962AF_BUF_X_LSB + (axis * 2))
+#define FXLS8962AF_AUTO_SUSPEND_DELAY_MS	2000
+
+#define FXLS8962AF_SCALE_TABLE_LEN		4
+
+struct fxls8962af_scale_info {
+	unsigned int scale;
+	u8 reg_value;
+};
+
+struct fxls8962af_chip_info {
+	u8 chip_id;
+	const struct iio_chan_spec *channels;
+	int num_channels;
+	const struct fxls8962af_scale_info
+	    scale_table[FXLS8962AF_SCALE_TABLE_LEN];
+	int all_events;
+	int enabled_events;
+};
+
+struct fxls8962af_data {
+	struct regmap *regmap;
+	struct mutex lock;
+	const struct fxls8962af_chip_info *chip_info;
+	struct regulator *vdd_reg;
+	struct iio_mount_matrix orientation;
+};
+
+const struct regmap_config fxls8962af_regmap_conf = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = FXLS8962AF_MAX_REG,
+};
+EXPORT_SYMBOL_GPL(fxls8962af_regmap_conf);
+
+enum {
+	idx_x,
+	idx_y,
+	idx_z,
+	idx_ts,
+};
+
+static int fxls8962af_drdy(struct fxls8962af_data *data)
+{
+	int tries = 150, ret;
+	unsigned int reg;
+	struct device *dev = regmap_get_device(data->regmap);
+
+	while (tries-- > 0) {
+		ret = regmap_read(data->regmap, FXLS8962AF_INT_STATUS, &reg);
+		if (ret < 0)
+			return ret;
+
+		if ((reg & FXLS8962AF_INT_STATUS_SRC_DRDY) ==
+		    FXLS8962AF_INT_STATUS_SRC_DRDY)
+			return 0;
+
+		msleep(20);
+	}
+
+	dev_err(dev, "data not ready\n");
+
+	return -EIO;
+}
+
+static int fxls8962af_set_power_state(struct fxls8962af_data *data, bool on)
+{
+#ifdef CONFIG_PM
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
+
+	if (on) {
+		ret = pm_runtime_get_sync(dev);
+	} else {
+		pm_runtime_mark_last_busy(dev);
+		ret = pm_runtime_put_autosuspend(dev);
+	}
+
+	if (ret < 0) {
+		dev_err(dev, "failed to change power state to %d\n", on);
+		if (on)
+			pm_runtime_put_noidle(dev);
+
+		return ret;
+	}
+#endif
+
+	return 0;
+}
+
+static int fxls8962af_get_temp(struct fxls8962af_data *data, int *val)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
+	unsigned int value;
+
+	mutex_lock(&data->lock);
+
+	ret = fxls8962af_drdy(data);
+	if (ret < 0) {
+		mutex_unlock(&data->lock);
+		return ret;
+	}
+
+	ret = fxls8962af_set_power_state(data, true);
+	if (ret) {
+		mutex_unlock(&data->lock);
+		return ret;
+	}
+
+	ret = regmap_read(data->regmap, FXLS8962AF_TEMP_OUT, &value);
+	if (ret < 0) {
+		dev_err(dev, "Error reading reg_temp\n");
+		fxls8962af_set_power_state(data, false);
+		mutex_unlock(&data->lock);
+		return ret;
+	}
+
+	ret = fxls8962af_set_power_state(data, false);
+
+	*val = sign_extend32(value, 7);
+
+	mutex_unlock(&data->lock);
+	if (ret < 0)
+		return ret;
+
+	return IIO_VAL_INT;
+}
+
+static int fxls8962af_get_axis(struct fxls8962af_data *data,
+			       struct iio_chan_spec const *chan, int *val)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	int axis = chan->scan_index;
+	int ret;
+	__le16 raw_val;
+
+	mutex_lock(&data->lock);
+
+	ret = fxls8962af_drdy(data);
+	if (ret < 0) {
+		mutex_unlock(&data->lock);
+		return ret;
+	}
+
+	ret = fxls8962af_set_power_state(data, true);
+	if (ret) {
+		mutex_unlock(&data->lock);
+		return ret;
+	}
+
+	ret = regmap_bulk_read(data->regmap, FXLS8962AF_AXIS_TO_REG(axis),
+			       &raw_val, sizeof(raw_val));
+	if (ret < 0) {
+		dev_err(dev, "failed to read axes\n");
+		fxls8962af_set_power_state(data, false);
+		mutex_unlock(&data->lock);
+		return ret;
+	}
+
+	ret = fxls8962af_set_power_state(data, false);
+
+	mutex_unlock(&data->lock);
+	*val = sign_extend32(le16_to_cpu(raw_val),
+			     chan->scan_type.realbits - 1);
+	if (ret < 0)
+		return ret;
+
+	return IIO_VAL_INT;
+}
+
+static ssize_t fxls8962af_show_scale_avail(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct fxls8962af_data *data = iio_priv(indio_dev);
+	int i, len = 0;
+
+	for (i = 0; i < FXLS8962AF_SCALE_TABLE_LEN; i++)
+		len += scnprintf(buf + len, PAGE_SIZE - len, "0.%09u ",
+				 data->chip_info->scale_table[i].scale);
+
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
+static int fxls8962af_write_raw_get_fmt(struct iio_dev *indio_dev,
+					struct iio_chan_spec const *chan,
+					long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_ACCEL:
+			return IIO_VAL_INT_PLUS_NANO;
+		default:
+			return IIO_VAL_INT_PLUS_MICRO;
+		}
+	default:
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+}
+
+static IIO_DEVICE_ATTR(in_accel_scale_available, 0444,
+		       fxls8962af_show_scale_avail, NULL, 0);
+
+static int fxls8962af_standby(struct fxls8962af_data *data)
+{
+	return regmap_update_bits(data->regmap, FXLS8962AF_SENS_CONFIG1,
+				  FXLS8962AF_SENS_CONFIG1_ACTIVE, 0);
+}
+
+static int fxls8962af_active(struct fxls8962af_data *data)
+{
+	return regmap_update_bits(data->regmap, FXLS8962AF_SENS_CONFIG1,
+				  FXLS8962AF_SENS_CONFIG1_ACTIVE, 1);
+}
+
+/* returns >0 if active, 0 if in standby and <0 on error */
+static int fxls8962af_is_active(struct fxls8962af_data *data)
+{
+	unsigned int reg;
+	int ret;
+
+	ret = regmap_read(data->regmap, FXLS8962AF_SENS_CONFIG1, &reg);
+	if (ret < 0)
+		return ret;
+
+	return reg & FXLS8962AF_SENS_CONFIG1_ACTIVE;
+}
+
+static int fxls8962af_update_config(struct fxls8962af_data *data, u8 reg,
+				    u8 mask, u8 val)
+{
+	int ret;
+	int is_active;
+
+	mutex_lock(&data->lock);
+
+	is_active = fxls8962af_is_active(data);
+	if (is_active < 0) {
+		ret = is_active;
+		goto fail;
+	}
+
+	/* config can only be changed when in standby */
+	if (is_active > 0) {
+		ret = fxls8962af_standby(data);
+		if (ret < 0)
+			goto fail;
+	}
+
+	ret = regmap_update_bits(data->regmap, reg, mask, val);
+	if (ret < 0)
+		goto fail;
+
+	if (is_active > 0) {
+		ret = fxls8962af_active(data);
+		if (ret < 0)
+			goto fail;
+	}
+
+	ret = 0;
+ fail:
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static int fxls8962af_set_full_scale(struct fxls8962af_data *data, u32 scale)
+{
+	int i;
+
+	for (i = 0; i < FXLS8962AF_SCALE_TABLE_LEN; i++) {
+		if (data->chip_info->scale_table[i].scale == scale)
+			break;
+	}
+
+	if (i == FXLS8962AF_SCALE_TABLE_LEN)
+		return -EINVAL;
+
+	return fxls8962af_update_config(data, FXLS8962AF_SENS_CONFIG1,
+					FXLS8962AF_FSR_MASK,
+					data->chip_info->scale_table[i].reg_value);
+}
+
+static unsigned int fxls8962af_read_full_scale(struct fxls8962af_data *data,
+					       int *val)
+{
+	int i, ret;
+	unsigned int reg;
+
+	ret = regmap_read(data->regmap, FXLS8962AF_SENS_CONFIG1, &reg);
+	if (ret < 0)
+		return ret;
+
+	reg &= FXLS8962AF_FSR_MASK;
+
+	for (i = 0; i < FXLS8962AF_SCALE_TABLE_LEN; i++)
+		if (data->chip_info->scale_table[i].reg_value == reg)
+			break;
+
+	if (i == FXLS8962AF_SCALE_TABLE_LEN)
+		return -EINVAL;
+
+	*val = data->chip_info->scale_table[i].scale;
+
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
+static int fxls8962af_read_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int *val, int *val2, long mask)
+{
+	struct fxls8962af_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		switch (chan->type) {
+		case IIO_TEMP:
+			ret = fxls8962af_get_temp(data, val);
+			break;
+		case IIO_ACCEL:
+			ret = fxls8962af_get_axis(data, chan, val);
+			break;
+		default:
+			ret = -EINVAL;
+		}
+
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
+	case IIO_CHAN_INFO_OFFSET:
+		if (chan->type == IIO_TEMP) {
+			*val = FXLS8962AF_TEMP_CENTER_VAL;
+			return IIO_VAL_INT;
+		} else {
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+		ret = fxls8962af_read_full_scale(data, val2);
+		return ret;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static int fxls8962af_write_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int val, int val2, long mask)
+{
+	struct fxls8962af_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		ret = fxls8962af_set_full_scale(data, val2);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	iio_device_release_direct_mode(indio_dev);
+	return ret;
+}
+
+#define FXLS8962AF_CHANNEL(axis, idx) { \
+	.type = IIO_ACCEL, \
+	.modified = 1, \
+	.channel2 = IIO_MOD_##axis, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			      BIT(IIO_CHAN_INFO_CALIBBIAS), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
+			BIT(IIO_CHAN_INFO_SCALE) | \
+			BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY) | \
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
+	.scan_index = idx, \
+	.scan_type = { \
+		.sign = 's', \
+		.realbits = 12, \
+		.storagebits = 16, \
+		.shift = 4, \
+		.endianness = IIO_BE, \
+	}, \
+}
+
+#define FXLS8962AF_TEMP_CHANNEL { \
+	.type = IIO_TEMP, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			      BIT(IIO_CHAN_INFO_OFFSET),\
+	.scan_index = -1, \
+	.scan_type = { \
+		.sign = 's', \
+		.realbits = 8, \
+		.storagebits = 16, \
+	}, \
+}
+
+static const struct iio_chan_spec fxls8962af_channels[] = {
+	FXLS8962AF_CHANNEL(X, idx_x),
+	FXLS8962AF_CHANNEL(Y, idx_y),
+	FXLS8962AF_CHANNEL(Z, idx_z),
+	IIO_CHAN_SOFT_TIMESTAMP(idx_ts),
+	FXLS8962AF_TEMP_CHANNEL,
+};
+
+static const struct fxls8962af_chip_info fxls_chip_info_table[] = {
+	[fxls8962af] = {
+		.chip_id = FXLS8962AF_DEVICE_ID,
+		.channels = fxls8962af_channels,
+		.num_channels = ARRAY_SIZE(fxls8962af_channels),
+		.scale_table = {
+			 {IIO_G_TO_M_S_2(980000), FXLS8962AF_FSR_2G},
+			 {IIO_G_TO_M_S_2(1950000), FXLS8962AF_FSR_4G},
+			 {IIO_G_TO_M_S_2(3910000), FXLS8962AF_FSR_8G},
+			 {IIO_G_TO_M_S_2(7810000), FXLS8962AF_FSR_16G}},
+			},
+	[fxls8964af] = {
+		.chip_id = FXLS8964AF_DEVICE_ID,
+		.channels = fxls8962af_channels,
+		.num_channels = ARRAY_SIZE(fxls8962af_channels),
+		.scale_table = {
+			 {IIO_G_TO_M_S_2(980000), FXLS8962AF_FSR_2G},
+			 {IIO_G_TO_M_S_2(1950000), FXLS8962AF_FSR_4G},
+			 {IIO_G_TO_M_S_2(3910000), FXLS8962AF_FSR_8G},
+			 {IIO_G_TO_M_S_2(7810000), FXLS8962AF_FSR_16G}},
+			},
+};
+
+static struct attribute *fxls8962af_attributes[] = {
+	&iio_dev_attr_in_accel_scale_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group fxls8962af_group = {
+	.attrs = fxls8962af_attributes,
+};
+
+static const struct iio_info fxls8962af_info = {
+	.attrs = &fxls8962af_group,
+	.read_raw = &fxls8962af_read_raw,
+	.write_raw = &fxls8962af_write_raw,
+	.write_raw_get_fmt = fxls8962af_write_raw_get_fmt,
+};
+
+static const unsigned long fxls8962af_scan_masks[] = { 0x7, 0 };
+
+static int fxls8962af_reset(struct fxls8962af_data *data)
+{
+	int i, ret;
+	unsigned int reg;
+
+	ret = regmap_update_bits(data->regmap, FXLS8962AF_SENS_CONFIG1,
+				 FXLS8962AF_SENS_CONFIG1_RST,
+				 FXLS8962AF_SENS_CONFIG1_RST);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < 10; i++) {
+		usleep_range(100, 200);
+		ret = regmap_read(data->regmap, FXLS8962AF_SENS_CONFIG1, &reg);
+		if (ret == -EIO)
+			continue;	/* I2C comm reset */
+		if (ret < 0)
+			return ret;
+		if (!(reg & FXLS8962AF_SENS_CONFIG1_RST))
+			return 0;
+	}
+
+	return -ETIMEDOUT;
+}
+
+int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq,
+			  const char *name)
+{
+	struct fxls8962af_data *data;
+	struct iio_dev *indio_dev;
+	unsigned int reg;
+	int ret, i;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	dev_set_drvdata(dev, indio_dev);
+	mutex_init(&data->lock);
+	data->regmap = regmap;
+
+	ret = iio_read_mount_matrix(dev, "mount-matrix", &data->orientation);
+	if (ret)
+		return ret;
+
+	data->vdd_reg = devm_regulator_get_optional(dev, "vdd");
+	if (IS_ERR(data->vdd_reg)) {
+		if ((PTR_ERR(data->vdd_reg) != -ENODEV) && dev->of_node)
+			return PTR_ERR(data->vdd_reg);
+
+		data->vdd_reg = NULL;
+	} else {
+		ret = regulator_enable(data->vdd_reg);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_read(data->regmap, FXLS8962AF_WHO_AM_I, &reg);
+	if (ret < 0)
+		goto disable_regulators;
+
+	dev_dbg(dev, "Chip Id %x\n", reg);
+	for (i = 0; i < ARRAY_SIZE(fxls_chip_info_table); i++) {
+		if (fxls_chip_info_table[i].chip_id == reg) {
+			data->chip_info = &fxls_chip_info_table[i];
+			break;
+		}
+	}
+
+	indio_dev->channels = data->chip_info->channels;
+	indio_dev->num_channels = data->chip_info->num_channels;
+	indio_dev->name = name;
+	indio_dev->available_scan_masks = fxls8962af_scan_masks;
+	indio_dev->info = &fxls8962af_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	dev_info(dev, "registering %s accelerometer\n", name);
+
+	ret = fxls8962af_reset(data);
+	if (ret < 0)
+		goto disable_regulators;
+
+	ret = pm_runtime_set_active(dev);
+	if (ret < 0)
+		goto disable_regulators;
+
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev, FXLS8962AF_AUTO_SUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+
+	ret = iio_device_register(indio_dev);
+	if (ret < 0)
+		goto disable_regulators;
+
+	return 0;
+
+ disable_regulators:
+	if (data->vdd_reg)
+		regulator_disable(data->vdd_reg);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(fxls8962af_core_probe);
+
+int fxls8962af_core_remove(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct fxls8962af_data *data = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_put_noidle(dev);
+
+	fxls8962af_standby(iio_priv(indio_dev));
+
+	if (data->vdd_reg)
+		regulator_disable(data->vdd_reg);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fxls8962af_core_remove);
+
+#ifdef CONFIG_PM
+static int fxls8962af_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct fxls8962af_data *data = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&data->lock);
+	ret = fxls8962af_standby(data);
+	mutex_unlock(&data->lock);
+	if (ret < 0) {
+		dev_err(dev, "powering off device failed\n");
+		return -EAGAIN;
+	}
+
+	if (data->vdd_reg) {
+		ret = regulator_disable(data->vdd_reg);
+		if (ret) {
+			dev_err(dev, "failed to disable VDD regulator\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int fxls8962af_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct fxls8962af_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (data->vdd_reg) {
+		ret = regulator_disable(data->vdd_reg);
+		if (ret) {
+			dev_err(dev, "failed to disable VDD regulator\n");
+			return ret;
+		}
+	}
+
+	ret = fxls8962af_active(data);
+	if (ret < 0)
+		goto runtime_resume_failed;
+
+	return 0;
+
+ runtime_resume_failed:
+	if (data->vdd_reg)
+		regulator_disable(data->vdd_reg);
+
+	return ret;
+}
+#endif
+
+const struct dev_pm_ops fxls8962af_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	    SET_RUNTIME_PM_OPS(fxls8962af_runtime_suspend,
+			       fxls8962af_runtime_resume, NULL)
+};
+EXPORT_SYMBOL_GPL(fxls8962af_pm_ops);
+
+MODULE_AUTHOR("Sean Nyekjaer <sean@geanix.com>");
+MODULE_DESCRIPTION("NXP FXLS8962AF/FXLS8964AF accelerometer driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/accel/fxls8962af-i2c.c b/drivers/iio/accel/fxls8962af-i2c.c
new file mode 100644
index 000000000000..4cdbd9793df7
--- /dev/null
+++ b/drivers/iio/accel/fxls8962af-i2c.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021 Connected Cars A/S
+ */
+
+#include <linux/device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/acpi.h>
+#include <linux/regmap.h>
+
+#include "fxls8962af.h"
+
+static int fxls8962af_probe(struct i2c_client *client,
+			    const struct i2c_device_id *id)
+{
+	struct regmap *regmap;
+	const char *name = NULL;
+
+	regmap = devm_regmap_init_i2c(client, &fxls8962af_regmap_conf);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "Failed to initialize i2c regmap\n");
+		return PTR_ERR(regmap);
+	}
+
+	if (id)
+		name = id->name;
+
+	return fxls8962af_core_probe(&client->dev, regmap, client->irq, name);
+}
+
+static int fxls8962af_remove(struct i2c_client *client)
+{
+	return fxls8962af_core_remove(&client->dev);
+}
+
+static const struct i2c_device_id fxls8962af_id[] = {
+	{"fxls8962af", fxls8962af},
+	{"fxls8964af", fxls8964af},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, fxls8962af_id);
+
+static const struct of_device_id fxls8962af_of_match[] = {
+	{.compatible = "nxp,fxls8962af"},
+	{.compatible = "nxp,fxls8964af"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, fxls8962af_of_match);
+
+static struct i2c_driver fxls8962af_driver = {
+	.driver = {
+		   .name = "fxls8962af_i2c",
+		   .of_match_table = fxls8962af_of_match,
+		   .pm = &fxls8962af_pm_ops,
+		   },
+	.probe = fxls8962af_probe,
+	.remove = fxls8962af_remove,
+	.id_table = fxls8962af_id,
+};
+
+module_i2c_driver(fxls8962af_driver);
+
+MODULE_AUTHOR("Sean Nyekjaer <sean@geanix.com>");
+MODULE_DESCRIPTION("NXP FXLS8962AF/FXLS8964AF accelerometer driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/accel/fxls8962af-spi.c b/drivers/iio/accel/fxls8962af-spi.c
new file mode 100644
index 000000000000..976851863e82
--- /dev/null
+++ b/drivers/iio/accel/fxls8962af-spi.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021 Connected Cars A/S
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/slab.h>
+#include <linux/regmap.h>
+
+#include "fxls8962af.h"
+
+static const struct regmap_config fxls8962af_spi_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int fxls8962af_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id = spi_get_device_id(spi);
+	struct regmap *regmap;
+	const char *name = NULL;
+
+	regmap = devm_regmap_init_spi(spi, &fxls8962af_spi_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
+			(int)PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	if (id)
+		name = id->name;
+
+	return fxls8962af_core_probe(&spi->dev, regmap, spi->irq, name);
+}
+
+static int fxls8962af_remove(struct spi_device *spi)
+{
+	return fxls8962af_core_remove(&spi->dev);
+}
+
+static const struct of_device_id fxls8962af_spi_of_match[] = {
+	{.compatible = "nxp,fxls8962af",},
+	{.compatible = "nxp,fxls8964af",},
+	{},
+};
+MODULE_DEVICE_TABLE(of, fxls8962af_spi_of_match);
+
+static const struct spi_device_id fxls8962af_spi_id_table[] = {
+	{"fxls8962af", fxls8962af},
+	{"fxls8964af", fxls8964af},
+	{},
+};
+MODULE_DEVICE_TABLE(spi, fxls8962af_spi_id_table);
+
+static struct spi_driver fxls8962af_driver = {
+	.driver = {
+		   .name = "fxls8962af_spi",
+		   .pm = &fxls8962af_pm_ops,
+		   .of_match_table = fxls8962af_spi_of_match,
+		   },
+	.probe = fxls8962af_probe,
+	.remove = fxls8962af_remove,
+	.id_table = fxls8962af_spi_id_table,
+};
+
+module_spi_driver(fxls8962af_driver);
+
+MODULE_AUTHOR("Sean Nyekjaer <sean@geanix.com>");
+MODULE_DESCRIPTION("NXP FXLS8962AF/FXLS8964AF accelerometer driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/accel/fxls8962af.h b/drivers/iio/accel/fxls8962af.h
new file mode 100644
index 000000000000..0cc6ff36ed7c
--- /dev/null
+++ b/drivers/iio/accel/fxls8962af.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2021 Connected Cars A/S
+ */
+#ifndef _FXLS8962AF_H_
+#define _FXLS8962AF_H_
+
+struct regmap;
+
+enum {
+	fxls8962af,
+	fxls8964af,
+};
+
+int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq,
+			  const char *name);
+int fxls8962af_core_remove(struct device *dev);
+extern const struct dev_pm_ops fxls8962af_pm_ops;
+extern const struct regmap_config fxls8962af_regmap_conf;
+
+#endif				/* _FXLS8962AF_H_ */
-- 
2.31.0

