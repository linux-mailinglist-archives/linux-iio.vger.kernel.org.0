Return-Path: <linux-iio+bounces-20878-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2443AE30A1
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 17:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89002188E0F0
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 15:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D1E20297D;
	Sun, 22 Jun 2025 15:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJV0fRY6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6382C1F560B;
	Sun, 22 Jun 2025 15:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750607423; cv=none; b=WsVEI/AqT6hdeN+qpwd10FFptWm9xNLMsKNhEj+nYeLHtBGknTrHfJ+aOMis3TJTgC6rmkeztIRaRvpzMAx4zUktNZT+vCqtJOJ3/Me4ptiFaWienvZkS6uplTt0lSgpG0+gbJOFC7jspuE9yryooMA9sx+3T1GtAHziTlQyKEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750607423; c=relaxed/simple;
	bh=5q4vaZJIwBeMq0b5T8uy5ma589RluGjH1eJbp7aiXc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rZrNtvPciopKjig3YhE4aac7xvSCJHYP9FyV8gccP5ZR6DEpvVB1qHADj4z7Hj61yt6jdjsmszJXz7kRr/MbEl897vJCgI+OvifveeFXBYugVqR5axUTlqQlpK3+35+EeqdFAwhKUCtd9tQfagHPI0fenV/T62c72faaDSS9Lv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJV0fRY6; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6095cea1f4eso269182a12.0;
        Sun, 22 Jun 2025 08:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750607420; x=1751212220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ow9ujsHQEkD1S1vI52/xmEQqYlvBstlixFiJehZIezQ=;
        b=WJV0fRY6avYFJEYqUdzbPpOUcdXB6RehMRFNtGREER9oAyerlbMJ3PQdo8ptVsVsEH
         v0iJNRIDUHu0bv5LoYVd+0SNEC6z/vTWTeVR0R7EWVOM+Ic71pe3hdA7c6c+6zXBWMfV
         0hILhLm/dvLyOb3VbHMAr0IfCj+k5b9+2MyZyKvDu5HTStjrU+MTITrGjoF66u2+2LmB
         JhtTfFCZY4EgtcA6oPkVHm+6X+cQMMSkn1Ik8QZrb15G7MI3M2U2oRUG+s+iUMraY2Jz
         7UoWZyjtzVWutjTZ0InX5oLuMAZU+TPh7Ml/Xrl+Tj9ZtbKmapfsiJnl047Ms4+4vG2w
         V/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750607420; x=1751212220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ow9ujsHQEkD1S1vI52/xmEQqYlvBstlixFiJehZIezQ=;
        b=Bw8GtjG7BRC0PWqgSj4vlt+GZ5l6EWycP6cAYleH24NVPgK2rEEL7CSaBOOdR/z5Nl
         w4f4Jrgmuu59jvkbfqSp84QLjpm+MxyJG8QgpzdRTbqCMnTlABJP9y/bnhmDBEUx2TqX
         X2R2dhUx/+mSLYsC5M5+wY206dh/ozSITcFOaUk/WEyA0XbHlBMBj+6YoDDHqt1KcZAB
         4MhTkvSUqJgRhxnNg8jC6Vc+VWZd8Lgwn+0uROODx0XqzHW1spVDwiSPlDFamWkmBS5x
         FJlgq35QVFnvBLC6ZPEOp9+75ofDS7hPE3k1oFgOE/BVhnBL+S2KZlTG4XaH9VF9/QTB
         SDKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcWIvMAI8iUKLhriAqZCY3nBOVH7fnGg4FAiXVC7ktaIdMyQFNxAPnCXVfiKKWbzNdLOnUnIcjF4tRAbX6@vger.kernel.org, AJvYcCXgArKIDXznW11AsXyr61yj/3UI8rxnH4HP95qPkV8zczbN2VxT/l9Ku8bVSOBkan+jI1ULi3WSOow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQXW+7uCZoJJCa4HwHaHFAcIgPMe0AaDvBaiokOezuZ4azkC2z
	sazsgxJxbYddWc9iSSPYY49AcFIMtsb4Kr71lH4H79nk5xx6wqJTJqe+fIZeVw==
