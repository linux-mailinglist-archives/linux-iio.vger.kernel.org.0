Return-Path: <linux-iio+bounces-8380-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DA394D66F
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 20:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114541C21E0B
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 18:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3CD15FCEA;
	Fri,  9 Aug 2024 18:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nw0hfDJC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34991591E2
	for <linux-iio@vger.kernel.org>; Fri,  9 Aug 2024 18:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723228879; cv=none; b=n7SGjTyJ436ikHFl2yVfUimeV6WeHnEUMkPq66efCaSlsSgf0klfc6POOdxjtG45UJ/HvEsSCCD38ejJwRC+6QngGi4DkFpo0tmdDM7dc1DPY7nfJhvB1Jybe/R0EWxbHk4RpZFi6O0iUT8YHOq5/+2uosOiocVF7ritsWdQ/xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723228879; c=relaxed/simple;
	bh=la6GSpQ2MOFizv9wiIf/4WUJBySqR8xKNVQYNv704wc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lm9wv72J0HHPU5N32n49IPCV4Zq+cl5IUSI+Aoyvo9A7cAFgWZ9Uo5WxUj8JD5Mrs3ozIjOZGlUObnOIlByY6Cvx/XaOr1kAqYLIwxeEu19VErkVnFEGaVUr565ooMJ+5oopt1WXBVE6GrsoQ40FpJA8WKSz9XMo+kvdMylx/XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nw0hfDJC; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-44ff99fcd42so12796851cf.0
        for <linux-iio@vger.kernel.org>; Fri, 09 Aug 2024 11:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723228877; x=1723833677; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S1bblDUFtr6UOb9/HDv6zHhrOgpYsPDN9jUK9jADrd4=;
        b=nw0hfDJC37vxG+MOV9V9Zdmka296vCArG4GkWMuaY6Zqr2ibkaQtG40fapIhCIQQ/e
         8YcVC+w+mM5SmK3SeDfTV/wult8eVoaglmERrmq8F/uBpYRO4D01TkyWBAHr87vcSLzD
         TlFQP6dcJ6luN37ztM6XLFgyChI4bpjwjxgkLq6YbcbnM9pSmoCv/sfbqfSmwmkY2nmz
         Ty3SuwC5qm4hEEW95KD8EgZM0j/UBmZpLv3OjMz1tfkomNf7VG1GFXX7pk78U48r/n0F
         7bBjrO5XOgqXHlmhtj2aUKDiGiw8VO004cWXMMilhAtiZ6kZBw/vzZNw3lb3CToyyp1v
         IgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723228877; x=1723833677;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S1bblDUFtr6UOb9/HDv6zHhrOgpYsPDN9jUK9jADrd4=;
        b=oQiMLWb6nEjHC15pJqN5/d4gs8FPxPG7+QZy+9q5lUld83cRQgZpguU+WFu5VeP21a
         A48Hxvv9xE1dUNRnC1HAi7iH0K/cNEJrPf9UGn8aARAEETN9Zrfanb1ljBDMhow2CI7W
         yxt47XLn5wKSm+pCXcH5suFv7XXyO6mc/LJN2zq6HSDTPbS5frbm8Ob0Nb22c+ekH09M
         QTNfDUPJzFn/tdiHlUIX8FFbw2ZWI+RIk9ox5OFuM/WqoHlZ4rxI0r7PxLy7BrLmvE8m
         U5no3aD6a9pCKxhc2p5uZ5lC78Vf/948DAfpgwm5vBjRmBSkTMFqt5Hmbvu7nltCaUzm
         t5/w==
X-Gm-Message-State: AOJu0Yxyiw3w6xWQqYfamHm6pKMz+PcrLUBQ0VTu2iOvOliskYo4/UG6
	3diR6c+yZ5S9EGPyKu0ABo5syxdn4RcMqyCpwIu6imb0b0zdahhjK6S2bf7zGAc=
X-Google-Smtp-Source: AGHT+IFewIGGG3exnCOpqbH8KmEMNNmpnY4iTeju133LC+0BzLTFB16XV5HsfO1wa1DS06fzTdHfbA==
X-Received: by 2002:a05:622a:5809:b0:447:def8:bc8b with SMTP id d75a77b69052e-45312578845mr37513481cf.20.1723228876667;
        Fri, 09 Aug 2024 11:41:16 -0700 (PDT)
Received: from [127.0.1.1] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4531c1d723asm370381cf.44.2024.08.09.11.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 11:41:16 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Fri, 09 Aug 2024 14:41:08 -0400
Subject: [PATCH v2 1/3] dt-bindings: iio: adc: add AD762x/AD796x ADCs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240809-ad7625_r1-v2-1-f85e7ac83150@baylibre.com>
References: <20240809-ad7625_r1-v2-0-f85e7ac83150@baylibre.com>
In-Reply-To: <20240809-ad7625_r1-v2-0-f85e7ac83150@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 David Lechner <dlechner@baylibre.com>, 
 Uwe Kleine-Konig <u.kleine-koenig@baylibre.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.14.1

