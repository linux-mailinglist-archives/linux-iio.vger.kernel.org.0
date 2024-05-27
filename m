Return-Path: <linux-iio+bounces-5339-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 175FD8D05E1
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 17:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CEE928A995
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 15:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56A715E5CC;
	Mon, 27 May 2024 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gywXpsyw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F44E15A870;
	Mon, 27 May 2024 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716822730; cv=none; b=bUEv4AFK2AFRaWuDWTsdEzopDnuxSkW59RqteawVZ9/7P630p6KVor1WQ9Yiuw8bBL3Tspia1uAZyqrOO60KBQ11PoV0UNUVMTCcbiXcnH28F+7VY4iVvRT2HoMkZ8G/WcX4x2BlzT2eFd1cw9zYddwXXoMMRogNFg5UK2iFfMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716822730; c=relaxed/simple;
	bh=UyyqMZ5L0SngNJF1PyJXB84Mo8+32rBzh55sf5EUPf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K4spusAQrnAyqibl/PCUaF5wOu2RDZFzzKxcEyMkK3flyMwqzlJmRclg8WNxgyrPAe8Z4rv+SaEV+PjPaer6xleBg69H9FxIrAJ3itZqCCFg8z8820/RHZ4jgIiF0OS3gKn0LJwO/Hp1iLcTQ2waUpPxFLTorakeFLLvAJpHQbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gywXpsyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46CAEC32781;
	Mon, 27 May 2024 15:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716822730;
	bh=UyyqMZ5L0SngNJF1PyJXB84Mo8+32rBzh55sf5EUPf4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gywXpsywYia+Hq6opZLUa1WVkNcDubPq7au1N6st4RS3QNycysYI2FjG5ThTyiZUc
	 P5Px1lkTnBl+TsF5sF3xjh81iNzTX5qJURcKbOJ0eej+N/VhLgV5iW+AAkzbNBu0JX
	 PqO/DWsEkJltjEedxyIrGlQQoQ4VFdj/W9FSKv2vxqk5IQnRwcIwBsCBSBhBRonohP
	 B1xOOjJghUTlyfYsgswlI1uj55GRMC27kLhjtRNgnKvKJmGT8ar68TVDWPfWv8+hvH
	 GnHTBqcPekBSK2UZAuray9QDtEVj8xFnqUafHt6z8wjIGOfH970F5L/LS2l0UIg8NC
	 kkIiwscwh9PIg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4BBC25B78;
	Mon, 27 May 2024 15:12:10 +0000 (UTC)
From: Arthur Becker via B4 Relay <devnull+arthur.becker.sentec.com@kernel.org>
Date: Mon, 27 May 2024 17:12:08 +0200
Subject: [PATCH v3 1/2] iio: light: driver for Vishay VEML6040
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-veml6040-v3-1-6f3bbfd42960@sentec.com>
References: <20240527-veml6040-v3-0-6f3bbfd42960@sentec.com>
In-Reply-To: <20240527-veml6040-v3-0-6f3bbfd42960@sentec.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Arthur Becker <arthur.becker@sentec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716822728; l=9912;
 i=arthur.becker@sentec.com; s=20240521; h=from:subject:message-id;
 bh=yXqC+TyItLfjzLbDaRdbD4A5KUDEuV/bl3K5vQInJNk=;
 b=RDzvTfTqNGTzE9lAL9EAAi0sylom9MZTx2+2t+MZPi+2XACYOXL+HClPg1bfXwacKrh8VylOw
 S/4U7DJiEnJChT0wSbNVjsxUE8lE3AWvK9tinyiCphwA9u5KlcLZNfO
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
---
 drivers/iio/light/Kconfig    |  11 ++
 drivers/iio/light/Makefile   |   1 +
 drivers/iio/light/veml6040.c | 283 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 295 insertions(+)

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
index 000000000000..2ea00d57c38b
--- /dev/null
+++ b/drivers/iio/light/veml6040.c
@@ -0,0 +1,283 @@
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
+	int init_config =
+		FIELD_PREP(VEML6040_CONF_IT_MSK, VEML6040_CONF_IT_40_MS) |
+		FIELD_PREP(VEML6040_CONF_AF_MSK, 0) |
+		FIELD_PREP(VEML6040_CONF_SD_MSK, 0);
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
+
+module_i2c_driver(veml6040_driver);
+
+MODULE_DESCRIPTION("veml6040 RGBW light sensor driver");
+MODULE_AUTHOR("Arthur Becker <arthur.becker@sentec.com>");
+MODULE_LICENSE("GPL");

-- 
2.34.1



