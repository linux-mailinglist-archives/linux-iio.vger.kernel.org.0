Return-Path: <linux-iio+bounces-14668-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3CDA20A1E
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 13:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 500351886502
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jan 2025 12:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770A91AAA05;
	Tue, 28 Jan 2025 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNv3WjqV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266351A2391;
	Tue, 28 Jan 2025 12:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738065703; cv=none; b=SINPD0lJXIIeQG5SdtE5EOVwb0VLuLWFOzvfG+iRkPUnMb9/do3kH4+HPV7Bjwx6uS6txU7Llk16Pb+IeYiGuLFg2AreIp2nSgHqjJjf33pLn3zWh6JXN1E1pKUMUEGtLSDR9pp1rU+pMspX8bA7LfX50dupUtXP/jSQR/2s6FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738065703; c=relaxed/simple;
	bh=px3EIy5ZuO4BmN8KqrxdtewctqEZJkoNUBSfYojLlQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uwuCTJW9aok/kdv4/vuRdv9oPv4yNcNSfB2DZpc+1JUQuaVqyV8aqGDEi2QtVbHGCevgdaZY5be60yxjzcOCsIS3B7ldtS+KZ4Jl8wsX8duHnnml165mG8wPuaQQnaj+2UliReJxjiv3b0D1TDKPBIdBlzDCVySrZJjZrZ+3v/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNv3WjqV; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab2f33766e6so73181866b.0;
        Tue, 28 Jan 2025 04:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738065699; x=1738670499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgtfoHM2AMsUxihJMzmLY7ruAv0/tgz+oz8n9tt8xxk=;
        b=hNv3WjqVWvwqEmLqUDa3HGKbIRfW+3oie7K8Tdbj9LAI2/NvsATZ4lH+QfPT/utjA5
         soUMJiG23vX7hdqYjLMJvWE8XtRwKgGXJ1KmD3M8rnWubHXI5tMOmD1cj3+/Dl5uGmEP
         p8iAfl6TYhWfs9ztEpLa12zTAL3PxZ1ollvnZQCv2xvNvKhqDgFEqmw/Ay7YFIOCXis6
         tboHJZJNl45ghhwKrCxwSotcrVOcFSf2CSe9/L19ZYEeaut92akGYL5a0BuEcwwUOoC/
         wtdsmqYl4P/5/A6wF6e4SsfBacO93otqaXOuv26Qv9HF2A/jB4KzVX/geV0sVgE7FErL
         oSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738065699; x=1738670499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hgtfoHM2AMsUxihJMzmLY7ruAv0/tgz+oz8n9tt8xxk=;
        b=a3XXS4zaej+AAhaG4GyEWpmwcGQdbW7vFlbkmJpFATs7rid/1RPgcbmMyfl1GQt4bA
         RHrJE2o0w0oClSUXzkffBDjI0coUN3hItS43Da0KWzTGSQAf7vnneqpLNSp2ZcKDIeHh
         7oCqax1LIx/obxePR/jjXoUGpJsVCNJ4laveVMcmYgKfWxq2H1miUd7TD1aV8Z2eATJI
         +IZdtIHqvyKQnW96kIbaC5yAZDrLscYOxhwTmh8guuPa4PubXag/4BHwsmgBCR60gCyS
         /z3LI2Wmj/FVvafy0GoJWMb0YcnaMpfuZN/RLpWpRTLEp2oIvMz9DI4oLMqNssyAhCgp
         IByg==
X-Forwarded-Encrypted: i=1; AJvYcCVVlTGGPsPNZ2Qf2y4K05uNICDINbRA8oMMIxKBE6xoZ2yXRk6eDB2f5HKFTfHC2HItmoE4TBBG7drqA/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaehKIC4/YhPMPcO4IfcFxWW+EwTw1F5EblrB42jFx24HZBXcA
	gwwtDvR3hzd19OVEM/+izoggjLTD9KYWfGr6p+dBkCrmARRA+xJt
