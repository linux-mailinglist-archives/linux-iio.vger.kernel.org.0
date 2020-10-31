Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C052A195F
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgJaSPI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:46174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728247AbgJaSO6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:14:58 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E336F20709;
        Sat, 31 Oct 2020 18:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604168098;
        bh=uqY3t5DS/fLrjmuPBA7eur8K8fB96S7fLULj9OOiZw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0u5DT0qQ62kOs9tCaPSdEGLe20bgpq5FOJJAoFmQ0QOu3Iby7uEzwXSKqHr8RaVPk
         DDZKSS6+715OBw++hVenWzw2O8u/YmMKsOOTv4V7cQSqyu98eQd7VH27B3hp/Zr1P4
         aWvjTSl87/oddhAa5INe8hoy9Q/xTUEuROmWGX7o=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Peter Rosin <peda@axentia.se>
Subject: [PATCH 04/10] dt-bindings:iio:adc:envelope-detector: txt to yaml conversion.
Date:   Sat, 31 Oct 2020 18:12:36 +0000
Message-Id: <20201031181242.742301-5-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031181242.742301-1-jic23@kernel.org>
References: <20201031181242.742301-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Straight forward format conversion.  The example in here is fun in
that it has 2 separate provider / consumer pairs.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Peter Rosin <peda@axentia.se>
---
 .../bindings/iio/adc/envelope-detector.txt    | 54 ------------
 .../bindings/iio/adc/envelope-detector.yaml   | 87 +++++++++++++++++++
 2 files changed, 87 insertions(+), 54 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/envelope-detector.txt b/Documentation/devicetree/bindings/iio/adc/envelope-detector.txt
deleted file mode 100644
index 27544bdd4478..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/envelope-detector.txt
+++ /dev/null
@@ -1,54 +0,0 @@
-Bindings for ADC envelope detector using a DAC and a comparator
-
-The DAC is used to find the peak level of an alternating voltage input
-signal by a binary search using the output of a comparator wired to
-an interrupt pin. Like so:
-                          _
-                         | \
-    input +------>-------|+ \
-                         |   \
-           .-------.     |    }---.
-           |       |     |   /    |
-           |    dac|-->--|- /     |
-           |       |     |_/      |
-           |       |              |
-           |       |              |
-           |    irq|------<-------'
-           |       |
-           '-------'
-
-Required properties:
-- compatible: Should be "axentia,tse850-envelope-detector"
-- io-channels: Channel node of the dac to be used for comparator input.
-- io-channel-names: Should be "dac".
-- interrupt specification for one client interrupt,
-  see ../../interrupt-controller/interrupts.txt for details.
-- interrupt-names: Should be "comp".
-
-Example:
-
-	&i2c {
-		dpot: mcp4651-104@28 {
-			compatible = "microchip,mcp4651-104";
-			reg = <0x28>;
-			#io-channel-cells = <1>;
-		};
-	};
-
-	dac: dac {
-		compatible = "dpot-dac";
-		vref-supply = <&reg_3v3>;
-		io-channels = <&dpot 0>;
-		io-channel-names = "dpot";
-		#io-channel-cells = <1>;
-	};
-
-	envelope-detector {
-		compatible = "axentia,tse850-envelope-detector";
-		io-channels = <&dac 0>;
-		io-channel-names = "dac";
-
-		interrupt-parent = <&gpio>;
-		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
-		interrupt-names = "comp";
-	};
diff --git a/Documentation/devicetree/bindings/iio/adc/envelope-detector.yaml b/Documentation/devicetree/bindings/iio/adc/envelope-detector.yaml
new file mode 100644
index 000000000000..6048be936aba
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/envelope-detector.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/envelope-detector.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ADC envelope detector using a DAC and a comparator
+
+maintainers:
+  - Peter Rosin <peda@axentia.se>
+
+description: |
+  The DAC is used to find the peak level of an alternating voltage input
+  signal by a binary search using the output of a comparator wired to
+  an interrupt pin. Like so:
+                          _
+                         | \
+    input +------>-------|+ \
+                         |   \
+           .-------.     |    }---.
+           |       |     |   /    |
+           |    dac|-->--|- /     |
+           |       |     |_/      |
+           |       |              |
+           |       |              |
+           |    irq|------<-------'
+           |       |
+           '-------'
+
+properties:
+  compatible:
+    const: axentia,tse850-envelope-detector
+
+  io-channels:
+    maxItems: 1
+    description: Channel node of the dac to be used for comparator input.
+
+  io-channel-names:
+    const: dac
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    const: comp
+
+required:
+  - compatible
+  - io-channels
+  - io-channel-names
+  - interrupts
+  - interrupt-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        dpot: dpot@28 {
+            compatible = "microchip,mcp4651-104";
+            reg = <0x28>;
+            #io-channel-cells = <1>;
+        };
+    };
+
+    dac: dac {
+        compatible = "dpot-dac";
+        vref-supply = <&reg_3v3>;
+        io-channels = <&dpot 0>;
+        io-channel-names = "dpot";
+        #io-channel-cells = <1>;
+    };
+
+    envelope-detector {
+        compatible = "axentia,tse850-envelope-detector";
+        io-channels = <&dac 0>;
+        io-channel-names = "dac";
+
+        interrupt-parent = <&gpio>;
+        interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
+        interrupt-names = "comp";
+    };
+...
+
-- 
2.28.0

