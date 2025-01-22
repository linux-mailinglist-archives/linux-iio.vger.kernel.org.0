Return-Path: <linux-iio+bounces-14530-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF89A19270
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2025 14:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 631981621E1
	for <lists+linux-iio@lfdr.de>; Wed, 22 Jan 2025 13:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC0F21325D;
	Wed, 22 Jan 2025 13:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7o61hpD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1876E21323E;
	Wed, 22 Jan 2025 13:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737552547; cv=none; b=k8R7RWFHE9UubL6SI/D7MrBrJhz8DTUntUtShbNTkJlZOGxAsK4ajc/ldpQepBG8g820G9xf68+mgqEFmhTROsbTXa9HJa1OgRG8SJAluKQYAasJXHjvHiLz2KUrZOFzL2zcAl4d3H7jCTCaaQTCcU4GD5kp7n7rPveeWtGs0TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737552547; c=relaxed/simple;
	bh=6Ug6MY3Fyk/PIG0Fsi/EPISNogWR5drYtfGYqiRV/TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTSVOPiuJGG++D2dpWIYCBiCQAQ2a65fJpeqi8I0lQ5G9ofkfb+NGw+k7qWFh2nWrA/0fh2IS16Utf1iIUsqHhBKew8i6Wxn5Kx4Y/J0qrP/NEMc6IE8jVVSxMw3BMoqa4sRWVgaLSsfdquv8DZq9ZJjYrFsExTvCMhHbswhpYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7o61hpD; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385eed29d17so3677164f8f.0;
        Wed, 22 Jan 2025 05:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737552543; x=1738157343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkqX9VAHdNzzFhb9yX2jyhz14c5QFySAR6IZ3g5wTS4=;
        b=f7o61hpDdrv0OUr6RH27Kfigzz370FjyiO1fBW7QOiA/jzzFf19OHgvIClEIPm2cTG
         kNBRu1OL9750H7LD/ZH19u7t9qRuwGR2pwXym+IJP8UfqNTYuKe8zl+kOjQeiD6nsw28
         ZoGj/fweqa13DPeVutEpZ4AMMkKBYLrEed+XfdQeKCYFb+PdlIVV+Tm4a0VwbwEKoViF
         q0QoAlqlARtqFHxUhhYTBgvHJc4qhb2z1I49EIyhtxKEfyRLnnp588Gl3ePoBizBOq2f
         B5omeCAcZtg91P+v1EGfyWKQTUvB5E5EhBFWEeLIKH4+b4zvs/tASZGgQbhtMPWuitTI
         Hi5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737552543; x=1738157343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkqX9VAHdNzzFhb9yX2jyhz14c5QFySAR6IZ3g5wTS4=;
        b=Bs+Nbj8B1bYbhvckBAb00C7GlLyz0SgS0V7VEwYVSUeGyE1o6xr8yQl62uqf4ZmKeV
         p182zZmi4JYydxzuvw69a06r2MMS6eLa84O94oPyN8+Aq8DyOdLmjnEflc9DKSpZ1f3Q
         QvgdraI+CRPQAJ7dOFA/WNIEw5AYrFNg/nEfB1cymfXJ7nsbZxMpWbqTUh7arze2Lc6b
         8sHBu18Yi8PFoVVKOzhqaCC9PPRT6x0eX545fqQaRjhTIX2EKpwMCJu+mFaBk/rFS3iA
         k7hcCY6F4DGU8Eo4QmdpDiN3VGGYuJFyq6KPsV5AFm0YnbYPwbS6glNHGHHlbhJGgpjq
         LASw==
