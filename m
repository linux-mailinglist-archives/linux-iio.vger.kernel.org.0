Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948384462B3
	for <lists+linux-iio@lfdr.de>; Fri,  5 Nov 2021 12:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbhKELc1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 5 Nov 2021 07:32:27 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:2060 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231486AbhKELcZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Nov 2021 07:32:25 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A50YEtj019817;
        Fri, 5 Nov 2021 07:29:45 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3c4t6f2pme-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Nov 2021 07:29:44 -0400
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 1A5BThDd018149
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 5 Nov 2021 07:29:43 -0400
Received: from SCSQCASHYB6.ad.analog.com (10.77.17.132) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Fri, 5 Nov 2021 04:29:42 -0700
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by
 SCSQCASHYB6.ad.analog.com (10.77.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Fri, 5 Nov 2021 04:29:41 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Fri, 5 Nov 2021 04:29:41 -0700
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.181])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1A5BTbk1016952;
        Fri, 5 Nov 2021 07:29:40 -0400
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v4 2/3] dt-bindings: iio: frequency: add admv1013 doc
Date:   Fri, 5 Nov 2021 13:29:29 +0200
Message-ID: <20211105112930.122017-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211105112930.122017-1-antoniu.miclaus@analog.com>
References: <20211105112930.122017-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: w-vZkLvhFHD5WV7dPxta8CSOQBWQVOC8
X-Proofpoint-ORIG-GUID: w-vZkLvhFHD5WV7dPxta8CSOQBWQVOC8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-05_01,2021-11-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111050067
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree bindings for the ADMV1013 Upconverter.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 .../bindings/iio/frequency/adi,admv1013.yaml  | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
new file mode 100644
index 000000000000..47993253a586
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
@@ -0,0 +1,119 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/frequency/adi,admv1013.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADMV1013 Microwave Upconverter
+
+maintainers:
+  - Antoniu Miclaus <antoniu.miclaus@analog.com>
+
+description: |
+   Wideband, microwave upconverter optimized for point to point microwave
+   radio designs operating in the 24 GHz to 44 GHz frequency range.
+
+   https://www.analog.com/en/products/admv1013.html
+
+properties:
+  compatible:
+    enum:
+      - adi,admv1013
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 1000000
+
+  clocks:
+    description:
+      Definition of the external clock.
+    minItems: 1
+
+  clock-names:
+    items:
+      - const: lo_in
+
+  clock-output-names:
+    maxItems: 1
+
+  vcm-supply:
+    description:
+      Analog voltage regulator.
+
+  adi,vga-powerdown:
+    description:
+      Power Down the Voltage Gain Amplifier Circuit available at
+      BG_RBIAS2 pin.
+    type: boolean
+
+  adi,mixer-powerdown:
+    description:
+      Power Down the Mixer Circuit. Enable to put the block in
+      a power down state.
+    type: boolean
+
+  adi,quad-powerdown:
+    description:
+      Power Down the Quadrupler. Enable to put the block in
+      a power down state.
+    type: boolean
+
+  adi,bg-powerdown:
+    description:
+      Power Down the Transmitter Band Gap. Enable to put the part in
+      a power down state.
+    type: boolean
+
+  adi,mixer-if-enable:
+    description:
+      Enable the Intermediate Frequency Mode. Either IF Mode or I/Q Mode
+      can be enabled at a time.
+    type: boolean
+
+  adi,detector-enable:
+    description:
+      Enable the Envelope Detector available at output pins VENV_P and
+      VENV_N. Disable to reduce power consumption.
+    type: boolean
+
+  adi,quad-se-mode:
+    description:
+      Switch the LO path from differential to single-ended operation.
+      Set value 6 for Single-Ended Mode, Negative Side Disabled.
+      Set value 9 for Single-Ended Mode, Positive Side Disabled.
+      Set value 12 for Differential Mode.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [6, 9, 12]
+
+  '#clock-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - vcm-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      admv1013@0{
+        compatible = "adi,admv1013";
+        reg = <0>;
+        spi-max-frequency = <1000000>;
+        clocks = <&admv1013_lo>;
+        clock-names = "lo_in";
+        vcm-supply = <&vcm>;
+        adi,quad-se-mode = <12>;
+        adi,mixer-if-enable;
+        adi,detector-enable;
+      };
+    };
+...
-- 
2.33.1

