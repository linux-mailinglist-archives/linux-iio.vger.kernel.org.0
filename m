Return-Path: <linux-iio+bounces-9391-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8089971C98
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 16:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E57284769
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2024 14:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF40F1BAECF;
	Mon,  9 Sep 2024 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gvLs64Re"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C92A1BA894
	for <linux-iio@vger.kernel.org>; Mon,  9 Sep 2024 14:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725892258; cv=none; b=Q0yv0ls3mYKbL5rY34uPWz55+qKJiJLkLrFO1KrZ/mmIoIUZx5kPYUDWJPRsyaCHZx4mRkqvFNc4VI8L/WZoG00UmyimMl+yhCSfFkUYdYh8hI/yzH0itTWriREoJrcbrugJWV5f7OWyiagBk6Uc46lBJTcrf0+N2cnySHy8rlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725892258; c=relaxed/simple;
	bh=cJz56MhvoNRwns9QCgPwKIZJcbJaF4abAjFyuzcpJww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lY+8run98VseP8l1wVfxtCrG0u5T9Lo+4vpE6byakYLzTOm+myDV06xbh8PYSGHbf0w4nf30kmDhZT3T1WACVtxhDVIlfz8zvh3QqbWvmAaXYWo12bgCjJ0W+FqKiPGrrF9LWxCPj7EQmXcQzm/ejd5PAncldJ9u9UMhTECAAes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gvLs64Re; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6c355155f8eso25054056d6.0
        for <linux-iio@vger.kernel.org>; Mon, 09 Sep 2024 07:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725892255; x=1726497055; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UfPN/kQIrUKqIq5jWFNbRckbkKsrSVmrNfpeCh4QqdA=;
        b=gvLs64ReJXAZdXKnWT9TJ/OHuuFY+cm8E2234EQP7HYNvz5vFVbsnbtaY7q6sreh3q
         W11uvR2k7398QntIoSkcqMeSvwqftXZ2x54VqKTyU1ji45xD+MFuXQy8t9gS0ucd3vtn
         BMZ2u9aSqhpg0H8HROrla7BjzOTspHRgb3irMN4Sfg70NyIInRO+31K28JXAarJXSewC
         C7M9o41cguaNbqCeXvK6DKQv3UzNA3q3EK2H0uKse+rvf0U7+150x4vp1h58jv6y7B20
         JeF47y/QUfPC78oYIDv2Ri9RliXAZGZEnLv6B1itXmsFugmqfzUc6dHTdDc24wgs5h6U
         QG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725892255; x=1726497055;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UfPN/kQIrUKqIq5jWFNbRckbkKsrSVmrNfpeCh4QqdA=;
        b=vBX5ngrZp9yW96/73SeY+7dzowa5Qovj9MxcEXtP+sEC2rSrx4Fxw4P/fe49Tnttj4
         AYVzrcgnicPrr4DuudNkLjQBCQLFgXT/bs6rWr70rBn+UVExSoijEeh6FTj29+uzZbhE
         b2oq/w7nA/MifzcIxv2AqM7xNiDf+IQTUajuncaLEt6JdZnJZefNv5gHjtp6JzPterDl
         d4itcpWnQ67e040MBZPKcWustIq+ZC/1IUhpiOBSi0iZeuyD/fguAL+nSvrSk+X8EvF3
         dx4RqS+fNLw729JE/lkWpN2fgbvG8ahPtaXrT8lb3ConKx8jHs89KMCJ+FKYQ2TQGRCz
         N3zQ==
X-Gm-Message-State: AOJu0YxXTZdcy1UOtoqEv1w/k8RWtgSo+OIrUwbcTY+mI3RFMUKjCUBc
	hPKZaKfZ8Y3UtnAe2l+lUozTpxgpVJxc25fXNcTLE0WjFvjm1xp5+YFRL8Pb0UA=
X-Google-Smtp-Source: AGHT+IEwA7628dgDEojrPJKZcaWRkdXDMVfcaEMwo0MQ841nvQOXVWQHiOcW2yix4wc6h6yEoh7L0A==
X-Received: by 2002:a05:6214:aaf:b0:6c5:194a:4d7b with SMTP id 6a1803df08f44-6c52851138emr135105726d6.33.1725892254983;
        Mon, 09 Sep 2024 07:30:54 -0700 (PDT)
Received: from [127.0.1.1] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c534339987sm21385406d6.33.2024.09.09.07.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 07:30:54 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 09 Sep 2024 10:30:47 -0400
Subject: [PATCH v5 1/3] dt-bindings: iio: adc: add AD762x/AD796x ADCs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240909-ad7625_r1-v5-1-60a397768b25@baylibre.com>
References: <20240909-ad7625_r1-v5-0-60a397768b25@baylibre.com>
In-Reply-To: <20240909-ad7625_r1-v5-0-60a397768b25@baylibre.com>
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
 Trevor Gamblin <tgamblin@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.1

Add a binding specification for the Analog Devices Inc. AD7625,
AD7626, AD7960, and AD7961 ADCs.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
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


