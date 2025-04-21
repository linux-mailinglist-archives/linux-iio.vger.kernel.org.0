Return-Path: <linux-iio+bounces-18473-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E04A958F8
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 00:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2A563A897D
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 22:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B820E221FD5;
	Mon, 21 Apr 2025 22:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPdUh/iN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EA5221541;
	Mon, 21 Apr 2025 22:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745273223; cv=none; b=NWEVXnf0LiRQPLDxMb7/g8rvO+FUSM8p0pcQSoGeQXjXQzYBKNx4VCD9qUhIz94VJ35f3KUet2XaHqVi8yYXb6fmRBTgllVVlc9C2bOjGbZT3h0rLM7ywmz/HVt28bfH/RznZrHRfGNAdLO39uGUC/O/VMpN6CCMgTUBiKXhitQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745273223; c=relaxed/simple;
	bh=u7HugNoxWSUaNP1adimKDBkibD2dTkBd882ZzUDDWBg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pDi6tiw5+kv7kC3a0vu6Bkm+e6Uw7fvjma5A4UbFBe3UBiDkt/AfJOk3yoAWkLOXDwDoUB2pXztikkLNe4n03V6czVkf1EqI/usUdf2erfRSoMjLT3eqQqmR2rglyWR+qTtWVpcANeBdAJsfWWZz5Q72Os6KlxccfTuLpKuH8ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPdUh/iN; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5f37f45e819so704864a12.3;
        Mon, 21 Apr 2025 15:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745273220; x=1745878020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yfTlM7bYUKW+qdxuoRFzRPDEGnqKN2kxZUE8Rurfp7U=;
        b=mPdUh/iNY2FRh9FR5q13GKYJWHKfW6uJZenfPb80wIi9SKbpzGu9opqYr6XxQIUfa6
         pmTS+QQOjJfDPouF/C2KXG2vl6vaXhp6w5kHjbF1AMPGtK0ZfTYxNgLdAGnm7LhNLLqe
         DfTiwLgrxedQsMe6NvK/0ZY3U7IA4bcZzeFXMTgzcVkn/eCMUKBuQ2pYflDqfsbj7Jkl
         xWjanNOolmSGepBQOmDTaNTJVPWfuQrdCA5pVFS3tI3YYPXUKpSoYe3k6Eau+DOZqBJg
         l9a1SnsXdxoZchQvZwDjSxSXZdBpQ/PATPytJPnQeMoKs73aQa4bC1LH3frjGH5EaGeU
         1p9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745273220; x=1745878020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yfTlM7bYUKW+qdxuoRFzRPDEGnqKN2kxZUE8Rurfp7U=;
        b=UDTqDDSyyJ9N41Is2DizdGpAUVAqaZ+M2ZQ2vVhL4agToh4Z2P2qXkIwpzaCfRF1sa
         AknCA4MAjHIi/LKNOqwSjYPiqZFZWC1lxBFWqYXd6/+OSAP7jWEHktkInEYVHp/EFlJv
         7XsQQuCvOesqx9syV8iwxXUf3Ub94EIV8iCW1GdMhXTErFu9Y3GZB+W/iSwJy2pYmIkR
         ZsygXJv2WEaUegCBZBI39phAg0vagKXY53dj4ZNtm2rlS8K4Vp+nQbwA0uhtY9AOsiz6
         1/ono0KffBf20b9qSCv7gAmE/uVgzniCts0fR0i3SOIMJoqa+t4TzvUTxRXINSj4Z/K3
         jUDg==
X-Forwarded-Encrypted: i=1; AJvYcCW39LhsBA2afVQwSmmun/Fg/iqkjrtHDgf7sOwMR8edRlG4101KedbVHFdwAO8Yd44MhguhSkqiHM5yWDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPlvBU/qvhtSyw9ub3EOgqYdxM7iXuKXvi7uAog8h5E5sHr1ar
	b5LWXHIDizFNnHzrb498xVJ2ZK2fD0Mir1dFuwI6wDB0W3KGWcAM
