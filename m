Return-Path: <linux-iio+bounces-107-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE4C7EE131
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 14:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E14D1C20A29
	for <lists+linux-iio@lfdr.de>; Thu, 16 Nov 2023 13:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC22C30671;
	Thu, 16 Nov 2023 13:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="TOziHgXU"
X-Original-To: linux-iio@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB53FD56;
	Thu, 16 Nov 2023 05:13:51 -0800 (PST)
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id CCD9287465;
	Thu, 16 Nov 2023 14:13:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1700140429;
	bh=f18mliQSVOeakng7264VvIoPbOYvilMt4PFqLFrZac0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TOziHgXUXIXIG4H05s63YhpQIiD1Hvd5rgk53KPxYzg049HRBRPbUAm2hQFFLJijs
	 yPTy3wZ4RFnxgbQ27jpjcpvZFSzo7ZryTllF3t3Kh1RhOcIcck/A6l0z/FXkd+k3UV
	 nhgKmlGyx4r8rFIHQLCNJc7Rbg+tyywR3RIK4uYydwIt+SuFgUnepsrHhfwNe+p3Qg
	 8s0FltSL/sL1BadG3zAgkRJKcmYvBthvja2tQsnnvAs/69BG9WBOGKk3WSbjmIkwop
	 3ZwW9iFuGQEX6MNMzBGhK0XnBY7z5e//cDC50m/qSNZt0Dv4tgG6AfjCQM+9cy0lSz
	 zQmeigJ8rexng==
From: Marek Vasut <marex@denx.de>
To: linux-iio@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Andre Werner <andre.werner@systec-electronic.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@denx.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Rob Herring <robh+dt@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	Vincent Tremblay <vincent@vtremblay.dev>,
	devicetree@vger.kernel.org
Subject: [PATCH 2/2] iio: light: isl76682: Add ISL76682 driver
Date: Thu, 16 Nov 2023 14:13:16 +0100
Message-ID: <20231116131329.6801-2-marex@denx.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231116131329.6801-1-marex@denx.de>
References: <20231116131329.6801-1-marex@denx.de>
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
NOTE: I am not 100% sure about the SCALE handling, can you please
      check esp. that one ? Thanks !
---
 drivers/iio/light/Kconfig    |   8 +
 drivers/iio/light/Makefile   |   1 +
 drivers/iio/light/isl76682.c | 379 +++++++++++++++++++++++++++++++++++
 3 files changed, 388 insertions(+)
 create mode 100644 drivers/iio/light/isl76682.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 45edba797e4c7..124c45f509754 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -252,6 +252,14 @@ config ISL29125
 	  To compile this driver as a module, choose M here: the module will be
 	  called isl29125.
 
