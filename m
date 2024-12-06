Return-Path: <linux-iio+bounces-13160-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B87DE9E7529
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 17:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86CD7168EF1
	for <lists+linux-iio@lfdr.de>; Fri,  6 Dec 2024 16:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A23A20DD58;
	Fri,  6 Dec 2024 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFrCL4MX"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2950220C00D;
	Fri,  6 Dec 2024 16:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733501409; cv=none; b=MwcC9kq8nG84AaV05S510yqYi0bppV1SLeSvY9CWzhdRyCid9kUqtS13qMS6GEvrtLqmR++1b+Or+g6pauku8aqCbXzsIpAaKIvuKcD9jTFE0pUkTx+8cQbGRdkX5+cQtFDDaDDvsfn9/8FaJKUpy6vEG+2LRKyjDJ97B58+u+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733501409; c=relaxed/simple;
	bh=nMR4V8MGKWTFohUyjsWNkXL00NOm8bL29UHYAm26VJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GvLRqUUtIb0Gd/eycKJZmrjBhXyLVd0d8SPBw1Pi6yW6BAB69JGC2CgigvmA+7MyzpeAsFXqwAxqC0LxP7fgicilWVZYcoHJpaJNrbVOL3ETtqVS/eNIXj/XEGQJy3DxhfHqpBIyVSdyS8+xJsEi0UAQcFTfckGUGs8wbojifn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFrCL4MX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1BB6C4CEDC;
	Fri,  6 Dec 2024 16:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733501408;
	bh=nMR4V8MGKWTFohUyjsWNkXL00NOm8bL29UHYAm26VJM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DFrCL4MXTCJmRTAfOLZZHDn1HLKfp1vMWuFN7/w6BLzLpV3J2ZQZWOTlV20RBRDrw
	 nEDf/7P6wkmsFwFAx8rGS2Q5ox9RMAimKz2FYYyux2Vm86QkUv0zv5f9NJ+Tgzmylu
	 XLLwlx6o36M9F+QeZZR9MBpg6tAfttFWW3HY1wWpvrWnzL2on6m/AZBamgIdeYQoX1
	 V7iTF+3tR5Hu4ZxD0MHpQMbHnkxSYWJ1HNFBwK4qTLYLQbumySuWpfkC8NA2KARy1R
	 I1g/fsMy74lJRQg8P6KhxZXSa3QQpsNHQ4R3NAqovraOwC0CzeeRiihNrX5C9graIf
	 f8qeDzbgFLa4A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1914E7717D;
	Fri,  6 Dec 2024 16:10:08 +0000 (UTC)
From: Mikael Gonella-Bolduc via B4 Relay <devnull+mgonellabolduc.dimonoff.com@kernel.org>
Date: Fri, 06 Dec 2024 11:09:57 -0500
Subject: [PATCH v2 2/2] iio: light: Add APDS9160 ALS & Proximity sensor
 driver
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-apds9160-driver-v2-2-be2cb72ef8f4@dimonoff.com>
References: <20241206-apds9160-driver-v2-0-be2cb72ef8f4@dimonoff.com>
In-Reply-To: <20241206-apds9160-driver-v2-0-be2cb72ef8f4@dimonoff.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733501407; l=42202;
 i=mgonellabolduc@dimonoff.com; s=20241119; h=from:subject:message-id;
 bh=71FBRTqRS7C12pQldNNf2osYz/EtO/ADr0z66vOJoh4=;
 b=mhQKEm3Qoytvn9JaeZPLdGnWonxdf6zGNIPakQHm3q+Gk6MHDKm01SJAJoazKdUOU/CaLKaNw
 OU2HHRlksgBAwcfnOO5yus7hxjjfS17TXVy2kuzrn+uRwkieqx2fEo7
X-Developer-Key: i=mgonellabolduc@dimonoff.com; a=ed25519;
 pk=p4tvPfGPfXRyChsgHc6s7HwB6YBl2JqqcP3BXtoDitE=
X-Endpoint-Received: by B4 Relay for mgonellabolduc@dimonoff.com/20241119
 with auth_id=279
X-Original-From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
Reply-To: mgonellabolduc@dimonoff.com

From: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>

APDS9160 is a combination of ALS and proximity sensors.

This patch add supports for:
    - Intensity clear data and illuminance data
    - Proximity data
    - Gain control, rate control
    - Event thresholds

Signed-off-by: Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
---
 MAINTAINERS                  |    7 +
 drivers/iio/light/Kconfig    |   11 +
 drivers/iio/light/Makefile   |    1 +
 drivers/iio/light/apds9160.c | 1548 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1567 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e69d1632c382fe0e366f7bb20e72ee0c9e91e30b..99903578e2a31dd946bd5f6722eb2aabc349a090 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3714,6 +3714,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
 F:	drivers/iio/light/apds9306.c
 
+AVAGO APDS9160 AMBIENT LIGHT SENSOR AND PROXIMITY DRIVER
+M:	Mikael Gonella-Bolduc <mgonellabolduc@dimonoff.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/light/avago,apds9160.yaml
+F:	drivers/iio/light/apds9160.c
+
 AVIA HX711 ANALOG DIGITAL CONVERTER IIO DRIVER
 M:	Andreas Klinger <ak@it-klinger.de>
 L:	linux-iio@vger.kernel.org
diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 29ffa84919273d64b8464ab8bbf59661b0102f97..419360661d53973eda71d7d986ff7fd481c7aa2c 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -63,6 +63,17 @@ config AL3320A
 	  To compile this driver as a module, choose M here: the
 	  module will be called al3320a.
 
+config APDS9160
+	tristate "APDS9160 combined als and proximity sensor"
+	depends on I2C
+	select REGMAP_I2C
+	help
+	   Say Y here if you want to build support for a Broadcom APDS9160
+		combined ambient light and proximity sensor.
+
+	   To compile this driver as a module, choose M here: the
+	   module will be called apds9160.
+
 config APDS9300
 	tristate "APDS9300 ambient light sensor"
 	depends on I2C
diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
index f14a3744271242f04fe7849b47308397ac2c9939..4a22043acdbbbed2b696a3225e4024654d5d9339 100644
--- a/drivers/iio/light/Makefile
+++ b/drivers/iio/light/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_ADJD_S311)		+= adjd_s311.o
 obj-$(CONFIG_ADUX1020)		+= adux1020.o
 obj-$(CONFIG_AL3010)		+= al3010.o
 obj-$(CONFIG_AL3320A)		+= al3320a.o
+obj-$(CONFIG_APDS9160)		+= apds9160.o
 obj-$(CONFIG_APDS9300)		+= apds9300.o
 obj-$(CONFIG_APDS9306)		+= apds9306.o
 obj-$(CONFIG_APDS9960)		+= apds9960.o
