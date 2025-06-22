Return-Path: <linux-iio+bounces-20854-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E8AAE2FE7
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 14:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A8E017123F
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 12:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC28F1F4285;
	Sun, 22 Jun 2025 12:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLpMlAoA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919C61D5CED;
	Sun, 22 Jun 2025 12:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750595392; cv=none; b=oPkCTyoS/7uUEqOgdvepuoG72oZ5uOMTDCEuHeg9ukpNihUTOHZiekZs6Z35ogkqNeZvUADwqHhbpYg67HaSibcWHxps3eV/Y2VUaygHgvdE5aLUCryfWLekCQXi2CoRkHXkLSLcbwpbZo6/iK72BtRucxx7DS05bBjMqR13aks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750595392; c=relaxed/simple;
	bh=e8bYz3hzwlkzVF4SuQhfquBYwv8w3gtTysCPQfbNAug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mVkO6An2KEQ0ryYkwdsreuX/JPK4DTPjyjFKbj3wd469RAlHLSb1io4qU5z875eX4D/lWaMeSIUqZ5UHc4/CZkjDwHLd2th3HfoBLRaaETXrhwy0xpSzuy839sdVIUAQRagHPxSDzyYFsg0Do5oAO9ysxK5De3TMJYDQg8/TfeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLpMlAoA; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ad89c10dfabso109058866b.0;
        Sun, 22 Jun 2025 05:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750595389; x=1751200189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2n7CkLovKCebGHHD+J7tZWi3ApS+RBBl80tlgN3FL9g=;
        b=JLpMlAoAl9n5cROalAqb53YSKPNO3Qnf3RuAKnaGa+p5lsbAGWzUOzpeCBY+Zg2+kx
         mDExvWzhTrf9d17xYuWP1HrjADqgiWx3UGcK+ZVVmR0RyP15oimxz7wAJ7su3VTHzhcd
         JvOvVbmeumrbDU4aVVkiX4d7GDZiyVbLHPevf1JhQs19Imm2eUWaEO2K1lvW09Rq9z1I
         GLpkYWyK0tMCwANPmNGgD6EAdlNPbJp3EGKu64j2LhDcT1ust1dKG9sC6k8EZINF1Xzq
         cgZc7ociSRLjY/N3UVTr6nop/Cv6Qq6tf3B4b/R0ldXJCd/8bAzyrakc2g2h9aN+2DmS
         28pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750595389; x=1751200189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2n7CkLovKCebGHHD+J7tZWi3ApS+RBBl80tlgN3FL9g=;
        b=V002dO0BeSsj8apSJZ+0AboAAfUkDsaaTJ5EB68EEqX40VLVQEG0+sLNPx/1Ln4a17
         QPztFxzJp8RAUtlb+It8PfqHHVPoCnr5TMFeouq+r/ZcuxR4w4T06OdMmOsSrHju9PJd
         Ce3Z3DXidxIjwKqYcAl/QL4cKYmq0HhhG5+XdTxC/VlSO/8GgmEjcA52QkKLSO9reFIp
         bxdKtZGWl/lqz7Rj9FNzFX4AQ6tVLWSHIFBMhOK01yyhHLbCFHd8iw7jdHcO8LS0mKYg
         EaPMNyrrT0HoAND8MmFqK1q0bfiTmBqr8ciAxSYWVMflOBB87XUtdo+EqBmIuojA+QS/
         la+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVjqSntnPqmYQzWtkHu35foe2T/IyhgSZXq9u4EYVYDfEFFW++WiDewWjlJlmEv96yalAlHtw5b/ykAWCr@vger.kernel.org, AJvYcCXdvh5Tg8J/ztmWRA+6ZGTC3AfHayfnHAKZFqFvJ3B5Ob7F3rlKFSK6SVA7/HWOHzCjYIpPQqF//QQ=@vger.kernel.org, AJvYcCXj9Na+KlqMLCIu2IDlebjPXj2VP+XKHqjLfJ65W5FgNZRFZsr2BKMduBjIk3zmdlmo9EezSgWW3zRw@vger.kernel.org
X-Gm-Message-State: AOJu0YzrOybm/CmQ1iAMFkOgyh5o1pqMGoAhPtDE7nIzhlOeVi5lhwdF
	P5Wjk+9KMDiohN9mEmE90W3HZXYGKr2VlOxaMzisUnsSR78aICYPnR4u
