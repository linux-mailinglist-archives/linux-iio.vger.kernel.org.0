Return-Path: <linux-iio+bounces-15252-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE99A2EA5F
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 12:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4686168703
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 11:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6681E47B7;
	Mon, 10 Feb 2025 11:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYdPFyty"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AA21E376E;
	Mon, 10 Feb 2025 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185302; cv=none; b=mQQXadOYnm6feZDseo8yJDVvazhjfqVBvtK+HblR/Z8uy5AEkZwkNiaDrXQw6fu1ZQJjE4cbjBkwHI8L3uO4LLdfq43vGIfBI51JtLGtdg+N1Z4/fwPyV2pAt+m/G/8dMFqZRgfgpmfWeMYHPOLkXwbjphNl7rE2RCHAxHqWUcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185302; c=relaxed/simple;
	bh=zo086hz6rka8QSxwW7LEi8pN4iHCWI1Sn1JRIdpPfJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rPxF6IwNcEog/IdpJRTGt7G9pl+53gN9/ZBSh05wwaiHsfJUVi43mPvDMDaG+CdopzsWllLTPB+G2igqD5MPN0N3MSQN1eAqPVwDfJgzlT2KycR2WQ7CHgLzzEHsv4bjsbsvcWHK16Amc87XL8CSIJ/iG0aQNGl2ojqQmIG/Srk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYdPFyty; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab7b5308a4dso27034266b.1;
        Mon, 10 Feb 2025 03:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739185299; x=1739790099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bl/DOFrifvpFKvgqOzrQvHhDtISjLv/tfdgxn7y5stM=;
        b=BYdPFytyFvvuxt08NpijFDoFWYWH41gSuPl3wrHTk9+6M7t7c94zBc1F92Bco4McVO
         jgVnYLQc8ktgepvVm7hPpDpZCCaKQH9mBwAfh5dVOMUt6ippTUBBiIKaGgk8oWXYOcAm
         tRznlrjXMXWoF+Ank/X3+iaXyyLI9XyeVXZpVaEjaWSQ0C5F6V/6VP+a9whfEvuVec/R
         Q9o1EqAYWB69rStmu3wFBlBx4oSFJg9QIDVPiWoxMCW9uG5gF1e6u5CeAWMANWnrGc1O
         DnZl2vaqG1ZVnmHDJ/ufub+jMzokVAgg8k/Bg5shioWxFEv3K1O2BsxRKg8wjb4yGTNY
         pfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739185299; x=1739790099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bl/DOFrifvpFKvgqOzrQvHhDtISjLv/tfdgxn7y5stM=;
        b=dnpgYzYG1m/SpVE9V39OuverWf622QcYPKE229ZZSmCCsCKc+H5obxMCljV5oCwp+Q
         Q5GCU/bTx4DZPyb71C38ER7rS235RgQpCb3uxfS77P30nsLiN/MtovcihWrTti5K7XNi
         Uk/MimqjO04kY63nf1MfY2xzPPjLn4N5nonDCrydhbU4bgjx/2gCHK++iqU8e4F6rYbG
         bcAbQixKoSj/hB6R+eeYhPFt4Tsij9qXVe6JFgSFDCn6qfR7n+On3VP1JjGzDs7g4MNy
         m4cSgW8kTt10J3sRlQIjgwIhEa7vv76nkpCSs25/PHVMryhjqgaaQIRQ1tFHu8fK5cfj
         /Grw==
X-Forwarded-Encrypted: i=1; AJvYcCVuxkstwwf6Y4uTyyAKcSjWby0RbYj/krdPkM8UC0+DNt19EsItPA8wn8AO5JOnQoU4oug+qCrEXkEResk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWSSoaT01mOzn1ntYdybQG27xt+JBQpWgMTcMdXEepMS98dyz2
	aXRw7ZqDW5eRLzEzqqiXn5kTXtwminAqAva7Jxo2Z4ph9Kn4kURm
