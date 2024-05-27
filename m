Return-Path: <linux-iio+bounces-5334-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DBA8D04FC
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 17:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B89E1F21C19
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 15:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E060117DE08;
	Mon, 27 May 2024 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BByoX2L5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A51176FA2;
	Mon, 27 May 2024 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716819996; cv=none; b=l/LFQic7gIO1LYDJdw0AAB6A7kJaffYZWVLFM9UQbtTIJcDJwPVOKW0DYQTlQ+vUbyIicH0vB/YFsvQQ0PmqwwAfKLypYoCC1MPqO5XGcefGJdjsdrQ9yH1LjoMwwcnAcuhK+Rb+zMD88W2EB8g+2Gfw2u7wNKbpJASjqiUHvyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716819996; c=relaxed/simple;
	bh=0Vd7KqD0ZfO0IpZ8xLe6FCO8lpnKuD7o5aQJalcxCWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uXEosklsmh/r0HxqgSfHE3g9sNEJf56e+Xf0wkV3uWSrY7qbFgq+VPLHVY3qwBQuafyqGzaR7kYj4iQKhYDjbeRDCTi52GUhRTnesLNCbmvduo5d8aCfEZi3c13Zmojr+yi26j4VARsT0oJg7yjOZeJU/s0S9cNoJQKvBa8QK5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BByoX2L5; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e95a75a90eso35880941fa.2;
        Mon, 27 May 2024 07:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716819992; x=1717424792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpIX4Pd1EUusuugwnT+3rv8SCMjuRrcLsru9z3jTuWs=;
        b=BByoX2L5no1lvDYR7b9YifogErHsxmJNTvVNrhGd58jRD4sBUv6FVYInDg9OVNlbMl
         2K0rih/olkGS+fjyiY60UHPNgeP0fpPukxAYBYlJDHOTuCy4w2Z9oMOpS9u01s7FO0P+
         6p9Lqig8FmxPg9YjasqO+DrB8RzPeLpqzX5BIcPxP+XokutlWfr3Q+0UspsWRCJmpHZ3
         NZoG2KK5i9puFgRFnCsN9wTlqUsOfftz5tykMpQltiJebGOed3BWL+OgqLfLetAfXO6X
         9Lt5IL6DEe6SWherxGs8U0O5A9ZZrrGtjd+LStwij43rfZby9fEAqPQjHFVZSXeDv1v9
         PWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716819992; x=1717424792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpIX4Pd1EUusuugwnT+3rv8SCMjuRrcLsru9z3jTuWs=;
        b=N0UvIpXMpw2ljWIDfwLxaEVfABlucwUubj6JndoMRQbqUCRRJbyIF6SErfoyLBVTzr
         yONdVu67t4PvrVu/kAdyqTEaSNKCegOEGydJiVJzoiM/OHMDMpYZqqngW3Swcs+UT6sj
         EwWSyoNnys8OuBqDF63KfpCgS3c3Y2S4jv4DCIFpYoYCoPRI4dGSSzdPVwWV7CcG7CWn
         Uu8OmPv+ZLODsNdBD8quHfLxxQquUnp6/2fuNmVtMF71AcH0SY3XnEhGgdy/oHCa6Vw0
         F/YL4Dwh06I+OygOWQwbnyIUA4LHKT5oNjGWqk/gNVBEX/8iIcjSEpEdUo1RZIb4kEM8
         g5jw==
X-Forwarded-Encrypted: i=1; AJvYcCU8YiC0yPK6Ala6KvEwAh3zQYakxJxSVqnjGt5tKdwhfvSQG4+2PYCcbnoy4P7kX1HzrLNUT5rUjOiT68vE7/V9tBgD+YJNsQPvrm/K+DSfhDMRaXub7lR3DEMOe2tv04HfwEwDAw==
X-Gm-Message-State: AOJu0YzfAD89S2DLthxgzq0giaB5ENDzXg+oeamrqW4sSkWYM2/9C6xn
	w/WrB67GFYMtzH/Wm0cEphTgWrokH027mubFxjE9cN9oVXumtlQFE9EM8yVCtDY=
