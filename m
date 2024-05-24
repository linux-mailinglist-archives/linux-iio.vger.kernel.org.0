Return-Path: <linux-iio+bounces-5253-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588A48CE2C3
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 11:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76C691C21A7D
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 09:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7506F12AAD9;
	Fri, 24 May 2024 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnK+yyQx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5027C129A83;
	Fri, 24 May 2024 09:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541246; cv=none; b=TaIGU9y2GCHpMmOPTHvBpD2H1619vW3c5SdTxf+7JD7LSByvHHJVITuSFEgqKG3BAcHLQb+aaKpxoZN1gbUhozdri22FHDMUVLLfIdfJ8UGsWqjJC0M/7ngorxh0NXkOsLycVZKT15WIC79w3ZOLYdvjsWL5XDyNrtF9QFy8ej8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541246; c=relaxed/simple;
	bh=TCnAHbRn4gD/Ud2GfwsphOkrishFmJ62+Hu27T3td88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TLevDNMI4KODPosbVhxm1OrpCbaaoxSRD1SGT2YEHHIngSngoLjb+isqm5WibEHIPtd65kPoJbWhALwVfKiXuRyW0sP15UW4GjyBeB6fhG7gGMvDV7vZtkiVRp9dsA5g+ahdUCJg/M8pfNQp/2eEnxypzgL3/RG9dc+sRjBXyOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnK+yyQx; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a5dcb5a0db4so774517866b.2;
        Fri, 24 May 2024 02:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716541242; x=1717146042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHw+IPdlQq7fNHkszmR6n42dvUymFzPrIX7n+uhkZH0=;
        b=UnK+yyQxMxekxZgbhxMiqzy3M/wuA4apyldFPVbnzbDpLrgHDs6q6XUgZ/XXuvFRAr
         OyGZ4eWTbZI0BhjJb6EGgagaLcZ2MuGs/KkvEVbgLfcok68CIcT2i5p3RVAA8PEFt8lN
         Wv+2JfRvmptSHmLH3W2fWbxh/WUAr4cNNOmwHs6tmgJkWsUrmLWH1M7uCZeZ+J+Geyjl
         TCAd5ORfMAa8W6oW1C0mzDCTfZe1glS/yMXEolcQIh22K3iwq6F4eVODpZoUHykCWpSj
         7+Z/IS9lzxJ7kJQ8GAyX2947A1oYlY1F0RKfDRuSHWiHzexVncIuL71lgIhGM2SWDsJ5
         mCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716541242; x=1717146042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHw+IPdlQq7fNHkszmR6n42dvUymFzPrIX7n+uhkZH0=;
        b=NKceY065Wy9cJYNGLZy0tufkNW523rzsSAvm1wYZYXnudEze5oKFEJ1FjIejmYhAck
         uVxGQq0zTk9UzpbAn35W+Or28I4XjmJwVcVx5N0X3AqgbmnedrAdq2CQ9HmZ3gglILnH
         g0sW9/svNZM4Yq0b/f4lGnNJio1spe85tpRqvYeIJJSQlmS9GzKMMMvkosRIMlu0vVY6
         6m83V39fYgVPCiqs5LtNQtzJYItzga4q8es1zkuOWbcwgEc0ZjzXysEFywJf+v/j46Qf
         nhODJCehTGSLAWlTvj1nIEuLzrhq2oulMen0iNIdHZDkjwKlanoYt0M2W9w7dfUs/q42
         tgIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZm5/42ECjm5kUfuLjJ/+kPJGBTo7tOZfaIstUk3NlaFbuOm73FAbld9xyo831L9wvJXILROSfu30Iebm65G2+7knO4FUBVlhnRfXZYUtqd0WzHZAWKxomleZYwczUzkzE6vA1aw==
X-Gm-Message-State: AOJu0YzRlqN8MYkA2hWa8b1zOAPWnFqbF+AjpnbvoCVKeLGpqt9p8Aca
	h7wJMR2H+JJJXRHV3XzqL43diHUBVX5qTtRpEWOo+Zk2Of1G0aFZrVv0bgM2gZo=
X-Google-Smtp-Source: AGHT+IEHTmIh+BSxfbRjLNCh7HBSONrylKRIug4/do88u5Xfh/BapzupZ5j/kIYQZR63rEsKMYEayw==
X-Received: by 2002:a17:906:e84:b0:a59:c9ad:bd28 with SMTP id a640c23a62f3a-a62641a5722mr102376066b.13.1716541241953;
        Fri, 24 May 2024 02:00:41 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:dac3:9bb:ed7a:184b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c93ae41sm97730466b.62.2024.05.24.02.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 02:00:41 -0700 (PDT)
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
Subject: [PATCH v4 03/10] iio: imu: adis16475: Re-define ADIS16475_DATA
Date: Fri, 24 May 2024 12:00:24 +0300
Message-Id: <20240524090030.336427-4-ramona.bolboaca13@gmail.com>
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

Re-define ADIS16475_DATA such that it takes _burst_max_len and
_burst_max_speed_hz as parameters.

Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
---
no changes in v4
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


