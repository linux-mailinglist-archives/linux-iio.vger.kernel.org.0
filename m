Return-Path: <linux-iio+bounces-20105-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF6DAC9F98
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 19:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57A618931B7
	for <lists+linux-iio@lfdr.de>; Sun,  1 Jun 2025 17:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514B520D4F2;
	Sun,  1 Jun 2025 17:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0I6WyI2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E372066CF;
	Sun,  1 Jun 2025 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748798524; cv=none; b=US+Ax6nNy9iQlyD66Dr/eD3pPbqunjQcNHMqFBU1SMxKfxJu3D3gLAcL85yNJT+susKVd7XpD5uoAxwiXxwk3lSn0n/MXepm3qr49j5veiTq+1q/wVr7a8flhRUxa7RHWnUcdpi1jeM3A2FiS8dLnCFVz1LwibG/J+9rgRD7qB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748798524; c=relaxed/simple;
	bh=a/9cv1A7PsrnaQyeWdhkzMR72y+CP6I3R/R8Vzgx+/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tnnCrIdC85tTLJbxDzA9Er8r9KheGbV7VMS1TXeugSNoSSY0UAFGM81Z+Obp1as7eKzIl8FczL/uGrkZ6DsN6vRl1voo4qq/cjHKXPkKv00Y5/bE2zdT4VEF52k4Navx/KeEZjVT8joMvAiMH2gGGjTvNoA5bfQLb1QgGQZF3C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0I6WyI2; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a4ef892ab2so501794f8f.3;
        Sun, 01 Jun 2025 10:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748798520; x=1749403320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZC774zi9wipgE1achXdcOBBubJSX3HwNL15strlYYoI=;
        b=g0I6WyI2HwfVYzhrck0e+9sLWuJhwQ9AyuAfwtiYHRuEGWhWAhzkKINXKLModsG30G
         EKS6CUytz03UsrC5oA6+qbKXhkqJ9lNUqbpRQutTVzRuLcSmsxX5ujZsAi2N3KACgq/V
         H665WxbOHL5awOJSQFbEmqNCBylJwiIvtEVIrj6SLhI4aiLa2CD8aK2zOyA0ftOtr7uf
         CFTmOUMcssb8k+QI2YlJebvH14Qz7D1qyiGbqTSojXU7fN04nIHof14HGkObWTzZAU6m
         uit9ihGnUWfmJkgzFzrstizfewRxydl/Xl15VDuepJu4ZoMDAtXbU6FkJdA6MBmaq4jT
         VUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748798520; x=1749403320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZC774zi9wipgE1achXdcOBBubJSX3HwNL15strlYYoI=;
        b=FGeKyKE3+/2S1i1TtaJAqmePm+uNKsQB5pGuR77dBLT9UHKpTCl0A3tj2hdc+HDHPX
         1BQ47GM/Txbtn54+r0MKuvO09ERD6x3LB0lTsvqYT1i6jE3S0FVPYdQVZqTHF9kmyrKy
         GeWsiZdIlU8Cm2kXqId+zh3DtLmGO7hvpEDzh4c4WMHbi8Y3tRLqGaPigANu0s6wV1/U
         RVnolf5c7hkH66jNFq5rL2vB1cqrsXwOYSJw7P2OPxZW16vcaeNeNEr9LHvfE/gkemyb
         B9JFyTvRfwvTv32apI3/NvwPzf01/v/1g66hyLJfUDA8KdMUbWVSKNZHXjHdmRncTb+q
         orIg==
X-Forwarded-Encrypted: i=1; AJvYcCUR3XRGVqhTh/J0fh3oImwdmK3v5TtYM+VDDJuZ4GuI2jq22ngj9IYt0oJo+S1h0+kpA0of8Gd0kQc=@vger.kernel.org, AJvYcCWAnrLU/42s9U47d6L0uPPKRx/79jJ2zSWhhBr0oynDW/Zwagrt0R/cKlzpDuSfJBZoHmbjPatG8MIe@vger.kernel.org, AJvYcCWihmPMbdzh3ia+tBM+JtNUAhidYynrcn6TjiixoiRigoKZ06TOHlJWU1Xy/QEGxnjf4a+QR/IlFNAcdLLl@vger.kernel.org
X-Gm-Message-State: AOJu0Yyseptff87VOqXcTMb4NIR1h6AETTHw6oTdndXunWGBU6HKkfk/
	ZaZXxQJ/uwmbItx7LUfbYbod2fBtExQXZ702nNtZKfOcgBfTZNqeUlS1
