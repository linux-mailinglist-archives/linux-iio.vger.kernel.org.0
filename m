Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654C21A9426
	for <lists+linux-iio@lfdr.de>; Wed, 15 Apr 2020 09:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635136AbgDOHVj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Apr 2020 03:21:39 -0400
Received: from gproxy4-pub.mail.unifiedlayer.com ([69.89.23.142]:58480 "EHLO
        gproxy4-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2635131AbgDOHVi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Apr 2020 03:21:38 -0400
X-Greylist: delayed 1521 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Apr 2020 03:21:36 EDT
Received: from CMGW (unknown [10.9.0.13])
        by gproxy4.mail.unifiedlayer.com (Postfix) with ESMTP id A362A176FCD
        for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2020 00:56:24 -0600 (MDT)
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTP
        id Oby9j6lNrtoKZObyBjkeN7; Wed, 15 Apr 2020 00:56:24 -0600
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.2 cv=AaTBJzfG c=1 sm=1 tr=0
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=LfuyaZh/8e9VOkaVZk0aRw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=cl8xLZFz6L8A:10 a=oz0wMknONp8A:10 a=vU9dKmh3AAAA:8
 a=I3rDmXkFPg_7Nv1lI34A:9 a=KWntJOfHXSHpKsIS:21 a=z28oGt1q3h8XXXqV:21
 a=QEXdDO2ut3YA:10 a=8teeR8OajY8A:10 a=rsP06fVo5MYu2ilr0aT5:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Ug+LY9Kvt/tJkAV/bW2LWX0VIs/cS3dNUMNGI6YE5Mw=; b=SgsHELD0UOWFUYmbfR7XXS+jca
        N0ByllGfc45mhMN/ca1f9zMYezB34762XlVhEfzy6tPiGM78UBEAVnpk+vYqMrkxnpCrJY8W6YvYh
        hYxu2wfNzly4fp9aTtoVVB7atoiWD+DX35vq1GFU8URpcyZdNJHfK4XYX/wETDNeVn2qm3PQPzZTe
        P6BA3UYZfeeaEV6TYJi9cXKBKzMOT4Y6r/FxXXgulYHOuqUVOTtQyvCKqbG7Wcq8z/v55XKXMpkXs
        5RZnEKuWIDsiA0zGlAYtetBy4MAhfGxp56s7WvAKXDDeN8xSDzBOPOM8vU+sVQu6zXxCbgLCDHxY8
        +baGXT7w==;
Received: from p5b3f6ccc.dip0.t-ipconnect.de ([91.63.108.204]:49262 helo=localhost.localdomain)
        by md-in-79.webhostbox.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <saravanan@linumiz.com>)
        id 1jOby8-0000eI-4v; Wed, 15 Apr 2020 06:56:20 +0000
From:   Saravanan Sekar <saravanan@linumiz.com>
To:     robh+dt@kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, broonie@kernel.org,
        lgirdwood@gmail.com, saravanan@linumiz.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH 3/4] iio: accel: Add driver for wsen-itds accelerometer sensor
Date:   Wed, 15 Apr 2020 08:55:34 +0200
Message-Id: <20200415065535.7753-4-saravanan@linumiz.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200415065535.7753-1-saravanan@linumiz.com>
References: <20200415065535.7753-1-saravanan@linumiz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 91.63.108.204
X-Source-L: No
X-Exim-ID: 1jOby8-0000eI-4v
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: p5b3f6ccc.dip0.t-ipconnect.de (localhost.localdomain) [91.63.108.204]:49262
X-Source-Auth: saravanan@linumiz.com
X-Email-Count: 31
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add an iio driver for the wurth elektronic wsen-itds 3-axis accelerometer.
The driver supports the acceleration, temperature data reading and
supports configuring of output data rate, operating mode and scale.

Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>
---
 drivers/iio/accel/Kconfig     |  14 +
 drivers/iio/accel/Makefile    |   1 +
 drivers/iio/accel/wsen-itds.c | 978 ++++++++++++++++++++++++++++++++++
 3 files changed, 993 insertions(+)
 create mode 100644 drivers/iio/accel/wsen-itds.c

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 5d91a6dda894..9fbefc94e33e 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -450,4 +450,18 @@ config STK8BA50
 	  Choosing M will build the driver as a module. If so, the module
 	  will be called stk8ba50.
 
