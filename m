Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC1866A28
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2019 11:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfGLJl2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Jul 2019 05:41:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51980 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfGLJl1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Jul 2019 05:41:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so8284520wma.1
        for <linux-iio@vger.kernel.org>; Fri, 12 Jul 2019 02:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5t/i/WcvGwyfpdgTajUuRwsLpVeFOZFYkuHu3i+OhN8=;
        b=vobkhHSsftwgo2Xa12Dw1w6c+Ufilw8Y3RG/uMOsAZeIPeX6q+JlmPZF30FVu71IPF
         Xp/p4BXu9AqPFRJLi4P0MWU/tKHTvSf8Vw05B3GDH7JFUs4cQvUeS/CMlYZQmMG/5LTS
         nlT/ecJOSuOm0AX+aIppyVPoilm1mR8psIby7jhiRDLLIdsC4TG6G4bcLBQtftba5GVq
         6ckHfka96U+5A8+cCXGqHJnV4nxri1oGUI+Mwg/OTE1IPQ+EKopHwK7BZ9remhJXGY95
         0Eb5/jiCAuxSwqvJHZ05HGPsWPDtwqM+AIBTzx1UrGeT/6tH7b28MHaJ9EDkTCLwlbIe
         uQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5t/i/WcvGwyfpdgTajUuRwsLpVeFOZFYkuHu3i+OhN8=;
        b=eno1Saj23DGexX6i/cV6ci7P4LVbPwCZgxk9jnmh+DTrQyQpKOjGaCc8YK92RJf4Y+
         VG4/7YBnMyf2qXm/RbG6XsX6FGDCf1rPi6fk5eRTSA3QA+YBwoL+JcewMaswOCvClfyH
         G6jO0tFKU+J/YLQJ5Js50CXFguCfy9wscPMdLCJsGuQ/LACl+q3RRfG51Hv1KEb+eP6K
         a2l2pHv09zM9PhSclsPNHuZSWTtziRwWmxnNbU9rhTVm7/3kp1cn/Cen3gWikS3g7Daq
         Oo1YXNRJ0jclVvuaDU9pUyA8jCH6y2OTE6QQLUKb3LT9BDEAwZIhiozOmJelBYi+yK5b
         gChw==
X-Gm-Message-State: APjAAAVYRfbCgU5LMkiXkfReuIbpkGbu5eY7U4MaKJUyn+XkvLcB2+wk
        1c7PFedgtzfK9hVxVKkT4wAuN06aw5A=
X-Google-Smtp-Source: APXvYqz6ICKagKev7mslCiyA7tBFadahjS6xduWeiON8cv9teXNml079yE9xaaXHWoiy4ZZlHUIXfQ==
X-Received: by 2002:a1c:5453:: with SMTP id p19mr8335396wmi.148.1562924484124;
        Fri, 12 Jul 2019 02:41:24 -0700 (PDT)
Received: from pop-os.baylibre.local ([2a01:e35:8ad2:2cb0:2dbb:fac9:5ec0:e3ef])
        by smtp.googlemail.com with ESMTPSA id p18sm7310891wrm.16.2019.07.12.02.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 02:41:23 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        baylibre-upstreaming@groups.io, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v4 3/3] iio: Add PAT9125 optical tracker sensor
Date:   Fri, 12 Jul 2019 11:40:50 +0200
Message-Id: <20190712094050.17432-4-amergnat@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190712094050.17432-1-amergnat@baylibre.com>
References: <20190712094050.17432-1-amergnat@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds support for PixArt Imaging’s miniature low power optical
navigation chip using LASER light source enabling digital surface tracking.

Features and datasheet: [0]

This IIO driver allows to read relative position from where the system
started on X and Y axis through two way:
  - Punctual "read_raw" which will issue a read in the device registers to
  get the delta between last/current read and return the addition of all
  the deltas.
  - Buffer read. Data can be retrieved using triggered buffer subscription
  (i.e. iio_readdev). The buffer payload is:
    |32 bits delta X|32 bits delta Y|timestamp|.

The possible I2C addresses are 0x73, 0x75 and 0x79.

X and Y axis CPI resolution can be get/set independently through IIO_SCALE.
The range value is 0-255 which means:
  - 0 to ~1,275 Counts Per Inch on flat surface.
  - 0 to ~630 Counts Per Rev on 1.0mm diameter STS shaft at 1.0mm distance.
More details on the datasheet.

The "position" directory is added to contain drivers which can provide
position data.

