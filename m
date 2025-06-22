Return-Path: <linux-iio+bounces-20876-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33899AE309B
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 17:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D1373B157A
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 15:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922731F875A;
	Sun, 22 Jun 2025 15:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYggceU4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E171F09B3;
	Sun, 22 Jun 2025 15:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750607421; cv=none; b=iWpqezheOOk8EHwLP89PI7+sxw2rb70q03y5dz8KzeB2YllrX2lfb4sEOTCx/tfApwjNejPCtIeT/jcY4osT7d4H5TZqxewz/14GRNNa1gbCqv7yiXDVEQwi3jNKza+1vfju2C4umANCHSXGM7jQ5+GVqYwWPSIu+XK3kP5x8/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750607421; c=relaxed/simple;
	bh=oCRy1ZQSUb9ukwEP/W3QHY4woZ1eiV+QRQuJ/xo/CUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DlMCMtx3y5cEhQoF7gzPFUmMUAZw0zNdzCyOV3/yS9i1sO9GOQTv7+PNK1Tsr/sme9B8bDkWSArJ5n2bFjpzdN7MTPXT507SSa0rjfZ2CoOils+R+F1ch+1V8nuWYcxWbbZLi3PFr8r9rmH1WUneHmJgfmCUul3xhmBZTF7/s6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYggceU4; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ade6ef7e6b5so63570866b.3;
        Sun, 22 Jun 2025 08:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750607418; x=1751212218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQb7325VOJ6/baYGlSu5wu/ewUw5736k+prFnTlHKuw=;
        b=SYggceU4AD+JO3ngNu8Ol54lwuAqL0vKO2W1qH40DzCyLq7RgSbjmzeLHJLQGl1pf0
         56NUPB/7alq/J3aa3vKEejv1im2q5HFAR3p18DRMVux5FNqqYRIkjQM0mT9189EnYQUC
         QrARiA0xvcdDbTJtS2ShUJaR101NbmyNj2AT0b4ewpWAR6i3x3fVh9sqBnmpuL9lcseO
         84+kJNSwq7GVE1sg3a5U1/xFPHIWF9i8gH5hbU8jFK68JUtvlPddjX/FfrGrSMfSbMZM
         eQ3Hyrm9X/WWopIKDQAdYAeL8i6+h4U/x1dZ+A3RR1lJoJgj28fW4qbxJwgOqO4vOYX7
         8iow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750607418; x=1751212218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQb7325VOJ6/baYGlSu5wu/ewUw5736k+prFnTlHKuw=;
        b=RJcizTT63fSRpjDXTCK+G8hbj41/OJSMbm9jQNzsJn7ER+9Ax6yzUP6h7BAkqfHLsk
         rna0C+sdKAc8QpIond9WTNjKTxfm6fuMInx76fY9edEiRVop0am6qLP9crctmOsFHBVb
         IPzaiS80x4IaRvOdnqgOx0WW2/HHwzPrc+AFg/miafxyzi9WsYctpkSoDyLm/KuFAWOB
         DBMfw80oG1Q1TJgNhbkBSg9HBuafP87zqIR3edMkX0KkJpJrUAMo/sJZ506qeb7A0gG5
         DDn7YXU8JEtLUqUaKfBXh9yZLqUuNqSimgcYrwB43JydqyYpm5vnC2gRfxo9XvDi1ER8
         JGgA==
X-Forwarded-Encrypted: i=1; AJvYcCVRHl/kTIGiQfCxQp4EwBgLVRMWRua4XnykrMBInhoBJrqBluPgwf9Gbhl+CQIVXBsS35EU6+K2uO4=@vger.kernel.org, AJvYcCX7/3bpipsuRmf4r1kVdTwUwtxhhyuAurFnmPPkkH+DilncrQ/33yabH+wMRRbbQjtRnkxCmXGD73xXvT90@vger.kernel.org
X-Gm-Message-State: AOJu0YyMswDmpRhNM+deS05XY110dj/JClEFUazPljvgLu6izmQ3VH9D
	EhuvG8JzSudcrhBG8phEBdyluhHFUhvX4SEAnCgAyyKYHXSgbi2wbysY
