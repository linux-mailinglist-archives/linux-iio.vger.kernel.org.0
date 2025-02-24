Return-Path: <linux-iio+bounces-15997-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E450EA41E47
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 13:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435883BDF68
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 11:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB3325A63D;
	Mon, 24 Feb 2025 11:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BU6xx4tl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B79525A2BF;
	Mon, 24 Feb 2025 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740397720; cv=none; b=eP/2G9Kqu0AnNHSp/slweHHGwFNl4c5vC0Hv8GFHncRxmfnbRAkkR0FgdNaxvayEydFShL+9B83ULCSWZsZyG4qbuYNFS4xm1aVlfglIs1I1LsbyQkoBx54J4xJxjIn2n0sletH/M0f+pcQMINpTGPwLKT3fO4bzDtQo8FnfpK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740397720; c=relaxed/simple;
	bh=8Wti5GM6Wjzt2pJAaHrcQOHnbYlpqmpl09h519dLUwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/j3DdK+TuwiO/AsAgkCox7divZYrbtPw2KpajX792KNanJB4a9ed8gTyuARG6xTWv9vb8dGkVqWkiLD5/09VbIkyYjlRIpv5jVWelk0fLIFhfC/2VVDaufUEl6JpqRJx+w8ykhvIKu9hr2oDxezfK9yLB37yk8rN6zVEuBqyg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BU6xx4tl; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5452c2805bcso4772776e87.2;
        Mon, 24 Feb 2025 03:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740397717; x=1741002517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MBhvZt4vjLDC8q/lcIhSmOcrM6PKUkGdN2T76L0AmI=;
        b=BU6xx4tltInqS9cjn4M7dK/ud/DPQPxnksAEUpU9E724r9BOObvviFsTwJVXZymVfT
         t5uS+DmX1HssOZUL1J1pKHgyueJi6TC4WDaapjC9ehhBf4UnevwG5POn85mcgGj8dFq8
         Pmc/cqs7KjCVQ0MwdxTT7BjIYdy6+HbNLRJjHuntwS0ITbEtnVi9EK1lFE3F1aSHw+4I
         bMVetTU8bk2FbmtDybQjxPyjQahwBbM+pj+QxtIp67Zp22xkVOC9cD/ogtQ60rxabjul
         Tbf7TyvVizQ6XKodiKb1bGodb986zeFBybaV0FwLfgLimCkN6ozoEBaGc7XBfGvkzwsx
         qwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740397717; x=1741002517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+MBhvZt4vjLDC8q/lcIhSmOcrM6PKUkGdN2T76L0AmI=;
        b=vUbqvVeMrbwfBUdt+DWIgedAtQyz+XOKlimZp1O69kJfZG4+6UblmTSpsbIhwQMKpV
         gSwwpglY6xGArUCmb9gk0daRDqYTM+7nJeOdM39U5y80+Q8m266bsHgHi7aoNwbBt7UY
         exuNwjYbE754HU/SvcctP/ynrMTqY5jSCiVXuHbYCkAkdYkdyv4dopB1xdyQ/MXhOnqe
         bEKScDIQ5waDO+ZWgyI2IEMNjGfJy7NYJGR/yYChxkv7VYUt8h30Nwzig8gpqoyw+a9k
         heA5OOetIULWfnN78Si0Ws3eGsUNFMXJzRCfNhQhM6kyx06781rrY9TEihgEP0YKs3fh
         0tKw==
X-Forwarded-Encrypted: i=1; AJvYcCUF64kpDP3qGzIh28kdTJ/q+Mrlr5V7jBAe5IuV6UWL7M2SLzjDHYIXzYMZUWJqtuRYId7QLBneV5Naog==@vger.kernel.org, AJvYcCVWjI+eeJgxdQU0pG4SY8Wcgct6z6e2pXqlF8ZBYKjcAW7vFd+F425M6bmn8hU7xj+XYrE4Qqm8UyKgJQ==@vger.kernel.org, AJvYcCXK0N568mwRU6ueWqEtV7jkN5x9+tLqbC2yesnREXguF5p6M9KolvpUveZVhYRB3TvDBML2PJtU8GSa@vger.kernel.org, AJvYcCXlNhOeAhv/zwnA0Hh22hjA2hwqarwwfiB2pfjUrV0khpKA5FGDVyl3TuftwtMxPS8UQ5UUj8g3hhx1YYLC@vger.kernel.org
X-Gm-Message-State: AOJu0YziH9gB3mUH+43YYKSAbjUtTVynkzF/MC8DduqTXe09SbxeY0Q1
	z+7/DFgj7SUI3cxPWtsauC/WoW2gAjCd2O3tA6/aqKHZDAQEt2f6
