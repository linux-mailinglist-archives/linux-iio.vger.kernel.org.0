Return-Path: <linux-iio+bounces-5376-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F08F28D0A05
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 20:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8292A1F22E14
	for <lists+linux-iio@lfdr.de>; Mon, 27 May 2024 18:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2B5167DA8;
	Mon, 27 May 2024 18:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeUT3kzo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF265167283;
	Mon, 27 May 2024 18:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716835108; cv=none; b=j9eiF8tE7nNc27asDk1A025uNp/UdUoUx71M//KVEwuM+Wf6AtiLYQ16y5SnnCiTN/dFux5aL3Z+SVtw0y1UOQ6mcGKp+yLYu+q9NqufFcXxCpYQ93jHMoEZFqwdAJXVzE4m1nOROZbMYB3s4hC8+DAcgXfpHTZ4LAgopkhEgrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716835108; c=relaxed/simple;
	bh=39PDmXjTat2LrOJYPlMZ4r4AFk1Kb3ruqgQ4CjrEI5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SWw1h0xYZdrvfEjGK59jPw3xMWzW64saAFAocW0Y0gQB7NtRWhdXepMYO7jMo+qLNe2oAnHDLumUjbFyW4doIzWURv7bvEkjnjoyblA68owT7m5bEVyfiu4vCdIZFMXd7iSbWRuQSqgKiAI5sU1l+YIGTr8rLtQV0PHCFgn+2E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeUT3kzo; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-578972defb3so12663a12.2;
        Mon, 27 May 2024 11:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716835105; x=1717439905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jK5lmerkNYbstPfL+gYcg+7vPHVC5CUiywbb5O2E4Wc=;
        b=EeUT3kzoTn7NojXcgr0izMwBH89sEfRpYvGwHN3g2z2becCyuR44m6evtKjRgyJC/u
         4CdwvXIEJP89ftYSxEXKXGxKOgeczB/WDTQdQXzJ0CrCoJnjME+8vGAO83KsDL1A38ea
         gFrCmDuCUkO64hyUDVAmZa5POgisXQMpgtTQlluBrstJTfmPk0iZuofkxsMmh+oQmftf
         jjnL2ZKwCoHj3rF/fLfw9XWhcEyS7MUJKxZ5R/AVIsb3KvL3WTA5ZnYRILlMAOssUFb7
         cUvG/w9/9Hw8xkKMG9KVVVnjf3EeBbOr6KBScYtrt6U9UGav8+gQnVORmqcx86b3jucH
         mJnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716835105; x=1717439905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jK5lmerkNYbstPfL+gYcg+7vPHVC5CUiywbb5O2E4Wc=;
        b=qBGr4ssA9Rv/G2KV7A6v0h+M2wdjrDJN+ai4VGs5hTyROSP5Hd2HoP0VUqxMvrr2D1
         T4vlt5EbTqI5IDj8oxca9eqs1ffKncIhUTSbnXz84/bSpKxSEdi7bpKTDT51NyoAOuwE
         O7rAZCJsamBqGhfswpOHhUp0tg/aZcDn5Rh/UiErOlMuP3ydfj/Zx1Tgy2EUOfCglTDm
         9+6KIHVPTbFAcSBMsfVCiTAJ/KaEcwN/58/l1O9+8mEspKazV/gDSs3yROTTi6y9nX8P
         AbLieHTQXs4k03RzjY1AxO76nkc9dRbOLobjrHByLTbVivPtgwLnN/voZwVU7AH7qHup
         8+dg==
X-Forwarded-Encrypted: i=1; AJvYcCW8Dc2W20AER2V0cEttNhzFtRpAuExPdEAlWlC9OHgTOudMmtOMFnBSIjGtQKk9+jg4DPHP9PyzrN2eiE/1SC9m0IWYHNFgx6ZlGDIrXc9fFBqYXoHR8UvQSszDKOBH+xnQ2thSFEAG
X-Gm-Message-State: AOJu0YwNIcupkP/PpGuDtxkBvJmOxozLDkEnLkpa3FygaAZ52CP5y9vI
	HI3zs7RLOurDC/wNc08jZPFfMyqN+ClmqNsbVI4QT9eTvfhRkp9rH6vPrg==
X-Google-Smtp-Source: AGHT+IHBZ0sRi3n9lAxJaBWSuUqmTal3IzjRJHmF1jStp0aNsRNauKLK+tGQzdCs2+yFm7sJKS78ew==
X-Received: by 2002:a17:906:9907:b0:a62:32be:33be with SMTP id a640c23a62f3a-a62641a65f5mr627834866b.10.1716835105120;
        Mon, 27 May 2024 11:38:25 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4b45:3774:6be0:a177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc52398sm513825266b.105.2024.05.27.11.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 11:38:24 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: himanshujha199640@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v1 13/17] iio: chemical: bme680: Add read buffers in DMA safe region
Date: Mon, 27 May 2024 20:38:01 +0200
Message-Id: <20240527183805.311501-14-vassilisamir@gmail.com>
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

Move the buffers that are used in order to read data from the
device in a DMA-safe region. Also create defines for the number
of bytes that are being read from the device and don't use
magic numbers.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/bme680.h      |  7 ++++++
 drivers/iio/chemical/bme680_core.c | 37 +++++++++++++++---------------
 2 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
index 5f602170a3af..17ea59253923 100644
--- a/drivers/iio/chemical/bme680.h
+++ b/drivers/iio/chemical/bme680.h
@@ -54,6 +54,13 @@
 #define BME680_REG_MEAS_STAT_0			0x1D
 #define   BME680_GAS_MEAS_BIT			BIT(6)
 
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
index a6f425076d36..b055eeee8f1c 100644
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
@@ -547,7 +550,6 @@ static int bme680_read_temp(struct bme680_data *data, int *val)
 {
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
-	__be32 tmp = 0;
 	u32 adc_temp;
 	s16 comp_temp;
 
@@ -559,13 +561,14 @@ static int bme680_read_temp(struct bme680_data *data, int *val)
 	bme680_wait_for_eoc(data);
 
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
@@ -591,7 +594,6 @@ static int bme680_read_press(struct bme680_data *data,
 {
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
-	__be32 tmp = 0;
 	u32 adc_press;
 
 	/* Read and compensate temperature to get a reading of t_fine */
@@ -600,13 +602,14 @@ static int bme680_read_press(struct bme680_data *data,
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
@@ -623,7 +626,6 @@ static int bme680_read_humid(struct bme680_data *data,
 {
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
-	__be16 tmp = 0;
 	u16 adc_humidity;
 	u32 comp_humidity;
 
@@ -633,13 +635,13 @@ static int bme680_read_humid(struct bme680_data *data,
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
@@ -657,8 +659,6 @@ static int bme680_read_gas(struct bme680_data *data,
 {
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
-	__be16 tmp = 0;
-	unsigned int check;
 	u16 adc_gas_res, gas_regs_val;
 	u8 gas_range;
 
@@ -676,19 +676,19 @@ static int bme680_read_gas(struct bme680_data *data,
 
 	bme680_wait_for_eoc(data);
 
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
+	gas_regs_val = be16_to_cpu(data->be16);
 	adc_gas_res = gas_regs_val >> BME680_ADC_GAS_RES_SHIFT;
 
 	/*
@@ -817,7 +817,6 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 {
 	struct iio_dev *indio_dev;
 	struct bme680_data *data;
-	unsigned int val;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
@@ -848,15 +847,15 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
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


