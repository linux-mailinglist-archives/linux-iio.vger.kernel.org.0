Return-Path: <linux-iio+bounces-14703-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC77DA21BD6
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 12:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8FF73A1E62
	for <lists+linux-iio@lfdr.de>; Wed, 29 Jan 2025 11:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5293F1DEFFC;
	Wed, 29 Jan 2025 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UvUu/r3T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010341DE3D8
	for <linux-iio@vger.kernel.org>; Wed, 29 Jan 2025 11:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738148722; cv=none; b=XO3yCf5jvIqRCQxn9ptrZPI4csfdKtIKq14k61vTmTVuE3S9kQAPStk10sfGvtbZxfaYZ7qTFyzpZsUxUdsUAef0RSEE1kMtzvgubucTSLiwyT8FkBNdzTPQHtLBZrYBUfcAsHXa8bY54EY22ofbbMO8PYOFwACbBhcv0ieSXR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738148722; c=relaxed/simple;
	bh=YPCClW4zgeQ61rrLflVkDPfGzAFfF6xsFYHv7CQfSZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rfys+nB60WIdduCDsuymCvjKvmeBcKMg92XwDORfjKJsR0fahTVTj1Id6GRd6pU9f0iAzM84+vYc3DAHLehVxwYS1d17ojKdMLzdpd/Y2Ta2cxB3NG7e8xMuw761xIslw+W/xBUNudlxKpgQ8R0q+W2r24iHSTEy/ytUqNTbB0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UvUu/r3T; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3863703258fso345398f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 29 Jan 2025 03:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738148719; x=1738753519; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XLkzkT5XO+iBeguDxTbZiSb8sV8dMk0q4xA/rqr+DXo=;
        b=UvUu/r3TI84tSIMlPxXg+NAa1n4irVgu790eu1XoaaC8Q/nFUwwj0jXE25G7ER0RSg
         LAH7md/ntxH668tzRJmLJ2UzRMpv8kmNhD9cPgfyj3jxId6yzqMf+inyFe71BHjQGxoG
         4DOSHCLIqLrg4aLkLwh0r1YAcjEH/UFi33i5QhND5bBHURvBzUBsJrUPNTcF+t9Nw9pm
         zBml2OtDM7XrcODPWIjQVm0/BFMmRbZVOzEt1tdSRsQEOtCN+c5AfvfyQ1S0/6iA+Slt
         J4C8Rr9QJ9SSkoAWiYE4mlT0G3qdr8K6ho4/ForU0o3MXp+7MMGnKiM197zbiUg2HuDR
         61EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738148719; x=1738753519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XLkzkT5XO+iBeguDxTbZiSb8sV8dMk0q4xA/rqr+DXo=;
        b=VoKheiYtkX/s0/DVPjRYcRmk5sGKb6YrEFoF9TpOa/QHI/iqTRHwiSKX9YQd0P4/Ud
         EXqy0GcLGQcB3JIKKiLTESGFPwWF2U+eS1qk0ukvd3+A4Ilfxg/wrDTVR80lEixk3fq0
         JVg5BnOAmrRbHce87HQNo4tYrvGY2x6s8XW0mEidc4ZD/ge7PgmZKyjWqUa9IioBpYOY
         dCSGIC2b6/ZGjRG++ZnyUvF43h85W5C+u/g9/Des/61Wd1rZvFg1/L+Jr0p8YM8+vX5c
         m/iAC5dLEMKFpNjoVErJ256woiBVS9RkOasU67zwXUg9nl3nXeKUW2ZuhPrhGvEOoyog
         Qkyg==
X-Forwarded-Encrypted: i=1; AJvYcCW5JvSlcHgc1En9l9cYaN8DqYA+zB16VLJ5otVxgFv6XhhQgWiHHs+H749l3Hp37xecr5dLX4d/CuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9+zolFdgMFMm1qiP/xzYSneUtPBd/j/mtQFLmk1us6m5+MYIB
	X6LScUwPQDCFpa61pkKZtkyrwtzY3Ipwml/sevLfKRqO8DucKc0SV12ZWZ6HdTA1bkiCAs+64wN
	X
X-Gm-Gg: ASbGncs5Yy3tRPYL+f2YLsAlC6reBYWEGysk+6ghJMpCKY8SfBU6/vk+tstwxhZXwrc
	lsExjKQT6dLw3tD8NmBQ/9C7MQt/PQ5bQIjD8orK6EvJb5ZUmaHSp3wcd4rJI8F9GQKl9FX3nBw
	iuuNWaziyq3y7Lerfghag70VCPfQJvsxv7jGm5u2a30AG/zgmlSfn7N3HWueTKe6VZFIAURXCXZ
	UWavvKUjn940pRDsGRVYTM/O/w+UaDEkRlHGZpQhfwKEBIW3bJDw6EBGmuVDVK18OMpD6vIR+5X
	esuiqUgfcZrW7oJDshoSpgtsCaekgXW9u5RcW7PjctMZz/A9MLca6A7RgVyUz6Sx5kq04b8=