diff --git a/drivers/iio/light/apds9160.c b/drivers/iio/light/apds9160.c
new file mode 100644
index 0000000000000000000000000000000000000000..1cc639c31ebfef7254bf967e56a25a75f99ab05c
--- /dev/null
+++ b/drivers/iio/light/apds9160.c
@@ -0,0 +1,1548 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * APDS9160 sensor driver.
+ * Chip is combined proximity and ambient light sensor.
+ * Author: 2024 Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>
+ */
+
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/events.h>
+#include <linux/iio/sysfs.h>
+
+#include <linux/unaligned.h>
+
+#define APDS9160_REGMAP_NAME "apds9160_regmap"
+#define APDS9160_REG_CNT 37
+
+/* Main control register */
+#define APDS9160_REG_CTRL 0x00
+#define APDS9160_CTRL_SWRESET BIT(4) /* 1: Activate reset */
+#define APDS9160_CTRL_MODE_RGB BIT(2) /* 0: ALS & IR, 1: RGB & IR */
+#define APDS9160_CTRL_EN_ALS BIT(1) /* 1: ALS active */
+#define APDS9160_CTLR_EN_PS BIT(0) /* 1: PS active */
+
+/* Status register  */
+#define APDS9160_SR_LS_INT BIT(4)
+#define APDS9160_SR_LS_NEW_DATA BIT(3)
+#define APDS9160_SR_PS_INT BIT(1)
+#define APDS9160_SR_PS_NEW_DATA BIT(0)
+
+/* Interrupt configuration registers */
+#define APDS9160_REG_INT_CFG 0x19
+#define APDS9160_REG_INT_PST 0x1A
+#define APDS9160_INT_CFG_EN_LS BIT(2) /* LS int enable */
+#define APDS9160_INT_CFG_EN_PS BIT(0) /* PS int enable */
+
+/* Proximity registers */
+#define APDS9160_REG_PS_LED 0x01
+#define APDS9160_REG_PS_PULSES 0x02
+#define APDS9160_REG_PS_MEAS_RATE 0x03
+#define APDS9160_REG_PS_THRES_HI_LSB 0x1B
+#define APDS9160_REG_PS_THRES_HI_MSB 0x1C
+#define APDS9160_REG_PS_THRES_LO_LSB 0x1D
+#define APDS9160_REG_PS_THRES_LO_MSB 0x1E
+#define APDS9160_REG_PS_DATA_LSB 0x08
+#define APDS9160_REG_PS_DATA_MSB 0x09
+#define APDS9160_REG_PS_CAN_LEVEL_DIG_LSB 0x1F
+#define APDS9160_REG_PS_CAN_LEVEL_DIG_MSB 0x20
+#define APDS9160_REG_PS_CAN_LEVEL_ANA_DUR 0x21
+#define APDS9160_REG_PS_CAN_LEVEL_ANA_CURRENT 0x22
+
+/* Light sensor registers */
+#define APDS9160_REG_LS_MEAS_RATE 0x04
+#define APDS9160_REG_LS_GAIN 0x05
+#define APDS9160_REG_LS_DATA_CLEAR_LSB 0x0A
+#define APDS9160_REG_LS_DATA_CLEAR 0x0B
+#define APDS9160_REG_LS_DATA_CLEAR_MSB 0x0C
+#define APDS9160_REG_LS_DATA_ALS_LSB 0x0D
+#define APDS9160_REG_LS_DATA_ALS 0x0E
+#define APDS9160_REG_LS_DATA_ALS_MSB 0x0F
+#define APDS9160_REG_LS_THRES_UP_LSB 0x24
+#define APDS9160_REG_LS_THRES_UP 0x25
+#define APDS9160_REG_LS_THRES_UP_MSB 0x26
+#define APDS9160_REG_LS_THRES_LO_LSB 0x27
+#define APDS9160_REG_LS_THRES_LO 0x28
+#define APDS9160_REG_LS_THRES_LO_MSB 0x29
+#define APDS9160_REG_LS_THRES_VAR 0x2A
+
+/* Part identification number register */
+#define APDS9160_REG_ID 0x06
+
+/* Status register */
+#define APDS9160_REG_SR 0x07
+#define APDS9160_SR_DATA_ALS BIT(3)
+#define APDS9160_SR_DATA_PS BIT(0)
+
+/* Supported ID:s */
+#define APDS9160_PART_ID_0 0x03
+
+#define APDS9160_PS_THRES_MAX 0x7FF
+#define APDS9160_LS_THRES_MAX 0xFFFFF
+#define APDS9160_CMD_LS_RESOLUTION_25MS 0x04
+#define APDS9160_CMD_LS_RESOLUTION_50MS 0x03
+#define APDS9160_CMD_LS_RESOLUTION_100MS 0x02
+#define APDS9160_CMD_LS_RESOLUTION_200MS 0x01
+#define APDS9160_PS_DATA_MASK 0x7FF
+
+#define APDS9160_DEFAULT_LS_GAIN 3
+#define APDS9160_DEFAULT_LS_RATE 100
+#define APDS9160_DEFAULT_PS_RATE 100
+#define APDS9160_DEFAULT_PS_CANCELLATION_LEVEL 0
+#define APDS9160_DEFAULT_PS_ANALOG_CANCELLATION 0
+#define APDS9160_DEFAULT_PS_GAIN 1
+#define APDS9160_DEFAULT_PS_CURRENT 100
+#define APDS9160_DEFAULT_PS_RESOLUTION_11BITS 0x03
+
+static const struct reg_default apds9160_reg_defaults[] = {
+	{ APDS9160_REG_CTRL, 0x00 }, /* Sensors disabled by default  */
+	{ APDS9160_REG_PS_LED, 0x33 }, /* 60 kHz frequency, 100 mA */
+	{ APDS9160_REG_PS_PULSES, 0x08 }, /* 8 pulses */
+	{ APDS9160_REG_PS_MEAS_RATE, 0x05 }, /* 100ms */
+	{ APDS9160_REG_LS_MEAS_RATE, 0x22 }, /* 100ms */
+	{ APDS9160_REG_LS_GAIN, 0x01 }, /* 3x */
+	{ APDS9160_REG_INT_CFG, 0x10 }, /* Interrupts disabled */
+	{ APDS9160_REG_INT_PST, 0x00 },
+	{ APDS9160_REG_PS_THRES_HI_LSB, 0xFF },
+	{ APDS9160_REG_PS_THRES_HI_MSB, 0x07 },
+	{ APDS9160_REG_PS_THRES_LO_LSB, 0x00 },
+	{ APDS9160_REG_PS_THRES_LO_MSB, 0x00 },
+	{ APDS9160_REG_PS_CAN_LEVEL_DIG_LSB, 0x00 },
+	{ APDS9160_REG_PS_CAN_LEVEL_DIG_MSB, 0x00 },
+	{ APDS9160_REG_PS_CAN_LEVEL_ANA_DUR, 0x00 },
+	{ APDS9160_REG_PS_CAN_LEVEL_ANA_CURRENT, 0x00 },
+	{ APDS9160_REG_LS_THRES_UP_LSB, 0xFF },
+	{ APDS9160_REG_LS_THRES_UP, 0xFF },
+	{ APDS9160_REG_LS_THRES_UP_MSB, 0x0F },
+	{ APDS9160_REG_LS_THRES_LO_LSB, 0x00 },
+	{ APDS9160_REG_LS_THRES_LO, 0x00 },
+	{ APDS9160_REG_LS_THRES_LO_MSB, 0x00 },
+	{ APDS9160_REG_LS_THRES_VAR, 0x00 },
+};
+
+static const struct regmap_range apds9160_readable_ranges[] = {
+	regmap_reg_range(APDS9160_REG_CTRL, APDS9160_REG_LS_THRES_VAR),
+};
+
+static const struct regmap_access_table apds9160_readable_table = {
+	.yes_ranges = apds9160_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(apds9160_readable_ranges),
+};
+
+static const struct regmap_range apds9160_writeable_ranges[] = {
+	regmap_reg_range(APDS9160_REG_CTRL, APDS9160_REG_LS_GAIN),
+	regmap_reg_range(APDS9160_REG_INT_CFG, APDS9160_REG_LS_THRES_VAR),
+};
+
+static const struct regmap_access_table apds9160_writeable_table = {
+	.yes_ranges = apds9160_writeable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(apds9160_writeable_ranges),
+};
+
+static const struct regmap_range apds9160_volatile_ranges[] = {
+	regmap_reg_range(APDS9160_REG_SR, APDS9160_REG_LS_DATA_ALS_MSB),
+};
+
+static const struct regmap_access_table apds9160_volatile_table = {
+	.yes_ranges = apds9160_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(apds9160_volatile_ranges),
+};
+
+static const struct regmap_config apds9160_regmap_config = {
+	.name = APDS9160_REGMAP_NAME,
+	.reg_bits = 8,
+	.val_bits = 8,
+	.use_single_read = true,
+	.use_single_write = true,
+
+	.rd_table = &apds9160_readable_table,
+	.wr_table = &apds9160_writeable_table,
+	.volatile_table = &apds9160_volatile_table,
+
+	.reg_defaults = apds9160_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(apds9160_reg_defaults),
+	.max_register = APDS9160_REG_CNT,
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static const struct iio_event_spec apds9160_event_spec[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
+static const struct iio_chan_spec apds9160_channels[] = {
+	{
+		/* Proximity sensor channel */
+		.type = IIO_PROXIMITY,
+		.address = APDS9160_REG_PS_DATA_LSB,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					    BIT(IIO_CHAN_INFO_CALIBSCALE) |
+					    BIT(IIO_CHAN_INFO_HARDWAREGAIN) |
+					    BIT(IIO_CHAN_INFO_CALIBBIAS),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+						BIT(IIO_CHAN_INFO_HARDWAREGAIN),
+		.event_spec = apds9160_event_spec,
+		.num_event_specs = ARRAY_SIZE(apds9160_event_spec),
+	},
+	{
+		/* Proximity sensor led current */
+		.type = IIO_CURRENT,
+		.output = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_CALIBBIAS),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_RAW),
+	},
+	{
+		/* Illuminance */
+		.type = IIO_LIGHT,
+		.address = APDS9160_REG_LS_DATA_ALS_LSB,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_INT_TIME) |
+					    BIT(IIO_CHAN_INFO_HARDWAREGAIN) |
+					    BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+						BIT(IIO_CHAN_INFO_SCALE),
+		.event_spec = apds9160_event_spec,
+		.num_event_specs = ARRAY_SIZE(apds9160_event_spec),
+	},
+	{
+		/* Clear channel */
+		.type = IIO_INTENSITY,
+		.address = APDS9160_REG_LS_DATA_CLEAR_LSB,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.channel2 = IIO_MOD_LIGHT_CLEAR,
+		.modified = 1,
+	},
+};
+
+/* Attributes */
+static const int apds9160_als_rate_avail[] = {
+	25, 50, 100, 200
+};
+
+static const int apds9160_als_rate_map[][2] = {
+	{ 25, 0x00 },
+	{ 50, 0x01 },
+	{ 100, 0x02 },
+	{ 200, 0x03 },
+};
+
+static const int apds9160_als_gain_avail[] = {
+	1, 3, 6, 18, 54
+};
+
+static const int apds9160_als_gain_map[][2] = {
+	{ 1, 0x00 },
+	{ 3, 0x01 },
+	{ 6, 0x02 },
+	{ 18, 0x03 },
+	{ 54, 0x04 },
+};
+
+static const int apds9160_ps_gain_avail[] = {
+	1, 2, 4, 8
+};
+
+static const int apds9160_ps_gain_map[][2] = {
+	{ 1, 0x00 },
+	{ 2, 0x01 },
+	{ 4, 0x02 },
+	{ 8, 0x03 },
+};
+
+static const int apds9160_ps_rate_avail[] = {
+	25, 50, 100, 200, 400
+};
+
+static const int apds9160_ps_rate_map[][2] = {
+	{ 25, 0x03 },
+	{ 50, 0x04 },
+	{ 100, 0x05 },
+	{ 200, 0x06 },
+	{ 400, 0x07 },
+};
+
+static const int apds9160_ps_led_current_avail[] = {
+	10, 25, 50, 100, 150, 175, 200
+};
+
+static const int apds9160_ps_led_current_map[][2] = {
+	{ 10, 0x00 },
+	{ 25, 0x01 },
+	{ 50, 0x02 },
+	{ 100, 0x03 },
+	{ 150, 0x04 },
+	{ 175, 0x05 },
+	{ 200, 0x06 },
+};
+
+/*
+ * @itime: Integration time in ms
+ * @gain: Gain multiplier
+ * @scale1: lux/count resolution
+ * @scale2: micro lux/count
+ */
+struct apds9160_scale {
+	int itime;
+	int gain;
+	int scale1;
+	int scale2;
+};
+
+/*
+ * Scale mapping extracted from datasheet
+ */
+static const struct apds9160_scale apds9160_als_scale_map[] = {
+	{
+		.itime = 25,
+		.gain = 1,
+		.scale1 = 3,
+		.scale2 = 272000,
+	},
+	{
+		.itime = 25,
+		.gain = 3,
+		.scale1 = 1,
+		.scale2 = 77000,
+	},
+	{
+		.itime = 25,
+		.gain = 6,
+		.scale1 = 0,
+		.scale2 = 525000,
+	},
+	{
+		.itime = 25,
+		.gain = 18,
+		.scale1 = 0,
+		.scale2 = 169000,
+	},
+	{
+		.itime = 25,
+		.gain = 54,
+		.scale1 = 0,
+		.scale2 = 49000,
+	},
+	{
+		.itime = 50,
+		.gain = 1,
+		.scale1 = 1,
+		.scale2 = 639000,
+	},
+	{
+		.itime = 50,
+		.gain = 3,
+		.scale1 = 0,
+		.scale2 = 538000,
+	},
+	{
+		.itime = 50,
+		.gain = 6,
+		.scale1 = 0,
+		.scale2 = 263000,
+	},
+	{
+		.itime = 50,
+		.gain = 18,
+		.scale1 = 0,
+		.scale2 = 84000,
+	},
+	{
+		.itime = 50,
+		.gain = 54,
+		.scale1 = 0,
+		.scale2 = 25000,
+	},
+	{
+		.itime = 100,
+		.gain = 1,
+		.scale1 = 0,
+		.scale2 = 819000,
+	},
+	{
+		.itime = 100,
+		.gain = 3,
+		.scale1 = 0,
+		.scale2 = 269000,
+	},
+	{
+		.itime = 100,
+		.gain = 6,
+		.scale1 = 0,
+		.scale2 = 131000,
+	},
+	{
+		.itime = 100,
+		.gain = 18,
+		.scale1 = 0,
+		.scale2 = 42000,
+	},
+	{
+		.itime = 100,
+		.gain = 54,
+		.scale1 = 0,
+		.scale2 = 12000,
+	},
+	{
+		.itime = 200,
+		.gain = 1,
+		.scale1 = 0,
+		.scale2 = 409000,
+	},
+	{
+		.itime = 200,
+		.gain = 3,
+		.scale1 = 0,
+		.scale2 = 135000,
+	},
+	{
+		.itime = 200,
+		.gain = 6,
+		.scale1 = 0,
+		.scale2 = 66000,
+	},
+	{
+		.itime = 200,
+		.gain = 18,
+		.scale1 = 0,
+		.scale2 = 21000,
+	},
+	{
+		.itime = 200,
+		.gain = 54,
+		.scale1 = 0,
+		.scale2 = 6000,
+	},
+};
+
+static const int apds9160_25ms_avail[][2] = {
+	{ 3, 272000 },
+	{ 1, 77000 },
+	{ 0, 525000 },
+	{ 0, 169000 },
+	{ 0, 49000 },
+};
+
+static const int apds9160_50ms_avail[][2] = {
+	{ 1, 639000 },
+	{ 0, 538000 },
+	{ 0, 263000 },
+	{ 0, 84000 },
+	{ 0, 25000 },
+};
+
+static const int apds9160_100ms_avail[][2] = {
+	{ 0, 819000 },
+	{ 0, 269000 },
+	{ 0, 131000 },
+	{ 0, 42000 },
+	{ 0, 12000 },
+};
+
+static const int apds9160_200ms_avail[][2] = {
+	{ 0, 409000 },
+	{ 0, 135000 },
+	{ 0, 66000 },
+	{ 0, 21000 },
+	{ 0, 6000 },
+};
+
+static const struct reg_field apds9160_reg_field_ls_en =
+	REG_FIELD(APDS9160_REG_CTRL, 1, 1);
+
+static const struct reg_field apds9160_reg_field_ps_en =
+	REG_FIELD(APDS9160_REG_CTRL, 0, 0);
+
+static const struct reg_field apds9160_reg_field_int_ps =
+	REG_FIELD(APDS9160_REG_INT_CFG, 0, 0);
+
+static const struct reg_field apds9160_reg_field_int_als =
+	REG_FIELD(APDS9160_REG_INT_CFG, 2, 2);
+
+static const struct reg_field apds9160_reg_field_ps_overflow =
+	REG_FIELD(APDS9160_REG_PS_DATA_MSB, 3, 3);
+
+static const struct reg_field apds9160_reg_field_als_rate =
+	REG_FIELD(APDS9160_REG_LS_MEAS_RATE, 0, 2);
+
+static const struct reg_field apds9160_reg_field_als_gain =
+	REG_FIELD(APDS9160_REG_LS_GAIN, 0, 2);
+
+static const struct reg_field apds9160_reg_field_ps_rate =
+	REG_FIELD(APDS9160_REG_PS_MEAS_RATE, 0, 2);
+
+static const struct reg_field apds9160_reg_field_als_res =
+	REG_FIELD(APDS9160_REG_LS_MEAS_RATE, 4, 6);
+
+static const struct reg_field apds9160_reg_field_ps_current =
+	REG_FIELD(APDS9160_REG_PS_LED, 0, 2);
+
+static const struct reg_field apds9160_reg_field_ps_gain =
+	REG_FIELD(APDS9160_REG_PS_MEAS_RATE, 6, 7);
+
+static const struct reg_field apds9160_reg_field_ps_resolution =
+	REG_FIELD(APDS9160_REG_PS_MEAS_RATE, 3, 4);
+
+struct apds9160_chip {
+	struct i2c_client *client;
+	struct regmap *regmap;
+
+	struct regmap_field *reg_enable_ps;
+	struct regmap_field *reg_enable_als;
+	struct regmap_field *reg_int_ps;
+	struct regmap_field *reg_int_als;
+	struct regmap_field *reg_ps_overflow;
+	struct regmap_field *reg_als_rate;
+	struct regmap_field *reg_als_resolution;
+	struct regmap_field *reg_ps_rate;
+	struct regmap_field *reg_als_gain;
+	struct regmap_field *reg_ps_current;
+	struct regmap_field *reg_ps_gain;
+	struct regmap_field *reg_ps_resolution;
+
+	struct mutex lock; /* protects state and config data */
+
+	/* State data */
+	int als_int;
+	int ps_int;
+
+	/* Configuration values */
+	int als_itime;
+	int als_hwgain;
+	int als_scale1;
+	int als_scale2;
+	int ps_rate;
+	int ps_cancellation_level;
+	int ps_cancellation_analog;
+	int ps_cancellation_current;
+	int ps_current;
+	int ps_gain;
+};
+
+static int apds9160_set_ps_rate(struct apds9160_chip *data, int val)
+{
+	int ret = -EINVAL;
+	int idx;
+
+	for (idx = 0; idx < ARRAY_SIZE(apds9160_ps_rate_map); idx++) {
+		if (apds9160_ps_rate_map[idx][0] == val) {
+			ret = regmap_field_write(data->reg_ps_rate,
+						 apds9160_ps_rate_map[idx][1]);
+			if (ret)
+				return ret;
+
+			data->ps_rate = val;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int apds9160_set_ps_gain(struct apds9160_chip *data, int val)
+{
+	int ret = -EINVAL;
+	int idx;
+
+	for (idx = 0; idx < ARRAY_SIZE(apds9160_ps_gain_map); idx++) {
+		if (apds9160_ps_gain_map[idx][0] == val) {
+			ret = regmap_field_write(data->reg_ps_gain,
+						 apds9160_ps_gain_map[idx][1]);
+			if (ret)
+				return ret;
+
+			data->ps_gain = val;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+/*
+ * The PS intelligent cancellation level register allows
+ *	for an on-chip substraction of the ADC count caused by
+ * unwanted reflected light from PS ADC output.
+ */
+static int apds9160_set_ps_cancellation_level(struct apds9160_chip *data,
+					      int val)
+{
+	int ret;
+	__le16 buf;
+
+	if (val < 0 || val > 0xFFFF)
+		return -EINVAL;
+
+	buf = cpu_to_le16(val);
+	ret = regmap_bulk_write(data->regmap, APDS9160_REG_PS_CAN_LEVEL_DIG_LSB,
+				&buf, 2);
+	if (!ret)
+		data->ps_cancellation_level = val;
+
+	return ret;
+}
+
+/*
+ * This parameter determines the cancellation pulse duration
+ * in each of the PWM pulse. The cancellation is applied during the
+ * integration phase of the PS measurement.
+ * Duration is programmed in half clock cycles
+ * A duration value of 0 or 1 will not generate any cancellation pulse
+ */
+static int apds9160_set_ps_analog_cancellation(struct apds9160_chip *data,
+					       int val)
+{
+	int ret;
+
+	if (val < 0 || val > 0x7F)
+		return -EINVAL;
+
+	ret = regmap_write(data->regmap, APDS9160_REG_PS_CAN_LEVEL_ANA_DUR,
+			   val);
+	if (!ret)
+		data->ps_cancellation_analog = val;
+
+	return ret;
+}
+
+/*
+ * This parameter works in conjunction with the cancellation pulse duration
+ * The value determines the current used for crosstalk cancellation
+ * B4-B5: The coarse value defines cancellation current in steps of 60nA
+ * B0-B3: The fine value adjusts the cancellation current in steps of 2.4nA
+ */
+static int apds9160_set_ps_cancellation_current(struct apds9160_chip *data,
+						int val)
+{
+	int ret;
+
+	if (val < 0 || val > 0x3F)
+		return -EINVAL;
+
+	ret = regmap_write(data->regmap, APDS9160_REG_PS_CAN_LEVEL_ANA_CURRENT,
+			   val);
+	if (!ret)
+		data->ps_cancellation_current = val;
+
+	return ret;
+}
+
+static int apds9160_set_ps_current(struct apds9160_chip *data, int val)
+{
+	int ret = -EINVAL;
+	int idx;
+
+	for (idx = 0; idx < ARRAY_SIZE(apds9160_ps_led_current_map); idx++) {
+		if (apds9160_ps_led_current_map[idx][0] == val) {
+			ret = regmap_field_write(
+				data->reg_ps_current,
+				apds9160_ps_led_current_map[idx][1]);
+
+			if (ret)
+				return ret;
+
+			data->ps_current = val;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int apds9160_set_als_gain(struct apds9160_chip *data, int gain)
+{
+	int ret = -EINVAL;
+	int idx;
+
+	for (idx = 0; idx < ARRAY_SIZE(apds9160_als_gain_map); idx++) {
+		if (gain == apds9160_als_gain_map[idx][0]) {
+			ret = regmap_field_write(data->reg_als_gain,
+					apds9160_als_gain_map[idx][1]);
+			if (ret)
+				return ret;
+
+			data->als_hwgain = gain;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int apds9160_set_als_scale(struct apds9160_chip *data, int val, int val2)
+{
+	int ret = -EINVAL;
+	int idx;
+
+	for (idx = 0; idx < ARRAY_SIZE(apds9160_als_scale_map); idx++) {
+		if (apds9160_als_scale_map[idx].itime == data->als_itime &&
+		    apds9160_als_scale_map[idx].scale1 == val &&
+		    apds9160_als_scale_map[idx].scale2 == val2) {
+			ret = apds9160_set_als_gain(data,
+					apds9160_als_scale_map[idx].gain);
+			if (ret)
+				return ret;
+
+			data->als_scale1 = val;
+			data->als_scale2 = val2;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int apds9160_set_als_resolution(struct apds9160_chip *data, int val)
+{
+	switch (val) {
+	case 25:
+		return regmap_field_write(data->reg_als_resolution,
+			APDS9160_CMD_LS_RESOLUTION_25MS);
+	case 50:
+		return regmap_field_write(data->reg_als_resolution,
+			APDS9160_CMD_LS_RESOLUTION_50MS);
+	case 200:
+		return regmap_field_write(data->reg_als_resolution,
+			APDS9160_CMD_LS_RESOLUTION_200MS);
+	default:
+		return regmap_field_write(data->reg_als_resolution,
+			APDS9160_CMD_LS_RESOLUTION_100MS);
+	}
+}
+
+static int apds9160_set_als_rate(struct apds9160_chip *data, int val)
+{
+	int idx;
+
+	for (idx = 0; idx < ARRAY_SIZE(apds9160_als_rate_map); idx++) {
+		if (apds9160_als_rate_map[idx][0] == val) {
+			return regmap_field_write(data->reg_als_rate,
+					apds9160_als_rate_map[idx][1]);
+		}
+	}
+
+	return -EINVAL;
+}
+
+/*
+ *	Setting the integration time ajusts resolution, rate, scale and gain
+ */
+static int apds9160_set_als_int_time(struct apds9160_chip *data, int val)
+{
+	int ret = -EINVAL;
+	int idx;
+
+	ret = apds9160_set_als_rate(data, val);
+	if (ret)
+		return ret;
+
+	/* Match resolution register with rate */
+	ret = apds9160_set_als_resolution(data, val);
+	if (ret)
+		return ret;
+
+	data->als_itime = val;
+
+	/* Set the scale minimum gain */
+	for (idx = 0; idx < ARRAY_SIZE(apds9160_als_scale_map); idx++) {
+		if (data->als_itime == apds9160_als_scale_map[idx].itime) {
+			ret = apds9160_set_als_scale(data,
+					apds9160_als_scale_map[idx].scale1,
+					apds9160_als_scale_map[idx].scale2);
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int apds9160_read_avail(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       const int **vals, int *type, int *length,
+			       long mask)
+{
+	struct apds9160_chip *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		switch (chan->type) {
+		case IIO_LIGHT:
+			*length = ARRAY_SIZE(apds9160_als_rate_avail);
+			*vals = (const int *)apds9160_als_rate_avail;
+			*type = IIO_VAL_INT;
+			return IIO_AVAIL_LIST;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_LIGHT:
+			/* The available scales changes depending on itime */
+			switch (data->als_itime) {
+			case 25:
+				*length = ARRAY_SIZE(apds9160_25ms_avail) * 2;
+				*vals = (const int *) apds9160_25ms_avail;
+				*type = IIO_VAL_INT_PLUS_MICRO;
+				return IIO_AVAIL_LIST;
+			case 50:
+				*length = ARRAY_SIZE(apds9160_50ms_avail) * 2;
+				*vals = (const int *) apds9160_50ms_avail;
+				*type = IIO_VAL_INT_PLUS_MICRO;
+				return IIO_AVAIL_LIST;
+			case 100:
+				*length = ARRAY_SIZE(apds9160_100ms_avail) * 2;
+				*vals = (const int *) apds9160_100ms_avail;
+				*type = IIO_VAL_INT_PLUS_MICRO;
+				return IIO_AVAIL_LIST;
+			case 200:
+				*length = ARRAY_SIZE(apds9160_200ms_avail) * 2;
+				*vals = (const int *) apds9160_200ms_avail;
+				*type = IIO_VAL_INT_PLUS_MICRO;
+				return IIO_AVAIL_LIST;
+			default:
+				return -EINVAL;
+			}
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		switch (chan->type) {
+		case IIO_PROXIMITY:
+			*length = ARRAY_SIZE(apds9160_ps_rate_avail);
+			*vals = (const int *)apds9160_ps_rate_avail;
+			*type = IIO_VAL_INT;
+			return IIO_AVAIL_LIST;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		switch (chan->type) {
+		case IIO_PROXIMITY:
+			*length = ARRAY_SIZE(apds9160_ps_gain_avail);
+			*vals = (const int *)apds9160_ps_gain_avail;
+			*type = IIO_VAL_INT;
+			return IIO_AVAIL_LIST;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_CURRENT:
+			*length = ARRAY_SIZE(apds9160_ps_led_current_avail);
+			*vals = (const int *)apds9160_ps_led_current_avail;
+			*type = IIO_VAL_INT;
+			return IIO_AVAIL_LIST;
+		default:
+			return -EINVAL;
+		}
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int apds9160_write_raw_get_fmt(struct iio_dev *indio_dev,
+				      struct iio_chan_spec const *chan,
+				      long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_RAW:
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int apds9160_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int *val,
+			     int *val2, long mask)
+{
+	struct apds9160_chip *data = iio_priv(indio_dev);
+	int ret = -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_PROXIMITY: {
+			__le16 buf;
+
+			ret = regmap_bulk_read(data->regmap, chan->address,
+					       &buf, 2);
+			if (ret)
+				return ret;
+
+			ret = IIO_VAL_INT;
+			*val = le16_to_cpu(buf);
+			/* Remove overflow bits from result */
+			*val = FIELD_GET(APDS9160_PS_DATA_MASK, *val);
+		} break;
+		case IIO_LIGHT:
+		case IIO_INTENSITY: {
+			u8 buf[3];
+
+			ret = regmap_bulk_read(data->regmap, chan->address,
+					       &buf, 3);
+			if (ret)
+				return ret;
+
+			ret = IIO_VAL_INT;
+			*val = get_unaligned_le24(buf);
+		} break;
+		case IIO_CURRENT:
+			ret = IIO_VAL_INT;
+			*val = data->ps_current;
+			break;
+		default:
+			break;
+		}
+		break;
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		switch (chan->type) {
+		case IIO_LIGHT:
+			ret = IIO_VAL_INT;
+			*val = data->als_hwgain;
+			break;
+		case IIO_PROXIMITY:
+			ret = IIO_VAL_INT;
+			*val = data->ps_gain;
+			break;
+		default:
+			break;
+		}
+		break;
+	case IIO_CHAN_INFO_INT_TIME:
+		switch (chan->type) {
+		case IIO_LIGHT:
+			ret = IIO_VAL_INT;
+			*val = data->als_itime;
+			break;
+		default:
+			break;
+		}
+		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		switch (chan->type) {
+		case IIO_PROXIMITY:
+			ret = IIO_VAL_INT;
+			*val = data->ps_rate;
+			break;
+		default:
+			break;
+		}
+		break;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		switch (chan->type) {
+		case IIO_PROXIMITY:
+			ret = IIO_VAL_INT;
+			*val = data->ps_cancellation_level;
+			break;
+		default:
+			break;
+		}
+		break;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		switch (chan->type) {
+		case IIO_PROXIMITY:
+			ret = IIO_VAL_INT;
+			*val = data->ps_cancellation_analog;
+			break;
+		case IIO_CURRENT:
+			ret = IIO_VAL_INT;
+			*val = data->ps_cancellation_current;
+		default:
+			break;
+		}
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_LIGHT:
+			ret = IIO_VAL_INT_PLUS_MICRO;
+			*val = data->als_scale1;
+			*val2 = data->als_scale2;
+			break;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+};
+
+static int apds9160_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan, int val,
+			      int val2, long mask)
+{
+	struct apds9160_chip *data = iio_priv(indio_dev);
+
+	guard(mutex)(&data->lock);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_INT_TIME:
+		if (val2 != 0)
+			return -EINVAL;
+		switch (chan->type) {
+		case IIO_LIGHT:
+			return apds9160_set_als_int_time(data, val);
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_LIGHT:
+			return apds9160_set_als_scale(data, val, val2);
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val2 != 0)
+			return -EINVAL;
+		switch (chan->type) {
+		case IIO_PROXIMITY:
+			return apds9160_set_ps_rate(data, val);
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_HARDWAREGAIN:
+		if (val2 != 0)
+			return -EINVAL;
+		switch (chan->type) {
+		case IIO_PROXIMITY:
+			return apds9160_set_ps_gain(data, val);
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_CALIBSCALE:
+		if (val2 != 0)
+			return -EINVAL;
+		switch (chan->type) {
+		case IIO_PROXIMITY:
+			return apds9160_set_ps_cancellation_level(data, val);
+		case IIO_CURRENT:
+			return apds9160_set_ps_cancellation_current(data, val);
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_CALIBBIAS:
+		if (val2 != 0)
+			return -EINVAL;
+		switch (chan->type) {
+		case IIO_PROXIMITY:
+			return apds9160_set_ps_analog_cancellation(data, val);
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_RAW:
+		if (val2 != 0)
+			return -EINVAL;
+		switch (chan->type) {
+		case IIO_CURRENT:
+			return apds9160_set_ps_current(data, val);
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static inline int apds9160_get_thres_reg(const struct iio_chan_spec *chan,
+					 enum iio_event_direction dir, u8 *reg)
+{
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		switch (chan->type) {
+		case IIO_PROXIMITY:
+			*reg = APDS9160_REG_PS_THRES_HI_LSB;
+			break;
+		case IIO_LIGHT:
+			*reg = APDS9160_REG_LS_THRES_UP_LSB;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	case IIO_EV_DIR_FALLING:
+		switch (chan->type) {
+		case IIO_PROXIMITY:
+			*reg = APDS9160_REG_PS_THRES_LO_LSB;
+			break;
+		case IIO_LIGHT:
+			*reg = APDS9160_REG_LS_THRES_LO_LSB;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int apds9160_read_event(struct iio_dev *indio_dev,
+			       const struct iio_chan_spec *chan,
+			       enum iio_event_type type,
+			       enum iio_event_direction dir,
+			       enum iio_event_info info, int *val, int *val2)
+{
+	u8 reg;
+
+	int ret = 0;
+	struct apds9160_chip *data = iio_priv(indio_dev);
+
+	if (info != IIO_EV_INFO_VALUE)
+		return -EINVAL;
+
+	ret = apds9160_get_thres_reg(chan, dir, &reg);
+	if (ret < 0)
+		return ret;
+
+	switch (chan->type) {
+	case IIO_PROXIMITY: {
+		__le16 buf;
+
+		ret = regmap_bulk_read(data->regmap, reg, &buf, 2);
+		if (ret < 0)
+			return ret;
+		*val = le16_to_cpu(buf);
+		return IIO_VAL_INT;
+	} break;
+	case IIO_LIGHT: {
+		u8 buf[3];
+
+		ret = regmap_bulk_read(data->regmap, reg, &buf, 3);
+		if (ret < 0)
+			return ret;
+		*val = get_unaligned_le24(buf);
+		return IIO_VAL_INT;
+	} break;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int apds9160_write_event(struct iio_dev *indio_dev,
+				const struct iio_chan_spec *chan,
+				enum iio_event_type type,
+				enum iio_event_direction dir,
+				enum iio_event_info info, int val, int val2)
+{
+	u8 reg;
+	int ret = 0;
+	struct apds9160_chip *data = iio_priv(indio_dev);
+
+	if (info != IIO_EV_INFO_VALUE)
+		return -EINVAL;
+
+	ret = apds9160_get_thres_reg(chan, dir, &reg);
+	if (ret < 0)
+		return ret;
+
+	switch (chan->type) {
+	case IIO_PROXIMITY: {
+		if (val < 0 || val > APDS9160_PS_THRES_MAX)
+			return -EINVAL;
+		__le16 buf;
+
+		buf = cpu_to_le16(val);
+		return regmap_bulk_write(data->regmap, reg, &buf, 2);
+	}
+	case IIO_LIGHT: {
+		if (val < 0 || val > APDS9160_LS_THRES_MAX)
+			return -EINVAL;
+		__le32 buf = 0;
+
+		buf = cpu_to_le32(val);
+		return regmap_bulk_write(data->regmap, reg, &buf, 3);
+	}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int apds9160_read_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir)
+{
+	struct apds9160_chip *data = iio_priv(indio_dev);
+
+	switch (chan->type) {
+	case IIO_PROXIMITY:
+		return data->ps_int;
+	case IIO_LIGHT:
+		return data->als_int;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int apds9160_write_event_config(struct iio_dev *indio_dev,
+				       const struct iio_chan_spec *chan,
+				       enum iio_event_type type,
+				       enum iio_event_direction dir, bool state)
+{
+	struct apds9160_chip *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (chan->type) {
+	case IIO_PROXIMITY:
+		ret = regmap_field_write(data->reg_int_ps, state);
+		if (ret)
+			return ret;
+		data->ps_int = state;
+		break;
+	case IIO_LIGHT:
+		ret = regmap_field_write(data->reg_int_als, state);
+		if (ret)
+			return ret;
+		data->als_int = state;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static irqreturn_t apds9160_irq_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct apds9160_chip *data = iio_priv(indio_dev);
+	int ret, status;
+
+	/* Reading status register clears the interrupt flag */
+	ret = regmap_read(data->regmap, APDS9160_REG_SR, &status);
+	if (ret < 0) {
+		dev_err_ratelimited(&data->client->dev,
+				    "irq status reg read failed\n");
+		return IRQ_HANDLED;
+	}
+
+	if ((status & APDS9160_SR_LS_INT) &&
+	    (status & APDS9160_SR_LS_NEW_DATA) && data->als_int) {
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_LIGHT, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_EITHER),
+			       iio_get_time_ns(indio_dev));
+	}
+
+	if ((status & APDS9160_SR_PS_INT) &&
+	    (status & APDS9160_SR_PS_NEW_DATA) && data->ps_int) {
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_EITHER),
+			       iio_get_time_ns(indio_dev));
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int apds9160_detect(struct apds9160_chip *chip)
+{
+	struct i2c_client *client = chip->client;
+	int ret;
+	u32 val;
+
+	ret = regmap_read(chip->regmap, APDS9160_REG_ID, &val);
+	if (ret < 0) {
+		dev_err(&client->dev, "ID read failed\n");
+		return ret;
+	}
+
+	if (val != APDS9160_PART_ID_0)
+		dev_info(&client->dev, "Unsupported part id %u\n", val);
+
+	return ret;
+}
+
+static void apds9160_disable(void *chip)
+{
+	struct apds9160_chip *data = (struct apds9160_chip *)chip;
+	int ret;
+
+	ret = regmap_field_write(data->reg_enable_als, 0);
+	if (ret)
+		return;
+
+	regmap_field_write(data->reg_enable_ps, 0);
+}
+
+static int apds9160_chip_init(struct apds9160_chip *chip)
+{
+	int ret;
+
+	/* Write default values to interrupt register */
+	ret = regmap_field_write(chip->reg_int_ps, 0);
+	chip->ps_int = 0;
+	if (ret)
+		return ret;
+
+	ret = regmap_field_write(chip->reg_int_als, 0);
+	chip->als_int = 0;
+	if (ret)
+		return ret;
+
+	/* Write default values to control register */
+	ret = regmap_field_write(chip->reg_enable_als, 1);
+	if (ret)
+		return ret;
+
+	ret = regmap_field_write(chip->reg_enable_ps, 1);
+	if (ret)
+		return ret;
+
+	/* Write other default values */
+	ret = regmap_field_write(chip->reg_ps_resolution,
+				 APDS9160_DEFAULT_PS_RESOLUTION_11BITS);
+	if (ret)
+		return ret;
+
+	/* Write default values to configuration registers */
+	ret = apds9160_set_ps_current(chip, APDS9160_DEFAULT_PS_CURRENT);
+	if (ret)
+		return ret;
+
+	apds9160_set_ps_rate(chip, APDS9160_DEFAULT_PS_RATE);
+	if (ret)
+		return ret;
+
+	apds9160_set_als_int_time(chip, APDS9160_DEFAULT_LS_RATE);
+	if (ret)
+		return ret;
+
+	ret = apds9160_set_als_scale(chip,
+				     apds9160_100ms_avail[0][0],
+				     apds9160_100ms_avail[0][1]);
+	if (ret)
+		return ret;
+
+	ret = apds9160_set_ps_gain(chip, APDS9160_DEFAULT_PS_GAIN);
+	if (ret)
+		return ret;
+
+	ret = apds9160_set_ps_analog_cancellation(
+		chip, APDS9160_DEFAULT_PS_ANALOG_CANCELLATION);
+	if (ret)
+		return ret;
+
+	ret = apds9160_set_ps_cancellation_level(
+		chip, APDS9160_DEFAULT_PS_CANCELLATION_LEVEL);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(&chip->client->dev, apds9160_disable,
+					(void *)chip);
+}
+
+static int apds9160_regfield_init(struct apds9160_chip *data)
+{
+	struct device *dev = &data->client->dev;
+	struct regmap *regmap = data->regmap;
+	struct regmap_field *tmp;
+
+	tmp = devm_regmap_field_alloc(dev, regmap, apds9160_reg_field_int_als);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+	data->reg_int_als = tmp;
+
+	tmp = devm_regmap_field_alloc(dev, regmap, apds9160_reg_field_int_ps);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+	data->reg_int_ps = tmp;
+
+	tmp = devm_regmap_field_alloc(dev, regmap, apds9160_reg_field_ls_en);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+	data->reg_enable_als = tmp;
+
+	tmp = devm_regmap_field_alloc(dev, regmap, apds9160_reg_field_ps_en);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+	data->reg_enable_ps = tmp;
+
+	tmp = devm_regmap_field_alloc(dev, regmap,
+				      apds9160_reg_field_ps_overflow);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+	data->reg_ps_overflow = tmp;
+
+	tmp = devm_regmap_field_alloc(dev, regmap, apds9160_reg_field_als_rate);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+	data->reg_als_rate = tmp;
+
+	tmp = devm_regmap_field_alloc(dev, regmap, apds9160_reg_field_als_res);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+	data->reg_als_resolution = tmp;
+
+	tmp = devm_regmap_field_alloc(dev, regmap, apds9160_reg_field_ps_rate);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+	data->reg_ps_rate = tmp;
+
+	tmp = devm_regmap_field_alloc(dev, regmap, apds9160_reg_field_als_gain);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+	data->reg_als_gain = tmp;
+
+	tmp = devm_regmap_field_alloc(dev, regmap,
+				      apds9160_reg_field_ps_current);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+	data->reg_ps_current = tmp;
+
+	tmp = devm_regmap_field_alloc(dev, regmap, apds9160_reg_field_ps_gain);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+	data->reg_ps_gain = tmp;
+
+	tmp = devm_regmap_field_alloc(dev, regmap,
+				      apds9160_reg_field_ps_resolution);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+	data->reg_ps_resolution = tmp;
+
+	return 0;
+}
+
+static const struct iio_info apds9160_info = {
+	.read_avail = apds9160_read_avail,
+	.read_raw = apds9160_read_raw,
+	.write_raw = apds9160_write_raw,
+	.write_raw_get_fmt = apds9160_write_raw_get_fmt,
+	.read_event_value = apds9160_read_event,
+	.write_event_value = apds9160_write_event,
+	.read_event_config = apds9160_read_event_config,
+	.write_event_config = apds9160_write_event_config,
+};
+
+static int apds9160_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct apds9160_chip *chip;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable vdd supply\n");
+
+	indio_dev->info = &apds9160_info;
+	indio_dev->name = "apds9160";
+	indio_dev->channels = apds9160_channels;
+	indio_dev->num_channels = ARRAY_SIZE(apds9160_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	chip = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	chip->client = client;
+	chip->regmap = devm_regmap_init_i2c(client, &apds9160_regmap_config);
+	if (IS_ERR(chip->regmap))
+		return dev_err_probe(dev, PTR_ERR(chip->regmap),
+				     "regmap initialization failed.\n");
+
+	chip->client = client;
+	mutex_init(&chip->lock);
+
+	ret = apds9160_detect(chip);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "apds9160 not found\n");
+
+	ret = apds9160_regfield_init(chip);
+	if (ret)
+		return ret;
+
+	ret = apds9160_chip_init(chip);
+	if (ret)
+		return ret;
+
+	if (client->irq > 0) {
+		ret = devm_request_threaded_irq(dev, client->irq, NULL,
+						apds9160_irq_handler,
+						IRQF_ONESHOT, "apds9160_event",
+						indio_dev);
+		if (ret) {
+			return dev_err_probe(dev, ret,
+					     "request irq (%d) failed\n",
+					     client->irq);
+		}
+	}
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed iio device registration\n");
+
+	return ret;
+}
+
+static const struct of_device_id apds9160_of_match[] = {
+	{ .compatible = "brcm,apds9160" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, apds9160_of_match);
+
+static const struct i2c_device_id apds9160_id[] = { { "apds9160", 0 }, { } };
+MODULE_DEVICE_TABLE(i2c, apds9160_id);
+
+static struct i2c_driver apds9160_driver = {
+	.driver	  = {
+		.name	= "apds9160",
+		.of_match_table = apds9160_of_match,
+	},
+	.probe    = apds9160_probe,
+	.id_table = apds9160_id,
+};
+module_i2c_driver(apds9160_driver);
+
+MODULE_DESCRIPTION("APDS9160 combined ALS and proximity sensor");
+MODULE_AUTHOR("Mikael Gonella-Bolduc <m.gonella.bolduc@gmail.com>");
+MODULE_LICENSE("GPL");

-- 
2.34.1



