Return-Path: <linux-iio+bounces-246-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5841A7F386A
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 22:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2573B21637
	for <lists+linux-iio@lfdr.de>; Tue, 21 Nov 2023 21:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF34D584F0;
	Tue, 21 Nov 2023 21:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-iio@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320BF1AC;
	Tue, 21 Nov 2023 13:36:32 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3ALIY4aj027136;
	Tue, 21 Nov 2023 16:36:19 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3uer08e1ns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Nov 2023 16:36:19 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 3ALLaHQG057106
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Nov 2023 16:36:17 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 21 Nov 2023 16:36:17 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 21 Nov 2023 16:36:16 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 21 Nov 2023 16:36:16 -0500
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.129])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 3ALLa45o020012;
	Tue, 21 Nov 2023 16:36:07 -0500
From: <marcelo.schmitt@analog.com>
To: <beniamin.bia@analog.com>, <paul.cercueil@analog.com>,
        <Michael.Hennerich@analog.com>, <lars@metafoo.de>, <jic23@kernel.org>,
        <marcelo.schmitt1@gmail.com>
CC: Marcelo Schmitt <marcelo.schmitt@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/7] dt-bindings: iio: Add binding documentation for AD7091R-8
Date: Tue, 21 Nov 2023 18:36:04 -0300
Message-ID: <566503a54feba35178c778a7929bced66ebd8870.1700595310.git.marcelo.schmitt1@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1700595310.git.marcelo.schmitt1@gmail.com>
References: <cover.1700595310.git.marcelo.schmitt1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: vz-JdBsH_myxB9kCTeCk2GGfC32oeuPb
X-Proofpoint-GUID: vz-JdBsH_myxB9kCTeCk2GGfC32oeuPb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_11,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311060001 definitions=main-2311210169

From: Marcelo Schmitt <marcelo.schmitt@analog.com>

Add device tree binding documentation for AD7091R-8.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 .../bindings/iio/adc/adi,ad7091r8.yaml        | 101 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7091r8.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7091r8.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7091r8.yaml
new file mode 100644
index 000000000000..f10b6727737f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7091r8.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7091r8.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7091R8 8-Channel 12-Bit ADC
+
+maintainers:
+  - Marcelo Schmitt <marcelo.schmitt@analog.com>
+
+description: |
+  Analog Devices AD7091R-8 8-Channel 12-Bit ADC
+  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7091R-2_7091R-4_7091R-8.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7091r2
+      - adi,ad7091r4
+      - adi,ad7091r8
+
+  reg:
+    maxItems: 1
+
+  vref-supply: true
+
+  spi-max-frequency: true
+
+  adi,conversion-start-gpios:
+    description:
+      Device tree identifier of the CONVST pin.
+      This logic input is used to initiate conversions on the analog
+      input channels.
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - adi,conversion-start-gpios
+
+patternProperties:
+  "^channel@[0-7]$":
+    $ref: "adc.yaml"
+    type: object
+    description: Represents the external channels which are connected to the ADC.
+
+    properties:
+      reg:
+        minimum: 0
+        maximum: 7
+
+    required:
+      - reg
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+  # AD7091R-2 does not have ALERT/BUSY/GPO pin
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad7091r4
+              - adi,ad7091r8
+    then:
+      properties:
+        interrupts: true
+    else:
+      properties:
+        interrupts: false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+                compatible = "adi,ad7091r8";
+                reg = <0x0>;
+                spi-max-frequency = <45454545>;
+                vref-supply = <&adc_vref>;
+                adi,conversion-start-gpios = <&gpio 25 GPIO_ACTIVE_LOW>;
+                reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
+                interrupts = <22 IRQ_TYPE_EDGE_FALLING>;
+                interrupt-parent = <&gpio>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 008f0e73bead..6e7c6c866396 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1132,6 +1132,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	http://ez.analog.com/community/linux-device-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r8.yaml
 F:	drivers/iio/adc/drivers/iio/adc/ad7091r-base.c
 F:	drivers/iio/adc/drivers/iio/adc/ad7091r-base.h
 F:	drivers/iio/adc/drivers/iio/adc/ad7091r5.c
-- 
2.42.0