X-Gm-Gg: ASbGncsRDPdXG7cSaJoUoHgHA4R1oKFneF57hJ7ZGroj4ESQTTw866mAjYwFcXwrfCG
	ThUwcEK9gbywce8Dd7HoNz8iW9Lj7GT1ozbLIx3EQd/7/qx1NkQnQFFaVT/mm/7oax6i+Nntpwm
	ja3lqaNJV1g67cvowrgpXCK68K87c2vkvrxYs2pLoqxd4nXoAeUjeQ3BJVVg07jDarlyoqEKgub
	PrFyA9yR1e26p1JZinQMf4oiwEJtYK+7f/gs/G/kMIgUPKnhJfT9tmW8UBDzKBQob5SxcS5bonn
	rVTZi5r4MZDH9fG1hFmhlS+fjQhlQWdshW//wIRrol/ItOCWrWugwUS3/03Jfi4krO0YX4t73Mm
	A1HH2uCPVlsmM1G4e656xHONejE4W1RQ6jC3SUExemes=
X-Google-Smtp-Source: AGHT+IFD8wcr6ihxIXvxSxY44HMvEsRDM0Bkg5z4dbjCoXtn+v6Ucl+U8fuW9uihhbwIjRB+3gkn9A==
X-Received: by 2002:a17:907:94c3:b0:ade:8a6:b86b with SMTP id a640c23a62f3a-ae057c3b2b3mr279707566b.16.1750607419661;
        Sun, 22 Jun 2025 08:50:19 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053ecbd9esm552781966b.38.2025.06.22.08.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 08:50:19 -0700 (PDT)
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
Subject: [PATCH v10 5/7] iio: accel: adxl345: add coupling detection for activity/inactivity
Date: Sun, 22 Jun 2025 15:50:08 +0000
Message-Id: <20250622155010.164451-6-l.rubusch@gmail.com>
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

Enable AC/DC coupling configuration for activity and inactivity detection
by setting the AC/DC bit. Extend existing magnitude-based detection with
adaptive AC-coupled mode.

Use DC-coupled mode to compare acceleration samples directly against
configured thresholds. Use AC-coupled mode to compare samples against a
reference taken at the start of activity detection. Implement DC-coupled
events using MAG, and AC-coupled events using MAG_ADAPTIVE.

Expose configuration of thresholds and periods via separate sysfs handles.
Note that both coupling modes share the same sensor registers, so activity
or inactivity detection cannot be configured for both AC and DC
simultaneously. Apply the most recently configured mode.

Simplify event handling and support adaptive AC-coupling.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 253 +++++++++++++++++++++++++++++--
 1 file changed, 238 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 3faf1af013c7..c5a3dac5f938 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -38,6 +38,8 @@
 #define ADXL345_REG_TAP_SUPPRESS	BIT(3)
 #define ADXL345_REG_ACT_AXIS_MSK	GENMASK(6, 4)
 #define ADXL345_REG_INACT_AXIS_MSK	GENMASK(2, 0)
+#define ADXL345_REG_ACT_ACDC_MSK	BIT(7)
+#define ADXL345_REG_INACT_ACDC_MSK	BIT(3)
 #define ADXL345_POWER_CTL_INACT_MSK	(ADXL345_POWER_CTL_AUTO_SLEEP | ADXL345_POWER_CTL_LINK)
 
 #define ADXL345_TAP_Z_EN		BIT(0)
@@ -52,6 +54,9 @@
 #define ADXL345_ACT_Y_EN		BIT(5)
 #define ADXL345_ACT_X_EN		BIT(6)
 
