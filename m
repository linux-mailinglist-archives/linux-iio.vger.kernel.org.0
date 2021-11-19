Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA82D456E37
	for <lists+linux-iio@lfdr.de>; Fri, 19 Nov 2021 12:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbhKSLdT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Nov 2021 06:33:19 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:55842 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235125AbhKSLdP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Nov 2021 06:33:15 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AJ7qxYl021939;
        Fri, 19 Nov 2021 06:30:13 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3ce7wxs0t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 06:30:13 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 1AJBUCmr049465
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Nov 2021 06:30:12 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Fri, 19 Nov 2021
 06:30:11 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Fri, 19 Nov 2021 06:30:11 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1AJBU3KM014813;
        Fri, 19 Nov 2021 06:30:09 -0500
From:   Cristian Pop <cristian.pop@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, Cristian Pop <cristian.pop@analog.com>
Subject: [PATCH v1 2/2] iio:frequency:admv4420.c: Add support for ADMV4420
Date:   Fri, 19 Nov 2021 13:40:11 +0200
Message-ID: <20211119114011.75406-2-cristian.pop@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119114011.75406-1-cristian.pop@analog.com>
References: <20211119114011.75406-1-cristian.pop@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: sQdJxvr4GDnv42UD9s1bOtF2Q4YlE8BZ
X-Proofpoint-ORIG-GUID: sQdJxvr4GDnv42UD9s1bOtF2Q4YlE8BZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-19_09,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111190064
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for K Band Downconverter with Integrated
Fractional-N PLL and VCO.
More info:
https://www.analog.com/en/products/admv4420.html

Signed-off-by: Cristian Pop <cristian.pop@analog.com>
---
 drivers/iio/frequency/Kconfig    |  10 +
 drivers/iio/frequency/Makefile   |   1 +
 drivers/iio/frequency/admv4420.c | 413 +++++++++++++++++++++++++++++++
 3 files changed, 424 insertions(+)
 create mode 100644 drivers/iio/frequency/admv4420.c

diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
index 2c9e0559e8a4..e2a8428a72df 100644
--- a/drivers/iio/frequency/Kconfig
+++ b/drivers/iio/frequency/Kconfig
@@ -50,6 +50,16 @@ config ADF4371
 	  To compile this driver as a module, choose M here: the
 	  module will be called adf4371.
 
+config ADMV4420
+	tristate "Analog Devices ADMV4420 K Band Downconverter"
+	depends on SPI
+	help
+	  Say yes here to build support for Analog Devices K Band
+	  Downconverter with integrated Fractional-N PLL and VCO.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called admv4420.
+
 config ADRF6780
         tristate "Analog Devices ADRF6780 Microwave Upconverter"
         depends on SPI
diff --git a/drivers/iio/frequency/Makefile b/drivers/iio/frequency/Makefile
index ae3136c79202..f582305b3086 100644
--- a/drivers/iio/frequency/Makefile
+++ b/drivers/iio/frequency/Makefile
@@ -7,4 +7,5 @@
 obj-$(CONFIG_AD9523) += ad9523.o
 obj-$(CONFIG_ADF4350) += adf4350.o
 obj-$(CONFIG_ADF4371) += adf4371.o
+obj-$(CONFIG_ADMV4420) += admv4420.o
 obj-$(CONFIG_ADRF6780) += adrf6780.o
