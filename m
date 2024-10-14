Return-Path: <linux-iio+bounces-10571-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD1899CD85
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 16:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 328C8B20BE8
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 14:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4761AA7A5;
	Mon, 14 Oct 2024 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="HD6ikDjd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEE825632;
	Mon, 14 Oct 2024 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916394; cv=none; b=pULIqcJFw1oVywp0tBzAzvpgPiky56NZbuzoKxt7bdzRP+rvuaWMmAfv3TfMU1lB366X1CJqqYF2GyCHNkBSL92h2UnwAfZSmTCU6HjH23mEyfdZ7+aZsuUv74Op5uBJHu9cIRHSf7Ohm5lXWcB4TatniOlnTvN7vnDMCmjUFUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916394; c=relaxed/simple;
	bh=TgmPxSTtvSvX7Nnjnaui3vorlKObcSV38uI/WBfQv+U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zlx0NFmpFiKH56EXPsVLA7g+S5Ilp/u8tSj/ghAOVxXITZ3dABakjPk33ruzmVr6ky69wNh7/PNd8YMIaZMQroMmh4YTU7Tq5hmnvnPDej63bycMhoHpjm94WXSKpfAGZKOV8aLVLoIoIJMlKuO62Ecu/PnwgU92jvujrJeErJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=HD6ikDjd; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49EDePoJ001993;
	Mon, 14 Oct 2024 10:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=igPDh
	nJHlozLbnTu+9Ev2eRWrasyx9OxCSK44yrB1WU=; b=HD6ikDjdvWhH8Wj8bBwZR
	n7cd0eRDG88pmEeRB7zzlaIKqBgSOgZvWTBf10CdXTbkenZEOVhsYzraeiIk7J9S
	Rq8KKc4TMQDPnzXpshN5WNv/9JJSJlpV6M4CzxGGIb3mfq/pMlvV1Ui9sOL0NY9V
	WU0ZGvIoisVA+ngnqLxygnG6iHTJeo73anNWvyu2XQaQhcUOBm1gfsEWetmH2oWu
	OPDHHbyr4h6jBS4jsPWb2b0LilzFflHCmayMinsu2WVwpq3voDGWnX886shUX3o5
	79F6dXc1jD8bKOIFlq5CQ9rEAR9DCAFboPOOtZuzz69zpPciAWbFBzTJKEXEdMiM
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 428yqm18pk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 10:32:57 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 49EEWtmh051590
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 14 Oct 2024 10:32:55 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 14 Oct
 2024 10:32:55 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 14 Oct 2024 10:32:55 -0400
Received: from HYB-hYN1yfF7zRm.ad.analog.com (HYB-hYN1yfF7zRm.ad.analog.com [10.48.65.186])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 49EEW6bD014258;
	Mon, 14 Oct 2024 10:32:48 -0400
From: Ramona Alexandra Nechita <ramona.nechita@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Alexandru Ardelean
	<alexandru.ardelean@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>,
        George Mois <george.mois@analog.com>,
        Ramona Alexandra Nechita <ramona.nechita@analog.com>,
        Ana-Maria Cusco
	<ana-maria.cusco@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v7 3/3] drivers: iio: adc: add support for ad777x family
Date: Mon, 14 Oct 2024 17:32:00 +0300
Message-ID: <20241014143204.30195-4-ramona.nechita@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014143204.30195-1-ramona.nechita@analog.com>
References: <20241014143204.30195-1-ramona.nechita@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: qZ3LFg282sj6yHoKzloC_AbVJFmXuA3J
X-Proofpoint-GUID: qZ3LFg282sj6yHoKzloC_AbVJFmXuA3J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 bulkscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410140106

Add support for AD7770, AD7771, AD7779 ADCs. The device is capable of
sending out data both on DOUT lines interface,as on the SDO line.
The driver currently implements only the SDO data streaming mode. SPI
communication is used alternatively for accessing registers and streaming
data. Register accesses are protected by crc8.

Signed-off-by: Ramona Alexandra Nechita <ramona.nechita@analog.com>
---
 drivers/iio/adc/Kconfig  |  11 +
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/ad7779.c | 909 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 921 insertions(+)
 create mode 100644 drivers/iio/adc/ad7779.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 85b82a708c36..9802cb87075a 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -267,6 +267,17 @@ config AD7768_1
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad7768-1.
 
