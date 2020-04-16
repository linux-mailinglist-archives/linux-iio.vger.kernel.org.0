Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23F81AC07D
	for <lists+linux-iio@lfdr.de>; Thu, 16 Apr 2020 13:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634617AbgDPL6V (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Apr 2020 07:58:21 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:58726 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2634579AbgDPL6J (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Apr 2020 07:58:09 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03GBqVpT019700;
        Thu, 16 Apr 2020 07:58:09 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 30dn9adgm8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Apr 2020 07:58:08 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 03GBw7aZ016574
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 16 Apr 2020 07:58:07 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 16 Apr
 2020 07:58:06 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 16 Apr 2020 07:58:06 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 03GBw2DY013213;
        Thu, 16 Apr 2020 07:58:05 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>
Subject: [PATCH v2 2/2] dt-bindings: iio: dac: AD5570R fix bindings errors
Date:   Thu, 16 Apr 2020 14:58:48 +0300
Message-ID: <20200416115848.56156-3-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416115848.56156-1-alexandru.tachici@analog.com>
References: <20200416115848.56156-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-16_03:2020-04-14,2020-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 mlxscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004160084
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Replaced num property with reg property, fixed errors
reported by dt-binding-check.

Fixes: ea52c21268e6 ("iio: dac: ad5770r: Add AD5770R support")
Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 .../bindings/iio/dac/adi,ad5770r.yaml         | 82 +++++++++----------
 1 file changed, 39 insertions(+), 43 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
index d9c25cf4b92f..87e9b2802013 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
@@ -2,7 +2,7 @@
 # Copyright 2020 Analog Devices Inc.
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/bindings/iio/dac/adi,ad5770r.yaml#
+$id: http://devicetree.org/schemas/iio/dac/adi,ad5770r.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Analog Devices AD5770R DAC device driver
@@ -49,83 +49,77 @@ properties:
       asserted during driver probe.
     maxItems: 1
 
-  channel0:
+  channel@0:
     description: Represents an external channel which are
       connected to the DAC. Channel 0 can act both as a current
       source and sink.
     type: object
 
     properties:
-      num:
+      reg:
         description: This represents the channel number.
-        items:
-          const: 0
+        const: 0
 
       adi,range-microamp:
           description: Output range of the channel.
           oneOf:
-            - $ref: /schemas/types.yaml#/definitions/int32-array
             - items:
-                - enum: [0 300000]
-                - enum: [-60000 0]
-                - enum: [-60000 300000]
+                - const: 0
+                - const: 300000
+            - items:
+                - const: -60000
+                - const: 0
+            - items:
+                - const: -60000
+                - const: 300000
 
-  channel1:
+  channel@1:
     description: Represents an external channel which are
       connected to the DAC.
     type: object
 
     properties:
-      num:
+      reg:
         description: This represents the channel number.
-        items:
-          const: 1
+        const: 1
 
       adi,range-microamp:
           description: Output range of the channel.
-          oneOf:
-            - $ref: /schemas/types.yaml#/definitions/uint32-array
-            - items:
-                - enum: [0 140000]
-                - enum: [0 250000]
+          items:
+            - const: 0
+            - enum: [ 140000, 250000 ]
 
-  channel2:
+  channel@2:
     description: Represents an external channel which are
       connected to the DAC.
     type: object
 
     properties:
-      num:
+      reg:
         description: This represents the channel number.
-        items:
-          const: 2
+        const: 2
 
       adi,range-microamp:
           description: Output range of the channel.
-          oneOf:
-            - $ref: /schemas/types.yaml#/definitions/uint32-array
-            - items:
-                - enum: [0 140000]
-                - enum: [0 250000]
+          items:
+            - const: 0
+            - enum: [ 55000, 150000 ]
 
 patternProperties:
   "^channel@([3-5])$":
     type: object
     description: Represents the external channels which are connected to the DAC.
     properties:
-      num:
+      reg:
         description: This represents the channel number.
-        items:
-          minimum: 3
-          maximum: 5
+        minimum: 3
+        maximum: 5
 
       adi,range-microamp:
           description: Output range of the channel.
-          oneOf:
-            - $ref: /schemas/types.yaml#/definitions/uint32-array
-            - items:
-                - enum: [0 45000]
-                - enum: [0 100000]
+          items:
+            - const: 0
+            - enum: [ 45000, 100000 ]
 
 required:
 - reg
@@ -150,34 +144,36 @@ examples:
                         vref-supply = <&vref>;
                         adi,external-resistor;
                         reset-gpios = <&gpio 22 0>;
+                        #address-cells = <1>;
+                        #size-cells = <0>;
 
                         channel@0 {
-                                num = <0>;
-                                adi,range-microamp = <(-60000) 300000>;
+                                reg = <0>;
+                                adi,range-microamp = <0 300000>;
                         };
 
                         channel@1 {
-                                num = <1>;
+                                reg = <1>;
                                 adi,range-microamp = <0 140000>;
                         };
 
                         channel@2 {
-                                num = <2>;
+                                reg = <2>;
                                 adi,range-microamp = <0 55000>;
                         };
 
                         channel@3 {
-                                num = <3>;
+                                reg = <3>;
                                 adi,range-microamp = <0 45000>;
                         };
 
                         channel@4 {
-                                num = <4>;
+                                reg = <4>;
                                 adi,range-microamp = <0 45000>;
                         };
 
                         channel@5 {
-                                num = <5>;
+                                reg = <5>;
                                 adi,range-microamp = <0 45000>;
                         };
                 };
-- 
2.20.1

