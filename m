Return-Path: <linux-iio+bounces-9945-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7D098AE32
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 22:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4AB1F22F86
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 20:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EDC1A0B1D;
	Mon, 30 Sep 2024 20:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5o9eUDW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2350A1A2541;
	Mon, 30 Sep 2024 20:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727727850; cv=none; b=amP2N6T0xBN44s0Z9wQ31NRe10cXJyn8+1+/a3X4DVNJtLCJQQGV8PX2qYBHVFO0kMirzpPPLKkhYhwHssjFIqCwf/cPLgUrZdb5lHxMsRcCg9RD3X8TZ+Lks5y+PY97liJZpVeT4VQN3l0VJaHpVmklfzYmttAIl/dXq8/HqGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727727850; c=relaxed/simple;
	bh=RmxdUFHsaBXNARBCNZrRTzRIQzLkbNfV3Q0LYAtokpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J1oiE75sTMZW20v1yHVCmt0ZjFMXAzDKd2taNZOVCflOOggwtBhlyWh3SibReBTlEHqeuIPFeM61SQ0PhSmA8ybhtuKk8or8KFR0xqb3siDyor8lM5eG18aBPKkkVEpKj+PFB0PbtYfLXQjEYPYZf2jYsfPc7tqCKoVbBRLV+3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5o9eUDW; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37cc4e718ecso3218004f8f.0;
        Mon, 30 Sep 2024 13:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727727846; x=1728332646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0sgKCiAcApFBFQ0JAwvmnGBkpAWLyGLAUEGVVDFn48=;
        b=M5o9eUDWEtCoiFWdA9Cwh2TTlXb0rj/BLjVySaBkE30iomBog48N+HWUq9yH7mADcY
         lETSinQLnJfe5p0wkFLDO95fd3qh7F/Ei6Np+4QbwEBPJH5Uetdw+FCPdPqaDOREVogC
         Fyr52iEHkIg+X7LU9wqMgz5llSYiWk9yFCl2+Dw4T5DoF3GKxsj5lHit+jDfmxlgeZQq
         G/PzUzm0hIY1B+pQBwA7fh8vkJE5/pn0F5ebLr/rWSbGNWJHj3ocsuf+Rb23ie4n0KwC
         QHv9hE6bOsrNH3/dj+JTSyuwG7gO0VhHfHp1vRYTzEkEKnFMHYmEaFC86s5R10EqlzRm
         nDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727727846; x=1728332646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0sgKCiAcApFBFQ0JAwvmnGBkpAWLyGLAUEGVVDFn48=;
        b=NnuD27H4opWGToQ0iwpAINJdVbg1SL7hbZVgiYPdv7ozJoXGWnuyaer/5uo8bGmSoz
         OvtusDU3pMVbssZ5zgVpHEMgv7fO8v5fLLYwb9g5KPJjZxhXzIcjnZcXR/EUoxflWiF4
         AhuoKKVsKLvXCHfCAuPCnPdRoDQh7Ie9PzeADgxl0E+YpFULOTozV99umGefVk2aDUlM
         bZ9NcSh3Zd7FZwwU70GJ7CI/fD3qS1kVnyVjdkzZlS/XWBnKTaves48CXlJ4kNMP2vqE
         dApMzxTMTvG4R+k11h7KOLbIx7bl+YobydkixoK+EqMNrY0s5PHBLWaRERMmTvMO8Rw7
         qwXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4uC9ZuoSNnXLvILYPWQSnZ2dHh7pyzAyia65mluvldB+SIXPBYiSq8ovJhG0Yyx4Ia503gyhbNL7jwsXZ@vger.kernel.org, AJvYcCVnoJGODSJua3eGfOwIhG5ikoCtbrB+aTsZUDfqSdRo07GEsS0ern1xENRiWVyrz8vYPlpGHNtiG9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxLyMVM65ygRWVuWbaJRroSMYURMi8Q47cgx0B/TfdQwJf5NwK
	LwHUUItQ648PFLFKSRlYbtv/T4cZrwaTJ4e5RoiV7jdookdBIpf3iaOYpE8e
