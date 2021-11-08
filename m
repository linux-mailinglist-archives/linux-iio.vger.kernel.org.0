Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7B044983D
	for <lists+linux-iio@lfdr.de>; Mon,  8 Nov 2021 16:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239204AbhKHP3F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Nov 2021 10:29:05 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:43806 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235860AbhKHP3F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Nov 2021 10:29:05 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1A89AWDh025830;
        Mon, 8 Nov 2021 10:26:20 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3c711fsr8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Nov 2021 10:26:20 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 1A8FQJm0033165
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Nov 2021 10:26:19 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Mon, 8 Nov 2021
 10:26:18 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.858.5 via Frontend Transport;
 Mon, 8 Nov 2021 10:26:18 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.181])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1A8FQEqD023501;
        Mon, 8 Nov 2021 10:26:16 -0500
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 2/2] dt-bindings:iio:amplifiers: add ad7293 doc
Date:   Mon, 8 Nov 2021 17:22:38 +0200
Message-ID: <20211108152238.189650-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211108152238.189650-1-antoniu.miclaus@analog.com>
References: <20211108152238.189650-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: GaJg0lW7Pkmamm-XPa1sghMDKctRN8z5
X-Proofpoint-GUID: GaJg0lW7Pkmamm-XPa1sghMDKctRN8z5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-08_05,2021-11-08_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 phishscore=0 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111080095
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree bindings for the AD7293 Power Amplifier.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v2:
 - add support for AVDD and VDRIVE voltage regulators
 - add support for reset GPIO
 .../bindings/iio/amplifiers/adi,ad7293.yaml   | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,ad7293.yaml

diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,ad7293.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,ad7293.yaml
new file mode 100644
index 000000000000..9f1b2eb78af3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,ad7293.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/amplifiers/adi,ad7293.yaml#
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
+  avdd-supply:
+    description:
+      AVDD voltage regulator.
+
+  vdrive-supply:
+    description:
+      VDRIVE voltage regulator.
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 1000000
+
+  reset-gpios: true
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
2.33.1

