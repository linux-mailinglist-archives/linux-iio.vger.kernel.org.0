Return-Path: <linux-iio+bounces-19156-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24890AA9C77
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 21:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E56FC7AA893
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 19:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B421527464A;
	Mon,  5 May 2025 19:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iUu+bjOh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4FB2701C9
	for <linux-iio@vger.kernel.org>; Mon,  5 May 2025 19:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746472948; cv=none; b=uHmZtU0HHilELfu4ZDNqBTqlmJ8LOY2ixm43eUxrGX4JaptwZAIGUWZLQp0pCJDmcgVIeO58T2iRAr0U8cxhh4s/C2D0wn7IB3l/Xiv54eXf/zMTHYucIpRQEtR64NQXNBjpAkpFNLZ6Q8K/FEzv2ty68yC9j0jG2QZpJk2KJtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746472948; c=relaxed/simple;
	bh=eEbRtA/1AVtNKKSpkTMGRBnBrwhRCmUWINQFMAKTavk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t69TJEuNtymHD6bAW8D6wIw/8NXk2mUZC8ca2pwgR2kbtxGF7kDrzY+zEXi4RmGAOES4qLVgdExvo5kX/WVk0v6dnyUV9ud1DcVeIdA2ioiiStainrb43ix2r78tO5nClZF5cvgDobNtJibwzNqycMKQ20IP4xXxHzxiUP4R2fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iUu+bjOh; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3fe83c8cbdbso1407569b6e.3
        for <linux-iio@vger.kernel.org>; Mon, 05 May 2025 12:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746472945; x=1747077745; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UdhNP4X0/GICvJpAQY+7kUUTrTHMClamNEnMpORuZ1I=;
        b=iUu+bjOhcCuErP1nThW+4IctznKp8ujtGW1UlatUoCqoAxgK5dXKxMDWSEymUxsV/I
         HYc6FTv3BRlK8cBbO8ivnMCSw6Cxelnyi6iJImFcAyEv/S5AwAylsY6ce9KwtaeYq062
         myunxpYVlxgkCxt2sY0uJH10X14/MsDI+4oCM+Dbq+UkKNpu5MkBuwV9EBD7aytve2Mv
         Y2alkTBHvI1TTIPBk2o3tuLkFqwziVbInZ2gAMY1NyUdBMal9upxEf9XuLzpC0XWbQUV
         vmTfnY3tIF7pBvhew5gd2vA2G/23ZwFxVftP1lzp4vUF67E0zEl5RcG4TFo0shu3/xuD
         WAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746472945; x=1747077745;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UdhNP4X0/GICvJpAQY+7kUUTrTHMClamNEnMpORuZ1I=;
        b=kOPcuy8M4cYHI9VM4/GEoYcSXV6k3slFBMrcLMOEhtXg1KSxTFHqmdqrOYcIUekNIK
         /0zaCnZiE9Y4yhiwDrsEHMPGRBpxef9sewA6hvNRSPkO1LP2lEQwExVlnMuIX8OgDglV
         UuNcN3QxlYq1ZvfT/R4/ElKeMu8+m8/R23hKm6B/ySZOpVP4eh1XOEPDluHTrfWz/1Io
         fBbiViwyaQ7N9vZdWVoCsGMzUZvHUts5u2CR4pffea6LDRkp/Dr5dg1ROcqwahHxY3YB
         cHWUQbFscl5Me2QMVxnli2IoEix/zyXFniwVldU4l5rsTQKv/QhgS7wECr0K6mN5cH0f
         Tfow==
X-Gm-Message-State: AOJu0Yw9/dketVraZGuk6dH9MiM1ywmD/EOR81Iu5Ij1BXD3lLHoL/sr
	HH78bDZYeVUtVzsOx5fDJnE/Rz8g6NDQmvl82Tym6CF2StzSdSK5dz2LdQ0bZv0=
