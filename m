Return-Path: <linux-iio+bounces-18530-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F393AA97561
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 21:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16123BA568
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 19:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7662980A1;
	Tue, 22 Apr 2025 19:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KJ8S+i7j"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70911E0DDC
	for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 19:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745350128; cv=none; b=iJ+dpZ3QwdJx52aTodErpkyABIe9sBXMfhm37XiMFrCT75tl6c+QYfoD5TPtGbhMvX++cM5LzGQkhUTUZ4kF2LwGqNUg0W2sfNhBwGOQ9DUGUTfNwpXnBXtjpAYf9hBWxtKLKNU+Mx66TTX5O7LNu1DcdhDWYrtG6P4zHGwIsow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745350128; c=relaxed/simple;
	bh=Aoo24VDkLJ9Fvyx9uF18E+0I92xixFzfbVJacPGEagc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=M+mhxo0HL31yWbRRm6DeePKHnzV3F3+6QdlzVFXZLA58vxTDOE4tFc/CQjgxfaGs4sOy2xOVB2rdQjL8FTyd3br2VttjjhX6jFalhZQJlE/nNzohI8FbL8laSDsmGCJZMaj33UydF5Q0GAex50oO5OeiotsSsbAVhc/Kbd9wA2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KJ8S+i7j; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2c2dc6c30c2so1510443fac.2
        for <linux-iio@vger.kernel.org>; Tue, 22 Apr 2025 12:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745350124; x=1745954924; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iLi+B3MTVPFx0AsESTkz2z+6nVaBF7LP0N10jEwchIU=;
        b=KJ8S+i7jH9AQv76qTVOW0h7hIkYfGoTnE/+aPiyE45BmiDCbGNz1ANT8Q6Z9y1Mxzt
         P2ExpSWT4aClWnILEmD7yw+fpM7wj4BUbXuhPGREY2erAGlBRVVf826UkMm4+uUfZVH+
         q3q+oJnRVx5yw2MoBPvDWzWZ9/KNSd/BLG6HVYqZMsqozh78vTeJYuvg64Zn5ShfLqRG
         V/KNnH/4Q0XXVOXSfWzyS0rl+6wtf0WpuMUni5GO+JglujBmPsBSJ1BvcqMUfa0g8NdM
         ytg7QpA1W6kHBgAujaS+X7mF0f8xHqNk5WNQKIgVdzu22xxVEdRkcihtwN0V3yIeCK+0
         vquQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745350124; x=1745954924;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iLi+B3MTVPFx0AsESTkz2z+6nVaBF7LP0N10jEwchIU=;
        b=nC+rrs1nUNYxbCy9oDjypfw2fK/wPJA3MCV2qofYVWMJFKeHGOJ7FS+/g/1PD5SaSK
         b/9n5xAMYiQ+PseXnxu1gedy/wCTsPkwYqZ7vbiThEXSMKp/Rz87VbyMV/M4bQU/Ijw/
         GJgk+k71FzkbNLuWxMvxDdrH/nrMdWnFFC2Mygop8Lf+hJQJ5ZHgdLD07UftWC1apdMO
         VMj8eFnN2lBjKybads1xjJxTGgJHzhcus+7DlL5lPuVXaSOzQd7sBCoaffNs6/5sFhCv
         VLFUb9gVgWExaYchBPwTtiYkbC0iGLFipIDcWHGPjipMR9HGhnERXGNDiKi+AHB/Kv4Q
         V69g==
X-Gm-Message-State: AOJu0YyHFzT1coXMvX4ufPn6H1yvuaK/gdKA+hBYLyxPJdTSu2NYAfnW
	uugC7vHhxM6/Afha6SsfAJK7eBU9jK7g45QfOrdOVgNfkSpaKBLusCFij4dekiUmmBhnb0afodK
	zltc=
X-Gm-Gg: ASbGncuqd4/BAsvnRnYITdd8TPVAUU4GikZZAube8P53OdtfSjoOcLpREXjAw+oNdt+
	ydgO0Ewb3f1mFS7AmEGGJXp83FGKEhZtEw9qXDgDkZ6Nc5QBgupLmOjgiK8+FlTvbWyiNCL6CdA
	Sb5bxyS4/cnInJ7BZ/CBkc1YEG/HxRNTEP0fQxCdsdueSAl+hHg/EUGqz6FfdPxTHmOBTc06lDJ
	9iPISLosNNbwJSeIzjFpYsLrzMNGXa9tdwPgjyU9IeRCm54AA/7qzRsOdw8CNNbOnnirXkjK8/P
	9oGvFh6oJaowEw9O1ccKxE14WUUCReoZB5aRYmjbpExPwFA=
