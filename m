Return-Path: <linux-iio+bounces-26142-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A4EC47AD0
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 16:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D361894C67
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 15:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD432749C7;
	Mon, 10 Nov 2025 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfjBqVXq"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68914224AE8;
	Mon, 10 Nov 2025 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789530; cv=none; b=KiBwLQubP1XnkePV+4Jt3DMQqda15Z3cFzKeVVyhTTzZFWHV/dWdC4k2hgwOgqPE1is/Rzw93XDg/Upzw+kqiajyE4qrPbBT1t/gBzvqUWMPp314ucYCoBSuNIAF3/0NfoLhITaor8Ey0yJm1pBbXSkvWs0Zn3TzAfYkdfBJNpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789530; c=relaxed/simple;
	bh=tGxprLrftAwjCoXRJ+nMUe8IsESY4LQ1oVBr+0IAoZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UYyVBtMXT0i1N2lDSE0nS0HEAWGkED/vImyGDNC1/lA+l7+/hE8LCVY1kiEqDoEom6ftLRgk90AocMrG48PJnUM24mlncCO4u+Y+U/6L/PILBeP5brmlw1K8Y0Y69Dm2m30C37u/G4GmFpwTkmd0VlRJEklTT99SL2zNk34Cpvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfjBqVXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E083AC116D0;
	Mon, 10 Nov 2025 15:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762789530;
	bh=tGxprLrftAwjCoXRJ+nMUe8IsESY4LQ1oVBr+0IAoZY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KfjBqVXqSXm10xxchP+gqjfb96ScZCWi40kfdsNGtiHo6bnYXgaPJrbjIsGhJlPV2
	 Soto2ZMOfPsZtifQXcDO/Xqxl6VLnsImjc8/hnhzCNFdoYSKvX35UwFJa6QXFUEMVT
	 3+FVRVU7dp+oZ9w43QdUYihny72mR0uNt7b3MyL50AmMnmRE8kp10xlpANULXcDNal
	 rjnF9gRdYFv5dLjMCTCgaY66tONPfyOZeec2jaPzLNiC/JzGtPpF3Y8b1HPoWj51Pz
	 CrAQxvtNJ873s3Ux++P2YrLmJ7gB7rD4YYBSbkndI+3PXrxQ8g5GeOjg6Aj/6Ecboc
	 NQbDyjtUGogMA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5916CD1297;
	Mon, 10 Nov 2025 15:45:29 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 10 Nov 2025 15:44:45 +0000
Subject: [PATCH 2/3] dt-bindings: iio: frequency: add adf41513
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251110-adf41513-iio-driver-v1-2-2df8be0fdc6e@analog.com>
References: <20251110-adf41513-iio-driver-v1-0-2df8be0fdc6e@analog.com>
In-Reply-To: <20251110-adf41513-iio-driver-v1-0-2df8be0fdc6e@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762789528; l=10076;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=lVwojzT6WizUcRBWmB0UObJnWFpsQQtx46u9qWYqXPk=;
 b=qag8YCAvMAps567tUXFTXniKVEZnj5V2mENJlLRLZblYYhjBulcN02vGl4wTne98lGQGoZPfw
 R0RSSWRvAG/BszqaaBWExVZ58uArfTtsIRlAi+aKqmeKPJZRqu1Y0/b
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

