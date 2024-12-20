Return-Path: <linux-iio+bounces-13732-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 168149F9A80
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2024 20:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65FA9162FCB
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2024 19:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1183F22579A;
	Fri, 20 Dec 2024 19:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YoxVaRMb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6390E2210F6;
	Fri, 20 Dec 2024 19:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734722929; cv=none; b=O2/bnDU4j2SQENlJFLp9N0H1IZjMYB7qTFsUdqAUrkNAgXEgx7wfDMjXenTniIqKTsywyRhyEgtNkWJ3yqwjcVnRxIxBTfhZDP+iJwmCYlzmRuRaPbO9trh8TBZtirEYL/XmeTorau3BtMj5tsIkux3cAPxyzenXXNVvASxjxYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734722929; c=relaxed/simple;
	bh=8MAY/2gad3nXRIsui94Uq3r2tW4yrZPfdpOkMSUEI5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pgWTRrU87bsgktUHI9S2fjw5XBIch6qz6EOWUv04EFBVaiS9o4RqBSBS3c0y6D0+zFiIH4eky2B7lUk6MtKPQ/yfdPosH6x5IYeBRBLCldyBu+MPk0nyKkIp4uOvE/6k0dGqjM57hgPihVkayBrLaY48TIy2hyALsfFBuerQgUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YoxVaRMb; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385de9f789cso1757577f8f.2;
        Fri, 20 Dec 2024 11:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734722924; x=1735327724; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lFB+FGfn84ZOhhOOlKEEM+ivMJsE7vQ6c4qPzh5sbwo=;
        b=YoxVaRMbyP5zUXyu1e1x749NVxqsuS5G5ewHHe4EZdMtQGFiOi0GxOv1sx9ra/amsB
         TT7p3cJ5QEJHmrnQexozGb2nYp693r+h9j6zVBrVVJmdnWrE4khWPZ2/gDMOJUOdEaR8
         5v3YlKisnKSwFXiK8bqzceydxNLJH/Q5P5AIBJ8nSi0O2LZLFlKTUW+R+oVKXjQpYBxB
         wZnF/a1e075AdT+9hDaI49BH6FPQIK1UoaAD/E+xx8Cwt9iDb44MLDqpUMw9CQ70rZt4
         BPrfqsCakzabMLNZi0q+aHY7J1bPdCN6DPSlSDS0YiqQ9vl0rj9hgVpMzDsWCxEdep6m
         odAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734722924; x=1735327724;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFB+FGfn84ZOhhOOlKEEM+ivMJsE7vQ6c4qPzh5sbwo=;
        b=skIKl2Bb2MnHR+Lz80E+Lck5EZSOXH5aTPovFN0xN22pdHp00rl4lsgFzTp7eU/tBM
         SqsTWMMEvi5pq7PtORvKDxSTYLG2eTp/uLQSGksLY7TEclv7RB4JPv67Cu1krW07aMbt
         7B+N/XfyoIuU2wLCSLJkNxr/rd9TFddUYcpx2K30QeCWET4ygf7TUoqPS6DMm5gp3PMB
         YvWevRmtSGuE8COuXoemCEI7bznnzJQhz4uJZbPPECASUOf/Di5Bra7MU3EejiOVtu2J
         z6Jd/wFwAVmoZLODabHHz6IoWlwjVA9DsSA3Kq8CvkqPMFcWcfLnA4vGMXOtRDlHUhPv
         9jMA==
X-Forwarded-Encrypted: i=1; AJvYcCVeMIFqwW6maDirBABvd8IoR4sZSrY6YO5WEx3MRsp37j7EaXYLDhxYyUflwgAzqiOkbnCFI2cFHReKN4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqWjB/rgrn0DLooZBYQz/cO5N53Uxr48CxteVPH6l13fGJsWdw
	s/fsimsEZkkYTM/tOw9WK0atxejBXM8rl4wfvC5AxWgMn8myt1dR
