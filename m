Return-Path: <linux-iio+bounces-15729-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B194A39D99
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 14:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A6783A9DE0
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 13:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C3E26A1A6;
	Tue, 18 Feb 2025 13:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEdOFgGE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A437269881;
	Tue, 18 Feb 2025 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885247; cv=none; b=oYXOMoFqLXMjovq6mUDUUBvWT6l1zLrCl4GoYLecmgu0YI/etNs83EU8FF2jYa8XoZgFOQcW58WNZQuMH38+C8loZPH9bf4j14OMPSoX960JRPm0wrZl8Dkso3qIukkEdqaAXPrvMO6wMlxZUxH+654BgvOxa9SP/w4/O1VvoxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885247; c=relaxed/simple;
	bh=zwTJFheisvQd1LkpImKMVz0iqvOi+KCShNIUE6MmLc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jApN5vohn7nys32j45h83dv9ZxtjJilQG92+PnF1Kp7h7Xzdi599bO19Uu27i2ScLaEFPxzTTALruend548oq8u8+wL0C/Zdl3W8vLW+0AP/xKHZwsO7K3GgOqD/E1i4bkeghSyZcH1KEDeneQzBkRlNTjNcyxWWdeYSF8qwrMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEdOFgGE; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30762598511so52074221fa.0;
        Tue, 18 Feb 2025 05:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739885243; x=1740490043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JcY0j5/3e6cwhup+7TTVg+eO1rssFDj9P+AQ5rPw/gQ=;
        b=JEdOFgGEqTl6TWsUmOo3OGZ4PRGlKQzJ8gMq04AsS+JO+MLNCeTxnm+q0Y33+M1xUu
         54S6awCItWSC+slLDFlRns5wMNYKQ3UWav+ZEvDiIE/u/LITHld0h4Xz8vYo8zVRXPBO
         sSHoBeHcjp1XQalRwEWmjGhw2FbMZ3qUisC1GcgzZfxbtcumgEnowqib3gZu5CM7odjV
         J7Ba3nacaa+IcONd7h3ixfCKhHyiU/dJii9Pi0ciRgyLOCvje/dshOHRPiYuLFQG0xxG
         PCI+7paVFLnwimGu1hWVARvOWk7dT/6UM4lDSfKkNyhNL2/lFZOcmuDnr1gsCpgmUH/E
         58cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739885243; x=1740490043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JcY0j5/3e6cwhup+7TTVg+eO1rssFDj9P+AQ5rPw/gQ=;
        b=TpJOyrzPCRp1NC6mqJ4aMGNHtCmm9viW1DNnUsrexGA3FtFM2Zi193kp45hThqZGKV
         QRXuQj7V8STmtYhlmFhfCHhXUwSSdnM635951/JG0dpRgXKhlYtn/Z03WM1L6/g3zIgl
         wfm1LtZ0DHBfxhvEWcI+hwcplNePhX7PYWR1FL/hRk3APdyhUrRQVYk1B/7jMzP3ILKq
         N6NUKt2viwlm3erX0jvxtnmJYiMzUW+wZaOyttQTTCWHuvnUTBr3c8Z1A9Q1RoSUqGSn
         zbxynU6TJzC2ysL8MCX5N/EQD44+JTwhwSJnbOyNhmbCuQ6up9qeSdNBsK7nsNmQVC4U
         xYlA==
X-Forwarded-Encrypted: i=1; AJvYcCUxLFXYhwCAFFTM4l4ZGUcRR47FP0tS0xCQG9+gI8oGpyyeZtD4GIJuy+tT/SlOq0ZPGuC8cptfLmXoqJLg@vger.kernel.org, AJvYcCVB/ZKM9Gm3a7KYmmRYoucrmgvIeVES+cupO6M4x37AWnLA5KpXHrFMaeAHlqGSOGiTGqtXejIu6IR/1w==@vger.kernel.org, AJvYcCVO5aaD5MY5bKrQIpTcjgv2zj50LhKkKBLQOCBCGgGfgWSW0Mwbv6eI3qISnmEURJCERgKC7aEDr/7P@vger.kernel.org, AJvYcCWIR6hbJXJPiFz/JOd13nX43GgNK6IAquan7s/RlyrAdY62kAKVaQlmRgXoYluYGQ1fgJdDq8hXde3low==@vger.kernel.org
X-Gm-Message-State: AOJu0YzC5Ur/CbZZO2hrt9nZNyTgmZY42sw4pI7igrwMJ84kgPxgFYtg
	vdidjvjEzIL7MlTQ1gABWQiN5kTcVoUtVsbvQsDI8qNThXlEqras
