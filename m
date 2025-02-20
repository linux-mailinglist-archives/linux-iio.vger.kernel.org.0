Return-Path: <linux-iio+bounces-15836-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6B4A3D71E
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 11:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B68C7A9225
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 10:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7671F4628;
	Thu, 20 Feb 2025 10:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKvhOZsI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C7C1F4167;
	Thu, 20 Feb 2025 10:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048171; cv=none; b=VaL+dEXcC9jhqTveDtY6vVkO7AOFEQF2aP0HL3N1xpdwmxVqoyrE5atCNa7IczXeYq6WLfT9anaEf60SEsHgNdpXVlIGAQacG518NzHaAuLx9cCNAl3liSycJ0XkBpCmljWPnK6N1/ujqKYV7D21sVUEKuS23DOP4LisKCGMl5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048171; c=relaxed/simple;
	bh=/c13zuYptb0ZWGvmPSo0Ms0ITzJfpzc8HWI5U+Afwok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HOth7+T1CyROY7qXpfvtNxi8dytf38swQzWnwRCtqs3mTuTTulirYp2nGZI7nt+hLo/UWGsnqGbRLWjGLg6v8qwkSg2ZKnDPNnQYTxdO+TACHqL7z9FKN+pXj7FuywaBA+S3J/jiNn91ukSi9by9iTknv5ve1MKLeQ7V7Gbf/4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKvhOZsI; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abb7d5a6577so8422166b.2;
        Thu, 20 Feb 2025 02:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740048168; x=1740652968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tPPQP8puSdAdZPHNmR3ieICP+QZSlGfGIEXG2SGjIY=;
        b=KKvhOZsItCUoqV26aQ3h65QRmhOpnSHPeE5BaFR5YSvYBUBGK21eXnYJqk23LzJk8t
         ypeZqHRlpweYg4KXHxQDShWN7CVNyqlM3SW5SLQ4IdHKMs5QsVUDBpQqvCHBrIw8GntZ
         FSMPdfQTIgIwF49G2duHjViwmDW8qrqc6jXP61e/ZiNVk6FanOyu8+xF3sQqsIufGeTI
         8j3Z49a4eWEi9T5SJYEd0riKfLSQVm1OCtZL6X8bq9U0+UE14Qki36wNZhjgge84c5v+
         Z36jz66p+xUqdrf7njwhoa8vl/eVD+tdNeYF8vCo812000DKkgAtgHBncQgWkg9ZIqXi
         v3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740048168; x=1740652968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7tPPQP8puSdAdZPHNmR3ieICP+QZSlGfGIEXG2SGjIY=;
        b=ergCIdoqkxQzjFk3AJAKrU54KZWcmvp0ZKwH8ETr+q9/eMbAZFaGj3u82AGGUfLEez
         QTgiCw+YCkX0HWKTTHKexIhQBtjfmJWq7IKbc3/z7GdVqzzf+5ZZHcPFubk3HFiTWocK
         e6wg2INRYRKisKkmjP+X3JVkTZrk1HzZB+z95DmYyRFwQdE5HCR24hiFs5OTYVWDU4uO
         0tDcPnQAqyviQrt+BI5Fpfa6bHBGB197iSjJh2DcB6aqVdn9urKjDPuJXg1PyflscyP7
         TwjTzrMfio4HnnjUDgNN51ID9bYCAKYBkQK2V1VYE8ppRH0VPQ8GNCllZTIr74QOiFh4
         XnUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVgRaY2jkLMFEXLa3B2okpsX63TMmo4EWL3KU5xFAQx7jlI0DVOzaqfN1Zpwp1cAbt9pYGdZPoqN8JZ+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAErdA3esTZOnDFWd2nNykevIA7DFAuofZNyo6+NGHSXHKAKxA
	A29XibdOAS/yzpdwa5st02wdJenR9g+Kd5VKNpneYlVXtX0qTNTM
X-Gm-Gg: ASbGncsATcKxmSy1trJfkKwkb817nHQCIO4DqnGYMIJ4PnQNkLUJvO7Ws1nTv3NFGpM
	Reh9X3Berwdufw8/wwy7M1am6GyuXFAlTG5VzBlIYhoK2aUgyQQ/XziTmLnR/z6Pigl1jNjmBgj
	J9orgLzqMunZNqilaJdqtPauI4b37L7Avhsq9KcP4HmqF5mC4fO5s4pmCUB4zh9zG3GugUv2Eo1
	myOczX3BvRTq9qlC0yG84u9iHSMec1fpRSkbyOxxaygT8LT+uU62jYu8G8BEpOgBzZ/ERPSd5+/
	SPLdXqZYbaA5UplpE98K7H5/hFUIN6vktNmmKUoflMIYqp2Ta31zi0DDNa8Vgh7Aq9MkLg==
X-Google-Smtp-Source: AGHT+IG+DEFamWgcrhRCN4CxkKQ+4rgCOVBCw3nbAc01Y7LUIhWNwYpwU4HClBnj2eBqEkVcd0ktAQ==
X-Received: by 2002:a17:906:37db:b0:abb:da39:2447 with SMTP id a640c23a62f3a-abbda39282dmr190609366b.7.1740048167474;
        Thu, 20 Feb 2025 02:42:47 -0800 (PST)
Received: from 0f997e1ceb21.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbdfcaed55sm246474866b.137.2025.02.20.02.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:42:47 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v3 09/15] iio: accel: adxl345: add freefall feature
Date: Thu, 20 Feb 2025 10:42:28 +0000
Message-Id: <20250220104234.40958-10-l.rubusch@gmail.com>
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
index 10cd81dd08bb..7f842e7f371a 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -79,6 +79,7 @@ struct adxl345_state {
 	u32 tap_duration_us;
 	u32 tap_latent_us;
 	u32 tap_window_us;
+	u32 ff_time_ms;
 
 	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);
 };
@@ -98,6 +99,14 @@ static struct iio_event_spec adxl345_events[] = {
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
@@ -345,6 +354,64 @@ static int adxl345_set_tap_latent(struct adxl345_state *st, u32 val_int,
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
@@ -471,6 +538,11 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
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
@@ -510,6 +582,8 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_EV_TYPE_MAG:
+		return adxl345_set_ff_en(st, state);
 	default:
 		return -EINVAL;
 	}
@@ -524,6 +598,7 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
 	unsigned int tap_threshold;
+	unsigned int ff_threshold;
 	int ret;
 
 	switch (type) {
@@ -554,6 +629,22 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
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
@@ -594,6 +685,18 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
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
@@ -855,6 +958,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
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
 	return -ENOENT;
 }
 
@@ -954,6 +1068,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 					 ADXL345_DATA_FORMAT_FULL_RES |
 					 ADXL345_DATA_FORMAT_SELF_TEST);
 	unsigned int tap_threshold;
+	unsigned int ff_threshold;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
@@ -973,6 +1088,9 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	st->tap_window_us = 64;			/*   64 [0x40] -> .080    */
 	st->tap_latent_us = 16;			/*   16 [0x10] -> .020    */
 
+	ff_threshold = 8;			/*    8 [0x08]            */
+	st->ff_time_ms = 32;			/*   32 [0x20] -> 0.16    */
+
 	indio_dev->name = st->info->name;
 	indio_dev->info = &adxl345_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -1049,6 +1167,10 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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


