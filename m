Return-Path: <linux-iio+bounces-21267-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4E3AF65DE
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 01:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4A0F524638
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 23:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8AD2F7CF9;
	Wed,  2 Jul 2025 23:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQVGKjuj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416D52F6F98;
	Wed,  2 Jul 2025 23:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751497430; cv=none; b=qQ4kxUWFgx7SGgzb0nwL+qtGwygj7oWUlj1ffSNuhcGXAtTTexueuNedxeZ9clM+pNbiAn0AqROcXi2RpPhr90y3S6pdlJ2mDr9AUe1u+f/J/kEPqbb2MvoiEglAXyBSE2KqUHxClINN8h7FnMj+pCb3wtkhWA4ucvNIJadK6Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751497430; c=relaxed/simple;
	bh=s+C0yL1hXzubu2/nbnuUG6U6nRsLcXLdwHincapmv8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hpi9uBI6FyN2Q7pvtt1SglaTX1AqBr7rn66JCYGlayIDTYXQvrQdRztRBVU2t/3ichIdYV8b33zBkEBfPksIu8aovXA0FNsqDYtSv6JDBsKZ4F5wvmqTNngkq8mr7GNCzFrGDKZwTeU2eYlA9iRVbqJokCG+HJe3NYGQsCj3Aug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQVGKjuj; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-606a269d440so1563375a12.2;
        Wed, 02 Jul 2025 16:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751497427; x=1752102227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZDY8jLX7yIHyfhWXatG/QVlYNUsLcUkgMuRqMMKogY=;
        b=nQVGKjuj8OjPHDjGPLEUbPJYWFX9Joq5RCMbDKNhoUGVbk9jL2NaAcKwf81o6mnugo
         Zz/Iq/YCjwQtfPhROLbWrLvF0ZOLfjhs3k1pVJnc42Yy6SSPu6xgLk5W6gQLQ0gcqWoj
         BxTjLD1ey7tDP0f5qkPSVjr+rU/3PoSG0RoE/HEfyjRQ8Khc9QU63GlbMEJYujUcOsJW
         qCXe47uPUzxEx9f5egey7z5odB+q9bdc2/TDEH2uw78a7zY+J2DGoUU3r8N5tbudFn5K
         H2Qn5+XIdLjX9r0l3DZTfP+vJ9y/DEb3It6kN8ZZajj6E4/wzq9miSvwTdBAdJwLhuYQ
         g1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497427; x=1752102227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DZDY8jLX7yIHyfhWXatG/QVlYNUsLcUkgMuRqMMKogY=;
        b=xCJ0Pgq6v4/yyPiKJxTYI0ysjkJ79JugD8xRqD9UD5P2qneKXzK3fy6yDItbSTyk6O
         XX2ycOdZ8lkRaJDn2VvEgM8u13DLGvmTiPNRbwLkLyvDp34v4mqi8W6VB3HZKS5Qzepq
         I2nJnd9mYe0oAfmNQTqdXqmhXlQ6Jo6zLSfghKvfegQqK+laH7p9lW1rdKtrCCNSUpTa
         oAMk5FSdF8bfGtc2ZavZUBDPucIKmUzPD8ys9QoQpHGeWg4otF0El/2q1fxQma3e0ZVu
         JmQdGvkGwnnarjygzxnWCLPhTssTDVHd6LWSgv5b+K6lyZIjQ6XecKnyktGiNzyi28rs
         1cbA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ7fNZrLKzPSZaGRpm9Bo2LZ3BG3A3EiNR/c/1Aaqb87F2U2HVSg/EhADkJ9mXF6pGr8j6fQuCp/g=@vger.kernel.org, AJvYcCXeubnhJUIWq/5uF6Lschzz4dXsnX3XEIqAQajIGpKuq6SRLT4c3Ogx6OclEJWEs3uLmnZc7Vgvt4FH3xpo@vger.kernel.org
X-Gm-Message-State: AOJu0YzFppJWZWRIwKi3QEa2WzikWCiRzEfBf8woQMpmi73QyTwZ1035
	gUOROVs0bkPxb28Sz+XYBOTg93BA5EE79Cc2OdnShYj772Zv1evCrcbUep5+jA==
