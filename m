Return-Path: <linux-iio+bounces-27645-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B09CD14836
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 18:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71F41303804B
	for <lists+linux-iio@lfdr.de>; Mon, 12 Jan 2026 17:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A066130F938;
	Mon, 12 Jan 2026 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k2ijrkZq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8220302CAB
	for <linux-iio@vger.kernel.org>; Mon, 12 Jan 2026 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768239991; cv=none; b=UB4mX1JfS9UxAfw5Rt7x7hFS6glN4ssjlBry2G4LecNr00ohxAc0LXOvL3ItJpSX7tp/7Z2snYZcT6hVglIDSO47ZOoi6yF4CV1CXlh+BsYUegZ2QR6c1wO86QaWBJ1Z7Y3+RBgULWz3IrnFCQp5QhVyBOI6D1An5Z3J3DnFKJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768239991; c=relaxed/simple;
	bh=OXT0WKHU2BPah6p4qCMyGsEBDF/aYZm3K7NFH7mMQRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tZbkJBkb12u1/9eXoBydHysaGElcqA3ZDkKs8JgdPU0bVFrC+ZHvDy6AQgFwDno1Wev39ja8HEWl6HHQvd/KkV6/JWT2bZu9JLgqIfY2CLGTlVynn6tupGSsXZLLgJRinjPomhsGAIwFxpDJO5TFufitIYqbqBFVs2ifGM+kFlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=k2ijrkZq; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-45391956bfcso4939762b6e.3
        for <linux-iio@vger.kernel.org>; Mon, 12 Jan 2026 09:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768239988; x=1768844788; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nsW1I87ikqp3p9mbh+4t5p+N4vk12hLCFTGYmOODa8w=;
        b=k2ijrkZq2iWKTt3alnSPnpqMNwc4hCzo+l/XjKDPauS+Udom7IVeWrA2J2wP7S2oZo
         dcR3pSH55pVxPqUOifodr8J3+R/NgOxyZAv2RYqxdE1hI7yzKHCXPOB77WjRZq1qYSxz
         Zb7+g5qIBCJl4qpj0Cfl7Q4nTucss7SF1urnW6VMOBK0xn8n2M/uXlegnDTCqOpe2xkS
         RNMnTESfgKgV+4HsCqnyu8R1LK/r2KAvkvXn9QtkHtBbrUPJSbYs39DBkUZtbzOrr83/
         H0yya/bfHcbmVtwxYMpBnDtIwV62SgwenTbZX1TWITYt7eFZ1yQzccK8g0AUNc8w/q8z
         OUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768239988; x=1768844788;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nsW1I87ikqp3p9mbh+4t5p+N4vk12hLCFTGYmOODa8w=;
        b=wfO4oNVXHI2eb6OCcE0noe2p1tjLvZeycAr7o2PKoNH8usPaQ/NgdBcXCiFBudUbyO
         qE4PE0rhq7duMPV4aR+sDqXE1XOm3QO2UPinoKoXj3Wxk05l0vzoiOA36AQVv+fdUEAr
         bMO95xz1PExZpIn37JFBE8MIxmbsW4/42npkxHOlf97hjAbY2B5X0YpCDnLL0PW/tvwb
         s72BUOZGLfIepquDqjbaRD2YKX2uWKGNdWTTcl+lywYkejpF+Rny+mXEB9VBbn2m0mmQ
         lWGEEZtebVVEo5OzwnQm5ogS/8zmoAlySW4iKqi3slRx8OSuFYjT/jpLHvJ+mzRAoqJ2
         lnOw==
X-Forwarded-Encrypted: i=1; AJvYcCWOSAWeq3FUg6YyWPbO1lGe+SqPKJCGhs2dPQWPpISOPR/Kc6WDkZgXKhH/gKzJLQIV3OpJibyoMVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjMM+d+ELA/6LjcbJvh3YpB0g0Zj0KUU4y/FFE2uhFsUboKHxO
	wCjOszvGxzVTT4rjVjOJn5tIHfSKo0Pjc0GEJPDAh5NTu5/PUxuJL1TgmiuPNGEcBKo=
X-Gm-Gg: AY/fxX6Cpw+hNqESmCf2EvOfbPQZK1NpuO9uQn9JR7TqyFbZqkGFGI6JxAGEm8l6fcd
	N8KXpsn8IS1b3fXG5dW6tOg+XjFsXoiLHa9k/wX/Ak8rRYVL4Iec6cBmgH4ovbbwEbndT/phJ7v
	eR2qMI+p5/VdJq9cmgsoENT1/5INgmeJfpx7q3/WN7mkVX/sUhGCHKfUytAgCm/M5uvAsGdCYWx
	y31x3z/g+5yLjbQfWHgQGldzSRzmRz7lHUWj9UGrVEJaagJPp0f0PtWo7TX38nxk1JTwhqqCizW
	DcXr4W4s080nz/RcKTKNvwz6Uc2UM3NqMAOp6yfvikwSkvTa4eheFhOs9csrsnRfHAbpkIpdBUe
	BGg+pFo+ZViTUX6YvGWXAoNfQ7BacVmoqu76eYcunihvXcaFRx5QDWl9XxZyM2MR+0xHxKp1M7t
	F+byNDd0F4+jjNlKJaT4HFFBDs5w==
