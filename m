Return-Path: <linux-iio+bounces-9649-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D50E497C9A4
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2024 15:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0611E1C221EF
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2024 13:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C62719EED0;
	Thu, 19 Sep 2024 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zl3e7YU0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E5619DF83
	for <linux-iio@vger.kernel.org>; Thu, 19 Sep 2024 13:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726751096; cv=none; b=EltMmef+6N6nLaAB1RQxFRDvBeKN7zxMqxwm0nVAxmRjjVh5vJjrENodwGrTI0n7XKw2thEppuhPQKmByaugo5s+itr4LGDJDSQBz0XniV+9lhZFWn28bUoffN477+ROHvQnee3rIeSpotBeHKm4NaWvHvEbMy1J7v9topCdb/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726751096; c=relaxed/simple;
	bh=7jeDEErQ+xBSjvZ9RT/TEcexKXO8icQCIcZ4pRA2dbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKK6turv3TuCXINkoMJL6oe+JZyk+n7LUQExm7MtZEzcDNhdFOLE30peaqk1cAtwdocwnPt99uwl+xfhHagIuqYK8rKCH9AlBxIcl13C2jD84wy4w9HVwEcFXWtJcgy0V1Lz3bj1FST3dXrKk89anS3sRKsMzhL1IbqIuaUwfcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zl3e7YU0; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8d56155f51so93095866b.2
        for <linux-iio@vger.kernel.org>; Thu, 19 Sep 2024 06:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726751092; x=1727355892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWLUgthTvXLTW08JjjEElu7+ziFuVs/iQEkeWDpV0KA=;
        b=zl3e7YU06WEnpw8Y3BJFPbrmv1quavUpaUZ2n/55b0JrzWa1hC5OvBSJU/CXvkYrUp
         Ty0kWWSyJKmwc4FpUvxOYTsLHN/lgSTD3pFqBHYsBa0H51a+gnq6kTLA4TYaALXc64I7
         mH3qooRALkIze9uqF4uef+qzMXLbWPmRfxrNb5VEQgEhXazxy2gKv65fI6GMQyALeWA+
         zFJqOjznsGZi5RAerC2ICSCdDg8f3q510mesBXz+IHTl1iYrX/wuRyvYg3igXb4vyyOL
         QWLvfY8S0yjaNHKj77+BAC3D+380W8VSuB8Liy4J9xtnY+zA4HiGXIoaWFohJOP/Ovra
         0rgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726751092; x=1727355892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWLUgthTvXLTW08JjjEElu7+ziFuVs/iQEkeWDpV0KA=;
        b=q/DNIFflBGkp7Oca4MmATVgv0s9iLpQhXjXuKK8q5AP+hYLV0bq26G7i4z79OgA8Yj
         na5cR8+T5IBrtrxcoAapINnHydI0hpxjt3eJW3qdoPDHbaATn4PvDAwfj4ZO8cfPIO4u
         n6lY+KYqZOgbu1+mH1JrMyNvYk9jae3zCqfuBr0G+Mp5Tzv4kCdYlvoPzlCfFkP5GwJC
         r1tliVHZSVFKSOk1V38jT7GJDKe4+9OW9B1CRV+W+Ajpv6zPijYsKGMb5FOnnMALUIqF
         HK3uDva0qSqPyXCGV3bLCBeaGRvrLHXJOi7fVNVgP6N9Yvn8tuFMvG8PyX7PkXVbEi/7
         uU7w==
X-Gm-Message-State: AOJu0YzhcN1IRykAD+rcJbM7615zZYhABdS2dp3dmMJExgJOErIiiSXu
	8LYlUgOFNntDqgMZMMGo7H7E4DEeNumTVHOcunvcomgCI96KwcAjrhI+uJqq8sUZXnBgYS7nxqJ
	I27c=
X-Google-Smtp-Source: AGHT+IFCzw8baFkNf0BgCzVZQgQ3gbw6b+bcEnMmiDQX9iGDzFn09M+1ygpCg5C6XyrB59wxuSzCTw==
X-Received: by 2002:a17:906:794b:b0:a86:a4b1:d2b8 with SMTP id a640c23a62f3a-a90293b1860mr2515563166b.4.1726751090966;
        Thu, 19 Sep 2024 06:04:50 -0700 (PDT)
