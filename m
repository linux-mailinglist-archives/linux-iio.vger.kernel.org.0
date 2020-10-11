Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F91C28A86A
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 19:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388242AbgJKRKd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Oct 2020 13:10:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387984AbgJKRKd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Oct 2020 13:10:33 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B33612225F;
        Sun, 11 Oct 2020 17:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602436232;
        bh=PsLbU/RCifjhdGVYUO9hAK5V5Y+VrZgZTOklfS68Eco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wJsBQ9QBWT4rP6JepehkmijpOgJ7qg/kcMHkTr32/MhHO0tKapueOCyd4XKpv5NEJ
         GSCLKKxxs6cknm+gcPy0+rp4424l94fMox51C8XAbJO2Nn93i4rHVjO9RTQS6UJ+Wo
         o91oMRRPByTIg7lDAHZKQ1giZ5Px1aLPJQUCoZOE=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 23/29] dt-bindings:iio:dac:adi,ad5758 yaml conversion
Date:   Sun, 11 Oct 2020 18:07:43 +0100
Message-Id: <20201011170749.243680-24-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201011170749.243680-1-jic23@kernel.org>
References: <20201011170749.243680-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I have put Michael as maintainer on this one. Happy to change it to
someone else though.

One issue in here, is I cannot have an example with a negative
limit on the range.  There are very few such yaml bindings in existence
but the thermal-zones.yaml has the same problem.  If there is
any means of fixing this let me know.  For now I'm sticking to
positive range values in the example.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
---
 .../devicetree/bindings/iio/dac/ad5758.txt    |  83 -----------
 .../bindings/iio/dac/adi,ad5758.yaml          | 129 ++++++++++++++++++
 2 files changed, 129 insertions(+), 83 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/ad5758.txt b/Documentation/devicetree/bindings/iio/dac/ad5758.txt
