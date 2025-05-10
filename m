Return-Path: <linux-iio+bounces-19415-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AE7AB25A7
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 00:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0320A9E1452
	for <lists+linux-iio@lfdr.de>; Sat, 10 May 2025 22:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B942222B9;
	Sat, 10 May 2025 22:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cC1EVwbC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08151220F24;
	Sat, 10 May 2025 22:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746917089; cv=none; b=tWHjAgdljaBW8dnkhxiT0MiGY0xC8ghh0MJIo1cpAXZMJXO3YFvIMmHxQZ1d+H9ySQ36ozPxTPCb/n8QXGHjEvaXgvXXzfPRRTCThw+t1FBPJYuxapAzJMeqf7rYEcZZtMROOKtrS3rF7FE+eswxUjgYQ49tHAxi3cLX24lgo5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746917089; c=relaxed/simple;
	bh=804Ek70/ZGmvi349/t64PO/HGS2Wt9z08xXqQ/rSBD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IYWYIjhnfh0vBceIr/Zbq5jJke6s98D+yXmS7SKoXZGBVJQd6h6VCd1LCQ4Giodfr4hSUUUMawW0qiINddFA3u846YJTYQIsc2P2NCCYU+MozbzSkbgTeGNs3L8uJd6UdJn3LkY//nBvpBi+0qMiQx4bEl6QNF78r0mmVZPz4tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cC1EVwbC; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a0b77ea855so470544f8f.3;
        Sat, 10 May 2025 15:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746917085; x=1747521885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lABvRLlLyNPJg5J8U59g526kzNEubv4RkuPVEwpVoN8=;
        b=cC1EVwbC/vJRpiInm1QpP3G/dHBhKWG4D0syIbLUXoMzwM33K9WBIymSR35VYCZKtN
         5oIGadwU4tzClPn0CAXo5vzkLEP3tF4NDUfgKPxwXfrNPb5RoMARBFx4aCuxAYhr18oW
         7qHG1+6o9K3CT6NN3uYUkV0hguFXeGMEXQ+94lvuJ6EwuAnMBwAC/8VM60/woYzy4zob
         m1z/hPREn5uqyEPlbSn4SUWXGWG+iPXEFsRGbmhBtE4PvKhcF1OU030eGIVxtm0JiJh0
         AhdVBinISrODCSkbBUNeYQD8weuIlxi3slpYrkhyQz13ls+U0elIoNE6WTU8wMWLXqr7
         szLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746917085; x=1747521885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lABvRLlLyNPJg5J8U59g526kzNEubv4RkuPVEwpVoN8=;
        b=KGn3ffEkgWcqjTxpS0wjxsIrLQsyj1rTZQ3mmJnhjjrnyc6IlpGCTs3wpQDq745xEZ
         Mn1NOkJBAKAvlWcQj1y/cl8V710V1X4ClbBCwksWKm0FDqWUUACt5ITUVIx6IT241r5C
         uhYDOjsZnLv+6xHZSbprIIFnFquXtimqFpQXSHD1r+iPFUAk5sfCp978LXmdQSLmSyvx
         lqFmhUhwr0XIzwesfWDOcYv+rx7vTo5xVPbUjO07qAIpG8Kr/p3iLIw/2Hz+B0MM+Maw
         jitXJWlpc5Xrb7GarCxjvR+qGs3BziZPGVkKXHQ2WKLK+MvDfY6led+OVKOqfoJRii/D
         POnw==
X-Forwarded-Encrypted: i=1; AJvYcCVOuSDgl0zARktBFxpMjEd6Owk/D5XA8EondM/FNi6yeajRpumqPGsLXzEXsx2quW5oRx3vxFr3vFe9wI0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx808GSOL/3WQWttVpBc6/RMuz3vFtMJg7843jo82CbJS1HAeSu
	EMyfld7WLLl4TTiq7H4ipvRqq/Tnd1QrTa3OmAbMPMeWm3GFRAGw
X-Gm-Gg: ASbGncsNeYryHrqrzn8sBR1klU3kexGFQWLNS1FoQXvlgFierob2RtUeAi0osEeBNLZ
	c4mJKlSpa9bAomdZYYpQFFo0YhbKSyIr9J5iycr+0s6vvEmFDl0aQjD+sAar3t1RFenm43P5ojE
	L/SSf0lv+Cq6fNT1blz7G2a3i0Cp7ZURHb1LzmF43KUIv70l0J/vxq9GsLiExCtEblC/MGO5jYp
	AkLPCzvAK2KX58dur6x66j+mZPGt85kYKMe59D6Rc1PAE9NuoxraSy1kWmbWbem/3M7EHCCmSiu
	4RFewxOoUCV4T+AGQbbg3F4uazK/eQDVWdaL6gCyMe0bttNQIVbWAqDLe/3P+63AjqOxZ3y654d
	rnNir3ogyxPCAzPVOU1hxoQ==
