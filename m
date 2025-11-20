Return-Path: <linux-iio+bounces-26330-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF31BC72E59
	for <lists+linux-iio@lfdr.de>; Thu, 20 Nov 2025 09:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 38A5235B349
	for <lists+linux-iio@lfdr.de>; Thu, 20 Nov 2025 08:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BB330F544;
	Thu, 20 Nov 2025 08:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cqcNsUiy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA3030C61E
	for <linux-iio@vger.kernel.org>; Thu, 20 Nov 2025 08:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763627183; cv=none; b=GzRaf966RPO7eiBdRSXJ3l3/f8ccmYK4h6u1cPMXz1AIBXlcPGK6hTUpSBbnjngY2vxgDiD6yMtRerLfFjm3VcfET0UddQhWDj2btsgjYHlhOYO96lioDRCsfDjJM6uCrmGVO7j558bnoSM/hMdb/9n6Mqx6vTe5pPtRmyjtwe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763627183; c=relaxed/simple;
	bh=47mPrZHijqjGm1AMWrbG+8cwdi3Wv5j/BmTxIhmQBEw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LtFS79Um20u75dLIkHA+rxvsDS67fxb5xDfzJOKTt9C8LfhHiymNXjhakVABZIDzBolAduys15YRr4LuR+7o9Csw+7oJ7l8FlcWJtN11E4pQ6+w1ShzNgZuq3eeAI+7CI/BpRRrXsmo62U+y953kZGy3IMReUTlmCUEOvpHHYRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cqcNsUiy; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b387483bbso371752f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 20 Nov 2025 00:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763627180; x=1764231980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lPSxFWZnb/6QKSItrwTL8YBNanLm9rz5scONQu9zZ0Y=;
        b=cqcNsUiy2TTU+DDR764pRMv5B5q2TdszTOC6DshpuuReVyLBi8gHGgK7gFBsPgcCO6
         sgMs9vy7n40xt3X6P1qA85+/4SuMEnDQDpa8GXkjYDvFkQUWtjsU2LSWMma/ofxG3Bb5
         9b5DfidXEoO60CLZn5pjAwQ4i+66CaIRtxsmft2hldDsE3xhMvzSB+A/wMewrIz/9EbA
         R+5XhAuRLfCTcVmBmMpmGJViVCFpHoiLfaU0JEEH4706n0kEmGX8ci9UjgD/aO2qfzfc
         b+qEMb5xEUoDivh+BUSG1OuzbiIxsMV7ao+axYuPl0gtzE+49dejF0izlj/rGmetoGOF
         vL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763627180; x=1764231980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lPSxFWZnb/6QKSItrwTL8YBNanLm9rz5scONQu9zZ0Y=;
        b=b0qxQyNMx8WCMLBy935O3PbBFa4mrODri4A9+znQZCG490KTdd9zFzCiUjrWp0ruPh
         ETH8pUUgePAOb8ncBgdCidfgIUH9YAJ7myaPxnvq29j80FUoNlLDdDiusemPuIi9Ak8I
         5JLL5Gtys04U1tBHiqTc+TPFt38WWu1hTkwn9hbkqYxoNyJYxq10qVZQlZEd81ago69T
         xWgz08ET649Zx0lbjQ3udXrFNzUQgOWxHB5tECOKw5WU9sX2cio66r0CnbDaIRsINNTx
         Kow2LfB7jZ47ywPo5IGAyiSK9+AE5hOiUKpEOPYuUym9Wd/Wq0YDxxoWoEN/ezk6a/rt
         oBVg==
X-Forwarded-Encrypted: i=1; AJvYcCX0RzZ34f5qVw3i6QG70LMPrmWPV/SkG5N2EDXcQ3MAMCdMwyciwOyltptEIfF3x9j7/w/W7JELEPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmdjxWJ42omeKeNu2ptCP2Ekc+9Sj0AC5OMi3jJ/X3LmUEj4eu
	YRqWK/hVlQkXAwAwSirUgkgcO92cSSsC1pjN1oh1PGLfyq6SEew/wzAvhugAU3GMoi759sxpiL5
	HEd8e
