Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7071942D9EB
	for <lists+linux-iio@lfdr.de>; Thu, 14 Oct 2021 15:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhJNNPs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 14 Oct 2021 09:15:48 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:40522 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231166AbhJNNPr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Oct 2021 09:15:47 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19EBk87d020021;
        Thu, 14 Oct 2021 15:13:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=fEiEp/KNdDVRTPjRoHGgkIiSQMo3Xj7w4dLVXvt3NkM=;
 b=N41mMaQzjjsXOrC1MtQhZGxRqch4C+hDBo4PgiIw03DW9K+XCGTbFJ5sR63CPTZWLneO
 +sxuqTkxkBf7qYiSE+Qz/hYS3jrGAftbCUKt9UOAfwuoOH5HaFnd0GHnRMREfKqz5gqB
 GKhKzHlMy5evgg5RUinBFQmOCcjfKVqhKqidEzkxt21jDZHXPRj+lI6kcRWpeX67j7XY
 TTFWqohxHhaZSyHkAJE5C4eitjnRrCwLfcjkAuMVYbOtfLO3cUfDF8Lp6o+yDxM36TSQ
 OSBxm/B15Z8w4vMv/OWqWIClXMUUKa3sgcozNmpoifhZ4bQISDvH8jCjqotWmMa81mxd wg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3bpkye8fyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Oct 2021 15:13:20 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C1B2010002A;
        Thu, 14 Oct 2021 15:13:19 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B928222179A;
        Thu, 14 Oct 2021 15:13:19 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 14 Oct 2021 15:13:19
 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v5 1/7] dt-bindings: iio: stm32-adc: add generic channel binding
Date:   Thu, 14 Oct 2021 15:12:22 +0200
Message-ID: <20211014131228.4692-2-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211014131228.4692-1-olivier.moysan@foss.st.com>
References: <20211014131228.4692-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-14_08,2021-10-14_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add ADC generic channel binding. This binding should
be used as an alternate to legacy channel properties
whenever possible.
ADC generic channel binding allows to identify supported
internal channels through the following reserved label names:
"vddcore", "vrefint" and "vbat".
This binding also allows to set a different sampling time
for each channel.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 .../bindings/iio/adc/st,stm32-adc.yaml        | 100 ++++++++++++++++--
 1 file changed, 93 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
index a58334c3bb76..2083e1723970 100644
--- a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
@@ -222,6 +222,12 @@ patternProperties:
       '#io-channel-cells':
         const: 1
 
+      '#address-cells':
+        const: 1
+
+      '#size-cells':
+        const: 0
+
       interrupts:
         description: |
           IRQ Line for the ADC instance. Valid values are:
@@ -256,6 +262,7 @@ patternProperties:
             - 20 channels, numbered from 0 to 19 (for in0..in19) on stm32h7 and
               stm32mp1.
         $ref: /schemas/types.yaml#/definitions/uint32-array
+        deprecated: true
 
       st,adc-diff-channels:
         description: |
@@ -265,7 +272,9 @@ patternProperties:
           <vinp vinn>, <vinp vinn>,... vinp and vinn are numbered from 0 to 19.
 
           Note: At least one of "st,adc-channels" or "st,adc-diff-channels" is
-          required. Both properties can be used together. Some channels can be
+          required if no adc generic channel is defined. These legacy channel
+          properties are exclusive with adc generic channel bindings.
+          Both properties can be used together. Some channels can be
           used as single-ended and some other ones as differential (mixed). But
           channels can't be configured both as single-ended and differential.
         $ref: /schemas/types.yaml#/definitions/uint32-matrix
@@ -279,6 +288,7 @@ patternProperties:
                 "vinn" indicates negative input number
               minimum: 0
               maximum: 19
+        deprecated: true
 
       st,min-sample-time-nsecs:
         description:
@@ -289,6 +299,42 @@ patternProperties:
           list, to set sample time resp. for all channels, or independently for
           each channel.
         $ref: /schemas/types.yaml#/definitions/uint32-array
+        deprecated: true
+
+    patternProperties:
+      "^channel@([0-9]|1[0-9])$":
+        type: object
+        $ref: "adc.yaml"
+        description: Represents the external channels which are connected to the ADC.
+
+        properties:
+          reg:
+            items:
+              minimum: 0
+              maximum: 19
+
+          label:
+            description: |
+              Unique name to identify which channel this is.
+              Reserved label names "vddcore", "vrefint" and "vbat"
+              are used to identify internal channels with matching names.
+
+          diff-channels:
+            $ref: /schemas/types.yaml#/definitions/uint32-array
+            items:
+              minimum: 0
+              maximum: 19
+
+          st,min-sample-time-ns:
+            description: |
+              Minimum sampling time in nanoseconds. Depending on hardware (board)
+              e.g. high/low analog input source impedance, fine tune of ADC
+              sampling time may be recommended.
+
+        required:
+          - reg
+
+        additionalProperties: false
 
     allOf:
       - if:
@@ -369,12 +415,6 @@ patternProperties:
 
     additionalProperties: false
 
-    anyOf:
-      - required:
-          - st,adc-channels
-      - required:
-          - st,adc-diff-channels
-
     required:
       - compatible
       - reg
@@ -451,4 +491,50 @@ examples:
         // other adc child node follow...
       };
 
+  - |
+    // Example 3: with stm32mp157c to setup ADC2 with:
+    // - internal channels 13, 14, 15.
+      #include <dt-bindings/interrupt-controller/arm-gic.h>
+      #include <dt-bindings/clock/stm32mp1-clks.h>
+      adc122: adc@48003000 {
+        compatible = "st,stm32mp1-adc-core";
+        reg = <0x48003000 0x400>;
+        interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&rcc ADC12>, <&rcc ADC12_K>;
+        clock-names = "bus", "adc";
+        booster-supply = <&booster>;
+        vdd-supply = <&vdd>;
+        vdda-supply = <&vdda>;
+        vref-supply = <&vref>;
+        st,syscfg = <&syscfg>;
+        interrupt-controller;
+        #interrupt-cells = <1>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        adc@100 {
+          compatible = "st,stm32mp1-adc";
+          #io-channel-cells = <1>;
+          reg = <0x100>;
+          interrupts = <1>;
+          #address-cells = <1>;
+          #size-cells = <0>;
+          channel@13 {
+            reg = <13>;
+            label = "vrefint";
+            st,min-sample-time-ns = <9000>;
+          };
+          channel@14 {
+            reg = <14>;
+            label = "vddcore";
+            st,min-sample-time-ns = <9000>;
+          };
+          channel@15 {
+            reg = <15>;
+            label = "vbat";
+            st,min-sample-time-ns = <9000>;
+          };
+        };
+      };
+
 ...
-- 
2.17.1