X-Gm-Gg: ASbGncsfJGG2EYKNZM4GJgESdzkNn2eCRbVYpMAerjuVt+u0JAh0XfZpU+X4G+2Uafp
	lt9gWtuAWb2Ue6RnlZyUlZxfnKXhSXtjd1Qn2oPIBEnHJu4Ytw63Ga7tM6T/6RsdsGoqHjQ2R8j
	/lTzvoFwHLbc2sZN4WXbBnF4fzw8oRAEipEyWQ3AWS5TxZTznKnz1dndF3Ck45WPULuniubGo1L
	wJDsVfKo6XyLICHYRYlyawBJCY2eecs5X2d722HOV71369b0I1cQfr3Wx3QanMjwDceoOY6wx/i
	1tjpk1Z93xH9mP4Pnvh/X0FgfqkKMACuIFbidnCfBhCo+0YcHCyz1el+Ww3GvFyl0kttThficJz
	vtA4=
X-Google-Smtp-Source: AGHT+IFQ2Q3czWKQj+DjuYb0TIh/a/6hmoyrNCq3xajr00aC3sm1Q20OyDI8m7S4ggdUG1GKJVcS6g==
X-Received: by 2002:a05:6000:184e:b0:386:3082:ee2d with SMTP id ffacd0b85a97d-38a223ffb7dmr3108285f8f.41.1734722924232;
        Fri, 20 Dec 2024 11:28:44 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-e9bd-7e4a-34d9-3ba2.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:e9bd:7e4a:34d9:3ba2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c847dabsm4674274f8f.59.2024.12.20.11.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 11:28:43 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 20 Dec 2024 20:28:29 +0100
Subject: [PATCH 2/2] iio: veml3235: fix scale to conform to ABI
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-veml3235_scale-v1-2-b43b190bbb6a@gmail.com>
References: <20241220-veml3235_scale-v1-0-b43b190bbb6a@gmail.com>
In-Reply-To: <20241220-veml3235_scale-v1-0-b43b190bbb6a@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734722919; l=10923;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=8MAY/2gad3nXRIsui94Uq3r2tW4yrZPfdpOkMSUEI5A=;
 b=wges/W4toTyFAytiprbjk4rGQWiFW28sRE6qP1HxE8TNlDRwz0iGtqnrPIg9ndlcueQKBiUne
 g32UREKxCVoAM9KcxKtsPqvtPM57yv6bE+JHUKSn66s3184iWpwqRdM
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The current scale is not ABI-compliant as it is just the sensor gain
instead of the value that acts as a multiplier to be applied to the raw
value (there is no offset).

Use the iio-gts helpers to obtain the proper scale values according to
the gain and integration time to match the resolution tables from the
datasheet.

Fixes: c5a23f80c164 ("iio: light: add support for veml3235")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/Kconfig    |   1 +
 drivers/iio/light/veml3235.c | 252 ++++++++++++++++++++++++-------------------
 2 files changed, 140 insertions(+), 113 deletions(-)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 0cf9cf2a3f94..12864691a7ff 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -656,6 +656,7 @@ config VCNL4035
 config VEML3235
 	tristate "VEML3235 ambient light sensor"
 	select REGMAP_I2C
+	select IIO_GTS_HELPER
 	depends on I2C
 	help
 	  Say Y here if you want to build a driver for the Vishay VEML3235
diff --git a/drivers/iio/light/veml3235.c b/drivers/iio/light/veml3235.c
index 66361c3012a3..4ace3f8e95f1 100644
--- a/drivers/iio/light/veml3235.c
+++ b/drivers/iio/light/veml3235.c
@@ -11,6 +11,7 @@
 #include <linux/err.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/iio-gts-helper.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
@@ -35,17 +36,33 @@ struct veml3235_data {
 	struct device *dev;
 	struct regmap *regmap;
 	struct veml3235_rf rf;
+	struct iio_gts gts;
 };
 
