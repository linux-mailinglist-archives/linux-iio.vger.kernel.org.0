Return-Path: <linux-iio+bounces-17066-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 214F4A68094
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 00:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F18A420201
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 23:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DCE218E97;
	Tue, 18 Mar 2025 23:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dl1YV63v"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BC22153C4;
	Tue, 18 Mar 2025 23:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742339350; cv=none; b=Gg8nCfWtu9A4q1PRT0CtVvn4wrM6eKLYXk6zgCT2jcDG7qfMA2MTNOs3shmV5x0Hk9RLtH8gTk7e4oh42FRaJNHWIVar4/gWtClusSU6FD4dn5Yp+oGXU6wjEh9MhqFWtiWQypWbxjilBXz4mLjHHZMGgzSujhq9LfVQOGiJvoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742339350; c=relaxed/simple;
	bh=kh+x+b4Qv5K6soJVwQuWos+FYwV/Inyyy52QBlUrV0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EFIMCzQwwxg2KutFAsvE5PNETJfi5ehHrlDOnEmmRI5UIubMwcrmjSKWFIzofPYD2xfj8v5wnNT1NGDD3OEGAS0vm/QOmMws4QfGTKayiWTiuGdoQfWTITvn3Lv1oRn6NwrIfn22si4d1xR6SFP4oD63X80r+JOzkd0sLunn6Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dl1YV63v; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3996683dd7bso392991f8f.3;
        Tue, 18 Mar 2025 16:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742339346; x=1742944146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wq/EAL+TvIEsau/5MxNqALDLxnYs3DXhVk3Fq5Cp8SU=;
        b=Dl1YV63vjW7jfx+MFBfuQNHPiBsXqCJmxaAHxNNrKvhH4ES8hq0sRVf6FTLcn98eTO
         96RJWXWkN5A3syDJ55z2B3dTFTOKZbpX5TtIumEB90tDCLFdtWj65khqySfAJWGm60UG
         VYIMgMn7kvrugy/A9Lz31pyniYfKjeAsUqGbWgGyfD7r7PxLD0xpdxWaYVhsP3+b4sHh
         VtFBJx5c43qh0QEm954VLhCoAN2LPCzFCRVQVJUlBVIHlJ3p1eggiC2eqXbJ/kTu+kR/
         dvC52KzSz4OeM7QLMqt57c7JSnOcLE/sAL2rbTXwAX1V7HDAoBW582oAJrG6Mr1gSSSI
         FpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742339346; x=1742944146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wq/EAL+TvIEsau/5MxNqALDLxnYs3DXhVk3Fq5Cp8SU=;
        b=P2tIdobr9KvUQ+zYZ7eRegtlk2sQJ+UM1Jsk7HGfvAHL9/MnhI4TZD3LPL45RU1HGM
         Q1M0ux05Tm7APBP80yMRmSSZrKgAzZJ8sGvw5pWpEUVQB0U/N6JxJhcFuaDe7Yrs4s2N
         cs0z3KYGVS0uB5dqVqJ5k9LN6KGc3YDQRx/ISzO8Ocho3RZ1ZxJXnfcqBTX40HdjQMZB
         5Pr6XBLuecYYSC/WJvn2UQ/3YiX6ZyEgocZ0b2s7P+pl7wKne7J0qGbDFZgHce77bxOn
         mQEAX11su9HQvJdPamV1L6Z7WVXjS6v3Lh65AxLkMBOv54O8VWDa7zarzB1HufUHehJ1
         ziHw==
X-Forwarded-Encrypted: i=1; AJvYcCW4E5ydXz+cwnRhqNttp8QjZNjEtvQFx5lCc6rLTbPUh0gJMjuXJj5RQNsbtLBtDwPujV8l7sTC7TLOF8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/K2m/0ON8URREFZHicAZptya7AHPNvdUTbs9BHIXO8J3BzxgM
	kOZKmO/eKz2Az+W3U+NiTRZaROWOAbmbVZNpTmgLHdqsDU7aaVXS
X-Gm-Gg: ASbGnctC4sh2CPbGPYedRyLJcuJfXVcmEId3PkzxodsxGMMDB/ZBi5OV11cwh7FIaAC
	ob/CH2AlYUQKihHggBZQOsEOQY0vIsOXqF8YILYD77bS2MpX3mzuJ4RHab2hB9UZ+fw65YabI4l
	jA9kCp2roJLXUtauqu1Z5/V+PQAfROmHj3vBAZudYAAsmHaoh+5JDldLvn+owqVleeg5Ti0s8PO
	L6D++1kWAijhhqE0PQSbDuZE0iaHcJF7zL+g0mAAIClTR1TqzuvWq0eu8GY2XMjEnDru083bukE
	wjPF6pG8JwE937pzIsKTiADsE8VrSbAX+UbuJwtSWKwy6Xu8OnZPqG3zXKO5rNC7otuJcJhHfV5
	bj3fi9h6jgWGrZ3Af/5Hyk8w=
X-Google-Smtp-Source: AGHT+IEzO75XNfp84qPlu5sKKlmRvEj95fvaIR2YRpLGHNV33HoUqtebs+xbZ6trKfjpGAh7qqhVYA==
X-Received: by 2002:a05:6000:1f8e:b0:391:1319:9007 with SMTP id ffacd0b85a97d-399739e1bc6mr211654f8f.5.1742339346386;
        Tue, 18 Mar 2025 16:09:06 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d440ed793sm1113455e9.39.2025.03.18.16.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:09:05 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v5 10/11] iio: accel: adxl345: add coupling detection for activity/inactivity
Date: Tue, 18 Mar 2025 23:08:42 +0000
Message-Id: <20250318230843.76068-11-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318230843.76068-1-l.rubusch@gmail.com>
References: <20250318230843.76068-1-l.rubusch@gmail.com>
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
 1 file changed, 160 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 3b841032d41b..35bed998083b 100644
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
@@ -754,9 +836,16 @@ static int adxl345_find_odr(struct adxl345_state *st, int val,
 
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
@@ -777,9 +866,51 @@ static int adxl345_find_range(struct adxl345_state *st, int val, int val2,
 
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
@@ -919,6 +1050,8 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
 	bool int_en;
+	bool act_ac;
+	bool inact_ac;
 	int ret;
 
 	switch (type) {
@@ -963,6 +1096,21 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
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
@@ -999,6 +1147,16 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
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


