Return-Path: <linux-iio+bounces-26465-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F17BC87042
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 21:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DED93B03E8
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 20:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A7F33B95E;
	Tue, 25 Nov 2025 20:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NtgUY5kd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D775933B97F
	for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 20:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764102197; cv=none; b=R39zWAjcsMOfW5mth7OU1PQdNRFcEsV8mHxqc32loLef14p+kDIj7HixwyZi0V2xpJR7ALmxWlsEsNAxf1Ia52dM+UNe/D++xUnR7KP+Ko494yEHp/2xPbn4GOKigLWO6RSKu47c5izQMeW+YxM3ejxjDS0XbZmQxQLbmw8TAIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764102197; c=relaxed/simple;
	bh=h/L2zhPfn2Gbd634jm4+Ta6MvmpxMumLED/InTCkazs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gxv/dOTYQqbiFoBuJkuoKEcnZ8w9/dG+0G3oHotAxvjMp2z3w2oux3WTq1luUpfYnDHZ+UmCKVrb08Tz8LQKMqeI/asX66WSEBoFqLEUUSVhi6Az7fqT++u+syvqWY7y/TYAMh/IhpLy75PEF53HgRsf5K/6FNkZ1Dwrdn4KvaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NtgUY5kd; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7277324054so887207966b.0
        for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 12:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764102193; x=1764706993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vttCzqYG+Cs7YHIz7IHkrbbgN3J8iVBx1Ck/rBWwG+E=;
        b=NtgUY5kdTOL2oAU6Vix5LuEHdjCsNxPGcMYAb9/igzUTu9XM5ONLM+qCk58vcWO0JB
         VzbwT/KfIRcdi/13xCfRZNX1CWUlVkqKb3wUTeO0aY7Kx0TRsmoIoLlAqfgJ5KMDilmr
         nVrn0heZF/JO9FZZjPUsWMOypbUYMTNf6EcYAKjGkP5LgcCwSu/oj4/t3MveIG8Ntuf1
         iYHjHxg3uW1j5n46VRjM4xgwqqGvJvsvMwk1qENNgrwn589c8CW7EeYsLdZxQMbJd+s5
         vJjldG+9OfZH+rnPOYMf/yKzo0E6DBd/jTT4Cg5VChbzH6wEuKCfiGfIkvYjJXgoPg7Y
         xi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764102193; x=1764706993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vttCzqYG+Cs7YHIz7IHkrbbgN3J8iVBx1Ck/rBWwG+E=;
        b=vwGoLbvEWpFp6zkNtqoDLHeqsuyYzcfRfTrsgd/0GWoG8PlTmr+mY8K1yerddr8F8U
         tdb4zhnEif90V8+g5uZSo52DMWjFUrE4IWHcUWoV5czjwHyVMT9K+DHjW+lHltwM5DgI
         d8FlETiuQJT3z7mPuykY3Vc+8zOe6qlXj2dH1oDgpu9b/QDvXRjpSgT3xyPMyXMdcl/5
         pdmin7/7jkTn3NBDL3JD/AGm3LCwkFr0l9BjF+66XaTiZaHAGK7BIJyTVje3kFpPCUB9
         eV5/AB2RoYxJiW41p5tc2Yz8NCA6QNKirt/YYsBZLt0e4yyRDUQntyR8Z6oCXBXdJFf6
         dx7w==
X-Forwarded-Encrypted: i=1; AJvYcCXp/sdMzu6v2U2e0FSEX/Ve6qHJ0j8YQCsXYfKLuOwuOj8gWPBQ3YjqFNa7KQZtr5h1NzdRGSIAC0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNi69UP2Xy/Kf5IxB6mxiedrd9ed4sPsXEuFOyyw6HyWGdHQR/
	/gn3LY0hHUwFlOfBQB9rh96qmYGQe+1RneTA5JqOD88XruuXJq+nAfsXt5BFy0LPtI0Sc4bwrZn
	/sOEO
X-Gm-Gg: ASbGnctUj1U37woS23jDq8Vb4fUG+VhVIIME8nMOFbYFpyP8SKXrXBrCXe+o/izvDoG
	I+IHVHQpk9rQL5fp679yT5PgKkGY/HBVU6oGSE/7RbPeHQmDXjMMoBH2NpG7rFtweMVlHHpPjWA
	pnI7qTjBVQ9BLA8VOrRhT6xmQzxSSV1jwtEl1n93F9o2ZYYEQu/1tZrsKGkq7Bjfdj69Bf9SqBZ
	UV7dVPs+7TZsZmDTCXH8Q/KNmJOHb1awT3oaGIAaD8h2R2a2R6+LGooaa2G2aV0JxPMszjdg5EQ
	7Go3OVcn47SLUu0OL/552cjfAs9Qy0zLB8WOODTFjg1gphIcAer5ejEmRj9ISZqiCVk29LT4jsW
	dutY5ZdrxWpzOLV8q2jRErMLJyRIq2yY8iTQX3Di3htoxD2dZ0qjrjJF5+O1tf42Oz4b1iKp97O
	LNWQ==
