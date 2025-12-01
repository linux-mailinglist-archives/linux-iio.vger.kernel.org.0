Return-Path: <linux-iio+bounces-26590-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D436BC968B1
	for <lists+linux-iio@lfdr.de>; Mon, 01 Dec 2025 11:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E9A3A3F95
	for <lists+linux-iio@lfdr.de>; Mon,  1 Dec 2025 10:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01B030595D;
	Mon,  1 Dec 2025 10:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iyZLJA2t"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8539D3054D7
	for <linux-iio@vger.kernel.org>; Mon,  1 Dec 2025 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764583251; cv=none; b=lXjlFqdBlAD3T+KYmKXMmLPKAROR1bTcOy3rw8RqU6npkIrgdRImEw8Z2sTMXyu4pu/vftz2xyBYR7WO/9Gn2yGOjOHTo0AgZAGAE90BAK4kE32TtlM3WNCHzLHD5LGi6Tq+YnKf+Xfr2NIS3/SYrDFv+euDwoaWwK/QGhO8CG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764583251; c=relaxed/simple;
	bh=3AqaMzAo/SdteHE5mpmxKXza3NAKzUzx2yzL4sMysqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LnDvXN+fSabkGo31tqEokkX5fIohMVorNcq0ydE0W15ymrKk/2AlJ1cVbgJ1rwCLd4huMkDw79Las5iW4vw/fx1Bcbqyspa3XJG75POD8diFANNZegmG1tyfi3z4N+EjrdPWNNJTo9hJFuQWlRSFPdqDkhn2nbln5ZLvLMUHdrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iyZLJA2t; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64074f01a6eso7170473a12.2
        for <linux-iio@vger.kernel.org>; Mon, 01 Dec 2025 02:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764583248; x=1765188048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/G8mYUOngTogtLwRSsvnDIX3G5P9ST+QdTt2B0Gx9Y=;
        b=iyZLJA2t6gQ2WNxkkWNT3Oy07bqnFruSK+mlGj/iM1cv5oVoPds83FupSLBhjkCFEM
         fT91cAtAfEeDBBZsnj1DYrsCj6LIGURsZqGpTcaz5axd0JeC2oehDlD2Jaq+sxYszJkY
         HmlWsSAe0fxkbHJ/RXaXvCpLtWB5MQz+IU96C9lEBvl1IDqEVtwWDgGL1hwqhoJBtUuU
         kzyjw4KHCyVJ5scFz9UyvIclcAI1rOSAIh2xH61RlDmuy0rreJ47/9GSJ74xh9R4DYQO
         Wa9laNn06i6s051egwbIsae6fIVW9i1hYTcm/3DE8o8xSbJR95idckwB+NzufUNhqCNb
         H8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764583248; x=1765188048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9/G8mYUOngTogtLwRSsvnDIX3G5P9ST+QdTt2B0Gx9Y=;
        b=j1m7Pv7XSMObsu35YCQLmBK2VXzehC019nJOb40+gdBTZnRE4q0zTOF9PTSmVC4jKi
         1jzp7UGPEDCC5MCd2W3RXdNDpyT4a9ANmAySBafCtJTExM/f84ggpt6cnPP66qdKX18t
         +8lgtV5ZUULOhZ7SM/RA6sH2YoyPQFaK4FnG0koC3/2cmF3oODiuhZGTjE7UZUJK0mZV
         7mrupF78ea1eUdWvDKxYtKvbg3X+y6VfVibE3FR3k6sLdYbrDqh6ISspCd/Ckj/nILM9
         +SIM8oBbBy/ISbNkEj0kuijsu5er3Iy9ATdf49UhO4tC8Bd5n61xhBe3Qkjkn4ivja0x
         ff1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXPQMfisCucqawlvjFpogqzGjIcjKZCCGf3VMNUczKBDYoW7DPXGOinG/fJj2FBfC+WANXmY8yqSI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTbwFycUEpR8+LoGQDzoEw8MEUhr8wUuZzqld4/vs406kzakwe
	KWmRw5qAj6787we8QZedthwIbTlfTim6XwA2iKrsNqLf7jwNwvY6Rk3pZd7rcnBMkag=
