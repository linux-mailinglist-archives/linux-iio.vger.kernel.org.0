Return-Path: <linux-iio+bounces-7674-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7046934BEC
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 12:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 669781F239FB
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 10:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD5612C470;
	Thu, 18 Jul 2024 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGAPKHqe"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B88A1B86FB;
	Thu, 18 Jul 2024 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721299827; cv=none; b=ESeWmG49ambjFa6XSyAmcrUpyUMmgEJlWBa/9wTp7fwwuwGPpjYQCGtS7KKmFH59vUMm3ytRY0/kTHpfeEV3kZELkt609+MighhHuml1kkbFmfNLq1TG2jeTdPBx+TZmQ2sYEQJAQCim5EUzPHBQrkUoL1XLsgGsXr3fXm3hqdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721299827; c=relaxed/simple;
	bh=vEjFRBWsSwAIUZLWB+DrzyigB9DIGSgo2Bnboz2zqeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y0hHRoASjQB//gUm+Vyxu3sOjD+wqbGk4xMfBeVnFsfzNcYquBvkTXDGBKXkSs/+roDjBsrz5Ygp0htCEt10lYgw1//5uBhs+S8vv/SD4BHVa2SoJ6rZcaQi8+Us5C6rUcopjtiqHFjjeAHWzri6/QtSXi/hQ6lA+3FIGP8ExgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGAPKHqe; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-78135be2d46so411700a12.0;
        Thu, 18 Jul 2024 03:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721299823; x=1721904623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+eCSYPvaq7B66pgnJLs9WEsLtzq9JpmQfKw7c3QRAWo=;
        b=gGAPKHqeXYRbMlcDRXMzJRcYuuLmU9gEygjt9YfwFbD981pl+zJNCtI0ZhvL12ITI6
         EDCDIYo6xyEPVbPEofJxfqxoYTQ/Gosyoi7vB/D1aX1WlGgNrai/SZuon2Kh46m2LJi5
         X7IzsEiC9kz8QE3jpKAz00N0NIqQs3pA+tidMk6NsTeRBsmQFSqZSKlQD1ddwUCSeI3x
         OY0trQrnSUGruAQA7LRtM/twHIPP6YVfYJXDjekvSQF+6ugi6BouNgeRsIQi5BK2F+wA
         6rY5a2jY8aDUylxCPc9aIEvoUVpj2iLElFFtys1sPqX25gZFsyJF0FM7PP2BKBNskbs/
         FarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721299823; x=1721904623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+eCSYPvaq7B66pgnJLs9WEsLtzq9JpmQfKw7c3QRAWo=;
        b=vWpB5GLq31cOdqh78QoY++uf/bQC8hxo7hoNTSNWG55MvWszP/SwnkfR5kVSJAndFc
         ZZwobmgWGNOZ/uOM2639ztM9yrM4Q1VbZ4RTVZfGi6yW/h8ogtkiBQObUFKZY+sopoQS
         5Jx8VqOiJOW/syRPx6sC+Ea2dezVjd0EArsakHNgwBT/NCKdgZMjgu4614V9ydyVJl3u
         BgVzCbDrWXYwDg/iKGozWNQoFzzfR0+/8Ybgy1NFQTJKP93/+CkgVaxaTc3lv5GtP1vE
         sshdLxcjJVnyHtPUI0vgRSDOp8BMDrQVjjp4iBGHCIJL1MDjs6iaQR4eb2Aoa+nDLLIH
         CMQg==
X-Forwarded-Encrypted: i=1; AJvYcCXpeHMDlfrG3dekooTJicuFsKznNXV/pnahD7d4ed1rwBrWmWg2UWN/7PjXMrpU9asm5SATNeN4tUEVIqWhW2vTlyz/3vXz6vEZHHTG
X-Gm-Message-State: AOJu0YzuNc7nRWY1C0enDlgc4hc5pRYd4EOI5FffKteRfQ2E2iebqwOn
	r6gJFVe4WjFmbQFasIY986QgoLDm0xwnUtaDtfpXEQQP+E+OZRBNMF8MwxO3A4VoIg==
