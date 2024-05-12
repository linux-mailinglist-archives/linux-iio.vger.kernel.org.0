Return-Path: <linux-iio+bounces-4999-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4228C391D
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 01:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1541C20CD8
	for <lists+linux-iio@lfdr.de>; Sun, 12 May 2024 23:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F7D5A11F;
	Sun, 12 May 2024 23:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1nTvLI0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFC928F5;
	Sun, 12 May 2024 23:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715555135; cv=none; b=ICsV76FKqRiPvkqqkRz5JTdht5BhPu+nqcEP12IIa4kk6Ds2EioA7a9J5gMoWkGwk2+G4R001w/L4axqHXIa1338Do5a92mEqh0Cpov/YECiDUTaz/7K24KrgnqgON/798bfCbmESfR3TDYqlYaHKdm91ew4P3QbBp+xF7o8HL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715555135; c=relaxed/simple;
	bh=9H9GPQ7tP0vin8zHARgSizlxH9s5eyVXtjlSh6XfJpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2X4CJL929w68BYZhDGyZ5kxASzyLxKzAVBXoyFt1bGXa9etDl2dJIOOaojogN95V6zWymt9Lr9eoSzBGfz/UUNLkeJWApLioGNgudm5LbmdJfBEQ98W1GaGdSvyxpV5dONpy0Ojc8WUKwL9jS5HBpl9GZLvpGrYKR6CvdvChxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1nTvLI0; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41c7ac71996so25563995e9.3;
        Sun, 12 May 2024 16:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715555131; x=1716159931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugEre8Mze8222LG+qCM2SvtNLqBTMnKS8It5A7/7cew=;
        b=S1nTvLI04vCEBFoPls9l7Kd9PxpHDz5pZsC+VtWf6M6ZpHknL2Nlb5hxvHv/LbGyhM
         LvR3hMNLlwPIwnz5auTwGjCPkjDsAinyz8JV5Z2mUFK6mfR0LtibdgXIKpQh2BG88uWq
         rnAw/RZEBBnI3ocTUCxYKCtYEsVWChH+0W4mjJxji2opt1VBwcYsHWgJf2f+6ULGYAC/
         H9RysL8Oh1fDOS58Gn3Pf2uINUxv+UjtVo0cT2/TTjjuWf62RArXX/q8l0k8krnAMhdK
         b2DH4oxtizynlU8tAuv6S1CzxMc7N0QyMZc8LC410KdbE/mgfKEiI0rkr1pjtNgxatq7
         SxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715555131; x=1716159931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugEre8Mze8222LG+qCM2SvtNLqBTMnKS8It5A7/7cew=;
        b=Ddo36OuaA8UuIsewNybASZ3Q/i+K3O/hX2seEy3P5q9XjPlMtrYt/wXP3BYjYeTBr/
         GbVwl2nk6La1C+R7avaJKrdpjwXvxSJnSu4Ykzdh2fA66a+9XgrmnBjJSIifT6XDOc0h
         ujPTRy24IzGUGo8CWN2dVsj6xtx6uby1qiI+6Zb5TCOC3Pnl7zy1V3OK9bkQXd/a9Iec
         6gshYbUMyyClG+Dju1zSLdIGtl944S09JBG00WpNXk3fn4c+r7VXl6KlqxYLQT1caTog
         Mi5mhPnXvBTT3T24rbaldIWaNfTmvP+kvlfX4mV2wxTZRzc9oMAigiM/9+wWwNiwvCEZ
         oHXg==
X-Forwarded-Encrypted: i=1; AJvYcCVMpnvEAwVPFnDp39GMp2wxPe1u5Yk1FD5jV2IEiE+qKz9SKE1pjxXrPKFsGIkUC/nqcTv7L7aEXdhhiNERqE6uEYmtd12a0W86Zgp+qc6G/1aEa1zBtiHE9lnhMnrttswD/NjsN7Y+
X-Gm-Message-State: AOJu0YwM7gMyYJ9OqNbNchEkKBibbdvSPtyyPK4JRKmqgBlU48tzCrlb
	Zx/9AHkfRVSatYdHad5QDRyXx2fVBipKLFXnxB6f+VDrhEatbtoq
