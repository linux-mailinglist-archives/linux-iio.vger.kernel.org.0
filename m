Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB502A19FE
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgJaSwP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:52:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728456AbgJaSwN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:52:13 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2434205ED;
        Sat, 31 Oct 2020 18:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170331;
        bh=+pI2CXGiE+I6mLa2YboecZU7GwgiJdcZktZELuuO7IA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BzIQBnrHlsDu9L6+6qARiYOGB+IrePopZmX9O+pJpDoBoUl0v030tLyK/cCCnlOEW
         o6dHxdpdh50BdADxCWpDs8Xl/CRe149n9pw/lyrG2btWYAkmK6ahLPb5QPBiiFC0xd
         Vy/0WynSwm0N4CZ522rdz8WJLGMzV9YwWgdH7XmY=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>
Subject: [PATCH 30/46] dt-bindings:iio:adc:renesas,rcar-gyroadc: txt to yaml conversion.
Date:   Sat, 31 Oct 2020 18:48:38 +0000
Message-Id: <20201031184854.745828-31-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This is a somewhat unusual device, in that it effectively does
spi offload.   That means that it doesn't act as a full SPI
master, but supports some functionality.  As such it supports
a subset of specific SPI ADCs.  There is potential for a future
clash in bindings, but as these are simple devices hopefully that
will not occur.

One addition to this from testing it against existing dts files
was to add a resets property.
This is specified in arch/arm/boot/dts/r8a7791.dtsi
If it's the dtsi that is wrong and not the binding doc, then
we can fix that instead.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
---
 .../bindings/iio/adc/renesas,gyroadc.txt      |  98 ------------
 .../iio/adc/renesas,rcar-gyroadc.yaml         | 141 ++++++++++++++++++
 2 files changed, 141 insertions(+), 98 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt b/Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
