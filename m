Return-Path: <linux-iio+bounces-24374-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583CAB96BA7
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 18:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CA6A3B90CD
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 16:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08F12E336F;
	Tue, 23 Sep 2025 16:06:15 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FC1266B56;
	Tue, 23 Sep 2025 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758643575; cv=none; b=RDkdubwHJCa39gocILAYBreUHxa2IIgYvG/nubpRcrytidA3e0cvK6R0KkS5ICtJ3VSFy5uMWDZpxElW0UR7dZOfPqim5YCzbllge93J68QhodJgTVd6wEpCqP6/XDaG/EqLlNpIgBVhdGIqRiNRNDdT/vMa9cq4rNfASbMuaQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758643575; c=relaxed/simple;
	bh=BJJpFKc3eWPnUQN05pacgwN7SfjzcTDEsetqVeomAtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fog+v030n9tTz+wmL5rHxZRfktWeRuIVNdd18qrasDQA0s1g0nGqhs3iLSn77JX+Xsjni5fA0jHkbpg/nj9rruaWock9/fRp4WBkxGMCK8cSkguqMVjpLkpByvvZ+VuKg9zLAiE50PxnqYf9DPCncZ8L4LSvV+X+G/iZQ6c03Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: OU6AneBWR+aivyAowQmlbw==
X-CSE-MsgGUID: yLMfyZXzQ2KSfB8WP/fzjg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 24 Sep 2025 01:06:12 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.64])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 91CAF4008A2F;
	Wed, 24 Sep 2025 01:06:06 +0900 (JST)
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
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH 2/7] dt-bindings: iio: adc: document RZ/T2H and RZ/N2H ADC
Date: Tue, 23 Sep 2025 19:05:16 +0300
Message-ID: <20250923160524.1096720-3-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250923160524.1096720-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20250923160524.1096720-1-cosmin-gabriel.tanislav.xa@renesas.com>
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
---
 .../iio/adc/renesas,r9a09g077-adc.yaml        | 170 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 177 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
new file mode 100644
index 000000000000..840108cd317e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/renesas,r9a09g077-adc.yaml
@@ -0,0 +1,170 @@
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
+  with a 12-bit accuracy. Up to 15 analog input channels can be selected.
+  Conversions can be performed in single or continuous mode. Result of the ADC
+  is stored in a 16-bit data register corresponding to each channel.
+
+properties:
+  compatible:
+    enum:
+      - renesas,r9a09g077-adc # RZ/T2H
+      - renesas,r9a09g087-adc # RZ/N2H
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
+      - description: converter clock
+      - description: peripheral clock
+
+  clock-names:
+    items:
+      - const: adclk
+      - const: pclk
+
+  power-domains:
+    maxItems: 1
+
+  renesas,max-channels:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Maximum number of channels supported by the ADC.
+      RZ/T2H has two ADCs with 4 channels and one with 6 channels.
+      RZ/N2H has two ADCs with 4 channels and one with 15 channels.
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
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+  - renesas,max-channels
+
+patternProperties:
+  "^channel@[0-9a-e]$":
+    $ref: adc.yaml
+    type: object
+    description: The external channels which are connected to the ADC.
+
+    properties:
+      reg:
+        description: The channel number.
+        maximum: 14
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g077-adc
+    then:
+      properties:
+        renesas,max-channels:
+          enum: [4, 6]
+
+      patternProperties:
+        "^channel@[6-9a-e]$": false
+        "^channel@[0-5]$":
+          properties:
+            reg:
+              maximum: 5
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,r9a09g087-adc
+    then:
+      properties:
+        renesas,max-channels:
+          enum: [4, 15]
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
+      renesas,max-channels = <6>;
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
index 9f4b48801879..07e0d37cf468 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21822,6 +21822,13 @@ S:	Supported
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


