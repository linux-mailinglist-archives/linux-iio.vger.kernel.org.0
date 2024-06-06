Return-Path: <linux-iio+bounces-5959-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C898FF6C6
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 23:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F020E1F22361
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 21:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CC119DF64;
	Thu,  6 Jun 2024 21:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d10i3E95"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D1B19D074;
	Thu,  6 Jun 2024 21:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717709051; cv=none; b=DHqGkmx8hlvdFYGmjxTe5h+UO+lVus+Nu0I2R6xd2xnFvbcZk5LA5knJsXz/GXUwgbtl/mhqRcYs0Qf4KSN/xJdsrrNCF8346SGQDsUr9kCrvOmrqmpDooWudcQaZSc+AAZOeHQh0KqD78t5Z2m3dXutNFDtL7sKikfYFlBhNYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717709051; c=relaxed/simple;
	bh=oaQTGyxGPjbqBajXp7jjrspFVvNhAFfu/BujcL7Qe4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qKUMw3ahcDQZY1cRdIklbsca/d2dYDM9Kn4+tfyIXbsNzGPKqqmAgO7ZBSgWDeuGOs0wZi751pjSGszj+ya1sQ/E/B5DuRHtlOK1pYnUbYigv5HCqph8Ah0vn3T4qTAIuxoxP0kF5iatjWTHS79C1SQCdwmYYM45VEF0BHDdS3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d10i3E95; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a2406f951so1754069a12.1;
        Thu, 06 Jun 2024 14:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717709048; x=1718313848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EaOsOaYf/7LcQ86mO6uOU7J8W4GCc5BrEGKCRrUVKM=;
        b=d10i3E95VO8a/U4chFTW6daoDxDSyji3lXWXAKXZEQ4xiZQ5qEosCvWyrT8f/SkQbm
         Rpe7pN8j52wC3ONGsgMYUgETA+DdejivEBG7x/LnpXScgDenYU1UH0XHW4MQf3TjiX/B
         r4nXSI0FQtIUeQm6780Jk4p4y46C90TcO7jF/fRsvGKABK2fF7A+N4Sm3yJ36EECkKnJ
         EB/JXnhOhkY05cuOEyP4qXzE3ryfFM3cH8BXb6hIDaCLZTh30ifjTMTugtAeLOl6F7BP
         l4tn4KDpqrNzXiJ850E2oqJ4XsTEBGSEJO05A9relMicEw22CQL6j/WxhGPGR+Yyrnqs
         dH0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717709048; x=1718313848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8EaOsOaYf/7LcQ86mO6uOU7J8W4GCc5BrEGKCRrUVKM=;
        b=Yeji6Z8dkZ0Dsd2Vsw4DqeMH351+Of1jkgut+gezLw3v/Dlo8OKZbQZylYVwcXLlaN
         7bmQ2u9Pr44xq+P0YfR9Br883STIVaCCxtUi1mPd2DZ+njtuFeBG0gU86yXG9RuvMxrw
         fuhRdinKxgXbHs2znF4mwFH18xWzICRAUOLVvLFLpRaKPwJZSqTFRfLmQO1NLrVSTdSR
         NVHP2K8Z2PQYrsFr2Q6xYEueSygQ0Z7U4uo4BcSoSpTm8y90KDlMDDiSZ+Q4PF18iDlu
         qCk9rNDVCMgVAF1Nq0UrMTjETG8WbXk5KTnbGVyURT8s5g7G9vREyr0HdSInnRGszgan
         Vf/w==
X-Forwarded-Encrypted: i=1; AJvYcCVjoEmEdZDDh7M6JgN5HpzGpLKAkpnIBSjMRUjGBZCVwVYKGk+FaAcSxSxjP4sNPxCm+x3mIHfY+Gxl9CJfkxVm0NlBtSWmpES0tT9rQx9VtpfyO6tmDwFVDshgEXwGC74+7oyhlefe
X-Gm-Message-State: AOJu0YwHqV+B87PWIY1LZeU9bSQDorjpNmic3Z/gW+I3OjGUTrMcvb38
	w/hTzj4h/WiHueJwvOAhVG7v82zAck9IY7eLS2wuxhlCyceES40f
