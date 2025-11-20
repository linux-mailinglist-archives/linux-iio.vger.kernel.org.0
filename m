Return-Path: <linux-iio+bounces-26329-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C1FC72E7D
	for <lists+linux-iio@lfdr.de>; Thu, 20 Nov 2025 09:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCA2F4EC905
	for <lists+linux-iio@lfdr.de>; Thu, 20 Nov 2025 08:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6737130CDBC;
	Thu, 20 Nov 2025 08:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TDw2ufj5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA6630C616
	for <linux-iio@vger.kernel.org>; Thu, 20 Nov 2025 08:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763627182; cv=none; b=F0hHvJ3rvryS6yaHeqvdmFd/ICivEs5q1got4drf1Ij1ZPps5vgNIir35zTjCzUtYbuyU8aGpmCoNsgBr0BobS2qi+kb0YoeaGml7B6vapSLlVsQXyONPhmTVdplFANvLaAg23DUkr3A88QDtPmKfppOUxfty6CEv2gHbcIuawM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763627182; c=relaxed/simple;
	bh=NJ9+ni9tjiEFyLqyjknlb8H77fEVqdcPkQvWufgkhRg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=giaIHotUrO2X1Wb2zyxGTE9ZZlllJsF0e0Mkq3lOaigCGjlCLkJ4sRuQ7neFeKUH5MISrrGbfgG1ZFB+cAVTTleBK5jQeFcSEiVVkwiyFvmnDSWHzXg3VHeu5ztH2NRW7lt5p9RMGDsWLoJDrK/OgZm6Y9C8/E+F8z5NhHWEFx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TDw2ufj5; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477a219db05so3714625e9.2
        for <linux-iio@vger.kernel.org>; Thu, 20 Nov 2025 00:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763627178; x=1764231978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tbaQKfxHLaDmuudc50zb/1EfAh1OSh/uCcSH2yo6k94=;
        b=TDw2ufj5js5l87CdVI09BTcyqb/WCwVG/pX9v5f9PN/tsOjEqbZWaMt3iS7MINymri
         ntl105tX5dJT8IfLppojp4uNefgP2CJJVpSfKE3g/AN1xWZPpudeU14lqzkYn5R0s77i
         Xcsekzn2/8iK3+NGtQ6JyZ4xIn6hP4nwkbKzx9gZ61YevAkdfRFnXF/UdlP7snHyb3up
         3eCQpF5kFeuADOMSNJALhBPrzNyY+e7q483bIoyHUndS9gJdajjRkFZgGcM8N6/OTNRM
         cLSV3U3tffCw0uXmM+WrSsQVN0s/zog1z3p0foobPfJxBNKDrjl5fAp7PSJ9FOcAQ2JG
         aJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763627178; x=1764231978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tbaQKfxHLaDmuudc50zb/1EfAh1OSh/uCcSH2yo6k94=;
        b=fp8zY0TnRNvTkBjwHH9AWKuCLnsg3SH5Ljis7IbebsofBmRoHjrZsuR4lAPf4FJlbs
         z3rsYQA/feSHil5YzAFdphY5sI5l6Qs3fVCMB7WKtyKszlzRWBKCDy6CZJw5CWDU0GRh
         EvBCjeDyzwTmSG1O47erT1CmX2wyA+yFOjA360Pv7E2kmjTx7m5OcD1zrQ1lAvJo/9WI
         sO+0EUikb3x2dTBqFRSlQgpsZdauQbWlSxyoO3AL8SoGFRcqMBOV4yp9CR7nE6Hx1TIn
         gJLsXZ8jeR1EeIFg3jWCuHVeuK5MEmXHzFx4DJMO2kwxXrzc5QnTdOlTVQk5sT0BGfEK
         2iog==
