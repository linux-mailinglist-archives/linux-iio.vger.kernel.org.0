Return-Path: <linux-iio+bounces-4901-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 945F78C0252
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 18:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA22282AB8
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 16:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB00912AAE8;
	Wed,  8 May 2024 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3f06WaB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B180A2E3E8;
	Wed,  8 May 2024 16:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715187145; cv=none; b=cP0Uvt1RU5atgp/FP8NNyNGWHDkDVCrUw4Fjm21Q5/39yIQumUqoaL2zHtW44ZrQX1O+ziNuFbnlWf/kwFz092c44iewGiRvY/pb1X5tHdXOqBIN2vb0e7l+bzWGuAxP8TtqLTtfMjYG/zevkVXOeqyOCWlMU2wVTj0tjMpWFxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715187145; c=relaxed/simple;
	bh=uJCprQj0d/fuMxBVcO8FSqjPp6Mc3BIdkm9iL8OL/Co=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gLyHNwV+4Cn3/ItwjnJ5VfVz5DOaZomX2F/wdHgqwZi0Td8VxEtzPhF0iK5imljNVFCMP9aO4DCADvXN1554GuRidUydjmNiM2MHfiyntTri6F6KkHkBooA3PWedEZw5tie/UyyGGsFBGWlTwh5bbPx6Mwl4YWSe1NVnvk7BWH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3f06WaB; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59cf8140d0so933601566b.3;
        Wed, 08 May 2024 09:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715187142; x=1715791942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ecoUdRdm8TJtWd4XvtflaMn/ctNEXLJheqvwj+nZBY=;
        b=Y3f06WaBvjul/gYn/eQ/qFVuuzoSQat/43Z+VrW5O83NMhrhzRVYjGWFN7LpTuzi7o
         x5Omv1UZO2IHIi/9tZHRXiYqR6EL6q8SxaYXIWfm8RsNyvl9q/L53aI+Lotef+8bGGak
         NeaIWII1ms+W2hRqMxFnj+0V23OsnVdEQ+fUhDRVLvKVz9fBsPWGB5M+6+TJBq4ZoG0k
         XXaTghl7KxuSuTcDGD7CnmBKBemkYJ+xbIQWJ4G2w6AedNUwcT7iSd2UFv5HIs1Y61mL
         6Sc9yXhMnlkhGQn1UPLhAVlVS20KmW+l5goqZo6kaF3xUr/q8BLCnX9eAPraD+mtvgz7
         +6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715187142; x=1715791942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ecoUdRdm8TJtWd4XvtflaMn/ctNEXLJheqvwj+nZBY=;
        b=gQ0P+MhALjuwoPawJvTV79DE/3VJGD7Jteakm1vW24a8Nkne7pV1pQdt8iC9fXzCxN
         oZVCMS7bcVmRcYgLyueywls06hDBKFhaEE91TElYE0To3FmXhEuyTZUYEogJx2nkQjBF
         7izL31dkM2iRmjHUJbCwIGJrduDuibPi87LIwQ96lKNYwEoKF74Geq8Ile01c2MYJLN/
         Durgn8U5oCC/iGGu4V+tJDmNwgW+QwTbq+a2i4ITW0MUV1WyYZRKVYAkizFoQzknNPtG
         XvrzrWGi3CEsicuhU9vIInFfqwc5mTeGdJcb6VGpyX2cvdEmoLb5LPAmd5dpTramGK5P
         8Bow==
X-Forwarded-Encrypted: i=1; AJvYcCX2dWSDZfJKny2EACSJVuJUieFzHZV+IqexIrgUgktmbOfRaoCsh55OdlUosuJnQJjNbPR32lAiTf2rE2s4gYFkzf3YyS1aZ6A/ZKoKJxyFfNPtFmQBOrck3IiDPdtqf0RXvRkpyzLm
X-Gm-Message-State: AOJu0Yy0jW4XUpL6GPOcqK7l35Gt9JakWZayu9JCxSlpFw56Ba2ooteL
	2KacyWwWsyS4bQvHxbSywjy+9kR91skdjs70mMGGAGxYUZ5UM0m3
