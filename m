Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04EC944087F
	for <lists+linux-iio@lfdr.de>; Sat, 30 Oct 2021 13:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbhJ3LVI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 30 Oct 2021 07:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbhJ3LVH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 30 Oct 2021 07:21:07 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32775C061570
        for <linux-iio@vger.kernel.org>; Sat, 30 Oct 2021 04:18:37 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id x33-20020a17090a6c2400b001a63ef25836so3045427pjj.3
        for <linux-iio@vger.kernel.org>; Sat, 30 Oct 2021 04:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=As1oSmn2KfTKHWYj5vhtOqfUlB8+JtyqUfj6hUcYW8A=;
        b=jegrsBDMbp+vcmJ0hqi+Jc7jkL9tZyAjAvKUpBOf0v7sOQyAP2EMt2WY3NOyqdL69I
         nJzEU/ATRH3ZHV7A8GGXUdLRSC13GzSLnAOgdnSls+z+RkO1jyi4ybxfqUQj2lWeNMiB
         eTOQ2o4m6VlRq8dk5k+2NxR+9rqOGs562MlTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=As1oSmn2KfTKHWYj5vhtOqfUlB8+JtyqUfj6hUcYW8A=;
        b=QT7kltC2ECQk5Y4kvKVuVwovOA9HTyCv0hAicpwYZ7bP4sVNNgdxmJlhduTNc1PgY1
         mmnjLgI4cH6nIIO2r8rCTHGItQ7rh11EmdquZBOEY6YPn3oNr7oiInTDnn8/Fi+ohBXi
         gB2w9iIvkLvaCRoZOtqw1TqgTbuTeZqXzI22VkZR40xIuCy/VzevEvWrAE3rV8+9l9gD
         zMxXc64z4azxc0qZS2vhdFY1roYeEGZqVWwMxE5woQbXxKhqigzBgQG/YcrvOG1k8ysj
         DYpE1sQ4NdNeYLVEz0ddcnZRHuSXasrHnpNQcGl0aP349XednwjiUAV//u4oFQb4Q8rE
         o6kQ==
X-Gm-Message-State: AOAM530EkK3FFXBv4TLFa3CrIQ9WhXARPevz0BsMCiyIYsZFwckkubbO
        hMzTjq/EHGdEfjuyckU9dT1n/Q==
X-Google-Smtp-Source: ABdhPJzHEv4AHYh4S9b5yxXfaqGf+2WoezMkFxpFMTUebD62Vu1cIGjJQjTV6JnwNnH4gIDIfoSEVg==
X-Received: by 2002:a17:90b:1d92:: with SMTP id pf18mr25643053pjb.38.1635592716575;
        Sat, 30 Oct 2021 04:18:36 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:71f1:234f:bb3d:6ccf])
        by smtp.gmail.com with UTF8SMTPSA id j10sm9973213pfu.164.2021.10.30.04.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Oct 2021 04:18:36 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, swboyd@chromium.org
Cc:     andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 3/5] iio: proximity: Add SX9324 support
Date:   Sat, 30 Oct 2021 04:18:25 -0700
Message-Id: <20211030111827.1494139-4-gwendal@chromium.org>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
In-Reply-To: <20211030111827.1494139-1-gwendal@chromium.org>
References: <20211030111827.1494139-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Semtech SAR sensor SX9324 is an evolution of the SX9310:
It has 4 phases that can be configure to capture and process data
from any of 3 CS pins and provide independent detection:
proximity, table proximity or body proximity.

Gather antenna data:
echo sx9324-dev3 > trigger/current_trigger
echo 1 > scan_elements/in_proximity0_en
echo 1 > buffer/enable
od -v -An --endian=big -t d2 -w2 /dev/iio\:device3
(at 10Hz, the default).

Trigger events:
Setting:
thresh_falling_period: 2 (events)
thresh_rising_period: 2 (events)
in_proximity0_thresh_either_value: 300
in_proximity0_thresh_either_hysteresis: 72

using iio_event_monitor /dev/iio\:deviceX, approaching my hand to the
antenna pad, I see:
...
Event: time: 1634763907532035297, type: proximity, channel: 0, evtype:
thresh, direction: falling
Event: time: 1634763910138104640, type: proximity, channel: 0, evtype:
thresh, direction: rising
...

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/iio/proximity/Kconfig  |  18 +
 drivers/iio/proximity/Makefile |   3 +-
 drivers/iio/proximity/sx9324.c | 931 +++++++++++++++++++++++++++++++++
 3 files changed, 951 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/proximity/sx9324.c

diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
index 7c7203ca3ac63..aaddf97f9b219 100644
--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -112,11 +112,15 @@ config SRF04
 	  To compile this driver as a module, choose M here: the
 	  module will be called srf04.
 
+config SX_COMMON
+	tristate
+
 config SX9310
 	tristate "SX9310/SX9311 Semtech proximity sensor"
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	select REGMAP_I2C
+	select SX_COMMON
 	depends on I2C
 	help
 	  Say Y here to build a driver for Semtech's SX9310/SX9311 capacitive
@@ -125,6 +129,20 @@ config SX9310
 	  To compile this driver as a module, choose M here: the
 	  module will be called sx9310.
 
