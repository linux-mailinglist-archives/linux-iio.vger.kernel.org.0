Return-Path: <linux-iio+bounces-17060-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 552E7A68086
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 00:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51EF919C271E
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 23:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A00F2144D4;
	Tue, 18 Mar 2025 23:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTMh/dnX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA858214217;
	Tue, 18 Mar 2025 23:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742339343; cv=none; b=fdSQ2NOka7QRkRN0PsDny5VQvVXSpskPQZWTQfnhsDunczUo77reS0qCd+E6x4/jsSFq9A/PNUqEPUOy0YAW4YxFFxbxVHS4Ll+0pth8VfKUM2939kAHMAGXUJg7RVbsBipI2itzMz/nqH+0BF+lvPMuF3t/01895k44qaLHCHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742339343; c=relaxed/simple;
	bh=gIx7mxQLDoUZcS9OQy9xSQ7npBFbtDddjzOZeHfc8Rg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AjAfRxUpmnEjq5JSgI/N53RQuV0218b65bSKUjc1SXwJVw5sTxNkBZBSUr6UMwFjcRxX5QybnsDgSRLFj1bWXl7BJEbJenBZSFldxRBcI6B9ZkCiBjpbQqKLGyyc2f4MzzEjzLIEfEIrxOuyM+Y66IElXTRku3afLgyIgpfCUFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTMh/dnX; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39123d2eb7fso810084f8f.1;
        Tue, 18 Mar 2025 16:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742339340; x=1742944140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Af8+S+Iqm4Cd36iKsf8R3DH0P2+TW/TcPm1Vexd8UEA=;
        b=aTMh/dnXVeWObvd0Bj+asjEL0D0QtQjJ1S8+qCV6rZh/6qoziL1+A+q2hJTcuNs9UT
         iJRD03cFRtYFNG+JEvIJV7nOWZoNup+uh/g/wN0gvOHKcj6Ja1rSCg6H9LdlJzg9f0tA
         CHFYVbvLfbh00qnOsDIxCP9TIAM30/vq2r9seF4rjXWeh5Dwt64mBJ7G0xU5YMC0eCot
         EqhOtfEpzpN7rH6oEW2+P1ylbnNp2CI5eu3LtpkQj9WtQscZIXjbrG7CuTc9Y3yLLkko
         QBPAnpzmjtzkgWcrcwnr/XVv9+u375m4RHHZSTF12VrLlVx+17w7Pe/ZQ2VayWSbIL2m
         +ZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742339340; x=1742944140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Af8+S+Iqm4Cd36iKsf8R3DH0P2+TW/TcPm1Vexd8UEA=;
        b=DwGgUpV6pdBa9YANX+0sybxzM/H5mkcReKh2j2/qCHug6oUHsDVPEfSMHWHa7XQz+h
         Div/sl77BovA8LAqA5zp19qXr1uhrHFIOtnJyZdhVAMp+FZVscoJAvbouXQMYsmnrr9N
         ohxYD6k7/m+hS/P1/24f5xd/BJe3rJ1X8HwpOn72oS5Ylnie1JxDbf4/ZXM3vGHC6jtc
         A2qzHNRG0mhcA6IcCPWfGzqUhB398FDJUcevrLlqkgX9/1cawkQNs6IrRV/TowU8c5kZ
         z4qRteGKwDTbPGTt7YH2NS5aBpHrXtjCkUXVL61p5AJzmu+zihmKKEgG1bdDjGpB2YOx
         +RUA==
X-Forwarded-Encrypted: i=1; AJvYcCV1atKGYbmob+uR/PCaTF917lIWwcCblwOYsZslGus7pZPNk36gHC5ryT6C+E0/xiClfjeDhymzsKXeoVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+0JlDMDyv4kH0PKhWP8+mK7loLlXVS5H18je2XouT0znqX1bX
	WivysUYe2N9QSN8UEJFGwQtXKTsn0IEzGQYJ9v8SZK9TKJfLUPt7
X-Gm-Gg: ASbGncvhxY+UrRT+L5rFPUpaXm/FqzA0N6a6feidUc5I+/8a1KJ1ef4faHC40Gsp8N0
	sMUft22WYh7JExig0y9a2UB9AVlnKPkPYtEKTD6fD7aB1AgTF2TZwqAnO2nIpsPo6wIG0j2xJcP
	2o6fpLzsyfEtndGhYSU3b6iThlPTag8sm4m3Crhdx6OTtBBMF6uwk2RxELHlsv2hC9votZepLLw
	nfwuLu4nJYHMJWJUi9RqVIExBHBFsdM6FTPyl4E/VuCuh7kJmXkg/HVWIiRJitTp6ERe8hq43Q4
	RiBQZM8dTvvfsYyCvd8rTn+3ZQeOQ5wrKkfHM9uSllRbJv8NL77aTdk07KbIy196Z4mWxyJh9bd
	fQRTAe9DPOk8cR7Owku347NI=
X-Google-Smtp-Source: AGHT+IEYb6yR9aCl/Sm1DJOhI88C2Vh5s5yKxEaGtUh0r3ndO3O3zfNq8wzgH6S0YUiG6Nr8kd0+YA==
X-Received: by 2002:a5d:5985:0:b0:38f:20b5:2c80 with SMTP id ffacd0b85a97d-399739f08camr153905f8f.6.1742339339842;
        Tue, 18 Mar 2025 16:08:59 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d440ed793sm1113455e9.39.2025.03.18.16.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:08:59 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v5 05/11] iio: accel: adxl345: add freefall feature
Date: Tue, 18 Mar 2025 23:08:37 +0000
Message-Id: <20250318230843.76068-6-l.rubusch@gmail.com>
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

Add the freefall detection of the sensor together with a threshold and
time parameter. A freefall event is detected if the measuring signal
falls below the threshold.

Introduce a freefall threshold stored in regmap cache, and a freefall
time, having the scaled time value stored as a member variable in the
state instance.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 126 +++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 52daf46c4acd..76ee657e958a 100644
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
@@ -376,6 +385,64 @@ static int adxl345_set_tap_latent(struct adxl345_state *st, u32 val_int,
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
@@ -488,6 +555,11 @@ static int adxl345_read_event_config(struct iio_dev *indio_dev,
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
@@ -511,6 +583,8 @@ static int adxl345_write_event_config(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_EV_TYPE_MAG:
+		return adxl345_set_ff_en(st, state);
 	default:
 		return -EINVAL;
 	}
@@ -525,6 +599,7 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
 	unsigned int tap_threshold;
+	unsigned int ff_threshold;
 	int ret;
 
 	switch (type) {
@@ -558,6 +633,22 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
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
@@ -605,6 +696,22 @@ static int adxl345_write_event_value(struct iio_dev *indio_dev,
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
@@ -858,6 +965,17 @@ static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
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
@@ -966,6 +1084,7 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 					 ADXL345_DATA_FORMAT_FULL_RES |
 					 ADXL345_DATA_FORMAT_SELF_TEST);
 	unsigned int tap_threshold;
+	unsigned int ff_threshold;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
@@ -985,6 +1104,9 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	st->tap_window_us = 64;			/*   64 [0x40] -> .080    */
 	st->tap_latent_us = 16;			/*   16 [0x10] -> .020    */
 
+	ff_threshold = 8;			/*    8 [0x08]            */
+	st->ff_time_ms = 32;			/*   32 [0x20] -> 0.16    */
+
 	indio_dev->name = st->info->name;
 	indio_dev->info = &adxl345_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -1061,6 +1183,10 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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


