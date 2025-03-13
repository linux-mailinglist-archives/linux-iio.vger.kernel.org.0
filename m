Return-Path: <linux-iio+bounces-16799-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F9BA5FCAF
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 17:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9400016D445
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 16:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D811426BDB2;
	Thu, 13 Mar 2025 16:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XYreB1kw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A50126C03;
	Thu, 13 Mar 2025 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884682; cv=none; b=rVpL6l0MjzHjpTm7wX8e/p6Ux41iD/eeYtwAOARK3PJJb9BUCX2ZcJp4K6LIApyjUe0Ok2WZ0/Rq2n63L8W53vQrDc5tSyX1Cv360j/Itg6RStBV0bdhSByNq8gBPCLvP6N9tFx+w2Yvt+6QfF/u3szcqVRTxqztv5HTB9QZJSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884682; c=relaxed/simple;
	bh=C9BDPXAoBdCppIJNKsEUjSpGkbDtTojTxqIZj4vm4Vk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L2PPsjx0TYHbmyWaP3lQy0H6IBXd0e4DSBKiPrcsA1I2jAbFOLwkVeI51xX6f0cJW4UZbJHUFzNydXS3og3p7evuoFYK3f6exjbJqcIEu0iqvjPPuNgh25yD/KLzWmKgFb0VUBwPKVcE9tbdE4s6Y1eUFVILr0p5up1S6UQ1JVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XYreB1kw; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac24daf5f32so15088966b.0;
        Thu, 13 Mar 2025 09:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741884679; x=1742489479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXp+p7KoE6pwI0WlNoFYElb0u9k8flDM6qj6UZ8wyYE=;
        b=XYreB1kwYcf0tiG4DeWtwqP4nUNuMtASfEvrht3xzO2Q2/cri0BQ1g3ybmRgxNiTc8
         H7bIDuMJXSOqbu/1X+vpoMjDG/fUTITdOiOp35DkhhezMN70LsJRfgi/txSc2CKGGh+L
         zWDp69C7CpTdmLepXn+NX4pkJu0FaZEKwGgemPaGziBMe9LUjWra1+mODNqmY2jaywMT
         g5nrSR9w+sUArbyhj4DYGZUc7Cf3P7QFEKb/3ZrlDf5S4VKeKFMwrS3zkwQUWjVgFYbg
         Yi/p8+y+ov93vSmBfbHJGBDW5+RgqIH8B2AzZkoE1r1hFelp0DEmRn2h6QpyGkEb0ocz
         ywFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741884679; x=1742489479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXp+p7KoE6pwI0WlNoFYElb0u9k8flDM6qj6UZ8wyYE=;
        b=ceIMCagfR2fO4THZglCZyLCiWwD8LdWwpkyWF1OofmCkrgjuFU4AQwbgCdzoFo07/W
         nw/OBkudKWgbfG3Q2be+whZ+hPF0khGyoCMMdJAZJZ13Ke5GUDpMEWeSy1vFoKbs9ICm
         yvcQfrRA+lmSslQINm5BKb8Bj++yjxuKf3uOem6kaFALQTzHoUV9Mx6p18fsBr3b5GF+
         SjERUOG8aJHJO0fUbxFWABKdNMyUWFKfSA19Cxji9BHRxpNRJnNib2+UJtHKCdo9A9wv
         5i+0rVKy0w6Yc6Cd0AGZ3qEM9ptsuMxoxchBLBEBk8r5LhAxprcg/PRhfeA5v7I7c/9H
         /dvg==
X-Forwarded-Encrypted: i=1; AJvYcCVmWqOvbOvXdBCllQpuE5M6fgEUs+WsQfmUyelT74+ForS4x3+DAIViUjZQvx99KVN7kxolxqa2Hm4Aqpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3vs3H0+CY0SQDQg+Y1Kw+ahn1G7Wbz2kosSXBuAXFixv1wpgS
	7BRRpWY9NvHufSWiqUITlCOBnjo8F5uP1XD5gPPIZBm71Uyx/oM1
X-Gm-Gg: ASbGnctaTNNzSfMAePOvYScCkgnqyeJLRCrBzHlrX+c+qCSZPc/myPKQL9ohiXXffYM
	0Yl8Qt29N7qTdKLc9DFCDBPoy8SxdsGfCBY8Y5udxbA4SalVdOkSPPjyaxBxBkBVBfmLS8wHj8I
	SBaVIbp2RQVEHLRFHyGUT3k6dVZZI/A6Kw3I0B3mCP9Bs857ggzxshj0BYknNC8D1jx94eUT1AR
	2PyXgylt39Yppuqw3fVkYBVj1gHi/+G3B9boJA+USw3TmaIy7EvhYp3qltqb8i2/EhNLioUMCha
	37HGdDUmTN0pjuG7Kk/98rKkkPyRSDR1K+kfQTMIA0QYbRFJ9Nw02RlctciF5wkV/0qtqHaX4O4
	K9wSuXotDwqOKBIWtm8YO1Ww=
X-Google-Smtp-Source: AGHT+IHwxtpnkiH3QDVTQd596RDWVcfAkbC47JC09890A1Eex4towAiTcUVxRgzFmP4Jl/XHi+QZmg==
X-Received: by 2002:a17:907:c10:b0:ac2:7ce7:cd35 with SMTP id a640c23a62f3a-ac2b9e3a732mr612145466b.10.1741884678575;
        Thu, 13 Mar 2025 09:51:18 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147efb0csm101370866b.65.2025.03.13.09.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:51:18 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v4 13/14] iio: accel: adxl345: add coupling detection for activity/inactivity
Date: Thu, 13 Mar 2025 16:50:48 +0000
Message-Id: <20250313165049.48305-14-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313165049.48305-1-l.rubusch@gmail.com>
References: <20250313165049.48305-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl345_core.c | 150 ++++++++++++++++++++++++++++++-
 1 file changed, 148 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index c718d529d897..1cbe431cda71 100644
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
@@ -300,6 +319,69 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
 
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
+		*ac = (FIELD_GET(ADXL345_REG_ACT_ACDC_MSK, regval) > 0);
+	else
+		*ac = (FIELD_GET(ADXL345_REG_INACT_ACDC_MSK, regval) > 0);
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
@@ -745,7 +827,8 @@ static int adxl345_set_odr(struct adxl345_state *st, enum adxl345_odr odr)
 	if (ret)
 		return ret;
 
-	return 0;
+	/* update inactivity time by ODR */
+	return adxl345_set_inact_time_s(st, 0);
 }
 
 static int adxl345_find_range(struct adxl345_state *st, int val, int val2,
@@ -766,15 +849,51 @@ static int adxl345_find_range(struct adxl345_state *st, int val, int val2,
 
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
 
-	return 0;
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
@@ -914,6 +1033,8 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
 	bool int_en;
+	bool act_ac;
+	bool inact_ac;
 	int ret = -EFAULT;
 
 	switch (type) {
@@ -958,6 +1079,21 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
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
@@ -994,6 +1130,16 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
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


