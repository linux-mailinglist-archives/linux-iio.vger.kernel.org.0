Return-Path: <linux-iio+bounces-26337-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 75240C72EB6
	for <lists+linux-iio@lfdr.de>; Thu, 20 Nov 2025 09:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8E9C4EDFB1
	for <lists+linux-iio@lfdr.de>; Thu, 20 Nov 2025 08:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF34328273;
	Thu, 20 Nov 2025 08:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PV//OcXK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2049325735
	for <linux-iio@vger.kernel.org>; Thu, 20 Nov 2025 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763627191; cv=none; b=WSy3lhDG6ndC4dunMJPb7IjHK3OPDZtz8Atw1eECJqIl+n3itF6JjE7bE7/fZozV0AFuTkI+VMKDmieaFv0K7emRRPJEBI46gsEd9Jfzvi6NWkekBb/fvM6qaLXGt1DHi2Y6tuj2Qr+o35lRAjckO3tcYCZM3uieLEOyuxpBfv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763627191; c=relaxed/simple;
	bh=rCueut8oKenLkzP/pdx8S5ZQVc/azzywTOOlHs8t1/A=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nIunxEDx7vFTfC+pQMsiIeuSUbFn7GdqZVV1qOV5PhtwLpLFPtYsY44QWJ68a/Griqhc+YDQeGzVDXdGESzzCsaipC2qiDQQtLXszu3+K5FkRPGNBXksXDNNh9oCiQjsw4ZAku0pPQPUHpKTEfNVJXUtquEBI97kPxGnvQnZdWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PV//OcXK; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42b39d51dcfso334335f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 20 Nov 2025 00:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763627188; x=1764231988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PX6DdzcBdAgazqaRtWaoP1G3y29Y/m2GG3jReyS8qiU=;
        b=PV//OcXKLO49qFfNi8bUQ7lQ7Qq62Y9+fOqVpd7C8PX5qlbKz2PxbL3e2mDmvqCmgI
         sslje1OwtS6oHidVezw/E0zqdxfItcyRsCke/+2sZk4YGeXQNpXsLBqBBf+Uv2Yy8pJX
         x1CS+pISI8SPrJeub2zNimsuthPD8lylcuQzcJydP69sNQFM/kEkgpFWQmEQscgzBK3D
         UaIJHV6Py9Ui58sR6J2Pf45854JT/KjBkChMVZExKSPxZ6CWMAAOmf2aPdQP+z+ToxA8
         vGwfBJuOJ4fXgOvuuVtw9yDYPQAXZpOcI7xRnWjdEq3fShKMg/kS9yRGrquNS8l/H6JF
         1wlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763627188; x=1764231988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PX6DdzcBdAgazqaRtWaoP1G3y29Y/m2GG3jReyS8qiU=;
        b=oZ41wTP6lafwnfbP/E0hPOmTh0yOQ+URlkr+G/POehovO/GBrMKrF+8zWWw2hIEsPe
         Bgfez67mVsvPJaJG6gI0PknT8fDsIQHnSldqVFZr0P9X24J2KOUD8DkY4sYuJquQBsOH
         6DvR+KOSk/e7pBLf9Bun54HjpDVn1nM6Nqhak6vIfGn8kPsbx9OytxaWU2M4XjomEw95
         ipHHd5pC4mo7CdwbEHkysUDPNnuaCGFbLzxyzZSEtZd/HNCuOCVFi+uil27o5pa1JFZI
         dPP6rwNLgEByoQPGNyF5BVNs221/Z3WKfn/zX7Yx7LtW3a37oUs4yyATd8c7zuQVG/3l
         Du0g==
X-Forwarded-Encrypted: i=1; AJvYcCWhba0AWKqG6+0tv8/NVazfrQSh7lMmCzDQUE7DiCBS5ZK6wIflMdoQ9+cvpZ2aDfX3zvYUJupXjFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywleau2N9YNMYeav0ViyBQtdCHXIkoms0uAKimbHO4Cz+qCUpjB
	F6mrixUII5tM0EKPgu9O4Z8bLW62TZl6S7A9GEbexloHxJLtemgz/laWzmTU8bxKETfiuMjeFk9
	0DL6G
