Return-Path: <linux-iio+bounces-4905-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116218C0258
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 18:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34B351C21CD8
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 16:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0DD12C814;
	Wed,  8 May 2024 16:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXPGP37G"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEFA12BF23;
	Wed,  8 May 2024 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715187150; cv=none; b=aH7zJt76TT6+Hn0yJVMUPPEcnT46gjg4eP3RJGGWNGyctyJW0gjvoPxOVxFBAnZOufUTrW6h3fGprKUgkKxVN9iqtNAsEfe4oti3Hm4YlenIgQ3NGwEzui34W622EpsebzD/nWF2UPWFUEny/Qx26hoFpPfGOAvye4vpx9JeWn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715187150; c=relaxed/simple;
	bh=bBREB3o7ZmqUzSIQAPdtxmw45LSnyx8GRFkTbVMsszc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rCK6FMH7OA/WBsVWuz0dNFFEAZFMnjK4jhRo4eyTanYVyoE5XnPH/fmUsiDxUGihDWq6aI9uzj90LnJPsqtAfu13mhbNK8bnoc1fevl7GF7wVoZ+PBXqSwf9mkFyEbiZN29qE+IOIEgTx4uZPxbsyZ+u/4AYr607Wsc/4tgMb5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXPGP37G; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59c5c9c6aeso996754166b.2;
        Wed, 08 May 2024 09:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715187147; x=1715791947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lr7+9723Dpn5jydrGZto5yHAv/bnnDEVeZUXRY0OaWU=;
        b=jXPGP37GtbZCACpUothLvRguWl4vXtQ46lam2GbVYDmk3dpfCkmiFsEQ2Xo/DyzJgE
         wTcm4bbQWklLXaHsUH34wkHNpyt2v9IYWXilixko0fa76ThOGPxTcVFYqR1DHISDUX7C
         r54XwAWb7ddMjMlFN4+uhXcAZeID3OFkSfC7SsMc9iVllfnh56kiPdDuPb1g9rXx5OsG
         B2D5vcEipKTtvOHpTay0Vvop3DBGjo278Vkne2SeNm8fv0OFZYbxJvfoTRMCawbjGy7F
         dEb/RQEKJaZh4QKE+khoeRg61oQuQmWOsx1SGPl5UlXtTkrL9DhyioHz6RM0jb0SnO6e
         +waw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715187147; x=1715791947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lr7+9723Dpn5jydrGZto5yHAv/bnnDEVeZUXRY0OaWU=;
        b=hupdB3Q/S4gWDgV15zhBE3PQUYiqytilk6xKhVfHQBgASJGCcCCexvlqSY3BHxe8zD
         INFWCIhhuVNyDkKy+7eYHPFsCelwxgM6zuF5AUS2C9vJmKkzs3bLQKj3ry+P04kfbTWG
         A7TaupytuQWR+NK5IVSQFmK1S0lZ/kMd1TTZerWgmLIqoo0zssA/X/GqtuZDc4FIxqmN
         UAcXp4RouDMALlf0hEH1hrE9X5GRa7zUdEEev2gwxW4W3JgiwuJb6ZiStma4q3C379CE
         P2m70ZpHJ/O+hD9DlOjr7Ib7TmzKPGAQJ/h3ir8VqApBso1TBasb/uA+nuwgHJqAX9rV
         x7rQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUdnX0+eFb0ljPH8D+WS6ULA/++SL0Ble24MPzj+8tStCJzkI4dmPZRuzdrbY/sTxdtQFBlN4cectfoMFf5RNFweApf3xZTHF9+Ca1ltuMfevfGMKDOBaZc+f7biYP+vnpp09MqY29
X-Gm-Message-State: AOJu0YzU5v7Jsxsgk+rKrkQ4+kuzkSsFh0kIccrJaZ5DeXHNUEH7LEYz
	hTXcaTHYMPSgGpN2+L34nX/4LVVDqrSW16AZ0atgR5pFadaw29OE
X-Google-Smtp-Source: AGHT+IHUhkPj+OE2YBwSHM3L7YidjpSIMyeQqE6/PLqF9mgsVoKMikQkf1YDC8uKR9jBhwzpjA6gEw==
X-Received: by 2002:a17:906:4756:b0:a59:cb29:3fac with SMTP id a640c23a62f3a-a59fb9f1043mr184936266b.65.1715187147029;
        Wed, 08 May 2024 09:52:27 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:a3c8:644e:cd04:560a])
        by smtp.gmail.com with ESMTPSA id kj24-20020a170907765800b00a59a8212c8esm5648010ejc.42.2024.05.08.09.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 09:52:26 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	andriy.shevchenko@linux.intel.com,
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
Subject: [PATCH v6 8/9] iio: pressure: bmp280: Add SCALE, RAW values in channels and refactorize them
Date: Wed,  8 May 2024 18:52:06 +0200
Message-Id: <20240508165207.145554-9-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240508165207.145554-1-vassilisamir@gmail.com>
References: <20240508165207.145554-1-vassilisamir@gmail.com>
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
 drivers/iio/pressure/bmp280-core.c | 86 +++++++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 70ce37370ac6..3f8144a0355b 100644
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
@@ -903,7 +973,7 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.num_chip_id = ARRAY_SIZE(bme280_chip_ids),
 	.regmap_config = &bmp280_regmap_config,
 	.start_up_time = 2000,
-	.channels = bmp280_channels,
+	.channels = bme280_channels,
 	.num_channels = 3,
 
 	.oversampling_temp_avail = bmp280_oversampling_avail,
-- 
2.25.1


