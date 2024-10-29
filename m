Return-Path: <linux-iio+bounces-11572-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5CE9B5259
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 20:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B84C6B21575
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 19:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D20206E72;
	Tue, 29 Oct 2024 19:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3+dYzof"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A691FF7CC;
	Tue, 29 Oct 2024 19:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730228532; cv=none; b=S2jad8ykngJ90j1CB8piPA42xatrn6jSZMLjf4iWcGA9umtaS2VpAZsRgpOjym19x+6lgU00Kg2FNz/a1fii7kjC6Ae8UscW6WED5julpoXWqzrlLLRw9LTtj+/QPxMi5F6iuIiqAzJdnjbkJrjTmxuX4mRKq0c9wH01bfoLpzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730228532; c=relaxed/simple;
	bh=qiRr4zMUO4tQzO2veSpGbHnSfMoPvHWCVCMpHl6lJKo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ldg9QoB1v1+og8p1WqE/fTMsQXSMQlnE5PQvcCgm2llTfiG2dMeJwm+RD29o0evOyts/f0oUXlHCGfa7rVjWfhz0I4nq49L4DmaxqpqrXwqqLOL6B0dOatB/u+wDkifwW7f4YJBgW6FNNutQtVoECebtrHWbR3X4M3ZSWaEf0vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3+dYzof; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539fb49c64aso9632340e87.0;
        Tue, 29 Oct 2024 12:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730228527; x=1730833327; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8BRnl1K9qrfeUJRYg2fRD26W4VpCBVnP5tqx6Abse5I=;
        b=R3+dYzofMJi1U9r7TAqMqY67/+PRmWZSugemCjBm96MLpqgMtV4jATW3iWiq3Nvox7
         5/etBcFFQfQL5AgMG3F+SWpTxQDZ4D/2uhQFc6Iqc54e7Moca/XykGf/RXQKjE6H2bfI
         0qzHqFprlBBvd1UXl+uGNRc2vROelkpJHE68SYTSiq7j9O/y1tNWh0AQqdmdAqrScF8A
         dFPZd7oZv8EhnJwbZU1KJ1d5Q6WQWmsatJ7mIJ+kmJ7p+f3SWCVkeTi2cVnKnMMCXGvq
         QxnZDTUvqff3O4/0aGX+j6f0mShp3LbcX1M7dZtvqUWGyVCJMorY0JFJuaMVltaParsU
         CpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730228527; x=1730833327;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8BRnl1K9qrfeUJRYg2fRD26W4VpCBVnP5tqx6Abse5I=;
        b=CMcZlXREx5rLAfEqluTRqq/+II1Fbl7n9h1RNMiOotxI8uK89qH7mb1FzXfFItfRZE
         qb4X5ABlFAI26C2xv8BXBp+PmJ+lJL3IdPx2lq1qhUsnIW0rWprHw+ucVw6mTqF51sei
         MzrEZ47huwCXsj77B/JYANoqtUMkWnGvHPSm8HvbH+ZYitmobu67Q44388iKdSGQf+Qe
         60mT9AluDoi750ZwfJS1PhmhDNk7/QJMNTjGsnRVVPt5gdj+wcK7fnp+18TWkGyFUoRH
         YfOxNFshU415u5+nYxBJdnHcW1ygPO4sSWFkzrrkrGrWAJsLRxfYk45i3JpDD2Ow8Qn/
         gY8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVsfe2oM/FY3IqLZ51wR/jtXUnRbLn9ApjSB0PX5YFwjKzM9uHAd7Rtk8ais9MkTIQvwmls9TmgnSIS@vger.kernel.org, AJvYcCWaAyJO9ciBcqxPAHsRyScZgDiVo2C57TnxtuykZojE7nFZ9ZqQpdvUO604lFCGOrYmW/U8f4p9A2c=@vger.kernel.org, AJvYcCWmyw7XNtJSjuNZZCUxnh+Teq+Nyzi9X36sOdxdAN8lu79x1S9/1IGRdCNVUfm21AfB8BfI6rKmWGY=@vger.kernel.org, AJvYcCWuczqwulgxD+0BPupXxbUVNm+IQb2BOkwAasuC4df7AiANGAjLuSxoZ/Koe8jwzVjUt+0KRfV+Mh6K9wYK@vger.kernel.org, AJvYcCXZChi63NIMvGNZWceUK6Dx3JQb9/PARscj3RvuEvHlzqThpKAoLYtizeI7B0+mTV4nWtHl3eT751+Otg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxleoTFv6/YJ+AhpjK0XYP3NEJtN36uH4Aic4dridptC3HQjM8e
	KR3Q1furAGuR83IcHUh0L52Hk471K4I3oBOKDtSH8Pljo3zQlAOg
