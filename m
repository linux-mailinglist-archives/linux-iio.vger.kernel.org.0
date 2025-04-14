Return-Path: <linux-iio+bounces-18113-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9801A88B99
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 20:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44C0189A940
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 18:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42D22918C0;
	Mon, 14 Apr 2025 18:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X594cjCl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166FB28F525;
	Mon, 14 Apr 2025 18:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744656181; cv=none; b=bjZra8bpbl8VKcLe65+/UkykAZ1CSs4qlqzEQq38Mds3OkU7pF748FxuMTcMbQcPe+8OOnclYIgVwYm+SgaLmewwYlTNPDYa23BGKJokOKIGmb46XfZU4yN2vLn5qCApMz9npuBhmPDnB2LQXAmcVGycv/D1HTQbj0oYTpDytcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744656181; c=relaxed/simple;
	bh=DqMyix5Y2hwLPyspjSRNtK/jRR7d1XA/saXeC/MMJtw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZvFkKCZ42YXewCghC8ItjkMQhQc5nJpgvTRqV0eGD3yg9i6EJpZ1pPEO2T1nbjCkllLP++eGVq15rb6AMAfryGhp0Zan6BOXuFHEUHmgj12Lm9wRqj5jpshFs98fPKUtTLYwQbATk9nifQEN5EFWVO6Cjonaq+j/OQCNRoviAwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X594cjCl; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac315695c8fso79646266b.3;
        Mon, 14 Apr 2025 11:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744656177; x=1745260977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hTMeMv7oT0bknwxdE+4YeT2UNuXEoMAw2r6vfkW7OHc=;
        b=X594cjClPkHyytQryS54+06Y9RakeBDh+DBcXO7KlUrI0bTYZMVbtxDmUz4EJliUYD
         dlmMQUhINNHLpx+y0GKjpkGxVrwHftSf2w2gHzC3GcvfmfXMkgcpVoAM0mdOOhIdsU/V
         rS1CUPF8NnsdH5K7mWtI4oDm3BKYfX0FKfY5vvjeP/ipVJC4iWoS5N9pts0K9PYxI/c4
         B940FdH6OOZE4jy3RJstAg3O9gChq65jIRIrsP8BGA5g8bXK3cHBeD1obWPp9DN0BCoW
         iRW/gyjfDJ2SOtdonQIjvseo+XBq6AB1/xMGx7a4+1aCwDxd8UsXmnEdNR3bW+JmpSlz
         aSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744656177; x=1745260977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTMeMv7oT0bknwxdE+4YeT2UNuXEoMAw2r6vfkW7OHc=;
        b=dIUWuzjdzZVonVUKy+AgM2Pdp9y+PorMlJjmW5RmsELI7AD0bJZQok+4fzvrffu1Ec
         JUG46i0hRkMBruPLK80GKfjKVGw3myPDDe5rZ/0ZW8A/1Sh/FDxfw8LCHBhaSTauj+ch
         difQDRz7aDP0CZdMKyQhzAagZqtELrzGLjNg6yokyZYD3u/mLQARdlhsYUKqrHe5YiDQ
         k8wJNVaJ8neVFZvfw/caV0UGorar1X90LqotY64XrsDYRbAWdGaCV//UqDrnMkXSlTgw
         51DgOU2JpEA0lvm2CJAboyoNM1yplVDgrdcDdswY1r669UVWpebAUSFyvKDT9dYFp1Qx
         +TQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKIjLybevpwXM72Ps2nwxzm9h28FYnp1mkv7nuqYMBpGZxgM5GUK3fnXWeGcmaX48jk0VwuJShkJ1wnZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YztWUSe90TvtMSf1+J+SnhqPD2AYmNi8i/Py7a8xAaHOmTZmI/s
	RtwdQg7eOlUafrluphG0ZYgB8pMrD3JyIh9AIXq3K0eIo30nw5Av5SGk1A==
X-Gm-Gg: ASbGnctp72NJ8vVdD8iccMVG4eMUP87r7tjfZTvibo/rG2wilMEGW0Z9LWnQdLj+PkX
	hSJ7GkoXDmuzmXu8pmjWA+rNkdtmIgjRU48cpGAy/LUfmtqzQXrKrd0TKqQWZEQ1BRuTKL53G7A
	ynzNfHeIJQsD7z9IOUr2KuNHR7uigcMS+t684sMMhqLzgZnxZYbIa56s23uaj43rA2GS7Vjtg3M
	UAoG+LpgUhxiR+xWX+EToLnQxtvcUeL8AL0zV/gz9sz0b/NfudXj7r7DeqRna8hnm9V9v1fcyzC
	hE5DUUw67vdUCCStBL0GXwca0tqrkb+5dT14hYOQAiwSgzNAxaxp0PZ4apHRugOZ8ShRTOWU0gn
	09EDHKmzAzOoEbyaFhz0=
