Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 102FF13C37B
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2020 14:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgAONqV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jan 2020 08:46:21 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:27542 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726071AbgAONqV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jan 2020 08:46:21 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00FDd6Kp032119;
        Wed, 15 Jan 2020 14:45:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=5SVANsPP3r8hlB7rFp9BZdgd6E2Gkc0NPbNEQYjFajA=;
 b=eCs0nbUKgF/jtkqb0pqbqfP3HdJCdrBDWUFnvqE40in+HK7CvCFTTg1W826HQf0LP0aK
 XdNfJQX1Zk/Vq6Bm1ed+SY7REp/+ZoULRfMgNojFMhSaQ+Q0/RO96cpflMBpZaHOmvPt
 t7PnO0qFAyrKtDhL0iV3BVnRWKa7Q0CWz4POJ0J6bHuDJk4A/GBqksxUoBUkuJbWXTNz
 CRt+yrIEbBZ1StCmm83zGjJcjjPLMScQqkwfygnm9SgOqRO67OKPMLPNGISHOeSzISp7
 B8XUZWcXm7DTYQAo3cQTPoVfaxRL9xY7UPAZiyIFDFWxVVjfaGgAA8FR6y7+TGLcbf0b Sw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xf7fnucht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jan 2020 14:45:50 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1501610002A;
        Wed, 15 Jan 2020 14:45:49 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D36E62B1890;
        Wed, 15 Jan 2020 14:45:49 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Jan 2020 14:45:49
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <robh+dt@kernel.org>, <jic23@kernel.org>
CC:     <alexandre.torgue@st.com>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <fabrice.gasnier@st.com>,
        <olivier.moysan@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] dt-bindings: iio: adc: stm32-adc: convert bindings to json-schema
Date:   Wed, 15 Jan 2020 14:45:41 +0100
Message-ID: <1579095941-18648-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-15_02:2020-01-15,2020-01-15 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert the STM32 ADC binding to DT schema format using json-schema

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
Changes in V3:
- Fix minimum and maximum syntax for uint32-array properties as pointed
  out by Rob.
- update example to better show this syntax e.g. st,adc-channels = <0 1>;

Changes in V2:
- Take almost all of Rob suggestions (removed reg generic description,
  added minItems, maxItems, st,max-clk-rate-hz range, drop some pipes,
  simplify clock-names, remove unneeded allOfs)
- For now, keep all in one file despite there are lots of if/thens in the
  bindings
---
 .../devicetree/bindings/iio/adc/st,stm32-adc.txt   | 149 -------
 .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  | 458 +++++++++++++++++++++
 2 files changed, 458 insertions(+), 149 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
