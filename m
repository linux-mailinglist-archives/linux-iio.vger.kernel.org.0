Return-Path: <linux-iio+bounces-21266-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DDAAF65DC
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 01:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0FD4A17F1
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 23:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A492F6F94;
	Wed,  2 Jul 2025 23:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T27tjw3o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DFE2F5C5D;
	Wed,  2 Jul 2025 23:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497428; cv=none; b=OgPYTfJUbdoU88zMa9tY3LDn67t6IdXsyhQXNJ9XrqW7KnHgRXYHo1WY3FWwprcBepty0QUITrlbaNxDWyt6T2viAP4Nzg7m5RDXencmBhDKq1pkkxm3RaMKOGzwnyXVsu6gh2v7RZtJ2uNM4Fk2LSsApyIVeF9GW973lTHbLtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497428; c=relaxed/simple;
	bh=6hj0XDYiO26Kjof19ZOBMPRcHJDYPluG+RqJHR5D4pc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q7vrrM1CQRkT3/eUeYrMimcpndA1Bv/XbBZU8874h+++V2xFJ2ztglD6gHoUEKsDyFpNfE22HgmET/g0rcA6zKc3eny3YX97h3cLnTdzsUEIJnl65B7aqqdWrNJvbPLiJewFVdTLgpuYfhYgUU5FL6IONNhTmNljAFb3hyC1P24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T27tjw3o; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-608964359f9so1357729a12.1;
        Wed, 02 Jul 2025 16:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497424; x=1752102224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MQWe/hTusPFEv9JgIS55L59V7GL7W+4vGQLXf/D9JZE=;
        b=T27tjw3oBsy/62uGIHjfCGu9jwcIUGhF4kRzaOup5kwDLE5JA06pTeYZLf7DoWDyMn
         g6cHAUXnOzaSu2MsAB9usa1PIYnarkeSHS5OU6/25TVkQmZ99fGzQ4yP/aUhWw1Vo22n
         /Gd4yL5f+h4gSvfbALykOdqaGZ0nqRcgBfkoTpICEfIaLYK/7B7JUz78pUv19zt4uwcI
         nUsK4guZl/GujlxVGHx609AEWSinEmRymwN7lgkgc0iZ1z0qIpBOxSNkZsmPm7pl4PBy
         3+mBEsS6Zk3bgtE1ogccaiMs8SQLbTeoP3g7sZTRGJyKXbSFb8cvM1mR3UFzqY0SVhcl
         FdQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497424; x=1752102224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MQWe/hTusPFEv9JgIS55L59V7GL7W+4vGQLXf/D9JZE=;
        b=J5gECE+cSs3pRu/80kCb0/h33vtorExp+TkXlKvB7d9MvMY3J8blqJoKQQ/UZAqaWX
         jrk3Bs+/EJA2MnIEPhpQAQIByMJOgPGDh8cTg15SR4mTJzNQA9FXuLtIyxigF4gwlyXn
         yfg8IpTSuw2f8w/mrMpgbuulcIF7TUBOv3be7Uwy4LXFIYZpblSUY1q+pnCZZVl3eify
         nmNtyg1EszBouCGAuS1IXHuM6WaDknSAPLQdiEP/s01I/5o3zfv4RqpJAZGI5kg+9Tdu
         cklrPutlszR/xPBcJp1T2Qq/1++50WaF4O2jYksp24Z+HWjLO8IJmm3pff+ZFNhYMzFL
         SxZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWLliguO8S0ScanKJNcIjky22fIK0ayE13NUovKjEpVZTgZOUFogxtxDTB6E1HeFSMBD/zdXM63vw4=@vger.kernel.org, AJvYcCWlpYkB7wMVODxbnAnUPNfL00xijX3wv/iTY1BfSr5r/vLQOeZZa0YlCxr3fR1mVQCKNpQasPL+Wp1Fqx8B@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9j2MUX37GM7d6OfpkFveq9P9zaRYWiRGhFXA2sHZn89mYmJEM
	+iXIvCPIlZsg6CbEwaY5YFnzjf9BQOuVthG9GTK6p2TqWlMnyF4TLNRK
X-Gm-Gg: ASbGncvyX02BGue0RryJ0ag9AxF49U9Fxm+nw43i+Uu2uof3/CCSuOehg5MeXkPR+0R
	IOdTrmY83NTjXKzkhDQbYyDT5yt8PGFJ1qqeSxiq0/4SiLYg1X8syJZkMrjMgE1rtjC34yWfhZG
	iApF8lagiEES8PMlxeXfVF7YjfNL4nXhxZDzLGaoAawHFMaDtZNHOmcsvNsrkYyMaN3Qy7mWuEx
	Xb0tZry9HTV/78z3fb2Nqa72DnAGxsL+08QZfUp30PKyn7eDR91LNM5UKlQO+5jQg5pgJfJw3E6
	VlhSXjTVn4ohnxEt9om7Y3d8YXJ/B9naSHqn42kQic+d1fkLb92pThKABQlgVGrzipXKW3K3zLq
	LaRA8PiYb49oCoMKjr/YL3vdXn8Db2pWn
