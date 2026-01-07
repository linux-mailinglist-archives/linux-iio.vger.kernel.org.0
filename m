Return-Path: <linux-iio+bounces-27522-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BD0CFE7A9
	for <lists+linux-iio@lfdr.de>; Wed, 07 Jan 2026 16:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3411B3075AEA
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jan 2026 15:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328ED350D47;
	Wed,  7 Jan 2026 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="LnRjsgzw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC45732D0E1;
	Wed,  7 Jan 2026 14:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767797308; cv=none; b=m7RCPfi9UYf5fNXXai7GtJpu5lgniA7MYRmHgxUijglK5t0Lqkv9oPgmWizEfTstBGOsJlGfFr7/D+UwWLD63S0+oM72DXnhCwcOHpAFSkONkfBnSk45fC2cpcAwTJAXFSqEK44VX4lcQGNvvnG0pfklG7pwgvz0rrDufBm3rP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767797308; c=relaxed/simple;
	bh=9EHV45aAoEzWV9Ixs+rGE7fUtzp/tfq4jnxI+f+gV5s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JQejpl1dNFDUDFxmlJZWrdfQ/bTq09kxP/+5LBkGzXvf1R2/yt2+60dvEDsgYMw/345iMfPFWMF2fruRHNvwshslvS+8XAS48ceop4iWqli0ivZhzD02z7quwHvF5aZTJcRNibVBcM6TlU8s8CLUAVaH8pwYNo40+m06oBCpZIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=LnRjsgzw; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 607EjXia3431543;
	Wed, 7 Jan 2026 09:48:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/nHEn
	liPam6fb6GMcUS9kWNAOB+fk2jo5n1O4P9DJg0=; b=LnRjsgzwZ+R9kfP59bNfa
	NNVvXj7/CLcNcBIfUYYaGN8AKrHpS8ITCZcRZFD+T/8WC6wGfpWLqVFe06kI4/0Z
	AkJsBzTXuDDq36FjoRt5KJu3knlx9VOCGrb4JBOJMzpFNCVg+1wqmKEVOKR60mfP
	AX5uVdMma5y3zdwVIMwRjxU3CN9G762taw3+booAWyh25K01fmdWWBNKm+az5ll/
	virbXvS+UZOMS0lPgglGhOH1uTNYUelBWLtz0dIs/SQBBHeL7gOcplbH1NSuwlvE
	C1c18NtxmrfY8fEwt+yRgueXxFpHNq65x+84DOEQvCd9DkbewVszXyBsk5iqLulQ
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4bhgcgk1gn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Jan 2026 09:48:17 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 607EmGuf065514
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Jan 2026 09:48:16 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 7 Jan
 2026 09:48:15 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 7 Jan 2026 09:48:15 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 607Em0RA004203;
	Wed, 7 Jan 2026 09:48:02 -0500
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <tomas.melin@vaisala.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 2/2] iio: adc: Initial support for AD4134
Date: Wed, 7 Jan 2026 11:47:59 -0300
Message-ID: <6ae8e203f6fb6e9718271132bd35daef790ab574.1767795849.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1767795849.git.marcelo.schmitt@analog.com>
References: <cover.1767795849.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDExNCBTYWx0ZWRfX2XKxUNOklahL
 +GPsYSCro9XM6Ko4jriQpo5E98GH7bCGrkrcJ8u07zWNqbo9Pq9Moo+Nx8TbaE2hbeI6Slf9vCK
 QgzzDV5LPa38a7Cah4CEJyxf1gyiL+bruo6YKUFqCGH1TSZq2XcG3Os3LDBp9z3I2PbNSUOS4QS
 isbD9KQ1RDF0tyl1OQYmixlzBSNTQKaIKCj/lU4MJ4k4wE4F+v4RZRRF56Epoip/OU4+h7pi4bZ
 4GGRCEJzEsYisA+3gCk3bQeI2kE+dmzX/659PaMnFg0emm6uuadAINsVf9a0xQ4WAfJEnpud4f9
 4h3M3LxtPscWPob3b4kQwIE7Pk0rYrdsBBz5fZLOU2avl3RLwfHnJY2YxCVaddIoKuDPsAL39c0
 llQnF+NerEYtLNiuify809Eni3egoD4xjgDihqLvNPCicpTUfIQJaFcGidBCYgbodJxtLV5+EOU
 HBLkL3JyV6rqmFVgHTw==
