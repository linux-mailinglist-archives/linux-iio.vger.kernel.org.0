Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64E323EEF85
	for <lists+linux-iio@lfdr.de>; Tue, 17 Aug 2021 17:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240347AbhHQPxN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Aug 2021 11:53:13 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:46713 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240416AbhHQPuF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Aug 2021 11:50:05 -0400
Received: (Authenticated sender: jacopo@jmondi.org)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id E8997200002;
        Tue, 17 Aug 2021 15:49:15 +0000 (UTC)
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     Jacopo Mondi <jacopo@jmondi.org>, linux-iio@vger.kernel.org
Subject: [PATCH 2/2] iio: chemical: Add Senseair Sunrise 006-0-007 driver
Date:   Tue, 17 Aug 2021 17:49:51 +0200
Message-Id: <20210817154951.50208-3-jacopo@jmondi.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817154951.50208-1-jacopo@jmondi.org>
References: <20210817154951.50208-1-jacopo@jmondi.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for the Senseair Sunrise 006-0-0007 driver through the
IIO subsystem.

Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
---
 MAINTAINERS                    |   6 +
 drivers/iio/chemical/Kconfig   |  10 ++
 drivers/iio/chemical/Makefile  |   1 +
 drivers/iio/chemical/sunrise.c | 310 +++++++++++++++++++++++++++++++++
 4 files changed, 327 insertions(+)
 create mode 100644 drivers/iio/chemical/sunrise.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 90ca9df1d3c3..10a33fd2ccb8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16544,6 +16544,12 @@ S:	Maintained
 F:	drivers/misc/phantom.c
 F:	include/uapi/linux/phantom.h
 
+SENSEAIR SUNRISE 006-0-0007
+M:	Jacopo Mondi <jacopo@jmondi.org>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/chemical/senseair,sunrise.yaml
+F:	drivers/iio/chemical/sunrise.c
+
 SENSIRION SCD30 CARBON DIOXIDE SENSOR DRIVER
 M:	Tomasz Duszynski <tomasz.duszynski@octakon.com>
 S:	Maintained
diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index 10bb431bc3ce..c308379076ba 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -144,6 +144,16 @@ config SPS30
 	  To compile this driver as a module, choose M here: the module will
 	  be called sps30.
 
+config SUNRISE
+	tristate "Senseair Sunrise 006-0-0007 CO2 sensor"
+	depends on I2C
+	help
+	  Say yes here to build support for Senseair Sunrise 006-0-0007 CO2
+	  sensor.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called sunrise.
+
 config VZ89X
 	tristate "SGX Sensortech MiCS VZ89X VOC sensor"
 	depends on I2C
diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
index fef63dd5bf92..24b8d63d05bd 100644
--- a/drivers/iio/chemical/Makefile
+++ b/drivers/iio/chemical/Makefile
@@ -17,4 +17,5 @@ obj-$(CONFIG_SCD30_I2C) += scd30_i2c.o
 obj-$(CONFIG_SCD30_SERIAL) += scd30_serial.o
 obj-$(CONFIG_SENSIRION_SGP30)	+= sgp30.o
 obj-$(CONFIG_SPS30) += sps30.o
+obj-$(CONFIG_SUNRISE) += sunrise.o
 obj-$(CONFIG_VZ89X)		+= vz89x.o
