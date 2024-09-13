Return-Path: <linux-iio+bounces-9505-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F50978100
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 15:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89FD285215
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 13:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F033F1DB52E;
	Fri, 13 Sep 2024 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3wXmPZE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D101DC1A4;
	Fri, 13 Sep 2024 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233568; cv=none; b=b9fh0DrRqcDKXqIz3NnkhfoKzemJ/NdCBVKxBT9P7TSbJ1JLJrS1JXj/tSZ8tOCP4ef/U9YCeCa2KHMVFHrOxqpFA6UdlZ18PxKHZ8FpDYDyJjxx64ug8+3J2ptPqcioc7puAv/LAdJgKOLGlkmzNwV1wsu+S2eZQ8l0aRNIHj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233568; c=relaxed/simple;
	bh=t6mgGp9Vg7sGs79HuOV6idIRLy5hQ/Ir5tJ9nVviFUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tFHhkFiwWik7/tN9a5JUnFD4fx6MaOfBZEylc89A/F392QI1F7w9Vdju9jOWqZiYOho/xunHbTyu05Dn/1C0cQukb0T0McTxkngj5j3lEbiFH839fCHygtirV1ulV8KKH78MY6KtQ+yq8UVEul+vXHK0dybS/QPX8RbwY9Bcelk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3wXmPZE; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8d4093722bso285531766b.0;
        Fri, 13 Sep 2024 06:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726233565; x=1726838365; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e3VOjACAwwRG2xUv/ZVo50qMovzLbtOXrSIBAXe2PmQ=;
        b=h3wXmPZEiX+L4aDDAlvHFPisgKUSy5AJ1VNgniBF//7QsiPejeqjryhFowpiQ2AIso
         MS0AAkIqh/S2hROiGSZ3s+QVWEIuFuOAkd5S3LVY1vlAvMRMqGEEt/efAOpFqgu/6uSY
         4nkjDXNq0raxk3bDhK9GgGbJB2+ELxwPWSTsE17cQ4WI8WwANpP94tDgDjRRzcr7eOgu
         ZDOwLK+zQtxnvaa+nNbYcV/wCwtcQ0D0lLWbu3+BrsK48HS7rTI6sMeGuUktNK2WxCaI
         7F6Vkt46rfPcBwHPSRVtCf7nruCBq8cqx1VtZJV+9Pm7AEXzR1THPIzkkzDCiA7BJebt
         udSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726233565; x=1726838365;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3VOjACAwwRG2xUv/ZVo50qMovzLbtOXrSIBAXe2PmQ=;
        b=kg7yTcgu82Y/7bJRi2JC0BDATXXTpUo8ZIdPCx7Irna0gnNgHN4iSGO5FD0Rqt9g7Q
         E0Wa28N08zRGPwOuSSkFX5NrPj+CYcat64cOpOUBrbkMBWGCLI/WrxT10CJqwTfc7jsi
         m4Z2mSDXX2hZ6wIv6rAw+j1wY8qqtJv2i640CCm+PMbP/lSpd7oXxJM40PIA/3jVBSqx
         fC0bJ1UfxN7KZ6WzMeKQ4m+wvjjIyfGKWhqCDTP2p+X8TS+Bet3ikkK6sRdhrfVk6+Iv
         xbeyeuAwcew5EX/qXIKaCGi4at00rBwv+Ju9vpPP4ONMHGFgIj4KWlgnzs1Q2XNiogWw
         7YXg==
X-Forwarded-Encrypted: i=1; AJvYcCUEy59vW/1nkJY9cjytiH0eYCjvrERQdtNfMxeob0Lpem0WeLSkLNX7ZTjk/hC6paQbxxjNTRKgwQglrozj@vger.kernel.org, AJvYcCVMtuPZVCDo09vULr6ec38uSa+kaUEht0silS7GIhEJi9T6bV2fq4KTmfUzvcUoqhyCjnJadk4Lxpmh@vger.kernel.org
X-Gm-Message-State: AOJu0YxTUq7Deg1vHruGVtgO3gdcXosiUAoi/T8j7YIc7eQgX7lS+9Qj
	MQBxsW+kFYmL/TvZq9qkfI7W18+kVn8WCoggk6bVMHOyPfGwV+Nt
