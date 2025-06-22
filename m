Return-Path: <linux-iio+bounces-20879-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E833BAE30A3
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 17:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FF3E188F3E4
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 15:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C03D20A5F1;
	Sun, 22 Jun 2025 15:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dC1mnQZ1"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FD11FFC7E;
	Sun, 22 Jun 2025 15:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750607425; cv=none; b=o4udmQ5h+db6GQ0hmeWqw/0O8HPgOUoCe8WWeeMCuoekbY23WF7xaco7EDyjaLU0UzlqQyo0hQ+CBzaooexD4SJmt2Yim18vFC5wb8ft2tPMJz8lQ7I6S7THX4S8oQ1gPV4jDgbJuUa+WC2gXYrmFYzb4CMECnhNNWsRHsJvzh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750607425; c=relaxed/simple;
	bh=B+2nO65ApKKPy8e7Ga2hlszF64aBJTf+8dYktop5uVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gptq74AutXrEQoYTJZexPyEJMJa7K/M/O4TGgvNjncKScc6cJ4alF193mJjOt3AJch+wgcl1a2AaQV+m2iSCWbhReFW/i9KWmiVBmv8OtO6OxyTylwXYnP41tV0nnF5xc+KHSbomhlDPxPPZXDltKNDCZ7elMmlJPq34SuyJ7TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dC1mnQZ1; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-607780f0793so675797a12.2;
        Sun, 22 Jun 2025 08:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750607421; x=1751212221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwdBygc9qVp9kulnWBDNSOpL5ulvrlGHjGtt+VSO4VQ=;
        b=dC1mnQZ1PS9VepGk/RhJlUiCalFvZ/Cftf6UnYR3vT73hDyy0/HDu7TM4N6HTFJxeA
         eXmlfVoh4Rmjr96xOisV1tgn3e4Uy5ylyTRpFLS4JRC2L9pmGbCcfol22j4VKeuS59kK
         vKf9qg3MMh8ELKn05F0hGzK+EzCa1DMEesqqA6MMuimzceiMdw4gyF32ohzuF3ZKRLJ8
         a30YkM/i8ujUXwNzE+W21+Z7wRimRo0BxdYhGEZIs5hQPTrXbfxPjJ/P1AR0yw+hsjrs
         oZfkr+jMi/ohKGHMNfYz4pe07CujayfWfxv8N2pD1cT8bOQbRlgGmMl1KPayzabWSHgg
         d4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750607421; x=1751212221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwdBygc9qVp9kulnWBDNSOpL5ulvrlGHjGtt+VSO4VQ=;
        b=nO9U7D1hXwglycmPdnf3nAI4Y4r93pT1fPt7geyCPLDWadrrj1rkCaPueRgXrm3+8J
         sXfAv8OWQyrC7CsJ78RjiXQPXsXiNAL42jzlYcs493QYRkiUet690HRz2EUsXLfsQuYB
         2X1tJd6t0IpNChhgfjHFE152m46hmYN0gO7IWq3B08YZy2HoH9IOBMoIQRKqAjE4PHrs
         cN5znI6s1eSEJJsre/5qYBv+HmRhxtojhCtcLCwB1akQq9ADnewQcEt5h49zNBKKxBuU
         yRlIqHuOayiXjdrfVK02ppJ3/dzngk6AbEB0dP0lrhxHYPA9PO8PEkb76+x2yx15IP0H
         ftVg==
X-Forwarded-Encrypted: i=1; AJvYcCVgobZiSNLG3AOX+MKxT+Dlf2AwfRb0dO/D7aktEJ0itfIJmKBXl3rwym0IbCvVMvFXnNYTRrhqpoMQ0/87@vger.kernel.org, AJvYcCXEt452b9fHYebDO42Ep29Ihc5dxsofoWsX+qPMR5Iv6GJ29w7dcn4fsAQTWhrPSLMgHlp7zOlTowY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLOmeuQOfCZZ7PDsyDTZrCZaE2lcH9vcekaw6rfnYDvln310yn
	ii0nOPkg9LqcqZvvabHF4WwQhENCCZ7FWL+3qys/Y7OwiLFzej1GJXnafHdnBQ==
X-Gm-Gg: ASbGncvDvvkvsc+nHTxGTavjgqqO+djxcizr9EkPgx2qflSQ1QAqGdm2wa7xeQihcso
	VohiTu6OaRrs7pqJXr6eBBf5ErzK38mNwpYlmdGolHMp9/+jbcI2Vr5JOYSYvoazSzxWWdrq2L8
	CLFZYtir0hff0VMTK9MEh+nUYwcAD7y/8htNLoPnr+kkfXbHK4PCYkvA8yMKXpC86xrPwhdldLA
	tQL1UQ8zsJEPKJkZRWtE+eCVEhyoPlvzRYAByLUot+2lR8vlBszd9zulFZQ8jwVHpLzISg084ZQ
	XyNS5S8RfrF4Fb+evyiIAxQx6PCfsBb9MRnSr72elWr7T/XaVpUI92g44AI5Cjvj/mAO78uUNl5
	mxSJDPk157oDgqDPmRYdgIdPophMqGVhf