deleted file mode 100644
index df5b9f2ad8d8..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/renesas,gyroadc.txt
+++ /dev/null
@@ -1,98 +0,0 @@
-* Renesas R-Car GyroADC device driver
-
-The GyroADC block is a reduced SPI block with up to 8 chipselect lines,
-which supports the SPI protocol of a selected few SPI ADCs. The SPI ADCs
-are sampled by the GyroADC block in a round-robin fashion and the result
-presented in the GyroADC registers.
-
-Required properties:
-- compatible:	Should be "<soc-specific>", "renesas,rcar-gyroadc".
-                The <soc-specific> should be one of:
-		renesas,r8a7791-gyroadc - for the GyroADC block present
-					  in r8a7791 SoC
-		renesas,r8a7792-gyroadc - for the GyroADC with interrupt
-					  block present in r8a7792 SoC
-- reg:		Address and length of the register set for the device
-- clocks:	References to all the clocks specified in the clock-names
-		property as specified in
-		Documentation/devicetree/bindings/clock/clock-bindings.txt.
-- clock-names:	Shall contain "fck". The "fck" is the GyroADC block clock.
-- power-domains: Must contain a reference to the PM domain, if available.
-- #address-cells: Should be <1> (setting for the subnodes) for all ADCs
-		except for "fujitsu,mb88101a". Should be <0> (setting for
-		only subnode) for "fujitsu,mb88101a".
-- #size-cells:	Should be <0> (setting for the subnodes)
-
-Sub-nodes:
-You must define subnode(s) which select the connected ADC type and reference
-voltage for the GyroADC channels.
-
-Required properties for subnodes:
-- compatible:	Should be either of:
-		"fujitsu,mb88101a"
-			- Fujitsu MB88101A compatible mode,
-			  12bit sampling, up to 4 channels can be sampled in
-			  round-robin fashion. One Fujitsu chip supplies four
-			  GyroADC channels with data as it contains four ADCs
-			  on the chip and thus for 4-channel operation, single
-			  MB88101A is required. The Cx chipselect lines of the
-			  MB88101A connect directly to two CHS lines of the
-			  GyroADC, no demuxer is required. The data out line
-			  of each MB88101A connects to a shared input pin of
-			  the GyroADC.
-		"ti,adcs7476" or "ti,adc121" or "adi,ad7476"
-			- TI ADCS7476 / TI ADC121 / ADI AD7476 compatible mode,
-			  15bit sampling, up to 8 channels can be sampled in
-			  round-robin fashion. One TI/ADI chip supplies single
-			  ADC channel with data, thus for 8-channel operation,
-			  8 chips are required. A 3:8 chipselect demuxer is
-			  required to connect the nCS line of the TI/ADI chips
-			  to the GyroADC, while MISO line of each TI/ADI ADC
-			  connects to a shared input pin of the GyroADC.
-		"maxim,max1162" or "maxim,max11100"
-			- Maxim MAX1162 / Maxim MAX11100 compatible mode,
-			  16bit sampling, up to 8 channels can be sampled in
-			  round-robin fashion. One Maxim chip supplies single
-			  ADC channel with data, thus for 8-channel operation,
-			  8 chips are required. A 3:8 chipselect demuxer is
-			  required to connect the nCS line of the MAX chips
-			  to the GyroADC, while MISO line of each Maxim ADC
-			  connects to a shared input pin of the GyroADC.
-- reg:		Should be the number of the analog input. Should be present
-		for all ADCs except "fujitsu,mb88101a".
-- vref-supply:	Reference to the channel reference voltage regulator.
-
-Example:
-	vref_max1162: regulator-vref-max1162 {
-		compatible = "regulator-fixed";
-
-		regulator-name = "MAX1162 Vref";
-		regulator-min-microvolt = <4096000>;
-		regulator-max-microvolt = <4096000>;
-	};
-
-	adc@e6e54000 {
-		compatible = "renesas,r8a7791-gyroadc", "renesas,rcar-gyroadc";
-		reg = <0 0xe6e54000 0 64>;
-		clocks = <&mstp9_clks R8A7791_CLK_GYROADC>;
-		clock-names = "fck";
-		power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
-
-		pinctrl-0 = <&adc_pins>;
-		pinctrl-names = "default";
-
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		adc@0 {
-			reg = <0>;
-			compatible = "maxim,max1162";
-			vref-supply = <&vref_max1162>;
-		};
-
-		adc@1 {
-			reg = <1>;
-			compatible = "maxim,max1162";
-			vref-supply = <&vref_max1162>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml
new file mode 100644
index 000000000000..aeaa9d372450
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml
@@ -0,0 +1,141 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/renesas,rcar-gyroadc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas R-Car GyroADC
+
+maintainers:
+  - Marek Vasut <marek.vasut+renesas@gmail.com>
+
+description: |
+  The GyroADC block is a reduced SPI block with up to 8 chipselect lines,
+  which supports the SPI protocol of a selected few SPI ADCs. The SPI ADCs
+  are sampled by the GyroADC block in a round-robin fashion and the result
+  presented in the GyroADC registers.
+  The ADC bindings should match with that of the devices connected to a
+  full featured SPI bus.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,r8a7791-gyroadc
+          - renesas,r8a7792-gyroadc
+      - const: renesas,rcar-gyroadc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: fck
+
+  power-domains: true
+
+  resets: true
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - "#address-cells"
+  - "#size-cells"
+
+patternProperties:
+  "^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+$":
+    type: object
+    properties:
+      compatible:
+        description: |
+          fujitsu,mb88101a
+          - Fujitsu MB88101A compatible mode,
+            12bit sampling, up to 4 channels can be sampled in round-robin
+            fashion. One Fujitsu chip supplies four GyroADC channels with
+            data as it contains four ADCs on the chip and thus for 4-channel
+            operation, single MB88101A is required. The Cx chipselect lines
+            of the MB88101A connect directly to two CHS lines of the GyroADC,
+            no demuxer is required. The data out line of each MB88101A
+            connects to a shared input pin of the GyroADC.
+          ti,adcs7476 or ti,adc121 or adi,ad7476
+          - TI ADCS7476 / TI ADC121 / ADI AD7476 compatible mode, 15bit
+            sampling, up to 8 channels can be sampled in round-robin
+            fashion. One TI/ADI chip supplies single ADC channel with data,
+            thus for 8-channel operation, 8 chips are required.
+            A 3:8 chipselect demuxer is  required to connect the nCS line
+            of the TI/ADI chips to the GyroADC, while MISO line of each
+            TI/ADI ADC connects to a shared input pin of the GyroADC.
+          maxim,max1162 or maxim,max11100
+          - Maxim MAX1162 / Maxim MAX11100 compatible mode,  16bit sampling,
+            up to 8 channels can be sampled in round-robin fashion. One
+            Maxim chip supplies single ADC channel with data, thus for
+            8-channel operation, 8 chips are required.
+            A 3:8 chipselect demuxer is required to connect the nCS line
+            of the MAX chips to the GyroADC, while MISO line of each Maxim
+            ADC connects to a shared input pin of the GyroADC.
+        enum:
+          - adi,7476
+          - fujitsu,mb88101a
+          - maxim,max1162
+          - maxim,max11100
+          - ti,adcs7476
+          - ti,adc121
+
+      reg: true
+
+      vref-supply: true
+
+    additionalProperties: false
+
+    required:
+      - compatible
+      - reg
+      - vref-supply
+
+examples:
+  - |
+    #include <dt-bindings/clock/r8a7791-clock.h>
+    #include <dt-bindings/power/r8a7791-sysc.h>
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        adc@e6e54000 {
+            compatible = "renesas,r8a7791-gyroadc", "renesas,rcar-gyroadc";
+            reg = <0 0xe6e54000 0 64>;
+            clocks = <&mstp9_clks R8A7791_CLK_GYROADC>;
+            clock-names = "fck";
+            power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+
+            pinctrl-0 = <&adc_pins>;
+            pinctrl-names = "default";
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            adc@0 {
+                reg = <0>;
+                compatible = "maxim,max1162";
+                vref-supply = <&vref_max1162>;
+            };
+
+            adc@1 {
+                reg = <1>;
+                compatible = "maxim,max1162";
+                vref-supply = <&vref_max1162>;
+            };
+        };
+    };
+...
-- 
2.28.0

