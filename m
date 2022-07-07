Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D43D569D7C
	for <lists+linux-iio@lfdr.de>; Thu,  7 Jul 2022 10:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234797AbiGGIcE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 7 Jul 2022 04:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbiGGIcD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 7 Jul 2022 04:32:03 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B190B4D4C3
        for <linux-iio@vger.kernel.org>; Thu,  7 Jul 2022 01:32:01 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2677dQl8012215;
        Thu, 7 Jul 2022 04:31:56 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3h5u9s09aa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Jul 2022 04:31:56 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 2678Vq7J044802
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jul 2022 04:31:54 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 7 Jul 2022 04:31:53 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 7 Jul 2022 04:31:53 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 7 Jul 2022 04:31:53 -0400
Received: from euswvd-wpr-708.reddog.microsoft.com ([10.140.226.204])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2678VhIo015236;
        Thu, 7 Jul 2022 04:31:45 -0400
From:   Ibrahim Tilki <Ibrahim.Tilki@analog.com>
To:     <jic23@kernel.org>, <andy.shevchenko@gmail.com>
CC:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        <linux-iio@vger.kernel.org>, <Nuno.Sa@analog.com>,
        <Nurettin.Bolucu@analog.com>
Subject: [PATCH v2 1/3] iio: adc: add max11410 adc driver
Date:   Thu, 7 Jul 2022 08:31:24 +0000
Message-ID: <20220707083126.181-1-Ibrahim.Tilki@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: AkTpTjPELy89df4kLIuDDVYsFD9SqNil
X-Proofpoint-ORIG-GUID: AkTpTjPELy89df4kLIuDDVYsFD9SqNil
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-07_06,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 mlxscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207070032
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Adding support for max11410 24-bit, 1.9ksps delta-sigma adc which
has 3 differential reference and 10 differential channel inputs.
Inputs and references can be buffered internally. Inputs can also
be amplified with internal PGA.

Device has a digital filter that is controlled by a custom sysfs attribute.
User has four options to choose from: fir50/60, fir50, fir60 and sinc4.
Digital filter selection affects sampling frequency range so driver
has to consider the configured filter when configuring sampling frequency.

Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Reviewed-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
---

Notes:
    since v2:
      - remove bit position shifting, use field_prep instead
      - reduce the amount of reg writes in max11410_configure_channel
      - add error checking in max11410_parse_channels
      - remove some unneeded blank lines and minor style fixes
      - remove scan data assignment in max11410_trigger_handler

 drivers/iio/adc/Kconfig    |  13 +
 drivers/iio/adc/Makefile   |   1 +
 drivers/iio/adc/max11410.c | 953 +++++++++++++++++++++++++++++++++++++
 3 files changed, 967 insertions(+)
 create mode 100644 drivers/iio/adc/max11410.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 71ab0a06a..eccb8d139 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -654,6 +654,19 @@ config MAX1118
 	  To compile this driver as a module, choose M here: the module will be
 	  called max1118.
 
+config MAX11410
+	tristate "Analog Devices MAX11410 ADC driver"
+	depends on SPI
+	select REGMAP_SPI
+	select IIO_BUFFER
+	select IIO_TRIGGER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say yes here to build support for Analog Devices MAX11410 ADCs.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called max11410.
+
 config MAX1241
 	tristate "Maxim max1241 ADC driver"
 	depends on SPI_MASTER
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 39d806f6d..679cc3c05 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -61,6 +61,7 @@ obj-$(CONFIG_LTC2497) += ltc2497.o ltc2497-core.o
 obj-$(CONFIG_MAX1027) += max1027.o
 obj-$(CONFIG_MAX11100) += max11100.o
 obj-$(CONFIG_MAX1118) += max1118.o
+obj-$(CONFIG_MAX11410) += max11410.o
 obj-$(CONFIG_MAX1241) += max1241.o
 obj-$(CONFIG_MAX1363) += max1363.o
 obj-$(CONFIG_MAX9611) += max9611.o
