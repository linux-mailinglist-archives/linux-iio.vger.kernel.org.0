Return-Path: <linux-iio+bounces-21275-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F49AF6601
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 01:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 085BB4E4584
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 23:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73DC2F6FB6;
	Wed,  2 Jul 2025 23:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSoe6EYE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6292F5C55;
	Wed,  2 Jul 2025 23:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497713; cv=none; b=VQw4oWToqQi8vb+irLaXo/PY9rS/x21TBO9o8IO1ygInCuEIQEM26kLEFmkRS0CeVpyS+AuVaYw60Jxue6DTvPs/pAUplW26lhXXC0raj2pG6HjQ5IaFm8T5fC1fXpTQBKB5J4ZGY/TB84FxZmH7q5nzNjoLRtHvTg/gemH9mQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497713; c=relaxed/simple;
	bh=eAwHb7oGlBf3N7BjmVMPwsNpP142rZLVOMlcInE+SZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jdb5RQllfPVY3VUIizK0IshDGODT9TobM0cWXKRuRpSxzKPcmh5+4aoSe3F2rabstE1L3RNjrlHGmwoGFIPcgRwKbRF72G2l1Jx7luxqgcLm99F3ojRvxJTdTezh2jGfJjDpQcmisM86Dnut7cH1ZtqASKms50pySSRTWPfilwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSoe6EYE; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae0b98ccc57so96604066b.0;
        Wed, 02 Jul 2025 16:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497710; x=1752102510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5rV+hcIRu9hiAshsYg5BPxUuS6hHYKbnLNPhgkfY+/M=;
        b=hSoe6EYEB2M/VLSzddrAswutt4BXDpCynfZ96XZyvT6lZPZwL4SJZhNl1EC6myrfEn
         65ahLypzVJcfwWFYRCbpL3lGDkGhFhEnVvGJo/CRR7dEW+U6G7wIkL3yeYG6g650cFwC
         ytzg7w0bV6dzcuCz+BlEHLl+jx7bvXdYaisBQoHm5FF2lwbUjdF8fA3VJRdS2KjjTPqZ
         Gd+KFxQNPsGLErim1s4zgR1vXgTwPJUuPBatCHnAPDzx8yu11w0HNuF0UdY4WXJDYaZv
         a/pUSGQKqyP9MqP2rH/AiJ8bCuAG+k9lKTGLgnOUA6/xqAHqV8TeeKAwlJIaYQ8GmDZr
         ZslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497710; x=1752102510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5rV+hcIRu9hiAshsYg5BPxUuS6hHYKbnLNPhgkfY+/M=;
        b=l14sZmzWKtRw3KMKTg2xqadkBP4j5O9ojwTAdFEEAntD5/utX0UM8xjGfZectAVxT7
         xsiE2Nb7QrLyc7ypa3N2clr8XqHNQ9Q6i+ye+6HDoeaGLWFFh5U2zjd1CKRy5Ol1/SmH
         OWsSsdfYLXyZDDlr/fiim0D1RmQiB+N6QuvAnq9Ucpg7wLaSoZIuJV0gF42QRiXm3Qut
         U1oxrckR73XvGBrDNXlIjxrT3qnL+2cb7ht/dv3ILi9Tfzo1vy2hnAAqcOK6IYu9/6rK
         FFn8StpcirZbaOk5J93K+DdXKp2BnxS/LKvi4Rnj9L7QClHFMS+bBT21LMDLyLxq6KSt
         JKZA==
X-Forwarded-Encrypted: i=1; AJvYcCUFyC+M6930vp2fHGYll3BFnndnzr3AKyS1k9z5dHMUaNj+H+i2BdHCejEdsVruXs+R+EqbbnLXM94=@vger.kernel.org, AJvYcCX9LcDxiLMbUDDQ3lQfCMjtQKZKa3/uon1E1pqpi2cMq9QQm/7CFvl2By/jE8blMbs5vfaSCgSzHlv5@vger.kernel.org, AJvYcCXrKsT11Q/2WJL9prLbUHt70+PeZRRjF2IaCRkx49HmiLRXAel2v8aH5BXSTlO/KXwH3PDXuvRptGsokckk@vger.kernel.org
X-Gm-Message-State: AOJu0YwJH2bf36KjBaX2JcTktTwy0skfGnjuODcPWaOuza6qZPc9kaFq
	81Xm+L5mKVcfrCPNO+CR7MDtH6zL3pecduRTSt1NEY2aAzLVaFm+FZwf
