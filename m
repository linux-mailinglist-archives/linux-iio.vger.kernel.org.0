Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C422EA9C2
	for <lists+linux-iio@lfdr.de>; Tue,  5 Jan 2021 12:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbhAELYd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 5 Jan 2021 06:24:33 -0500
Received: from mx07-002cda01.pphosted.com ([185.132.180.122]:12482 "EHLO
        mx07-002cda01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725939AbhAELYc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Jan 2021 06:24:32 -0500
X-Greylist: delayed 899 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Jan 2021 06:24:25 EST
Received: from pps.filterd (m0135535.ppops.net [127.0.0.1])
        by mx07-002cda01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 105B7lup030107;
        Tue, 5 Jan 2021 11:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avl.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=28082020; bh=ubG0N+XrE+xu4sfSz4n8ar0gT3VFRiqsJgbMEwbweI4=;
 b=jRqwAhGKukuHFTVO0q0PeD+uOrFODcGLW8wjMQA9O/Dw6u2im3tZJu3/i/Nl7JVHTfEe
 bMK0mUi7W7r1Cz6ynjE/z3tQpA0Pz5LqNga1BawWG3lcq5TF80j9M/4YZsxHD50EdImR
 MPrJFfUtLAoHWBov0PVW9fCHUAsz682fHdRC2IrzB82IWCXcSP7gcKl+9jT1GB7ntN70
 dF9xhrgvbOOlcNoBGRNnzf70i41LMh4BhWkhjzIcEbslcjek/RKtXk9RwqWNjb8GiEsQ
 xEVjd3XgM3IYOUAMu/R60dPtTDH+0sIfxB/V6r8rnss902YYqQgCiH9R1x/1ic6+5yVh 5Q== 
Received: from atgrzso2901.avl01.avlcorp.lan ([192.102.17.76])
        by mx07-002cda01.pphosted.com with ESMTP id 35tj1h3ym3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 11:08:43 +0000
Received: from pps.filterd (atgrzso2901.avl01.avlcorp.lan [127.0.0.1])
        by atgrzso2901.avl01.avlcorp.lan (8.16.0.42/8.16.0.42) with SMTP id 105B5220031337;
        Tue, 5 Jan 2021 12:08:42 +0100
Received: from atgrzsw3759.avl01.avlcorp.lan ([10.13.100.86])
        by atgrzso2901.avl01.avlcorp.lan with ESMTP id 35thdsgsv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jan 2021 12:08:42 +0100
Received: from atgrzsw3764.avl01.avlcorp.lan (10.37.149.17) by
 atgrzsw3759.avl01.avlcorp.lan (10.37.149.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2044.4; Tue, 5 Jan 2021 12:08:41 +0100
Received: from ATGRZWN210214.avl01.avlcorp.lan (10.12.100.12) by
 atgrzsw3764.avl01.avlcorp.lan (10.37.149.17) with Microsoft SMTP Server id
 15.1.2044.4 via Frontend Transport; Tue, 5 Jan 2021 12:08:41 +0100
From:   <tomislav.denis@avl.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <tomislav.denis@avl.com>
Subject: [PATCH v2 1/2] iio: adc: Add driver for Texas Instruments ADS131E0x ADC family
Date:   Tue, 5 Jan 2021 12:08:38 +0100
Message-ID: <20210105110839.5436-2-tomislav.denis@avl.com>
X-Mailer: git-send-email 2.10.1.windows.1
In-Reply-To: <20210105110839.5436-1-tomislav.denis@avl.com>
References: <20210105110839.5436-1-tomislav.denis@avl.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: f9e74532-fb7d-4806-8539-2b9574eafa9a
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-05_01:2021-01-05,2021-01-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101050068
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-05_01:2021-01-05,2021-01-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 adultscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101050069
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Tomislav Denis <tomislav.denis@avl.com>

The ADS131E0x are a family of multichannel, simultaneous sampling,
24-bit, delta-sigma, analog-to-digital converters (ADCs) with a
built-in programmable gain amplifier (PGA), internal reference
and an onboard oscillator.

Signed-off-by: Tomislav Denis <tomislav.denis@avl.com>
---
 MAINTAINERS                    |   6 +
 drivers/iio/adc/Kconfig        |  12 +
 drivers/iio/adc/Makefile       |   1 +
 drivers/iio/adc/ti-ads131e08.c | 921 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 940 insertions(+)
 create mode 100644 drivers/iio/adc/ti-ads131e08.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ac5688..167aabf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17367,6 +17367,12 @@ M:	Robert Richter <rric@kernel.org>
 S:	Odd Fixes
 F:	drivers/gpio/gpio-thunderx.c
 
+TI ADS131E0X ADC SERIES DRIVER
+M:	Tomislav Denis <tomislav.denis@avl.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	drivers/iio/adc/ti-ads131e08.c
+
 TI AM437X VPFE DRIVER
 M:	"Lad, Prabhakar" <prabhakar.csengg@gmail.com>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 15587a1..ef5471a 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1151,6 +1151,18 @@ config TI_ADS124S08
 	  This driver can also be built as a module. If so, the module will be
 	  called ti-ads124s08.
 
+config TI_ADS131E08
+	tristate "Texas Instruments ADS131E08"
+	depends on SPI && OF
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say yes here you get support for Texas Instruments ADS131E08 and
+	  ADS131E04 chips.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called ti-ads131e08.
+
 config TI_AM335X_ADC
 	tristate "TI's AM335X ADC driver"
 	depends on MFD_TI_AM335X_TSCADC && HAS_DMA
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 5fca90a..a226657 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -103,6 +103,7 @@ obj-$(CONFIG_TI_ADS7950) += ti-ads7950.o
 obj-$(CONFIG_TI_ADS8344) += ti-ads8344.o
 obj-$(CONFIG_TI_ADS8688) += ti-ads8688.o
 obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
+obj-$(CONFIG_TI_ADS131E08) += ti-ads131e08.o
 obj-$(CONFIG_TI_AM335X_ADC) += ti_am335x_adc.o
 obj-$(CONFIG_TI_TLC4541) += ti-tlc4541.o
 obj-$(CONFIG_TWL4030_MADC) += twl4030-madc.o
diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
new file mode 100644
index 0000000..cf9d047
--- /dev/null
+++ b/drivers/iio/adc/ti-ads131e08.c
@@ -0,0 +1,921 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Texas Instruments ADS131E0x 4-, 6- and 8-Channel ADCs
+ *
+ * Copyright (c) 2020 AVL DiTEST GmbH
+ *   Tomislav Denis <tomislav.denis@avl.com>
+ *
+ * Datasheet: https://www.ti.com/lit/ds/symlink/ads131e08.pdf
+ */
+
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/bitfield.h>
+#include <linux/spi/spi.h>
+#include <linux/regulator/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/sysfs.h>
+#include <asm/unaligned.h>
+
+/* Commands */
+#define ADS131E08_CMD_RESET		0x06
+#define ADS131E08_CMD_START		0x08
+#define ADS131E08_CMD_STOP		0x0A
+#define ADS131E08_CMD_OFFSETCAL		0x1A
+#define ADS131E08_CMD_SDATAC		0x11
+#define ADS131E08_CMD_RDATA		0x12
+#define ADS131E08_CMD_RREG(r)		(0x20 | (r & GENMASK(4, 0)))
+#define ADS131E08_CMD_WREG(r)		(0x40 | (r & GENMASK(4, 0)))
+
+/* Registers */
+#define ADS131E08_ADR_CFG1R		0x01
+#define ADS131E08_ADR_CFG3R		0x03
+#define ADS131E08_ADR_CH0R		0x05
+
+/* Configuration register 1 */
+#define ADS131E08_CFG1R_DR_MASK		GENMASK(2, 0)
+
+/* Configuration register 3 */
+#define ADS131E08_CFG3R_PDB_REFBUF_MASK	BIT(7)
+#define ADS131E08_CFG3R_VREF_4V_MASK	BIT(5)
+
+/* Channel settings register */
+#define ADS131E08_CHR_GAIN_MASK		GENMASK(6, 4)
+#define ADS131E08_CHR_MUX_MASK		GENMASK(2, 0)
+#define ADS131E08_CHR_PWD_MASK		BIT(7)
+
+/* ADC  misc */
+#define ADS131E08_DEFAULT_DATA_RATE	1
+#define ADS131E08_DEFAULT_PGA_GAIN	1
+#define ADS131E08_DEFAULT_MUX		0
+
+#define ADS131E08_VREF_2V4_MV		2400
+#define ADS131E08_VREF_4V_MV		4000
+
+#define ADS131E08_WAIT_RESET_CYCLES	18
+#define ADS131E08_WAIT_SDECODE_CYCLES	4
+#define ADS131E08_WAIT_OFFSETCAL_MS	153
+#define ADS131E08_MAX_SETTLING_TIME_MS	6
+
+#define ADS131E08_NUM_STATUS_BYTES	3
+#define ADS131E08_NUM_DATA_BYTES_MAX	24
+#define ADS131E08_NUM_DATA_BYTES(dr)	(((dr) >= 32) ? 2 : 3)
+#define ADS131E08_NUM_DATA_BITS(dr)	(ADS131E08_NUM_DATA_BYTES(dr) * 8)
+#define ADS131E08_NUM_STORAGE_BYTES	4
+
+enum ads131e08_ids {
+	ads131e04,
+	ads131e06,
+	ads131e08,
+};
+
+struct ads131e08_info {
+	unsigned int max_channels;
+};
+
+struct ads131e08_channel_config {
+	unsigned int pga_gain;
+	unsigned int mux;
+};
+
+struct ads131e08_state {
+	const struct ads131e08_info *info;
+	struct spi_device *spi;
+	struct iio_trigger *trig;
+	struct clk *adc_clk;
+	struct regulator *vref_reg;
+	struct ads131e08_channel_config *channel_config;
+	unsigned int data_rate;
+	unsigned int vref_mv;
+	unsigned int sdecode_delay_us;
+	unsigned int reset_delay_us;
+	unsigned int readback_len;
+	struct completion completion;
+
+	struct {
+		u8 data[ADS131E08_NUM_DATA_BYTES_MAX];
+		s64 ts __aligned(8);
+	} tmp_buf;
+
+	u8 tx_buf[3] ____cacheline_aligned;
+	/*
+	 * Add extra one padding byte to be able to access the last channel
+	 * value using u32 pointer
+	 */
+	u8 rx_buf[ADS131E08_NUM_STATUS_BYTES +
+		ADS131E08_NUM_DATA_BYTES_MAX + 1];
+};
+
+static const struct ads131e08_info ads131e08_info_tbl[] = {
+	[ads131e04] = {
+		.max_channels = 4,
+	},
+	[ads131e06] = {
+		.max_channels = 6,
+	},
+	[ads131e08] = {
+		.max_channels = 8,
+	},
+};
+
+struct ads131e08_data_rate_desc {
+	unsigned int rate;  /* data rate in kSPS */
+	u8 reg;             /* reg value */
+};
+
+static const struct ads131e08_data_rate_desc ads131e08_data_rate_tbl[] = {
+	{ .rate = 64,   .reg = 0x00 },
+	{ .rate = 32,   .reg = 0x01 },
+	{ .rate = 16,   .reg = 0x02 },
+	{ .rate = 8,    .reg = 0x03 },
+	{ .rate = 4,    .reg = 0x04 },
+	{ .rate = 2,    .reg = 0x05 },
+	{ .rate = 1,    .reg = 0x06 },
+};
+
+struct ads131e08_pga_gain_desc {
+	unsigned int gain;  /* PGA gain value */
+	u8 reg;             /* reg value */
+};
+
+static const struct ads131e08_pga_gain_desc ads131e08_pga_gain_tbl[] = {
+	{ .gain = 1,   .reg = 0x01 },
+	{ .gain = 2,   .reg = 0x02 },
+	{ .gain = 4,   .reg = 0x04 },
+	{ .gain = 8,   .reg = 0x05 },
+	{ .gain = 12,  .reg = 0x06 },
+};
+
+static const u8 ads131e08_valid_channel_mux_values[] = { 0, 1, 3, 4 };
+
+static int ads131e08_exec_cmd(struct ads131e08_state *st, u8 cmd)
+{
+	int ret;
+
+	ret = spi_write_then_read(st->spi, &cmd, 1, NULL, 0);
+	if (ret) {
+		dev_err(&st->spi->dev,
+			"%s: SPI write failed for cmd: %02x\n", __func__, cmd);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ads131e08_read_reg(struct ads131e08_state *st, u8 reg)
+{
+	int ret;
+
+	struct spi_transfer transfer[] = {
+		{
+			.tx_buf = &st->tx_buf,
+			.len = 2,
+			.delay_usecs = st->sdecode_delay_us,
+		}, {
+			.rx_buf = &st->rx_buf,
+			.len = 1,
+		},
+	};
+
+	st->tx_buf[0] = ADS131E08_CMD_RREG(reg);
+	st->tx_buf[1] = 0;
+
+	ret = spi_sync_transfer(st->spi, transfer, ARRAY_SIZE(transfer));
+	if (ret) {
+		dev_err(&st->spi->dev, "%s: SPI transfer failed\n", __func__);
+		return ret;
+	}
+
+	return st->rx_buf[0];
+}
+
+static int ads131e08_write_reg(struct ads131e08_state *st, u8 reg, u8 value)
+{
+	int ret;
+
+	struct spi_transfer transfer[] = {
+		{
+			.tx_buf = &st->tx_buf,
+			.len = 3,
+			.delay_usecs = st->sdecode_delay_us,
+		}
+	};
+
+	st->tx_buf[0] = ADS131E08_CMD_WREG(reg);
+	st->tx_buf[1] = 0;
+	st->tx_buf[2] = value;
+
+	ret = spi_sync_transfer(st->spi, transfer, ARRAY_SIZE(transfer));
+	if (ret) {
+		dev_err(&st->spi->dev, "%s: SPI transfer failed\n", __func__);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ads131e08_read_data(struct ads131e08_state *st, int rx_len)
+{
+	int ret;
+
+	struct spi_transfer transfer[] = {
+		{
+			.tx_buf = &st->tx_buf,
+			.len = 1,
+		}, {
+			.rx_buf = &st->rx_buf,
+			.len = rx_len,
+		},
+	};
+
+	st->tx_buf[0] = ADS131E08_CMD_RDATA;
+
+	ret = spi_sync_transfer(st->spi, transfer, ARRAY_SIZE(transfer));
+	if (ret) {
+		dev_err(&st->spi->dev, "%s: SPI transfer failed\n", __func__);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ads131e08_set_data_rate(struct ads131e08_state *st, int data_rate)
+{
+	int i, reg, ret;
+
+	for (i = 0; i < ARRAY_SIZE(ads131e08_data_rate_tbl); ++i) {
+		if (ads131e08_data_rate_tbl[i].rate == data_rate)
+			break;
+	}
+
+	if (i == ARRAY_SIZE(ads131e08_data_rate_tbl)) {
+		dev_err(&st->spi->dev, "invalid data rate value\n");
+		return -EINVAL;
+	}
+
+	reg = ads131e08_read_reg(st, ADS131E08_ADR_CFG1R);
+	if (reg < 0)
+		return reg;
+
+	reg &= ~ADS131E08_CFG1R_DR_MASK;
+	reg |= FIELD_PREP(ADS131E08_CFG1R_DR_MASK,
+		ads131e08_data_rate_tbl[i].reg);
+
+	ret = ads131e08_write_reg(st, ADS131E08_ADR_CFG1R, reg);
+	if (ret)
+		return ret;
+
+	st->data_rate = data_rate;
+	st->readback_len = ADS131E08_NUM_STATUS_BYTES +
+		ADS131E08_NUM_DATA_BYTES(st->data_rate) *
+		st->info->max_channels;
+
+	return 0;
+}
+
+static int ads131e08_set_pga_gain(struct ads131e08_state *st,
+	unsigned int channel, unsigned int pga_gain)
+{
+	int i, reg;
+
+	for (i = 0; i < ARRAY_SIZE(ads131e08_pga_gain_tbl); ++i) {
+		if (ads131e08_pga_gain_tbl[i].gain == pga_gain)
+			break;
+	}
+
+	if (i == ARRAY_SIZE(ads131e08_pga_gain_tbl)) {
+		dev_err(&st->spi->dev, "invalid PGA gain value\n");
+		return -EINVAL;
+	}
+
+	reg = ads131e08_read_reg(st, ADS131E08_ADR_CH0R + channel);
+	if (reg < 0)
+		return reg;
+
+	reg &= ~ADS131E08_CHR_GAIN_MASK;
+	reg |= FIELD_PREP(ADS131E08_CHR_GAIN_MASK, ads131e08_pga_gain_tbl[i].reg);
+
+	return ads131e08_write_reg(st, ADS131E08_ADR_CH0R + channel, reg);
+}
+
+static int ads131e08_set_channel_mux(struct ads131e08_state *st,
+	unsigned int channel, unsigned int mux)
+{
+	int i, reg;
+
+	for (i = 0; i < ARRAY_SIZE(ads131e08_valid_channel_mux_values); ++i) {
+		if (ads131e08_valid_channel_mux_values[i] == mux)
+			break;
+	}
+
+	if (i == ARRAY_SIZE(ads131e08_valid_channel_mux_values)) {
+		dev_err(&st->spi->dev, "invalid channel mux value\n");
+		return -EINVAL;
+	}
+
+	reg = ads131e08_read_reg(st, ADS131E08_ADR_CH0R + channel);
+	if (reg < 0)
+		return reg;
+
+	reg &= ~ADS131E08_CHR_MUX_MASK;
+	reg |= FIELD_PREP(ADS131E08_CHR_MUX_MASK, mux);
+
+	return ads131e08_write_reg(st, ADS131E08_ADR_CH0R + channel, reg);
+}
+
+static int ads131e08_power_down_channel(struct ads131e08_state *st,
+	unsigned int channel, bool value)
+{
+	int reg;
+
+	reg = ads131e08_read_reg(st, ADS131E08_ADR_CH0R + channel);
+	if (reg < 0)
+		return reg;
+
+	reg &= ~ADS131E08_CHR_PWD_MASK;
+	reg |= FIELD_PREP(ADS131E08_CHR_PWD_MASK, value);
+
+	return ads131e08_write_reg(st, ADS131E08_ADR_CH0R + channel, reg);
+}
+
+static int ads131e08_config_reference_voltage(struct ads131e08_state *st)
+{
+	int reg;
+
+	reg = ads131e08_read_reg(st, ADS131E08_ADR_CFG3R);
+	if (reg < 0)
+		return reg;
+
+	reg &= ~ADS131E08_CFG3R_PDB_REFBUF_MASK |
+		~ADS131E08_CFG3R_VREF_4V_MASK;
+	reg |= FIELD_PREP(ADS131E08_CFG3R_PDB_REFBUF_MASK,
+		IS_ERR(st->vref_reg));
+	reg |= FIELD_PREP(ADS131E08_CFG3R_VREF_4V_MASK,
+		st->vref_mv == ADS131E08_VREF_4V_MV);
+
+	return ads131e08_write_reg(st, ADS131E08_ADR_CFG3R, reg);
+}
+
+static int ads131e08_initial_config(struct iio_dev *indio_dev)
+{
+	struct ads131e08_state *st = iio_priv(indio_dev);
+	const struct iio_chan_spec *channel = indio_dev->channels;
+	int ret, i;
+	u8 active_channels = 0;
+
+	ret = ads131e08_exec_cmd(st, ADS131E08_CMD_RESET);
+	if (ret)
+		return ret;
+
+	udelay(st->reset_delay_us);
+
+	/* Disable read data in continuous mode (enabled by default) */
+	ret = ads131e08_exec_cmd(st, ADS131E08_CMD_SDATAC);
+	if (ret)
+		return ret;
+
+	ret = ads131e08_set_data_rate(st, ADS131E08_DEFAULT_DATA_RATE);
+	if (ret)
+		return ret;
+
+	ret = ads131e08_config_reference_voltage(st);
+	if (ret)
+		return ret;
+
+	for (i = 0;  i < indio_dev->num_channels; ++i) {
+		ret = ads131e08_set_pga_gain(st, channel->channel,
+			st->channel_config[i].pga_gain);
+		if (ret)
+			return ret;
+
+		ret = ads131e08_set_channel_mux(st, channel->channel,
+			st->channel_config[i].mux);
+		if (ret)
+			return ret;
+
+		active_channels |= BIT(channel->channel);
+		channel++;
+	}
+
+	/* Power down unused channels */
+	for (i = 0; i < st->info->max_channels; ++i) {
+		if (!(active_channels & BIT(i))) {
+			ret = ads131e08_power_down_channel(st, i, true);
+			if (ret)
+				return ret;
+		}
+	}
+
+	/* Request channel offset calibration */
+	ret = ads131e08_exec_cmd(st, ADS131E08_CMD_OFFSETCAL);
+	if (ret)
+		return ret;
+
+	/*
+	 * Channel offset calibration is triggered with first START command.
+	 * Since calibration take more time than settling operation,
+	 * this causes timeout error when command START is sent first
+	 * time (e.g. first call of the ads131e08_read_direct method).
+	 * To avoid this problem offset calibration is triggered here.
+	 */
+	ret = ads131e08_exec_cmd(st, ADS131E08_CMD_START);
+	if (ret)
+		return ret;
+
+	msleep(ADS131E08_WAIT_OFFSETCAL_MS);
+
+	ret = ads131e08_exec_cmd(st, ADS131E08_CMD_STOP);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int ads131e08_read_direct(struct iio_dev *indio_dev,
+	struct iio_chan_spec const *channel, int *value)
+{
+	struct ads131e08_state *st = iio_priv(indio_dev);
+	int ret;
+	u8 num_bits, *src;
+
+	reinit_completion(&st->completion);
+
+	ret = ads131e08_exec_cmd(st, ADS131E08_CMD_START);
+	if (ret)
+		return ret;
+
+	ret = wait_for_completion_timeout(&st->completion,
+		msecs_to_jiffies(ADS131E08_MAX_SETTLING_TIME_MS));
+	if (!ret)
+		return -ETIMEDOUT;
+
+	ret = ads131e08_read_data(st, st->readback_len);
+	if (ret)
+		return ret;
+
+	ret = ads131e08_exec_cmd(st, ADS131E08_CMD_STOP);
+	if (ret)
+		return ret;
+
+	src = st->rx_buf + ADS131E08_NUM_STATUS_BYTES +
+		channel->channel * ADS131E08_NUM_DATA_BYTES(st->data_rate);
+
+	num_bits = ADS131E08_NUM_DATA_BITS(st->data_rate);
+	*value = sign_extend32(
+		get_unaligned_be32(src) >> (32 - num_bits), num_bits - 1);
+
+	return ret;
+}
+
+static int ads131e08_read_raw(struct iio_dev *indio_dev,
+	struct iio_chan_spec const *channel, int *value,
+	int *value2, long mask)
+{
+	struct ads131e08_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		ret = ads131e08_read_direct(indio_dev, channel, value);
+		iio_device_release_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*value = st->vref_mv /
+			st->channel_config[channel->address].pga_gain;
+		*value2 = ADS131E08_NUM_DATA_BITS(st->data_rate) - 1;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*value = st->data_rate;
+
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
+static int ads131e08_write_raw(struct iio_dev *indio_dev,
+	struct iio_chan_spec const *channel, int value,
+	int value2, long mask)
+{
+	struct ads131e08_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		ret = ads131e08_set_data_rate(st, value);
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
+	}
+
+	return -EINVAL;
+}
+
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("1 2 4 8 16 32 64");
+
+static struct attribute *ads131e08_attributes[] = {
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group ads131e08_attribute_group = {
+	.attrs = ads131e08_attributes,
+};
+
+static int ads131e08_debugfs_reg_access(struct iio_dev *indio_dev,
+	unsigned int reg, unsigned int writeval, unsigned int *readval)
+{
+	struct ads131e08_state *st = iio_priv(indio_dev);
+
+	if (readval) {
+		int ret = ads131e08_read_reg(st, (u8)reg);
+		*readval = ret;
+		return ret;
+	}
+
+	return ads131e08_write_reg(st, (u8)reg, (u8)writeval);
+}
+
+static const struct iio_info ads131e08_iio_info = {
+	.read_raw = ads131e08_read_raw,
+	.write_raw = ads131e08_write_raw,
+	.attrs = &ads131e08_attribute_group,
+	.debugfs_reg_access = &ads131e08_debugfs_reg_access,
+};
+
+static int ads131e08_set_trigger_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct ads131e08_state *st = iio_priv(indio_dev);
+	u8 cmd = state ? ADS131E08_CMD_START : ADS131E08_CMD_STOP;
+
+	return ads131e08_exec_cmd(st, cmd);
+}
+
+static const struct iio_trigger_ops ads131e08_trigger_ops = {
+	.set_trigger_state = &ads131e08_set_trigger_state,
+};
+
+static irqreturn_t ads131e08_trigger_handler(int irq, void *private)
+{
+	struct iio_poll_func *pf = private;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ads131e08_state *st = iio_priv(indio_dev);
+	int ret;
+	unsigned int chn, i = 0;
+	u8 *src, *dest;
+	/*
+	 * The number of data bits per channel depends on the data rate.
+	 * For 32 and 64 ksps data rates, number of data bits per channel
+	 * is 16. This case is not compliant with used (fixed) scan element
+	 * type (be:s24/32>>8). So we use a litle tweek to pack properly
+	 * 16 bits of data into the buffer.
+	 */
+	unsigned int num_bytes = ADS131E08_NUM_DATA_BYTES(st->data_rate);
+	u8 tweek_offset = num_bytes == 2 ? 1 : 0;
+
+	ret = ads131e08_read_data(st, st->readback_len);
+	if (ret)
+		goto out;
+
+	for_each_set_bit(chn, indio_dev->active_scan_mask,
+		indio_dev->masklength) {
+		src = st->rx_buf + ADS131E08_NUM_STATUS_BYTES + chn * num_bytes;
+		dest = st->tmp_buf.data + i * ADS131E08_NUM_STORAGE_BYTES;
+
+		/*
+		 * Tweek offset is 0:
+		 * +---+---+---+---+
+		 * |D0 |D1 |D2 | X | (3 data bytes)
+		 * +---+---+---+---+
+		 *  a+0 a+1 a+2 a+3
+		 *
+		 * Tweek offset is 1:
+		 * +---+---+---+---+
+		 * |P0 |D0 |D1 | X | (one padding byte and 2 data bytes)
+		 * +---+---+---+---+
+		 *  a+0 a+1 a+2 a+3
+		 */
+		memcpy(dest + tweek_offset, src, num_bytes);
+
+		/*
+		 * Data conversion from 16 bits of data to 24 bits of data
+		 * is done by sign etension (properly filling padding byte).
+		 */
+		if (tweek_offset)
+			memset(dest, *src & BIT(7) ? 0xff : 0x00, 1);
+
+		i++;
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, st->tmp_buf.data,
+		iio_get_time_ns(indio_dev));
+
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t ads131e08_interrupt(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct ads131e08_state *st = iio_priv(indio_dev);
+
+	if (iio_buffer_enabled(indio_dev))
+		iio_trigger_poll(st->trig);
+	else
+		complete(&st->completion);
+
+	return IRQ_HANDLED;
+}
+
+static int ads131e08_parse_dt(struct iio_dev *indio_dev,
+	struct device_node *node)
+{
+	struct ads131e08_state *st = iio_priv(indio_dev);
+	struct iio_chan_spec *channels;
+	struct ads131e08_channel_config *channel_config;
+	struct device_node *child;
+	unsigned int channel, tmp;
+	int num_channels, i, ret;
+
+	ret = of_property_read_u32(node, "ti,vref-internal", &tmp);
+	if (ret)
+		tmp = 0;
+
+	switch (tmp) {
+	case 0:
+		st->vref_mv = ADS131E08_VREF_2V4_MV;
+		break;
+	case 1:
+		st->vref_mv = ADS131E08_VREF_4V_MV;
+		break;
+	default:
+		dev_err(&st->spi->dev, "invalid internal voltage reference\n");
+		return -EINVAL;
+	}
+
+	num_channels = of_get_available_child_count(node);
+	if (num_channels == 0) {
+		dev_err(&st->spi->dev, "no channel children\n");
+		return -ENODEV;
+	}
+
+	if (num_channels > st->info->max_channels) {
+		dev_err(&st->spi->dev, "num of channel children out of range\n");
+		return -EINVAL;
+	}
+
+	channels = devm_kcalloc(&st->spi->dev, num_channels,
+		sizeof(struct iio_chan_spec), GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
+
+	channel_config = devm_kcalloc(&st->spi->dev, num_channels,
+		sizeof(struct ads131e08_channel_config), GFP_KERNEL);
+	if (!channel_config)
+		return -ENOMEM;
+
+	i = 0;
+	for_each_available_child_of_node(node, child) {
+		ret = of_property_read_u32(child, "reg", &channel);
+		if (ret)
+			return ret;
+
+		ret = of_property_read_u32(child, "ti,gain", &tmp);
+		if (ret)
+			channel_config[i].pga_gain = ADS131E08_DEFAULT_PGA_GAIN;
+		else
+			channel_config[i].pga_gain = tmp;
+
+		ret = of_property_read_u32(child, "ti,mux", &tmp);
+		if (ret)
+			channel_config[i].mux = ADS131E08_DEFAULT_MUX;
+		else
+			channel_config[i].mux = tmp;
+
+		channels[i].type = IIO_VOLTAGE;
+		channels[i].indexed = 1;
+		channels[i].channel = channel;
+		channels[i].address = i;
+		channels[i].info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+						BIT(IIO_CHAN_INFO_SCALE);
+		channels[i].info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ);
+		channels[i].scan_index = channel;
+		channels[i].scan_type.sign = 's';
+		channels[i].scan_type.realbits = 24;
+		channels[i].scan_type.storagebits = 32;
+		channels[i].scan_type.shift = 8;
+		channels[i].scan_type.endianness = IIO_BE;
+		i++;
+	}
+
+	indio_dev->channels = channels;
+	indio_dev->num_channels = num_channels;
+	st->channel_config = channel_config;
+
+	return 0;
+}
+
+static void ads131e08_regulator_disable(void *data)
+{
+	struct ads131e08_state *st = data;
+
+	regulator_disable(st->vref_reg);
+}
+
+static void ads131e08_clk_disable(void *data)
+{
+	struct ads131e08_state *st = data;
+
+	clk_disable_unprepare(st->adc_clk);
+}
+
+static int ads131e08_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct ads131e08_state *st;
+	int ret;
+	unsigned long adc_clk_hz, adc_clk_ns;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev) {
+		dev_err(&spi->dev, "failed to allocate IIO device\n");
+		return -ENOMEM;
+	}
+
+	spi_set_drvdata(spi, indio_dev);
+
+	st = iio_priv(indio_dev);
+	st->info = &ads131e08_info_tbl[spi_get_device_id(spi)->driver_data];
+	st->spi = spi;
+
+	ret = ads131e08_parse_dt(indio_dev, spi->dev.of_node);
+	if (ret)
+		return ret;
+
+	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->dev.of_node = spi->dev.of_node;
+	indio_dev->info = &ads131e08_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	init_completion(&st->completion);
+
+	if (spi->irq) {
+		ret = devm_request_irq(&spi->dev, spi->irq,
+			ads131e08_interrupt,
+			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+			spi->dev.driver->name, indio_dev);
+		if (ret) {
+			dev_err(&spi->dev, "failed to allocate IRQ\n");
+			return ret;
+		}
+	} else {
+		dev_err(&spi->dev, "data ready IRQ missing\n");
+		return -ENODEV;
+	}
+
+	st->trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
+		indio_dev->name, indio_dev->id);
+	if (!st->trig) {
+		dev_err(&spi->dev, "failed to allocate IIO trigger\n");
+		return -ENOMEM;
+	}
+
+	st->trig->ops = &ads131e08_trigger_ops;
+	st->trig->dev.parent = &spi->dev;
+	iio_trigger_set_drvdata(st->trig, indio_dev);
+	ret = devm_iio_trigger_register(&spi->dev, st->trig);
+	if (ret) {
+		dev_err(&spi->dev, "failed to register IIO trigger\n");
+		return -ENOMEM;
+	}
+
+	indio_dev->trig = iio_trigger_get(st->trig);
+
+	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
+		NULL, &ads131e08_trigger_handler, NULL);
+	if (ret) {
+		dev_err(&spi->dev, "failed to setup IIO buffer\n");
+		return ret;
+	}
+
+	st->vref_reg = devm_regulator_get_optional(&spi->dev, "vref");
+	if (!IS_ERR(st->vref_reg)) {
+		ret = regulator_enable(st->vref_reg);
+		if (ret) {
+			dev_err(&spi->dev,
+				"failed to enable external vref supply\n");
+			return ret;
+		}
+
+		ret = devm_add_action_or_reset(&spi->dev,
+			ads131e08_regulator_disable, st);
+		if (ret) {
+			regulator_disable(st->vref_reg);
+			return ret;
+		}
+
+		ret = regulator_get_voltage(st->vref_reg);
+		if (ret < 0) {
+			dev_err(&spi->dev, "failed to get vref voltage\n");
+			return ret;
+		}
+
+		st->vref_mv = ret / 1000;
+	}
+
+	st->adc_clk = devm_clk_get(&spi->dev, "adc-clk");
+	if (IS_ERR(st->adc_clk)) {
+		dev_err(&spi->dev, "failed to get the ADC clock\n");
+		return PTR_ERR(st->adc_clk);
+	}
+
+	ret = clk_prepare_enable(st->adc_clk);
+	if (ret) {
+		dev_err(&spi->dev, "failed to prepare/enable the ADC clock\n");
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(&spi->dev, ads131e08_clk_disable, st);
+	if (ret) {
+		clk_disable_unprepare(st->adc_clk);
+		return ret;
+	}
+
+	adc_clk_hz = clk_get_rate(st->adc_clk);
+	if (!adc_clk_hz) {
+		dev_err(&spi->dev, "failed to get the ADC clock rate\n");
+		return  -EINVAL;
+	}
+
+	adc_clk_ns = NSEC_PER_SEC / adc_clk_hz;
+	st->sdecode_delay_us = DIV_ROUND_UP(
+		ADS131E08_WAIT_SDECODE_CYCLES * adc_clk_ns, 1000);
+	st->reset_delay_us = DIV_ROUND_UP(
+		ADS131E08_WAIT_RESET_CYCLES * adc_clk_ns, 1000);
+
+	ret = ads131e08_initial_config(indio_dev);
+	if (ret) {
+		dev_err(&spi->dev, "initial configuration failed\n");
+		return ret;
+	}
+
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
+	if (ret) {
+		dev_err(&spi->dev, "failed to register IIO device\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id ads131e08_of_match[] = {
+	{ .compatible = "ti,ads131e04", },
+	{ .compatible = "ti,ads131e06", },
+	{ .compatible = "ti,ads131e08", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ads131e08_of_match);
+
+static const struct spi_device_id ads131e08_id[] = {
+	{ "ads131e04",      ads131e04},
+	{ "ads131e06",      ads131e06},
+	{ "ads131e08",      ads131e08},
+	{}
+};
+MODULE_DEVICE_TABLE(spi, ads131e08_id);
+
+static struct spi_driver ads131e08_driver = {
+	.driver = {
+		.name = "ads131e08",
+		.of_match_table = ads131e08_of_match,
+	},
+	.probe = ads131e08_probe,
+	.id_table = ads131e08_id,
+};
+module_spi_driver(ads131e08_driver);
+
+MODULE_AUTHOR("Tomislav Denis <tomislav.denis@avl.com>");
+MODULE_DESCRIPTION("Driver for ADS131E0x ADC family");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

