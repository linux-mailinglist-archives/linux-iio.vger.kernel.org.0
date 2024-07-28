Return-Path: <linux-iio+bounces-7994-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF8993E5CC
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 17:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E85281941
	for <lists+linux-iio@lfdr.de>; Sun, 28 Jul 2024 15:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B3F4F8A0;
	Sun, 28 Jul 2024 15:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwE2jJZF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BA13FE55;
	Sun, 28 Jul 2024 15:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722180048; cv=none; b=pJZRPziKD5iRoRNPgp1T934UaFSmlvOJVxaK3TUUdIbyo21jXoSiM/aEhX+c/qqcsDzHkQ85WpXKVrRD+qt56mec4Ta2qUbBMXoUM6vAqiT2hwjhhHenH7UAfq8Shdf/MBoA9wj4F7byLRxPWBwRDX9IZ6kIvaJb+dFy+YVN0C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722180048; c=relaxed/simple;
	bh=owexpOXF+wI61BgqHsHNShPLhj3RatWabgrTY7mkeHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGqo94HPT49jMaE7xh5H1LkqdAwaYLlq3pypR56uOa8/QpObAJAvn0aEnqOwPswBEi08EdgV0gCMpL1ii3+2+tfQ9a361gZ7ZekMePSEyFZPV1dFzcilXrx69c2sFiqZrNwl15vfQ94yIF/ziy4zWZ6fKw+xdtB0hh8ooo39lYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwE2jJZF; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70d153fec2fso1922189b3a.1;
        Sun, 28 Jul 2024 08:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722180046; x=1722784846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PG62K3ydvM6FgW1Is7oA+qi+i6CrllaajFqPquOOLx0=;
        b=CwE2jJZF6wrYBzCMsxEQB+cel6b3YB+reK65xCKKjkV00aM4tVnpA5lS0kxicoRUO2
         K6b++E5yZCEjaAwew7T0ElqmwFxRuPMCXvHcWEjtHod1GpL6f6IrNKv3h1A09VZ93G7M
         RKAzNURjRviMcxCo1GF97q68wU1DjMmHjRArWVYZctOR7/WjQ8WhvKoqBiPqUM7eoeFt
         ykStgX+zgK8nd724NTAyyLqqGW5AEb14ufabOSR6aVVU5O+4xkbtzo56/Zq6mkORpr+5
         MrmZqHbJVPhtlQAjWIzr6UciemOCb8P25ULvz3t48eecfI5dTOzUaxumb0e/OxQt45kf
         dl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722180046; x=1722784846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PG62K3ydvM6FgW1Is7oA+qi+i6CrllaajFqPquOOLx0=;
        b=kiKP5CAnghpdLcei/qBS9dHWaNPHETPgs2n3uowivvAGDxHaWIYBpmGTibg4n3lTPP
         OvgnUFST7nwVcLQUzcM0sHghzJXX8Pz+RGqJ5iat8hl2kAwNFaEqmt6JyknqEVB9fvZ1
         P+7k0QArtT6lND1iISSGD/9r4xFt86uFKqa9T5iTb1ot1eP6C+fZmwddtXNGhVjYvW6x
         Y37waceCiRwwQPRxsIGosLmLnJHwdYSkIY2yDJlkznrUF81rV8Xz+yGGG3VFEbjNLJNL
         STAiJqAnP6d39Flaz3NKsLcR3/XyVPT2CW0pLmsXyQa0gS8tnAKU9h55HlWqUKUYlKUY
         yWqw==
X-Forwarded-Encrypted: i=1; AJvYcCW9XzTh+hbruiWc8yqjpUoSxr5RBATWRJ6vLV/gsKmOhEEztPetQ0fnKTkFQqFF07OuXfKX0FpY4to1hQufPAeaFaF8gft+cPoKcNJs
X-Gm-Message-State: AOJu0Yxp+czFpelnjKK0L/vsmlbtoSBjmTP2zqGfCTu5plp4+2ZoyA7B
	RX+aXmwnIZmDU7z51nxaKRVm/h4QKK8gtY4vmf8lZ7mD+bbpUAGTeAhm5du3KHfVug==
X-Google-Smtp-Source: AGHT+IGPIvOF7s3vnbCTPK9auTSkhd7q0XfxQxzRfPm5/aBYIX3fXUZxWfM131zZt6vuQNfxFW3dwA==
X-Received: by 2002:a05:6a21:3483:b0:1c4:818c:299d with SMTP id adf61e73a8af0-1c4a1179127mr6632320637.11.1722180045901;
        Sun, 28 Jul 2024 08:20:45 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7a9f817aebasm5836843a12.28.2024.07.28.08.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 08:20:45 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v2 2/3] iio: light: ltr390: Add ALS channel and support for gain and resolution
Date: Sun, 28 Jul 2024 20:49:55 +0530
Message-ID: <20240728151957.310237-2-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728151957.310237-1-abhashkumarjha123@gmail.com>
References: <20240727132735.052502ad@jic23-huawei>
 <20240728151957.310237-1-abhashkumarjha123@gmail.com>
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
 drivers/iio/light/ltr390.c | 111 ++++++++++++++++++++++++++++++++-----
 1 file changed, 96 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index 9f00661c3..d1a259141 100644
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
+	int mode;
 	int gain;
 	int int_time_us;
 };
@@ -94,6 +100,28 @@ static int ltr390_register_read(struct ltr390_data *data, u8 register_address)
 	return get_unaligned_le24(recieve_buffer);
 }
 
+static int ltr390_set_mode(struct ltr390_data *data, int mode)
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
+
+	default:
+		return -EINVAL;
+	}
+
+	data->mode = mode;
+	return 0;
+}
+
 static int ltr390_read_raw(struct iio_dev *iio_device,
 			   struct iio_chan_spec const *chan, int *val,
 			   int *val2, long mask)
@@ -104,17 +132,57 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
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
@@ -129,11 +197,23 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
 static const int ltr390_int_time_map_us[] = {400000, 200000, 100000, 50000, 25000, 12500};
 static const int ltr390_gain_map[] = {1, 3, 6, 9, 18};
 
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
@@ -253,12 +333,14 @@ static int ltr390_probe(struct i2c_client *client)
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
@@ -276,8 +358,7 @@ static int ltr390_probe(struct i2c_client *client)
 	/* Wait for the registers to reset before proceeding */
 	usleep_range(1000, 2000);
 
-	ret = regmap_set_bits(data->regmap, LTR390_MAIN_CTRL,
-				LTR390_SENSOR_ENABLE | LTR390_UVS_MODE);
+	ret = regmap_set_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_SENSOR_ENABLE);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to enable the sensor\n");
 
-- 
2.43.0


