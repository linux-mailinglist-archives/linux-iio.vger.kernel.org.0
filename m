Return-Path: <linux-iio+bounces-6408-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5121890B9BF
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 20:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E0F285A74
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 18:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FC4198851;
	Mon, 17 Jun 2024 18:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="XQdeQGeG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005B2364BE;
	Mon, 17 Jun 2024 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718649154; cv=none; b=V/+KUT+LjwUSwEXUGlBbPbXgu21xntaKKgZlPNjoAl5+FMbXBJ4X/3gxbsWV0HnarJUqimmA4SbvRu1FwVifroyJ17VmnCg1+E2h22eqg8C/7YyWaDo76EWVJOfeOdlYH/UGRGjVjPAvZAGobtnhzycwDNHJCkfwpMIumGJktiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718649154; c=relaxed/simple;
	bh=P2wdIP0uG4dkAQoGvXpaeCBMIlNZeaWaFsz2yUMEZCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCssyfvQWNGpDjC61BG/koN9Va7qaGuMHSo7M9nV4jgxINTO2p9byC86ajfqOQ5obR7T3weF/9js4xWz+u7Ms4slcQmqS1vmu8IVYMDCR6cLsczyVZLYO7mwAqtLoVPyunkQwD19XqZ2ZP0xnk9XtSHUra74boLl3UAWZr3XA6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=XQdeQGeG; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 0B0E41F9D9;
	Mon, 17 Jun 2024 20:32:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1718649142;
	bh=jpkd5bGIuhY5z6UHD0UtFi3x8Uchmz6Nlu3roTK2w/w=; h=From:To:Subject;
	b=XQdeQGeGI8h2e9Hpr2g85F2t1huGD4smCQCCInN3HAgwPG0orYF+Rak6unbaQr7g5
	 FhFQEMOqr6HIPSlATMY11BIjbek6xNBSlt8p4CFHASK/zT9jqVks2EkFqbt3hZX5ja
	 mPe5o7gXFXLs52oy4xbKmAd2vaOFVBWMH6IIPgl49yL4nzw6jduvnK4MAxg8DqQ9H0
	 1ST3tEjKbLdxRjywkBKGRk83lbr/P7w+ul/0ZdnbFp/z9NhxxXeN6Qa1eiVMo9O6GZ
	 KpgduggkXyhsAsQ1QIF/rldZIAWqkqVvX2IAzQyV6pHGOz2K76Rvw28qVnnxNyfT/b
	 qouYoA51JQk8w==
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
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 1/2] dt-bindings: iio: adc: add ti,ads1119
Date: Mon, 17 Jun 2024 20:32:14 +0200
Message-Id: <20240617183215.4080-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240617183215.4080-1-francesco@dolcini.it>
References: <20240617183215.4080-1-francesco@dolcini.it>
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
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
v3:
 - add avdd and dvdd supplies
 - add Reviewed-by: Conor Dooley <conor.dooley@microchip.com

v2:
 - add diff-channels and single-channel
 - add XOR check to make diff/single channel property required 
 - add interrupts, reset-gpios and vref-supply to the example 
 - fix missing additionalProperties/unevaluatedProperties warning in channels
 - remove ti,gain and ti,datarate as they aren't fixed hw properties
 - remove unnecessary | 
---
 .../bindings/iio/adc/ti,ads1119.yaml          | 155 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 162 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
new file mode 100644
index 000000000000..ba6850ab1f90
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
@@ -0,0 +1,155 @@
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
+  avdd-supply: true
+  dvdd-supply: true
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
+  - avdd-supply
+  - dvdd-supply
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
+            avdd-supply = <&reg_avdd_ads1119>;
+            dvdd-supply = <&reg_dvdd_ads1119>;
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
index bff979a507ba..8acc2c83605c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22390,6 +22390,13 @@ M:	Robert Richter <rric@kernel.org>
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