X-Gm-Gg: ASbGncvD0ZbQuwHo54ARPshZPtGTyPsxyyJ9AmfEB84cS+ecz3GHFXiuZ9EjDJo+cgI
	RmC1cHkep8XvAPdsA0JFog1z1/aeFSfRllEsTOIEvFtKZ7Kc2dJcmZIhRJ8T8UsHtEAwZ5yahf3
	LFaTtIxht+mHxkakq0wCa0U1dASCdWUCeLsJc3SHRJOD6/rC1UsDherBcejJ54Uv9uNQW7TG/CM
	n5WFueIxinmXzvnLFqVdYgQC54tCuI7s8eLToLSEU3MvWdxf8oJibPrT6NA9sZzr8gNJpWGDRfy
	GO9K5IETO1dNiYK3ENOegeOw66g2tfcVgN/nr4uBK5DZw+5tcBfbvkBkFO1j7Rvdgo0P3w==
X-Google-Smtp-Source: AGHT+IHyRpBHhYOPuFxmzFrLWDD68ZNdEcFhhR+cQwGKikyUvYwjRfQ4H0FRQPO4b5ScGfwP3+S6vg==
X-Received: by 2002:a17:907:7f08:b0:aae:e684:cc75 with SMTP id a640c23a62f3a-ab789c35369mr511015466b.13.1739185298499;
        Mon, 10 Feb 2025 03:01:38 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7a5a78369sm486987266b.136.2025.02.10.03.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 03:01:38 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 05/14] iio: accel: adxl345: add single tap feature
Date: Mon, 10 Feb 2025 11:01:10 +0000
Message-Id: <20250210110119.260858-6-l.rubusch@gmail.com>
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

Add the single tap feature with a threshold in 62.5mg/LSB points and a
scaled duration in us. Keep singletap threshold and duration using means
of IIO ABI. Extend the channels for single enable x/y/z axis of the
feature but also initialize threshold and duration with reasonable
content. When an interrupt is caught it will be pushed to the according
IIO channel.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 369 ++++++++++++++++++++++++++++++-
 1 file changed, 367 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 910ad21279ed..304147a4ca60 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/bitops.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/property.h>
@@ -15,6 +16,7 @@
 #include <linux/units.h>
 
 #include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/sysfs.h>
@@ -31,6 +33,33 @@
 #define ADXL345_INT1			0
 #define ADXL345_INT2			1
 