X-Google-Smtp-Source: AGHT+IG8CkUP8ZDUMID8nseOMa8nG2vnELSrSZA8EUwcjtynf6vvmEMraQFKrzek2F8MzpPHmRH/BQ==
X-Received: by 2002:a17:906:1157:b0:a68:f8b9:ffa3 with SMTP id a640c23a62f3a-a6cd7891afbmr53168266b.46.1717709048165;
        Thu, 06 Jun 2024 14:24:08 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:28a0:434b:ab8b:94ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8058272bsm146690566b.18.2024.06.06.14.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 14:24:07 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v2 13/19] iio: chemical: bme680: Add read buffers in read/write buffer union
Date: Thu,  6 Jun 2024 23:23:06 +0200
Message-Id: <20240606212313.207550-15-vassilisamir@gmail.com>
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

Move the buffers that are used in order to read data from the
device in the union which handles all the device read/write
buffers. Also create defines for the number of bytes that are
being read from the device and don't use magic numbers.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680.h      |  7 +++++
 drivers/iio/chemical/bme680_core.c | 45 +++++++++++++++---------------
 2 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
index 8d0f53c05d7d..7d0ff294725a 100644
--- a/drivers/iio/chemical/bme680.h
+++ b/drivers/iio/chemical/bme680.h
@@ -56,6 +56,13 @@
 #define   BME680_GAS_MEAS_BIT			BIT(6)
 #define   BME680_MEAS_BIT			BIT(5)
 
+#define BME680_TEMP_NUM_BYTES			3
+#define BME680_PRESS_NUM_BYTES			3
+#define BME680_HUMID_NUM_BYTES			2
+#define BME680_GAS_NUM_BYTES			2
+
+#define BME680_MEAS_TRIM_MASK			GENMASK(24, 4)
+
 /* Calibration Parameters */
 #define BME680_T2_LSB_REG	0x8A
 #define BME680_H2_MSB_REG	0xE1
diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 9d33952e5d01..3c33c21b5d6a 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -111,6 +111,9 @@ struct bme680_data {
 	s32 t_fine;
 
 	union {
+		u8 buf[3];
+		unsigned int check;
+		__be16 be16;
 		u8 bme680_cal_buf_1[BME680_CALIB_RANGE_1_LEN];
 		u8 bme680_cal_buf_2[BME680_CALIB_RANGE_2_LEN];
 		u8 bme680_cal_buf_3[BME680_CALIB_RANGE_3_LEN];
@@ -449,7 +452,6 @@ static u8 bme680_oversampling_to_reg(u8 val)
 static int bme680_wait_for_eoc(struct bme680_data *data)
 {
 	struct device *dev = regmap_get_device(data->regmap);
-	unsigned int check;
 	int ret;
 	/*
 	 * (Sum of oversampling ratios * time per oversampling) +
@@ -462,16 +464,16 @@ static int bme680_wait_for_eoc(struct bme680_data *data)
 
 	usleep_range(wait_eoc_us, wait_eoc_us + 100);
 
-	ret = regmap_read(data->regmap, BME680_REG_MEAS_STAT_0, &check);
+	ret = regmap_read(data->regmap, BME680_REG_MEAS_STAT_0, &data->check);
 	if (ret) {
 		dev_err(dev, "failed to read measurement status register.\n");
 		return ret;
 	}
-	if (check & BME680_MEAS_BIT) {
+	if (data->check & BME680_MEAS_BIT) {
 		dev_err(dev, "Device measurement cycle incomplete.\n");
 		return -EBUSY;
 	}
-	if (!(check & BME680_NEW_DATA_BIT)) {
+	if (!(data->check & BME680_NEW_DATA_BIT)) {
 		dev_err(dev, "No new data available from the device.\n");
 		return -ENODATA;
 	}
@@ -560,7 +562,6 @@ static int bme680_read_temp(struct bme680_data *data, int *val)
 {
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
-	__be32 tmp = 0;
 	u32 adc_temp;
 	s16 comp_temp;
 
@@ -574,13 +575,14 @@ static int bme680_read_temp(struct bme680_data *data, int *val)
 		return ret;
 
 	ret = regmap_bulk_read(data->regmap, BME680_REG_TEMP_MSB,
-			       &tmp, 3);
+			       data->buf, BME680_TEMP_NUM_BYTES);
 	if (ret < 0) {
 		dev_err(dev, "failed to read temperature\n");
 		return ret;
 	}
 
-	adc_temp = be32_to_cpu(tmp) >> 12;
+	adc_temp = FIELD_GET(BME680_MEAS_TRIM_MASK,
+			     get_unaligned_be24(data->buf));
 	if (adc_temp == BME680_MEAS_SKIPPED) {
 		/* reading was skipped */
 		dev_err(dev, "reading temperature skipped\n");
@@ -606,7 +608,6 @@ static int bme680_read_press(struct bme680_data *data,
 {
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
-	__be32 tmp = 0;
 	u32 adc_press;
 
 	/* Read and compensate temperature to get a reading of t_fine */
@@ -615,13 +616,14 @@ static int bme680_read_press(struct bme680_data *data,
 		return ret;
 
 	ret = regmap_bulk_read(data->regmap, BME680_REG_PRESS_MSB,
-			       &tmp, 3);
+			       data->buf, BME680_PRESS_NUM_BYTES);
 	if (ret < 0) {
 		dev_err(dev, "failed to read pressure\n");
 		return ret;
 	}
 
-	adc_press = be32_to_cpu(tmp) >> 12;
+	adc_press = FIELD_GET(BME680_MEAS_TRIM_MASK,
+			      get_unaligned_be24(data->buf));
 	if (adc_press == BME680_MEAS_SKIPPED) {
 		/* reading was skipped */
 		dev_err(dev, "reading pressure skipped\n");
@@ -638,7 +640,6 @@ static int bme680_read_humid(struct bme680_data *data,
 {
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
-	__be16 tmp = 0;
 	u16 adc_humidity;
 	u32 comp_humidity;
 
@@ -648,13 +649,13 @@ static int bme680_read_humid(struct bme680_data *data,
 		return ret;
 
 	ret = regmap_bulk_read(data->regmap, BME680_REG_HUMIDITY_MSB,
-			       &tmp, sizeof(tmp));
+			       &data->be16, BME680_HUMID_NUM_BYTES);
 	if (ret < 0) {
 		dev_err(dev, "failed to read humidity\n");
 		return ret;
 	}
 
-	adc_humidity = be16_to_cpu(tmp);
+	adc_humidity = be16_to_cpu(data->be16);
 	if (adc_humidity == BME680_MEAS_SKIPPED) {
 		/* reading was skipped */
 		dev_err(dev, "reading humidity skipped\n");
@@ -672,8 +673,6 @@ static int bme680_read_gas(struct bme680_data *data,
 {
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
-	__be16 tmp = 0;
-	unsigned int check;
 	u16 adc_gas_res, gas_regs_val;
 	u8 gas_range;
 
@@ -693,19 +692,20 @@ static int bme680_read_gas(struct bme680_data *data,
 	if (ret)
 		return ret;
 
-	ret = regmap_read(data->regmap, BME680_REG_MEAS_STAT_0, &check);
-	if (check & BME680_GAS_MEAS_BIT) {
+	ret = regmap_read(data->regmap, BME680_REG_MEAS_STAT_0, &data->check);
+	if (data->check & BME680_GAS_MEAS_BIT) {
 		dev_err(dev, "gas measurement incomplete\n");
 		return -EBUSY;
 	}
 
 	ret = regmap_bulk_read(data->regmap, BME680_REG_GAS_MSB,
-			       &tmp, sizeof(tmp));
+			       &data->be16, BME680_GAS_NUM_BYTES);
 	if (ret < 0) {
 		dev_err(dev, "failed to read gas resistance\n");
 		return ret;
 	}
-	gas_regs_val = be16_to_cpu(tmp);
+
+	gas_regs_val = be16_to_cpu(data->be16);
 	adc_gas_res = FIELD_GET(BME680_ADC_GAS_RES, gas_regs_val);
 
 	/*
@@ -834,7 +834,6 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 {
 	struct iio_dev *indio_dev;
 	struct bme680_data *data;
-	unsigned int val;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
@@ -865,15 +864,15 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 		return ret;
 	}
 
-	ret = regmap_read(regmap, BME680_REG_CHIP_ID, &val);
+	ret = regmap_read(regmap, BME680_REG_CHIP_ID, &data->check);
 	if (ret < 0) {
 		dev_err(dev, "Error reading chip ID\n");
 		return ret;
 	}
 
-	if (val != BME680_CHIP_ID_VAL) {
+	if (data->check != BME680_CHIP_ID_VAL) {
 		dev_err(dev, "Wrong chip ID, got %x expected %x\n",
-			val, BME680_CHIP_ID_VAL);
+			data->check, BME680_CHIP_ID_VAL);
 		return -ENODEV;
 	}
 
-- 
2.25.1


