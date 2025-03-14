Return-Path: <linux-iio+bounces-16812-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A9FA60A81
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 08:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6469A17F3C9
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 07:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF18C1953A2;
	Fri, 14 Mar 2025 07:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YoF5pl4K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C7715CD4A;
	Fri, 14 Mar 2025 07:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741938931; cv=none; b=an52VNm7Dj3VFMoIDncEQHjJc/MwVOAN08moOIbAtZ61Nw03/nMRKV4XFTSe2zNPaNEPCk9p5Jza2RFukDhEn/8cltFOD6xjrJYpZTc2vTDFvVoJmRFM95KRLnvxt1J87SiIfFeMHa30x5HauHOgnmXgxM6XLMcJKitqZYr6T4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741938931; c=relaxed/simple;
	bh=x8O+cVQkiIjFxyt9FNr4RI/iEusqLMSqlxE9BTflG+o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hq8x0+U0TM6sgq/C17gXz/ASsfXVKOFeiEisbx8LlcqG0w5dsc6veebgKH8toyaX8DNSAfHcRZOCDvGYAElrx9GloyHc9oKtaI05ScXcY71sVjYTwUdNBuu0iNNSSSrZ4w/MqGqe7rINziRyvNn4Gv5fIsHR2zkNmFGnMTFvJEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=YoF5pl4K; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ab6d747200a911f08eb9c36241bbb6fb-20250314
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=vkkild/Hn3SrCH3OFDvuROaLOzxsZuorcOOQckscz2g=;
	b=YoF5pl4K64fiIu+tEZ+X+Yj0MZeR/1jx5Hw5lAq1vdMWx7uSPtCINgZdkE0do049rdnia3Xh/eE3SNdlkqaGXfgXNKgrek0RZJw8nH7FNsifjBtWRNe9OhlnlH2+fBJOryPfB/m5dv3VDDj4xhM/yjXlNBCvPqBgIPoUW2yzJ4o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:5d7d49ad-57ed-4374-b9b9-50d8ad6017c5,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:5e575e8c-f5b8-47d5-8cf3-b68fe7530c9a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:1,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,OSH|NGT
X-CID-BAS: 2,OSH|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ab6d747200a911f08eb9c36241bbb6fb-20250314
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <lu.tang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1800418703; Fri, 14 Mar 2025 15:55:17 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 14 Mar 2025 15:55:15 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 14 Mar 2025 15:55:14 +0800
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
Subject: [PATCH 2/5] pmic: mediatek: Add pmic regulator driver
Date: Fri, 14 Mar 2025 15:32:28 +0800
Message-ID: <20250314073307.25092-3-Lu.Tang@mediatek.com>
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

Add pmic mt6316/mt6373/mt6363 regulator driver

Signed-off-by: Lu Tang <lu.tang@mediatek.com>
---
 drivers/regulator/Kconfig                  |   34 +
 drivers/regulator/Makefile                 |    3 +
 drivers/regulator/mt6316-regulator.c       |  381 +++++++
 drivers/regulator/mt6363-regulator.c       | 1106 ++++++++++++++++++++
 drivers/regulator/mt6373-regulator.c       |  826 +++++++++++++++
 include/linux/regulator/mt6316-regulator.h |   48 +
 include/linux/regulator/mt6363-regulator.h |  424 ++++++++
 include/linux/regulator/mt6373-regulator.h |  318 ++++++
 8 files changed, 3140 insertions(+)
 create mode 100644 drivers/regulator/mt6316-regulator.c
 create mode 100644 drivers/regulator/mt6363-regulator.c
 create mode 100644 drivers/regulator/mt6373-regulator.c
 create mode 100644 include/linux/regulator/mt6316-regulator.h
 create mode 100644 include/linux/regulator/mt6363-regulator.h
 create mode 100644 include/linux/regulator/mt6373-regulator.h

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 39297f7d8177..7b2d47fee535 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -853,6 +853,16 @@ config REGULATOR_MT6315
 	  This driver supports the control of different power rails of device
 	  through regulator interface.
 
+config REGULATOR_MT6316
+	tristate "MediaTek MT6316 PMIC"
+	depends on SPMI
+	select REGMAP_SPMI
+	help
+	  Say y here to select this option to enable the power regulator of
+	  MediaTek MT6316 PMIC.
+	  This driver supports the control of different power rails of device
+	  through regulator interface.
+
 config REGULATOR_MT6323
 	tristate "MediaTek MT6323 PMIC"
 	depends on MFD_MT6397
@@ -916,6 +926,18 @@ config REGULATOR_MT6360
 	  2-channel buck with Thermal Shutdown and Overload Protection
 	  6-channel High PSRR and Low Dropout LDO.
 
+config REGULATOR_MT6363
+	tristate "MT6363 SPMI Regulator driver"
+	depends on MFD_MTK_SPMI_PMIC
+	help
+	  Say y here to select this option to enable the power regulator of
+	  MediaTek MT6363 PMIC.
+	  This driver supports the control of different power rails of device
+	  through regulator interface.
+
+	  The driver can also be build as a module.
+	  If so, the module will be called mt6363_regulator
+
 config REGULATOR_MT6370
 	tristate "MT6370 SubPMIC Regulator"
 	depends on MFD_MT6370
@@ -924,6 +946,18 @@ config REGULATOR_MT6370
 	  This driver supports the control for DisplayBias voltages and one
 	  general purpose LDO which is commonly used to drive the vibrator.
 
+config REGULATOR_MT6373
+	tristate "MT6373 SPMI Regulator driver"
+	depends on MFD_MTK_SPMI_PMIC
+	help
+	  Say y here to select this option to enable the power regulator of
+	  MediaTek MT6373 PMIC.
+	  This driver supports the control of different power rails of device
+	  through regulator interface.
+
+	  The driver can also be build as a module.
+	  If so, the module will be called mt6373_regulator
+
 config REGULATOR_MT6380
 	tristate "MediaTek MT6380 PMIC"
 	depends on MTK_PMIC_WRAP
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 3d5a803dce8a..b54a64522499 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -102,6 +102,7 @@ obj-$(CONFIG_REGULATOR_MP886X) += mp886x.o
 obj-$(CONFIG_REGULATOR_MPQ7920) += mpq7920.o
 obj-$(CONFIG_REGULATOR_MT6311) += mt6311-regulator.o
 obj-$(CONFIG_REGULATOR_MT6315) += mt6315-regulator.o
+obj-$(CONFIG_REGULATOR_MT6316) += mt6316-regulator.o
 obj-$(CONFIG_REGULATOR_MT6323)	+= mt6323-regulator.o
 obj-$(CONFIG_REGULATOR_MT6331)	+= mt6331-regulator.o
 obj-$(CONFIG_REGULATOR_MT6332)	+= mt6332-regulator.o
@@ -109,7 +110,9 @@ obj-$(CONFIG_REGULATOR_MT6357)	+= mt6357-regulator.o
 obj-$(CONFIG_REGULATOR_MT6358)	+= mt6358-regulator.o
 obj-$(CONFIG_REGULATOR_MT6359)	+= mt6359-regulator.o
 obj-$(CONFIG_REGULATOR_MT6360) += mt6360-regulator.o
+obj-$(CONFIG_REGULATOR_MT6363) += mt6363-regulator.o
 obj-$(CONFIG_REGULATOR_MT6370) += mt6370-regulator.o
+obj-$(CONFIG_REGULATOR_MT6373) += mt6373-regulator.o
 obj-$(CONFIG_REGULATOR_MT6380)	+= mt6380-regulator.o
 obj-$(CONFIG_REGULATOR_MT6397)	+= mt6397-regulator.o
 obj-$(CONFIG_REGULATOR_MTK_DVFSRC) += mtk-dvfsrc-regulator.o
