Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A922A1A25
	for <lists+linux-iio@lfdr.de>; Sat, 31 Oct 2020 19:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgJaSwi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 31 Oct 2020 14:52:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728509AbgJaSwe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 14:52:34 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D7F520659;
        Sat, 31 Oct 2020 18:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604170353;
        bh=XwPqLcNJtMME21zPbSKPcpiAuMe1PlO5Q8RRyezbGlM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hR6lZo54IjW9aM5+Ew7FZBgkTYeTt35o5QPtcE5nnDIRmXLD1smGq5K3Ftj3vI7vb
         rdhV3qAy7E+xQwPUo+coz+H5/48kKn92oGMjWQ3z4rN5pJk2Sc15wyzHw4aMNfkNYH
         va3C8iMfERUDq81dmFUU5Mc7nHS/oU3ZigyJ8kEA=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 45/46] dt-bindings:iio:frequency:adi,adf4350: txt to yaml format conversion.
Date:   Sat, 31 Oct 2020 18:48:53 +0000
Message-Id: <20201031184854.745828-46-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031184854.745828-1-jic23@kernel.org>
References: <20201031184854.745828-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This is a large but fairly simple binding.
It may well be possible to constrain some of the properties more than
currently done, but that would involve diving into datasheets for the
supported parts.  Hence for this initial conversion just use the
information that was in the txt file.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>
---
 .../bindings/iio/frequency/adf4350.txt        |  86 --------
 .../bindings/iio/frequency/adi,adf4350.yaml   | 190 ++++++++++++++++++
 2 files changed, 190 insertions(+), 86 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4350.txt b/Documentation/devicetree/bindings/iio/frequency/adf4350.txt
