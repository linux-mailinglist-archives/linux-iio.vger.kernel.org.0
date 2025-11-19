Return-Path: <linux-iio+bounces-26321-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 526EAC70C04
	for <lists+linux-iio@lfdr.de>; Wed, 19 Nov 2025 20:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41A4C4E105B
	for <lists+linux-iio@lfdr.de>; Wed, 19 Nov 2025 19:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88053364E8A;
	Wed, 19 Nov 2025 19:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GmR/5M8h"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912732F6186
	for <linux-iio@vger.kernel.org>; Wed, 19 Nov 2025 19:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763579758; cv=none; b=Bbdwrd+cVvQ8JtidvM3t692+rWk822wmpa03fKymbLZ3BdssHLsATzdgHmjZW3fMMPpzyzM+o+6Zj9jdxVSEaAMGPOWJy+GRvRvTMXH3FAwodF7SXjxrPtRh3YK9pkWEfy5TMwyRYZQCr+HisyqqbcYRAQsYKWkWW5EZBYTJngM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763579758; c=relaxed/simple;
	bh=OhAPqaXLXCmsNIfo7/tILARHNy+GrLJldAAVbkxmaW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e46wbxEaFdaBHma88i2emLH4ZRB0ZbvtVWJaDoUqjy+/sGwYkJDJhwf2ZdxXY12588YWG5i3vi2EwRuWB4ZNn8SUowHSp9iGDA1nVNkc4zWLMfUD6Dzt8ZgW7E7Uae91vlq6g7isOPNgFiWzuJcmZl4ussQNA6ank6qR8wJnlJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GmR/5M8h; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-429c7869704so65010f8f.2
        for <linux-iio@vger.kernel.org>; Wed, 19 Nov 2025 11:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763579750; x=1764184550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZahglen05z3CRdzByKKHS/uCh35Ibd/55Vn0qmvXT0=;
        b=GmR/5M8hKGcY/fmoclyUwornqytGUr+nWy4thm6HDc86qBtUDO/E08PDJCqRmG1Kbc
         TRSOKCz9GfI6E1ZTQqXPWInacqctUxzjBzNVHZuqfcQZdqzOScdLfzJ97IAiXy3V2yEE
         oI5fp2vIJZqF5UfRbmKm6jDZLlA7DJuVNQZNUr/Dfqet6n3nv55aY1e89EBXS6Ed9k2c
         +QGDtyF5A8Un8Vtz87iGeFRQm93twjtEfsPUQ3DYAGLgp4SuuqwZ0X1SXOlytJ+eOrYc
         WabArJqzXzjQnd1E6Hckf6u0DkmufpadnyBfWiaAO6a8ifkmaXbmVsfthBv6VzZrmWXz
         4k0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763579750; x=1764184550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tZahglen05z3CRdzByKKHS/uCh35Ibd/55Vn0qmvXT0=;
        b=Ib08cvh5s5x12x82vNwfqZCpgIcJFSx9hZz1mPdFT22RsAcAxMACknd2i3MNPkiLEv
         D13gXdYvKwLtEeKbdctPNtXy1h2Re/QcDODzlKD8cthbnCuzMY/PASkcS/Th1ZCK5KnW
         VeXikdM8fFDJ2A1BbWutWFw5sNTjJmritD3TH+dfSnYDe5jJrg0t/sUJA8mfMdYI9K8F
         1YEKG8JgVfCB+LAnTrtVUTScDC2LkYX5mvFVSfDqw3fkCTINHhvX98eCbXCDqKG5AqHC
         vqP+4FEpgOFg0OtspsX0uebHXPG2/xZ2hekthLahwMv0/SDBzrpRwRKb+AFguWpIAgRT
         qX3Q==
X-Gm-Message-State: AOJu0Yz9NUJSWpPAy6LSmOepz3507aEuwNUcw/0RvCQb9nnLIB4uXzg3
	+5lkXdP6uEEk2M3xoxKa4uk7FSDsoTsxdrajBFG1fPr13jKxZ9eDFWsHfXeOjOs6qlE=
