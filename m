Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A042F2CAF
	for <lists+linux-iio@lfdr.de>; Tue, 12 Jan 2021 11:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbhALKYV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Jan 2021 05:24:21 -0500
Received: from mx07-002cda01.pphosted.com ([185.132.180.122]:32136 "EHLO
        mx07-002cda01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730230AbhALKYV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Jan 2021 05:24:21 -0500
Received: from pps.filterd (m0135535.ppops.net [127.0.0.1])
        by mx07-002cda01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10C9WOcL025322;
        Tue, 12 Jan 2021 09:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avl.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=28082020; bh=CLSVKytESToWr2Hvh62edIW6FTin2sJrYNFa6V+LO90=;
 b=VofvDICM8CQXr3MTe4BnuW1P1sgXUSJ3mWVMy1UXyj41nvGkvMp2cGVMvKXbxfEcow0X
 q3Fudu5KBDFhrNtlt3D8Y+66Hf8sT5JROYQRkxi/3hIGBh1SsSe7G1gySx0fB3YGJQFq
 AUnRiUyHTvMWFlXjZaKg3lvJuKiDURqujvS27V65CX9blGgcaQwbSOIXBVKs/h+c0e8C
 qh3FYd1sjZkxhJQB+WRkWZqA6sxc1D4HuOswWprVP87bBrXKAuSlA/6eH8VNEXQfG7FS
 nTHwQAWGKC7XOZ8hxKfLyRy9ChAQxNxPn+kX+h50EWAPbg3THaIWEoeL7mHDEAeit6IN nA== 
Received: from atgrzso8133.avl01.avlcorp.lan ([192.102.17.76])
        by mx07-002cda01.pphosted.com with ESMTP id 35y5smmdtj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 09:51:32 +0000
Received: from pps.filterd (atgrzso8133.avl01.avlcorp.lan [127.0.0.1])
        by atgrzso8133.avl01.avlcorp.lan (8.16.0.42/8.16.0.42) with SMTP id 10C9XcXb031862;
        Tue, 12 Jan 2021 10:51:31 +0100
Received: from atgrzsw3760.avl01.avlcorp.lan ([10.13.100.86])
        by atgrzso8133.avl01.avlcorp.lan with ESMTP id 35y3xps7ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Jan 2021 10:51:31 +0100
Received: from atgrzsw3763.avl01.avlcorp.lan (10.37.149.16) by
 atgrzsw3760.avl01.avlcorp.lan (10.37.149.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2044.4; Tue, 12 Jan 2021 10:51:31 +0100
Received: from ATGRZWN210214.avl01.avlcorp.lan (10.12.100.12) by
 atgrzsw3763.avl01.avlcorp.lan (10.37.149.16) with Microsoft SMTP Server id
 15.1.2044.4 via Frontend Transport; Tue, 12 Jan 2021 10:51:30 +0100
From:   <tomislav.denis@avl.com>
To:     <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <tomislav.denis@avl.com>
Subject: [PATCH v3 2/2] bindings: iio: adc: Add documentation for ADS131E0x ADC driver
Date:   Tue, 12 Jan 2021 10:51:28 +0100
Message-ID: <20210112095128.7112-3-tomislav.denis@avl.com>
X-Mailer: git-send-email 2.10.1.windows.1
In-Reply-To: <20210112095128.7112-1-tomislav.denis@avl.com>
References: <20210112095128.7112-1-tomislav.denis@avl.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: f9e74532-fb7d-4806-8539-2b9574eafa9a
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-12_06:2021-01-11,2021-01-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120053
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-12_06:2021-01-11,2021-01-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120053
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Tomislav Denis <tomislav.denis@avl.com>

Add a device tree binding documentation for Texas Instruments
ADS131E0x ADC family driver.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Tomislav Denis <tomislav.denis@avl.com>
---
 .../devicetree/bindings/iio/adc/ti,ads131e08.yaml  | 181 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 182 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
new file mode 100644
index 0000000..e0670e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
@@ -0,0 +1,181 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads131e08.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments ADS131E0x 4-, 6- and 8-Channel ADCs
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
+      - ti,ads131e06
+      - ti,ads131e08
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+  spi-cpha: true
+
+  clocks:
+    description: |
+      Device tree identifier to the clock source (2.048 MHz).
+      Note: clock source is selected using CLKSEL pin.
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: adc-clk
+
+  interrupts:
+    description: |
+      IRQ line for the ADC data ready.
+    maxItems: 1
+
+  vref-supply:
+    description: |
+      Optional external voltage reference. If not supplied, internal voltage
+      reference is used.
+
+  ti,vref-internal:
+    description: |
+      Select the internal voltage reference value.
+      0: 2.4V
+      1: 4.0V
+      If this field is left empty, 2.4V is selected.
+      Note: internal voltage reference is used only if vref-supply is not supplied.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    default: 0
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - spi-cpha
+  - clocks
+  - clock-names
+  - interrupts
+
+patternProperties:
+  "^channel@([0-7])$":
+    $ref: "adc.yaml"
+    type: object
+    description: |
+      Represents the external channels which are connected to the ADC.
+
+    properties:
+      reg:
+        description: |
+          The channel number.
+          Up to 4 channels, numbered from 0 to 3 for ti,ads131e04.
+          Up to 6 channels, numbered from 0 to 5 for ti,ads131e06.
+          Up to 8 channels, numbered from 0 to 7 for ti,ads131e08.
+        items:
+          minimum: 0
+          maximum: 7
+
+      ti,gain:
+        description: |
+          The PGA gain value for the channel.
+          If this field is left empty, PGA gain 1 is used.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [1, 2, 4, 8, 12]
+        default: 1
+
+      ti,mux:
+        description: |
+          Channel input selection(muliplexer).
+          0: Normal input.
+          1: Input shorted to (VREFP + VREFN) / 2 (for offset or noise measurements).
+          3: MVDD (for supply measurement)
+          4: Temperature sensor
+          If this field is left empty, normal input is selected.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 3, 4]
+        default: 0
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      adc@0 {
+        compatible = "ti,ads131e08";
+        reg = <0>;
+        spi-max-frequency = <1000000>;
+        spi-cpha;
+        clocks = <&clk2048k>;
+        clock-names = "adc-clk";
+        interrupt-parent = <&gpio5>;
+        interrupts = <28 IRQ_TYPE_EDGE_FALLING>;
+        vref-supply = <&adc_vref>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        channel@0 {
+          reg = <0>;
+        };
+
+        channel@1 {
+          reg = <1>;
+        };
+
+        channel@2 {
+          reg = <2>;
+          ti,gain = <2>;
+        };
+
+        channel@3 {
+          reg = <3>;
+        };
+
+        channel@4 {
+          reg = <4>;
+        };
+
+        channel@5 {
+          reg = <5>;
+        };
+
+        channel@6 {
+          reg = <6>;
+        };
+
+        channel@7 {
+          reg = <7>;
+          ti,mux = <4>;
+        };
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 167aabf..f6c5e47 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17371,6 +17371,7 @@ TI ADS131E0X ADC SERIES DRIVER
 M:	Tomislav Denis <tomislav.denis@avl.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/ti,ads131e08.yaml
 F:	drivers/iio/adc/ti-ads131e08.c
 
 TI AM437X VPFE DRIVER
-- 
2.7.4

