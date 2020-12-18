Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764942DE7DC
	for <lists+linux-iio@lfdr.de>; Fri, 18 Dec 2020 18:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732227AbgLRRJF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Dec 2020 12:09:05 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:24866 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727787AbgLRRJF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Dec 2020 12:09:05 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BIGl0ks011129;
        Fri, 18 Dec 2020 12:08:23 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 35cun963xn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Dec 2020 12:08:22 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0BIH8KI0002348
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 18 Dec 2020 12:08:21 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 18 Dec 2020 09:08:19 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 18 Dec 2020 09:08:19 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0BIH8D3V024409;
        Fri, 18 Dec 2020 12:08:16 -0500
From:   Cristian Pop <cristian.pop@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        Cristian Pop <cristian.pop@analog.com>
Subject: [PATCH v4 3/3] iio: dac: ad5766: add driver support for AD5766
Date:   Fri, 18 Dec 2020 19:12:31 +0200
Message-ID: <20201218171231.58794-3-cristian.pop@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201218171231.58794-1-cristian.pop@analog.com>
References: <20201218171231.58794-1-cristian.pop@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-18_10:2020-12-18,2020-12-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 bulkscore=0 adultscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012180115
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The AD5766/AD5767 are 16-channel, 16-bit/12-bit, voltage output dense DACs
Digital-to-Analog converters.

This change adds support for these DACs.

Signed-off-by: Cristian Pop <cristian.pop@analog.com>
---
Changelog v4:
	- Select output range
	- Set possible dither source to: 0 - N0 and 1 for N1.
	- Better macros usage
	- Invert reset logic
	- Use GENMASK
	- Add/remove some commas
 drivers/iio/dac/Kconfig  |  10 +
 drivers/iio/dac/Makefile |   1 +
 drivers/iio/dac/ad5766.c | 668 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 679 insertions(+)
 create mode 100644 drivers/iio/dac/ad5766.c

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 6f6074a5d3db..cea07b4cced1 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -189,6 +189,16 @@ config AD5764
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5764.
 
+config AD5766
+	tristate "Analog Devices AD5766/AD5767 DAC driver"
+	depends on SPI_MASTER
+	help
+	  Say yes here to build support for Analog Devices AD5766, AD5767
+	  Digital to Analog Converter.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad5766.
+
 config AD5770R
 	tristate "Analog Devices AD5770R IDAC driver"
 	depends on SPI_MASTER
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 2fc481167724..33e16f14902a 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_AD5755) += ad5755.o
 obj-$(CONFIG_AD5755) += ad5758.o
 obj-$(CONFIG_AD5761) += ad5761.o
 obj-$(CONFIG_AD5764) += ad5764.o
+obj-$(CONFIG_AD5766) += ad5766.o
 obj-$(CONFIG_AD5770R) += ad5770r.o
 obj-$(CONFIG_AD5791) += ad5791.o
 obj-$(CONFIG_AD5686) += ad5686.o
