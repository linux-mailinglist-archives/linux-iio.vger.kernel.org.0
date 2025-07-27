Return-Path: <linux-iio+bounces-22071-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3560AB131E1
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 23:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE9D1894212
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 21:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920F1244675;
	Sun, 27 Jul 2025 21:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/mXI4QO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D28423F429;
	Sun, 27 Jul 2025 21:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753650030; cv=none; b=mcgZ1oaEnruaKGRUhRVw4QtKv81mJUZYnCxvA5FIFQ+vFoR5fnYZfiLTn2s/0vm2oE4O4YZmmzJjp22vblywjRRlY/POUZH/SOX19ePrgbvRaD8HLEMFQUB6wjtjU/rbocUPIXmAfpL7rv0PxzXmVmU2E7W5hqSsXmzqYejrgcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753650030; c=relaxed/simple;
	bh=h/V5rBzUPbKaPmGNzNd0Lc311u4gD1ZrhXoJKBdkIQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UURSSMlj7KXUVva2RHeSP+zOXoox1UI6pCc3aHf6UhaQXSk++VKUW0cl4IUNaYO5avm55IhShvzhdrxssxEJa2Fgpyuf2An/KKzFIPXwu30AyynBEwyWZzfcydAW17PTOitiIJcr2nKcPjNc+OQ+cNN6iBYSeUYNcMg/UHyAMtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/mXI4QO; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-adb2bd27d8bso42035766b.1;
        Sun, 27 Jul 2025 14:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753650026; x=1754254826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCIzVsb1hxak6haxp9BKGZjBhblnujxfoJvCvgl6N6U=;
        b=h/mXI4QOD8mz0AMxNwbUOEHrOM/zhRjzGmt7c1mnVIctg7Eqb7+h/NG0tYQiaUGgHY
         P8iCkA9gAAIobQeXACKie14qTRe4g4Ol7P9e38xa34Lsu70Dh6cbprsbUfmgVmeG2SRp
         XqOEmHIuoGQeoZUBKi/CfbpKzEOtEspyj4zKkVgpCwKDVWB4VujKPIAZuRSPV8Kym40M
         8uvfL6VXbIh6W2Uo1qPwHx7XhQHzM9OawOkT/SlBSdNZzAFT7AHelTu/47aaKsq7OqLN
         7TdgKFgRNMiru0LcDLpZt7RIdrK94Bx6lfz4FgSZYVu6BhchHPQaUUDU2bi7jelM0y76
         qM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753650026; x=1754254826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SCIzVsb1hxak6haxp9BKGZjBhblnujxfoJvCvgl6N6U=;
        b=rE7a73jjmUfjfAjN+JVhmH5LbtzT5AJXfHm5/4jRwXdh1z0NbY80wn/fnT+ZjXLpMs
         0efpoC6pDa6+OHLrrtosbYKDrqXoJ9YijjxnWmybv/w2YOVKbgcfo+9HIt5KP80m3xPo
         N3Hy271G1+9bSO9BxVUl4IKPye158l0IFMOSzoDFGo6f1R8QU41MxbgrFZs+uVAdzLNY
         mtuI419+RslRasnL28Wo3GxnHyYfZ6OSz7BVmMg5W/u8v63pu5KLTo56zBha5hktDGrM
         /xMi1TRU/jf4OZC7mwINAVyCRcxULte44Wqeime9bpMSy8Q5rTVuC6U6WVluUe1LtoA+
         LqsA==
X-Forwarded-Encrypted: i=1; AJvYcCVkIM1bDJqOIWfxKNM/QxELdWqsC1Yqu3ysmYQCa9o+dlhSzVF8j8HsC0iXfAsG8IJ/W1hXElu316Nl2tAV@vger.kernel.org, AJvYcCWfmgpcut+/0i3pFZXtmsbCQ3wbi5U3V2dsoRTH4ltRjInbIG84YG+a6fQludUvY4rZ0iHJuoUgw+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoNlNRZ7OJ38aQDAZP3KCZN6KWW1Hq8ks8g2pnIfss9N29dEvH
	ftuojG9sffD5qQQWDZo1tjmDtZgPCRuLrpUXXxLK0SvZxiCPX5PR4GcX
