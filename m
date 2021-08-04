Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569AE3E0949
	for <lists+linux-iio@lfdr.de>; Wed,  4 Aug 2021 22:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240854AbhHDUZ2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Aug 2021 16:25:28 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:23751 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S240842AbhHDUZ0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Aug 2021 16:25:26 -0400
X-IronPort-AV: E=Sophos;i="5.84,295,1620658800"; 
   d="scan'208";a="89843670"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Aug 2021 05:25:11 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id C954640E2584;
        Thu,  5 Aug 2021 05:25:08 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Magnus Damm <magnus.damm@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 1/3] dt-bindings: iio: adc: Add binding documentation for Renesas RZ/G2L A/D converter
Date:   Wed,  4 Aug 2021 21:21:16 +0100
Message-Id: <20210804202118.25745-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210804202118.25745-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210804202118.25745-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add binding documentation for Renesas RZ/G2L A/D converter block.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v3-->v4:
* Included RB tag from Rob
---
 .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 134 ++++++++++++++++++
 1 file changed, 134 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
new file mode 100644
index 000000000000..c80201d6a716
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
@@ -0,0 +1,134 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/renesas,rzg2l-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G2L ADC
+
+maintainers:
+  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
+
+description: |
+  A/D Converter block is a successive approximation analog-to-digital converter
+  with a 12-bit accuracy. Up to eight analog input channels can be selected.
+  Conversions can be performed in single or repeat mode. Result of the ADC is
+  stored in a 32-bit data register corresponding to each channel.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r9a07g044-adc   # RZ/G2{L,LC}
+      - const: renesas,rzg2l-adc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
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
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: presetn
+      - const: adrst-n
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+  - resets
+  - reset-names
+
+patternProperties:
+  "^channel@[0-7]$":
+    $ref: "adc.yaml"
+    type: object
+    description: |
+      Represents the external channels which are connected to the ADC.
+
+    properties:
+      reg:
+        description: |
+          The channel number. It can have up to 8 channels numbered from 0 to 7.
+        items:
+          - minimum: 0
+            maximum: 7
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r9a07g044-cpg.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    adc: adc@10059000 {
+      compatible = "renesas,r9a07g044-adc", "renesas,rzg2l-adc";
+      reg = <0x10059000 0x400>;
+      interrupts = <GIC_SPI 347 IRQ_TYPE_EDGE_RISING>;
+      clocks = <&cpg CPG_MOD R9A07G044_ADC_ADCLK>,
+               <&cpg CPG_MOD R9A07G044_ADC_PCLK>;
+      clock-names = "adclk", "pclk";
+      power-domains = <&cpg>;
+      resets = <&cpg R9A07G044_ADC_PRESETN>,
+               <&cpg R9A07G044_ADC_ADRST_N>;
+      reset-names = "presetn", "adrst-n";
+
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      channel@0 {
+        reg = <0>;
+      };
+      channel@1 {
+        reg = <1>;
+      };
+      channel@2 {
+        reg = <2>;
+      };
+      channel@3 {
+        reg = <3>;
+      };
+      channel@4 {
+        reg = <4>;
+      };
+      channel@5 {
+        reg = <5>;
+      };
+      channel@6 {
+        reg = <6>;
+      };
+      channel@7 {
+        reg = <7>;
+      };
+    };
-- 
2.17.1