X-Google-Smtp-Source: AGHT+IFgBbJg1VpU8mtqvVV7aE3oAEuJwY3NpmDGYDIyx4r6eC+OHOoi7OJWGH8i1ifpxr7RUcUXcQ==
X-Received: by 2002:a17:906:dc8d:b0:ad8:9372:870a with SMTP id a640c23a62f3a-ae0578e80f1mr294711566b.3.1750607420716;
        Sun, 22 Jun 2025 08:50:20 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053ecbd9esm552781966b.38.2025.06.22.08.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 08:50:20 -0700 (PDT)
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
Subject: [PATCH v10 6/7] iio: accel: adxl345: extend inactivity time for less than 1s
Date: Sun, 22 Jun 2025 15:50:09 +0000
Message-Id: <20250622155010.164451-7-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl345_core.c | 158 +++++++++++++++++++++----------
 1 file changed, 109 insertions(+), 49 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index c5a3dac5f938..f1f92635bc21 100644
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
@@ -86,6 +89,7 @@ enum adxl345_activity_type {
 	ADXL345_INACTIVITY,
 	ADXL345_ACTIVITY_AC,
 	ADXL345_INACTIVITY_AC,
+	ADXL345_INACTIVITY_FF,
 };
 
 static const unsigned int adxl345_act_int_reg[] = {
@@ -93,6 +97,7 @@ static const unsigned int adxl345_act_int_reg[] = {
 	[ADXL345_INACTIVITY] = ADXL345_INT_INACTIVITY,
 	[ADXL345_ACTIVITY_AC] = ADXL345_INT_ACTIVITY,
 	[ADXL345_INACTIVITY_AC] = ADXL345_INT_INACTIVITY,
+	[ADXL345_INACTIVITY_FF] = ADXL345_INT_FREE_FALL,
 };
 
 static const unsigned int adxl345_act_thresh_reg[] = {
@@ -100,6 +105,7 @@ static const unsigned int adxl345_act_thresh_reg[] = {
 	[ADXL345_INACTIVITY] = ADXL345_REG_THRESH_INACT,
 	[ADXL345_ACTIVITY_AC] = ADXL345_REG_THRESH_ACT,
 	[ADXL345_INACTIVITY_AC] = ADXL345_REG_THRESH_INACT,
+	[ADXL345_INACTIVITY_FF] = ADXL345_REG_THRESH_FF,
 };
 
 static const unsigned int adxl345_act_acdc_msk[] = {
@@ -107,6 +113,7 @@ static const unsigned int adxl345_act_acdc_msk[] = {
 	[ADXL345_INACTIVITY] = ADXL345_REG_INACT_ACDC_MSK,
 	[ADXL345_ACTIVITY_AC] = ADXL345_REG_ACT_ACDC_MSK,
 	[ADXL345_INACTIVITY_AC] = ADXL345_REG_INACT_ACDC_MSK,
+	[ADXL345_INACTIVITY_FF] = ADXL345_REG_NO_ACDC_MSK,
 };
 
 enum adxl345_odr {
@@ -189,6 +196,9 @@ struct adxl345_state {
 	u8 watermark;
 	u8 fifo_mode;
 
+	u8 inact_threshold;
+	u32 inact_time_ms;
+
 	u32 tap_duration_us;
 	u32 tap_latent_us;
 	u32 tap_window_us;
@@ -333,10 +343,29 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
 
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
 /**
  * adxl345_set_inact_time - Configure inactivity time explicitly or by ODR.
  * @st: The sensor state instance.
- * @val_s: A desired time value, between 0 and 255.
+ * @val_int: The inactivity time, integer part.
+ * @val_fract: The inactivity time, fractional part when val_int is 0.
  *
  * Inactivity time can be configured between 1 and 255 seconds. If a user sets
  * val_s to 0, a default inactivity time is calculated automatically (since 0 is
@@ -357,16 +386,18 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
  *
  * Return: 0 or error value.
  */
-static int adxl345_set_inact_time(struct adxl345_state *st, u32 val_s)
+static int adxl345_set_inact_time(struct adxl345_state *st, u32 val_int,
+				  u32 val_fract)
 {
 	int max_boundary = U8_MAX;
 	int min_boundary = 10;
-	unsigned int val = min(val_s, U8_MAX);
+	unsigned int val;
 	enum adxl345_odr odr;
 	unsigned int regval;
 	int ret;
 
-	if (val == 0) {
+	if (val_int == 0 && val_fract == 0) {
+		/* Generated inactivity time based on ODR */
 		ret = regmap_read(st->regmap, ADXL345_REG_BW_RATE, &regval);
 		if (ret)
 			return ret;
@@ -374,9 +405,31 @@ static int adxl345_set_inact_time(struct adxl345_state *st, u32 val_s)
 		odr = FIELD_GET(ADXL345_BW_RATE_MSK, regval);
 		val = clamp(max_boundary - adxl345_odr_tbl[odr][0],
 			    min_boundary, max_boundary);
+		st->inact_time_ms = MILLI * val;
+
+		/* Inactivity time in s */
+		return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
+	} else if (val_int == 0 && val_fract > 0) {
+		/* time < 1s, free-fall */
+
+		/*
+		 * Datasheet max. value is 255 * 5000 us = 1.275000 seconds.
+		 *
+		 * Recommended values between 100ms and 350ms (0x14 to 0x46)
+		 */
+		st->inact_time_ms = DIV_ROUND_UP(val_fract, MILLI);
+
+		return regmap_write(st->regmap, ADXL345_REG_TIME_FF,
+				    DIV_ROUND_CLOSEST(val_fract, 5));
+	} else if (val_int > 0) {
+		/* Time >= 1s, inactivity */
+		st->inact_time_ms = MILLI * val_int;
+
+		return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val_int);
 	}
 
-	return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
+	/* Do not support negative or wrong input. */
+	return -EINVAL;
 }
 
 /**
@@ -399,6 +452,9 @@ static int adxl345_is_act_inact_ac(struct adxl345_state *st,
 	bool coupling;
 	int ret;
 
+	if (type == ADXL345_INACTIVITY_FF)
+		return true;
+
 	ret = regmap_read(st->regmap, ADXL345_REG_ACT_INACT_CTRL, &regval);
 	if (ret)
 		return ret;
@@ -511,6 +567,9 @@ static int adxl345_is_act_inact_en(struct adxl345_state *st,
 		if (!en)
 			return false;
 		break;
+	case ADXL345_INACTIVITY_FF:
+		en = true;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -542,15 +601,20 @@ static int adxl345_set_act_inact_linkbit(struct adxl345_state *st,
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
 
-	inact_ac_en = adxl345_is_act_inact_en(st, ADXL345_INACTIVITY_AC);
-	if (inact_ac_en < 0)
-		return inact_ac_en;
+		inact_ac_en = adxl345_is_act_inact_en(st, ADXL345_INACTIVITY_AC);
+		if (inact_ac_en < 0)
+			return inact_ac_en;
+
+		inact_en = inact_en || inact_ac_en;
+	}
 
-	inact_en = inact_en || inact_ac_en;
 	act_en = act_en || act_ac_en;
 
 	return regmap_assign_bits(st->regmap, ADXL345_REG_POWER_CTL,
@@ -569,11 +633,15 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 
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
@@ -618,6 +686,9 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 		axis_ctrl = ADXL345_INACT_X_EN | ADXL345_INACT_Y_EN |
 				ADXL345_INACT_Z_EN;
 		break;
+	case ADXL345_INACTIVITY_FF:
+		axis_ctrl = ADXL345_ACT_INACT_NO_AXIS_EN;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -884,7 +955,7 @@ static int adxl345_set_odr(struct adxl345_state *st, enum adxl345_odr odr)
 		return ret;
 
 	/* update inactivity time by ODR */
-	return adxl345_set_inact_time(st, 0);
+	return adxl345_set_inact_time(st, 0, 0);
 }
 
 static int adxl345_find_range(struct adxl345_state *st, int val, int val2,
@@ -921,12 +992,6 @@ static int adxl345_set_range(struct adxl345_state *st, enum adxl345_range range)
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
@@ -937,6 +1002,7 @@ static int adxl345_set_range(struct adxl345_state *st, enum adxl345_range range)
 		/ adxl345_range_factor_tbl[range];
 	act_threshold = min(U8_MAX, max(1, act_threshold));
 
+	inact_threshold = st->inact_threshold;
 	inact_threshold = inact_threshold * adxl345_range_factor_tbl[range_old]
 		/ adxl345_range_factor_tbl[range];
 	inact_threshold = min(U8_MAX, max(1, inact_threshold));
@@ -946,8 +1012,7 @@ static int adxl345_set_range(struct adxl345_state *st, enum adxl345_range range)
 	if (ret)
 		return ret;
 
-	return regmap_write(st->regmap, adxl345_act_thresh_reg[ADXL345_INACTIVITY],
-			   inact_threshold);
+	return adxl345_set_inact_threshold(st, inact_threshold);
 }
 
 static int adxl345_read_avail(struct iio_dev *indio_dev,
@@ -1192,7 +1257,6 @@ static int adxl345_read_mag_value(struct adxl345_state *st,
 				  int *val, int *val2)
 {
 	unsigned int threshold;
-	unsigned int period;
 	int ret;
 
 	switch (info) {
@@ -1208,25 +1272,16 @@ static int adxl345_read_mag_value(struct adxl345_state *st,
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
@@ -1249,14 +1304,12 @@ static int adxl345_write_mag_value(struct adxl345_state *st,
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
@@ -1669,6 +1722,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
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
@@ -1907,15 +1971,11 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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


