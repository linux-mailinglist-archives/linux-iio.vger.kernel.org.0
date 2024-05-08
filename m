Return-Path: <linux-iio+bounces-4892-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6336A8C020D
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 18:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87A5B1C21A4C
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 16:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4186E12838B;
	Wed,  8 May 2024 16:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uo6zuL2J"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830BE14A8C;
	Wed,  8 May 2024 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715186087; cv=none; b=hKKe6IkTC8dFRab7p4agBoqDmBuFkIHk9d/UPH0RmIhRmL74wee8lMuwmvoja5w+vWhgn2Ongyp6IEoM52UyHzi3w5IxonIFJhU4d2BFnmaWAtNsALhHQ3BnqdsiTQMnP4MA7bC7Mby9tc5nVR53SdzM1lE3hiI64CNCAz0F1wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715186087; c=relaxed/simple;
	bh=GZaAr5RygQFmlE6KJCuN9p5qEvzol2zFA6i0gHwOQG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ko1ybww+mqtd6hvma2Sz9jH7nybUf5ISw1BWyzsaL15H6Udo7OH447RLzzLGuYeClGx+kF7FWJ99MuO3GOlfQvbyyb5OAQjohCBAboTzrWUsDXolaaZp+Z2K0ek9GO7Q89sdPv8/bKhyMO/Y3pd8SHCVP4jjBv4ajBPY9IFfIYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uo6zuL2J; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59ab4f60a6so1003201866b.0;
        Wed, 08 May 2024 09:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715186083; x=1715790883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MC7P1POHROJSmnY61bQaysxhFvNv1wVgLw++QzUYJv8=;
        b=Uo6zuL2JgPiBBQPl7SLqHkrQu/a8tlEUDXcFYRlk5TGPHlyR/v+3VkCn9mZMqPXXka
         0TQSZdKVK5FWH+uZ8GMEdxLtZgU082t8bZJn1hOW8Cv5LqIbyMPYkipSuZ9U0Xk7WrYm
         kWo+GRn7HAy0ftjDDAwD71j/4nc9EYniV9I3MnQyPHjv9kUaqzlw0bSHjZm2u9dAUbeF
         DuoYc+yIFx/2STguURjdwhoP795OVHfl4DTlOdKxZvGrwdMzDH3BsLxj8g5aqzBsXK6L
         HxYtmZ8tFLPdVkHsmMkKfGYRqluFnCRtRvvqZbhNZsiDQ9Z/Cjrg17tyGB7URQzX0D5j
         ZRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715186083; x=1715790883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MC7P1POHROJSmnY61bQaysxhFvNv1wVgLw++QzUYJv8=;
        b=rsTxjLeez9KNqg0qrmQa0X/Z9lwI1teqIVABE4SeScRuG1IngVZjG0FkaJ4ysYnrji
         /WRcl77liehBkZETaEGuS5+Qi6Hk1hvJByRAEvJMKOHxHM9HWLqCDDUvdQjnWLoYIw/Z
         5BT7iZB7uayK2GVxYEIya9IBYKlOMVmb5IPfvaPzOdLXxZGtzXKRrCcQROvRCMlJetoY
         xtlT162ZzaK6AKz0Uxh5aB4e/5SxkyrPDi7l3utvEBt3+QmZB7RiLYzZDaPUN0IRFqlw
         0iLUza8oKyTZghK1qaSXZovKw0Vh1npX9hUbCTBarYUC5zwIGeIj4gNusOrHVh2wQQ/3
         11Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUqx1pYi7C06tlnb0+3uNY58xHFR2HEDzJQQ98oEbLtOrg1Y2VagttIpii7WtPtpI/P1qxlzI/48rDs9xIYDur9BkGIc2LZb9Zg/ezhG3Qh83gt3w5bl9aMSohfocd+5unyzUGMH+g4
X-Gm-Message-State: AOJu0Yz9p7/FRuAVE3IEVN4X/9K/JVPTNg84fIndPdwjOByrKJ8Ne7uJ
	mzgSL8RqqnccyIuWi/Q+yFcZ5IVDuPNX1Kv7U1X/y2J+WA4n4BEBKI3xT2MdaUg=
