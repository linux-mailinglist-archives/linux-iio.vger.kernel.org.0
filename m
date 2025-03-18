Return-Path: <linux-iio+bounces-17058-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB3EA68081
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 00:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADECC1892578
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 23:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7967205E36;
	Tue, 18 Mar 2025 23:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDukmi+o"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3D02135A9;
	Tue, 18 Mar 2025 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742339341; cv=none; b=ju20rIAlGG0eoknnBDAO1X8QIMnGpO7FPiNHVA7EPazckGzsj1m/fglnVMyviWCYLoD1dfy35rya6r558F12QLEGUA+JZWlNnigsGabRTyJe9IYAlgw6D50fDmH5YX83+yZj6TKT2PIh4mmTF91hf9lnhpgVWVkgoLAbc/nzTiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742339341; c=relaxed/simple;
	bh=PnA3gkAKR9j1sQPf2K2flhREM56meu3VB7HAqRauyC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X95grRwVac2lpYx6l9bNsy9O0FtHsYFINR7KvIdjD4lgYbK2VjHvlgmHLB6XlUIpy1Bb0axkBFSNtyWrmYHRRRt9AgvvlDeW7rci8YMcJwUALGruX1kNs5pzyohecfqjZtxMueR8iiylshZWY0GvUTcINJk2jTfMv7P5va5QA2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDukmi+o; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43938828d02so6397105e9.1;
        Tue, 18 Mar 2025 16:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742339338; x=1742944138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dB0EYpnHKI9P7vCaj/PqV9XKwE6uJs4DCnLjT7T6Du4=;
        b=MDukmi+oTd75mL5ESjASmBs+fGZcIKTY5FS8lp536fG+NcCv4Y/aR+AFRkiQYFMDr/
         QE2rsg7r733GVvFc4fBd3sGFxInKXu/kezRAuwemsKH6M8fPhKlmLgfyrLGdiX6aLm3U
         HMXfK0XlxrO0e7t5wVcXda6LlaqLKWuaeSXI6DKHSl0gOSlH9E4C+JXHC0VrLrDnKOKW
         2knIT4V0MwRFGVYHoYs+PCpnIRy4R14LTa6RER6cBdRMcI8jde5JIGdvZuUbCI+QZ1k+
         V4quDdu/tRZGpvOvEPW08MCgH1btX0CniWhu4dgP9Mhxo/32idnwSbRLyRrvol1QXE8M
         gyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742339338; x=1742944138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dB0EYpnHKI9P7vCaj/PqV9XKwE6uJs4DCnLjT7T6Du4=;
        b=lC3jmX3hghSJzHUVNoERHjzCKDVa63WMj0qna56rh6qKk+8fEI/yJ9uNM67s1U9KBt
         9nTjR3b/HcMegDFeMYDDpDIbyRJ+8vdRgV9Ds9iK509PSRqVwIktYCPHA21TPQWqaq42
         ZLNYFrsyPkoSfjQMubZTsklI09Wqb2HFBCNU7qFeOTm8w+2Aem9n6xjNteKWjjy6YZto
         BojT8as+9r07XjvjXt2dZRSRSFuz/A7WxCUUXwg7o9NiboyV2+ytGrImExeFfU5AMKCK
         ew+gqFCSwj3ewM+sE8sFTVUpyMKDKajBKBQvKMccgHwW4g9VrN+ss+imgmZ9Vcz1/zF3
         imhw==
X-Forwarded-Encrypted: i=1; AJvYcCWqLTB10C+4z5NtNG5vfz47z1sJvjKE64G2H0jFReVqvpzqcgIQgBs56cUmeKmiAx1jS6VDLmOk7jtBI4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMp08jx8+n+sbfggaiN3yetIl26l63UXWha/ugDnbOG1r8q+u5
	Dg0yTVaz+36hWIpBT62mZhhQ8NtAlS88fhwLk3XFlHPXURm4FX3A
X-Gm-Gg: ASbGncspW9Dq9u0sC7b4Fq1SV/hlAX+jQJEkj167Fcxli1SB/JeBQ9GYO4zqPezyk/7
	T+5bvvnN4YoiGsdv1noSqkwW780ruP062+fcysckHDiVXa9YmnbktHnxc/q9rU7F1ZhUCGGAD4R
	Eg6WvyIAokbIgCeSWag9SALLtJSzZVbcODFe+urfmUFqaZZX98Qa903afh+svsL4ntbzKHLzMdY
	2lpm/sdN62Dp1EKJaLqgQpu+8g45c7HoBcHM0yqJXRKRGo8yKwk0bzqzMSKScd+6a6rLQWq5uRw
	L+VrQzzWr9NwjF1xedrodbbwx8cBh/Wu2M5u3UbyA90NzWke6p65t0RlBoeq1YOnzvEghMWNppy
	rIs50N2vlEZx79IjQVJCHVeOo/s5LQCETtQ==
