Return-Path: <linux-iio+bounces-5687-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1248D8715
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 18:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6271F2564D
	for <lists+linux-iio@lfdr.de>; Mon,  3 Jun 2024 16:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4582136994;
	Mon,  3 Jun 2024 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UmJZHVcM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25204107A8;
	Mon,  3 Jun 2024 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717431727; cv=none; b=VzpIlGgP5nKuY7+OwcMOFMCam3EXGIdtK9KuuQT4ahtBny7/ky7iwR6B7tBmn6F4wQTv6/LXptG3a2ir+wlZCsKErpxjXzRcPeXSn9CVYqPk+ubq/2h8AgvAEaMjV5Gk7ASjWW19sCjSaDxN+MTC5BxBQVtFVssNad6TxPo/76Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717431727; c=relaxed/simple;
	bh=EgzUJainlt0ENh9EPF37WX+j3+uEqD6QBBZKEYSXilk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcB/ihptKAiusoIC6uzEBF3z4dQHOwcQqqqVTjnfhlDzQVPXVy47jBC5hm0hPLXY8U6nUlr0WxDlCUjh3o4TagRYljS6WX+tZRwHuxWc/YPDB0cFbAk8oY+URgbOownEwkqc2ElzOJY3/xYo3q8+/2enVPbTz37zKqryfljowWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UmJZHVcM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4213b94b7e7so8030345e9.0;
        Mon, 03 Jun 2024 09:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717431723; x=1718036523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTKSSeVOj6yqFCJP7sdQZ8emJ8Ixiim9GC+7gtQ2b3c=;
        b=UmJZHVcMbbYCxXoGprAc2n8ZfvWSVMfBust2imaYEaWPQFt1srRVLd5nXSSLj4zfHz
         pyf64JXzfNHWzTxotfqdpU/FYUohaIuvR2boW/p73AsroF32hT8nSoDTNlXCBc9shlce
         jt8v8bdfEclmC/tjAlGTJkEhBmTz35DD5HEH/UshJwwnVuSvY5urhSlye0LsIZkXQHsg
         HX7qZfimpHlquu+PpZqgrKY8lUFGTMRqnU3NGU1Q6TnxWemnb9/8IHTxKwxqp2Yttuzx
         AYM2Iqse5DSy42OSAnT4kO/WWrRkplWPTHYkClKvGOFkTKO8y5H4jvhFN7atpYxY/0dj
         Bc5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717431723; x=1718036523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTKSSeVOj6yqFCJP7sdQZ8emJ8Ixiim9GC+7gtQ2b3c=;
        b=vGhWtTzJVE9AWpNqMenSdRUJrcW6lL0expv9qOaIATy78fM+mjr6GyhPrcbimAA3Jh
         gw71wFlgyZuLK3gygazJLMXIDmNUzEF/Z6zWAuCliRuWJMJgJaeZFUmCzc44klQKAhi9
         gmmGIGP944Lhl9k3TfaYAn7/Sp/VFXAqLiN/DBg3cTlCYBvNyaSPhZrpzQFE0pJMCm/p
         YAcoO0nBrErZqbw85plSG4Vd18IKEaNlMzgwRDsTJGBSE3RRQ/7r3Mu37Fv691mA15kn
         46E/soR3Cs/f3mQMVIzfCBm5rLMJ5p5GbF+21cKusLX1zNTL64d3W0gc4bhupL3Gi5KD
         Z9tg==
X-Forwarded-Encrypted: i=1; AJvYcCXGD4lYRdFJAEcEo55pNWzFb0oMsqTymrFwvirc3ihCCQyB3kNWd95N9hbnnFbIOAa1IwXCIJTVltcOc8iL9CKcMZdp3EWyXisqWzg9yO/0ravfk1Giv+m+rPK4UgC3D55rh4wtl6JX+X9QYorIgAv7G/SqlRJNNFXhyoc2T236WphO9g==
X-Gm-Message-State: AOJu0YxyX109QxH5eW2IbQ/h/8KtxBA91c6fm3M4o/l4+x/iJgfPW+Lf
	Os86+M6uA4fjO4IBdXoZ/GKN2cUekiGm+H++XjTO1q4hFOsAm3Twt35pOL3wQjw=
X-Google-Smtp-Source: AGHT+IECjZeX7iqGzyBssWgmXArqNDdWSywnK0Z5tR7fwg3dnPwTDC/SQoeF8H6Kn1VXN+PQCMtDEw==
X-Received: by 2002:a05:600c:19c7:b0:421:2ee4:6b94 with SMTP id 5b1f17b1804b1-42145117f43mr1581995e9.5.1717431723000;
        Mon, 03 Jun 2024 09:22:03 -0700 (PDT)
