Return-Path: <linux-iio+bounces-27729-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A6AD1D8F0
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29BF630115F3
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 09:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98841389DF9;
	Wed, 14 Jan 2026 09:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="man/930Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94CD3876D7;
	Wed, 14 Jan 2026 09:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768382880; cv=none; b=Rc+d7xQXUvErddQlGDto7JzvCS1HajpZWz8APfCjQ+GKDfFDjidhimmCN/GiJC26aMqBtB59t+CJJnQgI2F98UH33JbIcIMfbHvQDQ2P/F1IO7YMWRt2Zo+eMZYVqYuwqQ+xuhT7TRhDHQG5yBTs0Zq8aHKErOHZRT69V00N/KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768382880; c=relaxed/simple;
	bh=+3CW85O2WIOnxdfyGAv+wZCMXlAgE30diiAWWctx5GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZUT6y1GJVfpV3+7iVvQiyX4ZoWauHgjpOsaVlxl7ozOOwzacalGTBQlmHQ+FxPzeoklhob7q4dlLJe0xCHmvli3Yq66JtwPOVX13UfUsKlEo9fkY9Z73d0dXpveVgT29WHOZ9xwCMc1jBceKxmgoeOwRCnFcUgXKassiva5StA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=man/930Y; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1768382876;
	bh=+3CW85O2WIOnxdfyGAv+wZCMXlAgE30diiAWWctx5GQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=man/930YmxetzB2PbDx0E3YZBxPRXuXkxHuq8fn75Pn+nYmF02ah+zMpmBTVTpFPI
	 mMShArRoXRaIX08YVcSvdMYKu+Y+hpfKQXKbambzBA3kmcnBhw5PVEmdOHZ4Q+JXzO
	 ts8rKjz3+ZAY2xPurl+sDTfLta7LJLqh7hH3mL+mYCz2tWET5SrBNt4KkV+7CQhu50
	 9H86cXxTiNIM4zGQQ09EfiXQzxKTsPIwORoM8uRNq2lIT4yN8cFWhNerEgGN/GegND
	 7GdKnfM3dkQpmss6i5liqxBWc5y1PK5B8DD+FdPET4SVfk0cb29KX4fgRTGV5fvd5q
	 r4o2lcZDgQ9BA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6F23417E1543;
	Wed, 14 Jan 2026 10:27:55 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	srini@kernel.org,
	vkoul@kernel.org,
	neil.armstrong@linaro.org,
	sre@kernel.org,
	sboyd@kernel.org,
	angelogioacchino.delregno@collabora.com,
	krzk@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com,
	quic_wcheng@quicinc.com,
	melody.olvera@oss.qualcomm.com,
	quic_nsekar@quicinc.com,
	ivo.ivanov.ivanov1@gmail.com,
	abelvesa@kernel.org,
	luca.weiss@fairphone.com,
	konrad.dybcio@oss.qualcomm.com,
	mitltlatltl@gmail.com,
	krishna.kurapati@oss.qualcomm.com,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com,
	Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v8 07/10] phy: qualcomm: eusb2-repeater: Migrate to devm_spmi_subdevice_alloc_and_add()
Date: Wed, 14 Jan 2026 10:27:39 +0100
Message-ID: <20260114092742.13231-8-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260114092742.13231-1-angelogioacchino.delregno@collabora.com>
References: <20260114092742.13231-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Qualcomm PMICs integrate an USB Repeater device, used to
convert between eUSB2 and USB 2.0 signaling levels, reachable
in a specific address range over SPMI.

Instead of using the parent SPMI device (the main PMIC) as a kind
of syscon in this driver, register a new SPMI sub-device for EUSB2
and initialize its own regmap with this sub-device's specific base
address, retrieved from the devicetree.

This allows to stop manually adding the register base address to
every R/W call in this driver, as this can be, and is now, handled
by the regmap API instead.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/phy/qualcomm/Kconfig                  |  2 +
 .../phy/qualcomm/phy-qcom-eusb2-repeater.c    | 55 ++++++++++++-------
 2 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
