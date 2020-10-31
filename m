Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8102A19FA
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgJaSwO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:52:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728399AbgJaSwL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:52:11 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB64A20706;
        Sat, 31 Oct 2020 18:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170330;
        bh=1Q0ZJ/Wana9Pw/ke3PIV+04f2kJRfZw43bG3mikPiHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iEz621HeRFYd/wuqe6Ad7T4yAeuxtpMGOtpITNc/Ydqipaf7rresHThPcVRP2faWv
         slf+U/DZWNU1o+91vtOsTp3uyo/0GaLsafYbYy5jMEx36WFhMwxS1MwTKMJofjwlD8
         82bin0QiHMFqak1DH9bB/891v4//c5KSzf6IjSt8=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH 29/46] dt-bindings:iio:adc:atmel,sama9260-adc: conversion to yaml from at91_adc.txt
Date:   Sat, 31 Oct 2020 18:48:37 +0000
Message-Id: <20201031184854.745828-30-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This binding raises a few questions.
1) Do we need #address-cells and #size-cells as the child nodes don't have
   a reg property?  A few dtsi files include these so if we drop the
   requirement we will need to clean those up as well.
2) Renamed to a specific part.  Given we have another at91 ADC binding
   it is clear now this won't cover all at91 parts so lets name it
   after a specific part.
3) For atmel,adc-res-names the description is a big vague.  Are other
   resolution names allowed? We don't seem to have any currently.

There are a few things we would do differently in an ADC binding if we
were starting from scratch but we are stuck with what we have (which
made sense back when this was written!)

We may be able to tighten up some elements of this binding in the future
by careful checking of what values properties can actually take.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
---
 .../devicetree/bindings/iio/adc/at91_adc.txt  |  83 --------
 .../bindings/iio/adc/atmel,sama9260-adc.yaml  | 178 ++++++++++++++++++
 2 files changed, 178 insertions(+), 83 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/at91_adc.txt b/Documentation/devicetree/bindings/iio/adc/at91_adc.txt