X-Google-Smtp-Source: AGHT+IEwart1K70Q3xXtXpl06Gau6o0XlxmPQ5x1c27gnod+RvTriYDy8X1oG5B3wY1ZU8APCJnKOw==
X-Received: by 2002:a17:906:7310:b0:b73:667e:bb29 with SMTP id a640c23a62f3a-b7671558abcmr1505927566b.8.1764102192891;
        Tue, 25 Nov 2025 12:23:12 -0800 (PST)
Received: from localhost ([151.35.128.119])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b765502840csm1658891866b.59.2025.11.25.12.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 12:23:12 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v3 3/9] iio: imu: st_lsm6dsx: move wakeup event enable mask to event_src
Date: Tue, 25 Nov 2025 21:23:01 +0100
Message-Id: <20251125202307.4033346-4-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251125202307.4033346-1-flavra@baylibre.com>
References: <20251125202307.4033346-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7475; i=flavra@baylibre.com; h=from:subject; bh=h/L2zhPfn2Gbd634jm4+Ta6MvmpxMumLED/InTCkazs=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpJhADIWxqnj1iMqMM7C1xI7zGHft1pA3TgJ8Du 3wXagqwTE6JAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaSYQAwAKCRDt8TtzzpQ2 X3tHC/4xczSi8fr+pIP4kEK6iyJ+Yvg3q24BTBTB577oKwktl+HXXniqS4L5JOQkoaDNr9CbqsG w+Pvp2Lp/QPT1xUwgnrC0Clu23KFi9ClxWqxx7o2i+7RKvQ+u7yRZmAw7qa+jXxwq/7rrNfITm8 yvhIloTrc0OiFJPKIHQlISrxJ/4Gzxzl+sxzz2h1XQjlFPnTVf1BPL56IAwrUhFNP5/VQBAsTmf rDBWlURRwzPtoUbiVjtqtmcIg6br9cZ0w2aKXhEU3OnRGt76PZWSbaPCKsWtoaA7DDi9e0Sh0UK bWbfBeHmZ/W48gv+Gz1nmzvhdRmPRp99NAtURAkOw3yA3lDd7vcx72o141c5LYNg7L7AGDQhERK 1ludZpK9vZ2ga3RhSUpkPrSaGWVyeVDugFFr3NwqBD8EkU90s6CEqLBlQW0zud945n2+BRRQ/Md vguVr3zP5CNlBLHTpI2h+RFi13TbYWQqT2bHiPRVnwovxjO7Tmc+xH6bCPKo9vJsH5geM=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The mask value being assigned to the irq1_func and irq2_func fields of the
irq_config struct is specific to a single event source (i.e. the wakeup
event), and as such it should be separate from the definition of the
interrupt function registers, which cover multiple event sources.
In preparation for adding support for more event types, change the
irq1_func and irq2_func type from an {address, mask} pair to an address,
and move the mask value to a new field of struct st_lsm6dsx_event_src. No
functional changes.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  7 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 80 +++++++-------------
 2 files changed, 30 insertions(+), 57 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 80bc5686454b..4200e5231950 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -249,6 +249,7 @@ enum st_lsm6dsx_event_id {
 
 struct st_lsm6dsx_event_src {
 	struct st_lsm6dsx_reg value;
+	u8 enable_mask;
 	struct st_lsm6dsx_reg status;
 	u8 status_x_mask;
 	u8 status_y_mask;
@@ -343,8 +344,8 @@ struct st_lsm6dsx_settings {
 	struct {
 		struct st_lsm6dsx_reg irq1;
 		struct st_lsm6dsx_reg irq2;
-		struct st_lsm6dsx_reg irq1_func;
-		struct st_lsm6dsx_reg irq2_func;
+		u8 irq1_func;
+		u8 irq2_func;
 		struct st_lsm6dsx_reg lir;
 		struct st_lsm6dsx_reg clear_on_read;
 		struct st_lsm6dsx_reg hla;
@@ -443,7 +444,7 @@ struct st_lsm6dsx_hw {
 	u8 ts_sip;
 	u8 sip;
 
-	const struct st_lsm6dsx_reg *irq_routing;
+	u8 irq_routing;
 	u8 event_threshold;
 	u8 enable_event;
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index e8f0a2ff91be..ba163dd2ab82 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -328,14 +328,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x58,
 				.mask = BIT(0),
 			},
-			.irq1_func = {
-				.addr = 0x5e,
-				.mask = BIT(5),
-			},
-			.irq2_func = {
-				.addr = 0x5f,
-				.mask = BIT(5),
-			},
+			.irq1_func = 0x5e,
+			.irq2_func = 0x5f,
 			.hla = {
 				.addr = 0x12,
 				.mask = BIT(5),
@@ -394,6 +388,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 						.addr = 0x5b,
 						.mask = GENMASK(5, 0),
 					},
+					.enable_mask = BIT(5),
 					.status = {
 						.addr = 0x1b,
 						.mask = BIT(3),
@@ -500,14 +495,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x58,
 				.mask = BIT(0),
 			},
-			.irq1_func = {
-				.addr = 0x5e,
-				.mask = BIT(5),
-			},
-			.irq2_func = {
-				.addr = 0x5f,
-				.mask = BIT(5),
-			},
+			.irq1_func = 0x5e,
+			.irq2_func = 0x5f,
 			.hla = {
 				.addr = 0x12,
 				.mask = BIT(5),
@@ -566,6 +555,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 						.addr = 0x5b,
 						.mask = GENMASK(5, 0),
 					},
+					.enable_mask = BIT(5),
 					.status = {
 						.addr = 0x1b,
 						.mask = BIT(3),
@@ -702,14 +692,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x58,
 				.mask = BIT(0),
 			},
-			.irq1_func = {
-				.addr = 0x5e,
-				.mask = BIT(5),
-			},
-			.irq2_func = {
-				.addr = 0x5f,
-				.mask = BIT(5),
-			},
+			.irq1_func = 0x5e,
+			.irq2_func = 0x5f,
 			.hla = {
 				.addr = 0x12,
 				.mask = BIT(5),
@@ -809,6 +793,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 						.addr = 0x5b,
 						.mask = GENMASK(5, 0),
 					},
+					.enable_mask = BIT(5),
 					.status = {
 						.addr = 0x1b,
 						.mask = BIT(3),
@@ -957,14 +942,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x56,
 				.mask = BIT(6),
 			},
-			.irq1_func = {
-				.addr = 0x5e,
-				.mask = BIT(5),
-			},
-			.irq2_func = {
-				.addr = 0x5f,
-				.mask = BIT(5),
-			},
+			.irq1_func = 0x5e,
+			.irq2_func = 0x5f,
 			.hla = {
 				.addr = 0x12,
 				.mask = BIT(5),
@@ -1052,6 +1031,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 						.addr = 0x5b,
 						.mask = GENMASK(5, 0),
 					},
+					.enable_mask = BIT(5),
 					.status = {
 						.addr = 0x1b,
 						.mask = BIT(3),
@@ -1176,14 +1156,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x56,
 				.mask = BIT(6),
 			},
-			.irq1_func = {
-				.addr = 0x5e,
-				.mask = BIT(5),
-			},
-			.irq2_func = {
-				.addr = 0x5f,
-				.mask = BIT(5),
-			},
+			.irq1_func = 0x5e,
+			.irq2_func = 0x5f,
 			.hla = {
 				.addr = 0x12,
 				.mask = BIT(5),
@@ -1239,6 +1213,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 						.addr = 0x5b,
 						.mask = GENMASK(5, 0),
 					},
+					.enable_mask = BIT(5),
 					.status = {
 						.addr = 0x1b,
 						.mask = BIT(3),
@@ -1357,14 +1332,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x56,
 				.mask = BIT(0),
 			},
-			.irq1_func = {
-				.addr = 0x5e,
-				.mask = BIT(5),
-			},
-			.irq2_func = {
-				.addr = 0x5f,
-				.mask = BIT(5),
-			},
+			.irq1_func = 0x5e,
+			.irq2_func = 0x5f,
 			.hla = {
 				.addr = 0x03,
 				.mask = BIT(4),
@@ -1451,6 +1420,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 						.addr = 0x5b,
 						.mask = GENMASK(5, 0),
 					},
+					.enable_mask = BIT(5),
 					.status = {
 						.addr = 0x45,
 						.mask = BIT(3),
@@ -1911,10 +1881,11 @@ static int st_lsm6dsx_write_raw(struct iio_dev *iio_dev,
 static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, bool state)
 {
 	const struct st_lsm6dsx_reg *reg;
+	const struct st_lsm6dsx_event_src *src;
 	unsigned int data;
 	int err;
 
-	if (!hw->settings->irq_config.irq1_func.addr)
+	if (!hw->irq_routing)
 		return -ENOTSUPP;
 
 	reg = &hw->settings->event_settings.enable_reg;
@@ -1927,9 +1898,10 @@ static int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, bool state)
 	}
 
 	/* Enable wakeup interrupt */
-	data = ST_LSM6DSX_SHIFT_VAL(state, hw->irq_routing->mask);
-	return st_lsm6dsx_update_bits_locked(hw, hw->irq_routing->addr,
-					     hw->irq_routing->mask, data);
+	src = &hw->settings->event_settings.sources[ST_LSM6DSX_EVENT_WAKEUP];
+	data = ST_LSM6DSX_SHIFT_VAL(state, src->enable_mask);
+	return st_lsm6dsx_update_bits_locked(hw, hw->irq_routing,
+					     src->enable_mask, data);
 }
 
 static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
@@ -2183,11 +2155,11 @@ st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw,
 
 	switch (drdy_pin) {
 	case 1:
-		hw->irq_routing = &hw->settings->irq_config.irq1_func;
+		hw->irq_routing = hw->settings->irq_config.irq1_func;
 		*drdy_reg = &hw->settings->irq_config.irq1;
 		break;
 	case 2:
-		hw->irq_routing = &hw->settings->irq_config.irq2_func;
+		hw->irq_routing = hw->settings->irq_config.irq2_func;
 		*drdy_reg = &hw->settings->irq_config.irq2;
 		break;
 	default:
-- 
2.39.5


