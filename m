Return-Path: <linux-iio+bounces-8077-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD639426FC
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 08:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF6FC1C211E7
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 06:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B7916C695;
	Wed, 31 Jul 2024 06:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jp/patP2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB06A16D4E0;
	Wed, 31 Jul 2024 06:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722407848; cv=none; b=Xac7K12xaH5XjYrH379tdbEvtWDC2YZsWo2WOZRsSrczjcmutYqh97aQwwZ7sepWvl9UrTw1XADkZJZ5by3de0ucgY3uI1LQdcPM4myIq53AbrYQv0sc6VsgZAQiJdYi1+8AUkC23O8lc5Xw17C2r9cNmWr4VO6hu3cWDnBOCrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722407848; c=relaxed/simple;
	bh=lVtZ+oApslVLsltgzqjCPLzhDTDpeQDuXQpluuf1Sb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9cfPZK/9IkFjSfsqEPb55nkrizqGVwMN6AzMYfWksTuqZVlc0Z0+0bQ6j/j+i/KLe4J6oJEclOQnsAEQAJP6p1wbh0MM0YkWieNj4aqE317ii19Gd5dQdycBAQdD7Mdt/hHhxbkALomUhjNhwgUHt5pBrUvzS+gb1RESmiqjHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jp/patP2; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc65329979so43862135ad.0;
        Tue, 30 Jul 2024 23:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722407845; x=1723012645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLmTWNCcO33qyoawnApG+TtbPb4Atzj5qDibWR/TR3U=;
        b=jp/patP211br8dXt0a6GgsMyCHxzIYmsATSFoCBOgrL4owm9q3ggVkf9ecgM6mzCst
         P4/+b04yFW3sZ13+421n08oD/hJeuRSBXc/EKoHKLCHI33MUIyibgcHsnZPVwDVS5hHP
         fPs6i1k4Dpu6cBEzwawXtF6D0nrUqP8TPSEBq03954QqJnTEiJ0zPHyBUaxHF9dbsqfF
         ccu8iCa00rsXRytFy9yMICufqNtSWdaIwdfeIAyWqmnlQWkU4wLfBAj9JG8zfCFHmOiN
         f51s0Aw7Jy1sUjzx1Xxt4Xq2vThNbvb0ECx7o+Yfx/pirzZyURCKpO6iwWCeuUYIAXMj
         CylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722407845; x=1723012645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLmTWNCcO33qyoawnApG+TtbPb4Atzj5qDibWR/TR3U=;
        b=fpAN0L8L/QfoQTRb07tRCaMrKMLlAeAQsRwGeMLymbqJwH8zwahwn7PWQY1JITLtHQ
         z0jWj/KAuxi4KVIFzQzaNWf1ZWmwlrCWO21PGLB/uQZoZ79UObvFaz5iOTnc+F6rMQGC
         pxTULskwoEzzl7k+bNjGrfHE41qX5kd2Etx/q36nWicZU0mbmYiL2uKYOBQRR45gxppq
         VjHvOaInoT4yq67q8BhX7b2YG87Z2qJjtqKO89JC9h/XESMX/pgh8DydFSquzVQrnKft
         2N98LZqWfKFjbHYV5qSBCi9vgX/r8E8rAEnmi5yIdquccS5A0L+wxb21DIt72dgr2Iox
         55qg==
X-Forwarded-Encrypted: i=1; AJvYcCWhjZLqpIcuG5eNGrFDkwWM9iElksNaJVW+IjmAb9zWY/VJqWnxwM0qqUk1rhvyBPs7T60ddBM3cg1L4SShfBbdX0uSw5KtZMTOAcdK
X-Gm-Message-State: AOJu0YwQGv4qHBtmfcophb1YQ+bo9Nzaw7WxDQy7r7vL6tRTyaKcYor3
	2TuCVSkMTm6D2noLujlhq0rQFt0/0uAPfjfI23QrmFR+vhwBhKFU4GqsZyzglSgywA==
X-Google-Smtp-Source: AGHT+IENFgRRLL+b17zMlU0bkoby/GHGL6sRHqQXQZYtY/mXkBGO/1hNuBDLk4h4U4gIZ8MvVfhJqQ==
X-Received: by 2002:a17:902:f809:b0:1fc:2e36:511a with SMTP id d9443c01a7336-1ff04823e4bmr147205595ad.14.1722407844862;
        Tue, 30 Jul 2024 23:37:24 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fed7ee4ce6sm113164905ad.157.2024.07.30.23.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 23:37:23 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v5 1/3] iio: light: ltr390: Add configurable gain and resolution
Date: Wed, 31 Jul 2024 12:07:03 +0530
Message-ID: <20240731063706.25412-2-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240731063706.25412-1-abhashkumarjha123@gmail.com>
References: <20240731063706.25412-1-abhashkumarjha123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for configuring and reading the gain and resolution
(integration time). Also provide the available values for gain and
resoltion respectively via `read_avail` callback.

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/light/ltr390.c | 136 ++++++++++++++++++++++++++++++++++---
 1 file changed, 125 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index fff1e8990..ee3d30075 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -23,21 +23,29 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/regmap.h>
+#include <linux/bitfield.h>
 
 #include <linux/iio/iio.h>
 
 #include <asm/unaligned.h>
 
