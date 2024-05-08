Return-Path: <linux-iio+bounces-4900-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA6C8C0250
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 18:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DD9F1F23309
	for <lists+linux-iio@lfdr.de>; Wed,  8 May 2024 16:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B9CD530;
	Wed,  8 May 2024 16:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqShdIlk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF1410A12;
	Wed,  8 May 2024 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715187144; cv=none; b=rjjQXjfxUK10SRHS/zNY7gjoYEqdV0lzaYVurdLkwAjZSJ90gxcvGX89ZFO/xQV+4EaS8C88uDrFlIIzahrortiaDe/G1FYzZpyDZgr7CAPGMmcZan91yaQF0tDirdjLXNpMiyktTbdYYy6ULWLyrQxL/XtWExBRcUknnr7d1pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715187144; c=relaxed/simple;
	bh=9MYMqXE7bH1T1ZWrHlbUX2Eeezf08FVyd/SPBoYqvU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JvsUmjT0J24BcRVPG27FZZpCBxWOwVJgG2hvqk6VjMo+lugmwNyS+hiGzBvwEAAQmCQtFuuW493jCu8iqY2bdb6/+Gi5lvaykrx+Ze3/qu34QXhtXWAg6Yv3oKB7GPrk5qg3DYqVeWpj5unMs20Ae4G/C3k6L0WcBpjwuOoI8tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqShdIlk; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59a352bbd9so202792566b.1;
        Wed, 08 May 2024 09:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715187141; x=1715791941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YpNOHhYoasG7qZzRh+H/G0tZ+lEbMfm2wisJ2QOZuA=;
        b=RqShdIlkKT4GgVQR5h7BOGF/EJHEON3jmAFyETKSgjMbwJ/uuoaGQ1h2qMZLNTEp3x
         hqAQznpKRz/xK/kn8eyWk7sv0fFKki6NKmNBULknPYQiA5xL2YRtk6xALnJoXNrw2hsb
         RwaiwH9DZ2jeWtcrgqV2vszjvwY21l4vXTSa4W7OmMck7OAu6LGLeZdw6BUSsij4SOc0
         IJyEqu18hsD8YRe7JSgWKXOksHToOxJsHCkS+2P38O6y4B/IYMVx30BMn4h9Fwxukj7i
         9PAkgpWWaABHJbh6vks0RC7hGc9ZBqSp09pB+60lmI0k7AiYVM1XQjGDGW0lZmFjBruK
         bPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715187141; x=1715791941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YpNOHhYoasG7qZzRh+H/G0tZ+lEbMfm2wisJ2QOZuA=;
        b=SUcWt0HkB2iWKFrXpRXQ/H8X8zmi6aL4T8xrXiyVwNxmNpXsg5q5HrHUZudNI/q4N8
         C/cC8/bxc1J45OvK+XKOBwyY+crrhbOWGNSEt3l6DuIkDjFd+wBvD7DMN7TOHO7UJ8yG
         SasmMBtPB+soPhZ/+UBgk9hFIDHQyQPhDShSFxBcurBcoJNislvPXMkdtzEEOJ8R2g50
         cwZ8sNjYTgKkNt4Pf2qPePelook28KxwePUr0wIUT0fgM80+kEm9gHzydi6x+s+OQMTF
         mx9rt/wtJteKoThlii275WTs0xHFlhBGjt+XUgT93BB+OVct0QjVil8JUkiB2cDNbuXd
         R+Vw==
X-Forwarded-Encrypted: i=1; AJvYcCU/BbOPsMJd2DXABSp0euHrPnxPTQzkS70VF5KHBEnTej2Z9/Ima0y7H3L3FnmDaBFZz4alrBNA2ybQ48Xbkx8Rr9e/zDYAD7IcSZrqzQ9O86nlsRR6Xd3VEaiH67SD09E8ee3YLYtT
X-Gm-Message-State: AOJu0YznxI97WRYEgFflba7Di/GEXEyZrjSZyHgyExulH1HKXiAuFM3o
	m0nF2gX+52LTni5iHBgYMw/Y5S0EmRY/8ghnf6bVUFNtSBoMG7xH
X-Google-Smtp-Source: AGHT+IEc4VHshD2VtCCULaUq4i3DUtrKNFSZU07HsisRLsnIJh+xvGGGItD0EUtq+UhbnubKIXvMtg==
X-Received: by 2002:a17:907:76f4:b0:a59:a85c:a5ca with SMTP id a640c23a62f3a-a5a115bd150mr17940866b.7.1715187141042;
        Wed, 08 May 2024 09:52:21 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:a3c8:644e:cd04:560a])
        by smtp.gmail.com with ESMTPSA id kj24-20020a170907765800b00a59a8212c8esm5648010ejc.42.2024.05.08.09.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 09:52:20 -0700 (PDT)
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
Subject: [PATCH v6 3/9] iio: pressure: bmp280: Make error checks consistent
Date: Wed,  8 May 2024 18:52:01 +0200
Message-Id: <20240508165207.145554-4-vassilisamir@gmail.com>
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


