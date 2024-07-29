Return-Path: <linux-iio+bounces-8019-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5923E93F48F
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 13:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EECF1C21B72
	for <lists+linux-iio@lfdr.de>; Mon, 29 Jul 2024 11:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20979146A60;
	Mon, 29 Jul 2024 11:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHqsMXTV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698A714883B;
	Mon, 29 Jul 2024 11:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253909; cv=none; b=iHRPbCYWq6ajSP9DcIOvwIrOqipU5qcCJ3cILh9K+hzR5s3k8sOmKGhnY5yf38CNQStgPG78WgGEk/Iyv07cGWYkzy/W0A/RXGacRO8eUss5XAIrfx1y62h6UwASu0fVEDuBIm5yoeUqKWImxNZu8Y2XHPVTFENEApl8HklDNes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253909; c=relaxed/simple;
	bh=/Qy1LObMKWIxCMmIDmIh0oDsUkuilV/YtTh2bV9PWBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1dh5TojE17qHY/WCQyvwn81i5paIiF8bs6yaQU6TSKW9sHi3exX+A8vo/cTJppqwJwgPkvVxKJYNkyOCou75GtQsNK3BWcWIwC0+0YJtdWWSNksX4mVRDB8PoDsNgSkFzsbzRQj1xTSLYBzNbsWaRpxBrZQqqU0touusqmMAhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHqsMXTV; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7a211a272c2so1857455a12.1;
        Mon, 29 Jul 2024 04:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722253907; x=1722858707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBXlZtIXpxwGCC54MpHsk2hkjmskav/WyDY22uHOy5I=;
        b=MHqsMXTV7ECcNGNHMyuyT1TLB8qGB1Y9SGgnzNIkcNtk8JUws+IZ2vNnpV29cbFqpb
         gSKP8Pkn5uVuI6ogBa2AxoGRCblJQo55nXQRdlwCmMROAZKxwoeQeOfQNDVskEkPoeyy
         oljzmw40h47gXQ+iTlNVQl+G05/udSq6piV0YC4A+r9b1YyGYkYhnduaDMNDWFrZTCyg
         BD2C/pB74yUhtwDnLTfFTN2kDN2qoiJvpHefkGaLdUwWxs6Hw1jSV90/xfUftO17x/Fv
         PD8x/U/9CqBEw8+NwuiPl5a4W/bTNw18cTbtmKX51jkGM1xJiOTckmi5IYas8MjE9a8E
         Zt5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722253907; x=1722858707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBXlZtIXpxwGCC54MpHsk2hkjmskav/WyDY22uHOy5I=;
        b=oS29+gAM5xsYX5tCUMH2aQBTOLgC1/Igu3gUrP5tphuf5zTOrPRmb+pBX49vKM5mRA
         zm/ARqnr9qs8VkSWGpU8aSZ50ZULzlH8Ilc3/fjOuEUeUlYqREO1CLqAEBCLG457tk/K
         rB47CGo12FwCQK3KGjlAS+WwQNruRx7yIgHFZTAKgjgxLe0epGrxzkBN0aQ1luOJyQE6
         zyDoRpfiERB/c4T5I1wWvFDogqiKzcwC5HFoeGZ8NbMEO8BEvQNPJ4auBblYfbJflRuH
         ooAftmvPV+3rncdJb5s5hro9aagOUCqRaGMh+oUscuX4PSZIde0qEhHwqOpla4tMRyF2
         XFWw==
X-Forwarded-Encrypted: i=1; AJvYcCVj9wWesiupVJLxXcRcbIF2/jyMDxnzjWXDNoLK2KvTikIs+CAeyS2gqgfHqkw9D/Q/e8iV77xVzkmb9+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO0uT545S4qXRlikPDaUJsHqJ+Ew8xrzoz2Wag8oyLQi+kphAy
	8837Ffi/P89dTWL+Pn4HGWa1I5bsSjIBgdixxXfMBqrBtqyJT1Wchy8jSTwcxOSSaA==
