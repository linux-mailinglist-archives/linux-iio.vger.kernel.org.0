Return-Path: <linux-iio+bounces-14674-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E27A20A2B
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 13:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B809A3A5DDE
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 12:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0251D5ACD;
	Tue, 28 Jan 2025 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2dDZVCU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F5E1B412A;
	Tue, 28 Jan 2025 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738065709; cv=none; b=d1fiPy/GwmNGBffeIY4ufQH12PtsGffzVHcVUXz/RlcREA3k9T1Q1BuLspktXXAg9pZx8ogjNWGDKi9LYrbyLO3bjtytOquT0sQqJHOWclfwsmAvQ+EdLHvOaVqyv6/R6j0zFifwRuge6D4eOmDmorYGYcxRm2fMyRUakIrOtQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738065709; c=relaxed/simple;
	bh=b0Y4qK+EtkUXFA8A7omBr2akO/7BYmyJxAD6GQedwaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I3Zng/K9E9M6vmnAh1lpW+5rN8g+NUacLnE2rf0UHrVPDwgIeUB8XDazDTdPaMJHi3yKQKWAWKHj4agVPoN/b5kXtZLHV1wMv5cxpYkVlnsgYNRH7r/t+i/fNEN6EyNYjTadHNVfvoH3bmdm1W0GRObUrnsk86pXSLZtsiCbCM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g2dDZVCU; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa6a38e64e4so93391966b.0;
        Tue, 28 Jan 2025 04:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738065706; x=1738670506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZAln2CNkbhURcsDHLTlOdLPcb+aZKD8RZcU3/8yIGQ=;
        b=g2dDZVCUpGPDMLQOS8BfMQDp0WVAn7y8RReHjbFc7xQkDyMg9y57zy7b8jzzr1RHok
         I7lSKUllFw7lFlA99/baCu35R03fsuk4y/6juI2feZxbRPas4RoPdviOUs3/lkHFHnUO
         8NcCkqXBNDVH3ORcURZMfnAKOL6T0FpsZLqwhtuHjncZM3FB7qk4Xev6pTti4PRngC3I
         G28cgizu5xmvFWuzYPDviLsANYWSmsDE0Ni/mhh0CvlQiy0ufzc1QHwafBK2ZgtNBQlA
         imkS5uhDdLpyfHVbFmAbbwnmdUgbUVzPQmFusb3Q08TSvvs/9S0ZZDhPsIHwmndLMa5F
         WzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738065706; x=1738670506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZAln2CNkbhURcsDHLTlOdLPcb+aZKD8RZcU3/8yIGQ=;
        b=LCl6/BLYS+FWVKPAJztKUSzHki6dNwZY41GDNFdn+SnIEx6EUADl7BubMVf7BAAkpy
         7rrbpmnflCXSABBKsW4/XdOuHNauDjnlC49WJnbbZ6CtEVsWyWzlR0/zEb3Yy7FJe1Jc
         ORPxaHrAPFt3XmaabDzIG96C5R2jCdhLqeD70tuXf9S81oli8/ISP+XQUa4oKj5k0dZu
         Hqmlyq4/O10UJ9nPn8HTlWlaPlsTWNVNYL5Kua5I/Ni9Fbr3Kj8lFViYNZFnhQtal8im
         0ipTVBQAxz9W19lwyk233rbHaYqGwrrNYfM0ArzSCZzy3Z/kKSDVt6dPvGDlxxNVwTDa
         fZqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnA7Q6SwrGtIViZq4oVes0H/2QgVvVhyDkHXvgJoiJQO8z60SUvqQB/qjgPQRTrNGOqv4Er+62PwONIW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3SKav6oR1uR4XOUsNuD7NbqWqpMQTwk1MVkTGT1vaVfyGXx9Y
	+Rp+969VvbdiqW39YgP3YgfifmgGz0OOAoP2afp7g9ZetOssl0nH
X-Gm-Gg: ASbGncungpEbpZBfFeim9nItT1SO+fyA+gPR8N5zkj5mkM6Dw79uvGEkNAgr7dxTD3y
	1hhW2faBB7KbUQVLLSf7vei7y70Y2RFt8N2w8ub9wT8LvyXxPlSJ7I3Q1WYBK7kOC2h9FboajYx
	buYEnITyj/Sp8EBBxNGaHAzoxBuwn2LooGCjaIR9GsyelbY1xMgIpuEHZaZx8KsaXUgFiwCOpBs
	dOSfX290JEhaIYk9hRRIpeGIyvc4vlAyyXC1/713/RAIWI/VKcAcN31iChC/4uL7sFOnDN3BEnO
	mUzkMffC4XSAULYhwZgKS8IdnE+W9CrVepc74PWMo6G0B6i+TXHK77k1jvQrzBhU4vGOAg==
