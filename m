Return-Path: <linux-iio+bounces-14670-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E39D7A20A23
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 13:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F402162CCD
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 12:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A581B0439;
	Tue, 28 Jan 2025 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="El12VTVz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30DD1ACEAF;
	Tue, 28 Jan 2025 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738065706; cv=none; b=CFIHngBH56WvFETPVSwpSVbBWb4FhHVG88+w8EmHC/owc8C3gwcQH1igV4lXJ2n3/G7bwvJ2y/7uyRWYVTEBVADvxo31FaTDQp2XlgEmGOjUw9H8XXsleHGLG1mY4IwnjPbtQH6MyaZq0xfYdz3w0+2wAXst3KnfbTNHfIEhlDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738065706; c=relaxed/simple;
	bh=E97KxUbL38FSBEO6mpg7NPFx2gC0CAYXgXakLUXyIpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eHu6zjHHB5I4X4u2APRZm1wifMfmNkMy8GMfNTE1YRwMm2HBPPnR7P4iiI5GlUs7Pj4V0DDYnizN+2Oe8jEBnAORbbXW60YNtrAYywijXMwp2ORvUanjIpkVzptshGPGxrblcg/9B35ao+1Hhlcja2MocLwBOonVTstUoNnitB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=El12VTVz; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa6b500a685so91390866b.2;
        Tue, 28 Jan 2025 04:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738065702; x=1738670502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pK0C2HvJvXDr8HjTqLM0+B0C7fhzdaX3twoJh9FXeBU=;
        b=El12VTVz6q/Dp/uQhjfPMkKKBElJfpA8QDhS7RZO4Fp23akVfXJ8Gd+9dIkpgDl8mv
         z7A+fgAJle/+CWTQKRVmnU+RHV/i5kzmLZg9YZX4i+F+BEFCTfeW6vijBlkGpECJAzRf
         p1q30X7gVFklzBawarV+loGea4gxi6NYlauT+GOa3l/W4pW6Phd/fUHKNrJjXRfDlfFK
         l6Dnx6ozTjUgM8g8XSMn7S7BXedSw1AU0x1zCTqRxBJmGbcM+mMN6kREeUghrO20IZZF
         qDe8kN+C6drSRq+OmxoVF4b2jr0MqiJqcPQO2bk3zFMQ4HAe7oiCUA4ZUBX8v27LM8vG
         sZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738065702; x=1738670502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pK0C2HvJvXDr8HjTqLM0+B0C7fhzdaX3twoJh9FXeBU=;
        b=hTAENSvNcZnCaqqW2JYYL/7RB00DETRo9rwMTe7XecjFtocDTXXFMdFxnWVWB/DwNc
         rRxJtFN8c0joLpuebXKneu5xLEeSp2O9ArkPvrxRmVlqqyNzq1hqtelmSrg2IEUclreB
         XmW28+dTd6OWNxU4067ap4W9jI/UWMY8qgMFUsOQ8r+T5PZNQO+0ofKe8cDcGfneOdJU
         l5rmY4ATkgPCr8lK5xVVi1JruiZ1jQ5WRZoN4WnEoZcRKbK+S9ppGS694aXwE7ShsEuC
         q+4D3hAqvAXOswYPmlL0wmAs++k/douGC4YL4WunvJ028N1bG0zxD8bKr9NMsVaTKHfJ
         R4mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy9dTOQPEIvEw5j6+U79E/JTBYOCnrF2/i85E+zRa9rObI2jpTURetP5q38/pYOztSwdiFeFLGRTwvmPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvZBtjacxwEGqbRPufptxS+QT8vop8aG7x2CUnPFjRDmmmZPgZ
	38c0pr1o97SHaC7VRxgd9iCRHlFoY6128k/vhTqiZovVNu/XQdwr
X-Gm-Gg: ASbGncstwM5ge7kJHSxRgjKB0xLXZL74lE17svknMeOgxiVgeG8X4kZmezGCDmS89dw
	pRJ0WKhIHL2sI5WLaAVoeFgf3/anJPacniHTzHu3swmQoqpUiKnPJ63GzTREiOebQ4ZBKDXoANe
	SSkux4mKzrecutkIJf10bF2BJhnWXHyFYKxOzOXjgjqm0PURPrPbtECrQ3/25R17WIWtdfv1XEv
	M85kcSAMY8bj4tl3AfV0/K+DUa1zxLHCAYEiC8fsXHLdWxggS6ffnnbP8wzN3Rc1rEMB/MjBI4r
	Tw5OxXEjiYQlLwDYlUc5SIAy4tUcrkZWhVnH81ELIbEeStytgulsO8g+559hqjYkQQQS+A==