Received: from localhost.localdomain ([188.27.132.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90cbc7122esm53213166b.124.2024.09.19.06.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 06:04:50 -0700 (PDT)
From: Alexandru Ardelean <aardelean@baylibre.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	michael.hennerich@analog.com,
	gstols@baylibre.com,
	dlechner@baylibre.com,
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH v7 1/8] iio: adc: ad7606: add 'bits' parameter to channels macros
Date: Thu, 19 Sep 2024 16:04:36 +0300
Message-ID: <20240919130444.2100447-2-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919130444.2100447-1-aardelean@baylibre.com>
References: <20240919130444.2100447-1-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some newer additions to the AD7606 family, which support 18 bit
precision. Up until now, all chips were 16 bit.

This change adds a 'bits' parameter to the AD760X_CHANNEL macro and renames
'ad7606_channels' -> 'ad7606_channels_16bit' for the current devices.

The AD7606_SW_CHANNEL() macro is also introduced, as a short-hand for IIO
channels in SW mode.

Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 drivers/iio/adc/ad7606.c     | 58 ++++++++++++++++++------------------
 drivers/iio/adc/ad7606.h     | 18 ++++++-----
 drivers/iio/adc/ad7606_spi.c | 16 +++++-----
 3 files changed, 47 insertions(+), 45 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 9b457472d49c..8ebfe8abc3f4 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -309,16 +309,16 @@ static const struct iio_chan_spec ad7605_channels[] = {
 	AD7605_CHANNEL(3),
 };
 
-static const struct iio_chan_spec ad7606_channels[] = {
+static const struct iio_chan_spec ad7606_channels_16bit[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(8),
-	AD7606_CHANNEL(0),
-	AD7606_CHANNEL(1),
-	AD7606_CHANNEL(2),
-	AD7606_CHANNEL(3),
-	AD7606_CHANNEL(4),
-	AD7606_CHANNEL(5),
-	AD7606_CHANNEL(6),
-	AD7606_CHANNEL(7),
+	AD7606_CHANNEL(0, 16),
+	AD7606_CHANNEL(1, 16),
+	AD7606_CHANNEL(2, 16),
+	AD7606_CHANNEL(3, 16),
+	AD7606_CHANNEL(4, 16),
+	AD7606_CHANNEL(5, 16),
+	AD7606_CHANNEL(6, 16),
+	AD7606_CHANNEL(7, 16),
 };
 
 /*
@@ -333,22 +333,22 @@ static const struct iio_chan_spec ad7606_channels[] = {
  */
 static const struct iio_chan_spec ad7616_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(16),
-	AD7606_CHANNEL(0),
-	AD7606_CHANNEL(1),
-	AD7606_CHANNEL(2),
-	AD7606_CHANNEL(3),
-	AD7606_CHANNEL(4),
-	AD7606_CHANNEL(5),
-	AD7606_CHANNEL(6),
-	AD7606_CHANNEL(7),
-	AD7606_CHANNEL(8),
-	AD7606_CHANNEL(9),
-	AD7606_CHANNEL(10),
-	AD7606_CHANNEL(11),
-	AD7606_CHANNEL(12),
-	AD7606_CHANNEL(13),
-	AD7606_CHANNEL(14),
-	AD7606_CHANNEL(15),
+	AD7606_CHANNEL(0, 16),
+	AD7606_CHANNEL(1, 16),
+	AD7606_CHANNEL(2, 16),
+	AD7606_CHANNEL(3, 16),
+	AD7606_CHANNEL(4, 16),
+	AD7606_CHANNEL(5, 16),
+	AD7606_CHANNEL(6, 16),
+	AD7606_CHANNEL(7, 16),
+	AD7606_CHANNEL(8, 16),
+	AD7606_CHANNEL(9, 16),
+	AD7606_CHANNEL(10, 16),
+	AD7606_CHANNEL(11, 16),
+	AD7606_CHANNEL(12, 16),
+	AD7606_CHANNEL(13, 16),
+	AD7606_CHANNEL(14, 16),
+	AD7606_CHANNEL(15, 16),
 };
 
 static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
@@ -358,25 +358,25 @@ static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
 		.num_channels = 5,
 	},
 	[ID_AD7606_8] = {
-		.channels = ad7606_channels,
+		.channels = ad7606_channels_16bit,
 		.num_channels = 9,
 		.oversampling_avail = ad7606_oversampling_avail,
 		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	},
 	[ID_AD7606_6] = {
-		.channels = ad7606_channels,
+		.channels = ad7606_channels_16bit,
 		.num_channels = 7,
 		.oversampling_avail = ad7606_oversampling_avail,
 		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	},
 	[ID_AD7606_4] = {
-		.channels = ad7606_channels,
+		.channels = ad7606_channels_16bit,
 		.num_channels = 5,
 		.oversampling_avail = ad7606_oversampling_avail,
 		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
 	},
 	[ID_AD7606B] = {
-		.channels = ad7606_channels,
+		.channels = ad7606_channels_16bit,
 		.num_channels = 9,
 		.oversampling_avail = ad7606_oversampling_avail,
 		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 6649e84d25de..204a343067e5 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -8,7 +8,7 @@
 #ifndef IIO_ADC_AD7606_H_
 #define IIO_ADC_AD7606_H_
 
-#define AD760X_CHANNEL(num, mask_sep, mask_type, mask_all) {	\
+#define AD760X_CHANNEL(num, mask_sep, mask_type, mask_all, bits) {	\
 		.type = IIO_VOLTAGE,				\
 		.indexed = 1,					\
 		.channel = num,					\
@@ -19,24 +19,26 @@
 		.scan_index = num,				\
 		.scan_type = {					\
 			.sign = 's',				\
-			.realbits = 16,				\
-			.storagebits = 16,			\
+			.realbits = (bits),			\
+			.storagebits = (bits) > 16 ? 32 : 16,	\
 			.endianness = IIO_CPU,			\
 		},						\
 }
 
 #define AD7605_CHANNEL(num)				\
 	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),	\