X-Google-Smtp-Source: AGHT+IFfGATH3y/DPGOJdMbFGfXj9JGiUziISkXYBPrT/5awBuWT+CUjXg3fMaGoBIFCUBqq7hG3vg==
X-Received: by 2002:a05:600c:1d0e:b0:43b:c938:1d0e with SMTP id 5b1f17b1804b1-43d43781b95mr1157865e9.2.1742339337644;
        Tue, 18 Mar 2025 16:08:57 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d440ed793sm1113455e9.39.2025.03.18.16.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:08:57 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v5 03/11] iio: accel: adxl345: add double tap feature
Date: Tue, 18 Mar 2025 23:08:35 +0000
Message-Id: <20250318230843.76068-4-l.rubusch@gmail.com>
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

Add the double tap feature of the sensor. The interrupt handler needs
to catch and forward the event to the IIO channel. The single tap
implementation now is extended to deal with double tap as well.

Doubletap introduces window and latency times, both in us. Since both
times are scaled, the 8-bit register value is stored in hardware,
where the scaled value in [us] is stored as member variable.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 104 ++++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 86104840f2cc..9dee819d5252 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -42,17 +42,23 @@
 /* single/double tap */
 enum adxl345_tap_type {
 	ADXL345_SINGLE_TAP,
+	ADXL345_DOUBLE_TAP,
 };
 
 static const unsigned int adxl345_tap_int_reg[] = {
 	[ADXL345_SINGLE_TAP] = ADXL345_INT_SINGLE_TAP,
+	[ADXL345_DOUBLE_TAP] = ADXL345_INT_DOUBLE_TAP,
 };
 
 enum adxl345_tap_time_type {
+	ADXL345_TAP_TIME_LATENT,
+	ADXL345_TAP_TIME_WINDOW,
 	ADXL345_TAP_TIME_DUR,
 };
 
 static const unsigned int adxl345_tap_time_reg[] = {
+	[ADXL345_TAP_TIME_LATENT] = ADXL345_REG_LATENT,
+	[ADXL345_TAP_TIME_WINDOW] = ADXL345_REG_WINDOW,
 	[ADXL345_TAP_TIME_DUR] = ADXL345_REG_DUR,
 };
 
@@ -65,6 +71,8 @@ struct adxl345_state {
 	u8 fifo_mode;
 
 	u32 tap_duration_us;
+	u32 tap_latent_us;
+	u32 tap_window_us;
 
 	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);
 };
@@ -78,6 +86,14 @@ static struct iio_event_spec adxl345_events[] = {
 		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
 			BIT(IIO_EV_INFO_TIMEOUT),
 	},
+	{
+		/* double tap */
+		.type = IIO_EV_TYPE_GESTURE,
+		.dir = IIO_EV_DIR_DOUBLETAP,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
+			BIT(IIO_EV_INFO_RESET_TIMEOUT) |
+			BIT(IIO_EV_INFO_TAP2_MIN_DELAY),
+	},
 };
 
 #define ADXL345_CHANNEL(index, reg, axis) {					\