+config SX9324
+	tristate "SX9324 Semtech proximity sensor"
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	select REGMAP_I2C
+	select SX_COMMON
+	depends on I2C
+	help
+	  Say Y here to build a driver for Semtech's SX9324
+	  proximity/button sensor.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called sx9324.
+
 config SX9500
 	tristate "SX9500 Semtech proximity sensor"
 	select IIO_BUFFER
diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
index cbdac09433eb5..1b026fedc396c 100644
--- a/drivers/iio/proximity/Makefile
+++ b/drivers/iio/proximity/Makefile
@@ -14,7 +14,8 @@ obj-$(CONFIG_RFD77402)		+= rfd77402.o
 obj-$(CONFIG_SRF04)		+= srf04.o
 obj-$(CONFIG_SRF08)		+= srf08.o
 obj-$(CONFIG_SX9310)		+= sx9310.o
+obj-$(CONFIG_SX9324)		+= sx9324.o
+obj-$(CONFIG_SX_COMMON) 	+= sx_common.o
 obj-$(CONFIG_SX9500)		+= sx9500.o
 obj-$(CONFIG_VCNL3020)		+= vcnl3020.o
 obj-$(CONFIG_VL53L0X_I2C)	+= vl53l0x-i2c.o
-
diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
new file mode 100644
index 0000000000000..41d9c950c5abd
--- /dev/null
+++ b/drivers/iio/proximity/sx9324.c
@@ -0,0 +1,931 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2021 Google LLC.
+ *
+ * Driver for Semtech's SX9324 capacitive proximity/button solution.
+ * Based on SX9324 driver and copy of datasheet at:
+ * https://edit.wpgdadawant.com/uploads/news_file/program/2019/30184/tech_files/program_30184_suggest_other_file.pdf
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/acpi.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/irq.h>
+#include <linux/gpio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/log2.h>
+#include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+
+#include <linux/iio/proximity/sx_common.h>
+
+#define SX9324_DRIVER_NAME		"sx9324"
+
+/* Register definitions. */
+#define SX9324_REG_IRQ_SRC		SX_COMMON_REG_IRQ_SRC
+#define SX9324_REG_STAT0		0x01
+#define SX9324_REG_STAT1		0x02
+#define SX9324_REG_STAT2		0x03
+#define SX9324_REG_STAT2_COMPSTAT_MASK	GENMASK(3, 0)
+#define SX9324_REG_STAT3		0x04
+#define SX9324_REG_IRQ_MSK		0x05
+#define SX9324_CONVDONE_IRQ		BIT(3)
+#define SX9324_FAR_IRQ			BIT(5)
+#define SX9324_CLOSE_IRQ		BIT(6)
+#define SX9324_REG_IRQ_CFG0		0x06
+#define SX9324_REG_IRQ_CFG1		0x07
+#define SX9324_REG_IRQ_CFG1_FAILCOND    0x80
+#define SX9324_REG_IRQ_CFG2		0x08
+
+#define SX9324_REG_GNRL_CTRL0		0x10
+#define SX9324_REG_GNRL_CTRL0_SCANPERIOD_MASK GENMASK(4, 0)
+#define SX9324_REG_GNRL_CTRL0_SCANPERIOD_100MS 0x16
+#define SX9324_REG_GNRL_CTRL1		0x11
+#define SX9324_REG_GNRL_CTRL1_PHEN_MASK GENMASK(3, 0)
+#define SX9324_REG_GNRL_CTRL1_PAUSECTRL 0x20
+
+#define SX9324_REG_I2C_ADDR		0x14
+#define SX9324_REG_CLK_SPRD		0x15
+
+#define SX9324_REG_AFE_CTRL0		0x20
+#define SX9324_REG_AFE_CTRL1		0x21
+#define SX9324_REG_AFE_CTRL2		0x22
+#define SX9324_REG_AFE_CTRL3		0x23
+#define SX9324_REG_AFE_CTRL4		0x24
+#define SX9324_REG_AFE_CTRL4_FREQ_83_33HZ 0x40
+#define SX9324_REG_AFE_CTRL4_RESOLUTION_MASK GENMASK(2, 0)
+#define SX9324_REG_AFE_CTRL4_RES_100	0x04
+#define SX9324_REG_AFE_CTRL5		0x25
+#define SX9324_REG_AFE_CTRL6		0x26
+#define SX9324_REG_AFE_CTRL7		0x27
+#define SX9324_REG_AFE_PH0		0x28
+#define SX9324_REG_AFE_PH0_PIN_MASK(_pin) \
+	GENMASK(2 * (_pin) + 1, 2 * (_pin))
+
+#define SX9324_REG_AFE_PH1		0x29
+#define SX9324_REG_AFE_PH2		0x2a
+#define SX9324_REG_AFE_PH3		0x2b
+#define SX9324_REG_AFE_CTRL8		0x2c
+#define SX9324_REG_AFE_CTRL8_RESFILTN_4KOHM 0x02
+#define SX9324_REG_AFE_CTRL9		0x2d
+#define SX9324_REG_AFE_CTRL9_AGAIN_1	0x08
+
+#define SX9324_REG_PROX_CTRL0		0x30
+#define SX9324_REG_PROX_CTRL0_GAIN_MASK	GENMASK(5, 3)
+#define SX9324_REG_PROX_CTRL0_GAIN_1		0x80
+#define SX9324_REG_PROX_CTRL0_RAWFILT_1P50	0x01
+#define SX9324_REG_PROX_CTRL1		0x31
+#define SX9324_REG_PROX_CTRL2		0x32
+#define SX9324_REG_PROX_CTRL2_AVGNEG_THRESH_16K 0x20
+#define SX9324_REG_PROX_CTRL3		0x33
+#define SX9324_REG_PROX_CTRL3_AVGDEB_2SAMPLES	0x40
+#define SX9324_REG_PROX_CTRL3_AVGPOS_THRESH_16K 0x20
+#define SX9324_REG_PROX_CTRL4		0x34
+#define SX9324_REG_PROX_CTRL4_AVGNEGFILT_MASK	GENMASK(5, 3)
+#define SX9324_REG_PROX_CTRL4_AVGNEG_FILT_1P50 0x08
+#define SX9324_REG_PROX_CTRL4_AVGPOSFILT_MASK	GENMASK(2, 0)
+#define SX9324_REG_PROX_CTRL3_AVGPOS_FILT_1P256 0x04
+#define SX9324_REG_PROX_CTRL5		0x35
+#define SX9324_REG_PROX_CTRL5_HYST_MASK			GENMASK(5, 4)
+#define SX9324_REG_PROX_CTRL5_CLOSE_DEBOUNCE_MASK	GENMASK(3, 2)
+#define SX9324_REG_PROX_CTRL5_FAR_DEBOUNCE_MASK		GENMASK(1, 0)
+#define SX9324_REG_PROX_CTRL6		0x36
+#define SX9324_REG_PROX_CTRL6_PROXTHRESH_32	0x08
+#define SX9324_REG_PROX_CTRL7		0x37
+
+#define SX9324_REG_ADV_CTRL0		0x40
+#define SX9324_REG_ADV_CTRL1		0x41
+#define SX9324_REG_ADV_CTRL2		0x42
+#define SX9324_REG_ADV_CTRL3		0x43
+#define SX9324_REG_ADV_CTRL4		0x44
+#define SX9324_REG_ADV_CTRL5		0x45
+#define SX9324_REG_ADV_CTRL5_STARTUPSENS_MASK GENMASK(3, 2)
+#define SX9324_REG_ADV_CTRL5_STARTUP_SENSOR_1	0x04
+#define SX9324_REG_ADV_CTRL5_STARTUP_METHOD_1	0x01
+#define SX9324_REG_ADV_CTRL6		0x46
+#define SX9324_REG_ADV_CTRL7		0x47
+#define SX9324_REG_ADV_CTRL8		0x48
+#define SX9324_REG_ADV_CTRL9		0x49
+#define SX9324_REG_ADV_CTRL10		0x4a
+#define SX9324_REG_ADV_CTRL11		0x4b
+#define SX9324_REG_ADV_CTRL12		0x4c
+#define SX9324_REG_ADV_CTRL13		0x4d
+#define SX9324_REG_ADV_CTRL14		0x4e
+#define SX9324_REG_ADV_CTRL15		0x4f
+#define SX9324_REG_ADV_CTRL16		0x50
+#define SX9324_REG_ADV_CTRL17		0x51
+#define SX9324_REG_ADV_CTRL18		0x52
+#define SX9324_REG_ADV_CTRL19		0x53
+#define SX9324_REG_ADV_CTRL20		0x54
+#define SX9324_REG_ADV_CTRL19_HIGHT_FAILURE_THRESH_SATURATION 0xf0
+
+#define SX9324_REG_PHASE_SEL		0x60
+
+#define SX9324_REG_USEFUL_MSB		0x61
+#define SX9324_REG_USEFUL_LSB		0x62
+
+#define SX9324_REG_AVG_MSB		0x63
+#define SX9324_REG_AVG_LSB		0x64
+
+#define SX9324_REG_DIFF_MSB		0x65
+#define SX9324_REG_DIFF_LSB		0x66
+
+#define SX9324_REG_OFFSET_MSB		0x67
+#define SX9324_REG_OFFSET_LSB		0x68
+
+#define SX9324_REG_SAR_MSB		0x69
+#define SX9324_REG_SAR_LSB		0x6a
+
+#define SX9324_REG_RESET		0x9f
+/* Write this to REG_RESET to do a soft reset. */
+#define SX9324_SOFT_RESET		0xde
+
+#define SX9324_REG_WHOAMI		0xfa
+#define SX9324_REG_REVISION		0xfe
+
+/* 4 channels, as defined in STAT0: PH0, PH1, PH2 and PH3. */
+#define SX9324_NUM_CHANNELS		4
+/* 3 CS pins: CS0, CS1, CS2. */
+#define SX9324_NUM_PINS			3
+
+#define SX9324_CHANNEL(idx)						\
+	{								\
+		.type = IIO_PROXIMITY,					\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+				      BIT(IIO_CHAN_INFO_HARDWAREGAIN),	\
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
+		.info_mask_separate_available =				\
+			BIT(IIO_CHAN_INFO_HARDWAREGAIN),		\
+		.indexed = 1,						\
+		.channel = idx,						\
+		.address = SX9324_REG_DIFF_MSB,				\
+		.event_spec = sx_common_events,				\
+		.num_event_specs = ARRAY_SIZE(sx_common_events),	\
+		.scan_index = idx,					\
+		.scan_type = {						\
+			.sign = 's',					\
+			.realbits = 12,					\
+			.storagebits = 16,				\
+			.endianness = IIO_BE,				\
+		},							\
+	}
+
+static const struct iio_chan_spec sx9324_channels[] = {
+	SX9324_CHANNEL(0),			/* Phase 0 */
+	SX9324_CHANNEL(1),			/* Phase 1 */
+	SX9324_CHANNEL(2),			/* Phase 2 */
+	SX9324_CHANNEL(3),			/* Phase 3 */
+	IIO_CHAN_SOFT_TIMESTAMP(4),
+};
+
+static const char * const sx9324_cs_pin_usage[] = { "HZ", "MI", "DS", "GD" };
+
+static ssize_t sx9324_phase_configuration_show(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
+{
+	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct sx_common_data *data = iio_priv(indio_dev);
+	unsigned int val;
+	int i, ret, pin_idx;
+	size_t len = 0;
+
+	ret = regmap_read(data->regmap, SX9324_REG_AFE_PH0 + this_attr->address, &val);
+
+	for (i = 0; i < SX9324_NUM_PINS; i++) {
+		pin_idx = (val & SX9324_REG_AFE_PH0_PIN_MASK(i)) >> (2 * i);
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%s,",
+				 sx9324_cs_pin_usage[pin_idx]);
+	}
+	buf[len - 1] = '\n';
+	return len;
+}
+
+static ssize_t sx9324_phase_configuration_store(struct device *dev,
+						struct device_attribute *attr,
+						const char *buf,
+						size_t len)
+{
+	return -EINVAL;
+}
+
+#define IIO_DEV_ATTR_PHASE_CONFIG(_idx) \
+IIO_DEVICE_ATTR(in_proximity_configuration##_idx, 0644, \
+		sx9324_phase_configuration_show, \
+		sx9324_phase_configuration_store, _idx)
+
+static IIO_DEV_ATTR_PHASE_CONFIG(0);
+static IIO_DEV_ATTR_PHASE_CONFIG(1);
+static IIO_DEV_ATTR_PHASE_CONFIG(2);
+static IIO_DEV_ATTR_PHASE_CONFIG(3);
+
+/*
+ * Each entry contains the integer part (val) and the fractional part, in micro
+ * seconds. It conforms to the IIO output IIO_VAL_INT_PLUS_MICRO.
+ */
+static const struct {
+	int val;
+	int val2;
+} sx9324_samp_freq_table[] = {
+	{1000, 0},  /* 00000: Min (no idle time) */
+	{500, 0},  /* 00001: 2 ms */
+	{250, 0},  /* 00010: 4 ms */
+	{166, 666666},  /* 00011: 6 ms */
+	{125, 0},  /* 00100: 8 ms */
+	{100, 0},  /* 00101: 10 ms */
+	{71, 428571},  /* 00110: 14 ms */
+	{55, 555556},  /* 00111: 18 ms */
+	{45, 454545},  /* 01000: 22 ms */
+	{38, 461538},  /* 01001: 26 ms */
+	{33, 333333},  /* 01010: 30 ms */
+	{29, 411765},  /* 01011: 34 ms */
+	{26, 315789},  /* 01100: 38 ms */
+	{23, 809524},  /* 01101: 42 ms */
+	{21, 739130},  /* 01110: 46 ms */
+	{20, 0},  /* 01111: 50 ms */
+	{17, 857143},  /* 10000: 56 ms */
+	{16, 129032},  /* 10001: 62 ms */
+	{14, 705882},  /* 10010: 68 ms */
+	{13, 513514},  /* 10011: 74 ms */
+	{12, 500000},  /* 10100: 80 ms */
+	{11, 111111},  /* 10101: 90 ms */
+	{10, 0},  /* 10110: 100 ms (Typ.) */
+	{5, 0},  /* 10111: 200 ms */
+	{3, 333333},  /* 11000: 300 ms */
+	{2, 500000},  /* 11001: 400 ms */
+	{1, 666667},  /* 11010: 600 ms */
+	{1, 250000},  /* 11011: 800 ms */
+	{1, 0},  /* 11100: 1 s */
+	{0, 500000},  /* 11101: 2 s */
+	{0, 333333},  /* 11110: 3 s */
+	{0, 250000},  /* 11111: 4 s */
+};
+
+static const unsigned int sx9324_scan_period_table[] = {
+	2,   15,  30,  45,   60,   90,	 120,  200,
+	400, 600, 800, 1000, 2000, 3000, 4000, 5000,
+};
+
+static ssize_t sx9324_show_samp_freq_avail(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	size_t len = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(sx9324_samp_freq_table); i++)
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%d.%d ",
+				 sx9324_samp_freq_table[i].val,
+				 sx9324_samp_freq_table[i].val2);
+	buf[len - 1] = '\n';
+	return len;
+}
+static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(sx9324_show_samp_freq_avail);
+
+static const struct regmap_range sx9324_writable_reg_ranges[] = {
+	/*
+	 * To set COMPSTAT for compensation, even if datasheet says register is
+	 * RO.
+	 */
+	regmap_reg_range(SX9324_REG_STAT2, SX9324_REG_STAT2),
+	regmap_reg_range(SX9324_REG_IRQ_MSK, SX9324_REG_IRQ_CFG2),
+	regmap_reg_range(SX9324_REG_GNRL_CTRL0, SX9324_REG_GNRL_CTRL1),
+	/* Leave i2c and clock spreading as unavailable */
+	regmap_reg_range(SX9324_REG_AFE_CTRL0, SX9324_REG_AFE_CTRL9),
+	regmap_reg_range(SX9324_REG_PROX_CTRL0, SX9324_REG_PROX_CTRL7),
+	regmap_reg_range(SX9324_REG_ADV_CTRL0, SX9324_REG_ADV_CTRL20),
+	regmap_reg_range(SX9324_REG_PHASE_SEL, SX9324_REG_PHASE_SEL),
+	regmap_reg_range(SX9324_REG_OFFSET_MSB, SX9324_REG_OFFSET_LSB),
+	regmap_reg_range(SX9324_REG_RESET, SX9324_REG_RESET),
+};
+
+static const struct regmap_access_table sx9324_writeable_regs = {
+	.yes_ranges = sx9324_writable_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(sx9324_writable_reg_ranges),
+};
+
+/*
+ * All allocated registers are readable, so we just list unallocated
+ * ones.
+ */
+static const struct regmap_range sx9324_non_readable_reg_ranges[] = {
+	regmap_reg_range(SX9324_REG_IRQ_CFG2 + 1, SX9324_REG_GNRL_CTRL0 - 1),
+	regmap_reg_range(SX9324_REG_GNRL_CTRL1 + 1, SX9324_REG_AFE_CTRL0 - 1),
+	regmap_reg_range(SX9324_REG_AFE_CTRL9 + 1, SX9324_REG_PROX_CTRL0 - 1),
+	regmap_reg_range(SX9324_REG_PROX_CTRL7 + 1, SX9324_REG_ADV_CTRL0 - 1),
+	regmap_reg_range(SX9324_REG_ADV_CTRL20 + 1, SX9324_REG_PHASE_SEL - 1),
+	regmap_reg_range(SX9324_REG_SAR_LSB + 1, SX9324_REG_RESET - 1),
+	regmap_reg_range(SX9324_REG_RESET + 1, SX9324_REG_WHOAMI - 1),
+	regmap_reg_range(SX9324_REG_WHOAMI + 1, SX9324_REG_REVISION - 1),
+};
+
+static const struct regmap_access_table sx9324_readable_regs = {
+	.no_ranges = sx9324_non_readable_reg_ranges,
+	.n_no_ranges = ARRAY_SIZE(sx9324_non_readable_reg_ranges),
+};
+
+static const struct regmap_range sx9324_volatile_reg_ranges[] = {
+	regmap_reg_range(SX9324_REG_IRQ_SRC, SX9324_REG_STAT3),
+	regmap_reg_range(SX9324_REG_USEFUL_MSB, SX9324_REG_DIFF_LSB),
+	regmap_reg_range(SX9324_REG_SAR_MSB, SX9324_REG_SAR_LSB),
+	regmap_reg_range(SX9324_REG_WHOAMI, SX9324_REG_WHOAMI),
+	regmap_reg_range(SX9324_REG_REVISION, SX9324_REG_REVISION),
+};
+
+static const struct regmap_access_table sx9324_volatile_regs = {
+	.yes_ranges = sx9324_volatile_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(sx9324_volatile_reg_ranges),
+};
+
+static const struct regmap_config sx9324_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = SX9324_REG_REVISION,
+	.cache_type = REGCACHE_RBTREE,
+
+	.wr_table = &sx9324_writeable_regs,
+	.rd_table = &sx9324_readable_regs,
+	.volatile_table = &sx9324_volatile_regs,
+};
+
+static int sx9324_read_prox_data(struct sx_common_data *data,
+				 const struct iio_chan_spec *chan,
+				 __be16 *val)
+{
+	int ret;
+
+	ret = regmap_write(data->regmap, SX9324_REG_PHASE_SEL, chan->channel);
+	if (ret < 0)
+		return ret;
+
+	return regmap_bulk_read(data->regmap, chan->address, val, sizeof(*val));
+}
+
+/*
+ * If we have no interrupt support, we have to wait for a scan period
+ * after enabling a channel to get a result.
+ */
+static int sx9324_wait_for_sample(struct sx_common_data *data)
+{
+	int ret;
+	unsigned int val;
+
+	ret = regmap_read(data->regmap, SX9324_REG_GNRL_CTRL0, &val);
+	if (ret < 0)
+		return ret;
+	val = FIELD_GET(SX9324_REG_GNRL_CTRL0_SCANPERIOD_MASK, val);
+
+	msleep(sx9324_scan_period_table[val]);
+
+	return 0;
+}
+
+static int sx9324_read_gain(struct sx_common_data *data,
+			    const struct iio_chan_spec *chan, int *val)
+{
+	unsigned int reg, regval;
+	int ret;
+
+	reg = SX9324_REG_PROX_CTRL0 + chan->channel / 2;
+	ret = regmap_read(data->regmap, reg, &regval);
+	if (ret)
+		return ret;
+
+	*val = 1 << FIELD_GET(SX9324_REG_PROX_CTRL0_GAIN_MASK, regval);
+
+	return IIO_VAL_INT;
+}
+
+static int sx9324_read_samp_freq(struct sx_common_data *data,
+				 int *val, int *val2)
+{
+	int ret;
+	unsigned int regval;
+
+	ret = regmap_read(data->regmap, SX9324_REG_GNRL_CTRL0, &regval);
+	if (ret)
+		return ret;
+
+	regval = FIELD_GET(SX9324_REG_GNRL_CTRL0_SCANPERIOD_MASK, regval);
+	*val = sx9324_samp_freq_table[regval].val;
+	*val2 = sx9324_samp_freq_table[regval].val2;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int sx9324_read_raw(struct iio_dev *indio_dev,
+			   const struct iio_chan_spec *chan,
+			   int *val, int *val2, long mask)
+{
+	struct sx_common_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		ret = sx_common_read_proximity(data, chan, val);
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		ret = sx9324_read_gain(data, chan, val);
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return sx9324_read_samp_freq(data, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int sx9324_set_samp_freq(struct sx_common_data *data,
+				int val, int val2)
+{
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(sx9324_samp_freq_table); i++)
+		if (val == sx9324_samp_freq_table[i].val &&
+		    val2 == sx9324_samp_freq_table[i].val2)
+			break;
+
+	if (i == ARRAY_SIZE(sx9324_samp_freq_table))
+		return -EINVAL;
+
+	mutex_lock(&data->mutex);
+
+	ret = regmap_update_bits(data->regmap,
+				 SX9324_REG_GNRL_CTRL0,
+				 SX9324_REG_GNRL_CTRL0_SCANPERIOD_MASK, i);
+
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static int sx9324_read_thresh(struct sx_common_data *data,
+			      const struct iio_chan_spec *chan, int *val)
+{
+	unsigned int reg;
+	unsigned int regval;
+	int ret;
+
+	/*
+	 * TODO(gwendal): Depending on the phase function
+	 * (proximity/table/body), retrieve the right threshold.
+	 */
+	reg = SX9324_REG_PROX_CTRL6 + chan->channel / 2;
+	ret = regmap_read(data->regmap, reg, &regval);
+	if (ret)
+		return ret;
+
+	if (regval <= 1)
+		*val = regval;
+	else
+		*val = (regval * regval) / 2;
+
+	return IIO_VAL_INT;
+}
+
+static int sx9324_read_hysteresis(struct sx_common_data *data,
+				  const struct iio_chan_spec *chan, int *val)
+{
+	unsigned int regval, pthresh;
+	int ret;
+
+	ret = sx9324_read_thresh(data, chan, &pthresh);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_read(data->regmap, SX9324_REG_PROX_CTRL5, &regval);
+	if (ret)
+		return ret;
+
+	regval = FIELD_GET(SX9324_REG_PROX_CTRL5_HYST_MASK, regval);
+	if (!regval)
+		*val = 0;
+	else
+		*val = pthresh >> (5 - regval);
+
+	return IIO_VAL_INT;
+}
+
+static int sx9324_read_far_debounce(struct sx_common_data *data, int *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(data->regmap, SX9324_REG_PROX_CTRL5, &regval);
+	if (ret)
+		return ret;
+
+	regval = FIELD_GET(SX9324_REG_PROX_CTRL5_FAR_DEBOUNCE_MASK, regval);
+	if (regval)
+		*val = 1 << regval;
+	else
+		*val = 0;
+
+	return IIO_VAL_INT;
+}
+
+static int sx9324_read_close_debounce(struct sx_common_data *data, int *val)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(data->regmap, SX9324_REG_PROX_CTRL5, &regval);
+	if (ret)
+		return ret;
+
+	regval = FIELD_GET(SX9324_REG_PROX_CTRL5_CLOSE_DEBOUNCE_MASK, regval);
+	if (regval)
+		*val = 1 << regval;
+	else
+		*val = 0;
+
+	return IIO_VAL_INT;
+}
+
+static int sx9324_read_event_val(struct iio_dev *indio_dev,
+				 const struct iio_chan_spec *chan,
+				 enum iio_event_type type,
+				 enum iio_event_direction dir,
+				 enum iio_event_info info, int *val, int *val2)
+{
+	struct sx_common_data *data = iio_priv(indio_dev);
+
+	if (chan->type != IIO_PROXIMITY)
+		return -EINVAL;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		return sx9324_read_thresh(data, chan, val);
+	case IIO_EV_INFO_PERIOD:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return sx9324_read_far_debounce(data, val);
+		case IIO_EV_DIR_FALLING:
+			return sx9324_read_close_debounce(data, val);
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_INFO_HYSTERESIS:
+		return sx9324_read_hysteresis(data, chan, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int sx9324_write_thresh(struct sx_common_data *data,
+			       const struct iio_chan_spec *chan, int val)
+{
+	unsigned int reg;
+	int ret;
+
+	reg = SX9324_REG_PROX_CTRL6 + chan->channel / 2;
+
+	if (val >= 1)
+		val = int_sqrt(2 * val);
+
+	if (val > 0xff)
+		return -EINVAL;
+
+	mutex_lock(&data->mutex);
+	ret = regmap_write(data->regmap, reg, val);
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static int sx9324_write_hysteresis(struct sx_common_data *data,
+				   const struct iio_chan_spec *chan, int _val)
+{
+	unsigned int hyst, val = _val;
+	int ret, pthresh;
+
+	ret = sx9324_read_thresh(data, chan, &pthresh);
+	if (ret < 0)
+		return ret;
+
+	if (val == 0)
+		hyst = 0;
+	else if (val >= pthresh >> 2)
+		hyst = 3;
+	else if (val >= pthresh >> 3)
+		hyst = 2;
+	else if (val >= pthresh >> 4)
+		hyst = 1;
+	else
+		return -EINVAL;
+
+	hyst = FIELD_PREP(SX9324_REG_PROX_CTRL5_HYST_MASK, hyst);
+	mutex_lock(&data->mutex);
+	ret = regmap_update_bits(data->regmap, SX9324_REG_PROX_CTRL5,
+				 SX9324_REG_PROX_CTRL5_HYST_MASK, hyst);
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static int sx9324_write_far_debounce(struct sx_common_data *data, int val)
+{
+	int ret;
+	unsigned int regval;
+
+	if (val > 0)
+		val = ilog2(val);
+	if (!FIELD_FIT(SX9324_REG_PROX_CTRL5_FAR_DEBOUNCE_MASK, val))
+		return -EINVAL;
+
+	regval = FIELD_PREP(SX9324_REG_PROX_CTRL5_FAR_DEBOUNCE_MASK, val);
+
+	mutex_lock(&data->mutex);
+	ret = regmap_update_bits(data->regmap, SX9324_REG_PROX_CTRL5,
+				 SX9324_REG_PROX_CTRL5_FAR_DEBOUNCE_MASK,
+				 regval);
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static int sx9324_write_close_debounce(struct sx_common_data *data, int val)
+{
+	int ret;
+	unsigned int regval;
+
+	if (val > 0)
+		val = ilog2(val);
+	if (!FIELD_FIT(SX9324_REG_PROX_CTRL5_CLOSE_DEBOUNCE_MASK, val))
+		return -EINVAL;
+
+	regval = FIELD_PREP(SX9324_REG_PROX_CTRL5_CLOSE_DEBOUNCE_MASK, val);
+
+	mutex_lock(&data->mutex);
+	ret = regmap_update_bits(data->regmap, SX9324_REG_PROX_CTRL5,
+				 SX9324_REG_PROX_CTRL5_CLOSE_DEBOUNCE_MASK,
+				 regval);
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static int sx9324_write_event_val(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan,
+				  enum iio_event_type type,
+				  enum iio_event_direction dir,
+				  enum iio_event_info info, int val, int val2)
+{
+	struct sx_common_data *data = iio_priv(indio_dev);
+
+	if (chan->type != IIO_PROXIMITY)
+		return -EINVAL;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		return sx9324_write_thresh(data, chan, val);
+	case IIO_EV_INFO_PERIOD:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return sx9324_write_far_debounce(data, val);
+		case IIO_EV_DIR_FALLING:
+			return sx9324_write_close_debounce(data, val);
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_INFO_HYSTERESIS:
+		return sx9324_write_hysteresis(data, chan, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int sx9324_write_gain(struct sx_common_data *data,
+			     const struct iio_chan_spec *chan, int val)
+{
+	unsigned int gain, reg;
+	int ret;
+
+	gain = ilog2(val);
+	reg = SX9324_REG_PROX_CTRL0 + chan->channel / 2;
+	gain = FIELD_PREP(SX9324_REG_PROX_CTRL0_GAIN_MASK, gain);
+
+	mutex_lock(&data->mutex);
+	ret = regmap_update_bits(data->regmap, reg,
+				 SX9324_REG_PROX_CTRL0_GAIN_MASK,
+				 gain);
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static int sx9324_write_raw(struct iio_dev *indio_dev,
+			    const struct iio_chan_spec *chan, int val, int val2,
+			    long mask)
+{
+	struct sx_common_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return sx9324_set_samp_freq(data, val, val2);
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		return sx9324_write_gain(data, chan, val);
+	}
+
+	return -EINVAL;
+}
+
+static struct attribute *sx9324_attributes[] = {
+	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_dev_attr_in_proximity_configuration0.dev_attr.attr,
+	&iio_dev_attr_in_proximity_configuration1.dev_attr.attr,
+	&iio_dev_attr_in_proximity_configuration2.dev_attr.attr,
+	&iio_dev_attr_in_proximity_configuration3.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group sx9324_attribute_group = {
+	.attrs = sx9324_attributes,
+};
+
+static const struct iio_info sx9324_info = {
+	.attrs = &sx9324_attribute_group,
+	.read_raw = sx9324_read_raw,
+	.read_avail = sx_common_read_avail,
+	.read_event_value = sx9324_read_event_val,
+	.write_raw = sx9324_write_raw,
+	.write_event_value = sx9324_write_event_val,
+	.read_event_config = sx_common_read_event_config,
+	.write_event_config = sx_common_write_event_config,
+};
+
+/* Activate all channels and perform an initial compensation. */
+static int sx9324_init_compensation(struct iio_dev *indio_dev)
+{
+	struct sx_common_data *data = iio_priv(indio_dev);
+	unsigned int val;
+	int ret;
+
+	/* run the compensation phase on all channels */
+	ret = regmap_update_bits(data->regmap, SX9324_REG_STAT2,
+				 SX9324_REG_STAT2_COMPSTAT_MASK,
+				 SX9324_REG_STAT2_COMPSTAT_MASK);
+	if (ret)
+		return ret;
+
+	ret = regmap_read_poll_timeout(data->regmap, SX9324_REG_STAT2, val,
+				       !(val & SX9324_REG_STAT2_COMPSTAT_MASK),
+				       20000, 2000000);
+	if (ret == -ETIMEDOUT)
+		dev_err(&data->client->dev,
+			"initial compensation timed out: 0x%02x\n",
+			val);
+	return ret;
+}
+
+static int sx9324_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct iio_dev *indio_dev;
+	struct sx_common_data *data;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->reg_stat = SX9324_REG_STAT0;
+	data->reg_irq_msk = SX9324_REG_IRQ_MSK;
+	data->reg_enable_chan = SX9324_REG_GNRL_CTRL1;
+	data->reg_reset = SX9324_REG_RESET;
+
+	data->mask_enable_chan = SX9324_REG_GNRL_CTRL1_PHEN_MASK;
+	data->irq_msk_offset = 3;
+	data->num_channels = SX9324_NUM_CHANNELS;
+
+	ret = sx_common_probe_setup(indio_dev, client, &sx9324_regmap_config);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap, SX9324_REG_WHOAMI, &data->whoami);
+	if (ret) {
+		dev_err(dev, "error in reading WHOAMI register: %d", ret);
+		return ret;
+	}
+
+	/* Low level entry points */
+	data->read_prox_data = sx9324_read_prox_data;
+	data->init_compensation = sx9324_init_compensation;
+	data->wait_for_sample = sx9324_wait_for_sample;
+
+	indio_dev->channels = sx9324_channels;
+	indio_dev->num_channels = ARRAY_SIZE(sx9324_channels);
+	indio_dev->info = &sx9324_info;
+
+	return sx_common_probe_register(indio_dev);
+}
+
+static int __maybe_unused sx9324_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct sx_common_data *data = iio_priv(indio_dev);
+	unsigned int regval;
+	int ret;
+
+	mutex_lock(&data->mutex);
+	ret = regmap_read(data->regmap, SX9324_REG_GNRL_CTRL1, &regval);
+
+	data->suspend_ctrl =
+		FIELD_GET(SX9324_REG_GNRL_CTRL1_PHEN_MASK, regval);
+
+	if (ret < 0)
+		goto out;
+
+	// disable all phases, send the device to sleep
+	ret = regmap_write(data->regmap, SX9324_REG_GNRL_CTRL1, 0);
+
+out:
+	mutex_unlock(&data->mutex);
+	return ret;
+}
+
+static int __maybe_unused sx9324_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct sx_common_data *data = iio_priv(indio_dev);
+	int ret;
+
+	mutex_lock(&data->mutex);
+	ret = regmap_write(data->regmap, SX9324_REG_GNRL_CTRL1,
+			   data->suspend_ctrl | SX9324_REG_GNRL_CTRL1_PAUSECTRL);
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
+static const struct dev_pm_ops sx9324_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(sx9324_suspend, sx9324_resume)
+};
+
+static const struct acpi_device_id sx9324_acpi_match[] = {
+	{ "STH9324", SX9324_WHOAMI_VALUE},
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, sx9324_acpi_match);
+
+static const struct of_device_id sx9324_of_match[] = {
+	{ .compatible = "semtech,sx9324", (void *)SX9324_WHOAMI_VALUE},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sx9324_of_match);
+
+static const struct i2c_device_id sx9324_id[] = {
+	{"sx9324", SX9324_WHOAMI_VALUE},
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, sx9324_id);
+
+static struct i2c_driver sx9324_driver = {
+	.driver = {
+		.name	= SX9324_DRIVER_NAME,
+		.acpi_match_table = ACPI_PTR(sx9324_acpi_match),
+		.of_match_table = of_match_ptr(sx9324_of_match),
+		.pm = &sx9324_pm_ops,
+
+		/*
+		 * Lots of i2c transfers in probe + over 200 ms waiting in
+		 * sx9324_init_compensation() mean a slow probe; prefer async
+		 * so we don't delay boot if we're builtin to the kernel.
+		 */
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.probe_new	= sx9324_probe,
+	.id_table	= sx9324_id,
+};
+module_i2c_driver(sx9324_driver);
+
+MODULE_AUTHOR("Gwendal Grignou <gwendal@chromium.org>");
+MODULE_DESCRIPTION("Driver for Semtech SX9324 proximity sensor");
+MODULE_LICENSE("GPL v2");
-- 
2.33.1.1089.g2158813163f-goog

