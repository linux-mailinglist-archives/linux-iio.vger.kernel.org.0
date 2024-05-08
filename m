Return-Path: <linux-iio+bounces-4891-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8768C020B
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 18:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5140C286A6A
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 16:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4D21F93E;
	Wed,  8 May 2024 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUNrC1oc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CACF9C3;
	Wed,  8 May 2024 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715186084; cv=none; b=CAqFHrbsewanvMNkhlIhRrLeNpM1ozc85WhqO9DM5eSseviXlNoJvnVBcH8Mc/BoxOUDzlLFTAMmCar318bR9+eU88xCafRnOJHSTJqTNYJ2ol43Rxse9Oat8reT1r8n6jg5Y5w820b93dn2L43eZUfPRe2gAetXj64UfVzgBc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715186084; c=relaxed/simple;
	bh=uJCprQj0d/fuMxBVcO8FSqjPp6Mc3BIdkm9iL8OL/Co=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DAud1WUn5hiuhcMfQxdZfTGo2jrI/tFlk3EO/zCtS6CoiZFEkvJw8i6/CqgQWXEO4LD6h0OwyobZO6CqrfyVsXv1NKHJrDSM0YybBH3V88JTNprPUKeyeRV76K+n0bQ+E8FqIAVSxhUCDBamckJjbY9k86a4MAYZSqsP6tNctW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NUNrC1oc; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59c04839caso1050689566b.2;
        Wed, 08 May 2024 09:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715186081; x=1715790881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ecoUdRdm8TJtWd4XvtflaMn/ctNEXLJheqvwj+nZBY=;
        b=NUNrC1oc6Fhyz2ZOpRuZlajdKAaE8kRG9za3LoVKFFiTWkbQm0dnfkWdvqg9mNZ9L/
         1YvW6JpJHh334AjSSyZBXuNkeE36ojt65XS9Uemo5giOa/ghrtJ3tDc1cybDefKBrma9
         ChMuemJb98zRBTOat0zfsfeG/PV/jSBrq+5/UNDJGtRkSe3qMvD3uEJE7OBGO+LaOdNE
         ROdY5GMRt6mFCI91LCRVGn/kIKWD32I36J1PcGUwtmtKUD03HettUXk8Jd9SdZzXQ9Z0
         tDhpU59JTAXpCa54CEkmNZuMb5WZyjLsB/tuHLKYfArzmp2EKV/prj4/uVvGbtajFn2c
         U2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715186081; x=1715790881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ecoUdRdm8TJtWd4XvtflaMn/ctNEXLJheqvwj+nZBY=;
        b=o2pjGlWbKQJlftPmkeH8Gucwp439um1r8Su4fRaIb+EUp+tk+lbMW1YpDeNrHks7fC
         l2Uhp8QkbBDNEZZRivV4eTHN8D0ROnKRI8noP18nIdGssYVmScdvPcFmdZ9knpy1G7kA
         Olp+6o+bJy7udVd8CgYb4Mhx2bwcltKmV9VNOdg2YB7P9IOqOrv/4Z4NRmACeMeIHNOE
         cnJTnupB84CP9mKuZ+D1wTz9QYowTPL6Z63EfunWyq1M91Mshh71S3odXv1H5amHIBBR
         agT5uACmNSexfwcpidUzgy/ZQGkKfpCEhj45wP9ayDFU8z8byJrTKPmQh2bnrXZPleqd
         QATg==
X-Forwarded-Encrypted: i=1; AJvYcCWuE2/FCPXFKLgnl6VXrEJMeVHE7mR8jkCNAIIS600UeJ3Lq4L43TCxkyJp0V0VvpyJ/3etpcfOThkBmXc55ipH5Km23vdE5dU/wg5sKTbC8Du1cO67jeNwVhR7iHRSDhtRQWNGG4/6
X-Gm-Message-State: AOJu0YxKOMMWh/yTW549QiqGQBOIZ2KMLuTPNBkG+QQZ4GbwvlnfY7i9
	HM/JQLnmlEeLzYLyDVRGKviaxu0F42/pz17PCbdVoOCkDgCN/je4
X-Google-Smtp-Source: AGHT+IGLMYujgyQZmi67nFa4QlF4q6RlTqeOMmTdSg597/YfzWYOorvj97XDx8tCGPoIZMKAtkecfA==
X-Received: by 2002:a17:906:4549:b0:a59:bacc:b083 with SMTP id a640c23a62f3a-a59fb9b84f1mr199711166b.56.1715186081242;
        Wed, 08 May 2024 09:34:41 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:a3c8:644e:cd04:560a])
        by smtp.gmail.com with ESMTPSA id hb4-20020a170906b88400b00a5599f3a057sm7872843ejb.107.2024.05.08.09.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 09:34:40 -0700 (PDT)
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
Subject: [PATCH 4/9] iio: pressure: bmp280: Use unsigned data types for raw sensor data
Date: Wed,  8 May 2024 18:34:20 +0200
Message-Id: <20240508163425.143831-5-vassilisamir@gmail.com>
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


