Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477963B7A34
	for <lists+linux-iio@lfdr.de>; Wed, 30 Jun 2021 00:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbhF2WGS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Jun 2021 18:06:18 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:61189 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234871AbhF2WGP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Jun 2021 18:06:15 -0400
X-IronPort-AV: E=Sophos;i="5.83,310,1616425200"; 
   d="scan'208";a="85915408"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 30 Jun 2021 07:03:46 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 24E9B40108F7;
        Wed, 30 Jun 2021 07:03:43 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/2] dt-bindings: iio: adc: Add binding documentation for Renesas RZ/G2L A/D converter
Date:   Tue, 29 Jun 2021 23:03:27 +0100
Message-Id: <20210629220328.13366-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210629220328.13366-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210629220328.13366-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add binding documentation for Renesas RZ/G2L A/D converter block.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 121 ++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
new file mode 100644
index 000000000000..db935d6d59eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
@@ -0,0 +1,121 @@
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
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r9a07g044-adc   # RZ/G2{L,LC}
+          - const: renesas,rzg2l-adc
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
+  renesas-rzg2l,adc-trigger-mode:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description: Trigger mode for A/D converter
+    enum:
+      - 0 # Software trigger mode (Defaults)
+      - 1 # Asynchronous trigger using ADC_TRG trigger input pin
+      - 2 # Synchronous trigger (Trigger from MTU3a/GPT)
+    default: 0
+
+  gpios:
+    description:
+      ADC_TRG trigger input pin
+    maxItems: 1
+
+  renesas-rzg2l,adc-channels:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description: Input channels available on platform
+    uniqueItems: true
+    minItems: 1
+    maxItems: 8
+    items:
+      enum: [0, 1, 2, 3, 4, 5, 6, 7]
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
+  - resets
+  - reset-names
+  - renesas-rzg2l,adc-channels
+  - "#io-channel-cells"
+
+allOf:
+  - if:
+      properties:
+        renesas-rzg2l,adc-trigger-mode:
+          const: 1
+    then:
+      required:
+        - gpios
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
+      #io-channel-cells = <1>;
+      renesas-rzg2l,adc-trigger-mode = /bits/ 8 <0>;
+      renesas-rzg2l,adc-channels = /bits/ 8 <0 1 2 3 4 5 6>;
+    };
-- 
2.17.1

