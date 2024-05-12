Return-Path: <linux-iio+bounces-5002-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B08F8C3923
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 01:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DB5EB20D52
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 23:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1AC5FDB3;
	Sun, 12 May 2024 23:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMM6EnrL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD5A5D8F0;
	Sun, 12 May 2024 23:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715555138; cv=none; b=GW/81InDzKtmCQ43B//TH1picbuJCvAKMICyiTti8iQmVmicOl9D0pElJvCUOBtCWdvf6IvoT3lmSrzezEcPzsFtCVojMe36HTxXdnsrY8mZ6rvr9XJ+F17LJTPxE2NjYEthKcmSBpjTHns3kJiMSquSbKsTn83KWmXsQwZZylM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715555138; c=relaxed/simple;
	bh=iyjE7SnsFqQfNUBMaXK+QnE6ThuT7NRlk3/NBOY8EC8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HP11CaPMITN6xhGYmdt6ALWUlMfVmBZUSVgpyj16yL+cU3tErokm2OfiCzuSTHVyrFi2sDcLcSljfU/fQl8+58bggWOkE345ElAEkk9HFomox61kWIsErNdiXuAaJ83CVtR3SwW7XFDb4FHF7q64gRPO+9HMKu2T428W5t9qArE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMM6EnrL; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34ddc9fe4a1so2599150f8f.0;
        Sun, 12 May 2024 16:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715555135; x=1716159935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=no1yFzPYjJgUNtn8BohHDKM7deFPivb6F1L4Mw2rQPw=;
        b=VMM6EnrLaII+idxS1FoI1NQiNwd57zuvk0NulMHyRcaz3sC2V/87LrAYh9hfF9w5ut
         Vr2zNS/moGk6WzmRYgL96R2XM222C9B8B3YuX/Lokfx7sfnfzR1CIHgofKiKKVu2+JCQ
         xdHukZLdFNUkE540/555oroHN5/ot1iGT5/tRZFSf8kWAT7vEQZHoTApZrUBwEtghRy3
         kFuIv+gDTRBfNuDUQTU0IbcYPeHUd6S60kPD7GbiotsRFXrB5xEDaU04b7QpZXzDs64H
         AShIUeJ95XQRYHqEEQTkDlbTcDS+C7FITdCX188xiLipwFD/xeUNCdGGAi7bAGjfDK0J
         dffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715555135; x=1716159935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=no1yFzPYjJgUNtn8BohHDKM7deFPivb6F1L4Mw2rQPw=;
        b=NJxoALUCQSfvZ3c0Ix/RdXZvIi+c83nX0E4iLYUjgRsgMCXJ5NjUbHF+GEEWGC7tgk
         K8PTDvv/vycRsy3cR2N4N+EWPznzJH4w860Wgbr2W4g5kuc5Dm5q9A0YzGgCPWH03bSn
         g1srEsR+97j73CxDNe/lNQf6RtyiYnybE4lXCQyIVtDkTdW/QHLGPeKAQrec5XEHuZHp
         g+77s1qkdPoUsivPFxb2fDHr/vNAcfH70MOigvb/9XjHQwfKrdHwqoiBoljFoahS6ArS
         UFkUoR8PdAhmnlg4r4wHJqZTCJ1ALOjUnj96uVmV5oxiiIwKwpzjxNILBZu7BcrX4pUD
         wDvg==
X-Forwarded-Encrypted: i=1; AJvYcCXavRLHiKk/XaZskNE+hnUbDmqOKSagYCng76Ii48pNBS3UCnDTwrF5ibUcFyaNAfVE0ucnR7ou9FC4bp54ZbiIfvtSwdnSEh9Dcf+EyuqdjDLXQcLEODfDyc0+mLCHoYQcfJ7UwsBE
X-Gm-Message-State: AOJu0YzCcU3KjPu2ByawaRM+2eS+UlllvFZAxhOdSbpK8Kw9vzBPtrKt
	HxFpvcBdgMIaOHPnJuWS0oGVDZfRp9UC8EBH8u3eVldOt4Jgkmgy
X-Google-Smtp-Source: AGHT+IFAkkb6/q1j6X7gBuGFWF3Ea9AV5gOu9T98KXfjVjm00rV+SPaxMA+MNHzpDySofIKKdtXi8g==
X-Received: by 2002:adf:e8cc:0:b0:34d:71a9:8837 with SMTP id ffacd0b85a97d-3504a954ebbmr5847928f8f.44.1715555134597;
        Sun, 12 May 2024 16:05:34 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:ce14:864c:436e:5c6d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee92bcsm136720935e9.36.2024.05.12.16.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 16:05:34 -0700 (PDT)
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
Subject: [PATCH v7 4/5] iio: pressure: bmp280: Add SCALE, RAW values in channels and refactorize them
Date: Mon, 13 May 2024 01:05:23 +0200
Message-Id: <20240512230524.53990-5-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240512230524.53990-1-vassilisamir@gmail.com>
References: <20240512230524.53990-1-vassilisamir@gmail.com>
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
---
 drivers/iio/pressure/bmp280-core.c | 96 ++++++++++++++++++++++++++----
 1 file changed, 83 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 854f699fd724..da24e95c62c3 100644
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
@@ -1327,7 +1397,7 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.regmap_config = &bmp380_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp380_channels,
-	.num_channels = 2,
+	.num_channels = ARRAY_SIZE(bmp380_channels),
 
 	.oversampling_temp_avail = bmp380_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp380_oversampling_avail),
@@ -1852,7 +1922,7 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.regmap_config = &bmp580_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp380_channels,
-	.num_channels = 2,
+	.num_channels = ARRAY_SIZE(bmp380_channels),
 
 	.oversampling_temp_avail = bmp580_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp580_oversampling_avail),
@@ -2141,7 +2211,7 @@ const struct bmp280_chip_info bmp180_chip_info = {
 	.regmap_config = &bmp180_regmap_config,
 	.start_up_time = 2000,
 	.channels = bmp280_channels,
-	.num_channels = 2,
+	.num_channels = ARRAY_SIZE(bmp280_channels),
 
 	.oversampling_temp_avail = bmp180_oversampling_temp_avail,
 	.num_oversampling_temp_avail =
-- 
2.25.1


