Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA4EB9B2B5
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2019 16:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395550AbfHWOzC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Aug 2019 10:55:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395548AbfHWOzB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 23 Aug 2019 10:55:01 -0400
Received: from localhost.localdomain (unknown [194.230.147.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46F3C23401;
        Fri, 23 Aug 2019 14:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566572099;
        bh=2zZ3n85/0UHPMbcgkgeEEMmql7o89Jja/uNBLg2lFsE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sbKoecBeP/pwwwYNFfR4aEw8QvN3rGUFfH1L0YLwLZhyZm8CseRmMofijqNEJwLiK
         vz0GjWUdhEjwQQlhd2mRyA1o8M/ItwTQJLJJiKszdFb9joEhwvYKZmJMqPBcLX4WL7
         PVqAEJYpFzs+xB7zvavDe3Ik1PxlOuXqahe8DaMU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-rtc@vger.kernel.org
Cc:     notify@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>
Subject: [RFC 8/9] dt-bindings: iio: adc: exynos: Convert Exynos ADC bindings to json-schema
Date:   Fri, 23 Aug 2019 16:53:55 +0200
Message-Id: <20190823145356.6341-8-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190823145356.6341-1-krzk@kernel.org>
References: <20190823145356.6341-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert Samsung Exynos Analog to Digital Converter bindings to DT schema
format using json-schema.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../bindings/iio/adc/samsung,exynos-adc.txt   | 107 ------------
 .../bindings/iio/adc/samsung,exynos-adc.yaml  | 159 ++++++++++++++++++
 2 files changed, 159 insertions(+), 107 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.txt b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.txt
deleted file mode 100644
index e1fe02f3e3e9..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.txt
+++ /dev/null
@@ -1,107 +0,0 @@
-Samsung Exynos Analog to Digital Converter bindings
-
-The devicetree bindings are for the new ADC driver written for
-Exynos4 and upward SoCs from Samsung.
-
-New driver handles the following
-1. Supports ADC IF found on EXYNOS4412/EXYNOS5250
-   and future SoCs from Samsung
-2. Add ADC driver under iio/adc framework
-3. Also adds the Documentation for device tree bindings
-
-Required properties:
-- compatible:		Must be "samsung,exynos-adc-v1"
-				for Exynos5250 controllers.
-			Must be "samsung,exynos-adc-v2" for
-				future controllers.
-			Must be "samsung,exynos3250-adc" for
-				controllers compatible with ADC of Exynos3250.
-			Must be "samsung,exynos4212-adc" for
-				controllers compatible with ADC of Exynos4212 and Exynos4412.
-			Must be "samsung,exynos7-adc" for
-				the ADC in Exynos7 and compatibles
-			Must be "samsung,s3c2410-adc" for
-				the ADC in s3c2410 and compatibles
-			Must be "samsung,s3c2416-adc" for
-				the ADC in s3c2416 and compatibles
-			Must be "samsung,s3c2440-adc" for
-				the ADC in s3c2440 and compatibles
-			Must be "samsung,s3c2443-adc" for
-				the ADC in s3c2443 and compatibles
-			Must be "samsung,s3c6410-adc" for
-				the ADC in s3c6410 and compatibles
-			Must be "samsung,s5pv210-adc" for
-				the ADC in s5pv210 and compatibles
-- reg:			List of ADC register address range
-			- The base address and range of ADC register
-			- The base address and range of ADC_PHY register (every
-			  SoC except for s3c24xx/s3c64xx ADC)
-- interrupts: 		Contains the interrupt information for the timer. The
-			format is being dependent on which interrupt controller
-			the Samsung device uses.
-- #io-channel-cells = <1>; As ADC has multiple outputs
-- clocks		From common clock bindings: handles to clocks specified
-			in "clock-names" property, in the same order.
-- clock-names		From common clock bindings: list of clock input names
-			used by ADC block:
-			- "adc" : ADC bus clock
-			- "sclk" : ADC special clock (only for Exynos3250 and
-				   compatible ADC block)
-- vdd-supply		VDD input supply.
-
-- samsung,syscon-phandle Contains the PMU system controller node
-			(To access the ADC_PHY register on Exynos5250/5420/5800/3250)
-Optional properties:
-- has-touchscreen:	If present, indicates that a touchscreen is
-			connected an usable.
-
-Note: child nodes can be added for auto probing from device tree.
-
-Example: adding device info in dtsi file
-
-adc: adc@12d10000 {
-	compatible = "samsung,exynos-adc-v1";
-	reg = <0x12D10000 0x100>;
-	interrupts = <0 106 0>;
-	#io-channel-cells = <1>;
-	io-channel-ranges;
-
-	clocks = <&clock 303>;
-	clock-names = "adc";
-
-	vdd-supply = <&buck5_reg>;
-	samsung,syscon-phandle = <&pmu_system_controller>;
-};
-
-Example: adding device info in dtsi file for Exynos3250 with additional sclk
-
-adc: adc@126c0000 {
-	compatible = "samsung,exynos3250-adc", "samsung,exynos-adc-v2;
-	reg = <0x126C0000 0x100>;
-	interrupts = <0 137 0>;
-	#io-channel-cells = <1>;
-	io-channel-ranges;
-
-	clocks = <&cmu CLK_TSADC>, <&cmu CLK_SCLK_TSADC>;
-	clock-names = "adc", "sclk";
-
-	vdd-supply = <&buck5_reg>;
-	samsung,syscon-phandle = <&pmu_system_controller>;
-};
-
-Example: Adding child nodes in dts file
-
-adc@12d10000 {
-
-	/* NTC thermistor is a hwmon device */
-	ncp15wb473@0 {
-		compatible = "murata,ncp15wb473";
-		pullup-uv = <1800000>;
-		pullup-ohm = <47000>;
-		pulldown-ohm = <0>;
-		io-channels = <&adc 4>;
-	};
-};
-
-Note: Does not apply to ADC driver under arch/arm/plat-samsung/
-Note: The child node can be added under the adc node or separately.
diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
new file mode 100644
index 000000000000..c989d455b508
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
@@ -0,0 +1,159 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/samsung,exynos-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos Analog to Digital Converter (ADC)
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - samsung,exynos-adc-v1                 # Exynos5250
+          - samsung,exynos-adc-v2
+          - samsung,exynos3250-adc
+          - samsung,exynos4212-adc                # Exynos4212 and Exynos4412
+          - samsung,exynos7-adc
+          - samsung,s3c2410-adc
+          - samsung,s3c2416-adc
+          - samsung,s3c2440-adc
+          - samsung,s3c2443-adc
+          - samsung,s3c6410-adc
+          - samsung,s5pv210-adc
+  reg:
+    oneOf:
+      - items:
+          - description: base registers
+      - items:
+          # For S5P and Exynos
+          - description: base registers
+          - description: phy registers
+
+  clocks:
+    description:
+      Phandle to ADC bus clock. For Exynos3250 additional clock is needed.
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    description:
+      Must contain clock names matching phandles in clocks property.
+    oneOf:
+      - items:
+          - const: adc
+      - items:
+          # TODO: This can be in any order matching clocks, how to express it?
+          - const: adc
+          - const: sclk
+
+  interrupts:
+    maxItems: 1
+
+  "#io-channel-cells":
+    const: 1
+
+  vdd-supply:
+    description: VDD input supply
+    maxItems: 1
+
+  samsung,syscon-phandle:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    # TODO: reference to PMU schema?
+    description:
+      Phandle to the PMU system controller node (to access the ADC_PHY
+      register on Exynos5250/5420/5800/3250)
+    maxItems: 1
+
+  has-touchscreen:
+    description: If present, indicates that a touchscreen is connected an usable
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - "#io-channel-cells"
+  - samsung,syscon-phandle
+  - vdd-supply
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,exynos-adc-v1
+              - samsung,exynos-adc-v2
+              - samsung,exynos3250-adc
+              - samsung,exynos4212-adc
+              - samsung,exynos7-adc
+              - samsung,s5pv210-adc
+    then:
+      properties:
+        reg:
+          items:
+            # For S5P and Exynos
+            - description: base registers
+            - description: phy registers
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,exynos3250-adc
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+        clock-names:
+          items:
+          - const: adc
+          - const: sclk
+
+examples:
+  - |
+    adc: adc@12d10000 {
+      compatible = "samsung,exynos-adc-v1";
+      reg = <0x12d10000 0x100>;
+      interrupts = <0 106 0>;
+      #io-channel-cells = <1>;
+      io-channel-ranges;
+
+      clocks = <&clock 303>;
+      clock-names = "adc";
+
+      vdd-supply = <&buck5_reg>;
+      samsung,syscon-phandle = <&pmu_system_controller>;
+
+      /* NTC thermistor is a hwmon device */
+      ncp15wb473@0 {
+        compatible = "murata,ncp15wb473";
+        pullup-uv = <1800000>;
+        pullup-ohm = <47000>;
+        pulldown-ohm = <0>;
+        io-channels = <&adc 4>;
+      };
+    };
+
+  - |
+    adc@126c0000 {
+      compatible = "samsung,exynos3250-adc";
+      reg = <0x126C0000 0x100>;
+      interrupts = <0 137 0>;
+      #io-channel-cells = <1>;
+      io-channel-ranges;
+
+      clocks = <&cmu 0>, // CLK_TSADC
+               <&cmu 1>; // CLK_SCLK_TSADC
+      clock-names = "adc", "sclk";
+
+      vdd-supply = <&buck5_reg>;
+      samsung,syscon-phandle = <&pmu_system_controller>;
+    };
-- 
2.17.1

