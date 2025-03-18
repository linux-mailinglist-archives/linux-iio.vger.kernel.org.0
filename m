Return-Path: <linux-iio+bounces-17057-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B87C7A68082
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 00:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC443BCA71
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 23:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE34A213E79;
	Tue, 18 Mar 2025 23:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsGgOziz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E1F211710;
	Tue, 18 Mar 2025 23:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742339340; cv=none; b=hCiMK1ZFommRifwPQyvtRQThlz4DzdamR73W11BaM49n2aAK5pOMOEdznoQOcPa89GiJiVkDGDXitLZ5VZxcjqLIStB7pcBnE7Z5/2JUxkEhMiQhj3paMLrzIvBISqEYp8wF6aovExMIHf0+U86HqxoRn7OEnWZgm0lC8AG9Q7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742339340; c=relaxed/simple;
	bh=y5IslAqmDg4mdxKMOO+rul3SuVDj/fCUEloCSsCaerQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HCfVrYAbGtSxNqoZukVv5mZ8DMEXft9twGdMc1UAEVopzerk2UmdRJ96fzLo9KQcRaPLEnaS42P9A6ys1aX0c275IYH7nsT4GBo8eFRqKDveycUufJnBSIzGmlm8qB7nKooFRiwjH/PuKo8Bhpjxeo+aUdheO0BVCL0OTzdIsDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsGgOziz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43d16a01deaso1526445e9.2;
        Tue, 18 Mar 2025 16:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742339337; x=1742944137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IMHfkz9v2A2q1ZtzvI5rEiKtpOSbE1j3RQynQq8gEew=;
        b=RsGgOzizkpEnjZbNWff0Oms7QIhrpd5KgJnqdqOUdb3bTxnkAFMDjNz5uoc4oTTSZY
         PNDQxZvXtllfRslCgJ29iPCq3+i/FuWtTCEW1Jao6VNF4Mk/UOmSquj84BcD3yroZdRK
         mfAMVe4rVbEYZiTXuEAg9Fwgb13v5OCa30AbuE6njlgYKYAEPu0fVJ7BVxmkq7zTgQJd
         YvtekrlaLAOaDaX30HwDFSC3Q2a4sAjRrVKxHZ6njoGi4x86QaQa3jDWOx7zvSecd7Qv
         snUUTn+d9PXyrQVbHx4s+nJoTZgvT1JK1oPd/lLvfiDkDG4hsoI9PSVAErI1mKed6oB1
         zpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742339337; x=1742944137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMHfkz9v2A2q1ZtzvI5rEiKtpOSbE1j3RQynQq8gEew=;
        b=mXfA+WJXJsP8y9mvEr0E3rE1BGFvk7zrBvz1HCLkNGZ/MGMQEwfsZWk0YonnCdRzld
         4/BB++pXsNt8v6+4HPYvax3Wl5mUYYQHzkb8vViihtE6x0lIqMdA4TGV/rIYieuWiSyp
         MXitOiIqk5/Z3wq89GLB4flZEn/Rprav8FO18vA5qeAEJ81M8EZo/PbGhCo36JQ+qheq
         /FOsQdpwCjz3Y7TMnH4ZUBKJ1M0iphHw4mmTB/K/D0AdZ2BVM4PL3joCKHVHRjQBUq/t
         k3fE0RFGG9frwoB0tcLCEK6ak1lGalUiM78Wb+2dMsuBVfw9FMyuMXsdvR1yPiy2aPpA
         OrjA==
X-Forwarded-Encrypted: i=1; AJvYcCWVd13sPzwaR/eYJ5wR/z01vkwPjfIRrRO4/GniH6i/TZ/nLX+um8rnDnYsHFc0dleJBJBQrAZ+DO2mUeI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7xSjzJJ5ViIZhVoxHDSf1+xq6RZvon+wVYF/0hhrf9KDqUoT/
	wqqt9/Q6gUxEJFTwyYHmRcATvEytv4sGLBXS4hYAol53GFBlDtWW