+#define ADXL345_COUPLING_DC		0
+#define ADXL345_COUPLING_AC		1
+
 /* single/double tap */
 enum adxl345_tap_type {
 	ADXL345_SINGLE_TAP,
@@ -79,16 +84,29 @@ static const unsigned int adxl345_tap_time_reg[] = {
 enum adxl345_activity_type {
 	ADXL345_ACTIVITY,
 	ADXL345_INACTIVITY,
+	ADXL345_ACTIVITY_AC,
+	ADXL345_INACTIVITY_AC,
 };
 
 static const unsigned int adxl345_act_int_reg[] = {
 	[ADXL345_ACTIVITY] = ADXL345_INT_ACTIVITY,
 	[ADXL345_INACTIVITY] = ADXL345_INT_INACTIVITY,
+	[ADXL345_ACTIVITY_AC] = ADXL345_INT_ACTIVITY,
+	[ADXL345_INACTIVITY_AC] = ADXL345_INT_INACTIVITY,
 };
 
 static const unsigned int adxl345_act_thresh_reg[] = {
 	[ADXL345_ACTIVITY] = ADXL345_REG_THRESH_ACT,
 	[ADXL345_INACTIVITY] = ADXL345_REG_THRESH_INACT,
+	[ADXL345_ACTIVITY_AC] = ADXL345_REG_THRESH_ACT,
+	[ADXL345_INACTIVITY_AC] = ADXL345_REG_THRESH_INACT,
+};
+
+static const unsigned int adxl345_act_acdc_msk[] = {
+	[ADXL345_ACTIVITY] = ADXL345_REG_ACT_ACDC_MSK,
+	[ADXL345_INACTIVITY] = ADXL345_REG_INACT_ACDC_MSK,
+	[ADXL345_ACTIVITY_AC] = ADXL345_REG_ACT_ACDC_MSK,
+	[ADXL345_INACTIVITY_AC] = ADXL345_REG_INACT_ACDC_MSK,
 };
 
 enum adxl345_odr {
@@ -186,6 +204,13 @@ static struct iio_event_spec adxl345_events[] = {
 		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
 			BIT(IIO_EV_INFO_VALUE),
 	},
+	{
+		/* activity, ac bit set */
+		.type = IIO_EV_TYPE_MAG_ADAPTIVE,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
+			BIT(IIO_EV_INFO_VALUE),
+	},
 	{
 		/* single tap */
 		.type = IIO_EV_TYPE_GESTURE,
@@ -239,6 +264,14 @@ static const struct iio_event_spec adxl345_fake_chan_events[] = {
 		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
 			BIT(IIO_EV_INFO_PERIOD),
 	},
+	{
+		/* inactivity, AC bit set */
+		.type = IIO_EV_TYPE_MAG_ADAPTIVE,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_PERIOD),
+	},
 };
 
 static const struct iio_chan_spec adxl345_channels[] = {
@@ -346,12 +379,114 @@ static int adxl345_set_inact_time(struct adxl345_state *st, u32 val_s)
 	return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
 }
 
+/**
+ * adxl345_is_act_inact_ac() - Verify if AC or DC coupling is currently enabled.
+ *
+ * @st: The device data.
+ * @type: The activity or inactivity type.
+ *
+ * Given a type of activity / inactivity combined with either AC coupling set or
+ * default to DC, this function verifies if the combination is currently
+ * configured, hence enabled or not.
+ *
+ * Return: true if configured coupling matches the provided type, else a negative
+ *         error value.
+ */
+static int adxl345_is_act_inact_ac(struct adxl345_state *st,
+				   enum adxl345_activity_type type)
+{
+	unsigned int regval;
+	bool coupling;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADXL345_REG_ACT_INACT_CTRL, &regval);
+	if (ret)
+		return ret;
+
+	coupling = adxl345_act_acdc_msk[type] & regval;
+
+	switch (type) {
+	case ADXL345_ACTIVITY:
+	case ADXL345_INACTIVITY:
+		return coupling == ADXL345_COUPLING_DC;
+	case ADXL345_ACTIVITY_AC:
+	case ADXL345_INACTIVITY_AC:
+		return coupling == ADXL345_COUPLING_AC;
+	default:
+		return -EINVAL;
+	}
+}
+
+/**
+ * adxl345_set_act_inact_ac() - Configure AC coupling or DC coupling.
+ *
+ * @st: The device data.
+ * @type: Provide a type of activity or inactivity.
+ * @cmd_en: enable or disable AC coupling.
+ *
+ * Enables AC coupling or DC coupling depending on the provided type argument.
+ * Note: Activity and inactivity can be either AC coupled or DC coupled not
+ * both at the same time.
+ *
+ * Return: 0 if successful, else error value.
+ */
+static int adxl345_set_act_inact_ac(struct adxl345_state *st,
+				    enum adxl345_activity_type type,
+				    bool cmd_en)
+{
+	unsigned int act_inact_ac;
+
+	if (type == ADXL345_ACTIVITY_AC || type == ADXL345_INACTIVITY_AC)
+		act_inact_ac = ADXL345_COUPLING_AC && cmd_en;
+	else
+		act_inact_ac = ADXL345_COUPLING_DC && cmd_en;
+
+	/*
+	 * A setting of false selects dc-coupled operation, and a setting of
+	 * true enables ac-coupled operation. In dc-coupled operation, the
+	 * current acceleration magnitude is compared directly with
+	 * ADXL345_REG_THRESH_ACT and ADXL345_REG_THRESH_INACT to determine
+	 * whether activity or inactivity is detected.
+	 *
+	 * In ac-coupled operation for activity detection, the acceleration
+	 * value at the start of activity detection is taken as a reference
+	 * value. New samples of acceleration are then compared to this
+	 * reference value, and if the magnitude of the difference exceeds the
+	 * ADXL345_REG_THRESH_ACT value, the device triggers an activity
+	 * interrupt.
+	 *
+	 * Similarly, in ac-coupled operation for inactivity detection, a
+	 * reference value is used for comparison and is updated whenever the
+	 * device exceeds the inactivity threshold. After the reference value
+	 * is selected, the device compares the magnitude of the difference
+	 * between the reference value and the current acceleration with
+	 * ADXL345_REG_THRESH_INACT. If the difference is less than the value in
+	 * ADXL345_REG_THRESH_INACT for the time in ADXL345_REG_TIME_INACT, the
+	 * device is considered inactive and the inactivity interrupt is
+	 * triggered. [quoted from p. 24, ADXL345 datasheet Rev. G]
+	 *
+	 * In a conclusion, the first acceleration snapshot sample which hit the
+	 * threshold in a particular direction is always taken as acceleration
+	 * reference value to that direction. Since for the hardware activity
+	 * and inactivity depend on the x/y/z axis, so do ac and dc coupling.
+	 * Note, this sw driver always enables or disables all three x/y/z axis
+	 * for detection via act_axis_ctrl and inact_axis_ctrl, respectively.
+	 * Where in dc-coupling samples are compared against the thresholds, in
+	 * ac-coupling measurement difference to the first acceleration
+	 * reference value are compared against the threshold. So, ac-coupling
+	 * allows for a bit more dynamic compensation depending on the initial
+	 * sample.
+	 */
+	return regmap_assign_bits(st->regmap, ADXL345_REG_ACT_INACT_CTRL,
+				  adxl345_act_acdc_msk[type], act_inact_ac);
+}
+
 static int adxl345_is_act_inact_en(struct adxl345_state *st,
 				   enum adxl345_activity_type type)
 {
 	unsigned int axis_ctrl;
 	unsigned int regval;
-	bool en;
+	bool int_en, en;
 	int ret;
 
 	ret = regmap_read(st->regmap, ADXL345_REG_ACT_INACT_CTRL, &axis_ctrl);
@@ -361,6 +496,7 @@ static int adxl345_is_act_inact_en(struct adxl345_state *st,
 	/* Check if axis for activity are enabled */
 	switch (type) {
 	case ADXL345_ACTIVITY:
+	case ADXL345_ACTIVITY_AC:
 		en = FIELD_GET(ADXL345_ACT_X_EN, axis_ctrl) |
 			FIELD_GET(ADXL345_ACT_Y_EN, axis_ctrl) |
 			FIELD_GET(ADXL345_ACT_Z_EN, axis_ctrl);
@@ -368,6 +504,7 @@ static int adxl345_is_act_inact_en(struct adxl345_state *st,
 			return false;
 		break;
 	case ADXL345_INACTIVITY:
+	case ADXL345_INACTIVITY_AC:
 		en = FIELD_GET(ADXL345_INACT_X_EN, axis_ctrl) |
 			FIELD_GET(ADXL345_INACT_Y_EN, axis_ctrl) |
 			FIELD_GET(ADXL345_INACT_Z_EN, axis_ctrl);
@@ -383,23 +520,39 @@ static int adxl345_is_act_inact_en(struct adxl345_state *st,
 	if (ret)
 		return ret;
 
-	return adxl345_act_int_reg[type] & regval;
+	int_en = adxl345_act_int_reg[type] & regval;
+	if (!int_en)
+		return false;
+
+	/* Check if configured coupling matches provided type */
+	return adxl345_is_act_inact_ac(st, type);
 }
 
 static int adxl345_set_act_inact_linkbit(struct adxl345_state *st,
 					 enum adxl345_activity_type type,
 					 bool en)
 {
-	int act_en, inact_en;
+	int act_en, act_ac_en, inact_en, inact_ac_en;
 
 	act_en = adxl345_is_act_inact_en(st, ADXL345_ACTIVITY);
 	if (act_en < 0)
 		return act_en;
 
+	act_ac_en = adxl345_is_act_inact_en(st, ADXL345_ACTIVITY_AC);
+	if (act_ac_en < 0)
+		return act_ac_en;
+
 	inact_en = adxl345_is_act_inact_en(st, ADXL345_INACTIVITY);
 	if (inact_en < 0)
 		return inact_en;
 
+	inact_ac_en = adxl345_is_act_inact_en(st, ADXL345_INACTIVITY_AC);
+	if (inact_ac_en < 0)
+		return inact_ac_en;
+
+	inact_en = inact_en || inact_ac_en;
+	act_en = act_en || act_ac_en;
+
 	return regmap_assign_bits(st->regmap, ADXL345_REG_POWER_CTL,
 				  ADXL345_POWER_CTL_INACT_MSK,
 				  en && act_en && inact_en);
@@ -426,7 +579,7 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 			return 0;
 
 		/* When turning on inactivity, check if inact time is valid */
-		if (type == ADXL345_INACTIVITY) {
+		if (type == ADXL345_INACTIVITY || type == ADXL345_INACTIVITY_AC) {
 			ret = regmap_read(st->regmap,
 					  ADXL345_REG_TIME_INACT,
 					  &period);
@@ -436,6 +589,16 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 			if (!period)
 				return 0;
 		}
+	} else {
+		/*
+		 * When turning off an activity, ensure that the correct
+		 * coupling event is specified. This step helps prevent misuse -
+		 * for example, if an AC-coupled activity is active and the
+		 * current call attempts to turn off a DC-coupled activity, this
+		 * inconsistency should be detected here.
+		 */
+		if (adxl345_is_act_inact_ac(st, type) <= 0)
+			return 0;
 	}
 
 	/* Start modifying configuration registers */
@@ -446,10 +609,12 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 	/* Enable axis according to the command */
 	switch (type) {
 	case ADXL345_ACTIVITY:
+	case ADXL345_ACTIVITY_AC:
 		axis_ctrl = ADXL345_ACT_X_EN | ADXL345_ACT_Y_EN |
 				ADXL345_ACT_Z_EN;
 		break;
 	case ADXL345_INACTIVITY:
+	case ADXL345_INACTIVITY_AC:
 		axis_ctrl = ADXL345_INACT_X_EN | ADXL345_INACT_Y_EN |
 				ADXL345_INACT_Z_EN;
 		break;
@@ -462,6 +627,11 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 	if (ret)
 		return ret;
 
+	/* Update AC/DC-coupling according to the command */
+	ret = adxl345_set_act_inact_ac(st, type, cmd_en);
+	if (ret)
+		return ret;
+
 	/* Enable the interrupt line, according to the command */
 	ret = regmap_assign_bits(st->regmap, ADXL345_REG_INT_ENABLE,
 				 adxl345_act_int_reg[type], cmd_en);
@@ -955,6 +1125,10 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
 		return adxl345_read_mag_config(st, dir,
 					       ADXL345_ACTIVITY,
 					       ADXL345_INACTIVITY);
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		return adxl345_read_mag_config(st, dir,
+					       ADXL345_ACTIVITY_AC,
+					       ADXL345_INACTIVITY_AC);
 	case IIO_EV_TYPE_GESTURE:
 		switch (dir) {
 		case IIO_EV_DIR_SINGLETAP:
@@ -991,6 +1165,11 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 						ADXL345_ACTIVITY,
 						ADXL345_INACTIVITY,
 						state);
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		return adxl345_write_mag_config(st, dir,
+						ADXL345_ACTIVITY_AC,
+						ADXL345_INACTIVITY_AC,
+						state);
 	case IIO_EV_TYPE_GESTURE:
 		switch (dir) {
 		case IIO_EV_DIR_SINGLETAP:
@@ -1100,6 +1279,11 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 					      ADXL345_ACTIVITY,
 					      ADXL345_INACTIVITY,
 					      val, val2);
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		return adxl345_read_mag_value(st, dir, info,
+					      ADXL345_ACTIVITY_AC,
+					      ADXL345_INACTIVITY_AC,
+					      val, val2);
 	case IIO_EV_TYPE_GESTURE:
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
@@ -1158,6 +1342,14 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 		break;
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		ret = adxl345_write_mag_value(st, dir, info,
+					      ADXL345_ACTIVITY_AC,
+					      ADXL345_INACTIVITY_AC,
+					      val, val2);
+		if (ret)
+			return ret;
+		break;
 	case IIO_EV_TYPE_GESTURE:
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
@@ -1402,6 +1594,7 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
 {
 	s64 ts = iio_get_time_ns(indio_dev);
 	struct adxl345_state *st = iio_priv(indio_dev);
+	unsigned int regval;
 	int samples;
 	int ret = -ENOENT;
 
@@ -1426,22 +1619,52 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
 	}
 
 	if (FIELD_GET(ADXL345_INT_ACTIVITY, int_stat)) {
-		ret = iio_push_event(indio_dev,
-				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, act_dir,
-							IIO_EV_TYPE_MAG,
-							IIO_EV_DIR_RISING),
-				     ts);
+		ret = regmap_read(st->regmap, ADXL345_REG_ACT_INACT_CTRL, &regval);
+		if (ret)
+			return ret;
+
+		if (FIELD_GET(ADXL345_REG_ACT_ACDC_MSK, regval)) {
+			/* AC coupled */
+			ret = iio_push_event(indio_dev,
+					     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, act_dir,
+								IIO_EV_TYPE_MAG_ADAPTIVE,
+								IIO_EV_DIR_RISING),
+					     ts);
+
+		} else {
+			/* DC coupled, relying on THRESH */
+			ret = iio_push_event(indio_dev,
+					     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, act_dir,
+								IIO_EV_TYPE_MAG,
+								IIO_EV_DIR_RISING),
+					     ts);
+		}
 		if (ret)
 			return ret;
 	}
 
 	if (FIELD_GET(ADXL345_INT_INACTIVITY, int_stat)) {
-		ret = iio_push_event(indio_dev,
-				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
-							IIO_MOD_X_AND_Y_AND_Z,
-							IIO_EV_TYPE_MAG,
-							IIO_EV_DIR_FALLING),
-				     ts);
+		ret = regmap_read(st->regmap, ADXL345_REG_ACT_INACT_CTRL, &regval);
+		if (ret)
+			return ret;
+
+		if (FIELD_GET(ADXL345_REG_INACT_ACDC_MSK, regval)) {
+			/* AC coupled */
+			ret = iio_push_event(indio_dev,
+					     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+								IIO_MOD_X_AND_Y_AND_Z,
+								IIO_EV_TYPE_MAG_ADAPTIVE,
+								IIO_EV_DIR_FALLING),
+					     ts);
+		} else {
+			/* DC coupled, relying on THRESH */
+			ret = iio_push_event(indio_dev,
+					     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+								IIO_MOD_X_AND_Y_AND_Z,
+								IIO_EV_TYPE_MAG,
+								IIO_EV_DIR_FALLING),
+					     ts);
+		}
 		if (ret)
 			return ret;
 	}
-- 
2.39.5