X-Gm-Gg: ASbGncvVFxH59zdK2CKWHZgt0KkgPX8Tr8G3uxDQNGNG6m0CkKD5EG/ibbVhy9/xxrQ
	vn9E+eNJhwn6oVJ3Xxz+Nkl7KPAnJWZXWp9Quv+pnRF94ivZ7zXC/iF3aC6ByGdlUpJrqxfnNDW
	PlCicIfPMJRPs7rwyRpdt/WQGK+N7nzv33/aFnLXjiKWfT0ZCNxghPgzH2yTS1GRQ4rE7T7jK3/
	dTRdixXkPAOX/q6niVHis/5ciCTxwzz51EpJBctTwig1X56y+VqiQ5KEtlCp7mk5KiKNxaJhhoa
	tG5Wq7gfPXrdWeAUubDxwwji1slE/lSrgqn7rQ7eOWQqd9nhOheKiEKSsAX1HBPdPZ07/sQE/5E
	gLSnsp9uEtVCrmmukX9s10m27QEPSdH5V0fjO5FjSSVK3vQYOtrEPvuQJD/s+ZQekWtGgghYqnQ
	==
X-Google-Smtp-Source: AGHT+IFOqcsdFfIfTn8Cp1Jgf5FfKtJ0C/U6Y8GNjCLqDLcdR+8KVDiwT1GGwWPtj4xqFKGs6+sv/Q==
X-Received: by 2002:a17:906:b894:b0:af6:32b3:2674 with SMTP id a640c23a62f3a-af632b331e2mr266583166b.0.1753650026124;
        Sun, 27 Jul 2025 14:00:26 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61500add92dsm2512774a12.52.2025.07.27.14.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 14:00:25 -0700 (PDT)
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
Subject: [PATCH v12 3/7] iio: accel: adxl345: add inactivity feature
Date: Sun, 27 Jul 2025 21:00:10 +0000
Message-Id: <20250727210014.27766-4-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250727210014.27766-1-l.rubusch@gmail.com>
References: <20250727210014.27766-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for the sensor’s inactivity feature in the driver. When both
activity and inactivity detection are enabled, the sensor sets a link bit
that ties the two functions together. This also enables auto-sleep mode,
allowing the sensor to automatically enter sleep state upon detecting
inactivity.

Inactivity detection relies on a configurable threshold and a specified
time period. If sensor measurements remain below the threshold for the
defined duration, the sensor transitions to the inactivity state.

When an Output Data Rate (ODR) is set, the inactivity time period is
automatically adjusted to a sensible default. Higher ODRs result in shorter
inactivity timeouts, while lower ODRs allow longer durations-within
reasonable upper and lower bounds. This is important because features like
auto-sleep operate effectively only between 12.5 Hz and 400 Hz. These
defaults are applied when the sample rate is modified, but users can
override them by explicitly setting a custom inactivity timeout.

Similarly, configuring the g-range provides default threshold values for
both activity and inactivity detection. These are implicit defaults meant
to simplify configuration, but they can also be manually overridden as
needed.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 241 ++++++++++++++++++++++++++++++-
 1 file changed, 237 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 8ff1784403ba..1272d8107f0d 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -34,11 +34,20 @@
 #define ADXL345_INT2			1
 
 #define ADXL345_REG_TAP_AXIS_MSK	GENMASK(2, 0)
+#define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3)
+#define ADXL345_REG_TAP_SUPPRESS	BIT(3)
+#define ADXL345_POWER_CTL_INACT_MSK	(ADXL345_POWER_CTL_AUTO_SLEEP | ADXL345_POWER_CTL_LINK)
+
 #define ADXL345_TAP_Z_EN		BIT(0)
 #define ADXL345_TAP_Y_EN		BIT(1)
 #define ADXL345_TAP_X_EN		BIT(2)
 #define ADXL345_REG_TAP_SUPPRESS	BIT(3)
 
+#define ADXL345_INACT_Z_EN		BIT(0)
+#define ADXL345_INACT_Y_EN		BIT(1)
+#define ADXL345_INACT_X_EN		BIT(2)
+#define ADXL345_INACT_XYZ_EN		(ADXL345_INACT_Z_EN | ADXL345_INACT_Y_EN | ADXL345_INACT_X_EN)
+
 #define ADXL345_ACT_Z_EN		BIT(4)
 #define ADXL345_ACT_Y_EN		BIT(5)
 #define ADXL345_ACT_X_EN		BIT(6)
