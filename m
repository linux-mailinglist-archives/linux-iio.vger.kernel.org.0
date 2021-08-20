Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8643E3F31DE
	for <lists+linux-iio@lfdr.de>; Fri, 20 Aug 2021 19:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbhHTRCE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Aug 2021 13:02:04 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:62928 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233093AbhHTRB7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Aug 2021 13:01:59 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17KGkcnW019308;
        Fri, 20 Aug 2021 13:01:10 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3aj61f3act-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Aug 2021 13:01:10 -0400
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 17KH18Kl023693
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 20 Aug 2021 13:01:08 -0400
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Fri, 20 Aug 2021 10:01:07 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Fri, 20 Aug 2021 10:01:07 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Fri, 20 Aug 2021 10:01:07 -0700
Received: from ubuntuservermchindri.ad.analog.com ([10.32.225.46])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 17KH0YNS013729;
        Fri, 20 Aug 2021 13:01:04 -0400
From:   Mihail Chindris <mihail.chindris@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>,
        <dragos.bogdan@analog.com>, <alexandru.ardelean@analog.com>,
        Mihail Chindris <mihail.chindris@analog.com>
Subject: [PATCH v4 5/6] dt-bindings: iio: dac: Add adi,ad3552r.yaml
Date:   Fri, 20 Aug 2021 16:59:26 +0000
Message-ID: <20210820165927.4524-6-mihail.chindris@analog.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210820165927.4524-1-mihail.chindris@analog.com>
References: <20210820165927.4524-1-mihail.chindris@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: rAH2T4LZEfXYFuoEDZrXpFoeQaf8OVY5
X-Proofpoint-ORIG-GUID: rAH2T4LZEfXYFuoEDZrXpFoeQaf8OVY5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-20_06,2021-08-20_03,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108200095
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add documentation for ad3552r

Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
---
 .../bindings/iio/dac/adi,ad3552r.yaml         | 185 ++++++++++++++++++
 1 file changed, 185 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
new file mode 100644
index 000000000000..82ad8335aed8
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
@@ -0,0 +1,185 @@
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
+  Bindings for the Analog Devices AD3552R  DAC device. Datasheet can be
+  found here:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad3552r.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad3552r
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 30000000
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  ldac-gpios:
+    description: |
+      If a LDAC gpio is specified it will generate a LDAC pulse each time the
+      trigger handler sends data to the chip.
+    maxItems: 1
+
+  adi,synch_channels: |
+      If set to true, data will be written to the input registers. When a pulse
+      is generated on the LDAC pin data will update the output voltage of both
+      channels if enabled. If ldac-gpios is specified the pulse will be
+      generated by the driver in the interrupt handler. If adi,synch_channels
+      is set to false, data will be written to the DAC registers and the output
+      is updated imediatly after each register is written.
+    type: bool
+
+  adi,vref-select:
+    description: Selection of the voltage reference.
+      The options are
+       - 0 internal source with Vref I/O floating
+       - 1 internal source with Vref I/O at 2.5V.
+       - 2 external source with Vref I/O as input.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2]
+
+  adi,spi-multi-io-mode:
+    description:  |
+      Select SPI operating mode:
+        - 0: standard.
+        - 1: dual.
+        - 2: quad.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2]
+
+  adi,ddr:
+    description: Enable or disable double data rate SPI
+    type: boolean
+
+  adi,synchronous-mode:
+    description: Enable or disable synchronous dual SPI mode
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
+          minimum: 0
+          maximum: 1
+
+      adi,output-range:
+        description: |
+          Output range of the channel
+            0: 0 V to 2.5 V
+            1: 0 V to 5 V
+            2: 0 V to 10 V
+            3: -5 V to 5 V
+            4: -10 V to 10 V
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 2, 3, 4]
+
+      custom-output-range-config:
+        type: object
+        description: Configuration of custom range when adi,output-range is set
+                      to custom
+        properties:
+          adi,gain-offset:
+            description: Gain offset
+            $ref: /schemas/types.yaml#/definitions/int32
+            maximum: 511
+            minimum: -511
+          adi,gain-scaling-p:
+            description: |
+              Scaling p:
+               0: 1.0
+               1: 0.5
+               2: 0.25
+               3: 0.125
+            $ref: /schemas/types.yaml#/definitions/uint32
+            enum: [0, 1, 2, 3]
+          adi,gain-scaling-n:
+            description: |
+              Scaling p:
+               0: 1.0
+               1: 0.5
+               2: 0.25
+               3: 0.125
+            $ref: /schemas/types.yaml#/definitions/uint32
+            enum: [0, 1, 2, 3]
+          adi,rfb-ohms:
+            description: Feedback Resistor
+        required:
+          - adi,gain-offset
+          - adi,gain-sacling-p
+          - adi,gain-sacling-n
+          - adi,rfb-ohms
+    required:
+      - reg
+
+    oneOf:
+      # If adi,output-range is missing, custom-output-range-config must be used
+      - required:
+        - adi,output-range
+      - required:
+        - custom-output-range-config
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
+            reg = <0 0 0 0>;
+            spi-max-frequency = <20000000>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <87 0>;
+            pwms = <&axi_pwm 0 50>;
+            reset-gpios = <&gpio 86 0>;
+            adi,synch_channels;
+            adi,vref-select = <0>;
+            channel@0 {
+                    reg = <0>;
+                    adi,output-range = <0>;
+            };
+            channel@1 {
+                    reg = <1>;
+                    custom-output-range-config {
+                            adi,gain-offset = <5>;
+                            adi,gain-sacling-p = <1>;
+                            adi,gain-sacling-n = <2>;
+                            adi,rfb-ohms = <1>;
+                    };
+          };
+      };
+...
-- 
2.27.0

