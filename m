Return-Path: <linux-iio+bounces-11042-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2FA99AD8C7
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 01:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693E91F269FB
	for <lists+linux-iio@lfdr.de>; Wed, 23 Oct 2024 23:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D51920127E;
	Wed, 23 Oct 2024 23:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Iw4fq07Y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED33D200BA8
	for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 23:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729727693; cv=none; b=QNP0aXSIL3UXIbbQ5WxbuTNFZlKzHaog2C8+1TO/OQdAiv5A8B0W3+om0vEgGsM3QNaM7eLxzAMvSaTqmIEX2DlmZXMNy+aTg8PS5irlNpR0Ew9tQLGBRf6e8uDabCZ7HvGfQH/sF6xkbm9odeHTt7UnEQXUAz2hv5gj3ebnl70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729727693; c=relaxed/simple;
	bh=nUH5txR4P/Bv9EVLN478VLSNk/BVSj4cf6PubYC2e5w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E60riSF5hsJVnJQHSdbcWxilnzJG1gscJXI3QQmEZ7L7EcdgmJ3Eta6xGyWDbJi6sLTHSqfuSrVadYd3rzX7Pffc5YnRdp4D8SyU7WfbVTEVMeHoR/TK4zr7Hd2+b3yIuKsWEAslO7MiQKC22s4QgojiISSpwiyyBoozUOvTBe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Iw4fq07Y; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5ebbfcab9f4so138019eaf.2
        for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2024 16:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729727690; x=1730332490; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hYgkvqv4R1HU1dFN4HvN+5+Sd8/gJpr63Hs53U7tMP4=;
        b=Iw4fq07Yn/4+23EI13rcBmkximnUVWcPNnb0goK6aBcK1nd+Ja3gRArRp3vsnpLkyu
         EwnMp1XIUGcF6C6eAoVPFxsPnPNkH+CbHPHNvlQufgomsCSNFRG9LuDVA8wCbHTU4bV6
         CHGX9d692RLVFadGvThGFFe7uKynMheHuSwfwwP8KbMG5a6rPDxfh35ZtlD0Zf/oVbhH
         oqm4xH0ZLvNKyLw++GD2ssFt1AHcdZ8suU0nO+QkrHCJGvV6JPHFELLSTj0TlA+nORjn
         EouAW7MXJmiI+3C7xvqRyb/RnM0CZWf9fSqiKpsfii9EjKXPws60lYKpE/NuRVFgjdQI
         EbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729727690; x=1730332490;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hYgkvqv4R1HU1dFN4HvN+5+Sd8/gJpr63Hs53U7tMP4=;
        b=FPHs/TsCXQB75bRtd6/RmHfKEc8e8bVTvSwidpM5mY7a4u5M1GAIffcz8aTiirKeRO
         33B7q7neOOis0f8tu8qCWUDTvLWoD6VZNhmv8Gte1fgsxejEv9OxQoDgA8HlIYhKjSD1
         Y6YlXhEd1RZdmp8WPxYHlzCEkLKSmEgsjd9BNTZ+3+LWcpa6qCwL3CkYdbMy1bKiM4jF
         TPGsAVHW2ICyZDMCupfUh2lBMR/bwRh4FS8UcUmbuHGWFeR9oAHltZkg41LofRASgqW2
         ko30nRl2noeg8OU2CoTqAVD9Q98PR6ZPfGu5h4l1PK62IiIW+Y7iZeO/ZV92traRKYzc
         bjrw==
X-Forwarded-Encrypted: i=1; AJvYcCXYMrXaqUVBEbtUkP6uOWR21/vIdcUhiJsCER4uqj8sOiSXkpeChhJsGUKBz0WNeK2N1/Ccy2Pm8BM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUUIWal0HA2wJx/bWvmRU6uZpu8arPnjXxYn+9pMhm1e/WrF80
	glenWOeMDl2EV9y0DRgweNAY8k8HHVuRE+7IG8Whaqmi0R4IEwTjkiZyAjz1d/A=
X-Google-Smtp-Source: AGHT+IHcCxKyS2mmLHC5MPxm7YFL188H9iZp31keASBRo+Q1y9yvvaWEd8aS9jAZNjM885evSN5LsA==
X-Received: by 2002:a05:6820:1c9a:b0:5e5:7086:ebe8 with SMTP id 006d021491bc7-5ebee308838mr3087385eaf.0.1729727690124;
        Wed, 23 Oct 2024 16:54:50 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec02c2b25bsm132002eaf.39.2024.10.23.16.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 16:54:49 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 23 Oct 2024 18:54:09 -0500
Subject: [PATCH 05/11] iio: dac: ad5504: use
 devm_regulator_get_enable_read_voltage()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-iio-regulator-refactor-round-5-v1-5-d0bd396b3f50@baylibre.com>
References: <20241023-iio-regulator-refactor-round-5-v1-0-d0bd396b3f50@baylibre.com>
In-Reply-To: <20241023-iio-regulator-refactor-round-5-v1-0-d0bd396b3f50@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Simplify the code by using devm_regulator_get_enable_read_voltage().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ad5504.c | 52 ++++++++++++++----------------------------------
 1 file changed, 15 insertions(+), 37 deletions(-)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 305cd58cd257..f1717955ddcf 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -273,35 +273,27 @@ static int ad5504_probe(struct spi_device *spi)
 	const struct ad5504_platform_data *pdata = dev_get_platdata(&spi->dev);
 	struct iio_dev *indio_dev;
 	struct ad5504_state *st;
-	struct regulator *reg;
-	int ret, voltage_uv = 0;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
-	reg = devm_regulator_get(&spi->dev, "vcc");
-	if (!IS_ERR(reg)) {
-		ret = regulator_enable(reg);
-		if (ret)
-			return ret;
-
-		ret = regulator_get_voltage(reg);
-		if (ret < 0)
-			goto error_disable_reg;
-
-		voltage_uv = ret;
-	}
 
 	spi_set_drvdata(spi, indio_dev);
 	st = iio_priv(indio_dev);
-	if (voltage_uv)
-		st->vref_mv = voltage_uv / 1000;
-	else if (pdata)
-		st->vref_mv = pdata->vref_mv;
-	else
-		dev_warn(&spi->dev, "reference voltage unspecified\n");
 
-	st->reg = reg;
+	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vcc");
+	if (ret < 0 && ret != -ENODEV)
+		return ret;
+	if (ret == -ENODEV) {
+		if (pdata->vref_mv)
+			st->vref_mv = pdata->vref_mv;
+		else
+			dev_warn(&spi->dev, "reference voltage unspecified\n");
+	} else {
+		st->vref_mv = ret / 1000;
+	}
+
 	st->spi = spi;
 	indio_dev->name = spi_get_device_id(st->spi)->name;
 	indio_dev->info = &ad5504_info;
@@ -320,31 +312,17 @@ static int ad5504_probe(struct spi_device *spi)
 					   spi_get_device_id(st->spi)->name,
 					   indio_dev);
 		if (ret)
-			goto error_disable_reg;
+			return ret;
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		goto error_disable_reg;
-
-	return 0;
-
-error_disable_reg:
-	if (!IS_ERR(reg))
-		regulator_disable(reg);
-
-	return ret;
+	return iio_device_register(indio_dev);
 }
 
 static void ad5504_remove(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
-	struct ad5504_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
-
-	if (!IS_ERR(st->reg))
-		regulator_disable(st->reg);
 }
 
 static const struct spi_device_id ad5504_id[] = {

-- 
2.43.0


