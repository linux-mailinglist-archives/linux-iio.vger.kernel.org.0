Return-Path: <linux-iio+bounces-20396-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC88AD4575
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 00:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4D0A17D28B
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 22:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D658A28CF77;
	Tue, 10 Jun 2025 21:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfIY0Rvt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E93228AAE1;
	Tue, 10 Jun 2025 21:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749592798; cv=none; b=rIexOX1RoYbDnPdvscWRh8u/CBzp69hNa0WgoJ2JdH9dB97g6n3pcgxGPJpBkzdIg4TK/5/ou+KFpGZ88L6rQjzpNDVQstWWbcw8QjUHCoKBKs7IaOWAp1rZyVd41Fp0RsQ5HcZ2q2grdYhdeAFDpGU3g1m2unqwPUezrGoPZ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749592798; c=relaxed/simple;
	bh=zdf2o3GNT0PrZvxhGuy5bqYI3XGJGMj/MsOvR4fg08U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eLZIUKsc55yApWviE2/SifA8IJf5E4/hfQ8CFCfhb5OWneiMqTRqFSG1kwdkYCqI4pTXRmXnPD7ezy3dYDwpBv5FsenULD+CUiCQZDEW/h2LI7w014nlrc5WIVoqYWLr4cgr76zjjHiaBHSVPD3FwGuNjWT0Otn8Lfk8yVweCg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfIY0Rvt; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a528e301b0so790635f8f.1;
        Tue, 10 Jun 2025 14:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749592795; x=1750197595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNcLrTnvuT1Qe76HK2Tsx4xoyXpLEnvpzok27cKhlGs=;
        b=OfIY0Rvt6ARBWISqev1jYHeLny/eDQY495SmjTXBmip5AcfpG76JiXbiXb04nOT77q
         YcFstIO/rH7H2rTNGqNa5TCa77MrtUyhalZVfhA0QnP7xDAd3kBwpO0uCjgdx9YQ7a1n
         GrbHj25EktoRB4zbLBAe6NaEq5tTydbLFAdWIRaMYuelZ7gvD9iE43JkbYvgxgrEuP2q
         Un7W/u+b94wXbqAcYSPRqJrUE/Dm3nZZTbuZ0DlCvSCGA7w8WVMuD8PMeHAKQRidxj7/
         5LtO1aYrw7a8kQvG5y6IynIbeI8Uvj1EoSUDUCksiH2Zmx0/APqtPb8QvhVtnNCEVyFB
         ABjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749592795; x=1750197595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNcLrTnvuT1Qe76HK2Tsx4xoyXpLEnvpzok27cKhlGs=;
        b=Q6q+hbcM+ArHkdeZlLBNnVNEn7uNb4aBfI7z/56WuMPbuTC3CZaEHqBzwn/1tPAb62
         xXigQH+s+kMOs5TWi2DORYCimz473jTFwELtsj8DHbgUnPngcWB8XjdDLe+n/h1OIQaE
         ymujpO3CDl2KANuOECIAVzFi1IzU5BfbDmPuNHN5rArtEOgkeLpTlA443WlEJMQHD8Bz
         c61qqkR1c/LaaNbzNOlp+yzhciSzKkzlAsBtGxFv9L1JG4H3owKMIWfiv6yKYIv84EXu
         t52qB+xWADoEntItKMWn2n2wkE++2BhOfgWpC9TXarnqaOjtCi+TmucOw2dHiICnN7XP
         Pf4A==
X-Forwarded-Encrypted: i=1; AJvYcCW9d4PRhi3HE0epdWyEeDaebp1LvngVTOfxnJIWVm5mtEXhP2dpt6l6Rr1NVs+NP4mDd+Fk2Bb1CgjIelAa@vger.kernel.org, AJvYcCXNa2Q8o7GICfhSXYR6Mcx6rTWRvrHOh8paGeTfbmHg79lIPqLq2k7LFM3BMZVc7ZaYDzUp2TmjzpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz26/gwsJ4lREtOqLZiJ2mX+qVRbUIQIowXh7Mgy5sbwEUJ+b2p
	HWaQSUX3q91hfSnsLRcLN3xJjPp+6bwBeRm/dqscDTSLTnEVEQAn09nu