X-Google-Smtp-Source: AGHT+IHr/glalOcXV+QMjEoqEZAMZ/9anNwdrjlM4o9ZcK4jLgro1ZJmKPmvSKBLhP18nzJJxKxZkQ==
X-Received: by 2002:a05:600c:5250:b0:420:1670:d5fb with SMTP id 5b1f17b1804b1-4201670d916mr7612055e9.10.1715555131139;
        Sun, 12 May 2024 16:05:31 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:ce14:864c:436e:5c6d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee92bcsm136720935e9.36.2024.05.12.16.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 16:05:30 -0700 (PDT)
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
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v7 1/5] iio: pressure: bmp280: Refactorize reading functions
Date: Mon, 13 May 2024 01:05:20 +0200
Message-Id: <20240512230524.53990-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240512230524.53990-1-vassilisamir@gmail.com>
References: <20240512230524.53990-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For BMP18x, BMP28x, BME280, BMP38x the reading of the pressure
value requires an update of the t_fine variable which happens
through reading the temperature value.

So all the bmpxxx_read_press() functions of the above sensors
are internally calling the equivalent bmpxxx_read_temp() function
in order to update the t_fine value. By just looking at the code
this functionality is a bit hidden and is not easy to understand
why those channels are not independent.

This commit tries to clear these things a bit by splitting the
bmpxxx_{read/compensate}_{temp/press/humid}() to the following:

i. bmpxxx_read_{temp/press/humid}_adc(): read the raw value from
the sensor.

ii. bmpxx_calc_t_fine(): calculate the t_fine variable.

iii. bmpxxx_get_t_fine(): get the t_fine variable.

iv. bmpxxx_compensate_{temp/press/humid}(): compensate the adc
values and return the calculated value.

v. bmpxxx_read_{temp/press/humid}(): combine calls of the
aforementioned functions to return the requested value.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 352 ++++++++++++++++++-----------
 drivers/iio/pressure/bmp280.h      |   6 -
 2 files changed, 224 insertions(+), 134 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index c99635a442f8..58f3aaaa1efe 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -282,6 +282,28 @@ static int bme280_read_calib(struct bmp280_data *data)
 	return 0;
 }
 
