Return-Path: <linux-iio+bounces-27962-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 810D5D3AD2D
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 15:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B1AFD3061A01
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 14:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5ED37E2F8;
	Mon, 19 Jan 2026 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsqGTelL"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB6F27E07E;
	Mon, 19 Jan 2026 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768833450; cv=none; b=RGN60wtZ2lKitYqtcNzj/8gcyjWtmcn0e4FLmpYCSl2HvzXf4M5cOWkMFOPtafV7k3A29oZpWPSCDdl01mU49t8Zssx2s4E44y3zmYs8nn7bRtQStDYVg5bNXtIOtPlyZcqHHm1g0Qf+WKXfRrne1JZQbEZN0JZAclJzr/8cs8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768833450; c=relaxed/simple;
	bh=d/8RMpsl29Y8TYdguvIdcsQnNBPTICFlLMW095KZ3Uc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SO6AXy0DpOetOUHShm7tfSp8BYPADUAZGqjpXzPXZzWjA4Ftk2O/XgNgMfrBrPGAKoya5pg5054JMTv3HyIQo301nuQq71DJvUzB7BGMIRj4iP+GXKokRy33VCUos+sFVPx+fjWuN8JB1l19zP55mOsG77mugnIgtc7cA0ax9d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsqGTelL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0CE65C19423;
	Mon, 19 Jan 2026 14:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768833450;
	bh=d/8RMpsl29Y8TYdguvIdcsQnNBPTICFlLMW095KZ3Uc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EsqGTelLaLd7E5ajbh78dPbDs64COBrxc1rHcd4PvxMW3hOMD9PYprRKZpuXI3vJS
	 IxX1bMJl+wFDvBPV2aGVl02Vrf/fxibUrlvTPGcdvaQejCq9nXQe17cXy8sNVmY62J
	 1ykG7QQ0L9+huc5ljeWpePQ1i0oZKzbjw0fvJnhvBW3IVt0cnHcwDNyscGir+4eqk+
	 sL73vzdbiaaLOoszEIMjCoOoWT9hP1Ui8AFpuMcocOI+6h3WqiP8Oec3K2qLXiVZ6s
	 9Mn8K3PAOmUyMciEOBKBteAw0lgLq9Dut74ex42RaPNrO7apWunWgu+xXX/PUU26px
	 rH9o7ZapYMeBw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F260FD29C33;
	Mon, 19 Jan 2026 14:37:29 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 19 Jan 2026 14:36:56 +0000
Subject: [PATCH 2/7] dt-bindings: iio: amplifiers: Add AD8366 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-iio-ad8366-update-v1-2-8044e23e964a@analog.com>
References: <20260119-iio-ad8366-update-v1-0-8044e23e964a@analog.com>
In-Reply-To: <20260119-iio-ad8366-update-v1-0-8044e23e964a@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768833448; l=3034;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=MBEdUYu8R67rthes6ey0a6hT+KutZfNFQEm2s4twTzs=;
 b=2jvQufCxxYEUOOUxTv/fGM9g28FrsoPfcUranF/D1M2D1HEEl6yJ7XDkcUfc87aRU5Wuw3DGa
 1E+Hw9QHvhoBCuMU/Xgtovg96uqeJsvqgRq7oLtfWfuQSXa7fV98So9
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add device tree binding documentation for amplifiers and digital
attenuators. This covers different device variants with similar
SPI control.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 .../bindings/iio/amplifiers/adi,ad8366.yaml        | 85 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 86 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,ad8366.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,ad8366.yaml
new file mode 100644
index 000000000000..7477bb9b5071
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,ad8366.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/amplifiers/adi,ad8366.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AD8366, similar Gain Amplifiers and Digital Attenuators
+
+maintainers:
+  - Michael Hennerich <michael.hennerich@analog.com>
+  - Rodrigo Alencar <rodrigo.alencar@analog.com>
+
+description: |
+  Digital Variable Gain Amplifiers (VGAs) and Digital Attenuators with
+  SPI interface.
+
+properties:
+  compatible:
+    enum:
+      - adi,ad8366
+      - adi,ada4961
+      - adi,adl5240
+      - adi,adrf5720
+      - adi,adrf5730
+      - adi,adrf5731
+      - adi,hmc271a
+      - adi,hmc792a
+      - adi,hmc1018a
+      - adi,hmc1019a
+      - adi,hmc1119
+
+  reg:
+    maxItems: 1
+
+  vcc-supply:
+    description: Regulator that provides power to the device.
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      GPIO pin used to reset the device.
+
+  enable-gpios:
+    maxItems: 1
+    description:
+      GPIO pin used to enable the device.
+
+required:
+  - compatible
+  - reg
+  - vcc-supply
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      amplifier@0 {
+        compatible = "adi,ad8366";
+        reg = <0>;
+        spi-max-frequency = <1000000>;
+        vcc-supply = <&vcc_3v3>;
+      };
+    };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      attenuator@1 {
+        compatible = "adi,adrf5730";
+        reg = <1>;
+        spi-max-frequency = <1000000>;
+        vcc-supply = <&vcc_3v3>;
+      };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 9c8e83470464..0bbeea028cc0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1589,6 +1589,7 @@ M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/amplifiers/adi,ad8366.yaml
 F:	drivers/iio/amplifiers/ad8366.c
 
 ANALOG DEVICES INC AD9467 DRIVER

-- 
2.43.0



