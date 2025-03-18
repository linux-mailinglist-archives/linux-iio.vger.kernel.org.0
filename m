Return-Path: <linux-iio+bounces-17064-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CEDA68088
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 00:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13AA57A98E8
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 23:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B97215182;
	Tue, 18 Mar 2025 23:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atYGaiKp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0104D21504E;
	Tue, 18 Mar 2025 23:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742339349; cv=none; b=uZ7dJJaA1snWfrNx2+NdetW8BYwcNCkw1cIU21X2uQsIrVOrdj5OIs5Aq+dFSeuyxTaJOTbsyQAbEc1xzgvTN+nyIXDBYfUJduyfBMJ2YVc5Ars2kqJGR5lAu4RxuNOpP01rNT8OIIL4zHMhsRGa29HUD1IclF86h+OvqrPS4i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742339349; c=relaxed/simple;
	bh=RVR3zu+KfVpUgL3tdC4QLemoM5TIYvYAsCe4gVAhl+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XCWn6uVpy7yFYXy4SqNA9kTOTSIEv+Zufk05MoKcLptPPsbep0RrW1vVswuJyfciDfhjFW3RdgUh+oX9qlUuD5uZFts7J81x8ibhw6/MpeoM71SWfoYASsnX2D80iPZT+s1lrqUWPhqpFNsz6+RpW9uinAJW0Q1IsgBMUDVYkcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=atYGaiKp; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39973c72e8cso23685f8f.0;
        Tue, 18 Mar 2025 16:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742339344; x=1742944144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MxxWAHFgtZ5hBiQ9O6m5AIG2XO+clsclDewmbmkb1Q=;
        b=atYGaiKpYJidHuAzn8GF4dRfZAr0vrZj97rL7QnFSSdX/0rQXCLb0GTWUQcK2w56AK
         x+ueQf2j2uQ9GvpATsoSOCoohfe42xlqlEt607He2y6O1aDEWR3w4ZF8g/cSePj5IMJ9
         klaAwT4k9AJ7RZXEiwP+B5kEv89bXcneVF7WUSNvWG1LsQ25nVZcaeRA5Dwp/mBOH9xg
         EW/0cFWTzncpQpeYY5uA99aV2sU1cbreXH/3CrXY8P0Mp1byTqGU3JqHrX+9R2bIsfP4
         DyF85FF2YhJZMt3zi7TvkQq6Zi34UsOZ5le/VZHYK1i3o3fTjOaPEMVrqTkYy5BG4kFC
         cDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742339344; x=1742944144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0MxxWAHFgtZ5hBiQ9O6m5AIG2XO+clsclDewmbmkb1Q=;
        b=B+8rdISjCyEB4bagMf9NcWspjtpXVLZNGitGSBSJTjIoVBnISCHxsBuusykgtIp6LY
         s5mIKIU2PjpqrYkh5JSy+3QDRnGY96/SD+64/DvACeB8BedHoU4q48G3HJobYf5xfEW+
         jjNWWl5ZvuzAkNaJIPzE/uQEczlzPxCFToyf0N372eKAKSjIg8WKKLb+j20fw7wFSstz
         XkbxjwAlS3sZxHyucYHUBIPQF9vC8YJK+ywnjZ+Th9Go97SFGRdrCrXPkHMGvO1X0xDH
         YpF7PfkatPMf/L0YN8kucPrpErFUrxcL7f5FbZo0NsiuYh/l7v3ctE1KNSGPKHYEZJGL
         /fig==
X-Forwarded-Encrypted: i=1; AJvYcCVa+jH4PT/Jfyl6MIERF063MmgEEAXWsRbPN0HGUbyF3L0+5KcQzrmvoAqoe/PqDqzZxWRJO4rdhNPIOiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbtzBAGTVTLNfoU0h3j/7Y/tw31Z+sKcDpl2paF1yVRLY1qaY7
	4mvC+sHF9vP1OIJ+XWM7GR20BguWPRB7+h/OHDfZv4wHuwu6eqCf
