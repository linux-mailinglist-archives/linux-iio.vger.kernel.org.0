Return-Path: <linux-iio+bounces-5078-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D038C81A8
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 09:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98FAD282729
	for <lists+linux-iio@lfdr.de>; Fri, 17 May 2024 07:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22053288A4;
	Fri, 17 May 2024 07:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O2id4REP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058AB200DD;
	Fri, 17 May 2024 07:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715932081; cv=none; b=vE5l2epPBNb494NP3+u76lEUzJwZTSN3JGObzxFxTgo1EvS8r3kqR62WZd7Qq6xoQE1vwVAHH/jYAk+ArgUxtKliaVU4WJL7pDssBldWFopCqEHomtCXpv2Mn/4xNpAaOJbEjI3sy2CqeI3aWNaElcwo8kRhUybDkr0U/WQ9wp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715932081; c=relaxed/simple;
	bh=33MG/pr9NDZe6h6wcG70d5VGPAnCFOGbElh2wYUPQfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MlHpydX2BCEF1ALXl+FpLo1zAeNou1kcGwAwcw94h4hC0yLccz885H6RnCUosT084vJcDINaaj1wIh3UjuGdv9a6EJGCOPHzH/W+NhQwjFjb09dIpcMv27O+PcPHSGw6ycKT/zF6E2fzgZK/BspMH1+1uCNKalifU8oBK0oxr3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O2id4REP; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-351d3898640so1576212f8f.3;
        Fri, 17 May 2024 00:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715932078; x=1716536878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eG3qMs75e2sr0KEMnEGucaBNNv20cjmulL7EY2l6yg=;
        b=O2id4REPqTA/CDixp0ApkhKjxy9lbiMfiPpvzXMF9JowJNz0JDKWkSzEGhdwpke1Dj
         b/M035f3cbH6i5o+mGFpdhoD43FD7xD1NSlArb/vVdbLmHRCL6k0hKm3xtXxQo6D1021
         GuXSU8tLHC7iJiNw41s1bzm/6BGp66jvBtXvqeOjzKHUTPQADmUvTFPlAA6/aoW3sFey
         A6xmGvhvIKw26KqH14pGnEjUif7lN2CaKuchaDuhuxFWk/U0EhXI+cotTqCY35t0JnBP
         sx+v4z14ocJmP/YGU2HNrJn9ZKSh+9llgIpb/ScKNaQfJxj4G7cBAaNAXfQL5RG+tnnL
         ctRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715932078; x=1716536878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8eG3qMs75e2sr0KEMnEGucaBNNv20cjmulL7EY2l6yg=;
        b=KyMh5VvWSmkFg5DKj/QHqEDeq/s6pCM/16YARxVeYWZ6BLAZvoZoVY5Mqgy56GoruE
         XX2yLfvu6zeh3B4nvGRNDCyzXH2mj/j4y9xYrtSGqBUFa7jsRR+gpgS9/cat3IS540ru
         b3kzfLHQ6T8cDBbIYetPxhbzPNdj2mrplMWKkodZtvlS+CjDHu2fGf5KcPThUtrOkXHU
         VGtprMACosWNnA4ZfdDsUDLv65BiaWOdBBvZdQTKUBm5s5v4YT204mFzAJE/Nh430Ubu
         sHlyfkrV3lR8r9ppdewbYlQzRUMCqbj9MsrIYsGxcYoYCeWWkQlrDpFgvhXc6eLGjpTH
         fUXg==
X-Forwarded-Encrypted: i=1; AJvYcCX2C/Hx+eDXsS8mjGGdU7jPUJR4TjSJiWajMykV1ykfxVAVmqByAuOgi95+c2PE6jSB50sUg3wdZ2THIIpm+TCfh2eGJRYwdSN7DM+wP50/+OUoCLTw3eHkSWT4UhUoNFVNQnqKqw==
X-Gm-Message-State: AOJu0YxR/c4x004/xNyF0HMykkZaZoYcs53O17caKTA/AaHFv9nbMq/W
	M/Iq5T2eXl6y70U8LAkdpoBPxOE7DdeqKzwmwMFePGGCsrMKVa3dq5J8TBhpLdk=
