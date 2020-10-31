Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE712A1A0D
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbgJaSwV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:52:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728458AbgJaSwU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:52:20 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA6C420724;
        Sat, 31 Oct 2020 18:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170339;
        bh=IRPUBaVia/ExN9xck1J1VThVGmNv3x7KfgS5uFnE/dE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x0CznKxkkNv0wqnjgEQp6pP/cDxDRsGL6NzEIzRmmt0cQLID0mVeuYC6C3A2RmWoV
         RgFu4iugOjAvPa7X6wkFVkcRDWrzkd8GkM8Lp8HG/H3kVxG8xI0yVKq/WB/B+N0X1N
         HOOPu9irgq8KwZN3a/QrzyBhMETwMQX4Emn2P0DY=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 35/46] dt-bindings:iio:adc:qcom,pm8018-adc: yaml conversion and rename.
Date:   Sat, 31 Oct 2020 18:48:43 +0000
Message-Id: <20201031184854.745828-36-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Renamed to match a listed compatible rather than relying on wildcards
with all their usual problems.

Dropped the reference supply as a requirement as at least one dtsi doesn't
include it and the example never did.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/iio/adc/qcom,pm8018-adc.yaml     | 166 ++++++++++++++++++
 .../bindings/iio/adc/qcom,pm8xxx-xoadc.txt    | 157 -----------------
 2 files changed, 166 insertions(+), 157 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,pm8018-adc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,pm8018-adc.yaml
