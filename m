Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF862D2BC2
	for <lists+linux-iio@lfdr.de>; Tue,  8 Dec 2020 14:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgLHNQK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 8 Dec 2020 08:16:10 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:24678 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726338AbgLHNQK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Dec 2020 08:16:10 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B8DBPbl015642;
        Tue, 8 Dec 2020 08:15:27 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3588090xrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 08:15:27 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0B8DFQ4b049676
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 8 Dec 2020 08:15:26 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 8 Dec 2020 08:15:25 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Tue, 8 Dec 2020 08:15:24 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 8 Dec 2020 08:15:24 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0B8DFKdU000595;
        Tue, 8 Dec 2020 08:15:23 -0500
From:   Cristian Pop <cristian.pop@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, Cristian Pop <cristian.pop@analog.com>
Subject: [PATCH v3 3/3] iio: dac: ad5766: add driver support for AD5766
Date:   Tue, 8 Dec 2020 15:19:57 +0200
Message-ID: <20201208131957.34381-3-cristian.pop@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201208131957.34381-1-cristian.pop@analog.com>
References: <20201208131957.34381-1-cristian.pop@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-08_09:2020-12-08,2020-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1011 priorityscore=1501 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080081
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The AD5766/AD5767 are 16-channel, 16-bit/12-bit, voltage output dense DACs
Digital-to-Analog converters.

This change adds support for these DACs.

Link: https://www.analog.com/media/en/technical-documentation/data-sheets/ad5766-5767.pdf