X-Google-Smtp-Source: AGHT+IEyVGWNoj5HraKCjAhv01hnN28xv9kutpbklD2oY34ELG8GIG/PO0HZ21fKkbGco56j6AnzMg==
X-Received: by 2002:a17:907:efc6:b0:a86:9c71:ec93 with SMTP id a640c23a62f3a-a9029438edemr672926866b.24.1726233564939;
        Fri, 13 Sep 2024 06:19:24 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25a258a3sm865945666b.89.2024.09.13.06.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 06:19:24 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 13 Sep 2024 15:19:02 +0200
Subject: [PATCH 7/7] iio: light: veml6030: add support for veml6035
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-veml6035-v1-7-0b09c0c90418@gmail.com>
References: <20240913-veml6035-v1-0-0b09c0c90418@gmail.com>
In-Reply-To: <20240913-veml6035-v1-0-0b09c0c90418@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726233553; l=14378;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=t6mgGp9Vg7sGs79HuOV6idIRLy5hQ/Ir5tJ9nVviFUw=;
 b=Fhe5cwMkT01pIdBkLK8cwUDGuQ6etJjs+tU3zZuGK1AWIGxAGMcdkPgcdPX/gIGrOHqoxwv8p
 NomkLKkO57DCfsOkSx5cA9OJoJi0BTDUL4vWZVu3EkkZcpE+IdAv4dI
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The veml6035 is an ALS that shares most of its functionality with the
veml6030, which allows for some code recycling.

