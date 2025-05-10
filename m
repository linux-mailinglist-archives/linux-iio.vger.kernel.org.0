Return-Path: <linux-iio+bounces-19413-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C755FAB25A3
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 00:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380C99E1BD8
	for <lists+linux-iio@lfdr.de>; Sat, 10 May 2025 22:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC8421ADC3;
	Sat, 10 May 2025 22:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0Ji0dII"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E846D217719;
	Sat, 10 May 2025 22:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746917085; cv=none; b=Ui5Kq2E35VsEWwaaYtY13+uHU8x+p9RgU5jrJ9/QNMqlhVByrzLs6zIk4Vayd/7hbZg2gIGhmrvu1ow/5BhH0d38jAIeZJXH0crBmCPilp0e6PYrDAYAL+7msbgDL7ZU/agODE8xWpkZGcG43UtzMRo/cBqhOSQ37FQX/+h0QBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746917085; c=relaxed/simple;
	bh=8KQC0TWXqIvCCF6ajMwFgZWvFYTt/EXi+/lxbNKX7Y4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nm4lVlK+csiSywKTZAgZcUkC53dUZtWC/G6DOEhpmwXjqFtib5eZwRogx5qHEXTtAUpr/nLGdmm0tVuXxibwGAwTGzo9FmOW/0NCzDPPFmRkJ4bM8ptOCo82K55nNzfeIDC8qz3OBDHt/7ZZTx92U+fRSGAqpGmPFGKb1Ii5cRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0Ji0dII; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfe99f2a7so4013355e9.2;
        Sat, 10 May 2025 15:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746917081; x=1747521881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9lGv3RpTEO+CVygRuJVfKXfD/b84o8z4MvMG3CkyMU=;
        b=T0Ji0dIIQSa8P4YYtX/dRoe0TITnS1ytH+e75WImyxCZ2cM/ot8SFXmgycNEnoAh3v
         /3wrai4rQLGxKgJ1bwyJ9EOhQVFo1sm7nmOZ4pRJWxx0jDNIYLrwVckZXserFKK5Od9X
         nmUNAlw8b6C1aoKEjAVESP0mVRFVW7Ot9ONsQQir/nOjP7y9ngtlca1sy3I+p6rmqUj8
         T6WX8ompy5WJVBJjkysiUgCiEsHYn6zuNYs5BG1prYuVSQXLrZ3uG0BZ+4bHhqViQU2J
         t3dvQ+0z8TbW3QDLKkiMtJmwawpNRluw27AFX2a+dwLKOybJ2t+mLgWiyHaL+5PvKv5z
         3tFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746917081; x=1747521881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9lGv3RpTEO+CVygRuJVfKXfD/b84o8z4MvMG3CkyMU=;
        b=PNnqytKtYZGCMHvzeXlCDjApbNnoSHqigBEoDuWtrVP4spu8GlJDTgW3pi46CM+/Tr
         AlrT+uCHTXyS76N2HanUVJvojohbjCZdChw9jk5mpy3DB6L+DHjgZPPD9dt5vcey6dP8
         lDDJBYg3L86GHsY80V31/y8tP7RDjMMIaoYHF180WRVtUji01iUlQiaAJShzNkxm0S0d
         MRxt/4jBGRV4rAqrC/h+WTedxVLZcvjtGrvDCi/jhs1oT/AuTGgoilkOGjmMjXTc4Ieh
         p3hQiIb4HCsMq49toFm9m2dfe3r9/ftnru6TMKzw1Sb2RI+gHnaCavOlqTOoynHjB6VS
         /Pyw==
X-Forwarded-Encrypted: i=1; AJvYcCX6ykwyt7HYFGN9MLR0Yt0cuhi6b3yWp5wcmE/eKFQyszaTTe01efw9Iz4Vrdv1s9hHDWBRiNoGIEivd6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+ddQ36D2gn5/rHBRAdTs+z7KojDHCYm4l0lTfpjpDYgdh+LiA
	pFnBKckpjjSHzT+HNc/eTJ7l8ACH6xkkVFu9kJ9g8RHDGUt8H/DtXnLtU8Rb
