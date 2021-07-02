Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823D63B9F8F
	for <lists+linux-iio@lfdr.de>; Fri,  2 Jul 2021 13:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhGBLRV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Jul 2021 07:17:21 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:30820 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231130AbhGBLRV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Jul 2021 07:17:21 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 162BBMuD029561;
        Fri, 2 Jul 2021 07:14:48 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 39h859wfk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jul 2021 07:14:48 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 162BElw2052696
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Jul 2021 07:14:47 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Fri, 2 Jul 2021
 07:14:46 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Fri, 2 Jul 2021 07:14:46 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.128])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 162BEhEJ008901;
        Fri, 2 Jul 2021 07:14:44 -0400
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v4 1/2] iio: frequency: adrf6780: add support for ADRF6780
Date:   Fri, 2 Jul 2021 14:12:38 +0300
Message-ID: <20210702111239.174189-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: u6SbmTkomfrzD_8c3sQCBhFnKjQL5cEx
X-Proofpoint-ORIG-GUID: u6SbmTkomfrzD_8c3sQCBhFnKjQL5cEx
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-02_03:2021-07-02,2021-07-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 mlxscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107020063
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ADRF6780 is a silicon germanium (SiGe) design, wideband,
microwave upconverter optimized for point to point microwave
radio designs operating in the 5.9 GHz to 23.6 GHz frequency
range.

Datasheet:
https://www.analog.com/media/en/technical-documentation/data-sheets/ADRF6780.pdf

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 changes in v4:
  - change license to: GPL-2.0-only
 drivers/iio/frequency/Kconfig    |  13 +
 drivers/iio/frequency/Makefile   |   1 +
 drivers/iio/frequency/adrf6780.c | 498 +++++++++++++++++++++++++++++++
 3 files changed, 512 insertions(+)
 create mode 100644 drivers/iio/frequency/adrf6780.c

diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
index 240b81502512..fc9751c48f59 100644
--- a/drivers/iio/frequency/Kconfig
+++ b/drivers/iio/frequency/Kconfig
@@ -49,5 +49,18 @@ config ADF4371
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called adf4371.
+
+config ADRF6780
+        tristate "Analog Devices ADRF6780 Microwave Upconverter"
+        depends on SPI
+        depends on COMMON_CLK
+        depends on OF
+        help
+          Say yes here to build support for Analog Devices ADRF6780
+          5.9 GHz to 23.6 GHz, Wideband, Microwave Upconverter.
+
+          To compile this driver as a module, choose M here: the
+          module will be called adrf6780.
+
 endmenu
 endmenu
diff --git a/drivers/iio/frequency/Makefile b/drivers/iio/frequency/Makefile
index 518b1e50caef..ae3136c79202 100644
--- a/drivers/iio/frequency/Makefile
+++ b/drivers/iio/frequency/Makefile
@@ -7,3 +7,4 @@
 obj-$(CONFIG_AD9523) += ad9523.o
 obj-$(CONFIG_ADF4350) += adf4350.o
 obj-$(CONFIG_ADF4371) += adf4371.o