X-Gm-Gg: ASbGnctjbWjyO5YfgHtKdxLA353vMxyZYa/odgzG9XnML/nrfNYH+hSvrtlKj5A9MTm
	pyISkat+wIPUZB7wQl5tRd9zAtdZ9n+b+tX8tUOAGvgD1UQPSnT85sOsmBNR7kGJGdaAiQt9SPg
	N5AVuaQAQyu5laQYk0G4fMd5z1s7n83iKvCvZ5zNIQVW6DaAIjEAa951/5dpWueTJC+yDyv0Q89
	bUqELA8YcF+YaWDOwwvFHVQV8q1AR/86ZNjgFT8MEnp1SCva/+fhth+18UGDo28FL6g06aN6q+I
	5WiJdf5yPVvPnl5y
X-Google-Smtp-Source: AGHT+IH+HNPcxqMLKuJWsB6GW+NT134Jn0ypTXzkqAZNbymF35/Mv3onOVSc0hPbnddKKvR6W0yXaw==
X-Received: by 2002:a05:6512:ea1:b0:545:b49:f96d with SMTP id 2adb3069b0e04-54838d43b7emr4464873e87.0.1740397716315;
        Mon, 24 Feb 2025 03:48:36 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54526338bf9sm3167862e87.85.2025.02.24.03.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 03:48:35 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Pavel Machek <pavel@ucw.cz>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-leds@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: mfd: Document TI LM3533 MFD
Date: Mon, 24 Feb 2025 13:48:13 +0200
Message-ID: <20250224114815.146053-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224114815.146053-1-clamor95@gmail.com>
References: <20250224114815.146053-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add bindings for the LM3533 - a complete power source for backlight, keypad
and indicator LEDs in smartphone handsets. The high-voltage inductive boost
converter provides the power for two series LED strings display backlight
and keypad functions.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../devicetree/bindings/mfd/ti,lm3533.yaml    | 231 ++++++++++++++++++
 1 file changed, 231 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,lm3533.yaml