X-Google-Smtp-Source: AGHT+IFDKhCaAdGcEdaRC+OcWusjUkxRXv3jBSWYwfmcSpsWKk1kuqZr8WvKf3SyJy6JX3ErWqyLGQ==
X-Received: by 2002:a17:907:1b20:b0:ab6:92dc:8b98 with SMTP id a640c23a62f3a-ab692dc9244mr478974066b.8.1738065705586;
        Tue, 28 Jan 2025 04:01:45 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab69f8555b7sm418865966b.71.2025.01.28.04.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 04:01:45 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v1 12/12] iio: accel: adxl345: add inactivity feature
Date: Tue, 28 Jan 2025 12:01:00 +0000
Message-Id: <20250128120100.205523-13-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250128120100.205523-1-l.rubusch@gmail.com>
References: <20250128120100.205523-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add handling for inactivity events, together with threshold and timeout
to trigger the event. The event could be used for ODR and g range
reduction for power saving using low power modes or sleep modes, not
covered by this patch.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 167 ++++++++++++++++++++++++++-----
 1 file changed, 142 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 94c3ad818ba5..b9f42c56e8f1 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -123,6 +123,8 @@
 #define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3)
 #define ADXL345_REG_ACT_AXIS_MSK	GENMASK(6, 4)
 #define ADXL345_REG_ACT_ACDC_MSK	BIT(7)