+static int bme280_read_humid_adc(struct bmp280_data *data, u16 *adc_humidity)
+{
+	u16 value_humidity;
+	int ret;
+
+	ret = regmap_bulk_read(data->regmap, BME280_REG_HUMIDITY_MSB,
+			       &data->be16, sizeof(data->be16));
+	if (ret) {
+		dev_err(data->dev, "failed to read humidity\n");
+		return ret;
+	}
+
+	value_humidity = be16_to_cpu(data->be16);
+	if (value_humidity == BMP280_HUMIDITY_SKIPPED) {
+		dev_err(data->dev, "reading humidity skipped\n");
+		return -EIO;
+	}
+	*adc_humidity = value_humidity;
+
+	return 0;
+}
+
 /*
  * Returns humidity in percent, resolution is 0.01 percent. Output value of
  * "47445" represents 47445/1024 = 46.333 %RH.
@@ -289,12 +311,12 @@ static int bme280_read_calib(struct bmp280_data *data)
  * Taken from BME280 datasheet, Section 4.2.3, "Compensation formula".
  */
 static u32 bme280_compensate_humidity(struct bmp280_data *data,
-				      u16 adc_humidity)
+				      u16 adc_humidity, s32 t_fine)
 {
 	struct bmp280_calib *calib = &data->calib.bmp280;
 	s32 var;
 
-	var = data->t_fine - (s32)76800;
+	var = t_fine - (s32)76800;
 	var = (((((s32)adc_humidity << 14) - (calib->H4 << 20) - (calib->H5 * var))
 		+ (s32)16384) >> 15) * (((((((var * calib->H6) >> 10)
 		* (((var * (s32)calib->H3) >> 11) + (s32)32768)) >> 10)
@@ -306,6 +328,28 @@ static u32 bme280_compensate_humidity(struct bmp280_data *data,
 	return var >> 12;
 }
 
+static int bmp280_read_temp_adc(struct bmp280_data *data, u32 *adc_temp)
+{
+	u32 value_temp;
+	int ret;
+
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
+			       data->buf, sizeof(data->buf));
+	if (ret) {
+		dev_err(data->dev, "failed to read temperature\n");
+		return ret;
+	}
+
+	value_temp = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(data->buf));
+	if (value_temp == BMP280_TEMP_SKIPPED) {
+		dev_err(data->dev, "reading temperature skipped\n");
+		return -EIO;
+	}
+	*adc_temp = value_temp;
+
+	return 0;
+}
+
 /*
  * Returns temperature in DegC, resolution is 0.01 DegC.  Output value of
  * "5123" equals 51.23 DegC.  t_fine carries fine temperature as global
@@ -313,8 +357,7 @@ static u32 bme280_compensate_humidity(struct bmp280_data *data,
  *
  * Taken from datasheet, Section 3.11.3, "Compensation formula".
  */
-static s32 bmp280_compensate_temp(struct bmp280_data *data,
-				  u32 adc_temp)
+static s32 bmp280_calc_t_fine(struct bmp280_data *data, u32 adc_temp)
 {
 	struct bmp280_calib *calib = &data->calib.bmp280;
 	s32 var1, var2;
@@ -324,9 +367,48 @@ static s32 bmp280_compensate_temp(struct bmp280_data *data,
 	var2 = (((((((s32)adc_temp) >> 4) - ((s32)calib->T1)) *
 		  ((((s32)adc_temp >> 4) - ((s32)calib->T1))) >> 12) *
 		((s32)calib->T3))) >> 14;
-	data->t_fine = var1 + var2;
+	return var1 + var2; /* t_fine = var1 + var2 */
+}
+
+static int bmp280_get_t_fine(struct bmp280_data *data, s32 *t_fine)
+{
+	u32 adc_temp;
+	int ret;
+
+	ret = bmp280_read_temp_adc(data, &adc_temp);
+	if (ret)
+		return ret;
+
+	*t_fine = bmp280_calc_t_fine(data, adc_temp);
+
+	return 0;
+}
+
+static s32 bmp280_compensate_temp(struct bmp280_data *data, u32 adc_temp)
+{
+	return (bmp280_calc_t_fine(data, adc_temp) * 5 + 128) / 256;
+}
+
+static int bmp280_read_press_adc(struct bmp280_data *data, u32 *adc_press)
+{
+	u32 value_press;
+	int ret;
+
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
+			       data->buf, sizeof(data->buf));
+	if (ret) {
+		dev_err(data->dev, "failed to read pressure\n");
+		return ret;
+	}
+
+	value_press = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(data->buf));
+	if (value_press == BMP280_PRESS_SKIPPED) {
+		dev_err(data->dev, "reading pressure skipped\n");
+		return -EIO;
+	}
+	*adc_press = value_press;
 
-	return (data->t_fine * 5 + 128) >> 8;
+	return 0;
 }
 
 /*
@@ -337,12 +419,12 @@ static s32 bmp280_compensate_temp(struct bmp280_data *data,
  * Taken from datasheet, Section 3.11.3, "Compensation formula".
  */
 static u32 bmp280_compensate_press(struct bmp280_data *data,
-				   u32 adc_press)
+				   u32 adc_press, s32 t_fine)
 {
 	struct bmp280_calib *calib = &data->calib.bmp280;
 	s64 var1, var2, p;
 
-	var1 = ((s64)data->t_fine) - 128000;
+	var1 = ((s64)t_fine) - 128000;
 	var2 = var1 * var1 * (s64)calib->P6;
 	var2 += (var1 * (s64)calib->P5) << 17;
 	var2 += ((s64)calib->P4) << 35;
@@ -369,58 +451,31 @@ static int bmp280_read_temp(struct bmp280_data *data,
 	u32 adc_temp;
 	int ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
-			       data->buf, sizeof(data->buf));
-	if (ret) {
-		dev_err(data->dev, "failed to read temperature\n");
+	ret = bmp280_read_temp_adc(data, &adc_temp);
+	if (ret)
 		return ret;
-	}
 
-	adc_temp = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(data->buf));
-	if (adc_temp == BMP280_TEMP_SKIPPED) {
-		/* reading was skipped */
-		dev_err(data->dev, "reading temperature skipped\n");
-		return -EIO;
-	}
 	comp_temp = bmp280_compensate_temp(data, adc_temp);
 