diff --git a/Documentation/devicetree/bindings/mfd/ti,lm3533.yaml b/Documentation/devicetree/bindings/mfd/ti,lm3533.yaml
new file mode 100644
index 000000000000..c8ac6d4424aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti,lm3533.yaml
@@ -0,0 +1,231 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ti,lm3533.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI LM3533 Complete Lighting Power Solution
+
+description: >
+  The LM3533 is a complete power source for backlight, keypad, and indicator LEDs
+  in smartphone handsets. The high-voltage inductive boost converter provides the
+  power for two series LED strings display backlight and keypad functions.
+
+  https://www.ti.com/product/LM3533
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+properties:
+  compatible:
+    const: ti,lm3533
+
+  reg:
+    maxItems: 1
+
+  enable-gpios:
+    description: GPIO to use to enable/disable the backlight (HWEN pin).
+    maxItems: 1
+
+  ti,boost-ovp-microvolt:
+    description:
+      Boost OVP select (16V, 24V, 32V, 40V)
+    enum: [ 16000000, 24000000, 32000000, 40000000 ]
+    default: 16000000
+
+  ti,boost-freq-hz:
+    description:
+      Boost frequency select (500KHz or 1MHz)
+    enum: [ 500000, 1000000 ]
+    default: 500000
+
+  light-sensor:
+    type: object
+    description:
+      Properties for an illumination sensor.
+    additionalProperties: false
+
+    properties:
+      compatible:
+        const: ti,lm3533-als
+
+      ti,resistor-value-ohm:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Internal configuration resister value when ALS is in Analog Sensor
+          mode and PWM mode is disabled.
+        minimum: 1575
+        maximum: 200000
+
+      ti,pwm-mode:
+        type: boolean
+        description:
+          Switch for mode in which ALS is running. If this propertly is set
+          then ALS is running in PWM mode, internal resistor value is set to
+          high-impedance (0) and resistor-value-ohm propertly is ignored.
+
+    required:
+      - compatible
+
+required:
+  - compatible
+  - reg
+  - enable-gpios
+  - light-sensor
+  - backlight-0
+  - backlight-1
+  - led-0
+  - led-1
+  - led-2
+  - led-3
+
+patternProperties:
+  "^backlight-[01]$":
+    type: object
+    description:
+      Properties for a backlight device.
+
+    $ref: /schemas/leds/backlight/common.yaml#
+
+    properties:
+      compatible:
+        const: ti,lm3533-backlight
+
+      default-brightness: true
+
+      ti,max-current-microamp:
+        description:
+          Maximum current in µA with a 800 µA step.
+        enum: [ 5000, 5800, 6600, 7400, 8200, 9000, 9800,
+                10600, 11400, 12200, 13000, 13800, 14600,
+                15400, 16200, 17000, 17800, 18600, 19400,
+                20200, 21000, 21800, 22600, 23400, 24200,
+                25000, 25800, 26600, 27400, 28200, 29000,
+                29800 ]
+        default: 5000
+
+      ti,pwm-config-mask:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Control Bank PWM Configuration Register mask that allows to configure
+          PWM input in Zones 0-4
+          BIT(0) - PWM Input is enabled
+          BIT(1) - PWM Input is enabled in Zone 0
+          BIT(2) - PWM Input is enabled in Zone 1
+          BIT(3) - PWM Input is enabled in Zone 2
+          BIT(4) - PWM Input is enabled in Zone 3
+          BIT(5) - PWM Input is enabled in Zone 4
+
+      ti,linear-mapping-mode:
+        description:
+          Enable linear mapping mode. If disabled, then it will use exponential
+          mapping mode in which the ramp up/down appears to have a more uniform
+          transition to the human eye.
+        type: boolean
+
+      ti,hardware-controlled:
+        description:
+          Each backlight has its own voltage Control Bank (A and B) and there are
+          two HVLED sinks which by default are linked to respective Bank. Setting
+          this property will link both sinks to a Control Bank of backlight where
+          property is defined.
+        type: boolean
+
+    required:
+      - compatible
+
+    additionalProperties: false
+
+  "^led-[0-3]$":
+    type: object
+    description:
+      Properties for a led device.
+
+    $ref: /schemas/leds/common.yaml#
+
+    properties:
+      compatible:
+        const: ti,lm3533-leds
+
+      linux,default-trigger: true
+
+      ti,max-current-microamp:
+        description:
+          Maximum current in µA with a 800 µA step.
+        enum: [ 5000, 5800, 6600, 7400, 8200, 9000, 9800,
+                10600, 11400, 12200, 13000, 13800, 14600,
+                15400, 16200, 17000, 17800, 18600, 19400,
+                20200, 21000, 21800, 22600, 23400, 24200,
+                25000, 25800, 26600, 27400, 28200, 29000,
+                29800 ]
+        default: 5000
+
+      ti,pwm-config-mask:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Same descryption and function as for backlight.
+
+    required:
+      - compatible
+
+    additionalProperties: false
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        led-controller@36 {
+            compatible = "ti,lm3533";
+            reg = <0x36>;
+
+            enable-gpios = <&gpio 110 GPIO_ACTIVE_HIGH>;
+
+            ti,boost-ovp-microvolt = <24000000>;
+            ti,boost-freq-hz = <500000>;
+
+            backlight-0 {
+                compatible = "ti,lm3533-backlight";
+
+                ti,max-current-microamp = <23400>;
+                default-brightness = <113>;
+                ti,hardware-controlled;
+            };
+
+            backlight-1 {
+                compatible = "ti,lm3533-backlight";
+                status = "disabled";
+            };
+
+            led-0 {
+                compatible = "ti,lm3533-leds";
+                status = "disabled";
+            };
+
+            led-1 {
+                compatible = "ti,lm3533-leds";
+                status = "disabled";
+            };
+
+            led-2 {
+                compatible = "ti,lm3533-leds";
+                status = "disabled";
+            };
+
+            led-3 {
+                compatible = "ti,lm3533-leds";
+                status = "disabled";
+            };
+
+            light-sensor {
+                compatible = "ti,lm3533-als";
+                status = "disabled";
+            };
+        };
+    };
+...
-- 
2.43.0


