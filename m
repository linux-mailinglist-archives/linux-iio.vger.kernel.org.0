Return-Path: <linux-iio+bounces-26290-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DB617C69E94
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 15:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id ED1A42BB8C
	for <lists+linux-iio@lfdr.de>; Tue, 18 Nov 2025 14:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05A235A956;
	Tue, 18 Nov 2025 14:18:30 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D80A358D0D
	for <linux-iio@vger.kernel.org>; Tue, 18 Nov 2025 14:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475510; cv=none; b=kKnFv/UeGFiOweGtE6Je0L853ruYaTEFICdm39LXLxNCoFTWRvU2mnOwbZAj+/YFqdFPMEd2bUIs2fJuyue/PcnGSCvcG4y3lXFMRDHyQkkDAzEyWhIT1pJkmcEjHcODcIGnIKf3RwEAWhmMwEHa95xsf8lCYlsf5aeCemOXT6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475510; c=relaxed/simple;
	bh=pcxDN9ij9nGGiYPl7/WyvlJ1vm+7GJ5D1LmyOAHTE6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grPTGx1T7hV1WiB25ZQyJ4WA88qNP4wyqVgJ+wgUoibW+2QjYtC9SxB1rUcprWJmNpsi1jyz1ZQgND2xlBI4mrumIUgyx+Phj68D4zDeLgsGR0+bv3MDXmGASp8/3GaUk/x9yCLYcgm8T0xwMGuv6s+dWeMO9QjDhScxHaH1W9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vLMXG-0000ef-Mr; Tue, 18 Nov 2025 15:18:22 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vLMXG-0015yH-0T;
	Tue, 18 Nov 2025 15:18:22 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vLMXG-00000003o3o-0IeA;
	Tue, 18 Nov 2025 15:18:22 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Conor Dooley <conor.dooley@microchip.com>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v4 1/2] bindings: iio: adc: Add bindings for TI ADS131M0x ADCs
Date: Tue, 18 Nov 2025 15:18:20 +0100
Message-ID: <20251118141821.907364-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251118141821.907364-1-o.rempel@pengutronix.de>
References: <20251118141821.907364-1-o.rempel@pengutronix.de>
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

These variants differ primarily in the number of supported channels
(2, 3, 4, 6, and 8, respectively), which requires separate compatible
strings to validate the channel nodes.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
changes v4:
- Move clock-names and refin-supply to top-level properties
- Update clock-names description to explicitly note XTAL support is limited to
  M06/M08
- Simplify conditional schema logic by removing redundant M06/M08 block
changes v3:
- Make channel@ regex patterns consistent
changes v2:
- Rename file to ti,ads131m02.yaml and update $id.
- Add supplies (avdd, dvdd, refin), interrupts, reset-gpios, and clock-names.
- Make avdd-supply, dvdd-supply, and clock-names required.
- Tighten channel validation logic for each device variant.
- Simplify channel description and reorder datasheet list.
- Update commit message to clarify device difference
---
 .../bindings/iio/adc/ti,ads131m02.yaml        | 208 ++++++++++++++++++
 1 file changed, 208 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads131m02.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads131m02.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads131m02.yaml
new file mode 100644
index 000000000000..5d52bb7dd5d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads131m02.yaml
@@ -0,0 +1,208 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads131m02.yaml#
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
+  - ADS131M02: https://www.ti.com/lit/ds/symlink/ads131m02.pdf
+  - ADS131M03: https://www.ti.com/lit/ds/symlink/ads131m03.pdf
+  - ADS131M04: https://www.ti.com/lit/ds/symlink/ads131m04.pdf
+  - ADS131M06: https://www.ti.com/lit/ds/symlink/ads131m06.pdf
+  - ADS131M08: https://www.ti.com/lit/ds/symlink/ads131m08.pdf
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
+  avdd-supply:
+    description: Analog power supply (AVDD).
+
+  dvdd-supply:
+    description: Digital power supply (DVDD).
+
+  interrupts:
+    description: DRDY (Data Ready) output signal.
+    maxItems: 1
+
+  reset-gpios:
+    description: Optional RESET signal.
+    maxItems: 1
+
+  clock-names:
+    description:
+      Indicates if a crystal oscillator (XTAL) or CMOS signal is connected
+      (CLKIN). Note that XTAL mode is only supported on ADS131M06 and ADS131M08.
+    enum: [xtal, clkin]
+
+  refin-supply:
+    description: Optional external reference supply (REFIN).
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
+  - clock-names
+  - avdd-supply
+  - dvdd-supply
+
+patternProperties:
+  "^channel@[0-7]$":
+    type: object
+    $ref: /schemas/iio/adc/adc.yaml#
+    description: Properties for a single ADC channel.
+
+    properties:
+      reg:
+        description: The channel index (0-7).
+        minimum: 0
+        maximum: 7  # Max channels on ADS131M08
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
+      # 20-pin devices: M02, M03, M04
+      # These do not support XTAL or REFIN.
+      properties:
+        compatible:
+          enum:
+            - ti,ads131m02
+            - ti,ads131m03
+            - ti,ads131m04
+    then:
+      properties:
+        clock-names:
+          const: clkin
+        refin-supply: false
+
+  - if:
+      # ADS131M02: 2 channels max (0-1)
+      properties:
+        compatible:
+          contains:
+            const: ti,ads131m02
+    then:
+      patternProperties:
+        "^channel@[0-1]$":
+          properties:
+            reg:
+              maximum: 1
+        "^channel@[2-7]$": false
+
+  - if:
+      # ADS131M03: 3 channels max (0-2)
+      properties:
+        compatible:
+          contains:
+            const: ti,ads131m03
+    then:
+      patternProperties:
+        "^channel@[0-2]$":
+          properties:
+            reg:
+              maximum: 2
+        "^channel@[3-7]$": false
+
+  - if:
+      # ADS131M04: 4 channels max (0-3)
+      properties:
+        compatible:
+          contains:
+            const: ti,ads131m04
+    then:
+      patternProperties:
+        "^channel@[0-3]$":
+          properties:
+            reg:
+              maximum: 3
+        "^channel@[4-7]$": false
+
+  - if:
+      # ADS131M06: 6 channels max (0-5)
+      properties:
+        compatible:
+          contains:
+            const: ti,ads131m06
+    then:
+      patternProperties:
+        "^channel@[0-5]$":
+          properties:
+            reg:
+              maximum: 5
+        "^channel@[6-7]$": false
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
+            clock-names = "clkin";
+
+            avdd-supply = <&vdd_ana>;
+            dvdd-supply = <&vdd_dig>;
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


