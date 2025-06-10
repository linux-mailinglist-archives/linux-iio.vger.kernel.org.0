Return-Path: <linux-iio+bounces-20395-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C95C7AD4573
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 00:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0169217D25D
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 22:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B00728C03B;
	Tue, 10 Jun 2025 21:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnQtAmz3"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A431528A722;
	Tue, 10 Jun 2025 21:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749592798; cv=none; b=UxPCiNXD1WOgcP8AYBl3cZGwSGwMdiflmPnalAqPF6kN09zGyDY+niEFXkgO7hPAjMRFTKZB6ArmQCHEYYA5wE8EdWx5ownlyUO7a3ju/w0EL7+7inaQuZrzWxFg5h+Xgq+AH3GOOsarQUtzqvdE36wSvlyZcFhmDmpp9g/lSGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749592798; c=relaxed/simple;
	bh=OaBykbMp2Rq+XQ6YOQqafgwYQWK8i3391T2Jes/VIEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fu+LaHTRZPK/4UipJSOSrlz1ziGl/KEIzDJLIuiCIl6TM7PVwRuV34hfZQWzFKIh6bkd1aRhLHwMgmNLB2SkG3BJoAOqnQ32smU/QVdH8fpoO/GD/DBfZQZmgtXCcVanOKLZXPS9ePXu4I6wRvQfMrwCi87Zouc4T+wnAZalpCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnQtAmz3; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a4e575db1aso777686f8f.2;
        Tue, 10 Jun 2025 14:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749592794; x=1750197594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rtr6bY8fpgZFbG5TN0BX0c8IK6uZXcYU2zsMpVhTsgM=;
        b=UnQtAmz335PrRqOsl/Bxbl5hXxMa4d3q/xFw1m/tOqwvqotmqITB4t9eSjllEkhhDr
         K2FvvONJlKHKZZAOmOfd+cBAUEjUp/r1xJn4EPUyZukoMD8vA2Dq8KbY5DbWGzlC6nMh
         kFhpnzEyqsgDSPgDpS9ocy/MxqanPqbfGkLHoWXFh2CMvbcfr8D8aGHl+YiPaK54GPTg
         ZbHcjQvboQfxWWvtntSzQ1LjncyPtTFRIxdHnytfukgItetPJOxO8+w/N2lqyU2sj3jT
         FEe8hTeJBnn99LydEjsmkITBNnW3oBjWfLgcOMa/YxbP/OnCvmaB7xcorVOrAg+dcz1J
         yfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749592794; x=1750197594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rtr6bY8fpgZFbG5TN0BX0c8IK6uZXcYU2zsMpVhTsgM=;
        b=YNvw8V/+p/TJrQagcSiChlZlErGu45ip9JxGx18D/YWMP76PmN0678M2pcRyK4lWxZ
         DBylH6wsMzTbPyW4GxUbhppuv8IcEqQdHTsWz25bWLfSCBPGHPIHNJng9HyJB+7fkA7i
         uuzvvWB4yB0vh3DOS1u+VMYPaEFJLWmGSCzaHz1O0OiMwJbmd12NFJ2qxYYC0Ob1rFGS
         Mka1velWK07zN43aOke3UViM6PlWPsQdKgrdmPN1bjEXQY42j0DpocJB3pGQjbfQfuVU
         B1bLxW7sQMWPQlf435upr19eFHycRDLQvPEHzN9hr/BjTk1Jqe3bwqd4/5eGv3+3y6j0
         kK0A==
X-Forwarded-Encrypted: i=1; AJvYcCUwdNBcc5EMMgMJZdTYJIvqDR5VPfbrJ8Ow90SsBXEVvdp0TpxdVmkt2PWuorTnzi5GNtpPUhJEKnMPXaP7@vger.kernel.org, AJvYcCWFDbl7lt2EaLacu77Ff00Lr5//hhIxtVZBbYNnZA87ZxldGD1pxl2uSO08kAtQ3OC+sIBLAQrW2RM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfN6MirOzkma8NLETUzTWG4UYlnxwUsD02sJP2HGHqqHU48q5G
	v3pqMDmFIX5oxippNmuaFvRFSWVLJKa5twBCHANL/s+gSCWbgEjf0GZh
