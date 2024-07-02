Return-Path: <linux-iio+bounces-7135-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8125D924033
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 16:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBE85B25D55
	for <lists+linux-iio@lfdr.de>; Tue,  2 Jul 2024 14:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902101B583F;
	Tue,  2 Jul 2024 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAUi9Zsa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DE01B583E;
	Tue,  2 Jul 2024 14:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719929645; cv=none; b=YwAOCO4ZJ8PyLNVdMyEhkW1C9lW4cMZeWT/5xVXlC8ahQqB1HU0nOo9WaorvdaElOznRC1NxsuylhAVvoZp0u+olTJF+J16bWZV/UFYzDpiojTmX0Yf1nveV/XoZzwAi7m3PfRWer8eosJwPvvHHOmUlJsCEmqXQjJOsRzzbbnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719929645; c=relaxed/simple;
	bh=QGI98O7ud8a9YsDBcm/KWxBbt43sD8oGzYKMh+Z+MNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QJp2KbE8mpfEIlxIrov8QUWMzMoPj2XaXHa8zZMYNMYdi/c5NGSzKlSwFf3VtbnXBup4f4QoBGbZMLK4AefaLndeY36QYyphmCAHtGhu/U5RmfKOtfAm7KKtouumqpe8IGQ61S8XfiUK6U3n3ClKRwufhHyyvy3Lf+csD/4AmZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAUi9Zsa; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7201cb6cae1so2283443a12.2;
        Tue, 02 Jul 2024 07:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719929642; x=1720534442; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G5jrod5QPT7Dk/dMg3fNfu5tzuc/VhhzOKPhWLeMt00=;
        b=NAUi9Zsal0BdnE1pOoXldaXMAuj/dJ8iGePMoTIC5q0Mqm2Hnd+EnSyO+isc1YcGJS
         D/I80G4tU8TpGZsNv9XoC1CQCg8+Jv27eEQztSAFn3g/wX/b7q1/mWMtvQxrH3rwrJC6
         j3PUSdXqLkFER+n8E3dWGwM6ri2X9sfeuszYLC8/k0A+Sa///1jFq6O1/+EcMzk6cO4j
         7D8bq8cJCaUSlYN6ILXntq+buzbxFJUfrz6MratBndWPxsEYAMEQ07/5T+vvXZKTj8UP
         9JGQ/TAZ5NKLgqM1QzHCgNwDsnEOrjFNrXnuTrG8ThY2ZcJhr2JxbWw58BLpJk+9eQWF
         3shQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719929642; x=1720534442;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5jrod5QPT7Dk/dMg3fNfu5tzuc/VhhzOKPhWLeMt00=;
        b=FaZib26tMlkY0UBHeDuXdTCBWvDAgUndefQNDRQi+mIM1aDlCWSjx2xapFFyZ12057
         22EDXpQBnjuuE00fVpn8Mopxr8STwt/xt0YaItmPC8YqK+Ot2Y5nvAr3AlnYCgU2+z0Y
         2BjmDGBgFDDZONtL+bkg6xJjxvGQeX7WiWHzzmz+5qERlYHLjX+5uat8i+I7zdZrOvn8
         qsnDVkG/paD4fzgD7UyQmwzHo6CqiEHZ48aACWv8kHYK5Jeu2aFpZEyA5bzY53rZMHgM
         pFdI+c16RCBxB998njcZPnbBWlsEZov7wN7mnLXgpO8HoUMgcSh90dJgtKceLeR7UTiY
         ii7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXe82eXfu2E6OWZnf1iCr27NhCFLZzcqPm6xyz3wAmZAasAkMmrbcsEE487JFNVUd9lm0RBsfK1RekVm/0b1nWY7V8gjYlmyzIlwZQ0C9vD8jPQo95leSsfKgvB0KRrxto3JW9VzGTV
X-Gm-Message-State: AOJu0YxJXTrB5vmQ8zhXqHkgJ5lsFPhOeMTvQM/1IQwILeEl+BbDM2/z
	cwzaU31ozNSk8fyO0vBix37cHAePuKhU/cio4EPZndv2bMuWleZ6SkXh2B/gQR7oC0DN
X-Google-Smtp-Source: AGHT+IFelUDwX6Jmg8aQFD4rixcGOGwUML+7BDrFE4gnUPI441O80D43FBx7QO6z7nC8/qdAJip6/g==
X-Received: by 2002:a05:6a20:258a:b0:1be:c3c1:7be8 with SMTP id adf61e73a8af0-1bef61407bbmr9206922637.26.1719929641024;
        Tue, 02 Jul 2024 07:14:01 -0700 (PDT)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708044ac1e1sm8547872b3a.163.2024.07.02.07.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 07:14:00 -0700 (PDT)
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Tue, 02 Jul 2024 22:12:34 +0800
Subject: [PATCH v9 3/3] iio: proximity: Add driver support for TYHX's
 HX9023S capacitive proximity sensor
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-add-tyhx-hx9023s-sensor-driver-v9-3-c030f1801d9b@gmail.com>
References: <20240702-add-tyhx-hx9023s-sensor-driver-v9-0-c030f1801d9b@gmail.com>
In-Reply-To: <20240702-add-tyhx-hx9023s-sensor-driver-v9-0-c030f1801d9b@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, yasin.lee.x@outlook.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719929607; l=35491;
 i=yasin.lee.x@gmail.com; s=20240616; h=from:subject:message-id;
 bh=QGI98O7ud8a9YsDBcm/KWxBbt43sD8oGzYKMh+Z+MNg=;
 b=vYVXHd3Dtdm+PBb2lT6HAWxkqPUsKh4RjNVOVvz1ymqDc2ZKmmCflQtuqNtylhNXdyAllManI
 YN3UbmuAeMjClFNzoj4umuD4Y2LthhvbTgBaP3VMZ1cKJy1Tl80Pc+U
X-Developer-Key: i=yasin.lee.x@gmail.com; a=ed25519;
 pk=BU85jOyDTb45hxm+MZA26zg/m26xjGZhLgKrPSRtySI=

