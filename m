Return-Path: <linux-iio+bounces-5397-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FB58D1E93
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 16:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76E42286656
	for <lists+linux-iio@lfdr.de>; Tue, 28 May 2024 14:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294BD16FF39;
	Tue, 28 May 2024 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTIMlGoA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3072F16F90B;
	Tue, 28 May 2024 14:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906283; cv=none; b=b3drlxIGCMaoZa0oCZJ30E4FP0M/G+95+URlnmOrRuiY1f+I6KAUpXQjOB3MIp0YtUbUNVB3/PO1W8BNl+UESVCiS9NgyXVM9iUkIU3FnexiFGS5dFH7jcnhZgwVnxCqBpUoCoOLOH9KTVnLkjQiVnQ+VEWT2YYqwv6oHCGhYOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906283; c=relaxed/simple;
	bh=SqVjZBVKLoxCG9HOpyPz22UIfMp7t6E7WIQ4bXXJRSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PSB0L/yKbUIpe21vWpx4OaXbn50utkqjeNDAfqn5ES9pVpJt8Rzoy2i2a3bt5yj8S6HacBP3NGTXprC4Q6tQuMjv/YJo0S6daRSuQpmLcIkC3eytRBRHLNPChjbIfRnIImDTpLvygezLe7rmtxH7fAZYSoULhE3WI9UADHnXpac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZTIMlGoA; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57863a8f4b2so1047621a12.0;
        Tue, 28 May 2024 07:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716906279; x=1717511079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wg8CtjNjFgeTw9feqCVVRxh9BF8aMu7Y3qqfuAJtbso=;
        b=ZTIMlGoAuJR82vTLpV/gQHG2DUKjrqHgBkKaDeizO71DX4I43rmQF4+JyXvYNHgDvP
         BzR27M5fT76i6JFSsAsYpUMauqGKdUfUn8f++cbx22HKTgVJHmx4MoTRPoOCaqDTVUaP
         HywPYUriFS9uDpZdicckb6oWMuj+AyP/ZW6/iU5Ans13LlQ1s3KItqqbLCcz9jI36f+h
         Pfg96XcDs/dftv0NZxi3m8EF/g+HksSZXIDziZKQWdrB1oit0RCyIOXzHfHlt3SuXTjB
         sWpvpJqkAta+vRFq13GCKs8ZSV1aS0FM6qnLk3DDuv7znRvDlIs3nKP9HdHiVNMGOdBT
         RHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716906279; x=1717511079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wg8CtjNjFgeTw9feqCVVRxh9BF8aMu7Y3qqfuAJtbso=;
        b=hN4M+CfvxaZ6Xja911kfh0G95yRw3fhgr71/C63FWxhj54mya6zkJL0xg4x0jZ8Hb0
         YEq89oEEikTJh84HtBRmr86MbmsHKwScv7CcKnz1Ldpf6de/Jvz8FmHERBAtsEDE7UEZ
         or/ODpYJECXz7NILfU8L4lb8YdT/0JZEiIbXaiM5vy/mfWuFDR2dbQnG81YrYb0YkU1t
         /Rq7Ay5jCsdAeq8bj3eg91eEKs/Cv439G8KFjVd47pqmiFXA3cBxGWmEMEICCW26MqE7
         E5X9DtWIcfuhAvjmcRt2iY6IGFffpXAoDTlaJXr0SPhQljjONbNagFRBsZM7VXdg4bud
         PD9A==
X-Forwarded-Encrypted: i=1; AJvYcCVkwqj0XY314JFiYAKNq/MN1BXjdfhFUQJqiRvoVM4wlV3ASYcaPYPmYkSjUcHl5CAR8jAYprSc6XwK4EjrnLOwj2tvAObYk+uLt4ujxG6LmBecumKIXBIgYSh4vscaqQWz2ZxGtT1leJE91Y3AmLPlDplILAvwKPZ7TroHbjXTYg==
X-Gm-Message-State: AOJu0YxsD2Py7FLHss+TFS0RGfKdxWMigOV0a/os/5Sy9SCsAM1dtjx2
	NpPNo/XuMSp524tCWBJtmnAOIvQ6LUguNrqGSCjNx23D4o+PkI1OOnkxHcKrnSk=
X-Google-Smtp-Source: AGHT+IGn4BxkX1WFMimSR6i41u9QLQdoI0QIrIveo8gqbpbt8B6dgdBlhshzx+k1HelehukXIJgr+w==
X-Received: by 2002:a50:d615:0:b0:579:c1fc:b94d with SMTP id 4fb4d7f45d1cf-579c1fcbc25mr5794864a12.6.1716906278575;
        Tue, 28 May 2024 07:24:38 -0700 (PDT)
Received: from rbolboac.. ([2a02:2f0e:350b:4500:3736:ef2a:a857:c911])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579d7dc9efesm2495580a12.48.2024.05.28.07.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 07:24:38 -0700 (PDT)
From: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
X-Google-Original-From: Ramona Gradinariu <ramona.gradinariu@analog.com>
To: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	corbet@lwn.net,
	conor+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	robh@kernel.org