X-Gm-Gg: ASbGncv6SxeH6q2H91yQCd5GfcHJtbktSvk6boCkhTHEQa//rINFCS9/TgXiA8YK2WU
	ztmA9ywY4dYJULRRPcpERiFJqefn0bhnr4DqPxy8wK9nKpb19V3wP2mxXFZhiVrrN8jGw4QqEmR
	04NyfIikVDFhOqElgb0Fx0Ofxvb4Y+HOCO5zNkmHbLRYXpSM2EdaXnDPCm3yaMN7efk3z/u+jjG
	5kFX2kFHYSRBjd1W/yy7gYNVg6xDwD11tQX/5sYzAXf8w1lYIaj3bBYi3Nz/pT4vHSCk91o2z5P
	/JxYjH6hNi6JZXyC4c9Mc1du4SSSYitKFVByHCFsQGhooOvsFXzoRT3DlpHygZH8C2FZ4qW7Gtn
	A4OrMnBTobqtPQllMCKrkFAc=
X-Google-Smtp-Source: AGHT+IErgFYAXTPN+AzvrWatg1PvoZzWwKvf6LNCiI5p7gd1tVzCTDhVr+UkJW8OkXhswsTeNtW9YA==
X-Received: by 2002:a05:600c:3ca0:b0:439:930a:58a6 with SMTP id 5b1f17b1804b1-43d438428a9mr992545e9.8.1742339336494;
        Tue, 18 Mar 2025 16:08:56 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d440ed793sm1113455e9.39.2025.03.18.16.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:08:55 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v5 02/11] iio: accel: adxl345: add single tap feature
Date: Tue, 18 Mar 2025 23:08:34 +0000
Message-Id: <20250318230843.76068-3-l.rubusch@gmail.com>
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

Add the single tap feature with a threshold in 62.5mg/LSB points and a
scaled duration in us. Keep singletap threshold in regmap cache but
the scaled value of duration in us as member variable.

Both use IIO channels for individual enable of the x/y/z axis. Initializes
threshold and duration with reasonable content. When an interrupt is
caught it will be pushed to the according IIO channel.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 365 ++++++++++++++++++++++++++++++-
 1 file changed, 362 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index a98fb7fc748e..86104840f2cc 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/bitops.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/property.h>
@@ -17,6 +18,7 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
 #include <linux/iio/kfifo_buf.h>
 
 #include "adxl345.h"
@@ -31,6 +33,29 @@
 #define ADXL345_INT1			0
 #define ADXL345_INT2			1
 
+#define ADXL345_REG_TAP_AXIS_MSK	GENMASK(2, 0)
+
+#define ADXL345_TAP_Z_EN		BIT(0)
+#define ADXL345_TAP_Y_EN		BIT(1)
+#define ADXL345_TAP_X_EN		BIT(2)
+
+/* single/double tap */
+enum adxl345_tap_type {
+	ADXL345_SINGLE_TAP,
+};
+
+static const unsigned int adxl345_tap_int_reg[] = {
+	[ADXL345_SINGLE_TAP] = ADXL345_INT_SINGLE_TAP,
+};
+
+enum adxl345_tap_time_type {
+	ADXL345_TAP_TIME_DUR,
+};
+
+static const unsigned int adxl345_tap_time_reg[] = {
+	[ADXL345_TAP_TIME_DUR] = ADXL345_REG_DUR,
+};
+
 struct adxl345_state {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
@@ -38,9 +63,23 @@ struct adxl345_state {
 	int irq;
 	u8 watermark;
 	u8 fifo_mode;
+
+	u32 tap_duration_us;
+
 	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);
 };
 
+static struct iio_event_spec adxl345_events[] = {
+	{
+		/* single tap */
+		.type = IIO_EV_TYPE_GESTURE,
+		.dir = IIO_EV_DIR_SINGLETAP,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_TIMEOUT),
+	},
+};
+
 #define ADXL345_CHANNEL(index, reg, axis) {					\
 	.type = IIO_ACCEL,						\
 	.modified = 1,							\
