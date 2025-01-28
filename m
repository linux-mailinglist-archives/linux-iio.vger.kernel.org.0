Return-Path: <linux-iio+bounces-14672-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E29FA20A27
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 13:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510CB1886686
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 12:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E6E1CAA8A;
	Tue, 28 Jan 2025 12:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isT3o6LU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1DD1B0404;
	Tue, 28 Jan 2025 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738065708; cv=none; b=V02HpNcIDIRcRCu0yvvu1WiedgA3DkjNjhQ3IBM+H/ch744J+uL3kNMNAZgoPSGFuw0Bk9eQK0+WZVFYeQ59gMwQ73J5pIk7ffUSx2EMQScNq8DV2xDJ3DBYfsHKtUe2glJX6PpaxaV5cbvlC8992Rgr9crd74DJ1oBrCBDt95A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738065708; c=relaxed/simple;
	bh=ooSE/z8nHD4qO4yh+O7AGHDn8LEVgPgbJnX/wvZzEBY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JGxlybmnB00Jlt4FCqKchzWWXIyNh/A3fyqLeZg5VS+ZdI+qR2ptSsWeMlwi1cpck634LlsCpkz7vS/4oAxLuHO2gDH4lJFjG721ggb8apouHvFmWSsDy4SPYw0o5jvkSRbDCSaUg2n1kL/LkN8MghHM4fpYHG2APWidZ3IDaE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=isT3o6LU; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa6965ad2a5so82414866b.3;
        Tue, 28 Jan 2025 04:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738065705; x=1738670505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxJICuKJGEvgJGZrYDbWlzD+OXLpb5BbFr8sRyR6UcY=;
        b=isT3o6LU35ARHilax//rRup7vzE0zxYHBbUmUjZiI3R+pto22HCi80wjm/3Anlxnru
         IVpoExBm9VeKUSyQiP5vfsvg5gnkDrTOhdhft8RYo8rrFtWMG9OFfJ+qJV+pzc5L1kWH
         ZEor3j2ZY4zTXuOXF1q2M8BZ2Q2tvyOT99jkuuDf2KFxBb4HQR8DRMlElm9B+YRMypep
         9990LaiG/F1T1vJli6G+xaqfWQ/20rYGN8TdK0m6OUony0ALVJLJ2s5H+aemVyh5oEMB
         De3Im76rVR1XKEXlOUAdtmi1is0+SqW7wMhAUU4hQg0xRwOns3aynIvf/uUHGezlVWug
         cJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738065705; x=1738670505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxJICuKJGEvgJGZrYDbWlzD+OXLpb5BbFr8sRyR6UcY=;
        b=oQY/Wq4k0bQQkQLKKOpQ5/zj/0rP9jVVW5VwyQVNTmbzqCZ8Obb/o3sYViuuonDP31
         IcP39/IE2jcLE8KPeGcvJu6PBguOnSB7ZE6EBItCl5XTXxCHUcwG+HfBv5w2IYu+85dR
         zD3DnqmogGVtQ/uRMD8P8Z2Z//+0q+x/0oDk+nG5NDET4fu7YL6GNLHfEc6Q+7hOxmLO
         jyZWDQh4zWCjBRRvuaFo31y+HOo7Qv5UfLECizqiozUJvPxOF0wZrYdCiJIOqpcfPPv8
         BD9Y/FGeGvWf6dC+l8/yOY3eocvDygGUPxqHFij/5iAfjoR86DNwKTMjoBiq5M4uEofN
         O/xg==
X-Forwarded-Encrypted: i=1; AJvYcCUUDUXXBddW5B8xox3GgJzjkGgrXGkr3pEfoOBhgrItrCmCFjo+DZHByylJnnbcdb4u3LZp/dPHehWMfDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzReCnQcyFsk/IAEBSF+ExT9ZIGXuVrFEEHoZZsIyqpG48rzI5g
	6J22HUCmQK9o35HZBON/JFEQvdH9YdHhwFnXMuajO6QkOPbxqhCE
