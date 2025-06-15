Return-Path: <linux-iio+bounces-20692-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 295BEADA463
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 00:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A07603B02B3
	for <lists+linux-iio@lfdr.de>; Sun, 15 Jun 2025 22:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0278284B58;
	Sun, 15 Jun 2025 22:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNFzkMJA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2765E283FD6;
	Sun, 15 Jun 2025 22:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750026197; cv=none; b=kGM81t49RghMwFSOXKFFzgakJEBd7tKMsxfSdMnlOb7iql0topRDjNDfgZY40EN7KVwpBqnwEB6F1RxjBxvR+uUE4iZgFuggiQYrtb/ZG8dz3SpywPcAVQ97AvPU24yP8pwtNdvnyqjMyTz1ZuFabEqh9/iQWTx0b8s4Rz+Lvac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750026197; c=relaxed/simple;
	bh=5zmq67RrbidWvGT+nU8mPVUwsnFqWPDMndHHaEb9/Ro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tWYzeComvvtZaCo7+11kWSGu4ZGmZHvYEffK5bCIbh4zXS6EmBP6s2hjJjqLWIfP82A28muF3mP3mmVF95+ByTra2kl/W2PDOiVTWjFrcjuWri11mWevxRKuIGiWZMvI0BzV9ikXh3lT3Yy2Gva0GnUcR6OLR0fRsfMRtQVaI+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNFzkMJA; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6006cf5000aso590186a12.0;
        Sun, 15 Jun 2025 15:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750026193; x=1750630993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGHcozTw568gdp3NNjBkf4aWTLbK4Gw6qR5VfaroyFw=;
        b=TNFzkMJAk8pdWgT/lG6T95dRgaxFw8b3R3Pu+hyifmLvhZ5uO2nKgUY5fy0PmRZ4gC
         u5mcP1HTJbSIesThlvjyR4DsR9Jima4dvuO8C0MeyjdGCCS/WDLbkdOx/gXdDvsJ+zWe
         7gvuEKmm+EoopoBj0UqY/51TEKvC2gLVrsHTXfRyg8d1Q2WpJPEwbdK9PkYhtNbhPVWi
         Lvk7tideFbNzAmc+xlam+uuwNw4T2K20k1tibVE0jFYpk4HLUoy5KSAr4UJWwye5f/zU
         iggaePMA4Y2PO78amknhCbLveTpFIvSFgPGuSITR3a3PlZQ5p9/Gz97KTKrKRUOlbl9T
         tgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750026193; x=1750630993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGHcozTw568gdp3NNjBkf4aWTLbK4Gw6qR5VfaroyFw=;
        b=vMfNOTVp9k/2tAzTqZa9ABtlwRM42dtWDvpvFKeLVKbxlEM4LsOB0b7ZET/CYoXLXq
         fNe+NvrobYiGX4L6efcGf9COrcBv7vKGv1dWeDCGLY9EfUKbTeC0isaNr7hXRvOjTg1q
         W/niYMIhFUzR1WYWqqFpbBStG8WNLc02Bb66bHhKNZH2AJXwaJqHvsnV1XptzuXKJtaM
         1xcU+c7nPY7RaUN0SsQq21NKd6osmlBomXuQeBNCObXiVp+QVVLQ43VJP0KeI19+T9Hw
         bIKB5Cyw+ZHNb7MLPLa7JJeU3yPVHH1ahesp6OpdDP8dp/jNTYFgL1quofDwBYAgcz9H
         o8pg==
X-Forwarded-Encrypted: i=1; AJvYcCVSOq2zfWqN38RovRQoqjRL+c9wn49khMWAR+axSSGlkx/cnl7cVoUUj2Qgzcnsooq8ZTz4Z9B0m1H7@vger.kernel.org, AJvYcCVU6SBTOm3FcGhSq4gZK3lK9o+O9TtC/Rqp16GMQaYwLvpjW0aG/ggccwJ1Dqkncw9KPgPLWLqkll/43c/Y@vger.kernel.org, AJvYcCWRji8RMOPcoS4wxnj50GLwtU4k8njWkcQUh/ZGA3MPHXtXiMUZvfuW+xlP6UtEObdTUspYPtEfMnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQFeCycsOETGhmttvYb8ey8QUsO5ES33EtKADt+wXalpguRQoQ
	N4qsBrTv03CHQhNb1vLh9klEv8L+zCTZLHrQ4AkPPYo0ssRzvzX2Gjk0
