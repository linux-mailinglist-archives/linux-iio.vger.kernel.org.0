Return-Path: <linux-iio+bounces-13780-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B9F9FBCD6
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 12:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 110647A072D
	for <lists+linux-iio@lfdr.de>; Tue, 24 Dec 2024 11:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712E81C5F1C;
	Tue, 24 Dec 2024 11:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRG2cwab"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8A11BE251;
	Tue, 24 Dec 2024 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735038004; cv=none; b=ntXPM9/zrnkpz0vrpCck8laz/Pl/LDaMJ5YDF2XavXFYNGo34WqutOz/ANiSjI+BKCv18gBjMQvWcOCpibuuR5o5eCr+eESSwRFkAtGMFbGK1JzpCh3xOEAasesxQZwnB+QMIAQQOY/r0BtggpPT2EMk4UjJyv1X2oSJ8hB3vAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735038004; c=relaxed/simple;
	bh=3L4AkJMuOiqvoy831vC+216muqu8ivWuslJJlT0OtXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xr91oy+mzBuhKayDMYChe5xlDpLB75z96yPbOZWnu3Qxve+dfIYrEYj0nwumuNL/LZ6ftmF9BXWeD8gMSe9fTIXeTbQk3vFgODFdArRFJC+WJEs3sm0mBeQmo/WoCiwHv9J4EXVSTGdMIXXlTKYTgkX6v8ZRzGtw5W2PHXuNNoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRG2cwab; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3862b40a6e0so2861908f8f.0;
        Tue, 24 Dec 2024 03:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735038000; x=1735642800; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rd7GQFui/s6a+z+46G9C342q/zChKZOmrRYi99jNoGc=;
        b=iRG2cwabktouHS8vcai1z32kwgbNWK6Ab8yuzXwc1oKKypEYU+LNKRD+smUnOlL0Lk
         iKovdc6RAwGiJ+ORjr35jfsN89jYtPRBkxisOhsNYxRbmtEBJKYwksxEyJI/TBHRXNcH
         w5YDGXniCd9slimrvO3JaGZPJ4rh24aM4U6K0b8ik/6T5SCtL/Gf6saDRldHgTGe/Xdv
         ufckJwixdX1+nOqhJ0MBitzyKHD8YXbzXIRIBmhKfamIleXEhGYnrz8OpltMyhOtdffo
         tRL4P9QJE/ioKe65DyqdoFZOiuZfX5BBHhwbadI/Srx79Gbsukf1ViT4mME7WbIBSJMf
         dFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735038000; x=1735642800;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rd7GQFui/s6a+z+46G9C342q/zChKZOmrRYi99jNoGc=;
        b=VUhqruwvHjvtx+w+hYQwn2oExrzxxhhuVG9c7k4RauBJXeT4oJwTa2SWA/o3d7kOPL
         8isMZLwVJ3O6sVRvaSB6sKRsK+Zxmj4rAbwdNlMeRhQ11biCAmPOrDVFsHSTkt0A28ZO
         I4UarJLoyg8WzPuN/XfiLE0y0ki/+kdyQDqHkBkg5iyOhrETxfnnj97XZvwjPU0ragJr
         yNi79xoNzAgHCGkGkkFCFzPQnv/oXjZ4rKLm8ftIhnjhpkiLo6Xx0CjSRxFhnjZVFVlH
         KbFwKH8sUMtMyYkKUnnqXPO+LxLB0TgbdwoKscq9U+cPkX5F/iJpnltJkewPX1RRaT42
         QvvA==
X-Forwarded-Encrypted: i=1; AJvYcCX7N/gntC6iyeyn3qP7loc2lBjaL49fJqPK6bouS/PIl/BcObbkOXIHz3M5r7vAFx2AOhVozsmI/Wb7Lr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjwcVHtvOhPd8ViHAg5fEh5eYILNvySjD3jWe9sXlxmrE/P5hz
	GmVG9hBKBreoNNm0AxKV5fqFPKbQ8HKwMyPm6ybQv/UUwQXSLpUD
X-Gm-Gg: ASbGnctcuzDLnEIbuS0zDkGlVorTmll7cAHwWWQLWG6TezYFREcBcRGNago0RxZht+t
	biVLzvGteZT2RAHKZRENUQnc65gfMgop3icWwEHP1s07n69pPJCZCUiQkqwJM1G/I5A1lhAjukw
	/GcOlGm5ZITYoiXq2FDHWUAMv/i6MVTUFc/dZeMZh/xHcfTJQMYDpP5rtBq1JlIliZL3biaIYhw
	8+hHKrz1xdAepoomjAXQ95/KevuDMhqHT/i7OJYaDE4a91WY/dNWhpxvVB05aJhVRpOsetTRrJF
	Nhh1sOuxE0T5PwXwS/Y0QD6vQDLdu+8/8xYNQRlIQ3ZomTvD0dAbQG7ehUbdkC3am2/6UthntW+
	Hog==
X-Google-Smtp-Source: AGHT+IHKgW0sfccPnvD5RD/iH1AA80M4gLAKLu6GQz/3JgEanzWfRXz73rsdbN3UQ68v42tEeMv+UQ==
X-Received: by 2002:a5d:64e3:0:b0:388:c7c2:5bdb with SMTP id ffacd0b85a97d-38a221e1533mr14637370f8f.2.1735038000352;
        Tue, 24 Dec 2024 03:00:00 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-1a49-0b63-5213-952a.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:1a49:b63:5213:952a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8acb85sm13699427f8f.103.2024.12.24.02.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 02:59:59 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 24 Dec 2024 11:59:03 +0100
Subject: [PATCH v2 4/4] iio: veml3235: fix scale to conform to ABI
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241224-veml3235_scale-v2-4-2e1286846c77@gmail.com>
References: <20241224-veml3235_scale-v2-0-2e1286846c77@gmail.com>
In-Reply-To: <20241224-veml3235_scale-v2-0-2e1286846c77@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735037993; l=10625;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=3L4AkJMuOiqvoy831vC+216muqu8ivWuslJJlT0OtXo=;
 b=d1l16gRjz9vbtc6jYEQkj+hPkni8Mcg7mIxMb8L+go9fU3gNJVugszsiLdUzpgvlg7p2tacsg
 bayGJmRXll/DILpd4Mttyfv/bJliH4UA7KjDNeFMp9G4M5Jak0EVIzr
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
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/Kconfig    |   1 +
 drivers/iio/light/veml3235.c | 237 +++++++++++++++++++++++--------------------
 2 files changed, 130 insertions(+), 108 deletions(-)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 0cf9cf2a3f944d9f9967b0e02dcb114c116803a4..12864691a7ffa008df5b3384c9caca7ec234577f 100644
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
index f754980ea156a6e128ff159b816e09099197c5c7..56e98bf421841bf0082245f69274c7a00c1d5c8a 100644
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
+	ret = iio_gts_find_gain_sel_in_times(&data->gts, val, val2, &gain_sel,
+					     &time_sel);
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


