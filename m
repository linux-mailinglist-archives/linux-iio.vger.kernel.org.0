Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738E22A19D6
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgJaSvo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:51:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728399AbgJaSvo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:51:44 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C05020731;
        Sat, 31 Oct 2020 18:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170303;
        bh=vIemXMQMymDLIT1z/e12ErAzM2pvezHbH0Eu/XLXaeM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qas9zPA9MuPk5kGxPeZ5s6yBYHik9kvY3GW+oirPyCWOx9oEqeXPaAxyYGWxRmNMA
         9SQEtK9ecUBbLqW4jt/Fqd7U4P35pAfaV8PY5KJGTDu2wDLqREjsOhH490FhSyKYGu
         bjV2LWTfFVI3idiFrkb7frkDcLLNHSndjMr+NpKY=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 11/46] dt-bindings:iio:imu:adi,adis16480: txt to yaml conversion
Date:   Sat, 31 Oct 2020 18:48:19 +0000
Message-Id: <20201031184854.745828-12-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Alexandru is currently listed as maintainer on basis of last person
to touch the binding.

Whilst the driver only uses one interrupt, the hardware can route events
to one and dataready signal to the other so we should allow for either
1 or 2 interrupts.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 .../bindings/iio/imu/adi,adis16480.txt        |  86 ------------
 .../bindings/iio/imu/adi,adis16480.yaml       | 130 ++++++++++++++++++
 2 files changed, 130 insertions(+), 86 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt
deleted file mode 100644
index cd903a1d880d..000000000000
--- a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.txt
+++ /dev/null
@@ -1,86 +0,0 @@
-
-Analog Devices ADIS16480 and similar IMUs
-
-Required properties for the ADIS16480:
-
-- compatible: Must be one of
-	* "adi,adis16375"
-	* "adi,adis16480"
-	* "adi,adis16485"
-	* "adi,adis16488"
-	* "adi,adis16490"
-	* "adi,adis16495-1"
-	* "adi,adis16495-2"
-	* "adi,adis16495-3"
-	* "adi,adis16497-1"
-	* "adi,adis16497-2"
-	* "adi,adis16497-3"
-- reg: SPI chip select number for the device
-- spi-max-frequency: Max SPI frequency to use
-	see: Documentation/devicetree/bindings/spi/spi-bus.txt
-- spi-cpha: See Documentation/devicetree/bindings/spi/spi-bus.txt
-- spi-cpol: See Documentation/devicetree/bindings/spi/spi-bus.txt
-- interrupts: interrupt mapping for IRQ, accepted values are:
-	* IRQF_TRIGGER_RISING
-	* IRQF_TRIGGER_FALLING
-
-Optional properties:
-
-- interrupt-names: Data ready line selection. Valid values are:
-	* DIO1
-	* DIO2
-	* DIO3
-	* DIO4
-	If this field is left empty, DIO1 is assigned as default data ready
-	signal.
-- reset-gpios: must be the device tree identifier of the RESET pin. As the line
-	is active low, it should be marked GPIO_ACTIVE_LOW.
-- clocks: phandle to the external clock. Should be set according to
-	"clock-names".
-	If this field is left empty together with the "clock-names" field, then
-	the internal clock is used.
-- clock-names: The name of the external clock to be used. Valid values are:
-	* sync: In sync mode, the internal clock is disabled and the frequency
-		of the external clock signal establishes therate of data
-		collection and processing. See Fig 14 and 15 in the datasheet.
-		The clock-frequency must be:
-		* 3000 to 4500 Hz for adis1649x devices.
-		* 700 to 2400 Hz for adis1648x devices.
-	* pps: In Pulse Per Second (PPS) Mode, the rate of data collection and
-	       production is equal to the product of the external clock
-	       frequency and the scale factor in the SYNC_SCALE register, see
-	       Table 154 in the datasheet.
-	       The clock-frequency must be:
-	       * 1 to 128 Hz for adis1649x devices.
-	       * This mode is not supported by adis1648x devices.
-	If this field is left empty together with the "clocks" field, then the
-	internal clock is used.
-- adi,ext-clk-pin: The DIOx line to be used as an external clock input.
-	Valid values are:
-	* DIO1
-	* DIO2
-	* DIO3
-	* DIO4
-	Each DIOx pin supports only one function at a time (data ready line
-	selection or external clock input). When a single pin has two
-	two assignments, the enable bit for the lower priority function
-	automatically resets to zero (disabling the lower priority function).
-	Data ready has highest priority.
-	If this field is left empty, DIO2 is assigned as default external clock
-	input pin.
-
-Example:
-
-	imu@0 {
-		compatible = "adi,adis16495-1";
-		reg = <0>;
-		spi-max-frequency = <3200000>;
-		spi-cpol;
-		spi-cpha;
-		interrupts = <25 IRQF_TRIGGER_FALLING>;
-		interrupt-parent = <&gpio>;
-		interrupt-names = "DIO2";
-		clocks = <&adis16495_sync>;
-		clock-names = "sync";
-		adi,ext-clk-pin = "DIO1";
-	};
diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
new file mode 100644
index 000000000000..5dbe24be9925
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16480.yaml
@@ -0,0 +1,130 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/adi,adis16480.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADIS16480 and similar IMUs
+
+maintainers:
+  - Alexandru Ardelean <alexandru.ardelean@analog.com>
+
+properties:
+  compatible:
+    enum:
+      - adi,adis16375
+      - adi,adis16480
+      - adi,adis16485
+      - adi,adis16488
+      - adi,adis16490
+      - adi,adis16495-1
+      - adi,adis16495-2
+      - adi,adis16495-3
+      - adi,adis16497-1
+      - adi,adis16497-2
+      - adi,adis16497-3
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+    description: |
+      Accepted interrupt types are:
+      * IRQ_TYPE_EDGE_RISING
+      * IRQ_TYPE_EDGE_FALLING
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 2
+    description:
+      Default if not supplied is DIO1.
+    items:
+      enum:
+        - DIO1
+        - DIO2
+        - DIO3
+        - DIO4
+
+  spi-max-frequency: true
+
+  spi-cpha: true
+  spi-cpol: true
+
+  reset-gpios:
+    maxItems: 1
+    description: Connected to RESET pin which is active low.
+
+  clocks:
+    maxItems: 1
+    description: If not provided, then the internal clock is used.
+
+  clock-names:
+    description: |
+      sync: In sync mode, the internal clock is disabled and the frequency
+            of the external clock signal establishes therate of data
+            collection and processing. See Fig 14 and 15 in the datasheet.
+            The clock-frequency must be:
+            * 3000 to 4500 Hz for adis1649x devices.
+            * 700 to 2400 Hz for adis1648x devices.
+      pps:  In Pulse Per Second (PPS) Mode, the rate of data collection and
+            production is equal to the product of the external clock
+            frequency and the scale factor in the SYNC_SCALE register, see
+            Table 154 in the datasheet.
+            The clock-frequency must be:
+            * 1 to 128 Hz for adis1649x devices.
+            * This mode is not supported by adis1648x devices.
+    enum:
+      - sync
+      - pps
+
+  adi,ext-clk-pin:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: |
+      The DIOx line to be used as an external clock input.
+      Each DIOx pin supports only one function at a time (data ready line
+      selection or external clock input). When a single pin has two
+      two assignments, the enable bit for the lower priority function
+      automatically resets to zero (disabling the lower priority function).
+      Data ready has highest priority.
+      If not provided then DIO2 is assigned as default external clock
+      input pin.
+    enum:
+      - DIO1
+      - DIO2
+      - DIO3
+      - DIO4
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - spi-cpha
+  - spi-cpol
+  - spi-max-frequency
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        imu@0 {
+            compatible = "adi,adis16495-1";
+            reg = <0>;
+            spi-max-frequency = <3200000>;
+            spi-cpol;
+            spi-cpha;
+            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-parent = <&gpio>;
+            interrupt-names = "DIO2";
+            clocks = <&adis16495_sync>;
+            clock-names = "sync";
+            adi,ext-clk-pin = "DIO1";
+        };
+    };
+...
-- 
2.28.0

