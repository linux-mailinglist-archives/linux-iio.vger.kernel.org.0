Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C947318DED9
	for <lists+linux-iio@lfdr.de>; Sat, 21 Mar 2020 09:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgCUIyD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Mar 2020 04:54:03 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:20670 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728012AbgCUIyB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Mar 2020 04:54:01 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02L8rEhf009239;
        Sat, 21 Mar 2020 04:53:58 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yw4ec1stk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 21 Mar 2020 04:53:57 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 02L8ruRh007360
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sat, 21 Mar 2020 04:53:56 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Sat, 21 Mar
 2020 04:53:55 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Sat, 21 Mar 2020 04:53:55 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 02L8rdeo008553;
        Sat, 21 Mar 2020 04:53:53 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <jic23@kernel.org>, <robh+dt@kernel.org>, <Laszlo.Nagy@analog.com>,
        <Andrei.Grozav@analog.com>, <Michael.Hennerich@analog.com>,
        <Istvan.Csomortani@analog.com>, <Adrian.Costina@analog.com>,
        <Dragos.Bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v11 6/8] dt-bindings: iio: adc: add bindings doc for AXI ADC driver
Date:   Sat, 21 Mar 2020 10:53:13 +0200
Message-ID: <20200321085315.11030-7-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200321085315.11030-1-alexandru.ardelean@analog.com>
References: <20200321085315.11030-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-21_02:2020-03-20,2020-03-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 suspectscore=0 impostorscore=0 spamscore=0
 mlxscore=0 bulkscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003210051
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This change adds the bindings documentation for the AXI ADC driver.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../bindings/iio/adc/adi,axi-adc.yaml         | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
new file mode 100644
index 000000000000..0924b2b4972b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,axi-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AXI ADC IP core
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+  - Alexandru Ardelean <alexandru.ardelean@analog.com>
+
+description: |
+  Analog Devices Generic AXI ADC IP core for interfacing an ADC device
+  with a high speed serial (JESD204B/C) or source synchronous parallel
+  interface (LVDS/CMOS).
+  Usually, some other interface type (i.e SPI) is used as a control
+  interface for the actual ADC, while this IP core will interface
+  to the data-lines of the ADC and handle the streaming of data into
+  memory via DMA.
+
+  https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
+
+properties:
+  compatible:
+    enum:
+      - adi,axi-adc-10.0.a
+
+  reg:
+    maxItems: 1
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    items:
+      - const: rx
+
+  adi,adc-dev:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      A reference to a the actual ADC to which this FPGA ADC interfaces to.
+
+required:
+  - compatible
+  - dmas
+  - reg
+  - adi,adc-dev
+
+additionalProperties: false
+
+examples:
+  - |
+    axi-adc@44a00000 {
+          compatible = "adi,axi-adc-10.0.a";
+          reg = <0x44a00000 0x10000>;
+          dmas = <&rx_dma 0>;
+          dma-names = "rx";
+
+          adi,adc-dev = <&spi_adc>;
+    };
+...
-- 
2.17.1

