Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0117D16C121
	for <lists+linux-iio@lfdr.de>; Tue, 25 Feb 2020 13:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbgBYMlb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Feb 2020 07:41:31 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:41408 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729773AbgBYMla (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Feb 2020 07:41:30 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01PCX1ED022375;
        Tue, 25 Feb 2020 07:41:12 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 2yb23aghvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Feb 2020 07:41:12 -0500
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 01PCfBGW016750
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 25 Feb 2020 07:41:11 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 25 Feb
 2020 07:41:10 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 25 Feb 2020 07:41:10 -0500
Received: from nsa.sphairon.box ([10.44.3.59])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 01PCev8e005013;
        Tue, 25 Feb 2020 07:41:07 -0500
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 5/5] dt-bindings: iio: Add adis16475 documentation
Date:   Tue, 25 Feb 2020 13:41:52 +0100
Message-ID: <20200225124152.270914-6-nuno.sa@analog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200225124152.270914-1-nuno.sa@analog.com>
References: <20200225124152.270914-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-25_03:2020-02-21,2020-02-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002250100
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Document the ADIS16475 device devicetree bindings.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 .../bindings/iio/imu/adi,adis16475.yaml       | 130 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 131 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
new file mode 100644
index 000000000000..c0f2146e000c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
@@ -0,0 +1,130 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/adi,adis16475.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADIS16475 and similar IMUs
+
+maintainers:
+  - Nuno Sá <nuno.sa@analog.com>
+
+description: |
+  Analog Devices ADIS16475 and similar IMUs
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ADIS16475.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,adis16475-1
+      - adi,adis16475-2
+      - adi,adis16475-3
+      - adi,adis16477-1
+      - adi,adis16477-2
+      - adi,adis16477-3
+      - adi,adis16470
+      - adi,adis16465-1
+      - adi,adis16465-2
+      - adi,adis16465-3
+      - adi,adis16467-1
+      - adi,adis16467-2
+      - adi,adis16467-3
+      - adi,adis16500
+      - adi,adis16505-1
+      - adi,adis16505-2
+      - adi,adis16505-3
+      - adi,adis16507-1
+      - adi,adis16507-2
+      - adi,adis16507-3
+
+  reg:
+    maxItems: 1
+
+  spi-cpha: true
+
+  spi-cpol: true
+
+  spi-max-frequency:
+    maximum: 2000000
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    oneOf:
+      - const: sync
+      - const: direct-sync
+      - const: pulse-sync
+      - const: scaled-sync
+
+  reset-gpios:
+    description:
+      Must be the device tree identifier of the RESET pin. If specified,
+      it will be asserted during driver probe. As the line is active low,
+      it should be marked GPIO_ACTIVE_LOW.
+    maxItems: 1
+
+  adi,scaled-output-hz:
+    description:
+      This property must be present if the clock mode is scaled-sync through
+      clock-names property. In this mode, the input clock can have a range
+      of 1Hz to 128HZ which must be scaled to originate an allowable sample
+      rate. This property specifies that rate.
+    minimum: 1900
+    maximum: 2100
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - spi-cpha
+  - spi-cpol
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - adi,adis16500
+          - adi,adis16505-1
+          - adi,adis16505-2
+          - adi,adis16505-3
+          - adi,adis16507-1
+          - adi,adis16507-2
+          - adi,adis16507-3
+
+then:
+  properties:
+    clock-names:
+      oneOf:
+        - const: sync
+        - const: direct-sync
+        - const: scaled-sync
+
+    adi,burst32-enable:
+      description:
+        Enable burst32 mode. In this mode, a burst reading contains calibrated
+        gyroscope and accelerometer data in 32-bit format.
+      type: boolean
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            adis16475: adis16475-3@0 {
+                    compatible = "adi,adis16475-3";
+                    reg = <0>;
+                    spi-cpha;
+                    spi-cpol;
+                    spi-max-frequency = <2000000>;
+                    interrupts = <4 IRQ_TYPE_EDGE_RISING>;
+                    interrupt-parent = <&gpio>;
+            };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index f11262f1f3bb..f8ccc92ab378 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1015,6 +1015,7 @@ W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/imu/adis16475.c
 F:	Documentation/ABI/testing/sysfs-bus-iio-imu-adis16475
+F:	Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
 
 ANALOG DEVICES INC ADM1177 DRIVER
 M:	Beniamin Bia <beniamin.bia@analog.com>
-- 
2.25.1

