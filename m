Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE87F2714AC
	for <lists+linux-iio@lfdr.de>; Sun, 20 Sep 2020 15:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgITNyv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Sep 2020 09:54:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbgITNyv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 Sep 2020 09:54:51 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B36162220C;
        Sun, 20 Sep 2020 13:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600610090;
        bh=iBeg9/e9j5vt/iiuxBaDSH3XHQVnxLTuuqfeFAJP65E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mQ9Rs8oN4JWGcABDzdV+y76xDTfMKezLc2XSKsNlsyTw5NTzm8eppjdpfRrT4bRQ5
         mJcqcf4Ea35tTCFQ7do8Vx5GeoNfYrxbq3FjTqTnVR2dXO0QIuDFSZmt1CyN3JMROu
         8C/QjYuqJjY0DNfdDVmoorl4h18QUJJzERugBKhY=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v3 1/1] dt-bindings:iio:adc:amlogic,meson-saradc yaml conversion
Date:   Sun, 20 Sep 2020 14:54:36 +0100
Message-Id: <20200920135436.199003-2-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200920135436.199003-1-jic23@kernel.org>
References: <20200920135436.199003-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This binding is non trivial due to the range of different parts
supported having several subtle quirks. Martin has helped
clarify some of them.

Note, I haven't restricted the amlogic,hhi-sysctrl to only
be present on the relevant parts if nvmem stuff also is, but
it would seem to be rather odd if it were otherwise.

Perhaps we look to make this binding more restrictive at a later date.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>

---
Changes since v2
(thanks Rob and Martin)
  - consistent capitalization
  - clock names etc all shared, only the number of them changed dependent
    on type.
  - missing maxItems for nvmem-cells.

 .../bindings/iio/adc/amlogic,meson-saradc.txt |  48 ------
 .../iio/adc/amlogic,meson-saradc.yaml         | 149 ++++++++++++++++++
 2 files changed, 149 insertions(+), 48 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
