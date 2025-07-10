Return-Path: <linux-iio+bounces-21511-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2856AFFD42
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 10:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD3DA483C9A
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 08:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EDB291142;
	Thu, 10 Jul 2025 08:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqueoUGv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB6E28D8D2;
	Thu, 10 Jul 2025 08:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137883; cv=none; b=mZP/DrZbFy0ZNPUIsmd+shZOnCDixPERZsWItEceD+IYYM1f3Agg37mRFSxyk/4YkAg9nlXs0hs9E0gvUSLzny35o+XDQQAI0BffZ2kLw0SaUbKaFi1bSg5Oxutpv8rGXftbYOY9+1dpvCpQep7ISYf375XYIyvTpohncrFaw7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137883; c=relaxed/simple;
	bh=6THoRxVWmeyUkb9eFDl9Nx1C4CZk72tZZgVUuoEYz3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Js6YgJ4K1rIY4vas0NUC3bCThbo4OA5gITa8WJpEqgFzQkjyIy5Z+Dqe0ep9KHzuHEpTgAEMS93VEBRP35wBdXF5lpGYh1g4BS7jGxi9/Zj/KS9ZKK9IvPbrA08Gd8w/c7wrHap88FNQCK0RSxY4M/v9bvzE5U9OBI/4n0pO4Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqueoUGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5CFDC4CEF5;
	Thu, 10 Jul 2025 08:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752137882;
	bh=6THoRxVWmeyUkb9eFDl9Nx1C4CZk72tZZgVUuoEYz3s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jqueoUGvmw0ednAfg3Iy4kYyIDKz19PSVxbL7wFycyh03jIA3u+Qw1+gaYxwQ3+IJ
	 N9Ut0FpX8iOI8u6P+VjA1cCJWngC08icHohuV8NVcDvIHPlZOwQxP0VR9yos+2hNxR
	 9b/DVmFq2uvUVxp7PLW6VLBvMhcVoUH/iZwgsugQu/Eki8kB2Tq9Jl0yu64mGN6XHA
	 61rckd0qaVYUThGKULXoFXIlSNEnrkGTP6BkPK6CPlupfuNXmknw471l2UnD/jCrJ5
	 SrUOVxoWizyKANZBtBVnn3BZ6XTIz7TtMaU/4WmfTp5IkKjq6ru/RWfc7U910tjCOJ
	 dV3dQWIZqa1NQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B33E8C83F1A;
	Thu, 10 Jul 2025 08:58:02 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Date: Thu, 10 Jul 2025 08:57:56 +0000
Subject: [PATCH v2 1/8] dt-bindings: iio: imu: Add inv_icm45600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-add_newport_driver-v2-1-bf76d8142ef2@tdk.com>
References: <20250710-add_newport_driver-v2-0-bf76d8142ef2@tdk.com>
In-Reply-To: <20250710-add_newport_driver-v2-0-bf76d8142ef2@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Remi Buisson <remi.buisson@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752137881; l=4651;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=kn/sMAV7JFKvYcZy6R2/MG9kA2WFXmd+bAq1lHYc/Ps=;
 b=/6GH3zv6lQ1Rz8XZVzljWteqaaszyMSNlHe45SJQawXU7Y9mQhS74Z9cV7ICTAjyuZ7MQrf07
 OEJrUfem798Bj/MlnwKr7nN59tHMMd0XDWJT8bpEhUaqMql2/GPrCiB
X-Developer-Key: i=remi.buisson@tdk.com; a=ed25519;
 pk=yDVMi4C7RpXN4dififo42A7fDDt3THYzoZoNq9lUZuo=
X-Endpoint-Received: by B4 Relay for remi.buisson@tdk.com/20250411 with
 auth_id=372
X-Original-From: Remi Buisson <remi.buisson@tdk.com>
Reply-To: remi.buisson@tdk.com

From: Remi Buisson <remi.buisson@tdk.com>

Document the ICM-45600 devices devicetree bindings.

Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
---
 .../bindings/iio/imu/invensense,icm45600.yaml      | 138 +++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm45600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm45600.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..a651878791ffae8d1c8d6c8ff1e4becfc56af79f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm45600.yaml
@@ -0,0 +1,138 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/invensense,icm45600.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: InvenSense ICM-45600 Inertial Measurement Unit
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
+      - invensense,icm45606
+      - invensense,icm45608
+      - invensense,icm45634
+      - invensense,icm45686
+      - invensense,icm45687
+      - invensense,icm45688p
+      - invensense,icm45689
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
+  mount-matrix:
+    description: an optional 3x3 mounting rotation matrix
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
+            interrupts = <7 IRQ_TYPE_EDGE_RISING>;
+            vdd-supply = <&vdd>;
+            vddio-supply = <&vddio>;
+            mount-matrix = "0", "-1", "0",
+                           "1", "0", "0",
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
+            interrupts = <6 IRQ_TYPE_EDGE_RISING>;
+            vdd-supply = <&vdd>;
+            vddio-supply = <&vddio>;
+            mount-matrix = "0", "-1", "0",
+                           "1", "0", "0",
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
+        icm45606@68,46A00000084 {
+            reg = <0x68 0x46A 0x84>;
+            interrupt-parent = <&gpio1>;
+            interrupt-names = "INT1";
+            interrupts = <5 IRQ_TYPE_EDGE_RISING>;
+            vdd-supply = <&vdd>;
+            vddio-supply = <&vddio>;
+            mount-matrix = "0", "-1", "0",
+                           "1", "0", "0",
+                           "0", "0", "1";
+        };
+    };

-- 
2.34.1