X-Google-Smtp-Source: AGHT+IEoiLlkG8CuDq3sxtWZySPM8V1hr1BrdzVkkZxxU8PgD1mHd8w2+yO6D2bCGRL6IKQMfgmgaA==
X-Received: by 2002:a05:6871:547:b0:2c7:6150:fff7 with SMTP id 586e51a60fabf-2d526e24d2bmr10859675fac.35.1745350123696;
        Tue, 22 Apr 2025 12:28:43 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:c8d1:e0ed:ce8b:96a3])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2d5212c95ebsm2732646fac.5.2025.04.22.12.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 12:28:43 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 22 Apr 2025 14:28:36 -0500
Subject: [PATCH] iio: pressure: bmp280: drop sensor_data array
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-iio-pressure-bmp280-rework-push-to-buffers-v1-1-ee722f29aeca@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAOPtB2gC/x2NwQrCQAwFf6XkbGCNSlt/RTy09q0NYndJXBVK/
 93F4xxmZiWHKZzOzUqGt7qmpcJ+19BtHpY7WKfKJEFO4SjCqomzwb0YeHxm6QIbPskenIvP/Eo
 8lhhhzqHtpiGg79sDqAarFvX7n12u2/YDK2ONbHwAAAA=
X-Change-ID: 20250422-iio-pressure-bmp280-rework-push-to-buffers-078da0e9973e
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9506; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Aoo24VDkLJ9Fvyx9uF18E+0I92xixFzfbVJacPGEagc=;
 b=owEBbAGT/pANAwAKAcLMIAH/AY/AAcsmYgBoB+3k4EQIfqFSijVG3Jw6BOowCU4UxQi0VZBOx
 KaQmDM+JQKJATIEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAft5AAKCRDCzCAB/wGP
 wLV+B/YtbUFMSdQ3hQHgJ/gpIqZ8vguOPfP1ibSygeA14fM0bbzq9k1f3IJ2kjxSz7lg9xR21hN
 OFl+a5WWATRi48yO/ob+jjXVK8KA4CepKct8yPYs9H3q2r32CEo1mNmjWPAVNX4VMtHKMANfLk0
 K69HcJSx6okaU0KefmEtjB1n/T/P0UXSg/pL69e3ddl4pXBvAeOZy01qZUBXHLA0ssRpUsWfIpA
 6cmpJiNqQ0PpoX8iziip5AujmfusJGlUMT6ADqvkfc/BGYhMJBJ9Gv/ksCxWJMSb7JGhKpqZe9g
 DrhaGQKSndqos463s+3YSVxKXkLFBntR1mSWYtAc7GL0DV8=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Drop the sensor_data array from struct bmp280_data and replace it using
local structs in each interrupt handler.

The sensor_data array in struct bmp280_data is not used to share data
between functions and isn't used for DMA, so there isn't really a need
to have it in the struct. Instead, we can use the struct pattern for
scan data in each interrupt handler. This has the advantage of allowing
us to see the actual layout of each scan buffer for each different type
of supported sensor. It also avoid juggling values between local
variables and the array which makes the code a bit simpler by avoiding
some extra assignments.

We can also drop the BME280_NUM_MAX_CHANNELS macro as it is no longer
used.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Link: https://lore.kernel.org/linux-iio/20250421135540.1a667221@jic23-huawei/
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
This is an alternative to [1] that takes a different approach to avoid
the messy one-size-fits-all buffer used with iio_push_to_buffers_with_ts().

[1]: https://lore.kernel.org/linux-iio/20250418-iio-introduce-iio_declare_buffer_with_ts-v1-4-ee0c62a33a0f@baylibre.com/
---
 drivers/iio/pressure/bmp280-core.c | 102 +++++++++++++++++++------------------
 drivers/iio/pressure/bmp280.h      |   8 ---
 2 files changed, 52 insertions(+), 58 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index c20cc4a98c9c494a9c8843518ba2f17b41be18a9..5728cc18cced223284a2c41dc6dec6f47169c797 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -46,6 +46,7 @@
 #include <linux/random.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/types.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
@@ -1105,9 +1106,13 @@ static irqreturn_t bmp280_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmp280_data *data = iio_priv(indio_dev);
-	u32 adc_temp, adc_press, comp_press;
-	s32 t_fine, comp_temp;
-	s32 *chans = (s32 *)data->sensor_data;
+	u32 adc_temp, adc_press;
+	s32 t_fine;
+	struct {
+		u32 comp_press;
+		s32 comp_temp;
+		aligned_s64 timestamp;
+	} buffer;
 	int ret;
 
 	guard(mutex)(&data->lock);
