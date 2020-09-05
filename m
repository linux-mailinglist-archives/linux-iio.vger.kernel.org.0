Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D24525E95D
	for <lists+linux-iio@lfdr.de>; Sat,  5 Sep 2020 19:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgIERcw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Sep 2020 13:32:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728473AbgIERcs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Sep 2020 13:32:48 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6D292078E;
        Sat,  5 Sep 2020 17:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599327168;
        bh=RBeBn26VqXSvtc29tYTwUVWtUqRK71pOOETdakTP+Z0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TS58A5x4T3xwdFaeBWIKcP60Y235hLXXvwtgnhMWl+0cgdR7jS3dKaO+7DdcGtMnX
         gQtDzPADQ9oH1VdBAsXNGbOtRGf2dFN+Kt/BvQKsvFRQqVgRwIvZhhZHxqoj3pssJr
         bOvUmOnuaAcQqxdWn8q3RDDuescuv2Ed3Cg4o3K4=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Stefan Popa <stefan.popa@analog.com>
Subject: [PATCH 15/20] dt-bindings:iio:adc:ad7768-1 yaml conversion
Date:   Sat,  5 Sep 2020 18:29:59 +0100
Message-Id: <20200905173004.216081-16-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200905173004.216081-1-jic23@kernel.org>
References: <20200905173004.216081-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Fairly straight conversion.  The one oddity in the original binding
is that spi-cpha and spi-cpol were not marked as required, but were
in the example.  Looking at the datasheet, there isn't any documented
flexibility in the possible SPI modes, so I have moved these to requires.
For spi-max-frequency I have gone the other way.  I absolutely agree
that it is good to specify this in the dt-binding, but it's not
strictly required.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Stefan Popa <stefan.popa@analog.com>
---
 .../bindings/iio/adc/adi,ad7768-1.txt         | 41 ---------
 .../bindings/iio/adc/adi,ad7768-1.yaml        | 89 +++++++++++++++++++
 2 files changed, 89 insertions(+), 41 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.txt b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.txt
deleted file mode 100644
index 9f5b88cf680d..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-Analog Devices AD7768-1 ADC device driver
-
-Required properties for the AD7768-1:
-
-- compatible: Must be "adi,ad7768-1"
-- reg: SPI chip select number for the device
-- spi-max-frequency: Max SPI frequency to use
-	see: Documentation/devicetree/bindings/spi/spi-bus.txt
-- clocks: phandle to the master clock (mclk)
-	see: Documentation/devicetree/bindings/clock/clock-bindings.txt
-- clock-names: Must be "mclk".
-- interrupts: IRQ line for the ADC
-	see: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
-- vref-supply: vref supply can be used as reference for conversion
-- adi,sync-in-gpios: must be the device tree identifier of the SYNC-IN pin. Enables
-	synchronization of multiple devices that require simultaneous sampling.
-	A pulse is always required if the configuration is changed in any way, for example
-	if the filter decimation rate changes. As the line is active low, it should
-	be marked GPIO_ACTIVE_LOW.
-
-Optional properties:
-
- - reset-gpios : GPIO spec for the RESET pin. If specified, it will be asserted during
-	driver probe. As the line is active low, it should be marked GPIO_ACTIVE_LOW.
-
-Example:
-
-	adc@0 {
-		compatible = "adi,ad7768-1";
-		reg = <0>;
-		spi-max-frequency = <2000000>;
-		spi-cpol;
-		spi-cpha;
-		vref-supply = <&adc_vref>;
-		interrupts = <25 IRQ_TYPE_EDGE_RISING>;
-		interrupt-parent = <&gpio>;
-		adi,sync-in-gpios = <&gpio 22 GPIO_ACTIVE_LOW>;
-		reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
-		clocks = <&ad7768_mclk>;
-		clock-names = "mclk";
-	};
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
new file mode 100644
index 000000000000..a2c559d0c947
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7768-1.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7768-1 ADC device driver
+
+maintainers:
+  - Stefan Popa <stefan.popa@analog.com>
+
+description: |
+  Datasheet at:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/ad7768-1.pdf
+
+properties:
+  compatible:
+    const: adi,ad7768-1
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: mclk
+
+  interrupts:
+    maxItems: 1
+
+  vref-supply:
+    description:
+      ADC reference voltage supply
+
+  adi,sync-in-gpios:
+    description:
+      Enables synchronization of multiple devices that require simultaneous
+      sampling. A pulse is always required if the configuration is changed
+      in any way, for example if the filter decimation rate changes.
+      As the line is active low, it should be marked GPIO_ACTIVE_LOW.
+
+  reset-gpios:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+  spi-cpol: true
+  spi-cpha : true
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - vref-supply
+  - spi-cpol
+  - spi-cpha
+  - adi,sync-in-gpios
+
+additionalProperties: false
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
+            compatible = "adi,ad7768-1";
+            reg = <0>;
+            spi-max-frequency = <2000000>;
+            spi-cpol;
+            spi-cpha;
+            vref-supply = <&adc_vref>;
+            interrupts = <25 IRQ_TYPE_EDGE_RISING>;
+            interrupt-parent = <&gpio>;
+            adi,sync-in-gpios = <&gpio 22 GPIO_ACTIVE_LOW>;
+            reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
+            clocks = <&ad7768_mclk>;
+            clock-names = "mclk";
+        };
+    };
+...
-- 
2.28.0