[0]: http://www.pixart.com/products-detail/72/PAT9125EL-TKIT___TKMT

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/iio/Kconfig            |   1 +
 drivers/iio/Makefile           |   1 +
 drivers/iio/position/Kconfig   |  18 ++
 drivers/iio/position/Makefile  |   6 +
 drivers/iio/position/pat9125.c | 506 +++++++++++++++++++++++++++++++++
 5 files changed, 532 insertions(+)
 create mode 100644 drivers/iio/position/Kconfig
 create mode 100644 drivers/iio/position/Makefile
 create mode 100644 drivers/iio/position/pat9125.c

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 5bd51853b15e..aca6fcbceeab 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -85,6 +85,7 @@ source "drivers/iio/light/Kconfig"
 source "drivers/iio/magnetometer/Kconfig"
 source "drivers/iio/multiplexer/Kconfig"
 source "drivers/iio/orientation/Kconfig"
+source "drivers/iio/position/Kconfig"
 if IIO_TRIGGER
    source "drivers/iio/trigger/Kconfig"
 endif #IIO_TRIGGER
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index bff682ad1cfb..1712011c0f4a 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -31,6 +31,7 @@ obj-y += light/
 obj-y += magnetometer/
 obj-y += multiplexer/
 obj-y += orientation/
+obj-y += position/
 obj-y += potentiometer/
 obj-y += potentiostat/
 obj-y += pressure/
