Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5ACCEE3FC
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2019 16:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfKDPin (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 4 Nov 2019 10:38:43 -0500
Received: from mail-pg1-f182.google.com ([209.85.215.182]:44886 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfKDPin (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Nov 2019 10:38:43 -0500
Received: by mail-pg1-f182.google.com with SMTP id f19so2414388pgk.11;
        Mon, 04 Nov 2019 07:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YozH4rfa5peGm+QMBTPcVdd1dFhvgr76aI1QuJNOqI4=;
        b=UxTnBwsDTbe0KNqNBw7YogblBvxP2hrvhzp+Kwt1yLLdClBVcxgRw6vQmYZaLK1tao
         hlT5z1H4i6nPpHkIz4hKY2MtzDeno+/ndoevPEi5mtdYbM/f1WbAzi9SlndpUaJxbo9o
         wkW1c+Q4h200/kfnPUzKUOt9uQ20LzJM20o/zNCT/TKaPXi1FX6s0R/jtpjFZMCcwDbQ
         JaScF5XMijW39qogurzTLo62mzJ6EjHa5p0HmnNx5sifm69XawgoxbpqMZMzr3f6z7Hh
         IERMdJIvFKizrMzNyvPRj5mgTskVIsAh7PtnOG1GLtPT5tMcrllZ+3ra4br83ZU+ozzx
         xdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YozH4rfa5peGm+QMBTPcVdd1dFhvgr76aI1QuJNOqI4=;
        b=JBEs2AR/qhNEd2IltJPx/MMxNMxo0zzhApj9Bt7BLqtLOlEboZJTKEFdA+1DSOgpuA
         GCCc54l9HL/mdtHuO1tLRx2pEHc2fhkcjCa7E2rHoRZM0ibf2tHrsSa9PS9wSbyZrpl+
         XOhwc1sP6CrxMvFCjyoyQNsQcU77iNP9iaPbk4LOZJZLJSlFsA1qc0zn4uQqTHLnhIYA
         0LTjZPXvDajj2vzagWbL+JZBt9uzrq2ff2lkxeHEYMfl40c/bwMEEcxyDthyvlDAUA+e
         oICkJMO9mCOoPYn0YR4Z7Vv6GH90HTgAzIdtQOJyCpCbz5ukUrU/bY5IGi9G4zA48cWA
         AmAA==
X-Gm-Message-State: APjAAAUC3rDrInnwEEZ1eyaUqCyp5p+kGb4a6p6wagU39Ql3DCFfe/LK
        p9Hd+imqQITLntgO8Tp+mhk=
X-Google-Smtp-Source: APXvYqxEgC5Bd7Jf2luYvpIScwH1DOPaM8iPeoQK5NXMP8SatvP+HX2AxL+EbcdeMM4YrQpXP4oihQ==
X-Received: by 2002:a17:90a:3807:: with SMTP id w7mr20762289pjb.33.1572881921861;
        Mon, 04 Nov 2019 07:38:41 -0800 (PST)
Received: from localhost.localdomain ([106.51.108.222])
        by smtp.gmail.com with ESMTPSA id j22sm14734299pff.42.2019.11.04.07.38.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Nov 2019 07:38:40 -0800 (PST)
From:   Rishi Gupta <gupt21@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net, alexios.zavras@intel.com, angus@akkea.ca,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, Rishi Gupta <gupt21@gmail.com>
Subject: [PATCH v6 1/3] iio: light: add driver for veml6030 ambient light sensor
Date:   Mon,  4 Nov 2019 21:08:24 +0530
Message-Id: <1572881904-15274-1-git-send-email-gupt21@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

veml6030 is an ambient light sensor from Vishay semiconductors.
It has 16-bit resolution, supports both ambient light measurement
and white channel which is more responsive to wider wavelength
spectrum. It has flexible power saving, integration time and
gain options. Communication with host is over I2C.

Signed-off-by: Rishi Gupta <gupt21@gmail.com>
---
Changes in v6:
* Move devm_add_action_or_reset() after veml6030_hw_init()
* Reading/Writing/Show for period now takes values in seconds

Changes in v5:
* Removed setting val2 when returning IIO_VAL_INT
* Removed redundant return from veml6030_read_raw()
* Set 4000 as min time in usleep_range(4000, 4002)
* Removed PSM support completely

Changes in v4:
* None

Changes in v3:
* Added appnote link in topmost comments section
* Dropped 'return ret' statements wherever not needed
* Removed .scan_index from channel specifications, not needed
* If irq is not enabled, events interfaces are not exposed now
* Return IRQ_NONE for spurious interrupt
* Removed CONFIG_PM, added __maybe_unused in power routines
* Removed of_match_ptr when specifying DT device id to match
* Corrected & documented sequence in veml6030_write_interrupt_config()
* Removed veml6030_remove() & added devm_add_action_or_reset functionality
* Added support to read integration time, gain, thresholds, period
* Removed including mutex.h not needed
* Set 100 ms integration & 1/8 gain during probe for better accuracy
* Used IIO_CONST_ATTR to create sysfs entries "_available"
* Minor cosmetics like everything in lower case

Changes in v2:
* Added comma after CH_WHITE in enum veml6030_chan so it can be extended
* Removed .scan_type as driver doesn't use buffered mode
* Removed iio_device_unregister() as kernel will take care of cleaning

 drivers/iio/light/Kconfig    |  11 +
 drivers/iio/light/Makefile   |   1 +
 drivers/iio/light/veml6030.c | 911 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 923 insertions(+)
 create mode 100644 drivers/iio/light/veml6030.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 4a1a883..f9d27ef 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -496,6 +496,17 @@ config VCNL4035
 	  To compile this driver as a module, choose M here: the
 	  module will be called vcnl4035.
 
+config VEML6030
+	tristate "VEML6030 ambient light sensor"
+	select REGMAP_I2C
+	depends on I2C
+	help
+	  Say Y here if you want to build a driver for the Vishay VEML6030
+	  ambient light sensor (ALS).
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called veml6030.
+
 config VEML6070
 	tristate "VEML6070 UV A light sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index 00d1f9b..5e0c40b 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_TSL4531)		+= tsl4531.o
 obj-$(CONFIG_US5182D)		+= us5182d.o
 obj-$(CONFIG_VCNL4000)		+= vcnl4000.o
 obj-$(CONFIG_VCNL4035)		+= vcnl4035.o
+obj-$(CONFIG_VEML6030)		+= veml6030.o
 obj-$(CONFIG_VEML6070)		+= veml6070.o
 obj-$(CONFIG_VL6180)		+= vl6180.o
 obj-$(CONFIG_ZOPT2201)		+= zopt2201.o
diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
new file mode 100644
index 0000000..a38b110
--- /dev/null
+++ b/drivers/iio/light/veml6030.c
@@ -0,0 +1,911 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * VEML6030 Ambient Light Sensor
+ *
+ * Copyright (c) 2019, Rishi Gupta <gupt21@gmail.com>
+ *
+ * Datasheet: https://www.vishay.com/docs/84366/veml6030.pdf
+ * Appnote-84367: https://www.vishay.com/docs/84367/designingveml6030.pdf
+ */
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/err.h>
+#include <linux/regmap.h>
+#include <linux/interrupt.h>
+#include <linux/pm_runtime.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
+
+/* Device registers */
+#define VEML6030_REG_ALS_CONF   0x00
+#define VEML6030_REG_ALS_WH     0x01
+#define VEML6030_REG_ALS_WL     0x02
+#define VEML6030_REG_ALS_PSM    0x03
+#define VEML6030_REG_ALS_DATA   0x04
+#define VEML6030_REG_WH_DATA    0x05
+#define VEML6030_REG_ALS_INT    0x06
+
+/* Bit masks for specific functionality */
+#define VEML6030_ALS_IT       GENMASK(9, 6)
+#define VEML6030_PSM          GENMASK(2, 1)
+#define VEML6030_ALS_PERS     GENMASK(5, 4)
+#define VEML6030_ALS_GAIN     GENMASK(12, 11)
+#define VEML6030_PSM_EN       BIT(0)
+#define VEML6030_INT_TH_LOW   BIT(15)
+#define VEML6030_INT_TH_HIGH  BIT(14)
+#define VEML6030_ALS_INT_EN   BIT(1)
+#define VEML6030_ALS_SD       BIT(0)
+
+/*
+ * The resolution depends on both gain and integration time. The
+ * cur_resolution stores one of the resolution mentioned in the
+ * table during startup and gets updated whenever integration time
+ * or gain is changed.
+ *
+ * Table 'resolution and maximum detection range' in appnote 84367
+ * is visualized as a 2D array. The cur_gain stores index of gain
+ * in this table (0-3) while the cur_integration_time holds index
+ * of integration time (0-5).
+ */
+struct veml6030_data {
+	struct i2c_client *client;
+	struct regmap *regmap;
+	int cur_resolution;
+	int cur_gain;
+	int cur_integration_time;
+};
+
+/* Integration time available in seconds */
+static IIO_CONST_ATTR(in_illuminance_integration_time_available,
+				"0.025 0.05 0.1 0.2 0.4 0.8");
+
+/*
+ * Scale is 1/gain. Value 0.125 is ALS gain x (1/8), 0.25 is
+ * ALS gain x (1/4), 1.0 = ALS gain x 1 and 2.0 is ALS gain x 2.
+ */
+static IIO_CONST_ATTR(in_illuminance_scale_available,
+				"0.125 0.25 1.0 2.0");
+
+static struct attribute *veml6030_attributes[] = {
+	&iio_const_attr_in_illuminance_integration_time_available.dev_attr.attr,
+	&iio_const_attr_in_illuminance_scale_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group veml6030_attr_group = {
+	.attrs = veml6030_attributes,
+};
+
+/*
+ * Persistence = 1/2/4/8 x integration time
+ * Minimum time for which light readings must stay above configured
+ * threshold to assert the interrupt.
+ */
+static const char * const period_values[] = {
+		"0.1 0.2 0.4 0.8",
+		"0.2 0.4 0.8 1.6",
+		"0.4 0.8 1.6 3.2",
+		"0.8 1.6 3.2 6.4",
+		"0.05 0.1 0.2 0.4",
+		"0.025 0.050 0.1 0.2"
+};
+
+/*
+ * Return list of valid period values in seconds corresponding to
+ * the currently active integration time.
+ */
+static ssize_t in_illuminance_period_available_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	int ret, reg, x;
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct veml6030_data *data = iio_priv(indio_dev);
+
+	ret = regmap_read(data->regmap, VEML6030_REG_ALS_CONF, &reg);
+	if (ret) {
+		dev_err(&data->client->dev,
+				"can't read als conf register %d\n", ret);
+		return ret;
+	}
+
+	ret = ((reg >> 6) & 0xF);
+	switch (ret) {
+	case 0:
+	case 1:
+	case 2:
+	case 3:
+		x = ret;
+		break;
+	case 8:
+		x = 4;
+		break;
+	case 12:
+		x = 5;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", period_values[x]);
+}
+
+static IIO_DEVICE_ATTR_RO(in_illuminance_period_available, 0);
+
+static struct attribute *veml6030_event_attributes[] = {
+	&iio_dev_attr_in_illuminance_period_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group veml6030_event_attr_group = {
+	.attrs = veml6030_event_attributes,
+};
+
+static int veml6030_als_pwr_on(struct veml6030_data *data)
+{
+	return regmap_update_bits(data->regmap, VEML6030_REG_ALS_CONF,
+				 VEML6030_ALS_SD, 0);
+}
+
+static int veml6030_als_shut_down(struct veml6030_data *data)
+{
+	return regmap_update_bits(data->regmap, VEML6030_REG_ALS_CONF,
+				 VEML6030_ALS_SD, 1);
+}
+
+static void veml6030_als_shut_down_action(void *data)
+{
+	veml6030_als_shut_down(data);
+}
+
+static const struct iio_event_spec veml6030_event_spec[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_PERIOD),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+/* Channel number */
+enum veml6030_chan {
+	CH_ALS,
+	CH_WHITE,
+};
+
+static const struct iio_chan_spec veml6030_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.channel = CH_ALS,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_PROCESSED) |
+				BIT(IIO_CHAN_INFO_INT_TIME) |
+				BIT(IIO_CHAN_INFO_SCALE),
+		.event_spec = veml6030_event_spec,
+		.num_event_specs = ARRAY_SIZE(veml6030_event_spec),
+	},
+	{
+		.type = IIO_INTENSITY,
+		.channel = CH_WHITE,
+		.modified = 1,
+		.channel2 = IIO_MOD_LIGHT_BOTH,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_PROCESSED),
+	},
+};
+
+static const struct regmap_config veml6030_regmap_config = {
+	.name = "veml6030_regmap",
+	.reg_bits = 8,
+	.val_bits = 16,
+	.max_register = VEML6030_REG_ALS_INT,
+	.val_format_endian = REGMAP_ENDIAN_LITTLE,
+};
+
+static int veml6030_get_intgrn_tm(struct iio_dev *indio_dev,
+						int *val, int *val2)
+{
+	int ret, reg;
+	struct veml6030_data *data = iio_priv(indio_dev);
+
+	ret = regmap_read(data->regmap, VEML6030_REG_ALS_CONF, &reg);
+	if (ret) {
+		dev_err(&data->client->dev,
+				"can't read als conf register %d\n", ret);
+		return ret;
+	}
+
+	switch ((reg >> 6) & 0xF) {
+	case 0:
+		*val2 = 100000;
+		break;
+	case 1:
+		*val2 = 200000;
+		break;
+	case 2:
+		*val2 = 400000;
+		break;
+	case 3:
+		*val2 = 800000;
+		break;
+	case 8:
+		*val2 = 50000;
+		break;
+	case 12:
+		*val2 = 25000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	*val = 0;
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int veml6030_set_intgrn_tm(struct iio_dev *indio_dev,
+						int val, int val2)
+{
+	int ret, new_int_time, int_idx;
+	struct veml6030_data *data = iio_priv(indio_dev);
+
+	if (val)
+		return -EINVAL;
+
+	switch (val2) {
+	case 25000:
+		new_int_time = 0x300;
+		int_idx = 5;
+		break;
+	case 50000:
+		new_int_time = 0x200;
+		int_idx = 4;
+		break;
+	case 100000:
+		new_int_time = 0x00;
+		int_idx = 3;
+		break;
+	case 200000:
+		new_int_time = 0x40;
+		int_idx = 2;
+		break;
+	case 400000:
+		new_int_time = 0x80;
+		int_idx = 1;
+		break;
+	case 800000:
+		new_int_time = 0xC0;
+		int_idx = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_CONF,
+					VEML6030_ALS_IT, new_int_time);
+	if (ret) {
+		dev_err(&data->client->dev,
+				"can't update als integration time %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * Cache current integration time and update resolution. For every
+	 * increase in integration time to next level, resolution is halved
+	 * and vice-versa.
+	 */
+	if (data->cur_integration_time < int_idx)
+		data->cur_resolution <<= int_idx - data->cur_integration_time;
+	else if (data->cur_integration_time > int_idx)
+		data->cur_resolution >>= data->cur_integration_time - int_idx;
+
+	data->cur_integration_time = int_idx;
+
+	return ret;
+}
+
+static int veml6030_read_persistence(struct iio_dev *indio_dev,
+						int *val, int *val2)
+{
+	int ret, reg, period, x, y;
+	struct veml6030_data *data = iio_priv(indio_dev);
+
+	ret = veml6030_get_intgrn_tm(indio_dev, &x, &y);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_read(data->regmap, VEML6030_REG_ALS_CONF, &reg);
+	if (ret) {
+		dev_err(&data->client->dev,
+				"can't read als conf register %d\n", ret);
+	}
+
+	/* integration time multiplied by 1/2/4/8 */
+	period = y * (1 << ((reg >> 4) & 0x03));
+
+	*val = period / 1000000;
+	*val2 = period % 1000000;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int veml6030_write_persistence(struct iio_dev *indio_dev,
+						int val, int val2)
+{
+	int ret, period, x, y;
+	struct veml6030_data *data = iio_priv(indio_dev);
+
+	ret = veml6030_get_intgrn_tm(indio_dev, &x, &y);
+	if (ret < 0)
+		return ret;
+
+	if (!val) {
+		period = val2 / y;
+	} else {
+		if ((val == 1) && (val2 == 600000))
+			period = 1600000 / y;
+		else if ((val == 3) && (val2 == 200000))
+			period = 3200000 / y;
+		else if ((val == 6) && (val2 == 400000))
+			period = 6400000 / y;
+		else
+			period = -1;
+	}
+
+	if (period <= 0 || period > 8 || hweight8(period) != 1)
+		return -EINVAL;
+
+	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_CONF,
+				VEML6030_ALS_PERS, (ffs(period) - 1) << 4);
+	if (ret)
+		dev_err(&data->client->dev,
+				"can't set persistence value %d\n", ret);
+
+	return ret;
+}
+
+static int veml6030_set_als_gain(struct iio_dev *indio_dev,
+						int val, int val2)
+{
+	int ret, new_gain, gain_idx;
+	struct veml6030_data *data = iio_priv(indio_dev);
+
+	if (val == 0 && val2 == 125000) {
+		new_gain = 0x1000; /* 0x02 << 11 */
+		gain_idx = 3;
+	} else if (val == 0 && val2 == 250000) {
+		new_gain = 0x1800;
+		gain_idx = 2;
+	} else if (val == 1 && val2 == 0) {
+		new_gain = 0x00;
+		gain_idx = 1;
+	} else if (val == 2 && val2 == 0) {
+		new_gain = 0x800;
+		gain_idx = 0;
+	} else {
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_CONF,
+					VEML6030_ALS_GAIN, new_gain);
+	if (ret) {
+		dev_err(&data->client->dev,
+				"can't set als gain %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * Cache currently set gain & update resolution. For every
+	 * increase in the gain to next level, resolution is halved
+	 * and vice-versa.
+	 */
+	if (data->cur_gain < gain_idx)
+		data->cur_resolution <<= gain_idx - data->cur_gain;
+	else if (data->cur_gain > gain_idx)
+		data->cur_resolution >>= data->cur_gain - gain_idx;
+
+	data->cur_gain = gain_idx;
+
+	return ret;
+}
+
+static int veml6030_get_als_gain(struct iio_dev *indio_dev,
+						int *val, int *val2)
+{
+	int ret, reg;
+	struct veml6030_data *data = iio_priv(indio_dev);
+
+	ret = regmap_read(data->regmap, VEML6030_REG_ALS_CONF, &reg);
+	if (ret) {
+		dev_err(&data->client->dev,
+				"can't read als conf register %d\n", ret);
+		return ret;
+	}
+
+	switch ((reg >> 11) & 0x03) {
+	case 0:
+		*val = 1;
+		*val2 = 0;
+		break;
+	case 1:
+		*val = 2;
+		*val2 = 0;
+		break;
+	case 2:
+		*val = 0;
+		*val2 = 125000;
+		break;
+	case 3:
+		*val = 0;
+		*val2 = 250000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int veml6030_read_thresh(struct iio_dev *indio_dev,
+						int *val, int *val2, int dir)
+{
+	int ret, reg;
+	struct veml6030_data *data = iio_priv(indio_dev);
+
+	if (dir == IIO_EV_DIR_RISING)
+		ret = regmap_read(data->regmap, VEML6030_REG_ALS_WH, &reg);
+	else
+		ret = regmap_read(data->regmap, VEML6030_REG_ALS_WL, &reg);
+	if (ret) {
+		dev_err(&data->client->dev,
+				"can't read als threshold value %d\n", ret);
+		return ret;
+	}
+
+	*val = reg & 0xffff;
+	return IIO_VAL_INT;
+}
+
+static int veml6030_write_thresh(struct iio_dev *indio_dev,
+						int val, int val2, int dir)
+{
+	int ret;
+	struct veml6030_data *data = iio_priv(indio_dev);
+
+	if (val > 0xFFFF || val < 0 || val2)
+		return -EINVAL;
+
+	if (dir == IIO_EV_DIR_RISING) {
+		ret = regmap_write(data->regmap, VEML6030_REG_ALS_WH, val);
+		if (ret)
+			dev_err(&data->client->dev,
+					"can't set high threshold %d\n", ret);
+	} else {
+		ret = regmap_write(data->regmap, VEML6030_REG_ALS_WL, val);
+		if (ret)
+			dev_err(&data->client->dev,
+					"can't set low threshold %d\n", ret);
+	}
+
+	return ret;
+}
+
+/*
+ * Provide both raw as well as light reading in lux.
+ * light (in lux) = resolution * raw reading
+ */
+static int veml6030_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	int ret, reg;
+	struct veml6030_data *data = iio_priv(indio_dev);
+	struct regmap *regmap = data->regmap;
+	struct device *dev = &data->client->dev;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+	case IIO_CHAN_INFO_PROCESSED:
+		switch (chan->type) {
+		case IIO_LIGHT:
+			ret = regmap_read(regmap, VEML6030_REG_ALS_DATA, &reg);
+			if (ret < 0) {
+				dev_err(dev, "can't read als data %d\n", ret);
+				return ret;
+			}
+			if (mask == IIO_CHAN_INFO_PROCESSED) {
+				*val = (reg * data->cur_resolution) / 10000;
+				*val2 = (reg * data->cur_resolution) % 10000;
+				return IIO_VAL_INT_PLUS_MICRO;
+			}
+			*val = reg;
+			return IIO_VAL_INT;
+		case IIO_INTENSITY:
+			ret = regmap_read(regmap, VEML6030_REG_WH_DATA, &reg);
+			if (ret < 0) {
+				dev_err(dev, "can't read white data %d\n", ret);
+				return ret;
+			}
+			if (mask == IIO_CHAN_INFO_PROCESSED) {
+				*val = (reg * data->cur_resolution) / 10000;
+				*val2 = (reg * data->cur_resolution) % 10000;
+				return IIO_VAL_INT_PLUS_MICRO;
+			}
+			*val = reg;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_INT_TIME:
+		if (chan->type == IIO_LIGHT)
+			return veml6030_get_intgrn_tm(indio_dev, val, val2);
+		return -EINVAL;
+	case IIO_CHAN_INFO_SCALE:
+		if (chan->type == IIO_LIGHT)
+			return veml6030_get_als_gain(indio_dev, val, val2);
+		return -EINVAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int veml6030_write_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int val, int val2, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		switch (chan->type) {
+		case IIO_LIGHT:
+			return veml6030_set_intgrn_tm(indio_dev, val, val2);
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_LIGHT:
+			return veml6030_set_als_gain(indio_dev, val, val2);
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int veml6030_read_event_val(struct iio_dev *indio_dev,
+		const struct iio_chan_spec *chan, enum iio_event_type type,
+		enum iio_event_direction dir, enum iio_event_info info,
+		int *val, int *val2)
+{
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+		case IIO_EV_DIR_FALLING:
+			return veml6030_read_thresh(indio_dev, val, val2, dir);
+		default:
+			return -EINVAL;
+		}
+		break;
+	case IIO_EV_INFO_PERIOD:
+		return veml6030_read_persistence(indio_dev, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int veml6030_write_event_val(struct iio_dev *indio_dev,
+		const struct iio_chan_spec *chan, enum iio_event_type type,
+		enum iio_event_direction dir, enum iio_event_info info,
+		int val, int val2)
+{
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		return veml6030_write_thresh(indio_dev, val, val2, dir);
+	case IIO_EV_INFO_PERIOD:
+		return veml6030_write_persistence(indio_dev, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int veml6030_read_interrupt_config(struct iio_dev *indio_dev,
+		const struct iio_chan_spec *chan, enum iio_event_type type,
+		enum iio_event_direction dir)
+{
+	int ret, reg;
+	struct veml6030_data *data = iio_priv(indio_dev);
+
+	ret = regmap_read(data->regmap, VEML6030_REG_ALS_CONF, &reg);
+	if (ret) {
+		dev_err(&data->client->dev,
+				"can't read als conf register %d\n", ret);
+		return ret;
+	}
+
+	if (reg & VEML6030_ALS_INT_EN)
+		return 1;
+	else
+		return 0;
+}
+
+/*
+ * Sensor should not be measuring light when interrupt is configured.
+ * Therefore correct sequence to configure interrupt functionality is:
+ * shut down -> enable/disable interrupt -> power on
+ *
+ * state = 1 enables interrupt, state = 0 disables interrupt
+ */
+static int veml6030_write_interrupt_config(struct iio_dev *indio_dev,
+		const struct iio_chan_spec *chan, enum iio_event_type type,
+		enum iio_event_direction dir, int state)
+{
+	int ret;
+	struct veml6030_data *data = iio_priv(indio_dev);
+
+	if (state < 0 || state > 1)
+		return -EINVAL;
+
+	ret = veml6030_als_shut_down(data);
+	if (ret < 0) {
+		dev_err(&data->client->dev,
+			"can't disable als to configure interrupt %d\n", ret);
+		return ret;
+	}
+
+	/* enable interrupt + power on */
+	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_CONF,
+			VEML6030_ALS_INT_EN | VEML6030_ALS_SD, state << 1);
+	if (ret)
+		dev_err(&data->client->dev,
+			"can't enable interrupt & poweron als %d\n", ret);
+
+	return ret;
+}
+
+static const struct iio_info veml6030_info = {
+	.read_raw  = veml6030_read_raw,
+	.write_raw = veml6030_write_raw,
+	.read_event_value = veml6030_read_event_val,
+	.write_event_value	= veml6030_write_event_val,
+	.read_event_config = veml6030_read_interrupt_config,
+	.write_event_config	= veml6030_write_interrupt_config,
+	.attrs = &veml6030_attr_group,
+	.event_attrs = &veml6030_event_attr_group,
+};
+
+static const struct iio_info veml6030_info_no_irq = {
+	.read_raw  = veml6030_read_raw,
+	.write_raw = veml6030_write_raw,
+	.attrs = &veml6030_attr_group,
+};
+
+static irqreturn_t veml6030_event_handler(int irq, void *private)
+{
+	int ret, reg, evtdir;
+	struct iio_dev *indio_dev = private;
+	struct veml6030_data *data = iio_priv(indio_dev);
+
+	ret = regmap_read(data->regmap, VEML6030_REG_ALS_INT, &reg);
+	if (ret) {
+		dev_err(&data->client->dev,
+				"can't read als interrupt register %d\n", ret);
+		return IRQ_HANDLED;
+	}
+
+	/* Spurious interrupt handling */
+	if (!(reg & (VEML6030_INT_TH_HIGH | VEML6030_INT_TH_LOW)))
+		return IRQ_NONE;
+
+	if (reg & VEML6030_INT_TH_HIGH)
+		evtdir = IIO_EV_DIR_RISING;
+	else
+		evtdir = IIO_EV_DIR_FALLING;
+
+	iio_push_event(indio_dev, IIO_UNMOD_EVENT_CODE(IIO_INTENSITY,
+					0, IIO_EV_TYPE_THRESH, evtdir),
+					iio_get_time_ns(indio_dev));
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * Set ALS gain to 1/8, integration time to 100 ms, PSM to mode 2,
+ * persistence to 1 x integration time and the threshold
+ * interrupt disabled by default. First shutdown the sensor,
+ * update registers and then power on the sensor.
+ */
+static int veml6030_hw_init(struct iio_dev *indio_dev)
+{
+	int ret, val;
+	struct veml6030_data *data = iio_priv(indio_dev);
+	struct i2c_client *client = data->client;
+
+	ret = veml6030_als_shut_down(data);
+	if (ret) {
+		dev_err(&client->dev, "can't shutdown als %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_write(data->regmap, VEML6030_REG_ALS_CONF, 0x1001);
+	if (ret) {
+		dev_err(&client->dev, "can't setup als configs %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_PSM,
+				 VEML6030_PSM | VEML6030_PSM_EN, 0x03);
+	if (ret) {
+		dev_err(&client->dev, "can't setup default PSM %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_write(data->regmap, VEML6030_REG_ALS_WH, 0xFFFF);
+	if (ret) {
+		dev_err(&client->dev, "can't setup high threshold %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_write(data->regmap, VEML6030_REG_ALS_WL, 0x0000);
+	if (ret) {
+		dev_err(&client->dev, "can't setup low threshold %d\n", ret);
+		return ret;
+	}
+
+	ret = veml6030_als_pwr_on(data);
+	if (ret) {
+		dev_err(&client->dev, "can't poweron als %d\n", ret);
+		return ret;
+	}
+
+	/* Wait 4 ms to let processor & oscillator start correctly */
+	usleep_range(4000, 4002);
+
+	/* Clear stale interrupt status bits if any during start */
+	ret = regmap_read(data->regmap, VEML6030_REG_ALS_INT, &val);
+	if (ret < 0) {
+		dev_err(&client->dev,
+			"can't clear als interrupt status %d\n", ret);
+		return ret;
+	}
+
+	/* Cache currently active measurement parameters */
+	data->cur_gain = 3;
+	data->cur_resolution = 4608;
+	data->cur_integration_time = 3;
+
+	return ret;
+}
+
+static int veml6030_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	int ret;
+	struct veml6030_data *data;
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+		dev_err(&client->dev, "i2c adapter doesn't support plain i2c\n");
+		return -EOPNOTSUPP;
+	}
+
+	regmap = devm_regmap_init_i2c(client, &veml6030_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&client->dev, "can't setup regmap\n");
+		return PTR_ERR(regmap);
+	}
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+	data->regmap = regmap;
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->name = "veml6030";
+	indio_dev->channels = veml6030_channels;
+	indio_dev->num_channels = ARRAY_SIZE(veml6030_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	if (client->irq) {
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						NULL, veml6030_event_handler,
+						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+						"veml6030", indio_dev);
+		if (ret < 0) {
+			dev_err(&client->dev,
+					"irq %d request failed\n", client->irq);
+			return ret;
+		}
+		indio_dev->info = &veml6030_info;
+	} else {
+		indio_dev->info = &veml6030_info_no_irq;
+	}
+
+	ret = veml6030_hw_init(indio_dev);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_add_action_or_reset(&client->dev,
+					veml6030_als_shut_down_action, data);
+	if (ret < 0)
+		return ret;
+
+	return devm_iio_device_register(&client->dev, indio_dev);
+}
+
+static int __maybe_unused veml6030_runtime_suspend(struct device *dev)
+{
+	int ret;
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct veml6030_data *data = iio_priv(indio_dev);
+
+	ret = veml6030_als_shut_down(data);
+	if (ret < 0)
+		dev_err(&data->client->dev, "can't suspend als %d\n", ret);
+
+	return ret;
+}
+
+static int __maybe_unused veml6030_runtime_resume(struct device *dev)
+{
+	int ret;
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct veml6030_data *data = iio_priv(indio_dev);
+
+	ret = veml6030_als_pwr_on(data);
+	if (ret < 0)
+		dev_err(&data->client->dev, "can't resume als %d\n", ret);
+
+	return ret;
+}
+
+static const struct dev_pm_ops veml6030_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(veml6030_runtime_suspend,
+				veml6030_runtime_resume, NULL)
+};
+
+static const struct of_device_id veml6030_of_match[] = {
+	{ .compatible = "vishay,veml6030" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, veml6030_of_match);
+
+static const struct i2c_device_id veml6030_id[] = {
+	{ "veml6030", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, veml6030_id);
+
+static struct i2c_driver veml6030_driver = {
+	.driver = {
+		.name = "veml6030",
+		.of_match_table = veml6030_of_match,
+		.pm = &veml6030_pm_ops,
+	},
+	.probe = veml6030_probe,
+	.id_table = veml6030_id,
+};
+module_i2c_driver(veml6030_driver);
+
+MODULE_AUTHOR("Rishi Gupta <gupt21@gmail.com>");
+MODULE_DESCRIPTION("VEML6030 Ambient Light Sensor");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

