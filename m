Return-Path: <linux-iio+bounces-5252-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 362018CE2C0
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 11:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A101F21F8A
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 09:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E6E12A16B;
	Fri, 24 May 2024 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gj5YqF9x"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0777D129A79;
	Fri, 24 May 2024 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541244; cv=none; b=caGQVVKDJ2WF2fa1WYAkKW1ZCWnmp3AvSX084Whvt/JA6O3BCyLK8ypHi2i1iImSQHrajlP7pnTQPlCs25gmukczxn8wM7+xK+KH6SbOmru2ZkwfP9GfqYv8N8cc5r+lrffvgr8Y9j8tpn2jsCRWA3aw95W7GSXsvtJGKO4VIXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541244; c=relaxed/simple;
	bh=Y93nr4Z0MK7qQN4BiYCDu5objA4XgGBLJvKyetcWsvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ex6r/zpxBTOO58zZXu+rWQGRnGklUs+OSpJTSsUOZy9yACymUs5kZ5Wdk5oN6OlPnX8G0seJzDPPlTtcfN6xAxMLaJQ8HTyc315tilcsNDnRN6xfGVO5tfq/HGnqNprmijBJR2N6YiC8EoBWNinWWszfeK0dCn41MDSQfdMyl1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gj5YqF9x; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-574bf7ab218so13273618a12.1;
        Fri, 24 May 2024 02:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716541241; x=1717146041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IMduNn7RQfQDpRyojpA+r6mi6s/Qq6E8+WzsWYBouU=;
        b=Gj5YqF9xuDdmpJUB+TMpEOSw9YXO5H3eGT9j0T8f9+ouqkET0d2ik8w/Fcx5/BAEGd
         YbQxcxHjE15da1YUskYjMqn96o2dkq60/0/lD5U6yMCX47Vj7+fv75epDKf9M78PIt33
         EYM9ZYEEZ3BVJwAnDKuHmYjUeXTNQFh24Hr5zLRYXZYi6v+++r8TI+9Z1zN7YWdxtztC
         AT3CqrU32GPiPAZMwV04SXBcN8ZOJZ/+3vTUxp/2kAMV+Pl7jefMvuPFnaJB43jRK+gr
         wkvvQDzI4EjW7S16SpN0Z/WPqocLEMgZoa0LdDRqwVw6u2n2Ga4QbTeZCIwSVSxHywSO
         yC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716541241; x=1717146041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3IMduNn7RQfQDpRyojpA+r6mi6s/Qq6E8+WzsWYBouU=;
        b=VGSM5DgopfRKR8W+qCEwGHLvYY8SV1NR5tmUU7AJyfOX+ryzHWUWuhbubKCkdfT2QM
         VYTrQpOM4bXYvGknPaRHyW3+3VjW6y0iOLBNjo42hKnf5PRh5tdxQDOnd32kAzERpz6X
         1FCinLsu55uH0X2kM04PQYPWiHnt0vTyKpXs0oNXmnweuCB65B37pCymcboaaPquCXYI
         3qN90fCfkvS0DYYraQSJwuDUqWOApTn1aZM2yREhDFaN+NWxIPpJXRx6nEEx9sV48JOW
         GxVFDo8hLE1AagA/6zFDFeg8MTUdc1EV2IEQ40e6PPimQ8MW8E2yRWJzy5q0KG6i0z/b
         dENg==
X-Forwarded-Encrypted: i=1; AJvYcCU16yaMNwD/8kL8mj9dPJxuJdLMAjWfCFDqkadbK0t2F2cLYpDtoVA9oTxxV0hggAvegL7Df+Khup4li2zA1dCDKiVUpGo2zrQJxpR1FpOb0SRIVvntU7MlJeziolthM6bewOQzqA==
X-Gm-Message-State: AOJu0YyEjokw30gESUUmWcMT4V3L+0/lVdrvuc2o8owdrlOo5cjTY8am
	o+ucg4VKVxAYD4t5nTQ3W2a2KHNj6x70K+/DfoPqEMD3NbPmbkXXIUOnUP9VFac=
X-Google-Smtp-Source: AGHT+IGEbqO6QdDI31nKupNb5W4r+wwNi3Dp2LeiffLt1zV4dYQwBmQ5oi0J8rGSgQL0NkpiQgbLVw==
X-Received: by 2002:a17:906:bca:b0:a5c:eeb8:5215 with SMTP id a640c23a62f3a-a62642d9ccdmr101288066b.10.1716541240540;
        Fri, 24 May 2024 02:00:40 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:dac3:9bb:ed7a:184b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c93ae41sm97730466b.62.2024.05.24.02.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 02:00:40 -0700 (PDT)
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
Subject: [PATCH v4 02/10] drivers: iio: imu: Add support for ADIS16501
Date: Fri, 24 May 2024 12:00:23 +0300
Message-Id: <20240524090030.336427-3-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240524090030.336427-1-ramona.bolboaca13@gmail.com>
References: <20240524090030.336427-1-ramona.bolboaca13@gmail.com>
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
no changes in v4
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


