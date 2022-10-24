Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5779F60A1EE
	for <lists+linux-iio@lfdr.de>; Mon, 24 Oct 2022 13:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiJXLhJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 Oct 2022 07:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiJXLgt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Oct 2022 07:36:49 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A0B65256
        for <linux-iio@vger.kernel.org>; Mon, 24 Oct 2022 04:36:16 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:1037:e7a1:b1a2:65fe])
        by andre.telenet-ops.be with bizsmtp
        id bnaL280013Gfk6v01naLRa; Mon, 24 Oct 2022 13:34:20 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1omvil-001DFE-J3; Mon, 24 Oct 2022 13:34:19 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1omvik-00D63J-Tt; Mon, 24 Oct 2022 13:34:18 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Marek Vasut <marek.vasut@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: iio: adc: renesas,rcar-gyroadc: Miscellaneous improvements
Date:   Mon, 24 Oct 2022 13:34:15 +0200
Message-Id: <7b7a13680fa24282c3407e12b5943a66a2ed9068.1666611184.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Set limits on the number of power-domains and resets, and make them
required.

Simplify the example, and update it to match reality:
  - Convert from obsolete MSTP to CPG/MSSR bindings,
  - Examples should use #{address,size}-cells = <1>,
  - Add missing resets property,
  - Drop soc container and pinctrl properties, which are not needed in
    examples.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../iio/adc/renesas,rcar-gyroadc.yaml         | 60 +++++++++----------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml
index c115e2e99bd9a8a5..1c7aee5ed3e0bfb2 100644
--- a/Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/renesas,rcar-gyroadc.yaml
@@ -34,9 +34,11 @@ properties:
   clock-names:
     const: fck
 
-  power-domains: true
+  power-domains:
+    maxItems: 1
 
-  resets: true
+  resets:
+    maxItems: 1
 
   "#address-cells":
     const: 1
@@ -51,6 +53,8 @@ required:
   - reg
   - clocks
   - clock-names
+  - power-domains
+  - resets
   - "#address-cells"
   - "#size-cells"
 
@@ -108,36 +112,30 @@ patternProperties:
 
 examples:
   - |
-    #include <dt-bindings/clock/r8a7791-clock.h>
+    #include <dt-bindings/clock/r8a7791-cpg-mssr.h>
     #include <dt-bindings/power/r8a7791-sysc.h>
-    soc {
-        #address-cells = <2>;
-        #size-cells = <2>;
-
-        adc@e6e54000 {
-            compatible = "renesas,r8a7791-gyroadc", "renesas,rcar-gyroadc";
-            reg = <0 0xe6e54000 0 64>;
-            clocks = <&mstp9_clks R8A7791_CLK_GYROADC>;
-            clock-names = "fck";
-            power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
-
-            pinctrl-0 = <&adc_pins>;
-            pinctrl-names = "default";
-
-            #address-cells = <1>;
-            #size-cells = <0>;
-
-            adc@0 {
-                reg = <0>;
-                compatible = "maxim,max1162";
-                vref-supply = <&vref_max1162>;
-            };
-
-            adc@1 {
-                reg = <1>;
-                compatible = "maxim,max1162";
-                vref-supply = <&vref_max1162>;
-            };
+
+    adc@e6e54000 {
+        compatible = "renesas,r8a7791-gyroadc", "renesas,rcar-gyroadc";
+        reg = <0xe6e54000 64>;
+        clocks = <&cpg CPG_MOD 901>;
+        clock-names = "fck";
+        power-domains = <&sysc R8A7791_PD_ALWAYS_ON>;
+        resets = <&cpg 901>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            reg = <0>;
+            compatible = "maxim,max1162";
+            vref-supply = <&vref_max1162>;
+        };
+
+        adc@1 {
+            reg = <1>;
+            compatible = "maxim,max1162";
+            vref-supply = <&vref_max1162>;
         };
     };
 ...
-- 
2.25.1

