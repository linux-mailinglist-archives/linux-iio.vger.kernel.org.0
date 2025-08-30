Return-Path: <linux-iio+bounces-23441-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2395CB3CA69
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 13:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C26A203CD
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 11:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9E827F010;
	Sat, 30 Aug 2025 11:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mPrfzW2F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B971527A91D
	for <linux-iio@vger.kernel.org>; Sat, 30 Aug 2025 11:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756552197; cv=none; b=MFQY12jXIH2Vq06a014HNpDWXtRaEAiIfZen8cWj93AQvwHk3pfNzRQm1DPqFnXpkmWlgYBGrnBE6YwTVufpshb2aKWpSOvyt0vAY6pXsTxrJ/sp1Cvg73Xj8TJLtvmGElr16BzEYDtlEYPDnwGrLg6q5s+fodaCoNDA/YnrziM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756552197; c=relaxed/simple;
	bh=ebjPcUawDuyYiStYmNU5ZL3R3L1PNedniR0atYT+P1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D6ISzThCNjO6Zc3DjXQyxT8IAMP6jjuAgcGqiVfw1H+YjQxXZdeTfJgeNt5uhagRYsGcP/EomeZUCcE0JVAwdX6ZgjgKM8uV8TDRZ4i+KatRE8S5E1xq1+sHJe3AGG/MPyNYBkME0EMAF5RjHKgB7YYxmzIDKGwwlV1l7VquweU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mPrfzW2F; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61a54560c1fso664248a12.0
        for <linux-iio@vger.kernel.org>; Sat, 30 Aug 2025 04:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756552194; x=1757156994; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lR2F57pXZlUmDDCYEA5++08US32un21m5O7B8t3ZqrM=;
        b=mPrfzW2FAZs/rZYVYIW54R0ePY24K4rrShfDoq9q9tpXor8CpVQye8DDbKBqaow6/E
         9PPTu/UKnms4e80hiszzimSRSmyw+qpxRtv/i4WiJkeLekATrTSQlutenfdEJvn8qRL+
         O67zAdOsOZaBzUlGNvPot0YiKdYc5GMvoXCfZzg9JTnl5blFo4J8RFr590T5cGLsUHpl
         zFW8jeqcNYxr2u5fda7Cr0msc259RhQ60wmkXyeFwx/lBiU6uTYt9Ikpr3cfAi1wWwFg
         +7aUSqsJHJIq5ynqclCRA/u+73Wjs88wUmwdenu4XQ9vou8pZmg80sF4auPHqI0AmsHA
         GB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756552194; x=1757156994;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lR2F57pXZlUmDDCYEA5++08US32un21m5O7B8t3ZqrM=;
        b=iynfOokXfeVaLalmLjTmbCKMO2rMfvjAWhDgVsQ/oSv1aXSUISwRFNb5TSoNJozM+L
         jYm9Pc7raoEyCw3325UuMb9AWIJc/CxvpgQBhd9Ia61CimpCjBmeViUKUgT+TpD3T3v2
         P9+JaBLCBK11YccSD84uknFFi1Zf54YfYUdrkHRnc61V8E8dN5Luw3qLJHCuz+zBSVWm
         6MhuOJk2sGb71oux4VVxTpj9RY60kZgVm3TBaWEcOb8wD39tL0NxMVuq8ib0JtuXlUTr
         W/TluPZ/h17ld/Oero7XGdXTLrdKITSmbkjpzC11aSGmYPttlkuzRRz7Q351lfSSwiVP
         KcEA==
X-Gm-Message-State: AOJu0Yy0a7tfVob+5SrmIoQ5ClIvRpzdV04Lm3eMdHMawXgmCKz3DgiK
	bW76fK4UgWb2DwrKxmVyVMfBzEMrcv4PbiakAV1l2vjQPlvvu79Zar+hHD1ISf1vbiw=
X-Gm-Gg: ASbGnctwbn0bEWd3/6RFHPIR0AOfuMsvPA2Ii/sjzkxjyVmKWF98xXzWqWXKlIHNFq+
	j9BYJVtHFCXO+VFIvrH6flGT+7oJCBP+P016gzzFJVUH3HSQuEIuJ02pBOlGa4+Sj+ydUoiKBTN
	+i5ChIlwKx1mwB9PYgYA639gJ1aA5P7Wny+tYreFb3aqGisr37ceKw39FFfZB/gpLUBMWKW+H8w
	iRQnk+mnUiuyNUhsdgKdePucyD2PB1BhhOlZsWGJ1W3quK9u7GS8n6bQgyU5nQP0qO6fF3f016E
	WElnIM6n1FcvPubJ1UeNNlxy5/leRydmmQJH1M1iU8LHKztectEW4eVuf/+ynGYPWUnunTvepDr
	sdOPKcAd/9fmeem9x/GlHcFQv/axBUMwKbn5sWjc=
