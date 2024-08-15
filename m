Return-Path: <linux-iio+bounces-8491-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EA3952E02
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2024 14:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4DC91C21F08
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2024 12:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CE717BEAB;
	Thu, 15 Aug 2024 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BaNftDo0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E706D17AE16
	for <linux-iio@vger.kernel.org>; Thu, 15 Aug 2024 12:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723723933; cv=none; b=i+qxuoFedTh8M2QlxR1nBppac/FvuXSg7iL1qnGRyARs8y0cf2GRKz8cRkRkI6quqEiOx8WXZRYzNbhFyH8KIw9W70XOw6wHRpr7e6CEc7xRanoXbBzdtk0YzlZtW7FZnbhtGxsYyZgkwO/QXPfzVkERBVCeAOvcBODtaKbtQs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723723933; c=relaxed/simple;
	bh=rXhZdUWJsqDazB5Vkbf8w2K7TEhns08C2q9VAY7oRJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fSpo/ypbBKjgcFKCTJO3f26pImXKDlRP5iaLFUfNURhawceszi0WnOiGXLwIPOB+hqUe5pszlVCP1P52BQI4GeKce71bzKXoytANiXYIzAgNMx1keTXob0HH/8JQPdw9Lf7GbJgTduqIYg9C23zwT+mBrqUM4lroO/W7Xbcsnys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BaNftDo0; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso5660515e9.0
        for <linux-iio@vger.kernel.org>; Thu, 15 Aug 2024 05:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723723926; x=1724328726; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YAz4wQg7uBRMgRGbUs7MSl25zX2Ca4ENNRVTWXCuU9Y=;
        b=BaNftDo0BRSJsd9Wc68nFe3Yy9GD6EPIJr8HllL9C1NTcpELwpwVCnInFcT/vcUKQ9
         QJt0k/GEda25MMVBfPqA93FE74YZEPUW3a5ZMnL/n1CvB+jKCJ7SO7s9k6R3XdV9UwM9
         Tjd85AOUg9fSQ2l5e0Ytrbg35ThjWDthD7ItUDBnumAD00lYtYWGENKh03pWhsrxPGxT
         aeVdF/AjmKENRalg1SG31K1J52qj+cYv+PJFa2Fqfbcwb3o5LiuWu4C0CaYtAILGgSCV
         W8gikDLQXlSb2YpB+CabV5heSWi9XAMTnQwkdzy9TAxOZX5J76xSHmu8WFXErz1wDkrt
         q7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723723926; x=1724328726;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YAz4wQg7uBRMgRGbUs7MSl25zX2Ca4ENNRVTWXCuU9Y=;
        b=kO5syx6FI3+el/DTaijQtYUq8GG6RCULPPNDej/5SvqWRsasSx0i54dUhCWv1RRs6a
         Qff07VDSG3P9yzAuYI4TNnySiLdzOWCxlcgzR9qQ6j9S8Sle9v5TCWJJix0YyG5IWbF9
         N5TOdbzFSWruyFcVmsTs5mjnTg65ik698DO1aBqkYdScTBy7KTi658N2k8HHbhihHcTz
         YuPhqcX4mcn4WQwpC0jHvx1vIDnGOlzw6LlGPSYmVeTNQCmubFQjUjj2qBEtNe28dl1y
         3ri6sSYYLG6AXB0vQlcsKZ2gOvKiCdvQmH64CXMBep/DJPCwOmaszSYsHA3+LxZOdJA5
         BBWg==
X-Forwarded-Encrypted: i=1; AJvYcCWN2htB66peofJq2Vva0omuryRJszSeV53mLMQfrAqN9qgrI7Y2nN0gjLnZjht8Rj1fu1gG+KihTn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNqG9Joi9zrTjRzQaYrBoAIV+TomuRtY6wuv4etkKRsomMX6bU
	x9d6PaOj1hQ6f7mcVcdYWrDTQrYaUxZ1OC4P92FquUPCYmtqTDWl5YL5A0wtI4k=
X-Google-Smtp-Source: AGHT+IE7oDIh5qrSNArjB/+/3YroZbMJvOJ3u5VObrCTb4B77OgIVkH6sw3EHVQJNpWLQsADrWeAhA==
X-Received: by 2002:a5d:6dae:0:b0:36d:2941:d531 with SMTP id ffacd0b85a97d-3717780fb2bmr4268953f8f.44.1723723925444;
        Thu, 15 Aug 2024 05:12:05 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189897926sm1365082f8f.87.2024.08.15.05.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:12:05 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Thu, 15 Aug 2024 12:11:56 +0000
