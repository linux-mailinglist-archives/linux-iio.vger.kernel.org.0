Return-Path: <linux-iio+bounces-5918-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EED8FF19F
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 18:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E26761F25AE2
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 16:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6632E19884B;
	Thu,  6 Jun 2024 16:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HteBn5Jw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18758197A95;
	Thu,  6 Jun 2024 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690062; cv=none; b=kFxl7OkGKQKFNYCZ13GMuOi+pcRz/Njp73qY8WkRA5Iz3Qw2zLXW+8/bUNuZ0KYbAIVR97D3aj964rfqGq2jV7uDuGuuQ/Vw9MMs1r2KbPXyOqt1NHvSzCWiRfZboU3u28q+hXfLPYmXQUBCBUy7IG3+6tFHimpGWfhnITtWAlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690062; c=relaxed/simple;
	bh=vG7MiK5lwP9gTD7IW9Ex2zb2lCF5cVjPO4UKq3rUWGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KbDgS13jFXvt69vvIyHLkfCSMMnAYFt+H1IuRWLrVRFYTenw2Yr6uqKS1qCekzWqx/H7qLdiafn3n3ImQsvY5F2rKth4XD7n9wXXRXB/z14Qz6UkdZcwQc3fmUgPxO7XPyELU8kumqzDrJmoNg52YxXvGS382ewzxF7e3w/+6G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HteBn5Jw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3B58C32781;
	Thu,  6 Jun 2024 16:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717690061;
	bh=vG7MiK5lwP9gTD7IW9Ex2zb2lCF5cVjPO4UKq3rUWGM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HteBn5JwVFBJj0hth4xpsaxrPYwEZWEn3104Zbti+ovMuxW0X7C94HxizxQQm7ELM
	 RX/3Z/F2fIu03NZXM8TopqWdkbPW3zYJ4vky9ksUkfhSx+Ex3hnQI1gMKFutW+EoGm
	 e003WHA8ntERcW5UoLFuW+iff9xXvpYKCMhUTseMLxJtP04emLuWn1IzuI1Hfb6EvL
	 cc7A+hEzB9xxtWM9R0zkcKWZi3YtJPK/sklsBWzOM5MgieKiKRLsMOpJ56AATVODKR
	 CIS07Qj1NRDUc7wKPuJ4EJI5p9B712PEEnI/GciXfsRQNsgWf2D9rc5mlEFDDFlm/F
	 uTdxldu6nupPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DABC27C54;
	Thu,  6 Jun 2024 16:07:41 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Thu, 06 Jun 2024 19:07:41 +0300
Subject: [PATCH v6 2/9] dt-bindings: adc: ad7173: add support for ad411x
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240606-ad4111-v6-2-573981fb3e2e@analog.com>
References: <20240606-ad4111-v6-0-573981fb3e2e@analog.com>
In-Reply-To: <20240606-ad4111-v6-0-573981fb3e2e@analog.com>
To: Ceclan Dumitru <dumitru.ceclan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717690059; l=8769;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=xeEJYH2gvo+9v8BsizW6ZALFjkNIafLPtcaGba94JsM=;
 b=pk+qFOAtrWyG1+pBt8mk9pLvGJk4PGA7u/1Wz1Q0+zvC55sDiPvaYC/FxrRuGB/jvr8fQjI+e
 urRBEmTQCydA3xOJverCZuGKZKXDr3mLpHaY4UYujlohk4/vN63rp0w
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

Add support for: AD4111, AD4112, AD4114, AD4115, AD4116.

AD411x family ADCs support a VCOM pin. The purpose of this pin is to
offer a dedicated common-mode voltage input for single-ended channels.
This pin is specified as supporting a differential channel with VIN10 on
model AD4116.

AD4111/AD4112 support current channels. Support is implemented using
single-channel and "adi,current-channel".

Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7173.yaml    | 194 ++++++++++++++++++++-
 1 file changed, 192 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
index ea6cfcd0aff4..17c5d39cc2c1 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
@@ -19,7 +19,18 @@ description: |
   primarily for measurement of signals close to DC but also delivers
   outstanding performance with input bandwidths out to ~10kHz.
 
+  Analog Devices AD411x ADC's:
+  The AD411X family encompasses a series of low power, low noise, 24-bit,
+  sigma-delta analog-to-digital converters that offer a versatile range of
+  specifications. They integrate an analog front end suitable for processing
+  fully differential/single-ended and bipolar voltage inputs.
+
   Datasheets for supported chips:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4111.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4112.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4114.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4115.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4116.pdf
     https://www.analog.com/media/en/technical-documentation/data-sheets/AD7172-2.pdf
     https://www.analog.com/media/en/technical-documentation/data-sheets/AD7172-4.pdf
     https://www.analog.com/media/en/technical-documentation/data-sheets/AD7173-8.pdf
@@ -31,6 +42,11 @@ description: |
 properties:
   compatible:
     enum:
+      - adi,ad4111
+      - adi,ad4112
+      - adi,ad4114
+      - adi,ad4115
+      - adi,ad4116
       - adi,ad7172-2
       - adi,ad7172-4
       - adi,ad7173-8
