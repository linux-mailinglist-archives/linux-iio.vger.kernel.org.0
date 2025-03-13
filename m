Return-Path: <linux-iio+bounces-16794-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2602A5FCA4
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 17:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053B8189F4DC
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 16:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5C226B0AA;
	Thu, 13 Mar 2025 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqwGGX50"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0C426B082;
	Thu, 13 Mar 2025 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884678; cv=none; b=RmrJ9IK+Co7xC/E8ovv9RSVKjUO7Z5Y8hI5tW/5KJ9gozgnBqK+4tBBo/LAn34D2DXR1ZK7ZuzBI5Po2SN1IRDpLc5tXccSOxpRo4tlinuuaUmdyBIV3kXq9T23mK56B5BBMoc8GN5BOMCTOPIK9/PO2lWDElUPq5UIeyKg86KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884678; c=relaxed/simple;
	bh=ZgD+ggEIcZvGSmTEh6HZK6oXnQsJrbJ0FFZVMJVYXL4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S54922DxspbW9y8ftOlYBk1DbnXbWaK3z7Ul9czHSRquuhFnC0B4KjHX8B+lXOjKbT9G1w4DlOECW1kRH6IzSjrub/XIILN0rB9Uji+tYPI7I2oIZH87GosrgqpqaHb6ApKhqz3rA3RZS/BF3urmWdY99J0SJKarmYifu5c+KoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqwGGX50; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac30d4ee0f5so15650066b.0;
        Thu, 13 Mar 2025 09:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741884673; x=1742489473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=37rTZ9VYdIOohXqPChjfDU8OspBVgffgmeVDmCtP9bU=;
        b=nqwGGX50zNAV8TiQBgAKLOORXkE9Sq0/cg+QL9ztNwEFbYjNmgwn/H06ozgliSynfx
         zVIdlEViyP7vWnA4MeIxE8i1vdmtZKSz3+qbWZhvJnd8SC7BMPINKaETM7m4lXPx2vyT
         zLjci6pZv9NZL54s6MBMpmI3PjR7soX5OCIgufrAWosKUdfME/tzEdfaXxlpgn8hmVUq
         sJ4PEbHXmG1cNam3fF0m0TB6KHlb8k73b167/cz/SKJwr7jUzPON6En4RQHMLfGtJe+R
         vimpq/NbNxrJ8kkeqKiDN4Z1pO6haQZPDMIyZEv09cL4Q7o1PH7DUUmt31cKGKEVSL2y
         xQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741884673; x=1742489473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37rTZ9VYdIOohXqPChjfDU8OspBVgffgmeVDmCtP9bU=;
        b=X7qyQtzY9s/vB1XAkaa4wMCr9XeENrIwAkQPnnmsRAIRxYGLqIwOnh4crcT5YtFgBH
         jPqtg3SzTNNTYhMujJljNROHxm2HOS2kPQP20u8nIeZQr4oUFnr8NyQFEJNmCYDESQJ7
         2I8Lq/QKrvlHEogUohXlSsqab5MNmNpU4BxOQR7vRnH+F8bO6s3c4U2can6DmdF5N+3i
         0jf+NbbFbKCMOJnabowVQii9txGczwTx+wORncOlt0g9MG+zRwtnd46emZqXpTVnu9Bx
         JxUCD3lK88NQNmN1pkStWoDaPSM6dYBgkqQAaysdHyZbPs0ODfbMG0YUENgh+0rZQG/h
         p+eA==
X-Forwarded-Encrypted: i=1; AJvYcCV772ElOfWcWr0ULRinf3KeosqO6Gav8LB2/wEqGTZesELKW/HTtsoSvNWD6kwbJ6KUxzhEOEFPGI4eIX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzKc36hE8eWLh/x9rqZmqBt+9Zt6CTmyk6GTzoiL7PZ+4q8KxY
	fuAOEfUKKcNKU1I0+hnob7JSWfu4iwR6O61jhquv+tskY4fdZnBD
