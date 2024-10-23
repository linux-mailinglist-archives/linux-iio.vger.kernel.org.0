Return-Path: <linux-iio+bounces-11013-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B489AD464
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 21:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8761F22857
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 19:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8E81D5AB6;
	Wed, 23 Oct 2024 19:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bloozLyU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460F21D5CF1;
	Wed, 23 Oct 2024 19:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729710007; cv=none; b=HrWkcJQQvYuqw0h1xQYz1OdXtpQId7VDwh8SclOu+RaTMj+TKaGsnBAb5En77ofaCqowXsgQhr1P42hDxyGKL+x43nvf6+LfaRTm0p9n4p/cJm5mj/3Y6GzAs316uNA5WL8bpyUhhsTVP3JXfD3tXkj5e0DSVrAtkDHCTqDu9YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729710007; c=relaxed/simple;
	bh=0QbXSZ/VFWwRmaW3c7Dri5JLq7UePxt3W8JVSJxI9Gg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D7tX17uApdoLwp/wJmbdoY7xnCangfcnKbGvQMJerHyuyeygwlb57Uygo9M0kL/oKnyLG20uptImuzLkBbXq8zWFEfrN+F1QuazRQGeiCrfdRcRgCr7RaKKc9uz7qUsLSOGXkiyv4OKHR+zwAWanlO9K10SD1rAMeDDQ7kEyAQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bloozLyU; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315baec69eso918925e9.2;
        Wed, 23 Oct 2024 12:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729710003; x=1730314803; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tTr96Cmd6Q/7UIWdN06ILTH6tOhiUGJjAmB4yFfW9A0=;
        b=bloozLyUgU8E9Z/dsLOUwxL4NoS3vVvI738EI1zNZGkCox5fPW5Qiwk8UQCmp810Qq
         tSHTVTPtOLBSjc+POG35YPmXHrTfxKwgrUuqO4er7A0qUrB9gmm1wEKoZUlyry0pAr0l
         sGYvXN4OtU0Sw2mXAmzIg4RtKpHgCfe05N0Pqgw2hWJNQ1kigrW+k8uPb7gcmyq6oOMM
         0kSNjH/Sr9j5vEsU6dlJj8ruwddlZ3KZGgntq3R0bFMY3syKRQnEe6VcVMKwBdcD4JZt
         qJG5XXsxRTFfDT4Gzkk0xsvIa5/+Pv1ddeLaUKdoaa4cd/fvx2TpBpfBES4Pn8bh9upi
         AiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729710003; x=1730314803;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTr96Cmd6Q/7UIWdN06ILTH6tOhiUGJjAmB4yFfW9A0=;
        b=KSPdb2o6sOosuCya/0E2JmGtx7Bsdfvxb/S90qXYwHmj7mA6hItB0PyWjtY35RKHQq
         jg0hVFXa6Aa4QnQP4tZf20lZfrWj5RmngG729vX6zH0301xvex4AOUxj/c75+kOk/yur
         99CJQxYHL8KtSZ7TyUhq+rc6reSSqiXiBvZfbYRWbv58cdqX5c3UxiQVif2Favkq4pQ7
         3j7F39lxN8HfXbJ3dVhS+fx5EgT2jmu6JSoVyTlVC1cQnJ8YPO1qwJ7MdgRQyiJnEZ1q
         HWdgZxqvulNoD/jVFTU9v74sDoyJsSzYq2arYuk9i6rOAIDY5A/TXr7TD5Fx8emDUqQh
         8N5A==
X-Forwarded-Encrypted: i=1; AJvYcCU/USZmKtrghIFIA9PcL1s8W1Bdlfv7iu5l+v0a7TncAmbmpStB4PCh8+vvoGcdKdXjMQFBvMKt/hg+tt4z@vger.kernel.org, AJvYcCU8p/32KO0nR/NLFFGPQvkaGc5BsegmsgfdwmRK96NnLuMEZTePQquAwJuJaUlY1tB1JRhBQrD8zOkn@vger.kernel.org
X-Gm-Message-State: AOJu0YxoPEwpjoapK93254Aas+oBYsa3EOx/EwAamAMsXjqXpAT/YcKW
	PWS/oJHojRqKgyb5zpDz5ICQPso4L5Vqh/az8i5+GRoYfwmtcVuC
X-Google-Smtp-Source: AGHT+IE1jaEi/Y8Atd54V2oCc6qoVS/slBMUfw844wGW2RTVKAa7Ru2GeVOdIgLFmEVictnULfXrvA==
X-Received: by 2002:a05:600c:3d0f:b0:42e:8d0d:bca5 with SMTP id 5b1f17b1804b1-431841ee366mr29484255e9.2.1729710003368;
        Wed, 23 Oct 2024 12:00:03 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b7f1-415d-4bfe-cca9.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b7f1:415d:4bfe:cca9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c3a707sm24176485e9.33.2024.10.23.12.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 12:00:01 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 23 Oct 2024 20:59:58 +0200
Subject: [PATCH v3 1/2] dt-bindings: iio: light: veml6030: add veml3235
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-veml3235-v3-1-8490f2622f9a@gmail.com>
References: <20241023-veml3235-v3-0-8490f2622f9a@gmail.com>
In-Reply-To: <20241023-veml3235-v3-0-8490f2622f9a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729709999; l=1972;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=0QbXSZ/VFWwRmaW3c7Dri5JLq7UePxt3W8JVSJxI9Gg=;
 b=n5Zi70m72F42BvY62vO+EPTk04z6Agc9Rn1FEqO3ZsjdjqnyVdr7oA3mSfjwj0vVKi6VBhfVf
 l7fFikOokkSDCSLLX9PY4KGutdBu2eoKGqJXuV86URdULN9f48PRXz8
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The veml3235 is another Vishay ambient light sensor that shares similar
properties with the other sensors covered by this bindings. In this
case, only the compatible, reg, and vdd-supply properties are required,
and the device does not have an interrupt line, like the already
supported veml7700.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
index 53b55575efd3..4ea69f1fdd63 100644
--- a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/light/vishay,veml6030.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: VEML6030, VEML6035 and VEML7700 Ambient Light Sensors (ALS)
+title: VEML3235, VEML6030, VEML6035 and VEML7700 Ambient Light Sensors (ALS)
 
 maintainers:
   - Rishi Gupta <gupt21@gmail.com>
@@ -20,6 +20,7 @@ description: |
   whenever configured threshold is crossed.
 
   Specifications about the sensors can be found at:
+    https://www.vishay.com/docs/80131/veml3235.pdf
     https://www.vishay.com/docs/84366/veml6030.pdf
     https://www.vishay.com/docs/84889/veml6035.pdf
     https://www.vishay.com/docs/84286/veml7700.pdf
@@ -27,6 +28,7 @@ description: |
 properties:
   compatible:
     enum:
+      - vishay,veml3235
       - vishay,veml6030
       - vishay,veml6035
       - vishay,veml7700
@@ -76,6 +78,7 @@ allOf:
       properties:
         compatible:
           enum:
+            - vishay,veml3235
             - vishay,veml7700
     then:
       properties:

-- 
2.43.0


