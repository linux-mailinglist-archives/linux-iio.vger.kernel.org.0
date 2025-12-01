Return-Path: <linux-iio+bounces-26582-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B59C8C9686D
	for <lists+linux-iio@lfdr.de>; Mon, 01 Dec 2025 11:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4AE43A1E1B
	for <lists+linux-iio@lfdr.de>; Mon,  1 Dec 2025 10:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AE8302747;
	Mon,  1 Dec 2025 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Gh7UyBSZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1654C302161
	for <linux-iio@vger.kernel.org>; Mon,  1 Dec 2025 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764583230; cv=none; b=U2viFjOydMJDUDzNcrJKqov9WL38QUEXy8p0YkWg1Gul4wb0+sKmoNMAzudjEPSmx603GET5jwmTo27qZA7DxU9tK8QVrOw6Ny3ydPbMpKu7t8mkpC3VzZSma5XSSnms3jEUS4IGo+VMKT1o4rTdtkFy+0ntA55t67S1uPU3ggs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764583230; c=relaxed/simple;
	bh=Xb/mqp4+YwITWlbn8v8dEwFHqYPu9zYkndT2tCfzi90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UABvXgwHEOATSTwWs3P6MCgwgSTiZKCRjL4y5U4iPfJOcPolYKwpvmOBEKYks3l8GhD9Oqat1Cp7P4UB7v3rx4h5ZjWrCzhgok8ORTTPd267dpM58L8fgToWT1XwOmtED4f9LOLRz7PnJGstEYDbEvX0yiSN8vFDiyaFbXIBSfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Gh7UyBSZ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b73161849e1so952117866b.2
        for <linux-iio@vger.kernel.org>; Mon, 01 Dec 2025 02:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764583226; x=1765188026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ib0drqFrjnDrbAYTSSfxv4es9CvzBMVOslQd6EXaRk=;
        b=Gh7UyBSZ4vBRUQl6KzVy4tlg0NQElm49hDqToU0Rw8SXU0b7yDeQzFmMyTHhLo04Pz
         oS3s89/DRRwaI7QhmRJsQE/PFNhvRUtowN1pQNCMm9NRJrrvedq/fulUgHBiu4czso92
         3g4by10vvRltJTXnJbPwTk3/9TjVHzrtxzsq6R+Ltg2dkSiA9nxOTmD+Ck4LLTUgWLr0
         UBROpO7L0QCbPqbnsmKQzVYWDrb6iRqDRG9LR1HF6BJjlawgwyiV9IXN9/M95/JxEYdH
         ba8AWJ1yGrsLc3xCWAfjF70z/GgZbBqn42N4nvkCmfkKDxQvbjC89b+geXKjMKyueQgX
         OOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764583226; x=1765188026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8Ib0drqFrjnDrbAYTSSfxv4es9CvzBMVOslQd6EXaRk=;
        b=gt5JvWLOLb6lCQMI+MVQj5a2Ex1S5PT9fYkquRHOLqHW394wgOzA7V/NodeXKuS2EC
         snASBsF2kaaNfAdSeRfSc1EYG7CDx6B4YmMUeBGBSSD3apPOmAKBXMbVSR1TTH993dy6
         //CAC09dvbw6XJrdgB5VLT4ztgtPJtmC7xipw7ympYKF7WCFckzSKc5ao50totwelOxh
         AehxbItgwl6XPEnDtZq2G4RhBZGUEp8fO+7lAisqgkr5qNO9oiqH6sY7+lZLatS3nZsn
         IRgU/y/6DlDjJFEXx4iymQ2CpaMy6CS1AauqZBYgUCDn1PcT2H4ivzfMaGKcfna4J312
         uOog==