@@ -57,6 +96,8 @@ struct adxl345_state {
 		.storagebits = 16,			\
 		.endianness = IIO_LE,			\
 	},						\
+	.event_spec = adxl345_events,			\
+	.num_event_specs = ARRAY_SIZE(adxl345_events),	\
 }
 
 enum adxl345_chans {
@@ -113,6 +154,150 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
 	return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
 }
 
+/* tap */
+
+static int _adxl345_set_tap_int(struct adxl345_state *st,
+				enum adxl345_tap_type type, bool state)
+{
+	unsigned int int_map = 0x00;
+	unsigned int tap_threshold;
+	bool axis_valid;
+	bool singletap_args_valid = false;
+	bool en = false;
+	u32 axis_ctrl;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADXL345_REG_TAP_AXIS, &axis_ctrl);
+	if (ret)
+		return ret;
+
+	axis_valid = FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, axis_ctrl) > 0;
+
+	ret = regmap_read(st->regmap, ADXL345_REG_THRESH_TAP, &tap_threshold);
+	if (ret)
+		return ret;
+
+	/*
+	 * Note: A value of 0 for threshold and/or dur may result in undesirable
+	 *	 behavior if single tap/double tap interrupts are enabled.
+	 */
+	singletap_args_valid = tap_threshold > 0 && st->tap_duration_us > 0;
+
+	if (type == ADXL345_SINGLE_TAP)
+		en = axis_valid && singletap_args_valid;
+
+	if (state && en)
+		int_map |= adxl345_tap_int_reg[type];
+
+	return regmap_update_bits(st->regmap, ADXL345_REG_INT_ENABLE,
+				  adxl345_tap_int_reg[type], int_map);
+}
+
+static int adxl345_is_tap_en(struct adxl345_state *st,
+			     enum iio_modifier axis,
+			     enum adxl345_tap_type type, bool *en)
+{
+	unsigned int regval;
+	bool axis_en;
+	u32 axis_ctrl;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADXL345_REG_TAP_AXIS, &axis_ctrl);
+	if (ret)
+		return ret;
+
+	switch (axis) {
+	case IIO_MOD_X:
+		axis_en = FIELD_GET(ADXL345_TAP_X_EN, axis_ctrl);
+		break;
+	case IIO_MOD_Y:
+		axis_en = FIELD_GET(ADXL345_TAP_Y_EN, axis_ctrl);
+		break;
+	case IIO_MOD_Z:
+		axis_en = FIELD_GET(ADXL345_TAP_Z_EN, axis_ctrl);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_read(st->regmap, ADXL345_REG_INT_ENABLE, &regval);
+	if (ret)
+		return ret;
+
+	*en = (adxl345_tap_int_reg[type] & regval) > 0;
+
+	return 0;
+}
+
+static int adxl345_set_singletap_en(struct adxl345_state *st,
+				    enum iio_modifier axis, bool en)
+{
+	int ret;
+	u32 axis_ctrl;
+
+	switch (axis) {
+	case IIO_MOD_X:
+		axis_ctrl = ADXL345_TAP_X_EN;
+		break;
+	case IIO_MOD_Y:
+		axis_ctrl = ADXL345_TAP_Y_EN;
+		break;
+	case IIO_MOD_Z:
+		axis_ctrl = ADXL345_TAP_Z_EN;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (en)
+		ret = regmap_set_bits(st->regmap, ADXL345_REG_TAP_AXIS,
+				      axis_ctrl);
+	else
+		ret = regmap_clear_bits(st->regmap, ADXL345_REG_TAP_AXIS,
+					axis_ctrl);
+	if (ret)
+		return ret;
+
+	return _adxl345_set_tap_int(st, ADXL345_SINGLE_TAP, en);
+}
+
+static int _adxl345_set_tap_time(struct adxl345_state *st,
+				 enum adxl345_tap_time_type type, u32 val_us)
+{
+	unsigned int regval;
+
+	switch (type) {
+	case ADXL345_TAP_TIME_DUR:
+		st->tap_duration_us = val_us;
+		break;
+	}
+
+	/*
+	 * The scale factor is 1250us / LSB for tap_window_us and tap_latent_us.
+	 * For tap_duration_us the scale factor is 625us / LSB.
+	 */
+	if (type == ADXL345_TAP_TIME_DUR)
+		regval = DIV_ROUND_CLOSEST(val_us, 625);
+	else
+		regval = DIV_ROUND_CLOSEST(val_us, 1250);
+
+	return regmap_write(st->regmap, adxl345_tap_time_reg[type], regval);
+}
+
+static int adxl345_set_tap_duration(struct adxl345_state *st, u32 val_int,
+				    u32 val_fract_us)
+{
+	/*
+	 * Max value is 255 * 625 us = 0.159375 seconds
+	 *
+	 * Note: the scaling is similar to the scaling in the ADXL380
+	 */
+	if (val_int || val_fract_us > 159375)
+		return -EINVAL;
+
+	return _adxl345_set_tap_time(st, ADXL345_TAP_TIME_DUR, val_fract_us);
+}
+
 static int adxl345_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
@@ -198,6 +383,131 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int adxl345_read_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
+{
+	struct adxl345_state *st = iio_priv(indio_dev);
+	bool int_en;
+	int ret;
+
+	switch (type) {
+	case IIO_EV_TYPE_GESTURE:
+		switch (dir) {
+		case IIO_EV_DIR_SINGLETAP:
+			ret = adxl345_is_tap_en(st, chan->channel2,
+						ADXL345_SINGLE_TAP, &int_en);
+			if (ret)
+				return ret;
+			return int_en;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl345_write_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir,
+				      int state)
+{
+	struct adxl345_state *st = iio_priv(indio_dev);
+
+	switch (type) {
+	case IIO_EV_TYPE_GESTURE:
+		switch (dir) {
+		case IIO_EV_DIR_SINGLETAP:
+			return adxl345_set_singletap_en(st, chan->channel2, state);
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl345_read_event_value(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info,
+				    int *val, int *val2)
+{
+	struct adxl345_state *st = iio_priv(indio_dev);
+	unsigned int tap_threshold;
+	int ret;
+
+	switch (type) {
+	case IIO_EV_TYPE_GESTURE:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			/*
+			 * The scale factor would be 62.5mg/LSB (i.e. 0xFF = 16g) but
+			 * not applied here. In context of this general purpose sensor,
+			 * what imports is rather signal intensity than the absolute
+			 * measured g value.
+			 */
+			ret = regmap_read(st->regmap, ADXL345_REG_THRESH_TAP,
+					  &tap_threshold);
+			if (ret)
+				return ret;
+			*val = sign_extend32(tap_threshold, 7);
+			return IIO_VAL_INT;
+		case IIO_EV_INFO_TIMEOUT:
+			*val = st->tap_duration_us;
+			*val2 = 1000000;
+			return IIO_VAL_FRACTIONAL;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl345_write_event_value(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     enum iio_event_info info,
+				     int val, int val2)
+{
+	struct adxl345_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = adxl345_set_measure_en(st, false);
+	if (ret)
+		return ret;
+
+	switch (type) {
+	case IIO_EV_TYPE_GESTURE:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			ret = regmap_write(st->regmap, ADXL345_REG_THRESH_TAP,
+					   min(val, 0xFF));
+			if (ret)
+				return ret;
+			break;
+		case IIO_EV_INFO_TIMEOUT:
+			ret = adxl345_set_tap_duration(st, val, val2);
+			if (ret)
+				return ret;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return adxl345_set_measure_en(st, true);
+}
+
 static int adxl345_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 			      unsigned int writeval, unsigned int *readval)
 {
@@ -416,10 +726,23 @@ static int adxl345_fifo_push(struct iio_dev *indio_dev,
 	return 0;
 }
 
-static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat)
+static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
+			      enum iio_modifier tap_dir)
 {
+	s64 ts = iio_get_time_ns(indio_dev);
 	struct adxl345_state *st = iio_priv(indio_dev);
 	int samples;
+	int ret = -ENOENT;
+
+	if (FIELD_GET(ADXL345_INT_SINGLE_TAP, int_stat)) {
+		ret = iio_push_event(indio_dev,
+				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0, tap_dir,
+							IIO_EV_TYPE_GESTURE,
+							IIO_EV_DIR_SINGLETAP),
+				     ts);
+		if (ret)
+			return ret;
+	}
 
 	if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
 		samples = adxl345_get_samples(st);
@@ -428,9 +751,11 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat)
 
 		if (adxl345_fifo_push(indio_dev, samples) < 0)
 			return -EINVAL;
+
+		return 0;
 	}
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -444,12 +769,33 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 {
 	struct iio_dev *indio_dev = p;
 	struct adxl345_state *st = iio_priv(indio_dev);
+	unsigned int regval;
+	enum iio_modifier tap_dir = IIO_NO_MOD;
+	u32 axis_ctrl;
 	int int_stat;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADXL345_REG_TAP_AXIS, &axis_ctrl);
+	if (ret)
+		return IRQ_NONE;
+
+	if (FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, axis_ctrl)) {
+		ret = regmap_read(st->regmap, ADXL345_REG_ACT_TAP_STATUS, &regval);
+		if (ret)
+			return IRQ_NONE;
+
+		if (FIELD_GET(ADXL345_TAP_Z_EN, regval))
+			tap_dir = IIO_MOD_Z;
+		else if (FIELD_GET(ADXL345_TAP_Y_EN, regval))
+			tap_dir = IIO_MOD_Y;
+		else if (FIELD_GET(ADXL345_TAP_X_EN, regval))
+			tap_dir = IIO_MOD_X;
+	}
 
 	if (regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, &int_stat))
 		return IRQ_NONE;
 
-	if (adxl345_push_event(indio_dev, int_stat))
+	if (adxl345_push_event(indio_dev, int_stat, tap_dir))
 		goto err;
 
 	if (FIELD_GET(ADXL345_INT_OVERRUN, int_stat))
@@ -468,6 +814,10 @@ static const struct iio_info adxl345_info = {
 	.read_raw	= adxl345_read_raw,
 	.write_raw	= adxl345_write_raw,
 	.write_raw_get_fmt	= adxl345_write_raw_get_fmt,
+	.read_event_config = adxl345_read_event_config,
+	.write_event_config = adxl345_write_event_config,
+	.read_event_value = adxl345_read_event_value,
+	.write_event_value = adxl345_write_event_value,
 	.debugfs_reg_access = &adxl345_reg_access,
 	.hwfifo_set_watermark = adxl345_set_watermark,
 };
@@ -501,6 +851,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 					 ADXL345_DATA_FORMAT_JUSTIFY |
 					 ADXL345_DATA_FORMAT_FULL_RES |
 					 ADXL345_DATA_FORMAT_SELF_TEST);
+	unsigned int tap_threshold;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
@@ -514,6 +865,10 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		return -ENODEV;
 	st->fifo_delay = fifo_delay_default;
 
+	/* Init with reasonable values */
+	tap_threshold = 48;			/*   48 [0x30] -> ~3g     */
+	st->tap_duration_us = 16;		/*   16 [0x10] -> .010    */
+
 	indio_dev->name = st->info->name;
 	indio_dev->info = &adxl345_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -586,6 +941,10 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		if (ret)
 			return ret;
 
+		ret = regmap_write(st->regmap, ADXL345_REG_THRESH_TAP, tap_threshold);
+		if (ret)
+			return ret;
+
 		/* FIFO_STREAM mode is going to be activated later */
 		ret = devm_iio_kfifo_buffer_setup(dev, indio_dev, &adxl345_buffer_ops);
 		if (ret)
-- 
2.39.5