X-Gm-Gg: ASbGnct9cS3xJRHB6vRtS8QQT87oXiQPfW0LyGnVjuInVV4No0pyKirxJCw+y6gMF6M
	0Cs1bM9TZ55HrA1FDpmE+aPcvqBDgkW46jSirXv6fqhZNd7X7KnVhzQuLZ1JGWZRYmcv6BJZyLt
	s2cTnwyj8afm0MLBthH46s6UJED9BpAn7Llfl26uj/tN4u69VDfgrFN/LWtXRz+MSdS7Ad3Bpqo
	p1CRXOS3Bn2n21LfaVXHpSritHIA1xnYruFtEyk7pbdI4wQWTxRvtg7CN4OPWSmdd7SfB3grZlh
	yldCJbjhKeglH1WpyNI7TjyhdONI/nqKh8lKJ+pCOaBRxGhHz+iwnKCfhCRFL+PmSnyU+wZgZOp
	SKGDNyzM7Xc2QYECI/gRIR3ncMMYLqaZT
X-Google-Smtp-Source: AGHT+IEiW8tg7bjLO6DvY9j56OPoVKVgh2PcwkstE+NGubL4mWPgXzIyA1Z8e6dZ8p/rI9c6KKd0Aw==
X-Received: by 2002:a05:6000:2507:b0:3a4:f7d9:9617 with SMTP id ffacd0b85a97d-3a55864e245mr199312f8f.0.1749592794630;
        Tue, 10 Jun 2025 14:59:54 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53244f04dsm13312647f8f.73.2025.06.10.14.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 14:59:54 -0700 (PDT)
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
Subject: [PATCH v9 10/11] iio: accel: adxl345: extend inactivity time for less than 1s
Date: Tue, 10 Jun 2025 21:59:32 +0000
Message-Id: <20250610215933.84795-11-l.rubusch@gmail.com>
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

Inactivity event and free-fall event are actually the same type of sensor
events. Hence, inactivity detection using a period of 1 to 255s can be
extended to be used for lower periods than 1s for covering free-fall
detection.