X-Google-Smtp-Source: AGHT+IE8+3ZstNFQZPToimNK69bPd5aClzHaZ6yYuKT8Depw0ff5NvbMt/od6lGqAGWIRlXWiYOkAA==
X-Received: by 2002:a05:6000:4022:b0:351:bc37:c696 with SMTP id ffacd0b85a97d-351bc37c747mr11390190f8f.49.1715932077708;
        Fri, 17 May 2024 00:47:57 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:569e:359d:dfe4:922e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baacef2sm21104207f8f.85.2024.05.17.00.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 00:47:56 -0700 (PDT)
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
Subject: [PATCH v3 3/9] iio: imu: adis16475: Re-define ADIS16475_DATA
Date: Fri, 17 May 2024 10:47:44 +0300
Message-Id: <20240517074750.87376-4-ramona.bolboaca13@gmail.com>
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

Re-define ADIS16475_DATA such that it takes _burst_max_len and
_burst_max_speed_hz as parameters.

Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
---
no changes in v3
 drivers/iio/imu/adis16475.c | 136 +++++++++++++++++++++++-------------
 1 file changed, 89 insertions(+), 47 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 53872b716f4a..f9455ecb348c 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -690,32 +690,32 @@ static const char * const adis16475_status_error_msgs[] = {
 	[ADIS16475_DIAG_STAT_CLK] = "Clock error",
 };

