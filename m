Return-Path: <linux-iio+bounces-11885-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEC59BAE7A
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 09:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2D111F22436
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 08:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3E21AB507;
	Mon,  4 Nov 2024 08:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lC5CSM6M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DC118C326;
	Mon,  4 Nov 2024 08:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730710107; cv=none; b=kUtEpR2rU3WGzPdEk+NK0tETFEPuJCw+gzQKqAsKQSRnfKjLOG94LagFGfW+iE5VyqLyywR9RkChd7l3gRSsFLJw23JNW/9fvj20PyjXqA22r0SdVs4ozWjnnpe/geRMHxCsBCQG1gDYMVK2CJjOFwryHS7FzLDxs/Wu3NTPbuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730710107; c=relaxed/simple;
	bh=ieeozOBoT/hUfxM6G/eG0PnBqvNCBtxvm9ZxZvgBzDA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PhpdbTqV3kJs0wANwU1HTGLYJodt7G8TkxLn26Em0ukjRBJpb1RF0GXGG0E9BKmhmyePIkSodTKO9X0KTq1jAWPNudu3MR+wmnMVlb3wKkdpW5EqAlqhOtDLEhg+UG4ebrVYhmTpzgRiR4mggLeIjWNanYIEcdITNrmpv5YRgC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lC5CSM6M; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a3dc089d8so667757766b.3;
        Mon, 04 Nov 2024 00:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730710104; x=1731314904; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8uUY2OJbWDGFjBu98yJDzgII+Ph2MDjiCrySpehdizA=;
        b=lC5CSM6MTdeYl2nXoq4S2n4c4nOEYW8Wz4uqTktQ0e2/3XODzSIahyLg6YMx8yQeaU
         MpQmEg9DEPH4xVeE1FsEgilNoAiXHu2IAc1wK5TCXg5kMQuS4W+6Pb38aiOMbHzI8kzR
         bNxaZHcGnuph6tZiqmO7ZLylYC5w3mO1CTIx35WmSEsgBEMvhBIUxoBYw+q7g9MnZEYi
         qPmcDRoumztjM4XxtxjPcIVWnwzbXG8+2JwUU5Mc4l2MUUXcHVoX4gxXzz2EMzw5beDs
         ZCyjBMuAaJkBsEMGNciQMdEViG2mxPzupS1QsEhhlhJYfBy6NkrBeK5xvn/LVwgYFIiO
         zjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730710104; x=1731314904;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8uUY2OJbWDGFjBu98yJDzgII+Ph2MDjiCrySpehdizA=;
        b=OdVzk9fDVJaNkwWpvRjnsK1e4s8vJ3u+tRlmLiUslLO+zzqljuPcrDlDD+lsdD7ftB
         7RXztWqCu9xwb7KiSAq/uJ7JlJkMT1Q1OiuoDa9zV53GRQjlw9BpydGSgOm7IeC7Id52
         YKGEmqSTgZ7WsBk4CBVAaMhaZiNYB9nz2p1N/USpq9Ibg15hpX1dDMbsWQDoq6VKVnU3
         Bg5htlvYTptdFT+Vkj8aFkxxZw+i10HzCnB4w6148QUeFigUoc59jvDZDUHuDIGBcH1Q
         pu3kA4FhJwqGr7/H1BvMpBeCquaD2FxZdUi9fSfYUkZJMNzA938RKzEKaaa3PlCZegyP
         eIgw==
X-Forwarded-Encrypted: i=1; AJvYcCX9JFMURt15CPtJJiqFe7PrBlYKCqx2cQvV175LldyfB/8g+Oyxz9Q8xT60A3cKgKKUXPv8t+vm5ucF@vger.kernel.org, AJvYcCXGLCNnFdI5HiSlZgMQGOhGiyC64SrsJEy8CUhCraYYK9AcXzg/9vR6e7KFAgQAkj67EaEuSGn8EDE=@vger.kernel.org, AJvYcCXNzh4+dCZDMIOywaWgLVijI8v0pXGO5ItrB/23sIAMsJQF0eDecUhi/B8xic8oa5BSPRA+jVM/0i+Cr+//@vger.kernel.org, AJvYcCXn0eVw6Ip4ilUrXHqftS9X3fXlq2mMLXMMi5oUtQvBUkmD130gxZWpCk9kvxER+tDJhfdFXiMFswiq5A==@vger.kernel.org, AJvYcCXwBn/9o3aeUE4jqXr+x4BqwLTTcGk0+O4e0pffEE7oHMcNOpQKCx2AFof31+7+we4Q9eWGFVX/KOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNAD2t7FGPieSb6+hm3pDMK4qZ7kNJbVIyvCG/crKZfAnRz5eb
	ZfJDIGpenE8JTi+3lLRw9tzOyGTmiKAwERQ9hfeW+JFb0Ih+QqEa
