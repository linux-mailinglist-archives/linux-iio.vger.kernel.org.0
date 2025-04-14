Return-Path: <linux-iio+bounces-18107-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B49A88B8D
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 20:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14385172982
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 18:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F258228DEFC;
	Mon, 14 Apr 2025 18:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5lPklgq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9026C156236;
	Mon, 14 Apr 2025 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744656175; cv=none; b=gjIaIF0PZHi/1mtNw4AChTtBhSgnuxMqGnZSUIw+BLeUsH8KSZ8L+XMZKcuupSXoYydHp+kw7OLpL3UmmiFhpVLF/dz74mxFRXaS56RLBC5PwAM3NTFez8LL5Obx1YENe8UuZmDT0amA9FrP/1jwqLCy+Mt80QpF0PQ1sAa7VLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744656175; c=relaxed/simple;
	bh=5RxrPYtZ7I6Dt5qarm4tttwb4MttmZTzMw61EXrH4Qc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kAYgmy/WyrxoJuBU4Vunko4Le7W9iW18ScMronHxHTRFXZnY5BeGaPalWdWMQWSf2NGfcaNVJ4ZG1sKxLEGjPnIPI/6rOrfb1Aki7lVwCNSAQpBIdUyFnOTtEmf3QrO4s9TBlsEaikpLyAXy1CFkkwAOH5/BsATrT6ZMNdSGIS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5lPklgq; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2c7a36802so85358366b.2;
        Mon, 14 Apr 2025 11:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744656172; x=1745260972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfWNkGnK7ineJbQkLTaDbBS+hsswOkVBZ94MBtsFSmo=;
        b=K5lPklgqX+DFB//9nImfo2sg9nzcRFRnZpgAOKS275y9Np6xjtqtuT+uurindTKM6J
         2GvEjlx2v7tP9BRur2wyXkl+YwoU7LuMoeJ91nX3J+/FDuXNNfRhdT+KMg309+XpPscs
         /bEv4JCmW3S2VQaz/yxalYAaFHK2wR/M5HoSdReRo+t8ItFwG+7QJt9fUUagVXXeOHxG
         cteFBmffPCIPH7bUaNwzxjLkGLa9EncJW3LNez7vPMombfLsuElt6odIOwDRiV7FkSuR
         zwtSXi1it+8EF5ILivxWPelf0MwXT8wvKg+fWnfwvZW0EFCNEmmxvXZH5SyQqWjBjcQk
         DOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744656172; x=1745260972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfWNkGnK7ineJbQkLTaDbBS+hsswOkVBZ94MBtsFSmo=;
        b=KrlHmq2PDVoYx80qLgRVZ7hZ2z/X+cx+rVaFCKgmZ2pMcADqsyDHwKYkk+Bx64iLm0
         /YBf7oXkJ1khCg2KabrJcd3nTPmrmxVPMMKCUKcObTkX6427Vhrg8PVJyfgfIh9ZI2zx
         1JngWUh5sQh/iqVnfEob7fIr3YJclKWOWb+yCE5G9tYv/YJ8xnl0CAdPFNpdlrW/ITx3
         3n0QwCk01RKqgqcMiMhu2fuGBlMlmVt6gjoJNRBPXeM1tB7FpsF0YWeZXuPk23Oka02T
         XzJ2UhncAxfdxlwLsicqH0fe5X+yguzPhst9567+Jnr8OY/jNHIKDUy+3MzXigiGvRCH
         Lntg==
X-Forwarded-Encrypted: i=1; AJvYcCXa+M55uGNmhzCwgpo+NScHzo6EKRPF+jDnpk10hdFJ1BNcsLh+Etqf++XhoXWL5EuxtJw4aCYRKvTeyK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWMsdvXBzGKG3ly4COwBZJR9pt5iUbJ5rYpGwFxxWovdGGGmAE
	n6JnRHsCU6P2huv9SU846WOSXgh6iNhgQ/B0Yq+cVGtOtzjD5G0o
