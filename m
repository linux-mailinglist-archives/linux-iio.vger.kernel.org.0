Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1463B743C
	for <lists+linux-iio@lfdr.de>; Tue, 29 Jun 2021 16:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbhF2O2E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Jun 2021 10:28:04 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:18430 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234292AbhF2O2C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Jun 2021 10:28:02 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15TEJ5JO025194;
        Tue, 29 Jun 2021 10:25:34 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 39fp4btsrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Jun 2021 10:25:34 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 15TEPX5F030073
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Jun 2021 10:25:33 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Tue, 29 Jun 2021
 10:25:32 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Tue, 29 Jun 2021 10:25:32 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.128])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 15TEPRhJ027422;
        Tue, 29 Jun 2021 10:25:30 -0400
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 2/2] dt-bindings: iio: frequency: add adrf6780 doc
Date:   Tue, 29 Jun 2021 17:23:08 +0300
Message-ID: <20210629142308.25868-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210629142308.25868-1-antoniu.miclaus@analog.com>
References: <20210629142308.25868-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 20LX94TUeiaw5ui62SV7vv1f44f2M-mf
X-Proofpoint-ORIG-GUID: 20LX94TUeiaw5ui62SV7vv1f44f2M-mf
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-29_06:2021-06-28,2021-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106290096
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree bindings for the ADRF6780 Upconverter.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 .../bindings/iio/frequency/adi,adrf6780.yaml  | 133 ++++++++++++++++++
 1 file changed, 133 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
new file mode 100644
index 000000000000..008f76095a63
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.yaml
@@ -0,0 +1,133 @@
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
+  adi,parity-en:
+    description:
+      Enable Parity for Write execution.
+    type: boolean
+
+  adi,vga-buff-en:
+    description:
+      VGA Buffer Enable.
+    type: boolean
+
+  adi,det-en:
+    description:
+      Detector Enable.
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
+        adi,parity-en;
+      };
+    };
+...
+
-- 
2.32.0

