Return-Path: <linux-iio+bounces-15259-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC803A2EA71
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 12:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BE087A5EED
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 11:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289911E9B34;
	Mon, 10 Feb 2025 11:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqWxA1lg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D081E990A;
	Mon, 10 Feb 2025 11:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185310; cv=none; b=dDExxnBzmMjqgWrKVtebw3qYXnuwtEKjMENrh9l1CJBhhmJKeMN6icZgHU2mgAVI0iBYmn2q0AI1vbbTrYLKKKBHfqak4msRvHKfvoW9LILYgGMtdJtnCHRZmy53HPnANF4KhOM5tlYTL/JWSWZ4IPtm3u0aQGanS8vmgsWUHtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185310; c=relaxed/simple;
	bh=xFCGQv3SGwTqSapsSEWJ0N08FlJruBGs76wdlSZIxhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kp4/PDoe0ajC/Atzmj5xI6z/UZ4rYRwTSldEHQ6YRUY7oQg58fbOZzFckvABw6yFFKo9T9/vVlDupc1inFzfiX38JcnTg/91g/tx58evuRno+A8SkOr4hMMYbzjm1bW6tLzH4srysP55VQHI1RDmh7SWUx+fUTydEM+Q9RROexA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqWxA1lg; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab7908ecb31so35115166b.1;
        Mon, 10 Feb 2025 03:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739185307; x=1739790107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIR2sPvBWBJ32kfSECe1rNdqkZ/8/PBESSaLWMDqlxY=;
        b=nqWxA1lg7wgRPZ0Jpi3RRQB293eACfp/O/TwdakZ1bevjEwvWuThpOG+91965YBTjr
         hwB0Aba9QJJbwXMpYviOpugavBhVj/lRc1Q6jFUMN0Kkjrxov0oNLRldEReaq8P+0hBc
         f+oRa9z5b3OHJfzLuOIYhxM6QIYSWer0DHDcRzHNohGf0tGkPhwCL/CQKqND+G3QEakk
         wQmf4O+lLpLVU/LP27oTCZPsFjdU9AdI7HT72/zASZskhyHnllUObdnLWU1LaLZQxDu3
         KdIc3rx0F0BxUbhzvo6RBhU7qtcy8OxvEZ71XU/DC3BafouJ6I/tUZV90yAP9t/XjTG5
         mCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739185307; x=1739790107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIR2sPvBWBJ32kfSECe1rNdqkZ/8/PBESSaLWMDqlxY=;
        b=CTd/iILmI0M0vYh8fA9G+Z57Fzj4plyScjBQRU9fWZa0JZhRLMh3JJP0e4MoKmCzPA
         wrlrT2EKm9V2p3Zc5uDnJOburucxlx3ACxME+4a9waV0ZD2sRUEu49Jb57rAGNT5jlyq
         nD0sYBqhHaYJ4MZAeyf34t1o2JAdQZB5Fk42oXtLL/GzVvKpTxdVwtuy/sWa8tRh/Zit
         WUpx4CPTRKhRYjEze0R111LggKoc1kchXY1QidT2NZJgqlR/ezNX8hlH9Ab1BwGo0opE
         LMI6bjRopr1+Wf6z5RwwG80pgu2v9xq57V/dkQ6RZ+tOw33jcM6eS8Srj7i0qB/jaoby
         cwag==
X-Forwarded-Encrypted: i=1; AJvYcCU+MbRV8o/ZONR+iwvr/L4RQU7H6O02W82VnLoMwskd+Q1PeeOeEsUplY+CuWYo9nbVDrSZaI2OiCZZqu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhOB4anI9YOzKSYU7rfe4dRDEpPwlNu2zL+QpA3kWIwCJOE041
	X0CJcLJvhgMR+Ui7mFJaguE5HndqdTmZrtk3cAW9mmBx0JfERpjh