Signed-off-by: Cristian Pop <cristian.pop@analog.com>
---
 Changelog in v3:
	- Add ABI doc
	- Add build files
	- Fix build, define local macro "IIO_ENUM_AVAILABLE_SHARED"
	- Better description for "lock" variable
	- Use "put_unaligned_xx16"a
	- Rename to: "_ad5766_spi_write" and "_ad5766_spi_read" from 
	  "_ad5766_spi_write" and "_ad5766_spi_read"

 drivers/iio/dac/Kconfig  |  10 +
 drivers/iio/dac/Makefile |   1 +
 drivers/iio/dac/ad5766.c | 766 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 777 insertions(+)
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
index 000000000000..3c634d63a6db
--- /dev/null
+++ b/drivers/iio/dac/ad5766.c
@@ -0,0 +1,766 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices AD5766, AD5767
+ * Digital to Analog Converters driver
+ *
+ * Copyright 2019-2020 Analog Devices Inc.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/iio/iio.h>
+#include <linux/bitfield.h>
+#include <linux/unaligned/be_byteshift.h>
+
+#define AD5766_UPPER_WORD_SPI_MASK		GENMASK(31, 16)
+#define AD5766_LOWER_WORD_SPI_MASK		GENMASK(15, 0)
+#define AD5766_DITHER_SOURCE_MASK(x)		GENMASK(((2 * x) + 1), (2 * x))
+#define AD5766_DITHER_SCALE_MASK(x)		AD5766_DITHER_SOURCE_MASK(x)
+
+#define AD5766_CMD_NOP_MUX_OUT			0x00
+#define AD5766_CMD_SDO_CNTRL			0x01
+#define AD5766_CMD_WR_IN_REG(x)			(0x10 | ((x) & 0xF))
+#define AD5766_CMD_WR_DAC_REG(x)		(0x20 | ((x) & 0xF))
+#define AD5766_CMD_SW_LDAC			0x30
+#define AD5766_CMD_SPAN_REG			0x40
+#define AD5766_CMD_WR_PWR_DITHER		0x51
+#define AD5766_CMD_WR_DAC_REG_ALL		0x60
+#define AD5766_CMD_SW_FULL_RESET		0x70
+#define AD5766_CMD_READBACK_REG(x)		(0x80 | ((x) & 0xF))
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
+	AD5766_VOLTAGE_RANGE_MAX,
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
+	AD5766_DITHER_PWR,
+	AD5766_DITHER_INVERT
+};
+
+/*
+ * External dither signal can be composed with the DAC output, if activated.
+ * The dither signals are applied to the N0 and N1 input pins.
+ * Dither source for each of the channel can be selected by writing to
+ * "dither_source",a 32 bit variable and two bits are used for each of the 16
+ * channels: 0: NO_DITHER, 1: N0, 2: N1.
+ * This variable holds available dither source strings.
+ */
+static const char * const ad5766_dither_sources[] = {
+	"NO_DITHER",
+	"N0",
+	"N1",
+};
+
+/*
+ * Dither signal can also be scaled.
+ * Available dither scale strings coresponding to "dither_scale" field in
+ * "struct ad5766_state".
+ * "dither_scale" is a 32 bit variable and two bits are used for each of the 16
+ * channels: 0: NO_SCALING, 1: 75%_SCALING, 2: 50%_SCALING, 3: 25%_SCALING.
+ */
+static const char * const ad5766_dither_scales[] = {
+	"NO_SCALING",
+	"75%_SCALING",
+	"50%_SCALING",
+	"25%_SCALING",
+};
+
+/**
+ * struct ad5766_state - driver instance specific data
+ * @spi:		SPI device
+ * @lock:		Lock used to restrict concurent access to SPI device
+ * @chip_info:		Chip model specific constants
+ * @gpio_reset:		Reset GPIO, used to reset the device
+ * @crt_range:		Current selected output range
+ * @cached_offset:	Cached range coresponding to the selected offset
+ * @dither_power_ctrl:	Power-down bit for each channel dither block (for
+ *			example, D15 = DAC 15,D8 = DAC 8, and D0 = DAC 0)
+ *			0 - Normal operation, 1 - Power down
+ * @dither_invert:	Inverts the dither signal applied to the selected DAC
+ *			outputs
+ * @dither_source:	Selects between 3 possible sources:
+ *			0: No dither, 1: N0, 2: N1
+ *			Two bits are used for each channel
+ * @dither_scale:	Selects between 4 possible scales:
+ *			0: No scale, 1: 75%, 2: 50%, 3: 25%
+ *			Two bits are used for each channel
+ * @scale_avail:	Scale available table
+ * @offset_avail:	Offest available table
+ * @data:		SPI transfer buffers
+ */
+struct ad5766_state {
+	struct spi_device		*spi;
+	struct mutex			lock;
+	const struct ad5766_chip_info	*chip_info;
+	struct gpio_desc		*gpio_reset;
+	enum ad5766_voltage_range	crt_range;
+	enum ad5766_voltage_range	cached_offset;
+	u16		dither_power_ctrl;
+	u16		dither_invert;
+	u32		dither_source;
+	u32		dither_scale;
+	int		scale_avail[AD5766_VOLTAGE_RANGE_MAX][2];
+	int		offset_avail[AD5766_VOLTAGE_RANGE_MAX][2];
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
+	int ret = 0;
+
+	if (st->gpio_reset) {
+		gpiod_set_value_cansleep(st->gpio_reset, 0);
+		ndelay(100); /* t_reset >= 100ns */
+		gpiod_set_value_cansleep(st->gpio_reset, 1);
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
+static int ad5766_default_setup(struct ad5766_state *st,
+	enum ad5766_voltage_range range)
+{
+	int ret;
+	uint16_t val;
+
+	/* Always issue a software reset before writing to the span register. */
+	ret = ad5766_reset(st);
+	if (ret)
+		return ret;
+
+	ret = __ad5766_spi_write(st, AD5766_CMD_SPAN_REG, range);
+	if (ret)
+		return ret;
+
+	st->crt_range = range;
+	st->cached_offset = range;
+
+	st->dither_power_ctrl = 0;
+	ret = __ad5766_spi_write(st, AD5766_CMD_WR_PWR_DITHER,
+			     st->dither_power_ctrl);
+	if (ret)
+		return ret;
+
+	st->dither_source = 0;
+	val = FIELD_GET(AD5766_LOWER_WORD_SPI_MASK, st->dither_source);
+	ret = __ad5766_spi_write(st, AD5766_CMD_DITHER_SIG_1,
+			  st->dither_source & 0xFFFF);
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
+	return 0;
+}
+
+static int ad5766_set_offset(struct ad5766_state *st, int val, int val2)
+{
+	int i;
+	s32 (*tbl)[AD5766_VOLTAGE_RANGE_MAX][2] = &(st->offset_avail);
+
+	for (i = 0; i < AD5766_VOLTAGE_RANGE_MAX; i++) {
+		if ((*tbl)[i][0] == val && (*tbl)[i][1] == val2) {
+			st->cached_offset = i;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int ad5766_set_scale(struct ad5766_state *st, int val, int val2)
+{
+	int i;
+	enum ad5766_voltage_range offset_idx = st->cached_offset;
+	s32 (*offset_tbl)[AD5766_VOLTAGE_RANGE_MAX][2] = &(st->offset_avail);
+	s32 (*scale_tbl)[AD5766_VOLTAGE_RANGE_MAX][2] = &(st->scale_avail);
+
+	for (i = 0; i < AD5766_VOLTAGE_RANGE_MAX; i++) {
+		if ((*scale_tbl)[i][0] != val || (*scale_tbl)[i][1] != val2)
+			continue;
+
+		if ((*offset_tbl)[i][0] != (*offset_tbl)[offset_idx][0] ||
+			(*offset_tbl)[i][1] != (*offset_tbl)[offset_idx][1])
+			continue;
+
+		return ad5766_default_setup(st, i);
+	}
+
+	return -EINVAL;
+}
+
+static int ad5766_read_avail(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan,
+				 const int **vals, int *type, int *length,
+				 long mask)
+{
+	struct ad5766_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (const int *)st->scale_avail;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		/* Values are stored in a 2D matrix  */
+		*length = AD5766_VOLTAGE_RANGE_MAX * 2;
+
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_OFFSET:
+		*vals = (const int *)st->offset_avail;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		/* Values are stored in a 2D matrix  */
+		*length = AD5766_VOLTAGE_RANGE_MAX * 2;
+
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad5766_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val,
+			   int *val2,
+			   long m)
+{
+	int ret;
+	struct ad5766_state *st = iio_priv(indio_dev);
+
+	switch (m) {
+	case IIO_CHAN_INFO_RAW:
+		ret = ad5766_read(indio_dev, chan->address, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = st->scale_avail[st->crt_range][0];
+		*val2 = st->scale_avail[st->crt_range][1];
+
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	case IIO_CHAN_INFO_OFFSET:
+		*val = st->offset_avail[st->crt_range][0];
+		*val2 = st->offset_avail[st->crt_range][1];
+
+		return IIO_VAL_INT_PLUS_MICRO;
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
+	struct ad5766_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+	{
+		const int max_val = (1 << chan->scan_type.realbits);
+
+		if (val >= max_val || val < 0)
+			return -EINVAL;
+		val <<= chan->scan_type.shift;
+		return ad5766_write(indio_dev, chan->address, val);
+	}
+	case IIO_CHAN_INFO_OFFSET:
+		return ad5766_set_offset(st, val, val2);
+	case IIO_CHAN_INFO_SCALE:
+		return ad5766_set_scale(st, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info ad5766_info = {
+	.read_raw = ad5766_read_raw,
+	.write_raw = ad5766_write_raw,
+	.read_avail = ad5766_read_avail,
+};
+
+static int ad5766_get_dither_source(struct iio_dev *dev,
+				    const struct iio_chan_spec *chan)
+{
+	struct ad5766_state *st = iio_priv(dev);
+	u32 source;
+
+	source = st->dither_source & AD5766_DITHER_SOURCE_MASK(chan->channel);
+
+	return (source >> chan->channel * 2);
+}
+
+static int ad5766_set_dither_source(struct iio_dev *dev,
+			  const struct iio_chan_spec *chan,
+			  unsigned int mode)
+{
+	int ret;
+	struct ad5766_state *st = iio_priv(dev);
+	uint16_t val;
+
+	st->dither_source &= ~AD5766_DITHER_SOURCE_MASK(chan->channel);
+	st->dither_source |= (mode << (chan->channel * 2));
+
+	val = FIELD_GET(AD5766_LOWER_WORD_SPI_MASK, st->dither_source);
+	ret = ad5766_write(dev, AD5766_CMD_DITHER_SIG_1, val);
+	if (ret)
+		return ret;
+
+	val = FIELD_GET(AD5766_UPPER_WORD_SPI_MASK, st->dither_source);
+	return ad5766_write(dev, AD5766_CMD_DITHER_SIG_2, val);
+}
+
+static const struct iio_enum ad5766_dither_source_enum = {
+	.items = ad5766_dither_sources,
+	.num_items = ARRAY_SIZE(ad5766_dither_sources),
+	.set = ad5766_set_dither_source,
+	.get = ad5766_get_dither_source,
+};
+
+static int ad5766_get_dither_scale(struct iio_dev *dev,
+				   const struct iio_chan_spec *chan)
+{
+	struct ad5766_state *st = iio_priv(dev);
+	u32 scale;
+
+	scale = st->dither_scale & AD5766_DITHER_SCALE_MASK(chan->channel);
+
+	return (scale >> chan->channel * 2);
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
+	st->dither_scale |= (scale << (chan->channel * 2));
+
+	val = FIELD_GET(AD5766_LOWER_WORD_SPI_MASK, st->dither_scale);
+	ret = ad5766_write(dev, AD5766_CMD_DITHER_SCALE_1, val);
+	if (ret)
+		return ret;
+
+	val = FIELD_GET(AD5766_UPPER_WORD_SPI_MASK, st->dither_scale);
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
+	int ret;
+	struct ad5766_state *st = iio_priv(indio_dev);
+
+	switch ((u32)private) {
+	case AD5766_DITHER_PWR:
+		return sprintf(buf, "%u\n", 0x01 &
+			       ~(st->dither_power_ctrl >> chan->channel));
+		break;
+	case AD5766_DITHER_INVERT:
+		return sprintf(buf, "%u\n", 0x01 &
+			       (st->dither_invert >> chan->channel));
+		break;
+	default:
+		ret = -EINVAL;
+		break;
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
+	bool readin;
+	int ret;
+	struct ad5766_state *st = iio_priv(indio_dev);
+
+	ret = kstrtobool(buf, &readin);
+	if (ret)
+		return ret;
+
+	switch ((u32)private) {
+	case AD5766_DITHER_PWR:
+		ret = kstrtobool(buf, &readin);
+		if (ret)
+			break;
+		readin = !readin;
+		st->dither_power_ctrl = (st->dither_power_ctrl &
+					 ~BIT(chan->channel)) |
+					 (readin << chan->channel);
+		ret = ad5766_write(indio_dev, AD5766_CMD_WR_PWR_DITHER,
+			     st->dither_power_ctrl);
+		break;
+	case AD5766_DITHER_INVERT:
+		st->dither_invert = (st->dither_invert &
+						~BIT(chan->channel)) |
+						(readin << chan->channel);
+		ret = ad5766_write(indio_dev, AD5766_CMD_INV_DITHER,
+				st->dither_power_ctrl);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
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
+	_AD5766_CHAN_EXT_INFO("dither_pwr", AD5766_DITHER_PWR, IIO_SEPARATE),
+	_AD5766_CHAN_EXT_INFO("dither_invert", AD5766_DITHER_INVERT,
+			      IIO_SEPARATE),
+	IIO_ENUM("dither_source", IIO_SEPARATE, &ad5766_dither_source_enum),
+	IIO_ENUM_AVAILABLE_SHARED("dither_source",
+				  IIO_SEPARATE,
+				  &ad5766_dither_source_enum),
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
+	.info_mask_shared_by_type_available =				\
+		BIT(IIO_CHAN_INFO_OFFSET) | BIT(IIO_CHAN_INFO_SCALE),	\
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
+static void ad5766_init_scale_tables(struct ad5766_state *st)
+{
+	int i;
+	s32 denom;
+	s64 offset;
+	u64 scale;
+	u8 realbits = st->chip_info->channels[0].scan_type.realbits;
+
+	for (i = 0; i < AD5766_VOLTAGE_RANGE_MAX; i++) {
+		offset = (1 << realbits) * ad5766_span_tbl[i].min;
+		denom = ad5766_span_tbl[i].max - ad5766_span_tbl[i].min;
+		offset = div_s64(offset * 1000000, denom);
+		st->offset_avail[i][0] = div_s64(offset, 1000000);
+		div_s64_rem(offset, 1000000, &st->offset_avail[i][1]);
+
+		scale = ad5766_span_tbl[i].max - ad5766_span_tbl[i].min;
+		scale = div_u64((scale * 1000000000), (1 << realbits));
+		st->scale_avail[i][0] = (int)div_u64(scale, 1000000);
+		div_s64_rem(scale, 1000000, &st->scale_avail[i][1]);
+	}
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
+						GPIOD_OUT_HIGH);
+
+	ad5766_init_scale_tables(st);
+
+	ret = ad5766_default_setup(st, AD5766_VOLTAGE_RANGE_M5V_to_5V);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct of_device_id ad5766_dt_match[] = {
+	{ .compatible = "adi,ad5766" },
+	{ .compatible = "adi,ad5767" },
+	{},
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

