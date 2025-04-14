Return-Path: <linux-iio+bounces-18110-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F96A88B93
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 20:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E1837A22C2
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 18:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CA828F518;
	Mon, 14 Apr 2025 18:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eG83h5zg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6879028DF12;
	Mon, 14 Apr 2025 18:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744656178; cv=none; b=PmMS1C3gNHhvW33ZHiaLoK6im1FJt/dE5Yh7fzr7roe8AEmSIsQ4fCZLMmYXNSqTYFOAhP9H1Ih7HTTtLPW7wRa+N7jft9KCj8zAaCPHrUihFqU5ef1rV9+lstxC/Wwi/mCiOVgSLI0blox0WF2ajjVZo7DZCvbC6Tvg++Tuhps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744656178; c=relaxed/simple;
	bh=okZLLCEBu0H3RhSIIU1fzQZoC+9KvNdvuWVj0hHY8CQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gAa+iicaKsVXlBOGp6i52E1GjAEDpiCaOqBoMaeip5Xg3g9jUk/Svy9UipLuJQCgBKgk7xWoaPNIh8QUMe12oeK4p4AaBBIGK4japv5XTb4BjMA5WdMsmOs4k/qXuG4xxqeXc06SDWR44A24XtcDr/e37ngyNew6j831aw10mIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eG83h5zg; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2c7a36802so85359166b.2;
        Mon, 14 Apr 2025 11:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744656174; x=1745260974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xl4fo+5wq9O04rfHJRdTZpJiIbJaDuhNxt56NkmrfbY=;
        b=eG83h5zgegdyz4a6s3pgJ9xVHdSUgL9n+aLSbgl/dRfEafFuoTnav+Y0ZaFzX/2zoC
         i+chmhc/R6MEhjsX7WJju6UswYUf1nsB6yRt+hggyxInJ63m1Uethz8fokyEPEl65ZY+
         kTzUCpg6ujNqSqKB7n5woWBLPNgAydLyvELnGWcti21xPELLFODCrQ45D+Tvt3KIGnMC
         jEXmKN+7v2gtDGDohHBAQqJmY2P269+KA9cDRHnxbIizgIZ0JtwmG7S2J/GpOmv6KPuf
         fDpYxUqEVRDZaH+8kmQ3KAHitoPhPiUUzdSdwUtqPi2PWdrCy4qwYQCM/cOb7En+Y1J6
         L1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744656174; x=1745260974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xl4fo+5wq9O04rfHJRdTZpJiIbJaDuhNxt56NkmrfbY=;
        b=hYZgw37RWETSfNzMHltdpeenqZYm+tEWZXrdfTk2QXv84AahHRUZLNlVtKUwpgqc/h
         WWr6RyN4OsD69hvn0LX2kGqArR/ZgHvxyjvC0lEzbYZEKowHLIGqbajJgQhNnQcaqMAj
         dicA9x4N0fnYHWrkz4tzntWSyuDg8vi9GwgFRQEzgn52NNQ8ZYhak0DJ5k+GpUrpzCav
         iov79WBHUhdg2BqTIx4eoyroO8GOWAFtf46k7l4Ro0tS4DGY+fczlKBkXwRlJjYDyRSb
         imYH2RUzdXhIRnJVC+Da9bgXYAY2UL5mD+80FN4xx5h/++CduT5B3atLhsFrlw4xR1rg
         /KZA==
X-Forwarded-Encrypted: i=1; AJvYcCW/pbG3Njb2+azqCgR5ZlrXvixG3HkKf/7uBRNMTsNtG0wsz7SXivBq6t3epdk0nyu5P6/Erv6Kv19njYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG9n/odqiR44pMCHzkUJp+STt9oSzwORGpmHtp2/iIjaPbpYc6
	abVlCZ2KFRryq6wDtGCjkFfQmtV6OobNMeg3qkTC2Ae4EZ9+7aM+