X-Google-Smtp-Source: AGHT+IERTOlQN9I0BTGsfMOQwH/tP/tWkhKo9Gkj/ItGfeCPWv55080dqT07c1ikKlUH71jSJllmxw==
X-Received: by 2002:a2e:87c7:0:b0:2e9:794c:19ae with SMTP id 38308e7fff4ca-2e9794c1b09mr15568171fa.23.1716819992405;
        Mon, 27 May 2024 07:26:32 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:9c9:f6ef:e79b:45ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089ae976sm110537875e9.38.2024.05.27.07.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 07:26:32 -0700 (PDT)
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
Subject: [PATCH v5 7/9] iio: imu: adis16475: Re-define ADIS16475_DATA
Date: Mon, 27 May 2024 17:26:16 +0300
Message-Id: <20240527142618.275897-8-ramona.bolboaca13@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527142618.275897-1-ramona.bolboaca13@gmail.com>
References: <20240527142618.275897-1-ramona.bolboaca13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Re-define ADIS16475_DATA such that it takes _burst_max_len,
_burst_max_speed_hz and _has_fifo as parameters.
Also, do a preparatory rename operation for ADIS16475_BURST32_MAX_DATA
to ADIS16475_BURST32_MAX_DATA_NO_TS32 to be able to differentiate in
the future between devices which are using 16-bit or 32-bit timestamp
size in burst mode.

Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
---
changes in v5:
 - squashed the two patches containing redefinition of ADIS16475_DATA
 - moved the renaming of ADIS16475_BURST32_MAX_DATA from last patch into this
 one
 drivers/iio/imu/adis16475.c | 141 +++++++++++++++++++++++-------------
 1 file changed, 92 insertions(+), 49 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index b1def85b6f90..aac4c09a69e8 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -65,7 +65,7 @@
 #define ADIS16500_BURST32_MASK		BIT(9)
 #define ADIS16500_BURST32(x)		FIELD_PREP(ADIS16500_BURST32_MASK, x)
 /* number of data elements in burst mode */
-#define ADIS16475_BURST32_MAX_DATA	32
+#define ADIS16475_BURST32_MAX_DATA_NO_TS32	32
 #define ADIS16475_BURST_MAX_DATA	20
 #define ADIS16475_MAX_SCAN_DATA		20
 /* spi max speed in brust mode */