X-Gm-Gg: ASbGncuI0YbeY+nUQOH5jvbz+HjFmIpPnhUY+hg4iuScyZ8EYSRZJ5Es82VexUDxqix
	65QlrNjuSo5YDFn18T+A2SZoC1Fz3hs4vV/wmwB0+pnA24ybftzIyic/MoIp1YWTJnFJ3BUFI9E
	OMSryzCiaPX2LbZ1ajAdMIpbPMIhK2IvzKJvQsWhFQwW7Wv1dstqeGowGUFY5dLjjPRyl5W/YfS
	BsuOmOXMdPfpzGFskyLouKsIaYbBTIuh9zMp8qVP4t8ZYc7awM25o2FUdWudnrB3o4nFO6o4Ha2
	KuqI6COMrTwyFbwkLOZMUFpioKoBYfY25U9OwShZeUwOUoNS9tuWSWAovM+U3lHPugLA8I/VOVm
	O8mhUY97hWeuM/bHtWB8Zog==
X-Google-Smtp-Source: AGHT+IF+o+cVHi/fvzp7TCXsNMKu4h6YRUWz7yM6FJ0YxJisWLRe1iKzVpvPsJYDY+1Uv1EIDmky4g==
X-Received: by 2002:a5d:5f8f:0:b0:3a0:75ff:261f with SMTP id ffacd0b85a97d-3a1f6487679mr2088787f8f.11.1746917081204;
        Sat, 10 May 2025 15:44:41 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2f65sm7701015f8f.55.2025.05.10.15.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 15:44:40 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v8 3/7] iio: accel: adxl345: add activity event feature
Date: Sat, 10 May 2025 22:44:01 +0000
Message-Id: <20250510224405.17910-4-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250510224405.17910-1-l.rubusch@gmail.com>
References: <20250510224405.17910-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the sensor detect and issue interrupts at activity. Activity
events are configured by a threshold stored in regmap cache. Initialize
the activity threshold register to a reasonable default value in probe.
The value is taken from the older ADXL345 input driver, to provide a
similar behavior. Reset the activity/inactivity direction enabling
register in probe. Reset and initialization shall bring the sensor in a
defined initial state to prevent dangling settings when warm restarting
the sensor.

Activity, ODR configuration together with the range setting prepare the
activity/inactivity hystersesis setup, implemented in a follow up patch.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 218 ++++++++++++++++++++++++++++++-
 1 file changed, 215 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 7c093c0241de..32d014bd1e52 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -36,11 +36,16 @@
 #define ADXL345_REG_TAP_AXIS_MSK	GENMASK(2, 0)
 #define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3)
 #define ADXL345_REG_TAP_SUPPRESS	BIT(3)
+#define ADXL345_REG_ACT_AXIS_MSK	GENMASK(6, 4)
 
 #define ADXL345_TAP_Z_EN		BIT(0)
 #define ADXL345_TAP_Y_EN		BIT(1)
 #define ADXL345_TAP_X_EN		BIT(2)
 
