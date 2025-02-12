Return-Path: <linux-iio+bounces-15423-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC3AA3207F
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 08:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF9D0160D69
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 07:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F43204C26;
	Wed, 12 Feb 2025 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLG/a4AB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03FC204699;
	Wed, 12 Feb 2025 07:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739347160; cv=none; b=PUl50wAbRecSPqpN5a5X5CMMJtcSEV6DOUdFaV0FcR7Uk4AXmyYkVjuM7SHuqEEvw4xTwYpm9KVAGeFzf8kmj6QC6+GuEAFXWyE8ML0iwchLoiLw1Z/PKHWsxncubTbK6xWycLLaEl2IcZFMAPv0oXP/yHuWRn/1IiMjNYpJ09Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739347160; c=relaxed/simple;
	bh=BpoTaVzl2mCpUcor7mHVXriGmR91XUBAff+pvoag5Js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bUshzdvV5AomvvFRD2J4MtAIqPKVInxcaH73/Lcb8iR73Gq2M1G43BsDrpdhn//AI2iiymxA/WjxLPXLd4GsdOzS+Z8OIz6ruoTtz8IC6eTn5y4VM33Lr1dbTO7H/t4A0psrPkHlBbqpsqSRStocvFccEdTeADzwPXUaC4d5deQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLG/a4AB; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5450d56199cso621390e87.1;
        Tue, 11 Feb 2025 23:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739347157; x=1739951957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmzH8tnBHTD3rBbOaj/wPbPUR7lc2Xqk0vuNMvFINeE=;
        b=FLG/a4ABTNVtTNnQ9SqzP5OVACT5rYYHGRVvMhx8C7WOfGY/MHsTT4j+GQahJhVD/0
         PsUYLheVOYnrfl5iBTlCGkE5j8b17wxdr89AAPcGADtYvQwJCArDDtb67tunp0bf+wqS
         uEftmcu85CGHc4Ubzjt7px9V9SAk5NIPQM9FNp5twlKykOgE7nAzOXk5Bu4a7ryyaezC
         cqosT3eVY1ruKM1TYf3vtkD6g0rUygVrqRZHrRsmvSkaLRet000Psl6Xf4AGhaXBUZUE
         AroTGkyYxYe55A2UlbYbV+hd4qNiMmEXnd6qf0cu2rRTibB5tHXA6HksS0uIbf7mdOjp
         Dl3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739347157; x=1739951957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmzH8tnBHTD3rBbOaj/wPbPUR7lc2Xqk0vuNMvFINeE=;
        b=dZVOUBQFMnfJLs8vjaBi/h9uR4biGcOVHli1YVQXlTL7T3GwxAFqHBO4nYVBm7QiaU
         7dhr8M0CLW1n4LV6jEcSYgXhQaygTAK7x06oPsHJcWHKr4OEb2xu0QQZMHteNHEH4+Lf
         UxZDSa64UVC3HH+PGGDCG6ZKNLm+wYhm8f+tjvJVrR3d7K6SNddtfm1lmj24GCcQb85b
         qD690LdYWaTwe4MIyq3mPlX5OXNwBi+ZH2YjFnuJUUoDEjAE9VZjbAbOyelDudW/FZ7o
         e4Tiq5iXOYOw73ccN8X0dZLmQlu9jWgRPMhy70S16/cZ8+IQ5sVa5JeX25Jc6pLwFhjP
         huKg==
X-Forwarded-Encrypted: i=1; AJvYcCVG+qDnXFCD2hAMM+2Y+kEtXF/LoT1LFlpUkdmZhs2AILR/JBuG++tQAnZhhh5YYjP83Dhp1Q3KpkQY@vger.kernel.org, AJvYcCWQ6dBvvQyBpds+6jljz8+yZkQkgfxq6yJIHKJVZd5kQ5mLz+vd3d6onAUsHRSQSz8Yv5fyyQ7kOsh9pC1Q@vger.kernel.org, AJvYcCXf6OPCpyJQxxxQqzYliJFEML/+oZ1g9NzU01W58dn7M4451H1ui10Yg4dlWHEzsoOdEI4umP1flBaPaQ==@vger.kernel.org, AJvYcCXlf7Ih9J9aGwfyi1a5Ob2HwO//DFhCAxs2z71d44+IZy1jqnh1RQtr2dbgCQo4aHmteusTbjH1qvJ5aw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJkuwG+OhcPb8nJt3FxsH8bEjhYYaj+5SjV7umcz5opqJrGzA0
	HZYT/NFQndsRKu/cWHhHsyoosr6kkKtNmSfrgr/soA2hUYvWM2Ac
X-Gm-Gg: ASbGncueZjC9bzXN3JjyQs1zYlqNNoR8yJrEoAyW2Zqs7IAMv3lGW+KFAQ3ciN4DBOD
	X/Sgz0rL21ZSjLEbfwbjvfj5SdsW6na295zVavpKtSk14du5JJxFX0S8UFzg/f2NXkAjCV48o2k
	CjsAC4SF27N7YFpxabwcZ60FILDS6E67DItDsKQuuYAOl9PjV9POs/f2U+9EBwS1zFaONO4qsNy
	q5x3A0sXWSl5ahkmV/9ur6IxpYqsssMp0i2irTL3zFXnZKS29bko7P1lxhpIyrl4X31xLqEZMCf
	9LeKFxg=