X-Gm-Gg: ASbGncsQB52vp7HQhDc/fgEb3t3mtSr2lJFGk5oTA7E3yX01CrdKnR7mDkvRoime6MN
	aZxYPkAkYv2Dw7b8+SPWblTi/jY78JpRp9dDF+mf0n31g/y8O9zpl50ch0P7jlJWDhTnAiWexdz
	YNzVL2JaKdgBRlcAFgabnBF5yS6vJD86uP8pbj+S2JcYZqVZYzjPvc8FUBHCPJeK7WJztxLULMD
	EXkXW0JH3g7D0JNVrTbn7fO1D4Zo/NBo4N/hAbAOJwnMpBMsoouw1PHYYG5N+n0hLpwbXuJADsk
	KXjlmWSf8x1vIhbctz5XwCwaoiroyTMJ1aK9ZcYA0Z/Ye4wBMEzkmzWVvcSFJJbiSjW9HWe0zMG
	ds2q410YnT7ON8JcwilljgdYOGb/51aFC
X-Google-Smtp-Source: AGHT+IELhI6tkQ4dFmoV1qnDpaZIvxVXs4KR1x6FXnqZYaoSjmeb8Mvj7QJg95614iEtDMVPHL6p7g==
X-Received: by 2002:a05:600c:1caa:b0:43d:2318:ed7f with SMTP id 5b1f17b1804b1-450d7a7493dmr29882535e9.0.1748798520018;
        Sun, 01 Jun 2025 10:22:00 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f009f9d6sm11890444f8f.84.2025.06.01.10.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Jun 2025 10:21:59 -0700 (PDT)
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
Subject: [PATCH v4 08/11] iio: accel: adxl313: add inactivity sensing
Date: Sun,  1 Jun 2025 17:21:36 +0000
Message-Id: <20250601172139.59156-9-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601172139.59156-1-l.rubusch@gmail.com>
References: <20250601172139.59156-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the interrupt handler to process interrupts as inactivity events.
Add functions to set threshold and period registers for inactivity. Add
functions to enable / disable inactivity. Extend the fake iio channel to
deal with inactivity events on x, y and z combined with AND.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313.h      |   2 +
 drivers/iio/accel/adxl313_core.c | 159 +++++++++++++++++++++++++------
 2 files changed, 131 insertions(+), 30 deletions(-)

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
index e647c40575ab..c5767d56b0cb 100644
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
+	unsigned int max_boundary = 255;
+	unsigned int val = min(val_s, max_boundary);
+
+	return regmap_write(data->regmap, ADXL313_REG_TIME_INACT, val);
+}
+
 static int adxl313_is_act_inact_en(struct adxl313_data *data,
 				   enum adxl313_activity_type type)
 {
@@ -343,10 +374,10 @@ static int adxl313_is_act_inact_en(struct adxl313_data *data,
 		return ret;
 
 	/* Check if axis for activity are enabled */
-	if (type != ADXL313_ACTIVITY)
-		return 0;
-
-	axis_en = FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl);
+	if (type == ADXL313_ACTIVITY)
+		axis_en = FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl);
+	else
+		axis_en = FIELD_GET(ADXL313_INACT_XYZ_EN, axis_ctrl);
 
 	/* The axis are enabled, now check if specific interrupt is enabled */
 	ret = regmap_read(data->regmap, ADXL313_REG_INT_ENABLE, &regval);