X-Gm-Gg: ASbGncvgTb4cBVWGrvEqsndqkzmpn0/BeORAWbNkYBmpd2qgvdzEFyJWmQ+c9PwFZqD
	k1CXRhHMfaK8hZHZVu+fZ1GRsvsYFYFaddg69CKDZGncJpG+tR1UB4DznxO69XiTKcNgD3NcPy6
	sMVOX7kbLBOck4QZ08WHypkBg+9hnctTEfg9o7p8lYSNco6tvKwLMCGbxiq9hjntcuQ2uSWRBlz
	Qa5hU2kqqHbrkfaK7FD9DGDRfttjJLgkwih0YW7Fm4w1cdB9CAsoWtfeXi6dA+oZ1vbKnsGXz3c
	ZG5j6t+2y+KB5qDfK1I6RMB/v4bcOi50VBTwapynGcEufOtIF6o02zcaq30N+9hnSvAwfR4+tsx
	6ryK/B2D/VG5jN/zfo2w=
X-Google-Smtp-Source: AGHT+IH9IeGifKvkXgiFjBYh3A6bk6CTM/xn2kBB7e7GEVclWumFSaUXMg4bppH4WkqMdjRlk/Gmhw==
X-Received: by 2002:a17:907:3e92:b0:acb:beb:e5df with SMTP id a640c23a62f3a-acb74745ea4mr348820066b.0.1745273219950;
        Mon, 21 Apr 2025 15:06:59 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acbb8d49fdasm80311666b.67.2025.04.21.15.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 15:06:59 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v7 05/11] iio: accel: adxl345: add freefall feature
Date: Mon, 21 Apr 2025 22:06:35 +0000
Message-Id: <20250421220641.105567-6-l.rubusch@gmail.com>
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

Add the freefall detection of the sensor together with a threshold and
time parameter. A freefall event is detected if the measuring signal
falls below the threshold.

Introduce a freefall threshold stored in regmap cache, and a freefall
time, having the scaled time value stored as a member variable in the
state instance.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 134 +++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index c464c87033fb..f42c861100cd 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -75,6 +75,7 @@ struct adxl345_state {
 	u32 tap_duration_us;
 	u32 tap_latent_us;
 	u32 tap_window_us;
+	u32 ff_time_ms;
 
 	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);
 };
@@ -122,10 +123,27 @@ enum adxl345_chans {
 	chan_x, chan_y, chan_z,
 };
 
+/* free fall */
+static const struct iio_event_spec adxl345_freefall_event_spec = {
+	.type = IIO_EV_TYPE_MAG,
+	.dir = IIO_EV_DIR_FALLING,
+	.mask_separate = BIT(IIO_EV_INFO_ENABLE),
+	.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+		BIT(IIO_EV_INFO_PERIOD),
+};
+
 static const struct iio_chan_spec adxl345_channels[] = {
 	ADXL345_CHANNEL(0, chan_x, X),
 	ADXL345_CHANNEL(1, chan_y, Y),
 	ADXL345_CHANNEL(2, chan_z, Z),
+	{
+		.type = IIO_ACCEL,
+		.modified = 1,
+		.channel2 = IIO_MOD_X_AND_Y_AND_Z,
+		.scan_index = -1, /* Fake channel */
+		.event_spec = &adxl345_freefall_event_spec,
+		.num_event_specs = 1,
+	},
 };
 
 static const unsigned long adxl345_scan_masks[] = {
@@ -383,6 +401,63 @@ static int adxl345_set_tap_latent(struct adxl345_state *st, u32 val_int,
 	return _adxl345_set_tap_time(st, ADXL345_TAP_TIME_LATENT, val_fract_us);
 }
 
+/* freefall */
+
+static int adxl345_is_ff_en(struct adxl345_state *st, bool *en)
+{
+	int ret;
+	unsigned int regval;
+
+	ret = regmap_read(st->regmap, ADXL345_REG_INT_ENABLE, &regval);
+	if (ret)
+		return ret;
+
+	*en = FIELD_GET(ADXL345_INT_FREE_FALL, regval) > 0;
+
+	return 0;
+}
+
+static int adxl345_set_ff_en(struct adxl345_state *st, bool cmd_en)
+{
+	unsigned int regval, ff_threshold;
+	bool en;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADXL345_REG_THRESH_FF, &ff_threshold);
+	if (ret)
+		return ret;
+
+	en = cmd_en && ff_threshold > 0 && st->ff_time_ms > 0;
+
+	regval = en ? ADXL345_INT_FREE_FALL : 0x00;
+
+	return regmap_update_bits(st->regmap, ADXL345_REG_INT_ENABLE,
+				  ADXL345_INT_FREE_FALL, regval);
+}
+
+static int adxl345_set_ff_time(struct adxl345_state *st, u32 val_int,
+			       u32 val_fract_us)
+{
+	unsigned int regval;
+	int val_ms;
+
+	/*
+	 * max value is 255 * 5000 us = 1.275000 seconds
+	 *
+	 * Note: the scaling is similar to the scaling in the ADXL380
+	 */
+	if (1000000 * val_int + val_fract_us > 1275000)
+		return -EINVAL;
+
+	val_ms = val_int * 1000 + DIV_ROUND_UP(val_fract_us, 1000);
+	st->ff_time_ms = val_ms;
+
+	regval = DIV_ROUND_CLOSEST(val_ms, 5);
+
+	/* Values between 100ms and 350ms (0x14 to 0x46) are recommended. */
+	return regmap_write(st->regmap, ADXL345_REG_TIME_FF, min(regval, 0xff));
+}
+
 static int adxl345_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