X-Google-Smtp-Source: AGHT+IFaXR2RtJ3pBrYJc2vTjIu0AooOWZLuE6CPwbh+wMKWgPCeEUd/i9/Qa4uykcV5cFvFctJO0g==
X-Received: by 2002:a05:6a21:670b:b0:1c0:bd6c:aaa0 with SMTP id adf61e73a8af0-1c3fdcf4ba7mr4879444637.28.1721299822961;
        Thu, 18 Jul 2024 03:50:22 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2cb778c6fe6sm330366a91.10.2024.07.18.03.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 03:50:22 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH] iio: light: ltr390: Add configurable gain, resolution and ALS reading
Date: Thu, 18 Jul 2024 16:19:45 +0530
Message-ID: <20240718104947.7384-1-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 1) Add support for configuring the gain and resolution(integration time)
    for the sensor.
 2) Add a channel for ALS and provide support for reading the raw and
    scale values.
 3) Add automatic mode switching between UVS and ALS based on the
    channel type.
 4) Calculate 'counts_per_uvi' based on the current gain and integration
    time.

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/light/ltr390.c | 256 ++++++++++++++++++++++++++++++++++---
 1 file changed, 238 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index fff1e8990..56f3c74ae 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -25,19 +25,33 @@
 #include <linux/regmap.h>
 
 #include <linux/iio/iio.h>
-
+#include <linux/iio/sysfs.h>
 #include <asm/unaligned.h>
 
 #define LTR390_MAIN_CTRL      0x00
 #define LTR390_PART_ID	      0x06
 #define LTR390_UVS_DATA	      0x10
 
+#define LTR390_ALS_DATA       0x0D
+#define LTR390_ALS_UVS_GAIN   0x05
+#define LTR390_ALS_UVS_MEAS_RATE 0x04
+#define LTR390_INT_CFG           0x19
+
 #define LTR390_SW_RESET	      BIT(4)
 #define LTR390_UVS_MODE	      BIT(3)
 #define LTR390_SENSOR_ENABLE  BIT(1)
 
 #define LTR390_PART_NUMBER_ID 0xb
 
+#define LTR390_ALS_UVS_GAIN_MASK 0x07
+#define LTR390_ALS_UVS_INT_TIME_MASK 0x70
+#define LTR390_ALS_UVS_INT_TIME_MASK_SHIFT 4
+
+#define LTR390_SET_ALS_MODE 1
+#define LTR390_SET_UVS_MODE 2
+
+#define LTR390_FRACTIONAL_PRECISION 100
+
 /*
  * At 20-bit resolution (integration time: 400ms) and 18x gain, 2300 counts of
  * the sensor are equal to 1 UV Index [Datasheet Page#8].
@@ -60,6 +74,9 @@ struct ltr390_data {
 	struct i2c_client *client;
 	/* Protects device from simulataneous reads */
 	struct mutex lock;
+	int mode;
+	int gain;
+	int int_time_us;
 };
 
 static const struct regmap_config ltr390_regmap_config = {
@@ -87,36 +104,232 @@ static int ltr390_register_read(struct ltr390_data *data, u8 register_address)
 	return get_unaligned_le24(recieve_buffer);
 }
 
