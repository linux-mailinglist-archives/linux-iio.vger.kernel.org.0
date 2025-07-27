Return-Path: <linux-iio+bounces-22073-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B136B131E8
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 23:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0576B3B90AE
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 21:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904AF246791;
	Sun, 27 Jul 2025 21:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjUYdNWu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E2B1F0E34;
	Sun, 27 Jul 2025 21:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753650033; cv=none; b=Of6cLHbxUaf5AYD0Ugh4/Cbw4n6E8XfdVheI3NB3M3fpkvjkljpOf4BcFWsTZDypPY09yCH4Rgl5pUZhFN3SF0Ji6OaA5a6L6vv55c+IzokdSGB4FcMUh+So49+faY9UiUQIViWeuOzRIqx+7PvIqsNnJy0aOfxYVbMZwXe0LlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753650033; c=relaxed/simple;
	bh=pCPdL/hewuHD88XWSTocJCtdLtCh+MiwhX9OBuYOPaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PtkPQeJprbmoTXmpMKZwbLWsXUfq4rB9v21fVHTZfmozkEY++t7ERezQE8KqluYy7W9rUzrD7K9vjSzY86zces5dbyugA0GLkL1/yuv4gJprgQSJBZJXRN/ExcquC7ZoM/PeY5akicv6VPlnGFWIm64ofAC6NPXzpFqJU3UKJmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjUYdNWu; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae0df0bb8fbso41565466b.3;
        Sun, 27 Jul 2025 14:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753650029; x=1754254829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiH0K9sOxGBv6I0ixV7soe9DS0npQd2KiLp2DLeCcz0=;
        b=bjUYdNWueB1ZQJkMXo/ySG1IH65SQo9ZfjGfIRyEmAk2fNLHz3AINaqrsSiKL1CHuM
         nnp+Bro3a3+qrspIKSo1SLVCvG7XjUlgMu08DjVSBw3BR6/l3jR9BsFVb+YTUszMV1Sa
         yg+3mZGdp+ilSQeCrj0MDDXUpRmWX+Zf69enr9n+epwY29RX5XfkY4GncoPA8ecObvmO
         n/AWquR7Ktf44aopqyRoB+Dr91VLlpV2yFid1cC03m0+Ag0+Wc7MEed8dBIKGKgf99Qz
         14u73LfrEZvFmMfJOwXuGr385edGQ0Q9fw4jqAN60+GVa2+HTS2vmtsHqQgohCCqLdVm
         yDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753650029; x=1754254829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eiH0K9sOxGBv6I0ixV7soe9DS0npQd2KiLp2DLeCcz0=;
        b=oU/eCCkWk7jFhw2r4J1FalAVWpqinzAtOujPJvgMwNKoey9v+bP8lvGWGD2trCSaXW
         nK2KvC9yaQVVdrZQJQXM235Qit0db6W1gcoaZoMxjLTkBMrZY/oxvBn8AIrM+BTbJhI+
         qfDy+75k4SEFTTYPL8DBVolRjGoc/MS/tvnTfKe5q8mwEOPrjP0OYd4x5/S36zsd8//H
         mxgnmVHRNaQf68dUkgDQDicSzK8qTpApaNZqbF0qljR4MKvuvg7u0YyM8PpHUuDFeb5o
         p7+y4HsGESeCpgbW7SfYYg+ocxVeCvrA1D1ZPaNNC+n4hmMzxglnE+AotzavFParInyn
         1iXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa6YDdvAVN4/S5TuAaar9yqpOnHJwNj4EYsdUIFqCY7WCCObVRND8i1XHPvdzCmZ692+mcWhxhMx0=@vger.kernel.org, AJvYcCWTb6LEVTBXiVk+TJ5t8Ddpv5/FJ3Mog0VeYTmzefhiVnOxAf9r2s82BeH3LgaQ9FBSLJVmFscg1hYFGFZQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl4UgTdiAS9oilLz4cTsOxC7akjBok6lJJyd/mupnMf5ESDspw
	5sPm/l+9QQumMnFnkaDN6tqpHbwKgU6ik59KUPK4xlepYWdtabFA19Ciicdxeg==
