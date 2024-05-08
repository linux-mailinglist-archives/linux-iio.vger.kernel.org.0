Return-Path: <linux-iio+bounces-4890-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A098C0209
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 18:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7650C1F22ACE
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 16:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028791095C;
	Wed,  8 May 2024 16:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvrpVPIc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012A5DDD8;
	Wed,  8 May 2024 16:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715186083; cv=none; b=uzwZ3Z290o4bA6UHKKJGCLiu28zCK4fzkPid7xYA2qHOr87XJOcVclc8dKmnHLDveVV75VQKiZvR10Qml/230NduNda5u3o43SnHa4L+aVzvC6BcFzXaweQYPqIx+g6U6hn7wgCR2PCxlxNqDd2QOAgBip3qjWom7qLKCIixBhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715186083; c=relaxed/simple;
	bh=9MYMqXE7bH1T1ZWrHlbUX2Eeezf08FVyd/SPBoYqvU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cDBcEaKhOd5S2C3rN/Estag3ijHLKYko4Kc2/59Nue1Eh2S2AbL+gJUgSYemkUVhHzqNSl9sMTI9hCfXGP2Vao/OLXlpycMnIiccL9uWJsZYHma0QuBh2E2C7vi8GTrNwh7WNBtCx6G+LT21eiDNTsMKiUpAz73q0vWf6eyB+7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvrpVPIc; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59a64db066so1180098466b.3;
        Wed, 08 May 2024 09:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715186080; x=1715790880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YpNOHhYoasG7qZzRh+H/G0tZ+lEbMfm2wisJ2QOZuA=;
        b=DvrpVPIcFfstPxwEmGhYSxucv8QvQM5Mv3luFNe5qDU2eM1Dbt6E6EAt5AdI3xve5N
         eocqf74LyO5NlgGrVxpXX+Wqo07iQS08aiAvUJZ/NKb74cIDA6NBDsqTeOXv3Nxuhf47
         TmgQRKiluBHeAqnCAvcCYOxqsW7Ff49o8VMAF1vW8fQRutMzBHWy5gZeBJ+8pwNm12+m
         MxhhtDf/UkJKyp3vDJvyPANMdq59lEYxQzoqZqWP84kIz2EXJWdL8Msf9QI+RVYeW5ET
         zVRiVv+w9H0ZWLOhpxRWyws8mCaTumsuUdRewq9A5EG3Fto/wZt4ws0BnBp7qi+xJeNL
         uPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715186080; x=1715790880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YpNOHhYoasG7qZzRh+H/G0tZ+lEbMfm2wisJ2QOZuA=;
        b=fChfBS2WkKbU0ZNtzBc00zW+h2lgUAmHAPo9SwQdqPkEWvQXU20wwZqW+5m3NxdBit
         FUdNWxxXN/IsxFMdQG7kBg8E86qMDOJ++lIRZ+qfjOG4GABddih98fk2ZyZGxQIELEJr
         9Yb4xjA6YuCsLv9ulwpF5RkIi6OxYwjN19oOZ+1nmLpGKHI05IOLeY+2JVrsSmkVLm2f
         yAKkYE6BE/jK633sLpF7OrwJmhjP21nwvpRHGqG8T9NTmbpjMTdeShDJkHHHz2KHMgJi
         7BXtau3WNfqO8txs7wD3uWu+2aNPh7cK/DRmRiwqr4eI8eEAd6ciu63NDXN1DaefSLHz
         BEDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFyzXX170dLRFrUdgF90CgxJpnpIh7kvrI/PrOuGo0RtC06VVV8rmCs8JKZ6nnwuBuIAU0ZHYG9LR/1q6di0kxRB4q/GFhdw8ZpCmUnd0j7waN2dlOznAKkppRn/5viw/Y7JpiX/zH
