Return-Path: <linux-iio+bounces-16797-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE9DA5FCAD
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 17:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 870693BDA65
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 16:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD9F26BDAC;
	Thu, 13 Mar 2025 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="betCTGkc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269D926B2D0;
	Thu, 13 Mar 2025 16:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884680; cv=none; b=BDZT0fXLLl1/kKJ0GnivLR+f0l6Tj1vohK7vbppYMu1EFmWHzINyFyvb4Ez9V8ip64VViRM/b6q2JPQeOyogNXPOIfmTFtGVRF2DkOVpOY3+fh5iFyRFX8aS50xvbxvqUzM+VG3LHY3ux9lqP0aj6sX5c3cyIJlCIsG3XeH3vPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884680; c=relaxed/simple;
	bh=mZjn8O2vII7ZxYPr65Ie0U6hWdaJ/rr+KTwnmFvv9yk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hu/JOIY/gLXs2tYreKu2BvkRfmoxRVSZ2sw6CmRDuM+eoL6erU+3wOrB0T0PuladfCuT+o4tj5Of3KJnYp1IaqhK9GfEobMgyeHMHmFXqLjvGuroAM3ghJXJoJtrZRbIG1B35IXUf4T1Bw+jbjnXSQNOhmMbHxFTwUj3/Cp5Etg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=betCTGkc; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac24daf5f32so15088166b.0;
        Thu, 13 Mar 2025 09:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741884676; x=1742489476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5UshTE7ACs62k6pf1vEYbB1RAdAT3w5z4Vdq4Vcj3c=;
        b=betCTGkc64FxuYXLI8SKq+vSrbwBzKzPG+6sUyjIJhcBLO6wvEkqx1/NZAlPqbwQNz
         YiDll5+wN0uVBnYC7u3tczXvEEm4Xl68bMdD5MTDrJjJT7ilaRZYx6hC4z71L5jq8VSG
         KkyvzZUAuvoKn8aIFClnOdsrAsUbuQkghDrG9Fahe8+/tSaG2e235ZyZzF++sfFjZGX9
         wzepy7sJ+ibMLfnQnqBxWRAEyPZSPVrNLCNLiVeknjfCUp3Wzt8RNNceoG7C/p/yFhvZ
         Hku7+bg89PWlxglkheCeyc3UT6dnHFnvdcC8t6yRZVuo1NaBQ01wOCFpLhvfVh7z4imB
         YoVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741884676; x=1742489476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5UshTE7ACs62k6pf1vEYbB1RAdAT3w5z4Vdq4Vcj3c=;
        b=gI9e2Xif/R9TqvIFvJPNqHTaXBUYnJt7ZkXjaCyFznqAlQ4iVp2KDESdp/k4s7nwmB
         Zl+jq5OmU0HGgWoV6PYw9EmlJclbrGh0Fpv9SXlmKAFoB4VCg0FM00kKQTPMn/9R6rBf
         SqVl1+iO9DmmL4jACf7tmTeF5sX6nCWx0DQqx9uBrXYI8dKXxP+3yubgF9275oaaC/jn
         euQhItP7XjQU4sFEKXoXxjX/uUO3o2HKZhffHVPQmmYAlG2We8wx8WI+rE8cM3jzkoPI
         VUc98K+bYlRu+DSzQ5Mp2V2+2A1eQaKro4OUnFOWSSBeaiGpUzlqfOPGBMtjlzFnPnEJ
         pKVg==
X-Forwarded-Encrypted: i=1; AJvYcCUQrvGW4dicF8TZyarHprzxcpkP5RQKuK5OBIMaQxGpfPoqnP5W838f9Lqtsifez5Z4HOm3mAik0TMs10g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Yy1bjFA0n94kKdKpi2Mzj/RuIn8lG95pPrXb+UG3+r1jh8KR
	bo1W5kVxSqAl0+nfnxrO6XGkVBvcIC/BYlvfEY9ZcRJ8aOeilGZu