@@ -364,12 +395,14 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 {
 	unsigned int axis_ctrl;
 	unsigned int threshold;
+	unsigned int inact_time_s;
+	bool en;
 	int ret;
 
-	if (type != ADXL313_ACTIVITY)
-		return 0;
-
-	axis_ctrl = ADXL313_ACT_XYZ_EN;
+	if (type == ADXL313_ACTIVITY)
+		axis_ctrl = ADXL313_ACT_XYZ_EN;
+	else
+		axis_ctrl = ADXL313_INACT_XYZ_EN;
 
 	ret = adxl313_set_measure_en(data, false);
 	if (ret)
@@ -384,9 +417,17 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 	if (ret)
 		return ret;
 
+	en = cmd_en && threshold;
+	if (type == ADXL313_INACTIVITY) {
+		ret = regmap_read(data->regmap, ADXL313_REG_TIME_INACT, &inact_time_s);
+		if (ret)
+			return ret;
+
+		en = en && inact_time_s;
+	}
+
 	ret = regmap_assign_bits(data->regmap, ADXL313_REG_INT_ENABLE,
-				 adxl313_act_int_reg[type],
-				 cmd_en && threshold);
+				 adxl313_act_int_reg[type], en);
 	if (ret)
 		return ret;
 
@@ -479,6 +520,8 @@ static int adxl313_read_event_config(struct iio_dev *indio_dev,
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
 		return adxl313_is_act_inact_en(data, ADXL313_ACTIVITY);
+	case IIO_EV_DIR_FALLING:
+		return adxl313_is_act_inact_en(data, ADXL313_INACTIVITY);
 	default:
 		return -EINVAL;
 	}
@@ -498,6 +541,8 @@ static int adxl313_write_event_config(struct iio_dev *indio_dev,
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
 		return adxl313_set_act_inact_en(data, ADXL313_ACTIVITY, state);
+	case IIO_EV_DIR_FALLING:
+		return adxl313_set_act_inact_en(data, ADXL313_INACTIVITY, state);
 	default:
 		return -EINVAL;
 	}
@@ -512,6 +557,8 @@ static int adxl313_read_event_value(struct iio_dev *indio_dev,
 {
 	struct adxl313_data *data = iio_priv(indio_dev);
 	unsigned int act_threshold;
+	unsigned int inact_threshold;
+	unsigned int inact_time_s;
 	int ret;
 
 	/* Measurement stays enabled, reading from regmap cache */
@@ -519,19 +566,38 @@ static int adxl313_read_event_value(struct iio_dev *indio_dev,
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
@@ -555,16 +621,30 @@ static int adxl313_write_event_value(struct iio_dev *indio_dev,
 	if (type != IIO_EV_TYPE_MAG)
 		return -EINVAL;
 
-	if (info != IIO_EV_INFO_VALUE)
-		return -EINVAL;
-
-	/* Scale factor 15.625 mg/LSB */
-	regval = DIV_ROUND_CLOSEST(MICRO * val + val2, 15625);
-	switch (dir) {
-	case IIO_EV_DIR_RISING:
-		ret = regmap_write(data->regmap,
-				   adxl313_act_thresh_reg[ADXL313_ACTIVITY],
-				   regval);
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		/* Scale factor 15.625 mg/LSB */
+		regval = DIV_ROUND_CLOSEST(MICRO * val + val2, 15625);
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			ret = regmap_write(data->regmap,
+					   adxl313_act_thresh_reg[ADXL313_ACTIVITY],
+					   regval);
+			if (ret)
+				return ret;
+			return adxl313_set_measure_en(data, true);
+		case IIO_EV_DIR_FALLING:
+			ret = regmap_write(data->regmap,
+					   adxl313_act_thresh_reg[ADXL313_INACTIVITY],
+					   regval);
+			if (ret)
+				return ret;
+			return adxl313_set_measure_en(data, true);
+		default:
+			return -EINVAL;
+		}
+	case IIO_EV_INFO_PERIOD:
+		ret = adxl313_set_inact_time_s(data, val);
 		if (ret)
 			return ret;
 		return adxl313_set_measure_en(data, true);
@@ -721,6 +801,17 @@ static int adxl313_push_event(struct iio_dev *indio_dev, int int_stat)
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
 	if (FIELD_GET(ADXL313_INT_WATERMARK, int_stat)) {
 		samples = adxl313_get_samples(data);
 		if (samples < 0)
@@ -895,6 +986,14 @@ int adxl313_core_probe(struct device *dev,
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


