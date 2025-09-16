Return-Path: <linux-iio+bounces-24140-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 157AAB5911B
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 10:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E300A7A8A81
	for <lists+linux-iio@lfdr.de>; Tue, 16 Sep 2025 08:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ACC28D83E;
	Tue, 16 Sep 2025 08:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MFmwdz8E"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE4128AAEE;
	Tue, 16 Sep 2025 08:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758012309; cv=none; b=oJXV7dRmsMjaT3To30D0+QSDrW5UwoUuKp+wZNt3Hqua79h2hKj+zhml+Wjl6HJYapX+3ZUiYanRgcbC89vk0bwMG+z4/ylxu6e6R5GepainEp5GznDwRvFMvWFbj33g3LFFj/UcGh1ato1bB2+k232amJQfX38tOoiXJD48R9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758012309; c=relaxed/simple;
	bh=xchGWsN5lDpHTNX8N/MOujMjY8eEjH4N8kib1urAC9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GmpI2iinKnz/Iwi+h77pRd3DQRjO4XwuRCAE8LvK+/eDUJSCP0gIRsT+OVeVprUdwvZwDTuGLZUYIX9wZy+Zez7XhDXcPqc/sZ2emMi8fJ6+lJ+ANb/9h6CEquCQ3Ylp4e0nuL68BTptkgoLNqJs+rL50VYkzzB8f+5pbRbFfeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MFmwdz8E; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758012300;
	bh=xchGWsN5lDpHTNX8N/MOujMjY8eEjH4N8kib1urAC9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MFmwdz8E7vzsXrT73Vmmo3LFXLttSppJ4Lie42+WfpPjl5M34A74EhuFXRh/aZC/2
	 97LVYszaCdsH48VXkid2wcE+Ok+F07e6XD4+wlfhdG9vnCbstyx70Xr2P55pGLZPGC
	 x8T+Pg8759/91JhUnAITV79eI/zmiqKk2zN2jNprz7Uq1BMV8u7Lt/29OiCTk/7zbP
	 9rzj6aITxExv8ONH7dPirTE/Y+lZJNoQgzPQpF/1MWmZI+1Req9tGWaUbPtHMZuPgP
	 xQJ8HSQnd2SwoT46GvG+03TYZqF2jdJMcBRWUJ+nyWVho4Ms9GpiTM+vxQqmK0KGOS
	 zJrUA7XKQ8UPQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3D93D17E12B1;
	Tue, 16 Sep 2025 10:44:59 +0200 (CEST)
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
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 2/7] nvmem: qcom-spmi-sdam: Migrate to devm_spmi_subdevice_alloc_and_add()
Date: Tue, 16 Sep 2025 10:44:40 +0200
Message-ID: <20250916084445.96621-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916084445.96621-1-angelogioacchino.delregno@collabora.com>
References: <20250916084445.96621-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Qualcomm PMICs integrate a SDAM device, internally located in
a specific address range reachable through SPMI communication.

Instead of using the parent SPMI device (the main PMIC) as a kind
of syscon in this driver, register a new SPMI sub-device for SDAM
and initialize its own regmap with this sub-device's specific base
address, retrieved from the devicetree.

This allows to stop manually adding the register base address to
every R/W call in this driver, as this can be, and is now, handled
by the regmap API instead.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20250722101317.76729-3-angelogioacchino.delregno@collabora.com
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
Link: https://lore.kernel.org/r/20250730112645.542179-3-angelogioacchino.delregno@collabora.com
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/nvmem/qcom-spmi-sdam.c | 37 ++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/nvmem/qcom-spmi-sdam.c b/drivers/nvmem/qcom-spmi-sdam.c
index 4f1cca6eab71..9a4be20dfa9f 100644
--- a/drivers/nvmem/qcom-spmi-sdam.c
+++ b/drivers/nvmem/qcom-spmi-sdam.c
@@ -9,6 +9,7 @@
 #include <linux/nvmem-provider.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/spmi.h>
 
 #define SDAM_MEM_START			0x40
 #define REGISTER_MAP_ID			0x40
