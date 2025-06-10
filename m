Return-Path: <linux-iio+bounces-20393-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FBFAD456D
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 00:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE4443A33C3
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 22:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0805C28A1E2;
	Tue, 10 Jun 2025 21:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/P0F71m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1C0284B4A;
	Tue, 10 Jun 2025 21:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749592794; cv=none; b=gXz2KLFQQ7AZpf8/rM1mclDWp7LXZtzWt09uR3DG+kb3YziXcEoKjPjK9a4MW0IyZ6e4hhO8xQ3TdtP8x2QVlgXmOJDa4p8Rz/cU1DoHaOxFDDIuU5RhmaiWyoD3VmWQdRT7X+OJLvDNhL5z/CHppVwrNGBjtGDegliFcuDu7VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749592794; c=relaxed/simple;
	bh=Jsj037GkRZrMWcRwPNezEY24we0hZ51pw2yLxPNmPfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yo150vTt+E+8T/d/9i8E1bJCW+7LXjq0xdhZExg4Kn8IOUYrhpZ6k9WWx+H2v8QPNtNkAIGbmqCfrgvwaEZmsLcOioAw0rV43DYxp16daOUc7EQWtbPnrxFqD0ivJjzTS1u1sRuD/aC2XglFfJj7+0Xbhq6MxZkLWNQJo4JjkFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/P0F71m; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a4e749d7b2so794985f8f.0;
        Tue, 10 Jun 2025 14:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749592791; x=1750197591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2Kh1AXLqZ10k32T7HjAyP7XDK1Denw+eFx0BnkCDuc=;
        b=m/P0F71mHe4FAa03OqrIN7RP5VAnr7Af/Twb/mlNoFI2/8X+NuV09rHBNNHP99pg7M
         /4qm/ooHy3ZQkGOziyF7slp6a1bsk8Yr9v1eYIX5xgw0tA4NKHUMXKw1VnvEPKj8Kv2f
         n+4dErIWlzYf6kYwNhrhHt+nNxf77NcG3ancUtd3PoGts+idmRql7q0u0ShH1WD1fz1B
         JoFVyDZxNx0MlfmCiWUGqMHitQIQ6gil/D6pKnEhOKfhaNmYzrFzzQ0QYttdNoiAOk5n
         7tAyiKOQjJ8jgildngjj/6sDG1G+E5AYj3xvIPFuMUBVyd5BStABE8uPHfn1lsFjeMhf
         iomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749592791; x=1750197591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d2Kh1AXLqZ10k32T7HjAyP7XDK1Denw+eFx0BnkCDuc=;
        b=KFIm2kOvhvNg8mXCSpYV2GLIAcW7eUIPC8EXUq3UFxhkOA5fcJPft4U6R21dmYgLtD
         4pmXaNqgcLTr5qo278pj1SV1mqerjnO2TWzg4xuWDUafS93oYsB4ZKOcRGGaeLPdQI5I
         GD4mwVrlSJPeABjlRfPz3yWe2UrGWIDm/FVRk4fz8GugYH8oZF52/SUONG0yEeL5NL7A
         n4uJOWI45T4JwLegXNF5n6SCr841iC/II6i+84NgVopKHSOVsK8HLt70jl3m7Rh3f7h+
         EYussEL7wpm8Dt1va9t+ajUgO+nucD9ZLl71JIBMA3Ug1dny1saA1RJ0aRk5Fuu5ruBK
         6GVg==
X-Forwarded-Encrypted: i=1; AJvYcCWh2pO4mqhRE5LxT+/Cq/QFDF2UslhrTgNPX+O+MpkBF8xBpIq9a51uaNj7Cw9I7xmqvjwuwNqiS7c=@vger.kernel.org, AJvYcCXZyjLto9pkAS38T0d1iKZDdatA0LBiLnhVUm4qtt8ndp17Q6J6MNHK5db8pIeMSiUG8hn9OSt4SYpuJsG3@vger.kernel.org
X-Gm-Message-State: AOJu0YzerKrTmtL2MD47u7mnAQw9EDibFvEorpM38kQ4wfUAxvNtd3C7
	GNEHKWSdx/FEKrAX4Xbvsfms5QzPLpZAwRovweT2Xq9+BVi/lmm1Tgr1