X-Gm-Gg: ASbGncsnKsUZUXwf5Jsi2OBkEpzh4OwQG0DfYf2eLhD7MnMb9N1Gk8J3Qn2YBRnNp2J
	s57eYHMWvhHC2rFb5cP3mNMoMk1m0RbKtfdv8cphvwZRGnZGr+/278IZr9aumb6fHUa1RhUdh0L
	VIVXVj9MovxAsgSucDr4gime4NFpymNApma6K4g+DUYkme8YnMbN8FI660VVzHowbDVAnjd9ghr
	Tsrqd3C7T8pDp6fMD1strYBGUnXU/VhadEsir+4pKFlygHONOvrLDNdCa9lh/1q3B2V4CJR2QuR
	el4zZCEOddrJZcTsCnUKBwpiih4JnDXDD9iD5s3smoRWjUnEkVOIcYNj3thm+dfrg2DXz7SmmZY
	7dyHrVL7xqeHbpnnmWKvE7rr2FQwEWMr7
X-Google-Smtp-Source: AGHT+IHysEb5U2dHkrbETPEX5l+2SWnkrEwe1BN2KMYt5LB3eyR+00UJwt5HnP/PHFMoKMfH7HrgRA==
X-Received: by 2002:a5d:64ca:0:b0:3a5:2d42:aa1e with SMTP id ffacd0b85a97d-3a558a1af38mr213843f8f.15.1749592793633;
        Tue, 10 Jun 2025 14:59:53 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53244f04dsm13312647f8f.73.2025.06.10.14.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 14:59:53 -0700 (PDT)
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
Subject: [PATCH v9 09/11] iio: accel: adxl345: add coupling detection for activity/inactivity
Date: Tue, 10 Jun 2025 21:59:31 +0000
Message-Id: <20250610215933.84795-10-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250610215933.84795-1-l.rubusch@gmail.com>
References: <20250610215933.84795-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add adaptive coupling activity/inactivity detection by setting the AC/DC
bit. This is an additional configuration to the activity and inactivity
magnitude events, respectively. DC-coupled event generation takes the
configured threshold values directly, where AC-coupled event generation
references to the acceleration value at the start of the activity
detection. New samples of acceleration are then compared to this
reference.

Both types are implemented using MAG for DC-coupled activity/inactivity,
but MAG_ADAPTIVE for AC-coupled activity inactivity events. Threshold and
periods can be configured by different sysfs handles, but share the same
registers at the sensor. Therefore activity and inactivity,
respectively, cannot be configured with AC- and DC-coupling at the same
time, e.g. configuring DC-coupled and AC-coupled activity will result in
AC-coupled activity, or generally the most recent one being configured.

This patch implicitly regroups adxl345_read/write_event_value() and
adxl345_read/write_event_config() where now redundant parts, due to
similar event handling for AC-coupling, are moved to a separate function
adxl345_read/write_mag_config() and adxl345_read/write_mag_value(),
respectively.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 498 ++++++++++++++++++++++++-------
 1 file changed, 382 insertions(+), 116 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 1670315ebd63..6a4af559ad9e 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -37,7 +37,9 @@
 #define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3)
 #define ADXL345_REG_TAP_SUPPRESS	BIT(3)
 #define ADXL345_REG_ACT_AXIS_MSK	GENMASK(6, 4)
