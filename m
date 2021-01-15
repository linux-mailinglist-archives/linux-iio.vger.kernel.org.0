Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D5E2F7770
	for <lists+linux-iio@lfdr.de>; Fri, 15 Jan 2021 12:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbhAOLSc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Jan 2021 06:18:32 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:7778 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726091AbhAOLSb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jan 2021 06:18:31 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10FBFGG1011912;
        Fri, 15 Jan 2021 06:17:49 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 35ya984aax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jan 2021 06:17:49 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 10FBHm2H030490
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Jan 2021 06:17:48 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Fri, 15 Jan 2021
 06:17:47 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Fri, 15 Jan 2021 06:17:47 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 10FBHhWK004415;
        Fri, 15 Jan 2021 06:17:44 -0500
From:   Cristian Pop <cristian.pop@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        Cristian Pop <cristian.pop@analog.com>
Subject: [PATCH v6 1/3] dt-bindings: iio: dac: AD5766 yaml documentation
Date:   Fri, 15 Jan 2021 13:21:03 +0200
Message-ID: <20210115112105.58652-1-cristian.pop@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-15_06:2021-01-15,2021-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101150069
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds device tree bindings for the AD5766 DAC.

Signed-off-by: Cristian Pop <cristian.pop@analog.com>
---
Changelog v6:
	- Use microvolt unit
	- Remove unrelevant to the binding comment
 .../bindings/iio/dac/adi,ad5766.yaml          | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
new file mode 100644
index 000000000000..7fdd2c42441d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2020 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad5766.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5766 DAC device driver
+
+maintainers:
+  - Cristian Pop <cristian.pop@analog.com>
+
+description: |
+  Bindings for the Analog Devices AD5766 current DAC device. Datasheet can be
+  found here:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad5766-5767.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad5766
+      - adi,ad5767
+
+  output-range-microvolts:
+    description: Select converter output range.
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 1000000
+
+  spi-cpol: true
+
+  reset-gpios:
+    description: GPIO spec for the RESET pin. As the line is active low, it
+      should be marked GPIO_ACTIVE_LOW.
+    maxItems: 1
+
+required:
+  - compatible
+  - output-range-microvolts
+  - reg
+  - spi-max-frequency
+  - spi-cpol
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+          #address-cells = <1>;
+          #size-cells = <0>;
+          
+          ad5766@0 {
+              compatible = "adi,ad5766";
+              output-range-microvolts = <(-5000) 5000>;
+              reg = <0>;
+              spi-cpol;
+              spi-max-frequency = <1000000>;
+              reset-gpios = <&gpio 22 0>;
+            };
+      };
-- 
2.17.1

