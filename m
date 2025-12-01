Return-Path: <linux-iio+bounces-26584-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 62397C968AB
	for <lists+linux-iio@lfdr.de>; Mon, 01 Dec 2025 11:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5C4253455F3
	for <lists+linux-iio@lfdr.de>; Mon,  1 Dec 2025 10:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A7B303A1A;
	Mon,  1 Dec 2025 10:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="T9T8iShB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7213019D6
	for <linux-iio@vger.kernel.org>; Mon,  1 Dec 2025 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764583238; cv=none; b=jwdEEswMrth/3PSVd7Y3hoXtdjlKvTVMeiG1Wi7aAodkjhbcaC++yUVgEEdxudGdvXlvB6kFYU+i/LEop627p69jnxY88GQTRLDo2Ec9D7MrROBwndWxBM9jV8lI6jNrDLZXgovQ1SCJhAHbExZKnljG8oqG0KEmKcVChWe0S50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764583238; c=relaxed/simple;
	bh=h/L2zhPfn2Gbd634jm4+Ta6MvmpxMumLED/InTCkazs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MmQaSadPX/Zv+4IVDIj8fZ3AaDvvTuAm0t70L7POEwXY6qfF9e1mAj2glQYVm+joXHOkzf6L7X8Pm6hwb7kBF5XBf746JQHQs/bKb7O1fDtYUnzXIRwwoJJsJhkGvnedk562783rPqxpMZtUVU7UArZ24bvu0XLf7ghXPehJo/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=T9T8iShB; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7c7503c73b4so2302166a34.3
        for <linux-iio@vger.kernel.org>; Mon, 01 Dec 2025 02:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764583235; x=1765188035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vttCzqYG+Cs7YHIz7IHkrbbgN3J8iVBx1Ck/rBWwG+E=;
        b=T9T8iShB8aRpu+jvoV6hvCzjhXjPHvYLotqbQwyZOykGwHignw87vRsYdD1d9dwV2s
         vGcZ3MyUm7PzvhlM7D9z+rDPPPiTDL7e+l1y/vaaGxXMyWcmrMgeT51R3NLyIxoATu/S
         QB3Sthl9jTDiQfp7K3REYi9s/8DC312VJYR9heVpGKuEJbLZ1i0N4TaV7OOhrK9gGO41
         A9IafUEUPW9TSJ/1+k+/q7gJePTqpgJhiNIMKcRBLs4yGFr4vv/RaMWexAwA2NtF8YUD
         pR6T3eVstkjfJWyqE2Sa7WN04zKSvaxGB8NamTKqikYkW0YO/glqp4eHz/26VMUAf0UM
         NnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764583235; x=1765188035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vttCzqYG+Cs7YHIz7IHkrbbgN3J8iVBx1Ck/rBWwG+E=;
        b=u0Wf34Slw7u59nyqwSOsKTh/sw+OZA0DRh+SH9nzDKSEpjdUset0qOV+ux5W2SI5aQ
         +ZUEAciAQcmwB26fbKHMDeqaWHVL9mV//i9nZcgwmSX4LslzMawVUmhZU2kP2TNNSrcS
         lS9TlWz/pPRyAEbERZQGkgGlrRV8aix5D7DmTWTCu5q6q64SsbNURsa0MKT5DoWti3cO
         d2yaCuGkT2k28NcDv+7Tx7Fdas5NAqTSmkhAsN9M/ZaaxsePZhox6VMgxoFsHkX6qlpJ
         9Kp1Gj/8fiNAGkkOjnhS/kY7iXKHt/bWCyxjwn6aDxpA4lkmo6mqnFlUcv7Mc9QO1c1q
         xnxA==