X-Gm-Gg: ASbGnctW6P1bbXBwep9tYQ9bOWzpcoz9qaDugYqYnDMZ0lgQSiYlaZUODeMqfWA4+iE
	uXWAvCZH3rlHnu9HyI1WoG3HUrDx4NidkvvQ6mfSEpKWTnfbQ5qJ7ttNi6PTAtuyhoJ6pXsGMIX
	nqhoJTWl5J7JfmzKRKlAy/f1d0LVM8hyiJwegK6cYkC0W/AD2ybw1Kpg8hokqHft+qkBPsFWJWE
	svY/ONfnef29Wjw4K3aUooKbTUSuU9Q+0FBbvoVh+2Ag+8T4ZLd2ey01pOm1hvVHFVK5P2PAtlo
	vj5PE+KNrWPx8p6rzlLmd9zLtUgr/NKBBr/WIk/db8vzWcAyGmdNFPtdhGORD5kf6Rv3Cd0gKYR
	qmb1XPNq7zk/hp0U7zbcT+BgSz0DzzsxingaIXiJ38AfRspqWD87btJg=
X-Google-Smtp-Source: AGHT+IFaIl00qIG4e442uJoYOLlCW4eU3tv1KImChCNKtIRML0L/ku2AMvpYaIrNrF2rsZ6awug8Cg==
X-Received: by 2002:a05:6000:288f:b0:429:ef82:585b with SMTP id ffacd0b85a97d-42cb9a0c689mr1817244f8f.9.1763627179616;
        Thu, 20 Nov 2025 00:26:19 -0800 (PST)
Received: from localhost ([151.35.219.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb8e62sm4013666f8f.35.2025.11.20.00.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 00:26:19 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/9] iio: imu: st_lsm6dsx: make event_settings more generic
Date: Thu, 20 Nov 2025 09:26:08 +0100
Message-Id: <20251120082615.3263892-3-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251120082615.3263892-1-flavra@baylibre.com>
References: <20251120082615.3263892-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8384; i=flavra@baylibre.com; h=from:subject; bh=47mPrZHijqjGm1AMWrbG+8cwdi3Wv5j/BmTxIhmQBEw=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpHtB59m6Jh10y8zsCS9pO++AMDbpz3lwlF7nmT y56gCrKdbeJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaR7QeQAKCRDt8TtzzpQ2 X26xDACmOnjzcLOdsDuEy9HEjdlskDOXOdtcyxEF1uIYEziYNGU0CxGJBZr82BXkHA8J/6BKjj4 qBv1UcQsVoaM5Zs/A/64dEcvAzzBjrdxD6Vfm5YCXUQ4vKkGVqup7LvQZzqDI+fqOaY++Boom7d nOJl6v7ZDjPJHWE51tptaS5ShtOzBbozXxpzQjk9sUdFeAuEigOKzhvT6FYFmH8d2b9t30Wg99o CSpmaK+Ql5WINqy+91z012YWhD/DFlC2NXEDLsfmPe7Q/ATDLRvhwZrsGjr9LVxtCSG3Iu384ne QmaD1rxbzNWWrFaxvIaqHQRzKCibmhpNyGp4XZNex2Ga69ax5GEvWyyo1XnJQZWoG05gA68MaZ6 9jFTllKM6uL413Su7igpn6eA1VfLpfB+lT10tU6FjepdkT9cLo35EyMR1tzy7yusJYVeEYnAF+y gn8MUCmN5wL8XRwnFK4kIm6o9NK+fF42UvLQaGrexluY0Za2WybmVRWtJrj6ZIJ7jDhZ4=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The st_lsm6dsx_event_settings structure contains fields specific for one
event type (wakeup). In preparation for adding support for more event
types, introduce an event id enum and a generic event source structure, and
replace wakeup-specific data in struct st_lsm6dsx_event_settings with an
array of event source structures.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  21 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 134 +++++++++++--------
 2 files changed, 95 insertions(+), 60 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index a4f558899767..4c3ff1cc0097 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -242,14 +242,23 @@ struct st_lsm6dsx_shub_settings {
 	u8 pause;
 };
 
+enum st_lsm6dsx_event_id {
+	ST_LSM6DSX_EVENT_WAKEUP,
+	ST_LSM6DSX_EVENT_MAX
+};
+
+struct st_lsm6dsx_event_src {
+	struct st_lsm6dsx_reg value;
+	u8 status_reg;
+	u8 status_mask;
+	u8 status_x_mask;
+	u8 status_y_mask;
+	u8 status_z_mask;
+};
+
 struct st_lsm6dsx_event_settings {
 	struct st_lsm6dsx_reg enable_reg;
-	struct st_lsm6dsx_reg wakeup_reg;
-	u8 wakeup_src_reg;
-	u8 wakeup_src_status_mask;
-	u8 wakeup_src_z_mask;
-	u8 wakeup_src_y_mask;
-	u8 wakeup_src_x_mask;
+	struct st_lsm6dsx_event_src sources[ST_LSM6DSX_EVENT_MAX];
 };
 
 enum st_lsm6dsx_ext_sensor_id {
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index a09df9d772dd..a71174e75f44 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -388,15 +388,19 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 			},
 		},
 		.event_settings = {
-			.wakeup_reg = {
-				.addr = 0x5B,
-				.mask = GENMASK(5, 0),
+			.sources = {
+				[ST_LSM6DSX_EVENT_WAKEUP] = {
+					.value = {
+						.addr = 0x5b,
+						.mask = GENMASK(5, 0),
+					},
+					.status_reg = 0x1b,
+					.status_mask = BIT(3),
+					.status_z_mask = BIT(0),
+					.status_y_mask = BIT(1),
+					.status_x_mask = BIT(2),
+				},
 			},
-			.wakeup_src_reg = 0x1b,
-			.wakeup_src_status_mask = BIT(3),
-			.wakeup_src_z_mask = BIT(0),
-			.wakeup_src_y_mask = BIT(1),
-			.wakeup_src_x_mask = BIT(2),
 		},
 	},
 	{
@@ -554,15 +558,19 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 			},
 		},
 		.event_settings = {
-			.wakeup_reg = {
-				.addr = 0x5B,
-				.mask = GENMASK(5, 0),
+			.sources = {
+				[ST_LSM6DSX_EVENT_WAKEUP] = {
+					.value = {
+						.addr = 0x5b,
+						.mask = GENMASK(5, 0),
+					},
+					.status_reg = 0x1b,
+					.status_mask = BIT(3),
+					.status_z_mask = BIT(0),
+					.status_y_mask = BIT(1),
+					.status_x_mask = BIT(2),
+				},
 			},
-			.wakeup_src_reg = 0x1b,
-			.wakeup_src_status_mask = BIT(3),
-			.wakeup_src_z_mask = BIT(0),
-			.wakeup_src_y_mask = BIT(1),
-			.wakeup_src_x_mask = BIT(2),
 		},
 	},
 	{
@@ -791,15 +799,19 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x58,
 				.mask = BIT(7),
 			},
