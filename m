Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0B181911E7
	for <lists+linux-iio@lfdr.de>; Tue, 24 Mar 2020 14:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgCXNrw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Mar 2020 09:47:52 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:29834 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726188AbgCXNrw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Mar 2020 09:47:52 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02ODj9Ox027856;
        Tue, 24 Mar 2020 09:47:39 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2ywcs626b9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Mar 2020 09:47:39 -0400
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 02ODlcB1053457
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 24 Mar 2020 09:47:38 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 24 Mar 2020 09:47:37 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 24 Mar 2020 09:47:37 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 24 Mar 2020 09:47:37 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 02ODlDnp002365;
        Tue, 24 Mar 2020 09:47:28 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>, <Laszlo.Nagy@analog.com>,
        <Andrei.Grozav@analog.com>, <Michael.Hennerich@analog.com>,
        <Istvan.Csomortani@analog.com>, <Adrian.Costina@analog.com>,
        <Dragos.Bogdan@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v13 7/8] iio: adc: ad9467: add support AD9467 ADC
Date:   Tue, 24 Mar 2020 15:46:35 +0200
Message-ID: <20200324134636.64643-8-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200324134636.64643-1-alexandru.ardelean@analog.com>
References: <20200324134636.64643-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-24_05:2020-03-23,2020-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003240074
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

The AD9467 is a 16-bit, monolithic, IF sampling analog-to-digital converter
(ADC). It is optimized for high performanceover wide bandwidths and ease of
use. The product operates at a 250 MSPS conversion rate and is designed for
wireless receivers, instrumentation, and test equipment that require a high
dynamic range. The ADC requires 1.8 V and 3.3 V power supplies and a low
voltage differential input clock for full performance operation. No
external reference or driver components are required for many applications.
Data outputs are LVDS compatible (ANSI-644 compatible) and include the
means to reduce the overall current needed for short trace distances.

Since the chip can operate at such high sample-rates (much higher than
classical interfaces), it requires that a DMA controller be used to
interface directly to the chip and push data into memory.
Typically, the AXI ADC IP core is used to interface with it.

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/AD9467.pdf

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/iio/adc/Kconfig  |  15 ++
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/ad9467.c | 420 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 436 insertions(+)
 create mode 100644 drivers/iio/adc/ad9467.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 445070abf376..a0796510f9d4 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -246,6 +246,21 @@ config AD799X
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad799x.
 
+config AD9467
+	tristate "Analog Devices AD9467 High Speed ADC driver"
+	depends on SPI
+	select ADI_AXI_ADC
+	help
+	  Say yes here to build support for Analog Devices:
+	  * AD9467 16-Bit, 200 MSPS/250 MSPS Analog-to-Digital Converter
+
+	  The driver requires the assistance of the AXI ADC IP core to operate,
+	  since SPI is used for configuration only, while data has to be
+	  streamed into memory via DMA.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad9467.
+
 config ADI_AXI_ADC
 	tristate "Analog Devices Generic AXI ADC IP core driver"
 	select IIO_BUFFER
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 7c6594d049f9..59722770a654 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_AD7793) += ad7793.o
 obj-$(CONFIG_AD7887) += ad7887.o
 obj-$(CONFIG_AD7949) += ad7949.o
 obj-$(CONFIG_AD799X) += ad799x.o
+obj-$(CONFIG_AD9467) += ad9467.o
 obj-$(CONFIG_ADI_AXI_ADC) += adi-axi-adc.o
 obj-$(CONFIG_ASPEED_ADC) += aspeed_adc.o
 obj-$(CONFIG_AT91_ADC) += at91_adc.o
diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
new file mode 100644
index 000000000000..82f6235a9288
--- /dev/null
+++ b/drivers/iio/adc/ad9467.c
@@ -0,0 +1,420 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices AD9467 SPI ADC driver
+ *
+ * Copyright 2012-2020 Analog Devices Inc.
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/of_device.h>
+
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#include <linux/clk.h>
+
+#include <linux/iio/adc/adi-axi-adc.h>
+
+/*
+ * ADI High-Speed ADC common spi interface registers
+ * See Application-Note AN-877:
+ *   https://www.analog.com/media/en/technical-documentation/application-notes/AN-877.pdf
+ */
+
+#define AN877_ADC_REG_CHIP_PORT_CONF		0x00
+#define AN877_ADC_REG_CHIP_ID			0x01
+#define AN877_ADC_REG_CHIP_GRADE		0x02
+#define AN877_ADC_REG_CHAN_INDEX		0x05
+#define AN877_ADC_REG_TRANSFER			0xFF
+#define AN877_ADC_REG_MODES			0x08
+#define AN877_ADC_REG_TEST_IO			0x0D
+#define AN877_ADC_REG_ADC_INPUT			0x0F
+#define AN877_ADC_REG_OFFSET			0x10
+#define AN877_ADC_REG_OUTPUT_MODE		0x14
+#define AN877_ADC_REG_OUTPUT_ADJUST		0x15
+#define AN877_ADC_REG_OUTPUT_PHASE		0x16
+#define AN877_ADC_REG_OUTPUT_DELAY		0x17
+#define AN877_ADC_REG_VREF			0x18
+#define AN877_ADC_REG_ANALOG_INPUT		0x2C
+
+/* AN877_ADC_REG_TEST_IO */
+#define AN877_ADC_TESTMODE_OFF			0x0
+#define AN877_ADC_TESTMODE_MIDSCALE_SHORT	0x1
+#define AN877_ADC_TESTMODE_POS_FULLSCALE	0x2
+#define AN877_ADC_TESTMODE_NEG_FULLSCALE	0x3
+#define AN877_ADC_TESTMODE_ALT_CHECKERBOARD	0x4
+#define AN877_ADC_TESTMODE_PN23_SEQ		0x5
+#define AN877_ADC_TESTMODE_PN9_SEQ		0x6
+#define AN877_ADC_TESTMODE_ONE_ZERO_TOGGLE	0x7
+#define AN877_ADC_TESTMODE_USER			0x8
+#define AN877_ADC_TESTMODE_BIT_TOGGLE		0x9
+#define AN877_ADC_TESTMODE_SYNC			0xA
+#define AN877_ADC_TESTMODE_ONE_BIT_HIGH		0xB
+#define AN877_ADC_TESTMODE_MIXED_BIT_FREQUENCY	0xC
+#define AN877_ADC_TESTMODE_RAMP			0xF
+
+/* AN877_ADC_REG_TRANSFER */
+#define AN877_ADC_TRANSFER_SYNC			0x1
+
+/* AN877_ADC_REG_OUTPUT_MODE */
+#define AN877_ADC_OUTPUT_MODE_OFFSET_BINARY	0x0
+#define AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT	0x1
+#define AN877_ADC_OUTPUT_MODE_GRAY_CODE		0x2
+
+/* AN877_ADC_REG_OUTPUT_PHASE */
+#define AN877_ADC_OUTPUT_EVEN_ODD_MODE_EN	0x20
+#define AN877_ADC_INVERT_DCO_CLK		0x80
+
+/* AN877_ADC_REG_OUTPUT_DELAY */
+#define AN877_ADC_DCO_DELAY_ENABLE		0x80
+
+/*
+ * Analog Devices AD9467 16-Bit, 200/250 MSPS ADC
+ */
+
+#define CHIPID_AD9467			0x50
+#define AD9467_DEF_OUTPUT_MODE		0x08
+#define AD9467_REG_VREF_MASK		0x0F
+
+enum {
+	ID_AD9467,
+};
+
+struct ad9467_state {
+	struct spi_device		*spi;
+	struct clk			*clk;
+	unsigned int			output_mode;
+
+	struct gpio_desc		*pwrdown_gpio;
+	struct gpio_desc		*reset_gpio;
+};
+
+static int ad9467_spi_read(struct spi_device *spi, unsigned int reg)
+{
+	unsigned char tbuf[2], rbuf[1];
+	int ret;
+
+	tbuf[0] = 0x80 | (reg >> 8);
+	tbuf[1] = reg & 0xFF;
+
+	ret = spi_write_then_read(spi,
+				  tbuf, ARRAY_SIZE(tbuf),
+				  rbuf, ARRAY_SIZE(rbuf));
+
+	if (ret < 0)
+		return ret;
+
+	return rbuf[0];
+}
+
+static int ad9467_spi_write(struct spi_device *spi, unsigned int reg,
+			    unsigned int val)
+{
+	unsigned char buf[3];
+
+	buf[0] = reg >> 8;
+	buf[1] = reg & 0xFF;
+	buf[2] = val;
+
+	return spi_write(spi, buf, ARRAY_SIZE(buf));
+}
+
+static int ad9467_reg_access(struct adi_axi_adc_conv *conv, unsigned int reg,
+			     unsigned int writeval, unsigned int *readval)
+{
+	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
+	struct spi_device *spi = st->spi;
+	int ret;
+
+	if (readval == NULL) {
+		ret = ad9467_spi_write(spi, reg, writeval);
+		ad9467_spi_write(spi, AN877_ADC_REG_TRANSFER,
+				 AN877_ADC_TRANSFER_SYNC);
+		return ret;
+	}
+
+	ret = ad9467_spi_read(spi, reg);
+	if (ret < 0)
+		return ret;
+	*readval = ret;
+
+	return 0;
+}
+
+static const unsigned int ad9467_scale_table[][2] = {
+	{2000, 0}, {2100, 6}, {2200, 7},
+	{2300, 8}, {2400, 9}, {2500, 10},
+};
+
+static void __ad9467_get_scale(struct adi_axi_adc_conv *conv, int index,
+			       unsigned int *val, unsigned int *val2)
+{
+	const struct adi_axi_adc_chip_info *info = conv->chip_info;
+	const struct iio_chan_spec *chan = &info->channels[0];
+	unsigned int tmp;
+
+	tmp = (info->scale_table[index][0] * 1000000ULL) >>
+			chan->scan_type.realbits;
+	*val = tmp / 1000000;
+	*val2 = tmp % 1000000;
+}
+
+#define AD9467_CHAN(_chan, _si, _bits, _sign)				\
+{									\
+	.type = IIO_VOLTAGE,						\
+	.indexed = 1,							\
+	.channel = _chan,						\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
+	.scan_index = _si,						\
+	.scan_type = {							\
+		.sign = _sign,						\
+		.realbits = _bits,					\
+		.storagebits = 16,					\
+	},								\
+}
+
+static const struct iio_chan_spec ad9467_channels[] = {
+	AD9467_CHAN(0, 0, 16, 'S'),
+};
+
+static const struct adi_axi_adc_chip_info ad9467_chip_tbl[] = {
+	[ID_AD9467] = {
+		.id = CHIPID_AD9467,
+		.max_rate = 250000000UL,
+		.scale_table = ad9467_scale_table,
+		.num_scales = ARRAY_SIZE(ad9467_scale_table),
+		.channels = ad9467_channels,
+		.num_channels = ARRAY_SIZE(ad9467_channels),
+	},
+};
+
+static int ad9467_get_scale(struct adi_axi_adc_conv *conv, int *val, int *val2)
+{
+	const struct adi_axi_adc_chip_info *info = conv->chip_info;
+	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
+	unsigned int i, vref_val, vref_mask;
+
+	vref_val = ad9467_spi_read(st->spi, AN877_ADC_REG_VREF);
+
+	switch (info->id) {
+	case CHIPID_AD9467:
+		vref_mask = AD9467_REG_VREF_MASK;
+		break;
+	default:
+		vref_mask = 0xFFFF;
+		break;
+	}
+
+	vref_val &= vref_mask;
+
+	for (i = 0; i < info->num_scales; i++) {
+		if (vref_val == info->scale_table[i][1])
+			break;
+	}
+
+	if (i == info->num_scales)
+		return -ERANGE;
+
+	__ad9467_get_scale(conv, i, val, val2);
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int ad9467_set_scale(struct adi_axi_adc_conv *conv, int val, int val2)
+{
+	const struct adi_axi_adc_chip_info *info = conv->chip_info;
+	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
+	unsigned int scale_val[2];
+	unsigned int i;
+
+	if (val != 0)
+		return -EINVAL;
+
+	for (i = 0; i < info->num_scales; i++) {
+		__ad9467_get_scale(conv, i, &scale_val[0], &scale_val[1]);
+		if (scale_val[0] != val || scale_val[1] != val2)
+			continue;
+
+		ad9467_spi_write(st->spi, AN877_ADC_REG_VREF,
+				 info->scale_table[i][1]);
+		ad9467_spi_write(st->spi, AN877_ADC_REG_TRANSFER,
+				 AN877_ADC_TRANSFER_SYNC);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int ad9467_read_raw(struct adi_axi_adc_conv *conv,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long m)
+{
+	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
+
+	switch (m) {
+	case IIO_CHAN_INFO_SCALE:
+		return ad9467_get_scale(conv, val, val2);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = clk_get_rate(st->clk);
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad9467_write_raw(struct adi_axi_adc_conv *conv,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long mask)
+{
+	const struct adi_axi_adc_chip_info *info = conv->chip_info;
+	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
+	unsigned long r_clk;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return ad9467_set_scale(conv, val, val2);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		r_clk = clk_round_rate(st->clk, val);
+		if (r_clk < 0 || r_clk > info->max_rate) {
+			dev_warn(&st->spi->dev,
+				 "Error setting ADC sample rate %ld", r_clk);
+			return -EINVAL;
+		}
+
+		return clk_set_rate(st->clk, r_clk);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad9467_outputmode_set(struct spi_device *spi, unsigned int mode)
+{
+	int ret;
+
+	ret = ad9467_spi_write(spi, AN877_ADC_REG_OUTPUT_MODE, mode);
+	if (ret < 0)
+		return ret;
+
+	return ad9467_spi_write(spi, AN877_ADC_REG_TRANSFER,
+				AN877_ADC_TRANSFER_SYNC);
+}
+
+static int ad9467_preenable_setup(struct adi_axi_adc_conv *conv)
+{
+	struct ad9467_state *st = adi_axi_adc_conv_priv(conv);
+
+	return ad9467_outputmode_set(st->spi, st->output_mode);
+}
+
+static int ad9467_setup(struct ad9467_state *st, unsigned int chip_id)
+{
+	switch (chip_id) {
+	case CHIPID_AD9467:
+		st->output_mode = AD9467_DEF_OUTPUT_MODE |
+				  AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static void ad9467_clk_disable(void *data)
+{
+	struct ad9467_state *st = data;
+
+	clk_disable_unprepare(st->clk);
+}
+
+static int ad9467_probe(struct spi_device *spi)
+{
+	const struct adi_axi_adc_chip_info *info;
+	struct adi_axi_adc_conv *conv;
+	struct ad9467_state *st;
+	unsigned int id;
+	int ret;
+
+	info = of_device_get_match_data(&spi->dev);
+	if (!info)
+		return -ENODEV;
+
+	conv = devm_adi_axi_adc_conv_register(&spi->dev, sizeof(*st));
+	if (IS_ERR(conv))
+		return PTR_ERR(conv);
+
+	st = adi_axi_adc_conv_priv(conv);
+	st->spi = spi;
+
+	st->clk = devm_clk_get(&spi->dev, "adc-clk");
+	if (IS_ERR(st->clk))
+		return PTR_ERR(st->clk);
+
+	ret = clk_prepare_enable(st->clk);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_add_action_or_reset(&spi->dev, ad9467_clk_disable, st);
+	if (ret)
+		return ret;
+
+	st->pwrdown_gpio = devm_gpiod_get_optional(&spi->dev, "powerdown",
+						   GPIOD_OUT_LOW);
+	if (IS_ERR(st->pwrdown_gpio))
+		return PTR_ERR(st->pwrdown_gpio);
+
+	st->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset",
+						 GPIOD_OUT_LOW);
+	if (IS_ERR(st->reset_gpio))
+		return PTR_ERR(st->reset_gpio);
+
+	if (st->reset_gpio) {
+		udelay(1);
+		ret = gpiod_direction_output(st->reset_gpio, 1);
+		mdelay(10);
+	}
+
+	spi_set_drvdata(spi, st);
+
+	conv->chip_info = info;
+
+	id = ad9467_spi_read(spi, AN877_ADC_REG_CHIP_ID);
+	if (id != conv->chip_info->id) {
+		dev_err(&spi->dev, "Unrecognized CHIP_ID 0x%X\n", id);
+		return -ENODEV;
+	}
+
+	conv->reg_access = ad9467_reg_access;
+	conv->write_raw = ad9467_write_raw;
+	conv->read_raw = ad9467_read_raw;
+	conv->preenable_setup = ad9467_preenable_setup;
+
+	return ad9467_setup(st, id);
+}
+
+static const struct of_device_id ad9467_of_match[] = {
+	{ .compatible = "adi,ad9467", .data = &ad9467_chip_tbl[ID_AD9467], },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ad9467_of_match);
+
+static struct spi_driver ad9467_driver = {
+	.driver = {
+		.name = "ad9467",
+		.of_match_table = ad9467_of_match,
+	},
+	.probe = ad9467_probe,
+};
+module_spi_driver(ad9467_driver);
+
+MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD9467 ADC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

