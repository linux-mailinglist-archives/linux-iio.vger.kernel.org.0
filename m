Return-Path: <linux-iio+bounces-23437-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28972B3CA5A
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 13:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5203C3ACDC9
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 11:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FCB27A124;
	Sat, 30 Aug 2025 11:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R+6edmvS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6076278158
	for <linux-iio@vger.kernel.org>; Sat, 30 Aug 2025 11:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756552191; cv=none; b=embor3cPzKQH6ARtkos3pKSAqjU3JckxzET1DIYG1wD0Kzppn9qSOoHY19VFcb4NVu2IjV0BW2p9zI/QV4XOutBgPlX6XpPl6LrE/9AHzq8HdcTMiYx8yLqsrAtsgRyBt2bb3kza5gUQNAQVyYKvAysQ/mBolnaYSHsANMpqzhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756552191; c=relaxed/simple;
	bh=MPAHQXQUpXiLCTcNCqhvtB/HRnhI8NNTl4O+MlOI1ks=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EUR81rnaj0NJNB3iqKP50nFzfxHyTduIdG3mi/e7sPJ2wKxnAsuLe/okGobYHcKwgRmD3b2RnSdYugtqgf49vzvLjJZsA1jXy+tOHc/4GNZ+RvDvTsyETO2apvJwh8f1od095B2QuYU7tlY3VH/eu2V86sNqLezmTFytiJMtFNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R+6edmvS; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61cbf01e472so507680a12.2
        for <linux-iio@vger.kernel.org>; Sat, 30 Aug 2025 04:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756552187; x=1757156987; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q1bivzFpeOn6zdj28AqutzvHysf6y4+jJdipsjR0D+8=;
        b=R+6edmvSTgpZasaFzAsQ+lD6ZV873Pt854QEgZ40y/MFYMC7Xwbco+yPP7kyWy6oSE
         5O7Bp2enDhmqbAeKjqlm2hFrPiRSwZm1MVzYs4tm48ziY9op8WLxxlpX0CCU6zT9kg3J
         3MmK5PsmYUatKBpDez5MXwjqOHGmqxsjNw/xtBsCYatZUXZ2RESef2Ef3xEp+/qdRsQ+
         KdOhW8ph4HoL9NBkVa5Vo2tK9AAcxeg6IZN6d3ZApGN1DxrQGMF+/Bo9GEX8caAQBg6P
         PEOq52fcO7QI3vnDTN/ODaF7YNp0pBrSG9Kfqzi75g/U218x+pA7cXcHuJmc5RqQetqZ
         CDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756552187; x=1757156987;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1bivzFpeOn6zdj28AqutzvHysf6y4+jJdipsjR0D+8=;
        b=DmfS3KEIaIeLmxdExG0atm/NTMblWA6vosbFzveZfH6y9frohPmf1HSOpnRzza8vkH
         wzMK7YXQS42iplzwioGDPdKmHPo2KjrWp2aV3052w8pWDuUHq4cC9dfd8o+Q7jhvOGIJ
         68039l6p25hpoJ+CjsZoOZowm50TSa/azQYFIqT3KyNQeSNrWc6Tq4Nd8HGqmq/TBuHZ
         LHiAalml7iaKsUXUMOh+7dIYeERGTKShdmKMeF11Lj9EpXnk9a/0D1F+XZW7N2GYE7C/
         wYBhD4neDNjnqEorXAL5ZPA/3ogXgH+h/FlLmAkzh/yrEP3mOGwTSzaPBZyOhm3vZi4h
         NI7w==
X-Gm-Message-State: AOJu0YxH36RRBOaP9Xv/L1m+lBu6NLDTtBo3/WCVZc/+VS1Mlr/YddhM
	ZBvSlDGIWX+dSYQFNfJHUCg1zJC6v9Avps6b2YjN43h1miW0V1kfsMOqvCQqcpr7Qt0=
X-Gm-Gg: ASbGnctFg6+vjn4svYeCAcwFWFJbuQPoSxTVrWjxpLvDo9ORrGVzVepfz8KNfOHgBeh
	w031pT5QjZYGkK/Xmy+pDlCKTS6daHDdqYfi7HTopbgkN9r9krVNju1S6iyzYtUm5e5jnpShGzq
	gXthgqEaz49wiat/A1EdWsWbQVbSV/NHV7x6mAvBwegHlVXYYCEDaHzSWfWfHjz4WrhsRGcs/YW
	vWS05QMmNrpmhH6xsHLUDvwbBec3Q9aJj3E+ufN35SFnBhPorWbLGIQ0Yf7BXsJHmtb8nAQ3W4l
	cAS70TBByaJc+BKtCM6Zdp+lGQN9g+EP3RfqXqFLYMaZWfGnLexX1wyGd44t5LclQhKlyESdmu2
	rZJrkmRDJMbpCWdXhmjTbA9a7zHTKR7XMBkdIYK4=