Subject: [PATCH 2/8] dt-bindings: iio: adc: ad7606: Add iio backend
 bindings
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-ad7606_add_iio_backend_support-v1-2-cea3e11b1aa4@baylibre.com>
References: <20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
In-Reply-To: <20240815-ad7606_add_iio_backend_support-v1-0-cea3e11b1aa4@baylibre.com>
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
 Guillaume Stols <gstols@baylibre.com>, 
 20240705211452.1157967-2-u.kleine-koenig@baylibre.com, 
 20240712171821.1470833-2-u.kleine-koenig@baylibre.com, 
 cover.1721040875.git.u.kleine-koenig@baylibre.com, aardelean@baylibre.com
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723723923; l=3779;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=rXhZdUWJsqDazB5Vkbf8w2K7TEhns08C2q9VAY7oRJ8=;
 b=HPwEMFBxPMurmX27U87sY6QHKVNxGxR1eZ9Vd9WXBPxs9E9Zy3T97AKPeqbeZKiZbNK8VxrxE
 PeQ+5wj6O3GCZwcklTVKBAlaPuTPu2KCjnRLXLXzbln0dnP6I24b/Vm
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

Add the required properties for iio-backend support, as well as an
example and the conditions to mutually exclude interruption and
conversion trigger with iio-backend.
The iio-backend's function is to controls the communication, and thus the
interruption pin won't be available anymore.
As a consequence, the conversion pin must be controlled externally since
we will miss information about when every single conversion cycle (i.e
conversion + data transfert) ends, hence a PWM is introduced to trigger
the conversions.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7606.yaml    | 75 +++++++++++++++++++++-
 1 file changed, 72 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
index c0008d36320f..4b324f7e3207 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -114,13 +114,28 @@ properties:
       assumed that the pins are hardwired to VDD.
     type: boolean
 
+  pwms:
+    description:
+      In case the conversion is triggered by a PWM instead of a GPIO plugged to
+      the CONVST pin, the PWM must be referenced.
+    minItems: 1
+    maxItems: 2
+
+  pwm-names:
+    minItems: 1
+    maxItems: 2
+
+  io-backends:
+    description:
+      A reference to the iio-backend, which is responsible handling the BUSY
+      pin's falling edge and communication.
+      An example of backend can be found at
+      http://analogdevicesinc.github.io/hdl/library/axi_ad7606x/index.html
+
 required:
   - compatible
-  - reg
   - avcc-supply
   - vdrive-supply
-  - interrupts
-  - adi,conversion-start-gpios
 
 # This checks if reg is a chipselect so the device is on an SPI
 # bus, the if-clause will fail if reg is a tuple such as for a
@@ -137,6 +152,35 @@ then:
         - spi-cpol
 
 allOf:
+  # Communication is handled either by the backend or an interrupt.
+  - if:
+      properties:
+        pwms: false
+    then:
+      required:
+        - adi,conversion-start-gpios
+
+  - if:
+      properties:
+        adi,conversion-start-gpios: false
+    then:
+      required:
+        - pwms
+
+  - if:
+      properties:
+        interrupts: false
+    then:
+      required:
+        - io-backends
+
+  - if:
+      properties:
+        io-backends: false
+    then:
+      required:
+        - interrupts
+
   - if:
       properties:
         compatible:
@@ -178,12 +222,37 @@ allOf:
         adi,sw-mode: false
     else:
       properties:
+        pwms:
+          maxItems: 1
+        pwm-names:
+          maxItems: 1
         adi,conversion-start-gpios:
           maxItems: 1
 
 unevaluatedProperties: false
 
 examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    / {
+        adi_adc {
+                compatible = "adi,ad7606b";
+
+                pwms = <&axi_pwm_gen 0 0>;
+
+                avcc-supply = <&adc_vref>;
+                vdrive-supply = <&vdd_supply>;
+
+                reset-gpios = <&gpio0 91 GPIO_ACTIVE_HIGH>;
+                standby-gpios = <&gpio0 90 GPIO_ACTIVE_LOW>;
+                adi,range-gpios = <&gpio0 89 GPIO_ACTIVE_HIGH>;
+                adi,oversampling-ratio-gpios = <&gpio0 88 GPIO_ACTIVE_HIGH
+                                                &gpio0 87 GPIO_ACTIVE_HIGH
+                                                &gpio0 86 GPIO_ACTIVE_HIGH>;
+                io-backends = <&iio_backend>;
+        };
+    };
+
   - |
     #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>

-- 
2.34.1


