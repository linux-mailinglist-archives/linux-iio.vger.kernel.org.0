Return-Path: <linux-iio+bounces-20690-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F567ADA45C
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 00:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CEC7168096
	for <lists+linux-iio@lfdr.de>; Sun, 15 Jun 2025 22:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBEA1EA7DF;
	Sun, 15 Jun 2025 22:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PphRo7Zw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52E2281532;
	Sun, 15 Jun 2025 22:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750026194; cv=none; b=YkeFTBlOFRmLIpm8yy/2ecRDjmM4FZquC7pQ6ZkbtNEjhvXIxkBY6Swov1lsG00fg8waRt5BGLRFMbWJ27yWTMWNsUPWWbVTUpMMhkL813UfkEHa+EasNPHDB1jQNm9tBVImSYUDNeKVAEdbTojEv75BZQ7GkY55rwsoFNYtlqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750026194; c=relaxed/simple;
	bh=NAnRvIZtABoeGKL4mT8NGeLUQXUGt3Db1dF5FBbw5Jk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q3pLxnAuRjtW3QNDUCRYs1cTyy6cdEqXFUCAz6hd1Ph3gU0hERcuTK6jWs6wjZ/eWX7ORQMCkriAuzwP7tAGZWGkH4eIWAsY8UW6crkcv2iZnKfmFPZJtcCLUJU//C0fqVMpZYQ8TOVDmGkDLGHxt3w+NEuh1Zl8FWNsfYumf6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PphRo7Zw; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ade6ef7e6b5so66344066b.3;
        Sun, 15 Jun 2025 15:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750026191; x=1750630991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7lx5bSlxHCR3yMcw5WqOUP1Em37abE5TKB7VY91trM=;
        b=PphRo7ZwuYmbC/aLdGr5MqeadFxcVP5Y67xXsudPdEVAYnW1lel0JPTf/zHGRXMMtj
         enMp9VrrbmgjXnzcLUN4NS/iJAU1YEyS95vb/0y2ODS/PKqzZsi83qVd3wHJxqA6yTAY
         oTojSWz9WSNj9+28sQe4voC15nM0yGFyKOoHg9/69eUz5VzUeEWs68flIQ2ruWqUdRXQ
         ZpstcKswrgCdb7n6kdhVXYV2XNACQw/ktLN14uO3HiLbkZRi2xPTK6VtXKSCt+Jgx9pT
         aqIAGZmJSPSwc9CPJGDRRhvEo6om/n4VGSF2CFm5EZlST7R8R/+LYz+a1Quc/TuHngAY
         NnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750026191; x=1750630991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7lx5bSlxHCR3yMcw5WqOUP1Em37abE5TKB7VY91trM=;
        b=UTBa2IykTvKSP/TtFEZ6KHkoZbzD/mHZDDsRwDdDfxFuBq+/z8x2LBDoulAG17RAP/
         SJV8sD4LFN9jX9mtyjXbZGFtfPvozb3fMgLgS8SEh8pkXWikVV8kFB/EFXN+LDz7NeD6
         DGTYHzrBANaZ6s111rZZIE9mtVlYT2sKZYyrJGri26dkJHymNOSJM1Z8P6AbvvQ3a8di
         MRPc6EDu3t5nYp7EExswMM18WBxhkuagPzFxlqe6nLv7gI3qsKpgWhuGxNfbX+MHngBM
         SBz8rMMY3HKo+rfpDu6iKobaI06tq3ZVvHXAwyWrFqTmXqHqeysX0b/DfciDfUYnEFNR
         v2TA==
X-Forwarded-Encrypted: i=1; AJvYcCVzYPuql11SjGdiwQsLUWz2p3RhLYoYe1mkBaKvKS3lE/YBGHg4D67mgjD9Ah2XAWYELlOwp5SgZ/I=@vger.kernel.org, AJvYcCWGTLPQqMKCgwW8oM19EH/EfZtOKHs45EqIFoqW2l1g3LVP+/BpC/SH20yBXMLaQCpJoC5PEopagRSXSmCr@vger.kernel.org, AJvYcCXuSHGkAEWd6tEyt50M9N9mUnKKEcB9XcgBM3T26Bhv4erSoOPICreyFfxV/bfgA0snpFnfEFTdLK/J@vger.kernel.org
X-Gm-Message-State: AOJu0YyTSk+y6wA9anAmTSbURyYP3bLXwV6KG7nB1/aTDWyYH3NJ91cd
	zeHT+bg6wVbHM3MVoIu//S89kZQIDbQzisukfaE2SuIWCbqLijzpP7A+BLWdjg==
