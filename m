Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA66E4268B8
	for <lists+linux-iio@lfdr.de>; Fri,  8 Oct 2021 13:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240417AbhJHLaj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 8 Oct 2021 07:30:39 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:65194 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240341AbhJHLah (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 8 Oct 2021 07:30:37 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1987MxiH001667;
        Fri, 8 Oct 2021 07:28:28 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 3bjhj1124f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 07:28:28 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 198BSRnl028817
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Oct 2021 07:28:27 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5; Fri, 8 Oct 2021
 07:28:26 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Fri, 8 Oct 2021 07:28:26 -0400
Received: from andrei-VirtualBox.ad.analog.com (ADRIMBAR-L02.ad.analog.com [10.48.65.112])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 198BSMC5022852;
        Fri, 8 Oct 2021 07:28:24 -0400
From:   <andrei.drimbarean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <fazilyildiran@gmail.com>,
        <andrei.drimbarean@analog.com>, <robh+dt@kernel.org>,
        <jic23@kernel.org>, <Michael.Hennerich@analog.com>,
        <lars@metafoo.de>
Subject: [PATCH 1/2] dt-bindings: add adpd188 schema
Date:   Fri, 8 Oct 2021 14:27:46 +0300
Message-ID: <20211008112747.79969-2-andrei.drimbarean@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211008112747.79969-1-andrei.drimbarean@analog.com>
References: <20211008112747.79969-1-andrei.drimbarean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: -1L1rDgwpPma3Y6g-JKj-aTTL3-djjph
X-Proofpoint-GUID: -1L1rDgwpPma3Y6g-JKj-aTTL3-djjph
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-08_03,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110080067
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Andrei Drimbarean <andrei.drimbarean@analog.com>

Signed-off-by: Andrei Drimbarean <andrei.drimbarean@analog.com>
---
 .../bindings/iio/light/adi,adpd188.yaml       | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/adi,adpd188.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/adi,adpd188.yaml b/Documentation/devicetree/bindings/iio/light/adi,adpd188.yaml
new file mode 100644
index 000000000000..3c08b0904803
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/adi,adpd188.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/adi,adpd188.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADPD188 device driver
+
+maintainers:
+  - Andrei Drimbarean <andrei.drimbarean@analog.com>
+
+description: |
+  Bindings for the Analog Devices ADPD188 device. The device support both SPI and I2C
+  interfaces. Datasheet can be found here:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/adpd188bi.pdf
+properties:
+  compatible:
+    enum:
+      - adi,adpd188
+
+  reg:
+    description: SPI chip select number or I2C slave address
+    maxItems: 1
+
+  interrupts:
+    description: IRQ line for the device or device chain
+    maxItems: 1
+
+  spi-cpol: true
+
+  spi-cpha: true
+
+  spi-max-frequency:
+    maximum: 10000000
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  status:
+    const: 'okay'
+
+  adi,no-of-devices:
+    description: Number of daisy-chained devices on an I2C bus
+      string
+    $ref: "http://devicetree.org/schemas/types.yaml#/definitions/uint8"
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      status = "okay";
+
+      adpd188@64 {
+        compatible = "adi,adpd188";
+        reg = <0x64>;
+        interrupts = <9 1>;
+        interrupt-parent = <&gpio>;
+        adi,no-of-devices = <8>;
+      };
+    };
+
+additionalProperties: false
-- 
2.25.1

