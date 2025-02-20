Return-Path: <linux-iio+bounces-15833-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED28AA3D718
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 11:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7FEF17A642
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 10:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151131F3FD0;
	Thu, 20 Feb 2025 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MhTA+j23"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C6B1CAA9C;
	Thu, 20 Feb 2025 10:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048168; cv=none; b=IpsB/BHcjeTLOy4Bb2NyMtT4QAKMcfy6exTBAZarI7A53bv6vKF9QA3FrwAoQfBMpIrO5lel8aF6Z8fXyLt+FGG+fMdZTafNhAzBXJvznu6zv3bcsfHaAcEyzYSz2KMfrt+3OLYYABO981jM6ARbGIXlx8mYIwSwjvCA1FY3FIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048168; c=relaxed/simple;
	bh=5jyI0GPJq4BjxA7uxkcbW2WX7rH37hTPuEJHW4cYwm0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dw37UqBbmZVt1By0xM3zrsG1rVi/C++XLK3+MvWGtvZO13eH1EElIgawLPR737cHWenyWwm2Q3freqef/YNykzHelNm4myC51pXa9lURSf56oGu/P0OPOIWQNvb4C5JDrAvfGaejOrBx2TIw9NYA/Orb89lCX8wrwvz7iHBmlAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MhTA+j23; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abb76cc6108so11413066b.0;
        Thu, 20 Feb 2025 02:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740048165; x=1740652965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbTRB3FoNxAsFddX7uPnXtU8eXUuScjraZJR3tByUSo=;
        b=MhTA+j23yVG2qZlB+hSRhtkh+A9gqilTjxaeKFQYWRWlhKxOYlGk4XmaOqBGrBso/f
         o1qRdoHwnwEZTQirloOTYPp6fVQFs9Rle8vdcJX+WiKa5muTmaqaUnH5Pl6k3+ygl4RL
         43STSoEiaxV0sImRuDPDaAzX+K7fWHbpn52+AOaMQbVonML0Znp67/l6WiQypW9PSAfh
         5AtFnDRB2z2x39Bw6+rb+xxriL4mp6hGKXNoI3d8lwzMwaLgHB88/91iBn52wo95ry56
         lbC5RN6oxOecLcxe6Qjp0widsMifLFNZ/N2B92pvOAtK5H1oeo8FUU6EZM4+BL2MYs7Z
         AxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740048165; x=1740652965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbTRB3FoNxAsFddX7uPnXtU8eXUuScjraZJR3tByUSo=;
        b=n4i2VT4NlqYINi8HLPQFLyytWKoylNOZXccLWMP3ncEN4VvIlh2JiLilsZi8fqMLCs
         FmVNVMyqLawFxZprD9BMS1W0P/nEs+AL62R0nNZZxFOc6qND6AMIhJ5/xE7nLgh8aIen
         RVDGd2iB+22Afq1IT8BNQI/8+90e6HNjM2wBfHwpIUqKlfW2XTNEa6T1Pr7pGE5AlATZ
         bwpIUcnqGjfVOwQaQ02L/7Tg4TcGluGMuImboz/0ugkGfGMelPac6DFUtKVRpXgFGiGR
         dLKVCaIcnzglu3k1dP4p5G3Nqrp4xRwmf5PybWzUpc4Fe7fEeUTzAf4MDPK3woh9isLV
         3/tw==
X-Forwarded-Encrypted: i=1; AJvYcCUp6Rme9DLvygEZsV27y2ZcowiZx44/DaGTm64KiUXTvE1hjGztVCexNfPMApgXLna+zgFKaKSWIXEGzV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtabCBYEEq3syI95nrQfP1OkAZIgF8wf6+7byCVgJadMAObkRg
	toOfpoGsHhvzGvcneMg4JGeBEhZSGzt1LGalK1xZvMhK5DQKH/i7
X-Gm-Gg: ASbGncuMDNX7PCYDc2WYYv6JCef9ih4aZIEv4bKAmOhbXi7UV0V2pqWIczpoX8Gty4A
	q14uY8aJKaovBO6CEEp/1YuH0LIszB+l+DIfZwHLyx1Kpn3o1wmJaeGl2eUZOjh9MzqWy43Xg4h
	L87yUAOU3d15E7lgvWGPm5/O9J58RURo6EWvsrYFwSaxocw/nbQ00e+T5hr4+44AFXX65U9AGUy
	DBS/yHo/Y6W6P4cUPym3Cq1ifUiG8aGm8wh6T56d/WgOgyoEYRTXuxqtlDhJ6gB3poj2MSuMEBA
	w+XMZ3vEDYQNgCbeYx6ISpHITHQYgNKCS+L/TLx9bjgGG5crSqMjxtPpmzX7jvYRo3/c+Q==
X-Google-Smtp-Source: AGHT+IE2yZjfHtbINlhq1SPgXqpxMlXv73y6RIZijnkxdLfgh0CtCRiSq2SyDKOgOlg5ERfU2+wkXQ==
X-Received: by 2002:a17:907:7248:b0:ab7:82a7:bb1f with SMTP id a640c23a62f3a-abb70d96de8mr824232666b.10.1740048164434;
        Thu, 20 Feb 2025 02:42:44 -0800 (PST)
