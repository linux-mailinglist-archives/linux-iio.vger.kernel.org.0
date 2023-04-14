Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9E36E20C0
	for <lists+linux-iio@lfdr.de>; Fri, 14 Apr 2023 12:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjDNK3r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 Apr 2023 06:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjDNK3q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Apr 2023 06:29:46 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78577E57;
        Fri, 14 Apr 2023 03:29:45 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33E7YLmn004374;
        Fri, 14 Apr 2023 06:29:31 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3px96s9dmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 06:29:30 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 33EATTXp060505
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Apr 2023 06:29:29 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 14 Apr 2023 06:29:28 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 14 Apr 2023 06:29:28 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 14 Apr 2023 06:29:28 -0400
Received: from kimedia-VirtualBox.analog.com (KPALLER2-L02.ad.analog.com [10.116.185.143])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 33EATCbZ003623;
        Fri, 14 Apr 2023 06:29:17 -0400
From:   Kim Seer Paller <kimseer.paller@analog.com>
To:     <lars@metafoo.de>, <jic23@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <kimseer.paller@analog.com>
Subject: [PATCH 1/2] dt-bindings:iio:adc: add max14001 bindings
Date:   Fri, 14 Apr 2023 18:28:44 +0800
Message-ID: <20230414102844.21579-1-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: b0FwTUOJrS_KqYt9ce2My3XCS1Lm3tK2
X-Proofpoint-ORIG-GUID: b0FwTUOJrS_KqYt9ce2My3XCS1Lm3tK2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_04,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0
 clxscore=1011 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140095
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add bindings for MAX14001.

The MAX14001 is configurable, isolated 10-bit ADCs for multi-range
binary inputs.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 .../bindings/iio/adc/adi,max14001.yaml        | 83 +++++++++++++++++++
 MAINTAINERS                                   |  7 ++
 2 files changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml b/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
new file mode 100644
index 000000000..4546bf595
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2023 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,max14001.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MAX14001 ADC device driver
+
+maintainers:
+  - Kim Seer Paller <kimseer.paller@analog.com>
+
+description: |
+    Single channel 10 bit ADC with SPI interface. Datasheet
+    can be found here:
+      https://www.analog.com/media/en/technical-documentation/data-sheets/MAX14001-MAX14002.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,max14001
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 5000000
+
+  vref-supply:
+    description: Voltage reference to establish input scaling.
+
+  adi,use-fadc:
+    $ref: /schemas/types.yaml#/definitions/flag
+    type: boolean
+    description: If set, the filtered ADC data (FADC register) will be read,
+                  otherwise the unfiltered ADC data (ADC register) will be read.
+
+  adi,inrush-mode:
+    $ref: /schemas/types.yaml#/definitions/flag
+    type: boolean
+    description: If set, the device will use FAST inrush mode,
+                  otherwise the device will use ADC controlled inrush mode.
+
+  adi,filter:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1, 2, 3 ]
+    description: |
+      0: Filtering off
+      1: Average 2 readings
+      2: Average 4 readings
+      3: Average 8 readings
+
+  adi,current-source:
+    $ref: /schemas/types.yaml#/definitions/flag
+    type: boolean
+    description: If set, the 70uA current source will be connected to the REFIN pin,
+                  otherwise the current source will be turned off.
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        status = "okay";
+
+        adc@0 {
+            compatible = "adi,max14001";
+            reg = <0>;
+            spi-max-frequency = <5000000>;
+            vref-supply = <&vref_reg>;
+            adi,use-fadc;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 0e64787aa..766847ad2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12573,6 +12573,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/max9860.txt
 F:	sound/soc/codecs/max9860.*
 
+MAX14001 IIO ADC DRIVER
+M:	Kim Seer Paller <kimseer.paller@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/dac/adi,max14001.yaml
+
 MAXBOTIX ULTRASONIC RANGER IIO DRIVER
 M:	Andreas Klinger <ak@it-klinger.de>
 L:	linux-iio@vger.kernel.org
-- 
2.34.1

