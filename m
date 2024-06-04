Return-Path: <linux-iio+bounces-5728-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D31938FAD04
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 10:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497C51F27A2B
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 08:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2703F1420B0;
	Tue,  4 Jun 2024 08:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X53AdB09"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AFA446CF;
	Tue,  4 Jun 2024 08:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717488156; cv=none; b=SjZsX0xLC7xT0HALp0NHHYaOnkTCzvdf9wS89wkXF+6NRBUUP9zMnqPNt1VYiLuKcz0DrUrOv+vVEhhjKqr7WF8ioNdOrDPtbzolxNurMJ/kQRG9AM4qS2fevxKIR50ZD4rqT1JgwZgwIB/XYVOfmojiD1V+QubgXsfhkay+DaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717488156; c=relaxed/simple;
	bh=G8VHWXgne1JlwVb/fvljyIg7n4e+MeEJZ4P0blVbA+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vFRKXcdoVWAwy97juHbMMnKyfUzwO0oEcrZsBoKvdlTfdJq05rrXcSZ7NI3lahVmMMyw28Rci5YIc9qguC9Ht4COFGDZbgU62ku5fNk2zQk7y6sFdmf4q8V8rvLkBeDULKwUhpgItOAM4+cts9OU/ZOKPInMVw+06koblZ5Vj5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X53AdB09; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6EB4FC32782;
	Tue,  4 Jun 2024 08:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717488156;
	bh=G8VHWXgne1JlwVb/fvljyIg7n4e+MeEJZ4P0blVbA+E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=X53AdB09KXPFmaj8eeA0Erp3Z4ok76csex4p4ierjgdqBaB994iseypf1WgeeNfjZ
	 9GrnuaQS4GAPH2W8HXY7aXdsu1F01bUXwTrrJ4VzcQW8KwzJ2OyGkL9AzhmHSrO/Mm
	 kCGJbVyaWLRoxZG3/GbTciCzwGUQf5Iy8Wn6fUAgeQeVy/uPqt5yJpSWWw9EJ6yFSa
	 RvXgs6An4g2n0tagyfGeaNOohzK/H8epk14SwyHgYNorV1ED8w7jSShE9L4kD4+U2r
	 OEnOkHHfUgx1ROzNlkiZUIRXymd1XSMuPmuCMYXyCr8dLSZa/H619l6JzYOp7VWFbL
	 VEpJDSwR+JRAg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CF0C27C53;
	Tue,  4 Jun 2024 08:02:36 +0000 (UTC)
From: Arthur Becker via B4 Relay <devnull+arthur.becker.sentec.com@kernel.org>
Date: Tue, 04 Jun 2024 10:01:48 +0200
Subject: [PATCH v4 1/2] iio: light: driver for Vishay VEML6040
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-veml6040-v4-1-5a4d59597874@sentec.com>
References: <20240604-veml6040-v4-0-5a4d59597874@sentec.com>
In-Reply-To: <20240604-veml6040-v4-0-5a4d59597874@sentec.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Arthur Becker <arthur.becker@sentec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717488152; l=9941;
 i=arthur.becker@sentec.com; s=20240521; h=from:subject:message-id;
 bh=DFzBtZ50BsQIEr9zvi852uqB+OUL03+O6u+LzE6xWtE=;
 b=drC1REcWhMaITCf89cS8TTjqp0wHf21i2goXz8+aROyJMfCI98+XWLopzcdRN2eDLnw7smbvd
 h8BmRKOOHzMC4KZDKhm3gpy+lFaF023UyXCvpUhSmtrP9guNPn/OBex
X-Developer-Key: i=arthur.becker@sentec.com; a=ed25519;
 pk=1GLsDBF6GZKt9oNFsvdnAB6sHyKKrSISlwM3AyWbx/k=
X-Endpoint-Received: by B4 Relay for arthur.becker@sentec.com/20240521 with
 auth_id=163
X-Original-From: Arthur Becker <arthur.becker@sentec.com>
Reply-To: arthur.becker@sentec.com

From: Arthur Becker <arthur.becker@sentec.com>

Implements driver for the Vishay VEML6040 rgbw light sensor.

Included functionality: setting the integration time and reading the raw
values for the four channels

Not yet implemented: setting the measurements to 'Manual Force Mode' (Auto
measurements off, and adding a measurement trigger)

