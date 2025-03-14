Return-Path: <linux-iio+bounces-16814-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD810A60A89
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 08:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D06F3B3601
	for <lists+linux-iio@lfdr.de>; Fri, 14 Mar 2025 07:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B781B19CC2E;
	Fri, 14 Mar 2025 07:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="N7/txmfl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB864198845;
	Fri, 14 Mar 2025 07:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741938936; cv=none; b=fp0jP0m/iWtz+cJAG/rBh1PealG1uyLoXZqcYZh0i0a8hV3g/IdAhVugz2+a9bFhidcH8D1/M2rpJbjXSFGuDRsdQjfp9al92SMbjPmeh4rB3FYMO3TYZK/WEdKWLX0tVSEOWPoSNPSL6ZHiabjZrQ6mPE10X680sBpecR3Ca1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741938936; c=relaxed/simple;
	bh=gSZ1vfvttshkX70ytTykwb3n1ENaSrc0Ac3KZVRMGfI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tnxozv2u8trT4vX68zXjWNZBhyNz2TnaOguX3H2wt8evEpJOO7+/8U83MkLXWoeE2KRZ4xelVt+bg08I/G1aXahs0U1okU33LoASqMs4WPovSgrBTodaSM6E4DWU5L/XcYPrmL3GTtNDw4XFhosYL6i6fENGOaw15QrnTaxRtIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=N7/txmfl; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b070a75a00a911f0aae1fd9735fae912-20250314
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=pVWm7uFv02O/ZDF60tnLZJcnGk12CQQp+MXAlWuZspM=;
	b=N7/txmflyfrpDjdDklEoSDmuzCiPdmN3TUs5VDju99AlD1vWr6BwCTOjczOADABBuEXe5/DBG1Q/mSS9RhGG08IIHOFA6O+J3M2qzqMwc+8Y7GKglEjJLBzdPGGzsFiszWx1i2MjG0EIsvAAX/9ptrqJcy5km3M1mNsP4GtZUDs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:183bc88c-59fc-4bf2-a061-e824b5389180,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:32381a4a-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b070a75a00a911f0aae1fd9735fae912-20250314
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <lu.tang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 752664611; Fri, 14 Mar 2025 15:55:25 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 14 Mar 2025 15:55:24 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Fri, 14 Mar 2025 15:55:23 +0800
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
Subject: [PATCH 3/5] pmic: mediatek: Add spmi pmic mfd driver
Date: Fri, 14 Mar 2025 15:32:29 +0800
Message-ID: <20250314073307.25092-4-Lu.Tang@mediatek.com>
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

Add spmi pmic mfd driver for mt8196

Signed-off-by: Lu Tang <lu.tang@mediatek.com>
---
 drivers/mfd/Kconfig                  |  26 ++
 drivers/mfd/Makefile                 |   2 +
 drivers/mfd/mt6685-core.c            |  83 +++++
 drivers/mfd/mtk-spmi-pmic.c          | 518 +++++++++++++++++++++++++++
 include/linux/mfd/mt6363/core.h      | 134 +++++++
 include/linux/mfd/mt6363/registers.h | 168 +++++++++
 include/linux/mfd/mt6373/core.h      |  94 +++++
 include/linux/mfd/mt6373/registers.h |  53 +++
 8 files changed, 1078 insertions(+)
 create mode 100644 drivers/mfd/mt6685-core.c
 create mode 100644 drivers/mfd/mtk-spmi-pmic.c
 create mode 100644 include/linux/mfd/mt6363/core.h
 create mode 100644 include/linux/mfd/mt6363/registers.h
 create mode 100644 include/linux/mfd/mt6373/core.h
 create mode 100644 include/linux/mfd/mt6373/registers.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index d44c69bb3dfd..a62625566893 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1030,6 +1030,32 @@ config MFD_MT6397
 	  accessing the device; additional drivers must be enabled in order
 	  to use the functionality of the device.
 
+config MFD_MT6685
+	tristate "MT6685 SPMI PMIC"
+	depends on OF
+	depends on SPMI
+	select REGMAP_SPMI
+	select REGMAP_IRQ
+	help
+	  This enables support for the Mediatek SPMI PMICs.
+	  These PMICs are currently used with the Mediatek series of
+	  SoCs.  Note, that this will only be useful paired with descriptions
+	  of the independent functions as children nodes in the device tree.
+
+config MFD_MTK_SPMI_PMIC
+	tristate "Mediatek SPMI PMICs"
+	depends on OF
+	depends on SPMI
+	select REGMAP_SPMI
+	help
+	  This enables support for the Mediatek SPMI PMICs.
+	  These PMICs are currently used with the MT63xx series of
+	  SoCs.  Note, that this will only be useful paired with descriptions
+	  of the independent functions as children nodes in the device tree.
+
+	  Say M here if you want to include support for the SPMI PMIC
+	  series as a module.  The module will be called "mtk-spmi-pmic".
+
 config MFD_MENF21BMC
 	tristate "MEN 14F021P00 Board Management Controller Support"
 	depends on I2C
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 9220eaf7cf12..b8cb34284e56 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -182,6 +182,8 @@ obj-$(CONFIG_MFD_MT6360)	+= mt6360-core.o
 obj-$(CONFIG_MFD_MT6370)	+= mt6370.o
 mt6397-objs			:= mt6397-core.o mt6397-irq.o mt6358-irq.o
 obj-$(CONFIG_MFD_MT6397)	+= mt6397.o
+obj-$(CONFIG_MFD_MT6685)	+= mt6685-core.o
+obj-$(CONFIG_MFD_MTK_SPMI_PMIC)	+= mtk-spmi-pmic.o
 
 pcf50633-objs			:= pcf50633-core.o pcf50633-irq.o
 obj-$(CONFIG_MFD_PCF50633)	+= pcf50633.o
