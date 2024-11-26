Return-Path: <linux-iio+bounces-12713-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B698A9D9F06
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 22:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BB03B2311C
	for <lists+linux-iio@lfdr.de>; Tue, 26 Nov 2024 21:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481EE1DFD8E;
	Tue, 26 Nov 2024 21:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKi86Msc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198DE1DFE08;
	Tue, 26 Nov 2024 21:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732657939; cv=none; b=t6foYT/Uafj1mSiILv/o7vS5aCa8quqsm5xUKQFfJ0mJT22balpmGOehVbe6vk+EmVxYzntQeRV8y5FgjX1kdaTogNA4gafxS5me7kelaTXm455F8alnBogiveEk/HAa1cYGk+9DnTyHVi72iDJebXpUcCdtbBS740kV7qRs9c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732657939; c=relaxed/simple;
	bh=rqwphtLoOPoHsG6FYXfAZ5N7hDP9zA8sci9sn02VjRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RL+XfOUwUxUIFHqlk1MMvk4Kwii/q94y6Y6ZAVFJX+pk0KEn6Z6Wh1qbxGnIgVxLeAqxGeB2k+mboCe+WW2XNd+bAmjN+qEkSRstUQ7FgFv3kjgZ0RUYwpTLZNDjgXDesWBAlPah3HbsqxWRPqWAz3L/aSt+p6onkF9abCJ1dNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKi86Msc; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-382610c7116so3330834f8f.0;
        Tue, 26 Nov 2024 13:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732657934; x=1733262734; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSf+8hdcvpNSvX1RrYpskPfbAYrflzCIixA/sVkPtms=;
        b=cKi86Mscxunwo8AWQcrh/W45d99XmRLnojmMelLUbxp7eDcLKz9/pSOGfdfdPikGe8
         1u9dmtulNzUXwouFClabXUG1h30MOT0XkqR7DvWhfHUt0Yqzs7Tn4WcZ0jqkdbTFx3Lv
         al87G6B53vPflw9oPjNomuwJ0kjcZmO7gNdI2+3rKyQrvc78NwURgsAIXJlKmeElVKAh
         OI/xNTUCLVcE0Leh0FzWkZSiuuRy9u+pZmJcjbXya1XBDiDtlH9vdY2NZfP2k4yjQcDL
         RXyfemOgFMZoutKUcyDsWhrXyOYEQkAizWXZfYIdBWXUJl4VA9l4fpZVD+WuBct4K74c
         vMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732657934; x=1733262734;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WSf+8hdcvpNSvX1RrYpskPfbAYrflzCIixA/sVkPtms=;
        b=vw0WhBlbrbr58VB1KF5UtNj3qQGkxOxeUJNXJSecO7HZ4Kj1t0n0J0A+YMeP58MMsX
         yhTLqaktUKV62jLoCDjBUc/RBjlP7WVvR3IDoTeSezCBkWZfLL1ZawRM2yUxbltTybLK
         8ExZaPCHxuayfEAz6HqaxF8CB0sElZNf2dCQK/JbzdfQVEvxcIl0wcZub26IktKUvo7f
         9jIEs43oHls1euW62H1UMjTEByrcoPQhWqSCQ+54RLJoc7y7Rq/GA9EbJMGniBRrHxME
         qfZQDk/RxExFS+y5FnGAsJLr0kmtFWETDAoLABbvHPEOIhWDQZ51DduDJ8+LGBB6WHey
         spwA==
X-Forwarded-Encrypted: i=1; AJvYcCVYJVvYi7BevqvRm5S+FXcz1lJ5biL7KE9F/aujWNhOjXkoKqIVlCp+TkydcA+2EhDZ/dsEKffl/DKJ6mMu@vger.kernel.org, AJvYcCXfcb2R9huCi713FpaRTllWLNyPyAiVN2/cuFv3QxMWcS03iXxmEePRzN4eDeHt1vLWd601IMT/ZC6P@vger.kernel.org
X-Gm-Message-State: AOJu0YxyQkWUIe97mPmOz0H6kOCvOKgrLJAIk5NlWRPJPMTqpCmQ98T+
	auKPPDDekcl2PhyYfl5wFCBjpJN4eerQ39vUPfHZtNvCDWCeivD2JaEQMw==
X-Gm-Gg: ASbGncuXDU5nKOOJRy5PHQgsx1UKMtjoLryjqYmag3WcXKq5odUtGRdSurrgqK+btI/
	wWiDWAr2YEh9yfENMzETl20U61dDTA4a1DL0XBu6NxYSKuSEQ+ZUAn5GX/QtE0v4yHLfNj6yFRJ
	ZF/12zt6jG7xYZgR9leeK/8Nvsh7nKAJ3QY2mTC4KpEmuldJswpDQslwckHL7+hDmXhUJrLw0wj
	/+vqWjK245v9M0PqdwADBxPISd17OMR8FsR4+zGQQezW3DhLZV1FdS2u7YI1MMTdAoq6Q9Cm/63
	0FRxSwSK/JBVuSFYWDhVpelFlHY20QVxzPX+3aYkxFDIuDBSAOIntEfOrdk5ILgd1Kx0e0I=
