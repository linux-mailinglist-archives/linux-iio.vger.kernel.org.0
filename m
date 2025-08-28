Return-Path: <linux-iio+bounces-23342-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E267FB3AD17
	for <lists+linux-iio@lfdr.de>; Thu, 28 Aug 2025 23:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9A5E7B8ECA
	for <lists+linux-iio@lfdr.de>; Thu, 28 Aug 2025 21:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97922D0C9D;
	Thu, 28 Aug 2025 21:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EdNbhx+y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B492C08D6
	for <linux-iio@vger.kernel.org>; Thu, 28 Aug 2025 21:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756418135; cv=none; b=r4279NAnGYJBmHooQRZXhGpUVX50uiqtXkEe7RZdtdEKw+/Y4jWYUjXI1vhSMQ6hXHw9Oicj7q/tjO7LEjNw67ieaEpu8ciz0HNaOeL0KjpoNViK9NtvxJbJc5w8t/HY2vbu5G65sHmjjV6s/a68qcXD1L9HLPygSvy99sKDu0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756418135; c=relaxed/simple;
	bh=ejiW++p+A0I9xjvm23IuPsPQ6EO4iCmJb+R47NFoGFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aM/j7eQNAe49yU4EUQs1xSVPg9V2Fs7mL5Hj8ZRUzyfUJ6+H/3XNn3Wn4tGuiufBhWY9z0GQuvxKFCsuo667iG/UYMgGJnlD+O7ho7BFhSsuCyxyXoNequfB2dAF94fEeUru9/urwoChQMPQgv8hmYa7wHdSDKpwxewg5SrmMCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EdNbhx+y; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7454a992f7dso892770a34.3
        for <linux-iio@vger.kernel.org>; Thu, 28 Aug 2025 14:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756418131; x=1757022931; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mCS1blGVKzhibBa+GC93mJ6dY0HkTwPO0389IUyBXCQ=;
        b=EdNbhx+yfOodoELKyk+kBAi2VaAL/phZtDpIKWC0RVaUEa///r1FwtqAYEfWrr3X/w
         zGbojUZWR4xNyPPRKOSwcP5lbDwPSn/fM2a4qqw1TeKbKhFKbRN5zPuHi2UH6sET/gJ1
         lxHH6rNf1FKIlwEPpipQbHYSEr01uvVnAHdcwbrz8BSz4tLM+PyUi8m9oaKKq80Zdk0L
         3Rl+ATnzpeCRgDfz8d8l0HjRhRX7sztow0cWV3jtUVeXuSsenPHg20pBxm0+xD53HRa/
         VhTEm1G6dMyx7SObw9jHRu98uTaWX4fGSQB6YuVthtYnrRI8vOBcOFpnBHZWjdmOQizD
         jq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756418131; x=1757022931;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mCS1blGVKzhibBa+GC93mJ6dY0HkTwPO0389IUyBXCQ=;
        b=aF3B295V7IZGRIKgSTomAI6lYRc84d7cR96G+iF28oEWinQOdB1QS+uwvLOm838XRP
         +/KZx9aniylT1WD7LFdpPMdHAIBidz2TOaTbieNM0l/w9tLh+IV76iSppxKvPSfCf/Wf
         +IFVOsK3Ps2GHJSdPMoEjSbOO6B0XtNC8bZMn6AfSRABs/tWo8KXyTBhJmoUkPU9n95g
         EoQdQ+7wqWiopVIjJoXvFFKdQ9rSTzwAYbY8QVL9ElSM4UwO3iuZpEmQXx1oCH6YxPcB
         m1u12NzNax/nLasNEBhVH4GViEv2Wq9PAW3WgTAvf1vkdvkH1lQqS2jqLEcghO+Xywr3
         5KjQ==
X-Gm-Message-State: AOJu0YyLt4A7xBE0vZw6kMJh2/Fwga0SKwZ+sH+kWSj0f28enzQ4WblQ
	jLbMgygFyQWRowsFyh2Xs6j8XAiHbCV55HKHb1nmtSQJ7XfZuRMBrLL2ljwIliA2Qmg=
X-Gm-Gg: ASbGncu3n0FO9J2UiYn83h4GBHoXlm2hw4zW3jEh9ZuGCTTSygr+WB3dDW8+mYEUIEY
	X/qAKejR0mfPlxNLyXLLpwDZlN6v74MSNltCdHU6vjYa8prFn18fDVLD+u45nVkpsQErnC6Vbke
	o4tnvk6X3JeGiEqv78EJU9SNOinO1dbZCo7cK088YcgDnStgL2hN0UfzWq2vYK79Uxc+z+ZAq4h
	0R0gZPCHyC+uHZlo9fyWXICOrWyHs7gsDtF+hiWaHfi2I73P+LVR40yzgkqTvBA9OUpMaoMJIsb
	x7z6Pj0Cw5u67VbPyY1alrAS4M567pVwR2l0PgvsEDIDyLJihqqcU1UyFtulza/xGn/FTI0Gb+R
	JNRLgdI+kQZ8quAryOfPWSQnKFfMg0iOhXdtslkk=
