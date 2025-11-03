Return-Path: <linux-iio+bounces-25864-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CB7C30181
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 09:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 466C234E2FF
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 08:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621BF2E9755;
	Tue,  4 Nov 2025 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="twNUbWjK"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7092BE032;
	Tue,  4 Nov 2025 08:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246594; cv=none; b=lFata2gKiL436r0arlG9jnPZtbVMV8F8rZAIyCNHdxKPz3xrfpz/yy1p3FvJNsFp4nfoo8Sgk0NmwE5Vvhdg6oO2hZ7po0rjoDF6BsN41181LLb97QHM3x7mitCqo0YZWMkQ4rRnjLNZjq9dT0sC6kNVXDwMnpzF9aHRQAdhSkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246594; c=relaxed/simple;
	bh=4EmK6KXqb5qibPEtx932m+NfhyTbFlNE92Xhc40W+wM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eN2PhfWlF2iJsf1uLjmcdiap+mw6siiUGdYRvIBiFrwyiYKLzasUi5AfjTiid98p3D5zZwxosaKawHGEn7Y3Od4W/HMNVcCTfv4w/NF4yGYK0Iupfj15vY0WPBv3HLV/R4EJFsUPWpieWd4FnnsK0cDfnEbu2ppQYnIx2/+OtVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=twNUbWjK; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1762246591; x=1793782591;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=4EmK6KXqb5qibPEtx932m+NfhyTbFlNE92Xhc40W+wM=;
  b=twNUbWjKukBBqNJKbAAnqSJnDc4xWgZjC5Mv+WqAhBdVv1FFCVYnGqJT
   CKQtXvK+rxIEycxx+eiileYpArvb2ls5P2LwRaMyYZ/AJ7v7oSujWBOYS
   YTKQsdTYwOMOlHLBJkvWX5dlEjvJ8nMaKFFBB6R/KxXtOaC4uWE/0eJmH
   ffc/XozYfJZayrIU/kZncMEY5dukd6qt9XMWyV5DsN5NetA5PaELBHvP9
   vdiPhGN9AuCZDN+ufdQFMVOP1wHrys17m9d2c9vb9UkHj5fZI678Ivkit
   b6Hh5oHotUAUOiwAjogB4CL+rdQf4XTE7bCgUJSTtMqYxSOLQk1eZve+u
   w==;
X-CSE-ConnectionGUID: ah0thdEYRoWg7Z9edIgL+Q==
X-CSE-MsgGUID: WfjLDgefTq24g3IgPgDA/w==
X-IronPort-AV: E=Sophos;i="6.19,278,1754982000"; 
   d="scan'208";a="48018755"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 01:56:29 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Tue, 4 Nov 2025 01:55:54 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 4 Nov 2025 01:55:51 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Mon, 3 Nov 2025 17:50:30 +0200
Subject: [PATCH v2 2/2] iio: dac: adding support for Microchip MCP47FEB02
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20251103-mcp47feb02-v2-2-8c37741bd97a@microchip.com>
References: <20251103-mcp47feb02-v2-0-8c37741bd97a@microchip.com>
In-Reply-To: <20251103-mcp47feb02-v2-0-8c37741bd97a@microchip.com>
To: Ariana Lazar <ariana.lazar@microchip.com>, Jonathan Cameron
	<jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762185039; l=42784;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=4EmK6KXqb5qibPEtx932m+NfhyTbFlNE92Xhc40W+wM=;
 b=aUBzgawBPG4QUIEiFedV63vb6viI/dDd2ScPqbfx0hzKGcUZoXD3R8+p45G4yPtP6vVzWKwmC
 E+HxtTYed2aDfvOtrEjGWjBrJlFCkrQ1T0tux8vo+leR3/lqF3bxwfT
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

This is the iio driver for Microchip MCP47F(E/V)B(0/1/2)1,
MCP47F(E/V)B(0/1/2)2, MCP47F(E/V)B(0/1/2)4 and MCP47F(E/V)B(0/1/2)8 series
of buffered voltage output Digital-to-Analog Converters with nonvolatile or
volatile memory and an I2C Interface.

The families support up to 8 output channels.

