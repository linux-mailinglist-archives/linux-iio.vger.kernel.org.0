Return-Path: <linux-iio+bounces-381-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 278877F8FD4
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 23:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1370281433
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 22:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF062315A7;
	Sat, 25 Nov 2023 22:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="Wi1rD7lf"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1293B119;
	Sat, 25 Nov 2023 14:28:00 -0800 (PST)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 4FDC4870A0;
	Sat, 25 Nov 2023 23:27:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1700951278;
	bh=YlmCmV7bxvwZo30VvOI5o2xsatB8UY1/9XnuZLjj1Ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wi1rD7lfFQ+SU/eif73dgD6x16s8ZaOhCPdS0IBy616kw4+d16tICLYko521qCuQ1
	 5lJUEqGfX58j4rGCMvIRLUf5y1TclXGAUUMXcs16P7qvW37H8vfIJkigBpX/ND/pp1
	 uLQIU+/M0AE5WYcl16Ak6rzdBVQwfN7CYYeaBs42CrHwD/aZREbhgQ6GaJgo8tLZFr
	 KOAv5hrMIk08/3N4IpUCLhOPJkj7Kua3pmCVuuny9Bvp3JrboMmZJSjtWkUdOlxC5N
	 a9NTBi6bBXRemz3RWkWux48tO9jXDQulqeHuUWziIrnRzzhE7Lz/pQmR7PbP3f3bqT
	 TzQ2PJ5h0fD1Q==
From: Marek Vasut <marex@denx.de>
To: linux-iio@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Andre Werner <andre.werner@systec-electronic.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@denx.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Rob Herring <robh+dt@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	Vincent Tremblay <vincent@vtremblay.dev>,
	devicetree@vger.kernel.org
Subject: [PATCH v5 2/2] iio: light: isl76682: Add ISL76682 driver
Date: Sat, 25 Nov 2023 23:26:23 +0100
Message-ID: <20231125222738.97875-2-marex@denx.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231125222738.97875-1-marex@denx.de>
References: <20231125222738.97875-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The ISL76682 is very basic ALS which only supports ALS or IR mode
in four ranges, 1k/4k/16k/64k LUX. There is no IRQ support or any
other fancy functionality.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Andre Werner <andre.werner@systec-electronic.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Naresh Solanki <naresh.solanki@9elements.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>
Cc: Vincent Tremblay <vincent@vtremblay.dev>
Cc: devicetree@vger.kernel.org
Cc: linux-iio@vger.kernel.org
---
V2: - Overhaul the driver
    - Cache the entire 8-bit command register instead of parts of it
      and build up and rewrite the entire register if necessary
    - Fix illumination scale, add intensity scale, add integration time
V3: - Limit the read data to 16bit ADC range
    - Update Kconfig description
    - Update macros, drop bitshifts
    - Switch over to table lookup for lux ranges
    - Switch over to .read_avail instead of attributes
    - Use guard where applicable
    - Drop remove function in favor of reset action
V4: - Address feedback from Andy
    - Add missing includes
    - Change ISL76682_ADC_MAX to BIT(16) - 1
    - Drop initial ret assignment in isl76682_read_raw()
    - Move return -EINVAL to default: switch-case branch
    - Use switch-case consistenly instead of if/else
    - Drop trailing commas
    - Add comment to isl76682_clear_configure_reg on command zeroing on failure
    - Drop i2c_set_clientdata
    - Update devm_regmap_init_i2c return value handling
V5: - Remove newline, add newline, around module_i2c_driver
    - Combine if:s
    - Drop inner comma in isl76682_of_match
    - Replace one more break with return -EINVAL
    - Add RB from Andy and Matti
    - Dispose of dependency on i2c_device_id, use ISL76682_DRIVER_NAME