@@ -495,6 +570,11 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_EV_TYPE_MAG:
+		ret = adxl345_is_ff_en(st, &int_en);
+		if (ret)
+			return ret;
+		return int_en;
 	default:
 		return -EINVAL;
 	}
@@ -518,6 +598,8 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_EV_TYPE_MAG:
+		return adxl345_set_ff_en(st, state);
 	default:
 		return -EINVAL;
 	}
@@ -532,6 +614,7 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
 	unsigned int tap_threshold;
+	unsigned int ff_threshold;
 	int ret;
 
 	switch (type) {
@@ -565,6 +648,22 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_EV_TYPE_MAG:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			ret = regmap_read(st->regmap, ADXL345_REG_THRESH_FF,
+					  &ff_threshold);
+			if (ret)
+				return ret;
+			*val = ff_threshold;
+			return IIO_VAL_INT;
+		case IIO_EV_INFO_PERIOD:
+			*val = st->ff_time_ms;
+			*val2 = 1000;
+			return IIO_VAL_FRACTIONAL;
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -612,6 +711,22 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 		break;
+	case IIO_EV_TYPE_MAG:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			ret = regmap_write(st->regmap, ADXL345_REG_THRESH_FF, val);
+			if (ret)
+				return ret;
+			break;
+		case IIO_EV_INFO_PERIOD:
+			ret = adxl345_set_ff_time(st, val, val2);
+			if (ret)
+				return ret;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -865,6 +980,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
 			return ret;
 	}
 
+	if (FIELD_GET(ADXL345_INT_FREE_FALL, int_stat)) {
+		ret = iio_push_event(indio_dev,
+				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+							IIO_MOD_X_AND_Y_AND_Z,
+							IIO_EV_TYPE_MAG,
+							IIO_EV_DIR_FALLING),
+				     ts);
+		if (ret)
+			return ret;
+	}
+
 	if (FIELD_GET(ADXL345_INT_WATERMARK, int_stat)) {
 		samples = adxl345_get_samples(st);
 		if (samples < 0)
@@ -973,6 +1099,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 					 ADXL345_DATA_FORMAT_FULL_RES |
 					 ADXL345_DATA_FORMAT_SELF_TEST);
 	unsigned int tap_threshold;
+	unsigned int ff_threshold;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
@@ -992,6 +1119,9 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	st->tap_window_us = 64;			/*   64 [0x40] -> .080    */
 	st->tap_latent_us = 16;			/*   16 [0x10] -> .020    */
 
+	ff_threshold = 8;			/*    8 [0x08]            */
+	st->ff_time_ms = 32;			/*   32 [0x20] -> 0.16    */
+
 	indio_dev->name = st->info->name;
 	indio_dev->info = &adxl345_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -1068,6 +1198,10 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 		if (ret)
 			return ret;
 
+		ret = regmap_write(st->regmap, ADXL345_REG_THRESH_FF, ff_threshold);
+		if (ret)
+			return ret;
+
 		/* FIFO_STREAM mode is going to be activated later */
 		ret = devm_iio_kfifo_buffer_setup(dev, indio_dev, &adxl345_buffer_ops);
 		if (ret)
-- 
2.39.5