Cc: Ramona Gradinariu <ramona.gradinariu@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH v2 1/6] iio: adis16480: make the burst_max_speed configurable
Date: Tue, 28 May 2024 17:24:04 +0300
Message-Id: <20240528142409.239187-2-ramona.gradinariu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528142409.239187-1-ramona.gradinariu@analog.com>
References: <20240528142409.239187-1-ramona.gradinariu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With this, we can pass the maxixum spi burst speed to the
'ADIS16480_DATA()' macro. This is in preparation to support new devices
that have a different speed than the one used so far.

Co-developed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
---
no changes in v2
 drivers/iio/imu/adis16480.c | 84 +++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index b40a55bba30c..bc6cbd00cd4b 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -107,8 +107,6 @@
 #define ADIS16495_BURST_ID			0xA5A5
 /* total number of segments in burst */
 #define ADIS16495_BURST_MAX_DATA		20
-/* spi max speed in burst mode */
-#define ADIS16495_BURST_MAX_SPEED              6000000

 #define ADIS16480_REG_SERIAL_NUM		ADIS16480_REG(0x04, 0x20)

@@ -872,33 +870,33 @@ static const char * const adis16480_status_error_msgs[] = {

 static int adis16480_enable_irq(struct adis *adis, bool enable);

-#define ADIS16480_DATA(_prod_id, _timeouts, _burst_len)			\
-{									\
-	.diag_stat_reg = ADIS16480_REG_DIAG_STS,			\
-	.glob_cmd_reg = ADIS16480_REG_GLOB_CMD,				\
-	.prod_id_reg = ADIS16480_REG_PROD_ID,				\
-	.prod_id = (_prod_id),						\
-	.has_paging = true,						\
-	.read_delay = 5,						\
-	.write_delay = 5,						\
-	.self_test_mask = BIT(1),					\
-	.self_test_reg = ADIS16480_REG_GLOB_CMD,			\
-	.status_error_msgs = adis16480_status_error_msgs,		\
-	.status_error_mask = BIT(ADIS16480_DIAG_STAT_XGYRO_FAIL) |	\
-		BIT(ADIS16480_DIAG_STAT_YGYRO_FAIL) |			\
-		BIT(ADIS16480_DIAG_STAT_ZGYRO_FAIL) |			\
-		BIT(ADIS16480_DIAG_STAT_XACCL_FAIL) |			\
-		BIT(ADIS16480_DIAG_STAT_YACCL_FAIL) |			\
-		BIT(ADIS16480_DIAG_STAT_ZACCL_FAIL) |			\
-		BIT(ADIS16480_DIAG_STAT_XMAGN_FAIL) |			\
-		BIT(ADIS16480_DIAG_STAT_YMAGN_FAIL) |			\
-		BIT(ADIS16480_DIAG_STAT_ZMAGN_FAIL) |			\
-		BIT(ADIS16480_DIAG_STAT_BARO_FAIL),			\
-	.enable_irq = adis16480_enable_irq,				\
-	.timeouts = (_timeouts),					\
-	.burst_reg_cmd = ADIS16495_REG_BURST_CMD,			\
-	.burst_len = (_burst_len),					\
-	.burst_max_speed_hz = ADIS16495_BURST_MAX_SPEED			\
+#define ADIS16480_DATA(_prod_id, _timeouts, _burst_len, _burst_max_speed)	\
+{										\
+	.diag_stat_reg = ADIS16480_REG_DIAG_STS,				\
+	.glob_cmd_reg = ADIS16480_REG_GLOB_CMD,					\
+	.prod_id_reg = ADIS16480_REG_PROD_ID,					\
+	.prod_id = (_prod_id),							\
+	.has_paging = true,							\
+	.read_delay = 5,							\
+	.write_delay = 5,							\
+	.self_test_mask = BIT(1),						\
+	.self_test_reg = ADIS16480_REG_GLOB_CMD,				\
+	.status_error_msgs = adis16480_status_error_msgs,			\
+	.status_error_mask = BIT(ADIS16480_DIAG_STAT_XGYRO_FAIL) |		\
+		BIT(ADIS16480_DIAG_STAT_YGYRO_FAIL) |				\
+		BIT(ADIS16480_DIAG_STAT_ZGYRO_FAIL) |				\
+		BIT(ADIS16480_DIAG_STAT_XACCL_FAIL) |				\
+		BIT(ADIS16480_DIAG_STAT_YACCL_FAIL) |				\
+		BIT(ADIS16480_DIAG_STAT_ZACCL_FAIL) |				\
+		BIT(ADIS16480_DIAG_STAT_XMAGN_FAIL) |				\
+		BIT(ADIS16480_DIAG_STAT_YMAGN_FAIL) |				\
+		BIT(ADIS16480_DIAG_STAT_ZMAGN_FAIL) |				\
+		BIT(ADIS16480_DIAG_STAT_BARO_FAIL),				\
+	.enable_irq = adis16480_enable_irq,					\
+	.timeouts = (_timeouts),						\
+	.burst_reg_cmd = ADIS16495_REG_BURST_CMD,				\
+	.burst_len = (_burst_len),						\
+	.burst_max_speed_hz = _burst_max_speed					\
 }

 static const struct adis_timeout adis16485_timeouts = {
@@ -944,7 +942,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 2048,
 		.has_sleep_cnt = true,
 		.filter_freqs = adis16480_def_filter_freqs,
-		.adis_data = ADIS16480_DATA(16375, &adis16485_timeouts, 0),
+		.adis_data = ADIS16480_DATA(16375, &adis16485_timeouts, 0, 0),
 	},
 	[ADIS16480] = {
 		.channels = adis16480_channels,
@@ -958,7 +956,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 2048,
 		.has_sleep_cnt = true,
 		.filter_freqs = adis16480_def_filter_freqs,
-		.adis_data = ADIS16480_DATA(16480, &adis16480_timeouts, 0),
+		.adis_data = ADIS16480_DATA(16480, &adis16480_timeouts, 0, 0),
 	},
 	[ADIS16485] = {
 		.channels = adis16485_channels,
@@ -972,7 +970,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 2048,
 		.has_sleep_cnt = true,
 		.filter_freqs = adis16480_def_filter_freqs,
-		.adis_data = ADIS16480_DATA(16485, &adis16485_timeouts, 0),
+		.adis_data = ADIS16480_DATA(16485, &adis16485_timeouts, 0, 0),
 	},
 	[ADIS16488] = {
 		.channels = adis16480_channels,
@@ -986,7 +984,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 2048,
 		.has_sleep_cnt = true,
 		.filter_freqs = adis16480_def_filter_freqs,
-		.adis_data = ADIS16480_DATA(16488, &adis16485_timeouts, 0),
+		.adis_data = ADIS16480_DATA(16488, &adis16485_timeouts, 0, 0),
 	},
 	[ADIS16490] = {
 		.channels = adis16485_channels,
@@ -1000,7 +998,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.max_dec_rate = 4250,
 		.filter_freqs = adis16495_def_filter_freqs,
 		.has_pps_clk_mode = true,
-		.adis_data = ADIS16480_DATA(16490, &adis16495_timeouts, 0),
+		.adis_data = ADIS16480_DATA(16490, &adis16495_timeouts, 0, 0),
 	},
 	[ADIS16495_1] = {
 		.channels = adis16485_channels,
@@ -1016,7 +1014,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.has_pps_clk_mode = true,
 		/* 20 elements of 16bits */
 		.adis_data = ADIS16480_DATA(16495, &adis16495_1_timeouts,
-					    ADIS16495_BURST_MAX_DATA * 2),
+					    ADIS16495_BURST_MAX_DATA * 2,
+					    6000000),
 	},
 	[ADIS16495_2] = {
 		.channels = adis16485_channels,
@@ -1032,7 +1031,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.has_pps_clk_mode = true,
 		/* 20 elements of 16bits */
 		.adis_data = ADIS16480_DATA(16495, &adis16495_1_timeouts,
-					    ADIS16495_BURST_MAX_DATA * 2),
+					    ADIS16495_BURST_MAX_DATA * 2,
+					    6000000),
 	},
 	[ADIS16495_3] = {
 		.channels = adis16485_channels,
@@ -1048,7 +1048,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.has_pps_clk_mode = true,
 		/* 20 elements of 16bits */
 		.adis_data = ADIS16480_DATA(16495, &adis16495_1_timeouts,
-					    ADIS16495_BURST_MAX_DATA * 2),
+					    ADIS16495_BURST_MAX_DATA * 2,
+					    6000000),
 	},
 	[ADIS16497_1] = {
 		.channels = adis16485_channels,
@@ -1064,7 +1065,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.has_pps_clk_mode = true,
 		/* 20 elements of 16bits */
 		.adis_data = ADIS16480_DATA(16497, &adis16495_1_timeouts,
-					    ADIS16495_BURST_MAX_DATA * 2),
+					    ADIS16495_BURST_MAX_DATA * 2,
+					    6000000),
 	},
 	[ADIS16497_2] = {
 		.channels = adis16485_channels,
@@ -1080,7 +1082,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.has_pps_clk_mode = true,
 		/* 20 elements of 16bits */
 		.adis_data = ADIS16480_DATA(16497, &adis16495_1_timeouts,
-					    ADIS16495_BURST_MAX_DATA * 2),
+					    ADIS16495_BURST_MAX_DATA * 2,
+					    6000000),
 	},
 	[ADIS16497_3] = {
 		.channels = adis16485_channels,
@@ -1096,7 +1099,8 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
 		.has_pps_clk_mode = true,
 		/* 20 elements of 16bits */
 		.adis_data = ADIS16480_DATA(16497, &adis16495_1_timeouts,
-					    ADIS16495_BURST_MAX_DATA * 2),
+					    ADIS16495_BURST_MAX_DATA * 2,
+					    6000000),
 	},
 };

--
2.34.1


