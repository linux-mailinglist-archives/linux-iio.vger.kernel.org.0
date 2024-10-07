Return-Path: <linux-iio+bounces-10312-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F3A993861
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 22:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81972852C4
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 20:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A771DED70;
	Mon,  7 Oct 2024 20:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gV/yCC2M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C0E1DE4F6;
	Mon,  7 Oct 2024 20:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728333427; cv=none; b=OUckjvTtpDlT9ER0hIy6xZCV4WodBleLNgsntbuSCpNIOso6ojQWBa7wJiVTl6zM4RgdPLyIlGxuQZJn0WonHUUQuHh4SHouhdR/vet16fbFCDGRk33svwFsxzEXULKR9IG2XfRdx+5m7ZDVrVqUfHHqIx4JpyQGWsrbqcibHX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728333427; c=relaxed/simple;
	bh=ffBqKTIzKKORtDAQTnF0ixHeiBBU1WJxjkoh95cX3hQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SxPMXYP+UTIecb+0S5VdWzYtnCP+JNzk21OLDMLWc2cqvqx4CTk1uaG80a4C8qjscFs8X2wy8GljKAsHw07dRnPgD8Z20B3LlKWUAYQc1sEQ8HksKAGtbnaKymttGIOHJ78quL5rR2746Jcb1V9M+KFEwOUa/fMhi1EgYq6+xgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gV/yCC2M; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37cd8a5aac9so2619369f8f.2;
        Mon, 07 Oct 2024 13:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728333424; x=1728938224; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R0B/ACvOpGHW6u8EpRZ7oeA/qI9QuVr63Qwli6fHJpg=;
        b=gV/yCC2MdfGYzqT2FnYyouQJlzI+VmF1ZaPqG5AmiQLqZyUXgt9cBcpGv4lO4dh3yw
         546VUDdhLs7UsBNEfxioQioiHjydhF91rmjJBRiH8NWxm5ZaG7uDLzEuh2BCgoBzNpBn
         iHh0NS2dcUFgvA7CpwOAnEy9dcRFX96HDgzxcDSyL7xUWPpV/MtAdhEI2hsif03pMMug
         3eQywi5C0BBla8GvPO5lykiosVVn/0XJPgivi2NmzoHpZVbW2gw7oQ6LwCJFNTbOiJmY
         dk/RKpvNhYdeil18hB36jbTzLV5ggQFbiewFrdWacFORe3muAbo7sO6gWelSvnlUf0NC
         PIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728333424; x=1728938224;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0B/ACvOpGHW6u8EpRZ7oeA/qI9QuVr63Qwli6fHJpg=;
        b=wW4wijwwiCSJ58W7fndxPJ2+EtIHWt5e7Rk3RWG8+VPZN058FOAmCy1qNU3UKNoy+Z
         N5U39vxTph+V3ges99F2CNIS3B8t534/N/7bOG2Cdmgc1JylK53hxIP86dbZRRKXulYn
         5A/APCCIetR7uffG76s4VOmQ+fYXqrKGyZwmCP+q81YnHM7t5ughIwU5W5OjL8L/R9mr
         wh1Sgbyvy8m4cMI/U1vdgcdEMFZnBm9kngGc0oy4soXswXwLp95pAkzB2O5KTIuXO1H5
         UlraDCBUcowvCPLYZIx/UbC2dK9pRqgosdqspb1GVpNUh0QUPa5uI4oV/xdErEClg0g0
         +ItQ==
X-Forwarded-Encrypted: i=1; AJvYcCWN8Rd9LSxzcec3a90Xp27FXq4wdVNfhh0lTiE/19IU4H72M0wpt8lPblae/qMEkOJjw7yvO5uGiUyx@vger.kernel.org, AJvYcCWfnw4Rp9OmLx0mc2hoERqCL5IHgKO5Zqk95EBLCkBhXDRAGJF16c//wO1UGigHUPHhhya6ScedxX/o@vger.kernel.org, AJvYcCWsQhICjFUlaxqAp4GaPpMeIdSQRBmFE1J5WnVZTxUtmivM42u0ICohCMRUhpYzJJ9n+my8RqjCZmjicabn@vger.kernel.org
X-Gm-Message-State: AOJu0YycOwV8WWTbg5vqyutxiN5nN8TbdMQY+c07ye+WEc8qERwSuihc
	GgE6/1UrqBJfpceLn6G5PC6gO5vV82UTPlqwHDokWCXj9Wu+F/C5
