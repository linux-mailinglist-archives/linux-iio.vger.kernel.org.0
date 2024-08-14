Return-Path: <linux-iio+bounces-8463-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F9A9519EE
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 13:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D312F281E22
	for <lists+linux-iio@lfdr.de>; Wed, 14 Aug 2024 11:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B7D1AED55;
	Wed, 14 Aug 2024 11:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="El6UVU0I"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F4F1AED4F;
	Wed, 14 Aug 2024 11:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723635146; cv=none; b=Ydlyj2kHEpwgJJbrGDzGSvrX26+Ge3dTkgEm4zayEyKBUbYuHxan1RuY/5lWCQmaAgbYtL61/6d26JQdnBWXQnOPSAvdGt5meGlKX8uOTSEYn9z9m8CG8+BLA4gDy3tYWwpl98DAcjiGgEvWWDy1/mkqSCnEWtSCv7rgwfWT9dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723635146; c=relaxed/simple;
	bh=iTgm4KVbZ83RShGklvWiqF7/wrRGgUpSPoamNO5kGSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lX5DcLFNv+zNecNnGjRnzAB9zEMjixHgG+W9uJ95IvmLyEnFw9zATHN2zIkBxBB09YgFh/fsR3t7uEjJRGjfKi5DBi/CPwUfxyUDbYdWo7H9WOJ4rFWRFTqelsc9FbQd4H1hnvXgrSc4V0p/QTipyvuOS7Fjxiq9YtecMel9mRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=El6UVU0I; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70d2b921cd1so5957130b3a.1;
        Wed, 14 Aug 2024 04:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723635143; x=1724239943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGTggqeFbnEsrXeAYf0Jl9pDsVDSYtOHnJDsYaO/zck=;
        b=El6UVU0IoZEJCXeuvJucmBH18eK5+/0ZJ152gxVoiYnWtGMqk1W07aJJaMeC+yJQVW
         WWQmRJ1IinsfcCISnGF+cEs4lAXajJo65YFrq/dWRHHwsNdEXt9UJ+0X1DteS8NDXr3U
         nepyZF/oiajI8+2q5pRXolO83pjBn1W5fUf5Xt5gBesRCDWLCEbLK/0l+5UIp+3vViEU
         LtTB/vsksG1bmSS3tfZ1dhApvxtWgd+escq4/DXaALddO/ZGn0uFSQxoX3XW+EHNLyYn
         p95ElcvcyoloTIEcQm7RigAkqn7Gzz+mP0VOe+e1xUcEemREqn3GobeOO3F9fpVQPj31
         /xDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723635143; x=1724239943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGTggqeFbnEsrXeAYf0Jl9pDsVDSYtOHnJDsYaO/zck=;
        b=WPkfjiMxInjYSVF4niBm+hWbMoyUxELY1KIUWUnI2R2ZA3qIL+S9SpojtEU6lBy8vi
         NT6sYCmqvUlsfaSxs46XVI5f/fArEjvfzP5VbsPfG+lpaczPyPmtpdO7/T3j392j2nVy
         6s4xvNpbyojDxIo/hL9KzbY8oc+HY65CZ2Am93xjMQc759V/WPlS4GepdENCiaxdVE8o
         YbE4/U2VbDm1Nws1uXA7ovkzJE+5P0aXZDIUv6z2mOmdSrACz+fTfLNNUOIHZVlyXMfu
         8WlRYi/PS6UlWUdoKWvbSLMO6vlxuLYUP3uTMM9F2tHD+jwMPpVk0JT2rPCTaTfdZxlD
         LydQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2TVhiGVpnIWXkAIiZgoKWWcwVJuQYv4No98QytYoc2v6XF/2u0RTmVViS9ypI5NgqZskGjf6WqRt6Dd1eEzpCOyuegqTaEpFRzlQa
X-Gm-Message-State: AOJu0Ywhe4KW3yO7fFgrvBgSFNfEH+Yj+honOVXx8dCwT+wT8rCFPnD+
	qnA3jgmBcTOSAQSILkxgzk3s0qzFrEa1r0PR+3WoKq5/QfqUrw99EBdxK/p3IVnn6Q==
X-Google-Smtp-Source: AGHT+IFOgHa5zVtZ5gv5XCeOWXcsbzF8NwszwAlSCT35fo22rqPOX/b/aiYWhYsOPIBeHx0hOXFtIQ==
X-Received: by 2002:a05:6a20:2d2c:b0:1c4:6709:9083 with SMTP id adf61e73a8af0-1c8eae2ea5fmr3559239637.10.1723635142932;
        Wed, 14 Aug 2024 04:32:22 -0700 (PDT)
Received: from abhash-IdeaPad-L340-15IRH-Gaming.. ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d3ac7e80e5sm1467434a91.17.2024.08.14.04.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 04:32:21 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v7 1/2] iio: light: ltr390: Add ALS channel and support for gain and resolution
Date: Wed, 14 Aug 2024 17:01:33 +0530
Message-ID: <20240814113135.14575-2-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240814113135.14575-1-abhashkumarjha123@gmail.com>
References: <20240814113135.14575-1-abhashkumarjha123@gmail.com>
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


