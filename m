Return-Path: <linux-iio+bounces-17946-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB58A85EFD
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 15:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE233B167E
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 13:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBC21C8603;
	Fri, 11 Apr 2025 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sR9ibisT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AD61A5B85;
	Fri, 11 Apr 2025 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744378122; cv=none; b=J7imlUjpexssslqGQeP/87/Y46t66dz4bm5g/t/ztbZ9fytuJQg/ckfkcV1qiM1lWME8B/eTCHkdoXsYd3Q+ag0J4okRJ1++SFKaGZuoMDnPS8YHKZjhTxvVZdCMXRAaTABA53lWocvmJUmCmD4mLyAEOpv9mgJ7MTD9x9/WWBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744378122; c=relaxed/simple;
	bh=0A5y2B3CkTHSgD4tqnDeSpLhj3pw/FCweLnBblikG5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hRCY0KqotwsG0U97/YwGbcCZG90/rS6Rr2dm40TEGd03oe/OOG/1qlT9XaiIV1G5z8Uc0ee2XWR8GUMO9vL5Vv3jdHPayxH1G0oMW1bKik6FW9BCmbXWClc0WASWZqjcF0fZWyOQXSu34FnRhebh05HFbiEEN27zdpFDrWnwvog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sR9ibisT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D91F5C4CEFA;
	Fri, 11 Apr 2025 13:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744378121;
	bh=0A5y2B3CkTHSgD4tqnDeSpLhj3pw/FCweLnBblikG5I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sR9ibisT3FuS/Isolq09sOiALGY+MTHZxhaPXIuOxeg85s1XiXPDmU4+QCPdZHEhQ
	 nX0hMUrmFxTmXzHBIBPDnSOOKsuChsIpf59RNem0u5vIotoZIrIX+1g0CpVeTK6jk3
	 g4G/yUiGk98zxRNgmdfTr4DwTrqC6jw4T3cB0F7xaHVhmfcAjv1/HBE0HGNjIO1/nd
	 cJZaFC1I/GKPlWZTT7TCZuX8HtZe5Uigl4N6Myet4gGm4X9l6Llrg6xlj41VAi2c6J
	 SO9/PKrOM9KILlz3CQckmBMw2HeSIURTl73QnWUFvcl2mi+lsduzKNSqEIWkTBUFso
	 +D5jDnnCcnscA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFCCC369AF;
	Fri, 11 Apr 2025 13:28:41 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Date: Fri, 11 Apr 2025 13:28:39 +0000
Subject: [PATCH 7/8] dt-bindings: iio: imu: Add inv_icm45600 documentation
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-add_newport_driver-v1-7-15082160b019@tdk.com>
References: <20250411-add_newport_driver-v1-0-15082160b019@tdk.com>
In-Reply-To: <20250411-add_newport_driver-v1-0-15082160b019@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Remi Buisson <remi.buisson@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744378119; l=6701;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=ppRiZsCqcoXPb0CsC4/6ztBvt4B21/TyWOUreV5Lxuw=;
 b=njVa4DZIxLfVh0DTqnRVXlaWB8Gb9eO2zaYfWZLDiyDMxoY6VxhPoRF2wHGhSO27IbNM5KgQU
 EfkveOOSsUhC2eJM4Ak0WgmAzfd1OJ2iRCd0nP+HMzibYTUyyj90s8W
X-Developer-Key: i=remi.buisson@tdk.com; a=ed25519;
 pk=yDVMi4C7RpXN4dififo42A7fDDt3THYzoZoNq9lUZuo=
X-Endpoint-Received: by B4 Relay for remi.buisson@tdk.com/20250411 with
 auth_id=372
X-Original-From: Remi Buisson <remi.buisson@tdk.com>
Reply-To: remi.buisson@tdk.com

From: Remi Buisson <remi.buisson@tdk.com>

Document the ICM-456xxx devices devicetree bindings.
Describe custom sysfs API for controlling the power modes.

Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
---
 .../ABI/testing/sysfs-bus-iio-inv_icm45600         |  37 ++++++
 .../bindings/iio/imu/invensense,icm45600.yaml      | 136 +++++++++++++++++++++
 2 files changed, 173 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-inv_icm45600 b/Documentation/ABI/testing/sysfs-bus-iio-inv_icm45600
