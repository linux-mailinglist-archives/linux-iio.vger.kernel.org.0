Return-Path: <linux-iio+bounces-5001-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E481D8C3921
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 01:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AF492816EC
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 23:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23FD5F873;
	Sun, 12 May 2024 23:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VC3ypKwM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B75D59173;
	Sun, 12 May 2024 23:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715555137; cv=none; b=T+6eHMAYI+yXDfU5byECBLS0e/qy3EyqBA/O3nq168vJAgsj2LSoN9zRQcLpWhIBOOVxuLZOt9XEVKa3ZuqXDY6if9YNNq+tXvGPjQNkeOKB8Eobf1PZJge7F8tuNZ6ukw+CA6VhOWzDovjleyJC112a57dCY1qDXT4f8O0NYDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715555137; c=relaxed/simple;
	bh=HcopHTpQQpzl+h/qyyUYoaVP95zpoq7JUG5up/je+10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y4FaIzP3BvdZ2T15vTUAPPErC/xJFQmjV1Z+EU9GTiuemVs20Hev/S3tzuWOyGkeJM6dNcTyNIB80KixsjdfI35KrvB1rfTRGUfkPU3HNZMwNIjJq2crEL07xJkBtll0O/fDpZeDcmw8UqLExzFBT63IlD2EdT+YsdPXSxFWJFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VC3ypKwM; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-34db6a29998so2966294f8f.0;
        Sun, 12 May 2024 16:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715555134; x=1716159934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85GY+ki2poAdYGoAml1173rDc9ko31HXORSz8tQErvA=;
        b=VC3ypKwMOZ5WrsMdmz37fUAVy5bP+nBTEux2mwtaSpqOKkj1+gm0YREjIwF0av9phO
         7MbCLZGdjc6i4BXZ0C8XnFxU1eczZKhkF/zdmRpONEb6myKLutMMywgtEF87KLlXO70K
         ptrQ0XrYaI4T1JiAhD2tPhkNpYNsaaPVumH62/XHkGkqsiAnNrBp4epRdgEoRxRFTFot
         fJeo8DdnyKe+ISXMI4sQtBhsVnSTy5d6eWYxwQjzIBmUOw/tHW5DhPbFQD7Xs6V7Y0JI
         qI9XsLu8VbAW90ZMl8ZbB7gC5yhxEZtS1RPnKIE3G+Hoa+x7cf8YweGDftXu6yOQHkBj
         qLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715555134; x=1716159934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85GY+ki2poAdYGoAml1173rDc9ko31HXORSz8tQErvA=;
        b=NDE1QYZb1JkDpvHvJvN89pmhgZxR+0JjDKdP2+j94M4ohPfw6P+rRDoA7aKeV460FK
         WrlG8HfOf0gkRNTeXb40UDRuvoItBrsSqaTdTD1FWakB/5cOJ6j2AJ+0/nw35e/2bhhd
         0KiUuGPmkVpQPqJnPXcYHVh8j4PiQLopS6b8AAdVJXpIEoVjlErKNkN2Q8Z/LL2qEG0y
         0dm00Jg4SLBYkuLzaO8U0XURWOBnQPinYe3yJrfMI9jn7Q4wYSc+3hZZNzYMArYcWcjn
         5eHFJdDhan9pzKagQnI+rOtXS54SHG+XFJx9OEEbgiv7hH/KDQ7aPK3ab8hPTCZ6x38a
         2poA==
X-Forwarded-Encrypted: i=1; AJvYcCVGcme1voihSIq7+P453UkYx+qK0Uaz7gz1cGi6D+ooLqyGpcKLdWCrnCteskK5cnjMmr+a5r8DmqoTTKqoiVUqlajZtOVhASkmZgi25mbn4/egwLxBR7L/ZDKa551uyO7XRL9Vx+T3
X-Gm-Message-State: AOJu0YwFfDxVsFDmO2W1ix6Zhku511mOFeOKZ6HieP1O80mpGLyMAlVm
	b90TkK6SGa7qwZ6k1lmxPTzIZjvVIKISeNKb6s6bCaoOVt8Wp6Fs
X-Google-Smtp-Source: AGHT+IGsEEWXNOob6LjScZvOhNBj/l+0cjguKpuxj/LFtcLARk3xyOx7gqACtZOte2cpz0U/r3VggQ==
X-Received: by 2002:a5d:4e92:0:b0:34c:d2c8:70a5 with SMTP id ffacd0b85a97d-3504aa69faemr5843101f8f.71.1715555133566;
        Sun, 12 May 2024 16:05:33 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:ce14:864c:436e:5c6d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee92bcsm136720935e9.36.2024.05.12.16.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 16:05:33 -0700 (PDT)
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
Subject: [PATCH v7 3/5] iio: pressure: bmp280: Generalize read_{temp,press,humid}() functions
Date: Mon, 13 May 2024 01:05:22 +0200
Message-Id: <20240512230524.53990-4-vassilisamir@gmail.com>
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

