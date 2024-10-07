Return-Path: <linux-iio+bounces-10291-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F8C9931CE
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 17:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFD75B25230
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 15:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C995F1DA31D;
	Mon,  7 Oct 2024 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KDOt4GXg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD6D1D9661
	for <linux-iio@vger.kernel.org>; Mon,  7 Oct 2024 15:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315950; cv=none; b=HTLKs2ZoFOSF7zMwmNm7hzwB9+BDBUANVfuzjhUcCuLgV7nbpiPh0rFn+NvWqDDj9QORcSsnX+4m7GNfG7L8pruip+NUqFaXRPvcwr5iUX42jG2o2tNzzjNfqFQiPJTKaFOi1lUtmDPxjeJ9nXGihXRp57cz54Q6WWOfoS6W9Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315950; c=relaxed/simple;
	bh=+4xKkJnQqVu7uiiyn2Kxt0tvZkLS+cNdyJZUR5y0ym0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WSWjnZY4SII4MqgOLHaa6mbEMF7TZMYD0n+axsAdzZ7ykeLuquf27IU8wcvz+zSnel9PeWX7fBJruE9iD8JNnYN8ATYY9qf+iEGURFTbg7QFABDrnyugLYdAwtd403kLhOAZQUbdgOIMszcjlOo/OfYxw9AtqpkLRIcXX4R1xUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KDOt4GXg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cba6cdf32so46639075e9.1
        for <linux-iio@vger.kernel.org>; Mon, 07 Oct 2024 08:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728315946; x=1728920746; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2N3r/AZHZIBAky01wN9j8Ij5Fk065LyhFYbUy+uaF2c=;
        b=KDOt4GXgmNLILzBh1cFROmBEVG9oAAMjjZK+f0JDkzsPDoBJDzRNvg40zhWtYQsIzP
         5+WFjMb/Wy5h5+hid0D1saH0bmtub0PJtYBwTQtCS1ND+dYfvRwftff0kds/cKnsaYiQ
         xBlPPv2y46M213YLK9fKLlljUCEdzG9t2DGg+ftWxBqiyjdn7DOTicV7lird1mNBYrhR
         3wIYX8bi19QcqZi2mDSI1onnZ/pTdxSGY8FUuCscse6GMkuLvpyfDPLF4Iu2trbzDAsf
         +/FzKRq0SWd4PQtWdxc3bnF/QR7UvgW5zUGWRHyOAU8yAimxVhZRCcsR0Ol7iCRiwakN
         c6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728315946; x=1728920746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2N3r/AZHZIBAky01wN9j8Ij5Fk065LyhFYbUy+uaF2c=;
        b=Ifp859/m/ozV+kG1Q+BIJqD5e3o5FaDCHC7Q6qjMXTFttV9G4yBAldca5ukvS00Qao
         Du5EGsfVatazF1vriH3Bdi4uPzMOfAm4t91/0EdD0Enpf0erqjOSzQ6GUvtGm9w/ajzS
         +azYQcHKNdgLwJYwAQ4SujMQxEx5WjTtp0dT7nPFBWzsND07es9BvTl80IHYx2A+ENPk
         BR0iLl236lSNgYfNVD/TGIW2FBpcxPQTKjnM8BRr0BV/LZObHyBAMgET8UZWSzjWslQo
         TDRCcj+L7egmKylNYWT6OInl14gn1ezbOLTVf0P4kbE5jcDvBbvTng9MWSJX2jodr/OI
         v1rA==
X-Gm-Message-State: AOJu0YypDriuoSqgKfiDrw1WB+I9TP6n3rUw4CyVnnqO67fFvaOTPu1+
	xiK65CyWJh0zfIpkmfjP+QElLbFIq3WszFZyE0G1yFINW9T8Ez+Y+hcQ16rkYmU=
X-Google-Smtp-Source: AGHT+IEDWpQdUChMZda2za516f28LSsRDgkuitm2dp+DyXfGHYdrbMiUC8uCMuYFEG24q7l2cl7vCQ==
X-Received: by 2002:a05:600c:468f:b0:42c:af06:718 with SMTP id 5b1f17b1804b1-42f85aea086mr90117135e9.28.1728315945926;
        Mon, 07 Oct 2024 08:45:45 -0700 (PDT)
Received: from [192.168.1.64] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f9384f648sm17645555e9.20.2024.10.07.08.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 08:45:45 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 07 Oct 2024 17:45:45 +0200
Subject: [PATCH 2/6] dt-bindings: iio: adc: ad7380: fix ad7380-4 reference
 supply
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-ad7380-fix-supplies-v1-2-badcf813c9b9@baylibre.com>
References: <20241007-ad7380-fix-supplies-v1-0-badcf813c9b9@baylibre.com>
In-Reply-To: <20241007-ad7380-fix-supplies-v1-0-badcf813c9b9@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-doc@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.1

ad7380-4 is the only device from ad738x family that doesn't have an
internal reference. Moreover its external reference is called REFIN in
the datasheet while all other use REFIO as an optional external
reference. If refio-supply is omitted the internal reference is
used.

Fix the binding by adding refin-supply and makes it required for
ad7380-4 only.

Fixes: 1a291cc8ee17 ("dt-bindings: iio: adc: ad7380: add support for ad738x-4 4 channels variants")
Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7380.yaml        | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
index 72c51b3de97b..74d82721637c 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
@@ -58,6 +58,7 @@ properties:
   vcc-supply: true
   vlogic-supply: true
   refio-supply: true
+  refin-supply: true
 
   aina-supply:
     description:
@@ -127,6 +128,23 @@ allOf:
         ainc-supply: false
         aind-supply: false
 
+  # ad7380-4 uses refin-supply as external reference.
+  # All other chips from ad738x family use refio as optional external reference.
+  # When refio-supply is omitted, internal reference is used.
+  - if:
+      properties:
+        compatible:
+          enum:
+            - adi,ad7380-4
+    then:
+      properties:
+        refio-supply: false
+      required:
+        - refin-supply
+    else:
+      properties:
+        refin-supply: false
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>

-- 
2.46.0


