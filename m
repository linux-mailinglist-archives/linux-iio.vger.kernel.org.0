Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206165275F1
	for <lists+linux-iio@lfdr.de>; Sun, 15 May 2022 08:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235743AbiEOGDx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 May 2022 02:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiEOGDv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 May 2022 02:03:51 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED044BE3C;
        Sat, 14 May 2022 23:03:49 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.91,227,1647270000"; 
   d="scan'208";a="121009741"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 May 2022 15:03:49 +0900
Received: from localhost.localdomain (unknown [10.226.92.18])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 07CA440065CE;
        Sun, 15 May 2022 15:03:44 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2UL ADC
Date:   Sun, 15 May 2022 07:03:35 +0100
Message-Id: <20220515060337.16513-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220515060337.16513-1-biju.das.jz@bp.renesas.com>
References: <20220515060337.16513-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Document Renesas RZ/G2UL ADC bindings. RZ/G2UL ADC is almost identical
to RZ/G2L, but it has 2 analog input channels compared to 8 channels
on the RZ/G2L.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v4->v5:
 * Removed redundant "type:object"
 * Added Rb tag from Krzysztof Kozlowski
v3->v4:
 * Removed unnecessary SoC specific reg description as it is
   equivalent to the logic used in reg.
 * Removed Items from reg.
v2->v3:
 * Added generic description for reg.
 * Improved schema validation by restricting both channel and reg to [0-1].
v1->v2:
 * Started using generic compatible for RZ/G2UL and added SoC specific validation
   for channels.
---
 .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 28 ++++++++++++++++---
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
index d66c24cae1e1..61c6157cf5a9 100644
--- a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
@@ -19,6 +19,7 @@ properties:
   compatible:
     items:
       - enum:
+          - renesas,r9a07g043-adc   # RZ/G2UL
           - renesas,r9a07g044-adc   # RZ/G2L
           - renesas,r9a07g054-adc   # RZ/V2L
       - const: renesas,rzg2l-adc
@@ -76,16 +77,35 @@ patternProperties:
     properties:
       reg:
         description: |
-          The channel number. It can have up to 8 channels numbered from 0 to 7.
-        items:
-          - minimum: 0
-            maximum: 7
+          The channel number.
 
     required:
       - reg
 
     additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a07g043-adc
+    then:
+      patternProperties:
+        "^channel@[2-7]$": false
+        "^channel@[0-1]$":
+          properties:
+            reg:
+              minimum: 0
+              maximum: 1
+    else:
+      patternProperties:
+        "^channel@[0-7]$":
+          properties:
+            reg:
+              minimum: 0
+              maximum: 7
+
 additionalProperties: false
 
 examples:
-- 
2.25.1

