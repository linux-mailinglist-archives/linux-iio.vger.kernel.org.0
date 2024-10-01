Return-Path: <linux-iio+bounces-9983-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF62D98C6CB
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 22:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05F921C23250
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 20:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AE01CF7BE;
	Tue,  1 Oct 2024 20:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liQOW+oa"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C811CF7A6;
	Tue,  1 Oct 2024 20:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727814126; cv=none; b=JRcD/o9tiW2518K46Mp/hjYYUw0ub/dFCOrWWvN/W1cUr+NpE8VdlBmxvO6ssVHTdsaq5PWJAdB9XtxEdmt1xLtG3/fpJScvMX+an+hezAKdxMIXLx6kSth+TT7t8/yM3zxkOyTUuficsW1AQChn0q4phtmpa5Zq6Z1PL7+wOyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727814126; c=relaxed/simple;
	bh=idyTbEXVNejNq/0RN4IT9GEkYOnmgvJGdw+H+vgQLoM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CFxcX2LNNuL8NsScb8+sECZUOODSgpI1HRTNPynagXJapXcI8ux0SiuK5kyu6lMRN/dJDCQgNvQATvJ2CLs7Su2hlRLMLOVUBR7milXFLzP0t0vrHGsdwi96Du+ABZcH6sdKbPkYEAFebGl1OesZOmA063qw+ESxiqWkcUwuluk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liQOW+oa; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42e5e758093so47938845e9.1;
        Tue, 01 Oct 2024 13:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727814123; x=1728418923; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dKYY9xrjJ6XXlAI0aWmqIA4xwpuELm//meQdtRiMDgI=;
        b=liQOW+oaTRn3iRANe+2YlR+mDXp/sHd+peUgDspTlENFexXw3Mgpffk1eqfKl5Tszg
         qrEpu/rXL31tnZlU5YAj/DMUZTbqlsQg4eGFFHQukhShtxiOiSX4Tm896FFYBIGLiG6u
         yVjZ46Gby0a+DlE9g3r7RPS2c3fJ5Ux/6wzsP2X5tIE8z1Qqb9FuDtnkY44gEYQCMik5
         KBSPD1bOPCoPIOFODYPkEOUCPQchATq8fWeKLOCR0Tr8jUR7q3h2xkme4wnaeEpFgjxK
         cXZ1J6F+bOy3FcE6UZsygvWprINots2jYyaeDLapWsxPjI8gD2nIn86gDsyTodYB91YA
         /ifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727814123; x=1728418923;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKYY9xrjJ6XXlAI0aWmqIA4xwpuELm//meQdtRiMDgI=;
        b=WLBLL6AsUo5Q+HwtPwmKqGrzvCt7U/qyaycSxh6ZamRq2UyUYY8tVyFvVILU5ec9xi
         10+atXBb4l3Z/2/FuKdO0633mIeryKh7lUrlqh1aW/UKj+AxoyLF2nO8uMrWP0tgnKqV
         jOC3irNOOYO+4lyhRFPmWZaMlQYKocvg3wII0onbQDHzRtAp3VXdYet06/jTiTabGTWR
         egxzsJJazNMPR+NUuXFicjwC8mHKlXAhjBsWF3DRr08OODgNXl4U3+ryfPrJbEasu602
         zCZJa/SVl49c9m07JkyOkMhiX8VNU4P+qTRDmuq+xG2l/8hEMcLEPxWpNTDGBNIBm1kp
         vmuw==
X-Forwarded-Encrypted: i=1; AJvYcCVhp8hJTFjcNNEzzD65+Bc5zB9PygQK0I0MnMGFPudCDhikEt2PWibi3qpJ87Jy3GiRXCiZ+LgX+kisx/0v@vger.kernel.org, AJvYcCX9QjYMNOZqpL0GDEc9oMT38HwGLI9vifFf4c5yITldQbFQ8bNAgxlb4kxdFup94NALiCF3X2ZszIGa@vger.kernel.org
X-Gm-Message-State: AOJu0YzjQxqAyUZsTOaYPusYo0wPu/WqGD1impA8wu4e2wj0NDSiwjZF
	yLolgDI0TiFQdO37ag19QPHA1VV13HJopeBYzss3madsJthWrq60HJG3J9ih
X-Google-Smtp-Source: AGHT+IGcVFZh0eszxBi1Rr2d7L3CUZ6xC3M1GcaKVLdQyW6K/YApqBeUJkcnhiBNX4DOSGJBZ94Qpw==
X-Received: by 2002:a5d:468b:0:b0:378:89d8:8242 with SMTP id ffacd0b85a97d-37cfb8cfaabmr378427f8f.26.1727814123022;
        Tue, 01 Oct 2024 13:22:03 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-41f4-a392-01d5-d74d.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:41f4:a392:1d5:d74d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a55336sm188680935e9.47.2024.10.01.13.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:22:01 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 01 Oct 2024 22:21:21 +0200
Subject: [PATCH v3 8/9] dt-bindings: iio: light: veml6030: add veml6035
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-veml6035-v3-8-d789f6ff147c@gmail.com>
References: <20241001-veml6035-v3-0-d789f6ff147c@gmail.com>
In-Reply-To: <20241001-veml6035-v3-0-d789f6ff147c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727814089; l=2791;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=idyTbEXVNejNq/0RN4IT9GEkYOnmgvJGdw+H+vgQLoM=;
 b=Zb9b3hsddSBX8POqKPfv+xviuQeQJkQBNsgIMbz98ADnayn8j1jGoQIBaNH++P0fnLl1wDy2k
 psozBzhvn5HCA0QOqDepE6yYvgnxg6J1h9mK+jq0AIKGEjOnzzJqQN3
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
index 42a78cd4f812..6218273b0e86 100644
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
@@ -48,6 +46,30 @@ required:
   - reg
   - vdd-supply
 
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


