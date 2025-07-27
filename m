Return-Path: <linux-iio+bounces-22070-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7320FB131DF
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 23:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 915991768BA
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 21:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F40B242928;
	Sun, 27 Jul 2025 21:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3wPy/CL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC5C23C51D;
	Sun, 27 Jul 2025 21:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753650028; cv=none; b=KB/Sf/YWk7iBqxSCSICcfOYFKFBUXggs59eR0zVk0QrL/jnpXD/C032qkkASj7cD+uvSQs4ZRRUns+FwbI4VEdzbbWtMx0UpwyfMFZLSBEZK0/kz3BetM9sKWB41t4aT7P//zIvc3dyi1uP0/14vzjMYCPGdFWNVxZvyB9+Qop0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753650028; c=relaxed/simple;
	bh=zxAtXKdcVlnQt87YxspoMyOfKzlIjDg+qkoKnCSUDwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bYRjF45gfYS1Qdptd+RRr396TPsm11wVK2f4jD5uRLTg+WFRurcpG5BwTxuocPAAmR+WIY3H+amhyC5DG7ucGwLs9ulni4Bq/mht38xssfw1A85PqCwHZNV+qh+yncYJSIeqHvFuLE4cXGa/3H8Pw4YzmS+wct+n01fHTRyxTwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3wPy/CL; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-606aadc1433so254887a12.2;
        Sun, 27 Jul 2025 14:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753650025; x=1754254825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gkL4j6OcZAN98BFgkxkvPrzlgEzIMzBycvONdqkDgA=;
        b=a3wPy/CL6vLWBpvxxZk7PLu0whHVw1j6ZJ6srUs9BmzwpStKUyJBWV4kU20T0Gq4Fu
         6N9AiF0VkbAKDRw/Vrgggg6npPL0OJAhX7DJ3dtr9WMoRlcALkalNba7jtZ0Xmy4vI2C
         QoEpeAN0dF6QJCQdtZejbNrOrnX1uKlSHZlCjYpUh2dgBC2aty5Vzc3dD9DHERz8m/WB
         fuOAofhTkcpM9ZDZln7Jtb0yBLsLOC2MJxgqo8rhWSFTO9RsqF20Anr2qhMx8MMw8DCK
         9byHS9yF8TCZxd7k4BeLWAi06hqlVhi0FLaSduBQj8nBZDW/hiih7a8v5HqJw/jrfw2v
         tiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753650025; x=1754254825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gkL4j6OcZAN98BFgkxkvPrzlgEzIMzBycvONdqkDgA=;
        b=iWsitpkQrug+LEbN2P6Gzw1HeWg9ybgpcmP66yjTfL1wgQLIpPmu9OrHaqkssqYa66
         unEpy/uoGx6PxNbCFBQo0ACVdfSkjoihpY726NCwmpvV51SplNjFnsuP/OTJEVvwHotj
         xZlvMbkWuJqmL6F0piIIXOPBAT+3FVJyDTmW9LtFefY/EY9NvS+0PqxHHzONdAsr/u7J
         +iR55Wc1I0hwvlC6KoGGpMCknybHhEQgFzwuyLCJzv0zNmfUQDLMEv7yGIbiUvp44j1/
         taEaoyNOW2Cw6XMw8jyR8isT7VNBCWsyBHARy2LqqO3lQ+Tf/oDVLvks9k/Hokz9RJAF
         K9dA==
X-Forwarded-Encrypted: i=1; AJvYcCVaQEoiCPLBOk8/1LhgDNRpFlZ4BHSUyn8x3OWiMglMs+ECzrCoC4dcRn2y3+3aOuHiHnJaNpwoGRY=@vger.kernel.org, AJvYcCVflygr+iQ3VaRqX3gr4ZKQpeRwyc5YGO2yeIWx8Bo5o3RXEQhj658cZcU64ZKwEcuiq4btFIMuFKig6OUO@vger.kernel.org
X-Gm-Message-State: AOJu0YyDeturZrTHv9MY3zqXtfeNG2BMp0soAr45+LfMkJOIfM6HV5z6
	dbyE/92/VxDLk+eAHXndlVgi+Ls37aSrFOVm4nxiKY6bqIac06aHWnCF
X-Gm-Gg: ASbGncvLXPghD44Zz4kxpd5UVd8lv5dcI/9xqJnnFMI4KGasM+72UvqT9HK+UtilNjd
	l93suocAjzyvn4nuaR3BFCh09jMr45hWmAd4o2gOcejCjfZuhx12+hP0rj7kBnLwcC++cqZUXOX
	ZMJMH8TEeA6elKhnkbEu3bobhlxd19xOTEHpgHe5fEr9yclnTjcPP4lF9XYYMwHXi19u9RMV2HB
	gmJ+4kMmrXRLpovt4O8nvZgiXsqEV+fmQpUu9ePEBnrada/gXc19Y8dBUfDkL41cEBN/txrSKDL
	HeInjc7b+JdqM1TeAJbqX65OzMtF8/4fckxggTWvvprB6+WC+U4IU25naH7T3l+djaZAzluJCkW
	KsYhZIBYwRedvFE5frvwpFriRRb6GVtdJ9iFwRzAPAHqj0wyD5hABCRYXKziLf+T5O6KP3hxBuG
	VRNYs=
