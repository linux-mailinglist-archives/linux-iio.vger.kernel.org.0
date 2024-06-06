Return-Path: <linux-iio+bounces-5958-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE99C8FF6C5
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 23:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 547D11F260D6
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2024 21:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E800419DF41;
	Thu,  6 Jun 2024 21:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmlHRW4K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE1D19CD1F;
	Thu,  6 Jun 2024 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717709050; cv=none; b=iNy8XwqEjCJmcalgLM2OKUybyLZFVZCP3P56K/FECspE1XM8Gi2MujoEH79WEHbJJ8G/dK0jAvnKVp9H2VmJDtCHEZMUC6ZEg5w63F5DafeJTDRDNtvLhhrxvpwlPd5CLDniLvfnB5mRHdnUtWpZpYgsyWl0VN71+AUjr6lUdAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717709050; c=relaxed/simple;
	bh=QmwDeeQRdPeRv1tG38iYJ7hw5WBCcBntJgCXUQ1vSfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dYKLzH3VVei7xg+7L2gznmNOmux0KZ/Pa0hUT8kYCAHWOG8fOvXryT1oKtMWTBKAUaPaom9nxltnZiwaHqqYS4TCwkRUpCFJk3bGuFgD4VqIW85Rg+YxKRZP0GfgIjc7p6q8tyK2tTRUwxeI8q90e1+OU9vy1PCSCQfXKV/bSlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmlHRW4K; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-35ef1e928c9so1685269f8f.3;
        Thu, 06 Jun 2024 14:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717709047; x=1718313847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/Xywdqe8DkSJdukhHoCiBUq2ZHXZimgJW2gIHn3CHM=;
        b=GmlHRW4KjJrfPNA7hNxuh8hK7k2f5om9/qoZp+pxuYoVtAt+dR0j0vR/oSsMAeEf7r
         t4JC3lyCSlcMZ+uUwbDFzS5ff/w8rKSCRXqOoZNywAUHi/seIE/rlvz8nAGS0GSLHxkh
         /LJFz155gr3fhKU2sBWT2mdRHainnBYAR8WDvcJyTQRLSwq3VFwN5sf1krzzEbLkDOOE
         wHY2JpNpJoyl9m4RCF1+y7SpalbQL4jLVEyYMyFoWZlLN15AgijV4WO8g79HtWL23Yd5
         q+Cr0DbI9wzKE2beMcgMNlIAd13qMN04MGmpZDbMOmQqW/zup8/8lKylRX9Iw1nQ0B7c
         pabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717709047; x=1718313847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/Xywdqe8DkSJdukhHoCiBUq2ZHXZimgJW2gIHn3CHM=;
        b=I41bjGP2QfrY69itrj8BFye2SHLYtX6z4Di8YtYypZjmDlGiL0mGp0Y1qx+0DBEPEr
         E6tK1iq2IEFMmRKIQix7jOFS7DYJ1JugdxWkNq1s3L/C8oNNPtO6ne3pbLEkUz8uF7iB
         MAxZfIuzLj9STZ21tklfTweyCj2Ecg4CYWVlxWUYBrPYSbAZQ0rc59AOzSpoV/IjRIUT
         Ysc3beGm12xMOLFWVphZcPsXEUL5AgokiCNBCa5DGnmiMvb4Zwmkig2RFlTjCcc+GPb6
         Dt2IqKwCYlhAEdw+MSPWuqmJnjK9AVaNt75qhgT2E0fzQ977jo4CgvTIWzpV9xAiAEkx
         ws/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxbXbxrIwdafopln99Mf5EjK8pwBy0rIbYqkzfFXOUXd/dXwr0QbS2XxZjGDfjYAGzBg4YJQyTRjSJPdUx7hUZ+z48eVUtp0ARfG+vJDqrGvN+umiTIIUSsrQn1iYcLJGJlv6j4qQl