X-Google-Smtp-Source: AGHT+IGmvNW10QZ+6tWbruOpUAXbDXE4AZWmoL1/gL1xsTzG665xkgwrRq37XjzgsPc9O2apIYKRuA==
X-Received: by 2002:a05:6000:18ab:b0:382:4978:2ab9 with SMTP id ffacd0b85a97d-385c6cca356mr391031f8f.5.1732657934151;
        Tue, 26 Nov 2024 13:52:14 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-d42c-04c9-936b-d14b.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d42c:4c9:936b:d14b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fafedbcsm14570297f8f.41.2024.11.26.13.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 13:52:13 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 26 Nov 2024 22:51:55 +0100
Subject: [PATCH 2/2] iio: light: add support for veml6031x00 ALS series
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-veml6031x00-v1-2-4affa62bfefd@gmail.com>
References: <20241126-veml6031x00-v1-0-4affa62bfefd@gmail.com>
In-Reply-To: <20241126-veml6031x00-v1-0-4affa62bfefd@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732657929; l=31965;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=rqwphtLoOPoHsG6FYXfAZ5N7hDP9zA8sci9sn02VjRg=;
 b=D7lF0CunxZR4R1Rr6dBJk022sJHWZCSXKUKYpfHFOTsjbG8vsf6Ij8jK4Yt5F4GwkD39TgBFo
 /umMk08pJWXDNz+3EI5TgxP9y/buE83Nz/rA4TzIMaacOSYx73u7dg2
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

These sensors provide two light channels (ALS and IR), I2C communication
and a multiplexed interrupt line to signal data ready and configurable
threshold alarms.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 MAINTAINERS                     |    6 +
 drivers/iio/light/Kconfig       |   13 +
 drivers/iio/light/Makefile      |    1 +
 drivers/iio/light/veml6031x00.c | 1129 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 1149 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3fd398d6e64f..b14aaa21d44b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24664,6 +24664,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
 F:	drivers/iio/light/veml6030.c
 
+VISHAY VEML6031X00 AMBIENT LIGHT SENSOR DRIVER
+M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
+F:	drivers/iio/light/veml6031x00.c
+
 VISHAY VEML6075 UVA AND UVB LIGHT SENSOR DRIVER
 M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
 S:	Maintained
diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 29ffa8491927..d75263ab637e 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -691,6 +691,19 @@ config VEML6030
 	  To compile this driver as a module, choose M here: the
 	  module will be called veml6030.
 
+config VEML6031X00
+	tristate "VEML6031X00 ambient light sensor series"
+	select REGMAP_I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	depends on I2C
+	help
+	  Say Y here if you want to build a driver for the Vishay VEML6031X00
+	  ambient light sensor series.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called veml6031x00.
+
 config VEML6040
 	tristate "VEML6040 RGBW light sensor"
 	select REGMAP_I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index f14a37442712..eca7a310bd54 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -64,6 +64,7 @@ obj-$(CONFIG_VCNL4000)		+= vcnl4000.o
 obj-$(CONFIG_VCNL4035)		+= vcnl4035.o
 obj-$(CONFIG_VEML3235)		+= veml3235.o
 obj-$(CONFIG_VEML6030)		+= veml6030.o
+obj-$(CONFIG_VEML6031X00)	+= veml6031x00.o
 obj-$(CONFIG_VEML6040)		+= veml6040.o
 obj-$(CONFIG_VEML6070)		+= veml6070.o
 obj-$(CONFIG_VEML6075)		+= veml6075.o
diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/veml6031x00.c
new file mode 100644
index 000000000000..fd4c111db13f
--- /dev/null
+++ b/drivers/iio/light/veml6031x00.c
@@ -0,0 +1,1129 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * VEML6031X00 Ambient Light Sensor
+ *
+ * Copyright (c) 2024, Javier Carrasco <javier.carrasco.cruz@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/units.h>
+#include <linux/pm_runtime.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/events.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+/* Device registers */
+#define VEML6031X00_REG_CONF0       0x00
+#define VEML6031X00_REG_CONF1       0x01
+#define VEML6031X00_REG_WH_L        0x04
+#define VEML6031X00_REG_WH_H        0x05
+#define VEML6031X00_REG_WL_L        0x06
+#define VEML6031X00_REG_WL_H        0x07
+#define VEML6031X00_REG_ALS_L       0x10
+#define VEML6031X00_REG_ALS_H       0x11
+#define VEML6031X00_REG_IR_L        0x12
+#define VEML6031X00_REG_IR_H        0x13
+#define VEML6031X00_REG_ID_L        0x14
+#define VEML6031X00_REG_ID_H        0x15
+#define VEML6031X00_REG_INT         0x17
+#define VEML6031X00_REG_DATA(ch)    (VEML6031X00_REG_ALS_L + (ch))
+
+/* Bit masks for specific functionality */
+#define VEML6031X00_ALL_CH_MASK     GENMASK(1, 0)
+#define VEML6031X00_CONF0_SD        BIT(0)
+#define VEML6031X00_CONF0_AF_TRIG   BIT(2)
+#define VEML6031X00_CONF0_AF        BIT(3)
+#define VEML6031X00_CONF1_GAIN      GENMASK(4, 3)
+#define VEML6031X00_CONF1_PD_D4     BIT(6)
+#define VEML6031X00_CONF1_IR_SD     BIT(7)
+#define VEML6031X00_INT_MASK        GENMASK(3, 1)
+#define VEML6031X00_INT_TH_H        BIT(1)
+#define VEML6031X00_INT_TH_L        BIT(2)
+#define VEML6031X00_INT_DRDY        BIT(3)
+
+/* Autosuspend delay */
+#define VEML6031X00_AUTOSUSPEND_MS  2000
+
+enum veml6031x00_scan {
+	VEML6031X00_SCAN_ALS,
+	VEML6031X00_SCAN_IR,
+	VEML6031X00_SCAN_TIMESTAMP,
+};
+
+struct veml6031x00_rf {
+	struct regmap_field *int_en;
+	struct regmap_field *it;
+	struct regmap_field *pers;
+};
+
+struct veml6031x00_chip {
+	const char *name;
+	const int part_id;
+};
+
+struct veml6031x00_data {
+	struct device *dev;
+	struct regmap *regmap;
+	struct iio_trigger *trig;
+	struct veml6031x00_rf rf;
+	const struct veml6031x00_chip *chip;
+	/* serialize access to irq enable/disable by events and trigger */
+	struct mutex lock;
+	atomic_t int_users;
+	bool ev_en;
+	bool trig_en;
+};
+
+static const int veml6031x00_it[][2] = {
+	{0, 3125},
+	{0, 6250},
+	{0, 12500},
+	{0, 25000},
+	{0, 50000},
+	{0, 100000},
+	{0, 200000},
+	{0, 400000},
+};
+
+static const int veml6031x00_gains[][2] = {
+	{0, 125000},
+	{0, 165000},
+	{0, 250000},
+	{0, 500000},
+	{0, 660000},
+	{1, 0},
+	{2, 0},
+};
+
+/*
+ * Persistence = 1/2/4/8 x integration time
+ * Minimum time for which light readings must stay above configured
+ * threshold to assert the interrupt.
+ */
+static const char * const period_values[] = {
+		"0.003125 0.00625 0.0125 0.025",
+		"0.00625 0.0125 0.025 0.05",
+		"0.0125 0.025 0.05 0.1",
+		"0.025 0.050 0.1 0.2",
+		"0.05 0.1 0.2 0.4",
+		"0.1 0.2 0.4 0.8",
+		"0.2 0.4 0.8 1.6",
+		"0.4 0.8 1.6 3.2"
+};
+
+/*
+ * Return list of valid period values in seconds corresponding to
+ * the currently active integration time.
+ */
+static ssize_t in_illuminance_period_available_show(struct device *dev,
+						    struct device_attribute *attr,
+						    char *buf)
+{
+	struct veml6031x00_data *data = iio_priv(dev_to_iio_dev(dev));
+	int ret, reg;
+
+	ret = regmap_field_read(data->rf.it, &reg);
+	if (ret)
+		return ret;
+
+	if (reg < 0 || reg >= ARRAY_SIZE(period_values))
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%s\n", period_values[reg]);
+}
+
+static IIO_DEVICE_ATTR_RO(in_illuminance_period_available, 0);
+
+static struct attribute *veml6031x00_event_attributes[] = {
+	&iio_dev_attr_in_illuminance_period_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group veml6031x00_event_attr_group = {
+	.attrs = veml6031x00_event_attributes,
+};
+
+/*
+ * Two shutdown bits (SD and ALS_IR_SD) must be cleared to power on
+ * the device.
+ */
+static int veml6031x00_als_power_on(struct veml6031x00_data *data)
+{
+	int ret;
+
+	ret =  regmap_clear_bits(data->regmap, VEML6031X00_REG_CONF0,
+				 VEML6031X00_CONF0_SD);
+	if (ret)
+		return ret;
+
+	ret =  regmap_clear_bits(data->regmap, VEML6031X00_REG_CONF1,
+				 VEML6031X00_CONF1_IR_SD);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/*
+ * Two shutdown bits (SD and ALS_IR_SD) must be set to power off
+ * the device.
+ */
+static int veml6031x00_als_sd(struct veml6031x00_data *data)
+{
+	int ret;
+
+	ret = regmap_set_bits(data->regmap, VEML6031X00_REG_CONF0,
+			      VEML6031X00_CONF0_SD);
+	if (ret) {
+		dev_err(data->dev, "Failed to set SD bit %d\n", ret);
+		return ret;
+	}
+
+	return regmap_set_bits(data->regmap, VEML6031X00_REG_CONF1,
+			       VEML6031X00_CONF1_IR_SD);
+}
+
+static void veml6031x00_als_sd_action(void *data)
+{
+	veml6031x00_als_sd(data);
+}
+
+static const struct iio_event_spec veml6031x00_event_spec[] = {
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
+		.mask_separate = BIT(IIO_EV_INFO_PERIOD) |
+		BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static const struct iio_chan_spec veml6031x00_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.address = VEML6031X00_REG_ALS_L,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
+					   BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+						     BIT(IIO_CHAN_INFO_SCALE),
+		.event_spec = veml6031x00_event_spec,
+		.num_event_specs = ARRAY_SIZE(veml6031x00_event_spec),
+		.scan_index = VEML6031X00_SCAN_ALS,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
+	},
+	{
+		.type = IIO_INTENSITY,
+		.address = VEML6031X00_REG_IR_L,
+		.modified = 1,
+		.channel2 = IIO_MOD_LIGHT_IR,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME) |
+					   BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+						     BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = VEML6031X00_SCAN_IR,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_LE,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(VEML6031X00_SCAN_TIMESTAMP),
+};
+
+static const struct regmap_config veml6031x00_regmap_config = {
+	.name = "veml6031x00_regmap",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = VEML6031X00_REG_INT,
+};
+
+static const struct reg_field veml6031x00_rf_int_en =
+	REG_FIELD(VEML6031X00_REG_CONF0, 1, 1);
+
+static const struct reg_field veml6031x00_rf_it =
+	REG_FIELD(VEML6031X00_REG_CONF0, 4, 6);
+
+static const struct reg_field veml6031x00_rf_pers =
+	REG_FIELD(VEML6031X00_REG_CONF1, 1, 2);
+
+static int veml6031x00_regfield_init(struct veml6031x00_data *data)
+{
+	struct regmap *regmap = data->regmap;
+	struct device *dev = data->dev;
+	struct regmap_field *rm_field;
+	struct veml6031x00_rf *rf = &data->rf;
+
+	rm_field = devm_regmap_field_alloc(dev, regmap, veml6031x00_rf_int_en);
+	if (IS_ERR(rm_field))
+		return PTR_ERR(rm_field);
+	rf->int_en = rm_field;
+
+	rm_field = devm_regmap_field_alloc(dev, regmap, veml6031x00_rf_it);
+	if (IS_ERR(rm_field))
+		return PTR_ERR(rm_field);
+	rf->it = rm_field;
+
+	rm_field = devm_regmap_field_alloc(dev, regmap, veml6031x00_rf_pers);
+	if (IS_ERR(rm_field))
+		return PTR_ERR(rm_field);
+	rf->pers = rm_field;
+
+	return 0;
+}
+
+static int veml6031x00_get_it_usec(struct veml6031x00_data *data, int *it_usec)
+{
+	int ret, reg;
+
+	ret = regmap_field_read(data->rf.it, &reg);
+	if (ret)
+		return ret;
+
+	switch (reg) {
+	case 0:
+		*it_usec = 3125;
+		break;
+	case 1:
+		*it_usec = 6250;
+		break;
+	case 2:
+		*it_usec = 12500;
+		break;
+	case 3:
+		*it_usec = 25000;
+		break;
+	case 4:
+		*it_usec = 50000;
+		break;
+	case 5:
+		*it_usec = 100000;
+		break;
+	case 6:
+		*it_usec = 200000;
+		break;
+	case 7:
+		*it_usec = 400000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int veml6031x00_set_it(struct iio_dev *iio, int val, int val2)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	int ret, new_it;
+
+	if (val)
+		return -EINVAL;
+
+	switch (val2) {
+	case 3125:
+		new_it = 0x00;
+		break;
+	case 6250:
+		new_it = 0x01;
+		break;
+	case 12500:
+		new_it = 0x02;
+		break;
+	case 25000:
+		new_it = 0x03;
+		break;
+	case 50000:
+		new_it = 0x04;
+		break;
+	case 100000:
+		new_it = 0x05;
+		break;
+	case 200000:
+		new_it = 0x06;
+		break;
+	case 400000:
+		new_it = 0x07;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_field_write(data->rf.it, new_it);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int veml6031x00_read_pers(struct iio_dev *iio, int *val, int *val2)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	int ret, reg, period, it_usec;
+
+	ret = veml6031x00_get_it_usec(data, &it_usec);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_field_read(data->rf.pers, &reg);
+	if (ret)
+		return ret;
+
+	/* integration time multiplied by 1/2/4/8 */
+	period = it_usec * (1 << reg);
+
+	*val = period / MICRO;
+	*val2 = period % MICRO;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int veml6031x00_write_pers(struct iio_dev *iio, int val, int val2)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	int ret, period, it_usec;
+
+	ret = veml6031x00_get_it_usec(data, &it_usec);
+	if (ret < 0)
+		return ret;
+
+	period = (val * MICRO + val2) / it_usec;
+
+	if (period > 8 || hweight8(period) != 1)
+		return -EINVAL;
+
+	return regmap_field_write(data->rf.pers, ffs(period) - 1);
+}
+
+static int veml6031x00_set_scale(struct iio_dev *iio, int val, int val2)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	int new_scale, gain_idx;
+
+	if (val == 0 && val2 == 125000) {
+		new_scale = FIELD_PREP(VEML6031X00_CONF1_GAIN, 0x03) |
+			VEML6031X00_CONF1_PD_D4;
+		gain_idx = 0;
+	} else if (val == 0 && val2 == 165000) {
+		new_scale = FIELD_PREP(VEML6031X00_CONF1_GAIN, 0x02) |
+			VEML6031X00_CONF1_PD_D4;
+		gain_idx = 1;
+	} else if (val == 0 && val2 == 250000) {
+		new_scale = FIELD_PREP(VEML6031X00_CONF1_GAIN, 0x00) |
+			VEML6031X00_CONF1_PD_D4;
+		gain_idx = 2;
+	} else if (val == 0 && val2 == 500000) {
+		new_scale = FIELD_PREP(VEML6031X00_CONF1_GAIN, 0x03);
+		gain_idx = 3;
+	} else if (val == 0 && val2 == 660000) {
+		new_scale = FIELD_PREP(VEML6031X00_CONF1_GAIN, 0x02);
+		gain_idx = 4;
+	} else if (val == 1 && val2 == 0) {
+		new_scale = FIELD_PREP(VEML6031X00_CONF1_GAIN, 0x00);
+		gain_idx = 5;
+	} else if (val == 2 && val2 == 0) {
+		new_scale = FIELD_PREP(VEML6031X00_CONF1_GAIN, 0x01);
+		gain_idx = 6;
+	} else {
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(data->regmap, VEML6031X00_REG_CONF1,
+				 VEML6031X00_CONF1_GAIN |
+				 VEML6031X00_CONF1_PD_D4,
+				 new_scale);
+}
+
+static int veml6031x00_get_scale(struct veml6031x00_data *data,
+				 int *val, int *val2)
+{
+	int ret, reg;
+
+	ret = regmap_read(data->regmap, VEML6031X00_REG_CONF1, &reg);
+	if (ret)
+		return ret;
+
+	switch (FIELD_GET(VEML6031X00_CONF1_GAIN, reg)) {
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
+		*val2 = 660000;
+		break;
+	case 3:
+		*val = 0;
+		*val2 = 500000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (reg & VEML6031X00_CONF1_PD_D4)
+		*val2 /= 4;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int veml6031x00_read_th(struct iio_dev *iio, int *val, int *val2, int dir)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	__le16 reg;
+	int ret;
+
+	if (dir == IIO_EV_DIR_RISING)
+		ret = regmap_bulk_read(data->regmap, VEML6031X00_REG_WH_L,
+				       &reg, 2);
+	else
+		ret = regmap_bulk_read(data->regmap, VEML6031X00_REG_WL_L,
+				       &reg, 2);
+	if (ret)
+		return ret;
+
+	*val = le16_to_cpu(reg);
+
+	return IIO_VAL_INT;
+}
+
+static int veml6031x00_write_th(struct iio_dev *iio, int val, int val2, int dir)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	struct device *dev = data->dev;
+	int ret;
+
+	if (val < 0 || val > U16_MAX || val2)
+		return -EINVAL;
+
+	if (dir == IIO_EV_DIR_RISING) {
+		ret = regmap_bulk_write(data->regmap, VEML6031X00_REG_WH_L,
+					&val, 2);
+		if (ret)
+			dev_dbg(dev, "Failed to set high threshold %d\n", ret);
+	} else {
+		ret = regmap_bulk_write(data->regmap, VEML6031X00_REG_WL_L,
+					&val, 2);
+		if (ret)
+			dev_dbg(dev, "Failed to set low threshold %d\n", ret);
+	}
+
+	return ret;
+}
+
+static int veml6031x00_single_read(struct iio_dev *iio, enum iio_chan_type type,
+				   int *val)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	int addr, it_usec, ret;
+	__le16 reg;
+
+	switch (type) {
+	case IIO_LIGHT:
+		addr = VEML6031X00_REG_ALS_L;
+	break;
+	case IIO_INTENSITY:
+		addr = VEML6031X00_REG_IR_L;
+	break;
+	default:
+		return -EINVAL;
+	}
+	ret = pm_runtime_resume_and_get(data->dev);
+	if (ret)
+		return ret;
+
+	ret = veml6031x00_get_it_usec(data, &it_usec);
+	if (ret < 0)
+		return ret;
+
+	/* integration time + 10 % to ensure completion */
+	fsleep(it_usec + (it_usec / 10));
+
+	iio_device_claim_direct_scoped(return -EBUSY, iio) {
+		ret = regmap_bulk_read(data->regmap, addr, &reg, 2);
+		if (ret < 0)
+			return ret;
+	}
+	pm_runtime_mark_last_busy(data->dev);
+	pm_runtime_put_autosuspend(data->dev);
+
+	*val = le16_to_cpu(reg);
+
+	return IIO_VAL_INT;
+}
+
+static int veml6031x00_read_raw(struct iio_dev *iio,
+				struct iio_chan_spec const *chan, int *val,
+				int *val2, long mask)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		return veml6031x00_single_read(iio, chan->type, val);
+	case IIO_CHAN_INFO_INT_TIME:
+		*val = 0;
+		return veml6031x00_get_it_usec(data, val2);
+	case IIO_CHAN_INFO_SCALE:
+		return veml6031x00_get_scale(data, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int veml6031x00_read_avail(struct iio_dev *iio,
+				  struct iio_chan_spec const *chan,
+				  const int **vals, int *type, int *length,
+				  long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		*vals = (int *)&veml6031x00_it;
+		*length = 2 * ARRAY_SIZE(veml6031x00_it);
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (int *)&veml6031x00_gains;
+		*length = 2 * ARRAY_SIZE(veml6031x00_gains);
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int veml6031x00_write_raw(struct iio_dev *iio,
+				 struct iio_chan_spec const *chan,
+				 int val, int val2, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		return veml6031x00_set_it(iio, val, val2);
+	case IIO_CHAN_INFO_SCALE:
+		return veml6031x00_set_scale(iio, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int veml6031x00_set_interrupt(struct veml6031x00_data *data, bool state)
+{
+	if (state) {
+		if (atomic_inc_return(&data->int_users) > 1)
+			return 0;
+	} else {
+		if (atomic_dec_return(&data->int_users) > 0)
+			return 0;
+	}
+
+	return regmap_field_write(data->rf.int_en, state);
+}
+
+static int veml6031x00_read_event_val(struct iio_dev *iio,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir,
+				      enum iio_event_info info,
+				      int *val, int *val2)
+{
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+		case IIO_EV_DIR_FALLING:
+			return veml6031x00_read_th(iio, val, val2, dir);
+		default:
+			return -EINVAL;
+		}
+		break;
+	case IIO_EV_INFO_PERIOD:
+		return veml6031x00_read_pers(iio, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int veml6031x00_write_event_val(struct iio_dev *iio,
+				       const struct iio_chan_spec *chan,
+				       enum iio_event_type type,
+				       enum iio_event_direction dir,
+				       enum iio_event_info info,
+				       int val, int val2)
+{
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		return veml6031x00_write_th(iio, val, val2, dir);
+	case IIO_EV_INFO_PERIOD:
+		return veml6031x00_write_pers(iio, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int veml6031x00_read_event_config(struct iio_dev *iio,
+					 const struct iio_chan_spec *chan,
+					 enum iio_event_type type,
+					 enum iio_event_direction dir)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+
+	guard(mutex)(&data->lock);
+
+	return data->ev_en;
+}
+
+static int veml6031x00_write_event_config(struct iio_dev *iio,
+					  const struct iio_chan_spec *chan,
+					  enum iio_event_type type,
+					  enum iio_event_direction dir,
+					  bool state)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	int ret;
+
+	scoped_guard(mutex, &data->lock) {
+		/* avoid multiple increments/decrements from one source */
+		if (state == data->ev_en)
+			return 0;
+
+		ret = veml6031x00_set_interrupt(data, state);
+		if (ret)
+			return ret;
+
+		data->ev_en = state;
+	}
+
+	if (state)
+		return pm_runtime_resume_and_get(data->dev);
+
+	pm_runtime_mark_last_busy(data->dev);
+	pm_runtime_put_autosuspend(data->dev);
+
+	return 0;
+}
+
+static const struct iio_info veml6031x00_info = {
+	.read_raw  = veml6031x00_read_raw,
+	.read_avail  = veml6031x00_read_avail,
+	.write_raw = veml6031x00_write_raw,
+	.read_event_value = veml6031x00_read_event_val,
+	.write_event_value	= veml6031x00_write_event_val,
+	.read_event_config = veml6031x00_read_event_config,
+	.write_event_config	= veml6031x00_write_event_config,
+	.event_attrs = &veml6031x00_event_attr_group,
+};
+
+static const struct iio_info veml6031x00_info_no_irq = {
+	.read_raw  = veml6031x00_read_raw,
+	.read_avail  = veml6031x00_read_avail,
+	.write_raw = veml6031x00_write_raw,
+};
+
+static irqreturn_t veml6031x00_interrupt(int irq, void *private)
+{
+	struct iio_dev *iio = private;
+	struct veml6031x00_data *data = iio_priv(iio);
+	int ret, reg;
+
+	ret = regmap_read(data->regmap, VEML6031X00_REG_INT, &reg);
+	if (ret) {
+		dev_err(data->dev,
+			"Failed to read interrupt register %d\n", ret);
+		return IRQ_NONE;
+	}
+
+	if (!(reg & VEML6031X00_INT_MASK))
+		return IRQ_NONE;
+
+	guard(mutex)(&data->lock);
+
+	if ((reg & VEML6031X00_INT_TH_H) && data->ev_en) {
+		iio_push_event(iio, IIO_UNMOD_EVENT_CODE(IIO_INTENSITY, 0,
+							 IIO_EV_TYPE_THRESH,
+							 IIO_EV_DIR_RISING),
+			       iio_get_time_ns(iio));
+	}
+
+	if ((reg & VEML6031X00_INT_TH_L) && data->ev_en) {
+		iio_push_event(iio, IIO_UNMOD_EVENT_CODE(IIO_INTENSITY, 0,
+							 IIO_EV_TYPE_THRESH,
+							 IIO_EV_DIR_FALLING),
+			       iio_get_time_ns(iio));
+	}
+
+	if ((reg & VEML6031X00_INT_DRDY) && data->trig_en) {
+		iio_trigger_poll_nested(data->trig);
+		ret = regmap_set_bits(data->regmap, VEML6031X00_REG_CONF0,
+				      VEML6031X00_CONF0_AF_TRIG);
+		if (ret)
+			dev_err(data->dev, "Failed to set trigger %d\n", ret);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int veml6031x00_buffer_preenable(struct iio_dev *iio)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	struct device *dev = data->dev;
+
+	return pm_runtime_resume_and_get(dev);
+}
+
+static int veml6031x00_buffer_postdisable(struct iio_dev *iio)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	struct device *dev = data->dev;
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+}
+
+static int veml6031x00_set_trigger_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *iio = iio_trigger_get_drvdata(trig);
+	struct veml6031x00_data *data = iio_priv(iio);
+	int ret;
+
+	scoped_guard(mutex, &data->lock) {
+		/* avoid multiple increments/decrements from one source */
+		if (state == data->trig_en)
+			return 0;
+
+		ret = veml6031x00_set_interrupt(data, state);
+		if (ret)
+			return ret;
+
+		data->trig_en = state;
+	}
+
+	/* The AF bit must be set before setting AF_TRIG */
+	ret = regmap_update_bits(data->regmap, VEML6031X00_REG_CONF0,
+				 VEML6031X00_CONF0_AF,
+				 FIELD_PREP(VEML6031X00_CONF0_AF, state));
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(data->regmap, VEML6031X00_REG_CONF0,
+				  VEML6031X00_CONF0_AF_TRIG,
+				  FIELD_PREP(VEML6031X00_CONF0_AF_TRIG, state));
+}
+
+static const struct iio_buffer_setup_ops veml6031x00_buffer_setup_ops = {
+	.preenable = veml6031x00_buffer_preenable,
+	.postdisable = veml6031x00_buffer_postdisable,
+};
+
+static const struct iio_trigger_ops veml6031x00_trigger_ops = {
+	.set_trigger_state = veml6031x00_set_trigger_state,
+};
+
+static irqreturn_t veml6031x00_trig_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *iio = pf->indio_dev;
+	struct veml6031x00_data *data = iio_priv(iio);
+	int ch, ret, i = 0;
+	__le16 reg;
+	struct {
+		__le16 chans[2];
+		aligned_s64 timestamp;
+	} scan;
+
+	memset(&scan, 0, sizeof(scan));
+
+	if (*iio->active_scan_mask == VEML6031X00_ALL_CH_MASK) {
+		ret = regmap_bulk_read(data->regmap,
+				       VEML6031X00_REG_ALS_L,
+				       &reg, sizeof(scan.chans));
+		if (ret)
+			goto done;
+	} else {
+		iio_for_each_active_channel(iio, ch) {
+			ret = regmap_bulk_read(data->regmap,
+					       VEML6031X00_REG_DATA(ch),
+					       &scan.chans[i++], 2);
+			if (ret)
+				goto done;
+		}
+	}
+
+	iio_push_to_buffers_with_timestamp(iio, &scan, pf->timestamp);
+
+done:
+	iio_trigger_notify_done(iio->trig);
+
+	return IRQ_HANDLED;
+}
+
+static void veml6031x00_validate_part_id(struct veml6031x00_data *data)
+{
+	int part_id, ret;
+	__le16 reg;
+
+	ret = regmap_bulk_read(data->regmap, VEML6031X00_REG_ID_L, &reg, 2);
+	if (ret) {
+		dev_info(data->dev, "Failed to read ID\n");
+		return;
+	}
+
+	part_id = le16_to_cpu(reg);
+	if (part_id != data->chip->part_id)
+		dev_info(data->dev, "Unknown ID %#02x\n", part_id);
+}
+
+static int veml6031x00_hw_init(struct iio_dev *iio)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	struct device *dev = data->dev;
+	int ret, val;
+	__le16 reg;
+
+	reg = cpu_to_le16(0);
+	ret = regmap_bulk_write(data->regmap, VEML6031X00_REG_WL_L, &reg, 2);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set low threshold\n");
+
+	reg = cpu_to_le16(U16_MAX);
+	ret = regmap_bulk_write(data->regmap, VEML6031X00_REG_WH_L, &reg, 2);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set high threshold\n");
+
+	ret = regmap_field_write(data->rf.int_en, 0);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_read(data->regmap, VEML6031X00_REG_INT, &val);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to clear interrupts\n");
+
+	return 0;
+}
+
+static int veml6031x00_setup_irq(struct i2c_client *i2c, struct iio_dev *iio)
+{
+	struct veml6031x00_data *data = iio_priv(iio);
+	struct device *dev = data->dev;
+	int ret;
+
+	data->trig = devm_iio_trigger_alloc(dev, "%s-drdy%d", iio->name,
+					    iio_device_id(iio));
+	if (!data->trig)
+		return -ENOMEM;
+
+	data->trig->ops = &veml6031x00_trigger_ops;
+	iio_trigger_set_drvdata(data->trig, iio);
+
+	ret = devm_iio_trigger_register(dev, data->trig);
+	if (ret)
+		return ret;
+
+	iio->trig = iio_trigger_get(data->trig);
+	ret = devm_request_threaded_irq(dev, i2c->irq, NULL,
+					veml6031x00_interrupt,
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					iio->name, iio);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to request irq %d\n",
+				     i2c->irq);
+
+	iio->info = &veml6031x00_info;
+
+	return 0;
+}
+
+static int veml6031x00_probe(struct i2c_client *i2c)
+{
+	struct device *dev = &i2c->dev;
+	struct veml6031x00_data *data;
+	struct iio_dev *iio;
+	struct regmap *regmap;
+	int ret;
+
+	regmap = devm_regmap_init_i2c(i2c, &veml6031x00_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "Failed to set regmap\n");
+
+	iio = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!iio)
+		return -ENOMEM;
+
+	data = iio_priv(iio);
+	i2c_set_clientdata(i2c, iio);
+	data->dev = dev;
+	data->regmap = regmap;
+
+	mutex_init(&data->lock);
+
+	ret = veml6031x00_regfield_init(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to init regfield\n");
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable regulator\n");
+
+	data->chip = i2c_get_match_data(i2c);
+	if (!data->chip)
+		return dev_err_probe(dev, -EINVAL, "Failed to get chip data\n");
+
+	ret = devm_add_action_or_reset(dev, veml6031x00_als_sd_action, data);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to add shut down action\n");
+
+	ret = pm_runtime_set_active(dev);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to activate PM runtime\n");
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable PM runtime\n");
+
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_autosuspend_delay(dev, VEML6031X00_AUTOSUSPEND_MS);
+	pm_runtime_use_autosuspend(dev);
+
+	veml6031x00_validate_part_id(data);
+
+	iio->name = data->chip->name;
+	iio->channels = veml6031x00_channels;
+	iio->num_channels = ARRAY_SIZE(veml6031x00_channels);
+	iio->modes = INDIO_DIRECT_MODE;
+
+	if (i2c->irq) {
+		ret = veml6031x00_setup_irq(i2c, iio);
+		if (ret < 0)
+			return ret;
+	} else {
+		iio->info = &veml6031x00_info_no_irq;
+	}
+
+	ret = veml6031x00_hw_init(iio);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_iio_triggered_buffer_setup(dev, iio, NULL,
+					      veml6031x00_trig_handler,
+					      &veml6031x00_buffer_setup_ops);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to register triggered buffer");
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	ret = devm_iio_device_register(dev, iio);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register iio device");
+
+	return 0;
+}
+
+static int veml6031x00_runtime_suspend(struct device *dev)
+{
+	struct veml6031x00_data *data = iio_priv(dev_get_drvdata(dev));
+
+	return veml6031x00_als_sd(data);
+}
+
+static int veml6031x00_runtime_resume(struct device *dev)
+{
+	struct veml6031x00_data *data = iio_priv(dev_get_drvdata(dev));
+
+	return veml6031x00_als_power_on(data);
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(veml6031x00_pm_ops, veml6031x00_runtime_suspend,
+				 veml6031x00_runtime_resume, NULL);
+
+static const struct veml6031x00_chip veml6031x00_chip = {
+	.name = "veml6031x00",
+	.part_id = 0x0001,
+};
+
+static const struct veml6031x00_chip veml6031x01_chip = {
+	.name = "veml6031x01",
+	.part_id = 0x0001,
+};
+
+static const struct veml6031x00_chip veml60311x00_chip = {
+	.name = "veml60311x00",
+	.part_id = 0x1001,
+};
+
+static const struct veml6031x00_chip veml60311x01_chip = {
+	.name = "veml60311x01",
+	.part_id = 0x1001,
+};
+
+static const struct of_device_id veml6031x00_of_match[] = {
+	{
+		.compatible = "vishay,veml6031x00",
+		.data = &veml6031x00_chip,
+	},
+	{
+		.compatible = "vishay,veml6031x01",
+		.data = &veml6031x01_chip,
+	},
+	{
+		.compatible = "vishay,veml60311x00",
+		.data = &veml60311x00_chip,
+	},
+	{
+		.compatible = "vishay,veml60311x01",
+		.data = &veml60311x01_chip,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, veml6031x00_of_match);
+
+static const struct i2c_device_id veml6031x00_id[] = {
+	{ "veml6031x00", (kernel_ulong_t)&veml6031x00_chip },
+	{ "veml6031x01", (kernel_ulong_t)&veml6031x01_chip },
+	{ "veml60311x00", (kernel_ulong_t)&veml60311x00_chip },
+	{ "veml60311x01", (kernel_ulong_t)&veml60311x01_chip },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, veml6031x00_id);
+
+static struct i2c_driver veml6031x00_driver = {
+	.driver = {
+		.name = "veml6031x00",
+		.of_match_table = veml6031x00_of_match,
+		.pm = pm_ptr(&veml6031x00_pm_ops),
+	},
+	.probe = veml6031x00_probe,
+	.id_table = veml6031x00_id,
+};
+module_i2c_driver(veml6031x00_driver);
+
+MODULE_AUTHOR("Javier Carrasco <javier.carrasco.cruz@gmail.com>");
+MODULE_DESCRIPTION("VEML6031X00 Ambient Light Sensor");
+MODULE_LICENSE("GPL");

-- 
2.43.0