+#define ADXL345_REG_TAP_AXIS_MSK	GENMASK(2, 0)
+
+enum adxl345_axis {
+	ADXL345_Z_EN = BIT(0),
+	ADXL345_Y_EN = BIT(1),
+	ADXL345_X_EN = BIT(2),
+	/* Suppress double tap detection if value > tap threshold */
+	ADXL345_TAP_SUPPRESS = BIT(3),
+};
+
+/* single/double tap */
+enum adxl345_tap_type {
+	ADXL345_SINGLE_TAP,
+};
+
+static const unsigned int adxl345_tap_int_reg[2] = {
+	[ADXL345_SINGLE_TAP] = ADXL345_INT_SINGLE_TAP,
+};
+
+enum adxl345_tap_time_type {
+	ADXL345_TAP_TIME_DUR,
+};
+
+static const unsigned int adxl345_tap_time_reg[3] = {
+	[ADXL345_TAP_TIME_DUR] = ADXL345_REG_DUR,
+};
+
 struct adxl345_state {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
@@ -40,9 +69,25 @@ struct adxl345_state {
 	u8 int_map;
 	u8 watermark;
 	u8 fifo_mode;
+
+	u32 tap_axis_ctrl;
+	u8 tap_threshold;
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
@@ -59,6 +104,8 @@ struct adxl345_state {
 		.storagebits = 16,			\
 		.endianness = IIO_LE,			\
 	},						\
+	.event_spec = adxl345_events,			\
+	.num_event_specs = ARRAY_SIZE(adxl345_events),	\
 }
 
 enum adxl345_chans {
@@ -96,6 +143,126 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
 	return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
 }
 
+/* tap */
+
+static int adxl345_write_tap_axis(struct adxl345_state *st,
+				  enum adxl345_axis axis, bool en)
+{
+	st->tap_axis_ctrl = FIELD_GET(ADXL345_REG_TAP_AXIS_MSK,
+				      en ? st->tap_axis_ctrl | axis
+				      : st->tap_axis_ctrl & ~axis);
+
+	return regmap_update_bits(st->regmap, ADXL345_REG_TAP_AXIS,
+				  ADXL345_REG_TAP_AXIS_MSK,
+				  FIELD_PREP(ADXL345_REG_TAP_AXIS_MSK,
+					     st->tap_axis_ctrl));
+}
+
+static int _adxl345_set_tap_int(struct adxl345_state *st,
+				enum adxl345_tap_type type, bool state)
+{
+	bool axis_valid;
+	bool singletap_args_valid = false;
+	bool en = false;
+
+	axis_valid = FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, st->tap_axis_ctrl) > 0;
+
+	/*
+	 * Note: A value of 0 for threshold and/or dur may result in undesirable
+	 *	 behavior if single tap/double tap interrupts are enabled.
+	 */
+	singletap_args_valid = st->tap_threshold > 0 && st->tap_duration_us > 0;
+
+	if (type == ADXL345_SINGLE_TAP)
+		en = axis_valid && singletap_args_valid;
+
+	if (state && en)
+		__set_bit(ilog2(adxl345_tap_int_reg[type]),
+			  (unsigned long *)&st->int_map);
+	else
+		__clear_bit(ilog2(adxl345_tap_int_reg[type]),
+			    (unsigned long *)&st->int_map);
+
+	return regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, st->int_map);
+}
+
+static int adxl345_is_tap_en(struct adxl345_state *st,
+			     enum adxl345_tap_type type, bool *en)
+{
+	int ret;
+	unsigned int regval;
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
+				    enum adxl345_axis axis, bool en)
+{
+	int ret;
+
+	ret = adxl345_write_tap_axis(st, axis, en);
+	if (ret)
+		return ret;
+
+	return _adxl345_set_tap_int(st, ADXL345_SINGLE_TAP, en);
+}
+
+static int adxl345_set_tap_threshold(struct adxl345_state *st, u8 val)
+{
+	int ret;
+
+	ret = regmap_write(st->regmap, ADXL345_REG_THRESH_TAP, min(val, 0xFF));
+	if (ret)
+		return ret;
+
+	st->tap_threshold = val;
+
+	return 0;
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
+		return 0;
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
@@ -181,6 +348,147 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int adxl345_read_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir)
+{
+	struct adxl345_state *st = iio_priv(indio_dev);
+	bool int_en;
+	bool axis_en;
+	int ret = -EFAULT;
+
+	switch (type) {
+	case IIO_EV_TYPE_GESTURE:
+		switch (chan->channel2) {
+		case IIO_MOD_X:
+			axis_en = FIELD_GET(ADXL345_X_EN, st->tap_axis_ctrl);
+			break;
+		case IIO_MOD_Y:
+			axis_en = FIELD_GET(ADXL345_Y_EN, st->tap_axis_ctrl);
+			break;
+		case IIO_MOD_Z:
+			axis_en = FIELD_GET(ADXL345_Z_EN, st->tap_axis_ctrl);
+			break;
+		default:
+			axis_en = ADXL345_TAP_SUPPRESS;
+		}
+
+		switch (dir) {
+		case IIO_EV_DIR_SINGLETAP:
+			ret = adxl345_is_tap_en(st, ADXL345_SINGLE_TAP, &int_en);
+			if (ret)
+				return ret;
+			return int_en && axis_en;
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
+	enum adxl345_axis axis;
+
+	switch (type) {
+	case IIO_EV_TYPE_GESTURE:
+		switch (chan->channel2) {
+		case IIO_MOD_X:
+			axis = ADXL345_X_EN;
+			break;
+		case IIO_MOD_Y:
+			axis = ADXL345_Y_EN;
+			break;
+		case IIO_MOD_Z:
+			axis = ADXL345_Z_EN;
+			break;
+		default:
+			axis = ADXL345_TAP_SUPPRESS;
+		}
+
+		switch (dir) {
+		case IIO_EV_DIR_SINGLETAP:
+			return adxl345_set_singletap_en(st, axis, state);
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int adxl345_read_event_value(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
+				    enum iio_event_type type, enum iio_event_direction dir,
+				    enum iio_event_info info, int *val, int *val2)
+{
+	struct adxl345_state *st = iio_priv(indio_dev);
+
+	switch (type) {
+	case IIO_EV_TYPE_GESTURE:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			/*
+			 * The scale factor is 62.5mg/LSB (i.e. 0xFF = 16g) but
+			 * not applied here.
+			 */
+			*val = sign_extend32(st->tap_threshold, 7);
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
+			ret = adxl345_set_tap_threshold(st, val);
+			break;
+		case IIO_EV_INFO_TIMEOUT:
+			ret = adxl345_set_tap_duration(st, val, val2);
+			break;
+		default:
+			ret = -EINVAL;
+		}
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	if (ret)
+		return ret; /* measurement stays off */
+
+	return adxl345_set_measure_en(st, true);
+}
+
 static int adxl345_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 			      unsigned int writeval, unsigned int *readval)
 {
@@ -383,8 +691,33 @@ static const struct iio_buffer_setup_ops adxl345_buffer_ops = {
 	.predisable = adxl345_buffer_predisable,
 };
 
-static int adxl345_get_status(struct adxl345_state *st, unsigned int *int_stat)
+static int adxl345_get_status(struct adxl345_state *st, unsigned int *int_stat,
+			      enum iio_modifier *act_tap_dir)
 {
+	unsigned int regval;
+	bool check_tap_stat;
+	int ret;
+
+	*act_tap_dir = IIO_NO_MOD;
+	check_tap_stat = FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, st->tap_axis_ctrl) > 0;
+
+	if (check_tap_stat) {
+		/* ACT_TAP_STATUS should be read before clearing the interrupt */
+		ret = regmap_read(st->regmap, ADXL345_REG_ACT_TAP_STATUS, &regval);
+		if (ret)
+			return ret;
+
+		if ((FIELD_GET(ADXL345_Z_EN, regval >> 4)
+				| FIELD_GET(ADXL345_Z_EN, regval)) > 0)
+			*act_tap_dir = IIO_MOD_Z;
+		else if ((FIELD_GET(ADXL345_Y_EN, regval >> 4)
+				| FIELD_GET(ADXL345_Y_EN, regval)) > 0)
+			*act_tap_dir = IIO_MOD_Y;
+		else if ((FIELD_GET(ADXL345_X_EN, regval >> 4)
+				| FIELD_GET(ADXL345_X_EN, regval)) > 0)
+			*act_tap_dir = IIO_MOD_X;
+	}
+
 	return regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, int_stat);
 }
 
@@ -407,6 +740,26 @@ static int adxl345_fifo_push(struct iio_dev *indio_dev,
 	return 0;
 }
 
+static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
+			      enum iio_modifier act_tap_dir)
+{
+	s64 ts = iio_get_time_ns(indio_dev);
+	int ret;
+
+	if (FIELD_GET(ADXL345_INT_SINGLE_TAP, int_stat)) {
+		ret = iio_push_event(indio_dev,
+				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+							act_tap_dir,
+							IIO_EV_TYPE_GESTURE,
+							IIO_EV_DIR_SINGLETAP),
+				     ts);
+		if (ret)
+			return ret;
+	}
+
+	return -ENOENT;
+}
+
 /**
  * adxl345_irq_handler() - Handle irqs of the ADXL345.
  * @irq: The irq being handled.
@@ -419,11 +772,15 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 	struct iio_dev *indio_dev = p;
 	struct adxl345_state *st = iio_priv(indio_dev);
 	int int_stat;
+	enum iio_modifier act_tap_dir;
 	int samples;
 
-	if (adxl345_get_status(st, &int_stat))
+	if (adxl345_get_status(st, &int_stat, &act_tap_dir))
 		return IRQ_NONE;
 
+	if (adxl345_push_event(indio_dev, int_stat, act_tap_dir) == 0)
+		return IRQ_HANDLED;
+
 	if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
 		samples = adxl345_get_samples(st);
 		if (samples < 0)
@@ -449,6 +806,10 @@ static const struct iio_info adxl345_info = {
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
@@ -496,6 +857,10 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 
 	st->int_map = 0x00;			/* reset interrupts */
 
+	/* Init with reasonable values */
+	st->tap_threshold = 48;			/*   48 [0x30] -> ~3g     */
+	st->tap_duration_us = 16;		/*   16 [0x10] -> .010    */
+
 	indio_dev->name = st->info->name;
 	indio_dev->info = &adxl345_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.39.5