+obj-$(CONFIG_ADRF6780) += adrf6780.o
diff --git a/drivers/iio/frequency/adrf6780.c b/drivers/iio/frequency/adrf6780.c
new file mode 100644
index 000000000000..472a66f90c7f
--- /dev/null
+++ b/drivers/iio/frequency/adrf6780.c
@@ -0,0 +1,498 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ADRF6780 driver
+ *
+ * Copyright 2021 Analog Devices Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+
+/* ADRF6780 Register Map */
+#define ADRF6780_REG_CONTROL			0x00
+#define ADRF6780_REG_ALARM_READBACK		0x01
+#define ADRF6780_REG_ALARM_MASKS		0x02
+#define ADRF6780_REG_ENABLE			0x03
+#define ADRF6780_REG_LINEARIZE			0x04
+#define ADRF6780_REG_LO_PATH			0x05
+#define ADRF6780_REG_ADC_CONTROL		0x06
+#define ADRF6780_REG_ADC_OUTPUT			0x0C
+
+/* ADRF6780_REG_CONTROL Map */
+#define ADRF6780_PARITY_EN_MSK			BIT(15)
+#define ADRF6780_PARITY_EN(x)			FIELD_PREP(ADRF6780_PARITY_EN_MSK, x)
+#define ADRF6780_SOFT_RESET_MSK			BIT(14)
+#define ADRF6780_SOFT_RESET(x)			FIELD_PREP(ADRF6780_SOFT_RESET_MSK, x)
+#define ADRF6780_CHIP_ID_MSK			GENMASK(11, 4)
+#define ADRF6780_CHIP_ID			0xA
+#define ADRF6780_CHIP_REVISION_MSK		GENMASK(3, 0)
+#define ADRF6780_CHIP_REVISION(x)		FIELD_PREP(ADRF6780_CHIP_REVISION_MSK, x)
+
+/* ADRF6780_REG_ALARM_READBACK Map */
+#define ADRF6780_PARITY_ERROR_MSK		BIT(15)
+#define ADRF6780_PARITY_ERROR(x)		FIELD_PREP(ADRF6780_PARITY_ERROR_MSK, x)
+#define ADRF6780_TOO_FEW_ERRORS_MSK		BIT(14)
+#define ADRF6780_TOO_FEW_ERRORS(x)		FIELD_PREP(ADRF6780_TOO_FEW_ERRORS_MSK, x)
+#define ADRF6780_TOO_MANY_ERRORS_MSK		BIT(13)
+#define ADRF6780_TOO_MANY_ERRORS(x)		FIELD_PREP(ADRF6780_TOO_MANY_ERRORS_MSK, x)
+#define ADRF6780_ADDRESS_RANGE_ERROR_MSK	BIT(12)
+#define ADRF6780_ADDRESS_RANGE_ERROR(x)		FIELD_PREP(ADRF6780_ADDRESS_RANGE_ERROR_MSK, x)
+
+/* ADRF6780_REG_ENABLE Map */
+#define ADRF6780_VGA_BUFFER_EN_MSK		BIT(8)
+#define ADRF6780_VGA_BUFFER_EN(x)		FIELD_PREP(ADRF6780_VGA_BUFFER_EN_MSK, x)
+#define ADRF6780_DETECTOR_EN_MSK		BIT(7)
+#define ADRF6780_DETECTOR_EN(x)			FIELD_PREP(ADRF6780_DETECTOR_EN_MSK, x)
+#define ADRF6780_LO_BUFFER_EN_MSK		BIT(6)
+#define ADRF6780_LO_BUFFER_EN(x)		FIELD_PREP(ADRF6780_LO_BUFFER_EN_MSK, x)
+#define ADRF6780_IF_MODE_EN_MSK			BIT(5)
+#define ADRF6780_IF_MODE_EN(x)			FIELD_PREP(ADRF6780_IF_MODE_EN_MSK, x)
+#define ADRF6780_IQ_MODE_EN_MSK			BIT(4)
+#define ADRF6780_IQ_MODE_EN(x)			FIELD_PREP(ADRF6780_IQ_MODE_EN_MSK, x)
+#define ADRF6780_LO_X2_EN_MSK			BIT(3)
+#define ADRF6780_LO_X2_EN(x)			FIELD_PREP(ADRF6780_LO_X2_EN_MSK, x)
+#define ADRF6780_LO_PPF_EN_MSK			BIT(2)
+#define ADRF6780_LO_PPF_EN(x)			FIELD_PREP(ADRF6780_LO_PPF_EN_MSK, x)
+#define ADRF6780_LO_EN_MSK			BIT(1)
+#define ADRF6780_LO_EN(x)			FIELD_PREP(ADRF6780_LO_EN_MSK, x)
+#define ADRF6780_UC_BIAS_EN_MSK			BIT(0)
+#define ADRF6780_UC_BIAS_EN(x)			FIELD_PREP(ADRF6780_UC_BIAS_EN_MSK, x)
+
+/* ADRF6780_REG_LINEARIZE Map */
+#define ADRF6780_RDAC_LINEARIZE_MSK		GENMASK(7, 0)
+#define ADRF6780_RDAC_LINEARIZE(x)		FIELD_PREP(ADRF6780_RDAC_LINEARIZE_MSK, x)
+
+/* ADRF6780_REG_LO_PATH Map */
+#define ADRF6780_LO_SIDEBAND_MSK		BIT(10)
+#define ADRF6780_LO_SIDEBAND(x)			FIELD_PREP(ADRF6780_LO_SIDEBAND_MSK, x)
+#define ADRF6780_Q_PATH_PHASE_ACCURACY_MSK	GENMASK(7, 4)
+#define ADRF6780_Q_PATH_PHASE_ACCURACY(x)	FIELD_PREP(ADRF6780_Q_PATH_PHASE_ACCURACY_MSK, x)
+#define ADRF6780_I_PATH_PHASE_ACCURACY_MSK	GENMASK(3, 0)
+#define ADRF6780_I_PATH_PHASE_ACCURACY(x)	FIELD_PREP(ADRF6780_I_PATH_PHASE_ACCURACY_MSK, x)
+
+/* ADRF6780_REG_ADC_CONTROL Map */
+#define ADRF6780_VDET_OUTPUT_SELECT_MSK		BIT(3)
+#define ADRF6780_VDET_OUTPUT_SELECT(x)		FIELD_PREP(ADRF6780_VDET_OUTPUT_SELECT_MSK, x)
+#define ADRF6780_ADC_START_MSK			BIT(2)
+#define ADRF6780_ADC_START(x)			FIELD_PREP(ADRF6780_ADC_START_MSK, x)
+#define ADRF6780_ADC_EN_MSK			BIT(1)
+#define ADRF6780_ADC_EN(x)			FIELD_PREP(ADRF6780_ADC_EN_MSK, x)
+#define ADRF6780_ADC_CLOCK_EN_MSK		BIT(0)
+#define ADRF6780_ADC_CLOCK_EN(x)		FIELD_PREP(ADRF6780_ADC_CLOCK_EN_MSK, x)
+
+/* ADRF6780_REG_ADC_OUTPUT Map */
+#define ADRF6780_ADC_STATUS_MSK			BIT(8)
+#define ADRF6780_ADC_STATUS(x)			FIELD_PREP(ADRF6780_ADC_STATUS_MSK, x)
+#define ADRF6780_ADC_VALUE_MSK			GENMASK(7, 0)
+#define ADRF6780_ADC_VALUE(x)			FIELD_PREP(ADRF6780_ADC_VALUE_MSK, x)
+
+struct adrf6780_dev {
+	struct spi_device	*spi;
+	struct clk		*clkin;
+	/* Protect against concurrent accesses to the device */
+	struct mutex		lock;
+	bool			vga_buff_en;
+	bool			lo_buff_en;
+	bool			if_mode_en;
+	bool			iq_mode_en;
+	bool			lo_x2_en;
+	bool			lo_ppf_en;
+	bool			lo_en;
+	bool			uc_bias_en;
+	bool			lo_sideband;
+	bool			vdet_out_en;
+};
+
+static int adrf6780_spi_read(struct adrf6780_dev *dev, unsigned int reg,
+			      unsigned int *val)
+{
+	int ret;
+	unsigned int temp;
+	struct spi_transfer t = {0};
+	u8 data[3];
+
+	data[0] = 0x80 | (reg << 1);
+	data[1] = 0x0;
+	data[2] = 0x0;
+
+	t.rx_buf = &data[0];
+	t.tx_buf = &data[0];
+	t.len = 3;
+
+	ret = spi_sync_transfer(dev->spi, &t, 1);
+	if (ret < 0)
+		return ret;
+
+	temp = ((data[0] | 0x80 | (reg << 1)) << 16) |
+		(data[1] << 8) | data[2];
+
+	*val = (temp >> 1) & 0xFFFF;
+
+	return ret;
+}
+
+static int adrf6780_spi_write(struct adrf6780_dev *dev,
+				      unsigned int reg,
+				      unsigned int val)
+{
+	u8 data[3];
+
+	val = (val << 1);
+
+	data[0] = (reg << 1) | (val >> 16);
+	data[1] = val >> 8;
+	data[2] = val;
+
+	return spi_write(dev->spi, &data[0], 3);
+}
+
+static int __adrf6780_spi_update_bits(struct adrf6780_dev *dev, unsigned int reg,
+			       unsigned int mask, unsigned int val)
+{
+	int ret;
+	unsigned int data, temp;
+
+	ret = adrf6780_spi_read(dev, reg, &data);
+	if (ret < 0)
+		return ret;
+
+	temp = (data & ~mask) | (val & mask);
+
+	return adrf6780_spi_write(dev, reg, temp);
+}
+
+static int adrf6780_spi_update_bits(struct adrf6780_dev *dev, unsigned int reg,
+			       unsigned int mask, unsigned int val)
+{
+	int ret;
+
+	mutex_lock(&dev->lock);
+	ret = __adrf6780_spi_update_bits(dev, reg, mask, val);
+	mutex_unlock(&dev->lock);
+	return ret;
+}
+
+static int adrf6780_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long info)
+{
+	struct adrf6780_dev *dev = iio_priv(indio_dev);
+	unsigned int data;
+	int ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&dev->lock);
+
+		ret = __adrf6780_spi_update_bits(dev, ADRF6780_REG_ADC_CONTROL,
+						ADRF6780_ADC_EN_MSK |
+						ADRF6780_ADC_CLOCK_EN_MSK |
+						ADRF6780_ADC_START_MSK,
+						ADRF6780_ADC_EN(1) |
+						ADRF6780_ADC_CLOCK_EN(1) |
+						ADRF6780_ADC_START(1));
+		if (ret < 0)
+			goto exit;
+
+		usleep_range(200, 250);
+
+		ret = adrf6780_spi_read(dev, ADRF6780_REG_ADC_OUTPUT, &data);
+		if (ret < 0)
+			goto exit;
+
+		if (!(data & ADRF6780_ADC_STATUS_MSK)) {
+			ret = -EINVAL;
+			goto exit;
+		}
+
+		ret = __adrf6780_spi_update_bits(dev, ADRF6780_REG_ADC_CONTROL,
+						ADRF6780_ADC_START_MSK,
+						ADRF6780_ADC_START(0));
+		if (ret < 0)
+			goto exit;
+
+		ret = adrf6780_spi_read(dev, ADRF6780_REG_ADC_OUTPUT, &data);
+		if (ret < 0)
+			goto exit;
+
+		mutex_unlock(&dev->lock);
+
+		*val = data & ADRF6780_ADC_VALUE_MSK;
+
+		return IIO_VAL_INT;
+exit:
+		mutex_unlock(&dev->lock);
+		return ret;
+	case IIO_CHAN_INFO_SCALE:
+		ret = adrf6780_spi_read(dev, ADRF6780_REG_LINEARIZE, &data);
+		if (ret < 0)
+			return ret;
+
+		*val = data & ADRF6780_RDAC_LINEARIZE_MSK;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_PHASE:
+		ret = adrf6780_spi_read(dev, ADRF6780_REG_LO_PATH, &data);
+		if (ret < 0)
+			return ret;
+
+		if (chan->channel2 == IIO_MOD_I)
+			*val = data & ADRF6780_I_PATH_PHASE_ACCURACY_MSK;
+		else
+			*val = (data & ADRF6780_Q_PATH_PHASE_ACCURACY_MSK) >> 4;
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adrf6780_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long info)
+{
+	struct adrf6780_dev *dev = iio_priv(indio_dev);
+	int ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		return adrf6780_spi_write(dev, ADRF6780_REG_LINEARIZE, val);
+	case IIO_CHAN_INFO_PHASE:
+		if (chan->channel2 == IIO_MOD_I)
+			ret = adrf6780_spi_update_bits(dev, ADRF6780_REG_LO_PATH,
+							ADRF6780_I_PATH_PHASE_ACCURACY_MSK,
+							ADRF6780_I_PATH_PHASE_ACCURACY(val));
+		else
+			ret = adrf6780_spi_update_bits(dev, ADRF6780_REG_LO_PATH,
+							ADRF6780_Q_PATH_PHASE_ACCURACY_MSK,
+							ADRF6780_Q_PATH_PHASE_ACCURACY(val));
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adrf6780_reg_access(struct iio_dev *indio_dev,
+				unsigned int reg,
+				unsigned int write_val,
+				unsigned int *read_val)
+{
+	struct adrf6780_dev *dev = iio_priv(indio_dev);
+
+	if (read_val)
+		return adrf6780_spi_read(dev, reg, read_val);
+	else
+		return adrf6780_spi_write(dev, reg, write_val);
+}
+
+static const struct iio_info adrf6780_info = {
+	.read_raw = adrf6780_read_raw,
+	.write_raw = adrf6780_write_raw,
+	.debugfs_reg_access = &adrf6780_reg_access,
+};
+
+#define ADRF6780_CHAN(_channel) {			\
+	.type = IIO_VOLTAGE,				\
+	.output = 1,					\
+	.indexed = 1,					\
+	.channel = _channel,				\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
+		BIT(IIO_CHAN_INFO_SCALE)		\
+}
+
+#define ADRF6780_CHAN_IQ(_channel, rf_comp) {			\
+	.type = IIO_ALTVOLTAGE,					\
+	.modified = 1,						\
+	.output = 1,						\
+	.indexed = 1,						\
+	.channel2 = IIO_MOD_##rf_comp,				\
+	.channel = _channel,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_PHASE)		\
+}
+
+static const struct iio_chan_spec adrf6780_channels[] = {
+	ADRF6780_CHAN(0),
+	ADRF6780_CHAN_IQ(0, I),
+	ADRF6780_CHAN_IQ(0, Q),
+};
+
+static int adrf6780_reset(struct adrf6780_dev *dev)
+{
+	int ret;
+	struct spi_device *spi = dev->spi;
+
+	ret = __adrf6780_spi_update_bits(dev, ADRF6780_REG_CONTROL,
+				 ADRF6780_SOFT_RESET_MSK,
+				 ADRF6780_SOFT_RESET(1));
+	if (ret < 0) {
+		dev_err(&spi->dev, "ADRF6780 SPI software reset failed.\n");
+		return ret;
+	}
+
+	ret = __adrf6780_spi_update_bits(dev, ADRF6780_REG_CONTROL,
+				 ADRF6780_SOFT_RESET_MSK,
+				 ADRF6780_SOFT_RESET(0));
+	if (ret < 0) {
+		dev_err(&spi->dev, "ADRF6780 SPI software reset disable failed.\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+static int adrf6780_init(struct adrf6780_dev *dev)
+{
+	int ret;
+	unsigned int chip_id, enable_reg, enable_reg_msk;
+	struct spi_device *spi = dev->spi;
+
+	/* Perform a software reset */
+	ret = adrf6780_reset(dev);
+	if (ret < 0)
+		return ret;
+
+	ret = adrf6780_spi_read(dev, ADRF6780_REG_CONTROL, &chip_id);
+	if (ret < 0)
+		return ret;
+
+	chip_id = (chip_id & ADRF6780_CHIP_ID_MSK) >> 4;
+	if (chip_id != ADRF6780_CHIP_ID) {
+		dev_err(&spi->dev, "ADRF6780 Invalid Chip ID.\n");
+		return -EINVAL;
+	}
+
+	enable_reg_msk = ADRF6780_VGA_BUFFER_EN_MSK |
+			ADRF6780_DETECTOR_EN_MSK |
+			ADRF6780_LO_BUFFER_EN_MSK |
+			ADRF6780_IF_MODE_EN_MSK |
+			ADRF6780_IQ_MODE_EN_MSK |
+			ADRF6780_LO_X2_EN_MSK |
+			ADRF6780_LO_PPF_EN_MSK |
+			ADRF6780_LO_EN_MSK |
+			ADRF6780_UC_BIAS_EN_MSK;
+
+	enable_reg = ADRF6780_VGA_BUFFER_EN(dev->vga_buff_en) |
+			ADRF6780_DETECTOR_EN(1) |
+			ADRF6780_LO_BUFFER_EN(dev->lo_buff_en) |
+			ADRF6780_IF_MODE_EN(dev->if_mode_en) |
+			ADRF6780_IQ_MODE_EN(dev->iq_mode_en) |
+			ADRF6780_LO_X2_EN(dev->lo_x2_en) |
+			ADRF6780_LO_PPF_EN(dev->lo_ppf_en) |
+			ADRF6780_LO_EN(dev->lo_en) |
+			ADRF6780_UC_BIAS_EN(dev->uc_bias_en);
+
+	ret = __adrf6780_spi_update_bits(dev, ADRF6780_REG_ENABLE, enable_reg_msk, enable_reg);
+	if (ret < 0)
+		return ret;
+
+	ret = __adrf6780_spi_update_bits(dev, ADRF6780_REG_LO_PATH,
+						ADRF6780_LO_SIDEBAND_MSK,
+						ADRF6780_LO_SIDEBAND(dev->lo_sideband));
+	if (ret < 0)
+		return ret;
+
+	return __adrf6780_spi_update_bits(dev, ADRF6780_REG_ADC_CONTROL,
+						ADRF6780_VDET_OUTPUT_SELECT_MSK,
+						ADRF6780_VDET_OUTPUT_SELECT(dev->vdet_out_en));
+}
+
+static void adrf6780_clk_disable(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
+static int adrf6780_dt_parse(struct adrf6780_dev *dev)
+{
+	struct spi_device *spi = dev->spi;
+
+	dev->vga_buff_en = of_property_read_bool(spi->dev.of_node, "adi,vga-buff-en");
+	dev->lo_buff_en = of_property_read_bool(spi->dev.of_node, "adi,lo-buff-en");
+	dev->if_mode_en = of_property_read_bool(spi->dev.of_node, "adi,if-mode-en");
+	dev->iq_mode_en = of_property_read_bool(spi->dev.of_node, "adi,iq-mode-en");
+	dev->lo_x2_en = of_property_read_bool(spi->dev.of_node, "adi,lo-x2-en");
+	dev->lo_ppf_en = of_property_read_bool(spi->dev.of_node, "adi,lo-ppf-en");
+	dev->lo_en = of_property_read_bool(spi->dev.of_node, "adi,lo-en");
+	dev->uc_bias_en = of_property_read_bool(spi->dev.of_node, "adi,uc-bias-en");
+	dev->lo_sideband = of_property_read_bool(spi->dev.of_node, "adi,lo-sideband");
+	dev->vdet_out_en = of_property_read_bool(spi->dev.of_node, "adi,vdet-out-en");
+
+	return 0;
+}
+
+static int adrf6780_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct adrf6780_dev *dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*dev));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	dev = iio_priv(indio_dev);
+
+	indio_dev->info = &adrf6780_info;
+	indio_dev->name = "adrf6780";
+	indio_dev->channels = adrf6780_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adrf6780_channels);
+
+	dev->spi = spi;
+
+	ret = adrf6780_dt_parse(dev);
+	if (ret < 0)
+		return ret;
+
+	dev->clkin = devm_clk_get(&spi->dev, "lo_in");
+	if (IS_ERR(dev->clkin))
+		return PTR_ERR(dev->clkin);
+
+	ret = clk_prepare_enable(dev->clkin);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_add_action_or_reset(&spi->dev, adrf6780_clk_disable, dev->clkin);
+	if (ret < 0)
+		return ret;
+
+	mutex_init(&dev->lock);
+
+	ret = adrf6780_init(dev);
+	if (ret < 0)
+		return ret;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct spi_device_id adrf6780_id[] = {
+	{ "adrf6780", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, adrf6780_id);
+
+static const struct of_device_id adrf6780_of_match[] = {
+	{ .compatible = "adi,adrf6780" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, adrf6780_of_match);
+
+static struct spi_driver adrf6780_driver = {
+	.driver = {
+		.name = "adrf6780",
+		.of_match_table = adrf6780_of_match,
+	},
+	.probe = adrf6780_probe,
+	.id_table = adrf6780_id,
+};
+module_spi_driver(adrf6780_driver);
+
+MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com");
+MODULE_DESCRIPTION("Analog Devices ADRF6780");
+MODULE_LICENSE("GPL v2");
-- 
2.32.0

