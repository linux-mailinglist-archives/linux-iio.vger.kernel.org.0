Return-Path: <linux-iio+bounces-15253-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B11A2EA69
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 12:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA2CE3AB093
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 11:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7041B6CE1;
	Mon, 10 Feb 2025 11:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaeylJyA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909A81E411C;
	Mon, 10 Feb 2025 11:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185304; cv=none; b=m1WZXqdGfF6zktxJjiQjEGgDFfnqRvdofqS8bFcohNHKpYgW8Li1ozMcyTj328VAmXahcHy5kdWl4JslOeP0QHI9Y4F/BFEfmfiRb1st0/dZp39Eff7IneUifT1See2Lu5l4jwk5nFGc694VXw+G5URM3iXfpH86TlQAYKKWP4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185304; c=relaxed/simple;
	bh=cJQBXncRcnbByy/WRb+6/EhlbXvj9i1sJQ+x1kH5WrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l6DElg2FguitC7cSguRdgv9M2vsiLtuwN5jlzE5/wgfxe6abhA66CyR5iBAbJseS/BO0KouabvTHEEv+aPb7iM7+n7jF7yW0/bPWigBw9m9mNKo+Jdbo2nYBJUGJ3Ga/NC08rrcCEb3PDz4a2hmaFVvoUu7gU1dzCunDTUVFrn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaeylJyA; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab790ca8a87so47701866b.3;
        Mon, 10 Feb 2025 03:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739185300; x=1739790100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiCEHmimT/fs+/V86FGfTGKDk57V8U90fK1w4CaiKvA=;
        b=NaeylJyA4WrRQ7GInNOUm8yFfVrhnnhyNz4JaBskgk6HGnhdAlDSRAzT4CRhmbQLXV
         ObJT1arKJuAcevBq/JlaPaQrOAsutoW0Ojrs9Vc9EBCpes7ixNbb9H1wkHCP8KwEn16e
         PmSQyg5m1fX/bMMOgCpj+BwQ9ERve8/HibtDAIQYgBSC0f6CzMUNtwX5aJ8eKLuHkbD6
         zeuH8i/uj6LG4sNvWx8GlXSkjnbh5bMxmUFgLzQW7wHUKARx9c8cOHBmvBrFgmcJlmUB
         egN+IZ8DeNFb7vdK2MGyhoxCXFerjd+szHLdHlI1KKBgb91t1EsM9pqd4dscUS61Ups9
         ghBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739185300; x=1739790100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiCEHmimT/fs+/V86FGfTGKDk57V8U90fK1w4CaiKvA=;
        b=UIVKB7UPgJCJj2yFo4i2BGUq0Zzb8Q2JHwfXt5wWmmm1+YjeLYonRZnSLZ3UBFqq56
         WW6D7nK8P+StgWcwb165XGnYJHrXD9baLIPc5Zz+9MXhG85MdrHwQ0BSaflVe9m1lHFP
         /l2nj4Dfit66wjetSmmR8TCkd0P/VnPq4WxHIOVqeTfARa5QefXSE1g9hJjh/z0eKbmb
         WmDl7PqpRL/rrQ96G5T2gc3cEQbZN5eEgO2p5WwniVoEOFsDCd1sX7eZYcNgBbfHAdU2
         0RksiYkzdzUZtjy1+zNmd/FBLkNaOmlVvEVidyqY2TYocoglEQXZN0S2t1d/UiB7YxtT
         54yA==
X-Forwarded-Encrypted: i=1; AJvYcCUz2c0ANY3dyeo0ze06Edd+n/pZxPNSlYOJLdJ0VUSYoR2O0RQ0R4mH4TzSZXH8ZqYjHGHZs4aSIQmEktE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4TBnNNpW+ysySyXWuqQTGy/s0NOP9gEjv+ETroH/HXxFbjNfB
	WyJMxFrpRokA726DuEk9B+5ncMERIPkAQiRAMWpsmhA81OGFn7qM
X-Gm-Gg: ASbGncsRfJF+vAtXONq+qlYBvygYPyyFIgDOmjrvIgYfild1iusCh1F+bWas18oyMkR
	+zz7TBB0gmfew/tEfijNutM9pW5cw6M+gD/wBT2SPNNlqFprgcRmDdUAaEnoqi2DIv/PxHR+AwM
	RFxwelOi6V88dnsZS+PfgFStzfQxclnbrSu9LCffN7PBTHibXIkK3ntEKcrPBozjzmR96sPqLPP
	tIzbdJ/fCa5wFzOIe4P+r8jCO2o3PD5utrPVGCPSk5I6fdF63j6jT9Qp9t7lDTfIxBQB5h1EdMW
	uBOWuYQlHTIWtmpwjFe8fldJ1dWJFSrfGdM2diNZWD6Rs/FlrbX54XqBVzvV2iG0EUY/Bg==
X-Google-Smtp-Source: AGHT+IFNx1AkxgQEqo3BcZAWVsArR//yZ0DGEJPcW19mY+G9oUIlagb4iXHBQqtmn0elr3fcTvSQyg==
X-Received: by 2002:a17:906:f59b:b0:aa6:6f12:aa45 with SMTP id a640c23a62f3a-ab789bc7a21mr553608866b.7.1739185299668;
        Mon, 10 Feb 2025 03:01:39 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7a5a78369sm486987266b.136.2025.02.10.03.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 03:01:39 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 06/14] iio: accel: adxl345: add double tap feature
