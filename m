Return-Path: <linux-iio+bounces-4894-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D696D8C0211
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 18:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067E51C22065
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 16:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A52512A17B;
	Wed,  8 May 2024 16:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cv47NF4X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC255748E;
	Wed,  8 May 2024 16:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715186089; cv=none; b=uA3P/qwQkCWmm/fhxnW+rIN8C5U7H4YDaIamBcT8G9h4FWo1xQGFH3osNJ3Zrquib5R2b3PYtMG4XTU7Vlv1puLUqBVsW7h+rLG7Vji4yRcMUhsGPrFvNSG0SET16BdykBdPibeN5IWdr6KelbzSwL/MxkocTj32rQTrUlkPrA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715186089; c=relaxed/simple;
	bh=ZePmlJ476b9UlfjyZ+GdTDypA639eVjBYtYWA2RyFN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uZ1wr7nZY/byIuhXng1uzc+j0M75OTgWMhdNrvnqlKMrAvNvEjbSr/D2abzGEOWnPl2724gP2kLHjsB4hIBA1vkNVtqFr6okQPaClnxUr2sjwS3uinkX7MtesDxWZbaRm4+o8Q8//oqUSUMNKZYiKuKiPLnB67ErCsDwLTWJ8NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cv47NF4X; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59c04839caso1050712366b.2;
        Wed, 08 May 2024 09:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715186085; x=1715790885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWuEmL1nOJO8dyDrRjblFvjZaNCnqeRHoo9biproydg=;
        b=Cv47NF4Xakh4QWWIhhUUommqfT8RndT0UEsH9kwwKzq34b6MRlrYKsTCqEXxDIEU71
         RTfeSVGuQo+RCrNC4UEM4i7C3HWt1lFCdk7JJlE6ktgNRW13dOcYygZJxEETsTiR9M3t
         F+R2dFU0tKBekKZUVKITFqheAxDRgXWLm9DzSQd3xoZAEJ+scxdRYv2E2JcxjBi+PRxz
         TVpxi5ISbH+4lI7oxkBILjPKv60uSxJj2vj2RR/8TdcLMmnHQlkfeiRslqwlfNI/+fH+
         ImNJbz2HsxXGXFIG8WPg8fxCfBtCGKgIfaKGD7jbJBfTUVd7tMlctrmbSU6z5gqKcQsm
         3lAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715186085; x=1715790885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWuEmL1nOJO8dyDrRjblFvjZaNCnqeRHoo9biproydg=;
        b=jxObuAfLfe/ka1xy6b+hCSbw8TebqexKP8FxYBxfBMXD0OGXArVdNpNTsz8ZsKJgxf
         4BF42WgDk+Rl7KpO7n+W6eTNO+LaJXZw7HjLAsEs+0YJYqkgMOZhgN0wSDxsIPYJBoyM
         29c2tzVvTKCNi24xY3GsOV5ITDtDUbOC6KTSzfwb6n1/S7oe7etz6JSi3MZjg0k+VW02
         ui+lM/F5D+oRK/lcY1x7mMJ9nlkc33ueP60koEcz5dhYcUOdh1fdYHagr3wn7pGS88mN
         IXV3rIgN7nLkDAKyiOzVhWQndx2rsj1oWuRG3QajibnL2FW6mBhjlE0kyif7qcsrnEy/
         hv6A==
X-Forwarded-Encrypted: i=1; AJvYcCVmHCUmmgIUTgNUe8zm5Tw+y9P1tUmutqzwiokIb29Uu1iAdCZhHr6G77UeOvdXMsZFZesw0VwQihOaO2HZwqnTH5rOtSf0uRenijPOHcEeHQyWcSJzk+iN+WDDkj8sQ33AdQQHu+51
X-Gm-Message-State: AOJu0YyjHY1Pqh3soTj2ghnXoo0mFp/HD5eUmNg8RBUWkXi2nZYePRcc
	zZLID3wSwQSzSOVc/R2mDwf0L8X/lsL0DnzhD9wvNa94bWRLI0+u
X-Google-Smtp-Source: AGHT+IEbP3P7J8b9TiOFhlK+U/MOtKGPFv+vUJS6BNYJJTSF2NrdM3DwITp/i18Tli8yHM1xv9BIdw==
X-Received: by 2002:a17:906:6d57:b0:a59:c5c2:a320 with SMTP id a640c23a62f3a-a59fb941e2amr198174266b.23.1715186085185;
        Wed, 08 May 2024 09:34:45 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:a3c8:644e:cd04:560a])
        by smtp.gmail.com with ESMTPSA id hb4-20020a170906b88400b00a5599f3a057sm7872843ejb.107.2024.05.08.09.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 09:34:44 -0700 (PDT)
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
Subject: [PATCH 7/9] iio: pressure: bmp280: Generalize read_{temp,press,humid}() functions
Date: Wed,  8 May 2024 18:34:23 +0200
Message-Id: <20240508163425.143831-8-vassilisamir@gmail.com>
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

