Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E381D6C81
	for <lists+linux-iio@lfdr.de>; Sun, 17 May 2020 21:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgEQTt2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 May 2020 15:49:28 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:52015 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgEQTt1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 May 2020 15:49:27 -0400
X-Originating-IP: 195.189.32.242
Received: from pc.localdomain (unknown [195.189.32.242])
        (Authenticated sender: contact@artur-rojek.eu)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id F08B71BF204;
        Sun, 17 May 2020 19:49:22 +0000 (UTC)
From:   Artur Rojek <contact@artur-rojek.eu>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v7 1/7] dt-bindings: iio/adc: Convert ingenic-adc docs to YAML.
Date:   Sun, 17 May 2020 21:48:58 +0200
Message-Id: <20200517194904.34758-1-contact@artur-rojek.eu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Convert the textual documentation of Device Tree bindings for the
Ingenic JZ47xx SoCs ADC controller to YAML.

The `interrupts` property is now explicitly listed and marked as
required. While missing from the previous textual documentation, this
property has been used with all the boards which probe this driver.

Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
Tested-by: Paul Cercueil <paul@crapouillou.net>
---

 Changes:

 v6: new patch

 v7: - specify `maxItems: 1` for single entry properties
     - get rid of redundant descriptions of said properties

 .../bindings/iio/adc/ingenic,adc.txt          | 49 -------------
 .../bindings/iio/adc/ingenic,adc.yaml         | 71 +++++++++++++++++++
 2 files changed, 71 insertions(+), 49 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
deleted file mode 100644
index cd9048cf9dcf..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
+++ /dev/null
@@ -1,49 +0,0 @@
-* Ingenic JZ47xx ADC controller IIO bindings
-
-Required properties:
-
-- compatible: Should be one of:
-  * ingenic,jz4725b-adc
-  * ingenic,jz4740-adc
-  * ingenic,jz4770-adc
-- reg: ADC controller registers location and length.
-- clocks: phandle to the SoC's ADC clock.
-- clock-names: Must be set to "adc".
-- #io-channel-cells: Must be set to <1> to indicate channels are selected
-  by index.
-
-ADC clients must use the format described in iio-bindings.txt, giving
-a phandle and IIO specifier pair ("io-channels") to the ADC controller.
-
-Example:
-
-#include <dt-bindings/iio/adc/ingenic,adc.h>
-
-adc: adc@10070000 {
-	compatible = "ingenic,jz4740-adc";
-	#io-channel-cells = <1>;
-
-	reg = <0x10070000 0x30>;
-
-	clocks = <&cgu JZ4740_CLK_ADC>;
-	clock-names = "adc";
-
-	interrupt-parent = <&intc>;
-	interrupts = <18>;
-};
-
-adc-keys {
-	...
-	compatible = "adc-keys";
-	io-channels = <&adc INGENIC_ADC_AUX>;
-	io-channel-names = "buttons";
-	...
-};
-
-battery {
-	...
-	compatible = "ingenic,jz4740-battery";
-	io-channels = <&adc INGENIC_ADC_BATTERY>;
-	io-channel-names = "battery";
-	...
-};
diff --git a/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
new file mode 100644
index 000000000000..9f414dbdae86
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019-2020 Artur Rojek
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/iio/adc/ingenic,adc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Ingenic JZ47xx ADC controller IIO bindings
+
+maintainers:
+  - Artur Rojek <contact@artur-rojek.eu>
+
+description: >
+  Industrial I/O subsystem bindings for ADC controller found in
+  Ingenic JZ47xx SoCs.
+
+  ADC clients must use the format described in iio-bindings.txt, giving
+  a phandle and IIO specifier pair ("io-channels") to the ADC controller.
+
+properties:
+  compatible:
+    enum:
+      - ingenic,jz4725b-adc
+      - ingenic,jz4740-adc
+      - ingenic,jz4770-adc
+
+  '#io-channel-cells':
+    const: 1
+    description:
+      Must be set to <1> to indicate channels are selected by index.
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: adc
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - '#io-channel-cells'
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/jz4740-cgu.h>
+    #include <dt-bindings/iio/adc/ingenic,adc.h>
+
+    adc@10070000 {
+            compatible = "ingenic,jz4740-adc";
+            #io-channel-cells = <1>;
+
+            reg = <0x10070000 0x30>;
+
+            clocks = <&cgu JZ4740_CLK_ADC>;
+            clock-names = "adc";
+
+            interrupt-parent = <&intc>;
+            interrupts = <18>;
+    };
-- 
2.26.2