X-Gm-Gg: ASbGncuoMnlY3gBqC0voDqhVOQj3HITu7I8VeD2hzQx2KcJsOcbLWeg3Mu4LhiAu4Qm
	a4QomV8wxV+WAlmIffqhKevXrmQfGRYPqPzFgY3/GYFWRlzCbEwJuyE0Yev8LApjr98XZIPENRV
	ZXvdTuC/ziM1BfQvn5AVSwrfXB9kowsfPnStqUv2TdscGA1pkeX9YNJzF8ix6H5UvXUHpnBjJDP
	QbTdYKRZubIkXgrTcP21VbYWP0czVNNOqcLxXY9kZPwFJ9LBq+GCukFIqNA3sFw9f6w46x6l9S8
	hfgsxfZunsg5WDq1Xn2lXesEAmlWpXcPomfAYJh5qQ7LnVFy8V515886aFQ5UXDiqXmsKFlei9i
	gM64FJ5QTO74YXvItu7tI5uFL/fGkTBDK9PQTPbhAyn3JWDVmAcEbE9FfVnNL2XzD8YEb
X-Google-Smtp-Source: AGHT+IF/bSSnQ1jVXnMo3sN69pOinM1P4Rz9s/MO01sXs/zCHGe4IGLjcPAIoEsTqZEzhUaiqji2Ng==
X-Received: by 2002:a05:6402:d09:b0:614:9ac9:5e6e with SMTP id 4fb4d7f45d1cf-614f1dfc6f1mr3492103a12.7.1753650029197;
        Sun, 27 Jul 2025 14:00:29 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61500add92dsm2512774a12.52.2025.07.27.14.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 14:00:28 -0700 (PDT)
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
Subject: [PATCH v12 5/7] iio: accel: adxl345: extend inactivity time for less than 1s
Date: Sun, 27 Jul 2025 21:00:12 +0000
Message-Id: <20250727210014.27766-6-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250727210014.27766-1-l.rubusch@gmail.com>
References: <20250727210014.27766-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inactivity and free-fall events are essentially the same type of sensor
events. Therefore, inactivity detection (normally set for periods between 1
and 255 seconds) can be extended for shorter durations to support free-fall
detection.

For periods shorter than 1 second, the driver automatically configures the
threshold and duration using the free-fall register. For periods longer
than 1 second, it uses the inactivity threshold and duration using the
inactivity registers.

When using the free-fall register, the link bit is not set, which means
auto-sleep cannot be enabled if activity detection is also active.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 200 +++++++++++++++++++++----------
 1 file changed, 138 insertions(+), 62 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 2722addde895..78e3f799ecc1 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -47,6 +47,7 @@
 #define ADXL345_INACT_Y_EN		BIT(1)
 #define ADXL345_INACT_X_EN		BIT(2)
 #define ADXL345_REG_INACT_ACDC		BIT(3)
+#define ADXL345_ACT_INACT_NO_AXIS_EN	0x00
 #define ADXL345_INACT_XYZ_EN		(ADXL345_INACT_Z_EN | ADXL345_INACT_Y_EN | ADXL345_INACT_X_EN)
 
 #define ADXL345_ACT_Z_EN		BIT(4)
@@ -57,6 +58,7 @@
 
 #define ADXL345_COUPLING_DC		0
 #define ADXL345_COUPLING_AC		1
