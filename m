Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC45256F4A
	for <lists+linux-iio@lfdr.de>; Sun, 30 Aug 2020 18:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgH3QOh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Aug 2020 12:14:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbgH3QOf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 30 Aug 2020 12:14:35 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3CD620720;
        Sun, 30 Aug 2020 16:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598804074;
        bh=NBMiRsEkFf78zUwrlRbxXbv0EhUvpXl4LtZf4x/AEQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SX7TmiQ2t/DoGLuY/p5MJpQkxnn6h0+1ko4YXd+S9e34q1MkmynHoiKjMqo77uVLH
         T/6HkQ5Kv3UUf3xLxhokSQw4Ct1S2RTJIj9yFIICyff5WH+lpmD2zSUSlo3eOaQvZ8
         rrYXaJIHXBHwTNegKpRGp/ETDtBhNCVAXotfQzfc=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: ti,adc12138 yaml conversion.
Date:   Sun, 30 Aug 2020 17:11:53 +0100
Message-Id: <20200830161154.3201-2-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200830161154.3201-1-jic23@kernel.org>
References: <20200830161154.3201-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simple binding conversion from txt to yaml.
Only addition was #io-channel-cells to allow for potential consumers
of the channels on this device.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
---

Changes:
* Fix missing include.
* Fix typo in one of the supplies.
* Fix spacing wrt to brackets.

 .../bindings/iio/adc/ti,adc12138.yaml         | 86 +++++++++++++++++++
 .../bindings/iio/adc/ti-adc12138.txt          | 37 --------
 2 files changed, 86 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,adc12138.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc12138.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,adc12138.yaml b/Documentation/devicetree/bindings/iio/adc/ti,adc12138.yaml
new file mode 100644
index 000000000000..ec3b2edf1fb7
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,adc12138.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,adc12138.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments ADC12138 and similar self-calibrating ADCs
+
+maintainers:
+  - Akinobu Mita <akinobu.mita@gmail.com>
+
+description: |
+  13 bit ADCs with 1, 2 or 8 inputs and self calibrating circuitry to
+  correct for linearity, zero and full scale errors.
+
+properties:
+  compatible:
+    enum:
+      - ti,adc12130
+      - ti,adc12132
+      - ti,adc12138
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description: End of Conversion (EOC) interrupt
+
+  clocks:
+    maxItems: 1
+    description: Conversion clock input.
+
+  spi-max-frequency: true
+
+  vref-p-supply:
+    description: The regulator supply for positive analog voltage reference
+
+  vref-n-supply:
+    description: |
+      The regulator supply for negative analog voltage reference
+      (Note that this must not go below GND or exceed vref-p)
+      If not specified, this is assumed to be analog ground.
+
+  ti,acquisition-time:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 6, 10, 18, 34 ]
+    description: |
+      The number of conversion clock periods for the S/H's acquisition time.
+      For high source impedances, this value can be increased to 18 or 34.
+      For less ADC accuracy and/or slower CCLK frequencies this value may be
+      decreased to 6.  See section 6.0 INPUT SOURCE RESISTANCE in the
+      datasheet for details.
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - vref-p-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "ti,adc12138";
+            reg = <0>;
+            interrupts = <28 IRQ_TYPE_EDGE_RISING>;
+            interrupt-parent = <&gpio1>;
+            clocks = <&cclk>;
+            vref-p-supply = <&ldo4_reg>;
+            spi-max-frequency = <5000000>;
+            ti,acquisition-time = <6>;
+            #io-channel-cells = <1>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/adc/ti-adc12138.txt b/Documentation/devicetree/bindings/iio/adc/ti-adc12138.txt
deleted file mode 100644
index 049a1d36f013..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/ti-adc12138.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-* Texas Instruments' ADC12130/ADC12132/ADC12138
-
-Required properties:
- - compatible: Should be one of
-	* "ti,adc12130"
-	* "ti,adc12132"
-	* "ti,adc12138"
- - reg: SPI chip select number for the device
- - interrupts: Should contain interrupt for EOC (end of conversion)
- - clocks: phandle to conversion clock input
- - spi-max-frequency: Definision as per
-	Documentation/devicetree/bindings/spi/spi-bus.txt
- - vref-p-supply: The regulator supply for positive analog voltage reference
-
-Optional properties:
- - vref-n-supply: The regulator supply for negative analog voltage reference
-	(Note that this must not go below GND or exceed vref-p)
-	If not specified, this is assumed to be analog ground.
- - ti,acquisition-time: The number of conversion clock periods for the S/H's
-	acquisition time.  Should be one of 6, 10, 18, 34.  If not specified,
-	default value of 10 is used.
-	For high source impedances, this value can be increased to 18 or 34.
-	For less ADC accuracy and/or slower CCLK frequencies this value may be
-	decreased to 6.  See section 6.0 INPUT SOURCE RESISTANCE in the
-	datasheet for details.
-
-Example:
-adc@0 {
-	compatible = "ti,adc12138";
-	reg = <0>;
-	interrupts = <28 IRQ_TYPE_EDGE_RISING>;
-	interrupt-parent = <&gpio1>;
-	clocks = <&cclk>;
-	vref-p-supply = <&ldo4_reg>;
-	spi-max-frequency = <5000000>;
-	ti,acquisition-time = <6>;
-};
-- 
2.28.0

