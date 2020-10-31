Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFFF2A1A11
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgJaSwZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:52:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:35918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728475AbgJaSwZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:52:25 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3699120659;
        Sat, 31 Oct 2020 18:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170343;
        bh=lFoRnEgeCn8mOtEpZtlP77+0c9x7C8iwtZqX5zeXFHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q+44F0zo9iCJMnUNVCgCQeBbdQ/xJClvM3+fHtcQRKXF13LYmvwSwMNhrKl+8EXgU
         LmNr36bWUHM4fm8bpqdFG2bSFcwJhwzNkGiZEyMP+j52gZKe+zCWcu1oJ2od80+Nc5
         RRMq5Isj91W5fB/MokBrXzH1YUP20c9tpozq7J/s=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 38/46] dt-bindings:iio:dac:ad5592r: txt to yaml format conversion.
Date:   Sat, 31 Oct 2020 18:48:46 +0000
Message-Id: <20201031184854.745828-39-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This is a more complex binding. Whilst conversion is straight forward
I am unsure if the full nature of required properties has been captured.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>
---
 .../devicetree/bindings/iio/dac/ad5592r.txt   | 155 --------------
 .../bindings/iio/dac/adi,ad5592r.yaml         | 201 ++++++++++++++++++
 2 files changed, 201 insertions(+), 155 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/ad5592r.txt b/Documentation/devicetree/bindings/iio/dac/ad5592r.txt