X-Google-Smtp-Source: AGHT+IElWGF/J3lYVMjLRCX4hUFrco/Kpvzbw/A8jguDUfW3hbZhHKJxw50QPrU3kkSMpcxaaADIdw==
X-Received: by 2002:adf:e502:0:b0:37c:d2d2:7f67 with SMTP id ffacd0b85a97d-37d0e74b62cmr6056692f8f.30.1728333418972;
        Mon, 07 Oct 2024 13:36:58 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-26cc-001d-7ed0-e346.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:26cc:1d:7ed0:e346])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1690f75bsm6464315f8f.23.2024.10.07.13.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 13:36:58 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 07 Oct 2024 22:36:38 +0200
Subject: [PATCH 3/3] iio: light: veml6030: add support for veml7700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241007-veml7700-v1-3-fb85dd839d63@gmail.com>
References: <20241007-veml7700-v1-0-fb85dd839d63@gmail.com>
In-Reply-To: <20241007-veml7700-v1-0-fb85dd839d63@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728333411; l=6748;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=ffBqKTIzKKORtDAQTnF0ixHeiBBU1WJxjkoh95cX3hQ=;
 b=Ichfa+n/zTkvi8u7AEtV619VW+zwZUglXdVjgVqUfx5q0Uyv8ESG4JbNPlSN+AW+ibjzpWokV
 6COuh21LbkRDjH80iDjXhNx4NsBeedR1hVBKoGpWTBdGpxN+viyZJlH
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The veml7700 contains the same sensor as the veml6030 in a different
package with no interrupt line and no pin to select the I2C address.

To handle the lack of the interrupt line and profit from the existing
support for the veml6030, add a specific iio_chan_spec with no
(num_)event_spec(s), and register the device's info from the
veml6030_info_no_irq struct.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6030.c | 108 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 91 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index ca0379945b1c..173c85a05a8d 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * VEML6030 and VMEL6035 Ambient Light Sensors
+ * VEML6030, VMEL6035 and VEML7700 Ambient Light Sensors
  *
  * Copyright (c) 2019, Rishi Gupta <gupt21@gmail.com>
  *
@@ -11,6 +11,10 @@
  * VEML6035:
  * Datasheet: https://www.vishay.com/docs/84889/veml6035.pdf
  * Appnote-84944: https://www.vishay.com/docs/84944/designingveml6035.pdf
+ *
+ * VEML7700:
+ * Datasheet: https://www.vishay.com/docs/84286/veml7700.pdf
+ * Appnote-84323: https://www.vishay.com/docs/84323/designingveml7700.pdf
  */
 
 #include <linux/bitfield.h>
@@ -56,7 +60,10 @@ struct veml603x_chip {
 	const char *name;
 	const int(*scale_vals)[][2];
 	const int num_scale_vals;
+	const struct iio_chan_spec *channels;
+	const int num_channels;
 	int (*hw_init)(struct iio_dev *indio_dev, struct device *dev);
+	int (*set_info)(struct iio_dev *indio_dev);
 	int (*set_als_gain)(struct iio_dev *indio_dev, int val, int val2);
 	int (*get_als_gain)(struct iio_dev *indio_dev, int *val, int *val2);
 };
@@ -250,6 +257,30 @@ static const struct iio_chan_spec veml6030_channels[] = {
 	},
 };
 
