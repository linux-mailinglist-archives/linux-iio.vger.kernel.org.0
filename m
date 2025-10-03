Return-Path: <linux-iio+bounces-24683-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F3DBB5A76
	for <lists+linux-iio@lfdr.de>; Fri, 03 Oct 2025 02:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F167D1AE4979
	for <lists+linux-iio@lfdr.de>; Fri,  3 Oct 2025 00:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B706617D2;
	Fri,  3 Oct 2025 00:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4h6wRa+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456A4A48
	for <linux-iio@vger.kernel.org>; Fri,  3 Oct 2025 00:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759450059; cv=none; b=jj2WXWGn4+oFni4O9FuMEX0EEPfxfxa3mPIIC9SElR+Qme5sajDuPo5mf3mbG4Qk8fZ3vkWjm5z1mZdT4c7KD4tkwcDw6rkA5ENXKie+Cj2jSumdCI3UJX9SyIXFziTa1es2pNNeunp0nptBgRdlWDeqG8T+z4rA9uHeHZtCOwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759450059; c=relaxed/simple;
	bh=XQyIKugIM+oaqSA5HGXAOKWIAWxZJMtqk03cVg01bZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UWqjKlcepCZfnmPKK1mXn1eLynJgHEJeVKt1enpTcNqryEtveGJs12eQqa5GXpWcw6is1+0bK+NNTjwlD0elbjyDmyKGdUijiH7k4LVBjRDWFFQpKH4DPDz0rYsxBEVG2n27fzopxE/XJ2FtClQOT4h4NhJBB0Axc3ce/P2mv5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4h6wRa+; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3ce040db85so26923066b.2
        for <linux-iio@vger.kernel.org>; Thu, 02 Oct 2025 17:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759450055; x=1760054855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XkV2oHj2uENfVm6/l2LAkTIzjwXp2OdcQ4n1hvdEW6s=;
        b=l4h6wRa+qMDRaRenmxRMb052x4f5f7UKlMbSDGOhLf/HVJgYj62q2DcsesjAJHh3wh
         HnIj6Q5XeOWZuQC6VwkMpeyBcyHZ7EmRgI0F3Fj/JOtFxZMmJ/vAhTPlQb5U1xHhIjnA
         CuuA0Ai06Z/JkUx8DKswfrp1IUnm3RCQ5g97kLfgXNOcPFH6+9ghV62BW9zrDHd50PJP
         Q7eNRupHWdCc7kRk5zxLAOkHwmViLgfTxlh0WECbWJ/SSrloNyw9mIJuqumXtYaViVpO
         10eczbIaPmiSjfJTjmoq2Y+7cQYMhFnX54SY1HXxlzG4qBARRvJYnvUWjPI9WgeCTnck
         Ep7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759450055; x=1760054855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XkV2oHj2uENfVm6/l2LAkTIzjwXp2OdcQ4n1hvdEW6s=;
        b=Fkmsr4rldLSwjb8YuBwqLBKAdxiL5i3qYJKf5l2HUM4I+e2gH6DaP7zrzDrJ4h4GhL
         UUcFvojp7GCR6onjVUdbe7Y/SMf2ZCstU+TAsq51d0Gk7koqE/CdWaErp7LpMmPcaDTr
         giuxtiWFXFHVKDF7rMj6UjkDOrYfFDGAcw2TZf42Khe9u/PR8P7RxaquD4qpIwnuaE4/
         JLaaYNq6WVOQEXHqawt/Q+R/MYDGufQ5tNlnoOw8AMjAJBQ2DAIjCNN645GRksbNdR92
         fVp8gak8N4+PFRSGXMpvpcSL2VX7GKAtvgvkCoBfMVxoC0nEQi6t7BcvGPyKTKnUB81M
         XOug==
