Return-Path: <linux-iio+bounces-5490-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B98F8D48A7
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 11:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C79D1286433
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 09:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8F8176ACE;
	Thu, 30 May 2024 09:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WlrrAioZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E17115D5A6;
	Thu, 30 May 2024 09:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717061671; cv=none; b=b57QYyKf2ePDqjmgb4umC9atItfZDroorkOndvexfNN0LD1W7nM/mkZaAf8DCQX1Kps8vMsk2GGAn2Ffn8wzLDE55+myNXQJ8HiMkk0moge1wZngEUaAnMZgNx4gTYjn659InpIsUolIopnbcnY7Rxqpk+4iQrHmUsvb0FGFFUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717061671; c=relaxed/simple;
	bh=9y2wYWsRUl0RFevN3rfCvyX/vfqF/FyafJd+gPdyaQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZWJ06VqxEoYjOYaVUa4r2NXYukKFuLK9DhEGbNdZ4f2xl9xpJBvJBDnS3SgE1bXVfZbOq2MuUP6KVS5h4U09Iw0wdxEPx09QEy/ouvvaJ5emGEDXiXoxPmmIiyUhW0Fpj3cSLLEUOYRZ4scZCCt89cxOL/YIq/rIafxqrlbZ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WlrrAioZ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717061666;
	bh=9y2wYWsRUl0RFevN3rfCvyX/vfqF/FyafJd+gPdyaQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WlrrAioZxPw2Tlzz8BNbGsle2ayzUEbU+grDX/tlsuRLyzBsbOK2EPjkbIdfwiFtH
	 Jl11IW8cODEmvh4hzltcnHMq13y3UoG+Lce+JqyNZdVP+vMMSxJGITkUbneECC8XSh
	 W/odHfBeXOuQ2LUEZubN0xZI/OZH2FL0SGO7j+OIfIr2zZmWOCYOHV0pBmC3B1eYOL
	 4eZbCzglhoAzn4U7NiRTXiOn90yx9SHI66SxUqLcLMFJbLMLqcTSQgXMY8srWHHzS+
	 xHR0TRuoIwtqAbHCVdt85ALFgnhzIC3vj3mywCBGsN+/4M9gt0TfzjS9vnZoirbWRt
	 gYmXgEBqOuzlg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 65DD237821AD;
	Thu, 30 May 2024 09:34:25 +0000 (UTC)
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
	kernel@collabora.com
Subject: [PATCH v1 2/4] iio: adc: Add support for MediaTek MT6357/8/9 Auxiliary ADC
Date: Thu, 30 May 2024 11:34:08 +0200
Message-ID: <20240530093410.112716-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530093410.112716-1-angelogioacchino.delregno@collabora.com>
References: <20240530093410.112716-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a driver to support reading the Auxiliary ADC IP found in the
MediaTek MT6357, MT6358 and MT6359 Power Management ICs.

