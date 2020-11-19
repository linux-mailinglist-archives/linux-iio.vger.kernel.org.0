Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7FD2B8FC6
	for <lists+linux-iio@lfdr.de>; Thu, 19 Nov 2020 11:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgKSKCt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Nov 2020 05:02:49 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:4960 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727174AbgKSKCr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Nov 2020 05:02:47 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJA0Mmm010496;
        Thu, 19 Nov 2020 05:02:45 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 34t9ybsjhh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 05:02:45 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0AJA2h0x011186
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 19 Nov 2020 05:02:43 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 19 Nov 2020 02:02:42 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 19 Nov 2020 02:02:42 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0AJA2Ydf018635;
        Thu, 19 Nov 2020 05:02:39 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <jic23@kernel.org>,
        <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 4/4] dt-bindings: adc: ad7887: add binding doc for AD7887
Date:   Thu, 19 Nov 2020 12:07:48 +0200
Message-ID: <20201119100748.57689-4-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201119100748.57689-1-alexandru.ardelean@analog.com>
References: <20201119100748.57689-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_08:2020-11-17,2020-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190073
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change adds a simple device-tree binding for thhe Analog Devices
AD7887 ADC.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../bindings/iio/adc/adi,ad7887.yaml          | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7887.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7887.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7887.yaml
new file mode 100644
index 000000000000..9b30f4569b4e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7887.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7887.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7887 low power, 12-bit ADC
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+
+description: |
+  Analog Devices AD7887 low power, 12-bit analog-to-digital converter (ADC)
+  that operates from a single 2.7 V to 5.25 V power supply.
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7887
+
+  reg:
+    maxItems: 1
+
+  spi-cpha: true
+
+  spi-cpol: true
+
+  avcc-supply: true
+
+  spi-max-frequency: true
+
+  vref-supply:
+    description:
+      ADC reference voltage supply
+
+  adi,dual-channel-mode:
+    description:
+      Configures dual-channel mode for the ADC. In dual-channel operation,
+      the AIN1/VREF pin assumes its AIN1 function, providing a second analog
+      input channel. In this case, he reference voltage for the part is provided
+      via the VDD pin. As a result, the input voltage range on both the AIN0 and
+      AIN1 inputs is 0 to VDD.
+    type: boolean
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - spi-cpha
+  - spi-cpol
+
+examples:
+  - |
+    spi0 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+                compatible = "adi,ad7887";
+                reg = <0>;
+                spi-max-frequency = <1000000>;
+                spi-cpol;
+                spi-cpha;
+
+                avcc-supply = <&adc_supply>;
+                vref-supply = <&adc_vref>;
+        };
+    };
+...
-- 
2.17.1