X-Google-Smtp-Source: AGHT+IFM/qKitDakAcvI3c2AKDR4xLVteAVdc+UtkF55o0TEuemuZqhAhPluXUZSwbbGfmniXeV/Ag==
X-Received: by 2002:a5d:5145:0:b0:37c:ccc1:17d2 with SMTP id ffacd0b85a97d-37cd5a9d0b6mr7138250f8f.34.1727727846103;
        Mon, 30 Sep 2024 13:24:06 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:89eb:9ac0:8a4a:319b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e65e4sm10064052f8f.61.2024.09.30.13.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 13:24:05 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dan.carpenter@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v3 2/2] iio: pressure: bmp280: Use char instead of s32 for data buffer
Date: Mon, 30 Sep 2024 22:23:53 +0200
Message-Id: <20240930202353.38203-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240930202353.38203-1-vassilisamir@gmail.com>
References: <20240930202353.38203-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As it was reported and discussed here [1], storing the sensor data in an
endian aware s32 buffer is not optimal. Advertising the timestamp as an
addition of 2 s32 variables which is also implied is again not the best
practice. For that reason, change the s32 sensor_data buffer to a u8
buffer and align it properly.

[1]: https://lore.kernel.org/linux-iio/73d13cc0-afb9-4306-b498-5d821728c3ba@stanley.mountain/

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 72 ++++++++++++++++++------------
 drivers/iio/pressure/bmp280.h      |  4 +-
 2 files changed, 46 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 472a6696303b..6811619c6f11 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1023,8 +1023,9 @@ static irqreturn_t bmp280_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmp280_data *data = iio_priv(indio_dev);
-	u32 adc_temp, adc_press;
-	s32 t_fine;
+	u32 adc_temp, adc_press, comp_press;
+	s32 t_fine, comp_temp;
+	s32 *chans = (s32 *)data->sensor_data;
 	int ret;
 
 	guard(mutex)(&data->lock);
@@ -1044,7 +1045,7 @@ static irqreturn_t bmp280_trigger_handler(int irq, void *p)
 		goto out;
 	}
 
-	data->sensor_data[1] = bmp280_compensate_temp(data, adc_temp);
+	comp_temp = bmp280_compensate_temp(data, adc_temp);
 
 	/* Pressure calculations */
 	adc_press = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(&data->buf[0]));
@@ -1054,10 +1055,12 @@ static irqreturn_t bmp280_trigger_handler(int irq, void *p)
 	}
 
 	t_fine = bmp280_calc_t_fine(data, adc_temp);
+	comp_press = bmp280_compensate_press(data, adc_press, t_fine);
 
-	data->sensor_data[0] = bmp280_compensate_press(data, adc_press, t_fine);
+	chans[0] = comp_press;
+	chans[1] = comp_temp;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
+	iio_push_to_buffers_with_timestamp(indio_dev, data->sensor_data,
 					   iio_get_time_ns(indio_dev));
 
 out:
@@ -1138,8 +1141,9 @@ static irqreturn_t bme280_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmp280_data *data = iio_priv(indio_dev);
-	u32 adc_temp, adc_press, adc_humidity;
-	s32 t_fine;
+	u32 adc_temp, adc_press, adc_humidity, comp_press, comp_humidity;
+	s32 t_fine, comp_temp;
+	s32 *chans = (s32 *)data->sensor_data;
 	int ret;
 
 	guard(mutex)(&data->lock);
@@ -1159,7 +1163,7 @@ static irqreturn_t bme280_trigger_handler(int irq, void *p)
 		goto out;
 	}
 
-	data->sensor_data[1] = bmp280_compensate_temp(data, adc_temp);
+	comp_temp = bmp280_compensate_temp(data, adc_temp);
 
 	/* Pressure calculations */
 	adc_press = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(&data->buf[0]));
@@ -1169,8 +1173,7 @@ static irqreturn_t bme280_trigger_handler(int irq, void *p)
 	}
 
 	t_fine = bmp280_calc_t_fine(data, adc_temp);
-
-	data->sensor_data[0] = bmp280_compensate_press(data, adc_press, t_fine);
+	comp_press = bmp280_compensate_press(data, adc_press, t_fine);
 
 	/* Humidity calculations */
 	adc_humidity = get_unaligned_be16(&data->buf[6]);
@@ -1179,9 +1182,14 @@ static irqreturn_t bme280_trigger_handler(int irq, void *p)
 		dev_err(data->dev, "reading humidity skipped\n");
 		goto out;
 	}
-	data->sensor_data[2] = bme280_compensate_humidity(data, adc_humidity, t_fine);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
+	comp_humidity = bme280_compensate_humidity(data, adc_humidity, t_fine);
+
+	chans[0] = comp_press;
+	chans[1] = comp_temp;
+	chans[2] = comp_humidity;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, data->sensor_data,
 					   iio_get_time_ns(indio_dev));
 
 out:
