Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDF86C03D6
	for <lists+linux-iio@lfdr.de>; Sun, 19 Mar 2023 19:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCSSry (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 Mar 2023 14:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjCSSrx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Mar 2023 14:47:53 -0400
Received: from mail-108-mta64.mxroute.com (mail-108-mta64.mxroute.com [136.175.108.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABAE11150
        for <linux-iio@vger.kernel.org>; Sun, 19 Mar 2023 11:47:50 -0700 (PDT)
Received: from mail-111-mta2.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta64.mxroute.com (ZoneMTA) with ESMTPSA id 186fb32fd94000edb4.006
 for <linux-iio@vger.kernel.org>
 (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256);
 Sun, 19 Mar 2023 18:47:48 +0000
X-Zone-Loop: 848e4f3f0aad51151ca92655aa711723616f1034501a
X-Originating-IP: [136.175.111.2]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ahepp.dev;
        s=x; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=wRWiCaXV8vGexe7nWEbGp9XumKYqENfJyo27262xtPE=; b=F+Fp+Og+G8lE2NpriDYzIaSJcs
        5Vz/8VRBaTvLyTsPPt17DfFE++yGSOQD/H4woQAxP+LxJAd1QwIGZiRYDNgkegUbsu5nLtMXIEAP+
        gEaUxLw4VXAMHW4Ywk7ARewdZIt+HYyeicOztmG/xyV0heB6d5ezCnLJ93ESZj/5tpBONo9dSjIWg
        DB1tJbnR7hR9RDniR/d6XD3dcBVgOJMnAJpja3wQ0D5yy9Yer/yvARmdbaV+A1TY4rvhF5GSEEIdD
        AvT7bdK+jHPeN76sFn+uGlCGhsPXFpOHVVngzm+DQdYy30F3R+9H8f5gHxB2ZgBqJop0MFfEnZL3o
        y6WxRi1w==;
From:   Andrew Hepp <andrew.hepp@ahepp.dev>
To:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Andrew Hepp <andrew.hepp@ahepp.dev>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: iio: Add MCP9600 thermocouple EMF converter
Date:   Sun, 19 Mar 2023 11:47:27 -0700
Message-Id: <20230319184728.49232-2-andrew.hepp@ahepp.dev>
In-Reply-To: <20230319184728.49232-1-andrew.hepp@ahepp.dev>
References: <20230319184728.49232-1-andrew.hepp@ahepp.dev>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes for v6:
- none
Changes for v5:
- remove "bindings" from subject
- change unevaluatedProperties to additionalProperties
Changes for v4:
- use descriptive names for open/short circuit interrupts
- remove vdd regulator description
- remove unused import
- use generic sensor name in example
- don't use literal style for doc description
Changes for v3:
- Added dt-bindings
---
 .../iio/temperature/microchip,mcp9600.yaml    | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml b/Documentation/devicetree/bindings/iio/temperature/microchip,mcp9600.yaml
new file mode 100644
index 000000000000..d2cafa38a544
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
+additionalProperties: false
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
-- 
2.30.2

