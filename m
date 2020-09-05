Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC5825E972
	for <lists+linux-iio@lfdr.de>; Sat,  5 Sep 2020 19:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgIERcd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Sep 2020 13:32:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727875AbgIERc2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Sep 2020 13:32:28 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 076572086A;
        Sat,  5 Sep 2020 17:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599327147;
        bh=LEeUU+rrD5hpO7lkr4ZcwemfFSGeHmj8P3ohRK9wtLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rJzTPQ9H4Eny+HO4mCvZEwnDo0ZwjmDf6nYmi68jLKpxGzTH8JId9F6NPoVbrZwRG
         LMKiEvTBj13Cpv7/m47acibbyzN5B+5Cgk8qLL1mt1dfrBKwTiGyTbIlmC6reSuR8X
         YTn5a7qHM9+l3IxuopA6cblzHhcgx6va+O7UcehI=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Fugang Duan <B38611@freescale.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 01/20] dt-bindings:iio:adc:fsl,vf610-adc conversion to yaml.
Date:   Sat,  5 Sep 2020 18:29:45 +0100
Message-Id: <20200905173004.216081-2-jic23@kernel.org>
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

A simple conversion of this freescale ADC binding from txt to yaml.
For maintainer I went with Fugang Duan as the original author of the
binding. Would be great to have confirmation of this.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Fugang Duan <B38611@freescale.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 .../bindings/iio/adc/fsl,vf610-adc.yaml       | 81 +++++++++++++++++++
 .../devicetree/bindings/iio/adc/vf610-adc.txt | 36 ---------
 2 files changed, 81 insertions(+), 36 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml b/Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
new file mode 100644
index 000000000000..99b6b55fd0a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/fsl,vf610-adc.yaml
@@ -0,0 +1,81 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/fsl,vf610-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADC found on Freescale vf610 and similar SoCs
+
+maintainers:
+  - Fugang Duan <B38611@freescale.com>
+
+description:
+  ADCs found on vf610/i.MX6slx and upward SoCs from Freescale.
+
+properties:
+  compatible:
+    const: fsl,vf610-adc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description: ADC source clock (ipg clock)
+    maxItems: 1
+
+  clock-names:
+    const: adc
+
+  vref-supply:
+    description: ADC reference voltage supply.
+
+  fsl,adck-max-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 3
+    maxItems: 3
+    description: |
+      Maximum frequencies from datasheet operating requirements.
+      Three values necessary to cover the 3 conversion modes.
+      * Frequency in normal mode (ADLPC=0, ADHSC=0)
+      * Frequency in high-speed mode (ADLPC=0, ADHSC=1)
+      * Frequency in low-power mode (ADLPC=1, ADHSC=0)
+
+  min-sample-time:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Minimum sampling time in nanoseconds. This value has
+      to be chosen according to the conversion mode and the connected analog
+      source resistance (R_as) and capacitance (C_as). Refer the datasheet's
+      operating requirements. A safe default across a wide range of R_as and
+      C_as as well as conversion modes is 1000ns.
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - vref-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/vf610-clock.h>
+    adc@4003b000 {
+        compatible = "fsl,vf610-adc";
+        reg = <0x4003b000 0x1000>;
+        interrupts = <0 53 0x04>;
+        clocks = <&clks VF610_CLK_ADC0>;
+        clock-names = "adc";
+        fsl,adck-max-frequency = <30000000>, <40000000>, <20000000>;
+        vref-supply = <&reg_vcc_3v3_mcu>;
+        min-sample-time = <10000>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt b/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
deleted file mode 100644
index 1aad0514e647..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/vf610-adc.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-Freescale vf610 Analog to Digital Converter bindings
-
-The devicetree bindings are for the new ADC driver written for
-vf610/i.MX6slx and upward SoCs from Freescale.
-
-Required properties:
-- compatible: Should contain "fsl,vf610-adc"
-- reg: Offset and length of the register set for the device
-- interrupts: Should contain the interrupt for the device
-- clocks: The clock is needed by the ADC controller, ADC clock source is ipg clock.
-- clock-names: Must contain "adc", matching entry in the clocks property.
-- vref-supply: The regulator supply ADC reference voltage.
-
-Recommended properties:
-- fsl,adck-max-frequency: Maximum frequencies according to datasheets operating
-  requirements. Three values are required, depending on conversion mode:
-  - Frequency in normal mode (ADLPC=0, ADHSC=0)
-  - Frequency in high-speed mode (ADLPC=0, ADHSC=1)
-  - Frequency in low-power mode (ADLPC=1, ADHSC=0)
-- min-sample-time: Minimum sampling time in nanoseconds. This value has
-  to be chosen according to the conversion mode and the connected analog
-  source resistance (R_as) and capacitance (C_as). Refer the datasheet's
-  operating requirements. A safe default across a wide range of R_as and
-  C_as as well as conversion modes is 1000ns.
-
-Example:
-adc0: adc@4003b000 {
-	compatible = "fsl,vf610-adc";
-	reg = <0x4003b000 0x1000>;
-	interrupts = <0 53 0x04>;
-	clocks = <&clks VF610_CLK_ADC0>;
-	clock-names = "adc";
-	fsl,adck-max-frequency = <30000000>, <40000000>,
-				<20000000>;
-	vref-supply = <&reg_vcc_3v3_mcu>;
-};
-- 
2.28.0