-#define LTR390_MAIN_CTRL      0x00
-#define LTR390_PART_ID	      0x06
-#define LTR390_UVS_DATA	      0x10
+#define LTR390_MAIN_CTRL		0x00
+#define LTR390_ALS_UVS_MEAS_RATE	0x04
+#define LTR390_ALS_UVS_GAIN		0x05
+#define LTR390_PART_ID			0x06
+#define LTR390_ALS_DATA			0x0D
+#define LTR390_UVS_DATA			0x10
+#define LTR390_INT_CFG			0x19
+
+#define LTR390_PART_NUMBER_ID		0xb
+#define LTR390_ALS_UVS_GAIN_MASK	0x07
+#define LTR390_ALS_UVS_INT_TIME_MASK	0x70
+#define LTR390_ALS_UVS_INT_TIME(x)	FIELD_PREP(LTR390_ALS_UVS_INT_TIME_MASK, (x))
 
 #define LTR390_SW_RESET	      BIT(4)
 #define LTR390_UVS_MODE	      BIT(3)
 #define LTR390_SENSOR_ENABLE  BIT(1)
 
-#define LTR390_PART_NUMBER_ID 0xb
-
 /*
  * At 20-bit resolution (integration time: 400ms) and 18x gain, 2300 counts of
  * the sensor are equal to 1 UV Index [Datasheet Page#8].
@@ -60,6 +68,8 @@ struct ltr390_data {
 	struct i2c_client *client;
 	/* Protects device from simulataneous reads */
 	struct mutex lock;
+	int gain;
+	int int_time_us;
 };
 
 static const struct regmap_config ltr390_regmap_config = {
@@ -75,8 +85,6 @@ static int ltr390_register_read(struct ltr390_data *data, u8 register_address)
 	int ret;
 	u8 recieve_buffer[3];
 
-	guard(mutex)(&data->lock);
-
 	ret = regmap_bulk_read(data->regmap, register_address, recieve_buffer,
 			       sizeof(recieve_buffer));
 	if (ret) {
@@ -94,6 +102,7 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
 	int ret;
 	struct ltr390_data *data = iio_priv(iio_device);
 
+	guard(mutex)(&data->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		ret = ltr390_register_read(data, LTR390_UVS_DATA);
@@ -105,18 +114,118 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
 		*val = LTR390_WINDOW_FACTOR;
 		*val2 = LTR390_COUNTS_PER_UVI;
 		return IIO_VAL_FRACTIONAL;
+
+	case IIO_CHAN_INFO_INT_TIME:
+		*val = data->int_time_us;
+		return IIO_VAL_INT;
+
 	default:
 		return -EINVAL;
 	}
 }
 
-static const struct iio_info ltr390_info = {
-	.read_raw = ltr390_read_raw,
-};
+/* integration time in us */
+static const int ltr390_int_time_map_us[] = { 400000, 200000, 100000, 50000, 25000, 12500 };
+static const int ltr390_gain_map[] = { 1, 3, 6, 9, 18 };
 
 static const struct iio_chan_spec ltr390_channel = {
 	.type = IIO_UVINDEX,
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE)
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+	.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SCALE)
+};
+
+static int ltr390_set_gain(struct ltr390_data *data, int val)
+{
+	int ret, idx;
+
+	for (idx = 0; idx < ARRAY_SIZE(ltr390_gain_map); idx++) {
+		if (ltr390_gain_map[idx] != val)
+			continue;
+
+		guard(mutex)(&data->lock);
+		ret = regmap_update_bits(data->regmap,
+					LTR390_ALS_UVS_GAIN,
+					LTR390_ALS_UVS_GAIN_MASK, idx);
+		if (ret)
+			return ret;
+
+		data->gain = ltr390_gain_map[idx];
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int ltr390_set_int_time(struct ltr390_data *data, int val)
+{
+	int ret, idx;
+
+	for (idx = 0; idx < ARRAY_SIZE(ltr390_int_time_map_us); idx++) {
+		if (ltr390_int_time_map_us[idx] != val)
+			continue;
+
+		guard(mutex)(&data->lock);
+		ret = regmap_update_bits(data->regmap,
+					LTR390_ALS_UVS_MEAS_RATE,
+					LTR390_ALS_UVS_INT_TIME_MASK,
+					LTR390_ALS_UVS_INT_TIME(idx));
+		if (ret)
+			return ret;
+
+		data->int_time_us = ltr390_int_time_map_us[idx];
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int ltr390_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+				const int **vals, int *type, int *length, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*length = ARRAY_SIZE(ltr390_gain_map);
+		*type = IIO_VAL_INT;
+		*vals = ltr390_gain_map;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_INT_TIME:
+		*length = ARRAY_SIZE(ltr390_int_time_map_us);
+		*type = IIO_VAL_INT;
+		*vals = ltr390_int_time_map_us;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ltr390_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+				int val, int val2, long mask)
+{
+	struct ltr390_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		if (val2 != 0)
+			return -EINVAL;
+
+		return ltr390_set_gain(data, val);
+
+	case IIO_CHAN_INFO_INT_TIME:
+		if (val2 != 0)
+			return -EINVAL;
+
+		return ltr390_set_int_time(data, val);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info ltr390_info = {
+	.read_raw = ltr390_read_raw,
+	.write_raw = ltr390_write_raw,
+	.read_avail = ltr390_read_avail,
 };
 
 static int ltr390_probe(struct i2c_client *client)
@@ -139,6 +248,11 @@ static int ltr390_probe(struct i2c_client *client)
 				     "regmap initialization failed\n");
 
 	data->client = client;
+	/* default value of integration time from pg: 15 of the datasheet */
+	data->int_time_us = 100000;
+	/* default value of gain from pg: 16 of the datasheet */
+	data->gain = 3;
+
 	mutex_init(&data->lock);
 
 	indio_dev->info = &ltr390_info;
-- 
2.43.0


