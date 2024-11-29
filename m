Return-Path: <linux-iio+bounces-12496-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F37059D6138
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 16:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77A491F210FE
	for <lists+linux-iio@lfdr.de>; Fri, 22 Nov 2024 15:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819D91DED5A;
	Fri, 22 Nov 2024 15:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APakh3ml"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBE11ABEB0;
	Fri, 22 Nov 2024 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732288554; cv=none; b=T38D7c9FKbh9Th2GHKT4C4VvKemjNQ48jWTKIRPIxoXYPm30/+v6K8yPDlpeirWIsZ5HvLXtTr6x4O32RNSctlXCNfc1JMmFB2XjuyF8LWGXceYL0q60G425bsC9E9Q9xNIu7uY8mTSz3VYzzigtq5WBgFO4Pxp+8PpCUSkLnK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732288554; c=relaxed/simple;
	bh=09lps0KWoBJamNVAOVmul1sMDyBDupuXQyoVEr2tEcM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=odBJenryXLj+Q/x64DfiFBP0ORzmQye4YQ4YcHImjZCKQuVyGfRV+DPh/KHEgTmsIdzrOUgRX1AiHqS9QO4Ud82cvPKhxn2t3xzcwrjvcAuHBD/CP4Ov7JqlIHKcczqdnDXQRcC8Rfh21vwSky99mG9Ol5iPQa6FXyjLb4gGf8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APakh3ml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C89DBC4CEDA;
	Fri, 22 Nov 2024 15:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732288553;
	bh=09lps0KWoBJamNVAOVmul1sMDyBDupuXQyoVEr2tEcM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=APakh3mlGV/JuvGm3v0W6P8+cPlr5X6sYCPCr8GKyGFQvb3WHKRKyJkd1mNT5o66L
	 W1UapjtKNwtHehIAexMN21cwebSoZhZ19nwFLOZ5fheF8O171AnzcKHQcWontV82ii
	 yxawWp9r5RmlTVLh7BGl5M6xgHDoajzt3BkvzulZwS+F4/UDSkwabvtS60fHlScogD
	 dfbcMZoDWHxcBAOUwxFNmXikgaNClt9LvIcNoMOTHGavfAeKEWQb4ZlgAxBf/Rt18g
	 y1VfOkvMG6mM5q4YuwXXM7wziA3yLiQXaZGxUtoKBX5T1B/zZxp/lIuB/OF9jDBCeI
	 jC6lrXc9CfmAg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B41E6916E;
	Fri, 22 Nov 2024 15:15:53 +0000 (UTC)
From: Tobias Sperling via B4 Relay <devnull+tobias.sperling.softing.com@kernel.org>
Date: Fri, 22 Nov 2024 16:15:37 +0100
Subject: [PATCH 2/2] iio: adc: Add driver for ADS7128 / ADS7138
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241122-adc_ml-v1-2-0769f2e1bbc1@softing.com>
References: <20241122-adc_ml-v1-0-0769f2e1bbc1@softing.com>
In-Reply-To: <20241122-adc_ml-v1-0-0769f2e1bbc1@softing.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Tobias Sperling <tobias.sperling@softing.com>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732288552; l=23844;
 i=tobias.sperling@softing.com; s=20241122; h=from:subject:message-id;
 bh=Gy11BqwG7z9gVP4ZJpy1wMUaaIF0QJ8j/2BOt2JcTmU=;
 b=Y9hscb/WJUH3MOT6CPldXW4u1Ufwr78sPylPPPGgoeGsGMt2telAEp6UgDsxwtEOx6zdVM41y
 vhg1i9H58IzA+Da/9aJQvifV/2l3fdepVetnRyrgUZ/SkQqXjgTJXqq
X-Developer-Key: i=tobias.sperling@softing.com; a=ed25519;
 pk=v7hgaMHsrA9ul4UXkBVUuwusS9PF3uHW/CC+gABI65E=
X-Endpoint-Received: by B4 Relay for tobias.sperling@softing.com/20241122
 with auth_id=281