Add the coefficients for the IIO standard units and the IIO value
inside the chip_info structure.

Move the calculations for the IIO unit compatibility from inside the
read_{temp,press,humid}() functions and move them to the general
read_raw() function.

In this way, all the data for the calculation of the value are
located in the chip_info structure of the respective sensor.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 164 +++++++++++++++++------------
 drivers/iio/pressure/bmp280.h      |  13 ++-
 2 files changed, 104 insertions(+), 73 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 212583d35350..854f699fd724 100644
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
 
@@ -456,16 +454,15 @@ static int bmp280_read_temp(struct bmp280_data *data,
 	if (ret)
 		return ret;
 
-	comp_temp = bmp280_compensate_temp(data, adc_temp);
+	*comp_temp = bmp280_compensate_temp(data, adc_temp);
 
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
@@ -476,17 +473,13 @@ static int bmp280_read_press(struct bmp280_data *data,
 	if (ret)
 		return ret;
 
-	comp_press = bmp280_compensate_press(data, adc_press, t_fine);
+	*comp_press = bmp280_compensate_press(data, adc_press, t_fine);
 
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
@@ -499,11 +492,9 @@ static int bme280_read_humid(struct bmp280_data *data, int *val, int *val2)
 	if (ret)
 		return ret;
 
-	comp_humidity = bme280_compensate_humidity(data, adc_humidity, t_fine);
+	*comp_humidity = bme280_compensate_humidity(data, adc_humidity, t_fine);
 
-	*val = comp_humidity * 1000 / 1024;
-
-	return IIO_VAL_INT;
+	return 0;
 }
 
 static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
@@ -511,6 +502,8 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 				int *val, int *val2, long mask)
 {
 	struct bmp280_data *data = iio_priv(indio_dev);
+	int chan_value;
+	int ret;
 
 	guard(mutex)(&data->lock);
 
@@ -518,11 +511,29 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
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
@@ -822,6 +833,8 @@ static int bmp280_chip_config(struct bmp280_data *data)
 
 static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
 static const u8 bmp280_chip_ids[] = { BMP280_CHIP_ID };
+static const int bmp280_temp_coeffs[] = { 10, 1 };
+static const int bmp280_press_coeffs[] = { 1, 256000 };
 
 const struct bmp280_chip_info bmp280_chip_info = {
 	.id_reg = BMP280_REG_ID,
@@ -850,6 +863,11 @@ const struct bmp280_chip_info bmp280_chip_info = {
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
@@ -877,6 +895,7 @@ static int bme280_chip_config(struct bmp280_data *data)
 }
 
 static const u8 bme280_chip_ids[] = { BME280_CHIP_ID };
+static const int bme280_humid_coeffs[] = { 1000, 1024 };
 
 const struct bmp280_chip_info bme280_chip_info = {
 	.id_reg = BMP280_REG_ID,
@@ -899,6 +918,13 @@ const struct bmp280_chip_info bme280_chip_info = {
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
@@ -1091,9 +1117,8 @@ static u32 bmp380_compensate_press(struct bmp280_data *data,
 	return comp_press;
 }
 
-static int bmp380_read_temp(struct bmp280_data *data, int *val, int *val2)
+static int bmp380_read_temp(struct bmp280_data *data, s32 *comp_temp)
 {
-	s32 comp_temp;
 	u32 adc_temp;
 	int ret;
 
@@ -1101,15 +1126,14 @@ static int bmp380_read_temp(struct bmp280_data *data, int *val, int *val2)
 	if (ret)
 		return ret;
 
-	comp_temp = bmp380_compensate_temp(data, adc_temp);
+	*comp_temp = bmp380_compensate_temp(data, adc_temp);
 
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
@@ -1120,12 +1144,9 @@ static int bmp380_read_press(struct bmp280_data *data, int *val, int *val2)
 	if (ret)
 		return ret;
 
-	comp_press = bmp380_compensate_press(data, adc_press, t_fine);
+	*comp_press = bmp380_compensate_press(data, adc_press, t_fine);
 
-	*val = comp_press;
-	*val2 = 100000;
-
-	return IIO_VAL_FRACTIONAL;
+	return 0;
 }
 
 static int bmp380_read_calib(struct bmp280_data *data)
@@ -1296,6 +1317,8 @@ static int bmp380_chip_config(struct bmp280_data *data)
 static const int bmp380_oversampling_avail[] = { 1, 2, 4, 8, 16, 32 };
 static const int bmp380_iir_filter_coeffs_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128};
 static const u8 bmp380_chip_ids[] = { BMP380_CHIP_ID, BMP390_CHIP_ID };
+static const int bmp380_temp_coeffs[] = { 10, 1 };
+static const int bmp380_press_coeffs[] = { 1, 100000 };
 
 const struct bmp280_chip_info bmp380_chip_info = {
 	.id_reg = BMP380_REG_ID,
@@ -1322,6 +1345,11 @@ const struct bmp280_chip_info bmp380_chip_info = {
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
@@ -1442,9 +1470,8 @@ static int bmp580_nvm_operation(struct bmp280_data *data, bool is_write)
  * for what is expected on IIO ABI.
  */
 
-static int bmp580_read_temp(struct bmp280_data *data, int *val, int *val2)
+static int bmp580_read_temp(struct bmp280_data *data, s32 *raw_temp)
 {
-	s32 raw_temp;
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB, data->buf,
@@ -1454,25 +1481,17 @@ static int bmp580_read_temp(struct bmp280_data *data, int *val, int *val2)
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
@@ -1482,18 +1501,13 @@ static int bmp580_read_press(struct bmp280_data *data, int *val, int *val2)
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
@@ -1828,6 +1842,8 @@ static int bmp580_chip_config(struct bmp280_data *data)
 
 static const int bmp580_oversampling_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
 static const u8 bmp580_chip_ids[] = { BMP580_CHIP_ID, BMP580_CHIP_ID_ALT };
+static const int bmp580_temp_coeffs[] = { 1000, 16 };
+static const int bmp580_press_coeffs[] = { 1, 64000};
 
 const struct bmp280_chip_info bmp580_chip_info = {
 	.id_reg = BMP580_REG_CHIP_ID,
@@ -1854,6 +1870,11 @@ const struct bmp280_chip_info bmp580_chip_info = {
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
@@ -2009,9 +2030,8 @@ static s32 bmp180_compensate_temp(struct bmp280_data *data, u32 adc_temp)
 	return (bmp180_calc_t_fine(data, adc_temp) + 8) / 16;
 }
 
-static int bmp180_read_temp(struct bmp280_data *data, int *val, int *val2)
+static int bmp180_read_temp(struct bmp280_data *data, s32 *comp_temp)
 {
-	s32 comp_temp;
 	u32 adc_temp;
 	int ret;
 
@@ -2019,10 +2039,9 @@ static int bmp180_read_temp(struct bmp280_data *data, int *val, int *val2)
 	if (ret)
 		return ret;
 
-	comp_temp = bmp180_compensate_temp(data, adc_temp);
+	*comp_temp = bmp180_compensate_temp(data, adc_temp);
 
-	*val = comp_temp * 100;
-	return IIO_VAL_INT;
+	return 0;
 }
 
 static int bmp180_read_press_adc(struct bmp280_data *data, u32 *adc_press)
@@ -2085,10 +2104,11 @@ static u32 bmp180_compensate_press(struct bmp280_data *data, u32 adc_press,
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
@@ -2098,12 +2118,9 @@ static int bmp180_read_press(struct bmp280_data *data, int *val, int *val2)
 	if (ret)
 		return ret;
 
-	comp_press = bmp180_compensate_press(data, adc_press, t_fine);
-
-	*val = comp_press;
-	*val2 = 1000;
+	*comp_press = bmp180_compensate_press(data, adc_press, t_fine);
 
-	return IIO_VAL_FRACTIONAL;
+	return 0;
 }
 
 static int bmp180_chip_config(struct bmp280_data *data)
@@ -2114,6 +2131,8 @@ static int bmp180_chip_config(struct bmp280_data *data)
 static const int bmp180_oversampling_temp_avail[] = { 1 };
 static const int bmp180_oversampling_press_avail[] = { 1, 2, 4, 8 };
 static const u8 bmp180_chip_ids[] = { BMP180_CHIP_ID };
+static const int bmp180_temp_coeffs[] = { 100, 1 };
+static const int bmp180_press_coeffs[] = { 1, 1000 };
 
 const struct bmp280_chip_info bmp180_chip_info = {
 	.id_reg = BMP280_REG_ID,
@@ -2134,6 +2153,11 @@ const struct bmp280_chip_info bmp180_chip_info = {
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
index 777b33ce1e70..69b74a238426 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -445,10 +445,17 @@ struct bmp280_chip_info {
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