X-Gm-Gg: ASbGnct+0tZYTKjIAymXNhbP28PfkzeeGJdkgDGLJJjaJ0snFCYhaM9zsMsTy6xWzjq
	F1tkNvrOT5CScyE5eK+mmsD9V0PQysLuj88rfB3ydM6h1UnOFe4YK7vBoVGFd8AMWi6e+6nvOu2
	0W/fShO52l2LEkttdIE9f8fZ72GRaZmrl9lrzHZuyx/KsJx6FHgxMdOXP1cbDt+EUg0EAToQ2zO
	Bxj8i9cHT8LD7OdvvCJKTRnab/LWxCz8ljpKjZLfa9qJwnD6kHfQvq0rwtEVofWRcBsNWvz6HEp
	szzMC+AwW/JtmWo+xElDza27BTXwnK5gIZsA8AOpa5ZFrhTN+o88xov/gAPvzUyvWXHIjkpZqMt
	YjroMzY2o5PzT8J/tCLkUix8=
X-Google-Smtp-Source: AGHT+IEh+pVooy+awPz0Sh96OuZafg7UDwyx+ZYIsRxfwZwQqUynacEUAR6dFktD7i3MWxtmhFhz8w==
X-Received: by 2002:a17:907:1c9f:b0:ab7:bb4b:aa49 with SMTP id a640c23a62f3a-ac2b9d5999bmr574139866b.5.1741884676078;
        Thu, 13 Mar 2025 09:51:16 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147efb0csm101370866b.65.2025.03.13.09.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:51:15 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v4 11/14] iio: accel: adxl345: add activity event feature
Date: Thu, 13 Mar 2025 16:50:46 +0000
Message-Id: <20250313165049.48305-12-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313165049.48305-1-l.rubusch@gmail.com>
References: <20250313165049.48305-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl345_core.c | 222 ++++++++++++++++++++++++++++++-
 1 file changed, 219 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index de9202126f70..98a781987b63 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -35,6 +35,7 @@
 
 #define ADXL345_REG_TAP_AXIS_MSK	GENMASK(2, 0)
 #define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3)
