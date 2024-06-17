Return-Path: <linux-iio+bounces-6444-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4614290BF78
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 01:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD990283095
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 23:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4C719A28F;
	Mon, 17 Jun 2024 23:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9zVZU2d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C81C19939B;
	Mon, 17 Jun 2024 23:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718665550; cv=none; b=d8Nb0TX53/wuWQq/DGgn+09AXkDcKZJbSiNiaZY9+dwHbSmK4BB4CTChtKkxb55FmiJ5tihseMi5BgiFtN+QrO7M9rTxhmT+fQZHqPSO6XLNtqRaiXLcWNu8ebnQKH/x23gQHcKMSExBMN0eMkP/S/sOrchh0RiQrkGcLqXynCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718665550; c=relaxed/simple;
	bh=oF3JyjqYNvKvnGayW12T/3YqdIPfyR81tF4gdXXcZrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YGPHFbVw0Q2WM5SwPHOIhDQTZJ+YJcET7U6xApkIYVv65gNSgMcgTVWOEt9KL7LfcBi2FuAT6g5uiBPHAX9pljqa0SeAewR67B8TZo50dJ8m6m6hmS1UrtDMPvBOsZLyZmQplI8k/xXBd/LcZiVJ4XrTfgw2iaFsB3uNPFWohFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9zVZU2d; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57c6011d75dso5960959a12.3;
        Mon, 17 Jun 2024 16:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718665547; x=1719270347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tn0FMzl8/VpfeukF2hqB3UY1dVk2IBZO5AKC3dpyQ6A=;
        b=T9zVZU2df1jZd8NQBbT3MdtRNKsSSb7KL9++OU+20glvbUj7tfw/OnQWPE7LHuGIEW
         qda8hvwv5I+TJlS958P0yzLq8uCV121tJpl53kNVSd74LVamMEnq18vKmdSL1VYk7l2I
         oTFtDmTmnAfJqxYg8bRWJoxunP+47pBJmX+cOSAo0wuY5kbPBnXGL9RCD6d0MP3XJzdb
         0YgdiNu+tOFD/CROLIcnHd0vPxteX9gWF8L76PHTP+wXatBM8n59uAi5l1II+FZY8MXc
         PODQ+ddnpqBjSCM5JTxvAXoua0w3kaK4tLIrw3IS3cMk4cIeTCa6d+J7rBnGKZ/FitfE
         37yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718665547; x=1719270347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tn0FMzl8/VpfeukF2hqB3UY1dVk2IBZO5AKC3dpyQ6A=;
        b=QG0NqWtsXgckxX63LUxdrX9M3F8k3TnoHjfsPBHI+t4UKC+9HIZPuvpgZ44uY2uvk0
         Tecqkf2ve+zqL/XB1tiK9bODU8dvlD6DJ713ZLo7Ioy5l0QCgBIU6vp9+rDRkqvrmph/
         6gDLqywbY9VeDuKiJVmNHMr7mOwUtSA4BfganFGCid8P6yfpFutzG4uorgMxUo0vjlW7
         MYyWZbD7cIXwNOd2YTBrehXAmhgP0mDAzrtIo3cgDYhQYwSowDaVEgeXwi4PWoldpnCt
         PLt33z1LPsMMbO6nbUxsGn2f+XIfPn4uO36+rJPLBMmH9UQhNic7wY2aK3JwPlDTChKZ
         K+lw==
X-Forwarded-Encrypted: i=1; AJvYcCV5mFqBJX52rQSOPa4nx9mASKKst7xsPYjvndu/YrsLD4Tmhpn2fWIGoN5Ks0H3aq6qED/LuLv0yURRr7d2Nz3VylxdCIN9+3BZtyRXvz/Tt86p2/sYXp8GqMmqpAezalrPUI1CDadY
X-Gm-Message-State: AOJu0YyYsDLHCCF5MMoyKzeCcLJJ11rGPz3C+qrxCaq1OZQpjcFwASYe
	ciY3wlu4jzNpSLymNw8wUrsFv4+v4ZZph5FjSQopBCgS0Irzn8q2
X-Google-Smtp-Source: AGHT+IH8q2XAKovQx0SGOr8ZaKxCW3h8G6BKLh7HROqzTYXf4V65w5FedBe0ENIcc/JgTPDPuuz2Qg==
X-Received: by 2002:a50:d483:0:b0:56e:99e:1fac with SMTP id 4fb4d7f45d1cf-57cbd8b9b8cmr7646015a12.39.1718665546557;
        Mon, 17 Jun 2024 16:05:46 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:b152:a6ad:d6c8:f0e8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72cdff1sm7085559a12.3.2024.06.17.16.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 16:05:46 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com,
	ak@it-klinger.de,
	petre.rodan@subdimension.ro,
	phil@raspberrypi.com,
	579lpy@gmail.com,
	linus.walleij@linaro.org,
	semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v8 2/3] iio: pressure: bmp280: Add SCALE, RAW values in channels and refactorize them
Date: Tue, 18 Jun 2024 01:05:39 +0200
Message-Id: <20240617230540.32325-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240617230540.32325-1-vassilisamir@gmail.com>
References: <20240617230540.32325-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add extra IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_RAW channels in order
to be able to calculate the processed value with standard userspace
IIO tools. Can be used for triggered buffers as well.