X-Gm-Gg: ASbGncssvLiMq+hCOrSaftgsSQpUfCWyj3b0v9KbwX1+/mULUdYmVi8Yq9wOk8zKdf4
	jwGJg/+lWR0J269I/M6jvWP/pupX4hFxw9TyvpKLN0YkHWWyqmPiYS31W5T29aYKU0BkVhCAsc3
	AnGJp3L0cS9DBN9t1MdW8g6V7S9P/ulB5AemgL5Jq1tqoY2mTD/hePxOSenQRwTIAIdch5/T21b
	KFHn2S3zkGQgwz9UQ6kLgvgR/P6y+JuphTdtA4E4v+NXKpTcozhj+k5Qj44L/reFQNog0v3D/Il
	OouycM5HKZa3TYYhR6ZGK4SnPbwZVXl8srNIXKeOaoK+UGp5YgHi3AcNhL+CYxq/V338fpwiIIP
	TWnUu6PhQhrrr3xhLgsEYzkFBcTugLLDT
X-Google-Smtp-Source: AGHT+IGYb57bUanIKual540V1bySFcrnEr0/kOxW2PYXqno3bBFxFBQ/7wiMKqFxnyQPvnKodvebdQ==
X-Received: by 2002:a17:907:94c3:b0:ade:8a6:b86b with SMTP id a640c23a62f3a-ae057c3b2b3mr261303466b.16.1750595388685;
        Sun, 22 Jun 2025 05:29:48 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053edc0e9sm533917566b.54.2025.06.22.05.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 05:29:48 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	bagasdotme@gmail.com
Cc: l.rubusch@gmail.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 7/8] iio: accel: adxl313: add AC coupled activity/inactivity events
Date: Sun, 22 Jun 2025 12:29:36 +0000
Message-Id: <20250622122937.156930-8-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250622122937.156930-1-l.rubusch@gmail.com>
References: <20250622122937.156930-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce AC-coupled activity and inactivity as MAG_ADAPTIVE events.
This adds a new set of threshold and duration configuration options,
ensures proper handling of event disabling, and extends the use of the
link bit to support complementary event configurations.

For example, either ACTIVITY or ACTIVITY_AC can be enabled, but only the
most recently set configuration will remain active. Disabling ACTIVITY
will have no effect if ACTIVITY_AC is currently enabled, as the event
types must match (i.e., ACTIVITY_AC must be explicitly disabled). When
either INACTIVITY or INACTIVITY_AC is enabled alongside an activity
event, the link bit is set.

With the link bit and auto-sleep enabled, activity and inactivity events
represent changes in the sensor's power-saving state and are only
triggered upon actual state transitions. Since AC coupling uses separate
bits for activity and inactivity, each can be configured independently.
For instance, ACTIVITY can be linked with INACTIVITY_AC.

If one of the linked events is disabled, the link bit is cleared. In
that case, the remaining event will no longer reflect a state transition
but will instead trigger based on periodic inactivity or whenever the
activity threshold is exceeded.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313_core.c | 215 ++++++++++++++++++++++++++++---
 1 file changed, 200 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 40c75e90e4bf..292528b457b4 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -30,20 +30,38 @@
 #define ADXL313_ACT_XYZ_EN			GENMASK(6, 4)
 #define ADXL313_INACT_XYZ_EN			GENMASK(2, 0)
 
