Return-Path: <linux-iio+bounces-16213-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0554A4A671
	for <lists+linux-iio@lfdr.de>; Sat,  1 Mar 2025 00:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A7E73B24B6
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2025 23:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDA61DF748;
	Fri, 28 Feb 2025 23:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9eG5y5n"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF0D1DF726;
	Fri, 28 Feb 2025 23:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740783845; cv=none; b=pDFjGPtnsgC7cfC7k1E2Cvy0Cgn4EuqUuBr9HhWWnipqT9eWAgZ/mz4RZLJsci6BVt28rlGRG+wHhxRu8t7V25PJ9wjO7RyZAvI17OzLEq/JpSL3IYigp0ysNBV7Skx1cWkvlqzk6rg+TaiFatAx2ZfmFVXHDAqpV+WkMhX7Z24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740783845; c=relaxed/simple;
	bh=S2I+5zrHkIJWgW/x1cmFQ21bTNoC3IzmEyR94oY7aJE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tX42IxbyxuXCBqE9oXx5P0DyqPDiV2pBjSkAWYBHz2d78l4VopxGvfkwnfIK8gOWzSy96niPEWxt+DZ2oQkpjcBAVOiRU8KPyL6dLkyVPwT/0L88Ie4YwW/YyeYO7YACbFKhAQBD7wUix0yPxXv2EGv+3DIIk6sv1QX7i6n+tq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9eG5y5n; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2232aead377so51523065ad.0;
        Fri, 28 Feb 2025 15:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740783843; x=1741388643; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wqniwqp268BOuKTlqpS+CRRTqpiMUjFZRa/CVRrwA44=;
        b=B9eG5y5n+l4JDEyuvlsYncgOD4NlsmoVvmE0hrz9iL9OP6fW2C9GFRbdN6tgxaTw5x
         XfEQVN1rCUOYhBLVSPcMQI75/lsvk3A2kfHpV3xtvWMZVaVBn1slH6TKZR/Hohdj0uiO
         iCbJcXr7kvbzYBdUiJ6ne/30Hekj/VmuHqnUf08+iThMs3Hsu189l3zTINv3GNsolBUz
         7+RO6dcVWQuDdbIypIrF/qQ/hpLIVicDMGfTVcJKKIB8eQZRUEJJJ0fIuCWPKIbP1H+o
         dDbmBzIUckrS4pxVmjYJDeUtnB7qWaP70sHOxJvXozE1FU8kksX/uDfIVMotARIatYJy
         DZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740783843; x=1741388643;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wqniwqp268BOuKTlqpS+CRRTqpiMUjFZRa/CVRrwA44=;
        b=v7i8vunq76ellPpVzmbEZlcUz91VEDNiWBJQm8HEj/7ivhE3fYDL6Iej+3OZo5x9yM
         /YacRRg+OGPmDqbY61FzWiuTQaO46YfpGv6aA7mz0+ZBtdf3bIrGI0FOa52vtwOUR3Ts
         nfKqJ1hVaL6ZRodcsqpGu7j/Pq4u7AxVz16JxEGBApyWcZrRoY8yTQGags+CYoKai6HZ
         ms3HR2GCxYvA0linLnqWRyK8cSsTaxp1jVDUXyXeH0v0+udlwP15OhKI6W7SFaq9uZ+1
         U/Uf/5Inp8Yc0x3kQU+sE0VcudY7W2aICaVTFlKdovzX6/YHbDevilsyCxfe24bD/pH4
         rkwg==
X-Forwarded-Encrypted: i=1; AJvYcCUd/D5koH+hCJJPm/AdMLkdMUngzw0AHsmuYC9WEQyIVc+Eccz5I/iQmbO+e4LkTAyy/Ur0t0Yluu9T0LU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl5lTT+tFzvs6dqaKgam0BikiML+FvkuPKk5d3WXRQ2FWFRVQs
	gBEfeulnTXgOzTXAwh/946RpTWQlWkNk3OB47t44NTih5yKWe9S6
