Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8255D51C844
	for <lists+linux-iio@lfdr.de>; Thu,  5 May 2022 20:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384651AbiEESs5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 May 2022 14:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384726AbiEESsZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 May 2022 14:48:25 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76D1C61297;
        Thu,  5 May 2022 11:40:50 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.91,203,1647270000"; 
   d="scan'208";a="120031898"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 06 May 2022 03:40:49 +0900
Received: from localhost.localdomain (unknown [10.226.92.72])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id EF7F640061B1;
        Fri,  6 May 2022 03:40:45 +0900 (JST)
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
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: Document Renesas RZ/G2UL ADC
Date:   Thu,  5 May 2022 19:40:36 +0100
Message-Id: <20220505184037.511295-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505184037.511295-1-biju.das.jz@bp.renesas.com>
References: <20220505184037.511295-1-biju.das.jz@bp.renesas.com>
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
---
v1->v2:
 * Started using generic compatible for RZ/G2UL and added SoC specific validation
   for channels.
---
 .../bindings/iio/adc/renesas,rzg2l-adc.yaml   | 45 ++++++++++++++++---
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml b/Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
index d66c24cae1e1..2da3538a3543 100644
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
@@ -74,18 +75,48 @@ patternProperties:
       Represents the external channels which are connected to the ADC.
 
     properties:
-      reg:
-        description: |
-          The channel number. It can have up to 8 channels numbered from 0 to 7.
-        items:
-          - minimum: 0
-            maximum: 7
-
+      reg: true
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
+        "^channel@[0-7]$":
+          type: object
+          properties:
+            reg:
+              description: |
+                The channel number. It can have up to 2 channels numbered from 0 to 1.
+              items:
+                - minimum: 0
+                  maximum: 1
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,r9a07g044-adc
+              - renesas,r9a07g054-adc
+    then:
+      patternProperties:
+        "^channel@[0-7]$":
+          type: object
+          properties:
+            reg:
+              description: |
+                The channel number. It can have up to 8 channels numbered from 0 to 7.
+              items:
+                - minimum: 0
+                  maximum: 7
+
 additionalProperties: false
 
 examples:
-- 
2.25.1