+#define ADXL345_REG_ACT_ACDC_MSK	BIT(7)
 #define ADXL345_REG_INACT_AXIS_MSK	GENMASK(2, 0)
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
@@ -345,12 +378,108 @@ static int adxl345_set_inact_time(struct adxl345_state *st, u32 val_s)
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
+	if (type == ADXL345_ACTIVITY || type == ADXL345_INACTIVITY)
+		return coupling == ADXL345_COUPLING_DC;
+	else
+		return coupling == ADXL345_COUPLING_AC;
+
+	return 0;
+}
+
+/**
+ * adxl345_set_act_inact_ac() - Configure AC coupling or DC coupling.
+ *
+ * @st: The device data.
+ * @type: Provide a type of activity or inactivity.
+ *
+ * Enables AC coupling or DC coupling depending on the provided type argument.
+ * Note: Activity and inactivity can be either AC coupled or DC coupled not
+ * both at the same time.
+ *
+ * Return: 0 if successful, else error value.
+ */
+static int adxl345_set_act_inact_ac(struct adxl345_state *st,
+				    enum adxl345_activity_type type)
+{
+	unsigned int coupling;
+
+	if (type == ADXL345_ACTIVITY_AC || type == ADXL345_INACTIVITY_AC)
+		coupling = ADXL345_COUPLING_AC;
+	else
+		coupling = ADXL345_COUPLING_DC;
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
+				  adxl345_act_acdc_msk[type], coupling);
+}
+
 static int adxl345_is_act_inact_en(struct adxl345_state *st,
 				   enum adxl345_activity_type type)
 {
 	unsigned int regval;
 	u32 axis_ctrl;
-	bool en;
+	bool coupling_en, int_en, en;
 	int ret;
 
 	ret = regmap_read(st->regmap, ADXL345_REG_ACT_INACT_CTRL, &axis_ctrl);
@@ -359,11 +488,13 @@ static int adxl345_is_act_inact_en(struct adxl345_state *st,
 
 	switch (type) {
 	case ADXL345_ACTIVITY:
+	case ADXL345_ACTIVITY_AC:
 		en = FIELD_GET(ADXL345_ACT_X_EN, axis_ctrl) |
 			FIELD_GET(ADXL345_ACT_Y_EN, axis_ctrl) |
 			FIELD_GET(ADXL345_ACT_Z_EN, axis_ctrl);
 		break;
 	case ADXL345_INACTIVITY:
+	case ADXL345_INACTIVITY_AC:
 		en = FIELD_GET(ADXL345_INACT_X_EN, axis_ctrl) |
 			FIELD_GET(ADXL345_INACT_Y_EN, axis_ctrl) |
 			FIELD_GET(ADXL345_INACT_Z_EN, axis_ctrl);
@@ -379,8 +510,48 @@ static int adxl345_is_act_inact_en(struct adxl345_state *st,
 	ret = regmap_read(st->regmap, ADXL345_REG_INT_ENABLE, &regval);
 	if (ret)
 		return ret;
+	int_en = adxl345_act_int_reg[type] & regval;
+
+	/* Check if coupling is enabled */
+	ret = adxl345_is_act_inact_ac(st, type);
+	if (ret < 0)
+		return ret;
+	coupling_en = ret;
 
-	return adxl345_act_int_reg[type] & regval;
+	return coupling_en && int_en;
+}
+
+static int adxl345_set_act_inact_linkbit(struct adxl345_state *st,
+					 enum adxl345_activity_type type,
+					 bool en)
+{
+	int act_en, act_ac_en, inact_en, inact_ac_en;
+
+	act_en = adxl345_is_act_inact_en(st, ADXL345_ACTIVITY);
+	if (act_en < 0)
+		return act_en;
+
+	act_ac_en = adxl345_is_act_inact_en(st, ADXL345_ACTIVITY_AC);
+	if (act_ac_en < 0)
+		return act_ac_en;
+
+	act_en = act_en || act_ac_en;
+
+	inact_en = adxl345_is_act_inact_en(st, ADXL345_INACTIVITY);
+	if (inact_en < 0)
+		return inact_en;
+
+	inact_ac_en = adxl345_is_act_inact_en(st, ADXL345_INACTIVITY_AC);
+	if (inact_ac_en < 0)
+		return inact_ac_en;
+
+	inact_en = inact_en || inact_ac_en;
+
+	en = en && act_en && inact_en;
+
+	return regmap_assign_bits(st->regmap, ADXL345_REG_POWER_CTL,
+				  (ADXL345_POWER_CTL_AUTO_SLEEP | ADXL345_POWER_CTL_LINK),
+				  en);
 }
 
 static int adxl345_set_act_inact_en(struct adxl345_state *st,
@@ -391,15 +562,24 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 	unsigned int inact_time_s;
 	unsigned int threshold;
 	u32 axis_ctrl;
-	int act_en, inact_en;
 	int ret;
 
+	/*
+	 * In case of turning off, assure turning off a correspondent coupling
+	 * event. In case of not matching coupling, simply return.
+	 */
+	if (!cmd_en) {
+		/* Expected positive true if coupling matches coupling type */
+		if (adxl345_is_act_inact_ac(st, type) <= 0)
+			return 0;
+	}
+
 	/* Start configuring the sensor registers */
 	ret = adxl345_set_measure_en(st, false);
 	if (ret)
 		return ret;
 
-	if (type == ADXL345_ACTIVITY) {
+	if (type == ADXL345_ACTIVITY || type == ADXL345_ACTIVITY_AC) {
 		axis_ctrl = ADXL345_ACT_X_EN | ADXL345_ACT_Y_EN |
 				ADXL345_ACT_Z_EN;
 	} else {
@@ -407,12 +587,16 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 				ADXL345_INACT_Z_EN;
 	}
 
+	ret = regmap_read(st->regmap, adxl345_act_thresh_reg[type], &threshold);
+	if (ret)
+		return ret;
+
 	ret = regmap_assign_bits(st->regmap, ADXL345_REG_ACT_INACT_CTRL,
 				 axis_ctrl, cmd_en);
 	if (ret)
 		return ret;
 
-	ret = regmap_read(st->regmap, adxl345_act_thresh_reg[type], &threshold);
+	ret = adxl345_set_act_inact_ac(st, type);
 	if (ret)
 		return ret;
 
@@ -420,10 +604,12 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 
 	switch (type) {
 	case ADXL345_ACTIVITY:
+	case ADXL345_ACTIVITY_AC:
 		en = FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, axis_ctrl) &&
 			threshold;
 		break;
 	case ADXL345_INACTIVITY:
+	case ADXL345_INACTIVITY_AC:
 		ret = regmap_read(st->regmap, ADXL345_REG_TIME_INACT, &inact_time_s);
 		if (ret)
 			return ret;
@@ -435,25 +621,14 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 		return -EINVAL;
 	}
 
+	/* Enable interrupts accordingly. */
 	ret = regmap_assign_bits(st->regmap, ADXL345_REG_INT_ENABLE,
-				 adxl345_act_int_reg[type], cmd_en);
+				 adxl345_act_int_reg[type], cmd_en && en);
 	if (ret)
 		return ret;
 
 	/* Set sleep and link bit when ACT and INACT are enabled. */
-	act_en = adxl345_is_act_inact_en(st, ADXL345_ACTIVITY);
-	if (act_en < 0)
-		return act_en;
-
-	inact_en = adxl345_is_act_inact_en(st, ADXL345_INACTIVITY);
-	if (inact_en < 0)
-		return inact_en;
-
-	en = en && act_en && inact_en;
-
-	ret = regmap_assign_bits(st->regmap, ADXL345_REG_POWER_CTL,
-				 (ADXL345_POWER_CTL_AUTO_SLEEP | ADXL345_POWER_CTL_LINK),
-				 en);
+	ret = adxl345_set_act_inact_linkbit(st, type, en);
 	if (ret)
 		return ret;
 
@@ -894,6 +1069,40 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 	return adxl345_set_measure_en(st, true);
 }
 
+static int adxl345_read_mag_config(struct adxl345_state *st,
+				   const struct iio_chan_spec *chan,
+				   enum iio_event_direction dir,
+				   enum adxl345_activity_type type_act,
+				   enum adxl345_activity_type type_inact)
+{
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		return adxl345_is_act_inact_en(st, type_act);
+	case IIO_EV_DIR_FALLING:
+		return adxl345_is_act_inact_en(st, type_inact);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl345_write_mag_config(struct adxl345_state *st,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_direction dir,
+				    enum iio_event_type type,
+				    enum adxl345_activity_type type_act,
+				    enum adxl345_activity_type type_inact,
+				    bool state)
+{
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		return adxl345_set_act_inact_en(st, type_act, state);
+	case IIO_EV_DIR_FALLING:
+		return adxl345_set_act_inact_en(st, type_inact, state);
+	default:
+		return -EINVAL;
+	}
+}
+
 static int adxl345_read_event_config(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan,
 				     enum iio_event_type type,
@@ -905,14 +1114,13 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
 
 	switch (type) {
 	case IIO_EV_TYPE_MAG:
-		switch (dir) {
-		case IIO_EV_DIR_RISING:
-			return adxl345_is_act_inact_en(st, ADXL345_ACTIVITY);
-		case IIO_EV_DIR_FALLING:
-			return adxl345_is_act_inact_en(st, ADXL345_INACTIVITY);
-		default:
-			return -EINVAL;
-		}
+		return adxl345_read_mag_config(st, chan, dir,
+					       ADXL345_ACTIVITY,
+					       ADXL345_INACTIVITY);
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		return adxl345_read_mag_config(st, chan, dir,
+					       ADXL345_ACTIVITY_AC,
+					       ADXL345_INACTIVITY_AC);
 	case IIO_EV_TYPE_GESTURE:
 		switch (dir) {
 		case IIO_EV_DIR_SINGLETAP:
@@ -945,27 +1153,100 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 
 	switch (type) {
 	case IIO_EV_TYPE_MAG:
+		return adxl345_write_mag_config(st, chan, dir, type,
+						ADXL345_ACTIVITY,
+						ADXL345_INACTIVITY,
+						state);
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		return adxl345_write_mag_config(st, chan, dir, type,
+						ADXL345_ACTIVITY_AC,
+						ADXL345_INACTIVITY_AC,
+						state);
+	case IIO_EV_TYPE_GESTURE:
+		switch (dir) {
+		case IIO_EV_DIR_SINGLETAP:
+			return adxl345_set_singletap_en(st, chan->channel2, state);
+		case IIO_EV_DIR_DOUBLETAP:
+			return adxl345_set_doubletap_en(st, state);
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl345_read_mag_value(struct adxl345_state *st,
+				  enum adxl345_activity_type type_act,
+				  enum adxl345_activity_type type_inact, /* TODO needed */
+				  enum iio_event_direction dir,
+				  enum iio_event_info info,
+				  int *val, int *val2)
+{
+	unsigned int act_threshold, inact_threshold;
+	int ret;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
 		switch (dir) {
 		case IIO_EV_DIR_RISING:
-			return adxl345_set_act_inact_en(st,
-							ADXL345_ACTIVITY,
-							state);
+			ret = regmap_read(st->regmap,
+					  adxl345_act_thresh_reg[type_act],
+					  &act_threshold);
+			if (ret)
+				return ret;
+			*val = 62500 * act_threshold;
+			*val2 = MICRO;
+			return IIO_VAL_FRACTIONAL;
 		case IIO_EV_DIR_FALLING:
-			return adxl345_set_act_inact_en(st,
-							ADXL345_INACTIVITY,
-							state);
+			ret = regmap_read(st->regmap,
+					  adxl345_act_thresh_reg[type_inact],
+					  &inact_threshold);
+			if (ret)
+				return ret;
+			*val = 62500 * inact_threshold;
+			*val2 = MICRO;
+			return IIO_VAL_FRACTIONAL;
 		default:
 			return -EINVAL;
 		}
-	case IIO_EV_TYPE_GESTURE:
+	case IIO_EV_INFO_PERIOD:
+		ret = regmap_read(st->regmap,
+				  ADXL345_REG_TIME_INACT,
+				  val);
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl345_write_mag_value(struct adxl345_state *st,
+				   enum adxl345_activity_type type_act,
+				   enum adxl345_activity_type type_inact,
+				   enum iio_event_direction dir,
+				   enum iio_event_info info,
+				   int val, int val2)
+{
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		/*
+		 * Scaling factor 62.5mg/LSB, i.e. ~16g corresponds to 0xff
+		 */
+		val = DIV_ROUND_CLOSEST(val * MICRO + val2, 62500);
 		switch (dir) {
-		case IIO_EV_DIR_SINGLETAP:
-			return adxl345_set_singletap_en(st, chan->channel2, state);
-		case IIO_EV_DIR_DOUBLETAP:
-			return adxl345_set_doubletap_en(st, state);
+		case IIO_EV_DIR_RISING:
+			return regmap_write(st->regmap,
+					    adxl345_act_thresh_reg[type_act],
+					    val);
+		case IIO_EV_DIR_FALLING:
+			return regmap_write(st->regmap,
+					    adxl345_act_thresh_reg[type_inact],
+					    val);
 		default:
 			return -EINVAL;
 		}
+	case IIO_EV_INFO_PERIOD:
+		return adxl345_set_inact_time(st, val);
 	default:
 		return -EINVAL;
 	}
@@ -979,48 +1260,18 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 				    int *val, int *val2)
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
-	unsigned int act_threshold, inact_threshold;
-	unsigned int inact_time_s;
 	unsigned int tap_threshold;
 	int ret;
 
 	switch (type) {
 	case IIO_EV_TYPE_MAG:
-		switch (info) {
-		case IIO_EV_INFO_VALUE:
-			switch (dir) {
-			case IIO_EV_DIR_RISING:
-				ret = regmap_read(st->regmap,
-						  adxl345_act_thresh_reg[ADXL345_ACTIVITY],
-						  &act_threshold);
-				if (ret)
-					return ret;
-				*val = 62500 * act_threshold;
-				*val2 = MICRO;
-				return IIO_VAL_FRACTIONAL;
-			case IIO_EV_DIR_FALLING:
-				ret = regmap_read(st->regmap,
-						  adxl345_act_thresh_reg[ADXL345_INACTIVITY],
-						  &inact_threshold);
-				if (ret)
-					return ret;
-				*val = 62500 * inact_threshold;
-				*val2 = MICRO;
-				return IIO_VAL_FRACTIONAL;
-			default:
-				return -EINVAL;
-			}
-		case IIO_EV_INFO_PERIOD:
-			ret = regmap_read(st->regmap,
-					  ADXL345_REG_TIME_INACT,
-					  &inact_time_s);
-			if (ret)
-				return ret;
-			*val = inact_time_s;
-			return IIO_VAL_INT;
-		default:
-			return -EINVAL;
-		}
+		return adxl345_read_mag_value(st, ADXL345_ACTIVITY,
+					      ADXL345_INACTIVITY, dir, info,
+					      val, val2);
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		return adxl345_read_mag_value(st, ADXL345_ACTIVITY_AC,
+					      ADXL345_INACTIVITY_AC, dir, info,
+					      val, val2);
 	case IIO_EV_TYPE_GESTURE:
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
@@ -1070,36 +1321,20 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
 
 	switch (type) {
 	case IIO_EV_TYPE_MAG:
-		switch (info) {
-		case IIO_EV_INFO_VALUE:
-			val = DIV_ROUND_CLOSEST(val * MICRO + val2, 62500);
-			switch (dir) {
-			case IIO_EV_DIR_RISING:
-				ret = regmap_write(st->regmap,
-						   adxl345_act_thresh_reg[ADXL345_ACTIVITY],
-						   val);
-				if (ret)
-					return ret;
-				break;
-			case IIO_EV_DIR_FALLING:
-				ret = regmap_write(st->regmap,
-						   adxl345_act_thresh_reg[ADXL345_INACTIVITY],
-						   val);
-				if (ret)
-					return ret;
-				break;
-			default:
-				return -EINVAL;
-			}
-			break;
-		case IIO_EV_INFO_PERIOD:
-			ret = adxl345_set_inact_time(st, val);
-			if (ret)
-				return ret;
-			break;
-		default:
-			return -EINVAL;
-		}
+		ret = adxl345_write_mag_value(st,
+					      ADXL345_ACTIVITY,
+					      ADXL345_INACTIVITY,
+					      dir, info, val, val2);
+		if (ret)
+			return ret;
+		break;
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		ret = adxl345_write_mag_value(st,
+					      ADXL345_ACTIVITY_AC,
+					      ADXL345_INACTIVITY_AC,
+					      dir, info, val, val2);
+		if (ret)
+			return ret;
 		break;
 	case IIO_EV_TYPE_GESTURE:
 		switch (info) {
@@ -1347,6 +1582,7 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
 {
 	s64 ts = iio_get_time_ns(indio_dev);
 	struct adxl345_state *st = iio_priv(indio_dev);
+	unsigned int regval;
 	int samples;
 	int ret = -ENOENT;
 
@@ -1371,22 +1607,52 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
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