X-Google-Smtp-Source: AGHT+IHki8mLuKFl4UDmlAuegBiJSb/umjKjbL8Z+Bypy7/sJZHfFHkMYcg2GoaqqxdFbCr8h+1d8g==
X-Received: by 2002:a17:907:3f2a:b0:a59:a282:5dbd with SMTP id a640c23a62f3a-a59fb9db24cmr312846866b.66.1715186082484;
        Wed, 08 May 2024 09:34:42 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:a3c8:644e:cd04:560a])
        by smtp.gmail.com with ESMTPSA id hb4-20020a170906b88400b00a5599f3a057sm7872843ejb.107.2024.05.08.09.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 09:34:42 -0700 (PDT)
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
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5/9] iio: pressure: bmp280: Refactorize reading functions
Date: Wed,  8 May 2024 18:34:21 +0200
Message-Id: <20240508163425.143831-6-vassilisamir@gmail.com>
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
 drivers/iio/pressure/bmp280-core.c | 361 ++++++++++++++++++-----------
 drivers/iio/pressure/bmp280.h      |   6 -
 2 files changed, 232 insertions(+), 135 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index dd5c526dacbd..a864f8db8e24 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -288,13 +288,35 @@ static int bme280_read_calib(struct bmp280_data *data)
  *
  * Taken from BME280 datasheet, Section 4.2.3, "Compensation formula".
  */
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
@@ -313,8 +335,29 @@ static u32 bme280_compensate_humidity(struct bmp280_data *data,
  *
  * Taken from datasheet, Section 3.11.3, "Compensation formula".
  */
-static s32 bmp280_compensate_temp(struct bmp280_data *data,
-				  u32 adc_temp)
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
+static s32 bmp280_calc_t_fine(struct bmp280_data *data, u32 adc_temp)
 {
 	struct bmp280_calib *calib = &data->calib.bmp280;
 	s32 var1, var2;
@@ -324,9 +367,26 @@ static s32 bmp280_compensate_temp(struct bmp280_data *data,
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
 
-	return (data->t_fine * 5 + 128) >> 8;
+	*t_fine = bmp280_calc_t_fine(data, adc_temp);
+
+	return 0;
+}
+
+static s32 bmp280_compensate_temp(struct bmp280_data *data, u32 adc_temp)
+{
+	return (bmp280_calc_t_fine(data, adc_temp) * 5 + 128) / 256;
 }
 
 /*
@@ -336,13 +396,35 @@ static s32 bmp280_compensate_temp(struct bmp280_data *data,
  *
  * Taken from datasheet, Section 3.11.3, "Compensation formula".
  */
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
+
+	return 0;
+}
+
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
@@ -369,59 +451,34 @@ static int bmp280_read_temp(struct bmp280_data *data,
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
+	/* IIO units are in milli Celsius */
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
 
+	/* IIO units are in kPa */
 	*val = comp_press;
 	*val2 = 256000;
 
@@ -432,28 +489,20 @@ static int bme280_read_humid(struct bmp280_data *data, int *val, int *val2)
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
 
+	/* IIO units are in 1000 * % */
 	*val = comp_humidity * 1000 / 1024;
 
 	return IIO_VAL_INT;
@@ -930,9 +979,31 @@ static int bmp380_cmd(struct bmp280_data *data, u8 cmd)
  * Taken from datasheet, Section Appendix 9, "Compensation formula" and repo
  * https://github.com/BoschSensortec/BMP3-Sensor-API.
  */
-static s32 bmp380_compensate_temp(struct bmp280_data *data, u32 adc_temp)
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
+static s32 bmp380_calc_t_fine(struct bmp280_data *data, u32 adc_temp)
 {
-	s64 var1, var2, var3, var4, var5, var6, comp_temp;
+	s64 var1, var2, var3, var4, var5, var6;
 	struct bmp380_calib *calib = &data->calib.bmp380;
 
 	var1 = ((s64) adc_temp) - (((s64) calib->T1) << 8);
@@ -941,7 +1012,29 @@ static s32 bmp380_compensate_temp(struct bmp280_data *data, u32 adc_temp)
 	var4 = var3 * ((s64) calib->T3);
 	var5 = (var2 << 18) + var4;
 	var6 = var5 >> 32;
-	data->t_fine = (s32) var6;
+	return (s32) var6; /* t_fine = var6 */
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
@@ -955,27 +1048,50 @@ static s32 bmp380_compensate_temp(struct bmp280_data *data, u32 adc_temp)
  * Taken from datasheet, Section 9.3. "Pressure compensation" and repository
  * https://github.com/BoschSensortec/BMP3-Sensor-API.
  */
-static u32 bmp380_compensate_press(struct bmp280_data *data, u32 adc_press)
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
+	var3 = (var2 * ((s64) t_fine)) >> 8;
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
 
@@ -1001,59 +1117,34 @@ static int bmp380_read_temp(struct bmp280_data *data, int *val, int *val2)
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
+	/* IIO units are in milli Celsius */
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
 
+	/* IIO units are in kPa */
 	*val = comp_press;
-	/* Compensated pressure is in cPa (centipascals) */
 	*val2 = 100000;
 
 	return IIO_VAL_FRACTIONAL;
@@ -1825,7 +1916,7 @@ static int bmp180_wait_for_eoc(struct bmp280_data *data, u8 ctrl_meas)
 	return 0;
 }
 
-static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
+static int bmp180_read_temp_adc(struct bmp280_data *data, u32 *adc_temp)
 {
 	int ret;
 
@@ -1842,7 +1933,7 @@ static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
 		return ret;
 	}
 
-	*val = be16_to_cpu(data->be16);
+	*adc_temp = be16_to_cpu(data->be16);
 
 	return 0;
 }
@@ -1892,16 +1983,34 @@ static int bmp180_read_calib(struct bmp280_data *data)
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
@@ -1910,25 +2019,18 @@ static int bmp180_read_temp(struct bmp280_data *data, int *val, int *val2)
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
+	/* IIO units are in milli Celsius */
+	*val = comp_temp * 100;
+	return IIO_VAL_INT;
 }
 
