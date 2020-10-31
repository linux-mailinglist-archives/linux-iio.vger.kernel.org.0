Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A949C2A1A12
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgJaSw1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:52:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728487AbgJaSw0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:52:26 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9920320724;
        Sat, 31 Oct 2020 18:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170344;
        bh=Pm/yy0Q2hxf7hDFcvvd7sLFGzR+up/N4nay/Lf6oWcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jTRLmfKONuYBK6rXBqPrrvYWmxB1u09i8yxy2mnwSdzWRsOf2ZVmGd3enPdL+pEhv
         tBx9slVHL1uRtVC8cVCPw8EMuMCHDZHhV922ajUdbvIu8jaQTg/IyG+X9CE1dGNI1B
         fM3ip7VbWe4dsBbG/mz6e5/xjacH09uJE+NAW410=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Subject: [PATCH 39/46] dt-bindings:iio:dac:ad5755: txt to yaml format conversion.
Date:   Sat, 31 Oct 2020 18:48:47 +0000
Message-Id: <20201031184854.745828-40-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Straight forward conversion.  Only fiddly bit is the XOR of
spi-cpol and spi-cpha.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
---
 .../devicetree/bindings/iio/dac/ad5755.txt    | 124 ------------
 .../bindings/iio/dac/adi,ad5755.yaml          | 178 ++++++++++++++++++
 2 files changed, 178 insertions(+), 124 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/ad5755.txt b/Documentation/devicetree/bindings/iio/dac/ad5755.txt
