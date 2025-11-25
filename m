Return-Path: <linux-iio+bounces-26470-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B20BC87057
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 21:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 566BD4E9AD3
	for <lists+linux-iio@lfdr.de>; Tue, 25 Nov 2025 20:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB7633EB16;
	Tue, 25 Nov 2025 20:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="numLU+sJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4066F33E35A
	for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 20:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764102203; cv=none; b=jJs1kHV5rq1s5jN02PzeE3AeR4XhJRHjOg0N32qeJk1YiZnP7G20NJyeFgD91VW4tALsca5MWRWR6TUr1RGLTwGjWYTFvgv8buBy6HqnpjHjJw3Od39jN99SHb9E7J6KqS8MWjBfOLpkVyGX1kJ13M9uBnRYG2cJBIMBoLvhcJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764102203; c=relaxed/simple;
	bh=+yEIVJzieMNN3BK0oO0ggXwrklmeKk9Pp005zecyGqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XtOP7acd9wYj+AachnzqkGFdYq3jAaQMnf/7LMJaPOu4+IZ7cNXMOOPJ70F0jhfkD3+N2KsqiYbiTx4VBXj0pNr/9WaAFYa8/SbVpb/VyRGg2kx2E0uelt/BU+JMQWc08TwMMkQGgbfc1092LlXWY24PzqjdTBUaYecQohRxzH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=numLU+sJ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b739ef3f739so515636866b.1
        for <linux-iio@vger.kernel.org>; Tue, 25 Nov 2025 12:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764102199; x=1764706999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ct6sb05LrGdG35kWjT5xVBetVUNfjUJeA8bNs4BtvO4=;
        b=numLU+sJ3XQgk9x5PX0xuZ/xRMiJQqwOO2qSyZY8hXXSDOlzXwxdaw106lfJNCpumz
         9wEH7NK+qLnsjCQ6GGmvT1BpOKhWGPed+LI+VViy2b//xkZIbpr9cHji091cooOY5wde
         uZaH09bSmGBuaWoPv6hkVzLmfQNYke3GJ/ey7HB2DmvmAChdCjF1qaIFoAA0T0H1vImR
         wzR2M+rkH6p6P/SW4LvDKkHcOMgUaCcV4mErDnpCOu5EwZqtTu+rlMPV3nIM4r4Z4BRO
         Ed3G+e/oVGJ3mDcKMpRfahYjq3NcJjq3wwv6UnAKJkUxuOBsS9xZj3uGHRRPNVvouggr
         Nu+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764102199; x=1764706999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ct6sb05LrGdG35kWjT5xVBetVUNfjUJeA8bNs4BtvO4=;
        b=RY5q/A9QIhxhTlFo7iZr0mPkYLzPr89Ud4zH59twzq0MxRElWj6a7M4RcKwrOhhjRK
         BaMep9OBq8BACDplQlLvN7pUXXKTub5OCaioT2waxVOFlzi3BJ2USRsFjnGd4OjSGrec
         dFfaAv3Ed/L6bFj1Bkx9ioPHYLW6atuNKQxoP3PANzfZ4zSNLq/WX9IFnr4++BBKEn05
         96fjQxTSaLg6w79CREEiSnueJdRg4QPUguzkUj9iwTxr1Vi8uAWgmh+yX9LBAysn6Mxm
         mtKHdqUrnDiVjSyklsG7ZSdNOMtOv+a/kMDzHUszgTUTIuhasxP6+yfNUlJVBj2d7DjV
         aXZA==
X-Forwarded-Encrypted: i=1; AJvYcCXpQcx/JaIXnydkM1mQXyGU71l4Gdpx5N8h7tqe0+E8wFPFKQer4Z0pv6KvQRwasIZRjUIL4eBuz20=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrx1YCdLVHvhdlTtzAjClLYcf4i303uEGqHUk3e7fMxp7DgQNZ
	Rrv2c6j/VDsQq4Pz2jtWGd4rqu4S0VXPRNyyMjIThRJbMU52BDH8Ri0BhU32ZZReyxQ=
