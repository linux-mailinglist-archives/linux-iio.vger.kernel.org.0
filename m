Return-Path: <linux-iio+bounces-7993-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AC893E5CA
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 17:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609E71F21254
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 15:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF515103F;
	Sun, 28 Jul 2024 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVnGz3xz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C593FE55;
	Sun, 28 Jul 2024 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722180036; cv=none; b=iaAxROtq45wjYThONd5sVY5LVjeVsiYwyC1ExYq1l9lVGsJJcMWY3miqMkDAVqfY7OxxA/9S/oeRCR6CYtTK2w1xXFVYEiaMx8pX2NfKfGXMARnWTbHcUd1DoTXMtBgoDy37xvBxq+SjeZXRaTZJdns96ErMJ4bJo4WyhNbvPvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722180036; c=relaxed/simple;
	bh=ZPZYOty7vPmPbDULQH68zaMGkRk3k6rDM+cb0rI0Bq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JaBoSjYKID4gRghzuLqaah6Mm21I2PnZpt6vdlot5zOaf7kfzJlqYyIn98v9B3XL6C0ZxxYoD98xUBbJdlD2DmG6lkiwM48lbnANe+yKhHzSIeVfq2Xtx3XTGrSt2LhfT/q9PfO7lzI8lFVySmVsFxyhzJ18IVBn1aW6wbcXFIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVnGz3xz; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-260f81f7fb5so1693002fac.0;
        Sun, 28 Jul 2024 08:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722180033; x=1722784833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWQtmbGLpCfa96+iJ2bZelo/zIhpTzAVTxEvyYUKtuw=;
        b=CVnGz3xzDOw60sNHquAGRUtG5+CEbLX7lTN5rRLl1r+WRR93GQ968mz+q7HrNJTkCB
         GDZOJhq7tbq9tMe3sRb4iIOnkttPokNrSOaS0hmrwOQ4L4Y/YnghhK9qgBQhILASNfkN
         fkXxEleEWaydJrY7yIc1lzgDaUtGtlmJh7SjJRvz4HTXXcfGe6dj9D6w11Hlmx56ZyJ/
         oBh900hTFnzmhKBlNEZT5K70vkK/S+zj+6Gr1cDG2t/pURv4PA2WroHm3CO8M9a2Vocp
         UGY///Fw31MkvJ1v8jK7GtFlOUA+TG53v4RnwpLJLiRAwtJHjXlW2G69zgvoD2N9UYBv
         7bEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722180033; x=1722784833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWQtmbGLpCfa96+iJ2bZelo/zIhpTzAVTxEvyYUKtuw=;
        b=viboUSlpH+z0oL2LGq9Wz39O0+1I03+4REcdzlriADQXoRbUkZWoAOLKFVR8C3+Loe
         ob5ttoi1ZVJyN/uD3+U1R9b6YW9+UZ784ITsseC7Khj5YGQ+hp1LZLMv7XW2vaskDzWE
         89aOnGQL4NJJAwYYqhP/YUPcKzXQjLidsn4qBzff6i//RUcBxBHykPFun/8BQ9vIcSNs
         2ydE61LJeDF+rFt5GGu0Cyr6CJ/1c5mwkwDzsu9vqF3vfhz9KvC+xSj+ZOlVFJcY4fJt
         0GBUP9Ie6zZnFDWPwuamLT8IPo4asRbRRfBrREsYiYfnilAdOzsDuV3K2K1QeIEoKe8o
         LooA==
X-Forwarded-Encrypted: i=1; AJvYcCWV5rKcOPi+xa7xlk5ZW9PT3ACFuxdRoIeCZxpcUMj0pqoQZ0oCHUrpCeu9RnlT/JDNPzGLzrV03CKcGOI6Qh/GdWz+lQhCWd/8rvPv
X-Gm-Message-State: AOJu0YzuqyRJ10RqqzIWO4rZhRWXJy9Z8Gd0QLD2B5xTpFWou0RH1prx
	2++J8XYduunqGvZ/s+DG2VLQ2DBV6urS+Os6wyFEslv8ryOy8+z8onM2Sq1sXAfx6Q==
