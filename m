Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 828F319F891
	for <lists+linux-iio@lfdr.de>; Mon,  6 Apr 2020 17:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgDFPJ1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 6 Apr 2020 11:09:27 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:32506 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728783AbgDFPJ1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Apr 2020 11:09:27 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 036F4ZtG030411;
        Mon, 6 Apr 2020 11:09:09 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 306m367g8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Apr 2020 11:09:09 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 036F97RB014020
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 6 Apr 2020 11:09:07 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 6 Apr 2020 08:09:06 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 6 Apr 2020 08:09:05 -0700
Received: from NSA-L01.ad.analog.com (nsa-l01.ad.analog.com [10.32.224.203])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 036F8oIk002847;
        Mon, 6 Apr 2020 11:09:03 -0400
From:   =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
To:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.Ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH v4 6/6] dt-bindings: iio: Add adis16475 documentation
Date:   Mon, 6 Apr 2020 17:08:46 +0200
Message-ID: <20200406150846.878-7-nuno.sa@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200406150846.878-1-nuno.sa@analog.com>
References: <20200406150846.878-1-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-06_08:2020-04-06,2020-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004060124
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Document the ADIS16475 device devicetree bindings

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
Changes in v2:
 * Remove burst32 property;
 * Rename clk-mode to adi,sync-mode;
 * Remove clock-names;
 * Add conditionals to state that clocks is only needed depending on adi,sync-mode property.

Changes in v3:
 * Make use of 'allOf' in conditionals.

Changes in v4:
 * Nothing changed.

 .../bindings/iio/imu/adi,adis16475.yaml       | 137 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 138 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
new file mode 100644
index 000000000000..98baecb4b98a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
@@ -0,0 +1,137 @@
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
+  reset-gpios:
+    description:
+      Must be the device tree identifier of the RESET pin. If specified,
+      it will be asserted during driver probe. As the line is active low,
+      it should be marked GPIO_ACTIVE_LOW.
+    maxItems: 1
+
+  adi,sync-mode:
+    description:
+      Configures the device SYNC pin. The following modes are supported
+      0 - output_sync
+      1 - direct_sync
+      2 - scaled_sync
+      3 - pulse_sync
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 3
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
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,adis16500
+              - adi,adis16505-1
+              - adi,adis16505-2
+              - adi,adis16505-3
+              - adi,adis16507-1
+              - adi,adis16507-2
+              - adi,adis16507-3
+
+    then:
+      properties:
+        adi,sync-mode:
+          minimum: 0
+          maximum: 2
+
+  - if:
+      properties:
+        adi,sync-mode:
+          enum: [1, 2, 3]
+
+    then:
+      dependencies:
+        adi,sync-mode: [ clocks ]
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
index a2ff8322c184..0828302accd8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1015,6 +1015,7 @@ L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/imu/adis16475.c
+F:	Documentation/devicetree/bindings/iio/imu/adi,adis16475.yaml
 
 ANALOG DEVICES INC ADM1177 DRIVER
 M:	Beniamin Bia <beniamin.bia@analog.com>
-- 
2.17.1

