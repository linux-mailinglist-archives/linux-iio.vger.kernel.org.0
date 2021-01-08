Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC6E2EF76D
	for <lists+linux-iio@lfdr.de>; Fri,  8 Jan 2021 19:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbhAHSew (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Jan 2021 13:34:52 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:63236 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726650AbhAHSew (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Jan 2021 13:34:52 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 108IK5r5015853;
        Fri, 8 Jan 2021 13:34:10 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 35wnkjnwmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Jan 2021 13:34:10 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 108IY9bZ059763
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Jan 2021 13:34:09 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2; Fri, 8 Jan 2021
 13:34:08 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 8 Jan 2021 13:34:08 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 108IY6P7025936;
        Fri, 8 Jan 2021 13:34:06 -0500
From:   Cristian Pop <cristian.pop@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        Cristian Pop <cristian.pop@analog.com>
Subject: [PATCH v5 1/3] dt-bindings: iio: dac: AD5766 yaml documentation
Date:   Fri, 8 Jan 2021 20:37:37 +0200
Message-ID: <20210108183739.27634-1-cristian.pop@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-08_08:2021-01-07,2021-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 phishscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101080100
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds device tree bindings for the AD5766 DAC.

Signed-off-by: Cristian Pop <cristian.pop@analog.com>
---
Changelog v5:                                                              
        -rename to property to "output-range-voltage"
 .../bindings/iio/dac/adi,ad5766.yaml          | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
new file mode 100644
index 000000000000..1deace7c48b2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5766.yaml
@@ -0,0 +1,64 @@
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
+  output-range-volts:
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
+    description: GPIO spec for the RESET pin. If specified, it will be asserted
+      during driver probe. As the line is active low, it should be marked
+      GPIO_ACTIVE_LOW.
+    maxItems: 1
+
+required:
+  - compatible
+  - output-range-volts
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
+              output-range-volts = <(-5) 5>;
+              reg = <0>;
+              spi-cpol;
+              spi-max-frequency = <1000000>;
+              reset-gpios = <&gpio 22 0>;
+            };
+      };
-- 
2.17.1

