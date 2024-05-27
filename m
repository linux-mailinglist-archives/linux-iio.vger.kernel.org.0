Return-Path: <linux-iio+bounces-5380-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 073208D0A0D
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 20:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56A5DB2149B
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 18:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73619169396;
	Mon, 27 May 2024 18:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cd0Rn0Sw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F086168C29;
	Mon, 27 May 2024 18:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716835112; cv=none; b=epAMUYbjWsOo0fXtOpo91vhfWQgQgj+gwC9InHxpVSzv2FUAKboXG3CG77XoPaTAqruffP4M8KGlB9X0/lUWwXB/f2o+kQQym3jvh7uEQKRooHx0SIcFJ3AcA2oQsKz3/HinDb8OLr71wxCHZUOWC3dCkjBw0rHNDZgQAnRh8Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716835112; c=relaxed/simple;
	bh=Q2PlA0hiHKYNxsXSB+MV8bzWdduB4sQHpHLyCbabfZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EEVWZO0LI+hTkxyi4LM9MCivr1nmMbFed+NCv3lcVps+3ED4wH+Pwp93hqj4rTvvuJtlyuqP6aHunP/T//4Wv/YAwiH7lmDtUK4S3KGyM19nVnVmv5ZY+ouE4VMBKZpXt88qqnWda8E6o665SGKkTKCgARo/f64JomSJs7lofdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cd0Rn0Sw; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a5a89787ea4so7555466b.2;
        Mon, 27 May 2024 11:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716835109; x=1717439909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zx/kAsdeMiTjNQrNc9mf98y9EcqJqfG2NikyGa/ZpqY=;
        b=Cd0Rn0Sw7CutXsCY7mWmg0tEiBiWuok9AJ7Xp6equk5V3Ds9Aug4tfIoYSVeIS4bu3
         AS+nryGYWPU7t3rfMACpDrsPgF8klr1mfGHDeNdeRSt099C7UIuVJxMFBZdHKOIsdHrb
         L7XeX49BYahiMsWuWZ07YuBRw0qqmmF2eCeOTBQ/791+xY3uI61SMuoE/6L277/5u1ED
         PP4sKJ6Id+e79lCqW+60mOWvOtGh8d72iHtuyUI+2wv/koKviAczbbkoNaLDLjGM/dbb
         aU7NOyFbMWlYegmLt+hg9c1RITcJTus6PlJ9/ailUzV4zhU3B5WHEmgmXIeDo5kml9Id
         9C/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716835109; x=1717439909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zx/kAsdeMiTjNQrNc9mf98y9EcqJqfG2NikyGa/ZpqY=;
        b=XjTsYnvCzPib6ZsgE4FjwA8pqvkWWtdEdrOZJen4EQOlF3ctZLFs7kyw9JeMYR00L0
         eL+3o5KNYreCqt9fqLQeC1NqRvaennc7K3DEv7mIaBJS76f7OrOPjnRnhbbfLkpSxbWa
         czsXw/0BBML+cWZoVzXctx8Q6yDGIEkN8/r4D9ptDjqx9ET4tzGA9A5DjBOaQ4/PUOew
         OqD6oam8H0Mo4RD6B/8PlAaHIle2WgTbZNMOoEzrUZFIjuZolpNCWLiqASu7b5GAgImC
         yhyEf2Dp1/immPl/dV2rD0I0TT0IXoVDTtS9GAQTw5+UkQJPnW/3q8rLwWRvkkcaiksl
         DvTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuJBlOIU1Vk0lTVdhifR1hN83qB7HoU9jpSVgxx1fSao7fymbe01KgPuS0XlmX2uLhKv7fC7+o7MnlbIuBLYhORCSJij51rpi+l7q7MySZFmQPE4fs8KKOo1ELXEF5lIPquLd/kg1r
X-Gm-Message-State: AOJu0YwD/FfQSBKGWNWYuSuSxjxJG75PEH4VIN3ksPN37W+Vs/OqQ7et
	lSgvrquMRQg+WYPtJ7vV7dX5gWSHtQRt+d904h2SM6+VYmeOnD+PkMj/tw==
