Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00D7221FF4
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jul 2020 11:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgGPJoO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Jul 2020 05:44:14 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:63738 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728022AbgGPJoM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2020 05:44:12 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06G9e8bJ031070;
        Thu, 16 Jul 2020 05:44:11 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3279gmq8hv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 05:44:11 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 06G9i9ec057827
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 16 Jul 2020 05:44:09 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 16 Jul
 2020 02:44:08 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 16 Jul 2020 02:44:08 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 06G9i21p001073;
        Thu, 16 Jul 2020 05:44:07 -0400
From:   Darius Berghe <darius.berghe@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>
Subject: [PATCH v2 3/3] ltc2471 driver yaml
Date:   Thu, 16 Jul 2020 12:46:11 +0300
Message-ID: <20200716094611.81746-4-darius.berghe@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716094611.81746-1-darius.berghe@analog.com>
References: <20200716094611.81746-1-darius.berghe@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-16_05:2020-07-16,2020-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007160075
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add dt binding documentation for ltc2471 driver. This covers all supported
devices.

Signed-off-by: Darius Berghe <darius.berghe@analog.com>
---
 .../bindings/iio/adc/adi,ltc2471.yaml         | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ltc2471.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ltc2471.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ltc2471.yaml
new file mode 100644
index 000000000000..d5b35a1fa651
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ltc2471.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2020 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bindings/iio/adc/adi,ltc2471.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices LTC2471 16-bit I2C Sigma-Delta ADC
+
+maintainers:
+  - Mike Looijmans <mike.looijmans@topic.nl>
+
+description: |
+  Analog Devices LTC2461 (single-ended) and LTC2463 (differential) 16-bit
+  I2C Sigma-Delta ADC with 60sps output rate.
+  https://www.analog.com/media/en/technical-documentation/data-sheets/24613fa.pdf
+
+  Analog Devices LTC2471 (single-ended) and LTC2473 (differential) 16-bit
+  I2C Sigma-Delta ADC with selectable 208/833sps output rate.
+  https://www.analog.com/media/en/technical-documentation/data-sheets/24713fb.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ltc2461
+      - adi,ltc2463
+      - adi,ltc2471
+      - adi,ltc2473
+
+  reg:
+    maxItems: 1
+
+  avcc-supply:
+    description:
+      Phandle to the Avcc power supply (2.7V - 5.5V)
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c0 {
+      adc@14 {
+        compatible = "adi,ltc2461";
+        reg = <0x14>;
+      };
+    };
+
-- 
2.27.0

