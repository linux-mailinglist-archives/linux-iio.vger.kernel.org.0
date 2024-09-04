Return-Path: <linux-iio+bounces-9153-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFE796C73E
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 21:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20DE91F25E92
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 19:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A921E5004;
	Wed,  4 Sep 2024 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Bqhk8ah+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D531E4925
	for <linux-iio@vger.kernel.org>; Wed,  4 Sep 2024 19:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725477266; cv=none; b=pfzb9ki5bHCX6bU8ifXPmX1QlNh8QLCM+EzF3tO7Y0/OY4hBMTj90AVh53QkQ6jqUefTooOmZZgZdzwnWOZgyK5hGYY6LCsHNctF5ac5+XTdsZK9CqRjQSwwHYXz1XKvW9NqqpJbLSPTgcLyLjLDnWjzNVoBLt4X7HET8f2sVao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725477266; c=relaxed/simple;
	bh=FPoIpjhdgY+gUPHyTDCz+KM4L9PU9IeDvwYYNQV78S4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RJBjoijibJq8XOAonupsZkZNkd1cJBoW0/pN3WQJZ6lojIdrb7OrkGnBSOdnzsbSTtCxTVH4378/I7mdkt8GePrIfvNQYSQYOUyVvCAL7p/rANV4wTceQjfAdtbwzUYyyPcgG4sv+PVDr8sse3ovoX8A7aafD1h4DlDOsrrE4pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Bqhk8ah+; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-278279a3a39so12314fac.0
        for <linux-iio@vger.kernel.org>; Wed, 04 Sep 2024 12:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725477263; x=1726082063; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+RrcLp4DnQKM4STPH/FJP94hc63N43mi7DT/0zmkB6Q=;
        b=Bqhk8ah+EqjB6qvf2hk2oMoshylQZsHRQlZNZyfwFjzSBFOB2AyL4igBFsue3IodLO
         DghdJua+Ys1zoMvjtN4ukMtVr2uZ3NfPONUtxv8AdDrlwE2MhWukzWuKOPGqEfJEQ/Ub
         p11/FIytvtiymAKpr/NOHr2j97cxbP3KaZTRc1z+wA2vh3jHx8agyS0KfhpmTY72Xp4S
         PDUQURKx2NypS8FtNDYqQ84pEWc1FsCJhYkDoCcPmGqAwHMkfrgTi45R8VLCddIcvLLP
         8MdDbQRGV8f5vmm4yNCs7nUe3QFl2mdhW82YOU5agejeXfDHBgog+zJJCd94Uf6jt06U
         9Ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725477263; x=1726082063;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+RrcLp4DnQKM4STPH/FJP94hc63N43mi7DT/0zmkB6Q=;
        b=w8HkYrUlh3Sm3QJGY71WORMwLPcOV9RM4dk0UavMthv3q//nLABKrhpvOce74ZA9TJ
         11FVYxnVWtPKpVKs6Y4Ej9Q5xhWxH2ol5//0BF2Agz3JEpUj2mqz/GIntf7pcuSadqX0
         gf78Ad483DSppqH2FEauWAom8QAsXQ4IETRcPfdA+XcKJ+sSN/HkyJ+/HHWXLxxdUeIZ
         f7Vnh8JDAEkiZ9WDI0C4+ugBIqeJMtnIH+alOS6BWDbwX4h/7mRQ7DUroLg1FGaaiIlP
         mmnV395Yd9D3wIHnGR6YCWBHyOQtsBhvOG5lg3Tni979wLIwU6/UpYfUa1UArkfOu4aU
         3Ksw==
X-Gm-Message-State: AOJu0YzfCQKI4hk3FcM/6Xmad6jffR0A08sRLvSDb60pfQkrnIXPL6RI
	DKPcmLhlaUlbHjiPTDR3fO7cXq/StZXuLqhg7OzX6vFGeuUIQQNOuO6EK/vQfyctoVSObZzFeIy
	EQ+c=
X-Google-Smtp-Source: AGHT+IHNvbnp8OBpaHE5h/CcLm1PdMYVDnqNgp9aW2NGdJA//igcLLiWUWDV6jBA8hLPNGA09XdgjQ==
X-Received: by 2002:a05:6870:7020:b0:260:e611:c09 with SMTP id 586e51a60fabf-2781a9e8c5emr6340056fac.47.1725477263057;
        Wed, 04 Sep 2024 12:14:23 -0700 (PDT)
Received: from [127.0.1.1] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98f026caesm8861085a.135.2024.09.04.12.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 12:14:22 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Wed, 04 Sep 2024 15:14:18 -0400
Subject: [PATCH v4 1/3] dt-bindings: iio: adc: add AD762x/AD796x ADCs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240904-ad7625_r1-v4-1-78bc7dfb2b35@baylibre.com>
References: <20240904-ad7625_r1-v4-0-78bc7dfb2b35@baylibre.com>
In-Reply-To: <20240904-ad7625_r1-v4-0-78bc7dfb2b35@baylibre.com>
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
 .../devicetree/bindings/iio/adc/adi,ad7625.yaml    | 176 +++++++++++++++++++++
 MAINTAINERS                                        |   9 ++
 2 files changed, 185 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml
new file mode 100644
index 000000000000..8848562af28f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml
@@ -0,0 +1,176 @@
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
+      properties:
+        refin-supply: false
+  - if:
+      required:
+        - refin-supply
+    then:
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
+    #include <dt-bindings/gpio/gpio.h>
+    adc {
+        compatible = "adi,ad7625";
+        vdd1-supply = <&supply_5V>;
+        vdd2-supply = <&supply_2_5V>;
+        vio-supply = <&supply_2_5V>;
+        io-backends = <&axi_adc>;
+        clocks = <&ref_clk>;
+        pwms = <&axi_pwm_gen 0 0>, <&axi_pwm_gen 1 0>;
+        pwm-names = "cnv", "clk_gate";
+        en0-gpios = <&gpio0 86 GPIO_ACTIVE_HIGH>;
+        en1-gpios = <&gpio0 87 GPIO_ACTIVE_HIGH>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index fa2c8d902122..77557e85220e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1271,6 +1271,15 @@ F:	Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
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


