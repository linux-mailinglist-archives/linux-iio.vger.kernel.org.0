Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17BC2A1960
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgJaSPH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:15:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728344AbgJaSPE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:15:04 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE5AF206E3;
        Sat, 31 Oct 2020 18:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604168104;
        bh=Za5exTD0a3RmhL7Ob2UhOE7IOWXzYlzSvz5GMsTToo8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ePGlAk5Va5+w4pv82PhGHDy2perbG3HYCP1mzkSpZbHcSdP2cjA8LvcuhE54JxOVE
         kogoU58gdzdLy8Sb6aH0Xt05PNBAqdgCv7S0rnCuFqOWwmHXbifw1JJPbtzKz4wfhS
         7XPnL7skU3t152cbcnfHDzDp2XUgYeAKX+ouGd6s=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH 08/10] dt-bindings:iio:afe:voltage-divider: txt to yaml conversion
Date:   Sat, 31 Oct 2020 18:12:40 +0000
Message-Id: <20201031181242.742301-9-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031181242.742301-1-jic23@kernel.org>
References: <20201031181242.742301-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Simple binding so straight forward conversion, though did require
adding a separate binding document for the max1027 to reflect
its abilities to provide channels to consumers.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Peter Rosin <peda@axentia.se>
---
 .../bindings/iio/afe/voltage-divider.txt      | 53 -----------
 .../bindings/iio/afe/voltage-divider.yaml     | 88 +++++++++++++++++++
 2 files changed, 88 insertions(+), 53 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/afe/voltage-divider.txt b/Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
deleted file mode 100644
index b452a8406107..000000000000
--- a/Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
+++ /dev/null
@@ -1,53 +0,0 @@
-Voltage divider
-===============
-
-When an io-channel measures the midpoint of a voltage divider, the
-interesting voltage is often the voltage over the full resistance
-of the divider. This binding describes the voltage divider in such
-a curcuit.
-
-    Vin ----.
-            |
-         .-----.
-         |  R  |
-         '-----'
-            |
-            +---- Vout
-            |
-         .-----.
-         | Rout|
-         '-----'
-            |
-           GND
-
-Required properties:
-- compatible : "voltage-divider"
-- io-channels : Channel node of a voltage io-channel measuring Vout.
-- output-ohms : Resistance Rout over which the output voltage is measured.
-	        See full-ohms.
-- full-ohms : Resistance R + Rout for the full divider. The io-channel
-	      is scaled by the Rout / (R + Rout) quotient.
-
-Example:
-The system voltage is circa 12V, but divided down with a 22/222
-voltage divider (R = 200 Ohms, Rout = 22 Ohms) and fed to an ADC.
-
-sysv {
-	compatible = "voltage-divider";
-	io-channels = <&maxadc 1>;
-
-	/* Scale the system voltage by 22/222 to fit the ADC range. */
-	output-ohms = <22>;
-	full-ohms = <222>; /* 200 + 22 */
-};
-
-&spi {
-	maxadc: adc@0 {
-		compatible = "maxim,max1027";
-		reg = <0>;
-		#io-channel-cells = <1>;
-		interrupt-parent = <&gpio5>;
-		interrupts = <15 IRQ_TYPE_EDGE_RISING>;
-		spi-max-frequency = <1000000>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
new file mode 100644
index 000000000000..fefce8c9f6dc
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/afe/voltage-divider.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/afe/voltage-divider.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Voltage divider
+
+maintainers:
+  - Peter Rosin <peda@axentia.se>
+
+description: |
+  When an io-channel measures the midpoint of a voltage divider, the
+  interesting voltage is often the voltage over the full resistance
+  of the divider. This binding describes the voltage divider in such
+  a curcuit.
+
+    Vin ----.
+            |
+         .-----.
+         |  R  |
+         '-----'
+            |
+            +---- Vout
+            |
+         .-----.
+         | Rout|
+         '-----'
+            |
+           GND
+
+
+properties:
+  compatible:
+    const: voltage-divider
+
+  io-channels:
+    maxItems: 1
+    description: |
+      Channel node of a voltage io-channel.
+
+  output-ohms:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Resistance Rout over which the output voltage is measured. See full-ohms.
+
+  full-ohms:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Resistance R + Rout for the full divider. The io-channel is scaled by
+      the Rout / (R + Rout) quotient.
+
+required:
+  - compatible
+  - io-channels
+  - output-ohms
+  - full-ohms
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    /*
+     * The system voltage is circa 12V, but divided down with a 22/222
+     * voltage divider (R = 200 Ohms, Rout = 22 Ohms) and fed to an ADC.
+     */
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        maxadc: adc@0 {
+            compatible = "maxim,max1027";
+            reg = <0>;
+            #io-channel-cells = <1>;
+            interrupt-parent = <&gpio5>;
+            interrupts = <15 IRQ_TYPE_EDGE_RISING>;
+            spi-max-frequency = <1000000>;
+        };
+    };
+    sysv {
+        compatible = "voltage-divider";
+        io-channels = <&maxadc 1>;
+
+        /* Scale the system voltage by 22/222 to fit the ADC range. */
+        output-ohms = <22>;
+        full-ohms = <222>; /* 200 + 22 */
+    };
+...
-- 
2.28.0

