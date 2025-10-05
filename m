Return-Path: <linux-iio+bounces-24733-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B25BB95CB
	for <lists+linux-iio@lfdr.de>; Sun, 05 Oct 2025 13:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4EB91895A15
	for <lists+linux-iio@lfdr.de>; Sun,  5 Oct 2025 11:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8FD2749D7;
	Sun,  5 Oct 2025 11:14:54 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A68A24DD00;
	Sun,  5 Oct 2025 11:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759662894; cv=none; b=tHzUsvgxEbzyUIcKSngaXjYcLGW3Z3tbV5udR50sQOQM3hpoRMvkQc8/Q4sZeAU8Rk4rnP7wndhAE1UoA0UW9swBCNslFSGPKXs0jYfj5syCNc3VAzykZ0B940xSgsBnlf5KXhe0JPekigSHMKeuGOz+0WzYVs/FigOjInk4hGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759662894; c=relaxed/simple;
	bh=flfBbhak/YrsZJhiUlCQnOSGQcRNBKtGFS2x79uQJFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzG04N4tIzMMg5+NYwIiqRclttHoVieh/wcnGJIOeSNHk/IXrOf8nhGesu98WZ/GDmeTTbzOmLIXWmdJ5Aiw0NuQo6gKEgpXtMl2nWoBAXJYio3yBEBI62sxyy4ieAl3PMK0YKaeDCcq2z00dl1Yv/5tvZ7hytGtMn4nc73i2c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: ibfIh42cTBmmRfCe0UUoGw==
X-CSE-MsgGUID: K1BREhvAScSrGdjwTUf5Zg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 05 Oct 2025 20:14:45 +0900
Received: from demon-pc.localdomain (unknown [10.226.92.25])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4C10440062B8;
	Sun,  5 Oct 2025 20:14:41 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: 
Cc: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/6] dt-bindings: iio: adc: document RZ/T2H and RZ/N2H ADC
Date: Sun,  5 Oct 2025 14:13:17 +0300
Message-ID: <20251005111323.804638-2-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251005111323.804638-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251005111323.804638-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the A/D 12-Bit successive approximation converters found in the
Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs.

RZ/T2H has two ADCs with 4 channels and one with 6.
RZ/N2H has two ADCs with 4 channels and one with 15.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../iio/adc/renesas,r9a09g077-adc.yaml        | 135 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 142 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
new file mode 100644
index 000000000000..dc0206b28231
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
@@ -0,0 +1,135 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/renesas,r9a09g077-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/T2H / RZ/N2H ADC12
+
+maintainers:
+  - Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
+
+description: |
+  A/D Converter block is a successive approximation analog-to-digital converter
+  with a 12-bit accuracy. Up to 16 analog input channels can be selected.
+  Conversions can be performed in single or continuous mode. Result of the ADC
+  is stored in a 16-bit data register corresponding to each channel.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: renesas,r9a09g087-adc # RZ/N2H
+          - const: renesas,r9a09g077-adc # RZ/T2H
+      - items:
+          - const: renesas,r9a09g077-adc # RZ/T2H
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: A/D scan end interrupt
+      - description: A/D scan end interrupt for Group B
+      - description: A/D scan end interrupt for Group C
+      - description: Window A compare match
+      - description: Window B compare match
+      - description: Compare match
+      - description: Compare mismatch
+
+  interrupt-names:
+    items:
+      - const: adi
+      - const: gbadi
+      - const: gcadi
+      - const: cmpai
+      - const: cmpbi
+      - const: wcmpm
+      - const: wcmpum
+
+  clocks:
+    items:
+      - description: Converter clock
+      - description: Peripheral clock
+
+  clock-names:
+    items:
+      - const: adclk
+      - const: pclk
+
+  power-domains:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  "#io-channel-cells":
+    const: 1
+
+patternProperties:
+  "^channel@[0-9a-f]$":
+    $ref: adc.yaml
+    type: object
+    description: The external channels which are connected to the ADC.
+
+    properties:
+      reg:
+        description: The channel number.
+        maximum: 15
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    adc@80008000 {
+      compatible = "renesas,r9a09g077-adc";
+      reg = <0x80008000 0x400>;
+      interrupts = <GIC_SPI 708 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 709 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 710 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 711 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 712 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 855 IRQ_TYPE_EDGE_RISING>,
+                   <GIC_SPI 856 IRQ_TYPE_EDGE_RISING>;
+      interrupt-names = "adi", "gbadi", "gcadi",
+                        "cmpai", "cmpbi", "wcmpm", "wcmpum";
+      clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKL>,
+               <&cpg CPG_MOD 225>;
+      clock-names = "adclk", "pclk";
+      power-domains = <&cpg>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+      #io-channel-cells = <1>;
+
+      channel@0 {
+        reg = <0x0>;
+      };
+      channel@1 {
+        reg = <0x1>;
+      };
+      channel@2 {
+        reg = <0x2>;
+      };
+      channel@3 {
+        reg = <0x3>;
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 07363437c278..ff2a3257a498 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21835,6 +21835,13 @@ S:	Supported
 F:	Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
 F:	drivers/counter/rz-mtu3-cnt.c
 
+RENESAS RZ/T2H / RZ/N2H A/D DRIVER
+M:	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
+L:	linux-iio@vger.kernel.org
+L:	linux-renesas-soc@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
+
 RENESAS RTCA-3 RTC DRIVER
 M:	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
 L:	linux-rtc@vger.kernel.org
-- 
2.51.0


