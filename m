Return-Path: <linux-iio+bounces-15839-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C73CA3D726
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 11:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2AD317AB05
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 10:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E125E1F582B;
	Thu, 20 Feb 2025 10:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBdy8vCv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990D71F463B;
	Thu, 20 Feb 2025 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048174; cv=none; b=KQgL87w237vlHO/v/P+o4EnAMDH8dhDNUJKXTMsyNZbZW2ADpy+DJ+ubgNx39AalNvDoUpWs3gTMutWB+vv4mnIL8m80Z/rXxbLDSucUuxetC1av2PG0npQ77fvra8H2br91pz74Dh9HtBVIDVukOQDL0+KGy013QES08EvjKIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048174; c=relaxed/simple;
	bh=veoJEo01/TYfg9M49Wpt0ngS9B4jMEJA09W/RI4zBEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S9DFCi2cNJwqZGDoTZVGugPdCjWfgCPE4qNxBDRc9MdV77iEWDoLpdaa+JdBzayVVogm/S+j22iS8upRZOCM7QQZIl7T4bPe7btI7vPYzabYPIl/Fz37cPQDZ0UAjdkAtJMTSr0cLnx15mX7Ix4vFBdSrfL90S/ZXNgvgg2dsGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBdy8vCv; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e02e77ea3cso114311a12.1;
        Thu, 20 Feb 2025 02:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740048171; x=1740652971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEuSZNgL2ESJTm75rVqG1TiF5psoPm0kxIpMbt1HsYc=;
        b=KBdy8vCvRq6AF9MdnyZrfJcekvgp2hCwM880mvFPX7IrTdA9xOFn6u9u/tTdTC6v0f
         F8XO2LF4ff0kwwPnAoRYXMu4CTemUELi+zWOG1veBxbWfc9GlECIctfHb8HKj6NHLfgp
         LJ06/Qs9mL181sYRTknL92kv2KwvBxratIAgSh6Cd1gsViTba7UNf/Abd6h/ulh/9eYh
         uXoFECCycK8G3pFXCRcFxuddokOHSyKXdhXctyRClniFVIzm/DnPblSGFgrIkDLm4HOC
         BV4UEN6TTeJaBWzNJRPg2lc5O9FcIoxr4wuXuEKx9kDxAsBbUQG+b1e8nKFDwQcoM7Aj
         3pqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740048171; x=1740652971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEuSZNgL2ESJTm75rVqG1TiF5psoPm0kxIpMbt1HsYc=;
        b=r6Ce6xVM2UA3tERcdV5QADmiZfW/euso8fKliQHdYhjBrOOQbo1GxNY2vQ/RwSpkHt
         ssX5sE2NuwFHk5ohr7YknQo1XZ2eUw8jO20bn7ad1GrJPNu8w2wlJJrCIM4pIDJEgFYc
         cDMCH0ljP+qbFMOajUUphZrB8+nGJm/1poDYPPTZvw2zJt4+ObpE2KBe/lLu+sZTC6D7
         kSvw3aAA2WCRb23/ywpoBLkFe4Bs3wxHS4y9vnTCXzaVK3fgWGUjk/Ab2onNtx1SUa50
         udExuVPHOjFPe27vp6or9rK2HKVoJ/xFWs3+/z/iiXECOO8iMUVCD/Rb6/ONuZnPWEM8
         5sZw==
X-Forwarded-Encrypted: i=1; AJvYcCUvKXLFmmf4qxCN3OjN7sn7m93PqXaP0HiXeiK3SOcwiApL6nptG6M0a+8C1E73FFQLt2iqM1QEXKdV+x4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc+HUFkdvdTXhksMh0AuDN6PJmGKl6JU6KUiWcnhXmhmauXZRJ
	1Ma3P/GRmScEFuLsqlHad4dOB+Esc8cpS0iT9Fu70rgetkXbp7TC