-static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
+static int bmp180_read_press_adc(struct bmp280_data *data, u32 *adc_press)
 {
 	u8 oss = data->oversampling_press;
 	int ret;
@@ -1947,7 +2049,7 @@ static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
 		return ret;
 	}
 
-	*val = get_unaligned_be24(data->buf) >> (8 - oss);
+	*adc_press = get_unaligned_be24(data->buf) >> (8 - oss);
 
 	return 0;
 }
@@ -1957,7 +2059,8 @@ static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
  *
  * Taken from datasheet, Section 3.5, "Calculating pressure and temperature".
  */
-static u32 bmp180_compensate_press(struct bmp280_data *data, u32 adc_press)
+static u32 bmp180_compensate_press(struct bmp280_data *data, u32 adc_press,
+				   s32 t_fine)
 {
 	struct bmp180_calib *calib = &data->calib.bmp180;
 	s32 oss = data->oversampling_press;
@@ -1965,7 +2068,7 @@ static u32 bmp180_compensate_press(struct bmp280_data *data, u32 adc_press)
 	s32 b3, b6;
 	u32 b4, b7;
 
-	b6 = data->t_fine - 4000;
+	b6 = t_fine - 4000;
 	x1 = (calib->B2 * (b6 * b6 >> 12)) >> 11;
 	x2 = calib->AC2 * b6 >> 11;
 	x3 = x1 + x2;
@@ -1974,7 +2077,7 @@ static u32 bmp180_compensate_press(struct bmp280_data *data, u32 adc_press)
 	x2 = (calib->B1 * ((b6 * b6) >> 12)) >> 16;
 	x3 = (x1 + x2 + 2) >> 2;
 	b4 = calib->AC4 * (u32)(x3 + 32768) >> 15;
-	b7 = (adc_press - b3) * (50000 >> oss);
+	b7 = (((u32)adc_press) - b3) * (50000 >> oss);
 	if (b7 < 0x80000000)
 		p = (b7 * 2) / b4;
 	else
@@ -1990,19 +2093,19 @@ static u32 bmp180_compensate_press(struct bmp280_data *data, u32 adc_press)
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
 
+	/* IIO units are in kPa */
 	*val = comp_press;
 	*val2 = 1000;
 
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index fe4d3f127954..7c30e4d523be 100644
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
-- 
2.25.1