@@ -70,14 +79,17 @@ static const unsigned int adxl345_tap_time_reg[] = {
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
@@ -145,6 +157,14 @@ static const int adxl345_fullres_range_tbl[][2] = {
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
@@ -212,10 +232,30 @@ enum adxl345_chans {
 	chan_x, chan_y, chan_z,
 };
 
+static const struct iio_event_spec adxl345_fake_chan_events[] = {
+	{
+		/* inactivity */
+		.type = IIO_EV_TYPE_MAG,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type =
+			BIT(IIO_EV_INFO_VALUE) |
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
@@ -263,6 +303,52 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
 
 /* activity / inactivity */
 
+/**
+ * adxl345_set_inact_time - Configure inactivity time explicitly or by ODR.
+ * @st: The sensor state instance.
+ * @val_s: A desired time value, between 0 and 255.
+ *
+ * Inactivity time can be configured between 1 and 255 seconds. If a user sets
+ * val_s to 0, a default inactivity time is calculated automatically (since 0 is
+ * also invalid and undefined by the sensor).
+ *
+ * In such cases, power consumption should be considered: the inactivity period
+ * should be shorter at higher sampling frequencies and longer at lower ones.
+ * Specifically, for frequencies above 255 Hz, the default is set to 10 seconds;
+ * for frequencies below 10 Hz, it defaults to 255 seconds.
+ *
+ * The calculation method subtracts the integer part of the configured sample
+ * frequency from 255 to estimate the inactivity time in seconds. Sub-Hertz
+ * values are ignored in this approximation. Since the recommended output data
+ * rates (ODRs) for features like activity/inactivity detection, sleep modes,
+ * and free fall range between 12.5 Hz and 400 Hz, frequencies outside this
+ * range will either use the defined boundary defaults or require explicit
+ * configuration via val_s.
+ *
+ * Return: 0 or error value.
+ */
+static int adxl345_set_inact_time(struct adxl345_state *st, u32 val_s)
+{
+	int max_boundary = U8_MAX;
+	int min_boundary = 10;
+	unsigned int val = min(val_s, U8_MAX);
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
+		val = clamp(max_boundary - adxl345_odr_tbl[odr][0],
+			    min_boundary, max_boundary);
+	}
+
+	return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
+}
+
 static int adxl345_is_act_inact_en(struct adxl345_state *st,
 				   enum adxl345_activity_type type)
 {
@@ -282,6 +368,11 @@ static int adxl345_is_act_inact_en(struct adxl345_state *st,
 		if (!en)
 			return false;
 		break;
+	case ADXL345_INACTIVITY:
+		en = FIELD_GET(ADXL345_INACT_XYZ_EN, axis_ctrl);
+		if (!en)
+			return false;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -294,12 +385,32 @@ static int adxl345_is_act_inact_en(struct adxl345_state *st,
 	return adxl345_act_int_reg[type] & regval;
 }
 
+static int adxl345_set_act_inact_linkbit(struct adxl345_state *st,
+					 enum adxl345_activity_type type,
+					 bool en)
+{
+	int act_en, inact_en;
+
+	act_en = adxl345_is_act_inact_en(st, ADXL345_ACTIVITY);
+	if (act_en < 0)
+		return act_en;
+
+	inact_en = adxl345_is_act_inact_en(st, ADXL345_INACTIVITY);
+	if (inact_en < 0)
+		return inact_en;
+
+	return regmap_assign_bits(st->regmap, ADXL345_REG_POWER_CTL,
+				  ADXL345_POWER_CTL_INACT_MSK,
+				  en && act_en && inact_en);
+}
+
 static int adxl345_set_act_inact_en(struct adxl345_state *st,
 				    enum adxl345_activity_type type,
 				    bool cmd_en)
 {
 	unsigned int axis_ctrl;
 	unsigned int threshold;
+	unsigned int period;
 	int ret;
 
 	if (cmd_en) {
@@ -312,6 +423,18 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 
 		if (!threshold) /* Just ignore the command if threshold is 0 */
 			return 0;
+
+		/* When turning on inactivity, check if inact time is valid */
+		if (type == ADXL345_INACTIVITY) {
+			ret = regmap_read(st->regmap,
+					  ADXL345_REG_TIME_INACT,
+					  &period);
+			if (ret)
+				return ret;
+
+			if (!period)
+				return 0;
+		}
 	}
 
 	/* Start modifying configuration registers */
@@ -324,6 +447,9 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 	case ADXL345_ACTIVITY:
 		axis_ctrl = ADXL345_ACT_XYZ_EN;
 		break;
+	case ADXL345_INACTIVITY:
+		axis_ctrl = ADXL345_INACT_XYZ_EN;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -339,6 +465,11 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 	if (ret)
 		return ret;
 
+	/* Set link-bit and auto-sleep only when ACT and INACT are enabled */
+	ret = adxl345_set_act_inact_linkbit(st, type, cmd_en);
+	if (ret)
+		return ret;
+
 	return adxl345_set_measure_en(st, true);
 }
 
@@ -570,9 +701,16 @@ static int adxl345_find_odr(struct adxl345_state *st, int val,
 
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
@@ -593,9 +731,49 @@ static int adxl345_find_range(struct adxl345_state *st, int val, int val2,
 
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
@@ -730,11 +908,14 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 
 static int adxl345_read_mag_config(struct adxl345_state *st,
 				   enum iio_event_direction dir,
-				   enum adxl345_activity_type type_act)
+				   enum adxl345_activity_type type_act,
+				   enum adxl345_activity_type type_inact)
 {
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
 		return !!adxl345_is_act_inact_en(st, type_act);
+	case IIO_EV_DIR_FALLING:
+		return !!adxl345_is_act_inact_en(st, type_inact);
 	default:
 		return -EINVAL;
 	}
@@ -743,11 +924,14 @@ static int adxl345_read_mag_config(struct adxl345_state *st,
 static int adxl345_write_mag_config(struct adxl345_state *st,
 				    enum iio_event_direction dir,
 				    enum adxl345_activity_type type_act,
+				    enum adxl345_activity_type type_inact,
 				    bool state)
 {
 	switch (dir) {
 	case IIO_EV_DIR_RISING:
 		return adxl345_set_act_inact_en(st, type_act, state);
+	case IIO_EV_DIR_FALLING:
+		return adxl345_set_act_inact_en(st, type_inact, state);
 	default:
 		return -EINVAL;
 	}
@@ -765,7 +949,8 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
 	switch (type) {
 	case IIO_EV_TYPE_MAG:
 		return adxl345_read_mag_config(st, dir,
-					       ADXL345_ACTIVITY);
+					       ADXL345_ACTIVITY,
+					       ADXL345_INACTIVITY);
 	case IIO_EV_TYPE_GESTURE:
 		switch (dir) {
 		case IIO_EV_DIR_SINGLETAP:
@@ -800,6 +985,7 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 	case IIO_EV_TYPE_MAG:
 		return adxl345_write_mag_config(st, dir,
 						ADXL345_ACTIVITY,
+						ADXL345_INACTIVITY,
 						state);
 	case IIO_EV_TYPE_GESTURE:
 		switch (dir) {
@@ -819,9 +1005,11 @@ static int adxl345_read_mag_value(struct adxl345_state *st,
 				  enum iio_event_direction dir,
 				  enum iio_event_info info,
 				  enum adxl345_activity_type type_act,
+				  enum adxl345_activity_type type_inact,
 				  int *val, int *val2)
 {
 	unsigned int threshold;
+	unsigned int period;
 	int ret;
 
 	switch (info) {
@@ -836,9 +1024,26 @@ static int adxl345_read_mag_value(struct adxl345_state *st,
 			*val = 62500 * threshold;
 			*val2 = MICRO;
 			return IIO_VAL_FRACTIONAL;
+		case IIO_EV_DIR_FALLING:
+			ret = regmap_read(st->regmap,
+					  adxl345_act_thresh_reg[type_inact],
+					  &threshold);
+			if (ret)
+				return ret;
+			*val = 62500 * threshold;
+			*val2 = MICRO;
+			return IIO_VAL_FRACTIONAL;
 		default:
 			return -EINVAL;
 		}
+	case IIO_EV_INFO_PERIOD:
+		ret = regmap_read(st->regmap,
+				  ADXL345_REG_TIME_INACT,
+				  &period);
+		if (ret)
+			return ret;
+		*val = period;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -848,6 +1053,7 @@ static int adxl345_write_mag_value(struct adxl345_state *st,
 				   enum iio_event_direction dir,
 				   enum iio_event_info info,
 				   enum adxl345_activity_type type_act,
+				   enum adxl345_activity_type type_inact,
 				   int val, int val2)
 {
 	switch (info) {
@@ -859,9 +1065,15 @@ static int adxl345_write_mag_value(struct adxl345_state *st,
 			return regmap_write(st->regmap,
 					    adxl345_act_thresh_reg[type_act],
 					    val);
+		case IIO_EV_DIR_FALLING:
+			return regmap_write(st->regmap,
+					    adxl345_act_thresh_reg[type_inact],
+					    val);
 		default:
 			return -EINVAL;
 		}
+	case IIO_EV_INFO_PERIOD:
+		return adxl345_set_inact_time(st, val);
 	default:
 		return -EINVAL;
 	}
@@ -882,6 +1094,7 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 	case IIO_EV_TYPE_MAG:
 		return adxl345_read_mag_value(st, dir, info,
 					      ADXL345_ACTIVITY,
+					      ADXL345_INACTIVITY,
 					      val, val2);
 	case IIO_EV_TYPE_GESTURE:
 		switch (info) {
@@ -936,6 +1149,7 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
 	case IIO_EV_TYPE_MAG:
 		ret = adxl345_write_mag_value(st, dir, info,
 					      ADXL345_ACTIVITY,
+					      ADXL345_INACTIVITY,
 					      val, val2);
 		if (ret)
 			return ret;
@@ -1217,6 +1431,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
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
@@ -1455,10 +1680,18 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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


