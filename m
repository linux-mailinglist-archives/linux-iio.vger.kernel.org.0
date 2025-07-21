Return-Path: <linux-iio+bounces-21799-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1BFB0BE3D
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 09:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4086516E1D2
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 07:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F96F288532;
	Mon, 21 Jul 2025 07:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="n8Sp8bxo"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5684E28726D;
	Mon, 21 Jul 2025 07:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753084548; cv=none; b=B3smrn7lgI0hcbJBDIC952TVET6Z7kPllGMVvVhQTFiNCQgdWhlVpXFrb/bg1z13uVMkbXQc5yx9w+DG3EPaStRwEct5AVoi+u0iqm1uJewygz0WZz2zm8/mgZ8nroQ+gSgIqUTyrT2krDXxO3JKWdZgkyOgI5mw4HUvS/7H0Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753084548; c=relaxed/simple;
	bh=fi7nmGU0pf9xh3UMutM9r5Cb3QhwcNCUIt79J9c8H3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VEZYitTGK7KPTl4RNPi2veeJLbSh6scvK57vu+0/IqrzGpPFjOy3nV7E1u8/NPQOHdwbpmpiSOyNA2H1QzFoVN+Ni52QQvgAsO3bqS2jscuS+7lqq+j/bgFdnexLOD+3w6roPWA4QHyVlPXXkGdBTOXJizIWBYL9HYZlsdFDHGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=n8Sp8bxo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753084544;
	bh=fi7nmGU0pf9xh3UMutM9r5Cb3QhwcNCUIt79J9c8H3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n8Sp8bxokZDcYtg86Gd+NAbWvBaXnRI83Jr3txsBY5EcbElzP+G5LGDsFAF8YpuNO
	 Rf4K13yhHX+13P94Of5Cf5f42jAZcdSwsLM7VUuE4pK2EY7NOQf9mmCXYRa5JV9Cfs
	 tOFY9zCfW6iijjhpwvEpy132bsaDfDhWqvYdf9sPD1rALE7ogX0Vk1cVOQ+57SfXmY
	 vVld8/smN3Ous0d9qC1/r4mQ2CE46rtfKlier2H0+UHH7Wh2qim5gnFEbqsI4ignrr
	 tYeSjutL8IA9sUSonNTFTlXCc6BS9Hh+rx+VL6F5p+4SLX8vxC2koo4TcQfutZPBkU
	 sRxxSnOdZe7bQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 924CC17E1544;
	Mon, 21 Jul 2025 09:55:43 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: sboyd@kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	arnd@arndb.de,
	gregkh@linuxfoundation.org,
	srini@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	sre@kernel.org,
	krzysztof.kozlowski@linaro.org,
	u.kleine-koenig@baylibre.com,
	angelogioacchino.delregno@collabora.com,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org,
	kernel@collabora.com,
	wenst@chromium.org
Subject: [PATCH v1 4/7] phy: qualcomm: eusb2-repeater: Migrate to devm_spmi_subdevice_alloc_and_add()
Date: Mon, 21 Jul 2025 09:55:22 +0200
Message-ID: <20250721075525.29636-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721075525.29636-1-angelogioacchino.delregno@collabora.com>
References: <20250721075525.29636-1-angelogioacchino.delregno@collabora.com>
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

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../phy/qualcomm/phy-qcom-eusb2-repeater.c    | 45 +++++++++++--------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
index e0f2acc8109c..f65437a85924 100644
--- a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
+++ b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
@@ -9,6 +9,7 @@
 #include <linux/regmap.h>
 #include <linux/of.h>
 #include <linux/phy/phy.h>
+#include <linux/spmi.h>
 
 /* eUSB2 status registers */
 #define EUSB2_RPTR_STATUS		0x08
@@ -55,7 +56,6 @@ struct eusb2_repeater {
 	struct phy *phy;
 	struct regulator_bulk_data *vregs;
 	const struct eusb2_repeater_cfg *cfg;
-	u32 base;
 	enum phy_mode mode;
 };
 
