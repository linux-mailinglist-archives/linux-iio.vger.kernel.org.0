Return-Path: <linux-iio+bounces-20877-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EA5AE309D
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 17:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6557216F4E8
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 15:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C901FE470;
	Sun, 22 Jun 2025 15:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4cBpT1i"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F021F4621;
	Sun, 22 Jun 2025 15:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750607422; cv=none; b=slyRzpV5kADCmf/MeEp9zbsrkJzQUVeMP9YuWyM+bpqWLTWBwghaV7R590X+h/EzFulwlZ2kDo8iiWm4WSZ1DCWMBH67MGh7/6UzE26BTsJLMmjkZIXtwkejZ80m6Dcw5MxGy78XQkoEVRL3zCEOTxI9ljlq0Ut82EtxJIU0YxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750607422; c=relaxed/simple;
	bh=cx/nfTUB2f+1sh1owG+x/MWH2zcuedAq36k/fbXL95U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AN0gAOgGbMYAA3Bc/07Dx7ZVDOjV7fGq7gPRbXmNfUf+17L6kpvGI0ViXrxuq2pQzS54RGuhLJTd9klVPeRcpqPhWNeq3JogQvLmiyb4uB+KQWG9qX1HHKCqYPjMJDEzC+jsNtZxvpZfuihwvwe4Trie/KdbB9kvYTBDTVv4gQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4cBpT1i; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6095f07cd53so676910a12.3;
        Sun, 22 Jun 2025 08:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750607419; x=1751212219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsIAHZTI45ZQdSlwPvHH3Qj1U4OpAFgZYtBorM87rNk=;
        b=B4cBpT1iwHbRHFsN2ceFhPZB7OLt8ZyxdY66IYgjIcMknc2T36429g7aPALi2E4zOR
         dE6NSY2YwoYYqEhH5vMyH2g71OSfnl3t79AidMiVoVX3+5WhFFrnOrYR7U8iVmD5VeMG
         tm3eFvAJvUWE7LVnmaxxePjdXQEdOKxtWzPMx9kk80+TuAIIAs+VtWTusWMQdl1LOVCo
         k7K3dodbKZxTEmzUQ/ymBjVC7fwv0ZZLtuUuTQTaavC8LKT8vCNPhrmWUnxKXszbHTCF
         eC+bVDi3PYklF5U8AS2dLpWBKQ/QQYHXUgS44dWo2ntHkt+iJAwE8kZmoAZ8OwFQcRFM
         v4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750607419; x=1751212219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsIAHZTI45ZQdSlwPvHH3Qj1U4OpAFgZYtBorM87rNk=;
        b=l5H7iJ88JiJHIw91d82aPoVO/yxvHTzIcOaznTikbqZa33LEYewB+dLY5y++KwYqvJ
         1L8XCX23E+PAB8jrAa56iOehQPGvYINP3ChQRMSjtZU2vQP4G9wyqWUDw/hXo5sTZCqn
         BoBctAFbx/gfCYewLtZgAJnMRsuPX+xjYg6Nw7VgZI/z2f0unjhFRlQ+n5NkSXVWXN48
         J8kXcS7ppHrknwfvqiNMpJ1/NghX8UXYlZa9InEns+qH+KfoxgQDc1uKxDh5iewurHTE
         a3RXpqpp7wgpUUQ2GawLeMnqjMiEmHNebHoyzNn32F1j+2vi49HENjR6R5ATWZPKYVj8
         Vqiw==
X-Forwarded-Encrypted: i=1; AJvYcCUGdglZXX2ldjDBejaYeRSQUCVUq2TcGSWmqGzBEFWS63bI+O8b1yyS3WSlScmYbFXcOomBDMzkoALRNfsM@vger.kernel.org, AJvYcCUadsLORb7JFNP0WtQffjv8lwX4wEgb2Nrn3+ZdH1bSmDvLL7LicnUy72qyZcAn1Rosj0RDo+lEi1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJY2NcOjzfS757ZjA7FPNCWLzVJ/6bte3aZVVt2MBIoLY6J6gH
	rdN/984s4svrBImG86E4KLkK5vqWN1278nQ5lmJCO7ML2L4+ItBFFCbv
X-Gm-Gg: ASbGnctu+LLwiJsCd0Sy7/DX4yrkD94VaYSED8WFTrhxpBBa3B4t9NBuL2b1Z2rG1px
	ZYsFrB8HbP660AurbxS2cOpoUeIxlgmrEyqcPTE7ExDF5Fompq866/nqpNMET4qmBJLSyCIUlng
	zXDAFs/+btetoSuA66odIzd96NoVbjuymJUH+RgVm+EriKybouqgsBWcnrD3+IdiYb9fMbfR2Ft
	f6rHBfkpQBDsY/88R6lO7mV1CVP+zK9Q38ZmM8T55cDTuTzL8sSI86W/LAdF+GHTfNSBR+wtdQx
	5qyWm4kAVpHxVZ9wedm5EVDdW9zVeN1+EABKsZYwxbo7B4ID0j4tYDC+yofsP/A/1X77ap4gdGJ
	CQdicn66LmLrCiA186QGv7S8RFZNh3epb