diff --git a/drivers/mfd/mt6685-core.c b/drivers/mfd/mt6685-core.c
new file mode 100644
index 000000000000..c71008184666
--- /dev/null
+++ b/drivers/mfd/mt6685-core.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 MediaTek Inc.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/regmap.h>
+#include <linux/spmi.h>
+
+static const struct mfd_cell mt6685_devs[] = {
+	{
+		.name = "mt6685-clkbuf",
+		.of_compatible = "mediatek,mt6685-clkbuf",
+	}, {
+		.name = "mt6685-tb-clkbuf",
+		.of_compatible = "mediatek,mt6685-tb-clkbuf",
+	}, {
+		.name = "mt6685-rtc",
+		.of_compatible = "mediatek,mt6685-rtc",
+	}, {
+		.name = "mt6685-audclk",
+		.of_compatible = "mediatek,mt6685-audclk",
+	}, {
+		.name = "mt6685-consys",
+		.of_compatible = "mediatek,mt6685-consys",
+	}, {
+		.name = "mt6685-gps",
+		.of_compatible = "mediatek,mt6685-gps",
+	}
+};
+
+static const struct regmap_config spmi_regmap_config = {
+	.reg_bits	= 16,
+	.val_bits	= 8,
+	.max_register	= 0x2000,
+	.fast_io	= true,
+	.use_single_read = true,
+	.use_single_write = true
+};
+
+static int mt6685_spmi_probe(struct spmi_device *sdev)
+{
+	int ret;
+	struct regmap *regmap;
+
+	regmap = devm_regmap_init_spmi_ext(sdev, &spmi_regmap_config);
+	if (IS_ERR(regmap)) {
+		dev_err(&sdev->dev, "Failed to init mt6685 regmap: %ld\n", PTR_ERR(regmap));
+		return PTR_ERR(regmap);
+	}
+
+	ret = devm_mfd_add_devices(&sdev->dev, -1, mt6685_devs,
+				   ARRAY_SIZE(mt6685_devs), NULL, 0, NULL);
+	if (ret) {
+		dev_err(&sdev->dev, "Failed to add child devices: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id mt6685_id_table[] = {
+	{ .compatible = "mediatek,mt6685", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mt6685_id_table);
+
+static struct spmi_driver mt6685_spmi_driver = {
+	.probe = mt6685_spmi_probe,
+	.driver = {
+		.name = "mt6685",
+		.of_match_table = mt6685_id_table,
+	},
+};
+module_spmi_driver(mt6685_spmi_driver);
+
+MODULE_DESCRIPTION("Mediatek SPMI MT6685 Clock IC driver");
+MODULE_AUTHOR("Lu Tang <lu.tang@mediatek.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/mtk-spmi-pmic.c b/drivers/mfd/mtk-spmi-pmic.c
new file mode 100644
index 000000000000..4c4bed5e991a
--- /dev/null
+++ b/drivers/mfd/mtk-spmi-pmic.c
@@ -0,0 +1,518 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 MediaTek Inc.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/mt6363/core.h>
+#include <linux/mfd/mt6363/registers.h>
+#include <linux/mfd/mt6373/core.h>
+#include <linux/mfd/mt6373/registers.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/of_irq.h>
+#include <linux/regmap.h>
+#include <linux/spmi.h>
+
+#define MTK_SPMI_PMIC_REG_WIDTH	8
+#define PMIC_SWCID		0xB
+#define PMIC_MT6316_SWCID	0x20B
+#define RCS_INT_DONE		0x41B
+
+struct irq_top_t {
+	int hwirq_base;
+	unsigned int num_int_regs;
+	unsigned int en_reg;
+	unsigned int en_reg_shift;
+	unsigned int sta_reg;
+	unsigned int sta_reg_shift;
+	unsigned int top_offset;
+};
+
+struct mtk_spmi_pmic_data {
+	const struct mfd_cell *cells;
+	int cell_size;
+	unsigned int num_top;
+	unsigned int num_pmic_irqs;
+	unsigned short top_int_status_reg;
+	struct irq_top_t *pmic_ints;
+	unsigned int cid_addr;
+};
+
+struct pmic_core {
+	struct device *dev;
+	struct spmi_device *sdev;
+	struct regmap *regmap;
+	u16 chip_id;
+	int irq;
+	bool *enable_hwirq;
+	bool *cache_hwirq;
+	struct mutex irqlock;
+	struct irq_domain *irq_domain;
+	const struct mtk_spmi_pmic_data *chip_data;
+};
+
+static const struct resource mt6363_regulators_resources[] = {
+	DEFINE_RES_IRQ_NAMED(MT6363_IRQ_VCN15_OC, "VCN15"),
+	DEFINE_RES_IRQ_NAMED(MT6363_IRQ_VCN13_OC, "VCN13"),
+	DEFINE_RES_IRQ_NAMED(MT6363_IRQ_VRF09_OC, "VRF09"),
+	DEFINE_RES_IRQ_NAMED(MT6363_IRQ_VRF12_OC, "VRF12"),
+	DEFINE_RES_IRQ_NAMED(MT6363_IRQ_VRF13_OC, "VRF13"),
+	DEFINE_RES_IRQ_NAMED(MT6363_IRQ_VRF18_OC, "VRF18"),
+	DEFINE_RES_IRQ_NAMED(MT6363_IRQ_VRFIO18_OC, "VRFIO18"),
+	DEFINE_RES_IRQ_NAMED(MT6363_IRQ_VSRAM_MDFE_OC, "VSRAM_MDFE"),
+	DEFINE_RES_IRQ_NAMED(MT6363_IRQ_VTREF18_OC, "VTREF18"),
+	DEFINE_RES_IRQ_NAMED(MT6363_IRQ_VSRAM_APU_OC, "VSRAM_APU"),
+	DEFINE_RES_IRQ_NAMED(MT6363_IRQ_VAUX18_OC, "VAUX18"),
+	DEFINE_RES_IRQ_NAMED(MT6363_IRQ_VEMC_OC, "VEMC"),
+	DEFINE_RES_IRQ_NAMED(MT6363_IRQ_VUFS12_OC, "VUFS12"),
+	DEFINE_RES_IRQ_NAMED(MT6363_IRQ_VUFS18_OC, "VUFS18"),
+	DEFINE_RES_IRQ_NAMED(MT6363_IRQ_VIO18_OC, "VIO18"),
+	DEFINE_RES_IRQ_NAMED(MT6363_IRQ_VIO075_OC, "VIO075"),
+	DEFINE_RES_IRQ_NAMED(MT6363_IRQ_VA12_1_OC, "VA12_1"),
+	DEFINE_RES_IRQ_NAMED(MT6363_IRQ_VA12_2_OC, "VA12_2"),
+	DEFINE_RES_IRQ_NAMED(MT6363_IRQ_VA15_OC, "VA15"),
+	DEFINE_RES_IRQ_NAMED(MT6363_IRQ_VM18_OC, "VM18"),
+};
+
+static const struct resource mt6363_keys_resources[] = {
+	DEFINE_RES_IRQ(MT6363_IRQ_PWRKEY),
+	DEFINE_RES_IRQ(MT6363_IRQ_HOMEKEY),
+	DEFINE_RES_IRQ(MT6363_IRQ_PWRKEY_R),
+	DEFINE_RES_IRQ(MT6363_IRQ_HOMEKEY_R),
+};
+
+static const struct resource mt6363_lvsys_notify_resources[] = {
+	/* MT6363 LVSYS interrupt name is contrary,
+	 * we name LVSYS_R to MT6363_IRQ_NI_LVSYS_INT_FALLING;
+	 * LVSYS_F to MT6363_IRQ_NI_LVSYS_INT_RISING
+	 */
+	DEFINE_RES_IRQ_NAMED(MT6363_IRQ_NI_LVSYS_INT_FALLING, "LVSYS_R"),
+	DEFINE_RES_IRQ_NAMED(MT6363_IRQ_NI_LVSYS_INT_RISING, "LVSYS_F"),
+};
+
+static const struct resource mt6373_regulators_resources[] = {
+	DEFINE_RES_IRQ_NAMED(MT6373_IRQ_VUSB_OC, "VUSB"),
+	DEFINE_RES_IRQ_NAMED(MT6373_IRQ_VAUX18_OC, "VAUX18"),
+	DEFINE_RES_IRQ_NAMED(MT6373_IRQ_VRF13_AIF_OC, "VRF13_AIF"),
+	DEFINE_RES_IRQ_NAMED(MT6373_IRQ_VRF18_AIF_OC, "VRF18_AIF"),
+	DEFINE_RES_IRQ_NAMED(MT6373_IRQ_VRFIO18_AIF_OC, "VRFIO18_AIF"),
+	DEFINE_RES_IRQ_NAMED(MT6373_IRQ_VCN33_1_OC, "VCN33_1"),
+	DEFINE_RES_IRQ_NAMED(MT6373_IRQ_VCN33_2_OC, "VCN33_2"),
+	DEFINE_RES_IRQ_NAMED(MT6373_IRQ_VCN33_3_OC, "VCN33_3"),
+	DEFINE_RES_IRQ_NAMED(MT6373_IRQ_VCN18IO_OC, "VCN18IO"),
+	DEFINE_RES_IRQ_NAMED(MT6373_IRQ_VRF09_AIF_OC, "VRF09_AIF"),
+	DEFINE_RES_IRQ_NAMED(MT6373_IRQ_VRF12_AIF_OC, "VRF12_AIF"),
+	DEFINE_RES_IRQ_NAMED(MT6373_IRQ_VANT18_OC, "VANT18"),
+	DEFINE_RES_IRQ_NAMED(MT6373_IRQ_VSRAM_DIGRF_AIF_OC, "VSRAM_DIGRF_AIF"),
+	DEFINE_RES_IRQ_NAMED(MT6373_IRQ_VEFUSE_OC, "VEFUSE"),
+	DEFINE_RES_IRQ_NAMED(MT6373_IRQ_VMCH_OC, "VMCH"),
+	DEFINE_RES_IRQ_NAMED(MT6373_IRQ_VMC_OC, "VMC"),
+	DEFINE_RES_IRQ_NAMED(MT6373_IRQ_VIBR_OC, "VIBR"),
+	DEFINE_RES_IRQ_NAMED(MT6373_IRQ_VIO28_OC, "VIO28"),
+	DEFINE_RES_IRQ_NAMED(MT6373_IRQ_VFP_OC, "VFP"),
+	DEFINE_RES_IRQ_NAMED(MT6373_IRQ_VTP_OC, "VTP"),
+};
+
+static const struct mfd_cell mt6363_devs[] = {
+	{
+		.name = "mt6363-auxadc",
+		.of_compatible = "mediatek,mt6363-auxadc",
+	}, {
+		.name = "mtk-dynamic-loading-throttling",
+		.of_compatible = "mediatek,mt6363-dynamic_loading_throttling",
+	}, {
+		.name = "mt6363-efuse",
+		.of_compatible = "mediatek,mt6363-efuse",
+	}, {
+		.name = "mt6363-regulator",
+		.num_resources = ARRAY_SIZE(mt6363_regulators_resources),
+		.resources = mt6363_regulators_resources,
+		.of_compatible = "mediatek,mt6363-regulator",
+	}, {
+		.name = "mtk-pmic-keys",
+		.num_resources = ARRAY_SIZE(mt6363_keys_resources),
+		.resources = mt6363_keys_resources,
+		.of_compatible = "mediatek,mt6363-keys"
+	}, {
+		.name = "mt6363-consys",
+		.of_compatible = "mediatek,mt6363-consys",
+	}, {
+		.name = "mt6363-lvsys-notify",
+		.num_resources = ARRAY_SIZE(mt6363_lvsys_notify_resources),
+		.resources = mt6363_lvsys_notify_resources,
+		.of_compatible = "mediatek,mt6363-lvsys-notify",
+	}, {
+		.name = "mt6363-pinctrl",
+		.of_compatible = "mediatek,mt6363-pinctrl",
+	},
+};
+
+static const struct mfd_cell mt6373_devs[] = {
+	{
+		.name = "mt6373-regulator",
+		.num_resources = ARRAY_SIZE(mt6373_regulators_resources),
+		.resources = mt6373_regulators_resources,
+		.of_compatible = "mediatek,mt6373-regulator",
+	}, {
+		.name = "mt6373-auxadc",
+		.of_compatible = "mediatek,mt6373-auxadc",
+	}, {
+		.name = "mt6373-efuse",
+		.of_compatible = "mediatek,mt6373-efuse",
+	}, {
+		.name = "mt6373-consys",
+		.of_compatible = "mediatek,mt6373-consys",
+	}, {
+		.name = "mt6373-pinctrl",
+		.of_compatible = "mediatek,mt6373-pinctrl",
+	},
+};
+
+static struct irq_top_t mt6363_ints[] = {
+	MT6363_TOP_GEN(BUCK),
+	MT6363_TOP_GEN(LDO),
+	MT6363_TOP_GEN(PSC),
+	MT6363_TOP_GEN(MISC),
+	MT6363_TOP_GEN(HK),
+	MT6363_TOP_GEN(BM),
+};
+
+
+static struct irq_top_t mt6373_ints[] = {
+	MT6373_TOP_GEN(BUCK),
+	MT6373_TOP_GEN(LDO),
+	MT6373_TOP_GEN(MISC),
+};
+
+static const struct mtk_spmi_pmic_data mt6316_data = {
+	.num_pmic_irqs = 0,
+	.cid_addr = PMIC_MT6316_SWCID,
+};
+
+static const struct mtk_spmi_pmic_data mt6363_data = {
+	.cells = mt6363_devs,
+	.cell_size = ARRAY_SIZE(mt6363_devs),
+	.num_top = ARRAY_SIZE(mt6363_ints),
+	.num_pmic_irqs = MT6363_IRQ_NR,
+	.top_int_status_reg = MT6363_TOP_INT_STATUS1,
+	.pmic_ints = mt6363_ints,
+};
+
+static const struct mtk_spmi_pmic_data mt6373_data = {
+	.cells = mt6373_devs,
+	.cell_size = ARRAY_SIZE(mt6373_devs),
+	.num_top = ARRAY_SIZE(mt6373_ints),
+	.num_pmic_irqs = MT6373_IRQ_NR,
+	.top_int_status_reg = MT6373_TOP_INT_STATUS1,
+	.pmic_ints = mt6373_ints,
+};
+
+static void mtk_spmi_pmic_irq_enable(struct irq_data *data)
+{
+	unsigned int hwirq = irqd_to_hwirq(data);
+	struct pmic_core *core = irq_data_get_irq_chip_data(data);
+
+	core->enable_hwirq[hwirq] = true;
+}
+
+static void mtk_spmi_pmic_irq_disable(struct irq_data *data)
+{
+	unsigned int hwirq = irqd_to_hwirq(data);
+	struct pmic_core *core = irq_data_get_irq_chip_data(data);
+
+	core->enable_hwirq[hwirq] = false;
+}
+
+static void mtk_spmi_pmic_irq_lock(struct irq_data *data)
+{
+	struct pmic_core *core = irq_data_get_irq_chip_data(data);
+
+	mutex_lock(&core->irqlock);
+}
+
+static void mtk_spmi_pmic_irq_sync_unlock(struct irq_data *data)
+{
+	unsigned int i, top_gp, gp_offset, en_reg, int_regs, shift;
+	struct irq_top_t *pmic_int;
+	struct pmic_core *core = irq_data_get_irq_chip_data(data);
+	const struct mtk_spmi_pmic_data *chip_data = core->chip_data;
+
+	for (i = 0; i < chip_data->num_pmic_irqs; i++) {
+		if (core->enable_hwirq[i] == core->cache_hwirq[i])
+			continue;
+
+		/* Find out the IRQ group */
+		top_gp = 0;
+		while ((top_gp + 1) < chip_data->num_top &&
+			i >= chip_data->pmic_ints[top_gp + 1].hwirq_base)
+			top_gp++;
+
+		pmic_int = &(chip_data->pmic_ints[top_gp]);
+		/* Find the IRQ registers */
+		gp_offset = i - pmic_int->hwirq_base;
+		int_regs = gp_offset / MTK_SPMI_PMIC_REG_WIDTH;
+		shift = gp_offset % MTK_SPMI_PMIC_REG_WIDTH;
+		en_reg = pmic_int->en_reg + (pmic_int->en_reg_shift * int_regs);
+
+		regmap_update_bits(core->regmap, en_reg, BIT(shift),
+				   core->enable_hwirq[i] << shift);
+		core->cache_hwirq[i] = core->enable_hwirq[i];
+	}
+	mutex_unlock(&core->irqlock);
+}
+
+static struct irq_chip mtk_spmi_pmic_irq_chip = {
+	.name = "spmi-pmic-irq",
+	.flags = IRQCHIP_SKIP_SET_WAKE,
+	.irq_enable = mtk_spmi_pmic_irq_enable,
+	.irq_disable = mtk_spmi_pmic_irq_disable,
+	.irq_bus_lock = mtk_spmi_pmic_irq_lock,
+	.irq_bus_sync_unlock = mtk_spmi_pmic_irq_sync_unlock,
+};
+
+static void mtk_spmi_pmic_irq_sp_handler(struct pmic_core *core,
+					 unsigned int top_gp)
+{
+	unsigned int irq_status = 0, sta_reg, status;
+	unsigned int hwirq, virq;
+	int ret, i, j;
+	struct irq_top_t *pmic_int;
+	const struct mtk_spmi_pmic_data *chip_data = core->chip_data;
+
+	for (i = 0; i < chip_data->pmic_ints[top_gp].num_int_regs; i++) {
+		pmic_int = &(chip_data->pmic_ints[top_gp]);
+		sta_reg = pmic_int->sta_reg + (pmic_int->sta_reg_shift * i);
+
+		ret = regmap_read(core->regmap, sta_reg, &irq_status);
+		if (ret) {
+			dev_err(core->dev,
+				"Failed to read irq status: %d\n", ret);
+			return;
+		}
+
+		if (!irq_status)
+			continue;
+
+		status = irq_status;
+		do {
+			j = __ffs(status);
+
+			hwirq = pmic_int->hwirq_base + MTK_SPMI_PMIC_REG_WIDTH * i + j;
+
+			virq = irq_find_mapping(core->irq_domain, hwirq);
+			dev_info(core->dev, "[%x]Reg[0x%x]=0x%x,hwirq=%d\n",
+				 core->chip_id, sta_reg, irq_status, hwirq);
+			if (virq)
+				handle_nested_irq(virq);
+
+			status &= ~BIT(j);
+		} while (status);
+
+		regmap_write(core->regmap, sta_reg, irq_status);
+	}
+}
+
+static irqreturn_t mtk_spmi_pmic_irq_handler(int irq, void *data)
+{
+	int ret;
+	unsigned int bit, i, top_irq_status = 0;
+	struct pmic_core *core = data;
+	const struct mtk_spmi_pmic_data *chip_data = core->chip_data;
+
+	ret = regmap_read(core->regmap, chip_data->top_int_status_reg,
+			  &top_irq_status);
+	if (ret) {
+		dev_err(core->dev,
+			"Failed to read status from the device, ret=%d\n", ret);
+		return IRQ_NONE;
+	}
+
+	dev_info(core->dev, "top_irq_sts:0x%x\n", top_irq_status);
+	for (i = 0; i < chip_data->num_top; i++) {
+		bit = BIT(chip_data->pmic_ints[i].top_offset);
+		if (top_irq_status & bit)
+			mtk_spmi_pmic_irq_sp_handler(core, i);
+	}
+
+	ret = regmap_write(core->regmap, RCS_INT_DONE, 1);
+	if (ret) {
+		dev_err(core->dev,
+			"Failed to clear RCS flag, ret=%d\n", ret);
+		return IRQ_NONE;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int mtk_spmi_pmic_irq_domain_map(struct irq_domain *d, unsigned int irq,
+					irq_hw_number_t hw)
+{
+	struct pmic_core *core = d->host_data;
+
+	irq_set_chip_data(irq, core);
+	irq_set_chip_and_handler(irq, &mtk_spmi_pmic_irq_chip,
+				 handle_level_irq);
+	irq_set_nested_thread(irq, 1);
+	irq_set_noprobe(irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops pmic_irq_domain_ops = {
+	.map = mtk_spmi_pmic_irq_domain_map,
+	.xlate = irq_domain_xlate_twocell,
+};
+
+static int mtk_spmi_pmic_irq_init(struct pmic_core *core)
+{
+	int i, j, ret;
+	unsigned int en_reg, sta_reg;
+	const struct mtk_spmi_pmic_data *chip_data = core->chip_data;
+
+	mutex_init(&core->irqlock);
+	core->enable_hwirq = devm_kcalloc(core->dev,
+					  chip_data->num_pmic_irqs,
+					  sizeof(bool), GFP_KERNEL);
+	if (!core->enable_hwirq)
+		return -ENOMEM;
+
+	core->cache_hwirq = devm_kcalloc(core->dev,
+					 chip_data->num_pmic_irqs,
+					 sizeof(bool), GFP_KERNEL);
+	if (!core->cache_hwirq)
+		return -ENOMEM;
+
+	/* Disable all interrupt for initializing */
+	for (i = 0; i < chip_data->num_top; i++) {
+		for (j = 0; j < chip_data->pmic_ints[i].num_int_regs; j++) {
+			en_reg = chip_data->pmic_ints[i].en_reg +
+				chip_data->pmic_ints[i].en_reg_shift * j;
+			regmap_write(core->regmap, en_reg, 0);
+			sta_reg = chip_data->pmic_ints[i].sta_reg +
+				chip_data->pmic_ints[i].sta_reg_shift * j;
+			regmap_write(core->regmap, sta_reg, 0xFF);
+		}
+	}
+	regmap_write(core->regmap, RCS_INT_DONE, 1);
+
+	core->irq_domain = irq_domain_add_linear(core->dev->of_node,
+						 chip_data->num_pmic_irqs,
+						 &pmic_irq_domain_ops,
+						 core);
+	if (!core->irq_domain) {
+		dev_err(core->dev, "Could not create IRQ domain\n");
+		return -ENODEV;
+	}
+
+	ret = devm_request_threaded_irq(core->dev, core->irq, NULL,
+					mtk_spmi_pmic_irq_handler, IRQF_ONESHOT,
+					mtk_spmi_pmic_irq_chip.name, core);
+	if (ret) {
+		dev_err(core->dev, "Failed to register IRQ=%d, ret=%d\n",
+			core->irq, ret);
+		return ret;
+	}
+
+	enable_irq_wake(core->irq);
+	return ret;
+}
+
+static const struct regmap_config spmi_regmap_config = {
+	.reg_bits	= 16,
+	.val_bits	= 8,
+	.max_register	= 0xffff,
+	.fast_io	= true,
+};
+
+static int mtk_spmi_pmic_probe(struct spmi_device *sdev)
+{
+	int ret;
+	unsigned int id;
+	struct device_node *np = sdev->dev.of_node;
+	struct pmic_core *core;
+	const struct mtk_spmi_pmic_data *chip_data;
+
+	core = devm_kzalloc(&sdev->dev, sizeof(*core), GFP_KERNEL);
+	if (!core)
+		return -ENOMEM;
+
+	core->sdev = sdev;
+	core->dev = &sdev->dev;
+	chip_data = (struct mtk_spmi_pmic_data *)of_device_get_match_data(&sdev->dev);
+	if (!chip_data)
+		return -ENODEV;
+
+	core->chip_data = chip_data;
+	core->regmap = devm_regmap_init_spmi_ext(sdev, &spmi_regmap_config);
+	if (IS_ERR(core->regmap))
+		return PTR_ERR(core->regmap);
+	if (chip_data->cid_addr)
+		ret = regmap_read(core->regmap, chip_data->cid_addr, &id);
+	else
+		ret = regmap_read(core->regmap, PMIC_SWCID, &id);
+	if (ret || id == 0) {
+		dev_err(&sdev->dev, "Failed to read chip id: %d\n", ret);
+		return ret;
+	}
+
+	core->chip_id = id;
+
+	if (chip_data->num_pmic_irqs) {
+		core->irq = of_irq_get(np, 0);
+		if (core->irq < 0)
+			dev_err(&sdev->dev, "Failed to get irq(%d)\n", core->irq);
+
+		ret = mtk_spmi_pmic_irq_init(core);
+		if (ret)
+			dev_err(&sdev->dev, "IRQ_init failed(%d)\n", core->irq);
+
+		ret = devm_mfd_add_devices(&sdev->dev, -1, chip_data->cells,
+					   chip_data->cell_size, NULL, 0,
+					   core->irq_domain);
+		if (ret) {
+			irq_domain_remove(core->irq_domain);
+			dev_err(&sdev->dev, "Failed to add mfd devices: %d\n", ret);
+			return ret;
+		}
+	} else {
+		ret = devm_of_platform_populate(&sdev->dev);
+		if (ret) {
+			dev_err(&sdev->dev, "Failed to platform populate: %d\n", ret);
+			return ret;
+		}
+	}
+
+	device_init_wakeup(&sdev->dev, true);
+
+	dev_dbg(&sdev->dev, "probe chip id=0x%x done\n", core->chip_id);
+
+	return ret;
+}
+
+static const struct of_device_id mtk_spmi_pmic_of_match[] = {
+	{ .compatible = "mediatek,mt6316", .data = &mt6316_data, },
+	{ .compatible = "mediatek,mt6363", .data = &mt6363_data, },
+	{ .compatible = "mediatek,mt6373", .data = &mt6373_data, },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mtk_spmi_pmic_of_match);
+
+static struct spmi_driver mtk_spmi_pmic_driver = {
+	.driver = {
+		.name = "mtk-spmi-pmic",
+		.of_match_table = of_match_ptr(mtk_spmi_pmic_of_match),
+	},
+	.probe = mtk_spmi_pmic_probe,
+};
+module_spmi_driver(mtk_spmi_pmic_driver);
+
+MODULE_DESCRIPTION("Mediatek SPMI PMIC driver");
+MODULE_ALIAS("spmi:spmi-pmic");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Argus Lin <argus.lin@mediatek.com>");
+MODULE_AUTHOR("Jeter Chen <jeter.chen@mediatek.com>");
+MODULE_AUTHOR("Lu Tang <lu.tang@mediatek.com>");
diff --git a/include/linux/mfd/mt6363/core.h b/include/linux/mfd/mt6363/core.h
new file mode 100644
index 000000000000..3243a52da34d
--- /dev/null
+++ b/include/linux/mfd/mt6363/core.h
@@ -0,0 +1,134 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ */
+
+#ifndef __MFD_MT6363_CORE_H__
+#define __MFD_MT6363_CORE_H__
+
+#define MT6363_REG_WIDTH 8
+
+enum mt6363_irq_top_status_shift {
+	MT6363_BUCK_TOP = 0,
+	MT6363_LDO_TOP,
+	MT6363_PSC_TOP,
+	MT6363_MISC_TOP,
+	MT6363_HK_TOP,
+	MT6363_SCK_TOP,
+	MT6363_BM_TOP,
+	MT6363_AUD_TOP,
+};
+
+enum mt6363_irq_numbers {
+	MT6363_IRQ_VS2_OC = 0,
+	MT6363_IRQ_VBUCK1_OC,
+	MT6363_IRQ_VBUCK2_OC,
+	MT6363_IRQ_VBUCK3_OC,
+	MT6363_IRQ_VBUCK4_OC,
+	MT6363_IRQ_VBUCK5_OC,
+	MT6363_IRQ_VBUCK6_OC,
+	MT6363_IRQ_VBUCK7_OC,
+	MT6363_IRQ_VS1_OC,
+	MT6363_IRQ_VS3_OC,
+	MT6363_IRQ_VCN15_OC = 16,
+	MT6363_IRQ_VCN13_OC,
+	MT6363_IRQ_VRF09_OC,
+	MT6363_IRQ_VRF12_OC,
+	MT6363_IRQ_VRF13_OC,
+	MT6363_IRQ_VRF18_OC,
+	MT6363_IRQ_VRFIO18_OC,
+	MT6363_IRQ_VSRAM_DIGRF_OC,
+	MT6363_IRQ_VSRAM_MDFE_OC,
+	MT6363_IRQ_VSRAM_MODEM_OC,
+	MT6363_IRQ_VTREF18_OC,
+	MT6363_IRQ_VSRAM_CPUB_OC,
+	MT6363_IRQ_VSRAM_CPUM_OC,
+	MT6363_IRQ_VSRAM_CPUL_OC,
+	MT6363_IRQ_VSRAM_APU_OC,
+	MT6363_IRQ_VAUX18_OC,
+	MT6363_IRQ_VEMC_OC,
+	MT6363_IRQ_VUFS12_OC,
+	MT6363_IRQ_VUFS18_OC,
+	MT6363_IRQ_VIO18_OC,
+	MT6363_IRQ_VIO075_OC,
+	MT6363_IRQ_VA12_1_OC,
+	MT6363_IRQ_VA12_2_OC,
+	MT6363_IRQ_VA15_OC,
+	MT6363_IRQ_VM18_OC,
+	MT6363_IRQ_PWRKEY = 48,
+	MT6363_IRQ_HOMEKEY,
+	MT6363_IRQ_HOMEKEY_2,
+	MT6363_IRQ_PWRKEY_R,
+	MT6363_IRQ_HOMEKEY_R,
+	MT6363_IRQ_HOMEKEY_2_R,
+	MT6363_IRQ_NI_LVSYS_INT_FALLING,
+	MT6363_IRQ_NI_LVSYS_INT_RISING,
+	MT6363_IRQ_CHRDET_LEVEL,
+	MT6363_IRQ_CHRDET_EDGE,
+	MT6363_IRQ_RCS0 = 64,
+	MT6363_IRQ_SPMI_CMD_ALERT,
+	MT6363_IRQ_BM_PROTREG = 70,
+	MT6363_IRQ_BUCK_PROTREG = 72,
+	MT6363_IRQ_LDO_PROTREG,
+	MT6363_IRQ_PSC_PROTREG,
+	MT6363_IRQ_PLT_PROTREG,
+	MT6363_IRQ_HK_PROTREG,
+	MT6363_IRQ_TOP_PROTREG = 79,
+	MT6363_IRQ_BAT_H,
+	MT6363_IRQ_BAT_L,
+	MT6363_IRQ_BAT2_H,
+	MT6363_IRQ_BAT2_L,
+	MT6363_IRQ_BAT_TEMP_H,
+	MT6363_IRQ_BAT_TEMP_L,
+	MT6363_IRQ_THR_H,
+	MT6363_IRQ_THR_L,
+	MT6363_IRQ_AUXADC_IMP,
+	MT6363_IRQ_NAG_C_DLTV,
+	MT6363_IRQ_FG_BAT_H = 88,
+	MT6363_IRQ_FG_BAT_L,
+	MT6363_IRQ_FG_CUR_H,
+	MT6363_IRQ_FG_CUR_L,
+	MT6363_IRQ_FG_ZCV,
+	MT6363_IRQ_FG_N_CHARGE_L = 95,
+	MT6363_IRQ_FG_IAVG_H,
+	MT6363_IRQ_FG_IAVG_L,
+	MT6363_IRQ_FG_DISCHARGE = 99,
+	MT6363_IRQ_FG_CHARGE,
+	MT6363_IRQ_BATON_LV = 104,
+	MT6363_IRQ_BATON_BAT_IN = 106,
+	MT6363_IRQ_BATON_BAT_OUT,
+	MT6363_IRQ_NR = 108,
+};
+
+#define MT6363_IRQ_BUCK_BASE MT6363_IRQ_VS2_OC
+#define MT6363_IRQ_LDO_BASE MT6363_IRQ_VCN15_OC
+#define MT6363_IRQ_PSC_BASE MT6363_IRQ_PWRKEY
+#define MT6363_IRQ_MISC_BASE MT6363_IRQ_RCS0
+#define MT6363_IRQ_HK_BASE MT6363_IRQ_BAT_H
+#define MT6363_IRQ_BM_BASE MT6363_IRQ_FG_BAT_H
+
+#define MT6363_IRQ_BUCK_BITS \
+	(MT6363_IRQ_VS3_OC - MT6363_IRQ_BUCK_BASE + 1)
+#define MT6363_IRQ_LDO_BITS \
+	(MT6363_IRQ_VM18_OC - MT6363_IRQ_LDO_BASE + 1)
+#define MT6363_IRQ_PSC_BITS \
+	(MT6363_IRQ_CHRDET_EDGE - MT6363_IRQ_PSC_BASE + 1)
+#define MT6363_IRQ_MISC_BITS \
+	(MT6363_IRQ_TOP_PROTREG - MT6363_IRQ_MISC_BASE + 1)
+#define MT6363_IRQ_HK_BITS \
+	(MT6363_IRQ_NAG_C_DLTV - MT6363_IRQ_HK_BASE + 1)
+#define MT6363_IRQ_BM_BITS \
+	(MT6363_IRQ_BATON_BAT_OUT - MT6363_IRQ_BM_BASE + 1)
+
+#define MT6363_TOP_GEN(sp) \
+{ \
+	.hwirq_base = MT6363_IRQ_##sp##_BASE, \
+	.num_int_regs =	((MT6363_IRQ_##sp##_BITS - 1) / MT6363_REG_WIDTH) + 1, \
+	.en_reg = MT6363_##sp##_TOP_INT_CON0, \
+	.en_reg_shift = 0x3, \
+	.sta_reg = MT6363_##sp##_TOP_INT_STATUS0, \
+	.sta_reg_shift = 0x1, \
+	.top_offset = MT6363_##sp##_TOP, \
+}
+
+#endif /* __MFD_MT6363_CORE_H__ */
diff --git a/include/linux/mfd/mt6363/registers.h b/include/linux/mfd/mt6363/registers.h
new file mode 100644
index 000000000000..e22ca686a7d0
--- /dev/null
+++ b/include/linux/mfd/mt6363/registers.h
@@ -0,0 +1,168 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ */
+
+
+#ifndef __MFD_MT6363_REGISTERS_H__
+#define __MFD_MT6363_REGISTERS_H__
+
+/* PMIC Registers */
+#define MT6363_TOPSTATUS		   (0x1e)
+#define MT6363_MISC_TOP_INT_CON0           (0x37)
+#define MT6363_MISC_TOP_INT_STATUS0        (0x43)
+#define MT6363_TOP_INT_STATUS1             (0x4e)
+#define MT6363_PSC_TOP_INT_CON0            (0x90f)
+#define MT6363_PSC_TOP_INT_STATUS0         (0x91b)
+#define MT6363_STRUP_CON11		   (0xa0e)
+#define MT6363_STRUP_CON12		   (0xa0f)
+#define MT6363_PCHR_VREF_ANA_CON1          (0xa89)
+#define MT6363_PCHR_VREF_ANA_CON2          (0xa8a)
+#define MT6363_BM_TOP_INT_CON0             (0xc24)
+#define MT6363_BM_TOP_INT_STATUS0          (0xc36)
+#define MT6363_HK_TOP_INT_CON0             (0xf92)
+#define MT6363_HK_TOP_INT_STATUS0          (0xf9e)
+#define MT6363_BUCK_TOP_INT_CON0           (0x1411)
+#define MT6363_BUCK_TOP_INT_STATUS0        (0x141d)
+#define MT6363_LDO_TOP_INT_CON0            (0x1b11)
+#define MT6363_LDO_TOP_INT_STATUS0         (0x1b29)
+
+/* voter */
+#define MT6363_BUCK_VS2_VOTER_CON0         (0x149a)
+#define MT6363_BUCK_VS2_VOTER_CON0_SET     (0x149b)
+#define MT6363_BUCK_VS2_VOTER_CON0_CLR     (0x149c)
+#define MT6363_BUCK_VS2_VOTER_CON1         (0x149d)
+#define MT6363_BUCK_VS2_VOTER_CON1_SET     (0x149e)
+#define MT6363_BUCK_VS2_VOTER_CON1_CLR     (0x149f)
+#define MT6363_BUCK_VS2_VOTER_CFG          (0x14a0)
+#define MT6363_BUCK_VS1_VOTER_CON0         (0x189a)
+#define MT6363_BUCK_VS1_VOTER_CON0_SET     (0x189b)
+#define MT6363_BUCK_VS1_VOTER_CON0_CLR     (0x189c)
+#define MT6363_BUCK_VS1_VOTER_CON1         (0x189d)
+#define MT6363_BUCK_VS1_VOTER_CON1_SET     (0x189e)
+#define MT6363_BUCK_VS1_VOTER_CON1_CLR     (0x189f)
+#define MT6363_BUCK_VS1_VOTER_CFG          (0x18a0)
+#define MT6363_BUCK_VS3_VOTER_CON0         (0x191a)
+#define MT6363_BUCK_VS3_VOTER_CON0_SET     (0x191b)
+#define MT6363_BUCK_VS3_VOTER_CON0_CLR     (0x191c)
+#define MT6363_BUCK_VS3_VOTER_CON1         (0x191d)
+#define MT6363_BUCK_VS3_VOTER_CON1_SET     (0x191e)
+#define MT6363_BUCK_VS3_VOTER_CON1_CLR     (0x191f)
+#define MT6363_BUCK_VS3_VOTER_CFG          (0x1920)
+
+#define MT6363_CHRDET_DEB_ADDR             MT6363_TOPSTATUS
+#define MT6363_CHRDET_DEB_MASK             (0x1)
+#define MT6363_CHRDET_DEB_SHIFT            (2)
+#define MT6363_RG_VBB_UVLO_VTHL_ADDR       MT6363_PCHR_VREF_ANA_CON1
+#define MT6363_RG_VBB_UVLO_VTHL_MASK       (0xF)
+#define MT6363_RG_VBB_UVLO_VTHL_SHIFT      (0)
+#define MT6363_RG_VSYS_UVLO_VTHL_ADDR      MT6363_PCHR_VREF_ANA_CON2
+#define MT6363_RG_VSYS_UVLO_VTHL_MASK      (0xF)
+#define MT6363_RG_VSYS_UVLO_VTHL_SHIFT     (0)
+
+#define MT6363_AUXADC_ADC0_L               (0x1088)
+#define MT6363_AUXADC_ADC3_L               (0x108e)
+#define MT6363_AUXADC_ADC4_L               (0x1090)
+#define MT6363_AUXADC_ADC11_L              (0x109e)
+#define MT6363_AUXADC_ADC38_L              (0x10c4)
+#define MT6363_AUXADC_ADC39_L              (0x10c6)
+#define MT6363_AUXADC_ADC40_L              (0x10c8)
+#define MT6363_AUXADC_ADC_CH12_L           (0x10d2)
+#define MT6363_AUXADC_ADC_CH14_L           (0x10d8)
+#define MT6363_AUXADC_ADC42_L              (0x10dc)
+#define MT6363_AUXADC_RQST0                (0x1108)
+#define MT6363_AUXADC_RQST1                (0x1109)
+#define MT6363_AUXADC_RQST3                (0x110c)
+#define MT6363_SDMADC_RQST0                (0x110e)
+#define MT6363_SDMADC_CON0                 (0x11c4)
+#define MT6363_AUXADC_IMP0                 (0x1208)
+#define MT6363_AUXADC_IMP1                 (0x1209)
+
+/* voter */
+#define MT6363_RG_BUCK_VS2_VOTER_EN_LO_ADDR                 \
+	MT6363_BUCK_VS2_VOTER_CON0
+#define MT6363_RG_BUCK_VS2_VOTER_EN_LO_MASK                 (0xFF)
+#define MT6363_RG_BUCK_VS2_VOTER_EN_LO_SHIFT                (0)
+#define MT6363_RG_BUCK_VS2_VOTER_EN_LO_SET_ADDR             \
+	MT6363_BUCK_VS2_VOTER_CON0_SET
+#define MT6363_RG_BUCK_VS2_VOTER_EN_LO_SET_MASK             (0xFF)
+#define MT6363_RG_BUCK_VS2_VOTER_EN_LO_SET_SHIFT            (0)
+#define MT6363_RG_BUCK_VS2_VOTER_EN_LO_CLR_ADDR             \
+	MT6363_BUCK_VS2_VOTER_CON0_CLR
+#define MT6363_RG_BUCK_VS2_VOTER_EN_LO_CLR_MASK             (0xFF)
+#define MT6363_RG_BUCK_VS2_VOTER_EN_LO_CLR_SHIFT            (0)
+#define MT6363_RG_BUCK_VS2_VOTER_EN_HI_ADDR                 \
+	MT6363_BUCK_VS2_VOTER_CON1
+#define MT6363_RG_BUCK_VS2_VOTER_EN_HI_MASK                 (0xF)
+#define MT6363_RG_BUCK_VS2_VOTER_EN_HI_SHIFT                (0)
+#define MT6363_RG_BUCK_VS2_VOTER_EN_HI_SET_ADDR             \
+	MT6363_BUCK_VS2_VOTER_CON1_SET
+#define MT6363_RG_BUCK_VS2_VOTER_EN_HI_SET_MASK             (0xF)
+#define MT6363_RG_BUCK_VS2_VOTER_EN_HI_SET_SHIFT            (0)
+#define MT6363_RG_BUCK_VS2_VOTER_EN_HI_CLR_ADDR             \
+	MT6363_BUCK_VS2_VOTER_CON1_CLR
+#define MT6363_RG_BUCK_VS2_VOTER_EN_HI_CLR_MASK             (0xF)
+#define MT6363_RG_BUCK_VS2_VOTER_EN_HI_CLR_SHIFT            (0)
+#define MT6363_RG_BUCK_VS2_VOTER_VOSEL_ADDR                 \
+	MT6363_BUCK_VS2_VOTER_CFG
+#define MT6363_RG_BUCK_VS2_VOTER_VOSEL_MASK                 (0xFF)
+#define MT6363_RG_BUCK_VS2_VOTER_VOSEL_SHIFT                (0)
+#define MT6363_RG_BUCK_VS1_VOTER_EN_LO_ADDR                 \
+	MT6363_BUCK_VS1_VOTER_CON0
+#define MT6363_RG_BUCK_VS1_VOTER_EN_LO_MASK                 (0xFF)
+#define MT6363_RG_BUCK_VS1_VOTER_EN_LO_SHIFT                (0)
+#define MT6363_RG_BUCK_VS1_VOTER_EN_LO_SET_ADDR             \
+	MT6363_BUCK_VS1_VOTER_CON0_SET
+#define MT6363_RG_BUCK_VS1_VOTER_EN_LO_SET_MASK             (0xFF)
+#define MT6363_RG_BUCK_VS1_VOTER_EN_LO_SET_SHIFT            (0)
+#define MT6363_RG_BUCK_VS1_VOTER_EN_LO_CLR_ADDR             \
+	MT6363_BUCK_VS1_VOTER_CON0_CLR
+#define MT6363_RG_BUCK_VS1_VOTER_EN_LO_CLR_MASK             (0xFF)
+#define MT6363_RG_BUCK_VS1_VOTER_EN_LO_CLR_SHIFT            (0)
+#define MT6363_RG_BUCK_VS1_VOTER_EN_HI_ADDR                 \
+	MT6363_BUCK_VS1_VOTER_CON1
+#define MT6363_RG_BUCK_VS1_VOTER_EN_HI_MASK                 (0xF)
+#define MT6363_RG_BUCK_VS1_VOTER_EN_HI_SHIFT                (0)
+#define MT6363_RG_BUCK_VS1_VOTER_EN_HI_SET_ADDR             \
+	MT6363_BUCK_VS1_VOTER_CON1_SET
+#define MT6363_RG_BUCK_VS1_VOTER_EN_HI_SET_MASK             (0xF)
+#define MT6363_RG_BUCK_VS1_VOTER_EN_HI_SET_SHIFT            (0)
+#define MT6363_RG_BUCK_VS1_VOTER_EN_HI_CLR_ADDR             \
+	MT6363_BUCK_VS1_VOTER_CON1_CLR
+#define MT6363_RG_BUCK_VS1_VOTER_EN_HI_CLR_MASK             (0xF)
+#define MT6363_RG_BUCK_VS1_VOTER_EN_HI_CLR_SHIFT            (0)
+#define MT6363_RG_BUCK_VS1_VOTER_VOSEL_ADDR                 \
+	MT6363_BUCK_VS1_VOTER_CFG
+#define MT6363_RG_BUCK_VS1_VOTER_VOSEL_MASK                 (0xFF)
+#define MT6363_RG_BUCK_VS1_VOTER_VOSEL_SHIFT                (0)
+#define MT6363_RG_BUCK_VS3_VOTER_EN_LO_ADDR                 \
+	MT6363_BUCK_VS3_VOTER_CON0
+#define MT6363_RG_BUCK_VS3_VOTER_EN_LO_MASK                 (0xFF)
+#define MT6363_RG_BUCK_VS3_VOTER_EN_LO_SHIFT                (0)
+#define MT6363_RG_BUCK_VS3_VOTER_EN_LO_SET_ADDR             \
+	MT6363_BUCK_VS3_VOTER_CON0_SET
+#define MT6363_RG_BUCK_VS3_VOTER_EN_LO_SET_MASK             (0xFF)
+#define MT6363_RG_BUCK_VS3_VOTER_EN_LO_SET_SHIFT            (0)
+#define MT6363_RG_BUCK_VS3_VOTER_EN_LO_CLR_ADDR             \
+	MT6363_BUCK_VS3_VOTER_CON0_CLR
+#define MT6363_RG_BUCK_VS3_VOTER_EN_LO_CLR_MASK             (0xFF)
+#define MT6363_RG_BUCK_VS3_VOTER_EN_LO_CLR_SHIFT            (0)
+#define MT6363_RG_BUCK_VS3_VOTER_EN_HI_ADDR                 \
+	MT6363_BUCK_VS3_VOTER_CON1
+#define MT6363_RG_BUCK_VS3_VOTER_EN_HI_MASK                 (0xF)
+#define MT6363_RG_BUCK_VS3_VOTER_EN_HI_SHIFT                (0)
+#define MT6363_RG_BUCK_VS3_VOTER_EN_HI_SET_ADDR             \
+	MT6363_BUCK_VS3_VOTER_CON1_SET
+#define MT6363_RG_BUCK_VS3_VOTER_EN_HI_SET_MASK             (0xF)
+#define MT6363_RG_BUCK_VS3_VOTER_EN_HI_SET_SHIFT            (0)
+#define MT6363_RG_BUCK_VS3_VOTER_EN_HI_CLR_ADDR             \
+	MT6363_BUCK_VS3_VOTER_CON1_CLR
+#define MT6363_RG_BUCK_VS3_VOTER_EN_HI_CLR_MASK             (0xF)
+#define MT6363_RG_BUCK_VS3_VOTER_EN_HI_CLR_SHIFT            (0)
+#define MT6363_RG_BUCK_VS3_VOTER_VOSEL_ADDR                 \
+	MT6363_BUCK_VS3_VOTER_CFG
+#define MT6363_RG_BUCK_VS3_VOTER_VOSEL_MASK                 (0xFF)
+#define MT6363_RG_BUCK_VS3_VOTER_VOSEL_SHIFT                (0)
+
+#endif /* __MFD_MT6363_REGISTERS_H__ */
+
diff --git a/include/linux/mfd/mt6373/core.h b/include/linux/mfd/mt6373/core.h
new file mode 100644
index 000000000000..dd77d8cf29a2
--- /dev/null
+++ b/include/linux/mfd/mt6373/core.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ */
+
+#ifndef __MFD_MT6373_CORE_H__
+#define __MFD_MT6373_CORE_H__
+
+#define MT6373_REG_WIDTH 8
+
+enum mt6373_irq_top_status_shift {
+	MT6373_BUCK_TOP = 0,
+	MT6373_LDO_TOP,
+	MT6373_PSC_TOP,
+	MT6373_MISC_TOP,
+	MT6373_HK_TOP,
+	MT6373_SCK_TOP,
+	MT6373_BM_TOP,
+	MT6373_AUD_TOP,
+};
+
+enum mt6373_irq_numbers {
+	MT6373_IRQ_VBUCK0_OC,
+	MT6373_IRQ_VBUCK1_OC,
+	MT6373_IRQ_VBUCK2_OC,
+	MT6373_IRQ_VBUCK3_OC,
+	MT6373_IRQ_VBUCK4_OC,
+	MT6373_IRQ_VBUCK5_OC,
+	MT6373_IRQ_VBUCK6_OC,
+	MT6373_IRQ_VBUCK7_OC,
+	MT6373_IRQ_VBUCK8_OC,
+	MT6373_IRQ_VBUCK9_OC,
+	MT6373_IRQ_VAUD18_OC = 16,
+	MT6373_IRQ_VUSB_OC,
+	MT6373_IRQ_VAUX18_OC,
+	MT6373_IRQ_VRF13_AIF_OC,
+	MT6373_IRQ_VRF18_AIF_OC,
+	MT6373_IRQ_VRFIO18_AIF_OC,
+	MT6373_IRQ_VCN33_1_OC,
+	MT6373_IRQ_VCN33_2_OC,
+	MT6373_IRQ_VCN33_3_OC,
+	MT6373_IRQ_VCN18IO_OC,
+	MT6373_IRQ_VRF09_AIF_OC,
+	MT6373_IRQ_VRF12_AIF_OC,
+	MT6373_IRQ_VANT18_OC,
+	MT6373_IRQ_VSRAM_DIGRF_AIF_OC,
+	MT6373_IRQ_VMDDR_OC,
+	MT6373_IRQ_VEFUSE_OC,
+	MT6373_IRQ_VMCH_OC,
+	MT6373_IRQ_VMC_OC,
+	MT6373_IRQ_VIBR_OC,
+	MT6373_IRQ_VIO28_OC,
+	MT6373_IRQ_VFP_OC,
+	MT6373_IRQ_VTP_OC,
+	MT6373_IRQ_VSIM1_OC,
+	MT6373_IRQ_VSIM2_OC,
+	MT6373_IRQ_RCS0 = 56,
+	MT6373_IRQ_SPMI_CMD_ALERT,
+	MT6373_IRQ_BM_PROTREG = 62,
+	MT6373_IRQ_VRC_PROTREG,
+	MT6373_IRQ_BUCK_PROTREG = 64,
+	MT6373_IRQ_LDO_PROTREG,
+	MT6373_IRQ_PSC_PROTREG,
+	MT6373_IRQ_PLT_PROTREG,
+	MT6373_IRQ_HK_PROTREG,
+	MT6373_IRQ_SCK_PROTREG,
+	MT6373_IRQ_XPP_PROTREG,
+	MT6373_IRQ_TOP_PROTREG,
+	MT6373_IRQ_NR = 72,
+};
+
+#define MT6373_IRQ_BUCK_BASE MT6373_IRQ_VBUCK0_OC
+#define MT6373_IRQ_LDO_BASE MT6373_IRQ_VAUD18_OC
+#define MT6373_IRQ_MISC_BASE MT6373_IRQ_RCS0
+
+#define MT6373_IRQ_BUCK_BITS \
+	(MT6373_IRQ_VBUCK9_OC - MT6373_IRQ_BUCK_BASE + 1)
+#define MT6373_IRQ_LDO_BITS \
+	(MT6373_IRQ_VSIM2_OC - MT6373_IRQ_LDO_BASE + 1)
+#define MT6373_IRQ_MISC_BITS \
+	(MT6373_IRQ_TOP_PROTREG - MT6373_IRQ_MISC_BASE + 1)
+
+#define MT6373_TOP_GEN(sp) \
+{ \
+	.hwirq_base = MT6373_IRQ_##sp##_BASE, \
+	.num_int_regs =	((MT6373_IRQ_##sp##_BITS - 1) / MT6373_REG_WIDTH) + 1, \
+	.en_reg = MT6373_##sp##_TOP_INT_CON0, \
+	.en_reg_shift = 0x3, \
+	.sta_reg = MT6373_##sp##_TOP_INT_STATUS0, \
+	.sta_reg_shift = 0x1, \
+	.top_offset = MT6373_##sp##_TOP, \
+}
+
+#endif /* __MFD_MT6373_CORE_H__ */
diff --git a/include/linux/mfd/mt6373/registers.h b/include/linux/mfd/mt6373/registers.h
new file mode 100644
index 000000000000..05aef78abfdf
--- /dev/null
+++ b/include/linux/mfd/mt6373/registers.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ */
+
+
+#ifndef __MFD_MT6373_REGISTERS_H__
+#define __MFD_MT6373_REGISTERS_H__
+
+/* PMIC Registers */
+#define MT6373_TOPSTATUS                       0x1e
+#define MT6373_MISC_TOP_INT_CON0               0x3c
+#define MT6373_MISC_TOP_INT_CON1               0x3f
+#define MT6373_MISC_TOP_INT_STATUS0            0x48
+#define MT6373_MISC_TOP_INT_STATUS1            0x49
+#define MT6373_TOP_INT_MASK_CON0               0x4c
+#define MT6373_TOP_INT_MASK_CON0_SET           0x4d
+#define MT6373_TOP_INT_MASK_CON0_CLR           0x4e
+#define MT6373_TOP_INT_MASK_CON1               0x4f
+#define MT6373_TOP_INT_MASK_CON1_SET           0x50
+#define MT6373_TOP_INT_MASK_CON1_CLR           0x51
+#define MT6373_TOP_INT_STATUS0                 0x52
+#define MT6373_TOP_INT_STATUS1                 0x53
+#define MT6373_HK_TOP_INT_CON0                 0xf92
+#define MT6373_HK_TOP_INT_CON1                 0xf95
+#define MT6373_HK_TOP_INT_STATUS0              0xf9e
+#define MT6373_HK_TOP_INT_STATUS1              0xf9f
+#define MT6373_AUXADC_ADC4_L                   0x1090
+#define MT6373_AUXADC_ADC38_L                  0x10c4
+#define MT6373_AUXADC_ADC39_L                  0x10c6
+#define MT6373_AUXADC_ADC40_L                  0x10c8
+#define MT6373_AUXADC_ADC_CH12_L               0x10d2
+#define MT6373_AUXADC_ADC_CH12_H               0x10d3
+#define MT6373_AUXADC_RQST0                    0x1108
+#define MT6373_AUXADC_RQST1                    0x1109
+#define MT6373_AUXADC_RQST3                    0x110c
+#define MT6373_SDMADC_RQST0                    0x110e
+#define MT6373_SDMADC_CON0                     0x11c4
+#define MT6373_BUCK_TOP_INT_CON0               0x1411
+#define MT6373_BUCK_TOP_INT_CON1               0x1414
+#define MT6373_BUCK_TOP_INT_STATUS0            0x141d
+#define MT6373_BUCK_TOP_INT_STATUS1            0x141e
+#define MT6373_LDO_TOP_INT_CON0                0x1b10
+#define MT6373_LDO_TOP_INT_CON1                0x1b13
+#define MT6373_LDO_TOP_INT_CON2                0x1b16
+#define MT6373_LDO_TOP_INT_STATUS0             0x1b22
+#define MT6373_LDO_TOP_INT_STATUS1             0x1b23
+#define MT6373_LDO_TOP_INT_STATUS2             0x1b24
+#define MT6373_LDO_VMCH_CON0                   0x1cb1
+#define MT6373_LDO_VMCH_CON1                   0x1cb2
+#define MT6373_LDO_VMCH_CON2                   0x1cb3
+
+#endif /* __MFD_MT6373_REGISTERS_H__ */
-- 
2.46.0


