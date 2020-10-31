Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C9D2A1A0B
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgJaSwV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:52:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728478AbgJaSwU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:52:20 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A8EF20706;
        Sat, 31 Oct 2020 18:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170340;
        bh=OgNZaLL9is87mgr0oVwVZNGbswE0xE79YT7Ep8Q7uvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2XYTMd9+PELNaYP5zEMv5LBIPexMCAdr3HZ16WnyGt7LXNnqEE9N2COWd/Lwl6Vam
         HDtFMSaDQ72LgsVez7pAkAGGU8sLb76xb5kyWgTKMfBxRkmnZ1eX5R1Zyg8HmFigNe
         6tICK9+t3olo1CjJPNI71QOP+K0mnmcS5LpvGw8Q=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Ivan T . Ivanov" <iivanov@mm-sol.com>
Subject: [PATCH 36/46] dt-bindings:iio:adc:qcom,spmi-iadc: txt to yaml format conversion.
Date:   Sat, 31 Oct 2020 18:48:44 +0000
Message-Id: <20201031184854.745828-37-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Straight forward conversion.  Not heard from Ivan in a while so if the
email bounces, I'll change the maintainer to myself for this binding unless
anyone else comes forwards.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Ivan T. Ivanov <iivanov@mm-sol.com>
---
 .../bindings/iio/adc/qcom,spmi-iadc.txt       | 46 --------------
 .../bindings/iio/adc/qcom,spmi-iadc.yaml      | 62 +++++++++++++++++++
 2 files changed, 62 insertions(+), 46 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.txt b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.txt
deleted file mode 100644
index 4e36d6e2f7b6..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.txt
+++ /dev/null
@@ -1,46 +0,0 @@
-Qualcomm's SPMI PMIC current ADC
-
-QPNP PMIC current ADC (IADC) provides interface to clients to read current.
-A 16 bit ADC is used for current measurements. IADC can measure the current
-through an external resistor (channel 1) or internal (built-in) resistor
-(channel 0). When using an external resistor it is to be described by
-qcom,external-resistor-micro-ohms property.
-
-IADC node:
-
-- compatible:
-    Usage: required
-    Value type: <string>
-    Definition: Should contain "qcom,spmi-iadc".
-
-- reg:
-    Usage: required
-    Value type: <prop-encoded-array>
-    Definition: IADC base address and length in the SPMI PMIC register map
-
-- interrupts:
-    Usage: optional
-    Value type: <prop-encoded-array>
-    Definition: End of ADC conversion.
-
-- qcom,external-resistor-micro-ohms:
-    Usage: optional
-    Value type: <u32>
-    Definition: Sense resister value in micro Ohm.
-                If not defined value of 10000 micro Ohms will be used.
-
-Example:
-	/* IADC node */
-	pmic_iadc: iadc@3600 {
-		compatible = "qcom,spmi-iadc";
-		reg = <0x3600 0x100>;
-		interrupts = <0x0 0x36 0x0 IRQ_TYPE_EDGE_RISING>;
-		qcom,external-resistor-micro-ohms = <10000>;
-		#io-channel-cells  = <1>;
-	};
-
-	/* IIO client node */
-	bat {
-		io-channels = <&pmic_iadc  0>;
-		io-channel-names = "iadc";
-	};
diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
new file mode 100644
index 000000000000..359e1ede0ae2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-iadc.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/qcom,spmi-iadc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm's SPMI PMIC current ADC
+
+maintainers:
+  - Ivan T. Ivanov <iivanov@mm-sol.com>
+
+description: |
+  QPNP PMIC current ADC (IADC) provides interface to clients to read current.
+  A 16 bit ADC is used for current measurements. IADC can measure the current
+  through an external resistor (channel 1) or internal (built-in) resistor
+  (channel 0). When using an external resistor it is to be described by
+  qcom,external-resistor-micro-ohms property.
+
+properties:
+  compatible:
+    const: qcom,spmi-iadc
+
+  reg:
+    description: IADC base address and length in the SPMI PMIC register map
+    maxItems: 1
+
+  qcom,external-resistor-micro-ohms:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Sensor resistor value. If not defined value of 10000 micro Ohms
+      will be used.
+
+  interrupts:
+    maxItems: 1
+    description:
+      End of conversion interrupt.
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
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spmi_bus {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        pmic_iadc: adc@3600 {
+            compatible = "qcom,spmi-iadc";
+            reg = <0x3600 0x100>;
+            interrupts = <0x0 0x36 0x0 IRQ_TYPE_EDGE_RISING>;
+            qcom,external-resistor-micro-ohms = <10000>;
+            #io-channel-cells  = <1>;
+        };
+    };
+...
+
-- 
2.28.0