@@ -1618,8 +1626,9 @@ static irqreturn_t bmp380_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmp280_data *data = iio_priv(indio_dev);
-	u32 adc_temp, adc_press;
-	s32 t_fine;
+	u32 adc_temp, adc_press, comp_press;
+	s32 t_fine, comp_temp;
+	s32 *chans = (s32 *)data->sensor_data;
 	int ret;
 
 	guard(mutex)(&data->lock);
@@ -1639,7 +1648,7 @@ static irqreturn_t bmp380_trigger_handler(int irq, void *p)
 		goto out;
 	}
 
-	data->sensor_data[1] = bmp380_compensate_temp(data, adc_temp);
+	comp_temp = bmp380_compensate_temp(data, adc_temp);
 
 	/* Pressure calculations */
 	adc_press = get_unaligned_le24(&data->buf[0]);
@@ -1649,10 +1658,12 @@ static irqreturn_t bmp380_trigger_handler(int irq, void *p)
 	}
 
 	t_fine = bmp380_calc_t_fine(data, adc_temp);
+	comp_press = bmp380_compensate_press(data, adc_press, t_fine);
 
-	data->sensor_data[0] = bmp380_compensate_press(data, adc_press, t_fine);
+	chans[0] = comp_press;
+	chans[1] = comp_temp;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
+	iio_push_to_buffers_with_timestamp(indio_dev, data->sensor_data,
 					   iio_get_time_ns(indio_dev));
 
 out:
@@ -2199,7 +2210,7 @@ static irqreturn_t bmp580_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmp280_data *data = iio_priv(indio_dev);
-	int ret;
+	int ret, offset;
 
 	guard(mutex)(&data->lock);
 
@@ -2211,13 +2222,15 @@ static irqreturn_t bmp580_trigger_handler(int irq, void *p)
 		goto out;
 	}
 
-	/* Temperature calculations */
-	memcpy(&data->sensor_data[1], &data->buf[0], 3);
-
 	/* Pressure calculations */
-	memcpy(&data->sensor_data[0], &data->buf[3], 3);
+	memcpy(&data->sensor_data[offset], &data->buf[3], 3);
+
+	offset += sizeof(s32);
+
+	/* Temperature calculations */
+	memcpy(&data->sensor_data[offset], &data->buf[0], 3);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
+	iio_push_to_buffers_with_timestamp(indio_dev, data->sensor_data,
 					   iio_get_time_ns(indio_dev));
 
 out:
@@ -2523,23 +2536,24 @@ static irqreturn_t bmp180_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmp280_data *data = iio_priv(indio_dev);
-	int ret, chan_value;
+	int ret, comp_temp, comp_press;
+	s32 *chans = (s32 *)data->sensor_data;
 
 	guard(mutex)(&data->lock);
 
-	ret = bmp180_read_temp(data, &chan_value);
+	ret = bmp180_read_temp(data, &comp_temp);
 	if (ret)
 		goto out;
 
-	data->sensor_data[1] = chan_value;
 
-	ret = bmp180_read_press(data, &chan_value);
+	ret = bmp180_read_press(data, &comp_press);
 	if (ret)
 		goto out;
 
-	data->sensor_data[0] = chan_value;
+	chans[0] = comp_press;
+	chans[1] = comp_temp;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
+	iio_push_to_buffers_with_timestamp(indio_dev, data->sensor_data,
 					   iio_get_time_ns(indio_dev));
 
 out:
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index a9f220c1f77a..dc1bf04cb0b5 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -322,6 +322,7 @@
 					 BMP280_NUM_TEMP_BYTES + \
 					 BME280_NUM_HUMIDITY_BYTES)
 
+#define BME280_NUM_MAX_CHANNELS		3
 /* Core exported structs */
 
 static const char *const bmp280_supply_names[] = {
@@ -419,7 +420,8 @@ struct bmp280_data {
 	 * Data to push to userspace triggered buffer. Up to 3 channels and
 	 * s64 timestamp, aligned.
 	 */
-	s32 sensor_data[6] __aligned(8);
+	u8 sensor_data[ALIGN(sizeof(s32) * BME280_NUM_MAX_CHANNELS, sizeof(s64))
+		       + sizeof(s64)] __aligned(sizeof(s64));
 
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
-- 
2.25.1


