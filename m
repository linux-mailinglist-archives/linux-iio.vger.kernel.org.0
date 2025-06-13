Return-Path: <linux-iio+bounces-20597-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB5CAD8CB5
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 15:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F0D13BBB69
	for <lists+linux-iio@lfdr.de>; Fri, 13 Jun 2025 13:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AA514D2B7;
	Fri, 13 Jun 2025 13:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="R4rGG08J"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110DF60B8A;
	Fri, 13 Jun 2025 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749819768; cv=none; b=S2Nq2Sv2/0KU0+vySvFGlhFf0jii4UAdceWCetBmqOll5Bvbct3jUF2OdK1bMyQex27/vixnk4GjWn4RV0/pZwyuNmBPS37CK32K5rLbJ/KzHMJkSwQZ9O7QJgAP5qo34fajSFQ6B5EB+mE3YOEgzgI86OYFj4pX3b5T0aHeAyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749819768; c=relaxed/simple;
	bh=2reAc8VrCoNjPEtFIG8NE8GEAn3xRXXZRjTRTsIsR5w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bEx5MrpWgQ3/bWLYJzYao6BXKjWPz88YM6Et/5FEHiySplHgI1zWOW2jbFMdoijLN9lVEW0kZmbGhyze++6vR/4OjkyP/T6Dd9e1aJLe9AiL7WgwwXZ0bNBi+y27AF82aox4C8vuzlCu8lWGTODOOBw9uQSz8EFgfJbUBQl23Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=R4rGG08J; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1749819767; x=1781355767;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2reAc8VrCoNjPEtFIG8NE8GEAn3xRXXZRjTRTsIsR5w=;
  b=R4rGG08JzLRdcDv5T11i7pnfTw45a2XFl9JcA4KwBYhxeS/8UXqjm3KJ
   OTZZX7qJAWfcncLiVOlt+Ywrr+i8eekH7093QX7obCep/IUkYaonpU7HG
   DFRuOqYRafcVd+bLCn0nRInScV9t6ocn6R3XkbVodXBLuSTBXTdi/R+Nd
   dIU1wAg3/PPXmVcOgXvZdnW0MEiSvxWw3MkIdXZADnATGVzwK6Iri98Sf
   XNDeeGAJ/hpxHWDBM7LsnAse/Xn5TN5NAE8/ES8euo1zmmOKCpiw7Aw8j
   1u2pQwwkQ+09wPCV9mNSP31JUfA61hx9muCD9OxmENNmi7iZzXgkJVqnq
   Q==;
X-CSE-ConnectionGUID: Q/C0oHGPR/isfC6vMelafQ==
X-CSE-MsgGUID: BnTmrFAKR3eOE0al60Rrhw==
X-IronPort-AV: E=Sophos;i="6.16,233,1744095600"; 
   d="scan'208";a="274154975"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Jun 2025 06:02:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 13 Jun 2025 06:02:30 -0700