---
 drivers/iio/light/Kconfig    |  15 ++
 drivers/iio/light/Makefile   |   1 +
 drivers/iio/light/isl76682.c | 361 +++++++++++++++++++++++++++++++++++
 3 files changed, 377 insertions(+)
 create mode 100644 drivers/iio/light/isl76682.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 45edba797e4c7..9e8cdc091556d 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -252,6 +252,21 @@ config ISL29125
 	  To compile this driver as a module, choose M here: the module will be
 	  called isl29125.
 
+config ISL76682
+	tristate "Intersil ISL76682 Light Sensor"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Say Y here if you want to build a driver for the Intersil ISL76682
+	  Ambient Light Sensor and IR Intensity sensor. This driver provides
+	  the readouts via standard IIO sysfs and device interface. Both ALS
+	  illuminance and IR illuminance are provided raw with separate scale
+	  setting which can be configured via sysfs, the default scale is 1000
+	  lux, other options are 4000/16000/64000 lux.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called isl76682.
+
 config HID_SENSOR_ALS
 	depends on HID_SENSOR_HUB
 	select IIO_BUFFER
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index c0db4c4c36ec9..09fa585f3109f 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_IQS621_ALS)	+= iqs621-als.o
 obj-$(CONFIG_SENSORS_ISL29018)	+= isl29018.o
 obj-$(CONFIG_SENSORS_ISL29028)	+= isl29028.o
 obj-$(CONFIG_ISL29125)		+= isl29125.o
+obj-$(CONFIG_ISL76682)		+= isl76682.o
 obj-$(CONFIG_JSA1212)		+= jsa1212.o
 obj-$(CONFIG_SENSORS_LM3533)	+= lm3533-als.o
 obj-$(CONFIG_LTR501)		+= ltr501.o