deleted file mode 100644
index 502e1e55adbd..000000000000
--- a/Documentation/devicetree/bindings/iio/dac/ad5755.txt
+++ /dev/null
@@ -1,124 +0,0 @@
-* Analog Devices AD5755 IIO Multi-Channel DAC Linux Driver
-
-Required properties:
- - compatible: Has to contain one of the following:
-	adi,ad5755
-	adi,ad5755-1
-	adi,ad5757
-	adi,ad5735
-	adi,ad5737
-
- - reg: spi chip select number for the device
- - spi-cpha or spi-cpol: is the only modes that is supported
-
-Recommended properties:
- - spi-max-frequency: Definition as per
-		Documentation/devicetree/bindings/spi/spi-bus.txt
-
-Optional properties:
-See include/dt-bindings/iio/ad5755.h
- - adi,ext-dc-dc-compenstation-resistor: boolean set if the hardware have an
-					 external resistor and thereby bypasses
-					 the internal compensation resistor.
- - adi,dc-dc-phase:
-	Valid values for DC DC Phase control is:
-	0: All dc-to-dc converters clock on the same edge.
-	1: Channel A and Channel B clock on the same edge,
-	   Channel C and Channel D clock on opposite edges.
-	2: Channel A and Channel C clock on the same edge,
-	   Channel B and Channel D clock on opposite edges.
-	3: Channel A, Channel B, Channel C, and Channel D
-	   clock 90 degrees out of phase from each other.
- - adi,dc-dc-freq-hz:
-	Valid values for DC DC frequency is [Hz]:
-	250000
-	410000
-	650000
- - adi,dc-dc-max-microvolt:
-	Valid values for the maximum allowed Vboost voltage supplied by
-	the dc-to-dc converter is:
-	23000000
-	24500000
-	27000000
-	29500000
-
-Optional for every channel:
- - adi,mode:
-	Valid values for DAC modes is:
-	0: 0 V to 5 V voltage range.
-	1: 0 V to 10 V voltage range.
-	2: Plus minus 5 V voltage range.
-	3: Plus minus 10 V voltage range.
-	4: 4 mA to 20 mA current range.
-	5: 0 mA to 20 mA current range.
-	6: 0 mA to 24 mA current range.
- - adi,ext-current-sense-resistor: boolean set if the hardware a external
-				   current sense resistor.
- - adi,enable-voltage-overrange: boolean enable voltage overrange
- - adi,slew: Array of slewrate settings should contain 3 fields:
-	1: Should be either 0 or 1 in order to enable or disable slewrate.
-	2: Slew rate settings:
-		Valid values for the slew rate update frequency:
-		64000
-		32000
-		16000
-		8000
-		4000
-		2000
-		1000
-		500
-		250
-		125
-		64
-		32
-		16
-		8
-		4
-		0
-	3: Slew step size:
-		Valid values for the step size LSBs:
-		1
-		2
-		4
-		16
-		32
-		64
-		128
-		256
-
-Example:
-dac@0 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	compatible = "adi,ad5755";
-	reg = <0>;
-	spi-max-frequency = <1000000>;
-	spi-cpha;
-	adi,dc-dc-phase = <0>;
-	adi,dc-dc-freq-hz = <410000>;
-	adi,dc-dc-max-microvolt = <23000000>;
-	channel@0 {
-		reg = <0>;
-		adi,mode = <4>;
-		adi,ext-current-sense-resistor;
-		adi,slew = <0 64000 1>;
-	};
-	channel@1 {
-		reg = <1>;
-		adi,mode = <4>;
-		adi,ext-current-sense-resistor;
-		adi,slew = <0 64000 1>;
-	};
-	channel@2 {
-		reg = <2>;
-		adi,mode = <4>;
-		adi,ext-current-sense-resistor;
-		adi,slew = <0 64000 1>;
-	};
-	channel@3 {
-		reg = <3>;
-		adi,mode = <4>;
-		adi,ext-current-sense-resistor;
-		adi,slew = <0 64000 1>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5755.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5755.yaml
new file mode 100644
index 000000000000..74edff3e8408
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5755.yaml
@@ -0,0 +1,178 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad5755.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5755 Multi-Channel DAC
+
+maintainers:
+  - Sean Nyekjaer <sean.nyekjaer@prevas.dk>
+
+properties:
+  compatible:
+    enum:
+      - adi,ad5755
+      - adi,ad5755-1
+      - adi,ad5757
+      - adi,ad5735
+      - adi,ad5737
+
+  reg:
+    maxItems: 1
+
+  spi-cpha:
+    description: Either this or spi-cpol but not both.
+  spi-cpol: true
+
+  spi-max-frequency: true
+
+  adi,ext-dc-dc-compenstation-resistor:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Set if the hardware have an external resistor and thereby bypasses
+      the internal compensation resistor.
+
+  adi,dc-dc-phase:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+    description: |
+      Valid values for DC DC Phase control is:
+      0: All dc-to-dc converters clock on the same edge.
+      1: Channel A and Channel B clock on the same edge,
+         Channel C and Channel D clock on opposite edges.
+      2: Channel A and Channel C clock on the same edge,
+         Channel B and Channel D clock on opposite edges.
+      3: Channel A, Channel B, Channel C, and Channel D
+         clock 90 degrees out of phase from each other.
+
+  adi,dc-dc-freq-hz:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [250000, 410000, 650000]
+
+  adi,dc-dc-max-microvolt:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Maximum allowed Vboost voltage supplied by the dc-to-dc converter.
+    enum: [23000000, 24500000, 27000000, 29500000]
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+patternProperties:
+  "^(channel@)[0-7]$":
+    type: object
+    description: Child node to describe a channel
+    properties:
+      reg:
+        maxItems: 1
+
+      adi,mode:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 6
+        description: |
+          Valid values for DAC modes is:
+          0: 0 V to 5 V voltage range.
+          1: 0 V to 10 V voltage range.
+          2: Plus minus 5 V voltage range.
+          3: Plus minus 10 V voltage range.
+          4: 4 mA to 20 mA current range.
+          5: 0 mA to 20 mA current range.
+          6: 0 mA to 24 mA current range.
+
+      adi,ext-current-sense-resistor:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description:
+          Set if the hardware has an external current sense resistor
+
+      adi,enable-voltage-overrange:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description: Enable voltage overrange
+
+      adi,slew:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        description: |
+          Array of slewrate settings should contain 3 fields:
+          1: Should be either 0 or 1 in order to enable or disable slewrate.
+          2: Slew rate update frequency
+          3: Slew step size
+        items:
+          - enum: [0, 1]
+          - enum: [64000, 32000, 16000, 8000, 4000, 2000, 1000, 500, 250, 125, 64, 32, 16, 8, 4, 0]
+          - enum: [1, 2, 4, 16, 32, 64, 128, 256]
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+allOf:
+  - $ref: '#/definitions/cpolXORcpha'
+
+definitions:
+  cpolXORcpha:
+    not:
+      required: [spi-cpha, spi-cpol]
+    oneOf:
+      - required:
+          - spi-cpha
+      - required:
+          - spi-cpol
+
+examples:
+  - |
+    #include <dt-bindings/iio/adi,ad5592r.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            compatible = "adi,ad5755";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            spi-cpha;
+            adi,dc-dc-phase = <0>;
+            adi,dc-dc-freq-hz = <410000>;
+            adi,dc-dc-max-microvolt = <23000000>;
+            channel@0 {
+                reg = <0>;
+                adi,mode = <4>;
+                adi,ext-current-sense-resistor;
+                adi,slew = <0 64000 1>;
+            };
+            channel@1 {
+                reg = <1>;
+                adi,mode = <4>;
+                adi,ext-current-sense-resistor;
+                adi,slew = <0 64000 1>;
+            };
+            channel@2 {
+                reg = <2>;
+                adi,mode = <4>;
+                adi,ext-current-sense-resistor;
+                adi,slew = <0 64000 1>;
+            };
+            channel@3 {
+                reg = <3>;
+                adi,mode = <4>;
+                adi,ext-current-sense-resistor;
+                adi,slew = <0 64000 1>;
+            };
+        };
+    };
+...
-- 
2.28.0

