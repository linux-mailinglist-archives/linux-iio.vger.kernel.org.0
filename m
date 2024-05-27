Return-Path: <linux-iio+bounces-5357-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FF68D0905
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 19:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487541F231D9
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 17:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632DD15F326;
	Mon, 27 May 2024 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYrkYm70"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6EE15A85F;
	Mon, 27 May 2024 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716829361; cv=none; b=hPfUldLlm07hVaV3vwQwCnC+WthLYYnSN62xQzETz3thQ0vkLwTV7yy7qV9YUuVUr0y6W6eauwU3Sbp0XAFiY4LsFKbKAKrWkv0LRHzSVxDiFvIgrI6Dwyq78paue6YeFnqGJWJJUkBIIOC51dGn3KVcWkfJJBXEAj/nPM8/Rd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716829361; c=relaxed/simple;
	bh=D7HFm8AUG04VbQUyxVJr0WSk84Tg1GR+2fxXqZXdOxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t4XLLFDp3mV1mrMvwCkhTMK6IEYuiNdpkb/8eNkkVDGsap5sc7uqETlEfduLpP9nvmXLVw/PQKUKTEsQKkYBLopFVYnYmcQNGLxQvWo8u8U1rSWRr9gs0JkjS8hka+CogvBBCYvlyEdnop/PgjPBFCS2s7N3pyf1CPAWvUB4gYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYrkYm70; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE90CC4AF08;
	Mon, 27 May 2024 17:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716829360;
	bh=D7HFm8AUG04VbQUyxVJr0WSk84Tg1GR+2fxXqZXdOxk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AYrkYm706wBpzhQ/gBLERTvpox3so1JMZSWIx4qSi2A5XhmcfE7MV7pm88aEvukyU
	 aVEsRNHOpNHtTmpO7TVGWds3Zxb6XBHVYf0SAFCxojzACKgoa8wOGtMBzJcxaayWxP
	 1/MklMOiOx5sN6aYa5bJaUPxOWVP7lL6EUl0T6lGQQPSjNFXowvKFndHerv8pMx7p+
	 Hv/3GwP6vbxzZa+k7wVW6NCgmf2zdgTH/hF/azMuCzzOkH6R8osPb+ZiBXflZ6Ax9n
	 qQuy38zRnrTJPggXNtydUDFF17G+8+zgqVUExkZkY7UmUm8mBxWJxDEA7DDbB7FyMh
	 x0ZIOXChRhatw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97412C25B78;
	Mon, 27 May 2024 17:02:40 +0000 (UTC)
From: Dumitru Ceclan via B4 Relay <devnull+dumitru.ceclan.analog.com@kernel.org>
Date: Mon, 27 May 2024 20:02:34 +0300
Subject: [PATCH v3 1/6] dt-bindings: adc: ad7173: add support for ad411x
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240527-ad4111-v3-1-7e9eddbbd3eb@analog.com>
References: <20240527-ad4111-v3-0-7e9eddbbd3eb@analog.com>
In-Reply-To: <20240527-ad4111-v3-0-7e9eddbbd3eb@analog.com>
To: Ceclan Dumitru <dumitru.ceclan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716829358; l=6275;
 i=dumitru.ceclan@analog.com; s=20240313; h=from:subject:message-id;
 bh=1wlr2he6NWLwHETQMfKvuBxqnB76wNWQ32VnB84HEfw=;
 b=vTzxYkwa9zI0HtMfB9xsqifGgN/WZjj48pt+23AfJ+HUyWSFb24JLQQP5ljYv+04azI5NtDMi
 hZ1UKXZLrFtB1N3DEgAziWJscJb3SKX0moKipQWtfG/YMHFjsMGkxVU
X-Developer-Key: i=dumitru.ceclan@analog.com; a=ed25519;
 pk=HdqMlVyrcazwoiai7oN6ghU+Bj1pusGUFRl30jhS7Bo=
X-Endpoint-Received: by B4 Relay for dumitru.ceclan@analog.com/20240313
 with auth_id=140
X-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
Reply-To: dumitru.ceclan@analog.com

From: Dumitru Ceclan <dumitru.ceclan@analog.com>

Add support for: AD4111, AD4112, AD4114, AD4115, AD4116.

AD411x family ADCs support a VCOM pin, dedicated for single-ended usage.
AD4111/AD4112 support current channels, usage is implemented by
 specifying channel reg values bigger than 15.

Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7173.yaml    | 122 ++++++++++++++++++++-
 1 file changed, 120 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
index ea6cfcd0aff4..5b1af382dad3 100644
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
@@ -129,10 +145,36 @@ patternProperties:
         maximum: 15
 
       diff-channels:
+        description: |
+          For using current channels specify select the current inputs
+           and enable the adi,current-channel property.
+
+          Family AD411x supports a dedicated VINCOM voltage input.
+          To select it set the second channel to 16.
+            (VIN2, VINCOM) -> diff-channels = <2 16>
+
+          There are special values that can be selected besides the voltage
+          analog inputs:
+            21: REF+
+            22: REF−
+          Supported only by AD7172-2, AD7172-4, AD7175-2, AD7175-8, AD7177-2:
+            19: ((AVDD1 − AVSS)/5)+
+            20: ((AVDD1 − AVSS)/5)−
+
         items:
           minimum: 0
           maximum: 31
 
+      single-channel:
+        description: |
+          Models AD4111 and AD4112 support single-ended current channels.
+          To select the desired current input, specify the desired input pair:
+            (IIN2+, IIN2−) -> single-channel = <2>
+
+        items:
+          minimum: 1
+          maximum: 16
+
       adi,reference-select:
         description: |
           Select the reference source to use when converting on
@@ -154,9 +196,26 @@ patternProperties:
           - avdd
         default: refout-avss
 
+      adi,current-channel:
+        description: |
+          Signal that the selected inputs are current channels.
+          Only available on AD4111 and AD4112.
+        type: boolean
+
+      adi,channel-type:
+        description:
+          Used to differentiate between different channel types as the device
+           register configurations are the same for all usage types.
+          Both pseudo-differential and single-ended channels will use the
+           single-ended specifier.
+        $ref: /schemas/types.yaml#/definitions/string
+        enum:
+          - single-ended
+          - differential
+        default: differential
+
     required:
       - reg
-      - diff-channels
 
 required:
   - compatible
@@ -166,7 +225,6 @@ allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
   # Only ad7172-4, ad7173-8 and ad7175-8 support vref2
-  # Other models have [0-3] channel registers
   - if:
       properties:
         compatible:
@@ -187,6 +245,37 @@ allOf:
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
 
@@ -210,6 +299,35 @@ allOf:
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
+            single-channel: false
+            adi,current-channel: false
+
   - if:
       anyOf:
         - required: [clock-names]

-- 
2.43.0



