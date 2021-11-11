Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8692944D572
	for <lists+linux-iio@lfdr.de>; Thu, 11 Nov 2021 12:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbhKKLDc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Nov 2021 06:03:32 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:62124 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229643AbhKKLDc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Nov 2021 06:03:32 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AB9EZB7012870;
        Thu, 11 Nov 2021 06:00:42 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3c8a7p6btg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Nov 2021 06:00:42 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 1ABB0f89011744
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 11 Nov 2021 06:00:41 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Thu, 11 Nov 2021
 06:00:40 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Thu, 11 Nov 2021 06:00:40 -0500
Received: from nsa.ad.analog.com ([10.44.3.52])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1ABB0cpj024606;
        Thu, 11 Nov 2021 06:00:39 -0500
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>
Subject: [RFC PATCH 1/1] iio: dac: add support for ltc2688
Date:   Thu, 11 Nov 2021 12:00:43 +0100
Message-ID: <20211111110043.101891-2-nuno.sa@analog.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211111110043.101891-1-nuno.sa@analog.com>
References: <20211111110043.101891-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: _BMMM_kZKaMUqt16s6YPa5uw26JmXCpm
X-Proofpoint-GUID: _BMMM_kZKaMUqt16s6YPa5uw26JmXCpm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-11_03,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111110066
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The LTC2688 is a 16 channel, 16 bit, +-15V DAC with an integrated
precission reference. It is guaranteed monotonic and has built in
rail-to-rail output buffers that can source or sink up to 20 mA.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/dac/ltc2688.c | 995 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 995 insertions(+)
 create mode 100644 drivers/iio/dac/ltc2688.c

