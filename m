Return-Path: <linux-iio+bounces-20689-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC836ADA45D
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 00:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1BD188608F
	for <lists+linux-iio@lfdr.de>; Sun, 15 Jun 2025 22:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263EE283159;
	Sun, 15 Jun 2025 22:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffe6/wse"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CCE280A3B;
	Sun, 15 Jun 2025 22:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750026193; cv=none; b=ny23u0C7CrO99+tdzU7mCRpvGFiV4WcY/yGC/FBMuuX9gYekq4TnuAc3soblKSjJJptv1wYQJms7PhUoodAjE18fh5s0AFx7Is64QMF1rlSUxN0McxxMBBvf7Pak8Kff77rUxP5ug/FgqzXONzMNnW3rzLi1Y45T+akQzv3Ayb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750026193; c=relaxed/simple;
	bh=CDzC+Dab/5nnNCzsDwpBRd0tqjx1D9QHKg7fh/0UfAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gaidIQiAGXCMcvMQEHcS0+8rr+LP881MepmHA7VBUz32xZjZPLJITZ0porSKGsQK35TDtnLbXKnEWa5w03GpaiggRKHJPqfegpodnSloRB7pTllUkxyuUjFjpgdxp8l35Nrs0WxECF10DHuUANM+x+qiQfOBqNEX3Ja2UUlxxLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffe6/wse; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-606c6bb1d03so761278a12.1;
        Sun, 15 Jun 2025 15:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750026190; x=1750630990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/ftbtqWVPSKTntyYUcVvhlj9HI4YnADjK65oS2i45k=;
        b=ffe6/wseMLyWsaOmDGwTm85rIBd8mt6cHH9vcSfkD1BDjmia5fRp1VWDfxrDSGZTwY
         U925/n8rEqiz5oEN+ngBZIsVPkOPV1Kcqq9KynwFNhbX5EzxllHA84iOUq3x3rk+ZqYl
         cpNnB4cqvCju/Agndvlbq79LDOD3zACNoaTponEdEos2z5EJ3HjkWD/QEeL7ZAFBcjbG
         MPmGeUQQ9rDrpZLdz5qoKUnxsYVnV33vmmmQdjqNslJVGF11al0HoMkswaU//wuEtSpy
         JtqXF2TXuO6OyOceghov2zK3iCPXOyFvf8fxh2excmNbB68ln9kBA6vIqNYHJ+zNrF5g
         n0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750026190; x=1750630990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/ftbtqWVPSKTntyYUcVvhlj9HI4YnADjK65oS2i45k=;
        b=OsWN14s8gXbsVuOWUZvSFTExMi8anf6WjPi5iOOB7J9WZw88sPdtTxXjVEgOXYJ6Zt
         CFtRRe7LjxyikD6LuwF2Rv5R0TCmkvfD5fC0KZlJJXuMqfMddP8AAlVpL0XqUyjdK5Ra
         q6cNiMviCP2eFQ67fsUgYUAEk4dV3k6oDYNice+/xb8+L7ObyDL5Gr7DFO9nZAE8lDpu
         gABSUjHU42CPa/ZTj1Hy7wh3PRj4+xIVyBxB4s/haiM4MUitiEQzEOAwp8naUH+gPLOS
         f1HqcsMR37MgOBj+Rr+hHIvlGD7GbvV36nEzeiaKsJqXuWPUrO/iKGfyECdXpfER2yVe
         LPHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaEkPGiceP3mq3LB4Os9zJZIu5xovTryUmRHGoS3qudyQXLWGoLRYIyP8uI7cF06mI5cjAOxK80og=@vger.kernel.org, AJvYcCVCql2ACjF9hvAxSwQL3EifbubVvrYGEp6mKrPMQg4UCzLOg0OVMfb+2re0Ehd7m4+6EIScQHrDUhZa@vger.kernel.org, AJvYcCX5BYYW+zIwZqBm+BWtiw5hcMK7p/+KPyScDWa7bwP1OH6WLaKt2G9eABFTooUZ8047djlvKtwz3/QTZPvB@vger.kernel.org