Add a binding specification for the Analog Devices Inc. AD7625,
AD7626, AD7960, and AD7961 ADCs.

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7625.yaml    | 175 +++++++++++++++++++++
 MAINTAINERS                                        |   9 ++
 2 files changed, 184 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml
new file mode 100644
index 000000000000..8192c269dc2f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml
@@ -0,0 +1,175 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7625.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices Fast PulSAR Analog to Digital Converters
+
+maintainers:
+  - Michael Hennerich <Michael.Hennerich@analog.com>
+  - Nuno Sá <nuno.sa@analog.com>
+
+description: |
+  A family of single channel differential analog to digital converters.
+
+  * https://www.analog.com/en/products/ad7625.html
+  * https://www.analog.com/en/products/ad7626.html
+  * https://www.analog.com/en/products/ad7960.html
+  * https://www.analog.com/en/products/ad7961.html
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7625
+      - adi,ad7626
+      - adi,ad7960
+      - adi,ad7961
+
+  vdd1-supply: true
+  vdd2-supply: true
+  vio-supply: true
+
+  ref-supply:
+    description:
+      Voltage regulator for the external reference voltage (REF).
+
+  refin-supply:
+    description:
+      Voltage regulator for the reference buffer input (REFIN).
+
+  clocks:
+    description:
+      The clock connected to the CLK pins, gated by the clk_gate PWM.
+    maxItems: 1
+
+  pwms:
+    items:
+      - description: PWM connected to the CNV input on the ADC.
+      - description: PWM that gates the clock connected to the ADC's CLK input.
+
+  pwm-names:
+    items:
+      - const: cnv
+      - const: clk_gate
+
+  io-backends:
+    description:
+      The AXI ADC IP block connected to the D+/- and DCO+/- lines of the
+      ADC. An example backend can be found at
+      http://analogdevicesinc.github.io/hdl/projects/pulsar_lvds/index.html.
+    maxItems: 1
+
+  adi,no-dco:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Indicates the wiring of the DCO+/- lines. If true, then they are
+      grounded and the device is in self-clocked mode. If this is not
+      present, then the device is in echoed clock mode.
+
+  adi,en0-always-on:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Indicates if EN0 is hard-wired to the high state. If neither this
+      nor en0-gpios are present, then EN0 is hard-wired low.
+
+  adi,en1-always-on:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Indicates if EN1 is hard-wired to the high state. If neither this
+      nor en1-gpios are present, then EN1 is hard-wired low.
+
+  adi,en2-always-on:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Indicates if EN2 is hard-wired to the high state. If neither this
+      nor en2-gpios are present, then EN2 is hard-wired low.
+
+  adi,en3-always-on:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Indicates if EN3 is hard-wired to the high state. If neither this
+      nor en3-gpios are present, then EN3 is hard-wired low.
+
+  en0-gpios:
+    description:
+      Configurable EN0 pin.
+
+  en1-gpios:
+    description:
+      Configurable EN1 pin.
+
+  en2-gpios:
+    description:
+      Configurable EN2 pin.
+
+  en3-gpios:
+    description:
+      Configurable EN3 pin.
+
+required:
+  - compatible
+  - vdd1-supply
+  - vdd2-supply
+  - vio-supply
+  - clocks
+  - pwms
+  - pwm-names
+  - io-backends
+
+allOf:
+  - if:
+      required:
+        - ref-supply
+    then:
+      # refin-supply is not needed if ref-supply is given
+      properties:
+        refin-supply: false
+  - if:
+      required:
+        - refin-supply
+    then:
+      # ref-supply is not needed if refin-supply is given
+      properties:
+        ref-supply: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad7625
+              - adi,ad7626
+    then:
+      properties:
+        en2-gpios: false
+        en3-gpios: false
+        adi,en2-always-on: false
+        adi,en3-always-on: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad7960
+              - adi,ad7961
+    then:
+      # ad796x parts must have one of the two supplies
+      oneOf:
+        - required: [ref-supply]
+        - required: [refin-supply]
+
+additionalProperties: false
+
+examples:
+  - |
+    adc {
+        compatible = "adi,ad7625";
+        vdd1-supply = <&supply_5V>;
+        vdd2-supply = <&supply_2_5V>;
+        vio-supply = <&supply_2_5V>;
+        io-backends = <&axi_adc>;
+        clocks = <&ref_clk>;
+        pwms = <&axi_pwm_gen 0 0>, <&axi_pwm_gen 1 0>;
+        pwm-names = "cnv", "clk_gate";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 42decde38320..2361f92751dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1260,6 +1260,15 @@ F:	Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
 F:	drivers/iio/addac/ad74413r.c
 F:	include/dt-bindings/iio/addac/adi,ad74413r.h
 
+ANALOG DEVICES INC AD7625 DRIVER
+M:	Michael Hennerich <Michael.Hennerich@analog.com>
+M:	Nuno Sá <nuno.sa@analog.com>
+R:	Trevor Gamblin <tgamblin@baylibre.com>
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+W:	http://analogdevicesinc.github.io/hdl/projects/pulsar_lvds/index.html
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml
+
 ANALOG DEVICES INC AD7768-1 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
 L:	linux-iio@vger.kernel.org

-- 
2.39.2


