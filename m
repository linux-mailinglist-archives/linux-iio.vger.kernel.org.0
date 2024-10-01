Return-Path: <linux-iio+bounces-9984-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D5198C6CE
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 22:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ABDC1F24AD9
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 20:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34671CFEA0;
	Tue,  1 Oct 2024 20:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IF8EGUef"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8161CF7C6;
	Tue,  1 Oct 2024 20:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727814131; cv=none; b=lOxaymwNPuukGaE7l6m5PyIQ60Ngy6wDv52tk+U0Z+OqAvD7up/MbkrszgPN2cOXP4KuBVUfKpMO9S8fYt6Xz2YIwsglC6HgPUJtwgfah4IKIge89hTdFFRgtQBekSwtTg3K3hEGZ8OUalSU032RMMdfAPVM3M8pDE5lIHnx1GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727814131; c=relaxed/simple;
	bh=/pwrzZflSvG9k5ba+Bzsv9QpL6npAQhZwanNFnxWnqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YWEqdvdSIqqxd0kw51BR3HlU8D9z8pQtYvgKq7rf5Z3bFNFRunxY4DElG/IOOKOgLkBmd0d2Jza8h3C7Kn1GVY7CjFcVsYg2VdkQr+wLnqPpWHydbfZxTIpRxcS/ODtX/cIjby/U2xgHSRVd3P9D5JPDAj9WkdpNzQtCBmF3szw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IF8EGUef; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cde6b5094so52595345e9.3;
        Tue, 01 Oct 2024 13:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727814125; x=1728418925; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+abLVP0EMhDabZt2X4T0m3nFOg9Swuuy4a8ah850zU=;
        b=IF8EGUefritWMObRwIfNzxzjYMjlizRBk910iLmWkKaDLU1ruxCemhSyp6Bz3dHMpf
         zIf2jWagl/a4+o6Bh7nL+7LLVUehgkeRIbwcSn77Qas/+xJXJOMVFn17AIuyXfkv6+L9
         hkHvqE0H1W8eZ+c+HnSPkXkRheqxnRcEdW7y+CP1NqPhsufwfjRocI4ECH7UKnBt1ajd
         q99cXNby6WU4O0W+HSx+4EMM4ZQDuh++c1kKWQKf9DSiOdhPZX9x211NQGd5exGncKEa
         Vr96VA3J5R1aVBeAUYsdGq+WRcEe3zthNZShk3LGy9xAVJ3/tP9q9+zg/yHZbCePNEux
         2alw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727814125; x=1728418925;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+abLVP0EMhDabZt2X4T0m3nFOg9Swuuy4a8ah850zU=;
        b=A/aQ1sd+jxA7zYFdG1bV/s5fzq/FKehgzaw8JX3lmFqKcTVMqYYa8YYyeCrOJ9YAgp
         PTfbREDOmO6B/zvbR0X4cvJOSy0+ecYvvp1XgqQ5+YKaSmcrBfnVNtuStwNkPQIz8zmg
         CfSa7Ccxx0xAbiw85sxKAysg0Pd59+5D/PVotsctz24t/8lgWpqI0SseomTsCz7PxGuQ
         +AlIl5w69X7jwz7EsrREVUTI3Za5o73tuUzG/Z4zgX5XB7prLAvOPcESUzoyNQKmxnhB
         OgtgebPsVAS6v7BRr2N8WrY8UinjszJsTz70lYcyMCwMal+1Q6OJE2xaTBe6LUXxw+lt
         Uhdw==
X-Forwarded-Encrypted: i=1; AJvYcCUKyJcgiNEsFfVeJj3gIxaIc5SH7tBH811b4JtZV0zXJ/z30jpvNhvvqJPjuzZzS7OuISrvRSiVUt6x@vger.kernel.org, AJvYcCV9nCNbNbxOIkP24V8Q1fpjiDuDHVtqSx/3dyJRzewTikDf7UXCFdJpH2V6sRMICCHyHtypCV4gnPbFkPoB@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd0ADArjwBbHMT7nQkYOMjhPe+m0sbiZGKqJZo/nXpj5EACyLR
	pCT9LbmsBSpqlqR1CDNKB9PMZ5T/3mBiaRLP68e8lh1a7FjCFB9ltODPBNJV
X-Google-Smtp-Source: AGHT+IHDAMkxcIw0lUd2GyKKv8cr5e8++DND6GHUeK9fCpWgJHbSKG3TLAsAdc9HcSJxuIh0ybySCg==
X-Received: by 2002:a05:600c:3c9f:b0:42c:aeaa:6aff with SMTP id 5b1f17b1804b1-42f777c0705mr5229005e9.10.1727814125118;
        Tue, 01 Oct 2024 13:22:05 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-41f4-a392-01d5-d74d.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:41f4:a392:1d5:d74d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a55336sm188680935e9.47.2024.10.01.13.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:22:04 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 01 Oct 2024 22:21:22 +0200
Subject: [PATCH v3 9/9] iio: light: veml6030: add support for veml6035
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-veml6035-v3-9-d789f6ff147c@gmail.com>
References: <20241001-veml6035-v3-0-d789f6ff147c@gmail.com>
In-Reply-To: <20241001-veml6035-v3-0-d789f6ff147c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727814089; l=15172;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=/pwrzZflSvG9k5ba+Bzsv9QpL6npAQhZwanNFnxWnqg=;
 b=Mn8v52sYUhDva6h44BV77ZgFtcZOxdzDhvC0B2/1vVDn1FvSqvy2nDiWmmnNmTMr0drvLmj0w
 5pn1QOeCE2cCakOUtnekpA9t/wYRX8OauDKT17cixQgTzEGQhVErcZD
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The veml6035 is an ALS that shares most of its functionality with the
veml6030, which allows for some code recycling.