X-Gm-Gg: ASbGncvkE9Mk9FbntOtYomqP9vvM/GPfvApyEM9+tCFRhuoSyYM8s30CqkYqbPLpSfm
	kQiB4lDIVKWziTBqm4180KVyheDecoi356v1QNJVahNrI9Ao6/aTspKVXLocNZbyCMVw2Fr+pIh
	SlIQheR1FIqEAt50ql85L/8kLA3XDIPD/nAgyVMR6ciTNbgpruRCVootU6TDtGOZkPhAcof+Gzw
	8QGfjtVErK54oW/HcRya5/NEHzHC8ahV9YG3+quEf7YDllG4eCHdNFURFvhqg6ui9hID8HXbssj
	ofO3lGmSnU80eOKbfi74fJy6mPQ93iDwaFs3TVD0xVP5EYaGlyYwCRS50bn90MAurvyYc3s01m4
	/32aMb1c6gMIUehrPWrk=
X-Google-Smtp-Source: AGHT+IFayrictClLxvWNwCsh0gJp3btoMn1UzriyLE71QmzMois11lWSPynzRqW4jKoUJtT5c5+KdQ==
X-Received: by 2002:a17:907:c8a8:b0:ac4:4c2:e8c7 with SMTP id a640c23a62f3a-acad36a1d86mr423144466b.12.1744656171567;
        Mon, 14 Apr 2025 11:42:51 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bb3172sm946483466b.24.2025.04.14.11.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 11:42:51 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v6 02/11] iio: accel: adxl345: add single tap feature
Date: Mon, 14 Apr 2025 18:42:36 +0000
Message-Id: <20250414184245.100280-3-l.rubusch@gmail.com>
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

Add the single tap feature with a threshold in 62.5mg/LSB points and a
scaled duration in us. Keep singletap threshold in regmap cache but
the scaled value of duration in us as member variable.

Both use IIO channels for individual enable of the x/y/z axis. Initializes
threshold and duration with reasonable content. When an interrupt is
caught it will be pushed to the according IIO channel.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 372 ++++++++++++++++++++++++++++++-
 1 file changed, 369 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index a98fb7fc748e..ccb25c35ac07 100644
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
@@ -113,6 +154,157 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
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
+	u32 axis_ctrl;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADXL345_REG_TAP_AXIS, &axis_ctrl);
+	if (ret)
+		return ret;
+
+	/* Verify if axis is enabled for the tap detection. */
+	switch (axis) {
+	case IIO_MOD_X:
+		*en = FIELD_GET(ADXL345_TAP_X_EN, axis_ctrl);
+		break;
+	case IIO_MOD_Y:
+		*en = FIELD_GET(ADXL345_TAP_Y_EN, axis_ctrl);
+		break;
+	case IIO_MOD_Z:
+		*en = FIELD_GET(ADXL345_TAP_Z_EN, axis_ctrl);
+		break;
+	default:
+		*en = false;
+		return -EINVAL;
+	}
+
+	if (*en) {
+		/*
+		 * If axis allow for tap detection, verify if the interrupt is
+		 * enabled for tap detection.
+		 */
+		ret = regmap_read(st->regmap, ADXL345_REG_INT_ENABLE, &regval);
+		if (ret)
+			return ret;
+
+		*en = adxl345_tap_int_reg[type] & regval;
+	}
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
@@ -198,6 +390,131 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
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
+				      bool state)
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
@@ -416,10 +733,23 @@ static int adxl345_fifo_push(struct iio_dev *indio_dev,
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
@@ -428,9 +758,11 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat)
 
 		if (adxl345_fifo_push(indio_dev, samples) < 0)
 			return -EINVAL;
+
+		ret = 0;
 	}
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -444,12 +776,33 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
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
@@ -468,6 +821,10 @@ static const struct iio_info adxl345_info = {
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
@@ -501,6 +858,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 					 ADXL345_DATA_FORMAT_JUSTIFY |
 					 ADXL345_DATA_FORMAT_FULL_RES |
 					 ADXL345_DATA_FORMAT_SELF_TEST);
+	unsigned int tap_threshold;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
@@ -514,6 +872,10 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		return -ENODEV;
 	st->fifo_delay = fifo_delay_default;
 
+	/* Init with reasonable values */
+	tap_threshold = 48;			/*   48 [0x30] -> ~3g     */
+	st->tap_duration_us = 16;		/*   16 [0x10] -> .010    */
+
 	indio_dev->name = st->info->name;
 	indio_dev->info = &adxl345_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -586,6 +948,10 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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