X-Gm-Gg: ASbGnctfgVrCvfD94ghC0CdLiwj3oTYXNSSG2vNhftv2VOHhAeMuoaXVjR8P+x5H8VL
	DW+3iu4IlEk58uefCbAkZHOvJbe7rjFnJPxF28SQ4HDCOqorCdBGtaGYQIfOvu4Gdmtmd6n4oZ2
	9RwSFZFBgOkBhvmJmAGl7ozHIWt3PBmJtgzoNYmuiiyrrwYYAiOCbDH/1Wo1VJ4RKkhY4qH+0Xi
	AWcCTMtEXt5FAFLtrQUehfZjkM/UykQR1JT6OTyoqh9aNvOO2ttQEftfwvAKzpGU9qgok8ULWjE
	btHMaGS3uTDwavtPem/7CLFXswHWCpCMAIPjd/q3qqmXvFAL+WNIB1MZBWQEfelMFwUg/60QyTH
	sN8zvVoS7W4wPIsejKcNrdld7tR63kNnb
X-Google-Smtp-Source: AGHT+IFl1yUBAVahJrUDF2mZttrG/hGvZmBvDQqccpdKN5iF6+AwaUNB728y2v5g7Pxa3ZXHkjmJQg==
X-Received: by 2002:a17:907:3d88:b0:ad8:8940:b3ad with SMTP id a640c23a62f3a-adfad3a3429mr218352066b.4.1750026191077;
        Sun, 15 Jun 2025 15:23:11 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adf8b393ea8sm412692766b.159.2025.06.15.15.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 15:23:10 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	bagasdotme@gmail.com
Cc: l.rubusch@gmail.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 5/8] iio: accel: adxl313: add inactivity sensing
Date: Sun, 15 Jun 2025 22:22:55 +0000
Message-Id: <20250615222258.117771-6-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250615222258.117771-1-l.rubusch@gmail.com>
References: <20250615222258.117771-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enhance the interrupt handler to process inactivity events. Introduce
functions to configure the threshold and period registers for
inactivity detection, as well as to enable or disable the inactivity
feature. Extend the fake IIO channel to handle inactivity events by
combining the x, y, and z axes using a logical AND operation.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313.h      |   2 +
 drivers/iio/accel/adxl313_core.c | 161 ++++++++++++++++++++++++++-----
 2 files changed, 137 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
index 4f4a9fd39f6d..d7e8cb44855b 100644
--- a/drivers/iio/accel/adxl313.h
+++ b/drivers/iio/accel/adxl313.h
@@ -18,6 +18,8 @@
 #define ADXL313_REG_SOFT_RESET		0x18
 #define ADXL313_REG_OFS_AXIS(index)	(0x1E + (index))
 #define ADXL313_REG_THRESH_ACT		0x24
+#define ADXL313_REG_THRESH_INACT	0x25
+#define ADXL313_REG_TIME_INACT		0x26
 #define ADXL313_REG_ACT_INACT_CTL	0x27
 #define ADXL313_REG_BW_RATE		0x2C
 #define ADXL313_REG_POWER_CTL		0x2D
diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index b0d14ce60f01..95f52c95682a 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -28,18 +28,22 @@
 #define ADXL313_REG_XYZ_BASE			ADXL313_REG_DATA_AXIS(0)
 
 #define ADXL313_ACT_XYZ_EN			GENMASK(6, 4)
+#define ADXL313_INACT_XYZ_EN			GENMASK(2, 0)
 
 /* activity/inactivity */
 enum adxl313_activity_type {
 	ADXL313_ACTIVITY,
+	ADXL313_INACTIVITY,
 };
 
 static const unsigned int adxl313_act_int_reg[] = {
 	[ADXL313_ACTIVITY] = ADXL313_INT_ACTIVITY,
+	[ADXL313_INACTIVITY] = ADXL313_INT_INACTIVITY,
 };
 
 static const unsigned int adxl313_act_thresh_reg[] = {
 	[ADXL313_ACTIVITY] = ADXL313_REG_THRESH_ACT,
+	[ADXL313_INACTIVITY] = ADXL313_REG_THRESH_INACT,
 };
 
 static const struct regmap_range adxl312_readable_reg_range[] = {
@@ -253,6 +257,16 @@ static const struct iio_event_spec adxl313_activity_events[] = {
 	},
 };
 
