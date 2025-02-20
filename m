Return-Path: <linux-iio+bounces-15841-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A315DA3D729
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 11:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B759178571
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 10:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF50B1F7557;
	Thu, 20 Feb 2025 10:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxQvny18"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707DA1F55FB;
	Thu, 20 Feb 2025 10:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048176; cv=none; b=r921u0YM+yyryDMR9YT/OF65lvjPuGMUl0ogdGChnF1CtnBTqDsvXVckOMQq+mUp+fIPpvyoglWBowhRoaxF07mKTA0USBd6QsnnJB2TDdj3Vy7ApzFJE86wvF7BNLgw/ZwqbKAFumuYWLRfrFkTbdxWezmii/tfTBkR285q+Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048176; c=relaxed/simple;
	bh=7Ev8SZr6ybrSLsNeldDCLMOD3Fq5Vu3fzAVC+a85s+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RdBHsAPzxviFHS8TP3PTn4UrdD1EgbVfSsiffA37Ou/kS0mKHD7Uv7eJ5g5L9gQ+mwhIb4gtMgHvhO+aZ+zZ5VMzFo4qK2MNfpIOMq3+J8Ceq/y7aKMN6T5AVwGhl3v1tJUcsJcW90ou0ZTupnhtrTDir8z+IjM9w9I+SNvywgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxQvny18; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e064eff5daso112570a12.3;
        Thu, 20 Feb 2025 02:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740048173; x=1740652973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJU2SiuSho+uT/qo2rXEKUSgHCtdBYekR0Np/HxOV+Q=;
        b=UxQvny18Ayo9PBa07YWkvkY+w3LM3JSjGwucbQ098aI0q2yi3sTjZFeXioRb0bUts6
         GzhKf463As3F+xjMTg/WAX8l/iCpC18/Lb27sV/bDJSg9WlMYMRaMTF/bKkr9g+zO4yI
         tEvnNeB8zvN74poHC5AHtYHU2oz44ozJ0Io/pyiI7h8LQwislw3ljOH/8lCAGsRXsYAK
         AZ27bM0z8W79KlyTsq5Ciwc2ivQstlgoIp30hbdG1d3u5Hje0f2w9ScQeapXd8D3ZN41
         IS+vplQr8Zv+JTiHnnRtm+YO8Qi8dXOD9M6ooB48V+ACznuebfNW7r48tlNYo8ibU2Ah
         MYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740048173; x=1740652973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJU2SiuSho+uT/qo2rXEKUSgHCtdBYekR0Np/HxOV+Q=;
        b=dotriiBYMQrBLrsHTa2xzZbotHr41gi2L6BueiLYa7vynJjHyLOP58U/YTpUDoJxY6
         mZAFjJNhIeOdLvy4iBw0zVHomleV1lNdBzD10mHHAA0z28J0LmXYpHA22HIh8XEq45bc
         62wxgwqEdsEBuLKz3Q6OtIh4Fmovw3Z37X3H0S00HOCbuW4PLVPLQvnXd3TSBSWkGsIe
         OR+qzhQNFTdx7m8yyvexlaiXOuyxHWT0gbElQHGDtOrNdUCeOd69mkD3M/1bxQx585g/
         MJVDtdwUrjb4+e+dWj454G3DAVuRXvbKtB6cA1qWRdKCN4Yq6OEswDyeVI1piQIR7ejF
         bdmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUczJplowubgwQMKbGHa4AWzz5YfVckZ48KyEQBf8pmTDqwoFrwIj3gYSXBy1RQlVfWie537jzyJ2/BZTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSXFfHP7jHSc3CQGDDCmy4sK4RBzDFUSxpMRAqPnBWyD+lFfRv
	SVm1BJel1TRqBHAoqbUV/MGhWEc3KBZK2KO1vpf3tQxUE2qgPvHC
X-Gm-Gg: ASbGncuT31c+eqPVnehU7ZOfKJ03/kqc9PQhRDbQPur2dWKWcmycipdgancx7+trc+U
	L4cZALgDuZohISA52I4xvUdd/sMGyN+PWepxcUqkdlb4bH5FUzIqcQa7YYBUgxyCUwmrsw5OhW9
	FgaFqxMRFn0DtZH1jWhdbL8gLW+CYwQWEdaSEVbpytnHvfbZovMypISyZO8wgSwhzzg8sDErFN0
	TePVkSJvN3jitZn5SqIAhm0rbxfucmIOtacw2kg3NVoKTrlY8fSmaVVEYmunOy7I9gNnk/kZyQg
	lBLNCWxvPbsqAuVRHeLzLbJc1pIP9LO3jbnIs9r2Ohk02Q/huPEalZrGdvAtl5ucDYkrAw==
