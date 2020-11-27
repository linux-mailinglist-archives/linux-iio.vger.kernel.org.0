Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03F62C7578
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388056AbgK1VtU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:20 -0500
Received: from mx07-002cda01.pphosted.com ([185.132.180.122]:43802 "EHLO
        mx07-002cda01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730766AbgK0TyQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Nov 2020 14:54:16 -0500
Received: from pps.filterd (m0135535.ppops.net [127.0.0.1])
        by mx07-002cda01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0ARJaVpI013592;
        Fri, 27 Nov 2020 19:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avl.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=28082020; bh=HrcK9cAlhl6KmtTaGNuiOIq/3IzBWDZpwwsU1qRUUeE=;
 b=F+XUEabEBAZsBb7tGvWaDcYcIF35bCvviHr6svTJsOA+NlYs8QfYdu4Nuz++4faJrUkZ
 iRx1LagyraEMgNz95mwOACR34grWCa3y3m4k+U/vZoK3rgkGp6/TTPsU5sP/5BS+fm6o
 QJGcFgu6KDaOm7kjowB5c4ot8t6nf9SYYPY1hOvPMNHNUvI7BxWrKO7/eXwaIWPYxZIn
 m9YPiHM5p0xw4GpKusWHm5W2a2T+KLtkjm0yMnejdcZTGa1CxOVBpJBglUB1uIwYIE1T
 toJYbooD00sCIH95jzluhoFDRO9huXfsqri+lvrnIB2o4+TjE4DA072/o187m0rky0UM 5Q== 
Received: from atgrzso2833.avl01.avlcorp.lan ([192.102.17.76])
        by mx07-002cda01.pphosted.com with ESMTP id 34xv3g47cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Nov 2020 19:42:42 +0000
Received: from pps.filterd (atgrzso2833.avl01.avlcorp.lan [127.0.0.1])
        by atgrzso2833.avl01.avlcorp.lan (8.16.0.42/8.16.0.42) with SMTP id 0ARJg7hj002461;
        Fri, 27 Nov 2020 20:42:41 +0100
Received: from atgrzsw3765.avl01.avlcorp.lan ([10.13.100.86])
        by atgrzso2833.avl01.avlcorp.lan with ESMTP id 34xufsavhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Nov 2020 20:42:41 +0100
Received: from atgrzsw3762.avl01.avlcorp.lan (10.37.149.15) by
 atgrzsw3765.avl01.avlcorp.lan (10.37.149.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2044.4; Fri, 27 Nov 2020 20:42:41 +0100
Received: from ATGRZWN210214.avl01.avlcorp.lan (10.12.100.12) by
 atgrzsw3762.avl01.avlcorp.lan (10.37.149.15) with Microsoft SMTP Server id
 15.1.2044.4 via Frontend Transport; Fri, 27 Nov 2020 20:42:41 +0100
From:   <tomislav.denis@avl.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <tomislav.denis@avl.com>
Subject: [PATCH 2/2] bindings: iio: adc: Add documentation for ADS131E0x ADC driver
Date:   Fri, 27 Nov 2020 20:42:40 +0100
Message-ID: <20201127194240.15060-3-tomislav.denis@avl.com>
X-Mailer: git-send-email 2.10.1.windows.1
In-Reply-To: <20201127194240.15060-1-tomislav.denis@avl.com>
References: <20201127194240.15060-1-tomislav.denis@avl.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: f9e74532-fb7d-4806-8539-2b9574eafa9a
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-27_11:2020-11-26,2020-11-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=923 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011270116
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-27_11:2020-11-26,2020-11-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=966 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011270116
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Tomislav Denis <tomislav.denis@avl.com>

Add a device tree binding documentation for Texas Instruments
ADS131E0x ADC family driver.

Signed-off-by: Tomislav Denis <tomislav.denis@avl.com>
---
 .../devicetree/bindings/iio/adc/ti,ads131e08.yaml  | 145 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 146 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
new file mode 100644
index 0000000..92da193
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
@@ -0,0 +1,145 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads131e08.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments ADS131E0x 4-, 6-, and 8-Channel ADCs
+
+maintainers:
+  - Tomislav Denis <tomislav.denis@avl.com>
+
+description: |
+  The ADS131E0x are a family of multichannel, simultaneous sampling,
+  24-bit, delta-sigma, analog-to-digital converters (ADCs) with a
+  built-in programmable gain amplifier (PGA), internal reference
+  and an onboard oscillator.
+  The communication with ADC chip is via the SPI bus (mode 1).
+
+  https://www.ti.com/lit/ds/symlink/ads131e08.pdf
+
+properties:
+  compatible:
+    enum:
+      - ti,ads131e04
+      - ti,ads131e08
+
+  reg:
+    description: |
+      SPI chip select number
+    maxItems: 1
+
+  spi-cpha: true
+
+  clocks:
+    description: |
+      Device tree identifier to the clock source (2.048 MHz)
+      Note: clock source is selected using CLKSEL pin
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: adc-clk
+
+  interrupts:
+    description: |
+      IRQ line for the ADC data ready
+    maxItems: 1
+
+  vref-supply:
+    description: |
+      Optional external voltage reference. Has to be supplied, if
+      ti,vref-sel equals 2
+
+  ti,vref-sel:
+    description: |
+      Select the voltage reference source
+      Valid values are:
+      0: Internal reference 2.4V
+      1: Internal reference 4V
+      2: External reference source (vref-supply is required)
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2]
+    default: 0
+
+  ti,datarate:
+    description: |
+      ADC data rate in kSPS
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 8, 16, 32, 64]
+    default: 1
+
+  ti,gain:
+    description: |
+      The gain value for the PGA function
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 4, 8, 12]
+    default: 1
+
+  ti,adc-channels:
+    description: |
+      List of single-ended channels muxed for this ADC
+      - 4 channels, numbered from 0 to 3 for ti,ads131e04
+      - 8 channels, numbered from 0 to 7 for ti,ads131e08
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+required:
+  - compatible
+  - reg
+  - spi-cpha
+  - clocks
+  - clock-names
+  - interrupts
+  - ti,adc-channels
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,ads131e04
+
+  - then:
+      properties:
+        ti,adc-channels:
+          minItems: 1
+          maxItems: 4
+          items:
+            minimum: 0
+            maximum: 3
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,ads131e08
+
+  - then:
+      properties:
+        ti,adc-channels:
+          minItems: 1
+          maxItems: 8
+          items:
+            minimum: 0
+            maximum: 7
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spidev@0 {
+      compatible = "ti,ads131e08";
+      reg = <0>;
+      spi-max-frequency = <1000000>;
+      spi-cpha;
+      clocks = <&clk2048k>;
+      clock-names = "adc-clk";
+      interrupt-parent = <&gpio5>;
+      interrupts = <28 IRQ_TYPE_EDGE_FALLING>;
+      vref-supply = <&vref_reg>;
+      ti,vref-sel = <2>;
+      ti,datarate = <1>;
+      ti,gain = <1>;
+      ti,adc-channels = <0 1 2 3 4 5 6 7>;
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 28bc5f9..0c351c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17224,6 +17224,7 @@ TI ADS131E0X ADC SERIES DRIVER
 M:	Tomislav Denis <tomislav.denis@avl.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
 F:	drivers/iio/adc/ti-ads131e08.c
 
 TI AM437X VPFE DRIVER
-- 
2.7.4

