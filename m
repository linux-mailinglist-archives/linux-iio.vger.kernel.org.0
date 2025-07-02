Return-Path: <linux-iio+bounces-21264-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8ECAF65D9
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 01:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01E5188FE5F
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 23:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D412F5C44;
	Wed,  2 Jul 2025 23:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5N8uDs0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4F02EBDC1;
	Wed,  2 Jul 2025 23:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497423; cv=none; b=jflLBrHvj+8Yrv/2yhosW96WlvjPdqzkyeEj1gJRuk4b3Z15xYFUTSw2Fj7Xwsxn8QLF4uysHt51aVx6hFGooG17jvz7ocuWhdrqCSffvdCw98iw2NsRKfpH+crz2sGAv05oKX2/GoH/09kgm3O75APYOXve2QJhbYmKkZKaVps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497423; c=relaxed/simple;
	bh=dXSD3Y9CdFOC7DBI5PmdQ8SOqNP4fSCXkxy9goyX044=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qHkTkp4hIvPQqI4ltAx97mxCRoho/Zm3HMCRVgTeX6Sh+QuyGtppUYESvoioPHVO8vTjlAAlPPWENzSRultab5cCPcL+KRXBoiSRubcSr9fRXKY0QsgG0yDCflQmBjpUee3ONqcFgT1fXnj7jg2P11/qc8TWHfCVbS2Fu0yZCBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5N8uDs0; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6070a8f99ffso1434704a12.3;
        Wed, 02 Jul 2025 16:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497420; x=1752102220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/t2LXrBhfR6tCe/TVOle2ATEgtYF3+FI/Wh5WPA3/A=;
        b=S5N8uDs0XLvpsgYHMLMzAFYCt+5R9rsB5r6RdQBP+9l/F6tOOYHILAKSnUPzKEFMCz
         8fjJ+pHMGMkDTquqpKFJPhbjdRUGcywwPyfPoDm3JAwEFVOYCDDL9TiH2b/Uz1+sB+Ti
         5mr5tsSgtEz53pgTNaRft9oQeWrMbc1JXEzVc/DPnLthWPuUuSGHYfLi9QPhqVcTffIp
         Uqd29T+SlfCDIKi22o2yx2xkrC5n3R9XPg3hguL6SB/drB4nujOy9Bu6Tb1xJEAPwKtA
         Obr1KHYlHr6IXwRT3DAACtrrnC+Qw+oDi4KvajEGR4TWlKHDonAyl4TrXwQrREA1DSJ8
         0b9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497420; x=1752102220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/t2LXrBhfR6tCe/TVOle2ATEgtYF3+FI/Wh5WPA3/A=;
        b=HZDcnl/JtNeZtXf6HtG+3pdVglLQLIu0940JQn1//UYm6VKJT9r/hHleP6s8ItejPp
         8sOLsRELZmQLlYcXEkOzk+uxDBvVYR+nsWQhZgtk6ABma2mMAoK5EMqx4oQrDSmV33Tj
         8XEgKc04WYQTGeevkTG09q4ORB0Ve5kvma59EjHkBsw8SDWG4ldQu9ubdBLS6cx8ylFt
         pqM4HYmBFHyF8ehKR56aNSl8G6CpZjpqMAd6be/YYhR4WvCxKXJ5NX7If2ltVs67Ipky
         pjbbJrMstUTQEmzOrfnqM8Owv5V11ROX0oxKmX88qUJwuQm2avIgFs49cKgHlCOy4tSa
         46rw==
X-Forwarded-Encrypted: i=1; AJvYcCUuSe+3XqHlmhtX4VnZoat+/75I/Tqx2TzOtgozoJlH8TYe0cVnCWXSryugZ0EPhrnRAVkFD+ovb3k=@vger.kernel.org, AJvYcCWMBauNqlFcU8ZGxLHoNkqldeclS3xwiGozoKE0ovuQ4u0aBa87+zrA9nZOGU4IWpkmPGM7X8kF59A4otPT@vger.kernel.org
X-Gm-Message-State: AOJu0YxYwfPnu1uymbLDIBRFmqSgurf2k17lKtPmD4IrgBXZLRRNvOKt
	TlzwpPtYJ/eNELfC5A4tPSkLOvXTUJizLhjdY3JaKC6U/hk8JxcB8KsJ