X-Gm-Gg: ASbGncsz+z6g5cijoQtfRUvHGcNDuwBTx3ukND23XB8/AKGbQi7/uYyQvCJ0wEJxZ/r
	mGsdfRqr/uoigj9CLREaipjn60bKfSSCinVdvi7pv46YKWPNq+EAD5SCO0bbm5pgCZRCPBarnOC
	pKyNS2ZTEIXLgMT6Tt0odDYxcuErV5l9UKK2Mr0e6mcnd+ddV0ya5CVZT3f7SMSAPKZn0Q98XL+
	ofAda3yKRs2XiqNXyJ1BsEqCXRFGuOX7h45xcjaofoYNwEYWBA62rZBYmMLncFUcgjFkbjRpqA/
	YpjTFNJUMjL96QMSna7xe5maeFZuEnOTzlWo0bS8xlujRCUF60iPxR9uWGuHQy5IZuQisSXRjTj
	HivqIFivXfPSruI9J9Swl5mchpD2GtwUQbY0F3HYX3FBwsL+JkTGUbFWw
X-Google-Smtp-Source: AGHT+IGthK7Ty7J1t2xmMgR2lsVCeQrT3yEG/RN8BxEQ059Av5b9KH09w+Gv6NVNxv95SdHGMgRmNg==
X-Received: by 2002:a17:906:9fc6:b0:b76:3599:649e with SMTP id a640c23a62f3a-b767168e416mr3364388566b.11.1764583247805;
        Mon, 01 Dec 2025 02:00:47 -0800 (PST)