@@ -20,7 +21,6 @@
 struct sdam_chip {
 	struct regmap			*regmap;
 	struct nvmem_config		sdam_config;
-	unsigned int			base;
 	unsigned int			size;
 };
 
@@ -73,7 +73,7 @@ static int sdam_read(void *priv, unsigned int offset, void *val,
 		return -EINVAL;
 	}
 
-	rc = regmap_bulk_read(sdam->regmap, sdam->base + offset, val, bytes);
+	rc = regmap_bulk_read(sdam->regmap, offset, val, bytes);
 	if (rc < 0)
 		dev_err(dev, "Failed to read SDAM offset %#x len=%zd, rc=%d\n",
 						offset, bytes, rc);
@@ -100,7 +100,7 @@ static int sdam_write(void *priv, unsigned int offset, void *val,
 		return -EINVAL;
 	}
 
-	rc = regmap_bulk_write(sdam->regmap, sdam->base + offset, val, bytes);
+	rc = regmap_bulk_write(sdam->regmap, offset, val, bytes);
 	if (rc < 0)
 		dev_err(dev, "Failed to write SDAM offset %#x len=%zd, rc=%d\n",
 						offset, bytes, rc);
@@ -110,8 +110,17 @@ static int sdam_write(void *priv, unsigned int offset, void *val,
 
 static int sdam_probe(struct platform_device *pdev)
 {
+	struct regmap_config sdam_regmap_config = {
+		.reg_bits = 16,
+		.val_bits = 8,
+		.max_register = 0x100,
+		.fast_io = true,
+	};
 	struct sdam_chip *sdam;
 	struct nvmem_device *nvmem;
+	struct spmi_device *sparent;
+	struct spmi_subdevice *sub_sdev;
+	struct device *dev = &pdev->dev;
 	unsigned int val;
 	int rc;
 
@@ -119,19 +128,24 @@ static int sdam_probe(struct platform_device *pdev)
 	if (!sdam)
 		return -ENOMEM;
 
-	sdam->regmap = dev_get_regmap(pdev->dev.parent, NULL);
-	if (!sdam->regmap) {
-		dev_err(&pdev->dev, "Failed to get regmap handle\n");
-		return -ENXIO;
-	}
+	sparent = to_spmi_device(dev->parent);
+	sub_sdev = devm_spmi_subdevice_alloc_and_add(dev, sparent);
+	if (IS_ERR(sub_sdev))
+		return PTR_ERR(sub_sdev);
 
-	rc = of_property_read_u32(pdev->dev.of_node, "reg", &sdam->base);
+	rc = of_property_read_u32(dev->of_node, "reg", &sdam_regmap_config.reg_base);
 	if (rc < 0) {
 		dev_err(&pdev->dev, "Failed to get SDAM base, rc=%d\n", rc);
 		return -EINVAL;
 	}
 
-	rc = regmap_read(sdam->regmap, sdam->base + SDAM_SIZE, &val);
+	sdam->regmap = devm_regmap_init_spmi_ext(&sub_sdev->sdev, &sdam_regmap_config);
+	if (IS_ERR(sdam->regmap)) {
+		dev_err(&pdev->dev, "Failed to get regmap handle\n");
+		return PTR_ERR(sdam->regmap);
+	}
+
+	rc = regmap_read(sdam->regmap, SDAM_SIZE, &val);
 	if (rc < 0) {
 		dev_err(&pdev->dev, "Failed to read SDAM_SIZE rc=%d\n", rc);
 		return -EINVAL;
@@ -159,7 +173,7 @@ static int sdam_probe(struct platform_device *pdev)
 	}
 	dev_dbg(&pdev->dev,
 		"SDAM base=%#x size=%u registered successfully\n",
-		sdam->base, sdam->size);
+		sdam_regmap_config.reg_base, sdam->size);
 
 	return 0;
 }
@@ -181,3 +195,4 @@ module_platform_driver(sdam_driver);
 
 MODULE_DESCRIPTION("QCOM SPMI SDAM driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("SPMI");
-- 
2.51.0