X-Google-Smtp-Source: AGHT+IG+cKxQSPQ9Pi/Avi5dOTpvsPKIaAV5wzSpxj0yxCGe76mugRilS6h64h/kv6QN0ANa2zMMGg==
X-Received: by 2002:a17:907:d804:b0:abf:777e:79f1 with SMTP id a640c23a62f3a-acad3495f6fmr435027966b.5.1744656177002;
        Mon, 14 Apr 2025 11:42:57 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bb3172sm946483466b.24.2025.04.14.11.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 11:42:56 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v6 08/11] iio: accel: adxl345: add activity event feature
Date: Mon, 14 Apr 2025 18:42:42 +0000
Message-Id: <20250414184245.100280-9-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414184245.100280-1-l.rubusch@gmail.com>
References: <20250414184245.100280-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl345_core.c | 217 ++++++++++++++++++++++++++++++-
 1 file changed, 214 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 166f549ba375..8f7ea3928cf8 100644
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
@@ -154,6 +172,13 @@ struct adxl345_state {
 };
 
 static struct iio_event_spec adxl345_events[] = {
+	{
+		/* activity */
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
+	},
 	{
 		/* single tap */
 		.type = IIO_EV_TYPE_GESTURE,
@@ -256,6 +281,99 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
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
@@ -710,6 +828,18 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (type) {
+	case IIO_EV_TYPE_THRESH:
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
@@ -746,6 +876,14 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 	struct adxl345_state *st = iio_priv(indio_dev);
 
 	switch (type) {
+	case IIO_EV_TYPE_THRESH:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return adxl345_set_act_inact_en(st, chan->channel2,
+							ADXL345_ACTIVITY, state);
+		default:
+			return -EINVAL;
+		}
 	case IIO_EV_TYPE_GESTURE:
 		switch (dir) {
 		case IIO_EV_DIR_SINGLETAP:
@@ -770,11 +908,31 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 				    int *val, int *val2)
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
+	unsigned int act_threshold;
 	unsigned int tap_threshold;
 	unsigned int ff_threshold;
 	int ret;
 
 	switch (type) {
+	case IIO_EV_TYPE_THRESH:
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
@@ -841,6 +999,25 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
 		return ret;
 
 	switch (type) {
+	case IIO_EV_TYPE_THRESH:
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
@@ -1099,7 +1276,8 @@ static int adxl345_fifo_push(struct iio_dev *indio_dev,
 }
 
 static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
-			      enum iio_modifier tap_dir)
+			      enum iio_modifier tap_dir,
+			      enum iio_modifier act_dir)
 {
 	s64 ts = iio_get_time_ns(indio_dev);
 	struct adxl345_state *st = iio_priv(indio_dev);
@@ -1126,6 +1304,16 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
 			return ret;
 	}
 
+	if (FIELD_GET(ADXL345_INT_ACTIVITY, int_stat)) {
+		ret = iio_push_event(indio_dev,
+				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, act_dir,
+							IIO_EV_TYPE_THRESH,
+							IIO_EV_DIR_RISING),
+				     ts);
+		if (ret)
+			return ret;
+	}
+
 	if (FIELD_GET(ADXL345_INT_FREE_FALL, int_stat)) {
 		ret = iio_push_event(indio_dev,
 				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
@@ -1164,6 +1352,7 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 	struct adxl345_state *st = iio_priv(indio_dev);
 	unsigned int regval;
 	enum iio_modifier tap_dir = IIO_NO_MOD;
+	enum iio_modifier act_dir = IIO_NO_MOD;
 	u32 axis_ctrl;
 	int int_stat;
 	int ret;
@@ -1172,7 +1361,8 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 	if (ret)
 		return IRQ_NONE;
 
-	if (FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, axis_ctrl)) {
+	if (FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, axis_ctrl) ||
+	    FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, axis_ctrl)) {
 		ret = regmap_read(st->regmap, ADXL345_REG_ACT_TAP_STATUS, &regval);
 		if (ret)
 			return IRQ_NONE;
@@ -1183,12 +1373,19 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
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
@@ -1353,6 +1550,20 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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