X-Google-Smtp-Source: AGHT+IE5WLd8Dn3t4A7/BKyLeGoMptgfZMxj/wKFGUWtLm7RwZIIkM9zJxSm1XAF/zMcmtNuIeBtzQ==
X-Received: by 2002:a5d:59a8:0:b0:3a0:9dd1:bb59 with SMTP id ffacd0b85a97d-3a1f64a1f8dmr2425868f8f.15.1746917085205;
        Sat, 10 May 2025 15:44:45 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2f65sm7701015f8f.55.2025.05.10.15.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 15:44:44 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v8 5/7] iio: accel: adxl345: add coupling detection for activity/inactivity
Date: Sat, 10 May 2025 22:44:03 +0000
Message-Id: <20250510224405.17910-6-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250510224405.17910-1-l.rubusch@gmail.com>
References: <20250510224405.17910-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add coupling activity/inactivity detection by setting the AC/DC bit. This
is an additional configuration to the activity and inactivity magnitude
events, respectively. DC-coupled event generation takes the configured
threshold values directly, where AC-coupled event generation references to
the acceleration value at the start of the activity detection. New samples
of acceleration are then compared to this reference.

Both types are implemented using MAG for DC-coupled activity/inactivity,
but MAG_REFERENCED for AC-coupled activity inactivity events. Threshold and
periods are offerend by different sysfs handles, but share the same
registers at the sensor. Thus activity and inactivity, respectively, cannot
be configured with AC- and DC-coupling at the same time, e.g. configuring
DC-coupled and AC-coupled activity will result in AC-coupled activity, or
generally the most recent one being configured.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 362 +++++++++++++++++++++++++++++--
 1 file changed, 346 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index ba68f304035a..c6f75d6b0db9 100644
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
 
+#define ADXL345_ACT_INACT_DC		0
+#define ADXL345_ACT_INACT_AC		1
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
@@ -156,6 +174,14 @@ static const int adxl345_fullres_range_tbl[][2] = {
 	[ADXL345_16G_RANGE] = { 0, 38312 },
 };
 