X-Proofpoint-ORIG-GUID: _Y6ORcJo_d1CXwoVT8Y7ybCzik6Tebtu
X-Authority-Analysis: v=2.4 cv=VsYuwu2n c=1 sm=1 tr=0 ts=695e7231 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8 a=VwQbUJbxAAAA:8
 a=THt8TSYBxwhYlH0bebcA:9
X-Proofpoint-GUID: _Y6ORcJo_d1CXwoVT8Y7ybCzik6Tebtu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-07_02,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0
 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601070114

AD4134 is a 24-bit, 4-channel, simultaneous sampling, precision
analog-to-digital converter (ADC). The device can be managed through SPI or
direct control of pin logical levels (pin control mode). The AD4134 design
also features a dedicated bus for ADC sample data output. Though, this
initial driver for AD4134 only supports usual SPI connections.

Add basic support for AD4134 that enables single-shot ADC sample read.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v3 -> v4:
- Added comment about minimum ODR high time.
- Split array of regulator names
- Updated to check for "xtal" clock name.
- Simplified voltage regulator initialization logic.
- Use reset framework to get and deassert device reset.
- Dropped ad4134 IIO documentation.

 MAINTAINERS              |   1 +
 drivers/iio/adc/Kconfig  |  11 +
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/ad4134.c | 501 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 514 insertions(+)
 create mode 100644 drivers/iio/adc/ad4134.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3f9f6dd96ae4..4dd9f758a871 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1464,6 +1464,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4134.yaml
+F:	drivers/iio/adc/ad4134.c
 
 ANALOG DEVICES INC AD4170-4 DRIVER
 M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 89a6486135f6..b4295aa415bf 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -112,6 +112,17 @@ config AD4130
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad4130.
 
+config AD4134
+	tristate "Analog Device AD4134 ADC Driver"
+	depends on SPI
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
index 0a199630c081..c76550415ff1 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_AD4030) += ad4030.o
 obj-$(CONFIG_AD4062) += ad4062.o
 obj-$(CONFIG_AD4080) += ad4080.o
 obj-$(CONFIG_AD4130) += ad4130.o
+obj-$(CONFIG_AD4134) += ad4134.o
 obj-$(CONFIG_AD4170_4) += ad4170-4.o
 obj-$(CONFIG_AD4695) += ad4695.o
 obj-$(CONFIG_AD4851) += ad4851.o
diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
new file mode 100644
index 000000000000..ec8c25efd66d
--- /dev/null
+++ b/drivers/iio/adc/ad4134.c
@@ -0,0 +1,501 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Analog Devices, Inc.
+ * Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/crc8.h>
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/types.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/reset.h>
+#include <linux/spi/spi.h>
+#include <linux/time.h>
+#include <linux/types.h>
+#include <linux/unaligned.h>
+#include <linux/units.h>
+
+#define AD4134_RESET_TIME_US			(10 * USEC_PER_SEC)
+
+#define AD4134_REG_READ_MASK			BIT(7)
+#define AD4134_SPI_MAX_XFER_LEN			3
+
+#define AD4134_EXT_CLOCK_MHZ			(48 * HZ_PER_MHZ)
+
+#define AD4134_NUM_CHANNELS			4
+#define AD4134_CHAN_PRECISION_BITS		24
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
+#define AD4134_DATA_PACKET_24BIT_FRAME		0x2
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
+/*
+ * AD4134 register map ends at address 0x48 and there is no register for
+ * retrieving ADC sample data. Though, to make use of Linux regmap API both
+ * for register access and sample read, we define one virtual register for each
+ * ADC channel. AD4134_CH_VREG(x) maps a channel number to it's virtual register
+ * address while AD4134_VREG_CH(x) tells which channel given the address.
+ */
+#define AD4134_CH_VREG(x)			((x) + 0x50)
+#define AD4134_VREG_CH(x)			((x) - 0x50)
+
+#define AD4134_SPI_CRC_POLYNOM			0x07
+#define AD4134_SPI_CRC_INIT_VALUE		0xA5
+static unsigned char ad4134_spi_crc_table[CRC8_TABLE_SIZE];
+
+#define AD4134_CHANNEL(_index) {						\
+	.type = IIO_VOLTAGE,							\
+	.indexed = 1,								\
+	.channel = (_index),							\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),				\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),			\
+}
+
+static const struct iio_chan_spec ad4134_chan_set[] = {
+	AD4134_CHANNEL(0),
+	AD4134_CHANNEL(1),
+	AD4134_CHANNEL(2),
+	AD4134_CHANNEL(3),
+};
+
+struct ad4134_state {
+	struct spi_device *spi;
+	struct regmap *regmap;
+	unsigned long sys_clk_hz;
+	struct gpio_desc *odr_gpio;
+	int refin_mv;
+	/*
+	 * DMA (thus cache coherency maintenance) requires the transfer buffers
+	 * to live in their own cache lines.
+	 */
+	u8 rx_buf[AD4134_SPI_MAX_XFER_LEN] __aligned(IIO_DMA_MINALIGN);
+	u8 tx_buf[AD4134_SPI_MAX_XFER_LEN];
+};
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
+static const struct regmap_access_table ad4134_regmap_rd_table = {
+	.yes_ranges = ad4134_regmap_rd_range,
+	.n_yes_ranges = ARRAY_SIZE(ad4134_regmap_rd_range),
+};
+
+static const struct regmap_access_table ad4134_regmap_wr_table = {
+	.yes_ranges = ad4134_regmap_wr_range,
+	.n_yes_ranges = ARRAY_SIZE(ad4134_regmap_wr_range),
+};
+
+static int ad4134_calc_spi_crc(u8 inst, u8 data)
+{
+	u8 buf[] = { inst, data };
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
+	struct spi_transfer xfer = {
+		.tx_buf = st->tx_buf,
+		.rx_buf = st->rx_buf,
+		.len = AD4134_SPI_MAX_XFER_LEN,
+	};
+	int ret;
+
+	ad4134_prepare_spi_tx_buf(reg, val, st->tx_buf);
+
+	ret = spi_sync_transfer(st->spi, &xfer, 1);
+	if (ret)
+		return ret;
+
+	if (st->rx_buf[2] != st->tx_buf[2])
+		dev_dbg(&st->spi->dev, "reg write CRC check failed\n");
+
+	return 0;
+}
+
+static int ad4134_data_read(struct ad4134_state *st, unsigned int reg,
+			    unsigned int *val)
+{
+	unsigned int i;
+	int ret;
+
+	/*
+	 * To be able to read data from all 4 channels through a single line, we
+	 * set DOUTx output format to 0 in the digital interface config register
+	 * (0x12). With that, data from all four channels is serialized and
+	 * output on DOUT0. During the probe, we also set SDO_PIN_SRC_SEL in
+	 * DEVICE_CONFIG_1 register to duplicate DOUT0 on the SDO pin. Combined,
+	 * those configurations enable ADC data read through a conventional SPI
+	 * interface. Now we read data from all channels but keep only the bits
+	 * from the requested one.
+	 */
+	for (i = 0; i < ARRAY_SIZE(ad4134_chan_set); i++) {
+		ret = spi_write_then_read(st->spi, NULL, 0, st->rx_buf,
+					  BITS_TO_BYTES(AD4134_CHAN_PRECISION_BITS));
+		if (ret)
+			return ret;
+
+		/*
+		 * AD4134 has a built-in feature that flags when data transfers
+		 * don't run enough clock cycles to read the entire data frame.
+		 * Clock out data from all channels to avoid that.
+		 */
+		if (i == AD4134_VREG_CH(reg))
+			*val = get_unaligned_be24(st->rx_buf);
+	}
+
+	return 0;
+}
+
+static int ad4134_register_read(struct ad4134_state *st, unsigned int reg,
+				unsigned int *val)
+{
+	struct spi_transfer xfer = {
+		.tx_buf = st->tx_buf,
+		.rx_buf = st->rx_buf,
+		.len = AD4134_SPI_MAX_XFER_LEN,
+	};
+	unsigned int inst;
+	int ret;
+
+	inst = AD4134_REG_READ_MASK | reg;
+	ad4134_prepare_spi_tx_buf(inst, 0, st->tx_buf);
+
+	ret = spi_sync_transfer(st->spi, &xfer, 1);
+	if (ret)
+		return ret;
+
+	*val = st->rx_buf[1];
+
+	/* Check CRC */
+	if (st->rx_buf[2] != st->tx_buf[2])
+		dev_dbg(&st->spi->dev, "reg read CRC check failed\n");
+
+	return 0;
+}
+
+static int ad4134_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct ad4134_state *st = context;
+
+	if (reg >= AD4134_CH_VREG(0))
+		return ad4134_data_read(st, reg, val);
+
+	return ad4134_register_read(st, reg, val);
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
+	int ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		gpiod_set_value_cansleep(st->odr_gpio, 1);
+		/*
+		 * For slave mode gated DCLK (data sheet page 11), the minimum
+		 * ODR high time is 3 * tDIGCLK. The internal digital clock
+		 * period is tDIGCLK = 1/fDIGCLK = 2/fSYSCLK.
+		 * The System clock frequency (fSYSCLK) is typically 48 MHz.
+		 * Thus, ODR high time = 3 * (2 / (48 * HZ_PER_MHZ))
+		 * ODR high time = 0.000000125 s = 125 ns
+		 * 1 micro second should be more than enough. Not worth it
+		 * tweaking for shorter dealy since this is not a fast data path.
+		 */
+		fsleep(1);
+		gpiod_set_value_cansleep(st->odr_gpio, 0);
+		ret = regmap_read(st->regmap, AD4134_CH_VREG(chan->channel), val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = st->refin_mv;
+		*val2 = AD4134_CHAN_PRECISION_BITS - 1;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4134_debugfs_reg_access(struct iio_dev *indio_dev,
+				     unsigned int reg, unsigned int writeval,
+				     unsigned int *readval)
+{
+	struct ad4134_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+
+	return regmap_write(st->regmap, reg, writeval);
+}
+
+static int ad4134_min_io_mode_setup(struct ad4134_state *st)
+{
+	struct device *dev = &st->spi->dev;
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
+		return dev_err_probe(dev, ret,
+				     "failed to set single channel mode\n");
+
+	ret = regmap_set_bits(st->regmap, AD4134_SDO_PIN_SRC_SEL_REG,
+			      AD4134_SDO_PIN_SRC_SEL_SDO_SEL_MASK);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to set SDO source selection\n");
+
+	return regmap_set_bits(st->regmap, AD4134_IFACE_CONFIG_B_REG,
+			       AD4134_IFACE_CONFIG_B_SINGLE_INSTR);
+}
+
+static const struct iio_info ad4134_info = {
+	.read_raw = ad4134_read_raw,
+	.debugfs_reg_access = ad4134_debugfs_reg_access,
+};
+
+static const char * const ad4143_required_regulators[] = {
+	"avdd5", "dvdd5", "iovdd",
+};
+
+static const char * const ad4143_optional_regulators[] = {
+	"avdd1v8", "dvdd1v8", "clkvdd",
+};
+
+static int ad4134_regulator_setup(struct ad4134_state *st)
+{
+	struct device *dev = &st->spi->dev;
+	int ret;
+
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ad4143_required_regulators),
+					     ad4143_required_regulators);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable power supplies\n");
+
+	/* Required regulator that we need to read the voltage */
+	ret = devm_regulator_get_enable_read_voltage(dev, "refin");
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to get REFIN voltage.\n");
+
+	st->refin_mv = ret / (MICRO / MILLI);
+
+	ret = devm_regulator_get_enable_optional(dev, "ldoin");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "failed to enable ldoin supply\n");
+
+	/* If ldoin was provided, then use the use the internal LDO regulators */
+	if (ret == 0)
+		return 0;
+
+	/*
+	 * If ldoin is not provided, then avdd1v8, dvdd1v8, and clkvdd are
+	 * required.
+	 */
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ad4143_optional_regulators),
+					     ad4143_optional_regulators);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable 1V8 power supplies\n");
+
+	return 0;
+}
+
+static int ad4134_clock_select(struct ad4134_state *st)
+{
+	struct device *dev = &st->spi->dev;
+	struct clk *xtal_clk, *clkin_clk;
+
+	/*
+	 * AD4134 requires one external clock source and only one external clock
+	 * source can be provided at a time. Try to get a crystal provided clock.
+	 * If that fails, try to get a CMOS clock.
+	 */
+	xtal_clk = devm_clk_get_optional_enabled(dev, "xtal");
+	if (!xtal_clk)
+		xtal_clk = devm_clk_get_optional_enabled(dev, "xtal");
+	if (IS_ERR(xtal_clk))
+		return dev_err_probe(dev, PTR_ERR(xtal_clk),
+				     "failed to get xtal\n");
+
+	clkin_clk = devm_clk_get_optional_enabled(dev, "clkin");
+	if (!clkin_clk)
+		clkin_clk = devm_clk_get_optional_enabled(dev, "clkin");
+	if (IS_ERR(clkin_clk))
+		return dev_err_probe(dev, PTR_ERR(clkin_clk),
+				     "failed to get clkin\n");
+
+	st->sys_clk_hz = clk_get_rate(xtal_clk) | clk_get_rate(clkin_clk);
+	if (st->sys_clk_hz != AD4134_EXT_CLOCK_MHZ)
+		dev_warn(dev, "invalid external clock frequency %lu\n",
+			 st->sys_clk_hz);
+
+	return 0;
+}
+
+static int ad4134_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct reset_control *rst;
+	struct iio_dev *indio_dev;
+	struct ad4134_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+
+	indio_dev->name = "ad4134";
+	indio_dev->channels = ad4134_chan_set;
+	indio_dev->num_channels = ARRAY_SIZE(ad4134_chan_set);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &ad4134_info;
+
+	ret = ad4134_regulator_setup(st);
+	if (ret)
+		return ret;
+
+	ret = ad4134_clock_select(st);
+	if (ret)
+		return ret;
+
+	rst = devm_reset_control_get_optional_exclusive_deasserted(dev, NULL);
+	if (IS_ERR(rst))
+		return dev_err_probe(dev, PTR_ERR(rst),
+				     "failed to get and deassert reset\n");
+
+	crc8_populate_msb(ad4134_spi_crc_table, AD4134_SPI_CRC_POLYNOM);
+
+	st->regmap = devm_regmap_init(dev, NULL, st, &ad4134_regmap_config);
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(dev, PTR_ERR(st->regmap),
+				     "failed to initialize regmap");
+
+	ret = ad4134_min_io_mode_setup(st);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to setup minimum I/O mode\n");
+
+	/* Bump precision to 24-bit */
+	ret = regmap_update_bits(st->regmap, AD4134_DATA_PACKET_CONFIG_REG,
+				 AD4134_DATA_PACKET_CONFIG_FRAME_MASK,
+				 FIELD_PREP(AD4134_DATA_PACKET_CONFIG_FRAME_MASK,
+					    AD4134_DATA_PACKET_24BIT_FRAME));
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
+
+static const struct spi_device_id ad4134_id[] = {
+	{ "ad4134" },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad4134_id);
+
+static const struct of_device_id ad4134_of_match[] = {
+	{ .compatible = "adi,ad4134" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad4134_of_match);
+
+static struct spi_driver ad4134_driver = {
+	.driver = {
+		.name = "ad4134",
+		.of_match_table = ad4134_of_match,
+	},
+	.probe = ad4134_probe,
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