+#define ADXL313_REG_ACT_ACDC_MSK		BIT(7)
+#define ADXL313_REG_INACT_ACDC_MSK		BIT(3)
+#define ADXL313_COUPLING_DC			0
+#define ADXL313_COUPLING_AC			1
+
 /* activity/inactivity */
 enum adxl313_activity_type {
 	ADXL313_ACTIVITY,
 	ADXL313_INACTIVITY,
+	ADXL313_ACTIVITY_AC,
+	ADXL313_INACTIVITY_AC,
 };
 
 static const unsigned int adxl313_act_int_reg[] = {
 	[ADXL313_ACTIVITY] = ADXL313_INT_ACTIVITY,
 	[ADXL313_INACTIVITY] = ADXL313_INT_INACTIVITY,
+	[ADXL313_ACTIVITY_AC] = ADXL313_INT_ACTIVITY,
+	[ADXL313_INACTIVITY_AC] = ADXL313_INT_INACTIVITY,
 };
 
 static const unsigned int adxl313_act_thresh_reg[] = {
 	[ADXL313_ACTIVITY] = ADXL313_REG_THRESH_ACT,
 	[ADXL313_INACTIVITY] = ADXL313_REG_THRESH_INACT,
+	[ADXL313_ACTIVITY_AC] = ADXL313_REG_THRESH_ACT,
+	[ADXL313_INACTIVITY_AC] = ADXL313_REG_THRESH_INACT,
+};
+
+static const unsigned int adxl313_act_acdc_msk[] = {
+	[ADXL313_ACTIVITY] = ADXL313_REG_ACT_ACDC_MSK,
+	[ADXL313_INACTIVITY] = ADXL313_REG_INACT_ACDC_MSK,
+	[ADXL313_ACTIVITY_AC] = ADXL313_REG_ACT_ACDC_MSK,
+	[ADXL313_INACTIVITY_AC] = ADXL313_REG_INACT_ACDC_MSK,
 };
 
 static const struct regmap_range adxl312_readable_reg_range[] = {
@@ -255,6 +273,13 @@ static const struct iio_event_spec adxl313_activity_events[] = {
 		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
 		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
 	},
+	{
+		/* activity, AC bit set */
+		.type = IIO_EV_TYPE_MAG_ADAPTIVE,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
+	},
 };
 
 static const struct iio_event_spec adxl313_inactivity_events[] = {
@@ -266,6 +291,14 @@ static const struct iio_event_spec adxl313_inactivity_events[] = {
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
 
 enum adxl313_chans {
@@ -363,11 +396,72 @@ static int adxl313_set_inact_time_s(struct adxl313_data *data,
 	return regmap_write(data->regmap, ADXL313_REG_TIME_INACT, val);
 }
 
+/**
+ * adxl313_is_act_inact_ac() - Check if AC coupling is enabled.
+ * @data: The device data.
+ * @type: The activity or inactivity type.
+ *
+ * Provide a type of activity or inactivity, combined with either AC coupling
+ * set, or default to DC coupling. This function verifies if the combination is
+ * currently enabled or not.
+ *
+ * Return: if the provided activity type has AC coupling enabled or a negative
+ * error value.
+ */
+static int adxl313_is_act_inact_ac(struct adxl313_data *data,
+				   enum adxl313_activity_type type)
+{
+	unsigned int regval;
+	bool coupling;
+	int ret;
+
+	ret = regmap_read(data->regmap, ADXL313_REG_ACT_INACT_CTL, &regval);
+	if (ret)
+		return ret;
+
+	coupling = adxl313_act_acdc_msk[type] & regval;
+
+	switch (type) {
+	case ADXL313_ACTIVITY:
+	case ADXL313_INACTIVITY:
+		return coupling == ADXL313_COUPLING_DC;
+	case ADXL313_ACTIVITY_AC:
+	case ADXL313_INACTIVITY_AC:
+		return coupling == ADXL313_COUPLING_AC;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl313_set_act_inact_ac(struct adxl313_data *data,
+				    enum adxl313_activity_type type,
+				    bool cmd_en)
+{
+	unsigned int act_inact_ac;
+
+	switch (type) {
+	case ADXL313_ACTIVITY_AC:
+	case ADXL313_INACTIVITY_AC:
+		act_inact_ac = ADXL313_COUPLING_AC && cmd_en;
+		break;
+	case ADXL313_ACTIVITY:
+	case ADXL313_INACTIVITY:
+		act_inact_ac = ADXL313_COUPLING_DC && cmd_en;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_assign_bits(data->regmap, ADXL313_REG_ACT_INACT_CTL,
+				  adxl313_act_acdc_msk[type], act_inact_ac);
+}
+
 static int adxl313_is_act_inact_en(struct adxl313_data *data,
 				   enum adxl313_activity_type type)
 {
 	unsigned int axis_ctrl;
 	unsigned int regval;
+	bool int_en;
 	int ret;
 
 	ret = regmap_read(data->regmap, ADXL313_REG_ACT_INACT_CTL, &axis_ctrl);
@@ -377,10 +471,12 @@ static int adxl313_is_act_inact_en(struct adxl313_data *data,
 	/* Check if axis for activity are enabled */
 	switch (type) {
 	case ADXL313_ACTIVITY:
+	case ADXL313_ACTIVITY_AC:
 		if (!FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl))
 			return false;
 		break;
 	case ADXL313_INACTIVITY:
+	case ADXL313_INACTIVITY_AC:
 		if (!FIELD_GET(ADXL313_INACT_XYZ_EN, axis_ctrl))
 			return false;
 		break;
@@ -393,21 +489,38 @@ static int adxl313_is_act_inact_en(struct adxl313_data *data,
 	if (ret)
 		return ret;
 
-	return adxl313_act_int_reg[type] & regval;
+	int_en = adxl313_act_int_reg[type] & regval;
+	if (!int_en)
+		return false;
+
+	/* Check if configured coupling matches provided type */
+	return adxl313_is_act_inact_ac(data, type);
 }
 
 static int adxl313_set_act_inact_linkbit(struct adxl313_data *data, bool en)
 {
-	int act_en, inact_en;
+	int act_en, inact_en, act_ac_en, inact_ac_en;
 
 	act_en = adxl313_is_act_inact_en(data, ADXL313_ACTIVITY);
 	if (act_en < 0)
 		return act_en;
 
+	act_ac_en = adxl313_is_act_inact_en(data, ADXL313_ACTIVITY_AC);
+	if (act_ac_en < 0)
+		return act_ac_en;
+
 	inact_en = adxl313_is_act_inact_en(data, ADXL313_INACTIVITY);
 	if (inact_en < 0)
 		return inact_en;
 
+	inact_ac_en = adxl313_is_act_inact_en(data, ADXL313_INACTIVITY_AC);
+	if (inact_ac_en < 0)
+		return inact_ac_en;
+
+	act_en = act_en || act_ac_en;
+
+	inact_en = inact_en || inact_ac_en;
+
 	return regmap_assign_bits(data->regmap, ADXL313_REG_POWER_CTL,
 				  ADXL313_POWER_CTL_AUTO_SLEEP | ADXL313_POWER_CTL_LINK,
 				  en && act_en && inact_en);
@@ -433,7 +546,7 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 			return 0;
 
 		/* When turning on inactivity, check if inact time is valid */
-		if (type == ADXL313_INACTIVITY) {
+		if (type == ADXL313_INACTIVITY || type == ADXL313_INACTIVITY_AC) {
 			ret = regmap_read(data->regmap,
 					  ADXL313_REG_TIME_INACT,
 					  &inact_time_s);
@@ -443,6 +556,16 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 			if (!inact_time_s)
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
+		if (adxl313_is_act_inact_ac(data, type) <= 0)
+			return 0;
 	}
 
 	/* Start modifying configuration registers */
@@ -453,9 +576,11 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 	/* Enable axis according to the command */
 	switch (type) {
 	case ADXL313_ACTIVITY:
+	case ADXL313_ACTIVITY_AC:
 		axis_ctrl = ADXL313_ACT_XYZ_EN;
 		break;
 	case ADXL313_INACTIVITY:
+	case ADXL313_INACTIVITY_AC:
 		axis_ctrl = ADXL313_INACT_XYZ_EN;
 		break;
 	default:
@@ -466,6 +591,11 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 	if (ret)
 		return ret;
 
+	/* Update AC/DC-coupling according to the command */
+	ret = adxl313_set_act_inact_ac(data, type, cmd_en);
+	if (ret)
+		return ret;
+
 	/* Enable the interrupt line, according to the command */
 	ret = regmap_assign_bits(data->regmap, ADXL313_REG_INT_ENABLE,
 				 adxl313_act_int_reg[type], cmd_en);
@@ -596,6 +726,10 @@ static int adxl313_read_event_config(struct iio_dev *indio_dev,
 		return adxl313_read_mag_config(data, dir,
 					       ADXL313_ACTIVITY,
 					       ADXL313_INACTIVITY);
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		return adxl313_read_mag_config(data, dir,
+					       ADXL313_ACTIVITY_AC,
+					       ADXL313_INACTIVITY_AC);
 	default:
 		return -EINVAL;
 	}
@@ -615,6 +749,11 @@ static int adxl313_write_event_config(struct iio_dev *indio_dev,
 						ADXL313_ACTIVITY,
 						ADXL313_INACTIVITY,
 						state);
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		return adxl313_write_mag_config(data, dir,
+						ADXL313_ACTIVITY_AC,
+						ADXL313_INACTIVITY_AC,
+						state);
 	default:
 		return -EINVAL;
 	}
@@ -740,6 +879,11 @@ static int adxl313_read_event_value(struct iio_dev *indio_dev,
 					      ADXL313_ACTIVITY,
 					      ADXL313_INACTIVITY,
 					      val, val2);
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		return adxl313_read_mag_value(data, dir, info,
+					      ADXL313_ACTIVITY_AC,
+					      ADXL313_INACTIVITY_AC,
+					      val, val2);
 	default:
 		return -EINVAL;
 	}
@@ -760,6 +904,11 @@ static int adxl313_write_event_value(struct iio_dev *indio_dev,
 					       ADXL313_ACTIVITY,
 					       ADXL313_INACTIVITY,
 					       val, val2);
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		return adxl313_write_mag_value(data, dir, info,
+					       ADXL313_ACTIVITY_AC,
+					       ADXL313_INACTIVITY_AC,
+					       val, val2);
 	default:
 		return -EINVAL;
 	}
@@ -906,28 +1055,64 @@ static int adxl313_fifo_push(struct iio_dev *indio_dev, int samples)
 static int adxl313_push_events(struct iio_dev *indio_dev, int int_stat)
 {
 	s64 ts = iio_get_time_ns(indio_dev);
+	struct adxl313_data *data = iio_priv(indio_dev);
+	unsigned int regval;
 	int ret = -ENOENT;
 
 	if (FIELD_GET(ADXL313_INT_ACTIVITY, int_stat)) {
-		ret = iio_push_event(indio_dev,
-				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
-							IIO_MOD_X_OR_Y_OR_Z,
-							IIO_EV_TYPE_MAG,
-							IIO_EV_DIR_RISING),
-				     ts);
+		ret = regmap_read(data->regmap, ADXL313_REG_ACT_INACT_CTL, &regval);
 		if (ret)
 			return ret;
+
+		if (FIELD_GET(ADXL313_REG_ACT_ACDC_MSK, regval)) {
+			/* AC coupled */
+			ret = iio_push_event(indio_dev,
+					     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+								IIO_MOD_X_OR_Y_OR_Z,
+								IIO_EV_TYPE_MAG_ADAPTIVE,
+								IIO_EV_DIR_RISING),
+					     ts);
+			if (ret)
+				return ret;
+		} else {
+			/* DC coupled, relying on THRESH */
+			ret = iio_push_event(indio_dev,
+					     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+								IIO_MOD_X_OR_Y_OR_Z,
+								IIO_EV_TYPE_MAG,
+								IIO_EV_DIR_RISING),
+					     ts);
+			if (ret)
+				return ret;
+		}
 	}
 
 	if (FIELD_GET(ADXL313_INT_INACTIVITY, int_stat)) {
-		ret = iio_push_event(indio_dev,
-				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
-							IIO_MOD_X_AND_Y_AND_Z,
-							IIO_EV_TYPE_MAG,
-							IIO_EV_DIR_FALLING),
-				     ts);
+		ret = regmap_read(data->regmap, ADXL313_REG_ACT_INACT_CTL, &regval);
 		if (ret)
 			return ret;
+
+		if (FIELD_GET(ADXL313_REG_INACT_ACDC_MSK, regval)) {
+			/* AC coupled */
+			ret = iio_push_event(indio_dev,
+					     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+								IIO_MOD_X_AND_Y_AND_Z,
+								IIO_EV_TYPE_MAG_ADAPTIVE,
+								IIO_EV_DIR_FALLING),
+					     ts);
+			if (ret)
+				return ret;
+		} else {
+			/* DC coupled, relying on THRESH */
+			ret = iio_push_event(indio_dev,
+					     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+								IIO_MOD_X_AND_Y_AND_Z,
+								IIO_EV_TYPE_MAG,
+								IIO_EV_DIR_FALLING),
+					     ts);
+			if (ret)
+				return ret;
+		}
 	}
 
 	return ret;
-- 
2.39.5