X-Gm-Message-State: AOJu0YwXRzAnLFX0JUyCtlkxKcw1dJ8C64uH6OoRywXtPY/XsAEtrW+0
	RBvG7FZ4tz1c5g7f9SpXl/CjMJh1ue/W5KtKDROPN8GmuIwEeKwzWvsCi+SGNfITxlZXEw==
X-Gm-Gg: ASbGncsDo9HNOTkVy6+hzzn16dI3ev/lJfsB96/DL9V8WN+YttaqqLGQN5PrgvObuGu
	nLaaiWKhlc56dVzyfajrafaumQJeZkx/Bnm/q8BSSlJYM5063cDRHY9aUOKkc21PWN85pdh8n74
	V0WAZwAjXwOaHuIy7NJHm74u1P9Bz+EauZW6jDRwYBTZJXWfCpxWGAfYNnN/2qHBTvxkXFYkJib
	OdcEQuVVtGA2EORAwnC9BpK1wXukeeyfdtPKH91B54xWJ94j4K3ORWPf01zjzNZFrJ5KEQmXGPC
	Bp4v0AQmPW5d3po2hV/ARYPvkPg6dAmfkJI5cEi116HrXCsXzRqJ+wrVt9XApa2579yp2CXeWUN
	ugBtoshaRXm62vs8ML5nB5QESaRfteWqD0VgB3orCRqAozyslY/BfQReRSeUHqIw4X7+QWbu+3F
	qDtZw/9kzPpmX1oQ==
X-Google-Smtp-Source: AGHT+IH4tUwAgZ7ZxRyFqTTb9hO5SY+ZX/ZsNzLPlNpncukBvwe+RcAmWFECv2kdj5tkJTB5rVHX+w==
X-Received: by 2002:a17:907:2d89:b0:b41:1160:a3ef with SMTP id a640c23a62f3a-b49c49c84e7mr76495666b.10.1759450055012;
        Thu, 02 Oct 2025 17:07:35 -0700 (PDT)
Received: from incite.mshome.net (86-83-125-241.fixed.kpn.net. [86.83.125.241])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b48652aa01esm301475166b.2.2025.10.02.17.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 17:07:34 -0700 (PDT)
From: Adrian Fluturel <fluturel.adrian@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	Frank.Li@nxp.com,
	Adrian Fluturel <fluturel.adrian@gmail.com>
Subject: [PATCH] iio: magnetometer: add driver for mmc5603 sensor
Date: Fri,  3 Oct 2025 02:07:31 +0200
Message-ID: <20251003000731.22927-1-fluturel.adrian@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds support for the MMC5603 magnetometer.
Features:
	- Raw X/Y/Z readout in milligauss
	- Raw temp readout in millicelsius

Signed-off-by: Adrian Fluturel <fluturel.adrian@gmail.com>
---
 drivers/iio/magnetometer/Kconfig   |  11 +
 drivers/iio/magnetometer/Makefile  |   1 +
 drivers/iio/magnetometer/mmc5603.c | 629 +++++++++++++++++++++++++++++
 3 files changed, 641 insertions(+)
 create mode 100644 drivers/iio/magnetometer/mmc5603.c

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 3debf1320ad1..0895602eb631 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -139,6 +139,17 @@ config MMC35240
 	  To compile this driver as a module, choose M here: the module
 	  will be called mmc35240.
 
+config MMC5603
+       tristate "MEMSIC MMC5603NJ 3-axis magnetic sensor"
+       select REGMAP_I2C
+       depends on I2C
+       help
+	 Say yes here to build support for the MEMSIC MMC5603NJ 3-axis
+       	 magnetic sensor.
+
+	 To compile this driver as a module, choose M here: the module
+	 will be called mmc5603.
+	 
 config IIO_ST_MAGN_3AXIS
 	tristate "STMicroelectronics magnetometers 3-Axis Driver"
 	depends on (I2C || SPI_MASTER) && SYSFS
diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetometer/Makefile
index 9297723a97d8..776d9f94a71a 100644
--- a/drivers/iio/magnetometer/Makefile
+++ b/drivers/iio/magnetometer/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_BMC150_MAGN_SPI) += bmc150_magn_spi.o
 obj-$(CONFIG_MAG3110)	+= mag3110.o
 obj-$(CONFIG_HID_SENSOR_MAGNETOMETER_3D) += hid-sensor-magn-3d.o
 obj-$(CONFIG_MMC35240)	+= mmc35240.o
+obj-$(CONFIG_MMC5603)   += mmc5603.o
 
 obj-$(CONFIG_IIO_ST_MAGN_3AXIS) += st_magn.o
 st_magn-y := st_magn_core.o
diff --git a/drivers/iio/magnetometer/mmc5603.c b/drivers/iio/magnetometer/mmc5603.c
new file mode 100644
index 000000000000..4a0a4e97b728
--- /dev/null
+++ b/drivers/iio/magnetometer/mmc5603.c
@@ -0,0 +1,629 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MMC5603NJ - MEMSIC 3-axis magnetic sensor
+ *
+ * Copyright (c) 2025, Adrian Fluturel.
+ *
+ * IIO driver for MMC5603 (7-bit I2C slave address 0x30).
+ */
+
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/delay.h>
+#include <linux/regmap.h>
+#include <linux/pm.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#define MMC5603_DRV_NAME "mmc5603"
+#define MMC5603_REGMAP_NAME "mmc5603_regmap"
+
+/* Registers */
+#define MMC5603_REG_XOUT_0 0x00
+#define MMC5603_REG_XOUT_1 0x01
+#define MMC5603_REG_XOUT_2 0x06
+#define MMC5603_REG_YOUT_0 0x02
+#define MMC5603_REG_YOUT_1 0x03
+#define MMC5603_REG_YOUT_2 0x07
+#define MMC5603_REG_ZOUT_0 0x04
+#define MMC5603_REG_ZOUT_1 0x05
+#define MMC5603_REG_ZOUT_2 0x08
+#define MMC5603_REG_TOUT 0x09
+
+#define MMC5603_REG_STATUS 0x18
+#define MMC5603_REG_ODR 0x1A
+#define MMC5603_REG_CTRL0 0x1B
+#define MMC5603_REG_CTRL1 0x1C
+#define MMC5603_REG_CTRL2 0x1D
+
+#define MMC5603_REG_ID 0x39
+
+/* STATUS bits */
+#define MMC5603_STATUS_MEAS_M_DONE_BIT BIT(6)
+#define MMC5603_STATUS_MEAS_T_DONE_BIT BIT(7)
+
+/* CONTROL0 bits */
+#define MMC5603_CTRL0_TM_M_BIT BIT(0)
+#define MMC5603_CTRL0_TM_T_BIT BIT(1)
+#define MMC5603_CTRL0_SET_BIT BIT(3)
+#define MMC5603_CTRL0_RESET_BIT BIT(4)
+#define MMC5603_CTRL0_AUTO_SR_EN BIT(5)
+
+/* CONTROL1 bits */
+#define MMC5603_CTRL1_BW0_BIT BIT(0)
+#define MMC5603_CTRL1_BW1_BIT BIT(1)
+#define MMC5603_CTRL1_BW_MASK (MMC5603_CTRL1_BW0_BIT | MMC5603_CTRL1_BW1_BIT)
+#define MMC5603_CTRL1_BW_SHIFT 0
+#define MMC5603_CTRL1_SW_RESET_BIT BIT(7)
+
+/* WAIT TIMES */
+#define MMC5603_POWERUP_WAIT_TIME 20000 /* us */
+#define MMC5603_SR_WAIT_TIME 1000 /* us */
+#define MMC5603_MEAS_WAIT_TIME 6600 /* us */
+
+enum mmc5603_resolution {
+	MMC5603_16_BITS = 0,
+	MMC5603_18_BITS,
+	MMC5603_20_BITS,
+};
+
+enum mmc5603_channels {
+	AXIS_X = 0,
+	AXIS_Y,
+	AXIS_Z,
+	TEMPERATURE,
+};
+
+static const struct {
+	int sens;
+	int nfo;
+} mmc5603_props_table[] = {
+	/* 16 bits operation */
+	{
+		1024,
+		32768,
+	},
+	/* 18 bits operation */
+	{
+		4096,
+		131072,
+	},
+	/* 20 bits operation */
+	{
+		16384,
+		524288,
+	}
+};
+
+static const struct {
+	int val;
+	int val2;
+} mmc5603_samp_freq[] = {
+	{1, 200000},
+	{2, 0},
+	{3, 500000},
+	{6, 600000},
+};
+
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("1.2 2 3.5 6.6");
+
+#define MMC5603_CHANNEL(_axis) { \
+		.type = IIO_MAGN, \
+		.modified = 1, \
+		.channel2 = IIO_MOD_ ## _axis, \
+		.address = AXIS_ ## _axis, \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
+			BIT(IIO_CHAN_INFO_SCALE), \
+}
+
+static const struct iio_chan_spec mmc5603_channels[] = {
+	MMC5603_CHANNEL(X),
+	MMC5603_CHANNEL(Y),
+	MMC5603_CHANNEL(Z),
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
+		.address = TEMPERATURE,
+	},
+};
+
+static struct attribute *mmc5603_attributes[] = {
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group mmc5603_attribute_group = {
+	.attrs = mmc5603_attributes,
+};
+
+// Private data
+struct mmc5603_data {
+	struct i2c_client *client;
+	struct mutex mutex;
+	struct regmap *regmap;
+
+	enum mmc5603_resolution res;
+};
+
+static int mmc5603_get_samp_freq_index(struct mmc5603_data *data,
+				int val, int val2)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mmc5603_samp_freq); i++)
+		if (mmc5603_samp_freq[i].val == val &&
+		    mmc5603_samp_freq[i].val2 == val2)
+			return i;
+	return -EINVAL;
+}
+
+static int mmc5603_set(struct mmc5603_data *data, bool set)
+{
+	u8 set_reset_bit;
+
+	if (set)
+		set_reset_bit = MMC5603_CTRL0_SET_BIT;
+	else
+		set_reset_bit = MMC5603_CTRL0_RESET_BIT;
+
+	return regmap_set_bits(data->regmap, MMC5603_REG_CTRL0,
+			set_reset_bit);
+}
+
+static int mmc5603_sw_reset(struct mmc5603_data *data)
+{
+	int ret;
+
+	ret = regmap_set_bits(data->regmap, MMC5603_REG_CTRL1,
+			      MMC5603_CTRL1_SW_RESET_BIT);
+
+	if (ret < 0)
+		return ret;
+
+	/* The datasheet says to wait 20ms after a software reset */
+	usleep_range(MMC5603_POWERUP_WAIT_TIME,
+		     MMC5603_POWERUP_WAIT_TIME + 100);
+
+	return 0;
+}
+
+static int mmc5603_init(struct mmc5603_data *data)
+{
+	int ret;
+	unsigned int reg_id;
+
+	usleep_range(MMC5603_POWERUP_WAIT_TIME,
+		     MMC5603_POWERUP_WAIT_TIME + 100);
+
+	ret = regmap_read(data->regmap, MMC5603_REG_ID, &reg_id);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Error reading product id\n");
+		return ret;
+	}
+
+	dev_info(&data->client->dev, "MMC5603 chip id %x\n", reg_id);
+
+	/* Do a software reset */
+	ret = mmc5603_sw_reset(data);
+	if (ret < 0)
+		return ret;
+
+	/* Do a SET-RESET cycle to get more accurate readings */
+	ret = mmc5603_set(data, true);
+	if (ret < 0)
+		return ret;
+
+	/* Wait 1 millisecond after a SET or RESET */
+	usleep_range(MMC5603_SR_WAIT_TIME, MMC5603_SR_WAIT_TIME + 1);
+
+	ret = mmc5603_set(data, false);
+	if (ret < 0)
+		return ret;
+
+	usleep_range(MMC5603_SR_WAIT_TIME, MMC5603_SR_WAIT_TIME + 1);
+
+	/* Set default sampling frequency */
+	ret = regmap_update_bits(data->regmap, MMC5603_REG_CTRL1,
+				 MMC5603_CTRL1_BW_MASK, data->res);
+	if (ret < 0)
+		return ret;
+
+	/* Enable automatic periodic SET-RESET */
+	ret = regmap_set_bits(data->regmap, MMC5603_REG_CTRL0,
+			      MMC5603_CTRL0_AUTO_SR_EN);
+
+	return 0;
+}
+
+static int mmc5603_take_magn_measurement(struct mmc5603_data *data)
+{
+	int ret, tries = 100;
+	unsigned int reg_status;
+
+	ret = regmap_write(data->regmap, MMC5603_REG_CTRL0,
+			   MMC5603_CTRL0_TM_M_BIT);
+	if (ret < 0)
+		return ret;
+
+	while (tries-- > 0) {
+		ret = regmap_read(data->regmap, MMC5603_REG_STATUS,
+				  &reg_status);
+		if (ret < 0)
+			return ret;
+		if (reg_status & MMC5603_STATUS_MEAS_M_DONE_BIT)
+			break;
+
+		/* Minimum time between measurements */
+		usleep_range(MMC5603_MEAS_WAIT_TIME,
+			     MMC5603_MEAS_WAIT_TIME + 1);
+	}
+
+	if (tries < 0) {
+		dev_err(&data->client->dev, "data not ready");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int mmc5603_take_temp_measurement(struct mmc5603_data *data)
+{
+	int ret, tries = 100;
+	unsigned int reg_status;
+
+	ret = regmap_write(data->regmap, MMC5603_REG_CTRL0,
+			   MMC5603_CTRL0_TM_T_BIT);
+	if (ret < 0)
+		return ret;
+
+	while (tries-- > 0) {
+		ret = regmap_read(data->regmap, MMC5603_REG_STATUS,
+				  &reg_status);
+		if (ret < 0)
+			return ret;
+		if (reg_status & MMC5603_STATUS_MEAS_T_DONE_BIT) {
+			printk(KERN_INFO "Measurement T done bit is 1\n");
+			break;
+		}
+
+		/* Minimum time between measurements */
+		usleep_range(MMC5603_MEAS_WAIT_TIME,
+			     MMC5603_MEAS_WAIT_TIME + 1);
+	}
+
+	if (tries < 0) {
+		dev_err(&data->client->dev, "data not ready");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int mmc5603_read_magn_measurement(struct mmc5603_data *data,
+					 u32 ret_data[3])
+{
+	int ret;
+	u8 buf[9];
+
+	ret = mmc5603_take_magn_measurement(data);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_bulk_read(data->regmap, MMC5603_REG_XOUT_0, buf,
+			       9 * sizeof(u8));
+
+	// Extract X (registers 0x00, 0x01, 0x06)
+	ret_data[AXIS_X] = (buf[0] << 12) | (buf[1] << 4) | (buf[6] >> 4);
+
+	// Extract Y (registers 0x02, 0x03, 0x07)
+	ret_data[AXIS_Y] = (buf[2] << 12) | (buf[3] << 4) | (buf[7] >> 4);
+
+	// Extract Z (registers 0x04, 0x05, 0x08)
+	ret_data[AXIS_Z] = (buf[4] << 12) | (buf[5] << 4) | (buf[8] >> 4);
+
+	return ret;
+}
+
+static int mmc5603_read_temp_measurement(struct mmc5603_data *data,
+					 int *ret_data)
+{
+	int ret;
+
+	ret = mmc5603_take_temp_measurement(data);
+	if (ret < 0)
+		return ret;
+
+	return regmap_read(data->regmap, MMC5603_REG_TOUT, ret_data);
+}
+
+static int mmc5603_read_temperature(struct mmc5603_data *data, int *ret_data)
+{
+	int ret, raw_temp;
+
+	mutex_lock(&data->mutex);
+	ret = mmc5603_read_temp_measurement(data, &raw_temp);
+	mutex_unlock(&data->mutex);
+
+	if (ret < 0)
+		return ret;
+
+	/* 0.8 degrees Celsius/LSB, 0x00 is -75 degrees Celsius */
+	*ret_data = raw_temp * 800 - 75000;
+	return 0;
+}
+
+static int mmc5603_raw_to_mgauss(struct mmc5603_data *data, int index,
+				 u32 raw[], int *val)
+{
+	int sens;
+	int nfo;
+
+	sens = mmc5603_props_table[data->res].sens;
+	nfo = mmc5603_props_table[data->res].nfo;
+
+	switch (index) {
+	case AXIS_X:
+		*val = ((int)raw[AXIS_X] - nfo) * 1000 / sens;
+		break;
+	case AXIS_Y:
+		*val = ((int)raw[AXIS_Y] - nfo) * 1000 / sens;
+		break;
+	case AXIS_Z:
+		*val = ((int)raw[AXIS_Z] - nfo) * 1000 / sens;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int mmc5603_read_mgauss(struct mmc5603_data *data, int index, int *val)
+{
+	int ret;
+	u32 raw[3];
+
+	mutex_lock(&data->mutex);
+	ret = mmc5603_read_magn_measurement(data, raw);
+	mutex_unlock(&data->mutex);
+	if (ret < 0)
+		return ret;
+	ret = mmc5603_raw_to_mgauss(data, index, raw, val);
+	return ret;
+}
+
+static int mmc5603_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct mmc5603_data *data = iio_priv(indio_dev);
+	int ret, i;
+	unsigned int reg;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->address) {
+		case AXIS_X:
+		case AXIS_Y:
+		case AXIS_Z:
+			ret = mmc5603_read_mgauss(data, chan->address, val);
+			if (ret < 0)
+				return ret;
+			return IIO_VAL_INT;
+		case TEMPERATURE:
+			ret = mmc5603_read_temperature(data, val);
+			if (ret < 0)
+				return ret;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		/* For IIO_TEMP and IIO_MAGN, the result is in milligauss
+		   and millicelcius so the scale is the same. */
+		switch (chan->type) {
+		case IIO_MAGN:
+		case IIO_TEMP:
+			*val = 0;
+			*val2 = 1000;
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		mutex_lock(&data->mutex);
+		ret = regmap_read(data->regmap, MMC5603_REG_CTRL1, &reg);
+		mutex_unlock(&data->mutex);
+
+		if (ret < 0)
+			return ret;
+
+		i = (reg & MMC5603_CTRL1_BW_MASK);
+		if (i < 0 || i >= ARRAY_SIZE(mmc5603_samp_freq))
+			return -EINVAL;
+
+		*val = mmc5603_samp_freq[i].val;
+		*val2 = mmc5603_samp_freq[i].val2;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mmc5603_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct mmc5603_data *data = iio_priv(indio_dev);
+	int i, ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		i = mmc5603_get_samp_freq_index(data, val, val2);
+		if (i < 0)
+			return -EINVAL;
+		mutex_lock(&data->mutex);
+		ret = regmap_update_bits(data->regmap, MMC5603_REG_CTRL1,
+					 MMC5603_CTRL1_BW_MASK,
+					 i << MMC5603_CTRL1_BW_SHIFT);
+		mutex_unlock(&data->mutex);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info mmc5603_info = {
+	.read_raw = mmc5603_read_raw,
+	.write_raw = mmc5603_write_raw,
+	.attrs = &mmc5603_attribute_group
+};
+
+static bool mmc5603_is_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MMC5603_REG_CTRL0:
+	case MMC5603_REG_CTRL1:
+	case MMC5603_REG_CTRL2:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool mmc5603_is_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MMC5603_REG_XOUT_0:
+	case MMC5603_REG_XOUT_1:
+	case MMC5603_REG_XOUT_2:
+	case MMC5603_REG_YOUT_0:
+	case MMC5603_REG_YOUT_1:
+	case MMC5603_REG_YOUT_2:
+	case MMC5603_REG_ZOUT_0:
+	case MMC5603_REG_ZOUT_1:
+	case MMC5603_REG_ZOUT_2:
+	case MMC5603_REG_TOUT:
+	case MMC5603_REG_STATUS:
+	case MMC5603_REG_ID:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool mmc5603_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MMC5603_REG_CTRL0:
+	case MMC5603_REG_CTRL1:
+	case MMC5603_REG_CTRL2:
+		return false;
+	default:
+		return true;
+	}
+}
+
+static const struct reg_default mmc5603_reg_defaults[] = {
+	{ MMC5603_REG_CTRL0, 0x0 },
+	{ MMC5603_REG_CTRL1, 0x0 },
+};
+
+static const struct regmap_config mmc5603_regmap_config = {
+	.name = MMC5603_REGMAP_NAME,
+
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = MMC5603_REG_ID,
+	.cache_type = REGCACHE_FLAT,
+
+	.writeable_reg = mmc5603_is_writeable_reg,
+	.readable_reg = mmc5603_is_readable_reg,
+	.volatile_reg = mmc5603_is_volatile_reg,
+
+	.reg_defaults = mmc5603_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(mmc5603_reg_defaults),
+};
+
+static int mmc5603_probe(struct i2c_client *client) {
+	struct mmc5603_data *data;
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	regmap = devm_regmap_init_i2c(client, &mmc5603_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "regmap initialization failed\n");
+		return PTR_ERR(regmap);
+	}
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+	data->regmap = regmap;
+	data->res = MMC5603_20_BITS;
+
+	mutex_init(&data->mutex);
+
+	indio_dev->info = &mmc5603_info;
+	indio_dev->name = MMC5603_DRV_NAME;
+	indio_dev->channels = mmc5603_channels;
+	indio_dev->num_channels = ARRAY_SIZE(mmc5603_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = mmc5603_init(data);
+	if (ret < 0) {
+		dev_err(&client->dev, "mmc5603 chip init failed\n");
+		return ret;
+	}
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+// Device tree matching
+static const struct of_device_id mmc5603_of_match[] = {
+	{ .compatible = "memsic,mmc5603", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mmc5603_of_match);
+
+// ACPI matching
+static const struct acpi_device_id mmc5603_acpi_match[] = {
+	{"MMC5603", 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, mmc5603_acpi_match);
+
+// Raw I2C matching
+static const struct i2c_device_id mmc5603_id[] = {
+	{ "mmc5603" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mmc5603_id);
+
+static struct i2c_driver mmc5603_driver = {
+	.driver = {
+		.name = MMC5603_DRV_NAME,
+		.of_match_table = mmc5603_of_match,
+		.acpi_match_table = mmc5603_acpi_match,
+	},
+	.probe = mmc5603_probe,
+	.id_table = mmc5603_id,
+};
+
+module_i2c_driver(mmc5603_driver);
+
+MODULE_AUTHOR("Adrian Fluturel <adrian.fluturel@protonmail.com>");
+MODULE_DESCRIPTION("MEMSIC MMC5603 magnetic sensor driver");
+MODULE_LICENSE("GPL v2");
-- 
2.48.1


