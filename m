Return-Path: <linux-iio+bounces-10355-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A371F9964FF
	for <lists+linux-iio@lfdr.de>; Wed,  9 Oct 2024 11:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1844281FE4
	for <lists+linux-iio@lfdr.de>; Wed,  9 Oct 2024 09:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4DE18E348;
	Wed,  9 Oct 2024 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RYAVmGOi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ED718E023
	for <linux-iio@vger.kernel.org>; Wed,  9 Oct 2024 09:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728465589; cv=none; b=LGBNC8se89oupPdQwbCSvU74/Z5cYYdTkLOyzn4fvsqemhFmezpvuhjEOOrS7PNnci+4ssoLvqeWRMAxVw/Vu+oGW5JPPl3+PfTrEflKPzUDXbMuy0sbk5vRMaYsP/lhGZMzkq94lEtNeUXzzZKUjuUdoU/DBHjOugtwy5KmIUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728465589; c=relaxed/simple;
	bh=cnL3eq0CvnDwIBAYvPykYoJ3Fx17pk9WK/iph6l0pIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qyZQQd1YxPsuPef538a4HIfWgVCxN110GHkNGT6o+pI7IDvEH8+NkNHEZVRRmSSQzp2WPHWCuV/yEsTw8C4wMKdOQ9BhUjrm/OVDgi2PWz/ZU1spP0kBLBCG2WSGTDfnd3EmKgpoB7d6FnA+weIyKyT3JkKRiLrmt5oGCI7vnfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RYAVmGOi; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-537a399e06dso6866130e87.1
        for <linux-iio@vger.kernel.org>; Wed, 09 Oct 2024 02:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728465584; x=1729070384; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=55EhiFz0eoHIW1OIthep7nNdg0DTxW/ypPJriA4rZJE=;
        b=RYAVmGOiyy1ygQ618FqZjeauPDbPJbZcil/yagD3uWL36YYcc5u+Q3ugFyg8G06JHY
         PfOiMxQyhsSjKoc3u9soB7VHnmsXozNshFiWiGJAGjWZtehFLgWNaJ84nH3D6rVUnC73
         ni3HWKa3+nafA3NUKkXCe/gLqL4NVW1hKYf8tUD+4MpXYqvZMVpN7dJsOM474bzNctcL
         +KdgICy7yOPz7l2ioBZyu0POn+g16vLwrKfjFKn0WHWXS5rq/Sqlw+S5G20kGn7Ce455
         BhdSJGPFKHPEwIlEYgW1S+vGcaj/nXde74cGKNpbWoxEYmQQtsXFQ3g07uA0MqMH61Bn
         BPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728465584; x=1729070384;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=55EhiFz0eoHIW1OIthep7nNdg0DTxW/ypPJriA4rZJE=;
        b=rIaB3PcnGd0pFsnerbfT6HtkvetzvFyw+oCs8LBL9/Vz7mBHdIVd+VO7eVWF/tgao/
         DkdyCwypDtk7OFaxAey2pGkvHnycMm0kiyVcPeMtCouJ9I+LhUmz0TYcX1E/neyL55Jt
         CYE+tDm8G80OJpEqzPZQ6AUPTItEpwZy26Pm5WGsfTSkl65A2U+gu94reVqUIJkvc/xe
         LnjRXyyAgk8k7hn5Y1XTXx00DO2kiYJVyXqJbmyugTlUvhIz6d2BGmqofSsGgHmE/4wm
         z1w53YeDRWDn/8jCkD6ChQHi3A00va4cEJs47Ie14cp+7+tHmzQHX3DXB8if9nYHiPU2
         NYQg==
X-Forwarded-Encrypted: i=1; AJvYcCXc9BqvtBgeYJXAfWEqgU2Mr+MBGjPdmqMO+Y7CI9bX/h7B8OMBj8KXvJ6dTtVjq5xijFs2v4w1ukU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ZxoXWXjtTiv8Vt17zip5k1dYm83gI/j45uibr638SOREIjNK
	4j9jYwg5vbIu1WXcXW+GC0liTds9BRCT5+WAzI6XHdvOv6WcZnSYHZ8+iUKekUQ=
X-Google-Smtp-Source: AGHT+IGLNJaNIcoKiyIBWQ3zVE26ZTEfaMbdvpfKWiYWNHWxUSJ8EEVTwm8NWBLhob73R+caHhP15g==
X-Received: by 2002:a05:6512:3501:b0:52f:d090:6da6 with SMTP id 2adb3069b0e04-539c49615c6mr955380e87.55.1728465583893;
        Wed, 09 Oct 2024 02:19:43 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d59b1207sm13892765e9.31.2024.10.09.02.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 02:19:43 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Wed, 09 Oct 2024 09:19:33 +0000
