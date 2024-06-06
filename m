Return-Path: <linux-iio+bounces-5966-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAB68FF6D6
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 23:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B961F232E8
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 21:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFA41A01B9;
	Thu,  6 Jun 2024 21:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7uCAGJM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A2019FA62;
	Thu,  6 Jun 2024 21:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717709058; cv=none; b=ufY1oh3N91cHbCEdroGsLLOLFrOZwWRqx6N7H6EnlGqm7eaTjzfDyfK1bUQySBpKVoWrNW7xlkePRoLruL14CoQmv1hwUQB8ZwUA0SiPoL+GUmn4spIP0zthxSArQR1AoOfFDCjGuuAP2DKtWcvEt9RhE1JoFWFTt1ML3n71t+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717709058; c=relaxed/simple;
	bh=6l/EfR3cgqh3S3VvJzUDR28vFG7EdWRDt4ZKwsqOLbY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nuvC4NKNE9LD5aOqId1LKw/PqUz9kit0tXsAEk5gzn4YyF83t0uyqfEZSzJ4cGCnqSeUU4KbbplVN6RID+bQvFwfPhdUMYVSSycIy5n/aMdNhysEBQ87tU0fyyT9/KfGquTCB19ye5V6OKZyiFiXL+3CSxmbGi1t2WsfnzCXtXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7uCAGJM; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a62ef52e837so190921466b.3;
        Thu, 06 Jun 2024 14:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717709055; x=1718313855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33ooC5ANBEJJVDpmUZure1ncbczhQ+Pa0W0whiRBsyw=;
        b=E7uCAGJMKS9j0FnqEVSytsnrw/HDM5PF5j1f9xSEUfMlX5KIrEwyR93XSEwL/3CEfh
         T7Tiu1Rh21EnAXEgecP0G6PfT8Fjulrsk4NZ0/PBD/xHXZAEur6pLDxAAknAcSn/5YEy
         pGYGTRDVyUWk+uxYw1eNKsmlgYDEMxnMUerKybVBY4x99rSyX4hA6Y9HeUs/XDWH6ncT
         iET5h5XwVqzOOrWOdzde/9vjDNxMu9HUyvwhOdOKoIV+r2I5NNbH9BMArqLLMUKjyyCF
         eJbsPyqTVlVO376IwYbWopjsW4KFQAEecYehNJ5RdKDAbP+3CqhQ5jhlIkqXQnYlzb4T
         ChWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717709055; x=1718313855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=33ooC5ANBEJJVDpmUZure1ncbczhQ+Pa0W0whiRBsyw=;
        b=ZkwfdDYwIfOlJm2msEowsE5ji6paP45h+YjMX/la+E6VG3anvWAAexfmQ4zYLy2fdY
         CWSSfuWkU/OXQwCCxG6nrk6VbHBH+LxmcYHn2Wclc8e60JcNhna+FgyssGfseRT7Kytg
         tYBSiQ2cbGaIBJXDLxNRa8pv5g1T7LaifaGEmHRgFGHEGbpyln5g6dNMaAYhNx8SiE/c
         fuMFiVKjvUA+MVhoGcqd5SpfR+Yrhe3tzWp/BNTXcz4e9eJq4NTuOj8E55TvfHlHwH+C
         uSkf2QCTnJe9TIbD/WNUhU20IT07aAVXublPoHfcPoH45ztrlw0L6Q33eH7pHLemPqWF
         3glg==
X-Forwarded-Encrypted: i=1; AJvYcCVpmatXONCnpU3qCO9nvClNy6nto8VbDTuviAsICFpf5i0W54n1TO2qUtO9jeTNxmFn86PMJaSGEJBBJ2f9FHIWDpe18LvNcAzpoPCIVA0dDXqxHc18fQ6fubN7XaWOAGzcCc97KUIN
X-Gm-Message-State: AOJu0YyU01G/tlqsysOKnEXnh5tMzY6pH6NAqO00nOHMEcjizsNuK4ED
	1/G883s1kCsd75+P22/ZBk6KCTktHXmZqw3fnY8vJsNnk37E10HL/cPMz8z/IR0=
X-Google-Smtp-Source: AGHT+IGEVWIAFtDqFpB5bqXpnD8g+pIGZNqBdhTs0RE2DM3rZMCaMNjvhi2r1vemHM1CSb6Vmlz83Q==
X-Received: by 2002:a17:907:d15:b0:a68:a843:9014 with SMTP id a640c23a62f3a-a6cd665d4c7mr65496466b.18.1717709054841;
        Thu, 06 Jun 2024 14:24:14 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:28a0:434b:ab8b:94ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8058272bsm146690566b.18.2024.06.06.14.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 14:24:14 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v2 19/19] iio: chemical: bme680: Refactorize reading functions
Date: Thu,  6 Jun 2024 23:23:13 +0200
Message-Id: <20240606212313.207550-22-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240606212313.207550-1-vassilisamir@gmail.com>
References: <20240606212313.207550-1-vassilisamir@gmail.com>
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
index b654a8cd31aa..6d0069d2dfb2 100644
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
 
 	union {
 		u8 buf[3];
@@ -237,6 +232,31 @@ static int bme680_read_calib(struct bme680_data *data,
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
@@ -244,12 +264,10 @@ static int bme680_read_calib(struct bme680_data *data,
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
@@ -259,10 +277,52 @@ static s16 bme680_compensate_temp(struct bme680_data *data,
 	var2 = (var1 * calib->par_t2) >> 11;
 	var3 = ((var1 >> 1) * (var1 >> 1)) >> 12;
 	var3 = (var3 * ((s32)calib->par_t3 << 4)) >> 14;
-	data->t_fine = var2 + var3;
-	calc_temp = (data->t_fine * 5 + 128) >> 8;
+	return var2 + var3; /* t_fine = var2 + var3 */
+}
+
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
 
-	return calc_temp;
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
@@ -273,12 +333,12 @@ static s16 bme680_compensate_temp(struct bme680_data *data,
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
@@ -306,6 +366,30 @@ static u32 bme680_compensate_press(struct bme680_data *data,
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
@@ -314,12 +398,12 @@ static u32 bme680_compensate_press(struct bme680_data *data,
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
@@ -567,68 +651,35 @@ static int bme680_gas_config(struct bme680_data *data)
 
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
-
-	adc_press = FIELD_GET(BME680_MEAS_TRIM_MASK,
-			      get_unaligned_be24(data->buf));
-	if (adc_press == BME680_MEAS_SKIPPED) {
-		/* reading was skipped */
-		dev_err(dev, "reading pressure skipped\n");
-		return -EINVAL;
-	}
 
-	*val = bme680_compensate_press(data, adc_press);
+	*val = bme680_compensate_press(data, adc_press, t_fine);
 	*val2 = 1000;
 	return IIO_VAL_FRACTIONAL;
 }
@@ -636,30 +687,19 @@ static int bme680_read_press(struct bme680_data *data,
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


