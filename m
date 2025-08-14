Return-Path: <linux-iio+bounces-22721-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C191FB26009
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 11:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86163720050
	for <lists+linux-iio@lfdr.de>; Thu, 14 Aug 2025 09:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2792F3C32;
	Thu, 14 Aug 2025 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0y60J9e"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F7F2E92C9;
	Thu, 14 Aug 2025 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161844; cv=none; b=TqgcMjpvW8utpPXSvbrmLaWKgV0S/tm7KuqCkLVDjj8MooLJXafBZVuxTU1TmRKqkrEfVNAVMV5mpGIRErSb8ZJfRoTv4Le3RXdPt7RDnrwzMhWeu2r4c8Wgz4NWsJb7IdHwihaQZZND4DdpIUfXAGI51UgZ5W+2CzWCOeIbL/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161844; c=relaxed/simple;
	bh=Fl8H+oj0osT+K1fBWkJc81TgNpphdRz2K2nB4HUVi1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uOS4GZ0N9A5R5sGHGf+Nk8fxYWKAesQ8ZVJh5rb4axlxmnW0ftgADLfcW/JGY9zzMjgkbTjoy6JeXEeCc/oejnotDUm5JjiDU0ScSl6PcozoMmVJ2Eqk/zqAyCQ/Rg5KSePLOtRIar6NLOaG3xo3K3EAJQK8pzAMk0Vv5h4FcJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0y60J9e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13BBCC4CEEF;
	Thu, 14 Aug 2025 08:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755161844;
	bh=Fl8H+oj0osT+K1fBWkJc81TgNpphdRz2K2nB4HUVi1M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=R0y60J9e2oQ4BmVWcQbL/xSBw6Tf6YOihank/5J9FWtGEHaFAXusFf7FYP7g4mvy7
	 3cVipM03HtW7vPrbx2ye6I1RZGivw8Xu9KKmaekrWrpTwO2pKyXhaDH9JHInM6QW+v
	 YpbpSOixgx+i+TmsUL8bm2eVCahynuUZqz/pifPeCsbklw1NmtVVwE6cIk9InTDyV8
	 LIic7E2Gc4pfaCplHJsm1cgPMvmBfZUYLTAFDAJBf07xhiRCRc49is0WOGl62zIgEt
	 jyRFn9adD94DVLhQZXgjqK5LXysLZyA5LoITfWm6492D2eSYTdA4aqVbwHrWv385Az
	 0CUg9p30BSh0Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DFCCA0EE3;
	Thu, 14 Aug 2025 08:57:24 +0000 (UTC)
From: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>
Date: Thu, 14 Aug 2025 08:57:15 +0000
Subject: [PATCH v4 1/9] dt-bindings: iio: imu: Add inv_icm45600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-add_newport_driver-v4-1-4464b6600972@tdk.com>
References: <20250814-add_newport_driver-v4-0-4464b6600972@tdk.com>
In-Reply-To: <20250814-add_newport_driver-v4-0-4464b6600972@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Remi Buisson <remi.buisson@tdk.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755161842; l=3305;
 i=remi.buisson@tdk.com; s=20250411; h=from:subject:message-id;
 bh=h1J88JN1g/YReQtGVeLTKGjC/sJtA2uL0J0HESlzSgg=;
 b=6nWPnSPBbw684Ki9g6pqKMVkYvbwhHFMWvp79UPrt9o1Ilat7RVdPp8gHeNemRQ+7KC16eh1v
 ROkp4vPJpugDsvDJiyDU66kAG8JTUXH66FtSXLEe9XGkJjGJjkeHW1V
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