X-Google-Smtp-Source: AGHT+IFrSiFX3KCioNEjQyYyYFvw/MXTdGiJ8hVws7UYrAIKguVYd0s/UbtKXB4RbX5DpUY2Cf6G/g==
X-Received: by 2002:a05:6808:152a:b0:43b:252e:f793 with SMTP id 5614622812f47-45a6be89f90mr8830207b6e.36.1768239988625;
        Mon, 12 Jan 2026 09:46:28 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:6b4b:49b3:cce5:b58f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4de40bfsm12126941fac.5.2026.01.12.09.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 09:46:28 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 12 Jan 2026 11:45:19 -0600
Subject: [PATCH v5 1/9] spi: dt-bindings: change spi-{rx,tx}-bus-width to
 arrays
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-spi-add-multi-bus-support-v5-1-295f4f09f6ba@baylibre.com>
References: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
In-Reply-To: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9946; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=OXT0WKHU2BPah6p4qCMyGsEBDF/aYZm3K7NFH7mMQRo=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpZTM4EcyE8Js93v0bq03ud4Q6874yBG/kkrfd4
 mhxEJ7MNAqJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaWUzOAAKCRDCzCAB/wGP
 wFYUB/43Z5x1OlxX5sgJaSde4FrI33rVNDqauG0Tzs+khQEHaXuqUniKY4j+B3naAd874LMr5cR
 uxu8mNJyryQYNypm2u1xHyXSBywDbc79s1mrjl6p3+81OuFoGT0gfpxF+a1hF+Suo8wLKjT9XZw
 50I7JfK9dBAj8VaJ4JoVM4UEUcehj3p2LErbiQyEB8J/6hPD2OTlDoB1GXTpMWK8fqspI6XQIhN
 3NIm5rQrRo7nVa0UHn7ltkTLhC3WiUARb3thaS1mZ1coyX6HPtTGT1cR+4DjldhhpDvQCWKmbXj
 uRNpDm1P+HaFYuq8rzzKgUSu8oOQe77+4P48siaxFJ2VXz7n
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Change spi-rx-bus-width and spi-tx-bus-width properties from single
uint32 values to arrays of uint32 values. This allows describing SPI
peripherals connected to controllers that have multiple data lanes for
receiving or transmitting two or more words in parallel.

Each index in the array corresponds to a physical data lane (one or more
wires depending on the bus width). Additional mapping properties will be
needed in cases where a lane on the controller or peripheral is skipped.

Bindings that make use of this property are updated in the same commit
to avoid validation errors.

The adi,ad4030 binding can now better describe the chips multi-lane
capabilities, so that binding is refined and gets a new example.

Converting from single uint32 to array of uint32 does not break .dts/
.dtb files since there is no difference between specifying a single
uint32 value and an array with a single uint32 value in devicetree.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v5 changes:
- Added change for andestech,ae350-spi.yaml (recently new file).

v4 changes:
- New patch to replace data-lanes property patch.

In v3, Rob suggested possibly splitting the spi-controller.yaml file
to have a way to make most SPI controllers have maxItems: 1 for these
properties. I would like to avoid that because it doesn't seem scalable,
e.g. if we need another similar split in the future, the number of
combinations would grow exponentially (factorially?). I have an idea to
instead do this using $dynamicAnchor and $dynamicRef, but dt-schema
doesn't currently support that. So I propose we do the best we can for
now with the current dt-schema and make further improvements later.

Also, in v3, I suggested that we could have leading 0s in the arrays
to indicate unused lanes. But after further consideration, I think it's
better to have separate lane-mapping properties for that purpose. It
will be easier to explain and parse and be a bit more flexible that way.
---
 .../bindings/display/panel/sitronix,st7789v.yaml   |  5 +--
 .../devicetree/bindings/iio/adc/adi,ad4030.yaml    | 42 +++++++++++++++++++++-
 .../devicetree/bindings/iio/adc/adi,ad4695.yaml    |  5 +--
 .../bindings/spi/allwinner,sun4i-a10-spi.yaml      |  6 ++--
 .../bindings/spi/allwinner,sun6i-a31-spi.yaml      |  6 ++--
 .../bindings/spi/andestech,ae350-spi.yaml          |  6 ++--
 .../bindings/spi/nvidia,tegra210-quad.yaml         |  6 ++--
 .../bindings/spi/spi-peripheral-props.yaml         | 26 ++++++++++----
 8 files changed, 83 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
