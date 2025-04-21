Return-Path: <linux-iio+bounces-18471-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE20A958F4
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 00:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3C747A5026
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 22:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E7B1519B8;
	Mon, 21 Apr 2025 22:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmLvN31b"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A36821D5A6;
	Mon, 21 Apr 2025 22:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745273222; cv=none; b=Ssk9dz2xlp4WpOcBDMW0Sd8wYbwrfatzZQD7OF/wt+bakHliIzUjKQ9+jdwt/HP2Hdd1jya0XvlOONZ/RyKS0sXNYMvWx4COOmIOGcOKz8IseiKOa8ONDI4gon2oSZocf6j8s+4n28D0Kc4mBG7EhjouowId7JJ9kHH3muPpAMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745273222; c=relaxed/simple;
	bh=0CGAbwxTgGMgGM/mr6uEkMLoVL7t36cFFW8BH3LDQe4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cNWfc9As/KT8X9u+r1avq71S28vwLnNnybsLVohOLnc7FV4LNVss/vIi2f6I+3SSH/G2Oiixdw+KvNQmC9FewKXswb7GNM8aebnoKkGCt40D0d5K9mH+d+NVqpsJrCIiJTmueHA/IyiBkxnNFEqlL7ICN8N5UE7CtktTxgf0lTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmLvN31b; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5f4aee67d24so687125a12.0;
        Mon, 21 Apr 2025 15:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745273218; x=1745878018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkNLtfmEhNo02EFqwGf9GufdancWAgw/DN+zWQihpvw=;
        b=OmLvN31bNwOfdALnb/nI9IsGCNC0N7RyvzQJCRNsCzqwFssYoXoA8+Mti9OTCvcfsw
         pklQawucqrjQ/Eq2oEXzFUEtybLuctcQ8e3T45Xq/ps7uriMk96m87v6zaSgIujgwPPJ
         /IexnUJFe1nl25wlCf+ESpZO+YZN/2WlNMaD4vTVm2M5DPg1JjQWWT4F5dSVrXfMV35C
         +NRf1RM9SPTJ4/GmGAvXVbNaewOYtJ4sshffSyg4aCH7fopnhyiFhjJ9Qjcmj3beBkzT
         OObjIyaA00h3tzpWQ5YqHPmNqvqhAHpOnJmduhtkcCmwGoH2g4GcRw15XpT9dq1h6EPw
         uP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745273218; x=1745878018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YkNLtfmEhNo02EFqwGf9GufdancWAgw/DN+zWQihpvw=;
        b=jf0M/K0dBvlVIYimkoalXm2PskbqhxxUM4TVP9fuAlHevOkUpNI+6OEBZEatzTZXvK
         l9pQ8r4mzxg+uFwDrhUAgblhatN8eoeUwXXMvwMH6ORm9Z6My+ySZagVJUF2BU/w1fwu
         2D6JgyT3zPd9H+K0rDeKHf/xytYoeUhD9ddZGL5Sd0kOSOZGrBx/jc+Py9DBOjRm6bvm
         THEimTWbHzLf+JoiGUkjv5gd9UmrTwKn3btgsn+oCvA/gzKjJTATRF0TWpUxjk+QRkCt
         n4+Umc/Q+it2TQHAb6k0ZiZ1piU2r9RQbuXrqaCo0A95NOQi73ZWAVIe1n4jNNCQI9yT
         E0QA==
X-Forwarded-Encrypted: i=1; AJvYcCV6W3+hQEJqNS/IaKG0SwSAeZdQkq4PAs/fbKobPANrBBp2f4ixhvtgohHSd+LIYK1zrqgG3CCHfTx9JC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkqj4uqADbjRjYNyTxSk+nKa8rl/mNWXPHpAH4kQzmQlrwMUid
	oCLaDiL18ZWCZBSa1WvLX6cZ4uxUO57FI7SPyWxQ4KrfJL95VeiC
X-Gm-Gg: ASbGnct68GQNxMvIa5lNqzTpG+3gUb4b1dyeqP1dHP1GQGBmOqjuKLpltkraCxoSXUg
	JgSvHfpjVL2uHo2yrT1dyTNm5iJ5XDoJnFj2z2kvXk8yeL5Bpv5K+n+375ln48Gw8jjtxFeQgzR
	LHrARbmGFVTH3Zf1iX1d1pJI5vqYU8D2Ss+OGGYJn3f26pljf+7evZ7WoQ+wePap8sSEsO0PS9T
	WT38fdhwm91LXLIlKpR6t8TVorsSSCqqGlALBpmsvnaWdi7OI5BXK1dT+0b1A2fyK+Y48jRwI1t
	H3ydOKRam3iojQi7braRfD5j1lFLr04JuBUmiEh99b/nC3Zfe2tP4t0iR6qVj40KjMM6KS6RkU3
	1eXDliuvFYVRTdkuipTU=
X-Google-Smtp-Source: AGHT+IETRtU5lnTIaLpR3LqRp0jjMXiVG83gsf0dIwLApwBmafuhK+qzTa6+XlGlsfQ84KHHy5Q24A==
X-Received: by 2002:a17:906:f5a5:b0:ac2:6bf9:e386 with SMTP id a640c23a62f3a-acb74b80cb5mr381911366b.8.1745273218112;
        Mon, 21 Apr 2025 15:06:58 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acbb8d49fdasm80311666b.67.2025.04.21.15.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 15:06:57 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v7 03/11] iio: accel: adxl345: add double tap feature
Date: Mon, 21 Apr 2025 22:06:33 +0000
Message-Id: <20250421220641.105567-4-l.rubusch@gmail.com>
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
index ccb25c35ac07..a95f1c218c0c 100644
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
@@ -268,12 +293,23 @@ static int adxl345_set_singletap_en(struct adxl345_state *st,
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
@@ -305,6 +341,34 @@ static int adxl345_set_tap_duration(struct adxl345_state *st, u32 val_int,
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
@@ -408,6 +472,12 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
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
@@ -429,6 +499,8 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 		switch (dir) {
 		case IIO_EV_DIR_SINGLETAP:
 			return adxl345_set_singletap_en(st, chan->channel2, state);
+		case IIO_EV_DIR_DOUBLETAP:
+			return adxl345_set_doubletap_en(st, state);
 		default:
 			return -EINVAL;
 		}
@@ -468,6 +540,14 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
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
@@ -504,6 +584,16 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
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
@@ -751,6 +841,16 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
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
@@ -875,6 +975,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	/* Init with reasonable values */
 	tap_threshold = 48;			/*   48 [0x30] -> ~3g     */
 	st->tap_duration_us = 16;		/*   16 [0x10] -> .010    */
+	st->tap_window_us = 64;			/*   64 [0x40] -> .080    */
+	st->tap_latent_us = 16;			/*   16 [0x10] -> .020    */
 
 	indio_dev->name = st->info->name;
 	indio_dev->info = &adxl345_info;
-- 
2.39.5