X-Forwarded-Encrypted: i=1; AJvYcCXRLumgLcVHNQccg7IJRYPGZJ2rbjaVg7iLeA+f/flDhDwgCMd3gWpNnV/3AubVALtN5JdlogJbiRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIxIvXA0WPGYvgSvLa/8Bcl+dQxheEV61kk04NyLFzQGskas6+
	JTTk83aWS5tT9mWrtTqAPlJaPoC91zqTTg8eSpnIII1CWH6EeHdfsuHRzCOJqXZG4dU=
X-Gm-Gg: ASbGncu+Wk7vb/SlS7UfZCp95MubJMBfMEGqZoWRJwZYKAMwy19AS8j+bwPEYInkICf
	fB118KAke/DqNfJEe6E/0JLcSEAzjXvMsRldsWx/rZj93zXFntxcm/zrFg7R2rSSRTUgxuWl7ZJ
	vDZ4Ok6BPIaNuAnUr3koiSfl0NMVM6Lkd3cPJK5A51SDb1IKPy0dFy3co/57bOE+YyY5KuzRtJS
	JqBHGR+cyO+sh1DAqiLBHzsTe4SEldfoZqyqwbFLOiZLw/cMP8oWv4r723bqlNgCIJbLR3fRkGD
	x4v9AVHFgmB4MdayIkea6Z6p0blPXZA4/O2myi6Q3rceAxPP9tuh+Py1+ASIsdrLREJcN5PMbIg
	A1DjbvIJWKFwmn6pRuelum0/0pubDB5WnvgCVT8/hOoOYsX2hZU0VuPGa
X-Google-Smtp-Source: AGHT+IH7ZXhKoR6QdClQKtV9d4tJbGaLp0zYNqtJ/pVkxVzNrRm1NwbNfJv/moDNWmGyhyh6+uGaNw==
X-Received: by 2002:a05:6830:6f0e:b0:7bd:f7c:ee with SMTP id 46e09a7af769-7c7990938c3mr15929504a34.25.1764583234871;
        Mon, 01 Dec 2025 02:00:34 -0800 (PST)
Received: from localhost ([151.35.151.28])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65933ef2772sm2404465eaf.17.2025.12.01.02.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 02:00:33 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v4 3/9] iio: imu: st_lsm6dsx: move wakeup event enable mask to event_src
Date: Mon,  1 Dec 2025 11:00:12 +0100
Message-Id: <20251201100018.426749-4-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251201100018.426749-1-flavra@baylibre.com>
References: <20251201100018.426749-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7475; i=flavra@baylibre.com; h=from:subject; bh=h/L2zhPfn2Gbd634jm4+Ta6MvmpxMumLED/InTCkazs=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpLWb4IWxqnj1iMqMM7C1xI7zGHft1pA3TgJ8Du 3wXagqwTE6JAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaS1m+AAKCRDt8TtzzpQ2 X8yZC/9QliEPg2bAB+HsEAR+Kte5NAi9Ci6IPu0GEtSkwGgkRE7RoxnywqldPG2dLob4w/2Mc7/ iyrWQoCNF3X9FBfTd9UNJrfh00Wju7Jg1rqpUk91UBr5vygfJUF6FzxfsDpol0ueUohhfuidQYO QVQ7VMNlfTG52GmT9LyDbLNgn3zSIISFAUl56jk/AeZiNpDseKTeBQEb1VovyWn/StROI2iRbVc GUogZBCzI/8uGk7ZzmiA6+adegA3G7BB0XWvCjNJtMTazpRogynaiWVQcleq3yJFxp77trwuOPR MFgR2m9ERjJ5FMp28DvWe0bpXQZ3aQly27dUL0nXFU5aKGHTqrIdXUAxQVg2yBTXjEHhzMNJNxn 7TMz3qTusODYGAgjX8LAA1po4de1bDmLSNv8RGMJONrVHh84Tz9mFdb2sQmtKJvVHl1M2t+/8gt 0qwopefsLxVzQxDmVeYopp5nxKab1qY8d87VeqyHc10EvR04t3T4BY1/cIYJkVZXRJReo=
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