X-Gm-Gg: ASbGncszA0BAMQqb6qIpLBOE3cQcMEePW0s8FMPx6AjOdNFhFYkyklzbUnKlgHyT+5q
	8X8ea08IieGsIbAWclObySvfOY6t7ItNIbaU6vTig/bxB8S4HUQsTd2OZI3wP2+b86tJTMRAkWq
	35tMqMxydhhvsSTQhcZDv6XU9coNbuBA32IAjamc5y0l77GJLHMLSB7roxfEd2wcGq2vN2Vcf4R
	Iup/9CFwhRTbukCBg0WAbGosf8Hn1yu9vvxS0ABvBR3SyD+8gA1aXmYHvijh/CqaSmycwqZ/r75
	uprUMyi4o6QYH9u/jLWw6Ua3GSB380AYljks1sgPlkfFC0MzRWmCsJhR00Axyy1g0R4Dnut+cJz
	JfbUcvw2zKUHL7YnzZXputW6/ZANXmN9V
X-Google-Smtp-Source: AGHT+IGq1YyyLSTwX05SLsNZo3BZaqX+E9QYjc+fO7jg/QIhpa/1Z+d1DQXHFH0o4AEyNAES9k7W5w==
X-Received: by 2002:a17:907:7e84:b0:adb:5985:5b58 with SMTP id a640c23a62f3a-adfad2f3e2amr226171866b.1.1750026193270;
        Sun, 15 Jun 2025 15:23:13 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adf8b393ea8sm412692766b.159.2025.06.15.15.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 15:23:12 -0700 (PDT)
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
Subject: [PATCH v5 7/8] iio: accel: adxl313: add AC coupled activity/inactivity events
Date: Sun, 15 Jun 2025 22:22:57 +0000
Message-Id: <20250615222258.117771-8-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250615222258.117771-1-l.rubusch@gmail.com>
References: <20250615222258.117771-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl313_core.c | 361 +++++++++++++++++++++++++------
 1 file changed, 296 insertions(+), 65 deletions(-)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index d8a263b2a6f6..a04f28049f3e 100644
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
@@ -265,6 +290,14 @@ static const struct iio_event_spec adxl313_inactivity_events[] = {
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
@@ -362,12 +395,50 @@ static int adxl313_set_inact_time_s(struct adxl313_data *data,
 	return regmap_write(data->regmap, ADXL313_REG_TIME_INACT, val);
 }
 
+/**
+ * adxl313_is_act_inact_ac() - Check if AC coupling is enabled.
+ * @data: The device data.
+ * @type: The activity or inactivity type.
+ *
+ * Provide a type of activity or inactivity, combined with either AC coupling
+ * set, or default to DC coupling. This function verifies, if the combination is
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
 static int adxl313_is_act_inact_en(struct adxl313_data *data,
 				   enum adxl313_activity_type type)
 {
 	unsigned int axis_ctrl;
 	unsigned int regval;
-	int axis_en, ret;
+	bool axis_en, int_en;
+	int ret;
 
 	ret = regmap_read(data->regmap, ADXL313_REG_ACT_INACT_CTL, &axis_ctrl);
 	if (ret)
@@ -376,9 +447,11 @@ static int adxl313_is_act_inact_en(struct adxl313_data *data,
 	/* Check if axis for activity are enabled */
 	switch (type) {
 	case ADXL313_ACTIVITY:
+	case ADXL313_ACTIVITY_AC:
 		axis_en = FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl);
 		break;
 	case ADXL313_INACTIVITY:
+	case ADXL313_INACTIVITY_AC:
 		axis_en = FIELD_GET(ADXL313_INACT_XYZ_EN, axis_ctrl);
 		break;
 	default:
@@ -393,21 +466,38 @@ static int adxl313_is_act_inact_en(struct adxl313_data *data,
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
+	act_en = act_en || act_ac_en;
+
 	inact_en = adxl313_is_act_inact_en(data, ADXL313_INACTIVITY);
 	if (inact_en < 0)
 		return inact_en;
 
+	inact_ac_en = adxl313_is_act_inact_en(data, ADXL313_INACTIVITY_AC);
+	if (inact_ac_en < 0)
+		return inact_ac_en;
+
+	inact_en = inact_en || inact_ac_en;
+
 	en = en && act_en && inact_en;
 
 	return regmap_assign_bits(data->regmap, ADXL313_REG_POWER_CTL,
@@ -422,6 +512,7 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 	unsigned int axis_ctrl;
 	unsigned int threshold;
 	unsigned int inact_time_s;
+	bool act_inact_ac;
 	int ret;
 
 	if (cmd_en) {
@@ -435,7 +526,7 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 			return 0;
 
 		/* When turning on inactivity, check if inact time is valid */
-		if (type == ADXL313_INACTIVITY) {
+		if (type == ADXL313_INACTIVITY || type == ADXL313_INACTIVITY_AC) {
 			ret = regmap_read(data->regmap, ADXL313_REG_TIME_INACT, &inact_time_s);
 			if (ret)
 				return ret;
@@ -443,6 +534,14 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 			if (!inact_time_s)
 				return 0;
 		}
+	} else {
+		/* When turning off, check if the correct coupling event was
+		 * specified, this can be misused, e.g.: Having AC-coupled
+		 * activity turned on, and in current call trying to turning off
+		 * a DC-coupled activity shall be caught here.
+		 */
+		if (adxl313_is_act_inact_ac(data, type) <= 0)
+			return 0;
 	}
 
 	/* Start modifying configuration registers */
@@ -453,9 +552,11 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
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
@@ -466,6 +567,25 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 	if (ret)
 		return ret;
 
+	/* Update AC/DC-coupling according to the command */
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
+	ret = regmap_assign_bits(data->regmap, ADXL313_REG_ACT_INACT_CTL,
+				 adxl313_act_acdc_msk[type], act_inact_ac);
+	if (ret)
+		return ret;
+
 	/* Enable the interrupt line, according to the command */
 	ret = regmap_assign_bits(data->regmap, ADXL313_REG_INT_ENABLE,
 				 adxl313_act_int_reg[type], cmd_en);
@@ -553,6 +673,37 @@ static int adxl313_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int adxl313_read_mag_config(struct adxl313_data *data,
+				   enum iio_event_direction dir,
+				   enum adxl313_activity_type act_type,
+				   enum adxl313_activity_type inact_type)
+{
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		return adxl313_is_act_inact_en(data, act_type);
+	case IIO_EV_DIR_FALLING:
+		return adxl313_is_act_inact_en(data, inact_type);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl313_write_mag_config(struct adxl313_data *data,
+				    enum iio_event_direction dir,
+				    enum adxl313_activity_type act_type,
+				    enum adxl313_activity_type inact_type,
+				    bool state)
+{
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		return adxl313_set_act_inact_en(data, act_type, state);
+	case IIO_EV_DIR_FALLING:
+		return adxl313_set_act_inact_en(data, inact_type, state);
+	default:
+		return -EINVAL;
+	}
+}
+
 static int adxl313_read_event_config(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan,
 				     enum iio_event_type type,
@@ -560,14 +711,15 @@ static int adxl313_read_event_config(struct iio_dev *indio_dev,
 {
 	struct adxl313_data *data = iio_priv(indio_dev);
 
-	if (type != IIO_EV_TYPE_MAG)
-		return -EINVAL;
-
-	switch (dir) {
-	case IIO_EV_DIR_RISING:
-		return adxl313_is_act_inact_en(data, ADXL313_ACTIVITY);
-	case IIO_EV_DIR_FALLING:
-		return adxl313_is_act_inact_en(data, ADXL313_INACTIVITY);
+	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		return adxl313_read_mag_config(data, dir,
+					       ADXL313_ACTIVITY,
+					       ADXL313_INACTIVITY);
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		return adxl313_read_mag_config(data, dir,
+					       ADXL313_ACTIVITY_AC,
+					       ADXL313_INACTIVITY_AC);
 	default:
 		return -EINVAL;
 	}
@@ -581,54 +733,51 @@ static int adxl313_write_event_config(struct iio_dev *indio_dev,
 {
 	struct adxl313_data *data = iio_priv(indio_dev);
 
-	if (type != IIO_EV_TYPE_MAG)
-		return -EINVAL;
-
-	switch (dir) {
-	case IIO_EV_DIR_RISING:
-		return adxl313_set_act_inact_en(data, ADXL313_ACTIVITY, state);
-	case IIO_EV_DIR_FALLING:
-		return adxl313_set_act_inact_en(data, ADXL313_INACTIVITY, state);
+	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		return adxl313_write_mag_config(data, dir,
+						ADXL313_ACTIVITY,
+						ADXL313_INACTIVITY,
+						state);
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		return adxl313_write_mag_config(data, dir,
+						ADXL313_ACTIVITY_AC,
+						ADXL313_INACTIVITY_AC,
+						state);
 	default:
 		return -EINVAL;
 	}
 }
 
-static int adxl313_read_event_value(struct iio_dev *indio_dev,
-				    const struct iio_chan_spec *chan,
-				    enum iio_event_type type,
-				    enum iio_event_direction dir,
-				    enum iio_event_info info,
-				    int *val, int *val2)
+static int adxl313_read_mag_value(struct adxl313_data *data,
+				  enum iio_event_direction dir,
+				  enum iio_event_info info,
+				  enum adxl313_activity_type act_type,
+				  enum adxl313_activity_type inact_type,
+				  int *val, int *val2)
 {
-	struct adxl313_data *data = iio_priv(indio_dev);
-	unsigned int act_threshold;
-	unsigned int inact_threshold;
-	unsigned int inact_time_s;
+	unsigned int threshold, period;
 	int ret;
 
-	if (type != IIO_EV_TYPE_MAG)
-		return -EINVAL;
-
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
 		switch (dir) {
 		case IIO_EV_DIR_RISING:
 			ret = regmap_read(data->regmap,
-					  adxl313_act_thresh_reg[ADXL313_ACTIVITY],
-					  &act_threshold);
+					  adxl313_act_thresh_reg[act_type],
+					  &threshold);
 			if (ret)
 				return ret;
-			*val = act_threshold * 15625;
+			*val = threshold * 15625;
 			*val2 = MICRO;
 			return IIO_VAL_FRACTIONAL;
 		case IIO_EV_DIR_FALLING:
 			ret = regmap_read(data->regmap,
-					  adxl313_act_thresh_reg[ADXL313_INACTIVITY],
-					  &inact_threshold);
+					  adxl313_act_thresh_reg[inact_type],
+					  &threshold);
 			if (ret)
 				return ret;
-			*val = inact_threshold * 15625;
+			*val = threshold * 15625;
 			*val2 = MICRO;
 			return IIO_VAL_FRACTIONAL;
 		default:
@@ -637,29 +786,25 @@ static int adxl313_read_event_value(struct iio_dev *indio_dev,
 	case IIO_EV_INFO_PERIOD:
 		ret = regmap_read(data->regmap,
 				  ADXL313_REG_TIME_INACT,
-				  &inact_time_s);
+				  &period);
 		if (ret)
 			return ret;
-		*val = inact_time_s;
+		*val = period;
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
 }
 
-static int adxl313_write_event_value(struct iio_dev *indio_dev,
-				     const struct iio_chan_spec *chan,
-				     enum iio_event_type type,
-				     enum iio_event_direction dir,
-				     enum iio_event_info info,
-				     int val, int val2)
+static int adxl313_write_mag_value(struct adxl313_data *data,
+				   enum iio_event_direction dir,
+				   enum iio_event_info info,
+				   enum adxl313_activity_type act_type,
+				   enum adxl313_activity_type inact_type,
+				   int val, int val2)
 {
-	struct adxl313_data *data = iio_priv(indio_dev);
 	unsigned int regval;
 
-	if (type != IIO_EV_TYPE_MAG)
-		return -EINVAL;
-
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
 		/* Scale factor 15.625 mg/LSB */
@@ -667,11 +812,11 @@ static int adxl313_write_event_value(struct iio_dev *indio_dev,
 		switch (dir) {
 		case IIO_EV_DIR_RISING:
 			return regmap_write(data->regmap,
-					    adxl313_act_thresh_reg[ADXL313_ACTIVITY],
+					    adxl313_act_thresh_reg[act_type],
 					    regval);
 		case IIO_EV_DIR_FALLING:
 			return regmap_write(data->regmap,
-					    adxl313_act_thresh_reg[ADXL313_INACTIVITY],
+					    adxl313_act_thresh_reg[inact_type],
 					    regval);
 		default:
 			return -EINVAL;
@@ -683,6 +828,56 @@ static int adxl313_write_event_value(struct iio_dev *indio_dev,
 	}
 }
 
+static int adxl313_read_event_value(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info,
+				    int *val, int *val2)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+
+	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		return adxl313_read_mag_value(data, dir, info,
+					      ADXL313_ACTIVITY,
+					      ADXL313_INACTIVITY,
+					      val, val2);
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		return adxl313_read_mag_value(data, dir, info,
+					      ADXL313_ACTIVITY_AC,
+					      ADXL313_INACTIVITY_AC,
+					      val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl313_write_event_value(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     enum iio_event_info info,
+				     int val, int val2)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+
+	switch (type) {
+	case IIO_EV_TYPE_MAG:
+		return adxl313_write_mag_value(data, dir, info,
+					       ADXL313_ACTIVITY,
+					       ADXL313_INACTIVITY,
+					       val, val2);
+	case IIO_EV_TYPE_MAG_ADAPTIVE:
+		return adxl313_write_mag_value(data, dir, info,
+					       ADXL313_ACTIVITY_AC,
+					       ADXL313_INACTIVITY_AC,
+					       val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
 static int adxl313_set_watermark(struct iio_dev *indio_dev, unsigned int value)
 {
 	struct adxl313_data *data = iio_priv(indio_dev);
@@ -824,28 +1019,64 @@ static int adxl313_fifo_push(struct iio_dev *indio_dev, int samples)
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