X-Google-Smtp-Source: AGHT+IG+Y/hClmvuFWBStq6SoVuXgTOfZQ1xjWjuVlZ4Fue0ovn868o3oc9Anwnh1Wp/qOGiOltCvg==
X-Received: by 2002:a05:6000:1f81:b0:38a:a019:30dd with SMTP id ffacd0b85a97d-38c50fe7e90mr2213273f8f.8.1738148719160;
        Wed, 29 Jan 2025 03:05:19 -0800 (PST)
Received: from [127.0.1.1] (host-95-245-235-245.retail.telecomitalia.it. [95.245.235.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a17d7a7sm17107364f8f.32.2025.01.29.03.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 03:05:18 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 29 Jan 2025 12:03:10 +0100
Subject: [PATCH v3 09/10] iio: adc: ad7606: change channel macros
 parameters
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-9-c3aec77c0ab7@baylibre.com>
References: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-0-c3aec77c0ab7@baylibre.com>
In-Reply-To: <20250129-wip-bl-ad7606_add_backend_sw_mode-v3-0-c3aec77c0ab7@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guillaume Stols <gstols@baylibre.com>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Guillaume Stols <gstols@baylibre.com>

Add the possibility to pass the *_available parameters to the main
macro.
This is a preparation to add the new channels for software mode and
hardware mode in iio backend mode more easily.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.h | 51 ++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index eca7ea99e24d..ada8065fba4e 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -40,37 +40,19 @@
 #define AD7606_RANGE_CH_ADDR(ch)	(0x03 + ((ch) >> 1))
 #define AD7606_OS_MODE			0x08
 
-#define AD760X_CHANNEL(num, mask_sep, mask_type, mask_all, bits) {	\
+#define AD760X_CHANNEL(num, mask_sep, mask_type, mask_all,	\
+		mask_sep_avail, mask_all_avail, bits) {		\
 		.type = IIO_VOLTAGE,				\
 		.indexed = 1,					\
 		.channel = num,					\
 		.address = num,					\
 		.info_mask_separate = mask_sep,			\
+		.info_mask_separate_available =			\
+			mask_sep_avail,				\
 		.info_mask_shared_by_type = mask_type,		\
 		.info_mask_shared_by_all = mask_all,		\
-		.scan_index = num,				\
-		.scan_type = {					\
-			.sign = 's',				\
-			.realbits = (bits),			\
-			.storagebits = (bits) > 16 ? 32 : 16,	\
-			.endianness = IIO_CPU,			\
-		},						\
-}
-
-#define AD7606_SW_CHANNEL(num, bits) {				\
-		.type = IIO_VOLTAGE,				\
-		.indexed = 1,					\
-		.channel = num,					\
-		.address = num,					\
-		.info_mask_separate =				\
-			BIT(IIO_CHAN_INFO_RAW) |		\
-			BIT(IIO_CHAN_INFO_SCALE),		\
-		.info_mask_separate_available =			\
-			BIT(IIO_CHAN_INFO_SCALE),		\
-		.info_mask_shared_by_all =			\
-			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
 		.info_mask_shared_by_all_available =		\
-			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+			mask_all_avail,				\
 		.scan_index = num,				\
 		.scan_type = {					\
 			.sign = 's',				\
@@ -80,14 +62,30 @@
 		},						\
 }
 
+#define AD7606_SW_CHANNEL(num, bits)			\
+	AD760X_CHANNEL(num,				\
+		/* mask separate */			\
+		BIT(IIO_CHAN_INFO_RAW) |		\
+		BIT(IIO_CHAN_INFO_SCALE),		\
+		/* mask type */				\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+		/* mask all */				\
+		0,					\
+		/* mask separate available */		\
+		BIT(IIO_CHAN_INFO_SCALE),		\
+		/* mask all available */		\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+		bits)
+
 #define AD7605_CHANNEL(num)				\
 	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),	\
-		BIT(IIO_CHAN_INFO_SCALE), 0, 16)
+		BIT(IIO_CHAN_INFO_SCALE), 0, 0, 0, 16)
 
 #define AD7606_CHANNEL(num, bits)			\
 	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),	\
 		BIT(IIO_CHAN_INFO_SCALE),		\
-		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), bits)
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+		0, 0, bits)
 
 #define AD7616_CHANNEL(num)	AD7606_SW_CHANNEL(num, 16)
 
@@ -95,7 +93,8 @@
 	AD760X_CHANNEL(num, 0,				\
 		BIT(IIO_CHAN_INFO_SCALE),		\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |		\
-		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), 16)
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),  \
+		0, 0, 16)
 
 struct ad7606_state;
 

-- 
2.47.0


