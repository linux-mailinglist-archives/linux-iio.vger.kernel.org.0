Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7589351640A
	for <lists+linux-iio@lfdr.de>; Sun,  1 May 2022 13:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345629AbiEALXZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 1 May 2022 07:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345385AbiEALXZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 1 May 2022 07:23:25 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7ECCF5838B;
        Sun,  1 May 2022 04:19:59 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.91,189,1647270000"; 
   d="scan'208";a="118512018"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 01 May 2022 20:19:58 +0900
Received: from localhost.localdomain (unknown [10.226.92.14])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id ADE6540062DF;
        Sun,  1 May 2022 20:19:54 +0900 (JST)
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
        Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH v2] dt-bindings: iio: adc: Document Renesas RZ/G2UL ADC
Date:   Sun,  1 May 2022 12:19:52 +0100
Message-Id: <20220501111952.45872-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

ADC found on RZ/G2UL SoC is almost identical to RZ/G2L SoC, but RZ/G2UL
has 2 analog input channels compared to 8 channels on RZ/G2L. Therefore,
added a new compatible to handle this difference.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Removed Items and used const for RZ/G2UL compatible
 * Add allOf:if:then restricting available channels per SoC variant.
---
 .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 34 ++++++++++++++-----
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
index d66c24cae1e1..d76c5ba3d625 100644
--- a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
@@ -17,11 +17,13 @@ description: |
 
 properties:
   compatible:
-    items:
-      - enum:
-          - renesas,r9a07g044-adc   # RZ/G2L
-          - renesas,r9a07g054-adc   # RZ/V2L
-      - const: renesas,rzg2l-adc
+    oneOf:
+      - const: renesas,renesas,r9a07g043-adc  # RZ/G2UL
+      - items:
+          - enum:
+              - renesas,r9a07g044-adc   # RZ/G2L
+              - renesas,r9a07g054-adc   # RZ/V2L
+          - const: renesas,rzg2l-adc
 
   reg:
     maxItems: 1
@@ -76,10 +78,24 @@ patternProperties:
     properties:
       reg:
         description: |
-          The channel number. It can have up to 8 channels numbered from 0 to 7.
-        items:
-          - minimum: 0
-            maximum: 7
+          The channel number. It can have up to 8 channels numbered from 0 to 7
+          for RZ/{G2L,V2L} SoCs or 2 channels numbered from 0 to 1 for RZ/G2UL
+          SoC.
+      allOf:
+        if:
+          properties:
+            compatible:
+              contains:
+                enum:
+                  - renesas,renesas,r9a07g043-adc
+        then:
+          items:
+            - minimum: 0
+              maximum: 1
+        else:
+          items:
+            - minimum: 0
+              maximum: 7
 
     required:
       - reg
-- 
2.25.1

