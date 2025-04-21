Return-Path: <linux-iio+bounces-18478-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 804EAA95901
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 00:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560B01896D10
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 22:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629B92253F8;
	Mon, 21 Apr 2025 22:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3q4Koge"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB96223706;
	Mon, 21 Apr 2025 22:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745273229; cv=none; b=OGIUYC83U+cMrSqAqMsuekJTl4I2RxcnkBUWzVjrPVCM2u+uZkwILKf7I41FbY5QJDRetPl0rjIDcKaqNTXmKShfwI13R7WLLF+jdW5cwEcNsU/wncWLHIgbhyn/va5CGWlFxQZpo+t1cuXkujzEvXyyW2VLyi1awAPNjwM7pxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745273229; c=relaxed/simple;
	bh=VjvsnNSbg1Cc4C8TpUgNdabih6kCHuQ/c1PuLjBoSdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tna0+vdphyeo61ZJLcM0fS6QjDG7fX10lOmK8GJ56/uv4G44Dt707fduU3DZJLBlY/ULMJLXYzErXBPK9oKS3onYAcC4iPGPxkX/c35Kj5wVLoNl5Z5dg6WrGwD0LinfS6nYS4/Vdte0vF5h9Gv3CWo5qzyPLoOP/6VTQgRp+ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3q4Koge; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-acba3f5868eso17916366b.1;
        Mon, 21 Apr 2025 15:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745273225; x=1745878025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZr0T5SXjPShcJbHgJIn0GUT2qyjdnoec7oYBKEuV84=;
        b=F3q4KogeIa6jzODekHX0r859Wy3px8R1a1louqXadEu9DXxI970qs21sGJPUhxGz2j
         n2HRPu5QthMSua7EgNhIGHZGil/hYPCsJIaPBrlzfnip/q5SKQoRtFcdDaKVtd0kRqWM
         MqNXjSDEAl1/7TJycvWU87nwcc5uOrxv24RX8QVsEagdVPrrB9uwHI8HKuMxnxSGBeJA
         Jp45wLwD98UF63p/BGEwDnJmWUDSR9UrdvfZKGM+ddfYszRs6ie4hHBio0yJ2kBjRvOU
         hT95OO3SPwwRNRJ5QFQFsNM31UXJPMaT2mJUv3ueDHeDZMntgD+qrQyMQvEkrf87dIOn
         waKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745273225; x=1745878025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZr0T5SXjPShcJbHgJIn0GUT2qyjdnoec7oYBKEuV84=;
        b=Mh0W41VddzPGo2BBoOtbDc8M8VE1BtFgiWK4Gc6tmC0DT/Sy3UfYmowkIJRIbuN2Th
         fYGsEK84cvhPwsJbXSYDzAK+tVpfnVsQEHbMI7ZxeUGj+crIxAG/ZvL+HlLaCfQj0Kpa
         3ktws3Fb1RGJRPsyMX5i0/kXAXmO0qFFt136ui5h3Irex9x9xw1T1Te8FTgFWLfdSRHQ
         ftp4V1qoPnvUwuJiKTeXVbk1eU/H9mpLW5StjER/BwlRlSM+GtwLD4xmFOleHj/G6b7g
         JdJFtegzgwsZjvUazLAK0AmjR6mlEETRUFtwwtkqSAETcWBtv96btGOAxs1Yasu1InIt
         ZY8g==
X-Forwarded-Encrypted: i=1; AJvYcCUuFSHN0bmH8CBhtXdN0Gz9A8v1tpYcrWvc1c/M4bDJjA8QzJFQuQoQcRrA3fdfqhoNmxUqEu3GR1plAhA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpw6KXhalITTOWbZbtN68OqEBWwVwGiirOTLOFjnhxXX1aDHqV
	MXdhjS46DK3B75urmVunXW6Y+az934kYWSoPL4SZGAUNvb+ByT8O
X-Gm-Gg: ASbGnctIztXLYUOeKO1hC+S5v6uYEMualWU2pCYZaYcfuldN6/6NKyI+UUZzbkITSLS
	0ORERxUL4sJL2im0TQURyafxe0XQygMhc0b+s50Kk9t6VfSlDXa64xSJmZqt1cmb8RNxChGdSGc
	b5xsjKHjyuGbrrfho7R5iWewGpudnBiYSKI0tOsbC95nM+d4LmjYol5pCkwLniwmDL96oMfEvLN
	f/KdLsNJlcW/uff0jlLVh6W7ErPQQXWnaPj/k1KyrPNBZHeT/mM+yy1+PxDGa0gQyj0Rz2aUeXN
	I7u9azKtlTSCG6BPueeOmN8zQE8HkLHzdTyiIiEommh00gKY5qKuusPBQZ5n7mtjaUyrJ51JiKf
	UDYuV3Lun+r5ByZebSrQ=
X-Google-Smtp-Source: AGHT+IH/5JAfyrS1Fx6teO+9qCIIag18/kxUkcz4BZ3XKGqyCGd9JggM0MqCm04CQfhMKvaDYWaBwA==
X-Received: by 2002:a17:906:5ad5:b0:acb:7de1:28b9 with SMTP id a640c23a62f3a-acb7de12b80mr319562166b.5.1745273225108;
        Mon, 21 Apr 2025 15:07:05 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acbb8d49fdasm80311666b.67.2025.04.21.15.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 15:07:04 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v7 10/11] iio: accel: adxl345: add coupling detection for activity/inactivity
Date: Mon, 21 Apr 2025 22:06:40 +0000
Message-Id: <20250421220641.105567-11-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250421220641.105567-1-l.rubusch@gmail.com>
References: <20250421220641.105567-1-l.rubusch@gmail.com>
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
index b25efcad069b..c07ad5774c8a 100644
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
@@ -204,6 +211,18 @@ static struct iio_event_spec adxl345_events[] = {
 			BIT(IIO_EV_INFO_RESET_TIMEOUT) |
 			BIT(IIO_EV_INFO_TAP2_MIN_DELAY),
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
@@ -320,6 +339,69 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
 
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
@@ -774,9 +856,16 @@ static int adxl345_find_odr(struct adxl345_state *st, int val,
 
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
@@ -797,9 +886,51 @@ static int adxl345_find_range(struct adxl345_state *st, int val, int val2,
 
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
@@ -938,7 +1069,7 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
 				     enum iio_event_direction dir)
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
-	bool int_en;
+	bool int_en, act_ac, inact_ac;
 	int ret;
 
 	switch (type) {
@@ -983,6 +1114,21 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
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
@@ -1019,6 +1165,16 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
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