Received: from 0f997e1ceb21.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbdfcaed55sm246474866b.137.2025.02.20.02.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:42:44 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v3 06/15] iio: accel: adxl345: add single tap feature
Date: Thu, 20 Feb 2025 10:42:25 +0000
Message-Id: <20250220104234.40958-7-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220104234.40958-1-l.rubusch@gmail.com>
References: <20250220104234.40958-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl345_core.c | 364 ++++++++++++++++++++++++++++++-
 1 file changed, 362 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 0cee81bc1877..d05593c0d513 100644
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
@@ -38,9 +67,23 @@ struct adxl345_state {
 	int irq;
 	u8 watermark;
 	u8 fifo_mode;
+
+	u32 tap_axis_ctrl;
+	u32 tap_duration_us;
+
 	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);
 };
 
+static struct iio_event_spec adxl345_events[] = {
+	{
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
@@ -57,6 +100,8 @@ struct adxl345_state {
 		.storagebits = 16,			\
 		.endianness = IIO_LE,			\
 	},						\
+	.event_spec = adxl345_events,			\
+	.num_event_specs = ARRAY_SIZE(adxl345_events),	\
 }
 
 enum adxl345_chans {
@@ -83,6 +128,7 @@ bool adxl345_is_volatile_reg(struct device *dev, unsigned int reg)
 	case ADXL345_REG_DATA_AXIS(3):
 	case ADXL345_REG_DATA_AXIS(4):
 	case ADXL345_REG_DATA_AXIS(5):
+	case ADXL345_REG_ACT_TAP_STATUS:
 	case ADXL345_REG_FIFO_STATUS:
 	case ADXL345_REG_INT_SOURCE:
 		return true;
@@ -112,6 +158,117 @@ static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
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
+	unsigned int int_map = 0x00;
+	unsigned int tap_threshold;
+	bool axis_valid;
+	bool singletap_args_valid = false;
+	bool en = false;
+	int ret;
+
+	axis_valid = FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, st->tap_axis_ctrl) > 0;
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
@@ -197,6 +354,160 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
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
+			break;
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
+			break;
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
+			 * The scale factor is 62.5mg/LSB (i.e. 0xFF = 16g) but
+			 * not applied here.
+			 */
+			ret = regmap_read(st->regmap, ADXL345_REG_THRESH_TAP, &tap_threshold);
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
+			break;
+		case IIO_EV_INFO_TIMEOUT:
+			ret = adxl345_set_tap_duration(st, val, val2);
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+		break;
+	default:
+		ret = -EINVAL;
+		break;
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
@@ -419,6 +730,26 @@ static int adxl345_fifo_push(struct iio_dev *indio_dev,
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
@@ -430,12 +761,28 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 {
 	struct iio_dev *indio_dev = p;
 	struct adxl345_state *st = iio_priv(indio_dev);
-	int int_stat;
-	int samples;
+	unsigned int regval;
+	enum iio_modifier act_tap_dir  = IIO_NO_MOD;
+	int int_stat, samples, ret;
+
+	if (FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, st->tap_axis_ctrl) > 0) {
+		ret = regmap_read(st->regmap, ADXL345_REG_ACT_TAP_STATUS, &regval);
+		if (ret)
+			return ret;
+		if (FIELD_GET(ADXL345_Z_EN, regval) > 0)
+			act_tap_dir = IIO_MOD_Z;
+		else if (FIELD_GET(ADXL345_Y_EN, regval) > 0)
+			act_tap_dir = IIO_MOD_Y;
+		else if (FIELD_GET(ADXL345_X_EN, regval) > 0)
+			act_tap_dir = IIO_MOD_X;
+	}
 
 	if (regmap_read(st->regmap, ADXL345_REG_INT_SOURCE, &int_stat))
 		return IRQ_NONE;
 
+	if (adxl345_push_event(indio_dev, int_stat, act_tap_dir) == 0)
+		return IRQ_HANDLED;
+
 	if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
 		samples = adxl345_get_samples(st);
 		if (samples < 0)
@@ -461,6 +808,10 @@ static const struct iio_info adxl345_info = {
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
@@ -494,6 +845,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 					 ADXL345_DATA_FORMAT_JUSTIFY |
 					 ADXL345_DATA_FORMAT_FULL_RES |
 					 ADXL345_DATA_FORMAT_SELF_TEST);
+	unsigned int tap_threshold;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
@@ -507,6 +859,10 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		return -ENODEV;
 	st->fifo_delay = fifo_delay_default;
 
+	/* Init with reasonable values */
+	tap_threshold = 48;			/*   48 [0x30] -> ~3g     */
+	st->tap_duration_us = 16;		/*   16 [0x10] -> .010    */
+
 	indio_dev->name = st->info->name;
 	indio_dev->info = &adxl345_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -579,6 +935,10 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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