Some chip-specific properties differ and dedicated functions to get and
set the sensor gain as well as its initialization are required.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/Kconfig    |   4 +-
 drivers/iio/light/veml6030.c | 290 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 265 insertions(+), 29 deletions(-)

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
index 0e4c36e8a566..a5deae333554 100644
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
+	int (*hw_init)(struct iio_dev *indio_dev, struct device *dev);
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
 	{ 0, 125000 },
@@ -78,6 +104,15 @@ static const int veml6030_scale_vals[][2] = {
 	{ 2, 0 },
 };
 
+static const int veml6035_scale_vals[][2] = {
+	{ 0, 125000 },
+	{ 0, 250000 },
+	{ 0, 500000 },
+	{ 1, 0 },
+	{ 2, 0 },
+	{ 4, 0 },
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
@@ -556,7 +682,7 @@ static int veml6030_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_INT_TIME:
 		return veml6030_get_intgrn_tm(indio_dev, val, val2);
 	case IIO_CHAN_INFO_SCALE:
-		return veml6030_get_als_gain(indio_dev, val, val2);
+		return data->chip->get_als_gain(indio_dev, val, val2);
 	default:
 		return -EINVAL;
 	}
@@ -567,6 +693,8 @@ static int veml6030_read_avail(struct iio_dev *indio_dev,
 			       const int **vals, int *type, int *length,
 			       long mask)
 {
+	struct veml6030_data *data = iio_priv(indio_dev);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_INT_TIME:
 		*vals = (int *)&veml6030_it_times;
@@ -574,8 +702,8 @@ static int veml6030_read_avail(struct iio_dev *indio_dev,
 		*type = IIO_VAL_INT_PLUS_MICRO;
 		return IIO_AVAIL_LIST;
 	case IIO_CHAN_INFO_SCALE:
-		*vals = (int *)&veml6030_scale_vals;
-		*length = 2 * ARRAY_SIZE(veml6030_scale_vals);
+		*vals = (int *)*data->chip->scale_vals;
+		*length = 2 * data->chip->num_scale_vals;
 		*type = IIO_VAL_INT_PLUS_MICRO;
 		return IIO_AVAIL_LIST;
 	}
@@ -587,11 +715,13 @@ static int veml6030_write_raw(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan,
 				int val, int val2, long mask)
 {
+	struct veml6030_data *data = iio_priv(indio_dev);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_INT_TIME:
 		return veml6030_set_intgrn_tm(indio_dev, val, val2);
 	case IIO_CHAN_INFO_SCALE:
-		return veml6030_set_als_gain(indio_dev, val, val2);
+		return data->chip->set_als_gain(indio_dev, val, val2);
 	default:
 		return -EINVAL;
 	}
@@ -699,12 +829,28 @@ static const struct iio_info veml6030_info = {
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
@@ -788,6 +934,62 @@ static int veml6030_hw_init(struct iio_dev *indio_dev, struct device *dev)
 	return ret;
 }
 
+/*
+ * Set ALS gain to 1/8, integration time to 100 ms, ALS and WHITE
+ * channel enabled, ALS channel interrupt, PSM enabled,
+ * PSM_WAIT = 0.8 s, persistence to 1 x integration time and the
+ * threshold interrupt disabled by default. First shutdown the sensor,
+ * update registers and then power on the sensor.
+ */
+static int veml6035_hw_init(struct iio_dev *indio_dev, struct device *dev)
+{
+	int ret, val;
+	struct veml6030_data *data = iio_priv(indio_dev);
+
+	ret = veml6030_als_shut_down(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "can't shutdown als\n");
+
+	ret = regmap_write(data->regmap, VEML6030_REG_ALS_CONF,
+			   VEML6035_SENS | VEML6035_CHAN_EN | VEML6030_ALS_SD);
+	if (ret)
+		return dev_err_probe(dev, ret, "can't setup als configs\n");
+
+	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_PSM,
+				 VEML6030_PSM | VEML6030_PSM_EN, 0x03);
+	if (ret)
+		return dev_err_probe(dev, ret, "can't setup default PSM\n");
+
+	ret = regmap_write(data->regmap, VEML6030_REG_ALS_WH, 0xFFFF);
+	if (ret)
+		return dev_err_probe(dev, ret, "can't setup high threshold\n");
+
+	ret = regmap_write(data->regmap, VEML6030_REG_ALS_WL, 0x0000);
+	if (ret)
+		return dev_err_probe(dev, ret, "can't setup low threshold\n");
+
+	ret = veml6030_als_pwr_on(data);
+	if (ret)
+		return dev_err_probe(dev, ret, "can't poweron als\n");
+
+	ret = devm_add_action_or_reset(dev, veml6030_als_shut_down_action, data);
+	if (ret < 0)
+		return ret;
+
+	/* Clear stale interrupt status bits if any during start */
+	ret = regmap_read(data->regmap, VEML6030_REG_ALS_INT, &val);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
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
@@ -818,7 +1020,11 @@ static int veml6030_probe(struct i2c_client *client)
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
@@ -827,18 +1033,18 @@ static int veml6030_probe(struct i2c_client *client)
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
 
-	ret = veml6030_hw_init(indio_dev, &client->dev);
+	ret = data->chip->hw_init(indio_dev, &client->dev);
 	if (ret < 0)
 		return ret;
 
@@ -874,14 +1080,44 @@ static int veml6030_runtime_resume(struct device *dev)
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