X-Google-Smtp-Source: AGHT+IHn+Tw+gjvqGwvhn3JcEZ/mUkCoTMHZ/rpwAOWC4IMaZGhWx4JOJrK9k+GHeHahGtfP4jYkXw==
X-Received: by 2002:a05:6402:538f:b0:601:e25d:198a with SMTP id 4fb4d7f45d1cf-60e764f7284mr11367a12.0.1751497424176;
        Wed, 02 Jul 2025 16:03:44 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c8319e706sm10031469a12.47.2025.07.02.16.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:03:43 -0700 (PDT)
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
Subject: [PATCH v11 5/8] iio: accel: adxl345: add coupling detection for activity/inactivity
Date: Wed,  2 Jul 2025 23:03:12 +0000
Message-Id: <20250702230315.19297-6-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl345_core.c | 252 +++++++++++++++++++++++++++++--
 1 file changed, 238 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 90fef42ac021..7038a4effd08 100644
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
@@ -54,6 +56,9 @@
 #define ADXL345_ACT_X_EN		BIT(6)
 #define ADXL345_ACT_XYZ_EN		(ADXL345_ACT_Z_EN | ADXL345_ACT_Y_EN | ADXL345_ACT_X_EN)
 
+#define ADXL345_COUPLING_DC		0
+#define ADXL345_COUPLING_AC		1
+
 /* single/double tap */
 enum adxl345_tap_type {
 	ADXL345_SINGLE_TAP,
@@ -81,16 +86,29 @@ static const unsigned int adxl345_tap_time_reg[] = {
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
@@ -188,6 +206,13 @@ static const struct iio_event_spec adxl345_events[] = {
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
@@ -241,6 +266,14 @@ static const struct iio_event_spec adxl345_fake_chan_events[] = {
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
@@ -348,12 +381,114 @@ static int adxl345_set_inact_time(struct adxl345_state *st, u32 val_s)
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
@@ -363,11 +498,13 @@ static int adxl345_is_act_inact_en(struct adxl345_state *st,
 	/* Check if axis for activity are enabled */
 	switch (type) {
 	case ADXL345_ACTIVITY:
+	case ADXL345_ACTIVITY_AC:
 		en = FIELD_GET(ADXL345_ACT_XYZ_EN, axis_ctrl);
 		if (!en)
 			return false;
 		break;
 	case ADXL345_INACTIVITY:
+	case ADXL345_INACTIVITY_AC:
 		en = FIELD_GET(ADXL345_INACT_XYZ_EN, axis_ctrl);
 		if (!en)
 			return false;
@@ -381,23 +518,40 @@ static int adxl345_is_act_inact_en(struct adxl345_state *st,
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
+	int act_ac_en, inact_ac_en;
 	int act_en, inact_en;
 
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
@@ -424,7 +578,7 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 			return 0;
 
 		/* When turning on inactivity, check if inact time is valid */
-		if (type == ADXL345_INACTIVITY) {
+		if (type == ADXL345_INACTIVITY || type == ADXL345_INACTIVITY_AC) {
 			ret = regmap_read(st->regmap,
 					  ADXL345_REG_TIME_INACT,
 					  &period);
@@ -434,6 +588,16 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
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
@@ -444,9 +608,11 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 	/* Enable axis according to the command */
 	switch (type) {
 	case ADXL345_ACTIVITY:
+	case ADXL345_ACTIVITY_AC:
 		axis_ctrl = ADXL345_ACT_XYZ_EN;
 		break;
 	case ADXL345_INACTIVITY:
+	case ADXL345_INACTIVITY_AC:
 		axis_ctrl = ADXL345_INACT_XYZ_EN;
 		break;
 	default:
@@ -458,6 +624,11 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
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
@@ -951,6 +1122,10 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
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
@@ -987,6 +1162,11 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
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
@@ -1096,6 +1276,11 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
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
@@ -1154,6 +1339,14 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
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
@@ -1398,6 +1591,7 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
 {
 	s64 ts = iio_get_time_ns(indio_dev);
 	struct adxl345_state *st = iio_priv(indio_dev);
+	unsigned int regval;
 	int samples;
 	int ret = -ENOENT;
 
@@ -1422,22 +1616,52 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
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