X-Gm-Gg: ASbGncs9nXwUqv4z5/O/nsGmUbnQbjiz+2vkovZM2AGQirqx11jkVTs+rQwWQUpuJfj
	m7NhIQcNhTVZD85w3oHMxPlPi4PWJE9mvyTjO8mnvuOBCloAsmrsD196DJ94/5RYZGXcsZC8nm0
	Lac6OXrELFR78+7MMD9pVV4dBmxJv0aSOwY+0e2Xtu73LwG3X6RQRGaBd+01Mcf67Ls4miBMrMJ
	N36RTNG5dkt9kwbk5E0pfSxdvtv+Oer/VJKZrm1g5wZsri87qKQfM47yLEZvmokhlTHBztY/SUz
	BBPRa6pyZV4+hD+Ve3j9ar/aNYuNhaGbUOAw7FCIhekLhNNA+hNj7ghS5Kiv7bqa03VkVA==
X-Google-Smtp-Source: AGHT+IFZHhp+0uc6ye98f6pWt8fixbtYfy6EpFB95hPLyg0WdOAduUIHsequ2qV2RG8KkStiBluwiw==
X-Received: by 2002:a17:907:3f18:b0:ab7:cd83:98bb with SMTP id a640c23a62f3a-ab7cd839b0amr54973066b.5.1739185306705;
        Mon, 10 Feb 2025 03:01:46 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7a5a78369sm486987266b.136.2025.02.10.03.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 03:01:46 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 12/14] iio: accel: adxl345: add inactivity feature
Date: Mon, 10 Feb 2025 11:01:17 +0000
Message-Id: <20250210110119.260858-13-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210110119.260858-1-l.rubusch@gmail.com>
References: <20250210110119.260858-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the inactivity feature of the sensor. When activity and inactivity
is enabled, a link bit will be set linking activity and inactivity
handling. Additionally, the auto-sleep mode will be enabled. Due to the
link bit the sensor is going to auto-sleep when inactivity was
detected.

Inactivity detection needs a threshold to be configured, and a time
after which it will go into inactivity state if measurements under
threshold.

When a ODR is configured this time for inactivity is adjusted with a
corresponding reasonable default value, in order to have higher
frequencies and lower inactivity times, and lower sample frequency but
give more time until inactivity. Both with reasonable upper and lower
boundaries, since many of the sensor's features (e.g. auto-sleep) will
need to operate beween 12.5 Hz and 400 Hz. This is a default setting
when actively changing sample frequency, explicitly setting the time
until inactivity will overwrite the default.

Similarly, setting the g-range will provide a default value for the
activity and inactivity thresholds. Both are implicit defaults, but
equally can be overwritten to be explicitly configured.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 140 ++++++++++++++++++++++++++++++-
 1 file changed, 139 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 16dea2a222d9..7de869fac799 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -36,6 +36,8 @@
 #define ADXL345_REG_TAP_AXIS_MSK	GENMASK(2, 0)
 #define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3)
 #define ADXL345_REG_ACT_AXIS_MSK	GENMASK(6, 4)