-	/*
-	 * val might be NULL if we're called by the read_press routine,
-	 * who only cares about the carry over t_fine value.
-	 */
-	if (val) {
-		*val = comp_temp * 10;
-		return IIO_VAL_INT;
-	}
-
-	return 0;
+	*val = comp_temp * 10;
+	return IIO_VAL_INT;
 }
 
 static int bmp280_read_press(struct bmp280_data *data,
 			     int *val, int *val2)
 {
-	u32 comp_press, adc_press;
+	u32 comp_press, adc_press, t_fine;
 	int ret;
 
-	/* Read and compensate temperature so we get a reading of t_fine. */
-	ret = bmp280_read_temp(data, NULL, NULL);
+	ret = bmp280_get_t_fine(data, &t_fine);
 	if (ret)
 		return ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
-			       data->buf, sizeof(data->buf));
-	if (ret) {
-		dev_err(data->dev, "failed to read pressure\n");
+	ret = bmp280_read_press_adc(data, &adc_press);
+	if (ret)
 		return ret;
-	}
 
-	adc_press = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(data->buf));
-	if (adc_press == BMP280_PRESS_SKIPPED) {
-		/* reading was skipped */
-		dev_err(data->dev, "reading pressure skipped\n");
-		return -EIO;
-	}
-	comp_press = bmp280_compensate_press(data, adc_press);
+	comp_press = bmp280_compensate_press(data, adc_press, t_fine);
 
 	*val = comp_press;
 	*val2 = 256000;
@@ -432,27 +487,18 @@ static int bme280_read_humid(struct bmp280_data *data, int *val, int *val2)
 {
 	u32 comp_humidity;
 	u16 adc_humidity;
+	s32 t_fine;
 	int ret;
 
-	/* Read and compensate temperature so we get a reading of t_fine. */
-	ret = bmp280_read_temp(data, NULL, NULL);
+	ret = bmp280_get_t_fine(data, &t_fine);
 	if (ret)
 		return ret;
 
-	ret = regmap_bulk_read(data->regmap, BME280_REG_HUMIDITY_MSB,
-			       &data->be16, sizeof(data->be16));
-	if (ret) {
-		dev_err(data->dev, "failed to read humidity\n");
+	ret = bme280_read_humid_adc(data, &adc_humidity);
+	if (ret)
 		return ret;
-	}
 
-	adc_humidity = be16_to_cpu(data->be16);
-	if (adc_humidity == BMP280_HUMIDITY_SKIPPED) {
-		/* reading was skipped */
-		dev_err(data->dev, "reading humidity skipped\n");
-		return -EIO;
-	}
-	comp_humidity = bme280_compensate_humidity(data, adc_humidity);
+	comp_humidity = bme280_compensate_humidity(data, adc_humidity, t_fine);
 
 	*val = comp_humidity * 1000 / 1024;
 
@@ -923,6 +969,28 @@ static int bmp380_cmd(struct bmp280_data *data, u8 cmd)
 	return 0;
 }
 
+static int bmp380_read_temp_adc(struct bmp280_data *data, u32 *adc_temp)
+{
+	u32 value_temp;
+	int ret;
+
+	ret = regmap_bulk_read(data->regmap, BMP380_REG_TEMP_XLSB,
+			       data->buf, sizeof(data->buf));
+	if (ret) {
+		dev_err(data->dev, "failed to read temperature\n");
+		return ret;
+	}
+
+	value_temp = get_unaligned_le24(data->buf);
+	if (value_temp == BMP380_TEMP_SKIPPED) {
+		dev_err(data->dev, "reading temperature skipped\n");
+		return -EIO;
+	}
+	*adc_temp = value_temp;
+
+	return 0;
+}
+
 /*
  * Returns temperature in Celsius degrees, resolution is 0.01º C. Output value
  * of "5123" equals 51.2º C. t_fine carries fine temperature as global value.
@@ -930,9 +998,9 @@ static int bmp380_cmd(struct bmp280_data *data, u8 cmd)
  * Taken from datasheet, Section Appendix 9, "Compensation formula" and repo
  * https://github.com/BoschSensortec/BMP3-Sensor-API.
  */