X-Google-Smtp-Source: AGHT+IF4HHhTo//ti6MYCBB6gJvhrBHgRT5SYPdYHDVqjU+nk0aug82fCbASdSX/pT3t6plS2yyPPg==
X-Received: by 2002:a05:6402:1ed6:b0:612:fbf0:57c4 with SMTP id 4fb4d7f45d1cf-614f1da8aaemr3461223a12.5.1753650024929;
        Sun, 27 Jul 2025 14:00:24 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61500add92dsm2512774a12.52.2025.07.27.14.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 14:00:24 -0700 (PDT)
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
Subject: [PATCH v12 2/7] iio: accel: adxl345: add activity event feature
Date: Sun, 27 Jul 2025 21:00:09 +0000
Message-Id: <20250727210014.27766-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250727210014.27766-1-l.rubusch@gmail.com>
References: <20250727210014.27766-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the sensor to detect activity and trigger interrupts accordingly.
Activity events are determined based on a threshold, which is initialized
to a sensible default during probe. This default value is adopted from the
legacy ADXL345 input driver to maintain consistent behavior.

The combination of activity detection, ODR configuration, and range
settings lays the groundwork for the activity/inactivity hysteresis
mechanism, which will be implemented in a subsequent patch. As such,
portions of this patch prepare switch-case structures to support those
upcoming changes.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 240 ++++++++++++++++++++++++++++++-
 1 file changed, 238 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index e293fc917972..8ff1784403ba 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -39,6 +39,11 @@
 #define ADXL345_TAP_X_EN		BIT(2)
 #define ADXL345_REG_TAP_SUPPRESS	BIT(3)
 
