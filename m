Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A85D154118
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 10:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbgBFJYA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 04:24:00 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:23532 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728380AbgBFJX7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2020 04:23:59 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0169BvxZ019310;
        Thu, 6 Feb 2020 04:23:58 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xyhnkm4cx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 04:23:57 -0500
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0169NuZZ025763
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 6 Feb 2020 04:23:56 -0500
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 6 Feb 2020
 04:23:55 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 6 Feb 2020 01:23:55 -0800
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.175])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0169NoIo010043;
        Thu, 6 Feb 2020 04:23:52 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH 1/2] iio: dac: ad5770r: Add AD5770R support
Date:   Thu, 6 Feb 2020 11:23:12 +0200
Message-ID: <20200206092313.18265-2-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206092313.18265-1-alexandru.tachici@analog.com>
References: <20200206092313.18265-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-05_06:2020-02-04,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002060073
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The AD5770R is a 6-channel, 14-bit resolution, low noise, programmable
current output digital-to-analog converter (DAC) for photonics control
applications.

It contains five 14-bit resolution current sourcing DAC channels and one
14-bit resolution current sourcing/sinking DAC channel.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/iio/dac/Kconfig                 |  10 +
 drivers/iio/dac/Makefile                |   1 +
 drivers/iio/dac/ad5770r.c               | 662 ++++++++++++++++++++++++
 include/linux/iio/common/adi_spi_regs.h |  44 ++
 4 files changed, 717 insertions(+)
 create mode 100644 drivers/iio/dac/ad5770r.c
 create mode 100644 include/linux/iio/common/adi_spi_regs.h

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 979070196da9..c74f2151ee42 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -208,6 +208,16 @@ config AD5764
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5764.
 
+config AD5770R
+	tristate "Analog Devices AD5770R IDAC driver"
+	depends on SPI_MASTER
+	help
+	  Say yes here to build support for Analog Devices AD5770R Digital to
+	  Analog Converter.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad5770r.
+
 config AD5791
 	tristate "Analog Devices AD5760/AD5780/AD5781/AD5790/AD5791 DAC SPI driver"
 	depends on SPI
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 1369fa1d2f0e..2fc481167724 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_AD5755) += ad5755.o
 obj-$(CONFIG_AD5755) += ad5758.o
 obj-$(CONFIG_AD5761) += ad5761.o
 obj-$(CONFIG_AD5764) += ad5764.o
+obj-$(CONFIG_AD5770R) += ad5770r.o
 obj-$(CONFIG_AD5791) += ad5791.o
 obj-$(CONFIG_AD5686) += ad5686.o
 obj-$(CONFIG_AD5686_SPI) += ad5686-spi.o