-static s32 bmp380_compensate_temp(struct bmp280_data *data, u32 adc_temp)
+static s32 bmp380_calc_t_fine(struct bmp280_data *data, u32 adc_temp)
 {
-	s64 var1, var2, var3, var4, var5, var6, comp_temp;
+	s64 var1, var2, var3, var4, var5, var6;
 	struct bmp380_calib *calib = &data->calib.bmp380;
 
 	var1 = ((s64) adc_temp) - (((s64) calib->T1) << 8);
@@ -941,13 +1009,57 @@ static s32 bmp380_compensate_temp(struct bmp280_data *data, u32 adc_temp)
 	var4 = var3 * ((s64) calib->T3);
 	var5 = (var2 << 18) + var4;
 	var6 = var5 >> 32;
-	data->t_fine = (s32) var6;
+	return (s32)var6; /* t_fine = var6 */
+}
+
+static int bmp380_get_t_fine(struct bmp280_data *data, s32 *t_fine)
+{
+	s32 adc_temp;
+	int ret;
+
+	ret = bmp380_read_temp_adc(data, &adc_temp);
+	if (ret)
+		return ret;
+
+	*t_fine = bmp380_calc_t_fine(data, adc_temp);
+
+	return 0;
+}
+
+static int bmp380_compensate_temp(struct bmp280_data *data, u32 adc_temp)
+{
+	s64 comp_temp;
+	s32 var6;
+
+	var6 = bmp380_calc_t_fine(data, adc_temp);
 	comp_temp = (var6 * 25) >> 14;
 
 	comp_temp = clamp_val(comp_temp, BMP380_MIN_TEMP, BMP380_MAX_TEMP);
 	return (s32) comp_temp;
 }
 
+static int bmp380_read_press_adc(struct bmp280_data *data, u32 *adc_press)
+{
+	u32 value_press;
+	int ret;
+
+	ret = regmap_bulk_read(data->regmap, BMP380_REG_PRESS_XLSB,
+			       data->buf, sizeof(data->buf));
+	if (ret) {
+		dev_err(data->dev, "failed to read pressure\n");
+		return ret;
+	}
+
+	value_press = get_unaligned_le24(data->buf);
+	if (value_press == BMP380_PRESS_SKIPPED) {
+		dev_err(data->dev, "reading pressure skipped\n");
+		return -EIO;
+	}
+	*adc_press = value_press;
+
+	return 0;
+}
+
 /*
  * Returns pressure in Pa as an unsigned 32 bit integer in fractional Pascal.
  * Output value of "9528709" represents 9528709/100 = 95287.09 Pa = 952.8709 hPa.
@@ -955,27 +1067,28 @@ static s32 bmp380_compensate_temp(struct bmp280_data *data, u32 adc_temp)
  * Taken from datasheet, Section 9.3. "Pressure compensation" and repository
  * https://github.com/BoschSensortec/BMP3-Sensor-API.
  */
-static u32 bmp380_compensate_press(struct bmp280_data *data, u32 adc_press)
+static u32 bmp380_compensate_press(struct bmp280_data *data,
+				   u32 adc_press, s32 t_fine)
 {
 	s64 var1, var2, var3, var4, var5, var6, offset, sensitivity;
 	struct bmp380_calib *calib = &data->calib.bmp380;
 	u32 comp_press;
 
-	var1 = (s64)data->t_fine * (s64)data->t_fine;
+	var1 = (s64)t_fine * (s64)t_fine;
 	var2 = var1 >> 6;
-	var3 = (var2 * ((s64) data->t_fine)) >> 8;
+	var3 = (var2 * ((s64)t_fine)) >> 8;
 	var4 = ((s64)calib->P8 * var3) >> 5;
 	var5 = ((s64)calib->P7 * var1) << 4;
-	var6 = ((s64)calib->P6 * (s64)data->t_fine) << 22;
+	var6 = ((s64)calib->P6 * (s64)t_fine) << 22;
 	offset = ((s64)calib->P5 << 47) + var4 + var5 + var6;
 	var2 = ((s64)calib->P4 * var3) >> 5;
 	var4 = ((s64)calib->P3 * var1) << 2;
 	var5 = ((s64)calib->P2 - ((s64)1 << 14)) *
-	       ((s64)data->t_fine << 21);
+	       ((s64)t_fine << 21);
 	sensitivity = (((s64) calib->P1 - ((s64) 1 << 14)) << 46) +
 			var2 + var4 + var5;
 	var1 = (sensitivity >> 24) * (s64)adc_press;
-	var2 = (s64)calib->P10 * (s64)data->t_fine;
+	var2 = (s64)calib->P10 * (s64)t_fine;
 	var3 = var2 + ((s64)calib->P9 << 16);
 	var4 = (var3 * (s64)adc_press) >> 13;
 
@@ -1001,59 +1114,32 @@ static int bmp380_read_temp(struct bmp280_data *data, int *val, int *val2)
 	u32 adc_temp;
 	int ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP380_REG_TEMP_XLSB,
-			       data->buf, sizeof(data->buf));
-	if (ret) {
-		dev_err(data->dev, "failed to read temperature\n");
+	ret = bmp380_read_temp_adc(data, &adc_temp);
+	if (ret)
 		return ret;
-	}
 
