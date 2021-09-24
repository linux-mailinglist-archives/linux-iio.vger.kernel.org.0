Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCE12416E00
	for <lists+linux-iio@lfdr.de>; Fri, 24 Sep 2021 10:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244802AbhIXIhW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 24 Sep 2021 04:37:22 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:48514 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244742AbhIXIhW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 24 Sep 2021 04:37:22 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18O87Sc4032193;
        Fri, 24 Sep 2021 10:35:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=c7/kNkHtFiFY5R4nkgOOzHHWckU5RiTtRW4/jUq4FIE=;
 b=WYrk2yIoOu2pT43ftVBgLYwh52CdCFiFmpKLnqntX3qqh1PVsCvuD1m4TNvzX4atIKL9
 LQL76ZYsLjx5lab+i3fu+RXRgQVIrh9Bn11tOwmW3tikZxL4rFWAB3s6y6qi90t9cxt8
 J1CcWJtydwxTGqzAq7GOvl0Tqc9oiOFFpjnDLJaRHiGc2yriPYgHDXl4kNOkKesTeoGn
 VB8Qd//BEpJN8wElHeifpOfjMcivT2bp8okpi5oNXGfFgyf1F2DdJASlb0hTTLToC9xG
 agG8Hz26R5T7yImXA+eUnieSpbuRV0QGtHjx1+JGKEFzS1fexEL9XXNu3tGdrUYcvxoW 4A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3b93fsadd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Sep 2021 10:35:26 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BF827100034;
        Fri, 24 Sep 2021 10:35:25 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B46F3226FB0;
        Fri, 24 Sep 2021 10:35:25 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 24 Sep 2021 10:35:25
 +0200
From:   Olivier Moysan <olivier.moysan@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v3 1/7] dt-bindings: iio: stm32-adc: add generic channel binding
Date:   Fri, 24 Sep 2021 10:34:04 +0200
Message-ID: <20210924083410.12332-2-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210924083410.12332-1-olivier.moysan@foss.st.com>
References: <20210924083410.12332-1-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-24_02,2021-09-23_01,2020-04-07_01
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
---
 .../bindings/iio/adc/st,stm32-adc.yaml        | 100 ++++++++++++++++--
 1 file changed, 93 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-adc.yaml
index a58334c3bb76..1c13921b0556 100644
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
+        description: |
+          Represents the external channels which are connected to the ADC.
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
+          st,min-sample-time-nsecs:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            description: |
+              Minimum sampling time in nanoseconds. Depending on hardware (board)
+              e.g. high/low analog input source impedance, fine tune of ADC
+              sampling time may be recommended.
+
+        required:
+          - reg
 
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
+            st,min-sample-time-nsecs = <9000>;
+          };
+          channel@14 {
+            reg = <14>;
+            label = "vddcore";
+            st,min-sample-time-nsecs = <9000>;
+          };
+          channel@15 {
+            reg = <15>;
+            label = "vbat";
+            st,min-sample-time-nsecs = <9000>;
+          };
+        };
+      };
+
 ...
-- 
2.17.1