+static const struct iio_chan_spec veml7700_channels[] = {
+	{
+		.type = IIO_LIGHT,
+		.channel = CH_ALS,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_PROCESSED) |
+				BIT(IIO_CHAN_INFO_INT_TIME) |
+				BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+						     BIT(IIO_CHAN_INFO_SCALE),
+	},
+	{
+		.type = IIO_INTENSITY,
+		.channel = CH_WHITE,
+		.modified = 1,
+		.channel2 = IIO_MOD_LIGHT_BOTH,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				BIT(IIO_CHAN_INFO_INT_TIME) |
+				BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
+						     BIT(IIO_CHAN_INFO_SCALE),
+	},
+};
+
 static const struct regmap_config veml6030_regmap_config = {
 	.name = "veml6030_regmap",
 	.reg_bits = 8,
@@ -862,6 +893,37 @@ static irqreturn_t veml6030_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+static int veml6030_set_info(struct iio_dev *indio_dev)
+{
+	struct veml6030_data *data = iio_priv(indio_dev);
+	struct i2c_client *client = data->client;
+	int ret;
+
+	if (client->irq) {
+		ret = devm_request_threaded_irq(&client->dev, client->irq,
+						NULL, veml6030_event_handler,
+						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+						indio_dev->name, indio_dev);
+		if (ret < 0)
+			return dev_err_probe(&client->dev, ret,
+					     "irq %d request failed\n",
+					     client->irq);
+
+		indio_dev->info = &veml6030_info;
+	} else {
+		indio_dev->info = &veml6030_info_no_irq;
+	}
+
+	return 0;
+}
+
+static int veml7700_set_info(struct iio_dev *indio_dev)
+{
+	indio_dev->info = &veml6030_info_no_irq;
+
+	return 0;
+}
+
 /*
  * Set ALS gain to 1/8, integration time to 100 ms, PSM to mode 2,
  * persistence to 1 x integration time and the threshold
@@ -1007,24 +1069,13 @@ static int veml6030_probe(struct i2c_client *client)
 		return -EINVAL;
 
 	indio_dev->name = data->chip->name;
-	indio_dev->channels = veml6030_channels;
-	indio_dev->num_channels = ARRAY_SIZE(veml6030_channels);
+	indio_dev->channels = data->chip->channels;
+	indio_dev->num_channels = data->chip->num_channels;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	if (client->irq) {
-		ret = devm_request_threaded_irq(&client->dev, client->irq,
-						NULL, veml6030_event_handler,
-						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-						indio_dev->name, indio_dev);
-		if (ret < 0)
-			return dev_err_probe(&client->dev, ret,
-					     "irq %d request failed\n",
-					     client->irq);
-
-		indio_dev->info = &veml6030_info;
-	} else {
-		indio_dev->info = &veml6030_info_no_irq;
-	}
+	ret = data->chip->set_info(indio_dev);
+	if (ret < 0)
+		return ret;
 
 	ret = data->chip->hw_init(indio_dev, &client->dev);
 	if (ret < 0)
@@ -1066,7 +1117,10 @@ static const struct veml603x_chip veml6030_chip = {
 	.name = "veml6030",
 	.scale_vals = &veml6030_scale_vals,
 	.num_scale_vals = ARRAY_SIZE(veml6030_scale_vals),
+	.channels = veml6030_channels,
+	.num_channels = ARRAY_SIZE(veml6030_channels),
 	.hw_init = veml6030_hw_init,
+	.set_info = veml6030_set_info,
 	.set_als_gain = veml6030_set_als_gain,
 	.get_als_gain = veml6030_get_als_gain,
 };
@@ -1075,11 +1129,26 @@ static const struct veml603x_chip veml6035_chip = {
 	.name = "veml6035",
 	.scale_vals = &veml6035_scale_vals,
 	.num_scale_vals = ARRAY_SIZE(veml6035_scale_vals),
+	.channels = veml6030_channels,
+	.num_channels = ARRAY_SIZE(veml6030_channels),
 	.hw_init = veml6035_hw_init,
+	.set_info = veml6030_set_info,
 	.set_als_gain = veml6035_set_als_gain,
 	.get_als_gain = veml6035_get_als_gain,
 };
 
+static const struct veml603x_chip veml7700_chip = {
+	.name = "veml7700",
+	.scale_vals = &veml6030_scale_vals,
+	.num_scale_vals = ARRAY_SIZE(veml6030_scale_vals),
+	.channels = veml7700_channels,
+	.num_channels = ARRAY_SIZE(veml7700_channels),
+	.hw_init = veml6030_hw_init,
+	.set_info = veml7700_set_info,
+	.set_als_gain = veml6030_set_als_gain,
+	.get_als_gain = veml6030_get_als_gain,
+};
+
 static const struct of_device_id veml6030_of_match[] = {
 	{
 		.compatible = "vishay,veml6030",
@@ -1089,6 +1158,10 @@ static const struct of_device_id veml6030_of_match[] = {
 		.compatible = "vishay,veml6035",
 		.data = &veml6035_chip,
 	},
+	{
+		.compatible = "vishay,veml7700",
+		.data = &veml7700_chip,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, veml6030_of_match);
@@ -1096,6 +1169,7 @@ MODULE_DEVICE_TABLE(of, veml6030_of_match);
 static const struct i2c_device_id veml6030_id[] = {
 	{ "veml6030", (kernel_ulong_t)&veml6030_chip},
 	{ "veml6035", (kernel_ulong_t)&veml6035_chip},
+	{ "veml7700", (kernel_ulong_t)&veml7700_chip},
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, veml6030_id);

-- 
2.43.0


