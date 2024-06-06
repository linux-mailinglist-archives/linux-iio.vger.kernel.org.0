Return-Path: <linux-iio+bounces-5930-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FAE8FF29C
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 18:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64957283C00
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 16:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96B6198845;
	Thu,  6 Jun 2024 16:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="PaSBu/iN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15E3195F0F;
	Thu,  6 Jun 2024 16:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717691742; cv=none; b=OdbbaKDKg7rX4MOjz/D++UvXyE97g7svuchheoIU7PZ0fvaVBsRllUdanu3krZNDBOdhk425dzuM5Ncsz/Aa8E0gRnSRQo0kHo3Ef4uNeM+u/lf/20+bi8P5IeqCov/rO+qcpzELR+t6pTFSbpw4L27Opmg142CQUk8h8sJyo9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717691742; c=relaxed/simple;
	bh=aHU4+FwLoaSWgDRB30Dp1ex2pYNaWD0i5KfMmU9QgXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y2redhrPVh7tQfFgxukqFNJ+2IflMVSBEx8vb1UKkQ/oJXszG2m+68/+x4sFCcUUEieTIq621TGB7gD+QCcS2kDuZL9wk5HoRN8ZxtM4P3Q6dvfxHe8evbJUNWLqSYyefINZHFE0IdCWRoGyUJd1HB51WwLgI2O9KqnhRvnYf/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=PaSBu/iN; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.corp.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 1F5451FA62;
	Thu,  6 Jun 2024 18:35:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1717691737;
	bh=491GEVJBM/nY6jPxxV15PpDLfl3c2eoctjsUQy5xWHM=; h=From:To:Subject;
	b=PaSBu/iNSl8FPfaK6sNE380iM1bg9ztu74kBz/jZWH0xGSf3eZX9X2E1hSICpdsKd
	 xVUtOyKurYAnmVM5/1W+Vr6LkGbdOlD54FPOh1ZdbytMexwzQuP7xnM0WCSaUATFWA
	 5OwRg/T4H2qzhWzzChP+zUEjcjZFf08udKwYKkE8yNhakg46nGX17ztNpufKhoOXst
	 15VRFNBX+TJo3Xff4enHQkK4WQbWiuGYLoy8DRHdU0bt0IA3sQVGMMi0a39n3uqr0u
	 GxLIOpvZbxratbzLqQHARiBmFTB6GGD5TuOwKbPcNa/+oh2rerJxMfWsvWFmeu8klU
	 NrHzrCNtH2QZw==
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco@dolcini.it>,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: add ti,ads1119
Date: Thu,  6 Jun 2024 18:35:28 +0200
Message-Id: <20240606163529.87528-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606163529.87528-1-francesco@dolcini.it>
References: <20240606163529.87528-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: João Paulo Gonçalves <joao.goncalves@toradex.com>

Add devicetree bindings for Texas Instruments ADS1119 16-bit ADC
with I2C interface.

Datasheet: https://www.ti.com/lit/gpn/ads1119
Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v2:
 - add diff-channels and single-channel
 - add XOR check to make diff/single channel property required 
 - add interrupts, reset-gpios and vref-supply to the example 
 - fix missing additionalProperties/unevaluatedProperties warning in channels
 - remove ti,gain and ti,datarate as they aren't fixed hw properties
 - remove unnecessary | 
---
 .../bindings/iio/adc/ti,ads1119.yaml          | 148 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 155 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
new file mode 100644
index 000000000000..cbf0d4ef3a11
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
@@ -0,0 +1,148 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads1119.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments ADS1119 ADC
+
+maintainers:
+  - João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
+
+description:
+  The TI ADS1119 is a precision 16-bit ADC over I2C that offers single-ended and
+  differential measurements using a multiplexed input. It features a programmable
+  gain, a programmable sample rate, an internal oscillator and voltage reference,
+  and a 50/60Hz rejection filter.
+
+properties:
+  compatible:
+    const: ti,ads1119
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  vref-supply:
+    description:
+      ADC external reference voltage (VREF).
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+
+patternProperties:
+  "^channel@([0-6])$":
+    $ref: adc.yaml
+    type: object
+    properties:
+      reg:
+        minimum: 0
+        maximum: 6
+
+      diff-channels:
+        description:
+          Differential input channels AIN0-AIN1, AIN2-AIN3 and AIN1-AIN2.
+        oneOf:
+          - items:
+              - const: 0
+              - const: 1
+          - items:
+              - const: 2
+              - const: 3
+          - items:
+              - const: 1
+              - const: 2
+
+      single-channel:
+        description:
+          Single-ended input channels AIN0, AIN1, AIN2 and AIN3.
+        minimum: 0
+        maximum: 3
+
+    oneOf:
+      - required:
+          - diff-channels
+      - required:
+          - single-channel
+
+    required:
+      - reg
+
+    unevaluatedProperties: false
+
+additionalProperties: false
+
+examples:
+  - |
+
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@40 {
+            compatible = "ti,ads1119";
+            reg = <0x40>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+            reset-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
+            vref-supply = <&reg_vref_ads1119>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            #io-channel-cells = <1>;
+
+            channel@0 {
+                reg = <0>;
+                single-channel = <0>;
+            };
+
+            channel@1 {
+                reg = <1>;
+                diff-channels = <0 1>;
+            };
+
+            channel@2 {
+                reg = <2>;
+                single-channel = <3>;
+            };
+
+            channel@3 {
+                reg = <3>;
+                single-channel = <1>;
+            };
+
+            channel@4 {
+                reg = <4>;
+                single-channel = <2>;
+            };
+
+            channel@5 {
+                reg = <5>;
+                diff-channels = <1 2>;
+            };
+
+            channel@6 {
+                reg = <6>;
+                diff-channels = <2 3>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index d6c90161c7bf..f1b2c4b815e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22380,6 +22380,13 @@ M:	Robert Richter <rric@kernel.org>
 S:	Odd Fixes
 F:	drivers/gpio/gpio-thunderx.c
 
+TI ADS1119 ADC DRIVER
+M:	Francesco Dolcini <francesco@dolcini.it>
+M:	João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
+
 TI ADS7924 ADC DRIVER
 M:	Hugo Villeneuve <hvilleneuve@dimonoff.com>
 L:	linux-iio@vger.kernel.org
-- 
2.39.2