new file mode 100644
index 000000000000..d186b713d6a7
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,pm8018-adc.yaml
@@ -0,0 +1,166 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/qcom,pm8018-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm's PM8xxx voltage XOADC
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description: |
+  The Qualcomm PM8xxx PMICs contain a HK/XO ADC (Housekeeping/Crystal
+  oscillator ADC) encompassing PM8018, PM8038, PM8058 and PM8921.
+
+properties:
+  compatible:
+    enum:
+      - qcom,pm8018-adc
+      - qcom,pm8038-adc
+      - qcom,pm8058-adc
+      - qcom,pm8921-adc
+
+  reg:
+    maxItems: 1
+    description:
+      ADC base address in the PMIC, typically 0x197.
+
+  xoadc-ref-supply:
+    description:
+      The reference voltage may vary with PMIC variant but is typically
+      something like 2.2 or 1.8V.
+
+  interrupts:
+    maxItems: 1
+
+  "#address-cells":
+    const: 2
+    description:
+      The first cell is the prescaler (on PM8058) or premux (on PM8921)
+      with two valid bits  so legal values are 0x00, 0x01 or 0x02.
+      The second cell is the main analog mux setting (0x00..0x0f).
+      The combination of prescaler/premux and analog mux uniquely addresses
+      a hardware channel on all systems.
+
+  "#size-cells":
+    const: 0
+
+  "#io-channel-cells":
+    const: 2
+    description:
+      The cells are precaler or premux followed by the analog muxing line.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - "#io-channel-cells"
+  - "#address-cells"
+  - "#size-cells"
+  - adc-channel@c
+  - adc-channel@d
+  - adc-channel@f
+
+patternProperties:
+  "^(adc-channel@)[0-9a-f]$":
+    type: object
+    description: |
+      ADC channel specific configuration.
+      Note that channels c, d and f must be present for calibration.
+      These three nodes are used for absolute and ratiometric calibration
+      and only need to have these reg values: they are by hardware definition
+      1:1 ratio converters that sample 625, 1250 and 0 milliV and create
+      an interpolation calibration for all other ADCs.
+
+    properties:
+      reg:
+        maxItems: 1
+
+      qcom,decimation:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          This parameter is used to decrease the ADC sampling rate.
+          Quicker measurements can be made by reducing the decimation ratio.
+          Valid values are 512, 1024, 2048, 4096.
+          If the property is not found, a default value of 512 will be used.
+
+      qcom,ratiometric:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          Channel calibration type. If this property is specified
+          VADC will use a special voltage references for channel
+          calibration. The available references are specified in the
+          as a u32 value setting (see below) and it is compulsory
+          to also specify this reference if ratiometric calibration
+          is selected.
+
+          If the property is not found, the channel will be
+          calibrated with the 0.625V and 1.25V reference channels, also
+          known as an absolute calibration.
+
+          The reference voltage pairs when using ratiometric calibration:
+          0 = XO_IN/XOADC_GND
+          1 = PMIC_IN/XOADC_GND
+          2 = PMIC_IN/BMS_CSP
+          3 (invalid)
+          4 = XOADC_GND/XOADC_GND
+          5 = XOADC_VREF/XOADC_GND
+
+    additionalProperties: false
+
+    required:
+      - reg
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    pmic {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@197 {
+            compatible = "qcom,pm8058-adc";
+            reg = <0x197>;
+            interrupts-extended = <&pm8058 76 IRQ_TYPE_EDGE_RISING>;
+            #address-cells = <2>;
+            #size-cells = <0>;
+            #io-channel-cells = <2>;
+
+            vcoin: adc-channel@0 {
+                reg = <0x00 0x00>;
+            };
+            vbat: adc-channel@1 {
+                reg = <0x00 0x01>;
+            };
+            dcin: adc-channel@2 {
+                reg = <0x00 0x02>;
+            };
+            ichg: adc-channel@3 {
+                reg = <0x00 0x03>;
+            };
+            vph_pwr: adc-channel@4 {
+                reg = <0x00 0x04>;
+            };
+            usb_vbus: adc-channel@a {
+                reg = <0x00 0x0a>;
+            };
+            die_temp: adc-channel@b {
+                reg = <0x00 0x0b>;
+            };
+            ref_625mv: adc-channel@c {
+                reg = <0x00 0x0c>;
+            };
+            ref_1250mv: adc-channel@d {
+                reg = <0x00 0x0d>;
+            };
+            ref_325mv: adc-channel@e {
+                reg = <0x00 0x0e>;
+            };
+            ref_muxoff: adc-channel@f {
+                reg = <0x00 0x0f>;
+           };
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,pm8xxx-xoadc.txt b/Documentation/devicetree/bindings/iio/adc/qcom,pm8xxx-xoadc.txt
deleted file mode 100644
index 3ae06127789e..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/qcom,pm8xxx-xoadc.txt
+++ /dev/null
@@ -1,157 +0,0 @@
-Qualcomm's PM8xxx voltage XOADC
-
-The Qualcomm PM8xxx PMICs contain a HK/XO ADC (Housekeeping/Crystal
-oscillator ADC) encompassing PM8018, PM8038, PM8058 and PM8921.
-
-Required properties:
-
-- compatible: should be one of:
-  "qcom,pm8018-adc"
-  "qcom,pm8038-adc"
-  "qcom,pm8058-adc"
-  "qcom,pm8921-adc"
-
-- reg: should contain the ADC base address in the PMIC, typically
-  0x197.
-
-- xoadc-ref-supply: should reference a regulator that can supply
-  a reference voltage on demand. The reference voltage may vary
-  with PMIC variant but is typically something like 2.2 or 1.8V.
-
-The following required properties are standard for IO channels, see
-iio-bindings.txt for more details, but notice that this particular
-ADC has a special addressing scheme that require two cells for
-identifying each ADC channel:
-
-- #address-cells: should be set to <2>, the first cell is the
-  prescaler (on PM8058) or premux (on PM8921) with two valid bits
-  so legal values are 0x00, 0x01 or 0x02. The second cell
-  is the main analog mux setting (0x00..0x0f). The combination
-  of prescaler/premux and analog mux uniquely addresses a hardware
-  channel on all systems.
-
-- #size-cells: should be set to <0>
-
-- #io-channel-cells: should be set to <2>, again the cells are
-  precaler or premux followed by the analog muxing line.
-
-- interrupts: should refer to the parent PMIC interrupt controller
-  and reference the proper ADC interrupt.
-
-Required subnodes:
-
-The ADC channels are configured as subnodes of the ADC.
-
-Since some of them are used for calibrating the ADC, these nodes are
-compulsory:
-
-adc-channel@c {
-	reg = <0x00 0x0c>;
-};
-
-adc-channel@d {
-	reg = <0x00 0x0d>;
-};
-
-adc-channel@f {
-	reg = <0x00 0x0f>;
-};
-
-These three nodes are used for absolute and ratiometric calibration
-and only need to have these reg values: they are by hardware definition
-1:1 ratio converters that sample 625, 1250 and 0 milliV and create
-an interpolation calibration for all other ADCs.
-
-Optional subnodes: any channels other than channels [0x00 0x0c],
-[0x00 0x0d] and [0x00 0x0f] are optional.
-
-Required channel node properties:
-
-- reg: should contain the hardware channel number in the range
-  0 .. 0xff (8 bits).
-
-Optional channel node properties:
-
-- qcom,decimation:
-  Value type: <u32>
-  Definition: This parameter is used to decrease the ADC sampling rate.
-          Quicker measurements can be made by reducing the decimation ratio.
-          Valid values are 512, 1024, 2048, 4096.
-          If the property is not found, a default value of 512 will be used.
-
-- qcom,ratiometric:
-  Value type: <u32>
-  Definition: Channel calibration type. If this property is specified
-          VADC will use a special voltage references for channel
-          calibration. The available references are specified in the
-	  as a u32 value setting (see below) and it is compulsory
-	  to also specify this reference if ratiometric calibration
-	  is selected.
-
-	  If the property is not found, the channel will be
-          calibrated with the 0.625V and 1.25V reference channels, also
-          known as an absolute calibration.
-  The reference voltage pairs when using ratiometric calibration:
-	  0 = XO_IN/XOADC_GND
-	  1 = PMIC_IN/XOADC_GND
-	  2 = PMIC_IN/BMS_CSP
-	  3 (invalid)
-	  4 = XOADC_GND/XOADC_GND
-	  5 = XOADC_VREF/XOADC_GND
-
-Example:
-
-xoadc: xoadc@197 {
-	compatible = "qcom,pm8058-adc";
-	reg = <0x197>;
-	interrupts-extended = <&pm8058 76 IRQ_TYPE_EDGE_RISING>;
-	#address-cells = <2>;
-	#size-cells = <0>;
-	#io-channel-cells = <2>;
-
-	vcoin: adc-channel@0 {
-		reg = <0x00 0x00>;
-	};
-	vbat: adc-channel@1 {
-		reg = <0x00 0x01>;
-	};
-	dcin: adc-channel@2 {
-		reg = <0x00 0x02>;
-	};
-	ichg: adc-channel@3 {
-		reg = <0x00 0x03>;
-	};
-	vph_pwr: adc-channel@4 {
-		reg = <0x00 0x04>;
-	};
-	usb_vbus: adc-channel@a {
-		reg = <0x00 0x0a>;
-	};
-	die_temp: adc-channel@b {
-		reg = <0x00 0x0b>;
-	};
-	ref_625mv: adc-channel@c {
-		reg = <0x00 0x0c>;
-	};
-	ref_1250mv: adc-channel@d {
-		reg = <0x00 0x0d>;
-	};
-	ref_325mv: adc-channel@e {
-		reg = <0x00 0x0e>;
-	};
-	ref_muxoff: adc-channel@f {
-		reg = <0x00 0x0f>;
-	};
-};
-
-/* IIO client node */
-iio-hwmon {
-	compatible = "iio-hwmon";
-	io-channels = <&xoadc 0x00 0x01>, /* Battery */
-		    <&xoadc 0x00 0x02>, /* DC in (charger) */
-		    <&xoadc 0x00 0x04>, /* VPH the main system voltage */
-		    <&xoadc 0x00 0x0b>, /* Die temperature */
-		    <&xoadc 0x00 0x0c>, /* Reference voltage 1.25V */
-		    <&xoadc 0x00 0x0d>, /* Reference voltage 0.625V */
-		    <&xoadc 0x00 0x0e>; /* Reference voltage 0.325V */
-};
-- 
2.28.0

