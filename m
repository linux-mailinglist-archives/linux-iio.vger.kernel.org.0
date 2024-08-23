Return-Path: <linux-iio+bounces-8717-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F23C195D42E
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 19:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D0228481D
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 17:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9212718DF7E;
	Fri, 23 Aug 2024 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMI6hNvx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A084441C69;
	Fri, 23 Aug 2024 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724433625; cv=none; b=HwNcro9BfFz+Y3yJvyfb188hPfpV08ubvpcffkeu83upKj/ZAD5aoz1kWPVAAESVx4rahAxt4HxnsmDe6/CyRFXDxmrUxD67FAFZUunSp1qnMhwCgqjtmjooDUcPlJ+i8rxTknwwGyQ2+sDNO9pLmqJnPwxrU0dmO9l3sq38fPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724433625; c=relaxed/simple;
	bh=zC9XP9jhFc1Jlr8IUnL1Zzn1CgCy8BJcD/49auEUjwY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pCdJur5J6SKreKF0zku7gYNLbiz8arDgiNP7tP8BCluZA3YhE/2cRXl0Vh+g6QVCAzetmZX4StF9sCx3iV2CebMUSyoJJre3Z5SSfMHsTiIf9hYNhd7LyoKFBkX3e8U7GeDyZyE5Gzcul7M+XjocyyIY83AaHWzIe5NbmHasaU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMI6hNvx; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5bef295a429so2985153a12.2;
        Fri, 23 Aug 2024 10:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724433622; x=1725038422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hRzhfxsKN1wyrpesi2RVynxpZJ9HYlBWXcGgydjxSaE=;
        b=QMI6hNvx1uzJ+wVrWDVtQlrf+JC241ZSuPEpCcHRPcBkjt6jWR8Pns+H+4nSXNrFoR
         FQ/xo8cnS5Le+2F7wQKG9XD64UdP4QFEg823ip/sRMZ4mq1DyC3Zz7WUEPLPooclmXg7
         XhxISwtTMdhPmZnczUq/n3DE0M4K+CeEQoyGWzzykZYtUZSmucswHR/NUAwvTrFP8aN+
         MX9qc4nvm9mRpQVIGmBiJM7u59Vva6elI3pi9rWzBc6+Ce4//2Wax30UGd9T82Gtxh30
         PlldMGB2Fbo0kME7bDAf2WC7TDQiKBec+6cDdp94J9TJEQkpPRM3A1KP3av15bNSRVp0
         QESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724433622; x=1725038422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hRzhfxsKN1wyrpesi2RVynxpZJ9HYlBWXcGgydjxSaE=;
        b=V65nr33d1JP01SAL4Mjv51iYMFynQgNsxHegqHxf9+y3QYxrzTeJuxmdzuEvYGOr38
         TnUhqkx4I73b1tJsUYDrd54A+RSjrxDTohEXGRqHkSQOJxam9MwFgKNS1ACpwto41x45
         06+kZm+vqA4tcJpHSdn66fIXam9RdhEQ5xbxY+MJa5CWORrKJQR2fjl7LIH0sVvjNhvC
         Qbo5xBMMoP14CzpFPSopL8WbOkdmag9mZXOnQzLfEpGKET/m8md/SPArbYPHL278sln4
         syqStdA4STW7ii7KHbd2B5iW4zhUTLmj8Nxs/T1sqpyYIjaOh2jBaLGnM8Cahqm2KHAw
         5Esg==
X-Forwarded-Encrypted: i=1; AJvYcCXNn9fDK7oTsABKf0/QX2C80+FTSorOpzwySoKrhW5mgBFZ6H0chdSdhJ8RzeRu6qi/05OOwgwZSfv/OSkE@vger.kernel.org, AJvYcCXnxtzS6jjWQ0naXz4/abKcogyEjRXqtwMsm/aGLkPOX3WhTSBYMavFhcRFYIKZjEWD9DmG44UvNls=@vger.kernel.org
X-Gm-Message-State: AOJu0YymkUJ3NevtqaVISa899FhPIXpGe/M4YQ29bj5hCsLX2en52wwE
	j6ZCwg3MpQeVqJM7fIo+2jvLKjiTIIVDZq3uC/f11CP9gstY9wseJi3jRg==
X-Google-Smtp-Source: AGHT+IH2j0Xt1m5Wgj7d8MKsbmOhfbrtb59YnW/nukhaLMf+JWL0P8TgeE/xhQTWDcK/IQliP4K5Yg==
X-Received: by 2002:a05:6402:5187:b0:5a2:447b:2143 with SMTP id 4fb4d7f45d1cf-5c089165572mr2223083a12.10.1724433621065;
        Fri, 23 Aug 2024 10:20:21 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:f90d:5a72:8d56:a041])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c04a3eb2afsm2304012a12.58.2024.08.23.10.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 10:20:20 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org
Cc: dan.carpenter@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: iio: pressure: bmp280: Use char instead of s32 for data buffer
Date: Fri, 23 Aug 2024 19:20:17 +0200
Message-Id: <20240823172017.9028-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
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
 drivers/iio/pressure/bmp280-core.c | 43 +++++++++++++++++-------------
 drivers/iio/pressure/bmp280.h      |  5 +++-
 2 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 3deaa57bb3f5..71e481c2f30d 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1035,7 +1035,8 @@ static irqreturn_t bmp280_trigger_handler(int irq, void *p)
 		goto out;
 	}
 