X-Gm-Gg: ASbGncs7/JNlFjqWfwNxKoaqAno2ZYbZUEQt+udAFpy1XnphKnfFf3A5NMj+/8+4yCQ
	kU51Cie/rGpQkKuXt0jZ/A0/vrrguEe9lZUgr3z/7QecQDrm63jwZ5TTnIXF/I3CyyMrgHLeI99
	hjR9iegOQBeSvD31mQrqFaxz6aIFTGo9oHFJNIvsbfeZEv5uVr7dBeM1UyHgNcP5k8Ub/ZPnOqX
	9U2c8keRZR5pO1E+SzCPLSmFhoNxu8cnRtTUDVZf+tsHhJeex36qbH65+1tI4vs9fjeIT7kQcbm
	c8slquJqPA7jH093yfYwKGxoZ3pOIk7Qdjr08f7yVoPdF3EvNmZeUe92JPra0pzaEMXrvw==
X-Google-Smtp-Source: AGHT+IEP4Q+5+zwugRKwDMhtpe2w1LYTE2MhbvCVG88FNINMlPB0sBZu9Zl/nS4C3wkdt+Ez4Xk5jQ==
X-Received: by 2002:a17:907:9690:b0:ab6:d575:3c41 with SMTP id a640c23a62f3a-abb7093229dmr749092866b.3.1740048170491;
        Thu, 20 Feb 2025 02:42:50 -0800 (PST)
Received: from 0f997e1ceb21.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbdfcaed55sm246474866b.137.2025.02.20.02.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:42:50 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v3 12/15] iio: accel: adxl345: add activity event feature
Date: Thu, 20 Feb 2025 10:42:31 +0000
Message-Id: <20250220104234.40958-13-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220104234.40958-1-l.rubusch@gmail.com>
References: <20250220104234.40958-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the sensor detect and issue interrupts at activity. Activity
events are configured by a threshold stored in regmap cache.

