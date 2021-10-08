Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862314268BF
	for <lists+linux-iio@lfdr.de>; Fri,  8 Oct 2021 13:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240456AbhJHLan (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Oct 2021 07:30:43 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:6338 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240398AbhJHLal (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Oct 2021 07:30:41 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1981kiKs003169;
        Fri, 8 Oct 2021 07:28:33 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 3bhtt1pmx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 07:28:32 -0400
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 198BSU0i029971
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Oct 2021 07:28:31 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Fri, 8 Oct 2021 04:28:30 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Fri, 8 Oct 2021 04:28:30 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Fri, 8 Oct 2021 04:28:29 -0700
Received: from andrei-VirtualBox.ad.analog.com (ADRIMBAR-L02.ad.analog.com [10.48.65.112])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 198BSMC6022852;
        Fri, 8 Oct 2021 07:28:26 -0400
From:   <andrei.drimbarean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <fazilyildiran@gmail.com>,
        <andrei.drimbarean@analog.com>, <robh+dt@kernel.org>,
        <jic23@kernel.org>, <Michael.Hennerich@analog.com>,
        <lars@metafoo.de>
Subject: [PATCH 2/2] drivers:iio:light: add ADPD188 driver support
Date:   Fri, 8 Oct 2021 14:27:47 +0300
Message-ID: <20211008112747.79969-3-andrei.drimbarean@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008112747.79969-1-andrei.drimbarean@analog.com>
References: <20211008112747.79969-1-andrei.drimbarean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: q8BHPFg1PGnbjztRAojeVHO4kG4E1tHR
X-Proofpoint-GUID: q8BHPFg1PGnbjztRAojeVHO4kG4E1tHR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-08_03,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110080067
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Andrei Drimbarean <andrei.drimbarean@analog.com>

Add IIO driver support for the ADPD188 device.

More information about the device at:
https://www.analog.com/media/en/technical-documentation/data-sheets/adpd188bi.pdf

Signed-off-by: Andrei Drimbarean <andrei.drimbarean@analog.com>
---
 drivers/iio/light/Kconfig       |   30 +
 drivers/iio/light/Makefile      |    3 +
 drivers/iio/light/adpd188.c     | 1389 +++++++++++++++++++++++++++++++
 drivers/iio/light/adpd188.h     |   64 ++
 drivers/iio/light/adpd188_i2c.c |  243 ++++++
 drivers/iio/light/adpd188_spi.c |   97 +++
 6 files changed, 1826 insertions(+)
 create mode 100644 drivers/iio/light/adpd188.c
 create mode 100644 drivers/iio/light/adpd188.h
 create mode 100644 drivers/iio/light/adpd188_i2c.c
 create mode 100644 drivers/iio/light/adpd188_spi.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 33ad4dd0b5c7..dba2c398e3ef 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -597,4 +597,34 @@ config ZOPT2201
 	  To compile this driver as a module, choose M here: the
 	  module will be called zopt2201.
 
+config ADPD188
+	select REGMAP
+	bool
+
+config ADPD188_SPI
+	tristate "Analog Devices ADPD188 Integrated Optical Module for Smoke Detection SPI Driver"
+	depends on SPI
+	select ADPD188
+	select REGMAP_SPI
+	help
+	  Say yes here if you want to build a driver for the Analog Devices
+	  Integrated Optical Module for Smoke Detection.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called adpd188_spi and you will also get adpd188
+	  for the core module.
+
+config ADPD188_I2C
+	tristate "Analog Devices ADPD188 Integrated Optical Module for Smoke Detection I2C Driver"
+	depends on I2C
+	select ADPD188
+	select REGMAP_I2C
+	help
+	  Say yes here if you want to build a driver for the Analog Devices
+	  Integrated Optical Module for Smoke Detection.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called adpd188_i2c and you will also get adpd188
+	  for the core module.
+
 endmenu
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index ea376deaca54..c52d334d0a06 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -57,3 +57,6 @@ obj-$(CONFIG_VEML6030)		+= veml6030.o
 obj-$(CONFIG_VEML6070)		+= veml6070.o
 obj-$(CONFIG_VL6180)		+= vl6180.o
 obj-$(CONFIG_ZOPT2201)		+= zopt2201.o
+obj-$(CONFIG_ADPD188)		+= adpd188.o
+obj-$(CONFIG_ADPD188_I2C)	+= adpd188_i2c.o
+obj-$(CONFIG_ADPD188_SPI)	+= adpd188_spi.o
diff --git a/drivers/iio/light/adpd188.c b/drivers/iio/light/adpd188.c
new file mode 100644
index 000000000000..8988eafeed92
--- /dev/null
+++ b/drivers/iio/light/adpd188.c
@@ -0,0 +1,1389 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ADPD188 driver
+ *
+ * Copyright 2021 Analog Devices Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+#include <linux/string.h>
+#include <linux/timekeeping.h>
+
+#include "adpd188.h"
+
+#define ADPD188_REG_STATUS			0x00
+#define ADPD188_REG_INT_MASK			0x01
+#define ADPD188_REG_FIFO_THRESH			0x06
+#define ADPD188_REG_SW_RESET			0x0F
+#define ADPD188_REG_MODE			0x10
+#define ADPD188_REG_SLOT_EN			0x11
+#define ADPD188_REG_FSAMPLE			0x12
+#define ADPD188_REG_PD_LED_SELECT		0x14
+#define ADPD188_REG_NUM_AVG			0x15
+#define ADPD188_REG_INT_SEQ_A			0x17
+#define ADPD188_REG_SLOTA_CH1_OFFSET		0x18
+#define ADPD188_REG_SLOTA_CH2_OFFSET		0x19
+#define ADPD188_REG_SLOTA_CH3_OFFSET		0x1A
+#define ADPD188_REG_SLOTA_CH4_OFFSET		0x1B
+#define ADPD188_REG_INT_SEQ_B			0x1D
+#define ADPD188_REG_SLOTB_CH1_OFFSET		0x1E
+#define ADPD188_REG_SLOTB_CH2_OFFSET		0x1F
+#define ADPD188_REG_SLOTB_CH3_OFFSET		0x20
+#define ADPD188_REG_SLOTB_CH4_OFFSET		0x21
+
+enum adpd188_iled_coarse_index {
+	LED3,
+	LED1,
+	LED2
+};
+#define ADPD188_REG_ILEDx_COARSE(x)		(0x22 + (x))
+
+enum adpd188_slots {
+	ADPD188_SLOTA,
+	ADPD188_SLOTB
+};
+#define ADPD188_REG_SLOTx_NUMPULSES(x)		(0x31 + (x) * 5)
+#define ADPD188_REG_SLOTx_AFE_WINDOW(x)		(0x39 + (x) * 2)
+
+#define ADPD188_REG_MATH			0x58
+#define ADPD188_REG_AFE_PWR_CFG1		0x3C
+#define ADPD188_REG_SAMPLE_CLK			0x4B
+#define ADPD188_REG_FIFO_DATA			0x60
+#define ADPD188_REG_16BIT_DATA_BASE		0x64
+#define ADPD188_REG_32BIT_DATA_LOW_BASE		0x70
+#define ADPD188_REG_32BIT_DATA_HIGH_BASE	0x74
+#define ADPD188_REG_16BIT_DATA(_slot, _ch)	\
+	(ADPD188_REG_16BIT_DATA_BASE + (_ch) + (_slot) * 4)
+#define ADPD188_REG_32BIT_DATA_LOW(_slot, _ch)	\
+	(ADPD188_REG_32BIT_DATA_LOW_BASE + (_ch) + (_slot) * 8)
+#define ADPD188_REG_32BIT_DATA_HIGH(_slot, _ch)	\
+	(ADPD188_REG_32BIT_DATA_HIGH_BASE + (_ch) + (_slot) * 8)
+
+/** ADPD188_REG_STATUS */
+#define ADPD188_FIFO_CLEAR			BIT(15)
+#define ADPD188_FIFO_SAMPLES			GENMASK(15, 8)
+#define ADPD188_SLOTB_INT			BIT(6)
+#define ADPD188_SLOTA_INT			BIT(5)
+
+/** ADPD188_REG_INT_MASK */
+#define ADPD188_FIFO_INT_MASK			BIT(8)
+#define ADPD188_SLOTB_INT_MASK			BIT(6)
+#define ADPD188_SLOTA_INT_MASK			BIT(5)
+
+/** ADPD188_REG_FIFO_THRESH */
+#define ADPD188_FIFO_THRESH			GENMASK(13, 8)
+
+/** ADPD188_REG_MODE */
+#define ADPD188_MODE_MASK			GENMASK(1, 0)
+
+/** ADPD188_REG_SLOT_EN */
+#define ADPD188_RDOUT_MODE_MASK			BIT(13)
+#define ADPD188_FIFO_OVRN_PREVENT_MASK		BIT(12)
+#define ADPD188_SLOTB_FIFO_MODE_MASK		GENMASK(8, 6)
+#define ADPD188_SLOTB_EN_MASK			BIT(5)
+#define ADPD188_SLOTA_FIFO_MODE_MASK		GENMASK(4, 2)
+#define ADPD188_SLOTA_EN_MASK			BIT(0)
+
+/** ADPD188_REG_SAMPLE_CLK */
+#define ADPD188_CLK32K_BYP			BIT(8)
+#define ADPD188_CLK32K_EN			BIT(7)
+#define ADPD188_CLK32K_ADJUST			GENMASK(5, 0)
+
+/** ADPD188_REG_PD_LED_SELECT */
+#define ADPD188_SLOTB_PD_SEL_MASK		GENMASK(11, 8)
+#define ADPD188_SLOTA_PD_SEL_MASK		GENMASK(7, 4)
+#define ADPD188_SLOTB_LED_SEL_MASK		GENMASK(3, 2)
+#define ADPD188_SLOTA_LED_SEL_MASK		GENMASK(1, 0)
+
+/** ADPD188_REG_NUM_AVG */
+#define ADPD188_SLOTB_NUM_AVG_MASK		GENMASK(10, 8)
+#define ADPD188_SLOTA_NUM_AVG_MASK		GENMASK(6, 4)
+
+/** ADPD188_REG_INT_SEQ_A */
+#define ADPD188_INTEG_ORDER_A_MASK		GENMASK(3, 0)
+
+/* ADPD188_REG_INT_SEQ_B */
+#define ADPD188_INTEG_ORDER_B_MASK		GENMASK(3, 0)
+
+/** ADPD188_REG_ILEDx_COARSE */
+#define ADPD188_ILEDx_SCALE_MASK		BIT(13)
+#define ADPD188_ILEDx_SLEW_MASK			GENMASK(6, 4)
+#define ADPD188_ILEDx_COARSE_MASK		GENMASK(3, 0)
+
+/** ADPD188_REG_SLOTx_NUMPULSES */
+#define ADPD188_SLOTx_PULSES_MASK		GENMASK(15, 8)
+#define ADPD188_SLOTx_PERIOD_MASK		GENMASK(7, 0)
+
+/** ADPD188_REG_SLOTx_AFE_WINDOW */
+#define ADPD188_SLOTx_AFE_WIDTH_MASK		GENMASK(15, 11)
+#define ADPD188_SLOTx_AFE_OFFSET_MASK		GENMASK(10, 0)
+
+/** ADPD188_REG_AFE_PWR_CFG1 */
+#define ADPD188_V_CATHODE_MASK			BIT(9)
+#define ADPD188_AFE_POWERDOWN_MASK		GENMASK(8, 3)
+
+/** ADPD188_REG_MATH */
+#define ADPD188_FLT_MATH34_B_MASK		GENMASK(11, 10)
+#define ADPD188_FLT_MATH34_A_MASK		GENMASK(9, 8)
+#define ADPD188_ENA_INT_AS_BUF_MASK		BIT(7)
+#define ADPD188_FLT_MATH12_B_MASK		GENMASK(6, 5)
+#define ADPD188_FLT_MATH12_A_MASK		GENMASK(2, 1)
+
+#define ADPD188_DEVID		0x16
+#define ADPD188_MAX_FSAMPLE	2000
+
+#define DEFAULT_SAMPLE_FREQUENCY	16
+
+enum adpd188_modes {
+	STANDBY,
+	PROGRAM,
+	NORMAL
+};
+
+enum adpd188_slot_fifo_mode {
+	ADPD188_NO_FIFO,
+	ADPD188_16BIT_SUM,
+	ADPD188_32BIT_SUM,
+	ADPD188_16BIT_4CHAN = 0x4,
+	ADPD188_32BIT_4CHAN = 0x6
+};
+
+struct adpd188_slot_config {
+	enum adpd188_slots slot_id;
+	bool slot_en;
+	enum adpd188_slot_fifo_mode slot_fifo_mode;
+};
+
+static int adpd188_reg_access(struct iio_dev *indio_dev,
+			      unsigned int reg,
+			      unsigned int tx_val,
+			      unsigned int *rx_val)
+{
+	struct adpd188 *dev = iio_priv(indio_dev);
+	struct adpd188_ops *ops = dev->ops;
+	struct i2c_client *i2c = dev->bus;
+	int dev_id = (reg & 0xF00) >> 8;
+	int ret;
+
+	if ((dev->phy_opt != ADPD188_I2C) || (dev_id == 0)) {
+		if (rx_val)
+			ret = ops->reg_read(dev->bus, reg, rx_val);
+		else
+			ret = ops->reg_write(dev->bus, reg, tx_val);
+	} else {
+		if (rx_val)
+			ret = ops->i2c_sub_read(dev->bus,
+						 (i2c->addr + dev_id),
+						 reg, rx_val);
+		else
+			ret = ops->i2c_sub_write(dev->bus,
+						  (i2c->addr + dev_id),
+						  reg, tx_val);
+	}
+
+	return (ret < 0) ? ret : 0;
+}
+
+static int adpd188_i2c_reg_write_mask(struct adpd188 *dev_data,
+				      int dev_id, int addr,
+				      int value, int mask)
+{
+	int temp_val;
+	int ret;
+	struct adpd188_ops *ops = dev_data->ops;
+
+	ret = ops->i2c_sub_read(dev_data->bus, dev_id, addr, &temp_val);
+	if (ret < 0)
+		return ret;
+	temp_val &= ~mask;
+	temp_val |= (value << (ffs(mask) - 1)) & mask;
+
+	return ops->i2c_sub_write(dev_data->bus, dev_id, addr, temp_val);
+}
+
+static int adpd188_spi_reg_write_mask(struct adpd188 *dev_data, int addr,
+				  int value, int mask)
+{
+	int temp_val;
+	int ret;
+	struct adpd188_ops *ops = dev_data->ops;
+
+	ret = ops->reg_read(dev_data->bus, addr, &temp_val);
+	if (ret < 0)
+		return ret;
+	temp_val &= ~mask;
+	temp_val |= (value << (ffs(mask) - 1)) & mask;
+
+	return ops->reg_write(dev_data->bus, addr, temp_val);
+}
+
+static int adpd188_reg_write_mask(struct adpd188 *dev_data, int addr,
+				  int value, int mask)
+{
+	struct i2c_client *i2c = dev_data->bus;
+
+	if (dev_data->phy_opt == ADPD188_SPI)
+		return adpd188_spi_reg_write_mask(dev_data, addr, value, mask);
+	else
+		return adpd188_i2c_reg_write_mask(dev_data, i2c->addr,
+						  addr, value, mask);
+}
+
+static int adpd188_set_device_mode(struct adpd188 *dev_data, int new_mode)
+{
+	int regval, ret;
+	struct adpd188_ops *ops = dev_data->ops;
+
+	regval = new_mode & ADPD188_MODE_MASK;
+
+	ret = ops->reg_write(dev_data->bus, ADPD188_REG_MODE, regval);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int adpd188_sub_set_device_mode(struct adpd188 *dev_data, int new_mode,
+				       int dev_id)
+{
+	int regval, ret;
+	struct adpd188_ops *ops = dev_data->ops;
+	struct i2c_client *i2c = dev_data->bus;
+
+	regval = new_mode & ADPD188_MODE_MASK;
+
+	ret = ops->i2c_sub_write(dev_data->bus, (i2c->addr + dev_id),
+				  ADPD188_REG_MODE, regval);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int adpd188_all_set_device_mode(struct adpd188 *dev_data, int new_mode)
+{
+	int regval, ret, i;
+	struct adpd188_ops *ops = dev_data->ops;
+	struct i2c_client *i2c = dev_data->bus;
+
+	regval = new_mode & ADPD188_MODE_MASK;
+
+	ret = ops->reg_write(dev_data->bus, ADPD188_REG_MODE, regval);
+	if (ret < 0)
+		return ret;
+
+	for (i = 1; i < dev_data->no_devices; i++) {
+		ret = ops->i2c_sub_write(dev_data->bus, (i2c->addr + i),
+					  ADPD188_REG_MODE, regval);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int adpd188_clear_fifos(struct adpd188 *dev_data)
+{
+	int ret, i;
+	struct i2c_client *i2c = dev_data->bus;
+
+	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_STATUS,
+				  1, ADPD188_FIFO_CLEAR);
+	if (ret < 0)
+		return ret;
+	for (i = 1; i < dev_data->no_devices; i++) {
+		ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + i,
+						 ADPD188_REG_STATUS,
+						 1, ADPD188_FIFO_CLEAR);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int adpd188_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct adpd188 *data = iio_priv(indio_dev);
+	struct adpd188_ops *ops = data->ops;
+	int ret, i;
+	int regval, regaddr;
+	int data_buf[4];
+	struct i2c_client *i2c = data->bus;
+	unsigned long j0, j1, delay;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = ops->reg_read(data->bus, ADPD188_REG_FSAMPLE, &regval);
+		if (ret < 0)
+			return ret;
+
+		*val = 32000000 / (regval * 4);
+		*val2 = 1000;
+
+		return IIO_VAL_FRACTIONAL;
+	case IIO_CHAN_INFO_OFFSET:
+		if ((chan->scan_index % 2) == 0)
+			regaddr = ADPD188_REG_SLOTA_CH1_OFFSET;
+		else
+			regaddr = ADPD188_REG_SLOTB_CH1_OFFSET;
+
+		if (data->phy_opt == ADPD188_I2C)
+			ret = ops->i2c_sub_read(data->bus,
+						(i2c->addr + (chan->channel / 2)),
+						regaddr, &regval);
+		else
+			ret = ops->reg_read(data->bus, regaddr, &regval);
+		if (ret < 0)
+			return ret;
+		*val = regval;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_RAW:
+		ret = adpd188_all_set_device_mode(data, PROGRAM);
+		if (ret < 0)
+			return ret;
+
+		ret = adpd188_all_set_device_mode(data, NORMAL);
+		if (ret < 0)
+			return ret;
+
+		delay = msecs_to_jiffies(1000); /* 1 sec delay */
+		j0 = jiffies;
+		j1 = j0 + delay;
+		while (time_before(jiffies, j1)) {
+			if (data->phy_opt == ADPD188_I2C)
+				ret = ops->i2c_sub_read(data->bus,
+							(i2c->addr + chan->scan_index / 2),
+							ADPD188_REG_STATUS, &regval);
+			else
+				ret = ops->reg_read(data->bus, ADPD188_REG_STATUS, &regval);
+			if (ret < 0)
+				return ret;
+			regval &= ADPD188_FIFO_SAMPLES;
+			regval >>= ffs(ADPD188_FIFO_SAMPLES) - 1;
+			if (regval >= (4 * 2))
+				break;
+		}
+		if (time_after(jiffies, j1))
+			return -ETIME;
+
+		for (i = 0; i < 4; i++) {
+			if (data->phy_opt == ADPD188_I2C)
+				ret = ops->i2c_sub_read(data->bus,
+							(i2c->addr + chan->scan_index / 2),
+							ADPD188_REG_FIFO_DATA,
+							data_buf + i);
+			else
+				ret = ops->reg_read(data->bus, ADPD188_REG_FIFO_DATA, data_buf + i);
+			if (ret < 0)
+				return ret;
+		}
+
+		if ((chan->scan_index % 2) == 0)
+			*val = data_buf[0] | (data_buf[1] << 16);
+		else
+			*val = data_buf[2] | (data_buf[3] << 16);
+
+		ret = adpd188_all_set_device_mode(data, PROGRAM);
+		if (ret < 0)
+			return ret;
+
+		ret = adpd188_clear_fifos(data);
+		if (ret < 0)
+			return ret;
+
+		ret = adpd188_all_set_device_mode(data, STANDBY);
+		if (ret < 0)
+			return ret;
+
+		return IIO_VAL_INT;
+	}
+
+	return -EINVAL;
+}
+
+static int adpd188_set_sample_freq(struct adpd188 *dev_data, int new_freq_int, int new_freq_frac)
+{
+	int regval;
+	struct adpd188_ops *ops = dev_data->ops;
+	int new_freq = new_freq_int * 1000 + new_freq_frac / 1000;
+
+	regval = 32000000 / (new_freq * 4);
+
+	return ops->reg_write(dev_data->bus, ADPD188_REG_FSAMPLE, regval);
+}
+
+static int adpd188_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct adpd188 *data = iio_priv(indio_dev);
+	struct adpd188_ops *ops = data->ops;
+	int regaddr;
+	int ret, ret2;
+	struct i2c_client *i2c = data->bus;
+
+	ret = adpd188_all_set_device_mode(data, PROGRAM);
+	if (ret < 0)
+		return ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if ((val > ADPD188_MAX_FSAMPLE) || (val < 0)) {
+			ret = -EINVAL;
+			break;
+		}
+
+		ret = adpd188_set_sample_freq(data, val, val2);
+		break;
+	case IIO_CHAN_INFO_OFFSET:
+		if ((chan->scan_index % 2) == 0)
+			regaddr = ADPD188_REG_SLOTA_CH1_OFFSET;
+		else
+			regaddr = ADPD188_REG_SLOTB_CH1_OFFSET;
+
+		if (data->phy_opt == ADPD188_I2C)
+			ret = ops->i2c_sub_write(data->bus,
+						 (i2c->addr + chan->channel / 2),
+						 regaddr, val);
+		else
+			ret = ops->reg_write(data->bus, regaddr, val);
+		break;
+	}
+
+	ret2 = adpd188_all_set_device_mode(data, STANDBY);
+	if (ret2 < 0)
+		return ret2;
+
+	return (ret < 0) ? ret : 0;
+}
+
+static int adpd188_mode_get(struct iio_dev *indio_dev,
+			const struct iio_chan_spec *chan)
+{
+	struct adpd188 *data = iio_priv(indio_dev);
+	struct adpd188_ops *ops = data->ops;
+	int regval;
+	int ret;
+
+	ret = ops->reg_read(data->bus, ADPD188_REG_MODE, &regval);
+	if (ret < 0)
+		return ret;
+
+	return regval & ADPD188_MODE_MASK;
+}
+
+static int adpd188_mode_set(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
+			unsigned int mode)
+{
+	struct adpd188 *data = iio_priv(indio_dev);
+
+	return adpd188_all_set_device_mode(data, mode);
+}
+
+static const char * const adpd188_modes_ascii[] = {"STANDBY", "PROGRAM", "NORMAL"};
+
+static const struct iio_enum adpd188_mode_iio_enum = {
+	.items = adpd188_modes_ascii,
+	.num_items = ARRAY_SIZE(adpd188_modes_ascii),
+	.get = adpd188_mode_get,
+	.set = adpd188_mode_set,
+
+};
+
+static struct iio_chan_spec_ext_info adpd188_ext_info[] = {
+	IIO_ENUM_AVAILABLE("mode", &adpd188_mode_iio_enum),
+	IIO_ENUM("mode", IIO_SHARED_BY_ALL, &adpd188_mode_iio_enum)
+};
+
+#define ADPD188_32BIT_CHANNEL(index, scan, color) {					\
+	.type = IIO_LIGHT,								\
+	.modified = 1,									\
+	.channel2 = IIO_MOD_LIGHT_##color,						\
+	.indexed = 1,									\
+	.channel = index,								\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_OFFSET),	\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+	.ext_info = adpd188_ext_info,							\
+	.scan_index = scan,								\
+	.scan_type = {									\
+		.sign = 'u',								\
+		.realbits = 32,								\
+		.storagebits = 32,							\
+		.endianness = IIO_LE,							\
+	},										\
+}
+
+static const struct iio_chan_spec adpd188_channels[] = {
+	IIO_CHAN_SOFT_TIMESTAMP(16),
+	ADPD188_32BIT_CHANNEL(0, 0, BLUE),
+	ADPD188_32BIT_CHANNEL(0, 1, IR),
+	ADPD188_32BIT_CHANNEL(1, 2, BLUE),
+	ADPD188_32BIT_CHANNEL(1, 3, IR),
+	ADPD188_32BIT_CHANNEL(2, 4, BLUE),
+	ADPD188_32BIT_CHANNEL(2, 5, IR),
+	ADPD188_32BIT_CHANNEL(3, 6, BLUE),
+	ADPD188_32BIT_CHANNEL(3, 7, IR),
+	ADPD188_32BIT_CHANNEL(4, 8, BLUE),
+	ADPD188_32BIT_CHANNEL(4, 9, IR),
+	ADPD188_32BIT_CHANNEL(5, 10, BLUE),
+	ADPD188_32BIT_CHANNEL(5, 11, IR),
+	ADPD188_32BIT_CHANNEL(6, 12, BLUE),
+	ADPD188_32BIT_CHANNEL(6, 13, IR),
+	ADPD188_32BIT_CHANNEL(7, 14, BLUE),
+	ADPD188_32BIT_CHANNEL(7, 15, IR)
+};
+
+static const struct iio_info adpd188_info = {
+	.read_raw       = adpd188_read_raw,
+	.write_raw      = adpd188_write_raw,
+	.debugfs_reg_access = &adpd188_reg_access,
+};
+
+static int adpd188_slot_setup(struct adpd188 *dev_data, struct adpd188_slot_config config)
+{
+	int ret;
+
+	if (config.slot_id == ADPD188_SLOTA) {
+		ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_SLOT_EN,
+					     config.slot_en,
+					     ADPD188_SLOTA_EN_MASK);
+		if (ret < 0)
+			return ret;
+		ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_SLOT_EN,
+					     config.slot_fifo_mode,
+					     ADPD188_SLOTA_FIFO_MODE_MASK);
+	} else if (config.slot_id == ADPD188_SLOTB) {
+		ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_SLOT_EN,
+					     config.slot_en,
+					     ADPD188_SLOTB_EN_MASK);
+		if (ret < 0)
+			return ret;
+		ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_SLOT_EN,
+					     config.slot_fifo_mode,
+					     ADPD188_SLOTB_FIFO_MODE_MASK);
+	}
+
+	return ret;
+}
+
+static int adpd188_sub_slot_setup(struct adpd188 *dev_data, struct adpd188_slot_config config,
+				  int dev_id)
+{
+	int ret = 0;
+	struct i2c_client *i2c = dev_data->bus;
+
+	if (config.slot_id == ADPD188_SLOTA) {
+		ret = adpd188_i2c_reg_write_mask(dev_data, (i2c->addr + dev_id),
+						ADPD188_REG_SLOT_EN,
+					     config.slot_en,
+					     ADPD188_SLOTA_EN_MASK);
+		if (ret < 0)
+			return ret;
+		ret = adpd188_i2c_reg_write_mask(dev_data, (i2c->addr + dev_id),
+						ADPD188_REG_SLOT_EN,
+					     config.slot_fifo_mode,
+					     ADPD188_SLOTA_FIFO_MODE_MASK);
+	} else if (config.slot_id == ADPD188_SLOTB) {
+		ret = adpd188_i2c_reg_write_mask(dev_data, (i2c->addr + dev_id),
+						ADPD188_REG_SLOT_EN,
+					     config.slot_en,
+					     ADPD188_SLOTB_EN_MASK);
+		if (ret < 0)
+			return ret;
+		ret = adpd188_i2c_reg_write_mask(dev_data, (i2c->addr + dev_id),
+						ADPD188_REG_SLOT_EN,
+					     config.slot_fifo_mode,
+					     ADPD188_SLOTB_FIFO_MODE_MASK);
+	}
+
+	return ret;
+}
+
+static int adpd188_core_smoke_setup(struct adpd188 *dev_data)
+{
+	int ret;
+	struct adpd188_slot_config ts_config;
+	struct adpd188_ops *ops = dev_data->ops;
+
+	ret = adpd188_set_device_mode(dev_data, PROGRAM);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_SLOT_EN, 1,
+				     ADPD188_RDOUT_MODE_MASK);
+	if (ret < 0)
+		return ret;
+	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_SLOT_EN, 1,
+				     ADPD188_FIFO_OVRN_PREVENT_MASK);
+	if (ret < 0)
+		return ret;
+
+	ts_config.slot_id = ADPD188_SLOTA;
+	ts_config.slot_en = true;
+	ts_config.slot_fifo_mode = ADPD188_32BIT_SUM;
+	ret = adpd188_slot_setup(dev_data, ts_config);
+	if (ret < 0)
+		return ret;
+
+	ts_config.slot_id = ADPD188_SLOTB;
+	ret = adpd188_slot_setup(dev_data, ts_config);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_set_sample_freq(dev_data, DEFAULT_SAMPLE_FREQUENCY, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_PD_LED_SELECT,
+				     1, ADPD188_SLOTA_LED_SEL_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_PD_LED_SELECT,
+				     3, ADPD188_SLOTB_LED_SEL_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_PD_LED_SELECT,
+				     1, ADPD188_SLOTA_PD_SEL_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_PD_LED_SELECT,
+				     1, ADPD188_SLOTB_PD_SEL_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->reg_write(dev_data->bus, ADPD188_REG_NUM_AVG, 0);
+	if (ret < 0)
+		return ret;
+
+	/* Slot A chan chop mode and chan offset */
+	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_INT_SEQ_A,
+				     9, ADPD188_INTEG_ORDER_A_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->reg_write(dev_data->bus,
+			ADPD188_REG_SLOTA_CH1_OFFSET, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->reg_write(dev_data->bus,
+			ADPD188_REG_SLOTA_CH2_OFFSET, 0x3FFF);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->reg_write(dev_data->bus,
+			ADPD188_REG_SLOTA_CH3_OFFSET, 0x3FFF);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->reg_write(dev_data->bus,
+			ADPD188_REG_SLOTA_CH4_OFFSET, 0x3FFF);
+	if (ret < 0)
+		return ret;
+
+	/* Slot B chan chop mode and chan offset */
+	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_INT_SEQ_B,
+				     9, ADPD188_INTEG_ORDER_B_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->reg_write(dev_data->bus,
+			ADPD188_REG_SLOTB_CH1_OFFSET, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->reg_write(dev_data->bus,
+			ADPD188_REG_SLOTB_CH2_OFFSET, 0x3FFF);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->reg_write(dev_data->bus,
+			ADPD188_REG_SLOTB_CH3_OFFSET, 0x3FFF);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->reg_write(dev_data->bus,
+			ADPD188_REG_SLOTB_CH4_OFFSET, 0x3FFF);
+	if (ret < 0)
+		return ret;
+
+	/** Set IR LED 3 power */
+	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_ILEDx_COARSE(LED3),
+				     9, ADPD188_ILEDx_COARSE_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_ILEDx_COARSE(LED3),
+				     3, ADPD188_ILEDx_SLEW_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_ILEDx_COARSE(LED3),
+				     1, ADPD188_ILEDx_SCALE_MASK);
+	if (ret < 0)
+		return ret;
+
+	/** Set blue LED 1 power */
+	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_ILEDx_COARSE(LED1),
+				     6, ADPD188_ILEDx_COARSE_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_ILEDx_COARSE(LED1),
+				     3, ADPD188_ILEDx_SLEW_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_ILEDx_COARSE(LED1),
+				     1, ADPD188_ILEDx_SCALE_MASK);
+	if (ret < 0)
+		return ret;
+
+	/* Slot A 4 LED pulses with 15us period */
+	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_SLOTx_NUMPULSES(ADPD188_SLOTA),
+				     4, ADPD188_SLOTx_PULSES_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_SLOTx_NUMPULSES(ADPD188_SLOTA),
+				     0xE, ADPD188_SLOTx_PERIOD_MASK);
+	if (ret < 0)
+		return ret;
+
+	/* Slot B 4 LED pulses with 15us period */
+	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_SLOTx_NUMPULSES(ADPD188_SLOTB),
+				     4, ADPD188_SLOTx_PULSES_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_SLOTx_NUMPULSES(ADPD188_SLOTB),
+				     0xE, ADPD188_SLOTx_PERIOD_MASK);
+	if (ret < 0)
+		return ret;
+
+	/* Slot A integrator window */
+	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_SLOTx_AFE_WINDOW(ADPD188_SLOTA),
+				     4, ADPD188_SLOTx_AFE_WIDTH_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_SLOTx_AFE_WINDOW(ADPD188_SLOTA),
+				     0x2F0, ADPD188_SLOTx_AFE_OFFSET_MASK);
+	if (ret < 0)
+		return ret;
+
+	/* Slot B integrator window */
+	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_SLOTx_AFE_WINDOW(ADPD188_SLOTB),
+				     4, ADPD188_SLOTx_AFE_WIDTH_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_SLOTx_AFE_WINDOW(ADPD188_SLOTB),
+				     0x2F0, ADPD188_SLOTx_AFE_OFFSET_MASK);
+	if (ret < 0)
+		return ret;
+
+	/* Power down channels 2, 3 and 4 */
+	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_AFE_PWR_CFG1,
+				     0x38, ADPD188_AFE_POWERDOWN_MASK);
+	if (ret < 0)
+		return ret;
+
+	/* Math for chop mode is inverted, non-inverted, non-inverted, inverted */
+	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_MATH,
+				     1, ADPD188_FLT_MATH34_B_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_MATH,
+				     1, ADPD188_FLT_MATH34_A_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_MATH,
+				     2, ADPD188_FLT_MATH12_B_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_MATH,
+				     2, ADPD188_FLT_MATH12_A_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_FIFO_THRESH,
+					SAMPLE_WORDS, ADPD188_FIFO_THRESH);
+	if (ret < 0)
+		return ret;
+
+	return adpd188_set_device_mode(dev_data, STANDBY);
+}
+
+static int adpd188_sub_core_smoke_setup(struct adpd188 *dev_data, int dev_id)
+{
+	int ret;
+	struct adpd188_slot_config ts_config;
+	struct adpd188_ops *ops = dev_data->ops;
+	struct i2c_client *i2c = dev_data->bus;
+
+	ret = adpd188_sub_set_device_mode(dev_data, PROGRAM, dev_id);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
+				     ADPD188_REG_SLOT_EN, 1,
+				     ADPD188_RDOUT_MODE_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
+					 ADPD188_REG_SLOT_EN, 1,
+				     ADPD188_FIFO_OVRN_PREVENT_MASK);
+	if (ret < 0)
+		return ret;
+
+	ts_config.slot_id = ADPD188_SLOTA;
+	ts_config.slot_en = true;
+	ts_config.slot_fifo_mode = ADPD188_32BIT_SUM;
+	ret = adpd188_sub_slot_setup(dev_data, ts_config, dev_id);
+	if (ret < 0)
+		return ret;
+
+	ts_config.slot_id = ADPD188_SLOTB;
+	ret = adpd188_sub_slot_setup(dev_data, ts_config, dev_id);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->i2c_sub_write(dev_data->bus, i2c->addr + dev_id, 0x4F, 0x20B8);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
+					ADPD188_REG_PD_LED_SELECT,
+				     1, ADPD188_SLOTA_LED_SEL_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
+					ADPD188_REG_PD_LED_SELECT,
+				     3, ADPD188_SLOTB_LED_SEL_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
+					ADPD188_REG_PD_LED_SELECT,
+				     1, ADPD188_SLOTA_PD_SEL_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
+					ADPD188_REG_PD_LED_SELECT,
+				     1, ADPD188_SLOTB_PD_SEL_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->i2c_sub_write(dev_data->bus, i2c->addr + dev_id, ADPD188_REG_NUM_AVG, 0);
+	if (ret < 0)
+		return ret;
+
+	/* Slot A chan chop mode and chan offset */
+	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
+					ADPD188_REG_INT_SEQ_A,
+				     9, ADPD188_INTEG_ORDER_A_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->i2c_sub_write(dev_data->bus, i2c->addr + dev_id,
+			ADPD188_REG_SLOTA_CH1_OFFSET, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->i2c_sub_write(dev_data->bus, i2c->addr + dev_id,
+			ADPD188_REG_SLOTA_CH2_OFFSET, 0x3FFF);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->i2c_sub_write(dev_data->bus, i2c->addr + dev_id,
+			ADPD188_REG_SLOTA_CH3_OFFSET, 0x3FFF);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->i2c_sub_write(dev_data->bus, i2c->addr + dev_id,
+			ADPD188_REG_SLOTA_CH4_OFFSET, 0x3FFF);
+	if (ret < 0)
+		return ret;
+
+	/* Slot B chan chop mode and chan offset */
+	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
+					ADPD188_REG_INT_SEQ_B,
+				     9, ADPD188_INTEG_ORDER_B_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->i2c_sub_write(dev_data->bus, i2c->addr + dev_id,
+			ADPD188_REG_SLOTB_CH1_OFFSET, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->i2c_sub_write(dev_data->bus, i2c->addr + dev_id,
+			ADPD188_REG_SLOTB_CH2_OFFSET, 0x3FFF);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->i2c_sub_write(dev_data->bus, i2c->addr + dev_id,
+			ADPD188_REG_SLOTB_CH3_OFFSET, 0x3FFF);
+	if (ret < 0)
+		return ret;
+
+	ret = ops->i2c_sub_write(dev_data->bus, i2c->addr + dev_id,
+			ADPD188_REG_SLOTB_CH4_OFFSET, 0x3FFF);
+	if (ret < 0)
+		return ret;
+
+	/** Set IR LED 3 power */
+	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
+					ADPD188_REG_ILEDx_COARSE(LED3),
+				     9, ADPD188_ILEDx_COARSE_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
+					ADPD188_REG_ILEDx_COARSE(LED3),
+				     3, ADPD188_ILEDx_SLEW_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
+					ADPD188_REG_ILEDx_COARSE(LED3),
+				     1, ADPD188_ILEDx_SCALE_MASK);
+	if (ret < 0)
+		return ret;
+
+	/** Set blue LED 1 power */
+	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
+					ADPD188_REG_ILEDx_COARSE(LED1),
+				     6, ADPD188_ILEDx_COARSE_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
+					ADPD188_REG_ILEDx_COARSE(LED1),
+				     3, ADPD188_ILEDx_SLEW_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
+					ADPD188_REG_ILEDx_COARSE(LED1),
+				     1, ADPD188_ILEDx_SCALE_MASK);
+	if (ret < 0)
+		return ret;
+
+	/* Slot A 4 LED pulses with 15us period */
+	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
+					ADPD188_REG_SLOTx_NUMPULSES(ADPD188_SLOTA),
+				     4, ADPD188_SLOTx_PULSES_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
+					ADPD188_REG_SLOTx_NUMPULSES(ADPD188_SLOTA),
+				     0xE, ADPD188_SLOTx_PERIOD_MASK);
+	if (ret < 0)
+		return ret;
+
+	/* Slot B 4 LED pulses with 15us period */
+	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
+					ADPD188_REG_SLOTx_NUMPULSES(ADPD188_SLOTB),
+				     4, ADPD188_SLOTx_PULSES_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
+					ADPD188_REG_SLOTx_NUMPULSES(ADPD188_SLOTB),
+				     0xE, ADPD188_SLOTx_PERIOD_MASK);
+	if (ret < 0)
+		return ret;
+
+	/* Slot A integrator window */
+	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
+					ADPD188_REG_SLOTx_AFE_WINDOW(ADPD188_SLOTA),
+				     4, ADPD188_SLOTx_AFE_WIDTH_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
+					ADPD188_REG_SLOTx_AFE_WINDOW(ADPD188_SLOTA),
+				     0x2F0, ADPD188_SLOTx_AFE_OFFSET_MASK);
+	if (ret < 0)
+		return ret;
+
+	/* Slot B integrator window */
+	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
+					ADPD188_REG_SLOTx_AFE_WINDOW(ADPD188_SLOTB),
+				     4, ADPD188_SLOTx_AFE_WIDTH_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
+					ADPD188_REG_SLOTx_AFE_WINDOW(ADPD188_SLOTB),
+				     0x2F0, ADPD188_SLOTx_AFE_OFFSET_MASK);
+	if (ret < 0)
+		return ret;
+
+	/* Power down channels 2, 3 and 4 */
+	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
+					ADPD188_REG_AFE_PWR_CFG1,
+				     0x38, ADPD188_AFE_POWERDOWN_MASK);
+	if (ret < 0)
+		return ret;
+
+	/* Math for chop mode is inverted, non-inverted, non-inverted, inverted */
+	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
+					ADPD188_REG_MATH,
+				     1, ADPD188_FLT_MATH34_B_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
+					ADPD188_REG_MATH,
+				     1, ADPD188_FLT_MATH34_A_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
+					ADPD188_REG_MATH,
+				     2, ADPD188_FLT_MATH12_B_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_i2c_reg_write_mask(dev_data, i2c->addr + dev_id,
+					ADPD188_REG_MATH,
+				     2, ADPD188_FLT_MATH12_A_MASK);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_FIFO_THRESH,
+					SAMPLE_WORDS, ADPD188_FIFO_THRESH);
+	if (ret < 0)
+		return ret;
+
+
+	return adpd188_sub_set_device_mode(dev_data, STANDBY, dev_id);
+}
+
+static int adpd188_data_rdy_trigger_set_state(struct iio_trigger *trig,
+					      bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct adpd188 *data = iio_priv(indio_dev);
+	struct i2c_client *i2c = data->bus;
+	int reg, ret;
+
+	ret = adpd188_all_set_device_mode(data, PROGRAM);
+	if (ret < 0)
+		return ret;
+
+	reg = !state;
+
+	if (data->phy_opt == ADPD188_SPI)
+		ret = adpd188_spi_reg_write_mask(data, ADPD188_REG_INT_MASK,
+					  reg, ADPD188_FIFO_INT_MASK);
+	else
+		ret = adpd188_i2c_reg_write_mask(data, (i2c->addr + (data->no_devices - 1)),
+						 ADPD188_REG_INT_MASK,
+						 reg, ADPD188_FIFO_INT_MASK);
+	if (ret < 0)
+		return ret;
+
+	reg = state ? NORMAL : STANDBY;
+
+	ret = adpd188_all_set_device_mode(data, reg);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static const struct iio_trigger_ops adpd188_trigger_ops = {
+	.set_trigger_state = adpd188_data_rdy_trigger_set_state,
+	.validate_device = iio_trigger_validate_own_device,
+};
+
+static irqreturn_t adpd188_interrupt(int irq, void *dev_id)
+{
+	struct iio_dev *indio_dev = dev_id;
+
+	iio_trigger_poll(indio_dev->trig);
+
+	return IRQ_WAKE_THREAD;
+};
+
+static irqreturn_t adpd188_oneshot_apply(int irq, void *dev_id)
+{
+	int ret;
+	struct iio_dev *indio_dev = dev_id;
+	struct adpd188 *dev_data = iio_priv(indio_dev);
+
+	ret = wait_for_completion_interruptible_timeout(&dev_data->value_ok,
+			msecs_to_jiffies(5000));
+	if (ret == 0) {
+		pr_err("adpd188: Data handle timeout.\n");
+		ret = IRQ_NONE;
+	} else {
+		ret = IRQ_HANDLED;
+	}
+	reinit_completion(&dev_data->value_ok);
+
+	return ret;
+}
+
+static irqreturn_t adpd188_trigger_handler(int irq, void  *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct adpd188 *dev_data = iio_priv(indio_dev);
+	int i, j, no_dev = dev_data->no_devices, ret;
+	struct adpd188_ops *ops = dev_data->ops;
+	struct i2c_client *i2c = dev_data->bus;
+
+	for (i = 0; i < no_dev; i++) {
+		for (j = 0; j < 4; j++) {
+			if (dev_data->phy_opt == ADPD188_I2C)
+				ret = ops->i2c_sub_read(i2c, (i2c->addr + i),
+							ADPD188_REG_FIFO_DATA,
+							(int *)&dev_data->data.reg_data[(i*4+j)]);
+			else
+				ret = ops->reg_read(dev_data->bus, ADPD188_REG_FIFO_DATA,
+							(int *)&dev_data->data.reg_data[(i*4+j)]);
+			if (ret < 0)
+				goto irq_handled;
+		}
+	}
+
+	ret = iio_push_to_buffers_with_timestamp(indio_dev, dev_data->data.word,
+		pf->timestamp);
+	if (ret < 0)
+		pr_err("adpd188: IIO buffer push error.\n");
+
+irq_handled:
+	iio_trigger_notify_done(indio_dev->trig);
+	complete(&dev_data->value_ok);
+
+	return IRQ_HANDLED;
+}
+
+static int adpd188_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct adpd188 *dev_data = iio_priv(indio_dev);
+	int ret;
+
+	ret = adpd188_all_set_device_mode(dev_data, PROGRAM);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_clear_fifos(dev_data);
+	if (ret < 0)
+		return ret;
+
+	return adpd188_all_set_device_mode(dev_data, STANDBY);
+}
+
+static const struct iio_buffer_setup_ops adpd188_buffer_setup_ops = {
+	.postdisable = &adpd188_buffer_postdisable
+};
+
+static int adpd188_core_sub_setup(struct iio_dev *indio_dev, struct device *dev,
+				  int dev_no)
+{
+	int i;
+	int ret;
+	int regval;
+	struct adpd188 *dev_data = iio_priv(indio_dev);
+	struct adpd188_ops *ops = dev_data->ops;
+	struct i2c_client *i2c = dev_data->bus;
+
+	for (i = 1; i < dev_no; i++) {
+		ret = ops->i2c_sub_read(dev_data->bus, (i2c->addr + i),
+					ADPD188_REG_DEVID, &regval);
+		if (ret < 0)
+			return ret;
+		if ((regval & ADPD188_DEVID_MASK) != ADPD188_DEVID) {
+			dev_err(dev, "Error wrong device ID: %d\n", ret);
+			return -ENODEV;
+		}
+
+		ret = adpd188_i2c_reg_write_mask(dev_data, (i2c->addr + i),
+						 ADPD188_REG_SAMPLE_CLK, 1,
+						 ADPD188_CLK32K_EN);
+		if (ret < 0)
+			return ret;
+
+		ret = adpd188_sub_core_smoke_setup(dev_data, i);
+		if (ret < 0)
+			return ret;
+
+		ret = adpd188_i2c_reg_write_mask(dev_data, (i2c->addr + i),
+						 ADPD188_REG_GPIO_CTRL,
+						 0xD, ADPD188_GPIO0_ALT_CONFIG);
+		if (ret < 0)
+			return ret;
+		if (i == (dev_no - 1)) {
+			ret = adpd188_i2c_reg_write_mask(dev_data, (i2c->addr + i),
+							 ADPD188_REG_FIFO_THRESH,
+							 SAMPLE_WORDS, ADPD188_FIFO_THRESH);
+			if (ret < 0)
+				return ret;
+
+			ret = adpd188_i2c_reg_write_mask(dev_data, (i2c->addr + i),
+							 ADPD188_REG_GPIO_CTRL,
+							 0x0, ADPD188_GPIO0_ALT_CONFIG);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int adpd188_core_setup(struct iio_dev *indio_dev, struct device *dev,
+			      int irq)
+{
+	int ret;
+	int regval;
+	struct adpd188 *dev_data = iio_priv(indio_dev);
+	struct adpd188_ops *ops = dev_data->ops;
+	struct iio_trigger *trig;
+
+	ret = ops->reg_read(dev_data->bus, ADPD188_REG_DEVID, &regval);
+	if (ret < 0)
+		return ret;
+	if ((regval & ADPD188_DEVID_MASK) != ADPD188_DEVID) {
+		dev_err(dev, "Error wrong device ID: %d\n", regval);
+		return -ENODEV;
+	}
+
+	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_SAMPLE_CLK, 1, ADPD188_CLK32K_EN);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_core_smoke_setup(dev_data);
+	if (ret < 0)
+		return ret;
+
+	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_GPIO_DRV, 1, ADPD188_GPIO0_ENA);
+	if (ret < 0)
+		return ret;
+	if (dev_data->no_devices > 1)
+		regval = 0xD;
+	else
+		regval = 0x0;
+	ret = adpd188_reg_write_mask(dev_data, ADPD188_REG_GPIO_CTRL,
+				     regval, ADPD188_GPIO0_ALT_CONFIG);
+	if (ret < 0)
+		return ret;
+
+	trig = devm_iio_trigger_alloc(indio_dev->dev.parent, "%s-dev%d",
+				      indio_dev->name,
+				      indio_dev->id);
+	if (!trig)
+		return -ENOMEM;
+
+	trig->dev.parent = indio_dev->dev.parent;
+	trig->ops = &adpd188_trigger_ops;
+	iio_trigger_set_drvdata(trig, indio_dev);
+
+	ret = devm_iio_trigger_register(dev, trig);
+	if (ret)
+		return ret;
+
+	indio_dev->trig = iio_trigger_get(trig);
+
+	init_completion(&dev_data->value_ok);
+
+	ret = devm_request_threaded_irq(indio_dev->dev.parent, irq,
+			       &adpd188_interrupt, &adpd188_oneshot_apply,
+			       IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+			       indio_dev->name, indio_dev);
+	if (ret)
+		return ret;
+
+	return devm_iio_triggered_buffer_setup(indio_dev->dev.parent, indio_dev,
+					       &iio_pollfunc_store_time,
+					       &adpd188_trigger_handler,
+					       &adpd188_buffer_setup_ops);
+}
+
+int adpd188_core_probe(void *bus, struct adpd188_ops *phy,
+		       enum adpd188_phy_opt opt,
+		       int dev_no,
+		       const char *name, int irq)
+{
+	struct iio_dev *indio_dev;
+	int ret;
+	struct i2c_client *i2c;
+	struct spi_device *spi;
+	struct adpd188 *dev_data;
+	struct device *dev;
+
+	if (opt == ADPD188_I2C) {
+		i2c = (struct i2c_client *)bus;
+		dev = &i2c->dev;
+	} else {
+		spi = (struct spi_device *)bus;
+		dev = &spi->dev;
+	}
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*dev_data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	dev_data = iio_priv(indio_dev);
+	dev_data->ops = phy;
+	dev_data->phy_opt = opt;
+	dev_data->no_devices = dev_no;
+	dev_data->bus = bus;
+
+	indio_dev->dev.parent = dev;
+	indio_dev->info = &adpd188_info;
+	indio_dev->name = name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = adpd188_channels;
+	indio_dev->num_channels = 2 * dev_no + 1;
+
+	ret = adpd188_core_setup(indio_dev, dev, irq);
+	if (ret < 0)
+		return ret;
+
+	if (dev_no > 1) {
+		ret = adpd188_core_sub_setup(indio_dev, dev, dev_no);
+		if (ret < 0)
+			return ret;
+	}
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+EXPORT_SYMBOL_GPL(adpd188_core_probe);
+
+MODULE_AUTHOR("Andrei Drimbarean <andrei.drimbarean@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADPD188core driver");
+MODULE_LICENSE("GPL v2");
+
diff --git a/drivers/iio/light/adpd188.h b/drivers/iio/light/adpd188.h
new file mode 100644
index 000000000000..7daa36444527
--- /dev/null
+++ b/drivers/iio/light/adpd188.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * ADPD188 Integrated Optical Module for Smoke Detection
+ *
+ * Copyright 2021 Analog Devices Inc.
+ */
+
+#ifndef _ADPD188_H_
+#define _ADPD188_H_
+
+#define ADPD188_REG_GPIO_DRV			0x02
+#define ADPD188_REG_DEVID			0x08
+#define ADPD188_REG_GPIO_CTRL			0x0B
+
+/** ADPD188_REG_GPIO_DRV */
+#define ADPD188_GPIO1_DRV			BIT(9)
+#define ADPD188_GPIO1_POL			BIT(8)
+#define ADPD188_GPIO0_ENA			BIT(2)
+#define ADPD188_GPIO0_DRV			BIT(1)
+#define ADPD188_GPIO0_POL			BIT(0)
+
+/** ADPD188_REG_DEVID */
+#define ADPD188_DEVID_MASK				GENMASK(7, 0)
+
+/** ADPD188_REG_GPIO_CTRL */
+#define ADPD188_GPIO1_ALT_CONFIG		GENMASK(12, 8)
+#define ADPD188_GPIO0_ALT_CONFIG		GENMASK(4, 0)
+
+struct adpd188_ops {
+	int (*reg_write)(void *bus, int reg_addr, int val);
+	int (*reg_read)(void *bus, int reg_addr, int *val);
+	int (*i2c_sub_write)(void *bus, int sub_addr, int reg_addr, int val);
+	int (*i2c_sub_read)(void *bus, int sub_addr, int reg_addr, int *val);
+};
+
+enum adpd188_phy_opt {
+	ADPD188_I2C,
+	ADPD188_SPI
+};
+
+#define SAMPLE_WORDS	18
+struct adpd188 {
+	struct adpd188_ops *ops;
+	enum adpd188_phy_opt phy_opt;
+	void *bus;
+	int no_devices;
+	union {
+		u32 word[SAMPLE_WORDS];
+		u16 reg_data[SAMPLE_WORDS * 2];
+	} data ____cacheline_aligned;
+	struct completion value_ok;
+};
+
+enum supported_parts {
+	ADPD188
+};
+
+int adpd188_core_probe(void *bus, struct adpd188_ops *phy,
+		       enum adpd188_phy_opt opt,
+		       int dev_no,
+		       const char *name, int irq);
+
+#endif /* _ADPD188_H_ */
+
diff --git a/drivers/iio/light/adpd188_i2c.c b/drivers/iio/light/adpd188_i2c.c
new file mode 100644
index 000000000000..644c8a41461a
--- /dev/null
+++ b/drivers/iio/light/adpd188_i2c.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ADPD188 I2C driver
+ *
+ * Copyright 2021 Analog Devices Inc.
+ *
+ * 7-bit I2C slave address: 0x64
+ */
+
+#include <linux/i2c.h>
+#include <linux/module.h>
+
+#include "adpd188.h"
+
+#define ADPD188_REG_I2CS_ID			0x09
+#define ADPD188_REG_SLAVE_ADDR_KEY		0x0D
+#define ADPD188_REG_EXT_SYNC_SEL		0x4F
+
+/** ADPD188_REG_I2CS_ID */
+#define ADPD188_ADDRESS_WRITE_KEY_MASK		GENMASK(15, 8)
+#define ADPD188_SLAVE_ADDRESS_MASK		GENMASK(7, 1)
+
+/** ADPD188_REG_SLAVE_ADDR_KEY */
+#define EN_I2C_ADDR_CHANGE_ALWAYS		0x04AD
+#define EN_I2C_ADDR_CHANGE_IF_GPIO0_HIGH	0x44AD
+#define EN_I2C_ADDR_CHANGE_IF_GPIO1_HIGH	0x84AD
+
+/** ADPD188_REG_EXT_SYNC_SEL */
+#define ADPD188_GPIO1_OE			BIT(6)
+#define ADPD188_GPIO1_IE			BIT(5)
+#define ADPD188_EXT_SYNC_SEL			GENMASK(3, 2)
+#define ADPD188_GPIO0_IE			BIT(1)
+
+struct adpd188_i2c_buff {
+	u8 addr;
+	__be16 val;
+} __packed;
+
+static int adpd188_sub_reg_write(void *bus, int i2c_addr,
+			   int reg_addr, int value)
+{
+	struct i2c_msg msg;
+	struct adpd188_i2c_buff buf;
+	struct i2c_client *i2c = (struct i2c_client *)bus;
+
+	buf.addr = reg_addr;
+	buf.val = cpu_to_be16(value);
+	msg.addr = i2c_addr;
+	msg.flags = 0;
+	msg.len = 3;
+	msg.buf = (u8 *)&buf;
+
+	return i2c_transfer(i2c->adapter, &msg, 1);
+}
+
+static int adpd188_sub_reg_read(void *bus, int i2c_addr, int reg_addr,
+			  int *value)
+{
+	int ret;
+	struct i2c_msg msg[2];
+	struct adpd188_i2c_buff buf;
+	struct i2c_client *i2c = (struct i2c_client *)bus;
+
+	msg[0].addr = i2c_addr;
+	msg[0].flags = 0;
+	msg[0].len = 1;
+	buf.addr = reg_addr;
+	msg[0].buf = &buf.addr;
+	msg[1].addr = i2c_addr;
+	msg[1].flags = I2C_M_RD;
+	msg[1].len = 2;
+	msg[1].buf = (u8 *)&buf.val;
+
+	ret = i2c_transfer(i2c->adapter, msg, 2);
+	if (ret < 0)
+		return ret;
+
+	*value = be16_to_cpu(buf.val);
+
+	return 0;
+}
+
+static int adpd188_sub_reg_write_mask(void *bus, int i2c_addr,
+				int reg_addr, int value, int mask)
+{
+	int ret;
+	u16 reg_val;
+	struct i2c_client *i2c = (struct i2c_client *)bus;
+
+	ret = adpd188_sub_reg_read(i2c, i2c_addr, reg_addr, (int *)&reg_val);
+	if (ret < 0)
+		return ret;
+
+	reg_val &= ~mask;
+	reg_val |= (value << (ffs(mask) - 1)) & mask;
+
+	return adpd188_sub_reg_write(i2c, i2c_addr, reg_addr, reg_val);
+}
+
+static int adpd188_prime_reg_write_mask(void *bus, int addr,
+				  int value, int mask)
+{
+	struct i2c_client *i2c = (struct i2c_client *)bus;
+
+	return adpd188_sub_reg_write_mask(bus, i2c->addr, addr, value, mask);
+}
+
+static int adpd188_prime_reg_read(void *bus, int addr, int *value)
+{
+	struct i2c_client *i2c = (struct i2c_client *)bus;
+
+	return adpd188_sub_reg_read(bus, i2c->addr, addr, value);
+}
+
+static int adpd188_prime_reg_write(void *bus, int addr, int value)
+{
+	struct i2c_client *i2c = (struct i2c_client *)bus;
+
+	return adpd188_sub_reg_write(bus, i2c->addr, addr, value);
+}
+
+static int adpd188_i2c_addr_change(struct i2c_client *i2c, int no_devices)
+{
+	int ret;
+	int val;
+	int i;
+
+	ret = adpd188_prime_reg_read(i2c, ADPD188_REG_DEVID, &val);
+	if (ret < 0) {
+		dev_err(&i2c->dev, "i2c read failed. ret=%d\n", ret);
+		return ret;
+	}
+	if ((val & 0xFF) != 0x16) {
+		dev_err(&i2c->dev, "i2c read failed. ret=%d val=%x\n", ret, val);
+		return ret;
+	}
+
+	ret = adpd188_prime_reg_write_mask(i2c, ADPD188_REG_GPIO_DRV,
+				  1, ADPD188_GPIO0_ENA);
+	if (ret < 0)  {
+		dev_err(&i2c->dev, "Error GPIO 0 enable: %d\n", ret);
+		return ret;
+	}
+	ret = adpd188_prime_reg_write_mask(i2c, ADPD188_REG_GPIO_CTRL,
+				  0x11, ADPD188_GPIO0_ALT_CONFIG);
+	if (ret < 0)  {
+		dev_err(&i2c->dev, "Error GPIO 0 state to high: %d\n", ret);
+		return ret;
+	}
+
+	ret = adpd188_prime_reg_write_mask(i2c, ADPD188_REG_EXT_SYNC_SEL,
+				1, ADPD188_GPIO1_IE);
+	if (ret < 0)  {
+		dev_err(&i2c->dev, "Error 0x4F not accessible: %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < (no_devices - 1); i++) {
+		val = (0xAD << (ffs(ADPD188_ADDRESS_WRITE_KEY_MASK) - 1)) |
+			((i2c->addr + i + 1) << (ffs(ADPD188_SLAVE_ADDRESS_MASK) - 1));
+		ret = adpd188_sub_reg_write(i2c, (i2c->addr + i), ADPD188_REG_SLAVE_ADDR_KEY,
+					EN_I2C_ADDR_CHANGE_IF_GPIO1_HIGH);
+		if (ret < 0)  {
+			dev_err(&i2c->dev, "Error changing slave address key: %d\n", ret);
+			return ret;
+		}
+		ret = adpd188_sub_reg_write(i2c, (i2c->addr + i), ADPD188_REG_I2CS_ID, val);
+		if (ret < 0)  {
+			dev_err(&i2c->dev, "Error changing slave address: %d\n", i);
+			return ret;
+		}
+		ret = adpd188_sub_reg_read(i2c, (i2c->addr + i + 1), ADPD188_REG_DEVID, &val);
+		if ((ret < 0) || ((val & 0xFF) != 0x16)) {
+			dev_err(&i2c->dev, "Failed to access device after reg change.\n");
+			return ret;
+		}
+		ret = adpd188_sub_reg_write_mask(i2c, (i2c->addr + i), ADPD188_REG_GPIO_CTRL,
+						0x10, ADPD188_GPIO0_ALT_CONFIG);
+		if (ret < 0) {
+			dev_err(&i2c->dev, "Error changing GPIO 0 to low: %d\n", i);
+			return ret;
+		}
+	}
+
+	dev_info(&i2c->dev, "adpd188 IDs changed.\n");
+
+	return 0;
+}
+
+static int adpd188_i2c_probe(struct i2c_client *i2c)
+{
+	int ret;
+	u32 no_devices;
+	struct adpd188_ops *phy;
+
+	ret = of_property_read_u32(i2c->dev.of_node,
+				   "adi,no-of-devices", &no_devices);
+	if (ret)
+		return ret;
+
+	if (no_devices > 1) {
+		ret = adpd188_i2c_addr_change(i2c, no_devices);
+		if (ret < 0)
+			return ret;
+	}
+
+	phy = devm_kzalloc(&i2c->dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+	phy->reg_write = adpd188_prime_reg_write;
+	phy->reg_read = adpd188_prime_reg_read;
+	phy->i2c_sub_write = adpd188_sub_reg_write;
+	phy->i2c_sub_read = adpd188_sub_reg_read;
+
+	return adpd188_core_probe(i2c, phy, ADPD188_I2C, no_devices, i2c->name, i2c->irq);
+}
+
+static const struct i2c_device_id adpd188_i2c_id[] = {
+	{ "adpd188", ADPD188 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, adpd188_i2c_id);
+
+static const struct of_device_id adpd188_of_match[] = {
+	{ .compatible = "adi,adpd188" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, adpd188_of_match);
+
+static struct i2c_driver adpd188_i2c_driver = {
+	.driver = {
+			.name = "adpd188_i2c",
+			.of_match_table = adpd188_of_match,
+		},
+	.probe_new = adpd188_i2c_probe,
+	.id_table = adpd188_i2c_id,
+};
+module_i2c_driver(adpd188_i2c_driver);
+
+MODULE_AUTHOR("Andrei Drimbarean <andrei.drimbarean@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADPD188 I2C driver");
+MODULE_LICENSE("GPL v2");
+
diff --git a/drivers/iio/light/adpd188_spi.c b/drivers/iio/light/adpd188_spi.c
new file mode 100644
index 000000000000..ba93750bf1b5
--- /dev/null
+++ b/drivers/iio/light/adpd188_spi.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ADPD188 SPI driver
+ *
+ * Copyright 2021 Analog Devices Inc.
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/spi/spi.h>
+
+#include "adpd188.h"
+
+static int adpd188_reg_write(void *bus, int addr, int value)
+{
+	struct spi_device *spi = bus;
+	u8 buff[3];
+	struct spi_message m;
+	struct spi_transfer t = {0};
+
+	buff[0] = (addr << 1) | 1;
+	buff[1] = value >> 8;
+	buff[2] = value & 0xff;
+
+	t.tx_buf = buff;
+	t.len = 3;
+
+	spi_message_init_with_transfers(&m, &t, 1);
+
+	return spi_sync(spi, &m);
+}
+
+static int adpd188_reg_read(void *bus, int addr, int *value)
+{
+	struct spi_device *spi = bus;
+	uint8_t buff[3];
+	struct spi_message m;
+	struct spi_transfer t = {0};
+	int ret;
+
+	buff[0] = addr << 1;
+
+	t.rx_buf = buff;
+	t.tx_buf = buff;
+	t.len = 3;
+
+	spi_message_init_with_transfers(&m, &t, 1);
+
+	ret = spi_sync(spi, &m);
+	if (ret < 0)
+		return ret;
+
+	*value = (buff[1] << 8) | buff[2];
+
+	return ret;
+}
+
+static int adpd188_spi_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id = spi_get_device_id(spi);
+	struct adpd188_ops *phy;
+
+	phy = devm_kzalloc(&spi->dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+	phy->reg_write = adpd188_reg_write;
+	phy->reg_read = adpd188_reg_read;
+
+	return adpd188_core_probe(spi, phy, ADPD188_SPI, 1, id->name, spi->irq);
+}
+
+static const struct spi_device_id adpd188_spi_id[] = {
+	{ "adpd188", ADPD188 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, adpd188_spi_id);
+
+static const struct of_device_id adpd188_of_match[] = {
+	{ .compatible = "adi,adpd188" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, adpd188_of_match);
+
+static struct spi_driver adpd188_spi_driver = {
+	.driver = {
+			.name = "adpd188_spi",
+			.of_match_table = adpd188_of_match,
+		},
+	.probe = adpd188_spi_probe,
+	.id_table = adpd188_spi_id,
+};
+module_spi_driver(adpd188_spi_driver);
+
+MODULE_AUTHOR("Andrei Drimbarean <andrei.drimbarean@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADPD188 SPI driver");
+MODULE_LICENSE("GPL v2");
+
-- 
2.25.1

