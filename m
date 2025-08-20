Return-Path: <linux-iio+bounces-23056-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 902B0B2DF49
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 16:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469101BA7FEA
	for <lists+linux-iio@lfdr.de>; Wed, 20 Aug 2025 14:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0855275B16;
	Wed, 20 Aug 2025 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrA2NEm3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FF726FDA9;
	Wed, 20 Aug 2025 14:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699885; cv=none; b=lEKbtT8mJBI6auxvp7n91T5axnlXMabv/0EbCI9jOkeOmn7IG+3fIzDSU3UBVfXOW4YoLNJR9Qv2WsppD1PYEzxc6aoZt0m8Q7TIps9x34mWBf3dyZTqM8SAZu47TasoCR8/qh3sGceMeVw/UaMZz8+3gaWobtrNhoXy2kvrKzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699885; c=relaxed/simple;
	bh=43Hd4T+6Nuk347DonpknX8Z7snBYArgegOMZAKI7kCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MjpPSFNGH43rHybn9p6lf/1D4DXSqg0JA6wgu8/9wNJGhJ/j5VxFvff/exXWn1/oqZwoNQsylqR1hIhKnHTuipm4Sjm4A1F2MJHScDCbWClVWLCG6l6+le3tm8FrONYFxVsQ0zPpSp+y7LMv7HIaI11b/ieH2jPxPJLoM5LJVoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrA2NEm3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54A88C4CEE7;
	Wed, 20 Aug 2025 14:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755699885;
	bh=43Hd4T+6Nuk347DonpknX8Z7snBYArgegOMZAKI7kCI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QrA2NEm3cKXUeEFZzGCxuf1j8LAplxp/5xln9YyUIHjL8zUEYEeLUJQCBRELLUbRS
	 L3zDHx3JQlQfKjuKI5R4tBBZ6D5SmucUzbsSFwsh8ZtG+QWhBdtW4rfFmwG1DiTwir
	 CU4YnWW1EBuscyNfSmpahPct6IP4EmvpSgdLuE4oRke/VqPW8ag6tcFnF4uIo1Yg/2
	 S9XoHoKO+0Le1ScDqQKGmW8gbKpoZEfTT+5ZvM6tceZWvlAsc+rbgPmUyVL+/DixN/
	 PJjH64UQadQnwzxOJRsbmO0B9gPYSd1i3OavMn53Mcc/9E4U3V7IU8fzInQluzavq5
	 Hj9tn23vl64Ug==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DF9CA0EE4;
	Wed, 20 Aug 2025 14:24:45 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Date: Wed, 20 Aug 2025 14:24:19 +0000
Subject: [PATCH v5 1/9] dt-bindings: iio: imu: Add inv_icm45600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-add_newport_driver-v5-1-2fc9f13dddee@tdk.com>
References: <20250820-add_newport_driver-v5-0-2fc9f13dddee@tdk.com>
In-Reply-To: <20250820-add_newport_driver-v5-0-2fc9f13dddee@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Remi Buisson <remi.buisson@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755699883; l=3083;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=CvG751gXpIrPtBZ/B5Zk3M5Cc7OHvJOTN+ywayo73q0=;
 b=LJMAASNBD7UiBd02spINrvRU+tqypx/DPEmEftnwHW88HzTWgwMxsmF+ftL78VxO66hDp9/GG
 Y7C1MEfd2gCALN/YeSW/PgnblGd+Ehsi4fSx3mTP/VWdpxqRSg29zUj
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



