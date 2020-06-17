Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9311FCE7B
	for <lists+linux-iio@lfdr.de>; Wed, 17 Jun 2020 15:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgFQNdG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 17 Jun 2020 09:33:06 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:24758 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726355AbgFQNdD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Jun 2020 09:33:03 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05HDTnIQ019360;
        Wed, 17 Jun 2020 09:33:02 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 31q670aj5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Jun 2020 09:33:01 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 05HDWxkd008815
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 17 Jun 2020 09:33:00 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 17 Jun
 2020 06:32:58 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 17 Jun 2020 06:32:58 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 05HDWtWP018768;
        Wed, 17 Jun 2020 09:32:57 -0400
From:   Darius Berghe <darius.berghe@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>
Subject: [PATCH v1 3/3] iio:adc:ltc2471: add dt binding yaml
Date:   Wed, 17 Jun 2020 16:35:23 +0300
Message-ID: <20200617133523.58158-3-darius.berghe@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617133523.58158-1-darius.berghe@analog.com>
References: <20200617133523.58158-1-darius.berghe@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-17_03:2020-06-17,2020-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 cotscore=-2147483648 spamscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006170104
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add dt binding documentation for ltc2471 driver. This covers all supported
devices.

Signed-off-by: Darius Berghe <darius.berghe@analog.com>
---
 .../bindings/iio/adc/adi,ltc2471.yaml         | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ltc2471.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ltc2471.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ltc2471.yaml
new file mode 100644
index 000000000000..0b84e14ec984
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ltc2471.yaml
@@ -0,0 +1,52 @@
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
+  Analog Devices LTC2471 (single-ended) and LTC2473 (differential) 16-bit
+  I2C Sigma-Delta ADC with selectable 208/833sps output rate.
+  https://www.analog.com/media/en/technical-documentation/data-sheets/24713fb.pdf
+
+  Analog Devices LTC2461 (single-ended) and LTC2463 (differential) 16-bit
+  I2C Sigma-Delta ADC with 60sps output rate.
+  https://www.analog.com/media/en/technical-documentation/data-sheets/24613fa.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ltc2471
+      - adi,ltc2473
+      - adi,ltc2461
+      - adi,ltc2463
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c0 {
+      ltc2461@14 {
+        compatible = "ltc2461";
+        reg = <0x14>;
+      };
+    };
+  - |
+    i2c0 {
+      ltc2473@54 {
+        compatible = "ltc2473";
+        reg = <0x54>;
+      };
+    };
+
-- 
2.26.2