@@ -110,7 +110,6 @@ static int eusb2_repeater_init(struct phy *phy)
 	struct eusb2_repeater *rptr = phy_get_drvdata(phy);
 	struct device_node *np = rptr->dev->of_node;
 	struct regmap *regmap = rptr->regmap;
-	u32 base = rptr->base;
 	u32 poll_val;
 	int ret;
 	u8 val;
@@ -119,25 +118,25 @@ static int eusb2_repeater_init(struct phy *phy)
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
 	if (!of_property_read_u8(np, "qcom,tune-usb2-amplitude", &val))
-		regmap_write(regmap, base + EUSB2_TUNE_USB2_PREEM, val);
+		regmap_write(regmap, EUSB2_TUNE_USB2_PREEM, val);
 
 	if (!of_property_read_u8(np, "qcom,tune-usb2-disc-thres", &val))
-		regmap_write(regmap, base + EUSB2_TUNE_HSDISC, val);
+		regmap_write(regmap, EUSB2_TUNE_HSDISC, val);
 
 	if (!of_property_read_u8(np, "qcom,tune-usb2-preem", &val))
-		regmap_write(regmap, base + EUSB2_TUNE_IUSB2, val);
+		regmap_write(regmap, EUSB2_TUNE_IUSB2, val);
 
 	/* Wait for status OK */
-	ret = regmap_read_poll_timeout(regmap, base + EUSB2_RPTR_STATUS, poll_val,
+	ret = regmap_read_poll_timeout(regmap, EUSB2_RPTR_STATUS, poll_val,
 				       poll_val & RPTR_OK, 10, 5);
 	if (ret)
 		dev_err(rptr->dev, "initialization timed-out\n");
@@ -150,7 +149,6 @@ static int eusb2_repeater_set_mode(struct phy *phy,
 {
 	struct eusb2_repeater *rptr = phy_get_drvdata(phy);
 	struct regmap *regmap = rptr->regmap;
-	u32 base = rptr->base;
 
 	switch (mode) {
 	case PHY_MODE_USB_HOST:
@@ -159,8 +157,8 @@ static int eusb2_repeater_set_mode(struct phy *phy,
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
@@ -169,8 +167,8 @@ static int eusb2_repeater_set_mode(struct phy *phy,
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
@@ -195,11 +193,18 @@ static const struct phy_ops eusb2_repeater_ops = {
 
 static int eusb2_repeater_probe(struct platform_device *pdev)
 {
+	struct regmap_config eusb2_regmap_config = {
+		.reg_bits = 16,
+		.val_bits = 16,
+		.max_register = 0x100,
+		.fast_io = true
+	};
+	struct spmi_device *sparent;
 	struct eusb2_repeater *rptr;
+	struct spmi_subdevice *sub_sdev;
 	struct device *dev = &pdev->dev;
 	struct phy_provider *phy_provider;
 	struct device_node *np = dev->of_node;
-	u32 res;
 	int ret;
 
 	rptr = devm_kzalloc(dev, sizeof(*rptr), GFP_KERNEL);
@@ -213,15 +218,17 @@ static int eusb2_repeater_probe(struct platform_device *pdev)
 	if (!rptr->cfg)
 		return -EINVAL;
 
-	rptr->regmap = dev_get_regmap(dev->parent, NULL);
-	if (!rptr->regmap)
-		return -ENODEV;
+	sub_sdev = devm_spmi_subdevice_alloc_and_add(&pdev->dev, sparent);
+	if (IS_ERR(sub_sdev))
+		return PTR_ERR(sub_sdev);
 
-	ret = of_property_read_u32(np, "reg", &res);
+	ret = of_property_read_u32(np, "reg", &eusb2_regmap_config.reg_base);
 	if (ret < 0)
 		return ret;
 
-	rptr->base = res;
+	rptr->regmap = devm_regmap_init_spmi_ext(&sub_sdev->sdev, &eusb2_regmap_config);
+	if (IS_ERR(rptr->regmap))
+		return -ENODEV;
 
 	ret = eusb2_repeater_init_vregs(rptr);
 	if (ret < 0) {
-- 
2.50.1


