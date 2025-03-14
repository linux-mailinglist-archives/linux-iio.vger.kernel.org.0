Return-Path: <linux-iio+bounces-16811-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8070AA60A7C
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 08:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64430189FA8B
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 07:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82F818B482;
	Fri, 14 Mar 2025 07:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QD+Qt+mO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897718632B;
	Fri, 14 Mar 2025 07:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741938926; cv=none; b=fJO5fDuVGHdPJTek0Y0kYo8T7F8e92r80SA3zZk7P4ZVHxMzbyjeFyZECu3vlymFyFCSp8EMyTsFXiZTckf4Ae8c77zlAw5swrZFAqC4QHZvnffXBd3pjwC0ZnM4asavrQL9BFIOw6BFps3sCBVKScTulXlu3Z26y2Hyceubbbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741938926; c=relaxed/simple;
	bh=ZcZE48jeqmu+HkT/CmNXc+BbjK5FYJcxHBRj0H4RB0Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sk/TKOFKxDCao9LnJZmXKc/jQprJ+8/43kndR/sAFBaaaFFmFdTTSyGExG+/zVGaqOAtZShFyt5ocrN9gvLP0Y9RpLiB5wqUFhe7g10w3LoUSpqwKqULkYntKT5zgbB+IV5OUO1lj4ClFcMV2AH3wnvAv3zFp0C2JzPkm+7UOns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=QD+Qt+mO; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a88cafd400a911f0aae1fd9735fae912-20250314
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=zzDRu+hb/QXfno0Yz4OFCqUyJDkPo/hMuBDb0U62RbI=;
	b=QD+Qt+mOfcYqdd1+e0VLeMwMu4v9koYEFMv39NS/Yy0FmTAt1G3XxePxG2a8VepWL8yONjaJy9FIjSnptSJaLed5T+K++9hg/wwKqIMUzbkmzFeEa9MKlb++t5OQP4qHIED+UK9HqFXIgn3WcspcdfevfJfliuPsVTEegLFirZ4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:463a3d0c-1353-4a50-9d6e-5a6496ac0222,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:0ef645f,CLOUDID:0a575e8c-f5b8-47d5-8cf3-b68fe7530c9a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a88cafd400a911f0aae1fd9735fae912-20250314
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <lu.tang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1667442372; Fri, 14 Mar 2025 15:55:12 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 14 Mar 2025 15:55:11 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 14 Mar 2025 15:55:10 +0800
From: Lu.Tang <Lu.Tang@mediatek.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Sean Wang <sean.wang@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Stephen Boyd
	<sboyd@kernel.org>, Chen Zhong <chen.zhong@mediatek.com>, Sen Chu
	<shen.chu@mediatek.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-gpio@vger.kernel.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Lu.Tang
	<lu.tang@mediatek.com>
Subject: [PATCH 1/5] pmic: mediatek: Add pmic auxadc driver
Date: Fri, 14 Mar 2025 15:32:27 +0800
Message-ID: <20250314073307.25092-2-Lu.Tang@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250314073307.25092-1-Lu.Tang@mediatek.com>
References: <20250314073307.25092-1-Lu.Tang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: "Lu.Tang" <lu.tang@mediatek.com>

Add pmic mt6363 and mt6373 auxadc driver

Signed-off-by: Lu Tang <lu.tang@mediatek.com>
---
 drivers/iio/adc/Kconfig             |  10 +
 drivers/iio/adc/Makefile            |   1 +
 drivers/iio/adc/mtk-spmi-pmic-adc.c | 576 ++++++++++++++++++++++++++++
 3 files changed, 587 insertions(+)
 create mode 100644 drivers/iio/adc/mtk-spmi-pmic-adc.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 27413516216c..7c4b5f8f7209 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1039,6 +1039,16 @@ config MEDIATEK_MT6577_AUXADC
 	  This driver can also be built as a module. If so, the module will be
 	  called mt6577_auxadc.
 
