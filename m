Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75AE02A1954
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgJaSPE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:15:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728338AbgJaSPD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:15:03 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42C69206D5;
        Sat, 31 Oct 2020 18:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604168102;
        bh=3JNkkk9Dl1YomxLvoKDitnSaJq06f+AYRrZkk3n4+0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QEjKOf2HcUyA6Aq9I6wetNpIMAYeqi8OoS4eauMsN4+1cxcAEKJ4hwJFM74CCh0/v
         Xf3DcQTwq3A237CjRgqDiuDWJuqt6vQjg92ZReAx2MqzOp04FH6D2JEbEiav6/7PHu
         c5cKO0SqHozFMAWLr/+T2Hw6/QNunNua1XNF9Rs8=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philippe Reynes <tremyfr@yahoo.fr>
Subject: [PATCH 07/10] dt-bindings:iio:adc:maxim,max1027: Pull out to separate binding doc.
Date:   Sat, 31 Oct 2020 18:12:39 +0000
Message-Id: <20201031181242.742301-8-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031181242.742301-1-jic23@kernel.org>
References: <20201031181242.742301-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The afe/voltage-divider.yaml example uses this device with 2 properties
not provided by trivial-devices.yaml (spi-max-frequency and #io-channel-cells)

Solve that by creating a more specific binding doc.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Philippe Reynes <tremyfr@yahoo.fr>
---
 .../bindings/iio/adc/maxim,max1027.yaml       | 64 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  | 12 ----
 2 files changed, 64 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max1027.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max1027.yaml
new file mode 100644
index 000000000000..09e853c50c76
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max1027.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/maxim,max1027.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX1027 and similar ADCs
+
+maintainers:
+  - Miquel Raynal <miquel.raynal@bootlin.com>
+  - Philippe Reynes <tremyfr@yahoo.fr>
+
+description: |
+  300ks/s SPI ADCs with temperature sensors.
+
+properties:
+  compatible:
+    enum:
+        # 10-bit 8 channels
+      - maxim,max1027
+        # 10-bit 12 channels
+      - maxim,max1029
+        # 10-bit 16 channels
+      - maxim,max1031
+         # 12-bit 8 channels
+      - maxim,max1227
+         # 12-bit 12 channels
+      - maxim,max1229
+         # 12-bit 16 channels
+      - maxim,max1231
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+       #address-cells = <1>;
+       #size-cells = <0>;
+        maxadc: adc@0 {
+            compatible = "maxim,max1027";
+            reg = <0>;
+            #io-channel-cells = <1>;
+            interrupt-parent = <&gpio5>;
+            interrupts = <15 IRQ_TYPE_EDGE_RISING>;
+            spi-max-frequency = <1000000>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index d154ea97e30d..185e09e61e16 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -108,18 +108,6 @@ properties:
           - isil,isl68137
             # 5 Bit Programmable, Pulse-Width Modulator
           - maxim,ds1050
-            # 10-bit 8 channels 300ks/s SPI ADC with temperature sensor
-          - maxim,max1027
-            # 10-bit 12 channels 300ks/s SPI ADC with temperature sensor
-          - maxim,max1029
-            # 10-bit 16 channels 300ks/s SPI ADC with temperature sensor
-          - maxim,max1031
-            # 12-bit 8 channels 300ks/s SPI ADC with temperature sensor
-          - maxim,max1227
-            # 12-bit 12 channels 300ks/s SPI ADC with temperature sensor
-          - maxim,max1229
-            # 12-bit 16 channels 300ks/s SPI ADC with temperature sensor
-          - maxim,max1231
             # Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
           - maxim,max1237
             # PECI-to-I2C translator for PECI-to-SMBus/I2C protocol conversion
-- 
2.28.0

