Return-Path: <linux-iio+bounces-26130-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFD4C46B0E
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 13:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B911885260
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 12:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D91430EF71;
	Mon, 10 Nov 2025 12:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dkGEy8RM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C0630B514;
	Mon, 10 Nov 2025 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762778763; cv=none; b=pe0lRCv56wU4Pi+lX1y1WcRqkekdEK+v9KFboJiLmcfg2GOZszlI15XqM+3xtPrNr1TcI/nZJD2ZN3VO8VwkCy2U5+hYEEDOro/zEeeEHpu9bdQo85YgdzZrQcMA+3/SfpuHE6lXUHSJ53B1gYzMZAvp/KVepIOABm3Xj+twwE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762778763; c=relaxed/simple;
	bh=tKDuBMEO9BMo/VwRcJs722Re7rMIPBhKoNe+urPsHIA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HLtb0qFrcTn2QwLVmLaIbuanmjrb1bJohNWCVi/bufGkGrYjjQZP2ugz1yBIDOx2gJzUPJExFXYyqqkxBQUs8TQJYrZ5LofrdGSdKx+fmVElkszhOr+ehdUcQdriEp0H+Epf3hBAX86xMvHv67CEOEdGp9zQeZ2ommfsRRhRINw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dkGEy8RM; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA9FCvX403753;
	Mon, 10 Nov 2025 07:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=y/bLK
	8t3yABEsTY4eeoaEbDSheiR3UzlchZHlVyy8rg=; b=dkGEy8RMHMigZRzfqpzpH
	YTD87xfbbJjmVx2KMpCHaxU47MO4pvVpUHy212UiJw9s46+3fJummXUJ06NVQpjE
	pPipVq8Mb7edgidsjYaE6WIJNxgc+INiOCQhBwuginuhmhVF3BHPz9a6qXJkynV8
	n+IA3MNtEmGepm952DCFoJBct2/tYakuOkauW2WYoVyaD0/UiZHR5mpeDC68jPKm
	7hb9Hndmj5axr39OqZisaYzQwDLatIbJ/LuKLTo87OwRaaGOubkayP5qR4pGo0ix
	V2vo/yglrerknXhNceadsw+lXz5aa6tEPyJoBkTd9cxkMiicM7JTDdcNfiFxkTH2
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ab9nk9tn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 07:45:56 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 5AACjtem064006
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Nov 2025 07:45:55 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 10 Nov
 2025 07:45:54 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 10 Nov 2025 07:45:54 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 5AACjfu4000601;
	Mon, 10 Nov 2025 07:45:43 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <cosmin.tanislav@analog.com>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 2/3] iio: adc: Initial support for AD4134
Date: Mon, 10 Nov 2025 09:45:40 -0300
Message-ID: <86f532ae3a9b3f122b9d5dbada9c131a0c048ca7.1762777931.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1762777931.git.marcelo.schmitt@analog.com>
References: <cover.1762777931.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: _ab23TcclbkLu2XRhrUHf_kQEh7KvXzA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDExMSBTYWx0ZWRfX2OSXl6b539bv
 N1HRVs62TD63hl/3bItQ+MfB5/1m3tBWgmmaplLl1/6UG8L/46XGiF++7m4HUbzmrkDadN+Rfn+
 Ux7PuKcTpxNDWaq3mhf/0Qiez/vPjsqTmEl93TsCy0E6ZTZ5Tk5iUhceqsAyDj09IZfe9nTgGn0
 L+XwZm81wlGEGX0u02oy7dnlE9s+KnZsAU4NxIv3yuoI5nE9mj32rtZsxM9spBWiI+rEz6kz1tO
 1/nATQ+O/M6ravjpvunZcALlKlvIVRHb/tQ4vJ07rJy3fe2YKdcyGDMJJhi+FopMorWd9hjnlbU
 t0ySaFwVQAWBV7dEmT5Yb48VzIX1/IOBHBDRNV1SjeT+vWcbdKD7Z2QvQnG5btWhzmrmcPHIHJN
 dUPof5shAyqDdWcoQTOXV3PVfXV6fA==
X-Proofpoint-ORIG-GUID: _ab23TcclbkLu2XRhrUHf_kQEh7KvXzA
X-Authority-Analysis: v=2.4 cv=YPiSCBGx c=1 sm=1 tr=0 ts=6911de84 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=vo2TPkcWhF2xW9m-t-EA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_05,2025-11-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511100111