+#define ADXL345_ACT_Z_EN		BIT(4)
+#define ADXL345_ACT_Y_EN		BIT(5)
+#define ADXL345_ACT_X_EN		BIT(6)
+
 /* single/double tap */
 enum adxl345_tap_type {
 	ADXL345_SINGLE_TAP,
@@ -64,6 +69,19 @@ static const unsigned int adxl345_tap_time_reg[] = {
 	[ADXL345_TAP_TIME_DUR] = ADXL345_REG_DUR,
 };
 
+/* activity/inactivity */
+enum adxl345_activity_type {
+	ADXL345_ACTIVITY,
+};
+
+static const unsigned int adxl345_act_int_reg[] = {
+	[ADXL345_ACTIVITY] = ADXL345_INT_ACTIVITY,
+};
+
+static const unsigned int adxl345_act_thresh_reg[] = {
+	[ADXL345_ACTIVITY] = ADXL345_REG_THRESH_ACT,
+};
+
 enum adxl345_odr {
 	ADXL345_ODR_0P10HZ = 0,
 	ADXL345_ODR_0P20HZ,
@@ -145,6 +163,13 @@ struct adxl345_state {
 };
 
 static struct iio_event_spec adxl345_events[] = {
+	{
+		/* activity */
+		.type = IIO_EV_TYPE_MAG,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
+	},
 	{
 		/* single tap */
 		.type = IIO_EV_TYPE_GESTURE,
@@ -239,6 +264,99 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
 	return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
 }
 
+/* act/inact */
+
+static int adxl345_is_act_inact_en(struct adxl345_state *st,
+				   enum iio_modifier axis,
+				   enum adxl345_activity_type type, bool *en)
+{
+	unsigned int regval;
+	u32 axis_ctrl;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADXL345_REG_ACT_INACT_CTRL, &axis_ctrl);
+	if (ret)
+		return ret;
+
+	if (type == ADXL345_ACTIVITY) {
+		switch (axis) {
+		case IIO_MOD_X:
+			*en = FIELD_GET(ADXL345_ACT_X_EN, axis_ctrl);
+			break;
+		case IIO_MOD_Y:
+			*en = FIELD_GET(ADXL345_ACT_Y_EN, axis_ctrl);
+			break;
+		case IIO_MOD_Z:
+			*en = FIELD_GET(ADXL345_ACT_Z_EN, axis_ctrl);
+			break;
+		default:
+			*en = false;
+			return -EINVAL;
+		}
+	}
+
+	if (*en) {
+		ret = regmap_read(st->regmap, ADXL345_REG_INT_ENABLE, &regval);
+		if (ret)
+			return ret;
+
+		*en = adxl345_act_int_reg[type] & regval;
+	}
+
+	return 0;
+}
+
+static int adxl345_set_act_inact_en(struct adxl345_state *st,
+				    enum iio_modifier axis,
+				    enum adxl345_activity_type type,
+				    bool cmd_en)
+{
+	bool en;
+	unsigned int threshold;
+	u32 axis_ctrl = 0;
+	int ret;
+
+	if (type == ADXL345_ACTIVITY) {
+		switch (axis) {
+		case IIO_MOD_X:
+			axis_ctrl = ADXL345_ACT_X_EN;
+			break;
+		case IIO_MOD_Y:
+			axis_ctrl = ADXL345_ACT_Y_EN;
+			break;
+		case IIO_MOD_Z:
+			axis_ctrl = ADXL345_ACT_Z_EN;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	if (cmd_en)
+		ret = regmap_set_bits(st->regmap,
+				      ADXL345_REG_ACT_INACT_CTRL, axis_ctrl);
+	else
+		ret = regmap_clear_bits(st->regmap,
+					ADXL345_REG_ACT_INACT_CTRL, axis_ctrl);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->regmap, adxl345_act_thresh_reg[type], &threshold);
+	if (ret)
+		return ret;
+
+	en = false;
+
+	if (type == ADXL345_ACTIVITY) {
+		en = FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, axis_ctrl) &&
+			threshold;
+	}
+
+	return regmap_update_bits(st->regmap, ADXL345_REG_INT_ENABLE,
+				  adxl345_act_int_reg[type],
+				  en ? adxl345_act_int_reg[type] : 0);
+}
+
 /* tap */
 
 static int _adxl345_set_tap_int(struct adxl345_state *st,
@@ -636,6 +754,18 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			ret = adxl345_is_act_inact_en(st, chan->channel2,
+						      ADXL345_ACTIVITY,
+						      &int_en);
+			if (ret)
+				return ret;
+			return int_en;
+		default:
+			return -EINVAL;
+		}
 	case IIO_EV_TYPE_GESTURE:
 		switch (dir) {
 		case IIO_EV_DIR_SINGLETAP:
@@ -667,6 +797,15 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 	struct adxl345_state *st = iio_priv(indio_dev);
 
 	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return adxl345_set_act_inact_en(st, chan->channel2,
+							ADXL345_ACTIVITY,
+							state);
+		default:
+			return -EINVAL;
+		}
 	case IIO_EV_TYPE_GESTURE:
 		switch (dir) {
 		case IIO_EV_DIR_SINGLETAP:
@@ -689,10 +828,30 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 				    int *val, int *val2)
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
+	unsigned int act_threshold;
 	unsigned int tap_threshold;
 	int ret;
 
 	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			switch (dir) {
+			case IIO_EV_DIR_RISING:
+				ret = regmap_read(st->regmap,
+						  adxl345_act_thresh_reg[ADXL345_ACTIVITY],
+						  &act_threshold);
+				if (ret)
+					return ret;
+
+				*val = act_threshold;
+				return IIO_VAL_INT;
+			default:
+				return -EINVAL;
+			}
+		default:
+			return -EINVAL;
+		}
 	case IIO_EV_TYPE_GESTURE:
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
@@ -743,6 +902,25 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
 		return ret;
 
 	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			switch (dir) {
+			case IIO_EV_DIR_RISING:
+				ret = regmap_write(st->regmap,
+						   adxl345_act_thresh_reg[ADXL345_ACTIVITY],
+						   val);
+				if (ret)
+					return ret;
+				break;
+			default:
+				return -EINVAL;
+			}
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
 	case IIO_EV_TYPE_GESTURE:
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
@@ -985,7 +1163,8 @@ static int adxl345_fifo_push(struct iio_dev *indio_dev,
 }
 
 static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
-			      enum iio_modifier tap_dir)
+			      enum iio_modifier tap_dir,
+			      enum iio_modifier act_dir)
 {
 	s64 ts = iio_get_time_ns(indio_dev);
 	struct adxl345_state *st = iio_priv(indio_dev);
@@ -1012,6 +1191,16 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
 			return ret;
 	}
 