X-Gm-Gg: ASbGncvzYjd4VHFZA/BlcDI/r/7uE3OgERwzRjdm9RMp+lrnlC6+JazyQ1A3X/6h5MQ
	3eDlzMBE+0ux+s+gyOYYpdv+M19iz9blzqT4FoopEQJIc+J86l5gR6oWQL8xe+Ix+3ugRkMDiPn
	KIOqdc0bP8Uw9StyRyU3CSCmkOKWQEpoQ7OTqgtz4ALWXlr63z+1E8AnXJQk9vrqDlSs8BVMx/f
	PB9UWPQwJETKEyasfzHULZQ5nYnTVHgqyV/1LXW40sx9jqEjNjvvXDK8Y5OuhjwlBImNiKPG9n3
	vsJ3fykh8QvkZwmIjLrjnKFwWBg8j29CdCzHMZwz632eJC1LbwhLhjvU3yXTje2XxpMa+wQ8F1o
	W6vcCORN3xYOVyk6twUH4Vo0GEzJto3nx
X-Google-Smtp-Source: AGHT+IHuLR8UlCApY770GdUmnFg6F2+tFx5EhjlpaG7j68rvbck6zMl00E0MtP/HtFjemga1lShBOw==
X-Received: by 2002:a17:907:7213:b0:ad8:89c7:61e2 with SMTP id a640c23a62f3a-ae05794689dmr321931166b.8.1750607417391;
        Sun, 22 Jun 2025 08:50:17 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053ecbd9esm552781966b.38.2025.06.22.08.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 08:50:16 -0700 (PDT)
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
Subject: [PATCH v10 3/7] iio: accel: adxl345: add activity event feature
Date: Sun, 22 Jun 2025 15:50:06 +0000
Message-Id: <20250622155010.164451-4-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250622155010.164451-1-l.rubusch@gmail.com>
References: <20250622155010.164451-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl345_core.c | 244 ++++++++++++++++++++++++++++++-
 1 file changed, 241 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 3821fe7cf2a0..99b590e67967 100644
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
+		en = FIELD_GET(ADXL345_ACT_X_EN, axis_ctrl) |
+			FIELD_GET(ADXL345_ACT_Y_EN, axis_ctrl) |
+			FIELD_GET(ADXL345_ACT_Z_EN, axis_ctrl);
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
+		axis_ctrl = ADXL345_ACT_X_EN | ADXL345_ACT_Y_EN |
+				ADXL345_ACT_Z_EN;
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
@@ -624,6 +733,31 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
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
@@ -634,6 +768,9 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		return adxl345_read_mag_config(st, dir,
+					       ADXL345_ACTIVITY);
 	case IIO_EV_TYPE_GESTURE:
 		switch (dir) {
 		case IIO_EV_DIR_SINGLETAP:
@@ -665,6 +802,10 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 	struct adxl345_state *st = iio_priv(indio_dev);
 
 	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		return adxl345_write_mag_config(st, dir,
+						ADXL345_ACTIVITY,
+						state);
 	case IIO_EV_TYPE_GESTURE:
 		switch (dir) {
 		case IIO_EV_DIR_SINGLETAP:
@@ -679,6 +820,58 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
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
@@ -691,6 +884,10 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		return adxl345_read_mag_value(st, dir, info,
+					      ADXL345_ACTIVITY,
+					      val, val2);
 	case IIO_EV_TYPE_GESTURE:
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
@@ -741,6 +938,13 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
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
@@ -980,7 +1184,8 @@ static int adxl345_fifo_push(struct iio_dev *indio_dev,
 }
 
 static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
-			      enum iio_modifier tap_dir)
+			      enum iio_modifier tap_dir,
+			      enum iio_modifier act_dir)
 {
 	s64 ts = iio_get_time_ns(indio_dev);
 	struct adxl345_state *st = iio_priv(indio_dev);
@@ -1007,6 +1212,16 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
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
@@ -1034,6 +1249,7 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 	struct adxl345_state *st = iio_priv(indio_dev);
 	unsigned int regval;
 	enum iio_modifier tap_dir = IIO_NO_MOD;
+	enum iio_modifier act_dir = IIO_NO_MOD;
 	u32 axis_ctrl;
 	int int_stat;
 	int ret;
@@ -1042,7 +1258,8 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 	if (ret)
 		return IRQ_NONE;
 
-	if (FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, axis_ctrl)) {
+	if (FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, axis_ctrl) ||
+	    FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, axis_ctrl)) {
 		ret = regmap_read(st->regmap, ADXL345_REG_ACT_TAP_STATUS, &regval);
 		if (ret)
 			return IRQ_NONE;
@@ -1053,12 +1270,19 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
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
@@ -1226,6 +1450,20 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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


