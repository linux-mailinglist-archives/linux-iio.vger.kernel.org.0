Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF73B41161A
	for <lists+linux-iio@lfdr.de>; Mon, 20 Sep 2021 15:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbhITNzI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Sep 2021 09:55:08 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:40519 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbhITNzH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Sep 2021 09:55:07 -0400
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 4A1B7240007;
        Mon, 20 Sep 2021 13:53:38 +0000 (UTC)
From:   Jacopo Mondi <jacopo+renesas@jmondi.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Peter Rosin <peda@axentia.se>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        linux-iio@vger.kernel.org, Jacopo Mondi <jacopo@jmondi.org>,
        Wolfram Sang <wsa@kernel.org>
Subject: [PATCH v6 3/4] iio: chemical: Add Senseair Sunrise 006-0-007 driver
Date:   Mon, 20 Sep 2021 15:54:12 +0200
Message-Id: <20210920135413.140310-4-jacopo+renesas@jmondi.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210920135413.140310-1-jacopo+renesas@jmondi.org>
References: <20210920135413.140310-1-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jacopo Mondi <jacopo@jmondi.org>

Add support for the Senseair Sunrise 006-0-0007 driver through the
IIO subsystem.

Datasheet: https://rmtplusstoragesenseair.blob.core.windows.net/docs/Dev/publicerat/TDE5531.pdf
Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
---
v5->v6:
- Apply style fixes from Andy
- Apply Jonathan suggestion and reduce sysfs attribute critical section
- Address Peter's comments on the regmap ops:
  - Do not use SMBUS_QUICK as it's supported by few adapters
  - Make protocol mangling optional
  - Insert a 'wake up' delay between the wake up message and the transaction
  - Check for the adapter's required functionalities
---
 MAINTAINERS                        |   7 +
 drivers/iio/chemical/Kconfig       |  10 +
 drivers/iio/chemical/Makefile      |   1 +
 drivers/iio/chemical/sunrise_co2.c | 551 +++++++++++++++++++++++++++++
 4 files changed, 569 insertions(+)
 create mode 100644 drivers/iio/chemical/sunrise_co2.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d7b4f32875a9..4f39e0d65e6d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16723,6 +16723,13 @@ S:	Maintained
 F:	drivers/misc/phantom.c
 F:	include/uapi/linux/phantom.h

+SENSEAIR SUNRISE 006-0-0007
+M:	Jacopo Mondi <jacopo@jmondi.org>
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-iio-chemical-sunrise-co2
+F:	Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.yaml
+F:	drivers/iio/chemical/sunrise_co2.c
+
 SENSIRION SCD30 CARBON DIOXIDE SENSOR DRIVER
 M:	Tomasz Duszynski <tomasz.duszynski@octakon.com>
 S:	Maintained
diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index a4920646e9be..5155ab2caed4 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -159,6 +159,16 @@ config SPS30_SERIAL
 	  To compile this driver as a module, choose M here: the module will
 	  be called sps30_serial.

+config SENSEAIR_SUNRISE_CO2
+	tristate "Senseair Sunrise 006-0-0007 CO2 sensor"
+	select REGMAP_I2C
+	help
+	  Say yes here to build support for Senseair Sunrise 006-0-0007 CO2
+	  sensor.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called sunrise_co2.
+
 config VZ89X
 	tristate "SGX Sensortech MiCS VZ89X VOC sensor"
 	depends on I2C
diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
index 4898690cc155..61e8749a84f3 100644
--- a/drivers/iio/chemical/Makefile
+++ b/drivers/iio/chemical/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_PMS7003) += pms7003.o
 obj-$(CONFIG_SCD30_CORE) += scd30_core.o
 obj-$(CONFIG_SCD30_I2C) += scd30_i2c.o
 obj-$(CONFIG_SCD30_SERIAL) += scd30_serial.o
+obj-$(CONFIG_SENSEAIR_SUNRISE_CO2) += sunrise_co2.o
 obj-$(CONFIG_SENSIRION_SGP30)	+= sgp30.o
 obj-$(CONFIG_SPS30) += sps30.o
 obj-$(CONFIG_SPS30_I2C) += sps30_i2c.o