+config MEDIATEK_SPMI_PMIC_ADC
+	tristate "MediaTek SPMI PMIC ADC Support"
+	depends on MFD_MTK_SPMI_PMIC
+	help
+	  Say yes here to enable support for MediaTek SPMI PMIC ADC.
+	  The driver supports multiple channels read.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called mtk-spmi-pmic-adc.
+
 config MEN_Z188_ADC
 	tristate "MEN 16z188 ADC IP Core support"
 	depends on MCB
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 9f26d5eca822..b3224abea040 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -91,6 +91,7 @@ obj-$(CONFIG_MEDIATEK_MT6359_AUXADC) += mt6359-auxadc.o
 obj-$(CONFIG_MEDIATEK_MT6360_ADC) += mt6360-adc.o
 obj-$(CONFIG_MEDIATEK_MT6370_ADC) += mt6370-adc.o
 obj-$(CONFIG_MEDIATEK_MT6577_AUXADC) += mt6577_auxadc.o
+obj-$(CONFIG_MEDIATEK_SPMI_PMIC_ADC) += mtk-spmi-pmic-adc.o
 obj-$(CONFIG_MEN_Z188_ADC) += men_z188_adc.o
 obj-$(CONFIG_MESON_SARADC) += meson_saradc.o
 obj-$(CONFIG_MP2629_ADC) += mp2629_adc.o
