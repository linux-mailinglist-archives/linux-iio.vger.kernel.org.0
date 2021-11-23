Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B3145A20A
	for <lists+linux-iio@lfdr.de>; Tue, 23 Nov 2021 12:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbhKWL55 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 23 Nov 2021 06:57:57 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:28898 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236683AbhKWL5z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 Nov 2021 06:57:55 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1ANAL4WM009293;
        Tue, 23 Nov 2021 06:54:47 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3cg6mm02wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Nov 2021 06:54:47 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 1ANBskYZ035312
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Nov 2021 06:54:46 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Tue, 23 Nov 2021 06:54:45 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Tue, 23 Nov 2021 06:54:45 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Tue, 23 Nov 2021 06:54:45 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.181])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1ANBsf0h026107;
        Tue, 23 Nov 2021 06:54:43 -0500
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v5 2/3] dt-bindings: iio: frequency: add admv1013 doc
Date:   Tue, 23 Nov 2021 13:53:35 +0200
Message-ID: <20211123115336.65827-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211123115336.65827-1-antoniu.miclaus@analog.com>
References: <20211123115336.65827-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: i2K45apHSBlxpBwtuoFV8DekTmH1h7YH
X-Proofpoint-ORIG-GUID: i2K45apHSBlxpBwtuoFV8DekTmH1h7YH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_04,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111230066
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree bindings for the ADMV1013 Upconverter.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 - remove powerdown properties from the dt bindings
 - update quad-se-mode property using strings enum
 .../bindings/iio/frequency/adi,admv1013.yaml  | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
new file mode 100644
index 000000000000..adbff58cbbf4
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.yaml
@@ -0,0 +1,87 @@
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
+  adi,detector-enable:
+    description:
+      Enable the Envelope Detector available at output pins VENV_P and
+      VENV_N. Disable to reduce power consumption.
+    type: boolean
+
+  adi,quad-se-mode:
+    description:
+      Switch the LO path from differential to single-ended operation.
+      se-neg - Single-Ended Mode, Negative Side Disabled.
+      se-pos - Single-Ended Mode, Positive Side Disabled.
+      diff - Differential Mode.
+    enum: [se-neg, se-pos, diff]
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
+        adi,quad-se-mode = "diff";
+        adi,detector-enable;
+      };
+    };
+...
-- 
2.34.0

