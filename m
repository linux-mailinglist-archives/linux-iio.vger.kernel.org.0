Return-Path: <linux-iio+bounces-14936-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB47A25FED
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 17:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64D101887C9D
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 16:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148EA20AF94;
	Mon,  3 Feb 2025 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBbo+UyZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA82820ADFF;
	Mon,  3 Feb 2025 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738600070; cv=none; b=uxnvdCNNLP4MLtKKyElSPEyTFZJXXLiZmu/MvolyWkUGeO92h2vtFCemUW9KSAQ/QHVL9eKe8nc99WSbWPQ/qA9m7fldscmvJxhMnX/Dc/3zPki+WVZHqvGsVqWp7C30hQS9np1DHGqet/TCZmUwCa6zmfsiVWdFiSpboGxk5qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738600070; c=relaxed/simple;
	bh=fo7FhHn4VTCz2AevYUZc7Rk+bXE+x9h47Dvo+U8KPa4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HBNsHC//Xoh8rQ37IDieoAoTWTvvbzE4yUG+xEtSDe98Bags5Sr85m+ZxxKdge0xUwdpWmqo2rcTDbNBOQOvS8g2GkTlplQDE1kojsF48vZkZpS7rVrIVuxqINAT3ugwtZ+YVIc38iW7Ss+aUp2BhV9d36gO9/GXgGgxtnNb+QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBbo+UyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98F93C4CEE7;
	Mon,  3 Feb 2025 16:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738600070;
	bh=fo7FhHn4VTCz2AevYUZc7Rk+bXE+x9h47Dvo+U8KPa4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sBbo+UyZrtVFkPe0PYW5uEVoAijshaBneeAd2Ngi0n29/zOD589Wv6hh3vj3dR8kB
	 +raHtCqdE9SyUC1q3AkykTUR7Mn8qPEZ09Z14JVB5DZ/KI1Q1WZucChzylUzMH7uBT
	 bcWl7kYZZIy0iHxuI9naRJ/CKZi9C1i2nzelWRpkp6Q3Xgn+1LInD7X2VFJ7Ie2r7S
	 KIbVXGo8yYlqIdj44oYbwTJovBy4MepTq7PofwzCFEQ30zRySPDb47II5GvzEU6Vr4
	 rhsCeAH1Es0zGYAyMUDKuYuXtmE3bJDR/Ha4ZUZ+DLXPiQQOdtvc2qiRnl3/czjXAa
	 9VtZeTz3nXC8w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E500C02197;
	Mon,  3 Feb 2025 16:27:50 +0000 (UTC)
From: Tobias Sperling via B4 Relay <devnull+tobias.sperling.softing.com@kernel.org>
Date: Mon, 03 Feb 2025 17:27:35 +0100
Subject: [PATCH v2 2/2] iio: adc: Add driver for ADS7128 / ADS7138
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-adc_ml-v2-2-8a597660c395@softing.com>
References: <20250203-adc_ml-v2-0-8a597660c395@softing.com>
In-Reply-To: <20250203-adc_ml-v2-0-8a597660c395@softing.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Tobias Sperling <tobias.sperling@softing.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738600069; l=23228;
 i=tobias.sperling@softing.com; s=20241122; h=from:subject:message-id;
 bh=WImZ2RFxnKkeZV1OXhxNpaEpDl1jJweogW7opemBPiU=;
 b=sB+WDcTGg1RWmbgwv4SPhamqdzSDQOMSCJt2lUspoVbSjTecPv/aqvj+yMRd82fSTaZpX4d1y
 Jw1DZ7JhbvbAH2tSFrN6QM4Dw4hhsyX58rlwiseou7xxvxo/vtfssTH
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
ADS7128 differs in the addition of further hardware features, like a
root-mean-square (RMS) and a zero-crossing-detect (ZCD) module.

