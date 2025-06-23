Return-Path: <linux-iio+bounces-20903-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C0DAE3EE9
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 14:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E7003A622F
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 12:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4021624DCE8;
	Mon, 23 Jun 2025 12:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="K6IXMrno"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D2B24BC1A;
	Mon, 23 Jun 2025 12:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680037; cv=none; b=pkkRelrqG/cIlWFdUYaQ/XBkqXUltMZsX4iLZT/VDLgEaQjWrfikbiyA5RH6zynn5AZWNhIxjdPJlF/MpcxWM8M/8J63uuY7QNkLELCYmVhUJF9w6q6YfbmExA1XUBWWBeEZTsaNrZiCZuY7EwqurMDHj2dV/pPu6lazDY6WNd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680037; c=relaxed/simple;
	bh=CZEgYbfBy7FB1rq1F534XxN+O0ZjjDodFZAWk6TJxVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfsdRbR5HuTHTsTiKgwRZUTJ7OLCS9cqxilW6hkqLzQVx7Z3ZSyXhFT92u3YuwR5BYD2LEPnMLVCziMgkoU1ifssY23f06EWSVyoYqtYNAcbOUtsn7/eXie06UTUPh6tJOMfEDcPyaLMdWp/NTrV0+webGH7JQnbeaV1aGQgAyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=K6IXMrno; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750680033;
	bh=CZEgYbfBy7FB1rq1F534XxN+O0ZjjDodFZAWk6TJxVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K6IXMrnots+VxqoED35PFiKhotry7PESAi9bWxLFA7wECQLtuHZ4I47xjfRE2H9m3
	 PqNb512qcE8XGkmN9k8KtjekgpZ2ya+f/yYM2MjsI71B4loE9GKIcQauNsBW9/APqR
	 DdCFR9gXlUBbMFVeybJm1/aTUflm3xjCWIUGY6szaGaFGrGTq8TrNr19ODCZXzSNR+
	 pPgI4y7K+XcRRBlAO7CmJCSKtKYFfgh3fv8iRceMoeDfG8Agz3ryhivQqocKHPYB/e
	 BL6Lu/kUijIo8dawgMdPQ7AQUqnMa9XCFkOcH2c9wIKskZeeIyBsTF/h/RIOb/thkL
	 OOgj2qnEbC8Vg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BD6AB17E05BD;
	Mon, 23 Jun 2025 14:00:32 +0200 (CEST)
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
Subject: [PATCH v1 1/5] dt-bindings: iio: adc: mt6359: Add bindings for MT6363 PMIC AuxADC
Date: Mon, 23 Jun 2025 14:00:24 +0200
Message-ID: <20250623120028.108809-2-angelogioacchino.delregno@collabora.com>
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

Add a compatible and channel bindings for MediaTek's MT6363 PMIC,
featuring an Auxiliary ADC IP with 15 ADC channels used for both
internal temperatures and voltages and for external voltage inputs.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../iio/adc/mediatek,mt6359-auxadc.yaml       |  1 +
 .../iio/adc/mediatek,mt6363-auxadc.h          | 24 +++++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6363-auxadc.h

diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
index 6497c416094d..a94429477e46 100644
--- a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
@@ -22,6 +22,7 @@ properties:
       - mediatek,mt6357-auxadc
       - mediatek,mt6358-auxadc
       - mediatek,mt6359-auxadc
+      - mediatek,mt6363-auxadc
 
   "#io-channel-cells":
     const: 1
diff --git a/include/dt-bindings/iio/adc/mediatek,mt6363-auxadc.h b/include/dt-bindings/iio/adc/mediatek,mt6363-auxadc.h
new file mode 100644
index 000000000000..92d135477d0e
--- /dev/null
+++ b/include/dt-bindings/iio/adc/mediatek,mt6363-auxadc.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+
+#ifndef _DT_BINDINGS_MEDIATEK_MT6363_AUXADC_H
+#define _DT_BINDINGS_MEDIATEK_MT6363_AUXADC_H
+
+/* ADC Channel Index */
+#define MT6363_AUXADC_BATADC		0
+#define MT6363_AUXADC_VCDT		1
+#define MT6363_AUXADC_BAT_TEMP		2
+#define MT6363_AUXADC_CHIP_TEMP		3
+#define MT6363_AUXADC_VSYSSNS		4
+#define MT6363_AUXADC_VTREF		5
+#define MT6363_AUXADC_VCORE_TEMP	6
+#define MT6363_AUXADC_VPROC_TEMP	7
+#define MT6363_AUXADC_VGPU_TEMP		8
+#define MT6363_AUXADC_VIN1		9
+#define MT6363_AUXADC_VIN2		10
+#define MT6363_AUXADC_VIN3		11
+#define MT6363_AUXADC_VIN4		12
+#define MT6363_AUXADC_VIN5		13
+#define MT6363_AUXADC_VIN6		14
+#define MT6363_AUXADC_VIN7		15
+
+#endif
-- 
2.49.0


