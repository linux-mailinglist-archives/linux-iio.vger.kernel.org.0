Return-Path: <linux-iio+bounces-26336-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F21C72E77
	for <lists+linux-iio@lfdr.de>; Thu, 20 Nov 2025 09:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 38E5835AE06
	for <lists+linux-iio@lfdr.de>; Thu, 20 Nov 2025 08:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7439327C19;
	Thu, 20 Nov 2025 08:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="abd/Ko/Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD92326D43
	for <linux-iio@vger.kernel.org>; Thu, 20 Nov 2025 08:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763627190; cv=none; b=W//3eRRGxQrtCsapZxp8SAE7itbnBXGtkZqcujdJHkl85m+NligFa84yM6jZyCLBoPjSWUXCHI+Qw2eTjJ82tP+OUqTZOjR/CCjZggdGXH6kT2Nr4/dMMK50A/nS1qbfrJSX0YQ6Fq5MVYyOWEiunVgyHo8H3+HAwnCwb5yfH6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763627190; c=relaxed/simple;
	bh=K/Kx2VbEDfL4oHgE4vCOHbqOhUH6e20qujkg/9y5Ho0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PrOQuAvipPwABFyzFkOZaJ4ia9sLo+7Ox/gnDUzAEdiuNhgs7QwVMu2kTX0xWFWko6bpNrAsqPwHOFr/5dTYNujAz4WeVfPpZo1p/5/V4KA0pwzaqamvunV59zEOvt0pOM/y6A2zC0Z5p8t4slITMC+S75VLsS1LPcV09/tNknc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=abd/Ko/Z; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477a1c28778so6739835e9.3
        for <linux-iio@vger.kernel.org>; Thu, 20 Nov 2025 00:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763627187; x=1764231987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KGqFACH/HkVCJjUX6Ee9GAnpXzUkKAqrFu9bfRLxaHs=;
        b=abd/Ko/ZK+iJKfu1T/zNLT1eIA91srp0x/QmgwvcsS25JyLWLnuZQPtqgg5gZO/+vr
         NkRkM3jlxOrralFT8BULLKYil+FpIBWkAD7aBCA7buPpEOuq0ItyVi+80zbltu/i0XqV
         5bhvFoTpIK1SlomwDcILnLmxWO0IH8uVETk+g24NFPfHUUAUm4JHI6IX3n9dDM20ef57
         ncA36uq50WjB/uQtMrZVLHQMnaQqWHNJMTDkbUVoqGYtrUT6QW2ecr+LWKi8IUuxBY1p
         yFVZRDv56MTpED8/jHDyudC6ZcBZNgI5/n7tW7FsVRtn/PKon4rC4QYShtAvwkJkX8mk
         DrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763627187; x=1764231987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KGqFACH/HkVCJjUX6Ee9GAnpXzUkKAqrFu9bfRLxaHs=;
        b=Jd0dUlHsXGHj1xsZzi3brQFk3V6HCQwUT+wJCP99xEmO1JuJcVt+J15WtTWry+FlEs
         fLfJ5O0g/cPdoFfxCgrxLsuEJNLFKWQlKZ5euq8Nid7S5JpfgUBnYlWixhBTgf/i9iyU
         a92S4b7EiKo2OM3gHv7BVWDYXOA2vYmhf4qi39niVh/HZzVT8xZKG9dhXCKDsYcqPJrf
         wj3wWwoASaxfJ1a7bKH052I7bTFHbKGD5oeBpwbHu3CqbR9tinNqkVrhyxnpAX5yxEC9
         d355HHWkR1PakmUZnz3x4bFs+dArEGx1HWpUomQ0Xrjj5rFwumml/u8aurpfoc3au29h
         NgEg==
X-Forwarded-Encrypted: i=1; AJvYcCXHv7EuVa7pNm7+4esYQ42WXbBNayWSXcF+Yv8Zt/w6keGI+k7P9ZoPX6yx0xPC1atmuCqelkYrDDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1pSVU2Lk7nvFUlkv//e73e33n34J7tvoIzSMLvOQrv4zZ2GnK
	lkJOlBSmDxq8uibOfqY3OIe7HbYqhjB9QzF4TJKh9YUprl+2wIYvW4cVuir2HiyfiaI=
X-Gm-Gg: ASbGncu82jCjvR0LxAl17OsIBKXoun8QeeNOk6l2jOzIJ0CozgqDm+Wz3WcI+Nwp5df
	ksWd3EKMFh9wx+z9lXR2b442cA0MfFF5cW0mTuRGhSmpmcqLpVKC2oALEd15tk66pTKTzvJIijZ
	9ajiJGyB+LGsMvoZ7pdph0dAxjGHzExzs/3SJWiWCXyLO9Kp4vCr+U/FWMfVsUh+Shky/1HpDvD
	tIHDUVx+BG9ia3HyGe5zfZG34nk1kX50BHhHstOTZfSlt5zgeae1BxOyIHr/ZRQTzbkSX6AhFpS
	OWVXOoZwMg6scwRn6tkGociOlidGCE9I86nCu3jcnVXI1mD8v1bAWoDzDqUEZmANmNtx8NPfLVz
	VYoENyU/7ZNxxZlgVSHf5dc4235R+KPPlO+VHxMmn7FurZkNTpLRce64=
X-Google-Smtp-Source: AGHT+IGypkUV/VzoWTzOaqQfFG9GB1sWrnoHEOhRUWD8sKoUwzZ7+2zS/Gxes1QuD0FpTMBaXZHAwQ==
X-Received: by 2002:a05:600c:1550:b0:477:b0b9:3131 with SMTP id 5b1f17b1804b1-477b8951fe9mr19532675e9.8.1763627186741;
        Thu, 20 Nov 2025 00:26:26 -0800 (PST)
