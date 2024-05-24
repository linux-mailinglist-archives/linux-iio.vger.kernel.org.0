Return-Path: <linux-iio+bounces-5258-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F9C8CE2D3
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 11:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1DAFB219BA
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 09:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74B312C47E;
	Fri, 24 May 2024 09:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcxJKJC4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D75312BF22;
	Fri, 24 May 2024 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716541252; cv=none; b=ox/RXrteLw6lXkCMUOIpjLTbR29gR3ZdAVjdMvuYUHryjirEtUCHtz3GjTPm4caCSN51F/QW4xtt4uwgm8OXlW4OVH4lpzNXm/ZdfeuU6mNgI1VhfzN/EeAvlpmNTmQ21WDLUyoLg336m7X4QILUjOJMMFCA41q8Fnub9kF5mbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716541252; c=relaxed/simple;
	bh=tztHe4aUcxX4wRjc99YaM39mqcZnfUl5JJ0BtiW9GwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rAJ6nZ4rTnKczfzkWYyH+M4PPSX9mJKkzPFAsJP8jnaHkDNr84FzJlG+P2QkFpZHDDMyjrxumofPYSXHSncdBqJac8FQ08y5XyIRWNHv4GdzX3HbknTNcYSJoRY/gQRzTaHisS6x5GG9sFQ3+q+vqvezPLZOt6nb/pZcAojemX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcxJKJC4; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52232d0e5ceso8960450e87.0;
        Fri, 24 May 2024 02:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716541248; x=1717146048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v34IUPHZBY7mvn3HFnO7gyHIF93FkJJT+RNRfSWUsJo=;
        b=bcxJKJC4xMSbAbg9UX2KhFjHfzm6qlNK6uBIGQoppPFvFZXkawR6AaV/4njrFvHlh3
         tzNwxoO+ED3jx4R5RgaqTay3uAXXmvAfuk5J08Ecd7Kt3JEzo/d4cQmnIm8O6w09OI3Q
         HU31wxSkJDHsfB/Blv9OXdMFbyZrFub/uqR0tiC0dFJyrrV0KTYRS/7A4uMxtkrQM9PW
         qLg2BR11OBl5Xnw1yORzb0dMq95rvcCPaaUKAaLhlYEoi5yem9RgbfP4gMWR/DN/t7yf
         Ko2Dwnea6lV5s2lzZQr79wmvnwavZmL5UhxOeKDm5O5V+0n5C7xS277SR6foCyqgPorA
         K5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716541248; x=1717146048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v34IUPHZBY7mvn3HFnO7gyHIF93FkJJT+RNRfSWUsJo=;
        b=jlpBkBNYtjLcUVcavhYau1dS0pdZsh7JB+I12OeM1+0NlwIm/rwfjKH2dC9mvk4rLD
         VdtmPne1SEApLMjGRiMJWNvoku6fs4K0fDCnHEJlIawAcRIgIvkhAEUtRJHhTU9ZdtEh
         7ruRG5xIeqJ9no3jXGtNNkOb2mKHmlV78e+7hu32SmqQOxe5BfazS9mw7qTQcy+MZ/Ux
         FCNtaw6ih5OAtwdLa+IzWbhLoc2GIj78bZqrGCE+5kzHmqKy8gaytQvvdo22HDBZ/cqG
         sr/Wm5lxjLXZ8uRaBWe6BTvleonVMVGQCbOwq8us+XhiTHBrl/cvvzM5QEZcrBKrE6Kc
         2+8w==
X-Forwarded-Encrypted: i=1; AJvYcCUbLxWQYZs04RNXi13iMkOEQDaEqBRgK0n21r4GEsedJLXoHEHMbAX2ANBpSz/NeSb2NlXQfdggl43Y7e24+f0iXtwMjyha1bB1f9O5v/F2g1//VnfYdOJKBPaiFxjmNV1wU5hUBQ==
X-Gm-Message-State: AOJu0Yykqkf9auSmKS75Ss1Es17DN0vNYXFOmapbSExAECA8fkVCt01e
	u31Ei3QG0QGJGzI+plNBJCowEtYaNAqxm557lpjv/3bhacWdADtnDGfq5N9fe4U=
X-Google-Smtp-Source: AGHT+IF2CqC/xnyoeGBavzBwpvkxWczgVySOR9mzABFMEDBNUI3FIifUprJe5lc9wZE38coodSo3zw==
X-Received: by 2002:a19:e01c:0:b0:51d:5f0b:816f with SMTP id 2adb3069b0e04-529646de43fmr760925e87.15.1716541248117;
        Fri, 24 May 2024 02:00:48 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:dac3:9bb:ed7a:184b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c93ae41sm97730466b.62.2024.05.24.02.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 02:00:47 -0700 (PDT)
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
Subject: [PATCH v4 08/10] iio: imu: adis16475: Re-define ADIS16475_DATA
Date: Fri, 24 May 2024 12:00:29 +0300
Message-Id: <20240524090030.336427-9-ramona.bolboaca13@gmail.com>
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