X-Forwarded-Encrypted: i=1; AJvYcCUeGFXLh/9qw+Q8lC0VPdiFleDCQoe7HERsd5YdeABG8mG48Es+YNTgMeMPZH8yeQbzwc/b+8pLIEOA@vger.kernel.org, AJvYcCVWo10EsUPi9vZWsQlLANFD3WOlcHyFneDshTIcCYXnNe/o0PnBMIN3V7BlkXnTz90MhcjKTcHGfzsVFw==@vger.kernel.org, AJvYcCW1uJif3/I85JRfn+HqRzMMEU7TvgCjeRQ3a1GiSdyEvMqHiCyOpr/4bFZMld9oUjpGuaQVUn+BpW/E@vger.kernel.org, AJvYcCW2lvdjFLqXmgKjkqhjSZRDOr8HKXOFuHXyAVCc0MoaGcjn1bATlQ4uAz0eRslVqbhPO3BRVl+ey44MDMoO@vger.kernel.org
X-Gm-Message-State: AOJu0YzivgGmaTGvGUo8AkLpaVpOxvW5GTZGyXemCzdSfFWREE9t/IbI
	Jw1pbQM+bjyhlNHf5SgONK+g4xw2qb9T0NbAnuWcbUdMIwUc05M0
X-Gm-Gg: ASbGnctdZGU+K87DVI2bifR+MSKW9qV98DOVwHwP0YAaqxJMxndl+2A+0R73LHw66Eg
	yA4cwJ8W+72pT6ZmmRwaLb06CgM477t0H1IOaoKoLAP3kNDOgq/TArpMx8o2Or4FFpW+GVIWy9u
	pcHIZceVGE1r/NEV+fyq6Wrs3kPNQ7ymndFhyx3bZEMB9Gqj89krpLzjpJXlK1paLE0m9IwMJ+2
	0oNxpB0I0dm9PCOOz9JjE7VhLKGAVbcBsurhTYWjn0Ol6lpSFO0LsA40c8jAFyI
X-Google-Smtp-Source: AGHT+IHuEp/y8/sgTl9R4+sCJRzVqDSsedgCxpfcG/bGMbsC+6eEBthY6D7NeW0q8qzOV3J0FzNJ7A==
X-Received: by 2002:a05:6000:1888:b0:385:fb59:8358 with SMTP id ffacd0b85a97d-38bf57bd745mr17502043f8f.53.1737552543038;
        Wed, 22 Jan 2025 05:29:03 -0800 (PST)
Received: from spiri.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf328847esm16481241f8f.98.2025.01.22.05.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 05:29:02 -0800 (PST)
From: Alisa-Dariana Roman <alisadariana@gmail.com>
X-Google-Original-From: Alisa-Dariana Roman <alisa.roman@analog.com>
To: Alisa-Dariana Roman <alisa.roman@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 1/2] dt-bindings: iio: adc: add AD7191
Date: Wed, 22 Jan 2025 15:20:39 +0200
Message-ID: <20250122132821.126600-2-alisa.roman@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122132821.126600-1-alisa.roman@analog.com>
References: <20250122132821.126600-1-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AD7191 is a pin-programmable, ultralow noise 24-bit sigma-delta ADC
designed for precision bridge sensor measurements. It features two
differential analog input channels, selectable output rates,
programmable gain, internal temperature sensor and simultaneous
50Hz/60Hz rejection.

Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
---
 .../bindings/iio/adc/adi,ad7191.yaml          | 175 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 182 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml
new file mode 100644
index 000000000000..c0a6bed7a9cb
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml
@@ -0,0 +1,175 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2025 Analog Devices Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/adi,ad7191.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7191 ADC device driver
+
+maintainers:
+  - Alisa-Dariana Roman <alisa.roman@analog.com>
+
+description: |
+  Bindings for the Analog Devices AD7191 ADC device. Datasheet can be
+  found here:
+  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7191.pdf
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7191
+
+  reg:
+    maxItems: 1
+
+  spi-cpol: true
+
+  spi-cpha: true
+
+  clocks:
+    maxItems: 1
+    description:
+      Optionally, either a crystal can be attached externally between MCLK1 and
+      MCLK2 pins, or an external CMOS-compatible clock can drive the MCLK2
+      pin. If absent, internal 4.92MHz clock is used.
+
+  interrupts:
+    maxItems: 1
+
+  avdd-supply:
+    description: AVdd voltage supply
+
+  dvdd-supply:
+    description: DVdd voltage supply
+
+  vref-supply:
+    description: Vref voltage supply
+
+  odr-gpios:
+    description: |
+      ODR1 and ODR2 pins for output data rate selection. Should be defined if
+      adi,odr-state is absent.
+    maxItems: 2
+
+  adi,odr-state:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Should be present if ODR pins are pin-strapped. Value corresponds to:
+      0: 120 Hz (ODR1=0, ODR2=0)
+      1: 60 Hz (ODR1=0, ODR2=1)
+      2: 50 Hz (ODR1=1, ODR2=0)
+      3: 10 Hz (ODR1=1, ODR2=1)
+      If defined, odr-gpios must be absent.
+    enum: [0, 1, 2, 3]
+
+  pga-gpios:
+    description: |
+      PGA1 and PGA2 pins for gain selection. Should be defined if adi,pga-state
+      is absent.
+    maxItems: 2
+
+  adi,pga-state:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Should be present if PGA pins are pin-strapped. Value corresponds to:
+      0: Gain 1 (PGA1=0, PGA2=0)
+      1: Gain 8 (PGA1=0, PGA2=1)
+      2: Gain 64 (PGA1=1, PGA2=0)
+      3: Gain 128 (PGA1=1, PGA2=1)
+      If defined, pga-gpios must be absent.
+    enum: [0, 1, 2, 3]
+
+  temp-gpios:
+    description: TEMP pin for temperature sensor enable.
+    maxItems: 1
+
+  chan-gpios:
+    description: CHAN pin for input channel selection.
+    maxItems: 1
+
+  clksel-gpios:
+    description: |
+      Clock source selection pin (internal or external). Should be defined if
+      clksel-config is absent.
+    maxItems: 1
+
+  adi,clksel-state:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Should be present if CLKSEL is pin-strapped. 0 selects an external clock,
+      1 selects the internal clock. If defined, clksel-gpios must be absent.
+    enum: [0, 1]
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - avdd-supply
+  - dvdd-supply
+  - vref-supply
+  - spi-cpol
+  - spi-cpha
+  - temp-gpios
+  - chan-gpios
+
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      required:
+        - adi,odr-state
+    then:
+      properties:
+        odr-gpios: false
+    else:
+      required:
+        - odr-gpios
+  - if:
+      required:
+        - adi,pga-state
+    then:
+      properties:
+        pga-gpios: false
+    else:
+      required:
+        - pga-gpios
+  - if:
+      required:
+        - adi,clksel-state
+    then:
+      properties:
+        clksel-gpios: false
+    else:
+      required:
+        - clksel-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad7191";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            spi-cpol;
+            spi-cpha;
+            clocks = <&ad7191_mclk>;
+            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-parent = <&gpio>;
+            avdd-supply = <&avdd>;
+            dvdd-supply = <&dvdd>;
+            vref-supply = <&vref>;
+            odr-gpios = <&gpio 23 GPIO_ACTIVE_HIGH>, <&gpio 24 GPIO_ACTIVE_HIGH>;
+            pga-gpios = <&gpio 5 GPIO_ACTIVE_HIGH>, <&gpio 6 GPIO_ACTIVE_HIGH>;
+            temp-gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
+            chan-gpios = <&gpio 27 GPIO_ACTIVE_HIGH>;
+            clksel-gpios = <&gpio 13 GPIO_ACTIVE_HIGH>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 98a3c1e46311..262beced3143 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1302,6 +1302,13 @@ W:	http://ez.analog.com/community/linux-device-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r*
 F:	drivers/iio/adc/ad7091r*
 
+ANALOG DEVICES INC AD7191 DRIVER
+M:	Alisa-Dariana Roman <alisa.roman@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad7191.yaml
+
 ANALOG DEVICES INC AD7192 DRIVER
 M:	Alisa-Dariana Roman <alisa.roman@analog.com>
 L:	linux-iio@vger.kernel.org
-- 
2.43.0


