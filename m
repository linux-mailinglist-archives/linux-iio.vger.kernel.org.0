Return-Path: <linux-iio+bounces-11061-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E10189ADEF7
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 10:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 629701F21A9D
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 08:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1F11C876D;
	Thu, 24 Oct 2024 08:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Qzeu2W3v"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D03F1BD504
	for <linux-iio@vger.kernel.org>; Thu, 24 Oct 2024 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729757852; cv=none; b=m1yVAZNUMlaHoz9WbVENTkm8a8dTq+zKY4Euwt+jKtRjSZsUfzZkQUN1C+m5qCuxwrs3JLochIFAfsULmbCioZD2yiLkE4nHOV84trjR6y1Mdmuzs3sNo6ruxdI5zotj0yDk/ofNog6kWO0N+Xz7QSx81OxPSWmUZlJtHc1FvbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729757852; c=relaxed/simple;
	bh=bINQAp/pWnnhzvey6FhSwDnpzo8hwDOZOiwS6aG0E+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Onh+K/YOlTIw8pINp34KBhiiniX2kx0iaRomUWIfX76aqtP8DwZcix1b7Xg2Ajt8qvf4+B3GoxvDLBxTspgPQWTqkI3ZSOGi0KGb+DgJ70jWD+vmWANhLaiOvT/d42W/e7nPYn6e78Q0NyiqzPbuki7acq9IzcvAS8R7xLsy8Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Qzeu2W3v; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4316cce103dso8184975e9.3
        for <linux-iio@vger.kernel.org>; Thu, 24 Oct 2024 01:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729757843; x=1730362643; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UjhehN3UQLkob1z9yCMxhZDnJwwD3zgQTo0JJJu1bkk=;
        b=Qzeu2W3vVNNgkyTE7xXipXI+r1AsI7+qWkw0VorU5cwtcVFoSOFU4Qoi7M5Ub80t27
         yxZnNcLJw1yaYqLsgL1Ye/bS2hZE6idS1LQD6qyrR5dMYUYIOXXu+dOUH95ytMeDuOwg
         DfRoXaGCNhKUxKgNDc7aLD/vsR8TNf5WZA0Cc6Prf7txHGBpg/V0PsTVQgFZtDLLqnv/
         ecZEqJj1cPPCdvydCi6d4WjAYn4QVnu0RAM1gNdnywLY/+jCtxVAzM0cxEzGm/vqgiNc
         OraFQ7IhPba01mFV7NhUtlR8M16G4TYz0buQpmB8bJ0d1xBW09G8l4D4T5ArYuyfEiuc
         edMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729757843; x=1730362643;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UjhehN3UQLkob1z9yCMxhZDnJwwD3zgQTo0JJJu1bkk=;
        b=BYssY2+Z4p20Ym1a4UYUAUDqcXwht/XCQmlvJAfBk4RLYywmek/NTWgocf9XfgQ5Ab
         nFP+Hb3MuIX1hThSZY2+CTJrtP5CWNggLpXVihzDzpeXJ4BlkHGTDojin9MIexp6/Ojj
         gLNFSmnK8Cs8J00ZkthqZ6aJXpxB6I2NUfP9j5aC0lTedl4YjFIB7ylPtd8Gqm0VTe4V
         gDjTCXQjUmz4Qk+cLHIcp5q2GGC0MJYAtFFmNxxq9TNfgn/4bDh0YQJMFmw03086xcN6
         QR0z02s37lrizdqfsVzzqNZ1Jzq7PAEYdIx8iP9BEIevg34kE6l34IPn6mFB1AXtt3Xu
         IG4A==
X-Gm-Message-State: AOJu0YyPVVRxHLRWPx8RFEnkEv6BNKjxFXEbdHn6jVabtl801P+Gd/Ys
	E1RES7NCPLSh8buvrOagjW3W61rmFk9BPQKHVv2ELIfc84Wgfd3KqIes4Edc3ak=
X-Google-Smtp-Source: AGHT+IHOzIZEUzmhjrr4HMvpk4oY/GOpqLv+1DW2TTM0nvMAVotcWmixkQkm9oQvVVtAQ6sGblsOgw==
X-Received: by 2002:a05:600c:4f86:b0:431:52a3:d9d5 with SMTP id 5b1f17b1804b1-43184157850mr55720895e9.0.1729757843454;
        Thu, 24 Oct 2024 01:17:23 -0700 (PDT)
Received: from [192.168.1.64] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b93d53sm10828922f8f.70.2024.10.24.01.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 01:17:22 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 24 Oct 2024 10:16:56 +0200
Subject: [PATCH v3 1/4] dt-bindings: iio: adc: ad7380: add adaq4370-4 and
 adaq4380-4 compatible parts
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241024-ad7380-add-adaq4380-4-support-v3-1-6a29bd0f79da@baylibre.com>
References: <20241024-ad7380-add-adaq4380-4-support-v3-0-6a29bd0f79da@baylibre.com>
In-Reply-To: <20241024-ad7380-add-adaq4380-4-support-v3-0-6a29bd0f79da@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

