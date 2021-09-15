Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1BD40C919
	for <lists+linux-iio@lfdr.de>; Wed, 15 Sep 2021 17:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbhIOQAg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Sep 2021 12:00:36 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:44751 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbhIOQAg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Sep 2021 12:00:36 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 514C51BF210;
        Wed, 15 Sep 2021 15:59:14 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 02/47] dt-bindings: mfd: ti,am3359-tscadc: Add a yaml description for this MFD
Date:   Wed, 15 Sep 2021 17:58:23 +0200
Message-Id: <20210915155908.476767-3-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210915155908.476767-1-miquel.raynal@bootlin.com>
References: <20210915155908.476767-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

There is a very light description of this MFD in a text file dedicated
to a touchscreen controller (which is one of the two children of the
MFD). Here is now a complete yaml description.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 .../bindings/mfd/ti,am3359-tscadc.yaml        | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml

diff --git a/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml b/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
new file mode 100644
index 000000000000..b2bff85f2329
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ti,am3359-tscadc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI AM3359 Touchscreen controller/ADC
+
+maintainers:
+  - Miquel Raynal <miquel.raynal@bootlin.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: ti,am3359-tscadc
+      - items:
+          - const: ti,am654-tscadc
+          - const: ti,am3359-tscadc
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
+  clock-names:
+    const: fck
+
+  dmas:
+    items:
+      - description: DMA controller phandle and request line for FIFO0
+      - description: DMA controller phandle and request line for FIFO1
+
+  dma-names:
+    items:
+      - const: fifo0
+      - const: fifo1
+
+  adc:
+    type: object
+    description: ADC child
+
+  tsc:
+    type: object
+    description: Touchscreen controller child
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - dmas
+  - dma-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    tscadc@0 {
+        compatible = "ti,am3359-tscadc";
+        reg = <0x0 0x1000>;
+        interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&adc_tsc_fck>;
+        clock-names = "fck";
+        dmas = <&edma 53 0>, <&edma 57 0>;
+        dma-names = "fifo0", "fifo1";
+
+        tsc {
+        };
+
+        adc {
+        };
+    };
-- 
2.27.0

