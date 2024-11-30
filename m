Return-Path: <linux-iio+bounces-12871-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9F79DF252
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 18:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8A4162E2F
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 17:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EB61A7274;
	Sat, 30 Nov 2024 17:42:51 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C82B1A704C;
	Sat, 30 Nov 2024 17:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.101.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732988571; cv=none; b=TBuGzWmrnhjiYJ/PTMUvlqaI6atkEkI8iKQk7xoQKcyTsi/n+PI8AmX18l7k2brYdR7Q0doNx0skO8onQikm/osJYMIKoC2JSQUYAZv3LKYAg1Fo+OXxwICT7HWS+j7wqOW9dZzIbYM+3qpkuf6Ul9UFGJCBy8CF8eM94uaL/Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732988571; c=relaxed/simple;
	bh=LBBdeBc1LSHiO31DNwrh5fUhRPGRqxNInSjsES1Gq7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhYnuhnjg0rkWWQxFVPCinO5nCXV7jekRhokDBfPLIUUpBbPCdvAPL9GzmXLFFiWghNiDHlYIW0yC9zrh+dvWsgcOymZGmgNwY2c48qSeeNXciOMMZygItKTXdzYfg8qktHTKRemcmp/hhpxcWO/c/sE0FR7XCdiC1MQWc9yxMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io; spf=pass smtp.mailfrom=sys-base.io; arc=none smtp.client-ip=185.233.101.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
	by leonov.paulk.fr (Postfix) with ESMTPS id 8A8781F00036;
	Sat, 30 Nov 2024 17:42:46 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
	id 068E7A66ACA; Sat, 30 Nov 2024 17:42:45 +0000 (UTC)
X-Spam-Level: *
Received: from localhost.localdomain (unknown [192.168.1.64])
	by laika.paulk.fr (Postfix) with ESMTP id A2473A66AC2;
	Sat, 30 Nov 2024 17:42:22 +0000 (UTC)
From: Paul Kocialkowski <paulk@sys-base.io>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Kocialkowski <paulk@sys-base.io>
Subject: [PATCH 2/2] iio: light: Add support for the TI OPT4048 color sensor
Date: Sat, 30 Nov 2024 18:42:12 +0100
Message-ID: <20241130174212.3298371-2-paulk@sys-base.io>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241130174212.3298371-1-paulk@sys-base.io>
References: <20241130174212.3298371-1-paulk@sys-base.io>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Texas Instruments OPT4048 is a XYZ tristimulus color sensor,
with an additional wide (visible + IR) channel.

This driver implements support for all channels, with configurable
integration time and auto-gain. Both direct reading and
triggered-buffer modes are supported.

Note that the Y channel is also reported as a separate illuminance
channel, for which a scale is provided (following the datasheet) to
convert it to lux units. Falling and rising thresholds are supported
for this channel.

The device's interrupt can be used to sample all channels at the end
of conversion and is optional.

Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>
---
 drivers/iio/light/Kconfig   |   10 +
 drivers/iio/light/Makefile  |    1 +
 drivers/iio/light/opt4048.c | 1145 +++++++++++++++++++++++++++++++++++
 3 files changed, 1156 insertions(+)
 create mode 100644 drivers/iio/light/opt4048.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index f2f3e414849a..6d0cc1eecae0 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -492,6 +492,16 @@ config OPT4001
 	  If built as a dynamically linked module, it will be called
 	  opt4001.
 
+config OPT4048
+	tristate "Texas Instruments OPT4048 XYZ tristimulus color sensor driver"
+	depends on I2C && PM
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Support for the Texas Instruments OPT4048 XYZ tristimulus color sensor.
+
+	  This driver can be built-in or built as a module, called opt4048.
+
 config PA12203001
 	tristate "TXC PA12203001 light and proximity sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index 321010fc0b93..f2031e6236f9 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -42,6 +42,7 @@ obj-$(CONFIG_MAX44009)		+= max44009.o
 obj-$(CONFIG_NOA1305)		+= noa1305.o
 obj-$(CONFIG_OPT3001)		+= opt3001.o
 obj-$(CONFIG_OPT4001)		+= opt4001.o
+obj-$(CONFIG_OPT4048)		+= opt4048.o
 obj-$(CONFIG_PA12203001)	+= pa12203001.o
 obj-$(CONFIG_ROHM_BU27008)	+= rohm-bu27008.o
 obj-$(CONFIG_ROHM_BU27034)	+= rohm-bu27034.o