X-Gm-Message-State: AOJu0YwFNZ7xS6oXxvMBwJOg9rHFaqLFOcFQUwZ+aq4YpE/bsIwhTcXC
	DRXge0H0F+xy9Qg+Hks2fWZZvYxeWRc6UK9mxxpuozk8R/lLJzSdyzjxPuxLmQ==
X-Gm-Gg: ASbGncvmEFFYlQoiXCaf7k+tAUZRZmPKmbbjXbS655YCcYcXpZ3dD9VYRqmUpg2WzAF
	0rh2YHln4iISl6YCCw81Se2yP6e47GOrCsv+cM5UtRhnTZWL5sHfwnO1waQfWnngygHhIJlBde0
	GNSUS6nnKpRBWWpF7P5zCdD0s4j8ColXJa16JO9h9PeEHiRu+v1yf41FFpLVY5L6JygoyZ1livy
	KNtlRpMZwerQreKEjASmH854zpLP7G2zn+dJN7SraaEIHSZqIdNUG3x5NA2xc79SY1HBsylJA/n
	7DnyqrP7zg4kH9AJKL2JDa1c1X3E7+PA2VxGYd67LNZCFd7kZGFS46Owl+R/+V4It5PK931GFSg
	en4dgthYLYLv42nM5qgd/boVfYpzrnUDs
X-Google-Smtp-Source: AGHT+IEm62cvsAxWVl+gwFFGA56IsUa3Qv87CztVk6WvXnlwbq3Sn3mAbFXaHrg0cq3VYgLhxEemvA==
X-Received: by 2002:a17:907:9814:b0:ad8:8200:ecfc with SMTP id a640c23a62f3a-adfad37aea7mr234148666b.5.1750026189898;
        Sun, 15 Jun 2025 15:23:09 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adf8b393ea8sm412692766b.159.2025.06.15.15.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 15:23:09 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	bagasdotme@gmail.com
Cc: l.rubusch@gmail.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/8] iio: accel: adxl313: add activity sensing
Date: Sun, 15 Jun 2025 22:22:54 +0000
Message-Id: <20250615222258.117771-5-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250615222258.117771-1-l.rubusch@gmail.com>
References: <20250615222258.117771-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for configuring an activity detection threshold. Extend the
interrupt handler to process activity-related interrupts, and provide
functions to set the threshold as well as to enable or disable activity
sensing. Additionally, introduce a virtual channel that represents the
logical AND of the x, y, and z axes in the IIO channel.

This patch serves as a preparatory step; some definitions and functions
introduced here are intended to be extended later to support inactivity
detection.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313_core.c | 244 +++++++++++++++++++++++++++++++
 1 file changed, 244 insertions(+)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 488680807a8f..b0d14ce60f01 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -13,8 +13,10 @@
 #include <linux/overflow.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/units.h>
 
 #include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
 #include <linux/iio/kfifo_buf.h>
 
 #include "adxl313.h"
@@ -25,6 +27,21 @@
 
 #define ADXL313_REG_XYZ_BASE			ADXL313_REG_DATA_AXIS(0)
 
+#define ADXL313_ACT_XYZ_EN			GENMASK(6, 4)
+
+/* activity/inactivity */
+enum adxl313_activity_type {
+	ADXL313_ACTIVITY,
+};
+
+static const unsigned int adxl313_act_int_reg[] = {
+	[ADXL313_ACTIVITY] = ADXL313_INT_ACTIVITY,
+};
+
+static const unsigned int adxl313_act_thresh_reg[] = {
+	[ADXL313_ACTIVITY] = ADXL313_REG_THRESH_ACT,
+};
+
 static const struct regmap_range adxl312_readable_reg_range[] = {
 	regmap_reg_range(ADXL313_REG_DEVID0, ADXL313_REG_DEVID0),
 	regmap_reg_range(ADXL313_REG_OFS_AXIS(0), ADXL313_REG_OFS_AXIS(2)),
@@ -227,6 +244,15 @@ static const int adxl313_odr_freqs[][2] = {
 	},								\
 }
 