X-Gm-Gg: ASbGncsZNWcnrFGPQeK4VYmeEAZbAwWK2Bts2FtxpgTh216t2UtwlxARpwACNoIDhrG
	Ll5C0rodHQSDKQqiwg2kfniF18C8uiU2hxrdr2a6LN7ObdYZKDaSjYtO6lWH7/HqLZOKKWsO9if
	MTHscL8D+1KD5tQXZl4Uem453WmURM3GYkPW7Ey1dzdBD3jVilqxIGHJr08Ke4tbdI2+NEb4lKw
	QTz+GGqutA+5p54UkHCDgPmkdmWjMwZ2282e2257ayGYscduxvj9eeNgzre/p3bgnkEzbNuljLc
	vWYHXvQy5Mn5O8LXfV1cM6UdBkKqiZuh0ySF5nagbTtElD6yaZbIFAt7v1L3oGLy5/9gSA==
X-Google-Smtp-Source: AGHT+IGxj/91ewZJORBmpFEOruy6g6SVAlbUfFsQe5K8dPIXsXkBeA4a8MMlRE9sLMYAAvdHzoMHGA==
X-Received: by 2002:a17:907:969f:b0:ab3:2719:ca30 with SMTP id a640c23a62f3a-ab38b35c602mr1760150466b.10.1738065704501;
        Tue, 28 Jan 2025 04:01:44 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab69f8555b7sm418865966b.71.2025.01.28.04.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 04:01:44 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v1 11/12] iio: accel: adxl345: add activity feature
Date: Tue, 28 Jan 2025 12:00:59 +0000
Message-Id: <20250128120100.205523-12-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250128120100.205523-1-l.rubusch@gmail.com>
References: <20250128120100.205523-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the handling of activity events, also add sysfs entries to
configure threshold values to trigger the event. Allow to push the
event over to the iio channel.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 158 ++++++++++++++++++++++++++++++-
 1 file changed, 154 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 62d75d28b6fc..94c3ad818ba5 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -121,6 +121,8 @@
 
 #define ADXL345_REG_TAP_AXIS_MSK	GENMASK(2, 0)
 #define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3)