@@ -129,10 +145,56 @@ patternProperties:
         maximum: 15
 
       diff-channels:
+        description: |
+          This property is used for defining the inputs of a differential
+          voltage channel. The first value is the positive input and the second
+          value is the negative input of the channel.
+
+          Family AD411x supports a dedicated VINCOM voltage input.
+          To select it set the second channel to 16.
+            (VIN2, VINCOM) -> diff-channels = <2 16>
+
+          There are special values that can be selected besides the voltage
+          analog inputs:
+            21: REF+
+            22: REF−
+
+          Supported only by AD7172-2, AD7172-4, AD7175-2, AD7175-8, AD7177-2,
+          must be paired together and can be used to monitor the power supply
+          of the ADC:
+            19: ((AVDD1 − AVSS)/5)+
+            20: ((AVDD1 − AVSS)/5)−
+
         items:
           minimum: 0
           maximum: 31
 
+      single-channel:
+        description: |
+          This property is used for defining a current channel or the positive
+          input of a voltage channel (single-ended or pseudo-differential).
+
+          Models AD4111 and AD4112 support current channels.
+            Example: (IIN2+, IIN2−) -> single-channel = <2>
+          To correctly configure a current channel set the "adi,current-channel"
+          property to true.
+
+          To configure a single-ended/pseudo-differential channel set the
+          "common-mode-channel" property to the desired negative voltage input.
+
+          When used as a voltage channel, special inputs are valid as well.
+        minimum: 0
+        maximum: 31
+
+      common-mode-channel:
+        description:
+          This property is used for defining the negative input of a
+          single-ended or pseudo-differential voltage channel.
+
+          Special inputs are valid as well.
+        minimum: 0
+        maximum: 31
+
       adi,reference-select:
         description: |
           Select the reference source to use when converting on
@@ -154,9 +216,31 @@ patternProperties:
           - avdd
         default: refout-avss
 
+      adi,current-channel:
+        $ref: /schemas/types.yaml#/definitions/flag
+        description: |
+          Signal that the selected inputs are current channels.
+          Only available on AD4111 and AD4112.
+
     required:
       - reg
-      - diff-channels
+
+    allOf:
+      - oneOf:
+          - required: [single-channel]
+            properties:
+              diff-channels: false
+          - required: [diff-channels]
+            properties:
+              single-channel: false
+              adi,current-channel: false
+              common-mode-channel: false
+
+      - if:
+          required: [common-mode-channel]
+        then:
+          properties:
+            adi,current-channel: false
 
 required:
   - compatible
@@ -166,7 +250,6 @@ allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
   # Only ad7172-4, ad7173-8 and ad7175-8 support vref2
-  # Other models have [0-3] channel registers
   - if:
       properties:
         compatible:
@@ -187,6 +270,37 @@ allOf:
                 - vref
                 - refout-avss
                 - avdd
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad4114
+              - adi,ad4115
+              - adi,ad4116
+              - adi,ad7173-8
+              - adi,ad7175-8
+    then:
+      patternProperties:
+        "^channel@[0-9a-f]$":
+          properties:
+            reg:
+              maximum: 15
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad7172-2
+              - adi,ad7175-2
+              - adi,ad7176-2
+              - adi,ad7177-2
+    then:
+      patternProperties:
+        "^channel@[0-9a-f]$":
+          properties:
             reg:
               maximum: 3
 
@@ -210,6 +324,34 @@ allOf:
           required:
             - adi,reference-select
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - adi,ad4111
+              - adi,ad4112
+              - adi,ad4114
+              - adi,ad4115
+              - adi,ad4116
+    then:
+      properties:
+        avdd2-supply: false
+
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              enum:
+                - adi,ad4111
+                - adi,ad4112
+    then:
+      patternProperties:
+        "^channel@[0-9a-f]$":
+          properties:
+            adi,current-channel: false
+
   - if:
       anyOf:
         - required: [clock-names]
@@ -221,6 +363,7 @@ allOf:
 unevaluatedProperties: false
 
 examples:
+  # Example AD7173-8 with external reference connected to REF+/REF-:
   - |
     #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>
@@ -277,3 +420,50 @@ examples:
         };
       };
     };
+
+  # Example AD4111 with current channel and single-ended channel:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+       adc@0 {
+        compatible = "adi,ad4111";
+        reg = <0>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+        interrupt-names = "rdy";
+        interrupt-parent = <&gpio>;
+        spi-max-frequency = <5000000>;
+        gpio-controller;
+        #gpio-cells = <2>;
+        #clock-cells = <0>;
+
+        channel@0 {
+          reg = <0>;
+          bipolar;
+          diff-channels = <4 5>;
+        };
+
+        // Single ended channel VIN2/VINCOM
+        channel@1 {
+          reg = <1>;
+          bipolar;
+          single-channel = <2>;
+          common-mode-channel = <16>;
+        };
+
+        // Current channel IN2+/IN2-
+        channel@2 {
+          reg = <2>;
+          single-channel = <2>;
+          adi,current-channel;
+        };
+      };
+    };

-- 
2.43.0