X-Original-From: Tobias Sperling <tobias.sperling@softing.com>
Reply-To: tobias.sperling@softing.com

From: Tobias Sperling <tobias.sperling@softing.com>

Add driver for ADS7128 and ADS7138 12-bit, 8-channel analog-to-digital
converters. These ADCs have a wide operating range and a wide feature
set. Communication is based on the I2C interface.

Signed-off-by: Tobias Sperling <tobias.sperling@softing.com>
---
 drivers/iio/adc/Kconfig      |  10 +
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/ti-ads7138.c | 796 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 807 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 6c4e74420fd25b9c9624b4a393bd436444d335d5..fe956b0cbb72fc998c1dbf1b35a04a0e5ae198e4 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1427,6 +1427,16 @@ config TI_ADS1119
          This driver can also be built as a module. If so, the module will be
          called ti-ads1119.
 
+config TI_ADS7138
+	tristate "Texas Instruments ADS7128 and ADS7138 ADC driver"
+	depends on I2C
+	help
+	  If you say yes here you get support for Texas Instruments ADS7128 and
+	  ADS7138 8-channel A/D converters with 12-bit resolution.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called ti-ads7138.
+
 config TI_ADS7924
 	tristate "Texas Instruments ADS7924 ADC"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 7b91cd98c0e0bda1b9a89ef369756dea51706227..38aebe49a1a89fd732a27844d8674af434dbc78d 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -130,6 +130,7 @@ obj-$(CONFIG_TI_ADS1119) += ti-ads1119.o
 obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
 obj-$(CONFIG_TI_ADS1298) += ti-ads1298.o
 obj-$(CONFIG_TI_ADS131E08) += ti-ads131e08.o
+obj-$(CONFIG_TI_ADS7138) += ti-ads7138.o
 obj-$(CONFIG_TI_ADS7924) += ti-ads7924.o
 obj-$(CONFIG_TI_ADS7950) += ti-ads7950.o
 obj-$(CONFIG_TI_ADS8344) += ti-ads8344.o