diff --git a/drivers/iio/dac/ltc2688.c b/drivers/iio/dac/ltc2688.c
new file mode 100644
index 000000000000..b394701b044e
--- /dev/null
+++ b/drivers/iio/dac/ltc2688.c
@@ -0,0 +1,995 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * LTC2688 16 channel, 16 bit Voltage Output SoftSpan DAC driver
+ *
+ * Copyright 2021 Analog Devices Inc.
+ */
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/limits.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/unaligned/be_byteshift.h>
+
+#define LTC2688_DAC_CHANNELS			16
+
+#define LTC2688_CMD_CH_CODE(x)			(0x00 + (x))
+#define LTC2688_CMD_CH_SETTING(x)		(0x10 + (x))
+#define LTC2688_CMD_CH_OFFSET(x)		(0X20 + (x))
+#define LTC2688_CMD_CH_GAIN(x)			(0x30 + (x))
+#define LTC2688_CMD_CH_CODE_UPDATE(x)		(0x40 + (x))
+
+#define LTC2688_CMD_CONFIG_REG			0x70
+#define LTC2688_CMD_POWERDOWN_REG		0x71
+#define LTC2688_CMD_A_B_SELECT_REG		0x72
+#define LTC2688_CMD_TOGGLE_DITHER_EN_REG	0x74
+#define LTC2688_CMD_UPDATE_ALL			0x7C
+#define LTC2688_CMD_NOOP			0xFF
+
+#define LTC2688_READ_OPERATION			0x80
+
+/* Channel Settings */
+#define LTC2688_CH_SPAN_MSK			GENMASK(2, 0)
+#define LTC2688_CH_OVERRANGE_MSK		BIT(3)
+#define LTC2688_CH_TD_SEL_MSK			GENMASK(5, 4)
+#define LTC2688_CH_DIT_PER_MSK			GENMASK(8, 6)
+#define LTC2688_CH_DIT_PH_MSK			GENMASK(10, 9)
+#define LTC2688_CH_MODE_MSK			BIT(11)
+
+/* Configuration register */
+#define LTC2688_CONFIG_RST			BIT(15)
+#define LTC2688_CONFIG_EXT_REF			BIT(1)
+
+enum {
+	LTC2688_SPAN_RANGE_0V_5V,
+	LTC2688_SPAN_RANGE_M10V_10V,
+	LTC2688_SPAN_RANGE_M15V_15V,
+	/*
+	 * These 2 were deliberately re-arranged to be the last items as they
+	 * have the same fs and we will just return 1 in read_available.
+	 */
+	LTC2688_SPAN_RANGE_0V_10V,
+	LTC2688_SPAN_RANGE_M5V_5V,
+	LTC2688_SPAN_RANGE_MAX
+};
+
+struct ltc2688_chan {
+	int span_tbl[LTC2688_SPAN_RANGE_MAX][2];
+	bool overrange;
+	bool dither_toggle;
+	u8 offset_idx;
+};
+
+/*
+ * Helper tables to make sure the selected span is valid for the current offset
+ * and to translate the reg value to set for a specific span...
+ */
+static const int ltc2688_off_tbl[LTC2688_SPAN_RANGE_MAX] = {
+	[LTC2688_SPAN_RANGE_0V_5V] = 0,
+	[LTC2688_SPAN_RANGE_M10V_10V] = -32768,
+	[LTC2688_SPAN_RANGE_M15V_15V] = -32768,
+	[LTC2688_SPAN_RANGE_0V_10V] = 0,
+	[LTC2688_SPAN_RANGE_M5V_5V] = -32768
+};
+
+static const int ltc2688_reg_val[LTC2688_SPAN_RANGE_MAX] = {
+	[LTC2688_SPAN_RANGE_0V_5V] = 0,
+	[LTC2688_SPAN_RANGE_M10V_10V] = 3,
+	[LTC2688_SPAN_RANGE_M15V_15V] = 4,
+	[LTC2688_SPAN_RANGE_0V_10V] = 1,
+	[LTC2688_SPAN_RANGE_M5V_5V] = 2
+};
+
+struct ltc2688_state {
+	struct spi_device *spi;
+	struct regmap *regmap;
+	struct ltc2688_chan channels[LTC2688_DAC_CHANNELS];
+	int vref;
+	u8 tx_data[6] ____cacheline_aligned;
+	u8 rx_data[3];
+};
+
+static int ltc2688_spi_read(void *context, unsigned int cmd, unsigned int *val)
+{
+	struct ltc2688_state *st = context;
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = st->tx_data,
+			.bits_per_word = 8,
+			.len = 3,
+			.cs_change = 1,
+		}, {
+			.tx_buf = st->tx_data + 3,
+			.rx_buf = st->rx_data,
+			.bits_per_word = 8,
+			.len = 3,
+		},
+	};
+	int ret;
+
+	st->tx_data[0] = cmd | LTC2688_READ_OPERATION;
+	st->tx_data[3] = LTC2688_CMD_NOOP;
+
+	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
+	if (ret)
+		return ret;
+
+	/* first byte is to be ignored */
+	*val = get_unaligned_be16(&st->rx_data[1]);
+
+	return 0;
+}
+
+static int ltc2688_spi_write(void *context, unsigned int cmd, unsigned int val)
+{
+	struct ltc2688_state *st = context;
+
+	st->tx_data[0] = cmd;
+	put_unaligned_be16(val, &st->tx_data[1]);
+
+	return spi_write(st->spi, st->tx_data, 3);
+}
+
+static int ltc2688_span_get(const struct ltc2688_state *st, int c, int *val2)
+{
+	const struct ltc2688_chan *chan = &st->channels[c];
+	int ret, reg, span;
+	u32 i;
+
+	ret = regmap_read(st->regmap, LTC2688_CMD_CH_SETTING(c), &reg);
+	if (ret)
+		return ret;
+
+	span = FIELD_GET(LTC2688_CH_SPAN_MSK, reg);
+	/* sanity check to make sure we don't get any weird value from the HW */
+	if (span >= LTC2688_SPAN_RANGE_MAX)
+		return -EIO;
+
+	/* look for correct span */
+	for (i = 0; i < ARRAY_SIZE(ltc2688_reg_val); i++)
+		if (span == ltc2688_reg_val[i])
+			break;
+
+	*val2 = chan->span_tbl[i][1];
+
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
+static const int ltc2688_offset_avail[] = { -32768, 0 };
+
+static int ltc2688_span_set(const struct ltc2688_state *st, int c, int span)
+{
+	const struct ltc2688_chan *chan = &st->channels[c];
+	u32 i = ARRAY_SIZE(chan->span_tbl);
+	int off = ltc2688_offset_avail[chan->offset_idx];
+
+	while (i--) {
+		if (span == chan->span_tbl[i][1]) {
+			/*
+			 * The selected scale needs to fit  the current offset.
+			 * Note that for [0V 10V] and [-5V 5V], as the scale is
+			 * the same, we will always succeed here. Hence if
+			 * someone really wants [0 10V] and does not set the
+			 * offset to 0, then :man-shrugging:
+			 */
+			if (off == ltc2688_off_tbl[i]) {
+				break;
+			} else if (i < LTC2688_SPAN_RANGE_0V_10V) {
+				/*
+				 * At this point, only one offset is valid so we
+				 * already can assume error.
+				 */
+				dev_err(&st->spi->dev, "Offset(%d) not valid for current scale(0.%09d)\n",
+					off, span);
+				return -EPERM;
+			}
+
+			continue;
+		}
+
+		if (!i) {
+			dev_err(&st->spi->dev, "span(%d) not available\n", span);
+			return -EINVAL;
+		}
+	}
+
+	return regmap_update_bits(st->regmap, LTC2688_CMD_CH_SETTING(c),
+				  LTC2688_CH_SPAN_MSK,
+				  FIELD_PREP(LTC2688_CH_SPAN_MSK, ltc2688_reg_val[i]));
+};
+
+static int ltc2688_offset_set(struct ltc2688_state *st, int c, int off)
+{
+	struct ltc2688_chan *chan = &st->channels[c];
+
+	if (off != ltc2688_offset_avail[0] && off != ltc2688_offset_avail[1])
+		return -EINVAL;
+
+	if (off == ltc2688_offset_avail[0])
+		chan->offset_idx = 0;
+	else
+		chan->offset_idx = 1;
+
+	return 0;
+}
+
+static int ltc2688_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length, long m)
+{
+	struct ltc2688_state *st = iio_priv(indio_dev);
+	int c = chan->channel;
+
+	switch (m) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (const int *)st->channels[c].span_tbl;
+		*length = ARRAY_SIZE(st->channels[c].span_tbl) * 2 - 2;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_OFFSET:
+		*vals = ltc2688_offset_avail;
+		*length = ARRAY_SIZE(ltc2688_offset_avail);
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	};
+}
+
+static int ltc2688_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long m)
+{
+	struct ltc2688_state *st = iio_priv(indio_dev);
+	int ret;
+	u8 offset;
+
+	switch (m) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_read(st->regmap,
+				  LTC2688_CMD_CH_CODE(chan->address), val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_OFFSET:
+		offset = st->channels[chan->channel].offset_idx;
+		*val = ltc2688_offset_avail[offset];
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+		return ltc2688_span_get(st, chan->channel, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		ret = regmap_read(st->regmap,
+				  LTC2688_CMD_CH_OFFSET(chan->channel), val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		ret = regmap_read(st->regmap,
+				  LTC2688_CMD_CH_GAIN(chan->channel), val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ltc2688_write_raw_get_fmt(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan,
+				     long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_CALIBSCALE:
+	case IIO_CHAN_INFO_CALIBBIAS:
+	case IIO_CHAN_INFO_OFFSET:
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ltc2688_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct ltc2688_state *st = iio_priv(indio_dev);
+	int cmd;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (val > U16_MAX || val < 0)
+			return -EINVAL;
+		/*
+		 * If in dither/toggle mode the dac should be updated by an
+		 * external signal and not here
+		 */
+		if (st->channels[chan->channel].dither_toggle)
+			cmd = LTC2688_CMD_CH_CODE(chan->channel);
+		else
+			cmd = LTC2688_CMD_CH_CODE_UPDATE(chan->channel);
+
+		return regmap_write(st->regmap, cmd, val);
+	case IIO_CHAN_INFO_SCALE:
+		if (val)
+			return -EINVAL;
+
+		return ltc2688_span_set(st, chan->channel, val2);
+	case IIO_CHAN_INFO_OFFSET:
+		return ltc2688_offset_set(st, chan->channel, val);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return regmap_write(st->regmap,
+				    LTC2688_CMD_CH_OFFSET(chan->channel), val);
+	case IIO_CHAN_INFO_CALIBSCALE:
+		return regmap_write(st->regmap,
+				    LTC2688_CMD_CH_GAIN(chan->channel), val);
+	default:
+		return -EINVAL;
+	}
+}
+
+enum {
+	LTC2688_DITHER_TOGGLE_ENABLE,
+	LTC2688_POWERDOWN,
+};
+
+static ssize_t ltc2688_read_ext(struct iio_dev *indio_dev,
+				uintptr_t private,
+				const struct iio_chan_spec *chan,
+				char *buf)
+{
+	struct ltc2688_state *st = iio_priv(indio_dev);
+	int ret, regval;
+	u32 reg;
+
+	switch (private) {
+	case LTC2688_DITHER_TOGGLE_ENABLE:
+		reg = LTC2688_CMD_TOGGLE_DITHER_EN_REG;
+		break;
+	case LTC2688_POWERDOWN:
+		reg = LTC2688_CMD_POWERDOWN_REG;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_read(st->regmap, reg, &regval);
+	if (ret < 0)
+		return ret;
+
+	return sprintf(buf, "%u\n", !!(regval & BIT(chan->channel)));
+}
+
+static ssize_t ltc2688_write_ext(struct iio_dev *indio_dev,
+				 uintptr_t private,
+				 const struct iio_chan_spec *chan,
+				 const char *buf, size_t len)
+{
+	struct ltc2688_state *st = iio_priv(indio_dev);
+	bool en;
+	int ret;
+	u32 val = 0, reg;
+
+	ret = strtobool(buf, &en);
+	if (ret)
+		return ret;
+
+	switch (private) {
+	case LTC2688_DITHER_TOGGLE_ENABLE:
+		reg = LTC2688_CMD_TOGGLE_DITHER_EN_REG;
+		break;
+	case LTC2688_POWERDOWN:
+		reg = LTC2688_CMD_POWERDOWN_REG;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (en)
+		val = BIT(chan->channel);
+
+	ret = regmap_update_bits(st->regmap, reg, BIT(chan->channel), val);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static int ltc2688_get_dither_period(struct iio_dev *dev,
+				     const struct iio_chan_spec *chan)
+{
+	struct ltc2688_state *st = iio_priv(dev);
+	int ret, regval;
+
+	ret = regmap_read(st->regmap, LTC2688_CMD_CH_SETTING(chan->channel),
+			  &regval);
+	if (ret)
+		return ret;
+
+	return FIELD_GET(LTC2688_CH_DIT_PER_MSK, regval);
+}
+
+static int ltc2688_set_dither_period(struct iio_dev *dev,
+				     const struct iio_chan_spec *chan,
+				     unsigned int period)
+{
+	struct ltc2688_state *st = iio_priv(dev);
+
+	return regmap_update_bits(st->regmap,
+				  LTC2688_CMD_CH_SETTING(chan->channel),
+				  LTC2688_CH_DIT_PER_MSK,
+				  FIELD_PREP(LTC2688_CH_DIT_PER_MSK, period));
+}
+
+static int ltc2688_get_dither_phase(struct iio_dev *dev,
+				    const struct iio_chan_spec *chan)
+{
+	struct ltc2688_state *st = iio_priv(dev);
+	int ret, regval;
+
+	ret = regmap_read(st->regmap, LTC2688_CMD_CH_SETTING(chan->channel),
+			  &regval);
+	if (ret)
+		return ret;
+
+	return FIELD_GET(LTC2688_CH_DIT_PH_MSK, regval);
+}
+
+static int ltc2688_set_dither_phase(struct iio_dev *dev,
+				    const struct iio_chan_spec *chan,
+				    unsigned int phase)
+{
+	struct ltc2688_state *st = iio_priv(dev);
+
+	return regmap_update_bits(st->regmap,
+				  LTC2688_CMD_CH_SETTING(chan->channel),
+				  LTC2688_CH_DIT_PH_MSK,
+				  FIELD_PREP(LTC2688_CH_DIT_PH_MSK, phase));
+}
+
+static int ltc2688_get_reg_select(struct iio_dev *dev,
+				  const struct iio_chan_spec *chan)
+{
+	struct ltc2688_state *st = iio_priv(dev);
+	int ret, regval;
+
+	ret = regmap_read(st->regmap, LTC2688_CMD_A_B_SELECT_REG, &regval);
+	if (ret < 0)
+		return ret;
+
+	return !!(regval & BIT(chan->channel));
+}
+
+static int ltc2688_set_reg_select(struct iio_dev *dev,
+				  const struct iio_chan_spec *chan,
+				  unsigned int reg)
+{
+	struct ltc2688_state *st = iio_priv(dev);
+
+	return regmap_update_bits(st->regmap, LTC2688_CMD_A_B_SELECT_REG,
+				  BIT(chan->channel), reg << chan->channel);
+}
+
+static int ltc2688_reg_access(struct iio_dev *indio_dev,
+			      unsigned int reg,
+			      unsigned int writeval,
+			      unsigned int *readval)
+{
+	struct ltc2688_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+	else
+		return regmap_write(st->regmap, reg, writeval);
+}
+
+static const char * const ltc2688_input_register[] = {
+	"input_a",
+	"input_b",
+};
+
+static const struct iio_enum ltc2688_input_reg_enum = {
+	.items = ltc2688_input_register,
+	.num_items = ARRAY_SIZE(ltc2688_input_register),
+	.set = ltc2688_set_reg_select,
+	.get = ltc2688_get_reg_select,
+};
+
+static const char * const ltc2688_dither_period[] = {
+	"4",
+	"8",
+	"16",
+	"32",
+	"64",
+};
+
+static const struct iio_enum ltc2688_dither_period_enum = {
+	.items = ltc2688_dither_period,
+	.num_items = ARRAY_SIZE(ltc2688_dither_period),
+	.set = ltc2688_set_dither_period,
+	.get = ltc2688_get_dither_period,
+};
+
+static const char * const ltc2688_dither_phase[] = {
+	"0",
+	"90",
+	"180",
+	"270",
+};
+
+static const struct iio_enum ltc2688_dither_phase_enum = {
+	.items = ltc2688_dither_phase,
+	.num_items = ARRAY_SIZE(ltc2688_dither_phase),
+	.set = ltc2688_set_dither_phase,
+	.get = ltc2688_get_dither_phase,
+};
+
+#define LTC2688_CHAN_EXT_INFO(_name, _what, _shared) {	\
+	.name = _name,					\
+	.read = ltc2688_read_ext,			\
+	.write = ltc2688_write_ext,			\
+	.private = _what,				\
+	.shared = _shared,				\
+}
+
+#define IIO_ENUM_AVAILABLE_SHARED(_name, _shared, _e) {	\
+	.name = (_name "_available"),			\
+	.shared = _shared,				\
+	.read = iio_enum_available_read,		\
+	.private = (uintptr_t)(_e),			\
+}
+
+static const struct iio_chan_spec_ext_info ltc2688_dither_ext_info[] = {
+	IIO_ENUM("input_register", IIO_SEPARATE, &ltc2688_input_reg_enum),
+	IIO_ENUM_AVAILABLE_SHARED("input_register",
+				  IIO_SHARED_BY_TYPE, &ltc2688_input_reg_enum),
+	IIO_ENUM("dither_period", IIO_SEPARATE, &ltc2688_dither_period_enum),
+	IIO_ENUM_AVAILABLE_SHARED("dither_period",
+				  IIO_SHARED_BY_TYPE, &ltc2688_dither_period_enum),
+	IIO_ENUM("dither_phase", IIO_SEPARATE, &ltc2688_dither_phase_enum),
+	IIO_ENUM_AVAILABLE_SHARED("dither_phase",
+				  IIO_SHARED_BY_TYPE, &ltc2688_dither_phase_enum),
+	LTC2688_CHAN_EXT_INFO("dither_en", LTC2688_DITHER_TOGGLE_ENABLE,
+			      IIO_SEPARATE),
+	LTC2688_CHAN_EXT_INFO("powerdown", LTC2688_POWERDOWN, IIO_SEPARATE),
+	{}
+};
+
+static const struct iio_chan_spec_ext_info ltc2688_toggle_ext_info[] = {
+	IIO_ENUM("input_register", IIO_SEPARATE, &ltc2688_input_reg_enum),
+	IIO_ENUM_AVAILABLE_SHARED("input_register",
+				  IIO_SHARED_BY_TYPE, &ltc2688_input_reg_enum),
+	LTC2688_CHAN_EXT_INFO("toggle_en", LTC2688_DITHER_TOGGLE_ENABLE,
+			      IIO_SEPARATE),
+	LTC2688_CHAN_EXT_INFO("powerdown", LTC2688_POWERDOWN, IIO_SEPARATE),
+	{}
+};
+
+static const struct iio_chan_spec_ext_info ltc2688_default_ext_info[] = {
+	LTC2688_CHAN_EXT_INFO("powerdown", LTC2688_POWERDOWN, IIO_SEPARATE),
+	{}
+};
+
+#define LTC2688_CHANNEL(_chan) {					\
+	.type = IIO_VOLTAGE,						\
+	.indexed = 1,							\
+	.output = 1,							\
+	.channel = (_chan),						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBSCALE) |		\
+		BIT(IIO_CHAN_INFO_SCALE) | BIT(IIO_CHAN_INFO_OFFSET) |	\
+		BIT(IIO_CHAN_INFO_CALIBBIAS) | BIT(IIO_CHAN_INFO_RAW),	\
+	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),	\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_OFFSET),\
+	.ext_info = ltc2688_default_ext_info				\
+}
+
+struct iio_chan_spec ltc2688_channels[] = {
+	LTC2688_CHANNEL(0),
+	LTC2688_CHANNEL(1),
+	LTC2688_CHANNEL(2),
+	LTC2688_CHANNEL(3),
+	LTC2688_CHANNEL(4),
+	LTC2688_CHANNEL(5),
+	LTC2688_CHANNEL(6),
+	LTC2688_CHANNEL(7),
+	LTC2688_CHANNEL(8),
+	LTC2688_CHANNEL(9),
+	LTC2688_CHANNEL(10),
+	LTC2688_CHANNEL(11),
+	LTC2688_CHANNEL(12),
+	LTC2688_CHANNEL(13),
+	LTC2688_CHANNEL(14),
+	LTC2688_CHANNEL(15),
+};
+
+enum {
+	LTC2688_CHAN_MODE_TOGGLE,
+	LTC2688_CHAN_MODE_DITHER
+};
+
+enum {
+	LTC2688_CHAN_TD_TGP1,
+	LTC2688_CHAN_TD_TGP2,
+	LTC2688_CHAN_TD_TGP3,
+	LTC2688_CHAN_TD_MAX
+};
+
+static const char * const ltc2688_clk_names[LTC2688_CHAN_TD_MAX] = {
+	"TGP1", "TGP2", "TGP3"
+};
+
+static void ltc2688_clk_disable(void *clk)
+{
+	clk_disable_unprepare(clk);
+}
+
+static int ltc2688_clk_setup(const struct ltc2688_state *st, unsigned long mask)
+{
+	u32 bit;
+	int ret;
+
+	for_each_set_bit(bit, &mask, ARRAY_SIZE(ltc2688_clk_names)) {
+		struct clk *clk;
+		/*
+		 * If a TGP pin is set, then we need to provide a valid clock at
+		 * the pin.
+		 */
+		clk = devm_clk_get(&st->spi->dev, ltc2688_clk_names[bit]);
+		if (IS_ERR(clk))
+			return dev_err_probe(&st->spi->dev, PTR_ERR(clk),
+					     "failed to get clk: %s\n",
+					     ltc2688_clk_names[bit]);
+
+		ret = clk_prepare_enable(clk);
+		if (ret)
+			return dev_err_probe(&st->spi->dev, ret,
+					     "failed to enable clk: %s\n",
+					     ltc2688_clk_names[bit]);
+
+		ret = devm_add_action_or_reset(&st->spi->dev,
+					       ltc2688_clk_disable, clk);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int ltc2688_channel_config(struct ltc2688_state *st)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(&st->spi->dev), *child;
+	u32 reg, clk_input, mode, val, mask;
+	unsigned long clk_msk = 0;
+	int ret;
+
+	fwnode_for_each_available_child_node(fwnode, child) {
+		struct ltc2688_chan *chan;
+
+		ret = fwnode_property_read_u32(child, "reg", &reg);
+		if (ret) {
+			fwnode_handle_put(child);
+			return dev_err_probe(&st->spi->dev, ret,
+					     "Failed to get reg property\n");
+		} else if (reg >= LTC2688_DAC_CHANNELS) {
+			fwnode_handle_put(child);
+			return dev_err_probe(&st->spi->dev, -EINVAL,
+					     "reg >= %d\n", LTC2688_DAC_CHANNELS);
+		}
+
+		chan = &st->channels[reg];
+		ret = fwnode_property_read_u32(child, "adi,mode", &mode);
+		if (!ret) {
+			if (mode > LTC2688_CHAN_MODE_DITHER) {
+				fwnode_handle_put(child);
+				return dev_err_probe(&st->spi->dev, -EINVAL,
+						     "chan mode inv value(%d)\n",
+						     mode);
+			}
+
+			chan->dither_toggle = true;
+			if (mode == LTC2688_CHAN_MODE_TOGGLE) {
+				ltc2688_channels[reg].ext_info = ltc2688_toggle_ext_info;
+			} else {
+				ltc2688_channels[reg].ext_info = ltc2688_dither_ext_info;
+				/* enable dither mode */
+				mask = LTC2688_CH_MODE_MSK;
+				val = BIT(11);
+			}
+		}
+
+		ret = fwnode_property_read_u32(child, "adi,toggle-dither-input",
+					       &clk_input);
+		if (!ret) {
+			if (clk_input > LTC2688_CHAN_TD_TGP3) {
+				fwnode_handle_put(child);
+				return dev_err_probe(&st->spi->dev, -EINVAL,
+						     "toggle-dither-input inv value(%d)\n",
+						     clk_input);
+			}
+
+			clk_msk |= BIT(clk_input);
+			mask |= LTC2688_CH_TD_SEL_MSK;
+			/*
+			 * 0 means software toggle which we are not supporting
+			 * for now. Hence the +1
+			 */
+			val |= FIELD_PREP(LTC2688_CH_TD_SEL_MSK, clk_input + 1);
+		} else if (chan->dither_toggle) {
+			/*
+			 * As sw_toggle is not supported, we need to make sure
+			 * a valid input is selected if toggle/dither mode is
+			 * requested
+			 */
+			return dev_err_probe(&st->spi->dev, -EINVAL,
+					     "toggle-dither set but no toggle-dither-input\n");
+		}
+
+		chan->overrange = fwnode_property_read_bool(child,
+							    "adi,overrange");
+		if (chan->overrange) {
+			val |= LTC2688_CH_OVERRANGE_MSK;
+			mask |= BIT(3);
+		}
+
+		if (!mask)
+			continue;
+
+		ret = regmap_update_bits(st->regmap,
+					 LTC2688_CMD_CH_SETTING(reg), mask,
+					 val);
+		if (ret) {
+			fwnode_handle_put(child);
+			return dev_err_probe(&st->spi->dev, -EINVAL,
+					     "failed to set chan settings\n");
+		}
+
+		mask = 0;
+		val = 0;
+	}
+
+	return ltc2688_clk_setup(st, clk_msk);
+}
+
+static const int ltc2688_span_helper[LTC2688_SPAN_RANGE_MAX][2] = {
+	{0, 5000}, {-10000, 10000}, {-15000, 15000}, {0, 10000}, {-5000, 5000},
+};
+
+static int ltc2688_get_full_scale(const struct ltc2688_chan *chan, int idx)
+{
+	int fs = ltc2688_span_helper[idx][1] - ltc2688_span_helper[idx][0];
+
+	if (chan->overrange)
+		fs = mult_frac(fs, 105, 100);
+
+	return fs;
+}
+
+static void ltc2688_span_avail_compute(struct ltc2688_state *st)
+{
+	u32 c, i;
+
+	for (c = 0; c < ARRAY_SIZE(st->channels); c++) {
+		struct ltc2688_chan *chan = &st->channels[c];
+
+		for (i = 0; i < ARRAY_SIZE(chan->span_tbl); i++) {
+			u32 fs, s;
+
+			fs = ltc2688_get_full_scale(chan, i);
+			/* we will return IIO_VAL_INT_PLUS_NANO */
+			s = DIV_ROUND_CLOSEST_ULL(st->vref * fs * 1000000000ULL,
+						  4096 * 1 << 16);
+
+			chan->span_tbl[i][1] = s;
+			/* default offset is 0 */
+			chan->offset_idx = 1;
+		}
+	}
+}
+
+static int ltc2688_setup(struct ltc2688_state *st, struct regulator *vref)
+{
+	struct gpio_desc *gpio;
+	int ret;
+
+	gpio = devm_gpiod_get_optional(&st->spi->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpio))
+		return dev_err_probe(&st->spi->dev, PTR_ERR(gpio),
+				     "Failed to get reset gpio");
+
+	if (gpio) {
+		usleep_range(1000, 1200);
+		/* bring device out of reset */
+		gpiod_set_value_cansleep(gpio, 0);
+	} else {
+		ret = regmap_update_bits(st->regmap, LTC2688_CMD_CONFIG_REG,
+					 LTC2688_CONFIG_RST,
+					 LTC2688_CONFIG_RST);
+		if (ret < 0)
+			return ret;
+	}
+
+	usleep_range(10000, 12000);
+	ret = ltc2688_channel_config(st);
+	if (ret < 0)
+		return ret;
+
+	if (vref) {
+		ret = regmap_update_bits(st->regmap, LTC2688_CMD_CONFIG_REG,
+					 LTC2688_CONFIG_EXT_REF, BIT(1));
+		if (ret < 0)
+			return ret;
+	}
+
+	ltc2688_span_avail_compute(st);
+	return 0;
+}
+
+static void ltc2688_disable_regulator(void *regulator)
+{
+	regulator_disable(regulator);
+}
+
+static int ltc2688_regulator_supply_get(const struct ltc2688_state *st,
+					const char *name)
+{
+	struct regulator *reg;
+	int ret;
+
+	reg = devm_regulator_get(&st->spi->dev, name);
+	if (IS_ERR(reg))
+		return dev_err_probe(&st->spi->dev, PTR_ERR(reg),
+				     "Failed to get %s regulator\n", name);
+
+	ret = regulator_enable(reg);
+	if (ret)
+		return dev_err_probe(&st->spi->dev, ret,
+				     "Failed to enable %s regulator\n", name);
+
+	return devm_add_action_or_reset(&st->spi->dev,
+					ltc2688_disable_regulator, reg);
+}
+
+static bool ltc2688_reg_readable(struct device *dev, unsigned int cmd)
+{
+	switch (cmd | LTC2688_READ_OPERATION) {
+	case 0x80 ... 0xBF:
+		return true;
+	case 0xF0 ... 0xFE:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool ltc2688_reg_writable(struct device *dev, unsigned int cmd)
+{
+	if (cmd <= LTC2688_CMD_UPDATE_ALL)
+		return true;
+
+	return false;
+}
+
+static const struct regmap_config ltc2688_regmap_config = {
+	.reg_read = ltc2688_spi_read,
+	.reg_write = ltc2688_spi_write,
+	.readable_reg = ltc2688_reg_readable,
+	.writeable_reg = ltc2688_reg_writable,
+	/* ignoring the no op command */
+	.max_register = U16_MAX - 1
+};
+
+static const struct iio_info ltc2688_info = {
+	.write_raw = ltc2688_write_raw,
+	.read_raw = ltc2688_read_raw,
+	.write_raw_get_fmt = ltc2688_write_raw_get_fmt,
+	.read_avail = ltc2688_read_avail,
+	.debugfs_reg_access = ltc2688_reg_access,
+};
+
+static int ltc2688_probe(struct spi_device *spi)
+{
+	struct ltc2688_state *st;
+	struct iio_dev *indio_dev;
+	struct regulator *vref_reg;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+
+	st->regmap = devm_regmap_init(&spi->dev, NULL, st, &ltc2688_regmap_config);
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->regmap),
+				     "Failed to init regmap");
+
+	ret = ltc2688_regulator_supply_get(st, "vcc");
+	if (ret)
+		return ret;
+
+	ret = ltc2688_regulator_supply_get(st, "iovcc");
+	if (ret)
+		return ret;
+
+	vref_reg = devm_regulator_get_optional(&spi->dev, "vref");
+	if (!IS_ERR(vref_reg)) {
+		ret = regulator_enable(vref_reg);
+		if (ret)
+			return dev_err_probe(&spi->dev, ret,
+					     "Failed to enable vref regulators\n");
+
+		ret = devm_add_action_or_reset(&spi->dev,
+					       ltc2688_disable_regulator,
+					       vref_reg);
+		if (ret)
+			return ret;
+
+		ret = regulator_get_voltage(vref_reg);
+		if (ret < 0)
+			return dev_err_probe(&spi->dev, ret,
+					     "Failed to get vref\n");
+
+		st->vref = ret / 1000;
+	} else {
+		if (PTR_ERR(vref_reg) != -ENODEV)
+			return dev_err_probe(&spi->dev, PTR_ERR(vref_reg),
+					     "Failed to get vref regulator");
+
+		vref_reg = NULL;
+		/* internal reference */
+		st->vref = 4096;
+	}
+
+	indio_dev->name = "ltc2688";
+	indio_dev->info = &ltc2688_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ltc2688_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ltc2688_channels);
+
+	ret = ltc2688_setup(st, vref_reg);
+	if (ret < 0)
+		return ret;
+
+	return devm_iio_device_register(&st->spi->dev, indio_dev);
+}
+
+static const struct of_device_id ltc2688_of_id[] = {
+	{ .compatible = "adi,ltc2688" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ltc2688_of_id);
+
+static const struct spi_device_id ltc2688_id[] = {
+	{ "ltc2688" },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ltc2688_id);
+
+static struct spi_driver ltc2688_driver = {
+	.driver = {
+		.name = "ltc2688",
+		.of_match_table = ltc2688_of_id,
+	},
+	.probe = ltc2688_probe,
+	.id_table = ltc2688_id,
+};
+module_spi_driver(ltc2688_driver);
+
+MODULE_AUTHOR("Nuno Sá <nuno.sa@analog.com>");
+MODULE_DESCRIPTION("Analog Devices LTC2688 DAC");
+MODULE_LICENSE("GPL");
-- 
2.33.1

