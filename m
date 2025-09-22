Return-Path: <linux-iio+bounces-24350-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97640B90694
	for <lists+linux-iio@lfdr.de>; Mon, 22 Sep 2025 13:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A246617DB31
	for <lists+linux-iio@lfdr.de>; Mon, 22 Sep 2025 11:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20208306D2B;
	Mon, 22 Sep 2025 11:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zWPY/5Vp"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB75CAD5A;
	Mon, 22 Sep 2025 11:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758540715; cv=none; b=QpWL7S+12CvNvUQOKeLtef/g98o1RkfbXB+jWag/rdvBUvAXIS4Q23V+UjeDonsll/6uunO9WvnYCioHPDuN32oJtXjPYn7o9gIIrtJbbv1qbhPtmZUdFwz0ZbiObCxsldQ4EJ8NtD0qFMydVN/LDh0w0l1h8gPTSQTdBAUGn0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758540715; c=relaxed/simple;
	bh=CHXi9toR2h5uP4bzrfZAD9X4g/l7vyhIV9srSa5Udg4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=G6SVtTRrgrd91Wq/VjyCJpy80pX1Shif+U8zp7XFNLED1iehwKBLogRKKZJ4Oqp9r3AtnN3KjWqxL7DnjSBa31kguLig7Tw7O+LUfSBVDYc5kY+NRGLhPEQ8igzAMp150cbSDkozblHpHCxJWVc0uLR8dmfiNkrxjZNd9gQwBn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zWPY/5Vp; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1758540712; x=1790076712;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=CHXi9toR2h5uP4bzrfZAD9X4g/l7vyhIV9srSa5Udg4=;
  b=zWPY/5VpUJoTQoUZ586Eiafn01RO7YF+RjPpqeFj4VAUIyZmBzrBrWmp
   iP+/kJAidfb5jnaB4DbL9VUOKFV/Rz2jolvUfXjvC9Zmb7y3lspu4sIiW
   zsk+i/OxDTLFrKWsq67cIGZxvhPVESsYQ8xR5IiwY7YPQkouiXaa2hfjJ
   Uj92JRJSzVNgwrTXchZYz3jIdMIe1Z1S9+j0QQ68Zvg2gHgYxcQod2eNd
   BSj+/BCVQ1m/hMgFdTbsDopKF2tlDNT13pI9pQ/myfWk78JXKTQV0Lu4T
   1o2Y7GjhIqcpg4awJljM3+Qo3DKt5XO39wr6uFGpWftiENfLW2mU+odyf
   w==;
X-CSE-ConnectionGUID: YdbPqAe1Tj2CMCNQIPYNrg==
X-CSE-MsgGUID: gvrDJtYaQOitEQMn1Vcpyg==
X-IronPort-AV: E=Sophos;i="6.18,285,1751266800"; 
   d="scan'208";a="46230265"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Sep 2025 04:31:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 22 Sep 2025 04:31:09 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Mon, 22 Sep 2025 04:31:06 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Mon, 22 Sep 2025 14:30:54 +0300
Subject: [PATCH 2/2] iio: dac: adding support for Microchip MCP47FEB02
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250922-mcp47feb02-v1-2-06cb4acaa347@microchip.com>
References: <20250922-mcp47feb02-v1-0-06cb4acaa347@microchip.com>
In-Reply-To: <20250922-mcp47feb02-v1-0-06cb4acaa347@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758540660; l=45179;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=CHXi9toR2h5uP4bzrfZAD9X4g/l7vyhIV9srSa5Udg4=;
 b=tBLPgmpbknU6CQC2F4W4z13/MVQ7v8qbwT2Z88oY+ouT60llrR9gVWkUl2GJaBDRuR9Tv3hfs
 +aaau9V1sYgDKbQnQsbOcv508d0IN9hBDjolzf+Y+z6KiWFasFyOpt2
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

This is the iio driver for Microchip MCP47F(E/V)B(0/1/2)1, MCP47F(E/V)B(0/1/2)2,
MCP47F(E/V)B(0/1/2)4 and MCP47F(E/V)B(0/1/2)8 series of buffered voltage output
Digital-to-Analog Converters with nonvolatile or volatile memory and an I2C
Interface.

The families support up to 8 output channels.

The devices can be 8-bit, 10-bit and 12-bit.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 MAINTAINERS                  |    1 +
 drivers/iio/dac/Kconfig      |   16 +
 drivers/iio/dac/Makefile     |    1 +
 drivers/iio/dac/mcp47feb02.c | 1347 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1365 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6f51890cfc3081bc49c08fddc8af526c1ecc8d72..0f97f90ac2f492895d27da86d831df83cb402516 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14943,6 +14943,7 @@ M:	Ariana Lazar <ariana.lazar@microchip.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
+F:	drivers/iio/dac/mcp47feb02.c
 
 MCP4821 DAC DRIVER
 M:	Anshul Dalal <anshulusr@gmail.com>
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index e0996dc014a3d538ab6b4e0d50ff54ede50f1527..179ce565036e3494e4ce43bb926de31f38b547c4 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -509,6 +509,22 @@ config MCP4728
 	  To compile this driver as a module, choose M here: the module
 	  will be called mcp4728.
 
+config MCP47FEB02
+	tristate "MCP47F(E/V)B|(0/1/2)(1/2/4/8)DAC driver"
+	depends on I2C
+	help
+          Say yes here if you want to build a driver for the Microchip
+          MCP47FEB01, MCP47FEB11, MCP47FEB21, MCP47FEB02, MCP47FEB12,
+          MCP47FEB22, MCP47FVB01, MCP47FVB11, MCP47FVB21, MCP47FVB02,
+          MCP47FVB12, MCP47FVB02, MCP47FVB12, MCP47FVB22, MCP47FVB04,
+          MCP47FVB14, MCP47FVB24, MCP47FVB04, MCP47FVB08, MCP47FVB18,
+          MCP47FVB28, MCP47FEB04, MCP47FEB14 and MCP47FEB24 having up to 8
+          channels, 8-bit, 10-bit or 12-bit digital-to-analog converter (DAC)
+          with I2C interface.
+
+          To compile this driver as a module, choose M here: the module
+          will be called mcp47feb02.
+
 config MCP4821
 	tristate "MCP4801/02/11/12/21/22 DAC driver"
 	depends on SPI
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 3684cd52b7fa9bc0ad9f855323dcbb2e4965c404..d633a6440fc4b9aba7d8b1c209b6dcd05cd982dd 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -50,6 +50,7 @@ obj-$(CONFIG_MAX5522) += max5522.o
 obj-$(CONFIG_MAX5821) += max5821.o
 obj-$(CONFIG_MCP4725) += mcp4725.o
 obj-$(CONFIG_MCP4728) += mcp4728.o
+obj-$(CONFIG_MCP47FEB02) += mcp47feb02.o
 obj-$(CONFIG_MCP4821) += mcp4821.o
 obj-$(CONFIG_MCP4922) += mcp4922.o
 obj-$(CONFIG_STM32_DAC_CORE) += stm32-dac-core.o
diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
new file mode 100644
index 0000000000000000000000000000000000000000..c9c2ded78d9c6013e5618e6342ebc8f50e79a31e
--- /dev/null
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -0,0 +1,1347 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * IIO driver for MCP47FEB02 Multi-Channel DAC with I2C interface
+ *
+ * Copyright (C) 2025 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Ariana Lazar <ariana.lazar@microchip.com>
+ *
+ * Datasheet for MCP47FEBXX can be found here:
+ * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005375A.pdf
+ *
+ * Datasheet for MCP47FVBXX can be found here:
+ * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005405A.pdf
+ *
+ * Datasheet for MCP47FXBX4/8 can be found here:
+ * https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP47FXBX48-Data-Sheet-DS200006368A.pdf
+ */
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+#define MCP47FEB02_DAC0_REG_ADDR		0x00
+#define MCP47FEB02_DAC1_REG_ADDR		0x01
+#define MCP47FEB02_DAC2_REG_ADDR		0x02
+#define MCP47FEB02_DAC3_REG_ADDR		0x03
+#define MCP47FEB02_DAC4_REG_ADDR		0x04
+#define MCP47FEB02_DAC5_REG_ADDR		0x05
+#define MCP47FEB02_DAC6_REG_ADDR		0x06
+#define MCP47FEB02_DAC7_REG_ADDR		0x07
+#define MCP47FEB02_VREF_REG_ADDR		0x08
+#define MCP47FEB02_POWER_DOWN_REG_ADDR		0x09
+#define MCP47FEB02_GAIN_STATUS_REG_ADDR		0x0A
+#define MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR	0x0B
+
+#define MCP47FEB02_NV_DAC0_REG_ADDR		0x10
+#define MCP47FEB02_NV_DAC1_REG_ADDR		0x11
+#define MCP47FEB02_NV_DAC2_REG_ADDR		0x12
+#define MCP47FEB02_NV_DAC3_REG_ADDR		0x13
+#define MCP47FEB02_NV_DAC4_REG_ADDR		0x14
+#define MCP47FEB02_NV_DAC5_REG_ADDR		0x15
+#define MCP47FEB02_NV_DAC6_REG_ADDR		0x16
+#define MCP47FEB02_NV_DAC7_REG_ADDR		0x17
+#define MCP47FEB02_NV_VREF_REG_ADDR		0x18
+#define MCP47FEB02_NV_POWER_DOWN_REG_ADDR	0x19
+#define MCP47FEB02_NV_GAIN_I2C_SLAVE_REG_ADDR	0x1A
+
+#define MCP47FEBXX_MAX_CH			8
+#define MCP47FEB02_GAIN_X1			0
+#define MCP47FEB02_GAIN_X2			1
+#define MCP47FEB02_MAX_VALS_SCALES_CH		6
+#define MCP47FEB02_MAX_SCALES_CH		3
+#define MCP47FEB02_DAC_WIPER_UNLOCKED		0
+#define MCP47FEB02_INTERNAL_BAND_GAP_MV		2440
+#define MCP47FEB02_DELAY_1_MS			1000
+
+/* Voltage reference, Power-Down control register and DAC Wiperlock status register fields */
+#define CH_0					GENMASK(1, 0)
+#define CH_1					GENMASK(3, 2)
+#define CH_2					GENMASK(5, 4)
+#define CH_3					GENMASK(7, 6)
+#define CH_4					GENMASK(9, 8)
+#define CH_5					GENMASK(11, 10)
+#define CH_6					GENMASK(13, 12)
+#define CH_7					GENMASK(15, 14)
+
+/* Gain Control and I2C Slave Address Reguster fields */
+#define G_0					BIT(8)
+#define G_1					BIT(9)
+#define G_2					BIT(10)
+#define G_3					BIT(11)
+#define G_4					BIT(12)
+#define G_5					BIT(13)
+#define G_6					BIT(14)
+#define G_7					BIT(15)
+
+#define MCP47FEB02_GAIN_STATUS_EEWA_MASK	BIT(6)
+#define MCP47FEB02_VOLATILE_GAIN_MASK		GENMASK(15, 8)
+#define MCP47FEB02_NV_I2C_SLAVE_ADDR_MASK	GENMASK(7, 0)
+#define MCP47FEB02_WIPERLOCK_STATUS_MASK	GENMASK(15, 0)
+#define CMD_MEM_ADDR_MASK			GENMASK(7, 3)
+
+#define CMD_FORMAT(reg, cmd)			(FIELD_PREP(CMD_MEM_ADDR_MASK, (reg)) | (cmd))
+#define READ_CMD				0x06
+#define WRITE_CMD				0x00
+#define READ_OP(ch)				(((ch) << 3) | READ_CMD)
+#define WRITE_OP(ch)				((ch) << 3)
+
+enum vref_mode {
+	MCP47FEB02_VREF_VDD = 0,
+	MCP47FEB02_INTERNAL_BAND_GAP = 1,
+	MCP47FEB02_EXTERNAL_VREF_UNBUFFERED = 2,
+	MCP47FEB02_EXTERNAL_VREF_BUFFERED = 3,
+};
+
+enum mcp47feb02_scale {
+	MCP47FEB02_SCALE_VDD = 0,
+	MCP47FEB02_SCALE_GAIN_X1 = 1,
+	MCP47FEB02_SCALE_GAIN_X2 = 2,
+};
+
+enum iio_powerdown_mode {
+	MCP47FEB02_NORMAL_OPERATION = 0,
+	MCP47FEB02_IIO_1K = 1,
+	MCP47FEB02_IIO_100K = 2,
+	MCP47FEB02_OPEN_CIRCUIT = 3,
+};
+
+/**
+ * struct mcp47feb02_features - chip specific data
+ * @name:		device name
+ * @phys_channels:	number of hardware channels
+ * @resolution:		ADC resolution
+ * @have_ext_vref2:	does the hardware have an the second external voltage reference?
+ * @have_eeprom:	does the hardware have an internal eeprom?
+ */
+struct mcp47feb02_features {
+	const char	*name;
+	unsigned int	phys_channels;
+	unsigned int	resolution;
+	bool have_ext_vref2;
+	bool have_eeprom;
+};
+
+static const struct mcp47feb02_features mcp47feb01_chip_info = {
+	.name = "mcp47feb01",
+	.phys_channels = 1,
+	.resolution = 8,
+	.have_ext_vref2 = false,
+	.have_eeprom = true,
+};
+
+static const struct mcp47feb02_features mcp47feb11_chip_info = {
+	.name = "mcp47feb11",
+	.phys_channels = 1,
+	.resolution = 10,
+	.have_ext_vref2 = false,
+	.have_eeprom = true,
+};
+
+static const struct mcp47feb02_features mcp47feb21_chip_info = {
+	.name = "mcp47feb21",
+	.phys_channels = 1,
+	.resolution = 12,
+	.have_ext_vref2 = false,
+	.have_eeprom = true,
+};
+
+static const struct mcp47feb02_features mcp47feb02_chip_info = {
+	.name = "mcp47feb02",
+	.phys_channels = 2,
+	.resolution = 8,
+	.have_ext_vref2 = false,
+	.have_eeprom = true,
+};
+
+static const struct mcp47feb02_features mcp47feb12_chip_info = {
+	.name = "mcp47feb12",
+	.phys_channels = 2,
+	.resolution = 10,
+	.have_ext_vref2 = false,
+	.have_eeprom = true,
+};
+
+static const struct mcp47feb02_features mcp47feb22_chip_info = {
+	.name = "mcp47feb22",
+	.phys_channels = 2,
+	.resolution = 12,
+	.have_ext_vref2 = false,
+	.have_eeprom = true,
+};
+
+static const struct mcp47feb02_features mcp47feb04_chip_info = {
+	.name = "mcp47feb04",
+	.phys_channels = 4,
+	.resolution = 8,
+	.have_ext_vref2 = true,
+	.have_eeprom = true,
+};
+
+static const struct mcp47feb02_features mcp47feb14_chip_info = {
+	.name = "mcp47feb14",
+	.phys_channels = 4,
+	.resolution = 10,
+	.have_ext_vref2 = true,
+	.have_eeprom = true,
+};
+
+static const struct mcp47feb02_features mcp47feb24_chip_info = {
+	.name = "mcp47feb24",
+	.phys_channels = 4,
+	.resolution = 12,
+	.have_ext_vref2 = true,
+	.have_eeprom = true,
+};
+
+static const struct mcp47feb02_features mcp47feb08_chip_info = {
+	.name = "mcp47feb08",
+	.phys_channels = 8,
+	.resolution = 8,
+	.have_ext_vref2 = true,
+	.have_eeprom = true,
+};
+
+static const struct mcp47feb02_features mcp47feb18_chip_info = {
+	.name = "mcp47feb18",
+	.phys_channels = 8,
+	.resolution = 10,
+	.have_ext_vref2 = true,
+	.have_eeprom = true,
+};
+
+static const struct mcp47feb02_features mcp47feb28_chip_info = {
+	.name = "mcp47feb28",
+	.phys_channels = 8,
+	.resolution = 12,
+	.have_ext_vref2 = true,
+	.have_eeprom = true,
+};
+
+static const struct mcp47feb02_features mcp47fvb01_chip_info = {
+	.name = "mcp47fvb01",
+	.phys_channels = 1,
+	.resolution = 8,
+	.have_ext_vref2 = false,
+	.have_eeprom = false,
+};
+
+static const struct mcp47feb02_features mcp47fvb11_chip_info = {
+	.name = "mcp47fvb11",
+	.phys_channels = 1,
+	.resolution = 10,
+	.have_ext_vref2 = false,
+	.have_eeprom = false,
+};
+
+static const struct mcp47feb02_features mcp47fvb21_chip_info = {
+	.name = "mcp47fvb21",
+	.phys_channels = 1,
+	.resolution = 12,
+	.have_ext_vref2 = false,
+	.have_eeprom = false,
+};
+
+static const struct mcp47feb02_features mcp47fvb02_chip_info = {
+	.name = "mcp47fvb02",
+	.phys_channels = 2,
+	.resolution = 8,
+	.have_ext_vref2 = false,
+	.have_eeprom = false,
+};
+
+static const struct mcp47feb02_features mcp47fvb12_chip_info = {
+	.name = "mcp47fvb12",
+	.phys_channels = 2,
+	.resolution = 8,
+	.have_ext_vref2 = false,
+	.have_eeprom = false,
+};
+
+static const struct mcp47feb02_features mcp47fvb22_chip_info = {
+	.name = "mcp47fvb22",
+	.phys_channels = 2,
+	.resolution = 12,
+	.have_ext_vref2 = false,
+	.have_eeprom = false,
+};
+
+static const struct mcp47feb02_features mcp47fvb04_chip_info = {
+	.name = "mcp47fvb04",
+	.phys_channels = 4,
+	.resolution = 8,
+	.have_ext_vref2 = true,
+	.have_eeprom = false,
+};
+
+static const struct mcp47feb02_features mcp47fvb14_chip_info = {
+	.name = "mcp47fvb14",
+	.phys_channels = 4,
+	.resolution = 10,
+	.have_ext_vref2 = true,
+	.have_eeprom = false,
+};
+
+static const struct mcp47feb02_features mcp47fvb24_chip_info = {
+	.name = "mcp47fvb24",
+	.phys_channels = 4,
+	.resolution = 12,
+	.have_ext_vref2 = true,
+	.have_eeprom = false,
+};
+
+static const struct mcp47feb02_features mcp47fvb08_chip_info = {
+	.name = "mcp47fvb08",
+	.phys_channels = 8,
+	.resolution = 8,
+	.have_ext_vref2 = true,
+	.have_eeprom = false,
+};
+
+static const struct mcp47feb02_features mcp47fvb18_chip_info = {
+	.name = "mcp47fvb18",
+	.phys_channels = 8,
+	.resolution = 10,
+	.have_ext_vref2 = true,
+	.have_eeprom = false,
+};
+
+static const struct mcp47feb02_features mcp47fvb28_chip_info = {
+	.name = "mcp47fvb28",
+	.phys_channels = 4,
+	.resolution = 8,
+	.have_ext_vref2 = true,
+	.have_eeprom = false,
+};
+
+/**
+ * struct mcp47feb02_channel_data - channel configuration
+ * @ref_mode: chosen voltage for reference
+ * @powerdown_mode: selected power-down mode
+ * @use_2x_gain: output driver gain control
+ * @powerdown: is false if the channel is in normal operation mode
+ * @dac_data: read dac value
+ */
+struct mcp47feb02_channel_data {
+	enum vref_mode ref_mode;
+	u8 powerdown_mode;
+	bool use_2x_gain;
+	bool powerdown;
+	u16 dac_data;
+};
+
+/**
+ * struct mcp47feb02_data - chip configuration
+ * @chdata: options configured for each channel on the device
+ * @scale: scales set on channels that are based on Vref/Vref0
+ * @scale_1:  scales set on channels that are based on Vref1
+ * @labels: table with channels labels
+ * @active_channels_mask: enabled channels
+ * @client: the i2c-client attached to the device
+ * @regmap: regmap for directly accessing device register
+ * @vref1_buffered: Vref1 buffer is enabled
+ * @vref_buffered: Vref/Vref0 buffer is enabled
+ * @phys_channels: physical channels on the device
+ * @lock: prevents concurrent reads/writes
+ * @use_vref1: vref1-supply is defined
+ * @use_vref: vref-supply is defined
+ * @have_eeprom: does the hardware have an internal eeprom?
+ */
+struct mcp47feb02_data {
+	struct mcp47feb02_channel_data chdata[MCP47FEBXX_MAX_CH];
+	int scale[MCP47FEB02_MAX_VALS_SCALES_CH];
+	int scale_1[MCP47FEB02_MAX_VALS_SCALES_CH];
+	const char *labels[MCP47FEBXX_MAX_CH];
+	unsigned long active_channels_mask;
+	struct i2c_client *client;
+	struct regmap *regmap;
+	bool vref1_buffered;
+	bool vref_buffered;
+	u16 phys_channels;
+	struct mutex lock; /* synchronize access to driver's state members */
+	bool use_vref1;
+	bool use_vref;
+	bool have_eeprom;
+};
+
+static const struct regmap_range mcp47feb02_readable_ranges[] = {
+	regmap_reg_range(READ_OP(MCP47FEB02_DAC0_REG_ADDR),
+			 READ_OP(MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR)),
+	regmap_reg_range(READ_OP(MCP47FEB02_NV_DAC0_REG_ADDR),
+			 READ_OP(MCP47FEB02_NV_GAIN_I2C_SLAVE_REG_ADDR)),
+};
+
+static const struct regmap_range mcp47feb02_writable_ranges[] = {
+	regmap_reg_range(WRITE_OP(MCP47FEB02_DAC0_REG_ADDR),
+			 WRITE_OP(MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR)),
+	regmap_reg_range(WRITE_OP(MCP47FEB02_NV_DAC0_REG_ADDR),
+			 WRITE_OP(MCP47FEB02_NV_GAIN_I2C_SLAVE_REG_ADDR)),
+};
+
+static const struct regmap_range mcp47feb02_volatile_ranges[] = {
+	regmap_reg_range(WRITE_OP(MCP47FEB02_DAC0_REG_ADDR),
+			 WRITE_OP(MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR)),
+	regmap_reg_range(WRITE_OP(MCP47FEB02_NV_DAC0_REG_ADDR),
+			 WRITE_OP(MCP47FEB02_NV_GAIN_I2C_SLAVE_REG_ADDR)),
+	regmap_reg_range(READ_OP(MCP47FEB02_DAC0_REG_ADDR),
+			 READ_OP(MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR)),
+	regmap_reg_range(READ_OP(MCP47FEB02_NV_DAC0_REG_ADDR),
+			 READ_OP(MCP47FEB02_NV_GAIN_I2C_SLAVE_REG_ADDR)),
+};
+
+static const struct regmap_access_table mcp47feb02_readable_table = {
+	.yes_ranges = mcp47feb02_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(mcp47feb02_readable_ranges),
+};
+
+static const struct regmap_access_table mcp47feb02_writable_table = {
+	.yes_ranges = mcp47feb02_writable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(mcp47feb02_writable_ranges),
+};
+
+static const struct regmap_access_table mcp47feb02_volatile_table = {
+	.yes_ranges = mcp47feb02_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(mcp47feb02_volatile_ranges),
+};
+
+static const struct regmap_config mcp47feb02_regmap_config = {
+	.name = "mcp47feb02_regmap",
+	.reg_bits = 8,
+	.val_bits = 16,
+	.rd_table = &mcp47feb02_readable_table,
+	.wr_table = &mcp47feb02_writable_table,
+	.volatile_table = &mcp47feb02_volatile_table,
+	.max_register = READ_OP(MCP47FEB02_NV_GAIN_I2C_SLAVE_REG_ADDR),
+	.cache_type = REGCACHE_RBTREE,
+};
+
+/* For devices that doesn't have nonvolatile memory */
+static const struct regmap_range mcp47fvb02_readable_ranges[] = {
+	regmap_reg_range(READ_OP(MCP47FEB02_DAC0_REG_ADDR),
+			 READ_OP(MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR)),
+};
+
+static const struct regmap_range mcp47fvb02_writable_ranges[] = {
+	regmap_reg_range(WRITE_OP(MCP47FEB02_DAC0_REG_ADDR),
+			 WRITE_OP(MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR)),
+};
+
+static const struct regmap_range mcp47fvb02_volatile_ranges[] = {
+	regmap_reg_range(WRITE_OP(MCP47FEB02_DAC0_REG_ADDR),
+			 WRITE_OP(MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR)),
+	regmap_reg_range(READ_OP(MCP47FEB02_DAC0_REG_ADDR),
+			 READ_OP(MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR)),
+};
+
+static const struct regmap_access_table mcp47fvb02_readable_table = {
+	.yes_ranges = mcp47fvb02_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(mcp47fvb02_readable_ranges),
+};
+
+static const struct regmap_access_table mcp47fvb02_writable_table = {
+	.yes_ranges = mcp47fvb02_writable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(mcp47fvb02_writable_ranges),
+};
+
+static const struct regmap_access_table mcp47fvb02_volatile_table = {
+	.yes_ranges = mcp47fvb02_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(mcp47fvb02_volatile_ranges),
+};
+
+static const struct regmap_config mcp47fvb02_regmap_config = {
+	.name = "mcp47fvb02_regmap",
+	.reg_bits = 8,
+	.val_bits = 16,
+	.rd_table = &mcp47fvb02_readable_table,
+	.wr_table = &mcp47fvb02_writable_table,
+	.volatile_table = &mcp47fvb02_volatile_table,
+	.max_register = READ_OP(MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR),
+	.cache_type = REGCACHE_RBTREE,
+};
+
+static int mcp47feb02_write_to_register(struct regmap *regmap, unsigned int reg,
+					int channel, int tmp_val)
+{
+	int ret, val;
+
+	ret = regmap_read(regmap, CMD_FORMAT(reg, READ_CMD), &val);
+	if (ret)
+		return ret;
+
+	if (reg == MCP47FEB02_GAIN_STATUS_REG_ADDR) {
+		switch (channel) {
+		case 0:
+			FIELD_MODIFY(G_0, &val, tmp_val);
+			break;
+		case 1:
+			FIELD_MODIFY(G_1, &val, tmp_val);
+			break;
+		case 2:
+			FIELD_MODIFY(G_2, &val, tmp_val);
+			break;
+		case 3:
+			FIELD_MODIFY(G_3, &val, tmp_val);
+			break;
+		case 4:
+			FIELD_MODIFY(G_4, &val, tmp_val);
+			break;
+		case 5:
+			FIELD_MODIFY(G_5, &val, tmp_val);
+			break;
+		case 6:
+			FIELD_MODIFY(G_6, &val, tmp_val);
+			break;
+		case 7:
+			FIELD_MODIFY(G_7, &val, tmp_val);
+			break;
+		default:
+			FIELD_MODIFY(G_0, &val, tmp_val);
+			break;
+		}
+	} else {
+		switch (channel) {
+		case 0:
+			FIELD_MODIFY(CH_0, &val, tmp_val);
+			break;
+		case 1:
+			FIELD_MODIFY(CH_1, &val, tmp_val);
+			break;
+		case 2:
+			FIELD_MODIFY(CH_2, &val, tmp_val);
+			break;
+		case 3:
+			FIELD_MODIFY(CH_3, &val, tmp_val);
+			break;
+		case 4:
+			FIELD_MODIFY(CH_4, &val, tmp_val);
+			break;
+		case 5:
+			FIELD_MODIFY(CH_5, &val, tmp_val);
+			break;
+		case 6:
+			FIELD_MODIFY(CH_6, &val, tmp_val);
+			break;
+		case 7:
+			FIELD_MODIFY(CH_7, &val, tmp_val);
+			break;
+		default:
+			FIELD_MODIFY(CH_0, &val, tmp_val);
+			break;
+		}
+	}
+
+	ret = regmap_write(regmap, CMD_FORMAT(reg, WRITE_CMD), val);
+
+	return ret;
+}
+
+static int mcp47feb02_write_to_eeprom(struct regmap *regmap, unsigned int reg,
+				      unsigned int val)
+{
+	int eewa_val, ret;
+
+	/*
+	 * wait till the currently occurring EEPROM Write Cycle is completed.
+	 * Only serial commands to the volatile memory are allowed.
+	 */
+	ret = regmap_read_poll_timeout(regmap,
+				       CMD_FORMAT(MCP47FEB02_GAIN_STATUS_REG_ADDR, READ_CMD),
+				       eewa_val, !(eewa_val & MCP47FEB02_GAIN_STATUS_EEWA_MASK),
+				       MCP47FEB02_DELAY_1_MS, MCP47FEB02_DELAY_1_MS * 5);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(regmap, CMD_FORMAT(reg, WRITE_CMD), val);
+
+	return ret;
+}
+
+static ssize_t mcp47feb02_store_eeprom(struct device *dev, struct device_attribute *attr,
+				       const char *buf, size_t len)
+{
+	struct mcp47feb02_data *data = iio_priv(dev_to_iio_dev(dev));
+	int ret, i, val, val1;
+	bool state;
+
+	ret = kstrtobool(buf, &state);
+	if (ret < 0)
+		return ret;
+
+	if (!state)
+		return 0;
+
+	if (!data->have_eeprom) {
+		dev_err(dev, "Device has no eeprom memory.\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Verify DAC Wiper and DAC Configuratioin are unlocked. If both are disabled,
+	 * writing to EEPROM is available.
+	 */
+	ret = regmap_read(data->regmap, CMD_FORMAT(MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR, READ_CMD),
+			  &val);
+	if (ret)
+		return ret;
+
+	if (val)  {
+		dev_err(dev, "DAC Wiper and DAC Configuration not are unlocked.\n");
+		return -EINVAL;
+	}
+
+	for_each_set_bit(i, &data->active_channels_mask, data->phys_channels) {
+		ret = mcp47feb02_write_to_eeprom(data->regmap, MCP47FEB02_NV_DAC0_REG_ADDR + i,
+						 data->chdata[i].dac_data);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_read(data->regmap, CMD_FORMAT(MCP47FEB02_VREF_REG_ADDR, READ_CMD), &val);
+	if (ret)
+		return ret;
+
+	ret = mcp47feb02_write_to_eeprom(data->regmap, MCP47FEB02_NV_VREF_REG_ADDR, val);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap, CMD_FORMAT(MCP47FEB02_POWER_DOWN_REG_ADDR, READ_CMD), &val);
+	if (ret)
+		return ret;
+
+	ret = mcp47feb02_write_to_eeprom(data->regmap, MCP47FEB02_NV_POWER_DOWN_REG_ADDR, val);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap,
+			  CMD_FORMAT(MCP47FEB02_NV_GAIN_I2C_SLAVE_REG_ADDR, READ_CMD), &val);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap,
+			  CMD_FORMAT(MCP47FEB02_GAIN_STATUS_REG_ADDR, READ_CMD), &val1);
+	if (ret)
+		return ret;
+
+	ret = mcp47feb02_write_to_eeprom(data->regmap, MCP47FEB02_NV_GAIN_I2C_SLAVE_REG_ADDR,
+					 (val1 & MCP47FEB02_VOLATILE_GAIN_MASK) |
+					  (val & MCP47FEB02_NV_I2C_SLAVE_ADDR_MASK));
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR(store_eeprom, 0200, NULL, mcp47feb02_store_eeprom, 0);
+static struct attribute *mcp47feb02_attributes[] = {
+	&iio_dev_attr_store_eeprom.dev_attr.attr,
+	NULL,
+};
+
+static int mcp47feb02_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct mcp47feb02_data *data = iio_priv(indio_dev);
+	int ret, ch;
+
+	for_each_set_bit(ch, &data->active_channels_mask, data->phys_channels) {
+		data->chdata[ch].powerdown = true;
+		ret = mcp47feb02_write_to_register(data->regmap, MCP47FEB02_POWER_DOWN_REG_ADDR,
+						   ch, data->chdata[ch].powerdown_mode + 1);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(data->regmap, CMD_FORMAT(ch, WRITE_CMD),
+				   data->chdata[ch].dac_data);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int mcp47feb02_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct mcp47feb02_data *data = iio_priv(indio_dev);
+	int ch, ret;
+
+	for_each_set_bit(ch, &data->active_channels_mask, data->phys_channels) {
+		data->chdata[ch].powerdown = false;
+
+		ret = regmap_write(data->regmap, CMD_FORMAT(ch, WRITE_CMD),
+				   data->chdata[ch].dac_data);
+		if (ret)
+			return ret;
+
+		ret = mcp47feb02_write_to_register(data->regmap, MCP47FEB02_VREF_REG_ADDR,
+						   ch, data->chdata[ch].ref_mode);
+		if (ret)
+			return ret;
+
+		ret = mcp47feb02_write_to_register(data->regmap, MCP47FEB02_GAIN_STATUS_REG_ADDR,
+						   ch, data->chdata[ch].use_2x_gain);
+		if (ret)
+			return ret;
+
+		ret = mcp47feb02_write_to_register(data->regmap, MCP47FEB02_POWER_DOWN_REG_ADDR,
+						   ch, MCP47FEB02_NORMAL_OPERATION);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(mcp47feb02_pm_ops, mcp47feb02_suspend, mcp47feb02_resume);
+
+static const struct attribute_group mcp47feb02_attribute_group = {
+	.attrs = mcp47feb02_attributes,
+};
+
+static const char * const mcp47feb02_powerdown_modes[] = {
+	"1kohm_to_gnd",
+	"100kohm_to_gnd",
+	"open_circuit",
+};
+
+static int mcp47feb02_get_powerdown_mode(struct iio_dev *indio_dev,
+					 const struct iio_chan_spec *chan)
+{
+	struct mcp47feb02_data *data = iio_priv(indio_dev);
+	int bit_set;
+
+	bit_set = test_bit(chan->address, &data->active_channels_mask);
+	if (bit_set)
+		return data->chdata[chan->address].powerdown_mode;
+
+	return -EINVAL;
+}
+
+static int mcp47feb02_set_powerdown_mode(struct iio_dev *indio_dev,
+					 const struct iio_chan_spec *chan, unsigned int mode)
+{
+	struct mcp47feb02_data *data = iio_priv(indio_dev);
+	struct device *dev = &data->client->dev;
+	int bit_set, ret;
+
+	bit_set = test_bit(chan->address, &data->active_channels_mask);
+	if (bit_set) {
+		ret = mcp47feb02_write_to_register(data->regmap, MCP47FEB02_POWER_DOWN_REG_ADDR,
+						   chan->address, mode + 1);
+		if (ret)
+			return ret;
+
+		data->chdata[chan->address].powerdown_mode = mode;
+
+		return 0;
+	}
+
+	dev_err(dev, "Channel %ld not enabled\n", chan->address);
+	return -EINVAL;
+}
+
+static ssize_t mcp47feb02_read_powerdown(struct iio_dev *indio_dev, uintptr_t private,
+					 const struct iio_chan_spec *chan, char *buf)
+{
+	struct mcp47feb02_data *data = iio_priv(indio_dev);
+	int bit_set;
+
+	bit_set = test_bit(chan->address, &data->active_channels_mask);
+	if (bit_set)
+		return sysfs_emit(buf, "%d\n", data->chdata[chan->address].powerdown);
+
+	dev_err(&data->client->dev, "Channel %ld not enabled\n", chan->address);
+	return -EINVAL;
+}
+
+static ssize_t mcp47feb02_write_powerdown(struct iio_dev *indio_dev, uintptr_t private,
+					  const struct iio_chan_spec *chan, const char *buf,
+					  size_t len)
+{
+	struct mcp47feb02_data *data = iio_priv(indio_dev);
+	struct device *dev = &data->client->dev;
+	int bit_set, ret;
+	bool state;
+
+	ret = kstrtobool(buf, &state);
+	if (ret)
+		return ret;
+
+	bit_set = test_bit(chan->address, &data->active_channels_mask);
+	if (bit_set)
+		data->chdata[chan->address].powerdown = state;
+	else
+		dev_err(dev, "Channel %ld not enabled\n", chan->address);
+
+	return len;
+}
+
+static const struct iio_enum mcp47febxx_powerdown_mode_enum = {
+	.items = mcp47feb02_powerdown_modes,
+	.num_items = ARRAY_SIZE(mcp47feb02_powerdown_modes),
+	.get = mcp47feb02_get_powerdown_mode,
+	.set = mcp47feb02_set_powerdown_mode,
+};
+
+static const struct iio_chan_spec_ext_info mcp47feb02_ext_info[] = {
+	{
+		.name = "powerdown",
+		.read = mcp47feb02_read_powerdown,
+		.write = mcp47feb02_write_powerdown,
+		.shared = IIO_SEPARATE,
+	},
+	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &mcp47febxx_powerdown_mode_enum),
+	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE, &mcp47febxx_powerdown_mode_enum),
+	{ },
+};
+
+static const struct iio_chan_spec mcp47febxx_ch_template = {
+	.type = IIO_VOLTAGE,
+	.output = 1,
+	.indexed = 1,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)	|
+			      BIT(IIO_CHAN_INFO_SCALE),
+	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
+	.ext_info = mcp47feb02_ext_info,
+};
+
+static void mcp47feb02_init_scale(const struct mcp47feb02_features *info,
+				  enum mcp47feb02_scale scale, int vref_mv,
+				  int scale_avail[])
+{
+	int value_micro, value_int;
+	s64 tmp;
+
+	tmp = (s64)vref_mv * 1000000LL >> info->resolution;
+	value_int = div_s64_rem(tmp, 1000000LL, &value_micro);
+	scale_avail[scale * 2] = value_int;
+	scale_avail[scale * 2 + 1] = value_micro;
+}
+
+static int mcp47feb02_init_scales_avail(const struct mcp47feb02_features *info,
+					struct mcp47feb02_data *data, int vdd_mv, int vref_mv,
+					int vref1_mv)
+{
+	struct device *dev = &data->client->dev;
+	int tmp_vref;
+
+	if (data->use_vref && vref_mv <= 0) {
+		dev_err(dev, "use_vref set but vref_mv invalid\n");
+		return -EINVAL;
+	}
+
+	mcp47feb02_init_scale(info, MCP47FEB02_SCALE_VDD, vdd_mv, data->scale);
+
+	if (data->use_vref)
+		tmp_vref = vref_mv;
+	else
+		tmp_vref = MCP47FEB02_INTERNAL_BAND_GAP_MV;
+
+	mcp47feb02_init_scale(info, MCP47FEB02_SCALE_GAIN_X1, tmp_vref, data->scale);
+	mcp47feb02_init_scale(info, MCP47FEB02_SCALE_GAIN_X2, tmp_vref * 2, data->scale);
+
+	if (data->phys_channels >= 4) {
+		mcp47feb02_init_scale(info, MCP47FEB02_SCALE_VDD, vdd_mv, data->scale_1);
+
+		if (data->use_vref1 && vref1_mv <= 0) {
+			dev_err(dev, "use_vref1 set but vref1_mv invalid\n");
+			return -EINVAL;
+		}
+
+		if (data->use_vref1)
+			tmp_vref = vref1_mv;
+		else
+			tmp_vref = MCP47FEB02_INTERNAL_BAND_GAP_MV;
+
+		mcp47feb02_init_scale(info, MCP47FEB02_SCALE_GAIN_X1, tmp_vref,
+				      data->scale_1);
+		mcp47feb02_init_scale(info, MCP47FEB02_SCALE_GAIN_X2, tmp_vref * 2,
+				      data->scale_1);
+	}
+
+	return 0;
+}
+
+static int mcp47feb02_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+				 const int **vals, int *type, int *length, long info)
+{
+	struct mcp47feb02_data *data = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			if (data->phys_channels >= 4 && (chan->address % 2))
+				*vals = data->scale_1;
+			else
+				*vals = data->scale;
+
+			*length = MCP47FEB02_MAX_VALS_SCALES_CH;
+			*type = IIO_VAL_INT_PLUS_MICRO;
+			return IIO_AVAIL_LIST;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static void mcp47feb02_get_scale_avail(enum mcp47feb02_scale scale, struct mcp47feb02_data *data,
+				       int *val, int *val2, int channel)
+{
+	if (data->phys_channels >= 4 && (channel % 2)) {
+		*val = data->scale_1[scale * 2];
+		*val2 = data->scale_1[scale * 2 + 1];
+	} else {
+		*val = data->scale[scale * 2];
+		*val2 = data->scale[scale * 2 + 1];
+	}
+}
+
+static void mcp47feb02_get_scale(int channel, struct mcp47feb02_data *data,
+				 int *val, int *val2)
+{
+	if (data->chdata[channel].ref_mode == MCP47FEB02_VREF_VDD)
+		mcp47feb02_get_scale_avail(MCP47FEB02_SCALE_VDD, data, val,
+					   val2, channel);
+	else if (data->chdata[channel].use_2x_gain)
+		mcp47feb02_get_scale_avail(MCP47FEB02_SCALE_GAIN_X2, data, val,
+					   val2, channel);
+	else
+		mcp47feb02_get_scale_avail(MCP47FEB02_SCALE_GAIN_X1, data, val,
+					   val2, channel);
+}
+
+static int mcp47feb02_check_scale(struct mcp47feb02_data *data, int val, int val2,
+				  int scale[])
+{
+	for (int i = 0; i < MCP47FEB02_MAX_SCALES_CH; i++) {
+		if (scale[i * 2] == val && scale[i * 2 + 1] == val2)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int mcp47feb02_ch_scale(int num_channels, struct mcp47feb02_data *data,
+			       int channel, int scale)
+{
+	int tmp_val, ret;
+
+	if (scale == MCP47FEB02_SCALE_VDD) {
+		tmp_val = MCP47FEB02_VREF_VDD;
+	} else if (data->phys_channels >= 4 && (channel % 2)) {
+		if (data->use_vref1) {
+			if (data->vref1_buffered)
+				tmp_val = MCP47FEB02_EXTERNAL_VREF_BUFFERED;
+			else
+				tmp_val = MCP47FEB02_EXTERNAL_VREF_UNBUFFERED;
+		} else {
+			tmp_val = MCP47FEB02_INTERNAL_BAND_GAP;
+		}
+	} else {
+		if (data->use_vref) {
+			if (data->vref_buffered)
+				tmp_val = MCP47FEB02_EXTERNAL_VREF_BUFFERED;
+			else
+				tmp_val = MCP47FEB02_EXTERNAL_VREF_UNBUFFERED;
+		} else {
+			tmp_val = MCP47FEB02_INTERNAL_BAND_GAP;
+		}
+	}
+
+	ret = mcp47feb02_write_to_register(data->regmap, MCP47FEB02_VREF_REG_ADDR,
+					   channel, tmp_val);
+	if (ret)
+		return ret;
+
+	data->chdata[channel].ref_mode = tmp_val;
+
+	return 0;
+}
+
+static int mcp47feb02_set_scale(struct mcp47feb02_data *data, int channel, int scale)
+{
+	int tmp_val, ret;
+
+	mcp47feb02_ch_scale(data->phys_channels, data, channel, scale);
+
+	if (scale == MCP47FEB02_SCALE_GAIN_X2)
+		tmp_val = MCP47FEB02_GAIN_X2;
+	else
+		tmp_val = MCP47FEB02_GAIN_X1;
+
+	ret = mcp47feb02_write_to_register(data->regmap, MCP47FEB02_GAIN_STATUS_REG_ADDR,
+					   channel, tmp_val);
+	if (ret)
+		return ret;
+
+	data->chdata[channel].use_2x_gain = tmp_val;
+
+	return 0;
+}
+
+static int mcp47feb02_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+			       int *val, int *val2, long mask)
+{
+	struct mcp47feb02_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_read(data->regmap, CMD_FORMAT(chan->address, READ_CMD), val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		mcp47feb02_get_scale(chan->address, data, val, val2);
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mcp47feb02_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+				int val, int val2, long mask)
+{
+	struct mcp47feb02_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_write(data->regmap, CMD_FORMAT(chan->address, WRITE_CMD), val);
+		data->chdata[chan->address].dac_data = val;
+		return ret;
+	case IIO_CHAN_INFO_SCALE:
+		if (data->phys_channels >= 4 && (chan->address % 2))
+			ret = mcp47feb02_check_scale(data, val, val2, data->scale_1);
+		else
+			ret = mcp47feb02_check_scale(data, val, val2, data->scale);
+
+		if (ret < 0)
+			return ret;
+
+		return mcp47feb02_set_scale(data, chan->address, ret);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info mcp47feb02_info = {
+	.read_raw = mcp47feb02_read_raw,
+	.write_raw = mcp47feb02_write_raw,
+	.read_avail = &mcp47feb02_read_avail,
+	.attrs = &mcp47feb02_attribute_group,
+};
+
+static const struct iio_info mcp47fvb02_info = {
+	.read_raw = mcp47feb02_read_raw,
+	.write_raw = mcp47feb02_write_raw,
+	.read_avail = &mcp47feb02_read_avail,
+	.attrs = &mcp47feb02_attribute_group,
+};
+
+static int mcp47feb02_parse_fw(struct iio_dev *indio_dev, const struct mcp47feb02_features *info)
+{
+	struct iio_chan_spec chanspec = mcp47febxx_ch_template;
+	struct mcp47feb02_data *data = iio_priv(indio_dev);
+	struct device *dev = &data->client->dev;
+	struct iio_chan_spec *channels;
+	u32 reg, num_channels;
+	int chan_idx = 0;
+
+	num_channels = device_get_child_node_count(dev);
+	if (num_channels > info->phys_channels)
+		return dev_err_probe(dev, -EINVAL, "More channels than the chip supports\n");
+
+	channels = devm_kcalloc(dev, num_channels, sizeof(*channels), GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
+
+	device_for_each_child_node_scoped(dev, child) {
+		fwnode_property_read_u32(child, "reg", &reg);
+
+		if (reg >= info->phys_channels)
+			return dev_err_probe(dev, -EINVAL,
+					     "The index of the channels does not match the chip\n");
+
+		set_bit(reg, &data->active_channels_mask);
+
+		if (fwnode_property_present(child, "label"))
+			fwnode_property_read_string(child, "label",
+						    (const char **)&data->labels[reg]);
+
+		chanspec.address = reg;
+		chanspec.channel = reg;
+		channels[chan_idx] = chanspec;
+		chan_idx++;
+	}
+
+	indio_dev->num_channels = num_channels;
+	indio_dev->channels = channels;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	data->phys_channels = info->phys_channels;
+
+	/*
+	 * check if vref-supply, vref1-supply, microchip,vref-buffered and
+	 * microchip,vref1-buffered are defined in the devicetree
+	 */
+	data->use_vref = device_property_present(dev, "vref-supply");
+	data->use_vref1 = device_property_present(dev, "vref1-supply");
+	data->vref_buffered = device_property_read_bool(dev, "microchip,vref-buffered");
+	data->vref1_buffered = device_property_read_bool(dev, "microchip,vref1-buffered");
+
+	return 0;
+}
+
+static int mcp47feb02_probe(struct i2c_client *client)
+{
+	int err, ret, vdd_mv, vref_mv, vref1_mv, i, tmp_vref, vref_ch, gain_ch;
+	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	const struct mcp47feb02_features *info;
+	enum vref_mode ref_mode, ref_mode1;
+	struct device *dev = &client->dev;
+	struct mcp47feb02_data *data;
+	struct iio_dev *indio_dev;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
+	data->client = client;
+	info = i2c_get_match_data(client);
+
+	if (info->have_eeprom) {
+		data->regmap = devm_regmap_init_i2c(client, &mcp47feb02_regmap_config);
+		data->have_eeprom = true;
+	} else {
+		data->regmap = devm_regmap_init_i2c(client, &mcp47fvb02_regmap_config);
+		data->have_eeprom = false;
+	}
+
+	if (IS_ERR(data->regmap))
+		dev_err_probe(dev, PTR_ERR(data->regmap), "Error initializing i2c regmap\n");
+
+	err = mcp47feb02_parse_fw(indio_dev, info);
+	if (err)
+		return dev_err_probe(dev, err, "Error parsing devicetree data\n");
+
+	if (!info->have_ext_vref2 && data->use_vref1)
+		return dev_err_probe(dev, -EINVAL,
+				     "Second External reference is unavailable on %s\n",
+				     info->name);
+
+	ret = regmap_read(data->regmap, CMD_FORMAT(MCP47FEB02_VREF_REG_ADDR, READ_CMD), &vref_ch);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap, CMD_FORMAT(MCP47FEB02_GAIN_STATUS_REG_ADDR, READ_CMD),
+			  &gain_ch);
+	if (ret)
+		return ret;
+
+	gain_ch = gain_ch >> 8;
+
+	/*
+	 * Values stored in the nonvolatile memory will be transferred to the volatile registers
+	 * at startup. For safety reasons, the user receives a warning if startup values
+	 * do not match the ones from current devicetree configuration.
+	 * Nonvolatile memory can be written at any time
+	 */
+	for_each_set_bit(i, &data->active_channels_mask, data->phys_channels) {
+		/* VDD can be set as Vref only with Gain x1 */
+		if ((vref_ch & 0x03) == MCP47FEB02_VREF_VDD &&
+		    (gain_ch & 0x01) == MCP47FEB02_GAIN_X2) {
+			dev_info(dev, "vdd can be used only with gain x1\n");
+			ret = mcp47feb02_write_to_register(data->regmap,
+							   MCP47FEB02_GAIN_STATUS_REG_ADDR,
+							   i, MCP47FEB02_GAIN_X1);
+			if (ret)
+				return ret;
+
+			data->chdata[i].use_2x_gain = MCP47FEB02_GAIN_X1;
+		}
+
+		if (data->phys_channels >= 4 && (i % 2)) {
+			if ((vref_ch & 0x03) == MCP47FEB02_EXTERNAL_VREF_BUFFERED &&
+			    data->use_vref1 && !data->vref1_buffered)
+				dev_info(dev, "vref1 is unbuffered\n");
+			else if ((vref_ch & 0x03) == MCP47FEB02_EXTERNAL_VREF_UNBUFFERED &&
+				 data->use_vref1 && data->vref1_buffered)
+				dev_info(dev, "vref1 is buffered\n");
+		} else {
+			if ((vref_ch & 0x03) == MCP47FEB02_EXTERNAL_VREF_BUFFERED &&
+			    data->use_vref && !data->vref_buffered)
+				dev_info(dev, "vref is unbuffered\n");
+			else if ((vref_ch & 0x03) == MCP47FEB02_EXTERNAL_VREF_UNBUFFERED &&
+				 data->use_vref && data->vref_buffered)
+				dev_info(dev, "vref is buffered\n");
+		}
+
+		vref_ch = vref_ch >> 2;
+		gain_ch = gain_ch >> 1;
+	}
+
+	if (data->use_vref)
+		ref_mode = data->vref_buffered ?
+			MCP47FEB02_EXTERNAL_VREF_BUFFERED : MCP47FEB02_EXTERNAL_VREF_UNBUFFERED;
+	else
+		ref_mode = MCP47FEB02_INTERNAL_BAND_GAP;
+
+	if (data->use_vref1)
+		ref_mode1 = data->vref1_buffered ?
+			MCP47FEB02_EXTERNAL_VREF_BUFFERED : MCP47FEB02_EXTERNAL_VREF_UNBUFFERED;
+
+	else
+		ref_mode1 =  MCP47FEB02_INTERNAL_BAND_GAP;
+
+	for_each_set_bit(i, &data->active_channels_mask, data->phys_channels) {
+		if (data->phys_channels >= 4 && (i % 2))
+			tmp_vref = ref_mode1;
+		else
+			tmp_vref = ref_mode;
+
+		ret = mcp47feb02_write_to_register(data->regmap, MCP47FEB02_VREF_REG_ADDR,
+						   i, tmp_vref);
+		if (ret)
+			return ret;
+
+		data->chdata[i].ref_mode = tmp_vref;
+	}
+
+	indio_dev->name = id->name;
+	if (info->have_eeprom)
+		indio_dev->info = &mcp47feb02_info;
+	else
+		indio_dev->info = &mcp47fvb02_info;
+
+	ret = devm_mutex_init(dev, &data->lock);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_regulator_get_enable_read_voltage(dev, "vdd");
+	if (ret < 0)
+		return ret;
+
+	vdd_mv = ret / 1000;
+
+	if (data->use_vref) {
+		ret = devm_regulator_get_enable_read_voltage(dev, "vref");
+		if (ret < 0)
+			return ret;
+
+		vref_mv = ret / 1000;
+	}
+
+	if (data->use_vref1) {
+		ret = devm_regulator_get_enable_read_voltage(dev, "vref1");
+		if (ret < 0)
+			return ret;
+
+		vref1_mv = ret / 1000;
+	}
+
+	for_each_set_bit(i, &data->active_channels_mask, data->phys_channels) {
+		ret = mcp47feb02_init_scales_avail(info, data, vdd_mv, vref_mv, vref1_mv);
+		if (ret)
+			dev_err_probe(dev, ret, "failed to init scales for ch i %d\n", i);
+	}
+
+	err = iio_device_register(indio_dev);
+
+	return err;
+}
+
+static void mcp47feb02_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+
+	iio_device_unregister(indio_dev);
+}
+
+static const struct i2c_device_id mcp47feb02_id[] = {
+	{ "mcp47feb01", (kernel_ulong_t)&mcp47feb01_chip_info },
+	{ "mcp47feb11", (kernel_ulong_t)&mcp47feb11_chip_info },
+	{ "mcp47feb21", (kernel_ulong_t)&mcp47feb21_chip_info },
+	{ "mcp47feb02", (kernel_ulong_t)&mcp47feb02_chip_info },
+	{ "mcp47feb12", (kernel_ulong_t)&mcp47feb12_chip_info },
+	{ "mcp47feb22", (kernel_ulong_t)&mcp47feb22_chip_info },
+	{ "mcp47feb04", (kernel_ulong_t)&mcp47feb04_chip_info },
+	{ "mcp47feb14", (kernel_ulong_t)&mcp47feb14_chip_info },
+	{ "mcp47feb24", (kernel_ulong_t)&mcp47feb24_chip_info },
+	{ "mcp47feb08", (kernel_ulong_t)&mcp47feb08_chip_info },
+	{ "mcp47feb18", (kernel_ulong_t)&mcp47feb18_chip_info },
+	{ "mcp47feb28", (kernel_ulong_t)&mcp47feb28_chip_info },
+	{ "mcp47fvb01", (kernel_ulong_t)&mcp47fvb01_chip_info },
+	{ "mcp47fvb11", (kernel_ulong_t)&mcp47fvb11_chip_info },
+	{ "mcp47fvb21", (kernel_ulong_t)&mcp47fvb21_chip_info },
+	{ "mcp47fvb02", (kernel_ulong_t)&mcp47fvb02_chip_info },
+	{ "mcp47fvb12", (kernel_ulong_t)&mcp47fvb12_chip_info },
+	{ "mcp47fvb22", (kernel_ulong_t)&mcp47fvb22_chip_info },
+	{ "mcp47fvb04", (kernel_ulong_t)&mcp47fvb04_chip_info },
+	{ "mcp47fvb14", (kernel_ulong_t)&mcp47fvb14_chip_info },
+	{ "mcp47fvb24", (kernel_ulong_t)&mcp47fvb24_chip_info },
+	{ "mcp47fvb08", (kernel_ulong_t)&mcp47fvb08_chip_info },
+	{ "mcp47fvb18", (kernel_ulong_t)&mcp47fvb18_chip_info },
+	{ "mcp47fvb28", (kernel_ulong_t)&mcp47fvb28_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mcp47feb02_id);
+
+static const struct of_device_id mcp47feb02_of_match[] = {
+	{ .compatible = "microchip,mcp47feb01", .data = &mcp47feb01_chip_info },
+	{ .compatible = "microchip,mcp47feb11", .data = &mcp47feb11_chip_info },
+	{ .compatible = "microchip,mcp47feb21", .data = &mcp47feb21_chip_info },
+	{ .compatible = "microchip,mcp47feb02", .data = &mcp47feb02_chip_info },
+	{ .compatible = "microchip,mcp47feb12", .data = &mcp47feb12_chip_info },
+	{ .compatible = "microchip,mcp47feb22", .data = &mcp47feb22_chip_info },
+	{ .compatible = "microchip,mcp47feb04", .data = &mcp47feb04_chip_info },
+	{ .compatible = "microchip,mcp47feb14", .data = &mcp47feb14_chip_info },
+	{ .compatible = "microchip,mcp47feb24", .data = &mcp47feb24_chip_info },
+	{ .compatible = "microchip,mcp47feb08", .data = &mcp47feb08_chip_info },
+	{ .compatible = "microchip,mcp47feb18", .data = &mcp47feb18_chip_info },
+	{ .compatible = "microchip,mcp47feb28", .data = &mcp47feb28_chip_info },
+	{ .compatible = "microchip,mcp47fvb01", .data = &mcp47fvb01_chip_info },
+	{ .compatible = "microchip,mcp47fvb11", .data = &mcp47fvb11_chip_info },
+	{ .compatible = "microchip,mcp47fvb21", .data = &mcp47fvb21_chip_info },
+	{ .compatible = "microchip,mcp47fvb02", .data = &mcp47fvb02_chip_info },
+	{ .compatible = "microchip,mcp47fvb12", .data = &mcp47fvb12_chip_info },
+	{ .compatible = "microchip,mcp47fvb22", .data = &mcp47fvb22_chip_info },
+	{ .compatible = "microchip,mcp47fvb04", .data = &mcp47fvb04_chip_info },
+	{ .compatible = "microchip,mcp47fvb14",	.data = &mcp47fvb14_chip_info },
+	{ .compatible = "microchip,mcp47fvb24", .data = &mcp47fvb24_chip_info },
+	{ .compatible = "microchip,mcp47fvb08", .data = &mcp47fvb08_chip_info },
+	{ .compatible = "microchip,mcp47fvb18", .data = &mcp47fvb18_chip_info },
+	{ .compatible = "microchip,mcp47fvb28", .data = &mcp47fvb28_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mcp47feb02_of_match);
+
+static struct i2c_driver mcp47feb02_driver = {
+	.driver = {
+		.name	= "mcp47feb02",
+		.of_match_table = mcp47feb02_of_match,
+		.pm	= pm_sleep_ptr(&mcp47feb02_pm_ops),
+	},
+	.probe		= mcp47feb02_probe,
+	.remove		= mcp47feb02_remove,
+	.id_table	= mcp47feb02_id,
+};
+module_i2c_driver(mcp47feb02_driver);
+
+MODULE_AUTHOR("Ariana Lazar <ariana.lazar@microchip.com>");
+MODULE_DESCRIPTION("IIO driver for MCP47FEB02 Multi-Channel DAC with I2C interface");
+MODULE_LICENSE("GPL");

-- 
2.43.0


