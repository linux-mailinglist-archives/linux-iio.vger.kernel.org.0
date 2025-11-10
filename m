Return-Path: <linux-iio+bounces-26122-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 695E1C45105
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 07:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F0A3AE11F
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 06:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9612EA158;
	Mon, 10 Nov 2025 06:14:39 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17362E9748
	for <linux-iio@vger.kernel.org>; Mon, 10 Nov 2025 06:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762755279; cv=none; b=q/a2yv/DIimuCYdpdBMW6dDebZwaXCQYyEsvU/J3vrLZcZvgQg+Y+q2n2+21kJ/i+jZAa8WBJiTy6aJ6h/h8bBgWUIo5snaLwFxM8dUsM3pb9uIZlxCIdA7GrDLhw7i9eIiMfQ0oVLfH8TNc1MrIhgRgV7+u26srIu/rhZqAWVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762755279; c=relaxed/simple;
	bh=DuiIGtY0qQwfD+vldm5Ivq6YSFje38G8KMqsRMeGqyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ak15vcB5+ZaUGhfu9omBlE+wVcoLJBFNENGtCromqgt0Q+P+MYmxuCt04VQbVTrayIEmm2RjicKP1ALL54IOCF4KBx6lIHi3wcB7w5FvU5I+lximbUs6cb/30bwDB0+ehQW4h4kXb9zM15JgJ3sjJklHMEdBT5mBDsPdnNgImH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vILAL-0002LZ-G5; Mon, 10 Nov 2025 07:14:13 +0100
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vILAK-007y74-2S;
	Mon, 10 Nov 2025 07:14:12 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1vILAK-000000032sx-2vxv;
	Mon, 10 Nov 2025 07:14:12 +0100
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
Subject: [PATCH v2 1/2] bindings: iio: adc: Add bindings for TI ADS131M0x ADCs
Date: Mon, 10 Nov 2025 07:14:08 +0100
Message-ID: <20251110061409.726028-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251110061409.726028-1-o.rempel@pengutronix.de>
References: <20251110061409.726028-1-o.rempel@pengutronix.de>
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
---
changes v2:
- Rename file to ti,ads131m02.yaml and update $id.
- Add supplies (avdd, dvdd, refin), interrupts, reset-gpios, and clock-names.
- Make avdd-supply, dvdd-supply, and clock-names required.
- Tighten channel validation logic for each device variant.
- Simplify channel description and reorder datasheet list.
- Update commit message to clarify device difference
---
 .../bindings/iio/adc/ti,ads131m02.yaml        | 220 ++++++++++++++++++
 1 file changed, 220 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads131m02.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads131m02.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads131m02.yaml
new file mode 100644
index 000000000000..ed1d3fd4d26c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads131m02.yaml
@@ -0,0 +1,220 @@
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
+  - avdd-supply
+  - dvdd-supply
+
+patternProperties:
+  "^channel@([0-7])$":
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
+      required:
+        - clock-names
+
+  - if:
+      # 32-pin devices: M06, M08
+      # These support both XTAL/CLKIN and optional REFIN.
+      properties:
+        compatible:
+          enum:
+            - ti,ads131m06
+            - ti,ads131m08
+    then:
+      properties:
+        clock-names:
+          description:
+            Indicates if a crystal oscillator (XTAL) or CMOS signal is connected
+            (CLKIN).
+          enum: [xtal, clkin]
+        refin-supply:
+          description: Optional external reference supply (REFIN).
+      required:
+        - clock-names
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
+        "^channel@([2-7])$": false
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
+        "^channel@([3-7])$": false
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
+        "^channel@([4-7])$": false
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


