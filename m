Return-Path: <linux-iio+bounces-5755-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A768FB241
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 14:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADAC01C21B79
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 12:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79101474BE;
	Tue,  4 Jun 2024 12:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kFCm6/+7"
X-Original-To: linux-iio@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F6E146D4C;
	Tue,  4 Jun 2024 12:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504225; cv=none; b=ak8HFIypkhqnYuM5V4JzRc4qMiZJhHhfDgV9MhPsjoT/FtsPm79JKf4JoOWzyNuUCGOUzSJW6PohXYvPoPYQRZjYG7HaTwSqaNL/QHyYoARecTiIJ3MckicCc5tNE89FiR/SvuX6xIrQ5xDaKqpRAfWiRI7REU7k3nb2UxLV1Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504225; c=relaxed/simple;
	bh=6xWTyodjrT1SPLw8LKxOjmFfzJAtO5y6pDoAzgdGO40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evxG7QQzlsy0yt+Fivj25ERH6dlujDyhtw6eh+jTdDsQbRJVX98RXD55v3OMRfWKI2787bh3XbzHZZSGGbVY4sWZvPtFwGdxbcCsiwW7oavttv3iEMqbmyLYESWLAulCEsLNL3Qe/m+dZpLlP1DrDPKPZIbSF5v1RMzHnZ4NVdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kFCm6/+7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717504221;
	bh=6xWTyodjrT1SPLw8LKxOjmFfzJAtO5y6pDoAzgdGO40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kFCm6/+7Bwq/SNtbK74kMEFZK22F71144noyHpftdXbWjxS+v0Ewrj/WUxhVJ6/Cz
	 pJvdIzGgrl/RBzF+QbFelYS2HxCETuNTMDtpbDHu9LQNBrGtLG8B6OvaQCX6q0q8/Z
	 uS+le8ZkeOIfQ14nvnEOPatbC1Y0TIMdalV3ICuQuXds4P4/Iu/HS4oojGVq/QRRrG
	 8T5/nVJ3akCBBce3RctYVpgUl7+3uq+vXomgOPXQp/8NdoWrBcj9kNIYVKbZebct9X
	 BW83wfORXVBt+DsfPtcOQhkSG5wCz/smRJ5B3V4uym9nAWO8viwc1QKe+cAFUCwFrL
	 ihFvYad/h+1cg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id F0C0A37821F5;
	Tue,  4 Jun 2024 12:30:19 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	lee@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	bigunclemax@gmail.com,
	dlechner@baylibre.com,
	marius.cristea@microchip.com,
	marcelo.schmitt@analog.com,
	fr0st61te@gmail.com,
	mitrutzceclan@gmail.com,
	mike.looijmans@topic.nl,
	marcus.folkesson@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	andy.shevchenko@gmail.com,
	kernel@collabora.com
Subject: [PATCH v2 4/5] iio: adc: Add support for MediaTek MT6357/8/9 Auxiliary ADC
Date: Tue,  4 Jun 2024 14:30:07 +0200
Message-ID: <20240604123008.327424-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604123008.327424-1-angelogioacchino.delregno@collabora.com>
References: <20240604123008.327424-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a driver to support reading the Auxiliary ADC IP found in the
MediaTek MT6357, MT6358 and MT6359 Power Management ICs, featuring
a different register layout, configurationm reset and ADC reading
sequence from the other already supported MediaTek SoC or PMIC
(aux)ADC HW.

This driver provides multiple ADC channels for system monitoring,
such as battery voltage, PMIC temperature, PMIC-internal voltage
regulators temperature, and others.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iio/adc/Kconfig         |  12 +
 drivers/iio/adc/Makefile        |   1 +
 drivers/iio/adc/mt6359-auxadc.c | 606 ++++++++++++++++++++++++++++++++
 3 files changed, 619 insertions(+)
 create mode 100644 drivers/iio/adc/mt6359-auxadc.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 8db68b80b391..1c3df21beaf3 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -870,6 +870,18 @@ config MCP3911
 	  This driver can also be built as a module. If so, the module will be
 	  called mcp3911.
 
+config MEDIATEK_MT6359_AUXADC
+	tristate "MediaTek MT6359 PMIC AUXADC driver"
+	depends on MFD_MT6397
+	help
+	  Say yes here to enable support for MediaTek MT6357, MT6358 and
+	  MT6359 PMICs Auxiliary ADC.
+	  This driver provides multiple channels for system monitoring,
+	  such as battery voltage, PMIC temperature, and others.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called mt6359-auxadc.
+
 config MEDIATEK_MT6360_ADC
 	tristate "Mediatek MT6360 ADC driver"
 	depends on MFD_MT6360
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index edb32ce2af02..da7d4452b1e0 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -79,6 +79,7 @@ obj-$(CONFIG_MCP320X) += mcp320x.o
 obj-$(CONFIG_MCP3422) += mcp3422.o
 obj-$(CONFIG_MCP3564) += mcp3564.o
 obj-$(CONFIG_MCP3911) += mcp3911.o