A SAR sensor from NanjingTianyihexin Electronics Ltd.

The device has the following entry points:

Usual frequency:
- sampling_frequency

Instant reading of current values for different sensors:
- in_proximity0_raw
- in_proximity1_raw
- in_proximity2_raw
- in_proximity3_raw
- in_proximity4_raw
and associated events in events/

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 drivers/iio/proximity/Kconfig   |   14 +
 drivers/iio/proximity/Makefile  |    1 +
 drivers/iio/proximity/hx9023s.c | 1124 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 1139 insertions(+)

diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
index 2ca3b0bc5eba..0694f625b432 100644
--- a/drivers/iio/proximity/Kconfig
+++ b/drivers/iio/proximity/Kconfig
@@ -32,6 +32,20 @@ config CROS_EC_MKBP_PROXIMITY
 	  To compile this driver as a module, choose M here: the
 	  module will be called cros_ec_mkbp_proximity.
 
+config HX9023S
+	tristate "TYHX HX9023S SAR sensor"
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	select REGMAP_I2C
+	depends on I2C
+	help
+	  Say Y here to build a driver for TYHX HX9023S capacitive SAR sensor.
+	  This driver supports the TYHX HX9023S capacitive
+	  SAR sensors. This sensors is used for proximity detection applications.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called hx9023s.
+
 config IRSD200
 	tristate "Murata IRS-D200 PIR sensor"
 	select IIO_BUFFER
diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
index f36598380446..ab381cd27dbb 100644
--- a/drivers/iio/proximity/Makefile
+++ b/drivers/iio/proximity/Makefile
@@ -6,6 +6,7 @@
 # When adding new entries keep the list in alphabetical order
 obj-$(CONFIG_AS3935)		+= as3935.o
 obj-$(CONFIG_CROS_EC_MKBP_PROXIMITY) += cros_ec_mkbp_proximity.o
+obj-$(CONFIG_HX9023S)		+= hx9023s.o
 obj-$(CONFIG_IRSD200)		+= irsd200.o
 obj-$(CONFIG_ISL29501)		+= isl29501.o
 obj-$(CONFIG_LIDAR_LITE_V2)	+= pulsedlight-lidar-lite-v2.o
diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
new file mode 100644
index 000000000000..e3f3fee2c94a
--- /dev/null
+++ b/drivers/iio/proximity/hx9023s.c
@@ -0,0 +1,1124 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 NanjingTianyihexin Electronics Ltd.
+ * http://www.tianyihexin.com
+ *
+ * Driver for NanjingTianyihexin HX9023S Cap Sensor.
+ * Datasheet available at:
+ * http://www.tianyihexin.com/ueditor/php/upload/file/20240614/1718336303992081.pdf
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/irqreturn.h>
+#include <linux/math64.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <asm/byteorder.h>
+#include <asm/unaligned.h>
+
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/types.h>
+
+#define HX9023S_CHIP_ID 0x1D
+#define HX9023S_CH_NUM 5
+#define HX9023S_POS 0x03
+#define HX9023S_NEG 0x02
+#define HX9023S_NOT_CONNECTED 16
+
+#define HX9023S_GLOBAL_CTRL0                   0x00
+#define HX9023S_PRF_CFG                        0x02
+#define HX9023S_CH0_CFG_7_0                    0x03
+#define HX9023S_CH4_CFG_9_8                    0x0C
+#define HX9023S_RANGE_7_0                      0x0D
+#define HX9023S_RANGE_9_8                      0x0E
+#define HX9023S_RANGE_18_16                    0x0F
+#define HX9023S_AVG0_NOSR0_CFG                 0x10
+#define HX9023S_NOSR12_CFG                     0x11
+#define HX9023S_NOSR34_CFG                     0x12
+#define HX9023S_AVG12_CFG                      0x13
+#define HX9023S_AVG34_CFG                      0x14
+#define HX9023S_OFFSET_DAC0_7_0                0x15
+#define HX9023S_OFFSET_DAC4_9_8                0x1E
+#define HX9023S_SAMPLE_NUM_7_0                 0x1F
+#define HX9023S_INTEGRATION_NUM_7_0            0x21
+#define HX9023S_CH_NUM_CFG                     0x24
+#define HX9023S_LP_ALP_4_CFG                   0x29
+#define HX9023S_LP_ALP_1_0_CFG                 0x2A
+#define HX9023S_LP_ALP_3_2_CFG                 0x2B
+#define HX9023S_UP_ALP_1_0_CFG                 0x2C
+#define HX9023S_UP_ALP_3_2_CFG                 0x2D
+#define HX9023S_DN_UP_ALP_0_4_CFG              0x2E
+#define HX9023S_DN_ALP_2_1_CFG                 0x2F
+#define HX9023S_DN_ALP_4_3_CFG                 0x30
+#define HX9023S_RAW_BL_RD_CFG                  0x38
+#define HX9023S_INTERRUPT_CFG                  0x39
+#define HX9023S_INTERRUPT_CFG1                 0x3A
+#define HX9023S_CALI_DIFF_CFG                  0x3B
+#define HX9023S_DITHER_CFG                     0x3C
+#define HX9023S_DEVICE_ID                      0x60
+#define HX9023S_PROX_STATUS                    0x6B
+#define HX9023S_PROX_INT_HIGH_CFG              0x6C
+#define HX9023S_PROX_INT_LOW_CFG               0x6D
+#define HX9023S_PROX_HIGH_DIFF_CFG_CH0_0       0x80
+#define HX9023S_PROX_LOW_DIFF_CFG_CH0_0        0x88
+#define HX9023S_PROX_LOW_DIFF_CFG_CH3_1        0x8F
+#define HX9023S_PROX_HIGH_DIFF_CFG_CH4_0       0x9E
+#define HX9023S_PROX_HIGH_DIFF_CFG_CH4_1       0x9F
+#define HX9023S_PROX_LOW_DIFF_CFG_CH4_0        0xA2
+#define HX9023S_PROX_LOW_DIFF_CFG_CH4_1        0xA3
+#define HX9023S_CAP_INI_CH4_0                  0xB3
+#define HX9023S_LP_DIFF_CH4_2                  0xBA
+#define HX9023S_RAW_BL_CH4_0                   0xB5
+#define HX9023S_LP_DIFF_CH4_0                  0xB8
+#define HX9023S_DSP_CONFIG_CTRL1               0xC8
+#define HX9023S_CAP_INI_CH0_0                  0xE0
+#define HX9023S_RAW_BL_CH0_0                   0xE8
+#define HX9023S_LP_DIFF_CH0_0                  0xF4
+#define HX9023S_LP_DIFF_CH3_2                  0xFF
+
+#define HX9023S_DATA_LOCK_MASK BIT(4)
+#define HX9023S_INTERRUPT_MASK GENMASK(9, 0)
+#define HX9023S_PROX_DEBOUNCE_MASK GENMASK(3, 0)
+
+struct hx9023s_ch_data {
+	s16 raw; /* Raw Data*/
+	s16 lp; /* Low Pass Filter Data*/
+	s16 bl; /* Base Line Data */
+	s16 diff; /* Difference of Low Pass Data and Base Line Data */
+
+	struct {
+		unsigned int near;
+		unsigned int far;
+	} thres;
+
+	u16 dac;
+	u8 channel_positive;
+	u8 channel_negative;
+	bool sel_bl;
+	bool sel_raw;
+	bool sel_diff;
+	bool sel_lp;
+	bool enable;
+};
+
+struct hx9023s_data {
+	struct iio_trigger *trig;
+	struct regmap *regmap;
+	unsigned long chan_prox_stat;
+	unsigned long chan_read;
+	unsigned long chan_event;
+	unsigned long ch_en_stat;
+	unsigned long chan_in_use;
+	unsigned int prox_state_reg;
+	bool trigger_enabled;
+
+	struct {
+		__le16 channels[HX9023S_CH_NUM];
+		s64 ts __aligned(8);
+	} buffer;
+
+	/*
+	 * Serialize access to registers below:
+	 * HX9023S_PROX_INT_LOW_CFG,
+	 * HX9023S_PROX_INT_HIGH_CFG,
+	 * HX9023S_INTERRUPT_CFG,
+	 * HX9023S_CH_NUM_CFG
+	 * Serialize access to channel configuration in
+	 * hx9023s_push_events and hx9023s_trigger_handler.
+	 */
+	struct mutex mutex;
+	struct hx9023s_ch_data ch_data[HX9023S_CH_NUM];
+};
+
+static const struct reg_sequence hx9023s_reg_init_list[] = {
+	/* scan period */
+	REG_SEQ0(HX9023S_PRF_CFG, 0x17),
+
+	/* full scale of conversion phase of each channel */
+	REG_SEQ0(HX9023S_RANGE_7_0, 0x11),
+	REG_SEQ0(HX9023S_RANGE_9_8, 0x02),
+	REG_SEQ0(HX9023S_RANGE_18_16, 0x00),
+
+	/* ADC average number and OSR number of each channel */
+	REG_SEQ0(HX9023S_AVG0_NOSR0_CFG, 0x71),
+	REG_SEQ0(HX9023S_NOSR12_CFG, 0x44),
+	REG_SEQ0(HX9023S_NOSR34_CFG, 0x00),
+	REG_SEQ0(HX9023S_AVG12_CFG, 0x33),
+	REG_SEQ0(HX9023S_AVG34_CFG, 0x00),
+
+	/* sample & integration frequency of the ADC */
+	REG_SEQ0(HX9023S_SAMPLE_NUM_7_0, 0x65),
+	REG_SEQ0(HX9023S_INTEGRATION_NUM_7_0, 0x65),
+
+	/* coefficient of the first order low pass filter during each channel */
+	REG_SEQ0(HX9023S_LP_ALP_1_0_CFG, 0x22),
+	REG_SEQ0(HX9023S_LP_ALP_3_2_CFG, 0x22),
+	REG_SEQ0(HX9023S_LP_ALP_4_CFG, 0x02),
+
+	/* up coefficient of the first order low pass filter during each channel */
+	REG_SEQ0(HX9023S_UP_ALP_1_0_CFG, 0x88),
+	REG_SEQ0(HX9023S_UP_ALP_3_2_CFG, 0x88),
+	REG_SEQ0(HX9023S_DN_UP_ALP_0_4_CFG, 0x18),
+
+	/* down coefficient of the first order low pass filter during each channel */
+	REG_SEQ0(HX9023S_DN_ALP_2_1_CFG, 0x11),
+	REG_SEQ0(HX9023S_DN_ALP_4_3_CFG, 0x11),
+
+	/* selection of data for the Data Mux Register to output data */
+	REG_SEQ0(HX9023S_RAW_BL_RD_CFG, 0xF0),
+
+	/* enable the interrupt function */
+	REG_SEQ0(HX9023S_INTERRUPT_CFG, 0xFF),
+	REG_SEQ0(HX9023S_INTERRUPT_CFG1, 0x3B),
+	REG_SEQ0(HX9023S_DITHER_CFG, 0x21),
+
+	/* threshold of the offset compensation */
+	REG_SEQ0(HX9023S_CALI_DIFF_CFG, 0x07),
+
+	/* proximity persistency number(near & far) */
+	REG_SEQ0(HX9023S_PROX_INT_HIGH_CFG, 0x01),
+	REG_SEQ0(HX9023S_PROX_INT_LOW_CFG, 0x01),
+
+	/* disable the data lock */
+	REG_SEQ0(HX9023S_DSP_CONFIG_CTRL1, 0x00),
+};
+
+static const struct iio_event_spec hx9023s_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_PERIOD),
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+#define HX9023S_CHANNEL(idx)					\
+{								\
+	.type = IIO_PROXIMITY,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
+	.indexed = 1,						\
+	.channel = idx,						\
+	.address = 0,						\
+	.event_spec = hx9023s_events,				\
+	.num_event_specs = ARRAY_SIZE(hx9023s_events),		\
+	.scan_index = idx,					\
+	.scan_type = {						\
+		.sign = 's',					\
+		.realbits = 16,					\
+		.storagebits = 16,				\
+		.endianness = IIO_BE,				\
+	},							\
+}
+
+static const struct iio_chan_spec hx9023s_channels[] = {
+	HX9023S_CHANNEL(0),
+	HX9023S_CHANNEL(1),
+	HX9023S_CHANNEL(2),
+	HX9023S_CHANNEL(3),
+	HX9023S_CHANNEL(4),
+	IIO_CHAN_SOFT_TIMESTAMP(5),
+};
+
+static const unsigned int hx9023s_samp_freq_table[] = {
+	2, 2, 4, 6, 8, 10, 14, 18, 22, 26,
+	30, 34, 38, 42, 46, 50, 56, 62, 68, 74,
+	80, 90, 100, 200, 300, 400, 600, 800, 1000, 2000,
+	3000, 4000,
+};
+
+static const struct regmap_range hx9023s_rd_reg_ranges[] = {
+	regmap_reg_range(HX9023S_GLOBAL_CTRL0, HX9023S_LP_DIFF_CH3_2),
+};
+
+static const struct regmap_range hx9023s_wr_reg_ranges[] = {
+	regmap_reg_range(HX9023S_GLOBAL_CTRL0, HX9023S_LP_DIFF_CH3_2),
+};
+
+static const struct regmap_range hx9023s_volatile_reg_ranges[] = {
+	regmap_reg_range(HX9023S_CAP_INI_CH4_0, HX9023S_LP_DIFF_CH4_2),
+	regmap_reg_range(HX9023S_CAP_INI_CH0_0, HX9023S_LP_DIFF_CH3_2),
+	regmap_reg_range(HX9023S_PROX_STATUS, HX9023S_PROX_STATUS),
+};
+
+static const struct regmap_access_table hx9023s_rd_regs = {
+	.yes_ranges = hx9023s_rd_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(hx9023s_rd_reg_ranges),
+};
+
+static const struct regmap_access_table hx9023s_wr_regs = {
+	.yes_ranges = hx9023s_wr_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(hx9023s_wr_reg_ranges),
+};
+
+static const struct regmap_access_table hx9023s_volatile_regs = {
+	.yes_ranges = hx9023s_volatile_reg_ranges,
+	.n_yes_ranges = ARRAY_SIZE(hx9023s_volatile_reg_ranges),
+};
+
+static const struct regmap_config hx9023s_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.cache_type = REGCACHE_MAPLE,
+	.rd_table = &hx9023s_rd_regs,
+	.wr_table = &hx9023s_wr_regs,
+	.volatile_table = &hx9023s_volatile_regs,
+};
+
+static int hx9023s_interrupt_enable(struct hx9023s_data *data)
+{
+	return regmap_update_bits(data->regmap, HX9023S_INTERRUPT_CFG,
+				HX9023S_INTERRUPT_MASK, HX9023S_INTERRUPT_MASK);
+}
+
+static int hx9023s_interrupt_disable(struct hx9023s_data *data)
+{
+	return regmap_update_bits(data->regmap, HX9023S_INTERRUPT_CFG,
+				HX9023S_INTERRUPT_MASK, 0x00);
+}
+
+static int hx9023s_data_lock(struct hx9023s_data *data, bool locked)
+{
+	if (locked)
+		return regmap_update_bits(data->regmap, HX9023S_DSP_CONFIG_CTRL1,
+					HX9023S_DATA_LOCK_MASK, HX9023S_DATA_LOCK_MASK);
+	else
+		return regmap_update_bits(data->regmap, HX9023S_DSP_CONFIG_CTRL1,
+					HX9023S_DATA_LOCK_MASK, 0);
+}
+
+static int hx9023s_ch_cfg(struct hx9023s_data *data)
+{
+	u8 reg_list[HX9023S_CH_NUM * 2];
+	u8 ch_pos[HX9023S_CH_NUM];
+	u8 ch_neg[HX9023S_CH_NUM];
+	/* Bit positions corresponding to input pin connections */
+	u8 conn_cs[HX9023S_CH_NUM] = { 0, 2, 4, 6, 8 };
+	unsigned int i;
+	u16 reg;
+
+	for (i = 0; i < HX9023S_CH_NUM; i++) {
+		ch_pos[i] = data->ch_data[i].channel_positive == HX9023S_NOT_CONNECTED ?
+			HX9023S_NOT_CONNECTED : conn_cs[data->ch_data[i].channel_positive];
+		ch_neg[i] = data->ch_data[i].channel_negative == HX9023S_NOT_CONNECTED ?
+			HX9023S_NOT_CONNECTED : conn_cs[data->ch_data[i].channel_negative];
+
+		reg = (HX9023S_POS << ch_pos[i]) | (HX9023S_NEG << ch_neg[i]);
+		put_unaligned_le16(reg, &reg_list[i * 2]);
+	}
+
+	return regmap_bulk_write(data->regmap, HX9023S_CH0_CFG_7_0, reg_list, HX9023S_CH_NUM * 2);
+}
+
+static int hx9023s_write_far_debounce(struct hx9023s_data *data, int val)
+{
+	guard(mutex)(&data->mutex);
+	return regmap_update_bits(data->regmap, HX9023S_PROX_INT_LOW_CFG,
+				HX9023S_PROX_DEBOUNCE_MASK,
+				FIELD_GET(HX9023S_PROX_DEBOUNCE_MASK, val));
+}
+
+static int hx9023s_write_near_debounce(struct hx9023s_data *data, int val)
+{
+	guard(mutex)(&data->mutex);
+	return regmap_update_bits(data->regmap, HX9023S_PROX_INT_HIGH_CFG,
+				HX9023S_PROX_DEBOUNCE_MASK,
+				FIELD_GET(HX9023S_PROX_DEBOUNCE_MASK, val));
+}
+
+static int hx9023s_read_far_debounce(struct hx9023s_data *data, int *val)
+{
+	int ret;
+
+	ret = regmap_read(data->regmap, HX9023S_PROX_INT_LOW_CFG, val);
+	if (ret)
+		return ret;
+
+	*val = FIELD_GET(HX9023S_PROX_DEBOUNCE_MASK, *val);
+
+	return IIO_VAL_INT;
+}
+
+static int hx9023s_read_near_debounce(struct hx9023s_data *data, int *val)
+{
+	int ret;
+
+	ret = regmap_read(data->regmap, HX9023S_PROX_INT_HIGH_CFG, val);
+	if (ret)
+		return ret;
+
+	*val = FIELD_GET(HX9023S_PROX_DEBOUNCE_MASK, *val);
+
+	return IIO_VAL_INT;
+}
+
+static int hx9023s_get_thres_near(struct hx9023s_data *data, u8 ch, int *val)
+{
+	int ret;
+	u8 buf[2];
+	unsigned int reg, tmp;
+
+	reg = (ch == 4) ? HX9023S_PROX_HIGH_DIFF_CFG_CH4_0 :
+		HX9023S_PROX_HIGH_DIFF_CFG_CH0_0 + (ch * 2);
+
+	ret = regmap_bulk_read(data->regmap, reg, buf, sizeof(buf));
+	if (ret)
+		return ret;
+
+	tmp = (get_unaligned_le16(buf) & GENMASK(9, 0)) * 32;
+	data->ch_data[ch].thres.near = tmp;
+	*val = tmp;
+
+	return IIO_VAL_INT;
+}
+
+static int hx9023s_get_thres_far(struct hx9023s_data *data, u8 ch, int *val)
+{
+	int ret;
+	u8 buf[2];
+	unsigned int reg, tmp;
+
+	reg = (ch == 4) ? HX9023S_PROX_LOW_DIFF_CFG_CH4_0 :
+		HX9023S_PROX_LOW_DIFF_CFG_CH0_0 + (ch * 2);
+
+	ret = regmap_bulk_read(data->regmap, reg, buf, sizeof(buf));
+	if (ret)
+		return ret;
+
+	tmp = (get_unaligned_le16(buf) & GENMASK(9, 0)) * 32;
+	data->ch_data[ch].thres.far = tmp;
+	*val = tmp;
+
+	return IIO_VAL_INT;
+}
+
+static int hx9023s_set_thres_near(struct hx9023s_data *data, u8 ch, int val)
+{
+	__le16 val_le16 = cpu_to_le16((val / 32) & GENMASK(9, 0));
+	unsigned int reg;
+
+	data->ch_data[ch].thres.near = ((val / 32) & GENMASK(9, 0)) * 32;
+	reg = (ch == 4) ? HX9023S_PROX_HIGH_DIFF_CFG_CH4_0 :
+		HX9023S_PROX_HIGH_DIFF_CFG_CH0_0 + (ch * 2);
+
+	return regmap_bulk_write(data->regmap, reg, &val_le16, sizeof(val_le16));
+}
+
+static int hx9023s_set_thres_far(struct hx9023s_data *data, u8 ch, int val)
+{
+	__le16 val_le16 = cpu_to_le16((val / 32) & GENMASK(9, 0));
+	unsigned int reg;
+
+	data->ch_data[ch].thres.far = ((val / 32) & GENMASK(9, 0)) * 32;
+	reg = (ch == 4) ? HX9023S_PROX_LOW_DIFF_CFG_CH4_0 :
+		HX9023S_PROX_LOW_DIFF_CFG_CH0_0 + (ch * 2);
+
+	return regmap_bulk_write(data->regmap, reg, &val_le16, sizeof(val_le16));
+}
+
+static int hx9023s_get_prox_state(struct hx9023s_data *data)
+{
+	return regmap_read(data->regmap, HX9023S_PROX_STATUS, &data->prox_state_reg);
+}
+
+static int hx9023s_data_select(struct hx9023s_data *data)
+{
+	int ret;
+	unsigned int i, buf;
+	unsigned long tmp;
+
+	ret = regmap_read(data->regmap, HX9023S_RAW_BL_RD_CFG, &buf);
+	if (ret)
+		return ret;
+
+	tmp = buf;
+	for (i = 0; i < 4; i++) {
+		data->ch_data[i].sel_diff = test_bit(i, &tmp);
+		data->ch_data[i].sel_lp = !data->ch_data[i].sel_diff;
+		data->ch_data[i].sel_bl = test_bit(i + 4, &tmp);
+		data->ch_data[i].sel_raw = !data->ch_data[i].sel_bl;
+	}
+
+	ret = regmap_read(data->regmap, HX9023S_INTERRUPT_CFG1, &buf);
+	if (ret)
+		return ret;
+
+	tmp = buf;
+	data->ch_data[4].sel_diff = test_bit(2, &tmp);
+	data->ch_data[4].sel_lp = !data->ch_data[4].sel_diff;
+	data->ch_data[4].sel_bl = test_bit(3, &tmp);
+	data->ch_data[4].sel_raw = !data->ch_data[4].sel_bl;
+
+	return 0;
+}
+
+static int hx9023s_sample(struct hx9023s_data *data)
+{
+	int ret;
+	unsigned int i;
+	u8 buf[HX9023S_CH_NUM * 3];
+	u16 value;
+
+	ret = hx9023s_data_lock(data, true);
+	if (ret)
+		return ret;
+
+	ret = hx9023s_data_select(data);
+	if (ret)
+		goto err;
+
+	/* 3 bytes for each of channels 0 to 3 which have contiguous registers */
+	ret = regmap_bulk_read(data->regmap, HX9023S_RAW_BL_CH0_0, buf, 12);
+	if (ret)
+		goto err;
+
+	/* 3 bytes for channel 4 */
+	ret = regmap_bulk_read(data->regmap, HX9023S_RAW_BL_CH4_0, buf + 12, 3);
+	if (ret)
+		goto err;
+
+	for (i = 0; i < HX9023S_CH_NUM; i++) {
+		value = get_unaligned_le16(&buf[i * 3 + 1]);
+		data->ch_data[i].raw = 0;
+		data->ch_data[i].bl = 0;
+		if (data->ch_data[i].sel_raw)
+			data->ch_data[i].raw = value;
+		if (data->ch_data[i].sel_bl)
+			data->ch_data[i].bl = value;
+	}
+
+	/* 3 bytes for each of channels 0 to 3 which have contiguous registers */
+	ret = regmap_bulk_read(data->regmap, HX9023S_LP_DIFF_CH0_0, buf, 12);
+	if (ret)
+		goto err;
+
+	/* 3 bytes for channel 4 */
+	ret = regmap_bulk_read(data->regmap, HX9023S_LP_DIFF_CH4_0, buf + 12, 3);
+	if (ret)
+		goto err;
+
+	for (i = 0; i < HX9023S_CH_NUM; i++) {
+		value = get_unaligned_le16(&buf[i * 3 + 1]);
+		data->ch_data[i].lp = 0;
+		data->ch_data[i].diff = 0;
+		if (data->ch_data[i].sel_lp)
+			data->ch_data[i].lp = value;
+		if (data->ch_data[i].sel_diff)
+			data->ch_data[i].diff = value;
+	}
+
+	for (i = 0; i < HX9023S_CH_NUM; i++) {
+		if (data->ch_data[i].sel_lp && data->ch_data[i].sel_bl)
+			data->ch_data[i].diff = data->ch_data[i].lp - data->ch_data[i].bl;
+	}
+
+	/* 2 bytes for each of channels 0 to 4 which have contiguous registers */
+	ret = regmap_bulk_read(data->regmap, HX9023S_OFFSET_DAC0_7_0, buf, 10);
+	if (ret)
+		goto err;
+
+	for (i = 0; i < HX9023S_CH_NUM; i++) {
+		value = get_unaligned_le16(&buf[i * 2]);
+		value = FIELD_GET(GENMASK(11, 0), value);
+		data->ch_data[i].dac = value;
+	}
+
+err:
+	return hx9023s_data_lock(data, false);
+}
+
+static int hx9023s_ch_en(struct hx9023s_data *data, u8 ch_id, bool en)
+{
+	int ret;
+	unsigned int buf;
+
+	ret = regmap_read(data->regmap, HX9023S_CH_NUM_CFG, &buf);
+	if (ret)
+		return ret;
+
+	data->ch_en_stat = buf;
+	if (en && data->ch_en_stat == 0)
+		data->prox_state_reg = 0;
+
+	data->ch_data[ch_id].enable = en;
+	__assign_bit(ch_id, &data->ch_en_stat, en);
+
+	return regmap_write(data->regmap, HX9023S_CH_NUM_CFG, data->ch_en_stat);
+}
+
+static int hx9023s_property_get(struct hx9023s_data *data)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	u32 array[2];
+	u32 i, reg, temp;
+	int ret;
+
+	data->chan_in_use = 0;
+	for (i = 0; i < HX9023S_CH_NUM; i++) {
+		data->ch_data[i].channel_positive = HX9023S_NOT_CONNECTED;
+		data->ch_data[i].channel_negative = HX9023S_NOT_CONNECTED;
+	}
+
+	device_for_each_child_node_scoped(dev, child) {
+		ret = fwnode_property_read_u32(child, "reg", &reg);
+		if (ret || reg >= HX9023S_CH_NUM)
+			return dev_err_probe(dev, ret, "Failed to read reg\n");
+		__set_bit(reg, &data->chan_in_use);
+
+		ret = fwnode_property_read_u32(child, "single-channel", &temp);
+		if (ret == 0) {
+			data->ch_data[reg].channel_positive = temp;
+			data->ch_data[reg].channel_negative = HX9023S_NOT_CONNECTED;
+		} else {
+			ret = fwnode_property_read_u32_array(child, "diff-channels",
+							     array, ARRAY_SIZE(array));
+			if (ret == 0) {
+				data->ch_data[reg].channel_positive = array[0];
+				data->ch_data[reg].channel_negative = array[1];
+			} else {
+				return dev_err_probe(dev, ret, "Property read failed: %d\n", reg);
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int hx9023s_update_chan_en(struct hx9023s_data *data,
+				  unsigned long chan_read,
+				  unsigned long chan_event)
+{
+	unsigned int i;
+	unsigned long channels = chan_read | chan_event;
+
+	if ((data->chan_read | data->chan_event) != channels) {
+		for_each_set_bit(i, &channels, HX9023S_CH_NUM)
+			hx9023s_ch_en(data, i, test_bit(i, &data->chan_in_use));
+		for_each_clear_bit(i, &channels, HX9023S_CH_NUM)
+			hx9023s_ch_en(data, i, false);
+	}
+
+	data->chan_read = chan_read;
+	data->chan_event = chan_event;
+
+	return 0;
+}
+
+static int hx9023s_get_proximity(struct hx9023s_data *data,
+				 const struct iio_chan_spec *chan,
+				 int *val)
+{
+	int ret;
+
+	ret = hx9023s_sample(data);
+	if (ret)
+		return ret;
+
+	ret = hx9023s_get_prox_state(data);
+	if (ret)
+		return ret;
+
+	*val = data->ch_data[chan->channel].diff;
+	return IIO_VAL_INT;
+}
+
+static int hx9023s_get_samp_freq(struct hx9023s_data *data, int *val, int *val2)
+{
+	int ret;
+	unsigned int odr, index;
+
+	ret = regmap_read(data->regmap, HX9023S_PRF_CFG, &index);
+	if (ret)
+		return ret;
+
+	odr = hx9023s_samp_freq_table[index];
+	*val = KILO / odr;
+	*val2 = div_u64((KILO % odr) * MICRO, odr);
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int hx9023s_read_raw(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
+			    int *val, int *val2, long mask)
+{
+	struct hx9023s_data *data = iio_priv(indio_dev);
+	int ret;
+
+	if (chan->type != IIO_PROXIMITY)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
+		ret = hx9023s_get_proximity(data, chan, val);
+		iio_device_release_direct_mode(indio_dev);
+		return ret;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return hx9023s_get_samp_freq(data, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int hx9023s_set_samp_freq(struct hx9023s_data *data, int val, int val2)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	unsigned int i, period_ms;
+
+	period_ms = div_u64(NANO, (val * MEGA + val2));
+
+	for (i = 0; i < ARRAY_SIZE(hx9023s_samp_freq_table); i++) {
+		if (period_ms == hx9023s_samp_freq_table[i])
+			break;
+	}
+	if (i == ARRAY_SIZE(hx9023s_samp_freq_table)) {
+		dev_err(dev, "Period:%dms NOT found!\n", period_ms);
+		return -EINVAL;
+	}
+
+	return regmap_write(data->regmap, HX9023S_PRF_CFG, i);
+}
+
+static int hx9023s_write_raw(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
+			     int val, int val2, long mask)
+{
+	struct hx9023s_data *data = iio_priv(indio_dev);
+
+	if (chan->type != IIO_PROXIMITY)
+		return -EINVAL;
+
+	if (mask != IIO_CHAN_INFO_SAMP_FREQ)
+		return -EINVAL;
+
+	return hx9023s_set_samp_freq(data, val, val2);
+}
+
+static irqreturn_t hx9023s_irq_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct hx9023s_data *data = iio_priv(indio_dev);
+
+	if (data->trigger_enabled)
+		iio_trigger_poll(data->trig);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static void hx9023s_push_events(struct iio_dev *indio_dev)
+{
+	struct hx9023s_data *data = iio_priv(indio_dev);
+	s64 timestamp = iio_get_time_ns(indio_dev);
+	unsigned long prox_changed;
+	unsigned int chan;
+	int ret;
+
+	ret = hx9023s_sample(data);
+	if (ret)
+		return;
+
+	ret = hx9023s_get_prox_state(data);
+	if (ret)
+		return;
+
+	prox_changed = (data->chan_prox_stat ^ data->prox_state_reg) & data->chan_event;
+	for_each_set_bit(chan, &prox_changed, HX9023S_CH_NUM) {
+		unsigned int dir;
+
+		dir = (data->prox_state_reg & BIT(chan)) ? IIO_EV_DIR_FALLING : IIO_EV_DIR_RISING;
+
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, chan, IIO_EV_TYPE_THRESH, dir),
+			       timestamp);
+	}
+	data->chan_prox_stat = data->prox_state_reg;
+}
+
+static irqreturn_t hx9023s_irq_thread_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct hx9023s_data *data = iio_priv(indio_dev);
+
+	guard(mutex)(&data->mutex);
+	hx9023s_push_events(indio_dev);
+
+	return IRQ_HANDLED;
+}
+
+static int hx9023s_read_event_val(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan,
+				  enum iio_event_type type,
+				  enum iio_event_direction dir,
+				  enum iio_event_info info, int *val, int *val2)
+{
+	struct hx9023s_data *data = iio_priv(indio_dev);
+
+	if (chan->type != IIO_PROXIMITY)
+		return -EINVAL;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return hx9023s_get_thres_far(data, chan->channel, val);
+		case IIO_EV_DIR_FALLING:
+			return hx9023s_get_thres_near(data, chan->channel, val);
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_INFO_PERIOD:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return hx9023s_read_far_debounce(data, val);
+		case IIO_EV_DIR_FALLING:
+			return hx9023s_read_near_debounce(data, val);
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int hx9023s_write_event_val(struct iio_dev *indio_dev,
+				   const struct iio_chan_spec *chan,
+				   enum iio_event_type type,
+				   enum iio_event_direction dir,
+				   enum iio_event_info info, int val, int val2)
+{
+	struct hx9023s_data *data = iio_priv(indio_dev);
+
+	if (chan->type != IIO_PROXIMITY)
+		return -EINVAL;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return hx9023s_set_thres_far(data, chan->channel, val);
+		case IIO_EV_DIR_FALLING:
+			return hx9023s_set_thres_near(data, chan->channel, val);
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_INFO_PERIOD:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return hx9023s_write_far_debounce(data, val);
+		case IIO_EV_DIR_FALLING:
+			return hx9023s_write_near_debounce(data, val);
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int hx9023s_read_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
+{
+	struct hx9023s_data *data = iio_priv(indio_dev);
+
+	return test_bit(chan->channel, &data->chan_event);
+}
+
+static int hx9023s_write_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir,
+				      int state)
+{
+	struct hx9023s_data *data = iio_priv(indio_dev);
+
+	if (test_bit(chan->channel, &data->chan_in_use)) {
+		hx9023s_ch_en(data, chan->channel, !!state);
+		__assign_bit(chan->channel, &data->chan_event, data->ch_data[chan->channel].enable);
+	}
+
+	return 0;
+}
+
+static const struct iio_info hx9023s_info = {
+	.read_raw = hx9023s_read_raw,
+	.write_raw = hx9023s_write_raw,
+	.read_event_value = hx9023s_read_event_val,
+	.write_event_value = hx9023s_write_event_val,
+	.read_event_config = hx9023s_read_event_config,
+	.write_event_config = hx9023s_write_event_config,
+};
+
+static int hx9023s_set_trigger_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
+	struct hx9023s_data *data = iio_priv(indio_dev);
+
+	guard(mutex)(&data->mutex);
+	if (state)
+		hx9023s_interrupt_enable(data);
+	else if (!data->chan_read)
+		hx9023s_interrupt_disable(data);
+	data->trigger_enabled = state;
+
+	return 0;
+}
+
+static const struct iio_trigger_ops hx9023s_trigger_ops = {
+	.set_trigger_state = hx9023s_set_trigger_state,
+};
+
+static irqreturn_t hx9023s_trigger_handler(int irq, void *private)
+{
+	struct iio_poll_func *pf = private;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct hx9023s_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
+	unsigned int bit, index, i = 0;
+	int ret;
+
+	guard(mutex)(&data->mutex);
+	ret = hx9023s_sample(data);
+	if (ret) {
+		dev_warn(dev, "sampling failed\n");
+		goto out;
+	}
+
+	ret = hx9023s_get_prox_state(data);
+	if (ret) {
+		dev_warn(dev, "get prox failed\n");
+		goto out;
+	}
+
+	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength) {
+		index = indio_dev->channels[bit].channel;
+		data->buffer.channels[i++] = cpu_to_le16(data->ch_data[index].diff);
+	}
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer, pf->timestamp);
+
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int hx9023s_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct hx9023s_data *data = iio_priv(indio_dev);
+	unsigned long channels = 0;
+	unsigned int bit;
+
+	guard(mutex)(&data->mutex);
+	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength)
+		__set_bit(indio_dev->channels[bit].channel, &channels);
+
+	hx9023s_update_chan_en(data, channels, data->chan_event);
+
+	return 0;
+}
+
+static int hx9023s_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct hx9023s_data *data = iio_priv(indio_dev);
+
+	guard(mutex)(&data->mutex);
+	hx9023s_update_chan_en(data, 0, data->chan_event);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops hx9023s_buffer_setup_ops = {
+	.preenable = hx9023s_buffer_preenable,
+	.postdisable = hx9023s_buffer_postdisable,
+};
+
+static int hx9023s_id_check(struct iio_dev *indio_dev)
+{
+	struct hx9023s_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
+	unsigned int id;
+	int ret;
+
+	ret = regmap_read(data->regmap, HX9023S_DEVICE_ID, &id);
+	if (ret)
+		return ret;
+
+	if (id != HX9023S_CHIP_ID)
+		dev_warn(dev, "Unexpected chip ID, assuming compatible\n");
+
+	return 0;
+}
+
+static int hx9023s_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct iio_dev *indio_dev;
+	struct hx9023s_data *data;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(struct hx9023s_data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	mutex_init(&data->mutex);
+
+	data->regmap = devm_regmap_init_i2c(client, &hx9023s_regmap_config);
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(dev, PTR_ERR(data->regmap), "regmap init failed\n");
+
+	ret = hx9023s_property_get(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "dts phase failed\n");
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "regulator get failed\n");
+
+	ret = hx9023s_id_check(indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "id check failed\n");
+
+	indio_dev->name = "hx9023s";
+	indio_dev->channels = hx9023s_channels;
+	indio_dev->num_channels = ARRAY_SIZE(hx9023s_channels);
+	indio_dev->info = &hx9023s_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	i2c_set_clientdata(client, indio_dev);
+
+	ret = regmap_multi_reg_write(data->regmap, hx9023s_reg_init_list,
+				     ARRAY_SIZE(hx9023s_reg_init_list));
+	if (ret)
+		return dev_err_probe(dev, ret, "device init failed\n");
+
+	ret = hx9023s_ch_cfg(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "channel config failed\n");
+
+	ret = regcache_sync(data->regmap);
+	if (ret)
+		return dev_err_probe(dev, ret, "regcache sync failed\n");
+
+	if (client->irq) {
+		ret = devm_request_threaded_irq(dev, client->irq, hx9023s_irq_handler,
+						hx9023s_irq_thread_handler, IRQF_ONESHOT,
+						"hx9023s_event", indio_dev);
+		if (ret)
+			return dev_err_probe(dev, ret, "irq request failed\n");
+
+		data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
+						    iio_device_id(indio_dev));
+		if (!data->trig)
+			return dev_err_probe(dev, -ENOMEM,
+					"iio trigger alloc failed\n");
+
+		data->trig->ops = &hx9023s_trigger_ops;
+		iio_trigger_set_drvdata(data->trig, indio_dev);
+
+		ret = devm_iio_trigger_register(dev, data->trig);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					"iio trigger register failed\n");
+	}
+
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, iio_pollfunc_store_time,
+					      hx9023s_trigger_handler, &hx9023s_buffer_setup_ops);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				"iio triggered buffer setup failed\n");
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static int hx9023s_suspend(struct device *dev)
+{
+	struct hx9023s_data *data = iio_priv(dev_get_drvdata(dev));
+
+	guard(mutex)(&data->mutex);
+	hx9023s_interrupt_disable(data);
+
+	return 0;
+}
+
+static int hx9023s_resume(struct device *dev)
+{
+	struct hx9023s_data *data = iio_priv(dev_get_drvdata(dev));
+
+	guard(mutex)(&data->mutex);
+	if (data->trigger_enabled)
+		hx9023s_interrupt_enable(data);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(hx9023s_pm_ops, hx9023s_suspend, hx9023s_resume);
+
+static const struct of_device_id hx9023s_of_match[] = {
+	{ .compatible = "tyhx,hx9023s" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, hx9023s_of_match);
+
+static const struct i2c_device_id hx9023s_id[] = {
+	{ "hx9023s" },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, hx9023s_id);
+
+static struct i2c_driver hx9023s_driver = {
+	.driver = {
+		.name = "hx9023s",
+		.of_match_table = hx9023s_of_match,
+		.pm = &hx9023s_pm_ops,
+
+		/*
+		 * The I2C operations in hx9023s_reg_init() and hx9023s_ch_cfg()
+		 * are time-consuming. Prefer async so we don't delay boot
+		 * if we're builtin to the kernel.
+		 */
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.probe = hx9023s_probe,
+	.id_table = hx9023s_id,
+};
+module_i2c_driver(hx9023s_driver);
+
+MODULE_AUTHOR("Yasin Lee <yasin.lee.x@gmail.com>");
+MODULE_DESCRIPTION("Driver for TYHX HX9023S SAR sensor");
+MODULE_LICENSE("GPL");

-- 
2.25.1


