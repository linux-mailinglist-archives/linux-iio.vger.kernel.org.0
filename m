Return-Path: <linux-iio+bounces-8235-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15EE946F4B
	for <lists+linux-iio@lfdr.de>; Sun,  4 Aug 2024 16:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A87CC281A04
	for <lists+linux-iio@lfdr.de>; Sun,  4 Aug 2024 14:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CDF59167;
	Sun,  4 Aug 2024 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TP7yggd5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DA539FC6;
	Sun,  4 Aug 2024 14:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722781427; cv=none; b=TFmMojSMSiZFB6OKqypEc9uh39iNmx7A+6HNWtF1UIEX8YtZT47GYHCpoxGpToDdZgel5eoHtu7oz8dUBE2GBWq+VPRmoDkWrApifPk5w6VL3AWCBFAhffO1qor5JCpcN5t2oXJgrKSBqCDB0TcU0szc4e1GsqGsjGiIOYc50ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722781427; c=relaxed/simple;
	bh=iTgm4KVbZ83RShGklvWiqF7/wrRGgUpSPoamNO5kGSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGAXbSs71qLpjScRrCa+pgcvMwMCxsn9J2Tfiw0inGQgC+BQ0i7eeEmQOamDNDSQQ8AdxCMWeSDn/1az6VuuXaaQvV1qdE1t3oj51ZdRjSoqkp/a18RyeQbamFVs34vJZxhm3H4oJGqHoBau4LFZN/4FyibP1bdmkIw1siufH8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TP7yggd5; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fc66fc35f2so33513295ad.0;
        Sun, 04 Aug 2024 07:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722781424; x=1723386224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGTggqeFbnEsrXeAYf0Jl9pDsVDSYtOHnJDsYaO/zck=;
        b=TP7yggd51k19L3WCggUO251bcc0341zX+vclLkb6+sYA3zVTJBDTpq8yCKM8qP+gHe
         9++1aLeMxCwhluzifjEcPMeOHq7qMyfBg8w7ik7EhQ1FfUVE1Nb6m2JgopyvHuAmszf/
         4tdMTL6+ZEBGinK61OcwroMlHqYWpL46G3C5YjxKJqNNYNrxN9w8Px5QI2q2SE6HjgP2
         Aj0J7VExy8Z6gmO89xGZBNn1Mh6rcP9rjcRVKNk3Mp+TbRDqTMDtOh9GNcmjI5IoWIpv
         PZQGQSIv18YjTUZ5bLLXntbV/SCk6ta6yS6yCe61RCijz+YLmDdL958QljwHEuqzB/Wh
         5zGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722781424; x=1723386224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGTggqeFbnEsrXeAYf0Jl9pDsVDSYtOHnJDsYaO/zck=;
        b=Rcf4/QA71fCl61HgJ9BOqqH8kLcDblZpmzlCd6tJ5qEHLYJ0iU9ImT1hjoRbEUcT15
         fNlMUs1r1ps+TRhG5FS22hqCic7ecQgkcJlyEZEtS+9HKkngnTPr632kN5bOEd3s2hoF
         ftUKxk8OJLvc31leh+SkYYhth/yq6Dil0bulL6wGHyvWURV/O0pCps6jJgEj0jahxWqe
         e7l18cCa20eKwV444zX9ZHBTaS2jElQV1ukYoC1CEFmKb5ywXn6g2xniP+74v79/OWRH
         x0Qvq3b5dqcvkEb6UKQakmaLdxP+D7iPiYNJ66q5mpikEDQA4Q8k4dqMKTWshf9Ifhjp
         0MXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5rX47PyVye3k9ajDFSpkAub8gmb4LlmV+zdBnfHI9L3NvAOQ8Q+URKSF5ceA5KOOVW+HDiEqfbANJ589f6FxjFf9ZI/8mePcSQbvO
X-Gm-Message-State: AOJu0YyLyFjQgsEt0/DyugomGV3qIEI/ZX1RcMsEPoiXSb+xiiXWnKS6
	jyUjcX2rTg0RKrkk/yfXQ+5lgvYuuBrkFPtEgVSqBeIn+OCP5e1+c9IKJWOqdZkUsQ==
X-Google-Smtp-Source: AGHT+IE0M/ywIYMkBhPVrsunQLO91vcuFOoRPaptdY+ljIJvEwH0QSQANexJvPhNfcuFeXUiQnjzew==
X-Received: by 2002:a17:902:ea02:b0:1fd:6581:93c5 with SMTP id d9443c01a7336-1ff524afe2bmr174309835ad.27.1722781424417;
        Sun, 04 Aug 2024 07:23:44 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ff59293a90sm49735375ad.235.2024.08.04.07.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 07:23:43 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v7 1/2] iio: light: ltr390: Add ALS channel and support for gain and resolution
