Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4052441967
	for <lists+linux-iio@lfdr.de>; Mon,  1 Nov 2021 11:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbhKAKHi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Nov 2021 06:07:38 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:39248 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232416AbhKAKHN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 Nov 2021 06:07:13 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A19U5RF014923;
        Mon, 1 Nov 2021 06:04:39 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3c2dnkr4k1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Nov 2021 06:04:39 -0400
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 1A1A4bre029199
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Nov 2021 06:04:38 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Mon, 1 Nov 2021 03:04:36 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Mon, 1 Nov 2021 03:04:36 -0700
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.121])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1A1A4R6o012768;
        Mon, 1 Nov 2021 06:04:30 -0400
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <nuno.sa@analog.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 2/2] dt-bindings: iio: frequency: add admv1013 doc
Date:   Mon, 1 Nov 2021 12:04:20 +0200
Message-ID: <20211101100420.70304-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211101100420.70304-1-antoniu.miclaus@analog.com>
References: <20211101100420.70304-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: q4FNfCxV9o4Ht-4qMh0GxzZnntmtHtx6
X-Proofpoint-GUID: q4FNfCxV9o4Ht-4qMh0GxzZnntmtHtx6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-01_04,2021-10-29_03,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111010057
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

