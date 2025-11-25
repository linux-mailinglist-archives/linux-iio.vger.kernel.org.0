Return-Path: <linux-iio+bounces-26463-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CC5C87030
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 21:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ED213AF592
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 20:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A57833B6F8;
	Tue, 25 Nov 2025 20:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MgiM+INT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106382FB0B9
	for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 20:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764102194; cv=none; b=JalwN/fbQ/ms2LWbSaPWM/lZ29damPm15KAzyCP/2gk3HMoJgDvj1VlQIZcPgplG6j59DrS53Y9M/aC7UAKKuK+Acm6jsN4JiosGQn2JOfyh/7+Jc0sn499bfPmh5KJwjYaUhkWqwzsIqaxCTtfA+FnsmJUamYGbYQAdvovGWdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764102194; c=relaxed/simple;
	bh=Xb/mqp4+YwITWlbn8v8dEwFHqYPu9zYkndT2tCfzi90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NsiLrshI58luqMXbklEFq5WyF88Qok076YyF9hMVx/nOSxikKXTPj6L+D75zhspkr4V1LyX00nd0gfRhAbQabHG7PVMGsYYqLp/Gk6zglmVXLyvQ2T9eShx9Xx94ozv6G1OxAwghfkbEib8AEyWhJZi22EOpqcCj8S9fUm5skME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MgiM+INT; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b737c6c13e1so534134666b.3
        for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 12:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764102190; x=1764706990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ib0drqFrjnDrbAYTSSfxv4es9CvzBMVOslQd6EXaRk=;
        b=MgiM+INTWMEjj5TL/Y6K42VIPQ35oJPQNO8uOTrmiWCitqdiSbhLZFdB7PBoU/qCd6
         mEZq4flDo8PfbdvCNvKVehtSOnJVlrb+UrGmhHsuL8KBANNwabegvfc2BWWV+f5cz0Vh
         rzPkuJ7kdAwKH/+ouJzJTf82TieEDZqJmIJSDJwDGW8BA+s7wTsVUg47jhpmogsSFaUF
         MP+p/9hXOevJd11fLiWW7+IiWBPFLwSN0L2Hh4X1W/4ajx19wpBegOKdRR5FMtBiXeMp
         d3eX/EyooK8lVhOLdjo++k33CeCYdGoni152nb1FGX+XXbaZQvT+RtAFsHeA8IQWRxT8
         +CzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764102190; x=1764706990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Ib0drqFrjnDrbAYTSSfxv4es9CvzBMVOslQd6EXaRk=;
        b=q2nK0UH3aZ10K2N7+0GvQHziPCW524r1REYN/x0oCa+pO7d52OMm59NnN/Exxrsnt6
         iUEEIuGYhwAP2FZ5atnIg6G97WuQbZg+j2rZof1I3H3wFnCI2oJoXNjBXTviamcN1lAL
         pbZNavoTzHqE5wqJ6Y/3fAMnd4YJ9agJxfykKzCPGdp0doW8Kt6gTlDrXAX921gTPNNq
         C3hqKp3/V89nXTXP3xLrmp/C24yscqBLqldkSWUTI8PlTyw2R71ryVZY9dwdYL1HLivS
         9LhA0nIoxhwnHMHUilpGixvISD/PgEKh73pWpt/vBz+pTXQK6QGUtluPC8JktJj9VKWv
         G4WA==
X-Forwarded-Encrypted: i=1; AJvYcCVd9xSAtqxN2pN5E3eHQoLDlchtjINhiU4QEh5pGCmyfTMhhy/ocv6vZM5Y6r4TN+JyBArznhwVOys=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFUfbyf3c80lQoOZrykq9qx0ffkZUYfFF2s4La2QNDYFZZ4wDe
	a9+Xb2bRbMsTJQ/c+2rx4Z21DdjB6lJL2Jyx1NwoXjBcqaKX0Dsmb50Y36/htT0O3WM=
X-Gm-Gg: ASbGncuMck3gLAN6Djgd9O8SoX4tSk8Vpla07J1yrly/FK/YFZoiHzEphx/4Ux2x7pS
	2wy1bPnkhbm2c36axy801kW8UeMArOq4oP/BMBZFHFa/3GEk2AtULONtsin3Ck0YyOuJQTU1A2z
	ExCrPYIwNVyHx3TJwGi5yl67WZhMPQbBndVQt/LLprkL2RVEcsCdXXFCs9ECxHQ461ZQjV9ghGq
	x4rxKr4AHzfv1rxzD6DIlrgNbW9D6sEb2cTJe9rimQd0YrUo7P+VQx+18gM2b9A2+8DuNETYvGl
	4SLqfC0XI86onuQs4aqktPPZT1MjA/khxza3yLWR9ypnlb8gIeXbhD1XGBsI3h+Ad34RJKKs3OS
	hOMqa1YZBOjfjwTu0UTxoTh1PVw9tIjc80Z8XVumkvp8qxr9HXLNqS5IzRcLU6DUnyEkxYUslpc
	YIfA==
