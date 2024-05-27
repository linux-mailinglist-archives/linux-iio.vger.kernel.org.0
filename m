Return-Path: <linux-iio+bounces-5349-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 500D38D06D1
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 17:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 549D5B2CDA5
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 15:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376D061FDD;
	Mon, 27 May 2024 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="BPhqvm4B"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042751E868;
	Mon, 27 May 2024 15:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716824484; cv=none; b=aLnF3eC766rsxHj0Lo2TvO6K87uscZIW6K+zpcq7XGSWb0uQDEJGQUJuL8dTkQoj4h5DcLvLMAfHhk1muVM0gjtz/On9DUtzsTvrR2eMCVCyRrNdln2ppY+9LHEvAl3yBwBynTE1MRPvWRUzN3N9YhPB3jbTBQB/uYQAM9jPVhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716824484; c=relaxed/simple;
	bh=Rj5PIlDFNaOJxdQqaPTtbgIWtQYQeE66I14+sbNsVTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rZzpfvxT2TUAdfnk9Z6oOzAazjfSw10GmUIGSagzkDE0oD86d4x1wzT1FS156NQbepf42BU2Hp+wUjWnaK6P2qtYu4XwEt45M4j4mykH5jEfReYcVB+jgwD2SylsDlwo7DDVh9jp2JvDVC6fl41JfKVVumFFdWPK/ygxhrOR2Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=BPhqvm4B; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 672EC206BF;
	Mon, 27 May 2024 17:41:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1716824478;
	bh=P55Jv4h7jsUm37sll4dvV/rarKgAJHPzr9ghJjpczzE=; h=From:To:Subject;
	b=BPhqvm4BoBBhnE4O2cPXIQHB/NJXT40fjf1hmOiFyo6zfwV8NP4nwXlLl2nf+eLLt
	 E85wbIsyDWHnBEr2fS5PGzxuWkkRuQPRNS+wfx5bltZ1rnDWdkvbNcO+4/geKpmOj0
	 ZC+x0EIUenFLIm13ctII7MdHJZRWw2VFcQSfLh94aDROw2Scw0wesDgIpX6v/MhseO
	 2QFmleAM1C7+kbedAx+rVACOARDqbfRMW4v58i0DogKYdgxyQXp0V15lSbwPpu7yNm
	 OjSmtftn7hG+mHNNh5xBtwvhU3bnKfjrwGUd3Q248F/qjN5CPfzW/UOamKtFUJsv06
	 ZBiUpVQK6QwyA==
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
Subject: [PATCH v1 1/2] dt-bindings: iio: adc: add ti,ads1119
Date: Mon, 27 May 2024 17:40:49 +0200
Message-Id: <20240527154050.24975-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240527154050.24975-1-francesco@dolcini.it>
References: <20240527154050.24975-1-francesco@dolcini.it>
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
 .../bindings/iio/adc/ti,ads1119.yaml          | 122 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 129 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
new file mode 100644
index 000000000000..ab4f01199dbe
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1119.yaml
@@ -0,0 +1,122 @@
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
+description: |
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
+    description: |
+      ADC channels.
+
+    properties:
+      reg:
+        description: |
+          0: Voltage over AIN0 and AIN1.
+          1: Voltage over AIN2 and AIN3.
+          2: Voltage over AIN1 and AIN2.
+          3: Voltage over AIN0 and GND.
+          4: Voltage over AIN1 and GND.
+          5: Voltage over AIN2 and GND.
+          6: Voltage over AIN3 and GND.
+        items:
+          - minimum: 0
+            maximum: 6
+
+      ti,gain:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          PGA gain value.
+        enum: [1, 4]
+        default: 1
+
+      ti,datarate:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          Data acquisition rate in samples per second.
+        enum: [20, 90, 330, 1000]
+        default: 20
+
+    required:
+      - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@40 {
+            compatible = "ti,ads1119";
+            reg = <0x40>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            #io-channel-cells = <1>;
+
+            channel@0 {
+                reg = <0>;
+                ti,gain = <4>;
+                ti,datarate = <330>;
+            };
+
+            channel@4 {
+                reg = <4>;
+                ti,datarate = <1000>;
+            };
+
+            channel@5 {
+                reg = <5>;
+                ti,gain = <4>;
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