X-Google-Smtp-Source: AGHT+IEpPtXHu6qzEmt8Wunqu7lAMY3sRPrB7NPAe2eoRjYtzBRDjKSOQpjYKSgvDDr9tbU0K7RkTQ==
X-Received: by 2002:a05:6871:58a:b0:254:b74e:d654 with SMTP id 586e51a60fabf-267d4d8ed02mr4938255fac.22.1722180032985;
        Sun, 28 Jul 2024 08:20:32 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7a9f817aebasm5836843a12.28.2024.07.28.08.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 08:20:32 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v2 1/3] iio: light: ltr390: Add configurable gain and resolution
Date: Sun, 28 Jul 2024 20:49:54 +0530
Message-ID: <20240728151957.310237-1-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240727132735.052502ad@jic23-huawei>
References: <20240727132735.052502ad@jic23-huawei>
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
 drivers/iio/light/ltr390.c | 144 +++++++++++++++++++++++++++++++++----
 1 file changed, 130 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index fff1e8990..9f00661c3 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -25,19 +25,26 @@
 #include <linux/regmap.h>
 
 #include <linux/iio/iio.h>
-
+#include <linux/iio/sysfs.h>
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
+#define LTR390_ALS_UVS_INT_TIME(x)	FIELD_PREP(LTR390_ALS_UVS_INT_TIME_MASK, x)
 
 #define LTR390_SW_RESET	      BIT(4)
 #define LTR390_UVS_MODE	      BIT(3)
 #define LTR390_SENSOR_ENABLE  BIT(1)
 
-#define LTR390_PART_NUMBER_ID 0xb
-
 /*
  * At 20-bit resolution (integration time: 400ms) and 18x gain, 2300 counts of
  * the sensor are equal to 1 UV Index [Datasheet Page#8].
@@ -60,6 +67,8 @@ struct ltr390_data {
 	struct i2c_client *client;
 	/* Protects device from simulataneous reads */
 	struct mutex lock;
+	int gain;
+	int int_time_us;
 };
 
 static const struct regmap_config ltr390_regmap_config = {
@@ -75,8 +84,6 @@ static int ltr390_register_read(struct ltr390_data *data, u8 register_address)
 	int ret;
 	u8 recieve_buffer[3];
 
-	guard(mutex)(&data->lock);
-
 	ret = regmap_bulk_read(data->regmap, register_address, recieve_buffer,
 			       sizeof(recieve_buffer));
 	if (ret) {
@@ -91,32 +98,135 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
 			   struct iio_chan_spec const *chan, int *val,
 			   int *val2, long mask)
 {
-	int ret;
 	struct ltr390_data *data = iio_priv(iio_device);
+	int ret;
 
+	guard(mutex)(&data->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		ret = ltr390_register_read(data, LTR390_UVS_DATA);
 		if (ret < 0)
 			return ret;
+
 		*val = ret;
 		return IIO_VAL_INT;
+
 	case IIO_CHAN_INFO_SCALE:
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
+static const int ltr390_int_time_map_us[] = {400000, 200000, 100000, 50000, 25000, 12500};
+static const int ltr390_gain_map[] = {1, 3, 6, 9, 18};
 
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
+		break;
+	}
+
+	return 0;
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
+		break;
+	}
+
+	return 0;
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
@@ -139,6 +249,11 @@ static int ltr390_probe(struct i2c_client *client)
 				     "regmap initialization failed\n");
 
 	data->client = client;
+	/* default value of integration time from pg: 15 of the datasheet */
+	data->int_time_us = 100000;
+	/* default value of gain from pg: 16 of the datasheet */
+	data->gain = 3;
+
 	mutex_init(&data->lock);
 
 	indio_dev->info = &ltr390_info;
@@ -162,7 +277,7 @@ static int ltr390_probe(struct i2c_client *client)
 	usleep_range(1000, 2000);
 
 	ret = regmap_set_bits(data->regmap, LTR390_MAIN_CTRL,
-			      LTR390_SENSOR_ENABLE | LTR390_UVS_MODE);
+				LTR390_SENSOR_ENABLE | LTR390_UVS_MODE);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to enable the sensor\n");
 
@@ -189,6 +304,7 @@ static struct i2c_driver ltr390_driver = {
 	.probe = ltr390_probe,
 	.id_table = ltr390_id,
 };
+
 module_i2c_driver(ltr390_driver);
 
 MODULE_AUTHOR("Anshul Dalal <anshulusr@gmail.com>");
-- 
2.43.0