+/* scaling */
+static const int adxl345_range_factor_tbl[] = {
+	[ADXL345_2G_RANGE]  = 1,
+	[ADXL345_4G_RANGE]  = 2,
+	[ADXL345_8G_RANGE]  = 4,
+	[ADXL345_16G_RANGE] = 8,
+};
+
 struct adxl345_state {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
@@ -179,6 +205,13 @@ static struct iio_event_spec adxl345_events[] = {
 		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
 		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
 	},
+	{
+		/* activity, ac bit set */
+		.type = IIO_EV_TYPE_MAG_REFERENCED,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
+	},
 	{
 		/* single tap */
 		.type = IIO_EV_TYPE_GESTURE,
@@ -232,6 +265,14 @@ static const struct iio_event_spec adxl345_fake_chan_events[] = {
 		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
 			BIT(IIO_EV_INFO_PERIOD),
 	},
+	{
+		/* inactivity, AC bit set */
+		.type = IIO_EV_TYPE_MAG_REFERENCED,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_PERIOD),
+	},
 };
 
 static const struct iio_chan_spec adxl345_channels[] = {
@@ -295,19 +336,119 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
 
 /* act/inact */
 
+/**
+ * adxl345_is_act_inact_ac() - Verify if AC or DC coupling is currently enabled.
+ *
+ * @st: The device data.
+ * @type: The activity or inactivity type.
+ * @en: Carries the result if this activity type is enabled.
+ *
+ * Given a type of activity / inactivity combined with either AC coupling set or
+ * default to DC, this function verifies if the combination is currently
+ * configured, hence enabled or not.
+ *
+ * Return: 0 if successful, else error value.
+ */
+static int adxl345_is_act_inact_ac(struct adxl345_state *st,
+				   enum adxl345_activity_type type, bool *en)
+{
+	unsigned int regval;
+	bool ac;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADXL345_REG_ACT_INACT_CTRL, &regval);
+	if (ret)
+		return ret;
+
+	if (type == ADXL345_ACTIVITY || type == ADXL345_ACTIVITY_AC)
+		ac = FIELD_GET(ADXL345_REG_ACT_ACDC_MSK, regval);
+	else
+		ac = FIELD_GET(ADXL345_REG_INACT_ACDC_MSK, regval);
+
+	if (type == ADXL345_ACTIVITY || type == ADXL345_INACTIVITY)
+		*en = (ac == ADXL345_ACT_INACT_DC);
+	else
+		*en = (ac == ADXL345_ACT_INACT_AC);
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
+	unsigned int act_inact_ac;
+
+	if (type == ADXL345_ACTIVITY_AC || type == ADXL345_INACTIVITY_AC)
+		act_inact_ac = 0xff;
+	else
+		act_inact_ac = 0x00;
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
+	return regmap_update_bits(st->regmap, ADXL345_REG_ACT_INACT_CTRL,
+				 adxl345_act_acdc_msk[type], act_inact_ac);
+}
+
 static int adxl345_is_act_inact_en(struct adxl345_state *st,
 				   enum iio_modifier axis,
 				   enum adxl345_activity_type type, bool *en)
 {
 	unsigned int regval;
 	u32 axis_ctrl;
+	bool coupling_en;
 	int ret;
 
 	ret = regmap_read(st->regmap, ADXL345_REG_ACT_INACT_CTRL, &axis_ctrl);
 	if (ret)
 		return ret;
 
-	if (type == ADXL345_ACTIVITY) {
+	if (type == ADXL345_ACTIVITY || type == ADXL345_ACTIVITY_AC) {
 		switch (axis) {
 		case IIO_MOD_X:
 			*en = FIELD_GET(ADXL345_ACT_X_EN, axis_ctrl);
@@ -345,6 +486,12 @@ static int adxl345_is_act_inact_en(struct adxl345_state *st,
 			return ret;
 
 		*en = adxl345_act_int_reg[type] & regval;
+
+		ret = adxl345_is_act_inact_ac(st, type, &coupling_en);
+		if (ret)
+			return ret;
+
+		*en = adxl345_act_int_reg[type] && coupling_en;
 	}
 
 	return 0;
@@ -361,7 +508,7 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 	u32 axis_ctrl = 0;
 	int ret;
 
-	if (type == ADXL345_ACTIVITY) {
+	if (type == ADXL345_ACTIVITY || type == ADXL345_ACTIVITY_AC) {
 		switch (axis) {
 		case IIO_MOD_X:
 			axis_ctrl = ADXL345_ACT_X_EN;
@@ -395,7 +542,7 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 
 	en = false;
 
-	if (type == ADXL345_ACTIVITY) {
+	if (type == ADXL345_ACTIVITY || type == ADXL345_ACTIVITY_AC) {
 		en = FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, axis_ctrl) &&
 			threshold;
 	} else {
@@ -413,6 +560,10 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 	if (ret)
 		return ret;
 
+	ret = adxl345_set_act_inact_ac(st, type);
+	if (ret)
+		return ret;
+
 	return regmap_update_bits(st->regmap, ADXL345_REG_POWER_CTL,
 				  ADXL345_POWER_CTL_INACT_MSK,
 				  en ? (ADXL345_POWER_CTL_AUTO_SLEEP | ADXL345_POWER_CTL_LINK)
@@ -692,9 +843,16 @@ static int adxl345_find_odr(struct adxl345_state *st, int val,
 
 static int adxl345_set_odr(struct adxl345_state *st, enum adxl345_odr odr)
 {
-	return regmap_update_bits(st->regmap, ADXL345_REG_BW_RATE,
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, ADXL345_REG_BW_RATE,
 				 ADXL345_BW_RATE_MSK,
 				 FIELD_PREP(ADXL345_BW_RATE_MSK, odr));
+	if (ret)
+		return ret;
+
+	/* update inactivity time by ODR */
+	return adxl345_set_inact_time_s(st, 0);
 }
 
 static int adxl345_find_range(struct adxl345_state *st, int val, int val2,
@@ -715,9 +873,51 @@ static int adxl345_find_range(struct adxl345_state *st, int val, int val2,
 
 static int adxl345_set_range(struct adxl345_state *st, enum adxl345_range range)
 {
-	return regmap_update_bits(st->regmap, ADXL345_REG_DATA_FORMAT,
+	unsigned int act_threshold, inact_threshold;
+	unsigned int range_old;
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADXL345_REG_DATA_FORMAT, &regval);
+	if (ret)
+		return ret;
+	range_old = FIELD_GET(ADXL345_DATA_FORMAT_RANGE, regval);
+
+	ret = regmap_read(st->regmap,
+			  adxl345_act_thresh_reg[ADXL345_ACTIVITY],
+			  &act_threshold);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->regmap,
+			  adxl345_act_thresh_reg[ADXL345_INACTIVITY],
+			  &inact_threshold);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->regmap, ADXL345_REG_DATA_FORMAT,
 				 ADXL345_DATA_FORMAT_RANGE,
 				 FIELD_PREP(ADXL345_DATA_FORMAT_RANGE, range));
+	if (ret)
+		return ret;
+
+	act_threshold = act_threshold
+		* adxl345_range_factor_tbl[range_old]
+		/ adxl345_range_factor_tbl[range];
+	act_threshold = min(255, max(1, inact_threshold));
+
+	inact_threshold = inact_threshold
+		* adxl345_range_factor_tbl[range_old]
+		/ adxl345_range_factor_tbl[range];
+	inact_threshold = min(255, max(1, inact_threshold));
+
+	ret = regmap_write(st->regmap, adxl345_act_thresh_reg[ADXL345_ACTIVITY],
+			   act_threshold);
+	if (ret)
+		return ret;
+
+	return regmap_write(st->regmap, adxl345_act_thresh_reg[ADXL345_INACTIVITY],
+			   inact_threshold);
 }
 
 static int adxl345_read_avail(struct iio_dev *indio_dev,
@@ -879,6 +1079,25 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_EV_TYPE_MAG_REFERENCED:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			ret = adxl345_is_act_inact_en(st, chan->channel2,
+						      ADXL345_ACTIVITY_AC,
+						      &int_en);
+			if (ret)
+				return ret;
+			return int_en;
+		case IIO_EV_DIR_FALLING:
+			ret = adxl345_is_act_inact_en(st, chan->channel2,
+						      ADXL345_INACTIVITY_AC,
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
@@ -923,6 +1142,19 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_EV_TYPE_MAG_REFERENCED:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return adxl345_set_act_inact_en(st, chan->channel2,
+							ADXL345_ACTIVITY_AC,
+							state);
+		case IIO_EV_DIR_FALLING:
+			return adxl345_set_act_inact_en(st, chan->channel2,
+							ADXL345_INACTIVITY_AC,
+							state);
+		default:
+			return -EINVAL;
+		}
 	case IIO_EV_TYPE_GESTURE:
 		switch (dir) {
 		case IIO_EV_DIR_SINGLETAP:
@@ -987,6 +1219,42 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_EV_TYPE_MAG_REFERENCED:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			switch (dir) {
+			case IIO_EV_DIR_RISING:
+				ret = regmap_read(st->regmap,
+						  adxl345_act_thresh_reg[ADXL345_ACTIVITY_AC],
+						  &act_threshold);
+				if (ret)
+					return ret;
+
+				*val = act_threshold;
+				return IIO_VAL_INT;
+			case IIO_EV_DIR_FALLING:
+				ret = regmap_read(st->regmap,
+						  adxl345_act_thresh_reg[ADXL345_INACTIVITY_AC],
+						  &inact_threshold);
+				if (ret)
+					return ret;
+
+				*val = inact_threshold;
+				return IIO_VAL_INT;
+			default:
+				return -EINVAL;
+			}
+		case IIO_EV_INFO_PERIOD:
+			ret = regmap_read(st->regmap,
+					  ADXL345_REG_TIME_INACT,
+					  &inact_time_s);
+			if (ret)
+				return ret;
+			*val = inact_time_s;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
 	case IIO_EV_TYPE_GESTURE:
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
@@ -1068,6 +1336,37 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 		break;
+	case IIO_EV_TYPE_MAG_REFERENCED:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			switch (dir) {
+			case IIO_EV_DIR_RISING:
+				ret = regmap_write(st->regmap,
+						   adxl345_act_thresh_reg[ADXL345_ACTIVITY_AC],
+						   val);
+				if (ret)
+					return ret;
+				break;
+			case IIO_EV_DIR_FALLING:
+				ret = regmap_write(st->regmap,
+						   adxl345_act_thresh_reg[ADXL345_INACTIVITY_AC],
+						   val);
+				if (ret)
+					return ret;
+				break;
+			default:
+				return -EINVAL;
+			}
+			break;
+		case IIO_EV_INFO_PERIOD:
+			ret = adxl345_set_inact_time_s(st, val);
+			if (ret)
+				return ret;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
 	case IIO_EV_TYPE_GESTURE:
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
@@ -1315,6 +1614,7 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
 {
 	s64 ts = iio_get_time_ns(indio_dev);
 	struct adxl345_state *st = iio_priv(indio_dev);
+	unsigned int regval;
 	int samples;
 	int ret = -ENOENT;
 
@@ -1339,22 +1639,52 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
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
+								IIO_EV_TYPE_MAG_REFERENCED,
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
+								IIO_EV_TYPE_MAG_REFERENCED,
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


