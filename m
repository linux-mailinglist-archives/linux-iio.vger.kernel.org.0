Return-Path: <linux-iio+bounces-26589-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90045C968C6
	for <lists+linux-iio@lfdr.de>; Mon, 01 Dec 2025 11:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6D4B3345CD7
	for <lists+linux-iio@lfdr.de>; Mon,  1 Dec 2025 10:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF8D3054EF;
	Mon,  1 Dec 2025 10:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CmADOCWG"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A203305063
	for <linux-iio@vger.kernel.org>; Mon,  1 Dec 2025 10:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764583250; cv=none; b=dctjrIQVW620TRLroS9cqeGJvkvXEh7a7s349o6a5qm8+1l4H1jiwDCxK+y82WuZMk0Oj7y/WepbaAtucABh1H0GVnA+QdX/IYSmUZZ6Oou+ullOjz4qxIzi1JW5sCiPXB1+Jy8KjI0L6U5GhgIfevt+gaesLXnWZRxMRyM7dQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764583250; c=relaxed/simple;
	bh=VEXbt4kdhx6arib++1D6zpeorO/guWg9frDU5YFOf1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b9ThcLdqfRg+Abhr+6DhJ/InbCqnj5tFhZPr0r+see7DSNTTMbJypkVy4y8g8Dhs6vkjbekn22I/BIT9EgWr66zegZ0vAvMZ3IQB8PoBMnM9EEP3q9GzERtS1grFF+gIEi/xdTpfAyHwUaNcS1gsiQn+APJe6FMSCxSRkhyVGEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CmADOCWG; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6406f3dcc66so6937164a12.3
        for <linux-iio@vger.kernel.org>; Mon, 01 Dec 2025 02:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764583247; x=1765188047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3o4iWlWyVTGQhQpE/OiZWMQgLCIUVL9MlPwLkSEzHMw=;
        b=CmADOCWGc30UY+zSocwitrtIBKz5CPIkG4VgQB7c4xVrHgOiZeA4wgAUl2SjHr/UG5
         vWq7DiFKxu3z6JVIqqYHQEEeqSMaEv2MK6DZFy4Ft7JPXmTRBFsJ/onweWwaG419YK9T
         3IFr8Nf8RixKt9qycsZJo12bYAvbbqFmuBc3nmsFVwLF8OsuV9Cyp4u/Zsr/l57BCIq/
         apS0ue1h2fIZNurNohQuFLOkszh3+6WNFvMUQHzQ/6eTkCUGEZCSiQFLJbzzbA/i6Hba
         rQ8g9Hwi1ifjJo9CtSTCE/YtEiwFJDjQkhk2TfDXg0cmbJResGqdUrAQnBPvMAF5TlEt
         UZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764583247; x=1765188047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3o4iWlWyVTGQhQpE/OiZWMQgLCIUVL9MlPwLkSEzHMw=;
        b=va2jbweOV2rFyEP/S5PXMY9GWGT84o/AgaSAOVhnIP2IUbg63tQGEixiRMFm2GeVOM
         TgUEWtL33c/jifiWQF8alsq8mIiv0mxsRQbUF43AHTGLifiegt2usMwXlcmDWdNFP9fN
         I2Ukl47lfXsfRK1LJh8w9b7jW5vtN2EzxALXWizilH8C6S9W/9FnIXLR6teyg/8IrB5R
         5Qb58mN5ZVfdbsRpkuDAoNQKjL/Dt9rMyDadI86INX4X6SR01RzAEzC22lsaxcwBLYWs
         U5qvyNF/Iy2GXXOyFX+Y5CXJWmvd20YoKaWvxx1vOdNBZQ0kH2mZawVy/8idH1uALcLo
         UufA==
X-Forwarded-Encrypted: i=1; AJvYcCWBYMnEbJsVeWUgTpqMkJIC1uILXl9O3oaWCKosvrrIHdi02DY0yYbGpSa00ATfTQWpiYeKWjJRPws=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHv4nMRVJNwiOWHC5h5k5eUpj6PyeWRYkPfl4e72eq3mdyak7e
	eVW8zs0wtChcBTv9YGIuYww05QVO0BUpFp5yejvQVh53WID7fjmpbjew18RJkL32vAw=