-	data->sensor_data[1] = bmp280_compensate_temp(data, adc_temp);
+	ret = bmp280_compensate_temp(data, adc_temp);
+	memcpy(&data->buffer.buf[4], &ret, 4);
 
 	/* Pressure calculations */
 	adc_press = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(&data->buf[0]));
@@ -1045,10 +1046,10 @@ static irqreturn_t bmp280_trigger_handler(int irq, void *p)
 	}
 
 	t_fine = bmp280_calc_t_fine(data, adc_temp);
+	ret = bmp280_compensate_press(data, adc_press, t_fine);
+	memcpy(&data->buffer.buf[0], &ret, 4);
 
-	data->sensor_data[0] = bmp280_compensate_press(data, adc_press, t_fine);
-
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
 					   iio_get_time_ns(indio_dev));
 
 out:
@@ -1148,7 +1149,8 @@ static irqreturn_t bme280_trigger_handler(int irq, void *p)
 		goto out;
 	}
 
-	data->sensor_data[1] = bmp280_compensate_temp(data, adc_temp);
+	ret = bmp280_compensate_temp(data, adc_temp);
+	memcpy(&data->buffer.buf[4], &ret, 4);
 
 	/* Pressure calculations */
 	adc_press = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(&data->buf[0]));
@@ -1158,8 +1160,8 @@ static irqreturn_t bme280_trigger_handler(int irq, void *p)
 	}
 
 	t_fine = bmp280_calc_t_fine(data, adc_temp);
-
-	data->sensor_data[0] = bmp280_compensate_press(data, adc_press, t_fine);
+	ret = bmp280_compensate_press(data, adc_press, t_fine);
+	memcpy(&data->buffer.buf[0], &ret, 4);
 
 	/* Humidity calculations */
 	adc_humidity = get_unaligned_be16(&data->buf[6]);
@@ -1168,9 +1170,11 @@ static irqreturn_t bme280_trigger_handler(int irq, void *p)
 		dev_err(data->dev, "reading humidity skipped\n");
 		goto out;
 	}
-	data->sensor_data[2] = bme280_compensate_humidity(data, adc_humidity, t_fine);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
+	ret = bme280_compensate_humidity(data, adc_humidity, t_fine);
+	memcpy(&data->buffer.buf[8], &ret, 4);
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
 					   iio_get_time_ns(indio_dev));
 
 out:
@@ -1628,7 +1632,8 @@ static irqreturn_t bmp380_trigger_handler(int irq, void *p)
 		goto out;
 	}
 
-	data->sensor_data[1] = bmp380_compensate_temp(data, adc_temp);
+	ret = bmp380_compensate_temp(data, adc_temp);
+	memcpy(&data->buffer.buf[4], &ret, 4);
 
 	/* Pressure calculations */
 	adc_press = get_unaligned_le24(&data->buf[0]);
@@ -1638,10 +1643,10 @@ static irqreturn_t bmp380_trigger_handler(int irq, void *p)
 	}
 
 	t_fine = bmp380_calc_t_fine(data, adc_temp);
+	ret = bmp380_compensate_press(data, adc_press, t_fine);
+	memcpy(&data->buffer.buf[0], &ret, 4);
 
-	data->sensor_data[0] = bmp380_compensate_press(data, adc_press, t_fine);
-
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
 					   iio_get_time_ns(indio_dev));
 
 out:
@@ -2203,12 +2208,12 @@ static irqreturn_t bmp580_trigger_handler(int irq, void *p)
 	}
 
 	/* Temperature calculations */
-	memcpy(&data->sensor_data[1], &data->buf[0], 3);
+	memcpy(&data->buffer.buf[4], &data->buf[0], 3);
 
 	/* Pressure calculations */
-	memcpy(&data->sensor_data[0], &data->buf[3], 3);
+	memcpy(&data->buffer.buf[0], &data->buf[3], 3);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
 					   iio_get_time_ns(indio_dev));
 
 out:
@@ -2522,15 +2527,15 @@ static irqreturn_t bmp180_trigger_handler(int irq, void *p)
 	if (ret)
 		goto out;
 
-	data->sensor_data[1] = chan_value;
+	memcpy(&data->buffer.buf[4], &chan_value, 4);
 
 	ret = bmp180_read_press(data, &chan_value);
 	if (ret)
 		goto out;
 
-	data->sensor_data[0] = chan_value;
+	memcpy(&data->buffer.buf[0], &chan_value, 4);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
 					   iio_get_time_ns(indio_dev));
 
 out:
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index ccacc67c1473..a853b6d5bdfa 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -411,7 +411,10 @@ struct bmp280_data {
 	 * Data to push to userspace triggered buffer. Up to 3 channels and
 	 * s64 timestamp, aligned.
 	 */
-	s32 sensor_data[6] __aligned(8);
+	struct {
+		u8 buf[12];
+		s64 ts __aligned(8);
+	} buffer;
 
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
-- 
2.25.1