deleted file mode 100644
index 989f96f31c66..000000000000
--- a/Documentation/devicetree/bindings/iio/dac/ad5592r.txt
+++ /dev/null
@@ -1,155 +0,0 @@
-Analog Devices AD5592R/AD5593R DAC/ADC device driver
-
-Required properties for the AD5592R:
-	- compatible: Must be "adi,ad5592r"
-	- reg: SPI chip select number for the device
-	- spi-max-frequency: Max SPI frequency to use (< 30000000)
-	- spi-cpol: The AD5592R requires inverse clock polarity (CPOL) mode
-
-Required properties for the AD5593R:
-	- compatible: Must be "adi,ad5593r"
-	- reg: I2C address of the device
-
-Required properties for all supported chips:
-	- #address-cells: Should be 1.
-	- #size-cells: Should be 0.
-	- channel nodes:
-	  Each child node represents one channel and has the following
-	  Required properties:
-		* reg: Pin on which this channel is connected to.
-		* adi,mode: Mode or function of this channel.
-			    Macros specifying the valid values
-			    can be found in <dt-bindings/iio/adi,ad5592r.h>.
-
-			    The following values are currently supported:
-				* CH_MODE_UNUSED (the pin is unused)
-				* CH_MODE_ADC (the pin is ADC input)
-				* CH_MODE_DAC (the pin is DAC output)
-				* CH_MODE_DAC_AND_ADC (the pin is DAC output
-					but can be monitored by an ADC, since
-					there is no disadvantage this
-					this should be considered as the
-					preferred DAC mode)
-				* CH_MODE_GPIO (the pin is registered
-					with GPIOLIB)
-	 Optional properties:
-		* adi,off-state: State of this channel when unused or the
-				 device gets removed. Macros specifying the
-				 valid values can be found in
-				 <dt-bindings/iio/adi,ad5592r.h>.
-
-				* CH_OFFSTATE_PULLDOWN (the pin is pulled down)
-				* CH_OFFSTATE_OUT_LOW  (the pin is output low)
-				* CH_OFFSTATE_OUT_HIGH (the pin is output high)
-				* CH_OFFSTATE_OUT_TRISTATE (the pin is
-					tristated output)
-
-
-Optional properties:
-	- vref-supply: Phandle to the external reference voltage supply. This should
-	  only be set if there is an external reference voltage connected to the VREF
-	  pin. If the property is not set the internal 2.5V reference is used.
-	- reset-gpios : GPIO spec for the RESET pin. If specified, it will be
-	  asserted during driver probe.
-	- gpio-controller: Marks the device node as a GPIO controller.
-	- #gpio-cells: Should be 2. The first cell is the GPIO number and the second
-	  cell specifies GPIO flags, as defined in <dt-bindings/gpio/gpio.h>.
-
-AD5592R Example:
-
-	#include <dt-bindings/iio/adi,ad5592r.h>
-
-	vref: regulator-vref {
-		compatible = "regulator-fixed";
-		regulator-name = "vref-ad559x";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-	};
-
-	ad5592r@0 {
-		#size-cells = <0>;
-		#address-cells = <1>;
-		#gpio-cells = <2>;
-		compatible = "adi,ad5592r";
-		reg = <0>;
-
-		spi-max-frequency = <1000000>;
-		spi-cpol;
-
-		vref-supply = <&vref>; /* optional */
-		reset-gpios = <&gpio0 86 0>;  /* optional */
-		gpio-controller;
-
-		channel@0 {
-			reg = <0>;
-			adi,mode = <CH_MODE_DAC>;
-		};
-		channel@1 {
-			reg = <1>;
-			adi,mode = <CH_MODE_ADC>;
-		};
-		channel@2 {
-			reg = <2>;
-			adi,mode = <CH_MODE_DAC_AND_ADC>;
-		};
-		channel@3 {
-			reg = <3>;
-			adi,mode = <CH_MODE_DAC_AND_ADC>;
-			adi,off-state = <CH_OFFSTATE_PULLDOWN>;
-		};
-		channel@4 {
-			reg = <4>;
-			adi,mode = <CH_MODE_UNUSED>;
-			adi,off-state = <CH_OFFSTATE_PULLDOWN>;
-		};
-		channel@5 {
-			reg = <5>;
-			adi,mode = <CH_MODE_GPIO>;
-			adi,off-state = <CH_OFFSTATE_PULLDOWN>;
-		};
-		channel@6 {
-			reg = <6>;
-			adi,mode = <CH_MODE_GPIO>;
-			adi,off-state = <CH_OFFSTATE_PULLDOWN>;
-		};
-		channel@7 {
-			reg = <7>;
-			adi,mode = <CH_MODE_GPIO>;
-			adi,off-state = <CH_OFFSTATE_PULLDOWN>;
-		};
-	};
-
-AD5593R Example:
-
-	#include <dt-bindings/iio/adi,ad5592r.h>
-
-	ad5593r@10 {
-		#size-cells = <0>;
-		#address-cells = <1>;
-		#gpio-cells = <2>;
-		compatible = "adi,ad5593r";
-		reg = <0x10>;
-		gpio-controller;
-
-		channel@0 {
-			reg = <0>;
-			adi,mode = <CH_MODE_DAC>;
-			adi,off-state = <CH_OFFSTATE_PULLDOWN>;
-		};
-		channel@1 {
-			reg = <1>;
-			adi,mode = <CH_MODE_ADC>;
-			adi,off-state = <CH_OFFSTATE_PULLDOWN>;
-		};
-		channel@2 {
-			reg = <2>;
-			adi,mode = <CH_MODE_DAC_AND_ADC>;
-			adi,off-state = <CH_OFFSTATE_PULLDOWN>;
-		};
-		channel@6 {
-			reg = <6>;
-			adi,mode = <CH_MODE_GPIO>;
-			adi,off-state = <CH_OFFSTATE_PULLDOWN>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5592r.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5592r.yaml
new file mode 100644
index 000000000000..c49646825c37
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5592r.yaml
@@ -0,0 +1,201 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad5592r.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5592R/AD5593R DAC/ADC
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+
+properties:
+  compatible:
+    enum:
+      - adi,ad5592r
+      - adi,ad5593r
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 30000000
+
+  spi-cpol: true
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  "#io-channel-cells":
+    const: 1
+
+  vref-supply:
+    description: If not set internal 2.5V reference used.
+
+  reset-gpios:
+    maxItems: 1
+
+  gpio-controller:
+    description: Marks the device node as a GPIO controller.
+
+  "#gpio-cells":
+    const: 2
+    description:
+      The first cell is the GPIO number and the second cell specifies
+      GPIO flags, as defined in <dt-bindings/gpio/gpio.h>.
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: adi,ad5592r
+    then:
+      required:
+        - spi-cpol
+    else:
+      properties:
+        spi-cpol: false
+
+additionalProperties: false
+
+patternProperties:
+  "^(channel@)[0-7]$":
+    type: object
+    description: Child node to describe a channel
+    properties:
+      reg:
+        maxItems: 1
+
+      adi,mode:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          Mode or function of this channel.
+          Macros specifying the valid values can be found in
+          <dt-bindings/iio/adi,ad5592r.h>.
+
+          The following values are currently supported:
+          * CH_MODE_UNUSED (the pin is unused)
+          * CH_MODE_ADC (the pin is ADC input)
+          * CH_MODE_DAC (the pin is DAC output)
+          * CH_MODE_DAC_AND_ADC (the pin is DAC output but can be monitored
+            by an ADC, since there is no disadvantage this should be
+            considered as the preferred DAC mode)
+          * CH_MODE_GPIO (the pin is registered with GPIOLIB)
+
+      adi,off-state:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          State of this channel when unused or the device gets removed.
+          Macros specifying the  valid values can be found in
+          <dt-bindings/iio/adi,ad5592r.h>.
+          * CH_OFFSTATE_PULLDOWN (the pin is pulled down)
+          * CH_OFFSTATE_OUT_LOW  (the pin is output low)
+          * CH_OFFSTATE_OUT_HIGH (the pin is output high)
+          * CH_OFFSTATE_OUT_TRISTATE (the pin is tristated output)
+
+    required:
+      - reg
+      - adi,mode
+
+    additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/iio/adi,ad5592r.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        addac@0 {
+            compatible = "adi,ad5592r";
+            #size-cells = <0>;
+            #address-cells = <1>;
+            #gpio-cells = <2>;
+            reg = <0>;
+
+            spi-max-frequency = <1000000>;
+            spi-cpol;
+
+            vref-supply = <&vref>;
+            reset-gpios = <&gpio0 86 0>;
+            gpio-controller;
+
+            channel@0 {
+                reg = <0>;
+                adi,mode = <CH_MODE_DAC>;
+            };
+            channel@1 {
+                reg = <1>;
+                adi,mode = <CH_MODE_ADC>;
+            };
+            channel@2 {
+                reg = <2>;
+                adi,mode = <CH_MODE_DAC_AND_ADC>;
+            };
+            channel@3 {
+                reg = <3>;
+                adi,mode = <CH_MODE_DAC_AND_ADC>;
+                adi,off-state = <CH_OFFSTATE_PULLDOWN>;
+            };
+            channel@4 {
+                reg = <4>;
+                adi,mode = <CH_MODE_UNUSED>;
+                adi,off-state = <CH_OFFSTATE_PULLDOWN>;
+            };
+            channel@5 {
+                reg = <5>;
+                adi,mode = <CH_MODE_GPIO>;
+                adi,off-state = <CH_OFFSTATE_PULLDOWN>;
+            };
+            channel@6 {
+                reg = <6>;
+                adi,mode = <CH_MODE_GPIO>;
+                adi,off-state = <CH_OFFSTATE_PULLDOWN>;
+            };
+            channel@7 {
+                reg = <7>;
+                adi,mode = <CH_MODE_GPIO>;
+                adi,off-state = <CH_OFFSTATE_PULLDOWN>;
+            };
+        };
+        ad5593r@10 {
+            compatible = "adi,ad5593r";
+            #size-cells = <0>;
+            #address-cells = <1>;
+            #gpio-cells = <2>;
+            reg = <0x10>;
+            gpio-controller;
+
+            channel@0 {
+                reg = <0>;
+                adi,mode = <CH_MODE_DAC>;
+                adi,off-state = <CH_OFFSTATE_PULLDOWN>;
+            };
+            channel@1 {
+                reg = <1>;
+                adi,mode = <CH_MODE_ADC>;
+                adi,off-state = <CH_OFFSTATE_PULLDOWN>;
+            };
+            channel@2 {
+                reg = <2>;
+                adi,mode = <CH_MODE_DAC_AND_ADC>;
+                adi,off-state = <CH_OFFSTATE_PULLDOWN>;
+            };
+            channel@6 {
+                reg = <6>;
+                adi,mode = <CH_MODE_GPIO>;
+                adi,off-state = <CH_OFFSTATE_PULLDOWN>;
+            };
+        };
+    };
+...
-- 
2.28.0