+#define ADXL345_REG_INACT_AXIS_MSK	GENMASK(2, 0)
+#define ADXL345_REG_INACT_ACDC_MSK	BIT(3)
 
 enum adxl345_axis {
 	ADXL345_Z_EN = BIT(0),
@@ -155,6 +157,32 @@ static const unsigned int adxl345_tap_time_reg[3] = {
 	[ADXL345_TAP_TIME_DUR] = ADXL345_REG_DUR,
 };
 
+/* activity/inactivity */
+enum adxl345_activity_type {
+	ADXL345_ACTIVITY,
+	ADXL345_INACTIVITY
+};
+
+static const unsigned int adxl345_act_int_reg[2] = {
+	[ADXL345_ACTIVITY] = ADXL345_INT_ACTIVITY,
+	[ADXL345_INACTIVITY] = ADXL345_INT_INACTIVITY,
+};
+
+static const unsigned int adxl345_act_thresh_reg[2] = {
+	[ADXL345_ACTIVITY] = ADXL345_REG_THRESH_ACT,
+	[ADXL345_INACTIVITY] = ADXL345_REG_THRESH_INACT,
+};
+
+static const unsigned int adxl345_act_acdc_msk[2] = {
+	[ADXL345_ACTIVITY] = ADXL345_REG_ACT_ACDC_MSK,
+	[ADXL345_INACTIVITY] = ADXL345_REG_INACT_ACDC_MSK
+};
+
+static const unsigned int adxl345_act_axis_msk[2] = {
+	[ADXL345_ACTIVITY] = ADXL345_REG_ACT_AXIS_MSK,
+	[ADXL345_INACTIVITY] = ADXL345_REG_INACT_AXIS_MSK
+};
+
 struct adxl345_state {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
@@ -169,6 +197,11 @@ struct adxl345_state {
 	bool act_ac;
 	u8 act_value;
 
+	u32 inact_axis_ctrl;
+	bool inact_ac;
+	u8 inact_value;
+	u8 inact_time_s;
+
 	u32 tap_axis_ctrl;
 	u8 tap_threshold;
 	u32 tap_duration_us;
@@ -188,6 +221,11 @@ static struct iio_event_spec adxl345_events[] = {
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_RISING,
 	},
+	{
+		/* inactivity */
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+	},
 	{
 		/* single tap */
 		.type = IIO_EV_TYPE_GESTURE,
@@ -289,7 +327,8 @@ static inline int adxl345_write_interrupts(struct adxl345_state *st)
 
 /* act/inact */
 
-static int adxl345_write_act_axis(struct adxl345_state *st, bool en)
+static int adxl345_write_act_axis(struct adxl345_state *st,
+				  enum adxl345_activity_type type, bool en)
 {
 	int ret;
 
@@ -316,7 +355,9 @@ static int adxl345_write_act_axis(struct adxl345_state *st, bool en)
 	 * inactive and the inactivity interrupt is triggered.
 	 */
 	ret = regmap_update_bits(st->regmap, ADXL345_REG_ACT_INACT_CTRL,
-				 ADXL345_REG_ACT_ACDC_MSK, st->act_ac);
+				 adxl345_act_acdc_msk[type],
+				 (type == ADXL345_ACTIVITY
+				  ? st->act_ac : st->inact_ac));
 	if (ret)
 		return ret;
 
@@ -326,32 +367,52 @@ static int adxl345_write_act_axis(struct adxl345_state *st, bool en)
 	 * kept in sync, i.e. an axis will be generally enabled or disabled for
 	 * both equally, activity and inactivity detection.
 	 */
-	st->act_axis_ctrl = en
-		? st->act_axis_ctrl | ADXL345_REG_ACT_AXIS_MSK
-		: st->act_axis_ctrl & ~ADXL345_REG_ACT_AXIS_MSK;
+	if (type == ADXL345_ACTIVITY) {
+		st->act_axis_ctrl = en
+			? st->act_axis_ctrl | ADXL345_REG_ACT_AXIS_MSK
+			: st->act_axis_ctrl & ~ADXL345_REG_ACT_AXIS_MSK;
+
+		ret = regmap_update_bits(st->regmap, ADXL345_REG_ACT_INACT_CTRL,
+					 adxl345_act_axis_msk[type],
+					 st->act_axis_ctrl);
+		if (ret)
+			return ret;
 
-	ret = regmap_update_bits(st->regmap, ADXL345_REG_ACT_INACT_CTRL,
-				 ADXL345_REG_ACT_AXIS_MSK,
-				 st->act_axis_ctrl);
-	if (ret)
-		return ret;
+	} else {
+		st->inact_axis_ctrl = en
+			? st->inact_axis_ctrl | ADXL345_REG_INACT_AXIS_MSK
+			: st->inact_axis_ctrl & ~ADXL345_REG_INACT_AXIS_MSK;
 
+		ret = regmap_update_bits(st->regmap, ADXL345_REG_ACT_INACT_CTRL,
+					 adxl345_act_axis_msk[type],
+					 st->inact_axis_ctrl);
+		if (ret)
+			return ret;
+	}
 	return 0;
 }
 
-static int adxl345_set_act_int(struct adxl345_state *st)
+static int adxl345_set_act_int(struct adxl345_state *st,
+			       enum adxl345_activity_type type)
 {
 	bool args_valid;
 	bool axis_en;
 
-	axis_en = FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, st->act_axis_ctrl) > 0;
-	args_valid = axis_en && st->act_value > 0;
-	adxl345_intmap_switch_bit(st, args_valid, ADXL345_INT_ACTIVITY);
+	if (type == ADXL345_ACTIVITY) {
+		axis_en = FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, st->act_axis_ctrl) > 0;
+		args_valid = axis_en && st->act_value > 0;
+	} else {
+		axis_en = FIELD_GET(ADXL345_REG_INACT_AXIS_MSK, st->inact_axis_ctrl) > 0;
+		args_valid = axis_en && st->inact_value > 0 &&
+			st->inact_time_s > 0;
+	}
+	adxl345_intmap_switch_bit(st, args_valid, adxl345_act_int_reg[type]);
 
 	return adxl345_write_interrupts(st);
 }
 
-static int _adxl345_is_act_en(struct adxl345_state *st, bool *en)
+static int _adxl345_is_act_en(struct adxl345_state *st,
+			      enum adxl345_activity_type type, bool *en)
 {
 	int ret;
 	unsigned int regval;
@@ -360,42 +421,76 @@ static int _adxl345_is_act_en(struct adxl345_state *st, bool *en)
 	if (ret)
 		return ret;
 
-	*en = FIELD_GET(ADXL345_INT_ACTIVITY, regval) > 0;
+	*en = (adxl345_act_int_reg[type] & regval) > 0;
 
 	return 0;
 }
 
-static int _adxl345_set_act_en(struct adxl345_state *st, bool en)
+static int _adxl345_set_act_en(struct adxl345_state *st,
+			       enum adxl345_activity_type type, bool en)
 {
 	int ret;
 
-	ret = adxl345_write_act_axis(st, en);
+	ret = adxl345_write_act_axis(st, type, en);
 	if (ret)
 		return ret;
 
-	return adxl345_set_act_int(st);
+	return adxl345_set_act_int(st, type);
 }
 
 static int adxl345_is_act_en(struct adxl345_state *st, bool *en)
 {
-	return _adxl345_is_act_en(st, en);
+	return _adxl345_is_act_en(st, ADXL345_ACTIVITY, en);
 }
 
 static int adxl345_set_act_en(struct adxl345_state *st, bool en)
 {
-	return _adxl345_set_act_en(st, en);
+	return _adxl345_set_act_en(st, ADXL345_ACTIVITY, en);
 }
 
-static int _adxl345_set_act_value(struct adxl345_state *st, u8 val)
+static int adxl345_is_inact_en(struct adxl345_state *st, bool *en)
 {
-	st->act_value = val;
+	return _adxl345_is_act_en(st, ADXL345_INACTIVITY, en);
+}
 
-	return regmap_write(st->regmap, ADXL345_REG_THRESH_ACT, val);
+static int adxl345_set_inact_en(struct adxl345_state *st, bool en)
+{
+	return _adxl345_set_act_en(st, ADXL345_INACTIVITY, en);
+}
+
+static int _adxl345_set_act_value(struct adxl345_state *st,
+				  enum adxl345_activity_type type, u8 val)
+{
+	switch (type) {
+	case ADXL345_ACTIVITY:
+		st->act_value = val;
+		break;
+	case ADXL345_INACTIVITY:
+		st->inact_value = val;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_write(st->regmap, adxl345_act_thresh_reg[type], val);
 }
 
 static int adxl345_set_act_value(struct adxl345_state *st, u8 val)
 {
-	return _adxl345_set_act_value(st, val);
+	return _adxl345_set_act_value(st, ADXL345_ACTIVITY, val);
+}
+
+static int adxl345_set_inact_value(struct adxl345_state *st, u8 val)
+{
+	return _adxl345_set_act_value(st, ADXL345_INACTIVITY, val);
+}
+
+static int adxl345_set_inact_time_s(struct adxl345_state *st, u32 val_s)
+{
+	st->inact_time_s = min(val_s, 0xff);
+
+	return regmap_write(st->regmap, ADXL345_REG_TIME_INACT,
+			    st->inact_time_s);
 }
 
 /* tap */
@@ -1027,6 +1122,8 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
 	static IIO_DEVICE_ATTR_RW(in_accel_##A##_##C##_##E, 0)
 
 ADXL345_generate_iio_dev_attr_INT(activity, act, value);
+ADXL345_generate_iio_dev_attr_INT(activity, inact, value);
+ADXL345_generate_iio_dev_attr_INT(activity, inact, time_s);
 ADXL345_generate_iio_dev_attr_INT(freefall, ff, value);
 
 ADXL345_generate_iio_dev_attr_FRACTIONAL(gesture_singletap, tap, duration, MICRO, us);
@@ -1035,12 +1132,16 @@ ADXL345_generate_iio_dev_attr_FRACTIONAL(gesture_doubletap, tap, latent, MICRO,
 ADXL345_generate_iio_dev_attr_FRACTIONAL(freefall, ff, time, MILLI, ms);
 
 ADXL345_generate_iio_dev_attr_EN(activity, act);
+ADXL345_generate_iio_dev_attr_EN(activity, inact);
 ADXL345_generate_iio_dev_attr_EN(freefall, ff);
 ADXL345_generate_iio_dev_attr_EN(gesture_doubletap, suppressed);
 
 static struct attribute *adxl345_event_attrs[] = {
 	&iio_dev_attr_in_accel_activity_act_en.dev_attr.attr,
 	&iio_dev_attr_in_accel_activity_act_value.dev_attr.attr,
+	&iio_dev_attr_in_accel_activity_inact_en.dev_attr.attr,
+	&iio_dev_attr_in_accel_activity_inact_value.dev_attr.attr,
+	&iio_dev_attr_in_accel_activity_inact_time_s.dev_attr.attr,
 	&iio_dev_attr_in_accel_freefall_ff_en.dev_attr.attr,
 	&iio_dev_attr_in_accel_freefall_ff_value.dev_attr.attr,
 	&iio_dev_attr_in_accel_freefall_time_ms.dev_attr.attr,
@@ -1296,6 +1397,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
 			return ret;
 	}
 
+	if (FIELD_GET(ADXL345_INT_INACTIVITY, int_stat)) {
+		ret = iio_push_event(indio_dev,
+				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+							IIO_MOD_X_OR_Y_OR_Z,
+							IIO_EV_TYPE_THRESH,
+							IIO_EV_DIR_FALLING),
+				     ts);
+		if (ret)
+			return ret;
+	}
+
 	if (FIELD_GET(ADXL345_INT_FREE_FALL, int_stat)) {
 		ret = iio_push_event(indio_dev,
 				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
@@ -1412,6 +1524,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	 * setup.
 	 */
 	st->act_axis_ctrl = ADXL345_REG_ACT_AXIS_MSK;
+	st->inact_axis_ctrl = ADXL345_REG_INACT_AXIS_MSK;
+	st->inact_ac = 0;			/*    0 [dc]              */
 	st->act_ac = 0;
 	st->int_map = 0x00;			/* reset interrupts */
 
@@ -1422,6 +1536,9 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	st->tap_latent_us = 20;			/*   20 [0x14] -> .025    */
 
 	st->act_value = 6;			/*    6 [0x06]            */
+	st->inact_value = 4;			/*    4 [0x04]            */
+	st->inact_time_s = 3;			/*    3 [0x03] -> 3       */
+
 	st->ff_value = 8;			/*    8 [0x08]            */
 	st->ff_time_ms = 32;			/*   32 [0x20] -> 0.16    */
 
-- 
2.39.5


