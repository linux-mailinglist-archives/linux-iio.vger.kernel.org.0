Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD7FF15411A
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 10:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgBFJYA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 04:24:00 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:22714 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728033AbgBFJX6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2020 04:23:58 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0169Bw9b019329;
        Thu, 6 Feb 2020 04:23:57 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xyhnkm4cw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Feb 2020 04:23:57 -0500
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0169NucR023559
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 6 Feb 2020 04:23:56 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 6 Feb 2020
 04:23:55 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 6 Feb 2020 04:23:55 -0500
Received: from tachici-Precision-5530.ad.analog.com ([10.48.65.175])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0169NoIp010043;
        Thu, 6 Feb 2020 04:23:53 -0500
From:   Alexandru Tachici <alexandru.tachici@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Subject: [PATCH 2/2] dt-bindings: iio: dac: Add docs for AD5770R DAC
Date:   Thu, 6 Feb 2020 11:23:13 +0200
Message-ID: <20200206092313.18265-3-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200206092313.18265-1-alexandru.tachici@analog.com>
References: <20200206092313.18265-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-05_06:2020-02-04,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2001150001 definitions=main-2002060073
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Adding dt-bindings documentation for AD5770R DAC.

Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 .../bindings/iio/dac/adi,ad5770r.yaml         | 176 ++++++++++++++++++
 1 file changed, 176 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
new file mode 100644
index 000000000000..02b2f6e67583
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.yaml
@@ -0,0 +1,176 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2020 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/iio/adc/adi,ad5770r.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5770R DAC device driver
+
+maintainers:
+  - Mircea Caprioru <mircea.caprioru@analog.com>
+
+description: |
+  Bindings for the Analog Devices AD5770R current DAC device. Datasheet can be
+  found here:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD5770R.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad5770r
+
+  reg:
+    maxItems: 1
+
+  vref-supply:
+    description: Specify the voltage of the external reference used.
+      Available reference options are 1.25 V or 2.5 V. If no
+      external reference declared then the device will use the
+      internal reference of 1.25 V.
+
+  adi,external-resistor:
+    description: Specify if an external 2.5k ohm resistor is used. If not
+      specified the device will use and internal 2.5k ohm resistor.
+      The precision resistor is used for reference current generation.
+    type: boolean
+
+  reset-gpios:
+    description: GPIO spec for the RESET pin. If specified, it will be
+      asserted during driver probe.
+    maxItems: 1
+
+  channel0:
+    description: Represents an external channel which are
+      connected to the DAC. Channel 0 can act both as a current
+      source and sink.
+    type: object
+
+    properties:
+      num:
+        description: This represents the channel number.
+        items:
+          const: 0
+
+      adi,range-microamp:
+          description: Output range of the channel.
+          oneOf:
+            - $ref: /schemas/types.yaml#/definitions/int32-array
+            - items:
+                - enum: [0 300000]
+                - enum: [-60000 0]
+                - enum: [-60000 300000]
+
+  channel1:
+    description: Represents an external channel which are
+      connected to the DAC.
+    type: object
+
+    properties:
+      num:
+        description: This represents the channel number.
+        items:
+          const: 1
+
+      adi,range-microamp:
+          description: Output range of the channel.
+          allOf:
+            - $ref: /schemas/types.yaml#/definitions/uint32-array
+            - items:
+                - enum: [0 140000]
+                - enum: [0 250000]
+
+  channel2:
+    description: Represents an external channel which are
+      connected to the DAC.
+    type: object
+
+    properties:
+      num:
+        description: This represents the channel number.
+        items:
+          const: 2
+
+      adi,range-microamp:
+          description: Output range of the channel.
+          allOf:
+            - $ref: /schemas/types.yaml#/definitions/uint32-array
+            - items:
+                - enum: [0 140000]
+                - enum: [0 250000]
+
+patternProperties:
+  "^channel@([3-5])$":
+    type: object
+    description: Represents the external channels which are connected to the DAC.
+    properties:
+      num:
+        description: This represents the channel number.
+        items:
+          minimum: 3
+          maximum: 5
+
+      adi,range-microamp:
+          description: Output range of the channel.
+          oneOf:
+            - $ref: /schemas/types.yaml#/definitions/uint32-array
+            - items:
+                - enum: [0 45000]
+                - enum: [0 100000]
+
+required:
+- reg
+- diff-channels
+- channel0
+- channel1
+- channel2
+- channel3
+- channel4
+- channel5
+
+examples:
+  - |
+        spi {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                ad5770r@0 {
+                        compatible = "ad5770r";
+                        reg = <0>;
+                        spi-max-frequency = <1000000>;
+                        vref-supply = <&vref>;
+                        adi,external-resistor;
+                        reset-gpios = <&gpio 22 0>;
+
+                        channel@0 {
+                                num = <0>;
+                                adi,range-microamp = <(-60000) 300000>;
+                        };
+
+                        channel@1 {
+                                num = <1>;
+                                adi,range-microamp = <0 140000>;
+                        };
+
+                        channel@2 {
+                                num = <2>;
+                                adi,range-microamp = <0 55000>;
+                        };
+
+                        channel@3 {
+                                num = <3>;
+                                adi,range-microamp = <0 45000>;
+                        };
+
+                        channel@4 {
+                                num = <4>;
+                                adi,range-microamp = <0 45000>;
+                        };
+
+                        channel@5 {
+                                num = <5>;
+                                adi,range-microamp = <0 45000>;
+                        };
+                };
+        };
+...
\ No newline at end of file
-- 
2.20.1

