Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F7F30F25F
	for <lists+linux-iio@lfdr.de>; Thu,  4 Feb 2021 12:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235887AbhBDLfq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 4 Feb 2021 06:35:46 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:36800 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235751AbhBDLd6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 Feb 2021 06:33:58 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 114BTVe4001624;
        Thu, 4 Feb 2021 06:33:15 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 36d26aen7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Feb 2021 06:33:14 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 114BXCNx054309
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Feb 2021 06:33:13 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Thu, 4 Feb 2021 03:33:11 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 4 Feb 2021 03:33:11 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 114BX7Yp009001;
        Thu, 4 Feb 2021 06:33:10 -0500
From:   <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>
Subject: [PATCH v2 2/2] dt-bindings: iio: adc: ad7124: add config nodes
Date:   Thu, 4 Feb 2021 13:35:51 +0200
Message-ID: <20210204113551.68744-3-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210204113551.68744-1-alexandru.tachici@analog.com>
References: <20210204113551.68744-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-04_06:2021-02-04,2021-02-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102040072
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Document use of configurations in device-tree bindings.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 .../bindings/iio/adc/adi,ad7124.yaml          | 72 +++++++++++++++----
 1 file changed, 57 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
index fb3d0dae9bae..330064461d0a 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
@@ -62,20 +62,19 @@ required:
   - interrupts
 
 patternProperties:
-  "^channel@([0-9]|1[0-5])$":
-    $ref: "adc.yaml"
+  "^config@(2[0-7])$":
     type: object
     description: |
-      Represents the external channels which are connected to the ADC.
+      Represents a channel configuration.
+      See Documentation/devicetree/bindings/iio/adc/adc.txt.
 
     properties:
       reg:
         description: |
-          The channel number. It can have up to 8 channels on ad7124-4
-          and 16 channels on ad7124-8, numbered from 0 to 15.
+          The config number. It can have up to 8 configuration.
         items:
-          minimum: 0
-          maximum: 15
+         minimum: 20
+         maximum: 27
 
       adi,reference-select:
         description: |
@@ -88,8 +87,6 @@ patternProperties:
         $ref: /schemas/types.yaml#/definitions/uint32
         enum: [0, 1, 3]
 
-      diff-channels: true
-
       bipolar: true
 
       adi,buffered-positive:
@@ -100,6 +97,35 @@ patternProperties:
         description: Enable buffered mode for negative input.
         type: boolean
 
+    additionalProperties: false
+
+  "^channel@([0-9]|1[0-5])$":
+    type: object
+    description: |
+      Represents the external channels which are connected to the ADC.
+      See Documentation/devicetree/bindings/iio/adc/adc.txt.
+
+    properties:
+      reg:
+        description: |
+          The channel number. It can have up to 8 channels on ad7124-4
+          and 16 channels on ad7124-8, numbered from 0 to 15.
+        items:
+         minimum: 0
+         maximum: 15
+
+      diff-channels: true
+
+      adi,configuration:
+        description: |
+          The devices has 8 configuration and ad7124-8 support up to 16 unipolar channels.
+          Each channel can be assigned one configuration. Some channels will be sharing the
+          same configuration.
+        allOf:
+          - $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 20
+        maximum: 27
+
     required:
       - reg
       - diff-channels
@@ -127,30 +153,46 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
 
-        channel@0 {
-          reg = <0>;
-          diff-channels = <0 1>;
+        config@20 {
+          reg = <20>;
           adi,reference-select = <0>;
           adi,buffered-positive;
         };
 
-        channel@1 {
-          reg = <1>;
+        config@21 {
+          reg = <21>;
           bipolar;
-          diff-channels = <2 3>;
           adi,reference-select = <0>;
           adi,buffered-positive;
           adi,buffered-negative;
         };
 
+        config@22 {
+          reg = <22>;
+        };
+
+        channel@0 {
+          reg = <0>;
+          diff-channels = <0 1>;
+          adi,configuration = <20>;
+        };
+
+        channel@1 {
+          reg = <1>;
+          diff-channels = <2 3>;
+          adi,configuration = <21>;
+        };
+
         channel@2 {
           reg = <2>;
           diff-channels = <4 5>;
+          adi,configuration = <22>;
         };
 
         channel@3 {
           reg = <3>;
           diff-channels = <6 7>;
+          adi,configuration = <22>;
         };
       };
     };
-- 
2.20.1