X-Gm-Gg: ASbGncuJvW+BjEUR6nCXYVIE+fLW5JgS1wUJ/xxsAc/59ecHFfNnJaTtAXr7NadzTad
	x4J+mXmy/frJwibIErcDKxkGrlNiYTSVx3wT37Vhp/9H/Iqu6JRPlJXpxfuTbJuDncT0YB/deu1
	hb/XUHbEekprIipjra8Dc9F9/ALZH6/uQ2LP4n5NYJgrSOu3VtRBrE2aXq4sy3fE4EYw5GxfSw1
	XEm06vJjOvYKc4Fq0uf0UUYUN+Rcrm1WcBH2t6AZXPOjOurFmB9ZYkmKBhEcuu2v0xXsaSBz+In
	pb5DEUkTKYwXS8+R9JWgmbf3XaUsCAt0ZI7DKDsfex3iRK6PFxgkYlINHoOiiHfraEYfUAV8+RZ
	d+2nvN4HpP8gDEsiVhTpD3J/Qf3cJdRSNzdgIH9mJo1G7hIn35yLlkUsH
X-Google-Smtp-Source: AGHT+IG5bqA8WyY3qXmWxHHH/Fj5+Ec1QuNajs2fTVSz8eFnD2YVBj4e0cBEppD2V+qHnrP70iS4qA==
X-Received: by 2002:a17:906:fd8e:b0:b4a:d0cf:873f with SMTP id a640c23a62f3a-b76715159demr3862578166b.2.1764583246638;
        Mon, 01 Dec 2025 02:00:46 -0800 (PST)
Received: from localhost ([151.35.151.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f59a6a5csm1192638866b.41.2025.12.01.02.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 02:00:46 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v4 8/9] iio: imu: st_lsm6dsx: add event spec parameter to iio_chan_spec initializer
Date: Mon,  1 Dec 2025 11:00:17 +0100
Message-Id: <20251201100018.426749-9-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251201100018.426749-1-flavra@baylibre.com>
References: <20251201100018.426749-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3543; i=flavra@baylibre.com; h=from:subject; bh=VEXbt4kdhx6arib++1D6zpeorO/guWg9frDU5YFOf1g=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpLWb6w3EoMg4eoH1X/EuzPkJ4w8Cz7ovsBXGSb DdmD9omWjiJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaS1m+gAKCRDt8TtzzpQ2 XyPgC/9uka8VLFWqjeMm3+Zvky4dQHOu6ujgDzdW4ElKbN52L0248PexMTopgj/IBkzLTMkaVxD BN/Yog2ZWN3QftH1y7x7WngDidyW0Cd+LT1itd3JeZ4RDl51ah8ax7rXdWEd8fN9VahFVbRcESg OYE55RHjZMdmHc2YaJvJnrwURqvTbYEdAJ6MZ2Lcr2nPxqA2LVNLEI1AbaDLigCv9tKm/QR+1qH 2rb9mqcC9HQ9MVu/6zcH6/GkYAzmamvzaxwc5LvESVIF7fKFk3CEWX3K+m9WTdjytdUVk+xugkN y7LFdegzGNd21BLhUo6D7d70Zx5iLZgDupDlYb9JCSO1SEPkCuUwfGxtztuYkhx0X120+xMdQBa cpgeV9Iaq+M75PgDk1xeB/H6y8V87t3/HgS3itIhjTAzzJowpRazmOfGqCju2qtDBmPx6phB9/j yv/Pti+E4FyXTmY+1PI5xGsVpDiSrogG0hs01VGOUy5hjmLyt9wPpHtjUd6bkO6WLKZ/Q=
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      | 15 ++++-----------
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 15 ++++++++++++---
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 515aadbee3a4..3edff8456a8f 100644
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
@@ -468,13 +468,6 @@ struct st_lsm6dsx_hw {
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
index e6c769049981..04a3c65d4546 100644
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