+#define ADXL345_REG_INACT_AXIS_MSK	GENMASK(2, 0)
+#define ADXL345_POWER_CTL_INACT_MSK	(ADXL345_POWER_CTL_AUTO_SLEEP | ADXL345_POWER_CTL_LINK)
 
 enum adxl345_axis {
 	ADXL345_Z_EN = BIT(0),
@@ -71,18 +73,22 @@ static const unsigned int adxl345_tap_time_reg[3] = {
 /* activity/inactivity */
 enum adxl345_activity_type {
 	ADXL345_ACTIVITY,
+	ADXL345_INACTIVITY,
 };
 
 static const unsigned int adxl345_act_int_reg[2] = {
 	[ADXL345_ACTIVITY] = ADXL345_INT_ACTIVITY,
+	[ADXL345_INACTIVITY] = ADXL345_INT_INACTIVITY,
 };
 
 static const unsigned int adxl345_act_thresh_reg[2] = {
 	[ADXL345_ACTIVITY] = ADXL345_REG_THRESH_ACT,
+	[ADXL345_INACTIVITY] = ADXL345_REG_THRESH_INACT,
 };
 
 static const unsigned int adxl345_act_axis_msk[2] = {
 	[ADXL345_ACTIVITY] = ADXL345_REG_ACT_AXIS_MSK,
+	[ADXL345_INACTIVITY] = ADXL345_REG_INACT_AXIS_MSK,
 };
 
 enum adxl345_odr {
@@ -174,6 +180,10 @@ struct adxl345_state {
 	u32 act_axis_ctrl;
 	u8 act_threshold;
 
+	u32 inact_axis_ctrl;
+	u8 inact_threshold;
+	u8 inact_time_s;
+
 	u32 tap_axis_ctrl;
 	u8 tap_threshold;
 	u32 tap_duration_us;
@@ -195,6 +205,14 @@ static struct iio_event_spec adxl345_events[] = {
 		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
 			BIT(IIO_EV_INFO_VALUE),
 	},
+	{
+		/* inactivity */
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
+			BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_PERIOD),
+	},
 	{
 		/* single tap */
 		.type = IIO_EV_TYPE_GESTURE,
@@ -301,6 +319,17 @@ static int adxl345_write_act_axis(struct adxl345_state *st,
 					 st->act_axis_ctrl);
 		if (ret)
 			return ret;
+
+	} else {
+		st->inact_axis_ctrl = en
+			? st->inact_axis_ctrl | ADXL345_REG_INACT_AXIS_MSK
+			: st->inact_axis_ctrl & ~ADXL345_REG_INACT_AXIS_MSK;
+
+		ret = regmap_update_bits(st->regmap, ADXL345_REG_ACT_INACT_CTRL,
+					 adxl345_act_axis_msk[type],
+					 st->inact_axis_ctrl);
+		if (ret)
+			return ret;
 	}
 	return 0;
 }
@@ -324,6 +353,7 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 				    enum adxl345_activity_type type, bool cmd_en)
 {
 	bool axis_en, en = false;
+	unsigned long autosleep = 0;
 	int ret;
 
 	ret = adxl345_write_act_axis(st, type, cmd_en);
@@ -333,12 +363,24 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 	if (type == ADXL345_ACTIVITY) {
 		axis_en = FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, st->act_axis_ctrl) > 0;
 		en = axis_en && st->act_threshold > 0;
+	} else {
+		axis_en = FIELD_GET(ADXL345_REG_INACT_AXIS_MSK, st->inact_axis_ctrl) > 0;
+		en = axis_en && st->inact_threshold > 0 &&
+			st->inact_time_s > 0;
 	}
 
 	en ? __set_bit(ilog2(adxl345_act_int_reg[type]), (unsigned long *)&st->int_map)
 		: __clear_bit(ilog2(adxl345_act_int_reg[type]), (unsigned long *)&st->int_map);
 
-	return regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, st->int_map);
+	ret = regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, st->int_map);
+	if (ret)
+		return ret;
+
+	en ? __set_bit(ilog2(ADXL345_POWER_CTL_INACT_MSK), &autosleep)
+		: __clear_bit(ilog2(ADXL345_POWER_CTL_INACT_MSK), &autosleep);
+
+	return regmap_update_bits(st->regmap, ADXL345_REG_POWER_CTL,
+				  ADXL345_POWER_CTL_INACT_MSK, autosleep);
 }
 
 static int adxl345_set_act_inact_threshold(struct adxl345_state *st,
@@ -352,6 +394,48 @@ static int adxl345_set_act_inact_threshold(struct adxl345_state *st,
 
 	if (type == ADXL345_ACTIVITY)
 		st->act_threshold = val;
+	else
+		st->inact_threshold = val;
+
+	return 0;
+}
+
+/**
+ * adxl345_set_inact_time_s - Configure inactivity time explicitly or by ODR.
+ * @st: The sensor state instance.
+ * @val_s: A desired time value, between 0 and 255.
+ *
+ * If val_s is 0, a default inactivity time will be computed. It should take
+ * power consumption into consideration. Thus it shall be shorter for higher
+ * frequencies and longer for lower frequencies. Hence, frequencies above 255 Hz
+ * shall default to 10 s and frequencies below 10 Hz shall result in 255 s to
+ * detect inactivity.
+ *
+ * The approach simply subtracts the pre-decimal figure of the configured
+ * sample frequency from 255 s to compute inactivity time [s]. Sub-Hz are thus
+ * ignored in this estimation. The recommended ODRs for various features
+ * (activity/inactivity, sleep modes, free fall, etc.) lie between 12.5 Hz and
+ * 400 Hz, thus higher or lower frequencies will result in the boundary
+ * defaults or need to be explicitly specified via val_s.
+ *
+ * Return: 0 or error value.
+ */
+static int adxl345_set_inact_time_s(struct adxl345_state *st, u32 val_s)
+{
+	unsigned int max_boundary = 255;
+	unsigned int min_boundary = 10;
+	unsigned int val = min(val_s, max_boundary);
+	int ret;
+
+	if (val == 0)
+		val = (adxl345_odr_tbl[st->odr][0] > max_boundary)
+			? min_boundary : max_boundary -	adxl345_odr_tbl[st->odr][0];
+
+	ret = regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
+	if (ret)
+		return ret;
+
+	st->inact_time_s = val;
 
 	return 0;
 }
@@ -641,6 +725,11 @@ static int adxl345_set_odr(struct adxl345_state *st, enum adxl345_odr odr)
 
 	st->odr = odr;
 
+	/* update inactivity time by ODR */
+	ret = adxl345_set_inact_time_s(st, 0);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -672,6 +761,24 @@ static int adxl345_set_range(struct adxl345_state *st, enum adxl345_range range)
 	if (ret)
 		return ret;
 
+	st->act_threshold = st->act_threshold
+		* adxl345_range_factor_tbl[st->range]
+		/ adxl345_range_factor_tbl[range];
+	st->act_threshold = min(255, max(1, st->inact_threshold));
+
+	st->inact_threshold = st->inact_threshold
+		* adxl345_range_factor_tbl[st->range]
+		/ adxl345_range_factor_tbl[range];
+	st->inact_threshold = min(255, max(1, st->inact_threshold));
+
+	ret = adxl345_set_act_inact_threshold(st, ADXL345_ACTIVITY, st->act_threshold);
+	if (ret)
+		return ret;
+
+	ret = adxl345_set_act_inact_threshold(st, ADXL345_INACTIVITY, st->inact_threshold);
+	if (ret)
+		return ret;
+
 	st->range = range;
 
 	return 0;
@@ -810,6 +917,11 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
 			if (ret)
 				return ret;
 			return int_en;
+		case IIO_EV_DIR_FALLING:
+			ret = adxl345_is_act_inact_en(st, ADXL345_INACTIVITY, &int_en);
+			if (ret)
+				return ret;
+			return int_en;
 		default:
 			return -EINVAL;
 		}