X-Gm-Gg: ASbGnctb/xzPwFyRMY/CoOEKcwlSN+aRFhdwrxdLVI4G0c4fy3BnWf5T0OEDX88QY34
	+n3vzPIyZIFGQQYZBSzQHVYY+4Bj1gZjZ2+K3n/ZF0r7N1Cp17yc1f94NNvIxiMIF+HKLvv2xgG
	H5tsZwJ9dC0YoaulsdyOSHHS1ip06iLsC+lJAiKF/Q2Tb5XpXFFJ5sxFBLtIUZI2EEfM1phpDdo
	GbXV1OUjnrPIoH3pwMFrT5IcJjl8ugKn3VaER37YAN2UYU0haj7uT9i3B/krNM4ERAsKz9JSbJ0
	S7t4pkElhWgly0dcPslyARSetvudfdydo2/YSMFeJs5Gw2zYPf7ea1/gQ2wiLvtfXmJA/EAbpME
	9cpli5vOoaGL+pATviFo=
X-Google-Smtp-Source: AGHT+IERiWRNepLz2BnGPMbtnKAJQ6q+vCT63Sc+FjOnx/eOr5ZLKdeWpHG/ddjekxE9ELxQ94vjbQ==
X-Received: by 2002:a17:907:9588:b0:ab7:5fcd:d4db with SMTP id a640c23a62f3a-acad34d88d5mr453359566b.9.1744656174276;
        Mon, 14 Apr 2025 11:42:54 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bb3172sm946483466b.24.2025.04.14.11.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 11:42:53 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v6 05/11] iio: accel: adxl345: add freefall feature
Date: Mon, 14 Apr 2025 18:42:39 +0000
Message-Id: <20250414184245.100280-6-l.rubusch@gmail.com>
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

Add the freefall detection of the sensor together with a threshold and
time parameter. A freefall event is detected if the measuring signal
falls below the threshold.

Introduce a freefall threshold stored in regmap cache, and a freefall
time, having the scaled time value stored as a member variable in the
state instance.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 125 +++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index c464c87033fb..ae02826e552b 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -75,6 +75,7 @@ struct adxl345_state {
 	u32 tap_duration_us;
 	u32 tap_latent_us;
 	u32 tap_window_us;
+	u32 ff_time_ms;
 
 	__le16 fifo_buf[ADXL345_DIRS * ADXL345_FIFO_SIZE + 1] __aligned(IIO_DMA_MINALIGN);
 };
@@ -96,6 +97,14 @@ static struct iio_event_spec adxl345_events[] = {
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
@@ -383,6 +392,63 @@ static int adxl345_set_tap_latent(struct adxl345_state *st, u32 val_int,
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
@@ -495,6 +561,11 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
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
@@ -518,6 +589,8 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_EV_TYPE_MAG:
+		return adxl345_set_ff_en(st, state);
 	default:
 		return -EINVAL;
 	}
@@ -532,6 +605,7 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
 	unsigned int tap_threshold;
+	unsigned int ff_threshold;
 	int ret;
 
 	switch (type) {
@@ -565,6 +639,22 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
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
@@ -612,6 +702,22 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
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
@@ -865,6 +971,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
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
@@ -973,6 +1090,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 					 ADXL345_DATA_FORMAT_FULL_RES |
 					 ADXL345_DATA_FORMAT_SELF_TEST);
 	unsigned int tap_threshold;
+	unsigned int ff_threshold;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
@@ -992,6 +1110,9 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	st->tap_window_us = 64;			/*   64 [0x40] -> .080    */
 	st->tap_latent_us = 16;			/*   16 [0x10] -> .020    */
 
+	ff_threshold = 8;			/*    8 [0x08]            */
+	st->ff_time_ms = 32;			/*   32 [0x20] -> 0.16    */
+
 	indio_dev->name = st->info->name;
 	indio_dev->info = &adxl345_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -1068,6 +1189,10 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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


