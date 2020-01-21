Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD8E8143BF5
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jan 2020 12:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgAUL00 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jan 2020 06:26:26 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:42174 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728655AbgAUL00 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jan 2020 06:26:26 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00LBBf46028942;
        Tue, 21 Jan 2020 06:26:10 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xkyta7610-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jan 2020 06:26:10 -0500
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 00LBQ8Sl010616
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 21 Jan 2020 06:26:08 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 21 Jan
 2020 03:26:06 -0800
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 21 Jan 2020 06:26:06 -0500
Received: from saturn.ad.analog.com ([10.48.65.124])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 00LBQ1e8009439;
        Tue, 21 Jan 2020 06:26:04 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ekigwana@gmail.com>, <jic23@kernel.org>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/3] dt-bindings: iio: frequency: Add docs for ADF4360 PLL
Date:   Tue, 21 Jan 2020 13:25:55 +0200
Message-ID: <20200121112556.9867-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200121112556.9867-1-alexandru.ardelean@analog.com>
References: <20200121112556.9867-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-21_03:2020-01-21,2020-01-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001210096
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Edward Kigwana <ekigwana@gmail.com>

This change adds the device-tree bindings documentation for the ADF4360
family of PLLs.

Signed-off-by: Edward Kigwana <ekigwana@gmail.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../bindings/iio/frequency/adi,adf4360.yaml   | 158 ++++++++++++++++++
 1 file changed, 158 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adi,adf4360.yaml

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf4360.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf4360.yaml
new file mode 100644
index 000000000000..95d9a49be607
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf4360.yaml
@@ -0,0 +1,158 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright 2019-2020 Edward Kigwana
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/frequency/adi,adf4360.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADF4360 PLL device driver
+
+maintainers:
+  - Lars-Peter Clausen <lars@metafoo.de>
+  - Edward Kigwana <ekigwana@gmail.com>
+
+description: |
+  Bindings for the Analog Devices ADF4360 family of clock generator phase-locked
+  loop (PLL) devices with an integrated voltage-controlled oscillator (VCO).
+  Each of the parts in the family supports a specific frequency range.
+  Datasheets can be found here:
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-0.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-1.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-2.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-3.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-4.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-5.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-6.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-7.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-8.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ADF4360-9.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,adf4360-0
+      - adi,adf4360-1
+      - adi,adf4360-2
+      - adi,adf4360-3
+      - adi,adf4360-4
+      - adi,adf4360-5
+      - adi,adf4360-6
+      - adi,adf4360-7
+      - adi,adf4360-8
+      - adi,adf4360-9
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    description: phandle to external reference clock.
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: clkin
+
+  '#clock-cells':
+    const: 0
+
+  adi,loop-filter-pfd-frequency-hz:
+    description: |
+      The phase-frequency-detector frequency that the external loop filter was
+      designed for.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    maxItems: 1
+
+  adi,loop-filter-charger-pump-current-microamp:
+    description: |
+      The charge pump current that the external loop filter was designed for.
+      The provided value is clamped to the closest enumerated value.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [310, 620, 930, 1250, 1560, 1870, 2180, 2500]
+    maxItems: 1
+
+  adi,vco-minimum-frequency-hz:
+    description: |
+      Required for ADF4360-7, ADF4360-8 and ADF4360-9. Minimum VCO frequency
+      that can be supported by the tuning range set by the external inductor.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    maxItems: 1
+
+  adi,vco-maximum-frequency-hz:
+    description: |
+      Required for ADF4360-7, ADF4360-8 and ADF4360-9. Maximum VCO frequency
+      that can be supported by the tuning range set by the external inductor.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    maxItems: 1
+
+  adi,loop-filter-inverting:
+    description: Indicates that the external loop filter is an inverting filter.
+    type: boolean
+    maxItems: 1
+
+  adi,power-up-frequency-hz:
+    description: |
+    PLL tunes to the set frequency on probe or defaults to either the minimum
+    for the part or value set using adi,vco-minimum-frequency-hz.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    maxItems: 1
+
+  adi,vdd-supply:
+    description: |
+      vdd supply is used to enable or disable chip when regulator power down
+      mode is set. Other power down modes are used to mitigate the case of a
+      shared regulator.
+    maxItems: 1
+
+  adi,enable-gpios:
+    description: |
+      Chip enable gpio is used to enable or disable chip when chip enable power
+      down mode is set.
+    maxItems: 1
+
+  adi,muxout-gpios:
+    description: |
+      MUX out gpio is used to detect chip and test pll lock state on read when
+      muxout control is set to lock detect.
+    maxItems: 1
+
+  adi,power-out-level-microamp:
+    description: |
+      Chip support setting of output power level. This property is optional.
+      If it is not provided by default 11000 uA will be set.
+    allOf:
+      - enum: [3500, 5000, 7500, 11000]
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - adi,loop-filter-charge-pump-current
+  - adi,loop-filter-pfd-frequency-hz
+
+examples:
+  - |
+    spi0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      pll@0 {
+        compatible = "adi,adf4360-7";
+        reg = <0>;
+        spi-max-frequency = <2000000>;
+        clocks = <&ref_clock>;
+        #clock-cells = <0>;
+        clock-output-names = "adf4360-7";
+
+        adi,loop-filter-charge-pump-current = <5>;
+        adi,loop-filter-pfd-frequency-hz = <2500000>;
+        adi,vco-minimum-frequency-hz = <700000000>;
+        adi,vco-maximum-frequency-hz = <840000000>;
+      };
+   };
+...
-- 
2.20.1

