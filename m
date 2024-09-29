Return-Path: <linux-iio+bounces-9870-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B6B989513
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 13:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3FFE1F218A9
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 11:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAB2178CCA;
	Sun, 29 Sep 2024 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jb9i1rlB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4B2175D32;
	Sun, 29 Sep 2024 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727609124; cv=none; b=akePM1ha7vAhb6xQn7SDJBjzgWipLrihKQYWHSxy5F/yLVR8cMunyp/OkodT15LSjSfqidmNQs1eWMEeAskkJZGgurM1m4glHBPxhO6N9YVhRnxGivwKzpaUoY/S/v8xs6CD9v3+t66Q/YpECyBo94Tnzqx9IU5p5oIc+TLs2Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727609124; c=relaxed/simple;
	bh=X7fORzgExfQA0C69v6mdx3BvSNCqFSI75V/IXIa61q4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tuo7qsr1Hf5y8DqxOQKASOvMCbfWcu4wulNsggaXVmkO9a41oizbeS1KnEYnXS1f0Vc0VSDsetHC499LhB2UrxR082zPXTTcqwJHLRJP61IJQQk+8o6tv1vzvcuN+iS85dFZmv724x3MoL9KSHnHsOi6BVTT+ei4yz2ThB7QP8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jb9i1rlB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cbe624c59so27891085e9.3;
        Sun, 29 Sep 2024 04:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727609121; x=1728213921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dyzHFaozNPNRfwrQWOh+rrvCgTOHdjJlFF8sSYQJj8g=;
        b=jb9i1rlBHNZxMKTqwA6RZ1aN642VunS7W40ZCe1v+8qw7ekEThrDJXEIUyVR/VbVks
         yhlnyrACPJtdnwP2YdFvd0rlBbgReJK/bScvIGjXqjFw1uFeWJU3TbO9IboenXcdQUCn
         nuELQ/HVIgcM3jf/xqAc7IBNP69pLU4kRWYNA3bFrUzdQzW4DbfNWMZjSDbx1amsq7Xs
         JVzNd3dud9ib0hYLUM/lu8yvEvcKwPDSNVmy3vVALRQJg4FHmXjaMXVFO6Tmg4rgSKKI
         XfnKs7zDJmPaVNLW95qgIEHVMMnO/j7rmuptN/FYifIoUavr8dIuDmIA6o8xLAOOvWko
         Pn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727609121; x=1728213921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyzHFaozNPNRfwrQWOh+rrvCgTOHdjJlFF8sSYQJj8g=;
        b=aS1t4TthvNdt7i1n0CTNSqagBHz5/JUxvECN6Vo03qBrbemClx/8eaXwgrMvZ4GPug
         pTedmNGvrzeG/uZ78b69pDpvKSvSUq0xtpo5TiqmYm/S/AFCuTRWUh8taMcT4AenoHhf
         n1fFCp+pMV8Suw6RTbcKPgTqSGDUqa5mPzD8wcXUjeUEV7GhT/xPGhVOMLhHkkYuXUKm
         jmE5Ew4PcIKaOEd5CiqeyjeAsYSymgMLG/v1U7J4EolPZoBMj3gmpIDrdDWwUAjXuyba
         Twh3Ipr81IydtAja3S0rGWm/oi0Q1vnRflzik3UCXBlaVk+D4GWuP9r7yr3MQ3V19bHA
         atrw==
X-Forwarded-Encrypted: i=1; AJvYcCUhRVJO1IjEcHQlA8aCqO1QCYIO+NpSvzkUoZaCI9D/1+zMtV+wFT+ZL8izmUJSJy0a2xWHCv9VDXS/ZtRu@vger.kernel.org, AJvYcCUmtb69ma1FLAh+XKtQnXtwVaPeJiy+nZRHk7esg91HQN18AzDjGOT2LKjW4UG+iCNqMrVoj1hL29M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBRn/wc8QIaUQT/NbgjtPve6qnf3m3XFQ9IIitqCyTD5ulehNQ
	eeb6WmH6B0nvMyw7o4E70LvbwW4TQ0TRQA4ByJdnjiXf0LGFqv/iDZKN1+Pn
