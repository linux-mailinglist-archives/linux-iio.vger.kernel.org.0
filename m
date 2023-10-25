Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA537D78A7
	for <lists+linux-iio@lfdr.de>; Thu, 26 Oct 2023 01:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjJYXhM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Oct 2023 19:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjJYXhL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Oct 2023 19:37:11 -0400
Received: from mail-108-mta156.mxroute.com (mail-108-mta156.mxroute.com [136.175.108.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CFD181
        for <linux-iio@vger.kernel.org>; Wed, 25 Oct 2023 16:37:07 -0700 (PDT)
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta156.mxroute.com (ZoneMTA) with ESMTPSA id 18b692e47300008912.007
 for <linux-iio@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 25 Oct 2023 23:32:02 +0000
X-Zone-Loop: db06b666b271d3b5354dff743fdae9a5946c62c73147
X-Originating-IP: [136.175.111.2]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ahepp.dev;
        s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:
        From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
        References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
        List-Owner:List-Archive; bh=uFQRte2LtvmVBjvFynl4AJsVJgA3W83CRZZB75zhHwY=; b=E
        2sizVDXj6SO1oZNQuTbiklVPWOjOeANMnHGljimZT3MnHHhLyVHEVA+5k/aijZiEsS4sXsKVwVnoh
        eliDMKqKo4oB16ZkcGDMHghFZZDcXTdU4foq2mQejohc205c+QVwurCNBiQefSHmKBuxkLvvTIZSg
        2fM+nRKCXnQeknPF8uhI8fUCE6JDyz2tkW2y/ZLWQwayP8LPoLK9hyyyTmbG4JgNXK3ngTAcLTIW1
        Z3Zhf5r8KgWfXL6mmLXNCTa3nS2NitJW2yOM2BcMB5Q+Tsd5vMPrKdMzl0EAQ8UnzXB2HXk/csIyR
        AH1QhYxZOTvOYYr4rddbqqeVNfRGYD7zA==;
From:   Andrew Hepp <andrew.hepp@ahepp.dev>
To:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc:     Andrew Hepp <andrew.hepp@ahepp.dev>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [v7,PATCH 1/2] dt-bindings: iio: Add MCP9600 thermocouple EMF converter
Date:   Wed, 25 Oct 2023 16:31:52 -0700
Message-Id: <20231025233153.5454-1-andrew.hepp@ahepp.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: andrew.hepp@ahepp.dev
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add support for the MCP9600 thermocouple electromotive force converter. The sensor has  integrated cold junction compensation and a typical accuracy of 0.5 degrees Celsius. The driver supports a resolution of 0.0625 degrees Celsius.

Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/MCP960X-Data-Sheet-20005426.pdf
Signed-off-by: Andrew Hepp <andrew.hepp@ahepp.dev>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes for v7:
- none
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
2.34.1

