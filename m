Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5F93CB6D6
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jul 2021 13:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbhGPLpY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 16 Jul 2021 07:45:24 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:5404 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232262AbhGPLpX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 16 Jul 2021 07:45:23 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16GBaJ23003923;
        Fri, 16 Jul 2021 07:42:28 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 39tw63j92x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jul 2021 07:42:27 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 16GBgQCH054713
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Jul 2021 07:42:26 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Fri, 16 Jul 2021 07:42:26 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Fri, 16 Jul 2021 07:42:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Fri, 16 Jul 2021 07:42:25 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.134])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 16GBgLLS006350;
        Fri, 16 Jul 2021 07:42:23 -0400
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jic23@kernel.org>, <devicetree@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 2/2] dt-bindings: iio: frequency: add adrf6780 doc
Date:   Fri, 16 Jul 2021 14:42:10 +0300
Message-ID: <20210716114210.141560-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210716114210.141560-1-antoniu.miclaus@analog.com>
References: <20210716114210.141560-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: PqknkWKJQQQAcuZ5cqm_do9hiQt0VW2v
X-Proofpoint-ORIG-GUID: PqknkWKJQQQAcuZ5cqm_do9hiQt0VW2v
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-16_04:2021-07-16,2021-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107160070
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree bindings for the ADRF6780 Upconverter.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v6
 .../bindings/iio/frequency/adi,adrf6780.yaml  | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
new file mode 100644
index 000000000000..65cb3bee4aca
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
@@ -0,0 +1,119 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/frequency/adi,adrf6780.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADRF6780 Microwave Upconverter
+
+maintainers:
+  - Antoniu Miclaus <antoniu.miclaus@analog.com>
+
+description: |
+   Wideband, microwave upconverter optimized for point to point microwave
+   radio designs operating in the 5.9 GHz to 23.6 GHz frequency range.
+
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
+  '#clock-cells':
+    const: 0
+
+dependencies:
+  adi,lo-x2-en: [ "adi,lo-en" ]
+  adi,lo-ppf-en: [ "adi,lo-en" ]
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      adrf6780@0 {
+        compatible = "adi,adrf6780";
+        reg = <0>;
+        spi-max-frequency = <1000000>;
+        clocks = <&adrf6780_lo>;
+        clock-names = "lo_in";
+      };
+    };
+...
-- 
2.32.0