X-Gm-Gg: ASbGncsqTmNZ5Dwp7vZMFGvY54HrGOvVzq981O6Ve+fIURaXTsyhk1eg2UoqUTMXij7
	Zg/lOE57IcR5LUHUmnXKhSjIeLRePoaFEy1/EOfUBOXOmrqMEyvEnHUrJjvomj6D7f4PcuL+Xii
	xgMY2ye4TLkqHxyF7DhpDUzuOsdLQfxKrd1dd7ZMvV0dZe643v+f06hgz6B5cdz3mY6QyY5o5k4
	vpWEuil+aOvkVUqeIMoYGABJ/iHUp1nYzpm2uIGTrtX6NmA8Ue8XzP3IrSAaBtpoyXpZjrWbXDt
	5e3XtfGD4/JVWNy8PGSgF+dF8nNo5+uNP/Avl05mJLwW8yA0DKJhD9jSt1TPnUL272rHwgSpWHH
	jBz/+M0HiMT99/ojKAIdzKNNCZfFtM8GD
X-Google-Smtp-Source: AGHT+IG5radwdNOkIg5iSCE3Xy/+Zuhz2bOwm94BK0tFCBgjvZTTxthhHqwYKpitQWD7+ih+zMs50A==
X-Received: by 2002:a17:907:9405:b0:ade:9b52:4d84 with SMTP id a640c23a62f3a-ae3e29d6e00mr6619566b.15.1751497709458;
        Wed, 02 Jul 2025 16:08:29 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353ca18bbsm1158355566b.151.2025.07.02.16.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:08:29 -0700 (PDT)
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
Subject: [PATCH v7 5/8] iio: accel: adxl313: add inactivity sensing
Date: Wed,  2 Jul 2025 23:08:16 +0000
Message-Id: <20250702230819.19353-6-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250702230819.19353-1-l.rubusch@gmail.com>
References: <20250702230819.19353-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl313_core.c | 110 ++++++++++++++++++++++++++++++-
 2 files changed, 110 insertions(+), 2 deletions(-)

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
index 828b46b2254d..e904dee4dc2b 100644
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
@@ -253,6 +257,17 @@ static const struct iio_event_spec adxl313_activity_events[] = {
 	},
 };
 