X-Gm-Gg: ASbGnctiQwzN8MxO0/FlgcwlKAWUjTwiQcy8Qgropd8+WtQTyIaZS5dEAKjR5rSWt7b
	/Z85SMvU3BOZSW+IFG+zphnSXZv1WoluUlwSbBgUxHzDzya/jFCDYStF0f+4I/QsmbbrEESLan7
	pJuGSIpXWaFCdDJKx+2Mb3N9hFV6M56Y2ak+ErHZulcgSKfPd+Cr6c7ixkT8YAubX2A2kL6TC8o
	Ad3qR+ukmYg17cfD7HaSKZzXK4wawZn3b+B96e8mgp+bZSs18D+OyiHu4s/NqoCZixmSHx938dp
	oqvwmk9Hn/B/yPfF6Ari/xgHl/cmvuhFJjW+Wo84ugz+EVsWhrJcz8QHeGT89f7SuOv1fULbNH7
	nT+X2P4btlUDKi+jRZvlKp128PUrgYeqTlPRtLrWk4J1MdVZ01R+pbw+qUchV6/TJi+CddTiuVN
	YZOP/dzzVNaxpnEZjjCmXRBfLBe/1hucfrK2s9T+UA1Q==
X-Google-Smtp-Source: AGHT+IFKE+Ky/K++z5OHPA04EVmi5tIsUEcEojQOiVrA+eQqY31INhQV7qHFlCCEBZCKCcJw0G3bFw==
X-Received: by 2002:a05:6000:3106:b0:429:8d0f:ebf with SMTP id ffacd0b85a97d-42b5938fad5mr21012521f8f.42.1763579750166;
        Wed, 19 Nov 2025 11:15:50 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:37e6:ed62:3c8b:2621])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd9061sm788246f8f.41.2025.11.19.11.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 11:15:49 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	s32@nxp.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	chester62515@gmail.com,
	mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com,
	vkoul@kernel.org
Subject: [PATCH v7 1/2] dt-bindings: iio: adc: Add the NXP SAR ADC for s32g2/3 platforms
Date: Wed, 19 Nov 2025 20:15:44 +0100
Message-ID: <20251119191545.46053-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119191545.46053-1-daniel.lezcano@linaro.org>
References: <20251119191545.46053-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The s32g2 and s32g3 NXP platforms have two instances of a Successive
Approximation Register ADC. It supports the raw, trigger and scan
modes which involves the DMA. Add their descriptions.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/iio/adc/nxp,s32g2-sar-adc.yaml   | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,s32g2-sar-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/nxp,s32g2-sar-adc.yaml b/Documentation/devicetree/bindings/iio/adc/nxp,s32g2-sar-adc.yaml
new file mode 100644
index 000000000000..ec258f224df8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/nxp,s32g2-sar-adc.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/nxp,s32g2-sar-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP Successive Approximation ADC
+
+description:
+  The NXP SAR ADC provides fast and accurate analog-to-digital
+  conversion using the Successive Approximation Register (SAR) method.
+  It has 12-bit resolution with 8 input channels. Conversions can be
+  launched in software or using hardware triggers. It supports
+  continuous and one-shot modes with separate registers.
+
+maintainers:
+  - Daniel Lezcano <daniel.lezcano@kernel.org>
+
+properties:
+  compatible:
+    oneOf:
+      - const: nxp,s32g2-sar-adc
+      - items:
+          - const: nxp,s32g3-sar-adc
+          - const: nxp,s32g2-sar-adc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    const: rx
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - dmas
+  - dma-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    adc@401f8000 {
+        compatible = "nxp,s32g2-sar-adc";
+        reg = <0x401f8000 0x1000>;
+        interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clks 0x41>;
+        dmas = <&edma0 0 32>;
+        dma-names = "rx";
+    };
-- 
2.43.0