X-Google-Smtp-Source: AGHT+IEJwqUzuL45+dgEO8NTgngtB0dtDCqWv0IJVHc6vajNBf/y02YfSkzxVYc+hH2GATxC9pz2sg==
X-Received: by 2002:a17:906:f8d1:b0:a9e:6e77:3ecd with SMTP id a640c23a62f3a-a9e6e77407bmr887156966b.54.1730710103492;
        Mon, 04 Nov 2024 00:48:23 -0800 (PST)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e565df962sm522780166b.123.2024.11.04.00.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 00:48:23 -0800 (PST)
Date: Mon, 4 Nov 2024 09:48:21 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Sebastian Reichel <sre@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: mfd: sprd,sc2731: convert to YAML
Message-ID: <efd200c3b5b75405e4e450d064b026f10ae2f8e0.1730709384.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Convert the Spreadtrum SC27xx PMIC bindings to DT schema. Adjust the
filename to match the compatible of the only in-tree user, SC2731.
Change #interrupt-cells value to 1, as according to [1] that is the
correct value.
Move partial examples of child nodes in the child node schemas to this new
MFD schema to have one complete example.

[1] https://lore.kernel.org/lkml/b6a32917d1e231277d240a4084bebb6ad91247e3.1550060544.git.baolin.wang@linaro.org/

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Changes in V3:
- remove $ref to nvmem/sc2731-efuse and list the compatibles with
  additionalProperties: true (Krzysztof)

Changes in V2:
- rebase on next-20241029
- drop partial examples in child node schemas, move them here (Rob)

Link to V2: https://lore.kernel.org/lkml/ZyExK01iprBHhGm6@standask-GA-A55M-S2HP/
Link to V1: https://lore.kernel.org/lkml/Zr3X1RoQs7ElTnlJ@standask-GA-A55M-S2HP/

 .../bindings/iio/adc/sprd,sc2720-adc.yaml     |  17 --
 .../bindings/leds/sprd,sc2731-bltc.yaml       |  31 ---
 .../devicetree/bindings/mfd/sprd,sc2731.yaml  | 252 ++++++++++++++++++
 .../bindings/mfd/sprd,sc27xx-pmic.txt         |  40 ---
 .../bindings/power/supply/sc2731-charger.yaml |  21 +-
 .../bindings/power/supply/sc27xx-fg.yaml      |  38 +--
 .../regulator/sprd,sc2731-regulator.yaml      |  21 --
 .../bindings/rtc/sprd,sc2731-rtc.yaml         |  16 --
 8 files changed, 254 insertions(+), 182 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
index 8181cf9a8e07..a678323d78e3 100644
--- a/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml
@@ -80,23 +80,6 @@ required:
 additionalProperties: false
 
 examples:
-  - |
-    #include <dt-bindings/interrupt-controller/irq.h>
-    pmic {
-        #address-cells = <1>;
-        #size-cells = <0>;
-        adc@480 {
-            compatible = "sprd,sc2731-adc";
-            reg = <0x480>;
-            interrupt-parent = <&sc2731_pmic>;
-            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
-            #io-channel-cells = <1>;
-            hwlocks = <&hwlock 4>;
-            nvmem-cells = <&adc_big_scale>, <&adc_small_scale>;
-            nvmem-cell-names = "big_scale_calib", "small_scale_calib";
-        };
-    };
-
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
     pmic {
diff --git a/Documentation/devicetree/bindings/leds/sprd,sc2731-bltc.yaml b/Documentation/devicetree/bindings/leds/sprd,sc2731-bltc.yaml
index 5853410c7a45..97535d6dc47a 100644
--- a/Documentation/devicetree/bindings/leds/sprd,sc2731-bltc.yaml
+++ b/Documentation/devicetree/bindings/leds/sprd,sc2731-bltc.yaml
@@ -50,35 +50,4 @@ required:
   - '#size-cells'
 
 additionalProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/leds/common.h>
-
-    pmic {
-      #address-cells = <1>;
-      #size-cells = <0>;
-
-      led-controller@200 {
-        compatible = "sprd,sc2731-bltc";
-        reg = <0x200>;
-        #address-cells = <1>;
-        #size-cells = <0>;
-
-        led@0 {
-          reg = <0x0>;
-          color = <LED_COLOR_ID_RED>;
-        };
-
-        led@1 {
-          reg = <0x1>;
-          color = <LED_COLOR_ID_GREEN>;
-        };
-
-        led@2 {
-          reg = <0x2>;
-          color = <LED_COLOR_ID_BLUE>;
-        };
-      };
-    };
 ...
diff --git a/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml b/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
new file mode 100644
index 000000000000..8beec7e8e4c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
@@ -0,0 +1,252 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/sprd,sc2731.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Spreadtrum SC27xx PMIC
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+description: |
+  Spreadtrum PMICs belonging to the SC27xx series integrate all mobile handset
+  power management, audio codec, battery management and user interface support
+  functions in a single chip. They have 6 major functional blocks:
+    - DCDCs to support CPU, memory
+    - LDOs to support both internal and external requirements
+    - Battery management system, such as charger, fuel gauge
+    - Audio codec
+    - User interface functions, such as indicator, flash LED and so on
+    - IC level interface, such as power on/off control, RTC, typec and so on
+
+properties:
+  $nodename:
+    pattern: '^pmic@[0-9a-f]+$'
+
+  compatible:
+    enum:
+      - sprd,sc2720
+      - sprd,sc2721
+      - sprd,sc2723
+      - sprd,sc2730
+      - sprd,sc2731
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+  spi-max-frequency: true
+
+  '#address-cells':
+    const: 1
+
+  '#interrupt-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  regulators:
+    type: object
+    $ref: /schemas/regulator/sprd,sc2731-regulator.yaml#
+
+patternProperties:
+  "^adc@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/iio/adc/sprd,sc2720-adc.yaml#
+
+  "^charger@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/power/supply/sc2731-charger.yaml#
+
+  "^efuse@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        enum:
+          - sprd,sc2720-efuse
+          - sprd,sc2721-efuse
+          - sprd,sc2723-efuse
+          - sprd,sc2730-efuse
+          - sprd,sc2731-efuse
+
+  "^fuel-gauge@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/power/supply/sc27xx-fg.yaml#
+
+  "^gpio@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/gpio/sprd,gpio-eic.yaml#
+
+  "^led-controller@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/leds/sprd,sc2731-bltc.yaml#
+
+  "^rtc@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/rtc/sprd,sc2731-rtc.yaml#
+
+  "^vibrator@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/input/sprd,sc27xx-vibrator.yaml#
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+  - spi-max-frequency
+  - '#address-cells'
+  - '#interrupt-cells'
+  - '#size-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/leds/common.h>
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      sc2731_pmic: pmic@0 {
+        compatible = "sprd,sc2731";
+        reg = <0>;
+        interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-controller;
+        spi-max-frequency = <26000000>;
+        #address-cells = <1>;
+        #interrupt-cells = <1>;
+        #size-cells = <0>;
+
+        charger@0 {
+          compatible = "sprd,sc2731-charger";
+          reg = <0x0>;
+          phys = <&ssphy>;
+          monitored-battery = <&bat>;
+        };
+
+        led-controller@200 {
+          compatible = "sprd,sc2731-bltc";
+          reg = <0x200>;
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          led@0 {
+            reg = <0x0>;
+            color = <LED_COLOR_ID_RED>;
+          };
+
+          led@1 {
+            reg = <0x1>;
+            color = <LED_COLOR_ID_GREEN>;
+          };
+
+          led@2 {
+            reg = <0x2>;
+            color = <LED_COLOR_ID_BLUE>;
+          };
+        };
+
+        rtc@280 {
+          compatible = "sprd,sc2731-rtc";
+          reg = <0x280>;
+          interrupt-parent = <&sc2731_pmic>;
+          interrupts = <2>;
+        };
+
+        pmic_eic: gpio@300 {
+          compatible = "sprd,sc2731-eic";
+          reg = <0x300>;
+          interrupt-parent = <&sc2731_pmic>;
+          interrupts = <5>;
+          gpio-controller;
+          #gpio-cells = <2>;
+          interrupt-controller;
+          #interrupt-cells = <2>;
+        };
+
+        efuse@380 {
+          compatible = "sprd,sc2731-efuse";
+          reg = <0x380>;
+          hwlocks = <&hwlock 12>;
+          #address-cells = <1>;
+          #size-cells = <1>;
+
+          /* Data cells */
+          fgu_calib: calib@6 {
+            reg = <0x6 0x2>;
+            bits = <0 9>;
+          };
+
+          adc_big_scale: calib@24 {
+            reg = <0x24 0x2>;
+          };
+
+          adc_small_scale: calib@26 {
+            reg = <0x26 0x2>;
+          };
+        };
+
+        adc@480 {
+          compatible = "sprd,sc2731-adc";
+          reg = <0x480>;
+          interrupt-parent = <&sc2731_pmic>;
+          interrupts = <0>;
+          #io-channel-cells = <1>;
+          hwlocks = <&hwlock 4>;
+          nvmem-cells = <&adc_big_scale>, <&adc_small_scale>;
+          nvmem-cell-names = "big_scale_calib", "small_scale_calib";
+        };
+
+        fuel-gauge@a00 {
+          compatible = "sprd,sc2731-fgu";
+          reg = <0xa00>;
+          battery-detect-gpios = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
+          interrupt-parent = <&sc2731_pmic>;
+          interrupts = <4>;
+          io-channels = <&pmic_adc 5>, <&pmic_adc 14>;
+          io-channel-names = "bat-temp", "charge-vol";
+          nvmem-cells = <&fgu_calib>;
+          nvmem-cell-names = "fgu_calib";
+          monitored-battery = <&bat>;
+          sprd,calib-resistance-micro-ohms = <21500>;
+        };
+
+        vibrator@ec8 {
+          compatible = "sprd,sc2731-vibrator";
+          reg = <0xec8>;
+        };
+
+        regulators {
+          compatible = "sprd,sc2731-regulator";
+
+          BUCK_CPU0 {
+            regulator-name = "vddarm0";
+            regulator-min-microvolt = <400000>;
+            regulator-max-microvolt = <1996875>;
+            regulator-ramp-delay = <25000>;
+            regulator-always-on;
+          };
+
+          LDO_CAMA0 {
+            regulator-name = "vddcama0";
+            regulator-min-microvolt = <1200000>;
+            regulator-max-microvolt = <3750000>;
+            regulator-enable-ramp-delay = <100>;
+          };
+        };
+      };
+    };
+...
diff --git a/Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.txt b/Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.txt
deleted file mode 100644
index 21b9a897fca5..000000000000
--- a/Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.txt
+++ /dev/null
@@ -1,40 +0,0 @@
-Spreadtrum SC27xx Power Management Integrated Circuit (PMIC)
-
-The Spreadtrum SC27xx series PMICs contain SC2720, SC2721, SC2723, SC2730
-and SC2731. The Spreadtrum PMIC belonging to SC27xx series integrates all
-mobile handset power management, audio codec, battery management and user
-interface support function in a single chip. It has 6 major functional
-blocks:
-- DCDCs to support CPU, memory.
-- LDOs to support both internal and external requirement.
-- Battery management system, such as charger, fuel gauge.
-- Audio codec.
-- User interface function, such as indicator, flash LED and so on.
-- IC level interface, such as power on/off control, RTC and typec and so on.
-
-Required properties:
-- compatible: Should be one of the following:
-	"sprd,sc2720"
-	"sprd,sc2721"
-	"sprd,sc2723"
-	"sprd,sc2730"
-	"sprd,sc2731"
-- reg: The address of the device chip select, should be 0.
-- spi-max-frequency: Typically set to 26000000.
-- interrupts: The interrupt line the device is connected to.
-- interrupt-controller: Marks the device node as an interrupt controller.
-- #interrupt-cells: The number of cells to describe an PMIC IRQ, must be 2.
-- #address-cells: Child device offset number of cells, must be 1.
-- #size-cells: Child device size number of cells, must be 0.
-
-Example:
-pmic@0 {
-	compatible = "sprd,sc2731";
-	reg = <0>;
-	spi-max-frequency = <26000000>;
-	interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
-	interrupt-controller;
-	#interrupt-cells = <2>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-};
diff --git a/Documentation/devicetree/bindings/power/supply/sc2731-charger.yaml b/Documentation/devicetree/bindings/power/supply/sc2731-charger.yaml
index a846a4d14ca9..f5aa72502b4e 100644
--- a/Documentation/devicetree/bindings/power/supply/sc2731-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/sc2731-charger.yaml
@@ -30,23 +30,4 @@ properties:
       - constant-charge-voltage-max-microvolt: maximum constant input voltage.
 
 additionalProperties: false
-
-examples:
-  - |
-    bat: battery {
-      compatible = "simple-battery";
-      charge-term-current-microamp = <120000>;
-      constant-charge-voltage-max-microvolt = <4350000>;
-    };
-
-    pmic {
-      #address-cells = <1>;
-      #size-cells = <0>;
-
-      battery@a00 {
-        compatible = "sprd,sc2731-charger";
-        reg = <0x0>;
-        phys = <&ssphy>;
-        monitored-battery = <&bat>;
-      };
-    };
+...
diff --git a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml
index 9108a2841caf..9495397c9269 100644
--- a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml
+++ b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml
@@ -65,40 +65,4 @@ required:
   - monitored-battery
 
 additionalProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/gpio/gpio.h>
-    bat: battery {
-      compatible = "simple-battery";
-      charge-full-design-microamp-hours = <1900000>;
-      constant-charge-voltage-max-microvolt = <4350000>;
-      ocv-capacity-celsius = <20>;
-      ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>,
-                             <4022000 85>, <3983000 80>, <3949000 75>,
-                             <3917000 70>, <3889000 65>, <3864000 60>,
-                             <3835000 55>, <3805000 50>, <3787000 45>,
-                             <3777000 40>, <3773000 35>, <3770000 30>,
-                             <3765000 25>, <3752000 20>, <3724000 15>,
-                             <3680000 10>, <3605000 5>, <3400000 0>;
-                             // ...
-    };
-
-    pmic {
-      #address-cells = <1>;
-      #size-cells = <0>;
-
-      battery@a00 {
-        compatible = "sprd,sc2731-fgu";
-        reg = <0xa00>;
-        battery-detect-gpios = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
-        interrupt-parent = <&sc2731_pmic>;
-        interrupts = <4>;
-        io-channels = <&pmic_adc 5>, <&pmic_adc 14>;
-        io-channel-names = "bat-temp", "charge-vol";
-        nvmem-cells = <&fgu_calib>;
-        nvmem-cell-names = "fgu_calib";
-        monitored-battery = <&bat>;
-        sprd,calib-resistance-micro-ohms = <21500>;
-      };
-    };
+...
diff --git a/Documentation/devicetree/bindings/regulator/sprd,sc2731-regulator.yaml b/Documentation/devicetree/bindings/regulator/sprd,sc2731-regulator.yaml
index ffb2924dde36..9bd752bab68e 100644
--- a/Documentation/devicetree/bindings/regulator/sprd,sc2731-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/sprd,sc2731-regulator.yaml
@@ -43,25 +43,4 @@ required:
   - compatible
 
 additionalProperties: false
-
-examples:
-  - |
-    regulators {
-      compatible = "sprd,sc2731-regulator";
-
-      BUCK_CPU0 {
-        regulator-name = "vddarm0";
-        regulator-min-microvolt = <400000>;
-        regulator-max-microvolt = <1996875>;
-        regulator-ramp-delay = <25000>;
-        regulator-always-on;
-      };
-
-      LDO_CAMA0 {
-        regulator-name = "vddcama0";
-        regulator-min-microvolt = <1200000>;
-        regulator-max-microvolt = <3750000>;
-        regulator-enable-ramp-delay = <100>;
-      };
-    };
 ...
diff --git a/Documentation/devicetree/bindings/rtc/sprd,sc2731-rtc.yaml b/Documentation/devicetree/bindings/rtc/sprd,sc2731-rtc.yaml
index f3d20e976965..5756f617df36 100644
--- a/Documentation/devicetree/bindings/rtc/sprd,sc2731-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/sprd,sc2731-rtc.yaml
@@ -30,20 +30,4 @@ allOf:
   - $ref: rtc.yaml#
 
 unevaluatedProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/interrupt-controller/irq.h>
-
-    pmic {
-      #address-cells = <1>;
-      #size-cells = <0>;
-
-      rtc@280 {
-        compatible = "sprd,sc2731-rtc";
-        reg = <0x280>;
-        interrupt-parent = <&sc2731_pmic>;
-        interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
-      };
-    };
 ...
-- 
2.43.0


