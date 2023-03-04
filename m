Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE7F6AABFE
	for <lists+linux-iio@lfdr.de>; Sat,  4 Mar 2023 20:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjCDTAk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Mar 2023 14:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCDTAj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Mar 2023 14:00:39 -0500
Received: from mail-108-mta106.mxroute.com (mail-108-mta106.mxroute.com [136.175.108.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A841A15558
        for <linux-iio@vger.kernel.org>; Sat,  4 Mar 2023 11:00:31 -0800 (PST)
Received: from mail-111-mta2.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta106.mxroute.com (ZoneMTA) with ESMTPSA id 186adff2a2c000edb4.005
 for <linux-iio@vger.kernel.org>
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Sat, 04 Mar 2023 19:00:26 +0000
X-Zone-Loop: c2a05e3f842109563baa46ded17487dad2f6219f9b3e
X-Originating-IP: [136.175.111.2]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ahepp.dev;
        s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:
        From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=vAe3fdfC0djmO3MJDSayibTQ/X49u9L1YrbwXs3r8O0=; b=C
        150N580Z1qRj3Aqm1qU/V7G3t7Z7sgXetvu75kdHfR9Q3TZdB37QKTVp400D+/HEhjYkmA0sP9+wt
        LSgpefa2qHl4uzSoYFvJjwm9CcCWswg7CnO8cUUWPE/PE2FFCeJk/37008FillB8q8ibVRbK9Lpwf
        SP5TTuK38wEb8y2pxJxmDyMqMn2/tqVMFR4HknVEviVDiWuTQ4AQExHJQ4/ZHYu1mDm5RXrFOPBxl
        +c6/WqGk2GA/OyFR//lkIm4ghq5GOe2ofptu8cOr0H2KhOt2TSv+P4xeyYL1eL29OZW/Iw2/kXwFp
        qSV3K+JWP/hYRCS1GHrlvurIEQ6sqN46Q==;
From:   Andrew Hepp <andrew.hepp@ahepp.dev>
To:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Andrew Hepp <andrew.hepp@ahepp.dev>
Subject: [PATCH v4 1/2] dt-bindings: iio: Add MCP9600 thermocouple EMF converter bindings
Date:   Sat,  4 Mar 2023 10:59:53 -0800
Message-Id: <20230304185954.1492-1-andrew.hepp@ahepp.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: andrew.hepp@ahepp.dev
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for the MCP9600 thermocouple EMF converter.

Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/MCP960X-Data-Sheet-20005426.pdf
Signed-off-by: Andrew Hepp <andrew.hepp@ahepp.dev>
---
Changes for v4:
- use descriptive names for open/short circuit interrupts
- remove vdd regulator description
- remove unused import
- use generic sensor name in example
- don't use literal style for doc description
Changes for v3:
- Added dt-bindings
---
 .../iio/temperature/microchip,mcp9600.yaml    | 70 ++++++++++++++++++
 microchip,mcp9600.yaml                        | 72 +++++++++++++++++++
 2 files changed, 142 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
 create mode 100644 microchip,mcp9600.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
new file mode 100644
index 000000000000..5916d331e759
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/temperature/microchip,mcp9600.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip MCP9600 thermocouple EMF converter
+
+maintainers:
+  - Andrew Hepp <andrew.hepp@ahepp.dev>
+
+description:
+  https://ww1.microchip.com/downloads/en/DeviceDoc/MCP960X-Data-Sheet-20005426.pdf
+
+properties:
+  compatible:
+    const: microchip,mcp9600
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 6
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 6
+    items:
+      enum:
+        - open-circuit
+        - short-circuit
+        - alert1
+        - alert2
+        - alert3
+        - alert4
+
+  thermocouple-type:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Type of thermocouple (THERMOCOUPLE_TYPE_K if omitted).
+      Use defines in dt-bindings/iio/temperature/thermocouple.h.
+      Supported types are B, E, J, K, N, R, S, T.
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/iio/temperature/thermocouple.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        temperature-sensor@60 {
+            compatible = "microchip,mcp9600";
+            reg = <0x60>;
+            interrupt-parent = <&gpio>;
+            interrupts = <25 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "open-circuit";
+            thermocouple-type = <THERMOCOUPLE_TYPE_K>;
+            vdd-supply = <&vdd>;
+        };
+    };
diff --git a/microchip,mcp9600.yaml b/microchip,mcp9600.yaml
new file mode 100644
index 000000000000..584d0ae42502
--- /dev/null
+++ b/microchip,mcp9600.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/temperature/microchip,mcp9600.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip MCP9600 thermocouple EMF converter
+
+maintainers:
+  - Andrew Hepp <andrew.hepp@ahepp.dev>
+
+description: |
+  https://ww1.microchip.com/downloads/en/DeviceDoc/MCP960X-Data-Sheet-20005426.pdf
+
+properties:
+  compatible:
+    const: microchip,mcp9600
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 6
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 6
+    items:
+      enum:
+        - open
+        - short
+        - alert1
+        - alert2
+        - alert3
+        - alert4
+
+  thermocouple-type:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Type of thermocouple (THERMOCOUPLE_TYPE_K if omitted).
+      Use defines in dt-bindings/iio/temperature/thermocouple.h.
+      Supported types are B, E, J, K, N, R, S, T.
+
+  vdd-supply:
+    description: Regulator that provides power to the sensor.
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/iio/temperature/thermocouple.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        mcp9600@60 {
+            compatible = "microchip,mcp9600";
+            reg = <0x60>;
+            interrupt-parent = <&gpio>;
+            interrupts = <25 IRQ_TYPE_EDGE_RISING>;
+            interrupt-names = "open";
+            thermocouple-type = <THERMOCOUPLE_TYPE_K>;
+            vdd-supply = <&vdd>;
+        };
+    };
-- 
2.30.2