Received: from localhost.localdomain ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4213cd1c075sm43697765e9.0.2024.06.03.09.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 09:22:02 -0700 (PDT)
From: Mudit Sharma <muditsharma.info@gmail.com>
To: ivan.orlov0322@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	robh@kernel.org
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 2/3] iio: light: ROHM BH1745 colour sensor
Date: Mon,  3 Jun 2024 17:21:21 +0100
Message-ID: <20240603162122.165943-2-muditsharma.info@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240603162122.165943-1-muditsharma.info@gmail.com>
References: <20240603162122.165943-1-muditsharma.info@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for BH1745, which is an I2C colour sensor with red, green,
blue and clear channels. It has a programmable active low interrupt pin.
Interrupt occurs when the signal from the selected interrupt source
channel crosses set interrupt threshold high or low level.

This driver includes device attributes to configure the following:
- Interrupt pin latch: The interrupt pin can be configured to
  be latched (until interrupt register (0x60) is read or initialized)
  or update after each measurement.
- Interrupt source: The colour channel that will cause the interrupt
  when channel will cross the set threshold high or low level.

This driver also includes device attributes to present valid
configuration options/values for:
- Integration time
- Interrupt colour source
- Hardware gain

Signed-off-by: Mudit Sharma <muditsharma.info@gmail.com>
---
v1->v2:
- No changes

 drivers/iio/light/Kconfig  |  12 +
 drivers/iio/light/Makefile |   1 +
 drivers/iio/light/bh1745.c | 879 +++++++++++++++++++++++++++++++++++++
 3 files changed, 892 insertions(+)
 create mode 100644 drivers/iio/light/bh1745.c

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 9a587d403118..6e0bd2addf9e 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -114,6 +114,18 @@ config AS73211
 	 This driver can also be built as a module.  If so, the module
 	 will be called as73211.
 
+config BH1745
+	tristate "ROHM BH1745 colour sensor"
+	depends on I2C
+	select REGMAP_I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say Y here to build support for the ROHM bh1745 colour sensor.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called bh1745.
+
 config BH1750
 	tristate "ROHM BH1750 ambient light sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index a30f906e91ba..939a701a06ac 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_APDS9300)		+= apds9300.o
 obj-$(CONFIG_APDS9306)		+= apds9306.o
 obj-$(CONFIG_APDS9960)		+= apds9960.o
 obj-$(CONFIG_AS73211)		+= as73211.o
+obj-$(CONFIG_BH1745)		+= bh1745.o
 obj-$(CONFIG_BH1750)		+= bh1750.o
 obj-$(CONFIG_BH1780)		+= bh1780.o
 obj-$(CONFIG_CM32181)		+= cm32181.o
