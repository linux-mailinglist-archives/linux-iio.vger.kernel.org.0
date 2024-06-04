Return-Path: <linux-iio+bounces-5752-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EFA8FB237
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 14:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32A7DB234B5
	for <lists+linux-iio@lfdr.de>; Tue,  4 Jun 2024 12:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B348146A72;
	Tue,  4 Jun 2024 12:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ReHSnQbx"
X-Original-To: linux-iio@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096A3146006;
	Tue,  4 Jun 2024 12:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504219; cv=none; b=rX32lXpEPOBGFxqtFId/UChIaisIOPodUXLVhXzl6Zw8XlRNUaQBraAs4bsnpKXvVjoicmOdNIshrHU9Eh3Nd94kNvzmf/bgDUoh1qeIwsYwCcC/CIh7vxgvW78k2zMD1Y2kqHc4KPcpC11arUjepDRMk46ezpYIi26wN+DlFRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504219; c=relaxed/simple;
	bh=NmgU/fSBCXlvV9b915m9J2ArWT5VcY56DHnNpeH6o44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNmIUru5DBrs22ZtmN1fWzJXPapPubwcJD/PbhT0RrAq5xeLoOTtUraH29XiFP5tOQmXKLVkL4K/AGc7BNyiPhS4mIl/QslNM/Bl8auRI9XMDAiQQmUWxWqMZeLVwEmgcx/isI2vOIHKV5Muq6Hit4zlUHBi9Y6yM4IfkMOKMc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ReHSnQbx; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717504216;
	bh=NmgU/fSBCXlvV9b915m9J2ArWT5VcY56DHnNpeH6o44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ReHSnQbxWGyZLMNFUpCKsg9MVCobgpAZI5zJHlO9gIDiTGs3XzRBhvT9WNtqd9rzz
	 FM0e3SBAliNRfnHVAG8jhR+LkndQSuMxVlAS7xhZDgTJSqyQl5bRB/Slqo09LDC4zz
	 4a45DKZBXo4gbnij3Szhk66Co9ItiOQtAcefUYJqnUpRExDZKRVU0XLfkWkaEvNQ1e
	 QWFTIwxEkD29Y9z7Qcswlf8iSokPbAuPUjytAiRj3WhNvWojRP9nW2OtM1uV9S8nYN
	 E/T2oJbVKKHqG53CniXg+aJ+lw7YaDVjayYvrElFexxxg1zRAh9y8e83PMembtj2QN
	 Xp8X23K3SPacg==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B3D3737821A8;
	Tue,  4 Jun 2024 12:30:14 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	lee@kernel.org,
	andy@kernel.org,
	nuno.sa@analog.com,
	bigunclemax@gmail.com,
	dlechner@baylibre.com,
	marius.cristea@microchip.com,
	marcelo.schmitt@analog.com,
	fr0st61te@gmail.com,
	mitrutzceclan@gmail.com,
	mike.looijmans@topic.nl,
	marcus.folkesson@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	andy.shevchenko@gmail.com,
	kernel@collabora.com
Subject: [PATCH v2 1/5] dt-bindings: iio: adc: Add MediaTek MT6359 PMIC AUXADC
Date: Tue,  4 Jun 2024 14:30:04 +0200
Message-ID: <20240604123008.327424-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604123008.327424-1-angelogioacchino.delregno@collabora.com>
References: <20240604123008.327424-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new binding for the MT6350 Series (MT6357/8/9) PMIC AUXADC,
providing various ADC channels for both internal temperatures and
voltages, audio accessory detection (hp/mic/hp+mic and buttons,
usually on a 3.5mm jack) other than some basic battery statistics
on boards where the battery is managed by this PMIC.

Also add the necessary dt-binding headers for devicetree consumers.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../iio/adc/mediatek,mt6359-auxadc.yaml       | 33 +++++++++++++++++++
 .../iio/adc/mediatek,mt6357-auxadc.h          | 21 ++++++++++++
 .../iio/adc/mediatek,mt6358-auxadc.h          | 22 +++++++++++++
 .../iio/adc/mediatek,mt6359-auxadc.h          | 22 +++++++++++++
 4 files changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
 create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6357-auxadc.h
 create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6358-auxadc.h
 create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6359-auxadc.h

diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
new file mode 100644
index 000000000000..6497c416094d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/mediatek,mt6359-auxadc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT6350 series PMIC AUXADC
+
+maintainers:
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+
+description:
+  The Auxiliary Analog/Digital Converter (AUXADC) is an ADC found
+  in some MediaTek PMICs, performing various PMIC related measurements
+  such as battery and PMIC internal voltage regulators temperatures,
+  accessory detection resistance (usually, for a 3.5mm audio jack)
+  other than voltages for various PMIC internal components.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt6357-auxadc
+      - mediatek,mt6358-auxadc
+      - mediatek,mt6359-auxadc
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - "#io-channel-cells"
+
+additionalProperties: false
diff --git a/include/dt-bindings/iio/adc/mediatek,mt6357-auxadc.h b/include/dt-bindings/iio/adc/mediatek,mt6357-auxadc.h
new file mode 100644
index 000000000000..03ebb1d23953
--- /dev/null
+++ b/include/dt-bindings/iio/adc/mediatek,mt6357-auxadc.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+
+#ifndef _DT_BINDINGS_MEDIATEK_MT6357_AUXADC_H
+#define _DT_BINDINGS_MEDIATEK_MT6357_AUXADC_H
+
+/* ADC Channel Index */
+#define MT6357_AUXADC_BATADC		0
+#define MT6357_AUXADC_ISENSE		1
+#define MT6357_AUXADC_VCDT		2
+#define MT6357_AUXADC_BAT_TEMP		3
+#define MT6357_AUXADC_CHIP_TEMP		4
+#define MT6357_AUXADC_ACCDET		5
+#define MT6357_AUXADC_VDCXO		6
+#define MT6357_AUXADC_TSX_TEMP		7
+#define MT6357_AUXADC_HPOFS_CAL		8
+#define MT6357_AUXADC_DCXO_TEMP		9
+#define MT6357_AUXADC_VCORE_TEMP	10
+#define MT6357_AUXADC_VPROC_TEMP	11
+#define MT6357_AUXADC_VBAT		12
+
+#endif
diff --git a/include/dt-bindings/iio/adc/mediatek,mt6358-auxadc.h b/include/dt-bindings/iio/adc/mediatek,mt6358-auxadc.h
new file mode 100644
index 000000000000..efa08398fafd
--- /dev/null
+++ b/include/dt-bindings/iio/adc/mediatek,mt6358-auxadc.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+
+#ifndef _DT_BINDINGS_MEDIATEK_MT6358_AUXADC_H
+#define _DT_BINDINGS_MEDIATEK_MT6358_AUXADC_H
+
+/* ADC Channel Index */
+#define MT6358_AUXADC_BATADC		0
+#define MT6358_AUXADC_VCDT		1
+#define MT6358_AUXADC_BAT_TEMP		2
+#define MT6358_AUXADC_CHIP_TEMP		3
+#define MT6358_AUXADC_ACCDET		4
+#define MT6358_AUXADC_VDCXO		5
+#define MT6358_AUXADC_TSX_TEMP		6
+#define MT6358_AUXADC_HPOFS_CAL		7
+#define MT6358_AUXADC_DCXO_TEMP		8
+#define MT6358_AUXADC_VBIF		9
+#define MT6358_AUXADC_VCORE_TEMP	10
+#define MT6358_AUXADC_VPROC_TEMP	11
+#define MT6358_AUXADC_VGPU_TEMP		12
+#define MT6358_AUXADC_VBAT		13
+
+#endif
diff --git a/include/dt-bindings/iio/adc/mediatek,mt6359-auxadc.h b/include/dt-bindings/iio/adc/mediatek,mt6359-auxadc.h
new file mode 100644
index 000000000000..59826393ee7e
--- /dev/null
+++ b/include/dt-bindings/iio/adc/mediatek,mt6359-auxadc.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+
+#ifndef _DT_BINDINGS_MEDIATEK_MT6359_AUXADC_H
+#define _DT_BINDINGS_MEDIATEK_MT6359_AUXADC_H
+
+/* ADC Channel Index */
+#define MT6359_AUXADC_BATADC		0
+#define MT6359_AUXADC_BAT_TEMP		1
+#define MT6359_AUXADC_CHIP_TEMP		2
+#define MT6359_AUXADC_ACCDET		3
+#define MT6359_AUXADC_VDCXO		4
+#define MT6359_AUXADC_TSX_TEMP		5
+#define MT6359_AUXADC_HPOFS_CAL		6
+#define MT6359_AUXADC_DCXO_TEMP		7
+#define MT6359_AUXADC_VBIF		8
+#define MT6359_AUXADC_VCORE_TEMP	9
+#define MT6359_AUXADC_VPROC_TEMP	10
+#define MT6359_AUXADC_VGPU_TEMP		11
+#define MT6359_AUXADC_VBAT		12
+#define MT6359_AUXADC_IBAT		13
+
+#endif
-- 
2.45.1


