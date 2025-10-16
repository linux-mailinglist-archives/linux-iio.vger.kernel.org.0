Return-Path: <linux-iio+bounces-25136-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F440BE2E9D
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 12:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847951A64385
	for <lists+linux-iio@lfdr.de>; Thu, 16 Oct 2025 10:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EB93375D9;
	Thu, 16 Oct 2025 10:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QlUgMmw/"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBA3334361;
	Thu, 16 Oct 2025 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760611465; cv=none; b=BS6GJh/j7ienBfAZF/VEq7vwxcctxKTtZ4yHFRkHa1oRzAAQ48RYhrfd/SVlRTvL6P9nhxHdGVoBEwNmnsuICF671NgxRRJwrgA1VCIrBWhPSb4O7q0cI/pjQ2QY1//dzcw0LssISvVSwYb7p1zVVrXQNuC4cH7d0TUC2Ad+ToA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760611465; c=relaxed/simple;
	bh=N7ODaLqYcZSZMtIVtoBLdboOew23yBvfmL8UxHCI+OE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f04P4TVrlImVlnQUjmsOuWF4iUp0eLv4hbm3cLuq4AjC8RBWRVlrKFy9a6uURsxUm70js2xTxhX4QDiHBMM3t4+MoRA0yjg8khnJz9doeekQyqdu3sJD79yFzJz0OkZe5J2rRK450EgdThIEH4O4xqwzwEcOzODPU0H8xGH4uCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QlUgMmw/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760611462;
	bh=N7ODaLqYcZSZMtIVtoBLdboOew23yBvfmL8UxHCI+OE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QlUgMmw//MS3cgj0szHvxeEtO87uuF0UA6HRtHhYKAPhL88ovHCDWgkZSPyxoUjfd
	 KAcTeWyqCQV3QgQ0q03NnW4qbDXF8YXbrbPQvzdUwVNbJXW9rN6v3EcAzh9j6h7p5e
	 d3PgXilIA6cskw4Udb5WfDNiniGL8pYLuJM26ZiTTwxTS1fYfvv8pFTstckt75u4rB
	 OMmjEQNkxccM7ZYty9ydjRyew3ztqTmO0DFA4ya2WVnjeEavSELCtU12OC6TE3Fe+S
	 rQf8Dm0Z3EcgFr71NXCOP0kWYmHYORbWudUMibJ45ty378EDOoQVIMOwHZp5kxlcV2
	 5nWnnI5L6zPyg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2EC5417E0CF8;
	Thu, 16 Oct 2025 12:44:21 +0200 (CEST)
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
	wenst@chromium.org,
	casey.connolly@linaro.org,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v6 6/8] misc: qcom-coincell: Migrate to devm_spmi_subdevice_alloc_and_add()
Date: Thu, 16 Oct 2025 12:44:00 +0200
Message-ID: <20251016104402.338246-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016104402.338246-1-angelogioacchino.delregno@collabora.com>
References: <20251016104402.338246-1-angelogioacchino.delregno@collabora.com>
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

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/misc/Kconfig         |  2 ++
 drivers/misc/qcom-coincell.c | 38 +++++++++++++++++++++++++-----------
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index b9c11f67315f..f4c5e67192fb 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -291,6 +291,8 @@ config HP_ILO
 config QCOM_COINCELL
 	tristate "Qualcomm coincell charger support"
 	depends on MFD_SPMI_PMIC || COMPILE_TEST
+	depends on SPMI
+	select REGMAP_SPMI
 	help
 	  This driver supports the coincell block found inside of
 	  Qualcomm PMICs.  The coincell charger provides a means to
diff --git a/drivers/misc/qcom-coincell.c b/drivers/misc/qcom-coincell.c
index 3c57f7429147..49e38442b289 100644
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
@@ -71,19 +71,28 @@ static int qcom_coincell_chgr_config(struct qcom_coincell *chgr, int rset,
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
-	struct device_node *node = pdev->dev.of_node;
+	struct regmap_config qcom_coincell_regmap_config = {
+		.reg_bits = 16,
+		.val_bits = 8,
+		.max_register = 0x100,
+		.fast_io = true,
+	};
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	struct spmi_subdevice *sub_sdev;
+	struct spmi_device *sparent;
 	struct qcom_coincell chgr;
 	u32 rset = 0;
 	u32 vset = 0;
@@ -92,16 +101,22 @@ static int qcom_coincell_probe(struct platform_device *pdev)
 
 	chgr.dev = &pdev->dev;
 
-	chgr.regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	rc = of_property_read_u32(node, "reg", &qcom_coincell_regmap_config.reg_base);
+	if (rc)
+		return rc;
+
+	sparent = to_spmi_device(dev->parent);
+	sub_sdev = devm_spmi_subdevice_alloc_and_add(dev, sparent);
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
@@ -142,3 +157,4 @@ module_platform_driver(qcom_coincell_driver);
 
 MODULE_DESCRIPTION("Qualcomm PMIC coincell charger driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("SPMI");
-- 
2.51.0


