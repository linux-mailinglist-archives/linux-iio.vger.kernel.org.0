Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49EBB6AA698
	for <lists+linux-iio@lfdr.de>; Sat,  4 Mar 2023 01:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjCDAnI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Mar 2023 19:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCDAnI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Mar 2023 19:43:08 -0500
Received: from mail-108-mta249.mxroute.com (mail-108-mta249.mxroute.com [136.175.108.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8388613532
        for <linux-iio@vger.kernel.org>; Fri,  3 Mar 2023 16:43:05 -0800 (PST)
Received: from mail-111-mta2.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta249.mxroute.com (ZoneMTA) with ESMTPSA id 186aa127ca7000edb4.005
 for <linux-iio@vger.kernel.org>
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Sat, 04 Mar 2023 00:43:03 +0000
X-Zone-Loop: 805946428376b97d9114a27f066bbe7ca5b5354c686e
X-Originating-IP: [136.175.111.2]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ahepp.dev;
        s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:
        From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=SqOZ+n7iiZ6IA5VrgdiO4hkN3wRJAXL1gzzEhu6P3/A=; b=P
        2w5kZtkm+rWp0KL3eNs3jv+BoCWvae1HIPLXGu8jeGeCSbagsRR54rhY7cN2LbZsg1tLMgRypT2W+
        O3dmWd77dABU4vCJc+KMePopYVEz5ags+yAzS064h/yCcVa2pezHwN266UpfKopZr2Sls7KnaHLJe
        7mJiGXdgLKcx7YW67x/FUA4P//1cHXB9ByA07FzWd4SCvXOLrXwUvCwwB4oZ3IRHtY8BJbXc3cs8G
        EiSyfgWmtQ1TBQFPakCAdP/yzBMXZWHAc31RKbw53KrPBvljf8yWvmXYHNOSPWHKubAtacGGarzzx
        t9qplq1j9DUEu/LTVRsvCA/LkuQMvonRw==;
From:   Andrew Hepp <andrew.hepp@ahepp.dev>
To:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Andrew Hepp <andrew.hepp@ahepp.dev>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: iio: Add MCP9600 thermocouple EMF converter bindings
Date:   Fri,  3 Mar 2023 16:41:08 -0800
Message-Id: <20230304004109.78659-1-andrew.hepp@ahepp.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: andrew.hepp@ahepp.dev
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for the MCP9600 thermocouple EMF converter.

Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/MCP960X-Data-Sheet-20005426.pdf
Signed-off-by: Andrew Hepp <andrew.hepp@ahepp.dev>
---
Changes for v3:
- Added dt-bindings
---
 .../iio/temperature/microchip,mcp9600.yaml    | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
new file mode 100644
index 000000000000..584d0ae42502
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
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

