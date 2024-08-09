Return-Path: <linux-iio+bounces-8363-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A785F94D190
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 15:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B91621C20A96
	for <lists+linux-iio@lfdr.de>; Fri,  9 Aug 2024 13:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE940194C6E;
	Fri,  9 Aug 2024 13:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVAR0fXd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E2718C925;
	Fri,  9 Aug 2024 13:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723211355; cv=none; b=WR8KR22BQ3pFPBkJx/zHE+G3xxeHSJxg2cx/obvgBxREgV86MISx0u7n3XxwU/LimZ3W7PafjRaFnT4UCX7FtMydLDmKHlc+zSHPeYpAu0UzXvDHNi6erAO84PoQ6ti7Tb+mhWKNwxBU1uRE//xl5PfGI+hSS8e5Jm1XDLLttOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723211355; c=relaxed/simple;
	bh=ZjiwsrSFa0t8o6fGNq60V9Drb5brqlNaEu8OYuhug+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JuNJil30UsymCTAc85FGyk+c/8PU8ILQRc2dRtfTFQZG8qPN5V0+RtgE5e/S35fdI3U7i/BGfscmAUmXlnMLZdZWy6x3xS/ESNxA9ZD+uDUJXpFpxTAHUHFADFUZPvZtD/io34jEfvCIHoaHO7DkG2uSrq/ZEF2xFFj+FxVH3T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVAR0fXd; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5b3fff87e6bso2306389a12.0;
        Fri, 09 Aug 2024 06:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723211352; x=1723816152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1sSUf6K1mg1eTJFMtYJO/PWYF/2PWB2qfNRQMe6qLvY=;
        b=eVAR0fXdHtIStT+0iCfEy8Xwx8oY53qhVFTKRPN02Y1SoGFgfSf9i8T5XOcNhqpw6J
         tT03fejma2zLSqk0pJLYgOdug8TAZkPPzggD2XrGPGF0jKHQuHuo+R4USju8ljrIU2Rt
         ovIdBk9goSu8XqqNeQc75VJsar+NFQRnZLOhNRoTrX2bd32u958Ig4MAAvdoDvCEccBo
         1fmOFCkru9JMOl1aYzREHCZtBtqhatVVSV+9WB4JeyqfbEfgIJ4Vgelcxz2jKU7wNZuv
         0AOVVwgN2OftziI0UcN5LcnxlVMb8PvC+iWdU1UGXnrpSZp2/QQTsNNatjOaklSvwSwc
         rA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723211352; x=1723816152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1sSUf6K1mg1eTJFMtYJO/PWYF/2PWB2qfNRQMe6qLvY=;
        b=twlb6AwwjONMmTxAdRO5OS67Xaq374nnziKH6yTVfTr254+WVZaZ/f4vsxgPcHVh+h
         cPMG5R8CSDtzQgmwE4sZghnTQfomG5EuaBGR4mS5ZH7OSs+lXWvdXvoVclbc+4q5dP0p
         ThT7PjHeuh+doaMmRVOOyvbp3MiJk1Jy7b4ROkcBD858wd6nl8HOzy1XkIyyzO6I9BEU
         XntAimwPR6JSAdZlWlITLmO0wVycFi6Zh/41573AdJa93cu4Vx5iOJsS1uEy02Tow/cC
         /+UznqVQOIvpjvhtXIM4JJDu6/+DTO1KW7TSmFc7w8AbkdRtNyBGKaab3gtr3EwPRqJT
         lPrA==
X-Forwarded-Encrypted: i=1; AJvYcCVSfzRkSM6LcVa7FxN+B4a8fxdn1g3DVpXR/YiJj6Fsp0Pseem2zXTr1fxl2pVuCMB5mF7xJsTWV4HCLDK69bF6EdNS+UFGZCcsJPBu9L6Z5m7sVDVL+L+Z+bs5K9bW3ZkeBBCTPIrp
X-Gm-Message-State: AOJu0Yyufr/0KIVGSG1LAVCuR2/TfTZmVEUfpp2J34QJuDGlox7PH7Uz
	TWqBcxI+MRUQDkuTkCzE4Pz8czkDejsz1TXRbgIuEvczp8SGDZ55
X-Google-Smtp-Source: AGHT+IFCzxVQaNZvkzO3F5IqJ9BbNONwpS3CmngsyJ/4FoqCY2dBB/dll4l8gA9xCqzt9qVC0kiriA==
X-Received: by 2002:a05:6402:2344:b0:5a2:1693:1a24 with SMTP id 4fb4d7f45d1cf-5bd0a5759c5mr1250813a12.15.1723211351860;
        Fri, 09 Aug 2024 06:49:11 -0700 (PDT)
Received: from HYB-hhAwRlzzMZb.ad.analog.com ([83.103.132.21])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2bf9e64sm1535512a12.11.2024.08.09.06.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 06:49:11 -0700 (PDT)
From: Dumitru Ceclan <mitrutzceclan@gmail.com>
X-Google-Original-From: Dumitru Ceclan <dumitru.ceclan@analog.com>
To: mitrutzceclan@gmail.com
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	dumitru.ceclan@analog.com0,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dumitru Ceclan <dumitru.ceclan@analog.com>
Subject: [PATCH] iio: adc: ad7173: fix GPIO device info
Date: Fri,  9 Aug 2024 16:49:08 +0300
Message-ID: <20240809134909.26829-1-dumitru.ceclan@analog.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Models AD4114/5/6 have .higher_gpio_bits = true. This is not correct as
the only models that have the GPIO bits to a higher position are AD4111/2.

Fix by removing the higher_gpio_bits = true from the AD4114/5/6 models.

Fixes: 13d12e3ad12d ("iio: adc: ad7173: Add support for AD411x devices")
Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
---
 drivers/iio/adc/ad7173.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 9544bf7142ad..b77e2beb502a 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -302,7 +302,6 @@ static const struct ad7173_device_info ad4114_device_info = {
 	.num_configs = 8,
 	.num_voltage_in = 16,
 	.num_gpios = 4,
-	.higher_gpio_bits = true,
 	.has_vincom_input = true,
 	.has_temp = true,
 	.has_input_buf = true,
@@ -320,7 +319,6 @@ static const struct ad7173_device_info ad4115_device_info = {
 	.num_configs = 8,
 	.num_voltage_in = 16,
 	.num_gpios = 4,
-	.higher_gpio_bits = true,
 	.has_vincom_input = true,
 	.has_temp = true,
 	.has_input_buf = true,
@@ -338,7 +336,6 @@ static const struct ad7173_device_info ad4116_device_info = {
 	.num_configs = 8,
 	.num_voltage_in = 16,
 	.num_gpios = 4,
-	.higher_gpio_bits = true,
 	.has_vincom_input = true,
 	.has_temp = true,
 	.has_input_buf = true,
-- 
2.43.0