Date: Mon, 10 Feb 2025 11:01:11 +0000
Message-Id: <20250210110119.260858-7-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210110119.260858-1-l.rubusch@gmail.com>
References: <20250210110119.260858-1-l.rubusch@gmail.com>
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

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 102 ++++++++++++++++++++++++++++++-
 1 file changed, 100 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 304147a4ca60..cf35a8f9f432 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -46,17 +46,23 @@ enum adxl345_axis {
 /* single/double tap */
 enum adxl345_tap_type {
 	ADXL345_SINGLE_TAP,
+	ADXL345_DOUBLE_TAP,
 };
 
 static const unsigned int adxl345_tap_int_reg[2] = {
 	[ADXL345_SINGLE_TAP] = ADXL345_INT_SINGLE_TAP,
+	[ADXL345_DOUBLE_TAP] = ADXL345_INT_DOUBLE_TAP,
 };
 
 enum adxl345_tap_time_type {
+	ADXL345_TAP_TIME_LATENT,
+	ADXL345_TAP_TIME_WINDOW,
 	ADXL345_TAP_TIME_DUR,
 };
 
 static const unsigned int adxl345_tap_time_reg[3] = {
+	[ADXL345_TAP_TIME_LATENT] = ADXL345_REG_LATENT,
+	[ADXL345_TAP_TIME_WINDOW] = ADXL345_REG_WINDOW,
 	[ADXL345_TAP_TIME_DUR] = ADXL345_REG_DUR,
 };
 
@@ -73,6 +79,8 @@ struct adxl345_state {
 	u32 tap_axis_ctrl;
 	u8 tap_threshold;
 	u32 tap_duration_us;
+	u32 tap_latent_us;
+	u32 tap_window_us;
 
 	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);
 };
@@ -86,6 +94,14 @@ static struct iio_event_spec adxl345_events[] = {
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
 {
 	bool axis_valid;
 	bool singletap_args_valid = false;
+	bool doubletap_args_valid = false;
 	bool en = false;
 
 	axis_valid = FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, st->tap_axis_ctrl) > 0;
@@ -173,8 +190,16 @@ static int _adxl345_set_tap_int(struct adxl345_state *st,
 	 */
 	singletap_args_valid = st->tap_threshold > 0 && st->tap_duration_us > 0;
 
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
 		__set_bit(ilog2(adxl345_tap_int_reg[type]),
@@ -213,6 +238,11 @@ static int adxl345_set_singletap_en(struct adxl345_state *st,
 	return _adxl345_set_tap_int(st, ADXL345_SINGLE_TAP, en);
 }
 
+static int adxl345_set_doubletap_en(struct adxl345_state *st, bool en)
+{
+	return _adxl345_set_tap_int(st, ADXL345_DOUBLE_TAP, en);
+}
+
 static int adxl345_set_tap_threshold(struct adxl345_state *st, u8 val)
 {
 	int ret;
@@ -232,6 +262,12 @@ static int _adxl345_set_tap_time(struct adxl345_state *st,
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
@@ -244,7 +280,7 @@ static int _adxl345_set_tap_time(struct adxl345_state *st,
 	if (type == ADXL345_TAP_TIME_DUR)
 		regval = DIV_ROUND_CLOSEST(val_us, 625);
 	else
-		return 0;
+		regval = DIV_ROUND_CLOSEST(val_us, 1250);
 
 	return regmap_write(st->regmap, adxl345_tap_time_reg[type], regval);
 }
@@ -263,6 +299,34 @@ static int adxl345_set_tap_duration(struct adxl345_state *st, u32 val_int,
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
@@ -380,6 +444,11 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
 			if (ret)
 				return ret;
 			return int_en && axis_en;
+		case IIO_EV_DIR_DOUBLETAP:
+			ret = adxl345_is_tap_en(st, ADXL345_DOUBLE_TAP, &int_en);
+			if (ret)
+				return ret;
+			return int_en;
 		default:
 			return -EINVAL;
 		}
@@ -416,6 +485,8 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 		switch (dir) {
 		case IIO_EV_DIR_SINGLETAP:
 			return adxl345_set_singletap_en(st, axis, state);
+		case IIO_EV_DIR_DOUBLETAP:
+			return adxl345_set_doubletap_en(st, state);
 		default:
 			return -EINVAL;
 		}
@@ -444,6 +515,14 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev, const struct iio_
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
@@ -475,6 +554,12 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
 		case IIO_EV_INFO_TIMEOUT:
 			ret = adxl345_set_tap_duration(st, val, val2);
 			break;
+		case IIO_EV_INFO_RESET_TIMEOUT:
+			ret = adxl345_set_tap_window(st, val, val2);
+			break;
+		case IIO_EV_INFO_TAP2_MIN_DELAY:
+			ret = adxl345_set_tap_latent(st, val, val2);
+			break;
 		default:
 			ret = -EINVAL;
 		}
@@ -757,6 +842,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
 			return ret;
 	}
 
+	if (FIELD_GET(ADXL345_INT_DOUBLE_TAP, int_stat)) {
+		ret = iio_push_event(indio_dev,
+				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+							act_tap_dir,
+							IIO_EV_TYPE_GESTURE,
+							IIO_EV_DIR_DOUBLETAP),
+				     ts);
+		if (ret)
+			return ret;
+	}
+
 	return -ENOENT;
 }
 
@@ -860,6 +956,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	/* Init with reasonable values */
 	st->tap_threshold = 48;			/*   48 [0x30] -> ~3g     */
 	st->tap_duration_us = 16;		/*   16 [0x10] -> .010    */
+	st->tap_window_us = 64;			/*   64 [0x40] -> .080    */
+	st->tap_latent_us = 16;			/*   16 [0x10] -> .020    */
 
 	indio_dev->name = st->info->name;
 	indio_dev->info = &adxl345_info;
-- 
2.39.5