deleted file mode 100644
index f65b04fb7962..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/at91_adc.txt
+++ /dev/null
@@ -1,83 +0,0 @@
-* AT91's Analog to Digital Converter (ADC)
-
-Required properties:
-  - compatible: Should be "atmel,<chip>-adc"
-    <chip> can be "at91sam9260", "at91sam9g45" or "at91sam9x5"
-  - reg: Should contain ADC registers location and length
-  - interrupts: Should contain the IRQ line for the ADC
-  - clock-names: tuple listing input clock names.
-	Required elements: "adc_clk", "adc_op_clk".
-  - clocks: phandles to input clocks.
-  - atmel,adc-channels-used: Bitmask of the channels muxed and enabled for this
-    device
-  - atmel,adc-startup-time: Startup Time of the ADC in microseconds as
-    defined in the datasheet
-  - atmel,adc-vref: Reference voltage in millivolts for the conversions
-  - atmel,adc-res: List of resolutions in bits supported by the ADC. List size
-		   must be two at least.
-  - atmel,adc-res-names: Contains one identifier string for each resolution
-			 in atmel,adc-res property. "lowres" and "highres"
-			 identifiers are required.
-
-Optional properties:
-  - atmel,adc-use-external-triggers: Boolean to enable the external triggers
-  - atmel,adc-use-res: String corresponding to an identifier from
-		       atmel,adc-res-names property. If not specified, the highest
-		       resolution will be used.
-  - atmel,adc-sleep-mode: Boolean to enable sleep mode when no conversion
-  - atmel,adc-sample-hold-time: Sample and Hold Time in microseconds
-  - atmel,adc-ts-wires: Number of touchscreen wires. Should be 4 or 5. If this
-                        value is set, then the adc driver will enable touchscreen
-                        support.
-    NOTE: when adc touchscreen is enabled, the adc hardware trigger will be
-          disabled. Since touchscreen will occupy the trigger register.
-  - atmel,adc-ts-pressure-threshold: a pressure threshold for touchscreen. It
-                                     makes touch detection more precise.
-
-Optional trigger Nodes:
-  - Required properties:
-    * trigger-name: Name of the trigger exposed to the user
-    * trigger-value: Value to put in the Trigger register
-      to activate this trigger
-  - Optional properties:
-    * trigger-external: Is the trigger an external trigger?
-
-Examples:
-adc0: adc@fffb0000 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	compatible = "atmel,at91sam9260-adc";
-	reg = <0xfffb0000 0x100>;
-	interrupts = <20 IRQ_TYPE_LEVEL_HIGH 0>;
-	clocks = <&adc_clk>, <&adc_op_clk>;
-	clock-names = "adc_clk", "adc_op_clk";
-	atmel,adc-channels-used = <0xff>;
-	atmel,adc-startup-time = <40>;
-	atmel,adc-use-external-triggers;
-	atmel,adc-vref = <3300>;
-	atmel,adc-res = <8 10>;
-	atmel,adc-res-names = "lowres", "highres";
-	atmel,adc-use-res = "lowres";
-
-	trigger0 {
-		trigger-name = "external-rising";
-		trigger-value = <0x1>;
-		trigger-external;
-	};
-	trigger1 {
-		trigger-name = "external-falling";
-		trigger-value = <0x2>;
-		trigger-external;
-	};
-
-	trigger2 {
-		trigger-name = "external-any";
-		trigger-value = <0x3>;
-		trigger-external;
-	};
-
-	trigger3 {
-		trigger-name = "continuous";
-		trigger-value = <0x6>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/iio/adc/atmel,sama9260-adc.yaml b/Documentation/devicetree/bindings/iio/adc/atmel,sama9260-adc.yaml
new file mode 100644
index 000000000000..c480e835e5a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/atmel,sama9260-adc.yaml
@@ -0,0 +1,178 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/atmel,sama9260-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AT91 sama9260 and similar Analog to Digital Converter (ADC)
+
+maintainers:
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+
+properties:
+  compatible:
+    enum:
+      - atmel,at91sam9260-adc
+      - atmel,at91sam9rl-adc
+      - atmel,at91sam9g45-adc
+      - atmel,at91sam9x5-adc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: adc_clk
+      - const: adc_op_clk
+
+  atmel,adc-channels-used:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Bitmask of the channels muxed and enabled for this device
+
+  atmel,adc-startup-time:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Startup Time of the ADC in microseconds as defined in the datasheet
+
+  atmel,adc-vref:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Reference voltage in millivolts for the conversions
+
+  atmel,adc-res:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: List of resolutions in bits supported by the ADC.
+    minItems: 2
+
+  atmel,adc-res-names:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    description: |
+      Contains one identifier string for each resolution in atmel,adc-res
+      property. lowres and highres identifiers are required.
+
+  atmel,adc-use-external-triggers:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Enable the external triggers
+
+  atmel,adc-use-res:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      String corresponding to an identifier from atmel,adc-res-names property.
+      If not specified, the highest resolution will be used.
+
+  atmel,adc-sleep-mode:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Enable sleep mode when no conversion
+
+  atmel,adc-sample-hold-time:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Sample and Hold Time in microseconds
+
+  atmel,adc-ts-wires:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Number of touchscreen wires. Must be set to enable touchscreen.
+      NOTE: when adc touchscreen is enabled, the adc hardware trigger will be
+      disabled. Since touchscreen will occupy the trigger register.
+    enum:
+      - 4
+      - 5
+
+  atmel,adc-ts-pressure-threshold:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Pressure threshold for touchscreen.
+
+  "#io-channel-cells":
+    const: 1
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - atmel,adc-channels-used
+  - atmel,adc-startup-time
+  - atmel,adc-vref
+  - atmel,adc-res
+  - atmel,adc-res-names
+
+patternProperties:
+  "^(trigger)[0-9]$":
+    type: object
+    description: Child node to describe a trigger exposed to the user.
+    properties:
+      trigger-name:
+        $ref: /schemas/types.yaml#/definitions/string
+        description: Identifying name.
+
+      trigger-value:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Value to put in the Trigger register to activate this trigger
+
+      trigger-external:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description: This trigger is provided from an external pin.
+
+    additionalProperties: false
+    required:
+      - trigger-name
+      - trigger-value
+
+examples:
+  - |
+    #include <dt-bindings/dma/at91.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        adc@fffb0000 {
+            compatible = "atmel,at91sam9260-adc";
+            reg = <0xfffb0000 0x100>;
+            interrupts = <20 IRQ_TYPE_LEVEL_HIGH 0>;
+            clocks = <&adc_clk>, <&adc_op_clk>;
+            clock-names = "adc_clk", "adc_op_clk";
+            atmel,adc-channels-used = <0xff>;
+            atmel,adc-startup-time = <40>;
+            atmel,adc-use-external-triggers;
+            atmel,adc-vref = <3300>;
+            atmel,adc-res = <8 10>;
+            atmel,adc-res-names = "lowres", "highres";
+            atmel,adc-use-res = "lowres";
+
+            trigger0 {
+                trigger-name = "external-rising";
+                trigger-value = <0x1>;
+                trigger-external;
+            };
+
+            trigger1 {
+                trigger-name = "external-falling";
+                trigger-value = <0x2>;
+                trigger-external;
+            };
+
+            trigger2 {
+                trigger-name = "external-any";
+                trigger-value = <0x3>;
+                trigger-external;
+            };
+
+            trigger3 {
+                trigger-name = "continuous";
+                trigger-value = <0x6>;
+            };
+        };
+    };
+...
-- 
2.28.0