new file mode 100644
index 0000000000000000000000000000000000000000..8d2d9b68ad9e35fe0d6c157e984afc327eab92ec
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-inv_icm45600
@@ -0,0 +1,37 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_power_mode
+KernelVersion:	6.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Accelerometer power mode. Setting this attribute will set the
+		requested power mode to use if the ODR support it. If ODR
+		support only 1 mode, power mode will be enforced.
+		Reading this attribute will return the current accelerometer
+		power mode if the sensor is on, or the requested value if the
+		sensor is off. The value between real and requested value can
+		be different for ODR supporting only 1 mode.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_accel_power_mode_available
+KernelVersion:	6.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		List of available accelerometer power modes that can be set in
+		in_accel_power_mode attribute.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_power_mode
+KernelVersion:	6.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Gyroscope power mode. Setting this attribute will set the
+		requested power mode to use if the ODR support it. If ODR
+		support only 1 mode, power mode will be enforced.
+		Reading this attribute will return the current gyroscope
+		power mode if the sensor is on, or the requested value if the
+		sensor is off. The value between real and requested value can
+		be different for ODR supporting only 1 mode.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_power_mode_available
+KernelVersion:	6.16
+Contact:	linux-iio@vger.kernel.org
+Description:
+		List of available gyroscope power modes that can be set in
+		in_anglvel_power_mode attribute.
diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm45600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm45600.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..51455f0b5cb90abdd823f154e45891ad364296e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm45600.yaml
@@ -0,0 +1,136 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/invensense,icm45600.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: InvenSense ICM-456xx Inertial Measurement Unit
+
+maintainers:
+  - Remi Buisson <remi.buisson@tdk.com>
+
+description: |
+  6-axis MotionTracking device that combines a 3-axis gyroscope and a 3-axis
+  accelerometer.
+
+  It has a configurable host interface that supports I3C, I2C and SPI serial
+  communication, features up to 8kB FIFO and 2 programmable interrupts with
+  ultra-low-power wake-on-motion support to minimize system power consumption.
+
+  Other industry-leading features include InvenSense on-chip APEX Motion
+  Processing engine for gesture recognition, activity classification, and
+  pedometer, along with programmable digital filters, and an embedded
+  temperature sensor.
+
+  https://invensense.tdk.com/wp-content/uploads/documentation/DS-000576_ICM-45605.pdf
+
+properties:
+  compatible:
+    enum:
+      - invensense,icm45605
+      - invensense,icm45686
+      - invensense,icm45688p
+      - invensense,icm45608
+      - invensense,icm45634
+      - invensense,icm45689
+      - invensense,icm45606
+      - invensense,icm45687
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      enum:
+        - INT1
+        - INT2
+    description: Choose chip interrupt pin to be used as interrupt input.
+
+  drive-open-drain:
+    type: boolean
+
+  vdd-supply:
+    description: Regulator that provides power to the sensor
+
+  vddio-supply:
+    description: Regulator that provides power to the bus
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        icm45605@68 {
+            compatible = "invensense,icm45605";
+            reg = <0x68>;
+            interrupt-parent = <&gpio2>;
+            interrupt-names = "INT1";
+            interrupts = <7 IRQ_TYPE_EDGE_RAISING>;
+            vdd-supply = <&vdd>;
+            vddio-supply = <&vddio>;
+            mount-matrix = "1", "0", "0",
+                           "0", "1", "0",
+                           "0", "0", "1";
+        };
+    };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        icm45605@0 {
+            compatible = "invensense,icm45605";
+            reg = <0>;
+            spi-max-frequency = <24000000>;
+            interrupt-parent = <&gpio1>;
+            interrupt-names = "INT1";
+            interrupts = <6 IRQ_TYPE_EDGE_RAISING>;
+            vdd-supply = <&vdd>;
+            vddio-supply = <&vddio>;
+            mount-matrix = "1", "0", "0",
+                           "0", "1", "0",
+                           "0", "0", "1";
+        };
+    };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i3c {
+        #address-cells = <3>;
+        #size-cells = <0>;
+
+        icm45600@68,46A00000011 {
+            compatible = "invensense,icm45600";
+            reg = <0x68 0x46A 0x84>;
+            interrupt-parent = <&gpio1>;
+            interrupt-names = "INT1";
+            interrupts = <5 IRQ_TYPE_EDGE_RISING>;
+            vdd-supply = <&vdd>;
+            vddio-supply = <&vddio>;
+            mount-matrix = "1", "0", "0",
+                           "0", "1", "0",
+                           "0", "0", "1";
+        };
+    };

-- 
2.34.1



