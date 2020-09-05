Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B56325E966
	for <lists+linux-iio@lfdr.de>; Sat,  5 Sep 2020 19:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgIERc6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Sep 2020 13:32:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:60600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728563AbgIERc5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Sep 2020 13:32:57 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E06D5208DB;
        Sat,  5 Sep 2020 17:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599327176;
        bh=G31arKrxrxxTxPGo3NOGEU4jamcW0b4IRC0IeztScz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AqYyjD8YDk6rgP8frq8UTUTnelg9IpS2nkGb5jiS7BDZAsqZIbEO7BBvMaqjSzFLE
         4OU00KdgALC2xb6kbsYcCdfSmPyxsv2rDNnCcuEOE4beksCT2QoI9NGCZzQqPVC+Fj
         y9NUQdDjxEaKHVqGSlQudEWpFsZZicpObxnSCBT4=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Markus Pargmann <mpa@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 20/20] dt-bindings:iio:adc:fsl,imx25-gcq yaml conversion
Date:   Sat,  5 Sep 2020 18:30:04 +0100
Message-Id: <20200905173004.216081-21-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200905173004.216081-1-jic23@kernel.org>
References: <20200905173004.216081-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This binding has a few corners that would have been done different today
but hopefully the yaml schema captures the contraints correctly.

The child node names are not constrained hence the fairly open regexp.
I've also documented the defaults for the two references that the
driver seems to use and copied the value descriptions from the header
because I think they should be in the dt-binding itself.

This is part of a general effort to convert all the IIO bindings
over to yaml

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Markus Pargmann <mpa@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 .../bindings/iio/adc/fsl,imx25-gcq.txt        |  57 --------
 .../bindings/iio/adc/fsl,imx25-gcq.yaml       | 129 ++++++++++++++++++
 2 files changed, 129 insertions(+), 57 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt b/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
deleted file mode 100644
index eebdcec3dab5..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.txt
+++ /dev/null
@@ -1,57 +0,0 @@
-Freescale i.MX25 ADC GCQ device
-
-This is a generic conversion queue device that can convert any of the
-analog inputs using the ADC unit of the i.MX25.
-
-Required properties:
- - compatible: Should be "fsl,imx25-gcq".
- - reg: Should be the register range of the module.
- - interrupts: Should be the interrupt number of the module.
-   Typically this is <1>.
- - #address-cells: Should be <1> (setting for the subnodes)
- - #size-cells: Should be <0> (setting for the subnodes)
-
-Optional properties:
- - vref-ext-supply: The regulator supplying the ADC reference voltage.
-   Required when at least one subnode uses the this reference.
- - vref-xp-supply: The regulator supplying the ADC reference voltage on pin XP.
-   Required when at least one subnode uses this reference.
- - vref-yp-supply: The regulator supplying the ADC reference voltage on pin YP.
-   Required when at least one subnode uses this reference.
-
-Sub-nodes:
-Optionally you can define subnodes which define the reference voltage
-for the analog inputs.
-
-Required properties for subnodes:
- - reg: Should be the number of the analog input.
-     0: xp
-     1: yp
-     2: xn
-     3: yn
-     4: wiper
-     5: inaux0
-     6: inaux1
-     7: inaux2
-Optional properties for subnodes:
- - fsl,adc-refp: specifies the positive reference input as defined in
-     <dt-bindings/iio/adc/fsl-imx25-gcq.h>
- - fsl,adc-refn: specifies the negative reference input as defined in
-     <dt-bindings/iio/adc/fsl-imx25-gcq.h>
-
-Example:
-
-	adc: adc@50030800 {
-		compatible = "fsl,imx25-gcq";
-		reg = <0x50030800 0x60>;
-		interrupt-parent = <&tscadc>;
-		interrupts = <1>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		inaux@5 {
-			reg = <5>;
-			fsl,adc-refp = <MX25_ADC_REFP_INT>;
-			fsl,adc-refn = <MX25_ADC_REFN_NGND>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.yaml b/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.yaml
new file mode 100644
index 000000000000..6c4e3ef0862c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/fsl,imx25-gcq.yaml
@@ -0,0 +1,129 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/fsl,imx25-gcq.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale ADC GCQ device
+
+description:
+  This is a generic conversion queue device that can convert any of the
+  analog inputs using the ADC unit of the i.MX25.
+
+maintainers:
+  - Markus Pargmann <mpa@pengutronix.de>
+
+properties:
+  compatible:
+    const: fsl,imx25-gcq
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vref-ext-supply:
+    description:
+      The regulator supplying the ADC reference voltage.
+      Required when at least one subnode uses the this reference.
+
+  vref-xp-supply:
+    description:
+      The regulator supplying the ADC reference voltage on pin XP.
+      Required when at least one subnode uses this reference.
+
+  vref-yp-supply:
+    description:
+      The regulator supplying the ADC reference voltage on pin YP.
+      Required when at least one subnode uses this reference.
+
+  "#io-channel-cells":
+    const: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#address-cells"
+  - "#size-cells"
+
+patternProperties:
+  "[a-z][a-z0-9]+@[0-9a-f]+$":
+    type: object
+    description:
+      Child nodes used to define the reference voltages used for each channel
+
+    properties:
+      reg:
+        description: |
+          Number of the analog input.
+          0: xp
+          1: yp
+          2: xn
+          3: yn
+          4: wiper
+          5: inaux0
+          6: inaux1
+          7: inaux2
+        items:
+          - minimum: 0
+            maximum: 7
+
+      fsl,adc-refp:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          Specifies the positive reference input as defined in
+          <dt-bindings/iio/adc/fsl-imx25-gcq.h>
+          0: YP voltage reference
+          1: XP voltage reference
+          2: External voltage reference
+          3: Internal voltage reference (default)
+        minimum: 0
+        maximum: 3
+
+      fsl,adc-refn:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          Specifies the negative reference input as defined in
+          <dt-bindings/iio/adc/fsl-imx25-gcq.h>
+          0: XN ground reference
+          1: YN ground reference
+          2: Internal ground reference
+          3: External ground reference (default)
+        minimum: 0
+        maximum: 3
+
+    required:
+      - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/iio/adc/fsl-imx25-gcq.h>
+    soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        adc@50030800 {
+            compatible = "fsl,imx25-gcq";
+            reg = <0x50030800 0x60>;
+            interrupt-parent = <&tscadc>;
+            interrupts = <1>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            inaux@5 {
+                reg = <5>;
+                fsl,adc-refp = <MX25_ADC_REFP_INT>;
+                fsl,adc-refn = <MX25_ADC_REFN_NGND>;
+            };
+        };
+    };
+...
-- 
2.28.0