-#define ADIS16475_DATA(_prod_id, _timeouts)				\
-{									\
-	.msc_ctrl_reg = ADIS16475_REG_MSG_CTRL,				\
-	.glob_cmd_reg = ADIS16475_REG_GLOB_CMD,				\
-	.diag_stat_reg = ADIS16475_REG_DIAG_STAT,			\
-	.prod_id_reg = ADIS16475_REG_PROD_ID,				\
-	.prod_id = (_prod_id),						\
-	.self_test_mask = BIT(2),					\
-	.self_test_reg = ADIS16475_REG_GLOB_CMD,			\
-	.cs_change_delay = 16,						\
-	.read_delay = 5,						\
-	.write_delay = 5,						\
-	.status_error_msgs = adis16475_status_error_msgs,		\
-	.status_error_mask = BIT(ADIS16475_DIAG_STAT_DATA_PATH) |	\
-		BIT(ADIS16475_DIAG_STAT_FLASH_MEM) |			\
-		BIT(ADIS16475_DIAG_STAT_SPI) |				\
-		BIT(ADIS16475_DIAG_STAT_STANDBY) |			\
-		BIT(ADIS16475_DIAG_STAT_SENSOR) |			\
-		BIT(ADIS16475_DIAG_STAT_MEMORY) |			\
-		BIT(ADIS16475_DIAG_STAT_CLK),				\
-	.unmasked_drdy = true,						\
-	.timeouts = (_timeouts),					\
-	.burst_reg_cmd = ADIS16475_REG_GLOB_CMD,			\
-	.burst_len = ADIS16475_BURST_MAX_DATA,				\
-	.burst_max_len = ADIS16475_BURST32_MAX_DATA,			\
-	.burst_max_speed_hz = ADIS16475_BURST_MAX_SPEED			\
+#define ADIS16475_DATA(_prod_id, _timeouts, _burst_max_len, _burst_max_speed_hz)	\
+{											\
+	.msc_ctrl_reg = ADIS16475_REG_MSG_CTRL,						\
+	.glob_cmd_reg = ADIS16475_REG_GLOB_CMD,						\
+	.diag_stat_reg = ADIS16475_REG_DIAG_STAT,					\
+	.prod_id_reg = ADIS16475_REG_PROD_ID,						\
+	.prod_id = (_prod_id),								\
+	.self_test_mask = BIT(2),							\
+	.self_test_reg = ADIS16475_REG_GLOB_CMD,					\
+	.cs_change_delay = 16,								\
+	.read_delay = 5,								\
+	.write_delay = 5,								\
+	.status_error_msgs = adis16475_status_error_msgs,				\
+	.status_error_mask = BIT(ADIS16475_DIAG_STAT_DATA_PATH) |			\
+		BIT(ADIS16475_DIAG_STAT_FLASH_MEM) |					\
+		BIT(ADIS16475_DIAG_STAT_SPI) |						\
+		BIT(ADIS16475_DIAG_STAT_STANDBY) |					\
+		BIT(ADIS16475_DIAG_STAT_SENSOR) |					\
+		BIT(ADIS16475_DIAG_STAT_MEMORY) |					\
+		BIT(ADIS16475_DIAG_STAT_CLK),						\
+	.unmasked_drdy = true,								\
+	.timeouts = (_timeouts),							\
+	.burst_reg_cmd = ADIS16475_REG_GLOB_CMD,					\
+	.burst_len = ADIS16475_BURST_MAX_DATA,						\
+	.burst_max_len = _burst_max_len,						\
+	.burst_max_speed_hz = _burst_max_speed_hz					\
 }

 static const struct adis16475_sync adis16475_sync_mode[] = {
@@ -753,7 +753,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
-		.adis_data = ADIS16475_DATA(16470, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16470, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16475_1] = {
 		.name = "adis16475-1",
@@ -770,7 +772,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
-		.adis_data = ADIS16475_DATA(16475, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16475, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16475_2] = {
 		.name = "adis16475-2",
@@ -787,7 +791,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
-		.adis_data = ADIS16475_DATA(16475, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16475, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16475_3] = {
 		.name = "adis16475-3",
@@ -804,7 +810,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
-		.adis_data = ADIS16475_DATA(16475, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16475, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16477_1] = {
 		.name = "adis16477-1",
@@ -822,7 +830,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
-		.adis_data = ADIS16475_DATA(16477, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16477, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16477_2] = {
 		.name = "adis16477-2",
@@ -840,7 +850,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
-		.adis_data = ADIS16475_DATA(16477, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16477, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16477_3] = {
 		.name = "adis16477-3",
@@ -858,7 +870,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
-		.adis_data = ADIS16475_DATA(16477, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16477, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16465_1] = {
 		.name = "adis16465-1",
@@ -875,7 +889,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
-		.adis_data = ADIS16475_DATA(16465, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16465, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16465_2] = {
 		.name = "adis16465-2",
@@ -892,7 +908,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
-		.adis_data = ADIS16475_DATA(16465, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16465, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16465_3] = {
 		.name = "adis16465-3",
@@ -909,7 +927,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
-		.adis_data = ADIS16475_DATA(16465, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16465, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16467_1] = {
 		.name = "adis16467-1",
@@ -926,7 +946,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
-		.adis_data = ADIS16475_DATA(16467, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16467, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16467_2] = {
 		.name = "adis16467-2",
@@ -943,7 +965,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
-		.adis_data = ADIS16475_DATA(16467, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16467, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16467_3] = {
 		.name = "adis16467-3",
@@ -960,7 +984,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
-		.adis_data = ADIS16475_DATA(16467, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16467, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16500] = {
 		.name = "adis16500",
@@ -979,7 +1005,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		/* pulse sync not supported */
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
-		.adis_data = ADIS16475_DATA(16500, &adis1650x_timeouts),
+		.adis_data = ADIS16475_DATA(16500, &adis1650x_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16501] = {
 		.name = "adis16501",
@@ -998,7 +1026,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		/* pulse sync not supported */
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
-		.adis_data = ADIS16475_DATA(16501, &adis1650x_timeouts),
+		.adis_data = ADIS16475_DATA(16501, &adis1650x_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16505_1] = {
 		.name = "adis16505-1",
@@ -1017,7 +1047,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		/* pulse sync not supported */
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
-		.adis_data = ADIS16475_DATA(16505, &adis1650x_timeouts),
+		.adis_data = ADIS16475_DATA(16505, &adis1650x_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16505_2] = {
 		.name = "adis16505-2",
@@ -1036,7 +1068,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		/* pulse sync not supported */
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
-		.adis_data = ADIS16475_DATA(16505, &adis1650x_timeouts),
+		.adis_data = ADIS16475_DATA(16505, &adis1650x_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16505_3] = {
 		.name = "adis16505-3",
@@ -1055,7 +1089,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		/* pulse sync not supported */
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
-		.adis_data = ADIS16475_DATA(16505, &adis1650x_timeouts),
+		.adis_data = ADIS16475_DATA(16505, &adis1650x_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16507_1] = {
 		.name = "adis16507-1",
@@ -1074,7 +1110,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		/* pulse sync not supported */
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
-		.adis_data = ADIS16475_DATA(16507, &adis1650x_timeouts),
+		.adis_data = ADIS16475_DATA(16507, &adis1650x_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16507_2] = {
 		.name = "adis16507-2",
@@ -1093,7 +1131,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		/* pulse sync not supported */
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
-		.adis_data = ADIS16475_DATA(16507, &adis1650x_timeouts),
+		.adis_data = ADIS16475_DATA(16507, &adis1650x_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 	[ADIS16507_3] = {
 		.name = "adis16507-3",
@@ -1112,7 +1152,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		/* pulse sync not supported */
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
-		.adis_data = ADIS16475_DATA(16507, &adis1650x_timeouts),
+		.adis_data = ADIS16475_DATA(16507, &adis1650x_timeouts,
+					    ADIS16475_BURST32_MAX_DATA,
+					    ADIS16475_BURST_MAX_SPEED),
 	},
 };

--
2.34.1