X-Google-Smtp-Source: AGHT+IHKyXeW+m07+W4HPLs5nlNMncnCSkYc1fzHV1dAnJXaLcvydq7W3CFac8V2g0UXj7YKcNZ5rQ==
X-Received: by 2002:a17:906:dc8e:b0:aa6:9407:34d3 with SMTP id a640c23a62f3a-ab38b362140mr1524250466b.9.1738065701665;
        Tue, 28 Jan 2025 04:01:41 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab69f8555b7sm418865966b.71.2025.01.28.04.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 04:01:40 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v1 08/12] iio: accel: adxl345: add double tap feature
Date: Tue, 28 Jan 2025 12:00:56 +0000
Message-Id: <20250128120100.205523-9-l.rubusch@gmail.com>
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

Add the double tap feature of the sensor. The interrupt handler needs
to catch and forwared the event to the IIO channel. The single tap
implementation now is extended to deal with double tap as well.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 139 ++++++++++++++++++++++++++++---
 1 file changed, 127 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 7831ec511941..f9e5f47ba303 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -129,6 +129,29 @@ enum adxl345_axis {
 	ADXL345_TAP_SUPPRESS = BIT(3),
 };
 
+/* single/double tap */
+enum adxl345_tap_type {
+	ADXL345_SINGLE_TAP,
+	ADXL345_DOUBLE_TAP
+};
+
+static const unsigned int adxl345_tap_int_reg[2] = {
+	[ADXL345_SINGLE_TAP] = ADXL345_INT_SINGLE_TAP,
+	[ADXL345_DOUBLE_TAP] = ADXL345_INT_DOUBLE_TAP,
+};
+
+enum adxl345_tap_time_type {
+	ADXL345_TAP_TIME_LATENT,
+	ADXL345_TAP_TIME_WINDOW,
+	ADXL345_TAP_TIME_DUR
+};
+
+static const unsigned int adxl345_tap_time_reg[3] = {
+	[ADXL345_TAP_TIME_LATENT] = ADXL345_REG_LATENT,
+	[ADXL345_TAP_TIME_WINDOW] = ADXL345_REG_WINDOW,
+	[ADXL345_TAP_TIME_DUR] = ADXL345_REG_DUR,
+};
+
 struct adxl345_state {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
@@ -142,6 +165,8 @@ struct adxl345_state {
 	u32 tap_axis_ctrl;
 	u8 tap_threshold;
 	u32 tap_duration_us;
+	u32 tap_latent_us;
+	u32 tap_window_us;
 
 	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);
 };
@@ -154,6 +179,12 @@ static struct iio_event_spec adxl345_events[] = {
 		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
 		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
 	},
+	{
+		/* double tap */
+		.type = IIO_EV_TYPE_GESTURE,
+		.dir = IIO_EV_DIR_DOUBLETAP,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE),
+	},
 };
 
 #define ADXL345_CHANNEL(index, reg, axis) {					\
@@ -250,10 +281,12 @@ static int adxl345_write_tap_axis(struct adxl345_state *st,
 					     st->tap_axis_ctrl));
 }
 
-static int _adxl345_set_tap_int(struct adxl345_state *st, bool state)
+static int _adxl345_set_tap_int(struct adxl345_state *st,
+				enum adxl345_tap_type type, bool state)
 {
 	bool axis_valid;
 	bool singletap_args_valid = false;
+	bool doubletap_args_valid = false;
 	bool en = false;
 
 	axis_valid = FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, st->tap_axis_ctrl) > 0;
@@ -264,14 +297,24 @@ static int _adxl345_set_tap_int(struct adxl345_state *st, bool state)
 	 */
 	singletap_args_valid = st->tap_threshold > 0 && st->tap_duration_us > 0;
 
-	en = axis_valid && singletap_args_valid;
+	if (type == ADXL345_SINGLE_TAP) {
+		en = axis_valid && singletap_args_valid;
+	} else {
+		/* doubletap: Window must be equal or greater than latent! */
+		doubletap_args_valid = st->tap_latent_us > 0 &&
+			st->tap_window_us > 0 &&
+			st->tap_window_us >= st->tap_latent_us;
+
+		en = axis_valid && singletap_args_valid && doubletap_args_valid;
+	}
 
-	adxl345_intmap_switch_bit(st, state && en, ADXL345_INT_SINGLE_TAP);
+	adxl345_intmap_switch_bit(st, state && en, adxl345_tap_int_reg[type]);
 
 	return adxl345_write_interrupts(st);
 }
 
-static int adxl345_is_tap_en(struct adxl345_state *st, bool *en)
+static int adxl345_is_tap_en(struct adxl345_state *st,
+			     enum adxl345_tap_type type, bool *en)
 {
 	int ret;
 	unsigned int regval;
@@ -280,7 +323,8 @@ static int adxl345_is_tap_en(struct adxl345_state *st, bool *en)
 	if (ret)
 		return ret;
 
-	*en = FIELD_GET(ADXL345_INT_SINGLE_TAP, regval) > 0;
+	// TODO FIELD_GET() seems not possible here due to construct 'not const', any ideas?
+	*en = (adxl345_tap_int_reg[type] & regval) > 0;
 
 	return 0;
 }