X-Gm-Gg: ASbGnctEgPb+YEVTlFmRaSKJVHafdUJIhz0sXAB9YhxsXB2gpZtvYxGdJB5RrLQWHFV
	N7me4vXSLWPAnMm8zSEM+DAvgEUaxfCcUQlJ4ssCc+9Oa+e8ElN7jMUYy5q+ndo9XU4BzILbN1m
	UBqWbYdt2gAz0OdvHXPMMkiCChPcKZb/HHHD8lpqU/fYvc40Y6NqB2klN4mtQKnJ1UcEIWuBOOl
	ej/8UjkhYz3pFpJm3+tXldUBlqIIVPR86kA4qRUV71ejYQaN2i6frDjSboXrqRWh4+Yc3Yeg9EO
	p11dcmy64UxjO/bswI9Lnu8eXvK9qVb/Sq6RoxwIKZXbhfWD6YJ+H8/1ryWeQtc+OI8KLZ4JfGJ
	eApZU
X-Google-Smtp-Source: AGHT+IG9YcMyqVcOyOKxvCgI5pvLcVwqz1VxYsEhxraj/Tuk0zNf67E3u3XohCx3ODkJ6ivp7VzzlA==
X-Received: by 2002:a17:907:d1b:b0:aab:8f0f:6919 with SMTP id a640c23a62f3a-ab38b3cd5femr1555413266b.11.1738065698972;
        Tue, 28 Jan 2025 04:01:38 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab69f8555b7sm418865966b.71.2025.01.28.04.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 04:01:38 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v1 06/12] iio: accel: adxl345: add single tap feature
Date: Tue, 28 Jan 2025 12:00:54 +0000
Message-Id: <20250128120100.205523-7-l.rubusch@gmail.com>
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

Add the single tap feature with a threshold in 62.5mg/LSB points and a
scaled duration in us. Keep singletap threshold by means of IIO but add
sysfs entry for the duration. Using a sysfs entry allow for a clearer
naming of the handle to improve usage. Extend the channels for single
enable x/y/z axis of the feature but also check if threshold (a.k.a
"value") and duration have reasonable content. When an interrupt is
caught it will be pushed to the according IIO channel.

The function call structure is in preparation to be extended for an
upcoming doubletap feature in the follow up patches.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 367 +++++++++++++++++++++++++++++++
 1 file changed, 367 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index b55f6774b1e9..0d991f3ec10c 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -15,6 +15,7 @@
 #include <linux/units.h>
 
 #include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/sysfs.h>
@@ -118,6 +119,16 @@
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
 struct adxl345_state {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
@@ -127,9 +138,24 @@ struct adxl345_state {
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
+		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE),
+	},
+};
+
 #define ADXL345_CHANNEL(index, reg, axis) {					\
 	.type = IIO_ACCEL,						\
 	.modified = 1,							\
@@ -146,6 +172,8 @@ struct adxl345_state {
 		.storagebits = 16,			\
 		.endianness = IIO_LE,			\
 	},						\
+	.event_spec = adxl345_events,				\
+	.num_event_specs = ARRAY_SIZE(adxl345_events),	\
 }
 
 enum adxl345_chans {
@@ -190,11 +218,121 @@ static void adxl345_powerdown(void *ptr)
 	adxl345_set_measure_en(st, false);
 }
 