AD4134 is a 24-bit, 4-channel, simultaneous sampling, precision
analog-to-digital converter (ADC). The device can be managed through SPI or
direct control of pin logical levels (pin control mode). The AD4134 design
also features a dedicated bus for ADC sample data output. Though, this
initial driver for AD4134 only supports usual SPI connections.

The different wiring configurations will likely require distinct software
to handle. So, the code specific to SPI is enclosed in ad4134-spi.c, while
functionality that may be useful to all wiring configuration is set into
ad4134-common.h and ad4134-common.c.

Add basic support for AD4134 that allows single-shot ADC sample read.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 MAINTAINERS                     |   1 +
 drivers/iio/adc/Kconfig         |  15 ++
 drivers/iio/adc/Makefile        |   2 +
 drivers/iio/adc/ad4134-common.c | 200 ++++++++++++++++++++++
 drivers/iio/adc/ad4134-common.h | 132 +++++++++++++++
 drivers/iio/adc/ad4134-spi.c    | 287 ++++++++++++++++++++++++++++++++
 6 files changed, 637 insertions(+)
 create mode 100644 drivers/iio/adc/ad4134-common.c
 create mode 100644 drivers/iio/adc/ad4134-common.h
 create mode 100644 drivers/iio/adc/ad4134-spi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 56bea005755d..e709ec1d6717 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1443,6 +1443,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
+F:	drivers/iio/adc/ad4134*
 
 ANALOG DEVICES INC AD4170-4 DRIVER
 M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 31335af6b2f1..d2a8ab5c1102 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -99,6 +99,21 @@ config AD4130
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad4130.
 
+config AD4134
+	tristate
+
+config AD4134_SPI
+	tristate "Analog Device AD4134 ADC Driver"
+	depends on SPI
+	select AD4134
+	select REGMAP_SPI
+	select CRC8
+	help
+	  Say yes here to build support for Analog Devices AD4134 SPI analog to
+	  digital converters (ADC).
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad4134_spi.
 
 config AD4170_4
 	tristate "Analog Device AD4170-4 ADC Driver"
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index e5349b01e4d9..b98ecf9709a6 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -13,6 +13,8 @@ obj-$(CONFIG_AD4000) += ad4000.o
 obj-$(CONFIG_AD4030) += ad4030.o
 obj-$(CONFIG_AD4080) += ad4080.o
 obj-$(CONFIG_AD4130) += ad4130.o
+obj-$(CONFIG_AD4134) += ad4134-common.o
+obj-$(CONFIG_AD4134_SPI) += ad4134-spi.o
 obj-$(CONFIG_AD4170_4) += ad4170-4.o
 obj-$(CONFIG_AD4695) += ad4695.o
 obj-$(CONFIG_AD4851) += ad4851.o
