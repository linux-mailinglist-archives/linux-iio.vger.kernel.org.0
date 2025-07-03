Return-Path: <linux-iio+bounces-21299-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B74AF76CF
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 16:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6B577BBDF7
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 14:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2579D2E88B7;
	Thu,  3 Jul 2025 14:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dJMsU601"
X-Original-To: linux-iio@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093272E717C;
	Thu,  3 Jul 2025 14:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551913; cv=none; b=jev+N+AfqFibX3XnTWmDP5qQFkSaMuiKCYf6JonUuAWTKVKHUIraEWdI+CDW0IMFu3RWc7XnzdOwn+mXcw1im1Wv7eS8YttfBbdXh5bMmFx55rhkqku8SAXrWHQGAD1RvaNumqopPRD8HUP5nw9/7eQkWmvl/ych+bTq5bPhDG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551913; c=relaxed/simple;
	bh=tdLyXltcIoFwobtxtRzgrsZDuNu50xOF9/XzgUdiQJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C6Dpocxb9aOXSwBdwVZvJ2zpw2UP4EuzUABZ7MhdOQ40lsfWd8S5OkzIoaGpAwQyovCjnHgJnpjeNFvv4p/B96rWgONVjDfIcC/hvImKw7FhBzJfYErP+qN61Y04DLOVcpmJXxqH7WXB8SqCwmy82xmfNDcpkKPcdiP5fJ6wLC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dJMsU601; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751551910;
	bh=tdLyXltcIoFwobtxtRzgrsZDuNu50xOF9/XzgUdiQJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dJMsU601hrZHvzQasjWjvsYpAkSLp5Yq/JX9OVRV1UJNyhdbfJPUs9EwUcFm2Do54
	 z4jcbL5hZ2WS+1T9TVbKbZuTg6YYQxytbfctZMXn8N60pb+pJ0iOBNIY+DQxbMxwoe
	 KA6PUXH98CYsuUlr/yn8V+4T8eSVwyQcPaOXkCrFiwmABFzXMGRbs4b+TswVBwGgu9
	 4xWpUIQdnF1PG6T83tNpoyY+9YVNVXsDo2gZAoObO7HODKPI1yeG+81W9rS8t2A5Bg
	 ci6ymVIytVK9Ah8rsj1lJ7FUXgxYxDM5qyGArYMKDfgVWdSnWWMdCLOLZYkwdtqXaY
	 7pm7jLa1EByAA==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5C3A817E07FF;
	Thu,  3 Jul 2025 16:11:49 +0200 (CEST)
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
Subject: [PATCH v2 1/6] dt-bindings: iio: adc: mt6359: Add MT6363 PMIC AuxADC
Date: Thu,  3 Jul 2025 16:11:41 +0200
Message-ID: <20250703141146.171431-2-angelogioacchino.delregno@collabora.com>
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

Add a compatible and channel bindings for MediaTek's MT6363 PMIC,
featuring an Auxiliary ADC IP with 15 ADC channels used for both
internal temperatures and voltages and for external voltage inputs.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
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


