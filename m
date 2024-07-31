Return-Path: <linux-iio+bounces-8103-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF1E94314F
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 15:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69B3BB2335A
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 13:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FC11B3F0A;
	Wed, 31 Jul 2024 13:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="sWWkQ1+/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490BE1B3751
	for <linux-iio@vger.kernel.org>; Wed, 31 Jul 2024 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722433693; cv=none; b=QvqGyjKXQmSBql95NfnqMT7nKrUTVscakLz/lmsmP8qXRw+HZbHGtRIpdnY3g7jRL4rgWxIV70kjHQczKOI+EeVNeMQ4pJoJA1ZnaWmCRD6mIHUsRW2jDPokFcvVp0BcJEFvjnWYrLYTnYJqNCQ6G2nJM1Xng14uanfzF/hsHok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722433693; c=relaxed/simple;
	bh=NzNtXoBNYB0etLBt7Aj0LPqIWAdcXavnH6zDU74kAYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B3EGCB3ql8ayP7RPr4SpTFqPhBgESZOvS6LdwSvm5Uwngpg0CT88pLM/VzCHJkuK6Ho1oEen81UY6yxr93WnOYoH+u/k/Na+ZRDwUTLX25+BfYJG/adi2m4xBzf3EZLJgDwwE5I8EwcEX41i3IRQiFf8wJ2QClPMuWcFFqjgTTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=sWWkQ1+/; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a1d6f4714bso84272385a.1
        for <linux-iio@vger.kernel.org>; Wed, 31 Jul 2024 06:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722433688; x=1723038488; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mDSy5i+PWIQbuPyffd+oom3wrRaBv+Tc62xGQ8pPdBU=;
        b=sWWkQ1+/QIZD0kbd26+3dAQr4D7qYhb5a9pMKX8kDGxj9/wYnSnd57q4Y/AxpS3hkl
         HsfF7fa0gwDh875NNQil9DX3TWysU0bvAru72qM8dho7170MWm0Fr1q/l3AV/7wOw7a+
         hBEd8GThI/juiTE4WIZOchVLk3APnWj3Q9v8zrDfQhhtCJtPoB8HB7oAve3uZxDL/H83
         m3fSzgQs8F89tFYv8AdJ711BAbA370yBm6yjVdlARSK+03V0+usmnkS7tYVdV28UEffF
         2XK+LUTnbIxOgQBxqxPZ6hCmn9kbFD8ocNz7zDMKMs11kOd0MTCqShcIUOqb7lHpl5AA
         Lkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722433688; x=1723038488;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDSy5i+PWIQbuPyffd+oom3wrRaBv+Tc62xGQ8pPdBU=;
        b=cfgFvheEwn1w/HtUJ/3AGL35WygRTdh52qRAl5mh73N0zV+IUvpT1mTY4s/n0/SiY6
         63REkGbopRADhCfpH/Qiij2Y9TkAYEOXQGAHmSf2RB45dSOKkr1sggEhP+YrQCCjBIht
         msFOh3eO23KuH3ypPlyETyL6+Lrf8BsETuJJIObZQNQURHVMr5szbJG/vV4Y+tIilJmU
         2zNywtlpjVCO3DxpgxhDW/EA7ZcXtONapEnV6fcy8olpn4GrG+Db211LzN5uxHrzvt3t
         mtZn5J2U5njlLSeKHERIZMZUIf6C7QHy+lXOuOUrfDsYUOI1UMNaF+OlFvRWH/EOCVM4
         yWTQ==
X-Gm-Message-State: AOJu0Yyoer17+nniluYKvtD6TnfNSgDTcxK9qzw4lGT/+QqsBBdOkQXg
	GY0Y0NKRBCHQV0CGWv8eydi1qkNwSW4YP/IUzS+dP2c57pK3Fss2WREp5uwU3qo=
X-Google-Smtp-Source: AGHT+IF0uk+GAWLTeYgzWMtpSJHPiGxYF+WUq8rmU/ZgGJOZAHOY3lzLw1QTuS7lRUaVaOh0j1UqcA==
X-Received: by 2002:a05:620a:408b:b0:79e:fd1e:6fc4 with SMTP id af79cd13be357-7a200d119f3mr973827385a.34.1722433688046;
        Wed, 31 Jul 2024 06:48:08 -0700 (PDT)
Received: from [127.0.1.1] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d73955ccsm746209985a.11.2024.07.31.06.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 06:48:06 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Wed, 31 Jul 2024 09:48:03 -0400
Subject: [PATCH RFC 1/3] dt-bindings: iio: adc: add AD762x/AD796x ADCs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240731-ad7625_r1-v1-1-a1efef5a2ab9@baylibre.com>
References: <20240731-ad7625_r1-v1-0-a1efef5a2ab9@baylibre.com>
In-Reply-To: <20240731-ad7625_r1-v1-0-a1efef5a2ab9@baylibre.com>
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

This adds a binding specification for the Analog Devices Inc. AD7625,
AD7626, AD7960, and AD7961 ADCs.

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7625.yaml    | 176 +++++++++++++++++++++
 MAINTAINERS                                        |   9 ++
 2 files changed, 185 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7625.yaml
new file mode 100644
index 000000000000..e88db0ac2534
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
+  A family of single channel differential analog to digital converters
+  in a LFCSP package. Note that these bindings are for the device when
+  used with the PulSAR LVDS project:
+  http://analogdevicesinc.github.io/hdl/projects/pulsar_lvds/index.html.
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
+  vdd1-supply:
+    description: A supply that powers the analog and digital circuitry.
+
+  vdd2-supply:
+    description: A supply that powers the analog and digital circuitry.
+
+  vio-supply:
+    description: A supply for the inputs and outputs.
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
+    maxItems: 2
+
+  pwm-names:
+    maxItems: 2
+    items:
+      - const: cnv
+        description: PWM connected to the CNV input on the ADC.
+      - const: clk_gate
+        description: PWM that gates the clock connected to the ADC's CLK input.
+
+  io-backends:
+    description:
+      The AXI ADC IP block connected to the D+/- and DCO+/- lines of the ADC.
+    maxItems: 1
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
+- if:
+  properties:
+    compatible:
+      contains:
+        enum:
+	  - adi,ad7625
+	  - adi,ad7626
+  then:
+    properties:
+      en2-gpios: false
+      en3-gpios: false
+      adi,en2-always-on: false
+      adi,en3-always-on: false
+    allOf:
+      # ref-supply and refin-supply are mutually-exclusive (neither is also
+      # valid)
+      - if:
+          required:
+            - ref-supply
+        then:
+          properties:
+            refin-supply: false
+      - if:
+          required:
+            - refin-supply
+        then:
+          properties:
+            ref-supply: false
+
+- if:
+  properties:
+    compatible:
+      contains:
+        enum:
+	  - adi,ad7960
+	  - adi,ad7961
+  then:
+    oneOf:
+      required:
+        - ref-supply
+      required:
+        - refin-supply
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
+        clock = <&ref_clk>;
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