diff --git a/drivers/iio/light/isl76682.c b/drivers/iio/light/isl76682.c
new file mode 100644
index 0000000000000..1bb44950fbc3e
--- /dev/null
+++ b/drivers/iio/light/isl76682.c
@@ -0,0 +1,361 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * IIO driver for the light sensor ISL76682.
+ * ISL76682 is Ambient Light Sensor
+ *
+ * Copyright (c) 2023 Marek Vasut <marex@denx.de>
+ */
+
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+#include <linux/iio/iio.h>
+
+#define ISL76682_REG_COMMAND			0x00
+
+#define ISL76682_COMMAND_EN			BIT(7)
+#define ISL76682_COMMAND_MODE_CONTINUOUS	BIT(6)
+#define ISL76682_COMMAND_LIGHT_IR		BIT(5)
+
+#define ISL76682_COMMAND_RANGE_LUX_1K		0x0
+#define ISL76682_COMMAND_RANGE_LUX_4K		0x1
+#define ISL76682_COMMAND_RANGE_LUX_16K		0x2
+#define ISL76682_COMMAND_RANGE_LUX_64K		0x3
+#define ISL76682_COMMAND_RANGE_LUX_MASK		GENMASK(1, 0)
+
+#define ISL76682_REG_ALSIR_L			0x01
+
+#define ISL76682_REG_ALSIR_U			0x02
+
+#define ISL76682_NUM_REGS			(ISL76682_REG_ALSIR_U + 1)
+
+#define ISL76682_CONV_TIME_MS			100
+#define ISL76682_INT_TIME_US			90000
+
+#define ISL76682_ADC_MAX			(BIT(16) - 1)
+
+#define ISL76682_DRIVER_NAME			"isl76682"
+
+struct isl76682_chip {
+	/*
+	 * Lock to synchronize access to device command register
+	 * and the content of range variable below.
+	 */
+	struct mutex			lock;
+	struct regmap			*regmap;
+	u8				range;
+	u8				command;
+};
+
+struct isl76682_range {
+	u8				range;
+	u32				als;
+	u32				ir;
+};
+
+static struct isl76682_range isl76682_range_table[] = {
+	{ ISL76682_COMMAND_RANGE_LUX_1K, 15000, 10500 },
+	{ ISL76682_COMMAND_RANGE_LUX_4K, 60000, 42000 },
+	{ ISL76682_COMMAND_RANGE_LUX_16K, 240000, 168000 },
+	{ ISL76682_COMMAND_RANGE_LUX_64K, 960000, 673000 }
+};
+
+static int isl76682_get(struct isl76682_chip *chip, bool mode_ir, int *data)
+{
+	u8 command;
+	int ret;
+
+	command = ISL76682_COMMAND_EN | ISL76682_COMMAND_MODE_CONTINUOUS |
+		  chip->range;
+
+	if (mode_ir)
+		command |= ISL76682_COMMAND_LIGHT_IR;
+
+	if (command != chip->command) {
+		ret = regmap_write(chip->regmap, ISL76682_REG_COMMAND, command);
+		if (ret)
+			return ret;
+
+		/* Need to wait for conversion time if ALS/IR mode enabled */
+		msleep(ISL76682_CONV_TIME_MS);
+
+		chip->command = command;
+	}
+
+	ret = regmap_bulk_read(chip->regmap, ISL76682_REG_ALSIR_L, data, 2);
+	*data &= ISL76682_ADC_MAX;
+	return ret;
+}
+
+static int isl76682_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
+{
+	struct isl76682_chip *chip = iio_priv(indio_dev);
+	int i;
+
+	if (chan->type != IIO_LIGHT && chan->type != IIO_INTENSITY)
+		return -EINVAL;
+
+	if (mask != IIO_CHAN_INFO_SCALE)
+		return -EINVAL;
+
+	if (val != 0)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(isl76682_range_table); i++) {
+		if (chan->type == IIO_LIGHT && val2 != isl76682_range_table[i].als)
+				continue;
+		if (chan->type == IIO_INTENSITY && val2 != isl76682_range_table[i].ir)
+				continue;
+
+		scoped_guard(mutex, &chip->lock)
+			chip->range = isl76682_range_table[i].range;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int isl76682_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct isl76682_chip *chip = iio_priv(indio_dev);
+	int ret;
+	int i;
+
+	if (chan->type != IIO_LIGHT && chan->type != IIO_INTENSITY)
+		return -EINVAL;
+
+	guard(mutex)(&chip->lock);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_LIGHT:
+			ret = isl76682_get(chip, false, val);
+			return (ret < 0) ? ret : IIO_VAL_INT;
+		case IIO_INTENSITY:
+			ret = isl76682_get(chip, true, val);
+			return (ret < 0) ? ret : IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+		return -EINVAL;
+	case IIO_CHAN_INFO_SCALE:
+		for (i = 0; i < ARRAY_SIZE(isl76682_range_table); i++) {
+			if (chip->range != isl76682_range_table[i].range)
+				continue;
+
+			*val = 0;
+			switch (chan->type) {
+			case IIO_LIGHT:
+				*val2 = isl76682_range_table[i].als;
+				return IIO_VAL_INT_PLUS_MICRO;
+			case IIO_INTENSITY:
+				*val2 = isl76682_range_table[i].ir;
+				return IIO_VAL_INT_PLUS_MICRO;
+			default:
+				return -EINVAL;
+			}
+		}
+		return -EINVAL;
+	case IIO_CHAN_INFO_INT_TIME:
+		*val = 0;
+		*val2 = ISL76682_INT_TIME_US;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int illuminance_scale_available[] = {
+	0, 15000,
+	0, 60000,
+	0, 240000,
+	0, 960000,
+};
+
+static int intensity_scale_available[] = {
+	0, 10500,
+	0, 42000,
+	0, 168000,
+	0, 673000,
+};
+
+static int integration_time_available[] = { 0, ISL76682_INT_TIME_US };
+
+static int isl76682_read_avail(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       const int **vals, int *type,
+			       int *length, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_LIGHT:
+			*vals = illuminance_scale_available;
+			*length = ARRAY_SIZE(illuminance_scale_available);
+			*type = IIO_VAL_INT_PLUS_MICRO;
+			return IIO_AVAIL_LIST;
+		case IIO_INTENSITY:
+			*vals = intensity_scale_available;
+			*length = ARRAY_SIZE(intensity_scale_available);
+			*type = IIO_VAL_INT_PLUS_MICRO;
+			return IIO_AVAIL_LIST;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_INT_TIME:
+		*vals = integration_time_available;
+		*length = ARRAY_SIZE(integration_time_available);
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_chan_spec isl76682_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+	}, {
+		.type = IIO_INTENSITY,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+	}
+};
+
+static const struct iio_info isl76682_info = {
+	.read_avail	= isl76682_read_avail,
+	.read_raw	= isl76682_read_raw,
+	.write_raw	= isl76682_write_raw,
+};
+
+static int isl76682_clear_configure_reg(struct isl76682_chip *chip)
+{
+	struct device *dev = regmap_get_device(chip->regmap);
+	int ret;
+
+	ret = regmap_write(chip->regmap, ISL76682_REG_COMMAND, 0x0);
+	if (ret < 0)
+		dev_err(dev, "Error %d clearing the CONFIGURE register\n", ret);
+
+	/*
+	 * In the success case, the command register was zeroed out.
+	 *
+	 * In the error case, we do not know in which state the command
+	 * register is, so we assume it is zeroed out, so that it would
+	 * be reprogrammed at the next data read out, and at that time
+	 * we hope it would be reprogrammed successfully. That is very
+	 * much a best effort approach.
+	 */
+	chip->command = 0;
+
+	return ret;
+}
+
+static void isl76682_reset_action(void *chip)
+{
+	isl76682_clear_configure_reg(chip);
+}
+
+static bool isl76682_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case ISL76682_REG_ALSIR_L:
+	case ISL76682_REG_ALSIR_U:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct regmap_config isl76682_regmap_config = {
+	.reg_bits		= 8,
+	.val_bits		= 8,
+	.volatile_reg		= isl76682_is_volatile_reg,
+	.max_register		= ISL76682_NUM_REGS - 1,
+	.num_reg_defaults_raw	= ISL76682_NUM_REGS,
+	.cache_type		= REGCACHE_FLAT,
+};
+
+static int isl76682_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct isl76682_chip *chip;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	chip = iio_priv(indio_dev);
+
+	mutex_init(&chip->lock);
+
+	chip->regmap = devm_regmap_init_i2c(client, &isl76682_regmap_config);
+	ret = PTR_ERR_OR_ZERO(chip->regmap);
+	if (ret)
+		return dev_err_probe(dev, ret, "Error initializing regmap\n");
+
+	chip->range = ISL76682_COMMAND_RANGE_LUX_1K;
+
+	ret = isl76682_clear_configure_reg(chip);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, isl76682_reset_action, chip);
+	if (ret)
+		return ret;
+
+	indio_dev->info = &isl76682_info;
+	indio_dev->channels = isl76682_channels;
+	indio_dev->num_channels = ARRAY_SIZE(isl76682_channels);
+	indio_dev->name = ISL76682_DRIVER_NAME;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct i2c_device_id isl76682_id[] = {
+	{ "isl76682" },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, isl76682_id);
+
+static const struct of_device_id isl76682_of_match[] = {
+	{ .compatible = "isil,isl76682" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, isl76682_of_match);
+
+static struct i2c_driver isl76682_driver = {
+	.driver  = {
+		.name		= ISL76682_DRIVER_NAME,
+		.of_match_table	= isl76682_of_match,
+	},
+	.probe		= isl76682_probe,
+	.id_table	= isl76682_id,
+};
+module_i2c_driver(isl76682_driver);
+
+MODULE_DESCRIPTION("ISL76682 Ambient Light Sensor driver");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
-- 
2.42.0


