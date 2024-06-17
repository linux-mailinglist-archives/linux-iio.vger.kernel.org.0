Return-Path: <linux-iio+bounces-6420-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC2A90BB8A
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 21:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C913B283CC4
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 19:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6291991AF;
	Mon, 17 Jun 2024 19:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="K17GCsYD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF8018FC67
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 19:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718654230; cv=none; b=aqG3nQwbhzZE6azKYj4CRxQyVoG+uxvX+3y2weiwDBgqD9c/IW5tmpqEzr1zc17sRVScUev6lwtnSOKX3S7sWm1eZ7stHX9bu+MJzslCpqhhmtatuOfqudFo6RzmYrl5cARjS2lgo4TrkSDEoj0IBLeqLQof6xMcGWS7meVshNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718654230; c=relaxed/simple;
	bh=foVAOaie8g7PFk9kJ4ya8WOTI3PmGLsD+uH8iBbKD0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lw/WsZnXK1z2WCN74zTBa7lyHsR2ZpG+3BGl4DFDB9THqUv8QRudnLVNydQw9/h7O3smLL9kAxdqA5WE2arfijTTfQcrVYksKTb3ZUh1T5QS9NCBN/VRivVwzsP2A35oEYwp+t0+11bkdfcVhyfFo01t05P1YeZkMzcQbjdDU1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=K17GCsYD; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d229baccc4so2313070b6e.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 12:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718654226; x=1719259026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djROvdc4m+1Uxp4kTKkbaQUDKu8G/VzCwjbfwrCIbGI=;
        b=K17GCsYDmdVxBkN6IP0bXwNasZywBgvDTVEAGvkWjoJa8jmOkFr0H7NkIwlwIsf2pP
         Tj2lbdn10088FE+vs8lZU8TSXSi2LyJzLKc5haPDwjS987q4dYGFVvjfcgT2V4P55Koq
         7H6HLazkw+7gQy/0beuF2L2836QTMlgvazG02E54ps5o2WKxdKawxsml/TIA0QFQOTc6
         LL94FlF+xwb3rJi0L+7yGe0sV94o1SE5JEx+CDcRqwZvTbUnj8/A7pQjbaR0FMt84on9
         PgSJz0CkJNr4Wixcrb+osi/PpPsfnhRjOjWmibPD8FtcgleWo7GNDr0G49SUpxPrkmU8
         iaeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718654226; x=1719259026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djROvdc4m+1Uxp4kTKkbaQUDKu8G/VzCwjbfwrCIbGI=;
        b=Az071HEEXBtfzIlic5cbQi7kPocuCcVJzgEYYcuU8haWImeZ9TwwDLMpfr5qrg9t09
         lEpFVf6sO7Ff+s7oVERIulT35w/qr8Cf+fplyMvBD5ioP2h7YPPQeEDl1C6XrK7tTnf3
         26M2BRlOAOuynI5vUHslU9brBW0EhYEEt1XpEyzsXGZyT/eArPdXDFr44FrKtdMkIf4O
         P/uuWO41gMIMEAm5odSM5LzhljDrtJOAdXKs6WIw3E5TbkJVmnWED3icILTNhNXhSzjx
         FkBZaD0HnSUfS+x0pbB0+eDbvou7GZr24PMBczEyJTT7SGdvdE1anoPLd7OW+KZ7avmm
         L5hA==
X-Forwarded-Encrypted: i=1; AJvYcCV0zpEZc6bZcDCdJp6+snbGXczg4fksyrAIpOCE0QLzg4TEbMzQKdqxONFPFQzOnMxaY5wU3VA8Mixxb+71nITxufgtTM0fGqX5
X-Gm-Message-State: AOJu0YwkRci0Uh+uYmGqg2Fg2nubIgsACPA1H2VC30s6xleHxfOeq875
	F7NfaeTce8GFsfWtgpsyGwmpHrF4/uNScf/S07tzllPeBE18ko31ctzTLSmZxTQ=
X-Google-Smtp-Source: AGHT+IHvqCExQiJpniETLBi/a8l6+wY4KqOKGgqMLwepVmk4gvSAH7n2HDbKxg2NuRS1BzGNX2ZnnA==
X-Received: by 2002:a05:6808:1687:b0:3d2:1523:8d85 with SMTP id 5614622812f47-3d24ea0cb34mr12020121b6e.59.1718654225781;
        Mon, 17 Jun 2024 12:57:05 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d2476e2fa4sm1579492b6e.52.2024.06.17.12.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 12:57:05 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Ramona Gradinariu <ramona.gradinariu@analog.com>
