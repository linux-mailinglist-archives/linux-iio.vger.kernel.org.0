Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 659FD3D57C9
	for <lists+linux-iio@lfdr.de>; Mon, 26 Jul 2021 12:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhGZKLL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Jul 2021 06:11:11 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52688 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbhGZKLL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Jul 2021 06:11:11 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16QApJBZ111547;
        Mon, 26 Jul 2021 05:51:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1627296679;
        bh=SOl8lRuzqsuJc76siYTZJd6Pexa98L1H8ZsCkObQGgU=;
        h=From:To:CC:Subject:Date;
        b=GxybnUFeVKLt4r6Y1PiiDffKcqcFd/uLis7zWGD35VJchzcavSJ8roCE/s0jkQleM
         nfrZFhJRjLlwuKMqry+xJ+wpzk5JZ1aEsDZscj1z0rz988Ht4zT43cr9PeRsm5Cvg9
         XhGHfSn6Vnco5RaGme0xKlOCMhPQC06dVuHb2VYk=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16QApJDU048984
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Jul 2021 05:51:19 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 26
 Jul 2021 05:51:19 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 26 Jul 2021 05:51:19 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16QApF87003827;
        Mon, 26 Jul 2021 05:51:16 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-input@vger.kernel.org>
Subject: [PATCH] dt-bindings: mfd: Convert ti-tsc-adc bindings to YAML schema
Date:   Mon, 26 Jul 2021 16:19:58 +0530
Message-ID: <20210726104958.8631-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert ti-tsc-adc binding to YAML schema. This is MFD device with
support for resistive touchscreen and ADC. But the txt binding file for
MFD and ADC has been incorrectly been under input/touchscreen directory,
so split the bindings across subsystems as appropriate.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 .../bindings/iio/adc/ti,am3359-adc.yaml       | 74 +++++++++++++++
 .../input/touchscreen/ti,am3359-tsc.yaml      | 79 ++++++++++++++++
 .../bindings/input/touchscreen/ti-tsc-adc.txt | 91 ------------------
 .../bindings/mfd/ti,am3359-tscadc.yaml        | 92 +++++++++++++++++++
 4 files changed, 245 insertions(+), 91 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,am3359-adc.yaml
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,am3359-adc.yaml b/Documentation/devicetree/bindings/iio/adc/ti,am3359-adc.yaml
new file mode 100644
index 000000000000..b7884be5d378
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,am3359-adc.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,am3359-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bindings for ADC part of TSCADC MFDs on TI SoCs
+
+maintainers:
+  - Vignesh Raghavendra <vigneshr@ti.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - ti,am654-adc
+          - const: ti,am3359-adc
+      - const: ti,am3359-adc
+
+  ti,adc-channels:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      List of analog inputs available for ADC.
+      AIN0 = 0, AIN1 = 1 and so on till AIN7 = 7.
+    minItems: 1
+    maxItems: 8
+    items:
+      maximum: 7
+
+  ti,chan-step-opendelay:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      List of open delays for each channel of list of analog inputs
+      available for ADC. ADC in the order of ti,adc-channels. The
+      value corresponds to the number of ADC clock cycles to wait
+      after applying the step configuration registers and before
+      sending the start of ADC conversion.
+    minItems: 1
+    maxItems: 8
+    items:
+      maximum: 0x3FFFF
+
+  ti,chan-step-sampledelay:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      List of sample delays for each channel of ADC in the order of
+      ti,adc-channels. The value corresponds to the number of
+      ADC clock cycles to sample (to hold start of conversion high).
+    minItems: 1
+    maxItems: 8
+    items:
+      maximum: 0xFF
+
+  ti,chan-step-avg:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Number of averages to be performed for each channel of ADC. If
+      average is 16 then input is sampled 16 times and averaged to
+      get more accurate value. This increases the time taken by ADC
+      to generate a sample.
+    minItems: 1
+    maxItems: 8
+    items:
+      maximum: 16
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - "#io-channel-cells"
+
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml b/Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml
new file mode 100644
index 000000000000..288f8d73b653
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/ti,am3359-tsc.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/ti,am3359-tsc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bindings for TSC part of TSCADC MFDs on TI SoCs
+
+maintainers:
+  - Vignesh Raghavendra <vigneshr@ti.com>
+
+properties:
+  compatible:
+    const: ti,am3359-tsc
+
+  ti,wires:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [4, 5, 8]
+    description:
+      Number of wires used by touchscreen
+
+  ti,x-plate-resistance:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      X plate resistance
+
+  ti,coordinate-readouts:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 5
+    description:
+      The sequencer supports a total of 16 programmable steps
+      each step is used to read a single coordinate. A single
+      readout is enough but multiple reads can increase the quality.
+      A value of 5 means, 5 reads for X, 5 for Y and 2 for Z (always).
+      This utilises 12 of the 16 software steps available.
+      The remaining 4 can be used by the ADC.
+
+  ti,wire-config:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      Different boards could have a different order for
+      connecting wires on touchscreen. We need to provide an
+      8 bit number where in the 1st four bits represent the
+      analog lines and the next 4 bits represent positive/
+      negative terminal on that input line. Notations to
+      represent the input lines and terminals respectively
+      is as follows:
+      AIN0 = 0, AIN1 = 1 and so on till AIN7 = 7.
+      XP  = 0, XN = 1, YP = 2, YN = 3.
+      minItems: 4
+    items:
+      maximum: 0x73
+
+  ti,charge-delay:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Length of touch screen charge delay step in terms of
+      List of analog inputs available for ADC.
+      ADC clock cycles. Charge delay value should be large
+      in order to avoid false pen-up events. This value
+      effects the overall sampling speed, hence need to be
+      kept as low as possible, while avoiding false pen-up
+      event. Start from a lower value, say 0x400, and
+      increase value until false pen-up events are avoided.
+      The pen-up detection happens immediately after the
+      charge step, so this does in fact function as a
+      hardware knob for adjusting the amount of "settling time".
+    minimum: 0x1
+    maximum: 0xFFFF
+
+required:
+  - compatible
+  - ti,wires
+  - ti,coordinate-readouts
+  - ti,wire-config
+  - ti,x-plate-resistance
+
+additionalProperties: false
diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
deleted file mode 100644
index aad5e34965eb..000000000000
--- a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
+++ /dev/null
@@ -1,91 +0,0 @@
-* TI - TSC ADC (Touschscreen and analog digital converter)
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-Required properties:
-- mfd
-	compatible: Should be
-		"ti,am3359-tscadc" for AM335x/AM437x SoCs
-		"ti,am654-tscadc", "ti,am3359-tscadc" for AM654 SoCs
-- child "tsc"
-	compatible: Should be "ti,am3359-tsc".
-	ti,wires: Wires refer to application modes i.e. 4/5/8 wire touchscreen
-		  support on the platform.
-	ti,x-plate-resistance: X plate resistance
-	ti,coordinate-readouts: The sequencer supports a total of 16
-				programmable steps each step is used to
-				read a single coordinate. A single
-                                readout is enough but multiple reads can
-				increase the quality.
-				A value of 5 means, 5 reads for X, 5 for
-				Y and 2 for Z (always). This utilises 12
-				of the 16 software steps available. The
-				remaining 4 can be used by the ADC.
-	ti,wire-config: Different boards could have a different order for
-			connecting wires on touchscreen. We need to provide an
-			8 bit number where in the 1st four bits represent the
-			analog lines and the next 4 bits represent positive/
-			negative terminal on that input line. Notations to
-			represent the input lines and terminals resoectively
-			is as follows:
-			AIN0 = 0, AIN1 = 1 and so on till AIN7 = 7.
-			XP  = 0, XN = 1, YP = 2, YN = 3.
-- child "adc"
-	compatible: Should be
-		    "ti,am3359-adc" for AM335x/AM437x SoCs
-		    "ti,am654-adc", "ti,am3359-adc" for AM654 SoCs
-	ti,adc-channels: List of analog inputs available for ADC.
-			 AIN0 = 0, AIN1 = 1 and so on till AIN7 = 7.
-
-Optional properties:
-- child "tsc"
-	ti,charge-delay: Length of touch screen charge delay step in terms of
-			 ADC clock cycles. Charge delay value should be large
-			 in order to avoid false pen-up events. This value
-			 effects the overall sampling speed, hence need to be
-			 kept as low as possible, while avoiding false pen-up
-			 event. Start from a lower value, say 0x400, and
-			 increase value until false pen-up events are avoided.
-			 The pen-up detection happens immediately after the
-			 charge step, so this does in fact function as a
-			 hardware knob for adjusting the amount of "settling
-			 time".
-
-- child "adc"
-	ti,chan-step-opendelay: List of open delays for each channel of
-				ADC in the order of ti,adc-channels. The
-				value corresponds to the number of ADC
-				clock cycles to wait after applying the
-				step configuration registers and before
-				sending the start of ADC conversion.
-				Maximum value is 0x3FFFF.
-       ti,chan-step-sampledelay: List of sample delays for each channel
-				  of ADC in the order of ti,adc-channels.
-				  The value corresponds to the number of
-				  ADC clock cycles to sample (to hold
-				  start of conversion high).
-				  Maximum value is 0xFF.
-       ti,chan-step-avg: Number of averages to be performed for each
-			  channel of ADC. If average is 16 then input
-			  is sampled 16 times and averaged to get more
-			  accurate value. This increases the time taken
-			  by ADC to generate a sample. Valid range is 0
-			  average to 16 averages. Maximum value is 16.
-
-Example:
-	tscadc: tscadc@44e0d000 {
-		compatible = "ti,am3359-tscadc";
-		tsc {
-			ti,wires = <4>;
-			ti,x-plate-resistance = <200>;
-			ti,coordiante-readouts = <5>;
-			ti,wire-config = <0x00 0x11 0x22 0x33>;
-			ti,charge-delay = <0x400>;
-		};
-
-		adc {
-			ti,adc-channels = <4 5 6 7>;
-			ti,chan-step-opendelay = <0x098 0x3ffff 0x098 0x0>;
-			ti,chan-step-sampledelay = <0xff 0x0 0xf 0x0>;
-			ti,chan-step-avg = <16 2 4 8>;
-		};
-	}
diff --git a/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml b/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
new file mode 100644
index 000000000000..61854b61e378
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti,am3359-tscadc.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ti,am3359-tscadc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bindings for Touchscreen + ADC MFD IPs on TI SoCs
+
+maintainers:
+  - Vignesh Raghavendra <vigneshr@ti.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - ti,am654-tscadc
+          - const: ti,am3359-tscadc
+      - const: ti,am3359-tscadc
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
+    const: "adc_tsc_fck"
+
+  dmas:
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: fifo0
+      - const: fifo1
+
+  power-domains: true
+
+  tsc:
+    $ref: ../input/touchscreen/ti,am3359-tsc.yaml
+    description:
+      Bindings for Touchscreen part of the MFD
+
+  adc:
+    $ref: ../iio/adc/ti,am3359-adc.yaml
+    description:
+      Bindings for ADC part of the MFD
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: ti,am654-tscadc
+then:
+  properties:
+    tsc: false
+
+examples:
+  - |
+    tscadc@44e0d000 {
+      compatible = "ti,am3359-tscadc";
+      reg = <0x44e0d000 0x1000>;
+      interrupts = <16>;
+        tsc {
+          compatible = "ti,am3359-tsc";
+          ti,wires = <4>;
+          ti,x-plate-resistance = <200>;
+          ti,coordinate-readouts = <5>;
+          ti,wire-config = <0x00 0x11 0x22 0x33>;
+          ti,charge-delay = <0x400>;
+        };
+
+      adc {
+        compatible = "ti,am3359-adc";
+        ti,adc-channels = <4 5 6 7>;
+        ti,chan-step-opendelay = <0x098 0x3ffff 0x098 0x0>;
+        ti,chan-step-sampledelay = <0xff 0x0 0xf 0x0>;
+        ti,chan-step-avg = <16 2 4 8>;
+        #io-channel-cells = <1>;
+      };
+    };
-- 
2.32.0