X-Gm-Gg: ASbGncs7pCBLeeMe7Wz/1v86WyZ5qgqelpYpzpr527G2dFhW34djLUJ31vVVMMDuIJX
	gHUuP81nEOSnSuHjwzAoYUrp4OeSYjk1V9yRrlzVM2/LxFb8UngxtPdJBrJwZ3dyWyf7SL2YfK0
	ofCCCreZsvVxzDAkaWk86EtgnisDHOO8D08XRjP+po93GrOFv0uUnav0PHTrDABDSKMaAZUISmD
	MaUtOwN3jfsPIp4vMQTutG27+MsqiJmug+VVDucOdZBO1MUXm9+ao64brqw550DFMb8jlvqb4yO
	leOfNcBtSM0y1JnNKWVtBhVEGPq7giRnWweN/ngjbncwoF10r7sYnFI49CjWAX3cc8oIGUOZx6h
	p4DQdogAyGQUdlFPTs5x+p8j1ls6prlO/
X-Google-Smtp-Source: AGHT+IHIN88VU1mwRV0L8bi40hMCRkMIx/OwlCCCnwoljUwi2PoJ3thzEpuuVI9+SjCK0tqbS/MhBA==
X-Received: by 2002:a05:6402:4311:b0:606:e469:2532 with SMTP id 4fb4d7f45d1cf-60e7454922dmr106961a12.10.1751497426434;
        Wed, 02 Jul 2025 16:03:46 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c8319e706sm10031469a12.47.2025.07.02.16.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:03:45 -0700 (PDT)
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
Subject: [PATCH v11 6/8] iio: accel: adxl345: extend inactivity time for less than 1s
Date: Wed,  2 Jul 2025 23:03:13 +0000
Message-Id: <20250702230315.19297-7-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl345_core.c | 201 +++++++++++++++++++++----------
 1 file changed, 139 insertions(+), 62 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 7038a4effd08..614d29e3ed2e 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -40,12 +40,15 @@
 #define ADXL345_REG_INACT_AXIS_MSK	GENMASK(2, 0)
 #define ADXL345_REG_ACT_ACDC_MSK	BIT(7)
 #define ADXL345_REG_INACT_ACDC_MSK	BIT(3)
+#define ADXL345_REG_NO_ACDC_MSK		0x00
 #define ADXL345_POWER_CTL_INACT_MSK	(ADXL345_POWER_CTL_AUTO_SLEEP | ADXL345_POWER_CTL_LINK)
 
 #define ADXL345_TAP_Z_EN		BIT(0)
 #define ADXL345_TAP_Y_EN		BIT(1)
 #define ADXL345_TAP_X_EN		BIT(2)
 
+#define ADXL345_ACT_INACT_NO_AXIS_EN	0x00
+
 #define ADXL345_INACT_Z_EN		BIT(0)
 #define ADXL345_INACT_Y_EN		BIT(1)
 #define ADXL345_INACT_X_EN		BIT(2)
