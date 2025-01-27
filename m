Return-Path: <linux-iio+bounces-14641-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0ACA1DCBF
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 20:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53AF118867E0
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2025 19:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3FB192D9D;
	Mon, 27 Jan 2025 19:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAn3+itx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E51193407;
	Mon, 27 Jan 2025 19:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738006239; cv=none; b=aoms+utACSfqy63fCPqy0GK/1nHTPuPLBu1d3f38nwR7DcVOeEjkOUDLodhlWKZpkrmVD3aijO2GpPCF5khd+4ZMMkjNZZvezRBkCvXtimRRWdiYHWR8zuEllrhRivLevevCLQOPSxqyJTqGCSsmrFhS9ZQjhvzPGv9uSkvzvMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738006239; c=relaxed/simple;
	bh=5tD8Vk7EekypCWuhLNMML4rWHhNpWxWZrnxHHi4O3a8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=thVlvvqcuA7sSpTQ6nyGvLDg0lI5n/DtQo6+tBssgG6uFhG+vhHuXQGd+b0HZ/K9ENIsxNtFDpn9Q5MVXv16t1aTP8BFKDuVoOvkgVMB/0CDPpe+cDXGIN6ofvVifHZQ/QG7fyF/gZer+58I5v1KFWwLsW1dSNzv0Im2eia6LhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAn3+itx; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so55910365e9.0;
        Mon, 27 Jan 2025 11:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738006235; x=1738611035; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jSGwaEkrtMFze0NZna4iTiM8aQ/SSR3BYpBAJypqEPs=;
        b=jAn3+itxfnA1BIohC5ad/7fR329TZE6HqyOI3WaM+DzfI2ch6NUqS7n026qOuvHb0H
         +ly3fyzejghkiYaYCBhI/cyERiCJRvd/7pYy2V3OGUEd7ZpoDy8tlXos5E9ue/VB73aR
         RKEQLpSw4sVVaQMNpgObe4eKXePFviaXSqCku3J8AXwb5maSw/0GkvxEHpRknVYkB0JC
         ldYB4OTvhbj9vKNk7RVvdUm1jZwqW8Zxr+lzpBsreuMr/09xtiQsM/gNFqC9bnLEzjYG
         z34QtAk1Kfoeq0346M770DSZuTHY6UMlBkdPxNMhQFE7bvXOq7z0vBOLYSFiDHKhogsZ
         F52g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738006235; x=1738611035;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSGwaEkrtMFze0NZna4iTiM8aQ/SSR3BYpBAJypqEPs=;
        b=b7caD6G3UAg+fKkERZed3wHJ1a8+No37MBzHM+Wz33x6HtUzX5x1g+cRhNu/BYmhuO
         D4Xo4uCx9xIs37tke09hGqM+Glp/Hk6ZkHzYI9uIEw8grsyahF+SUYVIEmMldMig3gQj
         6izTtuhstkVumrJEzgB+FZjoQ5rXeb3W/LLgSyTpcoK5ZbmWeDxYBaL7VrVAn3TPWAwN
         YdBcg9TN+lxEMVZWb34CLLM5+xN51IKPBeM5LbSd6B7+m7vB/KjnjCvDHKj0BMdye/pD
         ++jAkR+PzKXUaBh7ZlIubu+pi1TjhTVQ87boE6Ke10m0lT2C2LP0aJNjnZjbXlmnwt8Q
         HG/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6UcpOS7nbDRQnjpjvaauAQBSoczlHA3CuDdVxmlEwLOOABKNWYmIp52iceyofvUJf3ffIMqXlcjFHQ48=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJQKX4PguQ8hvxh+11F1GMlK47YNpgpIFhGDG41SxfZMkIFWlV
	tDdlByKth3dGuz/GtIAAC1dM47SX+a0GQN7WCEzAhT/UIpMcm5bs
X-Gm-Gg: ASbGncsX7D4XBBVj0nkT91ImVLNSW0L8jinMXBuHmcZXUzAkeervHb5L77AfNMxosRb
	7p4NVE2nqhUAMEGzaAt5liLGGU9PYgZ/WXeBSma+f52gv8DUGAl5u8dtfbf/DuG2H0Oc7ATQz1O
	qkmQ8zugKwvSB3+JgICpiE39hyOuhPffXnmrsS5m9u8tLGniLpbsGpmStH5PSPqu4CWv96XpnoB
	8fd9dBWWNo5mK151X5yTIbPvQIVQ2+2xNZf4W+8X+Is2q5G8yNhcU/+SRV7JlNf7Blue3H4qhLU
	oQm7alBRYFX4kynWuEK2G2fq3kgrSXlAgsZLCOaiI0W3LB2mi4qTGl62FmBSi1dGBPDqWTsyX2O
	XxlS4dQVVT7Ktdo6NRVVlduXdWA==