-		BIT(IIO_CHAN_INFO_SCALE), 0)
+		BIT(IIO_CHAN_INFO_SCALE), 0, 16)
 
-#define AD7606_CHANNEL(num)				\
+#define AD7606_CHANNEL(num, bits)			\
 	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),	\
 		BIT(IIO_CHAN_INFO_SCALE),		\
-		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), bits)
 
-#define AD7616_CHANNEL(num)	\
+#define AD7606_SW_CHANNEL(num, bits)	\
 	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),\
-		0, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
+		0, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), bits)
+
+#define AD7616_CHANNEL(num)	AD7606_SW_CHANNEL(num, 16)
 
 /**
  * struct ad7606_chip_info - chip specific information
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index 62ec12195307..e00f58a6a0e9 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -67,14 +67,14 @@ static const struct iio_chan_spec ad7616_sw_channels[] = {
 
 static const struct iio_chan_spec ad7606b_sw_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(8),
-	AD7616_CHANNEL(0),
-	AD7616_CHANNEL(1),
-	AD7616_CHANNEL(2),
-	AD7616_CHANNEL(3),
-	AD7616_CHANNEL(4),
-	AD7616_CHANNEL(5),
-	AD7616_CHANNEL(6),
-	AD7616_CHANNEL(7),
+	AD7606_SW_CHANNEL(0, 16),
+	AD7606_SW_CHANNEL(1, 16),
+	AD7606_SW_CHANNEL(2, 16),
+	AD7606_SW_CHANNEL(3, 16),
+	AD7606_SW_CHANNEL(4, 16),
+	AD7606_SW_CHANNEL(5, 16),
+	AD7606_SW_CHANNEL(6, 16),
+	AD7606_SW_CHANNEL(7, 16),
 };
 
 static const unsigned int ad7606B_oversampling_avail[9] = {
-- 
2.46.0