deleted file mode 100644
index 8de9331..00000000
--- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.txt
+++ /dev/null
@@ -1,149 +0,0 @@
-STMicroelectronics STM32 ADC device driver
-
-STM32 ADC is a successive approximation analog-to-digital converter.
-It has several multiplexed input channels. Conversions can be performed
-in single, continuous, scan or discontinuous mode. Result of the ADC is
-stored in a left-aligned or right-aligned 32-bit data register.
-Conversions can be launched in software or using hardware triggers.
-
-The analog watchdog feature allows the application to detect if the input
-voltage goes beyond the user-defined, higher or lower thresholds.
-
-Each STM32 ADC block can have up to 3 ADC instances.
-
-Each instance supports two contexts to manage conversions, each one has its
-own configurable sequence and trigger:
-- regular conversion can be done in sequence, running in background
-- injected conversions have higher priority, and so have the ability to
-  interrupt regular conversion sequence (either triggered in SW or HW).
-  Regular sequence is resumed, in case it has been interrupted.
-
-Contents of a stm32 adc root node:
------------------------------------
-Required properties:
-- compatible: Should be one of:
-  "st,stm32f4-adc-core"
-  "st,stm32h7-adc-core"
-  "st,stm32mp1-adc-core"
-- reg: Offset and length of the ADC block register set.
-- interrupts: One or more interrupts for ADC block. Some parts like stm32f4
-  and stm32h7 share a common ADC interrupt line. stm32mp1 has two separate
-  interrupt lines, one for each ADC within ADC block.
-- clocks: Core can use up to two clocks, depending on part used:
-  - "adc" clock: for the analog circuitry, common to all ADCs.
-    It's required on stm32f4.
-    It's optional on stm32h7.
-  - "bus" clock: for registers access, common to all ADCs.
-    It's not present on stm32f4.
-    It's required on stm32h7.
-- clock-names: Must be "adc" and/or "bus" depending on part used.
-- interrupt-controller: Identifies the controller node as interrupt-parent
-- vdda-supply: Phandle to the vdda input analog voltage.
-- vref-supply: Phandle to the vref input analog reference voltage.
-- #interrupt-cells = <1>;
-- #address-cells = <1>;
-- #size-cells = <0>;
-
-Optional properties:
-- A pinctrl state named "default" for each ADC channel may be defined to set
-  inX ADC pins in mode of operation for analog input on external pin.
-- booster-supply: Phandle to the embedded booster regulator that can be used
-  to supply ADC analog input switches on stm32h7 and stm32mp1.
-- vdd-supply: Phandle to the vdd input voltage. It can be used to supply ADC
-  analog input switches on stm32mp1.
-- st,syscfg: Phandle to system configuration controller. It can be used to
-  control the analog circuitry on stm32mp1.
-- st,max-clk-rate-hz: Allow to specify desired max clock rate used by analog
-  circuitry.
-
-Contents of a stm32 adc child node:
------------------------------------
-An ADC block node should contain at least one subnode, representing an
-ADC instance available on the machine.
-
-Required properties:
-- compatible: Should be one of:
-  "st,stm32f4-adc"
-  "st,stm32h7-adc"
-  "st,stm32mp1-adc"
-- reg: Offset of ADC instance in ADC block (e.g. may be 0x0, 0x100, 0x200).
-- clocks: Input clock private to this ADC instance. It's required only on
-  stm32f4, that has per instance clock input for registers access.
-- interrupts: IRQ Line for the ADC (e.g. may be 0 for adc@0, 1 for adc@100 or
-  2 for adc@200).
-- st,adc-channels: List of single-ended channels muxed for this ADC.
-  It can have up to 16 channels on stm32f4 or 20 channels on stm32h7, numbered
-  from 0 to 15 or 19 (resp. for in0..in15 or in0..in19).
-- st,adc-diff-channels: List of differential channels muxed for this ADC.
-  Depending on part used, some channels can be configured as differential
-  instead of single-ended (e.g. stm32h7). List here positive and negative
-  inputs pairs as <vinp vinn>, <vinp vinn>,... vinp and vinn are numbered
-  from 0 to 19 on stm32h7)
-  Note: At least one of "st,adc-channels" or "st,adc-diff-channels" is required.
-  Both properties can be used together. Some channels can be used as
-  single-ended and some other ones as differential (mixed). But channels
-  can't be configured both as single-ended and differential (invalid).
-- #io-channel-cells = <1>: See the IIO bindings section "IIO consumers" in
-  Documentation/devicetree/bindings/iio/iio-bindings.txt
-
-Optional properties:
-- dmas: Phandle to dma channel for this ADC instance.
-  See ../../dma/dma.txt for details.
-- dma-names: Must be "rx" when dmas property is being used.
-- assigned-resolution-bits: Resolution (bits) to use for conversions. Must
-  match device available resolutions:
-  * can be 6, 8, 10 or 12 on stm32f4
-  * can be 8, 10, 12, 14 or 16 on stm32h7
-  Default is maximum resolution if unset.
-- st,min-sample-time-nsecs: Minimum sampling time in nanoseconds.
-  Depending on hardware (board) e.g. high/low analog input source impedance,
-  fine tune of ADC sampling time may be recommended.
-  This can be either one value or an array that matches 'st,adc-channels' list,
-  to set sample time resp. for all channels, or independently for each channel.
-
-Example:
-	adc: adc@40012000 {
-		compatible = "st,stm32f4-adc-core";
-		reg = <0x40012000 0x400>;
-		interrupts = <18>;
-		clocks = <&rcc 0 168>;
-		clock-names = "adc";
-		vref-supply = <&reg_vref>;
-		interrupt-controller;
-		pinctrl-names = "default";
-		pinctrl-0 = <&adc3_in8_pin>;
-
-		#interrupt-cells = <1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		adc@0 {
-			compatible = "st,stm32f4-adc";
-			#io-channel-cells = <1>;
-			reg = <0x0>;
-			clocks = <&rcc 0 168>;
-			interrupt-parent = <&adc>;
-			interrupts = <0>;
-			st,adc-channels = <8>;
-			dmas = <&dma2 0 0 0x400 0x0>;
-			dma-names = "rx";
-			assigned-resolution-bits = <8>;
-		};
-		...
-		other adc child nodes follow...
-	};
-
-Example to setup:
-- channel 1 as single-ended
-- channels 2 & 3 as differential (with resp. 6 & 7 negative inputs)
-
-	adc: adc@40022000 {
-		compatible = "st,stm32h7-adc-core";
-		...
-		adc1: adc@0 {
-			compatible = "st,stm32h7-adc";
-			...
-			st,adc-channels = <1>;
-			st,adc-diff-channels = <2 6>, <3 7>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
new file mode 100644
index 00000000..933ba37
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
@@ -0,0 +1,458 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/bindings/iio/adc/st,stm32-adc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: STMicroelectronics STM32 ADC bindings
+
+description: |
+  STM32 ADC is a successive approximation analog-to-digital converter.
+  It has several multiplexed input channels. Conversions can be performed
+  in single, continuous, scan or discontinuous mode. Result of the ADC is
+  stored in a left-aligned or right-aligned 32-bit data register.
+  Conversions can be launched in software or using hardware triggers.
+
+  The analog watchdog feature allows the application to detect if the input
+  voltage goes beyond the user-defined, higher or lower thresholds.
+
+  Each STM32 ADC block can have up to 3 ADC instances.
+
+maintainers:
+  - Fabrice Gasnier <fabrice.gasnier@st.com>
+
+properties:
+  compatible:
+    enum:
+      - st,stm32f4-adc-core
+      - st,stm32h7-adc-core
+      - st,stm32mp1-adc-core
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: |
+      One or more interrupts for ADC block, depending on part used:
+        - stm32f4 and stm32h7 share a common ADC interrupt line.
+        - stm32mp1 has two separate interrupt lines, one for each ADC within
+          ADC block.
+    minItems: 1
+    maxItems: 2
+
+  clocks:
+    description: |
+      Core can use up to two clocks, depending on part used:
+        - "adc" clock: for the analog circuitry, common to all ADCs.
+          It's required on stm32f4.
+          It's optional on stm32h7 and stm32mp1.
+        - "bus" clock: for registers access, common to all ADCs.
+          It's not present on stm32f4.
+          It's required on stm32h7 and stm32mp1.
+
+  clock-names: true
+
+  st,max-clk-rate-hz:
+    description:
+      Allow to specify desired max clock rate used by analog circuitry.
+
+  vdda-supply:
+    description: Phandle to the vdda input analog voltage.
+
+  vref-supply:
+    description: Phandle to the vref input analog reference voltage.
+
+  booster-supply:
+    description:
+      Phandle to the embedded booster regulator that can be used to supply ADC
+      analog input switches on stm32h7 and stm32mp1.
+
+  vdd-supply:
+    description:
+      Phandle to the vdd input voltage. It can be used to supply ADC analog
+      input switches on stm32mp1.
+
+  st,syscfg:
+    description:
+      Phandle to system configuration controller. It can be used to control the
+      analog circuitry on stm32mp1.
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/phandle-array"
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: st,stm32f4-adc-core
+
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+
+        clock-names:
+          const: adc
+
+        interrupts:
+          items:
+            - description: interrupt line common for all ADCs
+
+        st,max-clk-rate-hz:
+          minimum: 600000
+          maximum: 36000000
+          default: 36000000
+
+        booster-supply: false
+
+        vdd-supply: false
+
+        st,syscfg: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: st,stm32h7-adc-core
+
+    then:
+      properties:
+        clocks:
+          minItems: 1
+          maxItems: 2
+
+        clock-names:
+          items:
+            - const: bus
+            - const: adc
+          minItems: 1
+          maxItems: 2
+
+        interrupts:
+          items:
+            - description: interrupt line common for all ADCs
+
+        st,max-clk-rate-hz:
+          minimum: 120000
+          maximum: 36000000
+          default: 36000000
+
+        vdd-supply: false
+
+        st,syscfg: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: st,stm32mp1-adc-core
+
+    then:
+      properties:
+        clocks:
+          minItems: 1
+          maxItems: 2
+
+        clock-names:
+          items:
+            - const: bus
+            - const: adc
+          minItems: 1
+          maxItems: 2
+
+        interrupts:
+          items:
+            - description: interrupt line for ADC1
+            - description: interrupt line for ADC2
+
+        st,max-clk-rate-hz:
+          minimum: 120000
+          maximum: 36000000
+          default: 36000000
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - vdda-supply
+  - vref-supply
+  - interrupt-controller
+  - '#interrupt-cells'
+  - '#address-cells'
+  - '#size-cells'
+
+patternProperties:
+  "^adc@[0-9]+$":
+    type: object
+    description:
+      An ADC block node should contain at least one subnode, representing an
+      ADC instance available on the machine.
+
+    properties:
+      compatible:
+        enum:
+          - st,stm32f4-adc
+          - st,stm32h7-adc
+          - st,stm32mp1-adc
+
+      reg:
+        description: |
+          Offset of ADC instance in ADC block. Valid values are:
+            - 0x0:   ADC1
+            - 0x100: ADC2
+            - 0x200: ADC3 (stm32f4 only)
+        maxItems: 1
+
+      '#io-channel-cells':
+        const: 1
+
+      interrupts:
+        description: |
+          IRQ Line for the ADC instance. Valid values are:
+            - 0 for adc@0
+            - 1 for adc@100
+            - 2 for adc@200 (stm32f4 only)
+        maxItems: 1
+
+      clocks:
+        description:
+          Input clock private to this ADC instance. It's required only on
+          stm32f4, that has per instance clock input for registers access.
+        maxItems: 1
+
+      dmas:
+        description: RX DMA Channel
+        maxItems: 1
+
+      dma-names:
+        const: rx
+
+      assigned-resolution-bits:
+        description: |
+          Resolution (bits) to use for conversions:
+            - can be 6, 8, 10 or 12 on stm32f4
+            - can be 8, 10, 12, 14 or 16 on stm32h7 and stm32mp1
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+
+      st,adc-channels:
+        description: |
+          List of single-ended channels muxed for this ADC. It can have up to:
+            - 16 channels, numbered from 0 to 15 (for in0..in15) on stm32f4
+            - 20 channels, numbered from 0 to 19 (for in0..in19) on stm32h7 and
+              stm32mp1.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32-array
+
+      st,adc-diff-channels:
+        description: |
+          List of differential channels muxed for this ADC. Some channels can
+          be configured as differential instead of single-ended on stm32h7 and
+          on stm32mp1. Positive and negative inputs pairs are listed:
+          <vinp vinn>, <vinp vinn>,... vinp and vinn are numbered from 0 to 19.
+
+          Note: At least one of "st,adc-channels" or "st,adc-diff-channels" is
+          required. Both properties can be used together. Some channels can be
+          used as single-ended and some other ones as differential (mixed). But
+          channels can't be configured both as single-ended and differential.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32-matrix
+          - items:
+              items:
+                - description: |
+                    "vinp" indicates positive input number
+                  minimum: 0
+                  maximum: 19
+                - description: |
+                    "vinn" indicates negative input number
+                  minimum: 0
+                  maximum: 19
+
+      st,min-sample-time-nsecs:
+        description:
+          Minimum sampling time in nanoseconds. Depending on hardware (board)
+          e.g. high/low analog input source impedance, fine tune of ADC
+          sampling time may be recommended. This can be either one value or an
+          array that matches "st,adc-channels" and/or "st,adc-diff-channels"
+          list, to set sample time resp. for all channels, or independently for
+          each channel.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32-array
+
+    allOf:
+      - if:
+          properties:
+            compatible:
+              contains:
+                const: st,stm32f4-adc
+
+        then:
+          properties:
+            reg:
+              enum:
+                - 0x0
+                - 0x100
+                - 0x200
+
+            interrupts:
+              minimum: 0
+              maximum: 2
+
+            assigned-resolution-bits:
+              enum: [6, 8, 10, 12]
+              default: 12
+
+            st,adc-channels:
+              minItems: 1
+              maxItems: 16
+              items:
+                minimum: 0
+                maximum: 15
+
+            st,adc-diff-channels: false
+
+            st,min-sample-time-nsecs:
+              minItems: 1
+              maxItems: 16
+              items:
+                minimum: 80
+
+          required:
+            - clocks
+
+      - if:
+          properties:
+            compatible:
+              contains:
+                enum:
+                  - st,stm32h7-adc
+                  - st,stm32mp1-adc
+
+        then:
+          properties:
+            reg:
+              enum:
+                - 0x0
+                - 0x100
+
+            interrupts:
+              minimum: 0
+              maximum: 1
+
+            assigned-resolution-bits:
+              enum: [8, 10, 12, 14, 16]
+              default: 16
+
+            st,adc-channels:
+              minItems: 1
+              maxItems: 20
+              items:
+                minimum: 0
+                maximum: 19
+
+            st,min-sample-time-nsecs:
+              minItems: 1
+              maxItems: 20
+              items:
+                minimum: 40
+
+    additionalProperties: false
+
+    anyOf:
+      - required:
+          - st,adc-channels
+      - required:
+          - st,adc-diff-channels
+
+    required:
+      - compatible
+      - reg
+      - interrupts
+      - '#io-channel-cells'
+
+examples:
+  - |
+    // Example 1: with stm32f429, ADC1, single-ended channel 8
+      adc123: adc@40012000 {
+        compatible = "st,stm32f4-adc-core";
+        reg = <0x40012000 0x400>;
+        interrupts = <18>;
+        clocks = <&rcc 0 168>;
+        clock-names = "adc";
+        st,max-clk-rate-hz = <36000000>;
+        vdda-supply = <&vdda>;
+        vref-supply = <&vref>;
+        interrupt-controller;
+        #interrupt-cells = <1>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        adc@0 {
+          compatible = "st,stm32f4-adc";
+          #io-channel-cells = <1>;
+          reg = <0x0>;
+          clocks = <&rcc 0 168>;
+          interrupt-parent = <&adc123>;
+          interrupts = <0>;
+          st,adc-channels = <8>;
+          dmas = <&dma2 0 0 0x400 0x0>;
+          dma-names = "rx";
+          assigned-resolution-bits = <8>;
+        };
+        // ...
+        // other adc child nodes follow...
+      };
+
+  - |
+    // Example 2: with stm32mp157c to setup ADC1 with:
+    // - channels 0 & 1 as single-ended
+    // - channels 2 & 3 as differential (with resp. 6 & 7 negative inputs)
+      #include <dt-bindings/interrupt-controller/arm-gic.h>
+      #include <dt-bindings/clock/stm32mp1-clks.h>
+      adc12: adc@48003000 {
+        compatible = "st,stm32mp1-adc-core";
+        reg = <0x48003000 0x400>;
+        interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&rcc ADC12>, <&rcc ADC12_K>;
+        clock-names = "bus", "adc";
+        booster-supply = <&booster>;
+        vdd-supply = <&vdd>;
+        vdda-supply = <&vdda>;
+        vref-supply = <&vref>;
+        st,syscfg = <&syscfg>;
+        interrupt-controller;
+        #interrupt-cells = <1>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        adc@0 {
+          compatible = "st,stm32mp1-adc";
+          #io-channel-cells = <1>;
+          reg = <0x0>;
+          interrupt-parent = <&adc12>;
+          interrupts = <0>;
+          st,adc-channels = <0 1>;
+          st,adc-diff-channels = <2 6>, <3 7>;
+          st,min-sample-time-nsecs = <5000>;
+          dmas = <&dmamux1 9 0x400 0x05>;
+          dma-names = "rx";
+        };
+        // ...
+        // other adc child node follow...
+      };
+
+...
-- 
2.7.4