X-Google-Smtp-Source: AGHT+IE1tKzJqbfjBH26TaM1koLxePkYTkuUtXN4w2h0H1fvC6I15wD2F+0d57Y/rydbL0hbWVPhew==
X-Received: by 2002:a17:906:6b1b:b0:a59:ee81:fd68 with SMTP id a640c23a62f3a-a626525cd08mr688673366b.71.1716835108688;
        Mon, 27 May 2024 11:38:28 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4b45:3774:6be0:a177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc52398sm513825266b.105.2024.05.27.11.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 11:38:28 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: himanshujha199640@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v1 17/17] iio: chemical: bme680: Refactorize reading functions
Date: Mon, 27 May 2024 20:38:05 +0200
Message-Id: <20240527183805.311501-18-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240527183805.311501-1-vassilisamir@gmail.com>
References: <20240527183805.311501-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reading of the pressure and humidity value, requires an update
of the t_fine variable which happens by reading the temperature
value.

So the bme680_read_{press/humid}() functions of the above sensors
are internally calling the equivalent bme680_read_temp() function
in order to update the t_fine value. By just looking at the code
this relation is a bit hidden and is not easy to understand why
those channels are not independent.

This commit tries to clear these thing a bit by splitting the
bme680_{read/compensate}_{temp/press/humid}() to the following:

i. bme680_read_{temp/press/humid}_adc(): read the raw value from
the sensor.

ii. bme680_calc_t_fine(): calculate the t_fine variable.

iii. bme680_get_t_fine(): get the t_fine variable.

iv. bme680_compensate_{temp/press/humid}(): compensate the adc
values and return the calculated value.

v. bme680_read_{temp/press/humid}(): combine calls of the
aforementioned functions to return the requested value.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 192 +++++++++++++++++------------
 1 file changed, 116 insertions(+), 76 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 8f977667249b..cfcb6f791517 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -104,11 +104,6 @@ struct bme680_data {
 	u8 oversampling_humid;
 	u16 heater_dur;
 	u16 heater_temp;
-	/*
-	 * Carryover value from temperature conversion, used in pressure
-	 * and humidity compensation calculations.
-	 */
-	s32 t_fine;
 
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
@@ -241,6 +236,31 @@ static int bme680_read_calib(struct bme680_data *data,
 	return 0;
 }
 
+static int bme680_read_temp_adc(struct bme680_data *data, u32 *adc_temp)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	u32 value_temp;
+	int ret;
+
+	ret = regmap_bulk_read(data->regmap, BME680_REG_TEMP_MSB,
+			       data->buf, BME680_TEMP_NUM_BYTES);
+	if (ret < 0) {
+		dev_err(dev, "failed to read temperature\n");
+		return ret;
+	}
+
+	value_temp = FIELD_GET(BME680_MEAS_TRIM_MASK,
+			       get_unaligned_be24(data->buf));
+	if (value_temp == BME680_MEAS_SKIPPED) {
+		/* reading was skipped */
+		dev_err(dev, "reading temperature skipped\n");
+		return -EINVAL;
+	}
+	*adc_temp = value_temp;
+
+	return 0;
+}
+
 /*
  * Taken from Bosch BME680 API:
  * https://github.com/BoschSensortec/BME680_driver/blob/63bb5336/bme680.c#L876
@@ -248,12 +268,10 @@ static int bme680_read_calib(struct bme680_data *data,
  * Returns temperature measurement in DegC, resolutions is 0.01 DegC. Therefore,
  * output value of "3233" represents 32.33 DegC.
  */