X-Gm-Gg: ASbGnctxSTjXSVjSyKtFJ4U061AYf7S6gE9J9CjpUEIjqEu0rlIXq1UzH//tKY0Mf0M
	bNLY7q0hJMWbzcJOt451nnHoWeMJLLF8EGRi+TGqs2jNRfn+baKOq5MSpAEupzWnrbiYGBMsQSG
	oVKCHY+l2fm+1wpWbW6EJ1F23Ecp3fRsFwjU4Da7R8cXz6/FbRy0Aw6aOXrDS1jiurn9e+sY208
	+H9NfM15eDg39ICOWWSd+gm2kQsh2gwYEXiGkQwoAfRA/lUiOgD6ZlmOXN6+zhm09DtKibw1cma
	o9CaW0U=
X-Google-Smtp-Source: AGHT+IG7tPc6iGrk3gZc+02r/zA9o519WXklYX8dI8yKaw0rkGB2udrfLJPL+83phxgroT7H/mERbQ==
X-Received: by 2002:a2e:9f54:0:b0:2fa:d2c3:a7e8 with SMTP id 38308e7fff4ca-30927a474a1mr38564601fa.13.1739885242803;
        Tue, 18 Feb 2025 05:27:22 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30917da0e64sm18300851fa.88.2025.02.18.05.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 05:27:22 -0800 (PST)
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
Subject: [PATCH v2 1/2] dt-bindings: mfd: Document TI LM3533 MFD
Date: Tue, 18 Feb 2025 15:26:59 +0200
Message-ID: <20250218132702.114669-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218132702.114669-1-clamor95@gmail.com>
References: <20250218132702.114669-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add bindings for the LM3533 - a complete power source for
backlight, keypad, and indicator LEDs in smartphone handsets.
The high-voltage inductive boost converter provides the
power for two series LED strings display backlight and keypad
functions.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../devicetree/bindings/mfd/ti,lm3533.yaml    | 231 ++++++++++++++++++
 1 file changed, 231 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,lm3533.yaml

diff --git a/Documentation/devicetree/bindings/mfd/ti,lm3533.yaml b/Documentation/devicetree/bindings/mfd/ti,lm3533.yaml
new file mode 100644
index 000000000000..83542f0c7bf7
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
+description: |
+  The LM3533 is a complete power source for backlight,
+  keypad, and indicator LEDs in smartphone handsets. The
+  high-voltage inductive boost converter provides the
+  power for two series LED strings display backlight and
+  keypad functions.
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
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
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
+  light-sensor@0:
+    type: object
+    description:
+      Properties for an illumination sensor.
+
+    properties:
+      compatible:
+        const: ti,lm3533-als
+
+      reg:
+        const: 0
+
+      ti,resistor-value-ohm:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          Internal configuration resister value when ALS is in Analog Sensor
+          mode and PWM mode is disabled.
+        minimum: 1575
+        maximum: 200000
+
+      ti,pwm-mode:
+        type: boolean
+        description: |
+          Switch for mode in which ALS is running. If this propertly is
+          set then ALS is running in PWM mode, internal resistor value is
+          set to high-impedance (0) and resistor-value-ohm propertly is
+          ignored.
+
+    required:
+      - compatible
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - '#address-cells'
+  - '#size-cells'
+  - enable-gpios
+
+patternProperties:
+  "^backlight@[01]$":
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
+      reg:
+        description: |
+          The control bank that is used to program the two current sinks. The
+          LM3533 has two control banks (A and B) and are represented as 0 or 1
+          in this property. The two current sinks can be controlled
+          independently with both banks, or bank A can be configured to control
+          both sinks with the led-sources property.
+        minimum: 0
+        maximum: 1
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
+        description: |
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
+        description: |
+          Enable linear mapping mode. If disabled, then it will use exponential
+          mapping mode in which the ramp up/down appears to have a more uniform
+          transition to the human eye.
+        type: boolean
+
+      ti,hardware-controlled:
+        description: |
+          Each backlight has its own voltage Control Bank (A and B) and there are
+          two HVLED sinks which by default are linked to respective Bank. Setting
+          this property will link both sinks to a Control Bank of backlight where
+          property is defined.
+        type: boolean
+
+    required:
+      - compatible
+      - reg
+
+    additionalProperties: false
+
+  "^led@[0-3]$":
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
+      reg:
+        description:
+          4 led banks
+        minimum: 0
+        maximum: 3
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
+      - reg
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
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            backlight@0 {
+                compatible = "ti,lm3533-backlight";
+                reg = <0>;
+
+                ti,max-current-microamp = <23400>;
+                default-brightness = <113>;
+                ti,hardware-controlled;
+            };
+        };
+    };
+...
-- 
2.43.0