X-Gm-Gg: ASbGncs8Z2P/gSY9fI5ecdh4EiUW2skLfKfdxnarisSJiz/T6SpIg6eb9xAIM4mL5Ol
	kCQAvlkvoHUVcAD6KZXN+dE1j1uux3ujOoweSRcXpwFF8yVg3VVshd1vfELF35qpewXVcK7C7nD
	k4sUk5a7Ci17IuzXJkAGKVdUvYG+d4nuiV+O7ZfM3reTLVSx1tDUHqlOXkzVTo/zVmalZevl2wq
	kWgKctUtilcfBxZ+pgPYRwoMBnBgdhMf5pAUfsg48+/0yLMPtDBffMeMW1pFRyh74diisnn9cME
	35U3UVCgK6Ko/V/uPmwisqOXJdkqMM3bjc9rqw==
X-Google-Smtp-Source: AGHT+IGQrPappHqX1wrTaZCZeKkRXP+Q5JZAiFzEP+LdfrmZbuJkONTHL0PwfyWv+Yeqjb+XOWbujw==
X-Received: by 2002:a05:6a21:696:b0:1ee:5cf2:9c07 with SMTP id adf61e73a8af0-1f2f4c98064mr10361226637.3.1740783842632;
        Fri, 28 Feb 2025 15:04:02 -0800 (PST)
Received: from [192.168.0.107] ([2804:14d:90a8:854f::10dc])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7ddf230dsm3974875a12.8.2025.02.28.15.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 15:04:02 -0800 (PST)
From: Gustavo Silva <gustavograzs@gmail.com>
Date: Fri, 28 Feb 2025 20:03:49 -0300
Subject: [PATCH v2 2/3] iio: imu: bmi270: rename variable bmi270_device to
 data
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-bmi270-irq-v2-2-3f97a4e8f551@gmail.com>
References: <20250228-bmi270-irq-v2-0-3f97a4e8f551@gmail.com>
In-Reply-To: <20250228-bmi270-irq-v2-0-3f97a4e8f551@gmail.com>
To: Alex Lanzano <lanzano.alex@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gustavo Silva <gustavograzs@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740783832; l=8485;
 i=gustavograzs@gmail.com; s=20250111; h=from:subject:message-id;
 bh=S2I+5zrHkIJWgW/x1cmFQ21bTNoC3IzmEyR94oY7aJE=;
 b=zPb6sa4VX67w7zqlACZh3gy4c+5LHGv0q4o2s/SSFyF7fg7oYElFMOs4hcAScgVYeZjZ8VZ4u
 4JIUM//qc68Ckrv8wJR8TeeJwV5ay9+a6UZOfz5/3Qc7d7wzgayRmzX
X-Developer-Key: i=gustavograzs@gmail.com; a=ed25519;
 pk=g2TFXpo1jMCOCN+rzVoM9NDFNfSMOgVyY0rlyvk4RTM=

Rename all instances of 'struct bmi270_data' to 'data', to ensure
consistency across the driver.
Also rename bmi270_data::data to bmi270_data::buffer to avoid naming
conflicts.

Acked-by: Alex Lanzano <lanzano.alex@gmail.com>
Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
---
 drivers/iio/imu/bmi270/bmi270_core.c | 85 +++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 44 deletions(-)

diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
index 9f24d4044ed6f00f67fd3a8f5adda821c3140a18..16deda12a5c1aba6d366f7fcb134266c490d3a75 100644
--- a/drivers/iio/imu/bmi270/bmi270_core.c
+++ b/drivers/iio/imu/bmi270/bmi270_core.c
@@ -90,7 +90,7 @@ struct bmi270_data {
 	struct {
 		__le16 channels[6];
 		aligned_s64 timestamp;
-	} data __aligned(IIO_DMA_MINALIGN);
+	} buffer __aligned(IIO_DMA_MINALIGN);
 };
 
 enum bmi270_scan {
@@ -284,8 +284,8 @@ static int bmi270_set_scale(struct bmi270_data *data, int chan_type, int uscale)
 	return -EINVAL;
 }
 