X-Google-Smtp-Source: AGHT+IGQLw0b7XG1xtw2s9ubCrwCns/JizWuQBLgEQwVAZLnAk0jw0JGz2MKgsnBMXqxEj7ZjE1GcA==
X-Received: by 2002:a17:906:c152:b0:ad8:8e05:e5e9 with SMTP id a640c23a62f3a-ae0578959d4mr354785866b.2.1750607418529;
        Sun, 22 Jun 2025 08:50:18 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae053ecbd9esm552781966b.38.2025.06.22.08.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 08:50:18 -0700 (PDT)
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
Subject: [PATCH v10 4/7] iio: accel: adxl345: add inactivity feature
Date: Sun, 22 Jun 2025 15:50:07 +0000
Message-Id: <20250622155010.164451-5-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250622155010.164451-1-l.rubusch@gmail.com>
References: <20250622155010.164451-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl345_core.c | 240 ++++++++++++++++++++++++++++++-
 1 file changed, 236 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 99b590e67967..3faf1af013c7 100644
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
@@ -264,6 +300,52 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
 
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
@@ -285,6 +367,13 @@ static int adxl345_is_act_inact_en(struct adxl345_state *st,
 		if (!en)
 			return false;
 		break;
+	case ADXL345_INACTIVITY:
+		en = FIELD_GET(ADXL345_INACT_X_EN, axis_ctrl) |
+			FIELD_GET(ADXL345_INACT_Y_EN, axis_ctrl) |
+			FIELD_GET(ADXL345_INACT_Z_EN, axis_ctrl);
+		if (!en)
+			return false;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -297,12 +386,32 @@ static int adxl345_is_act_inact_en(struct adxl345_state *st,
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
@@ -315,6 +424,18 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 
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
@@ -328,6 +449,10 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 		axis_ctrl = ADXL345_ACT_X_EN | ADXL345_ACT_Y_EN |
 				ADXL345_ACT_Z_EN;
 		break;
+	case ADXL345_INACTIVITY:
+		axis_ctrl = ADXL345_INACT_X_EN | ADXL345_INACT_Y_EN |
+				ADXL345_INACT_Z_EN;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -343,6 +468,11 @@ static int adxl345_set_act_inact_en(struct adxl345_state *st,
 	if (ret)
 		return ret;
 
+	/* Set link-bit and auto-sleep only when ACT and INACT are enabled */
+	ret = adxl345_set_act_inact_linkbit(st, type, cmd_en);
+	if (ret)
+		return ret;
+
 	return adxl345_set_measure_en(st, true);
 }
 
@@ -575,9 +705,16 @@ static int adxl345_find_odr(struct adxl345_state *st, int val,
 
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
@@ -598,9 +735,49 @@ static int adxl345_find_range(struct adxl345_state *st, int val, int val2,
 
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
@@ -735,11 +912,14 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 
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
@@ -748,11 +928,14 @@ static int adxl345_read_mag_config(struct adxl345_state *st,
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
@@ -770,7 +953,8 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
 	switch (type) {
 	case IIO_EV_TYPE_MAG:
 		return adxl345_read_mag_config(st, dir,
-					       ADXL345_ACTIVITY);
+					       ADXL345_ACTIVITY,
+					       ADXL345_INACTIVITY);
 	case IIO_EV_TYPE_GESTURE:
 		switch (dir) {
 		case IIO_EV_DIR_SINGLETAP:
@@ -805,6 +989,7 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 	case IIO_EV_TYPE_MAG:
 		return adxl345_write_mag_config(st, dir,
 						ADXL345_ACTIVITY,
+						ADXL345_INACTIVITY,
 						state);
 	case IIO_EV_TYPE_GESTURE:
 		switch (dir) {
@@ -824,9 +1009,11 @@ static int adxl345_read_mag_value(struct adxl345_state *st,
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
@@ -841,9 +1028,26 @@ static int adxl345_read_mag_value(struct adxl345_state *st,
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
@@ -853,6 +1057,7 @@ static int adxl345_write_mag_value(struct adxl345_state *st,
 				   enum iio_event_direction dir,
 				   enum iio_event_info info,
 				   enum adxl345_activity_type type_act,
+				   enum adxl345_activity_type type_inact,
 				   int val, int val2)
 {
 	switch (info) {
@@ -864,9 +1069,15 @@ static int adxl345_write_mag_value(struct adxl345_state *st,
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
@@ -887,6 +1098,7 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 	case IIO_EV_TYPE_MAG:
 		return adxl345_read_mag_value(st, dir, info,
 					      ADXL345_ACTIVITY,
+					      ADXL345_INACTIVITY,
 					      val, val2);
 	case IIO_EV_TYPE_GESTURE:
 		switch (info) {
@@ -941,6 +1153,7 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
 	case IIO_EV_TYPE_MAG:
 		ret = adxl345_write_mag_value(st, dir, info,
 					      ADXL345_ACTIVITY,
+					      ADXL345_INACTIVITY,
 					      val, val2);
 		if (ret)
 			return ret;
@@ -1222,6 +1435,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
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
@@ -1460,10 +1684,18 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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