X-Gm-Message-State: AOJu0YzYOyPTbTY46v8Au+tY4C0ZdOQJFGSCngr8nASeJkZT7heOcpES
	j9Q3XkMIuJNgJx8TifETqibKZGdhDoe97orSbfQf/ydEYk7L4zI192nK2C2oo78=
X-Google-Smtp-Source: AGHT+IEZ1yDCGHplSK/ZtTLyU1ooHMGPNodfNlUtzsLgkVqeTcYbxBv6bFhJeLId4udhTOIO+zB91Q==
X-Received: by 2002:adf:fa0a:0:b0:34a:35c7:22a3 with SMTP id ffacd0b85a97d-35efed3d400mr714718f8f.20.1717709047183;
        Thu, 06 Jun 2024 14:24:07 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:28a0:434b:ab8b:94ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8058272bsm146690566b.18.2024.06.06.14.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 14:24:06 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dpfrey@gmail.com,
	himanshujha199640@gmail.com,
	lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mike.looijmans@topic.nl,
	vassilisamir@gmail.com
Subject: [PATCH v2 13/19] iio: chemical: bme680: Add read buffers in DMA safe region
Date: Thu,  6 Jun 2024 23:23:05 +0200
Message-Id: <20240606212313.207550-14-vassilisamir@gmail.com>
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
device in a DMA-safe region. Also create defines for the number
of bytes that are being read from the device and don't use
magic numbers.

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
index 538696ac4205..99259d0cf13d 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -115,6 +115,9 @@ struct bme680_data {
 	 * transfer buffers to live in their own cache lines.
 	 */
 	union {
+		u8 buf[3];
+		unsigned int check;
+		__be16 be16;
 		u8 bme680_cal_buf_1[BME680_CALIB_RANGE_1_LEN];
 		u8 bme680_cal_buf_2[BME680_CALIB_RANGE_2_LEN];
 		u8 bme680_cal_buf_3[BME680_CALIB_RANGE_3_LEN];
@@ -453,7 +456,6 @@ static u8 bme680_oversampling_to_reg(u8 val)
 static int bme680_wait_for_eoc(struct bme680_data *data)
 {
 	struct device *dev = regmap_get_device(data->regmap);
-	unsigned int check;
 	int ret;
 	/*
 	 * (Sum of oversampling ratios * time per oversampling) +
@@ -466,16 +468,16 @@ static int bme680_wait_for_eoc(struct bme680_data *data)
 
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
@@ -564,7 +566,6 @@ static int bme680_read_temp(struct bme680_data *data, int *val)
 {
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
-	__be32 tmp = 0;
 	u32 adc_temp;
 	s16 comp_temp;
 
@@ -578,13 +579,14 @@ static int bme680_read_temp(struct bme680_data *data, int *val)
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
@@ -610,7 +612,6 @@ static int bme680_read_press(struct bme680_data *data,
 {
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
-	__be32 tmp = 0;
 	u32 adc_press;
 
 	/* Read and compensate temperature to get a reading of t_fine */
@@ -619,13 +620,14 @@ static int bme680_read_press(struct bme680_data *data,
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
@@ -642,7 +644,6 @@ static int bme680_read_humid(struct bme680_data *data,
 {
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
-	__be16 tmp = 0;
 	u16 adc_humidity;
 	u32 comp_humidity;
 
@@ -652,13 +653,13 @@ static int bme680_read_humid(struct bme680_data *data,
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
@@ -676,8 +677,6 @@ static int bme680_read_gas(struct bme680_data *data,
 {
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
-	__be16 tmp = 0;
-	unsigned int check;
 	u16 adc_gas_res, gas_regs_val;
 	u8 gas_range;
 
@@ -697,19 +696,20 @@ static int bme680_read_gas(struct bme680_data *data,
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
@@ -838,7 +838,6 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 {
 	struct iio_dev *indio_dev;
 	struct bme680_data *data;
-	unsigned int val;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
@@ -869,15 +868,15 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
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