+#define ADXL345_REG_ACT_AXIS_MSK	GENMASK(6, 4)
+#define ADXL345_REG_ACT_ACDC_MSK	BIT(7)
 
 enum adxl345_axis {
 	ADXL345_Z_EN = BIT(0),
@@ -163,6 +165,10 @@ struct adxl345_state {
 	u8 watermark;
 	u8 fifo_mode;
 
+	u32 act_axis_ctrl;
+	bool act_ac;
+	u8 act_value;
+
 	u32 tap_axis_ctrl;
 	u8 tap_threshold;
 	u32 tap_duration_us;
@@ -177,6 +183,11 @@ struct adxl345_state {
 };
 
 static struct iio_event_spec adxl345_events[] = {
+	{
+		/* activity */
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+	},
 	{
 		/* single tap */
 		.type = IIO_EV_TYPE_GESTURE,
@@ -276,6 +287,117 @@ static inline int adxl345_write_interrupts(struct adxl345_state *st)
 	return regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, st->int_map);
 }
 
+/* act/inact */
+
+static int adxl345_write_act_axis(struct adxl345_state *st, bool en)
+{
+	int ret;
+
+	/*
+	 * A setting of 0 selects dc-coupled operation, and a setting of 1
+	 * enables ac-coupled operation. In dc-coupled operation, the current
+	 * acceleration magnitude is compared directly with THRESH_ACT and
+	 * THRESH_INACT to determine whether activity or inactivity is
+	 * detected.
+	 *
+	 * In ac-coupled operation for activity detection, the acceleration
+	 * value at the start of activity detection is taken as a reference
+	 * value. New samples of acceleration are then compared to this
+	 * reference value, and if the magnitude of the difference exceeds the
+	 * THRESH_ACT value, the device triggers an activity interrupt.
+	 *
+	 * Similarly, in ac-coupled operation for inactivity detection, a
+	 * reference value is used for comparison and is updated whenever the
+	 * device exceeds the inactivity threshold. After the reference value
+	 * is selected, the device compares the magnitude of the difference
+	 * between the reference value and the current acceleration with
+	 * THRESH_INACT. If the difference is less than the value in
+	 * THRESH_INACT for the time in TIME_INACT, the device is  considered
+	 * inactive and the inactivity interrupt is triggered.
+	 */
+	ret = regmap_update_bits(st->regmap, ADXL345_REG_ACT_INACT_CTRL,
+				 ADXL345_REG_ACT_ACDC_MSK, st->act_ac);
+	if (ret)
+		return ret;
+
+	/*
+	 * The ADXL345 allows for individually enabling/disabling axis for
+	 * activity and inactivity detection, respectively. Here both axis are
+	 * kept in sync, i.e. an axis will be generally enabled or disabled for
+	 * both equally, activity and inactivity detection.
+	 */
+	st->act_axis_ctrl = en
+		? st->act_axis_ctrl | ADXL345_REG_ACT_AXIS_MSK
+		: st->act_axis_ctrl & ~ADXL345_REG_ACT_AXIS_MSK;
+
+	ret = regmap_update_bits(st->regmap, ADXL345_REG_ACT_INACT_CTRL,
+				 ADXL345_REG_ACT_AXIS_MSK,
+				 st->act_axis_ctrl);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int adxl345_set_act_int(struct adxl345_state *st)
+{
+	bool args_valid;
+	bool axis_en;
+
+	axis_en = FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, st->act_axis_ctrl) > 0;
+	args_valid = axis_en && st->act_value > 0;
+	adxl345_intmap_switch_bit(st, args_valid, ADXL345_INT_ACTIVITY);
+
+	return adxl345_write_interrupts(st);
+}
+
+static int _adxl345_is_act_en(struct adxl345_state *st, bool *en)
+{
+	int ret;
+	unsigned int regval;
+
+	ret = adxl345_read_interrupts(st, &regval);
+	if (ret)
+		return ret;
+
+	*en = FIELD_GET(ADXL345_INT_ACTIVITY, regval) > 0;
+
+	return 0;
+}
+
+static int _adxl345_set_act_en(struct adxl345_state *st, bool en)
+{
+	int ret;
+
+	ret = adxl345_write_act_axis(st, en);
+	if (ret)
+		return ret;
+
+	return adxl345_set_act_int(st);
+}
+
+static int adxl345_is_act_en(struct adxl345_state *st, bool *en)
+{
+	return _adxl345_is_act_en(st, en);
+}
+
+static int adxl345_set_act_en(struct adxl345_state *st, bool en)
+{
+	return _adxl345_set_act_en(st, en);
+}
+
+static int _adxl345_set_act_value(struct adxl345_state *st, u8 val)
+{
+	st->act_value = val;
+
+	return regmap_write(st->regmap, ADXL345_REG_THRESH_ACT, val);
+}
+
+static int adxl345_set_act_value(struct adxl345_state *st, u8 val)
+{
+	return _adxl345_set_act_value(st, val);
+}
+
 /* tap */
 
 static int adxl345_write_tap_axis(struct adxl345_state *st,
@@ -904,6 +1026,7 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}								\
 	static IIO_DEVICE_ATTR_RW(in_accel_##A##_##C##_##E, 0)
 
+ADXL345_generate_iio_dev_attr_INT(activity, act, value);
 ADXL345_generate_iio_dev_attr_INT(freefall, ff, value);
 
 ADXL345_generate_iio_dev_attr_FRACTIONAL(gesture_singletap, tap, duration, MICRO, us);
@@ -911,10 +1034,13 @@ ADXL345_generate_iio_dev_attr_FRACTIONAL(gesture_doubletap, tap, window, MICRO,
 ADXL345_generate_iio_dev_attr_FRACTIONAL(gesture_doubletap, tap, latent, MICRO, us);
 ADXL345_generate_iio_dev_attr_FRACTIONAL(freefall, ff, time, MILLI, ms);
 
+ADXL345_generate_iio_dev_attr_EN(activity, act);
 ADXL345_generate_iio_dev_attr_EN(freefall, ff);
 ADXL345_generate_iio_dev_attr_EN(gesture_doubletap, suppressed);
 
 static struct attribute *adxl345_event_attrs[] = {
+	&iio_dev_attr_in_accel_activity_act_en.dev_attr.attr,
+	&iio_dev_attr_in_accel_activity_act_value.dev_attr.attr,
 	&iio_dev_attr_in_accel_freefall_ff_en.dev_attr.attr,
 	&iio_dev_attr_in_accel_freefall_ff_value.dev_attr.attr,
 	&iio_dev_attr_in_accel_freefall_time_ms.dev_attr.attr,
@@ -1087,20 +1213,25 @@ static int adxl345_get_status(struct adxl345_state *st, unsigned int *int_stat,
 {
 	unsigned int regval;
 	bool check_tap_stat;
+	bool check_act_stat;
 
 	*act_tap_dir = IIO_NO_MOD;
 	check_tap_stat = FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, st->tap_axis_ctrl) > 0;
+	check_act_stat = FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, st->act_axis_ctrl) > 0;
 
-	if (check_tap_stat) {
+	if (check_tap_stat || check_act_stat) {
 		/* ACT_TAP_STATUS should be read before clearing the interrupt */
 		if (regmap_read(st->regmap, ADXL345_REG_ACT_TAP_STATUS, &regval))
 			return -EINVAL;
 
-		if (FIELD_GET(ADXL345_Z_EN, regval) > 0)
+		if ((FIELD_GET(ADXL345_Z_EN, regval >> 4)
+				| FIELD_GET(ADXL345_Z_EN, regval)) > 0)
 			*act_tap_dir = IIO_MOD_Z;
-		else if (FIELD_GET(ADXL345_Y_EN, regval) > 0)
+		else if ((FIELD_GET(ADXL345_Y_EN, regval >> 4)
+				| FIELD_GET(ADXL345_Y_EN, regval)) > 0)
 			*act_tap_dir = IIO_MOD_Y;
-		else if (FIELD_GET(ADXL345_X_EN, regval) > 0)
+		else if ((FIELD_GET(ADXL345_X_EN, regval >> 4)
+				| FIELD_GET(ADXL345_X_EN, regval)) > 0)
 			*act_tap_dir = IIO_MOD_X;
 	}
 
@@ -1154,6 +1285,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
 			return ret;
 	}
 
+	if (FIELD_GET(ADXL345_INT_ACTIVITY, int_stat)) {
+		ret = iio_push_event(indio_dev,
+				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+							act_tap_dir,
+							IIO_EV_TYPE_THRESH,
+							IIO_EV_DIR_RISING),
+				     ts);
+		if (ret)
+			return ret;
+	}
+
 	if (FIELD_GET(ADXL345_INT_FREE_FALL, int_stat)) {
 		ret = iio_push_event(indio_dev,
 				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
@@ -1264,6 +1406,13 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		return -ENODEV;
 	st->fifo_delay = fifo_delay_default;
 
+	/*
+	 * If the feature is enabled, scan all axis for activity and or
+	 * inactivity, and set activity and inactivity to the same ac / dc
+	 * setup.
+	 */
+	st->act_axis_ctrl = ADXL345_REG_ACT_AXIS_MSK;
+	st->act_ac = 0;
 	st->int_map = 0x00;			/* reset interrupts */
 
 	/* Init with reasonable values */
@@ -1272,6 +1421,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	st->tap_window_us = 20;			/*   20 [0x14] -> .025    */
 	st->tap_latent_us = 20;			/*   20 [0x14] -> .025    */
 
+	st->act_value = 6;			/*    6 [0x06]            */
 	st->ff_value = 8;			/*    8 [0x08]            */
 	st->ff_time_ms = 32;			/*   32 [0x20] -> 0.16    */
 
-- 
2.39.5