index 0ce2ea13583d..c35d4f2ab9a4 100644
--- a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
@@ -34,8 +34,9 @@ properties:
   spi-cpol: true
 
   spi-rx-bus-width:
-    minimum: 0
-    maximum: 1
+    items:
+      minimum: 0
+      maximum: 1
 
   dc-gpios:
     maxItems: 1
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
index 54e7349317b7..e22d518135f2 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
@@ -37,7 +37,15 @@ properties:
     maximum: 102040816
 
   spi-rx-bus-width:
-    enum: [1, 2, 4]
+    maxItems: 2
+    # all lanes must have the same width
+    oneOf:
+      - contains:
+          const: 1
+      - contains:
+          const: 2
+      - contains:
+          const: 4
 
   vdd-5v-supply: true
   vdd-1v8-supply: true
@@ -88,6 +96,18 @@ oneOf:
 
 unevaluatedProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - adi,ad4030-24
+            - adi,ad4032-24
+    then:
+      properties:
+        spi-rx-bus-width:
+          maxItems: 1
+
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
@@ -108,3 +128,23 @@ examples:
             reset-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
         };
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad4630-24";
+            reg = <0>;
+            spi-max-frequency = <80000000>;
+            spi-rx-bus-width = <4>, <4>;
+            vdd-5v-supply = <&supply_5V>;
+            vdd-1v8-supply = <&supply_1_8V>;
+            vio-supply = <&supply_1_8V>;
+            ref-supply = <&supply_5V>;
+            cnv-gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
index cbde7a0505d2..ae8d0b5f328b 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
@@ -38,8 +38,9 @@ properties:
   spi-cpha: true
 
   spi-rx-bus-width:
-    minimum: 1
-    maximum: 4
+    items:
+      minimum: 1
+      maximum: 4
 
   avdd-supply:
     description: Analog power supply.
diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml
index e1ab3f523ad6..a34e6471dbe8 100644
--- a/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/allwinner,sun4i-a10-spi.yaml
@@ -55,10 +55,12 @@ patternProperties:
           maximum: 4
 
       spi-rx-bus-width:
-        const: 1
+        items:
+          - const: 1
 
       spi-tx-bus-width:
-        const: 1
+        items:
+          - const: 1
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
index 1b91d1566c95..a6067030c5ed 100644
--- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
@@ -81,10 +81,12 @@ patternProperties:
           maximum: 4
 
       spi-rx-bus-width:
-        const: 1
+        items:
+          - const: 1
 
       spi-tx-bus-width:
-        const: 1
+        items:
+          - const: 1
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml b/Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml
index 78093468dd5e..8e441742cee6 100644
--- a/Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml
@@ -45,10 +45,12 @@ patternProperties:
 
     properties:
       spi-rx-bus-width:
-        enum: [1, 4]
+        items:
+          - enum: [1, 4]
 
       spi-tx-bus-width:
-        enum: [1, 4]
+        items:
+          - enum: [1, 4]
 
 allOf:
   - $ref: spi-controller.yaml#
diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
index 8b3640280559..909c204b8adf 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
@@ -54,10 +54,12 @@ patternProperties:
 
     properties:
       spi-rx-bus-width:
-        enum: [1, 2, 4]
+        items:
+          - enum: [1, 2, 4]
 
       spi-tx-bus-width:
-        enum: [1, 2, 4]
+        items:
+          - enum: [1, 2, 4]
 
 required:
   - compatible
diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 8b6e8fc009db..59ddead7da14 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -64,9 +64,16 @@ properties:
     description:
       Bus width to the SPI bus used for read transfers.
       If 0 is provided, then no RX will be possible on this device.
-    $ref: /schemas/types.yaml#/definitions/uint32
-    enum: [0, 1, 2, 4, 8]
-    default: 1
+
+      Some SPI peripherals and controllers may have multiple data lanes for
+      receiving two or more words at the same time. If this is the case, each
+      index in the array represents the lane on both the SPI peripheral and
+      controller. Additional mapping properties may be needed if a lane is
+      skipped on either side.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      enum: [0, 1, 2, 4, 8]
+    default: [1]
 
   spi-rx-delay-us:
     description:
@@ -81,9 +88,16 @@ properties:
     description:
       Bus width to the SPI bus used for write transfers.
       If 0 is provided, then no TX will be possible on this device.
-    $ref: /schemas/types.yaml#/definitions/uint32
-    enum: [0, 1, 2, 4, 8]
-    default: 1
+
+      Some SPI peripherals and controllers may have multiple data lanes for
+      transmitting two or more words at the same time. If this is the case, each
+      index in the array represents the lane on both the SPI peripheral and
+      controller. Additional mapping properties may be needed if a lane is
+      skipped on either side.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    items:
+      enum: [0, 1, 2, 4, 8]
+    default: [1]
 
   spi-tx-delay-us:
     description:

-- 
2.43.0