-	adc_temp = get_unaligned_le24(data->buf);
-	if (adc_temp == BMP380_TEMP_SKIPPED) {
-		dev_err(data->dev, "reading temperature skipped\n");
-		return -EIO;
-	}
 	comp_temp = bmp380_compensate_temp(data, adc_temp);
 
-	/*
-	 * Val might be NULL if we're called by the read_press routine,
-	 * who only cares about the carry over t_fine value.
-	 */
-	if (val) {
-		/* IIO reports temperatures in milli Celsius */
-		*val = comp_temp * 10;
-		return IIO_VAL_INT;
-	}
-
-	return 0;
+	*val = comp_temp * 10;
+	return IIO_VAL_INT;
 }
 
 static int bmp380_read_press(struct bmp280_data *data, int *val, int *val2)
 {
-	u32 adc_press, comp_press;
+	u32 adc_press, comp_press, t_fine;
 	int ret;
 
-	/* Read and compensate for temperature so we get a reading of t_fine */
-	ret = bmp380_read_temp(data, NULL, NULL);
+	ret = bmp380_get_t_fine(data, &t_fine);
 	if (ret)
 		return ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP380_REG_PRESS_XLSB,
-			       data->buf, sizeof(data->buf));
-	if (ret) {
-		dev_err(data->dev, "failed to read pressure\n");
+	ret = bmp380_read_press_adc(data, &adc_press);
+	if (ret)
 		return ret;
-	}
 
-	adc_press = get_unaligned_le24(data->buf);
-	if (adc_press == BMP380_PRESS_SKIPPED) {
-		dev_err(data->dev, "reading pressure skipped\n");
-		return -EIO;
-	}
-	comp_press = bmp380_compensate_press(data, adc_press);
+	comp_press = bmp380_compensate_press(data, adc_press, t_fine);
 
 	*val = comp_press;
-	/* Compensated pressure is in cPa (centipascals) */
 	*val2 = 100000;
 
 	return IIO_VAL_FRACTIONAL;
@@ -1824,7 +1910,7 @@ static int bmp180_wait_for_eoc(struct bmp280_data *data, u8 ctrl_meas)
 	return 0;
 }
 
-static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
+static int bmp180_read_temp_adc(struct bmp280_data *data, u32 *adc_temp)
 {
 	int ret;
 
@@ -1841,7 +1927,7 @@ static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
 		return ret;
 	}
 
-	*val = be16_to_cpu(data->be16);
+	*adc_temp = be16_to_cpu(data->be16);
 
 	return 0;
 }
@@ -1891,16 +1977,34 @@ static int bmp180_read_calib(struct bmp280_data *data)
  *
  * Taken from datasheet, Section 3.5, "Calculating pressure and temperature".
  */