deleted file mode 100644
index 2f607f41f9d3..000000000000
--- a/Documentation/devicetree/bindings/iio/dac/ad5758.txt
+++ /dev/null
@@ -1,83 +0,0 @@
-Analog Devices AD5758 DAC device driver
-
-Required properties for the AD5758:
-	- compatible: Must be "adi,ad5758"
-	- reg: SPI chip select number for the device
-	- spi-max-frequency: Max SPI frequency to use (< 50000000)
-	- spi-cpha: is the only mode that is supported
-
-Required properties:
-
- - adi,dc-dc-mode: Mode of operation of the dc-to-dc converter
-		   Dynamic Power Control (DPC)
-		   In this mode, the AD5758 circuitry senses the output
-		   voltage and dynamically regulates the supply voltage,
-		   VDPC+, to meet compliance requirements plus an optimized
-		   headroom voltage for the output buffer.
-
-		   Programmable Power Control (PPC)
-		   In this mode, the VDPC+ voltage is user-programmable to
-		   a fixed level that needs to accommodate the maximum output
-		   load required.
-
-		   The output of the DAC core is either converted to a
-		   current or voltage output at the VIOUT pin. Only one mode
-		   can be enabled at any one time.
-
-		   The following values are currently supported:
-			* 1: DPC current mode
-			* 2: DPC voltage mode
-			* 3: PPC current mode
-
- Depending on the selected output mode (voltage or current) one of the
- two properties must
- be present:
-
- - adi,range-microvolt: Voltage output range
-		The array of voltage output ranges must contain two fields:
-		* <0 5000000>: 0 V to 5 V voltage range
-		* <0 10000000>: 0 V to 10 V voltage range
-		* <(-5000000) 5000000>: ±5 V voltage range
-		* <(-10000000) 10000000>: ±10 V voltage range
- - adi,range-microamp: Current output range
-		The array of current output ranges must contain two fields:
-		* <0 20000>: 0 mA to 20 mA current range
-		* <0 24000>: 0 mA to 24 mA current range
-		* <4 24000>: 4 mA to 20 mA current range
-		* <(-20000) 20000>: ±20 mA current range
-		* <(-24000) 24000>: ±24 mA current range
-		* <(-1000) 22000>: −1 mA to +22 mA current range
-
-Optional properties:
-
- - reset-gpios : GPIO spec for the RESET pin. If specified, it will be
-		 asserted during driver probe.
-
- - adi,dc-dc-ilim-microamp: The dc-to-dc converter current limit
-		   The following values are currently supported [uA]:
-			* 150000
-			* 200000
-			* 250000
-			* 300000
-			* 350000
-			* 400000
-
- - adi,slew-time-us: The time it takes for the output to reach the
- full scale [uS]
-		     The supported range is between 133us up to 1023984375us
-
-AD5758 Example:
-
-	dac@0 {
-		compatible = "adi,ad5758";
-		reg = <0>;
-		spi-max-frequency = <1000000>;
-		spi-cpha;
-
-		reset-gpios = <&gpio 22 0>;
-
-		adi,dc-dc-mode = <2>;
-		adi,range-microvolt = <0 10000000>;
-		adi,dc-dc-ilim-microamp = <200000>;
-		adi,slew-time-us = <125000>;
-	};
diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
new file mode 100644
index 000000000000..626ccb6fe21e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
@@ -0,0 +1,129 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad5758.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5758 DAC
+
+maintainers:
+  - Michael Hennerich <Michael.Hennerich@analog.com>
+
+properties:
+  compatible:
+    const: adi,ad5758
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency: true
+  spi-cpha: true
+
+  adi,dc-dc-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 3]
+    description: |
+      Mode of operation of the dc-to-dc converter
+      Dynamic Power Control (DPC)
+      In this mode, the AD5758 circuitry senses the output voltage and
+      dynamically regulates the supply voltage, VDPC+, to meet compliance
+      requirements plus an optimized headroom voltage for the output buffer.
+
+      Programmable Power Control (PPC)
+      In this mode, the VDPC+ voltage is user-programmable to a fixed level
+      that needs to accommodate the maximum output load required.
+
+      The output of the DAC core is either converted to a current or
+      voltage output at the VIOUT pin. Only one mode can be enabled at
+      any one time.
+
+      The following values are currently supported:
+      * 1: DPC current mode
+      * 2: DPC voltage mode
+      * 3: PPC current mode
+
+      Depending on the selected output mode (voltage or current) one of the
+      two properties must be present:
+
+  adi,range-microvolt:
+    $ref: /schemas/types.yaml#/definitions/int32-array
+    description: |
+      Voltage output range specified as <minimum, maximum>
+    enum:
+      - [[0, 5000000]]
+      - [[0, 10000000]]
+      - [[-5000000, 5000000]]
+      - [[-10000000, 10000000]]
+
+  adi,range-microamp:
+    $ref: /schemas/types.yaml#/definitions/int32-array
+    description: |
+      Current output range specified as <minimum, maximum>
+    enum:
+      - [[0, 20000]]
+      - [[0, 24000]]
+      - [[4, 24000]]
+      - [[-20000, 20000]]
+      - [[-24000, 24000]]
+      - [[-1000, 22000]]
+
+  reset-gpios: true
+
+  adi,dc-dc-ilim-microamp:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [150000, 200000, 250000, 300000, 350000, 400000]
+    description: |
+      The dc-to-dc converter current limit.
+
+  adi,slew-time-us:
+    description: |
+      The time it takes for the output to reach the full scale [uS]
+    minimum: 133
+    maximum: 1023984375
+
+required:
+  - compatible
+  - reg
+  - spi-cpha
+  - adi,dc-dc-mode
+
+allOf:
+  - if:
+      properties:
+        adi,dc-dc-mode:
+          contains:
+            enum: [1, 3]
+    then:
+      properties:
+        adi,range-microvolt: false
+      required:
+        - adi,range-microamp
+    else:
+      properties:
+        adi,range-microamp: false
+      required:
+        - adi,range-microvolt
+
+additionalProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dac@0 {
+            compatible = "adi,ad5758";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            spi-cpha;
+
+            reset-gpios = <&gpio 22 0>;
+
+            adi,dc-dc-mode = <2>;
+            adi,range-microvolt = <0 10000000>;
+            adi,dc-dc-ilim-microamp = <200000>;
+            adi,slew-time-us = <125000>;
+        };
+    };
+...
-- 
2.28.0

