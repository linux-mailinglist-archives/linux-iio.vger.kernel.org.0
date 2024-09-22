Return-Path: <linux-iio+bounces-9718-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 223E397E40C
	for <lists+linux-iio@lfdr.de>; Mon, 23 Sep 2024 00:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33346B20BA3
	for <lists+linux-iio@lfdr.de>; Sun, 22 Sep 2024 22:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3452E13D89D;
	Sun, 22 Sep 2024 22:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6mc8OnH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D384D7EF09;
	Sun, 22 Sep 2024 22:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727043494; cv=none; b=C0Zs5NN5WpWdIfoITMx4TarVjCrjpUsRrNQ+pf3f7ISZPJHIKdFE+cnWNaQ6dIp1ovbZFUqg5QV3fY0+6yr7ldWlZ8dXDkXDL8ekjA9pprWg5fZiTIi1XtWTagZxitYEwCV3LUKk8w0XnxBWHwCmivSIv2Z/074qDjenbhDpt3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727043494; c=relaxed/simple;
	bh=+q0HZm1fKYjGmC3vzyj1zQ35NDKLymKJHg/syO6dFQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ws69f2DYzTxWa91u3Bj8Q1qMYdRiZUZKJVTE2fCgxMzl9dUaj9aJhjUQpdebTkc+9MU+4cjjJSYHOi6JzqiiK4PrEc+KxQxT5CjTPddfwrr4LNNLKdGLVa9oHF87j55UdA+kklib0WTIsCQ+nq6ppFJ+2mafYNvr1BGy0wr1apA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6mc8OnH; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d51a7d6f5so555723666b.2;
        Sun, 22 Sep 2024 15:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727043490; x=1727648290; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gGEeYvPXX8SDLK5PLcriklcqRkSODY2YvcKvFKnL6qM=;
        b=d6mc8OnHa4qpG4mLcADLpeSHBrFmaLcuQs5pSXUwRn3/ELMuwuhIqAcawSFmbsSn6e
         cOTLL7lcRYEzsQBDoiJ8c1ibFAeXuSvZm/RE4WQR0CL4y8+t/I5ohwXFZ57eNIbPUlo3
         lCiv92elWTI+KMtWxhuE4s489xaHYuDC07EFsGO+tpcWuR3bn3P2q6VReiVFNdJd/Xtc
         T5W+/K5DfVJzgitl42D9VKkmR/QKx7zxo7H+5jJ1LYMyOBSuqZqRuN0HljigSvI8kIzD
         UivxGKwEp8Le1EsIiYeO2M9tFYRNf4mCS3z/OCO4N/Fp9292ZX8IrNma7en4tNmdnWhO
         +EUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727043490; x=1727648290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGEeYvPXX8SDLK5PLcriklcqRkSODY2YvcKvFKnL6qM=;
        b=P/MpJliGhy0EIqrupL3AXlbOhZOzT7bE/mwHWbN4fTYwd69vHtOd7C1kHVQSSowhF3
         0QiHN8n+PLGofNlk9Ma6IQMvseyJfqEHhGNdEf67R+7GsO3ymhCK6icow5HDbIUvhsCp
         whzHPMK1OPVXkpIZNYOhKtvDoG2umt8mwpdYOC5SSBD1e1FcEE5mYHdN7QKNoL3hlpda
         Me/vQwLh+56KaEMkPH8qFz4gJ/ardh/3NT22MpwIw3K5cI/MdmkkpmcQNuatv8Zv4L4K
         mPEddhz59LGFNmTGS2hrpMdOfI6svPHyBspjgVdLcFOHF63+hKTAV2Eqvx6l8t+kzqNU
         +w/A==
X-Forwarded-Encrypted: i=1; AJvYcCWL6UIAXsKCqu7vCnYGODWXCUZXp3Dw+ekYwelD4wfrB9Tiw7R3FScFJ2EE1bLgR4TIdmS+nTAnbi0E@vger.kernel.org, AJvYcCWVTR8KUupL72metdZxQ1p1d3+EbZXb2AdLxaPJMQQDFBcCmOewBBuc91l4W1cm+9YDDVQA4FWMvAPktmv4@vger.kernel.org
X-Gm-Message-State: AOJu0YwBPq/GDKcU/Gx8neiWSDAE24ekkC9nIJTaW1rW0v/JuVVMI6FA
	bGK0V6H+bvC+K8PmcmrDj9YbIiFVUS0tNpBNJZzU2tNxse/c9urA304DkCPn
X-Google-Smtp-Source: AGHT+IEjI2sgA8ywNtDkFWIWUD1HRdFElMz9OGiERJ1wWXLb7hgIJDdlpCuCcciYLAV0tXU6MiZ3+Q==
X-Received: by 2002:a17:906:6a24:b0:a8a:9207:c4c1 with SMTP id a640c23a62f3a-a90d5167dafmr1045761266b.58.1727043489967;
        Sun, 22 Sep 2024 15:18:09 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90611164d0sm1126202066b.91.2024.09.22.15.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 15:18:09 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 23 Sep 2024 00:17:58 +0200
