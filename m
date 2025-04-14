Return-Path: <linux-iio+bounces-18115-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB98CA88B9C
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 20:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 058B1189AAA7
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 18:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04F32918FD;
	Mon, 14 Apr 2025 18:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecFwJW/S"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3733E291168;
	Mon, 14 Apr 2025 18:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744656183; cv=none; b=V+9pMpzVOOmWc5rY120re/OA8HQjslElqp62VZp6uknWouTMKlKmQCzn/uuCiUaKHalyRC+t78I4DYHGNlCsxxBdMQXORPMkqNYg2TtDm6KZ0UiI3LKvwyTxTE0WLGkESUPn5dIc9M5ze1+y13RoGqyMAAgs3w5q2EpMl9fFkGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744656183; c=relaxed/simple;
	bh=wyyagOiACiCvVPtfTegoqZcSdk91zKhMmUH1jo4csWA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bullYokX2UtCViSpa083jY8K98GWUQFKXh+Z9DgLCi8Eo5XJtlpDQKElKKyMV7gIJt/oa2W6maRhw0i3Jwwb38e05z/2gVIbEOPTPx7gRmR5HiQ1eSEFxl9ajxG+Kf0Jc0iCVz5BuSbvMmUMyJcP2jVl0XGxhg7eztNSnCndRhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecFwJW/S; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-acb03ad9213so21486766b.1;
        Mon, 14 Apr 2025 11:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744656179; x=1745260979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lGIF7lExxCuuWmnKyS0UqvwvU1UEvZCkmq6EdHYGAg=;
        b=ecFwJW/SROTX2xMl4xRl0OgRh0iZ4z0xDtBPhi4tkBIpTeTvwW3T5cmd9FUceeDa0m
         EAI6U/aGzOoQyJDmVCePYQrTQsNAjYRpPxObLxFNALdu9i3viwgGmZiWydtrgOBqnuIG
         VY6zvzhqDwwnjM41QrJ10A1+GqgJTh0CGOxHJ1yqPbl+S/YjqheWn8hNW3ucGbkpNJcW
         /bMoTLUOz5q0U9lzJ0fpKDq0Veb/o4rj+2eL/slnL0PEA1ZSL9ENnF2kB3pLg2qVcoOL
         Kcyu2zEtYiumi4Cwupz6yFkyjsyaO7XviTju4BGqhTEl/PIkKXRe+2gQ+IF05h5LA7/Z
         n0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744656179; x=1745260979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8lGIF7lExxCuuWmnKyS0UqvwvU1UEvZCkmq6EdHYGAg=;
        b=SYklnQVaY1ih4mFJC69Yt5Xf3F+Kn0prixbgEKCeHXJmsxatf7tWEHASoA/sQqKP/d
         LeWT5n+dnNrbdjEakCgoac5mcnAfmDLxGkWg3qSSY2M6X3gp83307Nl3YNF++bTP5N2N
         4iR138KBgNAIucAp0m5P2GhcFQAmtH2n+ItsL1jkVGdX/37CrfSlLwBnbILQxH2WFtiG
         MlZQPDHS2aoWTF1OSOh6gLMRMRpXhw3cPDP29tlGOldyU5jT0cX8ikxvLUKX6Wwdsezw
         gkK8B5HZQcTau3ZxbQFu4IZAE1pXlmBW09YNsfYLFqR1s2x3eHBYxNbCDo/RXHSkQLjg
         2sYA==
X-Forwarded-Encrypted: i=1; AJvYcCXF/5gFCzCecF/zqHjTmN9NGUYF/2+Mc7Z9W3eK28C8KX5hjuO3bv/TkhPomiSLkByU/HvJYhSe3dcp/BU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4JcHuRB9uqmJ+mT1tAP5hJPuS2l/kFdSPIWVkoQ9m2aZsVIIQ
	0lkrMug+6JGyie5BZnV35oZVDGkyKNRjth7sXz6csxrd7UrbQGb2
X-Gm-Gg: ASbGncs0P2l5mvLHT27zBrM20wzG9wwRUPIjLZAZ7AP3Pe5FFMgqEDbanH/wyhuisyV
	pG8EBsrRzxKXvkQvu5x0ENPMfKneO68ZUYSfSLLWfqAGhXY/ECQ/3hMWF7T0ichQd3WZrfsPCoX
	FyPIxLYPWg9ggP1i+GGhu+QF2kfLcHNUafWQDL2ApHt2TTMBIJTRvNxfjD26rBzt8GgjHqzckmU
	hcMZBI4Oy7DO86GC2GRgp6lN5+jBPygPPCKQbxNaaDeR8iT4Oo5xXPUvxOzeleipcjFRGtPdds1
	oYCa3BKWCNle1VUgmU1mz8t50WKzsWQAWFGgCDKJj5cLthbKMvuz5W5fCXzxQ3oJiIHXqg71tDf
	E1PPF1dz/I3Qf2fWLKqU=