X-Google-Smtp-Source: AGHT+IF+IIHA6Q5cudJvSu5ml3pRd3rgn2AkEpFHy4vlOTg5z8xGEHmgGG+PyNpV6WKp+BcSL5qkFg==
X-Received: by 2002:a05:6830:6685:b0:743:823:a094 with SMTP id 46e09a7af769-74500a8aba0mr14398676a34.10.1756418130734;
        Thu, 28 Aug 2025 14:55:30 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:aa84:2d2c:f28c:4102])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7455853804asm136084a34.33.2025.08.28.14.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 14:55:30 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 28 Aug 2025 16:54:52 -0500
Subject: [PATCH v3 1/4] dt-bindings: iio: adc: adi,ad7124: fix clocks
 properties
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-iio-adc-ad7124-proper-clock-support-v3-1-0b317b4605e5@baylibre.com>
References: <20250828-iio-adc-ad7124-proper-clock-support-v3-0-0b317b4605e5@baylibre.com>
In-Reply-To: <20250828-iio-adc-ad7124-proper-clock-support-v3-0-0b317b4605e5@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3149; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=ejiW++p+A0I9xjvm23IuPsPQ6EO4iCmJb+R47NFoGFU=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBosNA1O0KkNBJ9aNcMpiNpN0mL0yWZXDt161WKd
 V7fJ3SqsHGJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaLDQNQAKCRDCzCAB/wGP
 wCbiB/4+PzMxVzV3DSBjQKryiHukMKB7ZFrX8RalKvJGOisgzuD7Prh4Spexa2ufXG7KI7T+KrL
 0HgkRQIJB/+/T0e0fcf6E1x9g+xJX3Rsvpnlv7qS7oPwOY/ciuy30+/wo0caKSp7a3JTF53BdxB
 0gT7fGFowhXpZCDgJj+tSA7Q84dD+dNCexnLvwXxDe22VrM0ieC8i1NY7LdgfPJ71r16kiqDoZV
 W3lxQ5ugVV7PjfHMumHQaQyNyHapt8xRTl8Q6JCGlPBDgA4ylm5f478Xbsl1ztt2kSO618XrrFV
 QObtXUbz30UCRPrghl+sXVBW5iYPUCzLxWx+cQrBwTkyJbkS
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use correct clocks properties for the AD7124 family of ADCs.

These ADCs have an internal clock along with an optional external clock
that can be connected to the CLK pin. This pin can be wired up 3 ways:
1. Not connected - the internal clock is used.
2. Connected to an external clock (input) - the external clock is used.
3. Connected to the CLK pin on another ADC (output) - the internal clock
   is used on one and the other is configured for an external clock.

The new bindings describe these 3 cases by picking one of the following:
1. Omit both clocks and #clock-cells properties.
2. Include only the clocks property with a phandle to the external clock.
3. Include only the #clock-cells property on the ADC providing the output.

The clock-names property is now deprecated and should not be used. The
MCLK signal that it refers to is an internal counter in the ADC and
therefore does not make sense as a devicetree property as it can't be
connected to anything external to the ADC. Since there is only one
possible external clock, the clock-names property is not needed anyway.
Based on the implementation of the Linux driver, it looks like the
"mclk" clock was basically being used as a control to select the power
mode of the ADC, which is not something that should be done in the
devicetree.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7124.yaml     | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
index 4dd5395730c10925c86782116dfd70a75d033bfb..2e3f84db6193b3d8765e2bdbd2d3175cf1892ba4 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml
@@ -28,12 +28,21 @@ properties:
 
   clocks:
     maxItems: 1
-    description: phandle to the master clock (mclk)
+    description: Optional external clock connected to the CLK pin.
 
   clock-names:
+    deprecated: true
+    description:
+      MCLK is an internal counter in the ADC. Do not use this property.
     items:
       - const: mclk
 
+  '#clock-cells':
+    description:
+      The CLK pin can be used as an output. When that is the case, include
+      this property.
+    const: 0
+
   interrupts:
     description: IRQ line for the ADC
     maxItems: 1
@@ -67,10 +76,14 @@ properties:
 required:
   - compatible
   - reg
-  - clocks
-  - clock-names
   - interrupts
 
+# Can't have both clock input and output at the same time.
+not:
+  required:
+    - '#clock-cells'
+    - clocks
+
 patternProperties:
   "^channel@([0-9]|1[0-5])$":
     $ref: adc.yaml
@@ -136,8 +149,6 @@ examples:
         interrupt-parent = <&gpio>;
         rdy-gpios = <&gpio 25 GPIO_ACTIVE_LOW>;
         refin1-supply = <&adc_vref>;
-        clocks = <&ad7124_mclk>;
-        clock-names = "mclk";
 
         #address-cells = <1>;
         #size-cells = <0>;

-- 
2.43.0


