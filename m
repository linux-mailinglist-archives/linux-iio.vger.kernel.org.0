Return-Path: <linux-iio+bounces-24800-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA54BC0794
	for <lists+linux-iio@lfdr.de>; Tue, 07 Oct 2025 09:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC363BF945
	for <lists+linux-iio@lfdr.de>; Tue,  7 Oct 2025 07:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368C9237172;
	Tue,  7 Oct 2025 07:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rk8tE1mn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B6B221FBB;
	Tue,  7 Oct 2025 07:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759821609; cv=none; b=mEMazsIbJIwqNdWxKPQHVZs5CXa6HNz5OOAU3GoOw1YFLUy1Wk8GbfsX0GL4+imHNizn4t2dUtEVgvouWRpM8xqifujZ5EURbC5J2qsbB23QFLe1ddiF8l2hJ/Q8PYXBu4TVRJXGWl+Fe2FHNitdKZeuLfkZiOrj9RDSNARD4UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759821609; c=relaxed/simple;
	bh=JGM9cSZXo8+TvBmcJjJaKpVNMxrTNOCsRZaM5qoFaMs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CvyC6YOEy6oEXAy/T3T7j9gJ1PHJHYPjcXhBkAoiBZ7TECtnXi9MkG5bbCz03bb7RmeMEdxf5UZeKSF5Fm9cOZL0uxJxk3iwzKmT26xSyM2fyy/gxx3DTe29wigeMQZtykO0jvbKuGLc1DHtNdJJB54g+OzPSh0Q39cvLW2OX0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rk8tE1mn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67762C4CEF9;
	Tue,  7 Oct 2025 07:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759821609;
	bh=JGM9cSZXo8+TvBmcJjJaKpVNMxrTNOCsRZaM5qoFaMs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Rk8tE1mn844beRoki+1Si/vhLt3hrnVmhONJ/33iCpDmcn+70mhl2PV9HCNwYdk6m
	 tF5YqW2kYI4QlRniHEOyBY/oq7tlMlo9P5CzMv5pBPxMqZGEvPIpy5hZMGb4p/eS2F
	 bdy0G3+74lkEUodETPIFWdbskm1YI1iZgks1uSKt1KKfyjJNQv0UXrB4Sf2p4D0nIA
	 jK2os2vsxQ2prFHEH7gMD+uetD56MVLbWDbPuOtimkunGFY3oHxGs4TodCX2EkXw+g
	 gdaaIaeZ+/60ZBNlr2OdmNfYl0omLitrRvAbMf3ggoxWj2mwYcjr+AFsqZdeMZAMH/
	 rbSxxd9WBGRlA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557BDCCD184;
	Tue,  7 Oct 2025 07:20:09 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Date: Tue, 07 Oct 2025 07:20:02 +0000
Subject: [PATCH v7 1/9] dt-bindings: iio: imu: Add inv_icm45600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-add_newport_driver-v7-1-137223a1f79e@tdk.com>
References: <20251007-add_newport_driver-v7-0-137223a1f79e@tdk.com>
In-Reply-To: <20251007-add_newport_driver-v7-0-137223a1f79e@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Remi Buisson <remi.buisson@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759821607; l=3206;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=WdBxUHROTINcNpQrUbA+QjKp5ULEuA9Tfo00ubU35nk=;
 b=Brt3d+cA9+sFWMkxGnTDsQEGfr87u6PdYNBkC3tK9goXnlPxoI3s7lGsYbEkM83+8kL8W7ov/
 TQuZyAMJtKhDxYRd4FQRICEesxEeikpZqVDRPyiQYpGwdK+n7dlaiDe
X-Developer-Key: i=remi.buisson@tdk.com; a=ed25519;
 pk=yDVMi4C7RpXN4dififo42A7fDDt3THYzoZoNq9lUZuo=
X-Endpoint-Received: by B4 Relay for remi.buisson@tdk.com/20250411 with
 auth_id=372
X-Original-From: Remi Buisson <remi.buisson@tdk.com>
Reply-To: remi.buisson@tdk.com

From: Remi Buisson <remi.buisson@tdk.com>

Document the ICM-45600 devices devicetree bindings.
Specific variants of the device are defined because of their
differences in terms of FSR or advanced features like eDMP.

Signed-off-by: Remi Buisson <remi.buisson@tdk.com>
---
 .../bindings/iio/imu/invensense,icm45600.yaml      | 90 ++++++++++++++++++++++
 1 file changed, 90 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm45600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm45600.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..e0b78d14420febee405750ef5cb6ce14bfa07447
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm45600.yaml
@@ -0,0 +1,90 @@
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
+    items:
+      - enum: [int1, int2]
+      - const: int2
+    description: Choose chip interrupt pin to be used as interrupt input.
+
+  drive-open-drain:
+    type: boolean
+
+  vdd-supply: true
+
+  vddio-supply: true
+
+  mount-matrix: true
+
+required:
+  - compatible
+  - reg
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
+            interrupt-names = "int1";
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