-static const int veml3235_it_times[][2] = {
-	{ 0, 50000 },
-	{ 0, 100000 },
-	{ 0, 200000 },
-	{ 0, 400000 },
-	{ 0, 800000 },
+static const struct iio_itime_sel_mul veml3235_it_sel[] = {
+	GAIN_SCALE_ITIME_US(50000, 0, 1),
+	GAIN_SCALE_ITIME_US(100000, 1, 2),
+	GAIN_SCALE_ITIME_US(200000, 2, 4),
+	GAIN_SCALE_ITIME_US(400000, 3, 8),
+	GAIN_SCALE_ITIME_US(800000, 4, 16),
 };
 
-static const int veml3235_scale_vals[] = { 1, 2, 4, 8 };
+/*
+ * The MSB (DG) doubles the value of the rest of the field, which leads to
+ * two possible combinations to obtain gain = 2 and gain = 4. The gain
+ * handlding can be simplified by restricting DG = 1 to the only gain that
+ * really requires it, gain = 8. Note that "X10" is a reserved value.
+ */
+#define VEML3235_SEL_GAIN_X1 0
+#define VEML3235_SEL_GAIN_X2 1
+#define VEML3235_SEL_GAIN_X4 3
+#define VEML3235_SEL_GAIN_X8 7
+static const struct iio_gain_sel_pair veml3235_gain_sel[] = {
+	GAIN_SCALE_GAIN(1, VEML3235_SEL_GAIN_X1),
+	GAIN_SCALE_GAIN(2, VEML3235_SEL_GAIN_X2),
+	GAIN_SCALE_GAIN(4, VEML3235_SEL_GAIN_X4),
+	GAIN_SCALE_GAIN(8, VEML3235_SEL_GAIN_X8),
+};
 
 static int veml3235_power_on(struct veml3235_data *data)
 {
@@ -111,112 +128,99 @@ static const struct regmap_config veml3235_regmap_config = {
 
 static int veml3235_get_it(struct veml3235_data *data, int *val, int *val2)
 {
-	int ret, reg;
+	int ret, it_idx;
 
-	ret = regmap_field_read(data->rf.it, &reg);
+	ret = regmap_field_read(data->rf.it, &it_idx);
 	if (ret)
 		return ret;
 
-	switch (reg) {
-	case 0:
-		*val2 = 50000;
-		break;
-	case 1:
-		*val2 = 100000;
-		break;
-	case 2:
-		*val2 = 200000;
-		break;
-	case 3:
-		*val2 = 400000;
-		break;
-	case 4:
-		*val2 = 800000;
-		break;
-	default:
-		return -EINVAL;
-	}
+	ret = iio_gts_find_int_time_by_sel(&data->gts, it_idx);
+	if (ret < 0)
+		return ret;
 
+	*val2 = ret;
 	*val = 0;
 
 	return IIO_VAL_INT_PLUS_MICRO;
 }
 
-static int veml3235_set_it(struct iio_dev *indio_dev, int val, int val2)
+static int veml3235_set_it(struct iio_dev *indio_dev, int val2)
 {
 	struct veml3235_data *data = iio_priv(indio_dev);
-	int ret, new_it;
+	int ret, gain_idx, it_idx, new_gain, prev_gain, prev_it;
+	bool in_range;
 
-	if (val)
+	if (!iio_gts_valid_time(&data->gts, val2))
 		return -EINVAL;
 
-	switch (val2) {
-	case 50000:
-		new_it = 0x00;
-		break;
-	case 100000:
-		new_it = 0x01;
-		break;
-	case 200000:
-		new_it = 0x02;
-		break;
-	case 400000:
-		new_it = 0x03;
-		break;
-	case 800000:
-		new_it = 0x04;
-		break;
-	default:
-		return -EINVAL;
-	}
+	ret = regmap_field_read(data->rf.it, &it_idx);
+	if (ret)
+		return ret;
 
-	ret = regmap_field_write(data->rf.it, new_it);
-	if (ret) {
-		dev_err(data->dev,
-			"failed to update integration time: %d\n", ret);
+	ret = regmap_field_read(data->rf.gain, &gain_idx);
+	if (ret)
 		return ret;
-	}
 
-	return 0;
+	prev_it = iio_gts_find_int_time_by_sel(&data->gts, it_idx);
+	if (prev_it < 0)
+		return prev_it;
+
+	if (prev_it == val2)
+		return 0;
+
+	prev_gain = iio_gts_find_gain_by_sel(&data->gts, gain_idx);
+	if (prev_gain < 0)
+		return prev_gain;
+
+	ret = iio_gts_find_new_gain_by_gain_time_min(&data->gts, prev_gain, prev_it,
+						     val2, &new_gain, &in_range);
+	if (ret)
+		return ret;
+
+	if (!in_range)
+		dev_dbg(data->dev, "Optimal gain out of range\n");
+
+	ret = iio_gts_find_sel_by_int_time(&data->gts, val2);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_field_write(data->rf.it, ret);
+	if (ret)
+		return ret;
+
+	ret = iio_gts_find_sel_by_gain(&data->gts, new_gain);
+	if (ret < 0)
+		return ret;
+
+	return regmap_field_write(data->rf.gain, ret);
 }
 
-static int veml3235_set_gain(struct iio_dev *indio_dev, int val, int val2)
+static int veml3235_set_scale(struct iio_dev *indio_dev, int val, int val2)
 {
 	struct veml3235_data *data = iio_priv(indio_dev);
-	int ret, new_gain;
+	int ret, it_idx, gain_sel, time_sel;
 
-	if (val2 != 0)
-		return -EINVAL;
-
-	switch (val) {
-	case 1:
-		new_gain = 0x00;
-		break;
-	case 2:
-		new_gain = 0x01;
-		break;
-	case 4:
-		new_gain = 0x03;
-		break;
-	case 8:
-		new_gain = 0x07;
-		break;
-	default:
-		return -EINVAL;
-	}
+	ret = regmap_field_read(data->rf.it, &it_idx);
+	if (ret)
+		return ret;
 
-	ret = regmap_field_write(data->rf.gain, new_gain);
-	if (ret) {
-		dev_err(data->dev, "failed to set gain: %d\n", ret);
+	ret = iio_gts_find_gain_sel_in_times(&data->gts, val, val2, &gain_sel,
+					     &time_sel);
+	if (ret)
 		return ret;
+
+	if (it_idx != time_sel) {
+		ret = regmap_field_write(data->rf.it, time_sel);
+		if (ret)
+			return ret;
 	}
 
-	return 0;
+	return regmap_field_write(data->rf.gain, gain_sel);
 }
 
-static int veml3235_get_gain(struct veml3235_data *data, int *val)
+static int veml3235_get_scale(struct veml3235_data *data, int *val, int *val2)
 {
-	int ret, reg;
+	int gain, it, reg, ret;
 
 	ret = regmap_field_read(data->rf.gain, &reg);
 	if (ret) {
@@ -224,25 +228,25 @@ static int veml3235_get_gain(struct veml3235_data *data, int *val)
 		return ret;
 	}
 
-	switch (reg & 0x03) {
-	case 0:
-		*val = 1;
-		break;
-	case 1:
-		*val = 2;
-		break;
-	case 3:
-		*val = 4;
-		break;
-	default:
-		return -EINVAL;
+	gain = iio_gts_find_gain_by_sel(&data->gts, reg);
+	if (gain < 0)
+		return gain;
+
+	ret = regmap_field_read(data->rf.it, &reg);
+	if (ret) {
+		dev_err(data->dev, "failed to read integration time %d\n", ret);
+		return ret;
 	}
 
-	/* Double gain */
-	if (reg & 0x04)
-		*val *= 2;
+	it = iio_gts_find_int_time_by_sel(&data->gts, reg);
+	if (it < 0)
+		return it;
 
-	return IIO_VAL_INT;
+	ret = iio_gts_get_scale(&data->gts, gain, it, val, val2);
+	if (ret)
+		return ret;
+
+	return IIO_VAL_INT_PLUS_NANO;
 }
 
 static int veml3235_read_raw(struct iio_dev *indio_dev,
@@ -276,7 +280,7 @@ static int veml3235_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_INT_TIME:
 		return veml3235_get_it(data, val, val2);
 	case IIO_CHAN_INFO_SCALE:
-		return veml3235_get_gain(data, val);
+		return veml3235_get_scale(data, val, val2);
 	default:
 		return -EINVAL;
 	}
@@ -287,17 +291,27 @@ static int veml3235_read_avail(struct iio_dev *indio_dev,
 			       const int **vals, int *type, int *length,
 			       long mask)
 {
+	struct veml3235_data *data = iio_priv(indio_dev);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_INT_TIME:
-		*vals = (int *)&veml3235_it_times;
-		*length = 2 * ARRAY_SIZE(veml3235_it_times);
-		*type = IIO_VAL_INT_PLUS_MICRO;
-		return IIO_AVAIL_LIST;
+		return iio_gts_avail_times(&data->gts, vals, type, length);
 	case IIO_CHAN_INFO_SCALE:
-		*vals = (int *)&veml3235_scale_vals;
-		*length = ARRAY_SIZE(veml3235_scale_vals);
-		*type = IIO_VAL_INT;
-		return IIO_AVAIL_LIST;
+		return iio_gts_all_avail_scales(&data->gts, vals, type, length);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int veml3235_write_raw_get_fmt(struct iio_dev *indio_dev,
+				      struct iio_chan_spec const *chan,
+				      long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_INT_TIME:
+		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
 	}
@@ -309,9 +323,12 @@ static int veml3235_write_raw(struct iio_dev *indio_dev,
 {
 	switch (mask) {
 	case IIO_CHAN_INFO_INT_TIME:
-		return veml3235_set_it(indio_dev, val, val2);
+		if (val)
+			return -EINVAL;
+
+		return veml3235_set_it(indio_dev, val2);
 	case IIO_CHAN_INFO_SCALE:
-		return veml3235_set_gain(indio_dev, val, val2);
+		return veml3235_set_scale(indio_dev, val, val2);
 	}
 
 	return -EINVAL;
@@ -321,7 +338,7 @@ static void veml3235_read_id(struct veml3235_data *data)
 {
 	int ret, reg;
 
-	ret = regmap_field_read(data->rf.id,  &reg);
+	ret = regmap_field_read(data->rf.id, &reg);
 	if (ret) {
 		dev_info(data->dev, "failed to read ID\n");
 		return;
@@ -371,6 +388,13 @@ static int veml3235_hw_init(struct iio_dev *indio_dev)
 	struct device *dev = data->dev;
 	int ret;
 
+	ret = devm_iio_init_iio_gts(data->dev, 0, 272640000,
+				    veml3235_gain_sel, ARRAY_SIZE(veml3235_gain_sel),
+				    veml3235_it_sel, ARRAY_SIZE(veml3235_it_sel),
+				    &data->gts);
+	if (ret)
+		return dev_err_probe(data->dev, ret, "failed to init iio gts\n");
+
 	/* Set gain to 1 and integration time to 100 ms */
 	ret = regmap_field_write(data->rf.gain, 0x00);
 	if (ret)
@@ -389,9 +413,10 @@ static int veml3235_hw_init(struct iio_dev *indio_dev)
 }
 
 static const struct iio_info veml3235_info = {
-	.read_raw  = veml3235_read_raw,
-	.read_avail  = veml3235_read_avail,
+	.read_raw = veml3235_read_raw,
+	.read_avail = veml3235_read_avail,
 	.write_raw = veml3235_write_raw,
+	.write_raw_get_fmt = veml3235_write_raw_get_fmt,
 };
 
 static int veml3235_probe(struct i2c_client *client)
@@ -493,3 +518,4 @@ module_i2c_driver(veml3235_driver);
 MODULE_AUTHOR("Javier Carrasco <javier.carrasco.cruz@gmail.com>");
 MODULE_DESCRIPTION("VEML3235 Ambient Light Sensor");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_GTS_HELPER");

-- 
2.43.0