+config WSEN_ITDS
+	tristate "Wurth Elektronik WSEN-ITDS 3-Axis Accelerometer Driver"
+	depends on I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	select REGMAP_I2C
+	help
+	  Say yes here to build support for the WSEN-ITDS 3-axis
+	  accelerometer.
+
+	  The sensor provies 3-axis Acceleration, Tempreature data and
+	  application specific features like tap, 6D Orinetation, Free-fall
+	  Motion, Activity etc
+
 endmenu
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 3a051cf37f40..942cab3e1d16 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -61,3 +61,4 @@ st_accel-$(CONFIG_IIO_BUFFER) += st_accel_buffer.o
 
 obj-$(CONFIG_IIO_ST_ACCEL_I2C_3AXIS) += st_accel_i2c.o
 obj-$(CONFIG_IIO_ST_ACCEL_SPI_3AXIS) += st_accel_spi.o
+obj-$(CONFIG_WSEN_ITDS) += wsen-itds.o
diff --git a/drivers/iio/accel/wsen-itds.c b/drivers/iio/accel/wsen-itds.c
new file mode 100644
index 000000000000..0846fb28a1b9
--- /dev/null
+++ b/drivers/iio/accel/wsen-itds.c
@@ -0,0 +1,978 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * WSEN-ITDS 3-axis accel sensor driver
+ *
+ * Copyright 2020 Linumiz
+ *
+ * Author: Saravanan Sekar <saravanan@linumiz.com>
+ *
+ * TODO : events - 6D, Orientation, Free-fall, Tap, Motion
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+
+#define	ITDS_REG_TEMP_L			0x0d
+#define	ITDS_REG_DEV_ID			0x0f
+#define	ITDS_REG_CTRL1			0x20
+#define	ITDS_REG_CTRL2			0x21
+#define	ITDS_REG_CTRL3			0x22
+#define	ITDS_REG_CTRL4			0x23
+#define	ITDS_REG_CTRL5			0x24
+#define	ITDS_REG_CTRL6			0x25
+#define	ITDS_REG_STATUS			0x27
+#define	ITDS_REG_X_OUT_L		0x28
+#define	ITDS_REG_Y_OUT_L		0x2a
+#define	ITDS_REG_Z_OUT_L		0x2c
+#define	ITDS_REG_FIFO_CTRL		0x2e
+#define	ITDS_REG_FIFO_SAMPLES		0x2f
+#define	ITDS_REG_STATUS_DETECT		0x37
+#define	ITDS_REG_WAKEUP_EVENT		0x38
+#define	ITDS_REG_CTRL7			0x3f
+
+#define	ITDS_MASK_SCALE			GENMASK(5, 4)
+#define	ITDS_MASK_BDU_INC_ADD		GENMASK(3, 2)
+#define	ITDS_MASK_FIFOTH		GENMASK(4, 0)
+#define	ITDS_MASK_FIFOMODE		GENMASK(7, 5)
+#define	ITDS_MASK_MODE			GENMASK(3, 0)
+#define	ITDS_MASK_SAMPLES_COUNT		GENMASK(5, 0)
+#define	ITDS_MASK_ODR			GENMASK(7, 4)
+#define	ITDS_MASK_INT_DRDY		BIT(0)
+#define	ITDS_MASK_INT_FIFOTH		BIT(1)
+#define	ITDS_MASK_INT_EN		BIT(5)
+
+#define	ITDS_EVENT_DRDY			BIT(0)
+#define	ITDS_EVENT_DRDY_T		BIT(6)
+#define	ITDS_EVENT_FIFO_TH		BIT(7)
+#define	ITDS_DEVICE_ID			0x44
+#define	ITDS_ACCL_FIFO_SIZE		32
+
+#define ITDS_ACC_CHAN(_axis, _idx) {					\
+	.type = IIO_ACCEL,						\
+	.modified = 1,							\
+	.channel2 = IIO_MOD_##_axis,					\
+	.scan_index = _idx,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
+				BIT(IIO_CHAN_INFO_SCALE),		\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 14,						\
+		.storagebits = 16,					\
+		.shift = 2,						\
+		.endianness = IIO_LE,					\
+	},								\
+}
+
+enum itds_operating_mode {
+	ITDS_MODE_LOW_POWER,
+	ITDS_MODE_NORMAL = BIT(0),
+	ITDS_MODE_HIGH_PERFORMANCE = BIT(1),
+	ITDS_MODE_SINGLE_SHOT = BIT(2),
+	ITDS_MODE_INVALID = 4
+};
+
+enum itds_fifo_mode {
+	ITDS_MODE_BYPASS,
+	ITDS_MODE_FIFO,
+	ITDS_MODE_CONTINUES,
+	ITDS_MODE_CONTINUES_TO_FIFO,
+	ITDS_MODE_BYPASS_TO_CONTINUES,
+	ITDS_MODE_END
+};
+
+struct itds_info {
+	struct device *dev;
+	struct regmap *regmap;
+	struct iio_trigger *trig;
+	struct regulator *vdd_supply;
+	struct regulator *vddio_supply;
+	unsigned int scale;
+	enum itds_operating_mode op_mode;
+	enum itds_fifo_mode fifo_mode;
+	struct mutex mutex;
+	int64_t timestamp;
+	u8 fifo_threshold;
+	bool is_hwfifo_enabled;
+};
+
+struct itds_samp_freq {
+	int val;
+	int val2;
+};
+
+struct itds_fifo_modes {
+	char *str;
+	int rval;
+};
+
+static const char *operating_mode[ITDS_MODE_INVALID] = {
+	"lowpower",
+	"normal",
+	"high_perf",
+	"single_shot"
+};
+
+static const struct itds_samp_freq sample_freq[][10] = {
+	{
+		{0}, {1, 600000}, {12, 500000}, {25}, {50},
+		{100}, {200}, {200}, {200}, {200}
+	},
+
+	/* high performance mode */
+	{
+		{0}, {12, 500000}, {12, 500000}, {25}, {50},
+		{100}, {200}, {400}, {800}, {1600}
+	}
+};
+
+static const unsigned long itds_scan_masks[] = {0x7, 0};
+
+/* 2g, 4g, 8g, 16g */
+unsigned int sensitivity_scale[][4] = {
+	{976, 1952, 3904, 7808},
+
+	/* high performance mode */
+	{244, 488, 976, 1952}
+};
+
+static const struct iio_chan_spec itds_channels[] = {
+	ITDS_ACC_CHAN(X, 0),
+	ITDS_ACC_CHAN(Y, 1),
+	ITDS_ACC_CHAN(Z, 2),
+	{
+		.type = IIO_TEMP,
+		.scan_index = 3,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
+				 BIT(IIO_CHAN_INFO_OFFSET),
+	}
+};
+
+static struct itds_fifo_modes fifo_modes[ITDS_MODE_END] = {
+	{"bypass", 0},
+	{"fifo", 1},
+	{"continues", 3},
+	{"continues_fifo", 4},
+	{"bypass_continues", 6},
+};
+
+static struct regmap_config itds_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0x3f,
+};
+
+static ssize_t itds_accel_scale_avail(struct device *dev,
+				      struct device_attribute *attr,
+				      char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct itds_info *info = iio_priv(indio_dev);
+	int len = 0, i;
+	bool mode;
+
+	mode = !!(info->op_mode & ITDS_MODE_HIGH_PERFORMANCE);
+
+	for (i = 0; i < ARRAY_SIZE(sensitivity_scale[0]); i++)
+		len += sprintf(buf + len, "%d ", sensitivity_scale[mode][i]);
+
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
+static ssize_t itds_samp_freq_avail(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct itds_info *info = iio_priv(indio_dev);
+	int len = 0, i;
+	bool mode;
+
+	mode = !!(info->op_mode & ITDS_MODE_HIGH_PERFORMANCE);
+
+	for (i = 0; i < ARRAY_SIZE(sample_freq[0]); i++) {
+		len += sprintf(buf + len, "%d.%d ", sample_freq[mode][i].val,
+					 sample_freq[mode][i].val2);
+	}
+	buf[len - 1] = '\n';
+
+	return len;
+}
+
+static int itds_get_temp(struct itds_info *info, int *val)
+{
+	unsigned int regval;
+	int ret;
+	__le16 rval;
+
+	ret = regmap_read(info->regmap, ITDS_REG_STATUS_DETECT, &regval);
+	if (ret)
+		return ret;
+
+	if (!(regval & ITDS_EVENT_DRDY_T))
+		return -EAGAIN;
+
+	ret = regmap_bulk_read(info->regmap, ITDS_REG_TEMP_L,
+				   &rval, sizeof(rval));
+	if (ret) {
+		dev_err(info->dev, "failed to read TEMP reg\n");
+		return ret;
+	}
+
+	rval  = rval >> 4;
+	regval = sign_extend32(le16_to_cpu(rval), 11);
+	*val = regval * 625;
+
+	return IIO_VAL_INT;
+}
+
+static int itds_get_accel(struct itds_info *info,
+			  const struct iio_chan_spec *chan,
+			  int *val)
+{
+	unsigned int regval;
+	int reg, ret;
+	__le16 rval;
+
+	if (info->is_hwfifo_enabled)
+		return -EBUSY;
+
+	ret = regmap_read(info->regmap, ITDS_REG_STATUS, &regval);
+	if (ret)
+		return ret;
+
+	if (!(regval & ITDS_EVENT_DRDY))
+		return -EAGAIN;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		reg = ITDS_REG_X_OUT_L;
+		break;
+	case IIO_MOD_Y:
+		reg = ITDS_REG_Y_OUT_L;
+		break;
+	case IIO_MOD_Z:
+		reg = ITDS_REG_Z_OUT_L;
+		break;
+	default:
+		dev_err(info->dev, "invalid axis modifier\n");
+		return -EINVAL;
+	}
+
+	ret = regmap_bulk_read(info->regmap, reg, &rval, sizeof(rval));
+	if (ret)
+		return ret;
+
+	mutex_lock(&info->mutex);
+
+	if (info->op_mode & ITDS_MODE_HIGH_PERFORMANCE ||
+	    info->op_mode & ITDS_MODE_NORMAL) {
+		rval = rval >> chan->scan_type.shift;
+		*val = sign_extend32(le16_to_cpu(rval),
+				     chan->scan_type.realbits - 1);
+	} else {
+		rval = rval >> (chan->scan_type.shift + 2);
+		*val = sign_extend32(le16_to_cpu(rval),
+				     chan->scan_type.realbits - 3);
+	}
+
+	mutex_unlock(&info->mutex);
+
+	return IIO_VAL_INT;
+}
+
+static int itds_set_odr(struct itds_info *info, int val, int val2)
+{
+	int ret, i;
+	bool mode;
+
+	mode = !!(info->op_mode & ITDS_MODE_HIGH_PERFORMANCE);
+
+	for (i = 0; i < ARRAY_SIZE(sample_freq[0]); i++) {
+		if ((val == sample_freq[mode][i].val) &&
+		    (val2 == sample_freq[mode][i].val2)) {
+
+			ret = regmap_update_bits(info->regmap, ITDS_REG_CTRL1,
+						 ITDS_MASK_ODR, i << 4);
+			return ret;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int itds_get_odr(struct itds_info *info, int *val, int *val2)
+{
+	int ret;
+	unsigned int rval;
+	bool mode;
+
+	ret = regmap_read(info->regmap, ITDS_REG_CTRL1, &rval);
+	if (ret)
+		return ret;
+
+	rval = (rval & ITDS_MASK_ODR) >> 4;
+	mode = !!(info->op_mode & ITDS_MODE_HIGH_PERFORMANCE);
+	*val = sample_freq[mode][rval].val;
+	*val2 = sample_freq[mode][rval].val2;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int itds_set_scale(struct itds_info *info, int val)
+{
+	int i, ret = -EINVAL;
+	bool mode;
+
+	mutex_lock(&info->mutex);
+	mode = !!(info->op_mode & ITDS_MODE_HIGH_PERFORMANCE);
+	for (i = 0; i < ARRAY_SIZE(sensitivity_scale[0]); i++) {
+		if (val == sensitivity_scale[mode][i])
+			break;
+	}
+
+	if (i == ARRAY_SIZE(sensitivity_scale[0]))
+		goto ret_unlock;
+
+	ret = regmap_update_bits(info->regmap, ITDS_REG_CTRL6,
+				 ITDS_MASK_SCALE, i << 4);
+	if (ret)
+		goto ret_unlock;
+
+	info->scale = 1000 * sensitivity_scale[mode][i];
+
+ret_unlock:
+	mutex_unlock(&info->mutex);
+	return ret;
+}
+
+static int itds_get_scale(struct itds_info *info)
+{
+	int ret;
+	unsigned int rval;
+	bool mode;
+
+	ret = regmap_read(info->regmap, ITDS_REG_CTRL6, &rval);
+	if (ret)
+		return ret;
+
+	rval = (rval & ITDS_MASK_SCALE) >> 4;
+	mode = !!(info->op_mode & ITDS_MODE_HIGH_PERFORMANCE);
+	info->scale = 1000 * sensitivity_scale[mode][rval];
+
+	return 0;
+}
+
+int itds_set_trigger_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct itds_info *info = iio_priv(indio_dev);
+	unsigned int enable;
+	int ret;
+
+	enable = state ? ITDS_MASK_INT_EN : 0;
+	ret = regmap_update_bits(info->regmap, ITDS_REG_CTRL7,
+				 ITDS_MASK_INT_EN, enable);
+	if (ret)
+		dev_err(info->dev, "interrupt en/dis fail %d\n", ret);
+
+	return ret;
+}
+
+static int itds_fifo_flush(struct iio_dev *indio_dev, unsigned int count)
+{
+	struct itds_info *info = iio_priv(indio_dev);
+	struct device *dev = info->dev;
+	unsigned int rval;
+	int ret, i;
+	/* 3x16 bits data + timestamp 64 bits */
+	__le16 buffer[7];
+	u8 samples;
+
+	ret = regmap_read(info->regmap, ITDS_REG_FIFO_SAMPLES, &rval);
+	if (ret < 0) {
+		dev_err(dev, "FIFO count err %d\n", ret);
+		return ret;
+	}
+
+	if (!(rval & ITDS_EVENT_FIFO_TH))
+		return 0;
+
+	samples = rval & ITDS_MASK_SAMPLES_COUNT;
+	if (!count)
+		return 0;
+
+	samples = samples < count ? samples : count;
+	for (i = 0; i < samples; i++) {
+		ret = regmap_raw_read(info->regmap, ITDS_REG_X_OUT_L,
+				      buffer, 3 * sizeof(u16));
+		if (ret)
+			return i;
+
+		iio_push_to_buffers_with_timestamp(indio_dev, buffer,
+						   info->timestamp);
+	}
+
+	return samples;
+}
+
+static ssize_t itds_accel_get_fifo_threshold(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct itds_info *info = iio_priv(indio_dev);
+	int wm;
+
+	mutex_lock(&info->mutex);
+	wm = info->fifo_threshold;
+	mutex_unlock(&info->mutex);
+
+	return sprintf(buf, "%d\n", wm);
+}
+
+static int itds_accel_set_fifo_threshold(struct iio_dev *indio_dev,
+					 unsigned int val)
+{
+	struct itds_info *info = iio_priv(indio_dev);
+
+	if (val >= ITDS_ACCL_FIFO_SIZE)
+		val = ITDS_ACCL_FIFO_SIZE - 1;
+
+	mutex_lock(&info->mutex);
+	info->fifo_threshold = val;
+	mutex_unlock(&info->mutex);
+
+	return 0;
+}
+
+static ssize_t itds_accel_set_fifo_mode(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf,
+					size_t count)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct itds_info *info = iio_priv(indio_dev);
+	int i;
+
+	mutex_lock(&info->mutex);
+
+	for (i = 0; i < ITDS_MODE_END; i++) {
+		if (!strcmp(buf, fifo_modes[i].str)) {
+			info->fifo_mode = i;
+			goto ret_unlock;
+		}
+	}
+	count = -EINVAL;
+
+ret_unlock:
+	mutex_unlock(&info->mutex);
+	return count;
+}
+
+static ssize_t itds_accel_get_fifo_mode(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct itds_info *info = iio_priv(indio_dev);
+	int mode;
+
+	mutex_lock(&info->mutex);
+	mode = info->fifo_mode;
+	mutex_unlock(&info->mutex);
+
+	return sprintf(buf, "%s\n", fifo_modes[mode].str);
+}
+
+static int itds_set_operating_mode(struct itds_info *info,
+				enum itds_operating_mode mode)
+{
+	int ret;
+
+	ret = regmap_update_bits(info->regmap, ITDS_REG_CTRL1,
+				 ITDS_MASK_MODE, 1 << mode);
+	if (!ret) {
+		info->op_mode = mode;
+
+		/* update scale according to new operating mode */
+		itds_get_scale(info);
+	}
+
+	return ret;
+}
+
+static ssize_t itds_accel_set_operating_mode(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf,
+					     size_t count)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct itds_info *info = iio_priv(indio_dev);
+	int ret = -EINVAL;
+	int i;
+
+	mutex_lock(&info->mutex);
+
+	for (i = 0; i < ITDS_MODE_INVALID; i++) {
+		if (!strcmp(buf, operating_mode[i])) {
+			ret = itds_set_operating_mode(info, i);
+			if (!ret)
+				ret = count;
+
+			break;
+		}
+	}
+
+	mutex_unlock(&info->mutex);
+	return ret;
+}
+
+static ssize_t itds_accel_get_operating_mode(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct itds_info *info = iio_priv(indio_dev);
+	int mode;
+
+	mutex_lock(&info->mutex);
+	mode = info->op_mode;
+	mutex_unlock(&info->mutex);
+
+	return sprintf(buf, "%s\n", operating_mode[mode]);
+}
+
+static ssize_t itds_accel_get_fifo_state(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct itds_info *info = iio_priv(indio_dev);
+	bool is_enabled;
+
+	mutex_lock(&info->mutex);
+	is_enabled = info->is_hwfifo_enabled;
+	mutex_unlock(&info->mutex);
+
+	return sprintf(buf, "%d\n", is_enabled);
+}
+
+static IIO_CONST_ATTR(hwfifo_threshold_min, "1");
+static IIO_CONST_ATTR(hwfifo_threshold_max, __stringify(ITDS_ACCL_FIFO_SIZE));
+static IIO_DEVICE_ATTR(hwfifo_enabled, 0444,
+		       itds_accel_get_fifo_state, NULL, 0);
+static IIO_DEVICE_ATTR(hwfifo_threshold, 0444,
+		       itds_accel_get_fifo_threshold, NULL, 0);
+static IIO_DEVICE_ATTR(hwfifo_mode, 0644, itds_accel_get_fifo_mode,
+			itds_accel_set_fifo_mode, 0);
+static IIO_DEVICE_ATTR(operating_mode, 0644, itds_accel_get_operating_mode,
+		       itds_accel_set_operating_mode, 0);
+static IIO_DEVICE_ATTR(in_accel_samp_freq_available, 0444,
+		       itds_samp_freq_avail, NULL, 0);
+static IIO_DEVICE_ATTR(in_accel_scale_available, 0444,
+		       itds_accel_scale_avail, NULL, 0);
+
+static struct attribute *itds_accel_fifo_attributes[] = {
+	&iio_const_attr_hwfifo_threshold_min.dev_attr.attr,
+	&iio_const_attr_hwfifo_threshold_max.dev_attr.attr,
+	&iio_dev_attr_hwfifo_threshold.dev_attr.attr,
+	&iio_dev_attr_hwfifo_enabled.dev_attr.attr,
+	&iio_dev_attr_hwfifo_mode.dev_attr.attr,
+	&iio_dev_attr_operating_mode.dev_attr.attr,
+	&iio_dev_attr_in_accel_samp_freq_available.dev_attr.attr,
+	&iio_dev_attr_in_accel_scale_available.dev_attr.attr,
+	NULL,
+};
+
+static struct attribute_group itds_attrs_group = {
+	.attrs = itds_accel_fifo_attributes,
+};
+
+static irqreturn_t itds_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct itds_info *info = iio_priv(indio_dev);
+
+	if (info->is_hwfifo_enabled)
+		itds_fifo_flush(indio_dev, ITDS_ACCL_FIFO_SIZE);
+
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t itds_accel_irq_thread_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct itds_info *info = iio_priv(indio_dev);
+	unsigned int rval;
+	int ret;
+
+	ret = regmap_read(info->regmap, ITDS_REG_STATUS, &rval);
+	if (ret)
+		return IRQ_NONE;
+
+	if (rval & ITDS_EVENT_FIFO_TH)
+		iio_trigger_poll_chained(info->trig);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t itds_accel_irq_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct itds_info *info = iio_priv(indio_dev);
+
+	if (info->is_hwfifo_enabled) {
+		info->timestamp = iio_get_time_ns(indio_dev);
+		return IRQ_WAKE_THREAD;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int itds_accel_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct itds_info *info = iio_priv(indio_dev);
+
+	if (!info->is_hwfifo_enabled)
+		return 0;
+
+	regmap_update_bits(info->regmap, ITDS_REG_FIFO_CTRL,
+				 ITDS_MASK_FIFOTH | ITDS_MASK_FIFOMODE, 0);
+	regmap_update_bits(info->regmap, ITDS_REG_CTRL4,
+				 ITDS_MASK_INT_FIFOTH, 0);
+
+	info->is_hwfifo_enabled = false;
+
+	return 0;
+}
+
+static int itds_accel_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct itds_info *info = iio_priv(indio_dev);
+	unsigned int rval;
+	int ret = 0;
+
+	if (info->is_hwfifo_enabled)
+		return 0;
+
+	if (!info->fifo_mode)
+		return -EINVAL;
+
+	ret = regmap_read(info->regmap, ITDS_REG_CTRL1, &rval);
+	if (ret)
+		return ret;
+
+	if (!(rval & ITDS_MASK_ODR))
+		return -EINVAL;
+
+	ret = regmap_update_bits(info->regmap, ITDS_REG_FIFO_CTRL,
+				 ITDS_MASK_FIFOTH, info->fifo_threshold);
+	if (ret)
+		goto out_err;
+
+	ret = regmap_update_bits(info->regmap, ITDS_REG_FIFO_CTRL,
+				 ITDS_MASK_FIFOMODE,
+				 fifo_modes[info->fifo_mode].rval << 5);
+	if (ret)
+		goto out_err;
+
+	info->is_hwfifo_enabled = true;
+	ret = regmap_update_bits(info->regmap, ITDS_REG_CTRL4,
+				 ITDS_MASK_INT_FIFOTH,
+				 ITDS_MASK_INT_FIFOTH);
+	if (ret)
+		goto disable_fifo;
+
+	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
+		iio_triggered_buffer_postenable(indio_dev);
+
+	return 0;
+
+disable_fifo:
+	regmap_update_bits(info->regmap, ITDS_REG_FIFO_CTRL,
+				 ITDS_MASK_FIFOTH | ITDS_MASK_FIFOMODE, 0);
+
+out_err:
+	return ret;
+}
+
+static int itds_read_raw(struct iio_dev *indio_dev,
+			 struct iio_chan_spec const *chan, int *val,
+			 int *val2, long mask)
+{
+	struct itds_info *info = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (chan->type == IIO_ACCEL)
+			ret = itds_get_accel(info, chan, val);
+		else
+			ret = itds_get_temp(info, val);
+		return ret;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+		if (chan->type == IIO_ACCEL)
+			*val2 = info->scale;
+		else
+			*val2 = 100;
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = itds_get_odr(info, val, val2);
+		return ret;
+
+	case IIO_CHAN_INFO_OFFSET:
+		if (chan->type == IIO_TEMP)
+			*val = 250000;
+		else
+			*val = 0;
+
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int itds_write_raw(struct iio_dev *indio_dev,
+			  struct iio_chan_spec const *chan,
+			  int val, int val2, long mask)
+{
+	struct itds_info *info = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return itds_set_odr(info, val, val2);
+
+	case IIO_CHAN_INFO_SCALE:
+		return itds_set_scale(info, val);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_trigger_ops itds_trigger_ops = {
+	.set_trigger_state = itds_set_trigger_state,
+};
+
+static const struct iio_buffer_setup_ops itds_accel_buffer_ops = {
+	.postenable = itds_accel_buffer_postenable,
+	.predisable = iio_triggered_buffer_predisable,
+	.postdisable = itds_accel_buffer_postdisable,
+};
+
+static const struct iio_info itds_accel_info = {
+	.attrs			= &itds_attrs_group,
+	.read_raw		= itds_read_raw,
+	.write_raw		= itds_write_raw,
+	.hwfifo_flush_to_buffer = itds_fifo_flush,
+	.hwfifo_set_watermark	= itds_accel_set_fifo_threshold,
+};
+
+static int itds_probe(struct i2c_client *client, const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct iio_dev *indio_dev;
+	struct itds_info *info;
+	struct regmap *regmap;
+	unsigned int rval;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*info));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	regmap = devm_regmap_init_i2c(client, &itds_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "Failed to allocate regmap!\n");
+		return PTR_ERR(regmap);
+	}
+
+	info = iio_priv(indio_dev);
+	info->regmap = regmap;
+	info->dev = dev;
+	i2c_set_clientdata(client, indio_dev);
+	mutex_init(&info->mutex);
+
+	info->vdd_supply = devm_regulator_get_optional(dev, "vdd");
+	info->vddio_supply = devm_regulator_get_optional(dev, "vddio");
+
+	if (!IS_ERR_OR_NULL(info->vdd_supply) &&
+	    !IS_ERR_OR_NULL(info->vddio_supply)) {
+
+		ret = regulator_set_voltage(info->vdd_supply, 1700000, 3600000);
+		if (ret)
+			goto out_err;
+
+		ret = regulator_set_voltage(info->vddio_supply,
+						 1200000, 3700000);
+		if (ret)
+			goto out_err;
+
+		ret = regulator_enable(info->vdd_supply);
+		if (ret) {
+			dev_err(dev, "Failed to enable vdd: %d\n", ret);
+			goto out_err;
+		}
+
+		ret = regulator_enable(info->vddio_supply);
+		if (ret) {
+			dev_err(dev, "Failed to enable vddio: %d\n", ret);
+			goto out_disable_vdd;
+		}
+
+		/* chip boot sequence takes 20ms */
+		usleep_range(20000, 21000);
+	}
+
+	ret = regmap_read(info->regmap, ITDS_REG_DEV_ID, &rval);
+	if (ret && (rval != ITDS_DEVICE_ID)) {
+		dev_info(dev, "err %d device id %X not matched\n", ret, rval);
+		goto out_disable_vddio;
+	}
+
+	ret = regmap_update_bits(info->regmap, ITDS_REG_CTRL2,
+				 ITDS_MASK_BDU_INC_ADD, ITDS_MASK_BDU_INC_ADD);
+	if (ret) {
+		dev_err(dev, "unable to set block data update!\n");
+		goto out_disable_vddio;
+	}
+
+	ret = regmap_update_bits(info->regmap, ITDS_REG_WAKEUP_EVENT, 0xff, 0);
+	if (ret) {
+		dev_err(dev, "disable wakeup event fail!\n");
+		goto out_disable_vddio;
+	}
+
+	indio_dev->name = dev_name(dev);
+	indio_dev->dev.parent = dev;
+	indio_dev->channels = itds_channels;
+	indio_dev->num_channels = ARRAY_SIZE(itds_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->available_scan_masks = itds_scan_masks;
+	indio_dev->info = &itds_accel_info;
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      NULL,
+					      itds_trigger_handler,
+					      &itds_accel_buffer_ops);
+	if (ret) {
+		dev_err(dev, "unable to setup iio triggered buffer\n");
+		goto out_disable_vddio;
+	}
+
+	if (client->irq > 0) {
+		ret = devm_request_threaded_irq(dev, client->irq,
+						itds_accel_irq_handler,
+						itds_accel_irq_thread_handler,
+						IRQF_TRIGGER_RISING,
+						"itds_event", indio_dev);
+		if (ret) {
+			dev_err(dev, "unable to request IRQ\n");
+			goto out_disable_vddio;
+		}
+
+		info->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
+					indio_dev->name, indio_dev->id);
+		if (!info->trig) {
+			ret = -ENOMEM;
+			goto out_disable_vddio;
+		}
+
+		info->trig->dev.parent = dev;
+		info->trig->ops = &itds_trigger_ops;
+		iio_trigger_set_drvdata(info->trig, indio_dev);
+		indio_dev->trig = iio_trigger_get(info->trig);
+
+		ret = devm_iio_trigger_register(dev, info->trig);
+		if (ret)
+			goto out_disable_vddio;
+	}
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret) {
+		dev_err(dev, "IIO device register fail: %d\n", ret);
+		goto out_disable_vddio;
+	}
+
+	dev_set_drvdata(dev, indio_dev);
+
+	return 0;
+
+out_disable_vddio:
+	if (!IS_ERR_OR_NULL(info->vddio_supply))
+		regulator_disable(info->vddio_supply);
+
+out_disable_vdd:
+	if (!IS_ERR_OR_NULL(info->vdd_supply))
+		regulator_disable(info->vdd_supply);
+
+out_err:
+	return ret;
+}
+
+static int itds_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct itds_info *info = iio_priv(indio_dev);
+
+	regmap_update_bits(info->regmap, ITDS_REG_CTRL1, ITDS_MASK_MODE, 0);
+	if (!IS_ERR_OR_NULL(info->vdd_supply))
+		regulator_disable(info->vdd_supply);
+
+	if (!IS_ERR_OR_NULL(info->vddio_supply))
+		regulator_disable(info->vddio_supply);
+
+	return 0;
+}
+
+static const struct of_device_id itds_of_match[] = {
+	{ .compatible = "we,wsen-itds"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, itds_of_match);
+
+static const struct i2c_device_id itds_id[] = {
+	{ "wsen-itds", },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, itds_id);
+
+static struct i2c_driver itds_driver = {
+	.driver = {
+		.name = "wsen-itds",
+		.of_match_table = of_match_ptr(itds_of_match),
+	},
+	.probe		= itds_probe,
+	.remove		= itds_remove,
+	.id_table	= itds_id,
+};
+module_i2c_driver(itds_driver);
+
+MODULE_AUTHOR("Saravanan Sekar <saravanan@linumiz.com>");
+MODULE_DESCRIPTION("Würth Elektronik WSEN-ITDS 3-axis accel driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