deleted file mode 100644
index f8c181d81d2d..000000000000
--- a/Documentation/devicetree/bindings/iio/frequency/adf4350.txt
+++ /dev/null
@@ -1,86 +0,0 @@
-Analog Devices ADF4350/ADF4351 device driver
-
-Required properties:
-	- compatible: Should be one of
-		* "adi,adf4350": When using the ADF4350 device
-		* "adi,adf4351": When using the ADF4351 device
-	- reg: SPI chip select numbert for the device
-	- spi-max-frequency: Max SPI frequency to use (< 20000000)
-	- clocks: From common clock binding. Clock is phandle to clock for
-		ADF435x Reference Clock (CLKIN).
-
-Optional properties:
-	- gpios:	 GPIO Lock detect - If set with a valid phandle and GPIO number,
-			pll lock state is tested upon read.
-	- adi,channel-spacing: Channel spacing in Hz (influences MODULUS).
-	- adi,power-up-frequency:	If set in Hz the PLL tunes to
-			the desired frequency on probe.
-	- adi,reference-div-factor: If set the driver skips dynamic calculation
-			and uses this default value instead.
-	- adi,reference-doubler-enable: Enables reference doubler.
-	- adi,reference-div2-enable: Enables reference divider.
-	- adi,phase-detector-polarity-positive-enable: Enables positive phase
-			detector polarity. Default = negative.
-	- adi,lock-detect-precision-6ns-enable: Enables 6ns lock detect precision.
-			Default = 10ns.
-	- adi,lock-detect-function-integer-n-enable: Enables lock detect
-			for integer-N mode. Default = factional-N mode.
-	- adi,charge-pump-current: Charge pump current in mA.
-			Default = 2500mA.
-	- adi,muxout-select: On chip multiplexer output selection.
-			Valid values for the multiplexer output are:
-			0: Three-State Output (default)
-			1: DVDD
-			2: DGND
-			3: R-Counter output
-			4: N-Divider output
-			5: Analog lock detect
-			6: Digital lock detect
-	- adi,low-spur-mode-enable: Enables low spur mode.
-			Default = Low noise mode.
-	- adi,cycle-slip-reduction-enable: Enables cycle slip reduction.
-	- adi,charge-cancellation-enable: Enabled charge pump
-			charge cancellation for integer-N modes.
-	- adi,anti-backlash-3ns-enable: Enables 3ns antibacklash pulse width
-			 for integer-N modes.
-	- adi,band-select-clock-mode-high-enable: Enables faster band
-			selection logic.
-	- adi,12bit-clk-divider: Clock divider value used when
-			adi,12bit-clkdiv-mode != 0
-	- adi,clk-divider-mode:
-			Valid values for the clkdiv mode are:
-			0: Clock divider off (default)
-			1: Fast lock enable
-			2: Phase resync enable
-	- adi,aux-output-enable: Enables auxiliary RF output.
-	- adi,aux-output-fundamental-enable: Selects fundamental VCO output on
-			the auxiliary RF output. Default = Output of RF dividers.
-	- adi,mute-till-lock-enable: Enables Mute-Till-Lock-Detect function.
-	- adi,output-power: Output power selection.
-			Valid values for the power mode are:
-			0: -4dBm (default)
-			1: -1dBm
-			2: +2dBm
-			3: +5dBm
-	- adi,aux-output-power: Auxiliary output power selection.
-			Valid values for the power mode are:
-			0: -4dBm (default)
-			1: -1dBm
-			2: +2dBm
-			3: +5dBm
-
-
-Example:
-		lo_pll0_rx_adf4351: adf4351-rx-lpc@4 {
-			compatible = "adi,adf4351";
-			reg = <4>;
-			spi-max-frequency = <10000000>;
-			clocks = <&clk0_ad9523 9>;
-			clock-names = "clkin";
-			adi,channel-spacing = <10000>;
-			adi,power-up-frequency = <2400000000>;
-			adi,phase-detector-polarity-positive-enable;
-			adi,charge-pump-current = <2500>;
-			adi,output-power = <3>;
-			adi,mute-till-lock-enable;
-		};
diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf4350.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf4350.yaml
new file mode 100644
index 000000000000..d7f20b8518e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf4350.yaml
@@ -0,0 +1,190 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/frequency/adi,adf4350.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices ADF4350/ADF4351 wideband synthesizer
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+
+properties:
+  compatible:
+    enum:
+      - adi,adf4350
+      - adi,adf4351
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 20000000
+
+  clocks:
+    maxItems: 1
+    description: Clock to provide CLKIN reference clock signal.
+
+  clock-names:
+    const: clkin
+
+  gpios:
+    maxItems: 1
+    description: Lock detect GPIO.
+
+  adi,channel-spacing:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Channel spacing in Hz (influences MODULUS).
+
+  adi,power-up-frequency:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      If set the PLL tunes to this frequency (in Hz) on driver probe.
+
+  adi,reference-div-factor:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      If set the driver skips dynamic calculation and uses this default
+      value instead.
+
+  adi,reference-doubler-enable:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Enables reference doubler.
+
+  adi,reference-div2-enable:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Enables reference divider.
+
+  adi,phase-detector-polarity-positive-enable:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Enables positive phase detector polarity. Default negative.
+
+  adi,lock-detect-precision-6ns-enable:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Enables 6ns lock detect precision. Default = 10ns.
+
+  adi,lock-detect-function-integer-n-enable:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Enables lock detect for integer-N mode. Default = factional-N mode.
+
+  adi,charge-pump-current:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Charge pump current in mA. Default = 2500mA.
+
+  adi,muxout-select:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 6
+    description: |
+      On chip multiplexer output selection.
+      Valid values for the multiplexer output are:
+      0: Three-State Output (default)
+      1: DVDD
+      2: DGND
+      3: R-Counter output
+      4: N-Divider output
+      5: Analog lock detect
+      6: Digital lock detect
+
+  adi,low-spur-mode-enable:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Enables low spur mode. Default = Low noise mode.
+
+  adi,cycle-slip-reduction-enable:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Enables cycle slip reduction.
+
+  adi,charge-cancellation-enable:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Enabled charge pump charge cancellation for integer-N modes.
+
+  adi,anti-backlash-3ns-enable:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Enables 3ns antibacklash pulse width for integer-N modes.
+
+  adi,band-select-clock-mode-high-enable:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Enables faster band selection logic.
+
+  adi,12bit-clk-divider:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Clock divider value used when adi,12bit-clkdiv-mode != 0
+
+  adi,clk-divider-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2]
+    description: |
+      Valid values for the clkdiv mode are:
+      0: Clock divider off (default)
+      1: Fast lock enable
+      2: Phase resync enable
+
+  adi,aux-output-enable:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Enables auxiliary RF output.
+
+  adi,aux-output-fundamental-enable:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      Selects fundamental VCO output on the auxiliary RF output.
+      Default = Output of RF dividers.
+
+  adi,mute-till-lock-enable:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Enables Mute-Till-Lock-Detect function.
+
+  adi,output-power:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+    description: |
+      Output power selection.
+      Valid values for the power mode are:
+      0: -4dBm (default)
+      1: -1dBm
+      2: +2dBm
+      3: +5dBm
+
+  adi,aux-output-power:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+    description: |
+      Auxiliary output power selection.
+      Valid values for the power mode are:
+      0: -4dBm (default)
+      1: -1dBm
+      2: +2dBm
+      3: +5dBm
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pll@4 {
+            compatible = "adi,adf4351";
+            reg = <4>;
+            spi-max-frequency = <10000000>;
+            clocks = <&clk0_ad9523 9>;
+            clock-names = "clkin";
+            adi,channel-spacing = <10000>;
+            adi,power-up-frequency = <2400000000>;
+            adi,phase-detector-polarity-positive-enable;
+            adi,charge-pump-current = <2500>;
+            adi,output-power = <3>;
+            adi,mute-till-lock-enable;
+        };
+    };
+...
-- 
2.28.0

