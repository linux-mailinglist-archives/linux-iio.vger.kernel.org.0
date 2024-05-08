Return-Path: <linux-iio+bounces-4899-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 079508C024E
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 18:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AA101F24D6B
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 16:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9B931A81;
	Wed,  8 May 2024 16:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4XHx3s/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B91FC08;
	Wed,  8 May 2024 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715187143; cv=none; b=MKs6uyKH/l3WOkipQcLLMsmANkQqFy5DWFYjTe/Z4Ka/bkK71p+Vt8FaSpm7ZvkgWrkjHRcehn5brHZOrpHAGCTukCWDeIYFQf+JCCSyJmjRytwlsu/nCUKW+iovpsaAEJUXNU9iPl/61d4Byu5aqLjCwI6kW27MPOfiehAfaUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715187143; c=relaxed/simple;
	bh=l1hu2hFgIr8xR8Q585mFsIg/KueTHwMCzDe3W804cQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FyHQ/ORy/gdzN63pWH+h3NdKX549M972nil+7mYklR+wEI+vLzoZp+lrDvYNZ8NHzro8LWDgh2vPfCd+xlAg26fDuX/bCnDxb/moWbJtvr3Xw4FqctXMfdF/BH03xlxLB2j65s0EWaOIuQHS/9FE0NgELF8WZeLzP9YSIfdaMXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4XHx3s/; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59a9d66a51so1066706866b.2;
        Wed, 08 May 2024 09:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715187140; x=1715791940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yp+nY7e7eZPYh86CGgOdapTFik7EaeHR+9gwGoRC30w=;
        b=U4XHx3s/Q+tG9+l39etdw9yVDGATJIUslsIU9gV04E+E5C17WVpMStECQbBtyr0kmx
         1P6y+EYG9QAS8bXvLdSdb+yZ1yX8zdMCpkeLX2vocQQRsj4b0t4jhv98iCN8pEk7Xygz
         96IFWi7RVLgbDAereqVHLzNNW4G4Iwi7A8wwGlGTbF8TwwXZbhmriobFIh0qpkpOy4yx
         qYixPOWWRpIpP01t7e2TTRXWyfq61oM6L1zQfFBORIsKQfiCNd81HvHh8jAQFJsjnQcG
         UrD6hQwyU4PrJ2CGc45banvIYKbVSDighLViXFMba9up5t84/+2HiRZ6pWJ3bQFd9/I4
         0+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715187140; x=1715791940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yp+nY7e7eZPYh86CGgOdapTFik7EaeHR+9gwGoRC30w=;
        b=HidFsMHqxVRqWn8tFs1EhBWq41G9bFksGKigcOEo8afVCwMOcF/zHlJIDJjrJujMq6
         SYyolWY5TpVxWUD9csVTEKGAYnuR9l4xlws8CUc9Ux54JU78J48/dusYbYlgTYSI2aWD
         UOjbF6/dhMVtTBEBdUywEW2VOUJ8YQO1y9kMRQzDzEIzxcXg9mbbTauxcB4AwO0QrOaG
         wsp6GxSO2OMs4cAtGEDOkLKT0//Fz5zwa8YjyCQkoxYM3shqNW7PkG3LCbSKv56M2cxq
         nZAeNupa3kT/JBlRvIdZPAuD3n2cN+vRU/Hswx/AvOwwm/X/DsPUu7Enl0WwnmyMEMuA
         zYgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBbfMB+3Nyt0LGW7a0laZfuRcXitPWatptHVLXyGDtRu8n95kyVjNOWHPsOrJJqb6LSSN9sxcMoS+gZ8U1ZrcuomStWBnpjs/4IXntUi8sGYlJMUIEcO97NV5ate0/JUJWmUK+wRdd
X-Gm-Message-State: AOJu0Yz7dploCkK7oD96rwy2nzhsRRuiB//wIIckekNPSaBITWGD3CRi
	EFq0RKWRwuwm5tQ2ACznxoAO725/xBfJk+m9xBxWSiM8SDD49txW
X-Google-Smtp-Source: AGHT+IHTFiy6qUgBYK1drLRuQy1/LTawkRSOxAh0tX2vJzWkJPIQ4F6fAj2I9PWiqcjqbe0IBd5Q5A==
X-Received: by 2002:a17:906:db03:b0:a59:b590:5d71 with SMTP id a640c23a62f3a-a59fb6ed704mr272470966b.0.1715187140122;
        Wed, 08 May 2024 09:52:20 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:a3c8:644e:cd04:560a])
        by smtp.gmail.com with ESMTPSA id kj24-20020a170907765800b00a59a8212c8esm5648010ejc.42.2024.05.08.09.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 09:52:19 -0700 (PDT)
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
Subject: [PATCH v6 2/9] iio: pressure: bmp280: Remove, add and update error messages
Date: Wed,  8 May 2024 18:52:00 +0200
Message-Id: <20240508165207.145554-3-vassilisamir@gmail.com>
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

Remove duplicate error messages, add missing error messages and
update redundant ones.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 55 +++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 311a011604da..0aa16fb135c1 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -222,10 +222,8 @@ static int bme280_read_calib(struct bmp280_data *data)
 
 	/* Load shared calibration params with bmp280 first */
 	ret = bmp280_read_calib(data);
-	if  (ret < 0) {
-		dev_err(dev, "failed to read calibration parameters\n");
+	if  (ret < 0)
 		return ret;
-	}
 
 	/*
 	 * Read humidity calibration values.
@@ -841,8 +839,10 @@ static int bme280_chip_config(struct bmp280_data *data)
 	 */
 	ret = regmap_update_bits(data->regmap, BME280_REG_CTRL_HUMIDITY,
 				 BME280_OSRS_HUMIDITY_MASK, osrs);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_err(data->dev, "failed to set humidity oversampling");
 		return ret;
