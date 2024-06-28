Return-Path: <linux-iio+bounces-7021-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6024791C49D
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 19:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B211C2295E
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 17:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68C31CCCBD;
	Fri, 28 Jun 2024 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnULClMO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C3E1CCCCA;
	Fri, 28 Jun 2024 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719595056; cv=none; b=niCNmWyAPCvrHQd+kQimbiTJ/eh4/+ddrMFa8Xt3QN5aEJAnAzbO6Bi9ZeOAVKytb6D+bTKwv5AKVWTu3P1wMUO8bxyYox7zKEgWyOPlak2VX2eO5Sj+gKa3WEXjVuEFKB8xju1IJKLemBNblceP+elJN6pK8e557gSNBSiv7aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719595056; c=relaxed/simple;
	bh=yGS3Agj9POTWHdCDbgo38B6B+1sdNemPdNZ8vEzqtuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YYKTdbI/Cp1R12sPaZkD6GVtS1hI0zfunnTZJu3f7T/P+wH6oUnqmIGjy5OdIVgdiO+44jF0UTla54W8AffTcvIsZEKmwHXMYMQw92T5IgsS6B/Bbz0j+lYqmdO8vHp0927F1UQ8V2KANoVN+wQ9T6p4zmJa1dSOZu92aTBLg7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnULClMO; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ec408c6d94so8639221fa.3;
        Fri, 28 Jun 2024 10:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719595052; x=1720199852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdzS7aqVNcdjuEcYN/jK1z91hBFL8clfhb/MAZxogZ4=;
        b=hnULClMOz3EucP/W1/SmGh+kurU0wBfxrzvzYUuVklIu8IigXjIfZwSNWdlxE9HBPX
         7fLaJZLn0s9OmDm1jIBIJhSNfSOKFC/W5KRkcJJ4irG4vEPaSd2LQVWja2KOmefhc75s
         pDqga79iIh5KE2ZwlxBm53mSjq4MODukd9z1Kqab9x/XIkk9FCdRriR/G/0KWFGD/P9J
         XJqeBU19mXm3dU58p6TyayZ30uDpJUcefQBpa+rmNqKvJYdxfQ9saHOlx3OuL3mKyD2Z
         jGln/V07hTGbK4WR2Lavg9J1wy08s5rVCm5BTNcdUaVT3dUzxP0ECtVDopaWoIWFpHu9
         LwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719595052; x=1720199852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdzS7aqVNcdjuEcYN/jK1z91hBFL8clfhb/MAZxogZ4=;
        b=nub8MLBHTriYv4Ya3CYeVauLAVVKLKjUxLO0U3NZNzdb0ax8ikrprITqIWNq9KTIno
         FEWlhu3sWByjUk28/0iFFA41XgN9UPpGcGMbcRXMDT3GzQJZ3s9rY7kyDy1jzodhxQ3i
         qFJlfz1ipomtCuxb0PaIuVocAvsj31QAGAHj8Wh4FsWd0ocO1zCO7Ubn7RBtm7YRIcNX
         V4COj10T7sfIGPyksWJyVTl/tqKMDrTshW2wBB343loZdI/k3ElM7jQuxY3ur46vQU8P
         xDYYoFlLgBiK5aaXBgfpXePbpcX9lZrP7wzoEOnJtkOJM+nbqGE+2tLFoVWM/KCVjmuQ
         snEw==
X-Forwarded-Encrypted: i=1; AJvYcCXAJSmCxDi0Vh7ifamj6cPtb1sxEHaR1dqLwaSqrkD3eVKujbZq5TUR+HozW1lkeREic8E5ufDVWrudpb6XD0cRp6vKIVG+jCtZ2W2VetYWPYc3H/cq8GKmldqmrHIfjYGt1VokIyF5
X-Gm-Message-State: AOJu0YzAmZfRAsH0NCVK/6SHV8RZijhHN4KlVAkjR4SYEAmPSOQwuGMO
	nRil4Hzxz/d6AwGulctMQ0d2P50O14eZMTq2BxRpHYpNnPW1jMkV
X-Google-Smtp-Source: AGHT+IGVcC95hb+GNLs90ZyVv9iQpLl9y0wSVWxqDoTHeURwDlR2JnxHcFi2ytKqgT6acI2r7oi6LA==
X-Received: by 2002:a05:651c:2119:b0:2ec:681b:5b50 with SMTP id 38308e7fff4ca-2ec681b5f72mr113421611fa.11.1719595052105;
        Fri, 28 Jun 2024 10:17:32 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:b996:e85b:4fbf:5c89])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58612c838casm1271039a12.4.2024.06.28.10.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 10:17:31 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: petre.rodan@subdimension.ro,
	mazziesaccount@gmail.com,
	ak@it-klinger.de,
	vassilisamir@gmail.com,
	ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org,
	tgamblin@baylibre.com,
	ajarizzo@gmail.com,
	phil@raspberrypi.com,
	579lpy@gmail.com,
	andriy.shevchenko@linux.intel.com,
	semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 1/3] iio: pressure: bmp280: Generalize read_*() functions