X-Gm-Gg: ASbGncsYPuPGZpXEL2q9wu3wc0P2jFNAfAMAameX0KQ+P50YFNISpkPrO0epRxEFIf9
	+tZ/39aCVQl4yBoO4HaRdotSmW6b7efPhqkDr1wUIsRlIY314uuoKoDNxLwyiV068kCx0xEJhgV
	Kdr+mJhcmIE7CklwESTX0lLkHqvW1mtYw0+s9+QH0d9g2xggMhAt+8s4KguJIoqYL2/1ItOlVc9
	2adp7jUVJ2A1UYXK2f8SzuwaRtKp8RiU0sJbZ2LdJwrLKJKzW3pbK5V6eUAdyXRIs6Tlm2xJsKe
	Uplm/4A2Og1C/amBRMucA5lMp0OdV2SVs3Gvqb4NosfeVVBFMQgFVuXNX/nMhHmFxsGGWmb06PP
	pzjNqqmA5Vwoy+8pqjs9C9Yc=
X-Google-Smtp-Source: AGHT+IFbLpLERbrnwjMKdeBkNF8KKBZypHzQEZv7hyct3CaYbSrPm966Rch2KFbwovpFWDCzYWWOog==
X-Received: by 2002:a05:600c:3503:b0:43d:2318:ed7f with SMTP id 5b1f17b1804b1-43d436c8322mr1185945e9.0.1742339343978;
        Tue, 18 Mar 2025 16:09:03 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d440ed793sm1113455e9.39.2025.03.18.16.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:09:03 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v5 08/11] iio: accel: adxl345: add activity event feature
Date: Tue, 18 Mar 2025 23:08:40 +0000
Message-Id: <20250318230843.76068-9-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318230843.76068-1-l.rubusch@gmail.com>
References: <20250318230843.76068-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl345_core.c | 209 ++++++++++++++++++++++++++++++-
 1 file changed, 206 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 2ba77f31c3a0..6b8491202119 100644
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
@@ -256,6 +281,97 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
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
+	int ret;
+
+	ret = regmap_read(st->regmap, ADXL345_REG_ACT_INACT_CTRL, &axis_ctrl);
+	if (ret)
+		return ret;
+
+	if (type == ADXL345_ACTIVITY) {
+		switch (axis) {
+		case IIO_MOD_X:
+			axis_en = FIELD_GET(ADXL345_ACT_X_EN, axis_ctrl);
+			break;
+		case IIO_MOD_Y:
+			axis_en = FIELD_GET(ADXL345_ACT_Y_EN, axis_ctrl);
+			break;
+		case IIO_MOD_Z:
+			axis_en = FIELD_GET(ADXL345_ACT_Z_EN, axis_ctrl);
+			break;
+		default:
+			return -EINVAL;
+		}
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
@@ -704,6 +820,18 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
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
@@ -740,6 +868,14 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
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
@@ -764,11 +900,31 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
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
@@ -835,6 +991,25 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
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
@@ -1093,7 +1268,8 @@ static int adxl345_fifo_push(struct iio_dev *indio_dev,
 }
 
 static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
-			      enum iio_modifier tap_dir)
+			      enum iio_modifier tap_dir,
+			      enum iio_modifier act_dir)
 {
 	s64 ts = iio_get_time_ns(indio_dev);
 	struct adxl345_state *st = iio_priv(indio_dev);
@@ -1120,6 +1296,16 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
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
@@ -1158,6 +1344,7 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 	struct adxl345_state *st = iio_priv(indio_dev);
 	unsigned int regval;
 	enum iio_modifier tap_dir = IIO_NO_MOD;
+	enum iio_modifier act_dir = IIO_NO_MOD;
 	u32 axis_ctrl;
 	int int_stat;
 	int ret;
@@ -1166,7 +1353,8 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 	if (ret)
 		return IRQ_NONE;
 
-	if (FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, axis_ctrl)) {
+	if (FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, axis_ctrl) ||
+	    FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, axis_ctrl)) {
 		ret = regmap_read(st->regmap, ADXL345_REG_ACT_TAP_STATUS, &regval);
 		if (ret)
 			return IRQ_NONE;
@@ -1177,12 +1365,19 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
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
@@ -1347,6 +1542,14 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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