X-Gm-Gg: ASbGncvm96EofRFILvb7s4b2UYf91+/CDMGovYr+CE0OLKAgRQcJjS8oXXVLC1OZRYG
	EFZdIZuvwk3v9jgw9oRaNAshQ5UAUCQVTsQpL+f0lvXsLtVEANb9Vi3Lri0vfsaGtCKzJrFhB04
	VI8uD/GOwjtd8VvlT/j2U8fREpOlPW2VqWvDCj7hrtmq6byLlOmKFmlU701Ii4BT9imeaIWczOz
	5r4NmuFAJXBacH+FgiZZBFI3mQGSwZAoQMi9hKYsnuio5yFs+TcbTQeOW3UsseycVvO2aDIPtzR
	vxAMbcYuw+5Yoj2CIftAWnKB+MJ72Hse5EcoRxCsa/gqnZ8o2LnONhIb1Tlmqnnw1swzM70163H
	ujJd2d25I8yr5TfZgb5D11D/NDN7HOIwOqjOhvNq1ewUX0P7EinxFVJjgeofp5gqarfIFmEJ4O4
	WS8Q==
X-Google-Smtp-Source: AGHT+IEPXN/3aH0SDRPJ34SLeDgj9tjUAdB0XJS44lgwKIBRismZE5PyWIu21QHEMFdvrmwabm/fhg==
X-Received: by 2002:a17:906:478f:b0:b70:b71a:a5ae with SMTP id a640c23a62f3a-b76c5638e3bmr424243666b.44.1764102199500;
        Tue, 25 Nov 2025 12:23:19 -0800 (PST)
Received: from localhost ([151.35.128.119])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654fd51fbsm1624922566b.33.2025.11.25.12.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 12:23:19 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v3 8/9] iio: imu: st_lsm6dsx: add event spec parameter to iio_chan_spec initializer
Date: Tue, 25 Nov 2025 21:23:06 +0100
Message-Id: <20251125202307.4033346-9-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251125202307.4033346-1-flavra@baylibre.com>
References: <20251125202307.4033346-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3543; i=flavra@baylibre.com; h=from:subject; bh=+yEIVJzieMNN3BK0oO0ggXwrklmeKk9Pp005zecyGqI=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpJhAF+du2P16uOu3xIsJexN7PVLLDLYbnFIEPY CTla3v4jaGJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaSYQBQAKCRDt8TtzzpQ2 X4h9C/9Zu6Om1iIpCSOq1OHj+SMuFPohmjhdMYIvxkjlDskgghJKeAIXaqQJefP3uyKzEtEopFJ XP7QtiEY+9mwYgdiamRJ3F9s6BlwQCJtBegkFK34VaXYVVJVeoOaX6HnEwJ1841VWWddfVjDDCH jdbipvZfLsvzEZaP74/mgEnUZHRiI+SArjCvbr/tQiUUxuMc+M4edBWowvuN9UqQ8hDa+mO8HYk r4uQ4VEFS8e08KoONTe+IL2NYYcHkGqJEXqskOKZUYmF3Uu+X6rFcmwyE5fnTEd0LstrKwa0ay2 Htc/oUFX5ZSCY7+nsNOoxNPo4Yxb3P3NkWJ9jwRZASjOzzXR93hfZynKpPv8nam/ccAoo+sK9Nl 3XACkYKpqlVrb5hFYGiMs+l0eBtXBjnI7K4iR69E8cWtxWAZupTS3aZEV8yfD2fHimcLs2GiqL8 cCVo+M0DaaQU4s5kGHqQfaTICEwtGRH55P8azo39a3CuoUmYJcyhj35DcRHbTUQirv6jQ=
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
index 50c00dd38c63..e1eb64a5b10d 100644
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