index 60a0ead127fa..902a788f35f1 100644
--- a/drivers/phy/qualcomm/Kconfig
+++ b/drivers/phy/qualcomm/Kconfig
@@ -128,7 +128,9 @@ config PHY_QCOM_QUSB2
 config PHY_QCOM_EUSB2_REPEATER
 	tristate "Qualcomm PMIC eUSB2 Repeater Driver"
 	depends on OF && (ARCH_QCOM || COMPILE_TEST)
+	depends on SPMI
 	select GENERIC_PHY
+	select REGMAP_SPMI
 	help
 	  Enable support for the USB high-speed eUSB2 repeater on Qualcomm
 	  PMICs. The repeater is paired with a Synopsys or M31 eUSB2 Phy
diff --git a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
index efeec4709a15..bf6e1f96d31c 100644
--- a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
+++ b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
@@ -9,6 +9,7 @@
 #include <linux/regmap.h>
 #include <linux/of.h>
 #include <linux/phy/phy.h>
+#include <linux/spmi.h>
 
 /* eUSB2 status registers */
 #define EUSB2_RPTR_STATUS		0x08
@@ -66,7 +67,6 @@ struct eusb2_repeater {
 	struct phy *phy;
 	struct regulator_bulk_data *vregs;
 	const struct eusb2_repeater_cfg *cfg;
-	u32 base;
 	enum phy_mode mode;
 };
 
@@ -143,7 +143,6 @@ static int eusb2_repeater_init(struct phy *phy)
 	struct eusb2_repeater *rptr = phy_get_drvdata(phy);
 	struct device_node *np = rptr->dev->of_node;
 	struct regmap *regmap = rptr->regmap;
-	u32 base = rptr->base;
 	u32 poll_val;
 	s32 dt_val;
 	int ret;
@@ -154,37 +153,37 @@ static int eusb2_repeater_init(struct phy *phy)
 	if (ret)
 		return ret;
 
-	regmap_write(regmap, base + EUSB2_EN_CTL1, EUSB2_RPTR_EN);
+	regmap_write(regmap, EUSB2_EN_CTL1, EUSB2_RPTR_EN);
 
 	/* Write registers from init table */
 	for (int i = 0; i < rptr->cfg->init_tbl_num; i++)
