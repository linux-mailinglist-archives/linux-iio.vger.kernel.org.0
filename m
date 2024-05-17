Return-Path: <linux-iio+bounces-5077-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 837968C81A5
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 09:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C2D1C20FC6
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 07:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CFD22EE8;
	Fri, 17 May 2024 07:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrpSkpZP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171371863C;
	Fri, 17 May 2024 07:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715932080; cv=none; b=P1uLjp6tPX+E2quxWjGHKMVLLlr2/OJtr4dqva4CA07zqrcvnxkNrFYhrc6KRUUypgyMpRx5pDlXA8QJz21+TD2W4aAgiCA33wj0Hg7tThkfECfqFj9GzXTWhJtvNLWEmu9zxFkAICgeGwdydudDTIsuBnQKO+p8EUKK4pGTDMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715932080; c=relaxed/simple;
	bh=/M+Q0BFUN+2FXUs+wAl0V3zqWuPRNngtMnjq4+cPLfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m4GexNAk0gKp2rwk1cc3kopntrmO/YtwzJ1lp4Yfh20nLpI+vKxTUdxso1Xz6eSf7Ne2NZaIyore5GBZNpCdqedKRHlbExyH5T4dAV/f347OcMlb4t+GiHgyInk0sUJ0SwZix6X3hyFxOpB4s7RmMraOgohFqfFLUtc/7D8nXGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrpSkpZP; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5238b7d0494so382821e87.3;
        Fri, 17 May 2024 00:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715932076; x=1716536876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWPqUXYjeLP9jBiu1bfABjffqq89QjIiuHCswnkbHKA=;
        b=ZrpSkpZP71JiMCd56s2pN6gXbflIGJ62d4WmuLkjkA5t71jyM1ava8axvDnfInboy6
         lmFDFXdmHnTV9kGosi63dm8DE4OUQQjqgXuFP21Zi0lCZIl5uqeir9h3cHnNi5BjSH+G
         vcN3a/Gr51/fYS7d/lQ99l8PdQNFAWudeqmQZNo9xe8Y+b4GKitsusf3MMjujv2v26Fr
         cOoXYe9H5AwtegiiZ4FzBvrgJB3idVxp/t2ZgRzqZZavUctBdVD4lEjdPm6vd8iun01o
         o8+B0GPcsefB2f+gUmpGGUOFHPQJoJ8F3HCtLKcTwMNWeMK7gInmxiwrT5pFS63CW2gq
         hv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715932076; x=1716536876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWPqUXYjeLP9jBiu1bfABjffqq89QjIiuHCswnkbHKA=;
        b=TN/GKbvtW/5Wla0Dn8mxOQZ48+wdSPENkj45SAeiwoVqUbQntL0ALosdsPpQXdLK2M
         Y/kJrlDlpcZt1X7dq0vdQU9zvpk3fVY0Fo5JixpVtgRprQYlza6LbavGGGbYuqCDjdVo
         LWxfXa0TjeE+T0zPfr8hfNLR7ejD4hob+qB11bv/zWBb8eUq8P8RPP+kEOcIRqg/vTJj
         0lhhDNdXf/A/Lb0JTBf/KstGvOsuS0iPsc8du4ebLgbN9EpW7ooYZ11p3pgVZ6iuSBBC
         aM91MUVd2FzZWOfm4uR1GvOoefYa1XbU1Uh9yD+vPMwEbQF60aIu1bVmURBmJyKRokl4
         pWTA==
X-Forwarded-Encrypted: i=1; AJvYcCVqj+5ZF1Ht+RszezSkV2FWRjWBqAgIAGqkf1QRI63jLuetNUPuSnsppA1bVfrnzA+mwCqtZ8vZ0vxWxDsRFK1pqYo3IjZqZ/uwf6Kldj65bmS/oB3Eg5/E1dsav2RV50qVkgi2QQ==
X-Gm-Message-State: AOJu0Yyd+qDm4Qywd8p0hAjDzuOObb5/iJT4NKbEqQCYFz0316usXyP3
	G1SILztb0kEdNX11EL6tYBxKNJYDBERO543RZsSM8GHNu/oCDS9jvHrbfo8HDSg=