@@ -1127,7 +1132,7 @@ static irqreturn_t bmp280_trigger_handler(int irq, void *p)
 		goto out;
 	}
 
-	comp_temp = bmp280_compensate_temp(data, adc_temp);
+	buffer.comp_temp = bmp280_compensate_temp(data, adc_temp);
 
 	/* Pressure calculations */
 	adc_press = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(&data->buf[0]));
@@ -1137,13 +1142,9 @@ static irqreturn_t bmp280_trigger_handler(int irq, void *p)
 	}
 
 	t_fine = bmp280_calc_t_fine(data, adc_temp);
-	comp_press = bmp280_compensate_press(data, adc_press, t_fine);
-
-	chans[0] = comp_press;
-	chans[1] = comp_temp;
+	buffer.comp_press = bmp280_compensate_press(data, adc_press, t_fine);
 
-	iio_push_to_buffers_with_ts(indio_dev, data->sensor_data,
-				    sizeof(data->sensor_data),
+	iio_push_to_buffers_with_ts(indio_dev, &buffer, sizeof(buffer),
 				    iio_get_time_ns(indio_dev));
 
 out:
@@ -1226,9 +1227,14 @@ static irqreturn_t bme280_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmp280_data *data = iio_priv(indio_dev);
-	u32 adc_temp, adc_press, adc_humidity, comp_press, comp_humidity;
-	s32 t_fine, comp_temp;
-	s32 *chans = (s32 *)data->sensor_data;
+	u32 adc_temp, adc_press, adc_humidity;
+	s32 t_fine;
+	struct {
+		u32 comp_press;
+		s32 comp_temp;
+		u32 comp_humidity;
+		aligned_s64 timestamp;
+	} buffer;
 	int ret;
 
 	guard(mutex)(&data->lock);
@@ -1248,7 +1254,7 @@ static irqreturn_t bme280_trigger_handler(int irq, void *p)
 		goto out;
 	}
 
-	comp_temp = bmp280_compensate_temp(data, adc_temp);
+	buffer.comp_temp = bmp280_compensate_temp(data, adc_temp);
 
 	/* Pressure calculations */
 	adc_press = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(&data->buf[0]));
@@ -1258,7 +1264,7 @@ static irqreturn_t bme280_trigger_handler(int irq, void *p)
 	}
 
 	t_fine = bmp280_calc_t_fine(data, adc_temp);
-	comp_press = bmp280_compensate_press(data, adc_press, t_fine);
+	buffer.comp_press = bmp280_compensate_press(data, adc_press, t_fine);
 
 	/* Humidity calculations */
 	adc_humidity = get_unaligned_be16(&data->buf[6]);
@@ -1268,14 +1274,10 @@ static irqreturn_t bme280_trigger_handler(int irq, void *p)
 		goto out;
 	}
 
-	comp_humidity = bme280_compensate_humidity(data, adc_humidity, t_fine);
+	buffer.comp_humidity = bme280_compensate_humidity(data, adc_humidity,
+							  t_fine);
 
-	chans[0] = comp_press;
-	chans[1] = comp_temp;
-	chans[2] = comp_humidity;
-
-	iio_push_to_buffers_with_ts(indio_dev, data->sensor_data,
-				    sizeof(data->sensor_data),
+	iio_push_to_buffers_with_ts(indio_dev, &buffer, sizeof(buffer),
 				    iio_get_time_ns(indio_dev));
 
 out:
@@ -1901,9 +1903,13 @@ static irqreturn_t bmp380_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmp280_data *data = iio_priv(indio_dev);
-	u32 adc_temp, adc_press, comp_press;
-	s32 t_fine, comp_temp;
-	s32 *chans = (s32 *)data->sensor_data;
+	u32 adc_temp, adc_press;
+	s32 t_fine;
+	struct {
+		u32 comp_press;
+		s32 comp_temp;
+		aligned_s64 timestamp;
+	} buffer;
 	int ret;
 
 	guard(mutex)(&data->lock);
@@ -1923,7 +1929,7 @@ static irqreturn_t bmp380_trigger_handler(int irq, void *p)
 		goto out;
 	}
 
-	comp_temp = bmp380_compensate_temp(data, adc_temp);
+	buffer.comp_temp = bmp380_compensate_temp(data, adc_temp);
 
 	/* Pressure calculations */
 	adc_press = get_unaligned_le24(&data->buf[0]);