X-Google-Smtp-Source: AGHT+IHF4DrARXQVjjak5Z1Wdy3qdUxQveOk6nBfOOVKDEbbEdo1Wslk14hCzE62dTyT2+LJ+lOv3w==
X-Received: by 2002:a17:907:9593:b0:ac7:9237:60a8 with SMTP id a640c23a62f3a-acb13da62fdmr24073366b.9.1744656179027;
        Mon, 14 Apr 2025 11:42:59 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bb3172sm946483466b.24.2025.04.14.11.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 11:42:58 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v6 10/11] iio: accel: adxl345: add coupling detection for activity/inactivity
Date: Mon, 14 Apr 2025 18:42:44 +0000
Message-Id: <20250414184245.100280-11-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414184245.100280-1-l.rubusch@gmail.com>
References: <20250414184245.100280-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add coupling activity/inactivity detection by the AC/DC bit. This is an
addititional enhancement for the detection of activity states and
completes the activity / inactivity feature of the ADXL345.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 162 ++++++++++++++++++++++++++++++-
 1 file changed, 159 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 06028eaef9e0..fe0201c7bec6 100644
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
@@ -91,6 +93,11 @@ static const unsigned int adxl345_act_thresh_reg[] = {
 	[ADXL345_INACTIVITY] = ADXL345_REG_THRESH_INACT,
 };
 
+static const unsigned int adxl345_act_acdc_msk[] = {
+	[ADXL345_ACTIVITY] = ADXL345_REG_ACT_ACDC_MSK,
+	[ADXL345_INACTIVITY] = ADXL345_REG_INACT_ACDC_MSK,
+};
+
 enum adxl345_odr {
 	ADXL345_ODR_0P10HZ = 0,
 	ADXL345_ODR_0P20HZ,
@@ -220,6 +227,18 @@ static struct iio_event_spec adxl345_events[] = {
 			BIT(IIO_EV_INFO_VALUE) |
 			BIT(IIO_EV_INFO_PERIOD),
 	},
+	{
+		/* activity, activity - ac bit */
+		.type = IIO_EV_TYPE_MAG_REFERENCED,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		/* activity, inactivity - ac bit */
+		.type = IIO_EV_TYPE_MAG_REFERENCED,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE),
+	},
 };
 
 #define ADXL345_CHANNEL(index, reg, axis) {					\
@@ -301,6 +320,69 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
 
 /* act/inact */
 
+static int adxl345_is_act_inact_ac(struct adxl345_state *st,
+				   enum adxl345_activity_type type, bool *ac)
+{
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADXL345_REG_ACT_INACT_CTRL, &regval);
+	if (ret)
+		return ret;
+
+	if (type == ADXL345_ACTIVITY)
+		*ac = FIELD_GET(ADXL345_REG_ACT_ACDC_MSK, regval);
+	else
+		*ac = FIELD_GET(ADXL345_REG_INACT_ACDC_MSK, regval);
+
+	return 0;
+}
+
+static int adxl345_set_act_inact_ac(struct adxl345_state *st,
+				    enum adxl345_activity_type type, bool ac)
+{
+	unsigned int act_inact_ac = ac ? 0xff : 0x00;
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
@@ -766,9 +848,16 @@ static int adxl345_find_odr(struct adxl345_state *st, int val,
 
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
@@ -789,9 +878,51 @@ static int adxl345_find_range(struct adxl345_state *st, int val, int val2,
 
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
@@ -930,7 +1061,7 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
 				     enum iio_event_direction dir)
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
-	bool int_en;
+	bool int_en, act_ac, inact_ac;
 	int ret;
 
 	switch (type) {
@@ -975,6 +1106,21 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 		return int_en;
+	case IIO_EV_TYPE_MAG_REFERENCED:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			ret = adxl345_is_act_inact_ac(st, ADXL345_ACTIVITY, &act_ac);
+			if (ret)
+				return ret;
+			return act_ac;
+		case IIO_EV_DIR_FALLING:
+			ret = adxl345_is_act_inact_ac(st, ADXL345_INACTIVITY, &inact_ac);
+			if (ret)
+				return ret;
+			return inact_ac;
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -1011,6 +1157,16 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 		}
 	case IIO_EV_TYPE_MAG:
 		return adxl345_set_ff_en(st, state);
+	case IIO_EV_TYPE_MAG_REFERENCED:
+		switch (dir) {
+		case IIO_EV_DIR_RISING:
+			return adxl345_set_act_inact_ac(st, ADXL345_ACTIVITY, state);
+		case IIO_EV_DIR_FALLING:
+			return adxl345_set_act_inact_ac(st, ADXL345_INACTIVITY, state);
+		default:
+			return -EINVAL;
+		}
+
 	default:
 		return -EINVAL;
 	}
-- 
2.39.5