diff --git a/drivers/iio/dac/ad5770r.c b/drivers/iio/dac/ad5770r.c
new file mode 100644
index 000000000000..a8b2c1850ffd
--- /dev/null
+++ b/drivers/iio/dac/ad5770r.c
@@ -0,0 +1,662 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * AD5770R Digital to analog converters driver
+ *
+ * Copyright 2018 Analog Devices Inc.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iio/common/adi_spi_regs.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+
+/* AD5770R configuration registers */
+#define AD5770R_CHANNEL_CONFIG		0x14
+#define AD5770R_OUTPUT_RANGE(ch)	(0x15 + (ch))
+#define AD5770R_FILTER_RESISTOR(ch)	(0x1D + (ch))
+#define AD5770R_REFERENCE		0x1B
+#define AD5770R_DAC_LSB(ch)		(0x26 + 2 * (ch))
+#define AD5770R_DAC_MSB(ch)		(0x27 + 2 * (ch))
+#define AD5770R_CH_SELECT		0x34
+#define AD5770R_CH_ENABLE		0x44
+
+/* AD5770R_CHANNEL_CONFIG */
+#define AD5770R_CFG_CH0_SINK_EN(x)		(((x) & 0x1) << 7)
+#define AD5770R_CFG_SHUTDOWN_B(x, ch)		(((x) & 0x1) << (ch))
+
+/* AD5770R_OUTPUT_RANGE */
+#define AD5770R_RANGE_OUTPUT_SCALING(x)		(((x) & 0x3F) << 2)
+#define AD5770R_RANGE_MODE(x)			((x) & 0x03)
+
+/* AD5770R_REFERENCE */
+#define AD5770R_REF_RESISTOR_SEL(x)		(((x) & 0x1) << 2)
+#define AD5770R_REF_SEL(x)			(((x) & 0x3) << 0)
+
+/* AD5770R_CH_ENABLE */
+#define AD5770R_CH_SET(x, channel)		(((x) & 0x1) << (channel))
+
+#define AD5770R_MAX_CHANNELS	6
+#define AD5770R_MAX_CH_MODES	14
+#define AD5770R_LOW_VREF_mV	1250
+#define AD5770R_HIGH_VREF_mV	2500
+
+enum ad5770r_ch0_modes {
+	AD5770R_CH0_0_300 = 0,
+	AD5770R_CH0_NEG_60_0,
+	AD5770R_CH0_NEG_60_300
+};
+
+enum ad5770r_ch1_modes {
+	AD5770R_CH1_0_140_LOW_HEAD = 1,
+	AD5770R_CH1_0_140_LOW_NOISE,
+	AD5770R_CH1_0_250
+};
+
+enum ad5770r_ch2_5_modes {
+	AD5770R_CH_LOW_RANGE = 0,
+	AD5770R_CH_HIGH_RANGE
+};
+
+enum ad5770r_ref_v {
+	AD5770R_EXT_2_5_V = 0,
+	AD5770R_INT_1_25_V_OUT_ON,
+	AD5770R_EXT_1_25_V,
+	AD5770R_INT_1_25_V_OUT_OFF
+};
+
+enum ad5770r_output_filter_resistor {
+	AD5770R_FILTER_60_OHM = 0x0,
+	AD5770R_FILTER_5_6_KOHM = 0x5,
+	AD5770R_FILTER_11_2_KOHM,
+	AD5770R_FILTER_22_2_KOHM,
+	AD5770R_FILTER_44_4_KOHM,
+	AD5770R_FILTER_104_KOHM,
+};
+
+struct ad5770r_out_range {
+	u8	out_scale;
+	u8	out_range_mode;
+};
+
+/**
+ * struct ad5770R_state - driver instance specific data
+ * @spi:		spi_device
+ * @regmap:		regmap
+ * @vref_reg:		fixed regulator for reference configuration
+ * @gpio_reset:		gpio descriptor
+ * @output_mode:		array contains channels output ranges
+ * @vref:		reference value
+ * @ch_pwr_down:		powerdown flags
+ * @internal_ref:	internal reference flag
+ * @external_res:	external 2.5k resistor flag
+ */
+struct ad5770r_state {
+	struct spi_device		*spi;
+	struct regmap			*regmap;
+	struct regulator		*vref_reg;
+	struct gpio_desc		*gpio_reset;
+	struct ad5770r_out_range	output_mode[AD5770R_MAX_CHANNELS];
+	int				vref;
+	bool				ch_pwr_down[AD5770R_MAX_CHANNELS];
+	bool				internal_ref;
+	bool				external_res;
+};
+
+static const struct regmap_config ad5770r_spi_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.read_flag_mask = BIT(7),
+};
+
+struct ad5770r_output_modes {
+	unsigned int ch;
+	u8 mode;
+	int min;
+	int max;
+};
+
+static struct ad5770r_output_modes ad5770r_rng_tbl[] = {
+	{ 0, AD5770R_CH0_0_300, 0, 300 },
+	{ 0, AD5770R_CH0_NEG_60_0, -60, 0 },
+	{ 0, AD5770R_CH0_NEG_60_300, -60, 300 },
+	{ 1, AD5770R_CH1_0_140_LOW_HEAD, 0, 140 },
+	{ 1, AD5770R_CH1_0_140_LOW_NOISE, 0, 140 },
+	{ 1, AD5770R_CH1_0_250, 0, 250 },
+	{ 2, AD5770R_CH_LOW_RANGE, 0, 55 },
+	{ 2, AD5770R_CH_HIGH_RANGE, 0, 150 },
+	{ 3, AD5770R_CH_LOW_RANGE, 0, 45 },
+	{ 3, AD5770R_CH_HIGH_RANGE, 0, 100 },
+	{ 4, AD5770R_CH_LOW_RANGE, 0, 45 },
+	{ 4, AD5770R_CH_HIGH_RANGE, 0, 100 },
+	{ 5, AD5770R_CH_LOW_RANGE, 0, 45 },
+	{ 5, AD5770R_CH_HIGH_RANGE, 0, 100 },
+};
+
+static const unsigned int ad5770r_filter_freqs[] = {
+	153, 357, 715, 1400, 2800, 262000,
+};
+
+static const unsigned int ad5770r_filter_reg_vals[] = {
+	AD5770R_FILTER_104_KOHM,
+	AD5770R_FILTER_44_4_KOHM,
+	AD5770R_FILTER_22_2_KOHM,
+	AD5770R_FILTER_11_2_KOHM,
+	AD5770R_FILTER_5_6_KOHM,
+	AD5770R_FILTER_60_OHM
+};
+
+static int ad5770r_set_output_mode(struct ad5770r_state *st,
+				   const struct ad5770r_out_range *out_mode,
+				   int channel)
+{
+	unsigned int regval;
+
+	regval = AD5770R_RANGE_OUTPUT_SCALING(out_mode->out_scale) |
+		 AD5770R_RANGE_MODE(out_mode->out_range_mode);
+
+	return regmap_write(st->regmap,
+			    AD5770R_OUTPUT_RANGE(channel), regval);
+}
+
+static int ad5770r_set_reference(struct ad5770r_state *st)
+{
+	unsigned int regval = 0;
+
+	regval = AD5770R_REF_RESISTOR_SEL(st->external_res);
+
+	if (st->internal_ref) {
+		regval |= AD5770R_REF_SEL(AD5770R_INT_1_25_V_OUT_OFF);
+	} else {
+		switch (st->vref) {
+		case AD5770R_LOW_VREF_mV:
+			regval |= AD5770R_REF_SEL(AD5770R_EXT_1_25_V);
+			break;
+		case AD5770R_HIGH_VREF_mV:
+			regval |= AD5770R_REF_SEL(AD5770R_EXT_2_5_V);
+			break;
+		default:
+			regval = AD5770R_REF_SEL(AD5770R_INT_1_25_V_OUT_OFF);
+			break;
+		}
+	}
+
+	return regmap_write(st->regmap, AD5770R_REFERENCE, regval);
+}
+
+static int ad5770r_soft_reset(struct ad5770r_state *st)
+{
+	return regmap_write(st->regmap, ADI_SPI_IF_CONFIG_A,
+			    ADI_SPI_IF_SW_RESET_SEL(1));
+}
+
+static int ad5770r_reset(struct ad5770r_state *st)
+{
+	/* Perform software reset if no GPIO provided */
+	if (!st->gpio_reset)
+		return ad5770r_soft_reset(st);
+
+	gpiod_set_value_cansleep(st->gpio_reset, 0);
+	usleep_range(10, 20);
+	gpiod_set_value_cansleep(st->gpio_reset, 1);
+
+	/* data must not be written during reset timeframe */
+	usleep_range(100, 200);
+
+	return 0;
+}
+
+static int ad5770r_get_range(struct ad5770r_state *st,
+			     int ch, int *min, int *max)
+{
+	int i;
+	u8 tbl_ch, tbl_mode, out_range;
+
+	out_range = st->output_mode[ch].out_range_mode;
+
+	for (i = 0; i < AD5770R_MAX_CH_MODES; i++) {
+		tbl_ch = ad5770r_rng_tbl[i].ch;
+		tbl_mode = ad5770r_rng_tbl[i].mode;
+		if (tbl_ch == ch && tbl_mode == out_range) {
+			*min = ad5770r_rng_tbl[i].min;
+			*max = ad5770r_rng_tbl[i].max;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int ad5770r_get_filter_freq(struct iio_dev *indio_dev,
+				   const struct iio_chan_spec *chan, int *freq)
+{
+	struct ad5770r_state *st = iio_priv(indio_dev);
+	int ret;
+	unsigned int regval, i;
+
+	ret = regmap_read(st->regmap,
+			  AD5770R_FILTER_RESISTOR(chan->channel), &regval);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(ad5770r_filter_reg_vals); i++)
+		if (regval == ad5770r_filter_reg_vals[i])
+			break;
+	if (i == ARRAY_SIZE(ad5770r_filter_reg_vals))
+		return -EINVAL;
+
+	*freq = ad5770r_filter_freqs[i];
+
+	return IIO_VAL_INT;
+}
+
+static int ad5770r_set_filter_freq(struct iio_dev *indio_dev,
+				   const struct iio_chan_spec *chan,
+				   unsigned int freq)
+{
+	struct ad5770r_state *st = iio_priv(indio_dev);
+	unsigned int regval, i;
+
+	for (i = 0; i < ARRAY_SIZE(ad5770r_filter_freqs); i++)
+		if (ad5770r_filter_freqs[i] >= freq)
+			break;
+	if (i == ARRAY_SIZE(ad5770r_filter_freqs))
+		return -EINVAL;
+
+	regval = ad5770r_filter_reg_vals[i];
+
+	return regmap_write(st->regmap, AD5770R_FILTER_RESISTOR(chan->channel),
+			    regval);
+}
+
+static int ad5770r_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long info)
+{
+	struct ad5770r_state *st = iio_priv(indio_dev);
+	int max, min, ret;
+	__le16 buf16;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_bulk_read(st->regmap,
+				       chan->address,
+				       &buf16, 2);
+		if (ret)
+			return 0;
+		*val = le16_to_cpu(buf16) >> 2;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		ret = ad5770r_get_range(st, chan->channel, &min, &max);
+		if (ret < 0)
+			return ret;
+		*val = max - min;
+		/* There is no sign bit. (negative current is mapped from 0)
+		 * (sourced/sinked) current = raw * scale + offset
+		 * where offset in case of CH0 can be negative.
+		 */
+		*val2 = 14;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		return ad5770r_get_filter_freq(indio_dev, chan, val);
+	case IIO_CHAN_INFO_OFFSET:
+		ret = ad5770r_get_range(st, chan->channel, &min, &max);
+		if (ret < 0)
+			return ret;
+		*val = min;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad5770r_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long info)
+{
+	struct ad5770r_state *st = iio_priv(indio_dev);
+	u8 buf[2];
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		buf[0] = ((u16)val >> 6);
+		buf[1] = (val & 0x3F) << 2;
+		return regmap_bulk_write(st->regmap, chan->address,
+					 buf, ARRAY_SIZE(buf));
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		return ad5770r_set_filter_freq(indio_dev, chan, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad5770r_read_freq_avail(struct iio_dev *indio_dev,
+				   struct iio_chan_spec const *chan,
+				   const int **vals, int *type, int *length,
+				   long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		*type = IIO_VAL_INT;
+		*vals = ad5770r_filter_freqs;
+		*length = ARRAY_SIZE(ad5770r_filter_freqs);
+		return IIO_AVAIL_LIST;
+	}
+
+	return -EINVAL;
+}
+
+static int ad5770r_reg_access(struct iio_dev *indio_dev,
+			      unsigned int reg,
+			      unsigned int writeval,
+			      unsigned int *readval)
+{
+	struct ad5770r_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+	else
+		return regmap_write(st->regmap, reg, writeval);
+}
+
+static const struct iio_info ad5770r_info = {
+	.read_raw = ad5770r_read_raw,
+	.write_raw = ad5770r_write_raw,
+	.read_avail = ad5770r_read_freq_avail,
+	.debugfs_reg_access = &ad5770r_reg_access,
+};
+
+static int ad5770r_store_output_range(struct ad5770r_state *st,
+				      int min, int max, int index)
+{
+	int i;
+
+	for (i = 0; i < AD5770R_MAX_CH_MODES; i++) {
+		if (ad5770r_rng_tbl[i].ch != index)
+			continue;
+		if (ad5770r_rng_tbl[i].min != min ||
+		    ad5770r_rng_tbl[i].max != max)
+			continue;
+		st->output_mode[index].out_range_mode = ad5770r_rng_tbl[i].mode;
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static ssize_t ad5770r_read_dac_powerdown(struct iio_dev *indio_dev,
+					  uintptr_t private,
+					  const struct iio_chan_spec *chan,
+					  char *buf)
+{
+	struct ad5770r_state *st = iio_priv(indio_dev);
+
+	return sprintf(buf, "%d\n", st->ch_pwr_down[chan->channel]);
+}
+
+static ssize_t ad5770r_write_dac_powerdown(struct iio_dev *indio_dev,
+					   uintptr_t private,
+					   const struct iio_chan_spec *chan,
+					   const char *buf, size_t len)
+{
+	struct ad5770r_state *st = iio_priv(indio_dev);
+	unsigned int regval;
+	unsigned int mask;
+	bool readin;
+	int ret;
+
+	ret = kstrtobool(buf, &readin);
+	if (ret)
+		return ret;
+
+	readin = !readin;
+
+	regval = AD5770R_CFG_SHUTDOWN_B(readin, chan->channel);
+	if (chan->channel == 0 &&
+	    st->output_mode[0].out_range_mode > AD5770R_CH0_0_300) {
+		regval |= AD5770R_CFG_CH0_SINK_EN(readin);
+		mask = BIT(chan->channel) + BIT(7);
+	} else {
+		mask = BIT(chan->channel);
+	}
+	ret = regmap_update_bits(st->regmap, AD5770R_CHANNEL_CONFIG, mask,
+				 regval);
+	if (ret)
+		return ret;
+
+	regval = AD5770R_CH_SET(readin, chan->channel);
+	ret = regmap_update_bits(st->regmap, AD5770R_CH_ENABLE,
+				 BIT(chan->channel), regval);
+	if (ret)
+		return ret;
+
+	st->ch_pwr_down[chan->channel] = !readin;
+
+	return len;
+}
+
+static const struct iio_chan_spec_ext_info ad5770r_ext_info[] = {
+	{
+		.name = "powerdown",
+		.read = ad5770r_read_dac_powerdown,
+		.write = ad5770r_write_dac_powerdown,
+		.shared = IIO_SEPARATE,
+	},
+	{ }
+};
+
+#define AD5770R_IDAC_CHANNEL(index, reg) {				\
+	.type = IIO_CURRENT,						\
+	.address = reg,							\
+	.indexed = 1,							\
+	.channel = index,						\
+	.output = 1,							\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
+		BIT(IIO_CHAN_INFO_SCALE) |				\
+		BIT(IIO_CHAN_INFO_OFFSET) |				\
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\
+	.info_mask_shared_by_type_available =				\
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),	\
+	.ext_info = ad5770r_ext_info,					\
+}
+
+static const struct iio_chan_spec ad5770r_channels[] = {
+	AD5770R_IDAC_CHANNEL(0, AD5770R_DAC_MSB(0)),
+	AD5770R_IDAC_CHANNEL(1, AD5770R_DAC_MSB(1)),
+	AD5770R_IDAC_CHANNEL(2, AD5770R_DAC_MSB(2)),
+	AD5770R_IDAC_CHANNEL(3, AD5770R_DAC_MSB(3)),
+	AD5770R_IDAC_CHANNEL(4, AD5770R_DAC_MSB(4)),
+	AD5770R_IDAC_CHANNEL(5, AD5770R_DAC_MSB(5)),
+};
+
+static int ad5770r_channel_config(struct ad5770r_state *st)
+{
+	int ret, tmp[2], min, max;
+	unsigned int num;
+	struct fwnode_handle *child;
+
+	num = device_get_child_node_count(&st->spi->dev);
+	if (num != AD5770R_MAX_CHANNELS)
+		return -EINVAL;
+
+	device_for_each_child_node(&st->spi->dev, child) {
+		ret = fwnode_property_read_u32(child, "num", &num);
+		if (ret)
+			return ret;
+		if (num > AD5770R_MAX_CHANNELS)
+			return -EINVAL;
+
+		ret = fwnode_property_read_u32_array(child,
+						     "adi,range-microamp",
+						     tmp, 2);
+		if (ret)
+			return ret;
+
+		min = tmp[0] / 1000;
+		max = tmp[1] / 1000;
+		ret = ad5770r_store_output_range(st, min, max, num);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+static int ad5770r_init(struct ad5770r_state *st)
+{
+	int ret, i;
+
+	st->gpio_reset = devm_gpiod_get_optional(&st->spi->dev, "reset",
+						 GPIOD_OUT_HIGH);
+	if (IS_ERR(st->gpio_reset))
+		return PTR_ERR(st->gpio_reset);
+
+	/* Perform a reset */
+	ret = ad5770r_reset(st);
+	if (ret)
+		return ret;
+
+	/* Set output range */
+	ret = ad5770r_channel_config(st);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < AD5770R_MAX_CHANNELS; i++) {
+		ret = ad5770r_set_output_mode(st,  &st->output_mode[i], i);
+		if (ret)
+			return ret;
+	}
+
+	st->external_res = fwnode_property_read_bool(st->spi->dev.fwnode,
+						     "adi,external-resistor");
+
+	ret = ad5770r_set_reference(st);
+	if (ret)
+		return ret;
+
+	/* Set outputs off */
+	ret = regmap_write(st->regmap, AD5770R_CHANNEL_CONFIG, 0x00);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD5770R_CH_ENABLE, 0x00);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < AD5770R_MAX_CHANNELS; i++)
+		st->ch_pwr_down[i] = true;
+
+	return ret;
+}
+
+static void ad5770r_disable_regulator(void *data)
+{
+	struct spi_device *spi = (struct spi_device *)data;
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct ad5770r_state *st = iio_priv(indio_dev);
+
+	if (st->vref_reg)
+		regulator_disable(st->vref_reg);
+}
+
+static int ad5770r_probe(struct spi_device *spi)
+{
+	struct ad5770r_state *st;
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	spi_set_drvdata(spi, indio_dev);
+
+	st->spi = spi;
+
+	regmap = devm_regmap_init_spi(spi, &ad5770r_spi_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&spi->dev, "Error initializing spi regmap: %ld\n",
+			PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+	st->regmap = regmap;
+
+	ret = devm_add_action_or_reset(&spi->dev, ad5770r_disable_regulator,
+				       st);
+	if (ret < 0)
+		return ret;
+
+	st->vref_reg = devm_regulator_get_optional(&spi->dev, "vref");
+	if (!IS_ERR(st->vref_reg)) {
+		ret = regulator_enable(st->vref_reg);
+		if (ret) {
+			dev_err(&spi->dev,
+				"Failed to enable vref regulators: %d\n", ret);
+			return ret;
+		}
+
+		ret = regulator_get_voltage(st->vref_reg);
+		if (ret < 0)
+			return ret;
+
+		st->vref = ret / 1000;
+	} else {
+		if (PTR_ERR(st->vref_reg) == -ENODEV) {
+			st->vref = AD5770R_LOW_VREF_mV;
+			st->internal_ref = true;
+		} else {
+			return PTR_ERR(st->vref_reg);
+		}
+	}
+
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->info = &ad5770r_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ad5770r_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad5770r_channels);
+
+	ret = ad5770r_init(st);
+	if (ret < 0) {
+		dev_err(&spi->dev, "AD5770R init failed\n");
+		return ret;
+	}
+
+	return devm_iio_device_register(&st->spi->dev, indio_dev);
+}
+
+static const struct of_device_id ad5770r_of_id[] = {
+	{ .compatible = "adi,ad5770r", },
+};
+MODULE_DEVICE_TABLE(of, ad5770r_of_id);
+
+static const struct spi_device_id ad5770r_id[] = {
+	{ "ad5770r", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ad5770r_id);
+
+static struct spi_driver ad5770r_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = of_match_ptr(ad5770r_of_id),
+	},
+	.probe = ad5770r_probe,
+	.id_table = ad5770r_id,
+};
+
+module_spi_driver(ad5770r_driver);
+
+MODULE_AUTHOR("Mircea Caprioru <mircea.caprioru@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD5770R IDAC");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/iio/common/adi_spi_regs.h b/include/linux/iio/common/adi_spi_regs.h
new file mode 100644
index 000000000000..1fc3bfc7845d
--- /dev/null
+++ b/include/linux/iio/common/adi_spi_regs.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Common Analog Devices SPI configuration registers
+ *
+ * Copyright 2019 Analog Devices Inc.
+ */
+
+#ifndef _ADI_SPI_REGS_H_
+#define _ADI_SPI_REGS_H_
+
+#include <linux/bits.h>
+
+#define ADI_SPI_IF_CONFIG_A		0x00
+#define ADI_SPI_IF_CONFIG_B		0x01
+#define ADI_SPI_IF_DEVICE_CONFIG	0x02
+#define ADI_SPI_IF_CHIP_TYPE		0x03
+#define ADI_SPI_IF_PRODUCT_ID_L		0x04
+#define ADI_SPI_IF_PRODUCT_ID_H		0x05
+#define ADI_SPI_IF_CHIP_GRADE		0x06
+#define ADI_SPI_IF_SCRACTH_PAD		0x0A
+#define ADI_SPI_IF_SPI_REVISION		0x0B
+#define ADI_SPI_IF_SPI_VENDOR_L		0x0C
+#define ADI_SPI_IF_SPI_VENDOR_H		0x0D
+#define ADI_SPI_IF_SPI_STREAM_MODE	0x0E
+#define ADI_SPI_IF_CONFIG_C		0x10
+#define ADI_SPI_IF_STATUS_A		0x11
+
+/* ADI_SPI_IF_CONFIG_A */
+#define ADI_SPI_IF_SW_RESET_MSK		(BIT(0) | BIT(7))
+#define ADI_SPI_IF_SW_RESET_SEL(x)	((x) & ADI_SPI_IF_SW_RESET_MSK)
+#define ADI_SPI_IF_ADDR_ASC_MSK		(BIT(2) | BIT(5))
+#define ADI_SPI_IF_ADDR_ASC_SEL(x)	(((x) << 2) & ADI_SPI_IF_ADDR_ASC_MSK)
+
+/* ADI_SPI_IF_CONFIG_B */
+#define ADI_SPI_IF_SINGLE_INS_MSK	BIT(7)
+#define ADI_SPI_IF_SINGLE_INS_SEL(x)	FIELD_PREP(ADI_SPI_IF_SINGLE_INS_MSK, x)
+#define ADI_SPI_IF_SHORT_INS_MSK	BIT(7)
+#define ADI_SPI_IF_SHORT_INS_SEL(x)	FIELD_PREP(ADI_SPI_IF_SINGLE_INS_MSK, x)
+
+/* ADI_SPI_IF_CONFIG_C */
+#define ADI_SPI_IF_STRICT_REG_MSK	BIT(5)
+#define ADI_SPI_IF_STRICT_REG_GET(x)	FIELD_GET(ADI_SPI_IF_STRICT_REG_MSK, x)
+
+#endif /* _ADI_SPI_REGS_H_ */
-- 
2.20.1

