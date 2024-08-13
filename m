Return-Path: <linux-iio+bounces-8433-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8A494FD4F
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 07:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82829282B62
	for <lists+linux-iio@lfdr.de>; Tue, 13 Aug 2024 05:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98774383A9;
	Tue, 13 Aug 2024 05:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="W+Yc50RD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CC32C19E
	for <linux-iio@vger.kernel.org>; Tue, 13 Aug 2024 05:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723527659; cv=none; b=myXgIdJctYPbKn7v4hgG1YzH+LX5RPF50d26lxKFvEAdw3SlCbRo7zuX1YNfM5tBdL4KZCOmmWdWQUipI0E6FGw3k7xHF6zviusX0cVNjN1wFPlCrC/VfiwjasYt1cBCLzMdXUIW6+C5wBRYOkVLzE5qXIwY0lu1wQCHVpU6j10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723527659; c=relaxed/simple;
	bh=lqrNRFOGEIqChEHT8COg3Ajkibxc3Cly4DTf3GL9xj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rf9UpeGA6qzKmGWPGQMrNEcJn5B+bPyNNoQJkNy9eQUHuPH8WC9sBbNt1wl+q/KBetp/bHmfbM9d8C5C1/rSvD2ZUnzRQhcItQPYk/wVZoLB6z55r4INTKiIiqqmRHKJEdayeNEvBtRfW9N349pEXAjnHRSvuBMeM+to5mZZSWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=W+Yc50RD; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240813054054f911ea2106586132ab
        for <linux-iio@vger.kernel.org>;
        Tue, 13 Aug 2024 07:40:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=P5fnWxXIzhRO02nPudc2IAQGQdZVKSGoTLHiEj4IpHQ=;
 b=W+Yc50RD4AyEogFGWiZm3lemsqRQyisBGl8kL7cP48QZJUiDTZLEuSa1c+oJHumaDQ0drj
 W1K3SzX+FuMFp0w1NqxEUg7d8UjnZVgwAfwOf8Ok1pz6sgZRKruaRVHLG8DT7ZkvyBnRpUvb
 yCHf6vn+vyU9W8iIiiUA5/9NtR+Tmm2hZ3aWbURGvp3JCuP8gORtyu8ii1naNlO+f5d8h3RA
 6Iw1j8h1wioKO6XEeAfbTbC4hvD/xBeBhCIUBEYjhlJ6F9F6Qek4yFur4sXat727T0+aHBaX
 RhRzesbfbWqTRG/zvAm1er7xJjroYUpIn7P+E8V9Yt0AG4Jybl2PNdIg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Bao Cheng Su <baocheng.su@siemens.com>,
	Chao Zeng <chao.zeng@siemens.com>,
	devicetree@vger.kernel.org
Subject: [PATCH 3/3] iio: proximity: Add support for everlight pmd16d17 sensor
Date: Tue, 13 Aug 2024 07:40:42 +0200
Message-ID: <abb0c1c0724be733138276f638e43e98784bd191.1723527641.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1723527641.git.jan.kiszka@siemens.com>
References: <cover.1723527641.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Chao Zeng <chao.zeng@siemens.com>

Add initial support for everlight pm16d17 proximity sensor.

Signed-off-by: Chao Zeng <chao.zeng@siemens.com>
Co-developed-by: Baocheng Su <baocheng.su@siemens.com>
Signed-off-by: Baocheng Su <baocheng.su@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/iio/proximity/Kconfig   |  11 ++
 drivers/iio/proximity/Makefile  |   1 +
 drivers/iio/proximity/pm16d17.c | 324 ++++++++++++++++++++++++++++++++
 3 files changed, 336 insertions(+)
 create mode 100644 drivers/iio/proximity/pm16d17.c

diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
index 2ca3b0bc5eba..4c26bc3a0390 100644
--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -96,6 +96,17 @@ config PING
 	  To compile this driver as a module, choose M here: the
 	  module will be called ping.
 
+config PM16D17
+	tristate "PM16D17 proximity sensor"
+	select REGMAP_I2C
+	depends on I2C
+	help
+	 Say Y here to build a driver for the Everlight Devices
+	 PM16D17 proximity sensor.
+
+	 To compile this driver as a module, choose M here: the
+	 module will be called pm16d17.
+
 config RFD77402
 	tristate "RFD77402 ToF sensor"
 	depends on I2C
diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
index f36598380446..e41bba9c7cd3 100644
--- a/drivers/iio/proximity/Makefile
+++ b/drivers/iio/proximity/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_ISL29501)		+= isl29501.o
 obj-$(CONFIG_LIDAR_LITE_V2)	+= pulsedlight-lidar-lite-v2.o
 obj-$(CONFIG_MB1232)		+= mb1232.o
 obj-$(CONFIG_PING)		+= ping.o
+obj-$(CONFIG_PM16D17)		+= pm16d17.o
 obj-$(CONFIG_RFD77402)		+= rfd77402.o
 obj-$(CONFIG_SRF04)		+= srf04.o
 obj-$(CONFIG_SRF08)		+= srf08.o
diff --git a/drivers/iio/proximity/pm16d17.c b/drivers/iio/proximity/pm16d17.c
new file mode 100644
index 000000000000..94f21fc5e2fb
--- /dev/null
+++ b/drivers/iio/proximity/pm16d17.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) Siemens AG, 2023-2024
+ *
+ * Driver for Everlight PM-16d17 proximity sensor
+ *
+ * Author: Chao Zeng <chao.zeng@siemens.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
+
+#define PM16D17_DRV_NAME		"pm16d17"
+#define PM16D17_REGMAP_NAME		"pm16d17_regmap"
+
+/* Registers Address */
+#define PM16D17_OP_MODE			0x00
+#define PM16D17_INTERRUPT_FLAG		0x01
+#define PM16D17_PS_SETTING		0x0A
+#define PM16D17_VCSEL_DRIVE_CURRENT	0x0B
+#define PM16D17_VCSEL_DRIVE_PULSE	0x0C
+#define PM16D17_PS_INTUPT_LTHD_L	0x0D
+#define PM16D17_PS_INTUPT_LTHD_H	0x0E
+#define PM16D17_PS_INTUPT_HTHD_L	0x0F
+#define PM16D17_PS_INTUPT_HTHD_H	0x10
+#define PM16D17_PS_DATA_L		0x11
+#define PM16D17_PS_DATA_H		0x12
+#define PM16D17_PS_SETTING2		0x13
+#define PM16D17_PS_OFFSET_CANCEL_L	0x14
+#define PM16D17_PS_OFFSET_CANCEL_H	0x15
+#define PM16D17_DEV_ID			0x18
+
+#define DEVICE_ID			0x11
+
+#define ENABLE_PS_FUNCTION		BIT(3)
+#define PS_GAIN_MASK			GENMASK(7, 6)
+#define PS_ITIME_MASK			GENMASK(5, 3)
+#define PS_WTIME_MASK			GENMASK(2, 0)
+#define OFFSET_CANCEL_ENABLE		BIT(7)
+#define PS_OFFSET_CANCEL_LSB_MASK	GENMASK(7, 0)
+#define PS_OFFSET_CANCEL_MSB_MASK	GENMASK(15, 8)
+
+enum {
+	PITIME_0_POINT_4_MS = (0 << 3),
+	PITIME_0_POINT_8_MS = (1 << 3),
+	PITIME_1_POINT_6_MS = (2 << 3),
+	PITIME_3_POINT_2_MS = (3 << 3),
+	PITIME_6_POINT_3_MS = (4 << 3),
+	PITIME_12_POINT_6_MS = (5 << 3),
+	PITIME_25_POINT_2_MS = (6 << 3),
+};
+
+enum {
+	PWTIME_12_POINT_5_MS = 0,
+	PWTIME_25_MS,
+	PWTIME_50_MS,
+	PWTIME_100_MS,
+	PWTIME_200_MS,
+	PWTIME_400_MS,
+	PWTIME_800_MS,
+	PWTIME_1600_MS,
+};
+
+struct pm16d17_data {
+	struct i2c_client *client;
+	struct regmap *regmap;
+};
+
+static const struct regmap_config pm16d17_regmap_config = {
+	.name = PM16D17_REGMAP_NAME,
+	.reg_bits = 8,
+	.val_bits = 8,
+	.cache_type = REGCACHE_NONE,
+};
+
+static const struct iio_chan_spec pm16d17_channels[] = {
+	{
+		.type = IIO_PROXIMITY,
+		.indexed = 1,
+		.channel = 0,
+		.scan_index = -1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+	}
+};
+
+static inline int pm16d17_write_reg(struct pm16d17_data *data,
+				    unsigned int reg,
+				    unsigned int value)
+{
+	return regmap_write(data->regmap, reg, value);
+}
+
+static inline unsigned int pm16d17_read_reg(struct pm16d17_data *data,
+					    unsigned int reg,
+					    unsigned int *reg_val)
+{
+	return regmap_read(data->regmap, reg, reg_val);
+}
+
+static int pm16d17_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct pm16d17_data *data = iio_priv(indio_dev);
+	unsigned int ps_data_l;
+	unsigned int ps_data_h;
+	uint16_t ps_data;
+	int ret = -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_PROXIMITY:
+			ret = pm16d17_read_reg(data, PM16D17_PS_DATA_L, &ps_data_l);
+			if (ret < 0)
+				return ret;
+
+			ret = pm16d17_read_reg(data, PM16D17_PS_DATA_H, &ps_data_h);
+			if (ret < 0)
+				return ret;
+
+			ps_data = (ps_data_h << 8) | ps_data_l;
+
+			dev_dbg(&data->client->dev, "PS data: %x\n", ps_data);
+
+			*val = ps_data;
+			ret = IIO_VAL_INT;
+			break;
+		default:
+			break;
+		}
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static const struct iio_info pm16d17_info = {
+	.read_raw = pm16d17_read_raw,
+};
+
+static int pm16d17_chip_init(struct pm16d17_data *data)
+{
+	struct i2c_client *client = data->client;
+	struct device_node *np = client->dev.of_node;
+	const char *conv_time = NULL;
+	const char *wait_time = NULL;
+	uint8_t op_mode_setting_val;
+	uint32_t ps_offset_cancel;
+	uint8_t offset_lsb;
+	uint8_t offset_msb;
+	uint32_t pulse_count;
+	uint32_t pgain;
+	unsigned int val;
+	int ret;
+
+	ret = pm16d17_read_reg(data, PM16D17_DEV_ID, &val);
+
+	if (ret < 0 || (val != DEVICE_ID)) {
+		dev_err(&client->dev, "Invalid chip id 0x%04x\n", val);
+		return -ENODEV;
+	}
+
+	dev_dbg(&client->dev, "Detected PM16D17 with chip id: 0x%04x\n", val);
+
+	ret = pm16d17_write_reg(data, PM16D17_OP_MODE, ENABLE_PS_FUNCTION);
+	if (ret < 0)
+		return ret;
+
+	of_property_read_u32(np, "ps-gain", &pgain);
+	switch (pgain) {
+	case 1:
+	case 2:
+	case 4:
+	case 8:
+		op_mode_setting_val |= (ilog2(pgain) << 6) & PS_GAIN_MASK;
+		break;
+	default:
+		break;
+	}
+
+	of_property_read_string(np, "ps-itime", &conv_time);
+	if (strcmp(conv_time, "0.4") == 0)
+		op_mode_setting_val |= PITIME_0_POINT_4_MS & PS_ITIME_MASK;
+	else if (strcmp(conv_time, "0.8") == 0)
+		op_mode_setting_val |= PITIME_0_POINT_8_MS & PS_ITIME_MASK;
+	else if (strcmp(conv_time, "1.6") == 0)
+		op_mode_setting_val |= PITIME_1_POINT_6_MS & PS_ITIME_MASK;
+	else if (strcmp(conv_time, "3.2") == 0)
+		op_mode_setting_val |= PITIME_3_POINT_2_MS & PS_ITIME_MASK;
+	else if (strcmp(conv_time, "6.3") == 0)
+		op_mode_setting_val |= PITIME_6_POINT_3_MS & PS_ITIME_MASK;
+	else if (strcmp(conv_time, "12.6") == 0)
+		op_mode_setting_val |= PITIME_12_POINT_6_MS & PS_ITIME_MASK;
+	else if (strcmp(conv_time, "25.2") == 0)
+		op_mode_setting_val |= PITIME_25_POINT_2_MS & PS_ITIME_MASK;
+	else {
+		dev_info(&client->dev, "Using default ps itime value\n");
+		op_mode_setting_val |= PITIME_0_POINT_4_MS & PS_ITIME_MASK;
+	}
+
+	of_property_read_string(np, "ps-wtime", &wait_time);
+	if (strcmp(wait_time, "12.5") == 0)
+		op_mode_setting_val |= PWTIME_12_POINT_5_MS & PS_WTIME_MASK;
+	else if (strcmp(wait_time, "25") == 0)
+		op_mode_setting_val |= PWTIME_25_MS & PS_WTIME_MASK;
+	else if (strcmp(wait_time, "50") == 0)
+		op_mode_setting_val |= PWTIME_50_MS & PS_WTIME_MASK;
+	else if (strcmp(wait_time, "100") == 0)
+		op_mode_setting_val |= PWTIME_100_MS & PS_WTIME_MASK;
+	else if (strcmp(wait_time, "200") == 0)
+		op_mode_setting_val |= PWTIME_200_MS & PS_WTIME_MASK;
+	else if (strcmp(wait_time, "400") == 0)
+		op_mode_setting_val |= PWTIME_400_MS & PS_WTIME_MASK;
+	else if (strcmp(wait_time, "800") == 0)
+		op_mode_setting_val |= PWTIME_800_MS & PS_WTIME_MASK;
+	else if (strcmp(wait_time, "1600") == 0)
+		op_mode_setting_val |= PWTIME_1600_MS & PS_WTIME_MASK;
+	else {
+		dev_info(&client->dev, "Using default ps wtime value\n");
+		op_mode_setting_val |= PWTIME_12_POINT_5_MS & PS_WTIME_MASK;
+	}
+
+	ret = pm16d17_write_reg(data, PM16D17_PS_SETTING, op_mode_setting_val);
+	if (ret < 0)
+		return ret;
+
+	of_property_read_u32(np, "ps-ir-led-pulse-count", &pulse_count);
+	if (pulse_count > 256)
+		pulse_count = 256;
+	ret = pm16d17_write_reg(data, PM16D17_VCSEL_DRIVE_PULSE, pulse_count - 1);
+	if (ret < 0)
+		return ret;
+
+	of_property_read_u32(np, "ps-offset-cancel", &ps_offset_cancel);
+	if (ps_offset_cancel != 0) {
+		ret = pm16d17_write_reg(data, PM16D17_PS_SETTING2, OFFSET_CANCEL_ENABLE);
+		if (ret < 0)
+			return ret;
+
+		offset_lsb = ps_offset_cancel & PS_OFFSET_CANCEL_LSB_MASK;
+		offset_msb = (ps_offset_cancel & PS_OFFSET_CANCEL_MSB_MASK) >> 8;
+
+		ret = pm16d17_write_reg(data, PM16D17_PS_OFFSET_CANCEL_L, offset_lsb);
+		if (ret < 0)
+			return ret;
+
+		ret = pm16d17_write_reg(data, PM16D17_PS_OFFSET_CANCEL_H, offset_msb);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int pm16d17_probe(struct i2c_client *client)
+{
+	struct pm16d17_data *data;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->info = &pm16d17_info;
+	indio_dev->name = PM16D17_DRV_NAME;
+	indio_dev->channels = pm16d17_channels;
+	indio_dev->num_channels = ARRAY_SIZE(pm16d17_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+
+	data->regmap = devm_regmap_init_i2c(client, &pm16d17_regmap_config);
+	if (IS_ERR(data->regmap)) {
+		dev_err(&client->dev, "regmap initialization failed.\n");
+		return PTR_ERR(data->regmap);
+	}
+
+	ret = pm16d17_chip_init(data);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static const struct i2c_device_id pm16d17_id[] = {
+	{"pm16d17", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, pm16d17_id);
+
+static const struct of_device_id pm16d17_of_match[] = {
+	{ .compatible = "everlight,pm16d17" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, pm16d17_of_match);
+
+static struct i2c_driver pm16d17_driver = {
+	.driver = {
+		.name = PM16D17_DRV_NAME,
+		.of_match_table = pm16d17_of_match,
+	},
+	.probe = pm16d17_probe,
+	.id_table = pm16d17_id,
+};
+module_i2c_driver(pm16d17_driver);
+
+MODULE_AUTHOR("Chao Zeng <chao.zeng@siemens.com>");
+MODULE_DESCRIPTION("PM16D17 proximity sensor");
+MODULE_LICENSE("GPL");
-- 
2.43.0