X-Google-Smtp-Source: AGHT+IEl8eguKcXJDQ2hsuyrBiu4Ki6SKAVdtfIRyE4ixRhqiQjbJyuhqIxghuCuZsND+/ytdmZh1A==
X-Received: by 2002:a17:906:3c59:b0:a59:c963:82b with SMTP id a640c23a62f3a-a59fb951b13mr193321266b.33.1715187142038;
        Wed, 08 May 2024 09:52:22 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:a3c8:644e:cd04:560a])
        by smtp.gmail.com with ESMTPSA id kj24-20020a170907765800b00a59a8212c8esm5648010ejc.42.2024.05.08.09.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 09:52:21 -0700 (PDT)
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
Subject: [PATCH v6 4/9] iio: pressure: bmp280: Use unsigned data types for raw sensor data
Date: Wed,  8 May 2024 18:52:02 +0200
Message-Id: <20240508165207.145554-5-vassilisamir@gmail.com>
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

The raw sensor data that have not been compensated yet cannot be
signed values, so use unsigned ones. Also, compensated pressure
values cannot be negative so use unsigned also there.

Also, drop redundant cast of data->t_fine variable from s32 to s32.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 45 +++++++++++++++---------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index f05ea754f53a..dd5c526dacbd 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -289,13 +289,13 @@ static int bme280_read_calib(struct bmp280_data *data)
  * Taken from BME280 datasheet, Section 4.2.3, "Compensation formula".
  */
 static u32 bme280_compensate_humidity(struct bmp280_data *data,
-				      s32 adc_humidity)
+				      u16 adc_humidity)
 {
 	struct bmp280_calib *calib = &data->calib.bmp280;
 	s32 var;
 
-	var = ((s32)data->t_fine) - (s32)76800;
-	var = ((((adc_humidity << 14) - (calib->H4 << 20) - (calib->H5 * var))
+	var = data->t_fine - (s32)76800;
+	var = (((((s32)adc_humidity << 14) - (calib->H4 << 20) - (calib->H5 * var))
 		+ (s32)16384) >> 15) * (((((((var * calib->H6) >> 10)
 		* (((var * (s32)calib->H3) >> 11) + (s32)32768)) >> 10)
 		+ (s32)2097152) * calib->H2 + 8192) >> 14);
@@ -314,16 +314,16 @@ static u32 bme280_compensate_humidity(struct bmp280_data *data,
  * Taken from datasheet, Section 3.11.3, "Compensation formula".
  */
 static s32 bmp280_compensate_temp(struct bmp280_data *data,
-				  s32 adc_temp)
+				  u32 adc_temp)
 {
 	struct bmp280_calib *calib = &data->calib.bmp280;
 	s32 var1, var2;
 
-	var1 = (((adc_temp >> 3) - ((s32)calib->T1 << 1)) *
+	var1 = (((((s32)adc_temp) >> 3) - ((s32)calib->T1 << 1)) *
 		((s32)calib->T2)) >> 11;
-	var2 = (((((adc_temp >> 4) - ((s32)calib->T1)) *
-		  ((adc_temp >> 4) - ((s32)calib->T1))) >> 12) *
-		((s32)calib->T3)) >> 14;
+	var2 = (((((((s32)adc_temp) >> 4) - ((s32)calib->T1)) *
+		  ((((s32)adc_temp >> 4) - ((s32)calib->T1))) >> 12) *
+		((s32)calib->T3))) >> 14;
 	data->t_fine = var1 + var2;
 
 	return (data->t_fine * 5 + 128) >> 8;
@@ -337,7 +337,7 @@ static s32 bmp280_compensate_temp(struct bmp280_data *data,
  * Taken from datasheet, Section 3.11.3, "Compensation formula".
  */
 static u32 bmp280_compensate_press(struct bmp280_data *data,
-				   s32 adc_press)
+				   u32 adc_press)
 {
 	struct bmp280_calib *calib = &data->calib.bmp280;
 	s64 var1, var2, p;
@@ -353,7 +353,7 @@ static u32 bmp280_compensate_press(struct bmp280_data *data,
 	if (var1 == 0)
 		return 0;
 
-	p = ((((s64)1048576 - adc_press) << 31) - var2) * 3125;
+	p = ((((s64)1048576 - (s32)adc_press) << 31) - var2) * 3125;
 	p = div64_s64(p, var1);
 	var1 = (((s64)calib->P9) * (p >> 13) * (p >> 13)) >> 25;
 	var2 = ((s64)(calib->P8) * p) >> 19;
@@ -365,7 +365,8 @@ static u32 bmp280_compensate_press(struct bmp280_data *data,
 static int bmp280_read_temp(struct bmp280_data *data,
 			    int *val, int *val2)
 {
-	s32 adc_temp, comp_temp;
+	s32 comp_temp;
+	u32 adc_temp;
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
@@ -398,8 +399,7 @@ static int bmp280_read_temp(struct bmp280_data *data,
 static int bmp280_read_press(struct bmp280_data *data,
 			     int *val, int *val2)
 {
-	u32 comp_press;
-	s32 adc_press;
+	u32 comp_press, adc_press;
 	int ret;
 
 	/* Read and compensate temperature so we get a reading of t_fine. */
@@ -431,7 +431,7 @@ static int bmp280_read_press(struct bmp280_data *data,
 static int bme280_read_humid(struct bmp280_data *data, int *val, int *val2)
 {
 	u32 comp_humidity;
-	s32 adc_humidity;
+	u16 adc_humidity;
 	int ret;
 
 	/* Read and compensate temperature so we get a reading of t_fine. */
@@ -1030,8 +1030,7 @@ static int bmp380_read_temp(struct bmp280_data *data, int *val, int *val2)
 
 static int bmp380_read_press(struct bmp280_data *data, int *val, int *val2)
 {
-	s32 comp_press;
-	u32 adc_press;
+	u32 adc_press, comp_press;
 	int ret;
 
 	/* Read and compensate for temperature so we get a reading of t_fine */
@@ -1893,12 +1892,12 @@ static int bmp180_read_calib(struct bmp280_data *data)
  *
  * Taken from datasheet, Section 3.5, "Calculating pressure and temperature".
  */
-static s32 bmp180_compensate_temp(struct bmp280_data *data, s32 adc_temp)
+static s32 bmp180_compensate_temp(struct bmp280_data *data, u32 adc_temp)
 {
 	struct bmp180_calib *calib = &data->calib.bmp180;
 	s32 x1, x2;
 
-	x1 = ((adc_temp - calib->AC6) * calib->AC5) >> 15;
+	x1 = ((((s32)adc_temp) - calib->AC6) * calib->AC5) >> 15;
 	x2 = (calib->MC << 11) / (x1 + calib->MD);
 	data->t_fine = x1 + x2;
 
@@ -1907,7 +1906,8 @@ static s32 bmp180_compensate_temp(struct bmp280_data *data, s32 adc_temp)
 
 static int bmp180_read_temp(struct bmp280_data *data, int *val, int *val2)
 {
-	s32 adc_temp, comp_temp;
+	s32 comp_temp;
+	u32 adc_temp;
 	int ret;
 
 	ret = bmp180_read_adc_temp(data, &adc_temp);
@@ -1957,7 +1957,7 @@ static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
  *
  * Taken from datasheet, Section 3.5, "Calculating pressure and temperature".
  */
-static u32 bmp180_compensate_press(struct bmp280_data *data, s32 adc_press)
+static u32 bmp180_compensate_press(struct bmp280_data *data, u32 adc_press)
 {
 	struct bmp180_calib *calib = &data->calib.bmp180;
 	s32 oss = data->oversampling_press;
@@ -1974,7 +1974,7 @@ static u32 bmp180_compensate_press(struct bmp280_data *data, s32 adc_press)
 	x2 = (calib->B1 * ((b6 * b6) >> 12)) >> 16;
 	x3 = (x1 + x2 + 2) >> 2;
 	b4 = calib->AC4 * (u32)(x3 + 32768) >> 15;
-	b7 = ((u32)adc_press - b3) * (50000 >> oss);
+	b7 = (adc_press - b3) * (50000 >> oss);
 	if (b7 < 0x80000000)
 		p = (b7 * 2) / b4;
 	else
@@ -1989,8 +1989,7 @@ static u32 bmp180_compensate_press(struct bmp280_data *data, s32 adc_press)
 
 static int bmp180_read_press(struct bmp280_data *data, int *val, int *val2)
 {
-	u32 comp_press;
-	s32 adc_press;
+	u32 comp_press, adc_press;
 	int ret;
 
 	/* Read and compensate temperature so we get a reading of t_fine. */
-- 
2.25.1


