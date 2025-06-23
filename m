Return-Path: <linux-iio+bounces-20904-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6FAAE3EE8
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 14:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67959176DAD
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 12:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387E924DD11;
	Mon, 23 Jun 2025 12:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JupY+hcR"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB4124C060;
	Mon, 23 Jun 2025 12:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680038; cv=none; b=PRLv1mm6eFAPZRvEJd4fBgGySad94sp5AYzQeU9pXDstq1mY+snGyzU7uZ074CTgb6e0exLHiWst2Y13JSwPiAClWvi0sVLHTQgI8a2vjLvnyrW5YM2V9LxNjPOg+aTyNKfHHEo0r/X65L95aDgqxlsDJEdM9Ulldtcz3Od5xYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680038; c=relaxed/simple;
	bh=2uQyRTyYImsaB6rg/eF5AnNWNFNbbx7EBqAYScAL9oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRl4VIXmzeN6CKY6qfeh25yJDh2BXrOjT5iQK/EDsaC+KKrwtAMAo6lPoj3BQ9gyeWUYMLOp8+1GxgUtTZX30/pclytDSF9TpwYg19VYy5xYfkENzoxefiCgX7BRwmozPHqCg7x4Tu6p3qYlnFITX5bGpeKEZlX9/LP4K3apiIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JupY+hcR; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750680034;
	bh=2uQyRTyYImsaB6rg/eF5AnNWNFNbbx7EBqAYScAL9oM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JupY+hcRSm70R2EaDl3rvNIfdeDsGMmppJrxTvFLnfjDS0L+aUnjD7MpW+RFrKirW
	 TJW3AMRY9rSFRR6VCmqq+MNqLIRUryhi1U2jME/LL+Ar9g4/kYkQVjDw9HazHKGIhi
	 hT4t9DnLqxPv7wmtSU1RfLwX3BE3LbFB7t26PELX0m4EvtSDCWpf1G4UVjADm99apJ
	 blFzznnp6D+J+DDCIFxwjfcnH4oYedSU/LFnoi0LXnUjwJLqvwTL9kiHSSlPdhd4Nm
	 6EHozb44q1bKdLKwasACeQztXCWZShIqBs6Quz64dfbHQORs6s8C30RffG/Ll/6kfF
	 5iKOqHmZIfKyA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B3C8D17E1560;
	Mon, 23 Jun 2025 14:00:33 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v1 2/5] dt-bindings: iio: adc: mt6359: Add bindings for MT6373 PMIC AuxADC
Date: Mon, 23 Jun 2025 14:00:25 +0200
Message-ID: <20250623120028.108809-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623120028.108809-1-angelogioacchino.delregno@collabora.com>
References: <20250623120028.108809-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compatible and channel bindings for MediaTek's MT6373 PMIC,
featuring an Auxiliary ADC IP with 15 ADC channels for external
(SoC) temperatures and external voltage inputs.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../iio/adc/mediatek,mt6359-auxadc.yaml       |  1 +
 .../iio/adc/mediatek,mt6373-auxadc.h          | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6373-auxadc.h

diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
index a94429477e46..5d4ab701f51a 100644
--- a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
@@ -23,6 +23,7 @@ properties:
       - mediatek,mt6358-auxadc
       - mediatek,mt6359-auxadc
       - mediatek,mt6363-auxadc
+      - mediatek,mt6373-auxadc
 
   "#io-channel-cells":
     const: 1
diff --git a/include/dt-bindings/iio/adc/mediatek,mt6373-auxadc.h b/include/dt-bindings/iio/adc/mediatek,mt6373-auxadc.h
new file mode 100644
index 000000000000..17cab86d355e
--- /dev/null
+++ b/include/dt-bindings/iio/adc/mediatek,mt6373-auxadc.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+
+#ifndef _DT_BINDINGS_MEDIATEK_MT6373_AUXADC_H
+#define _DT_BINDINGS_MEDIATEK_MT6373_AUXADC_H
+
+/* ADC Channel Index */
+#define MT6373_AUXADC_CHIP_TEMP		0
+#define MT6373_AUXADC_VCORE_TEMP	1
+#define MT6373_AUXADC_VPROC_TEMP	2
+#define MT6373_AUXADC_VGPU_TEMP		3
+#define MT6373_AUXADC_VIN1		4
+#define MT6373_AUXADC_VIN2		5
+#define MT6373_AUXADC_VIN3		6
+#define MT6373_AUXADC_VIN4		7
+#define MT6373_AUXADC_VIN5		8
+#define MT6373_AUXADC_VIN6		9
+#define MT6373_AUXADC_VIN7		10
+
+#endif
-- 
2.49.0