Received: from vduicu-Virtual-Machine.mshome.net (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Fri, 13 Jun 2025 06:02:27 -0700
From: <victor.duicu@microchip.com>
To: <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <marius.cristea@microchip.com>, <victor.duicu@microchip.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: [PATCH v3 2/2] iio: temperature: add support for MCP998X
Date: Fri, 13 Jun 2025 16:02:07 +0300
Message-ID: <20250613130207.8560-3-victor.duicu@microchip.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250613130207.8560-1-victor.duicu@microchip.com>
References: <20250613130207.8560-1-victor.duicu@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Victor Duicu <victor.duicu@microchip.com>

This is the driver for Microchip MCP998X/33 and MCP998XD/33D
Multichannel Automotive Temperature Monitor Family.

Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
---
 MAINTAINERS                       |   7 +
 drivers/iio/temperature/Kconfig   |  10 +
 drivers/iio/temperature/Makefile  |   1 +
 drivers/iio/temperature/mcp9982.c | 778 ++++++++++++++++++++++++++++++
 4 files changed, 796 insertions(+)
 create mode 100644 drivers/iio/temperature/mcp9982.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 86a2045ba62e..63573c517603 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15887,6 +15887,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
 F:	drivers/iio/adc/mcp3911.c
 
+MICROCHIP MCP9982 TEMPERATURE DRIVER
+M:	Victor Duicu <victor.duicu@microchip.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/iio/temperature/microchip,mcp9982.yaml
+F:	drivers/iio/temperature/mcp9982.c
+
 MICROCHIP MMC/SD/SDIO MCI DRIVER
 M:	Aubin Constans <aubin.constans@microchip.com>
 S:	Maintained
diff --git a/drivers/iio/temperature/Kconfig b/drivers/iio/temperature/Kconfig
index 1244d8e17d50..e72b49f95f86 100644
--- a/drivers/iio/temperature/Kconfig
+++ b/drivers/iio/temperature/Kconfig
@@ -182,4 +182,14 @@ config MCP9600
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
index 000000000000..b1ae77c6e691
--- /dev/null
+++ b/drivers/iio/temperature/mcp9982.c
@@ -0,0 +1,778 @@
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
+#include <asm/div64.h>
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/device/devres.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/string.h>
+#include <linux/units.h>
+
+/* MCP9982 Registers */
+#define MCP9982_INT_VALUE_ADDR(index)		(2 * (index))
+#define MCP9982_FRAC_VALUE_ADDR(index)		(2 * (index) + 1)
+#define MCP9982_ONE_SHOT_ADDR			0x0A
+#define MCP9982_INTERNAL_HIGH_LIMIT_ADDR	0x0B
+#define MCP9982_INTERNAL_LOW_LIMIT_ADDR		0x0C
+#define MCP9982_EXT1_HIGH_LIMIT_INT_VALUE_ADDR	0x0D
+#define MCP9982_EXT1_HIGH_LIMIT_FRAC_VALUE_ADDR	0x0E
+#define MCP9982_EXT1_LOW_LIMIT_INT_VALUE_ADDR	0x0F
+#define MCP9982_EXT1_LOW_LIMIT_FRAC_VALUE_ADDR	0x10
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
+#define MCP9982_HOTTEST_INT_VALUE_ADDR		0x2F
+#define MCP9982_HOTTEST_FRAC_VALUE_ADDR		0x30
+#define MCP9982_HOTTEST_STATUS_ADDR		0x31
+#define MCP9982_THERM_SHTDWN_CFG_ADDR		0x32
+#define MCP9982_HRDW_THERM_SHTDWN_LIMIT_ADDR	0x33
+#define MCP9982_EXT_BETA_CFG_ADDR(index)	((index) + 52)
+#define MCP9982_EXT_IDEAL_ADDR(index)		((index) + 54)
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
+
+/* The maximum number of channels a member of the family can have */
+#define MCP9982_MAX_NUM_CHANNELS		5
+
+#define MCP9982_CHAN(index, si, __address) ({						\
+	struct iio_chan_spec __chan = {							\
+		.type = IIO_TEMP,							\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),				\
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |			\
+		BIT(IIO_CHAN_INFO_OFFSET),						\
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |		\
+		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |			\
+		BIT(IIO_CHAN_INFO_HYSTERESIS) |						\
+		BIT(IIO_CHAN_INFO_OFFSET),						\
+		.channel = index,							\
+		.address = __address,							\
+		.scan_index = si,							\
+		.scan_type = {								\
+			.sign = 'u',							\
+			.realbits = 8,							\
+			.storagebits = 8,						\
+		},									\
+		.indexed = 1,								\
+	};										\
+	__chan;										\
+})
+
+/**
+ * struct mcp9982_features - features of a mcp9982 instance
+ * @name:		chip's name
+ * @phys_channels:	number of physical channels supported by the chip
+ */
+struct mcp9982_features {
+	const char	*name;
+	u8		phys_channels;
+};
+
+static const struct mcp9982_features mcp9933_chip_config = {
+	.name = "mcp9933",
+	.phys_channels = 3,
+};
+
+static const struct mcp9982_features mcp9933d_chip_config = {
+	.name = "mcp9933d",
+	.phys_channels = 3,
+};
+
+static const struct mcp9982_features mcp9982_chip_config = {
+	.name = "mcp9982",
+	.phys_channels = 2,
+};
+
+static const struct mcp9982_features mcp9982d_chip_config = {
+	.name = "mcp9982d",
+	.phys_channels = 2,
+};
+
+static const struct mcp9982_features mcp9983_chip_config = {
+	.name = "mcp9983",
+	.phys_channels = 3,
+};
+
+static const struct mcp9982_features mcp9983d_chip_config = {
+	.name = "mcp9983d",
+	.phys_channels = 3,
+};
+
+static const struct mcp9982_features mcp9984_chip_config = {
+	.name = "mcp9984",
+	.phys_channels = 4,
+};
+
+static const struct mcp9982_features mcp9984d_chip_config = {
+	.name = "mcp9984d",
+	.phys_channels = 4,
+};
+
+static const struct mcp9982_features mcp9985_chip_config = {
+	.name = "mcp9985",
+	.phys_channels = 5,
+};
+
+static const struct mcp9982_features mcp9985d_chip_config = {
+	.name = "mcp9985d",
+	.phys_channels = 5,
+};
+
+static const unsigned int mcp9982_fractional_values[] = {
+	0,
+	125000,
+	250000,
+	375000,
+	500000,
+	625000,
+	750000,
+	875000,
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
+static unsigned int mcp9982_3db_values_map_tbl[11][3][2];
+static const unsigned int mcp9982_sampl_fr[][2] = {
+	{ 1, 16 },
+	{ 1, 8 },
+	{ 1, 4 },
+	{ 1, 2 },
+	{ 1, 1 },
+	{ 2, 1 },
+	{ 4, 1 },
+	{ 8, 1 },
+	{ 16, 1 },
+	{ 32, 1 },
+	{ 64, 1 },
+};
+
+static const unsigned int mcp9982_window_size[3] = {1, 4, 8};
+
+/*
+ * (Sampling_Frequency * 1000000) / (Window_Size * 2)
+ */
+static unsigned int mcp9982_calc_all_3db_values(void)
+{
+	u32 denominator, remainder;
+	unsigned int i, j;
+	u64 numerator;
+
+	for (i = 0; i < ARRAY_SIZE(mcp9982_window_size); i++)
+		for (j = 0; j <  ARRAY_SIZE(mcp9982_sampl_fr); j++) {
+			numerator = MICRO * mcp9982_sampl_fr[j][0];
+			denominator = 2 * mcp9982_window_size[i] * mcp9982_sampl_fr[j][1];
+			remainder = do_div(numerator, denominator);
+			remainder = do_div(numerator, MICRO);
+			mcp9982_3db_values_map_tbl[j][i][0] = numerator;
+			mcp9982_3db_values_map_tbl[j][i][1] = remainder;
+		}
+	return 0;
+}
+
+/* mcp9982 regmap configuration */
+static const struct regmap_range mcp9982_regmap_wr_ranges[] = {
+	regmap_reg_range(MCP9982_ONE_SHOT_ADDR, MCP9982_EXT1_LOW_LIMIT_FRAC_VALUE_ADDR),
+	regmap_reg_range(MCP9982_INTERNAL_THERM_LIMIT_ADDR, MCP9982_EXT1_THERM_LIMIT_ADDR),
+	regmap_reg_range(MCP9982_CFG_ADDR, MCP9982_CFG_ADDR),
+	regmap_reg_range(MCP9982_CONV_ADDR, MCP9982_HOTTEST_CFG_ADDR),
+	regmap_reg_range(MCP9982_THERM_SHTDWN_CFG_ADDR, MCP9982_THERM_SHTDWN_CFG_ADDR),
+	regmap_reg_range(MCP9982_EXT_BETA_CFG_ADDR(0), MCP9982_EXT_IDEAL_ADDR(3)),
+};
+
+static const struct regmap_access_table mcp9982_regmap_wr_table = {
+	.yes_ranges = mcp9982_regmap_wr_ranges,
+	.n_yes_ranges = ARRAY_SIZE(mcp9982_regmap_wr_ranges),
+};
+
+static const struct regmap_range mcp9982_regmap_rd_ranges[] = {
+	regmap_reg_range(MCP9982_INT_VALUE_ADDR(0),
+			 MCP9982_EXT1_LOW_LIMIT_FRAC_VALUE_ADDR),
+	regmap_reg_range(MCP9982_INTERNAL_THERM_LIMIT_ADDR, MCP9982_EXT1_THERM_LIMIT_ADDR),
+	regmap_reg_range(MCP9982_CFG_ADDR, MCP9982_CFG_ADDR),
+	regmap_reg_range(MCP9982_CONV_ADDR, MCP9982_EXT_IDEAL_ADDR(3)),
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
+	case MCP9982_EXT1_HIGH_LIMIT_INT_VALUE_ADDR:
+	case MCP9982_EXT1_HIGH_LIMIT_FRAC_VALUE_ADDR:
+	case MCP9982_EXT1_LOW_LIMIT_INT_VALUE_ADDR:
+	case MCP9982_EXT1_LOW_LIMIT_FRAC_VALUE_ADDR:
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
+};
+
+/**
+ * struct mcp9992_priv - information about chip parameters
+ * @regmap:			device register map
+ * @num_channels		number of physical channels
+ * @extended_temp_range		use extended temperature range or not
+ * @recd34_enable		state of REC on channels 3 and 4
+ * @recd12_enable		state of REC on channels 1 and 2
+ * @beta_values			beta compensation value for external channel 1 and 2
+ * @lock			synchronize access to driver's state members
+ * @iio_chan			specifications of channels
+ * @labels			labels of the channels
+ * @ideality_value		ideality factor value for each external channel
+ * @sampl_idx			index representing the current sampling frequency
+ * @dev_name			name of the device
+ * @apdd_enable			state of anti-parallel diode mode
+ */
+struct mcp9982_priv {
+	struct regmap *regmap;
+	u8 num_channels;
+	bool extended_temp_range;
+	bool recd34_enable;
+	bool recd12_enable;
+	unsigned int beta_values[2];
+	/*
+	 * Synchronize access to private members, and ensure
+	 * atomicity of consecutive regmap operations.
+	 */
+	struct mutex lock;
+	struct iio_chan_spec *iio_chan;
+	const char *labels[MCP9982_MAX_NUM_CHANNELS];
+	unsigned int ideality_value[4];
+	unsigned int sampl_idx;
+	const char *dev_name;
+	bool apdd_enable;
+};
+
+static int mcp9982_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length, long mask)
+{
+	struct mcp9982_priv *priv = iio_priv(indio_dev);
+	static const int offset[2] = {0, -64};
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		if (strchr(priv->dev_name, 'd')) {
+			*vals = mcp9982_conv_rate[4];
+			*length = (ARRAY_SIZE(mcp9982_conv_rate) - 4) * 2;
+		} else {
+			*vals = mcp9982_conv_rate[0];
+			*length = ARRAY_SIZE(mcp9982_conv_rate) * 2;
+		}
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*vals = mcp9982_3db_values_map_tbl[priv->sampl_idx][0];
+		*length = ARRAY_SIZE(mcp9982_3db_values_map_tbl[priv->sampl_idx]) * 2;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_OFFSET:
+		*type = IIO_VAL_INT;
+		*vals = offset;
+		*length = 2;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mcp9982_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	unsigned int index, idx, tmp_reg;
+	struct mcp9982_priv *priv = iio_priv(indio_dev);
+	int ret;
+
+	ret = regmap_write(priv->regmap, MCP9982_ONE_SHOT_ADDR, 1);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&priv->lock);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_read(priv->regmap, MCP9982_INT_VALUE_ADDR(chan->channel), val);
+		if (ret)
+			return ret;
+
+		/* The extended temperature range is offset by 64 degrees C */
+		if (priv->extended_temp_range)
+			*val -= 64;
+
+		ret = regmap_read(priv->regmap, MCP9982_FRAC_VALUE_ADDR(chan->channel), val2);
+		if (ret)
+			return ret;
+
+		/* Only the 3 MSB in fractional registers are used */
+		*val2 = mcp9982_fractional_values[*val2 >> 5];
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = mcp9982_conv_rate[priv->sampl_idx][0];
+		*val2 = mcp9982_conv_rate[priv->sampl_idx][1];
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+
+		ret = regmap_read(priv->regmap, MCP9982_RUNNING_AVG_ADDR, &tmp_reg);
+		if (ret)
+			return ret;
+		/*
+		 * In Filter Selection Register values 1 and 2
+		 * are mapped to the same setting.
+		 */
+		switch (tmp_reg) {
+		case 0:
+			idx = 0;
+			break;
+		case 1:
+		case 2:
+			idx = 1;
+			break;
+		default:
+			idx = 2;
+			break;
+		}
+
+		*val = mcp9982_3db_values_map_tbl[priv->sampl_idx][idx][0];
+		*val2 = mcp9982_3db_values_map_tbl[priv->sampl_idx][idx][1];
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_HYSTERESIS:
+		ret = regmap_read(priv->regmap, MCP9982_HYS_ADDR, &index);
+		if (ret)
+			return ret;
+
+		*val = index;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_OFFSET:
+		if (priv->extended_temp_range)
+			*val = -64;
+		else
+			*val = 0;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mcp9982_read_label(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+			      char *label)
+{
+	struct mcp9982_priv *priv = iio_priv(indio_dev);
+
+	if (chan->channel < 0 || chan->channel > 4)
+		return -EINVAL;
+
+	return sysfs_emit(label, "%s\n", priv->labels[chan->channel]);
+}
+
+static int mcp9982_write_raw_get_fmt(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+				     long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_HYSTERESIS:
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_OFFSET:
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mcp9982_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct mcp9982_priv *priv = iio_priv(indio_dev);
+	int ret;
+	unsigned int i;
+	unsigned int start = 0;
+
+	guard(mutex)(&priv->lock);
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		/*
+		 * For MCP998XD and MCP9933D sampling frequency can't
+		 * be set lower than 1.
+		 */
+		if (strchr(priv->dev_name, 'd'))
+			start = 4;
+		for (i = start; i < ARRAY_SIZE(mcp9982_conv_rate); i++)
+			if (val == mcp9982_conv_rate[i][0] && val2 == mcp9982_conv_rate[i][1])
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
+		return 0;
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
+		ret = regmap_write(priv->regmap, MCP9982_RUNNING_AVG_ADDR, i);
+
+		return ret;
+	case IIO_CHAN_INFO_HYSTERESIS:
+		if (val < 0 || val > 255)
+			return -EINVAL;
+
+		ret = regmap_write(priv->regmap, MCP9982_HYS_ADDR, val);
+		return ret;
+	case IIO_CHAN_INFO_OFFSET:
+		if (val != 0 && val != -64)
+			return -EINVAL;
+		priv->extended_temp_range = !(val == 0);
+		ret = regmap_assign_bits(priv->regmap, MCP9982_CFG_ADDR, MCP9982_CFG_RANGE,
+					 priv->extended_temp_range);
+		return ret;
+	default:
+		return -EINVAL;
+	}
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
+static int mcp9982_init(struct mcp9982_priv *priv)
+{
+	int ret;
+	unsigned int i;
+	u8 val;
+
+	/*
+	 * For chips with "D" in the name
+	 * set the below parameters to default to
+	 * ensure that hardware shutdown feature
+	 * can't be overridden.
+	 */
+	if (strchr(priv->dev_name, 'd')) {
+		priv->recd12_enable = true;
+		priv->recd34_enable = true;
+		for (i = 0; i < 2; i++)
+			priv->beta_values[i] = 16;
+		for (i = 0; i < 4; i++)
+			priv->ideality_value[i] = 18;
+	}
+
+	/*
+	 * Set default values in registers.
+	 * APDD, RECD12 and RECD34 are active on 0.
+	 */
+	val = FIELD_PREP(MCP9982_CFG_MSKAL, 1) | FIELD_PREP(MCP9982_CFG_RS, 1) |
+	      FIELD_PREP(MCP9982_CFG_ATTHM, 1) |
+	      FIELD_PREP(MCP9982_CFG_RECD12, !priv->recd12_enable) |
+	      FIELD_PREP(MCP9982_CFG_RECD34, !priv->recd34_enable) |
+	      FIELD_PREP(MCP9982_CFG_RANGE, 0) | FIELD_PREP(MCP9982_CFG_DA_ENA, 0) |
+	      FIELD_PREP(MCP9982_CFG_APDD, !priv->apdd_enable);
+
+	ret = regmap_write(priv->regmap, MCP9982_CFG_ADDR, val);
+	if (ret)
+		return ret;
+	priv->extended_temp_range = false;
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
+	/* Set beta compensation for channels 1 and 2 */
+	for (i = 0; i < 2; i++) {
+		ret = regmap_write(priv->regmap, MCP9982_EXT_BETA_CFG_ADDR(i),
+				   priv->beta_values[i]);
+		if (ret)
+			return ret;
+	}
+	/* Set ideality factor for all external channels */
+	for (i = 0; i < 4; i++) {
+		ret = regmap_write(priv->regmap, MCP9982_EXT_IDEAL_ADDR(i),
+				   priv->ideality_value[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int mcp9982_parse_of_config(struct iio_dev *indio_dev, struct device *dev,
+				   int device_nr_channels)
+{
+	unsigned int reg_nr, iio_idx;
+	struct mcp9982_priv *priv = iio_priv(indio_dev);
+
+	priv->apdd_enable = device_property_read_bool(dev, "microchip,enable-anti-parallel");
+
+	priv->recd12_enable = device_property_read_bool(dev,
+							"microchip,resistance-comp-ch1-2-enable");
+
+	priv->recd34_enable = device_property_read_bool(dev,
+							"microchip,resistance-comp-ch3-4-enable");
+
+	priv->beta_values[0] = 16;
+	priv->beta_values[1] = 16;
+	device_property_read_u32(dev, "microchip,beta1", &priv->beta_values[0]);
+	device_property_read_u32(dev, "microchip,beta2", &priv->beta_values[1]);
+	if (priv->beta_values[0] > 16 || priv->beta_values[1] > 16)
+		return -EINVAL;
+
+	priv->num_channels = device_get_child_node_count(dev) + 1;
+
+	if (priv->num_channels > device_nr_channels)
+		return dev_err_probe(dev, -EINVAL, "More channels than the chip supports\n");
+
+	priv->iio_chan = devm_kcalloc(dev, priv->num_channels, sizeof(*priv->iio_chan), GFP_KERNEL);
+	if (!priv->iio_chan)
+		return -ENOMEM;
+
+	priv->iio_chan[0] = MCP9982_CHAN(0, 0, MCP9982_INT_VALUE_ADDR(0));
+
+	priv->labels[0] = "internal diode";
+	iio_idx++;
+	device_for_each_child_node_scoped(dev, child) {
+		fwnode_property_read_u32(child, "reg", &reg_nr);
+		if (!reg_nr || reg_nr >= device_nr_channels)
+			return dev_err_probe(dev, -EINVAL,
+				     "The index of the channels does not match the chip\n");
+
+		priv->ideality_value[reg_nr - 1] = 18;
+		if (fwnode_property_present(child, "microchip,ideality-factor")) {
+			fwnode_property_read_u32(child, "microchip,ideality-factor",
+						 &priv->ideality_value[reg_nr - 1]);
+			if (priv->ideality_value[reg_nr - 1] > 63)
+				return dev_err_probe(dev, -EINVAL,
+				     "The ideality value is higher than maximum\n");
+		}
+
+		fwnode_property_read_string(child, "label",
+					    &priv->labels[reg_nr]);
+
+		priv->iio_chan[iio_idx++] = MCP9982_CHAN(reg_nr, reg_nr,
+							 MCP9982_INT_VALUE_ADDR(reg_nr));
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
+	priv->dev_name = chip->name;
+
+	ret = mcp9982_parse_of_config(indio_dev, &client->dev, chip->phys_channels);
+	if (ret)
+		return dev_err_probe(dev, ret, "Parameter parsing error\n");
+
+	mcp9982_calc_all_3db_values();
+	ret = mcp9982_init(priv);
+	if (ret)
+		return dev_err_probe(dev, ret, "Cannot initialize device\n");
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
+		.data = &mcp9933_chip_config
+	}, {
+		.compatible = "microchip,mcp9933d",
+		.data = &mcp9933d_chip_config
+	}, {
+		.compatible = "microchip,mcp9982",
+		.data = &mcp9982_chip_config
+	}, {
+		.compatible = "microchip,mcp9982d",
+		.data = &mcp9982d_chip_config
+	}, {
+		.compatible = "microchip,mcp9983",
+		.data = &mcp9983_chip_config
+	}, {
+		.compatible = "microchip,mcp9983d",
+		.data = &mcp9983d_chip_config
+	}, {
+		.compatible = "microchip,mcp9984",
+		.data = &mcp9984_chip_config
+	}, {
+		.compatible = "microchip,mcp9984d",
+		.data = &mcp9984d_chip_config
+	}, {
+		.compatible = "microchip,mcp9985",
+		.data = &mcp9985_chip_config
+	}, {
+		.compatible = "microchip,mcp9985d",
+		.data = &mcp9985d_chip_config
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