@@ -1933,13 +1939,9 @@ static irqreturn_t bmp380_trigger_handler(int irq, void *p)
 	}
 
 	t_fine = bmp380_calc_t_fine(data, adc_temp);
-	comp_press = bmp380_compensate_press(data, adc_press, t_fine);
-
-	chans[0] = comp_press;
-	chans[1] = comp_temp;
+	buffer.comp_press = bmp380_compensate_press(data, adc_press, t_fine);
 
-	iio_push_to_buffers_with_ts(indio_dev, data->sensor_data,
-				    sizeof(data->sensor_data),
+	iio_push_to_buffers_with_ts(indio_dev, &buffer, sizeof(buffer),
 				    iio_get_time_ns(indio_dev));
 
 out:
@@ -2611,7 +2613,12 @@ static irqreturn_t bmp580_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmp280_data *data = iio_priv(indio_dev);
-	int ret, offset;
+	struct {
+		__le32 comp_temp;
+		__le32 comp_press;
+		aligned_s64 timestamp;
+	} buffer;
+	int ret;
 
 	guard(mutex)(&data->lock);
 
@@ -2623,18 +2630,13 @@ static irqreturn_t bmp580_trigger_handler(int irq, void *p)
 		goto out;
 	}
 
-	offset = 0;
-
 	/* Pressure calculations */
-	memcpy(&data->sensor_data[offset], &data->buf[3], 3);
-
-	offset += sizeof(s32);
+	memcpy(&buffer.comp_press, &data->buf[3], 3);
 
 	/* Temperature calculations */
-	memcpy(&data->sensor_data[offset], &data->buf[0], 3);
+	memcpy(&buffer.comp_temp, &data->buf[0], 3);
 
-	iio_push_to_buffers_with_ts(indio_dev, data->sensor_data,
-				    sizeof(data->sensor_data),
+	iio_push_to_buffers_with_ts(indio_dev, &buffer, sizeof(buffer),
 				    iio_get_time_ns(indio_dev));
 
 out:
@@ -2956,25 +2958,25 @@ static irqreturn_t bmp180_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmp280_data *data = iio_priv(indio_dev);
-	int ret, comp_temp, comp_press;
-	s32 *chans = (s32 *)data->sensor_data;
+	struct {
+		u32 comp_press;
+		s32 comp_temp;
+		aligned_s64 timestamp;
+	} buffer;
+	int ret;
 
 	guard(mutex)(&data->lock);
 
-	ret = bmp180_read_temp(data, &comp_temp);
+	ret = bmp180_read_temp(data, &buffer.comp_temp);
 	if (ret)
 		goto out;
 
 
-	ret = bmp180_read_press(data, &comp_press);
+	ret = bmp180_read_press(data, &buffer.comp_press);
 	if (ret)
 		goto out;
 
-	chans[0] = comp_press;
-	chans[1] = comp_temp;
-
-	iio_push_to_buffers_with_ts(indio_dev, data->sensor_data,
-				    sizeof(data->sensor_data),
+	iio_push_to_buffers_with_ts(indio_dev, &buffer, sizeof(buffer),
 				    iio_get_time_ns(indio_dev));
 
 out:
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 5b2ee1d0ee464797d1d9993a014d8f84c37d5596..25bb9c743a05a19c5d2396969f0f4e0fef6ddcd0 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -349,7 +349,6 @@
 					 BMP280_NUM_TEMP_BYTES + \
 					 BME280_NUM_HUMIDITY_BYTES)
 
-#define BME280_NUM_MAX_CHANNELS		3
 /* Core exported structs */
 
 static const char *const bmp280_supply_names[] = {
@@ -452,13 +451,6 @@ struct bmp280_data {
 	 */
 	int sampling_freq;
 
-	/*
-	 * Data to push to userspace triggered buffer. Up to 3 channels and
-	 * s64 timestamp, aligned.
-	 */
-	u8 sensor_data[ALIGN(sizeof(s32) * BME280_NUM_MAX_CHANNELS, sizeof(s64))
-		       + sizeof(s64)] __aligned(sizeof(s64));
-
 	/* Value to hold the current operation mode of the device */
 	enum bmp280_op_mode op_mode;
 

---
base-commit: b475195fecc79a1a6e7fb0846aaaab0a1a4cb2e6
change-id: 20250422-iio-pressure-bmp280-rework-push-to-buffers-078da0e9973e

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


