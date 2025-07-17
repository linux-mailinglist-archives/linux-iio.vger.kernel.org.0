Return-Path: <linux-iio+bounces-21738-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59324B08E1D
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 15:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 403B63ACE48
	for <lists+linux-iio@lfdr.de>; Thu, 17 Jul 2025 13:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3692B2E5435;
	Thu, 17 Jul 2025 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOOd0ljf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96BE2063E7;
	Thu, 17 Jul 2025 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752758765; cv=none; b=qWXpE7tpawbupXotMXy2VSjXOCO1NNt5xsTbR4YFFTGLA7fXGwgTrEHvFibUMjGJNUHfwQJp+RCkJGiLSWG7HI0EQhoGW2m4/HeKcC5tQEYt6wmAhM8Do2R7Oh6CES2Wofu6I4oF1dhnZgZnBgW4W7lUFQlrpYryACKl2M3Cc8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752758765; c=relaxed/simple;
	bh=Fl8H+oj0osT+K1fBWkJc81TgNpphdRz2K2nB4HUVi1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j21snAmJaQNVZMd8LpIANLKkhEuUwiVN6OIt5k33+TyHl3Vj5dQ4DOl/tZ69EVAj4Raqs0o3ZuzWi1+wT25MWON8JkOoOKcfypGLLpjTRVBR0aM6UGH02iXi6lEDCraRBA8a9BK4TE0jtLNpt1UgxyUGHj8HjVMUrE5/MDaHprM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOOd0ljf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7BA3BC4CEED;
	Thu, 17 Jul 2025 13:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752758764;
	bh=Fl8H+oj0osT+K1fBWkJc81TgNpphdRz2K2nB4HUVi1M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IOOd0ljfha87s3DlJpQWOad+rbw/nnPZxqIYJfzbzLh4oWaGuwJbx4IwOikZ25R08
	 AWLJ+wtGNMmoj0hPszG6SKZflIvWwl660r0+f7LG7WgQrwcjTKjuurFsjPeixb4efV
	 DRsFHt1vEkHMVlpxWW2Q9Xb/jGrhBDHRBKVNQNtnWsoykinPIceQwum+L2wahLNzO1
	 lwDXahpMWKwZCiUtsbEBr6S8FmlQZ8aeo2tZElfwCaYifVSRI2vk6nM1ScOByCI901
	 CkHQfPR71Lbdx/uv5Wzo6bIlW4wS5J7mDGlGGdNCtCONX75BYcRPh5UitAWH7FL0rC
	 fg90X5jbqHH3A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA78C83F22;
	Thu, 17 Jul 2025 13:26:04 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Date: Thu, 17 Jul 2025 13:25:53 +0000
Subject: [PATCH v3 1/8] dt-bindings: iio: imu: Add inv_icm45600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-add_newport_driver-v3-1-c6099e02c562@tdk.com>
References: <20250717-add_newport_driver-v3-0-c6099e02c562@tdk.com>
In-Reply-To: <20250717-add_newport_driver-v3-0-c6099e02c562@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Remi Buisson <remi.buisson@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752758762; l=3305;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=h1J88JN1g/YReQtGVeLTKGjC/sJtA2uL0J0HESlzSgg=;
 b=Y39qiNyNZToqLF5HZW+Y4m8BW6+vy6Z0GvTqUO3Kj7hyNY0y8cGGh12BltwrlOTfgciRzZaBB
 HOVA8hkUAZ9BrbRmmgCMPBMvZhfHdNJh9xp25cQ2iAwttfUttX4xmjf
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
 .../bindings/iio/imu/invensense,icm45600.yaml      | 97 ++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm45600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm45600.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..f43258124c32ebf850fc29b2e97643885e6f8480
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm45600.yaml
@@ -0,0 +1,97 @@
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
+  - vdd-supply
+  - vddio-supply
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
+        imu@68 {
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

-- 
2.34.1