+#define ADXL345_REG_ACT_AXIS_MSK	GENMASK(6, 4)
 
 enum adxl345_axis {
 	ADXL345_Z_EN = BIT(0),
@@ -67,6 +68,23 @@ static const unsigned int adxl345_tap_time_reg[] = {
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
+static const unsigned int adxl345_act_axis_msk[] = {
+	[ADXL345_ACTIVITY] = ADXL345_REG_ACT_AXIS_MSK,
+};
+
 enum adxl345_odr {
 	ADXL345_ODR_0P10HZ = 0,
 	ADXL345_ODR_0P20HZ,
@@ -157,6 +175,13 @@ struct adxl345_state {
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
@@ -259,6 +284,108 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
 	return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
 }
 
+/* act/inact */
+
+static int adxl345_is_act_inact_en(struct adxl345_state *st,
+				   enum iio_modifier axis,
+				   enum adxl345_activity_type type, bool *en)
+{
+	unsigned int regval;
+	bool axis_en;
+	u32 axis_ctrl;
+	int act_shift;
+	int ret;
+
+	act_shift = (type == ADXL345_ACTIVITY) ? 4 : 0;
+
+	ret = regmap_read(st->regmap, ADXL345_REG_ACT_INACT_CTRL, &axis_ctrl);
+	if (ret)
+		return ret;
+
+	axis_ctrl = axis_ctrl >> act_shift;
+
+	switch (axis) {
+	case IIO_MOD_X:
+		axis_en = FIELD_GET(ADXL345_X_EN, axis_ctrl);
+		break;
+	case IIO_MOD_Y:
+		axis_en = FIELD_GET(ADXL345_Y_EN, axis_ctrl);
+		break;
+	case IIO_MOD_Z:
+		axis_en = FIELD_GET(ADXL345_Z_EN, axis_ctrl);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_read(st->regmap, ADXL345_REG_INT_ENABLE, &regval);
+	if (ret)
+		return ret;
+
+	*en = (adxl345_act_int_reg[type] & regval) > 0;
+
+	return 0;
+}
+
+static int adxl345_set_act_inact_en(struct adxl345_state *st,
+				    enum iio_modifier axis,
+				    enum adxl345_activity_type type,
+				    bool cmd_en)
+{
+	bool axis_en, en;
+	unsigned int threshold;
+	u32 axis_ctrl;
+	/*
+	 * Activity and inactivity share the same register for enabling
+	 * directions. Activity uses the four upper bits, where inactivity
+	 * detection uses the lower bits. In order to keep generic x, y
+	 * and z-axis type, it is shifted for initialization of activity.
+	 * NB: Activity and inactivitty axis enable bits are regmap cached.
+	 */
+	int act_shift = (type == ADXL345_ACTIVITY) ? 4 : 0;
+	int ret;
+
+	switch (axis) {
+	case IIO_MOD_X:
+		axis_ctrl = ADXL345_X_EN;
+		break;
+	case IIO_MOD_Y:
+		axis_ctrl = ADXL345_Y_EN;
+		break;
+	case IIO_MOD_Z:
+		axis_ctrl = ADXL345_Z_EN;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	axis_ctrl = axis_ctrl << act_shift;
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
+		axis_en = FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, axis_ctrl) > 0;
+		en = axis_en && threshold > 0;
+	}
+
+	return regmap_update_bits(st->regmap, ADXL345_REG_INT_ENABLE,
+				  adxl345_act_int_reg[type],
+				  en ? adxl345_act_int_reg[type] : 0);
+}
+
 /* tap */
 
 static int _adxl345_set_tap_int(struct adxl345_state *st,
@@ -719,6 +846,18 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
 	int ret = -EFAULT;
 
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
@@ -755,6 +894,14 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
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
@@ -779,11 +926,31 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
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
@@ -850,6 +1017,23 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
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
+				break;
+			default:
+				ret = -EINVAL;
+			}
+			break;
+		default:
+			ret = -EINVAL;
+		}
+		break;
 	case IIO_EV_TYPE_GESTURE:
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
@@ -1105,7 +1289,8 @@ static int adxl345_fifo_push(struct iio_dev *indio_dev,
 }
 
 static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
-			      enum iio_modifier tap_dir)
+			      enum iio_modifier tap_dir,
+			      enum iio_modifier act_dir)
 {
 	s64 ts = iio_get_time_ns(indio_dev);
 	struct adxl345_state *st = iio_priv(indio_dev);
@@ -1132,6 +1317,16 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
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
@@ -1164,10 +1359,12 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
  */
 static irqreturn_t adxl345_irq_handler(int irq, void *p)
 {
+	const int act_shift = 4;
 	struct iio_dev *indio_dev = p;
 	struct adxl345_state *st = iio_priv(indio_dev);
 	unsigned int regval;
 	enum iio_modifier tap_dir = IIO_NO_MOD;
+	enum iio_modifier act_dir = IIO_NO_MOD;
 	u32 axis_ctrl;
 	int int_stat;
 	int ret;
@@ -1176,7 +1373,8 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 	if (ret)
 		return IRQ_NONE;
 
-	if (FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, axis_ctrl)) {
+	if (FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, axis_ctrl) ||
+	    FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, axis_ctrl)) {
 		ret = regmap_read(st->regmap, ADXL345_REG_ACT_TAP_STATUS, &regval);
 		if (ret)
 			return IRQ_NONE;
@@ -1187,12 +1385,22 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 			tap_dir = IIO_MOD_Y;
 		else if (FIELD_GET(ADXL345_X_EN, regval))
 			tap_dir = IIO_MOD_X;
+
+		/* Activity direction is stored in the upper four bits */
+		regval >>= act_shift;
+
+		if (FIELD_GET(ADXL345_Z_EN, regval))
+			act_dir = IIO_MOD_Z;
+		else if (FIELD_GET(ADXL345_Y_EN, regval))
+			act_dir = IIO_MOD_Y;
+		else if (FIELD_GET(ADXL345_X_EN, regval))
+			act_dir = IIO_MOD_X;
 	}
 
 	if (regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, &int_stat))
 		return IRQ_NONE;
 
-	if (adxl345_push_event(indio_dev, int_stat, tap_dir))
+	if (adxl345_push_event(indio_dev, int_stat, tap_dir, act_dir))
 		goto err;
 
 	if (FIELD_GET(ADXL345_INT_OVERRUN, int_stat))
@@ -1357,6 +1565,14 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		if (ret)
 			return ret;
 
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