Subject: [PATCH v2 10/10] iio: light: veml6030: add support for veml6035
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240923-veml6035-v2-10-58c72a0df31c@gmail.com>
References: <20240923-veml6035-v2-0-58c72a0df31c@gmail.com>
In-Reply-To: <20240923-veml6035-v2-0-58c72a0df31c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727043474; l=15350;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=+q0HZm1fKYjGmC3vzyj1zQ35NDKLymKJHg/syO6dFQQ=;
 b=pgYmNgExgYwJQGEi4oB3jaDUom+I4WeBMv8s22pwN7/cVg1cet8HES9enfRgd1OxLfLXB6n1Q
 YuOWWytmKTnD8FCvIPOwo3b/qtElQOnlHVITQr5Mmi2BOke46YZk19I
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The veml6035 is an ALS that shares most of its functionality with the
veml6030, which allows for some code recycling.

Some chip-specific properties differ and dedicated functions to get and
set the sensor gain as well as its initialization are required.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/Kconfig    |   4 +-
 drivers/iio/light/veml6030.c | 291 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 266 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 515ff46b5b82..171ccaecf5b6 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -669,12 +669,12 @@ config VCNL4035
 	  module will be called vcnl4035.
 
 config VEML6030
-	tristate "VEML6030 ambient light sensor"
+	tristate "VEML6030 and VEML6035 ambient light sensors"
 	select REGMAP_I2C
 	depends on I2C
 	help
 	  Say Y here if you want to build a driver for the Vishay VEML6030
-	  ambient light sensor (ALS).
+	  and VEML6035 ambient light sensors (ALS).
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called veml6030.
diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 19c69bfad8cb..d5c09c148d22 100644
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
@@ -39,16 +45,34 @@
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
+	const int(*scale_vals)[][2];
+	const int num_scale_vals;
+	const struct iio_info *info;
+	const struct iio_info *info_no_irq;
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
@@ -56,6 +80,7 @@ struct veml6030_data {
 	int cur_resolution;
 	int cur_gain;
 	int cur_integration_time;
+	const struct veml603x_chip *chip;
 };
 
 static const int veml6030_it_times[][2] = {
@@ -69,7 +94,8 @@ static const int veml6030_it_times[][2] = {
 
 /*
  * Scale is 1/gain. Value 0.125 is ALS gain x (1/8), 0.25 is
- * ALS gain x (1/4), 1.0 = ALS gain x 1 and 2.0 is ALS gain x 2.
+ * ALS gain x (1/4), 0.5 is ALS gain x (1/2), 1.0 is ALS gain x 1,
+ * 2.0 is ALS gain x2, and 4.0 is ALS gain x 4.
  */
 static const int veml6030_scale_vals[][2] = {
 	{0, 125000},
@@ -78,6 +104,15 @@ static const int veml6030_scale_vals[][2] = {
 	{2, 0},
 };
 
+static const int veml6035_scale_vals[][2] = {
+	{0, 125000},
+	{0, 250000},
+	{0, 500000},
+	{1, 0},
+	{2, 0},
+	{4, 0},
+};
+
 /*
  * Persistence = 1/2/4/8 x integration time
  * Minimum time for which light readings must stay above configured
@@ -386,6 +421,21 @@ static int veml6030_write_persistence(struct iio_dev *indio_dev,
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
@@ -416,19 +466,49 @@ static int veml6030_set_als_gain(struct iio_dev *indio_dev,
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
@@ -468,6 +548,52 @@ static int veml6030_get_als_gain(struct iio_dev *indio_dev,
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
@@ -559,7 +685,7 @@ static int veml6030_read_raw(struct iio_dev *indio_dev,
 		return -EINVAL;
 	case IIO_CHAN_INFO_SCALE:
 		if (chan->type == IIO_LIGHT)
-			return veml6030_get_als_gain(indio_dev, val, val2);
+			return data->chip->get_als_gain(indio_dev, val, val2);
 		return -EINVAL;
 	default:
 		return -EINVAL;
@@ -571,6 +697,8 @@ static int veml6030_read_avail(struct iio_dev *indio_dev,
 			       const int **vals, int *type, int *length,
 			       long mask)
 {
+	struct veml6030_data *data = iio_priv(indio_dev);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_INT_TIME:
 		*vals = (int *)&veml6030_it_times;
@@ -578,8 +706,8 @@ static int veml6030_read_avail(struct iio_dev *indio_dev,
 		*type = IIO_VAL_INT_PLUS_MICRO;
 		return IIO_AVAIL_LIST;
 	case IIO_CHAN_INFO_SCALE:
-		*vals = (int *)&veml6030_scale_vals;
-		*length = 2 * ARRAY_SIZE(veml6030_scale_vals);
+		*vals = (int *)*data->chip->scale_vals;
+		*length = 2 * data->chip->num_scale_vals;
 		*type = IIO_VAL_INT_PLUS_MICRO;
 		return IIO_AVAIL_LIST;
 	default:
@@ -591,6 +719,8 @@ static int veml6030_write_raw(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan,
 				int val, int val2, long mask)
 {
+	struct veml6030_data *data = iio_priv(indio_dev);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_INT_TIME:
 		switch (chan->type) {
@@ -602,7 +732,7 @@ static int veml6030_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_LIGHT:
-			return veml6030_set_als_gain(indio_dev, val, val2);
+			return data->chip->set_als_gain(indio_dev, val, val2);
 		default:
 			return -EINVAL;
 		}
@@ -713,12 +843,28 @@ static const struct iio_info veml6030_info = {
 	.event_attrs = &veml6030_event_attr_group,
 };
 
+static const struct iio_info veml6035_info = {
+	.read_raw  = veml6030_read_raw,
+	.read_avail  = veml6030_read_avail,
+	.write_raw = veml6030_write_raw,
+	.read_event_value = veml6030_read_event_val,
+	.write_event_value = veml6030_write_event_val,
+	.read_event_config = veml6030_read_interrupt_config,
+	.write_event_config = veml6030_write_interrupt_config,
+	.event_attrs = &veml6030_event_attr_group,
+};
+
 static const struct iio_info veml6030_info_no_irq = {
 	.read_raw  = veml6030_read_raw,
 	.read_avail  = veml6030_read_avail,
 	.write_raw = veml6030_write_raw,
 };
 
+static const struct iio_info veml6035_info_no_irq = {
+	.read_raw  = veml6030_read_raw,
+	.write_raw = veml6030_write_raw,
+};
+
 static irqreturn_t veml6030_event_handler(int irq, void *private)
 {
 	int ret, reg, evtdir;
@@ -803,6 +949,63 @@ static int veml6030_hw_init(struct iio_dev *indio_dev)
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
+	if (ret)
+		return dev_err_probe(&client->dev, ret, "can't shutdown als\n");
+
+	ret = regmap_write(data->regmap, VEML6030_REG_ALS_CONF,
+			   VEML6035_SENS | VEML6035_CHAN_EN | VEML6030_ALS_SD);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "can't setup als configs\n");
+
+	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_PSM,
+				 VEML6030_PSM | VEML6030_PSM_EN, 0x03);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "can't setup default PSM\n");
+
+	ret = regmap_write(data->regmap, VEML6030_REG_ALS_WH, 0xFFFF);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "can't setup high threshold\n");
+
+	ret = regmap_write(data->regmap, VEML6030_REG_ALS_WL, 0x0000);
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "can't setup low threshold\n");
+
+	ret = veml6030_als_pwr_on(data);
+	if (ret)
+		return dev_err_probe(&client->dev, ret, "can't poweron als\n");
+
+	/* Clear stale interrupt status bits if any during start */
+	ret = regmap_read(data->regmap, VEML6030_REG_ALS_INT, &val);
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret,
+				     "can't clear als interrupt status\n");
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
@@ -833,7 +1036,11 @@ static int veml6030_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, ret,
 				     "failed to enable regulator\n");
 
-	indio_dev->name = "veml6030";
+	data->chip = i2c_get_match_data(client);
+	if (!data->chip)
+		return -EINVAL;
+
+	indio_dev->name = data->chip->name;
 	indio_dev->channels = veml6030_channels;
 	indio_dev->num_channels = ARRAY_SIZE(veml6030_channels);
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -842,15 +1049,15 @@ static int veml6030_probe(struct i2c_client *client)
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						NULL, veml6030_event_handler,
 						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-						"veml6030", indio_dev);