Date: Fri, 28 Jun 2024 19:17:24 +0200
Message-Id: <20240628171726.124852-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240628171726.124852-1-vassilisamir@gmail.com>
References: <20240628171726.124852-1-vassilisamir@gmail.com>
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
 drivers/iio/pressure/bmp280-core.c | 168 +++++++++++++++++------------
 drivers/iio/pressure/bmp280.h      |  13 ++-
 2 files changed, 108 insertions(+), 73 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 49081b729618..9ff26a8e85d3 100644
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
-
-	*val = comp_press;
-	*val2 = 256000;
+	*comp_press = bmp280_compensate_press(data, adc_press, t_fine);
 
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
-
-	*val = comp_humidity * 1000 / 1024;
+	*comp_humidity = bme280_compensate_humidity(data, adc_humidity, t_fine);
 
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
-
-	*val = comp_press;
-	*val2 = 100000;
+	*comp_press = bmp380_compensate_press(data, adc_press, t_fine);
 
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
@@ -1323,6 +1346,11 @@ const struct bmp280_chip_info bmp380_chip_info = {
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
@@ -1443,9 +1471,9 @@ static int bmp580_nvm_operation(struct bmp280_data *data, bool is_write)
  * for what is expected on IIO ABI.
  */
 
-static int bmp580_read_temp(struct bmp280_data *data, int *val, int *val2)
+static int bmp580_read_temp(struct bmp280_data *data, s32 *raw_temp)
 {
-	s32 raw_temp;
+	s32 value_temp;
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB, data->buf,
@@ -1455,25 +1483,19 @@ static int bmp580_read_temp(struct bmp280_data *data, int *val, int *val2)
 		return ret;
 	}
 
-	raw_temp = get_unaligned_le24(data->buf);
-	if (raw_temp == BMP580_TEMP_SKIPPED) {
+	value_temp = get_unaligned_le24(data->buf);
+	if (value_temp == BMP580_TEMP_SKIPPED) {
 		dev_err(data->dev, "reading temperature skipped\n");
 		return -EIO;
 	}
+	*raw_temp = sign_extend32(value_temp, 23);
 
-	/*
-	 * Temperature is returned in Celsius degrees in fractional
-	 * form down 2^16. We rescale by x1000 to return millidegrees
-	 * Celsius to respect IIO ABI.
-	 */
-	raw_temp = sign_extend32(raw_temp, 23);
-	*val = ((s64)raw_temp * 1000) / (1 << 16);
-	return IIO_VAL_INT;
+	return 0;
 }
 
-static int bmp580_read_press(struct bmp280_data *data, int *val, int *val2)
+static int bmp580_read_press(struct bmp280_data *data, u32 *raw_press)
 {
-	u32 raw_press;
+	u32 value_press;
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP580_REG_PRESS_XLSB, data->buf,
@@ -1483,18 +1505,14 @@ static int bmp580_read_press(struct bmp280_data *data, int *val, int *val2)
 		return ret;
 	}
 
-	raw_press = get_unaligned_le24(data->buf);
-	if (raw_press == BMP580_PRESS_SKIPPED) {
+	value_press = get_unaligned_le24(data->buf);
+	if (value_press == BMP580_PRESS_SKIPPED) {
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
+	*raw_press = value_press;
+
+	return 0;
 }
 
 static const int bmp580_odr_table[][2] = {
@@ -1830,6 +1848,9 @@ static int bmp580_chip_config(struct bmp280_data *data)
 
 static const int bmp580_oversampling_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
 static const u8 bmp580_chip_ids[] = { BMP580_CHIP_ID, BMP580_CHIP_ID_ALT };
+/* Instead of { 1000, 16 } we do this, to avoid overflow issues */
+static const int bmp580_temp_coeffs[] = { 125, 13 };
+static const int bmp580_press_coeffs[] = { 1, 64000};
 
 const struct bmp280_chip_info bmp580_chip_info = {
 	.id_reg = BMP580_REG_CHIP_ID,
@@ -1856,6 +1877,11 @@ const struct bmp280_chip_info bmp580_chip_info = {
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
@@ -2011,9 +2037,8 @@ static s32 bmp180_compensate_temp(struct bmp280_data *data, u32 adc_temp)
 	return (bmp180_calc_t_fine(data, adc_temp) + 8) / 16;
 }
 
-static int bmp180_read_temp(struct bmp280_data *data, int *val, int *val2)
+static int bmp180_read_temp(struct bmp280_data *data, s32 *comp_temp)
 {
-	s32 comp_temp;
 	u32 adc_temp;
 	int ret;
 
@@ -2021,10 +2046,9 @@ static int bmp180_read_temp(struct bmp280_data *data, int *val, int *val2)
 	if (ret)
 		return ret;
 
-	comp_temp = bmp180_compensate_temp(data, adc_temp);
+	*comp_temp = bmp180_compensate_temp(data, adc_temp);
 
-	*val = comp_temp * 100;
-	return IIO_VAL_INT;
+	return 0;
 }
 
 static int bmp180_read_press_adc(struct bmp280_data *data, u32 *adc_press)
@@ -2087,9 +2111,9 @@ static u32 bmp180_compensate_press(struct bmp280_data *data, u32 adc_press,
 	return p + ((x1 + x2 + 3791) >> 4);
 }
 
-static int bmp180_read_press(struct bmp280_data *data, int *val, int *val2)
+static int bmp180_read_press(struct bmp280_data *data, u32 *comp_press)
 {
-	u32 comp_press, adc_press;
+	u32 adc_press;
 	s32 t_fine;
 	int ret;
 
@@ -2101,12 +2125,9 @@ static int bmp180_read_press(struct bmp280_data *data, int *val, int *val2)
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
@@ -2117,6 +2138,8 @@ static int bmp180_chip_config(struct bmp280_data *data)
 static const int bmp180_oversampling_temp_avail[] = { 1 };
 static const int bmp180_oversampling_press_avail[] = { 1, 2, 4, 8 };
 static const u8 bmp180_chip_ids[] = { BMP180_CHIP_ID };
+static const int bmp180_temp_coeffs[] = { 100, 1 };
+static const int bmp180_press_coeffs[] = { 1, 1000 };
 
 const struct bmp280_chip_info bmp180_chip_info = {
 	.id_reg = BMP280_REG_ID,
@@ -2137,6 +2160,11 @@ const struct bmp280_chip_info bmp180_chip_info = {
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


