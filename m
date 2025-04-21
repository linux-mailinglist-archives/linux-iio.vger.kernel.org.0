Return-Path: <linux-iio+bounces-18476-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72016A95900
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 00:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AF9A3B1130
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 22:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C23B2253EF;
	Mon, 21 Apr 2025 22:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNj6u4nU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF5F2236E4;
	Mon, 21 Apr 2025 22:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745273227; cv=none; b=PDAVcb/N+pwHQ7Dn/GTZEI+qiiV6LHbkTpwreVu6HiQnTdCwLfDOjmKj8IH5RdXSyRXHdK0tCMVSzLX3xtJ6+HSnT7SBucnsOUGhmvHQAFbr98g/cquzbMX6F/i+E8OCFKOnH9rUfv2Gy0qZHORPB+T2raeXg+cyivqfruQXstk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745273227; c=relaxed/simple;
	bh=EtD3rmJf7q/N/LrJ8EPBuCdxDjFFCbLFEV4iJjPxgVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b9eBjQAsrwQBP+4HhI7nYdnxcPd41WW3wtvvhmylmv1P74eZ1cFCH7zzCPRECzUs4/JczOVLpzM1w8XUhqPHnaoN454Mg+lh53uLhWDxyiULfhYSp+oML3JQHYLAvsYnbd1b3WXaqTCfVFuOeK5B6JOMUcwP/Mrtp06Zq/VPQA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNj6u4nU; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e61a18c05aso649817a12.1;
        Mon, 21 Apr 2025 15:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745273223; x=1745878023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhhH8vW1ua9waxt1NFmM81BM9/bkLnKgIhzCXzZVw7Q=;
        b=GNj6u4nUT+uAMbMjL6U3lF6yXLIFQpbQuXeNqiW6op2VrdR+s6qWbwJxHeW44Q916R
         idL/dNf9/RrBcUMSl8AY+QQaA6d6sdvKA2Mxu30vrnjFhBycqHE56CAbGB+v8wf84Z4c
         AC25BQwAeugkyf9AOfUP48SbY38EmSb4woH+WbvBqReBYrsktBvLWYkoSOu7jeB9SAke
         5gkd96spmk1+A3goy+/Xuiem5GYMH9fG4/zWcxKYvWGrDBDfujInaEuQfh6z1Fp+qIp0
         Ko21OuLmmAx1nimO+lH11VT6ObzjsWpVLh+uq8OAV0wMl8k2a6JufO//to5P0HVKHf/0
         d8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745273223; x=1745878023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhhH8vW1ua9waxt1NFmM81BM9/bkLnKgIhzCXzZVw7Q=;
        b=L06nI16l6tP6+JFicxlh3uOWSSYIXIPU/F5cdcIpZjIH/kLSPxMURIunGBvVchJsYf
         ThQxwxqyUS0WEKYksg0b3WfoNQb376s/rrJrFqCNnq/zFVftZqB+Vj89u6rc5JYZJ0fe
         r9mT1p1KI6cpPvx8topxlPDZf3tVcvynAhYJhIF4dYOddr/4fOgVP54RaopDiz9l2TH6
         XolEJK9rTW4USmqqQoS+tKDCB3M4SZkJnXOH3ILLFHgENi632wkvv0rAM2emBA+D8oJC
         MA0RbrbTRlRttJokUiilpqVJCNgz/vMpuiztOQt6+l/DI0byc95m0ozgflaJmSeYx2ov
         hLxw==
X-Forwarded-Encrypted: i=1; AJvYcCVBuJOxQAIgRaEoGhVunTRYXiJBXztxlNXBM5hW0uCz7cPtN2xOKvBlClqEjYPb3Xkxs6WUg8MTImtIU7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaDmbkjcVl9vup1kl3wfrOS3TXin7t27LosZ8Ba+4WGMB7A3d9
	dHDNh9rW5q5jYj22ZFfp4jI+cZF1Zwjeo+gaZQaLUdRxtrlNzeP3
X-Gm-Gg: ASbGncvF2xAVbBpnj8Qly7M8tMrbFVusYu93TrWwmRqRqHP1bX4bK8nbl0VM07QLO37
	/pxI8zM6VfwFcVW+tYP2sb8vHzSJCBjjeSpew77NyjXCeeWBGyNb6MIltyTK7mMX1d6oyoX8wae
	u5+434s7wCROU8rejivnAMBRjH8tqp/QadVOePImhLIY7BfOIjDwudcrGf5NEx1NvqPqYVClL4S
	2rQ/y10qxe2fXr5DelNRNmZf186eeD7TyXJNd/QDX9Lcqei2vVRakjLNjpvN7AoeV91H709QzTg
	HmfQAYaXdrlvlwHhCLQFKqCOhQmChAEJVq/Lg1rA6s6rLQlIkELa1qEA//3DE9WWz3E7CKed6aG
	e6PhtFaZGoozyqD4nNpc=
X-Google-Smtp-Source: AGHT+IG14W9Vc5Sfxpctf5Tz5utDxHpICMMmU4pPCOkAt/tAD65UkiENCpe2R7ADOCJUf+eV9Ppo7w==
X-Received: by 2002:a17:907:7f0d:b0:acb:583:c63a with SMTP id a640c23a62f3a-acb74dd060cmr337217266b.15.1745273223012;
        Mon, 21 Apr 2025 15:07:03 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acbb8d49fdasm80311666b.67.2025.04.21.15.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 15:07:02 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v7 08/11] iio: accel: adxl345: add activity event feature
Date: Mon, 21 Apr 2025 22:06:38 +0000
Message-Id: <20250421220641.105567-9-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250421220641.105567-1-l.rubusch@gmail.com>
References: <20250421220641.105567-1-l.rubusch@gmail.com>
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
index 80b5b8402ced..680981609d83 100644
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
@@ -265,6 +290,99 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
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
@@ -719,6 +837,18 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
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
@@ -755,6 +885,14 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
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
@@ -779,11 +917,31 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
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
@@ -850,6 +1008,25 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
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
@@ -1108,7 +1285,8 @@ static int adxl345_fifo_push(struct iio_dev *indio_dev,
 }
 
 static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
-			      enum iio_modifier tap_dir)
+			      enum iio_modifier tap_dir,
+			      enum iio_modifier act_dir)
 {
 	s64 ts = iio_get_time_ns(indio_dev);
 	struct adxl345_state *st = iio_priv(indio_dev);
@@ -1135,6 +1313,16 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
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
@@ -1173,6 +1361,7 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 	struct adxl345_state *st = iio_priv(indio_dev);
 	unsigned int regval;
 	enum iio_modifier tap_dir = IIO_NO_MOD;
+	enum iio_modifier act_dir = IIO_NO_MOD;
 	u32 axis_ctrl;
 	int int_stat;
 	int ret;
@@ -1181,7 +1370,8 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 	if (ret)
 		return IRQ_NONE;
 
-	if (FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, axis_ctrl)) {
+	if (FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, axis_ctrl) ||
+	    FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, axis_ctrl)) {
 		ret = regmap_read(st->regmap, ADXL345_REG_ACT_TAP_STATUS, &regval);
 		if (ret)
 			return IRQ_NONE;
@@ -1192,12 +1382,19 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
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
@@ -1362,6 +1559,20 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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


