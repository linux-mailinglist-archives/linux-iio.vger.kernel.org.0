Return-Path: <linux-iio+bounces-10669-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140D09A14F4
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 23:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45B731C22331
	for <lists+linux-iio@lfdr.de>; Wed, 16 Oct 2024 21:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE141D318F;
	Wed, 16 Oct 2024 21:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0KUR2hP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010EF1D2B37;
	Wed, 16 Oct 2024 21:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729114789; cv=none; b=Ry16FvX0uzHMWkXF0yVARBKkbUlZJPTJIiXy+f9bzid9w3DLr/QMD6qwvABA3HHn2zoySC+rpo0d/OTNFcdBCOR3gBHmT4bgWKZeNLDUdhPvhlOG0f1GIuYEtjI8zkZsLxcotd/hJL00P89ZHLpfLniy2OBPonFzZ0yC1/7oIko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729114789; c=relaxed/simple;
	bh=61d8qSHJRGLnh0Y9cAoOg5eCbhpt0hm3xU+QENAD7jA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VMRhbRb6KOf3k9Z8PWksYKMpPnAvkxf3ajm3RN9dsrTPRGa4MuXt3xqKLOgEZyo3EtmS9x6SvuR3EJvT44ykJdeU/9B3T4SaXhzyPHFE74lgcmWeZwICbD5M7cDvhTbGr1/mMn9a9F8GjpiW07Klm0ldMTOxmFbq747FOMMOnvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0KUR2hP; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-431137d12a5so2835085e9.1;
        Wed, 16 Oct 2024 14:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729114786; x=1729719586; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MgE9PDBrF4vGeAFO8wmq91SsT1HFW3hejwwqxsVL/l4=;
        b=O0KUR2hPEnhCy/Rb3niRsmuqmLIz8lEWvwrrRGPa2dglG+S2j3UD3W2nngKGyNNzGu
         JUCv32wdAIG/IVnQCKTHUuFwssM4QUn9u2hvWbcZqGjMQSlgCkgY7BW9DVAbheViQke8
         AbJj3Dpx5Y6nT/WSdRa3lyNg8PVOPq/Qa/y9OrVafrLTnkw5riD+1GtRlCW0UUZfDToT
         79TSx8kszDjSWS02/FiePy+WKjra37w3Wyh05KFterM948j6k+vZ5/rV2YWJhErXxWUY
         VAQbXXsFtkv9/RZ5Lw7WqduIek58qNZwksg35WqylUfY+PVLjN+9BCRI96P2gx54nLse
         CeXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729114786; x=1729719586;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgE9PDBrF4vGeAFO8wmq91SsT1HFW3hejwwqxsVL/l4=;
        b=YbNWnZhGop6uZ//aNNAH9euv1x0eg92bydwwzvo4t2kXABxqQumqsqp35ypJU4SQ6H
         Dh4tyQWxn9O5BngEt23zvaxkZkur9KQlupTuMwzhfMSRd08rCRNu9leVh296qeo4PZYh
         cDW1UjYzwHgSWtA7OiGVWzYGzz/X/GvPZQvdc0Qdh0AIgYDzUzVJKMB152QDpuRS6ZbW
         9sbHpBdfacFWSsee+KNVOSVH39GwIs1CEZNdBffjOVyx8giTY9VjJjXKuw22olADmwkT
         5ruM+128zDVC39UdrPLleLuKT+IhAmEHdR/0hgJ+XD5F1YA5Kx6oL+ibP+f5gedOk5/k
         YgbA==
X-Forwarded-Encrypted: i=1; AJvYcCVevlB/1a2YES+4p7f6kw+B6H2SLo2D+KbXJbYnLuXZPUwdHVz4sM4/QffDXFJPEx3kJTJQjp7yoSaA/rhV@vger.kernel.org, AJvYcCXxyQZHGyhnluNc7MtdP233hOJ3axmKNvpzTtzaH30nZbJUL/TPI6+r7n2n8e/dzqry0SPPUQVbM0G8@vger.kernel.org
X-Gm-Message-State: AOJu0YxGmD1P5vo3/Xvn2ZXoD6TKvCP0LZh+noqB9C/1p2lE4Lj5+7lk
	4Mv1ME/mjbQL3dfEuSu/tPuVcEntanXYE/KJd9EoOJEqqa4J8BLYiMg86w==
X-Google-Smtp-Source: AGHT+IHfLEnlsK51lT7YVdALVlFoZfGZWF1j76x4eXukfyyraKG79y+cIWGRvUaQESS71IQ+Z+aaTg==
X-Received: by 2002:a05:600c:3581:b0:430:5887:c238 with SMTP id 5b1f17b1804b1-4311decab1fmr176320995e9.11.1729114785857;
        Wed, 16 Oct 2024 14:39:45 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-33e3-844f-063e-de99.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:33e3:844f:63e:de99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43158c37f36sm5632715e9.7.2024.10.16.14.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 14:39:45 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 16 Oct 2024 23:39:31 +0200
Subject: [PATCH 1/2] dt-bindings: iio: light: veml6030: add veml3235
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-veml3235-v1-1-b904f802daef@gmail.com>
References: <20241016-veml3235-v1-0-b904f802daef@gmail.com>
In-Reply-To: <20241016-veml3235-v1-0-b904f802daef@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729114783; l=1908;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=61d8qSHJRGLnh0Y9cAoOg5eCbhpt0hm3xU+QENAD7jA=;
 b=OTa5FzLNzJSNCi1/TVe8xXQ9Twh2cRKiZVZZu+Cf/m+kkLs4ZYxLWyXNwfTXhdYJLHXzkvmjp
 BTSTpaBMFAjD8u7bV7QnSggYYcyVQEJKkkyUaIfAM84euGkFuM+DsxO
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The veml3235 is another Vishay ambient light sensor that shares similar
properties with the other sensors covered by this bindings. In this
case, only the compatible, reg, and vdd-supply properties are required,
and the device does not have an interrupt line, like the already
supported veml7700.

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