The devices can be 8-bit, 10-bit and 12-bit.

Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 MAINTAINERS                  |    1 +
 drivers/iio/dac/Kconfig      |   16 +
 drivers/iio/dac/Makefile     |    1 +
 drivers/iio/dac/mcp47feb02.c | 1233 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1251 insertions(+)

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
index 0000000000000000000000000000000000000000..69f5ebbc89aed8ce229cd0c6a37ca58f8a822d46
--- /dev/null
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -0,0 +1,1233 @@
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
+#define MCP47FEB02_DAC0_REG_ADDR			(0x00 << 3)
+#define MCP47FEB02_VREF_REG_ADDR			(0x08 << 3)
+#define MCP47FEB02_POWER_DOWN_REG_ADDR			(0x09 << 3)
+#define MCP47FEB02_GAIN_BIT_STATUS_REG_ADDR		(0x0A << 3)
+#define MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR		(0x0B << 3)
+
+#define MCP47FEB02_NV_DAC0_REG_ADDR			(0x10 << 3)
+#define MCP47FEB02_NV_DAC1_REG_ADDR			(0x11 << 3)
+#define MCP47FEB02_NV_DAC2_REG_ADDR			(0x12 << 3)
+#define MCP47FEB02_NV_DAC3_REG_ADDR			(0x13 << 3)
+#define MCP47FEB02_NV_DAC4_REG_ADDR			(0x14 << 3)
+#define MCP47FEB02_NV_DAC5_REG_ADDR			(0x15 << 3)
+#define MCP47FEB02_NV_DAC6_REG_ADDR			(0x16 << 3)
+#define MCP47FEB02_NV_DAC7_REG_ADDR			(0x17 << 3)
+#define MCP47FEB02_NV_VREF_REG_ADDR			(0x18 << 3)
+#define MCP47FEB02_NV_POWER_DOWN_REG_ADDR		(0x19 << 3)
+#define MCP47FEB02_NV_GAIN_BIT_I2C_SLAVE_REG_ADDR	(0x1A << 3)
+
+#define MCP47FEBXX_MAX_CH				8
+#define MCP47FEB02_GAIN_BIT_X1				0
+#define MCP47FEB02_GAIN_BIT_X2				1
+#define MCP47FEB02_MAX_VALS_SCALES_CH			6
+#define MCP47FEB02_MAX_SCALES_CH			3
+#define MCP47FEB02_DAC_WIPER_UNLOCKED			0
+#define MCP47FEB02_INTERNAL_BAND_GAP_MV			2440
+#define MCP47FEB02_DELAY_1_MS				1000
+
+#define SET_DAC_CTRL_MASK				GENMASK(1, 0)
+#define SET_GAIN_BIT					BIT(0)
+#define READFLAG_MASK					GENMASK(2, 1)
+#define MCP47FEB02_GAIN_BIT_STATUS_EEWA_MASK		BIT(6)
+#define MCP47FEB02_VOLATILE_GAIN_BIT_MASK		GENMASK(15, 8)
+#define MCP47FEB02_NV_I2C_SLAVE_ADDR_MASK		GENMASK(7, 0)
+
+/* Voltage reference, Power-Down control register and DAC Wiperlock status register fields */
+#define DAC_CTRL_MASK(ch)				(GENMASK(1, 0) << (2 * (ch)))
+#define DAC_CTRL_VAL(ch, val)				((val) << (2 * (ch)))
+
+/* Gain Control and I2C Slave Address Reguster fields */
+#define DAC_GAIN_MASK(ch)				(BIT(0) << (8 + (ch)))
+#define DAC_GAIN_VAL(ch, val)				((val) << (8 + (ch)))
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
+	MCP47FEB02_SCALE_GAIN_BIT_X1 = 1,
+	MCP47FEB02_SCALE_GAIN_BIT_X2 = 2,
+};
+
+enum iio_powerdown_mode {
+	MCP47FEB02_NORMAL_OPERATION = 0,
+	MCP47FEB02_IIO_1K = 1,
+	MCP47FEB02_IIO_100K = 2,
+	MCP47FEB02_OPEN_CIRCUIT = 3,
+};
+
+static const char * const mcp47feb02_powerdown_modes[] = {
+	"1kohm_to_gnd",
+	"100kohm_to_gnd",
+	"open_circuit",
+};
+
+/**
+ * struct mcp47feb02_features - chip specific data
+ * @name:		device name
+ * @phys_channels:	number of hardware channels
+ * @resolution:		DAC resolution
+ * @have_ext_vref1:	does the hardware have an the second external voltage reference?
+ * @have_eeprom:	does the hardware have an internal eeprom?
+ */
+struct mcp47feb02_features {
+	const char	*name;
+	unsigned int	phys_channels;
+	unsigned int	resolution;
+	bool have_ext_vref1;
+	bool have_eeprom;
+};
+
+static const struct mcp47feb02_features mcp47feb01_chip_info = {
+	.name = "mcp47feb01",
+	.phys_channels = 1,
+	.resolution = 8,
+	.have_ext_vref1 = false,
+	.have_eeprom = true,
+};
+
+static const struct mcp47feb02_features mcp47feb11_chip_info = {
+	.name = "mcp47feb11",
+	.phys_channels = 1,
+	.resolution = 10,
+	.have_ext_vref1 = false,
+	.have_eeprom = true,
+};
+
+static const struct mcp47feb02_features mcp47feb21_chip_info = {
+	.name = "mcp47feb21",
+	.phys_channels = 1,
+	.resolution = 12,
+	.have_ext_vref1 = false,
+	.have_eeprom = true,
+};
+
+static const struct mcp47feb02_features mcp47feb02_chip_info = {
+	.name = "mcp47feb02",
+	.phys_channels = 2,
+	.resolution = 8,
+	.have_ext_vref1 = false,
+	.have_eeprom = true,
+};
+
+static const struct mcp47feb02_features mcp47feb12_chip_info = {
+	.name = "mcp47feb12",
+	.phys_channels = 2,
+	.resolution = 10,
+	.have_ext_vref1 = false,
+	.have_eeprom = true,
+};
+
+static const struct mcp47feb02_features mcp47feb22_chip_info = {
+	.name = "mcp47feb22",
+	.phys_channels = 2,
+	.resolution = 12,
+	.have_ext_vref1 = false,
+	.have_eeprom = true,
+};
+
+static const struct mcp47feb02_features mcp47feb04_chip_info = {
+	.name = "mcp47feb04",
+	.phys_channels = 4,
+	.resolution = 8,
+	.have_ext_vref1 = true,
+	.have_eeprom = true,
+};
+
+static const struct mcp47feb02_features mcp47feb14_chip_info = {
+	.name = "mcp47feb14",
+	.phys_channels = 4,
+	.resolution = 10,
+	.have_ext_vref1 = true,
+	.have_eeprom = true,
+};
+
+static const struct mcp47feb02_features mcp47feb24_chip_info = {
+	.name = "mcp47feb24",
+	.phys_channels = 4,
+	.resolution = 12,
+	.have_ext_vref1 = true,
+	.have_eeprom = true,
+};
+
+static const struct mcp47feb02_features mcp47feb08_chip_info = {
+	.name = "mcp47feb08",
+	.phys_channels = 8,
+	.resolution = 8,
+	.have_ext_vref1 = true,
+	.have_eeprom = true,
+};
+
+static const struct mcp47feb02_features mcp47feb18_chip_info = {
+	.name = "mcp47feb18",
+	.phys_channels = 8,
+	.resolution = 10,
+	.have_ext_vref1 = true,
+	.have_eeprom = true,
+};
+
+static const struct mcp47feb02_features mcp47feb28_chip_info = {
+	.name = "mcp47feb28",
+	.phys_channels = 8,
+	.resolution = 12,
+	.have_ext_vref1 = true,
+	.have_eeprom = true,
+};
+
+static const struct mcp47feb02_features mcp47fvb01_chip_info = {
+	.name = "mcp47fvb01",
+	.phys_channels = 1,
+	.resolution = 8,
+	.have_ext_vref1 = false,
+	.have_eeprom = false,
+};
+
+static const struct mcp47feb02_features mcp47fvb11_chip_info = {
+	.name = "mcp47fvb11",
+	.phys_channels = 1,
+	.resolution = 10,
+	.have_ext_vref1 = false,
+	.have_eeprom = false,
+};
+
+static const struct mcp47feb02_features mcp47fvb21_chip_info = {
+	.name = "mcp47fvb21",
+	.phys_channels = 1,
+	.resolution = 12,
+	.have_ext_vref1 = false,
+	.have_eeprom = false,
+};
+
+static const struct mcp47feb02_features mcp47fvb02_chip_info = {
+	.name = "mcp47fvb02",
+	.phys_channels = 2,
+	.resolution = 8,
+	.have_ext_vref1 = false,
+	.have_eeprom = false,
+};
+
+static const struct mcp47feb02_features mcp47fvb12_chip_info = {
+	.name = "mcp47fvb12",
+	.phys_channels = 2,
+	.resolution = 8,
+	.have_ext_vref1 = false,
+	.have_eeprom = false,
+};
+
+static const struct mcp47feb02_features mcp47fvb22_chip_info = {
+	.name = "mcp47fvb22",
+	.phys_channels = 2,
+	.resolution = 12,
+	.have_ext_vref1 = false,
+	.have_eeprom = false,
+};
+
+static const struct mcp47feb02_features mcp47fvb04_chip_info = {
+	.name = "mcp47fvb04",
+	.phys_channels = 4,
+	.resolution = 8,
+	.have_ext_vref1 = true,
+	.have_eeprom = false,
+};
+
+static const struct mcp47feb02_features mcp47fvb14_chip_info = {
+	.name = "mcp47fvb14",
+	.phys_channels = 4,
+	.resolution = 10,
+	.have_ext_vref1 = true,
+	.have_eeprom = false,
+};
+
+static const struct mcp47feb02_features mcp47fvb24_chip_info = {
+	.name = "mcp47fvb24",
+	.phys_channels = 4,
+	.resolution = 12,
+	.have_ext_vref1 = true,
+	.have_eeprom = false,
+};
+
+static const struct mcp47feb02_features mcp47fvb08_chip_info = {
+	.name = "mcp47fvb08",
+	.phys_channels = 8,
+	.resolution = 8,
+	.have_ext_vref1 = true,
+	.have_eeprom = false,
+};
+
+static const struct mcp47feb02_features mcp47fvb18_chip_info = {
+	.name = "mcp47fvb18",
+	.phys_channels = 8,
+	.resolution = 10,
+	.have_ext_vref1 = true,
+	.have_eeprom = false,
+};
+
+static const struct mcp47feb02_features mcp47fvb28_chip_info = {
+	.name = "mcp47fvb28",
+	.phys_channels = 4,
+	.resolution = 8,
+	.have_ext_vref1 = true,
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
+ * @info: pointer to features struct
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
+ */
+struct mcp47feb02_data {
+	struct mcp47feb02_channel_data chdata[MCP47FEBXX_MAX_CH];
+	int scale_1[MCP47FEB02_MAX_VALS_SCALES_CH];
+	int scale[MCP47FEB02_MAX_VALS_SCALES_CH];
+	const struct mcp47feb02_features *info;
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
+};
+
+static const struct regmap_range mcp47feb02_readable_ranges[] = {
+	regmap_reg_range(MCP47FEB02_DAC0_REG_ADDR, MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR),
+	regmap_reg_range(MCP47FEB02_NV_DAC0_REG_ADDR, MCP47FEB02_NV_GAIN_BIT_I2C_SLAVE_REG_ADDR),
+};
+
+static const struct regmap_range mcp47feb02_writable_ranges[] = {
+	regmap_reg_range(MCP47FEB02_DAC0_REG_ADDR, MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR),
+	regmap_reg_range(MCP47FEB02_NV_DAC0_REG_ADDR, MCP47FEB02_NV_GAIN_BIT_I2C_SLAVE_REG_ADDR),
+};
+
+static const struct regmap_range mcp47feb02_volatile_ranges[] = {
+	regmap_reg_range(MCP47FEB02_DAC0_REG_ADDR, MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR),
+	regmap_reg_range(MCP47FEB02_NV_DAC0_REG_ADDR, MCP47FEB02_NV_GAIN_BIT_I2C_SLAVE_REG_ADDR),
+	regmap_reg_range(MCP47FEB02_DAC0_REG_ADDR, MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR),
+	regmap_reg_range(MCP47FEB02_NV_DAC0_REG_ADDR, MCP47FEB02_NV_GAIN_BIT_I2C_SLAVE_REG_ADDR),
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
+	.max_register =  MCP47FEB02_NV_GAIN_BIT_I2C_SLAVE_REG_ADDR,
+	.read_flag_mask	= READFLAG_MASK,
+	.cache_type = REGCACHE_MAPLE,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+};
+
+/* For devices that doesn't have nonvolatile memory */
+static const struct regmap_range mcp47fvb02_readable_ranges[] = {
+	regmap_reg_range(MCP47FEB02_DAC0_REG_ADDR, MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR),
+};
+
+static const struct regmap_range mcp47fvb02_writable_ranges[] = {
+	regmap_reg_range(MCP47FEB02_DAC0_REG_ADDR, MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR),
+};
+
+static const struct regmap_range mcp47fvb02_volatile_ranges[] = {
+	regmap_reg_range(MCP47FEB02_DAC0_REG_ADDR, MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR),
+	regmap_reg_range(MCP47FEB02_DAC0_REG_ADDR, MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR),
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
+	.max_register = MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR,
+	.read_flag_mask	= READFLAG_MASK,
+	.cache_type = REGCACHE_MAPLE,
+	.val_format_endian = REGMAP_ENDIAN_BIG,
+};
+
+static int mcp47feb02_write_to_eeprom(struct mcp47feb02_data *data, unsigned int reg,
+				      unsigned int val)
+{
+	int eewa_val, ret;
+
+	/*
+	 * Wait till the currently occurring EEPROM Write Cycle is completed.
+	 * Only serial commands to the volatile memory are allowed.
+	 */
+	guard(mutex)(&data->lock);
+
+	ret = regmap_read_poll_timeout(data->regmap, MCP47FEB02_GAIN_BIT_STATUS_REG_ADDR,
+				       eewa_val,
+				       !(eewa_val & MCP47FEB02_GAIN_BIT_STATUS_EEWA_MASK),
+				       MCP47FEB02_DELAY_1_MS, MCP47FEB02_DELAY_1_MS * 5);
+	if (ret)
+		return ret;
+
+	return regmap_write(data->regmap, reg, val);
+}
+
+static ssize_t mcp47feb02_store_eeprom(struct device *dev, struct device_attribute *attr,
+				       const char *buf, size_t len)
+{
+	struct mcp47feb02_data *data = iio_priv(dev_to_iio_dev(dev));
+	int ret, i, val, val1, eewa_val;
+	bool state;
+
+	ret = kstrtobool(buf, &state);
+	if (ret < 0)
+		return ret;
+
+	if (!state)
+		return 0;
+
+	/*
+	 * Verify DAC Wiper and DAC Configuratioin are unlocked. If both are disabled,
+	 * writing to EEPROM is available.
+	 */
+	ret = regmap_read(data->regmap, MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR, &val);
+	if (ret)
+		return ret;
+
+	if (val)  {
+		dev_err(dev, "DAC Wiper and DAC Configuration not are unlocked.\n");
+		return -EINVAL;
+	}
+
+	for_each_set_bit(i, &data->active_channels_mask, data->phys_channels) {
+		ret = mcp47feb02_write_to_eeprom(data, i << 3, data->chdata[i].dac_data);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_read(data->regmap, MCP47FEB02_VREF_REG_ADDR, &val);
+	if (ret)
+		return ret;
+
+	ret = mcp47feb02_write_to_eeprom(data, MCP47FEB02_NV_VREF_REG_ADDR, val);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap, MCP47FEB02_POWER_DOWN_REG_ADDR, &val);
+	if (ret)
+		return ret;
+
+	ret = mcp47feb02_write_to_eeprom(data, MCP47FEB02_NV_POWER_DOWN_REG_ADDR, val);
+	if (ret)
+		return ret;
+
+	ret = regmap_read_poll_timeout(data->regmap, MCP47FEB02_GAIN_BIT_STATUS_REG_ADDR, eewa_val,
+				       !(eewa_val & MCP47FEB02_GAIN_BIT_STATUS_EEWA_MASK),
+				       MCP47FEB02_DELAY_1_MS, MCP47FEB02_DELAY_1_MS * 5);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap, MCP47FEB02_NV_GAIN_BIT_I2C_SLAVE_REG_ADDR, &val);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap, MCP47FEB02_GAIN_BIT_STATUS_REG_ADDR, &val1);
+	if (ret)
+		return ret;
+
+	ret = mcp47feb02_write_to_eeprom(data, MCP47FEB02_NV_GAIN_BIT_I2C_SLAVE_REG_ADDR,
+					 (val1 & MCP47FEB02_VOLATILE_GAIN_BIT_MASK) |
+					 (val & MCP47FEB02_NV_I2C_SLAVE_ADDR_MASK));
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR(store_eeprom, 0200, NULL, mcp47feb02_store_eeprom, 0);
+static struct attribute *mcp47feb02_attributes[] = {
+	&iio_dev_attr_store_eeprom.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group mcp47feb02_attribute_group = {
+	.attrs = mcp47feb02_attributes,
+};
+
+static int mcp47feb02_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct mcp47feb02_data *data = iio_priv(indio_dev);
+	int ret, ch;
+	u8 pd_mode;
+
+	guard(mutex)(&data->lock);
+
+	for_each_set_bit(ch, &data->active_channels_mask, data->phys_channels) {
+		data->chdata[ch].powerdown = true;
+		pd_mode = data->chdata[ch].powerdown_mode + 1;
+		regmap_update_bits(data->regmap, MCP47FEB02_POWER_DOWN_REG_ADDR,
+				   DAC_CTRL_MASK(ch), DAC_CTRL_VAL(ch, pd_mode));
+		if (ret)
+			return ret;
+
+		ret = regmap_write(data->regmap, ch << 3, data->chdata[ch].dac_data);
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
+	u8 pd_mode;
+
+	guard(mutex)(&data->lock);
+
+	for_each_set_bit(ch, &data->active_channels_mask, data->phys_channels) {
+		data->chdata[ch].powerdown = false;
+		pd_mode = data->chdata[ch].powerdown_mode + 1;
+
+		ret = regmap_write(data->regmap, ch << 3, data->chdata[ch].dac_data);
+		if (ret)
+			return ret;
+
+		ret = regmap_update_bits(data->regmap, MCP47FEB02_VREF_REG_ADDR,
+					 DAC_CTRL_MASK(ch), DAC_CTRL_VAL(ch, pd_mode));
+		if (ret)
+			return ret;
+
+		ret = regmap_update_bits(data->regmap, MCP47FEB02_GAIN_BIT_STATUS_REG_ADDR,
+					 DAC_GAIN_MASK(ch),
+					 DAC_GAIN_VAL(ch, data->chdata[ch].use_2x_gain));
+		if (ret)
+			return ret;
+
+		ret = regmap_update_bits(data->regmap, MCP47FEB02_POWER_DOWN_REG_ADDR,
+					 DAC_CTRL_MASK(ch),
+					 DAC_CTRL_VAL(ch, MCP47FEB02_NORMAL_OPERATION));
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int mcp47feb02_get_powerdown_mode(struct iio_dev *indio_dev,
+					 const struct iio_chan_spec *chan)
+{
+	struct mcp47feb02_data *data = iio_priv(indio_dev);
+
+	return data->chdata[chan->address].powerdown_mode;
+}
+
+static int mcp47feb02_set_powerdown_mode(struct iio_dev *indio_dev, const struct iio_chan_spec *ch,
+					 unsigned int mode)
+{
+	struct mcp47feb02_data *data = iio_priv(indio_dev);
+
+	data->chdata[ch->address].powerdown_mode = mode;
+
+	return 0;
+}
+
+static ssize_t mcp47feb02_read_powerdown(struct iio_dev *indio_dev, uintptr_t private,
+					 const struct iio_chan_spec *ch, char *buf)
+{
+	struct mcp47feb02_data *data = iio_priv(indio_dev);
+
+	/* Check if channel is in a power-down mode or not */
+	return sysfs_emit(buf, "%d\n", data->chdata[ch->address].powerdown);
+}
+
+static ssize_t mcp47feb02_write_powerdown(struct iio_dev *indio_dev, uintptr_t private,
+					  const struct iio_chan_spec *ch, const char *buf,
+					  size_t len)
+{
+	struct mcp47feb02_data *data = iio_priv(indio_dev);
+	unsigned long reg;
+	u8 tmp_pd_mode;
+	bool state;
+	int ret;
+
+	guard(mutex)(&data->lock);
+
+	ret = kstrtobool(buf, &state);
+	if (ret)
+		return ret;
+
+	reg = ch->address;
+
+	/*
+	 * Set channel to the power-down mode selected. Normal operation mode (0000h)
+	 * must be written to register in order to exit  power-down mode.
+	 */
+	tmp_pd_mode = state ? (data->chdata[reg].powerdown_mode + 1) : MCP47FEB02_NORMAL_OPERATION;
+	ret = regmap_update_bits(data->regmap, MCP47FEB02_POWER_DOWN_REG_ADDR,
+				 DAC_CTRL_MASK(reg), DAC_CTRL_VAL(reg, tmp_pd_mode));
+	if (ret)
+		return ret;
+
+	data->chdata[reg].powerdown = state;
+
+	return len;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(mcp47feb02_pm_ops, mcp47feb02_suspend, mcp47feb02_resume);
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
+	{ }
+};
+
+static const struct iio_chan_spec mcp47febxx_ch_template = {
+	.type = IIO_VOLTAGE,
+	.output = 1,
+	.indexed = 1,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SCALE),
+	.ext_info = mcp47feb02_ext_info,
+};
+
+static void mcp47feb02_init_scale(struct mcp47feb02_data *data, enum mcp47feb02_scale scale,
+				  int vref_mv, int scale_avail[])
+{
+	int value_micro, value_int;
+	s64 tmp;
+
+	tmp = (s64)vref_mv * 1000000LL >> data->info->resolution;
+	value_int = div_s64_rem(tmp, 1000000LL, &value_micro);
+	scale_avail[scale * 2] = value_int;
+	scale_avail[scale * 2 + 1] = value_micro;
+}
+
+static int mcp47feb02_init_scales_avail(struct mcp47feb02_data *data, int vdd_mv,
+					int vref_mv, int vref1_mv)
+{
+	struct device *dev = &data->client->dev;
+	int tmp_vref;
+
+	mcp47feb02_init_scale(data, MCP47FEB02_SCALE_VDD, vdd_mv, data->scale);
+
+	if (data->use_vref)
+		tmp_vref = vref_mv;
+	else
+		tmp_vref = MCP47FEB02_INTERNAL_BAND_GAP_MV;
+
+	mcp47feb02_init_scale(data, MCP47FEB02_SCALE_GAIN_BIT_X1, tmp_vref, data->scale);
+	mcp47feb02_init_scale(data, MCP47FEB02_SCALE_GAIN_BIT_X2, tmp_vref * 2, data->scale);
+
+	if (data->phys_channels >= 4) {
+		mcp47feb02_init_scale(data, MCP47FEB02_SCALE_VDD, vdd_mv, data->scale_1);
+
+		if (data->use_vref1 && vref1_mv <= 0)
+			return dev_err_probe(dev, -EINVAL, "Invalid voltage for Vref1\n");
+
+		if (data->use_vref1)
+			tmp_vref = vref1_mv;
+		else
+			tmp_vref = MCP47FEB02_INTERNAL_BAND_GAP_MV;
+
+		mcp47feb02_init_scale(data, MCP47FEB02_SCALE_GAIN_BIT_X1,
+				      tmp_vref, data->scale_1);
+		mcp47feb02_init_scale(data, MCP47FEB02_SCALE_GAIN_BIT_X2,
+				      tmp_vref * 2, data->scale_1);
+	}
+
+	return 0;
+}
+
+static int mcp47feb02_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec const *ch,
+				 const int **vals, int *type, int *length, long info)
+{
+	struct mcp47feb02_data *data = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_SCALE:
+		switch (ch->type) {
+		case IIO_VOLTAGE:
+			if (data->phys_channels >= 4 && (ch->address % 2))
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
+static void mcp47feb02_get_scale_avail(struct mcp47feb02_data *data, int *val, int *val2,
+				       enum mcp47feb02_scale scale, int ch)
+{
+	if (data->phys_channels >= 4 && (ch % 2)) {
+		*val = data->scale_1[scale * 2];
+		*val2 = data->scale_1[scale * 2 + 1];
+	} else {
+		*val = data->scale[scale * 2];
+		*val2 = data->scale[scale * 2 + 1];
+	}
+}
+
+static void mcp47feb02_get_scale(int ch, struct mcp47feb02_data *data, int *val, int *val2)
+{
+	enum mcp47feb02_scale tmp_scale;
+
+	if (data->chdata[ch].ref_mode == MCP47FEB02_VREF_VDD)
+		tmp_scale = MCP47FEB02_SCALE_VDD;
+	else if (data->chdata[ch].use_2x_gain)
+		tmp_scale = MCP47FEB02_SCALE_GAIN_BIT_X2;
+	else
+		tmp_scale = MCP47FEB02_SCALE_GAIN_BIT_X1;
+
+	mcp47feb02_get_scale_avail(data, val, val2, tmp_scale, ch);
+}
+
+static int mcp47feb02_check_scale(struct mcp47feb02_data *data, int val, int val2, int scale[])
+{
+	for (int i = 0; i < MCP47FEB02_MAX_SCALES_CH; i++) {
+		if (scale[i * 2] == val && scale[i * 2 + 1] == val2)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int mcp47feb02_ch_scale(struct mcp47feb02_data *data, int ch, int scale)
+{
+	int tmp_val, ret;
+
+	if (scale == MCP47FEB02_SCALE_VDD) {
+		tmp_val = MCP47FEB02_VREF_VDD;
+	} else if (data->phys_channels >= 4 && (ch % 2)) {
+		if (data->use_vref1) {
+			if (data->vref1_buffered)
+				tmp_val = MCP47FEB02_EXTERNAL_VREF_BUFFERED;
+			else
+				tmp_val = MCP47FEB02_EXTERNAL_VREF_UNBUFFERED;
+		} else {
+			tmp_val = MCP47FEB02_INTERNAL_BAND_GAP;
+		}
+	} else if (data->use_vref) {
+		if (data->vref_buffered)
+			tmp_val = MCP47FEB02_EXTERNAL_VREF_BUFFERED;
+		else
+			tmp_val = MCP47FEB02_EXTERNAL_VREF_UNBUFFERED;
+	} else {
+		tmp_val = MCP47FEB02_INTERNAL_BAND_GAP;
+	}
+
+	ret = regmap_update_bits(data->regmap, MCP47FEB02_VREF_REG_ADDR,
+				 DAC_CTRL_MASK(ch), DAC_CTRL_VAL(ch, tmp_val));
+	if (ret)
+		return ret;
+
+	data->chdata[ch].ref_mode = tmp_val;
+
+	return 0;
+}
+
+/*
+ * Setting the scale in order to choose between VDD and (Vref or BandGap) from the user
+ * space. You can't have an external voltage reference connected to the pin and select the
+ * internal BandGap. The VREF pin is either an input or an output. When the DAC’s voltage
+ * reference is configured as the VREF pin, the pin is an input. When the DAC’s voltage
+ * reference is configured as the internal BandGap, the pin is an output.
+ *
+ * If Vref voltage is not available then the internal BandGap will be used to calculate one
+ * of the possible scale.
+ * If Vref1 voltage is not available then the internal BandGap will be used to calculate
+ * one of the possible scale.
+ */
+static int mcp47feb02_set_scale(struct mcp47feb02_data *data, int ch, int scale)
+{
+	int tmp_val, ret;
+
+	ret = mcp47feb02_ch_scale(data, ch, scale);
+	if (ret)
+		return ret;
+
+	if (scale == MCP47FEB02_SCALE_GAIN_BIT_X2)
+		tmp_val = MCP47FEB02_GAIN_BIT_X2;
+	else
+		tmp_val = MCP47FEB02_GAIN_BIT_X1;
+
+	ret = regmap_update_bits(data->regmap, MCP47FEB02_GAIN_BIT_STATUS_REG_ADDR,
+				 DAC_GAIN_MASK(ch), DAC_GAIN_VAL(ch, tmp_val));
+	if (ret)
+		return ret;
+
+	data->chdata[ch].use_2x_gain = tmp_val;
+
+	return 0;
+}
+
+static int mcp47feb02_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *ch,
+			       int *val, int *val2, long mask)
+{
+	struct mcp47feb02_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_read(data->regmap, ch->address << 3, val);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		mcp47feb02_get_scale(ch->address, data, val, val2);
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mcp47feb02_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *ch,
+				int val, int val2, long mask)
+{
+	struct mcp47feb02_data *data = iio_priv(indio_dev);
+	int *tmp_scale;
+	int ret;
+
+	guard(mutex)(&data->lock);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_write(data->regmap, ch->address << 3, val);
+		if (ret)
+			return ret;
+
+		data->chdata[ch->address].dac_data = val;
+		return 0;
+	case IIO_CHAN_INFO_SCALE:
+		if (data->phys_channels >= 4 && (ch->address % 2))
+			tmp_scale = data->scale_1;
+		else
+			tmp_scale = data->scale;
+
+		ret = mcp47feb02_check_scale(data, val, val2, tmp_scale);
+		if (ret < 0)
+			return ret;
+
+		return mcp47feb02_set_scale(data, ch->address, ret);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mcp47feb02_read_label(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *ch, char *label)
+{
+	struct mcp47feb02_data *data = iio_priv(indio_dev);
+
+	return sysfs_emit(label, "%s\n", data->labels[ch->address]);
+
+	return 0;
+}
+
+static const struct iio_info mcp47feb02_info = {
+	.read_raw = mcp47feb02_read_raw,
+	.write_raw = mcp47feb02_write_raw,
+	.read_label = mcp47feb02_read_label,
+	.read_avail = &mcp47feb02_read_avail,
+	.attrs = &mcp47feb02_attribute_group,
+};
+
+static const struct iio_info mcp47fvb02_info = {
+	.read_raw = mcp47feb02_read_raw,
+	.write_raw = mcp47feb02_write_raw,
+	.read_label = mcp47feb02_read_label,
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
+	u32 num_channels;
+	int chan_idx = 0;
+	u32 reg = 0;
+	int ret;
+
+	num_channels = device_get_child_node_count(dev);
+	if (num_channels > info->phys_channels)
+		return dev_err_probe(dev, -EINVAL, "More channels than the chip supports\n");
+
+	if (!num_channels)
+		return dev_err_probe(dev, -EINVAL, "No channel specified in the devicetree.\n");
+
+	channels = devm_kcalloc(dev, num_channels, sizeof(*channels), GFP_KERNEL);
+	if (!channels)
+		return -ENOMEM;
+
+	device_for_each_child_node_scoped(dev, child) {
+		ret = fwnode_property_read_u32(child, "reg", &reg);
+		if (ret)
+			return dev_err_probe(dev, ret, "Invalid channel number\n");
+
+		if (reg >= info->phys_channels)
+			return dev_err_probe(dev, -EINVAL,
+					     "The index of the channels does not match the chip\n");
+
+		set_bit(reg, &data->active_channels_mask);
+
+		if (fwnode_property_present(child, "label"))
+			fwnode_property_read_string(child, "label", &data->labels[reg]);
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
+	 * Check if microchip,vref-buffered and microchip,vref1-buffered are defined
+	 * in the devicetree
+	 */
+	data->vref_buffered = device_property_read_bool(dev, "microchip,vref-buffered");
+
+	if (info->have_ext_vref1)
+		data->vref1_buffered = device_property_read_bool(dev, "microchip,vref1-buffered");
+
+	return 0;
+}
+
+static int mcp47feb02_init_ctrl_regs(struct mcp47feb02_data *data)
+{
+	int ret, i, vref_ch, gain_ch, pd_ch, pd_tmp;
+	struct device *dev = &data->client->dev;
+
+	ret = regmap_read(data->regmap, MCP47FEB02_VREF_REG_ADDR, &vref_ch);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap, MCP47FEB02_GAIN_BIT_STATUS_REG_ADDR, &gain_ch);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(data->regmap, MCP47FEB02_POWER_DOWN_REG_ADDR, &pd_ch);
+	if (ret)
+		return ret;
+
+	gain_ch = gain_ch >> 8;
+	for_each_set_bit(i, &data->active_channels_mask, data->phys_channels) {
+		data->chdata[i].ref_mode = (vref_ch >> (2 * i)) & SET_DAC_CTRL_MASK;
+		data->chdata[i].use_2x_gain = (gain_ch >> i)  & SET_GAIN_BIT;
+
+		/*
+		 * Inform the user that the current voltage reference read from volatile
+		 * register of the chip is different from the one from device tree.
+		 * You can't have an external voltage reference connected to the pin and
+		 * select the internal BandGap, because the VREF pin is either an input or
+		 * an output. When the DAC’s voltage reference is configured as the VREF pin,
+		 * the pin is an input. When the DAC’s voltage reference is configured as the
+		 * internal band gap, the pin is an output.
+		 */
+		if (data->chdata[i].ref_mode == MCP47FEB02_INTERNAL_BAND_GAP) {
+			if (data->phys_channels >= 4 && (i % 2)) {
+				if (data->use_vref1)
+					dev_info(dev, "cannot use Vref1 and internal BandGap");
+			} else {
+				if (data->use_vref)
+					dev_info(dev, "cannot use Vref and internal BandGap");
+			}
+		}
+
+		pd_tmp = (pd_ch >> (2 * i)) & SET_DAC_CTRL_MASK;
+		data->chdata[i].powerdown_mode = pd_tmp ? (pd_tmp - 1) : pd_tmp;
+		data->chdata[i].powerdown = !!(data->chdata[i].powerdown_mode);
+	}
+
+	return 0;
+}
+
+static int mcp47feb02_init_ch_scales(struct mcp47feb02_data *data, int vdd_mv,
+				     int vref_mv, int vref1_mv)
+{
+	struct device *dev = &data->client->dev;
+	int i, ret;
+
+	for_each_set_bit(i, &data->active_channels_mask, data->phys_channels) {
+		ret = mcp47feb02_init_scales_avail(data, vdd_mv, vref_mv, vref1_mv);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to init scales for ch i %d\n", i);
+	}
+
+	return 0;
+}
+
+static int mcp47feb02_probe(struct i2c_client *client)
+{
+	const struct i2c_device_id *id = i2c_client_get_device_id(client);
+	const struct mcp47feb02_features *info;
+	struct device *dev = &client->dev;
+	struct mcp47feb02_data *data;
+	struct iio_dev *indio_dev;
+	int vref1_mv = 0;
+	int vref_mv = 0;
+	int vdd_mv = 0;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	data = iio_priv(indio_dev);
+	data->client = client;
+	info = i2c_get_match_data(client);
+	if (!info)
+		return -EINVAL;
+
+	data->info = info;
+
+	if (info->have_eeprom) {
+		data->regmap = devm_regmap_init_i2c(client, &mcp47feb02_regmap_config);
+		indio_dev->info = &mcp47feb02_info;
+	} else {
+		data->regmap = devm_regmap_init_i2c(client, &mcp47fvb02_regmap_config);
+		indio_dev->info = &mcp47fvb02_info;
+	}
+
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(dev, PTR_ERR(data->regmap), "Error initializing i2c regmap\n");
+
+	indio_dev->name = id->name;
+
+	ret = mcp47feb02_parse_fw(indio_dev, info);
+	if (ret)
+		return dev_err_probe(dev, ret, "Error parsing devicetree data\n");
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
+	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
+	if (ret > 0) {
+		vref_mv = ret / 1000;
+		data->use_vref = true;
+	} else {
+		dev_info(dev, "Vref is unavailable, internal band gap can be used instead\n");
+	}
+
+	if (info->have_ext_vref1) {
+		ret = devm_regulator_get_enable_read_voltage(dev, "vref1");
+		if (ret > 0) {
+			vref1_mv = ret / 1000;
+			data->use_vref1 = true;
+		} else {
+			dev_info(dev,
+				 "Vref1 is unavailable, internal band gap can be used instead\n");
+		}
+	}
+
+	ret = mcp47feb02_init_ctrl_regs(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "Error initialising vref register\n");
+
+	ret = mcp47feb02_init_ch_scales(data, vdd_mv, vref_mv, vref1_mv);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
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
+	.id_table	= mcp47feb02_id,
+};
+module_i2c_driver(mcp47feb02_driver);
+
+MODULE_AUTHOR("Ariana Lazar <ariana.lazar@microchip.com>");
+MODULE_DESCRIPTION("IIO driver for MCP47FEB02 Multi-Channel DAC with I2C interface");
+MODULE_LICENSE("GPL");

-- 
2.43.0


