Return-Path: <linux-iio+bounces-4895-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EA78C0212
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 18:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D06A5B219E4
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 16:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F95612BEBA;
	Wed,  8 May 2024 16:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/DGmP61"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1950712B142;
	Wed,  8 May 2024 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715186089; cv=none; b=oOC9FuEdoT1XLbwb6V60ZlyMC0DnSvLS+UwBpEaR+NZ/2YxkKxIcvCZ5BbFHsegtsXuAXhlBvigNtN7f3s6FhvRH5KV8Uq7J1zb0C9bLD0HvB+q4T4/FxPwguWyM+WKzf4sXDxc0LEcJz/TPNN+nEg0riEJV1LXgOIb3nBx9tXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715186089; c=relaxed/simple;
	bh=bBREB3o7ZmqUzSIQAPdtxmw45LSnyx8GRFkTbVMsszc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qbNoY/4Rjy0LqxpN9QM/yYS+OuP0Nl3FikeqLFdRid0EwKSyAn0W6Zc5iJAAsU80ALCvdMyyPV7OCadIJwqIj5ZUi01+LTlZPR1ewVbu/dFIref4PGZUG6sNeMaIpJYTIAWD66pezg6FK2sEFUfjHKBAmzphcR8HWlrDXKwwg2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/DGmP61; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a59a17fcc6bso1082996366b.1;
        Wed, 08 May 2024 09:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715186086; x=1715790886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lr7+9723Dpn5jydrGZto5yHAv/bnnDEVeZUXRY0OaWU=;
        b=L/DGmP61K/Rsdj4+yiq7CBd7zb9N4cEDA7bqG/R1CJbyAQjb/ATH9AYRlsQ+Qpthpc
         VOFQX5DUyGfSh0x1ZhTOnfZm3ubL/iKg3GdMAHeDAPB+b9G1Lb2GymWjw7kKXVLzohmW
         Fv3zQYrF1mV9x3s2bN+wvpZSppDfXcKGfVZVvF/qyuxRLSXV3lfp826Ht6//kvGiOnzE
         f8aTwmv2Ix7E2pASZFlR/zUHzwmWEA5Pb7jzLGJ3LC7h8snbc3Hzx6KOGI2U7Vlju2e3
         uxZwMb/ae0MA4R/4AN7tXjp3QyHaGFflRkh2/+zC8gtVFNv5DlhiYTR1umMwjrFmuDIB
         4//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715186086; x=1715790886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lr7+9723Dpn5jydrGZto5yHAv/bnnDEVeZUXRY0OaWU=;
        b=s1cgjyRjV6Tbhy23SY+W8TlULOnatGQ+3InTlI+eSqXTzrql2kt1qHYX4BgWEOzaHi
         fUTfEeweHkQC6fUZQqM+/rvv3Wz/8DVKvlbFGRKKIVJnpeJ30YwxoYkmS4mVw5KgIk/v
         MZ9a6Ec5bQ+8x3kQsnDBFLO8LhQN1AqtIueQd5IVoQ3V24iVFnIA93Ut7FviqErG5waQ
         iwmnRhN+myVX/r8bCIG/gj1c6mp8YxDLxpbKORRkgGTdmNYB//yBpnmsSS0Sj9tV5xBl
         LJQjqqK6mHUNOmMCE4UfW+NP3FlowIOwuqFh5g2n2EEhLk9zV70XulEJMXTrEiuKAuBD
         Zagw==
X-Forwarded-Encrypted: i=1; AJvYcCXV6jpbx1OEwhlRRuTZJZ79D1aAJlhVKT5RpWounVdJSd9K6TAy9GGQSicrYMeZXGVrVBq2MrPJHhfvVWur8Q1B2WNVNtxFZVxjLoZyBwBi/+tBqBf/74WV3+TU2AVSUOq/yoUuNQOX
X-Gm-Message-State: AOJu0YxjRAteUgX7rSuVtkKW8MBvLYXOjl5tU+gzqSXl/EoHy+FEjsRv
	DYyPrQjJ41/rgnw1osEMDN7nBFShPP3vYPBkVc3dhKm3PiAc2pOLeDl1RVvig2Q=
X-Google-Smtp-Source: AGHT+IFVTozWBectdLwNHchfQY6Ds8AGXleybcPgQoRIpMykiXNbiikjTrFWvtcxYAEPAkxL7/ZfFw==
X-Received: by 2002:a17:906:515:b0:a59:a7b7:2b8b with SMTP id a640c23a62f3a-a59fb948fa8mr203571866b.10.1715186086542;
        Wed, 08 May 2024 09:34:46 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:a3c8:644e:cd04:560a])
        by smtp.gmail.com with ESMTPSA id hb4-20020a170906b88400b00a5599f3a057sm7872843ejb.107.2024.05.08.09.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 09:34:46 -0700 (PDT)
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
Subject: [PATCH 8/9] iio: pressure: bmp280: Add SCALE, RAW values in channels and refactorize them
Date: Wed,  8 May 2024 18:34:24 +0200
Message-Id: <20240508163425.143831-9-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240508163425.143831-1-vassilisamir@gmail.com>
References: <20240508163425.143831-1-vassilisamir@gmail.com>
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


