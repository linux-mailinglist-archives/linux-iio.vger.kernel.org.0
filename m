Return-Path: <linux-iio+bounces-20394-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B30AD4570
	for <lists+linux-iio@lfdr.de>; Wed, 11 Jun 2025 00:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8B14189953A
	for <lists+linux-iio@lfdr.de>; Tue, 10 Jun 2025 22:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DF928B4FB;
	Tue, 10 Jun 2025 21:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXz7L+yP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70317284B5F;
	Tue, 10 Jun 2025 21:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749592796; cv=none; b=nN7Uj8VJaqk/ssa5pSFnCuYJI2ptXfDnTfdbBDYLk00yyERsSIHyUD+xSCHA3uGuVPmCTBJ8DYD748KOpIxzr0YX7+tLmwRrc6goIedhhFMsSKevX44WYLZRPxJtQLRqq04wQoliDl2a0bzUVUDOfWxxNTqUWOCSxtKtTU4ia0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749592796; c=relaxed/simple;
	bh=jdy5l0MnZlu8kyfiZl4nOPTBPnHnbBvRA7qN16pHvd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K6YyhgJPsbmoRTwUia5M4+pNvPHWn1gtmD8zqjzPf9xmKCh01bMh5q6UxReO08V0ZATqOMU02FG9YeuiB30eU3JDgrl52nQNmKLaGTYbxLGO81IweQDEp33MsGxuKy3TJ7tLrYhnYECRO342U6C1U4GVER4AqxkyKCFYpSRLvhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXz7L+yP; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a52878d37aso1012026f8f.2;
        Tue, 10 Jun 2025 14:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749592793; x=1750197593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YMcbhaYsBJDy79eUfY5SGgotLclNWTNMFqNoTRNhww=;
        b=GXz7L+yPag9/McIqHiRpiEDGZf3ZtlLlYBM7PCtw8R+LJqUdaqGG6s+XWnDxeNNPN8
         k9DCpe35xQ41e4npb5EryRdyqOo1pc0pa0lzymGNS9kZDv/88+O3CYlGJG2Bl/N2R2Bw
         extANQO8edInwvuv+lH+/Rr2qyvjRwe3PCZG001xLX3efPL/5vWMTV7FrD+LwUu1mqiO
         h7KH9X5rk3AZHKZnive0/dVND577u5NDGFvkp9OMyufgmonuGQOGbMCpgjlkWsS+8EVA
         VBmHLA54Tdh7nP1YZwLiRboV5NVzuXByke41uEdSUnILSKEVJP1tUi9yLCR3MxwDmlIy
         5G9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749592793; x=1750197593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YMcbhaYsBJDy79eUfY5SGgotLclNWTNMFqNoTRNhww=;
        b=lmHxlGJzKZnhRGq+EB7zrMFNbEgvu1Ey3KU2QWy1aX7ar7Q3SYvEBmDSeIhuH/k9Bl
         eclRc49q94Ts0zHbJ8GvuzAgR4QdO9LINnn7FHvMxu7DAsrHztRf+GRkQ4ehzfTwhqLh
         zrDUFCefwhN3CMNhJuHkiYtbuCbzUEDX+aa73Mqo8fCPsfwpYcxZTgN/TfA0uM+vsygJ
         4r1YzNkeW2GjJv7brTJ8u0TgAPfvY26J8IJHM4BGUgGAFYoNgNlEm5JEWMxeVuxctSXP
         cB+sUogwBtV+g3TIa9PZ97SfI+uwvW3WtwWoEahdj9CO3NTpCK5yixUKdM6xYEeeONEK
         KzAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtObbsUycTS2/eKvE1CMgK/4usucIoZIWKEp0uBm9gvs4zCzUld5xHXw2WrdnhCfE/GC+lvzg1NWo=@vger.kernel.org, AJvYcCVgiAqiFuZTaGuX2sFoWJg1sRlLzFulkX1ig4SBqcjwJQuYhaylsreIQiTG3akda88bhTYKbDwtaJbXlHO5@vger.kernel.org