-			.wakeup_reg = {
-				.addr = 0x5B,
-				.mask = GENMASK(5, 0),
+			.sources = {
+				[ST_LSM6DSX_EVENT_WAKEUP] = {
+					.value = {
+						.addr = 0x5b,
+						.mask = GENMASK(5, 0),
+					},
+					.status_reg = 0x1b,
+					.status_mask = BIT(3),
+					.status_z_mask = BIT(0),
+					.status_y_mask = BIT(1),
+					.status_x_mask = BIT(2),
+				},
 			},
-			.wakeup_src_reg = 0x1b,
-			.wakeup_src_status_mask = BIT(3),
-			.wakeup_src_z_mask = BIT(0),
-			.wakeup_src_y_mask = BIT(1),
-			.wakeup_src_x_mask = BIT(2),
 		},
 	},
 	{
@@ -1028,15 +1040,19 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x58,
 				.mask = BIT(7),
 			},
-			.wakeup_reg = {
-				.addr = 0x5b,
-				.mask = GENMASK(5, 0),
+			.sources = {
+				[ST_LSM6DSX_EVENT_WAKEUP] = {
+					.value = {
+						.addr = 0x5b,
+						.mask = GENMASK(5, 0),
+					},
+					.status_reg = 0x1b,
+					.status_mask = BIT(3),
+					.status_z_mask = BIT(0),
+					.status_y_mask = BIT(1),
+					.status_x_mask = BIT(2),
+				},
 			},
-			.wakeup_src_reg = 0x1b,
-			.wakeup_src_status_mask = BIT(3),
-			.wakeup_src_z_mask = BIT(0),
-			.wakeup_src_y_mask = BIT(1),
-			.wakeup_src_x_mask = BIT(2),
 		},
 	},
 	{
@@ -1209,15 +1225,19 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x58,
 				.mask = BIT(7),
 			},