X-Gm-Gg: ASbGncsN0DbTXal6S4ToiFNTlKrqI2JqtQZzxB6lp2m53xh+11QZ9g0/soPQprVmQ8u
	uRRn0VeCoN7CPEO+D4EKtprkrsdto9epLP+zKld6XoB4B02vf+MeFyHJ8NGKksp7QxI5S719W4Y
	LT6vx98fPx5UkcY48mOIusAaSMvs7VTlvcgRXQ3aAcoDP1Pmj2LXgd2qL+QHCa5UxlouctSUEN2
	vd0z7h9dg/xq8/mKoVPMTmD9IShIJZaBG95RHPMma4q3S+Jg6iRCFmwogOo083Yjv1vwp/EV1kX
	6YHZsQxcc64IajOsaoykfH5d5+ZX7bYSocGzd4jcEH+IZlhoJ4zOH5UnK4yua7L+f/GSgXNfS/I
	K4lbV94enKOVdZG/fKChE1w8=
X-Google-Smtp-Source: AGHT+IEqHMw42K5AdfCt9I4LgUiwhZagxRJybAE+sFmFjKbjrlgD0n95lQ/SHgKqXkVdimpI54SGOQ==
X-Received: by 2002:a17:907:7243:b0:abb:e5ac:28b2 with SMTP id a640c23a62f3a-ac271639fa7mr987282066b.13.1741884673355;
        Thu, 13 Mar 2025 09:51:13 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147efb0csm101370866b.65.2025.03.13.09.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:51:13 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v4 08/14] iio: accel: adxl345: add freefall feature
Date: Thu, 13 Mar 2025 16:50:43 +0000
Message-Id: <20250313165049.48305-9-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313165049.48305-1-l.rubusch@gmail.com>
References: <20250313165049.48305-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl345_core.c | 122 +++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 9e33236c786a..1a2bf0c630c9 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -78,6 +78,7 @@ struct adxl345_state {
 	u32 tap_duration_us;
 	u32 tap_latent_us;
 	u32 tap_window_us;
+	u32 ff_time_ms;
 
 	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);
 };
@@ -99,6 +100,14 @@ static struct iio_event_spec adxl345_events[] = {
 			BIT(IIO_EV_INFO_RESET_TIMEOUT) |
 			BIT(IIO_EV_INFO_TAP2_MIN_DELAY),
 	},
+	{
+		/* free fall */
+		.type = IIO_EV_TYPE_MAG,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
+			BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_PERIOD),
+	},
 };
 
 #define ADXL345_CHANNEL(index, reg, axis) {					\
@@ -379,6 +388,64 @@ static int adxl345_set_tap_latent(struct adxl345_state *st, u32 val_int,
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
+	const unsigned int freefall_mask = 0x02;
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
+				  freefall_mask, regval);
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
@@ -491,6 +558,11 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
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
@@ -514,6 +586,8 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_EV_TYPE_MAG:
+		return adxl345_set_ff_en(st, state);
 	default:
 		return -EINVAL;
 	}
@@ -528,6 +602,7 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
 	unsigned int tap_threshold;
+	unsigned int ff_threshold;
 	int ret;
 
 	switch (type) {
@@ -561,6 +636,22 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
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
@@ -601,6 +692,18 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
 			break;
 		}
 		break;
+	case IIO_EV_TYPE_MAG:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			ret = regmap_write(st->regmap, ADXL345_REG_THRESH_FF, val);
+			break;
+		case IIO_EV_INFO_PERIOD:
+			ret = adxl345_set_ff_time(st, val, val2);
+			break;
+		default:
+			ret = -EINVAL;
+		}
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -862,6 +965,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
 			return ret;
 	}
 
+	if (FIELD_GET(ADXL345_INT_FREE_FALL, int_stat)) {
+		ret = iio_push_event(indio_dev,
+				     IIO_MOD_EVENT_CODE(IIO_ACCEL, 0,
+							IIO_MOD_X_OR_Y_OR_Z,
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
@@ -968,6 +1082,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 					 ADXL345_DATA_FORMAT_FULL_RES |
 					 ADXL345_DATA_FORMAT_SELF_TEST);
 	unsigned int tap_threshold;
+	unsigned int ff_threshold;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
@@ -987,6 +1102,9 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	st->tap_window_us = 64;			/*   64 [0x40] -> .080    */
 	st->tap_latent_us = 16;			/*   16 [0x10] -> .020    */
 
+	ff_threshold = 8;			/*    8 [0x08]            */
+	st->ff_time_ms = 32;			/*   32 [0x20] -> 0.16    */
+
 	indio_dev->name = st->info->name;
 	indio_dev->info = &adxl345_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -1063,6 +1181,10 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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