Received: from localhost ([151.35.151.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f59aea78sm1139206766b.36.2025.12.01.02.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 02:00:47 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v4 9/9] iio: imu: st_lsm6dsx: add tap event detection
Date: Mon,  1 Dec 2025 11:00:18 +0100
Message-Id: <20251201100018.426749-10-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251201100018.426749-1-flavra@baylibre.com>
References: <20251201100018.426749-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4582; i=flavra@baylibre.com; h=from:subject; bh=3AqaMzAo/SdteHE5mpmxKXza3NAKzUzx2yzL4sMysqg=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpLWb7TTjJL6EHV7uldI7M8K5+O6aAHfDEcn0lg j5nmvAKlc+JAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaS1m+wAKCRDt8TtzzpQ2 XymQC/4nfpZDOY4Lk08dRDTOaBdnFI8xracqk8/m1uisl9mKmcS0eJE/64gq7UMg3lpxhr1grY6 kbsmcp/uRvYcvmQOvvBZHhTwIOlHDjWT4kvSAKpzuo2yeg+Skz/Q2wcXy3T5HGHeFERCvnX+AjS yG5iLyW4eTKitLCqVeRexLnWYtXeg+l+iZ46RMA9tO6YwQBmcs3q7R+w8/emMRLmFOMfecwt3YZ KpUUddmYXgjTupX55TwlARIPp187LVs9vV7c0eiX1TXeeZMw0YFW0CKsJrY+jiSWmPfrb8QeXMC b/dIY/LxLn2t2jp1PvZ3lExH3+YQOR6uCOiKkNlg95ikYK661+tallecLEldUAql2TikYzKDzNF Y1KUmxAEjXkfTJUOI6vEXnK3rHpElj2TwuNmKYaSlZPKDAABT5wpV37lIvcy2HmCwAPXRkeOmJA qs9U7nrujdU/Dwi15p/pjPlsM9PjYpNTfuxZywKrWlrw0lC32oyntVBs8JPH+Nvxlx3XQ=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

In order to allow sensors to advertise tap event capability and report tap
events, define a new struct iio_event_spec array that includes a tap event
spec, and a new struct iio_chan_spec array that references the new
iio_event_spec array; for the LSM6DSV chip family, use the new
iio_chan_spec array and define an event source for tap events.
Tested on LSMDSV16X.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 57 +++++++++++++++++++-
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 3edff8456a8f..957dae73e13d 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -245,6 +245,7 @@ struct st_lsm6dsx_shub_settings {
 
 enum st_lsm6dsx_event_id {
 	ST_LSM6DSX_EVENT_WAKEUP,
+	ST_LSM6DSX_EVENT_TAP,
 	ST_LSM6DSX_EVENT_MAX
 };
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 04a3c65d4546..e99556ccacd4 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -105,6 +105,21 @@ static const struct iio_event_spec st_lsm6dsx_ev_motion[] = {
 	},
 };
 
+static const struct iio_event_spec st_lsm6dsx_ev_motion_tap[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type = IIO_EV_TYPE_GESTURE,
+		.dir = IIO_EV_DIR_SINGLETAP,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
 static const struct iio_chan_spec st_lsm6dsx_acc_channels[] = {
 	ST_LSM6DSX_CHANNEL_ACC(0x28, IIO_MOD_X, 0, st_lsm6dsx_ev_motion),
 	ST_LSM6DSX_CHANNEL_ACC(0x2a, IIO_MOD_Y, 1, st_lsm6dsx_ev_motion),
@@ -119,6 +134,13 @@ static const struct iio_chan_spec st_lsm6ds0_acc_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
+static const struct iio_chan_spec st_lsm6dsx_acc_tap_channels[] = {
+	ST_LSM6DSX_CHANNEL_ACC(0x28, IIO_MOD_X, 0, st_lsm6dsx_ev_motion_tap),
+	ST_LSM6DSX_CHANNEL_ACC(0x2a, IIO_MOD_Y, 1, st_lsm6dsx_ev_motion_tap),
+	ST_LSM6DSX_CHANNEL_ACC(0x2c, IIO_MOD_Z, 2, st_lsm6dsx_ev_motion_tap),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
 static const struct iio_chan_spec st_lsm6dsx_gyro_channels[] = {
 	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x22, IIO_MOD_X, 0),
 	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x24, IIO_MOD_Y, 1),
@@ -1260,8 +1282,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 		},
 		.channels = {
 			[ST_LSM6DSX_ID_ACC] = {
-				.chan = st_lsm6dsx_acc_channels,
-				.len = ARRAY_SIZE(st_lsm6dsx_acc_channels),
+				.chan = st_lsm6dsx_acc_tap_channels,
+				.len = ARRAY_SIZE(st_lsm6dsx_acc_tap_channels),
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
 				.chan = st_lsm6dsx_gyro_channels,
@@ -1438,6 +1460,32 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 					.status_y_mask = BIT(1),
 					.status_x_mask = BIT(2),
 				},
+				[ST_LSM6DSX_EVENT_TAP] = {
+					.x_value = {
+						.addr = 0x57,
+						.mask = GENMASK(4, 0),
+					},
+					.y_value = {
+						.addr = 0x58,
+						.mask = GENMASK(4, 0),
+					},
+					.z_value = {
+						.addr = 0x59,
+						.mask = GENMASK(4, 0),
+					},
+					.enable_mask = BIT(6),
+					.enable_axis_reg = 0x56,
+					.enable_x_mask = BIT(3),
+					.enable_y_mask = BIT(2),
+					.enable_z_mask = BIT(1),
+					.status = {
+						.addr = 0x46,
+						.mask = BIT(5),
+					},
+					.status_x_mask = BIT(2),
+					.status_y_mask = BIT(1),
+					.status_z_mask = BIT(0),
+				},
 			},
 		},
 	},
@@ -1952,6 +2000,8 @@ st_lsm6dsx_get_event_id(enum iio_event_type type)
 	switch (type) {
 	case IIO_EV_TYPE_THRESH:
 		return ST_LSM6DSX_EVENT_WAKEUP;
+	case IIO_EV_TYPE_GESTURE:
+		return ST_LSM6DSX_EVENT_TAP;
 	default:
 		return ST_LSM6DSX_EVENT_MAX;
 	}
@@ -2620,6 +2670,9 @@ static bool st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
 	events_found = st_lsm6dsx_report_events(hw, ST_LSM6DSX_EVENT_WAKEUP,
 						IIO_EV_TYPE_THRESH,
 						IIO_EV_DIR_EITHER);
+	events_found |= st_lsm6dsx_report_events(hw, ST_LSM6DSX_EVENT_TAP,
+						 IIO_EV_TYPE_GESTURE,
+						 IIO_EV_DIR_SINGLETAP);
 
 	return events_found;
 }
-- 
2.39.5