Datasheet: https://www.vishay.com/docs/84276/veml6040.pdf
Signed-off-by: Arthur Becker <arthur.becker@sentec.com>
---
V1 -> V2: Addressed review comments.
V2 -> V3: Addressed further review comments; Sending in patch thread
with dt-bindings.
V3 -> V4: Minor adjustments
---
 drivers/iio/light/Kconfig    |  11 ++
 drivers/iio/light/Makefile   |   1 +
 drivers/iio/light/veml6040.c | 281 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 293 insertions(+)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 9a587d403118..b68dcc1fbaca 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -666,6 +666,17 @@ config VEML6030
 	  To compile this driver as a module, choose M here: the
 	  module will be called veml6030.
 
+config VEML6040
+	tristate "VEML6040 RGBW light sensor"
+	select REGMAP_I2C
+	depends on I2C
+	help
+	  Say Y here if you want to build a driver for the Vishay VEML6040
+	  RGBW light sensor.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called veml6040.
+
 config VEML6070
 	tristate "VEML6070 UV A light sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index a30f906e91ba..1a071a8e9f8e 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -62,6 +62,7 @@ obj-$(CONFIG_US5182D)		+= us5182d.o
 obj-$(CONFIG_VCNL4000)		+= vcnl4000.o
 obj-$(CONFIG_VCNL4035)		+= vcnl4035.o
 obj-$(CONFIG_VEML6030)		+= veml6030.o
+obj-$(CONFIG_VEML6040)		+= veml6040.o
 obj-$(CONFIG_VEML6070)		+= veml6070.o
 obj-$(CONFIG_VEML6075)		+= veml6075.o
 obj-$(CONFIG_VL6180)		+= vl6180.o
