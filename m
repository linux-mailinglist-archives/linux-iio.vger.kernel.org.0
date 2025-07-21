Return-Path: <linux-iio+bounces-21800-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56B7B0BE43
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 09:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5789C3AB094
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 07:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC54A288C96;
	Mon, 21 Jul 2025 07:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Zyw1jUnc"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7032882B9;
	Mon, 21 Jul 2025 07:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753084549; cv=none; b=TExnsGo/DFYuYlJWMN4b/d7EKPt/yvUK1YQwvU6mkH4xgobzF17aZT6dzu4vGF7rgQwuQCs3GBAlv5J0P2cPsGnb+i+qzVFxXo8oMAb9tjWUCwbJq42stAfQzXlJsKrqw+fNMcLiCHJ1ub0J/DusAQYWVxh99LKoAbUMTwpJaz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753084549; c=relaxed/simple;
	bh=RLmLcPXaij1NGQOtTbMIV2wvgFwfpsIrsEIiLoGmT0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BpEmE7tQ52PIl2/D0LnTz34lEs5QmQoFzxK+nd5OETdphCHtSsBb1f/ceW38rHzFKEsIY9A3fd8YwcStLTwwdhB6/MutFr2niQCcnXnC0WIUssbpntCuiuzw7Xiiq2hV6RXawF2k/V0/1OByOB4Kps3/X3P2z9ZAdtm36tebixM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Zyw1jUnc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753084546;
	bh=RLmLcPXaij1NGQOtTbMIV2wvgFwfpsIrsEIiLoGmT0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zyw1jUncXekn3BweUTM5jctGCq89z4kmu3OXNAVAiHjn8G6/br1bYCM/DBkx3NQbc
	 P2hTJoJq+ThfEiUz3SUnFKYaYAo5mYrSK45G79i527Oet/VAzu8+t7rC4SGcv3SzF1
	 kjdGFPSPF9zh1ic2Hg+XZr25naE1DninatjrczFZ6870XCE+Zc5SsWjTHr02p9HwT6
	 3BCcFh52rMpita02dB7uR5dW6A7baJdhD1/0Fsh5Lnp1NRBx0WmBQSJJu6qwc15JCb
	 3Qs65yDNRNbdLR+lAd3RqDMuV4Zrjv49r5/o2xWxtJ0Fjf5WpOHTEku95OjKkAxD3K
	 2v//hmeargg0Q==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E525017E154C;
	Mon, 21 Jul 2025 09:55:44 +0200 (CEST)
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
Subject: [PATCH v1 5/7] misc: qcom-coincell: Migrate to devm_spmi_subdevice_alloc_and_add()
Date: Mon, 21 Jul 2025 09:55:23 +0200
Message-ID: <20250721075525.29636-6-angelogioacchino.delregno@collabora.com>
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

Some Qualcomm PMICs integrate a charger for coincells, usually
powering an RTC when external (or main battery) power is missing.

Instead of using the parent SPMI device (the main PMIC) as a kind
of syscon in this driver, register a new SPMI sub-device and
initialize its own regmap with this sub-device's specific base
address, retrieved from the devicetree.

This allows to stop manually adding the register base address to
every R/W call in this driver, as this can be, and is now, handled
by the regmap API instead.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/misc/qcom-coincell.c | 37 ++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/qcom-coincell.c b/drivers/misc/qcom-coincell.c
index 3c57f7429147..2a4788ed9e4f 100644
--- a/drivers/misc/qcom-coincell.c
+++ b/drivers/misc/qcom-coincell.c
@@ -9,11 +9,11 @@
 #include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/platform_device.h>
+#include <linux/spmi.h>
 
 struct qcom_coincell {
 	struct device	*dev;
 	struct regmap	*regmap;
-	u32		base_addr;
 };
 
 #define QCOM_COINCELL_REG_RSET		0x44
@@ -35,7 +35,7 @@ static int qcom_coincell_chgr_config(struct qcom_coincell *chgr, int rset,
 	/* if disabling, just do that and skip other operations */
 	if (!enable)
 		return regmap_write(chgr->regmap,
-			  chgr->base_addr + QCOM_COINCELL_REG_ENABLE, 0);
+			  QCOM_COINCELL_REG_ENABLE, 0);
 
 	/* find index for current-limiting resistor */
 	for (i = 0; i < ARRAY_SIZE(qcom_rset_map); i++)
@@ -58,7 +58,7 @@ static int qcom_coincell_chgr_config(struct qcom_coincell *chgr, int rset,
 	}
 
 	rc = regmap_write(chgr->regmap,
-			  chgr->base_addr + QCOM_COINCELL_REG_RSET, i);
+			  QCOM_COINCELL_REG_RSET, i);
 	if (rc) {
 		/*
 		 * This is mainly to flag a bad base_addr (reg) from dts.
@@ -71,19 +71,27 @@ static int qcom_coincell_chgr_config(struct qcom_coincell *chgr, int rset,
 	}
 
 	rc = regmap_write(chgr->regmap,
-		chgr->base_addr + QCOM_COINCELL_REG_VSET, j);
+		QCOM_COINCELL_REG_VSET, j);
 	if (rc)
 		return rc;
 
 	/* set 'enable' register */
 	return regmap_write(chgr->regmap,
-			    chgr->base_addr + QCOM_COINCELL_REG_ENABLE,
+			    QCOM_COINCELL_REG_ENABLE,
 			    QCOM_COINCELL_ENABLE);
 }
 
 static int qcom_coincell_probe(struct platform_device *pdev)
 {
+	struct regmap_config qcom_coincell_regmap_config = {
+		.reg_bits = 16,
+		.val_bits = 16,
+		.max_register = 0x100,
+		.fast_io = true
+	};
 	struct device_node *node = pdev->dev.of_node;
+	struct spmi_subdevice *sub_sdev;
+	struct spmi_device *sparent;
 	struct qcom_coincell chgr;
 	u32 rset = 0;
 	u32 vset = 0;
@@ -92,16 +100,25 @@ static int qcom_coincell_probe(struct platform_device *pdev)
 
 	chgr.dev = &pdev->dev;
 
-	chgr.regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	rc = of_property_read_u32(node, "reg", &qcom_coincell_regmap_config.reg_base);
+	if (rc)
+		return rc;
+
+	sparent = to_spmi_device(pdev->dev.parent);
+	if (!sparent)
+		return -ENODEV;
+
+	sub_sdev = devm_spmi_subdevice_alloc_and_add(&pdev->dev, sparent);
+	if (IS_ERR(sub_sdev))
+		return PTR_ERR(sub_sdev);
+
+	chgr.regmap = devm_regmap_init_spmi_ext(&sub_sdev->sdev,
+						&qcom_coincell_regmap_config);
 	if (!chgr.regmap) {
 		dev_err(chgr.dev, "Unable to get regmap\n");
 		return -EINVAL;
 	}
 
-	rc = of_property_read_u32(node, "reg", &chgr.base_addr);
-	if (rc)
-		return rc;
-
 	enable = !of_property_read_bool(node, "qcom,charger-disable");
 
 	if (enable) {
-- 
2.50.1