diff --git a/drivers/iio/adc/max11410.c b/drivers/iio/adc/max11410.c
new file mode 100644
index 000000000..fcade60df
--- /dev/null
+++ b/drivers/iio/adc/max11410.c
@@ -0,0 +1,953 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+
+#define REG_CONV_START	0x01
+#define		CONV_TYPE_SINGLE	0x00
+#define		CONV_TYPE_CONTINUOUS	0x01
+#define REG_CAL_START	0x03
+#define		CAL_START_SELF		0x00
+#define		CAL_START_PGA		0x01
+#define REG_GP1_CTRL	0x05
+#define		GP1_CTRL_INTRB		0xC1
+#define REG_FILTER	0x08
+#define		FILTER_RATE_MASK	GENMASK(3, 0)
+#define		FILTER_LINEF_MASK	GENMASK(5, 4)
+#define REG_CTRL	0x09
+#define		CTRL_REFSEL_MASK	GENMASK(2, 0)
+#define		CTRL_VREFN_BUF_BIT	BIT(3)
+#define		CTRL_VREFP_BUF_BIT	BIT(4)
+#define		CTRL_FORMAT_BIT		BIT(5)
+#define		CTRL_UNIPOLAR_BIT	BIT(6)
+#define REG_MUX_CTRL0	0x0B
+#define REG_PGA		0x0E
+#define		PGA_GAIN_MASK		GENMASK(2, 0)
+#define		PGA_SIG_PATH_MASK	GENMASK(5, 4)
+#define		PGA_SIG_PATH_BUFFERED	0x00
+#define		PGA_SIG_PATH_BYPASS	0x01
+#define		PGA_SIG_PATH_PGA	0x02
+#define REG_DATA0	0x30
+#define REG_STATUS	0x38
+#define		STATUS_CONV_READY_BIT	BIT(0)
+#define		STATUS_CAL_READY_BIT	BIT(2)
+
+#define REFSEL_AVDD_AGND	0x07
+#define REFSEL_MAX		0x07
+#define SIG_PATH_MAX		0x02
+#define CHANNEL_INDEX_MAX	0x0A
+#define AINP_AVDD	0x0A
+#define AINN_GND	0x0A
+
+#define CONVERSION_TIMEOUT_MS	2000
+#define CALIB_TIMEOUT_MS	2000
+
+enum max11410_supported_device_ids {
+	ID_MAX11410,
+};
+
+enum max11410_filter {
+	FILTER_FIR5060,
+	FILTER_FIR50,
+	FILTER_FIR60,
+	FILTER_SINC4,
+};
+
+static const u8 max11410_sampling_len[] = {
+	[FILTER_FIR5060] = 5,
+	[FILTER_FIR50] = 6,
+	[FILTER_FIR60] = 6,
+	[FILTER_SINC4] = 10,
+};
+
+static const int max11410_sampling_rates[4][10][2] = {
+	[FILTER_FIR5060] = {
+		{1, 100000},
+		{2, 100000},
+		{4, 200000},
+		{8, 400000},
+		{16, 800000}
+	},
+	[FILTER_FIR50] = {
+		{1, 300000},
+		{2, 700000},
+		{5, 300000},
+		{10, 700000},
+		{21, 300000},
+		{40}
+	},
+	[FILTER_FIR60] = {
+		{1, 300000},
+		{2, 700000},
+		{5, 300000},
+		{10, 700000},
+		{21, 300000},
+		{40}
+	},
+	[FILTER_SINC4] = {
+		{4},
+		{10},
+		{20},
+		{40},
+		{60},
+		{120},
+		{240},
+		{480},
+		{960},
+		{1920}
+	}
+};
+
+struct max11410_channel_config {
+	u32 settling_time_us;
+	u8 refsel;
+	u8 sig_path;
+	u8 gain;
+	bool bipolar;
+	bool buffered_vrefp;
+	bool buffered_vrefn;
+};
+
+struct max11410_state {
+	struct spi_device *spi_dev;
+	struct iio_trigger *trig;
+	struct completion completion;
+	struct mutex lock; /* Prevent changing channel config during sampling */
+	struct regmap *regmap;
+	struct regulator *avdd;
+	struct regulator *vref0p;
+	struct regulator *vref1p;
+	struct regulator *vref2p;
+	struct regulator *vref0n;
+	struct regulator *vref1n;
+	struct regulator *vref2n;
+	struct max11410_channel_config *channels;
+};
+
+static const struct iio_chan_spec chanspec_template = {
+		.type = IIO_VOLTAGE,
+		.indexed = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
+					| BIT(IIO_CHAN_INFO_SCALE)
+					| BIT(IIO_CHAN_INFO_OFFSET),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_HARDWAREGAIN)
+					| BIT(IIO_CHAN_INFO_SAMP_FREQ),
+		.scan_type = {
+			.sign = 's',
+			.realbits = 24,
+			.storagebits = 24,
+			.shift = 0,
+			.endianness = IIO_LE,
+		},
+};
+
+static unsigned int max11410_reg_size(unsigned int reg)
+{
+	/* Registers from 0x00 to 0x10 are 1 byte, the rest are 3 bytes long. */
+	return reg <= 0x10 ? 1 : 3;
+}
+
+static int max11410_write_reg(struct max11410_state *st,
+			      unsigned int reg,
+			      unsigned int val)
+{
+	/* This driver only needs to write 8-bit registers */
+	if (max11410_reg_size(reg) == 1)
+		return regmap_write(st->regmap, reg, val);
+
+	return -EINVAL;
+}
+
+static int max11410_read_reg(struct max11410_state *st,
+			     unsigned int reg,
+			     int *val)
+{
+	u8 data[3];
+	int ret;
+
+	if (max11410_reg_size(reg) == 3) {
+		ret = regmap_bulk_read(st->regmap, reg, data, 3);
+		if (!ret)
+			*val = get_unaligned_be24(data);
+		return ret;
+	}
+
+	return regmap_read(st->regmap, reg, val);
+}
+
+static struct regulator *max11410_get_vrefp(struct max11410_state *st, u8 refsel)
+{
+	switch (refsel % 4) {
+	case 0:
+		return st->vref0p;
+	case 1:
+		return st->vref1p;
+	case 2:
+		return st->vref2p;
+	case 3:
+		return st->avdd;
+	default:
+		return NULL;
+	}
+}
+
+static struct regulator *max11410_get_vrefn(struct max11410_state *st, u8 refsel)
+{
+	switch (refsel) {
+	case 0:
+		return st->vref0n;
+	case 1:
+		return st->vref1n;
+	case 2:
+		return st->vref2n;
+	default:
+		return NULL;
+	}
+}
+
+static const struct regmap_config regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x39,
+};
+
+static int max11410_sample(struct max11410_state *st, int *sample_raw)
+{
+	int val, ret;
+
+	if (st->spi_dev->irq > 0)
+		reinit_completion(&st->completion);
+
+	/* Start Conversion */
+	ret = max11410_write_reg(st, REG_CONV_START, CONV_TYPE_SINGLE);
+	if (ret)
+		return ret;
+
+	if (st->spi_dev->irq > 0) {
+		/* Wait for an interrupt. */
+		ret = wait_for_completion_timeout(&st->completion,
+						  msecs_to_jiffies(CONVERSION_TIMEOUT_MS));
+		if (!ret)
+			return -ETIMEDOUT;
+	} else {
+		/* Wait for status register Conversion Ready flag */
+		ret = read_poll_timeout(max11410_read_reg, ret,
+					ret || (val & STATUS_CONV_READY_BIT),
+					5000, CONVERSION_TIMEOUT_MS * 1000, true,
+					st, REG_STATUS, &val);
+		if (ret)
+			return ret;
+	}
+
+	/* Read ADC Data */
+	return max11410_read_reg(st, REG_DATA0, sample_raw);
+}
+
+static const char * const config_filter[] = {"fir50/60", "fir50", "fir60", "sinc4"};
+
+static IIO_CONST_ATTR(filter_available, "fir50/60 fir50 fir60 sinc4");
+
+static ssize_t max11410_filter_show(struct device *dev,
+				    struct device_attribute *devattr,
+				    char *buf)
+{
+	int ret;
+	unsigned int val;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct max11410_state *state = iio_priv(indio_dev);
+
+	ret = max11410_read_reg(state, REG_FILTER, &val);
+	if (ret)
+		return ret;
+
+	val = FIELD_GET(FILTER_LINEF_MASK, val);
+	if (val >= ARRAY_SIZE(config_filter))
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%s\n", config_filter[val]);
+}
+
+static ssize_t max11410_filter_store(struct device *dev,
+				     struct device_attribute *devattr,
+				     const char *buf, size_t count)
+{
+	int ret, config;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct max11410_state *state = iio_priv(indio_dev);
+
+	config = sysfs_match_string(config_filter, buf);
+	if (config < 0)
+		return -EINVAL;
+
+	ret = regmap_write_bits(state->regmap, REG_FILTER, FILTER_LINEF_MASK,
+				FIELD_PREP(FILTER_LINEF_MASK, config));
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static IIO_DEVICE_ATTR(filter, 0644, max11410_filter_show, max11410_filter_store, 0);
+
+static struct attribute *max11410_attributes[] = {
+	&iio_dev_attr_filter.dev_attr.attr,
+	&iio_const_attr_filter_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group max11410_attribute_group = {
+	.attrs = max11410_attributes,
+};
+
+static int max11410_set_input_mux(struct max11410_state *st, u8 ainp, u8 ainn)
+{
+	if (ainp > CHANNEL_INDEX_MAX || ainn > CHANNEL_INDEX_MAX)
+		return -EINVAL;
+
+	return max11410_write_reg(st, REG_MUX_CTRL0, (ainp << 4) | ainn);
+}
+
+static int max11410_configure_channel(struct max11410_state *st,
+				      struct iio_chan_spec const *chan)
+{
+	int ret;
+	unsigned int regval;
+	struct max11410_channel_config cfg = st->channels[chan->address];
+
+	if (chan->differential)
+		ret = max11410_set_input_mux(st, chan->channel, chan->channel2);
+	else
+		ret = max11410_set_input_mux(st, chan->channel, AINN_GND);
+
+	if (ret)
+		return ret;
+
+	regval = FIELD_PREP(CTRL_VREFP_BUF_BIT, cfg.buffered_vrefp) |
+		 FIELD_PREP(CTRL_VREFN_BUF_BIT, cfg.buffered_vrefn) |
+		 FIELD_PREP(CTRL_REFSEL_MASK, cfg.refsel) |
+		 FIELD_PREP(CTRL_UNIPOLAR_BIT, !cfg.bipolar);
+	ret = regmap_update_bits(st->regmap, REG_CTRL,
+				 CTRL_REFSEL_MASK | CTRL_VREFN_BUF_BIT |
+				 CTRL_VREFN_BUF_BIT | CTRL_UNIPOLAR_BIT,
+				 regval);
+	if (ret)
+		return ret;
+
+	regval = FIELD_PREP(PGA_SIG_PATH_MASK, cfg.sig_path) |
+		 FIELD_PREP(PGA_GAIN_MASK, cfg.gain);
+	ret = regmap_write(st->regmap, REG_PGA, regval);
+	if (ret)
+		return ret;
+
+	if (cfg.settling_time_us)
+		fsleep(cfg.settling_time_us);
+
+	return ret;
+}
+
+static int max11410_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long info)
+{
+	int ret, reg_val, filter, rate;
+	struct regulator *vrefp, *vrefn;
+	struct max11410_state *state = iio_priv(indio_dev);
+	struct max11410_channel_config cfg = state->channels[chan->address];
+
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		vrefp = max11410_get_vrefp(state, cfg.refsel);
+		if (!vrefp) {
+			/* We should never get here */
+			return -ENODEV;
+		}
+
+		*val = regulator_get_voltage(vrefp) / 1000;
+		vrefn = max11410_get_vrefn(state, cfg.refsel);
+		if (vrefn)
+			*val -= regulator_get_voltage(vrefn) / 1000;
+
+		if (cfg.bipolar)
+			*val *= 2;
+
+		*val2 = chan->scan_type.realbits;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_OFFSET:
+		if (cfg.bipolar)
+			*val = -BIT(chan->scan_type.realbits - 1);
+		else
+			*val = 0;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		mutex_lock(&state->lock);
+
+		ret = max11410_configure_channel(state, chan);
+
+		if (!ret)
+			ret = max11410_sample(state, &reg_val);
+
+		mutex_unlock(&state->lock);
+
+		iio_device_release_direct_mode(indio_dev);
+
+		if (ret)
+			return ret;
+
+		*val = reg_val;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		*val = BIT(cfg.gain);
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = regmap_read(state->regmap, REG_FILTER, &reg_val);
+		if (ret)
+			return ret;
+
+		filter = FIELD_GET(FILTER_LINEF_MASK, reg_val);
+		rate = reg_val & FILTER_RATE_MASK;
+		if (rate >= max11410_sampling_len[filter])
+			rate = max11410_sampling_len[filter] - 1;
+
+		*val = max11410_sampling_rates[filter][rate][0];
+		*val2 = max11410_sampling_rates[filter][rate][1];
+
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+	return -EINVAL;
+}
+
+static const int max11410_hwgain_list[] = {1, 2, 4, 8, 16, 32, 64, 128};
+
+static int max11410_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val, int val2, long mask)
+{
+	int i, ret, reg_val, filter;
+	struct max11410_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		for (i = 0; i < ARRAY_SIZE(max11410_hwgain_list); ++i) {
+			if (val == max11410_hwgain_list[i])
+				break;
+		}
+		if (i == ARRAY_SIZE(max11410_hwgain_list))
+			return -EINVAL;
+
+		st->channels[chan->address].gain = i;
+
+		return 0;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = regmap_read(st->regmap, REG_FILTER, &reg_val);
+		if (ret)
+			return ret;
+
+		filter = FIELD_GET(FILTER_LINEF_MASK, reg_val);
+
+		for (i = 0; i < max11410_sampling_len[filter]; ++i) {
+			if (val == max11410_sampling_rates[filter][i][0] &&
+			    val2 == max11410_sampling_rates[filter][i][1])
+				break;
+		}
+		if (i == max11410_sampling_len[filter])
+			return -EINVAL;
+
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		ret = regmap_write_bits(st->regmap, REG_FILTER, FILTER_RATE_MASK, i);
+		iio_device_release_direct_mode(indio_dev);
+
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int max11410_read_avail(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       const int **vals, int *type, int *length,
+			       long info)
+{
+	int ret, reg_val, filter;
+	struct max11410_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(max11410_hwgain_list);
+		*vals = max11410_hwgain_list;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = regmap_read(st->regmap, REG_FILTER, &reg_val);
+		if (ret)
+			return ret;
+
+		filter = FIELD_GET(FILTER_LINEF_MASK, reg_val);
+
+		*vals = (const int *)max11410_sampling_rates[filter];
+		*length = max11410_sampling_len[filter] * 2;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+
+		return IIO_AVAIL_LIST;
+	}
+	return -EINVAL;
+}
+
+static const struct iio_info max11410_info = {
+	.read_raw = max11410_read_raw,
+	.write_raw = max11410_write_raw,
+	.read_avail = max11410_read_avail,
+	.attrs = &max11410_attribute_group,
+};
+
+static irqreturn_t max11410_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct max11410_state *st = iio_priv(indio_dev);
+	struct {
+		int data;
+		s64 ts __aligned(8);
+	} scan;
+	int ret;
+
+	ret = max11410_read_reg(st, REG_DATA0, &scan.data);
+	if (!ret)
+		iio_push_to_buffers_with_timestamp(indio_dev, &scan,
+						   iio_get_time_ns(indio_dev));
+
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int max11410_buffer_postenable(struct iio_dev *indio_dev)
+{
+	int scan_ch, ret;
+	struct max11410_state *st = iio_priv(indio_dev);
+
+	/* Configure GPIO1 of MAX11410 as interrupt output. */
+	ret = max11410_write_reg(st, REG_GP1_CTRL, GP1_CTRL_INTRB);
+	if (ret)
+		return ret;
+
+	scan_ch = find_next_bit(indio_dev->active_scan_mask,
+				indio_dev->num_channels, 0);
+
+	ret = max11410_configure_channel(st, &indio_dev->channels[scan_ch]);
+	if (ret)
+		return ret;
+
+	/* Start continuous conversion. */
+	return max11410_write_reg(st, REG_CONV_START, CONV_TYPE_CONTINUOUS);
+}
+
+static int max11410_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct max11410_state *st = iio_priv(indio_dev);
+
+	/* Stop continuous conversion. */
+	return max11410_write_reg(st, REG_CONV_START, CONV_TYPE_SINGLE);
+}
+
+static bool max11410_validate_scan_mask(struct iio_dev *indio_dev,
+					const unsigned long *scan_mask)
+{
+	int i;
+	unsigned int x = 0;
+
+	for_each_set_bit(i, scan_mask, indio_dev->num_channels)
+		x++;
+
+	return x < 2;
+}
+
+static const struct iio_buffer_setup_ops max11410_buffer_ops = {
+	.postenable = &max11410_buffer_postenable,
+	.predisable = &max11410_buffer_predisable,
+	.validate_scan_mask = &max11410_validate_scan_mask,
+};
+
+static irqreturn_t max11410_interrupt(int irq, void *dev_id)
+{
+	struct iio_dev *indio_dev = dev_id;
+	struct max11410_state *st = iio_priv(indio_dev);
+
+	if (iio_buffer_enabled(indio_dev))
+		iio_trigger_poll_chained(st->trig);
+	else
+		complete(&st->completion);
+
+	return IRQ_HANDLED;
+};
+
+static int max11410_parse_channels(struct max11410_state *st,
+				   struct iio_dev *indio_dev)
+{
+	struct iio_chan_spec *channels;
+	struct fwnode_handle *child;
+	struct max11410_channel_config *cfg;
+	struct device *dev = &st->spi_dev->dev;
+	unsigned int num_ch;
+	u32 inputs[2];
+	u32 reference, sig_path;
+	int chan_idx = 0;
+	int ret;
+	struct iio_chan_spec chanspec = chanspec_template;
+
+	num_ch = device_get_child_node_count(dev);
+	if (num_ch == 0)
+		return dev_err_probe(&indio_dev->dev,
+				     -ENODEV,
+				     "no channel children\n");
+
+	/* Reserve space for soft timestamp channel */
+	num_ch += 1;
+	channels = devm_kcalloc(dev, num_ch,
+				sizeof(struct iio_chan_spec),
+				GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
+
+	st->channels = devm_kcalloc(dev, num_ch,
+				    sizeof(struct max11410_channel_config),
+				    GFP_KERNEL);
+	if (!st->channels)
+		return -ENOMEM;
+
+	device_for_each_child_node(dev, child) {
+		if (fwnode_property_present(child, "diff-channels")) {
+			ret = fwnode_property_read_u32_array(child,
+							     "diff-channels",
+							     inputs,
+							     ARRAY_SIZE(inputs));
+			if (ret)
+				return ret;
+
+			chanspec.differential = 1;
+		} else {
+			ret = fwnode_property_read_u32(child, "reg", &inputs[0]);
+			if (ret)
+				return ret;
+
+			inputs[1] = 0;
+			chanspec.differential = 0;
+		}
+		if (inputs[0] > CHANNEL_INDEX_MAX || inputs[1] > CHANNEL_INDEX_MAX)
+			return dev_err_probe(&indio_dev->dev,
+					     -EINVAL,
+					     "Invalid channel index for %s, should be less than %d\n",
+					     fwnode_get_name(child),
+					     CHANNEL_INDEX_MAX + 1);
+
+		cfg = &st->channels[chan_idx];
+		ret = fwnode_property_read_u32(child, "adi,reference", &reference);
+		if (ret) {
+			cfg->refsel = REFSEL_AVDD_AGND;
+		} else {
+			if (reference > REFSEL_MAX)
+				return dev_err_probe(&indio_dev->dev,
+						     -EINVAL,
+						     "Invalid adi,reference value for %s, should be less than %d.\n",
+						     fwnode_get_name(child),
+						     REFSEL_MAX + 1);
+
+			cfg->refsel = reference;
+		}
+		if (!max11410_get_vrefp(st, cfg->refsel))
+			return dev_err_probe(&indio_dev->dev,
+					     -EINVAL,
+					     "Invalid VREF configuration for %s, either specify corresponding VREFP regulator or change adi,reference property.\n",
+					     fwnode_get_name(child));
+
+		ret = fwnode_property_read_u32(child, "adi,input-mode", &sig_path);
+		if (!ret) {
+			if (sig_path > SIG_PATH_MAX)
+				return dev_err_probe(&indio_dev->dev,
+						     -EINVAL,
+						     "Invalid adi,input-mode value for %s, should be less than %d.\n",
+						     fwnode_get_name(child),
+						     SIG_PATH_MAX + 1);
+			cfg->sig_path = sig_path;
+		}
+		/* Enable hardware gain property if input mode is PGA */
+		if (sig_path == PGA_SIG_PATH_PGA)
+			__set_bit(IIO_CHAN_INFO_HARDWAREGAIN, &chanspec.info_mask_separate);
+		else
+			__clear_bit(IIO_CHAN_INFO_HARDWAREGAIN, &chanspec.info_mask_separate);
+
+		fwnode_property_read_u32(child,
+					 "settling-time-us",
+					 &cfg->settling_time_us);
+		cfg->bipolar = fwnode_property_read_bool(child, "bipolar");
+		cfg->buffered_vrefp = fwnode_property_read_bool(child, "adi,buffered-vrefp");
+		cfg->buffered_vrefn = fwnode_property_read_bool(child, "adi,buffered-vrefn");
+
+		chanspec.address = chan_idx;
+		chanspec.scan_index = chan_idx;
+		chanspec.channel = inputs[0];
+		chanspec.channel2 = inputs[1];
+
+		channels[chan_idx] = chanspec;
+		chan_idx++;
+	}
+
+	channels[chan_idx] = (struct iio_chan_spec)IIO_CHAN_SOFT_TIMESTAMP(chan_idx);
+
+	indio_dev->num_channels = chan_idx + 1;
+	indio_dev->channels = channels;
+
+	return 0;
+}
+
+static void max11410_disable_reg(void *reg)
+{
+	regulator_disable(reg);
+}
+
+static int max11410_init_vref(struct device *dev,
+			      struct regulator **vref,
+			      const char *id)
+{
+	int ret;
+	struct regulator *reg;
+
+	reg = devm_regulator_get_optional(dev, id);
+	if (IS_ERR(reg)) {
+		*vref = NULL;
+		return 0;
+	}
+	ret = regulator_enable(reg);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to enable regulator %s\n", id);
+
+	*vref = reg;
+	return devm_add_action_or_reset(dev, max11410_disable_reg, reg);
+}
+
+static int max11410_calibrate(struct max11410_state *st, u32 cal_type)
+{
+	int ret, val;
+
+	ret = max11410_write_reg(st, REG_CAL_START, cal_type);
+	if (ret)
+		return ret;
+
+	/* Wait for status register Calibration Ready flag */
+	return read_poll_timeout(max11410_read_reg, ret,
+				 ret || (val & STATUS_CAL_READY_BIT),
+				 50000, CALIB_TIMEOUT_MS * 1000, true,
+				 st, REG_STATUS, &val);
+}
+
+static int max11410_self_calibrate(struct max11410_state *st)
+{
+	int ret, i;
+
+	ret = regmap_write_bits(st->regmap, REG_FILTER,
+				FILTER_RATE_MASK, FILTER_RATE_MASK);
+	if (ret)
+		return ret;
+
+	ret = max11410_calibrate(st, CAL_START_SELF);
+	if (ret)
+		return ret;
+
+	ret = regmap_write_bits(st->regmap, REG_PGA, PGA_SIG_PATH_MASK,
+				FIELD_PREP(PGA_SIG_PATH_MASK, PGA_SIG_PATH_PGA));
+	if (ret)
+		return ret;
+
+	/* PGA calibrations */
+	for (i = 1; i < ARRAY_SIZE(max11410_hwgain_list); ++i) {
+		ret = regmap_write_bits(st->regmap, REG_PGA, PGA_GAIN_MASK, i);
+		if (ret)
+			return ret;
+
+		ret = max11410_calibrate(st, CAL_START_PGA);
+		if (ret)
+			return ret;
+	}
+
+	/* Cleanup */
+	ret = regmap_write_bits(st->regmap, REG_PGA, PGA_GAIN_MASK, 0);
+	if (ret)
+		return ret;
+
+	ret = regmap_write_bits(st->regmap, REG_FILTER, FILTER_RATE_MASK, 0);
+	if (ret)
+		return ret;
+
+	ret = regmap_write_bits(st->regmap, REG_PGA, PGA_SIG_PATH_MASK,
+				FIELD_PREP(PGA_SIG_PATH_MASK, PGA_SIG_PATH_BUFFERED));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int max11410_probe(struct spi_device *spi)
+{
+	struct max11410_state *st;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi_dev = spi;
+	init_completion(&st->completion);
+	mutex_init(&st->lock);
+
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &max11410_info;
+
+	st->regmap = devm_regmap_init_spi(spi, &regmap_config);
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->regmap),
+				     "regmap initialization failed\n");
+
+	st->avdd = devm_regulator_get(&spi->dev, "avdd");
+	if (IS_ERR(st->avdd))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->avdd),
+				     "avdd-supply is required.\n");
+
+	ret = regulator_enable(st->avdd);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&spi->dev, max11410_disable_reg, st->avdd);
+	if (ret)
+		return ret;
+
+	ret = max11410_init_vref(&spi->dev, &st->vref0p, "vref0p");
+	if (ret)
+		return ret;
+
+	ret = max11410_init_vref(&spi->dev, &st->vref1p, "vref1p");
+	if (ret)
+		return ret;
+
+	ret = max11410_init_vref(&spi->dev, &st->vref2p, "vref2p");
+	if (ret)
+		return ret;
+
+	ret = max11410_init_vref(&spi->dev, &st->vref0n, "vref0n");
+	if (ret)
+		return ret;
+
+	ret = max11410_init_vref(&spi->dev, &st->vref1n, "vref1n");
+	if (ret)
+		return ret;
+
+	ret = max11410_init_vref(&spi->dev, &st->vref2n, "vref2n");
+	if (ret)
+		return ret;
+
+	/*
+	 * Regulators must be configured before parsing channels for
+	 * validating "adi,reference" property of each channel.
+	 */
+	ret = max11410_parse_channels(st, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(st->regmap, REG_CTRL, CTRL_FORMAT_BIT);
+	if (ret)
+		return ret;
+
+	if (spi->irq > 0) {
+		st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
+						  indio_dev->name,
+						  iio_device_id(indio_dev));
+		if (!st->trig)
+			return -ENOMEM;
+
+		ret = devm_iio_trigger_register(&spi->dev, st->trig);
+		if (ret)
+			return ret;
+
+		indio_dev->trig = iio_trigger_get(st->trig);
+
+		ret = devm_request_threaded_irq(&spi->dev, spi->irq,
+						NULL,
+						&max11410_interrupt,
+						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+						"max11410", indio_dev);
+		if (ret)
+			return ret;
+
+		indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
+		ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
+						      NULL,
+						      &max11410_trigger_handler,
+						      &max11410_buffer_ops);
+		if (ret)
+			return ret;
+
+		ret = max11410_write_reg(st, REG_GP1_CTRL, GP1_CTRL_INTRB);
+		if (ret)
+			return ret;
+	}
+
+	ret = max11410_self_calibrate(st);
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "cannot perform device self calibration\n");
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct of_device_id max11410_spi_of_id[] = {
+	{ .compatible = "adi,max11410" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max11410_spi_of_id);
+
+static const struct spi_device_id max11410_id[] = {
+	{"max11410", ID_MAX11410},
+	{}
+};
+MODULE_DEVICE_TABLE(spi, max11410_id);
+
+static struct spi_driver max11410_driver = {
+	.driver = {
+		.name	= "max11410",
+		.of_match_table = max11410_spi_of_id,
+	},
+	.probe		= max11410_probe,
+	.id_table	= max11410_id,
+};
+module_spi_driver(max11410_driver);
+
+MODULE_SOFTDEP("pre: regmap_spi industrialio-triggered-buffer");
+MODULE_AUTHOR("David Jung <david.jung@analog.com>");
+MODULE_AUTHOR("Ibrahim Tilki <ibrahim.tilki@analog.com>");
+MODULE_DESCRIPTION("Analog Devices MAX11410 ADC");
+MODULE_LICENSE("GPL v2");
-- 
2.36.1