@@ -163,6 +179,7 @@ static int _adxl345_set_tap_int(struct adxl345_state *st,
 	unsigned int tap_threshold;
 	bool axis_valid;
 	bool singletap_args_valid = false;
+	bool doubletap_args_valid = false;
 	bool en = false;
 	u32 axis_ctrl;
 	int ret;
@@ -183,8 +200,16 @@ static int _adxl345_set_tap_int(struct adxl345_state *st,
 	 */
 	singletap_args_valid = tap_threshold > 0 && st->tap_duration_us > 0;
 
-	if (type == ADXL345_SINGLE_TAP)
+	if (type == ADXL345_SINGLE_TAP) {
 		en = axis_valid && singletap_args_valid;
+	} else {
+		/* doubletap: Window must be equal or greater than latent! */
+		doubletap_args_valid = st->tap_latent_us > 0 &&
+			st->tap_window_us > 0 &&
+			st->tap_window_us >= st->tap_latent_us;
+
+		en = axis_valid && singletap_args_valid && doubletap_args_valid;
+	}
 
 	if (state && en)
 		int_map |= adxl345_tap_int_reg[type];
@@ -261,12 +286,23 @@ static int adxl345_set_singletap_en(struct adxl345_state *st,
 	return _adxl345_set_tap_int(st, ADXL345_SINGLE_TAP, en);
 }
 
+static int adxl345_set_doubletap_en(struct adxl345_state *st, bool en)
+{
+	return _adxl345_set_tap_int(st, ADXL345_DOUBLE_TAP, en);
+}
+
 static int _adxl345_set_tap_time(struct adxl345_state *st,
 				 enum adxl345_tap_time_type type, u32 val_us)
 {
 	unsigned int regval;
 
 	switch (type) {
+	case ADXL345_TAP_TIME_WINDOW:
+		st->tap_window_us = val_us;
+		break;
+	case ADXL345_TAP_TIME_LATENT:
+		st->tap_latent_us = val_us;
+		break;
 	case ADXL345_TAP_TIME_DUR:
 		st->tap_duration_us = val_us;
 		break;
@@ -298,6 +334,34 @@ static int adxl345_set_tap_duration(struct adxl345_state *st, u32 val_int,
 	return _adxl345_set_tap_time(st, ADXL345_TAP_TIME_DUR, val_fract_us);
 }
 
+static int adxl345_set_tap_window(struct adxl345_state *st, u32 val_int,
+				  u32 val_fract_us)
+{
+	/*
+	 * Max value is 255 * 1250 us = 0.318750 seconds
+	 *
+	 * Note: the scaling is similar to the scaling in the ADXL380
+	 */
+	if (val_int || val_fract_us > 318750)
+		return -EINVAL;
+
+	return _adxl345_set_tap_time(st, ADXL345_TAP_TIME_WINDOW, val_fract_us);
+}
+
+static int adxl345_set_tap_latent(struct adxl345_state *st, u32 val_int,
+				  u32 val_fract_us)
+{
+	/*
+	 * Max value is 255 * 1250 us = 0.318750 seconds
+	 *
+	 * Note: the scaling is similar to the scaling in the ADXL380
+	 */
+	if (val_int || val_fract_us > 318750)
+		return -EINVAL;
+
+	return _adxl345_set_tap_time(st, ADXL345_TAP_TIME_LATENT, val_fract_us);
+}
+
 static int adxl345_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
@@ -401,6 +465,12 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
 			if (ret)
 				return ret;
 			return int_en;
+		case IIO_EV_DIR_DOUBLETAP:
+			ret = adxl345_is_tap_en(st, chan->channel2,
+						ADXL345_DOUBLE_TAP, &int_en);
+			if (ret)
+				return ret;
+			return int_en;
 		default:
 			return -EINVAL;
 		}
@@ -422,6 +492,8 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 		switch (dir) {
 		case IIO_EV_DIR_SINGLETAP:
 			return adxl345_set_singletap_en(st, chan->channel2, state);
+		case IIO_EV_DIR_DOUBLETAP:
+			return adxl345_set_doubletap_en(st, state);
 		default:
 			return -EINVAL;
 		}
@@ -461,6 +533,14 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 			*val = st->tap_duration_us;
 			*val2 = 1000000;
 			return IIO_VAL_FRACTIONAL;
+		case IIO_EV_INFO_RESET_TIMEOUT:
+			*val = st->tap_window_us;
+			*val2 = 1000000;
+			return IIO_VAL_FRACTIONAL;
+		case IIO_EV_INFO_TAP2_MIN_DELAY:
+			*val = st->tap_latent_us;
+			*val2 = 1000000;
+			return IIO_VAL_FRACTIONAL;
 		default:
 			return -EINVAL;
 		}
@@ -497,6 +577,16 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
 			if (ret)
 				return ret;
 			break;
+		case IIO_EV_INFO_RESET_TIMEOUT:
+			ret = adxl345_set_tap_window(st, val, val2);
+			if (ret)
+				return ret;
+			break;
+		case IIO_EV_INFO_TAP2_MIN_DELAY:
+			ret = adxl345_set_tap_latent(st, val, val2);
+			if (ret)
+				return ret;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -744,6 +834,16 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
 			return ret;
 	}
 
+	if (FIELD_GET(ADXL345_INT_DOUBLE_TAP, int_stat)) {
+		ret = iio_push_event(indio_dev,
+				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, tap_dir,
+							IIO_EV_TYPE_GESTURE,
+							IIO_EV_DIR_DOUBLETAP),
+				     ts);
+		if (ret)
+			return ret;
+	}
+
 	if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
 		samples = adxl345_get_samples(st);
 		if (samples < 0)
@@ -868,6 +968,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	/* Init with reasonable values */
 	tap_threshold = 48;			/*   48 [0x30] -> ~3g     */
 	st->tap_duration_us = 16;		/*   16 [0x10] -> .010    */
+	st->tap_window_us = 64;			/*   64 [0x40] -> .080    */
+	st->tap_latent_us = 16;			/*   16 [0x10] -> .020    */
 
 	indio_dev->name = st->info->name;
 	indio_dev->info = &adxl345_info;
-- 
2.39.5


