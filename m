Return-Path: <linux-iio+bounces-25914-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 798EDC3618A
	for <lists+linux-iio@lfdr.de>; Wed, 05 Nov 2025 15:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B1B4F4F44A7
	for <lists+linux-iio@lfdr.de>; Wed,  5 Nov 2025 14:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A2E32E73E;
	Wed,  5 Nov 2025 14:38:27 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5344415665C
	for <linux-iio@vger.kernel.org>; Wed,  5 Nov 2025 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353507; cv=none; b=Q5M0IQYhEz5KHU5lucbQHfqXVi4xxZdjzTc3PBElMcSShfmh3sHyE8CifFeq24+SBUQ4inkVT1iAJ/fsz8kdQaq6nlov3GN6usr7FvccMXB6245CvNTP0xe9VRD7EHPntVhR2jAGrTtZ4oNE4ZECK6jD4cvLFa2zJ1Zp9BUV7FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353507; c=relaxed/simple;
	bh=JAozV/BWaYyahkCMxTGFqzeqdas0jf1QKKAIVCCWTbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KSXNInVKhuu5+uCpL5EBMJFUxJqaPKC+VJI2MvFAQbQKzK3I11V9CfElUGEDcZxLX8BKaWtAI4zoO518MB9MIFz/EF7N8n+UUtGj4spBSRLu2nNw1fA0oC0bhfF4ucyiZ8tRBcXqKahhjfgvV9yU7t73C6F39zWR7xvT8PIUm7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vGeeO-0003od-3U; Wed, 05 Nov 2025 15:38:16 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vGeeN-007DGC-0h;
	Wed, 05 Nov 2025 15:38:15 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vGeeN-00000007aD9-0Z5K;
	Wed, 05 Nov 2025 15:38:15 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v1 1/2] bindings: iio: adc: Add bindings for TI ADS131M0x ADCs
Date: Wed,  5 Nov 2025 15:38:13 +0100
Message-ID: <20251105143814.1807444-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251105143814.1807444-1-o.rempel@pengutronix.de>
References: <20251105143814.1807444-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

Add device tree bindings documentation for the Texas Instruments
ADS131M0x analog-to-digital converters. This family includes the ADS131M02,
ADS131M03, ADS131M04, ADS131M06, and ADS131M08 variants.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .../bindings/iio/adc/ti,ads131m08.yaml        | 162 ++++++++++++++++++
 1 file changed, 162 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads131m08.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads131m08.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads131m08.yaml
new file mode 100644
index 000000000000..193ac84c41cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads131m08.yaml
@@ -0,0 +1,162 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads131m08.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments ADS131M0x 2-, 3-, 4-, 6- and 8-Channel ADCs
+
+maintainers:
+  - Oleksij Rempel <o.rempel@pengutronix.de>
+
+description: |
+  The ADS131M0x are a family of multichannel, simultaneous sampling,
+  24-bit, delta-sigma, analog-to-digital converters (ADCs) with a
+  built-in programmable gain amplifier (PGA) and internal reference.
+  Communication with the ADC chip is via SPI.
+
+  Datasheets:
+  - ADS131M08: https://www.ti.com/lit/ds/symlink/ads131m08.pdf
+  - ADS131M06: https://www.ti.com/lit/ds/symlink/ads131m06.pdf
+  - ADS131M04: https://www.ti.com/lit/ds/symlink/ads131m04.pdf
+  - ADS131M03: https://www.ti.com/lit/ds/symlink/ads131m03.pdf
+  - ADS131M02: https://www.ti.com/lit/ds/symlink/ads131m02.pdf
+
+properties:
+  compatible:
+    enum:
+      - ti,ads131m02
+      - ti,ads131m03
+      - ti,ads131m04
+      - ti,ads131m06
+      - ti,ads131m08
+
+  reg:
+    description: SPI chip select number.
+
+  clocks:
+    description:
+      Phandle to the external clock source required by the ADC's CLKIN pin.
+      The datasheet recommends specific frequencies based on the desired power
+      mode (e.g., 8.192 MHz for High-Resolution mode).
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+patternProperties:
+  "^channel@([0-7])$":
+    type: object
+    $ref: /schemas/iio/adc/adc.yaml#
+    description: |
+      Properties for a single ADC channel. The maximum valid channel number
+      depends on the specific compatible string used (e.g., 0-1 for ads131m02,
+      0-7 for ads131m08).
+
+    properties:
+      reg:
+        description: The channel index (0-7).
+        minimum: 0
+        maximum: 7 # Max channels on ADS131M08
+
+      label: true
+
+    required:
+      - reg
+
+    unevaluatedProperties: false
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,ads131m02
+    then:
+      patternProperties:
+        "^channel@[0-7]$":
+          properties:
+            reg:
+              maximum: 1
+        "^channel@([2-7])$": false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,ads131m03
+    then:
+      patternProperties:
+        "^channel@[0-7]$":
+          properties:
+            reg:
+              maximum: 2
+        "^channel@([3-7])$": false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,ads131m04
+    then:
+      patternProperties:
+        "^channel@[0-7]$":
+          properties:
+            reg:
+              maximum: 3
+        "^channel@([4-7])$": false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ti,ads131m06
+    then:
+      patternProperties:
+        "^channel@[0-7]$":
+          properties:
+            reg:
+              maximum: 5
+        "^channel@([6-7])$": false
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/stm32mp1-clks.h>
+
+    spi1 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "ti,ads131m02";
+            reg = <0>;
+            spi-max-frequency = <8000000>;
+
+            clocks = <&rcc CK_MCO2>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+                reg = <0>;
+                label = "input_voltage";
+            };
+
+            channel@1 {
+                reg = <1>;
+                label = "input_current";
+            };
+        };
+    };
-- 
2.47.3