X-Gm-Gg: ASbGncs8HHe3CDFPFj/iTmiTjKrnvWMuLjA9Gf6htoyFSavE+XXZd8ENz+7gf2lrvxC
	pDwkyuvXV1mivzl5Q62ti2V2AZCqAIWAMpS8dbFwfxBQv7OCjhAa23qPRbpKZSpptH9iLT5mHEP
	IWhf+a0W7qrErlCqX9U/g1aa1EAMlblT1oRLkPSknE1uAfLU39VwM9pjeYZlZ4UuiBqriVs0ksN
	xVVd/tt5MT82+LZ+nTdN4U5DT2tYthmZR0RuRKSRLYn0s+SzngqX3l0KEak0RPpJWlGLbVss66t
	PxpPtsTo3q8f4CEdS7HUc3LOdbFLky3RuI5WBLq9EszFmQBEzHJVDbEx2DMVXYkYX7Nq30qDDWF
	TITZIcEx6xC/Ldhai8mr8wfZr+LjLy44P
X-Google-Smtp-Source: AGHT+IF5DfIZycpfZgNHK6WlGH0ylLbAbMvmhMH5A+iKdVjNJlzqMfw5bh4OQYyBbzsYJ1As0zA4gQ==
X-Received: by 2002:a05:6402:5487:b0:607:7add:8647 with SMTP id 4fb4d7f45d1cf-60e74514bc3mr77375a12.8.1751497419567;
        Wed, 02 Jul 2025 16:03:39 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c8319e706sm10031469a12.47.2025.07.02.16.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:03:38 -0700 (PDT)
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
Subject: [PATCH v11 3/8] iio: accel: adxl345: add activity event feature
Date: Wed,  2 Jul 2025 23:03:10 +0000
Message-Id: <20250702230315.19297-4-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250702230315.19297-1-l.rubusch@gmail.com>
References: <20250702230315.19297-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl345_core.c | 242 ++++++++++++++++++++++++++++++-
 1 file changed, 239 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index b7dfd0007aa0..eb24ee7c4251 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -36,11 +36,17 @@
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
+#define ADXL345_ACT_XYZ_EN		(ADXL345_ACT_Z_EN | ADXL345_ACT_Y_EN | ADXL345_ACT_X_EN)
+
 /* single/double tap */
 enum adxl345_tap_type {
 	ADXL345_SINGLE_TAP,
@@ -64,6 +70,19 @@ static const unsigned int adxl345_tap_time_reg[] = {
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
@@ -144,6 +163,13 @@ struct adxl345_state {
 };
 
 static const struct iio_event_spec adxl345_events[] = {
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
@@ -237,6 +263,87 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
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
@@ -624,6 +731,31 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
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
@@ -634,6 +766,9 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		return adxl345_read_mag_config(st, dir,
+					       ADXL345_ACTIVITY);
 	case IIO_EV_TYPE_GESTURE:
 		switch (dir) {
 		case IIO_EV_DIR_SINGLETAP:
@@ -665,6 +800,10 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 	struct adxl345_state *st = iio_priv(indio_dev);
 
 	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		return adxl345_write_mag_config(st, dir,
+						ADXL345_ACTIVITY,
+						state);
 	case IIO_EV_TYPE_GESTURE:
 		switch (dir) {
 		case IIO_EV_DIR_SINGLETAP:
@@ -679,6 +818,58 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
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
@@ -691,6 +882,10 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		return adxl345_read_mag_value(st, dir, info,
+					      ADXL345_ACTIVITY,
+					      val, val2);
 	case IIO_EV_TYPE_GESTURE:
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
@@ -741,6 +936,13 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
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
@@ -980,7 +1182,8 @@ static int adxl345_fifo_push(struct iio_dev *indio_dev,
 }
 
 static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
-			      enum iio_modifier tap_dir)
+			      enum iio_modifier tap_dir,
+			      enum iio_modifier act_dir)
 {
 	s64 ts = iio_get_time_ns(indio_dev);
 	struct adxl345_state *st = iio_priv(indio_dev);
@@ -1007,6 +1210,16 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
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
@@ -1034,6 +1247,7 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 	struct adxl345_state *st = iio_priv(indio_dev);
 	unsigned int regval;
 	enum iio_modifier tap_dir = IIO_NO_MOD;
+	enum iio_modifier act_dir = IIO_NO_MOD;
 	u32 axis_ctrl;
 	int int_stat;
 	int ret;
@@ -1042,7 +1256,8 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 	if (ret)
 		return IRQ_NONE;
 
-	if (FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, axis_ctrl)) {
+	if (FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, axis_ctrl) ||
+	    FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, axis_ctrl)) {
 		ret = regmap_read(st->regmap, ADXL345_REG_ACT_TAP_STATUS, &regval);
 		if (ret)
 			return IRQ_NONE;
@@ -1053,12 +1268,19 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
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
@@ -1226,6 +1448,20 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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