diff --git a/drivers/iio/chemical/sunrise_co2.c b/drivers/iio/chemical/sunrise_co2.c
new file mode 100644
index 000000000000..a896561a98fa
--- /dev/null
+++ b/drivers/iio/chemical/sunrise_co2.c
@@ -0,0 +1,551 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Senseair Sunrise 006-0-0007 CO2 sensor driver.
+ *
+ * Copyright (C) 2021 Jacopo Mondi
+ *
+ * List of features not yet supported by the driver:
+ * - controllable EN pin
+ * - single-shot operations using the nDRY pin.
+ * - ABC/target calibration
+ */
+
+#include <linux/bitops.h>
+#include <linux/i2c.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/time64.h>
+
+#include <linux/iio/iio.h>
+
+#define DRIVER_NAME "sunrise_co2"
+
+#define SUNRISE_ERROR_STATUS_REG		0x00
+#define SUNRISE_CO2_FILTERED_COMP_REG		0x06
+#define SUNRISE_CHIP_TEMPERATURE_REG		0x08
+#define SUNRISE_CALIBRATION_STATUS_REG		0x81
+#define SUNRISE_CALIBRATION_COMMAND_REG		0x82
+#define SUNRISE_CALIBRATION_FACTORY_CMD		0x7c02
+#define SUNRISE_CALIBRATION_BACKGROUND_CMD	0x7c06
+/*
+ * The calibration timeout is not characterized in the datasheet.
+ * Use 30 seconds as a reasonable upper limit.
+ */
+#define SUNRISE_CALIBRATION_TIMEOUT_US		(30 * USEC_PER_SEC)
+
+struct sunrise_dev {
+	struct i2c_client *client;
+	struct regmap *regmap;
+	/* Protects access to IIO attributes. */
+	struct mutex lock;
+	bool ignore_nak;
+};
+
+/* Custom regmap read/write operations: perform unlocked access to the i2c bus. */
+
+static int sunrise_regmap_read(void *context, const void *reg_buf,
+			       size_t reg_size, void *val_buf, size_t val_size)
+{
+	struct i2c_client *client = context;
+	struct sunrise_dev *sunrise = i2c_get_clientdata(client);
+	union i2c_smbus_data data;
+	int ret;
+
+	if (reg_size != 1 || !val_size)
+		return -EINVAL;
+
+	memset(&data, 0, sizeof(data));
+	data.block[0] = val_size;
+
+	/*
+	 * Wake up sensor by sending sensor address: START, sensor address,
+	 * STOP. Sensor will not ACK this byte.
+	 *
+	 * The chip enters a low power state after 15ms without
+	 * communications or after a complete read/write sequence.
+	 */
+	__i2c_smbus_xfer(client->adapter, client->addr,
+			 sunrise->ignore_nak ? I2C_M_IGNORE_NAK : 0,
+			 I2C_SMBUS_WRITE, 0, I2C_SMBUS_BYTE_DATA, &data);
+
+	usleep_range(500, 1500);
+
+	ret = __i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+			       I2C_SMBUS_READ, ((u8 *)reg_buf)[0],
+			       I2C_SMBUS_I2C_BLOCK_DATA, &data);
+	if (ret < 0)
+		return ret;
+
+	memcpy(val_buf, &data.block[1], data.block[0]);
+
+	return 0;
+}
+
+static int sunrise_regmap_write(void *context, const void *val_buf, size_t count)
+{
+	struct i2c_client *client = context;
+	struct sunrise_dev *sunrise = i2c_get_clientdata(client);
+	union i2c_smbus_data data;
+
+	/* Discard reg address from values count. */
+	if (!count)
+		return -EINVAL;
+	count--;
+
+	memset(&data, 0, sizeof(data));
+	data.block[0] = count;
+	memcpy(&data.block[1], (u8 *)val_buf + 1, count);
+
+	__i2c_smbus_xfer(client->adapter, client->addr,
+			 sunrise->ignore_nak ? I2C_M_IGNORE_NAK : 0,
+			 I2C_SMBUS_WRITE, 0, I2C_SMBUS_BYTE_DATA, &data);
+
+	usleep_range(500, 1500);
+
+	return __i2c_smbus_xfer(client->adapter, client->addr, client->flags,
+				I2C_SMBUS_WRITE, ((u8 *)val_buf)[0],
+				I2C_SMBUS_I2C_BLOCK_DATA, &data);
+}
+
+/*
+ * Sunrise i2c read/write operations: lock the i2c segment to avoid losing the
+ * wake up session. Use custom regmap operations that perform unlocked access to
+ * the i2c bus.
+ */
+static int sunrise_read_byte(struct sunrise_dev *sunrise, u8 reg)
+{
+	const struct i2c_client *client = sunrise->client;
+	const struct device *dev = &client->dev;
+	unsigned int val;
+	int ret;
+
+	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
+	ret = regmap_read(sunrise->regmap, reg, &val);
+	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
+	if (ret) {
+		dev_err(dev, "Read byte failed: reg 0x%02x (%d)\n", reg, ret);
+		return ret;
+	}
+
+	return val;
+}
+
+static int sunrise_read_word(struct sunrise_dev *sunrise, u8 reg, u16 *val)
+{
+	const struct i2c_client *client = sunrise->client;
+	const struct device *dev = &client->dev;
+	__be16 be_val;
+	int ret;
+
+	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
+	ret = regmap_bulk_read(sunrise->regmap, reg, &be_val, sizeof(be_val));
+	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
+	if (ret) {
+		dev_err(dev, "Read word failed: reg 0x%02x (%d)\n", reg, ret);
+		return ret;
+	}
+
+	*val = be16_to_cpu(be_val);
+
+	return 0;
+}
+
+static int sunrise_write_byte(struct sunrise_dev *sunrise, u8 reg, u8 val)
+{
+	const struct i2c_client *client = sunrise->client;
+	const struct device *dev = &client->dev;
+	int ret;
+
+	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
+	ret = regmap_write(sunrise->regmap, reg, val);
+	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
+	if (ret)
+		dev_err(dev, "Write byte failed: reg 0x%02x (%d)\n", reg, ret);
+
+	return ret;
+}
+
+static int sunrise_write_word(struct sunrise_dev *sunrise, u8 reg, u16 data)
+{
+	const struct i2c_client *client = sunrise->client;
+	const struct device *dev = &client->dev;
+	__be16 be_data = cpu_to_be16(data);
+	int ret;
+
+	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
+	ret = regmap_bulk_write(sunrise->regmap, reg, &be_data, sizeof(be_data));
+	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
+	if (ret)
+		dev_err(dev, "Write word failed: reg 0x%02x (%d)\n", reg, ret);
+
+	return ret;
+}
+
+/* Trigger a calibration cycle. */
+
+enum {
+	SUNRISE_CALIBRATION_FACTORY,
+	SUNRISE_CALIBRATION_BACKGROUND,
+};
+
+static const struct sunrise_calib_data {
+	u16 cmd;
+	u8 bit;
+	const char * const name;
+} calib_data[] = {
+	[SUNRISE_CALIBRATION_FACTORY] = {
+		SUNRISE_CALIBRATION_FACTORY_CMD,
+		BIT(2),
+		"factory_calibration",
+	},
+	[SUNRISE_CALIBRATION_BACKGROUND] = {
+		SUNRISE_CALIBRATION_BACKGROUND_CMD,
+		BIT(5),
+		"background_calibration",
+	},
+};
+
+static int sunrise_calibrate(struct sunrise_dev *sunrise,
+			     const struct sunrise_calib_data *data)
+{
+	unsigned int status;
+	int ret;
+
+	/* Reset the calibration status reg. */
+	ret = sunrise_write_byte(sunrise, SUNRISE_CALIBRATION_STATUS_REG, 0x00);
+	if (ret)
+		return ret;
+
+	/* Write a calibration command and poll the calibration status bit. */
+	ret = sunrise_write_word(sunrise, SUNRISE_CALIBRATION_COMMAND_REG, data->cmd);
+	if (ret)
+		return ret;
+
+	dev_dbg(&sunrise->client->dev, "%s in progress\n", data->name);
+
+	/*
+	 * Calibration takes several seconds, so the sleep time between reads
+	 * can be pretty relaxed.
+	 */
+	return read_poll_timeout(sunrise_read_byte, status, status & data->bit,
+				 200000, SUNRISE_CALIBRATION_TIMEOUT_US, false,
+				 sunrise, SUNRISE_CALIBRATION_STATUS_REG);
+}
+
+static ssize_t sunrise_cal_factory_write(struct iio_dev *iiodev,
+					 uintptr_t private,
+					 const struct iio_chan_spec *chan,
+					 const char *buf, size_t len)
+{
+	struct sunrise_dev *sunrise = iio_priv(iiodev);
+	bool enable;
+	int ret;
+
+	ret = kstrtobool(buf, &enable);
+	if (ret)
+		return ret;
+
+	if (!enable)
+		return len;
+
+	mutex_lock(&sunrise->lock);
+	ret = sunrise_calibrate(sunrise, &calib_data[SUNRISE_CALIBRATION_FACTORY]);
+	mutex_unlock(&sunrise->lock);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static ssize_t sunrise_cal_background_write(struct iio_dev *iiodev,
+					    uintptr_t private,
+					    const struct iio_chan_spec *chan,
+					    const char *buf, size_t len)
+{
+	struct sunrise_dev *sunrise = iio_priv(iiodev);
+	bool enable;
+	int ret;
+
+	ret = kstrtobool(buf, &enable);
+	if (ret)
+		return ret;
+
+	if (!enable)
+		return len;
+
+	mutex_lock(&sunrise->lock);
+	ret = sunrise_calibrate(sunrise, &calib_data[SUNRISE_CALIBRATION_BACKGROUND]);
+	mutex_unlock(&sunrise->lock);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+ /* Enumerate and retrieve the chip error status. */
+enum {
+	SUNRISE_ERROR_FATAL,
+	SUNRISE_ERROR_I2C,
+	SUNRISE_ERROR_ALGORITHM,
+	SUNRISE_ERROR_CALIBRATION,
+	SUNRISE_ERROR_SELF_DIAGNOSTIC,
+	SUNRISE_ERROR_OUT_OF_RANGE,
+	SUNRISE_ERROR_MEMORY,
+	SUNRISE_ERROR_NO_MEASUREMENT,
+	SUNRISE_ERROR_LOW_VOLTAGE,
+	SUNRISE_ERROR_MEASUREMENT_TIMEOUT,
+};
+
+static const char * const sunrise_error_statuses[] = {
+	[SUNRISE_ERROR_FATAL] = "error_fatal",
+	[SUNRISE_ERROR_I2C] = "error_i2c",
+	[SUNRISE_ERROR_ALGORITHM] = "error_algorithm",
+	[SUNRISE_ERROR_CALIBRATION] = "error_calibration",
+	[SUNRISE_ERROR_SELF_DIAGNOSTIC] = "error_self_diagnostic",
+	[SUNRISE_ERROR_OUT_OF_RANGE] = "error_out_of_range",
+	[SUNRISE_ERROR_MEMORY] = "error_memory",
+	[SUNRISE_ERROR_NO_MEASUREMENT] = "error_no_measurement",
+	[SUNRISE_ERROR_LOW_VOLTAGE] = "error_low_voltage",
+	[SUNRISE_ERROR_MEASUREMENT_TIMEOUT] = "error_measurement_timeout",
+};
+
+static const struct iio_enum sunrise_error_statuses_enum = {
+	.items = sunrise_error_statuses,
+	.num_items = ARRAY_SIZE(sunrise_error_statuses),
+};
+
+static ssize_t sunrise_error_status_read(struct iio_dev *iiodev,
+					 uintptr_t private,
+					 const struct iio_chan_spec *chan,
+					 char *buf)
+{
+	struct sunrise_dev *sunrise = iio_priv(iiodev);
+	unsigned long errors;
+	ssize_t len = 0;
+	u16 value;
+	int ret;
+	u8 i;
+
+	mutex_lock(&sunrise->lock);
+	ret = sunrise_read_word(sunrise, SUNRISE_ERROR_STATUS_REG, &value);
+	if (ret) {
+		mutex_unlock(&sunrise->lock);
+		return ret;
+	}
+
+	errors = value;
+	for_each_set_bit(i, &errors, ARRAY_SIZE(sunrise_error_statuses))
+		len += sysfs_emit_at(buf, len, "%s ", sunrise_error_statuses[i]);
+
+	if (len)
+		buf[len - 1] = '\n';
+
+	mutex_unlock(&sunrise->lock);
+
+	return len;
+}
+
+static const struct iio_chan_spec_ext_info sunrise_concentration_ext_info[] = {
+	/* Calibration triggers. */
+	{
+		.name = "calibration_factory",
+		.write = sunrise_cal_factory_write,
+		.shared = IIO_SEPARATE,
+	},
+	{
+		.name = "calibration_background",
+		.write = sunrise_cal_background_write,
+		.shared = IIO_SEPARATE,
+	},
+
+	/* Error statuses. */
+	{
+		.name = "error_status",
+		.read = sunrise_error_status_read,
+		.shared = IIO_SHARED_BY_ALL,
+	},
+	{
+		.name = "error_status_available",
+		.shared = IIO_SHARED_BY_ALL,
+		.read = iio_enum_available_read,
+		.private = (uintptr_t)&sunrise_error_statuses_enum,
+	},
+	{}
+};
+
+static const struct iio_chan_spec sunrise_channels[] = {
+	{
+		.type = IIO_CONCENTRATION,
+		.modified = 1,
+		.channel2 = IIO_MOD_CO2,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.ext_info = sunrise_concentration_ext_info,
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
+	},
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
+	},
+};
+
+static int sunrise_read_raw(struct iio_dev *iio_dev,
+			    const struct iio_chan_spec *chan,
+			    int *val, int *val2, long mask)
+{
+	struct sunrise_dev *sunrise = iio_priv(iio_dev);
+	u16 value;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_CONCENTRATION:
+			mutex_lock(&sunrise->lock);
+			ret = sunrise_read_word(sunrise, SUNRISE_CO2_FILTERED_COMP_REG,
+						&value);
+			*val = value;
+			mutex_unlock(&sunrise->lock);
+
+			if (ret)
+				return ret;
+
+			return IIO_VAL_INT;
+
+		case IIO_TEMP:
+			mutex_lock(&sunrise->lock);
+			ret = sunrise_read_word(sunrise, SUNRISE_CHIP_TEMPERATURE_REG,
+						&value);
+			*val = value;
+			mutex_unlock(&sunrise->lock);
+
+			if (ret)
+				return ret;
+
+			return IIO_VAL_INT;
+
+		default:
+			return -EINVAL;
+		}
+
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_CONCENTRATION:
+			/*
+			 * 1 / 10^4 to comply with IIO scale for CO2
+			 * (percentage). The chip CO2 reading range is [400 -
+			 * 5000] ppm which corresponds to [0,004 - 0,5] %.
+			 */
+			*val = 1;
+			*val2 = 10000;
+			return IIO_VAL_FRACTIONAL;
+
+		case IIO_TEMP:
+			/* x10 to comply with IIO scale (millidegrees celsius). */
+			*val = 10;
+			return IIO_VAL_INT;
+
+		default:
+			return -EINVAL;
+		}
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info sunrise_info = {
+	.read_raw = sunrise_read_raw,
+};
+
+static const struct regmap_bus sunrise_regmap_bus = {
+	.read = sunrise_regmap_read,
+	.write = sunrise_regmap_write,
+};
+
+static const struct regmap_config sunrise_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int sunrise_probe(struct i2c_client *client)
+{
+	struct sunrise_dev *sunrise;
+	struct iio_dev *iio_dev;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA |
+						      I2C_FUNC_SMBUS_BLOCK_DATA)) {
+		dev_err(&client->dev,
+			"Adapter does not support required functionalities\n");
+		return -EOPNOTSUPP;
+	}
+
+	iio_dev = devm_iio_device_alloc(&client->dev, sizeof(*sunrise));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	sunrise = iio_priv(iio_dev);
+	sunrise->client = client;
+	mutex_init(&sunrise->lock);
+
+	i2c_set_clientdata(client, sunrise);
+
+	sunrise->regmap = devm_regmap_init(&client->dev, &sunrise_regmap_bus,
+					   client, &sunrise_regmap_config);
+	if (IS_ERR(sunrise->regmap)) {
+		dev_err(&client->dev, "Failed to initialize regmap\n");
+		return PTR_ERR(sunrise->regmap);
+	}
+
+	/*
+	 * The chip nacks the wake up message. If the adapter does not support
+	 * protocol mangling do not set the I2C_M_IGNORE_NAK flag at the expense
+	 * of possible cruft in the logs.
+	 */
+	if (i2c_check_functionality(client->adapter, I2C_FUNC_PROTOCOL_MANGLING))
+		sunrise->ignore_nak = true;
+
+	iio_dev->info = &sunrise_info;
+	iio_dev->name = DRIVER_NAME;
+	iio_dev->channels = sunrise_channels;
+	iio_dev->num_channels = ARRAY_SIZE(sunrise_channels);
+	iio_dev->modes = INDIO_DIRECT_MODE;
+
+	return devm_iio_device_register(&client->dev, iio_dev);
+}
+
+static const struct of_device_id sunrise_of_match[] = {
+	{ .compatible = "senseair,sunrise-006-0-0007" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, sunrise_of_match);
+
+static struct i2c_driver sunrise_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.of_match_table = sunrise_of_match,
+	},
+	.probe_new = sunrise_probe,
+};
+module_i2c_driver(sunrise_driver);
+
+MODULE_AUTHOR("Jacopo Mondi <jacopo@jmondi.org>");
+MODULE_DESCRIPTION("Senseair Sunrise 006-0-0007 CO2 sensor IIO driver");
+MODULE_LICENSE("GPL v2");
--
2.32.0

