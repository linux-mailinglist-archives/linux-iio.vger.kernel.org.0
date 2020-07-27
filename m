Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D7722EE0B
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jul 2020 15:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbgG0N5A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jul 2020 09:57:00 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:33812 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728815AbgG0N5A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2020 09:57:00 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06RDnfGi022328;
        Mon, 27 Jul 2020 09:56:59 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 32gek66tyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 09:56:59 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 06RDuw4l005706
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 27 Jul 2020 09:56:58 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 27 Jul 2020 09:56:57 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 27 Jul 2020 09:56:55 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 27 Jul 2020 09:56:55 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 06RDunPK001316;
        Mon, 27 Jul 2020 09:56:54 -0400
From:   Darius Berghe <darius.berghe@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <jic23@kernel.org>, <robh@kernel.org>
Subject: [PATCH v3 3/3] ltc2471 driver yaml
Date:   Mon, 27 Jul 2020 16:58:34 +0300
Message-ID: <20200727135834.84093-4-darius.berghe@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200727135834.84093-1-darius.berghe@analog.com>
References: <20200727135834.84093-1-darius.berghe@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_08:2020-07-27,2020-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007270102
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