+						indio_dev->name, indio_dev);
 		if (ret < 0)
 			return dev_err_probe(&client->dev, ret,
 					     "irq %d request failed\n",
 					     client->irq);
 
-		indio_dev->info = &veml6030_info;
+		indio_dev->info = data->chip->info;
 	} else {
-		indio_dev->info = &veml6030_info_no_irq;
+		indio_dev->info = data->chip->info_no_irq;
 	}
 
 	ret = devm_add_action_or_reset(&client->dev,
@@ -858,7 +1065,7 @@ static int veml6030_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	ret = veml6030_hw_init(indio_dev);
+	ret = data->chip->hw_init(indio_dev);
 	if (ret < 0)
 		return ret;
 
@@ -894,14 +1101,44 @@ static int veml6030_runtime_resume(struct device *dev)
 static DEFINE_RUNTIME_DEV_PM_OPS(veml6030_pm_ops, veml6030_runtime_suspend,
 				 veml6030_runtime_resume, NULL);
 
+static const struct veml603x_chip veml6030_chip = {
+	.name = "veml6030",
+	.scale_vals = &veml6030_scale_vals,
+	.num_scale_vals = ARRAY_SIZE(veml6030_scale_vals),
+	.info = &veml6030_info,
+	.info_no_irq = &veml6030_info_no_irq,
+	.hw_init = veml6030_hw_init,
+	.set_als_gain = veml6030_set_als_gain,
+	.get_als_gain = veml6030_get_als_gain,
+};
+
+static const struct veml603x_chip veml6035_chip = {
+	.name = "veml6035",
+	.scale_vals = &veml6035_scale_vals,
+	.num_scale_vals = ARRAY_SIZE(veml6035_scale_vals),
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