+
+static int ltr390_set_mode(struct ltr390_data *data, int mode)
+{
+	if (data->mode == mode)
+		return 0;
+
+	if (mode == LTR390_SET_ALS_MODE) {
+		regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_UVS_MODE);
+		data->mode = LTR390_SET_ALS_MODE;
+	} else if (mode == LTR390_SET_UVS_MODE) {
+		regmap_set_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_UVS_MODE);
+		data->mode = LTR390_SET_UVS_MODE;
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ltr390_counts_per_uvi(struct ltr390_data *data)
+{
+	int orig_gain = 18;
+	int orig_int_time = 400;
+	int divisor = orig_gain * orig_int_time;
+	int gain = data->gain;
+
+	int int_time_ms = DIV_ROUND_CLOSEST(data->int_time_us, 1000);
+	int uvi = DIV_ROUND_CLOSEST(2300*gain*int_time_ms, divisor);
+
+	return uvi;
+}
+
 static int ltr390_read_raw(struct iio_dev *iio_device,
 			   struct iio_chan_spec const *chan, int *val,
 			   int *val2, long mask)
 {
-	int ret;
 	struct ltr390_data *data = iio_priv(iio_device);
+	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = ltr390_register_read(data, LTR390_UVS_DATA);
-		if (ret < 0)
-			return ret;
+		switch (chan->type) {
+		case IIO_UVINDEX:
+			ret = ltr390_set_mode(data, LTR390_SET_UVS_MODE);
+			if (ret < 0)
+				return ret;
+
+		    ret = ltr390_register_read(data, LTR390_UVS_DATA);
+			if (ret < 0)
+				return ret;
+
+			break;
+
+		case IIO_INTENSITY:
+			ret = ltr390_set_mode(data, LTR390_SET_ALS_MODE);
+			if (ret < 0)
+				return ret;
+
+			ret = ltr390_register_read(data, LTR390_ALS_DATA);
+			if (ret < 0)
+				return ret;
+			break;
+
+		default:
+			ret = -EINVAL;
+		}
+
 		*val = ret;
-		return IIO_VAL_INT;
+		ret = IIO_VAL_INT;
+		break;
+
 	case IIO_CHAN_INFO_SCALE:
-		*val = LTR390_WINDOW_FACTOR;
-		*val2 = LTR390_COUNTS_PER_UVI;
-		return IIO_VAL_FRACTIONAL;
+		mutex_lock(&data->lock);
+
+		switch (chan->type) {
+		case IIO_UVINDEX:
+			ret = ltr390_set_mode(data, LTR390_SET_UVS_MODE);
+			if (ret < 0)
+				return ret;
+
+			*val = LTR390_WINDOW_FACTOR * LTR390_FRACTIONAL_PRECISION;
+			*val2 = ltr390_counts_per_uvi(data);
+			ret = IIO_VAL_FRACTIONAL;
+			break;
+
+		case IIO_INTENSITY:
+			ret = ltr390_set_mode(data, LTR390_SET_ALS_MODE);
+			if (ret < 0)
+				return ret;
+
+			*val = LTR390_WINDOW_FACTOR;
+			*val2 = data->gain;
+
+			ret = IIO_VAL_FRACTIONAL;
+			break;
+
+		default:
+			ret = -EINVAL;
+		}
+
+		mutex_unlock(&data->lock);
+		break;
+
+	case IIO_CHAN_INFO_INT_TIME:
+		mutex_lock(&data->lock);
+		*val = data->int_time_us;
+		mutex_unlock(&data->lock);
+		ret = IIO_VAL_INT;
+		break;
+
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
+
+	return ret;
 }
 
