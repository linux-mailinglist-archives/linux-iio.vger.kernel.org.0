Return-Path: <linux-iio+bounces-9717-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAF697E407
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 00:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7183F2812B3
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 22:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8714613B59E;
	Sun, 22 Sep 2024 22:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnWstA1e"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9146A130ADA;
	Sun, 22 Sep 2024 22:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727043492; cv=none; b=hq3i8itZDjRcmM/cn1Tyjzi/bBOFHehk03FKUp8+pKGjgCWDk+X+dPk93kcnjR62TsWH9kC6vdqUhv2nZTMMIGLz+jb+OWjZPfQORFihd9SoKIXvktn/E+n35X1tw1G0hLB8w5Rxw4kAiIpQivul8Hab1ilFHoH9WgR3R64Uq58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727043492; c=relaxed/simple;
	bh=v76tVZJ0W+acWKyOV/Gx+qBJtt0HMqLGPKyH78bj3Vc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pUeZQM08hou9E2tiQSx6MOc5+z3xgnR4a1grUruCl6pYBPOaXkLMEkrefGI6b8WIf27WGA45AEHn7VVTZV7b49cKf6gK4sZJesgIf4LJHgcdAuCB9inppkErGGpr9HaLXFn/CDBosFRIxNLmLZ2JIg4Ksnq7jU7Z0L2tAYd2vRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnWstA1e; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso643079766b.0;
        Sun, 22 Sep 2024 15:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727043489; x=1727648289; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5o8vKCa+LjmRjp9pULN5CS7y20Oqn8Tin5hh9qJ+rR0=;
        b=ZnWstA1e6POBlhEvdnb0mPlfa/Dl8pK3BMSgVMW2R9LBChf7xKBfaAuY5mJrvx+2WF
         f2nKnfKPgX+jqsfGzosdjdz9rCJr819zPOpeqnb08WDz2rgpS7XZOpYrFFDhTyo3pxhn
         KoIlfbRgWpT0wu59+rqeWlgGD7NDzTTpfpfu1EYoZ61TPrk46nsODbi55EorXXnmEBUv
         qKL7ltHKEgJ5fU6lwTVms7rH4w5+1AxMq38pxf5uvKYzSF9U85cB0YIAQ9tT4cMKFaEB
         zlkJuLsygVJG+Jz8uw0KL//e6ByT0SNbJksP+KtXWgYPjUHsWAHpHhlxjLvcGEFXqO0V
         2DsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727043489; x=1727648289;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5o8vKCa+LjmRjp9pULN5CS7y20Oqn8Tin5hh9qJ+rR0=;
        b=M5VRwSoWNCfY52nuKI4F5t6VAU92THJGGuhezk11GqMyyREYUaRoCU8VWGyThczYt7
         Bb661BU0uzuiv80K6UANVDXwpS396UNlPy+5iAWLfCq1bv4BTpS73reHG5Gp5rqqH1HP
         277Bq7LQxUKpn7a0Ddk/Va4NjmmtnUwISj4fUTQymrmKDFCig3yoSJG2nGeVnjuckq4K
         zt21fA/eALy5kBe4yhi370GROchjUU1XkznGVANlqjC/ip5i7zcZrqHpmI2TDVXzcIW9
         G4/B9pzKiffF/qV8m6odBpwtAf1mRHyj/RDllRbFvR4hTKj8DU3ebk+nrhaatkwtcwoU
         fh5w==
X-Forwarded-Encrypted: i=1; AJvYcCU3A3fcLoDbepIKBRAeaREAaWJMfobW4ekYLoX7G+6Nb5kEpZqU3ho2uL6QrHyADynV/1UE8LmAQTCe@vger.kernel.org, AJvYcCVC6YkxvjkzXIpdOoJHe2x/VSSVZYDf6Rh2qM5ojSqfK7MbGdC0IYVtLe8OSfIT8aj47u6LqmT4zHCuGJy/@vger.kernel.org
X-Gm-Message-State: AOJu0YxIUVSmM+UplLBlCW79krIbopxCRujtq5YbtZD09Ur67ICcoqtp
	1+qyJ8abiCHwbo5IZQINx26rQ4pqJFTAA/TfqM59/YVEmIXIrKelxQ3lBWRa