+obj-$(CONFIG_MEDIATEK_MT6359_AUXADC) += mt6359-auxadc.o
 obj-$(CONFIG_MEDIATEK_MT6360_ADC) += mt6360-adc.o
 obj-$(CONFIG_MEDIATEK_MT6370_ADC) += mt6370-adc.o
 obj-$(CONFIG_MEDIATEK_MT6577_AUXADC) += mt6577_auxadc.o
diff --git a/drivers/iio/adc/mt6359-auxadc.c b/drivers/iio/adc/mt6359-auxadc.c
new file mode 100644
index 000000000000..a4970cfb49a5
--- /dev/null
+++ b/drivers/iio/adc/mt6359-auxadc.c
@@ -0,0 +1,606 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek MT6359 PMIC AUXADC IIO driver
+ *
+ * Copyright (c) 2021 MediaTek Inc.
+ * Copyright (c) 2024 Collabora Ltd
+ * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
+
+#include <linux/iio/iio.h>
+
+#include <linux/mfd/mt6397/core.h>
+
+#include <dt-bindings/iio/adc/mediatek,mt6357-auxadc.h>
+#include <dt-bindings/iio/adc/mediatek,mt6358-auxadc.h>
+#include <dt-bindings/iio/adc/mediatek,mt6359-auxadc.h>
+
+#define AUXADC_AVG_TIME_US		10
+#define AUXADC_POLL_DELAY_US		100
+#define AUXADC_TIMEOUT_US		32000
+#define AUXADC_VOLT_FULL		1800
+#define IMP_STOP_DELAY_US		150
+#define IMP_POLL_DELAY_US		1000
+
+/* For PMIC_RG_RESET_VAL and MT6358_IMP0_CLEAR, the bits specific purpose is unknown. */
+#define PMIC_RG_RESET_VAL		(BIT(0) | BIT(3))
+#define PMIC_AUXADC_RDY_BIT		BIT(15)
+#define MT6357_IMP_ADC_NUM		30
+#define MT6358_IMP_ADC_NUM		28
+
+#define MT6358_DCM_CK_SW_EN		GENMASK(1, 0)
+#define MT6358_IMP0_CLEAR		(BIT(14) | BIT(7))
+#define MT6358_IMP0_IRQ_RDY		BIT(8)
+#define MT6358_IMP1_AUTOREPEAT_EN	BIT(15)
+
+#define MT6359_IMP0_CONV_EN		BIT(0)
+#define MT6359_IMP1_IRQ_RDY		BIT(15)
+
+enum mtk_pmic_auxadc_regs {
+	PMIC_AUXADC_ADC0,
+	PMIC_AUXADC_DCM_CON,
+	PMIC_AUXADC_IMP0,
+	PMIC_AUXADC_IMP1,
+	PMIC_AUXADC_IMP3,
+	PMIC_AUXADC_RQST0,
+	PMIC_AUXADC_RQST1,
+	PMIC_HK_TOP_WKEY,
+	PMIC_HK_TOP_RST_CON0,
+	PMIC_FGADC_R_CON0,
+	PMIC_AUXADC_REGS_MAX
+};
+
+enum mtk_pmic_auxadc_channels {
+	PMIC_AUXADC_CHAN_BATADC,
+	PMIC_AUXADC_CHAN_ISENSE,
+	PMIC_AUXADC_CHAN_VCDT,
+	PMIC_AUXADC_CHAN_BAT_TEMP,
+	PMIC_AUXADC_CHAN_BATID,
+	PMIC_AUXADC_CHAN_CHIP_TEMP,
+	PMIC_AUXADC_CHAN_VCORE_TEMP,
+	PMIC_AUXADC_CHAN_VPROC_TEMP,
+	PMIC_AUXADC_CHAN_VGPU_TEMP,
+	PMIC_AUXADC_CHAN_ACCDET,
+	PMIC_AUXADC_CHAN_VDCXO,
+	PMIC_AUXADC_CHAN_TSX_TEMP,
+	PMIC_AUXADC_CHAN_HPOFS_CAL,
+	PMIC_AUXADC_CHAN_DCXO_TEMP,
+	PMIC_AUXADC_CHAN_VBIF,
+	PMIC_AUXADC_CHAN_IBAT,
+	PMIC_AUXADC_CHAN_VBAT,
+	PMIC_AUXADC_CHAN_MAX
+};
+
+/**
+ * struct mt6359_auxadc - Main driver structure
+ * @dev:           Device pointer
+ * @regmap:        Regmap from SoC PMIC Wrapper
+ * @chip_info:     PMIC specific chip info
+ * @lock:          Mutex to serialize AUXADC reading vs configuration
+ * @timed_out:     Signals whether the last read timed out
+ */
+struct mt6359_auxadc {
+	struct device *dev;
+	struct regmap *regmap;
+	const struct mtk_pmic_auxadc_info *chip_info;
+	struct mutex lock;
+	bool timed_out;
+};
+
+/**
+ * struct mtk_pmic_auxadc_chan - PMIC AUXADC channel data
+ * @req_idx:       Request register number
+ * @req_mask:      Bitmask to activate a channel
+ * @num_samples:   Number of AUXADC samples for averaging
+ * @r_ratio:       Resistance ratio fractional
+ */
+struct mtk_pmic_auxadc_chan {
+	u8 req_idx;
+	u16 req_mask;
+	u16 num_samples;
+	struct u8_fract r_ratio;
+};
+
+/**
+ * struct mtk_pmic_auxadc_info - PMIC specific chip info
+ * @model_name:     PMIC model name
+ * @channels:       IIO specification of ADC channels
+ * @num_channels:   Number of ADC channels
+ * @desc:           PMIC AUXADC channel data
+ * @regs:           List of PMIC specific registers
+ * @sec_unlock_key: Security unlock key for HK_TOP writes
+ * @imp_adc_num:    ADC channel for battery impedance readings
+ * @read_imp:       Callback to read impedance channels
+ */
+struct mtk_pmic_auxadc_info {
+	const char *model_name;
+	const struct iio_chan_spec *channels;
+	u8 num_channels;
+	const struct mtk_pmic_auxadc_chan *desc;
+	const u16 *regs;
+	u16 sec_unlock_key;
+	u8 imp_adc_num;
+	int (*read_imp)(struct mt6359_auxadc *adc_dev, int *vbat, int *ibat);
+};
+
+#define MTK_PMIC_ADC_CHAN(_ch_idx, _req_idx, _req_bit, _samples, _rnum, _rdiv)	\
+	[PMIC_AUXADC_CHAN_##_ch_idx] = {					\
+		.req_idx = _req_idx,						\
+		.req_mask = BIT(_req_bit),					\
+		.num_samples = _samples,					\
+		.r_ratio = { _rnum, _rdiv }					\
+	}
+
+#define MTK_PMIC_IIO_CHAN(_model, _name, _ch_idx, _adc_idx, _nbits, _ch_type)	\
+{										\
+	.type = _ch_type,							\
+	.channel = _model##_AUXADC_##_ch_idx,					\
+	.address = _adc_idx,							\
+	.scan_index = PMIC_AUXADC_CHAN_##_ch_idx,				\
+	.datasheet_name = __stringify(_name),					\
+	.scan_type =  {								\
+		.sign = 'u',							\
+		.realbits = _nbits,						\
+		.storagebits = 16,						\
+		.endianness = IIO_CPU						\
+	},									\
+	.indexed = 1,								\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE)	\
+}
+
+static const struct iio_chan_spec mt6357_auxadc_channels[] = {
+	MTK_PMIC_IIO_CHAN(MT6357, bat_adc, BATADC, 0, 15, IIO_RESISTANCE),
+	MTK_PMIC_IIO_CHAN(MT6357, isense, ISENSE, 1, 12, IIO_CURRENT),
+	MTK_PMIC_IIO_CHAN(MT6357, cdt_v, VCDT, 2, 12, IIO_TEMP),
+	MTK_PMIC_IIO_CHAN(MT6357, batt_temp, BAT_TEMP, 3, 12, IIO_TEMP),
+	MTK_PMIC_IIO_CHAN(MT6357, chip_temp, CHIP_TEMP, 4, 12, IIO_TEMP),
+	MTK_PMIC_IIO_CHAN(MT6357, acc_det, ACCDET, 5, 12, IIO_RESISTANCE),
+	MTK_PMIC_IIO_CHAN(MT6357, dcxo_v, VDCXO, 6, 12, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6357, tsx_temp, TSX_TEMP, 7, 15, IIO_TEMP),
+	MTK_PMIC_IIO_CHAN(MT6357, hp_ofs_cal, HPOFS_CAL, 9, 15, IIO_RESISTANCE),
+	MTK_PMIC_IIO_CHAN(MT6357, dcxo_temp, DCXO_TEMP, 36, 15, IIO_TEMP),
+	MTK_PMIC_IIO_CHAN(MT6357, vcore_temp, VCORE_TEMP, 40, 12, IIO_TEMP),
+	MTK_PMIC_IIO_CHAN(MT6357, vproc_temp, VPROC_TEMP, 41, 12, IIO_TEMP),
+
+	/* Battery impedance channels */
+	MTK_PMIC_IIO_CHAN(MT6357, batt_v, VBAT, 0, 15, IIO_VOLTAGE),
+};
+
+static const struct mtk_pmic_auxadc_chan mt6357_auxadc_ch_desc[] = {
+	MTK_PMIC_ADC_CHAN(BATADC, PMIC_AUXADC_RQST0, 0, 128, 3, 1),
+	MTK_PMIC_ADC_CHAN(ISENSE, PMIC_AUXADC_RQST0, 0, 128, 3, 1),
+	MTK_PMIC_ADC_CHAN(VCDT, PMIC_AUXADC_RQST0, 0, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(BAT_TEMP, PMIC_AUXADC_RQST0, 3, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(CHIP_TEMP, PMIC_AUXADC_RQST0, 4, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(ACCDET, PMIC_AUXADC_RQST0, 5, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(TSX_TEMP, PMIC_AUXADC_RQST0, 7, 128, 1, 1),
+	MTK_PMIC_ADC_CHAN(HPOFS_CAL, PMIC_AUXADC_RQST0, 9, 256, 1, 1),
+	MTK_PMIC_ADC_CHAN(DCXO_TEMP, PMIC_AUXADC_RQST0, 10, 16, 1, 1),
+	MTK_PMIC_ADC_CHAN(VBIF, PMIC_AUXADC_RQST0, 11, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(VCORE_TEMP, PMIC_AUXADC_RQST1, 5, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(VPROC_TEMP, PMIC_AUXADC_RQST1, 6, 8, 1, 1),
+
+	/* Battery impedance channels */
+	MTK_PMIC_ADC_CHAN(VBAT, 0, 0, 128, 3, 1),
+};
+
+static const u16 mt6357_auxadc_regs[] = {
+	[PMIC_HK_TOP_RST_CON0]	= 0x0f90,
+	[PMIC_AUXADC_DCM_CON]	= 0x122e,
+	[PMIC_AUXADC_ADC0]	= 0x1088,
+	[PMIC_AUXADC_IMP0]	= 0x119c,
+	[PMIC_AUXADC_IMP1]	= 0x119e,
+	[PMIC_AUXADC_RQST0]	= 0x110e,
+	[PMIC_AUXADC_RQST1]	= 0x1114,
+};
+
+static const struct iio_chan_spec mt6358_auxadc_channels[] = {
+	MTK_PMIC_IIO_CHAN(MT6358, bat_adc, BATADC, 0, 15, IIO_RESISTANCE),
+	MTK_PMIC_IIO_CHAN(MT6358, cdt_v, VCDT, 2, 12, IIO_TEMP),
+	MTK_PMIC_IIO_CHAN(MT6358, batt_temp, BAT_TEMP, 3, 12, IIO_TEMP),
+	MTK_PMIC_IIO_CHAN(MT6358, chip_temp, CHIP_TEMP, 4, 12, IIO_TEMP),
+	MTK_PMIC_IIO_CHAN(MT6358, acc_det, ACCDET, 5, 12, IIO_RESISTANCE),
+	MTK_PMIC_IIO_CHAN(MT6358, dcxo_v, VDCXO, 6, 12, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6358, tsx_temp, TSX_TEMP, 7, 15, IIO_TEMP),
+	MTK_PMIC_IIO_CHAN(MT6358, hp_ofs_cal, HPOFS_CAL, 9, 15, IIO_RESISTANCE),
+	MTK_PMIC_IIO_CHAN(MT6358, dcxo_temp, DCXO_TEMP, 10, 15, IIO_TEMP),
+	MTK_PMIC_IIO_CHAN(MT6358, bif_v, VBIF, 11, 12, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6358, vcore_temp, VCORE_TEMP, 38, 12, IIO_TEMP),
+	MTK_PMIC_IIO_CHAN(MT6358, vproc_temp, VPROC_TEMP, 39, 12, IIO_TEMP),
+	MTK_PMIC_IIO_CHAN(MT6358, vgpu_temp, VGPU_TEMP, 40, 12, IIO_TEMP),
+
+	/* Battery impedance channels */
+	MTK_PMIC_IIO_CHAN(MT6358, batt_v, VBAT, 0, 15, IIO_VOLTAGE),
+};
+
+static const struct mtk_pmic_auxadc_chan mt6358_auxadc_ch_desc[] = {
+	MTK_PMIC_ADC_CHAN(BATADC, PMIC_AUXADC_RQST0, 0, 128, 3, 1),
+	MTK_PMIC_ADC_CHAN(VCDT, PMIC_AUXADC_RQST0, 0, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(BAT_TEMP, PMIC_AUXADC_RQST0, 3, 8, 2, 1),
+	MTK_PMIC_ADC_CHAN(CHIP_TEMP, PMIC_AUXADC_RQST0, 4, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(ACCDET, PMIC_AUXADC_RQST0, 5, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(VDCXO, PMIC_AUXADC_RQST0, 6, 8, 3, 2),
+	MTK_PMIC_ADC_CHAN(TSX_TEMP, PMIC_AUXADC_RQST0, 7, 128, 1, 1),
+	MTK_PMIC_ADC_CHAN(HPOFS_CAL, PMIC_AUXADC_RQST0, 9, 256, 1, 1),
+	MTK_PMIC_ADC_CHAN(DCXO_TEMP, PMIC_AUXADC_RQST0, 10, 16, 1, 1),
+	MTK_PMIC_ADC_CHAN(VBIF, PMIC_AUXADC_RQST0, 11, 8, 2, 1),
+	MTK_PMIC_ADC_CHAN(VCORE_TEMP, PMIC_AUXADC_RQST1, 8, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(VPROC_TEMP, PMIC_AUXADC_RQST1, 9, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(VGPU_TEMP, PMIC_AUXADC_RQST1, 10, 8, 1, 1),
+
+	/* Battery impedance channels */
+	MTK_PMIC_ADC_CHAN(VBAT, 0, 0, 128, 7, 2),
+};
+
+static const u16 mt6358_auxadc_regs[] = {
+	[PMIC_HK_TOP_RST_CON0]	= 0x0f90,
+	[PMIC_AUXADC_DCM_CON]	= 0x1260,
+	[PMIC_AUXADC_ADC0]	= 0x1088,
+	[PMIC_AUXADC_IMP0]	= 0x1208,
+	[PMIC_AUXADC_IMP1]	= 0x120a,
+	[PMIC_AUXADC_RQST0]	= 0x1108,
+	[PMIC_AUXADC_RQST1]	= 0x110a,
+};
+
+static const struct iio_chan_spec mt6359_auxadc_channels[] = {
+	MTK_PMIC_IIO_CHAN(MT6359, bat_adc, BATADC, 0, 15, IIO_RESISTANCE),
+	MTK_PMIC_IIO_CHAN(MT6359, batt_temp, BAT_TEMP, 3, 12, IIO_TEMP),
+	MTK_PMIC_IIO_CHAN(MT6359, chip_temp, CHIP_TEMP, 4, 12, IIO_TEMP),
+	MTK_PMIC_IIO_CHAN(MT6359, acc_det, ACCDET, 5, 12, IIO_RESISTANCE),
+	MTK_PMIC_IIO_CHAN(MT6359, dcxo_v, VDCXO, 6, 12, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6359, tsx_temp, TSX_TEMP, 7, 15, IIO_TEMP),
+	MTK_PMIC_IIO_CHAN(MT6359, hp_ofs_cal, HPOFS_CAL, 9, 15, IIO_RESISTANCE),
+	MTK_PMIC_IIO_CHAN(MT6359, dcxo_temp, DCXO_TEMP, 10, 15, IIO_TEMP),
+	MTK_PMIC_IIO_CHAN(MT6359, bif_v, VBIF, 11, 12, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6359, vcore_temp, VCORE_TEMP, 30, 12, IIO_TEMP),
+	MTK_PMIC_IIO_CHAN(MT6359, vproc_temp, VPROC_TEMP, 31, 12, IIO_TEMP),
+	MTK_PMIC_IIO_CHAN(MT6359, vgpu_temp, VGPU_TEMP, 32, 12, IIO_TEMP),
+
+	/* Battery impedance channels */
+	MTK_PMIC_IIO_CHAN(MT6359, batt_v, VBAT, 0, 15, IIO_VOLTAGE),
+	MTK_PMIC_IIO_CHAN(MT6359, batt_i, IBAT, 0, 15, IIO_CURRENT),
+};
+
+static const struct mtk_pmic_auxadc_chan mt6359_auxadc_ch_desc[] = {
+	MTK_PMIC_ADC_CHAN(BATADC, PMIC_AUXADC_RQST0, 0, 128, 7, 2),
+	MTK_PMIC_ADC_CHAN(BAT_TEMP, PMIC_AUXADC_RQST0, 3, 8, 5, 2),
+	MTK_PMIC_ADC_CHAN(CHIP_TEMP, PMIC_AUXADC_RQST0, 4, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(ACCDET, PMIC_AUXADC_RQST0, 5, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(VDCXO, PMIC_AUXADC_RQST0, 6, 8, 3, 2),
+	MTK_PMIC_ADC_CHAN(TSX_TEMP, PMIC_AUXADC_RQST0, 7, 128, 1, 1),
+	MTK_PMIC_ADC_CHAN(HPOFS_CAL, PMIC_AUXADC_RQST0, 9, 256, 1, 1),
+	MTK_PMIC_ADC_CHAN(DCXO_TEMP, PMIC_AUXADC_RQST0, 10, 16, 1, 1),
+	MTK_PMIC_ADC_CHAN(VBIF, PMIC_AUXADC_RQST0, 11, 8, 5, 2),
+	MTK_PMIC_ADC_CHAN(VCORE_TEMP, PMIC_AUXADC_RQST1, 8, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(VPROC_TEMP, PMIC_AUXADC_RQST1, 9, 8, 1, 1),
+	MTK_PMIC_ADC_CHAN(VGPU_TEMP, PMIC_AUXADC_RQST1, 10, 8, 1, 1),
+
+	/* Battery impedance channels */
+	MTK_PMIC_ADC_CHAN(VBAT, 0, 0, 128, 7, 2),
+	MTK_PMIC_ADC_CHAN(IBAT, 0, 0, 128, 7, 2),
+};
+
+static const u16 mt6359_auxadc_regs[] = {
+	[PMIC_FGADC_R_CON0]	= 0x0d88,
+	[PMIC_HK_TOP_WKEY]	= 0x0fb4,
+	[PMIC_HK_TOP_RST_CON0]	= 0x0f90,
+	[PMIC_AUXADC_RQST0]	= 0x1108,
+	[PMIC_AUXADC_RQST1]	= 0x110a,
+	[PMIC_AUXADC_ADC0]	= 0x1088,
+	[PMIC_AUXADC_IMP0]	= 0x1208,
+	[PMIC_AUXADC_IMP1]	= 0x120a,
+	[PMIC_AUXADC_IMP3]	= 0x120e,
+};
+
+static void mt6358_stop_imp_conv(struct mt6359_auxadc *adc_dev)
+{
+	const struct mtk_pmic_auxadc_info *cinfo = adc_dev->chip_info;
+	struct regmap *regmap = adc_dev->regmap;
+
+	regmap_set_bits(regmap, cinfo->regs[PMIC_AUXADC_IMP0], MT6358_IMP0_CLEAR);
+	regmap_clear_bits(regmap, cinfo->regs[PMIC_AUXADC_IMP0], MT6358_IMP0_CLEAR);
+	regmap_clear_bits(regmap, cinfo->regs[PMIC_AUXADC_IMP1], MT6358_IMP1_AUTOREPEAT_EN);
+	regmap_clear_bits(regmap, cinfo->regs[PMIC_AUXADC_DCM_CON], MT6358_DCM_CK_SW_EN);
+}
+
+static int mt6358_start_imp_conv(struct mt6359_auxadc *adc_dev)
+{
+	const struct mtk_pmic_auxadc_info *cinfo = adc_dev->chip_info;
+	struct regmap *regmap = adc_dev->regmap;
+	u32 val;
+	int ret;
+
+	regmap_set_bits(regmap, cinfo->regs[PMIC_AUXADC_DCM_CON], MT6358_DCM_CK_SW_EN);
+	regmap_set_bits(regmap, cinfo->regs[PMIC_AUXADC_IMP1], MT6358_IMP1_AUTOREPEAT_EN);
+
+	ret = regmap_read_poll_timeout(adc_dev->regmap, cinfo->regs[PMIC_AUXADC_IMP0],
+				       val, val & MT6358_IMP0_IRQ_RDY,
+				       IMP_POLL_DELAY_US, AUXADC_TIMEOUT_US);
+	if (ret) {
+		mt6358_stop_imp_conv(adc_dev);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int mt6358_read_imp(struct mt6359_auxadc *adc_dev, int *vbat, int *ibat)
+{
+	const struct mtk_pmic_auxadc_info *cinfo = adc_dev->chip_info;
+	struct regmap *regmap = adc_dev->regmap;
+	u16 reg_adc0 = cinfo->regs[PMIC_AUXADC_ADC0];
+	u32 val_v;
+	int ret;
+
+	ret = mt6358_start_imp_conv(adc_dev);
+	if (ret)
+		return ret;
+
+	/* Read the params before stopping */
+	regmap_read(regmap, reg_adc0 + (cinfo->imp_adc_num << 1), &val_v);
+
+	mt6358_stop_imp_conv(adc_dev);
+
+	if (vbat)
+		*vbat = val_v;
+	if (ibat)
+		*ibat = 0;
+
+	return 0;
+}
+
+static int mt6359_read_imp(struct mt6359_auxadc *adc_dev, int *vbat, int *ibat)
+{
+	const struct mtk_pmic_auxadc_info *cinfo = adc_dev->chip_info;
+	struct regmap *regmap = adc_dev->regmap;
+	u32 val, val_v, val_i;
+	int ret;
+
+	/* Start conversion */
+	regmap_write(regmap, cinfo->regs[PMIC_AUXADC_IMP0], MT6359_IMP0_CONV_EN);
+	ret = regmap_read_poll_timeout(regmap, cinfo->regs[PMIC_AUXADC_IMP1],
+				       val, val & MT6359_IMP1_IRQ_RDY,
+				       IMP_POLL_DELAY_US, AUXADC_TIMEOUT_US);
+
+	/* Stop conversion regardless of the result */
+	regmap_write(regmap, cinfo->regs[PMIC_AUXADC_IMP0], 0);
+	if (ret)
+		return ret;
+
+	/* If it succeeded, wait for the registers to be populated */
+	fsleep(IMP_STOP_DELAY_US);
+
+	ret = regmap_read(regmap, cinfo->regs[PMIC_AUXADC_IMP3], &val_v);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(regmap, cinfo->regs[PMIC_FGADC_R_CON0], &val_i);
+	if (ret)
+		return ret;
+
+	if (vbat)
+		*vbat = val_v;
+	if (ibat)
+		*ibat = val_i;
+
+	return 0;
+}
+
+static const struct mtk_pmic_auxadc_info mt6357_chip_info = {
+	.model_name = "MT6357",
+	.channels = mt6357_auxadc_channels,
+	.num_channels = ARRAY_SIZE(mt6357_auxadc_channels),
+	.desc = mt6357_auxadc_ch_desc,
+	.regs = mt6357_auxadc_regs,
+	.imp_adc_num = MT6357_IMP_ADC_NUM,
+	.read_imp = mt6358_read_imp,
+};
+
+static const struct mtk_pmic_auxadc_info mt6358_chip_info = {
+	.model_name = "MT6358",
+	.channels = mt6358_auxadc_channels,
+	.num_channels = ARRAY_SIZE(mt6358_auxadc_channels),
+	.desc = mt6358_auxadc_ch_desc,
+	.regs = mt6358_auxadc_regs,
+	.imp_adc_num = MT6358_IMP_ADC_NUM,
+	.read_imp = mt6358_read_imp,
+};
+
+static const struct mtk_pmic_auxadc_info mt6359_chip_info = {
+	.model_name = "MT6359",
+	.channels = mt6359_auxadc_channels,
+	.num_channels = ARRAY_SIZE(mt6359_auxadc_channels),
+	.desc = mt6359_auxadc_ch_desc,
+	.regs = mt6359_auxadc_regs,
+	.sec_unlock_key = 0x6359,
+	.read_imp = mt6359_read_imp,
+};
+
+static void mt6359_auxadc_reset(struct mt6359_auxadc *adc_dev)
+{
+	const struct mtk_pmic_auxadc_info *cinfo = adc_dev->chip_info;
+	struct regmap *regmap = adc_dev->regmap;
+
+	/* Unlock HK_TOP writes */
+	if (cinfo->sec_unlock_key)
+		regmap_write(regmap, cinfo->regs[PMIC_HK_TOP_WKEY], cinfo->sec_unlock_key);
+
+	/* Assert ADC reset */
+	regmap_set_bits(regmap, cinfo->regs[PMIC_HK_TOP_RST_CON0], PMIC_RG_RESET_VAL);
+
+	/* De-assert ADC reset. No wait required, as pwrap takes care of that for us. */
+	regmap_clear_bits(regmap, cinfo->regs[PMIC_HK_TOP_RST_CON0], PMIC_RG_RESET_VAL);
+
+	/* Lock HK_TOP writes again */
+	if (cinfo->sec_unlock_key)
+		regmap_write(regmap, cinfo->regs[PMIC_HK_TOP_WKEY], 0);
+}
+
+static int mt6359_auxadc_read_adc(struct mt6359_auxadc *adc_dev,
+				  const struct iio_chan_spec *chan, int *out)
+{
+	const struct mtk_pmic_auxadc_info *cinfo = adc_dev->chip_info;
+	const struct mtk_pmic_auxadc_chan *desc = &cinfo->desc[chan->scan_index];
+	struct regmap *regmap = adc_dev->regmap;
+	u32 val;
+	int ret;
+
+	/* Request to start sampling for ADC channel */
+	ret = regmap_write(regmap, cinfo->regs[desc->req_idx], desc->req_mask);
+	if (ret)
+		return ret;
+
+	/* Wait until all samples are averaged */
+	fsleep(desc->num_samples * AUXADC_AVG_TIME_US);
+
+	ret = regmap_read_poll_timeout(regmap,
+				       cinfo->regs[PMIC_AUXADC_ADC0] + (chan->address << 1),
+				       val, val & PMIC_AUXADC_RDY_BIT,
+				       AUXADC_POLL_DELAY_US, AUXADC_TIMEOUT_US);
+	if (ret)
+		return ret;
+
+	/* Stop sampling */
+	regmap_write(regmap, cinfo->regs[desc->req_idx], 0);
+
+	*out = val & GENMASK(chan->scan_type.realbits - 1, 0);
+	return 0;
+}
+
+static int mt6359_auxadc_read_label(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan, char *label)
+{
+	return sysfs_emit(label, "%s\n", chan->datasheet_name);
+}
+
+static int mt6359_auxadc_read_raw(struct iio_dev *indio_dev,
+				  const struct iio_chan_spec *chan,
+				  int *val, int *val2, long mask)
+{
+	struct mt6359_auxadc *adc_dev = iio_priv(indio_dev);
+	const struct mtk_pmic_auxadc_info *cinfo = adc_dev->chip_info;
+	const struct mtk_pmic_auxadc_chan *desc = &cinfo->desc[chan->scan_index];
+	int ret;
+
+	if (mask == IIO_CHAN_INFO_SCALE) {
+		*val = desc->r_ratio.numerator * AUXADC_VOLT_FULL;
+
+		if (desc->r_ratio.denominator > 1) {
+			*val2 = desc->r_ratio.denominator;
+			return IIO_VAL_FRACTIONAL;
+		}
+
+		return IIO_VAL_INT;
+	}
+
+	scoped_guard(mutex, &adc_dev->lock) {
+		switch (chan->scan_index) {
+		case PMIC_AUXADC_CHAN_IBAT:
+			ret = adc_dev->chip_info->read_imp(adc_dev, NULL, val);
+			break;
+		case PMIC_AUXADC_CHAN_VBAT:
+			ret = adc_dev->chip_info->read_imp(adc_dev, val, NULL);
+			break;
+		default:
+			ret = mt6359_auxadc_read_adc(adc_dev, chan, val);
+			break;
+		}
+	}
+
+	if (ret) {
+		/*
+		 * If we get more than one timeout, it's possible that the
+		 * AUXADC is stuck: perform a full reset to recover it.
+		 */
+		if (ret == -ETIMEDOUT) {
+			if (adc_dev->timed_out) {
+				dev_warn(adc_dev->dev, "Resetting stuck ADC!\r\n");
+				mt6359_auxadc_reset(adc_dev);
+			}
+			adc_dev->timed_out = true;
+		}
+		return ret;
+	}
+	adc_dev->timed_out = false;
+
+	return IIO_VAL_INT;
+}
+
+static const struct iio_info mt6359_auxadc_iio_info = {
+	.read_label = mt6359_auxadc_read_label,
+	.read_raw = mt6359_auxadc_read_raw,
+};
+
+static int mt6359_auxadc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device *mt6397_mfd_dev = dev->parent;
+	struct mt6359_auxadc *adc_dev;
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+	int ret;
+
+	/* Regmap is from SoC PMIC Wrapper, parent of the mt6397 MFD */
+	regmap = dev_get_regmap(mt6397_mfd_dev->parent, NULL);
+	if (!regmap)
+		return dev_err_probe(dev, -ENODEV, "Failed to get regmap\n");
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc_dev));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	adc_dev = iio_priv(indio_dev);
+	adc_dev->regmap = regmap;
+	adc_dev->dev = dev;
+
+	adc_dev->chip_info = device_get_match_data(dev);
+	if (!adc_dev->chip_info)
+		return -EINVAL;
+
+	mutex_init(&adc_dev->lock);
+
+	mt6359_auxadc_reset(adc_dev);
+
+	indio_dev->name = adc_dev->chip_info->model_name;
+	indio_dev->info = &mt6359_auxadc_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = adc_dev->chip_info->channels;
+	indio_dev->num_channels = adc_dev->chip_info->num_channels;
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register iio device\n");
+
+	return 0;
+}
+
+static const struct of_device_id mt6359_auxadc_of_match[] = {
+	{ .compatible = "mediatek,mt6357-auxadc", .data = &mt6357_chip_info },
+	{ .compatible = "mediatek,mt6358-auxadc", .data = &mt6358_chip_info },
+	{ .compatible = "mediatek,mt6359-auxadc", .data = &mt6359_chip_info },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mt6359_auxadc_of_match);
+
+static struct platform_driver mt6359_auxadc_driver = {
+	.driver = {
+		.name = "mt6359-auxadc",
+		.of_match_table = mt6359_auxadc_of_match,
+	},
+	.probe	= mt6359_auxadc_probe,
+};
+module_platform_driver(mt6359_auxadc_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>");
+MODULE_DESCRIPTION("MediaTek MT6359 PMIC AUXADC Driver");
-- 
2.45.1