ultralow noise PLL frequency synthesizer that can be used to
implement local oscillators (LOs) as high as 26.5 GHz

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 .../bindings/iio/frequency/adi,adf41513.yaml       | 268 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 269 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml
new file mode 100644
index 000000000000..7e1ad80d68af
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml
@@ -0,0 +1,268 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/frequency/adi,adf41513.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADF41513 PLL Frequency Synthesizer
+
+maintainers:
+  - Rodrigo Alencar <rodrigo.alencar@analog.com>
+
+description:
+  The ADF41513 is an ultralow noise frequency synthesizer that can be used to
+  implement local oscillators (LOs) as high as 26.5 GHz in the upconversion and
+  downconversion sections of wireless receivers and transmitters. The ADF41510
+  supports frequencies up to 10 GHz.
+
+  https://www.analog.com/en/products/adf41513.html
+  https://www.analog.com/en/products/adf41510.html
+
+properties:
+  compatible:
+    enum:
+      - adi,adf41510
+      - adi,adf41513
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 25000000
+
+  clocks:
+    maxItems: 1
+    description: Clock that provides the reference input frequency.
+
+  '#clock-cells':
+    const: 0
+
+  clock-output-names:
+    maxItems: 1
+
+  vcc-supply:
+    description: Power supply for the device (3.3V)
+
+  chip-enable-gpios:
+    description:
+      GPIO that controls the chip enable pin. A logic low on this pin
+      powers down the device and puts the charge pump output into
+      three-state mode.
+    maxItems: 1
+
+  lock-detect-gpios:
+    description:
+      GPIO for lock detect functionality. When configured for digital lock
+      detect, this pin will output a logic high when the PLL is locked.
+    maxItems: 1
+
+  adi,power-up-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint64
+    minimum: 1000000000
+    maximum: 26500000000
+    default: 10000000000
+    description:
+      The PLL tunes to this frequency (in Hz) on driver probe.
+      Range is 1 GHz to 26.5 GHz for ADF41513, and 1 GHz to 10 GHz for ADF41510.
+
+  adi,reference-div-factor:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 32
+    description:
+      Reference division factor (R Counter). If not specified, the driver
+      will calculate the optimal value automatically.
+
+  adi,reference-doubler-enable:
+    description:
+      Enables the reference doubler. The maximum reference frequency when
+      the doubler is enabled is 225 MHz.
+    type: boolean
+
+  adi,reference-div2-enable:
+    description:
+      Enables the reference divide-by-2 function. This provides a 50%
+      duty cycle signal to the PFD.
+    type: boolean
+
+  adi,charge-pump-current-microamp:
+    minimum: 450
+    maximum: 7200
+    default: 2400
+    description:
+      Charge pump current in microamps. The value will be rounded to the
+      nearest supported value.
+
+  adi,charge-pump-resistor-ohms:
+    minimum: 1800
+    maximum: 10000
+    default: 2700
+    description:
+      External charge pump resistor value in ohms. This sets the maximum
+      charge pump current along with the charge pump current setting.
+
+  adi,muxout-select:
+    description:
+      On chip multiplexer output selection.
+      high_z - MUXOUT Pin set to high-Z. (default)
+      muxout_high - MUXOUT Pin set to high.
+      muxout_low - MUXOUT Pin set to low.
+      f_div_rclk - MUXOUT Pin set to R divider output
+      f_div_nclk - MUXOUT Pin set to N divider output
+      lock_detect - MUXOUT Pin set to Digital lock detect
+      serial_data - MUXOUT Pin set to Serial data output
+      readback - MUXOUT Pin set to Readback mode
+      f_div_clk1 - MUXOUT Pin set to CLK1 divider output
+      f_div_rclk_2 - MUXOUT Pin set to R divider/2 output
+      f_div_nclk_2 - MUXOUT Pin set to N divider/2 output
+    enum: [high_z, muxout_high, muxout_low, f_div_rclk, f_div_nclk, lock_detect,
+           serial_data, readback, f_div_clk1, f_div_rclk_2, f_div_nclk_2]
+
+  adi,muxout-level-1v8-enable:
+    description:
+      Set MUXOUT and DLD logic levels to 1.8V. Default is 3.3V.
+    type: boolean
+
+  adi,phase-detector-polarity-positive-enable:
+    description:
+      Set phase detector polarity to positive. Default is negative.
+      Use positive polarity with non-inverting loop filter and VCO with
+      positive tuning slope, or with inverting loop filter and VCO with
+      negative tuning slope.
+    type: boolean
+
+  adi,lock-detect-precision:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 3
+    description:
+      Lock detector precision setting. Controls the sensitivity of the
+      lock detector. Lower values of precision increases the lock detector
+      window size.
+
+  adi,lock-detect-count:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 7
+    description: |
+      Lock detector count setting (3-bit value). Determines the number of
+      consecutive phase detector cycles that must be within the lock detector
+      window before lock is declared. The count grows in powers of two of the
+      programmed value:
+      - if adi,fast-lock-enable is set count = 2 * 2^value
+      - if adi,fast-lock-enable is not set count = 64 * 2^value
+
+  adi,lock-detect-bias-microamp:
+    description:
+      Lock detector bias current. Controls the lock detector window size
+      along with the lock detector precision setting. Lower bias current
+      increases the window size.
+    enum: [10, 20, 30, 40]
+
+  adi,fast-lock-enable:
+    description:
+      Enable fast lock mode. This changes the lock detector clock selection
+      for faster lock indication.
+    type: boolean
+
+  adi,phase-resync-enable:
+    description:
+      Enable phase resync functionality. This produces a consistent output
+      phase offset with respect to the input reference.
+    type: boolean
+
+  adi,12bit-clk-divider:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 4095
+    description:
+      CLK1 divider value used when adi,phase-resync-enable is set
+
+  adi,12bit-clk2-divider:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 4095
+    description:
+      CLK2 divider value used when adi,phase-resync-enable is set
+
+  adi,le-sync-enable:
+    description:
+      Synchronize the rising edge of LE on an SPI write with the falling
+      edge of the reference signal to prevent glitches.
+    type: boolean
+
+  adi,freq-resolution:
+    $ref: /schemas/types.yaml#/definitions/uint64
+    minimum: 1
+    default: 1000000
+    description:
+      Initial frequency resolution in micro-Hz (µHz) for the algorithm to achieve.
+      This influences the choice between fixed and variable modulus modes.
+      Default is 1000000 µHz (1 Hz).
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - vcc-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pll@0 {
+            compatible = "adi,adf41513";
+            reg = <0>;
+            spi-max-frequency = <10000000>;
+            clocks = <&ref_clk>;
+            vcc-supply = <&vcc_3v3>;
+            #clock-cells = <0>;
+
+            adi,power-up-frequency = /bits/ 64 <12000000000>;
+            adi,charge-pump-current-microamp = <2400>;
+            adi,phase-detector-polarity-positive-enable;
+        };
+    };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        /* Example with advanced features enabled */
+        pll_advanced@0 {
+            compatible = "adi,adf41513";
+            reg = <0>;
+            spi-max-frequency = <25000000>;
+            clocks = <&ref_clk>;
+            vcc-supply = <&vcc_3v3>;
+            chip-enable-gpios = <&gpio0 10 GPIO_ACTIVE_HIGH>;
+            lock-detect-gpios = <&gpio0 11 GPIO_ACTIVE_HIGH>;
+            #clock-cells = <0>;
+            clock-output-names = "adf41513_clk";
+
+            adi,power-up-frequency = /bits/ 64 <15500000000>;
+            adi,charge-pump-current-microamp = <3600>;
+            adi,charge-pump-resistor-ohms = <2700>;
+            adi,reference-doubler-enable;
+            adi,muxout-select = "lock_detect";
+            adi,lock-detect-precision = <1>;
+            adi,lock-detect-count = <4>;
+            adi,lock-detect-bias-microamp = <40>;
+            adi,fast-lock-enable;
+            adi,phase-resync-enable;
+            adi,12bit-clk-divider = <1>;
+            adi,12bit-clk2-divider = <200>;
+            adi,le-sync-enable;
+            adi,freq-resolution = /bits/ 64 <1000000>;
+            adi,phase-detector-polarity-positive-enable;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 8df4a0d216c8..1bbcff826238 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1606,6 +1606,7 @@ M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml
 F:	drivers/iio/frequency/adf41513.c
 
 ANALOG DEVICES INC ADF4377 DRIVER

-- 
2.43.0