diff --git a/drivers/iio/chemical/sunrise.c b/drivers/iio/chemical/sunrise.c
new file mode 100644
index 000000000000..582633e86d1d
--- /dev/null
+++ b/drivers/iio/chemical/sunrise.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * iio/co2/sunrise-006-0-0007.c
+ *
+ * Senseair Sunrise 006-0-0007 CO2 sensor driver.
+ *
+ * Copyright (C) 2021 Jacopo Mondi
+ *
+ * The driver supports continuous measurement operation mode only.
+ * TODO: Add support for controllable EN pin
+ * TODO: Add support for single-shot operations by using the nDRY pin.
+ */
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_device.h>
+
+#define DRIVER_NAME "sunrise"
+
+#define SUNRISE_ERROR_STATUS_REG		0x00
+#define SUNRISE_ERROR_OOR_ERR			BIT(5)
+#define SUNRISE_CO2_FILTERED_COMP_REG		0x06
+#define SUNRISE_CHIP_TEMPERATURE_REG		0x08
+#define SUNRISE_CALIBRATION_STATUS_REG		0x81
+#define SUNRISE_CALIBRATION_COMMAND_REG		0x082
+#define SUNRISE_CALIBRATION_BACKGROUND_CMD	0x7c06
+
+struct sunrise_dev {
+	struct i2c_client *client;
+	struct mutex lock;
+};
+
+static void sunrise_wakeup(struct i2c_client *client)
+{
+	/*
+	 * Ping to wakeup: the chip returns in low power state after 15 msec
+	 * without communications or after a complete read/write sequence.
+	 */
+	i2c_smbus_read_byte(client);
+}
+
+static int sunrise_read_byte(struct i2c_client *client, u8 reg, u8 *val)
+{
+	int ret;
+
+	sunrise_wakeup(client);
+	ret = i2c_smbus_read_byte_data(client, reg);
+	if (ret < 0) {
+		dev_err(&client->dev, "Read byte failed (%d)\n", ret);
+		return ret;
+	}
+
+	*val = ret;
+
+	return 0;
+}
+
+/* Accessors for readx_poll_timeout() function. */
+#define sunrise_readb_client(client, addr)	\
+({						\
+	u8 _val;				\
+	sunrise_read_byte(client, addr, &_val); \
+	_val;					\
+})
+#define sunrise_readb(addr)	sunrise_readb_client(client, addr)
+#define sunrise_poll_register(reg, val, cond)	\
+	readx_poll_timeout(sunrise_readb, reg, val, cond, 100, 0)
+
+static int sunrise_read_word(struct i2c_client *client, u8 reg, u16 *val)
+{
+	int ret;
+
+	sunrise_wakeup(client);
+	ret = i2c_smbus_read_word_data(client, reg);
+	if (ret < 0) {
+		dev_err(&client->dev, "Read word failed (%d)\n", ret);
+		return ret;
+	}
+
+	*val = be16_to_cpu(ret);
+
+	return 0;
+}
+
+static int sunrise_write_byte(struct i2c_client *client, u8 reg, u8 val)
+{
+	int ret;
+
+	sunrise_wakeup(client);
+	ret = i2c_smbus_write_byte_data(client, reg, val);
+	if (ret) {
+		dev_err(&client->dev, "Write byte failed (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int sunrise_write_word(struct i2c_client *client, u8 reg, u16 data)
+{
+	u16 be_data = cpu_to_be16(data);
+	int ret;
+
+	sunrise_wakeup(client);
+	ret = i2c_smbus_write_word_data(client, reg, be_data);
+	if (ret) {
+		dev_err(&client->dev, "Write word failed (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct iio_chan_spec sunrise_channels[] = {
+	{
+		.type = IIO_CONCENTRATION,
+		.modified = 1,
+		.channel2 = IIO_MOD_CO2,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.scan_index = 0,
+		.scan_type =  {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
+	},
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate =  BIT(IIO_CHAN_INFO_RAW) |
+				       BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = 1,
+		.scan_type =  {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
+	},
+};
+
+static int sunrise_read_co2_filtered(struct i2c_client *client, u16 *co2)
+{
+	int ret;
+
+	ret = sunrise_read_word(client, SUNRISE_CO2_FILTERED_COMP_REG, co2);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int sunrise_read_raw(struct iio_dev *iio_dev,
+			    const struct iio_chan_spec *chan,
+			    int *val, int *val2, long mask)
+{
+	struct sunrise_dev *sunrise = iio_priv(iio_dev);
+	struct i2c_client *client = sunrise->client;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+
+		mutex_lock(&sunrise->lock);
+
+		switch (chan->type) {
+		case IIO_CONCENTRATION: {
+			u16 co2;
+
+			ret = sunrise_read_co2_filtered(client, &co2);
+			*val = co2;
+			mutex_unlock(&sunrise->lock);
+
+			return ret ? ret : IIO_VAL_INT;
+		}
+
+		case IIO_TEMP: {
+			u16 temp;
+
+			ret = sunrise_read_word(client,
+						SUNRISE_CHIP_TEMPERATURE_REG,
+						&temp);
+			*val = temp;
+			mutex_unlock(&sunrise->lock);
+
+			return ret ? ret : IIO_VAL_INT;
+		}
+
+		default:
+			mutex_unlock(&sunrise->lock);
+			return -EINVAL;
+		}
+
+	case IIO_CHAN_INFO_SCALE:
+		/* Chip temperature scale = 1/100 */
+		*val = 1;
+		*val2 = 100;
+		return IIO_VAL_FRACTIONAL;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct iio_info sunrise_info = {
+	.read_raw = sunrise_read_raw,
+};
+
+static int sunrise_calibrate(struct i2c_client *client)
+{
+	u16 status;
+	int ret;
+
+	/* Verify if calibration is required. */
+	ret = sunrise_read_word(client, SUNRISE_ERROR_STATUS_REG, &status);
+	if (ret)
+		return ret;
+	if (!status)
+		return 0;
+
+	/*
+	 * A different error than "Out of range": report it in dmseg but
+	 * do not fail. However operations might be compromised. If OOR error
+	 * is set, proceed with a calibration cycle.
+	 */
+	if (status & ~SUNRISE_ERROR_OOR_ERR)
+		dev_err(&client->dev, "Error status: 0x%2x\n", status);
+	if (!(status & SUNRISE_ERROR_OOR_ERR))
+		return 0;
+
+	/* Run an ADC background calibration cycle. */
+	ret = sunrise_write_byte(client, SUNRISE_CALIBRATION_STATUS_REG, 0x00);
+	if (ret)
+		return ret;
+
+	ret = sunrise_write_word(client, SUNRISE_CALIBRATION_COMMAND_REG,
+				 SUNRISE_CALIBRATION_BACKGROUND_CMD);
+	if (ret)
+		return ret;
+
+	/*
+	 * Perform a read to trigger co2 calibration and poll the status bit
+	 * until calibration is completed.
+	 */
+	dev_dbg(&client->dev, "ABC backgrounf calibration in progress\n");
+
+	ret = sunrise_read_co2_filtered(client, &status);
+	if (ret)
+		return ret;
+
+	return sunrise_poll_register(SUNRISE_CALIBRATION_STATUS_REG, status,
+				     (status & BIT(5)));
+}
+
+static int sunrise_probe(struct i2c_client *client)
+{
+	struct sunrise_dev *sunrise;
+	struct iio_dev *iio_dev;
+	int ret;
+
+	iio_dev = devm_iio_device_alloc(&client->dev, sizeof(*sunrise));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, iio_dev);
+
+	sunrise = iio_priv(iio_dev);
+	sunrise->client = client;
+	mutex_init(&sunrise->lock);
+
+	iio_dev->info = &sunrise_info;
+	iio_dev->name = DRIVER_NAME;
+	iio_dev->channels = sunrise_channels;
+	iio_dev->num_channels = ARRAY_SIZE(sunrise_channels);
+	iio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = sunrise_calibrate(client);
+	if (ret) {
+		dev_err(&client->dev, "Calibration failed (%d)\n", ret);
+		return ret;
+	}
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

