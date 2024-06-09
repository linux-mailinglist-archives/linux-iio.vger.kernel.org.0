Return-Path: <linux-iio+bounces-6127-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E8E9018B4
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2024 01:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB139B20C30
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 23:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E17C74C08;
	Sun,  9 Jun 2024 23:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dio+v5MM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F88574060;
	Sun,  9 Jun 2024 23:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717976324; cv=none; b=PxuCVHzqK3LMrXnA7dVZF10vkWw4k17gmwUNecEh2XZkRnqCtujje7rJ8SPTNj97LIaqHf6NhSRw3epDnALCpTVOdAm3rIawVgg1jCcXM5CiG9Afx27Mo2biHZQglKKuy3ipq4ngvnxEE338XLGOKUIpYymyLsHtU2Se0DHQ174=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717976324; c=relaxed/simple;
	bh=r2yI9dn0gEm1yR0bBip9V2giKbeGMxeemtfmLYE2FpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C1jWKKck9LrQdc3szzesXDYKSNghvd1KUNlLYFnYqPZQ5hQeWlIi+2wpQxjZc5Hp74pWPX7d5H4FecWCodNNca16ft91kGf789PPW5zpx60w6Q62M4Vu2NvJ8Tn5X+wuSKdWlupRR7cwDgdk4HtZjWR/lT5dICdpHjJRw36pEdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dio+v5MM; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5751bcb3139so4606831a12.1;
        Sun, 09 Jun 2024 16:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717976321; x=1718581121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4YRfCh6nI5u0cnoU4dc0MnEyl+bZMsTTF5DckI6cPc=;
        b=Dio+v5MM5ZA49mDPdd9S9Pba7b8s4WxUpa/y1oBagbuSH9qQnHUzc8AdqKlXDhcAx7
         Q7QBSlvYHsq4i2m3hWQZiQ9eSFCgmkFeMXOLgjLwXmTF5Ee7nb7GCCuGE155YdWYOm/H
         6fylMqeQRERxbeOIkXsH4427deUkbt6Q4kjhWTuFlm+6iETsh+LDLCGbX79KivS33jJS
         YbAn8Yap2pRQRvecSOuGzB89/YrGdZjTbfAthL34RC+Tab+UQPH44iBaYtBcyhsrxGMf
         Skk15tpBxlOb96R4daFOknN//+OUlfMQI+V5xKd1kSnMlkmslQC1rS8OjfnPOjo/7WV6
         S8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717976321; x=1718581121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4YRfCh6nI5u0cnoU4dc0MnEyl+bZMsTTF5DckI6cPc=;
        b=Z7laSEtsUqte7FS2lWcdqjtwK/vPoi1yAXQ4FyyHD6N3mp7ozyRc7ayyy5+6nJHowC
         y2xJzIMmIKpvKhkk4HTc/uvNP/Cv6Ssi6UeV84X4a0K89n+V8hu5di8pNbmawWNqZsem
         H/VHC6DdMQpL8JhMfWgtjE6DkxovXw+3Qqok1YDMdOtpSpsg+3+OtjE4ZkhIY7qJy/u+
         izi7W7kEn+B5gK3iC46hi6ban3V+0ozv36TO4HME8oR+1bdj9eKO9ruOLW8h5DkKzkS+
         ZVHFE5MfU6pgR7cDueIdb4tfXm+wECFnNrM4Yknj8nf1bn0R+5A5pKG497szN4juqaDw
         Hekw==
X-Forwarded-Encrypted: i=1; AJvYcCX4RWk3wCaNSo5wEfnBI6xf4nP21qNQiNpaR7LCYoNCwyqmReblWAfdGJX+kx+XBWVXIEnTniSQQca48sDryQ7rSw+x4Ib1qWhs3TGSsQ02GYF+TC6+fOHBd1ZzTjKUCpUb855Phcy+
X-Gm-Message-State: AOJu0Yzx388l+Hs1kGJGVfedkf52ZrlNDqicaS4jtLNizh316nW6314R
	2lKnUsrIxu5MxL+/RJI80uE6WibnKdIzDAAI+ZCsKIJdvIk+fngO
X-Google-Smtp-Source: AGHT+IGo1LPSdfKL8RuiD+tQ4vy+Ss8Kw8LWyD4CDue3jwEpzeTujOb7m5c3r8MHYRbrhziLfHvFHA==
X-Received: by 2002:a17:906:c106:b0:a6f:1e88:d48f with SMTP id a640c23a62f3a-a6f1e88d574mr104007466b.62.1717976320655;
        Sun, 09 Jun 2024 16:38:40 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:635a:738f:880f:9ea5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f20bb1abesm46063366b.172.2024.06.09.16.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 16:38:40 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v3 09/15] iio: chemical: bme680: Add read buffers in read/write buffer union
Date: Mon, 10 Jun 2024 01:38:20 +0200
Message-Id: <20240609233826.330516-10-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240609233826.330516-1-vassilisamir@gmail.com>
References: <20240609233826.330516-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the buffers that are used in order to read data from the device in
the union which handles all the device read/write buffers. Also create
defines for the number of bytes that are being read from the device and
don't use magic numbers.

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
index 7dfe4bf2f2ae..415816a6cc9b 100644
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