Subject: [PATCH v4 2/8] dt-bindings: iio: adc: ad7606: Add iio backend
 bindings
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-ad7606_add_iio_backend_support-v4-2-6971a8c0f1d5@baylibre.com>
References: <20241009-ad7606_add_iio_backend_support-v4-0-6971a8c0f1d5@baylibre.com>
In-Reply-To: <20241009-ad7606_add_iio_backend_support-v4-0-6971a8c0f1d5@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 aardelean@baylibre.com, dlechner@baylibre.com, jstephan@baylibre.com, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Guillaume Stols <gstols@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728465581; l=3731;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=cnL3eq0CvnDwIBAYvPykYoJ3Fx17pk9WK/iph6l0pIg=;
 b=TdN3OCOIwD++z3xC2TnuMjOLsKpVwDChCeQwC/nTkT15Hpf3dRJZNCczmSej8m+ohrKAQ6pZ0
 smAIWx13T0lBDkH19jK5xG4pbHbV/yd/RLfmxpm4ULFJ4eEtLaqwutG
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

Add the required properties for iio-backend support, as well as an
example and the conditions to mutually exclude interruption and
conversion trigger with iio-backend.
The iio-backend's function is to controls the communication, and thus the
interruption pin won't be available anymore.
As a consequence, the conversion pin must be controlled externally since
we will miss information about when every single conversion cycle (i.e
conversion + data transfer) ends, hence a PWM is introduced to trigger
the conversions.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 64 +++++++++++++++++++++-
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index 47081c79a1cf..0a612844029a 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -129,6 +129,29 @@ properties:
       assumed that the pins are hardwired to VDD.
     type: boolean
 
+  pwms:
+    description:
+      In case the conversion is triggered by a PWM instead of a GPIO plugged to
+      the CONVST pin, the PWM must be referenced.
+      The first is the PWM connected to CONVST or CONVST1 for the chips with the
+      2nd PWM connected to CONVST2, if CONVST2 is available and not shorted to
+      CONVST1.
+    minItems: 1
+    maxItems: 2
+
+  pwm-names:
+    items:
+      - const: convst1
+      - const: convst2
+
+  io-backends:
+    description:
+      A reference to the iio-backend, which is responsible handling the BUSY
+      pin's falling edge and communication.
+      An example of backend can be found at
+      http://analogdevicesinc.github.io/hdl/library/axi_ad7606x/index.html
+
+
 patternProperties:
   "^channel@[1-8]$":
     type: object
@@ -175,12 +198,22 @@ required:
   - reg
   - avcc-supply
   - vdrive-supply
-  - interrupts
-  - adi,conversion-start-gpios
 
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
+  - oneOf:
+      - required:
+          - adi,conversion-start-gpios
+      - required:
+          - pwms
+
+  - oneOf:
+      - required:
+          - interrupts
+      - required:
+          - io-backends
+
   - if:
       properties:
         compatible:
@@ -222,6 +255,10 @@ allOf:
         adi,sw-mode: false
     else:
       properties:
+        pwms:
+          maxItems: 1
+        pwm-names:
+          maxItems: 1
         adi,conversion-start-gpios:
           maxItems: 1
 
@@ -247,6 +284,29 @@ allOf:
 unevaluatedProperties: false
 
 examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    iio-backend {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        adi_adc@0 {
+            compatible = "adi,ad7606b";
+            reg = <0>;
+            pwms = <&axi_pwm_gen 0 0>;
+
+            avcc-supply = <&adc_vref>;
+            vdrive-supply = <&vdd_supply>;
+
+            reset-gpios = <&gpio0 91 GPIO_ACTIVE_HIGH>;
+            standby-gpios = <&gpio0 90 GPIO_ACTIVE_LOW>;
+            adi,range-gpios = <&gpio0 89 GPIO_ACTIVE_HIGH>;
+            adi,oversampling-ratio-gpios = <&gpio0 88 GPIO_ACTIVE_HIGH
+                                            &gpio0 87 GPIO_ACTIVE_HIGH
+                                            &gpio0 86 GPIO_ACTIVE_HIGH>;
+            io-backends = <&iio_backend>;
+        };
+    };
+
   - |
     #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>

-- 
2.34.1


