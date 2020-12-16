Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033C72DBE8D
	for <lists+linux-iio@lfdr.de>; Wed, 16 Dec 2020 11:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgLPKWp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Dec 2020 05:22:45 -0500
Received: from hosting.pavoucek.net ([46.28.107.168]:39283 "EHLO
        hosting.pavoucek.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgLPKWp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Dec 2020 05:22:45 -0500
X-Greylist: delayed 496 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Dec 2020 05:22:44 EST
Received: from 176-74-132-138.netdatacomm.cz (176-74-132-138.netdatacomm.cz [176.74.132.138])
        (Authenticated sender: tomas@novotny.cz)
        by hosting.pavoucek.net (Postfix) with ESMTPSA id 60A35104073;
        Wed, 16 Dec 2020 11:13:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 hosting.pavoucek.net 60A35104073
From:   Tomas Novotny <tomas@novotny.cz>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Tomas Novotny <tomas@novotny.cz>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] dt-bindings:iio:dac:microchip,mcp4725: fix properties for mcp4726
Date:   Wed, 16 Dec 2020 11:13:16 +0100
Message-Id: <20201216101316.1403-1-tomas@novotny.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The vdd-supply property is optional if vref-supply is provided for
mcp4726.

Also the microchip,vref-buffered makes sense only if vref-supply is
specified.

Spotted by Jonathan during conversion to yaml.

Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Tomas Novotny <tomas@novotny.cz>
---
 .../bindings/iio/dac/microchip,mcp4725.yaml   | 31 +++++++++++++++----
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4725.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4725.yaml
index 271998610ceb..079f302d1349 100644
--- a/Documentation/devicetree/bindings/iio/dac/microchip,mcp4725.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp4725.yaml
@@ -39,20 +39,39 @@ properties:
 
 allOf:
   - if:
-      not:
-        properties:
-          compatible:
-            contains:
-              const: microchip,mcp4726
+      properties:
+        compatible:
+          contains:
+            const: microchip,mcp4725
     then:
       properties:
         vref-supply: false
+      required:
+        - vdd-supply
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: microchip,mcp4726
+    then:
+      anyOf:
+        - required:
+          - vdd-supply
+        - required:
+          - vref-supply
+
+  - if:
+      not:
+        required:
+          - vref-supply
+    then:
+      properties:
         microchip,vref-buffered: false
 
 required:
   - compatible
   - reg
-  - vdd-supply
 
 additionalProperties: false
 
-- 
2.26.2