X-Gm-Message-State: AOJu0YxAwsPrbUFTrJoMdAoPtZDvCZ2BXEciQnoI+nDz6SuBW2SRkY9R
	nNWL95ZEqBVzA++E5Ig6/Q1kPNDhB1sbnanUzZPLZcIGQ87QeDnicv1L
X-Gm-Gg: ASbGnct3PPNHBtCIfn/SCb/m2cJCEVmWpXWl7oTOIKOy1MZfxZzbkCYiOuDBOSjzQg3
	+715ndBFMi0xnX3b49TCpt9lqf7bp8hXcdglYFC+xYyYvZqOKJkxb5zN/9skN7LhkKslfyynquP
	qkd7ax1n0qwZg151nIUBYgDSSpIWOgF+cN2+3WgPhX33l/imHsss9PKWP1g9hdV2jxZ85MUR24y
	ORZ7BVzDLcZBgixT8gzgOG0vK4CJr4UaRPekHMHQWot5q/yRUTGwXlOh0D9o5nXtueObKxdL5aZ
	/Zmd+j5KFsPE1BuG/DI9U2AQ+ikoDk70SnR851sq1lYAw3cSYVAIOKN3zZACb5nn7J4OlTPZ7yY
	m//6ap8rt/22JF5VSdhHH4G4+Y7gk89BpKBaTj/tFS5k=
X-Google-Smtp-Source: AGHT+IFeMIC3wVB7KtB2p1XAhjze6E2Y2BTMZadsUcQbE+QtA0iRXAlCFyM5MGO7wcBNHhlHiRySdw==
X-Received: by 2002:a05:6000:3112:b0:3a4:eeeb:7e70 with SMTP id ffacd0b85a97d-3a5586c5cafmr186441f8f.4.1749592792617;
        Tue, 10 Jun 2025 14:59:52 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53244f04dsm13312647f8f.73.2025.06.10.14.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 14:59:52 -0700 (PDT)
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
Subject: [PATCH v9 08/11] iio: accel: adxl345: add inactivity feature
Date: Tue, 10 Jun 2025 21:59:30 +0000
Message-Id: <20250610215933.84795-9-l.rubusch@gmail.com>
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

Add the inactivity feature of the sensor to the driver. When activity
and inactivity are enabled, a link bit will be set linking activity and
inactivity handling. Additionally, the auto-sleep mode will be enabled.
Due to the link bit the sensor is going to auto-sleep when inactivity
was detected.

Inactivity detection needs a threshold to be configured and a period of
time in seconds. After, it will transition to inactivity state, if
measurements stay below inactivity threshold.

When a ODR is configured the period for inactivity is adjusted with a
corresponding reasonable default value, in order to have higher
frequencies, lower inactivity times, and lower sample frequency but
give more time until inactivity. Both with reasonable upper and lower
boundaries, since many of the sensor's features (e.g. auto-sleep) will
need to operate between 12.5 Hz and 400 Hz. This is a default setting
when actively changing sample frequency, explicitly setting the time
until inactivity will overwrite the default.

Similarly, setting the g-range will provide a default value for the
activity and inactivity thresholds. Both are implicit defaults, but
equally can be overwritten to be explicitly configured.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 238 +++++++++++++++++++++++++++++--
 1 file changed, 227 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 04b9f155872f..1670315ebd63 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -37,11 +37,17 @@
 #define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3)
 #define ADXL345_REG_TAP_SUPPRESS	BIT(3)
 #define ADXL345_REG_ACT_AXIS_MSK	GENMASK(6, 4)
+#define ADXL345_REG_INACT_AXIS_MSK	GENMASK(2, 0)
+#define ADXL345_POWER_CTL_INACT_MSK	(ADXL345_POWER_CTL_AUTO_SLEEP | ADXL345_POWER_CTL_LINK)
 
 #define ADXL345_TAP_Z_EN		BIT(0)
 #define ADXL345_TAP_Y_EN		BIT(1)
 #define ADXL345_TAP_X_EN		BIT(2)
 
