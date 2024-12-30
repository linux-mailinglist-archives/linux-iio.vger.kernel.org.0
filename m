Return-Path: <linux-iio+bounces-13864-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6E39FE77D
	for <lists+linux-iio@lfdr.de>; Mon, 30 Dec 2024 16:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDDF618828C7
	for <lists+linux-iio@lfdr.de>; Mon, 30 Dec 2024 15:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AA51AB6E2;
	Mon, 30 Dec 2024 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBNeg1FD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3C01AA794;
	Mon, 30 Dec 2024 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735571659; cv=none; b=fzrrFYwgRphOz9RAY6xrGOPChkxQtLpJbWfoBUdtMteikUI9ZaapEx72p5jH4kgMWttn6oBS3nIK54yZzsFhPOucSoRdLWQczdchsXvENq/YcifttzykJpWcereOx/i3EeLf3midcoOP6LMAVP2X3MwkmmH8PR/TQS/4/3yR26o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735571659; c=relaxed/simple;
	bh=8H460fZJOi+qM0ndD6yd960Um1X1URVJDR8oXrKBFW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lLc2ryYw3bTRyEKdHpvydkdSTHb3XdJi1Y1k3YNMqTk0C7DaJLJaukRuabNaUQDgOa1/dzwyM2pmxNXB8+e15pYtTs+M+tKmG/Ce7uZ1A65L0gNuH/rV8YsmHuci2PNQbWUXAvgPT5LnOIMly2ykIl51qOdxIG8+wDTy2sMBaZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBNeg1FD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43690d4605dso26921775e9.0;
        Mon, 30 Dec 2024 07:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735571656; x=1736176456; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sagPrjFX/xJKyNV/IniBabReXHppXB57Rv1Kz03nZHo=;
        b=mBNeg1FDq1Hc7U1yHcTEJE1jC+IBiAe3KVIqkxTvx4GLZbugjP3cgaI5tzAX7RnmIi
         xA/p6no3Lpf0hIXno/AXI3xRJakGkm/XEvnZsaW85GqrOVKzcGTbV6kZPmjPX690HOQ7
         ZgFP5KSOe+nNWP5hAs5qfHF5krgmvbq3Bq6Q5TBQAI6UQW7WanZ1k3ddUx34Yh/sXxrs
         fnBQK6n9b/SK5jgXYR+J9l7fWYz301uurVbbmjo7/alf+zaOrztGBh40FsbpimnXVfRF
         UL0nhhIigt2qyyawtZ1frkN708JTOEjJtISKTTigQRKhxyhFlPgC2CWtBhoRYVU1/bqq
         yjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735571656; x=1736176456;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sagPrjFX/xJKyNV/IniBabReXHppXB57Rv1Kz03nZHo=;
        b=U6Wj1v1JjprdeAvWsjaomLFRDSjGsh0XEtgZEWdLA6lPg7wcfOX9HN9tlyelcO/8Ln
         0jq72FZhzp1oeXUvf0zGcff87LnYAso+UOkOL8f7FwEgPSOekIJBJVXDu+KKemKugN+Z
         GNZf3XqPz5uuQXsAlEcd0qDy6hQIoXTFwVSpnuqFKbUvbetyONTrdDE/2MEoIBw6d4Qo
         8TO/fFlDz/k5cqUQZHDkqt+I/p/OqBH4vC9q/uMCi1v2FrE1DvyC1SisAdmnvi8VqvjE
         4zcIY5rA6fmZXhyb9d/7TC2nQGGi0pO2bhRhz+ibvCtt3FOg0jIbhOTtTB77zAYMsJsU
         lDGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVB9DcsBWi5MnKjjt7Nii+jbgaJjZAIi9EwmPIiAOZ6G3ZAGCp0K8YD9p47JYbRjROKKRLI2bpngUv+A/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzKQAavyA/FxZ2XCPD/KjXEeGo8B5xMxK4Q5tMfeDl0Ca8ZyoK
	HOW8R6+jVz7EELS02vq00g8j3+IogA1yDUoU95ymXqCEpVicRZWM
X-Gm-Gg: ASbGnctm6hKGKWJ4kRIWkS7/Drov7lbmpP10BVw6xDfSLQvMki5C746MicTn6PYoMsA
	/4yD/aTq+njpefvysRRCYpLFOrhBxCBM800zeqAIuv4eC2thFQQYpGD2QvMjxy1prJROPoAzkRc
	kvE128YOZGgQX53VM2P4aZ9MDgBxuWigKReJ2yB9mEeMcQnLXDEDsIfY53N/c9C0iPQALXa4isf
	ZhpTzJe3UcawMAzoMP0eWvBDbqLSbt87uciV1JngUqVKLrnYNlfUQrW93quShQxD4i1m8/oWClm
	nMh7yNDT5X1oaN1l0ba/Y8WrsV+T
X-Google-Smtp-Source: AGHT+IED+sO4qDtKoaEc66VvBoC/UBlPrOEOg4cf92FF9DRSFopA7zd2n2C4ogAbsIScZcv/OQjleA==
X-Received: by 2002:a05:600c:4f91:b0:434:f7e3:bfa8 with SMTP id 5b1f17b1804b1-43668b786d3mr240127015e9.33.1735571655691;
        Mon, 30 Dec 2024 07:14:15 -0800 (PST)