-static int bmi270_get_scale(struct bmi270_data *bmi270_device, int chan_type,
-			    int *scale, int *uscale)
+static int bmi270_get_scale(struct bmi270_data *data, int chan_type, int *scale,
+			    int *uscale)
 {
 	int ret;
 	unsigned int val;
@@ -293,8 +293,7 @@ static int bmi270_get_scale(struct bmi270_data *bmi270_device, int chan_type,
 
 	switch (chan_type) {
 	case IIO_ACCEL:
-		ret = regmap_read(bmi270_device->regmap,
-				  BMI270_ACC_CONF_RANGE_REG, &val);
+		ret = regmap_read(data->regmap, BMI270_ACC_CONF_RANGE_REG, &val);
 		if (ret)
 			return ret;
 
@@ -302,8 +301,7 @@ static int bmi270_get_scale(struct bmi270_data *bmi270_device, int chan_type,
 		bmi270_scale_item = bmi270_scale_table[BMI270_ACCEL];
 		break;
 	case IIO_ANGL_VEL:
-		ret = regmap_read(bmi270_device->regmap,
-				  BMI270_GYR_CONF_RANGE_REG, &val);
+		ret = regmap_read(data->regmap, BMI270_GYR_CONF_RANGE_REG, &val);
 		if (ret)
 			return ret;
 
@@ -403,25 +401,25 @@ static irqreturn_t bmi270_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	struct bmi270_data *bmi270_device = iio_priv(indio_dev);
+	struct bmi270_data *data = iio_priv(indio_dev);
 	int ret;
 
-	ret = regmap_bulk_read(bmi270_device->regmap, BMI270_ACCEL_X_REG,
-			       &bmi270_device->data.channels,
-			       sizeof(bmi270_device->data.channels));
+	ret = regmap_bulk_read(data->regmap, BMI270_ACCEL_X_REG,
+			       &data->buffer.channels,
+			       sizeof(data->buffer.channels));
 
 	if (ret)
 		goto done;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &bmi270_device->data,
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
 					   pf->timestamp);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;
 }
 
-static int bmi270_get_data(struct bmi270_data *bmi270_device,
-			   int chan_type, int axis, int *val)
+static int bmi270_get_data(struct bmi270_data *data, int chan_type, int axis,
+			   int *val)
 {
 	__le16 sample;
 	int reg;
@@ -441,7 +439,7 @@ static int bmi270_get_data(struct bmi270_data *bmi270_device,
 		return -EINVAL;
 	}
 
-	ret = regmap_bulk_read(bmi270_device->regmap, reg, &sample, sizeof(sample));
+	ret = regmap_bulk_read(data->regmap, reg, &sample, sizeof(sample));
 	if (ret)
 		return ret;
 
@@ -455,17 +453,17 @@ static int bmi270_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long mask)
 {
 	int ret;
-	struct bmi270_data *bmi270_device = iio_priv(indio_dev);
+	struct bmi270_data *data = iio_priv(indio_dev);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = bmi270_get_data(bmi270_device, chan->type, chan->channel2, val);
+		ret = bmi270_get_data(data, chan->type, chan->channel2, val);
 		if (ret)
 			return ret;
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		ret = bmi270_get_scale(bmi270_device, chan->type, val, val2);
+		ret = bmi270_get_scale(data, chan->type, val, val2);
 		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_OFFSET:
 		switch (chan->type) {
@@ -476,7 +474,7 @@ static int bmi270_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		ret = bmi270_get_odr(bmi270_device, chan->type, val, val2);
+		ret = bmi270_get_odr(data, chan->type, val, val2);
 		return ret ? ret : IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
@@ -599,12 +597,12 @@ static const struct iio_chan_spec bmi270_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(BMI270_SCAN_TIMESTAMP),
 };
 
-static int bmi270_validate_chip_id(struct bmi270_data *bmi270_device)
+static int bmi270_validate_chip_id(struct bmi270_data *data)
 {
 	int chip_id;
 	int ret;
-	struct device *dev = bmi270_device->dev;
-	struct regmap *regmap = bmi270_device->regmap;
+	struct device *dev = data->dev;
+	struct regmap *regmap = data->regmap;
 
 	ret = regmap_read(regmap, BMI270_CHIP_ID_REG, &chip_id);
 	if (ret)
@@ -618,24 +616,24 @@ static int bmi270_validate_chip_id(struct bmi270_data *bmi270_device)
 	if (chip_id == BMI160_CHIP_ID_VAL)
 		return -ENODEV;
 
-	if (chip_id != bmi270_device->chip_info->chip_id)
+	if (chip_id != data->chip_info->chip_id)
 		dev_info(dev, "Unexpected chip id 0x%x", chip_id);
 
 	if (chip_id == bmi260_chip_info.chip_id)
-		bmi270_device->chip_info = &bmi260_chip_info;
+		data->chip_info = &bmi260_chip_info;
 	else if (chip_id == bmi270_chip_info.chip_id)
-		bmi270_device->chip_info = &bmi270_chip_info;
+		data->chip_info = &bmi270_chip_info;
 
 	return 0;
 }
 
-static int bmi270_write_calibration_data(struct bmi270_data *bmi270_device)
+static int bmi270_write_calibration_data(struct bmi270_data *data)
 {
 	int ret;
 	int status = 0;
 	const struct firmware *init_data;
-	struct device *dev = bmi270_device->dev;
-	struct regmap *regmap = bmi270_device->regmap;
+	struct device *dev = data->dev;
+	struct regmap *regmap = data->regmap;
 
 	ret = regmap_clear_bits(regmap, BMI270_PWR_CONF_REG,
 				BMI270_PWR_CONF_ADV_PWR_SAVE_MSK);
@@ -656,8 +654,7 @@ static int bmi270_write_calibration_data(struct bmi270_data *bmi270_device)
 		return dev_err_probe(dev, ret,
 				     "Failed to prepare device to load init data");
 
-	ret = request_firmware(&init_data,
-			       bmi270_device->chip_info->fw_name, dev);
+	ret = request_firmware(&init_data, data->chip_info->fw_name, dev);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to load init data file");
 
@@ -689,11 +686,11 @@ static int bmi270_write_calibration_data(struct bmi270_data *bmi270_device)
 	return 0;
 }
 
-static int bmi270_configure_imu(struct bmi270_data *bmi270_device)
+static int bmi270_configure_imu(struct bmi270_data *data)
 {
 	int ret;
-	struct device *dev = bmi270_device->dev;
-	struct regmap *regmap = bmi270_device->regmap;
+	struct device *dev = data->dev;
+	struct regmap *regmap = data->regmap;
 
 	ret = regmap_set_bits(regmap, BMI270_PWR_CTRL_REG,
 			      BMI270_PWR_CTRL_AUX_EN_MSK |
@@ -730,38 +727,38 @@ static int bmi270_configure_imu(struct bmi270_data *bmi270_device)
 	return 0;
 }
 
-static int bmi270_chip_init(struct bmi270_data *bmi270_device)
+static int bmi270_chip_init(struct bmi270_data *data)
 {
 	int ret;
 
-	ret = bmi270_validate_chip_id(bmi270_device);
+	ret = bmi270_validate_chip_id(data);
 	if (ret)
 		return ret;
 
-	ret = bmi270_write_calibration_data(bmi270_device);
+	ret = bmi270_write_calibration_data(data);
 	if (ret)
 		return ret;
 
-	return bmi270_configure_imu(bmi270_device);
+	return bmi270_configure_imu(data);
 }
 
 int bmi270_core_probe(struct device *dev, struct regmap *regmap,
 		      const struct bmi270_chip_info *chip_info)
 {
 	int ret;
-	struct bmi270_data *bmi270_device;
+	struct bmi270_data *data;
 	struct iio_dev *indio_dev;
 
-	indio_dev = devm_iio_device_alloc(dev, sizeof(*bmi270_device));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
 	if (!indio_dev)
 		return -ENOMEM;
 
-	bmi270_device = iio_priv(indio_dev);
-	bmi270_device->dev = dev;
-	bmi270_device->regmap = regmap;
-	bmi270_device->chip_info = chip_info;
+	data = iio_priv(indio_dev);
+	data->dev = dev;
+	data->regmap = regmap;
+	data->chip_info = chip_info;
 
-	ret = bmi270_chip_init(bmi270_device);
+	ret = bmi270_chip_init(data);
 	if (ret)
 		return ret;
 

-- 
2.48.1