+#define ADXL345_INACT_Z_EN		BIT(0)
+#define ADXL345_INACT_Y_EN		BIT(1)
+#define ADXL345_INACT_X_EN		BIT(2)
+
 #define ADXL345_ACT_Z_EN		BIT(4)
 #define ADXL345_ACT_Y_EN		BIT(5)
 #define ADXL345_ACT_X_EN		BIT(6)
@@ -72,14 +78,17 @@ static const unsigned int adxl345_tap_time_reg[] = {
 /* activity/inactivity */
 enum adxl345_activity_type {
 	ADXL345_ACTIVITY,
+	ADXL345_INACTIVITY,
 };
 
 static const unsigned int adxl345_act_int_reg[] = {
 	[ADXL345_ACTIVITY] = ADXL345_INT_ACTIVITY,
+	[ADXL345_INACTIVITY] = ADXL345_INT_INACTIVITY,
 };
 
 static const unsigned int adxl345_act_thresh_reg[] = {
 	[ADXL345_ACTIVITY] = ADXL345_REG_THRESH_ACT,
+	[ADXL345_INACTIVITY] = ADXL345_REG_THRESH_INACT,
 };
 
 enum adxl345_odr {
@@ -147,6 +156,14 @@ static const int adxl345_fullres_range_tbl[][2] = {
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
@@ -213,10 +230,29 @@ enum adxl345_chans {
 	chan_x, chan_y, chan_z,
 };
 
+static const struct iio_event_spec adxl345_fake_chan_events[] = {
+	{
+		/* inactivity */
+		.type = IIO_EV_TYPE_MAG,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_PERIOD),
+	},
+};
+
 static const struct iio_chan_spec adxl345_channels[] = {
 	ADXL345_CHANNEL(0, chan_x, X),
 	ADXL345_CHANNEL(1, chan_y, Y),
 	ADXL345_CHANNEL(2, chan_z, Z),
+	{
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_X_AND_Y_AND_Z,
+		.scan_index = -1, /* Fake channel */
+		.event_spec = adxl345_fake_chan_events,
+		.num_event_specs = ARRAY_SIZE(adxl345_fake_chan_events),
+	},
 };
 
 static const unsigned long adxl345_scan_masks[] = {
@@ -264,6 +300,51 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
 
 /* act/inact */
 
+/**
+ * adxl345_set_inact_time - Configure inactivity time explicitly or by ODR.
+ * @st: The sensor state instance.
+ * @val_s: A desired time value, between 0 and 255.
+ *
+ * Inactivity time can be configured between 1 and 255 sec. If a val_s of 0
+ * is configured by a user, then a default inactivity time will be computed.
+ *
+ * In such case, it should take power consumption into consideration. Thus it
+ * shall be shorter for higher frequencies and longer for lower frequencies.
+ * Hence, frequencies above 255 Hz shall default to 10 s and frequencies below
+ * 10 Hz shall result in 255 s to detect inactivity.
+ *
+ * The approach simply subtracts the pre-decimal figure of the configured
+ * sample frequency from 255 s to compute inactivity time [s]. Sub-Hz are thus
+ * ignored in this estimation. The recommended ODRs for various features
+ * (activity/inactivity, sleep modes, free fall, etc.) lie between 12.5 Hz and
+ * 400 Hz, thus higher or lower frequencies will result in the boundary
+ * defaults or need to be explicitly specified via val_s.
+ *
+ * Return: 0 or error value.
+ */
+static int adxl345_set_inact_time(struct adxl345_state *st, u32 val_s)
+{
+	unsigned int max_boundary = 255;
+	unsigned int min_boundary = 10;
+	unsigned int val = min(val_s, max_boundary);
+	enum adxl345_odr odr;
+	unsigned int regval;
+	int ret;
+
+	if (val == 0) {
+		ret = regmap_read(st->regmap, ADXL345_REG_BW_RATE, &regval);
+		if (ret)
+			return ret;
+
+		odr = FIELD_GET(ADXL345_BW_RATE_MSK, regval);
+
+		val = (adxl345_odr_tbl[odr][0] > max_boundary)
+			? min_boundary : max_boundary -	adxl345_odr_tbl[odr][0];
+	}
+
+	return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
+}
+
 static int adxl345_is_act_inact_en(struct adxl345_state *st,
 				   enum adxl345_activity_type type)
 {
@@ -282,6 +363,11 @@ static int adxl345_is_act_inact_en(struct adxl345_state *st,
 			FIELD_GET(ADXL345_ACT_Y_EN, axis_ctrl) |
 			FIELD_GET(ADXL345_ACT_Z_EN, axis_ctrl);
 		break;
+	case ADXL345_INACTIVITY:
+		en = FIELD_GET(ADXL345_INACT_X_EN, axis_ctrl) |
+			FIELD_GET(ADXL345_INACT_Y_EN, axis_ctrl) |
+			FIELD_GET(ADXL345_INACT_Z_EN, axis_ctrl);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -302,22 +388,25 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 				    bool cmd_en)
 {
 	bool en;
+	unsigned int inact_time_s;
 	unsigned int threshold;
 	u32 axis_ctrl;
+	int act_en, inact_en;
 	int ret;
 
+	/* Start configuring the sensor registers */
+	ret = adxl345_set_measure_en(st, false);
+	if (ret)
+		return ret;
+
 	if (type == ADXL345_ACTIVITY) {
 		axis_ctrl = ADXL345_ACT_X_EN | ADXL345_ACT_Y_EN |
 				ADXL345_ACT_Z_EN;
 	} else {
-		axis_ctrl = 0x00;
+		axis_ctrl = ADXL345_INACT_X_EN | ADXL345_INACT_Y_EN |
+				ADXL345_INACT_Z_EN;
 	}
 
-	/* Start configuring the sensor registers */
-	ret = adxl345_set_measure_en(st, false);
-	if (ret)
-		return ret;
-
 	ret = regmap_assign_bits(st->regmap, ADXL345_REG_ACT_INACT_CTRL,
 				 axis_ctrl, cmd_en);
 	if (ret)
@@ -334,12 +423,37 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 		en = FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, axis_ctrl) &&
 			threshold;
 		break;
+	case ADXL345_INACTIVITY:
+		ret = regmap_read(st->regmap, ADXL345_REG_TIME_INACT, &inact_time_s);
+		if (ret)
+			return ret;
+
+		en = FIELD_GET(ADXL345_REG_INACT_AXIS_MSK, axis_ctrl) &&
+			threshold && inact_time_s;
+		break;
 	default:
 		return -EINVAL;
 	}
 
 	ret = regmap_assign_bits(st->regmap, ADXL345_REG_INT_ENABLE,
-				 adxl345_act_int_reg[type], cmd_en && en);
+				 adxl345_act_int_reg[type], cmd_en);
+	if (ret)
+		return ret;
+
+	/* Set sleep and link bit when ACT and INACT are enabled. */
+	act_en = adxl345_is_act_inact_en(st, ADXL345_ACTIVITY);
+	if (act_en < 0)
+		return act_en;
+
+	inact_en = adxl345_is_act_inact_en(st, ADXL345_INACTIVITY);
+	if (inact_en < 0)
+		return inact_en;
+
+	en = en && act_en && inact_en;
+
+	ret = regmap_assign_bits(st->regmap, ADXL345_REG_POWER_CTL,
+				 (ADXL345_POWER_CTL_AUTO_SLEEP | ADXL345_POWER_CTL_LINK),
+				 en);
 	if (ret)
 		return ret;
 
@@ -575,9 +689,16 @@ static int adxl345_find_odr(struct adxl345_state *st, int val,
 
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
+	return adxl345_set_inact_time(st, 0);
 }
 
 static int adxl345_find_range(struct adxl345_state *st, int val, int val2,
@@ -598,9 +719,49 @@ static int adxl345_find_range(struct adxl345_state *st, int val, int val2,
 
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
+	act_threshold = act_threshold * adxl345_range_factor_tbl[range_old]
+		/ adxl345_range_factor_tbl[range];
+	act_threshold = min(U8_MAX, max(1, act_threshold));
+
+	inact_threshold = inact_threshold * adxl345_range_factor_tbl[range_old]
+		/ adxl345_range_factor_tbl[range];
+	inact_threshold = min(U8_MAX, max(1, inact_threshold));
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
@@ -747,6 +908,8 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
 		switch (dir) {
 		case IIO_EV_DIR_RISING:
 			return adxl345_is_act_inact_en(st, ADXL345_ACTIVITY);
+		case IIO_EV_DIR_FALLING:
+			return adxl345_is_act_inact_en(st, ADXL345_INACTIVITY);
 		default:
 			return -EINVAL;
 		}
@@ -787,6 +950,10 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 			return adxl345_set_act_inact_en(st,
 							ADXL345_ACTIVITY,
 							state);
+		case IIO_EV_DIR_FALLING:
+			return adxl345_set_act_inact_en(st,
+							ADXL345_INACTIVITY,
+							state);
 		default:
 			return -EINVAL;
 		}
@@ -812,7 +979,8 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 				    int *val, int *val2)
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
-	unsigned int act_threshold;
+	unsigned int act_threshold, inact_threshold;
+	unsigned int inact_time_s;
 	unsigned int tap_threshold;
 	int ret;
 
@@ -830,9 +998,26 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 				*val = 62500 * act_threshold;
 				*val2 = MICRO;
 				return IIO_VAL_FRACTIONAL;
+			case IIO_EV_DIR_FALLING:
+				ret = regmap_read(st->regmap,
+						  adxl345_act_thresh_reg[ADXL345_INACTIVITY],
+						  &inact_threshold);
+				if (ret)
+					return ret;
+				*val = 62500 * inact_threshold;
+				*val2 = MICRO;
+				return IIO_VAL_FRACTIONAL;
 			default:
 				return -EINVAL;
 			}
+		case IIO_EV_INFO_PERIOD:
+			ret = regmap_read(st->regmap,
+					  ADXL345_REG_TIME_INACT,
+					  &inact_time_s);
+			if (ret)
+				return ret;
+			*val = inact_time_s;
+			return IIO_VAL_INT;
 		default:
 			return -EINVAL;
 		}