X-Google-Smtp-Source: AGHT+IEHg6IFH3LpvUBk8gtz2eV/nm1aGFtWrmsvGK8L0WqQQZfDuF8JLAEJnGWmJwRCGuoJqDkE/Q==
X-Received: by 2002:a05:6402:13d0:b0:61b:6c51:4005 with SMTP id 4fb4d7f45d1cf-61d0d5f33e1mr2017554a12.6.1756552194001;
        Sat, 30 Aug 2025 04:09:54 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc21542asm3285666a12.18.2025.08.30.04.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 04:09:53 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 30 Aug 2025 13:09:41 +0200
Subject: [PATCH 4/5] dt-bindings: iio: adc: samsung,exynos: Drop S3C2410
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-s3c-cleanup-adc-v1-4-de54dfb1d9ea@linaro.org>
References: <20250830-s3c-cleanup-adc-v1-0-de54dfb1d9ea@linaro.org>
In-Reply-To: <20250830-s3c-cleanup-adc-v1-0-de54dfb1d9ea@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1211;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ebjPcUawDuyYiStYmNU5ZL3R3L1PNedniR0atYT+P1Y=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBostv2ZO/eRzqfN09DvckB8iOzzLArEcasEJY79
 KGtOMomiLGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLLb9gAKCRDBN2bmhouD
 19RCD/4xQ3Lz5ArA1qhWwyYsVlyQlUrvZkfdqHYEi4Z3pihmEyrnxDe7VcRcaaLD5l5Hf32dvUh
 zkjHWB0psmPLTFsE/4DoNsY3zrb7K+pvqvyPzGOwO0rEG8V8Dl229/x16WBxhY5pG2Edn5s8Z7A
 asw6TY2NjoAQaK+oDCiskoRQDrAlif2cZNdNVuXnOt2k78SbnHcVimLj6zF5kwonj/FPfSonoYK
 ryXfKQkn3z5G6dWXHfgDtA4AZQ5UhHI5wSVZTOHt2h6jYkO+NEpE6d2CqdIbz2CWzA3POOJSYKl
 3fd1XN/yu104EEvJSPcbDdl6+vBj+9/kwfby/ALUtP4KXyiJ7LPWfau8DfZ1PK+9z5QE997+2vI
 nMfRgzL+nvN9A8ePeOCJy9HCpNDYCbDr3uip6Qb23fvPHgk3JJMx6oNeZktf7A6LGmo/FXZNBVl
 TYynjROY9z3MAaTYvzHBtZ5BxLgRVkSrGLlvQdba3HPFjZdFbqprdLoE+50cqEYb4Eam671dNtN
 Qc7wThoHCuER5UKtiP7QLTsTStp55A0RcXoDgLtSgVVwBepZYIezh1cmY6n815AnCErxAhuFRpp
 gcVthAWmYl0jzee1XHTrxwR/dWtZOehvKMDxXG+oJcyxqeugKVHoMrQsgfOddrfMiLlASAf8SWA
 GkMBVLmFCrHgKwg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Samsung S3C24xx family of SoCs was removed the Linux kernel in the
commit 61b7f8920b17 ("ARM: s3c: remove all s3c24xx support"), in January
2023.  There are no in-kernel users of remaining S3C24xx compatibles.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
index 8069e99ddac860b22c793c3ef9479f720cfd8c65..73d7ba0fda1def433a97d10bce21e762a307e36c 100644
--- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.yaml
@@ -18,10 +18,6 @@ properties:
           - samsung,exynos3250-adc
           - samsung,exynos4212-adc                # Exynos4212 and Exynos4412
           - samsung,exynos7-adc
-          - samsung,s3c2410-adc
-          - samsung,s3c2416-adc
-          - samsung,s3c2440-adc
-          - samsung,s3c2443-adc
           - samsung,s3c6410-adc
           - samsung,s5pv210-adc
       - items:

-- 
2.48.1