@@ -294,7 +338,12 @@ static int adxl345_set_singletap_en(struct adxl345_state *st,
 	if (ret)
 		return ret;
 
-	return _adxl345_set_tap_int(st, en);
+	return _adxl345_set_tap_int(st, ADXL345_SINGLE_TAP, en);
+}
+
+static int adxl345_set_doubletap_en(struct adxl345_state *st, bool en)
+{
+	return _adxl345_set_tap_int(st, ADXL345_DOUBLE_TAP, en);
 }
 
 static int adxl345_set_tap_value(struct adxl345_state *st, u8 val)
@@ -304,19 +353,33 @@ static int adxl345_set_tap_value(struct adxl345_state *st, u8 val)
 	return regmap_write(st->regmap, ADXL345_REG_THRESH_TAP, min(val, 0xFF));
 }
 
-static int _adxl345_set_tap_time(struct adxl345_state *st, u32 val_us)
+static int _adxl345_set_tap_time(struct adxl345_state *st,
+				 enum adxl345_tap_time_type type, u32 val_us)
 {
 	unsigned int regval;
 
-	st->tap_duration_us = val_us;
+	switch (type) {
+	case ADXL345_TAP_TIME_WINDOW:
+		st->tap_window_us = val_us;
+		break;
+	case ADXL345_TAP_TIME_LATENT:
+		st->tap_latent_us = val_us;
+		break;
+	case ADXL345_TAP_TIME_DUR:
+		st->tap_duration_us = val_us;
+		break;
+	}
 
 	/*
 	 * The scale factor is 1250us / LSB for tap_window_us and tap_latent_us.
 	 * For tap_duration_us the scale factor is 625us / LSB.
 	 */
-	regval = DIV_ROUND_CLOSEST(val_us, 625);
+	if (type == ADXL345_TAP_TIME_DUR)
+		regval = DIV_ROUND_CLOSEST(val_us, 625);
+	else
+		regval = DIV_ROUND_CLOSEST(val_us, 1250);
 
-	return regmap_write(st->regmap, ADXL345_REG_DUR, regval);
+	return regmap_write(st->regmap, adxl345_tap_time_reg[type], regval);
 }
 
 static int adxl345_set_tap_duration(struct adxl345_state *st, u32 val_int,
@@ -330,7 +393,35 @@ static int adxl345_set_tap_duration(struct adxl345_state *st, u32 val_int,
 	if (val_int || val_fract_us > 159375)
 		return -EINVAL;
 
-	return _adxl345_set_tap_time(st, val_fract_us);
+	return _adxl345_set_tap_time(st, ADXL345_TAP_TIME_DUR, val_fract_us);
+}
+
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
 }
 
 static int adxl345_read_raw(struct iio_dev *indio_dev,
@@ -448,10 +539,15 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
 				return -EINVAL;
 			}
 
-			ret = adxl345_is_tap_en(st, &int_en);
+			ret = adxl345_is_tap_en(st, ADXL345_SINGLE_TAP, &int_en);
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
@@ -491,6 +587,8 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 		}
 
 		return adxl345_set_singletap_en(st, axis, state);
+	case IIO_EV_DIR_DOUBLETAP:
+		return adxl345_set_doubletap_en(st, state);
 	default:
 		return -EINVAL;
 	}
@@ -637,9 +735,13 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
 	static IIO_DEVICE_ATTR_RW(in_accel_##A##_##C##_##E, 0)
 
 ADXL345_generate_iio_dev_attr_FRACTIONAL(gesture_singletap, tap, duration, MICRO, us);
+ADXL345_generate_iio_dev_attr_FRACTIONAL(gesture_doubletap, tap, window, MICRO, us);
+ADXL345_generate_iio_dev_attr_FRACTIONAL(gesture_doubletap, tap, latent, MICRO, us);
 
 static struct attribute *adxl345_event_attrs[] = {
 	&iio_dev_attr_in_accel_gesture_singletap_duration_us.dev_attr.attr,
+	&iio_dev_attr_in_accel_gesture_doubletap_latent_us.dev_attr.attr,
+	&iio_dev_attr_in_accel_gesture_doubletap_window_us.dev_attr.attr,
 	NULL
 };
 
@@ -861,6 +963,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
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
 
@@ -965,6 +1078,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	/* Init with reasonable values */
 	st->tap_threshold = 35;			/*   35 [0x23]            */
 	st->tap_duration_us = 3;		/*    3 [0x03] -> .001875 */
+	st->tap_window_us = 20;			/*   20 [0x14] -> .025    */
+	st->tap_latent_us = 20;			/*   20 [0x14] -> .025    */
 
 	indio_dev->name = st->info->name;
 	indio_dev->info = &adxl345_info;
-- 
2.39.5