diff --git a/drivers/iio/position/Kconfig b/drivers/iio/position/Kconfig
new file mode 100644
index 000000000000..1cf28896511c
--- /dev/null
+++ b/drivers/iio/position/Kconfig
@@ -0,0 +1,18 @@
+#
+# Optical tracker sensors
+#
+# When adding new entries keep the list in alphabetical order
+
+menu "Optical tracker sensors"
+
+config PAT9125
+	tristate "Optical tracker PAT9125 I2C driver"
+	depends on I2C
+	select IIO_BUFFER
+	help
+	  Say yes here to build support for PAT9125 optical tracker
+	  sensors.
+
+          To compile this driver as a module, say M here: the module will
+          be called pat9125.
+endmenu
diff --git a/drivers/iio/position/Makefile b/drivers/iio/position/Makefile
new file mode 100644
index 000000000000..cf294917ae2c
--- /dev/null
+++ b/drivers/iio/position/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for industrial I/O Optical tracker sensor drivers
+#
+
+# When adding new entries keep the list in alphabetical order
+obj-$(CONFIG_PAT9125) += pat9125.o
diff --git a/drivers/iio/position/pat9125.c b/drivers/iio/position/pat9125.c
new file mode 100644
index 000000000000..2f04777e0790
--- /dev/null
+++ b/drivers/iio/position/pat9125.c
@@ -0,0 +1,506 @@
+// SPDX-License-Identifier: (GPL-2.0)
+/*
+ * Copyright (C) 2019 BayLibre, SAS
+ * Author: Alexandre Mergnat <amergnat@baylibre.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/kfifo_buf.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+/* I2C Address function to ID pin*/
+#define PAT9125_I2C_ADDR_HI		0x73
+#define PAT9125_I2C_ADDR_LO		0x75
+#define PAT9125_I2C_ADDR_NC		0x79
+
+/* Registers */
+#define PAT9125_PRD_ID1_REG		0x00
+#define PAT9125_PRD_ID2_REG		0x01
+#define PAT9125_MOTION_STATUS_REG	0x02
+#define PAT9125_DELTA_X_LO_REG		0x03
+#define PAT9125_DELTA_Y_LO_REG		0x04
+#define PAT9125_OP_MODE_REG		0x05
+#define PAT9125_CONFIG_REG		0x06
+#define PAT9125_WRITE_PROTEC_REG	0x09
+#define PAT9125_SLEEP1_REG		0x0A
+#define PAT9125_SLEEP2_REG		0x0B
+#define PAT9125_RES_X_REG		0x0D
+#define PAT9125_RES_Y_REG		0x0E
+#define PAT9125_DELTA_XY_HI_REG		0x12
+#define PAT9125_SHUTER_REG		0x14
+#define PAT9125_FRAME_AVG_REG		0x17
+#define PAT9125_ORIENTATION_REG		0x19
+
+/* Bits */
+#define PAT9125_VALID_MOTION_DATA_BIT	BIT(7)
+#define PAT9125_RESET_BIT		BIT(7)
+
+/* Registers' values */
+#define PAT9125_SENSOR_ID_VAL			0x31
+#define PAT9125_DISABLE_WRITE_PROTECT_VAL	0x5A
+#define PAT9125_ENABLE_WRITE_PROTECT_VAL	0x00
+
+/* Default Value of sampled value size */
+#define PAT9125_SAMPLED_VAL_BIT_SIZE		12
+
+struct pat9125_data {
+	struct regmap *regmap;
+	struct iio_trigger *indio_trig;	/* Motion detection */
+	s32 position_x;
+	s32 position_y;
+	bool sampling;
+};
+
+static const struct iio_chan_spec pat9125_channels[] = {
+	{
+		.type = IIO_DISTANCE,
+		.modified = 1,
+		.channel2 = IIO_MOD_X,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
+	},
+	{
+		.type = IIO_DISTANCE,
+		.modified = 1,
+		.channel2 = IIO_MOD_Y,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(2),
+};
+
+/**
+ * pat9125_write_pretected_reg() - Write value in protected register.
+ *
+ * @regmap: Pointer to I2C register map.
+ * @reg_addr: Register address.
+ * @reg_value: Value to be write in register.
+ *
+ * A value of zero will be returned on success, a negative errno will
+ * be returned in error cases.
+ */
+static int pat9125_write_pretected_reg(struct iio_dev *indio_dev,
+	u8 reg_addr, u8 reg_value)
+{
+	struct pat9125_data *data = iio_priv(indio_dev);
+	int ret;
+
+	ret = regmap_write(data->regmap,
+		PAT9125_WRITE_PROTEC_REG,
+		PAT9125_DISABLE_WRITE_PROTECT_VAL);
+
+	if (!ret)
+		ret = regmap_write(data->regmap, reg_addr, reg_value);
+
+	/* Try to put back write protection everytime */
+	ret |= regmap_write(data->regmap,
+		PAT9125_WRITE_PROTEC_REG,
+		PAT9125_ENABLE_WRITE_PROTECT_VAL);
+
+	return ret;
+}
+/**
+ * pat9125_read_delta() - Read delta value, update delta & position data.
+ *
+ * @data: Driver's data structure.
+ *
+ * A value of zero will be returned on success, a negative errno will
+ * be returned in error cases.
+ */
+static int pat9125_read_delta(struct pat9125_data *data)
+{
+	struct regmap *regmap = data->regmap;
+	int status = 0;
+	int val_x = 0;
+	int val_y = 0;
+	int val_high_nibbles = 0;
+	int ret;
+
+	ret = regmap_read(regmap, PAT9125_MOTION_STATUS_REG, &status);
+	if (ret < 0)
+		return ret;
+
+	/* Check if motion is detected */
+	if (status & PAT9125_VALID_MOTION_DATA_BIT) {
+		ret = regmap_read(regmap, PAT9125_DELTA_X_LO_REG, &val_x);
+		if (ret < 0)
+			return ret;
+
+		ret = regmap_read(regmap, PAT9125_DELTA_Y_LO_REG, &val_y);
+		if (ret < 0)
+			return ret;
+
+		ret = regmap_read(regmap, PAT9125_DELTA_XY_HI_REG,
+			&val_high_nibbles);
+		if (ret < 0)
+			return ret;
+
+		val_x |= (val_high_nibbles << 4) & 0xF00;
+		val_y |= (val_high_nibbles << 8) & 0xF00;
+		val_x = sign_extend32(val_x,
+			PAT9125_SAMPLED_VAL_BIT_SIZE - 1);
+		val_y = sign_extend32(val_y,
+			PAT9125_SAMPLED_VAL_BIT_SIZE - 1);
+		data->position_x += val_x;
+		data->position_y += val_y;
+	}
+	return 0;
+}
+
+/**
+ * pat9125_read_raw() - Sample and return the value(s)
+ * function to the associated channel info enum.
+ *
+ * @indio_dev:	Industrial I/O device.
+ * @chan:	Specification of a single channel.
+ * @val:	Contain the elements making up the returned value.
+ * @val2:	Not used.
+ * @mask:	(enum iio_chan_info_enum) Type of the info attribute.
+ *
+ * Zero will be returned on success, negative value otherwise.
+ **/
+static int pat9125_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct pat9125_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = pat9125_read_delta(data);
+		if (ret)
+			return ret;
+		switch (chan->channel2) {
+		case IIO_MOD_X:
+			*val = data->position_x;
+			return IIO_VAL_INT;
+		case IIO_MOD_Y:
+			*val = data->position_y;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->channel2) {
+		case IIO_MOD_X:
+			ret = regmap_read(data->regmap, PAT9125_RES_X_REG, val);
+			if (ret)
+				return ret;
+			else
+				return IIO_VAL_INT;
+		case IIO_MOD_Y:
+			ret = regmap_read(data->regmap, PAT9125_RES_Y_REG, val);
+			if (ret)
+				return ret;
+			else
+				return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+/**
+ * pat9125_write_raw() - Write the value(s)
+ * function to the associated channel info enum.
+ *
+ * @indio_dev:	Industrial I/O device.
+ * @chan:	Specification of a single channel.
+ * @val:	Value write in the channel.
+ * @val2:	Not used.
+ * @mask:	(enum iio_chan_info_enum) Type of the info attribute.
+ *
+ * Zero will be returned on success, negative value otherwise.
+ **/
+static int pat9125_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->channel2) {
+		case IIO_MOD_X:
+			ret = pat9125_write_pretected_reg(indio_dev,
+				PAT9125_RES_X_REG, val);
+			return ret;
+		case IIO_MOD_Y:
+			ret = pat9125_write_pretected_reg(indio_dev,
+				PAT9125_RES_Y_REG, val);
+			return ret;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static irqreturn_t pat9125_threaded_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct pat9125_data *data = iio_priv(indio_dev);
+	u8 buf[16]; /* Payload: Pos_X (4) | Pos_Y (4) | Timestamp (8) */
+	int ret;
+	s64 timestamp;
+
+	data->sampling = true;
+	ret = pat9125_read_delta(data);
+	if (ret) {
+		dev_err(indio_dev->dev.parent, "Read delta failed %d\n", ret);
+		return IRQ_NONE;
+	}
+	timestamp = iio_get_time_ns(indio_dev);
+	*((s32 *)&buf[0]) = data->position_x;
+	*((s32 *)&buf[sizeof(s32)]) = data->position_y;
+	iio_push_to_buffers_with_timestamp(indio_dev, buf, timestamp);
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
+/**
+ * pat9125_threaded_event_handler() - Threaded motion detection event handler
+ * @irq: The irq being handled.
+ * @private: struct iio_device pointer for the device.
+ */
+static irqreturn_t pat9125_threaded_event_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct pat9125_data *data = iio_priv(indio_dev);
+
+	iio_trigger_poll_chained(data->indio_trig);
+	return IRQ_HANDLED;
+}
+
+/**
+ * pat9125_buffer_postenable() - Buffer post enable actions
+ *
+ * @indio_dev:	Industrial I/O device.
+ */
+static int pat9125_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct pat9125_data *data = iio_priv(indio_dev);
+	int ret = 0;
+
+	ret = iio_triggered_buffer_postenable(indio_dev);
+	if (ret)
+		return ret;
+
+	/* Release interrupt pin on the device */
+	ret = pat9125_read_delta(data);
+
+	/* iio_trigger_detach_poll_func isn't reachable, so use this function */
+	if (ret)
+		ret = iio_triggered_buffer_predisable(indio_dev);
+
+	return ret;
+}
+
+static const struct iio_buffer_setup_ops pat9125_buffer_ops = {
+	.postenable = pat9125_buffer_postenable,
+};
+
+static const struct regmap_config pat9125_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static const struct iio_info pat9125_info = {
+	.read_raw = pat9125_read_raw,
+	.write_raw = pat9125_write_raw,
+};
+
+/*
+ * To detect if a new value is available, register status is checked. This
+ * method is safer than using a flag on GPIO IRQ to track event while sampling
+ * because falling edge is missed when device trig just after a read reg value
+ * (that happen for fast motions or high CPI setting).
+ *
+ * Note: To avoid infinite loop in "iio_trigger_notify_done" when it is not in
+ * buffer mode and kernel warning due to nested IRQ thread,
+ * this function must return 0.
+ */
+static int pat9125_trig_try_reenable(struct iio_trigger *trig)
+{
+	struct pat9125_data *data = iio_trigger_get_drvdata(trig);
+	struct regmap *regmap = data->regmap;
+	int status = 0;
+
+	if (data->sampling) {
+		regmap_read(regmap, PAT9125_MOTION_STATUS_REG, &status);
+		if (status & PAT9125_VALID_MOTION_DATA_BIT) {
+			data->sampling = false;
+			iio_trigger_poll_chained(data->indio_trig);
+			return 0;
+		}
+	}
+	data->sampling = false;
+	return 0;
+}
+
+static const struct iio_trigger_ops pat9125_trigger_ops = {
+	.try_reenable = pat9125_trig_try_reenable,
+};
+
+static int pat9125_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct pat9125_data *data;
+	struct iio_dev *indio_dev;
+	int ret, sensor_pid;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev) {
+		dev_err(&client->dev, "IIO device allocation failed\n");
+		return -ENOMEM;
+	}
+
+	data = iio_priv(indio_dev);
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->name = id->name;
+	indio_dev->channels = pat9125_channels;
+	indio_dev->num_channels = ARRAY_SIZE(pat9125_channels);
+	indio_dev->info = &pat9125_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
+		pat9125_threaded_trigger_handler, &pat9125_buffer_ops);
+	if (ret) {
+		dev_err(&client->dev, "unable to setup triggered buffer\n");
+		return ret;
+	}
+
+	data->indio_trig = devm_iio_trigger_alloc(&client->dev, "%s-dev%d",
+		indio_dev->name, indio_dev->id);
+	if (!data->indio_trig)
+		return -ENOMEM;
+	data->indio_trig->dev.parent = &client->dev;
+	data->indio_trig->ops = &pat9125_trigger_ops;
+	iio_trigger_set_drvdata(data->indio_trig, data);
+	ret = devm_iio_trigger_register(&client->dev, data->indio_trig);
+	if (ret) {
+		dev_err(&client->dev, "unable to register trigger\n");
+		return ret;
+	}
+
+	data->regmap = devm_regmap_init_i2c(client, &pat9125_regmap_config);
+	if (IS_ERR(data->regmap)) {
+		dev_err(&client->dev, "regmap init failed %ld\n",
+			PTR_ERR(data->regmap));
+		return PTR_ERR(data->regmap);
+	}
+
+	/* Check device ID */
+	ret = regmap_read(data->regmap, PAT9125_PRD_ID1_REG, &sensor_pid);
+	if (ret < 0) {
+		dev_err(&client->dev, "register 0x%x access failed %d\n",
+			PAT9125_PRD_ID1_REG, ret);
+		return ret;
+	}
+	if (sensor_pid != PAT9125_SENSOR_ID_VAL)
+		return -ENODEV;
+
+	/* Switch to bank0 (Magic number)*/
+	ret = regmap_write(data->regmap, 0x7F, 0x00);
+	if (ret < 0) {
+		dev_err(indio_dev->dev.parent, "register 0x%x access failed %d\n",
+			0x7F, ret);
+		return ret;
+	}
+
+	/* Software reset */
+	ret = regmap_write_bits(data->regmap,
+			      PAT9125_CONFIG_REG,
+			      PAT9125_RESET_BIT,
+			      1);
+	if (ret < 0) {
+		dev_err(&client->dev, "register 0x%x access failed %d\n",
+			PAT9125_CONFIG_REG, ret);
+		return ret;
+	}
+
+	msleep(20);
+
+	/* Init GPIO IRQ */
+	if (client->irq) {
+		ret = devm_request_threaded_irq(&client->dev,
+			client->irq,
+			NULL,
+			pat9125_threaded_event_handler,
+			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+			"pat9125",
+			indio_dev);
+		if (ret) {
+			dev_err(&client->dev, "GPIO IRQ init failed\n");
+			return ret;
+		}
+	}
+
+	ret = devm_iio_device_register(&client->dev, indio_dev);
+	if (ret) {
+		dev_err(&client->dev, "IIO device register failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct i2c_device_id pat9125_id[] = {
+	{ "pat9125", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, pat9125_id);
+
+static const unsigned short normal_i2c[] = {
+	PAT9125_I2C_ADDR_HI,
+	PAT9125_I2C_ADDR_LO,
+	PAT9125_I2C_ADDR_NC,
+	I2C_CLIENT_END
+};
+
+static struct i2c_driver pat9125_driver = {
+	.driver = {
+		.name = "pat9125",
+	},
+	.probe = pat9125_probe,
+	.address_list = normal_i2c,
+	.id_table = pat9125_id,
+};
+
+module_i2c_driver(pat9125_driver);
+
+MODULE_AUTHOR("Alexandre Mergnat <amergnat@baylibre.com>");
+MODULE_DESCRIPTION("Optical Tracking sensor");
+MODULE_LICENSE("GPL");
-- 
2.17.1

