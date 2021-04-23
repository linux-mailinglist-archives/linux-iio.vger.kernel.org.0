Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CD436903B
	for <lists+linux-iio@lfdr.de>; Fri, 23 Apr 2021 12:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhDWKVC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Apr 2021 06:21:02 -0400
Received: from first.geanix.com ([116.203.34.67]:42622 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230502AbhDWKVC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 23 Apr 2021 06:21:02 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 24A9146523B;
        Fri, 23 Apr 2021 10:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1619173218; bh=os/fxQWgk9+TW1s+l8OnCUhqQjtB80flZ5CCntBbczk=;
        h=From:To:Cc:Subject:Date;
        b=ZMDgnYLC0AWSn43itq4Y3SiWMowMopHIAEulxYcqmSNDbtBP0xXR1cKvkivwmERhU
         4D/VzSIm5fJCbKaHGdOumheGvBGTv58o3TY+x95TAI6rcqE2PTjdk3LS0CsVaBLze3
         9oQhuIQEt0i/bTQK45SasMX0cZvsY4DT5UYqQGQxiN041T/n+/lWBErE8wOhBeER5Y
         P2fIXsS1btYAWx6G0ift1o5MxZltlrOwd3m45T9iTscwXs0ugVX/sLspK5bb/9JaY8
         2dv3kGi9UP1PsWrS+4ms5WMdjA3FfpFITQRcxVTIxVgbtgLPXGRLf7W1qY7lH6Dt9J
         US+ihYxH7VXOg==
From:   Sean Nyekjaer <sean@geanix.com>
To:     jic23@kernel.org, linux-iio@vger.kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de, Nuno.Sa@analog.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH v2 1/2] iio: accel: add support for FXLS8962AF/FXLS8964AF accelerometers
Date:   Fri, 23 Apr 2021 12:19:50 +0200
Message-Id: <20210423101951.2876009-1-sean@geanix.com>
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

Datasheets for the devices can be found here:
https://www.nxp.com/docs/en/data-sheet/FXLS8962AF.pdf
https://www.nxp.com/docs/en/data-sheet/FXLS8964AF.pdf

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Changes for v2: 
 - Addressed Kconfig comments
 - Using regmap_read_poll_timeout()
 - Addresed comments from Andy and Jonathan

 drivers/iio/accel/Kconfig           |  27 ++
 drivers/iio/accel/Makefile          |   3 +
 drivers/iio/accel/fxls8962af-core.c | 620 ++++++++++++++++++++++++++++
 drivers/iio/accel/fxls8962af-i2c.c  |  57 +++
 drivers/iio/accel/fxls8962af-spi.c  |  57 +++
 drivers/iio/accel/fxls8962af.h      |  21 +
 6 files changed, 785 insertions(+)
 create mode 100644 drivers/iio/accel/fxls8962af-core.c
 create mode 100644 drivers/iio/accel/fxls8962af-i2c.c
 create mode 100644 drivers/iio/accel/fxls8962af-spi.c
 create mode 100644 drivers/iio/accel/fxls8962af.h

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 2e0c62c39155..902f2e2edf65 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -208,6 +208,33 @@ config DMARD10
 	  Choosing M will build the driver as a module. If so, the module
 	  will be called dmard10.
 
+config FXLS8962AF
+	tristate
+
+config FXLS8962AF_I2C
+	tristate "NXP FXLS8962AF/FXLS8964AF Accelerometer I2C Driver"
+	depends on I2C
+	select REGMAP_I2C
+	select FXLS8962AF
+	help
+	  Say yes here to build support for the NXP 3-axis automotive
+	  accelerometer FXLS8962AF/FXLS8964AF with I2C support.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called fxls8962af_i2c.
+
+config FXLS8962AF_SPI
+	tristate "NXP FXLS8962AF/FXLS8964AF Accelerometer SPI Driver"
+	depends on SPI
+	select FXLS8962AF
+	select REGMAP_SPI
+	help
+	  Say yes here to build support for the NXP 3-axis automotive
+	  accelerometer FXLS8962AF/FXLS8964AF with SPI support.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called fxls8962af_spi.
+
 config HID_SENSOR_ACCEL_3D
 	depends on HID_SENSOR_HUB
 	select IIO_BUFFER
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 4f6c1ebe13b0..1b8c479c6f7c 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -25,6 +25,9 @@ obj-$(CONFIG_DA311)	+= da311.o
 obj-$(CONFIG_DMARD06)	+= dmard06.o
 obj-$(CONFIG_DMARD09)	+= dmard09.o
 obj-$(CONFIG_DMARD10)	+= dmard10.o