X-Google-Smtp-Source: AGHT+IHtki0MCkzUINr+06dFcYaayl0UIW2jQrZQ2rugocBoN1NSguGYSN4kVfrzmFWuU1MIndVbMA==
X-Received: by 2002:a05:600c:4f42:b0:434:a7e3:db5c with SMTP id 5b1f17b1804b1-438913cafacmr438165765e9.11.1738006234530;
        Mon, 27 Jan 2025 11:30:34 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b1d9-eb5a-e5fd-0636.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b1d9:eb5a:e5fd:636])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd4fa463sm142986915e9.8.2025.01.27.11.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 11:30:34 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 27 Jan 2025 20:30:23 +0100
Subject: [PATCH v3 2/2] iio: light: veml6030: fix scale to conform to ABI
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250127-veml6030-scale-v3-2-4f32ba03df94@gmail.com>
References: <20250127-veml6030-scale-v3-0-4f32ba03df94@gmail.com>
In-Reply-To: <20250127-veml6030-scale-v3-0-4f32ba03df94@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rishi Gupta <gupt21@gmail.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738006229; l=23017;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=5tD8Vk7EekypCWuhLNMML4rWHhNpWxWZrnxHHi4O3a8=;
 b=goX+A6hwZDKBtvyNM14/zt175PowsElB8x1iSEboP0bWzw539ss6O1ZhJtXd/ohBIN10o3a4m
 uYP4UrqEIbNDeKH8Ik4W4+rDIZb1PxdXOQMiCVThALw0g25o9SDJzip
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The current scale is not ABI-compliant as it is just the sensor gain
instead of the value that acts as a multiplier to be applied to the raw
value (there is no offset).

Use the iio-gts helpers to obtain the proper scale values according to
the gain and integration time to match the resolution tables from the
datasheet and drop dedicated variables to store the current values of
the integration time, gain and resolution. When at it, use 'scale'
instead of 'gain' consistently for the get/set functions to avoid
misunderstandings.

Fixes: 7b779f573c48 ("iio: light: add driver for veml6030 ambient light sensor")
Acked-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/Kconfig    |   1 +
 drivers/iio/light/veml6030.c | 528 ++++++++++++++++++-------------------------
 2 files changed, 218 insertions(+), 311 deletions(-)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 9260056f0af8a3d41c6cf8a8e74765b95a51aa8a..89aec08df739db924c4c827167267cbe6b993b81 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -694,6 +694,7 @@ config VEML6030
 	select REGMAP_I2C
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
+	select IIO_GTS_HELPER
 	depends on I2C
 	help
 	  Say Y here if you want to build a driver for the Vishay VEML6030
diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 3afd4bb1ad53157f7ec63a35f51e5a96f7b019fd..473a9c3e32a3a53f373595a5113b47e795f5366c 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -24,10 +24,12 @@
 #include <linux/regmap.h>
 #include <linux/interrupt.h>
 #include <linux/pm_runtime.h>
+#include <linux/units.h>
 #include <linux/regulator/consumer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
+#include <linux/iio/iio-gts-helper.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
@@ -65,6 +67,10 @@
 
 #define VEML6035_GAIN_RF      REG_FIELD(VEML6030_REG_ALS_CONF, 10, 12)
 