X-Forwarded-Encrypted: i=1; AJvYcCXGwvjiWvI3cqpmAMM9SQ+bmAsRKJy9GXRZ1YallNCJVKnplwIJNRK6VWoAnRxfaV4nOQqxobAaOoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZzT7uPWwnD1O9qzOtz2ktrOsI3ORiPBtrAt/572S6De/vRhNn
	+VoBPp2wdTqqbGQiphHMYt2NQbl+AW2av1esSEB9RcMMUomxiCSpwbJXwPcE+iUArs0=
X-Gm-Gg: ASbGnctx61KBpH5lOH4dSRF9a4/5tGR/90K4l5WMdNmwk4yyQPKckA53Q3GOUNhB8Za
	8z/PlS8LOlJ+dgarwaJ6g7AnKDcDkFY3ECkmM+gnfTaC8f8Lfo61GlD4XUJtMGM85Uo1P3q+xY/
	+KXSh2pFmh9DIAKh4cytrYseOaNcUbS+mvRiRYx8P7qLhXhLM4fQa4ul2hqf6tuTD8sgqo+XEjW
	UI9AF7wRpl71xfpGy81kfBh+jMbRjPwbBlPe0u6sbe4d4+jgnEEqSbYg473daFr67cFJd2CtKZt
	QQwyKaPKp1/Gm40Tp/81NhpB1KDbA9bwDXb3ref8fiItGPY5Kbuas45B/Lo1eJ0VuGLvfX2HVn3
	s4vjdhAXSxvRZ1dHmFPzWRNl9FZoA8DdU5n0RpO6S7heO8/57pbIMN5c=
X-Google-Smtp-Source: AGHT+IFYCfLo55w9X/Ry2+e45PLt6auk6ctX1o6IT5ZsjL0OQ6wgMf8aLPBxQuXgVokm2RvvZDFL6g==
X-Received: by 2002:a05:600c:1c14:b0:477:8b2e:aa7d with SMTP id 5b1f17b1804b1-477b8aa0ed3mr27973975e9.30.1763627178328;
        Thu, 20 Nov 2025 00:26:18 -0800 (PST)
Received: from localhost ([151.35.219.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f34fddsm4206625f8f.14.2025.11.20.00.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 00:26:18 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/9] iio: imu: st_lsm6dsx: fix iio_chan_spec for sensors without event detection
Date: Thu, 20 Nov 2025 09:26:07 +0100
Message-Id: <20251120082615.3263892-2-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251120082615.3263892-1-flavra@baylibre.com>
References: <20251120082615.3263892-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2506; i=flavra@baylibre.com; h=from:subject; bh=NJ9+ni9tjiEFyLqyjknlb8H77fEVqdcPkQvWufgkhRg=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpHtB4X4JCEU27Jb2F/dd3AOO4o39IAMFbxS5DF 0Lku7/jV4yJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaR7QeAAKCRDt8TtzzpQ2 X0ekC/9Ji/sg23f3L/hsVRFo/MHNBkNygKuQmy/IZTpew2oOwonCw/s6HsycI0RPkILwIw8/J2Y m8NzUSmQp2XbiALOGhY+syijYf1vQs4sebrd8rvnH7TIu2DnhlCqckJMfacpT2DjO7F8xDxgqkP s8+s9E3ZQ+SXroJoUx94pCZzgvHf5arBCMdHl/H5jCBrri2cuBAKphzuT2c4D+85vdrOS4ffozW U8roOHaIWEHAQLXT7KM+AQM9O6UAN/Rp8LdUFIPOZYY9RDuSDL20Jjw9wYGIrtDTcU4siXgfT33 III8zXEUt8uvioTngS+WXsPuWB6654zTOf/2kGaDBtBBjignpwZrUnteNsUIASsZUEUDAl8nWv2 93iWyMOo8RqUa/R2qQJOlDnF8kkV3/QFqkH1fMDO6xzyOPwb8l647IIpIUQ+KKHbIL/tx8Q+qr5 uM/Akox5o6Ye8McCYPkgxCpcFUoM7+b1f2dJABb9h7/sNX5I862mMfEtyXR5L1lodDexM=
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


