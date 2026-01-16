Return-Path: <linux-iio+bounces-27853-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4C4D32A60
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 15:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 243F5300285A
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 14:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0427392C4D;
	Fri, 16 Jan 2026 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uz1q6UJx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBB113B293;
	Fri, 16 Jan 2026 14:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768573958; cv=none; b=SN/gSEJ+UhzBchT725yDi9vliU52okCIq+K7pFspA3JCZphBqknCdwK9ZSbK61YK4F5GqmlOQvvZwSQqEDBPQOX2sbRJhs5zpiMRMXHvAxBRmY6v8PDSq36kB2BAmJTxG58J3CIKMiHQDZ7ypGy2tX8rieps3bIxWgxbybjP60k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768573958; c=relaxed/simple;
	bh=iAolrLV7aSjCNA0ezx11JkQLHIz9e59CzjWTdjR6rvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sm3cZc+W/FvfsiRLrIsL5l0RSlgU5zzQNkOk55dz/lfLB4V8+eByxYigsZF14dM4zrGVHZbVeKUHY3bVTp8YUnEnTr/4Kp23lN8u84dgSPWV9gilZ6ao9OyH4Cm3L5XMEnxgPgvqF0mmZDd2SsKuWEs1TxsvyhOI8I0a2F0ZmIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uz1q6UJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89B3DC19421;
	Fri, 16 Jan 2026 14:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768573958;
	bh=iAolrLV7aSjCNA0ezx11JkQLHIz9e59CzjWTdjR6rvE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Uz1q6UJx1e/tCmkq2bVVKSb3BVrWejyzQ3m/wuMWAth8Y40rsrpVBjjOdQ9Xr98fh
	 vKx4+k1L1F7MhC1/Hvv8CCzZcdgXTf8cVwZc4Fgjz56DHZJfR4F8UTkQHBFf2q2UVH
	 A5fUSpcKKaPzJC/PI8/pBqvgbfJr+3JqttjNDm5v7L4GkWnjloq/l9NNLwrXdvn7Lo
	 mmBt3UbEV2agwKwOv+jJk4pv1Y0dz+000gPozt/AJdE76IpgYn75kDkzcQR6DLvJ5x
	 LDbhFAhwLDyfn7UP5PsmHGqArnJkcrVqU16xXjTWC8UJLgOC2BqDqI5wLpgGxtnqmd
	 X+HJnzR/2aMQg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5B2C79FBC;
	Fri, 16 Jan 2026 14:32:38 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 16 Jan 2026 14:32:20 +0000
Subject: [PATCH v4 1/7] dt-bindings: iio: frequency: add adf41513
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-adf41513-iio-driver-v4-1-dbb7d6782217@analog.com>
References: <20260116-adf41513-iio-driver-v4-0-dbb7d6782217@analog.com>
In-Reply-To: <20260116-adf41513-iio-driver-v4-0-dbb7d6782217@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768573956; l=9129;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=QWPTp3OpLB0o766799gHTRhV4kjqgh/BctQ7wyvpQrA=;
 b=qigi1h9XmHVf5iYbg/vN1d9HkbRJATdB4c+BiC9m2DfKBRzq77CTPFVjB19pinovTT5O/06Fn
 18HWrHdWRSOAL3NZWH2O3CqJc6ys4A5lpswUYL9gVIZHOsP5a4ajtKS
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

DT-bindings for ADF41513, an ultralow noise PLL frequency synthesizer that
can be used to implement local oscillators (LOs) as high as 26.5 GHz.
Most properties are based upon an existing PLL device properties
(e.g. ADF4350).

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 .../bindings/iio/frequency/adi,adf41513.yaml       | 212 +++++++++++++++++++++
 MAINTAINERS                                        |   7 +
 2 files changed, 219 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml
new file mode 100644
index 000000000000..a797b70dc9bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml
@@ -0,0 +1,212 @@
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
+  https://www.analog.com/en/products/adf41510.html
+  https://www.analog.com/en/products/adf41513.html
+
+$ref: /schemas/spi/spi-peripheral-props.yaml#
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
+  avdd1-supply:
+    description: PFD and Up and Down Digital Driver Power Supply (3.3 V)
+
+  avdd2-supply:
+    description: RF Buffer and Prescaler Power Supply (3.3 V)
+
+  avdd3-supply:
+    description: N Divider Power Supply (3.3 V)
+
+  avdd4-supply:
+    description: R Divider and Lock Detector Power Supply (3.3 V)
+
+  avdd5-supply:
+    description: Sigma-Delta Modulator and SPI Power Supply (3.3 V)
+
+  vp-supply:
+    description: Charge Pump Power Supply (3.3 V)
+
+  enable-gpios:
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
+  adi,power-up-frequency-mhz:
+    minimum: 1000
+    maximum: 26500
+    default: 10000
+    description:
+      The PLL tunes to this frequency during the initialization sequence.
+      This property should be set to a frequency supported by the loop filter
+      and VCO used in the design. Range is 1 GHz to 26.5 GHz for ADF41513,
+      and 1 GHz to 10 GHz for ADF41510.
+
+  adi,reference-div-factor:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 32
+    default: 1
+    description:
+      Value for the reference division factor (R Counter). The driver will
+      increment R Counter as needed to achieve a PFD frequency within the
+      allowed range. High R counter values will reduce the PFD frequency, which
+      lowers the frequency resolution, and affects phase noise performance.
+      As it affects the PFD frequency, this value depends on the loop filter
+      design.
+
+  adi,reference-doubler-enable:
+    description:
+      Enables the reference doubler when deriving the PFD frequency.
+      The maximum reference frequency when the doubler is enabled is 225 MHz.
+      As it affects the PFD frequency, this value depends on the loop filter
+      design.
+    type: boolean
+
+  adi,reference-div2-enable:
+    description:
+      Enables the reference divide-by-2 function when deriving the PFD
+      frequency. As it affects the PFD frequency, this value depends on the
+      loop filter design.
+    type: boolean
+
+  adi,charge-pump-resistor-ohms:
+    minimum: 1800
+    maximum: 10000
+    default: 2700
+    description:
+      External charge pump resistor (R_SET) value in ohms. This sets the maximum
+      charge pump current along with the charge pump current setting.
+
+  adi,charge-pump-current-microamp:
+    description:
+      Charge pump current (I_CP) in microamps. The value will be rounded to the
+      nearest supported value. Range of acceptable values depends on the
+      charge pump resistor value, such that 810 mV <= I_CP * R_SET <= 12960 mV.
+      This value depends on the loop filter and the VCO design.
+
+  adi,logic-level-1v8-enable:
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
+  adi,lock-detector-count:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 64
+    description:
+      Sets the value for Lock Detector count of the PLL, which determines the
+      number of consecutive phase detector cycles that must be within the lock
+      detector window before lock is declared. Lower values increase the lock
+      detection sensitivity, while higher values provides a more stable lock
+      detection. Applications that consume the lock detect signal may require
+      different settings based on system requirements.
+    enum: [2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192]
+
+  adi,phase-resync-period-ns:
+    default: 0
+    description:
+      When this value is non-zero, enable phase resync functionality, which
+      produces a consistent output phase offset with respect to the input
+      reference. The value specifies the resync period in nanoseconds, used
+      to configure clock dividers with respect to the PFD frequency. This value
+      should be set to a value that is at least as long as the worst case lock
+      time, i.e., it depends mostly on the loop filter design.
+
+  adi,le-sync-enable:
+    description:
+      Synchronizes Load Enable (LE) transitions with the reference signal to
+      avoid asynchronous glitches in the output. This is recommended when using
+      the PLL as a frequency synthesizer, where the reference signal will always
+      be present while the device is being configured. When using the PLL as a
+      frequency tracker, where the reference signal may be absent, LE sync
+      should be left disabled.
+    type: boolean
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - avdd1-supply
+  - avdd2-supply
+  - avdd3-supply
+  - avdd4-supply
+  - avdd5-supply
+  - vp-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pll@0 {
+            compatible = "adi,adf41513";
+            reg = <0>;
+            spi-max-frequency = <25000000>;
+            clocks = <&ref_clk>;
+            avdd1-supply = <&avdd1_3v3>;
+            avdd2-supply = <&avdd2_3v3>;
+            avdd3-supply = <&avdd3_3v3>;
+            avdd4-supply = <&avdd4_3v3>;
+            avdd5-supply = <&avdd5_3v3>;
+            vp-supply = <&vp_3v3>;
+            enable-gpios = <&gpio0 10 GPIO_ACTIVE_HIGH>;
+            lock-detect-gpios = <&gpio0 11 GPIO_ACTIVE_HIGH>;
+
+            adi,power-up-frequency-mhz = <15500>;
+            adi,charge-pump-current-microamp = <3600>;
+            adi,charge-pump-resistor-ohms = <2700>;
+            adi,reference-doubler-enable;
+            adi,lock-detector-count = <64>;
+            adi,phase-resync-period-ns = <0>;
+            adi,phase-detector-polarity-positive-enable;
+            adi,le-sync-enable;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 4dd9f758a871..095af34e234e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1618,6 +1618,13 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.yaml
 F:	drivers/iio/amplifiers/ada4250.c
 
+ANALOG DEVICES INC ADF41513 DRIVER
+M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/frequency/adi,adf41513.yaml
+
 ANALOG DEVICES INC ADF4377 DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
 L:	linux-iio@vger.kernel.org

-- 
2.43.0



