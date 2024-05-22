Return-Path: <linux-iio+bounces-5171-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8A88CC143
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 14:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45835281CD1
	for <lists+linux-iio@lfdr.de>; Wed, 22 May 2024 12:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D894C13D88E;
	Wed, 22 May 2024 12:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="UiHd59CM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3434613D623;
	Wed, 22 May 2024 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716380940; cv=none; b=GSyhFrbtr5gRTtJ4Fpw89iBsdnmsDMQEAh4LYCdEqj9Hvhcz2C7GgemZ0ffnNCFAdRHZl2LRgZ4oMC89sjgaEsDpEcfnZiGf6NJsqbcb2z/3gITyauajTiC0lI/AWdcWTrTJIH431wtqm6+vw33DgI32+jkzbDv/nsv3fKqeTLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716380940; c=relaxed/simple;
	bh=JjuhdknsnFiI0x17b2BbdbC5VGTA9zTRzomUZmJRcS8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Iqgs7XXqNwicU3WdgcOHaWnnYimxWl9bpK6OnHbaV0BDi/YSwc2hNB6ajH4nf5eP4RraBPjWI11RdR1vYPlD9ZpbLDHR5ztgSxLOHe6InotG8K2QeCUBZUuDCSy1STbI2gDkJXBwlQzAstQLmNqzIsOTG+9Um0KJaOvM3cIO0M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=UiHd59CM; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44M8dYea002020;
	Wed, 22 May 2024 08:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=DKIM; bh=1rol5gXrnKkQ
	qaMLW395d6z7tbNZYid16fy+wVtzHCk=; b=UiHd59CMYCg2efjeO83gbYeQ8J02
	Ruv330imt1dVn9Tt8GYqwl937DfC/Xx9jjoQV0EmyOnGjatC0s9M7+bucIx32Yqe
	uEC1giRa2WxMGeEc5OZ3850J6wg2ntjaA2qDlvZu10xAhuHU4GD9GDYoxgGwdMKT
	2IWKJQtrz9Fbmm60TB+U41Oa+LMe6SRS3R3uWGaACYtmY0shTpjX1gnsiCoTEbff
	kzslQ0TU7fOg6030a/YIPlQF3dpEWUNMRXYCp/w8qRYulYqPP+q+gK7ogG+eLaUi
	+e3I2A03dVREQmoe9Duvmme9KLvsodCavEpijWKeep630gnXDM256BIXpg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3y9dd00k3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 May 2024 08:01:04 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 44MC12IP039671
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 May 2024 08:01:02 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 22 May 2024 08:01:01 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 22 May 2024 08:01:01 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 22 May 2024 08:01:01 -0400
Received: from HYB-hYN1yfF7zRm.ad.analog.com (HYB-hYN1yfF7zRm.ad.analog.com [10.48.65.137])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 44MC0h2l013453;
	Wed, 22 May 2024 08:00:46 -0400
From: ranechita <ramona.nechita@analog.com>
To: <linux-iio@vger.kernel.org>
CC: ranechita <ramona.nechita@analog.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Mark
 Brown" <broonie@kernel.org>,
        Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>,
        Nuno Sa <nuno.sa@analog.com>,
        "Marius
 Cristea" <marius.cristea@microchip.com>,
        Marcelo Schmitt
	<marcelo.schmitt@analog.com>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        "Ivan
 Mikhaylov" <fr0st61te@gmail.com>,
        Marcus Folkesson
	<marcus.folkesson@gmail.com>,
        Liam Beguin <liambeguin@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers: iio: adc: add support for ad777x family
Date: Wed, 22 May 2024 14:59:53 +0300
Message-ID: <20240522120005.18197-1-ramona.nechita@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: djH2Z7R48mCZM4Q_Qr7YQzbi8yCZ-bkJ
X-Proofpoint-GUID: djH2Z7R48mCZM4Q_Qr7YQzbi8yCZ-bkJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_05,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1011 priorityscore=1501 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405220080

Added support for ad7770,ad7771,ad7779 ADCs. The
data is streamed only on the spi-mode, without
using the data lines.

Signed-off-by: ranechita <ramona.nechita@analog.com>
---
 drivers/iio/adc/Kconfig  |   11 +
 drivers/iio/adc/Makefile |    1 +
 drivers/iio/adc/ad7779.c | 1182 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 1194 insertions(+)
 create mode 100644 drivers/iio/adc/ad7779.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 0d9282fa67f5..3e42cbc365d7 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -206,6 +206,17 @@ config AD7768_1
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad7768-1.
 
+config AD7779
+	tristate "Analog Devices AD7779 ADC driver"
+	depends on SPI
+	select IIO_BUFFER
+	help
+	  Say yes here to build support for Analog Devices AD7779 SPI
+	  analog to digital converter (ADC)
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad7779.
+
 config AD7780
 	tristate "Analog Devices AD7780 and similar ADCs driver"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index b3c434722364..e25997e926bb 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
 obj-$(CONFIG_AD7606) += ad7606.o
 obj-$(CONFIG_AD7766) += ad7766.o
 obj-$(CONFIG_AD7768_1) += ad7768-1.o
+obj-$(CONFIG_AD7779) += ad7779.o
 obj-$(CONFIG_AD7780) += ad7780.o
 obj-$(CONFIG_AD7791) += ad7791.o
 obj-$(CONFIG_AD7793) += ad7793.o
diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
new file mode 100644
index 000000000000..d2c1b14464ff
--- /dev/null
+++ b/drivers/iio/adc/ad7779.c
@@ -0,0 +1,1182 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * AD777X ADC
+ *
+ * Copyright 2023 Analog Devices Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/crc8.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/string.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/kfifo_buf.h>
+#include <linux/iio/sysfs.h>
+
+#include "cf_axi_adc.h"
+
+#define AD777X_SPI_READ_CMD			BIT(7)
+
+#define AD777X_DISABLE_SD			BIT(7)
+
+#define AD777X_REG_CH_DISABLE			0x08
+#define AD777X_REG_CH_SYNC_OFFSET(ch)		(0x09 + (ch))
+#define AD777X_REG_CH_CONFIG(ch)		(0x00 + (ch))
+#define AD777X_REG_GENERAL_USER_CONFIG_1	0x11
+#define AD777X_REG_GENERAL_USER_CONFIG_2	0x12
+#define AD777X_REG_GENERAL_USER_CONFIG_3	0x13
+#define AD777X_REG_DOUT_FORMAT			0x14
+#define AD777X_REG_ADC_MUX_CONFIG		0x15
+#define AD777X_REG_GPIO_CONFIG			0x17
+#define AD777X_REG_BUFFER_CONFIG_1		0x19
+#define AD777X_REG_GLOBAL_MUX_CONFIG		0x16
+#define AD777X_REG_BUFFER_CONFIG_2		0x1A
+#define AD777X_REG_GPIO_DATA			0x18
+#define AD777X_REG_CH_OFFSET_UPPER_BYTE(ch)	(0x1C + (ch) * 6)
+#define AD777X_REG_CH_OFFSET_LOWER_BYTE(ch)	(0x1E + (ch) * 6)
+#define AD777X_REG_CH_GAIN_UPPER_BYTE(ch)	(0x1F + (ch) * 6)
+#define AD777X_REG_CH_OFFSET_MID_BYTE(ch)	(0x1D + (ch) * 6)
+#define AD777X_REG_CH_GAIN_MID_BYTE(ch)		(0x20 + (ch) * 6)
+#define AD777X_REG_CH_ERR_REG(ch)		(0x4C + (ch))
+#define AD777X_REG_CH0_1_SAT_ERR		0x54
+#define AD777X_REG_CH_GAIN_LOWER_BYTE(ch)	(0x21 + (ch) * 6)
+#define AD777X_REG_CH2_3_SAT_ERR		0x55
+#define AD777X_REG_CH4_5_SAT_ERR		0x56
+#define AD777X_REG_CH6_7_SAT_ERR		0x57
+#define AD777X_REG_CHX_ERR_REG_EN		0x58
+#define AD777X_REG_GEN_ERR_REG_1		0x59
+#define AD777X_REG_GEN_ERR_REG_1_EN		0x5A
+#define AD777X_REG_GEN_ERR_REG_2		0x5B
+#define AD777X_REG_GEN_ERR_REG_2_EN		0x5C
+#define AD777X_REG_STATUS_REG_1			0x5D
+#define AD777X_REG_STATUS_REG_2			0x5E
+#define AD777X_REG_STATUS_REG_3			0x5F
+#define AD777X_REG_SRC_N_MSB			0x60
+#define AD777X_REG_SRC_N_LSB			0x61
+#define AD777X_REG_SRC_IF_MSB			0x62
+#define AD777X_REG_SRC_IF_LSB			0x63
+#define AD777X_REG_SRC_UPDATE			0x64
+
+#define AD777X_FILTER_MSK			BIT(6)
+#define AD777X_MOD_POWERMODE_MSK		BIT(6)
+#define AD777X_MOD_PDB_REFOUT_MSK		BIT(4)
+#define AD777X_MOD_SPI_EN_MSK			BIT(4)
+
+/* AD777X_REG_DOUT_FORMAT */
+#define AD777X_DOUT_FORMAT_MSK			GENMASK(7, 6)
+#define AD777X_DOUT_HEADER_FORMAT		BIT(5)
+#define AD777X_DCLK_CLK_DIV_MSK			GENMASK(3, 1)
+
+#define AD777X_REFMUX_CTRL_MSK			GENMASK(7, 6)
+#define AD777X_SPI_CRC_EN_MSK			BIT(0)
+
+#define AD777X_MAXCLK_LOWPOWER			4096000
+#define AD777X_NUM_CHANNELS			8
+#define AD777X_RESET_BUF_SIZE			8
+
+#define AD777X_LOWPOWER_DIV			512
+#define AD777X_HIGHPOWER_DIV			2048
+
+#define AD777X_SINC3_MAXFREQ			16000
+#define AD777X_SINC5_MAXFREQ			128000
+
+#define AD777X_DEFAULT_SAMPLING_FREQ		8000
+#define AD777X_DEFAULT_SAMPLING_2LINE		4000
+#define AD777X_DEFAULT_SAMPLING_1LINE		2000
+
+#define AD777X_SPIMODE_MAX_SAMP_FREQ		16000
+
+/* AXI CONTROL REGS VALUES FOR DATA LINES */
+#define AXI_CTRL_4_LINES			0x400
+#define AXI_CTRL_2_LINES			0x200
+#define AXI_CTRL_1_LINE				0x100
+
+#define DEC3					1000
+#define DEC6					1000000
+
+#define GAIN_REL				0x555555
+#define AD777X_FREQ_MSB_MSK			GENMASK(15, 8)
+#define AD777X_FREQ_LSB_MSK			GENMASK(7, 0)
+#define AD777X_UPPER				GENMASK(23, 16)
+#define AD777X_MID				GENMASK(15, 8)
+#define AD777X_LOWER				GENMASK(7, 0)
+
+#define AD777X_CRC8_POLY			0x07
+DECLARE_CRC8_TABLE(ad777x_crc8_table);
+
+enum ad777x_data_lines {
+	AD777x_4LINES,
+	AD777x_2LINES,
+	AD777x_1LINE,
+};
+
+enum ad777x_filter {
+	AD777X_SINC3,
+	AD777X_SINC5,
+};
+
+enum ad777x_variant {
+	ad7770,
+	ad7771,
+	ad7779,
+};
+
+enum ad777x_power_mode {
+	AD777X_LOW_POWER,
+	AD777X_HIGH_POWER,
+};
+
+struct ad777x_chip_info {
+	const char *name;
+};
+
+struct ad777x_state {
+	struct spi_device		*spi;
+	const struct ad777x_chip_info	*chip_info;
+	struct clk			*mclk;
+	struct regulator		*vref;
+	unsigned int			sampling_freq;
+	enum ad777x_power_mode		power_mode;
+	enum ad777x_data_lines		data_lines;
+	enum ad777x_filter		filter_enabled;
+	unsigned int			active_ch;
+	unsigned int			spidata_mode;
+	unsigned int			crc_enabled;
+
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 */
+	u8			reg_rx_buf[3] ____cacheline_aligned;
+	u8			reg_tx_buf[3];
+	u8			spidata_rx[32];
+	u8			spidata_tx[32];
+	u8			reset_buf[8];
+};
+
+static const char * const ad777x_filter_type[] = {
+	[AD777X_SINC3] = "sinc3_filter",
+	[AD777X_SINC5] = "sinc5_filter",
+};
+
+static const char * const ad777x_data_lines_modes[] = {
+	[AD777x_4LINES] = "4_data_lines",
+	[AD777x_2LINES] = "2_data_lines",
+	[AD777x_1LINE]  = "1_data_line",
+};
+
+static bool ad777x_has_axi_adc(struct device *dev)
+{
+	return device_property_present(dev, "spibus-connected");
+}
+
+static struct ad777x_state *ad777x_get_data(struct iio_dev *indio_dev)
+{
+	struct axiadc_converter *conv;
+
+	if (ad777x_has_axi_adc(&indio_dev->dev)) {
+		conv = iio_device_get_drvdata(indio_dev);
+		return conv->phy;
+	}
+
+	return iio_priv(indio_dev);
+}
+
+static int ad777x_spi_read(struct ad777x_state *st, u8 reg, u8 *rbuf)
+{
+	int ret;
+	int length = 2;
+	u8 crc_buf[2];
+	u8 exp_crc = 0;
+	struct spi_transfer reg_read_tr[] = {
+		{
+			.tx_buf = st->reg_tx_buf,
+			.rx_buf = st->reg_rx_buf,
+		},
+	};
+
+	if (st->crc_enabled)
+		length = 3;
+	reg_read_tr[0].len = length;
+
+	st->reg_tx_buf[0] = AD777X_SPI_READ_CMD | (reg & 0x7F);
+	st->reg_tx_buf[1] = 0;
+	st->reg_tx_buf[2] = crc8(ad777x_crc8_table, st->reg_tx_buf, 2, 0);
+
+	ret = spi_sync_transfer(st->spi, reg_read_tr,
+				ARRAY_SIZE(reg_read_tr));
+
+	crc_buf[0] = AD777X_SPI_READ_CMD | (reg & 0x7F);
+	crc_buf[1] = st->reg_rx_buf[1];
+	exp_crc = crc8(ad777x_crc8_table, crc_buf, 2, 0);
+	if (st->crc_enabled && exp_crc != st->reg_rx_buf[2]) {
+		dev_err(&st->spi->dev, "Bad CRC %x, expected %x",
+			st->reg_rx_buf[2], exp_crc);
+		return -EINVAL;
+	}
+	*rbuf = st->reg_rx_buf[1];
+
+	return ret;
+}
+
+static int ad777x_spi_write(struct ad777x_state *st, u8 reg, u8 val)
+{
+	int length = 2;
+	struct spi_transfer reg_write_tr[] = {
+		{
+			.tx_buf = st->reg_tx_buf,
+		},
+	};
+
+	if (st->crc_enabled)
+		length = 3;
+	reg_write_tr[0].len = length;
+
+	st->reg_tx_buf[0] = reg & 0x7F;
+	st->reg_tx_buf[1] = val;
+	st->reg_tx_buf[2] = crc8(ad777x_crc8_table, st->reg_tx_buf, 2, 0);
+
+	return spi_sync_transfer(st->spi, reg_write_tr,
+				ARRAY_SIZE(reg_write_tr));
+}
+
+static int ad777x_spi_write_mask(struct ad777x_state *st,
+				 u8 reg,
+				 u8 mask,
+				 u8 val)
+{
+	int ret;
+	u8 regval, data;
+
+	ret = ad777x_spi_read(st, reg, &data);
+	if (ret)
+		return ret;
+
+	regval = data;
+	regval &= ~mask;
+	regval |= val;
+
+	if (regval != data) {
+		ret = ad777x_spi_write(st, reg, regval);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int ad777x_reg_access(struct iio_dev *indio_dev,
+			     unsigned int reg,
+			     unsigned int writeval,
+			     unsigned int *readval)
+{
+	struct ad777x_state *st = ad777x_get_data(indio_dev);
+
+	if (readval)
+		return ad777x_spi_read(st, reg, (u8 *)readval);
+
+	return ad777x_spi_write(st, reg, writeval);
+}
+
+static int ad777x_set_sampling_frequency(struct ad777x_state *st,
+					 unsigned int sampling_freq)
+{
+	int ret;
+	unsigned int dec;
+	unsigned int div;
+	unsigned int decimal;
+	int temp;
+	unsigned int kfreq;
+	u8 msb, lsb;
+
+	if (st->filter_enabled == AD777X_SINC3 &&
+	    sampling_freq > AD777X_SINC3_MAXFREQ) {
+		return -EINVAL;
+	} else if (st->filter_enabled == AD777X_SINC5 &&
+		   sampling_freq > AD777X_SINC5_MAXFREQ) {
+		return -EINVAL;
+	}
+
+	if (st->spidata_mode == 1 &&
+	    sampling_freq > AD777X_SPIMODE_MAX_SAMP_FREQ)
+		return -EINVAL;
+
+	if (st->power_mode == AD777X_LOW_POWER)
+		div = AD777X_LOWPOWER_DIV;
+	else
+		div = AD777X_HIGHPOWER_DIV;
+
+	kfreq = sampling_freq / DEC3;
+	dec = div / kfreq;
+
+	lsb = FIELD_GET(AD777X_FREQ_LSB_MSK, dec);
+	msb = FIELD_GET(AD777X_FREQ_MSB_MSK, dec);
+
+	ret = ad777x_spi_write(st, AD777X_REG_SRC_N_LSB, lsb);
+	if (ret)
+		return ret;
+	ret = ad777x_spi_write(st, AD777X_REG_SRC_N_MSB, msb);
+	if (ret)
+		return ret;
+
+	if (div % kfreq != 0) {
+		temp = (div * DEC3) / kfreq;
+		decimal = ((temp -  dec * DEC3) << 16) / DEC3;
+		lsb = FIELD_GET(AD777X_FREQ_LSB_MSK, decimal);
+		msb = FIELD_GET(AD777X_FREQ_MSB_MSK, decimal);
+
+		ret = ad777x_spi_write(st, AD777X_REG_SRC_IF_LSB, lsb);
+		if (ret)
+			return ret;
+		ret = ad777x_spi_write(st, AD777X_REG_SRC_IF_MSB, msb);
+		if (ret)
+			return ret;
+	} else {
+		ret = ad777x_spi_write(st, AD777X_REG_SRC_IF_LSB, 0x0);
+		if (ret)
+			return ret;
+		ret = ad777x_spi_write(st, AD777X_REG_SRC_IF_MSB, 0x0);
+		if (ret)
+			return ret;
+	}
+	ret |= ad777x_spi_write(st, AD777X_REG_SRC_UPDATE, 0x1);
+	if (ret)
+		return ret;
+	usleep_range(10, 15);
+	ret |= ad777x_spi_write(st, AD777X_REG_SRC_UPDATE, 0x0);
+	if (ret)
+		return ret;
+	usleep_range(10, 15);
+
+	st->sampling_freq = sampling_freq;
+
+	return 0;
+}
+
+static int ad777x_set_data_lines(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan,
+				 unsigned int mode)
+{
+	struct ad777x_state *st = ad777x_get_data(indio_dev);
+	struct axiadc_state *axi_adc_st = iio_priv(indio_dev);
+	int ret;
+
+	if (st->spidata_mode)
+		return 0;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = ad777x_spi_write_mask(st, AD777X_REG_DOUT_FORMAT,
+				    AD777X_DOUT_FORMAT_MSK,
+				    FIELD_PREP(AD777X_DOUT_FORMAT_MSK,
+					       mode));
+	switch (mode) {
+	case AD777x_4LINES:
+		ret = ad777x_set_sampling_frequency(st,
+						    AD777X_DEFAULT_SAMPLING_FREQ);
+		if (ret)
+			return ret;
+		axiadc_write(axi_adc_st, ADI_REG_CNTRL, AXI_CTRL_4_LINES);
+		break;
+	case AD777x_2LINES:
+		ret = ad777x_set_sampling_frequency(st,
+						    AD777X_DEFAULT_SAMPLING_2LINE);
+		if (ret)
+			return ret;
+		axiadc_write(axi_adc_st, ADI_REG_CNTRL, AXI_CTRL_2_LINES);
+		break;
+	case AD777x_1LINE:
+		ret = ad777x_set_sampling_frequency(st,
+						    AD777X_DEFAULT_SAMPLING_1LINE);
+		if (ret)
+			return ret;
+		axiadc_write(axi_adc_st, ADI_REG_CNTRL, AXI_CTRL_1_LINE);
+		break;
+	default:
+		return -EINVAL;
+	}
+	iio_device_release_direct_mode(indio_dev);
+
+	st->data_lines = mode;
+
+	return 0;
+}
+
+static int ad777x_get_data_lines(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan)
+{
+	struct ad777x_state *st = ad777x_get_data(indio_dev);
+	u8 temp;
+	int ret;
+
+	ret = ad777x_spi_read(st, AD777X_REG_DOUT_FORMAT, &temp);
+	if (ret)
+		return ret;
+
+	return FIELD_GET(AD777X_DOUT_FORMAT_MSK, temp);
+}
+
+static int ad777x_get_filter(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan)
+{
+	struct ad777x_state *st = ad777x_get_data(indio_dev);
+	u8 temp;
+	int ret;
+
+	ret = ad777x_spi_read(st, AD777X_REG_GENERAL_USER_CONFIG_2, &temp);
+	if (ret)
+		return ret;
+
+	return FIELD_GET(AD777X_FILTER_MSK, temp);
+}
+
+static int ad777x_set_filter(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     unsigned int mode)
+{
+	struct ad777x_state *st = ad777x_get_data(indio_dev);
+	int ret = 0;
+
+	ret = ad777x_spi_write_mask(st,
+				    AD777X_REG_GENERAL_USER_CONFIG_2,
+				    AD777X_FILTER_MSK,
+				    FIELD_PREP(AD777X_FILTER_MSK, mode));
+	if (ret < 0)
+		return ret;
+
+	ret = ad777x_set_sampling_frequency(st, st->sampling_freq);
+	if (ret < 0)
+		return ret;
+
+	st->filter_enabled = mode;
+
+	return 0;
+}
+
+static int ad777x_get_calibscale(struct ad777x_state *st, int channel)
+{
+	int ret;
+	u8 low, mid, high;
+
+	ret = ad777x_spi_read(st, AD777X_REG_CH_GAIN_LOWER_BYTE(channel), &low);
+	if (ret)
+		return ret;
+	ret = ad777x_spi_read(st, AD777X_REG_CH_GAIN_MID_BYTE(channel), &mid);
+	if (ret)
+		return ret;
+	ret = ad777x_spi_read(st, AD777X_REG_CH_GAIN_UPPER_BYTE(channel), &high);
+	if (ret)
+		return ret;
+
+	return FIELD_PREP(AD777X_UPPER, high) | FIELD_PREP(AD777X_MID, mid) |
+	       FIELD_PREP(AD777X_LOWER, low);
+}
+
+static int ad777x_set_calibscale(struct ad777x_state *st, int channel, int val)
+{
+	int ret;
+	u8 msb, mid, lsb;
+	unsigned int gain;
+	unsigned long long tmp;
+
+	tmp = val * 5592405LL;
+	gain = DIV_ROUND_CLOSEST_ULL(tmp, DEC6);
+	msb = FIELD_GET(AD777X_UPPER, gain);
+	mid = FIELD_GET(AD777X_MID, gain);
+	lsb = FIELD_GET(AD777X_LOWER, gain);
+	ret = ad777x_spi_write(st,
+			       AD777X_REG_CH_GAIN_UPPER_BYTE(channel),
+			       msb);
+	if (ret)
+		return ret;
+	ret = ad777x_spi_write(st,
+			       AD777X_REG_CH_GAIN_MID_BYTE(channel),
+			       mid);
+	if (ret)
+		return ret;
+	return ad777x_spi_write(st,
+				AD777X_REG_CH_GAIN_LOWER_BYTE(channel),
+				lsb);
+}
+
+static int ad777x_get_calibbias(struct ad777x_state *st, int channel)
+{
+	int ret;
+	u8 low, mid, high;
+
+	ret = ad777x_spi_read(st, AD777X_REG_CH_OFFSET_LOWER_BYTE(channel),
+			      &low);
+	if (ret)
+		return ret;
+	ret = ad777x_spi_read(st, AD777X_REG_CH_OFFSET_MID_BYTE(channel), &mid);
+	if (ret)
+		return ret;
+	ret = ad777x_spi_read(st,
+			      AD777X_REG_CH_OFFSET_UPPER_BYTE(channel),
+			      &high);
+	if (ret)
+		return ret;
+
+	return FIELD_PREP(AD777X_UPPER, high) | FIELD_PREP(AD777X_MID, mid) |
+	       FIELD_PREP(AD777X_LOWER, low);
+}
+
+static int ad777x_set_calibbias(struct ad777x_state *st, int channel, int val)
+{
+	int ret;
+	u8 msb, mid, lsb;
+
+	msb = FIELD_GET(AD777X_UPPER, val);
+	mid = FIELD_GET(AD777X_MID, val);
+	lsb = FIELD_GET(AD777X_LOWER, val);
+	ret = ad777x_spi_write(st,
+			       AD777X_REG_CH_OFFSET_UPPER_BYTE(channel),
+			       msb);
+	if (ret)
+		return ret;
+	ret = ad777x_spi_write(st,
+			       AD777X_REG_CH_OFFSET_MID_BYTE(channel),
+			       mid);
+	if (ret)
+		return ret;
+	return ad777x_spi_write(st,
+				AD777X_REG_CH_OFFSET_LOWER_BYTE(channel),
+				lsb);
+}
+
+static int ad777x_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val,
+			   int *val2,
+			   long mask)
+{
+	struct ad777x_state *st = ad777x_get_data(indio_dev);
+	int ret;
+
+	ret = iio_device_claim_direct_mode(indio_dev);
+	if (ret)
+		return ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_CALIBSCALE:
+		*val = ad777x_get_calibscale(st, chan->channel);
+		iio_device_release_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		*val2 = GAIN_REL;
+		return IIO_VAL_FRACTIONAL;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		*val = ad777x_get_calibbias(st, chan->channel);
+		iio_device_release_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = st->sampling_freq;
+		iio_device_release_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
+	}
+
+	iio_device_release_direct_mode(indio_dev);
+
+	return -EINVAL;
+}
+
+static int ad777x_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val,
+			    int val2,
+			    long mask)
+{
+	struct ad777x_state *st = ad777x_get_data(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_CALIBSCALE:
+		return ad777x_set_calibscale(st, chan->channel, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return ad777x_set_calibbias(st, chan->channel, val);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return ad777x_set_sampling_frequency(st, val);
+	}
+
+	return -EINVAL;
+}
+
+static int ad777x_update_scan_mode(struct iio_dev *indio_dev,
+				   const unsigned long *scan_mask)
+{
+	struct ad777x_state *st = ad777x_get_data(indio_dev);
+	int i;
+	u8 bit;
+
+	for (i = 0; i < AD777X_NUM_CHANNELS; i++) {
+		bit = test_bit(i, scan_mask);
+		if (bit)
+			st->active_ch |= BIT(i);
+		else
+			st->active_ch &= ~BIT(i);
+	}
+
+	return 0;
+}
+
+static int ad777x_buffer_postenable(struct iio_dev *indio_dev)
+{
+	int ret;
+	struct ad777x_state *st = ad777x_get_data(indio_dev);
+
+	ret = ad777x_spi_write_mask(st,
+				    AD777X_REG_GENERAL_USER_CONFIG_3,
+				    AD777X_MOD_SPI_EN_MSK,
+				    FIELD_PREP(AD777X_MOD_SPI_EN_MSK, 1));
+	if (ret)
+		return ret;
+	enable_irq(st->spi->irq);
+
+	return 0;
+}
+
+static int ad777x_buffer_predisable(struct iio_dev *indio_dev)
+{
+	int ret;
+	struct ad777x_state *st = ad777x_get_data(indio_dev);
+
+	disable_irq_nosync(st->spi->irq);
+	ret = ad777x_spi_write(st,
+			       AD777X_REG_GENERAL_USER_CONFIG_3,
+			       AD777X_DISABLE_SD);
+	return ret;
+}
+
+static irqreturn_t ad777x_irq_handler(int irq, void *data)
+{
+	struct iio_dev *indio_dev = data;
+	struct ad777x_state *st = ad777x_get_data(indio_dev);
+	int ret;
+	u8 tmp[32];
+	int i;
+	int k = 0;
+
+	struct spi_transfer sd_readback_tr[] = {
+		{
+			.rx_buf = st->spidata_rx,
+			.tx_buf = st->spidata_tx,
+			.len = 32,
+		}
+	};
+
+	if (iio_buffer_enabled(indio_dev)) {
+		st->spidata_tx[0] = AD777X_SPI_READ_CMD;
+		ret = spi_sync_transfer(st->spi, sd_readback_tr,
+					ARRAY_SIZE(sd_readback_tr));
+		if (ret) {
+			dev_err(&st->spi->dev,
+				"spi transfer error in irq handler");
+			return IRQ_HANDLED;
+		}
+		for (i = 0; i < AD777X_NUM_CHANNELS; i++) {
+			if (st->active_ch & BIT(i)) {
+				tmp[k] = st->spidata_rx[4 * i];
+				tmp[k + 1] = st->spidata_rx[4 * i + 1];
+				tmp[k + 2] = st->spidata_rx[4 * i + 2];
+				tmp[k + 3] = st->spidata_rx[4 * i + 3];
+				k += 4;
+			}
+		}
+		iio_push_to_buffers(indio_dev, &tmp[0]);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int ad777x_reset(struct iio_dev *indio_dev, struct gpio_desc *reset_gpio)
+{
+	struct ad777x_state *st = iio_priv(indio_dev);
+	int ret;
+	int i;
+	struct spi_transfer reg_read_tr[] = {
+		{
+			.tx_buf = st->reset_buf,
+			.len = 8,
+		},
+	};
+
+	for (i = 0; i < AD777X_RESET_BUF_SIZE; i++)
+		st->reset_buf[i] = 0xFF;
+
+	if (reset_gpio) {
+		gpiod_set_value(reset_gpio, 1);
+		usleep_range(225, 230);
+		return 0;
+	}
+
+	ret = spi_sync_transfer(st->spi, reg_read_tr,
+				ARRAY_SIZE(reg_read_tr));
+	if (ret)
+		return ret;
+	usleep_range(225, 230);
+
+	return 0;
+}
+
+static const struct iio_info ad777x_info = {
+	.read_raw = ad777x_read_raw,
+	.write_raw = ad777x_write_raw,
+	.debugfs_reg_access = &ad777x_reg_access,
+	.update_scan_mode = &ad777x_update_scan_mode,
+};
+
+static const struct iio_enum ad777x_data_lines_enum = {
+	.items = ad777x_data_lines_modes,
+	.num_items = ARRAY_SIZE(ad777x_data_lines_modes),
+	.get = ad777x_get_data_lines,
+	.set = ad777x_set_data_lines,
+};
+
+static const struct iio_enum ad777x_filter_enum = {
+	.items = ad777x_filter_type,
+	.num_items = ARRAY_SIZE(ad777x_filter_type),
+	.get = ad777x_get_filter,
+	.set = ad777x_set_filter,
+};
+
+static const struct iio_chan_spec_ext_info ad777x_ext_info[] = {
+	IIO_ENUM("data_lines", IIO_SHARED_BY_ALL, &ad777x_data_lines_enum),
+	IIO_ENUM_AVAILABLE("data_lines", IIO_SHARED_BY_ALL,
+				  &ad777x_data_lines_enum),
+	{ },
+};
+
+static const struct iio_chan_spec_ext_info ad777x_ext_only_filter[] = {
+	IIO_ENUM("filter_type", IIO_SHARED_BY_ALL, &ad777x_filter_enum),
+	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_ALL,
+				  &ad777x_filter_enum),
+	{ },
+};
+
+static const struct iio_chan_spec_ext_info ad777x_ext_info_filter[] = {
+	IIO_ENUM("data_lines", IIO_SHARED_BY_ALL, &ad777x_data_lines_enum),
+	IIO_ENUM_AVAILABLE("data_lines", IIO_SHARED_BY_ALL,
+				  &ad777x_data_lines_enum),
+	IIO_ENUM("filter_type", IIO_SHARED_BY_ALL, &ad777x_filter_enum),
+	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_ALL,
+				  &ad777x_filter_enum),
+	{ },
+};
+
+#define AD777x_CHAN(index, _ext_info)					       \
+	{								       \
+		.type = IIO_VOLTAGE,					       \
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),       \
+		.address = (index),					       \
+		.indexed = 1,						       \
+		.channel = (index),					       \
+		.scan_index = (index),					       \
+		.ext_info = (_ext_info),				       \
+		.scan_type = {						       \
+			.sign = 's',					       \
+			.realbits = 24,					       \
+			.storagebits = 32,				       \
+		},							       \
+	}
+
+#define AD777x_CHAN_S(index, _ext_info)					       \
+	{								       \
+		.type = IIO_VOLTAGE,					       \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBSCALE)  |	       \
+				      BIT(IIO_CHAN_INFO_CALIBBIAS),	       \
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),       \
+		.address = (index),					       \
+		.indexed = 1,						       \
+		.channel = (index),					       \
+		.scan_index = (index),					       \
+		.ext_info = (_ext_info),				       \
+		.scan_type = {						       \
+			.sign = 's',					       \
+			.realbits = 24,					       \
+			.storagebits = 32,				       \
+			.endianness = IIO_BE,				       \
+		},							       \
+	}
+
+#define AD777x_CHAN_NO_FILTER(index)					       \
+	AD777x_CHAN(index, ad777x_ext_info)
+
+#define AD777x_CHAN_FILTER(index)					       \
+	AD777x_CHAN(index, ad777x_ext_info_filter)
+
+#define AD777x_CHAN_NO_FILTER_S(index)					       \
+	AD777x_CHAN_S(index, NULL)
+
+#define AD777x_CHAN_FILTER_S(index)					       \
+	AD777x_CHAN_S(index, ad777x_ext_only_filter)
+
+static const struct iio_chan_spec ad777x_channels[] = {
+	AD777x_CHAN_NO_FILTER_S(0),
+	AD777x_CHAN_NO_FILTER_S(1),
+	AD777x_CHAN_NO_FILTER_S(2),
+	AD777x_CHAN_NO_FILTER_S(3),
+	AD777x_CHAN_NO_FILTER_S(4),
+	AD777x_CHAN_NO_FILTER_S(5),
+	AD777x_CHAN_NO_FILTER_S(6),
+	AD777x_CHAN_NO_FILTER_S(7),
+};
+
+static const struct iio_chan_spec ad777x_channels_filter[] = {
+	AD777x_CHAN_FILTER_S(0),
+	AD777x_CHAN_FILTER_S(1),
+	AD777x_CHAN_FILTER_S(2),
+	AD777x_CHAN_FILTER_S(3),
+	AD777x_CHAN_FILTER_S(4),
+	AD777x_CHAN_FILTER_S(5),
+	AD777x_CHAN_FILTER_S(6),
+	AD777x_CHAN_FILTER_S(7),
+};
+
+static const struct axiadc_chip_info conv_chip_info = {
+	.name = "ad777x_axi_adc",
+	.max_rate = 4096000UL,
+	.num_channels = 8,
+	.channel[0] = AD777x_CHAN_NO_FILTER(0),
+	.channel[1] = AD777x_CHAN_NO_FILTER(1),
+	.channel[2] = AD777x_CHAN_NO_FILTER(2),
+	.channel[3] = AD777x_CHAN_NO_FILTER(3),
+	.channel[4] = AD777x_CHAN_NO_FILTER(4),
+	.channel[5] = AD777x_CHAN_NO_FILTER(5),
+	.channel[6] = AD777x_CHAN_NO_FILTER(6),
+	.channel[7] = AD777x_CHAN_NO_FILTER(7),
+};
+
+static const struct axiadc_chip_info conv_chip_info_filter = {
+	.name = "ad777x_axi_adc",
+	.max_rate = 4096000UL,
+	.num_channels = 8,
+	.channel[0] = AD777x_CHAN_FILTER(0),
+	.channel[1] = AD777x_CHAN_FILTER(1),
+	.channel[2] = AD777x_CHAN_FILTER(2),
+	.channel[3] = AD777x_CHAN_FILTER(3),
+	.channel[4] = AD777x_CHAN_FILTER(4),
+	.channel[5] = AD777x_CHAN_FILTER(5),
+	.channel[6] = AD777x_CHAN_FILTER(6),
+	.channel[7] = AD777x_CHAN_FILTER(7),
+};
+
+const struct iio_buffer_setup_ops ad777x_buffer_setup_ops = {
+	.postenable = ad777x_buffer_postenable,
+	.predisable = ad777x_buffer_predisable,
+};
+
+static void ad777x_clk_disable(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
+static void ad777x_reg_disable(void *data)
+{
+	regulator_disable(data);
+}
+
+static int ad777x_register_axi(struct ad777x_state *st)
+{
+	struct axiadc_converter *conv;
+
+	conv = devm_kzalloc(&st->spi->dev, sizeof(*conv), GFP_KERNEL);
+	if (!conv)
+		return -ENOMEM;
+
+	conv->spi = st->spi;
+	conv->clk = st->mclk;
+	if (strcmp(st->chip_info->name, "ad7771") == 0)
+		conv->chip_info = &conv_chip_info_filter;
+	else
+		conv->chip_info = &conv_chip_info;
+	conv->reg_access = &ad777x_reg_access;
+	conv->write_raw = &ad777x_write_raw;
+	conv->read_raw = &ad777x_read_raw;
+	conv->phy = st;
+	st->spidata_mode = 0;
+	spi_set_drvdata(st->spi, conv);
+
+	return 0;
+}
+
+static int ad777x_register(struct ad777x_state *st, struct iio_dev *indio_dev)
+{
+	int ret;
+
+	indio_dev->name = st->chip_info->name;
+	indio_dev->info = &ad777x_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	if (strcmp(st->chip_info->name, "ad7771") == 0)
+		indio_dev->channels = ad777x_channels_filter;
+	else
+		indio_dev->channels = ad777x_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad777x_channels);
+
+	ret = devm_request_threaded_irq(&st->spi->dev, st->spi->irq, NULL,
+					ad777x_irq_handler, IRQF_ONESHOT,
+					indio_dev->name, indio_dev);
+	if (ret)
+		return dev_err_probe(&st->spi->dev, ret,
+				     "request irq %d failed\n",
+				     st->spi->irq);
+
+	ret = devm_iio_kfifo_buffer_setup_ext(&st->spi->dev, indio_dev,
+					      &ad777x_buffer_setup_ops,
+					      NULL);
+	if (ret)
+		return dev_err_probe(&st->spi->dev, ret,
+				     "setup buffer failed\n");
+
+	ret = ad777x_spi_write_mask(st, AD777X_REG_DOUT_FORMAT,
+				    AD777X_DCLK_CLK_DIV_MSK,
+				    FIELD_PREP(AD777X_DCLK_CLK_DIV_MSK, 7));
+	if (ret)
+		return ret;
+	st->spidata_mode = 1;
+
+	disable_irq_nosync(st->spi->irq);
+
+	return devm_iio_device_register(&st->spi->dev, indio_dev);
+}
+
+static int ad777x_powerup(struct ad777x_state *st, struct gpio_desc *start_gpio)
+{
+	int ret;
+
+	ret = ad777x_spi_write_mask(st, AD777X_REG_GENERAL_USER_CONFIG_1,
+				    AD777X_MOD_POWERMODE_MSK,
+				    FIELD_PREP(AD777X_MOD_POWERMODE_MSK, 1));
+	if (ret)
+		return ret;
+	ret = ad777x_spi_write_mask(st, AD777X_REG_GENERAL_USER_CONFIG_1,
+				    AD777X_MOD_PDB_REFOUT_MSK,
+				    FIELD_PREP(AD777X_MOD_PDB_REFOUT_MSK, 1));
+	if (ret)
+		return ret;
+	ret = ad777x_spi_write_mask(st, AD777X_REG_DOUT_FORMAT,
+				    AD777X_DCLK_CLK_DIV_MSK,
+				    FIELD_PREP(AD777X_DCLK_CLK_DIV_MSK, 1));
+	if (ret)
+		return ret;
+	ret = ad777x_spi_write_mask(st, AD777X_REG_ADC_MUX_CONFIG,
+				    AD777X_REFMUX_CTRL_MSK,
+				    FIELD_PREP(AD777X_REFMUX_CTRL_MSK, 1));
+	if (ret)
+		return ret;
+	ret = ad777x_spi_write_mask(st, AD777X_REG_GEN_ERR_REG_1_EN,
+				    AD777X_SPI_CRC_EN_MSK,
+				    FIELD_PREP(AD777X_SPI_CRC_EN_MSK, 1));
+	if (ret)
+		return ret;
+
+	st->power_mode = AD777X_HIGH_POWER;
+	st->crc_enabled = true;
+	st->data_lines = AD777x_4LINES;
+	ret = ad777x_set_sampling_frequency(st, AD777X_DEFAULT_SAMPLING_FREQ);
+	if (ret)
+		return ret;
+
+	gpiod_set_value(start_gpio, 0);
+	usleep_range(10, 15);
+	gpiod_set_value(start_gpio, 1);
+	usleep_range(10, 15);
+	gpiod_set_value(start_gpio, 0);
+	usleep_range(10, 15);
+
+	return 0;
+}
+
+static int ad777x_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct ad777x_state *st;
+	struct gpio_desc *reset_gpio;
+	struct gpio_desc *start_gpio;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+
+	st->vref = devm_regulator_get_optional(&spi->dev, "vref");
+	if (IS_ERR(st->vref))
+		return PTR_ERR(st->vref);
+
+	ret = regulator_enable(st->vref);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&spi->dev,
+				       ad777x_reg_disable,
+				       st->vref);
+	if (ret)
+		return ret;
+
+	st->mclk = devm_clk_get(&spi->dev, "mclk");
+	if (IS_ERR(st->mclk))
+		return PTR_ERR(st->mclk);
+
+	ret = clk_prepare_enable(st->mclk);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_add_action_or_reset(&spi->dev,
+				       ad777x_clk_disable,
+				       st->mclk);
+	if (ret)
+		return ret;
+
+	reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(reset_gpio))
+		return PTR_ERR(reset_gpio);
+
+	start_gpio = devm_gpiod_get(&spi->dev, "start", GPIOD_OUT_HIGH);
+	if (IS_ERR(start_gpio))
+		return PTR_ERR(start_gpio);
+
+	crc8_populate_msb(ad777x_crc8_table, AD777X_CRC8_POLY);
+	st->spi = spi;
+
+	st->chip_info = device_get_match_data(&spi->dev);
+	if (!st->chip_info) {
+		const struct spi_device_id *id = spi_get_device_id(spi);
+
+		if (id) {
+			st->chip_info =
+				(struct ad777x_chip_info *)id->driver_data;
+		}
+		if (!st->chip_info)
+			return -EINVAL;
+	}
+	ret = ad777x_reset(indio_dev, start_gpio);
+	if (ret)
+		return ret;
+
+	ad777x_powerup(st, start_gpio);
+	if (ret)
+		return ret;
+
+	if (spi->irq)
+		ret = ad777x_register(st, indio_dev);
+	else
+		ret = ad777x_register_axi(st);
+
+	return ret;
+}
+
+static int __maybe_unused ad777x_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad777x_state *st = ad777x_get_data(indio_dev);
+	int ret;
+
+	ret = ad777x_spi_write_mask(st, AD777X_REG_GENERAL_USER_CONFIG_1,
+				    AD777X_MOD_POWERMODE_MSK,
+				    FIELD_PREP(AD777X_MOD_POWERMODE_MSK,
+					       AD777X_LOW_POWER));
+	if (ret)
+		return ret;
+
+	st->power_mode = AD777X_LOW_POWER;
+	return 0;
+}
+
+static int __maybe_unused ad777x_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad777x_state *st = ad777x_get_data(indio_dev);
+	int ret;
+
+	ret = ad777x_spi_write_mask(st, AD777X_REG_GENERAL_USER_CONFIG_1,
+				    AD777X_MOD_POWERMODE_MSK,
+				    FIELD_PREP(AD777X_MOD_POWERMODE_MSK,
+					       AD777X_HIGH_POWER));
+	if (ret)
+		return ret;
+
+	st->power_mode = AD777X_HIGH_POWER;
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(ad777x_pm_ops, ad777x_suspend, ad777x_resume);
+
+static const struct ad777x_chip_info ad7770_chip_info = {
+	.name = "ad7770",
+};
+
+static const struct ad777x_chip_info ad7771_chip_info = {
+	.name = "ad7771",
+};
+
+static const struct ad777x_chip_info ad7779_chip_info = {
+	.name = "ad7779",
+};
+
+static const struct spi_device_id ad777x_id[] = {
+	{
+		.name = "ad7770",
+		.driver_data = (__kernel_ulong_t)&ad7770_chip_info
+	},
+	{
+		.name = "ad7771",
+		.driver_data = (__kernel_ulong_t)&ad7771_chip_info
+	},
+	{
+		.name = "ad7779",
+		.driver_data = (__kernel_ulong_t)&ad7779_chip_info
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad777x_id);
+
+static const struct of_device_id ad777x_of_table[] = {
+	{
+		.compatible = "adi,ad7770",
+		.data = &ad7770_chip_info,
+	},
+	{
+		.compatible = "adi,ad7771",
+		.data = &ad7771_chip_info,
+	},
+	{
+		.compatible = "adi,ad7779",
+		.data = &ad7779_chip_info,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad777x_of_table);
+
+static struct spi_driver ad777x_driver = {
+	.driver = {
+		.name = "ad777x",
+		.pm = &ad777x_pm_ops,
+		.of_match_table = ad777x_of_table,
+	},
+	.probe = ad777x_probe,
+	.id_table = ad777x_id,
+};
+module_spi_driver(ad777x_driver);
+
+MODULE_AUTHOR("Ramona Alexandra Nechita <ramona.nechita@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD777X ADC");
+MODULE_LICENSE("GPL");
-- 
2.43.0


