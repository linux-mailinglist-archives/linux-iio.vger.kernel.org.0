Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671A13B9307
	for <lists+linux-iio@lfdr.de>; Thu,  1 Jul 2021 16:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhGAOU5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Jul 2021 10:20:57 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:18222 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231844AbhGAOU4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Jul 2021 10:20:56 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 161E8Tsj025039;
        Thu, 1 Jul 2021 10:18:26 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 39gsqmv6pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jul 2021 10:18:25 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 161EIOWh031548
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Jul 2021 10:18:24 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Thu, 1 Jul 2021
 10:18:23 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Thu, 1 Jul 2021 10:18:23 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.128])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 161EILp4015832;
        Thu, 1 Jul 2021 10:18:21 -0400
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3] dt-bindings: iio: frequency: add adrf6780 doc
Date:   Thu, 1 Jul 2021 17:16:48 +0300
Message-ID: <20210701141648.131776-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 1MwEL1OgORHUxPKqp7F5GwnVUPKs7hUg
X-Proofpoint-ORIG-GUID: 1MwEL1OgORHUxPKqp7F5GwnVUPKs7hUg
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-01_08:2021-07-01,2021-07-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 adultscore=1 impostorscore=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107010088
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree bindings for the ADRF6780 Upconverter.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
v3: remove `adi,parity-en` from example after latest changes in v2 
 .../bindings/iio/frequency/adi,adrf6780.yaml  | 122 ++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
new file mode 100644
index 000000000000..b191d98bf778
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
@@ -0,0 +1,122 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/frequency/adi,adrf6780.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADRF6780 Microwave Upconverter
+
+maintainers:
+- Antoniu Miclaus <antoniu.miclaus@analog.com>
+
+description: |
+   wideband, microwave upconverter optimized for point to point microwave
+   radio designs operating in the 5.9 GHz to 23.6 GHz frequency range.
+   https://www.analog.com/en/products/adrf6780.html
+
+properties:
+  compatible:
+    enum:
+      - adi,adrf6780
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 1000000
+
+  clocks:
+    description:
+      Definition of the external clock (see clock/clock-bindings.txt)
+    minItems: 1
+
+  clock-names:
+    description:
+      Must be "lo_in"
+    maxItems: 1
+
+  clock-output-names:
+    maxItems: 1
+
+  adi,vga-buff-en:
+    description:
+      VGA Buffer Enable.
+    type: boolean
+
+  adi,lo-buff-en:
+    description:
+      LO Buffer Enable.
+    type: boolean
+
+  adi,if-mode-en:
+    description:
+      IF Mode Enable.
+    type: boolean
+
+  adi,iq-mode-en:
+    description:
+      IQ Mode Enable.
+    type: boolean
+
+  adi,lo-x2-en:
+    description:
+      LO x2 Enable.
+    type: boolean
+
+  adi,lo-ppf-en:
+    description:
+      LO x1 Enable.
+    type: boolean
+
+  adi,lo-en:
+    description:
+      LO Enable.
+    type: boolean
+
+  adi,uc-bias-en:
+    description:
+      UC Bias Enable.
+    type: boolean
+
+  adi,lo-sideband:
+    description:
+      Switch to the Other LO Sideband.
+    type: boolean
+
+  adi,vdet-out-en:
+    description:
+      VDET Output Select Enable.
+    type: boolean
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  '#clock-cells':
+    const: 0
+
+required:
+- compatible
+- reg
+- clocks
+- clock-names
+
+additionalProperties: false
+
+examples:
+- |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      adrf6780@0{
+        compatible = "adi,adrf6780";
+        reg = <0>;
+        spi-max-frequency = <1000000>;
+        clocks = <&adrf6780_lo>;
+        clock-names = "lo_in";
+      };
+    };
+...
+
-- 
2.32.0