+obj-$(CONFIG_FXLS8962AF)	+= fxls8962af-core.o
+obj-$(CONFIG_FXLS8962AF_I2C)	+= fxls8962af-i2c.o
+obj-$(CONFIG_FXLS8962AF_SPI)	+= fxls8962af-spi.o
 obj-$(CONFIG_HID_SENSOR_ACCEL_3D) += hid-sensor-accel-3d.o
 obj-$(CONFIG_KXCJK1013) += kxcjk-1013.o
 obj-$(CONFIG_KXSD9)	+= kxsd9.o
diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
new file mode 100644
index 000000000000..6fda3bc1f28f
--- /dev/null
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -0,0 +1,620 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NXP FXLS8962AF/FXLS8964AF Accelerometer Core Driver
+ *
+ * Copyright 2021 Connected Cars A/S
+ *
+ * Datasheet:
+ * https://www.nxp.com/docs/en/data-sheet/FXLS8962AF.pdf
+ * https://www.nxp.com/docs/en/data-sheet/FXLS8964AF.pdf
+ */
+
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
+#include <linux/regmap.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
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
+#define FXLS8962AF_SC1_FSR_MASK			GENMASK(2, 1)
+#define FXLS8962AF_SC1_FSR_PREP(x)		FIELD_PREP(FXLS8962AF_SC1_FSR_MASK, x)
+#define FXLS8962AF_SC1_FSR_GET(x)		FIELD_GET(FXLS8962AF_SC1_FSR_MASK, x)
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
+/*Raw temp channel offset */
+#define FXLS8962AF_TEMP_CENTER_VAL		25
+
+#define FXLS8962AF_AUTO_SUSPEND_DELAY_MS	2000
+
+#define FXLS8962AF_SCALE_TABLE_LEN		4
+
+static const int fxls8962af_scale_table[FXLS8962AF_SCALE_TABLE_LEN][2] = {
+	{0, IIO_G_TO_M_S_2(980000)},
+	{0, IIO_G_TO_M_S_2(1950000)},
+	{0, IIO_G_TO_M_S_2(3910000)},
+	{0, IIO_G_TO_M_S_2(7810000)},
+};
+
+struct fxls8962af_chip_info {
+	const char *name;
+	const struct iio_chan_spec *channels;
+	int num_channels;
+	u8 chip_id;
+};
+
+struct fxls8962af_data {
+	struct regmap *regmap;
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
+	fxls8962af_idx_x,
+	fxls8962af_idx_y,
+	fxls8962af_idx_z,
+	fxls8962af_idx_ts,
+};
+
+static int fxls8962af_drdy(struct fxls8962af_data *data)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	unsigned int reg;
+	int ret;
+
+	ret = regmap_read_poll_timeout(data->regmap, FXLS8962AF_INT_STATUS, reg,
+			(reg & FXLS8962AF_INT_STATUS_SRC_DRDY), 20000, 2000000);
+	if (ret) {
+		dev_err(dev, "drdy timeout, int_status = 0x%x\n", reg);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int fxls8962af_power_on(struct fxls8962af_data *data)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
+
+	ret = pm_runtime_get_sync(dev);
+
+	if (ret < 0) {
+		dev_err(dev, "failed to power on\n");
+		pm_runtime_put_noidle(dev);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int fxls8962af_power_off(struct fxls8962af_data *data)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
+
+	pm_runtime_mark_last_busy(dev);
+	ret = pm_runtime_put_autosuspend(dev);
+
+	if (ret < 0) {
+		dev_err(dev, "failed to power off\n");
+		return ret;
+	}
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
+	ret = fxls8962af_drdy(data);
+	if (ret < 0)
+		return ret;
+
+	ret = fxls8962af_power_on(data);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap, FXLS8962AF_TEMP_OUT, &value);
+	if (ret < 0) {
+		dev_err(dev, "Error reading reg_temp\n");
+		fxls8962af_power_off(data);
+		return ret;
+	}
+
+	fxls8962af_power_off(data);
+
+	*val = sign_extend32(value, 7);
+
+	return IIO_VAL_INT;
+}
+
+static int fxls8962af_get_axis(struct fxls8962af_data *data,
+			       struct iio_chan_spec const *chan, int *val)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
+	__le16 raw_val;
+
+	ret = fxls8962af_drdy(data);
+	if (ret < 0)
+		return ret;
+
+	ret = fxls8962af_power_on(data);
+	if (ret)
+		return ret;
+
+	ret = regmap_bulk_read(data->regmap, chan->address,
+			       &raw_val, sizeof(raw_val));
+	if (ret < 0) {
+		dev_err(dev, "failed to read axes\n");
+		fxls8962af_power_off(data);
+		return ret;
+	}
+
+	fxls8962af_power_off(data);
+
+	*val = sign_extend32(le16_to_cpu(raw_val), chan->scan_type.realbits - 1);
+
+	return IIO_VAL_INT;
+}
+
+static int fxls8962af_read_avail(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan,
+				 const int **vals, int *type, int *length,
+				 long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*type = IIO_VAL_INT_PLUS_NANO;
+		*vals = (int *)fxls8962af_scale_table;
+		*length = ARRAY_SIZE(fxls8962af_scale_table) * 2;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int fxls8962af_write_raw_get_fmt(struct iio_dev *indio_dev,
+					struct iio_chan_spec const *chan,
+					long mask)
+{
+	return IIO_VAL_INT_PLUS_NANO;
+}
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
+	is_active = fxls8962af_is_active(data);
+	if (is_active) {
+		ret = fxls8962af_standby(data);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = regmap_update_bits(data->regmap, reg, mask, val);
+	if (ret < 0)
+		return ret;
+
+	if (is_active) {
+		ret = fxls8962af_active(data);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int fxls8962af_set_full_scale(struct fxls8962af_data *data, u32 scale)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(fxls8962af_scale_table); i++)
+		if (scale == fxls8962af_scale_table[i][1])
+			break;
+
+	if (i == ARRAY_SIZE(fxls8962af_scale_table))
+		return -EINVAL;
+
+	return fxls8962af_update_config(data, FXLS8962AF_SENS_CONFIG1,
+					FXLS8962AF_SC1_FSR_MASK,
+					FXLS8962AF_SC1_FSR_PREP(i));
+}
+
+static unsigned int fxls8962af_read_full_scale(struct fxls8962af_data *data,
+					       int *val)
+{
+	int ret;
+	unsigned int reg;
+	u8 range_idx;
+
+	ret = regmap_read(data->regmap, FXLS8962AF_SENS_CONFIG1, &reg);
+	if (ret < 0)
+		return ret;
+
+	range_idx = FXLS8962AF_SC1_FSR_GET(reg);
+
+	*val = fxls8962af_scale_table[range_idx][1];
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
+			break;
+		}
+
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
+	case IIO_CHAN_INFO_OFFSET:
+		if (chan->type == IIO_TEMP) {
+			*val = FXLS8962AF_TEMP_CENTER_VAL;
+			return IIO_VAL_INT;
+		}
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+		return fxls8962af_read_full_scale(data, val2);
+	default:
+		return -EINVAL;
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
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		if (val != 0)
+			return -EINVAL;
+
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		ret = fxls8962af_set_full_scale(data, val2);
+
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
+#define FXLS8962AF_CHANNEL(axis, reg, idx) { \
+	.type = IIO_ACCEL, \
+	.address = reg, \
+	.modified = 1, \
+	.channel2 = IIO_MOD_##axis, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE), \
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
+		.realbits = 8, \
+	}, \
+}
+
+static const struct iio_chan_spec fxls8962af_channels[] = {
+	FXLS8962AF_CHANNEL(X, FXLS8962AF_OUT_X_LSB, fxls8962af_idx_x),
+	FXLS8962AF_CHANNEL(Y, FXLS8962AF_OUT_Y_LSB, fxls8962af_idx_y),
+	FXLS8962AF_CHANNEL(Z, FXLS8962AF_OUT_Z_LSB, fxls8962af_idx_z),
+	IIO_CHAN_SOFT_TIMESTAMP(fxls8962af_idx_ts),
+	FXLS8962AF_TEMP_CHANNEL,
+};
+
+static const struct fxls8962af_chip_info fxls_chip_info_table[] = {
+	[fxls8962af] = {
+		.chip_id = FXLS8962AF_DEVICE_ID,
+		.name = "fxls8962af",
+		.channels = fxls8962af_channels,
+		.num_channels = ARRAY_SIZE(fxls8962af_channels),
+	},
+	[fxls8964af] = {
+		.chip_id = FXLS8964AF_DEVICE_ID,
+		.name = "fxls8964af",
+		.channels = fxls8962af_channels,
+		.num_channels = ARRAY_SIZE(fxls8962af_channels),
+	},
+};
+
+static const struct iio_info fxls8962af_info = {
+	.read_raw = &fxls8962af_read_raw,
+	.write_raw = &fxls8962af_write_raw,
+	.write_raw_get_fmt = fxls8962af_write_raw_get_fmt,
+	.read_avail = fxls8962af_read_avail,
+};
+
+static int fxls8962af_reset(struct fxls8962af_data *data)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	unsigned int reg;
+	int ret;
+
+	ret = regmap_update_bits(data->regmap, FXLS8962AF_SENS_CONFIG1,
+				 FXLS8962AF_SENS_CONFIG1_RST,
+				 FXLS8962AF_SENS_CONFIG1_RST);
+	if (ret < 0)
+		return ret;
+
+	/* TBOOT1, TBOOT2, specifies we have to wait between 1 - 17.7ms */
+	ret = regmap_read_poll_timeout(data->regmap, FXLS8962AF_SENS_CONFIG1, reg,
+			!(reg & FXLS8962AF_SENS_CONFIG1_RST), 1000, 18000);
+	if (ret) {
+		dev_err(dev, "reset timeout, sens_config1 = 0x%x\n", reg);
+		return ret;
+	}
+
+	return ret;
+}
+
+static void fxls8962af_regulator_disable(void *data_ptr)
+{
+	struct fxls8962af_data *data = data_ptr;
+
+	regulator_disable(data->vdd_reg);
+}
+
+static void fxls8962af_pm_disable(void *dev_ptr)
+{
+	struct device *dev = dev_ptr;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_put_noidle(dev);
+
+	fxls8962af_standby(iio_priv(indio_dev));
+}
+
+int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
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
+	data->regmap = regmap;
+
+	ret = iio_read_mount_matrix(dev, "mount-matrix", &data->orientation);
+	if (ret)
+		return ret;
+
+	data->vdd_reg = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(data->vdd_reg))
+		return dev_err_probe(dev, PTR_ERR(data->vdd_reg),
+				     "Failed to get vdd regulator\n");
+
+	ret = regulator_enable(data->vdd_reg);
+	if (ret) {
+		dev_err(dev, "Failed to enable vdd regulator: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev, fxls8962af_regulator_disable, data);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap, FXLS8962AF_WHO_AM_I, &reg);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(fxls_chip_info_table); i++) {
+		if (fxls_chip_info_table[i].chip_id == reg) {
+			data->chip_info = &fxls_chip_info_table[i];
+			break;
+		}
+	}
+	if (i == ARRAY_SIZE(fxls_chip_info_table)) {
+		dev_err(dev, "failed to match device in table\n");
+		return -ENXIO;
+	}
+
+	indio_dev->channels = data->chip_info->channels;
+	indio_dev->num_channels = data->chip_info->num_channels;
+	indio_dev->name = data->chip_info->name;
+	indio_dev->info = &fxls8962af_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = fxls8962af_reset(data);
+	if (ret < 0)
+		return ret;
+
+	ret = pm_runtime_set_active(dev);
+	if (ret < 0)
+		return ret;
+
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev, FXLS8962AF_AUTO_SUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+
+	ret = devm_add_action_or_reset(dev, fxls8962af_pm_disable, dev);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+EXPORT_SYMBOL_GPL(fxls8962af_core_probe);
+
+static int __maybe_unused fxls8962af_runtime_suspend(struct device *dev)
+{
+	struct fxls8962af_data *data = iio_priv(dev_get_drvdata(dev));
+	int ret;
+
+	ret = fxls8962af_standby(data);
+	if (ret < 0) {
+		dev_err(dev, "powering off device failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __maybe_unused fxls8962af_runtime_resume(struct device *dev)
+{
+	struct fxls8962af_data *data = iio_priv(dev_get_drvdata(dev));
+
+	return fxls8962af_active(data);
+}
+
+const struct dev_pm_ops fxls8962af_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(fxls8962af_runtime_suspend,
+			   fxls8962af_runtime_resume, NULL)
+};
+EXPORT_SYMBOL_GPL(fxls8962af_pm_ops);
+
+MODULE_AUTHOR("Sean Nyekjaer <sean@geanix.com>");
+MODULE_DESCRIPTION("NXP FXLS8962AF/FXLS8964AF accelerometer driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/accel/fxls8962af-i2c.c b/drivers/iio/accel/fxls8962af-i2c.c
new file mode 100644
index 000000000000..0dd86ece46ae
--- /dev/null
+++ b/drivers/iio/accel/fxls8962af-i2c.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NXP FXLS8962AF/FXLS8964AF Accelerometer I2C Driver
+ *
+ * Copyright 2021 Connected Cars A/S
+ */
+
+#include <linux/dev_printk.h>
+#include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+#include "fxls8962af.h"
+
+static int fxls8962af_probe(struct i2c_client *client)
+{
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_i2c(client, &fxls8962af_regmap_conf);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "Failed to initialize i2c regmap\n");
+		return PTR_ERR(regmap);
+	}
+
+	return fxls8962af_core_probe(&client->dev, regmap, client->irq);
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
+	{}
+};
+MODULE_DEVICE_TABLE(of, fxls8962af_of_match);
+
+static struct i2c_driver fxls8962af_driver = {
+	.driver = {
+		   .name = "fxls8962af_i2c",
+		   .of_match_table = fxls8962af_of_match,
+		   .pm = &fxls8962af_pm_ops,
+		   },
+	.probe_new = fxls8962af_probe,
+	.id_table = fxls8962af_id,
+};
+
+module_i2c_driver(fxls8962af_driver);
+
+MODULE_AUTHOR("Sean Nyekjaer <sean@geanix.com>");
+MODULE_DESCRIPTION("NXP FXLS8962AF/FXLS8964AF accelerometer i2c driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/accel/fxls8962af-spi.c b/drivers/iio/accel/fxls8962af-spi.c
new file mode 100644
index 000000000000..0597c3fef504
--- /dev/null
+++ b/drivers/iio/accel/fxls8962af-spi.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NXP FXLS8962AF/FXLS8964AF Accelerometer SPI Driver
+ *
+ * Copyright 2021 Connected Cars A/S
+ */
+
+#include <linux/dev_printk.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+//#include <linux/slab.h>
+#include <linux/regmap.h>
+
+#include "fxls8962af.h"
+
+static int fxls8962af_probe(struct spi_device *spi)
+{
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_spi(spi, &fxls8962af_regmap_conf);
+	if (IS_ERR(regmap)) {
+		dev_err(&spi->dev, "Failed to initialize spi regmap\n");
+		return PTR_ERR(regmap);
+	}
+
+	return fxls8962af_core_probe(&spi->dev, regmap, spi->irq);
+}
+
+static const struct of_device_id fxls8962af_spi_of_match[] = {
+	{.compatible = "nxp,fxls8962af"},
+	{.compatible = "nxp,fxls8964af"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, fxls8962af_spi_of_match);
+
+static const struct spi_device_id fxls8962af_spi_id_table[] = {
+	{"fxls8962af", fxls8962af},
+	{"fxls8964af", fxls8964af},
+	{}
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
+	.id_table = fxls8962af_spi_id_table,
+};
+
+module_spi_driver(fxls8962af_driver);
+
+MODULE_AUTHOR("Sean Nyekjaer <sean@geanix.com>");
+MODULE_DESCRIPTION("NXP FXLS8962AF/FXLS8964AF accelerometer spi driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/accel/fxls8962af.h b/drivers/iio/accel/fxls8962af.h
new file mode 100644
index 000000000000..1dc3b0e317dc
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
+struct device;
+
+enum {
+	fxls8962af,
+	fxls8964af,
+};
+
+int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq);
+int fxls8962af_core_remove(struct device *dev);
+extern const struct dev_pm_ops fxls8962af_pm_ops;
+extern const struct regmap_config fxls8962af_regmap_conf;
+
+#endif				/* _FXLS8962AF_H_ */
-- 
2.31.0

