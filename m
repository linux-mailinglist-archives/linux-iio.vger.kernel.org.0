Return-Path: <linux-iio+bounces-21300-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7989AF76D1
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 16:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E4B17AE6F
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 14:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E5B2E9EC6;
	Thu,  3 Jul 2025 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="isfIq4LF"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F393A2E7185;
	Thu,  3 Jul 2025 14:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551914; cv=none; b=f5qWn+OpQyGFv2NE34DJazVESRTs9eBFjHWul6dBF3pGTZVti0+O2Ao1h/wSt1SNGoubny3n4dMiKOB2ojcDYUQDywnvTE4cPvBvt8UU5vbJTCcV4YlDlsH3+xIl+npyJmF/rY3sgooB5ubVLlodEXByuUW7stcmPjCA4OHttJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551914; c=relaxed/simple;
	bh=dUr3Q+DSchYobd41/4+P5VYa5M9JhY9sPEfGAIXPGDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oaWYXzdFcDHD2G416Uk0EfCO9URECCesfLNymCk6AS4ja7uqYwD6Fhd0N2bpXzCnOZnoDIVJDoxt6/xFnGGTDOcHYydiw4SdEfeOkR5Px9DhQlkWe15qZVQXGkXMuMgbm0h6ncBSlLLy5o0/dVCKmriMUIMDhPAbTl2v9g2iBxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=isfIq4LF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751551911;
	bh=dUr3Q+DSchYobd41/4+P5VYa5M9JhY9sPEfGAIXPGDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=isfIq4LFKpUwnFve/+7L+1g1y0jJtzUA1KvwcD0OpSWdmNSzaeFTdw1Z2H2NmwnO/
	 1T7PREN51tCA438ivgHIANdjp9NQyEhQ88d2oAy0uAxcMUvQt4w7Pilaf2qp48ENmF
	 P966iulAN1DIHLfCIqC7K49BqSb6qO/IiS929HrFjkMYL9cX5tZiZ9xQWwf1ZKznWu
	 OUCioz6/4bzAzxilj0mqgk8gg5H/7RpPT9qbh7iwC+cpWFVTjJ0/idfmK0bZEIXqRx
	 LMop5M1e7FNa7PCOmimxysKvUvEpsAY9qV+99Z8RkwpR9IlczEi7Npg8lgQgP1PP8c
	 ymPpzzbhzAHWw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 513EA17E09C6;
	Thu,  3 Jul 2025 16:11:50 +0200 (CEST)
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
	kernel@collabora.com,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>
Subject: [PATCH v2 2/6] dt-bindings: iio: adc: mt6359: Add MT6373 PMIC AuxADC
Date: Thu,  3 Jul 2025 16:11:42 +0200
Message-ID: <20250703141146.171431-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703141146.171431-1-angelogioacchino.delregno@collabora.com>
References: <20250703141146.171431-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a compatible and channel bindings for MediaTek's MT6373 PMIC,
featuring an Auxiliary ADC IP with 15 ADC channels for external
(SoC) temperatures and external voltage inputs.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
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


