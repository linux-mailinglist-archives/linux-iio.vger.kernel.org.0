Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D897B447BC5
	for <lists+linux-iio@lfdr.de>; Mon,  8 Nov 2021 09:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237945AbhKHI2e (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Nov 2021 03:28:34 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:2662 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236740AbhKHI2d (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Nov 2021 03:28:33 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A85FB14007244;
        Mon, 8 Nov 2021 03:25:38 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3c5kj80tvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Nov 2021 03:25:38 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 1A88PaX0003305
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Nov 2021 03:25:37 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Mon, 8 Nov 2021 00:25:35 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Mon, 8 Nov 2021 00:25:35 -0800
Received: from ubuntuservermchindri.ad.analog.com ([10.32.225.18])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1A88PJeG001294;
        Mon, 8 Nov 2021 03:25:32 -0500
From:   Mihail Chindris <mihail.chindris@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <alexandru.ardelean@analog.com>,
        Mihail Chindris <mihail.chindris@analog.com>
Subject: [PATCH v5 1/2] dt-bindings: iio: dac: Add adi,ad3552r.yaml
Date:   Mon, 8 Nov 2021 08:24:46 +0000
Message-ID: <20211108082447.116663-2-mihail.chindris@analog.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211108082447.116663-1-mihail.chindris@analog.com>
References: <20211108082447.116663-1-mihail.chindris@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: bHSSr8BHSHik-y8bA_cnUXRXLqDpIBaC
X-Proofpoint-ORIG-GUID: bHSSr8BHSHik-y8bA_cnUXRXLqDpIBaC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-08_03,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111080052
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


Add documentation for ad3552r

Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
---
 .../bindings/iio/dac/adi,ad3552r.yaml         | 190 ++++++++++++++++++
 1 file changed, 190 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
new file mode 100644
index 000000000000..c6999bb4c7a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
@@ -0,0 +1,190 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2020 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad3552r.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD2552R DAC device driver
+
+maintainers:
+  - Mihail Chindris <mihail.chindris@analog.com>
+
+description: |
+  Bindings for the Analog Devices AD3552R DAC device and similar.
+  Datasheet can be found here:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad3542r.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad3552r.pdf
+properties:
+  compatible:
+    enum:
+      - adi,ad3542r
+      - adi,ad3552r
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 30000000
+
+  reset-gpios:
+    maxItems: 1
+
+  ldac-gpios:
+    description: |
+      LDAC pin to be used as a hardware trigger to update the DAC channels.
+    maxItems: 1
+
+  vref-supply:
+    description:
+      The regulator to use as an external reference. If it does not exists the
+      internal reference will be used. External reference must be 2.5V
+
+  adi,vref-out-en:
+    description: Vref I/O driven by internal vref to 2.5V. If not set, Vref pin
+      will be floating.
+    type: boolean
+
+  adi,sdo-drive-strength:
+    description: |
+      Configure SDIO0 and SDIO1 strength levels:
+        - 0: low SDO drive strength.
+        - 1: medium low SDO drive strength.
+        - 2: medium high SDO drive strength.
+        - 3: high SDO drive strength
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+
+patternProperties:
+  "^channel@([0-1])$":
+    type: object
+    description: Configurations of the DAC Channels
+    properties:
+      reg:
+          description: Channel number
+          enum: [0, 1]
+
+      custom-output-range-config:
+        type: object
+        description: Configuration of custom range when
+          adi,output-range-microvolt is not present.
+          The formulas for calculation the output voltages are
+            Vout_fs = 2.5 + [(GainN + Offset/1024) * 2.5 * Rfbx * 1.03]
+            Vout_zs = 2.5 - [(GainP + Offset/1024) * 2.5 * Rfbx * 1.03]
+        properties:
+          adi,gain-offset:
+            description: Gain offset used in the above formula
+            $ref: /schemas/types.yaml#/definitions/int32
+            maximum: 511
+            minimum: -511
+          adi,gain-scaling-p-inv-log2:
+            description: GainP = 1 / ( 2 ^ adi,gain-scaling-p-inv-log2)
+            $ref: /schemas/types.yaml#/definitions/uint32
+            enum: [0, 1, 2, 3]
+          adi,gain-scaling-n-inv-log2:
+            description: GainN = 1 / ( 2 ^ adi,gain-scaling-n-inv-log2)
+            $ref: /schemas/types.yaml#/definitions/uint32
+            enum: [0, 1, 2, 3]
+          adi,rfb-ohms:
+            description: Feedback Resistor
+        required:
+          - adi,gain-offset
+          - adi,gain-scaling-p-inv-log2
+          - adi,gain-scaling-n-inv-log2
+          - adi,rfb-ohms
+    required:
+      - reg
+
+    oneOf:
+      # If adi,output-range-microvolt is missing,
+      # custom-output-range-config must be used
+      - required:
+        - adi,output-range-microvolt
+      - required:
+        - custom-output-range-config
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,ad3542r
+    then:
+      patternProperties:
+        "^channel@([0-1])$":
+          type: object
+          properties:
+            adi,output-range-microvolt:
+              description: |
+                Voltage output range of the channel as <minimum, maximum>
+                Required connections:
+                  Rfb1x for: 0 to 2.5 V; 0 to 3V; 0 to 5 V;
+                  Rfb2x for: 0 to 10 V; 2.5 to 7.5V; -5 to 5 V;
+              oneOf:
+                - items:
+                    - const: 0
+                    - enum: [2500000, 3000000, 5000000, 10000000]
+                - items:
+                    - const: -2500000
+                    - const: 7500000
+                - items:
+                    - const: -5000000
+                    - const: 5000000
+          required:
+            - adi,output-range-microvolt
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,ad3552r
+    then:
+      patternProperties:
+        "^channel@([0-1])$":
+          type: object
+          properties:
+            adi,output-range-microvolt:
+              description: |
+                Voltage output range of the channel as <minimum, maximum>
+                Required connections:
+                  Rfb1x for: 0 to 2.5 V; 0 to 5 V;
+                  Rfb2x for: 0 to 10 V; -5 to 5 V;
+                  Rfb4x for: -10 to 10V
+              oneOf:
+                - items:
+                    - const: 0
+                    - enum: [2500000, 5000000, 10000000]
+                - items:
+                    - const: -5000000
+                    - const: 5000000
+                - items:
+                    - const: -10000000
+                    - const: 10000000
+
+required:
+  - compatible
+  - reg
+  - spi-max-frequency
+
+additionalProperties: false
+
+examples:
+  - |
+    ad3552r {
+            compatible = "adi,ad3552r";
+            reg = <0>;
+            spi-max-frequency = <20000000>;
+            channel@0 {
+                    reg = <0>;
+                    adi,output-range-microvolt = <0 10000000>;
+            };
+            channel@1 {
+                    reg = <1>;
+                    custom-output-range-config {
+                            adi,gain-offset = <5>;
+                            adi,gain-scaling-p-inv-log2 = <1>;
+                            adi,gain-scaling-n-inv-log2 = <2>;
+                            adi,rfb-ohms = <1>;
+                    };
+          };
+      };
+...
-- 
2.27.0