diff --git a/drivers/iio/light/bh1745.c b/drivers/iio/light/bh1745.c
new file mode 100644
index 000000000000..a7b660a1bdc8
--- /dev/null
+++ b/drivers/iio/light/bh1745.c
@@ -0,0 +1,879 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ROHM BH1745 digital colour sensor driver
+ *
+ * Copyright (C) Mudit Sharma <muditsharma.info@gmail.com>
+ *
+ * 7-bit I2C slave addresses:
+ *  0x38 (ADDR pin low)
+ *  0x39 (ADDR pin high)
+ *
+ */
+
+#include <linux/i2c.h>
+#include <linux/mutex.h>
+#include <linux/util_macros.h>
+#include <linux/iio/events.h>
+#include <linux/regmap.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#define BH1745_MOD_NAME "bh1745"
+
+/* BH1745 config regs */
+#define BH1745_SYS_CTRL 0x40
+
+#define BH1745_MODE_CTRL_1 0x41
+#define BH1745_MODE_CTRL_2 0x42
+#define BH1745_MODE_CTRL_3 0x44
+
+#define BH1745_INTR 0x60
+#define BH1745_INTR_STATUS BIT(7)
+
+#define BH1745_PERSISTENCE 0x61
+
+#define BH1745_TH_LSB 0X62
+#define BH1745_TH_MSB 0X63
+
+#define BH1745_TL_LSB 0X64
+#define BH1745_TL_MSB 0X65
+
+#define BH1745_THRESHOLD_MAX 0xFFFF
+#define BH1745_THRESHOLD_MIN 0x0
+
+#define BH1745_MANU_ID 0X92
+
+/* BH1745 output regs */
+#define BH1745_R_LSB 0x50
+#define BH1745_R_MSB 0x51
+#define BH1745_G_LSB 0x52
+#define BH1745_G_MSB 0x53
+#define BH1745_B_LSB 0x54
+#define BH1745_B_MSB 0x55
+#define BH1745_CLR_LSB 0x56
+#define BH1745_CLR_MSB 0x57
+
+#define BH1745_SW_RESET BIT(7)
+#define BH1745_INT_RESET BIT(6)
+
+#define BH1745_MEASUREMENT_TIME_MASK GENMASK(2, 0)
+
+#define BH1745_RGBC_EN BIT(4)
+
+#define BH1745_ADC_GAIN_MASK GENMASK(1, 0)
+
+#define BH1745_INT_ENABLE BIT(0)
+#define BH1745_INT_SIGNAL_ACTIVE BIT(7)
+
+#define BH1745_INT_SIGNAL_LATCHED BIT(4)
+#define BH1745_INT_SIGNAL_LATCH_OFFSET 4
+
+#define BH1745_INT_SOURCE_MASK GENMASK(3, 2)
+#define BH1745_INT_SOURCE_OFFSET 2
+
+#define BH1745_INT_TIME_AVAILABLE "0.16 0.32 0.64 1.28 2.56 5.12"
+#define BH1745_HARDWAREGAIN_AVAILABLE "1 2 16"
+#define BH1745_INT_COLOUR_CHANNEL_AVAILABLE \
+	"0 (Red Channel) 1 (Green Channel) 2 (Blue channel) 3 (Clear channel)"
+
+static const int bh1745_int_time[][2] = {
+	{ 0, 160000 }, /* 160 ms */
+	{ 0, 320000 }, /* 320 ms */
+	{ 0, 640000 }, /* 640 ms */
+	{ 1, 280000 }, /* 1280 ms */
+	{ 2, 560000 }, /* 2560 ms */
+	{ 5, 120000 }, /* 5120 ms */
+};
+
+static const u8 bh1745_gain_factor[] = { 1, 2, 16 };
+
+enum {
+	BH1745_INT_SOURCE_RED,
+	BH1745_INT_SOURCE_GREEN,
+	BH1745_INT_SOURCE_BLUE,
+	BH1745_INT_SOURCE_CLEAR,
+} bh1745_int_source;
+
+enum {
+	BH1745_ADC_GAIN_1X,
+	BH1745_ADC_GAIN_2X,
+	BH1745_ADC_GAIN_16X,
+} bh1745_gain;
+
+enum {
+	BH1745_MEASUREMENT_TIME_160MS,
+	BH1745_MEASUREMENT_TIME_320MS,
+	BH1745_MEASUREMENT_TIME_640MS,
+	BH1745_MEASUREMENT_TIME_1280MS,
+	BH1745_MEASUREMENT_TIME_2560MS,
+	BH1745_MEASUREMENT_TIME_5120MS,
+} bh1745_measurement_time;
+
+enum {
+	BH1745_PRESISTENCE_UPDATE_TOGGLE,
+	BH1745_PRESISTENCE_UPDATE_EACH_MEASUREMENT,
+	BH1745_PRESISTENCE_UPDATE_FOUR_MEASUREMENT,
+	BH1745_PRESISTENCE_UPDATE_EIGHT_MEASUREMENT,
+} bh1745_presistence_value;
+
+struct bh1745_data {
+	struct mutex lock;
+	struct regmap *regmap;
+	struct i2c_client *client;
+	struct iio_trigger *trig;
+	u8 mode_ctrl1;
+	u8 mode_ctrl2;
+	u8 int_src;
+	u8 int_latch;
+	u8 interrupt;
+};
+
+static const struct regmap_range bh1745_volatile_ranges[] = {
+	regmap_reg_range(BH1745_MODE_CTRL_2, BH1745_MODE_CTRL_2), /* VALID */
+	regmap_reg_range(BH1745_R_LSB, BH1745_CLR_MSB), /* Data */
+	regmap_reg_range(BH1745_INTR, BH1745_INTR), /* Interrupt */
+};
+
+static const struct regmap_access_table bh1745_volatile_regs = {
+	.yes_ranges = bh1745_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(bh1745_volatile_ranges),
+};
+
+static const struct regmap_range bh1745_read_ranges[] = {
+	regmap_reg_range(BH1745_SYS_CTRL, BH1745_MODE_CTRL_2),
+	regmap_reg_range(BH1745_R_LSB, BH1745_CLR_MSB),
+	regmap_reg_range(BH1745_INTR, BH1745_INTR),
+	regmap_reg_range(BH1745_PERSISTENCE, BH1745_TL_MSB),
+	regmap_reg_range(BH1745_MANU_ID, BH1745_MANU_ID),
+};
+
+static const struct regmap_access_table bh1745_ro_regs = {
+	.yes_ranges = bh1745_read_ranges,
+	.n_yes_ranges = ARRAY_SIZE(bh1745_read_ranges),
+};
+
+static const struct regmap_range bh1745_writable_ranges[] = {
+	regmap_reg_range(BH1745_SYS_CTRL, BH1745_MODE_CTRL_2),
+	regmap_reg_range(BH1745_PERSISTENCE, BH1745_TL_MSB),
+};
+
+static const struct regmap_access_table bh1745_wr_regs = {
+	.yes_ranges = bh1745_writable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(bh1745_writable_ranges),
+};
+
+static const struct regmap_config bh1745_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = BH1745_MANU_ID,
+	.cache_type = REGCACHE_RBTREE,
+	.volatile_table = &bh1745_volatile_regs,
+	.wr_table = &bh1745_wr_regs,
+	.rd_table = &bh1745_ro_regs,
+};
+
+static const struct iio_event_spec bh1745_event_spec[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_PERIOD),
+	},
+};
+
+#define BH1745_CHANNEL(_colour, _si, _addr)                                   \
+	{                                                                     \
+		.type = IIO_INTENSITY, .modified = 1,                         \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),                 \
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_HARDWAREGAIN) | \
+					    BIT(IIO_CHAN_INFO_INT_TIME),      \
+		.event_spec = bh1745_event_spec,                              \
+		.num_event_specs = ARRAY_SIZE(bh1745_event_spec),             \
+		.channel2 = IIO_MOD_LIGHT_##_colour, .address = _addr,        \
+		.scan_index = _si,                                            \
+		.scan_type = {                                                \
+			.sign = 'u',                                          \
+			.realbits = 16,                                       \
+			.storagebits = 16,                                    \
+			.endianness = IIO_CPU,                                \
+		},                                                            \
+	}
+
+static const struct iio_chan_spec bh1745_channels[] = {
+	BH1745_CHANNEL(RED, 0, BH1745_R_LSB),
+	BH1745_CHANNEL(GREEN, 1, BH1745_G_LSB),
+	BH1745_CHANNEL(BLUE, 2, BH1745_B_LSB),
+	BH1745_CHANNEL(CLEAR, 3, BH1745_CLR_LSB),
+	IIO_CHAN_SOFT_TIMESTAMP(4),
+};
+
+static int bh1745_write_value(struct bh1745_data *data, u8 reg, void *value,
+			      size_t len)
+{
+	int ret = 0;
+
+	ret = regmap_bulk_write(data->regmap, reg, value, len);
+	if (ret < 0) {
+		dev_err(&data->client->dev,
+			"Failed to write to sensor. Reg: 0x%x\n", reg);
+		return ret;
+	}
+	return ret;
+}
+
+static int bh1745_read_value(struct bh1745_data *data, u8 reg, void *value,
+			     size_t len)
+{
+	int ret = 0;
+
+	ret = regmap_bulk_read(data->regmap, reg, value, len);
+	if (ret < 0) {
+		dev_err(&data->client->dev,
+			"Failed to read from sensor. Reg: 0x%x\n", reg);
+		return ret;
+	}
+	return ret;
+}
+
+static ssize_t in_interrupt_source_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	int ret = 0;
+	int value = 0;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct bh1745_data *data = iio_priv(indio_dev);
+
+	ret = bh1745_read_value(data, BH1745_INTR, &value, 1);
+	if (ret < 0)
+		return ret;
+
+	value &= BH1745_INT_SOURCE_MASK;
+	return sprintf(buf, "%d\n", value >> 2);
+}
+
+static ssize_t in_interrupt_source_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t len)
+{
+	int ret = 0;
+	u16 value = 0;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct bh1745_data *data = iio_priv(indio_dev);
+
+	ret = kstrtou16(buf, 10, &value);
+	if (ret < 0)
+		return ret;
+
+	if (value > BH1745_INT_SOURCE_CLEAR) {
+		dev_err(dev,
+			"Supplied value: '%d' for interrupt source is invalid\n",
+			value);
+		return -EINVAL;
+	}
+	mutex_lock(&data->lock);
+	data->int_src = value;
+	value = value << 2;
+	ret = bh1745_read_value(data, BH1745_INTR, &data->interrupt, 1);
+	if (ret < 0) {
+		mutex_unlock(&data->lock);
+		return ret;
+	}
+	data->interrupt &= ~BH1745_INT_SOURCE_MASK;
+	data->interrupt |= value;
+	ret = bh1745_write_value(data, BH1745_INTR, &data->interrupt, 1);
+	mutex_unlock(&data->lock);
+	if (ret < 0)
+		return ret;
+	return len;
+}
+
+static ssize_t in_interrupt_latch_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	int value = 0;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct bh1745_data *data = iio_priv(indio_dev);
+
+	bh1745_read_value(data, BH1745_INTR, &value, 1);
+
+	value &= BH1745_INT_SIGNAL_LATCHED;
+	if (value)
+		return sprintf(buf, "1\n");
+
+	return sprintf(buf, "0\n");
+}
+
+static ssize_t in_interrupt_latch_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t len)
+{
+	int ret = 0;
+	u16 value = 0;
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct bh1745_data *data = iio_priv(indio_dev);
+
+	ret = kstrtou16(buf, 10, &value);
+	if (ret < 0)
+		return ret;
+
+	if (value == 0) {
+		data->int_latch = value;
+		mutex_lock(&data->lock);
+		ret = bh1745_read_value(data, BH1745_INTR, &data->interrupt, 1);
+		if (ret < 0) {
+			mutex_unlock(&data->lock);
+			return ret;
+		}
+
+		data->interrupt &= ~BH1745_INT_SIGNAL_LATCHED;
+		ret = bh1745_write_value(data, BH1745_INTR, &data->interrupt,
+					 1);
+		mutex_unlock(&data->lock);
+		if (ret < 0)
+			return ret;
+
+	} else if (value == 1) {
+		data->int_latch = value;
+		mutex_lock(&data->lock);
+		ret = bh1745_read_value(data, BH1745_INTR, &data->interrupt, 1);
+		if (ret < 0) {
+			mutex_unlock(&data->lock);
+			return ret;
+		}
+
+		data->interrupt |= BH1745_INT_SIGNAL_LATCHED;
+		ret = bh1745_write_value(data, BH1745_INTR, &data->interrupt,
+					 1);
+		mutex_unlock(&data->lock);
+		if (ret < 0)
+			return ret;
+
+	} else {
+		dev_err(dev,
+			"Value out of range for latch setup. Supported values '0' or '1'\n");
+	}
+	return len;
+}
+
+static ssize_t hardwaregain_available_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	return sprintf(buf, "%s\n", BH1745_HARDWAREGAIN_AVAILABLE);
+}
+
+static ssize_t interrupt_source_available_show(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	return sprintf(buf, "%s\n", BH1745_INT_COLOUR_CHANNEL_AVAILABLE);
+}
+
+static IIO_DEVICE_ATTR_RW(in_interrupt_source, 0);
+static IIO_DEVICE_ATTR_RW(in_interrupt_latch, 0);
+static IIO_DEVICE_ATTR_RO(hardwaregain_available, 0);
+static IIO_DEVICE_ATTR_RO(interrupt_source_available, 0);
+static IIO_CONST_ATTR_INT_TIME_AVAIL(BH1745_INT_TIME_AVAILABLE);
+
+static struct attribute *bh1745_attrs[] = {
+	&iio_dev_attr_in_interrupt_source.dev_attr.attr,
+	&iio_dev_attr_in_interrupt_latch.dev_attr.attr,
+	&iio_dev_attr_hardwaregain_available.dev_attr.attr,
+	&iio_dev_attr_interrupt_source_available.dev_attr.attr,
+	&iio_const_attr_integration_time_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group bh1745_attr_group = {
+	.attrs = bh1745_attrs,
+};
+
+static int bh1745_reset(struct bh1745_data *data)
+{
+	int ret = 0;
+	u8 value = 0;
+
+	ret = bh1745_read_value(data, BH1745_SYS_CTRL, &value, 1);
+	if (ret < 0)
+		return ret;
+
+	value |= (BH1745_SW_RESET | BH1745_INT_RESET);
+	return bh1745_write_value(data, BH1745_SYS_CTRL, &value, 1);
+}
+
+static int bh1745_power_on(struct bh1745_data *data)
+{
+	int ret = 0;
+	u8 value = 0;
+
+	ret = bh1745_read_value(data, BH1745_MODE_CTRL_2, &value, 1);
+	if (ret < 0)
+		return ret;
+
+	value |= BH1745_RGBC_EN;
+	mutex_lock(&data->lock);
+	data->mode_ctrl2 = value;
+	ret = bh1745_write_value(data, BH1745_MODE_CTRL_2, &data->mode_ctrl2,
+				 1);
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
+static int bh1745_power_off(struct bh1745_data *data)
+{
+	int ret = 0;
+	int value = 0;
+
+	ret = bh1745_read_value(data, BH1745_MODE_CTRL_2, &value, 1);
+	if (ret < 0)
+		return ret;
+
+	value &= ~BH1745_RGBC_EN;
+	mutex_lock(&data->lock);
+	data->mode_ctrl2 = value;
+	ret = bh1745_write_value(data, BH1745_MODE_CTRL_2, &data->mode_ctrl2,
+				 1);
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
+static int bh1745_set_int_time(struct bh1745_data *data, int val, int val2)
+{
+	int ret = 0;
+
+	for (u8 i = 0; i < ARRAY_SIZE(bh1745_int_time); i++) {
+		if (val == bh1745_int_time[i][0] &&
+		    val2 == bh1745_int_time[i][1]) {
+			mutex_lock(&data->lock);
+			data->mode_ctrl1 &= ~BH1745_MEASUREMENT_TIME_MASK;
+			data->mode_ctrl1 |= i;
+			ret = bh1745_write_value(data, BH1745_MODE_CTRL_1,
+						 &data->mode_ctrl1, 1);
+			mutex_unlock(&data->lock);
+			return ret;
+		}
+	}
+	return -EINVAL;
+}
+
+static int bh1745_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan, int *val,
+			   int *val2, long mask)
+{
+	struct bh1745_data *data = iio_priv(indio_dev);
+	int ret = 0;
+	u16 value = 0;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW: {
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+		ret = bh1745_read_value(data, chan->address, &value, 2);
+		if (ret < 0)
+			return ret;
+		iio_device_release_direct_mode(indio_dev);
+		*val = value;
+		return IIO_VAL_INT;
+	}
+
+	case IIO_CHAN_INFO_HARDWAREGAIN: {
+		mutex_lock(&data->lock);
+		ret = bh1745_read_value(data, BH1745_MODE_CTRL_2,
+					&data->mode_ctrl2, 1);
+		if (ret < 0) {
+			mutex_unlock(&data->lock);
+			return ret;
+		}
+
+		value = data->mode_ctrl2 & BH1745_ADC_GAIN_MASK;
+		mutex_unlock(&data->lock);
+
+		*val = bh1745_gain_factor[value];
+		return IIO_VAL_INT;
+	}
+
+	case IIO_CHAN_INFO_INT_TIME: {
+		mutex_lock(&data->lock);
+		ret = bh1745_read_value(data, BH1745_MODE_CTRL_1,
+					&data->mode_ctrl1, 1);
+		if (ret < 0) {
+			mutex_unlock(&data->lock);
+			return ret;
+		}
+		value = data->mode_ctrl1 & BH1745_MEASUREMENT_TIME_MASK;
+		mutex_unlock(&data->lock);
+
+		*val = bh1745_int_time[value][0];
+		*val2 = bh1745_int_time[value][1];
+		return IIO_VAL_INT_PLUS_MICRO;
+	}
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bh1745_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int val, int val2,
+			    long mask)
+{
+	struct bh1745_data *data = iio_priv(indio_dev);
+	int ret = 0;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_HARDWAREGAIN: {
+		for (u8 i = 0; i < ARRAY_SIZE(bh1745_gain_factor); i++) {
+			if (bh1745_gain_factor[i] == val) {
+				mutex_lock(&data->lock);
+				data->mode_ctrl2 &= ~BH1745_ADC_GAIN_MASK;
+				data->mode_ctrl2 |= i;
+				ret = bh1745_write_value(data,
+							 BH1745_MODE_CTRL_2,
+							 &data->mode_ctrl2, 1);
+				mutex_unlock(&data->lock);
+				return ret;
+			}
+		}
+		return -EINVAL;
+	}
+
+	case IIO_CHAN_INFO_INT_TIME: {
+		return bh1745_set_int_time(data, val, val2);
+	}
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bh1745_read_thresh(struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan,
+			      enum iio_event_type type,
+			      enum iio_event_direction dir,
+			      enum iio_event_info info, int *val, int *val2)
+{
+	struct bh1745_data *data = iio_priv(indio_dev);
+	int ret = 0;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			ret = bh1745_read_value(data, BH1745_TH_LSB, val, 2);
+			if (ret < 0)
+				return ret;
+			return IIO_VAL_INT;
+		case IIO_EV_DIR_FALLING:
+			ret = bh1745_read_value(data, BH1745_TL_LSB, val, 2);
+			if (ret < 0)
+				return ret;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case IIO_EV_INFO_PERIOD:
+		ret = bh1745_read_value(data, BH1745_PERSISTENCE, val, 1);
+		if (ret < 0)
+			return ret;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int bh1745_write_thresh(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan,
+			       enum iio_event_type type,
+			       enum iio_event_direction dir,
+			       enum iio_event_info info, int val, int val2)
+{
+	struct bh1745_data *data = iio_priv(indio_dev);
+	int ret = 0;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		if (val < BH1745_THRESHOLD_MIN || val > BH1745_THRESHOLD_MAX)
+			return -EINVAL;
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			ret = bh1745_write_value(data, BH1745_TH_LSB, &val, 2);
+			if (ret < 0)
+				return ret;
+			return IIO_VAL_INT;
+		case IIO_EV_DIR_FALLING:
+			ret = bh1745_write_value(data, BH1745_TL_LSB, &val, 2);
+			if (ret < 0)
+				return ret;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case IIO_EV_INFO_PERIOD:
+		if (val < BH1745_PRESISTENCE_UPDATE_TOGGLE ||
+		    val > BH1745_PRESISTENCE_UPDATE_EIGHT_MEASUREMENT)
+			return -EINVAL;
+		ret = bh1745_write_value(data, BH1745_PERSISTENCE, &val, 1);
+		if (ret < 0)
+			return ret;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info bh1745_info = {
+	.attrs = &bh1745_attr_group,
+	.read_raw = bh1745_read_raw,
+	.write_raw = bh1745_write_raw,
+	.read_event_value = bh1745_read_thresh,
+	.write_event_value = bh1745_write_thresh,
+
+};
+
+static void bh1745_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct bh1745_data *data = iio_priv(indio_dev);
+
+	if (bh1745_power_off(data) < 0)
+		dev_err(&data->client->dev, "Failed to turn off device");
+
+	dev_info(&data->client->dev, "BH1745 driver removed\n");
+}
+
+static int bh1745_set_trigger_state(struct iio_trigger *trig, bool state)
+{
+	int ret = 0;
+	u8 val = 0;
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct bh1745_data *data = iio_priv(indio_dev);
+
+	if (state) {
+		mutex_lock(&data->lock);
+		ret = bh1745_read_value(data, BH1745_INTR, &val, 1);
+		val |= (BH1745_INT_ENABLE |
+			(data->int_latch << BH1745_INT_SIGNAL_LATCH_OFFSET) |
+			(data->int_src << BH1745_INT_SOURCE_OFFSET));
+		data->interrupt = val;
+		ret = bh1745_write_value(data, BH1745_INTR, &data->interrupt,
+					 1);
+		mutex_unlock(&data->lock);
+	} else {
+		mutex_lock(&data->lock);
+		data->interrupt = val;
+		ret = bh1745_write_value(data, BH1745_INTR, &data->interrupt,
+					 1);
+		mutex_unlock(&data->lock);
+	}
+	return ret;
+}
+
+static const struct iio_trigger_ops bh1745_trigger_ops = {
+	.set_trigger_state = bh1745_set_trigger_state,
+};
+
+static irqreturn_t bh1745_interrupt_handler(int interrupt, void *p)
+{
+	struct iio_dev *indio_dev = p;
+	struct bh1745_data *data = iio_priv(indio_dev);
+	int ret = 0;
+	int value = 0;
+
+	ret = bh1745_read_value(data, BH1745_INTR, &value, 1);
+	if (ret < 0)
+		return ret;
+
+	if (value & BH1745_INTR_STATUS) {
+		mutex_lock(&data->lock);
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(
+				       IIO_INTENSITY, data->int_src,
+				       IIO_EV_TYPE_THRESH, IIO_EV_DIR_EITHER),
+			       iio_get_time_ns(indio_dev));
+
+		mutex_unlock(&data->lock);
+		iio_trigger_poll_nested(data->trig);
+		return IRQ_HANDLED;
+	}
+	return IRQ_NONE;
+}
+
+static irqreturn_t bh1745_trigger_handler(int interrupt, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct bh1745_data *data = iio_priv(indio_dev);
+	u16 value = 0;
+	struct {
+		u16 chans[4];
+
+		s64 timestamp __aligned(8);
+	} scan;
+
+	int i, j = 0;
+
+	for_each_set_bit(i, indio_dev->active_scan_mask,
+			 indio_dev->masklength) {
+		bh1745_read_value(data, BH1745_R_LSB + 2 * i, &value, 2);
+		scan.chans[j++] = value;
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
+					   iio_get_time_ns(indio_dev));
+
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
+static int bh1745_setup_trigger(struct iio_dev *indio_dev)
+{
+	struct bh1745_data *data = iio_priv(indio_dev);
+	int ret;
+
+	data->trig = devm_iio_trigger_alloc(indio_dev->dev.parent,
+					    "%sdata-rdy-dev%d", indio_dev->name,
+					    iio_device_id(indio_dev));
+	if (!data->trig)
+		return -ENOMEM;
+
+	data->trig->ops = &bh1745_trigger_ops;
+	iio_trigger_set_drvdata(data->trig, indio_dev);
+
+	ret = devm_iio_trigger_register(&data->client->dev, data->trig);
+	if (ret)
+		return dev_err_probe(&data->client->dev, ret,
+				     "Trigger registration failed\n");
+
+	ret = devm_iio_triggered_buffer_setup(indio_dev->dev.parent, indio_dev,
+					      NULL, bh1745_trigger_handler,
+					      NULL);
+	if (ret)
+		return dev_err_probe(&data->client->dev, ret,
+				     "Triggered buffer setup failed\n");
+
+	ret = devm_request_threaded_irq(&data->client->dev, data->client->irq,
+					NULL, bh1745_interrupt_handler,
+					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+					"bh1745_interrupt", indio_dev);
+	if (ret) {
+		return dev_err_probe(&data->client->dev, ret,
+				     "Request for IRQ failed\n");
+	}
+
+	dev_info(&data->client->dev,
+		 "Triggered buffer and IRQ setup successfully");
+	return ret;
+}
+
+static int bh1745_init(struct bh1745_data *data)
+{
+	int ret = 0;
+
+	mutex_init(&data->lock);
+	data->mode_ctrl1 = 0;
+	data->mode_ctrl2 = 0;
+	data->interrupt = 0;
+	data->int_src = BH1745_INT_SOURCE_RED;
+
+	ret = bh1745_reset(data);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Failed to reset sensor\n");
+		return ret;
+	}
+
+	ret = bh1745_power_on(data);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Failed to turn on sensor\n");
+		return ret;
+	}
+	return ret;
+}
+
+static int bh1745_probe(struct i2c_client *client)
+{
+	int ret = 0;
+	struct bh1745_data *data;
+	struct iio_dev *indio_dev;
+
+	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+	indio_dev->info = &bh1745_info;
+	indio_dev->name = BH1745_MOD_NAME;
+	indio_dev->channels = bh1745_channels;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->num_channels = ARRAY_SIZE(bh1745_channels);
+
+	data->regmap = devm_regmap_init_i2c(client, &bh1745_regmap);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(&client->dev, PTR_ERR(data->regmap),
+				     "Failed to initialize Regmap\n");
+
+	ret = bh1745_init(data);
+	if (ret < 0)
+		return ret;
+
+	if (client->irq) {
+		ret = bh1745_setup_trigger(indio_dev);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = devm_iio_device_register(&client->dev, indio_dev);
+	if (ret < 0)
+		dev_err(&data->client->dev, "Failed to register device\n");
+
+	dev_info(&data->client->dev, "BH1745 driver loaded\n");
+	return ret;
+}
+
+static const struct i2c_device_id bh1745_idtable[] = {
+	{ "bh1745" },
+	{},
+};
+
+static const struct of_device_id bh1745_of_match[] = {
+	{
+		.compatible = "rohm,bh1745",
+	},
+	{},
+};
+
+MODULE_DEVICE_TABLE(i2c, bh1745_idtable);
+
+static struct i2c_driver bh1745_driver = {
+	.driver = {
+		.name = "bh1745",
+		.of_match_table = bh1745_of_match,
+	},
+	.probe = bh1745_probe,
+	.remove = bh1745_remove,
+	.id_table = bh1745_idtable,
+};
+
+module_i2c_driver(bh1745_driver);
+MODULE_AUTHOR("Mudit Sharma <muditsharma.info@gmail.com>");
+MODULE_DESCRIPTION("BH1745 colour sensor driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0