Signed-off-by: Tobias Sperling <tobias.sperling@softing.com>
---
 drivers/iio/adc/Kconfig      |  10 +
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/ti-ads7138.c | 755 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 766 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 849c90203071a77ec7d94cec06d4378ece44440b..c43277305a126c498f97e843c05747fddb705e9a 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1467,6 +1467,16 @@ config TI_ADS1119
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
index ee19afba62b7fe0a68309c16f3581d98c5b8f653..1e71d8eb6406b92e5d8e99d556c38858a8b9b640 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -133,6 +133,7 @@ obj-$(CONFIG_TI_ADS1119) += ti-ads1119.o
 obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
 obj-$(CONFIG_TI_ADS1298) += ti-ads1298.o
 obj-$(CONFIG_TI_ADS131E08) += ti-ads131e08.o
+obj-$(CONFIG_TI_ADS7138) += ti-ads7138.o
 obj-$(CONFIG_TI_ADS7924) += ti-ads7924.o
 obj-$(CONFIG_TI_ADS7950) += ti-ads7950.o
 obj-$(CONFIG_TI_ADS8344) += ti-ads8344.o
diff --git a/drivers/iio/adc/ti-ads7138.c b/drivers/iio/adc/ti-ads7138.c
new file mode 100644
index 0000000000000000000000000000000000000000..913b9216236c4d905bafcb4ef8148f6231adf6d4
--- /dev/null
+++ b/drivers/iio/adc/ti-ads7138.c
@@ -0,0 +1,755 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ADS7138 - Texas Instruments Analog-to-Digital Converter
+ */
+
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <linux/unaligned.h>
+
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
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
+struct ads71x8_chip_data {
+	const char *name;
+	const int channel_num;
+};
+
+struct ads71x8_data {
+	/* Protects RMW access to the I2C interface */
+	struct mutex lock;
+	struct i2c_client *client;
+	struct regulator *vref_regu;
+	const struct ads71x8_chip_data *chip_data;
+};
+
+static const int ads71x8_samp_freqs[] = {
+	1000000, 666667, 500000, 333333, 250000, 166667, 125000, 83333,
+	62500, 41667, 31250, 20833, 15625, 10417, 7813, 5208,
+	31250, 20833, 15625, 10417, 7813, 5208, 3906, 2604,
+	1953, 1302, 977, 651, 488, 326, 244, 163
+};
+
+static const int ads71x8_oversampling_ratios[] = {
+	1, 2, 4, 8, 16, 32, 64, 128
+};
+
+static int ads71x8_i2c_write_block(const struct i2c_client *client, u8 reg,
+				   u8 *values, u8 length)
+{
+	int ret;
+	int len = length + 2; /* "+ 2" for OPCODE and reg */
+
+	u8 *buf __free(kfree) = kmalloc(len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf[0] = ADS71x8_OPCODE_BLOCK_WRITE;
+	buf[1] = reg;
+	memcpy(&buf[2], values, length);
+
+	ret = i2c_master_send(client, buf, len);
+	if (ret < 0)
+		return ret;
+	if (ret != len)
+		return -EIO;
+
+	return 0;
+}
+
+static int ads71x8_i2c_write(const struct i2c_client *client, u8 reg, u8 value)
+{
+	return ads71x8_i2c_write_block(client, reg, &value, sizeof(value));
+}
+
+static int ads71x8_i2c_setclear_bit(const struct i2c_client *client, u8 reg,
+				    u8 bits, u8 opcode)
+{
+	u8 buf[3] = { opcode, reg, bits };
+	int ret;
+
+	ret = i2c_master_send(client, buf, ARRAY_SIZE(buf));
+	if (ret < 0)
+		return ret;
+	if (ret != ARRAY_SIZE(buf))
+		return -EIO;
+
+	return 0;
+}
+
+static int ads71x8_i2c_set_bit(const struct i2c_client *client, u8 reg, u8 bits)
+{
+	return ads71x8_i2c_setclear_bit(client, reg, bits,
+					ADS71x8_OPCODE_SET_BIT);
+}
+
+static int ads71x8_i2c_clear_bit(const struct i2c_client *client, u8 reg, u8 bits)
+{
+	return ads71x8_i2c_setclear_bit(client, reg, bits,
+					ADS71x8_OPCODE_CLEAR_BIT);
+}
+
+static int ads71x8_i2c_read_block(const struct i2c_client *client, u8 reg,
+				  u8 *out_values, u8 length)
+{
+	u8 buf[2] = { ADS71x8_OPCODE_BLOCK_READ, reg };
+	int ret;
+	struct i2c_msg msgs[] = {
+		{
+			.addr = client->addr,
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
+	ret = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
+	if (ret < 0)
+		return ret;
+	if (ret != ARRAY_SIZE(msgs))
+		return -EIO;
+
+	return 0;
+}
+
+static int ads71x8_i2c_read(const struct i2c_client *client, u8 reg)
+{
+	u8 value;
+	int ret;
+
+	ret = ads71x8_i2c_read_block(client, reg, &value, sizeof(value));
+	if (ret)
+		return ret;
+	return value;
+}
+
+static int ads71x8_freq_to_bits(int freq)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ads71x8_samp_freqs); i++)
+		if (freq == ads71x8_samp_freqs[i])
+			return i;
+
+	return -EINVAL;
+}
+
+static int ads71x8_osr_to_bits(int osr)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ads71x8_oversampling_ratios); i++)
+		if (osr == ads71x8_oversampling_ratios[i])
+			return i;
+
+	return -EINVAL;
+}
+
+static int ads71x8_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct ads71x8_data *data = iio_priv(indio_dev);
+	int ret, vref, index;
+	u8 values[2];
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = ads71x8_i2c_read_block(data->client,
+					     ADS71x8_REG_RECENT_LSB_CH(chan->channel),
+					     values, ARRAY_SIZE(values));
+		if (ret)
+			return ret;
+
+		*val = get_unaligned_le16(values);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = ads71x8_i2c_read(data->client, ADS71x8_REG_OPMODE_CFG);
+		if (ret < 0)
+			return ret;
+
+		index = FIELD_GET(ADS71x8_OPMODE_CFG_FREQ_MASK, ret);
+		*val = ads71x8_samp_freqs[index];
+		return IIO_VAL_INT;
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
+		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		ret = ads71x8_i2c_read(data->client, ADS71x8_REG_OSR_CFG);
+		if (ret < 0)
+			return ret;
+
+		index = FIELD_GET(ADS71x8_OSR_CFG_MASK, ret);
+		*val = ads71x8_oversampling_ratios[index];
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ads71x8_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct ads71x8_data *data = iio_priv(indio_dev);
+	int bits, ret;
+	u8 value;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		bits = ads71x8_freq_to_bits(val);
+		if (bits < 0)
+			return bits;
+
+		guard(mutex)(&data->lock);
+		ret = ads71x8_i2c_read(data->client, ADS71x8_REG_OPMODE_CFG);
+		if (ret < 0)
+			return ret;
+
+		value = ret & ~ADS71x8_OPMODE_CFG_FREQ_MASK;
+		value |= FIELD_PREP(ADS71x8_OPMODE_CFG_FREQ_MASK, bits);
+		return ads71x8_i2c_write(data->client, ADS71x8_REG_OPMODE_CFG,
+					 value);
+	}
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		bits = ads71x8_osr_to_bits(val);
+		if (bits < 0)
+			return bits;
+
+		return ads71x8_i2c_write(data->client, ADS71x8_REG_OSR_CFG,
+					 bits);
+	default:
+		return -EINVAL;
+	}
+}
+
+static ssize_t ads71x8_read_stats(struct iio_dev *indio_dev, uintptr_t priv,
+				  const struct iio_chan_spec *chan, char *buf)
+{
+	struct ads71x8_data *data = iio_priv(indio_dev);
+	u8 values[2];
+	int ret;
+
+	switch (priv) {
+	case ADS71x8_STATS_MIN:
+		ret = ads71x8_i2c_read_block(data->client,
+					     ADS71x8_REG_MIN_LSB_CH(chan->channel),
+					     values, ARRAY_SIZE(values));
+		if (ret)
+			return ret;
+		break;
+	case ADS71x8_STATS_MAX:
+		ret = ads71x8_i2c_read_block(data->client,
+					     ADS71x8_REG_MAX_LSB_CH(chan->channel),
+					     values, ARRAY_SIZE(values));
+		if (ret)
+			return ret;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return sprintf(buf, "%d\n", get_unaligned_le16(values));
+}
+
+static int ads71x8_read_event(struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan,
+			      enum iio_event_type type,
+			      enum iio_event_direction dir,
+			      enum iio_event_info info, int *val, int *val2)
+{
+	struct ads71x8_data *data = iio_priv(indio_dev);
+	u8 reg, values[2];
+	int ret;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		reg = (dir == IIO_EV_DIR_RISING) ?
+				ADS71x8_REG_HIGH_TH_HYS_CH(chan->channel) :
+				ADS71x8_REG_LOW_TH_CNT_CH(chan->channel);
+		ret = ads71x8_i2c_read_block(data->client, reg, values,
+					     ARRAY_SIZE(values));
+		if (ret)
+			return ret;
+
+		*val = ((values[1] << 4) | (values[0] >> 4));
+		return IIO_VAL_INT;
+	case IIO_EV_INFO_HYSTERESIS:
+		ret = ads71x8_i2c_read(data->client,
+				       ADS71x8_REG_HIGH_TH_HYS_CH(chan->channel));
+		if (ret < 0)
+			return ret;
+
+		*val = (ret & ~ADS71x8_THRESHOLD_LSB_MASK);
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ads71x8_write_event(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan,
+			       enum iio_event_type type,
+			       enum iio_event_direction dir,
+			       enum iio_event_info info, int val, int val2)
+{
+	struct ads71x8_data *data = iio_priv(indio_dev);
+	u8 reg, values[2];
+	int ret;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE: {
+		if (val >= BIT(12) || val < 0)
+			return -EINVAL;
+
+		reg = (dir == IIO_EV_DIR_RISING) ?
+				ADS71x8_REG_HIGH_TH_HYS_CH(chan->channel) :
+				ADS71x8_REG_LOW_TH_CNT_CH(chan->channel);
+
+		guard(mutex)(&data->lock);
+		ret = ads71x8_i2c_read(data->client, reg);
+		if (ret < 0)
+			return ret;
+
+		values[0] = ret & ~ADS71x8_THRESHOLD_LSB_MASK;
+		values[0] |= FIELD_PREP(ADS71x8_THRESHOLD_LSB_MASK, val);
+		values[1] = (val >> 4);
+		return ads71x8_i2c_write_block(data->client, reg, values,
+					       ARRAY_SIZE(values));
+	}
+	case IIO_EV_INFO_HYSTERESIS: {
+		if (val >= BIT(4) || val < 0)
+			return -EINVAL;
+
+		reg = ADS71x8_REG_HIGH_TH_HYS_CH(chan->channel);
+
+		guard(mutex)(&data->lock);
+		ret = ads71x8_i2c_read(data->client, reg);
+		if (ret < 0)
+			return ret;
+
+		values[0] = val & ~ADS71x8_THRESHOLD_LSB_MASK;
+		values[0] |= FIELD_PREP(ADS71x8_THRESHOLD_LSB_MASK, ret >> 4);
+		return ads71x8_i2c_write(data->client, reg, values[0]);
+	}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ads71x8_read_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
+{
+	struct ads71x8_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (dir != IIO_EV_DIR_EITHER)
+		return -EINVAL;
+
+	ret = ads71x8_i2c_read(data->client, ADS71x8_REG_ALERT_CH_SEL);
+	if (ret < 0)
+		return ret;
+
+	return (ret & BIT(chan->channel)) ? 1 : 0;
+}
+
+static int ads71x8_write_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir, bool state)
+{
+	struct ads71x8_data *data = iio_priv(indio_dev);
+
+	if (dir != IIO_EV_DIR_EITHER)
+		return -EINVAL;
+
+	if (state)
+		return ads71x8_i2c_set_bit(data->client,
+					   ADS71x8_REG_ALERT_CH_SEL,
+					   BIT(chan->channel));
+	else
+		return ads71x8_i2c_clear_bit(data->client,
+					     ADS71x8_REG_ALERT_CH_SEL,
+					     BIT(chan->channel));
+}
+
+static int ads71x8_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = ads71x8_samp_freqs;
+		*length = ARRAY_SIZE(ads71x8_samp_freqs);
+		*type = IIO_VAL_INT;
+
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*vals = ads71x8_oversampling_ratios;
+		*length = ARRAY_SIZE(ads71x8_oversampling_ratios);
+		*type = IIO_VAL_INT;
+
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info ti_ads71x8_info = {
+	.read_raw = &ads71x8_read_raw,
+	.read_avail = &ads71x8_read_avail,
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
+				 BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static const struct iio_chan_spec_ext_info ads71x8_ext_info[] = {
+	{
+		.name = "stats_min",
+		.shared = IIO_SEPARATE,
+		.read = ads71x8_read_stats,
+		.write = NULL,
+		.private = ADS71x8_STATS_MIN
+	}, {
+		.name = "stats_max",
+		.shared = IIO_SEPARATE,
+		.read = ads71x8_read_stats,
+		.write = NULL,
+		.private = ADS71x8_STATS_MAX
+	}, {}
+};
+
+#define ADS71x8_V_CHAN(_chan) {						\
+	.type = IIO_VOLTAGE,						\
+	.indexed = 1,							\
+	.channel = _chan,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
+				    BIT(IIO_CHAN_INFO_SCALE) |		\
+				    BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
+	.info_mask_shared_by_type_available =				\
+				BIT(IIO_CHAN_INFO_SAMP_FREQ) |		\
+				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
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
+	u8 i, events_high, events_low;
+	u64 code;
+	int ret;
+
+	/* Check if interrupt was trigger by us */
+	ret = ads71x8_i2c_read(data->client, ADS71x8_REG_EVENT_FLAG);
+	if (ret <= 0)
+		return IRQ_NONE;
+
+	ret = ads71x8_i2c_read(data->client, ADS71x8_REG_EVENT_HIGH_FLAG);
+	if (ret < 0) {
+		dev_warn(&data->client->dev,
+			 "Failed to read event high flags: %d\n", ret);
+		return IRQ_HANDLED;
+	}
+	events_high = ret;
+
+	ret = ads71x8_i2c_read(data->client, ADS71x8_REG_EVENT_LOW_FLAG);
+	if (ret < 0) {
+		dev_warn(&data->client->dev,
+			 "Failed to read event low flags: %d\n", ret);
+		return IRQ_HANDLED;
+	}
+	events_low = ret;
+
+	for (i = 0; i < data->chip_data->channel_num; i++) {
+		if (events_high & BIT(i)) {
+			code = IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING);
+			iio_push_event(indio_dev, code,
+				       iio_get_time_ns(indio_dev));
+		}
+		if (events_low & BIT(i)) {
+			code = IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, i,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_FALLING);
+			iio_push_event(indio_dev, code,
+				       iio_get_time_ns(indio_dev));
+		}
+	}
+
+	/* Try to clear all interrupt flags */
+	ret = ads71x8_i2c_write(data->client, ADS71x8_REG_EVENT_HIGH_FLAG, 0xFF);
+	if (ret)
+		dev_warn(&data->client->dev,
+			 "Failed to clear event high flags: %d\n", ret);
+
+	ret = ads71x8_i2c_write(data->client, ADS71x8_REG_EVENT_LOW_FLAG, 0xFF);
+	if (ret)
+		dev_warn(&data->client->dev,
+			 "Failed to clear event low flags: %d\n", ret);
+
+	return IRQ_HANDLED;
+}
+
+static int ads71x8_set_conv_mode(struct ads71x8_data *data,
+				 enum ads71x8_modes mode)
+{
+	if (mode == ADS71x8_MODE_AUTO)
+		return ads71x8_i2c_set_bit(data->client, ADS71x8_REG_OPMODE_CFG,
+					   ADS71x8_OPMODE_CFG_CONV_MODE);
+	return ads71x8_i2c_clear_bit(data->client, ADS71x8_REG_OPMODE_CFG,
+				     ADS71x8_OPMODE_CFG_CONV_MODE);
+}
+
+static int ads7138_init_hw(struct ads71x8_data *data)
+{
+	int ret;
+
+	data->vref_regu = devm_regulator_get_optional(&data->client->dev, "avdd");
+	if (IS_ERR(data->vref_regu))
+		data->vref_regu = NULL;
+
+	/* Reset the chip to get a defined starting configuration */
+	ret = ads71x8_i2c_set_bit(data->client, ADS71x8_REG_GENERAL_CFG,
+				  ADS71x8_GENERAL_CFG_RST);
+	if (ret)
+		return ret;
+
+	ret = ads71x8_set_conv_mode(data, ADS71x8_MODE_AUTO);
+	if (ret)
+		return ret;
+
+	/* Enable statistics and digital window comparator */
+	ret = ads71x8_i2c_set_bit(data->client, ADS71x8_REG_GENERAL_CFG,
+				  (ADS71x8_GENERAL_CFG_STATS_EN |
+				   ADS71x8_GENERAL_CFG_DWC_EN));
+	if (ret)
+		return ret;
+
+	/* Enable all channels for auto sequencing */
+	ret = ads71x8_i2c_set_bit(data->client, ADS71x8_REG_AUTO_SEQ_CH_SEL, 0xFF);
+	if (ret)
+		return ret;
+
+	/* Set auto sequence mode and start sequencing */
+	return ads71x8_i2c_set_bit(data->client, ADS71x8_REG_SEQUENCE_CFG,
+				   (ADS71x8_SEQUENCE_CFG_SEQ_START |
+				    ADS71x8_SEQUENCE_CFG_SEQ_MODE));
+}
+
+static int ads71x8_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct iio_dev *indio_dev;
+	struct ads71x8_data *data;
+	int ret = 0;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+	data->chip_data = i2c_get_match_data(client);
+	if (!data->chip_data)
+		return -ENODEV;
+
+	ret = devm_mutex_init(dev, &data->lock);
+	if (ret)
+		return ret;
+
+	indio_dev->name = data->chip_data->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ads71x8_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ads71x8_channels);
+	indio_dev->info = &ti_ads71x8_info;
+
+	i2c_set_clientdata(client, indio_dev);
+
+	ret = devm_request_threaded_irq(dev, client->irq,
+					NULL, ads71x8_event_handler,
+					IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
+					client->name, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = ads7138_init_hw(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to initialize device\n");
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register iio device\n");
+
+	return 0;
+}
+
+static int ads71x8_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ads71x8_data *data = iio_priv(indio_dev);
+
+	return ads71x8_set_conv_mode(data, ADS71x8_MODE_MANUAL);
+}
+
+static int ads71x8_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ads71x8_data *data = iio_priv(indio_dev);
+
+	return ads71x8_set_conv_mode(data, ADS71x8_MODE_AUTO);
+}
+
+static const struct dev_pm_ops ads71x8_pm_ops = {
+	SET_RUNTIME_PM_OPS(ads71x8_runtime_suspend, ads71x8_runtime_resume, NULL)
+};
+
+static const struct ads71x8_chip_data ads7128_data = {
+	.name = "ads7128",
+	.channel_num = 8,
+};
+
+static const struct ads71x8_chip_data ads7138_data = {
+	.name = "ads7138",
+	.channel_num = 8,
+};
+
+static const struct of_device_id ads71x8_of_match[] = {
+	{ .compatible = "ti,ads7128", .data = &ads7128_data },
+	{ .compatible = "ti,ads7138", .data = &ads7138_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ads71x8_of_match);
+
+static const struct i2c_device_id ads71x8_device_ids[] = {
+	{ "ads7128", (kernel_ulong_t)&ads7128_data },
+	{ "ads7138", (kernel_ulong_t)&ads7138_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ads71x8_device_ids);
+
+static struct i2c_driver ads71x8_driver = {
+	.driver = {
+		.name = "ads7138",
+		.of_match_table = ads71x8_of_match,
+		.pm = pm_ptr(&ads71x8_pm_ops),
+	},
+	.id_table = ads71x8_device_ids,
+	.probe = ads71x8_probe,
+};
+module_i2c_driver(ads71x8_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Tobias Sperling <tobias.sperling@softing.com>");
+MODULE_DESCRIPTION("Driver for TI ADS71x8 ADCs");

-- 
2.34.1