diff --git a/drivers/iio/dac/ad5766.c b/drivers/iio/dac/ad5766.c
new file mode 100644
index 000000000000..b7405185f3d8
--- /dev/null
+++ b/drivers/iio/dac/ad5766.c
@@ -0,0 +1,668 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices AD5766, AD5767
+ * Digital to Analog Converters driver
+ * Copyright 2019-2020 Analog Devices Inc.
+ */
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/unaligned/be_byteshift.h>
+
+#define AD5766_UPPER_WORD_SPI_MASK		GENMASK(31, 16)
+#define AD5766_LOWER_WORD_SPI_MASK		GENMASK(15, 0)
+#define AD5766_DITHER_SOURCE_MASK(ch)		GENMASK(((2 * ch) + 1), (2 * ch))
+#define AD5766_DITHER_SOURCE(ch, source)	BIT((ch * 2) + source)
+#define AD5766_DITHER_SCALE_MASK(x)		AD5766_DITHER_SOURCE_MASK(x)
+#define AD5766_DITHER_SCALE(ch, scale)		(scale << (ch * 2))
+#define AD5766_DITHER_ENABLE_MASK(ch)		BIT(ch)
+#define AD5766_DITHER_ENABLE(ch, state)		((!state) << ch)
+#define AD5766_DITHER_INVERT_MASK(ch)		BIT(ch)
+#define AD5766_DITHER_INVERT(ch, state)		(state << ch)
+
+#define AD5766_CMD_NOP_MUX_OUT			0x00
+#define AD5766_CMD_SDO_CNTRL			0x01
+#define AD5766_CMD_WR_IN_REG(x)			(0x10 | ((x) & GENMASK(3, 0)))
+#define AD5766_CMD_WR_DAC_REG(x)		(0x20 | ((x) & GENMASK(3, 0)))
+#define AD5766_CMD_SW_LDAC			0x30
+#define AD5766_CMD_SPAN_REG			0x40
+#define AD5766_CMD_WR_PWR_DITHER		0x51
+#define AD5766_CMD_WR_DAC_REG_ALL		0x60
+#define AD5766_CMD_SW_FULL_RESET		0x70
+#define AD5766_CMD_READBACK_REG(x)		(0x80 | ((x) & GENMASK(3, 0)))
+#define AD5766_CMD_DITHER_SIG_1			0x90
+#define AD5766_CMD_DITHER_SIG_2			0xA0
+#define AD5766_CMD_INV_DITHER			0xB0
+#define AD5766_CMD_DITHER_SCALE_1		0xC0
+#define AD5766_CMD_DITHER_SCALE_2		0xD0
+
+#define AD5766_FULL_RESET_CODE			0x1234
+
+enum ad5766_type {
+	ID_AD5766,
+	ID_AD5767,
+};
+
+enum ad5766_voltage_range {
+	AD5766_VOLTAGE_RANGE_M20V_0V,
+	AD5766_VOLTAGE_RANGE_M16V_to_0V,
+	AD5766_VOLTAGE_RANGE_M10V_to_0V,
+	AD5766_VOLTAGE_RANGE_M12V_to_14V,
+	AD5766_VOLTAGE_RANGE_M16V_to_10V,
+	AD5766_VOLTAGE_RANGE_M10V_to_6V,
+	AD5766_VOLTAGE_RANGE_M5V_to_5V,
+	AD5766_VOLTAGE_RANGE_M10V_to_10V,
+};
+
+/**
+ * struct ad5766_chip_info - chip specific information
+ * @num_channels:	number of channels
+ * @channel:	        channel specification
+ */
+struct ad5766_chip_info {
+	unsigned int			num_channels;
+	const struct iio_chan_spec	*channels;
+};
+
+enum {
+	AD5766_DITHER_ENABLE,
+	AD5766_DITHER_INVERT,
+	AD5766_DITHER_SOURCE,
+};
+
+/*
+ * Dither signal can also be scaled.
+ * Available dither scale strings corresponding to "dither_scale" field in
+ * "struct ad5766_state".
+ */
+static const char * const ad5766_dither_scales[] = {
+	"100",
+	"75",
+	"50",
+	"25",
+};
+
+/**
+ * struct ad5766_state - driver instance specific data
+ * @spi:		SPI device
+ * @lock:		Lock used to restrict concurent access to SPI device
+ * @chip_info:		Chip model specific constants
+ * @gpio_reset:		Reset GPIO, used to reset the device
+ * @crt_range:		Current selected output range
+ * @dither_enable:	Power enable bit for each channel dither block (for
+ *			example, D15 = DAC 15,D8 = DAC 8, and D0 = DAC 0)
+ *			0 - Normal operation, 1 - Power down
+ * @dither_invert:	Inverts the dither signal applied to the selected DAC
+ *			outputs
+ * @dither_source:	Selects between 2 possible sources:
+ *			1: N0, 2: N1
+ *			Two bits are used for each channel
+ * @dither_scale:	Two bits are used for each of the 16 channels:
+ *			0: 100% SCALING, 1: 75% SCALING, 2: 50% SCALING,
+ *			3: 25% SCALING.
+ * @data:		SPI transfer buffers
+ */
+struct ad5766_state {
+	struct spi_device		*spi;
+	struct mutex			lock;
+	const struct ad5766_chip_info	*chip_info;
+	struct gpio_desc		*gpio_reset;
+	enum ad5766_voltage_range	crt_range;
+	u16		dither_enable;
+	u16		dither_invert;
+	u32		dither_source;
+	u32		dither_scale;
+	union {
+		u32	d32;
+		u16	w16[2];
+		u8	b8[4];
+	} data[3] ____cacheline_aligned;
+};
+
+struct ad5766_span_tbl {
+	int		min;
+	int		max;
+};
+
+static const struct ad5766_span_tbl ad5766_span_tbl[] = {
+	[AD5766_VOLTAGE_RANGE_M20V_0V] = {
+		.min = -20,
+		.max = 0,
+	},
+	[AD5766_VOLTAGE_RANGE_M16V_to_0V] = {
+		.min = -16,
+		.max = 0,
+	},
+	[AD5766_VOLTAGE_RANGE_M10V_to_0V] = {
+		.min = -10,
+		.max = 0,
+	},
+	[AD5766_VOLTAGE_RANGE_M12V_to_14V] = {
+		.min = -12,
+		.max = 14,
+	},
+	[AD5766_VOLTAGE_RANGE_M16V_to_10V] = {
+		.min = -16,
+		.max = 10,
+	},
+	[AD5766_VOLTAGE_RANGE_M10V_to_6V] = {
+		.min = -10,
+		.max = 6,
+	},
+	[AD5766_VOLTAGE_RANGE_M5V_to_5V] = {
+		.min = -5,
+		.max = 5,
+	},
+	[AD5766_VOLTAGE_RANGE_M10V_to_10V] = {
+		.min = -10,
+		.max = 10,
+	},
+};
+
+static int __ad5766_spi_read(struct ad5766_state *st, u8 dac, int *val)
+{
+	int ret;
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = &st->data[0].d32,
+			.bits_per_word = 8,
+			.len = 3,
+			.cs_change = 1,
+		}, {
+			.tx_buf = &st->data[1].d32,
+			.rx_buf = &st->data[2].d32,
+			.bits_per_word = 8,
+			.len = 3,
+		},
+	};
+
+	st->data[0].d32 = AD5766_CMD_READBACK_REG(dac);
+	st->data[1].d32 = AD5766_CMD_NOP_MUX_OUT;
+
+	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
+	if (ret)
+		return ret;
+
+	*val = st->data[2].w16[1];
+
+	return ret;
+}
+
+static int __ad5766_spi_write(struct ad5766_state *st, u8 command, u16 data)
+{
+	st->data[0].b8[0] = command;
+	put_unaligned_be16(data, &st->data[0].b8[1]);
+
+	return spi_write(st->spi, &st->data[0].b8[0], 3);
+}
+
+static int ad5766_read(struct iio_dev *indio_dev, u8 dac, int *val)
+{
+	struct ad5766_state *st = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = __ad5766_spi_read(st, dac, val);
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int ad5766_write(struct iio_dev *indio_dev, u8 dac, u16 data)
+{
+	struct ad5766_state *st = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = __ad5766_spi_write(st, AD5766_CMD_WR_DAC_REG(dac), data);
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int ad5766_reset(struct ad5766_state *st)
+{
+	int ret;
+
+	if (st->gpio_reset) {
+		gpiod_set_value_cansleep(st->gpio_reset, 1);
+		ndelay(100); /* t_reset >= 100ns */
+		gpiod_set_value_cansleep(st->gpio_reset, 0);
+	} else {
+		ret = __ad5766_spi_write(st, AD5766_CMD_SW_FULL_RESET,
+					AD5766_FULL_RESET_CODE);
+		if (ret < 0)
+			return ret;
+	}
+
+	/*
+	 * Minimum time between a reset and the subsequent successful write is
+	 * typically 25 ns
+	 */
+	ndelay(25);
+
+	return 0;
+}
+
+static int ad5766_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val,
+			   int *val2,
+			   long m)
+{
+	struct ad5766_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (m) {
+	case IIO_CHAN_INFO_RAW:
+		ret = ad5766_read(indio_dev, chan->address, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = ad5766_span_tbl[st->crt_range].min;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = ad5766_span_tbl[st->crt_range].max -
+		       ad5766_span_tbl[st->crt_range].min;
+		*val2 = st->chip_info->channels[0].scan_type.realbits;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad5766_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val,
+			    int val2,
+			    long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+	{
+		const int max_val = GENMASK(chan->scan_type.realbits - 1, 0);
+
+		if (val > max_val || val < 0)
+			return -EINVAL;
+		val <<= chan->scan_type.shift;
+		return ad5766_write(indio_dev, chan->address, val);
+	}
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info ad5766_info = {
+	.read_raw = ad5766_read_raw,
+	.write_raw = ad5766_write_raw,
+};
+
+static int ad5766_get_dither_source(struct iio_dev *dev,
+				    const struct iio_chan_spec *chan)
+{
+	struct ad5766_state *st = iio_priv(dev);
+	u32 source;
+
+	source = st->dither_source & AD5766_DITHER_SOURCE_MASK(chan->channel);
+	source = source >> (chan->channel * 2);
+	source -= 1;
+
+	return source;
+}
+
+static int ad5766_set_dither_source(struct iio_dev *dev,
+			  const struct iio_chan_spec *chan,
+			  unsigned int source)
+{
+	struct ad5766_state *st = iio_priv(dev);
+	uint16_t val;
+	int ret;
+
+	st->dither_source &= ~AD5766_DITHER_SOURCE_MASK(chan->channel);
+	st->dither_source |= AD5766_DITHER_SOURCE(chan->channel, source);
+
+	val = FIELD_GET(AD5766_LOWER_WORD_SPI_MASK, st->dither_source);
+	ret = ad5766_write(dev, AD5766_CMD_DITHER_SIG_1, val);
+	if (ret)
+		return ret;
+
+	val = FIELD_GET(AD5766_UPPER_WORD_SPI_MASK, st->dither_source);
+
+	return ad5766_write(dev, AD5766_CMD_DITHER_SIG_2, val);
+}
+
+static int ad5766_get_dither_scale(struct iio_dev *dev,
+				   const struct iio_chan_spec *chan)
+{
+	struct ad5766_state *st = iio_priv(dev);
+	u32 scale;
+
+	scale = st->dither_scale & AD5766_DITHER_SCALE_MASK(chan->channel);
+
+	return (scale >> (chan->channel * 2));
+}
+
+static int ad5766_set_dither_scale(struct iio_dev *dev,
+			  const struct iio_chan_spec *chan,
+			  unsigned int scale)
+{
+	int ret;
+	struct ad5766_state *st = iio_priv(dev);
+	uint16_t val;
+
+	st->dither_scale &= ~AD5766_DITHER_SCALE_MASK(chan->channel);
+	st->dither_scale |= AD5766_DITHER_SCALE(chan->channel, scale);
+
+	val = FIELD_GET(AD5766_LOWER_WORD_SPI_MASK, st->dither_scale);
+	ret = ad5766_write(dev, AD5766_CMD_DITHER_SCALE_1, val);
+	if (ret)
+		return ret;
+	val = FIELD_GET(AD5766_UPPER_WORD_SPI_MASK, st->dither_scale);
+
+	return ad5766_write(dev, AD5766_CMD_DITHER_SCALE_2, val);
+}
+
+static const struct iio_enum ad5766_dither_scale_enum = {
+	.items = ad5766_dither_scales,
+	.num_items = ARRAY_SIZE(ad5766_dither_scales),
+	.set = ad5766_set_dither_scale,
+	.get = ad5766_get_dither_scale,
+};
+
+static ssize_t ad5766_read_ext(struct iio_dev *indio_dev,
+			       uintptr_t private,
+			       const struct iio_chan_spec *chan,
+			       char *buf)
+{
+	struct ad5766_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (private) {
+	case AD5766_DITHER_ENABLE:
+		return sprintf(buf, "%u\n",
+			       !(st->dither_enable & BIT(chan->channel)));
+		break;
+	case AD5766_DITHER_INVERT:
+		return sprintf(buf, "%u\n",
+			       !!(st->dither_invert & BIT(chan->channel)));
+		break;
+	case AD5766_DITHER_SOURCE:
+		return sprintf(buf, "%u\n",
+			       ad5766_get_dither_source(indio_dev, chan));
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static ssize_t ad5766_write_ext(struct iio_dev *indio_dev,
+				 uintptr_t private,
+				 const struct iio_chan_spec *chan,
+				 const char *buf, size_t len)
+{
+	struct ad5766_state *st = iio_priv(indio_dev);
+	bool readin;
+	int ret;
+
+	ret = kstrtobool(buf, &readin);
+	if (ret)
+		return ret;
+
+	switch (private) {
+	case AD5766_DITHER_ENABLE:
+		st->dither_enable &= ~AD5766_DITHER_ENABLE_MASK(chan->channel);
+		st->dither_enable |= AD5766_DITHER_ENABLE(chan->channel,
+							  readin);
+		ret = ad5766_write(indio_dev, AD5766_CMD_WR_PWR_DITHER,
+				   st->dither_enable);
+		break;
+	case AD5766_DITHER_INVERT:
+		st->dither_invert &= ~AD5766_DITHER_INVERT_MASK(chan->channel);
+		st->dither_invert |= AD5766_DITHER_INVERT(chan->channel,
+							  readin);
+		ret = ad5766_write(indio_dev, AD5766_CMD_INV_DITHER,
+				   st->dither_invert);
+		break;
+	case AD5766_DITHER_SOURCE:
+		ret = ad5766_set_dither_source(indio_dev, chan, readin);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return ret ? ret : len;
+}
+
+#define _AD5766_CHAN_EXT_INFO(_name, _what, _shared) { \
+	.name = _name, \
+	.read = ad5766_read_ext, \
+	.write = ad5766_write_ext, \
+	.private = _what, \
+	.shared = _shared, \
+}
+
+#define IIO_ENUM_AVAILABLE_SHARED(_name, _shared, _e) \
+{ \
+	.name = (_name "_available"), \
+	.shared = _shared, \
+	.read = iio_enum_available_read, \
+	.private = (uintptr_t)(_e), \
+}
+
+static const struct iio_chan_spec_ext_info ad5766_ext_info[] = {
+
+	_AD5766_CHAN_EXT_INFO("dither_enable", AD5766_DITHER_ENABLE,
+			      IIO_SEPARATE),
+	_AD5766_CHAN_EXT_INFO("dither_invert", AD5766_DITHER_INVERT,
+			      IIO_SEPARATE),
+	_AD5766_CHAN_EXT_INFO("dither_source", AD5766_DITHER_SOURCE,
+			      IIO_SEPARATE),
+	IIO_ENUM("dither_scale", IIO_SEPARATE, &ad5766_dither_scale_enum),
+	IIO_ENUM_AVAILABLE_SHARED("dither_scale",
+				  IIO_SEPARATE,
+				  &ad5766_dither_scale_enum),
+	{}
+};
+
+#define AD576x_CHANNEL(_chan, _bits) {					\
+	.type = IIO_VOLTAGE,						\
+	.indexed = 1,							\
+	.output = 1,							\
+	.channel = (_chan),						\
+	.address = (_chan),						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |		\
+		BIT(IIO_CHAN_INFO_SCALE),				\
+	.scan_type = {							\
+		.sign = 'u',						\
+		.realbits = (_bits),					\
+		.storagebits = 16,					\
+		.shift = 16 - (_bits),					\
+	},								\
+	.ext_info = ad5766_ext_info,					\
+}
+
+#define DECLARE_AD576x_CHANNELS(_name, _bits)			\
+const struct iio_chan_spec _name[] = {				\
+	AD576x_CHANNEL(0, (_bits)),				\
+	AD576x_CHANNEL(1, (_bits)),				\
+	AD576x_CHANNEL(2, (_bits)),				\
+	AD576x_CHANNEL(3, (_bits)),				\
+	AD576x_CHANNEL(4, (_bits)),				\
+	AD576x_CHANNEL(5, (_bits)),				\
+	AD576x_CHANNEL(6, (_bits)),				\
+	AD576x_CHANNEL(7, (_bits)),				\
+	AD576x_CHANNEL(8, (_bits)),				\
+	AD576x_CHANNEL(9, (_bits)),				\
+	AD576x_CHANNEL(10, (_bits)),				\
+	AD576x_CHANNEL(11, (_bits)),				\
+	AD576x_CHANNEL(12, (_bits)),				\
+	AD576x_CHANNEL(13, (_bits)),				\
+	AD576x_CHANNEL(14, (_bits)),				\
+	AD576x_CHANNEL(15, (_bits)),				\
+}
+
+static DECLARE_AD576x_CHANNELS(ad5766_channels, 16);
+static DECLARE_AD576x_CHANNELS(ad5767_channels, 12);
+
+static const struct ad5766_chip_info ad5766_chip_infos[] = {
+	[ID_AD5766] = {
+		.num_channels = ARRAY_SIZE(ad5766_channels),
+		.channels = ad5766_channels,
+	},
+	[ID_AD5767] = {
+		.num_channels = ARRAY_SIZE(ad5767_channels),
+		.channels = ad5767_channels,
+	},
+};
+
+static int ad5766_get_output_range(struct ad5766_state *st)
+{
+	int i, ret, min, max, tmp[2];
+
+	ret = device_property_read_u32_array(&st->spi->dev,
+					     "output-range",
+					     tmp, 2);
+	if (ret)
+		return ret;
+
+	min = tmp[0];
+	max = tmp[1];
+	for (i = 0; i < ARRAY_SIZE(ad5766_span_tbl); i++) {
+		if (ad5766_span_tbl[i].min != min ||
+		    ad5766_span_tbl[i].max != max)
+			continue;
+
+		st->crt_range = i;
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int ad5766_default_setup(struct ad5766_state *st)
+{
+	uint16_t val;
+	int ret, i;
+
+	/* Always issue a reset before writing to the span register. */
+	ret = ad5766_reset(st);
+	if (ret)
+		return ret;
+
+	ret = ad5766_get_output_range(st);
+	if (ret)
+		return ret;
+
+	/* Dither power down */
+	st->dither_enable = GENMASK(15, 0);
+	ret = __ad5766_spi_write(st, AD5766_CMD_WR_PWR_DITHER,
+			     st->dither_enable);
+	if (ret)
+		return ret;
+
+	st->dither_source = 0;
+	for (i = 0; i < ARRAY_SIZE(ad5766_channels); i++)
+		st->dither_source |= AD5766_DITHER_SOURCE(i, 0);
+	val = FIELD_GET(AD5766_LOWER_WORD_SPI_MASK, st->dither_source);
+	ret = __ad5766_spi_write(st, AD5766_CMD_DITHER_SIG_1, val);
+	if (ret)
+		return ret;
+
+	val = FIELD_GET(AD5766_UPPER_WORD_SPI_MASK, st->dither_source);
+	ret = __ad5766_spi_write(st, AD5766_CMD_DITHER_SIG_2, val);
+	if (ret)
+		return ret;
+
+	st->dither_scale = 0;
+	val = FIELD_GET(AD5766_LOWER_WORD_SPI_MASK, st->dither_scale);
+	ret = __ad5766_spi_write(st, AD5766_CMD_DITHER_SCALE_1, val);
+	if (ret)
+		return ret;
+
+	val = FIELD_GET(AD5766_UPPER_WORD_SPI_MASK, st->dither_scale);
+	ret = __ad5766_spi_write(st, AD5766_CMD_DITHER_SCALE_2, val);
+	if (ret)
+		return ret;
+
+	st->dither_invert = 0;
+	ret = __ad5766_spi_write(st, AD5766_CMD_INV_DITHER, st->dither_invert);
+	if (ret)
+		return ret;
+
+	return  __ad5766_spi_write(st, AD5766_CMD_SPAN_REG, st->crt_range);
+}
+
+static int ad5766_probe(struct spi_device *spi)
+{
+	enum ad5766_type type;
+	struct iio_dev *indio_dev;
+	struct ad5766_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	mutex_init(&st->lock);
+
+	st->spi = spi;
+	type = spi_get_device_id(spi)->driver_data;
+	st->chip_info = &ad5766_chip_infos[type];
+
+	indio_dev->channels = st->chip_info->channels;
+	indio_dev->num_channels = st->chip_info->num_channels;
+	indio_dev->info = &ad5766_info;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->dev.of_node = spi->dev.of_node;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	st->gpio_reset = devm_gpiod_get_optional(&st->spi->dev, "reset",
+						GPIOD_OUT_LOW);
+
+	ret = ad5766_default_setup(st);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct of_device_id ad5766_dt_match[] = {
+	{ .compatible = "adi,ad5766" },
+	{ .compatible = "adi,ad5767" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ad5766_dt_match);
+
+static const struct spi_device_id ad5766_spi_ids[] = {
+	{ "ad5766", ID_AD5766 },
+	{ "ad5767", ID_AD5767 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ad5766_spi_ids);
+
+static struct spi_driver ad5766_driver = {
+	.driver = {
+		.name = "ad5766",
+		.of_match_table = ad5766_dt_match,
+	},
+	.probe = ad5766_probe,
+	.id_table = ad5766_spi_ids,
+};
+module_spi_driver(ad5766_driver);
+
+MODULE_AUTHOR("Denis-Gabriel Gheorghescu <denis.gheorghescu@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD5766/AD5767 DACs");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