X-Google-Smtp-Source: AGHT+IGpcs58MTRBzy8QSSt3KOW9IS8qh2Op0/WrgMhV43qjpLPuJ3b/P2nf8GBfY6hwmjebLcg+qg==
X-Received: by 2002:a05:6402:13d0:b0:61b:6c51:4005 with SMTP id 4fb4d7f45d1cf-61d0d5f33e1mr2017383a12.6.1756552187107;
        Sat, 30 Aug 2025 04:09:47 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc21542asm3285666a12.18.2025.08.30.04.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 04:09:46 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/5] iio: adc: samsung: Simplify, cleanup and drop S3C2410
Date: Sat, 30 Aug 2025 13:09:37 +0200
Message-Id: <20250830-s3c-cleanup-adc-v1-0-de54dfb1d9ea@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPHbsmgC/x3MMQqAMAxA0atIZgOxUlq9ijiUGDUgVVoUQby7x
 fEN/z+QJalk6KsHklyadY8FTV0BryEugjoVgyFjybeEuWXkTUI8DwwTo2sCe+qct4agVEeSWe/
 /OIzv+wEe2WmDYQAAAA==
X-Change-ID: 20250830-s3c-cleanup-adc-71ac80978520
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=823;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=MPAHQXQUpXiLCTcNCqhvtB/HRnhI8NNTl4O+MlOI1ks=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBostvzlCuQP5FPquq2lhYn0JmEK8niYeKAbQ7wN
 pTrsnpP9/iJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLLb8wAKCRDBN2bmhouD
 12FBD/9nHRQw5vlITMhdnscAzkVchRhGAmmUR0TsJVYZWXUEaliQJvfLbtxlpMeVMjuKYp0I3pA
 bucWOuH6Ru1FmVobvchYI9wYkYN/bJbW/OrqEW0da4IFhoc257hS5IfAxMI8MPFiJ8FS72/Pnqq
 EFadIC0BdIb7wuTUBCsrjCwVK3qiCEl9x6hHgvr41iX2PXgh++T/iQ+g4ahIohcjpEKxqMEvZpN
 gPr54LMn0PJQfjpDQB7GleIm79NEzeWsE8Mr2dZ0J83ScSPtGfTkC7lM2iVexgp+rVvImGVnEwE
 lBPOiFT2/qDlh7Wo0ENT5OoUPG0ExHz8SKPOInwTgtKcQkv2/SwFc8ATWh+cDQApu5gUAp+wkMu
 ta/FWCmlApsWAqbrikqJ+1s94VlIUvF7YOE0Xhk2fIDSvGEYyVDWTZddzrR40IvAVRFTQAwJaHo
 uYuyL8iZWiFRE9lQkoeSBLVwHwIw/iWoEkTnxYdl17Q2tXXycUhEEk37c+tyOlySp+WVnvcjbkg
 6Y1zuMGNTygyiy+nbBP6cip/YYpNYxyHnsw7G11ysixC0kyoIQo/6Qfitz1RZTZjLE4m0qZ9bTp
 DiOYn1YxdktqnDSox2RwMIYtrNSpoPuoeBDLBCdEOJw70Mx28pgx92gz05qDEGKsTTBQXajEYx9
 5eOIUs/+TCK/y4g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

S3C2410 is gone from kernel, so we can drop its support and remaining
related pieces.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (5):
      iio: adc: exynos_adc: Drop S3C2410 support
      iio: adc: exynos_adc: Drop touchscreen support
      iio: adc: exynos_adc: Drop platform data support
      dt-bindings: iio: adc: samsung,exynos: Drop S3C2410
      dt-bindings: iio: adc: samsung,exynos: Drop touchscreen support

 .../bindings/iio/adc/samsung,exynos-adc.yaml       |  23 +-
 drivers/iio/adc/exynos_adc.c                       | 280 +--------------------
 2 files changed, 4 insertions(+), 299 deletions(-)
---
base-commit: 3cace99d63192a7250461b058279a42d91075d0c
change-id: 20250830-s3c-cleanup-adc-71ac80978520

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