Received: from localhost ([151.35.219.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b82cc6c4sm41891105e9.2.2025.11.20.00.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 00:26:26 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/9] iio: imu: st_lsm6dsx: add event spec parameter to iio_chan_spec initializer
Date: Thu, 20 Nov 2025 09:26:14 +0100
Message-Id: <20251120082615.3263892-9-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251120082615.3263892-1-flavra@baylibre.com>
References: <20251120082615.3263892-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3483; i=flavra@baylibre.com; h=from:subject; bh=K/Kx2VbEDfL4oHgE4vCOHbqOhUH6e20qujkg/9y5Ho0=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpHtB7IN101XbBsRr0amGEISqgWrInYK8eYv6eC OFTgE1sBJmJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaR7QewAKCRDt8TtzzpQ2 X70KC/9MBp24o7acI41gAAgjhCHXoQo1UNiW6xBH7/53rquR2RcFT+6bCrXDaF4D2yVabMOzrsY 6Y4haFqOz/vV/IKlf7yD5scsaaFojUQ/h1g6S5Rm37HQPf1A8pNbTltY+PQgWpx2cUqLc+M2YH2 uEyaPHig4tJW9Yd8yCUiAvEWRG25XU6fM4s87Tw7prx+geagfa/cmqvnljuJYnjPEgfaC7+WBqs 5vkWwmXmihXINVhJN++Ruy7O4FMIatbCzaOOFH9Y4i+C9lL/38h9UNjoCOpEwXW9gVluNta87Nx OvvwX+mM9dkkTjNS5fSZoqCjPjn46kDYThoyXy4I7cG3rDONaGj1E43neZFLovpEgr5kW5yToSj e4MJyp5RpuNCljyhDA2hryXss2Ag/qg4DUHqXvEmQ1LBmgcNGTmjVS5Pe0G0rQhhbI1xAMilXbK +jJ2BBqGKLji/aB5DTN5n+rcb/jEEegKxvVxoqDTV9aUkjBNIoUImNPvAuumb/HS/wlBI=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

In preparation for adding support for more event sources, add to the
ST_LSM6DSX_CHANNEL_ACC() iio_chan_spec initializer macro an iio_event_spec
array argument, so that this macro can be used with different arrays by
sensors that support different event sources; change the st_lsm6dsx_event
struct declaration to an array (renamed as st_lsm6dsx_ev_motion) so that it
can be passed to the macro (and opportunistically move it from the header
file where it does not belong to the C file where it is used).
In addition, remove from this macro the channel type parameter and
hard-code IIO_ACCEL in the macro definition, since all callers use
IIO_ACCEL as channel type argument.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      | 15 ++++-----------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 15 ++++++++++++---
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 6f68508e5769..3b90261e6bb1 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -81,9 +81,9 @@ enum st_lsm6dsx_hw_id {
 #define ST_LSM6DSX_SHIFT_VAL(val, mask)	(((val) << __ffs(mask)) & (mask))
 #define st_lsm6dsx_field_get(mask, reg)	((reg & mask) >> __ffs(mask))
 
-#define ST_LSM6DSX_CHANNEL_ACC(chan_type, addr, mod, scan_idx)		\
+#define ST_LSM6DSX_CHANNEL_ACC(addr, mod, scan_idx, events)		\
 {									\
-	.type = chan_type,						\
+	.type = IIO_ACCEL,						\
 	.address = addr,						\
 	.modified = 1,							\
 	.channel2 = mod,						\
@@ -97,9 +97,9 @@ enum st_lsm6dsx_hw_id {
 		.storagebits = 16,					\
 		.endianness = IIO_LE,					\
 	},								\
-	.event_spec = &st_lsm6dsx_event,				\
+	.event_spec = events,						\
+	.num_event_specs = ARRAY_SIZE(events),				\
 	.ext_info = st_lsm6dsx_ext_info,				\
-	.num_event_specs = 1,						\
 }
 
 #define ST_LSM6DSX_CHANNEL(chan_type, addr, mod, scan_idx)		\
@@ -469,13 +469,6 @@ struct st_lsm6dsx_hw {
 	} scan[ST_LSM6DSX_ID_MAX];
 };
 
-static __maybe_unused const struct iio_event_spec st_lsm6dsx_event = {
-	.type = IIO_EV_TYPE_THRESH,
-	.dir = IIO_EV_DIR_EITHER,
-	.mask_separate = BIT(IIO_EV_INFO_VALUE) |
-			 BIT(IIO_EV_INFO_ENABLE)
-};
-
 static __maybe_unused const unsigned long st_lsm6dsx_available_scan_masks[] = {
 	0x7, 0x0,
 };
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index da914a58a875..562544636f36 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -96,10 +96,19 @@
 
 #define ST_LSM6DSX_TS_SENSITIVITY		25000UL /* 25us */
 
+static const struct iio_event_spec st_lsm6dsx_ev_motion[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
 static const struct iio_chan_spec st_lsm6dsx_acc_channels[] = {
-	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x28, IIO_MOD_X, 0),
-	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x2a, IIO_MOD_Y, 1),
-	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x2c, IIO_MOD_Z, 2),
+	ST_LSM6DSX_CHANNEL_ACC(0x28, IIO_MOD_X, 0, st_lsm6dsx_ev_motion),
+	ST_LSM6DSX_CHANNEL_ACC(0x2a, IIO_MOD_Y, 1, st_lsm6dsx_ev_motion),
+	ST_LSM6DSX_CHANNEL_ACC(0x2c, IIO_MOD_Z, 2, st_lsm6dsx_ev_motion),
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
-- 
2.39.5