@@ -866,6 +978,8 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 		switch (dir) {
 		case IIO_EV_DIR_RISING:
 			return adxl345_set_act_inact_en(st, ADXL345_ACTIVITY, state);
+		case IIO_EV_DIR_FALLING:
+			return adxl345_set_act_inact_en(st, ADXL345_INACTIVITY, state);
 		default:
 			return -EINVAL;
 		}
@@ -913,9 +1027,15 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev, const struct iio_
 			case IIO_EV_DIR_RISING:
 				*val = st->act_threshold;
 				return IIO_VAL_INT;
+			case IIO_EV_DIR_FALLING:
+				*val = st->inact_threshold;
+				return IIO_VAL_INT;
 			default:
 				return -EINVAL;
 			}
+		case IIO_EV_INFO_PERIOD:
+			*val = st->inact_time_s;
+			return IIO_VAL_INT;
 		default:
 			return -EINVAL;
 		}
@@ -982,10 +1102,16 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
 			case IIO_EV_DIR_RISING:
 				ret = adxl345_set_act_inact_threshold(st, ADXL345_ACTIVITY, val);
 				break;
+			case IIO_EV_DIR_FALLING:
+				ret = adxl345_set_act_inact_threshold(st, ADXL345_INACTIVITY, val);
+				break;
 			default:
 				ret = -EINVAL;
 			}
 			break;
+		case IIO_EV_INFO_PERIOD:
+			ret = adxl345_set_inact_time_s(st, val);
+			break;
 		default:
 			ret = -EINVAL;
 		}
@@ -1365,6 +1491,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
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
@@ -1481,6 +1618,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	 * setup.
 	 */
 	st->act_axis_ctrl = ADXL345_REG_ACT_AXIS_MSK;
+	st->inact_axis_ctrl = ADXL345_REG_INACT_AXIS_MSK;
 	st->int_map = 0x00;			/* reset interrupts */
 
 	/* Init with reasonable values */
-- 
2.39.5


