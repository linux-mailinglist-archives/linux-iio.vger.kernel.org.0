Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B61456E33
	for <lists+linux-iio@lfdr.de>; Fri, 19 Nov 2021 12:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbhKSLdJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Nov 2021 06:33:09 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:46464 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235042AbhKSLdJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Nov 2021 06:33:09 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AJ21JFf025301;
        Fri, 19 Nov 2021 06:30:07 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3cd5u5ufw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 06:30:07 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 1AJBU5Ch037582
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Nov 2021 06:30:05 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Fri, 19 Nov 2021
 06:30:04 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Fri, 19 Nov 2021 06:30:04 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1AJBU3KL014813;
        Fri, 19 Nov 2021 06:30:03 -0500
From:   Cristian Pop <cristian.pop@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, Cristian Pop <cristian.pop@analog.com>
Subject: [PATCH v1 1/2] dt:bindings:iio:frequency: Add ADMV4420 doc
Date:   Fri, 19 Nov 2021 13:40:10 +0200
Message-ID: <20211119114011.75406-1-cristian.pop@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: HrqxNphhdytz2HLTt5WKXs88GlnwRJwW
X-Proofpoint-ORIG-GUID: HrqxNphhdytz2HLTt5WKXs88GlnwRJwW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-19_09,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 clxscore=1011 bulkscore=0 mlxlogscore=999 impostorscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111190064
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree bindings for the ADMV4420 K band downconverter.

Signed-off-by: Cristian Pop <cristian.pop@analog.com>
---
 .../bindings/iio/frequency/adi,admv4420.yaml  | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
new file mode 100644
index 000000000000..69f1b4a41c5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/frequency/adi,admv4420.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADMV4420 K Band Downconverter
+
+maintainers:
+- Cristian Pop <cristian.pop@analog.com>
+
+description: |
+    The ADMV4420 is a highly integrated, double balanced, active
+    mixer with an integrated fractional-N synthesizer, ideally suited
+    for next generation K band satellite communications
+
+properties:
+  compatible:
+    enum:
+      - adi,admv4420
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 1000000
+
+  adi,ref_single_ended:
+    description: Reference clock type.
+    type: boolean
+
+  adi,ref_freq_hz:
+    description: Reference clock frequency.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  adi,ref_doubler_en:
+    description: Reference multiplied by 2.
+    type: boolean
+
+  adi,ref_divide_by_2_en:
+    description: Reference divided by 2.
+    type: boolean
+
+  adi,ref_divider:
+    description: Reference divider value.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  adi,N_counter_int_val:
+    description: N counted int val.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  adi,N_counter_frac_val:
+    description: N counted frac val.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  adi,N_counter_mod_val:
+    description: N counted mod val.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  adi,mux_sel:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 4, 5, 8]
+    description: |
+      Multiplexer output allows access to various internal signals:
+      0: Output Logic Low
+      1: Digital Lock Detect
+      4: RDiv-by-2 to Mux Out, Frequency = REFIN/(2 x R)
+      5: NDiv-by-2 to Mux Out, Frequency = VCO/(2 x N)
+      8: Output Logic High.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      admv4420@0 {
+        compatible = "adi,admv4420";
+        reg = <0>;
+        spi-max-frequency = <1000000>;
+
+        /* reference block config */
+        adi,ref_freq_hz = <50000000>;
+        adi,ref_single_ended = <0>;
+        adi,ref_divider = <1>;
+
+        /* N counter config*/
+        adi,N_counter_int_val = <0xA7>;
+        adi,N_counter_frac_val = <0x02>;
+        adi,N_counter_mod_val = <0x04>;
+
+        adi,mux_sel = <1>;
+      };
+    };
+...
-- 
2.17.1