X-Google-Smtp-Source: AGHT+IFZyQAKWZrZ4MuAfWBuJ1NpOgrEWJgJh1slnsJM+BJw6witruaZKKjsQOfYThAg7/upxVhUtg==
X-Received: by 2002:a05:6512:3d88:b0:545:1065:117f with SMTP id 2adb3069b0e04-54511c71959mr2077959e87.17.1739347156597;
        Tue, 11 Feb 2025 23:59:16 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5441053eacfsm1797880e87.38.2025.02.11.23.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 23:59:16 -0800 (PST)
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
Subject: [PATCH v1 1/2] dt-bindings: mfd: Document TI LM3533 MFD
Date: Wed, 12 Feb 2025 09:58:41 +0200
Message-ID: <20250212075845.11338-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212075845.11338-1-clamor95@gmail.com>
References: <20250212075845.11338-1-clamor95@gmail.com>
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
 .../devicetree/bindings/mfd/ti,lm3533.yaml    | 221 ++++++++++++++++++
 include/dt-bindings/mfd/lm3533.h              |  19 ++
 2 files changed, 240 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,lm3533.yaml
 create mode 100644 include/dt-bindings/mfd/lm3533.h

diff --git a/Documentation/devicetree/bindings/mfd/ti,lm3533.yaml b/Documentation/devicetree/bindings/mfd/ti,lm3533.yaml
new file mode 100644
index 000000000000..d0307e5894f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ti,lm3533.yaml
@@ -0,0 +1,221 @@
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
+  - Johan Hovold <jhovold@gmail.com>
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
+  ti,boost-ovp:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Boost OVP select (16V, 24V, 32V, 40V)
+    enum: [ 0, 1, 2, 3 ]
+    default: 0
+
+  ti,boost-freq:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Boost frequency select (500KHz or 1MHz)
+    enum: [ 0, 1 ]
+    default: 0
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
+    properties:
+      compatible:
+        const: lm3533-backlight
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
+      max-current-microamp:
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
+      default-brightness:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Default brightness level on boot.
+        minimum: 0
+        maximum: 255
+        default: 255
+
+      pwm:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Default pwm level on boot.
+        minimum: 0
+        maximum: 63
+        default: 0
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
+    properties:
+      compatible:
+        const: lm3533-leds
+
+      reg:
+        description:
+          4 led banks
+        minimum: 0
+        maximum: 3
+
+      max-current-microamp:
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
+      default-trigger:
+        $ref: /schemas/types.yaml#/definitions/string
+        description: |
+          This parameter, if present, is a string defining
+          the trigger assigned to the LED. Check linux,default-trigger.
+
+      pwm:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Default pwm level on boot.
+        minimum: 0
+        maximum: 63
+        default: 0
+
+    required:
+      - compatible
+      - reg
+
+    additionalProperties: false
+
+  "^light-sensor@[0]$":
+    type: object
+    description:
+      Properties for an illumination sensor.
+
+    properties:
+      compatible:
+        const: lm3533-als
+
+      reg:
+        const: 0
+
+      resistor-value:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description: |
+          PWM resistor value a linear step in currents
+          of 10 µA per code based upon 2V/R_ALS.
+        minimum: 1
+        maximum: 127
+        default: 1
+
+      pwm-mode:
+        type: boolean
+        description: Mode in which ALS is running
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
+    #include <dt-bindings/mfd/lm3533.h>
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
+            ti,boost-ovp = <LM3533_BOOST_OVP_24V>;
+            ti,boost-freq = <LM3533_BOOST_FREQ_500KHZ>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            backlight@0 {
+                compatible = "lm3533-backlight";
+                reg = <0>;
+
+                max-current-microamp = <23400>;
+                default-brightness = <113>;
+                pwm = <0x00>;
+            };
+        };
+    };
+...
diff --git a/include/dt-bindings/mfd/lm3533.h b/include/dt-bindings/mfd/lm3533.h
new file mode 100644
index 000000000000..929988190c52
--- /dev/null
+++ b/include/dt-bindings/mfd/lm3533.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * This header provides macros for TI LM3533 device bindings.
+ */
+
+#ifndef _DT_BINDINGS_MFD_LM3533_H
+#define _DT_BINDINGS_MFD_LM3533_H
+
+/* LM3533 boost freq */
+#define LM3533_BOOST_FREQ_500KHZ	0
+#define LM3533_BOOST_FREQ_1000KHZ	1
+
+/* LM3533 boost ovp */
+#define LM3533_BOOST_OVP_16V		0
+#define LM3533_BOOST_OVP_24V		1
+#define LM3533_BOOST_OVP_32V		2
+#define LM3533_BOOST_OVP_40V		3
+
+#endif
-- 
2.43.0