diff --git a/drivers/iio/adc/ti-ads7138.c b/drivers/iio/adc/ti-ads7138.c
new file mode 100644
index 0000000000000000000000000000000000000000..3ac76625bc6334965c78ba7938895236ee4edece
--- /dev/null
+++ b/drivers/iio/adc/ti-ads7138.c
@@ -0,0 +1,796 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ADS7138 - Texas Instruments Analog-to-Digital Converter
+ */
+
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/types.h>
+
+#define MODULE_NAME "ads71x8"
+
+/* AVDD (VREF) operating range in millivolts */
+#define ADS71x8_AVDD_MV_MIN		2350
+#define ADS71x8_AVDD_MV_MAX		5500
+
+/*
+ * Always assume 16 bits resolution as HW registers are aligned like that and
+ * with enabled oversampling/averaging it actually corresponds to 16 bits.
+ */
+#define ADS71x8_RES_BITS		16
+
+/* ADS71x8 operation codes */
+#define ADS71x8_OPCODE_SET_BIT		0x18
+#define ADS71x8_OPCODE_CLEAR_BIT	0x20
+#define ADS71x8_OPCODE_BLOCK_WRITE	0x28
+#define ADS71x8_OPCODE_BLOCK_READ	0x30
+
+/* ADS71x8 registers */
+#define ADS71x8_REG_GENERAL_CFG		0x01
+#define ADS71x8_REG_OSR_CFG		0x03
+#define ADS71x8_REG_OPMODE_CFG		0x04
+#define ADS71x8_REG_SEQUENCE_CFG	0x10
+#define ADS71x8_REG_AUTO_SEQ_CH_SEL	0x12
+#define ADS71x8_REG_ALERT_CH_SEL	0x14
+#define ADS71x8_REG_EVENT_FLAG		0x18
+#define ADS71x8_REG_EVENT_HIGH_FLAG	0x1A
+#define ADS71x8_REG_EVENT_LOW_FLAG	0x1C
+#define ADS71x8_REG_HIGH_TH_HYS_CH(x)	((x) * 4 + 0x20)
+#define ADS71x8_REG_LOW_TH_CNT_CH(x)	((x) * 4 + 0x22)
+#define ADS71x8_REG_MAX_LSB_CH(x)	((x) * 2 + 0x60)
+#define ADS71x8_REG_MIN_LSB_CH(x)	((x) * 2 + 0x80)
+#define ADS71x8_REG_RECENT_LSB_CH(x)	((x) * 2 + 0xA0)
+
+#define ADS71x8_GENERAL_CFG_RST		BIT(0)
+#define ADS71x8_GENERAL_CFG_DWC_EN	BIT(4)
+#define ADS71x8_GENERAL_CFG_STATS_EN	BIT(5)
+#define ADS71x8_OSR_CFG_MASK		GENMASK(2, 0)
+#define ADS71x8_OPMODE_CFG_CONV_MODE	BIT(5)
+#define ADS71x8_OPMODE_CFG_FREQ_MASK	GENMASK(4, 0)
+#define ADS71x8_SEQUENCE_CFG_SEQ_MODE	BIT(0)
+#define ADS71x8_SEQUENCE_CFG_SEQ_START	BIT(4)
+#define ADS71x8_THRESHOLD_LSB_MASK	GENMASK(7, 4)
+
+enum ads71x8_modes {
+	ADS71x8_MODE_MANUAL,
+	ADS71x8_MODE_AUTO,
+};
+
+enum ads71x8_stats {
+	ADS71x8_STATS_MIN,
+	ADS71x8_STATS_MAX,
+};
+
+enum ads71x8_chips { ads7128, ads7138 };
+
+struct ads71x8_data {
+	struct mutex lock;
+	struct i2c_client *client;
+	struct regulator *vref_regu;
+};
+
+struct ads71x8_freq_bits {
+	u32 hz;
+	u8 bits;
+};
+
+static const struct ads71x8_freq_bits ads71x8_samp_freq[] = {
+	{163, 0x1F}, {244, 0x1E}, {326, 0x1D}, {488, 0x1C}, {651, 0x1B},
+	{977, 0x1A}, {1302, 0x19}, {1953, 0x18}, {2604, 0x17}, {3906, 0x16},
+	{5208, 0x15}, {7813, 0x14}, {10417, 0x13}, {15625, 0x12}, {20833, 0x11},
+	{31250, 0x10}, {41667, 0x09}, {62500, 0x08}, {83333, 0x07},
+	{125000, 0x06}, {166667, 0x05}, {250000, 0x04}, {333333, 0x03},
+	{500000, 0x02}, {666667, 0x01}, {1000000, 0x0}
+};
+
+static int ads71x8_i2c_write_block(const struct i2c_client *client, u8 reg,
+	u8 *values, u8 length)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct ads71x8_data *data = iio_priv(indio_dev);
+	int ret;
+	struct i2c_msg msgs[] = {
+		{
+			.addr = client->addr,
+			.flags = 0,
+			.len = length + 2, /* "+ 2" for OPCODE and reg */
+		},
+	};
+
+	msgs[0].buf = kmalloc(msgs[0].len, GFP_KERNEL);
+	if (!msgs[0].buf)
+		return -ENOMEM;
+
+	msgs[0].buf[0] = ADS71x8_OPCODE_BLOCK_WRITE;
+	msgs[0].buf[1] = reg;
+	memcpy(&msgs[0].buf[2], values, length);
+
+	mutex_lock(&data->lock);
+	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+	mutex_unlock(&data->lock);
+	kfree(msgs[0].buf);
+
+	return ret;
+}
+
+static int ads71x8_i2c_write(const struct i2c_client *client, u8 reg, u8 value)
+{
+	return ads71x8_i2c_write_block(client, reg, &value, sizeof(value));
+}
+
+static int ads71x8_i2c_setclear_bit(const struct i2c_client *client, u8 reg,
+	u8 bits, u8 opcode)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct ads71x8_data *data = iio_priv(indio_dev);
+	int ret;
+	u8 buf[3] = {opcode, reg, bits};
+	struct i2c_msg msgs[] = {
+		{
+			.addr = client->addr,
+			.flags = 0,
+			.len = ARRAY_SIZE(buf),
+			.buf = buf,
+		},
+	};
+
+	mutex_lock(&data->lock);
+	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static int ads71x8_i2c_set_bit(const struct i2c_client *client, u8 reg, u8 bits)
+{
+	return ads71x8_i2c_setclear_bit(client, reg, bits,
+		ADS71x8_OPCODE_SET_BIT);
+}
+
+static int ads71x8_i2c_clear_bit(const struct i2c_client *client, u8 reg, u8 bits)
+{
+	return ads71x8_i2c_setclear_bit(client, reg, bits,
+		ADS71x8_OPCODE_CLEAR_BIT);
+}
+
+static int ads71x8_i2c_read_block(const struct i2c_client *client, u8 reg,
+	u8 *out_values, u8 length)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct ads71x8_data *data = iio_priv(indio_dev);
+	int ret;
+	u8 buf[2] = {ADS71x8_OPCODE_BLOCK_READ, reg};
+	struct i2c_msg msgs[] = {
+		{
+			.addr = client->addr,
+			.flags = 0,
+			.len = ARRAY_SIZE(buf),
+			.buf = buf,
+		},
+		{
+			.addr = client->addr,
+			.flags = I2C_M_RD,
+			.len = length,
+			.buf = out_values,
+		},
+	};
+
+	mutex_lock(&data->lock);
+	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static int ads71x8_i2c_read(const struct i2c_client *client, u8 reg)
+{
+	u8 value;
+	int ret;
+
+	ret = ads71x8_i2c_read_block(client, reg, &value, sizeof(value));
+	if (ret < 0)
+		return ret;
+	return value;
+}
+
+static const struct ads71x8_freq_bits *get_closest_freq(int freq)
+{
+	const int idx_max = ARRAY_SIZE(ads71x8_samp_freq) - 1;
+	u32 cur, best = ads71x8_samp_freq[idx_max].hz;
+	int i;
+
+	freq = clamp_val(freq, ads71x8_samp_freq[0].hz,
+		ads71x8_samp_freq[idx_max].hz);
+
+	for (i = 0; i <= idx_max; i++) {
+		cur = abs(ads71x8_samp_freq[i].hz - freq);
+		if (cur > best)
+			return &ads71x8_samp_freq[i-1];
+		best = cur;
+	}
+	return &ads71x8_samp_freq[idx_max];
+}
+
+static u32 get_closest_log2(u32 val)
+{
+	u32 down = ilog2(val);
+	u32 up = ilog2(roundup_pow_of_two(val));
+
+	return (val - (1 << down) < (1 << up) - val) ? down : up;
+}
+
+static int ads71x8_read_raw(struct iio_dev *indio_dev,
+	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
+{
+	struct ads71x8_data *data = iio_priv(indio_dev);
+	int i, ret, vref;
+	u8 values[2];
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = ads71x8_i2c_read_block(data->client,
+			ADS71x8_REG_RECENT_LSB_CH(chan->channel), values,
+			ARRAY_SIZE(values));
+		if (ret < 0)
+			return ret;
+
+		*val = ((values[1] << 8) | values[0]);
+		ret = IIO_VAL_INT;
+		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = ads71x8_i2c_read(data->client, ADS71x8_REG_OPMODE_CFG);
+		if (ret < 0)
+			return ret;
+
+		for (i = 0; i < ARRAY_SIZE(ads71x8_samp_freq); i++) {
+			if (ads71x8_samp_freq[i].bits ==
+					(ret & ADS71x8_OPMODE_CFG_FREQ_MASK)) {
+				*val = ads71x8_samp_freq[i].hz;
+				return IIO_VAL_INT;
+			}
+		}
+
+		ret = -EINVAL;
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		if (data->vref_regu) {
+			vref = regulator_get_voltage(data->vref_regu);
+			if (vref < 0)
+				return vref;
+			*val = vref / 1000;
+		} else {
+			*val = ADS71x8_AVDD_MV_MIN;
+		}
+		*val2 = ADS71x8_RES_BITS;
+		ret = IIO_VAL_FRACTIONAL_LOG2;
+		break;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		ret = ads71x8_i2c_read(data->client, ADS71x8_REG_OSR_CFG);
+		if (ret < 0)
+			return ret;
+		*val = (1 << (ret & ADS71x8_OSR_CFG_MASK));
+		ret = IIO_VAL_INT;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int ads71x8_write_raw(struct iio_dev *indio_dev,
+	struct iio_chan_spec const *chan, int val, int val2, long mask)
+{
+	struct ads71x8_data *data = iio_priv(indio_dev);
+	const struct ads71x8_freq_bits *freq = NULL;
+	int ret;
+	u8 osr_val;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		freq = get_closest_freq(val);
+		ret = ads71x8_i2c_read(data->client, ADS71x8_REG_OPMODE_CFG);
+		if (ret < 0)
+			return ret;
+		ret = ads71x8_i2c_write(data->client, ADS71x8_REG_OPMODE_CFG,
+			(ret & ~ADS71x8_OPMODE_CFG_FREQ_MASK) |
+			(freq->bits & ADS71x8_OPMODE_CFG_FREQ_MASK));
+		ret = (ret > 0) ? 0 : ret;
+		break;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		/* Number of samples can only be a power of 2 */
+		osr_val = get_closest_log2(clamp_val(val, 1, 128));
+		ret = ads71x8_i2c_write(data->client, ADS71x8_REG_OSR_CFG,
+			osr_val);
+		ret = (ret > 0) ? 0 : ret;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static ssize_t ads71x8_read_stats(struct iio_dev *indio_dev, uintptr_t priv,
+	const struct iio_chan_spec *chan, char *buf)
+{
+	struct ads71x8_data *data = iio_priv(indio_dev);
+	int ret;
+	u8 values[2];
+
+	switch (priv) {
+	case ADS71x8_STATS_MIN:
+		ret = ads71x8_i2c_read_block(data->client,
+			ADS71x8_REG_MIN_LSB_CH(chan->channel), values,
+			ARRAY_SIZE(values));
+		if (ret < 0)
+			return ret;
+		break;
+	case ADS71x8_STATS_MAX:
+		ret = ads71x8_i2c_read_block(data->client,
+			ADS71x8_REG_MAX_LSB_CH(chan->channel), values,
+			ARRAY_SIZE(values));
+		if (ret < 0)
+			return ret;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return sprintf(buf, "%d\n", ((values[1] << 8) | values[0]));
+}
+
+static int ads71x8_read_event(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir, enum iio_event_info info, int *val,
+	int *val2)
+{
+	int ret;
+	u8 reg, values[2];
+	struct ads71x8_data *data = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		reg = (dir == IIO_EV_DIR_RISING) ?
+			ADS71x8_REG_HIGH_TH_HYS_CH(chan->channel) :
+			ADS71x8_REG_LOW_TH_CNT_CH(chan->channel);
+		ret = ads71x8_i2c_read_block(data->client, reg, values,
+			ARRAY_SIZE(values));
+		if (ret < 0)
+			return ret;
+
+		*val = ((values[1] << 4) | (values[0] >> 4));
+		ret = IIO_VAL_INT;
+		break;
+	case IIO_EV_INFO_HYSTERESIS:
+		ret = ads71x8_i2c_read(data->client,
+			ADS71x8_REG_HIGH_TH_HYS_CH(chan->channel));
+		if (ret < 0)
+			return ret;
+
+		*val = (ret & ~ADS71x8_THRESHOLD_LSB_MASK);
+		ret = IIO_VAL_INT;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int ads71x8_write_event(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir, enum iio_event_info info, int val,
+	int val2)
+{
+	struct ads71x8_data *data = iio_priv(indio_dev);
+	int ret;
+	u8 reg, values[2];
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		if (val >= BIT(12) || val < 0) {
+			ret = -EINVAL;
+			break;
+		}
+		reg = (dir == IIO_EV_DIR_RISING) ?
+			ADS71x8_REG_HIGH_TH_HYS_CH(chan->channel) :
+			ADS71x8_REG_LOW_TH_CNT_CH(chan->channel);
+
+		ret = ads71x8_i2c_read(data->client, reg);
+		if (ret < 0)
+			return ret;
+
+		values[0] = (((val & 0x0F) << 4) |
+			(ret & ~ADS71x8_THRESHOLD_LSB_MASK));
+		values[1] = (val >> 4);
+		ret = ads71x8_i2c_write_block(data->client, reg, values,
+			ARRAY_SIZE(values));
+		ret = (ret > 0) ? 0 : ret;
+		break;
+	case IIO_EV_INFO_HYSTERESIS:
+		if (val >= BIT(4) || val < 0) {
+			ret = -EINVAL;
+			break;
+		}
+		reg = ADS71x8_REG_HIGH_TH_HYS_CH(chan->channel);
+		ret = ads71x8_i2c_read(data->client, reg);
+		if (ret < 0)
+			return ret;
+
+		ret = ads71x8_i2c_write(data->client, reg,
+			((ret & ADS71x8_THRESHOLD_LSB_MASK) |
+			(val & ~ADS71x8_THRESHOLD_LSB_MASK)));
+		ret = (ret > 0) ? 0 : ret;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int ads71x8_read_event_config(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir)
+{
+	struct ads71x8_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (dir) {
+	case IIO_EV_DIR_EITHER:
+		ret = ads71x8_i2c_read(data->client, ADS71x8_REG_ALERT_CH_SEL);
+		if (ret < 0)
+			return ret;
+
+		ret = (ret & BIT(chan->channel)) ? 1 : 0;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int ads71x8_write_event_config(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir, int state)
+{
+	struct ads71x8_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (dir) {
+	case IIO_EV_DIR_EITHER:
+		if (state)
+			ret = ads71x8_i2c_set_bit(data->client,
+				ADS71x8_REG_ALERT_CH_SEL, BIT(chan->channel));
+		else
+			ret = ads71x8_i2c_clear_bit(data->client,
+				ADS71x8_REG_ALERT_CH_SEL, BIT(chan->channel));
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static ssize_t ads71x8_show_samp_freq_avail(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	int i;
+	ssize_t len = 0;
+
+	for (i = 0; i < ARRAY_SIZE(ads71x8_samp_freq); i++)
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
+			ads71x8_samp_freq[i].hz);
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
+static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(ads71x8_show_samp_freq_avail);
+
+static struct attribute *ads71x8_attributes[] = {
+	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ads71x8_attribute_group = {
+	.attrs = ads71x8_attributes,
+};
+
+static const struct iio_info ti_ads71x8_info = {
+	.attrs = &ads71x8_attribute_group,
+	.read_raw = &ads71x8_read_raw,
+	.write_raw = &ads71x8_write_raw,
+	.read_event_value = &ads71x8_read_event,
+	.write_event_value = &ads71x8_write_event,
+	.read_event_config = &ads71x8_read_event_config,
+	.write_event_config = &ads71x8_write_event_config,
+};
+
+static const struct iio_event_spec ads71x8_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE)
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_HYSTERESIS) |
+			BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static const struct iio_chan_spec_ext_info ads71x8_ext_info[] = {
+	{"stats_min", IIO_SEPARATE, ads71x8_read_stats, NULL, ADS71x8_STATS_MIN},
+	{"stats_max", IIO_SEPARATE, ads71x8_read_stats, NULL, ADS71x8_STATS_MAX},
+	{},
+};
+
+#define ADS71x8_V_CHAN(_chan) {						\
+	.type = IIO_VOLTAGE,						\
+	.indexed = 1,							\
+	.channel = _chan,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
+		BIT(IIO_CHAN_INFO_SCALE) |				\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
+	.datasheet_name = "AIN"#_chan,					\
+	.event_spec = ads71x8_events,					\
+	.num_event_specs = ARRAY_SIZE(ads71x8_events),			\
+	.ext_info = ads71x8_ext_info,					\
+}
+
+static const struct iio_chan_spec ads71x8_channels[] = {
+	ADS71x8_V_CHAN(0),
+	ADS71x8_V_CHAN(1),
+	ADS71x8_V_CHAN(2),
+	ADS71x8_V_CHAN(3),
+	ADS71x8_V_CHAN(4),
+	ADS71x8_V_CHAN(5),
+	ADS71x8_V_CHAN(6),
+	ADS71x8_V_CHAN(7),
+};
+
+static irqreturn_t ads71x8_event_handler(int irq, void *priv)
+{
+	struct iio_dev *indio_dev = priv;
+	struct ads71x8_data *data = iio_priv(indio_dev);
+	int ret;
+	u8 i, events_high, events_low;
+	u64 code;
+
+	/* Check if interrupt was trigger by us */
+	ret = ads71x8_i2c_read(data->client, ADS71x8_REG_EVENT_FLAG);
+	if (ret <= 0)
+		return IRQ_NONE;
+
+	ret = ads71x8_i2c_read(data->client, ADS71x8_REG_EVENT_HIGH_FLAG);
+	events_high = ret;
+	if (ret < 0)
+		goto out;
+
+	ret = ads71x8_i2c_read(data->client, ADS71x8_REG_EVENT_LOW_FLAG);
+	events_low = ret;
+	if (ret < 0)
+		goto out;
+
+	for (i = 0; i < 8; i++) {
+		if (events_high & BIT(i)) {
+			code = IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
+				IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING);
+			iio_push_event(indio_dev, code,
+				iio_get_time_ns(indio_dev));
+		}
+		if (events_low & BIT(i)) {
+			code = IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
+				IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING);
+			iio_push_event(indio_dev, code,
+				iio_get_time_ns(indio_dev));
+		}
+	}
+
+	/* Clear all interrupt flags */
+	ads71x8_i2c_write(data->client, ADS71x8_REG_EVENT_HIGH_FLAG, 0xFF);
+	ads71x8_i2c_write(data->client, ADS71x8_REG_EVENT_LOW_FLAG, 0xFF);
+
+out:
+	if (ret < 0)
+		dev_warn(&data->client->dev,
+			"Couldn't handle interrupt correctly: %d\n", ret);
+	return IRQ_HANDLED;
+}
+
+static int ads71x8_set_conv_mode(struct ads71x8_data *data,
+	enum ads71x8_modes mode)
+{
+	if (mode == ADS71x8_MODE_AUTO)
+		return ads71x8_i2c_set_bit(data->client, ADS71x8_REG_OPMODE_CFG,
+			ADS71x8_OPMODE_CFG_CONV_MODE);
+	return ads71x8_i2c_clear_bit(data->client, ADS71x8_REG_OPMODE_CFG,
+		ADS71x8_OPMODE_CFG_CONV_MODE);
+}
+
+static int ads7138_init_hw(struct ads71x8_data *data)
+{
+	int ret = 0;
+
+	data->vref_regu = devm_regulator_get(&data->client->dev, "avdd");
+	if (IS_ERR(data->vref_regu))
+		data->vref_regu = NULL;
+
+	/* Reset the chip to get a defined starting configuration */
+	ret = ads71x8_i2c_set_bit(data->client, ADS71x8_REG_GENERAL_CFG,
+		ADS71x8_GENERAL_CFG_RST);
+	if (ret < 0)
+		goto cleanup_config;
+
+	ret = ads71x8_set_conv_mode(data, ADS71x8_MODE_AUTO);
+	if (ret < 0)
+		goto cleanup_config;
+
+	/* Enable statistics and digital window comparator */
+	ret = ads71x8_i2c_set_bit(data->client, ADS71x8_REG_GENERAL_CFG,
+		(ADS71x8_GENERAL_CFG_STATS_EN | ADS71x8_GENERAL_CFG_DWC_EN));
+	if (ret < 0)
+		goto cleanup_config;
+
+	/* Enable all channels for auto sequencing */
+	ret = ads71x8_i2c_set_bit(data->client, ADS71x8_REG_AUTO_SEQ_CH_SEL, 0xFF);
+	if (ret < 0)
+		goto cleanup_config;
+
+	/* Set auto sequence mode and start sequencing */
+	ret = ads71x8_i2c_set_bit(data->client, ADS71x8_REG_SEQUENCE_CFG,
+		(ADS71x8_SEQUENCE_CFG_SEQ_START | ADS71x8_SEQUENCE_CFG_SEQ_MODE));
+	if (ret < 0)
+		goto cleanup_config;
+
+	return 0;
+
+cleanup_config:
+	return ret;
+}
+
+static int ads71x8_probe(struct i2c_client *client)
+{
+	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	struct iio_dev *indio_dev;
+	struct ads71x8_data *data;
+	int ret = 0;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+	i2c_set_clientdata(client, indio_dev);
+	mutex_init(&data->lock);
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->dev.of_node = client->dev.of_node;
+	indio_dev->name = id->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ads71x8_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ads71x8_channels);
+	indio_dev->info = &ti_ads71x8_info;
+
+	ret = devm_request_threaded_irq(&client->dev, client->irq,
+		NULL, ads71x8_event_handler,
+		IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
+		client->name, indio_dev);
+	if (ret)
+		goto cleanup_mutex;
+
+	ret = iio_device_register(indio_dev);
+	if (ret) {
+		dev_err(&client->dev, "Failed to register iio device\n");
+		goto cleanup_mutex;
+	}
+
+	ret = ads7138_init_hw(data);
+	if (ret) {
+		dev_err(&client->dev, "Failed to initialize device\n");
+		goto cleanup_iio;
+	}
+
+	return 0;
+
+cleanup_iio:
+	iio_device_unregister(indio_dev);
+cleanup_mutex:
+	mutex_destroy(&data->lock);
+out:
+	return ret;
+}
+
+static void ads71x8_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct ads71x8_data *data = iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	mutex_destroy(&data->lock);
+}
+
+#ifdef CONFIG_PM
+static int ads71x8_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct ads71x8_data *data = iio_priv(indio_dev);
+
+	return ads71x8_set_conv_mode(data, ADS71x8_MODE_MANUAL);
+}
+
+static int ads71x8_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct ads71x8_data *data = iio_priv(indio_dev);
+
+	return ads71x8_set_conv_mode(data, ADS71x8_MODE_AUTO);
+}
+#endif
+
+static const struct dev_pm_ops ads71x8_pm_ops = {
+	SET_RUNTIME_PM_OPS(ads71x8_runtime_suspend, ads71x8_runtime_resume, NULL)
+};
+
+static const struct of_device_id __maybe_unused ads71x8_of_match[] = {
+	{
+		.compatible = "ti,ads7128",
+		.data = (void *)ads7128
+	},
+	{
+		.compatible = "ti,ads7138",
+		.data = (void *)ads7138
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ads71x8_of_match);
+
+static const struct i2c_device_id ads71x8_device_ids[] = {
+	{ "ads7128", ads7128 },
+	{ "ads7138", ads7138 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ads71x8_device_ids);
+
+static struct i2c_driver ads71x8_driver = {
+	.driver = {
+		.name = MODULE_NAME,
+		.of_match_table = of_match_ptr(ads71x8_of_match),
+		.pm = &ads71x8_pm_ops,
+	},
+	.id_table = ads71x8_device_ids,
+	.probe = ads71x8_probe,
+	.remove = ads71x8_remove,
+};
+module_i2c_driver(ads71x8_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Tobias Sperling <tobias.sperling@softing.com>");
+MODULE_DESCRIPTION("Driver for TI ADS71x8 ADCs");

-- 
2.34.1