+/* Maximum scales x 10000 to work with integers */
+#define VEML6030_MAX_SCALE    21504
+#define VEML6035_MAX_SCALE    4096
+
 enum veml6030_scan {
 	VEML6030_SCAN_ALS,
 	VEML6030_SCAN_WH,
@@ -78,16 +84,13 @@ struct veml6030_rf {
 
 struct veml603x_chip {
 	const char *name;
-	const int(*scale_vals)[][2];
-	const int num_scale_vals;
 	const struct iio_chan_spec *channels;
 	const int num_channels;
 	const struct reg_field gain_rf;
 	const struct reg_field it_rf;
+	const int max_scale;
 	int (*hw_init)(struct iio_dev *indio_dev, struct device *dev);
 	int (*set_info)(struct iio_dev *indio_dev);
-	int (*set_als_gain)(struct iio_dev *indio_dev, int val, int val2);
-	int (*get_als_gain)(struct iio_dev *indio_dev, int *val, int *val2);
 };
 
 /*
@@ -105,40 +108,55 @@ struct veml6030_data {
 	struct i2c_client *client;
 	struct regmap *regmap;
 	struct veml6030_rf rf;
-	int cur_resolution;
-	int cur_gain;
-	int cur_integration_time;
 	const struct veml603x_chip *chip;
+	struct iio_gts gts;
+
 };
 
-static const int veml6030_it_times[][2] = {
-	{ 0, 25000 },
-	{ 0, 50000 },
-	{ 0, 100000 },
-	{ 0, 200000 },
-	{ 0, 400000 },
-	{ 0, 800000 },
+#define VEML6030_SEL_IT_25MS  0x0C
+#define VEML6030_SEL_IT_50MS  0x08
+#define VEML6030_SEL_IT_100MS 0x00
+#define VEML6030_SEL_IT_200MS 0x01
+#define VEML6030_SEL_IT_400MS 0x02
+#define VEML6030_SEL_IT_800MS 0x03
+static const struct iio_itime_sel_mul veml6030_it_sel[] = {
+	GAIN_SCALE_ITIME_US(25000, VEML6030_SEL_IT_25MS, 1),
+	GAIN_SCALE_ITIME_US(50000, VEML6030_SEL_IT_50MS, 2),
+	GAIN_SCALE_ITIME_US(100000, VEML6030_SEL_IT_100MS, 4),
+	GAIN_SCALE_ITIME_US(200000, VEML6030_SEL_IT_200MS, 8),
+	GAIN_SCALE_ITIME_US(400000, VEML6030_SEL_IT_400MS, 16),
+	GAIN_SCALE_ITIME_US(800000, VEML6030_SEL_IT_800MS, 32),
 };
 
-/*
- * Scale is 1/gain. Value 0.125 is ALS gain x (1/8), 0.25 is
- * ALS gain x (1/4), 0.5 is ALS gain x (1/2), 1.0 is ALS gain x 1,
- * 2.0 is ALS gain x2, and 4.0 is ALS gain x 4.
+/* Gains are multiplied by 8 to work with integers. The values in the
+ * iio-gts tables don't need corrections because the maximum value of
+ * the scale refers to GAIN = x1, and the rest of the values are
+ * obtained from the resulting linear function.
  */
-static const int veml6030_scale_vals[][2] = {
-	{ 0, 125000 },
-	{ 0, 250000 },
-	{ 1, 0 },
-	{ 2, 0 },
+#define VEML6030_SEL_MILLI_GAIN_X125  2
+#define VEML6030_SEL_MILLI_GAIN_X250  3
+#define VEML6030_SEL_MILLI_GAIN_X1000 0
+#define VEML6030_SEL_MILLI_GAIN_X2000 1
+static const struct iio_gain_sel_pair veml6030_gain_sel[] = {
+	GAIN_SCALE_GAIN(1, VEML6030_SEL_MILLI_GAIN_X125),
+	GAIN_SCALE_GAIN(2, VEML6030_SEL_MILLI_GAIN_X250),
+	GAIN_SCALE_GAIN(8, VEML6030_SEL_MILLI_GAIN_X1000),
+	GAIN_SCALE_GAIN(16, VEML6030_SEL_MILLI_GAIN_X2000),
 };
 
-static const int veml6035_scale_vals[][2] = {
-	{ 0, 125000 },
-	{ 0, 250000 },
-	{ 0, 500000 },
-	{ 1, 0 },
-	{ 2, 0 },
-	{ 4, 0 },
+#define VEML6035_SEL_MILLI_GAIN_X125  4
+#define VEML6035_SEL_MILLI_GAIN_X250  5
+#define VEML6035_SEL_MILLI_GAIN_X500  7
+#define VEML6035_SEL_MILLI_GAIN_X1000 0
+#define VEML6035_SEL_MILLI_GAIN_X2000 1
+#define VEML6035_SEL_MILLI_GAIN_X4000 3
+static const struct iio_gain_sel_pair veml6035_gain_sel[] = {
+	GAIN_SCALE_GAIN(1, VEML6035_SEL_MILLI_GAIN_X125),
+	GAIN_SCALE_GAIN(2, VEML6035_SEL_MILLI_GAIN_X250),
+	GAIN_SCALE_GAIN(4, VEML6035_SEL_MILLI_GAIN_X500),
+	GAIN_SCALE_GAIN(8, VEML6035_SEL_MILLI_GAIN_X1000),
+	GAIN_SCALE_GAIN(16, VEML6035_SEL_MILLI_GAIN_X2000),
+	GAIN_SCALE_GAIN(32, VEML6035_SEL_MILLI_GAIN_X4000),
 };
 
 /*
@@ -372,104 +390,73 @@ static const struct regmap_config veml6030_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
-static int veml6030_get_intgrn_tm(struct iio_dev *indio_dev,
-						int *val, int *val2)
+static int veml6030_get_it(struct veml6030_data *data, int *val, int *val2)
 {
-	int it_idx, ret;
-	struct veml6030_data *data = iio_priv(indio_dev);
+	int ret, it_idx;
 
 	ret = regmap_field_read(data->rf.it, &it_idx);
-	if (ret) {
-		dev_err(&data->client->dev,
-				"can't read als conf register %d\n", ret);
+	if (ret)
 		return ret;
-	}
 
-	switch (it_idx) {
-	case 0:
-		*val2 = 100000;
-		break;
-	case 1:
-		*val2 = 200000;
-		break;
-	case 2:
-		*val2 = 400000;
-		break;
-	case 3:
-		*val2 = 800000;
-		break;
-	case 8:
-		*val2 = 50000;
-		break;
-	case 12:
-		*val2 = 25000;
-		break;
-	default:
-		return -EINVAL;
-	}
+	ret = iio_gts_find_int_time_by_sel(&data->gts, it_idx);
+	if (ret < 0)
+		return ret;
 
+	*val2 = ret;
 	*val = 0;
+
 	return IIO_VAL_INT_PLUS_MICRO;
 }
 
-static int veml6030_set_intgrn_tm(struct iio_dev *indio_dev,
-						int val, int val2)
+static int veml6030_set_it(struct iio_dev *indio_dev, int val, int val2)
 {
-	int ret, new_int_time, int_idx;
 	struct veml6030_data *data = iio_priv(indio_dev);
+	int ret, gain_idx, it_idx, new_gain, prev_gain, prev_it;
+	bool in_range;
 
-	if (val)
+	if (val || !iio_gts_valid_time(&data->gts, val2))
 		return -EINVAL;
 
-	switch (val2) {
-	case 25000:
-		new_int_time = 0x300;
-		int_idx = 5;
-		break;
-	case 50000:
-		new_int_time = 0x200;
-		int_idx = 4;
-		break;
-	case 100000:
-		new_int_time = 0x00;
-		int_idx = 3;
-		break;
-	case 200000:
-		new_int_time = 0x40;
-		int_idx = 2;
-		break;
-	case 400000:
-		new_int_time = 0x80;
-		int_idx = 1;
-		break;
-	case 800000:
-		new_int_time = 0xC0;
-		int_idx = 0;
-		break;
-	default:
-		return -EINVAL;
-	}
+	ret = regmap_field_read(data->rf.it, &it_idx);
+	if (ret)
+		return ret;
 
-	ret = regmap_field_write(data->rf.it, new_int_time);
-	if (ret) {
-		dev_err(&data->client->dev,
-				"can't update als integration time %d\n", ret);
+	ret = regmap_field_read(data->rf.gain, &gain_idx);
+	if (ret)
 		return ret;
-	}
 
-	/*
-	 * Cache current integration time and update resolution. For every
-	 * increase in integration time to next level, resolution is halved
-	 * and vice-versa.
-	 */
-	if (data->cur_integration_time < int_idx)
-		data->cur_resolution <<= int_idx - data->cur_integration_time;
-	else if (data->cur_integration_time > int_idx)
-		data->cur_resolution >>= data->cur_integration_time - int_idx;
+	prev_it = iio_gts_find_int_time_by_sel(&data->gts, it_idx);
+	if (prev_it < 0)
+		return prev_it;
+
+	if (prev_it == val2)
+		return 0;
 
-	data->cur_integration_time = int_idx;
+	prev_gain = iio_gts_find_gain_by_sel(&data->gts, gain_idx);
+	if (prev_gain < 0)
+		return prev_gain;
 
-	return ret;
+	ret = iio_gts_find_new_gain_by_gain_time_min(&data->gts, prev_gain, prev_it,
+						     val2, &new_gain, &in_range);
+	if (ret)
+		return ret;
+
+	if (!in_range)
+		dev_dbg(&data->client->dev, "Optimal gain out of range\n");
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
 
 static int veml6030_read_persistence(struct iio_dev *indio_dev,
@@ -478,7 +465,7 @@ static int veml6030_read_persistence(struct iio_dev *indio_dev,
 	int ret, reg, period, x, y;
 	struct veml6030_data *data = iio_priv(indio_dev);
 
-	ret = veml6030_get_intgrn_tm(indio_dev, &x, &y);
+	ret = veml6030_get_it(data, &x, &y);
 	if (ret < 0)
 		return ret;
 
@@ -503,7 +490,7 @@ static int veml6030_write_persistence(struct iio_dev *indio_dev,
 	int ret, period, x, y;
 	struct veml6030_data *data = iio_priv(indio_dev);
 
-	ret = veml6030_get_intgrn_tm(indio_dev, &x, &y);
+	ret = veml6030_get_it(data, &x, &y);
 	if (ret < 0)
 		return ret;
 
@@ -532,177 +519,29 @@ static int veml6030_write_persistence(struct iio_dev *indio_dev,
 	return ret;
 }
 
-/*
- * Cache currently set gain & update resolution. For every
- * increase in the gain to next level, resolution is halved
- * and vice-versa.
- */
-static void veml6030_update_gain_res(struct veml6030_data *data, int gain_idx)
-{
-	if (data->cur_gain < gain_idx)
-		data->cur_resolution <<= gain_idx - data->cur_gain;
-	else if (data->cur_gain > gain_idx)
-		data->cur_resolution >>= data->cur_gain - gain_idx;
-
-	data->cur_gain = gain_idx;
-}
-
-static int veml6030_set_als_gain(struct iio_dev *indio_dev,
-						int val, int val2)
+static int veml6030_set_scale(struct iio_dev *indio_dev, int val, int val2)
 {
-	int ret, new_gain, gain_idx;
+	int ret, gain_sel, it_idx, it_sel;
 	struct veml6030_data *data = iio_priv(indio_dev);
 
-	if (val == 0 && val2 == 125000) {
-		new_gain = 0x01;
-		gain_idx = 3;
-	} else if (val == 0 && val2 == 250000) {
-		new_gain = 0x11;
-		gain_idx = 2;
-	} else if (val == 1 && val2 == 0) {
-		new_gain = 0x00;
-		gain_idx = 1;
-	} else if (val == 2 && val2 == 0) {
-		new_gain = 0x01;
-		gain_idx = 0;
-	} else {
-		return -EINVAL;
-	}
-
-	ret = regmap_field_write(data->rf.gain, new_gain);
-	if (ret) {
-		dev_err(&data->client->dev,
-				"can't set als gain %d\n", ret);
+	ret = regmap_field_read(data->rf.it, &it_idx);
+	if (ret)
 		return ret;
-	}
-
-	veml6030_update_gain_res(data, gain_idx);
-
-	return 0;
-}
-
-static int veml6035_set_als_gain(struct iio_dev *indio_dev, int val, int val2)
-{
-	int ret, new_gain, gain_idx;
-	struct veml6030_data *data = iio_priv(indio_dev);
-
-	if (val == 0 && val2 == 125000) {
-		new_gain = FIELD_GET(VEML6035_GAIN_M, VEML6035_SENS);
-		gain_idx = 5;
-	} else if (val == 0 && val2 == 250000) {
-		new_gain = FIELD_GET(VEML6035_GAIN_M, VEML6035_SENS |
-				      VEML6035_GAIN);
-		gain_idx = 4;
-	} else if (val == 0 && val2 == 500000) {
-		new_gain = FIELD_GET(VEML6035_GAIN_M, VEML6035_SENS |
-				      VEML6035_GAIN | VEML6035_DG);
-		gain_idx = 3;
-	} else if (val == 1 && val2 == 0) {
-		new_gain = 0x0000;
-		gain_idx = 2;
-	} else if (val == 2 && val2 == 0) {
-		new_gain = FIELD_GET(VEML6035_GAIN_M, VEML6035_GAIN);
-		gain_idx = 1;
-	} else if (val == 4 && val2 == 0) {
-		new_gain = FIELD_GET(VEML6035_GAIN_M, VEML6035_GAIN |
-				      VEML6035_DG);
-		gain_idx = 0;
-	} else {
-		return -EINVAL;
-	}
 
-	ret = regmap_field_write(data->rf.gain, new_gain);
-	if (ret) {
-		dev_err(&data->client->dev, "can't set als gain %d\n", ret);
+	ret = iio_gts_find_gain_time_sel_for_scale(&data->gts, val, val2,
+						   &gain_sel, &it_sel);
+	if (ret)
 		return ret;
-	}
-
-	veml6030_update_gain_res(data, gain_idx);
-
-	return 0;
-}
-
-static int veml6030_get_als_gain(struct iio_dev *indio_dev,
-						int *val, int *val2)
-{
-	int gain, ret;
-	struct veml6030_data *data = iio_priv(indio_dev);
 
-	ret = regmap_field_read(data->rf.gain, &gain);
-	if (ret) {
-		dev_err(&data->client->dev,
-				"can't read als conf register %d\n", ret);
+	ret = regmap_field_write(data->rf.it, it_sel);
+	if (ret)
 		return ret;
-	}
 
-	switch (gain) {
-	case 0:
-		*val = 1;
-		*val2 = 0;
-		break;
-	case 1:
-		*val = 2;
-		*val2 = 0;
-		break;
-	case 2:
-		*val = 0;
-		*val2 = 125000;
-		break;
-	case 3:
-		*val = 0;
-		*val2 = 250000;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	return IIO_VAL_INT_PLUS_MICRO;
-}
-
-static int veml6035_get_als_gain(struct iio_dev *indio_dev, int *val, int *val2)
-{
-	int gain, ret;
-	struct veml6030_data *data = iio_priv(indio_dev);
-
-	ret = regmap_field_read(data->rf.gain, &gain);
-	if (ret) {
-		dev_err(&data->client->dev,
-				"can't read als conf register %d\n", ret);
+	ret = regmap_field_write(data->rf.gain, gain_sel);
+	if (ret)
 		return ret;
-	}
-
-	switch (gain) {
-	case 0:
-		*val = 1;
-		*val2 = 0;
-		break;
-	case 1:
-	case 2:
-		*val = 2;
-		*val2 = 0;
-		break;
-	case 3:
-		*val = 4;
-		*val2 = 0;
-		break;
-	case 4:
-		*val = 0;
-		*val2 = 125000;
-		break;
-	case 5:
-	case 6:
-		*val = 0;
-		*val2 = 250000;
-		break;
-	case 7:
-		*val = 0;
-		*val2 = 500000;
-		break;
-	default:
-		return -EINVAL;
-	}
 
-	return IIO_VAL_INT_PLUS_MICRO;
+	return 0;
 }
 
 static int veml6030_read_thresh(struct iio_dev *indio_dev,
@@ -749,6 +588,71 @@ static int veml6030_write_thresh(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static int veml6030_get_total_gain(struct veml6030_data *data)
+{
+	int gain, it, reg, ret;
+
+	ret = regmap_field_read(data->rf.gain, &reg);
+	if (ret)
+		return ret;
+
+	gain = iio_gts_find_gain_by_sel(&data->gts, reg);
+	if (gain < 0)
+		return gain;
+
+	ret = regmap_field_read(data->rf.it, &reg);
+	if (ret)
+		return ret;
+
+	it = iio_gts_find_int_time_by_sel(&data->gts, reg);
+	if (it < 0)
+		return it;
+
+	return iio_gts_get_total_gain(&data->gts, gain, it);
+}
+
+static int veml6030_get_scale(struct veml6030_data *data, int *val, int *val2)
+{
+	int gain, it, reg, ret;
+
+	ret = regmap_field_read(data->rf.gain, &reg);
+	if (ret)
+		return ret;
+
+	gain = iio_gts_find_gain_by_sel(&data->gts, reg);
+	if (gain < 0)
+		return gain;
+
+	ret = regmap_field_read(data->rf.it, &reg);
+	if (ret)
+		return ret;
+
+	it = iio_gts_find_int_time_by_sel(&data->gts, reg);
+	if (it < 0)
+		return it;
+
+	ret = iio_gts_get_scale(&data->gts, gain, it, val, val2);
+	if (ret)
+		return ret;
+
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
+static int veml6030_process_als(struct veml6030_data *data, int raw,
+				int *val, int *val2)
+{
+	int total_gain;
+
+	total_gain = veml6030_get_total_gain(data);
+	if (total_gain < 0)
+		return total_gain;
+
+	*val = raw * data->chip->max_scale / total_gain / 10000;
+	*val2 = raw * data->chip->max_scale / total_gain % 10000 * 100;
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
 /*
  * Provide both raw as well as light reading in lux.
  * light (in lux) = resolution * raw reading
@@ -772,11 +676,9 @@ static int veml6030_read_raw(struct iio_dev *indio_dev,
 				dev_err(dev, "can't read als data %d\n", ret);
 				return ret;
 			}
-			if (mask == IIO_CHAN_INFO_PROCESSED) {
-				*val = (reg * data->cur_resolution) / 10000;
-				*val2 = (reg * data->cur_resolution) % 10000 * 100;
-				return IIO_VAL_INT_PLUS_MICRO;
-			}
+			if (mask == IIO_CHAN_INFO_PROCESSED)
+				return veml6030_process_als(data, reg, val, val2);
+
 			*val = reg;
 			return IIO_VAL_INT;
 		case IIO_INTENSITY:
@@ -791,9 +693,9 @@ static int veml6030_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_INT_TIME:
-		return veml6030_get_intgrn_tm(indio_dev, val, val2);
+		return veml6030_get_it(data, val, val2);
 	case IIO_CHAN_INFO_SCALE:
-		return data->chip->get_als_gain(indio_dev, val, val2);
+		return veml6030_get_scale(data, val, val2);
 	default:
 		return -EINVAL;
 	}
@@ -808,15 +710,9 @@ static int veml6030_read_avail(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_INT_TIME:
-		*vals = (int *)&veml6030_it_times;
-		*length = 2 * ARRAY_SIZE(veml6030_it_times);
-		*type = IIO_VAL_INT_PLUS_MICRO;
-		return IIO_AVAIL_LIST;
+		return iio_gts_avail_times(&data->gts, vals, type, length);
 	case IIO_CHAN_INFO_SCALE:
-		*vals = (int *)*data->chip->scale_vals;
-		*length = 2 * data->chip->num_scale_vals;
-		*type = IIO_VAL_INT_PLUS_MICRO;
-		return IIO_AVAIL_LIST;
+		return iio_gts_all_avail_scales(&data->gts, vals, type, length);
 	}
 
 	return -EINVAL;
@@ -826,13 +722,25 @@ static int veml6030_write_raw(struct iio_dev *indio_dev,
 				struct iio_chan_spec const *chan,
 				int val, int val2, long mask)
 {
-	struct veml6030_data *data = iio_priv(indio_dev);
-
 	switch (mask) {
 	case IIO_CHAN_INFO_INT_TIME:
-		return veml6030_set_intgrn_tm(indio_dev, val, val2);
+		return veml6030_set_it(indio_dev, val, val2);
+	case IIO_CHAN_INFO_SCALE:
+		return veml6030_set_scale(indio_dev, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int veml6030_write_raw_get_fmt(struct iio_dev *indio_dev,
+				      struct iio_chan_spec const *chan,
+				      long mask)
+{
+	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
-		return data->chip->set_als_gain(indio_dev, val, val2);
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_INT_TIME:
+		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
 	}
@@ -930,6 +838,7 @@ static const struct iio_info veml6030_info = {
 	.read_raw  = veml6030_read_raw,
 	.read_avail  = veml6030_read_avail,
 	.write_raw = veml6030_write_raw,
+	.write_raw_get_fmt = veml6030_write_raw_get_fmt,
 	.read_event_value = veml6030_read_event_val,
 	.write_event_value	= veml6030_write_event_val,
 	.read_event_config = veml6030_read_interrupt_config,
@@ -941,6 +850,7 @@ static const struct iio_info veml6030_info_no_irq = {
 	.read_raw  = veml6030_read_raw,
 	.read_avail  = veml6030_read_avail,
 	.write_raw = veml6030_write_raw,
+	.write_raw_get_fmt = veml6030_write_raw_get_fmt,
 };
 
 static irqreturn_t veml6030_event_handler(int irq, void *private)
@@ -1066,6 +976,13 @@ static int veml6030_hw_init(struct iio_dev *indio_dev, struct device *dev)
 	int ret, val;
 	struct veml6030_data *data = iio_priv(indio_dev);
 
+	ret = devm_iio_init_iio_gts(dev, 2, 150400000,
+				    veml6030_gain_sel, ARRAY_SIZE(veml6030_gain_sel),
+				    veml6030_it_sel, ARRAY_SIZE(veml6030_it_sel),
+				    &data->gts);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to init iio gts\n");
+
 	ret = veml6030_als_shut_down(data);
 	if (ret)
 		return dev_err_probe(dev, ret, "can't shutdown als\n");
@@ -1101,11 +1018,6 @@ static int veml6030_hw_init(struct iio_dev *indio_dev, struct device *dev)
 		return dev_err_probe(dev, ret,
 				     "can't clear als interrupt status\n");
 
-	/* Cache currently active measurement parameters */
-	data->cur_gain = 3;
-	data->cur_resolution = 5376;
-	data->cur_integration_time = 3;
-
 	return ret;
 }
 
@@ -1121,6 +1033,13 @@ static int veml6035_hw_init(struct iio_dev *indio_dev, struct device *dev)
 	int ret, val;
 	struct veml6030_data *data = iio_priv(indio_dev);
 
+	ret = devm_iio_init_iio_gts(dev, 0, 409600000,
+				    veml6035_gain_sel, ARRAY_SIZE(veml6035_gain_sel),
+				    veml6030_it_sel, ARRAY_SIZE(veml6030_it_sel),
+				    &data->gts);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to init iio gts\n");
+
 	ret = veml6030_als_shut_down(data);
 	if (ret)
 		return dev_err_probe(dev, ret, "can't shutdown als\n");
@@ -1157,11 +1076,6 @@ static int veml6035_hw_init(struct iio_dev *indio_dev, struct device *dev)
 		return dev_err_probe(dev, ret,
 				     "can't clear als interrupt status\n");
 
-	/* Cache currently active measurement parameters */
-	data->cur_gain = 5;
-	data->cur_resolution = 1024;
-	data->cur_integration_time = 3;
-
 	return 0;
 }
 
@@ -1257,44 +1171,35 @@ static DEFINE_RUNTIME_DEV_PM_OPS(veml6030_pm_ops, veml6030_runtime_suspend,
 
 static const struct veml603x_chip veml6030_chip = {
 	.name = "veml6030",
-	.scale_vals = &veml6030_scale_vals,
-	.num_scale_vals = ARRAY_SIZE(veml6030_scale_vals),
 	.channels = veml6030_channels,
 	.num_channels = ARRAY_SIZE(veml6030_channels),
 	.gain_rf = VEML6030_GAIN_RF,
 	.it_rf = VEML6030_IT_RF,
+	.max_scale = VEML6030_MAX_SCALE,
 	.hw_init = veml6030_hw_init,
 	.set_info = veml6030_set_info,
-	.set_als_gain = veml6030_set_als_gain,
-	.get_als_gain = veml6030_get_als_gain,
 };
 
 static const struct veml603x_chip veml6035_chip = {
 	.name = "veml6035",
-	.scale_vals = &veml6035_scale_vals,
-	.num_scale_vals = ARRAY_SIZE(veml6035_scale_vals),
 	.channels = veml6030_channels,
 	.num_channels = ARRAY_SIZE(veml6030_channels),
 	.gain_rf = VEML6035_GAIN_RF,
 	.it_rf = VEML6030_IT_RF,
+	.max_scale = VEML6035_MAX_SCALE,
 	.hw_init = veml6035_hw_init,
 	.set_info = veml6030_set_info,
-	.set_als_gain = veml6035_set_als_gain,
-	.get_als_gain = veml6035_get_als_gain,
 };
 
 static const struct veml603x_chip veml7700_chip = {
 	.name = "veml7700",
-	.scale_vals = &veml6030_scale_vals,
-	.num_scale_vals = ARRAY_SIZE(veml6030_scale_vals),
 	.channels = veml7700_channels,
 	.num_channels = ARRAY_SIZE(veml7700_channels),
 	.gain_rf = VEML6030_GAIN_RF,
 	.it_rf = VEML6030_IT_RF,
+	.max_scale = VEML6030_MAX_SCALE,
 	.hw_init = veml6030_hw_init,
 	.set_info = veml7700_set_info,
-	.set_als_gain = veml6030_set_als_gain,
-	.get_als_gain = veml6030_get_als_gain,
 };
 
 static const struct of_device_id veml6030_of_match[] = {
@@ -1336,3 +1241,4 @@ module_i2c_driver(veml6030_driver);
 MODULE_AUTHOR("Rishi Gupta <gupt21@gmail.com>");
 MODULE_DESCRIPTION("VEML6030 Ambient Light Sensor");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("IIO_GTS_HELPER");

-- 
2.43.0