When lower periods are defined, the driver automatically will setup
threshold and period on the free-fall register, while using the
inactivity threshold and period for periods above 1s. Using the
free-fall register, no link bit will be set, and therefore no auto-sleep
can be set in cases where also activity will be enabled.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 165 +++++++++++++++++++++----------
 1 file changed, 113 insertions(+), 52 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 6a4af559ad9e..7afc120b4a45 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -86,6 +86,7 @@ enum adxl345_activity_type {
 	ADXL345_INACTIVITY,
 	ADXL345_ACTIVITY_AC,
 	ADXL345_INACTIVITY_AC,
+	ADXL345_INACTIVITY_FF,
 };
 
 static const unsigned int adxl345_act_int_reg[] = {
@@ -93,6 +94,7 @@ static const unsigned int adxl345_act_int_reg[] = {
 	[ADXL345_INACTIVITY] = ADXL345_INT_INACTIVITY,
 	[ADXL345_ACTIVITY_AC] = ADXL345_INT_ACTIVITY,
 	[ADXL345_INACTIVITY_AC] = ADXL345_INT_INACTIVITY,
+	[ADXL345_INACTIVITY_FF] = ADXL345_INT_FREE_FALL,
 };
 
 static const unsigned int adxl345_act_thresh_reg[] = {
@@ -100,6 +102,7 @@ static const unsigned int adxl345_act_thresh_reg[] = {
 	[ADXL345_INACTIVITY] = ADXL345_REG_THRESH_INACT,
 	[ADXL345_ACTIVITY_AC] = ADXL345_REG_THRESH_ACT,
 	[ADXL345_INACTIVITY_AC] = ADXL345_REG_THRESH_INACT,
+	[ADXL345_INACTIVITY_FF] = ADXL345_REG_THRESH_FF,
 };
 
 static const unsigned int adxl345_act_acdc_msk[] = {
@@ -107,6 +110,7 @@ static const unsigned int adxl345_act_acdc_msk[] = {
 	[ADXL345_INACTIVITY] = ADXL345_REG_INACT_ACDC_MSK,
 	[ADXL345_ACTIVITY_AC] = ADXL345_REG_ACT_ACDC_MSK,
 	[ADXL345_INACTIVITY_AC] = ADXL345_REG_INACT_ACDC_MSK,
+	[ADXL345_INACTIVITY_FF] = 0x00,
 };
 
 enum adxl345_odr {
@@ -189,6 +193,9 @@ struct adxl345_state {
 	u8 watermark;
 	u8 fifo_mode;
 
+	u8 inact_threshold;
+	u32 inact_time_ms;
+
 	u32 tap_duration_us;
 	u32 tap_latent_us;
 	u32 tap_window_us;
@@ -333,12 +340,31 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
 
 /* act/inact */
 
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
- * Inactivity time can be configured between 1 and 255 sec. If a val_s of 0
+ * Inactivity time can be configured between 1 and 255 sec. If a val_s of 0.00
  * is configured by a user, then a default inactivity time will be computed.
  *
  * In such case, it should take power consumption into consideration. Thus it
@@ -355,16 +381,18 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
  *
  * Return: 0 or error value.
  */
-static int adxl345_set_inact_time(struct adxl345_state *st, u32 val_s)
+static int adxl345_set_inact_time(struct adxl345_state *st, u32 val_int,
+				  u32 val_fract)
 {
 	unsigned int max_boundary = 255;
 	unsigned int min_boundary = 10;
-	unsigned int val = min(val_s, max_boundary);
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
@@ -373,9 +401,41 @@ static int adxl345_set_inact_time(struct adxl345_state *st, u32 val_s)
 
 		val = (adxl345_odr_tbl[odr][0] > max_boundary)
 			? min_boundary : max_boundary -	adxl345_odr_tbl[odr][0];
+
+		st->inact_time_ms = MILLI * val;
+
+		/* Inactivity time in s */
+		ret = regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
+		if (ret)
+			return ret;
+
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
+		ret = regmap_write(st->regmap, ADXL345_REG_TIME_FF,
+				   DIV_ROUND_CLOSEST(val_fract, 5));
+		if (ret)
+			return ret;
+	} else if (val_int > 0) {
+		/* Time >= 1s, inactivity */
+		st->inact_time_ms = MILLI * val_int;
+
+		ret = regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val_int);
+		if (ret)
+			return ret;
+	} else {
+		/* Do not support negative or wrong input. */
+		return -EINVAL;
 	}
 
-	return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
+	return 0;
 }
 
 /**
@@ -398,6 +458,9 @@ static int adxl345_is_act_inact_ac(struct adxl345_state *st,
 	bool coupling;
 	int ret;
 
+	if (type == ADXL345_INACTIVITY_FF)
+		return 1;
+
 	ret = regmap_read(st->regmap, ADXL345_REG_ACT_INACT_CTRL, &regval);
 	if (ret)
 		return ret;
@@ -499,6 +562,9 @@ static int adxl345_is_act_inact_en(struct adxl345_state *st,
 			FIELD_GET(ADXL345_INACT_Y_EN, axis_ctrl) |
 			FIELD_GET(ADXL345_INACT_Z_EN, axis_ctrl);
 		break;
+	case ADXL345_INACTIVITY_FF:
+		en = true;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -537,15 +603,19 @@ static int adxl345_set_act_inact_linkbit(struct adxl345_state *st,
 
 	act_en = act_en || act_ac_en;
 
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
 
-	inact_en = inact_en || inact_ac_en;
+		inact_en = inact_en || inact_ac_en;
+	}
 
 	en = en && act_en && inact_en;
 
@@ -559,7 +629,6 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 				    bool cmd_en)
 {
 	bool en;
-	unsigned int inact_time_s;
 	unsigned int threshold;
 	u32 axis_ctrl;
 	int ret;
@@ -582,14 +651,16 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 	if (type == ADXL345_ACTIVITY || type == ADXL345_ACTIVITY_AC) {
 		axis_ctrl = ADXL345_ACT_X_EN | ADXL345_ACT_Y_EN |
 				ADXL345_ACT_Z_EN;
+
+		ret = regmap_read(st->regmap, adxl345_act_thresh_reg[type], &threshold);
+		if (ret)
+			return ret;
 	} else {
 		axis_ctrl = ADXL345_INACT_X_EN | ADXL345_INACT_Y_EN |
 				ADXL345_INACT_Z_EN;
-	}
 
-	ret = regmap_read(st->regmap, adxl345_act_thresh_reg[type], &threshold);
-	if (ret)
-		return ret;
+		threshold = st->inact_threshold;
+	}
 
 	ret = regmap_assign_bits(st->regmap, ADXL345_REG_ACT_INACT_CTRL,
 				 axis_ctrl, cmd_en);
@@ -610,12 +681,9 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 		break;
 	case ADXL345_INACTIVITY:
 	case ADXL345_INACTIVITY_AC:
-		ret = regmap_read(st->regmap, ADXL345_REG_TIME_INACT, &inact_time_s);
-		if (ret)
-			return ret;
-
+	case ADXL345_INACTIVITY_FF:
 		en = FIELD_GET(ADXL345_REG_INACT_AXIS_MSK, axis_ctrl) &&
-			threshold && inact_time_s;
+			threshold && st->inact_time_ms;
 		break;
 	default:
 		return -EINVAL;
@@ -873,7 +941,7 @@ static int adxl345_set_odr(struct adxl345_state *st, enum adxl345_odr odr)
 		return ret;
 
 	/* update inactivity time by ODR */
-	return adxl345_set_inact_time(st, 0);
+	return adxl345_set_inact_time(st, 0, 0);
 }
 
 static int adxl345_find_range(struct adxl345_state *st, int val, int val2,
@@ -910,12 +978,6 @@ static int adxl345_set_range(struct adxl345_state *st, enum adxl345_range range)
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
@@ -926,6 +988,7 @@ static int adxl345_set_range(struct adxl345_state *st, enum adxl345_range range)
 		/ adxl345_range_factor_tbl[range];
 	act_threshold = min(U8_MAX, max(1, act_threshold));
 
+	inact_threshold = st->inact_threshold;
 	inact_threshold = inact_threshold * adxl345_range_factor_tbl[range_old]
 		/ adxl345_range_factor_tbl[range];
 	inact_threshold = min(U8_MAX, max(1, inact_threshold));
@@ -935,8 +998,7 @@ static int adxl345_set_range(struct adxl345_state *st, enum adxl345_range range)
 	if (ret)
 		return ret;
 
-	return regmap_write(st->regmap, adxl345_act_thresh_reg[ADXL345_INACTIVITY],
-			   inact_threshold);
+	return adxl345_set_inact_threshold(st, inact_threshold);
 }
 
 static int adxl345_read_avail(struct iio_dev *indio_dev,
@@ -1183,7 +1245,7 @@ static int adxl345_read_mag_value(struct adxl345_state *st,
 				  enum iio_event_info info,
 				  int *val, int *val2)
 {
-	unsigned int act_threshold, inact_threshold;
+	unsigned int act_threshold;
 	int ret;
 
 	switch (info) {
@@ -1199,22 +1261,16 @@ static int adxl345_read_mag_value(struct adxl345_state *st,
 			*val2 = MICRO;
 			return IIO_VAL_FRACTIONAL;
 		case IIO_EV_DIR_FALLING:
-			ret = regmap_read(st->regmap,
-					  adxl345_act_thresh_reg[type_inact],
-					  &inact_threshold);
-			if (ret)
-				return ret;
-			*val = 62500 * inact_threshold;
+			*val = 62500 * st->inact_threshold;
 			*val2 = MICRO;
 			return IIO_VAL_FRACTIONAL;
 		default:
 			return -EINVAL;
 		}
 	case IIO_EV_INFO_PERIOD:
-		ret = regmap_read(st->regmap,
-				  ADXL345_REG_TIME_INACT,
-				  val);
-		return IIO_VAL_INT;
+		*val = st->inact_time_ms;
+		*val2 = MILLI;
+		return IIO_VAL_FRACTIONAL;
 	default:
 		return -EINVAL;
 	}
@@ -1239,14 +1295,12 @@ static int adxl345_write_mag_value(struct adxl345_state *st,
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
@@ -1657,6 +1711,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
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
@@ -1888,15 +1953,11 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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


