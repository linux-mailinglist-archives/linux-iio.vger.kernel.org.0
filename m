Return-Path: <linux-iio+bounces-25313-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC43BBF5421
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 10:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A8A618A2F05
	for <lists+linux-iio@lfdr.de>; Tue, 21 Oct 2025 08:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB09312810;
	Tue, 21 Oct 2025 08:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nHZTY9xH"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B014E248F47;
	Tue, 21 Oct 2025 08:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761035555; cv=none; b=lcCoGvaR6emgbBtlsynf9tKPdvVox6chonbHoPsJhr8s43eU/skkhhDWgVT9w4XKkZEPh22lqxC9xBAFkCLdZ7686R0Eznzc1X4xe47mBGRI1fW8DuIc1vslimR/+DdN7vp98xCq55c54i7naGpfUiMc38zWzjOcjna7+H3Rd6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761035555; c=relaxed/simple;
	bh=lRlOQobFGzBwJ1dco++Se12aYkLegtGpeMMHYZRNdMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fuFkbLZVE1NhhER/HJTB4wHHD5SJ4hrPduwMjCktr0gaa3ATd9NGjMyk5DpAXBses01ITU6FBVqdjQf/DSElgKIpBeObre92li7q0GGAiwJ3UrDrGP/Eti81hmswEYCRhz3XYcQImrr0x/IchUoJ1BnWouRfj0QHhwvh+WIVfUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nHZTY9xH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761035548;
	bh=lRlOQobFGzBwJ1dco++Se12aYkLegtGpeMMHYZRNdMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nHZTY9xHTt6D6zBFu/VR9I7zH8CUDvxUwhGX2VF2YAH75l1mnqYEUWNRNd63AsdSe
	 SGVMBCszMcXlLYhjiEBxN7Icf7EHK3/88y9O2TpjFgVsTZ3fOmPlGU7w2Slhdrzjnp
	 6z/QVK6v/zqYZ7i3Gvl3wn9EJ+sHUPfAyVXw+Z5+L3XX7IOjmVC8Dbs0fNGVnWYCE7
	 5Mecz/waWQhvDv5OEKQKukhQzFxXVxMGUwYjjtwiL012oN5glYW0cliXnGXdcJltGV
	 9Wuio3s825LBxbQ3Uod75MrP/xdy1SkO0Y7SyW1iSrC9R7P0HGPSXYPYPcYCrp+b07
	 omgN2cFF9tOGw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5E31B17E1418;
	Tue, 21 Oct 2025 10:32:27 +0200 (CEST)
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
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v7 06/10] power: reset: qcom-pon: Migrate to devm_spmi_subdevice_alloc_and_add()
Date: Tue, 21 Oct 2025 10:32:15 +0200
Message-ID: <20251021083219.17382-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251021083219.17382-1-angelogioacchino.delregno@collabora.com>
References: <20251021083219.17382-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Qualcomm PMICs integrates a Power On device supporting pwrkey
and resin along with the Android reboot reason action identifier.

Instead of using the parent SPMI device (the main PMIC) as a kind
of syscon in this driver, register a new SPMI sub-device for PON
and initialize its own regmap with this sub-device's specific base
address, retrieved from the devicetree.

This allows to stop manually adding the register base address to
every R/W call in this driver, as this can be, and is now, handled
by the regmap API instead.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/power/reset/qcom-pon.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/power/reset/qcom-pon.c b/drivers/power/reset/qcom-pon.c
index 7e108982a582..0e075a2e5e48 100644
--- a/drivers/power/reset/qcom-pon.c
+++ b/drivers/power/reset/qcom-pon.c
@@ -11,6 +11,7 @@
 #include <linux/reboot.h>
 #include <linux/reboot-mode.h>
 #include <linux/regmap.h>
+#include <linux/spmi.h>
 
 #define PON_SOFT_RB_SPARE		0x8f
 
@@ -22,7 +23,6 @@
 struct qcom_pon {
 	struct device *dev;
 	struct regmap *regmap;
-	u32 baseaddr;
 	struct reboot_mode_driver reboot_mode;
 	long reason_shift;
 };
@@ -35,7 +35,7 @@ static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot,
 	int ret;
 
 	ret = regmap_update_bits(pon->regmap,
-				 pon->baseaddr + PON_SOFT_RB_SPARE,
+				 PON_SOFT_RB_SPARE,
 				 GENMASK(7, pon->reason_shift),
 				 magic << pon->reason_shift);
 	if (ret < 0)
@@ -46,27 +46,42 @@ static int qcom_pon_reboot_mode_write(struct reboot_mode_driver *reboot,
 
 static int qcom_pon_probe(struct platform_device *pdev)
 {
+	struct regmap_config qcom_pon_regmap_config = {
+		.reg_bits = 16,
+		.val_bits = 8,
+		.max_register = 0x100,
+		.fast_io = true,
+	};
+	struct device *dev = &pdev->dev;
+	struct spmi_subdevice *sub_sdev;
+	struct spmi_device *sparent;
 	struct qcom_pon *pon;
 	long reason_shift;
 	int error;
 
+	if (!dev->parent)
+		return -ENODEV;
+
 	pon = devm_kzalloc(&pdev->dev, sizeof(*pon), GFP_KERNEL);
 	if (!pon)
 		return -ENOMEM;
 
 	pon->dev = &pdev->dev;
 
-	pon->regmap = dev_get_regmap(pdev->dev.parent, NULL);
-	if (!pon->regmap) {
-		dev_err(&pdev->dev, "failed to locate regmap\n");
-		return -ENODEV;
-	}
+	sparent = to_spmi_device(dev->parent);
+	sub_sdev = devm_spmi_subdevice_alloc_and_add(dev, sparent);
+	if (IS_ERR(sub_sdev))
+		return PTR_ERR(sub_sdev);
 
-	error = of_property_read_u32(pdev->dev.of_node, "reg",
-				     &pon->baseaddr);
+	error = of_property_read_u32(dev->of_node, "reg",
+				     &qcom_pon_regmap_config.reg_base);
 	if (error)
 		return error;
 
+	pon->regmap = devm_regmap_init_spmi_ext(&sub_sdev->sdev, &qcom_pon_regmap_config);
+	if (IS_ERR(pon->regmap))
+		return PTR_ERR(pon->regmap);
+
 	reason_shift = (long)of_device_get_match_data(&pdev->dev);
 
 	if (reason_shift != NO_REASON_SHIFT) {
@@ -106,3 +121,4 @@ module_platform_driver(qcom_pon_driver);
 
 MODULE_DESCRIPTION("Qualcomm Power On driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("SPMI");
-- 
2.51.1