This driver provides multiple ADC channels for system monitoring,
such as battery voltage, PMIC temperature, PMIC-internal voltage
regulators temperature, and others.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iio/adc/Kconfig         |  12 +
 drivers/iio/adc/Makefile        |   1 +
 drivers/iio/adc/mt6359-auxadc.c | 598 ++++++++++++++++++++++++++++++++
 3 files changed, 611 insertions(+)
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
index 000000000000..0481bd3f0144
--- /dev/null
+++ b/drivers/iio/adc/mt6359-auxadc.c
@@ -0,0 +1,598 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek MT6359 PMIC AUXADC IIO driver
+ *
+ * Copyright (c) 2021 MediaTek Inc.
+ * Copyright (c) 2024 Collabora Ltd
+ * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/iio/iio.h>
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
+#define PMIC_RG_RESET_VAL		(BIT(0) | BIT(3))
+#define PMIC_AUXADC_RDY_BIT		BIT(15)
+#define PMIC_AUXADC_ADCx(x)		((x) << 1)
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
+ * @pdata:         PMIC specific platform data
+ * @lock:          Mutex lock for AUXADC reads
+ * @timed_out:     Signals whether the last read timed out
+ */
+struct mt6359_auxadc {
+	struct device *dev;
+	struct regmap *regmap;
+	const struct mtk_pmic_auxadc_pdata *pdata;
+	struct mutex lock;
+	bool timed_out;
+};
+
+/**
+ * struct mtk_pmic_auxadc_chan - PMIC AUXADC channel data
+ * @req_idx:       Request register number
+ * @req_mask:      Bitmask to activate a channel
+ * @num_samples:   Number of AUXADC samples for averaging
+ * @r_numerator:   Resistance ratio numerator
+ * @r_denominator: Resistance ratio denominator
+ */
+struct mtk_pmic_auxadc_chan {
+	u8 req_idx;
+	u16 req_mask;
+	u16 num_samples;
+	u8 r_numerator;
+	u8 r_denominator;
+};
+
+/**
+ * struct mtk_pmic_auxadc_pdata - PMIC specific platform data
+ * @channels:       IIO specification of ADC channels
+ * @num_channels:   Number of ADC channels
+ * @desc:           PMIC AUXADC channel data
+ * @regs:           List of PMIC specific registers
+ * @sec_unlock_key: Security unlock key for HK_TOP writes
+ * @imp_adc_num:    ADC channel for IMP readings
+ * @read_imp:       Callback to read PMIC IMP channels
+ */
+struct mtk_pmic_auxadc_pdata {
+	const struct iio_chan_spec *channels;
+	int num_channels;
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
+		.r_numerator = _rnum,						\
+		.r_denominator = _rdiv,						\
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
+	/* IMP channels */
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
+	/* IMP channels */
+	MTK_PMIC_ADC_CHAN(VBAT, 0, 0, 128, 3, 1),
+};
+
+static const u16 mt6357_auxadc_regs[] = {
+	[PMIC_HK_TOP_RST_CON0]	= 0xf90,
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
+	/* IMP channels */
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
+	/* IMP channels */
+	MTK_PMIC_ADC_CHAN(VBAT, 0, 0, 128, 7, 2),
+};
+
+static const u16 mt6358_auxadc_regs[] = {
+	[PMIC_HK_TOP_RST_CON0]	= 0xf90,
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
+	/* IMP channels */
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
+	/* IMP channels */
+	MTK_PMIC_ADC_CHAN(VBAT, 0, 0, 128, 7, 2),
+	MTK_PMIC_ADC_CHAN(IBAT, 0, 0, 128, 7, 2),
+};
+
+static const u16 mt6359_auxadc_regs[] = {
+	[PMIC_FGADC_R_CON0]	= 0xd88,
+	[PMIC_HK_TOP_WKEY]	= 0xfb4,
+	[PMIC_HK_TOP_RST_CON0]	= 0xf90,
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
+	const struct mtk_pmic_auxadc_pdata *pdata = adc_dev->pdata;
+	struct regmap *regmap = adc_dev->regmap;
+
+	regmap_set_bits(regmap, pdata->regs[PMIC_AUXADC_IMP0], MT6358_IMP0_CLEAR);
+	regmap_clear_bits(regmap, pdata->regs[PMIC_AUXADC_IMP0], MT6358_IMP0_CLEAR);
+	regmap_clear_bits(regmap, pdata->regs[PMIC_AUXADC_IMP1], MT6358_IMP1_AUTOREPEAT_EN);
+	regmap_clear_bits(regmap, pdata->regs[PMIC_AUXADC_DCM_CON], MT6358_DCM_CK_SW_EN);
+}
+
+static int mt6358_start_imp_conv(struct mt6359_auxadc *adc_dev)
+{
+	const struct mtk_pmic_auxadc_pdata *pdata = adc_dev->pdata;
+	struct regmap *regmap = adc_dev->regmap;
+	u32 val;
+	int ret;
+
+	regmap_set_bits(regmap, pdata->regs[PMIC_AUXADC_DCM_CON], MT6358_DCM_CK_SW_EN);
+	regmap_set_bits(regmap, pdata->regs[PMIC_AUXADC_IMP1], MT6358_IMP1_AUTOREPEAT_EN);
+
+	ret = regmap_read_poll_timeout(adc_dev->regmap, pdata->regs[PMIC_AUXADC_IMP0],
+				       val, !!(val & MT6358_IMP0_IRQ_RDY),
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
+	const struct mtk_pmic_auxadc_pdata *pdata = adc_dev->pdata;
+	struct regmap *regmap = adc_dev->regmap;
+	u16 reg_adc0 = pdata->regs[PMIC_AUXADC_ADC0];
+	int val_v, ret;
+
+	ret = mt6358_start_imp_conv(adc_dev);
+	if (ret)
+		return ret;
+
+	/* Read the params before stopping */
+	regmap_read(regmap, reg_adc0 + PMIC_AUXADC_ADCx(pdata->imp_adc_num), &val_v);
+
+	mt6358_stop_imp_conv(adc_dev);
+
+	*vbat = val_v;
+	*ibat = 0;
+
+	return 0;
+}
+
+static int mt6359_read_imp(struct mt6359_auxadc *adc_dev, int *vbat, int *ibat)
+{
+	const struct mtk_pmic_auxadc_pdata *pdata = adc_dev->pdata;
+	struct regmap *regmap = adc_dev->regmap;
+	int val_v, val_i, ret;
+	u32 val;
+
+	/* Start conversion */
+	regmap_write(regmap, pdata->regs[PMIC_AUXADC_IMP0], MT6359_IMP0_CONV_EN);
+	ret = regmap_read_poll_timeout(regmap, pdata->regs[PMIC_AUXADC_IMP1],
+				       val, !!(val & MT6359_IMP1_IRQ_RDY),
+				       IMP_POLL_DELAY_US, AUXADC_TIMEOUT_US);
+
+	/* Stop conversion regardless of the result */
+	regmap_write(regmap, pdata->regs[PMIC_AUXADC_IMP0], 0);
+	if (ret)
+		return ret;
+
+	/* If it succeeded, wait for the registers to be populated */
+	usleep_range(IMP_STOP_DELAY_US, IMP_STOP_DELAY_US + 50);
+
+	ret = regmap_read(regmap, pdata->regs[PMIC_AUXADC_IMP3], &val_v);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(regmap, pdata->regs[PMIC_FGADC_R_CON0], &val_i);
+	if (ret)
+		return ret;
+
+	*vbat = val_v;
+	*ibat = val_i;
+
+	return 0;
+}
+
+static const struct mtk_pmic_auxadc_pdata mt6357_pdata = {
+	.channels = mt6357_auxadc_channels,
+	.num_channels = ARRAY_SIZE(mt6357_auxadc_channels),
+	.desc = mt6357_auxadc_ch_desc,
+	.regs = mt6357_auxadc_regs,
+	.imp_adc_num = MT6357_IMP_ADC_NUM,
+	.read_imp = mt6358_read_imp,
+};
+
+static const struct mtk_pmic_auxadc_pdata mt6358_pdata = {
+	.channels = mt6358_auxadc_channels,
+	.num_channels = ARRAY_SIZE(mt6358_auxadc_channels),
+	.desc = mt6358_auxadc_ch_desc,
+	.regs = mt6358_auxadc_regs,
+	.imp_adc_num = MT6358_IMP_ADC_NUM,
+	.read_imp = mt6358_read_imp,
+};
+
+static const struct mtk_pmic_auxadc_pdata mt6359_pdata = {
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
+	const struct mtk_pmic_auxadc_pdata *pdata = adc_dev->pdata;
+	struct regmap *regmap = adc_dev->regmap;
+
+	/* Unlock HK_TOP writes */
+	if (pdata->sec_unlock_key)
+		regmap_write(regmap, pdata->regs[PMIC_HK_TOP_WKEY], pdata->sec_unlock_key);
+
+	/* Assert ADC reset */
+	regmap_set_bits(regmap, pdata->regs[PMIC_HK_TOP_RST_CON0], PMIC_RG_RESET_VAL);
+
+	/* De-assert ADC reset */
+	regmap_clear_bits(regmap, pdata->regs[PMIC_HK_TOP_RST_CON0], PMIC_RG_RESET_VAL);
+
+	/* Lock HK_TOP writes again */
+	if (pdata->sec_unlock_key)
+		regmap_write(regmap, pdata->regs[PMIC_HK_TOP_WKEY], 0);
+}
+
+static int mt6359_auxadc_read_adc(struct mt6359_auxadc *adc_dev,
+				  const struct iio_chan_spec *chan, int *out)
+{
+	const struct mtk_pmic_auxadc_pdata *pdata = adc_dev->pdata;
+	const struct mtk_pmic_auxadc_chan *desc = &pdata->desc[chan->scan_index];
+	struct regmap *regmap = adc_dev->regmap;
+	u32 val;
+	int ret;
+
+	/* Request to start sampling for ADC channel */
+	ret = regmap_write(regmap, pdata->regs[desc->req_idx], desc->req_mask);
+	if (ret)
+		return ret;
+
+	/* Wait until all samples are averaged */
+	usleep_range(desc->num_samples * AUXADC_AVG_TIME_US,
+		     (desc->num_samples + 1) * AUXADC_AVG_TIME_US);
+
+	ret = regmap_read_poll_timeout(regmap,
+				       (pdata->regs[PMIC_AUXADC_ADC0] +
+					PMIC_AUXADC_ADCx(chan->address)),
+				       val, (val & PMIC_AUXADC_RDY_BIT),
+				       AUXADC_POLL_DELAY_US, AUXADC_TIMEOUT_US);
+	if (ret)
+		return ret;
+
+	/* Stop sampling */
+	regmap_write(regmap, pdata->regs[desc->req_idx], 0);
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
+	const struct mtk_pmic_auxadc_pdata *pdata = adc_dev->pdata;
+	const struct mtk_pmic_auxadc_chan *desc = &pdata->desc[chan->scan_index];
+	int ret;
+
+	if (mask == IIO_CHAN_INFO_SCALE) {
+		*val = desc->r_numerator * AUXADC_VOLT_FULL;
+
+		if (desc->r_denominator > 1) {
+			*val2 = desc->r_denominator;
+			return IIO_VAL_FRACTIONAL;
+		}
+
+		return IIO_VAL_INT;
+	}
+
+	mutex_lock(&adc_dev->lock);
+
+	switch (chan->scan_index) {
+	case PMIC_AUXADC_CHAN_IBAT:
+		ret = adc_dev->pdata->read_imp(adc_dev, val2, val);
+		break;
+	case PMIC_AUXADC_CHAN_VBAT:
+		ret = adc_dev->pdata->read_imp(adc_dev, val, val2);
+		break;
+	default:
+		ret = mt6359_auxadc_read_adc(adc_dev, chan, val);
+		break;
+	}
+
+	mutex_unlock(&adc_dev->lock);
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
+static const struct iio_info mt6359_auxadc_info = {
+	.read_label = mt6359_auxadc_read_label,
+	.read_raw = mt6359_auxadc_read_raw,
+};
+
+static int mt6359_auxadc_probe(struct platform_device *pdev)
+{
+	struct device *mt6397_mfd_dev = pdev->dev.parent;
+	struct mt6359_auxadc *adc_dev;
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+	int ret;
+
+	/* Regmap is from SoC PMIC Wrapper, parent of the mt6397 MFD */
+	regmap = dev_get_regmap(mt6397_mfd_dev->parent, NULL);
+	if (!regmap)
+		return dev_err_probe(&pdev->dev, -ENODEV, "Failed to get regmap\n");
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*adc_dev));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	adc_dev = iio_priv(indio_dev);
+	adc_dev->regmap = regmap;
+	adc_dev->dev = &pdev->dev;
+
+	adc_dev->pdata = device_get_match_data(&pdev->dev);
+	if (!adc_dev->pdata)
+		return -EINVAL;
+
+	mutex_init(&adc_dev->lock);
+
+	mt6359_auxadc_reset(adc_dev);
+
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->name = dev_name(&pdev->dev);
+	indio_dev->info = &mt6359_auxadc_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = adc_dev->pdata->channels;
+	indio_dev->num_channels = adc_dev->pdata->num_channels;
+
+	ret = devm_iio_device_register(&pdev->dev, indio_dev);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "failed to register iio device\n");
+
+	return 0;
+}
+
+static const struct of_device_id mt6359_auxadc_of_match[] = {
+	{ .compatible = "mediatek,mt6357-auxadc", .data = &mt6357_pdata },
+	{ .compatible = "mediatek,mt6358-auxadc", .data = &mt6358_pdata },
+	{ .compatible = "mediatek,mt6359-auxadc", .data = &mt6359_pdata },
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