X-Google-Smtp-Source: AGHT+IEDQCu4uBTkegCrLYqMLI0mYo1OyKgpWYgmrRPbWa/wTPJLtH6LGCaMFbitQU3amAhRaaxskg==
X-Received: by 2002:a05:600c:3b93:b0:426:689b:65b7 with SMTP id 5b1f17b1804b1-42f58485cc1mr63667835e9.25.1727609120938;
        Sun, 29 Sep 2024 04:25:20 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:df60:d786:cd5:d3c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57de1192sm74717325e9.14.2024.09.29.04.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 04:25:19 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dan.carpenter@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v2 2/2] iio: pressure: bmp280: Use char instead of s32 for data buffer
Date: Sun, 29 Sep 2024 13:25:11 +0200
Message-Id: <20240929112511.100292-3-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240929112511.100292-1-vassilisamir@gmail.com>
References: <20240929112511.100292-1-vassilisamir@gmail.com>
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
practice. For that reason, change the s32 sensor_data buffer to a char
buffer with an extra value for the timestamp (as it is common practice).

[1]: https://lore.kernel.org/linux-iio/73d13cc0-afb9-4306-b498-5d821728c3ba@stanley.mountain/

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 78 ++++++++++++++++++------------
 drivers/iio/pressure/bmp280.h      |  5 +-
 2 files changed, 51 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 472a6696303b..2c62490a40c6 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1023,9 +1023,9 @@ static irqreturn_t bmp280_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmp280_data *data = iio_priv(indio_dev);
-	u32 adc_temp, adc_press;
-	s32 t_fine;
-	int ret;
+	u32 adc_temp, adc_press, comp_press;
+	s32 t_fine, comp_temp;
+	int ret, offset;
 
 	guard(mutex)(&data->lock);
 
@@ -1044,7 +1044,7 @@ static irqreturn_t bmp280_trigger_handler(int irq, void *p)
 		goto out;
 	}
 
-	data->sensor_data[1] = bmp280_compensate_temp(data, adc_temp);
+	comp_temp = bmp280_compensate_temp(data, adc_temp);
 
 	/* Pressure calculations */
 	adc_press = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(&data->buf[0]));
@@ -1054,10 +1054,13 @@ static irqreturn_t bmp280_trigger_handler(int irq, void *p)
 	}
 
 	t_fine = bmp280_calc_t_fine(data, adc_temp);
+	comp_press = bmp280_compensate_press(data, adc_press, t_fine);
 
-	data->sensor_data[0] = bmp280_compensate_press(data, adc_press, t_fine);
+	memcpy(&data->buffer.buf[offset], &comp_press, sizeof(s32));
+	offset += sizeof(s32);
+	memcpy(&data->buffer.buf[offset], &comp_temp, sizeof(s32));
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
 					   iio_get_time_ns(indio_dev));
 
 out:
@@ -1138,9 +1141,9 @@ static irqreturn_t bme280_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmp280_data *data = iio_priv(indio_dev);
-	u32 adc_temp, adc_press, adc_humidity;
-	s32 t_fine;
-	int ret;
+	u32 adc_temp, adc_press, adc_humidity, comp_press, comp_humidity;
+	s32 t_fine, comp_temp;
+	int ret, offset;
 
 	guard(mutex)(&data->lock);
 
@@ -1159,7 +1162,7 @@ static irqreturn_t bme280_trigger_handler(int irq, void *p)
 		goto out;
 	}
 
-	data->sensor_data[1] = bmp280_compensate_temp(data, adc_temp);
+	comp_temp = bmp280_compensate_temp(data, adc_temp);
 
 	/* Pressure calculations */
 	adc_press = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(&data->buf[0]));
@@ -1169,8 +1172,7 @@ static irqreturn_t bme280_trigger_handler(int irq, void *p)
 	}
 
 	t_fine = bmp280_calc_t_fine(data, adc_temp);
-
-	data->sensor_data[0] = bmp280_compensate_press(data, adc_press, t_fine);
+	comp_press = bmp280_compensate_press(data, adc_press, t_fine);
 
 	/* Humidity calculations */
 	adc_humidity = get_unaligned_be16(&data->buf[6]);