+static const struct iio_event_spec adxl313_inactivity_events[] = {
+	{
+		/* inactivity */
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
@@ -269,6 +284,14 @@ static const struct iio_chan_spec adxl313_channels[] = {
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
@@ -331,6 +354,15 @@ static int adxl313_read_freq_avail(struct iio_dev *indio_dev,
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
@@ -348,6 +380,10 @@ static int adxl313_is_act_inact_en(struct adxl313_data *data,
 		if (!FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl))
 			return false;
 		break;
+	case ADXL313_INACTIVITY:
+		if (!FIELD_GET(ADXL313_INACT_XYZ_EN, axis_ctrl))
+			return false;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -366,6 +402,7 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 {
 	unsigned int axis_ctrl;
 	unsigned int threshold;
+	unsigned int inact_time_s;
 	int ret;
 
 	if (cmd_en) {
@@ -377,6 +414,18 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 
 		if (!threshold) /* Just ignore the command if threshold is 0 */
 			return 0;
+
+		/* When turning on inactivity, check if inact time is valid */
+		if (type == ADXL313_INACTIVITY) {
+			ret = regmap_read(data->regmap,
+					  ADXL313_REG_TIME_INACT,
+					  &inact_time_s);
+			if (ret)
+				return ret;
+
+			if (!inact_time_s)
+				return 0;
+		}
 	}
 
 	/* Start modifying configuration registers */
@@ -389,6 +438,9 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 	case ADXL313_ACTIVITY:
 		axis_ctrl = ADXL313_ACT_XYZ_EN;
 		break;
+	case ADXL313_INACTIVITY:
+		axis_ctrl = ADXL313_INACT_XYZ_EN;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -481,11 +533,14 @@ static int adxl313_write_raw(struct iio_dev *indio_dev,
 
 static int adxl313_read_mag_config(struct adxl313_data *data,
 				   enum iio_event_direction dir,
-				   enum adxl313_activity_type type_act)
+				   enum adxl313_activity_type type_act,
+				   enum adxl313_activity_type type_inact)
 {
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
 		return !!adxl313_is_act_inact_en(data, type_act);
+	case IIO_EV_DIR_FALLING:
+		return !!adxl313_is_act_inact_en(data, type_inact);
 	default:
 		return -EINVAL;
 	}
@@ -494,11 +549,14 @@ static int adxl313_read_mag_config(struct adxl313_data *data,
 static int adxl313_write_mag_config(struct adxl313_data *data,
 				    enum iio_event_direction dir,
 				    enum adxl313_activity_type type_act,
+				    enum adxl313_activity_type type_inact,
 				    bool state)
 {
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
 		return adxl313_set_act_inact_en(data, type_act, state);
+	case IIO_EV_DIR_FALLING:
+		return adxl313_set_act_inact_en(data, type_inact, state);
 	default:
 		return -EINVAL;
 	}
@@ -514,7 +572,8 @@ static int adxl313_read_event_config(struct iio_dev *indio_dev,
 	switch (type) {
 	case IIO_EV_TYPE_MAG:
 		return adxl313_read_mag_config(data, dir,
-					       ADXL313_ACTIVITY);
+					       ADXL313_ACTIVITY,
+					       ADXL313_INACTIVITY);
 	default:
 		return -EINVAL;
 	}
@@ -532,6 +591,7 @@ static int adxl313_write_event_config(struct iio_dev *indio_dev,
 	case IIO_EV_TYPE_MAG:
 		return adxl313_write_mag_config(data, dir,
 						ADXL313_ACTIVITY,
+						ADXL313_INACTIVITY,
 						state);
 	default:
 		return -EINVAL;
@@ -542,9 +602,11 @@ static int adxl313_read_mag_value(struct adxl313_data *data,
 				  enum iio_event_direction dir,
 				  enum iio_event_info info,
 				  enum adxl313_activity_type type_act,
+				  enum adxl313_activity_type type_inact,
 				  int *val, int *val2)
 {
 	unsigned int threshold;
+	unsigned int period;
 	int ret;
 
 	switch (info) {
@@ -559,9 +621,25 @@ static int adxl313_read_mag_value(struct adxl313_data *data,
 			*val = threshold * 15625;
 			*val2 = MICRO;
 			return IIO_VAL_FRACTIONAL;
+		case IIO_EV_DIR_FALLING:
+			ret = regmap_read(data->regmap,
+					  adxl313_act_thresh_reg[type_inact],
+					  &threshold);
+			if (ret)
+				return ret;
+			*val = threshold * 15625;
+			*val2 = MICRO;
+			return IIO_VAL_FRACTIONAL;
 		default:
 			return -EINVAL;
 		}
+	case IIO_EV_INFO_PERIOD:
+		ret = regmap_read(data->regmap, ADXL313_REG_TIME_INACT,
+				  &period);
+		if (ret)
+			return ret;
+		*val = period;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -571,6 +649,7 @@ static int adxl313_write_mag_value(struct adxl313_data *data,
 				   enum iio_event_direction dir,
 				   enum iio_event_info info,
 				   enum adxl313_activity_type type_act,
+				   enum adxl313_activity_type type_inact,
 				   int val, int val2)
 {
 	unsigned int regval;
@@ -584,9 +663,15 @@ static int adxl313_write_mag_value(struct adxl313_data *data,
 			return regmap_write(data->regmap,
 					    adxl313_act_thresh_reg[type_act],
 					    regval);
+		case IIO_EV_DIR_FALLING:
+			return regmap_write(data->regmap,
+					    adxl313_act_thresh_reg[type_inact],
+					    regval);
 		default:
 			return -EINVAL;
 		}
+	case IIO_EV_INFO_PERIOD:
+		return adxl313_set_inact_time_s(data, val);
 	default:
 		return -EINVAL;
 	}
@@ -605,6 +690,7 @@ static int adxl313_read_event_value(struct iio_dev *indio_dev,
 	case IIO_EV_TYPE_MAG:
 		return adxl313_read_mag_value(data, dir, info,
 					      ADXL313_ACTIVITY,
+					      ADXL313_INACTIVITY,
 					      val, val2);
 	default:
 		return -EINVAL;
@@ -624,6 +710,7 @@ static int adxl313_write_event_value(struct iio_dev *indio_dev,
 	case IIO_EV_TYPE_MAG:
 		return adxl313_write_mag_value(data, dir, info,
 					       ADXL313_ACTIVITY,
+					       ADXL313_INACTIVITY,
 					       val, val2);
 	default:
 		return -EINVAL;
@@ -784,6 +871,17 @@ static int adxl313_push_events(struct iio_dev *indio_dev, int int_stat)
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
 
@@ -989,6 +1087,14 @@ int adxl313_core_probe(struct device *dev,
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


