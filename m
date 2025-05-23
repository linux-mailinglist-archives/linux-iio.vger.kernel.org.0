Return-Path: <linux-iio+bounces-19846-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 830C4AC2BDF
	for <lists+linux-iio@lfdr.de>; Sat, 24 May 2025 00:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54D337BD4E5
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 22:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F08BA221F3C;
	Fri, 23 May 2025 22:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dml5wMJB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8F3221264;
	Fri, 23 May 2025 22:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748039766; cv=none; b=N5EySiAyAGbxpNs/Fe2DFhqfn4G7uEIwwWCC0eSeEm7weMJo4tsK3TUkEZ/0U/vOQmfaYqt0f8zk8DB3XvfAcBdWwAowfNu1VE/4LuBX8PSfK/pe33fpiR5eTV8owVHe9nWaHRhcw0FFPzLIRpHNb7Ux0449ZlaEhURJBjw/UhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748039766; c=relaxed/simple;
	bh=rrbLsyU2u49meinO/TkASP7pAqwIfEaeD0GzK/lkINs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ryzx1m3r/fwMBKcLqJt4jlbMdu0Tc4ISrQGTNmKXIyiyxH6lHFEQ67YeRJmNL6l/EELx4Rax/yjsDi+x10riBW9NvigjMZwrZ9J/ydv66Se3Wmat2v5wpi9V7aYSVvi1WQZPeBbqqB57yTHt3che1TKkOndx56vXqassE7Xpdc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dml5wMJB; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a37b5de515so59811f8f.2;
        Fri, 23 May 2025 15:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748039763; x=1748644563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KB/N79A1bIujUdbyiBjqb32NKTK8A93/X+NHfWL089s=;
        b=Dml5wMJBTCs2uzYtNc3U0LFt9hzkoy2VjvpoI0JpmAHML0Kt46WxCnc2u12OXoSv5+
         0rSB2alO+2Fmfu5sH5PGmsiSmQMDdNoqVHRUNnFNjUbJKjhxUMM6OALJq9QeWO5ulEQx
         SxvpMS3ofHoerjPy3C3jDGkV0EhQNkNmrn1X1vm8RCqX4K9JM/ajAdgS3GJYP7R6RgDa
         k628jAw5NFEc38Tx3gnnGVsa4XqWl5A0RhKiTs/NwmvH7Nvv3k55K359q73JQLv7Ywdx
         /oIhlcjpJTDkxNCXCQh/PeKN9payft3wM+hN4qeMKg520z1NgzF4X7qGRF/Ef25fkRha
         LYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748039763; x=1748644563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KB/N79A1bIujUdbyiBjqb32NKTK8A93/X+NHfWL089s=;
        b=BGX34BkdzOtrMdn5kENEV8sh9wYCenR2R1iz8d8730MwQOahCCip467Y93QxfZeXBG
         BUkwu1Q+na8NcxIwqot4qjYQV6BRyrZPxcohUnmeO8TEhhdc4SM8PN8kj02NbbWDAgwk
         3yFxKc95vOwQ3/yoBG22SzttoxXfiooyA+zEUku25aLAuBFLPoroEDAjPVjxtxGXB70g
         2RuC5l8hEiP2e1D6t5Uts9RaZmQP0vhkN502R/bSYQfl2odB0albb9bJWN9COO1FmgnZ
         w7HjPg6nJbeQIZBD37Y2xCw81Jn1b9dkZApLhoyjeq2KIE2K5ZYRePtyhD860nCbl29B
         bOlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJH5LFdURPtd+yDO7RDwGyQZEtZgDHb15G1ctxGMQ2b1FJWAWgnGCnYkBwPF0G3zcairwLOwbZbVpuHHK1@vger.kernel.org, AJvYcCUoTyZY9vMlS/RWe+VybYHlcV77jwPuWW1Rj9gaDN92EAcVZiiPbpLuWHrF4qEzL3N8AzsqEmhwba5W@vger.kernel.org, AJvYcCVuZEaZNeKIgL1Tf5b3yvxr+hYKIrt6yPzCYubUbPIaUgVU5E+cWmgEZN8qat8+VtCReWGHSIh5FtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPyB3SEqTyMVkERx1T8cdiyiQimwoqTkz5Xyi9lacjecklj51H
	UDro3ii/9dZWcxtPVODb3PFQ1nywNPBPhjCbgrSlSW49eWuOriq1m7WDmTpn1XiD