X-Gm-Gg: ASbGncv/2UdlbT3Dpg+2I/4IgxOI2KIY7S7TAg+oNRFAfVICw6OauFfyjEnc5//q7p8
	mtK0eFOCgwV4+MiPbOpd3PHKko6Hi1iVqAOmlHReLSIfXl7IbgfdXztlNHOBHjzUgg0YmalaRnI
	tqa3ErB/6wO6KWD/oXx0cDyJdtwRjhTANIqZ22UL3hNHaGofGlaFDQldlis2MJyYkT7941SLWZl
	M5BUYdZDOzPW0h8zbG4m1B8z30ryDW+b3rQWywR5lHLqKG2yqZN8u1b2iJs7iayudeRTKy0tqi4
	esqGDVWD+nKTuQsjTGRgs2AWJE+S9LxL5XILhw7z5sauNYhG8F6+d5UqWi62P2bDADzDuyi70co
	8jiJSMGiuangKKORJR2BGqW1nPuBCKMrpeI2bxi+F464=
X-Google-Smtp-Source: AGHT+IGYIkaFaA6u3u+KgA8g3E9SI1brP3MVK3iWDe6KbEVWyof8EI+CID/TdwzzidctfvItxKlQkw==
X-Received: by 2002:a05:6000:4284:b0:3a3:71fb:7903 with SMTP id ffacd0b85a97d-3a55880794emr173161f8f.10.1749592790954;
        Tue, 10 Jun 2025 14:59:50 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53244f04dsm13312647f8f.73.2025.06.10.14.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 14:59:50 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v9 07/11] iio: accel: adxl345: add activity event feature
Date: Tue, 10 Jun 2025 21:59:29 +0000
Message-Id: <20250610215933.84795-8-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250610215933.84795-1-l.rubusch@gmail.com>
References: <20250610215933.84795-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the sensor detect and issue interrupts at activity. Activity
events are configured by a threshold. Initialize the activity threshold
register to a reasonable default value in probe. The value is taken from
the older ADXL345 input driver, to provide a similar behavior.

Activity, ODR configuration together with the range setting prepare the
activity/inactivity hysteresis setup, implemented in a follow up patch.
Thus parts of this patch prepare switch/case setups for the follow up
patches.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 205 ++++++++++++++++++++++++++++++-
 1 file changed, 202 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 2c4f045c741c..04b9f155872f 100644
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
@@ -144,6 +162,13 @@ struct adxl345_state {
 };
 
 static struct iio_event_spec adxl345_events[] = {
+	{
+		/* activity */
+		.type = IIO_EV_TYPE_MAG,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
+			BIT(IIO_EV_INFO_VALUE),
+	},
 	{
 		/* single tap */
 		.type = IIO_EV_TYPE_GESTURE,
@@ -237,6 +262,90 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
 				  ADXL345_POWER_CTL_MEASURE, en);
 }
 
