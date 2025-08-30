Return-Path: <linux-iio+bounces-23440-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4294CB3CA66
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 13:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99B65A0103A
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 11:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A884727B355;
	Sat, 30 Aug 2025 11:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IFi8f7TC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7104E27B35C
	for <linux-iio@vger.kernel.org>; Sat, 30 Aug 2025 11:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756552196; cv=none; b=a3uqBRcIABkT/QutTB2Pq3PnzFyF1x+QV8DaOD/pOeAp3ek9qJvbB9YIur3D/3+FJ4s3j7PaE9PRYAav29jebn+MdUr3S0dfGH3qqdrXprY6dt8legeKupYRP0KyP2d4L88PfKQcutArhAIPl7RE3nnJS+mvm2Aa28ngDRlFYLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756552196; c=relaxed/simple;
	bh=KjoP2OpIwgvcEU8lQlbyugpaZUrY36rc56GQiCq2XW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=amZsoBH8uRZGZGvQ+OMe2rnTOXR9ZURoabexTJ5Di7YFkmZzWkZfKz0wTBVL2K/eNu+kXnueyPnpexejc60bbKr1tO5paIaZfLEyROawVPf+5jHv+4mKJlP4bN5aT6g4ARVVmkpXw8a8X76j4++7SVNKfrw0Ki6yL5KinlkDk40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IFi8f7TC; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afe6a3ba50aso36311566b.1
        for <linux-iio@vger.kernel.org>; Sat, 30 Aug 2025 04:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756552192; x=1757156992; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jbqsXZ0a+2gRMmLHMi/t44FvhwPty9xFovSO5BTpK8k=;
        b=IFi8f7TCxN+nVFQuDVoK8TIJzUUDh12mv1OLrds3nptTbnaoVcikWPjB9L/um1NBPH
         HMWS5F24ez7u0k1mWUAHSSusIBq+Xlf29b0sIQ0WpPUyd7Iuzscj4UMwR6jqzGu13idI
         8HQxqbQ82Omv9rLXfQh7tgwosc8abC1xLdPUTBnh/fMh00zUg+/VfWXPq9GwuQlLxLJo
         4OCJab1EFItjJhXBaw4aNdO31ppnBCxreUKYIDVAtvprErnk8DqSBzIzsiJiPGtxKlLv
         ugDayC4pjjjegsrZf5/U4d9uQ+dLqYF+zxKUyncSfAq+zcWNek10CQHxxMxNJcXrWTT7
         StZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756552192; x=1757156992;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbqsXZ0a+2gRMmLHMi/t44FvhwPty9xFovSO5BTpK8k=;
        b=QXtmTuiWclKkiiyx5cRcylTfG3+Mk7TQWRjdMjomIECwl1g2srYGjXzDxtM29ZkbuH
         hXCC/3SGI957pRBWXc7UZjpG9I5Sgd2iVvC1z0MIeXDztmqenPqEz1WKKIRiQGfvmM2r
         r+LBjWaCBFEO9O4WtisYdSiXUMqaRkuVVnaVIcyLD8C8bW6DubOJC45HxgcPR07tGjVI
         oHbGyMh94WxZ1cYxb4isEAAxx3Xx3i/ayUf3nAoCEIU10fPzwtKmSd0hcZ67yU/eQvoi
         lMG1x2prrb0oKd9aNSaMI//Ppz5R3plP7MZYxoWWJ2QwWlUoNy67CmeO2NLLgCRmkNLH
         FWKw==
X-Gm-Message-State: AOJu0YyYrMNn5u0kvFhBKFdz0YWCCRM0uihSwslINPjqp/1MFY6SVeCt
	3ydpGtl/7VOryniVkq1RZQwRCOXV8eXz4urSevUnskPxMUrIEOE/TIsgGSjtr7sAbZo=
X-Gm-Gg: ASbGncuZBXWw91CynyP2e5CyjpKUwTNIMPEa1TwWvEgwlZR6OQ3KKVnD0twdvDuS96j
	0pDELfdpHBgfdDAUSqDUYAffv/XlM/M58cQF2hfzOGEfD1rHdeNss5taBpmZRk/oKvVwl7ohik5
	2NzEMPNR2/cTFYEwL5amPR8nj6N+dZHV6IcDKvKrofhisQwD42xqfeO6k7WiwwWz2zdK2boOTCo
	Srw8Inn8U4u+Sd/vJBpgu8Ji3YfZ/iDcv0cc2tjn37Q4LeCcmKu/PDdkMQEuQ3g/bEmu+tBz7/x
	wtXT6EOX91PjWkjGes6qQMQgS5FD8A4fRcxhTIzJ7YYsq4k8af46V9czYqD/XCJm3DKajbHrxJW
	Tm6cn4r9maa7sC9HsQBDuLYNIx4GwtK7kpt4zEJA=