+static inline void adxl345_intmap_switch_bit(struct adxl345_state *st,
+					     bool condition, u8 bit)
+{
+	st->int_map = condition ? st->int_map | bit : st->int_map & ~bit;
+}
+
+static inline int adxl345_read_interrupts(struct adxl345_state *st,
+					  unsigned int *interrupts)
+{
+	return regmap_read(st->regmap, ADXL345_REG_INT_ENABLE, interrupts);
+}
+
 static inline int adxl345_write_interrupts(struct adxl345_state *st)
 {
 	return regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, st->int_map);
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
+static int _adxl345_set_tap_int(struct adxl345_state *st, bool state)
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
+	en = axis_valid && singletap_args_valid;
+
+	adxl345_intmap_switch_bit(st, state && en, ADXL345_INT_SINGLE_TAP);
+
+	return adxl345_write_interrupts(st);
+}
+
+static int adxl345_is_tap_en(struct adxl345_state *st, bool *en)
+{
+	int ret;
+	unsigned int regval;
+
+	ret = adxl345_read_interrupts(st, &regval);
+	if (ret)
+		return ret;
+
+	*en = FIELD_GET(ADXL345_INT_SINGLE_TAP, regval) > 0;
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
+	return _adxl345_set_tap_int(st, en);
+}
+
+static int adxl345_set_tap_value(struct adxl345_state *st, u8 val)
+{
+	st->tap_threshold = val;
+
+	return regmap_write(st->regmap, ADXL345_REG_THRESH_TAP, min(val, 0xFF));
+}
+
+static int _adxl345_set_tap_time(struct adxl345_state *st, u32 val_us)
+{
+	unsigned int regval;
+
+	st->tap_duration_us = val_us;
+
+	/*
+	 * The scale factor is 1250us / LSB for tap_window_us and tap_latent_us.
+	 * For tap_duration_us the scale factor is 625us / LSB.
+	 */
+	regval = DIV_ROUND_CLOSEST(val_us, 625);
+
+	return regmap_write(st->regmap, ADXL345_REG_DUR, regval);
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
+	return _adxl345_set_tap_time(st, val_fract_us);
+}
+
 static int adxl345_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
@@ -275,6 +413,141 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 					  ADXL345_BW_RATE,
 					  clamp_val(ilog2(n), 0,
 						    ADXL345_BW_RATE));
+	default:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
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
+		switch (dir) {
+		case IIO_EV_DIR_SINGLETAP:
+			switch (chan->channel2) {
+			case IIO_MOD_X:
+				axis_en = FIELD_GET(ADXL345_X_EN, st->tap_axis_ctrl);
+				break;
+			case IIO_MOD_Y:
+				axis_en = FIELD_GET(ADXL345_Y_EN, st->tap_axis_ctrl);
+				break;
+			case IIO_MOD_Z:
+				axis_en = FIELD_GET(ADXL345_Z_EN, st->tap_axis_ctrl);
+				break;
+			default:
+				return -EINVAL;
+			}
+
+			ret = adxl345_is_tap_en(st, &int_en);
+			if (ret)
+				return ret;
+			return int_en && axis_en;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+
+	return ret;
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
+	if (type != IIO_EV_TYPE_GESTURE)
+		return -EINVAL;
+
+	switch (dir) {
+	case IIO_EV_DIR_SINGLETAP:
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
+			return -EINVAL;
+		}
+
+		return adxl345_set_singletap_en(st, axis, state);
+	default:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
+}
+
+static int adxl345_read_event_value(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
+				    enum iio_event_type type, enum iio_event_direction dir,
+				    enum iio_event_info info, int *val, int *val2)
+{
+	struct adxl345_state *st = iio_priv(indio_dev);
+
+	if (type != IIO_EV_TYPE_GESTURE)
+		return -EINVAL;
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		/*
+		 * The scale factor is 62.5mg/LSB (i.e. 0xFF = 16g) but
+		 * not applied here.
+		 */
+		*val = sign_extend32(st->tap_threshold, 7);
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+
+	return -EINVAL;
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
+	if (type != IIO_EV_TYPE_GESTURE)
+		return -EINVAL;
+
+	if (info == IIO_EV_INFO_VALUE) {
+		if (val < 0 || val > 255)
+			return -EINVAL;
+
+		ret = adxl345_set_measure_en(st, false);
+		if (ret)
+			return ret;
+
+		ret = adxl345_set_tap_value(st, val);
+		if (ret)
+			return ret;
+
+		return adxl345_set_measure_en(st, true);
 	}
 
 	return -EINVAL;
@@ -322,6 +595,58 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}
 }
 