X-Google-Smtp-Source: AGHT+IFcmmhwvTHvAm5wG4BFxmk3nTb64f+pRzNleklgbDCFZcXnrwyH2jsF/QlN4tKzCb7OwhEH6Q==
X-Received: by 2002:a17:906:478c:b0:a8d:4cec:fcec with SMTP id a640c23a62f3a-a90c1d6ee1fmr1625858666b.26.1727043488759;
        Sun, 22 Sep 2024 15:18:08 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90611164d0sm1126202066b.91.2024.09.22.15.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 15:18:08 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 23 Sep 2024 00:17:57 +0200
Subject: [PATCH v2 09/10] dt-bindings: iio: light: veml6030: add veml6035
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240923-veml6035-v2-9-58c72a0df31c@gmail.com>
References: <20240923-veml6035-v2-0-58c72a0df31c@gmail.com>
In-Reply-To: <20240923-veml6035-v2-0-58c72a0df31c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727043474; l=2791;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=v76tVZJ0W+acWKyOV/Gx+qBJtt0HMqLGPKyH78bj3Vc=;
 b=EptbaO69DKZ720L6uO0N+AQMv9KH+kws7wK/sVF1r1vPgCQwy5J14AMB0Hv3br85drfxXW1+T
 AMZJOkCb7Z8CyoIeNwqPz5SVpD51i+7f4SfTwJ7t7v6aNK1GTvt3pl0
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The veml6035 is a similar ambient light sensor to the veml6030, and
from the bindings point of view, it shares the same properties. Its
only difference in that respect is a different I2C address.

Estend the existing bindings to support the veml6035 ALS.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../bindings/iio/light/vishay,veml6030.yaml        | 40 +++++++++++++++++-----
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
index 2583b61c8357..69ca10cab09a 100644
--- a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
@@ -4,14 +4,14 @@
 $id: http://devicetree.org/schemas/iio/light/vishay,veml6030.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: VEML6030 Ambient Light Sensor (ALS)
+title: VEML6030 and VEML6035 Ambient Light Sensors (ALS)
 
 maintainers:
   - Rishi Gupta <gupt21@gmail.com>
 
 description: |
-  Bindings for the ambient light sensor veml6030 from Vishay
-  Semiconductors over an i2c interface.
+  Bindings for the ambient light sensors veml6030 and veml6035 from
+  Vishay Semiconductors over an i2c interface.
 
   Irrespective of whether interrupt is used or not, application
   can get the ALS and White channel reading from IIO raw interface.
@@ -19,20 +19,18 @@ description: |
   If the interrupts are used, application will receive an IIO event
   whenever configured threshold is crossed.
 
-  Specifications about the sensor can be found at:
+  Specifications about the sensors can be found at:
     https://www.vishay.com/docs/84366/veml6030.pdf
+    https://www.vishay.com/docs/84889/veml6035.pdf
 
 properties:
   compatible:
     enum:
       - vishay,veml6030
+      - vishay,veml6035
 
   reg:
-    description:
-      I2C address of the device.
-    enum:
-      - 0x10 # ADDR pin pulled down
-      - 0x48 # ADDR pin pulled up
+    maxItems: 1
 
   interrupts:
     description:
@@ -47,6 +45,30 @@ required:
   - compatible
   - reg
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - vishay,veml6030
+    then:
+      properties:
+        reg:
+          enum:
+            - 0x10  # ADDR pin pulled down
+            - 0x48  # ADDR pin pulled up
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - vishay,veml6035
+    then:
+      properties:
+        reg:
+          enum:
+            - 0x29
+
 additionalProperties: false
 
 examples:

-- 
2.43.0