Some chip-specific properties differ and dedicated functions to get and
set the sensor gain as well as its initialization are required.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6030.c | 300 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 273 insertions(+), 27 deletions(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 2945cc1db599..105f310c4954 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -1,13 +1,19 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * VEML6030 Ambient Light Sensor
+ * VEML6030 and VMEL6035 Ambient Light Sensors
  *
  * Copyright (c) 2019, Rishi Gupta <gupt21@gmail.com>
  *
+ * VEML6030:
  * Datasheet: https://www.vishay.com/docs/84366/veml6030.pdf
  * Appnote-84367: https://www.vishay.com/docs/84367/designingveml6030.pdf
+ *
+ * VEML6035:
+ * Datasheet: https://www.vishay.com/docs/84889/veml6035.pdf
+ * Appnote-84944: https://www.vishay.com/docs/84944/designingveml6035.pdf
  */
 
+#include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/err.h>
@@ -38,16 +44,33 @@
 #define VEML6030_ALS_INT_EN   BIT(1)
 #define VEML6030_ALS_SD       BIT(0)
 
+#define VEML6035_GAIN_M       GENMASK(12, 10)
+#define VEML6035_GAIN         BIT(10)
+#define VEML6035_DG           BIT(11)
+#define VEML6035_SENS         BIT(12)
+#define VEML6035_INT_CHAN     BIT(3)
+#define VEML6035_CHAN_EN      BIT(2)
+
+struct veml603x_chip {
+	const char *name;
+	const struct iio_info *info;
+	const struct iio_info *info_no_irq;
+	const char * const in_illuminance_scale_avail;
+	int (*hw_init)(struct iio_dev *indio_dev);
+	int (*set_als_gain)(struct iio_dev *indio_dev, int val, int val2);
+	int (*get_als_gain)(struct iio_dev *indio_dev, int *val, int *val2);
+};
+
 /*
  * The resolution depends on both gain and integration time. The
  * cur_resolution stores one of the resolution mentioned in the
  * table during startup and gets updated whenever integration time
  * or gain is changed.
  *
- * Table 'resolution and maximum detection range' in appnote 84367
+ * Table 'resolution and maximum detection range' in the appnotes
  * is visualized as a 2D array. The cur_gain stores index of gain
- * in this table (0-3) while the cur_integration_time holds index
- * of integration time (0-5).
+ * in this table (0-3 for VEML6030, 0-5 for VEML6035) while the
+ * cur_integration_time holds index of integration time (0-5).
  */
 struct veml6030_data {
 	struct i2c_client *client;
@@ -55,6 +78,7 @@ struct veml6030_data {
 	int cur_resolution;
 	int cur_gain;
 	int cur_integration_time;
+	const struct veml603x_chip *chip;
 };
 
 /* Integration time available in seconds */
@@ -63,14 +87,25 @@ static IIO_CONST_ATTR(in_illuminance_integration_time_available,
 
 /*
  * Scale is 1/gain. Value 0.125 is ALS gain x (1/8), 0.25 is
- * ALS gain x (1/4), 1.0 = ALS gain x 1 and 2.0 is ALS gain x 2.
+ * ALS gain x (1/4), 0.5 is ALS gain x (1/2), 1.0 is ALS gain x 1,
+ * 2.0 is ALS gain x2, and 4.0 is ALS gain x 4.
  */
-static IIO_CONST_ATTR(in_illuminance_scale_available,
+static IIO_CONST_ATTR_NAMED(veml6030_in_illuminance_scale_available,
+			    in_illuminance_scale_available,
 				"0.125 0.25 1.0 2.0");
+static IIO_CONST_ATTR_NAMED(veml6035_in_illuminance_scale_available,
+			    in_illuminance_scale_available,
+				"0.125 0.25 0.5 1.0 2.0 4.0");
 
 static struct attribute *veml6030_attributes[] = {
 	&iio_const_attr_in_illuminance_integration_time_available.dev_attr.attr,
-	&iio_const_attr_in_illuminance_scale_available.dev_attr.attr,
+	&iio_const_attr_veml6030_in_illuminance_scale_available.dev_attr.attr,
+	NULL
+};
+
+static struct attribute *veml6035_attributes[] = {
+	&iio_const_attr_in_illuminance_integration_time_available.dev_attr.attr,
+	&iio_const_attr_veml6035_in_illuminance_scale_available.dev_attr.attr,
 	NULL
 };
 
@@ -78,6 +113,10 @@ static const struct attribute_group veml6030_attr_group = {
 	.attrs = veml6030_attributes,
 };
 
+static const struct attribute_group veml6035_attr_group = {
+	.attrs = veml6035_attributes,
+};
+
 /*
  * Persistence = 1/2/4/8 x integration time
  * Minimum time for which light readings must stay above configured
@@ -380,6 +419,21 @@ static int veml6030_write_persistence(struct iio_dev *indio_dev,
 	return ret;
 }
 
+/*
+ * Cache currently set gain & update resolution. For every
+ * increase in the gain to next level, resolution is halved
+ * and vice-versa.
+ */
+static void veml6030_update_gain_res(struct veml6030_data *data, int gain_idx)
+{
+	if (data->cur_gain < gain_idx)
+		data->cur_resolution <<= gain_idx - data->cur_gain;
+	else if (data->cur_gain > gain_idx)
+		data->cur_resolution >>= data->cur_gain - gain_idx;
+
+	data->cur_gain = gain_idx;
+}
+
 static int veml6030_set_als_gain(struct iio_dev *indio_dev,
 						int val, int val2)
 {
@@ -410,19 +464,49 @@ static int veml6030_set_als_gain(struct iio_dev *indio_dev,
 		return ret;
 	}
 
-	/*
-	 * Cache currently set gain & update resolution. For every
-	 * increase in the gain to next level, resolution is halved
-	 * and vice-versa.
-	 */
-	if (data->cur_gain < gain_idx)
-		data->cur_resolution <<= gain_idx - data->cur_gain;
-	else if (data->cur_gain > gain_idx)
-		data->cur_resolution >>= data->cur_gain - gain_idx;
+	veml6030_update_gain_res(data, gain_idx);
 
-	data->cur_gain = gain_idx;
+	return 0;
+}
 
-	return ret;
+static int veml6035_set_als_gain(struct iio_dev *indio_dev, int val, int val2)
+{
+	int ret, new_gain, gain_idx;
+	struct veml6030_data *data = iio_priv(indio_dev);
+
+	if (val == 0 && val2 == 125000) {
+		new_gain = VEML6035_SENS;
+		gain_idx = 5;
+	} else if (val == 0 && val2 == 250000) {
+		new_gain = VEML6035_SENS | VEML6035_GAIN;
+		gain_idx = 4;
+	} else if (val == 0 && val2 == 500000) {
+		new_gain = VEML6035_SENS | VEML6035_GAIN |
+			VEML6035_DG;
+		gain_idx = 3;
+	} else if (val == 1 && val2 == 0) {
+		new_gain = 0x0000;
+		gain_idx = 2;
+	} else if (val == 2 && val2 == 0) {
+		new_gain = VEML6035_GAIN;
+		gain_idx = 1;
+	} else if (val == 4 && val2 == 0) {
+		new_gain = VEML6035_GAIN | VEML6035_DG;
+		gain_idx = 0;
+	} else {
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_CONF,
+				 VEML6035_GAIN_M, new_gain);
+	if (ret) {
+		dev_err(&data->client->dev, "can't set als gain %d\n", ret);
+		return ret;
+	}
+
+	veml6030_update_gain_res(data, gain_idx);
+
+	return 0;
 }
 
 static int veml6030_get_als_gain(struct iio_dev *indio_dev,
@@ -462,6 +546,52 @@ static int veml6030_get_als_gain(struct iio_dev *indio_dev,
 	return IIO_VAL_INT_PLUS_MICRO;
 }
 
+static int veml6035_get_als_gain(struct iio_dev *indio_dev, int *val, int *val2)
+{
+	int ret, reg;
+	struct veml6030_data *data = iio_priv(indio_dev);
+
+	ret = regmap_read(data->regmap, VEML6030_REG_ALS_CONF, &reg);
+	if (ret) {
+		dev_err(&data->client->dev,
+			"can't read als conf register %d\n", ret);
+		return ret;
+	}
+
+	switch (FIELD_GET(VEML6035_GAIN_M, reg)) {
+	case 0:
+		*val = 1;
+		*val2 = 0;
+		break;
+	case 1:
+	case 2:
+		*val = 2;
+		*val2 = 0;
+		break;
+	case 3:
+		*val = 4;
+		*val2 = 0;
+		break;
+	case 4:
+		*val = 0;
+		*val2 = 125000;
+		break;
+	case 5:
+	case 6:
+		*val = 0;
+		*val2 = 250000;
+		break;
+	case 7:
+		*val = 0;
+		*val2 = 500000;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
 static int veml6030_read_thresh(struct iio_dev *indio_dev,
 						int *val, int *val2, int dir)
 {
@@ -558,7 +688,7 @@ static int veml6030_read_raw(struct iio_dev *indio_dev,
 		return -EINVAL;
 	case IIO_CHAN_INFO_SCALE:
 		if (chan->type == IIO_LIGHT)
-			return veml6030_get_als_gain(indio_dev, val, val2);
+			return data->chip->get_als_gain(indio_dev, val, val2);
 		return -EINVAL;
 	default:
 		return -EINVAL;
@@ -569,6 +699,8 @@ static int veml6030_write_raw(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan,
 				int val, int val2, long mask)
 {
+	struct veml6030_data *data = iio_priv(indio_dev);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_INT_TIME:
 		switch (chan->type) {
@@ -580,7 +712,7 @@ static int veml6030_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_LIGHT:
-			return veml6030_set_als_gain(indio_dev, val, val2);
+			return data->chip->set_als_gain(indio_dev, val, val2);
 		default:
 			return -EINVAL;
 		}
@@ -691,12 +823,29 @@ static const struct iio_info veml6030_info = {
 	.event_attrs = &veml6030_event_attr_group,
 };
 
+static const struct iio_info veml6035_info = {
+	.read_raw  = veml6030_read_raw,
+	.write_raw = veml6030_write_raw,
+	.read_event_value = veml6030_read_event_val,
+	.write_event_value = veml6030_write_event_val,
+	.read_event_config = veml6030_read_interrupt_config,
+	.write_event_config = veml6030_write_interrupt_config,
+	.attrs = &veml6035_attr_group,
+	.event_attrs = &veml6030_event_attr_group,
+};
+
 static const struct iio_info veml6030_info_no_irq = {
 	.read_raw  = veml6030_read_raw,
 	.write_raw = veml6030_write_raw,
 	.attrs = &veml6030_attr_group,
 };
 
+static const struct iio_info veml6035_info_no_irq = {
+	.read_raw  = veml6030_read_raw,
+	.write_raw = veml6030_write_raw,
+	.attrs = &veml6035_attr_group,
+};
+
 static irqreturn_t veml6030_event_handler(int irq, void *private)
 {
 	int ret, reg, evtdir;
@@ -791,6 +940,73 @@ static int veml6030_hw_init(struct iio_dev *indio_dev)
 	return ret;
 }
 
+/*
+ * Set ALS gain to 1/8, integration time to 100 ms, ALS and WHITE
+ * channel enabled, ALS channel interrupt, PSM enabled,
+ * PSM_WAIT = 0.8 s, persistence to 1 x integration time and the
+ * threshold interrupt disabled by default. First shutdown the sensor,
+ * update registers and then power on the sensor.
+ */
+static int veml6035_hw_init(struct iio_dev *indio_dev)
+{
+	int ret, val;
+	struct veml6030_data *data = iio_priv(indio_dev);
+	struct i2c_client *client = data->client;
+
+	ret = veml6030_als_shut_down(data);
+	if (ret) {
+		dev_err(&client->dev, "can't shutdown als %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_write(data->regmap, VEML6030_REG_ALS_CONF,
+			   VEML6035_SENS | VEML6035_CHAN_EN | VEML6030_ALS_SD);
+	if (ret) {
+		dev_err(&client->dev, "can't setup als configs %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_PSM,
+				 VEML6030_PSM | VEML6030_PSM_EN, 0x03);
+	if (ret) {
+		dev_err(&client->dev, "can't setup default PSM %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_write(data->regmap, VEML6030_REG_ALS_WH, 0xFFFF);
+	if (ret) {
+		dev_err(&client->dev, "can't setup high threshold %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_write(data->regmap, VEML6030_REG_ALS_WL, 0x0000);
+	if (ret) {
+		dev_err(&client->dev, "can't setup low threshold %d\n", ret);
+		return ret;
+	}
+
+	ret = veml6030_als_pwr_on(data);
+	if (ret) {
+		dev_err(&client->dev, "can't poweron als %d\n", ret);
+		return ret;
+	}
+
+	/* Clear stale interrupt status bits if any during start */
+	ret = regmap_read(data->regmap, VEML6030_REG_ALS_INT, &val);
+	if (ret < 0) {
+		dev_err(&client->dev,
+			"can't clear als interrupt status %d\n", ret);
+		return ret;
+	}
+
+	/* Cache currently active measurement parameters */
+	data->cur_gain = 5;
+	data->cur_resolution = 1024;
+	data->cur_integration_time = 3;
+
+	return 0;
+}
+
 static int veml6030_probe(struct i2c_client *client)
 {
 	int ret;
@@ -818,7 +1034,11 @@ static int veml6030_probe(struct i2c_client *client)
 	data->client = client;
 	data->regmap = regmap;
 
-	indio_dev->name = "veml6030";
+	data->chip = i2c_get_match_data(client);
+	if (!data->chip)
+		return -EINVAL;
+
+	indio_dev->name = data->chip->name;
 	indio_dev->channels = veml6030_channels;
 	indio_dev->num_channels = ARRAY_SIZE(veml6030_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -827,18 +1047,18 @@ static int veml6030_probe(struct i2c_client *client)
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						NULL, veml6030_event_handler,
 						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-						"veml6030", indio_dev);
+						indio_dev->name, indio_dev);
 		if (ret < 0) {
 			dev_err(&client->dev,
 					"irq %d request failed\n", client->irq);
 			return ret;
 		}
-		indio_dev->info = &veml6030_info;
+		indio_dev->info = data->chip->info;
 	} else {
-		indio_dev->info = &veml6030_info_no_irq;
+		indio_dev->info = data->chip->info_no_irq;
 	}
 
-	ret = veml6030_hw_init(indio_dev);
+	ret = data->chip->hw_init(indio_dev);
 	if (ret < 0)
 		return ret;
 
@@ -879,14 +1099,40 @@ static int veml6030_runtime_resume(struct device *dev)
 static DEFINE_RUNTIME_DEV_PM_OPS(veml6030_pm_ops, veml6030_runtime_suspend,
 				 veml6030_runtime_resume, NULL);
 
+static const struct veml603x_chip veml6030_chip = {
+	.name = "veml6030",
+	.info = &veml6030_info,
+	.info_no_irq = &veml6030_info_no_irq,
+	.hw_init = veml6030_hw_init,
+	.set_als_gain = veml6030_set_als_gain,
+	.get_als_gain = veml6030_get_als_gain,
+};
+
+static const struct veml603x_chip veml6035_chip = {
+	.name = "veml6035",
+	.info = &veml6035_info,
+	.info_no_irq = &veml6035_info_no_irq,
+	.hw_init = veml6035_hw_init,
+	.set_als_gain = veml6035_set_als_gain,
+	.get_als_gain = veml6035_get_als_gain,
+};
+
 static const struct of_device_id veml6030_of_match[] = {
-	{ .compatible = "vishay,veml6030" },
+	{
+		.compatible = "vishay,veml6030",
+		.data = &veml6030_chip,
+	},
+	{
+		.compatible = "vishay,veml6035",
+		.data = &veml6035_chip,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, veml6030_of_match);
 
 static const struct i2c_device_id veml6030_id[] = {
-	{ "veml6030" },
+	{ "veml6030", (kernel_ulong_t)&veml6030_chip},
+	{ "veml6035", (kernel_ulong_t)&veml6035_chip},
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, veml6030_id);

-- 
2.43.0