Subject: [PATCH v2 3/4] iio: adc: ad4695: Add driver for AD4695 and similar ADCs
Date: Mon, 17 Jun 2024 14:53:14 -0500
Message-ID: <20240617-iio-adc-ad4695-v2-3-63ef6583f25d@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240617-iio-adc-ad4695-v2-0-63ef6583f25d@baylibre.com>
References: <20240617-iio-adc-ad4695-v2-0-63ef6583f25d@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This is a new driver for Analog Devices Inc. AD4695 and similar ADCs.
The initial driver supports initializing the chip including configuring
all possible LDO and reference voltage sources as well as any possible
voltage input channel wiring configuration.

Only the 4-wire SPI wiring mode where the CNV pin is tied to the CS pin
is supported at this time. And reading sample data from the ADC can only
be done in direct mode for now.

Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v2 changes:
* rework register definition macros
* remove code structure comments at top level
* remove simple wrapper functions around regmap functions
* rework channel fwnode parsing for DT changes
* fix missing return value check
---
 MAINTAINERS              |   1 +
 drivers/iio/adc/Kconfig  |  11 +
 drivers/iio/adc/Makefile |   1 +
 drivers/iio/adc/ad4695.c | 753 +++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 766 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 19d4bc962c77..e7a338a3eaaa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1217,6 +1217,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
+F:	drivers/iio/adc/ad4695.c
 F:	include/dt-bindings/iio/adi,ad4695.h
 
 ANALOG DEVICES INC AD7091R DRIVER
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 3d91015af6ea..26c3090ff967 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -36,6 +36,17 @@ config AD4130
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad4130.
 
+config AD4695
+	tristate "Analog Device AD4695 ADC Driver"
+	depends on SPI
+	select REGMAP_SPI
+	help
+	  Say yes here to build support for Analog Devices AD4695 and similar
+	  analog to digital converters (ADC).
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad4695.
+
 config AD7091R
 	tristate
 
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 37ac689a0209..5c4d79d4f939 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -7,6 +7,7 @@
 obj-$(CONFIG_AB8500_GPADC) += ab8500-gpadc.o
 obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
 obj-$(CONFIG_AD4130) += ad4130.o
+obj-$(CONFIG_AD4695) += ad4695.o
 obj-$(CONFIG_AD7091R) += ad7091r-base.o
 obj-$(CONFIG_AD7091R5) += ad7091r5.o
 obj-$(CONFIG_AD7091R8) += ad7091r8.o
diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
new file mode 100644
index 000000000000..dbe6175b780d
--- /dev/null
+++ b/drivers/iio/adc/ad4695.c
@@ -0,0 +1,753 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * SPI ADC driver for Analog Devices Inc. AD4695 and similar chips
+ *
+ * https://www.analog.com/en/products/ad4695.html
+ * https://www.analog.com/en/products/ad4696.html
+ * https://www.analog.com/en/products/ad4697.html
+ * https://www.analog.com/en/products/ad4698.html
+ *
+ * Copyright 2024 Analog Devices Inc.
+ * Copyright 2024 BayLibre, SAS
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/compiler.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/units.h>
+
+/* AD4695 registers */
+#define AD4695_REG_SPI_CONFIG_A				0x0000
+#define   AD4695_REG_SPI_CONFIG_A_SW_RST		  (BIT(7) | BIT(0))
+#define AD4695_REG_SPI_CONFIG_B				0x0001
+#define   AD4695_REG_SPI_CONFIG_B_INST_MODE		  BIT(7)
+#define AD4695_REG_DEVICE_TYPE				0x0003
+#define AD4695_REG_SCRATCH_PAD				0x000A
+#define AD4695_REG_VENDOR_L				0x000C
+#define AD4695_REG_VENDOR_H				0x000D
+#define AD4695_REG_LOOP_MODE				0x000E
+#define AD4695_REG_SPI_CONFIG_C				0x0010
+#define   AD4695_REG_SPI_CONFIG_C_MB_STRICT		  BIT(7)
+#define AD4695_REG_SPI_STATUS				0x0011
+#define AD4695_REG_STATUS				0x0014
+#define AD4695_REG_ALERT_STATUS1			0x0015
+#define AD4695_REG_ALERT_STATUS2			0x0016
+#define AD4695_REG_CLAMP_STATUS				0x001A
+#define AD4695_REG_SETUP				0x0020
+#define   AD4695_REG_SETUP_LDO_EN			  BIT(4)
+#define   AD4695_REG_SETUP_SPI_MODE			  BIT(2)
+#define   AD4695_REG_SETUP_SPI_CYC_CTRL			  BIT(1)
+#define AD4695_REG_REF_CTRL				0x0021
+#define   AD4695_REG_REF_CTRL_OV_MODE			  BIT(7)
+#define   AD4695_REG_REF_CTRL_VREF_SET			  GENMASK(4, 2)
+#define   AD4695_REG_REF_CTRL_REFHIZ_EN			  BIT(1)
+#define   AD4695_REG_REF_CTRL_REFBUF_EN			  BIT(0)
+#define AD4695_REG_SEQ_CTRL				0x0022
+#define   AD4695_REG_SEQ_CTRL_STD_SEQ_EN		  BIT(7)
+#define   AD4695_REG_SEQ_CTRL_NUM_SLOTS_AS		  GENMASK(6, 0)
+#define AD4695_REG_AC_CTRL				0x0023
+#define AD4695_REG_STD_SEQ_CONFIG			0x0024
+#define AD4695_REG_GPIO_CTRL				0x0026
+#define AD4695_REG_GP_MODE				0x0027
+#define AD4695_REG_TEMP_CTRL				0x0029
+#define AD4695_REG_CONFIG_IN(n)				(0x0030 | (n))
+#define   AD4695_REG_CONFIG_IN_MODE			  BIT(6)
+#define   AD4695_REG_CONFIG_IN_PAIR			  GENMASK(5, 4)
+#define   AD4695_REG_CONFIG_IN_AINHIGHZ_EN		  BIT(3)
+#define AD4695_REG_UPPER_IN(n)				(0x0040 | (2 * (n)))
+#define AD4695_REG_LOWER_IN(n)				(0x0060 | (2 * (n)))
+#define AD4695_REG_HYST_IN(n)				(0x0080 | (2 * (n)))
+#define AD4695_REG_OFFSET_IN(n)				(0x00A0 | (2 * (n)))
+#define AD4695_REG_GAIN_IN(n)				(0x00C0 | (2 * (n)))
+#define AD4695_REG_AS_SLOT(n)				(0x0100 | (n))
+#define   AD4695_REG_AS_SLOT_INX			  GENMASK(3, 0)
+#define AD4695_MAX_REG					0x017F
+
+/* Conversion mode commands */
+#define AD4695_CMD_EXIT_CNV_MODE	0x0A
+#define AD4695_CMD_TEMP_CHAN		0x0F
+#define AD4695_CMD_VOLTAGE_CHAN(n)	(0x10 | (n))
+
+/* timing specs */
+#define AD4695_T_CONVERT_NS		415
+#define AD4695_T_WAKEUP_HW_MS		3
+#define AD4695_T_WAKEUP_SW_MS		3
+#define AD4695_T_REFBUF_MS		100
+#define AD4695_REG_ACCESS_SCLK_HZ	(10 * MEGA)
+
+enum ad4695_in_pair {
+	AD4695_IN_PAIR_REFGND,
+	AD4695_IN_PAIR_COM,
+	AD4695_IN_PAIR_EVEN_ODD,
+};
+
+struct ad4695_chip_info {
+	const char *name;
+	int max_sample_rate;
+	u8 num_voltage_inputs;
+};
+
+struct ad4695_channel_config {
+	bool bipolar;
+	bool highz_en;
+	unsigned int channel;
+	enum ad4695_in_pair pin_pairing;
+};
+
+struct ad4695_state {
+	struct spi_device *spi;
+	struct regmap *regmap;
+	struct gpio_desc *reset_gpio;
+	struct ad4695_channel_config *channels_cfg;
+	const struct ad4695_chip_info *chip_info;
+	/* Reference voltage. */
+	unsigned int vref_mv;
+	/* Common mode input pin voltage. */
+	unsigned int com_mv;
+	/* raw data conversion data recived */
+	u16 raw_data __aligned(IIO_DMA_MINALIGN);
+	/* Commands to send for single conversion */
+	u16 cnv_cmd;
+	u8 cnv_cmd2;
+};
+
+static const struct regmap_range ad4695_regmap_rd_ranges[] = {
+	regmap_reg_range(AD4695_REG_SPI_CONFIG_A, AD4695_REG_SPI_CONFIG_B),
+	regmap_reg_range(AD4695_REG_DEVICE_TYPE, AD4695_REG_DEVICE_TYPE),
+	regmap_reg_range(AD4695_REG_SCRATCH_PAD, AD4695_REG_SCRATCH_PAD),
+	regmap_reg_range(AD4695_REG_VENDOR_L, AD4695_REG_LOOP_MODE),
+	regmap_reg_range(AD4695_REG_SPI_CONFIG_C, AD4695_REG_SPI_STATUS),
+	regmap_reg_range(AD4695_REG_STATUS, AD4695_REG_ALERT_STATUS2),
+	regmap_reg_range(AD4695_REG_CLAMP_STATUS, AD4695_REG_CLAMP_STATUS),
+	regmap_reg_range(AD4695_REG_SETUP, AD4695_REG_TEMP_CTRL),
+	regmap_reg_range(AD4695_REG_CONFIG_IN(0), AD4695_MAX_REG),
+};
+
+static const struct regmap_access_table ad4695_regmap_rd_table = {
+	.yes_ranges = ad4695_regmap_rd_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ad4695_regmap_rd_ranges),
+};
+
+static const struct regmap_range ad4695_regmap_wr_ranges[] = {
+	regmap_reg_range(AD4695_REG_SPI_CONFIG_A, AD4695_REG_SPI_CONFIG_B),
+	regmap_reg_range(AD4695_REG_SCRATCH_PAD, AD4695_REG_SCRATCH_PAD),
+	regmap_reg_range(AD4695_REG_LOOP_MODE, AD4695_REG_LOOP_MODE),
+	regmap_reg_range(AD4695_REG_SPI_CONFIG_C, AD4695_REG_SPI_STATUS),
+	regmap_reg_range(AD4695_REG_SETUP, AD4695_REG_TEMP_CTRL),
+	regmap_reg_range(AD4695_REG_CONFIG_IN(0), AD4695_MAX_REG),
+};
+
+static const struct regmap_access_table ad4695_regmap_wr_table = {
+	.yes_ranges = ad4695_regmap_wr_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ad4695_regmap_wr_ranges),
+};
+
+static const struct regmap_config ad4695_regmap_config = {
+	.name = "ad4695",
+	.reg_bits = 16,
+	.val_bits = 8,
+	.max_register = AD4695_MAX_REG,
+	.rd_table = &ad4695_regmap_rd_table,
+	.wr_table = &ad4695_regmap_wr_table,
+	.can_multi_write = true,
+};
+
+static const struct iio_chan_spec ad4695_channel_template = {
+	.type = IIO_VOLTAGE,
+	.indexed = 1,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			      BIT(IIO_CHAN_INFO_SCALE) |
+			      BIT(IIO_CHAN_INFO_OFFSET),
+	.scan_type = {
+		.realbits = 16,
+		.storagebits = 16,
+	},
+};
+
+static const struct iio_chan_spec ad4695_temp_channel_template = {
+	.address = AD4695_CMD_TEMP_CHAN,
+	.type = IIO_TEMP,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			      BIT(IIO_CHAN_INFO_SCALE) |
+			      BIT(IIO_CHAN_INFO_OFFSET),
+	.scan_type = {
+		.sign = 's',
+		.realbits = 16,
+		.storagebits = 16,
+	},
+};
+
+static const char * const ad4695_power_supplies[] = {
+	"avdd", "vio"
+};
+
+static const struct ad4695_chip_info ad4695_chip_info = {
+	.name = "ad4695",
+	.max_sample_rate = 500 * KILO,
+	.num_voltage_inputs = 16,
+};
+
+static const struct ad4695_chip_info ad4696_chip_info = {
+	.name = "ad4696",
+	.max_sample_rate = 1 * MEGA,
+	.num_voltage_inputs = 16,
+};
+
+static const struct ad4695_chip_info ad4697_chip_info = {
+	.name = "ad4697",
+	.max_sample_rate = 500 * KILO,
+	.num_voltage_inputs = 8,
+};
+
+static const struct ad4695_chip_info ad4698_chip_info = {
+	.name = "ad4698",
+	.max_sample_rate = 1 * MEGA,
+	.num_voltage_inputs = 8,
+};
+
+/**
+ * ad4695_set_single_cycle_mode - Set the device in single cycle mode
+ * @st: The AD4695 state
+ * @channel: The first channel to read
+ *
+ * As per the datasheet, to enable single cycle mode, we need to set
+ * STD_SEQ_EN=0, NUM_SLOTS_AS=0 and CYC_CTRL=1 (Table 15). Setting SPI_MODE=1
+ * triggers the first conversion using the channel in AS_SLOT0.
+ *
+ * Context: can sleep, must be called with iio_device_claim_direct held
+ * Return: 0 on success, a negative error code on failure
+ */
+static int ad4695_set_single_cycle_mode(struct ad4695_state *st,
+					unsigned int channel)
+{
+	int ret;
+
+	ret = regmap_clear_bits(st->regmap, AD4695_REG_SEQ_CTRL,
+				AD4695_REG_SEQ_CTRL_STD_SEQ_EN |
+				AD4695_REG_SEQ_CTRL_NUM_SLOTS_AS);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD4695_REG_AS_SLOT(0),
+			   FIELD_PREP(AD4695_REG_AS_SLOT_INX, channel));
+	if (ret)
+		return ret;
+
+	return regmap_set_bits(st->regmap, AD4695_REG_SETUP,
+			       AD4695_REG_SETUP_SPI_MODE |
+			       AD4695_REG_SETUP_SPI_CYC_CTRL);
+}
+
+static int ad4695_set_ref_voltage(struct ad4695_state *st, int vref_mv)
+{
+	u8 val;
+
+	if (vref_mv >= 2400 && vref_mv <= 2750)
+		val = 0;
+	else if (vref_mv > 2750 && vref_mv <= 3250)
+		val = 1;
+	else if (vref_mv > 3250 && vref_mv <= 3750)
+		val = 2;
+	else if (vref_mv > 3750 && vref_mv <= 4500)
+		val = 3;
+	else if (vref_mv > 4500 && vref_mv <= 5100)
+		val = 4;
+	else
+		return -EINVAL;
+
+	return regmap_update_bits(st->regmap, AD4695_REG_REF_CTRL,
+				  AD4695_REG_REF_CTRL_VREF_SET,
+				  FIELD_PREP(AD4695_REG_REF_CTRL_VREF_SET, val));
+}
+
+static int ad4695_write_chn_cfg(struct ad4695_state *st,
+				struct ad4695_channel_config *cfg)
+{
+	u32 mask = 0, val = 0;
+
+	mask |= AD4695_REG_CONFIG_IN_MODE;
+	val |= FIELD_PREP(AD4695_REG_CONFIG_IN_MODE, cfg->bipolar ? 1 : 0);
+
+	mask |= AD4695_REG_CONFIG_IN_PAIR;
+	val |= FIELD_PREP(AD4695_REG_CONFIG_IN_PAIR, cfg->pin_pairing);
+
+	mask |= AD4695_REG_CONFIG_IN_AINHIGHZ_EN;
+	val |= FIELD_PREP(AD4695_REG_CONFIG_IN_AINHIGHZ_EN, cfg->highz_en ? 1 : 0);
+
+	return regmap_update_bits(st->regmap, AD4695_REG_CONFIG_IN(cfg->channel),
+				  mask, val);
+}
+
+/**
+ * ad4695_read_one_sample - Read a single sample using single-cycle mode
+ * @st: The AD4695 state
+ * @address: The address of the channel to read
+ *
+ * Upon return, the sample will be stored in the raw_data field of @st.
+ *
+ * Context: can sleep, must be called with iio_device_claim_direct held
+ * Return: 0 on success, a negative error code on failure
+ */
+static int ad4695_read_one_sample(struct ad4695_state *st, unsigned int address)
+{
+	struct spi_transfer xfer[2] = { };
+	int ret;
+
+	ret = ad4695_set_single_cycle_mode(st, address);
+	if (ret)
+		return ret;
+
+	/*
+	 * Setting the first channel to the temperature channel isn't supported
+	 * in single-cycle mode, so we have to do an extra xfer to read the
+	 * temperature.
+	 */
+	if (address == AD4695_CMD_TEMP_CHAN) {
+		/* We aren't reading, so we can make this a short xfer. */
+		st->cnv_cmd2 = AD4695_CMD_TEMP_CHAN << 3;
+		xfer[0].bits_per_word = 8;
+		xfer[0].tx_buf = &st->cnv_cmd2;
+		xfer[0].len = 1;
+		xfer[0].cs_change = 1;
+		xfer[0].cs_change_delay.value = AD4695_T_CONVERT_NS;
+		xfer[0].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
+
+		/* Then read the result and exit conversion mode. */
+		st->cnv_cmd = AD4695_CMD_EXIT_CNV_MODE << 11;
+		xfer[1].bits_per_word = 16;
+		xfer[1].tx_buf = &st->cnv_cmd;
+		xfer[1].rx_buf = &st->raw_data;
+		xfer[1].len = 2;
+
+		return spi_sync_transfer(st->spi, xfer, 2);
+	}
+
+	/*
+	 * The conversion has already been done and we just have to read the
+	 * result and exit conversion mode.
+	 */
+	st->cnv_cmd = AD4695_CMD_EXIT_CNV_MODE << 11;
+	xfer[0].bits_per_word = 16;
+	xfer[0].tx_buf = &st->cnv_cmd;
+	xfer[0].rx_buf = &st->raw_data;
+	xfer[0].len = 2;
+
+	return spi_sync_transfer(st->spi, xfer, 1);
+}
+
+static int ad4695_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct ad4695_state *st = iio_priv(indio_dev);
+	struct ad4695_channel_config *cfg = &st->channels_cfg[chan->scan_index];
+	u8 realbits = chan->scan_type.realbits;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+			ret = ad4695_read_one_sample(st, chan->address);
+			if (ret)
+				return ret;
+
+			if (chan->scan_type.sign == 's')
+				*val = sign_extend32(st->raw_data, realbits - 1);
+			else
+				*val = st->raw_data;
+
+			return IIO_VAL_INT;
+		}
+		unreachable();
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			*val = st->vref_mv;
+			*val2 = chan->scan_type.realbits;
+			return IIO_VAL_FRACTIONAL_LOG2;
+		case IIO_TEMP:
+			/* T_scale (°C) = raw * V_REF (mV) / (-1.8 mV/°C * 2^16) */
+			*val = st->vref_mv * -556;
+			*val2 = 16;
+			return IIO_VAL_FRACTIONAL_LOG2;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_OFFSET:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			if (cfg->pin_pairing == AD4695_IN_PAIR_COM)
+				*val = st->com_mv * (1 << realbits) / st->vref_mv;
+			else
+				*val = 0;
+
+			return IIO_VAL_INT;
+		case IIO_TEMP:
+			/* T_offset (°C) = -725 mV / (-1.8 mV/°C) */
+			/* T_offset (raw) = T_offset (°C) * (-1.8 mV/°C) * 2^16 / V_REF (mV) */
+			*val = -47513600;
+			*val2 = st->vref_mv;
+			return IIO_VAL_FRACTIONAL;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4695_debugfs_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+				     unsigned int writeval, unsigned int *readval)
+{
+	struct ad4695_state *st = iio_priv(indio_dev);
+
+	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+		if (readval)
+			return regmap_read(st->regmap, reg, readval);
+
+		return regmap_write(st->regmap, reg, writeval);
+	}
+
+	unreachable();
+}
+
+static const struct iio_info ad4695_info = {
+	.read_raw = &ad4695_read_raw,
+	.debugfs_reg_access = &ad4695_debugfs_reg_access,
+};
+
+static int ad4695_parse_channel_cfg(struct iio_dev *indio_dev)
+{
+	struct device *dev = indio_dev->dev.parent;
+	struct ad4695_state *st = iio_priv(indio_dev);
+	struct iio_chan_spec *iio_chan_arr;
+	struct ad4695_channel_config *chan_cfg_arr;
+	unsigned int chan_idx = 0;
+	int ret;
+
+	indio_dev->num_channels = device_get_child_node_count(dev);
+	if (!indio_dev->num_channels)
+		return dev_err_probe(dev, -ENODEV, "no channel children\n");
+
+	/* Extra channel for temperature. */
+	indio_dev->num_channels++;
+
+	iio_chan_arr = devm_kcalloc(dev, indio_dev->num_channels,
+				    sizeof(*iio_chan_arr), GFP_KERNEL);
+	if (!iio_chan_arr)
+		return -ENOMEM;
+
+	chan_cfg_arr = devm_kcalloc(dev, indio_dev->num_channels,
+				    sizeof(*chan_cfg_arr), GFP_KERNEL);
+	if (!chan_cfg_arr)
+		return -ENOMEM;
+
+	indio_dev->channels = iio_chan_arr;
+	st->channels_cfg = chan_cfg_arr;
+
+	device_for_each_child_node_scoped(dev, child) {
+		struct ad4695_channel_config *chan_cfg = &st->channels_cfg[chan_idx];
+
+		iio_chan_arr[chan_idx] = ad4695_channel_template;
+		iio_chan_arr[chan_idx].scan_index = chan_idx;
+
+		if (fwnode_property_present(child, "diff-channels")) {
+			u32 channels[2];
+
+			ret = fwnode_property_read_u32_array(child,
+							     "diff-channels",
+							     channels,
+							     ARRAY_SIZE(channels));
+			if (ret)
+				return dev_err_probe(dev, ret,
+					"failed to read diff-channels(%s)\n",
+					fwnode_get_name(child));
+
+			if (channels[0] >= st->chip_info->num_voltage_inputs ||
+			    channels[1] >= st->chip_info->num_voltage_inputs)
+				return dev_err_probe(dev, -EINVAL,
+					"diff-channel out of range (%s)\n",
+					fwnode_get_name(child));
+
+			if (channels[0] % 2 != 0 ||
+			    channels[1] != channels[0] + 1)
+				return dev_err_probe(dev, -EINVAL,
+					"diff-channel must be even/odd consecutive pair (%s)\n",
+					fwnode_get_name(child));
+
+			iio_chan_arr[chan_idx].differential = 1;
+			iio_chan_arr[chan_idx].channel = channels[0];
+			iio_chan_arr[chan_idx].channel2 = channels[1];
+			iio_chan_arr[chan_idx].address =
+				AD4695_CMD_VOLTAGE_CHAN(channels[0]);
+
+			chan_cfg->channel = channels[0];
+			chan_cfg->pin_pairing = AD4695_IN_PAIR_EVEN_ODD;
+		} else if (fwnode_property_present(child, "single-channel")) {
+			u32 val;
+
+			ret = fwnode_property_read_u32(child, "single-channel",
+						       &val);
+			if (ret)
+				return dev_err_probe(dev, ret,
+					"failed to read single-channel (%s)\n",
+					fwnode_get_name(child));
+
+			if (val >= st->chip_info->num_voltage_inputs)
+				return dev_err_probe(dev, -EINVAL,
+					"single-channel out of range (%s)\n",
+					fwnode_get_name(child));
+
+			iio_chan_arr[chan_idx].channel = val;
+			iio_chan_arr[chan_idx].address =
+				AD4695_CMD_VOLTAGE_CHAN(val);
+
+			chan_cfg->channel = val;
+
+			/* Default to REFGND if common-mode-channel is not specified. */
+			val = AD4695_IN_PAIR_REFGND;
+
+			ret = fwnode_property_read_u32(child, "common-mode-channel",
+						       &val);
+			if (ret && ret != -EINVAL)
+				return dev_err_probe(dev, ret,
+					"failed to read common-mode-channel (%s)\n",
+					fwnode_get_name(child));
+
+			if (val > AD4695_IN_PAIR_COM)
+				return dev_err_probe(dev, -EINVAL,
+					"common-mode-channel out of range (%s)\n",
+					fwnode_get_name(child));
+
+			chan_cfg->pin_pairing = val;
+		} else {
+			return dev_err_probe(dev, -EINVAL,
+					"missing diff or single channel (%s)\n",
+					fwnode_get_name(child));
+		}
+
+		chan_cfg->bipolar = fwnode_property_read_bool(child, "bipolar");
+
+		iio_chan_arr[chan_idx].scan_type.sign = chan_cfg->bipolar ? 's' : 'u';
+
+		if (chan_cfg->bipolar && chan_cfg->pin_pairing == AD4695_IN_PAIR_REFGND)
+			return dev_err_probe(dev, -EINVAL,
+				"bipolar mode is not available for inputs paired with REFGND (%s).\n",
+				fwnode_get_name(child));
+
+		chan_cfg->highz_en = !fwnode_property_read_bool(child, "adi,no-high-z");
+
+		ret = ad4695_write_chn_cfg(st, chan_cfg);
+		if (ret)
+			return ret;
+
+		chan_idx++;
+	}
+
+	/* Temperature channel must be next scan index after voltage channels. */
+	iio_chan_arr[chan_idx] = ad4695_temp_channel_template;
+	iio_chan_arr[chan_idx].scan_index = chan_idx;
+
+	return 0;
+}
+
+static int ad4695_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct ad4695_state *st;
+	struct iio_dev *indio_dev;
+	struct gpio_desc *cnv_gpio;
+	bool use_internal_ldo_supply;
+	bool use_internal_ref_buffer;
+	int ret;
+
+	cnv_gpio = devm_gpiod_get_optional(dev, "cnv", GPIOD_OUT_LOW);
+	if (IS_ERR(cnv_gpio))
+		return dev_err_probe(dev, PTR_ERR(cnv_gpio), "Failed to get CNV GPIO\n");
+
+	/* Driver currently requires CNV pin to be connected to SPI CS */
+	if (cnv_gpio)
+		return dev_err_probe(dev, -ENODEV, "CNV GPIO is not supported\n");
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+
+	st->chip_info = spi_get_device_match_data(spi);
+	if (!st->chip_info)
+		return -EINVAL;
+
+	/* Registers cannot be read at the max allowable speed */
+	spi->max_speed_hz = AD4695_REG_ACCESS_SCLK_HZ;
+
+	st->regmap = devm_regmap_init_spi(spi, &ad4695_regmap_config);
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(dev, PTR_ERR(st->regmap), "Failed to initialize regmap\n");
+
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ad4695_power_supplies),
+					     ad4695_power_supplies);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable power supplies\n");
+
+	/* If LDO_IN supply is present, then we are using internal LDO. */
+	ret = devm_regulator_get_enable_optional(dev, "ldo-in");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "Failed to enable LDO_IN supply\n");
+
+	use_internal_ldo_supply = ret == 0;
+
+	if (!use_internal_ldo_supply) {
+		/* Otherwise we need an external VDD supply. */
+		ret = devm_regulator_get_enable(dev, "vdd");
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "Failed to enable VDD supply\n");
+	}
+
+	/* If REFIN supply is given, then we are using internal buffer */
+	ret = devm_regulator_get_enable_read_voltage(dev, "refin");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "Failed to get REFIN voltage\n");
+
+	if (ret != -ENODEV) {
+		st->vref_mv = ret / 1000;
+		use_internal_ref_buffer = true;
+	} else {
+		/* Otherwise, we need an external reference. */
+		ret = devm_regulator_get_enable_read_voltage(dev, "ref");
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "Failed to get REF voltage\n");
+
+		st->vref_mv = ret / 1000;
+		use_internal_ref_buffer = false;
+	}
+
+	ret = devm_regulator_get_enable_read_voltage(dev, "com");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "Failed to get COM voltage\n");
+
+	st->com_mv = ret == -ENODEV ? 0 : ret / 1000;
+
+	/*
+	 * Reset the device using hardware reset if available or fall back to
+	 * software reset.
+	 */
+
+	st->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(st->reset_gpio))
+		return PTR_ERR(st->reset_gpio);
+
+	if (st->reset_gpio) {
+		gpiod_set_value(st->reset_gpio, 0);
+		msleep(AD4695_T_WAKEUP_HW_MS);
+	} else {
+		ret = regmap_write(st->regmap, AD4695_REG_SPI_CONFIG_A,
+				   AD4695_REG_SPI_CONFIG_A_SW_RST);
+		if (ret)
+			return ret;
+
+		msleep(AD4695_T_WAKEUP_SW_MS);
+	}
+
+	/* Needed for debugfs since it only access registers 1 byte at a time. */
+	ret = regmap_set_bits(st->regmap, AD4695_REG_SPI_CONFIG_C,
+			      AD4695_REG_SPI_CONFIG_C_MB_STRICT);
+	if (ret)
+		return ret;
+
+	/* Disable internal LDO if it isn't needed. */
+	ret = regmap_update_bits(st->regmap, AD4695_REG_SETUP,
+				 AD4695_REG_SETUP_LDO_EN,
+				 FIELD_PREP(AD4695_REG_SETUP_LDO_EN,
+					    use_internal_ldo_supply ? 1 : 0));
+	if (ret)
+		return ret;
+
+	/* configure reference supply */
+
+	if (device_property_present(dev, "adi,no-ref-current-limit")) {
+		ret = regmap_set_bits(st->regmap, AD4695_REG_REF_CTRL,
+				      AD4695_REG_REF_CTRL_OV_MODE);
+		if (ret)
+			return ret;
+	}
+
+	if (device_property_present(dev, "adi,no-ref-high-z")) {
+		if (use_internal_ref_buffer)
+			return dev_err_probe(dev, -EINVAL,
+				"Cannot disable high-Z mode for internal reference buffer\n");
+
+		ret = regmap_clear_bits(st->regmap, AD4695_REG_REF_CTRL,
+					AD4695_REG_REF_CTRL_REFHIZ_EN);
+		if (ret)
+			return ret;
+	}
+
+	ret = ad4695_set_ref_voltage(st, st->vref_mv);
+	if (ret)
+		return ret;
+
+	if (use_internal_ref_buffer) {
+		ret = regmap_set_bits(st->regmap, AD4695_REG_REF_CTRL,
+				      AD4695_REG_REF_CTRL_REFBUF_EN);
+		if (ret)
+			return ret;
+
+		/* Give the capacitor some time to charge up. */
+		msleep(AD4695_T_REFBUF_MS);
+	}
+
+	ret = ad4695_parse_channel_cfg(indio_dev);
+	if (ret)
+		return ret;
+
+	indio_dev->name = st->chip_info->name;
+	indio_dev->info = &ad4695_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct spi_device_id ad4695_spi_id_table[] = {
+	{ .name = "ad4695", .driver_data = (kernel_ulong_t)&ad4695_chip_info },
+	{ .name = "ad4696", .driver_data = (kernel_ulong_t)&ad4696_chip_info },
+	{ .name = "ad4697", .driver_data = (kernel_ulong_t)&ad4697_chip_info },
+	{ .name = "ad4698", .driver_data = (kernel_ulong_t)&ad4698_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad4695_spi_id_table);
+
+static const struct of_device_id ad4695_of_match_table[] = {
+	{ .compatible = "adi,ad4695", .data = &ad4695_chip_info, },
+	{ .compatible = "adi,ad4696", .data = &ad4696_chip_info, },
+	{ .compatible = "adi,ad4697", .data = &ad4697_chip_info, },
+	{ .compatible = "adi,ad4698", .data = &ad4698_chip_info, },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad4695_of_match_table);
+
+static struct spi_driver ad4695_driver = {
+	.driver = {
+		.name = "ad4695",
+		.of_match_table = ad4695_of_match_table,
+	},
+	.probe = ad4695_probe,
+	.id_table = ad4695_spi_id_table,
+};
+module_spi_driver(ad4695_driver);
+
+MODULE_AUTHOR("Ramona Gradinariu <ramona.gradinariu@analog.com>");
+MODULE_AUTHOR("David Lechner <dlechner@baylibre.com>");
+MODULE_DESCRIPTION("Analog Devices AD4695 ADC driver");
+MODULE_LICENSE("GPL");

-- 
2.45.2