+static const struct iio_event_spec adxl313_activity_events[] = {
+	{
+		.type = IIO_EV_TYPE_MAG,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
+	},
+};
+
 enum adxl313_chans {
 	chan_x, chan_y, chan_z,
 };
@@ -235,6 +261,14 @@ static const struct iio_chan_spec adxl313_channels[] = {
 	ADXL313_ACCEL_CHANNEL(0, chan_x, X),
 	ADXL313_ACCEL_CHANNEL(1, chan_y, Y),
 	ADXL313_ACCEL_CHANNEL(2, chan_z, Z),
+	{
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_X_OR_Y_OR_Z,
+		.scan_index = -1, /* Fake channel for axis OR'ing */
+		.event_spec = adxl313_activity_events,
+		.num_event_specs = ARRAY_SIZE(adxl313_activity_events),
+	},
 };
 
 static const unsigned long adxl313_scan_masks[] = {
@@ -297,6 +331,73 @@ static int adxl313_read_freq_avail(struct iio_dev *indio_dev,
 	}
 }
 
+static int adxl313_is_act_inact_en(struct adxl313_data *data,
+				   enum adxl313_activity_type type)
+{
+	unsigned int axis_ctrl;
+	unsigned int regval;
+	int axis_en, ret;
+
+	ret = regmap_read(data->regmap, ADXL313_REG_ACT_INACT_CTL, &axis_ctrl);
+	if (ret)
+		return ret;
+
+	axis_en = FIELD_GET(ADXL313_ACT_XYZ_EN, axis_ctrl);
+
+	if (!axis_en)
+		return false;
+
+	/* Check if specific interrupt is enabled */
+	ret = regmap_read(data->regmap, ADXL313_REG_INT_ENABLE, &regval);
+	if (ret)
+		return ret;
+
+	return adxl313_act_int_reg[type] & regval;
+}
+
+static int adxl313_set_act_inact_en(struct adxl313_data *data,
+				    enum adxl313_activity_type type,
+				    bool cmd_en)
+{
+	unsigned int axis_ctrl;
+	unsigned int threshold;
+	int ret;
+
+	if (type != ADXL313_ACTIVITY)
+		return 0;
+
+	if (cmd_en) {
+		/* When turning on, check if threshold is valid */
+		ret = regmap_read(data->regmap, adxl313_act_thresh_reg[type],
+				  &threshold);
+		if (ret)
+			return ret;
+
+		if (!threshold) /* Just ignore the command if threshold is 0 */
+			return 0;
+	}
+
+	/* Start modifying configuration registers */
+	ret = adxl313_set_measure_en(data, false);
+	if (ret)
+		return ret;
+
+	/* Enable axis according to the command */
+	axis_ctrl = ADXL313_ACT_XYZ_EN;
+	ret = regmap_assign_bits(data->regmap, ADXL313_REG_ACT_INACT_CTL,
+				 axis_ctrl, cmd_en);
+	if (ret)
+		return ret;
+
+	/* Enable the interrupt line, according to the command */
+	ret = regmap_assign_bits(data->regmap, ADXL313_REG_INT_ENABLE,
+				 adxl313_act_int_reg[type], cmd_en);
+	if (ret)
+		return ret;
+
+	return adxl313_set_measure_en(data, true);
+}
+
 static int adxl313_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
