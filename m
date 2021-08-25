Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A74C3F785E
	for <lists+linux-iio@lfdr.de>; Wed, 25 Aug 2021 17:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241311AbhHYPai (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Aug 2021 11:30:38 -0400
Received: from mslow1.mail.gandi.net ([217.70.178.240]:35403 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241030AbhHYPai (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Aug 2021 11:30:38 -0400
Received: from relay6-d.mail.gandi.net (unknown [217.70.183.198])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id D5319C8C51;
        Wed, 25 Aug 2021 15:25:51 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 5E516C0004;
        Wed, 25 Aug 2021 15:25:27 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>,
        Tero Kristo <t-kristo@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "Ryan J . Barnett" <ryan.barnett@collins.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 03/40] dt-bindings: touchscreen: ti,am3359-tsc: New yaml description
Date:   Wed, 25 Aug 2021 17:24:41 +0200
Message-Id: <20210825152518.379386-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210825152518.379386-1-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This touchscreen controller is already described in a text file:
Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt

After introducing a proper description of the MFD, this is the second
step. The file cannot be removed yet as it also contains an ADC
description.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../input/touchscreen/ti,am3359-tsc.yaml      | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml b/Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml
new file mode 100644
index 000000000000..2d4ce6d04f53
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/ti,am3359-tsc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI AM3359 Touchscreen controller
+
+maintainers:
+  - Miquel Raynal <miquel.raynal@bootlin.com>
+
+properties:
+  compatible:
+    const: ti,am3359-tsc
+
+  ti,wires:
+    description: Wires refer to application modes i.e. 4/5/8 wire touchscreen
+      support on the platform.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [4, 5, 8]
+
+  ti,x-plate-resistance:
+    description: X plate resistance
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  ti,coordinate-readouts:
+    description: The sequencer supports a total of 16 programmable steps. Each
+      step is used to read a single coordinate. A single readout is enough but
+      multiple reads can increase the quality. A value of 5 means, 5 reads for
+      X, 5 for Y and 2 for Z (always). This utilises 12 of the 16 software steps
+      available. The remaining 4 can be used by the ADC.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 6
+
+  ti,wire-config:
+    description: Different boards could have a different order for connecting
+      wires on touchscreen. We need to provide an 8-bit number where the
+      first four bits represent the analog lines and the next 4 bits represent
+      positive/negative terminal on that input line. Notations to represent the
+      input lines and terminals respectively are as follows, AIN0 = 0, AIN1 = 1
+      and so on untill AIN7 = 7. XP = 0, XN = 1, YP = 2, YN = 3.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 4
+    maxItems: 8
+
+  ti,charge-delay:
+    description: Length of touch screen charge delay step in terms of ADC clock
+      cycles. Charge delay value should be large in order to avoid false pen-up
+      events. This value effects the overall sampling speed, hence need to be
+      kept as low as possible, while avoiding false pen-up event. Start from a
+      lower value, say 0x400, and increase value until false pen-up events are
+      avoided. The pen-up detection happens immediately after the charge step,
+      so this does in fact function as a hardware knob for adjusting the amount
+      of "settling time".
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - ti,wires
+  - ti,x-plate-resistance
+  - ti,coordinate-readouts
+  - ti,wire-config
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    tscadc: tscadc@0 {
+        compatible = "ti,am3359-tscadc";
+        reg = <0x0 0x1000>;
+        interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&adc_tsc_fck>;
+        clock-names = "fck";
+        status = "disabled";
+        dmas = <&edma 53 0>, <&edma 57 0>;
+        dma-names = "fifo0", "fifo1";
+
+        tsc {
+            compatible = "ti,am3359-tsc";
+            ti,wires = <4>;
+            ti,x-plate-resistance = <200>;
+            ti,coordinate-readouts = <5>;
+            ti,wire-config = <0x00 0x11 0x22 0x33>;
+            ti,charge-delay = <0x400>;
+        };
+    };
-- 
2.27.0