+config ISL76682
+	tristate "Intersil ISL76682 Light Sensor"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	  Provides driver for the Intersil's ISL76682 device. This driver
+	  supports the sysfs interface to get the ALS and IR intensity.
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
index 0000000000000..8b41a14bfe5be
--- /dev/null
+++ b/drivers/iio/light/isl76682.c
@@ -0,0 +1,379 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * IIO driver for the light sensor ISL76682.
+ * ISL76682 is Ambient Light Sensor
+ *
+ * Copyright (c) 2023 Marek Vasut <marex@denx.de>
+ */
+
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#define ISL76682_REG_COMMAND			0x00
+
+#define ISL76682_COMMAND_EN			BIT(7)
+#define ISL76682_COMMAND_MODE_CONTINUOUS	BIT(6)
+#define ISL76682_COMMAND_LIGHT_IR		BIT(5)
+
+#define ISL76682_COMMAND_RANGE_LUX_1K		0
+#define ISL76682_COMMAND_RANGE_LUX_4K		(1 << 0)
+#define ISL76682_COMMAND_RANGE_LUX_16K		(2 << 0)
+#define ISL76682_COMMAND_RANGE_LUX_64K		(3 << 0)
+#define ISL76682_COMMAND_RANGE_LUX_MASK		GENMASK(1, 0)
+
+#define ISL76682_REG_ALSIR_L			0x01
+
+#define ISL76682_REG_ALSIR_U			0x02
+
+#define ISL76682_NUM_REGS			(ISL76682_REG_ALSIR_U + 1)
+
+#define ISL76682_CONV_TIME_MS			100
+
+#define ISL76682_ADC_MAX			0xffff
+
+enum isl76682_als_ir_mode {
+	ISL76682_MODE_NONE = 0,
+	ISL76682_MODE_ALS,
+	ISL76682_MODE_IR,
+};
+
+struct isl76682_chip {
+	struct mutex			lock;
+	struct regmap			*regmap;
+	enum isl76682_als_ir_mode	als_ir_mode;
+	int				lux_scale;
+};
+
+static int isl76682_set_als_scale(struct isl76682_chip *chip, int lux_scale)
+{
+	int ret, val;
+
+	if (lux_scale == 1000)
+		val = ISL76682_COMMAND_RANGE_LUX_1K;
+	else if (lux_scale == 4000)
+		val = ISL76682_COMMAND_RANGE_LUX_4K;
+	else if (lux_scale == 16000)
+		val = ISL76682_COMMAND_RANGE_LUX_16K;
+	else if (lux_scale == 64000)
+		val = ISL76682_COMMAND_RANGE_LUX_64K;
+	else
+		return -EINVAL;
+
+	ret = regmap_update_bits(chip->regmap, ISL76682_REG_COMMAND,
+				 ISL76682_COMMAND_RANGE_LUX_MASK, val);
+	if (ret < 0)
+		return ret;
+
+	chip->lux_scale = lux_scale;
+
+	return 0;
+}
+
+static int isl76682_set_als_ir_mode(struct isl76682_chip *chip,
+				    enum isl76682_als_ir_mode mode)
+{
+	int ret;
+
+	if (chip->als_ir_mode == mode)
+		return 0;
+
+	if (mode == ISL76682_MODE_NONE) {
+		return regmap_clear_bits(chip->regmap, ISL76682_REG_COMMAND,
+					 ISL76682_COMMAND_EN);
+	}
+
+	ret = isl76682_set_als_scale(chip, chip->lux_scale);
+	if (ret < 0)
+		return ret;
+
+	if (mode == ISL76682_MODE_ALS) {
+		ret = regmap_clear_bits(chip->regmap, ISL76682_REG_COMMAND,
+					ISL76682_COMMAND_LIGHT_IR);
+	} else {
+		ret = regmap_set_bits(chip->regmap, ISL76682_REG_COMMAND,
+				      ISL76682_COMMAND_LIGHT_IR);
+	}
+	if (ret < 0)
+		return ret;
+
+	/* Enable the ALS/IR */
+	ret = regmap_set_bits(chip->regmap, ISL76682_REG_COMMAND,
+			      ISL76682_COMMAND_EN |
+			      ISL76682_COMMAND_MODE_CONTINUOUS);
+	if (ret < 0)
+		return ret;
+
+	/* Need to wait for conversion time if ALS/IR mode enabled */
+	msleep(ISL76682_CONV_TIME_MS);
+
+	chip->als_ir_mode = mode;
+
+	return 0;
+}
+
+static int isl76682_read_als_ir(struct isl76682_chip *chip, int *als_ir)
+{
+	unsigned int lsb, msb;
+	int ret;
+
+	ret = regmap_read(chip->regmap, ISL76682_REG_ALSIR_L, &lsb);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_read(chip->regmap, ISL76682_REG_ALSIR_U, &msb);
+	if (ret < 0)
+		return ret;
+
+	*als_ir = (msb << 8) | lsb;
+
+	return 0;
+}
+
+static int isl76682_als_get(struct isl76682_chip *chip, int *als_data)
+{
+	int als_ir_data;
+	int ret;
+
+	ret = isl76682_set_als_ir_mode(chip, ISL76682_MODE_ALS);
+	if (ret < 0)
+		return ret;
+
+	ret = isl76682_read_als_ir(chip, &als_ir_data);
+	if (ret < 0)
+		return ret;
+
+	*als_data = als_ir_data;
+
+	return 0;
+}
+
+static int isl76682_ir_get(struct isl76682_chip *chip, int *ir_data)
+{
+	int ret;
+
+	ret = isl76682_set_als_ir_mode(chip, ISL76682_MODE_IR);
+	if (ret < 0)
+		return ret;
+
+	return isl76682_read_als_ir(chip, ir_data);
+}
+
+static int isl76682_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
+{
+	struct isl76682_chip *chip = iio_priv(indio_dev);
+	int ret;
+
+	if (chan->type != IIO_LIGHT)
+		return -EINVAL;
+
+	if (mask != IIO_CHAN_INFO_SCALE)
+		return -EINVAL;
+
+	mutex_lock(&chip->lock);
+	ret = isl76682_set_als_scale(chip, val);
+	mutex_unlock(&chip->lock);
+
+	return ret;
+}
+
+static int isl76682_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct isl76682_chip *chip = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&chip->lock);
+
+	ret = -EINVAL;
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_LIGHT:
+			ret = isl76682_als_get(chip, val);
+			break;
+		case IIO_INTENSITY:
+			ret = isl76682_ir_get(chip, val);
+			break;
+		default:
+			break;
+		}
+
+		if (ret < 0)
+			break;
+
+		ret = IIO_VAL_INT;
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type != IIO_LIGHT)
+			break;
+		*val = chip->lux_scale;
+		*val2 = ISL76682_ADC_MAX;
+		ret = IIO_VAL_FRACTIONAL;
+		break;
+	default:
+		break;
+	}
+
+	mutex_unlock(&chip->lock);
+
+	return ret;
+}
+
+static IIO_CONST_ATTR(in_illuminance_scale_available, "1000 4000 16000 64000");
+
+#define ISL76682_CONST_ATTR(name) (&iio_const_attr_##name.dev_attr.attr)
+static struct attribute *isl76682_attributes[] = {
+	ISL76682_CONST_ATTR(in_illuminance_scale_available),
+	NULL,
+};
+
+static const struct attribute_group isl29108_group = {
+	.attrs = isl76682_attributes,
+};
+
+static const struct iio_chan_spec isl76682_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+	}, {
+		.type = IIO_INTENSITY,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	}
+};
+
+static const struct iio_info isl76682_info = {
+	.attrs		= &isl29108_group,
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
+		dev_err(dev, "%s(): Error %d clearing the CONFIGURE register\n",
+			__func__, ret);
+
+	chip->als_ir_mode = ISL76682_MODE_NONE;
+
+	return ret;
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
+	.reg_bits = 8,
+	.val_bits = 8,
+	.volatile_reg = isl76682_is_volatile_reg,
+	.max_register = ISL76682_NUM_REGS - 1,
+	.num_reg_defaults_raw = ISL76682_NUM_REGS,
+	.cache_type = REGCACHE_FLAT,
+};
+
+static int isl76682_probe(struct i2c_client *client)
+{
+	const struct i2c_device_id *id = i2c_client_get_device_id(client);
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
+	i2c_set_clientdata(client, indio_dev);
+	mutex_init(&chip->lock);
+
+	chip->regmap = devm_regmap_init_i2c(client, &isl76682_regmap_config);
+	if (IS_ERR(chip->regmap)) {
+		ret = PTR_ERR(chip->regmap);
+		dev_err(&client->dev, "%s: Error %d initializing regmap\n",
+			__func__, ret);
+		return ret;
+	}
+
+	chip->lux_scale = 1000;
+
+	ret = isl76682_clear_configure_reg(chip);
+	if (ret < 0)
+		return ret;
+
+	indio_dev->info = &isl76682_info;
+	indio_dev->channels = isl76682_channels;
+	indio_dev->num_channels = ARRAY_SIZE(isl76682_channels);
+	indio_dev->name = id->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = iio_device_register(indio_dev);
+	if (ret < 0) {
+		dev_err(&client->dev,
+			"%s(): iio registration failed with error %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void isl76682_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct isl76682_chip *chip = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+
+	isl76682_clear_configure_reg(chip);
+}
+
+static const struct i2c_device_id isl76682_id[] = {
+	{"isl76682", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, isl76682_id);
+
+static const struct of_device_id isl76682_of_match[] = {
+	{ .compatible = "isil,isl76682", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, isl76682_of_match);
+
+static struct i2c_driver isl76682_driver = {
+	.driver  = {
+		.name = "isl76682",
+		.of_match_table = isl76682_of_match,
+	},
+	.probe = isl76682_probe,
+	.remove = isl76682_remove,
+	.id_table = isl76682_id,
+};
+
+module_i2c_driver(isl76682_driver);
+
+MODULE_DESCRIPTION("ISL76682 Ambient Light Sensor driver");
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Marek Vasut <marex@denx.de>");
-- 
2.42.0