X-Gm-Gg: ASbGncuUjkOhDF+iuOyEqT+WjGGB2j+lYlnv84YrnYMK9AQp2Y40My+7RNTQCtCqI7c
	+khyTqApbQZW7upmoyaBshEGUZBdaYDMTg8h7RfU6QRHfsG+6NXRPsGLAgmHb+sQbFB3HstOSQs
	4b6Sy7r01Xph4MpBBmq8lV6sNJiw/K3AyeptOIHPYuba1wA0Kd2qLfQRMudyWHn/gGTRfztIM9L
	3KkvSNnQYTyJ+ORUEm2UaymJkS6G6oxW9U12aO3H3T4xhsLRSQu4Ls8ErLpLRwJVzxqTr/45QkO
	fEsiWAZHCFXCiAf+OK0+hOXY/j5NuvmWEEOTtVGOeaZyP0MaCkaDMhUq
X-Google-Smtp-Source: AGHT+IFP4LwculZpDHytgFOooYQO+DAe37OX6SW3bUx+SsxFcmn5CXLjoaf8bYal835tNPCOTXYE8Q==
X-Received: by 2002:a05:6808:4489:b0:3f9:8b5b:294c with SMTP id 5614622812f47-4035a5cb66fmr5946892b6e.31.1746472945262;
        Mon, 05 May 2025 12:22:25 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:2151:6806:9b7:545d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-731d34daaedsm1683415a34.51.2025.05.05.12.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 12:22:23 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 05 May 2025 14:20:29 -0500
Subject: [PATCH 02/14] iio: adc: ti-tsc2046: remove bits_per_word = 8
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-iio-remove-bits_per_word-8-v1-2-341f85fcfe11@baylibre.com>
References: <20250505-iio-remove-bits_per_word-8-v1-0-341f85fcfe11@baylibre.com>
In-Reply-To: <20250505-iio-remove-bits_per_word-8-v1-0-341f85fcfe11@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Esteban Blanc <eblanc@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Andy Shevchenko <andy@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>, 
 kernel@pengutronix.de, Song Qiang <songqiang1304521@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=769; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=eEbRtA/1AVtNKKSpkTMGRBnBrwhRCmUWINQFMAKTavk=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoGQ+TdyfFdvYnGSjQxnbn78dirXh7N6ymDOCSt
 p6Iw0xTwOuJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaBkPkwAKCRDCzCAB/wGP
 wNK2B/9t8MkypVvdiIhYPu9BWZjy0pVwj6ZzrIdSNRYIeMxUP6P6xr1urgyWmY+jtK96XZ03LDw
 I+rHBdNju9wVH9x3G8GiY5rETGj9GeqiVOHaWaONF5ICNW8joHnAnm+BP12udwiQZabd7PVLHPm
 N9VNWF03UgTT7QND9xjVOuqpFyJbt+Wka47CvmggvevcKmkTO25EsIHzpf17BjhY7oXHbD3wh57
 NWVO1A6nw3BXkbA8/+yexdX+DhUyPuQ1bdMBIm5f2jSeyu0hDnP2BmaedWqRkAp/G2IDHgU0Q7P
 PvF2AVLT8B8t11fCqLzfvuyahnca43WFdN5P7GqG51kqSdQC
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Remove setting bits_per_word = 8 from the ti-tsc2046 driver. This is the
default value for SPI transfers, so it is not necessary to explicitly
set it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ti-tsc2046.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
index 84a9a5e66526555b02497b105660c4822378483b..c2d2aada6772aae6fc8d01c3878d6e869d413bc7 100644
--- a/drivers/iio/adc/ti-tsc2046.c
+++ b/drivers/iio/adc/ti-tsc2046.c
@@ -761,7 +761,6 @@ static int tsc2046_adc_probe(struct spi_device *spi)
 	if (!dcfg)
 		return -EINVAL;
 
-	spi->bits_per_word = 8;
 	spi->mode &= ~SPI_MODE_X_MASK;
 	spi->mode |= SPI_MODE_0;
 	ret = spi_setup(spi);

-- 
2.43.0