Date: Sun,  4 Aug 2024 19:53:20 +0530
Message-ID: <20240804142321.54586-2-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240804142321.54586-1-abhashkumarjha123@gmail.com>
References: <20240804142321.54586-1-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new ALS channel and allow reading lux and scale values.
Also provide gain and resolution configuration for ALS channel.
Add automatic mode switching between the UVS and ALS channel
based on which channel is being accessed.
The default mode in which the sensor start is ALS mode.

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/light/ltr390.c | 105 +++++++++++++++++++++++++++++++------
 1 file changed, 90 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index ee3d30075..16e06f2ab 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -63,11 +63,17 @@
  */
 #define LTR390_WINDOW_FACTOR 1
 
+enum ltr390_mode {
+	LTR390_SET_ALS_MODE,
+	LTR390_SET_UVS_MODE,
+};
+
 struct ltr390_data {
 	struct regmap *regmap;
 	struct i2c_client *client;
 	/* Protects device from simulataneous reads */
 	struct mutex lock;
+	enum ltr390_mode mode;
 	int gain;
 	int int_time_us;
 };
@@ -95,6 +101,30 @@ static int ltr390_register_read(struct ltr390_data *data, u8 register_address)
 	return get_unaligned_le24(recieve_buffer);
 }
 
+static int ltr390_set_mode(struct ltr390_data *data, enum ltr390_mode mode)
+{
+	int ret;
+
+	if (data->mode == mode)
+		return 0;
+
+	switch (mode) {
+	case LTR390_SET_ALS_MODE:
+		ret = regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_UVS_MODE);
+		break;
+
+	case LTR390_SET_UVS_MODE:
+		ret = regmap_set_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_UVS_MODE);
+		break;
+	}
+
+	if (ret)
+		return ret;
+
+	data->mode = mode;
+	return 0;
+}
+
 static int ltr390_read_raw(struct iio_dev *iio_device,
 			   struct iio_chan_spec const *chan, int *val,
 			   int *val2, long mask)
@@ -105,15 +135,47 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
 	guard(mutex)(&data->lock);
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
+			ret = ltr390_register_read(data, LTR390_UVS_DATA);
+			if (ret < 0)
+				return ret;
+			break;
+
+		case IIO_LIGHT:
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
+			return -EINVAL;
+		}
 		*val = ret;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		*val = LTR390_WINDOW_FACTOR;
-		*val2 = LTR390_COUNTS_PER_UVI;
-		return IIO_VAL_FRACTIONAL;
+		switch (chan->type) {
+		case IIO_UVINDEX:
+			*val = LTR390_WINDOW_FACTOR;
+			*val2 = LTR390_COUNTS_PER_UVI;
+			return IIO_VAL_FRACTIONAL;
+
+		case IIO_LIGHT:
+			*val = LTR390_WINDOW_FACTOR * 6 * 100;
+			*val2 = data->gain * data->int_time_us;
+			return IIO_VAL_FRACTIONAL;
+
+		default:
+			return -EINVAL;
+		}
 
 	case IIO_CHAN_INFO_INT_TIME:
 		*val = data->int_time_us;
@@ -128,11 +190,23 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
 static const int ltr390_int_time_map_us[] = { 400000, 200000, 100000, 50000, 25000, 12500 };
 static const int ltr390_gain_map[] = { 1, 3, 6, 9, 18 };
 
-static const struct iio_chan_spec ltr390_channel = {
-	.type = IIO_UVINDEX,
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
-	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
-	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SCALE)
+static const struct iio_chan_spec ltr390_channels[] = {
+	/* UV sensor */
+	{
+		.type = IIO_UVINDEX,
+		.scan_index = 0,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SCALE)
+	},
+	/* ALS sensor */
+	{
+		.type = IIO_LIGHT,
+		.scan_index = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SCALE)
+	},
 };
 
 static int ltr390_set_gain(struct ltr390_data *data, int val)
@@ -252,12 +326,14 @@ static int ltr390_probe(struct i2c_client *client)
 	data->int_time_us = 100000;
 	/* default value of gain from pg: 16 of the datasheet */
 	data->gain = 3;
+	/* default mode for ltr390 is ALS mode */
+	data->mode = LTR390_SET_ALS_MODE;
 
 	mutex_init(&data->lock);
 
 	indio_dev->info = &ltr390_info;
-	indio_dev->channels = &ltr390_channel;
-	indio_dev->num_channels = 1;
+	indio_dev->channels = ltr390_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ltr390_channels);
 	indio_dev->name = "ltr390";
 
 	ret = regmap_read(data->regmap, LTR390_PART_ID, &part_number);
@@ -275,8 +351,7 @@ static int ltr390_probe(struct i2c_client *client)
 	/* Wait for the registers to reset before proceeding */
 	usleep_range(1000, 2000);
 
-	ret = regmap_set_bits(data->regmap, LTR390_MAIN_CTRL,
-			      LTR390_SENSOR_ENABLE | LTR390_UVS_MODE);
+	ret = regmap_set_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_SENSOR_ENABLE);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to enable the sensor\n");
 
-- 
2.43.0