X-Gm-Message-State: AOJu0YxWHKhG+0k/oFDz4xUPs0O+mj870/NE8adzWCJNHO7mCc9vAM6Y
	S3LBQAcbaTgA/IxWY7Pefr4GW2jL7ud7PLeNtxn4FenHo7HKPYsN
X-Google-Smtp-Source: AGHT+IHt80zpxu2MrJJiSzKFgkzVDJnHxe91h/MLoaKeBIcnIu4bl5ykZljEKmWSjF15fORRe1Dwwg==
X-Received: by 2002:a17:907:7084:b0:a59:c090:7786 with SMTP id a640c23a62f3a-a59fb94d9dfmr194818966b.25.1715186080023;
        Wed, 08 May 2024 09:34:40 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:a3c8:644e:cd04:560a])
        by smtp.gmail.com with ESMTPSA id hb4-20020a170906b88400b00a5599f3a057sm7872843ejb.107.2024.05.08.09.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 09:34:39 -0700 (PDT)
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
Subject: [PATCH 3/9] iio: pressure: bmp280: Make error checks consistent
Date: Wed,  8 May 2024 18:34:19 +0200
Message-Id: <20240508163425.143831-4-vassilisamir@gmail.com>
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

The form 'if (ret)' is used in this driver in order to check
for returned error values. There are also some places that
'if (ret < 0)' is used but for no specific reason. Change
them to 'if (ret)' to make the driver more consistent.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 40 +++++++++++++++---------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 0aa16fb135c1..f05ea754f53a 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -184,7 +184,7 @@ static int bmp280_read_calib(struct bmp280_data *data)
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_COMP_TEMP_START,
 			       data->bmp280_cal_buf,
 			       sizeof(data->bmp280_cal_buf));