@@ -695,32 +695,33 @@ static const char * const adis16475_status_error_msgs[] = {
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
@@ -758,7 +759,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
-		.adis_data = ADIS16475_DATA(16470, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16470, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16475_1] = {
 		.name = "adis16475-1",
@@ -775,7 +778,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
-		.adis_data = ADIS16475_DATA(16475, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16475, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16475_2] = {
 		.name = "adis16475-2",
@@ -792,7 +797,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
-		.adis_data = ADIS16475_DATA(16475, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16475, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16475_3] = {
 		.name = "adis16475-3",
@@ -809,7 +816,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
-		.adis_data = ADIS16475_DATA(16475, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16475, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16477_1] = {
 		.name = "adis16477-1",
@@ -827,7 +836,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
-		.adis_data = ADIS16475_DATA(16477, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16477, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16477_2] = {
 		.name = "adis16477-2",
@@ -845,7 +856,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
-		.adis_data = ADIS16475_DATA(16477, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16477, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16477_3] = {
 		.name = "adis16477-3",
@@ -863,7 +876,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
-		.adis_data = ADIS16475_DATA(16477, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16477, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16465_1] = {
 		.name = "adis16465-1",
@@ -880,7 +895,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
-		.adis_data = ADIS16475_DATA(16465, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16465, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16465_2] = {
 		.name = "adis16465-2",
@@ -897,7 +914,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
-		.adis_data = ADIS16475_DATA(16465, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16465, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16465_3] = {
 		.name = "adis16465-3",
@@ -914,7 +933,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
-		.adis_data = ADIS16475_DATA(16465, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16465, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16467_1] = {
 		.name = "adis16467-1",
@@ -931,7 +952,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
-		.adis_data = ADIS16475_DATA(16467, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16467, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16467_2] = {
 		.name = "adis16467-2",
@@ -948,7 +971,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
-		.adis_data = ADIS16475_DATA(16467, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16467, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16467_3] = {
 		.name = "adis16467-3",
@@ -965,7 +990,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		.max_dec = 1999,
 		.sync = adis16475_sync_mode,
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode),
-		.adis_data = ADIS16475_DATA(16467, &adis16475_timeouts),
+		.adis_data = ADIS16475_DATA(16467, &adis16475_timeouts,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16500] = {
 		.name = "adis16500",
@@ -984,7 +1011,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		/* pulse sync not supported */
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
-		.adis_data = ADIS16475_DATA(16500, &adis1650x_timeouts),
+		.adis_data = ADIS16475_DATA(16500, &adis1650x_timeouts,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16501] = {
 		.name = "adis16501",
@@ -1003,7 +1032,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		/* pulse sync not supported */
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
-		.adis_data = ADIS16475_DATA(16501, &adis1650x_timeouts),
+		.adis_data = ADIS16475_DATA(16501, &adis1650x_timeouts,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16505_1] = {
 		.name = "adis16505-1",
@@ -1022,7 +1053,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		/* pulse sync not supported */
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
-		.adis_data = ADIS16475_DATA(16505, &adis1650x_timeouts),
+		.adis_data = ADIS16475_DATA(16505, &adis1650x_timeouts,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16505_2] = {
 		.name = "adis16505-2",
@@ -1041,7 +1074,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		/* pulse sync not supported */
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
-		.adis_data = ADIS16475_DATA(16505, &adis1650x_timeouts),
+		.adis_data = ADIS16475_DATA(16505, &adis1650x_timeouts,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16505_3] = {
 		.name = "adis16505-3",
@@ -1060,7 +1095,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		/* pulse sync not supported */
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
-		.adis_data = ADIS16475_DATA(16505, &adis1650x_timeouts),
+		.adis_data = ADIS16475_DATA(16505, &adis1650x_timeouts,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16507_1] = {
 		.name = "adis16507-1",
@@ -1079,7 +1116,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		/* pulse sync not supported */
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
-		.adis_data = ADIS16475_DATA(16507, &adis1650x_timeouts),
+		.adis_data = ADIS16475_DATA(16507, &adis1650x_timeouts,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16507_2] = {
 		.name = "adis16507-2",
@@ -1098,7 +1137,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		/* pulse sync not supported */
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
-		.adis_data = ADIS16475_DATA(16507, &adis1650x_timeouts),
+		.adis_data = ADIS16475_DATA(16507, &adis1650x_timeouts,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 	[ADIS16507_3] = {
 		.name = "adis16507-3",
@@ -1117,7 +1158,9 @@ static const struct adis16475_chip_info adis16475_chip_info[] = {
 		/* pulse sync not supported */
 		.num_sync = ARRAY_SIZE(adis16475_sync_mode) - 1,
 		.flags = ADIS16475_HAS_BURST32 | ADIS16475_HAS_BURST_DELTA_DATA,
-		.adis_data = ADIS16475_DATA(16507, &adis1650x_timeouts),
+		.adis_data = ADIS16475_DATA(16507, &adis1650x_timeouts,
+					    ADIS16475_BURST32_MAX_DATA_NO_TS32,
+					    ADIS16475_BURST_MAX_SPEED, false),
 	},
 };

@@ -1158,7 +1201,7 @@ static bool adis16475_validate_crc(const u8 *buffer, u16 crc,
 {
 	int i;
 	/* extra 6 elements for low gyro and accel */
-	const u16 sz = burst32 ? ADIS16475_BURST32_MAX_DATA :
+	const u16 sz = burst32 ? ADIS16475_BURST32_MAX_DATA_NO_TS32 :
 		ADIS16475_BURST_MAX_DATA;

 	for (i = 0; i < sz - 2; i++)
--
2.34.1