diff --git a/drivers/iio/light/opt4048.c b/drivers/iio/light/opt4048.c
new file mode 100644
index 000000000000..1ad5e6586aad
--- /dev/null
+++ b/drivers/iio/light/opt4048.c
@@ -0,0 +1,1145 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2024 Paul Kocialkowski <paulk@sys-base.io>
+ */
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/log2.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
+
+#define OPT4048_CH0_DATA0			0x0
+#define OPT4048_CH0_DATA1			0x1
+#define OPT4048_CH1_DATA0			0x2
+#define OPT4048_CH1_DATA1			0x3
+#define OPT4048_CH2_DATA0			0x4
+#define OPT4048_CH2_DATA1			0x5
+#define OPT4048_CH3_DATA0			0x6
+#define OPT4048_CH3_DATA1			0x7
+
+#define OPT4048_CH_DATA0_MSB_VALUE(v)		((v) & GENMASK(11, 0))
+#define OPT4048_CH_DATA0_EXPONENT_VALUE(v)	(((v) & GENMASK(15, 12)) >> 12)
+
+#define OPT4048_CH_DATA1_CRC_VALUE(v)		((v) & GENMASK(3, 0))
+#define OPT4048_CH_DATA1_COUNTER_VALUE(v)	(((v) & GENMASK(7, 4)) >> 4)
+#define OPT4048_CH_DATA1_LSB_VALUE(v)		(((v) & GENMASK(15, 8)) >> 8)
+
+#define OPT4048_THRESHOLD_L			0x8
+#define OPT4048_THRESHOLD_H			0x9
+
+#define OPT4048_THRESHOLD_RESULT(v)		((v) & GENMASK(11, 0))
+#define OPT4048_THRESHOLD_RESULT_MAX		((1 << 12) - 1)
+#define OPT4048_THRESHOLD_EXPONENT(v)		(((v) << 12) & GENMASK(15, 12))
+#define OPT4048_THRESHOLD_EXPONENT_MAX		((1 << 4) - 1)
+
+#define OPT4048_CFG0				0xa
+#define OPT4048_CFG0_FAULT_COUNT_1		0
+#define OPT4048_CFG0_FAULT_COUNT_2		1
+#define OPT4048_CFG0_FAULT_COUNT_4		2
+#define OPT4048_CFG0_FAULT_COUNT_8		3
+#define OPT4048_CFG0_INT_POL_ACTIVE_LOW		0
+#define OPT4048_CFG0_INT_POL_ACTIVE_HIGH	BIT(2)
+#define OPT4048_CFG0_LATCH			BIT(3)
+#define OPT4048_CFG0_OP_MODE_POWER_DOWN		0
+#define OPT4048_CFG0_OP_MODE_ONESHOT_AUTORANGE	(1 << 4)
+#define OPT4048_CFG0_OP_MODE_ONESHOT		(2 << 4)
+#define OPT4048_CFG0_OP_MODE_CONTINUOUS		(3 << 4)
+#define OPT4048_CFG0_CONVERSION_TIME(v)		(((v) << 6) & GENMASK(9, 6))
+#define OPT4048_CFG0_RANGE(v)			(((v) << 10) & GENMASK(13, 10))
+#define OPT4048_CFG0_RANGE_AUTO			(12 << 10)
+#define OPT4048_CFG0_QWAKE			BIT(15)
+
+#define OPT4048_CFG1				0xb
+#define OPT4048_CFG1_I2C_BURST			BIT(0)
+#define OPT4048_CFG1_INT_CFG_ALERT		0
+#define OPT4048_CFG1_INT_CFG_DATA_READY_NEXT	(1 << 2)
+#define OPT4048_CFG1_INT_CFG_DATA_READY_ALL	(3 << 2)
+#define OPT4048_CFG1_INT_DIR_IN			0
+#define OPT4048_CFG1_INT_DIR_OUT		BIT(4)
+#define OPT4048_CFG1_THRESHOLD_CH_SEL(i)	(((i) << 5) & GENMASK(6, 5))
+#define OPT4048_CFG1_RESERVED			(0x80 << 7)
+
+#define OPT4048_STATUS				0xc
+#define OPT4048_STATUS_FLAG_L			BIT(0)
+#define OPT4048_STATUS_FLAG_H			BIT(1)
+#define OPT4048_STATUS_CONV_READY_FLAG		BIT(2)
+#define OPT4048_STATUS_OVERLOAD_FLAG		BIT(3)
+
+#define OPT4048_DID				0x11
+#define OPT4048_DID_L_VALUE(v)			(((v) & GENMASK(13, 12)) >> 12)
+#define OPT4048_DID_H_VALUE(v)			((v) & GENMASK(11, 0))
+#define OPT4048_DID_VALUE(l, h)			(((h) << 2) | (l))
+
+#define OPT4048_DID_OPT4048			0x2084
+
+#define OPT4048_SCALE_ULUX			2150
+
+struct opt4048_sensor_state {
+	bool active;
+	u8 conversion_time_index;
+	u16 threshold_low[2];
+	bool threshold_low_active;
+	u16 threshold_high[2];
+	bool threshold_high_active;
+	u16 status;
+};
+
+struct opt4048_sensor_scan {
+	u32 channels[5];
+	s64 timestamp __aligned(8);
+};
+
+struct opt4048_sensor {
+	struct device *dev;
+	struct i2c_client *i2c_client;
+	struct iio_dev *iio_dev;
+
+	struct regulator *vdd_supply;
+
+	struct opt4048_sensor_state state;
+	struct opt4048_sensor_scan scan;
+	bool scan_sync;
+	struct mutex lock;
+};
+
+static int opt4048_state_configure_cfg0(struct opt4048_sensor *sensor);
+
+static const int opt4048_conversion_time_available[] = {
+	0, 600,
+	0, 1000,
+	0, 1800,
+	0, 3400,
+	0, 6500,
+	0, 12700,
+	0, 25000,
+	0, 50000,
+	0, 100000,
+	0, 200000,
+	0, 400000,
+	0, 800000,
+};
+
+static int opt4048_conversion_time_index(int value, int value_micro)
+{
+	unsigned int count = ARRAY_SIZE(opt4048_conversion_time_available) / 2;
+	unsigned int index;
+	unsigned int i;
+
+	for (i = 0; i < count; i++) {
+		index = i * 2;
+
+		if (opt4048_conversion_time_available[index] != value)
+			continue;
+
+		index++;
+
+		if (opt4048_conversion_time_available[index] != value_micro)
+			continue;
+
+		return (int)i;
+	}
+
+	return -1;
+}
+
+static u32 opt4048_threshold_value(u16 result, u16 exponent)
+{
+	return result << (exponent + 8);
+}
+
+static void opt4048_threshold_convert(u32 value, u16 threshold[2])
+{
+	unsigned int result;
+	unsigned int exponent;
+
+	/*
+	 * Threshold values are stored with 12 bits for the mantissa (result)
+	 * and 4 bits for an exponent offset, added to 8.
+	 */
+
+	result = value >> 8;
+	exponent = ilog2(result);
+
+	if (exponent > 11) {
+		exponent -= 11;
+		result >>= exponent;
+	} else {
+		exponent = 0;
+	}
+
+	threshold[0] = (u16)result;
+	threshold[1] = (u16)exponent;
+}
+
+static u32 opt4048_data_value(u16 result_msb, u16 result_lsb, u16 exponent)
+{
+	return ((result_msb << 8) | result_lsb) << exponent;
+}
+
+static int opt4048_data_read(struct opt4048_sensor *sensor, u8 address,
+			     u32 *channel_value)
+{
+	struct i2c_client *i2c_client = sensor->i2c_client;
+	u16 value, result_msb, result_lsb, exponent;
+	unsigned int index = 0;
+	u8 values[4] = { 0 };
+	int ret;
+
+	/* Read all values in one transaction to ensure coherency. */
+	ret = i2c_smbus_read_i2c_block_data(i2c_client, address, 4, values);
+	if (ret < 0)
+		return ret;
+
+	value = values[index] << 8 | values[index + 1];
+	index += 2;
+
+	result_msb = OPT4048_CH_DATA0_MSB_VALUE(value);
+	exponent = OPT4048_CH_DATA0_EXPONENT_VALUE(value);
+
+	value = values[index] << 8 | values[index + 1];
+
+	result_lsb = (u16)OPT4048_CH_DATA1_LSB_VALUE(value);
+
+	*channel_value = opt4048_data_value(result_msb, result_lsb, exponent);
+
+	return 0;
+}
+
+static int opt4048_data_scan(struct opt4048_sensor *sensor,
+			     struct opt4048_sensor_scan *scan)
+{
+	struct i2c_client *i2c_client = sensor->i2c_client;
+	unsigned int index = 0;
+	u8 values[16] = { 0 };
+	unsigned int i;
+	int ret;
+
+	/* Read all values in one transaction to ensure coherency. */
+	ret = i2c_smbus_read_i2c_block_data(i2c_client, OPT4048_CH0_DATA0, 16,
+					    values);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < 4; i++) {
+		u16 value, result_msb, result_lsb, exponent;
+
+		value = values[index] << 8 | values[index + 1];
+		index += 2;
+
+		result_msb = (u16)OPT4048_CH_DATA0_MSB_VALUE(value);
+		exponent = (u16)OPT4048_CH_DATA0_EXPONENT_VALUE(value);
+
+		value = values[index] << 8 | values[index + 1];
+		index += 2;
+
+		result_lsb = (u16)OPT4048_CH_DATA1_LSB_VALUE(value);
+
+		scan->channels[i] =
+			opt4048_data_value(result_msb, result_lsb, exponent);
+	}
+
+	/* Report illuminance using Y intensity value. */
+	scan->channels[4] = scan->channels[1];
+
+	return 0;
+}
+
+static int opt4048_identify(struct opt4048_sensor *sensor)
+{
+	struct device *dev = sensor->dev;
+	int ret;
+	u16 id, low, high;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_read_word_swapped(sensor->i2c_client, OPT4048_DID);
+	if (ret < 0)
+		goto complete;
+
+	low = (u16)OPT4048_DID_L_VALUE(ret);
+	high = (u16)OPT4048_DID_H_VALUE(ret);
+
+	id = OPT4048_DID_VALUE(low, high);
+
+	switch (id) {
+	case OPT4048_DID_OPT4048:
+		dev_info(dev, "identified OPT4048 sensor\n");
+		ret = 0;
+		break;
+	default:
+		dev_err(dev, "unknown sensor with id: %#x\n", id);
+		ret = -ENODEV;
+		break;
+	}
+
+complete:
+	pm_runtime_put_sync(dev);
+
+	return ret;
+}
+
+static int opt4048_power(struct opt4048_sensor *sensor, bool on)
+{
+	struct opt4048_sensor_state *state = &sensor->state;
+	int ret;
+
+	mutex_lock(&sensor->lock);
+
+	state->active = on;
+	ret = opt4048_state_configure_cfg0(sensor);
+
+	mutex_unlock(&sensor->lock);
+
+	return ret;
+}
+
+/* State */
+
+static int opt4048_state_configure_cfg0(struct opt4048_sensor *sensor)
+{
+	struct opt4048_sensor_state *state = &sensor->state;
+	u16 value;
+	int ret;
+
+	/*
+	 * Use the auto-ranging feature instead of manual gain exponent,
+	 * use latched window mode for threshold.
+	 */
+	value = OPT4048_CFG0_FAULT_COUNT_1 |
+		OPT4048_CFG0_INT_POL_ACTIVE_LOW |
+		OPT4048_CFG0_LATCH |
+		OPT4048_CFG0_CONVERSION_TIME(state->conversion_time_index) |
+		OPT4048_CFG0_RANGE_AUTO;
+
+	if (state->active)
+		value |= OPT4048_CFG0_OP_MODE_CONTINUOUS;
+	else
+		value |= OPT4048_CFG0_OP_MODE_POWER_DOWN;
+
+	ret = i2c_smbus_write_word_swapped(sensor->i2c_client, OPT4048_CFG0,
+					   value);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int opt4048_state_configure_cfg1(struct opt4048_sensor *sensor)
+{
+	u16 value;
+	int ret;
+
+	/* Assign threshold to the Y channel for illuminance. */
+	value = OPT4048_CFG1_I2C_BURST |
+		OPT4048_CFG1_INT_DIR_OUT |
+		OPT4048_CFG1_THRESHOLD_CH_SEL(1) |
+		OPT4048_CFG1_RESERVED;
+
+	if (sensor->scan_sync)
+		value |= OPT4048_CFG1_INT_CFG_DATA_READY_ALL;
+	else
+		value |= OPT4048_CFG1_INT_CFG_ALERT;
+
+	ret = i2c_smbus_write_word_swapped(sensor->i2c_client, OPT4048_CFG1,
+					   value);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int opt4048_state_configure_threshold(struct opt4048_sensor *sensor)
+{
+	struct opt4048_sensor_state *state = &sensor->state;
+	u16 threshold[2];
+	u16 value;
+	int ret;
+
+	if (state->threshold_low_active) {
+		threshold[0] = state->threshold_low[0];
+		threshold[1] = state->threshold_low[1];
+	} else {
+		threshold[0] = 0;
+		threshold[1] = 0;
+	}
+
+	value = OPT4048_THRESHOLD_RESULT(threshold[0]) |
+		OPT4048_THRESHOLD_EXPONENT(threshold[1]);
+
+	ret = i2c_smbus_write_word_swapped(sensor->i2c_client,
+					   OPT4048_THRESHOLD_L, value);
+	if (ret < 0)
+		return ret;
+
+	if (state->threshold_high_active) {
+		threshold[0] = state->threshold_high[0];
+		threshold[1] = state->threshold_high[1];
+	} else {
+		threshold[0] = OPT4048_THRESHOLD_RESULT_MAX;
+		threshold[1] = OPT4048_THRESHOLD_EXPONENT_MAX;
+	}
+
+	value = OPT4048_THRESHOLD_RESULT(threshold[0]) |
+		OPT4048_THRESHOLD_EXPONENT(threshold[1]);
+
+	ret = i2c_smbus_write_word_swapped(sensor->i2c_client,
+					   OPT4048_THRESHOLD_H, value);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int opt4048_state_configure(struct opt4048_sensor *sensor)
+{
+	int ret;
+
+	mutex_lock(&sensor->lock);
+
+	ret = opt4048_state_configure_cfg0(sensor);
+	if (ret)
+		goto complete;
+
+	ret = opt4048_state_configure_cfg1(sensor);
+	if (ret)
+		goto complete;
+
+	ret = opt4048_state_configure_threshold(sensor);
+	if (ret)
+		goto complete;
+
+complete:
+	mutex_unlock(&sensor->lock);
+
+	return ret;
+}
+
+static void opt4048_state_reset(struct opt4048_sensor *sensor)
+{
+	struct opt4048_sensor_state *state = &sensor->state;
+
+	state->active = false;
+
+	/* Start with a 25 ms integration time. */
+	state->conversion_time_index = 6;
+
+	state->threshold_low_active = false;
+	state->threshold_high_active = false;
+}
+
+/* IIO */
+
+static const struct iio_event_spec opt4048_iio_events[] = {
+	{
+		.type		= IIO_EV_TYPE_THRESH,
+		.dir		= IIO_EV_DIR_RISING,
+		.mask_separate	=
+			BIT(IIO_EV_INFO_ENABLE) |
+			BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type		= IIO_EV_TYPE_THRESH,
+		.dir		= IIO_EV_DIR_FALLING,
+		.mask_separate	=
+			BIT(IIO_EV_INFO_ENABLE) |
+			BIT(IIO_EV_INFO_VALUE),
+	},
+};
+
+static const struct iio_chan_spec opt4048_iio_channels[] = {
+	{
+		.type			= IIO_INTENSITY,
+		.channel2		= IIO_MOD_X,
+		.address		= OPT4048_CH0_DATA0,
+		.modified		= 1,
+
+		.scan_index		= 0,
+		.scan_type		= {
+			.sign		= 'u',
+			.realbits	= 28,
+			.storagebits	= 32,
+			.endianness	= IIO_LE,
+		},
+
+		.info_mask_separate =
+			BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_all =
+			BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_all_available =
+			BIT(IIO_CHAN_INFO_INT_TIME),
+	},
+	{
+		.type			= IIO_INTENSITY,
+		.channel2		= IIO_MOD_Y,
+		.address		= OPT4048_CH1_DATA0,
+		.modified		= 1,
+
+		.scan_index		= 1,
+		.scan_type		= {
+			.sign		= 'u',
+			.realbits	= 28,
+			.storagebits	= 32,
+			.endianness	= IIO_LE,
+		},
+
+		.info_mask_separate =
+			BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_all =
+			BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_all_available =
+			BIT(IIO_CHAN_INFO_INT_TIME),
+	},
+	{
+		.type			= IIO_INTENSITY,
+		.channel2		= IIO_MOD_Z,
+		.address		= OPT4048_CH2_DATA0,
+		.modified		= 1,
+
+		.scan_index		= 2,
+		.scan_type		= {
+			.sign		= 'u',
+			.realbits	= 28,
+			.storagebits	= 32,
+			.endianness	= IIO_LE,
+		},
+
+		.info_mask_separate =
+			BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_all =
+			BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_all_available =
+			BIT(IIO_CHAN_INFO_INT_TIME),
+	},
+	{
+		.type			= IIO_INTENSITY,
+		.channel2		= IIO_MOD_LIGHT_BOTH,
+		.address		= OPT4048_CH3_DATA0,
+		.modified		= 1,
+
+		.scan_index		= 3,
+		.scan_type		= {
+			.sign		= 'u',
+			.realbits	= 28,
+			.storagebits	= 32,
+			.endianness	= IIO_LE,
+		},
+
+		.info_mask_separate =
+			BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_all =
+			BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_all_available =
+			BIT(IIO_CHAN_INFO_INT_TIME),
+	},
+	{
+		.type			= IIO_LIGHT,
+		.address		= OPT4048_CH1_DATA0,
+
+		.scan_index		= 4,
+		.scan_type		= {
+			.sign		= 'u',
+			.realbits	= 28,
+			.storagebits	= 32,
+			.endianness	= IIO_LE,
+		},
+
+		.info_mask_separate =
+			BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all =
+			BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_all_available =
+			BIT(IIO_CHAN_INFO_INT_TIME),
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(5),
+};
+
+static int opt4048_iio_read_raw(struct iio_dev *iio_dev,
+				struct iio_chan_spec const *channel,
+				int *value_first, int *value_second, long mask)
+{
+	struct opt4048_sensor *sensor = iio_priv(iio_dev);
+	struct opt4048_sensor_state *state = &sensor->state;
+	struct device *dev = sensor->dev;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		unsigned int scan_index;
+
+		ret = iio_device_claim_direct_mode(iio_dev);
+		if (ret)
+			return ret;
+
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret < 0)
+			goto release_direct_mode;
+
+		if (sensor->scan_sync) {
+			scan_index = channel->scan_index;
+
+			mutex_lock(&sensor->lock);
+			*value_first = (int)sensor->scan.channels[scan_index];
+			mutex_unlock(&sensor->lock);
+		} else {
+			ret = opt4048_data_read(sensor, channel->address,
+						(u32 *)value_first);
+		}
+
+		pm_runtime_mark_last_busy(dev);
+		pm_runtime_put_autosuspend(dev);
+
+release_direct_mode:
+		iio_device_release_direct_mode(iio_dev);
+
+		if (ret < 0)
+			return ret;
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*value_first = 0;
+		*value_second = OPT4048_SCALE_ULUX;
+
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	case IIO_CHAN_INFO_INT_TIME:
+		unsigned int index = 2 * state->conversion_time_index;
+
+		*value_first = opt4048_conversion_time_available[index];
+		index++;
+		*value_second = opt4048_conversion_time_available[index];
+
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int opt4048_iio_read_avail(struct iio_dev *iio_dev,
+				  struct iio_chan_spec const *channel,
+				  const int **values, int *type, int *length,
+				  long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		*length = ARRAY_SIZE(opt4048_conversion_time_available);
+		*values = opt4048_conversion_time_available;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int opt4048_iio_write_raw(struct iio_dev *iio_dev,
+				 struct iio_chan_spec const *channel,
+				 int value_first, int value_second, long mask)
+{
+	struct opt4048_sensor *sensor = iio_priv(iio_dev);
+	struct opt4048_sensor_state *state = &sensor->state;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		ret = opt4048_conversion_time_index(value_first, value_second);
+		if (ret < 0)
+			return -EINVAL;
+
+		state->conversion_time_index = (u16)ret;
+
+		if (pm_runtime_suspended(sensor->dev))
+			return 0;
+
+		ret = opt4048_state_configure_cfg0(sensor);
+		if (ret)
+			return ret;
+
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int opt4048_iio_read_event_value(struct iio_dev *iio_dev,
+					struct iio_chan_spec const *channel,
+					enum iio_event_type type,
+					enum iio_event_direction direction,
+					enum iio_event_info info,
+					int *value_first, int *value_second)
+{
+	struct opt4048_sensor *sensor = iio_priv(iio_dev);
+	struct opt4048_sensor_state *state = &sensor->state;
+	u32 value;
+
+	switch (direction) {
+	case IIO_EV_DIR_RISING:
+		value = opt4048_threshold_value(state->threshold_high[0],
+						state->threshold_high[1]);
+		*value_first = (int)value;
+
+		return IIO_VAL_INT;
+
+	case IIO_EV_DIR_FALLING:
+		value = opt4048_threshold_value(state->threshold_low[0],
+						state->threshold_low[1]);
+		*value_first = (int)value;
+
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int opt4048_iio_write_event_value(struct iio_dev *iio_dev,
+					 struct iio_chan_spec const *channel,
+					 enum iio_event_type type,
+					 enum iio_event_direction direction,
+					 enum iio_event_info info,
+					 int value_first, int value_second)
+{
+	struct opt4048_sensor *sensor = iio_priv(iio_dev);
+	struct opt4048_sensor_state *state = &sensor->state;
+	u32 value;
+	int ret;
+
+	switch (direction) {
+	case IIO_EV_DIR_RISING:
+		value = (u32)value_first;
+		opt4048_threshold_convert(value, state->threshold_high);
+		break;
+
+	case IIO_EV_DIR_FALLING:
+		value = (u32)value_first;
+		opt4048_threshold_convert(value, state->threshold_low);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	if (pm_runtime_suspended(sensor->dev))
+		return 0;
+
+	ret = opt4048_state_configure_threshold(sensor);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int opt4048_iio_read_event_config(struct iio_dev *iio_dev,
+					 struct iio_chan_spec const *channel,
+					 enum iio_event_type type,
+					 enum iio_event_direction direction)
+{
+	struct opt4048_sensor *sensor = iio_priv(iio_dev);
+	struct opt4048_sensor_state *state = &sensor->state;
+
+	switch (direction) {
+	case IIO_EV_DIR_RISING:
+		return state->threshold_high_active;
+
+	case IIO_EV_DIR_FALLING:
+		return state->threshold_low_active;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int opt4048_iio_write_event_config(struct iio_dev *iio_dev,
+					  struct iio_chan_spec const *channel,
+					  enum iio_event_type type,
+					  enum iio_event_direction direction,
+					  int active)
+{
+	struct opt4048_sensor *sensor = iio_priv(iio_dev);
+	struct opt4048_sensor_state *state = &sensor->state;
+	int ret = 0;
+
+	/* Threshold active are read in IRQ thread. */
+	mutex_lock(&sensor->lock);
+
+	switch (direction) {
+	case IIO_EV_DIR_RISING:
+		state->threshold_high_active = !!active;
+		break;
+
+	case IIO_EV_DIR_FALLING:
+		state->threshold_low_active = !!active;
+		break;
+
+	default:
+		ret = -EINVAL;
+		goto complete;
+	}
+
+	if (pm_runtime_suspended(sensor->dev))
+		goto complete;
+
+	ret = opt4048_state_configure_threshold(sensor);
+
+complete:
+	mutex_unlock(&sensor->lock);
+
+	return ret;
+}
+
+static const struct iio_info opt4048_iio_info = {
+	.read_raw		= opt4048_iio_read_raw,
+	.read_avail		= opt4048_iio_read_avail,
+	.write_raw		= opt4048_iio_write_raw,
+	.read_event_value	= opt4048_iio_read_event_value,
+	.write_event_value	= opt4048_iio_write_event_value,
+	.read_event_config	= opt4048_iio_read_event_config,
+	.write_event_config	= opt4048_iio_write_event_config,
+};
+
+static irqreturn_t opt4048_iio_buffer_trigger(int irq, void *data)
+{
+	struct iio_poll_func *poll_func = data;
+	struct iio_dev *iio_dev = poll_func->indio_dev;
+	struct opt4048_sensor *sensor = iio_priv(iio_dev);
+	struct opt4048_sensor_scan scan = { 0 };
+	s64 timestamp;
+	unsigned int index = 0;
+	unsigned int i;
+	int ret;
+
+	/* Capture timestamp just before reading values. */
+	timestamp = iio_get_time_ns(iio_dev);
+
+	mutex_lock(&sensor->lock);
+
+	if (!sensor->scan_sync) {
+		ret = opt4048_data_scan(sensor, &sensor->scan);
+		if (ret)
+			goto complete;
+	}
+
+	for_each_set_bit(i, iio_dev->active_scan_mask, iio_dev->masklength) {
+		/* Assume scan index matches array index. */
+		const struct iio_chan_spec *channel = &opt4048_iio_channels[i];
+		unsigned int scan_index = channel->scan_index;
+
+		/* Only active channels are reported, in order. */
+		scan.channels[index] = sensor->scan.channels[scan_index];
+		index++;
+	}
+
+	iio_push_to_buffers_with_timestamp(iio_dev, &scan, timestamp);
+
+complete:
+	mutex_unlock(&sensor->lock);
+
+	iio_trigger_notify_done(iio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int opt4048_iio_buffer_preenable(struct iio_dev *iio_dev)
+{
+	struct opt4048_sensor *sensor = iio_priv(iio_dev);
+	struct device *dev = sensor->dev;
+
+	return pm_runtime_resume_and_get(dev);
+}
+
+static int opt4048_iio_buffer_postdisable(struct iio_dev *iio_dev)
+{
+	struct opt4048_sensor *sensor = iio_priv(iio_dev);
+	struct device *dev = sensor->dev;
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+}
+static const struct iio_buffer_setup_ops opt4048_iio_buffer_setup_ops = {
+	.preenable = opt4048_iio_buffer_preenable,
+	.postdisable = opt4048_iio_buffer_postdisable,
+};
+
+static int opt4048_iio_setup(struct opt4048_sensor *sensor)
+{
+	struct iio_chan_spec *channels;
+	struct iio_dev *iio_dev = sensor->iio_dev;
+	struct device *dev = sensor->dev;
+	unsigned int channels_count;
+	int ret;
+
+	channels_count = ARRAY_SIZE(opt4048_iio_channels);
+
+	if (sensor->i2c_client->irq > 0) {
+		channels = devm_kzalloc(dev, sizeof(opt4048_iio_channels),
+					GFP_KERNEL);
+
+		memcpy(channels, opt4048_iio_channels,
+		       sizeof(opt4048_iio_channels));
+
+		/* Attach threshold events to the illuminance channel. */
+		channels[3].event_spec = opt4048_iio_events;
+		channels[3].num_event_specs = ARRAY_SIZE(opt4048_iio_events);
+	} else {
+		/* Threshold events are not available without an irq. */
+		channels = (struct iio_chan_spec *)opt4048_iio_channels;
+	}
+
+	iio_dev->info = &opt4048_iio_info;
+	iio_dev->name = "opt4048";
+	iio_dev->channels = channels;
+	iio_dev->num_channels = channels_count;
+	iio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = devm_iio_triggered_buffer_setup(dev, iio_dev, NULL,
+					      opt4048_iio_buffer_trigger,
+					      &opt4048_iio_buffer_setup_ops);
+	if (ret) {
+		dev_err(dev, "failed to setup iio triggered buffer\n");
+		return ret;
+	}
+
+	ret = iio_device_register(iio_dev);
+	if (ret) {
+		dev_err(dev, "failed to register iio device\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void opt4048_iio_cleanup(struct opt4048_sensor *sensor)
+{
+	iio_device_unregister(sensor->iio_dev);
+}
+
+/* IRQ */
+
+static irqreturn_t opt4048_irq(int irq, void *data)
+{
+	struct opt4048_sensor *sensor = data;
+	struct opt4048_sensor_state *state = &sensor->state;
+	struct iio_dev *iio_dev = sensor->iio_dev;
+	bool threshold_rising;
+	bool threshold_falling;
+	s64 timestamp;
+	u64 code;
+	u16 status;
+	int ret;
+
+	timestamp = iio_get_time_ns(iio_dev);
+
+	ret = i2c_smbus_read_word_swapped(sensor->i2c_client, OPT4048_STATUS);
+	if (ret < 0)
+		return IRQ_HANDLED;
+
+	status = (u16)ret;
+
+	mutex_lock(&sensor->lock);
+
+	if (!state->active)
+		goto complete;
+
+	if (status & OPT4048_STATUS_CONV_READY_FLAG)
+		opt4048_data_scan(sensor, &sensor->scan);
+
+	threshold_falling = (status & OPT4048_STATUS_FLAG_L) &&
+			    !(state->status & OPT4048_STATUS_FLAG_L);
+
+	if (state->threshold_low_active && threshold_falling) {
+		code = IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 3, IIO_EV_TYPE_THRESH,
+					    IIO_EV_DIR_FALLING);
+		iio_push_event(iio_dev, code, timestamp);
+	}
+
+	threshold_rising = (status & OPT4048_STATUS_FLAG_H) &&
+			   !(state->status & OPT4048_STATUS_FLAG_H);
+
+	if (state->threshold_high_active && threshold_rising) {
+		code = IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 3, IIO_EV_TYPE_THRESH,
+					    IIO_EV_DIR_RISING);
+		iio_push_event(iio_dev, code, timestamp);
+	}
+
+	state->status = status;
+
+complete:
+	mutex_unlock(&sensor->lock);
+
+	return IRQ_HANDLED;
+}
+
+/* PM */
+
+static int opt4048_suspend(struct device *dev)
+{
+	struct opt4048_sensor *sensor = dev_get_drvdata(dev);
+	int ret;
+
+	ret = opt4048_power(sensor, 0);
+	if (ret)
+		goto error;
+
+	ret = regulator_disable(sensor->vdd_supply);
+	if (ret)
+		goto error;
+
+	return 0;
+
+error:
+	return -EAGAIN;
+}
+
+static int opt4048_resume(struct device *dev)
+{
+	struct opt4048_sensor *sensor = dev_get_drvdata(dev);
+	unsigned long sleep_min;
+	unsigned int index;
+	int ret;
+
+	ret = regulator_enable(sensor->vdd_supply);
+	if (ret)
+		goto error;
+
+	/* Wait for the regulator to settle and the chip to power-on. */
+	udelay(30);
+
+	ret = opt4048_state_configure(sensor);
+	if (ret)
+		goto error_regulator;
+
+	ret = opt4048_power(sensor, 1);
+	if (ret)
+		goto error_regulator;
+
+	/* Wait for conversion to be ready for all channels. */
+	index = 2 * sensor->state.conversion_time_index + 1;
+	sleep_min = opt4048_conversion_time_available[index] * 4;
+
+	usleep_range(sleep_min, 5 * sleep_min / 4);
+
+	return 0;
+
+error_regulator:
+	regulator_disable(sensor->vdd_supply);
+
+error:
+	return -EAGAIN;
+}
+
+static const struct dev_pm_ops opt4048_pm_ops = {
+	.runtime_suspend	= opt4048_suspend,
+	.runtime_resume		= opt4048_resume,
+};
+
+/* I2C */
+
+static int opt4048_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct opt4048_sensor *sensor;
+	struct iio_dev *iio_dev;
+	int irq = client->irq;
+	int ret;
+
+	iio_dev = devm_iio_device_alloc(dev, sizeof(*sensor));
+	if (!iio_dev)
+		return -ENOMEM;
+
+	sensor = iio_priv(iio_dev);
+
+	sensor->dev = dev;
+	sensor->i2c_client = client;
+	sensor->iio_dev = iio_dev;
+
+	i2c_set_clientdata(client, sensor);
+
+	mutex_init(&sensor->lock);
+
+	sensor->vdd_supply = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(sensor->vdd_supply)) {
+		dev_err(dev, "failed to get VDD regulator\n");
+		return PTR_ERR(sensor->vdd_supply);
+	}
+
+	opt4048_state_reset(sensor);
+
+	devm_pm_runtime_enable(dev);
+
+	ret = opt4048_identify(sensor);
+	if (ret)
+		return ret;
+
+	pm_runtime_set_autosuspend_delay(dev, 5000);
+	pm_runtime_use_autosuspend(dev);
+
+	if (irq > 0) {
+		ret = devm_request_threaded_irq(dev, irq, NULL, opt4048_irq,
+						IRQF_TRIGGER_FALLING |
+						IRQF_ONESHOT,
+						"opt4048", sensor);
+		if (ret) {
+			dev_err(dev, "failed to request irq\n");
+			return ret;
+		}
+
+		sensor->scan_sync = true;
+	}
+
+	ret = opt4048_iio_setup(sensor);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void opt4048_remove(struct i2c_client *client)
+{
+	struct opt4048_sensor *sensor = i2c_get_clientdata(client);
+
+	opt4048_iio_cleanup(sensor);
+}
+
+static const struct i2c_device_id opt4048_id[] = {
+	{ "opt4048" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, opt4048_id);
+
+static const struct of_device_id opt4048_of_match[] = {
+	{ .compatible = "ti,opt4048" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, opt4048_of_match);
+
+static struct i2c_driver opt4048_driver = {
+	.driver = {
+		.name		= "opt4048",
+		.of_match_table = opt4048_of_match,
+		.pm		= &opt4048_pm_ops,
+	},
+	.id_table	= opt4048_id,
+	.probe		= opt4048_probe,
+	.remove		= opt4048_remove,
+};
+
+module_i2c_driver(opt4048_driver);
+
+MODULE_AUTHOR("Paul Kocialkowski <paulk@sys-base.io>");
+MODULE_DESCRIPTION("Texas Instruments OPT4048 XYZ tristimulus color sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.47.0


