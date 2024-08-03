Return-Path: <linux-iio+bounces-8219-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F79946AC6
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 20:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1431F215C2
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 18:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A3217C8B;
	Sat,  3 Aug 2024 18:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaLxfKs5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9574A1AACA;
	Sat,  3 Aug 2024 18:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722708612; cv=none; b=DozLh0Cy4GXlrX+EBQWVZgL2mwA97omk3TJmd0qd0c6MftjZP4pBXpjWAbYpK3ckF1z/bPMylhVDv2q4K1/sRwQEiCDsrck4yBI5Zq2z7/5HccFJ/90kDaJiM2moAjzVrbNlAfhCOCK/iD1sZLbdm2ms6vezSQ1PlgTQAw52SP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722708612; c=relaxed/simple;
	bh=2S4ndyfQHwkjcEZcx/Ka7S17KLYzJ1IGETFUdLbsDfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPpZArkqX5+ELQkrSS8N7C68m5NhyVrn4nyMMBUDo2/zyPV2uLBan6sCK5uNMgHv7WFfAMwZS5sdXsI0Zch/ckpDv5Cyn8P9tYm2fP4aht4s6Z63lT4a7ELk2WwXfrJZyvcNxjDHVcEheKDHWBnlgmDm0VONzywnIx+MbWDfzkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaLxfKs5; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3daf0e73a5bso6193363b6e.0;
        Sat, 03 Aug 2024 11:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722708609; x=1723313409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mER8v84ARA8XH2Iogvf2g55/SOmWGGANj/bW9FdhDhA=;
        b=YaLxfKs5jZJpwLCqGqR6edyup1Ayoxt1FaU4U20//dfFSVsCoenr+jGCv7D/nsWW3c
         f25rXN9Q4TMJ67d5VSoaubgS1YEaw6x/sbtkPJ/+sSX+IVWPRog0HVNM/k8rj10ezmDl
         AHKNPa34sxSpHryc+WcCADA2fgqCXNwHPXELlQGBkKU0qbsp2M/DRsI4hw30iPWLliT8
         J6r+TJzXrFx+2FziwOjVT+f5VrZo34T6FrGEQ14VoYbB+hS2tJMLRmgMTHCQNb+RH8My
         NxX6fI2q7hVrRhXCoHoNWohCrouBIJ2168Hs0YyQ6vt+4PpPSAyAoOLoG/KbMDS6+ABr
         65sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722708609; x=1723313409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mER8v84ARA8XH2Iogvf2g55/SOmWGGANj/bW9FdhDhA=;
        b=w9a6gwxGiAoXJxSUSFouGZPv63gI36XyO8s7NZZIOZtMoY2R789OtoRkEGlwudxaV0
         OTkdUzXs5tmPByYhmNyh3IDaIvYy2oSg3jloKIG+OhUq6F2mN+7KpVckPcVSyaU/lz4V
         yq5NShZX+Dae75Q801w3+8pkFDaHue/ZEHhMRD7wpt6xAxWIku9dB+MkOya5v4brdKmk
         Of7TEZ2w0nPbHpJmRV4yhcNx8IHf9K/3ZNkeMhq1vlK6V8P8XbIrfjuoMEdla4LTXnLD
         Ho2Hf4kaIcTYKgNI1TsaHq4456mdUNxE2op2ixx3G1HJWlqX1VlxpFzleh9is1qdcL9V
         89FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSjuc2R2W0nFpNLqPyq6TjvAbRexQVBTcFZd+k8ePURzRFSCgK79kUjjCzXPl42ff9A3F8nCEbkkHIXLUI1gnQMNSe5JgLqnSRmNe0
X-Gm-Message-State: AOJu0YyLI/UNyZ7BGfmIuQwsDSSNGEAXfDdFM4ha/XuCDHttSEuyieAP
	2q6S+vxOavMMUDSHc9gQ2exwIhtEJyTzdU4jK0fgdBVAU2x9HEHbwkTU/iNd8JA=
X-Google-Smtp-Source: AGHT+IHGoDDAN7qvnO2zDL7IH6VysKk6C6tEF1jthmdLX+k5bZkD3O50lZb42S58dxV20BP3u3Y/Xw==
X-Received: by 2002:a05:6871:582a:b0:268:880c:9de3 with SMTP id 586e51a60fabf-26891a9aea9mr9289995fac.14.1722708609125;
        Sat, 03 Aug 2024 11:10:09 -0700 (PDT)
Received: from localhost.localdomain ([136.233.9.100])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7b762e9f5aasm3046128a12.6.2024.08.03.11.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 11:10:08 -0700 (PDT)
From: Abhash Jha <abhashkumarjha123@gmail.com>
To: linux-iio@vger.kernel.org
Cc: anshulusr@gmail.com,
	jic23@kernel.org,
	lars@metafoo.de,
	linux-kernel@vger.kernel.org,
	Abhash Jha <abhashkumarjha123@gmail.com>
Subject: [PATCH v6 1/2] iio: light: ltr390: Add ALS channel and support for gain and resolution
Date: Sat,  3 Aug 2024 23:39:48 +0530
Message-ID: <20240803180950.32821-2-abhashkumarjha123@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240803180950.32821-1-abhashkumarjha123@gmail.com>
References: <20240803180950.32821-1-abhashkumarjha123@gmail.com>
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
 drivers/iio/light/ltr390.c | 100 +++++++++++++++++++++++++++++++------
 1 file changed, 85 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/light/ltr390.c b/drivers/iio/light/ltr390.c
index ee3d30075..44ca4b04a 100644
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
@@ -95,6 +101,25 @@ static int ltr390_register_read(struct ltr390_data *data, u8 register_address)
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
@@ -105,15 +130,47 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
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
@@ -128,11 +185,23 @@ static int ltr390_read_raw(struct iio_dev *iio_device,
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
@@ -252,12 +321,14 @@ static int ltr390_probe(struct i2c_client *client)
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
@@ -275,8 +346,7 @@ static int ltr390_probe(struct i2c_client *client)
 	/* Wait for the registers to reset before proceeding */
 	usleep_range(1000, 2000);
 
-	ret = regmap_set_bits(data->regmap, LTR390_MAIN_CTRL,
-			      LTR390_SENSOR_ENABLE | LTR390_UVS_MODE);
+	ret = regmap_set_bits(data->regmap, LTR390_MAIN_CTRL, LTR390_SENSOR_ENABLE);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to enable the sensor\n");
 
-- 
2.43.0