Re-define ADIS16475_DATA such that it takes _has_fifo as parameter.

Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
---
 drivers/iio/imu/adis16475.c | 95 +++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 47 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index c589f214259b..3bbf3e181e1a 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -695,32 +695,33 @@ static const char * const adis16475_status_error_msgs[] = {
 	[ADIS16475_DIAG_STAT_CLK] = "Clock error",
 };
 
-#define ADIS16475_DATA(_prod_id, _timeouts, _burst_max_len, _burst_max_speed_hz)	\
-{											\
-	.msc_ctrl_reg = ADIS16475_REG_MSG_CTRL,						\
-	.glob_cmd_reg = ADIS16475_REG_GLOB_CMD,						\
-	.diag_stat_reg = ADIS16475_REG_DIAG_STAT,					\
-	.prod_id_reg = ADIS16475_REG_PROD_ID,						\
-	.prod_id = (_prod_id),								\
-	.self_test_mask = BIT(2),							\
-	.self_test_reg = ADIS16475_REG_GLOB_CMD,					\
-	.cs_change_delay = 16,								\
-	.read_delay = 5,								\
-	.write_delay = 5,								\
-	.status_error_msgs = adis16475_status_error_msgs,				\
-	.status_error_mask = BIT(ADIS16475_DIAG_STAT_DATA_PATH) |			\
-		BIT(ADIS16475_DIAG_STAT_FLASH_MEM) |					\
-		BIT(ADIS16475_DIAG_STAT_SPI) |						\
-		BIT(ADIS16475_DIAG_STAT_STANDBY) |					\
-		BIT(ADIS16475_DIAG_STAT_SENSOR) |					\
-		BIT(ADIS16475_DIAG_STAT_MEMORY) |					\
-		BIT(ADIS16475_DIAG_STAT_CLK),						\
-	.unmasked_drdy = true,								\
-	.timeouts = (_timeouts),							\
-	.burst_reg_cmd = ADIS16475_REG_GLOB_CMD,					\
-	.burst_len = ADIS16475_BURST_MAX_DATA,						\
-	.burst_max_len = _burst_max_len,						\
-	.burst_max_speed_hz = _burst_max_speed_hz					\
+#define ADIS16475_DATA(_prod_id, _timeouts, _burst_max_len, _burst_max_speed_hz, _has_fifo)	\
+{												\
+	.msc_ctrl_reg = ADIS16475_REG_MSG_CTRL,							\
+	.glob_cmd_reg = ADIS16475_REG_GLOB_CMD,							\
+	.diag_stat_reg = ADIS16475_REG_DIAG_STAT,						\
+	.prod_id_reg = ADIS16475_REG_PROD_ID,							\
+	.prod_id = (_prod_id),									\
+	.self_test_mask = BIT(2),								\
+	.self_test_reg = ADIS16475_REG_GLOB_CMD,						\
+	.cs_change_delay = 16,									\
+	.read_delay = 5,									\
+	.write_delay = 5,									\
+	.status_error_msgs = adis16475_status_error_msgs,					\
+	.status_error_mask = BIT(ADIS16475_DIAG_STAT_DATA_PATH) |				\
+		BIT(ADIS16475_DIAG_STAT_FLASH_MEM) |						\
+		BIT(ADIS16475_DIAG_STAT_SPI) |							\
+		BIT(ADIS16475_DIAG_STAT_STANDBY) |						\
+		BIT(ADIS16475_DIAG_STAT_SENSOR) |						\
+		BIT(ADIS16475_DIAG_STAT_MEMORY) |						\
+		BIT(ADIS16475_DIAG_STAT_CLK),							\
+	.unmasked_drdy = true,									\
+	.has_fifo = _has_fifo,									\
+	.timeouts = (_timeouts),								\
+	.burst_reg_cmd = ADIS16475_REG_GLOB_CMD,						\
+	.burst_len = ADIS16475_BURST_MAX_DATA,							\
+	.burst_max_len = _burst_max_len,							\
+	.burst_max_speed_hz = _burst_max_speed_hz						\
 }
 
 static const struct adis16475_sync adis16475_sync_mode[] = {
@@ -760,7 +761,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
 		.adis_data = ADIS16475_DATA(16470, &adis16475_timeouts,
 					    ADIS16475_BURST32_MAX_DATA,
-					    ADIS16475_BURST_MAX_SPEED),
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16475_1] = {
 		.name = "adis16475-1",
@@ -779,7 +780,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
 		.adis_data = ADIS16475_DATA(16475, &adis16475_timeouts,
 					    ADIS16475_BURST32_MAX_DATA,
-					    ADIS16475_BURST_MAX_SPEED),
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16475_2] = {
 		.name = "adis16475-2",
@@ -798,7 +799,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
 		.adis_data = ADIS16475_DATA(16475, &adis16475_timeouts,
 					    ADIS16475_BURST32_MAX_DATA,
-					    ADIS16475_BURST_MAX_SPEED),
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16475_3] = {
 		.name = "adis16475-3",
@@ -817,7 +818,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
 		.adis_data = ADIS16475_DATA(16475, &adis16475_timeouts,
 					    ADIS16475_BURST32_MAX_DATA,
-					    ADIS16475_BURST_MAX_SPEED),
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16477_1] = {
 		.name = "adis16477-1",
@@ -837,7 +838,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16477, &adis16475_timeouts,
 					    ADIS16475_BURST32_MAX_DATA,
-					    ADIS16475_BURST_MAX_SPEED),
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16477_2] = {
 		.name = "adis16477-2",
@@ -857,7 +858,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16477, &adis16475_timeouts,
 					    ADIS16475_BURST32_MAX_DATA,
-					    ADIS16475_BURST_MAX_SPEED),
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16477_3] = {
 		.name = "adis16477-3",
@@ -877,7 +878,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16477, &adis16475_timeouts,
 					    ADIS16475_BURST32_MAX_DATA,
-					    ADIS16475_BURST_MAX_SPEED),
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16465_1] = {
 		.name = "adis16465-1",
@@ -896,7 +897,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
 		.adis_data = ADIS16475_DATA(16465, &adis16475_timeouts,
 					    ADIS16475_BURST32_MAX_DATA,
-					    ADIS16475_BURST_MAX_SPEED),
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16465_2] = {
 		.name = "adis16465-2",
@@ -915,7 +916,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
 		.adis_data = ADIS16475_DATA(16465, &adis16475_timeouts,
 					    ADIS16475_BURST32_MAX_DATA,
-					    ADIS16475_BURST_MAX_SPEED),
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16465_3] = {
 		.name = "adis16465-3",
@@ -934,7 +935,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
 		.adis_data = ADIS16475_DATA(16465, &adis16475_timeouts,
 					    ADIS16475_BURST32_MAX_DATA,
-					    ADIS16475_BURST_MAX_SPEED),
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16467_1] = {
 		.name = "adis16467-1",
@@ -953,7 +954,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
 		.adis_data = ADIS16475_DATA(16467, &adis16475_timeouts,
 					    ADIS16475_BURST32_MAX_DATA,
-					    ADIS16475_BURST_MAX_SPEED),
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16467_2] = {
 		.name = "adis16467-2",
@@ -972,7 +973,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
 		.adis_data = ADIS16475_DATA(16467, &adis16475_timeouts,
 					    ADIS16475_BURST32_MAX_DATA,
-					    ADIS16475_BURST_MAX_SPEED),
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16467_3] = {
 		.name = "adis16467-3",
@@ -991,7 +992,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
 		.adis_data = ADIS16475_DATA(16467, &adis16475_timeouts,
 					    ADIS16475_BURST32_MAX_DATA,
-					    ADIS16475_BURST_MAX_SPEED),
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16500] = {
 		.name = "adis16500",
@@ -1012,7 +1013,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16500, &adis1650x_timeouts,
 					    ADIS16475_BURST32_MAX_DATA,
-					    ADIS16475_BURST_MAX_SPEED),
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16501] = {
 		.name = "adis16501",
@@ -1033,7 +1034,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16501, &adis1650x_timeouts,
 					    ADIS16475_BURST32_MAX_DATA,
-					    ADIS16475_BURST_MAX_SPEED),
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16505_1] = {
 		.name = "adis16505-1",
@@ -1054,7 +1055,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16505, &adis1650x_timeouts,
 					    ADIS16475_BURST32_MAX_DATA,
-					    ADIS16475_BURST_MAX_SPEED),
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16505_2] = {
 		.name = "adis16505-2",
@@ -1075,7 +1076,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16505, &adis1650x_timeouts,
 					    ADIS16475_BURST32_MAX_DATA,
-					    ADIS16475_BURST_MAX_SPEED),
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16505_3] = {
 		.name = "adis16505-3",
@@ -1096,7 +1097,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16505, &adis1650x_timeouts,
 					    ADIS16475_BURST32_MAX_DATA,
-					    ADIS16475_BURST_MAX_SPEED),
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16507_1] = {
 		.name = "adis16507-1",
@@ -1117,7 +1118,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16507, &adis1650x_timeouts,
 					    ADIS16475_BURST32_MAX_DATA,
-					    ADIS16475_BURST_MAX_SPEED),
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16507_2] = {
 		.name = "adis16507-2",
@@ -1138,7 +1139,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16507, &adis1650x_timeouts,
 					    ADIS16475_BURST32_MAX_DATA,
-					    ADIS16475_BURST_MAX_SPEED),
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16507_3] = {
 		.name = "adis16507-3",
@@ -1159,7 +1160,7 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
 		.adis_data = ADIS16475_DATA(16507, &adis1650x_timeouts,
 					    ADIS16475_BURST32_MAX_DATA,
-					    ADIS16475_BURST_MAX_SPEED),
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 };
 
-- 
2.34.1


