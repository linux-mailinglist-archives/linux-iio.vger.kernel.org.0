Return-Path: <linux-iio+bounces-18108-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F30ACA88B8E
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 20:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 891697A2420
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 18:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA95428E5EE;
	Mon, 14 Apr 2025 18:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0RLJZRm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9E1289340;
	Mon, 14 Apr 2025 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744656176; cv=none; b=Er3d87cg2IYe4pBCOwPR1+NuPAdiQ/jthsPyrwbxbJMKA8wPn1/76rdi2he18pT4RYZogjj0rA4SvXR88urAly0YV0xjtbZiU6/9weaRnuiPbpmn3ShXYgl14RTT307wETYL+PtN0tzPxbMt8caYHM3Meuio6tCOYae23ACWvQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744656176; c=relaxed/simple;
	bh=0CGAbwxTgGMgGM/mr6uEkMLoVL7t36cFFW8BH3LDQe4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kuS7zttrajmUANqruTS18HLRR23m2BFWHEAI0e0jxHg1xMkQT86fuaD6Sa4BVLSAY8Y8zL6akmNnKg6pEdAxDHpUo/oYR95mKMVijbu0eH96FRVlUpNSwrtmkiVZV8PqbtHPmxcYSubf6LttHN9aegwFDt46fPewXdvXQiYMYcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0RLJZRm; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab7098af6fdso90460766b.2;
        Mon, 14 Apr 2025 11:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744656173; x=1745260973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkNLtfmEhNo02EFqwGf9GufdancWAgw/DN+zWQihpvw=;
        b=T0RLJZRmcjMo+iWITe5goQqRIT5MAlDnV9b/g1aKAFcH+ZYgc5xcyBNJS9EMDWkm3R
         vfyt0HF9Jm/YBO1tlp1wgx7VMfB/wFiSPHhi5LnxfAcf+Wbgg9rH10wHv3hFE00YB6E3
         t+xiKVcs0Dm5DbiwWB8D9kSHVDPxM8+yHu2RWuJeU2aNSPUUCwdgbqMpMf6x3Ri0qLXp
         xQrVpgxOuydanmrNeFmg7iyzYnpXZmTePfkHHW/vjvvqJchQZm+Mc0oQm1p0w3o+HJyi
         FxD/6gCEf/bAZOPJbhF7EDbRCZ1OctKXabXa025Fir0McnlKVsEBiaQ8k10hnHgtTZs7
         T99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744656173; x=1745260973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YkNLtfmEhNo02EFqwGf9GufdancWAgw/DN+zWQihpvw=;
        b=Xwx1H/aAOod7oZqo05WgS//b6uyGPGLt57ietQGMY+eL4WKtBQEiwvZwkjK4B+75gW
         SFj0FCf+hFtMwKU4bNXeulpdoVmwSqeiG2N3z/0oWZf2lfkD/S4raejXYcNBGax/X6Nu
         f1jPX3Jc6R0Ibi0/AeXHfZm+2jblKGy4kE51ae+9O6aAou5GF6e85rJXuQflDdCIc4XA
         aBnQXsMsH1plnXTfOZoadHzPp4Uhqzbw8bMQ/g2vuhcHkROMSu12aUcelm0as09pVKMN
         qPL1zmp5Uvsn2JXaAuDpW6v5Fj6HPVD5g8752uo0pero8YKsVo016RgIfpvfI51WCoK9
         oF6g==
X-Forwarded-Encrypted: i=1; AJvYcCU3ibfcSflwzm+GyqK7usMgkyhuehaMebMYJlhYFuYOn6SzVQyAytpbr3N0YxNfQWVhSs/Kz8QO3jw/kOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF+kCkBo3NHa8Bz6QknFdYbWBYgP0RGs3e9gbL8fDijP+ta/8x
	SFIR9hFgs4gM3l8qN8/X8OwpkNMqpJ4PaXIhJwVC53x2vgayEfvF
X-Gm-Gg: ASbGncsODhZ//CkG8KWF+7ccePxkjs9CFgMGTiiiEw4KmWUjwcOu7KhmKk3Dx466yYA
	/SXfp0ymkKz7IQWmU9ogvEJm0XFWxt3S95kRmcKBjNgV4UrqwEaQq7oLIoa6LqGM1U26hWbNjhI
	GCtk5bV2IyjRr170ccgR664VoKOmEq6iW2HcIHMQYqxqNg7HCBSC7IZVnYSLT7re7D8nguA84hz
	9jbv0wj2gbur1zpcHVqjquCfawuA9MLjsOcFfPNoOWlSX2gu3sy8eCkfbEyvdinJBJ7XtYVC6I1
	y/R6QEs6ANXJm3hT2oQoctfbxlyGcHdDmKGN0Ixaz03fgpSUfsXwJviAlOu3hxp4lGycA2AyDxe
	WkSBi/rxNUcxAgwf65bc=
X-Google-Smtp-Source: AGHT+IGcsvw/qwjnmAOjtLptABi143w/CE5RFQ2t1nxY8HYE3Ilxxpx4rSvZ7T8+XGeGGmISwuQCyg==
X-Received: by 2002:a17:907:9593:b0:ac7:9237:60a8 with SMTP id a640c23a62f3a-acb13da62fdmr24065666b.9.1744656172507;
        Mon, 14 Apr 2025 11:42:52 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bb3172sm946483466b.24.2025.04.14.11.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 11:42:52 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v6 03/11] iio: accel: adxl345: add double tap feature
Date: Mon, 14 Apr 2025 18:42:37 +0000
Message-Id: <20250414184245.100280-4-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414184245.100280-1-l.rubusch@gmail.com>
References: <20250414184245.100280-1-l.rubusch@gmail.com>
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