diff --git a/drivers/iio/frequency/admv4420.c b/drivers/iio/frequency/admv4420.c
new file mode 100644
index 000000000000..728e86ec93b6
--- /dev/null
+++ b/drivers/iio/frequency/admv4420.c
@@ -0,0 +1,413 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * ADMV4420
+ *
+ * Copyright 2021 Analog Devices Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+
+/* ADMV4420 Register Map */
+#define ADMV4420_SPI_CONFIG_1			0x00
+#define ADMV4420_SPI_CONFIG_2			0x01
+#define ADMV4420_CHIPTYPE			0x03
+#define ADMV4420_PRODUCT_ID_L			0x04
+#define ADMV4420_PRODUCT_ID_H			0x05
+#define ADMV4420_SCRATCHPAD			0x0A
+#define ADMV4420_SPI_REV			0x0B
+#define ADMV4420_ENABLES			0x103
+#define ADMV4420_SDO_LEVEL			0x108
+#define ADMV4420_INT_L				0x200
+#define ADMV4420_INT_H				0x201
+#define ADMV4420_FRAC_L				0x202
+#define ADMV4420_FRAC_M				0x203
+#define ADMV4420_FRAC_H				0x204
+#define ADMV4420_MOD_L				0x208
+#define ADMV4420_MOD_M				0x209
+#define ADMV4420_MOD_H				0x20A
+#define ADMV4420_R_DIV_L			0x20C
+#define ADMV4420_R_DIV_H			0x20D
+#define ADMV4420_REFERENCE			0x20E
+#define ADMV4420_VCO_DATA_READBACK1		0x211
+#define ADMV4420_VCO_DATA_READBACK2		0x212
+#define ADMV4420_PLL_MUX_SEL			0x213
+#define ADMV4420_LOCK_DETECT			0x214
+#define ADMV4420_BAND_SELECT			0x215
+#define ADMV4420_VCO_ALC_TIMEOUT		0x216
+#define ADMV4420_VCO_MANUAL			0x217
+#define ADMV4420_ALC				0x219
+#define ADMV4420_VCO_TIMEOUT1			0x21C
+#define ADMV4420_VCO_TIMEOUT2			0x21D
+#define ADMV4420_VCO_BAND_DIV			0x21E
+#define ADMV4420_VCO_READBACK_SEL		0x21F
+#define ADMV4420_AUTOCAL			0x226
+#define ADMV4420_CP_STATE			0x22C
+#define ADMV4420_CP_BLEED_EN			0x22D
+#define ADMV4420_CP_CURRENT			0x22E
+#define ADMV4420_CP_BLEED			0x22F
+
+#define ADMV4420_SPI_CONFIG_1_SOFTRESET		BIT(1)
+#define ADMV4420_SPI_CONFIG_1_SOFTRESET_	BIT(7)
+
+#define ADMV4420_REFERENCE_IN_MODE(x)		(x << 1)
+#define ADMV4420_REFERENCE_DOUBLER(x)		(x << 2)
+#define ADMV4420_REFERENCE_DIVIDE_BY_2_MASK	BIT(0)
+#define ADMV4420_REFERENCE_MODE_MASK		BIT(1)
+#define ADMV4420_REFERENCE_DOUBLER_MASK		BIT(2)
+#define ADMV4420_REF_DIVIDER_MAX_VAL		GENMASK(9, 0)
+#define ADMV4420_N_COUNTER_INT_MAX		GENMASK(15, 0)
+#define ADMV4420_N_COUNTER_FRAC_MAX		GENMASK(23, 0)
+#define ADMV4420_N_COUNTER_MOD_MAX		GENMASK(23, 0)
+
+#define ADMV4420_L_MASK				GENMASK(7, 0)
+#define ADMV4420_H_MASK				GENMASK(15, 8)
+#define ADMV4420_FRAC_L_MASK			GENMASK(7, 0)
+#define ADMV4420_FRAC_M_MASK			GENMASK(15, 8)
+#define ADMV4420_FRAC_H_MASK			GENMASK(23, 16)
+#define ADMV4420_MOD_L_MASK			GENMASK(7, 0)
+#define ADMV4420_MOD_M_MASK			GENMASK(15, 8)
+#define ADMV4420_MOD_H_MASK			GENMASK(23, 16)
+
+#define ENABLE_PLL				BIT(6)
+#define ENABLE_LO				BIT(5)
+#define ENABLE_VCO				BIT(3)
+#define ENABLE_IFAMP				BIT(2)
+#define ENABLE_MIXER				BIT(1)
+#define ENABLE_LNA				BIT(0)
+
+#define ADAR1000_SCRATCH_PAD_VAL_1		0xAD
+#define ADAR1000_SCRATCH_PAD_VAL_2		0xEA
+#define ADMV4420_DEF_REF_HZ			50000000
+#define ADMV4420_DEF_REF_DIVIDER		1
+#define ADMV4420_DEF_NC_INT			0xA7
+#define ADMV4420_DEF_NC_FRAC			0x02
+#define ADMV4420_DEF_NC_MOD			0x04
+
+enum admv4420_option_st {
+	ADMV4420_DISABLED,
+	ADMV4420_ENABLED,
+};
+
+enum admv4420_ref_op {
+	ADMV4420_DOUBLER,
+	ADMV4420_DIVIDE_BY_2,
+	ADMV4420_REF_SINGLE_ENDED,
+};
+
+enum admv4420_mux_sel {
+	ADMV4420_LOW = 0,
+	ADMV4420_LOCK_DTCT = 1,
+	ADMV4420_R_COUNTER_PER_2 = 4,
+	ADMV4420_N_CONUTER_PER_2 = 5,
+	ADMV4420_HIGH = 8,
+};
+
+enum admv4420_n_counter_par {
+	ADMV4420_N_COUNTER_INT,
+	ADMV4420_N_COUNTER_FRAC,
+	ADMV4420_N_COUNTER_MOD,
+};
+
+struct admv4420_reference_block {
+	bool doubler_en;
+	bool divide_by_2_en;
+	bool ref_single_ended;
+	u32 freq_hz;
+	u32 divider;
+};
+
+struct admv4420_n_counter {
+	u32 int_val;
+	u32 frac_val;
+	u32 mod_val;
+	u32 n_counter;
+};
+
+struct admv4420_state {
+	struct spi_device		*spi;
+	struct regmap			*regmap;
+	u64				pfd_freq_hz;
+	u64				vco_freq_hz;
+	u64				lo_freq_hz;
+	struct admv4420_reference_block ref_block;
+	struct admv4420_n_counter	n_counter;
+	enum admv4420_mux_sel		mux_sel;
+	struct mutex			lock;
+};
+
+static const struct regmap_config admv4420_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.read_flag_mask = BIT(7),
+};
+
+static int admv4420_reg_access(struct iio_dev *indio_dev,
+			       u32 reg, u32 writeval,
+			       u32 *readval)
+{
+	struct admv4420_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+	else
+		return regmap_write(st->regmap, reg, writeval);
+}
+
+static void admv4420_calc_vco_freq(struct admv4420_state *st)
+{
+	u64 tmp;
+
+	tmp = div_u64((st->pfd_freq_hz * st->n_counter.frac_val), st->n_counter.mod_val);
+	tmp += st->pfd_freq_hz * st->n_counter.int_val;
+	st->vco_freq_hz = tmp;
+}
+
+static void admv4420_calc_pfd_freq(struct admv4420_state *st)
+{
+	u32 tmp;
+
+	tmp = st->ref_block.freq_hz * (st->ref_block.doubler_en ? 2 : 1);
+	tmp = DIV_ROUND_CLOSEST(tmp, st->ref_block.divider *
+				(st->ref_block.divide_by_2_en ? 2 : 1));
+	st->pfd_freq_hz = tmp;
+
+	admv4420_calc_vco_freq(st);
+	st->lo_freq_hz = st->vco_freq_hz * 2;
+}
+
+static int admv4420_set_n_counter(struct admv4420_state *st, u32 int_val, u32 frac_val, u32 mod_val)
+{
+	int ret;
+
+	ret = regmap_write(st->regmap, ADMV4420_FRAC_H, FIELD_GET(ADMV4420_FRAC_H_MASK, frac_val));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADMV4420_FRAC_M, FIELD_GET(ADMV4420_FRAC_M_MASK, frac_val));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADMV4420_FRAC_L, FIELD_GET(ADMV4420_FRAC_L_MASK, frac_val));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADMV4420_MOD_H, FIELD_GET(ADMV4420_MOD_H_MASK, mod_val));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADMV4420_MOD_M, FIELD_GET(ADMV4420_MOD_M_MASK, mod_val));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADMV4420_MOD_L, FIELD_GET(ADMV4420_MOD_L_MASK, mod_val));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADMV4420_INT_H, FIELD_GET(ADMV4420_H_MASK, int_val));
+	if (ret)
+		return ret;
+
+	return regmap_write(st->regmap, ADMV4420_INT_L, FIELD_GET(ADMV4420_L_MASK, int_val));
+}
+
+static int admv4420_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long info)
+{
+	struct admv4420_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_FREQUENCY:
+		*val = div_u64(st->lo_freq_hz, 1000000);
+		div_u64_rem(st->lo_freq_hz, 1000000, val2);
+
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info admv4420_info = {
+	.read_raw = admv4420_read_raw,
+	.debugfs_reg_access = &admv4420_reg_access,
+};
+
+#define ADMV4420_CHAN_LO(_channel) {				\
+	.type = IIO_ALTVOLTAGE,					\
+	.output = 0,						\
+	.indexed = 1,						\
+	.channel = _channel,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_FREQUENCY)	\
+}
+
+static const struct iio_chan_spec admv4420_channels[] = {
+	ADMV4420_CHAN_LO(0),
+};
+
+static void admv4420_dt_parse(struct admv4420_state *st)
+{
+	struct spi_device *spi = st->spi;
+
+	st->ref_block.ref_single_ended = of_property_read_bool(spi->dev.of_node,
+							       "adi,ref_single_ended");
+	st->ref_block.doubler_en = of_property_read_bool(spi->dev.of_node, "adi,ref_doubler_en");
+	st->ref_block.divide_by_2_en = of_property_read_bool(spi->dev.of_node,
+							     "adi,ref_divide_by_2_en");
+	device_property_read_u32(&spi->dev, "adi,ref_freq_hz", &st->ref_block.freq_hz);
+	device_property_read_u32(&spi->dev, "adi,ref_divider", &st->ref_block.divider);
+	device_property_read_u32(&spi->dev, "adi,N_counter_int_val", &st->n_counter.int_val);
+	device_property_read_u32(&spi->dev, "adi,N_counter_frac_val", &st->n_counter.frac_val);
+	device_property_read_u32(&spi->dev, "adi,N_counter_mod_val", &st->n_counter.mod_val);
+	device_property_read_u32(&spi->dev, "adi,mux_sel", &st->mux_sel);
+}
+
+static int admv4420_setup(struct iio_dev *indio_dev)
+{
+	struct admv4420_state *st = iio_priv(indio_dev);
+	u32 val = 0;
+	int ret;
+
+	/* Software reset and activate SDO */
+	ret = regmap_write(st->regmap, ADMV4420_SPI_CONFIG_1,
+			   ADMV4420_SPI_CONFIG_1_SOFTRESET_ | ADMV4420_SPI_CONFIG_1_SOFTRESET);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADMV4420_SCRATCHPAD, ADAR1000_SCRATCH_PAD_VAL_1);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->regmap, ADMV4420_SCRATCHPAD, &val);
+	if (ret)
+		return ret;
+
+	if (val != ADAR1000_SCRATCH_PAD_VAL_1) {
+		dev_err(indio_dev->dev.parent, "Failed ADMV4420 to read/write scratchpad %x ", val);
+		return -EIO;
+	}
+
+	ret = regmap_write(st->regmap, ADMV4420_SCRATCHPAD, ADAR1000_SCRATCH_PAD_VAL_2);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->regmap, ADMV4420_SCRATCHPAD, &val);
+	if (ret)
+		return ret;
+
+	if (val != ADAR1000_SCRATCH_PAD_VAL_2) {
+		dev_err(indio_dev->dev.parent, "Failed ADMV4420 to read/write scratchpad %x ", val);
+		return -EIO;
+	}
+
+	st->ref_block.freq_hz = ADMV4420_DEF_REF_HZ;
+	st->ref_block.ref_single_ended = false;
+	st->ref_block.doubler_en = false;
+	st->ref_block.divide_by_2_en = false;
+	st->ref_block.divider = ADMV4420_DEF_REF_DIVIDER;
+
+	st->n_counter.int_val = ADMV4420_DEF_NC_INT;
+	st->n_counter.frac_val = ADMV4420_DEF_NC_FRAC;
+	st->n_counter.mod_val = ADMV4420_DEF_NC_MOD;
+
+	st->mux_sel = ADMV4420_LOCK_DTCT;
+
+	admv4420_dt_parse(st);
+
+	ret = regmap_write(st->regmap, ADMV4420_R_DIV_L,
+			   FIELD_GET(ADMV4420_L_MASK, st->ref_block.divider));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADMV4420_R_DIV_H,
+			   FIELD_GET(ADMV4420_H_MASK, st->ref_block.divider));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADMV4420_REFERENCE,
+			   st->ref_block.divide_by_2_en |
+			   ADMV4420_REFERENCE_IN_MODE(st->ref_block.ref_single_ended) |
+			   ADMV4420_REFERENCE_DOUBLER(st->ref_block.doubler_en));
+	if (ret)
+		return ret;
+
+	ret = admv4420_set_n_counter(st, st->n_counter.int_val, st->n_counter.frac_val,
+				     st->n_counter.mod_val);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADMV4420_PLL_MUX_SEL, st->mux_sel);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, ADMV4420_ENABLES, ENABLE_PLL | ENABLE_LO | ENABLE_VCO |
+			   ENABLE_IFAMP | ENABLE_MIXER | ENABLE_LNA);
+	if (ret)
+		return ret;
+
+	admv4420_calc_pfd_freq(st);
+
+	return 0;
+}
+
+static int admv4420_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct admv4420_state *st;
+	struct regmap *regmap;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	regmap = devm_regmap_init_spi(spi, &admv4420_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&spi->dev, "Error  ADMV4420 initializing spi regmap: %ld\n",
+			PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+	st->regmap = regmap;
+	mutex_init(&st->lock);
+
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = "admv4420";
+	indio_dev->info = &admv4420_info;
+	indio_dev->channels = admv4420_channels;
+	indio_dev->num_channels = ARRAY_SIZE(admv4420_channels);
+
+	ret = admv4420_setup(indio_dev);
+	if (ret) {
+		dev_err(&spi->dev, "Setup ADMV4420 failed (%d)\n", ret);
+		return ret;
+	}
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct of_device_id admv4420_of_match[] = {
+	{ .compatible = "adi,admv4420" },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, admv4420_of_match);
+
+static struct spi_driver admv4420_driver = {
+	.driver = {
+		.name	= "admv4420",
+		.of_match_table = admv4420_of_match,
+	},
+	.probe		= admv4420_probe,
+};
+module_spi_driver(admv4420_driver);
+
+MODULE_AUTHOR("Cristian Pop <cristian.pop@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADMV44200 K Band Downconverter");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.17.1