+#define ADXL345_ACT_Z_EN		BIT(4)
+#define ADXL345_ACT_Y_EN		BIT(5)
+#define ADXL345_ACT_X_EN		BIT(6)
+#define ADXL345_ACT_XYZ_EN		(ADXL345_ACT_Z_EN | ADXL345_ACT_Y_EN | ADXL345_ACT_X_EN)
+
 /* single/double tap */
 enum adxl345_tap_type {
 	ADXL345_SINGLE_TAP,
@@ -62,6 +67,19 @@ static const unsigned int adxl345_tap_time_reg[] = {
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
@@ -142,6 +160,14 @@ struct adxl345_state {
 };
 
 static const struct iio_event_spec adxl345_events[] = {
+	{
+		/* activity */
+		.type = IIO_EV_TYPE_MAG,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_shared_by_type =
+			BIT(IIO_EV_INFO_ENABLE) |
+			BIT(IIO_EV_INFO_VALUE),
+	},
 	{
 		/* single tap */
 		.type = IIO_EV_TYPE_GESTURE,
@@ -235,6 +261,87 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
 				  ADXL345_POWER_CTL_MEASURE, en);
 }
 
+/* activity / inactivity */
+
+static int adxl345_is_act_inact_en(struct adxl345_state *st,
+				   enum adxl345_activity_type type)
+{
+	unsigned int axis_ctrl;
+	unsigned int regval;
+	bool en;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADXL345_REG_ACT_INACT_CTRL, &axis_ctrl);
+	if (ret)
+		return ret;
+
+	/* Check if axis for activity are enabled */
+	switch (type) {
+	case ADXL345_ACTIVITY:
+		en = FIELD_GET(ADXL345_ACT_XYZ_EN, axis_ctrl);
+		if (!en)
+			return false;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Check if specific interrupt is enabled */
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
+	unsigned int axis_ctrl;
+	unsigned int threshold;
+	int ret;
+
+	if (cmd_en) {
+		/* When turning on, check if threshold is valid */
+		ret = regmap_read(st->regmap,
+				  adxl345_act_thresh_reg[type],
+				  &threshold);
+		if (ret)
+			return ret;
+
+		if (!threshold) /* Just ignore the command if threshold is 0 */
+			return 0;
+	}
+
+	/* Start modifying configuration registers */
+	ret = adxl345_set_measure_en(st, false);
+	if (ret)
+		return ret;
+
+	/* Enable axis according to the command */
+	switch (type) {
+	case ADXL345_ACTIVITY:
+		axis_ctrl = ADXL345_ACT_XYZ_EN;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_assign_bits(st->regmap, ADXL345_REG_ACT_INACT_CTRL,
+				 axis_ctrl, cmd_en);
+	if (ret)
+		return ret;
+
+	/* Enable the interrupt line, according to the command */
+	ret = regmap_assign_bits(st->regmap, ADXL345_REG_INT_ENABLE,
+				 adxl345_act_int_reg[type], cmd_en);
+	if (ret)
+		return ret;
+
+	return adxl345_set_measure_en(st, true);
+}
+
 /* tap */
 
 static int _adxl345_set_tap_int(struct adxl345_state *st,
@@ -621,6 +728,31 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 	return adxl345_set_measure_en(st, true);
 }
 
+static int adxl345_read_mag_config(struct adxl345_state *st,
+				   enum iio_event_direction dir,
+				   enum adxl345_activity_type type_act)
+{
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		return !!adxl345_is_act_inact_en(st, type_act);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl345_write_mag_config(struct adxl345_state *st,
+				    enum iio_event_direction dir,
+				    enum adxl345_activity_type type_act,
+				    bool state)
+{
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		return adxl345_set_act_inact_en(st, type_act, state);
+	default:
+		return -EINVAL;
+	}
+}
+
 static int adxl345_read_event_config(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan,
 				     enum iio_event_type type,
@@ -631,6 +763,9 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		return adxl345_read_mag_config(st, dir,
+					       ADXL345_ACTIVITY);
 	case IIO_EV_TYPE_GESTURE:
 		switch (dir) {
 		case IIO_EV_DIR_SINGLETAP:
@@ -662,6 +797,10 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 	struct adxl345_state *st = iio_priv(indio_dev);
 
 	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		return adxl345_write_mag_config(st, dir,
+						ADXL345_ACTIVITY,
+						state);
 	case IIO_EV_TYPE_GESTURE:
 		switch (dir) {
 		case IIO_EV_DIR_SINGLETAP:
@@ -676,6 +815,58 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 	}
 }
 
+static int adxl345_read_mag_value(struct adxl345_state *st,
+				  enum iio_event_direction dir,
+				  enum iio_event_info info,
+				  enum adxl345_activity_type type_act,
+				  int *val, int *val2)
+{
+	unsigned int threshold;
+	int ret;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			ret = regmap_read(st->regmap,
+					  adxl345_act_thresh_reg[type_act],
+					  &threshold);
+			if (ret)
+				return ret;
+			*val = 62500 * threshold;
+			*val2 = MICRO;
+			return IIO_VAL_FRACTIONAL;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl345_write_mag_value(struct adxl345_state *st,
+				   enum iio_event_direction dir,
+				   enum iio_event_info info,
+				   enum adxl345_activity_type type_act,
+				   int val, int val2)
+{
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		/* Scaling factor 62.5mg/LSB, i.e. ~16g corresponds to 0xff */
+		val = DIV_ROUND_CLOSEST(val * MICRO + val2, 62500);
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return regmap_write(st->regmap,
+					    adxl345_act_thresh_reg[type_act],
+					    val);
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
 static int adxl345_read_event_value(struct iio_dev *indio_dev,
 				    const struct iio_chan_spec *chan,
 				    enum iio_event_type type,
@@ -688,6 +879,10 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		return adxl345_read_mag_value(st, dir, info,
+					      ADXL345_ACTIVITY,
+					      val, val2);
 	case IIO_EV_TYPE_GESTURE:
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
@@ -738,6 +933,13 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
 		return ret;
 
 	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		ret = adxl345_write_mag_value(st, dir, info,
+					      ADXL345_ACTIVITY,
+					      val, val2);
+		if (ret)
+			return ret;
+		break;
 	case IIO_EV_TYPE_GESTURE:
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
@@ -977,6 +1179,7 @@ static int adxl345_fifo_push(struct iio_dev *indio_dev,
 }
 
 static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
+			      enum iio_modifier act_dir,
 			      enum iio_modifier tap_dir)
 {
 	s64 ts = iio_get_time_ns(indio_dev);
@@ -1004,6 +1207,16 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
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
@@ -1031,6 +1244,7 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 	struct adxl345_state *st = iio_priv(indio_dev);
 	unsigned int regval;
 	enum iio_modifier tap_dir = IIO_NO_MOD;
+	enum iio_modifier act_dir = IIO_NO_MOD;
 	u32 axis_ctrl;
 	int int_stat;
 	int ret;
@@ -1039,7 +1253,8 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 	if (ret)
 		return IRQ_NONE;
 
-	if (FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, axis_ctrl)) {
+	if (FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, axis_ctrl) ||
+	    FIELD_GET(ADXL345_ACT_XYZ_EN, axis_ctrl)) {
 		ret = regmap_read(st->regmap, ADXL345_REG_ACT_TAP_STATUS, &regval);
 		if (ret)
 			return IRQ_NONE;
@@ -1050,12 +1265,19 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
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
+	if (adxl345_push_event(indio_dev, int_stat, act_dir, tap_dir))
 		goto err;
 
 	if (FIELD_GET(ADXL345_INT_OVERRUN, int_stat))
@@ -1223,6 +1445,20 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		if (ret)
 			return ret;
 
+		/*
+		 * Initialized with sensible default values to streamline
+		 * sensor operation. These defaults are partly derived from
+		 * the previous input driver for the ADXL345 and partly
+		 * based on the recommendations provided in the datasheet.
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


