Return-Path: <linux-iio+bounces-27236-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C34CCD1F9D
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 22:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C8293002167
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 21:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0195B3446AF;
	Fri, 19 Dec 2025 21:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="h5xDNzCY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391A42E8DEB
	for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 21:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766180013; cv=none; b=VJBkAkbroSfDed897tGxDbbz1eE2DtGDbGBLbC00TsOIIS7baydlpfDfnpSH/f2i72q73MJzX7Mf4grDrTgA2N4O2uF1MvrCq+9bEYjWo4pfrcVSP5xg4oMtcG/8iydrI8t0g/PFOxJRxWK2AQ9dCIscnPS6nrHgmGzroYROQv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766180013; c=relaxed/simple;
	bh=eXLLDXKfOA+2V2f1sRQNUzsvVCDsgch7yTVzmIc7Kfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yu++AwtJM9zul1IYvuclKF10Zsydy9B3oxIiWvZ/r5vcJRMtJwc6k7thQaX37aRO1jt6VpAl03J+Glggny7WYhWpk6vuDmVX1QtSgdLeeaxhIMJiFQpZ0JYcIAAJ4AmwR49KNcWdfc3Kzp2Yo7WQkGytGCKwG4pX/+m47IJUnCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=h5xDNzCY; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-45085a4ab72so1270476b6e.1
        for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 13:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766180009; x=1766784809; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CwhL2XTdSKphpbDNArSNYm/QFBPbMdsK+MdRobcyzN8=;
        b=h5xDNzCYa+kR/oZEZWzDXsu2VAju3tz9jqbZH4p16XSnK2vaFfv9RC4ETj2MfTg+7R
         d6JVlEAsiGiA7gSYYVW26FtqFYG48LYc0qVKQOIwDIUdPDJ3MRw899XtSBB0/JjeNrVH
         QQSqIc6K2BXHHMyuDyO6W5JtymoC6wNmfBiSScdRal11J+zzA74yky/gzm9U1aBbRj/L
         lvf/l2xeICZEyxWqk/r67rQUGapGB5Q4lNYLAlsZM9C4Xyg1suQa7VcS0lBES41XX7h8
         tq1/eFQWFse2jJZz7AblaEKkbbHlQpBruRAkbSAcO5mR86Y2YXaUuDRn77OglurseAHR
         Jc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766180009; x=1766784809;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CwhL2XTdSKphpbDNArSNYm/QFBPbMdsK+MdRobcyzN8=;
        b=KEBAQRHd06igPdvu519tjN3Cs6E7bYbcHJBJpzPF2e/RJJ1zeeRZPsp2XiddtQCMGU
         FBHTTZRqC/3j99LCOTgnq12kDS+0ErJL78LWyZRum/rtQATYjDf3RHKd1l1/8OmDJkLm
         hLdU+kKN42VphPjdC4u0OtfypjTOtEpgW+Dx/kqj+EOskjJsvgDmbM4oLr0Ihk2c/4lj
         ArYKzToB7pbu+TcBWfKQ2lnCsTiCoNV33ENT52KOyseNEKOji1zt9d4MornZL8nDn1k2
         jxi5FmETRXCgQ4PlqqNjzGVedFBXL5H9rma+H0KJhrpj/NsUxxBtuHj3jccS3tcHNwll
         LS3A==
X-Forwarded-Encrypted: i=1; AJvYcCWPOckLkk5f2A13CpNLgvZUFFIpP9EnUd/zg657B79XYYCQMzhCo8ZQQYo0/7vI+YtZpMnUJhwThbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwypdEimC/sv3T66E8cPHe7cLTai3oCPdt2IO6t5RU6nNb1IKCM
	I6/BfbJIc8UqtY2Q3haTxwgcIUO/6vcSdvgpBtuS3IMyfGOj39ntQ0uwlosqt1pSLKo=
X-Gm-Gg: AY/fxX42pkHNhP3HQHJkT3e0chf8iYSGnMSZ491Upyp1AHeX6RmCK7phOlpbYuWhl1S
	ASx4QpTG2bamsXAI672OKZg29o9x9a6/JCpHaFEfxRbMDWK0NvQkok68txRbR491d7rsvs392MT
	rykGmK1D4HDIF7n9js4U5PlcholKzLsJJmAGNiRzFO2qvCnyZgzt7keNYFxsKCbsJ98Xd2dymb0
	UHURCzVZjXyong9kiSRXaBzmHtDDxxYt/SeKcb5jj2DAfZ8lSfPiSS/hPKYtH1CtJyQeIDWurCF
	0KWKwWEgrrDxOF7dkFE/z73UM0505I/hNgmmvEpv2NtcaujNhLwve9b1gQ6WUGjANsFCLxL9st0
	XZw9V5Qa/AImtH7MKhVKebcIUlHOV2pmY6IA9jLNQOXJqdeCnN+3JmNdgTsHdItw5iv/1bQBPZC
	P6p5YgyIx1+dDjjA==
X-Google-Smtp-Source: AGHT+IHZJw+RiDLBmaeDbeQUFrqbDtSK1//gqrxlOK/7F319JCtYiEBVmJe2iut00bN7PQ7TNXN7GQ==
X-Received: by 2002:a05:6808:189e:b0:450:c877:fd5f with SMTP id 5614622812f47-457b200ba40mr2182741b6e.49.1766180009065;
        Fri, 19 Dec 2025 13:33:29 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:9b20:bac4:9680:435])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667563ffsm2485045a34.13.2025.12.19.13.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 13:33:28 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 19 Dec 2025 15:32:09 -0600
Subject: [PATCH v4 1/9] spi: dt-bindings: change spi-{rx,tx}-bus-width to
 arrays
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-spi-add-multi-bus-support-v4-1-145dc5204cd8@baylibre.com>
References: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
In-Reply-To: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9014; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=eXLLDXKfOA+2V2f1sRQNUzsvVCDsgch7yTVzmIc7Kfs=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpRcRqhY5V6vWS8QZzXn5TO9ZsSyacivD7iII1g
 aFHllTGzXWJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaUXEagAKCRDCzCAB/wGP
 wKTNCACM6BZcUhlLZs31DgYm4ylqfRE/65t20Nh62ANpb0i3H5ZSZEa+LB73pzj868YLQjlEYo/
 IEiz3BUDJdRjxh+Jc1hY7490TCgX9uLua7OCy88M58/i5SfTm/mFkmfSPJQ90vPciOLVWyO9G5d
 ++uOVWW8BHbx1Jy5/bMZnsNaTXS1kHDBCnM/VoSObk+8GYuY/UpKgZENTF3Cye1LF80HOQAs/Sz
 Mqgc645DVmGl2gP3qWifSinC+0Or2hjuwjuAoT7SZ9k6J8gr1M+ACfhL8WBEcNLSJJLrDPaaaZL
 /ZawSYElxndMZbmh6FBhDYyXuGKcx6mVg+3Z0LzxfslZ7tk+
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

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

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
 .../bindings/spi/nvidia,tegra210-quad.yaml         |  6 ++--
 .../bindings/spi/spi-peripheral-props.yaml         | 26 ++++++++++----
 7 files changed, 79 insertions(+), 17 deletions(-)

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
index 3b47b68b92cb..414f5bc36304 100644
--- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
@@ -77,10 +77,12 @@ patternProperties:
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


