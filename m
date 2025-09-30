Return-Path: <linux-iio+bounces-24584-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9325CBAD13C
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 15:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 395BA3C74B9
	for <lists+linux-iio@lfdr.de>; Tue, 30 Sep 2025 13:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010BC304BBF;
	Tue, 30 Sep 2025 13:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Mpn0mHO4"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187BC1A8F97;
	Tue, 30 Sep 2025 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759239168; cv=none; b=Psw14JjrAv4Ju/5FpLQ6deM0gxCv3KBYOypzxjcjMaKDx/IVY+HBd6olyh4XdnAYvuBMZXAzMkztMjYW7v/deQFM0+lxrhGsXsM5E8CLJdaQ8R8rCQ5NERhU9lThIykvbAiG0IdCR9PPzJEhB7qI212wuOEFC+yrK3C1pHFc7jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759239168; c=relaxed/simple;
	bh=qAnSuAOOjpkxeTQDitmNK1BjtG7ivrbMzP6vYju+ImE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B5wYnQasPRAE+oihgxoI2+qEZUVnFk5NWE2xtVEluN3+PaYfeewza2g+C2JZYwSzyqb3kYfsGB7zIPTN8n7OVItW4SmWj5HmAFiPAvPES61MxiWl4QWy/vJrp273vd5+qICm42PXsIaodwqeJ5O7YVLJQFsBUZSB1pwIS13b89Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Mpn0mHO4; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1759239166; x=1790775166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qAnSuAOOjpkxeTQDitmNK1BjtG7ivrbMzP6vYju+ImE=;
  b=Mpn0mHO4v89NqNjinGduA9jYup7uuoKOVH+W0oDft2JWZZFK6Dfzx4LU
   ZpTHd31qUuO/UDeghfL8TESlB9ReZLC/SOYzFb7Nekf173V74IszDnyL+
   u6NTaQuSrqSWxtkciOeXGf8Qq4x+FAhJtSeDtYo40bh4yrd7Zt6qDcIaU
   YFFYRwreGBYANS8S6aXgY0HjOpSz9b2hmDtaExfbbyRHEio5+GXv+JYK4
   33dhGlRSCvbqdoXV/DNU1hp7qf9BqNQ1XfxQcxb6cy/4APsc7iFnye8Pc
   H7HGMukV9zQcdhqUW5qwsSH9ObASZ0UtaUP3D5I7bts0TPfhIXDhUjb2W
   A==;
X-CSE-ConnectionGUID: 230nnVAPSsq/Y51Dw2EIlA==
X-CSE-MsgGUID: bHpEkuI7Qjappp29mtfrug==
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="53148427"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2025 06:32:37 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 30 Sep 2025 06:32:12 -0700
Received: from vduicu-Virtual-Machine.mshome.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 30 Sep 2025 06:32:10 -0700
From: <victor.duicu@microchip.com>
To: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <marius.cristea@microchip.com>, <victor.duicu@microchip.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v6 2/2] iio: temperature: add support for MCP998X
Date: Tue, 30 Sep 2025 16:31:31 +0300
Message-ID: <20250930133131.13797-3-victor.duicu@microchip.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250930133131.13797-1-victor.duicu@microchip.com>
References: <20250930133131.13797-1-victor.duicu@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Victor Duicu <victor.duicu@microchip.com>

This is the driver for Microchip MCP998X/33 and MCP998XD/33D Multichannel
Automotive Temperature Monitor Family.

Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
---
 MAINTAINERS                       |   1 +
 drivers/iio/temperature/Kconfig   |  10 +
 drivers/iio/temperature/Makefile  |   1 +
 drivers/iio/temperature/mcp9982.c | 862 ++++++++++++++++++++++++++++++
 4 files changed, 874 insertions(+)
 create mode 100644 drivers/iio/temperature/mcp9982.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a1981c2f659b..1fb2aad63800 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16667,6 +16667,7 @@ M:	Victor Duicu <victor.duicu@microchip.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml
+F:	drivers/iio/temperature/mcp9982.c
 
 MICROCHIP MMC/SD/SDIO MCI DRIVER
 M:	Aubin Constans <aubin.constans@microchip.com>
diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
index 9328b2250ace..d1751db6bf6f 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -184,4 +184,14 @@ config MCP9600
 	  This driver can also be built as a module. If so, the module
 	  will be called mcp9600.
 
+config MCP9982
+       tristate "Microchip Technology MCP9982 driver"
+       depends on I2C
+       help
+         Say yes here to build support for Microchip Technology's MCP998X/33
+         and MCP998XD/33D Multichannel Automotive Temperature Monitor Family.
+
+         This driver can also be built as a module. If so, the module
+         will be called mcp9982.
+
 endmenu