adaq4370-4 (2MSPS) and adaq4380-4 (4MSPS) are quad-channel precision data
acquisition signal chain μModule solutions compatible with the ad738x
family, with the following differences:

- pin selectable gain in front of each 4 adc
- internal reference is 3V derived from refin-supply (5V)
- additional supplies

To select the gain a new patternProperties is added to describe each
channel. It is restricted to adaq devices.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 120 +++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
index 0065d650882489e21b952bb9fb25f1e3a070ee68..ada08005b3cd1ce7ba13f96484a33fdee0e83a1c 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
@@ -25,6 +25,8 @@ description: |
   * https://www.analog.com/en/products/ad7386-4.html
   * https://www.analog.com/en/products/ad7387-4.html
   * https://www.analog.com/en/products/ad7388-4.html
+  * https://www.analog.com/en/products/adaq4370-4.html
+  * https://www.analog.com/en/products/adaq4380-4.html
 
 
 $ref: /schemas/spi/spi-peripheral-props.yaml#
@@ -46,6 +48,8 @@ properties:
       - adi,ad7386-4
       - adi,ad7387-4
       - adi,ad7388-4
+      - adi,adaq4370-4
+      - adi,adaq4380-4
 
   reg:
     maxItems: 1
@@ -70,6 +74,20 @@ properties:
   refin-supply:
     description:
       A 2.5V to 3.3V supply for external reference voltage, for ad7380-4 only.
+      For adaq devices, a 5V supply voltage. A 3.3V internal reference is
+      derived from it. Connect to vs-p-supply for normal operation.
+
+  vs-p-supply:
+    description:
+      Amplifiers positive supply.
+
+  vs-n-supply:
+    description:
+      Amplifiers negative supply.
+
+  ldo-supply:
+    description:
+      LDO supply. Connect to vs-p-supply or a 3.6 to 5.5 V supply.
 
   aina-supply:
     description:
@@ -97,12 +115,45 @@ properties:
       specify the ALERT interrupt.
     maxItems: 1
 
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
 required:
   - compatible
   - reg
   - vcc-supply
   - vlogic-supply
 
+patternProperties:
+  "^channel@[0-3]$":
+    $ref: adc.yaml
+    type: object
+
+    properties:
+      reg:
+        description:
+          The channel number. From 0 to 3 corresponding to channels A,B,C,D
+        minimum: 0
+        maximum: 3
+
+      adi,gain-milli:
+        description:
+          The hardware gain applied to the ADC input (in milli units).
+          If not present, default to 1000 (no actual gain applied).
+          Refer to the typical connection diagrams section of the datasheet for
+          pin wiring.
+        $ref: /schemas/types.yaml#/definitions/uint16
+        enum: [300, 600, 1000, 1600]
+        default: 1000
+
+    required:
+      - reg
+
+    additionalProperties: false
+
 unevaluatedProperties: false
 
 allOf:
@@ -140,6 +191,7 @@ allOf:
         aind-supply: false
 
   # ad7380-4 uses refin-supply as external reference.
+  # adaq devices use internal reference only, derived from refin-supply
   # All other chips from ad738x family use refio as optional external reference.
   # When refio-supply is omitted, internal reference is used.
   - if:
@@ -147,6 +199,8 @@ allOf:
         compatible:
           enum:
             - adi,ad7380-4
+            - adi,adaq4370-4
+            - adi,adaq4380-4
     then:
       properties:
         refio-supply: false
@@ -156,6 +210,27 @@ allOf:
       properties:
         refin-supply: false
 
+  # adaq devices need more supplies and using channel to declare gain property
+  # only applies to adaq devices
+  - if:
+      properties:
+        compatible:
+          enum:
+            - adi,adaq4370-4
+            - adi,adaq4380-4
+    then:
+      required:
+        - vs-p-supply
+        - vs-n-supply
+        - ldo-supply
+    else:
+      properties:
+        vs-p-supply: false
+        vs-n-supply: false
+        ldo-supply: false
+      patternProperties:
+        "^channel@[0-3]$": false
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
@@ -180,3 +255,48 @@ examples:
             refio-supply = <&supply_2_5V>;
         };
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,adaq4380-4";
+            reg = <0>;
+
+            spi-cpol;
+            spi-cpha;
+            spi-max-frequency = <80000000>;
+
+            interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-parent = <&gpio0>;
+
+            vcc-supply = <&supply_3_3V>;
+            vlogic-supply = <&supply_3_3V>;
+            refin-supply = <&supply_5V>;
+            vs-p-supply = <&supply_5V>;
+            vs-n-supply = <&supply_0V>;
+            ldo-supply = <&supply_5V>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+                reg = <0>;
+                adi,gain-milli = /bits/ 16 <300>;
+            };
+
+            channel@2 {
+                reg = <2>;
+                adi,gain-milli = /bits/ 16 <600>;
+            };
+
+            channel@3 {
+                reg = <3>;
+                adi,gain-milli = /bits/ 16 <1000>;
+            };
+        };
+    };

-- 
2.47.0


