Return-Path: <linux-iio+bounces-8018-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6A393F48B
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 13:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DE5A1F22084
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 11:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859981487CE;
	Mon, 29 Jul 2024 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxRvjsdb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC08614831E;
	Mon, 29 Jul 2024 11:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253904; cv=none; b=Zev7XiEPKxk+vkpqpCxLyz3KOoWL7pe5e2DU82Woek24D0kmm1fRyx3YVjKgn7s9oqSuuO5hcre2x8qE1zS+m0eS7+67GaYh9nwDCOlY4ACHeZHwUEoggpJoCPMl9cPHgYjL4DiO2sGUD7n4gEjU6aE4YFPrcCjMVyzYHnSyQGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253904; c=relaxed/simple;
	bh=sI4cdAFg0hsoGmnBNLAc/3uLbSNzKKojFjUB26LrnUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KlS0DXfnWg5KNZG7CbPboGAQS9rrgpx+rUjngTmmZOjQ5BGgKhSso3rKKl3uBZJXOOtJCSFq2GEHedKCj7QjiSKiyRdE9J0BjEEQb5QXuVV/tSEDGZgnSBpH3Lc3fG/lH7JXTflGt9eV9fFFesidLlB9iUDlJI+sE8C9lHZQ1NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxRvjsdb; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fc5239faebso16231525ad.1;
        Mon, 29 Jul 2024 04:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722253902; x=1722858702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/vRoovyIj8/KYbO+9JAvtM+g6AnVksICedVIcBIJP4=;
        b=CxRvjsdb6iA+5I4SPCvLz65ktNciu4ZfwXh1h5qIaZeHSu+jZ6jAATomgPFrTRDp9M
         z95ba6WPUe0rMIKA0iylRyHFiHHe6PSd+jRWmsStX74/vEnDgLE2Led+r3nvla6KpyT9
         QE6sNUzzouByVGkltW8IyzTnuMcgFL1ZFFqFW2CfKW134gVU2TR8JQ7XD8V/6NHyRJPv
         P5Du0/wk1XoG/YMpUHC04MFJPOOIB8MfufseS7OSvxbE5H7AYRn3mYvhvHHwG2TNw+Dg
         3kBDZhNbl+QNI8C1cpYadXQlGnPyYIIw071WbP0m0HQAIvV2k+z8IVoF00JDKnQLzIx1
         zhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722253902; x=1722858702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/vRoovyIj8/KYbO+9JAvtM+g6AnVksICedVIcBIJP4=;
        b=E2hXx3FX0U1v9OBBY39eof4hrISIiaJsVddG3HDiKICJ0ussj1vwtRKNPC268tHui0
         Ol6s0FF94+4brNQoRwCiA4jU3t3xqkAQH3jZpas4vs+K2avJpNmYeqC/gzY6PisdFGcD
         pwPpB7pd9DEY2N7ujnC3+r60Ipp5jXVTqHRJEuMPt46jF/IgsQptxp4lY15M8trVouBh
         OvfFKrj1bxcaPOBbROfttJDzAEHZWcIioeStDH4A/xx1pqRwHiB1Fn6Dx75kIkO43bl/
         VJ24HoecPsLihayPiW5O7wQJLUoVFiM+y45pCbk13zxmoTdhMmpE0MMo8/VWbLoRaSX8
         j4lQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJ+9d0AWw5Ae1shQQS2+CeHKmUx0CuEgF/IGPKl+D4r0zjxBnk7KqSUy7nCspii3hkSeNvKPeE0yu/P12qEoTmQkCdsqlLEFt5qytT
X-Gm-Message-State: AOJu0YxbUo2sqlDLOeEum0BVtNjaMZFMW0lr+imdsBkFdFBNTr6ra2Qe
	TFkumNrSywyEmhHpyywxSdWUSk1a3i97buqfLcIkgOij+Y62aH6KU7FHlipo2X0tFg==
X-Google-Smtp-Source: AGHT+IGF7qBOOuXao+SNJ3DZq6DSRV5MzvrRXiOAqEdUWp6xRaJUZUHXQ78+ewRegz+cEhw7FrLYRA==
X-Received: by 2002:a17:90b:3882:b0:2c8:da73:af7d with SMTP id 98e67ed59e1d1-2cf7e09577cmr5214190a91.3.1722253901474;
        Mon, 29 Jul 2024 04:51:41 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2cd8f7692f0sm6760987a91.1.2024.07.29.04.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 04:51:40 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v3 1/3] iio: light: ltr390: Add configurable gain and resolution
Date: Mon, 29 Jul 2024 17:20:53 +0530
Message-ID: <20240729115056.355466-2-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729115056.355466-1-abhashkumarjha123@gmail.com>
References: <20240729115056.355466-1-abhashkumarjha123@gmail.com>
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
 drivers/iio/light/ltr390.c | 135 ++++++++++++++++++++++++++++++++++---
 1 file changed, 124 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index fff1e8990..b79cd413f 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -28,16 +28,23 @@
 
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
@@ -94,6 +101,7 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
 	int ret;
 	struct ltr390_data *data = iio_priv(iio_device);
 
+	guard(mutex)(&data->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		ret = ltr390_register_read(data, LTR390_UVS_DATA);
@@ -105,18 +113,118 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
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
@@ -139,6 +247,11 @@ static int ltr390_probe(struct i2c_client *client)
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


