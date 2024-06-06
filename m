Return-Path: <linux-iio+bounces-5960-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB3F8FF6C9
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 23:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A00280F77
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 21:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4840A19B595;
	Thu,  6 Jun 2024 21:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bj/gpXI3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256E419DF4C;
	Thu,  6 Jun 2024 21:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717709053; cv=none; b=qo2h/7rhgfy/+ldQ61bopGzDwxRlwD5FuUcrytRNB8gV1/dUKXbgARMvCunYhaGFt9z99ql9DcjAKioFTJ74RRxP6U7RjjgCQonJQDmHuieeiVfo7LgQjmFwyicplQfMCvy69U69nBygvEITes0MKfhUpZBIToNQ4yJKAzmwfTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717709053; c=relaxed/simple;
	bh=td7HH4arkiNuNGtODy8qhObxEuS32q+gi5snH3/4s0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zldm+9wND8Xk6kiqLGZTzdFMpH1GokNlEHciqmjzEoMR+hn4D9X99L3IEC3ySsVXx1C9yPN+d3Fu3rF7L4u+VOT97G5dpV4JnqjIMQKyEuLqz5klz91IKnFiXzjwPe77Xgu/ZTk+KAQ6msa3fA31dpM7L3tu5Dgr3hLnkx6j3uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bj/gpXI3; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a692130eb19so157702466b.2;
        Thu, 06 Jun 2024 14:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717709049; x=1718313849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3hJmKI5Mi8gc5sO4N5FOjXE0iLeocLoY1TsF7XbV0o=;
        b=bj/gpXI3b7Exq53cnZcm0A/Kv5d37xiH8V1AHnkYEGCcU0Is2A+Ti2N0cLO5MYGy89
         Val+fcVkP+3KtWQcTTu8I2FF5hK1ODdOk0eyHd+W2iqbOFzyq+J2SF4E4EJXBHYGgX6J
         DAdZ1s8iAmfImu6kbr1/oxmi56F8WFZca2xpOIOH3VjdsTccgBQIknyu8bcR5Q0QdiFm
         mFQ84IGOoobxw2O1UWUmex9quUZPkLOlmlccCsBmsANPXPjkzNHpWZscJN5PTWLjPdGH
         vkuiiEQT+j5BPtMZm/DVw97eLdmTPzD5eqhC58X3Zbysbp4wOE44kivSe+7M+ll5qjeK
         8gfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717709049; x=1718313849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3hJmKI5Mi8gc5sO4N5FOjXE0iLeocLoY1TsF7XbV0o=;
        b=w+p9DNdfIZqqdj2eMSmLUEdlwFefvDAvdRnCmbPE8xXR5kl515s0MPizXI/+xtetbN
         1hm0HhZFPpAjYlWJ2hpI8NRXp7dLJPkNIsvaUQAYIvOjDMSBq5LSI3nnprjxgMrj7o/3
         yEsARxfooA/fi3X73rm7M0iFJSJPpR8w9R9CPv1Hg6H9dj+PFHjNayMgOnfHKac3XAfT
         SfYjBRsKydgnt39U7F0+NbA1WLsGFI8avX/R9fsod87KujFgQXb0gCzlyCD4Tf67hHqq
         cDVFcu4GXJJpbNjUn2oTamWQbztj+gaMnRL/i4AUPYmTOaIrsosrSvlbtvSIkzfg4UXD
         M/mw==
X-Forwarded-Encrypted: i=1; AJvYcCXbGU32RWSkCKg6bjGbMJBrhpufP9TFkKKfmO9cs+UtAKToblTriIGX0q1oZEG981573DgsUYxySRx5OzF2fX36QSlJT01Gd0+OFLkYiAt6c5QTMgX+aDxvgbkwVT8Ix5/jGgBxkx/l
X-Gm-Message-State: AOJu0YxFyAvNlLEVU+iN71wxYhwBauOvmOyVwWmsp1kTNkDLpBf1m6Dp
	iBv29giaHyewlaxpf9hSTVijZytkzpe/RN5zYRt+Suk6GeFv7eJj
X-Google-Smtp-Source: AGHT+IGMC7b+ed17+ufi8m262KcvXwMaHCkD31Iyh2kWDxojKu9uFLR0459KklsxdTqhEHLnTVJqGA==
X-Received: by 2002:a17:906:c9cb:b0:a68:f77f:41e6 with SMTP id a640c23a62f3a-a6cdbfec30fmr45269666b.73.1717709049426;
        Thu, 06 Jun 2024 14:24:09 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:28a0:434b:ab8b:94ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8058272bsm146690566b.18.2024.06.06.14.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 14:24:08 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v2 13/19] iio: chemical: bme680: Add read buffers in union
Date: Thu,  6 Jun 2024 23:23:07 +0200
Message-Id: <20240606212313.207550-16-vassilisamir@gmail.com>
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
 drivers/iio/chemical/bme680_core.c | 47 +++++++++++++++---------------
 2 files changed, 30 insertions(+), 24 deletions(-)

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
index b13797f7d873..3c33c21b5d6a 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -111,10 +111,13 @@ struct bme680_data {
 	s32 t_fine;
 
 	union {
+		u8 buf[3];
+		unsigned int check;
+		__be16 be16;
 		u8 bme680_cal_buf_1[BME680_CALIB_RANGE_1_LEN];
 		u8 bme680_cal_buf_2[BME680_CALIB_RANGE_2_LEN];
 		u8 bme680_cal_buf_3[BME680_CALIB_RANGE_3_LEN];
-	}; 
+	};
 };
 
 static const struct regmap_range bme680_volatile_ranges[] = {
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