-static s16 bme680_compensate_temp(struct bme680_data *data,
-				  u32 adc_temp)
+static s32 bme680_calc_t_fine(struct bme680_data *data, u32 adc_temp)
 {
 	struct bme680_calib *calib = &data->bme680;
 	s64 var1, var2, var3;
-	s16 calc_temp;
 
 	/* If the calibration is invalid, attempt to reload it */
 	if (!calib->par_t2)
@@ -263,10 +281,52 @@ static s16 bme680_compensate_temp(struct bme680_data *data,
 	var2 = (var1 * calib->par_t2) >> 11;
 	var3 = ((var1 >> 1) * (var1 >> 1)) >> 12;
 	var3 = (var3 * ((s32)calib->par_t3 << 4)) >> 14;
-	data->t_fine = var2 + var3;
-	calc_temp = (data->t_fine * 5 + 128) >> 8;
+	return var2 + var3; /* t_fine = var2 + var3 */
+}
 
-	return calc_temp;
+static int bme680_get_t_fine(struct bme680_data *data, s32 *t_fine)
+{
+	u32 adc_temp;
+	int ret;
+
+	ret = bme680_read_temp_adc(data, &adc_temp);
+	if (ret)
+		return ret;
+
+	*t_fine = bme680_calc_t_fine(data, adc_temp);
+
+	return 0;
+}
+
+static s16 bme680_compensate_temp(struct bme680_data *data,
+				  u32 adc_temp)
+{
+	return (bme680_calc_t_fine(data, adc_temp) * 5 + 128) / 256;
+}
+
+static int bme680_read_press_adc(struct bme680_data *data, u32 *adc_press)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	u32 value_press;
+	int ret;
+
+	ret = regmap_bulk_read(data->regmap, BME680_REG_PRESS_MSB,
+			       data->buf, BME680_PRESS_NUM_BYTES);
+	if (ret < 0) {
+		dev_err(dev, "failed to read pressure\n");
+		return ret;
+	}
+
+	value_press = FIELD_GET(BME680_MEAS_TRIM_MASK,
+				get_unaligned_be24(data->buf));
+	if (value_press == BME680_MEAS_SKIPPED) {
+		/* reading was skipped */
+		dev_err(dev, "reading pressure skipped\n");
+		return -EINVAL;
+	}
+	*adc_press = value_press;
+
+	return 0;
 }
 
 /*
@@ -277,12 +337,12 @@ static s16 bme680_compensate_temp(struct bme680_data *data,
  * 97356 Pa = 973.56 hPa.
  */
 static u32 bme680_compensate_press(struct bme680_data *data,
-				   u32 adc_press)
+				   u32 adc_press, s32 t_fine)
 {
 	struct bme680_calib *calib = &data->bme680;
 	s32 var1, var2, var3, press_comp;
 
-	var1 = (data->t_fine >> 1) - 64000;
+	var1 = (t_fine >> 1) - 64000;
 	var2 = ((((var1 >> 2) * (var1 >> 2)) >> 11) * calib->par_p6) >> 2;
 	var2 = var2 + (var1 * calib->par_p5 << 1);
 	var2 = (var2 >> 2) + ((s32)calib->par_p4 << 16);
@@ -310,6 +370,30 @@ static u32 bme680_compensate_press(struct bme680_data *data,
 	return press_comp;
 }
 
+static int bme680_read_humid_adc(struct bme680_data *data, u32 *adc_humidity)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	u32 value_humidity;
+	int ret;
+
+	ret = regmap_bulk_read(data->regmap, BME680_REG_HUMIDITY_MSB,
+			       &data->be16, BME680_HUMID_NUM_BYTES);
+	if (ret < 0) {
+		dev_err(dev, "failed to read humidity\n");
+		return ret;
+	}
+
+	value_humidity = be16_to_cpu(data->be16);
+	if (value_humidity == BME680_MEAS_SKIPPED) {
+		/* reading was skipped */
+		dev_err(dev, "reading humidity skipped\n");
+		return -EINVAL;
+	}
+	*adc_humidity = value_humidity;
+
+	return 0;
+}
+
 /*
  * Taken from Bosch BME680 API:
  * https://github.com/BoschSensortec/BME680_driver/blob/63bb5336/bme680.c#L937
@@ -318,12 +402,12 @@ static u32 bme680_compensate_press(struct bme680_data *data,
  * value of "43215" represents 43.215 %rH.
  */
 static u32 bme680_compensate_humid(struct bme680_data *data,
-				   u16 adc_humid)
+				   u16 adc_humid, s32 t_fine)
 {
 	struct bme680_calib *calib = &data->bme680;
 	s32 var1, var2, var3, var4, var5, var6, temp_scaled, calc_hum;
 
-	temp_scaled = (data->t_fine * 5 + 128) >> 8;
+	temp_scaled = (t_fine * 5 + 128) >> 8;
 	var1 = (adc_humid - (((s32)calib->par_h1 * 16))) -
 		(((temp_scaled * calib->par_h3) / 100) >> 1);
 	var2 = (calib->par_h2 *
@@ -555,68 +639,35 @@ static int bme680_gas_config(struct bme680_data *data)
 
 static int bme680_read_temp(struct bme680_data *data, int *val)
 {
-	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 	u32 adc_temp;
 	s16 comp_temp;
 
-	ret = regmap_bulk_read(data->regmap, BME680_REG_TEMP_MSB,
-			       data->buf, BME680_TEMP_NUM_BYTES);
-	if (ret < 0) {
-		dev_err(dev, "failed to read temperature\n");
+	ret = bme680_read_temp_adc(data, &adc_temp);
+	if (ret)
 		return ret;
-	}
 
-	adc_temp = FIELD_GET(BME680_MEAS_TRIM_MASK,
-			     get_unaligned_be24(data->buf));
-	if (adc_temp == BME680_MEAS_SKIPPED) {
-		/* reading was skipped */
-		dev_err(dev, "reading temperature skipped\n");
-		return -EINVAL;
-	}
 	comp_temp = bme680_compensate_temp(data, adc_temp);
-	/*
-	 * val might be NULL if we're called by the read_press/read_humid
-	 * routine which is called to get t_fine value used in
-	 * compensate_press/compensate_humid to get compensated
-	 * pressure/humidity readings.
-	 */
-	if (val) {
-		*val = comp_temp * 10; /* Centidegrees to millidegrees */
-		return IIO_VAL_INT;
-	}
-
-	return ret;
+	*val = comp_temp * 10; /* Centidegrees to millidegrees */
+	return IIO_VAL_INT;
 }
 
 static int bme680_read_press(struct bme680_data *data,
 			     int *val, int *val2)
 {
-	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 	u32 adc_press;
+	s32 t_fine;
 
-	/* Read and compensate temperature to get a reading of t_fine */
-	ret = bme680_read_temp(data, NULL);
-	if (ret < 0)
+	ret = bme680_get_t_fine(data, &t_fine);
+	if (ret)
 		return ret;
 
-	ret = regmap_bulk_read(data->regmap, BME680_REG_PRESS_MSB,
-			       data->buf, BME680_PRESS_NUM_BYTES);
-	if (ret < 0) {
-		dev_err(dev, "failed to read pressure\n");
+	ret = bme680_read_press_adc(data, &adc_press);
+	if (ret)
 		return ret;
-	}
 
-	adc_press = FIELD_GET(BME680_MEAS_TRIM_MASK,
-			      get_unaligned_be24(data->buf));
-	if (adc_press == BME680_MEAS_SKIPPED) {
-		/* reading was skipped */
-		dev_err(dev, "reading pressure skipped\n");
-		return -EINVAL;
-	}
-
-	*val = bme680_compensate_press(data, adc_press);
+	*val = bme680_compensate_press(data, adc_press, t_fine);
 	*val2 = 1000;
 	return IIO_VAL_FRACTIONAL;
 }
@@ -624,30 +675,19 @@ static int bme680_read_press(struct bme680_data *data,
 static int bme680_read_humid(struct bme680_data *data,
 			     int *val, int *val2)
 {
-	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
-	u16 adc_humidity;
-	u32 comp_humidity;
+	u32 adc_humidity, comp_humidity;
+	s32 t_fine;
 
-	/* Read and compensate temperature to get a reading of t_fine */
-	ret = bme680_read_temp(data, NULL);
-	if (ret < 0)
+	ret = bme680_get_t_fine(data, &t_fine);
+	if (ret)
 		return ret;
 
-	ret = regmap_bulk_read(data->regmap, BME680_REG_HUMIDITY_MSB,
-			       &data->be16, BME680_HUMID_NUM_BYTES);
-	if (ret < 0) {
-		dev_err(dev, "failed to read humidity\n");
+	ret = bme680_read_humid_adc(data, &adc_humidity);
+	if (ret)
 		return ret;
-	}
 
-	adc_humidity = be16_to_cpu(data->be16);
-	if (adc_humidity == BME680_MEAS_SKIPPED) {
-		/* reading was skipped */
-		dev_err(dev, "reading humidity skipped\n");
-		return -EINVAL;
-	}
-	comp_humidity = bme680_compensate_humid(data, adc_humidity);
+	comp_humidity = bme680_compensate_humid(data, adc_humidity, t_fine);
 
 	*val = comp_humidity;
 	*val2 = 1000;
-- 
2.25.1


