Return-Path: <linux-iio+bounces-22909-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D19B29C13
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 10:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E15937ADBDA
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 08:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19163009E1;
	Mon, 18 Aug 2025 08:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuh4S3MI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE8D3009F0;
	Mon, 18 Aug 2025 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755505521; cv=none; b=hTA6fpo0ajZlrFKqHTpnBBoHALbMLuCcIIz6KkH1I4rFXwfUi9jxe25U4cs0L9f4ovwsgq4jEiooWeJAT87VyhRsuebxGQbo8To0DQMUzKCgVD8HlMHUr4R1+798D7OrcgILxWrQr1N/gTpJE34V0Wd6mE2oKkhvBJZ6ksRz08w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755505521; c=relaxed/simple;
	bh=ZvZrGT/fBSAGtvaz/SagDqn9V55PsR7z8yytvYw8F88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UgsBlZHdBR6+WdS9krADGAacQCOd0+OTvD1sGFpHV96oAd3qIVu66+yifUVinl2+BzGVma05+BgzwYPg3PFYjQ2zv8exqA5HJSTfUMqczbjvEDJuc0xoazFTQUYXxPFbJC1FLnmWd0c0bdDPh/V5s6R6NZmXHWbaSay9JLcJWNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuh4S3MI; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b05fe23so22279275e9.1;
        Mon, 18 Aug 2025 01:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755505517; x=1756110317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+Q7lY7WS+OoD2uetE2eNuKDumrNPHyxcErj74Jyyto=;
        b=iuh4S3MIiBKkEzRQtE9eUEdiauIzGUA6EnMKHk2LMh37rUiX3I90shYH0DmUOlCtmT
         ERJ4/RFN6EAYa0gdOU3vDPPjd73weK1Xk6xSZxNUMLy6Mhc3/ghoWlEluU+B3g07VIbV
         S0f/kQKz6rvbnSsZGBUteQI5JZ2ijbZR172ysiYeXkJ+uZEqWCCb/3bT5sYD4IkFGP80
         TUvpGmgKwqGsDbcDqHPWf8rTIg06mm/L5msiAWW8a/Sb3gc79Of+HUEbOutqXxA8lbZa
         NTYSQda3NI8ZIwfCe38kjxot162kcR/LWM1Pi7HH/Wzn/t+atAuWyO25iQEUKZAYzots
         WlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755505517; x=1756110317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+Q7lY7WS+OoD2uetE2eNuKDumrNPHyxcErj74Jyyto=;
        b=vFEN5k5NoFDZuDOmX+QTCXgZMRb8xuAWkr1pnayf0jO012PVa2cKyHWGCcr8/ZYoeU
         djDku8DtUtZlKqYN7vk0r9Fop3yEPu4CvWoCPNLMjwcHpLzXJi2WDKjzbj6I8aYmHuAL
         iM+nzOGe8ajJmM08yyk8cQt1i1rjpNNeaiKZEbcpXn1Eg4it7iF8jG8mr+jizapmWsE9
         8jT2RZdvO0LhsX1ZTz2KbWRgGgVQSYe2V4jjMRrs6TlgJJin+/rfohEzdTrDc3g3qzmr
         M4BjUpYQXQE/jPFtv0yjAsrwUcHZpHtKdje66IC8TwVBScszddldQhWyGRzFBlynd/aN
         Veng==
X-Forwarded-Encrypted: i=1; AJvYcCVyZHQmZwddHpc16DBIBjbaA+z1Sg9J8R9B4o9iBk45EkyWkQDkx9RbHRkzlSNoDYCScBZeAc7QVw/Xd5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSDHWdcvRLPcgHz7Ig79wSB5VkICgQqnpaMJJ2uFxkuBmkR5rN
	GswvVLubc2KWMAHsDCvjgbsCK0LYaySZhM8qhMA+B894QCjfjbvCHCTevktU0Q==
X-Gm-Gg: ASbGnctzXcp3whyPHA5zY5IMETmqEOLiLfyJNChwH1KOtZjIqT6AVNHICvkqsNrjo8z
	ZyYGBgLQbDSzDJ9iPveaSULEfZuE/qqqTZFUhL6DfAAw0Ze6iZKHv2dTmH3TA2M8m1bSBDMqV3k
	YHNSSDFDqR9pU7n6PSRquLrNtuDVCCCgDBJpGAAmHm8qcLpppubbbrIVcjFalcsCJt6Rakx1r9a
	3cv7p8DAH71OnFxVNM5jCKz7FQb1Moz/bw6ViCrAo6r9R/xFfL3T9lMU/Kyp7LmZWi8AtrL4Yqh
	O+TidHlmYVy19h9PEeOmRf6NSjiGUoq7XU4pSKHeYPEjQxxHTJkrzhTpGpzyftqtiivNtICHcNq
	lWYJ9Fnn5kNlR4LTuLciaX/D/R5Y2FAuERksxQTArwyUwHVElfg==
X-Google-Smtp-Source: AGHT+IFgGYo49vM6M6entrB9crar6NH3ry/CDCnc7D+FYrVz3F6DTq3Gh6c74VfnZJWmugGaGN424g==
X-Received: by 2002:a05:600c:c059:10b0:458:bc58:850c with SMTP id 5b1f17b1804b1-45a218013abmr49230285e9.1.1755505516571;
        Mon, 18 Aug 2025 01:25:16 -0700 (PDT)
Received: from localhost.localdomain ([196.235.158.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a223299ebsm126848085e9.23.2025.08.18.01.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 01:25:16 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	Markus.Elfring@web.de,
	salah.triki@gmail.com
Subject: [PATCH v3 2/2] iio: pressure: bmp280: Use gpiod_set_value_cansleep()
Date: Mon, 18 Aug 2025 09:23:31 +0100
Message-ID: <20250818082409.543197-3-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818082409.543197-1-salah.triki@gmail.com>
References: <20250818082409.543197-1-salah.triki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to `gpiod_set_value_cansleep()`, which is safe to use in
sleepable contexts like the driver probe function.

The `dev_info()` call has been removed as it was considered noisy and
is not necessary for normal driver operation.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/pressure/bmp280-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 6cdc8ed53520..656f6189c84c 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -3217,8 +3217,7 @@ int bmp280_common_probe(struct device *dev,
 		return dev_err_probe(dev, PTR_ERR(gpiod), "failed to get reset GPIO\n");
 
 	/* Deassert the signal */
-	dev_info(dev, "release reset\n");
-	gpiod_set_value(gpiod, 0);
+	gpiod_set_value_cansleep(gpiod, 0);
 
 	data->regmap = regmap;
 
-- 
2.43.0


