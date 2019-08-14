Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E91858CE6E
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2019 10:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfHNI3V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 14 Aug 2019 04:29:21 -0400
Received: from tr-host.de ([138.201.124.202]:44306 "EHLO kolab.tr-host.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbfHNI3R (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 14 Aug 2019 04:29:17 -0400
X-Greylist: delayed 472 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Aug 2019 04:29:15 EDT
Received: from localhost (localhost [127.0.0.1])
        by kolab.tr-host.de (Postfix) with ESMTP id F0BC83662E9B;
        Wed, 14 Aug 2019 10:21:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at example.com
Received: from kolab.tr-host.de ([127.0.0.1])
        by localhost (kolab.tr-host.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bVwFhNn_AhPk; Wed, 14 Aug 2019 10:21:19 +0200 (CEST)
Received: from koena-laptop-leo.koena (HSI-KBW-046-005-255-200.hsi8.kabel-badenwuerttemberg.de [46.5.255.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: leonard.pollak@tr-host.de)
        by kolab.tr-host.de (Postfix) with ESMTPSA id C811B3662E79;
        Wed, 14 Aug 2019 10:21:18 +0200 (CEST)
From:   Leonard Pollak <leonardp@tr-host.de>
To:     linux-iio@vger.kernel.org
Cc:     lars@metafoo.de, michael.hennerich@analog.com, jic23@kernel.org,
        pmeerw@pmeerw.net, Leonard Pollak <leonardp@tr-host.de>
Subject: [PATCH] staging:iio:meter add driver for ADE9000
Date:   Wed, 14 Aug 2019 10:20:37 +0200
Message-Id: <20190814082037.5214-1-leonardp@tr-host.de>
X-Mailer: git-send-email 2.17.1
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch adds basic support for the ADE9000 energy metering IC
by Analog Devices.

The driver has enough functionality to calibrate the device and do
voltage, current, energy and power measurements.

Signed-off-by: Leonard Pollak <leonardp@tr-host.de>
---
 drivers/staging/iio/meter/Kconfig        |  12 +-
 drivers/staging/iio/meter/Makefile       |   2 +
 drivers/staging/iio/meter/TODO           |   7 +
 drivers/staging/iio/meter/ade9000.c      | 427 +++++++++++++++++++
 drivers/staging/iio/meter/ade9000.h      | 519 +++++++++++++++++++++++
 drivers/staging/iio/meter/ade9000_chan.h | 217 ++++++++++
 6 files changed, 1183 insertions(+), 1 deletion(-)
 create mode 100644 drivers/staging/iio/meter/TODO
 create mode 100644 drivers/staging/iio/meter/ade9000.c
 create mode 100644 drivers/staging/iio/meter/ade9000.h
 create mode 100644 drivers/staging/iio/meter/ade9000_chan.h

diff --git a/drivers/staging/iio/meter/Kconfig b/drivers/staging/iio/meter/Kconfig
index aa6a3e7f6cdb..c34aef1282aa 100644
--- a/drivers/staging/iio/meter/Kconfig
+++ b/drivers/staging/iio/meter/Kconfig
@@ -2,7 +2,17 @@
 #
 # IIO meter drivers configuration
 #
-menu "Active energy metering IC"
+menu "Active energy metering ICs"
+
+config ADE9000
+	tristate "Analog Devices ADE9000 Polyphase Multifunction Energy (Quality) Metering IC Driver"
+	depends on SPI
+	help
+	  Say yes here to build support for Analog Devices ADE9000 Polyphase
+	  Multifunction Energy and Energy Quality Metering IC Driver.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ade9000.
 
 config ADE7854
 	tristate "Analog Devices ADE7854/58/68/78 Polyphase Multifunction Energy Metering IC Driver"
diff --git a/drivers/staging/iio/meter/Makefile b/drivers/staging/iio/meter/Makefile
index ed4547e38f3a..77557a1b9050 100644
--- a/drivers/staging/iio/meter/Makefile
+++ b/drivers/staging/iio/meter/Makefile
@@ -3,6 +3,8 @@
 # Makefile for metering ic drivers
 #
 
+obj-$(CONFIG_ADE9000) += ade9000.o
+
 obj-$(CONFIG_ADE7854) += ade7854.o
 obj-$(CONFIG_ADE7854_I2C) += ade7854-i2c.o
 obj-$(CONFIG_ADE7854_SPI) += ade7854-spi.o
diff --git a/drivers/staging/iio/meter/TODO b/drivers/staging/iio/meter/TODO
new file mode 100644
index 000000000000..009e7153c112
--- /dev/null
+++ b/drivers/staging/iio/meter/TODO
@@ -0,0 +1,7 @@
+ADE9000
+===
+
+* get the temperature sensor to work
+* calculate conversion constants and provide processed channels
+* provide channels for combined, processed inputs (e.g. all three phases combined)
+* implement buffer for reading WATTHR measurements so we don't lose any values
diff --git a/drivers/staging/iio/meter/ade9000.c b/drivers/staging/iio/meter/ade9000.c
new file mode 100644
index 000000000000..d1c21bf47cff
--- /dev/null
+++ b/drivers/staging/iio/meter/ade9000.c
@@ -0,0 +1,427 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/* Analog Devices ADE9000
+ * Polyphase Multifunction Energy (Quality) Metering IC Driver
+ *
+ * Copyright (c) 2019 Leonard Pollak
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/delay.h>
+#include <linux/mutex.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/spi/spi.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/list.h>
+#include <linux/module.h>
+
+#include <linux/export.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#include "ade9000.h"
+#include "ade9000_chan.h"
+
+static int ade9000_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val,
+			    int *val2,
+			    long mask)
+{
+	struct ade9000_state *st;
+
+	int ret;
+
+	st = iio_priv(indio_dev);
+
+	switch (mask) {
+/*
+ * the calculation of the processed values needs conversion constants
+ * for now the calculation of the conversion has to be done from userspace
+ */
+	//case IIO_CHAN_INFO_PROCESSED:
+	//	switch (chan->type) {
+	//	case IIO_ALTVOLTAGE:
+	//		ret = ade9000_voltage_processed(st, chan->address, val);
+	//		return IIO_VAL_INT; // millivolts!
+	//	case IIO_TEMP:
+	//		ret = ade9000_temp_processed(st, chan->address, val);
+	//		return IIO_VAL_INT_PLUS_MICRO;
+	//	case IIO_CURRENT:
+	//		ret = ade9000_current_processed(st, chan->address, val);
+	//		return IIO_VAL_INT;
+	//	default:
+	//		return -EINVAL;
+	//}
+	case IIO_CHAN_INFO_SCALE:
+		ret = st->read_reg(st, chan->address, val, 32);
+		break;
+	case IIO_CHAN_INFO_OFFSET:
+		ret = st->read_reg(st, chan->address, val, 32);
+		break;
+	case IIO_CHAN_INFO_RAW:
+		ret = st->read_reg(st, chan->address, val, 32);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return IIO_VAL_INT;
+}
+
+static int ade9000_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val,
+			     int val2,
+			     long mask)
+{
+	struct ade9000_state *st;
+
+	int ret;
+
+	st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_OFFSET:
+		switch (chan->type) {
+		case IIO_CURRENT:
+			ret = ade9000_spi_write(st, chan->address, val, 32);
+			return ret;
+		case IIO_ALTVOLTAGE:
+			ret = ade9000_spi_write(st, chan->address, val, 32);
+			return ret;
+		case IIO_POWER:
+			ret = ade9000_spi_write(st, chan->address, val, 32);
+			return ret;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_CURRENT:
+			ret = ade9000_spi_write(st, chan->address, val, 32);
+			return ret;
+		case IIO_ALTVOLTAGE:
+			ret = ade9000_spi_write(st, chan->address, val, 32);
+			return ret;
+		case IIO_POWER:
+			ret = ade9000_spi_write(st, chan->address, val, 32);
+			return ret;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			ret = ade9000_spi_write(st, chan->address, val, 32);
+			return ret;
+		case IIO_PHASE:
+			ret = ade9000_spi_write(st, chan->address, val, 32);
+			return ret;
+		case IIO_POWER:
+			ret = ade9000_spi_write(st, chan->address, val, 32);
+			return ret;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int ade9000_spi_read(struct ade9000_state *st,
+			    u16 address,
+			    u32 *val,
+			    int bits)
+{
+	int ret;
+
+	mutex_lock(&st->buf_lock);
+
+	st->tx[0] = (address >> 4) & 0xFF;
+	// setting bit 3 -> read cmd
+	st->tx[1] = ((address << 4) & 0xFF) | BIT(3);
+
+	ret = spi_write_then_read(st->spi, st->tx, 2, st->rx, 4);
+
+	if (ret < 0) {
+		dev_err("problem when reading register 0x%02X", address);
+		goto unlock;
+	}
+
+	switch (bits) {
+	case 16:
+		*val = be16_to_cpup((const __be16 *)st->rx);
+		break;
+	case 32:
+		*val = be32_to_cpup((const __be32 *)st->rx);
+		break;
+	default:
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+unlock:
+	mutex_unlock(&st->buf_lock);
+	return ret;
+}
+
+static int ade9000_spi_write(struct ade9000_state *st,
+			     u16 address,
+			     u32 val,
+			     int bits)
+{
+	int ret;
+
+	struct spi_transfer xfer = {
+		.tx_buf = st->tx,
+		.bits_per_word = 8,
+		.len = bits,
+	};
+
+	mutex_lock(&st->buf_lock);
+	st->tx[0] = (address >> 4) & 0xFF;
+	// clearing bit 3 -> write cmd
+	st->tx[1] = (address << 4) & 0xF0;
+
+	switch (bits) {
+	case 16:
+		xfer.len = 4;
+		st->tx[2] = (val >> 8) & 0xFF;
+		st->tx[3] = val & 0xFF;
+		break;
+	case 32:
+		xfer.len = 6;
+		st->tx[2] = (val >> 24) & 0xFF;
+		st->tx[3] = (val >> 16) & 0xFF;
+		st->tx[4] = (val >> 8) & 0xFF;
+		st->tx[5] = val & 0xFF;
+		break;
+	default:
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	ret = spi_write(st->spi, st->tx, 32);
+
+unlock:
+	mutex_unlock(&st->buf_lock);
+	return ret;
+}
+
+static int ade9000_voltage_processed(struct ade9000_state *st,
+				     u16 address,
+				     u32 *val)
+{
+	int ret = 0;
+
+	ret = st->read_reg(st, address, val, 32);
+
+	return ret;
+}
+
+static int ade9000_current_processed(struct ade9000_state *st,
+				     u16 address,
+				     u32 *val)
+{
+	int ret = 0;
+
+	ret = st->read_reg(st, address, val, 32);
+
+	return ret;
+}
+
+static int ade9000_init_info(struct ade9000_state *st)
+{
+	u32 idvar = 0;
+
+	/* Read Version */
+	st->read_reg(st, ADE9000_VERSION, &idvar, 16);
+
+	if (idvar != ADE9000_CHIP_VERSION)
+		goto err_ret;
+
+	return 0;
+
+err_ret:
+	dev_err("Version Check FAILED - got: %04X\n", idvar);
+	return -ENODEV;
+}
+
+static int ade9000_set_irq(struct ade9000_state *st, bool enable)
+{
+	int ret;
+	u32 irqen;
+
+	ret = st->read_reg(st, ADE9000_MASK0, &irqen, 32);
+	if (ret)
+		return ret;
+
+	/* 1: interrupt enabled when all periodical
+	 * (at 8 kHz rate) DSP computations finish.
+	 */
+	if (enable)
+		irqen |= BIT(17);
+	else
+		irqen &= ~BIT(17);
+
+	return st->write_reg(st, ADE9000_MASK0, irqen, 32);
+}
+
+static int ade9000_reset(struct ade9000_state *st)
+{
+	u32 val;
+
+	st->read_reg(st, ADE9000_CONFIG1, &val, 16);
+	val |= BIT(0); /* Software Chip Reset */
+
+	return st->write_reg(st, ADE9000_CONFIG1, val, 16);
+}
+
+static const struct of_device_id ade9000_of_dt_ids[] = {
+	{.compatible = "adi,ade9000"},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ade9000_of_dt_ids);
+
+static const struct spi_device_id ade9000_id[] = {
+	{"ade9000", ADE9000_CHIP_ID},
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ade9000_id);
+
+static struct spi_driver ade9000_driver = {
+	.driver = {
+		.name = "ade9000",
+		.of_match_table = of_match_ptr(ade9000_of_dt_ids),
+	},
+	.id_table = ade9000_id,
+	.probe = ade9000_probe,
+};
+module_spi_driver(ade9000_driver);
+
+static struct attribute *ade9000_attributes[] = {
+	&iio_const_attr_name.dev_attr.attr,
+	&iio_dev_attr_run.dev_attr.attr,
+	&iio_dev_attr_ep_cfg.dev_attr.attr,
+	&iio_dev_attr_egy_time.dev_attr.attr,
+	&iio_dev_attr_pwr_time.dev_attr.attr,
+	&iio_dev_attr_zx_sel.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ade9000_attribute_group = {
+	.attrs = ade9000_attributes,
+};
+
+static const struct iio_info ade9000_info = {
+	.attrs = &ade9000_attribute_group,
+	.read_raw = ade9000_read_raw,
+	.write_raw = ade9000_write_raw,
+};
+
+static int ade9000_probe(struct spi_device *spi)
+{
+	int ret;
+	struct ade9000_state *st;
+	struct iio_dev *indio_dev;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	spi_set_drvdata(spi, indio_dev);
+	st->spi = spi;
+	st->read_reg = ade9000_spi_read;
+	st->write_reg = ade9000_spi_write;
+	st->irq = spi->irq;
+	st->run = 0;
+
+	/* setup the industrialio driver allocated elements */
+	mutex_init(&st->buf_lock);
+
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->info = &ade9000_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ade9000_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ade9000_channels);
+
+	ret = ade9000_init_info(st);
+	if (ret) {
+		dev_err("Failed initial sanity check!");
+		ret = -ENODEV;
+		goto err_ret;
+	}
+
+	//ret = ade9000_set_irq(st, IRQ_ENABLE);
+	//if (ret) {
+	//	dev_err("setting irq faled!");
+	//	ret = -ENODEV;
+	//	goto err_ret;
+	//}
+
+	ret = ade9000_reset(st);
+	if (ret) {
+		dev_err("Resetting the device failed!");
+		ret = -ENODEV;
+		goto err_ret;
+	}
+
+	usleep_range(ADE9000_STARTUP_DELAY, ADE9000_STARTUP_DELAY + 100);
+
+	ret = devm_iio_device_register(&spi->dev, indio_dev);
+	return ret;
+
+err_ret:
+	dev_err("error error!\n");
+	return ret;
+}
+
+static ssize_t ade9000_set_attr(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf,
+				size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ade9000_state *st = iio_priv(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	int ret;
+	u32 val;
+
+	ret = kstrtou32(buf, 10, &val);
+
+	// for run register?
+	//if (val != 1 && val != 0)
+	//    return -EINVAL;
+
+	ret = st->write_reg(st, this_attr->address, val, 16);
+	return ret ? ret : len;
+}
+
+static ssize_t ade9000_get_attr(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ade9000_state *st = iio_priv(indio_dev);
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+
+	int ret;
+	u32 val = 0;
+
+	ret = st->read_reg(st, this_attr->address, &val, 16);
+	return sprintf(buf, "%d\n", val);
+}
+
+MODULE_AUTHOR("Leonard Pollak <pollak@tr-host.de>");
+MODULE_DESCRIPTION("Analog Devices ADE9000 Polyphase Energy Meter");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/staging/iio/meter/ade9000.h b/drivers/staging/iio/meter/ade9000.h
new file mode 100644
index 000000000000..3a3c5574387a
--- /dev/null
+++ b/drivers/staging/iio/meter/ade9000.h
@@ -0,0 +1,519 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _ADE9000_H
+#define _ADE9000_H
+
+#define ADE9000_AIGAIN		0x000
+#define ADE9000_AIGAIN0		0x001
+#define ADE9000_AIGAIN1		0x002
+#define ADE9000_AIGAIN2		0x003
+#define ADE9000_AIGAIN3		0x004
+#define ADE9000_AIGAIN4		0x005
+#define ADE9000_APHCAL0		0x006
+#define ADE9000_APHCAL1		0x007
+#define ADE9000_APHCAL2		0x008
+#define ADE9000_APHCAL3		0x009
+#define ADE9000_APHCAL4		0x00A
+#define ADE9000_AVGAIN		0x00B
+#define ADE9000_AIRMSOS		0x00C
+#define ADE9000_AVRMSOS		0x00D
+#define ADE9000_APGAIN		0x00E
+#define ADE9000_AWATTOS		0x00F
+#define ADE9000_AVAROS		0x010
+#define ADE9000_AFWATTOS	0x011
+#define ADE9000_AFVAROS		0x012
+#define ADE9000_AIFRMSOS	0x013
+#define ADE9000_AVFRMSOS	0x014
+#define ADE9000_AVRMSONEOS	0x015
+#define ADE9000_AIRMSONEOS	0x016
+#define ADE9000_AVRMS1012OS	0x017
+#define ADE9000_AIRMS1012OS	0x018
+#define ADE9000_BIGAIN		0x020
+#define ADE9000_BIGAIN0		0x021
+#define ADE9000_BIGAIN1		0x022
+#define ADE9000_BIGAIN2		0x023
+#define ADE9000_BIGAIN3		0x024
+#define ADE9000_BIGAIN4		0x025
+#define ADE9000_BPHCAL0		0x026
+#define ADE9000_BPHCAL1		0x027
+#define ADE9000_BPHCAL2		0x028
+#define ADE9000_BPHCAL3		0x029
+#define ADE9000_BPHCAL4		0x02A
+#define ADE9000_BVGAIN		0x02B
+#define ADE9000_BIRMSOS		0x02C
+#define ADE9000_BVRMSOS		0x02D
+#define ADE9000_BPGAIN		0x02E
+#define ADE9000_BWATTOS		0x02F
+#define ADE9000_BVAROS		0x030
+#define ADE9000_BFWATTOS	0x031
+#define ADE9000_BFVAROS		0x032
+#define ADE9000_BIFRMSOS	0x033
+#define ADE9000_BVFRMSOS	0x034
+#define ADE9000_BVRMSONEOS	0x035
+#define ADE9000_BIRMSONEOS	0x036
+#define ADE9000_BVRMS1012OS	0x037
+#define ADE9000_BIRMS1012OS	0x038
+#define ADE9000_CIGAIN		0x040
+#define ADE9000_CIGAIN0		0x041
+#define ADE9000_CIGAIN1		0x042
+#define ADE9000_CIGAIN2		0x043
+#define ADE9000_CIGAIN3		0x044
+#define ADE9000_CIGAIN4		0x045
+#define ADE9000_CPHCAL0		0x046
+#define ADE9000_CPHCAL1		0x047
+#define ADE9000_CPHCAL2		0x048
+#define ADE9000_CPHCAL3		0x049
+#define ADE9000_CPHCAL4		0x04A
+#define ADE9000_CVGAIN		0x04B
+#define ADE9000_CIRMSOS		0x04C
+#define ADE9000_CVRMSOS		0x04D
+#define ADE9000_CPGAIN		0x04E
+#define ADE9000_CWATTOS		0x04F
+#define ADE9000_CVAROS		0x050
+#define ADE9000_CFWATTOS	0x051
+#define ADE9000_CFVAROS		0x052
+#define ADE9000_CIFRMSOS	0x053
+#define ADE9000_CVFRMSOS	0x054
+#define ADE9000_CVRMSONEOS	0x055
+#define ADE9000_CIRMSONEOS	0x056
+#define ADE9000_CVRMS1012OS	0x057
+#define ADE9000_CIRMS1012OS	0x058
+#define ADE9000_CONFIG0		0x060
+#define ADE9000_MTTHR_L0	0x061
+#define ADE9000_MTTHR_L1	0x062
+#define ADE9000_MTTHR_L2	0x063
+#define ADE9000_MTTHR_L3	0x064
+#define ADE9000_MTTHR_L4	0x065
+#define ADE9000_MTTHR_H0	0x066
+#define ADE9000_MTTHR_H1	0x067
+#define ADE9000_MTTHR_H2	0x068
+#define ADE9000_MTTHR_H3	0x069
+#define ADE9000_MTTHR_H4	0x06A
+#define ADE9000_NIRMSOS		0x06B
+#define ADE9000_ISUMRMSOS	0x06C
+#define ADE9000_NIGAIN		0x06D
+#define ADE9000_NPHCAL		0x06E
+#define ADE9000_NIRMSONEOS	0x06F
+#define ADE9000_NIRMS1012OS	0x070
+#define ADE9000_VNOM		0x071
+#define ADE9000_DICOEFF		0x072
+#define ADE9000_ISUMLVL		0x073
+#define ADE9000_AI_PCF		0x20A
+#define ADE9000_AV_PCF		0x20B
+#define ADE9000_AIRMS		0x20C
+#define ADE9000_AVRMS		0x20D
+#define ADE9000_AIFRMS		0x20E
+#define ADE9000_AVFRMS		0x20F
+#define ADE9000_AWATT		0x210
+#define ADE9000_AVAR		0x211
+#define ADE9000_AVA         0x212
+#define ADE9000_AFWATT		0x213
+#define ADE9000_AFVAR		0x214
+#define ADE9000_AFVA		0x215
+#define ADE9000_APF         0x216
+#define ADE9000_AVTHD		0x217
+#define ADE9000_AITHD		0x218
+#define ADE9000_AIRMSONE	0x219
+#define ADE9000_AVRMSONE	0x21A
+#define ADE9000_AIRMS1012	0x21B
+#define ADE9000_AVRMS1012	0x21C
+#define ADE9000_AMTREGION	0x21D
+#define ADE9000_BI_PCF		0x22A
+#define ADE9000_BV_PCF		0x22B
+#define ADE9000_BIRMS		0x22C
+#define ADE9000_BVRMS		0x22D
+#define ADE9000_BIFRMS		0x22E
+#define ADE9000_BVFRMS		0x22F
+#define ADE9000_BWATT		0x230
+#define ADE9000_BVAR		0x231
+#define ADE9000_BVA         0x232
+#define ADE9000_BFWATT		0x233
+#define ADE9000_BFVAR		0x234
+#define ADE9000_BFVA		0x235
+#define ADE9000_BPF         0x236
+#define ADE9000_BVTHD		0x237
+#define ADE9000_BITHD		0x238
+#define ADE9000_BIRMSONE	0x239
+#define ADE9000_BVRMSONE	0x23A
+#define ADE9000_BIRMS1012	0x23B
+#define ADE9000_BVRMS1012	0x23C
+#define ADE9000_BMTREGION	0x23D
+#define ADE9000_CI_PCF		0x24A
+#define ADE9000_CV_PCF		0x24B
+#define ADE9000_CIRMS		0x24C
+#define ADE9000_CVRMS		0x24D
+#define ADE9000_CIFRMS		0x24E
+#define ADE9000_CVFRMS		0x24F
+#define ADE9000_CWATT		0x250
+#define ADE9000_CVAR		0x251
+#define ADE9000_CVA         0x252
+#define ADE9000_CFWATT		0x253
+#define ADE9000_CFVAR		0x254
+#define ADE9000_CFVA		0x255
+#define ADE9000_CPF         0x256
+#define ADE9000_CVTHD		0x257
+#define ADE9000_CITHD		0x258
+#define ADE9000_CIRMSONE	0x259
+#define ADE9000_CVRMSONE	0x25A
+#define ADE9000_CIRMS1012	0x25B
+#define ADE9000_CVRMS1012	0x25C
+#define ADE9000_CMTREGION	0x25D
+#define ADE9000_NI_PCF		0x265
+#define ADE9000_NIRMS		0x266
+#define ADE9000_NIRMSONE	0x267
+#define ADE9000_NIRMS1012	0x268
+#define ADE9000_ISUMRMS		0x269
+#define ADE9000_VERSION2	0x26A
+#define ADE9000_AWATT_ACC	0x2E5
+#define ADE9000_AWATTHR_LO	0x2E6
+#define ADE9000_AWATTHR_HI	0x2E7
+#define ADE9000_AVAR_ACC	0x2EF
+#define ADE9000_AVARHR_LO	0x2F0
+#define ADE9000_AVARHR_HI	0x2F1
+#define ADE9000_AVA_ACC		0x2F9
+#define ADE9000_AVAHR_LO	0x2FA
+#define ADE9000_AVAHR_HI	0x2FB
+#define ADE9000_AFWATT_ACC	0x303
+#define ADE9000_AFWATTHR_LO	0x304
+#define ADE9000_AFWATTHR_HI	0x305
+#define ADE9000_AFVAR_ACC	0x30D
+#define ADE9000_AFVARHR_LO	0x30E
+#define ADE9000_AFVARHR_HI	0x30F
+#define ADE9000_AFVA_ACC	0x317
+#define ADE9000_AFVAHR_LO	0x318
+#define ADE9000_AFVAHR_HI	0x319
+#define ADE9000_BWATT_ACC	0x321
+#define ADE9000_BWATTHR_LO	0x322
+#define ADE9000_BWATTHR_HI	0x323
+#define ADE9000_BVAR_ACC	0x32B
+#define ADE9000_BVARHR_LO	0x32C
+#define ADE9000_BVARHR_HI	0x32D
+#define ADE9000_BVA_ACC		0x335
+#define ADE9000_BVAHR_LO	0x336
+#define ADE9000_BVAHR_HI	0x337
+#define ADE9000_BFWATT_ACC	0x33F
+#define ADE9000_BFWATTHR_LO	0x340
+#define ADE9000_BFWATTHR_HI	0x341
+#define ADE9000_BFVAR_ACC	0x349
+#define ADE9000_BFVARHR_LO	0x34A
+#define ADE9000_BFVARHR_HI	0x34B
+#define ADE9000_BFVA_ACC	0x353
+#define ADE9000_BFVAHR_LO	0x354
+#define ADE9000_BFVAHR_HI	0x355
+#define ADE9000_CWATT_ACC	0x35D
+#define ADE9000_CWATTHR_LO	0x35E
+#define ADE9000_CWATTHR_HI	0x35F
+#define ADE9000_CVAR_ACC	0x367
+#define ADE9000_CVARHR_LO	0x368
+#define ADE9000_CVARHR_HI	0x369
+#define ADE9000_CVA_ACC		0x371
+#define ADE9000_CVAHR_LO	0x372
+#define ADE9000_CVAHR_HI	0x373
+#define ADE9000_CFWATT_ACC	0x37B
+#define ADE9000_CFWATTHR_LO	0x37C
+#define ADE9000_CFWATTHR_HI	0x37D
+#define ADE9000_CFVAR_ACC	0x385
+#define ADE9000_CFVARHR_LO	0x386
+#define ADE9000_CFVARHR_HI	0x387
+#define ADE9000_CFVA_ACC	0x38F
+#define ADE9000_CFVAHR_LO	0x390
+#define ADE9000_CFVAHR_HI	0x391
+#define ADE9000_PWATT_ACC	0x397
+#define ADE9000_NWATT_ACC	0x39B
+#define ADE9000_PVAR_ACC	0x39F
+#define ADE9000_NVAR_ACC	0x3A3
+#define ADE9000_IPEAK		0x400
+#define ADE9000_VPEAK		0x401
+#define ADE9000_STATUS0		0x402
+#define ADE9000_STATUS1		0x403
+#define ADE9000_EVENT_STATUS	0x404
+#define ADE9000_MASK0		0x405
+#define ADE9000_MASK1		0x406
+#define ADE9000_EVENT_MASK	0x407
+#define ADE9000_OILVL		0x409
+#define ADE9000_OIA         0x40A
+#define ADE9000_OIB         0x40B
+#define ADE9000_OIC         0x40C
+#define ADE9000_OIN         0x40D
+#define ADE9000_USER_PERIOD	0x40E
+#define ADE9000_VLEVEL		0x40F
+#define ADE9000_DIP_LVL		0x410
+#define ADE9000_DIPA		0x411
+#define ADE9000_DIPB		0x412
+#define ADE9000_DIPC		0x413
+#define ADE9000_SWELL_LVL	0x414
+#define ADE9000_SWELLA		0x415
+#define ADE9000_SWELLB		0x416
+#define ADE9000_SWELLC		0x417
+#define ADE9000_APERIOD		0x418
+#define ADE9000_BPERIOD		0x419
+#define ADE9000_CPERIOD		0x41A
+#define ADE9000_COM_PERIOD	0x41B
+#define ADE9000_ACT_NL_LVL	0x41C
+#define ADE9000_REACT_NL_LVL	0x41D
+#define ADE9000_APP_NL_LVL	0x41E
+#define ADE9000_PHNOLOAD	0x41F
+#define ADE9000_WTHR		0x420
+#define ADE9000_VARTHR		0x421
+#define ADE9000_VATHR		0x422
+#define ADE9000_LAST_DATA_32	0x423
+#define ADE9000_ADC_REDIRECT	0x424
+#define ADE9000_CF_LCFG		0x425
+#define ADE9000_PART_ID		0x472
+#define ADE9000_TEMP_TRIM	0x474
+#define ADE9000_RUN         0x480
+#define ADE9000_CONFIG1		0x481
+#define ADE9000_ANGL_VA_VB	0x482
+#define ADE9000_ANGL_VB_VC	0x483
+#define ADE9000_ANGL_VA_VC	0x484
+#define ADE9000_ANGL_VA_IA	0x485
+#define ADE9000_ANGL_VB_IB	0x486
+#define ADE9000_ANGL_VC_IC	0x487
+#define ADE9000_ANGL_IA_IB	0x488
+#define ADE9000_ANGL_IB_IC	0x489
+#define ADE9000_ANGL_IA_IC	0x48A
+#define ADE9000_DIP_CYC		0x48B
+#define ADE9000_SWELL_CYC	0x48C
+#define ADE9000_OISTATUS	0x48F
+#define ADE9000_CFMODE		0x490
+#define ADE9000_COMPMODE	0x491
+#define ADE9000_ACCMODE		0x492
+#define ADE9000_CONFIG3		0x493
+#define ADE9000_CF1DEN		0x494
+#define ADE9000_CF2DEN		0x495
+#define ADE9000_CF3DEN		0x496
+#define ADE9000_CF4DEN		0x497
+#define ADE9000_ZXTOUT		0x498
+#define ADE9000_ZXTHRSH		0x499
+#define ADE9000_ZX_LP_SEL	0x49A
+#define ADE9000_SEQ_CYC		0x49C
+#define ADE9000_PHSIGN		0x49D
+#define ADE9000_WFB_CFG		0x4A0
+#define ADE9000_WFB_PG_IRQEN	0x4A1
+#define ADE9000_WFB_TRG_CFG	0x4A2
+#define ADE9000_WFB_TRG_STAT	0x4A3
+#define ADE9000_CONFIG5		0x4A4
+#define ADE9000_CRC_RSLT	0x4A8
+#define ADE9000_CRC_SPI		0x4A9
+#define ADE9000_LAST_DATA_16	0x4AC
+#define ADE9000_LAST_CMD	0x4AE
+#define ADE9000_CONFIG2		0x4AF
+#define ADE9000_EP_CFG		0x4B0
+#define ADE9000_PWR_TIME	0x4B1
+#define ADE9000_EGY_TIME	0x4B2
+#define ADE9000_CRC_FORCE	0x4B4
+#define ADE9000_CRC_OPTEN	0x4B5
+#define ADE9000_TEMP_CFG	0x4B6
+#define ADE9000_TEMP_RSLT	0x4B7
+#define ADE9000_PSM2_CFG	0x4B8
+#define ADE9000_PGA_GAIN	0x4B9
+#define ADE9000_CHNL_DIS	0x4BA
+#define ADE9000_WR_LOCK		0x4BF
+#define ADE9000_VAR_DIS		0x4E0
+#define ADE9000_RESERVED1	0x4F0
+#define ADE9000_VERSION		0x4FE
+#define ADE9000_AI_SINC_DAT	0x500
+#define ADE9000_AV_SINC_DAT	0x501
+#define ADE9000_BI_SINC_DAT	0x502
+#define ADE9000_BV_SINC_DAT	0x503
+#define ADE9000_CI_SINC_DAT	0x504
+#define ADE9000_CV_SINC_DAT	0x505
+#define ADE9000_NI_SINC_DAT	0x506
+#define ADE9000_AI_LPF_DAT	0x510
+#define ADE9000_AV_LPF_DAT	0x511
+#define ADE9000_BI_LPF_DAT	0x512
+#define ADE9000_BV_LPF_DAT	0x513
+#define ADE9000_CI_LPF_DAT	0x514
+#define ADE9000_CV_LPF_DAT	0x515
+#define ADE9000_NI_LPF_DAT	0x516
+#define ADE9000_AV_PCF_1	0x600
+#define ADE9000_BV_PCF_1	0x601
+#define ADE9000_CV_PCF_1	0x602
+#define ADE9000_NI_PCF_1	0x603
+#define ADE9000_AI_PCF_1	0x604
+#define ADE9000_BI_PCF_1	0x605
+#define ADE9000_CI_PCF_1	0x606
+#define ADE9000_AIRMS_1		0x607
+#define ADE9000_BIRMS_1		0x608
+#define ADE9000_CIRMS_1		0x609
+#define ADE9000_AVRMS_1		0x60A
+#define ADE9000_BVRMS_1		0x60B
+#define ADE9000_CVRMS_1		0x60C
+#define ADE9000_NIRMS_1		0x60D
+#define ADE9000_AWATT_1		0x60E
+#define ADE9000_BWATT_1		0x60F
+#define ADE9000_CWATT_1		0x610
+#define ADE9000_AVA_1		0x611
+#define ADE9000_BVA_1		0x612
+#define ADE9000_CVA_1		0x613
+#define ADE9000_AVAR_1		0x614
+#define ADE9000_BVAR_1		0x615
+#define ADE9000_CVAR_1		0x616
+#define ADE9000_AFVAR_1		0x617
+#define ADE9000_BFVAR_1		0x618
+#define ADE9000_CFVAR_1		0x619
+#define ADE9000_APF_1		0x61A
+#define ADE9000_BPF_1		0x61B
+#define ADE9000_CPF_1		0x61C
+#define ADE9000_AVTHD_1		0x61D
+#define ADE9000_BVTHD_1		0x61E
+#define ADE9000_CVTHD_1		0x61F
+#define ADE9000_AITHD_1		0x620
+#define ADE9000_BITHD_1		0x621
+#define ADE9000_CITHD_1		0x622
+#define ADE9000_AFWATT_1	0x623
+#define ADE9000_BFWATT_1	0x624
+#define ADE9000_CFWATT_1	0x625
+#define ADE9000_AFVA_1		0x626
+#define ADE9000_BFVA_1		0x627
+#define ADE9000_CFVA_1		0x628
+#define ADE9000_AFIRMS_1	0x629
+#define ADE9000_BFIRMS_1	0x62A
+#define ADE9000_CFIRMS_1	0x62B
+#define ADE9000_AFVRMS_1	0x62C
+#define ADE9000_BFVRMS_1	0x62D
+#define ADE9000_CFVRMS_1	0x62E
+#define ADE9000_AIRMSONE_1	0x62F
+#define ADE9000_BIRMSONE_1	0x630
+#define ADE9000_CIRMSONE_1	0x631
+#define ADE9000_AVRMSONE_1	0x632
+#define ADE9000_BVRMSONE_1	0x633
+#define ADE9000_CVRMSONE_1	0x634
+#define ADE9000_NIRMSONE_1	0x635
+#define ADE9000_AIRMS1012_1	0x636
+#define ADE9000_BIRMS1012_1	0x637
+#define ADE9000_CIRMS1012_1	0x638
+#define ADE9000_AVRMS1012_1	0x639
+#define ADE9000_BVRMS1012_1	0x63A
+#define ADE9000_CVRMS1012_1	0x63B
+#define ADE9000_NIRMS1012_1	0x63C
+#define ADE9000_AV_PCF_2	0x680
+#define ADE9000_AI_PCF_2	0x681
+#define ADE9000_AIRMS_2		0x682
+#define ADE9000_AVRMS_2		0x683
+#define ADE9000_AWATT_2		0x684
+#define ADE9000_AVA_2		0x685
+#define ADE9000_AVAR_2		0x686
+#define ADE9000_AFVAR_2		0x687
+#define ADE9000_APF_2		0x688
+#define ADE9000_AVTHD_2		0x689
+#define ADE9000_AITHD_2		0x68A
+#define ADE9000_AFWATT_2	0x68B
+#define ADE9000_AFVA_2		0x68C
+#define ADE9000_AFIRMS_2	0x68D
+#define ADE9000_AFVRMS_2	0x68E
+#define ADE9000_AIRMSONE_2	0x68F
+#define ADE9000_AVRMSONE_2	0x690
+#define ADE9000_AIRMS1012_2	0x691
+#define ADE9000_AVRMS1012_2	0x692
+#define ADE9000_BV_PCF_2	0x693
+#define ADE9000_BI_PCF_2	0x694
+#define ADE9000_BIRMS_2		0x695
+#define ADE9000_BVRMS_2		0x696
+#define ADE9000_BWATT_2		0x697
+#define ADE9000_BVA_2		0x698
+#define ADE9000_BVAR_2		0x699
+#define ADE9000_BFVAR_2		0x69A
+#define ADE9000_BPF_2		0x69B
+#define ADE9000_BVTHD_2		0x69C
+#define ADE9000_BITHD_2		0x69D
+#define ADE9000_BFWATT_2	0x69E
+#define ADE9000_BFVA_2		0x69F
+#define ADE9000_BFIRMS_2	0x6A0
+#define ADE9000_BFVRMS_2	0x6A1
+#define ADE9000_BIRMSONE_2	0x6A2
+#define ADE9000_BVRMSONE_2	0x6A3
+#define ADE9000_BIRMS1012_2	0x6A4
+#define ADE9000_BVRMS1012_2	0x6A5
+#define ADE9000_CV_PCF_2	0x6A6
+#define ADE9000_CI_PCF_2	0x6A7
+#define ADE9000_CIRMS_2		0x6A8
+#define ADE9000_CVRMS_2		0x6A9
+#define ADE9000_CWATT_2		0x6AA
+#define ADE9000_CVA_2		0x6AB
+#define ADE9000_CVAR_2		0x6AC
+#define ADE9000_CFVAR_2		0x6AD
+#define ADE9000_CPF_2		0x6AE
+#define ADE9000_CVTHD_2		0x6AF
+#define ADE9000_CITHD_2		0x6B0
+#define ADE9000_CFWATT_2	0x6B1
+#define ADE9000_CFVA_2		0x6B2
+#define ADE9000_CFIRMS_2	0x6B3
+#define ADE9000_CFVRMS_2	0x6B4
+#define ADE9000_CIRMSONE_2	0x6B5
+#define ADE9000_CVRMSONE_2	0x6B6
+#define ADE9000_CIRMS1012_2	0x6B7
+#define ADE9000_CVRMS1012_2	0x6B8
+#define ADE9000_NI_PCF_2	0x6B9
+#define ADE9000_NIRMS_2		0x6BA
+#define ADE9000_NIRMSONE_2	0x6BB
+#define ADE9000_NIRMS1012_2	0x6BC
+
+#define ADE9000_CHIP_VERSION	0x00FE
+#define ADE9000_CHIP_ID		0b00100000
+#define ADE9000_MAX_TX		6
+#define ADE9000_MAX_RX		6
+#define ADE9000_STARTUP_DELAY	500
+
+#define ADE9000_SPI_SLOW	(u32)(500 * 1000)
+#define ADE9000_SPI_BURST	(u32)(1000 * 1000)
+#define ADE9000_SPI_FAST	(u32)(1500 * 1000)
+#define IRQ_ENABLE false
+
+/**
+ * struct ade9000_state - device instance specific data
+ * @spi:		actual spi_device
+ * @buf_lock:		mutex to protect tx and rx
+ * @tx:			transmit buffer
+ * @rx:			receive buffer
+ **/
+struct ade9000_state {
+	struct spi_device	*spi;
+	struct mutex		buf_lock;
+	int (*read_reg)(struct ade9000_state *st, u16 addr, u32 *val, int bits);
+	int (*write_reg)(struct ade9000_state *st, u16 addr, u32 val, int bits);
+	int irq; // unused
+	int run; // unused
+	u8 tx[ADE9000_MAX_TX] ____cacheline_aligned;
+	u8 rx[ADE9000_MAX_RX];
+};
+
+static int ade9000_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val,
+			    int *val2,
+			    long mask);
+static int ade9000_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val,
+			     int val2,
+			     long mask);
+static int ade9000_spi_read(struct ade9000_state *st,
+			    u16 addr,
+			    u32 *val,
+			    int bits);
+static int ade9000_spi_write(struct ade9000_state *st,
+			     u16 addr,
+			     u32 val,
+			     int bits);
+
+static int ade9000_probe(struct spi_device *spi);
+static int ade9000_init_info(struct ade9000_state *st);
+static int ade9000_set_irq(struct ade9000_state *st, bool enable);
+static int ade9000_reset(struct ade9000_state *st);
+
+static ssize_t ade9000_set_attr(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf,
+				size_t s);
+static ssize_t ade9000_get_attr(struct device *dev,
+				struct device_attribute *attr,
+				char *buf);
+
+static int ade9000_voltage_processed(struct ade9000_state *st,
+				     u16 address,
+				     u32 *val);
+static int ade9000_current_processed(struct ade9000_state *st,
+				     u16 address,
+				     u32 *val);
+#endif
diff --git a/drivers/staging/iio/meter/ade9000_chan.h b/drivers/staging/iio/meter/ade9000_chan.h
new file mode 100644
index 000000000000..068ade190b20
--- /dev/null
+++ b/drivers/staging/iio/meter/ade9000_chan.h
@@ -0,0 +1,217 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ADE9000_CHAN_H
+#define _ADE9000_CHAN_H
+
+#include <linux/iio/sysfs.h>
+
+#define ADE9000_CHANNEL(_type, _desc, _channel, _phase) \
+	ADE9000_## _type ## _ ## _desc(_channel, _phase)
+
+#define ADE9000_VOLTAGE_IN(_channel, _phase) { \
+	.type = IIO_ALTVOLTAGE, \
+	.indexed = 1, \
+	.channel = _channel, \
+	.address = ADE9000_ ## _phase ## VRMS, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.output = 0 \
+}
+
+#define ADE9000_VOLTAGE_SCALE(_channel, _phase) { \
+	.type = IIO_ALTVOLTAGE, \
+	.indexed = 1, \
+	.channel = _channel, \
+	.address = ADE9000_ ## _phase ## VGAIN, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE), \
+	.output = 1 \
+}
+
+#define ADE9000_VOLTAGE_OS(_channel, _phase) { \
+	.type = IIO_ALTVOLTAGE, \
+	.indexed = 1, \
+	.channel = _channel, \
+	.address = ADE9000_ ## _phase ## VRMSOS, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_OFFSET), \
+	.output = 1 \
+}
+
+#define ADE9000_CURRENT_IN(_channel, _phase) { \
+	.type = IIO_CURRENT, \
+	.indexed = 1, \
+	.channel = _channel, \
+	.address = ADE9000_ ## _phase ## IRMS, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.output = 0 \
+}
+
+#define ADE9000_CURRENT_SCALE(_channel, _phase) { \
+	.type = IIO_CURRENT, \
+	.indexed = 1, \
+	.channel = _channel, \
+	.address = ADE9000_ ## _phase ## IGAIN, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE), \
+	.output = 1 \
+}
+
+#define ADE9000_CURRENT_OS(_channel, _phase) { \
+	.type = IIO_CURRENT, \
+	.indexed = 1, \
+	.channel = _channel, \
+	.address = ADE9000_ ## _phase ## IRMSOS, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_OFFSET), \
+	.output = 1 \
+}
+
+#define ADE9000_POWER_IN(_channel, _phase) { \
+	.type = IIO_POWER, \
+	.indexed = 1, \
+	.channel = _channel, \
+	.address = ADE9000_ ## _phase ## WATT_ACC, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.output = 0 \
+}
+
+#define ADE9000_POWER_SCALE(_channel, _phase) { \
+	.type = IIO_POWER, \
+	.indexed = 1, \
+	.channel = _channel, \
+	.address = ADE9000_ ## _phase ## PGAIN, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE), \
+	.output = 1 \
+}
+
+#define ADE9000_WATT_OS(_channel, _phase) { \
+	.type = IIO_POWER, \
+	.modified = 1, \
+	.channel2 = IIO_MOD_X, \
+	.indexed = 1, \
+	.channel = _channel, \
+	.address = ADE9000_ ## _phase ## WATTOS, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_OFFSET), \
+	.output = 1 \
+}
+
+#define ADE9000_VAR_OS(_channel, _phase) { \
+	.type = IIO_POWER, \
+	.modified = 1, \
+	.channel2 = IIO_MOD_Y, \
+	.indexed = 1, \
+	.channel = _channel, \
+	.address = ADE9000_ ## _phase ## VAROS, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_OFFSET), \
+	.output = 1 \
+}
+
+#define ADE9000_PHASE_CAL(_channel, _phase) { \
+	.type = IIO_PHASE, \
+	.indexed = 1, \
+	.channel = _channel, \
+	.address = ADE9000_ ## _phase ## PHCAL0, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.output = 1 \
+}
+
+#define ADE9000_WAHR_IN(_channel, _phase) { \
+	.type = IIO_ENERGY, \
+	.modified = 1, \
+	.channel2 = IIO_MOD_X, \
+	.indexed = 1, \
+	.channel = _channel, \
+	.address = ADE9000_ ## _phase ## WATTHR_HI, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.output = 0 \
+}
+
+#define ADE9000_VAHR_IN(_channel, _phase) { \
+	.type = IIO_ENERGY, \
+	.modified = 1, \
+	.channel2 = IIO_MOD_Y, \
+	.indexed = 1, \
+	.channel = _channel, \
+	.address = ADE9000_ ## _phase ## VARHR_HI, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.output = 0 \
+}
+
+static IIO_CONST_ATTR(name, "ade9000");
+static IIO_DEVICE_ATTR(run, 0660,
+		       ade9000_get_attr, ade9000_set_attr, ADE9000_RUN);
+static IIO_DEVICE_ATTR(pwr_time, 0660,
+		       ade9000_get_attr, ade9000_set_attr, ADE9000_PWR_TIME);
+static IIO_DEVICE_ATTR(ep_cfg, 0660,
+		       ade9000_get_attr, ade9000_set_attr, ADE9000_EP_CFG);
+static IIO_DEVICE_ATTR(egy_time, 0660,
+		       ade9000_get_attr, ade9000_set_attr, ADE9000_EGY_TIME);
+static IIO_DEVICE_ATTR(zx_sel, 0660,
+		       ade9000_get_attr, ade9000_set_attr, ADE9000_ZX_LP_SEL);
+
+enum ade9000_phases {
+	ADE9000_N = 0,
+	ADE9000_A,
+	ADE9000_B,
+	ADE9000_C,
+};
+
+/*
+ * ADE9000_CHANNEL(_type, _desc, _channel, _phase)
+ * _type    iio channel type
+ * _desc    ade9000 channel *type* of register (eg. offset, gain, input, ...)
+ * _channel enum ade9000_phases
+ * _phase   'name' of phase
+ */
+static const struct iio_chan_spec ade9000_channels[] = {
+	ADE9000_CHANNEL(VOLTAGE, IN,    ADE9000_A, A),
+	ADE9000_CHANNEL(VOLTAGE, SCALE, ADE9000_A, A),
+	ADE9000_CHANNEL(VOLTAGE, OS,    ADE9000_A, A),
+	ADE9000_CHANNEL(CURRENT, IN,    ADE9000_A, A),
+	ADE9000_CHANNEL(CURRENT, SCALE, ADE9000_A, A),
+	ADE9000_CHANNEL(CURRENT, OS,    ADE9000_A, A),
+	ADE9000_CHANNEL(POWER,   IN,    ADE9000_A, A),
+	ADE9000_CHANNEL(POWER,   SCALE, ADE9000_A, A),
+	ADE9000_CHANNEL(WATT,    OS,    ADE9000_A, A),
+	ADE9000_CHANNEL(VAR,     OS,    ADE9000_A, A),
+	ADE9000_CHANNEL(WAHR,    IN,    ADE9000_A, A),
+	ADE9000_CHANNEL(VAHR,    IN,    ADE9000_A, A),
+	ADE9000_CHANNEL(PHASE,   CAL,   ADE9000_A, A),
+
+	ADE9000_CHANNEL(VOLTAGE, IN,    ADE9000_B, B),
+	ADE9000_CHANNEL(VOLTAGE, SCALE, ADE9000_B, B),
+	ADE9000_CHANNEL(VOLTAGE, OS,    ADE9000_B, B),
+	ADE9000_CHANNEL(CURRENT, IN,    ADE9000_B, B),
+	ADE9000_CHANNEL(CURRENT, SCALE, ADE9000_B, B),
+	ADE9000_CHANNEL(CURRENT, OS,    ADE9000_B, B),
+	ADE9000_CHANNEL(POWER,   IN,    ADE9000_B, B),
+	ADE9000_CHANNEL(POWER,   SCALE, ADE9000_B, B),
+	ADE9000_CHANNEL(WATT,    OS,    ADE9000_B, B),
+	ADE9000_CHANNEL(VAR,     OS,    ADE9000_B, B),
+	ADE9000_CHANNEL(WAHR,    IN,    ADE9000_B, B),
+	ADE9000_CHANNEL(VAHR,    IN,    ADE9000_B, B),
+	ADE9000_CHANNEL(PHASE,   CAL,   ADE9000_B, B),
+
+	ADE9000_CHANNEL(VOLTAGE, IN,    ADE9000_C, C),
+	ADE9000_CHANNEL(VOLTAGE, SCALE, ADE9000_C, C),
+	ADE9000_CHANNEL(VOLTAGE, OS,    ADE9000_C, C),
+	ADE9000_CHANNEL(CURRENT, IN,    ADE9000_C, C),
+	ADE9000_CHANNEL(CURRENT, SCALE, ADE9000_C, C),
+	ADE9000_CHANNEL(CURRENT, OS,    ADE9000_C, C),
+	ADE9000_CHANNEL(POWER,   IN,    ADE9000_C, C),
+	ADE9000_CHANNEL(POWER,   SCALE, ADE9000_C, C),
+	ADE9000_CHANNEL(WATT,    OS,    ADE9000_C, C),
+	ADE9000_CHANNEL(VAR,     OS,    ADE9000_C, C),
+	ADE9000_CHANNEL(WAHR,    IN,    ADE9000_C, C),
+	ADE9000_CHANNEL(VAHR,    IN,    ADE9000_C, C),
+	ADE9000_CHANNEL(PHASE,   CAL,   ADE9000_C, C),
+	{
+		.type = IIO_VOLTAGE,
+		.address = ADE9000_VLEVEL,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.output = 1,
+	},
+	{
+		.type = IIO_TEMP,
+		.address = ADE9000_TEMP_RSLT,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+	},
+};
+
+#endif
-- 
2.17.1