@@ -370,6 +471,103 @@ static int adxl313_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int adxl313_read_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+
+	if (type != IIO_EV_TYPE_MAG)
+		return -EINVAL;
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		return adxl313_is_act_inact_en(data, ADXL313_ACTIVITY);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl313_write_event_config(struct iio_dev *indio_dev,
+				      const struct iio_chan_spec *chan,
+				      enum iio_event_type type,
+				      enum iio_event_direction dir,
+				      bool state)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+
+	if (type != IIO_EV_TYPE_MAG)
+		return -EINVAL;
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		return adxl313_set_act_inact_en(data, ADXL313_ACTIVITY, state);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl313_read_event_value(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info,
+				    int *val, int *val2)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+	unsigned int act_threshold;
+	int ret;
+
+	if (type != IIO_EV_TYPE_MAG)
+		return -EINVAL;
+
+	if (info != IIO_EV_INFO_VALUE)
+		return -EINVAL;
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		ret = regmap_read(data->regmap,
+				  adxl313_act_thresh_reg[ADXL313_ACTIVITY],
+				  &act_threshold);
+		if (ret)
+			return ret;
+		*val = act_threshold * 15625;
+		*val2 = MICRO;
+		return IIO_VAL_FRACTIONAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl313_write_event_value(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     enum iio_event_info info,
+				     int val, int val2)
+{
+	struct adxl313_data *data = iio_priv(indio_dev);
+	unsigned int regval;
+
+	if (type != IIO_EV_TYPE_MAG)
+		return -EINVAL;
+
+	if (info != IIO_EV_INFO_VALUE)
+		return -EINVAL;
+
+	/* Scale factor 15.625 mg/LSB */
+	regval = DIV_ROUND_CLOSEST(val * MICRO + val2, 15625);
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		return regmap_write(data->regmap,
+				    adxl313_act_thresh_reg[ADXL313_ACTIVITY],
+				    regval);
+	default:
+		return -EINVAL;
+	}
+}
+
 static int adxl313_set_watermark(struct iio_dev *indio_dev, unsigned int value)
 {
 	struct adxl313_data *data = iio_priv(indio_dev);
@@ -508,6 +706,25 @@ static int adxl313_fifo_push(struct iio_dev *indio_dev, int samples)
 	return 0;
 }
 
+static int adxl313_push_events(struct iio_dev *indio_dev, int int_stat)
+{
+	s64 ts = iio_get_time_ns(indio_dev);
+	int ret = -ENOENT;
+
+	if (FIELD_GET(ADXL313_INT_ACTIVITY, int_stat)) {
+		ret = iio_push_event(indio_dev,
+				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+							IIO_MOD_X_OR_Y_OR_Z,
+							IIO_EV_TYPE_MAG,
+							IIO_EV_DIR_RISING),
+				     ts);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
 static irqreturn_t adxl313_irq_handler(int irq, void *p)
 {
 	struct iio_dev *indio_dev = p;
@@ -517,6 +734,16 @@ static irqreturn_t adxl313_irq_handler(int irq, void *p)
 	if (regmap_read(data->regmap, ADXL313_REG_INT_SOURCE, &int_stat))
 		return IRQ_NONE;
 
+	/*
+	 * In cases of sensor events not handled (still not implemented) by
+	 * this driver, the FIFO needs to be drained to become operational
+	 * again. In general the sensor configuration only should issue events
+	 * which were configured by this driver. Anyway a miss-configuration
+	 * easily might end up in a hanging sensor FIFO.
+	 */
+	if (adxl313_push_events(indio_dev, int_stat))
+		goto err;
+
 	if (FIELD_GET(ADXL313_INT_WATERMARK, int_stat)) {
 		samples = adxl313_get_samples(data);
 		if (samples < 0)
@@ -550,6 +777,10 @@ static int adxl313_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 static const struct iio_info adxl313_info = {
 	.read_raw	= adxl313_read_raw,
 	.write_raw	= adxl313_write_raw,
+	.read_event_config = adxl313_read_event_config,
+	.write_event_config = adxl313_write_event_config,
+	.read_event_value = adxl313_read_event_value,
+	.write_event_value = adxl313_write_event_value,
 	.read_avail	= adxl313_read_freq_avail,
 	.hwfifo_set_watermark = adxl313_set_watermark,
 	.debugfs_reg_access = &adxl313_reg_access,
@@ -663,6 +894,19 @@ int adxl313_core_probe(struct device *dev,
 		if (ret)
 			return ret;
 
+		/*
+		 * Reset or configure the registers with reasonable default
+		 * values. As having 0 in most cases may result in undesirable
+		 * behavior if the interrupts are enabled.
+		 */
+		ret = regmap_write(data->regmap, ADXL313_REG_ACT_INACT_CTL, 0x00);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(data->regmap, ADXL313_REG_THRESH_ACT, 0x52);
+		if (ret)
+			return ret;
+
 		ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
 						  &adxl313_buffer_ops);
 		if (ret)
-- 
2.39.5


