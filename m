Return-Path: <linux-iio+bounces-21277-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FD9AF6608
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 01:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6066C4E09CE
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 23:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AF72FC3C7;
	Wed,  2 Jul 2025 23:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJy8YVQj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8092F6FA9;
	Wed,  2 Jul 2025 23:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497716; cv=none; b=Veh3SdNWqmw7Rl0lCGyvYdmMjPJ0TNs8wc8c7lqimN24lQ61gRWVzSUqiJXCgiLzsyMw6ampebq2sIFYa+1Il+09xz+S7syE7LOoVmIGl/HzqoetnFWyAA4fjI+0Nnp/gwHzEt9ERVeDaOPABcjRvU4jpcMryggI5LRUzEmQwjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497716; c=relaxed/simple;
	bh=2NYscPkXH7LujJ6YrvLFy+toBDx7nKVU2gmdbMVK+Ds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cBPB2hlK+v1kfoCEMUD5Mm0xQHZ+i63SCdxZPxV/7tczWvV7WiiCdLy272k0zjRqyyvhSXpfu22jrIcpa8yrdPBsyFsiZU0m3yFHKK8pUXJ3WjQ5fi77C6qPhabwdvlMJwkpDeYrUvNE7x3QbLlRP3RgC1lSZ46F80R0xPPMiYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJy8YVQj; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-607247169c0so1551209a12.0;
        Wed, 02 Jul 2025 16:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497712; x=1752102512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4B+iskX/Yrubk1UAIA+RBumAroBgKkhC6vP1mpZ4uc=;
        b=XJy8YVQjfyH9TIO6xEsuvJ9VekLle0AaOoHUy+a4efLEfoNpd72654JqHqPygqXAo/
         OfgltxR7sEg5MzOXsh30oMsmyL/2lLIpMGJ5dOfZeqpjWl9BO0TRG66fviwU2VI0yJpt
         siO8+oyOXZ0OZCmW58jMD9ekDYZep0hkvuVzIRFB57ff2H6xSMfmicRqfVB7lAjtxWx7
         Vr5HXSBqpnasgZ5OhHc0HrZfNnOGBaBfj6CtV7Cn2oWw3qM9Sbs725ZRhPFkqCx2BmvA
         m/tsSbCyzhk7rcWdofqdMC4r+mwvZ9EILwIu4UOP8v7FSCDb5rz9A7sxMya0zkCekjac
         UUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497712; x=1752102512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4B+iskX/Yrubk1UAIA+RBumAroBgKkhC6vP1mpZ4uc=;
        b=oC6t7ltBUZxx2YpTh3hK3NlR0y8RL+/FqKU9pHQdOG8SM8S8JS8GafmIVvDwFlW2l/
         2jsPTZXsXgkBFB0jz75UEeVpTiYYx7EJw/XOKWSlTOlz/je56MaTJ5DAu9MEjdMcD3J9
         BeGS+q2jVN2HFvsMUECpzDDCD6W2E1hblWIDXlvezpXKgM+IcTwAfk+tKxaSchhqAedf
         V5RHxRr6FHtZGiLb0oQW9IIa9CRSIyLla7A4mku8B4RqwZS2TU6K/TYypcQ0sdzBJaY+
         xUOiL51qL7l4FOM/wwGGGxWZvucv0UB8bwnhHTAAfk1/vI1K3LdiZi6W6ktxGyWkVHb7
         jm+g==
X-Forwarded-Encrypted: i=1; AJvYcCU0K8z5qCyPdwpqGRIzajXVdM6komB8H9XWEBwEXKxFrNr+Fv+EvU4yTWzAduqfy0B+SKPRls2CnvY=@vger.kernel.org, AJvYcCU9YWVAPha+sSlx98ytPhmB5lsD8Lxac45UzZQkwPFrP/kah+M9RymfC24lvj/mHBE3SURB1P0M1+EZXJjZ@vger.kernel.org, AJvYcCWH79qryta8DbSZ2BYqCGq+rqQOU0C/zHVuVmcJMagWrX06gUae+YFr7LkqDO/PU4IWhx7elz/xyE9S@vger.kernel.org
X-Gm-Message-State: AOJu0Yz82INXTexHl1LhVIx7qMUr/bTTvm9Ek2gPuOR+O2nqNzOSSoWL
	8z7LCOwnILZsotgxi68F7rTGBNHHFwkR+OokE6b2fbJnITK/v+dQOcPlG4biTg==
