Return-Path: <linux-iio+bounces-19167-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2876EAA9C8F
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 21:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C0B67AC85E
	for <lists+linux-iio@lfdr.de>; Mon,  5 May 2025 19:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75E3279913;
	Mon,  5 May 2025 19:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="snba2dhZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0817B278143
	for <linux-iio@vger.kernel.org>; Mon,  5 May 2025 19:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746472959; cv=none; b=iNDw34OxynJ3o58itc0rBlAVM1sU0CeSw9LQO8qsdh8ChsOq+ajjJYG5dBAfr71V6M3/Gs6HxputZCG8N+g3ukC9eZnINaFjCzbK0AZCpH3N6cE2KH4mdJjPIoaqQ/cWiX9fBHUQU7WPs8bTnYxd0sot92keXZoG1wmNukW4x1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746472959; c=relaxed/simple;
	bh=woZ4lz73rZsU3uDIGwFORkcYXM8MzKKl2AxtHRksu1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rV+4T0EGM+qEpQmJawj/ACzUHKGYGXSuuPnWqHqtVqCsk5gmOt/0qdHuo+STnczMQZFx6wxxQv4BVJPxDXv4AaZ8aeh4HiwE0x1A7hJA3LccJVIc2p93IemQeUOed1cM82giEkyqGvGiYBg2Fe/uQ9fUEqcovgcotsi1rBQ5MDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=snba2dhZ; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-72c16e658f4so2813240a34.1
        for <linux-iio@vger.kernel.org>; Mon, 05 May 2025 12:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746472957; x=1747077757; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LByIDAchmcEufChFWQbH+s0Ti2HHvw4wiXz33sw8/Ro=;
        b=snba2dhZuM1g81skgcp0s2VbGwxnbrcSjSIW8SI+8qz5tYLaH/kp0f9LW9BUTgb0sj
         i852VKhnVNKnCfQGnnNkXpgLAfS4m/F0wUrVaBY43eCPBQCwHcLj1DTXOqJOL9eP2KeV
         N6tQiebE9lXNXh0AYPLVyIRqRN6OAOH6pSriQq4bTu5WIhQ1m2tVTP3uZ15wX29/PGGf
         KcHRAtiXp+22kIHRlspTf2J8wer4B2IxPC8cz4Xn+PA19npB0wD6ZnQ+peSeQo3/25sy
         r1VxxaG38BlzzPzXIdNu9LhWQuoQekdQZZUPjWFWtS9rsCOfEfY3QqZbWHR3sRHFjWNT
         w9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746472957; x=1747077757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LByIDAchmcEufChFWQbH+s0Ti2HHvw4wiXz33sw8/Ro=;
        b=ez2Lc/Du6yONPCJKKSOcdnWzFBWf5Ew8T9kkHpz55hUiEbo5c8VLQX7n4Gl8CD5MFu
         X4n6+gREYvQFEzXes8dMIwfyXJJ2E2wbYEhjyAb6EXXQrRX7qL6RVKVQ/O/3gPrhPtN+
         KRAqE7zarpGza2gBn+gEjTT9XyeOMiK+bUZsLqdcvZ9yto8juTbRFNH19+CqtKCKbLP4
         7wagz+jW8Kp4PmVuDtwLEZ5EuRT3bxVUfXVrVHyBMgFfonkP4/6pvXtrO5vA7yjttbsy
         lMLq8aAFofMUNPElGrKX9uj8ecksWerrOD+7dnN75E6knWfoWoJbpIXtNqXueK5RakWj
         VfFQ==
X-Gm-Message-State: AOJu0YycdMIppojjfhrNPHFrcWobkconm+j9DdpuQpkEfga7WvVjxZ/8
	QLaGjLvJWYWSHZFH9+h/8WC1fnGw5zKa8SHmwVlgSL3UGhGV3MbqLta0qM5Yk+c=
X-Gm-Gg: ASbGncvMsjVk1OXVqI0ZstPRUJTpv5QxKTAJNPPLVogDaQFGiJNmGMKmBlmtI5Rzcqx
	MI/gN3TZZXWrNm/Oz0v/kgw8gnL+7maKXNb99VEiilNtjWZFYT59v1LJP1LNS0DD6YBcmkXikDk
	MAu1rpMXxBQi6NUzN8A94xqKLh+3oDq7TMQx8kiipcJfH8FDPvI9weuhCajibueIrZRlddJLuKi
	a8+NCH+Dp8KraX/hB/4nErwepSZIFc/cAynEp4mNKLbc9Q4JMzaMs7YgIeIXX/YgwITe9wrCXO2
	S4TaNqU4GAzXuk0eDLq2mPwsVzJ8cciV1zvZePRENXzcIQ==
X-Google-Smtp-Source: AGHT+IGylEQxYRjmZfntPY+Ne/47DFT6SNOaHBZrW4Qdk/QT/pAd+7G/jDVvIVeAxzxnIX74dMLO8Q==
X-Received: by 2002:a05:6830:7009:b0:72b:94cc:4145 with SMTP id 46e09a7af769-731ead69406mr6815120a34.5.1746472957173;
        Mon, 05 May 2025 12:22:37 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:2151:6806:9b7:545d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-731d34daaedsm1683415a34.51.2025.05.05.12.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 12:22:36 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 05 May 2025 14:20:41 -0500
Subject: [PATCH 14/14] iio: pressure: zpa2326_spi: remove bits_per_word = 8
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-iio-remove-bits_per_word-8-v1-14-341f85fcfe11@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=818; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=woZ4lz73rZsU3uDIGwFORkcYXM8MzKKl2AxtHRksu1w=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoGQ/mdzZd6TKWJyJYAJUkkexWtskBG6pwbxJzd
 8XJQ+/8jIGJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaBkP5gAKCRDCzCAB/wGP
 wALaB/0UzTYy3QuI4RxqQIDv/5EVvtWzAvZbwCuf1+CjLoydQo1PU2nE8Hbgmm6f5WYKrZHBU1C
 luXg4ZcVDVrpKgXsXdXbfJ9qz5/C3F8kkFs5zdRBlcNu98CMAyxlbPIprhvWUI3gKeYIjU50EKb
 /1oVDAzaBtvJTct3XnEtIMSi62wqQGIE9Nz7/WJHVgqRJ+XGplDHBVYCDW+M7PClq6fGy4HR9Jv
 N5ymXoTFzO7ohwUu8ckCJJCsib4xXAnQ/Q/GnUcynTv2MpZMQLQzWyn4jChM4G2Op9IgNoQMk37
 Wn8Z18s3VzutqY5sjGCxTBAkKEhARyiarwMJm9/KSFcv4Go6
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Remove setting bits_per_word = 8 from the zpa2326 driver. This is the
default value for SPI transfers, so it is not necessary to explicitly
set it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/pressure/zpa2326_spi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/pressure/zpa2326_spi.c b/drivers/iio/pressure/zpa2326_spi.c
index 8a695b065a5fa40caee128b7eb8afe8485e72659..af756e2b0f313ab749ac0e83c6915912db0ff333 100644
--- a/drivers/iio/pressure/zpa2326_spi.c
+++ b/drivers/iio/pressure/zpa2326_spi.c
@@ -47,7 +47,6 @@ static int zpa2326_probe_spi(struct spi_device *spi)
 	 */
 	spi->mode = SPI_MODE_3;
 	spi->max_speed_hz = min(spi->max_speed_hz, 1000000U);
-	spi->bits_per_word = 8;
 	err = spi_setup(spi);
 	if (err < 0)
 		return err;

-- 
2.43.0