X-Google-Smtp-Source: AGHT+IETpTd6DodC7/CwUoZDrpTJTnHgIGsU8ylgGTl/SrmcPfw7hANqf+fGnfAliIFMLhL1a0bklA==
X-Received: by 2002:a05:6512:1256:b0:535:6a34:b8c3 with SMTP id 2adb3069b0e04-53b348b9fecmr9492620e87.5.1730228526638;
        Tue, 29 Oct 2024 12:02:06 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f299099sm499292166b.101.2024.10.29.12.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 12:02:06 -0700 (PDT)
Date: Tue, 29 Oct 2024 20:02:03 +0100
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
Subject: [PATCH v2] dt-bindings: mfd: sprd,sc2731: convert to YAML
Message-ID: <ZyExK01iprBHhGm6@standask-GA-A55M-S2HP>
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
Changes in V2:
- rebase on next-20241029
- drop partial examples in child node schemas, move them here (Rob)

Link to V1: https://lore.kernel.org/lkml/Zr3X1RoQs7ElTnlJ@standask-GA-A55M-S2HP/

 .../bindings/iio/adc/sprd,sc2720-adc.yaml     |  17 --
 .../bindings/leds/sprd,sc2731-bltc.yaml       |  31 ---
 .../devicetree/bindings/mfd/sprd,sc2731.yaml  | 244 ++++++++++++++++++
 .../bindings/mfd/sprd,sc27xx-pmic.txt         |  40 ---
 .../bindings/nvmem/sprd,sc2731-efuse.yaml     |  29 ---
 .../bindings/power/supply/sc2731-charger.yaml |  21 +-
 .../bindings/power/supply/sc27xx-fg.yaml      |  38 +--
 .../regulator/sprd,sc2731-regulator.yaml      |  21 --
 .../bindings/rtc/sprd,sc2731-rtc.yaml         |  16 --
 9 files changed, 246 insertions(+), 211 deletions(-)
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
index 000000000000..bd5f2504b44b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
@@ -0,0 +1,244 @@
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
+    $ref: /schemas/nvmem/sprd,sc2731-efuse.yaml#
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
diff --git a/Documentation/devicetree/bindings/nvmem/sprd,sc2731-efuse.yaml b/Documentation/devicetree/bindings/nvmem/sprd,sc2731-efuse.yaml
index dc25fe3d1841..8672bde24a9b 100644
--- a/Documentation/devicetree/bindings/nvmem/sprd,sc2731-efuse.yaml
+++ b/Documentation/devicetree/bindings/nvmem/sprd,sc2731-efuse.yaml
@@ -36,33 +36,4 @@ allOf:
   - $ref: nvmem-deprecated-cells.yaml#
 
 unevaluatedProperties: false
-
-examples:
-  - |
-    pmic {
-      #address-cells = <1>;
-      #size-cells = <0>;
-
-      efuse@380 {
-        compatible = "sprd,sc2731-efuse";
-        reg = <0x380>;
-        hwlocks = <&hwlock 12>;
-        #address-cells = <1>;
-        #size-cells = <1>;
-
-        /* Data cells */
-        fgu_calib: calib@6 {
-          reg = <0x6 0x2>;
-          bits = <0 9>;
-        };
-
-        adc_big_scale: calib@24 {
-          reg = <0x24 0x2>;
-        };
-
-        adc_small_scale: calib@26 {
-          reg = <0x26 0x2>;
-        };
-      };
-    };
 ...
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