diff --git a/drivers/iio/temperature/Makefile b/drivers/iio/temperature/Makefile
index 07d6e65709f7..83f5f4bb4ff3 100644
--- a/drivers/iio/temperature/Makefile
+++ b/drivers/iio/temperature/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_MAX30208) += max30208.o
 obj-$(CONFIG_MAX31856) += max31856.o
 obj-$(CONFIG_MAX31865) += max31865.o
 obj-$(CONFIG_MCP9600) += mcp9600.o
+obj-$(CONFIG_MCP9982) += mcp9982.o
 obj-$(CONFIG_MLX90614) += mlx90614.o
 obj-$(CONFIG_MLX90632) += mlx90632.o
 obj-$(CONFIG_MLX90632) += mlx90635.o
diff --git a/drivers/iio/temperature/mcp9982.c b/drivers/iio/temperature/mcp9982.c
new file mode 100644
index 000000000000..2d01ea8ae1dc
--- /dev/null
+++ b/drivers/iio/temperature/mcp9982.c
@@ -0,0 +1,862 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * IIO driver for MCP998X/33 and MCP998XD/33D Multichannel Automotive Temperature Monitor Family
+ *
+ * Copyright (C) 2025 Microchip Technology Inc. and its subsidiaries
+ *
+ * Author: Victor Duicu <victor.duicu@microchip.com>
+ *
+ * Datasheet can be found here:
+ * https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP998X-Family-Data-Sheet-DS20006827.pdf
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/device/devres.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/math64.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/string.h>
+#include <linux/units.h>
+
+/* MCP9982 Registers */
+#define MCP9982_HIGH_BYTE_ADDR(index)		(2 * (index))
+#define MCP9982_ONE_SHOT_ADDR			0x0A
+#define MCP9982_INTERNAL_HIGH_LIMIT_ADDR	0x0B
+#define MCP9982_INTERNAL_LOW_LIMIT_ADDR		0x0C
+#define MCP9982_EXT1_HIGH_LIMIT_HIGH_BYTE_ADDR	0x0D
+#define MCP9982_EXT1_HIGH_LIMIT_LOW_BYTE_ADDR	0x0E
+#define MCP9982_EXT1_LOW_LIMIT_HIGH_BYTE_ADDR	0x0F
+#define MCP9982_EXT1_LOW_LIMIT_LOW_BYTE_ADDR	0x10
+#define MCP9982_INTERNAL_THERM_LIMIT_ADDR	0x1D
+#define MCP9982_EXT1_THERM_LIMIT_ADDR		0x1E
+#define MCP9982_CFG_ADDR			0x22
+#define MCP9982_CONV_ADDR			0x24
+#define MCP9982_HYS_ADDR			0x25
+#define MCP9982_CONSEC_ALRT_ADDR		0x26
+#define MCP9982_ALRT_CFG_ADDR			0x27
+#define MCP9982_RUNNING_AVG_ADDR		0x28
+#define MCP9982_HOTTEST_CFG_ADDR		0x29
+#define MCP9982_STATUS_ADDR			0x2A
+#define MCP9982_EXT_FAULT_STATUS_ADDR		0x2B
+#define MCP9982_HIGH_LIMIT_STATUS_ADDR		0x2C
+#define MCP9982_LOW_LIMIT_STATUS_ADDR		0x2D
+#define MCP9982_THERM_LIMIT_STATUS_ADDR		0x2E
+#define MCP9982_HOTTEST_HIGH_BYTE_ADDR		0x2F
+#define MCP9982_HOTTEST_LOW_BYTE_ADDR		0x30
+#define MCP9982_HOTTEST_STATUS_ADDR		0x31
+#define MCP9982_THERM_SHTDWN_CFG_ADDR		0x32
+#define MCP9982_HRDW_THERM_SHTDWN_LIMIT_ADDR	0x33
+
+/* 34 is the start address for the beta registers. */
+#define MCP9982_EXT_BETA_CFG_ADDR(index)	((index) + 0x34)
+/* 36 is the start address for ideality registers. */
+#define MCP9982_EXT_IDEAL_ADDR(index)		((index) + 0x36)
+/* 80 is the start address in decimal for temperature memory block */
+#define MCP9982_TEMP_MEM_BLOCK_ADDR(index)	(2 * (index) + 0x80)
+
+/* MCP9982 Bits */
+#define MCP9982_CFG_MSKAL			BIT(7)
+#define MCP9982_CFG_RS				BIT(6)
+#define MCP9982_CFG_ATTHM			BIT(5)
+#define MCP9982_CFG_RECD12			BIT(4)
+#define MCP9982_CFG_RECD34			BIT(3)
+#define MCP9982_CFG_RANGE			BIT(2)
+#define MCP9982_CFG_DA_ENA			BIT(1)
+#define MCP9982_CFG_APDD			BIT(0)
+#define MCP9982_STATUS_BUSY			BIT(5)
+
+/* The maximum number of channels a member of the family can have. */
+#define MCP9982_MAX_NUM_CHANNELS		5
+#define MCP9982_BETA_AUTODETECT			16
+#define MCP9982_IDEALITY_DEFAULT		18
+#define MCP9982_OFFSET				-64
+#define MCP9982_SCALE				3906250
+
+#define MCP9982_CHAN(index, si, __address)						\
+	(struct iio_chan_spec) {							\
+		.type = IIO_TEMP,							\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),				\
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
+			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),		\
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |		\
+			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |		\
+			BIT(IIO_CHAN_INFO_OFFSET) |					\
+			BIT(IIO_CHAN_INFO_SCALE),					\
+		.channel = (index),							\
+		.address = (__address),							\
+		.scan_index = (si),							\
+		.scan_type = {								\
+			.sign = 'u',							\
+			.realbits = 8,							\
+			.storagebits = 8,						\
+		},									\
+		.indexed = 1,								\
+	}										\
+
+/**
+ * struct mcp9982_features - features of a mcp9982 instance
+ * @name:			chip's name
+ * @phys_channels:		number of physical channels supported by the chip
+ * @hw_thermal_shutdown:	presence of hardware thermal shutdown circuitry
+ * @allow_apdd:			whether the chip supports enabling APDD
+ */
+struct mcp9982_features {
+	const char	*name;
+	u8		phys_channels;
+	bool		hw_thermal_shutdown;
+	bool		allow_apdd;
+};
+
+static const struct mcp9982_features mcp9933_chip_config = {
+	.name = "mcp9933",
+	.phys_channels = 3,
+	.hw_thermal_shutdown = false,
+	.allow_apdd = true,
+};
+
+static const struct mcp9982_features mcp9933d_chip_config = {
+	.name = "mcp9933d",
+	.phys_channels = 3,
+	.hw_thermal_shutdown = true,
+	.allow_apdd = true,
+};
+
+static const struct mcp9982_features mcp9982_chip_config = {
+	.name = "mcp9982",
+	.phys_channels = 2,
+	.hw_thermal_shutdown = false,
+	.allow_apdd = false,
+};
+
+static const struct mcp9982_features mcp9982d_chip_config = {
+	.name = "mcp9982d",
+	.phys_channels = 2,
+	.hw_thermal_shutdown = true,
+	.allow_apdd = false,
+};
+
+static const struct mcp9982_features mcp9983_chip_config = {
+	.name = "mcp9983",
+	.phys_channels = 3,
+	.hw_thermal_shutdown = false,
+	.allow_apdd = false,
+};
+
+static const struct mcp9982_features mcp9983d_chip_config = {
+	.name = "mcp9983d",
+	.phys_channels = 3,
+	.hw_thermal_shutdown = true,
+	.allow_apdd = false,
+};
+
+static const struct mcp9982_features mcp9984_chip_config = {
+	.name = "mcp9984",
+	.phys_channels = 4,
+	.hw_thermal_shutdown = false,
+	.allow_apdd = true,
+};
+
+static const struct mcp9982_features mcp9984d_chip_config = {
+	.name = "mcp9984d",
+	.phys_channels = 4,
+	.hw_thermal_shutdown = true,
+	.allow_apdd = true,
+};
+
+static const struct mcp9982_features mcp9985_chip_config = {
+	.name = "mcp9985",
+	.phys_channels = 5,
+	.hw_thermal_shutdown = false,
+	.allow_apdd = true,
+};
+
+static const struct mcp9982_features mcp9985d_chip_config = {
+	.name = "mcp9985d",
+	.phys_channels = 5,
+	.hw_thermal_shutdown = true,
+	.allow_apdd = true,
+};
+
+static const unsigned int mcp9982_conv_rate[][2] = {
+	{ 0, 62500 },
+	{ 0, 125000 },
+	{ 0, 250000 },
+	{ 0, 500000 },
+	{ 1, 0 },
+	{ 2, 0 },
+	{ 4, 0 },
+	{ 8, 0 },
+	{ 16, 0 },
+	{ 32, 0 },
+	{ 64, 0 },
+};
+
+/*
+ * Constants were calculated using:
+ * (Sampling_Frequency(Hz) * 1000000) / (Window_Size * 2)
+ * The formula is used for Window_Size = { 4, 8 }.
+ * For Window_Size = 1 the filter is OFF and the 3db value
+ * is equal to the frequency.
+ */
+static const unsigned int mcp9982_3db_values_map_tbl[11][3][2] = {
+	{
+		{ 0, 62500 },
+		{ 0, 7812 },
+		{ 0, 3906 },
+	},
+	{
+		{ 0, 125000 },
+		{ 0, 15625 },
+		{ 0, 7812 },
+	},
+	{
+		{ 0, 250000 },
+		{ 0, 31250 },
+		{ 0, 15625 },
+	},
+	{
+		{ 0, 500000 },
+		{ 0, 62500 },
+		{ 0, 31250 },
+	},
+	{
+		{ 1, 0 },
+		{ 0, 125000 },
+		{ 0, 62500 },
+	},
+	{
+		{ 2, 0 },
+		{ 0, 250000 },
+		{ 0, 125000 },
+	},
+	{
+		{ 4, 0 },
+		{ 0, 500000 },
+		{ 0, 250000 },
+	},
+	{
+		{ 8, 0 },
+		{ 1, 0 },
+		{ 0, 500000 },
+	},
+	{
+		{ 16, 0 },
+		{ 2, 0 },
+		{ 1, 0 },
+	},
+	{
+		{ 32, 0 },
+		{ 4, 0 },
+		{ 2, 0 },
+	},
+	{
+		{ 64, 0 },
+		{ 8, 0 },
+		{ 4, 0 },
+	},
+};
+
+/* The delay, in milliseconds, needed to allow the conversion to end. */
+static const u64 mcp9982_delay_ms[11] = {
+	16125,
+	8125,
+	4125,
+	2125,
+	1125,
+	625,
+	375,
+	255,
+	190,
+	160,
+	145,
+};
+
+/* MCP9982 regmap configuration */
+static const struct regmap_range mcp9982_regmap_wr_ranges[] = {
+	regmap_reg_range(MCP9982_ONE_SHOT_ADDR,
+			 MCP9982_EXT1_LOW_LIMIT_LOW_BYTE_ADDR),
+	regmap_reg_range(MCP9982_INTERNAL_THERM_LIMIT_ADDR,
+			 MCP9982_EXT1_THERM_LIMIT_ADDR),
+	regmap_reg_range(MCP9982_CFG_ADDR, MCP9982_CFG_ADDR),
+	regmap_reg_range(MCP9982_CONV_ADDR, MCP9982_HOTTEST_CFG_ADDR),
+	regmap_reg_range(MCP9982_THERM_SHTDWN_CFG_ADDR,
+			 MCP9982_THERM_SHTDWN_CFG_ADDR),
+	regmap_reg_range(MCP9982_EXT_BETA_CFG_ADDR(0),
+			 MCP9982_EXT_IDEAL_ADDR(3)),
+	regmap_reg_range(MCP9982_TEMP_MEM_BLOCK_ADDR(0),
+			 MCP9982_TEMP_MEM_BLOCK_ADDR(4) + 1),
+};
+
+static const struct regmap_access_table mcp9982_regmap_wr_table = {
+	.yes_ranges = mcp9982_regmap_wr_ranges,
+	.n_yes_ranges = ARRAY_SIZE(mcp9982_regmap_wr_ranges),
+};
+
+static const struct regmap_range mcp9982_regmap_rd_ranges[] = {
+	regmap_reg_range(MCP9982_HIGH_BYTE_ADDR(0),
+			 MCP9982_EXT1_LOW_LIMIT_LOW_BYTE_ADDR),
+	regmap_reg_range(MCP9982_INTERNAL_THERM_LIMIT_ADDR,
+			 MCP9982_EXT1_THERM_LIMIT_ADDR),
+	regmap_reg_range(MCP9982_CFG_ADDR, MCP9982_CFG_ADDR),
+	regmap_reg_range(MCP9982_CONV_ADDR, MCP9982_EXT_IDEAL_ADDR(3)),
+	regmap_reg_range(MCP9982_TEMP_MEM_BLOCK_ADDR(0),
+			 MCP9982_TEMP_MEM_BLOCK_ADDR(4) + 1),
+};
+
+static const struct regmap_access_table mcp9982_regmap_rd_table = {
+	.yes_ranges = mcp9982_regmap_rd_ranges,
+	.n_yes_ranges = ARRAY_SIZE(mcp9982_regmap_rd_ranges),
+};
+
+static bool mcp9982_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MCP9982_ONE_SHOT_ADDR:
+	case MCP9982_INTERNAL_HIGH_LIMIT_ADDR:
+	case MCP9982_INTERNAL_LOW_LIMIT_ADDR:
+	case MCP9982_EXT1_HIGH_LIMIT_HIGH_BYTE_ADDR:
+	case MCP9982_EXT1_HIGH_LIMIT_LOW_BYTE_ADDR:
+	case MCP9982_EXT1_LOW_LIMIT_HIGH_BYTE_ADDR:
+	case MCP9982_EXT1_LOW_LIMIT_LOW_BYTE_ADDR:
+	case MCP9982_INTERNAL_THERM_LIMIT_ADDR:
+	case MCP9982_EXT1_THERM_LIMIT_ADDR:
+	case MCP9982_CFG_ADDR:
+	case MCP9982_CONV_ADDR:
+	case MCP9982_HYS_ADDR:
+	case MCP9982_CONSEC_ALRT_ADDR:
+	case MCP9982_ALRT_CFG_ADDR:
+	case MCP9982_RUNNING_AVG_ADDR:
+	case MCP9982_HOTTEST_CFG_ADDR:
+	case MCP9982_THERM_SHTDWN_CFG_ADDR:
+		return false;
+	default:
+		return true;
+	}
+}
+
+static const struct regmap_config mcp9982_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.rd_table = &mcp9982_regmap_rd_table,
+	.wr_table = &mcp9982_regmap_wr_table,
+	.volatile_reg = mcp9982_is_volatile_reg,
+	.max_register = MCP9982_TEMP_MEM_BLOCK_ADDR(4) + 1,
+};
+
+/**
+ * struct mcp9992_priv - information about chip parameters
+ * @regmap:			device register map
+ * @chip:			pointer to structure holding chip features
+ * @lock:			synchronize access to driver's state members
+ * @iio_chan:			specifications of channels
+ * @labels:			labels of the channels
+ * @sampl_idx:			index representing the current sampling frequency
+ * @time_limit:			time when it is safe to read
+ * @num_channels:		number of active physical channels
+ * @recd34_enable:		state of Resistance Error Correction(REC) on channels 3 and 4
+ * @recd12_enable:		state of Resistance Error Correction(REC) on channels 1 and 2
+ * @apdd_enable:		state of anti-parallel diode mode
+ * @run_state:			chip is in run state, otherwise is in standby state
+ * @wait_before_read:		whether we need to wait a delay before reading a new value
+ */
+struct mcp9982_priv {
+	struct regmap *regmap;
+	const struct mcp9982_features *chip;
+	/* Synchronize access to driver's state members. */
+	struct mutex lock;
+	struct iio_chan_spec iio_chan[5];
+	const char *labels[MCP9982_MAX_NUM_CHANNELS];
+	unsigned int sampl_idx;
+	unsigned long  time_limit;
+	u8 num_channels;
+	bool recd34_enable;
+	bool recd12_enable;
+	bool apdd_enable;
+	bool run_state;
+	bool wait_before_read;
+};
+
+static int mcp9982_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan, const int **vals,
+			      int *type, int *length, long mask)
+{
+	struct mcp9982_priv *priv = iio_priv(indio_dev);
+	unsigned int idx;
+	unsigned int sub;
+
+	if (priv->chip->hw_thermal_shutdown) {
+		idx = 4;
+		sub = 8;
+	} else {
+		idx = 0;
+		sub = 0;
+	}
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*vals = mcp9982_conv_rate[idx];
+		*length = ARRAY_SIZE(mcp9982_conv_rate) * 2 - sub;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*vals = mcp9982_3db_values_map_tbl[priv->sampl_idx][0];
+		*length = ARRAY_SIZE(mcp9982_3db_values_map_tbl[priv->sampl_idx]) * 2;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mcp9982_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	unsigned int tmp_reg, reg_status;
+	struct mcp9982_priv *priv = iio_priv(indio_dev);
+	unsigned long *src;
+	int ret;
+	u8 bulk_read[3];
+
+	if (priv->run_state) {
+		/*
+		 * When working in Run mode, after modifying a parameter (like sampling
+		 * frequency) we have to wait a delay before reading the new values.
+		 * We can't determine when the conversion is done based on the BUSY bit.
+		 */
+		if (priv->wait_before_read) {
+			if (!time_after(jiffies, priv->time_limit))
+				mdelay(jiffies_to_msecs(priv->time_limit - jiffies));
+			priv->wait_before_read = false;
+		}
+	} else {
+		ret = regmap_write(priv->regmap, MCP9982_ONE_SHOT_ADDR, 1);
+		if (ret)
+			return ret;
+		/*
+		 * In Standby state after writing in OneShot register wait for
+		 * the start of conversion and then poll the BUSY bit.
+		 */
+		mdelay(125);
+		ret = regmap_read_poll_timeout(priv->regmap, MCP9982_STATUS_ADDR,
+					       reg_status, !(reg_status & MCP9982_STATUS_BUSY),
+					       mcp9982_delay_ms[priv->sampl_idx] * USEC_PER_MSEC,
+					       0);
+		if (ret)
+			return ret;
+	}
+	guard(mutex)(&priv->lock);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		/*
+		 * The Block Read Protocol first returns the number of user readable
+		 * bytes, held in bulk_read[0], followed by the data.
+		 */
+		ret = regmap_bulk_read(priv->regmap, MCP9982_TEMP_MEM_BLOCK_ADDR(chan->channel),
+				       &bulk_read, sizeof(bulk_read));
+		if (ret)
+			return ret;
+
+		*val = get_unaligned_be16(bulk_read + 1);
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 0;
+		*val2 = MCP9982_SCALE;
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = mcp9982_conv_rate[priv->sampl_idx][0];
+		*val2 = mcp9982_conv_rate[priv->sampl_idx][1];
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		ret = regmap_read(priv->regmap, MCP9982_RUNNING_AVG_ADDR, &tmp_reg);
+		if (ret)
+			return ret;
+		*src = tmp_reg;
+		*val = mcp9982_3db_values_map_tbl[priv->sampl_idx][bitmap_weight(src, 2)][0];
+		*val2 = mcp9982_3db_values_map_tbl[priv->sampl_idx][bitmap_weight(src, 2)][1];
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = MCP9982_OFFSET;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mcp9982_read_label(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan, char *label)
+{
+	struct mcp9982_priv *priv = iio_priv(indio_dev);
+
+	return sysfs_emit(label, "%s\n", priv->labels[chan->channel]);
+}
+
+static int mcp9982_write_raw_get_fmt(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan, long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mcp9982_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	unsigned int i, previous_sampl_idx;
+	struct mcp9982_priv *priv = iio_priv(indio_dev);
+	unsigned long new_time_limit;
+	bool use_previous_freq = false;
+	int ret;
+
+	i = 0;
+	guard(mutex)(&priv->lock);
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		previous_sampl_idx = priv->sampl_idx;
+
+		/* For MCP998XD and MCP9933D sampling frequency can't be lower than 1. */
+		if (priv->chip->hw_thermal_shutdown)
+			i = 4;
+		for (; i < ARRAY_SIZE(mcp9982_conv_rate); i++)
+			if (val == mcp9982_conv_rate[i][0] &&
+			    val2 == mcp9982_conv_rate[i][1])
+				break;
+
+		if (i == ARRAY_SIZE(mcp9982_conv_rate))
+			return -EINVAL;
+
+		ret = regmap_write(priv->regmap, MCP9982_CONV_ADDR, i);
+		if (ret)
+			return ret;
+
+		priv->sampl_idx = i;
+
+		/*
+		 * When changing the frequency in Run mode, wait a delay based
+		 * on the previous value to ensure the new value becomes active.
+		 */
+		if (priv->run_state)
+			use_previous_freq = true;
+
+		break;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		for (i = 0; i < ARRAY_SIZE(mcp9982_3db_values_map_tbl[priv->sampl_idx]); i++)
+			if (val == mcp9982_3db_values_map_tbl[priv->sampl_idx][i][0] &&
+			    val2 == mcp9982_3db_values_map_tbl[priv->sampl_idx][i][1])
+				break;
+
+		if (i == ARRAY_SIZE(mcp9982_3db_values_map_tbl[priv->sampl_idx]))
+			return -EINVAL;
+
+		/*
+		 * In mcp9982_3db_values_map_tbl the second index maps:
+		 * 0 for filter off
+		 * 1 for filter at level 1
+		 * 2 for filter at level 2
+		 */
+		if (i == 2)
+			i = 3;
+		/*
+		 * If the digital filter is activated for chips without "D", set
+		 * the power state to Run to ensure the averaging is made on fresh values.
+		 */
+		if (!priv->chip->hw_thermal_shutdown) {
+			if (i == 0) {
+				ret = regmap_assign_bits(priv->regmap,
+							 MCP9982_CFG_ADDR,
+							 MCP9982_CFG_RS, 1);
+				priv->run_state = false;
+			} else {
+				ret = regmap_assign_bits(priv->regmap,
+							 MCP9982_CFG_ADDR,
+							 MCP9982_CFG_RS, 0);
+				priv->run_state = true;
+			}
+		}
+
+		ret = regmap_write(priv->regmap, MCP9982_RUNNING_AVG_ADDR, i);
+		if (ret)
+			return ret;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (priv->run_state) {
+		if (use_previous_freq) {
+			new_time_limit = jiffies +
+					msecs_to_jiffies(mcp9982_delay_ms[previous_sampl_idx]);
+			use_previous_freq = false;
+		} else {
+			new_time_limit = jiffies +
+					msecs_to_jiffies(mcp9982_delay_ms[priv->sampl_idx]);
+		}
+		if (time_after(new_time_limit, priv->time_limit)) {
+			priv->time_limit = new_time_limit;
+			priv->wait_before_read = true;
+		}
+	}
+
+	return 0;
+}
+
+static const struct iio_info mcp9982_info = {
+	.read_raw = mcp9982_read_raw,
+	.read_label = mcp9982_read_label,
+	.read_avail = mcp9982_read_avail,
+	.write_raw_get_fmt = mcp9982_write_raw_get_fmt,
+	.write_raw = mcp9982_write_raw,
+};
+
+static int mcp9982_init(struct device *dev, struct mcp9982_priv *priv)
+{
+	int ret;
+	unsigned int i;
+	u8 val;
+
+	/* Chips 82/83 and 82D/83D do not support anti-parallel diode mode. */
+	if (!priv->chip->allow_apdd && priv->apdd_enable == 1)
+		return dev_err_probe(dev, -EINVAL, "Incorrect setting of APDD.\n");
+
+	/* Chips with "D" work in Run state and those without work in Standby state. */
+	if (priv->chip->hw_thermal_shutdown)
+		priv->run_state = true;
+
+	/*
+	 * For chips with "D" in the name, resistance error correction must be on
+	 * so that hardware shutdown feature can't be overridden.
+	 */
+	if (priv->chip->hw_thermal_shutdown)
+		if (!priv->recd34_enable || !priv->recd12_enable)
+			return dev_err_probe(dev, -EINVAL, "Incorrect setting of RECD.\n");
+	/*
+	 * Set default values in registers.
+	 *
+	 * APDD, RECD12 and RECD34 are active on 0.
+	 */
+	val = FIELD_PREP(MCP9982_CFG_MSKAL, 1) |
+	      FIELD_PREP(MCP9982_CFG_RS, !priv->run_state) |
+	      FIELD_PREP(MCP9982_CFG_ATTHM, 1) |
+	      FIELD_PREP(MCP9982_CFG_RECD12, !priv->recd12_enable) |
+	      FIELD_PREP(MCP9982_CFG_RECD34, !priv->recd34_enable) |
+	      FIELD_PREP(MCP9982_CFG_RANGE, 1) | FIELD_PREP(MCP9982_CFG_DA_ENA, 0) |
+	      FIELD_PREP(MCP9982_CFG_APDD, !priv->apdd_enable);
+
+	ret = regmap_write(priv->regmap, MCP9982_CFG_ADDR, val);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->regmap, MCP9982_CONV_ADDR, 6);
+	if (ret)
+		return ret;
+	priv->sampl_idx = 6;
+
+	ret = regmap_write(priv->regmap, MCP9982_HYS_ADDR, 10);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->regmap, MCP9982_CONSEC_ALRT_ADDR, 112);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->regmap, MCP9982_RUNNING_AVG_ADDR, 0);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(priv->regmap, MCP9982_HOTTEST_CFG_ADDR, 0);
+	if (ret)
+		return ret;
+
+	/*
+	 * Only external channels 1 and 2 support beta compensation.
+	 * Set beta auto-detection.
+	 */
+	for (i = 0; i < 2; i++) {
+		ret = regmap_write(priv->regmap, MCP9982_EXT_BETA_CFG_ADDR(i),
+				   MCP9982_BETA_AUTODETECT);
+		if (ret)
+			return ret;
+	}
+	/* Set ideality factor to default for all external channels. */
+	for (i = 0; i < 4; i++) {
+		ret = regmap_write(priv->regmap, MCP9982_EXT_IDEAL_ADDR(i),
+				   MCP9982_IDEALITY_DEFAULT);
+		if (ret)
+			return ret;
+	}
+
+	priv->wait_before_read = false;
+	priv->time_limit = jiffies;
+
+	return 0;
+}
+
+static int mcp9982_parse_fw_config(struct iio_dev *indio_dev, struct device *dev,
+				   int device_nr_channels)
+{
+	unsigned int reg_nr;
+	unsigned int iio_idx = 0;
+	struct mcp9982_priv *priv = iio_priv(indio_dev);
+
+	priv->apdd_enable =
+		device_property_read_bool(dev, "microchip,enable-anti-parallel");
+
+	priv->recd12_enable =
+		device_property_read_bool(dev, "microchip,parasitic-res-on-channel1-2");
+
+	priv->recd34_enable =
+		device_property_read_bool(dev, "microchip,parasitic-res-on-channel3-4");
+
+	priv->num_channels = device_get_child_node_count(dev) + 1;
+
+	if (priv->num_channels > device_nr_channels)
+		return dev_err_probe(dev, -E2BIG,
+				     "More channels than the chip supports\n");
+
+	/* Initialise internal channel( which is always present ). */
+	priv->iio_chan[0] = MCP9982_CHAN(0, 0, MCP9982_HIGH_BYTE_ADDR(0));
+	priv->labels[0] = "internal diode";
+
+	iio_idx++;
+	device_for_each_child_node_scoped(dev, child) {
+		reg_nr = 0;
+		fwnode_property_read_u32(child, "reg", &reg_nr);
+		if (!reg_nr || reg_nr >= device_nr_channels)
+			return dev_err_probe(dev, -EINVAL,
+			  "The index of the channels does not match the chip\n");
+
+		fwnode_property_read_string(child, "label",
+					    &priv->labels[reg_nr]);
+
+		priv->iio_chan[iio_idx++] =
+			MCP9982_CHAN(reg_nr, reg_nr, MCP9982_HIGH_BYTE_ADDR(reg_nr));
+	}
+
+	return 0;
+}
+
+static int mcp9982_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct mcp9982_priv *priv;
+	struct iio_dev *indio_dev;
+	const struct mcp9982_features *chip;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	priv = iio_priv(indio_dev);
+	priv->regmap = devm_regmap_init_i2c(client, &mcp9982_regmap_config);
+	if (IS_ERR(priv->regmap))
+		return dev_err_probe(dev, PTR_ERR(priv->regmap),
+				     "Cannot initialize register map\n");
+
+	ret = devm_mutex_init(dev, &priv->lock);
+	if (ret)
+		return ret;
+
+	chip = i2c_get_match_data(client);
+	if (!chip)
+		return -EINVAL;
+	priv->chip = chip;
+
+	ret = mcp9982_parse_fw_config(indio_dev, dev, chip->phys_channels);
+	if (ret)
+		return ret;
+
+	ret = mcp9982_init(dev, priv);
+	if (ret)
+		return ret;
+
+	indio_dev->name = chip->name;
+	indio_dev->info = &mcp9982_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = priv->iio_chan;
+	indio_dev->num_channels = priv->num_channels;
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Cannot register IIO device\n");
+
+	return 0;
+}
+
+static const struct i2c_device_id mcp9982_id[] = {
+	{ .name = "mcp9933", .driver_data = (kernel_ulong_t)&mcp9933_chip_config },
+	{ .name = "mcp9933d", .driver_data = (kernel_ulong_t)&mcp9933d_chip_config },
+	{ .name = "mcp9982", .driver_data = (kernel_ulong_t)&mcp9982_chip_config },
+	{ .name = "mcp9982d", .driver_data = (kernel_ulong_t)&mcp9982d_chip_config },
+	{ .name = "mcp9983", .driver_data = (kernel_ulong_t)&mcp9983_chip_config },
+	{ .name = "mcp9983d", .driver_data = (kernel_ulong_t)&mcp9983d_chip_config },
+	{ .name = "mcp9984", .driver_data = (kernel_ulong_t)&mcp9984_chip_config },
+	{ .name = "mcp9984d", .driver_data = (kernel_ulong_t)&mcp9984d_chip_config },
+	{ .name = "mcp9985", .driver_data = (kernel_ulong_t)&mcp9985_chip_config },
+	{ .name = "mcp9985d", .driver_data = (kernel_ulong_t)&mcp9985d_chip_config },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mcp9982_id);
+
+static const struct of_device_id mcp9982_of_match[] = {
+	{
+		.compatible = "microchip,mcp9933",
+		.data = &mcp9933_chip_config,
+	}, {
+		.compatible = "microchip,mcp9933d",
+		.data = &mcp9933d_chip_config,
+	}, {
+		.compatible = "microchip,mcp9982",
+		.data = &mcp9982_chip_config,
+	}, {
+		.compatible = "microchip,mcp9982d",
+		.data = &mcp9982d_chip_config,
+	}, {
+		.compatible = "microchip,mcp9983",
+		.data = &mcp9983_chip_config,
+	}, {
+		.compatible = "microchip,mcp9983d",
+		.data = &mcp9983d_chip_config,
+	}, {
+		.compatible = "microchip,mcp9984",
+		.data = &mcp9984_chip_config,
+	}, {
+		.compatible = "microchip,mcp9984d",
+		.data = &mcp9984d_chip_config,
+	}, {
+		.compatible = "microchip,mcp9985",
+		.data = &mcp9985_chip_config,
+	}, {
+		.compatible = "microchip,mcp9985d",
+		.data = &mcp9985d_chip_config,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mcp9982_of_match);
+
+static struct i2c_driver mcp9982_driver = {
+	.driver	 = {
+		.name = "mcp9982",
+		.of_match_table = mcp9982_of_match,
+	},
+	.probe = mcp9982_probe,
+	.id_table = mcp9982_id,
+};
+module_i2c_driver(mcp9982_driver);
+
+MODULE_AUTHOR("Victor Duicu <victor.duicu@microchip.com>");
+MODULE_DESCRIPTION("MCP998X/33 and MCP998XD/33D Multichannel Automotive Temperature Monitor Driver");
+MODULE_LICENSE("GPL");
-- 
2.48.1