-static const struct iio_info ltr390_info = {
-	.read_raw = ltr390_read_raw,
+/* integration time in us */
+static const int ltr390_int_time_map_us[] = {400000, 200000, 100000, 50000, 25000, 12500};
+static const int ltr390_gain_map[] = {1, 3, 6, 9, 18};
+
+static IIO_CONST_ATTR_INT_TIME_AVAIL("400000 200000 100000 50000 25000 12500");
+static IIO_CONST_ATTR(gain_available, "1 3 6 9 18");
+
+static struct attribute *ltr390_attributes[] = {
+	&iio_const_attr_integration_time_available.dev_attr.attr,
+	&iio_const_attr_gain_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ltr390_attribute_group = {
+	.attrs = ltr390_attributes,
 };
 
-static const struct iio_chan_spec ltr390_channel = {
+static const struct iio_chan_spec ltr390_channels[] = {
+	/* UV sensor */
+	{
 	.type = IIO_UVINDEX,
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE)
+	.scan_index = 0,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME)
+	},
+	/* ALS sensor */
+	{
+	.type = IIO_INTENSITY,
+	.scan_index = 1,
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME)
+	},
+};
+
+static int ltr390_set_gain(struct ltr390_data *data, int val)
+{
+	int ret, idx;
+
+	for (idx = 0; idx < ARRAY_SIZE(ltr390_gain_map); idx++) {
+		if (ltr390_gain_map[idx] == val) {
+			mutex_lock(&data->lock);
+			ret = regmap_update_bits(data->regmap,
+						LTR390_ALS_UVS_GAIN,
+						LTR390_ALS_UVS_GAIN_MASK, idx);
+			if (!ret)
+				data->gain = ltr390_gain_map[idx];
+
+			mutex_unlock(&data->lock);
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static int ltr390_set_int_time(struct ltr390_data *data, int val)
+{
+	int ret, idx;
+
+	for (idx = 0; idx < ARRAY_SIZE(ltr390_int_time_map_us); idx++) {
+		if (ltr390_int_time_map_us[idx] == val) {
+			mutex_lock(&data->lock);
+			ret = regmap_update_bits(data->regmap,
+						LTR390_ALS_UVS_MEAS_RATE,
+						LTR390_ALS_UVS_INT_TIME_MASK,
+						idx<<LTR390_ALS_UVS_INT_TIME_MASK_SHIFT);
+			if (!ret)
+				data->int_time_us = ltr390_int_time_map_us[idx];
+
+			mutex_unlock(&data->lock);
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static int ltr390_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+				int val, int val2, long mask)
+{
+	struct ltr390_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		if (val2 != 0)
+			ret = -EINVAL;
+
+		ret = ltr390_set_gain(data, val);
+		break;
+
+	case IIO_CHAN_INFO_INT_TIME:
+		if (val2 != 0)
+			ret = -EINVAL;
+
+		ret = ltr390_set_int_time(data, val);
+		break;
+
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static const struct iio_info ltr390_info = {
+	.attrs = &ltr390_attribute_group,
+	.read_raw = ltr390_read_raw,
+	.write_raw = ltr390_write_raw,
 };
 
 static int ltr390_probe(struct i2c_client *client)
@@ -139,11 +352,18 @@ static int ltr390_probe(struct i2c_client *client)
 				     "regmap initialization failed\n");
 
 	data->client = client;
+	/* default value of int time from pg: 15 of the datasheet */
+	data->int_time_us = 100000;
+	/* default value of gain from pg: 16 of the datasheet */
+	data->gain = 3;
+	/* default mode for ltr390 is ALS mode */
+	data->mode = LTR390_SET_ALS_MODE;
+
 	mutex_init(&data->lock);
 
 	indio_dev->info = &ltr390_info;
-	indio_dev->channels = &ltr390_channel;
-	indio_dev->num_channels = 1;
+	indio_dev->channels = ltr390_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ltr390_channels);
 	indio_dev->name = "ltr390";
 
 	ret = regmap_read(data->regmap, LTR390_PART_ID, &part_number);
@@ -161,8 +381,7 @@ static int ltr390_probe(struct i2c_client *client)
 	/* Wait for the registers to reset before proceeding */
 	usleep_range(1000, 2000);
 
-	ret = regmap_set_bits(data->regmap, LTR390_MAIN_CTRL,
-			      LTR390_SENSOR_ENABLE | LTR390_UVS_MODE);
+	ret = regmap_set_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_SENSOR_ENABLE);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to enable the sensor\n");
 
@@ -189,6 +408,7 @@ static struct i2c_driver ltr390_driver = {
 	.probe = ltr390_probe,
 	.id_table = ltr390_id,
 };
+
 module_i2c_driver(ltr390_driver);
 
 MODULE_AUTHOR("Anshul Dalal <anshulusr@gmail.com>");
-- 
2.43.0