Activity, together with ODR and range setting are preparing a setup
together with inactivity coming in a follow up patch.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 183 +++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index ab1ab09f348a..f1895925a80b 100644
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
@@ -148,6 +166,7 @@ struct adxl345_state {
 	u8 watermark;
 	u8 fifo_mode;
 
+	u32 act_axis_ctrl;
 	u32 tap_axis_ctrl;
 	u32 tap_duration_us;
 	u32 tap_latent_us;
@@ -158,6 +177,13 @@ struct adxl345_state {
 };
 
 static struct iio_event_spec adxl345_events[] = {
+	{
+		/* activity */
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
+			BIT(IIO_EV_INFO_VALUE),
+	},
 	{
 		.type = IIO_EV_TYPE_GESTURE,
 		.dir = IIO_EV_DIR_SINGLETAP,
@@ -258,6 +284,73 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
 	return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
 }
 
+/* act/inact */
+
+static int adxl345_write_act_axis(struct adxl345_state *st,
+				  enum adxl345_activity_type type, bool en)
+{
+	int ret;
+
+	/*
+	 * The ADXL345 allows for individually enabling/disabling axis for
+	 * activity and inactivity detection, respectively. Here both axis are
+	 * kept in sync, i.e. an axis will be generally enabled or disabled for
+	 * both equally, activity and inactivity detection.
+	 */
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
+	}
+	return 0;
+}
+
+static int adxl345_is_act_inact_en(struct adxl345_state *st,
+				   enum adxl345_activity_type type, bool *en)
+{
+	int ret;
+	unsigned int regval;
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
+				    enum adxl345_activity_type type, bool cmd_en)
+{
+	bool axis_en, en = false;
+	unsigned int threshold;
+	int ret;
+
+	ret = adxl345_write_act_axis(st, type, cmd_en);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->regmap, adxl345_act_thresh_reg[type], &threshold);
+	if (ret)
+		return ret;
+
+	if (type == ADXL345_ACTIVITY) {
+		axis_en = FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, st->act_axis_ctrl) > 0;
+		en = axis_en && threshold > 0;
+	}
+
+	return regmap_update_bits(st->regmap, ADXL345_REG_INT_ENABLE,
+				  adxl345_act_int_reg[type],
+				  en ? adxl345_act_int_reg[type] : 0);
+}
+
 /* tap */
 
 static int adxl345_write_tap_axis(struct adxl345_state *st,
@@ -685,6 +778,16 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
 	int ret = -EFAULT;
 
 	switch (type) {
+	case IIO_EV_TYPE_THRESH:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			ret = adxl345_is_act_inact_en(st, ADXL345_ACTIVITY, &int_en);
+			if (ret)
+				return ret;
+			return int_en;
+		default:
+			return -EINVAL;
+		}
 	case IIO_EV_TYPE_GESTURE:
 		switch (chan->channel2) {
 		case IIO_MOD_X:
@@ -735,6 +838,13 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 	enum adxl345_axis axis;
 
 	switch (type) {
+	case IIO_EV_TYPE_THRESH:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return adxl345_set_act_inact_en(st, ADXL345_ACTIVITY, state);
+		default:
+			return -EINVAL;
+		}
 	case IIO_EV_TYPE_GESTURE:
 		switch (chan->channel2) {
 		case IIO_MOD_X:
@@ -776,9 +886,29 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 	struct adxl345_state *st = iio_priv(indio_dev);
 	unsigned int tap_threshold;
 	unsigned int ff_threshold;
+	unsigned int act_threshold;
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
@@ -842,6 +972,23 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
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
@@ -1124,6 +1271,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
 			return ret;
 	}
 
+	if (FIELD_GET(ADXL345_INT_ACTIVITY, int_stat)) {
+		ret = iio_push_event(indio_dev,
+				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+							act_tap_dir,
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
@@ -1157,6 +1315,7 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 		ret = regmap_read(st->regmap, ADXL345_REG_ACT_TAP_STATUS, &regval);
 		if (ret)
 			return ret;
+		/* tap direction */
 		if (FIELD_GET(ADXL345_Z_EN, regval) > 0)
 			act_tap_dir = IIO_MOD_Z;
 		else if (FIELD_GET(ADXL345_Y_EN, regval) > 0)
@@ -1165,6 +1324,19 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 			act_tap_dir = IIO_MOD_X;
 	}
 
+	if (FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, st->act_axis_ctrl) > 0) {
+		ret = regmap_read(st->regmap, ADXL345_REG_ACT_TAP_STATUS, &regval);
+		if (ret)
+			return ret;
+		/* activity direction */
+		if (FIELD_GET(ADXL345_Z_EN, regval >> 4) > 0)
+			act_tap_dir = IIO_MOD_Z;
+		else if (FIELD_GET(ADXL345_Y_EN, regval >> 4) > 0)
+			act_tap_dir = IIO_MOD_Y;
+		else if (FIELD_GET(ADXL345_X_EN, regval >> 4) > 0)
+			act_tap_dir = IIO_MOD_X;
+	}
+
 	if (regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, &int_stat))
 		return IRQ_NONE;
 
@@ -1248,6 +1420,13 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		return -ENODEV;
 	st->fifo_delay = fifo_delay_default;
 
+	/*
+	 * If the feature is enabled, scan all axis for activity and or
+	 * inactivity, and set activity and inactivity to the same ac / dc
+	 * setup.
+	 */
+	st->act_axis_ctrl = ADXL345_REG_ACT_AXIS_MSK;
+
 	/* Init with reasonable values */
 	tap_threshold = 48;			/*   48 [0x30] -> ~3g     */
 	st->tap_duration_us = 16;		/*   16 [0x10] -> .010    */
@@ -1273,6 +1452,10 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	if (ret)
 		return ret;
 
+	ret = adxl345_set_range(st, ADXL345_16G_RANGE);
+	if (ret)
+		return ret;
+
 	/* Reset interrupts at start up */
 	ret = regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, 0x00);
 	if (ret)
-- 
2.39.5


