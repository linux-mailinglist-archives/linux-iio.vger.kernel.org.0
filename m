Return-Path: <linux-iio+bounces-4877-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3324C8BFE1B
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 15:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5F71F230D8
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 13:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8677C6D5;
	Wed,  8 May 2024 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpyB6iJO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F456FE2A;
	Wed,  8 May 2024 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715174000; cv=none; b=eJQsr2otndfUzWQ8FwwK/bORpNLeXxjnpDHR3NNXgRlPVmQTIcz2KXCY5Ck2zaW7sHWcqoLk7EbgCqSjooL83i5YaC68IdnEb1nf442/C6eBT1+tYDIYJwGt84RQChhaflbHfjmRaX9nLLuxZRsERDkaHPlw3o7BplNU1emdUwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715174000; c=relaxed/simple;
	bh=svYcDWxFrzhEVruACAIUlqBusjkXHfKQP7gjR3oAUCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=raNM7i4MfqgR+nVDnA0v+CraiS12li7UIZ+FOEcJFXkAH2Z7IJ/F2ytfUSJSRoGZufXrBj38ezHgmkaLq7ui1VOL8kb1Kd1+if3ySEvlHg2Lz5Oy9SPZ0W1Gg2TQXyPfS/jAMlvJk6+GQu3vT52+jRHn0Yk8ftywY1PVOF/51Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpyB6iJO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41b79450f78so29273245e9.2;
        Wed, 08 May 2024 06:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715173996; x=1715778796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3D5G94gdRt6LkMerSlAzNCYSn8ggN7fyN2o/SaJ5ijg=;
        b=VpyB6iJOExThJk71suAuSwzM25+fAsFo1I5hlf26e+Kp6/1vnHTv2eZOm0WQEVb8FP
         w6sJ+QhTYvZY53rJcXJ487FuxYDI4W7y+JbHdRz8F6tQK89cGJxCBB1wNvssrlPotodD
         jSttwpxr6QerVSphIQKzBxzHibk+Hemb8yoBvYEgyGaDMrGpCL6N8uKBvEjx6Y3JPKxw
         hkzmJButM/WvIWqnaBnaiuJqYVSNvtfoEh2Lrqq1pnWbAtLN3u+i9gEqphTqlrG1MAkX
         /RFq11znL+s1U/cONvWRbo0+dWrIYRuUfkgNRRYI2CIlop28iO/wNLe4BgnVhgXDZ1d4
         iQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715173996; x=1715778796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3D5G94gdRt6LkMerSlAzNCYSn8ggN7fyN2o/SaJ5ijg=;
        b=W1X/5S2lEO74XqhP5GvvaWDEjkXSwZa0zVrrKAtGnjQ9TV4te8HlnVfrk06jdbjvIN
         sWZX+bWEPU+93Sg5WdkRocF42Bn3XHK5JTjz6ZBcSjOjbRs9NBw84e8X0b8sdsAj7/ob
         mEvLBLbqV4J1oLZb1kP9RZ854qOMIcfyFUs8dDTlVB+icjwfsb2skknDxRnixDStDq0v
         qZBmozeRjfOQIgROgbO9GDJrvz0DPS6PbeS0qy9aWfqLpPfYc6SNLbHudEroQkPsx8pO
         sx/rJTrMLm0TlH/5yL2IppP/pYqbBRuvHhT9c+d/DXwerpoixSh4mt9ShFY3e4v2FEzB
         rCLA==
X-Forwarded-Encrypted: i=1; AJvYcCUWpjYui09PPKRhupY0WPhkWWY61nOmLhYNjZ0LFcQJGlxHw4aPShjDPjfKaD66ECVrZSVF2xmDhBAlNUb4ppTAoX6fLhjhry6rM7VXyH7nq0O5Ls1JS9CRF2BZuNW0lsjId+sErQ==
X-Gm-Message-State: AOJu0YwDNm37lnctn1ygIx3orgFDn983rOPHGjG7gxnsMbAZJLOQKg/e
	53f9VLAeiqZQROKohDmD38UgtqP/ybSHJdWNhUQWL4DV2X0LudV9tNWJziVO+04=
X-Google-Smtp-Source: AGHT+IHGi0j3XxnGKzdPM8sC2D5+5XN+XqihsWGwVCl67omEa1VXVsO9oZz24DNMgTSs+OiS/I6Png==
X-Received: by 2002:a05:600c:4706:b0:415:6daf:c626 with SMTP id 5b1f17b1804b1-41f71ec26bemr23699015e9.21.1715173996012;
        Wed, 08 May 2024 06:13:16 -0700 (PDT)
Received: from rbolboac.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f88110f3esm22848365e9.29.2024.05.08.06.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 06:13:15 -0700 (PDT)
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
Subject: [PATCH v2 2/8] drivers: iio: imu: Add support for ADIS16501
Date: Wed,  8 May 2024 16:13:04 +0300
Message-Id: <20240508131310.880479-3-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508131310.880479-1-ramona.bolboaca13@gmail.com>
References: <20240508131310.880479-1-ramona.bolboaca13@gmail.com>
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
changes in v2:
 - added missing entry for adis16501 in adis16475_ids
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