@@ -1179,9 +1181,16 @@ static irqreturn_t bme280_trigger_handler(int irq, void *p)
 		dev_err(data->dev, "reading humidity skipped\n");
 		goto out;
 	}
-	data->sensor_data[2] = bme280_compensate_humidity(data, adc_humidity, t_fine);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
+	comp_humidity = bme280_compensate_humidity(data, adc_humidity, t_fine);
+
+	memcpy(&data->buffer.buf[offset], &comp_press, sizeof(s32));
+	offset += sizeof(s32);
+	memcpy(&data->buffer.buf[offset], &comp_temp, sizeof(s32));
+	offset += sizeof(s32);
+	memcpy(&data->buffer.buf[offset], &comp_humidity, sizeof(s32));
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
 					   iio_get_time_ns(indio_dev));
 
 out:
@@ -1618,9 +1627,9 @@ static irqreturn_t bmp380_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmp280_data *data = iio_priv(indio_dev);
-	u32 adc_temp, adc_press;
-	s32 t_fine;
-	int ret;
+	u32 adc_temp, adc_press, comp_press;
+	s32 t_fine, comp_temp;
+	int ret, offset;
 
 	guard(mutex)(&data->lock);
 
@@ -1639,7 +1648,7 @@ static irqreturn_t bmp380_trigger_handler(int irq, void *p)
 		goto out;
 	}
 
-	data->sensor_data[1] = bmp380_compensate_temp(data, adc_temp);
+	comp_temp = bmp380_compensate_temp(data, adc_temp);
 
 	/* Pressure calculations */
 	adc_press = get_unaligned_le24(&data->buf[0]);
@@ -1649,10 +1658,13 @@ static irqreturn_t bmp380_trigger_handler(int irq, void *p)
 	}
 
 	t_fine = bmp380_calc_t_fine(data, adc_temp);
+	comp_press = bmp380_compensate_press(data, adc_press, t_fine);
 
-	data->sensor_data[0] = bmp380_compensate_press(data, adc_press, t_fine);
+	memcpy(&data->buffer.buf[offset], &comp_press, sizeof(s32));
+	offset += sizeof(s32);
+	memcpy(&data->buffer.buf[offset], &comp_temp, sizeof(s32));
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
 					   iio_get_time_ns(indio_dev));
 
 out:
@@ -2199,7 +2211,7 @@ static irqreturn_t bmp580_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmp280_data *data = iio_priv(indio_dev);
-	int ret;
+	int ret, offset;
 
 	guard(mutex)(&data->lock);
 
@@ -2211,13 +2223,16 @@ static irqreturn_t bmp580_trigger_handler(int irq, void *p)
 		goto out;
 	}
 
+	/* Pressure calculations */
+	memcpy(&data->buffer.buf[offset], &data->buf[3], 3);
+
+	offset += sizeof(s32);
+
 	/* Temperature calculations */
-	memcpy(&data->sensor_data[1], &data->buf[0], 3);
+	memcpy(&data->buffer.buf[offset], &data->buf[0], 3);
 
-	/* Pressure calculations */
-	memcpy(&data->sensor_data[0], &data->buf[3], 3);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
 					   iio_get_time_ns(indio_dev));
 
 out:
@@ -2523,23 +2538,24 @@ static irqreturn_t bmp180_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmp280_data *data = iio_priv(indio_dev);
-	int ret, chan_value;
+	int ret, comp_temp, comp_press, offset;
 
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
+	memcpy(&data->buffer.buf[offset], &comp_press, sizeof(s32));
+	offset += sizeof(s32);
+	memcpy(&data->buffer.buf[offset], &comp_temp, sizeof(s32));
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
 					   iio_get_time_ns(indio_dev));
 
 out:
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index a9f220c1f77a..b0c26f55c6af 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -419,7 +419,10 @@ struct bmp280_data {
 	 * Data to push to userspace triggered buffer. Up to 3 channels and
 	 * s64 timestamp, aligned.
 	 */
-	s32 sensor_data[6] __aligned(8);
+	struct {
+		u8 buf[12];
+		aligned_s64 ts;
+	} buffer;
 
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
-- 
2.25.1