diff --git a/drivers/iio/light/veml6040.c b/drivers/iio/light/veml6040.c
new file mode 100644
index 000000000000..216e271001a8
--- /dev/null
+++ b/drivers/iio/light/veml6040.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Vishay VEML6040 RGBW light sensor driver
+ *
+ * Copyright (C) 2024 Sentec AG
+ * Author: Arthur Becker <arthur.becker@sentec.com>
+ *
+ */
+
+#include <linux/bitfield.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+
+/* VEML6040 Configuration Registers
+ *
+ * SD: Shutdown
+ * AF: Auto / Force Mode (Auto Measurements On:0, Off:1)
+ * TR: Trigger Measurement (when AF Bit is set)
+ * IT: Integration Time
+ */
+#define VEML6040_CONF_REG 0x000
+#define VEML6040_CONF_SD_MSK BIT(0)
+#define VEML6040_CONF_AF_MSK BIT(1)
+#define VEML6040_CONF_TR_MSK BIT(2)
+#define VEML6040_CONF_IT_MSK GENMASK(6, 4)
+#define VEML6040_CONF_IT_40_MS 0
+#define VEML6040_CONF_IT_80_MS 1
+#define VEML6040_CONF_IT_160_MS 2
+#define VEML6040_CONF_IT_320_MS 3
+#define VEML6040_CONF_IT_640_MS 4
+#define VEML6040_CONF_IT_1280_MS 5
+
+/* VEML6040 Read Only Registers */
+#define VEML6040_REG_R 0x08
+#define VEML6040_REG_G 0x09
+#define VEML6040_REG_B 0x0A
+#define VEML6040_REG_W 0x0B
+
+static const int veml6040_it_ms[] = { 40, 80, 160, 320, 640, 1280 };
+
+enum veml6040_chan {
+	CH_RED,
+	CH_GREEN,
+	CH_BLUE,
+	CH_WHITE,
+};
+
+struct veml6040_data {
+	struct i2c_client *client;
+	struct regmap *regmap;
+};
+
+static const struct regmap_config veml6040_regmap_config = {
+	.name = "veml6040_regmap",
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = VEML6040_REG_W,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+};
+
+static int veml6040_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int *val,
+			     int *val2, long mask)
+{
+	int ret, reg, it_index;
+	struct veml6040_data *data = iio_priv(indio_dev);
+	struct regmap *regmap = data->regmap;
+	struct device *dev = &data->client->dev;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_read(regmap, chan->address, &reg);
+		if (ret) {
+			dev_err(dev, "Data read failed: %d\n", ret);
+			return ret;
+		}
+		*val = reg;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_INT_TIME:
+		ret = regmap_read(regmap, VEML6040_CONF_REG, &reg);
+		if (ret) {
+			dev_err(dev, "Data read failed: %d\n", ret);
+			return ret;
+		}
+		it_index = FIELD_GET(VEML6040_CONF_IT_MSK, reg);
+		if (it_index >= ARRAY_SIZE(veml6040_it_ms)) {
+			dev_err(dev, "Invalid Integration Time Set");
+			return -EINVAL;
+		}
+		*val = veml6040_it_ms[it_index];
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int veml6040_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan, int val,
+			      int val2, long mask)
+{
+	struct veml6040_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		for (int i = 0; i < ARRAY_SIZE(veml6040_it_ms); i++) {
+			if (veml6040_it_ms[i] != val)
+				continue;
+
+			return regmap_update_bits(data->regmap,
+					VEML6040_CONF_REG,
+					VEML6040_CONF_IT_MSK,
+					FIELD_PREP(VEML6040_CONF_IT_MSK, i));
+		}
+		return -EINVAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int veml6040_read_avail(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       const int **vals, int *type, int *length,
+			       long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		*length = ARRAY_SIZE(veml6040_it_ms);
+		*vals = veml6040_it_ms;
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_LIST;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info veml6040_info = {
+	.read_raw = veml6040_read_raw,
+	.write_raw = veml6040_write_raw,
+	.read_avail = veml6040_read_avail,
+};
+
+static const struct iio_chan_spec veml6040_channels[] = {
+	{
+		.type = IIO_INTENSITY,
+		.address = VEML6040_REG_R,
+		.channel = CH_RED,
+		.channel2 = IIO_MOD_LIGHT_RED,
+		.modified = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_type_available =
+			BIT(IIO_CHAN_INFO_INT_TIME),
+	},
+	{
+		.type = IIO_INTENSITY,
+		.address = VEML6040_REG_G,
+		.channel = CH_GREEN,
+		.channel2 = IIO_MOD_LIGHT_GREEN,
+		.modified = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_type_available =
+			BIT(IIO_CHAN_INFO_INT_TIME),
+	},
+	{
+		.type = IIO_INTENSITY,
+		.address = VEML6040_REG_B,
+		.channel = CH_BLUE,
+		.channel2 = IIO_MOD_LIGHT_BLUE,
+		.modified = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_type_available =
+			BIT(IIO_CHAN_INFO_INT_TIME),
+	},
+	{
+		.type = IIO_INTENSITY,
+		.address = VEML6040_REG_W,
+		.channel = CH_WHITE,
+		.channel2 = IIO_MOD_LIGHT_CLEAR,
+		.modified = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_type_available =
+			BIT(IIO_CHAN_INFO_INT_TIME),
+	}
+};
+
+static void veml6040_shutdown_action(void *data)
+{
+	struct veml6040_data *veml6040_data = data;
+
+	regmap_update_bits(veml6040_data->regmap, VEML6040_CONF_REG,
+			   VEML6040_CONF_SD_MSK, VEML6040_CONF_SD_MSK);
+}
+
+static int veml6040_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct veml6040_data *data;
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+	const int init_config =
+		FIELD_PREP(VEML6040_CONF_IT_MSK, VEML6040_CONF_IT_40_MS) |
+		FIELD_PREP(VEML6040_CONF_AF_MSK, 0) |
+		FIELD_PREP(VEML6040_CONF_SD_MSK, 0);
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return dev_err_probe(dev, -EOPNOTSUPP,
+				     "I2C adapter doesn't support plain I2C\n");
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return dev_err_probe(dev, -ENOMEM,
+				     "IIO device allocation failed\n");
+
+	regmap = devm_regmap_init_i2c(client, &veml6040_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Regmap setup failed\n");
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+	data->regmap = regmap;
+
+	indio_dev->name = "veml6040";
+	indio_dev->info = &veml6040_info;
+	indio_dev->channels = veml6040_channels;
+	indio_dev->num_channels = ARRAY_SIZE(veml6040_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return ret;
+
+	ret = regmap_write(regmap, VEML6040_CONF_REG, init_config);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Could not set initial config\n");
+
+	ret = devm_add_action_or_reset(dev, veml6040_shutdown_action, data);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct i2c_device_id veml6040_id_table[] = {
+	{"veml6040"},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, veml6040_id_table);
+
+static const struct of_device_id veml6040_of_match[] = {
+	{.compatible = "vishay,veml6040"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, veml6040_of_match);
+
+static struct i2c_driver veml6040_driver = {
+	.probe = veml6040_probe,
+	.id_table = veml6040_id_table,
+	.driver = {
+		.name = "veml6040",
+		.of_match_table = veml6040_of_match,
+	},
+};
+module_i2c_driver(veml6040_driver);
+
+MODULE_DESCRIPTION("veml6040 RGBW light sensor driver");
+MODULE_AUTHOR("Arthur Becker <arthur.becker@sentec.com>");
+MODULE_LICENSE("GPL");

-- 
2.34.1