X-Gm-Gg: ASbGncvjS0F/N+wD1qMPQ7qfEBUgbyXhtNqLpBOTHMEYYnvsmqnD7NUmXLE3TrA2SQy
	8YdzrCB+6IHYWQIiFZTQYt1onwbNoO18nC6y0v5q3LmtTp+ixqMjiLsD84+jVAOeL+DfWsdKTsJ
	4RMN3VO3A0NPYfXVgq9dViHPup76LqBJYw5RfhE0tcWszUSqxXZ8U6LV9ycTyWaAMzSt6RjvfVo
	b9mWYb2XKRJCSeWj0JZzznnj1gvDSeNU9oMmAcZxclKlLvCUTtnVMNab8sd09/RPcXI6GLgvddu
	WgA4tNGvfpNwQAZ8NwypGVAmy/44jje93z+Y+sh6T2qQVlk8kNyDLBU+vNOwmGPSSczicqpRGtq
	XAhgg6JqwB8teiPDPMZXFd1wpQ117bHMt
X-Google-Smtp-Source: AGHT+IHCqgkMJc9oI/BxLtFpKdhNkWt++X1s7AXorGIRhDzVTMYoD7D3Df8ihICyvnd6FKJnzxNWFQ==
X-Received: by 2002:a17:907:3e24:b0:ade:902e:7b4b with SMTP id a640c23a62f3a-ae3c2adb981mr146381366b.7.1751497711811;
        Wed, 02 Jul 2025 16:08:31 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353ca18bbsm1158355566b.151.2025.07.02.16.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:08:31 -0700 (PDT)
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
Subject: [PATCH v7 7/8] iio: accel: adxl313: add AC coupled activity/inactivity events
Date: Wed,  2 Jul 2025 23:08:18 +0000
Message-Id: <20250702230819.19353-8-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250702230819.19353-1-l.rubusch@gmail.com>
References: <20250702230819.19353-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl313_core.c | 214 +++++++++++++++++++++++++++++--
 1 file changed, 200 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index df10dc430e1c..c62e669d41e8 100644
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
@@ -393,21 +489,39 @@ static int adxl313_is_act_inact_en(struct adxl313_data *data,
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
+	int act_ac_en, inact_ac_en;
 	int act_en, inact_en;
 
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
@@ -433,7 +547,7 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
 			return 0;
 
 		/* When turning on inactivity, check if inact time is valid */
-		if (type == ADXL313_INACTIVITY) {
+		if (type == ADXL313_INACTIVITY || type == ADXL313_INACTIVITY_AC) {
 			ret = regmap_read(data->regmap,
 					  ADXL313_REG_TIME_INACT,
 					  &inact_time_s);
@@ -443,6 +557,16 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
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
@@ -453,9 +577,11 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
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
@@ -466,6 +592,11 @@ static int adxl313_set_act_inact_en(struct adxl313_data *data,
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
@@ -596,6 +727,10 @@ static int adxl313_read_event_config(struct iio_dev *indio_dev,
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
@@ -615,6 +750,11 @@ static int adxl313_write_event_config(struct iio_dev *indio_dev,
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
@@ -714,6 +854,11 @@ static int adxl313_read_event_value(struct iio_dev *indio_dev,
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
@@ -734,6 +879,11 @@ static int adxl313_write_event_value(struct iio_dev *indio_dev,
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
@@ -880,28 +1030,64 @@ static int adxl313_fifo_push(struct iio_dev *indio_dev, int samples)
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