diff --git a/drivers/regulator/mt6316-regulator.c b/drivers/regulator/mt6316-regulator.c
new file mode 100644
index 000000000000..1c069a0d4cff
--- /dev/null
+++ b/drivers/regulator/mt6316-regulator.c
@@ -0,0 +1,381 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2024 MediaTek Inc.
+
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/mt6316-regulator.h>
+#include <linux/regulator/of_regulator.h>
+
+#define SET_OFFSET	0x1
+#define CLR_OFFSET	0x2
+
+#define MT6316_REG_WIDTH	8
+
+#define MT6316_BUCK_MODE_AUTO		0
+#define MT6316_BUCK_MODE_FORCE_PWM	1
+#define MT6316_BUCK_MODE_NORMAL		0
+#define MT6316_BUCK_MODE_LP		2
+
+#define BUCK_PHASE_3			3
+#define BUCK_PHASE_4			4
+
+struct mt6316_regulator_info {
+	struct regulator_desc desc;
+	u32 da_reg;
+	u32 qi;
+	u32 modeset_reg;
+	u32 modeset_mask;
+	u32 lp_mode_reg;
+	u32 lp_mode_mask;
+	u32 lp_mode_shift;
+};
+
+struct mt6316_init_data {
+	u32 id;
+	u32 size;
+};
+
+struct mt6316_chip {
+	struct device *dev;
+	struct regmap *regmap;
+	u32 slave_id;
+};
+
+#define MT_BUCK(match, _name, volt_ranges, _bid, _vsel)	\
+[MT6316_ID_##_name] = {					\
+	.desc = {					\
+		.name = #_name,				\
+		.of_match = of_match_ptr(match),	\
+		.ops = &mt6316_volt_range_ops,		\
+		.type = REGULATOR_VOLTAGE,		\
+		.id = MT6316_ID_##_name,		\
+		.owner = THIS_MODULE,			\
+		.n_voltages = 0x1ff,			\
+		.linear_ranges = volt_ranges,		\
+		.n_linear_ranges = ARRAY_SIZE(volt_ranges),\
+		.vsel_reg = _vsel,			\
+		.vsel_mask = 0xff,			\
+		.enable_reg = MT6316_BUCK_TOP_CON0,	\
+		.enable_mask = BIT(_bid - 1),		\
+		.of_map_mode = mt6316_map_mode,		\
+	},						\
+	.da_reg = MT6316_VBUCK##_bid##_DBG8,		\
+	.qi = BIT(0),					\
+	.lp_mode_reg = MT6316_BUCK_TOP_CON1,		\
+	.lp_mode_mask = BIT(_bid - 1),			\
+	.lp_mode_shift = _bid - 1,			\
+	.modeset_reg = MT6316_BUCK_TOP_4PHASE_TOP_ANA_CON0,\
+	.modeset_mask = BIT(_bid - 1),			\
+}
+
+static const struct linear_range mt_volt_range1[] = {
+	REGULATOR_LINEAR_RANGE(0, 0, 0x1fe, 2500),
+};
+
+static int mt6316_regulator_enable(struct regulator_dev *rdev)
+{
+	return regmap_write(rdev->regmap, rdev->desc->enable_reg + SET_OFFSET,
+			    rdev->desc->enable_mask);
+}
+
+static int mt6316_regulator_disable(struct regulator_dev *rdev)
+{
+	return regmap_write(rdev->regmap, rdev->desc->enable_reg + CLR_OFFSET,
+			    rdev->desc->enable_mask);
+}
+
+static unsigned int mt6316_map_mode(u32 mode)
+{
+	switch (mode) {
+	case MT6316_BUCK_MODE_AUTO:
+		return REGULATOR_MODE_NORMAL;
+	case MT6316_BUCK_MODE_FORCE_PWM:
+		return REGULATOR_MODE_FAST;
+	case MT6316_BUCK_MODE_LP:
+		return REGULATOR_MODE_IDLE;
+	default:
+		return REGULATOR_MODE_INVALID;
+	}
+}
+
+static int mt6316_regulator_set_voltage_sel(struct regulator_dev *rdev, unsigned int selector)
+{
+	unsigned short reg_val = 0;
+	int ret = 0;
+
+	reg_val = ((selector & 0x1) << 8) | (selector >> 1);
+	ret = regmap_bulk_write(rdev->regmap, rdev->desc->vsel_reg, (u8 *) &reg_val, 2);
+
+	return ret;
+}
+
+static int mt6316_regulator_get_voltage_sel(struct regulator_dev *rdev)
+{
+	int ret = 0;
+	unsigned int reg_val = 0;
+
+	ret = regmap_bulk_read(rdev->regmap, rdev->desc->vsel_reg, (u8 *) &reg_val, 2);
+	if (ret != 0) {
+		dev_err(&rdev->dev, "Failed to get mt6316 regulator voltage: %d\n", ret);
+		return ret;
+	}
+	ret = ((reg_val >> 8) & 0x1) + ((reg_val & rdev->desc->vsel_mask) << 1);
+
+	return ret;
+}
+
+static unsigned int mt6316_regulator_get_mode(struct regulator_dev *rdev)
+{
+	struct mt6316_regulator_info *info;
+	int ret = 0, regval = 0;
+	u32 modeset_mask;
+
+	info = container_of(rdev->desc, struct mt6316_regulator_info, desc);
+	ret = regmap_read(rdev->regmap, info->modeset_reg, &regval);
+	if (ret != 0) {
+		dev_err(&rdev->dev, "Failed to get mt6316 buck mode: %d\n", ret);
+		return ret;
+	}
+
+	modeset_mask = info->modeset_mask;
+
+	if ((regval & modeset_mask) == modeset_mask)
+		return REGULATOR_MODE_FAST;
+
+	ret = regmap_read(rdev->regmap, info->lp_mode_reg, &regval);
+	if (ret != 0) {
+		dev_err(&rdev->dev, "Failed to get mt6316 buck lp mode: %d\n", ret);
+		return ret;
+	}
+
+	if (regval & info->lp_mode_mask)
+		return REGULATOR_MODE_IDLE;
+	else
+		return REGULATOR_MODE_NORMAL;
+}
+
+static int mt6316_regulator_set_mode(struct regulator_dev *rdev, u32 mode)
+{
+	struct mt6316_regulator_info *info;
+	int ret = 0, val, curr_mode;
+	u32 modeset_mask;
+
+	info = container_of(rdev->desc, struct mt6316_regulator_info, desc);
+	modeset_mask = info->modeset_mask;
+
+	curr_mode = mt6316_regulator_get_mode(rdev);
+	switch (mode) {
+	case REGULATOR_MODE_FAST:
+		ret = regmap_update_bits(rdev->regmap, info->modeset_reg,
+					 modeset_mask, modeset_mask);
+		break;
+	case REGULATOR_MODE_NORMAL:
+		if (curr_mode == REGULATOR_MODE_FAST) {
+			ret = regmap_update_bits(rdev->regmap, info->modeset_reg,
+						 modeset_mask, 0);
+		} else if (curr_mode == REGULATOR_MODE_IDLE) {
+			ret = regmap_update_bits(rdev->regmap, info->lp_mode_reg,
+						 info->lp_mode_mask, 0);
+			usleep_range(100, 110);
+		}
+		break;
+	case REGULATOR_MODE_IDLE:
+		val = MT6316_BUCK_MODE_LP >> 1;
+		val <<= info->lp_mode_shift;
+		ret = regmap_update_bits(rdev->regmap, info->lp_mode_reg, info->lp_mode_mask, val);
+		break;
+	default:
+		ret = -EINVAL;
+		goto err_mode;
+	}
+
+err_mode:
+	if (ret != 0) {
+		dev_err(&rdev->dev, "Failed to set mt6316 buck mode: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int mt6316_get_status(struct regulator_dev *rdev)
+{
+	int ret = 0;
+	u32 regval = 0;
+	struct mt6316_regulator_info *info;
+
+	info = container_of(rdev->desc, struct mt6316_regulator_info, desc);
+	ret = regmap_read(rdev->regmap, info->da_reg, &regval);
+	if (ret != 0) {
+		dev_notice(&rdev->dev, "Failed to get enable reg: %d\n", ret);
+		return ret;
+	}
+
+	return (regval & info->qi) ? REGULATOR_STATUS_ON : REGULATOR_STATUS_OFF;
+}
+
+static void mt6316_buck_phase_init(struct mt6316_chip *chip, unsigned int *s6_buck_phase)
+{
+	int ret = 0;
+	u32 val = 0;
+
+	ret = regmap_read(chip->regmap, MT6316_BUCK_TOP_4PHASE_TOP_ELR_0, &val);
+	if (ret) {
+		dev_err(chip->dev, "Failed to get mt6316 buck phase: %d\n", ret);
+		return;
+	}
+
+	dev_info(chip->dev, "S%d RG_4PH_CONFIG:%d\n", chip->slave_id, val);
+	if (chip->slave_id == MT6316_SLAVE_ID_6)
+		*s6_buck_phase = val;
+}
+
+static const struct regulator_ops mt6316_volt_range_ops = {
+	.list_voltage = regulator_list_voltage_linear_range,
+	.map_voltage = regulator_map_voltage_linear_range,
+	.set_voltage_sel = mt6316_regulator_set_voltage_sel,
+	.get_voltage_sel = mt6316_regulator_get_voltage_sel,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = mt6316_regulator_enable,
+	.disable = mt6316_regulator_disable,
+	.is_enabled = regulator_is_enabled_regmap,
+	.get_status = mt6316_get_status,
+	.set_mode = mt6316_regulator_set_mode,
+	.get_mode = mt6316_regulator_get_mode,
+};
+
+static struct mt6316_regulator_info mt6316_regulators[] = {
+	MT_BUCK("vbuck1", VBUCK1, mt_volt_range1, 1, MT6316_BUCK_TOP_ELR0),
+	MT_BUCK("vbuck2", VBUCK2, mt_volt_range1, 2, MT6316_BUCK_TOP_ELR2),
+	MT_BUCK("vbuck3", VBUCK3, mt_volt_range1, 3, MT6316_BUCK_TOP_ELR4),
+	MT_BUCK("vbuck4", VBUCK4, mt_volt_range1, 4, MT6316_BUCK_TOP_ELR6),
+};
+
+static struct mt6316_init_data mt6316_3_init_data = {
+	.id = MT6316_SLAVE_ID_3,
+	.size = MT6316_ID_3_MAX,
+};
+
+static struct mt6316_init_data mt6316_6_init_data = {
+	.id = MT6316_SLAVE_ID_6,
+	.size = MT6316_ID_6_MAX,
+};
+
+static struct mt6316_init_data mt6316_7_init_data = {
+	.id = MT6316_SLAVE_ID_7,
+	.size = MT6316_ID_7_MAX,
+};
+
+static struct mt6316_init_data mt6316_8_init_data = {
+	.id = MT6316_SLAVE_ID_8,
+	.size = MT6316_ID_8_MAX,
+};
+
+static struct mt6316_init_data mt6316_15_init_data = {
+	.id = MT6316_SLAVE_ID_15,
+	.size = MT6316_ID_15_MAX,
+};
+
+static const struct of_device_id mt6316_of_match[] = {
+	{
+		.compatible = "mediatek,mt6316-3-regulator",
+		.data = &mt6316_3_init_data,
+	}, {
+		.compatible = "mediatek,mt6316-6-regulator",
+		.data = &mt6316_6_init_data,
+	}, {
+		.compatible = "mediatek,mt6316-7-regulator",
+		.data = &mt6316_7_init_data,
+	}, {
+		.compatible = "mediatek,mt6316-8-regulator",
+		.data = &mt6316_8_init_data,
+	}, {
+		.compatible = "mediatek,mt6316-15-regulator",
+		.data = &mt6316_15_init_data,
+	}, {
+		/* sentinel */
+	},
+};
+MODULE_DEVICE_TABLE(of, mt6316_of_match);
+
+static int mt6316_regulator_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *of_id;
+	struct device *dev = &pdev->dev;
+	struct regmap *regmap;
+	struct mt6316_init_data *pdata;
+	struct mt6316_chip *chip;
+	struct regulator_config config = {};
+	struct regulator_dev *rdev;
+	struct device_node *node = pdev->dev.of_node;
+	u32 val = 0;
+	int i;
+	unsigned int s6_buck_phase;
+
+	regmap = dev_get_regmap(dev->parent, NULL);
+	if (!regmap)
+		return -ENODEV;
+
+	chip = devm_kzalloc(dev, sizeof(struct mt6316_chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	of_id = of_match_device(mt6316_of_match, dev);
+	if (!of_id || !of_id->data)
+		return -ENODEV;
+
+	pdata = (struct mt6316_init_data *)of_id->data;
+	chip->slave_id = pdata->id;
+	if (!of_property_read_u32(node, "buck-size", &val))
+		pdata->size = val;
+	chip->dev = dev;
+	chip->regmap = regmap;
+	dev_set_drvdata(dev, chip);
+
+	dev->fwnode = &(dev->of_node->fwnode);
+	if (dev->fwnode && !dev->fwnode->dev)
+		dev->fwnode->dev = dev;
+
+	config.dev = dev;
+	config.driver_data = pdata;
+	config.regmap = regmap;
+
+	mt6316_buck_phase_init(chip, &s6_buck_phase);
+	for (i = 0; i < pdata->size; i++) {
+		if (pdata->id == MT6316_SLAVE_ID_6 &&
+		    s6_buck_phase == BUCK_PHASE_4 &&
+		    (mt6316_regulators + i)->desc.id == MT6316_ID_VBUCK3) {
+			dev_info(dev, "skip registering %s.\n", (mt6316_regulators + i)->desc.name);
+			continue;
+		}
+
+		rdev = devm_regulator_register(dev, &(mt6316_regulators + i)->desc, &config);
+		if (IS_ERR(rdev)) {
+			dev_err(dev, "failed to register %s\n", (mt6316_regulators + i)->desc.name);
+			continue;
+		}
+	}
+
+	return 0;
+}
+
+static struct platform_driver mt6316_regulator_driver = {
+	.driver		= {
+		.name	= "mt6316-regulator",
+		.of_match_table = mt6316_of_match,
+	},
+	.probe = mt6316_regulator_probe,
+};
+
+module_platform_driver(mt6316_regulator_driver);
+
+MODULE_AUTHOR("Lu Tang <lu.tang@mediatek.com>");
+MODULE_DESCRIPTION("Regulator Driver for MediaTek MT6316 PMIC");
+MODULE_LICENSE("GPL");
diff --git a/drivers/regulator/mt6363-regulator.c b/drivers/regulator/mt6363-regulator.c
new file mode 100644
index 000000000000..cdb280110a9a
--- /dev/null
+++ b/drivers/regulator/mt6363-regulator.c
@@ -0,0 +1,1106 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2024 MediaTek Inc.
+
+#include <linux/interrupt.h>
+#include <linux/mfd/mt6363/registers.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/mt6363-regulator.h>
+#include <linux/regulator/of_regulator.h>
+
+#define SET_OFFSET	0x1
+#define CLR_OFFSET	0x2
+#define OP_CFG_OFFSET	0x5
+#define NORMAL_OP_CFG	0x10
+#define NORMAL_OP_EN	0x800000
+
+#define MT6363_REGULATOR_MODE_NORMAL	0
+#define MT6363_REGULATOR_MODE_FCCM	1
+#define MT6363_REGULATOR_MODE_LP	2
+#define MT6363_REGULATOR_MODE_ULP	3
+
+#define DEFAULT_DELAY_MS		10
+
+/*
+ * MT6363 regulator lock register
+ */
+#define MT6363_TMA_UNLOCK_VALUE		0x9c9c
+#define MT6363_BUCK_TOP_UNLOCK_VALUE	0x5543
+
+#define MT6363_RG_BUCK_EFUSE_RSV1	0x1447
+#define MT6363_RG_BUCK_EFUSE_RSV1_MASK	0xf0
+
+/*
+ * MT6363 regulators' information
+ *
+ * @irq: Interrupt request number of the regulator.
+ * @oc_irq_enable_delay_ms: delay in milliseconds before enabling overcurrent interrupt.
+ * @oc_work: Delayed work fields of overcurrent events.
+ * @desc: standard fields of regulator description.
+ * @lp_mode_reg: for operating NORMAL/IDLE mode register.
+ * @lp_mode_mask: MASK for operating lp_mode register.
+ * @hw_lp_mode_reg: hardware NORMAL/IDLE mode status register.
+ * @hw_lp_mode_mask: MASK for hardware NORMAL/IDLE mode status register.
+ * @modeset_reg: for operating AUTO/PWM mode register.
+ * @modeset_mask: MASK for operating modeset register.
+ * @vocal_reg: Calibrates output voltage register.
+ * @vocal_mask: MASK of Calibrates output voltage register.
+ * @lp_imax_uA: Maximum load current in Low power mode.
+ * @op_en_reg: for HW control operating mode register.
+ * @orig_op_en: for HW control original mode register.
+ * @orig_op_cfg: for HW control original mode register.
+ */
+struct mt6363_regulator_info {
+	int irq;
+	int oc_irq_enable_delay_ms;
+	struct delayed_work oc_work;
+	struct regulator_desc desc;
+	u32 lp_mode_reg;
+	u32 lp_mode_mask;
+	u32 hw_lp_mode_reg;
+	u32 hw_lp_mode_mask;
+	u32 modeset_reg;
+	u32 modeset_mask;
+	u32 vocal_reg;
+	u32 vocal_mask;
+	u32 lp_imax_uA;
+	u32 op_en_reg;
+	u32 orig_op_en;
+	u32 orig_op_cfg;
+};
+
+#define MT6363_BUCK(match, _name, min, max, step, _enable_reg, en_bit, \
+		    _vsel_reg, _vsel_mask, _lp_mode_reg, lp_bit,			\
+		    _modeset_reg, modeset_bit, _en_delay)			\
+[MT6363_ID_##_name] = {						\
+	.desc = {						\
+		.name = #_name,					\
+		.of_match = of_match_ptr(match),		\
+		.of_parse_cb = mt6363_of_parse_cb,		\
+		.regulators_node = "regulators",		\
+		.ops = &mt6363_buck_ops,			\
+		.type = REGULATOR_VOLTAGE,			\
+		.id = MT6363_ID_##_name,			\
+		.owner = THIS_MODULE,				\
+		.n_voltages = ((max) - (min)) / (step) + 1,	\
+		.min_uV = (min),		\
+		.uV_step = (step),		\
+		.enable_reg = _enable_reg,			\
+		.enable_mask = BIT(en_bit),			\
+		.enable_time = _en_delay,			\
+		.vsel_reg = _vsel_reg,				\
+		.vsel_mask = _vsel_mask,			\
+		.of_map_mode = mt6363_map_mode,			\
+	},							\
+	.lp_mode_reg = _lp_mode_reg,				\
+	.lp_mode_mask = BIT(lp_bit),				\
+	.hw_lp_mode_reg = MT6363_BUCK_##_name##_HW_LP_MODE,	\
+	.hw_lp_mode_mask = 0xc,					\
+	.modeset_reg = _modeset_reg,				\
+	.modeset_mask = BIT(modeset_bit),			\
+	.lp_imax_uA = 100000,					\
+	.op_en_reg = MT6363_BUCK_##_name##_OP_EN_0,		\
+}
+
+#define MT6363_SSHUB(match, _name, min, max, step, \
+		     _enable_reg, _vsel_reg, _vsel_mask)	\
+[MT6363_ID_##_name] = {						\
+	.desc = {						\
+		.name = #_name,					\
+		.of_match = of_match_ptr(match),		\
+		.of_parse_cb = mt6363_of_parse_cb,		\
+		.regulators_node = "regulators",		\
+		.ops = &mt6363_sshub_ops,			\
+		.type = REGULATOR_VOLTAGE,			\
+		.id = MT6363_ID_##_name,			\
+		.owner = THIS_MODULE,				\
+		.n_voltages = ((max) - (min)) / (step) + 1,	\
+		.min_uV = (min),		\
+		.uV_step = (step),		\
+		.enable_reg = _enable_reg,			\
+		.enable_mask = BIT(0),				\
+		.vsel_reg = _vsel_reg,				\
+		.vsel_mask = _vsel_mask,			\
+	},							\
+}
+
+#define MT6363_LDO_LINEAR1(match, _name, min, max, step, \
+			   _enable_reg, en_bit, _vsel_reg,	\
+			   _vsel_mask, _lp_mode_reg, lp_bit, _en_delay)	\
+[MT6363_ID_##_name] = {						\
+	.desc = {						\
+		.name = #_name,					\
+		.of_match = of_match_ptr(match),		\
+		.of_parse_cb = mt6363_of_parse_cb,		\
+		.regulators_node = "regulators",		\
+		.ops = &mt6363_buck_ops,			\
+		.type = REGULATOR_VOLTAGE,			\
+		.id = MT6363_ID_##_name,			\
+		.owner = THIS_MODULE,				\
+		.n_voltages = ((max) - (min)) / (step) + 1,	\
+		.min_uV = (min),		\
+		.uV_step = (step),		\
+		.enable_reg = _enable_reg,			\
+		.enable_mask = BIT(en_bit),			\
+		.enable_time = _en_delay,			\
+		.vsel_reg = _vsel_reg,				\
+		.vsel_mask = _vsel_mask,			\
+		.of_map_mode = mt6363_map_mode,			\
+	},							\
+	.lp_mode_reg = _lp_mode_reg,				\
+	.lp_mode_mask = BIT(lp_bit),				\
+	.hw_lp_mode_reg = MT6363_LDO_##_name##_HW_LP_MODE,	\
+	.hw_lp_mode_mask = 0x4,					\
+}
+
+#define MT6363_LDO_LINEAR2(match, _name, min, max, step,	\
+			   _enable_reg, en_bit, _vsel_reg,	\
+			   _vsel_mask, _lp_mode_reg, lp_bit, _en_delay)	\
+[MT6363_ID_##_name] = {						\
+	.desc = {						\
+		.name = #_name,					\
+		.of_match = of_match_ptr(match),		\
+		.of_parse_cb = mt6363_of_parse_cb,		\
+		.regulators_node = "regulators",		\
+		.ops = &mt6363_volt_range_ops,			\
+		.type = REGULATOR_VOLTAGE,			\
+		.id = MT6363_ID_##_name,			\
+		.owner = THIS_MODULE,				\
+		.n_voltages = ((max) - (min)) / (step) + 1,	\
+		.min_uV = (min),		\
+		.uV_step = (step),		\
+		.enable_reg = _enable_reg,			\
+		.enable_mask = BIT(en_bit),			\
+		.enable_time = _en_delay,			\
+		.vsel_reg = _vsel_reg,				\
+		.vsel_mask = _vsel_mask,			\
+		.of_map_mode = mt6363_map_mode,			\
+	},							\
+	.lp_mode_reg = _lp_mode_reg,				\
+	.lp_mode_mask = BIT(lp_bit),				\
+	.hw_lp_mode_reg = MT6363_LDO_##_name##_HW_LP_MODE,	\
+	.hw_lp_mode_mask = 0x4,					\
+}
+
+#define MT6363_LDO(match, _name, _volt_table, _enable_reg, en_bit,	\
+		   _vsel_reg, _vsel_mask, _vocal_reg,		\
+		   _vocal_mask, _lp_mode_reg, lp_bit, _en_delay)		\
+[MT6363_ID_##_name] = {						\
+	.desc = {						\
+		.name = #_name,					\
+		.of_match = of_match_ptr(match),		\
+		.of_parse_cb = mt6363_of_parse_cb,		\
+		.regulators_node = "regulators",		\
+		.ops = &mt6363_volt_table_ops,			\
+		.type = REGULATOR_VOLTAGE,			\
+		.id = MT6363_ID_##_name,			\
+		.owner = THIS_MODULE,				\
+		.n_voltages = ARRAY_SIZE(_volt_table),		\
+		.volt_table = _volt_table,			\
+		.enable_reg = _enable_reg,			\
+		.enable_mask = BIT(en_bit),			\
+		.enable_time = _en_delay,			\
+		.vsel_reg = _vsel_reg,				\
+		.vsel_mask = _vsel_mask,			\
+		.of_map_mode = mt6363_map_mode,			\
+	},							\
+	.vocal_reg = _vocal_reg,				\
+	.vocal_mask = _vocal_mask,				\
+	.lp_mode_reg = _lp_mode_reg,				\
+	.lp_mode_mask = BIT(lp_bit),				\
+	.hw_lp_mode_reg = MT6363_LDO_##_name##_HW_LP_MODE,	\
+	.hw_lp_mode_mask = 0x4,					\
+	.lp_imax_uA = 10000,					\
+	.op_en_reg = MT6363_LDO_##_name##_OP_EN0,		\
+}
+
+#define MT6363_LDO_OPS(match, _name, _ops, _volt_table, _enable_reg, en_bit,	\
+		       _vsel_reg, _vsel_mask, _vocal_reg,	\
+		       _vocal_mask, _lp_mode_reg, lp_bit, _en_delay)	\
+[MT6363_ID_##_name] = {						\
+	.desc = {						\
+		.name = #_name,					\
+		.of_match = of_match_ptr(match),		\
+		.of_parse_cb = mt6363_of_parse_cb,		\
+		.regulators_node = "regulators",		\
+		.ops = &_ops,					\
+		.type = REGULATOR_VOLTAGE,			\
+		.id = MT6363_ID_##_name,			\
+		.owner = THIS_MODULE,				\
+		.n_voltages = ARRAY_SIZE(_volt_table),		\
+		.volt_table = _volt_table,			\
+		.enable_reg = _enable_reg,			\
+		.enable_mask = BIT(en_bit),			\
+		.enable_time = _en_delay,			\
+		.vsel_reg = _vsel_reg,				\
+		.vsel_mask = _vsel_mask,			\
+		.of_map_mode = mt6363_map_mode,			\
+	},							\
+	.vocal_reg = _vocal_reg,				\
+	.vocal_mask = _vocal_mask,				\
+	.lp_mode_reg = _lp_mode_reg,				\
+	.lp_mode_mask = BIT(lp_bit),				\
+	.hw_lp_mode_reg = MT6363_LDO_##_name##_HW_LP_MODE,	\
+	.hw_lp_mode_mask = 0x4,					\
+	.lp_imax_uA = 10000,					\
+	.op_en_reg = MT6363_LDO_##_name##_OP_EN0,		\
+}
+
+static const unsigned int ldo_volt_table0[] = {
+	1200000, 1300000, 1500000, 1700000, 1800000, 2000000, 2500000, 2600000,
+	2700000, 2800000, 2900000, 3000000, 3100000, 3300000, 3400000, 3500000,
+};
+
+static const unsigned int ldo_volt_table1[] = {
+	900000, 1000000, 1100000, 1200000, 1300000, 1700000, 1800000, 1810000,
+};
+
+static const unsigned int ldo_volt_table2[] = {
+	1800000, 1900000, 2000000, 2100000, 2200000, 2300000, 2400000, 2500000,
+	2600000, 2700000, 2800000, 2900000, 3000000, 3100000, 3200000, 3300000,
+};
+
+static const unsigned int ldo_volt_table3[] = {
+	600000, 700000, 800000, 900000, 1000000, 1100000, 1200000, 1300000,
+	1400000, 1500000, 1600000, 1700000, 1800000, 1900000, 2000000, 2100000,
+};
+
+static const unsigned int ldo_volt_table4[] = {
+	550000, 600000, 650000, 700000, 750000, 800000, 900000, 950000,
+	1000000, 1050000, 1100000, 1150000, 1700000, 1750000, 1800000, 1850000,
+};
+
+static const unsigned int ldo_volt_table5[] = {
+	600000, 650000, 700000, 750000, 800000,
+};
+
+static int mt6363_buck_enable(struct regulator_dev *rdev)
+{
+	return regmap_write(rdev->regmap, rdev->desc->enable_reg + SET_OFFSET,
+			    rdev->desc->enable_mask);
+}
+
+static int mt6363_buck_disable(struct regulator_dev *rdev)
+{
+	return regmap_write(rdev->regmap, rdev->desc->enable_reg + CLR_OFFSET,
+			    rdev->desc->enable_mask);
+}
+
+static inline unsigned int mt6363_map_mode(unsigned int mode)
+{
+	switch (mode) {
+	case MT6363_REGULATOR_MODE_NORMAL:
+		return REGULATOR_MODE_NORMAL;
+	case MT6363_REGULATOR_MODE_FCCM:
+		return REGULATOR_MODE_FAST;
+	case MT6363_REGULATOR_MODE_LP:
+		return REGULATOR_MODE_IDLE;
+	case MT6363_REGULATOR_MODE_ULP:
+		return REGULATOR_MODE_STANDBY;
+	default:
+		return REGULATOR_MODE_INVALID;
+	}
+}
+
+static unsigned int mt6363_regulator_get_mode(struct regulator_dev *rdev)
+{
+	struct mt6363_regulator_info *info = rdev_get_drvdata(rdev);
+	unsigned int val = 0;
+	int ret;
+
+	ret = regmap_read(rdev->regmap, info->modeset_reg, &val);
+	if (ret) {
+		dev_err(&rdev->dev, "Failed to get mt6363 mode: %d\n", ret);
+		return ret;
+	}
+
+	if (val & info->modeset_mask)
+		return REGULATOR_MODE_FAST;
+
+	if (info->hw_lp_mode_reg) {
+		ret = regmap_read(rdev->regmap, info->hw_lp_mode_reg, &val);
+		val &= info->hw_lp_mode_mask;
+	} else {
+		ret = regmap_read(rdev->regmap, info->lp_mode_reg, &val);
+		val &= info->lp_mode_mask;
+	}
+	if (ret) {
+		dev_err(&rdev->dev,
+			"Failed to get mt6363 lp mode: %d\n", ret);
+		return ret;
+	}
+
+	if (val)
+		return REGULATOR_MODE_IDLE;
+	else
+		return REGULATOR_MODE_NORMAL;
+}
+
+static int mt6363_buck_unlock(struct regmap *map, bool unlock)
+{
+	u16 buf = unlock ? MT6363_BUCK_TOP_UNLOCK_VALUE : 0;
+
+	return regmap_bulk_write(map, MT6363_BUCK_TOP_KEY_PROT_LO, &buf, 2);
+}
+
+static int mt6363_regulator_set_mode(struct regulator_dev *rdev,
+				     unsigned int mode)
+{
+	struct mt6363_regulator_info *info = rdev_get_drvdata(rdev);
+	int ret = 0;
+	int curr_mode;
+
+	curr_mode = mt6363_regulator_get_mode(rdev);
+	switch (mode) {
+	case REGULATOR_MODE_FAST:
+		ret = mt6363_buck_unlock(rdev->regmap, true);
+		if (ret)
+			return ret;
+		ret = regmap_update_bits(rdev->regmap,
+					 info->modeset_reg,
+					 info->modeset_mask,
+					 info->modeset_mask);
+		ret |= mt6363_buck_unlock(rdev->regmap, false);
+		break;
+	case REGULATOR_MODE_NORMAL:
+		if (curr_mode == REGULATOR_MODE_FAST) {
+			ret = mt6363_buck_unlock(rdev->regmap, true);
+			if (ret)
+				return ret;
+			ret = regmap_update_bits(rdev->regmap,
+						 info->modeset_reg,
+						 info->modeset_mask,
+						 0);
+			ret |= mt6363_buck_unlock(rdev->regmap, false);
+			break;
+		} else if (curr_mode == REGULATOR_MODE_IDLE) {
+			ret = regmap_update_bits(rdev->regmap,
+						 info->lp_mode_reg,
+						 info->lp_mode_mask,
+						 0);
+			udelay(100);
+		}
+		break;
+	case REGULATOR_MODE_IDLE:
+		ret = regmap_update_bits(rdev->regmap,
+					 info->lp_mode_reg,
+					 info->lp_mode_mask,
+					 info->lp_mode_mask);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (ret) {
+		dev_err(&rdev->dev,
+			"Failed to set mt6363 mode(%d): %d\n", mode, ret);
+	}
+	return ret;
+}
+
+static int mt6363_regulator_set_load(struct regulator_dev *rdev, int load_uA)
+{
+	int i, ret;
+	struct mt6363_regulator_info *info = rdev_get_drvdata(rdev);
+
+	/* not support */
+	if (!info->lp_imax_uA)
+		return 0;
+
+	if (load_uA >= info->lp_imax_uA) {
+		ret = mt6363_regulator_set_mode(rdev, REGULATOR_MODE_NORMAL);
+		if (ret)
+			return ret;
+		ret = regmap_write(rdev->regmap, info->op_en_reg + OP_CFG_OFFSET, NORMAL_OP_CFG);
+		for (i = 0; i < 3; i++) {
+			ret |= regmap_write(rdev->regmap, info->op_en_reg + i,
+					    (NORMAL_OP_EN >> (i * 8)) & 0xff);
+		}
+	} else {
+		ret = regmap_write(rdev->regmap, info->op_en_reg + OP_CFG_OFFSET,
+				   info->orig_op_cfg);
+		for (i = 0; i < 3; i++) {
+			ret |= regmap_write(rdev->regmap, info->op_en_reg + i,
+					    (info->orig_op_en >> (i * 8)) & 0xff);
+		}
+	}
+
+	return ret;
+}
+
+static int mt6363_vemc_set_voltage_sel(struct regulator_dev *rdev, unsigned int sel)
+{
+	int ret;
+	u16 buf = MT6363_TMA_UNLOCK_VALUE;
+	unsigned int val = 0;
+
+	ret = regmap_bulk_write(rdev->regmap, MT6363_TOP_TMA_KEY_L, &buf, 2);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(rdev->regmap, MT6363_TOP_TRAP, &val);
+	if (ret)
+		return ret;
+	switch (val) {
+	case 0:
+		/* If HW trapping is 0, use VEMC_VOSEL_0 */
+		ret = regmap_update_bits(rdev->regmap,
+					 rdev->desc->vsel_reg,
+					 rdev->desc->vsel_mask, sel);
+		break;
+	case 1:
+		/* If HW trapping is 1, use VEMC_VOSEL_1 */
+		ret = regmap_update_bits(rdev->regmap,
+					 rdev->desc->vsel_reg,
+					 rdev->desc->vsel_mask << 4, sel << 4);
+		break;
+	default:
+		break;
+	}
+	if (ret)
+		return ret;
+
+	buf = 0;
+	ret = regmap_bulk_write(rdev->regmap, MT6363_TOP_TMA_KEY_L, &buf, 2);
+	return ret;
+}
+
+static int mt6363_vemc_get_voltage_sel(struct regulator_dev *rdev)
+{
+	int ret;
+	unsigned int val = 0, sel = 0;
+
+	ret = regmap_read(rdev->regmap, rdev->desc->vsel_reg, &sel);
+	if (ret)
+		return ret;
+	ret = regmap_read(rdev->regmap, MT6363_TOP_TRAP, &val);
+	if (ret)
+		return ret;
+	switch (val) {
+	case 0:
+		/* If HW trapping is 0, use VEMC_VOSEL_0 */
+		sel &= rdev->desc->vsel_mask;
+		break;
+	case 1:
+		/* If HW trapping is 1, use VEMC_VOSEL_1 */
+		sel = (sel >> 4) & rdev->desc->vsel_mask;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return sel;
+}
+
+static int mt6363_va15_set_voltage_sel(struct regulator_dev *rdev, unsigned int sel)
+{
+	int ret;
+
+	ret = mt6363_buck_unlock(rdev->regmap, true);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(rdev->regmap, rdev->desc->vsel_reg, rdev->desc->vsel_mask, sel);
+	if (ret)
+		goto va15_unlock;
+	ret = regmap_update_bits(rdev->regmap, MT6363_RG_BUCK_EFUSE_RSV1,
+				 MT6363_RG_BUCK_EFUSE_RSV1_MASK, sel);
+	if (ret)
+		goto va15_unlock;
+
+va15_unlock:
+	ret |= mt6363_buck_unlock(rdev->regmap, false);
+	return ret;
+}
+
+static const struct regulator_ops mt6363_buck_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.map_voltage = regulator_map_voltage_linear,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = mt6363_buck_enable,
+	.disable = mt6363_buck_disable,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_mode = mt6363_regulator_set_mode,
+	.get_mode = mt6363_regulator_get_mode,
+	.set_load = mt6363_regulator_set_load,
+};
+
+/* for sshub */
+static const struct regulator_ops mt6363_sshub_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.map_voltage = regulator_map_voltage_linear,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+};
+
+static const struct regulator_ops mt6363_volt_range_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.map_voltage = regulator_map_voltage_linear,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_mode = mt6363_regulator_set_mode,
+	.get_mode = mt6363_regulator_get_mode,
+};
+
+static const struct regulator_ops mt6363_volt_table_ops = {
+	.list_voltage = regulator_list_voltage_table,
+	.map_voltage = regulator_map_voltage_iterate,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_mode = mt6363_regulator_set_mode,
+	.get_mode = mt6363_regulator_get_mode,
+	.set_load = mt6363_regulator_set_load,
+};
+
+static const struct regulator_ops mt6363_vemc_ops = {
+	.list_voltage = regulator_list_voltage_table,
+	.map_voltage = regulator_map_voltage_iterate,
+	.set_voltage_sel = mt6363_vemc_set_voltage_sel,
+	.get_voltage_sel = mt6363_vemc_get_voltage_sel,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_mode = mt6363_regulator_set_mode,
+	.get_mode = mt6363_regulator_get_mode,
+	.set_load = mt6363_regulator_set_load,
+};
+
+static const struct regulator_ops mt6363_va15_ops = {
+	.list_voltage = regulator_list_voltage_table,
+	.map_voltage = regulator_map_voltage_iterate,
+	.set_voltage_sel = mt6363_va15_set_voltage_sel,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_mode = mt6363_regulator_set_mode,
+	.get_mode = mt6363_regulator_get_mode,
+	.set_load = mt6363_regulator_set_load,
+};
+
+static int _isink_load_control(struct regulator_dev *rdev, bool enable)
+{
+	const struct {
+		unsigned int reg;
+		unsigned int mask;
+		unsigned int val;
+	} en_settings[] = {
+		{ MT6363_ISINK_EN_CTRL0, 0xFF, 0xFF },
+		{ MT6363_ISINK_EN_CTRL1, 0xF0, 0xF0 },
+	}, dis_settings[] = {
+		{ MT6363_ISINK_EN_CTRL1, 0xF0, 0 },
+		{ MT6363_ISINK_EN_CTRL0, 0xFF, 0 },
+	}, *settings;
+	int i, setting_size, ret;
+
+	if (enable) {
+		settings = en_settings;
+		setting_size = ARRAY_SIZE(en_settings);
+	} else {
+		settings = dis_settings;
+		setting_size = ARRAY_SIZE(dis_settings);
+	}
+
+	for (i = 0; i < setting_size; i++) {
+		ret = regmap_update_bits(rdev->regmap,
+					 settings[i].reg, settings[i].mask,
+					 settings[i].val);
+		if (ret) {
+			dev_err(&rdev->dev,
+				"Failed to %s isink settings[%d], ret=%d\n",
+				enable ? "enable" : "disable",
+				i, ret);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+static int isink_load_enable(struct regulator_dev *rdev)
+{
+	return _isink_load_control(rdev, true);
+}
+
+static int isink_load_disable(struct regulator_dev *rdev)
+{
+	return _isink_load_control(rdev, false);
+}
+
+static int isink_load_is_enabled(struct regulator_dev *rdev)
+{
+	unsigned int val = 0;
+	int ret;
+
+	ret = regmap_read(rdev->regmap, MT6363_ISINK_EN_CTRL1, &val);
+	if (ret)
+		return ret;
+
+	val &= 0xF0;
+	return (val == 0xF0);
+}
+
+static const struct regulator_ops isink_load_ops = {
+	.enable = isink_load_enable,
+	.disable = isink_load_disable,
+	.is_enabled = isink_load_is_enabled,
+};
+
+static int mt6363_of_parse_cb(struct device_node *np,
+			      const struct regulator_desc *desc,
+			      struct regulator_config *config);
+
+/* The array is indexed by id(MT6363_ID_XXX) */
+static struct mt6363_regulator_info mt6363_regulators[] = {
+	MT6363_BUCK("vs2", VS2, 0, 1600000, 12500,
+		    MT6363_RG_BUCK_VS2_EN_ADDR,
+		    MT6363_RG_BUCK_VS2_EN_SHIFT,
+		    MT6363_RG_BUCK_VS2_VOSEL_ADDR,
+		    MT6363_RG_BUCK_VS2_VOSEL_MASK,
+		    MT6363_RG_BUCK_VS2_LP_ADDR,
+		    MT6363_RG_BUCK_VS2_LP_SHIFT,
+		    MT6363_RG_VS2_FCCM_ADDR,
+		    MT6363_RG_VS2_FCCM_SHIFT, 180),
+	MT6363_BUCK("vbuck1", VBUCK1, 0, 1193750, 6250,
+		    MT6363_RG_BUCK_VBUCK1_EN_ADDR,
+		    MT6363_RG_BUCK_VBUCK1_EN_SHIFT,
+		    MT6363_RG_BUCK_VBUCK1_VOSEL_ADDR,
+		    MT6363_RG_BUCK_VBUCK1_VOSEL_MASK,
+		    MT6363_RG_BUCK_VBUCK1_LP_ADDR,
+		    MT6363_RG_BUCK_VBUCK1_LP_SHIFT,
+		    MT6363_RG_VBUCK1_FCCM_ADDR,
+		    MT6363_RG_VBUCK1_FCCM_SHIFT, 180),
+	MT6363_BUCK("vbuck2", VBUCK2, 0, 1193750, 6250,
+		    MT6363_RG_BUCK_VBUCK2_EN_ADDR,
+		    MT6363_RG_BUCK_VBUCK2_EN_SHIFT,
+		    MT6363_RG_BUCK_VBUCK2_VOSEL_ADDR,
+		    MT6363_RG_BUCK_VBUCK2_VOSEL_MASK,
+		    MT6363_RG_BUCK_VBUCK2_LP_ADDR,
+		    MT6363_RG_BUCK_VBUCK2_LP_SHIFT,
+		    MT6363_RG_VBUCK2_FCCM_ADDR,
+		    MT6363_RG_VBUCK2_FCCM_SHIFT, 200),
+	MT6363_BUCK("vbuck3", VBUCK3, 0, 1193750, 6250,
+		    MT6363_RG_BUCK_VBUCK3_EN_ADDR,
+		    MT6363_RG_BUCK_VBUCK3_EN_SHIFT,
+		    MT6363_RG_BUCK_VBUCK3_VOSEL_ADDR,
+		    MT6363_RG_BUCK_VBUCK3_VOSEL_MASK,
+		    MT6363_RG_BUCK_VBUCK3_LP_ADDR,
+		    MT6363_RG_BUCK_VBUCK3_LP_SHIFT,
+		    MT6363_RG_VBUCK3_FCCM_ADDR,
+		    MT6363_RG_VBUCK3_FCCM_SHIFT, 200),
+	MT6363_BUCK("vbuck4", VBUCK4, 0, 1193750, 6250,
+		    MT6363_RG_BUCK_VBUCK4_EN_ADDR,
+		    MT6363_RG_BUCK_VBUCK4_EN_SHIFT,
+		    MT6363_RG_BUCK_VBUCK4_VOSEL_ADDR,
+		    MT6363_RG_BUCK_VBUCK4_VOSEL_MASK,
+		    MT6363_RG_BUCK_VBUCK4_LP_ADDR,
+		    MT6363_RG_BUCK_VBUCK4_LP_SHIFT,
+		    MT6363_RG_VBUCK4_FCCM_ADDR,
+		    MT6363_RG_VBUCK4_FCCM_SHIFT, 200),
+	MT6363_BUCK("vbuck5", VBUCK5, 0, 1193750, 6250,
+		    MT6363_RG_BUCK_VBUCK5_EN_ADDR,
+		    MT6363_RG_BUCK_VBUCK5_EN_SHIFT,
+		    MT6363_RG_BUCK_VBUCK5_VOSEL_ADDR,
+		    MT6363_RG_BUCK_VBUCK5_VOSEL_MASK,
+		    MT6363_RG_BUCK_VBUCK5_LP_ADDR,
+		    MT6363_RG_BUCK_VBUCK5_LP_SHIFT,
+		    MT6363_RG_VBUCK5_FCCM_ADDR,
+		    MT6363_RG_VBUCK5_FCCM_SHIFT, 200),
+	MT6363_BUCK("vbuck6", VBUCK6, 0, 1193750, 6250,
+		    MT6363_RG_BUCK_VBUCK6_EN_ADDR,
+		    MT6363_RG_BUCK_VBUCK6_EN_SHIFT,
+		    MT6363_RG_BUCK_VBUCK6_VOSEL_ADDR,
+		    MT6363_RG_BUCK_VBUCK6_VOSEL_MASK,
+		    MT6363_RG_BUCK_VBUCK6_LP_ADDR,
+		    MT6363_RG_BUCK_VBUCK6_LP_SHIFT,
+		    MT6363_RG_VBUCK6_FCCM_ADDR,
+		    MT6363_RG_VBUCK6_FCCM_SHIFT, 300),
+	MT6363_BUCK("vbuck7", VBUCK7, 0, 1193750, 6250,
+		    MT6363_RG_BUCK_VBUCK7_EN_ADDR,
+		    MT6363_RG_BUCK_VBUCK7_EN_SHIFT,
+		    MT6363_RG_BUCK_VBUCK7_VOSEL_ADDR,
+		    MT6363_RG_BUCK_VBUCK7_VOSEL_MASK,
+		    MT6363_RG_BUCK_VBUCK7_LP_ADDR,
+		    MT6363_RG_BUCK_VBUCK7_LP_SHIFT,
+		    MT6363_RG_VBUCK7_FCCM_ADDR,
+		    MT6363_RG_VBUCK7_FCCM_SHIFT, 300),
+	MT6363_BUCK("vs1", VS1, 0, 2200000, 12500,
+		    MT6363_RG_BUCK_VS1_EN_ADDR,
+		    MT6363_RG_BUCK_VS1_EN_SHIFT,
+		    MT6363_RG_BUCK_VS1_VOSEL_ADDR,
+		    MT6363_RG_BUCK_VS1_VOSEL_MASK,
+		    MT6363_RG_BUCK_VS1_LP_ADDR,
+		    MT6363_RG_BUCK_VS1_LP_SHIFT,
+		    MT6363_RG_VS1_FCCM_ADDR,
+		    MT6363_RG_VS1_FCCM_SHIFT, 180),
+	MT6363_BUCK("vs3", VS3, 0, 1193750, 6250,
+		    MT6363_RG_BUCK_VS3_EN_ADDR,
+		    MT6363_RG_BUCK_VS3_EN_SHIFT,
+		    MT6363_RG_BUCK_VS3_VOSEL_ADDR,
+		    MT6363_RG_BUCK_VS3_VOSEL_MASK,
+		    MT6363_RG_BUCK_VS3_LP_ADDR,
+		    MT6363_RG_BUCK_VS3_LP_SHIFT,
+		    MT6363_RG_VS3_FCCM_ADDR,
+		    MT6363_RG_VS3_FCCM_SHIFT, 180),
+	MT6363_SSHUB("vbuck1-sshub", VBUCK1_SSHUB, 0, 1193750, 6250,
+		     MT6363_RG_BUCK_VBUCK1_SSHUB_EN_ADDR,
+		     MT6363_RG_BUCK_VBUCK1_SSHUB_VOSEL_ADDR,
+		     MT6363_RG_BUCK_VBUCK1_SSHUB_VOSEL_MASK),
+	MT6363_SSHUB("vbuck2-sshub", VBUCK2_SSHUB, 0, 1193750, 6250,
+		     MT6363_RG_BUCK_VBUCK2_SSHUB_EN_ADDR,
+		     MT6363_RG_BUCK_VBUCK2_SSHUB_VOSEL_ADDR,
+		     MT6363_RG_BUCK_VBUCK2_SSHUB_VOSEL_MASK),
+	MT6363_SSHUB("vbuck4-sshub", VBUCK4_SSHUB, 0, 1193750, 6250,
+		     MT6363_RG_BUCK_VBUCK4_SSHUB_EN_ADDR,
+		     MT6363_RG_BUCK_VBUCK4_SSHUB_VOSEL_ADDR,
+		     MT6363_RG_BUCK_VBUCK4_SSHUB_VOSEL_MASK),
+	MT6363_LDO_LINEAR1("vsram-digrf", VSRAM_DIGRF, 400000, 1193750, 6250,
+			   MT6363_RG_LDO_VSRAM_DIGRF_EN_ADDR,
+			   MT6363_RG_LDO_VSRAM_DIGRF_EN_SHIFT,
+			   MT6363_RG_LDO_VSRAM_DIGRF_VOSEL_ADDR,
+			   MT6363_RG_LDO_VSRAM_DIGRF_VOSEL_MASK,
+			   MT6363_RG_LDO_VSRAM_DIGRF_LP_ADDR,
+			   MT6363_RG_LDO_VSRAM_DIGRF_LP_SHIFT, 180),
+	MT6363_LDO_LINEAR1("vsram-mdfe", VSRAM_MDFE, 400000, 1193750, 6250,
+			   MT6363_RG_LDO_VSRAM_MDFE_EN_ADDR,
+			   MT6363_RG_LDO_VSRAM_MDFE_EN_SHIFT,
+			   MT6363_RG_LDO_VSRAM_MDFE_VOSEL_ADDR,
+			   MT6363_RG_LDO_VSRAM_MDFE_VOSEL_MASK,
+			   MT6363_RG_LDO_VSRAM_MDFE_LP_ADDR,
+			   MT6363_RG_LDO_VSRAM_MDFE_LP_SHIFT, 180),
+	MT6363_LDO_LINEAR1("vsram-modem", VSRAM_MODEM, 400000, 1193750, 6250,
+			   MT6363_RG_LDO_VSRAM_MODEM_EN_ADDR,
+			   MT6363_RG_LDO_VSRAM_MODEM_EN_SHIFT,
+			   MT6363_RG_LDO_VSRAM_MODEM_VOSEL_ADDR,
+			   MT6363_RG_LDO_VSRAM_MODEM_VOSEL_MASK,
+			   MT6363_RG_LDO_VSRAM_MODEM_LP_ADDR,
+			   MT6363_RG_LDO_VSRAM_MODEM_LP_SHIFT, 180),
+	MT6363_LDO_LINEAR2("vsram-cpub", VSRAM_CPUB, 400000, 1193750, 6250,
+			   MT6363_RG_LDO_VSRAM_CPUB_EN_ADDR,
+			   MT6363_RG_LDO_VSRAM_CPUB_EN_SHIFT,
+			   MT6363_RG_LDO_VSRAM_CPUB_VOSEL_ADDR,
+			   MT6363_RG_LDO_VSRAM_CPUB_VOSEL_MASK,
+			   MT6363_RG_LDO_VSRAM_CPUB_LP_ADDR,
+			   MT6363_RG_LDO_VSRAM_CPUB_LP_SHIFT, 180),
+	MT6363_LDO_LINEAR2("vsram-cpum", VSRAM_CPUM, 400000, 1193750, 6250,
+			   MT6363_RG_LDO_VSRAM_CPUM_EN_ADDR,
+			   MT6363_RG_LDO_VSRAM_CPUM_EN_SHIFT,
+			   MT6363_RG_LDO_VSRAM_CPUM_VOSEL_ADDR,
+			   MT6363_RG_LDO_VSRAM_CPUM_VOSEL_MASK,
+			   MT6363_RG_LDO_VSRAM_CPUM_LP_ADDR,
+			   MT6363_RG_LDO_VSRAM_CPUM_LP_SHIFT, 180),
+	MT6363_LDO_LINEAR2("vsram-cpul", VSRAM_CPUL, 400000, 1193750, 6250,
+			   MT6363_RG_LDO_VSRAM_CPUL_EN_ADDR,
+			   MT6363_RG_LDO_VSRAM_CPUL_EN_SHIFT,
+			   MT6363_RG_LDO_VSRAM_CPUL_VOSEL_ADDR,
+			   MT6363_RG_LDO_VSRAM_CPUL_VOSEL_MASK,
+			   MT6363_RG_LDO_VSRAM_CPUL_LP_ADDR,
+			   MT6363_RG_LDO_VSRAM_CPUL_LP_SHIFT, 180),
+	MT6363_LDO_LINEAR2("vsram-apu", VSRAM_APU, 400000, 1193750, 6250,
+			   MT6363_RG_LDO_VSRAM_APU_EN_ADDR,
+			   MT6363_RG_LDO_VSRAM_APU_EN_SHIFT,
+			   MT6363_RG_LDO_VSRAM_APU_VOSEL_ADDR,
+			   MT6363_RG_LDO_VSRAM_APU_VOSEL_MASK,
+			   MT6363_RG_LDO_VSRAM_APU_LP_ADDR,
+			   MT6363_RG_LDO_VSRAM_APU_LP_SHIFT, 180),
+	MT6363_LDO_OPS("vemc", VEMC, mt6363_vemc_ops, ldo_volt_table0,
+		       MT6363_RG_LDO_VEMC_EN_ADDR, MT6363_RG_LDO_VEMC_EN_SHIFT,
+		       MT6363_RG_VEMC_VOSEL_0_ADDR,
+		       MT6363_RG_VEMC_VOSEL_0_MASK,
+		       MT6363_RG_VEMC_VOCAL_0_ADDR,
+		       MT6363_RG_VEMC_VOCAL_0_MASK,
+		       MT6363_RG_LDO_VEMC_LP_ADDR,
+		       MT6363_RG_LDO_VEMC_LP_SHIFT, 680),
+	MT6363_LDO("vcn13", VCN13, ldo_volt_table1,
+		   MT6363_RG_LDO_VCN13_EN_ADDR, MT6363_RG_LDO_VCN13_EN_SHIFT,
+		   MT6363_RG_VCN13_VOSEL_ADDR,
+		   MT6363_RG_VCN13_VOSEL_MASK,
+		   MT6363_RG_VCN13_VOCAL_ADDR,
+		   MT6363_RG_VCN13_VOCAL_MASK,
+		   MT6363_RG_LDO_VCN13_LP_ADDR,
+		   MT6363_RG_LDO_VCN13_LP_SHIFT, 180),
+	MT6363_LDO("vtref18", VTREF18, ldo_volt_table2,
+		   MT6363_RG_LDO_VTREF18_EN_ADDR, MT6363_RG_LDO_VTREF18_EN_SHIFT,
+		   MT6363_RG_VTREF18_VOSEL_ADDR,
+		   MT6363_RG_VTREF18_VOSEL_MASK,
+		   MT6363_RG_VTREF18_VOCAL_ADDR,
+		   MT6363_RG_VTREF18_VOCAL_MASK,
+		   MT6363_RG_LDO_VTREF18_LP_ADDR,
+		   MT6363_RG_LDO_VTREF18_LP_SHIFT, 240),
+	MT6363_LDO("vaux18", VAUX18, ldo_volt_table2,
+		   MT6363_RG_LDO_VAUX18_EN_ADDR, MT6363_RG_LDO_VAUX18_EN_SHIFT,
+		   MT6363_RG_VAUX18_VOSEL_ADDR,
+		   MT6363_RG_VAUX18_VOSEL_MASK,
+		   MT6363_RG_VAUX18_VOCAL_ADDR,
+		   MT6363_RG_VAUX18_VOCAL_MASK,
+		   MT6363_RG_LDO_VAUX18_LP_ADDR,
+		   MT6363_RG_LDO_VAUX18_LP_SHIFT, 240),
+	MT6363_LDO("vcn15", VCN15, ldo_volt_table3,
+		   MT6363_RG_LDO_VCN15_EN_ADDR, MT6363_RG_LDO_VCN15_EN_SHIFT,
+		   MT6363_RG_VCN15_VOSEL_ADDR,
+		   MT6363_RG_VCN15_VOSEL_MASK,
+		   MT6363_RG_VCN15_VOCAL_ADDR,
+		   MT6363_RG_VCN15_VOCAL_MASK,
+		   MT6363_RG_LDO_VCN15_LP_ADDR,
+		   MT6363_RG_LDO_VCN15_LP_SHIFT, 180),
+	MT6363_LDO("vufs18", VUFS18, ldo_volt_table3,
+		   MT6363_RG_LDO_VUFS18_EN_ADDR, MT6363_RG_LDO_VUFS18_EN_SHIFT,
+		   MT6363_RG_VUFS18_VOSEL_ADDR,
+		   MT6363_RG_VUFS18_VOSEL_MASK,
+		   MT6363_RG_VUFS18_VOCAL_ADDR,
+		   MT6363_RG_VUFS18_VOCAL_MASK,
+		   MT6363_RG_LDO_VUFS18_LP_ADDR,
+		   MT6363_RG_LDO_VUFS18_LP_SHIFT, 680),
+	MT6363_LDO("vio18", VIO18, ldo_volt_table3,
+		   MT6363_RG_LDO_VIO18_EN_ADDR, MT6363_RG_LDO_VIO18_EN_SHIFT,
+		   MT6363_RG_VIO18_VOSEL_ADDR,
+		   MT6363_RG_VIO18_VOSEL_MASK,
+		   MT6363_RG_VIO18_VOCAL_ADDR,
+		   MT6363_RG_VIO18_VOCAL_MASK,
+		   MT6363_RG_LDO_VIO18_LP_ADDR,
+		   MT6363_RG_LDO_VIO18_LP_SHIFT, 680),
+	MT6363_LDO("vm18", VM18, ldo_volt_table4,
+		   MT6363_RG_LDO_VM18_EN_ADDR, MT6363_RG_LDO_VM18_EN_SHIFT,
+		   MT6363_RG_VM18_VOSEL_ADDR,
+		   MT6363_RG_VM18_VOSEL_MASK,
+		   MT6363_RG_VM18_VOCAL_ADDR,
+		   MT6363_RG_VM18_VOCAL_MASK,
+		   MT6363_RG_LDO_VM18_LP_ADDR,
+		   MT6363_RG_LDO_VM18_LP_SHIFT, 280),
+	MT6363_LDO_OPS("va15", VA15, mt6363_va15_ops, ldo_volt_table3,
+		       MT6363_RG_LDO_VA15_EN_ADDR, MT6363_RG_LDO_VA15_EN_SHIFT,
+		       MT6363_RG_VA15_VOSEL_ADDR,
+		       MT6363_RG_VA15_VOSEL_MASK,
+		       MT6363_RG_VA15_VOCAL_ADDR,
+		       MT6363_RG_VA15_VOCAL_MASK,
+		       MT6363_RG_LDO_VA15_LP_ADDR,
+		       MT6363_RG_LDO_VA15_LP_SHIFT, 180),
+	MT6363_LDO("vrf18", VRF18, ldo_volt_table3,
+		   MT6363_RG_LDO_VRF18_EN_ADDR, MT6363_RG_LDO_VRF18_EN_SHIFT,
+		   MT6363_RG_VRF18_VOSEL_ADDR,
+		   MT6363_RG_VRF18_VOSEL_MASK,
+		   MT6363_RG_VRF18_VOCAL_ADDR,
+		   MT6363_RG_VRF18_VOCAL_MASK,
+		   MT6363_RG_LDO_VRF18_LP_ADDR,
+		   MT6363_RG_LDO_VRF18_LP_SHIFT, 180),
+	MT6363_LDO("vrfio18", VRFIO18, ldo_volt_table3,
+		   MT6363_RG_LDO_VRFIO18_EN_ADDR, MT6363_RG_LDO_VRFIO18_EN_SHIFT,
+		   MT6363_RG_VRFIO18_VOSEL_ADDR,
+		   MT6363_RG_VRFIO18_VOSEL_MASK,
+		   MT6363_RG_VRFIO18_VOCAL_ADDR,
+		   MT6363_RG_VRFIO18_VOCAL_MASK,
+		   MT6363_RG_LDO_VRFIO18_LP_ADDR,
+		   MT6363_RG_LDO_VRFIO18_LP_SHIFT, 180),
+	MT6363_LDO("vio075", VIO075, ldo_volt_table5,
+		   MT6363_RG_LDO_VIO075_EN_ADDR, MT6363_RG_LDO_VIO075_EN_SHIFT,
+		   MT6363_RG_VIO075_VOSEL_ADDR,
+		   MT6363_RG_VIO075_VOSEL_MASK,
+		   MT6363_RG_VIO075_VOCAL_ADDR,
+		   MT6363_RG_VIO075_VOCAL_MASK,
+		   MT6363_RG_LDO_VIO075_LP_ADDR,
+		   MT6363_RG_LDO_VIO075_LP_SHIFT, 3000),
+	MT6363_LDO("vufs12", VUFS12, ldo_volt_table4,
+		   MT6363_RG_LDO_VUFS12_EN_ADDR, MT6363_RG_LDO_VUFS12_EN_SHIFT,
+		   MT6363_RG_VUFS12_VOSEL_ADDR,
+		   MT6363_RG_VUFS12_VOSEL_MASK,
+		   MT6363_RG_VUFS12_VOCAL_ADDR,
+		   MT6363_RG_VUFS12_VOCAL_MASK,
+		   MT6363_RG_LDO_VUFS12_LP_ADDR,
+		   MT6363_RG_LDO_VUFS12_LP_SHIFT, 280),
+	MT6363_LDO("va12-1", VA12_1, ldo_volt_table3,
+		   MT6363_RG_LDO_VA12_1_EN_ADDR, MT6363_RG_LDO_VA12_1_EN_SHIFT,
+		   MT6363_RG_VA12_1_VOSEL_ADDR,
+		   MT6363_RG_VA12_1_VOSEL_MASK,
+		   MT6363_RG_VA12_1_VOCAL_ADDR,
+		   MT6363_RG_VA12_1_VOCAL_MASK,
+		   MT6363_RG_LDO_VA12_1_LP_ADDR,
+		   MT6363_RG_LDO_VA12_1_LP_SHIFT, 180),
+	MT6363_LDO("va12-2", VA12_2, ldo_volt_table3,
+		   MT6363_RG_LDO_VA12_2_EN_ADDR, MT6363_RG_LDO_VA12_2_EN_SHIFT,
+		   MT6363_RG_VA12_2_VOSEL_ADDR,
+		   MT6363_RG_VA12_2_VOSEL_MASK,
+		   MT6363_RG_VA12_2_VOCAL_ADDR,
+		   MT6363_RG_VA12_2_VOCAL_MASK,
+		   MT6363_RG_LDO_VA12_2_LP_ADDR,
+		   MT6363_RG_LDO_VA12_2_LP_SHIFT, 180),
+	MT6363_LDO("vrf12", VRF12, ldo_volt_table3,
+		   MT6363_RG_LDO_VRF12_EN_ADDR, MT6363_RG_LDO_VRF12_EN_SHIFT,
+		   MT6363_RG_VRF12_VOSEL_ADDR,
+		   MT6363_RG_VRF12_VOSEL_MASK,
+		   MT6363_RG_VRF12_VOCAL_ADDR,
+		   MT6363_RG_VRF12_VOCAL_MASK,
+		   MT6363_RG_LDO_VRF12_LP_ADDR,
+		   MT6363_RG_LDO_VRF12_LP_SHIFT, 180),
+	MT6363_LDO("vrf13", VRF13, ldo_volt_table1,
+		   MT6363_RG_LDO_VRF13_EN_ADDR, MT6363_RG_LDO_VRF13_EN_SHIFT,
+		   MT6363_RG_VRF13_VOSEL_ADDR,
+		   MT6363_RG_VRF13_VOSEL_MASK,
+		   MT6363_RG_VRF13_VOCAL_ADDR,
+		   MT6363_RG_VRF13_VOCAL_MASK,
+		   MT6363_RG_LDO_VRF13_LP_ADDR,
+		   MT6363_RG_LDO_VRF13_LP_SHIFT, 180),
+	MT6363_LDO("vrf09", VRF09, ldo_volt_table1,
+		   MT6363_RG_LDO_VRF09_EN_ADDR, MT6363_RG_LDO_VRF09_EN_SHIFT,
+		   MT6363_RG_VRF09_VOSEL_ADDR,
+		   MT6363_RG_VRF09_VOSEL_MASK,
+		   MT6363_RG_VRF09_VOCAL_ADDR,
+		   MT6363_RG_VRF09_VOCAL_MASK,
+		   MT6363_RG_LDO_VRF09_LP_ADDR,
+		   MT6363_RG_LDO_VRF09_LP_SHIFT, 180),
+	[MT6363_ID_ISINK_LOAD] = {
+		.desc = {
+			.name = "isink_load",
+			.of_match = of_match_ptr("isink-load"),
+			.regulators_node = "regulators",
+			.id = MT6363_ID_ISINK_LOAD,
+			.type = REGULATOR_CURRENT,
+			.ops = &isink_load_ops,
+			.owner = THIS_MODULE,
+		},
+	}
+};
+
+static void mt6363_oc_irq_enable_work(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct mt6363_regulator_info *info
+		= container_of(dwork, struct mt6363_regulator_info, oc_work);
+
+	enable_irq(info->irq);
+}
+
+static irqreturn_t mt6363_oc_irq(int irq, void *data)
+{
+	struct regulator_dev *rdev = (struct regulator_dev *)data;
+	struct mt6363_regulator_info *info = rdev_get_drvdata(rdev);
+
+	disable_irq_nosync(info->irq);
+	if (!regulator_is_enabled_regmap(rdev))
+		goto delayed_enable;
+	regulator_notifier_call_chain(rdev, REGULATOR_EVENT_OVER_CURRENT,
+				      NULL);
+delayed_enable:
+	schedule_delayed_work(&info->oc_work,
+			      msecs_to_jiffies(info->oc_irq_enable_delay_ms));
+	return IRQ_HANDLED;
+}
+
+static int mt6363_of_parse_cb(struct device_node *np,
+			      const struct regulator_desc *desc,
+			      struct regulator_config *config)
+{
+	int ret;
+	struct mt6363_regulator_info *info = config->driver_data;
+
+	if (info->irq > 0) {
+		ret = of_property_read_u32(np, "mediatek,oc-irq-enable-delay-ms",
+					   &info->oc_irq_enable_delay_ms);
+		if (ret || !info->oc_irq_enable_delay_ms)
+			info->oc_irq_enable_delay_ms = DEFAULT_DELAY_MS;
+		INIT_DELAYED_WORK(&info->oc_work, mt6363_oc_irq_enable_work);
+	}
+	return 0;
+}
+
+static int mt6363_backup_op_setting(struct regmap *map, struct mt6363_regulator_info *info)
+{
+	int i, ret;
+	u32 val = 0;
+
+	ret = regmap_read(map, info->op_en_reg + OP_CFG_OFFSET, &info->orig_op_cfg);
+	for (i = 0; i < 3; i++) {
+		ret |= regmap_read(map, info->op_en_reg + i, &val);
+		info->orig_op_en |= val << (i * 8);
+	}
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int mt6363_regulator_probe(struct platform_device *pdev)
+{
+	struct regulator_config config = {};
+	struct regulator_dev *rdev;
+	struct mt6363_regulator_info *info;
+	int i, ret;
+
+	config.dev = pdev->dev.parent;
+	config.regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	for (i = 0; i < MT6363_MAX_REGULATOR; i++) {
+		info = &mt6363_regulators[i];
+		info->irq = platform_get_irq_byname_optional(pdev, info->desc.name);
+		config.driver_data = info;
+
+		rdev = devm_regulator_register(&pdev->dev, &info->desc, &config);
+		if (IS_ERR(rdev)) {
+			ret = PTR_ERR(rdev);
+			dev_err(&pdev->dev, "failed to register %s, ret=%d\n",
+				info->desc.name, ret);
+			continue;
+		}
+		if (info->lp_imax_uA) {
+			ret = mt6363_backup_op_setting(config.regmap, info);
+			if (ret) {
+				dev_notice(&pdev->dev, "failed to backup op_setting (%s)\n",
+					   info->desc.name);
+				info->lp_imax_uA = 0;
+			}
+		}
+
+		if (info->irq <= 0)
+			continue;
+		ret = devm_request_threaded_irq(&pdev->dev, info->irq, NULL,
+						mt6363_oc_irq,
+						IRQF_TRIGGER_HIGH,
+						info->desc.name,
+						rdev);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to request IRQ:%s, ret=%d",
+				info->desc.name, ret);
+			continue;
+		}
+	}
+
+	return 0;
+}
+
+static const struct platform_device_id mt6363_regulator_ids[] = {
+	{ "mt6363-regulator", 0},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(platform, mt6363_regulator_ids);
+
+static struct platform_driver mt6363_regulator_driver = {
+	.driver = {
+		.name = "mt6363-regulator",
+	},
+	.probe = mt6363_regulator_probe,
+	.id_table = mt6363_regulator_ids,
+};
+module_platform_driver(mt6363_regulator_driver);
+
+MODULE_AUTHOR("Lu Tang <lu.tang@mediatek.com>");
+MODULE_DESCRIPTION("Regulator Driver for MediaTek MT6363 PMIC");
+MODULE_LICENSE("GPL");
diff --git a/drivers/regulator/mt6373-regulator.c b/drivers/regulator/mt6373-regulator.c
new file mode 100644
index 000000000000..5a8a9f84d13a
--- /dev/null
+++ b/drivers/regulator/mt6373-regulator.c
@@ -0,0 +1,826 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2024 MediaTek Inc.
+
+#include <linux/interrupt.h>
+#include <linux/mfd/mt6373/registers.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/mt6373-regulator.h>
+#include <linux/regulator/of_regulator.h>
+
+#define SET_OFFSET	0x1
+#define CLR_OFFSET	0x2
+
+#define MT6373_REGULATOR_MODE_NORMAL	0
+#define MT6373_REGULATOR_MODE_FCCM	1
+#define MT6373_REGULATOR_MODE_LP	2
+#define MT6373_REGULATOR_MODE_ULP	3
+
+#define DEFAULT_DELAY_MS		10
+
+#define MT6373_RG_RSV_SWREG_H		0xa09
+#define MT6373_PLG_CFG_ELR1		0x3ab
+#define MT6373_ELR_MASK			0xc
+
+/*
+ * MT6373 regulators' information
+ *
+ * @desc: standard fields of regulator description.
+ * @lp_mode_reg: for operating NORMAL/IDLE mode register.
+ * @lp_mode_mask: MASK for operating lp_mode register.
+ * @modeset_reg: for operating AUTO/PWM mode register.
+ * @modeset_mask: MASK for operating modeset register.
+ * @modeset_reg: Calibrates output voltage register.
+ * @modeset_mask: MASK of Calibrates output voltage register.
+ */
+struct mt6373_regulator_info {
+	int irq;
+	int oc_irq_enable_delay_ms;
+	struct delayed_work oc_work;
+	struct regulator_desc desc;
+	u32 lp_mode_reg;
+	u32 lp_mode_mask;
+	u32 modeset_reg;
+	u32 modeset_mask;
+	u32 vocal_reg;
+	u32 vocal_mask;
+};
+
+#define MT6373_BUCK(match, _name, min, max, step,		\
+		    _enable_reg, en_bit, _vsel_reg, _vsel_mask, \
+		    _lp_mode_reg, lp_bit,			\
+		    _modeset_reg, modeset_bit, _en_delay)			\
+[MT6373_ID_##_name] = {						\
+	.desc = {						\
+		.name = #_name,					\
+		.of_match = of_match_ptr(match),		\
+		.of_parse_cb = mt6373_of_parse_cb,		\
+		.regulators_node = "regulators",		\
+		.ops = &mt6373_buck_ops,			\
+		.type = REGULATOR_VOLTAGE,			\
+		.id = MT6373_ID_##_name,			\
+		.owner = THIS_MODULE,				\
+		.n_voltages = ((max) - (min)) / (step) + 1,	\
+		.min_uV = (min),		\
+		.uV_step = (step),		\
+		.enable_reg = _enable_reg,			\
+		.enable_mask = BIT(en_bit),			\
+		.enable_time = _en_delay,			\
+		.vsel_reg = _vsel_reg,				\
+		.vsel_mask = _vsel_mask,			\
+		.of_map_mode = mt6373_map_mode,			\
+	},							\
+	.lp_mode_reg = _lp_mode_reg,				\
+	.lp_mode_mask = BIT(lp_bit),				\
+	.modeset_reg = _modeset_reg,				\
+	.modeset_mask = BIT(modeset_bit),			\
+}
+
+#define MT6373_LDO_LINEAR(match, _name, min, max, step,	\
+			  _enable_reg, en_bit, _vsel_reg,	\
+			  _vsel_mask, _lp_mode_reg, lp_bit, _en_delay)	\
+[MT6373_ID_##_name] = {						\
+	.desc = {						\
+		.name = #_name,					\
+		.of_match = of_match_ptr(match),		\
+		.of_parse_cb = mt6373_of_parse_cb,		\
+		.regulators_node = "regulators",		\
+		.ops = &mt6373_volt_range_ops,			\
+		.type = REGULATOR_VOLTAGE,			\
+		.id = MT6373_ID_##_name,			\
+		.owner = THIS_MODULE,				\
+		.n_voltages = ((max) - (min)) / (step) + 1,	\
+		.min_uV = (min),		\
+		.uV_step = (step),		\
+		.enable_reg = _enable_reg,			\
+		.enable_mask = BIT(en_bit),			\
+		.enable_time = _en_delay,			\
+		.vsel_reg = _vsel_reg,				\
+		.vsel_mask = _vsel_mask,			\
+		.of_map_mode = mt6373_map_mode,			\
+	},							\
+	.lp_mode_reg = _lp_mode_reg,				\
+	.lp_mode_mask = BIT(lp_bit),				\
+}
+
+#define MT6373_LDO(match, _name, _volt_table, _enable_reg, en_bit,	\
+		   _vsel_reg, _vsel_mask, _vocal_reg,		\
+		   _vocal_mask, _lp_mode_reg, lp_bit, _en_delay)		\
+[MT6373_ID_##_name] = {						\
+	.desc = {						\
+		.name = #_name,					\
+		.of_match = of_match_ptr(match),		\
+		.of_parse_cb = mt6373_of_parse_cb,		\
+		.regulators_node = "regulators",		\
+		.ops = &mt6373_volt_table_ops,			\
+		.type = REGULATOR_VOLTAGE,			\
+		.id = MT6373_ID_##_name,			\
+		.owner = THIS_MODULE,				\
+		.n_voltages = ARRAY_SIZE(_volt_table),		\
+		.volt_table = _volt_table,			\
+		.enable_reg = _enable_reg,			\
+		.enable_mask = BIT(en_bit),			\
+		.enable_time = _en_delay,			\
+		.vsel_reg = _vsel_reg,				\
+		.vsel_mask = _vsel_mask,			\
+		.of_map_mode = mt6373_map_mode,			\
+	},							\
+	.vocal_reg = _vocal_reg,				\
+	.vocal_mask = _vocal_mask,				\
+	.lp_mode_reg = _lp_mode_reg,				\
+	.lp_mode_mask = BIT(lp_bit),				\
+}
+
+#define MT6373_VMCH_EINT(match, _eint_pol, _volt_table, _en_delay)		\
+[MT6373_ID_VMCH_##_eint_pol] = {				\
+	.desc = {						\
+		.name = "VMCH_"#_eint_pol,			\
+		.of_match = of_match_ptr(match),	\
+		.of_parse_cb = mt6373_of_parse_cb,		\
+		.regulators_node = "regulators",		\
+		.ops = &mt6373_vmch_eint_ops,			\
+		.type = REGULATOR_VOLTAGE,			\
+		.id = MT6373_ID_VMCH_##_eint_pol,		\
+		.owner = THIS_MODULE,				\
+		.n_voltages = ARRAY_SIZE(_volt_table),		\
+		.volt_table = _volt_table,			\
+		.enable_reg = MT6373_LDO_VMCH_EINT,	\
+		.enable_mask = MT6373_PMIC_RG_LDO_VMCH_EINT_EN_MASK,	\
+		.enable_time = _en_delay,			\
+		.vsel_reg = MT6373_PMIC_RG_VMCH_VOSEL_ADDR,	\
+		.vsel_mask = MT6373_PMIC_RG_VMCH_VOSEL_MASK,	\
+		.of_map_mode = mt6373_map_mode,			\
+	},							\
+	.vocal_reg = MT6373_PMIC_RG_VMCH_VOCAL_ADDR,		\
+	.vocal_mask = MT6373_PMIC_RG_VMCH_VOCAL_MASK,		\
+	.lp_mode_reg = MT6373_PMIC_RG_LDO_VMCH_LP_ADDR,		\
+	.lp_mode_mask = BIT(MT6373_PMIC_RG_LDO_VMCH_LP_SHIFT),	\
+}
+
+static const unsigned int ldo_volt_table1[] = {
+	1200000, 1300000, 1500000, 1700000, 1800000, 2000000, 2100000, 2200000,
+	2700000, 2800000, 2900000, 3000000, 3100000, 3300000, 3400000, 3500000,
+};
+
+static const unsigned int ldo_volt_table2[] = {
+	1800000, 1900000, 2000000, 2100000, 2200000, 2300000, 2400000, 2500000,
+	2600000, 2700000, 2800000, 2900000, 3000000, 3100000, 3200000, 3300000,
+};
+
+static const unsigned int ldo_volt_table3[] = {
+	600000, 700000, 800000, 900000, 1000000, 1100000, 1200000, 1300000,
+	1400000, 1500000, 1600000, 1700000, 1800000, 1900000, 2000000, 2100000,
+};
+
+static const unsigned int ldo_volt_table4[] = {
+	1200000, 1300000, 1500000, 1700000, 1800000, 2000000, 2500000, 2600000,
+	2700000, 2800000, 2900000, 3000000, 3100000, 3300000, 3400000, 3500000,
+};
+
+static const unsigned int ldo_volt_table5[] = {
+	900000, 1000000, 1100000, 1200000, 1300000, 1700000, 1800000, 1810000,
+};
+
+static int mt6373_buck_enable(struct regulator_dev *rdev)
+{
+	return regmap_write(rdev->regmap, rdev->desc->enable_reg + SET_OFFSET,
+			    rdev->desc->enable_mask);
+}
+
+static int mt6373_buck_disable(struct regulator_dev *rdev)
+{
+	return regmap_write(rdev->regmap, rdev->desc->enable_reg + CLR_OFFSET,
+			    rdev->desc->enable_mask);
+}
+
+static inline unsigned int mt6373_map_mode(unsigned int mode)
+{
+	switch (mode) {
+	case MT6373_REGULATOR_MODE_NORMAL:
+		return REGULATOR_MODE_NORMAL;
+	case MT6373_REGULATOR_MODE_FCCM:
+		return REGULATOR_MODE_FAST;
+	case MT6373_REGULATOR_MODE_LP:
+		return REGULATOR_MODE_IDLE;
+	case MT6373_REGULATOR_MODE_ULP:
+		return REGULATOR_MODE_STANDBY;
+	default:
+		return REGULATOR_MODE_INVALID;
+	}
+}
+
+static unsigned int mt6373_regulator_get_mode(struct regulator_dev *rdev)
+{
+	struct mt6373_regulator_info *info = rdev_get_drvdata(rdev);
+	unsigned int val = 0;
+	int ret;
+
+	ret = regmap_read(rdev->regmap, info->modeset_reg, &val);
+	if (ret) {
+		dev_err(&rdev->dev, "Failed to get mt6373 mode: %d\n", ret);
+		return ret;
+	}
+
+	if (val & info->modeset_mask)
+		return REGULATOR_MODE_FAST;
+
+	ret = regmap_read(rdev->regmap, info->lp_mode_reg, &val);
+	if (ret) {
+		dev_err(&rdev->dev,
+			"Failed to get mt6373 lp mode: %d\n", ret);
+		return ret;
+	}
+
+	if (val & info->lp_mode_mask)
+		return REGULATOR_MODE_IDLE;
+	else
+		return REGULATOR_MODE_NORMAL;
+}
+
+static int mt6373_buck_unlock(struct regmap *map, bool unlock)
+{
+	u8 buf[2];
+
+	if (unlock) {
+		buf[0] = 0x43;
+		buf[1] = 0x55;
+	} else
+		buf[0] = buf[1] = 0;
+	return regmap_bulk_write(map, MT6373_BUCK_TOP_KEY_PROT_LO, buf, 2);
+}
+
+static int mt6373_regulator_set_mode(struct regulator_dev *rdev,
+				     unsigned int mode)
+{
+	struct mt6373_regulator_info *info = rdev_get_drvdata(rdev);
+	int ret = 0;
+	int curr_mode;
+
+	curr_mode = mt6373_regulator_get_mode(rdev);
+	switch (mode) {
+	case REGULATOR_MODE_FAST:
+		ret = mt6373_buck_unlock(rdev->regmap, true);
+		if (ret)
+			return ret;
+		ret = regmap_update_bits(rdev->regmap,
+					 info->modeset_reg,
+					 info->modeset_mask,
+					 info->modeset_mask);
+		ret |= mt6373_buck_unlock(rdev->regmap, false);
+		break;
+	case REGULATOR_MODE_NORMAL:
+		if (curr_mode == REGULATOR_MODE_FAST) {
+			ret = mt6373_buck_unlock(rdev->regmap, true);
+			if (ret)
+				return ret;
+			ret = regmap_update_bits(rdev->regmap,
+						 info->modeset_reg,
+						 info->modeset_mask,
+						 0);
+			ret |= mt6373_buck_unlock(rdev->regmap, false);
+		} else if (curr_mode == REGULATOR_MODE_IDLE) {
+			ret = regmap_update_bits(rdev->regmap,
+						 info->lp_mode_reg,
+						 info->lp_mode_mask,
+						 0);
+			udelay(100);
+		}
+		break;
+	case REGULATOR_MODE_IDLE:
+		ret = regmap_update_bits(rdev->regmap,
+					 info->lp_mode_reg,
+					 info->lp_mode_mask,
+					 info->lp_mode_mask);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (ret) {
+		dev_err(&rdev->dev,
+			"Failed to set mt6373 mode(%d): %d\n", mode, ret);
+	}
+	return ret;
+}
+
+static int mt6373_vmch_eint_enable(struct regulator_dev *rdev)
+{
+	unsigned int val;
+	int ret;
+
+	if (rdev->desc->id == MT6373_ID_VMCH_EINT_HIGH)
+		val = MT6373_PMIC_RG_LDO_VMCH_EINT_POL_MASK;
+	else
+		val = 0;
+	ret = regmap_update_bits(rdev->regmap, MT6373_LDO_VMCH_EINT,
+				 MT6373_PMIC_RG_LDO_VMCH_EINT_POL_MASK, val);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(rdev->regmap, MT6373_PMIC_RG_LDO_VMCH_EN_ADDR,
+				 BIT(MT6373_PMIC_RG_LDO_VMCH_EN_SHIFT),
+				 BIT(MT6373_PMIC_RG_LDO_VMCH_EN_SHIFT));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
+				 rdev->desc->enable_mask, rdev->desc->enable_mask);
+	return ret;
+}
+
+static int mt6373_vmch_eint_disable(struct regulator_dev *rdev)
+{
+	int ret;
+
+	ret = regmap_update_bits(rdev->regmap, MT6373_PMIC_RG_LDO_VMCH_EN_ADDR,
+				 BIT(MT6373_PMIC_RG_LDO_VMCH_EN_SHIFT), 0);
+	if (ret)
+		return ret;
+
+	udelay(1500); /* Must delay for VMCH discharging */
+	ret = regmap_update_bits(rdev->regmap, rdev->desc->enable_reg,
+				 rdev->desc->enable_mask, 0);
+	return ret;
+}
+
+static const struct regulator_ops mt6373_buck_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.map_voltage = regulator_map_voltage_linear,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = mt6373_buck_enable,
+	.disable = mt6373_buck_disable,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_mode = mt6373_regulator_set_mode,
+	.get_mode = mt6373_regulator_get_mode,
+};
+
+static const struct regulator_ops mt6373_volt_range_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.map_voltage = regulator_map_voltage_linear,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_mode = mt6373_regulator_set_mode,
+	.get_mode = mt6373_regulator_get_mode,
+};
+
+static const struct regulator_ops mt6373_volt_table_ops = {
+	.list_voltage = regulator_list_voltage_table,
+	.map_voltage = regulator_map_voltage_iterate,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_mode = mt6373_regulator_set_mode,
+	.get_mode = mt6373_regulator_get_mode,
+};
+
+static const struct regulator_ops mt6373_vmch_eint_ops = {
+	.list_voltage = regulator_list_voltage_table,
+	.map_voltage = regulator_map_voltage_iterate,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = mt6373_vmch_eint_enable,
+	.disable = mt6373_vmch_eint_disable,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_mode = mt6373_regulator_set_mode,
+	.get_mode = mt6373_regulator_get_mode,
+};
+
+static int mt6373_of_parse_cb(struct device_node *np,
+			      const struct regulator_desc *desc,
+			      struct regulator_config *config);
+
+/* The array is indexed by id(MT6373_ID_XXX) */
+static struct mt6373_regulator_info mt6373_regulators[] = {
+	MT6373_BUCK("vbuck0", VBUCK0, 0, 1193750, 6250,
+		    MT6373_PMIC_RG_BUCK_VBUCK0_EN_ADDR,
+		    MT6373_PMIC_RG_BUCK_VBUCK0_EN_SHIFT,
+		    MT6373_PMIC_RG_BUCK_VBUCK0_VOSEL_ADDR,
+		    MT6373_PMIC_RG_BUCK_VBUCK0_VOSEL_MASK,
+		    MT6373_PMIC_RG_BUCK_VBUCK0_LP_ADDR,
+		    MT6373_PMIC_RG_BUCK_VBUCK0_LP_SHIFT,
+		    MT6373_PMIC_RG_VBUCK0_FCCM_ADDR,
+		    MT6373_PMIC_RG_VBUCK0_FCCM_SHIFT, 180),
+	MT6373_BUCK("vbuck1", VBUCK1, 0, 1193750, 6250,
+		    MT6373_PMIC_RG_BUCK_VBUCK1_EN_ADDR,
+		    MT6373_PMIC_RG_BUCK_VBUCK1_EN_SHIFT,
+		    MT6373_PMIC_RG_BUCK_VBUCK1_VOSEL_ADDR,
+		    MT6373_PMIC_RG_BUCK_VBUCK1_VOSEL_MASK,
+		    MT6373_PMIC_RG_BUCK_VBUCK1_LP_ADDR,
+		    MT6373_PMIC_RG_BUCK_VBUCK1_LP_SHIFT,
+		    MT6373_PMIC_RG_VBUCK1_FCCM_ADDR,
+		    MT6373_PMIC_RG_VBUCK1_FCCM_SHIFT, 200),
+	MT6373_BUCK("vbuck2", VBUCK2, 0, 1193750, 6250,
+		    MT6373_PMIC_RG_BUCK_VBUCK2_EN_ADDR,
+		    MT6373_PMIC_RG_BUCK_VBUCK2_EN_SHIFT,
+		    MT6373_PMIC_RG_BUCK_VBUCK2_VOSEL_ADDR,
+		    MT6373_PMIC_RG_BUCK_VBUCK2_VOSEL_MASK,
+		    MT6373_PMIC_RG_BUCK_VBUCK2_LP_ADDR,
+		    MT6373_PMIC_RG_BUCK_VBUCK2_LP_SHIFT,
+		    MT6373_PMIC_RG_VBUCK2_FCCM_ADDR,
+		    MT6373_PMIC_RG_VBUCK2_FCCM_SHIFT, 200),
+	MT6373_BUCK("vbuck3", VBUCK3, 0, 1193750, 6250,
+		    MT6373_PMIC_RG_BUCK_VBUCK3_EN_ADDR,
+		    MT6373_PMIC_RG_BUCK_VBUCK3_EN_SHIFT,
+		    MT6373_PMIC_RG_BUCK_VBUCK3_VOSEL_ADDR,
+		    MT6373_PMIC_RG_BUCK_VBUCK3_VOSEL_MASK,
+		    MT6373_PMIC_RG_BUCK_VBUCK3_LP_ADDR,
+		    MT6373_PMIC_RG_BUCK_VBUCK3_LP_SHIFT,
+		    MT6373_PMIC_RG_VBUCK3_FCCM_ADDR,
+		    MT6373_PMIC_RG_VBUCK3_FCCM_SHIFT, 200),
+	MT6373_BUCK("vbuck4", VBUCK4, 0, 1193750, 6250,
+		    MT6373_PMIC_RG_BUCK_VBUCK4_EN_ADDR,
+		    MT6373_PMIC_RG_BUCK_VBUCK4_EN_SHIFT,
+		    MT6373_PMIC_RG_BUCK_VBUCK4_VOSEL_ADDR,
+		    MT6373_PMIC_RG_BUCK_VBUCK4_VOSEL_MASK,
+		    MT6373_PMIC_RG_BUCK_VBUCK4_LP_ADDR,
+		    MT6373_PMIC_RG_BUCK_VBUCK4_LP_SHIFT,
+		    MT6373_PMIC_RG_VBUCK4_FCCM_ADDR,
+		    MT6373_PMIC_RG_VBUCK4_FCCM_SHIFT, 180),
+	MT6373_BUCK("vbuck4-ufs", VBUCK4_UFS, 0, 2650125, 13875,
+		    MT6373_PMIC_RG_BUCK_VBUCK4_EN_ADDR,
+		    MT6373_PMIC_RG_BUCK_VBUCK4_EN_SHIFT,
+		    MT6373_PMIC_RG_BUCK_VBUCK4_VOSEL_ADDR,
+		    MT6373_PMIC_RG_BUCK_VBUCK4_VOSEL_MASK,
+		    MT6373_PMIC_RG_BUCK_VBUCK4_LP_ADDR,
+		    MT6373_PMIC_RG_BUCK_VBUCK4_LP_SHIFT,
+		    MT6373_PMIC_RG_VBUCK4_FCCM_ADDR,
+		    MT6373_PMIC_RG_VBUCK4_FCCM_SHIFT, 180),
+	MT6373_BUCK("vbuck5", VBUCK5, 0, 1193750, 6250,
+		    MT6373_PMIC_RG_BUCK_VBUCK5_EN_ADDR,
+		    MT6373_PMIC_RG_BUCK_VBUCK5_EN_SHIFT,
+		    MT6373_PMIC_RG_BUCK_VBUCK5_VOSEL_ADDR,
+		    MT6373_PMIC_RG_BUCK_VBUCK5_VOSEL_MASK,
+		    MT6373_PMIC_RG_BUCK_VBUCK5_LP_ADDR,
+		    MT6373_PMIC_RG_BUCK_VBUCK5_LP_SHIFT,
+		    MT6373_PMIC_RG_VBUCK5_FCCM_ADDR,
+		    MT6373_PMIC_RG_VBUCK5_FCCM_SHIFT, 200),
+	MT6373_BUCK("vbuck6", VBUCK6, 0, 1193750, 6250,
+		    MT6373_PMIC_RG_BUCK_VBUCK6_EN_ADDR,
+		    MT6373_PMIC_RG_BUCK_VBUCK6_EN_SHIFT,
+		    MT6373_PMIC_RG_BUCK_VBUCK6_VOSEL_ADDR,
+		    MT6373_PMIC_RG_BUCK_VBUCK6_VOSEL_MASK,
+		    MT6373_PMIC_RG_BUCK_VBUCK6_LP_ADDR,
+		    MT6373_PMIC_RG_BUCK_VBUCK6_LP_SHIFT,
+		    MT6373_PMIC_RG_VBUCK6_FCCM_ADDR,
+		    MT6373_PMIC_RG_VBUCK6_FCCM_SHIFT, 200),
+	MT6373_BUCK("vbuck7", VBUCK7, 0, 1193750, 6250,
+		    MT6373_PMIC_RG_BUCK_VBUCK7_EN_ADDR,
+		    MT6373_PMIC_RG_BUCK_VBUCK7_EN_SHIFT,
+		    MT6373_PMIC_RG_BUCK_VBUCK7_VOSEL_ADDR,
+		    MT6373_PMIC_RG_BUCK_VBUCK7_VOSEL_MASK,
+		    MT6373_PMIC_RG_BUCK_VBUCK7_LP_ADDR,
+		    MT6373_PMIC_RG_BUCK_VBUCK7_LP_SHIFT,
+		    MT6373_PMIC_RG_VBUCK7_FCCM_ADDR,
+		    MT6373_PMIC_RG_VBUCK7_FCCM_SHIFT, 200),
+	MT6373_BUCK("vbuck8", VBUCK8, 0, 1193750, 6250,
+		    MT6373_PMIC_RG_BUCK_VBUCK8_EN_ADDR,
+		    MT6373_PMIC_RG_BUCK_VBUCK8_EN_SHIFT,
+		    MT6373_PMIC_RG_BUCK_VBUCK8_VOSEL_ADDR,
+		    MT6373_PMIC_RG_BUCK_VBUCK8_VOSEL_MASK,
+		    MT6373_PMIC_RG_BUCK_VBUCK8_LP_ADDR,
+		    MT6373_PMIC_RG_BUCK_VBUCK8_LP_SHIFT,
+		    MT6373_PMIC_RG_VBUCK8_FCCM_ADDR,
+		    MT6373_PMIC_RG_VBUCK8_FCCM_SHIFT, 200),
+	MT6373_BUCK("vbuck9", VBUCK9, 0, 1193750, 6250,
+		    MT6373_PMIC_RG_BUCK_VBUCK9_EN_ADDR,
+		    MT6373_PMIC_RG_BUCK_VBUCK9_EN_SHIFT,
+		    MT6373_PMIC_RG_BUCK_VBUCK9_VOSEL_ADDR,
+		    MT6373_PMIC_RG_BUCK_VBUCK9_VOSEL_MASK,
+		    MT6373_PMIC_RG_BUCK_VBUCK9_LP_ADDR,
+		    MT6373_PMIC_RG_BUCK_VBUCK9_LP_SHIFT,
+		    MT6373_PMIC_RG_VBUCK9_FCCM_ADDR,
+		    MT6373_PMIC_RG_VBUCK9_FCCM_SHIFT, 200),
+	MT6373_LDO_LINEAR("vsram-digrf-aif", VSRAM_DIGRF_AIF, 400000, 1193750, 6250,
+			  MT6373_PMIC_RG_LDO_VSRAM_DIGRF_AIF_EN_ADDR,
+			  MT6373_PMIC_RG_LDO_VSRAM_DIGRF_AIF_EN_SHIFT,
+			  MT6373_PMIC_RG_LDO_VSRAM_DIGRF_AIF_VOSEL_ADDR,
+			  MT6373_PMIC_RG_LDO_VSRAM_DIGRF_AIF_VOSEL_MASK,
+			  MT6373_PMIC_RG_LDO_VSRAM_DIGRF_AIF_LP_ADDR,
+			  MT6373_PMIC_RG_LDO_VSRAM_DIGRF_AIF_LP_SHIFT, 180),
+	MT6373_LDO("vusb", VUSB, ldo_volt_table1,
+		   MT6373_PMIC_RG_LDO_VUSB_EN_ADDR, MT6373_PMIC_RG_LDO_VUSB_EN_SHIFT,
+		   MT6373_PMIC_RG_VUSB_VOSEL_ADDR,
+		   MT6373_PMIC_RG_VUSB_VOSEL_MASK,
+		   MT6373_PMIC_RG_VUSB_VOCAL_ADDR,
+		   MT6373_PMIC_RG_VUSB_VOCAL_MASK,
+		   MT6373_PMIC_RG_LDO_VUSB_LP_ADDR,
+		   MT6373_PMIC_RG_LDO_VUSB_LP_SHIFT, 720),
+	MT6373_LDO("vaux18", VAUX18, ldo_volt_table2,
+		   MT6373_PMIC_RG_LDO_VAUX18_EN_ADDR, MT6373_PMIC_RG_LDO_VAUX18_EN_SHIFT,
+		   MT6373_PMIC_RG_VAUX18_VOSEL_ADDR,
+		   MT6373_PMIC_RG_VAUX18_VOSEL_MASK,
+		   MT6373_PMIC_RG_VAUX18_VOCAL_ADDR,
+		   MT6373_PMIC_RG_VAUX18_VOCAL_MASK,
+		   MT6373_PMIC_RG_LDO_VAUX18_LP_ADDR,
+		   MT6373_PMIC_RG_LDO_VAUX18_LP_SHIFT, 240),
+	MT6373_LDO("vrf13-aif", VRF13_AIF, ldo_volt_table3,
+		   MT6373_PMIC_RG_LDO_VRF13_AIF_EN_ADDR, MT6373_PMIC_RG_LDO_VRF13_AIF_EN_SHIFT,
+		   MT6373_PMIC_RG_VRF13_AIF_VOSEL_ADDR,
+		   MT6373_PMIC_RG_VRF13_AIF_VOSEL_MASK,
+		   MT6373_PMIC_RG_VRF13_AIF_VOCAL_ADDR,
+		   MT6373_PMIC_RG_VRF13_AIF_VOCAL_MASK,
+		   MT6373_PMIC_RG_LDO_VRF13_AIF_LP_ADDR,
+		   MT6373_PMIC_RG_LDO_VRF13_AIF_LP_SHIFT, 720),
+	MT6373_LDO("vrf18-aif", VRF18_AIF, ldo_volt_table3,
+		   MT6373_PMIC_RG_LDO_VRF18_AIF_EN_ADDR, MT6373_PMIC_RG_LDO_VRF18_AIF_EN_SHIFT,
+		   MT6373_PMIC_RG_VRF18_AIF_VOSEL_ADDR,
+		   MT6373_PMIC_RG_VRF18_AIF_VOSEL_MASK,
+		   MT6373_PMIC_RG_VRF18_AIF_VOCAL_ADDR,
+		   MT6373_PMIC_RG_VRF18_AIF_VOCAL_MASK,
+		   MT6373_PMIC_RG_LDO_VRF18_AIF_LP_ADDR,
+		   MT6373_PMIC_RG_LDO_VRF18_AIF_LP_SHIFT, 720),
+	MT6373_LDO("vrfio18-aif", VRFIO18_AIF, ldo_volt_table3,
+		   MT6373_PMIC_RG_LDO_VRFIO18_AIF_EN_ADDR, MT6373_PMIC_RG_LDO_VRFIO18_AIF_EN_SHIFT,
+		   MT6373_PMIC_RG_VRFIO18_AIF_VOSEL_ADDR,
+		   MT6373_PMIC_RG_VRFIO18_AIF_VOSEL_MASK,
+		   MT6373_PMIC_RG_VRFIO18_AIF_VOCAL_ADDR,
+		   MT6373_PMIC_RG_VRFIO18_AIF_VOCAL_MASK,
+		   MT6373_PMIC_RG_LDO_VRFIO18_AIF_LP_ADDR,
+		   MT6373_PMIC_RG_LDO_VRFIO18_AIF_LP_SHIFT, 720),
+	MT6373_LDO("vrf09-aif", VRF09_AIF, ldo_volt_table3,
+		   MT6373_PMIC_RG_LDO_VRF09_AIF_EN_ADDR, MT6373_PMIC_RG_LDO_VRF09_AIF_EN_SHIFT,
+		   MT6373_PMIC_RG_VRF09_AIF_VOSEL_ADDR,
+		   MT6373_PMIC_RG_VRF09_AIF_VOSEL_MASK,
+		   MT6373_PMIC_RG_VRF09_AIF_VOCAL_ADDR,
+		   MT6373_PMIC_RG_VRF09_AIF_VOCAL_MASK,
+		   MT6373_PMIC_RG_LDO_VRF09_AIF_LP_ADDR,
+		   MT6373_PMIC_RG_LDO_VRF09_AIF_LP_SHIFT, 720),
+	MT6373_LDO("vrf12-aif", VRF12_AIF, ldo_volt_table5,
+		   MT6373_PMIC_RG_LDO_VRF12_AIF_EN_ADDR, MT6373_PMIC_RG_LDO_VRF12_AIF_EN_SHIFT,
+		   MT6373_PMIC_RG_VRF12_AIF_VOSEL_ADDR,
+		   MT6373_PMIC_RG_VRF12_AIF_VOSEL_MASK,
+		   MT6373_PMIC_RG_VRF12_AIF_VOCAL_ADDR,
+		   MT6373_PMIC_RG_VRF12_AIF_VOCAL_MASK,
+		   MT6373_PMIC_RG_LDO_VRF12_AIF_LP_ADDR,
+		   MT6373_PMIC_RG_LDO_VRF12_AIF_LP_SHIFT, 720),
+	MT6373_LDO("vant18", VANT18, ldo_volt_table3,
+		   MT6373_PMIC_RG_LDO_VANT18_EN_ADDR, MT6373_PMIC_RG_LDO_VANT18_EN_SHIFT,
+		   MT6373_PMIC_RG_VANT18_VOSEL_ADDR,
+		   MT6373_PMIC_RG_VANT18_VOSEL_MASK,
+		   MT6373_PMIC_RG_VANT18_VOCAL_ADDR,
+		   MT6373_PMIC_RG_VANT18_VOCAL_MASK,
+		   MT6373_PMIC_RG_LDO_VANT18_LP_ADDR,
+		   MT6373_PMIC_RG_LDO_VANT18_LP_SHIFT, 720),
+	MT6373_LDO("vibr", VIBR, ldo_volt_table1,
+		   MT6373_PMIC_RG_LDO_VIBR_EN_ADDR, MT6373_PMIC_RG_LDO_VIBR_EN_SHIFT,
+		   MT6373_PMIC_RG_VIBR_VOSEL_ADDR,
+		   MT6373_PMIC_RG_VIBR_VOSEL_MASK,
+		   MT6373_PMIC_RG_VIBR_VOCAL_ADDR,
+		   MT6373_PMIC_RG_VIBR_VOCAL_MASK,
+		   MT6373_PMIC_RG_LDO_VIBR_LP_ADDR,
+		   MT6373_PMIC_RG_LDO_VIBR_LP_SHIFT, 210),
+	MT6373_LDO("vio28", VIO28, ldo_volt_table1,
+		   MT6373_PMIC_RG_LDO_VIO28_EN_ADDR, MT6373_PMIC_RG_LDO_VIO28_EN_SHIFT,
+		   MT6373_PMIC_RG_VIO28_VOSEL_ADDR,
+		   MT6373_PMIC_RG_VIO28_VOSEL_MASK,
+		   MT6373_PMIC_RG_VIO28_VOCAL_ADDR,
+		   MT6373_PMIC_RG_VIO28_VOCAL_MASK,
+		   MT6373_PMIC_RG_LDO_VIO28_LP_ADDR,
+		   MT6373_PMIC_RG_LDO_VIO28_LP_SHIFT, 210),
+	MT6373_LDO("vfp", VFP, ldo_volt_table1,
+		   MT6373_PMIC_RG_LDO_VFP_EN_ADDR, MT6373_PMIC_RG_LDO_VFP_EN_SHIFT,
+		   MT6373_PMIC_RG_VFP_VOSEL_ADDR,
+		   MT6373_PMIC_RG_VFP_VOSEL_MASK,
+		   MT6373_PMIC_RG_VFP_VOCAL_ADDR,
+		   MT6373_PMIC_RG_VFP_VOCAL_MASK,
+		   MT6373_PMIC_RG_LDO_VFP_LP_ADDR,
+		   MT6373_PMIC_RG_LDO_VFP_LP_SHIFT, 210),
+	MT6373_LDO("vtp", VTP, ldo_volt_table1,
+		   MT6373_PMIC_RG_LDO_VTP_EN_ADDR, MT6373_PMIC_RG_LDO_VTP_EN_SHIFT,
+		   MT6373_PMIC_RG_VTP_VOSEL_ADDR,
+		   MT6373_PMIC_RG_VTP_VOSEL_MASK,
+		   MT6373_PMIC_RG_VTP_VOCAL_ADDR,
+		   MT6373_PMIC_RG_VTP_VOCAL_MASK,
+		   MT6373_PMIC_RG_LDO_VTP_LP_ADDR,
+		   MT6373_PMIC_RG_LDO_VTP_LP_SHIFT, 720),
+	MT6373_LDO("vmch", VMCH, ldo_volt_table4,
+		   MT6373_PMIC_RG_LDO_VMCH_EN_ADDR, MT6373_PMIC_RG_LDO_VMCH_EN_SHIFT,
+		   MT6373_PMIC_RG_VMCH_VOSEL_ADDR,
+		   MT6373_PMIC_RG_VMCH_VOSEL_MASK,
+		   MT6373_PMIC_RG_VMCH_VOCAL_ADDR,
+		   MT6373_PMIC_RG_VMCH_VOCAL_MASK,
+		   MT6373_PMIC_RG_LDO_VMCH_LP_ADDR,
+		   MT6373_PMIC_RG_LDO_VMCH_LP_SHIFT, 720),
+	MT6373_LDO("vmc", VMC, ldo_volt_table1,
+		   MT6373_PMIC_RG_LDO_VMC_EN_ADDR, MT6373_PMIC_RG_LDO_VMC_EN_SHIFT,
+		   MT6373_PMIC_RG_VMC_VOSEL_ADDR,
+		   MT6373_PMIC_RG_VMC_VOSEL_MASK,
+		   MT6373_PMIC_RG_VMC_VOCAL_ADDR,
+		   MT6373_PMIC_RG_VMC_VOCAL_MASK,
+		   MT6373_PMIC_RG_LDO_VMC_LP_ADDR,
+		   MT6373_PMIC_RG_LDO_VMC_LP_SHIFT, 720),
+	MT6373_LDO("vaud18", VAUD18, ldo_volt_table3,
+		   MT6373_PMIC_RG_LDO_VAUD18_EN_ADDR, MT6373_PMIC_RG_LDO_VAUD18_EN_SHIFT,
+		   MT6373_PMIC_RG_VAUD18_VOSEL_ADDR,
+		   MT6373_PMIC_RG_VAUD18_VOSEL_MASK,
+		   MT6373_PMIC_RG_VAUD18_VOCAL_ADDR,
+		   MT6373_PMIC_RG_VAUD18_VOCAL_MASK,
+		   MT6373_PMIC_RG_LDO_VAUD18_LP_ADDR,
+		   MT6373_PMIC_RG_LDO_VAUD18_LP_SHIFT, 720),
+	MT6373_LDO("vcn33-1", VCN33_1, ldo_volt_table4,
+		   MT6373_PMIC_RG_LDO_VCN33_1_EN_ADDR, MT6373_PMIC_RG_LDO_VCN33_1_EN_SHIFT,
+		   MT6373_PMIC_RG_VCN33_1_VOSEL_ADDR,
+		   MT6373_PMIC_RG_VCN33_1_VOSEL_MASK,
+		   MT6373_PMIC_RG_VCN33_1_VOCAL_ADDR,
+		   MT6373_PMIC_RG_VCN33_1_VOCAL_MASK,
+		   MT6373_PMIC_RG_LDO_VCN33_1_LP_ADDR,
+		   MT6373_PMIC_RG_LDO_VCN33_1_LP_SHIFT, 210),
+	MT6373_LDO("vcn33-2", VCN33_2, ldo_volt_table4,
+		   MT6373_PMIC_RG_LDO_VCN33_2_EN_ADDR, MT6373_PMIC_RG_LDO_VCN33_2_EN_SHIFT,
+		   MT6373_PMIC_RG_VCN33_2_VOSEL_ADDR,
+		   MT6373_PMIC_RG_VCN33_2_VOSEL_MASK,
+		   MT6373_PMIC_RG_VCN33_2_VOCAL_ADDR,
+		   MT6373_PMIC_RG_VCN33_2_VOCAL_MASK,
+		   MT6373_PMIC_RG_LDO_VCN33_2_LP_ADDR,
+		   MT6373_PMIC_RG_LDO_VCN33_2_LP_SHIFT, 210),
+	MT6373_LDO("vcn33-3", VCN33_3, ldo_volt_table4,
+		   MT6373_PMIC_RG_LDO_VCN33_3_EN_ADDR, MT6373_PMIC_RG_LDO_VCN33_3_EN_SHIFT,
+		   MT6373_PMIC_RG_VCN33_3_VOSEL_ADDR,
+		   MT6373_PMIC_RG_VCN33_3_VOSEL_MASK,
+		   MT6373_PMIC_RG_VCN33_3_VOCAL_ADDR,
+		   MT6373_PMIC_RG_VCN33_3_VOCAL_MASK,
+		   MT6373_PMIC_RG_LDO_VCN33_3_LP_ADDR,
+		   MT6373_PMIC_RG_LDO_VCN33_3_LP_SHIFT, 210),
+	MT6373_LDO("vcn18io", VCN18IO, ldo_volt_table3,
+		   MT6373_PMIC_RG_LDO_VCN18IO_EN_ADDR, MT6373_PMIC_RG_LDO_VCN18IO_EN_SHIFT,
+		   MT6373_PMIC_RG_VCN18IO_VOSEL_ADDR,
+		   MT6373_PMIC_RG_VCN18IO_VOSEL_MASK,
+		   MT6373_PMIC_RG_VCN18IO_VOCAL_ADDR,
+		   MT6373_PMIC_RG_VCN18IO_VOCAL_MASK,
+		   MT6373_PMIC_RG_LDO_VCN18IO_LP_ADDR,
+		   MT6373_PMIC_RG_LDO_VCN18IO_LP_SHIFT, 720),
+	MT6373_LDO("vefuse", VEFUSE, ldo_volt_table1,
+		   MT6373_PMIC_RG_LDO_VEFUSE_EN_ADDR, MT6373_PMIC_RG_LDO_VEFUSE_EN_SHIFT,
+		   MT6373_PMIC_RG_VEFUSE_VOSEL_ADDR,
+		   MT6373_PMIC_RG_VEFUSE_VOSEL_MASK,
+		   MT6373_PMIC_RG_VEFUSE_VOCAL_ADDR,
+		   MT6373_PMIC_RG_VEFUSE_VOCAL_MASK,
+		   MT6373_PMIC_RG_LDO_VEFUSE_LP_ADDR,
+		   MT6373_PMIC_RG_LDO_VEFUSE_LP_SHIFT, 720),
+	MT6373_VMCH_EINT("vmch-eint-high", EINT_HIGH, ldo_volt_table4, 720),
+	MT6373_VMCH_EINT("vmch-eint-low", EINT_LOW, ldo_volt_table4, 720),
+};
+
+static void mt6373_oc_irq_enable_work(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct mt6373_regulator_info *info
+		= container_of(dwork, struct mt6373_regulator_info, oc_work);
+
+	enable_irq(info->irq);
+}
+
+static irqreturn_t mt6373_oc_irq(int irq, void *data)
+{
+	struct regulator_dev *rdev = (struct regulator_dev *)data;
+	struct mt6373_regulator_info *info = rdev_get_drvdata(rdev);
+
+	disable_irq_nosync(info->irq);
+	if (!regulator_is_enabled_regmap(rdev))
+		goto delayed_enable;
+	regulator_notifier_call_chain(rdev, REGULATOR_EVENT_OVER_CURRENT,
+				      NULL);
+delayed_enable:
+	schedule_delayed_work(&info->oc_work,
+			      msecs_to_jiffies(info->oc_irq_enable_delay_ms));
+	return IRQ_HANDLED;
+}
+
+static int mt6373_of_parse_cb(struct device_node *np,
+			      const struct regulator_desc *desc,
+			      struct regulator_config *config)
+{
+	int ret;
+	struct mt6373_regulator_info *info = config->driver_data;
+
+	if (info->irq > 0) {
+		ret = of_property_read_u32(np, "mediatek,oc-irq-enable-delay-ms",
+					   &info->oc_irq_enable_delay_ms);
+		if (ret || !info->oc_irq_enable_delay_ms)
+			info->oc_irq_enable_delay_ms = DEFAULT_DELAY_MS;
+		INIT_DELAYED_WORK(&info->oc_work, mt6373_oc_irq_enable_work);
+	}
+	return 0;
+}
+
+static bool mt6373_bypass_register(struct mt6373_regulator_info *info)
+{
+	return info->desc.id == MT6373_ID_VBUCK4_UFS;
+}
+
+static int mt6373_regulator_probe(struct platform_device *pdev)
+{
+	struct regulator_config config = {};
+	struct regulator_dev *rdev;
+	struct mt6373_regulator_info *info;
+	int i, ret;
+	unsigned int val = 0;
+	bool is_mt6373_cw = false;
+
+	config.dev = pdev->dev.parent;
+	config.regmap = dev_get_regmap(pdev->dev.parent, NULL);
+
+	if (!config.regmap) {
+		dev_err(&pdev->dev, "failed to get regmap\n");
+		return -EINVAL;
+	}
+
+	ret = regmap_read(config.regmap, MT6373_PLG_CFG_ELR1, &val);
+	if (ret)
+		dev_notice(&pdev->dev, "failed to read ELR, ret=%d\n", ret);
+	else if ((val & MT6373_ELR_MASK) == 0x4)
+		is_mt6373_cw = true;
+
+	/* MT6373_RG_RSV_SWREG_H for checking 6989p */
+	ret = regmap_read(config.regmap, MT6373_RG_RSV_SWREG_H, &val);
+
+	for (i = 0; i < MT6373_MAX_REGULATOR; i++) {
+		info = &mt6373_regulators[i];
+		info->irq = platform_get_irq_byname_optional(pdev, info->desc.name);
+		config.driver_data = info;
+		if (is_mt6373_cw && mt6373_bypass_register(info))
+			continue;
+		if ((info->desc.id == MT6373_ID_VBUCK4) && (val & 0x1)) {
+			dev_info(&pdev->dev, "skip registering %s\n", info->desc.name);
+			continue;
+		}
+
+		rdev = devm_regulator_register(&pdev->dev, &info->desc, &config);
+		if (IS_ERR(rdev)) {
+			ret = PTR_ERR(rdev);
+			dev_err(&pdev->dev, "failed to register %s, ret=%d\n",
+				info->desc.name, ret);
+			continue;
+		}
+
+		if (info->irq <= 0)
+			continue;
+		ret = devm_request_threaded_irq(&pdev->dev, info->irq, NULL,
+						mt6373_oc_irq,
+						IRQF_TRIGGER_HIGH,
+						info->desc.name,
+						rdev);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to request IRQ:%s, ret=%d",
+				info->desc.name, ret);
+			continue;
+		}
+	}
+
+	return 0;
+}
+
+static void mt6373_regulator_shutdown(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct regmap *regmap;
+	int ret = 0;
+
+	regmap = dev_get_regmap(dev->parent, NULL);
+	if (!regmap) {
+		dev_notice(&pdev->dev, "invalid regmap.\n");
+		return;
+	}
+
+	ret = regmap_write(regmap, MT6373_TOP_CFG_ELR5, 0x1);
+	if (ret < 0) {
+		dev_notice(&pdev->dev, "enable sequence off failed.\n");
+		return;
+	}
+}
+
+static const struct platform_device_id mt6373_regulator_ids[] = {
+	{ "mt6373-regulator", 0},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(platform, mt6373_regulator_ids);
+
+static struct platform_driver mt6373_regulator_driver = {
+	.driver = {
+		.name = "mt6373-regulator",
+	},
+	.probe = mt6373_regulator_probe,
+	.shutdown = mt6373_regulator_shutdown,
+	.id_table = mt6373_regulator_ids,
+};
+module_platform_driver(mt6373_regulator_driver);
+
+MODULE_AUTHOR("Lu Tang <lu.tang@mediatek.com>");
+MODULE_DESCRIPTION("Regulator Driver for MediaTek MT6373 PMIC");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/regulator/mt6316-regulator.h b/include/linux/regulator/mt6316-regulator.h
new file mode 100644
index 000000000000..dd11b3d856fd
--- /dev/null
+++ b/include/linux/regulator/mt6316-regulator.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 MediaTek Inc.
+ */
+
+#ifndef __LINUX_REGULATOR_MT6316_H
+#define __LINUX_REGULATOR_MT6316_H
+
+#define MT6316_SLAVE_ID_3	3
+#define MT6316_SLAVE_ID_6	6
+#define MT6316_SLAVE_ID_7	7
+#define MT6316_SLAVE_ID_8	8
+#define MT6316_SLAVE_ID_15	15
+
+#define MT6316_ID_3_MAX		3
+#define MT6316_ID_6_MAX		3
+#define MT6316_ID_7_MAX		3
+#define MT6316_ID_8_MAX		3
+#define MT6316_ID_15_MAX	2
+
+enum {
+	MT6316_ID_VBUCK1 = 0,
+	MT6316_ID_VBUCK2,
+	MT6316_ID_VBUCK3,
+	MT6316_ID_VBUCK4,
+	MT6316_ID_MAX,
+};
+
+/* Register */
+#define MT6316_TOP_CFG_ELR4			0x143
+#define MT6316_BUCK_TOP_CON0			0x1440
+#define MT6316_BUCK_TOP_CON1			0x1443
+#define MT6316_BUCK_TOP_ELR0			0x1448
+#define MT6316_BUCK_TOP_ELR2			0x144A
+#define MT6316_BUCK_TOP_ELR4			0x144C
+#define MT6316_BUCK_TOP_ELR6			0x144E
+#define MT6316_VBUCK1_DBG4			0x14A4
+#define MT6316_VBUCK1_DBG8			0x14A8
+#define MT6316_VBUCK2_DBG4			0x1524
+#define MT6316_VBUCK2_DBG8			0x1528
+#define MT6316_VBUCK3_DBG4			0x15A4
+#define MT6316_VBUCK3_DBG8			0x15A8
+#define MT6316_VBUCK4_DBG4			0x1624
+#define MT6316_VBUCK4_DBG8			0x1628
+#define MT6316_BUCK_TOP_4PHASE_TOP_ANA_CON0     0x1688
+#define MT6316_BUCK_TOP_4PHASE_TOP_ELR_0	0x1690
+
+#endif /* __LINUX_REGULATOR_MT6316_H */
diff --git a/include/linux/regulator/mt6363-regulator.h b/include/linux/regulator/mt6363-regulator.h
new file mode 100644
index 000000000000..f9c2220ae18c
--- /dev/null
+++ b/include/linux/regulator/mt6363-regulator.h
@@ -0,0 +1,424 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 MediaTek Inc.
+ */
+
+#ifndef __LINUX_REGULATOR_MT6363_H
+#define __LINUX_REGULATOR_MT6363_H
+
+enum {
+	MT6363_ID_VS2,
+	MT6363_ID_VBUCK1,
+	MT6363_ID_VBUCK2,
+	MT6363_ID_VBUCK3,
+	MT6363_ID_VBUCK4,
+	MT6363_ID_VBUCK5,
+	MT6363_ID_VBUCK6,
+	MT6363_ID_VBUCK7,
+	MT6363_ID_VS1,
+	MT6363_ID_VS3,
+	MT6363_ID_VBUCK1_SSHUB,
+	MT6363_ID_VBUCK2_SSHUB,
+	MT6363_ID_VBUCK4_SSHUB,
+	MT6363_ID_VSRAM_DIGRF,
+	MT6363_ID_VSRAM_MDFE,
+	MT6363_ID_VSRAM_MODEM,
+	MT6363_ID_VSRAM_CPUB,
+	MT6363_ID_VSRAM_CPUM,
+	MT6363_ID_VSRAM_CPUL,
+	MT6363_ID_VSRAM_APU,
+	MT6363_ID_VEMC,
+	MT6363_ID_VCN13,
+	MT6363_ID_VTREF18,
+	MT6363_ID_VAUX18,
+	MT6363_ID_VCN15,
+	MT6363_ID_VUFS18,
+	MT6363_ID_VIO18,
+	MT6363_ID_VM18,
+	MT6363_ID_VA15,
+	MT6363_ID_VRF18,
+	MT6363_ID_VRFIO18,
+	MT6363_ID_VIO075,
+	MT6363_ID_VUFS12,
+	MT6363_ID_VA12_1,
+	MT6363_ID_VA12_2,
+	MT6363_ID_VRF12,
+	MT6363_ID_VRF13,
+	MT6363_ID_VRF09,
+	MT6363_ID_ISINK_LOAD,
+	MT6363_MAX_REGULATOR,
+};
+
+#define MTK_REGULATOR_MAX_NR MT6363_MAX_REGULATOR
+
+/* Register */
+#define MT6363_TOP_TRAP                             (0x36)
+#define MT6363_TOP_TMA_KEY_L                        (0x39e)
+#define MT6363_BUCK_TOP_KEY_PROT_LO                 (0x142a)
+#define MT6363_BUCK_VS2_OP_EN_0                     (0x148d)
+#define MT6363_BUCK_VS2_HW_LP_MODE                  (0x1498)
+#define MT6363_BUCK_VBUCK1_OP_EN_0                  (0x150d)
+#define MT6363_BUCK_VBUCK1_HW_LP_MODE               (0x1518)
+#define MT6363_BUCK_VBUCK2_OP_EN_0                  (0x158d)
+#define MT6363_BUCK_VBUCK2_HW_LP_MODE               (0x1598)
+#define MT6363_BUCK_VBUCK3_OP_EN_0                  (0x160d)
+#define MT6363_BUCK_VBUCK3_HW_LP_MODE               (0x1618)
+#define MT6363_BUCK_VBUCK4_OP_EN_0                  (0x168d)
+#define MT6363_BUCK_VBUCK4_HW_LP_MODE               (0x1698)
+#define MT6363_BUCK_VBUCK5_OP_EN_0                  (0x170d)
+#define MT6363_BUCK_VBUCK5_HW_LP_MODE               (0x1718)
+#define MT6363_BUCK_VBUCK6_OP_EN_0                  (0x178d)
+#define MT6363_BUCK_VBUCK6_HW_LP_MODE               (0x1798)
+#define MT6363_BUCK_VBUCK7_OP_EN_0                  (0x180d)
+#define MT6363_BUCK_VBUCK7_HW_LP_MODE               (0x1818)
+#define MT6363_BUCK_VS1_OP_EN_0                     (0x188d)
+#define MT6363_BUCK_VS1_HW_LP_MODE                  (0x1898)
+#define MT6363_BUCK_VS3_OP_EN_0                     (0x190d)
+#define MT6363_BUCK_VS3_HW_LP_MODE                  (0x1918)
+#define MT6363_LDO_VCN15_HW_LP_MODE                 (0x1b8b)
+#define MT6363_LDO_VCN15_OP_EN0                     (0x1b8c)
+#define MT6363_LDO_VRF09_HW_LP_MODE                 (0x1b99)
+#define MT6363_LDO_VRF09_OP_EN0                     (0x1b9a)
+#define MT6363_LDO_VRF12_HW_LP_MODE                 (0x1ba7)
+#define MT6363_LDO_VRF12_OP_EN0                     (0x1ba8)
+#define MT6363_LDO_VRF13_HW_LP_MODE                 (0x1bb5)
+#define MT6363_LDO_VRF13_OP_EN0                     (0x1bb6)
+#define MT6363_LDO_VRF18_HW_LP_MODE                 (0x1bc3)
+#define MT6363_LDO_VRF18_OP_EN0                     (0x1bc4)
+#define MT6363_LDO_VRFIO18_HW_LP_MODE               (0x1bd1)
+#define MT6363_LDO_VRFIO18_OP_EN0                   (0x1bd2)
+#define MT6363_LDO_VTREF18_HW_LP_MODE               (0x1c0b)
+#define MT6363_LDO_VTREF18_OP_EN0                   (0x1c0c)
+#define MT6363_LDO_VAUX18_HW_LP_MODE                (0x1c19)
+#define MT6363_LDO_VAUX18_OP_EN0                    (0x1c1a)
+#define MT6363_LDO_VEMC_HW_LP_MODE                  (0x1c27)
+#define MT6363_LDO_VEMC_OP_EN0                      (0x1c28)
+#define MT6363_LDO_VUFS12_HW_LP_MODE                (0x1c35)
+#define MT6363_LDO_VUFS12_OP_EN0                    (0x1c36)
+#define MT6363_LDO_VUFS18_HW_LP_MODE                (0x1c43)
+#define MT6363_LDO_VUFS18_OP_EN0                    (0x1c44)
+#define MT6363_LDO_VIO18_HW_LP_MODE                 (0x1c51)
+#define MT6363_LDO_VIO18_OP_EN0                     (0x1c52)
+#define MT6363_LDO_VIO075_HW_LP_MODE                (0x1c8b)
+#define MT6363_LDO_VIO075_OP_EN0                    (0x1c8c)
+#define MT6363_LDO_VA12_1_HW_LP_MODE                (0x1c99)
+#define MT6363_LDO_VA12_1_OP_EN0                    (0x1c9a)
+#define MT6363_LDO_VA12_2_HW_LP_MODE                (0x1ca7)
+#define MT6363_LDO_VA12_2_OP_EN0                    (0x1ca8)
+#define MT6363_LDO_VA15_HW_LP_MODE                  (0x1cb5)
+#define MT6363_LDO_VA15_OP_EN0                      (0x1cb6)
+#define MT6363_LDO_VM18_HW_LP_MODE                  (0x1cc3)
+#define MT6363_LDO_VM18_OP_EN0                      (0x1cc4)
+#define MT6363_LDO_VCN13_HW_LP_MODE                 (0x1d0b)
+#define MT6363_LDO_VCN13_OP_EN0                     (0x1d14)
+#define MT6363_LDO_VSRAM_DIGRF_HW_LP_MODE           (0x1d21)
+#define MT6363_LDO_VSRAM_DIGRF_OP_EN0               (0x1d2a)
+#define MT6363_LDO_VSRAM_MDFE_HW_LP_MODE            (0x1d8b)
+#define MT6363_LDO_VSRAM_MDFE_OP_EN0                (0x1d94)
+#define MT6363_LDO_VSRAM_MODEM_HW_LP_MODE           (0x1da6)
+#define MT6363_LDO_VSRAM_MODEM_OP_EN0               (0x1daf)
+#define MT6363_LDO_VSRAM_CPUB_HW_LP_MODE            (0x1e0b)
+#define MT6363_LDO_VSRAM_CPUB_OP_EN0                (0x1e14)
+#define MT6363_LDO_VSRAM_CPUM_HW_LP_MODE            (0x1e21)
+#define MT6363_LDO_VSRAM_CPUM_OP_EN0                (0x1e2a)
+#define MT6363_LDO_VSRAM_CPUL_HW_LP_MODE            (0x1e8b)
+#define MT6363_LDO_VSRAM_CPUL_OP_EN0                (0x1e94)
+#define MT6363_LDO_VSRAM_APU_HW_LP_MODE             (0x1ea1)
+#define MT6363_LDO_VSRAM_APU_OP_EN0                 (0x1eaa)
+#define MT6363_RG_BUCK_VS2_EN_ADDR                  (0x240)
+#define MT6363_RG_BUCK_VS2_EN_SHIFT                 (0)
+#define MT6363_RG_BUCK_VBUCK1_EN_ADDR               (0x240)
+#define MT6363_RG_BUCK_VBUCK1_EN_SHIFT              (1)
+#define MT6363_RG_BUCK_VBUCK2_EN_ADDR               (0x240)
+#define MT6363_RG_BUCK_VBUCK2_EN_SHIFT              (2)
+#define MT6363_RG_BUCK_VBUCK3_EN_ADDR               (0x240)
+#define MT6363_RG_BUCK_VBUCK3_EN_SHIFT              (3)
+#define MT6363_RG_BUCK_VBUCK4_EN_ADDR               (0x240)
+#define MT6363_RG_BUCK_VBUCK4_EN_SHIFT              (4)
+#define MT6363_RG_BUCK_VBUCK5_EN_ADDR               (0x240)
+#define MT6363_RG_BUCK_VBUCK5_EN_SHIFT              (5)
+#define MT6363_RG_BUCK_VBUCK6_EN_ADDR               (0x240)
+#define MT6363_RG_BUCK_VBUCK6_EN_SHIFT              (6)
+#define MT6363_RG_BUCK_VBUCK7_EN_ADDR               (0x240)
+#define MT6363_RG_BUCK_VBUCK7_EN_SHIFT              (7)
+#define MT6363_RG_BUCK_VS1_EN_ADDR                  (0x243)
+#define MT6363_RG_BUCK_VS1_EN_SHIFT                 (0)
+#define MT6363_RG_BUCK_VS3_EN_ADDR                  (0x243)
+#define MT6363_RG_BUCK_VS3_EN_SHIFT                 (1)
+#define MT6363_RG_LDO_VSRAM_DIGRF_EN_ADDR           (0x243)
+#define MT6363_RG_LDO_VSRAM_DIGRF_EN_SHIFT          (4)
+#define MT6363_RG_LDO_VSRAM_MDFE_EN_ADDR            (0x243)
+#define MT6363_RG_LDO_VSRAM_MDFE_EN_SHIFT           (5)
+#define MT6363_RG_LDO_VSRAM_MODEM_EN_ADDR           (0x243)
+#define MT6363_RG_LDO_VSRAM_MODEM_EN_SHIFT          (6)
+#define MT6363_RG_BUCK_VS2_LP_ADDR                  (0x246)
+#define MT6363_RG_BUCK_VS2_LP_SHIFT                 (0)
+#define MT6363_RG_BUCK_VBUCK1_LP_ADDR               (0x246)
+#define MT6363_RG_BUCK_VBUCK1_LP_SHIFT              (1)
+#define MT6363_RG_BUCK_VBUCK2_LP_ADDR               (0x246)
+#define MT6363_RG_BUCK_VBUCK2_LP_SHIFT              (2)
+#define MT6363_RG_BUCK_VBUCK3_LP_ADDR               (0x246)
+#define MT6363_RG_BUCK_VBUCK3_LP_SHIFT              (3)
+#define MT6363_RG_BUCK_VBUCK4_LP_ADDR               (0x246)
+#define MT6363_RG_BUCK_VBUCK4_LP_SHIFT              (4)
+#define MT6363_RG_BUCK_VBUCK5_LP_ADDR               (0x246)
+#define MT6363_RG_BUCK_VBUCK5_LP_SHIFT              (5)
+#define MT6363_RG_BUCK_VBUCK6_LP_ADDR               (0x246)
+#define MT6363_RG_BUCK_VBUCK6_LP_SHIFT              (6)
+#define MT6363_RG_BUCK_VBUCK7_LP_ADDR               (0x246)
+#define MT6363_RG_BUCK_VBUCK7_LP_SHIFT              (7)
+#define MT6363_RG_BUCK_VS1_LP_ADDR                  (0x249)
+#define MT6363_RG_BUCK_VS1_LP_SHIFT                 (0)
+#define MT6363_RG_BUCK_VS3_LP_ADDR                  (0x249)
+#define MT6363_RG_BUCK_VS3_LP_SHIFT                 (1)
+#define MT6363_RG_LDO_VSRAM_DIGRF_LP_ADDR           (0x249)
+#define MT6363_RG_LDO_VSRAM_DIGRF_LP_SHIFT          (4)
+#define MT6363_RG_LDO_VSRAM_MDFE_LP_ADDR            (0x249)
+#define MT6363_RG_LDO_VSRAM_MDFE_LP_SHIFT           (5)
+#define MT6363_RG_LDO_VSRAM_MODEM_LP_ADDR           (0x249)
+#define MT6363_RG_LDO_VSRAM_MODEM_LP_SHIFT          (6)
+#define MT6363_RG_BUCK_VS2_VOSEL_ADDR               (0x24c)
+#define MT6363_RG_BUCK_VS2_VOSEL_MASK               (0xff)
+#define MT6363_RG_BUCK_VBUCK1_VOSEL_ADDR            (0x24d)
+#define MT6363_RG_BUCK_VBUCK1_VOSEL_MASK            (0xff)
+#define MT6363_RG_BUCK_VBUCK2_VOSEL_ADDR            (0x24e)
+#define MT6363_RG_BUCK_VBUCK2_VOSEL_MASK            (0xff)
+#define MT6363_RG_BUCK_VBUCK3_VOSEL_ADDR            (0x24f)
+#define MT6363_RG_BUCK_VBUCK3_VOSEL_MASK            (0xff)
+#define MT6363_RG_BUCK_VBUCK4_VOSEL_ADDR            (0x250)
+#define MT6363_RG_BUCK_VBUCK4_VOSEL_MASK            (0xff)
+#define MT6363_RG_BUCK_VBUCK5_VOSEL_ADDR            (0x251)
+#define MT6363_RG_BUCK_VBUCK5_VOSEL_MASK            (0xff)
+#define MT6363_RG_BUCK_VBUCK6_VOSEL_ADDR            (0x252)
+#define MT6363_RG_BUCK_VBUCK6_VOSEL_MASK            (0xff)
+#define MT6363_RG_BUCK_VBUCK7_VOSEL_ADDR            (0x253)
+#define MT6363_RG_BUCK_VBUCK7_VOSEL_MASK            (0xff)
+#define MT6363_RG_BUCK_VS1_VOSEL_ADDR               (0x254)
+#define MT6363_RG_BUCK_VS1_VOSEL_MASK               (0xff)
+#define MT6363_RG_BUCK_VS3_VOSEL_ADDR               (0x255)
+#define MT6363_RG_BUCK_VS3_VOSEL_MASK               (0xff)
+#define MT6363_RG_LDO_VSRAM_DIGRF_VOSEL_ADDR        (0x258)
+#define MT6363_RG_LDO_VSRAM_DIGRF_VOSEL_MASK        (0x7f)
+#define MT6363_RG_LDO_VSRAM_MDFE_VOSEL_ADDR         (0x259)
+#define MT6363_RG_LDO_VSRAM_MDFE_VOSEL_MASK         (0x7f)
+#define MT6363_RG_LDO_VSRAM_MODEM_VOSEL_ADDR        (0x25a)
+#define MT6363_RG_LDO_VSRAM_MODEM_VOSEL_MASK        (0x7f)
+#define MT6363_BUCK_VS2_WDTDBG_VOSEL_ADDR           (0x142c)
+#define MT6363_BUCK_VBUCK1_WDTDBG_VOSEL_ADDR        (0x142d)
+#define MT6363_BUCK_VBUCK2_WDTDBG_VOSEL_ADDR        (0x142e)
+#define MT6363_BUCK_VBUCK3_WDTDBG_VOSEL_ADDR        (0x142f)
+#define MT6363_BUCK_VBUCK4_WDTDBG_VOSEL_ADDR        (0x1430)
+#define MT6363_BUCK_VBUCK5_WDTDBG_VOSEL_ADDR        (0x1431)
+#define MT6363_BUCK_VBUCK6_WDTDBG_VOSEL_ADDR        (0x1432)
+#define MT6363_BUCK_VBUCK7_WDTDBG_VOSEL_ADDR        (0x1433)
+#define MT6363_BUCK_VS1_WDTDBG_VOSEL_ADDR           (0x1434)
+#define MT6363_BUCK_VS3_WDTDBG_VOSEL_ADDR           (0x1435)
+#define MT6363_RG_BUCK_VBUCK1_SSHUB_EN_ADDR         (0x151a)
+#define MT6363_RG_BUCK_VBUCK1_SSHUB_VOSEL_ADDR      (0x151b)
+#define MT6363_RG_BUCK_VBUCK1_SSHUB_VOSEL_MASK      (0xff)
+#define MT6363_RG_BUCK_VBUCK2_SSHUB_EN_ADDR         (0x159a)
+#define MT6363_RG_BUCK_VBUCK2_SSHUB_VOSEL_ADDR      (0x159b)
+#define MT6363_RG_BUCK_VBUCK2_SSHUB_VOSEL_MASK      (0xff)
+#define MT6363_RG_BUCK_VBUCK4_SSHUB_EN_ADDR         (0x169a)
+#define MT6363_RG_BUCK_VBUCK4_SSHUB_VOSEL_ADDR      (0x169b)
+#define MT6363_RG_BUCK_VBUCK4_SSHUB_VOSEL_MASK      (0xff)
+#define MT6363_RG_VS1_FCCM_ADDR                     (0x1994)
+#define MT6363_RG_VS1_FCCM_SHIFT                    (0)
+#define MT6363_RG_VS3_FCCM_ADDR                     (0x19a3)
+#define MT6363_RG_VS3_FCCM_SHIFT                    (0)
+#define MT6363_RG_VBUCK1_FCCM_ADDR                  (0x1a32)
+#define MT6363_RG_VBUCK1_FCCM_SHIFT                 (0)
+#define MT6363_RG_VBUCK2_FCCM_ADDR                  (0x1a32)
+#define MT6363_RG_VBUCK2_FCCM_SHIFT                 (1)
+#define MT6363_RG_VBUCK3_FCCM_ADDR                  (0x1a32)
+#define MT6363_RG_VBUCK3_FCCM_SHIFT                 (2)
+#define MT6363_RG_VS2_FCCM_ADDR                     (0x1a32)
+#define MT6363_RG_VS2_FCCM_SHIFT                    (3)
+#define MT6363_RG_VBUCK4_FCCM_ADDR                  (0x1ab2)
+#define MT6363_RG_VBUCK4_FCCM_SHIFT                 (0)
+#define MT6363_RG_VBUCK5_FCCM_ADDR                  (0x1ab2)
+#define MT6363_RG_VBUCK5_FCCM_SHIFT                 (1)
+#define MT6363_RG_VBUCK6_FCCM_ADDR                  (0x1ab2)
+#define MT6363_RG_VBUCK6_FCCM_SHIFT                 (2)
+#define MT6363_RG_VBUCK7_FCCM_ADDR                  (0x1ab2)
+#define MT6363_RG_VBUCK7_FCCM_SHIFT                 (3)
+#define MT6363_RG_VCN13_VOSEL_ADDR                  (0x1b3f)
+#define MT6363_RG_VCN13_VOSEL_MASK                  (0xf)
+#define MT6363_RG_VEMC_VOSEL_0_ADDR                 (0x1b40)
+#define MT6363_RG_VEMC_VOSEL_0_MASK                 (0xf)
+#define MT6363_RG_LDO_VSRAM_CPUB_VOSEL_ADDR         (0x1b44)
+#define MT6363_RG_LDO_VSRAM_CPUB_VOSEL_MASK         (0x7f)
+#define MT6363_RG_LDO_VSRAM_CPUM_VOSEL_ADDR         (0x1b45)
+#define MT6363_RG_LDO_VSRAM_CPUM_VOSEL_MASK         (0x7f)
+#define MT6363_RG_LDO_VSRAM_CPUL_VOSEL_ADDR         (0x1b46)
+#define MT6363_RG_LDO_VSRAM_CPUL_VOSEL_MASK         (0x7f)
+#define MT6363_RG_LDO_VSRAM_APU_VOSEL_ADDR          (0x1b47)
+#define MT6363_RG_LDO_VSRAM_APU_VOSEL_MASK          (0x7f)
+#define MT6363_RG_VEMC_VOCAL_0_ADDR                 (0x1b4b)
+#define MT6363_RG_VEMC_VOCAL_0_MASK                 (0xf)
+#define MT6363_RG_LDO_VCN15_EN_ADDR                 (0x1b87)
+#define MT6363_RG_LDO_VCN15_EN_SHIFT                (0)
+#define MT6363_RG_LDO_VCN15_LP_ADDR                 (0x1b87)
+#define MT6363_RG_LDO_VCN15_LP_SHIFT                (1)
+#define MT6363_RG_LDO_VRF09_EN_ADDR                 (0x1b95)
+#define MT6363_RG_LDO_VRF09_EN_SHIFT                (0)
+#define MT6363_RG_LDO_VRF09_LP_ADDR                 (0x1b95)
+#define MT6363_RG_LDO_VRF09_LP_SHIFT                (1)
+#define MT6363_RG_LDO_VRF12_EN_ADDR                 (0x1ba3)
+#define MT6363_RG_LDO_VRF12_EN_SHIFT                (0)
+#define MT6363_RG_LDO_VRF12_LP_ADDR                 (0x1ba3)
+#define MT6363_RG_LDO_VRF12_LP_SHIFT                (1)
+#define MT6363_RG_LDO_VRF13_EN_ADDR                 (0x1bb1)
+#define MT6363_RG_LDO_VRF13_EN_SHIFT                (0)
+#define MT6363_RG_LDO_VRF13_LP_ADDR                 (0x1bb1)
+#define MT6363_RG_LDO_VRF13_LP_SHIFT                (1)
+#define MT6363_RG_LDO_VRF18_EN_ADDR                 (0x1bbf)
+#define MT6363_RG_LDO_VRF18_EN_SHIFT                (0)
+#define MT6363_RG_LDO_VRF18_LP_ADDR                 (0x1bbf)
+#define MT6363_RG_LDO_VRF18_LP_SHIFT                (1)
+#define MT6363_RG_LDO_VRFIO18_EN_ADDR               (0x1bcd)
+#define MT6363_RG_LDO_VRFIO18_EN_SHIFT              (0)
+#define MT6363_RG_LDO_VRFIO18_LP_ADDR               (0x1bcd)
+#define MT6363_RG_LDO_VRFIO18_LP_SHIFT              (1)
+#define MT6363_RG_LDO_VTREF18_EN_ADDR               (0x1c07)
+#define MT6363_RG_LDO_VTREF18_EN_SHIFT              (0)
+#define MT6363_RG_LDO_VTREF18_LP_ADDR               (0x1c07)
+#define MT6363_RG_LDO_VTREF18_LP_SHIFT              (1)
+#define MT6363_RG_LDO_VAUX18_EN_ADDR                (0x1c15)
+#define MT6363_RG_LDO_VAUX18_EN_SHIFT               (0)
+#define MT6363_RG_LDO_VAUX18_LP_ADDR                (0x1c15)
+#define MT6363_RG_LDO_VAUX18_LP_SHIFT               (1)
+#define MT6363_RG_LDO_VEMC_EN_ADDR                  (0x1c23)
+#define MT6363_RG_LDO_VEMC_EN_SHIFT                 (0)
+#define MT6363_RG_LDO_VEMC_LP_ADDR                  (0x1c23)
+#define MT6363_RG_LDO_VEMC_LP_SHIFT                 (1)
+#define MT6363_RG_LDO_VUFS12_EN_ADDR                (0x1c31)
+#define MT6363_RG_LDO_VUFS12_EN_SHIFT               (0)
+#define MT6363_RG_LDO_VUFS12_LP_ADDR                (0x1c31)
+#define MT6363_RG_LDO_VUFS12_LP_SHIFT               (1)
+#define MT6363_RG_LDO_VUFS18_EN_ADDR                (0x1c3f)
+#define MT6363_RG_LDO_VUFS18_EN_SHIFT               (0)
+#define MT6363_RG_LDO_VUFS18_LP_ADDR                (0x1c3f)
+#define MT6363_RG_LDO_VUFS18_LP_SHIFT               (1)
+#define MT6363_RG_LDO_VIO18_EN_ADDR                 (0x1c4d)
+#define MT6363_RG_LDO_VIO18_EN_SHIFT                (0)
+#define MT6363_RG_LDO_VIO18_LP_ADDR                 (0x1c4d)
+#define MT6363_RG_LDO_VIO18_LP_SHIFT                (1)
+#define MT6363_RG_LDO_VIO075_EN_ADDR                (0x1c87)
+#define MT6363_RG_LDO_VIO075_EN_SHIFT               (0)
+#define MT6363_RG_LDO_VIO075_LP_ADDR                (0x1c87)
+#define MT6363_RG_LDO_VIO075_LP_SHIFT               (1)
+#define MT6363_RG_LDO_VA12_1_EN_ADDR                (0x1c95)
+#define MT6363_RG_LDO_VA12_1_EN_SHIFT               (0)
+#define MT6363_RG_LDO_VA12_1_LP_ADDR                (0x1c95)
+#define MT6363_RG_LDO_VA12_1_LP_SHIFT               (1)
+#define MT6363_RG_LDO_VA12_2_EN_ADDR                (0x1ca3)
+#define MT6363_RG_LDO_VA12_2_EN_SHIFT               (0)
+#define MT6363_RG_LDO_VA12_2_LP_ADDR                (0x1ca3)
+#define MT6363_RG_LDO_VA12_2_LP_SHIFT               (1)
+#define MT6363_RG_LDO_VA15_EN_ADDR                  (0x1cb1)
+#define MT6363_RG_LDO_VA15_EN_SHIFT                 (0)
+#define MT6363_RG_LDO_VA15_LP_ADDR                  (0x1cb1)
+#define MT6363_RG_LDO_VA15_LP_SHIFT                 (1)
+#define MT6363_RG_LDO_VM18_EN_ADDR                  (0x1cbf)
+#define MT6363_RG_LDO_VM18_EN_SHIFT                 (0)
+#define MT6363_RG_LDO_VM18_LP_ADDR                  (0x1cbf)
+#define MT6363_RG_LDO_VM18_LP_SHIFT                 (1)
+#define MT6363_RG_LDO_VCN13_EN_ADDR                 (0x1d07)
+#define MT6363_RG_LDO_VCN13_EN_SHIFT                (0)
+#define MT6363_RG_LDO_VCN13_LP_ADDR                 (0x1d07)
+#define MT6363_RG_LDO_VCN13_LP_SHIFT                (1)
+#define MT6363_LDO_VSRAM_DIGRF_WDTDBG_VOSEL_ADDR    (0x1d24)
+#define MT6363_LDO_VSRAM_MDFE_WDTDBG_VOSEL_ADDR     (0x1d8e)
+#define MT6363_LDO_VSRAM_MODEM_WDTDBG_VOSEL_ADDR    (0x1da9)
+#define MT6363_RG_LDO_VSRAM_CPUB_EN_ADDR            (0x1e07)
+#define MT6363_RG_LDO_VSRAM_CPUB_EN_SHIFT           (0)
+#define MT6363_RG_LDO_VSRAM_CPUB_LP_ADDR            (0x1e07)
+#define MT6363_RG_LDO_VSRAM_CPUB_LP_SHIFT           (1)
+#define MT6363_LDO_VSRAM_CPUB_WDTDBG_VOSEL_ADDR     (0x1e0e)
+#define MT6363_RG_LDO_VSRAM_CPUM_EN_ADDR            (0x1e1d)
+#define MT6363_RG_LDO_VSRAM_CPUM_EN_SHIFT           (0)
+#define MT6363_RG_LDO_VSRAM_CPUM_LP_ADDR            (0x1e1d)
+#define MT6363_RG_LDO_VSRAM_CPUM_LP_SHIFT           (1)
+#define MT6363_LDO_VSRAM_CPUM_WDTDBG_VOSEL_ADDR     (0x1e24)
+#define MT6363_RG_LDO_VSRAM_CPUL_EN_ADDR            (0x1e87)
+#define MT6363_RG_LDO_VSRAM_CPUL_EN_SHIFT           (0)
+#define MT6363_RG_LDO_VSRAM_CPUL_LP_ADDR            (0x1e87)
+#define MT6363_RG_LDO_VSRAM_CPUL_LP_SHIFT           (1)
+#define MT6363_LDO_VSRAM_CPUL_WDTDBG_VOSEL_ADDR     (0x1e8e)
+#define MT6363_RG_LDO_VSRAM_APU_EN_ADDR             (0x1e9d)
+#define MT6363_RG_LDO_VSRAM_APU_EN_SHIFT            (0)
+#define MT6363_RG_LDO_VSRAM_APU_LP_ADDR             (0x1e9d)
+#define MT6363_RG_LDO_VSRAM_APU_LP_SHIFT            (1)
+#define MT6363_LDO_VSRAM_APU_WDTDBG_VOSEL_ADDR      (0x1ea4)
+#define MT6363_RG_VTREF18_VOCAL_ADDR                (0x1f08)
+#define MT6363_RG_VTREF18_VOCAL_MASK                (0xf)
+#define MT6363_RG_VTREF18_VOSEL_ADDR                (0x1f09)
+#define MT6363_RG_VTREF18_VOSEL_MASK                (0xf)
+#define MT6363_RG_VAUX18_VOCAL_ADDR                 (0x1f0c)
+#define MT6363_RG_VAUX18_VOCAL_MASK                 (0xf)
+#define MT6363_RG_VAUX18_VOSEL_ADDR                 (0x1f0d)
+#define MT6363_RG_VAUX18_VOSEL_MASK                 (0xf)
+#define MT6363_RG_VCN15_VOCAL_ADDR                  (0x1f13)
+#define MT6363_RG_VCN15_VOCAL_MASK                  (0xf)
+#define MT6363_RG_VCN15_VOSEL_ADDR                  (0x1f14)
+#define MT6363_RG_VCN15_VOSEL_MASK                  (0xf)
+#define MT6363_RG_VUFS18_VOCAL_ADDR                 (0x1f17)
+#define MT6363_RG_VUFS18_VOCAL_MASK                 (0xf)
+#define MT6363_RG_VUFS18_VOSEL_ADDR                 (0x1f18)
+#define MT6363_RG_VUFS18_VOSEL_MASK                 (0xf)
+#define MT6363_RG_VIO18_VOCAL_ADDR                  (0x1f1b)
+#define MT6363_RG_VIO18_VOCAL_MASK                  (0xf)
+#define MT6363_RG_VIO18_VOSEL_ADDR                  (0x1f1c)
+#define MT6363_RG_VIO18_VOSEL_MASK                  (0xf)
+#define MT6363_RG_VM18_VOCAL_ADDR                   (0x1f1f)
+#define MT6363_RG_VM18_VOCAL_MASK                   (0xf)
+#define MT6363_RG_VM18_VOSEL_ADDR                   (0x1f20)
+#define MT6363_RG_VM18_VOSEL_MASK                   (0xf)
+#define MT6363_RG_VA15_VOCAL_ADDR                   (0x1f23)
+#define MT6363_RG_VA15_VOCAL_MASK                   (0xf)
+#define MT6363_RG_VA15_VOSEL_ADDR                   (0x1f24)
+#define MT6363_RG_VA15_VOSEL_MASK                   (0xf)
+#define MT6363_RG_VRF18_VOCAL_ADDR                  (0x1f27)
+#define MT6363_RG_VRF18_VOCAL_MASK                  (0xf)
+#define MT6363_RG_VRF18_VOSEL_ADDR                  (0x1f28)
+#define MT6363_RG_VRF18_VOSEL_MASK                  (0xf)
+#define MT6363_RG_VRFIO18_VOCAL_ADDR                (0x1f2b)
+#define MT6363_RG_VRFIO18_VOCAL_MASK                (0xf)
+#define MT6363_RG_VRFIO18_VOSEL_ADDR                (0x1f2c)
+#define MT6363_RG_VRFIO18_VOSEL_MASK                (0xf)
+#define MT6363_RG_VIO075_VOCAL_ADDR                 (0x1f31)
+#define MT6363_RG_VIO075_VOCAL_MASK                 (0xf)
+#define MT6363_RG_VIO075_VOSEL_ADDR                 (0x1f31)
+#define MT6363_RG_VIO075_VOSEL_MASK                 (0x70)
+#define MT6363_RG_VCN13_VOCAL_ADDR                  (0x1f88)
+#define MT6363_RG_VCN13_VOCAL_MASK                  (0xf)
+#define MT6363_RG_VUFS12_VOCAL_ADDR                 (0x1f91)
+#define MT6363_RG_VUFS12_VOCAL_MASK                 (0xf)
+#define MT6363_RG_VUFS12_VOSEL_ADDR                 (0x1f92)
+#define MT6363_RG_VUFS12_VOSEL_MASK                 (0xf)
+#define MT6363_RG_VA12_1_VOCAL_ADDR                 (0x1f95)
+#define MT6363_RG_VA12_1_VOCAL_MASK                 (0xf)
+#define MT6363_RG_VA12_1_VOSEL_ADDR                 (0x1f96)
+#define MT6363_RG_VA12_1_VOSEL_MASK                 (0xf)
+#define MT6363_RG_VA12_2_VOCAL_ADDR                 (0x1f99)
+#define MT6363_RG_VA12_2_VOCAL_MASK                 (0xf)
+#define MT6363_RG_VA12_2_VOSEL_ADDR                 (0x1f9a)
+#define MT6363_RG_VA12_2_VOSEL_MASK                 (0xf)
+#define MT6363_RG_VRF12_VOCAL_ADDR                  (0x1f9d)
+#define MT6363_RG_VRF12_VOCAL_MASK                  (0xf)
+#define MT6363_RG_VRF12_VOSEL_ADDR                  (0x1f9e)
+#define MT6363_RG_VRF12_VOSEL_MASK                  (0xf)
+#define MT6363_RG_VRF13_VOCAL_ADDR                  (0x1fa1)
+#define MT6363_RG_VRF13_VOCAL_MASK                  (0xf)
+#define MT6363_RG_VRF13_VOSEL_ADDR                  (0x1fa2)
+#define MT6363_RG_VRF13_VOSEL_MASK                  (0xf)
+#define MT6363_RG_VRF09_VOCAL_ADDR                  (0x1fa8)
+#define MT6363_RG_VRF09_VOCAL_MASK                  (0xf)
+#define MT6363_RG_VRF09_VOSEL_ADDR                  (0x1fa9)
+#define MT6363_RG_VRF09_VOSEL_MASK                  (0xf)
+#define MT6363_ISINK_EN_CTRL0                       (0x220b)
+#define MT6363_ISINK_EN_CTRL1                       (0x220c)
+
+
+#endif /* __LINUX_REGULATOR_MT6363_H */
diff --git a/include/linux/regulator/mt6373-regulator.h b/include/linux/regulator/mt6373-regulator.h
new file mode 100644
index 000000000000..9aa38741c31a
--- /dev/null
+++ b/include/linux/regulator/mt6373-regulator.h
@@ -0,0 +1,318 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2024 MediaTek Inc.
+ */
+
+#ifndef __LINUX_REGULATOR_MT6373_H
+#define __LINUX_REGULATOR_MT6373_H
+
+enum {
+	MT6373_ID_VBUCK0,
+	MT6373_ID_VBUCK1,
+	MT6373_ID_VBUCK2,
+	MT6373_ID_VBUCK3,
+	MT6373_ID_VBUCK4,
+	MT6373_ID_VBUCK4_UFS,
+	MT6373_ID_VBUCK5,
+	MT6373_ID_VBUCK6,
+	MT6373_ID_VBUCK7,
+	MT6373_ID_VBUCK8,
+	MT6373_ID_VBUCK9,
+	MT6373_ID_VUSB,
+	MT6373_ID_VAUX18,
+	MT6373_ID_VRF13_AIF,
+	MT6373_ID_VRF18_AIF,
+	MT6373_ID_VRFIO18_AIF,
+	MT6373_ID_VRF09_AIF,
+	MT6373_ID_VRF12_AIF,
+	MT6373_ID_VANT18,
+	MT6373_ID_VSRAM_DIGRF_AIF,
+	MT6373_ID_VIBR,
+	MT6373_ID_VIO28,
+	MT6373_ID_VFP,
+	MT6373_ID_VTP,
+	MT6373_ID_VMCH,
+	MT6373_ID_VMC,
+	MT6373_ID_VAUD18,
+	MT6373_ID_VCN33_1,
+	MT6373_ID_VCN33_2,
+	MT6373_ID_VCN33_3,
+	MT6373_ID_VCN18IO,
+	MT6373_ID_VEFUSE,
+	MT6373_ID_VMCH_EINT_HIGH,
+	MT6373_ID_VMCH_EINT_LOW,
+	MT6373_MAX_REGULATOR,
+};
+
+/* Register */
+#define MT6373_BUCK_TOP_KEY_PROT_LO                 0x142a
+#define MT6373_TOP_CFG_ELR5                         0x147
+#define MT6373_PMIC_RG_BUCK_VBUCK0_EN_ADDR          0x240
+#define MT6373_PMIC_RG_BUCK_VBUCK0_EN_SHIFT         0
+#define MT6373_PMIC_RG_BUCK_VBUCK1_EN_ADDR          0x240
+#define MT6373_PMIC_RG_BUCK_VBUCK1_EN_SHIFT         1
+#define MT6373_PMIC_RG_BUCK_VBUCK2_EN_ADDR          0x240
+#define MT6373_PMIC_RG_BUCK_VBUCK2_EN_SHIFT         2
+#define MT6373_PMIC_RG_BUCK_VBUCK3_EN_ADDR          0x240
+#define MT6373_PMIC_RG_BUCK_VBUCK3_EN_SHIFT         3
+#define MT6373_PMIC_RG_BUCK_VBUCK4_EN_ADDR          0x240
+#define MT6373_PMIC_RG_BUCK_VBUCK4_EN_SHIFT         4
+#define MT6373_PMIC_RG_BUCK_VBUCK5_EN_ADDR          0x240
+#define MT6373_PMIC_RG_BUCK_VBUCK5_EN_SHIFT         5
+#define MT6373_PMIC_RG_BUCK_VBUCK6_EN_ADDR          0x240
+#define MT6373_PMIC_RG_BUCK_VBUCK6_EN_SHIFT         6
+#define MT6373_PMIC_RG_BUCK_VBUCK7_EN_ADDR          0x240
+#define MT6373_PMIC_RG_BUCK_VBUCK7_EN_SHIFT         7
+#define MT6373_PMIC_RG_BUCK_VBUCK8_EN_ADDR          0x243
+#define MT6373_PMIC_RG_BUCK_VBUCK8_EN_SHIFT         0
+#define MT6373_PMIC_RG_BUCK_VBUCK9_EN_ADDR          0x243
+#define MT6373_PMIC_RG_BUCK_VBUCK9_EN_SHIFT         1
+#define MT6373_PMIC_RG_BUCK_VBUCK0_LP_ADDR          0x246
+#define MT6373_PMIC_RG_BUCK_VBUCK0_LP_SHIFT         0
+#define MT6373_PMIC_RG_BUCK_VBUCK1_LP_ADDR          0x246
+#define MT6373_PMIC_RG_BUCK_VBUCK1_LP_SHIFT         1
+#define MT6373_PMIC_RG_BUCK_VBUCK2_LP_ADDR          0x246
+#define MT6373_PMIC_RG_BUCK_VBUCK2_LP_SHIFT         2
+#define MT6373_PMIC_RG_BUCK_VBUCK3_LP_ADDR          0x246
+#define MT6373_PMIC_RG_BUCK_VBUCK3_LP_SHIFT         3
+#define MT6373_PMIC_RG_BUCK_VBUCK4_LP_ADDR          0x246
+#define MT6373_PMIC_RG_BUCK_VBUCK4_LP_SHIFT         4
+#define MT6373_PMIC_RG_BUCK_VBUCK5_LP_ADDR          0x246
+#define MT6373_PMIC_RG_BUCK_VBUCK5_LP_SHIFT         5
+#define MT6373_PMIC_RG_BUCK_VBUCK6_LP_ADDR          0x246
+#define MT6373_PMIC_RG_BUCK_VBUCK6_LP_SHIFT         6
+#define MT6373_PMIC_RG_BUCK_VBUCK7_LP_ADDR          0x246
+#define MT6373_PMIC_RG_BUCK_VBUCK7_LP_SHIFT         7
+#define MT6373_PMIC_RG_BUCK_VBUCK8_LP_ADDR          0x249
+#define MT6373_PMIC_RG_BUCK_VBUCK8_LP_SHIFT         0
+#define MT6373_PMIC_RG_BUCK_VBUCK9_LP_ADDR          0x249
+#define MT6373_PMIC_RG_BUCK_VBUCK9_LP_SHIFT         1
+#define MT6373_PMIC_RG_BUCK_VBUCK0_VOSEL_ADDR       0x24c
+#define MT6373_PMIC_RG_BUCK_VBUCK0_VOSEL_MASK       0xFF
+#define MT6373_PMIC_RG_BUCK_VBUCK1_VOSEL_ADDR       0x24d
+#define MT6373_PMIC_RG_BUCK_VBUCK1_VOSEL_MASK       0xFF
+#define MT6373_PMIC_RG_BUCK_VBUCK2_VOSEL_ADDR       0x24e
+#define MT6373_PMIC_RG_BUCK_VBUCK2_VOSEL_MASK       0xFF
+#define MT6373_PMIC_RG_BUCK_VBUCK3_VOSEL_ADDR       0x24f
+#define MT6373_PMIC_RG_BUCK_VBUCK3_VOSEL_MASK       0xFF
+#define MT6373_PMIC_RG_BUCK_VBUCK4_VOSEL_ADDR       0x250
+#define MT6373_PMIC_RG_BUCK_VBUCK4_VOSEL_MASK       0xFF
+#define MT6373_PMIC_RG_BUCK_VBUCK5_VOSEL_ADDR       0x251
+#define MT6373_PMIC_RG_BUCK_VBUCK5_VOSEL_MASK       0xFF
+#define MT6373_PMIC_RG_BUCK_VBUCK6_VOSEL_ADDR       0x252
+#define MT6373_PMIC_RG_BUCK_VBUCK6_VOSEL_MASK       0xFF
+#define MT6373_PMIC_RG_BUCK_VBUCK7_VOSEL_ADDR       0x253
+#define MT6373_PMIC_RG_BUCK_VBUCK7_VOSEL_MASK       0xFF
+#define MT6373_PMIC_RG_BUCK_VBUCK8_VOSEL_ADDR       0x254
+#define MT6373_PMIC_RG_BUCK_VBUCK8_VOSEL_MASK       0xFF
+#define MT6373_PMIC_RG_BUCK_VBUCK9_VOSEL_ADDR       0x255
+#define MT6373_PMIC_RG_BUCK_VBUCK9_VOSEL_MASK       0xFF
+#define MT6373_PMIC_RG_VBUCK8_FCCM_ADDR             0x199d
+#define MT6373_PMIC_RG_VBUCK8_FCCM_SHIFT            6
+#define MT6373_PMIC_RG_VBUCK9_FCCM_ADDR             0x199d
+#define MT6373_PMIC_RG_VBUCK9_FCCM_SHIFT            7
+#define MT6373_PMIC_RG_VBUCK0_FCCM_ADDR             0x1a32
+#define MT6373_PMIC_RG_VBUCK0_FCCM_SHIFT            0
+#define MT6373_PMIC_RG_VBUCK1_FCCM_ADDR             0x1a32
+#define MT6373_PMIC_RG_VBUCK1_FCCM_SHIFT            1
+#define MT6373_PMIC_RG_VBUCK2_FCCM_ADDR             0x1a32
+#define MT6373_PMIC_RG_VBUCK2_FCCM_SHIFT            2
+#define MT6373_PMIC_RG_VBUCK3_FCCM_ADDR             0x1a32
+#define MT6373_PMIC_RG_VBUCK3_FCCM_SHIFT            3
+#define MT6373_PMIC_RG_VBUCK4_FCCM_ADDR             0x1ab2
+#define MT6373_PMIC_RG_VBUCK4_FCCM_SHIFT            0
+#define MT6373_PMIC_RG_VBUCK5_FCCM_ADDR             0x1ab2
+#define MT6373_PMIC_RG_VBUCK5_FCCM_SHIFT            1
+#define MT6373_PMIC_RG_VBUCK6_FCCM_ADDR             0x1ab2
+#define MT6373_PMIC_RG_VBUCK6_FCCM_SHIFT            2
+#define MT6373_PMIC_RG_VBUCK7_FCCM_ADDR             0x1ab2
+#define MT6373_PMIC_RG_VBUCK7_FCCM_SHIFT            3
+#define MT6373_PMIC_RG_LDO_VSRAM_DIGRF_AIF_VOSEL_ADDR 0x1b39
+#define MT6373_PMIC_RG_LDO_VSRAM_DIGRF_AIF_VOSEL_MASK 0x7F
+#define MT6373_PMIC_RG_LDO_VAUD18_EN_ADDR           0x1b87
+#define MT6373_PMIC_RG_LDO_VAUD18_EN_SHIFT          0
+#define MT6373_PMIC_RG_LDO_VAUD18_LP_ADDR           0x1b87
+#define MT6373_PMIC_RG_LDO_VAUD18_LP_SHIFT          1
+#define MT6373_PMIC_RG_LDO_VUSB_EN_ADDR             0x1b95
+#define MT6373_PMIC_RG_LDO_VUSB_EN_SHIFT            0
+#define MT6373_PMIC_RG_LDO_VUSB_LP_ADDR             0x1b95
+#define MT6373_PMIC_RG_LDO_VUSB_LP_SHIFT            1
+#define MT6373_PMIC_RG_LDO_VAUX18_EN_ADDR           0x1ba3
+#define MT6373_PMIC_RG_LDO_VAUX18_EN_SHIFT          0
+#define MT6373_PMIC_RG_LDO_VAUX18_LP_ADDR           0x1ba3
+#define MT6373_PMIC_RG_LDO_VAUX18_LP_SHIFT          1
+#define MT6373_PMIC_RG_LDO_VRF13_AIF_EN_ADDR        0x1bb1
+#define MT6373_PMIC_RG_LDO_VRF13_AIF_EN_SHIFT       0
+#define MT6373_PMIC_RG_LDO_VRF13_AIF_LP_ADDR        0x1bb1
+#define MT6373_PMIC_RG_LDO_VRF13_AIF_LP_SHIFT       1
+#define MT6373_PMIC_RG_LDO_VRF18_AIF_EN_ADDR        0x1bbf
+#define MT6373_PMIC_RG_LDO_VRF18_AIF_EN_SHIFT       0
+#define MT6373_PMIC_RG_LDO_VRF18_AIF_LP_ADDR        0x1bbf
+#define MT6373_PMIC_RG_LDO_VRF18_AIF_LP_SHIFT       1
+#define MT6373_PMIC_RG_LDO_VRFIO18_AIF_EN_ADDR      0x1bcd
+#define MT6373_PMIC_RG_LDO_VRFIO18_AIF_EN_SHIFT     0
+#define MT6373_PMIC_RG_LDO_VRFIO18_AIF_LP_ADDR      0x1bcd
+#define MT6373_PMIC_RG_LDO_VRFIO18_AIF_LP_SHIFT     1
+#define MT6373_PMIC_RG_LDO_VCN33_1_EN_ADDR          0x1c07
+#define MT6373_PMIC_RG_LDO_VCN33_1_EN_SHIFT         0
+#define MT6373_PMIC_RG_LDO_VCN33_1_LP_ADDR          0x1c07
+#define MT6373_PMIC_RG_LDO_VCN33_1_LP_SHIFT         1
+#define MT6373_PMIC_RG_LDO_VCN33_2_EN_ADDR          0x1c15
+#define MT6373_PMIC_RG_LDO_VCN33_2_EN_SHIFT         0
+#define MT6373_PMIC_RG_LDO_VCN33_2_LP_ADDR          0x1c15
+#define MT6373_PMIC_RG_LDO_VCN33_2_LP_SHIFT         1
+#define MT6373_PMIC_RG_LDO_VCN33_3_EN_ADDR          0x1c23
+#define MT6373_PMIC_RG_LDO_VCN33_3_EN_SHIFT         0
+#define MT6373_PMIC_RG_LDO_VCN33_3_LP_ADDR          0x1c23
+#define MT6373_PMIC_RG_LDO_VCN33_3_LP_SHIFT         1
+#define MT6373_PMIC_RG_LDO_VCN18IO_EN_ADDR          0x1c31
+#define MT6373_PMIC_RG_LDO_VCN18IO_EN_SHIFT         0
+#define MT6373_PMIC_RG_LDO_VCN18IO_LP_ADDR          0x1c31
+#define MT6373_PMIC_RG_LDO_VCN18IO_LP_SHIFT         1
+#define MT6373_PMIC_RG_LDO_VRF09_AIF_EN_ADDR        0x1c3f
+#define MT6373_PMIC_RG_LDO_VRF09_AIF_EN_SHIFT       0
+#define MT6373_PMIC_RG_LDO_VRF09_AIF_LP_ADDR        0x1c3f
+#define MT6373_PMIC_RG_LDO_VRF09_AIF_LP_SHIFT       1
+#define MT6373_PMIC_RG_LDO_VRF12_AIF_EN_ADDR        0x1c4d
+#define MT6373_PMIC_RG_LDO_VRF12_AIF_EN_SHIFT       0
+#define MT6373_PMIC_RG_LDO_VRF12_AIF_LP_ADDR        0x1c4d
+#define MT6373_PMIC_RG_LDO_VRF12_AIF_LP_SHIFT       1
+#define MT6373_PMIC_RG_LDO_VANT18_EN_ADDR           0x1c87
+#define MT6373_PMIC_RG_LDO_VANT18_EN_SHIFT          0
+#define MT6373_PMIC_RG_LDO_VANT18_LP_ADDR           0x1c87
+#define MT6373_PMIC_RG_LDO_VANT18_LP_SHIFT          1
+#define MT6373_PMIC_RG_LDO_VEFUSE_EN_ADDR           0x1ca3
+#define MT6373_PMIC_RG_LDO_VEFUSE_EN_SHIFT          0
+#define MT6373_PMIC_RG_LDO_VEFUSE_LP_ADDR           0x1ca3
+#define MT6373_PMIC_RG_LDO_VEFUSE_LP_SHIFT          1
+#define MT6373_PMIC_RG_LDO_VMCH_EN_ADDR             0x1cb1
+#define MT6373_PMIC_RG_LDO_VMCH_EN_SHIFT            0
+#define MT6373_PMIC_RG_LDO_VMCH_LP_ADDR             0x1cb1
+#define MT6373_PMIC_RG_LDO_VMCH_LP_SHIFT            1
+#define MT6373_PMIC_RG_LDO_VMC_EN_ADDR              0x1cc0
+#define MT6373_PMIC_RG_LDO_VMC_EN_SHIFT             0
+#define MT6373_PMIC_RG_LDO_VMC_LP_ADDR              0x1cc0
+#define MT6373_PMIC_RG_LDO_VMC_LP_SHIFT             1
+#define MT6373_PMIC_RG_LDO_VIBR_EN_ADDR             0x1cce
+#define MT6373_PMIC_RG_LDO_VIBR_EN_SHIFT            0
+#define MT6373_PMIC_RG_LDO_VIBR_LP_ADDR             0x1cce
+#define MT6373_PMIC_RG_LDO_VIBR_LP_SHIFT            1
+#define MT6373_PMIC_RG_LDO_VIO28_EN_ADDR            0x1d07
+#define MT6373_PMIC_RG_LDO_VIO28_EN_SHIFT           0
+#define MT6373_PMIC_RG_LDO_VIO28_LP_ADDR            0x1d07
+#define MT6373_PMIC_RG_LDO_VIO28_LP_SHIFT           1
+#define MT6373_PMIC_RG_LDO_VFP_EN_ADDR              0x1d15
+#define MT6373_PMIC_RG_LDO_VFP_EN_SHIFT             0
+#define MT6373_PMIC_RG_LDO_VFP_LP_ADDR              0x1d15
+#define MT6373_PMIC_RG_LDO_VFP_LP_SHIFT             1
+#define MT6373_PMIC_RG_LDO_VTP_EN_ADDR              0x1d23
+#define MT6373_PMIC_RG_LDO_VTP_EN_SHIFT             0
+#define MT6373_PMIC_RG_LDO_VTP_LP_ADDR              0x1d23
+#define MT6373_PMIC_RG_LDO_VTP_LP_SHIFT             1
+#define MT6373_PMIC_RG_LDO_VSIM1_EN_ADDR            0x1d31
+#define MT6373_PMIC_RG_LDO_VSIM1_EN_SHIFT           0
+#define MT6373_PMIC_RG_LDO_VSIM1_LP_ADDR            0x1d31
+#define MT6373_PMIC_RG_LDO_VSIM1_LP_SHIFT           1
+#define MT6373_PMIC_RG_LDO_VSIM2_EN_ADDR            0x1d40
+#define MT6373_PMIC_RG_LDO_VSIM2_EN_SHIFT           0
+#define MT6373_PMIC_RG_LDO_VSIM2_LP_ADDR            0x1d40
+#define MT6373_PMIC_RG_LDO_VSIM2_LP_SHIFT           1
+#define MT6373_PMIC_RG_LDO_VSRAM_DIGRF_AIF_EN_ADDR  0x1d87
+#define MT6373_PMIC_RG_LDO_VSRAM_DIGRF_AIF_EN_SHIFT 0
+#define MT6373_PMIC_RG_LDO_VSRAM_DIGRF_AIF_LP_ADDR  0x1d87
+#define MT6373_PMIC_RG_LDO_VSRAM_DIGRF_AIF_LP_SHIFT 1
+#define MT6373_PMIC_RG_VAUX18_VOCAL_ADDR            0x1e08
+#define MT6373_PMIC_RG_VAUX18_VOCAL_MASK            0xF
+#define MT6373_PMIC_RG_VAUX18_VOSEL_ADDR            0x1e09
+#define MT6373_PMIC_RG_VAUX18_VOSEL_MASK            0xF
+#define MT6373_PMIC_RG_VUSB_VOCAL_ADDR              0x1e0c
+#define MT6373_PMIC_RG_VUSB_VOCAL_MASK              0xF
+#define MT6373_PMIC_RG_VUSB_VOSEL_ADDR              0x1e0d
+#define MT6373_PMIC_RG_VUSB_VOSEL_MASK              0xF
+#define MT6373_PMIC_RG_VCN33_1_VOCAL_ADDR           0x1e10
+#define MT6373_PMIC_RG_VCN33_1_VOCAL_MASK           0xF
+#define MT6373_PMIC_RG_VCN33_1_VOSEL_ADDR           0x1e11
+#define MT6373_PMIC_RG_VCN33_1_VOSEL_MASK           0xF
+#define MT6373_PMIC_RG_VCN33_2_VOCAL_ADDR           0x1e14
+#define MT6373_PMIC_RG_VCN33_2_VOCAL_MASK           0xF
+#define MT6373_PMIC_RG_VCN33_2_VOSEL_ADDR           0x1e15
+#define MT6373_PMIC_RG_VCN33_2_VOSEL_MASK           0xF
+#define MT6373_PMIC_RG_VCN33_3_VOCAL_ADDR           0x1e18
+#define MT6373_PMIC_RG_VCN33_3_VOCAL_MASK           0xF
+#define MT6373_PMIC_RG_VCN33_3_VOSEL_ADDR           0x1e19
+#define MT6373_PMIC_RG_VCN33_3_VOSEL_MASK           0xF
+#define MT6373_PMIC_RG_VMCH_VOCAL_ADDR              0x1e1c
+#define MT6373_PMIC_RG_VMCH_VOCAL_MASK              0xF
+#define MT6373_PMIC_RG_VMCH_VOSEL_ADDR              0x1e1d
+#define MT6373_PMIC_RG_VMCH_VOSEL_MASK              0xF
+#define MT6373_PMIC_RG_VEFUSE_VOCAL_ADDR            0x1e20
+#define MT6373_PMIC_RG_VEFUSE_VOCAL_MASK            0xF
+#define MT6373_PMIC_RG_VEFUSE_VOSEL_ADDR            0x1e21
+#define MT6373_PMIC_RG_VEFUSE_VOSEL_MASK            0xF
+#define MT6373_PMIC_RG_VMC_VOCAL_ADDR               0x1e24
+#define MT6373_PMIC_RG_VMC_VOCAL_MASK               0xF
+#define MT6373_PMIC_RG_VMC_VOSEL_ADDR               0x1e25
+#define MT6373_PMIC_RG_VMC_VOSEL_MASK               0xF
+#define MT6373_PMIC_RG_VIBR_VOCAL_ADDR              0x1e28
+#define MT6373_PMIC_RG_VIBR_VOCAL_MASK              0xF
+#define MT6373_PMIC_RG_VIBR_VOSEL_ADDR              0x1e29
+#define MT6373_PMIC_RG_VIBR_VOSEL_MASK              0xF
+#define MT6373_PMIC_RG_VIO28_VOCAL_ADDR             0x1e2c
+#define MT6373_PMIC_RG_VIO28_VOCAL_MASK             0xF
+#define MT6373_PMIC_RG_VIO28_VOSEL_ADDR             0x1e2d
+#define MT6373_PMIC_RG_VIO28_VOSEL_MASK             0xF
+#define MT6373_PMIC_RG_VFP_VOCAL_ADDR               0x1e30
+#define MT6373_PMIC_RG_VFP_VOCAL_MASK               0xF
+#define MT6373_PMIC_RG_VFP_VOSEL_ADDR               0x1e31
+#define MT6373_PMIC_RG_VFP_VOSEL_MASK               0xF
+#define MT6373_PMIC_RG_VTP_VOCAL_ADDR               0x1e34
+#define MT6373_PMIC_RG_VTP_VOCAL_MASK               0xF
+#define MT6373_PMIC_RG_VTP_VOSEL_ADDR               0x1e35
+#define MT6373_PMIC_RG_VTP_VOSEL_MASK               0xF
+#define MT6373_PMIC_RG_VSIM1_VOCAL_ADDR             0x1e38
+#define MT6373_PMIC_RG_VSIM1_VOCAL_MASK             0xF
+#define MT6373_PMIC_RG_VSIM1_VOSEL_ADDR             0x1e39
+#define MT6373_PMIC_RG_VSIM1_VOSEL_MASK             0xF
+#define MT6373_PMIC_RG_VSIM2_VOCAL_ADDR             0x1e3c
+#define MT6373_PMIC_RG_VSIM2_VOCAL_MASK             0xF
+#define MT6373_PMIC_RG_VSIM2_VOSEL_ADDR             0x1e3d
+#define MT6373_PMIC_RG_VSIM2_VOSEL_MASK             0xF
+#define MT6373_PMIC_RG_VAUD18_VOCAL_ADDR            0x1e88
+#define MT6373_PMIC_RG_VAUD18_VOCAL_MASK            0xF
+#define MT6373_PMIC_RG_VAUD18_VOSEL_ADDR            0x1e89
+#define MT6373_PMIC_RG_VAUD18_VOSEL_MASK            0xF
+#define MT6373_PMIC_RG_VRF18_AIF_VOCAL_ADDR         0x1e8c
+#define MT6373_PMIC_RG_VRF18_AIF_VOCAL_MASK         0xF
+#define MT6373_PMIC_RG_VRF18_AIF_VOSEL_ADDR         0x1e8d
+#define MT6373_PMIC_RG_VRF18_AIF_VOSEL_MASK         0xF
+#define MT6373_PMIC_RG_VCN18IO_VOCAL_ADDR           0x1e90
+#define MT6373_PMIC_RG_VCN18IO_VOCAL_MASK           0xF
+#define MT6373_PMIC_RG_VCN18IO_VOSEL_ADDR           0x1e91
+#define MT6373_PMIC_RG_VCN18IO_VOSEL_MASK           0xF
+#define MT6373_PMIC_RG_VRFIO18_AIF_VOCAL_ADDR       0x1e94
+#define MT6373_PMIC_RG_VRFIO18_AIF_VOCAL_MASK       0xF
+#define MT6373_PMIC_RG_VRFIO18_AIF_VOSEL_ADDR       0x1e95
+#define MT6373_PMIC_RG_VRFIO18_AIF_VOSEL_MASK       0xF
+#define MT6373_PMIC_RG_VANT18_VOCAL_ADDR            0x1e98
+#define MT6373_PMIC_RG_VANT18_VOCAL_MASK            0xF
+#define MT6373_PMIC_RG_VANT18_VOSEL_ADDR            0x1e99
+#define MT6373_PMIC_RG_VANT18_VOSEL_MASK            0xF
+#define MT6373_PMIC_RG_VRF13_AIF_VOCAL_ADDR         0x1f08
+#define MT6373_PMIC_RG_VRF13_AIF_VOCAL_MASK         0xF
+#define MT6373_PMIC_RG_VRF13_AIF_VOSEL_ADDR         0x1f09
+#define MT6373_PMIC_RG_VRF13_AIF_VOSEL_MASK         0xF
+#define MT6373_PMIC_RG_VRF12_AIF_VOCAL_ADDR         0x1f0c
+#define MT6373_PMIC_RG_VRF12_AIF_VOCAL_MASK         0xF
+#define MT6373_PMIC_RG_VRF12_AIF_VOSEL_ADDR         0x1f0d
+#define MT6373_PMIC_RG_VRF12_AIF_VOSEL_MASK         0xF
+#define MT6373_PMIC_RG_VRF09_AIF_VOCAL_ADDR         0x1f88
+#define MT6373_PMIC_RG_VRF09_AIF_VOCAL_MASK         0xF
+#define MT6373_PMIC_RG_VRF09_AIF_VOSEL_ADDR         0x1f89
+#define MT6373_PMIC_RG_VRF09_AIF_VOSEL_MASK         0xF
+
+#define MT6373_LDO_VMCH_EINT                        0x1cbf
+#define MT6373_PMIC_RG_LDO_VMCH_EINT_EN_MASK        0x1
+#define MT6373_PMIC_RG_LDO_VMCH_EINT_POL_MASK       0x4
+#define MT6373_PMIC_RG_LDO_VMCH_EINT_DB_MASK        0x10
+
+#endif /* __LINUX_REGULATOR_MT6373_H */
-- 
2.46.0