X-Forwarded-Encrypted: i=1; AJvYcCXZMz4D/P9MdPXvRZ7PYZV5zeVDBIyWuhIXRgUh6csEPJbcofrRYG4zwZlwVkhwmNper9mLU9D8a9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiYQ7QjizoLb2HOcvW32ayyWktByFYHkfySGPjmCNWzX6rC/f4
	yyqWc5JJRCOui/YMNnHIbvYk9SbtaxlTrMJE+W60fOJ+GG2yYUmNx1VLxl7bhNrFCoo=
X-Gm-Gg: ASbGncsMuBMSserXXWqSJ1jbY4d9ry1HIR/0CRJ5ldwp3+PXiCxuWiP0vuBpBoxxMFI
	wg2OGJGWP9wIfsuNdAa9GnRGSG2nD9BwPvUECQRU3bxoHJvh74wuxZksSqstkSbpUf+PF1JlFmd
	d/LCXHlsos0EoZLjeVyP/QPfJqJjnhJXbdiN/XNfz+kblmL63OEo9CvkR2BVr36E39Z0srXxN+R
	AV6SJszPgXMxyAVnf1uYUmNnyJTNR9Vf7LS48FrKuYuzjLN4SSkJtJh7FD3aAwA1DpKrk1vT4bU
	kjyf3fHfz0E569friszKXdivJxFyyF7JjSdVp1zwZmnxKWzCSpFkSjqHjgmZKf4Ekz/NxRY4p4c
	2BWs++EQz/S5AKTavAL5vQBjSRzN5FuXyu862zqBOPtPnvGcy4jUiYwDg6gYBxxWpTec=
X-Google-Smtp-Source: AGHT+IHC478PO3CBUR5BJC5WOGgav4Icn/Pzk7/d7NpV1ZUnrHGzUJIvyLPUE9PiVEdjfFEhOsXrTA==
X-Received: by 2002:a17:907:3e1a:b0:b73:8b7f:8c48 with SMTP id a640c23a62f3a-b76716955b4mr3856310966b.37.1764583226234;
        Mon, 01 Dec 2025 02:00:26 -0800 (PST)
Received: from localhost ([151.35.151.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f59a63dfsm1143505566b.37.2025.12.01.02.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 02:00:25 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v4 1/9] iio: imu: st_lsm6dsx: fix iio_chan_spec for sensors without event detection
Date: Mon,  1 Dec 2025 11:00:10 +0100
Message-Id: <20251201100018.426749-2-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251201100018.426749-1-flavra@baylibre.com>
References: <20251201100018.426749-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2615; i=flavra@baylibre.com; h=from:subject; bh=Xb/mqp4+YwITWlbn8v8dEwFHqYPu9zYkndT2tCfzi90=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpLWb3b7PSvMCE4FL2AoX2G7rJWV6MWZPzu6uCj zuR4kzIvpiJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaS1m9wAKCRDt8TtzzpQ2 X6tGDACcRTAVsUnFhiTu4Fo7AEW9fUiqYY8H1hpQUXLtQq+tYt9Y//j7NarFeqPN31hJXx06fkr OQDGV6jXDsMz0GzaJBkn/Jx70XLEFQwdyY3+fQFTXSyWlGi0wrqWnrvSi0ueSzW6DSLwAQffPJk WVnGE4A4FMdZWuflwuh0gzp6PXrMfNj8qrrMEuSzqp1jN8heS0YLORGUKAhRVKVQezOn6L+ezm4 nT0PWB8Yz2lqV6YfLa/BA4AIMhxdMEBjxtB1tq4Y3Hj53QuhLQrvp2te2Ird0nRQyRGvOh0tsp2 kaj+sQPcfCdZGWerIK2phhh4n4i5lKUxCxxYZkFXLCCOklHDf+Qbr7TVP/FwwEHYBhSNCvdKkLS TNH8A2ffJ/zZTsfYMq9lNtfD09eLZWunc6YbHByEHJmQhSQN0u8zOh9qRiNLz0efLPYYaToD2a8 X8SI/2Xa7dyo55fmd9hPUmdoAtqlgjYNL1dEauh6K8E7+sCwQ+JW08Bu11sIMJjZaTOIQ=
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