Received: from [127.0.1.1] (82.158.190.253.dyn.user.ono.com. [82.158.190.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436611ea47asm358056485e9.4.2024.12.30.07.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 07:14:15 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 30 Dec 2024 16:13:53 +0100
Subject: [PATCH v3 2/2] iio: veml3235: fix scale to conform to ABI
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241230-veml3235_scale-v3-2-48a5795e2f64@gmail.com>
References: <20241230-veml3235_scale-v3-0-48a5795e2f64@gmail.com>
In-Reply-To: <20241230-veml3235_scale-v3-0-48a5795e2f64@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735571652; l=10687;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=8H460fZJOi+qM0ndD6yd960Um1X1URVJDR8oXrKBFW4=;
 b=KZnk9HfBTjh34yh2T65fv/TvIXOTXZlJ02GdwPGvfwMTcj7jJeVMPp3HbHRcHRQuLyqhZNIOQ
 SWhdlVnD38QCrT9kSdZKarfydBHIiGquuo35n0oYQvuy1ZffEmem6X7
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The current scale is not ABI-compliant as it is just the sensor gain
instead of the value that acts as a multiplier to be applied to the raw
value (there is no offset).

Use the iio-gts helpers to obtain the proper scale values according to
the gain and integration time to match the resolution tables from the
datasheet. When at it, use 'scale' instead of 'gain' consistently for
the get/set functions to avoid misunderstandings.

Fixes: c5a23f80c164 ("iio: light: add support for veml3235")
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/Kconfig    |   1 +
 drivers/iio/light/veml3235.c | 237 +++++++++++++++++++++++--------------------
 2 files changed, 130 insertions(+), 108 deletions(-)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 4897258e3da5519f2757e5f105552596dc4473cf..e34e551eef3e8db006de56724ce3873c07b3360a 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -669,6 +669,7 @@ config VCNL4035
 config VEML3235
 	tristate "VEML3235 ambient light sensor"
 	select REGMAP_I2C
+	select IIO_GTS_HELPER
 	depends on I2C
 	help
 	  Say Y here if you want to build a driver for the Vishay VEML3235
diff --git a/drivers/iio/light/veml3235.c b/drivers/iio/light/veml3235.c
index f754980ea156a6e128ff159b816e09099197c5c7..77c9ae17ed4715a453075fcdd6a17c21e52bf137 100644
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
+ * handling can be simplified by restricting DG = 1 to the only gain that
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
@@ -142,32 +159,17 @@ static const struct regmap_config veml3235_regmap_config = {
 
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
@@ -176,78 +178,78 @@ static int veml3235_get_it(struct veml3235_data *data, int *val, int *val2)
 static int veml3235_set_it(struct iio_dev *indio_dev, int val, int val2)
 {
 	struct veml3235_data *data = iio_priv(indio_dev);
-	int ret, new_it;
+	int ret, gain_idx, it_idx, new_gain, prev_gain, prev_it;
+	bool in_range;
 
-	if (val)
+	if (val || !iio_gts_valid_time(&data->gts, val2))
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
+	ret = regmap_field_read(data->rf.it, &it_idx);
+	if (ret)
+		return ret;
 
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
+	ret = iio_gts_find_gain_time_sel_for_scale(&data->gts, val, val2,
+						   &gain_sel, &time_sel);
+	if (ret)
+		return ret;
 
-	ret = regmap_field_write(data->rf.gain, new_gain);
-	if (ret) {
-		dev_err(data->dev, "failed to set gain: %d\n", ret);
+	ret = regmap_field_write(data->rf.it, time_sel);
+	if (ret)
 		return ret;
-	}
 
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
@@ -255,25 +257,25 @@ static int veml3235_get_gain(struct veml3235_data *data, int *val)
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
@@ -307,7 +309,7 @@ static int veml3235_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_INT_TIME:
 		return veml3235_get_it(data, val, val2);
 	case IIO_CHAN_INFO_SCALE:
-		return veml3235_get_gain(data, val);
+		return veml3235_get_scale(data, val, val2);
 	default:
 		return -EINVAL;
 	}
@@ -318,17 +320,27 @@ static int veml3235_read_avail(struct iio_dev *indio_dev,
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
@@ -342,7 +354,7 @@ static int veml3235_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_INT_TIME:
 		return veml3235_set_it(indio_dev, val, val2);
 	case IIO_CHAN_INFO_SCALE:
-		return veml3235_set_gain(indio_dev, val, val2);
+		return veml3235_set_scale(indio_dev, val, val2);
 	}
 
 	return -EINVAL;
@@ -402,6 +414,13 @@ static int veml3235_hw_init(struct iio_dev *indio_dev)
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
@@ -423,6 +442,7 @@ static const struct iio_info veml3235_info = {
 	.read_raw = veml3235_read_raw,
 	.read_avail = veml3235_read_avail,
 	.write_raw = veml3235_write_raw,
+	.write_raw_get_fmt = veml3235_write_raw_get_fmt,
 };
 
 static int veml3235_probe(struct i2c_client *client)
@@ -524,3 +544,4 @@ module_i2c_driver(veml3235_driver);
 MODULE_AUTHOR("Javier Carrasco <javier.carrasco.cruz@gmail.com>");
 MODULE_DESCRIPTION("VEML3235 Ambient Light Sensor");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_GTS_HELPER");

-- 
2.43.0


