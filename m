Return-Path: <linux-iio+bounces-5567-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D988D8D6B76
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 23:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 774AA1F22271
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 21:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45968288F;
	Fri, 31 May 2024 21:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tSRAnerk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDB381207
	for <linux-iio@vger.kernel.org>; Fri, 31 May 2024 21:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717190389; cv=none; b=prVkeHBeHKPlimZdaOYEX1ysyWwqnr2TKyLUh6wcaK2Tz+LtChnnVtRlDeaOwGSyU05ZHFPul4Hjo6AYRCyzLipm9AKggYFhPWDf+5ZtHfEdYUQe4YLzJF1SDGvXeCtZer+ylF/udr8m/RbxAiNbEKV8wufZ6aow9qesJUPH7vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717190389; c=relaxed/simple;
	bh=djS+IstEEdXks4E5EEDzjApEn0V5RdWip5LOqYcuvWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ahYN551rLe5vGDbHU4Fe4fdXtP6VkijD17jerhNJ2BcBrhzklogwWF4SV36HVQJrXSb6liKrA59jtU0BrKzYt720/rNZaDLYzFYGF1Wkr8ZqrlMPN0xagGXEtAoagoODr4EapgEYH7pCy1kvqyasElgsbdO6h5XrYKenfj0gvV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tSRAnerk; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6f8d0a1e500so1932614a34.3
        for <linux-iio@vger.kernel.org>; Fri, 31 May 2024 14:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717190387; x=1717795187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbruLAt03fLjpCxeoEnwGhqppmXvGlKTLyJ4VcLSIfs=;
        b=tSRAnerk5KRJEGjFE5vM/YlwMV836v+xL2j3odbVfO+oWstKhUHtnx0u1G/ZP7Zx7g
         rSA4oVy9z7Kp/mYpeJfDhBIiga2sYY7V79kZ9QSIWiHTYuABQIDKlEuLq8pd6uY3ZgXb
         s3Wjnuyt6Df6tvSX4vSmDHK9jLjC22p4Dji0zYTPJJziwfcOpiWx9B4OA9SLQchiz+NY
         0qkjCqqpbUPDWGuiRggXxZs+lig9hKmvzxRVEjBOsxgAooLS/NBjRjpJrNMm6eeONmnJ
         maWYQvHWPj9BoC40kgtlsFrL2qq7399K1WrihnZXqZx6MQaDdstqA7bXkQ11tVHBemNc
         uM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717190387; x=1717795187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YbruLAt03fLjpCxeoEnwGhqppmXvGlKTLyJ4VcLSIfs=;
        b=fpaWmg3Dc1FePasf2CwqSlSc0YezhPymTAfFuLR2FGfkz1Q8B6BUZRgdSwwJyCZd01
         mqOuUB9uYuxpRgjgM3jXSlUS7QK22UVuOrLnL/IwX/u4wHN5HsC8EonFMJzZLn2w+rIe
         +q54Vr7rrNvCWDI+R/RPXdJ2j8qPchfUF3w2f/UUTmWZVI0POi1XxdWEuFdG+cROAsUo
         HKl4kAQgXx4DbB2Tl/mplwfN8hH58Hml6vBhtV4GNFFVrJkHZ+rxpklqd5f6u6aBRoR+
         GB6zKaNbQ7y4lAK8UVo0yoiaVi2rk4/Q7oVP+csVT9W2qnRSE1di72rlYzJO8jg5Vltq
         1JEA==
X-Forwarded-Encrypted: i=1; AJvYcCXIP8yNR1ILwp0kyzRp68wNI1xcTDh4QxjsWHSgc9gz2r+9lgW+eSsXAYi8vYE4zS6SGilPIqolruRTICfWPoeKXU0hyB+Y3GoT
X-Gm-Message-State: AOJu0YxeZyMfZT78Z6WVto6etY3qzk2uAH5VDrk8zDIsT2Tf9kBRrUE+
	Qm/P6b+04yjPhxQvRPzv37GRWm1fmFnqAG4nAVKSblX1HFQyDUha3LT4zU4pDJQ=
X-Google-Smtp-Source: AGHT+IFkz+cdXrbneX907Jl5UcLu0PioPNnv+0/npiT6mmWiF18kZTPeeLG91XQTRcQYGozZr/qoBw==
X-Received: by 2002:a05:6830:1e52:b0:6f0:6864:eee6 with SMTP id 46e09a7af769-6f911f2fea3mr3079003a34.10.1717190387135;
        Fri, 31 May 2024 14:19:47 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f91054f6c5sm470176a34.38.2024.05.31.14.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 14:19:46 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] iio: adc: ad7793: use devm_regulator_get_enable_read_voltage
Date: Fri, 31 May 2024 16:19:35 -0500
Message-ID: <20240531-iio-adc-ref-supply-refactor-v1-4-4b313c0615ad@baylibre.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531-iio-adc-ref-supply-refactor-v1-0-4b313c0615ad@baylibre.com>
References: <20240531-iio-adc-ref-supply-refactor-v1-0-4b313c0615ad@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This makes use of the new devm_regulator_get_enable_read_voltage()
function to reduce boilerplate code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7793.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index 5f8cb9aaac70..d4ad7e0b515a 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -152,7 +152,6 @@ struct ad7793_chip_info {
 
 struct ad7793_state {
 	const struct ad7793_chip_info	*chip_info;
-	struct regulator		*reg;
 	u16				int_vref_mv;
 	u16				mode;
 	u16				conf;
@@ -769,11 +768,6 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 	},
 };
 
-static void ad7793_reg_disable(void *reg)
-{
-	regulator_disable(reg);
-}
-
 static int ad7793_probe(struct spi_device *spi)
 {
 	const struct ad7793_platform_data *pdata = spi->dev.platform_data;
@@ -800,23 +794,11 @@ static int ad7793_probe(struct spi_device *spi)
 	ad_sd_init(&st->sd, indio_dev, spi, &ad7793_sigma_delta_info);
 
 	if (pdata->refsel != AD7793_REFSEL_INTERNAL) {
-		st->reg = devm_regulator_get(&spi->dev, "refin");
-		if (IS_ERR(st->reg))
-			return PTR_ERR(st->reg);
-
-		ret = regulator_enable(st->reg);
-		if (ret)
-			return ret;
-
-		ret = devm_add_action_or_reset(&spi->dev, ad7793_reg_disable, st->reg);
-		if (ret)
+		ret = devm_regulator_get_enable_read_voltage(&spi->dev, "refin");
+		if (ret < 0)
 			return ret;
 
-		vref_mv = regulator_get_voltage(st->reg);
-		if (vref_mv < 0)
-			return vref_mv;
-
-		vref_mv /= 1000;
+		vref_mv = ret / 1000;
 	} else {
 		vref_mv = 1170; /* Build-in ref */
 	}

-- 
2.45.1