X-Google-Smtp-Source: AGHT+IH06tewptO4rXbvHsMuftBTokZQyzHaJH3+3A6SCfMfSdB2RIbnU7q5LGdr/4FPxlkQQJmDXQ==
X-Received: by 2002:ac2:4bd0:0:b0:523:8d7f:5199 with SMTP id 2adb3069b0e04-5238d7f5495mr9962071e87.41.1715932076222;
        Fri, 17 May 2024 00:47:56 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:569e:359d:dfe4:922e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baacef2sm21104207f8f.85.2024.05.17.00.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 00:47:55 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org,
	nuno.sa@analog.com
Cc: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Subject: [PATCH v3 2/9] drivers: iio: imu: Add support for ADIS16501
Date: Fri, 17 May 2024 10:47:43 +0300
Message-Id: <20240517074750.87376-3-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240517074750.87376-1-ramona.bolboaca13@gmail.com>
References: <20240517074750.87376-1-ramona.bolboaca13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for ADIS16501 device in already existing ADIS16475
driver.

Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
---
no changes in v3
 drivers/iio/imu/Kconfig     |  4 ++--
 drivers/iio/imu/adis16475.c | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
index 52a155ff3250..782fb80e44c2 100644
--- a/drivers/iio/imu/Kconfig
+++ b/drivers/iio/imu/Kconfig
@@ -36,8 +36,8 @@ config ADIS16475
 	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
 	help
 	  Say yes here to build support for Analog Devices ADIS16470, ADIS16475,
-	  ADIS16477, ADIS16465, ADIS16467, ADIS16500, ADIS16505, ADIS16507 inertial
-	  sensors.
+	  ADIS16477, ADIS16465, ADIS16467, ADIS16500, ADIS16501, ADIS16505,
+	  ADIS16507 inertial sensors.

 	  To compile this driver as a module, choose M here: the module will be
 	  called adis16475.
diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 01f55cc902fa..53872b716f4a 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -661,6 +661,7 @@ enum adis16475_variant {
 	ADIS16467_2,
 	ADIS16467_3,
 	ADIS16500,
+	ADIS16501,
 	ADIS16505_1,
 	ADIS16505_2,
 	ADIS16505_3,
@@ -980,6 +981,25 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16500, &adis1650x_timeouts),
 	},
+	[ADIS16501] = {
+		.name = "adis16501",
+		.num_channels = ARRAY_SIZE(adis16477_channels),
+		.channels = adis16477_channels,
+		.gyro_max_val = 1,
+		.gyro_max_scale = IIO_RAD_TO_DEGREE(40 << 16),
+		.accel_max_val = 1,
+		.accel_max_scale = IIO_M_S_2_TO_G(800 << 16),
+		.temp_scale = 100,
+		.deltang_max_val = IIO_DEGREE_TO_RAD(720),
+		.deltvel_max_val = 125,
+		.int_clk = 2000,
+		.max_dec = 1999,
+		.sync = adis16475_sync_mode,
+		/* pulse sync not supported */
+		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
+		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
+		.adis_data = ADIS16475_DATA(16501, &adis1650x_timeouts),
+	},
 	[ADIS16505_1] = {
 		.name = "adis16505-1",
 		.num_channels = ARRAY_SIZE(adis16477_channels),
@@ -1482,6 +1502,8 @@ static const struct of_device_id adis16475_of_match[] = {
 		.data = &adis16475_chip_info[ADIS16467_3] },
 	{ .compatible = "adi,adis16500",
 		.data = &adis16475_chip_info[ADIS16500] },
+	{ .compatible = "adi,adis16501",
+		.data = &adis16475_chip_info[ADIS16501] },
 	{ .compatible = "adi,adis16505-1",
 		.data = &adis16475_chip_info[ADIS16505_1] },
 	{ .compatible = "adi,adis16505-2",
@@ -1513,6 +1535,7 @@ static const struct spi_device_id adis16475_ids[] = {
 	{ "adis16467-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16467_2] },
 	{ "adis16467-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16467_3] },
 	{ "adis16500", (kernel_ulong_t)&adis16475_chip_info[ADIS16500] },
+	{ "adis16501", (kernel_ulong_t)&adis16475_chip_info[ADIS16501] },
 	{ "adis16505-1", (kernel_ulong_t)&adis16475_chip_info[ADIS16505_1] },
 	{ "adis16505-2", (kernel_ulong_t)&adis16475_chip_info[ADIS16505_2] },
 	{ "adis16505-3", (kernel_ulong_t)&adis16475_chip_info[ADIS16505_3] },
--
2.34.1