-			.wakeup_reg = {
-				.addr = 0x5B,
-				.mask = GENMASK(5, 0),
+			.sources = {
+				[ST_LSM6DSX_EVENT_WAKEUP] = {
+					.value = {
+						.addr = 0x5b,
+						.mask = GENMASK(5, 0),
+					},
+					.status_reg = 0x1b,
+					.status_mask = BIT(3),
+					.status_z_mask = BIT(0),
+					.status_y_mask = BIT(1),
+					.status_x_mask = BIT(2),
+				},
 			},
-			.wakeup_src_reg = 0x1b,
-			.wakeup_src_status_mask = BIT(3),
-			.wakeup_src_z_mask = BIT(0),
-			.wakeup_src_y_mask = BIT(1),
-			.wakeup_src_x_mask = BIT(2),
 		},
 	},
 	{
@@ -1415,15 +1435,19 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.addr = 0x50,
 				.mask = BIT(7),
 			},
-			.wakeup_reg = {
-				.addr = 0x5b,
-				.mask = GENMASK(5, 0),
+			.sources = {
+				[ST_LSM6DSX_EVENT_WAKEUP] = {
+					.value = {
+						.addr = 0x5b,
+						.mask = GENMASK(5, 0),
+					},
+					.status_reg = 0x45,
+					.status_mask = BIT(3),
+					.status_z_mask = BIT(0),
+					.status_y_mask = BIT(1),
+					.status_x_mask = BIT(2),
+				},
 			},
-			.wakeup_src_reg = 0x45,
-			.wakeup_src_status_mask = BIT(3),
-			.wakeup_src_z_mask = BIT(0),
-			.wakeup_src_y_mask = BIT(1),
-			.wakeup_src_x_mask = BIT(2),
 		},
 	},
 	{
@@ -1935,7 +1959,7 @@ st_lsm6dsx_write_event(struct iio_dev *iio_dev,
 	if (val < 0 || val > 31)
 		return -EINVAL;
 
-	reg = &hw->settings->event_settings.wakeup_reg;
+	reg = &hw->settings->event_settings.sources[ST_LSM6DSX_EVENT_WAKEUP].value;
 	data = ST_LSM6DSX_SHIFT_VAL(val, reg->mask);
 	err = st_lsm6dsx_update_bits_locked(hw, reg->addr,
 					    reg->mask, data);
@@ -2420,6 +2444,7 @@ static bool
 st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
 {
 	const struct st_lsm6dsx_event_settings *event_settings;
+	const struct st_lsm6dsx_event_src *src;
 	int err, data;
 	s64 timestamp;
 
@@ -2427,13 +2452,14 @@ st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
 		return false;
 
 	event_settings = &hw->settings->event_settings;
-	err = st_lsm6dsx_read_locked(hw, event_settings->wakeup_src_reg,
+	src = &event_settings->sources[ST_LSM6DSX_EVENT_WAKEUP];
+	err = st_lsm6dsx_read_locked(hw, src->status_reg,
 				     &data, sizeof(data));
 	if (err < 0)
 		return false;
 
 	timestamp = iio_get_time_ns(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
-	if ((data & hw->settings->event_settings.wakeup_src_z_mask) &&
+	if ((data & src->status_z_mask) &&
 	    (hw->enable_event & BIT(IIO_MOD_Z)))
 		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
@@ -2443,7 +2469,7 @@ st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
 						  IIO_EV_DIR_EITHER),
 						  timestamp);
 
-	if ((data & hw->settings->event_settings.wakeup_src_y_mask) &&
+	if ((data & src->status_y_mask) &&
 	    (hw->enable_event & BIT(IIO_MOD_Y)))
 		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
@@ -2453,7 +2479,7 @@ st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
 						  IIO_EV_DIR_EITHER),
 						  timestamp);
 
-	if ((data & hw->settings->event_settings.wakeup_src_x_mask) &&
+	if ((data & src->status_x_mask) &&
 	    (hw->enable_event & BIT(IIO_MOD_X)))
 		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
@@ -2463,7 +2489,7 @@ st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
 						  IIO_EV_DIR_EITHER),
 						  timestamp);
 
-	return data & event_settings->wakeup_src_status_mask;
+	return data & src->status_mask;
 }
 
 static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
-- 
2.39.5