Add the coefficients for the IIO standard units and the IIO value
inside the chip_info structure.

Move the calculations for the IIO unit compatibility from inside the
read_{temp,press,humid}() functions and move them to the general
read_raw() function.

In this way, all the data for the calculation of the value are
located in the chip_info structure of the respective sensor.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 171 ++++++++++++++++-------------
 drivers/iio/pressure/bmp280.h      |  13 ++-
 2 files changed, 104 insertions(+), 80 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index eed356bcf8a2..70ce37370ac6 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -445,10 +445,8 @@ static u32 bmp280_compensate_press(struct bmp280_data *data,
 	return (u32)p;
 }
 
-static int bmp280_read_temp(struct bmp280_data *data,
-			    int *val, int *val2)
+static int bmp280_read_temp(struct bmp280_data *data, s32 *comp_temp)
 {
-	s32 comp_temp;
 	u32 adc_temp;
 	int ret;
 
@@ -456,17 +454,15 @@ static int bmp280_read_temp(struct bmp280_data *data,
 	if (ret)
 		return ret;
 
-	comp_temp = bmp280_compensate_temp(data, adc_temp);
+	*comp_temp = bmp280_compensate_temp(data, adc_temp);
 
-	/* IIO units are in milli Celsius */
-	*val = comp_temp * 10;
-	return IIO_VAL_INT;
+	return 0;
 }
 
-static int bmp280_read_press(struct bmp280_data *data,
-			     int *val, int *val2)
+static int bmp280_read_press(struct bmp280_data *data, u32 *comp_press)
 {
-	u32 comp_press, adc_press, t_fine;
+	u32 adc_press;
+	s32 t_fine;
 	int ret;
 
 	ret = bmp280_get_t_fine(data, &t_fine);
@@ -477,18 +473,13 @@ static int bmp280_read_press(struct bmp280_data *data,
 	if (ret)
 		return ret;
 
-	comp_press = bmp280_compensate_press(data, adc_press, t_fine);
+	*comp_press = bmp280_compensate_press(data, adc_press, t_fine);
 
-	/* IIO units are in kPa */
-	*val = comp_press;
-	*val2 = 256000;
-
-	return IIO_VAL_FRACTIONAL;
+	return 0;
 }
 
-static int bme280_read_humid(struct bmp280_data *data, int *val, int *val2)
+static int bme280_read_humid(struct bmp280_data *data, u32 *comp_humidity)
 {
-	u32 comp_humidity;
 	u16 adc_humidity;
 	s32 t_fine;
 	int ret;
@@ -501,12 +492,9 @@ static int bme280_read_humid(struct bmp280_data *data, int *val, int *val2)
 	if (ret)
 		return ret;
 
-	comp_humidity = bme280_compensate_humidity(data, adc_humidity, t_fine);
+	*comp_humidity = bme280_compensate_humidity(data, adc_humidity, t_fine);
 
-	/* IIO units are in 1000 * % */
-	*val = comp_humidity * 1000 / 1024;
-
-	return IIO_VAL_INT;
+	return 0;
 }
 
 static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
@@ -514,6 +502,8 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 				int *val, int *val2, long mask)
 {
 	struct bmp280_data *data = iio_priv(indio_dev);
+	int chan_value;
+	int ret;
 
 	guard(mutex)(&data->lock);
 
@@ -521,11 +511,29 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_PROCESSED:
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
-			return data->chip_info->read_humid(data, val, val2);
+			ret = data->chip_info->read_humid(data, &chan_value);
+			if (ret)
+				return ret;
+
+			*val = data->chip_info->humid_coeffs[0] * chan_value;
+			*val2 = data->chip_info->humid_coeffs[1];
+			return data->chip_info->humid_coeffs_type;
 		case IIO_PRESSURE:
-			return data->chip_info->read_press(data, val, val2);
+			ret = data->chip_info->read_press(data, &chan_value);
+			if (ret)
+				return ret;
+
+			*val = data->chip_info->press_coeffs[0] * chan_value;
+			*val2 = data->chip_info->press_coeffs[1];
+			return data->chip_info->press_coeffs_type;
 		case IIO_TEMP:
-			return data->chip_info->read_temp(data, val, val2);
+			ret = data->chip_info->read_temp(data, &chan_value);
+			if (ret)
+				return ret;
+
+			*val = data->chip_info->temp_coeffs[0] * chan_value;
+			*val2 = data->chip_info->temp_coeffs[1];
+			return data->chip_info->temp_coeffs_type;
 		default:
 			return -EINVAL;
 		}
@@ -825,6 +833,8 @@ static int bmp280_chip_config(struct bmp280_data *data)
 
 static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
 static const u8 bmp280_chip_ids[] = { BMP280_CHIP_ID };
+static const int bmp280_temp_coeffs[] = { 10, 1 };
+static const int bmp280_press_coeffs[] = { 1, 256000 };
 
 const struct bmp280_chip_info bmp280_chip_info = {
 	.id_reg = BMP280_REG_ID,
@@ -853,6 +863,11 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.num_oversampling_press_avail = ARRAY_SIZE(bmp280_oversampling_avail),
 	.oversampling_press_default = BMP280_OSRS_PRESS_16X - 1,
 
+	.temp_coeffs = bmp280_temp_coeffs,
+	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
+	.press_coeffs = bmp280_press_coeffs,
+	.press_coeffs_type = IIO_VAL_FRACTIONAL,
+
 	.chip_config = bmp280_chip_config,
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
@@ -880,6 +895,7 @@ static int bme280_chip_config(struct bmp280_data *data)
 }
 
 static const u8 bme280_chip_ids[] = { BME280_CHIP_ID };
+static const int bme280_humid_coeffs[] = { 1000, 1024 };
 
 const struct bmp280_chip_info bme280_chip_info = {
 	.id_reg = BMP280_REG_ID,
@@ -902,6 +918,13 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.num_oversampling_humid_avail = ARRAY_SIZE(bmp280_oversampling_avail),
 	.oversampling_humid_default = BME280_OSRS_HUMIDITY_16X - 1,
 
+	.temp_coeffs = bmp280_temp_coeffs,
+	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
+	.press_coeffs = bmp280_press_coeffs,
+	.press_coeffs_type = IIO_VAL_FRACTIONAL,
+	.humid_coeffs = bme280_humid_coeffs,
+	.humid_coeffs_type = IIO_VAL_FRACTIONAL,
+
 	.chip_config = bme280_chip_config,
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
@@ -1094,9 +1117,8 @@ static u32 bmp380_compensate_press(struct bmp280_data *data,
 	return comp_press;
 }
 
-static int bmp380_read_temp(struct bmp280_data *data, int *val, int *val2)
+static int bmp380_read_temp(struct bmp280_data *data, s32 *comp_temp)
 {
-	s32 comp_temp;
 	u32 adc_temp;
 	int ret;
 
@@ -1104,16 +1126,14 @@ static int bmp380_read_temp(struct bmp280_data *data, int *val, int *val2)
 	if (ret)
 		return ret;
 
-	comp_temp = bmp380_compensate_temp(data, adc_temp);
+	*comp_temp = bmp380_compensate_temp(data, adc_temp);
 
-	/* IIO units are in milli Celsius */
-	*val = comp_temp * 10;
-	return IIO_VAL_INT;
+	return 0;
 }
 
-static int bmp380_read_press(struct bmp280_data *data, int *val, int *val2)
+static int bmp380_read_press(struct bmp280_data *data, u32 *comp_press)
 {
-	u32 adc_press, comp_press, t_fine;
+	u32 adc_press, t_fine;
 	int ret;
 
 	ret = bmp380_get_t_fine(data, &t_fine);
@@ -1124,13 +1144,9 @@ static int bmp380_read_press(struct bmp280_data *data, int *val, int *val2)
 	if (ret)
 		return ret;
 
-	comp_press = bmp380_compensate_press(data, adc_press, t_fine);
+	*comp_press = bmp380_compensate_press(data, adc_press, t_fine);
 
-	/* IIO units are in kPa */
-	*val = comp_press;
-	*val2 = 100000;
-
-	return IIO_VAL_FRACTIONAL;
+	return 0;
 }
 
 static int bmp380_read_calib(struct bmp280_data *data)
@@ -1301,6 +1317,8 @@ static int bmp380_chip_config(struct bmp280_data *data)
 static const int bmp380_oversampling_avail[] = { 1, 2, 4, 8, 16, 32 };
 static const int bmp380_iir_filter_coeffs_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128};
 static const u8 bmp380_chip_ids[] = { BMP380_CHIP_ID, BMP390_CHIP_ID };
+static const int bmp380_temp_coeffs[] = { 10, 1 };
+static const int bmp380_press_coeffs[] = { 1, 100000 };
 
 const struct bmp280_chip_info bmp380_chip_info = {
 	.id_reg = BMP380_REG_ID,
@@ -1328,6 +1346,11 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp380_iir_filter_coeffs_avail),
 	.iir_filter_coeff_default = 2,
 
+	.temp_coeffs = bmp380_temp_coeffs,
+	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
+	.press_coeffs = bmp380_press_coeffs,
+	.press_coeffs_type = IIO_VAL_FRACTIONAL,
+
 	.chip_config = bmp380_chip_config,
 	.read_temp = bmp380_read_temp,
 	.read_press = bmp380_read_press,
@@ -1448,9 +1471,8 @@ static int bmp580_nvm_operation(struct bmp280_data *data, bool is_write)
  * for what is expected on IIO ABI.
  */
 
-static int bmp580_read_temp(struct bmp280_data *data, int *val, int *val2)
+static int bmp580_read_temp(struct bmp280_data *data, s32 *raw_temp)
 {
-	s32 raw_temp;
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB, data->buf,
@@ -1460,25 +1482,17 @@ static int bmp580_read_temp(struct bmp280_data *data, int *val, int *val2)
 		return ret;
 	}
 
-	raw_temp = get_unaligned_le24(data->buf);
-	if (raw_temp == BMP580_TEMP_SKIPPED) {
+	*raw_temp = get_unaligned_le24(data->buf);
+	if (*raw_temp == BMP580_TEMP_SKIPPED) {
 		dev_err(data->dev, "reading temperature skipped\n");
 		return -EIO;
 	}
 
-	/*
-	 * Temperature is returned in Celsius degrees in fractional
-	 * form down 2^16. We rescale by x1000 to return milli Celsius
-	 * to respect IIO ABI.
-	 */
-	*val = raw_temp * 1000;
-	*val2 = 16;
-	return IIO_VAL_FRACTIONAL_LOG2;
+	return 0;
 }
 
-static int bmp580_read_press(struct bmp280_data *data, int *val, int *val2)
+static int bmp580_read_press(struct bmp280_data *data, u32 *raw_press)
 {
-	u32 raw_press;
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP580_REG_PRESS_XLSB, data->buf,
@@ -1488,18 +1502,13 @@ static int bmp580_read_press(struct bmp280_data *data, int *val, int *val2)
 		return ret;
 	}
 
-	raw_press = get_unaligned_le24(data->buf);
-	if (raw_press == BMP580_PRESS_SKIPPED) {
+	*raw_press = get_unaligned_le24(data->buf);
+	if (*raw_press == BMP580_PRESS_SKIPPED) {
 		dev_err(data->dev, "reading pressure skipped\n");
 		return -EIO;
 	}
-	/*
-	 * Pressure is returned in Pascals in fractional form down 2^16.
-	 * We rescale /1000 to convert to kilopascal to respect IIO ABI.
-	 */
-	*val = raw_press;
-	*val2 = 64000; /* 2^6 * 1000 */
-	return IIO_VAL_FRACTIONAL;
+
+	return 0;
 }
 
 static const int bmp580_odr_table[][2] = {
@@ -1813,6 +1822,8 @@ static int bmp580_chip_config(struct bmp280_data *data)
 
 static const int bmp580_oversampling_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
 static const u8 bmp580_chip_ids[] = { BMP580_CHIP_ID, BMP580_CHIP_ID_ALT };
+static const int bmp580_temp_coeffs[] = { 1000, 16 };
+static const int bmp580_press_coeffs[] = { 1, 64000};
 
 const struct bmp280_chip_info bmp580_chip_info = {
 	.id_reg = BMP580_REG_CHIP_ID,
@@ -1839,6 +1850,11 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.num_iir_filter_coeffs_avail = ARRAY_SIZE(bmp380_iir_filter_coeffs_avail),
 	.iir_filter_coeff_default = 2,
 
+	.temp_coeffs = bmp580_temp_coeffs,
+	.temp_coeffs_type = IIO_VAL_FRACTIONAL_LOG2,
+	.press_coeffs = bmp580_press_coeffs,
+	.press_coeffs_type = IIO_VAL_FRACTIONAL,
+
 	.chip_config = bmp580_chip_config,
 	.read_temp = bmp580_read_temp,
 	.read_press = bmp580_read_press,
@@ -1994,9 +2010,8 @@ static s32 bmp180_compensate_temp(struct bmp280_data *data, u32 adc_temp)
 	return (bmp180_calc_t_fine(data, adc_temp) + 8) / 16;
 }
 
-static int bmp180_read_temp(struct bmp280_data *data, int *val, int *val2)
+static int bmp180_read_temp(struct bmp280_data *data, s32 *comp_temp)
 {
-	s32 comp_temp;
 	u32 adc_temp;
 	int ret;
 
@@ -2004,11 +2019,9 @@ static int bmp180_read_temp(struct bmp280_data *data, int *val, int *val2)
 	if (ret)
 		return ret;
 
-	comp_temp = bmp180_compensate_temp(data, adc_temp);
+	*comp_temp = bmp180_compensate_temp(data, adc_temp);
 
-	/* IIO units are in milli Celsius */
-	*val = comp_temp * 100;
-	return IIO_VAL_INT;
+	return 0;
 }
 
 static int bmp180_read_press_adc(struct bmp280_data *data, u32 *adc_press)
@@ -2071,10 +2084,11 @@ static u32 bmp180_compensate_press(struct bmp280_data *data, u32 adc_press,
 	return p + ((x1 + x2 + 3791) >> 4);
 }
 
-static int bmp180_read_press(struct bmp280_data *data, int *val, int *val2)
+static int bmp180_read_press(struct bmp280_data *data, u32 *comp_press)
 {
-	u32 comp_press, adc_press;
+	u32 adc_press;
 	s32 t_fine;
+	int ret;
 
 	ret = bmp180_get_t_fine(data, &t_fine);
 	if (ret)
@@ -2084,13 +2098,9 @@ static int bmp180_read_press(struct bmp280_data *data, int *val, int *val2)
 	if (ret)
 		return ret;
 
-	comp_press = bmp180_compensate_press(data, adc_press, t_fine);
-
-	/* IIO units are in kPa */
-	*val = comp_press;
-	*val2 = 1000;
+	*comp_press = bmp180_compensate_press(data, adc_press, t_fine);
 
-	return IIO_VAL_FRACTIONAL;
+	return 0;
 }
 
 static int bmp180_chip_config(struct bmp280_data *data)
@@ -2101,6 +2111,8 @@ static int bmp180_chip_config(struct bmp280_data *data)
 static const int bmp180_oversampling_temp_avail[] = { 1 };
 static const int bmp180_oversampling_press_avail[] = { 1, 2, 4, 8 };
 static const u8 bmp180_chip_ids[] = { BMP180_CHIP_ID };
+static const int bmp180_temp_coeffs[] = { 100, 1 };
+static const int bmp180_press_coeffs[] = { 1, 1000 };
 
 const struct bmp280_chip_info bmp180_chip_info = {
 	.id_reg = BMP280_REG_ID,
@@ -2121,6 +2133,11 @@ const struct bmp280_chip_info bmp180_chip_info = {
 		ARRAY_SIZE(bmp180_oversampling_press_avail),
 	.oversampling_press_default = BMP180_MEAS_PRESS_8X,
 
+	.temp_coeffs = bmp180_temp_coeffs,
+	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
+	.press_coeffs = bmp180_press_coeffs,
+	.press_coeffs_type = IIO_VAL_FRACTIONAL,
+
 	.chip_config = bmp180_chip_config,
 	.read_temp = bmp180_read_temp,
 	.read_press = bmp180_read_press,
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 7c30e4d523be..a3d2cd722760 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -446,10 +446,17 @@ struct bmp280_chip_info {
 	int num_sampling_freq_avail;
 	int sampling_freq_default;
 
+	const int *temp_coeffs;
+	const int temp_coeffs_type;
+	const int *press_coeffs;
+	const int press_coeffs_type;
+	const int *humid_coeffs;
+	const int humid_coeffs_type;
+
 	int (*chip_config)(struct bmp280_data *data);
-	int (*read_temp)(struct bmp280_data *data, int *val, int *val2);
-	int (*read_press)(struct bmp280_data *data, int *val, int *val2);
-	int (*read_humid)(struct bmp280_data *data, int *val, int *val2);
+	int (*read_temp)(struct bmp280_data *data, s32 *adc_temp);
+	int (*read_press)(struct bmp280_data *data, u32 *adc_press);
+	int (*read_humid)(struct bmp280_data *data, u32 *adc_humidity);
 	int (*read_calib)(struct bmp280_data *data);
 	int (*preinit)(struct bmp280_data *data);
 };
-- 
2.25.1