@@ -887,19 +1072,31 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
 	case IIO_EV_TYPE_MAG:
 		switch (info) {
 		case IIO_EV_INFO_VALUE:
+			val = DIV_ROUND_CLOSEST(val * MICRO + val2, 62500);
 			switch (dir) {
 			case IIO_EV_DIR_RISING:
-				val = DIV_ROUND_CLOSEST(val * MICRO + val2, 62500);
 				ret = regmap_write(st->regmap,
 						   adxl345_act_thresh_reg[ADXL345_ACTIVITY],
 						   val);
 				if (ret)
 					return ret;
 				break;
+			case IIO_EV_DIR_FALLING:
+				ret = regmap_write(st->regmap,
+						   adxl345_act_thresh_reg[ADXL345_INACTIVITY],
+						   val);
+				if (ret)
+					return ret;
+				break;
 			default:
 				return -EINVAL;
 			}
 			break;
+		case IIO_EV_INFO_PERIOD:
+			ret = adxl345_set_inact_time(st, val);
+			if (ret)
+				return ret;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -1183,6 +1380,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
 			return ret;
 	}
 
+	if (FIELD_GET(ADXL345_INT_INACTIVITY, int_stat)) {
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
@@ -1414,10 +1622,18 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		if (ret)
 			return ret;
 
+		ret = regmap_write(st->regmap, ADXL345_REG_TIME_INACT, 0x37);
+		if (ret)
+			return ret;
+
 		ret = regmap_write(st->regmap, ADXL345_REG_THRESH_ACT, 6);
 		if (ret)
 			return ret;
 
+		ret = regmap_write(st->regmap, ADXL345_REG_THRESH_INACT, 4);
+		if (ret)
+			return ret;
+
 		ret = regmap_write(st->regmap, ADXL345_REG_THRESH_TAP, tap_threshold);
 		if (ret)
 			return ret;
-- 
2.39.5