+static const struct iio_event_spec adxl313_inactivity_events[] = {
+	{
+		.type = IIO_EV_TYPE_MAG,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_PERIOD),
+	},
+};
+
 enum adxl313_chans {
 	chan_x, chan_y, chan_z,
 };
@@ -269,6 +283,14 @@ static const struct iio_chan_spec adxl313_channels[] = {
 		.event_spec = adxl313_activity_events,
 		.num_event_specs = ARRAY_SIZE(adxl313_activity_events),
 	},
+	{
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_X_AND_Y_AND_Z,
+		.scan_index = -1, /* Fake channel for axis AND'ing */
+		.event_spec = adxl313_inactivity_events,
+		.num_event_specs = ARRAY_SIZE(adxl313_inactivity_events),
+	},
 };
 
 static const unsigned long adxl313_scan_masks[] = {
@@ -331,6 +353,15 @@ static int adxl313_read_freq_avail(struct iio_dev *indio_dev,
 	}
 }
 
+static int adxl313_set_inact_time_s(struct adxl313_data *data,
+				    unsigned int val_s)
+{
+	unsigned int max_boundary = U8_MAX; /* by register size */
+	unsigned int val = min(val_s, max_boundary);
+
+	return regmap_write(data->regmap, ADXL313_REG_TIME_INACT, val);
+}
+
 static int adxl313_is_act_inact_en(struct adxl313_data *data,
 				   enum adxl313_activity_type type)
 {
@@ -342,7 +373,17 @@ static int adxl313_is_act_inact_en(struct adxl313_data *data,
 	if (ret)
 		return ret;
 
-	axis_en = FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl);
+	/* Check if axis for activity are enabled */
+	switch (type) {
+	case ADXL313_ACTIVITY:
+		axis_en = FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl);
+		break;
+	case ADXL313_INACTIVITY:
+		axis_en = FIELD_GET(ADXL313_INACT_XYZ_EN, axis_ctrl);
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	if (!axis_en)
 		return false;
@@ -361,11 +402,9 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 {
 	unsigned int axis_ctrl;
 	unsigned int threshold;
+	unsigned int inact_time_s;
 	int ret;
 
-	if (type != ADXL313_ACTIVITY)
-		return 0;
-
 	if (cmd_en) {
 		/* When turning on, check if threshold is valid */
 		ret = regmap_read(data->regmap, adxl313_act_thresh_reg[type],
@@ -375,15 +414,33 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 
 		if (!threshold) /* Just ignore the command if threshold is 0 */
 			return 0;
+
+		/* When turning on inactivity, check if inact time is valid */
+		if (type == ADXL313_INACTIVITY) {
+			ret = regmap_read(data->regmap, ADXL313_REG_TIME_INACT, &inact_time_s);
+			if (ret)
+				return ret;
+
+			if (!inact_time_s)
+				return 0;
+		}
 	}
 
-	/* Start modifying configuration registers */
 	ret = adxl313_set_measure_en(data, false);
 	if (ret)
 		return ret;
 
 	/* Enable axis according to the command */
-	axis_ctrl = ADXL313_ACT_XYZ_EN;
+	switch (type) {
+	case ADXL313_ACTIVITY:
+		axis_ctrl = ADXL313_ACT_XYZ_EN;
+		break;
+	case ADXL313_INACTIVITY:
+		axis_ctrl = ADXL313_INACT_XYZ_EN;
+		break;
+	default:
+		return -EINVAL;
+	}
 	ret = regmap_assign_bits(data->regmap, ADXL313_REG_ACT_INACT_CTL,
 				 axis_ctrl, cmd_en);
 	if (ret)
@@ -484,6 +541,8 @@ static int adxl313_read_event_config(struct iio_dev *indio_dev,
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
 		return adxl313_is_act_inact_en(data, ADXL313_ACTIVITY);
+	case IIO_EV_DIR_FALLING:
+		return adxl313_is_act_inact_en(data, ADXL313_INACTIVITY);
 	default:
 		return -EINVAL;
 	}
@@ -503,6 +562,8 @@ static int adxl313_write_event_config(struct iio_dev *indio_dev,
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
 		return adxl313_set_act_inact_en(data, ADXL313_ACTIVITY, state);
+	case IIO_EV_DIR_FALLING:
+		return adxl313_set_act_inact_en(data, ADXL313_INACTIVITY, state);
 	default:
 		return -EINVAL;
 	}
@@ -517,24 +578,45 @@ static int adxl313_read_event_value(struct iio_dev *indio_dev,
 {
 	struct adxl313_data *data = iio_priv(indio_dev);
 	unsigned int act_threshold;
+	unsigned int inact_threshold;
+	unsigned int inact_time_s;
 	int ret;
 
 	if (type != IIO_EV_TYPE_MAG)
 		return -EINVAL;
 
-	if (info != IIO_EV_INFO_VALUE)
-		return -EINVAL;
-
-	switch (dir) {
-	case IIO_EV_DIR_RISING:
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			ret = regmap_read(data->regmap,
+					  adxl313_act_thresh_reg[ADXL313_ACTIVITY],
+					  &act_threshold);
+			if (ret)
+				return ret;
+			*val = act_threshold * 15625;
+			*val2 = MICRO;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_EV_DIR_FALLING:
+			ret = regmap_read(data->regmap,
+					  adxl313_act_thresh_reg[ADXL313_INACTIVITY],
+					  &inact_threshold);
+			if (ret)
+				return ret;
+			*val = inact_threshold * 15625;
+			*val2 = MICRO;
+			return IIO_VAL_FRACTIONAL;
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_INFO_PERIOD:
 		ret = regmap_read(data->regmap,
-				  adxl313_act_thresh_reg[ADXL313_ACTIVITY],
-				  &act_threshold);
+				  ADXL313_REG_TIME_INACT,
+				  &inact_time_s);
 		if (ret)
 			return ret;
-		*val = act_threshold * 15625;
-		*val2 = MICRO;
-		return IIO_VAL_FRACTIONAL;
+		*val = inact_time_s;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -553,16 +635,24 @@ static int adxl313_write_event_value(struct iio_dev *indio_dev,
 	if (type != IIO_EV_TYPE_MAG)
 		return -EINVAL;
 
-	if (info != IIO_EV_INFO_VALUE)
-		return -EINVAL;
-
-	/* Scale factor 15.625 mg/LSB */
-	regval = DIV_ROUND_CLOSEST(val * MICRO + val2, 15625);
-	switch (dir) {
-	case IIO_EV_DIR_RISING:
-		return regmap_write(data->regmap,
-				    adxl313_act_thresh_reg[ADXL313_ACTIVITY],
-				    regval);
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		/* Scale factor 15.625 mg/LSB */
+		regval = DIV_ROUND_CLOSEST(MICRO * val + val2, 15625);
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return regmap_write(data->regmap,
+					    adxl313_act_thresh_reg[ADXL313_ACTIVITY],
+					    regval);
+		case IIO_EV_DIR_FALLING:
+			return regmap_write(data->regmap,
+					    adxl313_act_thresh_reg[ADXL313_INACTIVITY],
+					    regval);
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_INFO_PERIOD:
+		return adxl313_set_inact_time_s(data, val);
 	default:
 		return -EINVAL;
 	}
@@ -722,6 +812,17 @@ static int adxl313_push_events(struct iio_dev *indio_dev, int int_stat)
 			return ret;
 	}
 
+	if (FIELD_GET(ADXL313_INT_INACTIVITY, int_stat)) {
+		ret = iio_push_event(indio_dev,
+				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+							IIO_MOD_X_AND_Y_AND_Z,
+							IIO_EV_TYPE_MAG,
+							IIO_EV_DIR_FALLING),
+				     ts);
+		if (ret)
+			return ret;
+	}
+
 	return ret;
 }
 
@@ -903,6 +1004,14 @@ int adxl313_core_probe(struct device *dev,
 		if (ret)
 			return ret;
 
+		ret = regmap_write(data->regmap, ADXL313_REG_TIME_INACT, 5);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(data->regmap, ADXL313_REG_THRESH_INACT, 0x4f);
+		if (ret)
+			return ret;
+
 		ret = regmap_write(data->regmap, ADXL313_REG_THRESH_ACT, 0x52);
 		if (ret)
 			return ret;
-- 
2.39.5


