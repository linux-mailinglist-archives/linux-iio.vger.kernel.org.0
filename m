Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEA92208B9
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jul 2020 11:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbgGOJ2V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jul 2020 05:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730249AbgGOJ2U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jul 2020 05:28:20 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A577C061755;
        Wed, 15 Jul 2020 02:28:20 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l63so2779137pge.12;
        Wed, 15 Jul 2020 02:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o2+VMsOTm1wpjTk++9eZZTe0kG8BcKDnSfegJMXQmzM=;
        b=lTriWVLAb1I2R6jxXo6R+CNiyFX/kB8gQwPtSkWli/1dhGTE3BAuHy8OUorylo/jf5
         HwZMwp/yL+hlkDkgJIYmvDubGiPHzy6/iOzVZc4RjkSLhumuZ1JvTX7cPCMMS5X68cF8
         ydT4jT00soa+veRrok3q+xviSjpJYgOASPJ2lbRUVxzTsaThqWcna/Dav8O1dyM6gRX3
         ePt1PU3H7rGILthnxe6qn5N6/EDVYSDUQEjmrIWRtvFYx8uIGL+5LlRV1AfMy3RxM1Py
         UmfXW1ixKyKqI88qBg9HxMlxswUdfKWoW8+Ej/1n0n45859kKGWZq2RbzqHpKpoQ/uog
         WFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o2+VMsOTm1wpjTk++9eZZTe0kG8BcKDnSfegJMXQmzM=;
        b=a+YOsOLIDzdPPgTGivXabglPlr6m1MoXXIcWVItemjfrwtFpg4N0UH6R/V1brsx1e9
         v7B8Ll8tOTVJJKdPp8ET92TKsSs+TX/32rMLnVeSAvwkZaf8WeIBkSIqFVu3EOgBhnnv
         miIIXmF1O5o0vHah5+Xofh420MaIIaVlPodV3EmOoNhE+k+Pe/sEe61ssyR3aUDJcgWo
         i1YPZIjUoIXoiOm33w3Afn3Lcw6cN714l/gv7+sjc4ZnKundJGRFb2EfD5z5Rm9jPTUB
         9ufKEe+d0s66btIyaFJ+uL0e6dxzmceUXjIqik3MbuOTlLcqMm8TG8wNjAcUMVGtGA3c
         If9w==
X-Gm-Message-State: AOAM532WuQAG5MZLg+mCEGDlUins7MAnfRKSxeZ4LH6OtIR6BGMQs4Nh
        f1gtjAOe6S5UMAzI6RkdyXw=
X-Google-Smtp-Source: ABdhPJxkWEHL4P+xTXKfPgM9XYFGzAtpupoFLhlw5+fpSRzRTFYTd/PFVtCAuZj6CLlMcPrAFrkjCw==
X-Received: by 2002:a62:fb07:: with SMTP id x7mr8435849pfm.252.1594805300046;
        Wed, 15 Jul 2020 02:28:20 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:6188:2bbe:d028:8959:a8a3:a7bc])
        by smtp.gmail.com with ESMTPSA id oc6sm1590428pjb.43.2020.07.15.02.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 02:28:19 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org
Cc:     dragos.bogdan@analog.com, darius.berghe@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: [PATCH 1/2] iio: gyro: Add driver support for ADXRS290
Date:   Wed, 15 Jul 2020 14:57:57 +0530
Message-Id: <20200715092757.14563-1-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

ADXRS290 is a high performance MEMS pitch and roll (dual-axis in-plane)
angular rate sensor (gyroscope) designed for use in stabilization
applications. It also features an internal temperature sensor and
programmable high-pass and low-pass filters.

Add support for ADXRS290 in direct-access mode for now.

Datasheet:
Link: https://www.analog.com/media/en/technical-documentation/data-sheets/ADXRS290.pdf

Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
---
 MAINTAINERS                 |   6 +
 drivers/iio/gyro/Kconfig    |  10 +
 drivers/iio/gyro/Makefile   |   1 +
 drivers/iio/gyro/adxrs290.c | 490 ++++++++++++++++++++++++++++++++++++
 4 files changed, 507 insertions(+)
 create mode 100644 drivers/iio/gyro/adxrs290.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e016ee39c74a..dd02cfc410e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1098,6 +1098,12 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/i2c/adv7842*
 
+ANALOG DEVICES INC ADXRS290 DRIVER
+M:	Nishant Malpani <nish.malpani25@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	drivers/iio/gyro/adxrs290.c
+
 ANALOG DEVICES INC ASOC CODEC DRIVERS
 M:	Lars-Peter Clausen <lars@metafoo.de>
 M:	Nuno Sá <nuno.sa@analog.com>
diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
index 6daeddf37f60..024a34139875 100644
--- a/drivers/iio/gyro/Kconfig
+++ b/drivers/iio/gyro/Kconfig
@@ -41,6 +41,16 @@ config ADIS16260
 	  This driver can also be built as a module.  If so, the module
 	  will be called adis16260.
 
+config ADXRS290
+	tristate "Analog Devices ADXRS290 Dual-Axis MEMS Gyroscope SPI driver"
+	depends on SPI
+	help
+	  Say yes here to build support for Analog Devices ADXRS290 programmable
+	  digital output gyroscope.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called adxrs290.
+
 config ADXRS450
 	tristate "Analog Devices ADXRS450/3 Digital Output Gyroscope SPI driver"
 	depends on SPI
diff --git a/drivers/iio/gyro/Makefile b/drivers/iio/gyro/Makefile
index 45cbd5dc644e..0319b397dc3f 100644
--- a/drivers/iio/gyro/Makefile
+++ b/drivers/iio/gyro/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_ADIS16080) += adis16080.o
 obj-$(CONFIG_ADIS16130) += adis16130.o
 obj-$(CONFIG_ADIS16136) += adis16136.o
 obj-$(CONFIG_ADIS16260) += adis16260.o
+obj-$(CONFIG_ADXRS290) += adxrs290.o
 obj-$(CONFIG_ADXRS450) += adxrs450.o
 obj-$(CONFIG_BMG160) += bmg160_core.o
 obj-$(CONFIG_BMG160_I2C) += bmg160_i2c.o
diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
new file mode 100644
index 000000000000..1139f79a3bd5
--- /dev/null
+++ b/drivers/iio/gyro/adxrs290.c
@@ -0,0 +1,490 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ADXRS290 SPI Gyroscope Driver
+ *
+ * Copyright (C) 2020 Analog Devices, Inc.
+ */
+
+#include <asm/unaligned.h>
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+
+#define ADXRS290_ADI_ID		0xAD
+#define ADXRS290_MEMS_ID	0x1D
+#define ADXRS290_DEV_ID		0x92
+
+#define ADXRS290_REG_ADI_ID	0x00 /* Analog Devices Identifier Register */
+#define ADXRS290_REG_MEMS_ID	0x01 /* MEMS Identifier Register */
+#define ADXRS290_REG_DEV_ID	0x02 /* Device Identifier Register */
+#define ADXRS290_REG_REV_ID	0x03 /* Silicon Revision Number Register */
+#define ADXRS290_REG_SN0	0x04 /* Serial Number Registers, 4 bytes */
+#define ADXRS290_REG_DATAX0	0x08 /* Roll Rate o/p Data Regs, 2 bytes */
+#define ADXRS290_REG_DATAY0	0x0A /* Pitch Rate o/p Data Regs, 2 bytes */
+#define ADXRS290_REG_TEMP0	0x0C /* Temperature Data Registers, 2 bytes */
+#define ADXRS290_REG_POWER_CTL	0x10 /* Power Control Register */
+#define ADXRS290_REG_FILTER	0x11 /* Band-pass Filter Register */
+#define ADXRS290_REG_DATA_RDY	0x12 /* Data Ready Register */
+
+#define ADXRS290_READ		BIT(7)
+#define ADXRS290_TSM		BIT(0)
+#define ADXRS290_MEASUREMENT	BIT(1)
+#define ADXRS290_SYNC		GENMASK(1, 0)
+#define ADXRS290_LPF_MASK	GENMASK(2, 0)
+#define ADXRS290_LPF(x)		FIELD_PREP(ADXRS290_LPF_MASK, x)
+#define ADXRS290_HPF_MASK	GENMASK(7, 4)
+#define ADXRS290_HPF(x)		FIELD_PREP(ADXRS290_HPF_MASK, x)
+
+#define ADXRS290_READ_REG(reg)	(ADXRS290_READ | (reg))
+
+#define ADXRS290_MAX_TRANSITION_TIME_MS 100
+
+enum adxrs290_mode {
+	STANDBY,
+	MEASUREMENT,
+};
+
+struct adxrs290_state {
+	struct spi_device	*spi;
+	/* To atomize successive reads for single measurement */
+	struct mutex		lock;
+	enum adxrs290_mode	mode;
+	unsigned int		lpf_3db_freq_idx;
+	unsigned int		hpf_3db_freq_idx;
+	union {
+		u8 tx;
+		u8 rx[2];
+	}			data ____cacheline_aligned;
+};
+
+/*
+ * Available cut-off frequencies of the low pass filter in Hz.
+ * The integer part and fractional part are represented separately.
+ */
+static const unsigned int adxrs290_lpf_3db_freq_tbl[][2] = {
+	[0] = {480, 0},
+	[1] = {320, 0},
+	[2] = {160, 0},
+	[3] = {80, 0},
+	[4] = {56, 600},
+	[5] = {40, 0},
+	[6] = {28, 300},
+	[7] = {20, 0},
+};
+
+/*
+ * Available cut-off frequencies of the high pass filter in Hz.
+ * The integer part and fractional part are represented separately.
+ */
+static const unsigned int adxrs290_hpf_3db_freq_tbl[][2] = {
+	[0] = {0, 0},
+	[1] = {0, 11},
+	[2] = {0, 22},
+	[3] = {0, 44},
+	[4] = {0, 87},
+	[5] = {0, 175},
+	[6] = {0, 350},
+	[7] = {0, 700},
+	[8] = {1, 400},
+	[9] = {2, 800},
+	[10] = {11, 300},
+};
+
+static int adxrs290_spi_read16b(struct iio_dev *indio_dev, const u8 cmd,
+				u16 *val)
+{
+	struct adxrs290_state *st = iio_priv(indio_dev);
+	int ret = 0;
+
+	struct spi_transfer t[] = {
+		{
+			.tx_buf = &st->data.tx,
+			.bits_per_word = 8,
+			.len = sizeof(st->data.tx),
+			.cs_change = 0,
+		}, {
+			.rx_buf = &st->data.rx,
+			.bits_per_word = 8,
+			.len = sizeof(st->data.rx),
+		},
+	};
+
+	mutex_lock(&st->lock);
+
+	st->data.tx = cmd;
+	ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
+
+	if (ret < 0) {
+		dev_err(&st->spi->dev, "error reading 16b from reg 0x%02x\n",
+			cmd);
+		goto err_unlock;
+	}
+
+	*val = get_unaligned_le16(st->data.rx);
+
+err_unlock:
+	mutex_unlock(&st->lock);
+	return ret;
+}
+
+static int adxrs290_get_rate_data(struct iio_dev *indio_dev, const u8 cmd,
+				  unsigned int *val)
+{
+	int ret;
+	u16 temp;
+
+	ret = adxrs290_spi_read16b(indio_dev, cmd, &temp);
+	if (ret < 0)
+		return ret;
+
+	*val = temp;
+
+	return 0;
+}
+
+static int adxrs290_get_temp_data(struct iio_dev *indio_dev, unsigned int *val)
+{
+	const u8 cmd = ADXRS290_READ_REG(ADXRS290_REG_TEMP0);
+	int ret;
+	u16 temp;
+
+	ret = adxrs290_spi_read16b(indio_dev, cmd, &temp);
+	if (ret < 0)
+		return ret;
+
+	/* extract lower 12 bits temperature reading */
+	*val = temp & 0x0FFF;
+
+	return 0;
+}
+
+static int adxrs290_get_3db_freq(struct iio_dev *indio_dev, u8 *val, u8 *val2)
+{
+	struct adxrs290_state *st = iio_priv(indio_dev);
+	const u8 cmd = ADXRS290_READ_REG(ADXRS290_REG_FILTER);
+	int temp;
+
+	temp = spi_w8r8(st->spi, cmd);
+	if (temp < 0)
+		return temp;
+
+	*val = FIELD_GET(ADXRS290_LPF_MASK, temp);
+	*val2 = FIELD_GET(ADXRS290_HPF_MASK, temp);
+
+	return 0;
+}
+
+static int adxrs290_spi_write_reg(struct spi_device *spi, const u8 reg,
+				  const u8 val)
+{
+	u8 buf[2];
+
+	buf[0] = reg;
+	buf[1] = val;
+
+	return spi_write(spi, buf, ARRAY_SIZE(buf));
+}
+
+static unsigned int adxrs290_find_best_match(const unsigned int (*freq_tbl)[2],
+					     unsigned int n, unsigned int freq)
+{
+	unsigned int i, best_freq_idx;
+	unsigned int diff, best_diff;
+
+	best_freq_idx = 0;
+	best_diff = UINT_MAX;
+	for (i = 0; i < n; i++) {
+		diff = abs(freq_tbl[i][0] - freq);
+		if (diff < best_diff) {
+			best_diff = diff;
+			best_freq_idx = i;
+		}
+	}
+
+	return best_freq_idx;
+}
+
+static int adxrs290_set_filter_freq(struct iio_dev *indio_dev,
+				    unsigned int lpf_idx, unsigned int hpf_idx)
+{
+	struct adxrs290_state *st = iio_priv(indio_dev);
+	u8 val;
+
+	val = ADXRS290_HPF(hpf_idx) | ADXRS290_LPF(lpf_idx);
+
+	return adxrs290_spi_write_reg(st->spi, ADXRS290_REG_FILTER, val);
+}
+
+static ssize_t adxrs290_show_avail(const unsigned int (*freq_tbl)[2], size_t n,
+				   char *buf)
+{
+	ssize_t len = 0;
+	int i;
+
+	for (i = 0; i < n; i++) {
+		len += scnprintf(buf + len, PAGE_SIZE - len,
+				 "%u.%03u ", freq_tbl[i][0], freq_tbl[i][1]);
+	}
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
+static ssize_t adxrs290_show_lpf_freq_avail(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	return adxrs290_show_avail(adxrs290_lpf_3db_freq_tbl,
+				   ARRAY_SIZE(adxrs290_lpf_3db_freq_tbl), buf);
+}
+
+static ssize_t adxrs290_show_hpf_freq_avail(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	return adxrs290_show_avail(adxrs290_hpf_3db_freq_tbl,
+				   ARRAY_SIZE(adxrs290_hpf_3db_freq_tbl), buf);
+}
+
+/* attribute to display available 3db frequencies for the low-pass filter */
+static IIO_DEVICE_ATTR(in_anglvel_filter_low_pass_3db_frequency_available,
+		       0444, adxrs290_show_lpf_freq_avail, NULL, 0);
+
+/* attribute to display available 3db frequencies for the high-pass filter */
+static IIO_DEVICE_ATTR(in_anglvel_filter_high_pass_3db_frequency_available,
+		       0444, adxrs290_show_hpf_freq_avail, NULL, 0);
+
+static struct attribute *adxrs290_attributes[] = {
+	&iio_dev_attr_in_anglvel_filter_low_pass_3db_frequency_available.dev_attr.attr,
+	&iio_dev_attr_in_anglvel_filter_high_pass_3db_frequency_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group adxrs290_attrs_group = {
+	.attrs = adxrs290_attributes,
+};
+
+static int adxrs290_initial_setup(struct iio_dev *indio_dev)
+{
+	struct adxrs290_state *st = iio_priv(indio_dev);
+
+	st->mode = MEASUREMENT;
+
+	return adxrs290_spi_write_reg(st->spi,
+				      ADXRS290_REG_POWER_CTL,
+				      ADXRS290_MEASUREMENT | ADXRS290_TSM);
+}
+
+static int adxrs290_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val,
+			     int *val2,
+			     long mask)
+{
+	struct adxrs290_state *st = iio_priv(indio_dev);
+	int ret;
+	unsigned int t;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_ANGL_VEL:
+			ret = adxrs290_get_rate_data(indio_dev,
+						     ADXRS290_READ_REG(chan->address),
+						     &t);
+			if (ret < 0)
+				return ret;
+			*val = t;
+			return IIO_VAL_INT;
+		case IIO_TEMP:
+			ret = adxrs290_get_temp_data(indio_dev, &t);
+			if (ret < 0)
+				return ret;
+			*val = t;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_ANGL_VEL:
+			*val = 0;
+			*val2 = 87266;
+			return IIO_VAL_INT_PLUS_NANO;
+		case IIO_TEMP:
+			*val = 100;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		switch (chan->type) {
+		case IIO_ANGL_VEL:
+			t = st->lpf_3db_freq_idx;
+			*val = adxrs290_lpf_3db_freq_tbl[t][0];
+			*val2 = adxrs290_lpf_3db_freq_tbl[t][1] * 1000;
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
+		switch (chan->type) {
+		case IIO_ANGL_VEL:
+			t = st->hpf_3db_freq_idx;
+			*val = adxrs290_hpf_3db_freq_tbl[t][0];
+			*val2 = adxrs290_hpf_3db_freq_tbl[t][1] * 1000;
+			return IIO_VAL_INT_PLUS_MICRO;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int adxrs290_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      int val,
+			      int val2,
+			      long mask)
+{
+	struct adxrs290_state *st = iio_priv(indio_dev);
+	unsigned int lpf_idx, hpf_idx;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		lpf_idx = adxrs290_find_best_match(adxrs290_lpf_3db_freq_tbl,
+						   ARRAY_SIZE(adxrs290_lpf_3db_freq_tbl),
+						   val);
+		/* caching the updated state of the low-pass filter */
+		st->lpf_3db_freq_idx = lpf_idx;
+		/* retrieving the current state of the high-pass filter */
+		hpf_idx = st->hpf_3db_freq_idx;
+		return adxrs290_set_filter_freq(indio_dev, lpf_idx, hpf_idx);
+	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
+		hpf_idx = adxrs290_find_best_match(adxrs290_hpf_3db_freq_tbl,
+						   ARRAY_SIZE(adxrs290_hpf_3db_freq_tbl),
+						   val);
+		/* caching the updated state of the high-pass filter */
+		st->hpf_3db_freq_idx = hpf_idx;
+		/* retrieving the current state of the low-pass filter */
+		lpf_idx = st->lpf_3db_freq_idx;
+		return adxrs290_set_filter_freq(indio_dev, lpf_idx, hpf_idx);
+	}
+
+	return -EINVAL;
+}
+
+#define ADXRS290_ANGL_VEL_CHANNEL(reg, axis) {				\
+	.type = IIO_ANGL_VEL,						\
+	.address = reg,							\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##axis,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
+	BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |		\
+	BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),		\
+}
+
+static const struct iio_chan_spec adxrs290_channels[] = {
+	ADXRS290_ANGL_VEL_CHANNEL(ADXRS290_REG_DATAX0, X),
+	ADXRS290_ANGL_VEL_CHANNEL(ADXRS290_REG_DATAY0, Y),
+	{
+		.type = IIO_TEMP,
+		.address = ADXRS290_REG_TEMP0,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+		BIT(IIO_CHAN_INFO_SCALE),
+	},
+};
+
+static const struct iio_info adxrs290_info = {
+	.attrs = &adxrs290_attrs_group,
+	.read_raw = &adxrs290_read_raw,
+	.write_raw = &adxrs290_write_raw,
+};
+
+static int adxrs290_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct adxrs290_state *st;
+	int ret;
+	u8 val, val2;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+	spi_set_drvdata(spi, indio_dev);
+
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = "adxrs290";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = adxrs290_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adxrs290_channels);
+	indio_dev->info = &adxrs290_info;
+
+	val = spi_w8r8(spi, ADXRS290_READ_REG(ADXRS290_REG_ADI_ID));
+	if (val != ADXRS290_ADI_ID) {
+		dev_err(&spi->dev, "Wrong ADI ID 0x%02x\n", val);
+		return -ENODEV;
+	}
+
+	val = spi_w8r8(spi, ADXRS290_READ_REG(ADXRS290_REG_MEMS_ID));
+	if (val != ADXRS290_MEMS_ID) {
+		dev_err(&spi->dev, "Wrong MEMS ID 0x%02x\n", val);
+		return -ENODEV;
+	}
+
+	val = spi_w8r8(spi, ADXRS290_READ_REG(ADXRS290_REG_DEV_ID));
+	if (val != ADXRS290_DEV_ID) {
+		dev_err(&spi->dev, "Wrong DEV ID 0x%02x\n", val);
+		return -ENODEV;
+	}
+
+	/* default mode the gyroscope starts in */
+	st->mode = STANDBY;
+
+	/* switch to measurement mode and switch on the temperature sensor */
+	ret = adxrs290_initial_setup(indio_dev);
+	if (ret < 0)
+		return ret;
+
+	/* max transition time to measurement mode */
+	msleep_interruptible(ADXRS290_MAX_TRANSITION_TIME_MS);
+
+	ret = adxrs290_get_3db_freq(indio_dev, &val, &val2);
+	if (ret < 0)
+		return ret;
+
+	st->lpf_3db_freq_idx = val;
+	st->hpf_3db_freq_idx = val2;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct of_device_id adxrs290_of_match[] = {
+	{ .compatible = "adi,adxrs290" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, adxrs290_of_match);
+
+static struct spi_driver adxrs290_driver = {
+	.driver = {
+		.name = "adxrs290",
+		.of_match_table = adxrs290_of_match,
+	},
+	.probe = adxrs290_probe,
+};
+module_spi_driver(adxrs290_driver);
+
+MODULE_AUTHOR("Nishant Malpani <nish.malpani25@gmail.com>");
+MODULE_DESCRIPTION("Analog Devices ADXRS290 Gyroscope SPI driver");
+MODULE_LICENSE("GPL");
-- 
2.20.1