+config AD7779
+	tristate "Analog Devices AD7779 ADC driver"
+	depends on SPI
+	select IIO_BUFFER
+	help
+	  Say yes here to build support for Analog Devices AD777X family
+	  (AD7770, AD7771, AD7779) analog to digital converter (ADC).
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad7779.
+
 config AD7780
 	tristate "Analog Devices AD7780 and similar ADCs driver"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 66b36dfe9a28..fa579f4d37fd 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_AD7606_IFACE_SPI) += ad7606_spi.o
 obj-$(CONFIG_AD7606) += ad7606.o
 obj-$(CONFIG_AD7766) += ad7766.o
 obj-$(CONFIG_AD7768_1) += ad7768-1.o
+obj-$(CONFIG_AD7779) += ad7779.o
 obj-$(CONFIG_AD7780) += ad7780.o
 obj-$(CONFIG_AD7791) += ad7791.o
 obj-$(CONFIG_AD7793) += ad7793.o
diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
new file mode 100644
index 000000000000..5904cc669f3a
--- /dev/null
+++ b/drivers/iio/adc/ad7779.c
@@ -0,0 +1,909 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * AD7770, AD7771, AD7779 ADC
+ *
+ * Copyright 2023-2024 Analog Devices Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitmap.h>
+#include <linux/clk.h>
+#include <linux/crc8.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <asm/unaligned.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+
+#define AD7779_SPI_READ_CMD			BIT(7)
+
+#define AD7779_DISABLE_SD			BIT(7)
+
+#define AD7779_REG_CH_DISABLE			0x08
+#define AD7779_REG_CH_SYNC_OFFSET(ch)		(0x09 + (ch))
+#define AD7779_REG_CH_CONFIG(ch)		(0x00 + (ch))
+#define AD7779_REG_GENERAL_USER_CONFIG_1	0x11
+#define AD7779_REG_GENERAL_USER_CONFIG_2	0x12
+#define AD7779_REG_GENERAL_USER_CONFIG_3	0x13
+#define AD7779_REG_DOUT_FORMAT			0x14
+#define AD7779_REG_ADC_MUX_CONFIG		0x15
+#define AD7779_REG_GPIO_CONFIG			0x17
+#define AD7779_REG_BUFFER_CONFIG_1		0x19
+#define AD7779_REG_GLOBAL_MUX_CONFIG		0x16
+#define AD7779_REG_BUFFER_CONFIG_2		0x1A
+#define AD7779_REG_GPIO_DATA			0x18
+#define AD7779_REG_CH_OFFSET_UPPER_BYTE(ch)	(0x1C + (ch) * 6)
+#define AD7779_REG_CH_OFFSET_LOWER_BYTE(ch)	(0x1E + (ch) * 6)
+#define AD7779_REG_CH_GAIN_UPPER_BYTE(ch)	(0x1F + (ch) * 6)
+#define AD7779_REG_CH_OFFSET_MID_BYTE(ch)	(0x1D + (ch) * 6)
+#define AD7779_REG_CH_GAIN_MID_BYTE(ch)		(0x20 + (ch) * 6)
+#define AD7779_REG_CH_ERR_REG(ch)		(0x4C + (ch))
+#define AD7779_REG_CH0_1_SAT_ERR		0x54
+#define AD7779_REG_CH_GAIN_LOWER_BYTE(ch)	(0x21 + (ch) * 6)
+#define AD7779_REG_CH2_3_SAT_ERR		0x55
+#define AD7779_REG_CH4_5_SAT_ERR		0x56
+#define AD7779_REG_CH6_7_SAT_ERR		0x57
+#define AD7779_REG_CHX_ERR_REG_EN		0x58
+#define AD7779_REG_GEN_ERR_REG_1		0x59
+#define AD7779_REG_GEN_ERR_REG_1_EN		0x5A
+#define AD7779_REG_GEN_ERR_REG_2		0x5B
+#define AD7779_REG_GEN_ERR_REG_2_EN		0x5C
+#define AD7779_REG_STATUS_REG_1			0x5D
+#define AD7779_REG_STATUS_REG_2			0x5E
+#define AD7779_REG_STATUS_REG_3			0x5F
+#define AD7779_REG_SRC_N_MSB			0x60
+#define AD7779_REG_SRC_N_LSB			0x61
+#define AD7779_REG_SRC_IF_MSB			0x62
+#define AD7779_REG_SRC_IF_LSB			0x63
+#define AD7779_REG_SRC_UPDATE			0x64
+
+#define AD7779_FILTER_MSK			BIT(6)
+#define AD7779_MOD_POWERMODE_MSK		BIT(6)
+#define AD7779_MOD_PDB_REFOUT_MSK		BIT(4)
+#define AD7779_MOD_SPI_EN_MSK			BIT(4)
+#define AD7779_USRMOD_INIT_MSK			GENMASK(6, 4)
+
+/* AD7779_REG_DOUT_FORMAT */
+#define AD7779_DOUT_FORMAT_MSK			GENMASK(7, 6)
+#define AD7779_DOUT_HEADER_FORMAT		BIT(5)
+#define AD7779_DCLK_CLK_DIV_MSK			GENMASK(3, 1)
+
+#define AD7779_REFMUX_CTRL_MSK			GENMASK(7, 6)
+#define AD7779_SPI_CRC_EN_MSK			BIT(0)
+
+#define AD7779_MAXCLK_LOWPOWER			(4096 * HZ_PER_KHZ)
+#define AD7779_NUM_CHANNELS			8
+#define AD7779_RESET_BUF_SIZE			8
+#define AD7779_CHAN_DATA_SIZE			4
+
+#define AD7779_LOWPOWER_DIV			512
+#define AD7779_HIGHPOWER_DIV			2048
+
+#define AD7779_SINC3_MAXFREQ			(16 * HZ_PER_KHZ)
+#define AD7779_SINC5_MAXFREQ			(128 * HZ_PER_KHZ)
+
+#define AD7779_DEFAULT_SAMPLING_FREQ		(8 * HZ_PER_KHZ)
+#define AD7779_DEFAULT_SAMPLING_2LINE		(4 * HZ_PER_KHZ)
+#define AD7779_DEFAULT_SAMPLING_1LINE		(2 * HZ_PER_KHZ)
+
+#define AD7779_SPIMODE_MAX_SAMP_FREQ		(16 * HZ_PER_KHZ)
+
+#define GAIN_REL				0x555555
+#define AD7779_FREQ_MSB_MSK			GENMASK(15, 8)
+#define AD7779_FREQ_LSB_MSK			GENMASK(7, 0)
+#define AD7779_UPPER				GENMASK(23, 16)
+#define AD7779_MID				GENMASK(15, 8)
+#define AD7779_LOWER				GENMASK(7, 0)
+
+#define AD7779_REG_MSK		GENMASK(6, 0)
+
+#define AD7779_CRC8_POLY			0x07
+DECLARE_CRC8_TABLE(ad7779_crc8_table);
+
+enum ad7779_filter {
+	AD7779_SINC3,
+	AD7779_SINC5,
+};
+
+enum ad7779_variant {
+	ad7770,
+	ad7771,
+	ad7779,
+};
+
+enum ad7779_power_mode {
+	AD7779_LOW_POWER,
+	AD7779_HIGH_POWER,
+};
+
+struct ad7779_chip_info {
+	const char *name;
+	struct iio_chan_spec const *channels;
+};
+
+struct ad7779_state {
+	struct spi_device *spi;
+	const struct ad7779_chip_info *chip_info;
+	struct clk *mclk;
+	struct iio_trigger *trig;
+	struct completion completion;
+	unsigned int sampling_freq;
+	enum ad7779_filter filter_enabled;
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 */
+	struct {
+		u32 chans[8];
+		aligned_s64 timestamp;
+	} data __aligned(IIO_DMA_MINALIGN);
+	u32			spidata_tx[8];
+	u8			reg_rx_buf[3];
+	u8			reg_tx_buf[3];
+	u8			reset_buf[8];
+};
+
+static const char * const ad7779_filter_type[] = {
+	[AD7779_SINC3] = "sinc3",
+	[AD7779_SINC5] = "sinc5",
+};
+
+static const char * const ad7779_power_supplies[] = {
+	"avdd1", "avdd2", "avdd4",
+};
+
+static int ad7779_spi_read(struct ad7779_state *st, u8 reg, u8 *rbuf)
+{
+	int ret;
+	u8 crc_buf[2];
+	u8 exp_crc;
+	struct spi_transfer t = {
+		.tx_buf = st->reg_tx_buf,
+		.rx_buf = st->reg_rx_buf,
+	};
+
+	st->reg_tx_buf[0] = AD7779_SPI_READ_CMD | FIELD_GET(AD7779_REG_MSK, reg);
+	st->reg_tx_buf[1] = 0;
+
+	if (reg == AD7779_REG_GEN_ERR_REG_1_EN) {
+		t.len = 2;
+	} else {
+		t.len = 3;
+		st->reg_tx_buf[2] = crc8(ad7779_crc8_table, st->reg_tx_buf,
+					 t.len - 1, 0);
+	}
+
+	ret = spi_sync_transfer(st->spi, &t, 1);
+	if (ret)
+		return ret;
+
+	crc_buf[0] = AD7779_SPI_READ_CMD | FIELD_GET(AD7779_REG_MSK, reg);
+	crc_buf[1] = st->reg_rx_buf[1];
+	exp_crc = crc8(ad7779_crc8_table, crc_buf, ARRAY_SIZE(crc_buf), 0);
+	if (reg != AD7779_REG_GEN_ERR_REG_1_EN && exp_crc != st->reg_rx_buf[2]) {
+		dev_err(&st->spi->dev, "Bad CRC %x, expected %x",
+			st->reg_rx_buf[2], exp_crc);
+		return -EINVAL;
+	}
+	*rbuf = st->reg_rx_buf[1];
+
+	return 0;
+}
+
+static int ad7779_spi_write(struct ad7779_state *st, u8 reg, u8 val)
+{
+	u8 length = 3;
+
+	st->reg_tx_buf[0] = FIELD_GET(AD7779_REG_MSK, reg);
+	st->reg_tx_buf[1] = val;
+	if (reg == AD7779_REG_GEN_ERR_REG_1_EN)
+		length = 2;
+	else
+		st->reg_tx_buf[2] = crc8(ad7779_crc8_table, st->reg_tx_buf,
+					 length - 1, 0);
+
+	return spi_write(st->spi, st->reg_tx_buf, length);
+}
+
+static int ad7779_spi_write_mask(struct ad7779_state *st, u8 reg, u8 mask,
+				 u8 val)
+{
+	int ret;
+	u8 regval, data;
+
+	ret = ad7779_spi_read(st, reg, &data);
+	if (ret)
+		return ret;
+
+	regval = (data & ~mask) | (val & mask);
+
+	if (regval == data)
+		return 0;
+
+	return ad7779_spi_write(st, reg, regval);
+}
+
+static int ad7779_reg_access(struct iio_dev *indio_dev,
+			     unsigned int reg,
+			     unsigned int writeval,
+			     unsigned int *readval)
+{
+	struct ad7779_state *st = iio_priv(indio_dev);
+	u8 rval;
+	int ret;
+
+	if (readval) {
+		ret = ad7779_spi_read(st, reg, &rval);
+		*readval = rval;
+	}
+
+	return ad7779_spi_write(st, reg, writeval);
+}
+
+static int ad7779_set_sampling_frequency(struct ad7779_state *st,
+					 unsigned int sampling_freq)
+{
+	int ret;
+	unsigned int dec;
+	unsigned int frac;
+	unsigned int div;
+	unsigned int decimal;
+	unsigned int freq_khz;
+
+	if (st->filter_enabled == AD7779_SINC3 &&
+	    sampling_freq > AD7779_SINC3_MAXFREQ)
+		return -EINVAL;
+
+	if (st->filter_enabled == AD7779_SINC5 &&
+	    sampling_freq > AD7779_SINC5_MAXFREQ)
+		return -EINVAL;
+
+	if (sampling_freq > AD7779_SPIMODE_MAX_SAMP_FREQ)
+		return -EINVAL;
+
+	div = AD7779_HIGHPOWER_DIV;
+
+	freq_khz = sampling_freq / HZ_PER_KHZ;
+	dec = div / freq_khz;
+	frac = div % freq_khz;
+
+	ret = ad7779_spi_write(st, AD7779_REG_SRC_N_MSB,
+			       FIELD_GET(AD7779_FREQ_MSB_MSK, dec));
+	if (ret)
+		return ret;
+	ret = ad7779_spi_write(st, AD7779_REG_SRC_N_LSB,
+			       FIELD_GET(AD7779_FREQ_LSB_MSK, dec));
+	if (ret)
+		return ret;
+
+	if (frac) {
+		/*
+		 * In order to obtain the first three decimals of the decimation
+		 * the initial number is multiplied with 10^3 prior to the
+		 * division, then the original division result is subtracted and
+		 * the number is divided by 10^3.
+		 */
+		decimal = ((mult_frac(div, KILO, freq_khz) - dec * KILO) << 16)
+			  / KILO;
+		ret = ad7779_spi_write(st, AD7779_REG_SRC_N_MSB,
+				       FIELD_GET(AD7779_FREQ_MSB_MSK, decimal));
+		if (ret)
+			return ret;
+		ret = ad7779_spi_write(st, AD7779_REG_SRC_N_LSB,
+				       FIELD_GET(AD7779_FREQ_LSB_MSK, decimal));
+		if (ret)
+			return ret;
+	} else {
+		ret = ad7779_spi_write(st, AD7779_REG_SRC_N_MSB,
+				       FIELD_GET(AD7779_FREQ_MSB_MSK, 0x0));
+		if (ret)
+			return ret;
+		ret = ad7779_spi_write(st, AD7779_REG_SRC_N_LSB,
+				       FIELD_GET(AD7779_FREQ_LSB_MSK, 0x0));
+		if (ret)
+			return ret;
+	}
+	ret = ad7779_spi_write(st, AD7779_REG_SRC_UPDATE, BIT(0));
+	if (ret)
+		return ret;
+
+	/* SRC update settling time */
+	fsleep(15);
+
+	ret = ad7779_spi_write(st, AD7779_REG_SRC_UPDATE, 0x0);
+	if (ret)
+		return ret;
+
+	/* SRC update settling time */
+	fsleep(15);
+
+	st->sampling_freq = sampling_freq;
+
+	return 0;
+}
+
+static int ad7779_get_filter(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan)
+{
+	struct ad7779_state *st = iio_priv(indio_dev);
+	u8 temp;
+	int ret;
+
+	ret = ad7779_spi_read(st, AD7779_REG_GENERAL_USER_CONFIG_2, &temp);
+	if (ret)
+		return ret;
+
+	return FIELD_GET(AD7779_FILTER_MSK, temp);
+}
+
+static int ad7779_set_filter(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     unsigned int mode)
+{
+	struct ad7779_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = ad7779_spi_write_mask(st,
+				    AD7779_REG_GENERAL_USER_CONFIG_2,
+				    AD7779_FILTER_MSK,
+				    FIELD_PREP(AD7779_FILTER_MSK, mode));
+	if (ret)
+		return ret;
+
+	ret = ad7779_set_sampling_frequency(st, st->sampling_freq);
+	if (ret)
+		return ret;
+
+	st->filter_enabled = mode;
+
+	return 0;
+}
+
+static int ad7779_get_calibscale(struct ad7779_state *st, int channel)
+{
+	int ret;
+	u8 calibscale[3];
+
+	ret = ad7779_spi_read(st, AD7779_REG_CH_GAIN_LOWER_BYTE(channel), &calibscale[0]);
+	if (ret)
+		return ret;
+
+	ret = ad7779_spi_read(st, AD7779_REG_CH_GAIN_MID_BYTE(channel), &calibscale[1]);
+	if (ret)
+		return ret;
+
+	ret = ad7779_spi_read(st, AD7779_REG_CH_GAIN_UPPER_BYTE(channel), &calibscale[2]);
+	if (ret)
+		return ret;
+
+	return get_unaligned_be24(calibscale);
+}
+
+static int ad7779_set_calibscale(struct ad7779_state *st, int channel, int val)
+{
+	int ret;
+	unsigned int gain;
+	u8 gain_bytes[3];
+
+	/*
+	 * The gain value is relative to 0x555555, which represents a gain of 1
+	 */
+	gain = DIV_ROUND_CLOSEST_ULL((u64)val * 5592405LL, MEGA);
+	put_unaligned_be24(gain, gain_bytes);
+	ret = ad7779_spi_write(st, AD7779_REG_CH_GAIN_UPPER_BYTE(channel),
+			       gain_bytes[0]);
+	if (ret)
+		return ret;
+
+	ret = ad7779_spi_write(st, AD7779_REG_CH_GAIN_MID_BYTE(channel),
+			       gain_bytes[1]);
+	if (ret)
+		return ret;
+
+	return ad7779_spi_write(st, AD7779_REG_CH_GAIN_LOWER_BYTE(channel),
+				gain_bytes[2]);
+}
+
+static int ad7779_get_calibbias(struct ad7779_state *st, int channel)
+{
+	int ret;
+	u8 calibbias[3];
+
+	ret = ad7779_spi_read(st, AD7779_REG_CH_OFFSET_LOWER_BYTE(channel),
+			      &calibbias[0]);
+	if (ret)
+		return ret;
+
+	ret = ad7779_spi_read(st, AD7779_REG_CH_OFFSET_MID_BYTE(channel),
+			      &calibbias[1]);
+	if (ret)
+		return ret;
+
+	ret = ad7779_spi_read(st, AD7779_REG_CH_OFFSET_UPPER_BYTE(channel),
+			      &calibbias[2]);
+	if (ret)
+		return ret;
+
+	return get_unaligned_be24(calibbias);
+}
+
+static int ad7779_set_calibbias(struct ad7779_state *st, int channel, int val)
+{
+	int ret;
+	u8 calibbias[3];
+
+	put_unaligned_be24(val, calibbias);
+	ret = ad7779_spi_write(st, AD7779_REG_CH_OFFSET_UPPER_BYTE(channel),
+			       calibbias[0]);
+	if (ret)
+		return ret;
+
+	ret = ad7779_spi_write(st, AD7779_REG_CH_OFFSET_MID_BYTE(channel),
+			       calibbias[1]);
+	if (ret)
+		return ret;
+
+	return ad7779_spi_write(st, AD7779_REG_CH_OFFSET_LOWER_BYTE(channel),
+				calibbias[2]);
+}
+
+static int ad7779_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan, int *val,
+			   int *val2, long mask)
+{
+	struct ad7779_state *st = iio_priv(indio_dev);
+	int ret;
+
+	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+		switch (mask) {
+		case IIO_CHAN_INFO_CALIBSCALE:
+			ret = ad7779_get_calibscale(st, chan->channel);
+			if (ret < 0)
+				return ret;
+			*val = ret;
+			*val2 = GAIN_REL;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_CHAN_INFO_CALIBBIAS:
+			ret = ad7779_get_calibbias(st, chan->channel);
+			if (ret < 0)
+				return ret;
+			*val = ret;
+			return IIO_VAL_INT;
+		case IIO_CHAN_INFO_SAMP_FREQ:
+			*val = st->sampling_freq;
+			if (*val < 0)
+				return -EINVAL;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	}
+	unreachable();
+}
+
+static int ad7779_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int val, int val2,
+			    long mask)
+{
+	struct ad7779_state *st = iio_priv(indio_dev);
+
+	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+		switch (mask) {
+		case IIO_CHAN_INFO_CALIBSCALE:
+			return ad7779_set_calibscale(st, chan->channel, val2);
+		case IIO_CHAN_INFO_CALIBBIAS:
+			return ad7779_set_calibbias(st, chan->channel, val);
+		case IIO_CHAN_INFO_SAMP_FREQ:
+			return ad7779_set_sampling_frequency(st, val);
+		default:
+			return -EINVAL;
+		}
+	}
+	unreachable();
+}
+
+static int ad7779_buffer_preenable(struct iio_dev *indio_dev)
+{
+	int ret;
+	struct ad7779_state *st = iio_priv(indio_dev);
+
+	ret = ad7779_spi_write_mask(st,
+				    AD7779_REG_GENERAL_USER_CONFIG_3,
+				    AD7779_MOD_SPI_EN_MSK,
+				    FIELD_PREP(AD7779_MOD_SPI_EN_MSK, 1));
+	if (ret)
+		return ret;
+
+	/*
+	 * DRDY output cannot be disabled at device level therefore we mask
+	 * the irq at host end.
+	 */
+	enable_irq(st->spi->irq);
+
+	return 0;
+}
+
+static int ad7779_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct ad7779_state *st = iio_priv(indio_dev);
+
+	disable_irq(st->spi->irq);
+
+	return ad7779_spi_write(st, AD7779_REG_GENERAL_USER_CONFIG_3,
+			       AD7779_DISABLE_SD);
+}
+
+static irqreturn_t ad7779_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ad7779_state *st = iio_priv(indio_dev);
+	int ret;
+	struct spi_transfer t = {
+		.rx_buf = st->data.chans,
+		.tx_buf = st->spidata_tx,
+		.len = AD7779_NUM_CHANNELS * AD7779_CHAN_DATA_SIZE,
+	};
+
+	st->spidata_tx[0] = AD7779_SPI_READ_CMD;
+	ret = spi_sync_transfer(st->spi, &t, 1);
+	if (ret) {
+		dev_err(&st->spi->dev, "SPI transfer error in IRQ handler");
+		goto exit_handler;
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &st->data, pf->timestamp);
+
+exit_handler:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
+static int ad7779_reset(struct iio_dev *indio_dev, struct gpio_desc *reset_gpio)
+{
+	struct ad7779_state *st = iio_priv(indio_dev);
+	int ret;
+	struct spi_transfer t = {
+		.tx_buf = st->reset_buf,
+		.len = 8,
+	};
+
+	if (reset_gpio) {
+		gpiod_set_value(reset_gpio, 1);
+		/* Delay for reset to occur is 225 microseconds */
+		fsleep(230);
+		ret = 0;
+	} else {
+		memset(st->reset_buf, 0xff, sizeof(st->reset_buf));
+		ret = spi_sync_transfer(st->spi, &t, 1);
+		if (ret)
+			return ret;
+	}
+
+	/* Delay for reset to occur is 225 microseconds */
+	fsleep(230);
+
+	return ret;
+}
+
+static const struct iio_info ad7779_info = {
+	.read_raw = ad7779_read_raw,
+	.write_raw = ad7779_write_raw,
+	.debugfs_reg_access = &ad7779_reg_access,
+};
+
+static const struct iio_enum ad7779_filter_enum = {
+	.items = ad7779_filter_type,
+	.num_items = ARRAY_SIZE(ad7779_filter_type),
+	.get = ad7779_get_filter,
+	.set = ad7779_set_filter,
+};
+
+static const struct iio_chan_spec_ext_info ad7779_ext_filter[] = {
+	IIO_ENUM("filter_type", IIO_SHARED_BY_ALL, &ad7779_filter_enum),
+	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_ALL,
+				  &ad7779_filter_enum),
+	{ }
+};
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
+			.endianness = IIO_BE,				   \
+		},								\
+	}
+
+#define AD777x_CHAN_NO_FILTER_S(index)					       \
+	AD777x_CHAN_S(index, NULL)
+
+#define AD777x_CHAN_FILTER_S(index)					       \
+	AD777x_CHAN_S(index, ad7779_ext_filter)
+static const struct iio_chan_spec ad7779_channels[] = {
+	AD777x_CHAN_NO_FILTER_S(0),
+	AD777x_CHAN_NO_FILTER_S(1),
+	AD777x_CHAN_NO_FILTER_S(2),
+	AD777x_CHAN_NO_FILTER_S(3),
+	AD777x_CHAN_NO_FILTER_S(4),
+	AD777x_CHAN_NO_FILTER_S(5),
+	AD777x_CHAN_NO_FILTER_S(6),
+	AD777x_CHAN_NO_FILTER_S(7),
+	IIO_CHAN_SOFT_TIMESTAMP(8),
+};
+
+static const struct iio_chan_spec ad7779_channels_filter[] = {
+	AD777x_CHAN_FILTER_S(0),
+	AD777x_CHAN_FILTER_S(1),
+	AD777x_CHAN_FILTER_S(2),
+	AD777x_CHAN_FILTER_S(3),
+	AD777x_CHAN_FILTER_S(4),
+	AD777x_CHAN_FILTER_S(5),
+	AD777x_CHAN_FILTER_S(6),
+	AD777x_CHAN_FILTER_S(7),
+	IIO_CHAN_SOFT_TIMESTAMP(8),
+};
+
+static const struct iio_buffer_setup_ops ad7779_buffer_setup_ops = {
+	.preenable = ad7779_buffer_preenable,
+	.postdisable = ad7779_buffer_postdisable,
+};
+
+static const struct iio_trigger_ops ad7779_trigger_ops = {
+	.validate_device = iio_trigger_validate_own_device,
+};
+
+static int ad7779_conf(struct ad7779_state *st, struct gpio_desc *start_gpio)
+{
+	int ret;
+
+	ret = ad7779_spi_write_mask(st, AD7779_REG_GEN_ERR_REG_1_EN,
+				    AD7779_SPI_CRC_EN_MSK,
+				    FIELD_PREP(AD7779_SPI_CRC_EN_MSK, 1));
+	if (ret)
+		return ret;
+
+	ret = ad7779_spi_write_mask(st, AD7779_REG_GENERAL_USER_CONFIG_1,
+				    AD7779_USRMOD_INIT_MSK,
+				    FIELD_PREP(AD7779_USRMOD_INIT_MSK, 5));
+	if (ret)
+		return ret;
+
+	ret = ad7779_spi_write_mask(st, AD7779_REG_DOUT_FORMAT,
+				    AD7779_DCLK_CLK_DIV_MSK,
+				    FIELD_PREP(AD7779_DCLK_CLK_DIV_MSK, 1));
+	if (ret)
+		return ret;
+
+	ret = ad7779_spi_write_mask(st, AD7779_REG_ADC_MUX_CONFIG,
+				    AD7779_REFMUX_CTRL_MSK,
+				    FIELD_PREP(AD7779_REFMUX_CTRL_MSK, 1));
+	if (ret)
+		return ret;
+
+	ret = ad7779_set_sampling_frequency(st, AD7779_DEFAULT_SAMPLING_FREQ);
+	if (ret)
+		return ret;
+
+	gpiod_set_value(start_gpio, 0);
+	/* Start setup time */
+	fsleep(15);
+	gpiod_set_value(start_gpio, 1);
+	/* Start setup time */
+	fsleep(15);
+	gpiod_set_value(start_gpio, 0);
+	/* Start setup time */
+	fsleep(15);
+
+	return 0;
+}
+
+static int ad7779_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct ad7779_state *st;
+	struct gpio_desc *reset_gpio, *start_gpio;
+	struct device *dev = &spi->dev;
+	int ret = -EINVAL;
+
+	if (!spi->irq)
+		return dev_err_probe(dev, ret, "DRDY irq not present\n");
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+
+	ret = devm_regulator_bulk_get_enable(dev,
+					     ARRAY_SIZE(ad7779_power_supplies),
+					     ad7779_power_supplies);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get and enable supplies\n");
+
+	st->mclk = devm_clk_get_enabled(dev, "mclk");
+	if (IS_ERR(st->mclk))
+		return PTR_ERR(st->mclk);
+
+	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(reset_gpio))
+		return PTR_ERR(reset_gpio);
+
+	start_gpio = devm_gpiod_get(dev, "start", GPIOD_OUT_HIGH);
+	if (IS_ERR(start_gpio))
+		return PTR_ERR(start_gpio);
+
+	crc8_populate_msb(ad7779_crc8_table, AD7779_CRC8_POLY);
+	st->spi = spi;
+
+	st->chip_info = spi_get_device_match_data(spi);
+	if (!st->chip_info)
+		return -ENODEV;
+
+	ret = ad7779_reset(indio_dev, reset_gpio);
+	if (ret)
+		return ret;
+
+	ret = ad7779_conf(st, start_gpio);
+	if (ret)
+		return ret;
+
+	indio_dev->name = st->chip_info->name;
+	indio_dev->info = &ad7779_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = st->chip_info->channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad7779_channels);
+
+	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
+					  iio_device_id(indio_dev));
+	if (!st->trig)
+		return -ENOMEM;
+
+	st->trig->ops = &ad7779_trigger_ops;
+
+	iio_trigger_set_drvdata(st->trig, st);
+
+	ret = devm_request_irq(dev, spi->irq, iio_trigger_generic_data_rdy_poll,
+			       IRQF_ONESHOT | IRQF_NO_AUTOEN, indio_dev->name,
+			       st->trig);
+	if (ret)
+		return dev_err_probe(dev, ret, "request IRQ %d failed\n",
+				     st->spi->irq);
+
+	ret = devm_iio_trigger_register(dev, st->trig);
+	if (ret)
+		return ret;
+
+	indio_dev->trig = iio_trigger_get(st->trig);
+
+	init_completion(&st->completion);
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, &iio_pollfunc_store_time,
+					      &ad7779_trigger_handler,
+					      &ad7779_buffer_setup_ops);
+	if (ret)
+		return ret;
+
+	ret = ad7779_spi_write_mask(st, AD7779_REG_DOUT_FORMAT,
+				    AD7779_DCLK_CLK_DIV_MSK,
+				    FIELD_PREP(AD7779_DCLK_CLK_DIV_MSK, 7));
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static int ad7779_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7779_state *st = iio_priv(indio_dev);
+
+	return ad7779_spi_write_mask(st, AD7779_REG_GENERAL_USER_CONFIG_1,
+				     AD7779_MOD_POWERMODE_MSK,
+				     FIELD_PREP(AD7779_MOD_POWERMODE_MSK,
+					       AD7779_LOW_POWER));
+}
+
+static int ad7779_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct ad7779_state *st = iio_priv(indio_dev);
+
+	return ad7779_spi_write_mask(st, AD7779_REG_GENERAL_USER_CONFIG_1,
+				     AD7779_MOD_POWERMODE_MSK,
+				     FIELD_PREP(AD7779_MOD_POWERMODE_MSK,
+					       AD7779_HIGH_POWER));
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(ad7779_pm_ops, ad7779_suspend, ad7779_resume);
+
+static const struct ad7779_chip_info ad7770_chip_info = {
+	.name = "ad7770",
+	.channels = ad7779_channels,
+};
+
+static const struct ad7779_chip_info ad7771_chip_info = {
+	.name = "ad7771",
+	.channels = ad7779_channels_filter,
+};
+
+static const struct ad7779_chip_info ad7779_chip_info = {
+	.name = "ad7779",
+	.channels = ad7779_channels,
+};
+
+static const struct spi_device_id ad7779_id[] = {
+	{
+		.name = "ad7770",
+		.driver_data = (kernel_ulong_t)&ad7770_chip_info,
+	},
+	{
+		.name = "ad7771",
+		.driver_data = (kernel_ulong_t)&ad7771_chip_info,
+	},
+	{
+		.name = "ad7779",
+		.driver_data = (kernel_ulong_t)&ad7779_chip_info,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad7779_id);
+
+static const struct of_device_id ad7779_of_table[] = {
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
+MODULE_DEVICE_TABLE(of, ad7779_of_table);
+
+static struct spi_driver ad7779_driver = {
+	.driver = {
+		.name = "ad7779",
+		.pm = pm_sleep_ptr(&ad7779_pm_ops),
+		.of_match_table = ad7779_of_table,
+	},
+	.probe = ad7779_probe,
+	.id_table = ad7779_id,
+};
+module_spi_driver(ad7779_driver);
+
+MODULE_AUTHOR("Ramona Alexandra Nechita <ramona.nechita@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD7779 ADC");
+MODULE_LICENSE("GPL");
-- 
2.43.0