+#define ADXL345_REG_NO_ACDC		0x00
 
 /* single/double tap */
 enum adxl345_tap_type {
@@ -87,6 +89,7 @@ enum adxl345_activity_type {
 	ADXL345_INACTIVITY,
 	ADXL345_ACTIVITY_AC,
 	ADXL345_INACTIVITY_AC,
+	ADXL345_INACTIVITY_FF,
 };
 
 static const unsigned int adxl345_act_int_reg[] = {
@@ -94,6 +97,7 @@ static const unsigned int adxl345_act_int_reg[] = {
 	[ADXL345_INACTIVITY] = ADXL345_INT_INACTIVITY,
 	[ADXL345_ACTIVITY_AC] = ADXL345_INT_ACTIVITY,
 	[ADXL345_INACTIVITY_AC] = ADXL345_INT_INACTIVITY,
+	[ADXL345_INACTIVITY_FF] = ADXL345_INT_FREE_FALL,
 };
 
 static const unsigned int adxl345_act_thresh_reg[] = {
@@ -101,6 +105,7 @@ static const unsigned int adxl345_act_thresh_reg[] = {
 	[ADXL345_INACTIVITY] = ADXL345_REG_THRESH_INACT,
 	[ADXL345_ACTIVITY_AC] = ADXL345_REG_THRESH_ACT,
 	[ADXL345_INACTIVITY_AC] = ADXL345_REG_THRESH_INACT,
+	[ADXL345_INACTIVITY_FF] = ADXL345_REG_THRESH_FF,
 };
 
 static const unsigned int adxl345_act_acdc_msk[] = {
@@ -108,6 +113,7 @@ static const unsigned int adxl345_act_acdc_msk[] = {
 	[ADXL345_INACTIVITY] = ADXL345_REG_INACT_ACDC,
 	[ADXL345_ACTIVITY_AC] = ADXL345_REG_ACT_ACDC,
 	[ADXL345_INACTIVITY_AC] = ADXL345_REG_INACT_ACDC,
+	[ADXL345_INACTIVITY_FF] = ADXL345_REG_NO_ACDC,
 };
 
 enum adxl345_odr {
@@ -190,6 +196,9 @@ struct adxl345_state {
 	u8 watermark;
 	u8 fifo_mode;
 
+	u8 inact_threshold;
+	u32 inact_time_ms;
+
 	u32 tap_duration_us;
 	u32 tap_latent_us;
 	u32 tap_window_us;
@@ -338,10 +347,72 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
 
 /* activity / inactivity */
 
+static int adxl345_set_inact_threshold(struct adxl345_state *st,
+				       unsigned int threshold)
+{
+	int ret;
+
+	st->inact_threshold = min(U8_MAX, threshold);
+
+	ret = regmap_write(st->regmap,
+			   adxl345_act_thresh_reg[ADXL345_INACTIVITY],
+			   st->inact_threshold);
+	if (ret)
+		return ret;
+
+	return regmap_write(st->regmap,
+			    adxl345_act_thresh_reg[ADXL345_INACTIVITY_FF],
+			    st->inact_threshold);
+}
+
+static int adxl345_set_default_time(struct adxl345_state *st)
+{
+	int max_boundary = U8_MAX;
+	int min_boundary = 10;
+	enum adxl345_odr odr;
+	unsigned int regval;
+	unsigned int val;
+	int ret;
+
+	/* Generated inactivity time based on ODR */
+	ret = regmap_read(st->regmap, ADXL345_REG_BW_RATE, &regval);
+	if (ret)
+		return ret;
+
+	odr = FIELD_GET(ADXL345_BW_RATE_MSK, regval);
+	val = clamp(max_boundary - adxl345_odr_tbl[odr][0],
+		    min_boundary, max_boundary);
+	st->inact_time_ms = MILLI * val;
+
+	/* Inactivity time in s */
+	return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
+}
+
+static int adxl345_set_inactivity_time(struct adxl345_state *st, u32 val_int)
+{
+	st->inact_time_ms = MILLI * val_int;
+
+	return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val_int);
+}
+
+static int adxl345_set_freefall_time(struct adxl345_state *st, u32 val_fract)
+{
+	/*
+	 * Datasheet max. value is 255 * 5000 us = 1.275000 seconds.
+	 *
+	 * Recommended values between 100ms and 350ms (0x14 to 0x46)
+	 */
+	st->inact_time_ms = DIV_ROUND_UP(val_fract, MILLI);
+
+	return regmap_write(st->regmap, ADXL345_REG_TIME_FF,
+			    DIV_ROUND_CLOSEST(val_fract, 5));
+}
+
 /**
  * adxl345_set_inact_time - Configure inactivity time explicitly or by ODR.
  * @st: The sensor state instance.
- * @val_s: A desired time value, between 0 and 255.
+ * @val_int: The inactivity time, integer part.
+ * @val_fract: The inactivity time, fractional part when val_int is 0.
  *
  * Inactivity time can be configured between 1 and 255 seconds. If a user sets
  * val_s to 0, a default inactivity time is calculated automatically (since 0 is
@@ -362,26 +433,24 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
  *
  * Return: 0 or error value.
  */
-static int adxl345_set_inact_time(struct adxl345_state *st, u32 val_s)
+static int adxl345_set_inact_time(struct adxl345_state *st, u32 val_int,
+				  u32 val_fract)
 {
-	int max_boundary = U8_MAX;
-	int min_boundary = 10;
-	unsigned int val = min(val_s, U8_MAX);
-	enum adxl345_odr odr;
-	unsigned int regval;
-	int ret;
-
-	if (val == 0) {
-		ret = regmap_read(st->regmap, ADXL345_REG_BW_RATE, &regval);
-		if (ret)
-			return ret;
-
-		odr = FIELD_GET(ADXL345_BW_RATE_MSK, regval);
-		val = clamp(max_boundary - adxl345_odr_tbl[odr][0],
-			    min_boundary, max_boundary);
+	if (val_int > 0) {
+		/* Time >= 1s, inactivity */
+		return adxl345_set_inactivity_time(st, val_int);
+	} else if (val_int == 0) {
+		if (val_fract > 0) {
+			/* Time < 1s, free-fall */
+			return adxl345_set_freefall_time(st, val_fract);
+		} else if (val_fract == 0) {
+			/* Time == 0.0s */
+			return adxl345_set_default_time(st);
+		}
 	}
 
-	return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
+	/* Do not support negative or wrong input. */
+	return -EINVAL;
 }
 
 /**
@@ -404,6 +473,9 @@ static int adxl345_is_act_inact_ac(struct adxl345_state *st,
 	bool coupling;
 	int ret;
 
+	if (type == ADXL345_INACTIVITY_FF)
+		return true;
+
 	ret = regmap_read(st->regmap, ADXL345_REG_ACT_INACT_CTRL, &regval);
 	if (ret)
 		return ret;
@@ -512,6 +584,9 @@ static int adxl345_is_act_inact_en(struct adxl345_state *st,
 		if (!en)
 			return false;
 		break;
+	case ADXL345_INACTIVITY_FF:
+		en = true;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -544,15 +619,20 @@ static int adxl345_set_act_inact_linkbit(struct adxl345_state *st,
 	if (act_ac_en < 0)
 		return act_ac_en;
 
-	inact_en = adxl345_is_act_inact_en(st, ADXL345_INACTIVITY);
-	if (inact_en < 0)
-		return inact_en;
+	if (type == ADXL345_INACTIVITY_FF) {
+		inact_en = false;
+	} else {
+		inact_en = adxl345_is_act_inact_en(st, ADXL345_INACTIVITY);
+		if (inact_en < 0)
+			return inact_en;
+
+		inact_ac_en = adxl345_is_act_inact_en(st, ADXL345_INACTIVITY_AC);
+		if (inact_ac_en < 0)
+			return inact_ac_en;
 
-	inact_ac_en = adxl345_is_act_inact_en(st, ADXL345_INACTIVITY_AC);
-	if (inact_ac_en < 0)
-		return inact_ac_en;
+		inact_en = inact_en || inact_ac_en;
+	}
 
-	inact_en = inact_en || inact_ac_en;
 	act_en = act_en || act_ac_en;
 
 	return regmap_assign_bits(st->regmap, ADXL345_REG_POWER_CTL,
@@ -571,11 +651,15 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 
 	if (cmd_en) {
 		/* When turning on, check if threshold is valid */
-		ret = regmap_read(st->regmap,
-				  adxl345_act_thresh_reg[type],
-				  &threshold);
-		if (ret)
-			return ret;
+		if (type == ADXL345_ACTIVITY || type == ADXL345_ACTIVITY_AC) {
+			ret = regmap_read(st->regmap,
+					  adxl345_act_thresh_reg[type],
+					  &threshold);
+			if (ret)
+				return ret;
+		} else {
+			threshold = st->inact_threshold;
+		}
 
 		if (!threshold) /* Just ignore the command if threshold is 0 */
 			return 0;
@@ -618,6 +702,9 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 	case ADXL345_INACTIVITY_AC:
 		axis_ctrl = ADXL345_INACT_XYZ_EN;
 		break;
+	case ADXL345_INACTIVITY_FF:
+		axis_ctrl = ADXL345_ACT_INACT_NO_AXIS_EN;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -883,7 +970,7 @@ static int adxl345_set_odr(struct adxl345_state *st, enum adxl345_odr odr)
 		return ret;
 
 	/* update inactivity time by ODR */
-	return adxl345_set_inact_time(st, 0);
+	return adxl345_set_inact_time(st, 0, 0);
 }
 
 static int adxl345_find_range(struct adxl345_state *st, int val, int val2,
@@ -920,12 +1007,6 @@ static int adxl345_set_range(struct adxl345_state *st, enum adxl345_range range)
 	if (ret)
 		return ret;
 
-	ret = regmap_read(st->regmap,
-			  adxl345_act_thresh_reg[ADXL345_INACTIVITY],
-			  &inact_threshold);
-	if (ret)
-		return ret;
-
 	ret = regmap_update_bits(st->regmap, ADXL345_REG_DATA_FORMAT,
 				 ADXL345_DATA_FORMAT_RANGE,
 				 FIELD_PREP(ADXL345_DATA_FORMAT_RANGE, range));
@@ -936,6 +1017,7 @@ static int adxl345_set_range(struct adxl345_state *st, enum adxl345_range range)
 		/ adxl345_range_factor_tbl[range];
 	act_threshold = min(U8_MAX, max(1, act_threshold));
 
+	inact_threshold = st->inact_threshold;
 	inact_threshold = inact_threshold * adxl345_range_factor_tbl[range_old]
 		/ adxl345_range_factor_tbl[range];
 	inact_threshold = min(U8_MAX, max(1, inact_threshold));
@@ -945,8 +1027,7 @@ static int adxl345_set_range(struct adxl345_state *st, enum adxl345_range range)
 	if (ret)
 		return ret;
 
-	return regmap_write(st->regmap, adxl345_act_thresh_reg[ADXL345_INACTIVITY],
-			   inact_threshold);
+	return adxl345_set_inact_threshold(st, inact_threshold);
 }
 
 static int adxl345_read_avail(struct iio_dev *indio_dev,
@@ -1191,7 +1272,6 @@ static int adxl345_read_mag_value(struct adxl345_state *st,
 				  int *val, int *val2)
 {
 	unsigned int threshold;
-	unsigned int period;
 	int ret;
 
 	switch (info) {
@@ -1207,25 +1287,16 @@ static int adxl345_read_mag_value(struct adxl345_state *st,
 			*val2 = MICRO;
 			return IIO_VAL_FRACTIONAL;
 		case IIO_EV_DIR_FALLING:
-			ret = regmap_read(st->regmap,
-					  adxl345_act_thresh_reg[type_inact],
-					  &threshold);
-			if (ret)
-				return ret;
-			*val = 62500 * threshold;
+			*val = 62500 * st->inact_threshold;
 			*val2 = MICRO;
 			return IIO_VAL_FRACTIONAL;
 		default:
 			return -EINVAL;
 		}
 	case IIO_EV_INFO_PERIOD:
-		ret = regmap_read(st->regmap,
-				  ADXL345_REG_TIME_INACT,
-				  &period);
-		if (ret)
-			return ret;
-		*val = period;
-		return IIO_VAL_INT;
+		*val = st->inact_time_ms;
+		*val2 = MILLI;
+		return IIO_VAL_FRACTIONAL;
 	default:
 		return -EINVAL;
 	}
@@ -1248,14 +1319,12 @@ static int adxl345_write_mag_value(struct adxl345_state *st,
 					    adxl345_act_thresh_reg[type_act],
 					    val);
 		case IIO_EV_DIR_FALLING:
-			return regmap_write(st->regmap,
-					    adxl345_act_thresh_reg[type_inact],
-					    val);
+			return adxl345_set_inact_threshold(st, val);
 		default:
 			return -EINVAL;
 		}
 	case IIO_EV_INFO_PERIOD:
-		return adxl345_set_inact_time(st, val);
+		return adxl345_set_inact_time(st, val, val2);
 	default:
 		return -EINVAL;
 	}
@@ -1668,6 +1737,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
 			return ret;
 	}
 
+	if (FIELD_GET(ADXL345_INT_FREE_FALL, int_stat)) {
+		ret = iio_push_event(indio_dev,
+				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+							IIO_MOD_X_AND_Y_AND_Z,
+							IIO_EV_TYPE_MAG,
+							IIO_EV_DIR_FALLING),
+				     ts);
+		if (ret)
+			return ret;
+	}
+
 	if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
 		samples = adxl345_get_samples(st);
 		if (samples < 0)
@@ -1906,15 +1986,11 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		if (ret)
 			return ret;
 
-		ret = regmap_write(st->regmap, ADXL345_REG_TIME_INACT, 0x37);
-		if (ret)
-			return ret;
-
 		ret = regmap_write(st->regmap, ADXL345_REG_THRESH_ACT, 6);
 		if (ret)
 			return ret;
 
-		ret = regmap_write(st->regmap, ADXL345_REG_THRESH_INACT, 4);
+		ret = adxl345_set_inact_threshold(st, 4);
 		if (ret)
 			return ret;
 
-- 
2.39.5