X-Google-Smtp-Source: AGHT+IHYI3tcuSfMfYLyvgkgErLnZ1GzeCpm9S3JwFpVHykTzgSrhsFx7MfV7tYp5tXNWutnC3a91w==
X-Received: by 2002:a05:6402:354c:b0:61c:d7e5:47a3 with SMTP id 4fb4d7f45d1cf-61d0d365421mr1981474a12.3.1756552192554;
        Sat, 30 Aug 2025 04:09:52 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc21542asm3285666a12.18.2025.08.30.04.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 04:09:52 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sat, 30 Aug 2025 13:09:40 +0200
Subject: [PATCH 3/5] iio: adc: exynos_adc: Drop platform data support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250830-s3c-cleanup-adc-v1-3-de54dfb1d9ea@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1736;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=KjoP2OpIwgvcEU8lQlbyugpaZUrY36rc56GQiCq2XW0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBostv13VGu7FUVwm7lV7kKSuqLAH95o21fWUsyk
 kZGd4D32xyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLLb9QAKCRDBN2bmhouD
 1xCpD/9RsBrZtrfnGAO6kOBtpZf3RsuYS4WozEoGAPOZ/+LUFG7GyY6PHdLh04yO0tyeru9lmnl
 NWiyylXT161JodBZBtmPzVGF03rHBTAOUplPZd5paYxfpJwt8PJb/xHmt+0xSbnapKtKq200hOX
 EUPwCpJQ9D8g6nPMbYUQ6Ens7xPCUMXbhA29e7wK9UBBL0oTOeUZRaBbz4p0phSh1Jm1shYTVXp
 QngUaBT09dvDLQfrg9tGI+JBpDndf89JRLDDK3yQ/Vj813uwCaXSU3NmD0OKS/vtuUyzo/J0OIt
 8vVneJFmFtj4xhz1JdbVUnA8vMsGRMZLf/f0M9GRJHxy7pHzmzW6OUolCzk+CHo3KCQgbOY1coA
 6v46Kib9uoMtvr7Y+3aQb0c+2zWCV24+9ia905h/shhAk8pEhuZun2FPDPiUxSr490p1irdBmt0
 6OCDoUzRL5lkSOt6avOdIL9235r4vBEvl2HvUzT9elT+Z6862INH90abu3DWL6oAm+rk4O2k401
 /PuIEEZckhNUQTxHX/j6Hsvdc+1QQgbLp5dQXn/VfZp8fCYyNy6NE+jvz2674Gdvk0LFg9KbCrn
 v26uvKiam2qS5ejw+6+GF74I/T7rOXWawPDPYNvrAjuXZOsC2O1WHTbgNsWyDAC4U4RJ3YDi9gQ
 EEPu7EfKv7b8Umg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

There are no Samsung Exynos SoC ADC driver users which bind via platform
ID, thus platform data is never set and can be dropped.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iio/adc/exynos_adc.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 30f6d8436e775a8d2177951b436cd45152307ea2..dd1494ee365a7b34d6b485ee4c9e753f50b5ff26 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -106,7 +106,6 @@ struct exynos_adc {
 	struct clk		*clk;
 	struct clk		*sclk;
 	unsigned int		irq;
-	unsigned int		delay;
 	struct regulator	*vdd;
 
 	struct completion	completion;
@@ -213,7 +212,7 @@ static void exynos_adc_v1_init_hw(struct exynos_adc *info)
 	writel(con1, ADC_V1_CON(info->regs));
 
 	/* set touchscreen delay */
-	writel(info->delay, ADC_V1_DLY(info->regs));
+	writel(10000, ADC_V1_DLY(info->regs));
 }
 
 static void exynos_adc_v1_exit_hw(struct exynos_adc *info)
@@ -556,7 +555,6 @@ static int exynos_adc_probe(struct platform_device *pdev)
 {
 	struct exynos_adc *info = NULL;
 	struct device_node *np = pdev->dev.of_node;
-	struct s3c2410_ts_mach_info *pdata = dev_get_platdata(&pdev->dev);
 	struct iio_dev *indio_dev = NULL;
 	int ret;
 	int irq;
@@ -657,11 +655,6 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	if (info->data->init_hw)
 		info->data->init_hw(info);
 
-	if (pdata)
-		info->delay = pdata->delay;
-	else
-		info->delay = 10000;
-
 	ret = of_platform_populate(np, exynos_adc_match, NULL, &indio_dev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed adding child nodes\n");

-- 
2.48.1


