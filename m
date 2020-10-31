Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3053A2A195A
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgJaSPH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:15:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728332AbgJaSPG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:15:06 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6564E206DD;
        Sat, 31 Oct 2020 18:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604168105;
        bh=Dajqw5nvr2DvYCFQUKa+XCYy8A7wnG/zDAlkydD1B0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jklqEaapj5i8oOedy9tPBdkExPWW1Lnvtegbj997i+2TXkrPEekBG0PkeHiCH+Ziq
         9iulStcClJzllY4vB3MCMWqueq4+b/pPp/gFROfT7PwPI9do75LzMKgueUMH24/t5D
         MTzFb/BBvxptx8cr1vX/Dv/hI4w4l9qh0vVLaQw8=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 09/10] dt-bindings:iio:light:capella,cm3605: txt to yaml conversion.
Date:   Sat, 31 Oct 2020 18:12:41 +0000
Message-Id: <20201031181242.742301-10-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031181242.742301-1-jic23@kernel.org>
References: <20201031181242.742301-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simple conversion using the new iio-consumers.yaml binding in the
dt-schema.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 .../bindings/iio/light/capella,cm3605.yaml    | 78 +++++++++++++++++++
 .../devicetree/bindings/iio/light/cm3605.txt  | 41 ----------
 2 files changed, 78 insertions(+), 41 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/capella,cm3605.yaml b/Documentation/devicetree/bindings/iio/light/capella,cm3605.yaml
new file mode 100644
index 000000000000..001c99dbd14e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/capella,cm3605.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/capella,cm3605.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title:
+  Capella Microsystems CM3605 Ambient Light and Short Distance Proximity Sensor
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description: |
+  The CM3605 is an entirely analog part. However, it requires quite a bit of
+  software logic to interface a host operating system.
+
+  This ALS and proximity sensor was one of the very first deployed in mobile
+  handsets, notably it is used in the very first Nexus One Android phone from
+  2010.
+
+properties:
+  compatible:
+    const: capella,cm3605
+
+  aset-gpios:
+    maxItems: 1
+    description:
+      ASET line (drive low to activate the ALS, should be flagged
+      GPIO_ACTIVE_LOW)
+
+  interrupts:
+    maxItems: 1
+    description:
+      Connected to the POUT (proximity sensor out) line. The edge
+      detection must be set to IRQ_TYPE_EDGE_BOTH so as to detect
+      movements toward and away from the proximity sensor.
+
+  io-channels:
+    maxItems: 1
+    description:
+      ADC channel used for converting the voltage from AOUT to a digital
+      representation.
+
+  io-channel-names:
+    const: aout
+
+  vdd-supply: true
+
+  capella,aset-resistance-ohms:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [50000, 100000, 300000, 600000]
+    description: >
+      Sensitivity calibration resistance. Note that calibration curves
+      are only provided for specific allowed values. Default: 100 kOhms.
+
+required:
+  - compatible
+  - aset-gpios
+  - interrupts
+  - io-channels
+  - io-channel-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    light-sensor {
+        compatible = "capella,cm3605";
+        vdd-supply = <&foo_reg>;
+        aset-gpios = <&foo_gpio 1 GPIO_ACTIVE_LOW>;
+        capella,aset-resistance-ohms = <100000>;
+        interrupts = <1 IRQ_TYPE_EDGE_BOTH>;
+        io-channels = <&adc 0x01>;
+        io-channel-names = "aout";
+    };
+...
diff --git a/Documentation/devicetree/bindings/iio/light/cm3605.txt b/Documentation/devicetree/bindings/iio/light/cm3605.txt
deleted file mode 100644
index 56331a79f9ab..000000000000
--- a/Documentation/devicetree/bindings/iio/light/cm3605.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-Capella Microsystems CM3605
-Ambient Light and Short Distance Proximity Sensor
-
-The CM3605 is an entirely analog part which however require quite a bit of
-software logic to interface a host operating system.
-
-This ALS and proximity sensor was one of the very first deployed in mobile
-handsets, notably it is used in the very first Nexus One Android phone from
-2010.
-
-Required properties:
-- compatible: must be: "capella,cm3605"
-- aset-gpios: GPIO line controlling the ASET line (drive low
-  to activate the ALS, should be flagged GPIO_ACTIVE_LOW)
-- interrupts: the IRQ line (such as a GPIO) that is connected to
-  the POUT (proximity sensor out) line. The edge detection must
-  be set to IRQ_TYPE_EDGE_BOTH so as to detect movements toward
-  and away from the proximity sensor.
-- io-channels: the ADC channel used for converting the voltage from
-  AOUT to a digital representation.
-- io-channel-names: must be "aout"
-
-Optional properties:
-- vdd-supply: regulator supplying VDD power to the component.
-- capella,aset-resistance-ohms: the sensitivity calibration resistance,
-  in Ohms. Valid values are: 50000, 100000, 300000 and 600000,
-  as these are the resistance values that we are supplied with
-  calibration curves for. If not supplied, 100 kOhm will be assumed
-  but it is strongly recommended to supply this.
-
-Example:
-
-cm3605 {
-	compatible = "capella,cm3605";
-	vdd-supply = <&foo_reg>;
-	aset-gpios = <&foo_gpio 1 GPIO_ACTIVE_LOW>;
-	capella,aset-resistance-ohms = <100000>;
-	interrupts = <1 IRQ_TYPE_EDGE_BOTH>;
-	io-channels = <&adc 0x01>;
-	io-channel-names = "aout";
-};
-- 
2.28.0