@@ -88,6 +91,7 @@ enum adxl345_activity_type {
 	ADXL345_INACTIVITY,
 	ADXL345_ACTIVITY_AC,
 	ADXL345_INACTIVITY_AC,
+	ADXL345_INACTIVITY_FF,
 };
 
 static const unsigned int adxl345_act_int_reg[] = {
@@ -95,6 +99,7 @@ static const unsigned int adxl345_act_int_reg[] = {
 	[ADXL345_INACTIVITY] = ADXL345_INT_INACTIVITY,
 	[ADXL345_ACTIVITY_AC] = ADXL345_INT_ACTIVITY,
 	[ADXL345_INACTIVITY_AC] = ADXL345_INT_INACTIVITY,
+	[ADXL345_INACTIVITY_FF] = ADXL345_INT_FREE_FALL,
 };
 
 static const unsigned int adxl345_act_thresh_reg[] = {
@@ -102,6 +107,7 @@ static const unsigned int adxl345_act_thresh_reg[] = {
 	[ADXL345_INACTIVITY] = ADXL345_REG_THRESH_INACT,
 	[ADXL345_ACTIVITY_AC] = ADXL345_REG_THRESH_ACT,
 	[ADXL345_INACTIVITY_AC] = ADXL345_REG_THRESH_INACT,
+	[ADXL345_INACTIVITY_FF] = ADXL345_REG_THRESH_FF,
 };
 
 static const unsigned int adxl345_act_acdc_msk[] = {
@@ -109,6 +115,7 @@ static const unsigned int adxl345_act_acdc_msk[] = {
 	[ADXL345_INACTIVITY] = ADXL345_REG_INACT_ACDC_MSK,
 	[ADXL345_ACTIVITY_AC] = ADXL345_REG_ACT_ACDC_MSK,
 	[ADXL345_INACTIVITY_AC] = ADXL345_REG_INACT_ACDC_MSK,
+	[ADXL345_INACTIVITY_FF] = ADXL345_REG_NO_ACDC_MSK,
 };
 
 enum adxl345_odr {
@@ -191,6 +198,9 @@ struct adxl345_state {
 	u8 watermark;
 	u8 fifo_mode;
 
+	u8 inact_threshold;
+	u32 inact_time_ms;
+
 	u32 tap_duration_us;
 	u32 tap_latent_us;
 	u32 tap_window_us;
@@ -335,10 +345,72 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
 
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
@@ -359,26 +431,24 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
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
@@ -401,6 +471,9 @@ static int adxl345_is_act_inact_ac(struct adxl345_state *st,
 	bool coupling;
 	int ret;
 
+	if (type == ADXL345_INACTIVITY_FF)
+		return true;
+
 	ret = regmap_read(st->regmap, ADXL345_REG_ACT_INACT_CTRL, &regval);
 	if (ret)
 		return ret;
@@ -509,6 +582,9 @@ static int adxl345_is_act_inact_en(struct adxl345_state *st,
 		if (!en)
 			return false;
 		break;
+	case ADXL345_INACTIVITY_FF:
+		en = true;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -541,15 +617,20 @@ static int adxl345_set_act_inact_linkbit(struct adxl345_state *st,
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
@@ -568,11 +649,15 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 
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
@@ -615,6 +700,9 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 	case ADXL345_INACTIVITY_AC:
 		axis_ctrl = ADXL345_INACT_XYZ_EN;
 		break;
+	case ADXL345_INACTIVITY_FF:
+		axis_ctrl = ADXL345_ACT_INACT_NO_AXIS_EN;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -881,7 +969,7 @@ static int adxl345_set_odr(struct adxl345_state *st, enum adxl345_odr odr)
 		return ret;
 
 	/* update inactivity time by ODR */
-	return adxl345_set_inact_time(st, 0);
+	return adxl345_set_inact_time(st, 0, 0);
 }
 
 static int adxl345_find_range(struct adxl345_state *st, int val, int val2,
@@ -918,12 +1006,6 @@ static int adxl345_set_range(struct adxl345_state *st, enum adxl345_range range)
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
@@ -934,6 +1016,7 @@ static int adxl345_set_range(struct adxl345_state *st, enum adxl345_range range)
 		/ adxl345_range_factor_tbl[range];
 	act_threshold = min(U8_MAX, max(1, act_threshold));
 
+	inact_threshold = st->inact_threshold;
 	inact_threshold = inact_threshold * adxl345_range_factor_tbl[range_old]
 		/ adxl345_range_factor_tbl[range];
 	inact_threshold = min(U8_MAX, max(1, inact_threshold));
@@ -943,8 +1026,7 @@ static int adxl345_set_range(struct adxl345_state *st, enum adxl345_range range)
 	if (ret)
 		return ret;
 
-	return regmap_write(st->regmap, adxl345_act_thresh_reg[ADXL345_INACTIVITY],
-			   inact_threshold);
+	return adxl345_set_inact_threshold(st, inact_threshold);
 }
 
 static int adxl345_read_avail(struct iio_dev *indio_dev,
@@ -1189,7 +1271,6 @@ static int adxl345_read_mag_value(struct adxl345_state *st,
 				  int *val, int *val2)
 {
 	unsigned int threshold;
-	unsigned int period;
 	int ret;
 
 	switch (info) {
@@ -1205,25 +1286,16 @@ static int adxl345_read_mag_value(struct adxl345_state *st,
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
@@ -1246,14 +1318,12 @@ static int adxl345_write_mag_value(struct adxl345_state *st,
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
@@ -1666,6 +1736,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
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
@@ -1904,15 +1985,11 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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