X-Google-Smtp-Source: AGHT+IGF+wjsrrV67Pij9SFqzeDliTRks/HuCmQeNAm0imaxPTBFAgavjvkH/vSIBPJzDV5Xqdcw6w==
X-Received: by 2002:a17:90b:4a81:b0:2c3:34f4:5154 with SMTP id 98e67ed59e1d1-2cf7ce8754bmr12389745a91.1.1722253907060;
        Mon, 29 Jul 2024 04:51:47 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2cd8f7692f0sm6760987a91.1.2024.07.29.04.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 04:51:46 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v3 2/3] iio: light: ltr390: Add ALS channel and support for gain and resolution
Date: Mon, 29 Jul 2024 17:20:54 +0530
Message-ID: <20240729115056.355466-3-abhashkumarjha123@gmail.com>
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

Add new ALS channel and allow reading raw and scale values.
Also provide gain and resolution configuration for ALS channel.
Add automatic mode switching between the UVS and ALS channel
based on which channel is being accessed.
The default mode in which the sensor start is ALS mode.

Signed-off-by: Abhash Jha <abhashkumarjha123@gmail.com>
---
 drivers/iio/light/ltr390.c | 109 ++++++++++++++++++++++++++++++++-----
 1 file changed, 94 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index b79cd413f..79f5a516a 100644
--- a/drivers/iio/light/ltr390.c
+++ b/drivers/iio/light/ltr390.c
@@ -62,11 +62,17 @@
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
@@ -94,6 +100,25 @@ static int ltr390_register_read(struct ltr390_data *data, u8 register_address)
 	return get_unaligned_le24(recieve_buffer);
 }
 
+static int ltr390_set_mode(struct ltr390_data *data, enum ltr390_mode mode)
+{
+	if (data->mode == mode)
+		return 0;
+
+	switch (mode) {
+	case LTR390_SET_ALS_MODE:
+		regmap_clear_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_UVS_MODE);
+		break;
+
+	case LTR390_SET_UVS_MODE:
+		regmap_set_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_UVS_MODE);
+		break;
+	}
+
+	data->mode = mode;
+	return 0;
+}
+
 static int ltr390_read_raw(struct iio_dev *iio_device,
 			   struct iio_chan_spec const *chan, int *val,
 			   int *val2, long mask)
@@ -104,15 +129,56 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
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
+		case IIO_INTENSITY:
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
+
 		*val = ret;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		*val = LTR390_WINDOW_FACTOR;
-		*val2 = LTR390_COUNTS_PER_UVI;
-		return IIO_VAL_FRACTIONAL;
+		switch (chan->type) {
+		case IIO_UVINDEX:
+			ret = ltr390_set_mode(data, LTR390_SET_UVS_MODE);
+			if (ret < 0)
+				return ret;
+
+			*val = LTR390_WINDOW_FACTOR;
+			*val2 = LTR390_COUNTS_PER_UVI;
+			return IIO_VAL_FRACTIONAL;
+
+		case IIO_INTENSITY:
+			ret = ltr390_set_mode(data, LTR390_SET_ALS_MODE);
+			if (ret < 0)
+				return ret;
+
+			*val = LTR390_WINDOW_FACTOR;
+			*val2 = data->gain;
+			return IIO_VAL_FRACTIONAL;
+
+		default:
+			return -EINVAL;
+		}
 
 	case IIO_CHAN_INFO_INT_TIME:
 		*val = data->int_time_us;
@@ -127,11 +193,23 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
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
+		.type = IIO_INTENSITY,
+		.scan_index = 1,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME),
+		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) | BIT(IIO_CHAN_INFO_SCALE)
+	},
 };
 
 static int ltr390_set_gain(struct ltr390_data *data, int val)
@@ -251,12 +329,14 @@ static int ltr390_probe(struct i2c_client *client)
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
@@ -274,8 +354,7 @@ static int ltr390_probe(struct i2c_client *client)
 	/* Wait for the registers to reset before proceeding */
 	usleep_range(1000, 2000);
 
-	ret = regmap_set_bits(data->regmap, LTR390_MAIN_CTRL,
-			      LTR390_SENSOR_ENABLE | LTR390_UVS_MODE);
+	ret = regmap_set_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_SENSOR_ENABLE);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to enable the sensor\n");
 
-- 
2.43.0