diff --git a/drivers/iio/adc/mtk-spmi-pmic-adc.c b/drivers/iio/adc/mtk-spmi-pmic-adc.c
new file mode 100644
index 000000000000..61e062bc8cf5
--- /dev/null
+++ b/drivers/iio/adc/mtk-spmi-pmic-adc.c
@@ -0,0 +1,576 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 MediaTek Inc.
+ */
+
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/iio/iio.h>
+#include <linux/kernel.h>
+#include <linux/mfd/mt6363/registers.h>
+#include <linux/mfd/mt6373/registers.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/property.h>
+#include <linux/platform_device.h>
+#include <linux/power_supply.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/syscore_ops.h>
+
+#include <dt-bindings/iio/mt635x-auxadc.h>
+
+#define AUXADC_RDY_BIT			BIT(15)
+
+#define AUXADC_DEF_R_RATIO		1
+#define AUXADC_DEF_AVG_NUM		32
+
+#define AUXADC_AVG_TIME_US		10
+#define AUXADC_POLL_DELAY_US		100
+#define AUXADC_TIMEOUT_US		32000
+#define VOLT_FULL			1840
+
+#define IMP_VOLT_FULL			18400
+#define IMIX_R_MIN_MOHM			100
+#define IMIX_R_CALI_CNT			2
+
+#define EXT_THR_PURES_SHIFT		3
+#define EXT_THR_SEL_MASK		0x1F
+
+#define DT_CHANNEL_CONVERT(val)		((val) & 0xFF)
+#define DT_PURES_CONVERT(val)		(((val) & 0xFF00) >> 8)
+
+struct pmic_adc_device {
+	struct device *dev;
+	struct regmap *regmap;
+	struct mutex lock;
+	struct iio_chan_spec *iio_chans;
+	unsigned int nchannels;
+	const struct auxadc_info *info;
+	struct regulator *isink_load;
+	int imix_r;
+	int imp_curr;
+	int pre_uisoc;
+};
+
+static struct pmic_adc_device *imix_r_dev;
+
+/*
+ * @ch_name:	HW channel name
+ * @res:	ADC resolution
+ * @r_ratio:	resistance ratio, represented by r_ratio[0] / r_ratio[1]
+ * @avg_num:	sampling times of AUXADC measurements then average it
+ * @regs:	request and data output registers for this channel
+ */
+struct auxadc_channels {
+	enum iio_chan_type type;
+	long info_mask;
+	/* AUXADC channel attribute */
+	const char *ch_name;
+	unsigned char res;
+	unsigned char r_ratio[2];
+	unsigned short avg_num;
+	const struct auxadc_regs *regs;
+};
+
+#define AUXADC_CHANNEL(_ch_name, _res)	\
+	[AUXADC_##_ch_name] = {				\
+		.type = IIO_VOLTAGE,			\
+		.info_mask = BIT(IIO_CHAN_INFO_RAW) |		\
+			     BIT(IIO_CHAN_INFO_PROCESSED),	\
+		.ch_name = __stringify(_ch_name),	\
+		.res = _res,				\
+	}
+
+/*
+ * The array represents all possible AUXADC channels found
+ * in the supported PMICs.
+ */
+static struct auxadc_channels auxadc_chans[] = {
+	AUXADC_CHANNEL(BATADC, 15),
+	AUXADC_CHANNEL(VCDT, 12),
+	AUXADC_CHANNEL(BAT_TEMP, 12),
+	AUXADC_CHANNEL(CHIP_TEMP, 12),
+	AUXADC_CHANNEL(VCORE_TEMP, 12),
+	AUXADC_CHANNEL(VPROC_TEMP, 12),
+	AUXADC_CHANNEL(VGPU_TEMP, 12),
+	AUXADC_CHANNEL(ACCDET, 12),
+	AUXADC_CHANNEL(HPOFS_CAL, 15),
+	AUXADC_CHANNEL(VTREF, 12),
+	AUXADC_CHANNEL(VBIF, 12),
+	AUXADC_CHANNEL(IMP, 15),
+	[AUXADC_IMIX_R] = {
+		.type = IIO_RESISTANCE,
+		.info_mask = BIT(IIO_CHAN_INFO_RAW),
+		.ch_name = "IMIX_R",
+	},
+	AUXADC_CHANNEL(VSYSSNS, 15),
+	AUXADC_CHANNEL(VIN1, 15),
+	AUXADC_CHANNEL(VIN2, 15),
+	AUXADC_CHANNEL(VIN3, 15),
+	AUXADC_CHANNEL(VIN4, 15),
+	AUXADC_CHANNEL(VIN5, 15),
+	AUXADC_CHANNEL(VIN6, 15),
+	AUXADC_CHANNEL(VIN7, 15),
+};
+
+struct auxadc_regs {
+	unsigned int enable_reg;
+	unsigned int enable_mask;
+	unsigned int ready_reg;
+	unsigned int ready_mask;
+	unsigned int value_reg;
+	unsigned int ext_thr_sel;
+	u8 src_sel;
+};
+
+#define AUXADC_REG(_ch_name, _chip, _enable_reg, _enable_mask, _value_reg) \
+	[AUXADC_##_ch_name] = {				\
+		.enable_reg = _chip##_##_enable_reg,	\
+		.enable_mask = _enable_mask,		\
+		.ready_reg = _chip##_##_value_reg,	\
+		.ready_mask = AUXADC_RDY_BIT,		\
+		.value_reg = _chip##_##_value_reg,	\
+	}						\
+
+#define TIA_ADC_REG(_src_sel, _chip)	\
+	[AUXADC_VIN##_src_sel] = {			\
+		.enable_reg = _chip##_AUXADC_RQST1,	\
+		.enable_mask = BIT(4),			\
+		.ready_reg = _chip##_AUXADC_ADC_CH12_L,	\
+		.ready_mask = AUXADC_RDY_BIT,		\
+		.value_reg = _chip##_AUXADC_ADC_CH12_L,	\
+		.ext_thr_sel = _chip##_SDMADC_CON0,	\
+		.src_sel = _src_sel,			\
+	}						\
+
+static const struct auxadc_regs mt6363_auxadc_regs_tbl[] = {
+	AUXADC_REG(BATADC, MT6363, AUXADC_RQST0, BIT(0), AUXADC_ADC0_L),
+	AUXADC_REG(BAT_TEMP, MT6363, AUXADC_RQST0, BIT(3), AUXADC_ADC3_L),
+	AUXADC_REG(CHIP_TEMP, MT6363, AUXADC_RQST0, BIT(4), AUXADC_ADC4_L),
+	AUXADC_REG(VCORE_TEMP, MT6363, AUXADC_RQST3, BIT(0), AUXADC_ADC38_L),
+	AUXADC_REG(VPROC_TEMP, MT6363, AUXADC_RQST3, BIT(1), AUXADC_ADC39_L),
+	AUXADC_REG(VGPU_TEMP, MT6363, AUXADC_RQST3, BIT(2), AUXADC_ADC40_L),
+	AUXADC_REG(VTREF, MT6363, AUXADC_RQST1, BIT(3), AUXADC_ADC11_L),
+	[AUXADC_IMP] = {
+		.enable_reg = MT6363_AUXADC_IMP0,
+		.enable_mask = BIT(0),
+		.ready_reg = MT6363_AUXADC_IMP1,
+		.ready_mask = BIT(7),
+		.value_reg = MT6363_AUXADC_ADC42_L,
+	},
+	AUXADC_REG(VSYSSNS, MT6363, AUXADC_RQST1, BIT(6), AUXADC_ADC_CH14_L),
+	TIA_ADC_REG(1, MT6363),
+	TIA_ADC_REG(2, MT6363),
+	TIA_ADC_REG(3, MT6363),
+	TIA_ADC_REG(4, MT6363),
+	TIA_ADC_REG(5, MT6363),
+	TIA_ADC_REG(6, MT6363),
+	TIA_ADC_REG(7, MT6363),
+};
+
+static const struct auxadc_regs mt6373_auxadc_regs_tbl[] = {
+	AUXADC_REG(CHIP_TEMP, MT6373, AUXADC_RQST0, BIT(4), AUXADC_ADC4_L),
+	AUXADC_REG(VCORE_TEMP, MT6373, AUXADC_RQST3, BIT(0), AUXADC_ADC38_L),
+	AUXADC_REG(VPROC_TEMP, MT6373, AUXADC_RQST3, BIT(1), AUXADC_ADC39_L),
+	AUXADC_REG(VGPU_TEMP, MT6373, AUXADC_RQST3, BIT(2), AUXADC_ADC40_L),
+	TIA_ADC_REG(1, MT6373),
+	TIA_ADC_REG(2, MT6373),
+	TIA_ADC_REG(3, MT6373),
+	TIA_ADC_REG(4, MT6373),
+	TIA_ADC_REG(5, MT6373),
+};
+
+struct auxadc_info {
+	const struct auxadc_regs *regs_tbl;
+};
+
+static const struct auxadc_info mt6363_info = {
+	.regs_tbl = mt6363_auxadc_regs_tbl,
+};
+
+static const struct auxadc_info mt6373_info = {
+	.regs_tbl = mt6373_auxadc_regs_tbl,
+};
+
+#define regmap_bulk_read_poll_timeout(map, addr, val, val_count, cond, sleep_us, timeout_us) \
+({ \
+	u64 __timeout_us = (timeout_us); \
+	unsigned long __sleep_us = (sleep_us); \
+	ktime_t __timeout = ktime_add_us(ktime_get(), __timeout_us); \
+	int __ret; \
+	might_sleep_if(__sleep_us); \
+	for (;;) { \
+		__ret = regmap_bulk_read((map), (addr), (u8 *) &(val), val_count); \
+		if (__ret) \
+			break; \
+		if (cond) \
+			break; \
+		if ((__timeout_us) && \
+		    ktime_compare(ktime_get(), __timeout) > 0) { \
+			__ret = regmap_bulk_read((map), (addr), (u8 *) &(val), val_count); \
+			break; \
+		} \
+		if (__sleep_us) \
+			usleep_range((__sleep_us >> 2) + 1, __sleep_us); \
+	} \
+	__ret ?: ((cond) ? 0 : -ETIMEDOUT); \
+})
+
+/*
+ * @adc_dev:	 pointer to the struct pmic_adc_device
+ * @auxadc_chan: pointer to the struct auxadc_channels, it represents specific
+		 auxadc channel
+ * @val:	 pointer to output value
+ */
+static int get_auxadc_out(struct pmic_adc_device *adc_dev,
+			  int channel, int channel2, int *val)
+{
+	int ret;
+	u16 buf = 0;
+	const struct auxadc_channels *auxadc_chan = &auxadc_chans[channel];
+
+	if (!auxadc_chan->regs)
+		return -EINVAL;
+
+	if (auxadc_chan->regs->ext_thr_sel) {
+		buf = (channel2 << EXT_THR_PURES_SHIFT)
+			| auxadc_chan->regs->src_sel;
+		ret = regmap_update_bits(adc_dev->regmap,
+					 auxadc_chan->regs->ext_thr_sel,
+					 EXT_THR_SEL_MASK, buf);
+		if (ret < 0)
+			return ret;
+	}
+	regmap_write(adc_dev->regmap,
+		     auxadc_chan->regs->enable_reg,
+		     auxadc_chan->regs->enable_mask);
+	usleep_range(auxadc_chan->avg_num * AUXADC_AVG_TIME_US,
+		     (auxadc_chan->avg_num + 1) * AUXADC_AVG_TIME_US);
+
+	ret = regmap_bulk_read_poll_timeout(adc_dev->regmap,
+					    auxadc_chan->regs->value_reg,
+					    buf, 2,
+					    (buf & AUXADC_RDY_BIT),
+					    AUXADC_POLL_DELAY_US,
+					    AUXADC_TIMEOUT_US);
+	*val = buf & (BIT(auxadc_chan->res) - 1);
+	if (ret)
+		dev_err(adc_dev->dev, "%s ret error code:%d!\n", auxadc_chan->ch_name, ret);
+
+	/* set PURES to OPEN after measuring done */
+	if (auxadc_chan->regs->ext_thr_sel) {
+		buf = (ADC_PURES_OPEN << EXT_THR_PURES_SHIFT)
+			| auxadc_chan->regs->src_sel;
+		ret = regmap_update_bits(adc_dev->regmap,
+					 auxadc_chan->regs->ext_thr_sel,
+					 EXT_THR_SEL_MASK, buf);
+	}
+
+	return ret;
+}
+
+static int gauge_get_imp_ibat(void)
+{
+	struct power_supply *psy;
+	union power_supply_propval prop;
+	int ret;
+
+	psy = power_supply_get_by_name("mtk-gauge");
+	if (!psy)
+		return 0;
+
+	ret = power_supply_get_property(psy, POWER_SUPPLY_PROP_CURRENT_NOW, &prop);
+	if (ret)
+		return ret;
+
+	power_supply_put(psy);
+	return prop.intval;
+}
+
+static int get_imp_out(struct pmic_adc_device *adc_dev, int *val)
+{
+	int ret;
+	unsigned int buf = 0;
+	const struct auxadc_channels *auxadc_chan = &auxadc_chans[AUXADC_IMP];
+
+	if (!auxadc_chan->regs)
+		return -EINVAL;
+
+	regmap_write(adc_dev->regmap,
+		     auxadc_chan->regs->enable_reg,
+		     auxadc_chan->regs->enable_mask);
+	ret = regmap_read_poll_timeout(adc_dev->regmap, auxadc_chan->regs->ready_reg,
+					   buf, buf & auxadc_chan->regs->ready_mask,
+					   AUXADC_POLL_DELAY_US,
+					   AUXADC_TIMEOUT_US);
+	if (ret) {
+		dev_err(adc_dev->dev, "%s %s ret error code:%d!\n",
+			__func__, auxadc_chan->ch_name, ret);
+		return ret;
+	}
+
+	ret = regmap_bulk_read(adc_dev->regmap, auxadc_chan->regs->value_reg, (u8 *) &buf, 2);
+	if (ret)
+		return ret;
+	*val = buf & (BIT(auxadc_chan->res) - 1);
+	adc_dev->imp_curr = gauge_get_imp_ibat();
+
+	regmap_write(adc_dev->regmap,
+		     auxadc_chan->regs->enable_reg, 0);
+
+	return 0;
+}
+
+static int pmic_adc_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct pmic_adc_device *adc_dev = iio_priv(indio_dev);
+	const struct auxadc_channels *auxadc_chan;
+	int auxadc_out = 0;
+	int ret = 0;
+
+	mutex_lock(&adc_dev->lock);
+	switch (chan->channel) {
+	case AUXADC_IMP:
+		ret = get_imp_out(adc_dev, &auxadc_out);
+		break;
+	case AUXADC_IMIX_R:
+		auxadc_out = adc_dev->imix_r;
+		break;
+	default:
+		ret = get_auxadc_out(adc_dev,
+				     chan->channel, chan->channel2,
+				     &auxadc_out);
+		break;
+	}
+	mutex_unlock(&adc_dev->lock);
+
+	if (ret && ret != -ETIMEDOUT)
+		return ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_PROCESSED:
+		auxadc_chan = &auxadc_chans[chan->channel];
+		*val = auxadc_out * auxadc_chan->r_ratio[0] * VOLT_FULL;
+		*val = (*val / auxadc_chan->r_ratio[1]) >> auxadc_chan->res;
+		ret = IIO_VAL_INT;
+		break;
+	case IIO_CHAN_INFO_RAW:
+		*val = auxadc_out;
+		ret = IIO_VAL_INT;
+		break;
+	default:
+		return -EINVAL;
+	}
+	if (chan->channel == AUXADC_IMP) {
+		*val2 = adc_dev->imp_curr;
+		ret = IIO_VAL_INT_MULTIPLE;
+	}
+
+	return ret;
+}
+
+static int pmic_adc_fwnode_xlate(struct iio_dev *indio_dev,
+			     const struct fwnode_reference_args *iiospec)
+{
+	int i;
+	int channel = DT_CHANNEL_CONVERT(iiospec->args[0]);
+	int channel2 = DT_PURES_CONVERT(iiospec->args[0]);
+
+	for (i = 0; i < indio_dev->num_channels; i++) {
+		if (indio_dev->channels[i].channel == channel &&
+		    indio_dev->channels[i].channel2 == channel2)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static const struct iio_info pmic_adc_info = {
+	.read_raw = &pmic_adc_read_raw,
+	.fwnode_xlate = &pmic_adc_fwnode_xlate,
+};
+
+static int auxadc_init_imix_r(struct pmic_adc_device *adc_dev,
+			      struct device_node *imix_r_node)
+{
+	unsigned int val = 0;
+	int ret;
+
+	if (!adc_dev)
+		return -EINVAL;
+
+	adc_dev->isink_load = devm_regulator_get_exclusive(adc_dev->dev, "isink_load");
+	if (IS_ERR(adc_dev->isink_load)) {
+		dev_err(adc_dev->dev, "Failed to get isink_load regulator, ret=%d\n",
+			(int)PTR_ERR(adc_dev->isink_load));
+		return PTR_ERR(adc_dev->isink_load);
+	}
+
+	imix_r_dev = adc_dev;
+	if (imix_r_dev->imix_r)
+		return 0;
+
+	ret = of_property_read_u32(imix_r_node, "val", &val);
+	if (ret)
+		dev_notice(imix_r_dev->dev, "no imix_r, ret=%d\n", ret);
+	imix_r_dev->imix_r = (int)val;
+	imix_r_dev->pre_uisoc = 101;
+	return 0;
+}
+
+static int auxadc_get_data_from_dt(struct pmic_adc_device *adc_dev,
+				   struct iio_chan_spec *iio_chan,
+				   struct device_node *node)
+{
+	struct auxadc_channels *auxadc_chan;
+	unsigned int channel = 0;
+	unsigned int value = 0;
+	unsigned int val_arr[2] = {0};
+	int ret;
+
+	ret = of_property_read_u32(node, "channel", &channel);
+	if (ret) {
+		dev_err(adc_dev->dev, "invalid channel in node:%s\n",
+			   node->name);
+		return ret;
+	}
+	if (channel > AUXADC_CHAN_MAX) {
+		dev_err(adc_dev->dev, "invalid channel number %d in node:%s\n",
+			   channel, node->name);
+		return -EINVAL;
+	}
+	if (channel >= ARRAY_SIZE(auxadc_chans)) {
+		dev_err(adc_dev->dev, "channel number %d in node:%s not exists\n",
+			   channel, node->name);
+		return -EINVAL;
+	}
+	iio_chan->channel = channel;
+	iio_chan->datasheet_name = auxadc_chans[channel].ch_name;
+	iio_chan->info_mask_separate = auxadc_chans[channel].info_mask;
+	iio_chan->type = auxadc_chans[channel].type;
+	iio_chan->extend_name = node->name;
+	ret = of_property_read_u32(node, "pures", &value);
+	if (!ret)
+		iio_chan->channel2 = value;
+
+	if (channel == AUXADC_IMIX_R)
+		return auxadc_init_imix_r(adc_dev, node);
+
+	auxadc_chan = &auxadc_chans[channel];
+	auxadc_chan->regs = &adc_dev->info->regs_tbl[channel];
+
+	ret = of_property_read_u32_array(node, "resistance-ratio", val_arr, 2);
+	if (!ret) {
+		auxadc_chan->r_ratio[0] = val_arr[0];
+		auxadc_chan->r_ratio[1] = val_arr[1];
+	} else {
+		auxadc_chan->r_ratio[0] = AUXADC_DEF_R_RATIO;
+		auxadc_chan->r_ratio[1] = 1;
+	}
+
+	ret = of_property_read_u32(node, "avg-num", &value);
+	if (!ret)
+		auxadc_chan->avg_num = value;
+	else
+		auxadc_chan->avg_num = AUXADC_DEF_AVG_NUM;
+
+	return 0;
+}
+
+static int auxadc_parse_dt(struct pmic_adc_device *adc_dev,
+			   struct device_node *node)
+{
+	struct iio_chan_spec *iio_chan;
+	struct device_node *child;
+	unsigned int index = 0;
+	int ret;
+
+	adc_dev->nchannels = of_get_available_child_count(node);
+	if (!adc_dev->nchannels)
+		return -EINVAL;
+
+	adc_dev->iio_chans = devm_kcalloc(adc_dev->dev, adc_dev->nchannels,
+		sizeof(*adc_dev->iio_chans), GFP_KERNEL);
+	if (!adc_dev->iio_chans)
+		return -ENOMEM;
+	iio_chan = adc_dev->iio_chans;
+
+	for_each_available_child_of_node(node, child) {
+		ret = auxadc_get_data_from_dt(adc_dev, iio_chan, child);
+		if (ret < 0) {
+			of_node_put(child);
+			return ret;
+		}
+		iio_chan->indexed = 1;
+		iio_chan->address = index++;
+		iio_chan++;
+	}
+
+	return 0;
+}
+
+static int pmic_adc_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct pmic_adc_device *adc_dev;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*adc_dev));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	adc_dev = iio_priv(indio_dev);
+	adc_dev->dev = &pdev->dev;
+	adc_dev->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	mutex_init(&adc_dev->lock);
+	adc_dev->info = of_device_get_match_data(&pdev->dev);
+
+	ret = auxadc_parse_dt(adc_dev, node);
+	if (ret) {
+		dev_notice(&pdev->dev, "auxadc_parse_dt fail, ret=%d\n", ret);
+		return ret;
+	}
+
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->name = dev_name(&pdev->dev);
+	indio_dev->info = &pmic_adc_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = adc_dev->iio_chans;
+	indio_dev->num_channels = adc_dev->nchannels;
+
+	ret = devm_iio_device_register(&pdev->dev, indio_dev);
+	if (ret < 0) {
+		dev_notice(&pdev->dev, "failed to register iio device!\n");
+		return ret;
+	}
+
+	dev_dbg(&pdev->dev, "probe done\n");
+
+	return 0;
+}
+
+static const struct of_device_id pmic_adc_of_match[] = {
+	{ .compatible = "mediatek,mt6363-auxadc", .data = &mt6363_info, },
+	{ .compatible = "mediatek,mt6373-auxadc", .data = &mt6373_info, },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pmic_adc_of_match);
+
+static struct platform_driver pmic_adc_driver = {
+	.driver = {
+		.name = "mtk-spmi-pmic-adc",
+		.of_match_table = pmic_adc_of_match,
+	},
+	.probe	= pmic_adc_probe,
+};
+module_platform_driver(pmic_adc_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Lu Tang <lu.tang@mediatek.com>");
+MODULE_DESCRIPTION("MediaTek SPMI PMIC ADC Driver");
-- 
2.46.0