-		regmap_write(regmap, base + rptr->cfg->init_tbl[i].reg,
+		regmap_write(regmap, rptr->cfg->init_tbl[i].reg,
 			     rptr->cfg->init_tbl[i].value);
 
 	/* Override registers from devicetree values */
 	if (!of_property_read_u8(np, "qcom,tune-usb2-preem", &val))
-		regmap_write(regmap, base + EUSB2_TUNE_USB2_PREEM, val);
+		regmap_write(regmap, EUSB2_TUNE_USB2_PREEM, val);
 
 	if (!of_property_read_u8(np, "qcom,tune-usb2-disc-thres", &val))
-		regmap_write(regmap, base + EUSB2_TUNE_HSDISC, val);
+		regmap_write(regmap, EUSB2_TUNE_HSDISC, val);
 
 	if (!of_property_read_u8(np, "qcom,tune-usb2-amplitude", &val))
-		regmap_write(regmap, base + EUSB2_TUNE_IUSB2, val);
+		regmap_write(regmap, EUSB2_TUNE_IUSB2, val);
 
 	if (!of_property_read_u8(np, "qcom,tune-res-fsdif", &val))
-		regmap_write(regmap, base + EUSB2_TUNE_RES_FSDIF, val);
+		regmap_write(regmap, EUSB2_TUNE_RES_FSDIF, val);
 
 	if (!of_property_read_s32(np, "qcom,squelch-detector-bp", &dt_val)) {
 		for (i = 0; i < ARRAY_SIZE(squelch_detector); i++) {
 			if (squelch_detector[i] == dt_val) {
-				regmap_write(regmap, base + EUSB2_TUNE_SQUELCH_U, i);
+				regmap_write(regmap, EUSB2_TUNE_SQUELCH_U, i);
 				break;
 			}
 		}
 	}
 
 	/* Wait for status OK */
-	ret = regmap_read_poll_timeout(regmap, base + EUSB2_RPTR_STATUS, poll_val,
+	ret = regmap_read_poll_timeout(regmap, EUSB2_RPTR_STATUS, poll_val,
 				       poll_val & RPTR_OK, 10, 5);
 	if (ret)
 		dev_err(rptr->dev, "initialization timed-out\n");
@@ -197,7 +196,6 @@ static int eusb2_repeater_set_mode(struct phy *phy,
 {
 	struct eusb2_repeater *rptr = phy_get_drvdata(phy);
 	struct regmap *regmap = rptr->regmap;
-	u32 base = rptr->base;
 
 	switch (mode) {
 	case PHY_MODE_USB_HOST:
@@ -206,8 +204,8 @@ static int eusb2_repeater_set_mode(struct phy *phy,
 		 * per eUSB 1.2 Spec. Below implement software workaround until
 		 * PHY and controller is fixing seen observation.
 		 */
-		regmap_write(regmap, base + EUSB2_FORCE_EN_5, F_CLK_19P2M_EN);
-		regmap_write(regmap, base + EUSB2_FORCE_VAL_5, V_CLK_19P2M_EN);
+		regmap_write(regmap, EUSB2_FORCE_EN_5, F_CLK_19P2M_EN);
+		regmap_write(regmap, EUSB2_FORCE_VAL_5, V_CLK_19P2M_EN);
 		break;
 	case PHY_MODE_USB_DEVICE:
 		/*
@@ -216,8 +214,8 @@ static int eusb2_repeater_set_mode(struct phy *phy,
 		 * repeater doesn't clear previous value due to shared
 		 * regulators (say host <-> device mode switch).
 		 */
-		regmap_write(regmap, base + EUSB2_FORCE_EN_5, 0);
-		regmap_write(regmap, base + EUSB2_FORCE_VAL_5, 0);
+		regmap_write(regmap, EUSB2_FORCE_EN_5, 0);
+		regmap_write(regmap, EUSB2_FORCE_VAL_5, 0);
 		break;
 	default:
 		return -EINVAL;
@@ -242,13 +240,23 @@ static const struct phy_ops eusb2_repeater_ops = {
 
 static int eusb2_repeater_probe(struct platform_device *pdev)
 {
+	struct regmap_config eusb2_regmap_config = {
+		.reg_bits = 16,
+		.val_bits = 8,
+		.max_register = 0xff,
+		.fast_io = true,
+	};
+	struct spmi_device *sparent;
 	struct eusb2_repeater *rptr;
+	struct spmi_subdevice *sub_sdev;
 	struct device *dev = &pdev->dev;
 	struct phy_provider *phy_provider;
 	struct device_node *np = dev->of_node;
-	u32 res;
 	int ret;
 
+	if (!dev->parent)
+		return -ENODEV;
+
 	rptr = devm_kzalloc(dev, sizeof(*rptr), GFP_KERNEL);
 	if (!rptr)
 		return -ENOMEM;
@@ -260,15 +268,21 @@ static int eusb2_repeater_probe(struct platform_device *pdev)
 	if (!rptr->cfg)
 		return -EINVAL;
 
-	rptr->regmap = dev_get_regmap(dev->parent, NULL);
-	if (!rptr->regmap)
+	sparent = to_spmi_device(dev->parent);
+	if (!sparent)
 		return -ENODEV;
 
-	ret = of_property_read_u32(np, "reg", &res);
+	sub_sdev = devm_spmi_subdevice_alloc_and_add(dev, sparent);
+	if (IS_ERR(sub_sdev))
+		return PTR_ERR(sub_sdev);
+
+	ret = device_property_read_u32(dev, "reg", &eusb2_regmap_config.reg_base);
 	if (ret < 0)
 		return ret;
 
-	rptr->base = res;
+	rptr->regmap = devm_regmap_init_spmi_ext(&sub_sdev->sdev, &eusb2_regmap_config);
+	if (IS_ERR(rptr->regmap))
+		return -ENODEV;
 
 	ret = eusb2_repeater_init_vregs(rptr);
 	if (ret < 0) {
@@ -335,3 +349,4 @@ module_platform_driver(eusb2_repeater_driver);
 
 MODULE_DESCRIPTION("Qualcomm PMIC eUSB2 Repeater driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("SPMI");
-- 
2.52.0