diff --git a/drivers/iio/adc/ad4134-common.c b/drivers/iio/adc/ad4134-common.c
new file mode 100644
index 000000000000..05332a640926
--- /dev/null
+++ b/drivers/iio/adc/ad4134-common.c
@@ -0,0 +1,200 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2025 Analog Devices, Inc.
+ * Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/crc8.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+#include "ad4134-common.h"
+
+const struct ad4134_chip_info ad4134_chip_info = {
+	.name = "ad4134",
+};
+EXPORT_SYMBOL_NS_GPL(ad4134_chip_info, "IIO_AD4134");
+
+static const struct regmap_range ad4134_regmap_rd_range[] = {
+	regmap_reg_range(AD4134_IFACE_CONFIG_A_REG, AD4134_SILICON_REV_REG),
+	regmap_reg_range(AD4134_SCRATCH_PAD_REG, AD4134_PW_DOWN_CTRL_REG),
+	regmap_reg_range(AD4134_DEVICE_STATUS_REG, AD4134_AIN_OR_ERROR_REG),
+	regmap_reg_range(AD4134_CH_VREG(0), AD4134_CH_VREG(AD4134_NUM_CHANNELS)),
+};
+
+static const struct regmap_range ad4134_regmap_wr_range[] = {
+	regmap_reg_range(AD4134_IFACE_CONFIG_A_REG, AD4134_DEVICE_CONFIG_REG),
+	regmap_reg_range(AD4134_SCRATCH_PAD_REG, AD4134_SCRATCH_PAD_REG),
+	regmap_reg_range(AD4134_STREAM_MODE_REG, AD4134_PW_DOWN_CTRL_REG),
+	regmap_reg_range(AD4134_ODR_VAL_INT_LSB_REG, AD4134_CH3_OFFSET_MSB_REG),
+};
+
+const struct regmap_access_table ad4134_regmap_rd_table = {
+	.yes_ranges = ad4134_regmap_rd_range,
+	.n_yes_ranges = ARRAY_SIZE(ad4134_regmap_rd_range),
+};
+EXPORT_SYMBOL_NS_GPL(ad4134_regmap_rd_table, "IIO_AD4134");
+
+const struct regmap_access_table ad4134_regmap_wr_table = {
+	.yes_ranges = ad4134_regmap_wr_range,
+	.n_yes_ranges = ARRAY_SIZE(ad4134_regmap_wr_range),
+};
+EXPORT_SYMBOL_NS_GPL(ad4134_regmap_wr_table, "IIO_AD4134");
+
+static const char * const ad4143_regulator_names[] = {
+	"avdd5", "dvdd5", "iovdd", "refin",	/* Required supplies */
+	"avdd1v8", "dvdd1v8", "clkvdd",		/* Required if ldoin not provided */
+	"ldoin",
+};
+
+static const char *const ad4134_clk_sel[] = {
+	"xtal1-xtal2", "clkin"
+};
+
+static int ad4134_clock_select(struct ad4134_state *st)
+{
+	struct device *dev = st->dev;
+	struct clk *sys_clk;
+	int ret;
+
+	ret = device_property_match_property_string(dev, "clock-names",
+						    ad4134_clk_sel,
+						    ARRAY_SIZE(ad4134_clk_sel));
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to find external clock\n");
+
+	sys_clk = devm_clk_get_enabled(dev, ad4134_clk_sel[ret]);
+	if (IS_ERR(sys_clk))
+		return dev_err_probe(dev, PTR_ERR(sys_clk),
+				     "failed to get %s external clock\n",
+				     ad4134_clk_sel[ret]);
+
+	st->sys_clk_rate = clk_get_rate(sys_clk);
+	if (st->sys_clk_rate != AD4134_EXT_CLOCK_MHZ)
+		dev_warn(dev, "invalid external clock frequency %lu\n",
+			 st->sys_clk_rate);
+
+	return 0;
+}
+
+int ad4134_probe(struct device *dev, const struct ad4134_bus_info *bus_info)
+{
+	bool use_internal_ldo_retulator;
+	struct gpio_desc *reset_gpio;
+	struct iio_dev *indio_dev;
+	struct ad4134_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->dev = dev;
+
+	indio_dev->name = bus_info->chip_info->name;
+
+	/* Required regulators */
+	ret = devm_regulator_bulk_get_enable(dev, 3, ad4143_regulator_names);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable power supplies\n");
+
+	/* Required regulator that we need to read the voltage */
+	ret = devm_regulator_get_enable_read_voltage(dev, "refin");
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to get REFIN voltage.\n");
+
+	st->refin_mv = ret / MILLI;
+
+	/*
+	 * If ldoin is not provided, then avdd1v8, dvdd1v8, and clkvdd are
+	 * required.
+	 */
+	ret = devm_regulator_get_enable_optional(dev, "ldoin");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "failed to enable ldoin supply\n");
+
+	use_internal_ldo_retulator = ret == 0;
+
+	if (!use_internal_ldo_retulator) {
+		ret = devm_regulator_get_enable(dev, "avdd1v8");
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+					     "failed to enable avdd1v8 supply\n");
+
+		ret = devm_regulator_get_enable(dev, "dvdd1v8");
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+					     "failed to enable dvdd1v8 supply\n");
+
+		ret = devm_regulator_get_enable(dev, "clkvdd");
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+					     "failed to enable clkvdd supply\n");
+	}
+
+	ret = ad4134_clock_select(st);
+	if (ret)
+		return ret;
+
+	crc8_populate_msb(ad4134_spi_crc_table, AD4134_SPI_CRC_POLYNOM);
+
+	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(reset_gpio),
+				     "failed to find reset GPIO\n");
+
+	if (reset_gpio) {
+		fsleep(AD4134_RESET_TIME_US);
+		gpiod_set_value_cansleep(reset_gpio, 0);
+	}
+
+	ret = bus_info->bops->config_iio_dev(indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to config IIO device\n");
+
+	st->regmap = bus_info->bops->init_regmap(st);
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(st->dev, PTR_ERR(st->regmap),
+				     "failed to initialize regmap");
+
+	/* wiring/configuration specific setup */
+	ret = bus_info->bops->setup(st);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to setup bus\n");
+
+	/* Bump precision to 24-bit */
+	st->current_scan_type = AD4134_DATA_PACKET_24BIT_FRAME;
+	ret = regmap_update_bits(st->regmap, AD4134_DATA_PACKET_CONFIG_REG,
+				 AD4134_DATA_PACKET_CONFIG_FRAME_MASK,
+				 FIELD_PREP(AD4134_DATA_PACKET_CONFIG_FRAME_MASK,
+					    st->current_scan_type));
+	if (ret)
+		return ret;
+
+	/* Set high performance power mode */
+	ret = regmap_update_bits(st->regmap, AD4134_DEVICE_CONFIG_REG,
+				 AD4134_DEVICE_CONFIG_POWER_MODE_MASK,
+				 FIELD_PREP(AD4134_DEVICE_CONFIG_POWER_MODE_MASK,
+					    AD4134_POWER_MODE_HIGH_PERF));
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+EXPORT_SYMBOL_NS_GPL(ad4134_probe, "IIO_AD4134");
+
+unsigned char ad4134_spi_crc_table[CRC8_TABLE_SIZE];
+EXPORT_SYMBOL_NS_GPL(ad4134_spi_crc_table, "IIO_AD4134");
+
+MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD4134 driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/iio/adc/ad4134-common.h b/drivers/iio/adc/ad4134-common.h
new file mode 100644
index 000000000000..c0a553d827c9
--- /dev/null
+++ b/drivers/iio/adc/ad4134-common.h
@@ -0,0 +1,132 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Analog Devices AD4134 and similar ADCs common definitions and properties
+ * Copyright (C) 2025 Analog Devices, Inc.
+ * Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
+ */
+
+#ifndef __DRIVERS_IIO_ADC_AD4134_COMMON_H__
+#define __DRIVERS_IIO_ADC_AD4134_COMMON_H__
+
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/compiler_attributes.h>
+#include <linux/crc8.h>
+#include <linux/iio/iio.h>
+#include <linux/units.h>
+#include <linux/types.h>
+
+#define AD4134_RESET_TIME_US			(10 * MICRO)
+
+#define AD4134_REG_READ_MASK			BIT(7)
+#define AD4134_SPI_MAX_XFER_LEN			3
+
+#define AD4134_EXT_CLOCK_MHZ			(48 * MEGA)
+
+#define AD4134_NUM_CHANNELS			4
+
+#define AD4134_IFACE_CONFIG_A_REG		0x00
+#define AD4134_IFACE_CONFIG_B_REG		0x01
+#define AD4134_IFACE_CONFIG_B_SINGLE_INSTR	BIT(7)
+
+#define AD4134_DEVICE_CONFIG_REG		0x02
+#define AD4134_DEVICE_CONFIG_POWER_MODE_MASK	BIT(0)
+#define AD4134_POWER_MODE_HIGH_PERF		0x1
+
+#define AD4134_SILICON_REV_REG			0x07
+#define AD4134_SCRATCH_PAD_REG			0x0A
+#define AD4134_STREAM_MODE_REG			0x0E
+#define AD4134_SDO_PIN_SRC_SEL_REG		0x10
+#define AD4134_SDO_PIN_SRC_SEL_SDO_SEL_MASK	BIT(2)
+
+#define AD4134_DATA_PACKET_CONFIG_REG		0x11
+#define AD4134_DATA_PACKET_CONFIG_FRAME_MASK	GENMASK(5, 4)
+#define AD4134_DATA_PACKET_16BIT_FRAME		0x0
+#define AD4134_DATA_PACKET_16BIT_CRC6_FRAME	0x1
+#define AD4134_DATA_PACKET_24BIT_FRAME		0x2
+#define AD4134_DATA_PACKET_24BIT_CRC6_FRAME	0x3
+
+#define AD4134_DIG_IF_CFG_REG			0x12
+#define AD4134_DIF_IF_CFG_FORMAT_MASK		GENMASK(1, 0)
+#define AD4134_DATA_FORMAT_SINGLE_CH_MODE	0x0
+
+#define AD4134_PW_DOWN_CTRL_REG			0x13
+#define AD4134_DEVICE_STATUS_REG		0x15
+#define AD4134_ODR_VAL_INT_LSB_REG		0x16
+#define AD4134_CH3_OFFSET_MSB_REG		0x3E
+#define AD4134_AIN_OR_ERROR_REG			0x48
+
+#define AD4134_CH_VREG(x)			((x) + 0x50) /* chanX virtual register */
+#define AD4134_VREG_CH(x)			((x) - 0x50) /* chan of virtual reg X */
+
+#define AD4134_SPI_CRC_POLYNOM			0x07
+#define AD4134_SPI_CRC_INIT_VALUE		0xA5
+extern unsigned char ad4134_spi_crc_table[CRC8_TABLE_SIZE];
+
+extern const struct regmap_access_table ad4134_regmap_rd_table;
+extern const struct regmap_access_table ad4134_regmap_wr_table;
+
+#define AD4134_SCAN_TYPE(_realbits, _storebits) {				\
+	.sign = 's',								\
+	.realbits = (_realbits),						\
+	.storagebits = (_storebits),						\
+	.shift = ((_storebits) - (_realbits)),					\
+	.endianness = IIO_BE							\
+}
+
+struct iio_scan_type ad4134_scan_types[] = {
+	AD4134_SCAN_TYPE(16, 16),
+	AD4134_SCAN_TYPE(16, 24),
+	AD4134_SCAN_TYPE(24, 24),
+	AD4134_SCAN_TYPE(24, 32),
+};
+
+#define AD4134_CHANNEL(_index) {						\
+	.type = IIO_VOLTAGE,							\
+	.indexed = 1,								\
+	.channel = (_index),							\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),				\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),			\
+	.scan_index = (_index),							\
+	.has_ext_scan_type = 1,							\
+	.ext_scan_type = ad4134_scan_types,					\
+	.num_ext_scan_type = ARRAY_SIZE(ad4134_scan_types)			\
+}
+
+struct device;
+
+struct ad4134_state {
+	struct device *dev;
+	struct regmap *regmap;
+	unsigned long sys_clk_rate;
+	int refin_mv;
+	struct gpio_desc *odr_gpio;
+	unsigned int current_scan_type;
+	/*
+	 * DMA (thus cache coherency maintenance) requires the transfer buffers
+	 * to live in their own cache lines.
+	 */
+	u8 rx_buf[AD4134_SPI_MAX_XFER_LEN] __aligned(IIO_DMA_MINALIGN);
+	u8 tx_buf[AD4134_SPI_MAX_XFER_LEN];
+};
+
+struct ad4134_chip_info {
+	const char *name;
+};
+
+extern const struct ad4134_chip_info ad4134_chip_info;
+
+struct ad4134_bus_ops {
+	int (*config_iio_dev)(struct iio_dev *indio_dev);
+	struct regmap *(*init_regmap)(struct ad4134_state *st);
+	int (*setup)(struct ad4134_state *st);
+};
+
+struct ad4134_bus_info {
+	const struct ad4134_chip_info *chip_info;
+	const struct ad4134_bus_ops *bops;
+};
+
+int ad4134_probe(struct device *dev, const struct ad4134_bus_info *bus_info);
+
+#endif /* __DRIVERS_IIO_ADC_AD4134_COMMON_H__ */
diff --git a/drivers/iio/adc/ad4134-spi.c b/drivers/iio/adc/ad4134-spi.c
new file mode 100644
index 000000000000..7d0749e5c084
--- /dev/null
+++ b/drivers/iio/adc/ad4134-spi.c
@@ -0,0 +1,287 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2025 Analog Devices, Inc.
+ * Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/bits.h>
+#include <linux/crc8.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+
+#include "ad4134-common.h"
+
+static const struct iio_chan_spec ad4134_chan_set[] = {
+	AD4134_CHANNEL(0),
+	AD4134_CHANNEL(1),
+	AD4134_CHANNEL(2),
+	AD4134_CHANNEL(3),
+};
+
+static int ad4134_calc_spi_crc(u8 inst, u8 data)
+{
+	u8 buf[] = {inst, data};
+
+	return crc8(ad4134_spi_crc_table, buf, ARRAY_SIZE(buf),
+		    AD4134_SPI_CRC_INIT_VALUE);
+}
+
+static void ad4134_prepare_spi_tx_buf(u8 inst, u8 data, u8 *buf)
+{
+	buf[0] = inst;
+	buf[1] = data;
+	buf[2] = ad4134_calc_spi_crc(inst, data);
+}
+
+static int ad4134_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct ad4134_state *st = context;
+	struct spi_device *spi = to_spi_device(st->dev);
+	struct spi_transfer xfer = {
+		.tx_buf = st->tx_buf,
+		.rx_buf = st->rx_buf,
+		.len = AD4134_SPI_MAX_XFER_LEN,
+	};
+	int ret;
+
+	ad4134_prepare_spi_tx_buf(reg, val, st->tx_buf);
+
+	ret = spi_sync_transfer(spi, &xfer, 1);
+	if (ret)
+		return ret;
+
+	if (st->rx_buf[2] != st->tx_buf[2])
+		dev_dbg(st->dev, "reg write CRC check failed\n");
+
+	return 0;
+}
+
+static int ad4134_data_read(struct ad4134_state *st, unsigned int reg,
+			    unsigned int *val)
+{
+	struct spi_device *spi = to_spi_device(st->dev);
+	struct iio_scan_type *scan_type = &ad4134_scan_types[st->current_scan_type];
+	unsigned int i;
+	int ret;
+
+	/*
+	 * Data from all four channels is serialized and output on SDO. Read
+	 * them all but keep only the requested data.
+	 */
+	for (i = 0; i < ARRAY_SIZE(ad4134_chan_set); i++) {
+		ret = spi_write_then_read(spi, NULL, 0, st->rx_buf,
+					  BITS_TO_BYTES(scan_type->storagebits));
+		if (ret)
+			return ret;
+
+		if (i != AD4134_VREG_CH(reg))
+			continue;
+
+		if (scan_type->realbits == 16)
+			*val = get_unaligned_be16(st->rx_buf);
+		else
+			*val = get_unaligned_be24(st->rx_buf);
+
+		*val >>= scan_type->shift;
+	}
+
+	return 0;
+}
+
+static int ad4134_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct ad4134_state *st = context;
+	struct spi_device *spi = to_spi_device(st->dev);
+	struct spi_transfer xfer = {
+		.tx_buf = st->tx_buf,
+		.rx_buf = st->rx_buf,
+		.len = AD4134_SPI_MAX_XFER_LEN,
+	};
+	unsigned int inst;
+	int ret;
+
+	if (reg >= AD4134_CH_VREG(0))
+		return ad4134_data_read(st, reg, val);
+
+	inst = AD4134_REG_READ_MASK | reg;
+	ad4134_prepare_spi_tx_buf(inst, 0, st->tx_buf);
+
+	ret = spi_sync_transfer(spi, &xfer, 1);
+	if (ret)
+		return ret;
+
+	*val = st->rx_buf[1];
+
+	/* Check CRC */
+	if (st->rx_buf[2] != st->tx_buf[2])
+		dev_dbg(st->dev, "reg read CRC check failed\n");
+
+	return 0;
+}
+
+static const struct regmap_config ad4134_regmap_config = {
+	.reg_read = ad4134_reg_read,
+	.reg_write = ad4134_reg_write,
+	.rd_table = &ad4134_regmap_rd_table,
+	.wr_table = &ad4134_regmap_wr_table,
+	.max_register = AD4134_CH_VREG(ARRAY_SIZE(ad4134_chan_set)),
+};
+
+static int ad4134_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long info)
+{
+	struct ad4134_state *st = iio_priv(indio_dev);
+	const struct iio_scan_type *scan_type;
+	int ret;
+
+	scan_type = iio_get_current_scan_type(indio_dev, chan);
+	if (IS_ERR(scan_type))
+		return PTR_ERR(scan_type);
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		gpiod_set_value_cansleep(st->odr_gpio, 1);
+		fsleep(1);
+		gpiod_set_value_cansleep(st->odr_gpio, 0);
+		ret = regmap_read(st->regmap, AD4134_CH_VREG(chan->channel), val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = st->refin_mv;
+		*val2 = scan_type->realbits - (scan_type->sign == 's' ? 1 : 0);
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4134_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+			     unsigned int writeval, unsigned int *readval)
+{
+	struct ad4134_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+
+	return regmap_write(st->regmap, reg, writeval);
+}
+
+static struct regmap *ad4134_minimum_io_regmap_init(struct ad4134_state *st)
+{
+	return devm_regmap_init(st->dev, NULL, st, &ad4134_regmap_config);
+}
+
+static int ad4134_get_current_scan_type(const struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan)
+{
+	struct ad4134_state *st = iio_priv(indio_dev);
+
+	return st->current_scan_type;
+}
+
+static int ad4134_min_io_mode_setup(struct ad4134_state *st)
+{
+	struct device *dev = st->dev;
+	int ret;
+
+	st->odr_gpio = devm_gpiod_get(dev, "odr", GPIOD_OUT_LOW);
+	if (IS_ERR(st->odr_gpio))
+		return dev_err_probe(dev, PTR_ERR(st->odr_gpio),
+				     "failed to get ODR GPIO\n");
+
+	ret = regmap_update_bits(st->regmap, AD4134_DIG_IF_CFG_REG,
+				 AD4134_DIF_IF_CFG_FORMAT_MASK,
+				 FIELD_PREP(AD4134_DIF_IF_CFG_FORMAT_MASK,
+					    AD4134_DATA_FORMAT_SINGLE_CH_MODE));
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(st->regmap, AD4134_SDO_PIN_SRC_SEL_REG,
+			      AD4134_SDO_PIN_SRC_SEL_SDO_SEL_MASK);
+	if (ret)
+		return ret;
+
+	return regmap_set_bits(st->regmap, AD4134_IFACE_CONFIG_B_REG,
+			       AD4134_IFACE_CONFIG_B_SINGLE_INSTR);
+}
+
+static const struct iio_info ad4134_info = {
+	.read_raw = ad4134_read_raw,
+	.get_current_scan_type = ad4134_get_current_scan_type,
+	.debugfs_reg_access = ad4134_reg_access,
+};
+
+static int ad4134_config_iio_dev(struct iio_dev *indio_dev)
+{
+	indio_dev->channels = ad4134_chan_set;
+	indio_dev->num_channels = ARRAY_SIZE(ad4134_chan_set);
+
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &ad4134_info;
+
+	return 0;
+};
+
+static const struct ad4134_bus_ops ad4134_min_io_bops = {
+	.config_iio_dev = &ad4134_config_iio_dev,
+	.init_regmap = &ad4134_minimum_io_regmap_init,
+	.setup = &ad4134_min_io_mode_setup,
+};
+
+static const struct ad4134_bus_info ad4134_min_io_bus_info = {
+	.chip_info = &ad4134_chip_info,
+	.bops = &ad4134_min_io_bops,
+};
+
+static int ad4134_spi_probe(struct spi_device *spi)
+{
+	const struct ad4134_bus_info *bus_info;
+
+	bus_info = spi_get_device_match_data(spi);
+	if (!bus_info)
+		return -EINVAL;
+
+	return ad4134_probe(&spi->dev, bus_info);
+}
+
+static const struct spi_device_id ad4134_id[] = {
+	{ "ad4134", (kernel_ulong_t)&ad4134_min_io_bus_info },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, ad4134_id);
+
+static const struct of_device_id ad4134_of_match[] = {
+	{ .compatible = "adi,ad4134", .data = &ad4134_min_io_bus_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad4134_of_match);
+
+static struct spi_driver ad4134_driver = {
+	.driver = {
+		.name = "ad4134",
+		.of_match_table = ad4134_of_match,
+	},
+	.probe = ad4134_spi_probe,
+	.id_table = ad4134_id,
+};
+module_spi_driver(ad4134_driver);
+
+MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD4134 SPI driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_AD4134");
-- 
2.51.0


