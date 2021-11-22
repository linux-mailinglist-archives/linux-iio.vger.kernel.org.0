Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201D2458F87
	for <lists+linux-iio@lfdr.de>; Mon, 22 Nov 2021 14:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbhKVNkG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 22 Nov 2021 08:40:06 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:16288 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233849AbhKVNkF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Nov 2021 08:40:05 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AM7DXtP009084;
        Mon, 22 Nov 2021 08:36:59 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3cg6mksvc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Nov 2021 08:36:58 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 1AMDapCi033989
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Nov 2021 08:36:51 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Mon, 22 Nov 2021
 08:36:50 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Mon, 22 Nov 2021 08:36:50 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.145])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1AMDakCX005963;
        Mon, 22 Nov 2021 08:36:48 -0500
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v4 2/2] dt-bindings:iio:amplifiers: add ad7293 doc
Date:   Mon, 22 Nov 2021 15:36:39 +0200
Message-ID: <20211122133639.132972-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211122133639.132972-1-antoniu.miclaus@analog.com>
References: <20211122133639.132972-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: i-DnEY4y7mE_SRUYfraDyau06H01gfqX
X-Proofpoint-ORIG-GUID: i-DnEY4y7mE_SRUYfraDyau06H01gfqX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-22_06,2021-11-22_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111220072
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree bindings for the AD7293 Power Amplifier.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v4:
 - set `avdd-supply: true`
 - set `maxItems` for reset-gpios
 .../bindings/iio/dac/adi,ad7293.yaml          | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad7293.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad7293.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad7293.yaml
new file mode 100644
index 000000000000..7951ffe8805b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad7293.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad7293.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AD7293 12-Bit Power Amplifier Current Controller with ADC,
+       DACs, Temperature and Current Sensors
+
+maintainers:
+  - Antoniu Miclaus <antoniu.miclaus@analog.com>
+
+description: |
+   Power Amplifier drain current controller containing functionality
+   for general-purpose monitoring and control of current, voltage,
+   and temperature, integrated into a single chip solution with an
+   SPI-compatible interface.
+
+   https://www.analog.com/en/products/ad7293.html
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7293
+
+  avdd-supply: true
+
+  vdrive-supply:
+    description:
+      VDRIVE voltage regulator.
+
+  reset-gpios:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 1000000
+
+required:
+  - compatible
+  - reg
+  - avdd-supply
+  - vdrive-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      ad7293@0 {
+        compatible = "adi,ad7293";
+        reg = <0>;
+        spi-max-frequency = <1000000>;
+        avdd-supply = <&avdd>;
+        vdrive-supply = <&vdrive>;
+        reset-gpios = <&gpio 10 0>;
+      };
+    };
+...
-- 
2.34.0