X-Google-Smtp-Source: AGHT+IGmtQaLA/Uc4OF4O4nDM/5+lEJ34paMjp1QNcJa/UK+uZ+msJKQDzBQKODh/ewuat38K/Z4PA==
X-Received: by 2002:a17:907:744:b0:b73:b0eb:16f5 with SMTP id a640c23a62f3a-b76c55f4037mr512604466b.31.1764102190146;
        Tue, 25 Nov 2025 12:23:10 -0800 (PST)
Received: from localhost ([151.35.128.119])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b765c1379ddsm1583680466b.0.2025.11.25.12.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 12:23:09 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v3 1/9] iio: imu: st_lsm6dsx: fix iio_chan_spec for sensors without event detection
Date: Tue, 25 Nov 2025 21:22:59 +0100
Message-Id: <20251125202307.4033346-2-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251125202307.4033346-1-flavra@baylibre.com>
References: <20251125202307.4033346-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2615; i=flavra@baylibre.com; h=from:subject; bh=Xb/mqp4+YwITWlbn8v8dEwFHqYPu9zYkndT2tCfzi90=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpJhACb7PSvMCE4FL2AoX2G7rJWV6MWZPzu6uCj zuR4kzIvpiJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaSYQAgAKCRDt8TtzzpQ2 X032C/4nr+nfvc3LvitKlpUfYNuGChz6j9VHNrts/2ML7zBvEZbr2bf+mgUJM3NRJu439PRLxm5 TR6jyO8W809+M8QORepMjECfKhVAprfkRUa+QZMkn6gvyyQ3f70Rn8tN5LXFpV3WdSyUcxU4U3I o4UOGkdA9nYRGB5x0f8iX5X9T4FHGf2UUv8XVX0v84kty3LtqPoQM78oOa0edMM8SuKXlCvQ9ao YTHri8qWoNV/ov2hlMJgrsxjDKTJ4cYg5r0/A8RfUqlzxoa+eQcl9X3QBlK+668855qRRDsAzRe dXQQ8znDKyjcdre090FAc5JyWl70bl9GfM57zYpsLIYyt+F+gsEsLqi3fcQlu2vfdJx+ZTFVg3T d6SqVFXiBEaGenHn2fSIJL5rIqXRu99+dQUWif+SJkveP3Ra9dCu/M7URSfghJ0LlXSQ0H6qSz7 QEB5QJvpvef5o6QBwHWcWUkm/vQaYHT8nAxsIJ7fJYfMWYKXexBY2yy2bviRt/1i78aq0=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The st_lsm6dsx_acc_channels array of struct iio_chan_spec has a non-NULL
event_spec field, indicating support for IIO events. However, event
detection is not supported for all sensors, and if userspace tries to
configure accelerometer wakeup events on a sensor device that does not
support them (e.g. LSM6DS0), st_lsm6dsx_write_event() dereferences a NULL
pointer when trying to write to the wakeup register.
Define an additional struct iio_chan_spec array whose members have a NULL
event_spec field, and use this array instead of st_lsm6dsx_acc_channels for
sensors without event detection capability.

Fixes: b5969abfa8b8 ("iio: imu: st_lsm6dsx: add motion events")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 216160549b5a..a09df9d772dd 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -103,6 +103,13 @@ static const struct iio_chan_spec st_lsm6dsx_acc_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
+static const struct iio_chan_spec st_lsm6ds0_acc_channels[] = {
+	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x28, IIO_MOD_X, 0),
+	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x2a, IIO_MOD_Y, 1),
+	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x2c, IIO_MOD_Z, 2),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
 static const struct iio_chan_spec st_lsm6dsx_gyro_channels[] = {
 	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x22, IIO_MOD_X, 0),
 	ST_LSM6DSX_CHANNEL(IIO_ANGL_VEL, 0x24, IIO_MOD_Y, 1),
@@ -144,8 +151,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 		},
 		.channels = {
 			[ST_LSM6DSX_ID_ACC] = {
-				.chan = st_lsm6dsx_acc_channels,
-				.len = ARRAY_SIZE(st_lsm6dsx_acc_channels),
+				.chan = st_lsm6ds0_acc_channels,
+				.len = ARRAY_SIZE(st_lsm6ds0_acc_channels),
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
 				.chan = st_lsm6ds0_gyro_channels,
@@ -1445,8 +1452,8 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 		},
 		.channels = {
 			[ST_LSM6DSX_ID_ACC] = {
-				.chan = st_lsm6dsx_acc_channels,
-				.len = ARRAY_SIZE(st_lsm6dsx_acc_channels),
+				.chan = st_lsm6ds0_acc_channels,
+				.len = ARRAY_SIZE(st_lsm6ds0_acc_channels),
 			},
 			[ST_LSM6DSX_ID_GYRO] = {
 				.chan = st_lsm6dsx_gyro_channels,
-- 
2.39.5