+/* act/inact */
+
+static int adxl345_is_act_inact_en(struct adxl345_state *st,
+				   enum adxl345_activity_type type)
+{
+	unsigned int regval;
+	u32 axis_ctrl;
+	bool en;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADXL345_REG_ACT_INACT_CTRL, &axis_ctrl);
+	if (ret)
+		return ret;
+
+	switch (type) {
+	case ADXL345_ACTIVITY:
+		en = FIELD_GET(ADXL345_ACT_X_EN, axis_ctrl) |
+			FIELD_GET(ADXL345_ACT_Y_EN, axis_ctrl) |
+			FIELD_GET(ADXL345_ACT_Z_EN, axis_ctrl);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!en)
+		return en;
+
+	/* Check if corresponding interrupts are enabled */
+	ret = regmap_read(st->regmap, ADXL345_REG_INT_ENABLE, &regval);
+	if (ret)
+		return ret;
+
+	return adxl345_act_int_reg[type] & regval;
+}
+
+static int adxl345_set_act_inact_en(struct adxl345_state *st,
+				    enum adxl345_activity_type type,
+				    bool cmd_en)
+{
+	bool en;
+	unsigned int threshold;
+	u32 axis_ctrl;
+	int ret;
+
+	if (type == ADXL345_ACTIVITY) {
+		axis_ctrl = ADXL345_ACT_X_EN | ADXL345_ACT_Y_EN |
+				ADXL345_ACT_Z_EN;
+	} else {
+		axis_ctrl = 0x00;
+	}
+
+	/* Start configuring the sensor registers */
+	ret = adxl345_set_measure_en(st, false);
+	if (ret)
+		return ret;
+
+	ret = regmap_assign_bits(st->regmap, ADXL345_REG_ACT_INACT_CTRL,
+				 axis_ctrl, cmd_en);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->regmap, adxl345_act_thresh_reg[type], &threshold);
+	if (ret)
+		return ret;
+
+	en = false;
+
+	switch (type) {
+	case ADXL345_ACTIVITY:
+		en = FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, axis_ctrl) &&
+			threshold;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_assign_bits(st->regmap, ADXL345_REG_INT_ENABLE,
+				 adxl345_act_int_reg[type], cmd_en && en);
+	if (ret)
+		return ret;
+
+	return adxl345_set_measure_en(st, true);
+}
+
 /* tap */
 
 static int _adxl345_set_tap_int(struct adxl345_state *st,
@@ -634,6 +743,13 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return adxl345_is_act_inact_en(st, ADXL345_ACTIVITY);
+		default:
+			return -EINVAL;
+		}
 	case IIO_EV_TYPE_GESTURE:
 		switch (dir) {
 		case IIO_EV_DIR_SINGLETAP:
@@ -665,6 +781,15 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 	struct adxl345_state *st = iio_priv(indio_dev);
 
 	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return adxl345_set_act_inact_en(st,
+							ADXL345_ACTIVITY,
+							state);
+		default:
+			return -EINVAL;
+		}
 	case IIO_EV_TYPE_GESTURE:
 		switch (dir) {
 		case IIO_EV_DIR_SINGLETAP:
@@ -687,10 +812,30 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
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
+				*val = 62500 * act_threshold;
+				*val2 = MICRO;
+				return IIO_VAL_FRACTIONAL;
+			default:
+				return -EINVAL;
+			}
+		default:
+			return -EINVAL;
+		}
 	case IIO_EV_TYPE_GESTURE:
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
@@ -739,6 +884,26 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
 		return ret;
 
 	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			switch (dir) {
+			case IIO_EV_DIR_RISING:
+				val = DIV_ROUND_CLOSEST(val * MICRO + val2, 62500);
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
@@ -980,7 +1145,8 @@ static int adxl345_fifo_push(struct iio_dev *indio_dev,
 }
 
 static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
-			      enum iio_modifier tap_dir)
+			      enum iio_modifier tap_dir,
+			      enum iio_modifier act_dir)
 {
 	s64 ts = iio_get_time_ns(indio_dev);
 	struct adxl345_state *st = iio_priv(indio_dev);
@@ -1007,6 +1173,16 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
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
@@ -1034,6 +1210,7 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 	struct adxl345_state *st = iio_priv(indio_dev);
 	unsigned int regval;
 	enum iio_modifier tap_dir = IIO_NO_MOD;
+	enum iio_modifier act_dir = IIO_NO_MOD;
 	u32 axis_ctrl;
 	int int_stat;
 	int ret;
@@ -1042,7 +1219,8 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 	if (ret)
 		return IRQ_NONE;
 
-	if (FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, axis_ctrl)) {
+	if (FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, axis_ctrl) ||
+	    FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, axis_ctrl)) {
 		ret = regmap_read(st->regmap, ADXL345_REG_ACT_TAP_STATUS, &regval);
 		if (ret)
 			return IRQ_NONE;
@@ -1053,12 +1231,19 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
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
@@ -1219,6 +1404,20 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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