X-Gm-Gg: ASbGncvnYJHFeQsmYoOa90yAfOFDGVwZxJHGuR7dbWrT5Oeh1FFjKYJ0AIlWP8ribck
	B95iUcrm5JrEhPZlbUrYVQ6pT1SfIoEKeWgCWyg8MZGmrbHpVUfL+Avtk0l8wy/pFo2j6HwdUhJ
	dq3LUkVJaJ8g1QBC/rhsppF0hulPym1N+ixYKCsLQ3O61JjlLs+fNmsIygK3wcLbID5xaVh0qJ3
	SAlaM3o0j3nCRI+IWSvB80J4tdDPbc8kJ/JbJ2sB4CbHBB4Qry5lWobyoCOpKbFAS4k6uUxuvr4
	LuUFnBBzHWK2ACBfydhKPWiVPqqHoB2+3X0uz8J2gx0NADVKjmGsRKpXsabRdOV5D7uDXurNSmJ
	vcdgWBPrTY+4ssGI1oNhplg==
X-Google-Smtp-Source: AGHT+IHTemefUyS6YnRl4lfHtFoIINTY2RndonTHs2vdWzL0nxCrLCqR3zy6fJ42HiVHttByl2Kjvw==
X-Received: by 2002:a05:600c:c0c3:10b0:439:94f8:fc7b with SMTP id 5b1f17b1804b1-44c90f4ccb1mr1498025e9.0.1748039762688;
        Fri, 23 May 2025 15:36:02 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6b29672sm165202375e9.3.2025.05.23.15.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 15:36:02 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: l.rubusch@gmail.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/12] iio: accel: adxl313: add inactivity sensing
Date: Fri, 23 May 2025 22:35:21 +0000
Message-Id: <20250523223523.35218-11-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250523223523.35218-1-l.rubusch@gmail.com>
References: <20250523223523.35218-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl313_core.c | 149 ++++++++++++++++++++++++-------
 2 files changed, 121 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
index 8c68cff7569c..374e4bfe6e05 100644
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
index 74bb7cfe8a55..f7baca814da7 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -30,18 +30,22 @@
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
@@ -254,6 +258,14 @@ static const struct iio_event_spec adxl313_fake_chan_events[] = {
 		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
 		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
 	},
+	{
+		/* inactivity */
+		.type = IIO_EV_TYPE_MAG,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_PERIOD),
+	},
 };
 
 enum adxl313_chans {
@@ -334,6 +346,15 @@ static int adxl313_read_freq_avail(struct iio_dev *indio_dev,
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
@@ -346,10 +367,10 @@ static int adxl313_is_act_inact_en(struct adxl313_data *data,
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
@@ -367,12 +388,14 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
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
 
 	ret = regmap_assign_bits(data->regmap, ADXL313_REG_ACT_INACT_CTL,
 				 axis_ctrl, cmd_en);
@@ -383,9 +406,17 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
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
 	return regmap_assign_bits(data->regmap, ADXL313_REG_INT_ENABLE,
-				  adxl313_act_int_reg[type],
-				  cmd_en && threshold);
+				  adxl313_act_int_reg[type], en);
 }
 
 static int adxl313_read_raw(struct iio_dev *indio_dev,
@@ -474,6 +505,8 @@ static int adxl313_read_event_config(struct iio_dev *indio_dev,
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
 		return adxl313_is_act_inact_en(data, ADXL313_ACTIVITY);
+	case IIO_EV_DIR_FALLING:
+		return adxl313_is_act_inact_en(data, ADXL313_INACTIVITY);
 	default:
 		return -EINVAL;
 	}
@@ -493,6 +526,8 @@ static int adxl313_write_event_config(struct iio_dev *indio_dev,
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
 		return adxl313_set_act_inact_en(data, ADXL313_ACTIVITY, state);
+	case IIO_EV_DIR_FALLING:
+		return adxl313_set_act_inact_en(data, ADXL313_INACTIVITY, state);
 	default:
 		return -EINVAL;
 	}
@@ -507,6 +542,8 @@ static int adxl313_read_event_value(struct iio_dev *indio_dev,
 {
 	struct adxl313_data *data = iio_priv(indio_dev);
 	unsigned int act_threshold;
+	unsigned int inact_threshold;
+	unsigned int inact_time_s;
 	int ret;
 
 	/* Measurement stays enabled, reading from regmap cache */
@@ -514,19 +551,38 @@ static int adxl313_read_event_value(struct iio_dev *indio_dev,
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
@@ -550,16 +606,30 @@ static int adxl313_write_event_value(struct iio_dev *indio_dev,
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
+		/* The scale factor is 15.625 mg/LSB */
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
@@ -720,6 +790,17 @@ static int adxl313_push_event(struct iio_dev *indio_dev, int int_stat)
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
@@ -890,6 +971,14 @@ int adxl313_core_probe(struct device *dev,
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