X-Gm-Gg: ASbGncvYia+yUu5BeYKBCxocingE3Av2bJSqsv3t7LRZEglb6XYs1fEIl8cljDG++Nl
	NxhyX6fKMBzWZV9FToOx01kGLHKZ07qMpjkiN99fmoDkhNZL6gRc3Z6NJzj278xa6+mLF7dEkz9
	22V+N3nOasHyjxnmi39BL9I5cS20cT4/H0yRM3NfgXJH1UzqQAUaPF5dHjMKEJwWOwmOUZRYNXV
	rBOXlwL5mMWS/zfblO3bvH3eWd6gwf7Vcoq7CWWi91kpxXS+7xE8dJx34WNjPPL56oRxLBxGZcZ
	ThDvYp4aM+JTsIIVk/cPtePZTwPcD6+LWizYtr7xs05/Ds0g75GiHjItdS6tA9mki77hyq27l5e
	SbTZ406xJI+Ha2HoynxaH4/X89UieWAyEVziH1UysPsfRmkQ7OKOzX6A=
X-Google-Smtp-Source: AGHT+IG802Gei6CAzXsOaDNbdW60lD9/nV5nK8bJuNWbFp6TGJvXHnh57A2zHwT6/ty7W1wS6XC4qw==
X-Received: by 2002:a05:6000:428a:b0:42b:3bfc:d5cb with SMTP id ffacd0b85a97d-42cb9a55986mr1634050f8f.51.1763627188022;
        Thu, 20 Nov 2025 00:26:28 -0800 (PST)
Received: from localhost ([151.35.219.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa35c2sm3670859f8f.25.2025.11.20.00.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 00:26:27 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 9/9] iio: imu: st_lsm6dsx: add tap event detection
Date: Thu, 20 Nov 2025 09:26:15 +0100
Message-Id: <20251120082615.3263892-10-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251120082615.3263892-1-flavra@baylibre.com>
References: <20251120082615.3263892-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4455; i=flavra@baylibre.com; h=from:subject; bh=rCueut8oKenLkzP/pdx8S5ZQVc/azzywTOOlHs8t1/A=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpHtB8QOA8X/mB6mZ0YURPf5zlC0oGj0Ne0K+Cg YtUsyRJXr+JAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaR7QfAAKCRDt8TtzzpQ2 Xx1/C/4+y62W1GV5v+dJYV9rWI6c9J4mRTAuH2Qf1wbrvJWk/wn+EDMbfzeErWGUyO8j7Qdk9Nl CvITr106a3DmMvl4OfucJD2bTo3S8v1C4Gz5cDAjs43S3162o8RNLp8LfLLupKvIl37mWCrTIbU 198/ndh6P0IJnGEIjAWaTsIjjaXWSNApSvOpg8e78eLN4os4MXe9SLXEeAroD+T2j2bmufPeo9d 9wHxGP6vj95lfp5Ont8UlYc2HyA8IeaELU/abvGRJB+6GdMwHM+AOcENJAhRH48euoR6iEuPs8R S5KV1eLp9m+UYtd6l+MFWJpi4v6NnmcZzhJSYaEsFmq8YMjdLHVIzPER9IV8Dy/qvuITMgImOuy jXIdgEH4eWzGpJasZHhBLE/ewUnxBE0AHQFXu+lqKcaNdfdoO7cHNcoTNtYuV0k8P53FgNkoJOh A6/lYE9q1ZB05RLSk6R88mPg3bqh3YSdx525CqQNvYOfryRibZ+AA+mxDb3YfQ6hIJ7wk=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

In order to allow sensors to advertise tap event capability and report tap
events, define a new struct iio_event_spec array that includes a tap event
spec, and a new struct iio_chan_spec array that references the new
iio_event_spec array; for the LSM6DSV chip family, use the new
iio_chan_spec array and define an event source for tap events.
Tested on LSMDSV16X.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 55 +++++++++++++++++++-
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 3b90261e6bb1..5d820f2a0bce 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -245,6 +245,7 @@ struct st_lsm6dsx_shub_settings {
 
 enum st_lsm6dsx_event_id {
 	ST_LSM6DSX_EVENT_WAKEUP,
+	ST_LSM6DSX_EVENT_TAP,
 	ST_LSM6DSX_EVENT_MAX
 };
 
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 562544636f36..55cd63643c52 100644
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
@@ -1250,8 +1272,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
@@ -1426,6 +1448,30 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
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
+					.status_reg = 0x46,
+					.status_mask = BIT(5),
+					.status_x_mask = BIT(2),
+					.status_y_mask = BIT(1),
+					.status_z_mask = BIT(0),
+				},
 			},
 		},
 	},
@@ -1939,6 +1985,8 @@ st_lsm6dsx_get_event_id(enum iio_event_type type)
 	switch (type) {
 	case IIO_EV_TYPE_THRESH:
 		return ST_LSM6DSX_EVENT_WAKEUP;
+	case IIO_EV_TYPE_GESTURE:
+		return ST_LSM6DSX_EVENT_TAP;
 	default:
 		return ST_LSM6DSX_EVENT_MAX;
 	}
@@ -2606,6 +2654,9 @@ static bool st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
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