X-Google-Smtp-Source: AGHT+IF0YGG3Ig1iKT77VWOWS2d17YtlmZyMqVnk5gLQkPBg8yJIlQhCVW4NayO0FRVXdeyoB8en5Q==
X-Received: by 2002:a17:906:6a0c:b0:aba:6055:9ed1 with SMTP id a640c23a62f3a-abb70ab8b8amr843952966b.6.1740048172407;
        Thu, 20 Feb 2025 02:42:52 -0800 (PST)
Received: from 0f997e1ceb21.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbdfcaed55sm246474866b.137.2025.02.20.02.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:42:52 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v3 14/15] iio: accel: adxl345: add coupling detection for activity/inactivity
Date: Thu, 20 Feb 2025 10:42:33 +0000
Message-Id: <20250220104234.40958-15-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220104234.40958-1-l.rubusch@gmail.com>
References: <20250220104234.40958-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl345_core.c | 154 +++++++++++++++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 40ec06bf2090..7ace835e7824 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -36,7 +36,9 @@
 #define ADXL345_REG_TAP_AXIS_MSK	GENMASK(2, 0)
 #define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3)
 #define ADXL345_REG_ACT_AXIS_MSK	GENMASK(6, 4)
+#define ADXL345_REG_ACT_ACDC_MSK	BIT(7)
 #define ADXL345_REG_INACT_AXIS_MSK	GENMASK(2, 0)
+#define ADXL345_REG_INACT_ACDC_MSK	BIT(3)
 #define ADXL345_POWER_CTL_INACT_MSK	(ADXL345_POWER_CTL_AUTO_SLEEP | ADXL345_POWER_CTL_LINK)
 
 enum adxl345_axis {
@@ -86,6 +88,11 @@ static const unsigned int adxl345_act_thresh_reg[] = {
 	[ADXL345_INACTIVITY] = ADXL345_REG_THRESH_INACT,
 };
 
+static const unsigned int adxl345_act_acdc_msk[] = {
+	[ADXL345_ACTIVITY] = ADXL345_REG_ACT_ACDC_MSK,
+	[ADXL345_INACTIVITY] = ADXL345_REG_INACT_ACDC_MSK,
+};
+
 static const unsigned int adxl345_act_axis_msk[] = {
 	[ADXL345_ACTIVITY] = ADXL345_REG_ACT_AXIS_MSK,
 	[ADXL345_INACTIVITY] = ADXL345_REG_INACT_AXIS_MSK,
@@ -221,6 +228,18 @@ static struct iio_event_spec adxl345_events[] = {
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
@@ -337,6 +356,69 @@ static int adxl345_write_act_axis(struct adxl345_state *st,
 	return 0;
 }
 
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
+		*ac = (FIELD_GET(ADXL345_REG_ACT_ACDC_MSK, regval) > 0) ? true : false;
+	else
+		*ac = (FIELD_GET(ADXL345_REG_INACT_ACDC_MSK, regval) > 0) ? true : false;
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
+	 * A setting of 0 selects dc-coupled operation, and a setting of 1
+	 * enables ac-coupled operation. In dc-coupled operation, the current
+	 * acceleration magnitude is compared directly with
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
 				   enum adxl345_activity_type type, bool *en)
 {
@@ -695,6 +777,11 @@ static int adxl345_set_odr(struct adxl345_state *st, enum adxl345_odr odr)
 	if (ret)
 		return ret;
 
+	/* update inactivity time by ODR */
+	ret = adxl345_set_inact_time_s(st, 0);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -718,14 +805,54 @@ static int adxl345_find_range(struct adxl345_state *st, int val, int val2,
 
 static int adxl345_set_range(struct adxl345_state *st, enum adxl345_range range)
 {
+	unsigned int act_threshold, inact_threshold;
+	unsigned int range_old;
+	unsigned int regval;
 	int ret;
 
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
 	ret = regmap_update_bits(st->regmap, ADXL345_REG_DATA_FORMAT,
 				 ADXL345_DATA_FORMAT_RANGE,
 				 FIELD_PREP(ADXL345_DATA_FORMAT_RANGE, range));
 	if (ret)
 		return ret;
 
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
+	ret = regmap_write(st->regmap, adxl345_act_thresh_reg[ADXL345_INACTIVITY],
+			   inact_threshold);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -862,6 +989,8 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
 	struct adxl345_state *st = iio_priv(indio_dev);
 	bool int_en;
 	bool axis_en;
+	bool act_ac;
+	bool inact_ac;
 	int ret = -EFAULT;
 
 	switch (type) {
@@ -915,6 +1044,21 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
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
@@ -965,6 +1109,16 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
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


