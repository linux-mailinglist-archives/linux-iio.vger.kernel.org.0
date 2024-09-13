Return-Path: <linux-iio+bounces-9500-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CC29780F0
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 15:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 589E8B24DEB
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 13:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D551DB931;
	Fri, 13 Sep 2024 13:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VI6xo8em"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FAC1DB535;
	Fri, 13 Sep 2024 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233561; cv=none; b=KaLGtBNsEpw1lS6At5JE2kxgccVLnkcgIZfMNnE4yJCDtuijqXfip4KMicAhQJgLHYWuSyApnGODY05lkLeh7JSPqiMvgfCHIbhpd2hQiJCPp0NHQb4ohMI7ABvzCWlw81QWQRxfpXH/maPv/C+9LSgEKzECAlvX+lBGCWL4VBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233561; c=relaxed/simple;
	bh=QxTQNvrLxkh1mF26QIuMBRqrU+ZhcDmuI2kAxhFttkg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bxUe6MKlA/RSbkfwFZtxpZFE8NsFgyHNA78PNv7VhJt5hUWMPvh9sWySvA0cTkuroE7aimgdxibMnQMLrGzv/LbUbsHv4yPgIgAdn5ZksJziI5CiuWxyMcC9Hq8SIwPqrysLuxGSyPytxnb7PCLAs9JagKboN06PC+NH3zu7GgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VI6xo8em; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8a7b1c2f2bso331671466b.0;
        Fri, 13 Sep 2024 06:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726233558; x=1726838358; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FvCncG6LHLyyoaSgVvqTRJYitrtjvsDOL7xX1DcIzHI=;
        b=VI6xo8emk0y1PnyBuXUZ2C3cSGW3r0mKqn0d6DkXddtUktx/OQdVziyVGvpqfJU1SQ
         8fb3nBCJunZdkMemF+hfL0iUTC0vi7dOVyn9jjmiiP4KKZOcagctMz6rfALNO3ntc8s3
         hr2borEhnNDUeqD/RnCPTNfRQEY+SSGHUwUMHng4lmKZMoiNpK1JRi23sQFsiKvFArwZ
         yxhijDv6UvCOG+WNOH7vtQ+pEzYk0Zr86DOuu6ZLfX/aTGJkB8JA1nLiZPw+1t1Nlu4p
         94We3Rab0ypOkMtYBepJ44JvrCXd5iLazgWhfMQvO9glKFf9+fFZFfMPB9SlZlEp70On
         fcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726233558; x=1726838358;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FvCncG6LHLyyoaSgVvqTRJYitrtjvsDOL7xX1DcIzHI=;
        b=f0/s72mMSwuVSU6hV2qzok5Ye5336fZJ/3FgjkHddAc9INgeiz5IEsWSyfQC/VHLbZ
         5Bv1jvNu5c6LPo1xolhVFF5/sTqqZLoQme2wQekk3XIxqKUo2glK9PCMuCCHRtnXyaHS
         M788PSdXNt8EQibUqMCa1/DRlpuJ3CBamnFx+1rvKcV6Qqq+C3p5bO9GMyeQzgzJWHtB
         C1J4vbxCDh+QarmJK1XJDyRYq3XTas704sKLc4vFXrxjyQbsqZZ7tIgd302ec9qvLRUt
         eMzZCsPEAJQHHxR7XiT628wqCZxOevFPr3r7NwHsqWL4gdYJJt8YU4ujpbN77hiZl3Ff
         CZbA==
X-Forwarded-Encrypted: i=1; AJvYcCUo+OgWGNgLC4lkyggSVpfhpgBSUElvcCwvTV7cSvc5XXtcsFvOX8OVvQ71JnRpoKJYp1EgA/Mctft1Znv3@vger.kernel.org, AJvYcCXx4pa6KmtsoLWgh5E4xOCszvEzpJlyRaoBpRWGaGVlVsLHD5/+zilLnXpM9tIRANSWzmiLUD5berFt@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Ld+fbqybOIdMPOANusinYtZZm8H+AAIsSV7YwIrMSpXWoYdP
	plDYbzueE0Kwh88np5wFbrnq5MkNM8Y0M/MFYElcv7cxHlsih5Ok
X-Google-Smtp-Source: AGHT+IHvHlAyalGXsjJDX7CzVRuDNtVhq3dY80xNEnWGKjx5/caV7+QaAtWAxoVtguLJAcBdQpBYYQ==
X-Received: by 2002:a17:906:730d:b0:a7a:a46e:dc3f with SMTP id a640c23a62f3a-a90296eabc9mr732776166b.45.1726233557603;
        Fri, 13 Sep 2024 06:19:17 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a258a3sm865945666b.89.2024.09.13.06.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 06:19:17 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 13 Sep 2024 15:18:57 +0200
Subject: [PATCH 2/7] dt-bindings: iio: light: veml6030: add veml6035
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-veml6035-v1-2-0b09c0c90418@gmail.com>
References: <20240913-veml6035-v1-0-0b09c0c90418@gmail.com>
In-Reply-To: <20240913-veml6035-v1-0-0b09c0c90418@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726233553; l=2738;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=QxTQNvrLxkh1mF26QIuMBRqrU+ZhcDmuI2kAxhFttkg=;
 b=gg2z2BzG1e7LXQfbyKLt2/n6StFumXHAGLcTiRsIr+nDhRzREUEEs/yQPpFtSOBeQl5aBz0Gg
 NbRkyzwCs/hDElpBjlDKNu2qo3E9WpejParnL9WY+BcMI4sS9Y8qfRP
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The veml6035 is a similar ambient light sensor to the veml6030, and
from the bindings point of view, it shares the same properties. Its
only difference in that respect is a different I2C address.

Estend the existing bindings to support the veml6035 ALS.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../bindings/iio/light/vishay,veml6030.yaml        | 40 +++++++++++++++++-----
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
index 7f4995557570..f88e043d7ede 100644
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
@@ -45,6 +43,30 @@ required:
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