+#define ADXL345_generate_iio_dev_attr_FRACTIONAL(A, B, C, D, E)		\
+	static ssize_t in_accel_##A##_##C##_##E##_show(struct device *dev, \
+						       struct device_attribute *attr, \
+						       char *buf)	\
+	{								\
+		struct iio_dev *indio_dev = dev_to_iio_dev(dev);	\
+		struct adxl345_state *st = iio_priv(indio_dev);		\
+		int vals[2];						\
+									\
+		vals[0] = st->B##_##C##_##E;				\
+		vals[1] = D;						\
+									\
+		return iio_format_value(buf, IIO_VAL_FRACTIONAL, 2, vals); \
+	}								\
+									\
+	static ssize_t in_accel_##A##_##C##_##E##_store(struct device *dev, \
+							struct device_attribute *attr, \
+							const char *buf, size_t len) \
+	{								\
+		struct iio_dev *indio_dev = dev_to_iio_dev(dev);	\
+		struct adxl345_state *st = iio_priv(indio_dev);		\
+		int val_int, val_fract_us, ret;				\
+									\
+		ret = iio_str_to_fixpoint(buf, 100000, &val_int, &val_fract_us); \
+		if (ret)						\
+			return ret;					\
+									\
+		ret = adxl345_set_measure_en(st, false);		\
+		if (ret)						\
+			return ret;					\
+									\
+		adxl345_set_##B##_##C(st, val_int, val_fract_us);	\
+									\
+		ret = adxl345_set_measure_en(st, true);			\
+		if (ret)						\
+			return ret;					\
+									\
+		return len;						\
+	}								\
+	static IIO_DEVICE_ATTR_RW(in_accel_##A##_##C##_##E, 0)
+
+ADXL345_generate_iio_dev_attr_FRACTIONAL(gesture_singletap, tap, duration, MICRO, us);
+
+static struct attribute *adxl345_event_attrs[] = {
+	&iio_dev_attr_in_accel_gesture_singletap_duration_us.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group adxl345_event_attrs_group = {
+	.attrs = adxl345_event_attrs,
+};
+
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
 "0.09765625 0.1953125 0.390625 0.78125 1.5625 3.125 6.25 12.5 25 50 100 200 400 800 1600 3200"
 );
@@ -477,6 +802,17 @@ static const struct iio_buffer_setup_ops adxl345_buffer_ops = {
 
 static int adxl345_get_status(struct adxl345_state *st, unsigned int *int_stat)
 {
+	unsigned int regval;
+	bool check_tap_stat;
+
+	check_tap_stat = FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, st->tap_axis_ctrl) > 0;
+
+	if (check_tap_stat) {
+		/* ACT_TAP_STATUS should be read before clearing the interrupt */
+		if (regmap_read(st->regmap, ADXL345_REG_ACT_TAP_STATUS, &regval))
+			return -EINVAL;
+	}
+
 	return regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, int_stat);
 }
 
@@ -499,6 +835,25 @@ static int adxl345_fifo_push(struct iio_dev *indio_dev,
 	return 0;
 }
 
+static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat)
+{
+	s64 ts = iio_get_time_ns(indio_dev);
+	int ret;
+
+	if (FIELD_GET(ADXL345_INT_SINGLE_TAP, int_stat)) {
+		ret = iio_push_event(indio_dev,
+				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+							IIO_MOD_X_OR_Y_OR_Z,
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
@@ -516,6 +871,9 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 	if (adxl345_get_status(st, &int_stat))
 		return IRQ_NONE;
 
+	if (adxl345_push_event(indio_dev, int_stat) == 0)
+		return IRQ_HANDLED;
+
 	if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
 		samples = adxl345_get_samples(st);
 		if (samples < 0)
@@ -538,9 +896,14 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 
 static const struct iio_info adxl345_info = {
 	.attrs		= &adxl345_attrs_group,
+	.event_attrs	= &adxl345_event_attrs_group,
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
@@ -588,6 +951,10 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 
 	st->int_map = 0x00;			/* reset interrupts */
 
+	/* Init with reasonable values */
+	st->tap_threshold = 35;			/*   35 [0x23]            */
+	st->tap_duration_us = 3;		/*    3 [0x03] -> .001875 */
+
 	indio_dev->name = st->info->name;
 	indio_dev->info = &adxl345_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.39.5