+	if (FIELD_GET(ADXL345_INT_ACTIVITY, int_stat)) {
+		ret = iio_push_event(indio_dev,
+				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, act_dir,
+							IIO_EV_TYPE_MAG,
+							IIO_EV_DIR_RISING),
+				     ts);
+		if (ret)
+			return ret;
+	}
+
 	if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
 		samples = adxl345_get_samples(st);
 		if (samples < 0)
@@ -1039,6 +1228,7 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 	struct adxl345_state *st = iio_priv(indio_dev);
 	unsigned int regval;
 	enum iio_modifier tap_dir = IIO_NO_MOD;
+	enum iio_modifier act_dir = IIO_NO_MOD;
 	u32 axis_ctrl;
 	int int_stat;
 	int ret;
@@ -1047,7 +1237,8 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 	if (ret)
 		return IRQ_NONE;
 
-	if (FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, axis_ctrl)) {
+	if (FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, axis_ctrl) ||
+	    FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, axis_ctrl)) {
 		ret = regmap_read(st->regmap, ADXL345_REG_ACT_TAP_STATUS, &regval);
 		if (ret)
 			return IRQ_NONE;
@@ -1058,12 +1249,19 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 			tap_dir = IIO_MOD_Y;
 		else if (FIELD_GET(ADXL345_TAP_X_EN, regval))
 			tap_dir = IIO_MOD_X;
+
+		if (FIELD_GET(ADXL345_ACT_Z_EN, regval))
+			act_dir = IIO_MOD_Z;
+		else if (FIELD_GET(ADXL345_ACT_Y_EN, regval))
+			act_dir = IIO_MOD_Y;
+		else if (FIELD_GET(ADXL345_ACT_X_EN, regval))
+			act_dir = IIO_MOD_X;
 	}
 
 	if (regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, &int_stat))
 		return IRQ_NONE;
 
-	if (adxl345_push_event(indio_dev, int_stat, tap_dir))
+	if (adxl345_push_event(indio_dev, int_stat, tap_dir, act_dir))
 		goto err;
 
 	if (FIELD_GET(ADXL345_INT_OVERRUN, int_stat))
@@ -1224,6 +1422,20 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		if (ret)
 			return ret;
 
+		/*
+		 * Initialization with reasonable values to simplify operation
+		 * of the sensor. The default values are partly taken from the
+		 * older input driver for the ADXL345, and partly based on
+		 * recommendations in the datasheet.
+		 */
+		ret = regmap_write(st->regmap, ADXL345_REG_ACT_INACT_CTRL, 0);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(st->regmap, ADXL345_REG_THRESH_ACT, 6);
+		if (ret)
+			return ret;
+
 		ret = regmap_write(st->regmap, ADXL345_REG_THRESH_TAP, tap_threshold);
 		if (ret)
 			return ret;
-- 
2.39.5