Even though it is not a good design choice to have SCALE, RAW and
PROCESSED together, the PROCESSED channel is kept for ABI compatibility.

While at it, separate BMPxxx and BMExxx device channels since BME
supports also humidity measurements.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Link: https://lore.kernel.org/r/20240512230524.53990-5-vassilisamir@gmail.com
---
 drivers/iio/pressure/bmp280-core.c | 96 ++++++++++++++++++++++++++----
 1 file changed, 83 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 27c00af060fa..5f64d9951f37 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -137,17 +137,45 @@ enum {
 static const struct iio_chan_spec bmp280_channels[] = {
 	{
 		.type = IIO_PRESSURE,
+		/* PROCESSED maintained for ABI backwards compatibility */
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 	},
 	{
 		.type = IIO_TEMP,
+		/* PROCESSED maintained for ABI backwards compatibility */
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+	},
+};
+
+static const struct iio_chan_spec bme280_channels[] = {
+	{
+		.type = IIO_PRESSURE,
+		/* PROCESSED maintained for ABI backwards compatibility */
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+	},
+	{
+		.type = IIO_TEMP,
+		/* PROCESSED maintained for ABI backwards compatibility */
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 	},
 	{
 		.type = IIO_HUMIDITYRELATIVE,
+		/* PROCESSED maintained for ABI backwards compatibility */
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 	},
 };
@@ -155,21 +183,20 @@ static const struct iio_chan_spec bmp280_channels[] = {
 static const struct iio_chan_spec bmp380_channels[] = {
 	{
 		.type = IIO_PRESSURE,
+		/* PROCESSED maintained for ABI backwards compatibility */
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
 	},
 	{
 		.type = IIO_TEMP,
+		/* PROCESSED maintained for ABI backwards compatibility */
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
-				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
-		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
-	},
-	{
-		.type = IIO_HUMIDITYRELATIVE,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
@@ -537,6 +564,49 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_CHAN_INFO_RAW:
+		switch (chan->type) {
+		case IIO_HUMIDITYRELATIVE:
+			ret = data->chip_info->read_humid(data, &chan_value);
+			if (ret)
+				return ret;
+
+			*val = chan_value;
+			return IIO_VAL_INT;
+		case IIO_PRESSURE:
+			ret = data->chip_info->read_press(data, &chan_value);
+			if (ret)
+				return ret;
+
+			*val = chan_value;
+			return IIO_VAL_INT;
+		case IIO_TEMP:
+			ret = data->chip_info->read_temp(data, &chan_value);
+			if (ret)
+				return ret;
+
+			*val = chan_value;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_HUMIDITYRELATIVE:
+			*val = data->chip_info->humid_coeffs[0];
+			*val2 = data->chip_info->humid_coeffs[1];
+			return data->chip_info->humid_coeffs_type;
+		case IIO_PRESSURE:
+			*val = data->chip_info->press_coeffs[0];
+			*val2 = data->chip_info->press_coeffs[1];
+			return data->chip_info->press_coeffs_type;
+		case IIO_TEMP:
+			*val = data->chip_info->temp_coeffs[0];
+			*val2 = data->chip_info->temp_coeffs[1];
+			return data->chip_info->temp_coeffs_type;
+		default:
+			return -EINVAL;
+		}
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
@@ -843,7 +913,7 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.regmap_config = &bmp280_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp280_channels,
-	.num_channels = 2,
+	.num_channels = ARRAY_SIZE(bmp280_channels),
 
 	.oversampling_temp_avail = bmp280_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp280_oversampling_avail),
@@ -903,8 +973,8 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.num_chip_id = ARRAY_SIZE(bme280_chip_ids),
 	.regmap_config = &bmp280_regmap_config,
 	.start_up_time = 2000,
-	.channels = bmp280_channels,
-	.num_channels = 3,
+	.channels = bme280_channels,
+	.num_channels = ARRAY_SIZE(bme280_channels),
 
 	.oversampling_temp_avail = bmp280_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp280_oversampling_avail),
@@ -1328,7 +1398,7 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.spi_read_extra_byte = true,
 	.start_up_time = 2000,
 	.channels = bmp380_channels,
-	.num_channels = 2,
+	.num_channels = ARRAY_SIZE(bmp380_channels),
 
 	.oversampling_temp_avail = bmp380_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp380_oversampling_avail),
@@ -1858,7 +1928,7 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.regmap_config = &bmp580_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp380_channels,
-	.num_channels = 2,
+	.num_channels = ARRAY_SIZE(bmp380_channels),
 
 	.oversampling_temp_avail = bmp580_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp580_oversampling_avail),
@@ -2147,7 +2217,7 @@ const struct bmp280_chip_info bmp180_chip_info = {
 	.regmap_config = &bmp180_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp280_channels,
-	.num_channels = 2,
+	.num_channels = ARRAY_SIZE(bmp280_channels),
 
 	.oversampling_temp_avail = bmp180_oversampling_temp_avail,
 	.num_oversampling_temp_avail =
-- 
2.25.1