+	}
 
 	return bmp280_chip_config(data);
 }
@@ -1071,7 +1071,7 @@ static int bmp380_read_calib(struct bmp280_data *data)
 			       sizeof(data->bmp380_cal_buf));
 	if (ret) {
 		dev_err(data->dev,
-			"failed to read temperature calibration parameters\n");
+			"failed to read calibration parameters\n");
 		return ret;
 	}
 
@@ -1609,20 +1609,24 @@ static int bmp580_preinit(struct bmp280_data *data)
 
 	/* Post powerup sequence */
 	ret = regmap_read(data->regmap, BMP580_REG_CHIP_ID, &reg);
-	if (ret)
+	if (ret) {
+		dev_err(data->dev, "failed to establish comms with the chip\n");
 		return ret;
+	}
 
 	/* Print warn message if we don't know the chip id */
 	if (reg != BMP580_CHIP_ID && reg != BMP580_CHIP_ID_ALT)
-		dev_warn(data->dev, "preinit: unexpected chip_id\n");
+		dev_warn(data->dev, "unexpected chip_id\n");
 
 	ret = regmap_read(data->regmap, BMP580_REG_STATUS, &reg);
-	if (ret)
+	if (ret) {
+		dev_err(data->dev, "failed to read nvm status\n");
 		return ret;
+	}
 
 	/* Check nvm status */
 	if (!(reg & BMP580_STATUS_NVM_RDY_MASK) || (reg & BMP580_STATUS_NVM_ERR_MASK)) {
-		dev_err(data->dev, "preinit: nvm error on powerup sequence\n");
+		dev_err(data->dev, "nvm error on powerup sequence\n");
 		return -EIO;
 	}
 
@@ -1657,6 +1661,10 @@ static int bmp580_chip_config(struct bmp280_data *data)
 				 BMP580_DSP_COMP_MASK |
 				 BMP580_DSP_SHDW_IIR_TEMP_EN |
 				 BMP580_DSP_SHDW_IIR_PRESS_EN, reg_val);
+	if (ret) {
+		dev_err(data->dev, "failed to change DSP mode settings\n");
+		return ret;
+	}
 
 	/* Configure oversampling */
 	reg_val = FIELD_PREP(BMP580_OSR_TEMP_MASK, data->oversampling_temp) |
@@ -1778,8 +1786,10 @@ static int bmp180_wait_for_eoc(struct bmp280_data *data, u8 ctrl_meas)
 		reinit_completion(&data->done);
 
 	ret = regmap_write(data->regmap, BMP280_REG_CTRL_MEAS, ctrl_meas);
-	if (ret)
+	if (ret) {
+		dev_err(data->dev, "failed to write crtl_meas register\n");
 		return ret;
+	}
 
 	if (data->use_eoc) {
 		/*
@@ -1802,12 +1812,16 @@ static int bmp180_wait_for_eoc(struct bmp280_data *data, u8 ctrl_meas)
 	}
 
 	ret = regmap_read(data->regmap, BMP280_REG_CTRL_MEAS, &ctrl);
-	if (ret)
+	if (ret) {
+		dev_err(data->dev, "failed to read ctrl_meas register\n");
 		return ret;
+	}
 
 	/* The value of this bit reset to "0" after conversion is complete */
-	if (ctrl & BMP180_MEAS_SCO)
+	if (ctrl & BMP180_MEAS_SCO) {
+		dev_err(data->dev, "conversion didn't complete\n");
 		return -EIO;
+	}
 
 	return 0;
 }
@@ -1824,8 +1838,10 @@ static int bmp180_read_adc_temp(struct bmp280_data *data, int *val)
 
 	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB,
 			       &data->be16, sizeof(data->be16));
-	if (ret)
+	if (ret) {
+		dev_err(data->dev, "failed to read temperature\n");
 		return ret;
+	}
 
 	*val = be16_to_cpu(data->be16);
 
@@ -1840,9 +1856,10 @@ static int bmp180_read_calib(struct bmp280_data *data)
 
 	ret = regmap_bulk_read(data->regmap, BMP180_REG_CALIB_START,
 			       data->bmp180_cal_buf, sizeof(data->bmp180_cal_buf));
-
-	if (ret < 0)
+	if (ret < 0) {
+		dev_err(data->dev, "failed to read calibration parameters\n");
 		return ret;
+	}
 
 	/* None of the words has the value 0 or 0xFFFF */
 	for (i = 0; i < ARRAY_SIZE(data->bmp180_cal_buf); i++) {
@@ -1925,8 +1942,10 @@ static int bmp180_read_adc_press(struct bmp280_data *data, int *val)
 
 	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB,
 			       data->buf, sizeof(data->buf));
-	if (ret)
+	if (ret) {
+		dev_err(data->dev, "failed to read pressure\n");
 		return ret;
+	}
 
 	*val = get_unaligned_be24(data->buf) >> (8 - oss);
 
@@ -2158,8 +2177,10 @@ int bmp280_common_probe(struct device *dev,
 	data->regmap = regmap;
 
 	ret = regmap_read(regmap, data->chip_info->id_reg, &chip_id);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_err(data->dev, "failed to read chip id\n");
 		return ret;
+	}
 
 	for (i = 0; i < data->chip_info->num_chip_id; i++) {
 		if (chip_id == data->chip_info->chip_id[i]) {
-- 
2.25.1


