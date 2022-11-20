Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB724631562
	for <lists+linux-iio@lfdr.de>; Sun, 20 Nov 2022 18:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiKTRGw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Nov 2022 12:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiKTRGu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Nov 2022 12:06:50 -0500
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EB05800B;
        Sun, 20 Nov 2022 09:06:48 -0800 (PST)
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 6F7AC5F7AB;
        Sun, 20 Nov 2022 18:06:46 +0100 (CET)
From:   Edmund Berenson <edmund.berenson@emlix.com>
Cc:     Edmund Berenson <edmund.berenson@emlix.com>,
        Lukasz Zemla <Lukasz.Zemla@woodward.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: iio: adc: ad7923: adjust documentation
Date:   Sun, 20 Nov 2022 18:06:30 +0100
Message-Id: <20221120170630.29354-1-edmund.berenson@emlix.com>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20221120153419.GA3094349-robh@kernel.org>
References: <20221120153419.GA3094349-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

- Add the ad7927 compatibility string, with fallback compatibility
to ad7928.
- ad7923 and ad7924 are treated the same in the driver, show
the relationship in the documentation.

Suggested-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>
---
 .../bindings/iio/adc/adi,ad7923.yaml          | 26 ++++++++++++-------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
index 07f9d1c09c7d..e553853e25d5 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7923.yaml
@@ -11,7 +11,7 @@ maintainers:
 
 description: |
   Analog Devices AD7904, AD7914, AD7923, AD7924 4 Channel ADCs, and AD7908,
-   AD7918, AD7928 8 Channels ADCs.
+   AD7918, AD7927, AD7928 8 Channels ADCs.
 
   Specifications about the part can be found at:
     https://www.analog.com/media/en/technical-documentation/data-sheets/AD7923.pdf
@@ -20,14 +20,22 @@ description: |
 
 properties:
   compatible:
-    enum:
-      - adi,ad7904
-      - adi,ad7914
-      - adi,ad7923
-      - adi,ad7924
-      - adi,ad7908
-      - adi,ad7918
-      - adi,ad7928
+    oneOf:
+      - enum:
+          - adi,ad7904
+          - adi,ad7914
+          - adi,ad7908
+          - adi,ad7918
+          - adi,ad7923
+          - adi,ad7924
+          - adi,ad7927
+          - adi,ad7928
+      - items:
+          - const: adi,ad7923
+          - const: adi,ad7924
+      - items:
+          - const: adi,ad7927
+          - const: adi,ad7928
 
   reg:
     maxItems: 1
-- 
2.37.4