deleted file mode 100644
index d57e9df25f4f..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-* Amlogic Meson SAR (Successive Approximation Register) A/D converter
-
-Required properties:
-- compatible:	depending on the SoC this should be one of:
-			- "amlogic,meson8-saradc" for Meson8
-			- "amlogic,meson8b-saradc" for Meson8b
-			- "amlogic,meson8m2-saradc" for Meson8m2
-			- "amlogic,meson-gxbb-saradc" for GXBB
-			- "amlogic,meson-gxl-saradc" for GXL
-			- "amlogic,meson-gxm-saradc" for GXM
-			- "amlogic,meson-axg-saradc" for AXG
-			- "amlogic,meson-g12a-saradc" for AXG
-		along with the generic "amlogic,meson-saradc"
-- reg:		the physical base address and length of the registers
-- interrupts:	the interrupt indicating end of sampling
-- clocks:	phandle and clock identifier (see clock-names)
-- clock-names:	mandatory clocks:
-			- "clkin" for the reference clock (typically XTAL)
-			- "core" for the SAR ADC core clock
-		optional clocks:
-			- "adc_clk" for the ADC (sampling) clock
-			- "adc_sel" for the ADC (sampling) clock mux
-- vref-supply:	the regulator supply for the ADC reference voltage
-- #io-channel-cells: must be 1, see ../iio-bindings.txt
-
-Optional properties:
-- amlogic,hhi-sysctrl:	phandle to the syscon which contains the 5th bit
-			of the TSC (temperature sensor coefficient) on
-			Meson8b and Meson8m2 (which used to calibrate the
-			temperature sensor)
-- nvmem-cells:		phandle to the temperature_calib eFuse cells
-- nvmem-cell-names:	if present (to enable the temperature sensor
-			calibration) this must contain "temperature_calib"
-
-
-Example:
-	saradc: adc@8680 {
-		compatible = "amlogic,meson-gxl-saradc", "amlogic,meson-saradc";
-		#io-channel-cells = <1>;
-		reg = <0x0 0x8680 0x0 0x34>;
-		interrupts = <GIC_SPI 73 IRQ_TYPE_EDGE_RISING>;
-		clocks = <&xtal>,
-			 <&clkc CLKID_SAR_ADC>,
-			 <&clkc CLKID_SANA>,
-			 <&clkc CLKID_SAR_ADC_CLK>,
-			 <&clkc CLKID_SAR_ADC_SEL>;
-		clock-names = "clkin", "core", "sana", "adc_clk", "adc_sel";
-	};
diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
new file mode 100644
index 000000000000..3be8955587e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
@@ -0,0 +1,149 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/amlogic,meson-saradc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Meson SAR (Successive Approximation Register) A/D converter
+
+maintainers:
+  - Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+
+description:
+  Binding covers a range of ADCs found on Amlogic Meson SoCs.
+
+properties:
+  compatible:
+    oneOf:
+      - const: amlogic,meson-saradc
+      - items:
+          - enum:
+              - amlogic,meson8-saradc
+              - amlogic,meson8b-saradc
+              - amlogic,meson8m2-saradc
+              - amlogic,meson-gxbb-saradc
+              - amlogic,meson-gxl-saradc
+              - amlogic,meson-gxm-saradc
+              - amlogic,meson-axg-saradc
+              - amlogic,meson-g12a-saradc
+          - const: amlogic,meson-saradc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: Interrupt indicates end of sampling.
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+    maxItems: 4
+
+  clock-names:
+    minItems: 2
+    maxItems: 4
+    items:
+      - const: clkin
+      - const: core
+      - const: adc_clk
+      - const: adc_sel
+
+  vref-supply: true
+
+  "#io-channel-cells":
+    const: 1
+
+  amlogic,hhi-sysctrl:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Syscon which contains the 5th bit of the TSC (temperature sensor
+      coefficient) on Meson8b and Meson8m2 (which used to calibrate the
+      temperature sensor)
+
+  nvmem-cells:
+    description: phandle to the temperature_calib eFuse cells
+    maxItems: 1
+
+  nvmem-cell-names:
+    const: temperature_calib
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,meson8-saradc
+              - amlogic,meson8b-saradc
+              - amlogic,meson8m2-saradc
+    then:
+      properties:
+        clocks:
+          maxItems: 2
+        clock-names:
+          maxItems: 2
+    else:
+      properties:
+        nvmem-cells: false
+        mvmem-cel-names: false
+        clocks:
+          minItems: 4
+        clock-names:
+          minItems: 4
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - amlogic,meson8b-saradc
+              - amlogic,meson8m2-saradc
+    then:
+      properties:
+        amlogic,hhi-sysctrl: true
+    else:
+      properties:
+        amlogic,hhi-sysctrl: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - "#io-channel-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/gxbb-clkc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        adc@8680 {
+            compatible = "amlogic,meson-gxl-saradc", "amlogic,meson-saradc";
+            #io-channel-cells = <1>;
+            reg = <0x0 0x8680 0x0 0x34>;
+            interrupts = <GIC_SPI 73 IRQ_TYPE_EDGE_RISING>;
+            clocks = <&xtal>,
+                <&clkc CLKID_SAR_ADC>,
+                <&clkc CLKID_SAR_ADC_CLK>,
+                <&clkc CLKID_SAR_ADC_SEL>;
+            clock-names = "clkin", "core", "adc_clk", "adc_sel";
+        };
+        adc@9680 {
+            compatible = "amlogic,meson8b-saradc", "amlogic,meson-saradc";
+            #io-channel-cells = <1>;
+            reg = <0x0 0x9680 0x0 0x34>;
+            interrupts = <GIC_SPI 73 IRQ_TYPE_EDGE_RISING>;
+            clocks = <&xtal>, <&clkc CLKID_SAR_ADC>;
+            clock-names = "clkin", "core";
+            nvmem-cells = <&tsens_caldata>;
+            nvmem-cell-names = "temperature_calib";
+            amlogic,hhi-sysctrl = <&hhi>;
+        };
+    };
+...
-- 
2.28.0