-	if (ret < 0) {
+	if (ret) {
 		dev_err(data->dev,
 			"failed to read calibration parameters\n");
 		return ret;
@@ -222,7 +222,7 @@ static int bme280_read_calib(struct bmp280_data *data)
 
 	/* Load shared calibration params with bmp280 first */
 	ret = bmp280_read_calib(data);
-	if  (ret < 0)
+	if (ret)
 		return ret;
 
 	/*
@@ -234,7 +234,7 @@ static int bme280_read_calib(struct bmp280_data *data)
 	 */
 
 	ret = regmap_read(data->regmap, BME280_REG_COMP_H1, &tmp);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(dev, "failed to read H1 comp value\n");
 		return ret;
 	}
@@ -242,14 +242,14 @@ static int bme280_read_calib(struct bmp280_data *data)
 
 	ret = regmap_bulk_read(data->regmap, BME280_REG_COMP_H2,
 			       &data->le16, sizeof(data->le16));
-	if (ret < 0) {
+	if (ret) {
 		dev_err(dev, "failed to read H2 comp value\n");
 		return ret;
 	}
 	calib->H2 = sign_extend32(le16_to_cpu(data->le16), 15);
 
 	ret = regmap_read(data->regmap, BME280_REG_COMP_H3, &tmp);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(dev, "failed to read H3 comp value\n");
 		return ret;
 	}
@@ -257,7 +257,7 @@ static int bme280_read_calib(struct bmp280_data *data)
 
 	ret = regmap_bulk_read(data->regmap, BME280_REG_COMP_H4,
 			       &data->be16, sizeof(data->be16));
-	if (ret < 0) {
+	if (ret) {
 		dev_err(dev, "failed to read H4 comp value\n");
 		return ret;
 	}
@@ -266,14 +266,14 @@ static int bme280_read_calib(struct bmp280_data *data)
 
 	ret = regmap_bulk_read(data->regmap, BME280_REG_COMP_H5,
 			       &data->le16, sizeof(data->le16));
-	if (ret < 0) {
+	if (ret) {
 		dev_err(dev, "failed to read H5 comp value\n");
 		return ret;
 	}
 	calib->H5 = sign_extend32(FIELD_GET(BME280_COMP_H5_MASK, le16_to_cpu(data->le16)), 11);
 
 	ret = regmap_read(data->regmap, BME280_REG_COMP_H6, &tmp);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(dev, "failed to read H6 comp value\n");
 		return ret;
 	}
@@ -370,7 +370,7 @@ static int bmp280_read_temp(struct bmp280_data *data,
 
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
 			       data->buf, sizeof(data->buf));
-	if (ret < 0) {
+	if (ret) {
 		dev_err(data->dev, "failed to read temperature\n");
 		return ret;
 	}
@@ -404,12 +404,12 @@ static int bmp280_read_press(struct bmp280_data *data,
 
 	/* Read and compensate temperature so we get a reading of t_fine. */
 	ret = bmp280_read_temp(data, NULL, NULL);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
 			       data->buf, sizeof(data->buf));
-	if (ret < 0) {
+	if (ret) {
 		dev_err(data->dev, "failed to read pressure\n");
 		return ret;
 	}
@@ -436,12 +436,12 @@ static int bme280_read_humid(struct bmp280_data *data, int *val, int *val2)
 
 	/* Read and compensate temperature so we get a reading of t_fine. */
 	ret = bmp280_read_temp(data, NULL, NULL);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	ret = regmap_bulk_read(data->regmap, BME280_REG_HUMIDITY_MSB,
 			       &data->be16, sizeof(data->be16));
-	if (ret < 0) {
+	if (ret) {
 		dev_err(data->dev, "failed to read humidity\n");
 		return ret;
 	}
@@ -775,7 +775,7 @@ static int bmp280_chip_config(struct bmp280_data *data)
 				BMP280_OSRS_PRESS_MASK |
 				BMP280_MODE_MASK,
 				osrs | BMP280_MODE_NORMAL);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(data->dev, "failed to write ctrl_meas register\n");
 		return ret;
 	}
@@ -783,7 +783,7 @@ static int bmp280_chip_config(struct bmp280_data *data)
 	ret = regmap_update_bits(data->regmap, BMP280_REG_CONFIG,
 				 BMP280_FILTER_MASK,
 				 BMP280_FILTER_4X);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(data->dev, "failed to write config register\n");
 		return ret;
 	}
@@ -839,7 +839,7 @@ static int bme280_chip_config(struct bmp280_data *data)
 	 */
 	ret = regmap_update_bits(data->regmap, BME280_REG_CTRL_HUMIDITY,
 				 BME280_OSRS_HUMIDITY_MASK, osrs);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(data->dev, "failed to set humidity oversampling");
 		return ret;
 	}
@@ -1856,7 +1856,7 @@ static int bmp180_read_calib(struct bmp280_data *data)
 
 	ret = regmap_bulk_read(data->regmap, BMP180_REG_CALIB_START,
 			       data->bmp180_cal_buf, sizeof(data->bmp180_cal_buf));
-	if (ret < 0) {
+	if (ret) {
 		dev_err(data->dev, "failed to read calibration parameters\n");
 		return ret;
 	}
@@ -2177,7 +2177,7 @@ int bmp280_common_probe(struct device *dev,
 	data->regmap = regmap;
 
 	ret = regmap_read(regmap, data->chip_info->id_reg, &chip_id);
-	if (ret < 0) {
+	if (ret) {
 		dev_err(data->dev, "failed to read chip id\n");
 		return ret;
 	}
@@ -2200,7 +2200,7 @@ int bmp280_common_probe(struct device *dev,
 	}
 
 	ret = data->chip_info->chip_config(data);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	dev_set_drvdata(dev, indio_dev);
@@ -2213,7 +2213,7 @@ int bmp280_common_probe(struct device *dev,
 
 	if (data->chip_info->read_calib) {
 		ret = data->chip_info->read_calib(data);
-		if (ret < 0)
+		if (ret)
 			return dev_err_probe(data->dev, ret,
 					     "failed to read calibration coefficients\n");
 	}
-- 
2.25.1


