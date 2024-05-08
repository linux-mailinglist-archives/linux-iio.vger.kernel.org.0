Return-Path: <linux-iio+bounces-4878-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D51EF8BFE1F
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 15:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C7891F230D8
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 13:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8DE7E0F6;
	Wed,  8 May 2024 13:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDClRqBn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AB479DD4;
	Wed,  8 May 2024 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715174001; cv=none; b=L6pnOKF8NF8nt7e4CPeHUwskLv3U3K+QIZbZZoD4NkwJsWRePMbimZlPDkX3yMdSG4Ty/eJrxkqklSSqwms0euFZzmulXmor35u7kqwYtAeUkXU9lkiCdNR6bnfmuyCp/TqQAzWBPGxW+JwDPr3+G+CQjZRLvSJOFCXjwpxnUtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715174001; c=relaxed/simple;
	bh=9UkFAE7iLsQZRwMDPV0r3qgO8Qfs9KaIwDxhJCqaAbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HxOSIcv+F3s5dsr18jZg8DaIp16GxMy6JdblStmBOu55jDvA7DkYaqeMhdvlviK7xBLyDJK7Xy9kLlZ/+9maF3BZvymdC6UZB9tCeRP/3AmZH4dlu8XEIzILhAYkAwv0E086MJACI5rJtYsSnGO4wRBs91h0kAjESHowWvgIs80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDClRqBn; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e3e18c24c1so24861261fa.1;
        Wed, 08 May 2024 06:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715173998; x=1715778798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrE8mXpcndBf6eUlpjGTP9brfOJGIKxXWfJr0qURJq8=;
        b=VDClRqBnMDS+u5ey8Ut8tpN66j1nDfQHnYTcTq3nfWxJSYVTmoBiT+qXyP4kEHbX79
         tzSIi17YiF+YnbsiPz/3lRdPl3DeWVjwWoRen2t/xFEZpy05gukYCJsZxuLAnLtkgcEA
         In10GbgDPXaP5FyWRysAVE0u4IcUnDDGJO8Rv6Iz0onyiRWBpYMJpmEawjTd0F4LISAP
         X87oa2YDT+IthEqz5vDMx7Y2YSV6e6cGDeYduQMJwOgunrq++ha/pb6eMdXcpdMSmE0j
         wLp3I5JAeizGsdob7eH5he2UN3mJ5dpEsKPZRv1JTnobgaDvNjhgpwaVtLtlvldT9mdN
         ZR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715173998; x=1715778798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LrE8mXpcndBf6eUlpjGTP9brfOJGIKxXWfJr0qURJq8=;
        b=m+r4qOaCAtBRIR1RsrkWT95WAlhWQm4LjSPhvVBk/tbz7ZViLGbHB1WtPi5I3/DEj3
         WtSjr7lTs2y2f7XKqMpkmzKbwCL/TnZt2xf6Dkug1LbdbD+oeF4a3aVgabLtJqEXolr6
         9MgqlE33f0MKXT3IMH8sOFioCEg9V72LPDwLzzKoNZGB2k/ES4hY7q7dBa+WsuQCDVeK
         VzYuBtmVH4uyyrRd+/wboxfEazYQj3+Mw3EBtO9wK/ZfgvmTEaF5pee1LopnPYCNgVK6
         GJq+3NHF1nh0iRbaAtr/jG5YisIsprIxWzEST2IpqU+4GSlIL+viqT0fwdUpgfICSGrm
         Rzqw==
X-Forwarded-Encrypted: i=1; AJvYcCXGBAIB7j18ESdYNSF1+r/TnlEJIsUlPMdvweD1ZACmDRmYTC6r8YpYXBtb8QcioRb3UhvatUbO+/IuWZ4wrnpV+wuYJUVfZf28rDUaWlpuYfuRnwtW8rhPmxMHvlG16aqB8wMnkw==
X-Gm-Message-State: AOJu0YxJuNuoKnaACGuRhQ4buR4kXnAART/gdRD74VyRjyuAI0BvFaoJ
	dW63/zKL4Yb85saXXYn+RpAkKK0Pemfdo6l9nsmJ/+unGB7Cr6nAb/HGt6Age5M=
X-Google-Smtp-Source: AGHT+IF7VU7Y1QSO6KjlyfD2UAUnXFOZ55c6wE3pNSEiANo07qh/k9rEcOA9qyaBcYg4OCT6P4uePA==
X-Received: by 2002:a2e:80c9:0:b0:2d5:9703:263f with SMTP id 38308e7fff4ca-2e4479a3179mr17159541fa.44.1715173997413;
        Wed, 08 May 2024 06:13:17 -0700 (PDT)
Received: from rbolboac.. ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f88110f3esm22848365e9.29.2024.05.08.06.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 06:13:16 -0700 (PDT)
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
Subject: [PATCH v2 3/8] iio: imu: adis16475: Re-define ADIS16475_DATA
Date: Wed,  8 May 2024 16:13:05 +0300
Message-Id: <20240508131310.880479-4-ramona.bolboaca13@gmail.com>
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

Re-define ADIS16475_DATA such that it takes _burst_max_len and
_burst_max_speed_hz as parameters.

Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
---
changes in v2:
 - fixed typo from adis16475_timeouts to adis1650x_timeouts for devices which
 actually have adis1650x_timeouts
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