-static s32 bmp180_compensate_temp(struct bmp280_data *data, u32 adc_temp)
+
+static s32 bmp180_calc_t_fine(struct bmp280_data *data, u32 adc_temp)
 {
 	struct bmp180_calib *calib = &data->calib.bmp180;
 	s32 x1, x2;
 
 	x1 = ((((s32)adc_temp) - calib->AC6) * calib->AC5) >> 15;
 	x2 = (calib->MC << 11) / (x1 + calib->MD);
-	data->t_fine = x1 + x2;
+	return x1 + x2; /* t_fine = x1 + x2; */
+}
+
+static int bmp180_get_t_fine(struct bmp280_data *data, s32 *t_fine)
+{
+	s32 adc_temp;
+	int ret;
+
+	ret = bmp180_read_temp_adc(data, &adc_temp);
+	if (ret)
+		return ret;
+
+	*t_fine = bmp180_calc_t_fine(data, adc_temp);
 
-	return (data->t_fine + 8) >> 4;
+	return 0;
+}
+
+static s32 bmp180_compensate_temp(struct bmp280_data *data, u32 adc_temp)
+{
+	return (bmp180_calc_t_fine(data, adc_temp) + 8) / 16;
 }
 
 static int bmp180_read_temp(struct bmp280_data *data, int *val, int *val2)
@@ -1909,25 +2013,17 @@ static int bmp180_read_temp(struct bmp280_data *data, int *val, int *val2)
 	u32 adc_temp;
 	int ret;
 
-	ret = bmp180_read_adc_temp(data, &adc_temp);
+	ret = bmp180_read_temp_adc(data, &adc_temp);
 	if (ret)
 		return ret;
 
 	comp_temp = bmp180_compensate_temp(data, adc_temp);
 
-	/*
-	 * val might be NULL if we're called by the read_press routine,
-	 * who only cares about the carry over t_fine value.
-	 */
-	if (val) {
-		*val = comp_temp * 100;
-		return IIO_VAL_INT;
-	}
-
-	return 0;
+	*val = comp_temp * 100;
+	return IIO_VAL_INT;
 }
 
-static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
+static int bmp180_read_press_adc(struct bmp280_data *data, u32 *adc_press)
 {
 	u8 oss = data->oversampling_press;
 	int ret;
@@ -1946,7 +2042,7 @@ static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
 		return ret;
 	}
 
-	*val = get_unaligned_be24(data->buf) >> (8 - oss);
+	*adc_press = get_unaligned_be24(data->buf) >> (8 - oss);
 
 	return 0;
 }
@@ -1956,7 +2052,8 @@ static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
  *
  * Taken from datasheet, Section 3.5, "Calculating pressure and temperature".
  */
-static u32 bmp180_compensate_press(struct bmp280_data *data, u32 adc_press)
+static u32 bmp180_compensate_press(struct bmp280_data *data, u32 adc_press,
+				   s32 t_fine)
 {
 	struct bmp180_calib *calib = &data->calib.bmp180;
 	s32 oss = data->oversampling_press;
@@ -1964,7 +2061,7 @@ static u32 bmp180_compensate_press(struct bmp280_data *data, u32 adc_press)
 	s32 b3, b6;
 	u32 b4, b7;
 
-	b6 = data->t_fine - 4000;
+	b6 = t_fine - 4000;
 	x1 = (calib->B2 * (b6 * b6 >> 12)) >> 11;
 	x2 = calib->AC2 * b6 >> 11;
 	x3 = x1 + x2;
@@ -1989,18 +2086,17 @@ static u32 bmp180_compensate_press(struct bmp280_data *data, u32 adc_press)
 static int bmp180_read_press(struct bmp280_data *data, int *val, int *val2)
 {
 	u32 comp_press, adc_press;
-	int ret;
+	s32 t_fine;
 
-	/* Read and compensate temperature so we get a reading of t_fine. */
-	ret = bmp180_read_temp(data, NULL, NULL);
+	ret = bmp180_get_t_fine(data, &t_fine);
 	if (ret)
 		return ret;
 
-	ret = bmp180_read_adc_press(data, &adc_press);
+	ret = bmp180_read_press_adc(data, &adc_press);
 	if (ret)
 		return ret;
 
-	comp_press = bmp180_compensate_press(data, adc_press);
+	comp_press = bmp180_compensate_press(data, adc_press, t_fine);
 
 	*val = comp_press;
 	*val2 = 1000;
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 51fbd451ecbe..777b33ce1e70 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -397,12 +397,6 @@ struct bmp280_data {
 	 */
 	int sampling_freq;
 
-	/*
-	 * Carryover value from temperature conversion, used in pressure
-	 * calculation.
-	 */
-	s32 t_fine;
-
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.

base-commit: 34d3aa6a60c8e0d053e8df5ff4a2b211951f06a6
-- 
2.25.1


