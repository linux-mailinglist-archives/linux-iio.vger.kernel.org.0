Return-Path: <linux-iio+bounces-6446-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C45290BF7B
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 01:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 380B11C21562
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 23:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4460719AA6A;
	Mon, 17 Jun 2024 23:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRmvevCp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D50A199EA9;
	Mon, 17 Jun 2024 23:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718665552; cv=none; b=YhLXPRNsqO6Nx0a/FDvAog/I5kItwr0Nzlul9Uw7ru6DKrI5MM4QEJQAlSQB6U9hmdWVKl8cMI4OJhdN2t3ux9oRYdeEbC/xkvnAXXL+sTx4pPWiXkIGQimv9PXIDDHvqnaOre9EGOmvMmaEYyiZ87jSlpeihXc9aHY3uJxOHEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718665552; c=relaxed/simple;
	bh=a17a6y1pDF9uo9l932aKEJ2LUSgTP8hY+VNbd1/XqnI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DTE7XGA07jJGv4SxJOp04k5Uc29E/sLVP16zTf+elsjW6yQdNyRR570jo9nXjlvkdBC80I7BUbO6wlWQ8BDLM7ELjne9K4lC1t/xzhI0FZnENJqdjmYifq1T15lQExQse70R+QF72s8TMW+Bidjt8thmKvpLDgA3VGfs74BJ95E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRmvevCp; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-57a30dbdb7fso8559801a12.3;
        Mon, 17 Jun 2024 16:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718665548; x=1719270348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYzpkSnNarCc/h5qzglAYKHhoOccjtVg+bauZ5VSUdc=;
        b=DRmvevCpW1M/WI9Sfxe0mfClrsCJEN3YW01CpeVqaQSXAMq5Qxec++JMp++b5Vi89g
         69Hgtp1w9OacexOqFTnvteSwzQJZ1n/oO362s4Urh7qQSTy7aK0/4oyTpLKjUXGy8fkM
         VPmxa3GFZI83+FXHCOZonnX79wAQ6HhX34l5SkF4/mtN6f7YRjoPCLhi2bHhMt1fLx7O
         G+kE7AcYuEaQQoinSYNEl/MyCih2ARLlCZ2evRbKJT+PnwZnbKHO6qbrLFBP0mq5IsA5
         adEC3sPOHgzKMXKlzsILrcRlsIvjQQlUEJmfNcoY1mN15jwPCzkD+Geuj9p83MeSJTD6
         XFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718665548; x=1719270348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYzpkSnNarCc/h5qzglAYKHhoOccjtVg+bauZ5VSUdc=;
        b=Kgc1851YZrK2D/Go59j1kzm4f8mYDSRkMlENR0DV07WRKlriyu0EZGUkL1QaGg2kgD
         LMj9zmAbTgb6EP4aHpu12pnpyVDs4CDtSQLIAK5DiUfymqhZCcS/BE6DaWBnY7S+r8Od
         SyVzSW+d/xua7q5NMGHmOSRFsrPq+um+DJv0uQ/ZeaV1aJymsm7eH+xeDYQrxAYUZa/w
         4vRvOjPykGqkdjGF4SX2B85RDRSOVOCIfbjCbNFh8o5PLinLE61BuZn8aS68Z3Ues0l1
         LQ4qM9u0hGyc08RWnujgbWShk4x9/xi9Rts3hz/enItwgrut8/De/9Q7ocj1gjv0gCza
         C3rA==
X-Forwarded-Encrypted: i=1; AJvYcCU80Xuyz2BWc1O2pM1qNm2JiRCPYlYNGoDRxMxLkjHH7K9fCwS5HU/47St7zNRX/1ynwrsnzMv6Dwgmx+cqn0ajN8xPcXfi+5buU2LYQdyK1Tp+0el/tmi4QmIBJNCIs7J4oCYol257
X-Gm-Message-State: AOJu0Yx0YXQotko+QxvMN5MlMKrM7DL5f3qT1123CfhvAOh9Z2cC3BRu
	GknohYIs6DwuxDySp/mRBlk22dDNiyxuhXGvzKj6UMqjqSN9kTOA
X-Google-Smtp-Source: AGHT+IGyv6m8rB+SE6FYYRQ8SEc4iYxJyAeIrthGAAR8q4omk8c5l6C7W4Bp7g6Caw6IKnQjlFyhIA==
X-Received: by 2002:a50:d792:0:b0:57c:70a6:baf with SMTP id 4fb4d7f45d1cf-57cbd6a581cmr6407686a12.40.1718665547917;
        Mon, 17 Jun 2024 16:05:47 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:b152:a6ad:d6c8:f0e8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72cdff1sm7085559a12.3.2024.06.17.16.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 16:05:47 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: andriy.shevchenko@linux.intel.com,
	ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com,
	ak@it-klinger.de,
	petre.rodan@subdimension.ro,
	phil@raspberrypi.com,
	579lpy@gmail.com,
	linus.walleij@linaro.org,
	semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v8 3/3] iio: pressure: bmp280: Add triggered buffer support
Date: Tue, 18 Jun 2024 01:05:40 +0200
Message-Id: <20240617230540.32325-4-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240617230540.32325-1-vassilisamir@gmail.com>
References: <20240617230540.32325-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BMP2xx, BME280, BMP3xx, and BMP5xx use continuous buffers for their
temperature, pressure and humidity readings. This facilitates the
use of burst/bulk reads in order to acquire data faster. The
approach is different from the one used in oneshot captures.

BMP085 & BMP1xx devices use a completely different measurement
process that is well defined and is used in their buffer_handler().

Suggested-by: Angel Iglesias <ang.iglesiasg@gmail.com>
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Link: https://lore.kernel.org/r/20240512230524.53990-6-vassilisamir@gmail.com
---
 drivers/iio/pressure/Kconfig       |   2 +
 drivers/iio/pressure/bmp280-core.c | 366 ++++++++++++++++++++++++++++-
 drivers/iio/pressure/bmp280-spi.c  |   8 +-
 drivers/iio/pressure/bmp280.h      |  21 +-
 4 files changed, 379 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index 3ad38506028e..0b5406a3f85d 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -31,6 +31,8 @@ config BMP280
 	select REGMAP
 	select BMP280_I2C if (I2C)
 	select BMP280_SPI if (SPI_MASTER)
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Bosch Sensortec BMP180, BMP280, BMP380
 	  and BMP580 pressure and temperature sensors. Also supports the BME280 with
diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 5f64d9951f37..05320a2e990e 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -41,7 +41,10 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #include <asm/unaligned.h>
 
@@ -134,6 +137,12 @@ enum {
 	BMP380_P11 = 20,
 };
 
+enum bmp280_scan {
+	BMP280_PRESS,
+	BMP280_TEMP,
+	BME280_HUMID,
+};
+
 static const struct iio_chan_spec bmp280_channels[] = {
 	{
 		.type = IIO_PRESSURE,
@@ -142,6 +151,13 @@ static const struct iio_chan_spec bmp280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
 	},
 	{
 		.type = IIO_TEMP,
@@ -150,7 +166,15 @@ static const struct iio_chan_spec bmp280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
 static const struct iio_chan_spec bme280_channels[] = {
@@ -161,6 +185,13 @@ static const struct iio_chan_spec bme280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
 	},
 	{
 		.type = IIO_TEMP,
@@ -169,6 +200,13 @@ static const struct iio_chan_spec bme280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
 	},
 	{
 		.type = IIO_HUMIDITYRELATIVE,
@@ -177,7 +215,15 @@ static const struct iio_chan_spec bme280_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.scan_index = 2,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
 static const struct iio_chan_spec bmp380_channels[] = {
@@ -190,6 +236,13 @@ static const struct iio_chan_spec bmp380_channels[] = {
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
 	},
 	{
 		.type = IIO_TEMP,
@@ -200,7 +253,15 @@ static const struct iio_chan_spec bmp380_channels[] = {
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
 static int bmp280_read_calib(struct bmp280_data *data)
@@ -316,7 +377,7 @@ static int bme280_read_humid_adc(struct bmp280_data *data, u16 *adc_humidity)
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, BME280_REG_HUMIDITY_MSB,
-			       &data->be16, sizeof(data->be16));
+			       &data->be16, BME280_NUM_HUMIDITY_BYTES);
 	if (ret) {
 		dev_err(data->dev, "failed to read humidity\n");
 		return ret;
@@ -362,7 +423,7 @@ static int bmp280_read_temp_adc(struct bmp280_data *data, u32 *adc_temp)
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
-			       data->buf, sizeof(data->buf));
+			       data->buf, BMP280_NUM_TEMP_BYTES);
 	if (ret) {
 		dev_err(data->dev, "failed to read temperature\n");
 		return ret;
@@ -423,7 +484,7 @@ static int bmp280_read_press_adc(struct bmp280_data *data, u32 *adc_press)
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
-			       data->buf, sizeof(data->buf));
+			       data->buf, BMP280_NUM_PRESS_BYTES);
 	if (ret) {
 		dev_err(data->dev, "failed to read pressure\n");
 		return ret;
@@ -558,7 +619,7 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 			if (ret)
 				return ret;
 
-			*val = data->chip_info->temp_coeffs[0] * (s64)chan_value;
+			*val = data->chip_info->temp_coeffs[0] * chan_value;
 			*val2 = data->chip_info->temp_coeffs[1];
 			return data->chip_info->temp_coeffs_type;
 		default:
@@ -874,6 +935,16 @@ static const struct iio_info bmp280_info = {
 	.write_raw = &bmp280_write_raw,
 };
 
+static const unsigned long bmp280_avail_scan_masks[] = {
+	BIT(BMP280_TEMP) | BIT(BMP280_PRESS),
+	0
+};
+
+static const unsigned long bme280_avail_scan_masks[] = {
+	BIT(BME280_HUMID) | BIT(BMP280_TEMP) | BIT(BMP280_PRESS),
+	0
+};
+
 static int bmp280_chip_config(struct bmp280_data *data)
 {
 	u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
@@ -901,6 +972,53 @@ static int bmp280_chip_config(struct bmp280_data *data)
 	return ret;
 }
 
+static irqreturn_t bmp280_buffer_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct bmp280_data *data = iio_priv(indio_dev);
+	s32 adc_temp, adc_press, t_fine;
+	int ret;
+
+	guard(mutex)(&data->lock);
+
+	/* Burst read data registers */
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
+			       data->buf, BMP280_BURST_READ_BYTES);
+	if (ret) {
+		dev_err(data->dev, "failed to burst read sensor data\n");
+		goto out;
+	}
+
+	/* Temperature calculations */
+	adc_temp = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(&data->buf[3]));
+	if (adc_temp == BMP280_TEMP_SKIPPED) {
+		dev_err(data->dev, "reading temperature skipped\n");
+		goto out;
+	}
+
+	data->sensor_data[1] = bmp280_compensate_temp(data, adc_temp);
+
+	/* Pressure calculations */
+	adc_press = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(&data->buf[0]));
+	if (adc_press == BMP280_PRESS_SKIPPED) {
+		dev_err(data->dev, "reading pressure skipped\n");
+		goto out;
+	}
+
+	t_fine = bmp280_calc_t_fine(data, adc_temp);
+
+	data->sensor_data[0] = bmp280_compensate_press(data, adc_press, t_fine);
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
+					   iio_get_time_ns(indio_dev));
+
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
 static const u8 bmp280_chip_ids[] = { BMP280_CHIP_ID };
 static const int bmp280_temp_coeffs[] = { 10, 1 };
@@ -914,6 +1032,7 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.start_up_time = 2000,
 	.channels = bmp280_channels,
 	.num_channels = ARRAY_SIZE(bmp280_channels),
+	.avail_scan_masks = bmp280_avail_scan_masks,
 
 	.oversampling_temp_avail = bmp280_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp280_oversampling_avail),
@@ -942,6 +1061,8 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
 	.read_calib = bmp280_read_calib,
+
+	.buffer_handler = bmp280_buffer_handler,
 };
 EXPORT_SYMBOL_NS(bmp280_chip_info, IIO_BMP280);
 
@@ -964,6 +1085,62 @@ static int bme280_chip_config(struct bmp280_data *data)
 	return bmp280_chip_config(data);
 }
 
+static irqreturn_t bme280_buffer_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct bmp280_data *data = iio_priv(indio_dev);
+	s32 adc_temp, adc_press, adc_humidity, t_fine;
+	int ret;
+
+	guard(mutex)(&data->lock);
+
+	/* Burst read data registers */
+	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
+			       data->buf, BME280_BURST_READ_BYTES);
+	if (ret) {
+		dev_err(data->dev, "failed to burst read sensor data\n");
+		goto out;
+	}
+
+	/* Temperature calculations */
+	adc_temp = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(&data->buf[3]));
+	if (adc_temp == BMP280_TEMP_SKIPPED) {
+		dev_err(data->dev, "reading temperature skipped\n");
+		goto out;
+	}
+
+	data->sensor_data[1] = bmp280_compensate_temp(data, adc_temp);
+
+	/* Pressure calculations */
+	adc_press = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(&data->buf[0]));
+	if (adc_press == BMP280_PRESS_SKIPPED) {
+		dev_err(data->dev, "reading pressure skipped\n");
+		goto out;
+	}
+
+	t_fine = bmp280_calc_t_fine(data, adc_temp);
+
+	data->sensor_data[0] = bmp280_compensate_press(data, adc_press, t_fine);
+
+	/* Humidity calculations */
+	adc_humidity = get_unaligned_be16(&data->buf[6]);
+
+	if (adc_humidity == BMP280_HUMIDITY_SKIPPED) {
+		dev_err(data->dev, "reading humidity skipped\n");
+		goto out;
+	}
+	data->sensor_data[2] = bme280_compensate_humidity(data, adc_humidity, t_fine);
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
+					   iio_get_time_ns(indio_dev));
+
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static const u8 bme280_chip_ids[] = { BME280_CHIP_ID };
 static const int bme280_humid_coeffs[] = { 1000, 1024 };
 
@@ -975,6 +1152,7 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.start_up_time = 2000,
 	.channels = bme280_channels,
 	.num_channels = ARRAY_SIZE(bme280_channels),
+	.avail_scan_masks = bme280_avail_scan_masks,
 
 	.oversampling_temp_avail = bmp280_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp280_oversampling_avail),
@@ -1000,6 +1178,8 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.read_press = bmp280_read_press,
 	.read_humid = bme280_read_humid,
 	.read_calib = bme280_read_calib,
+
+	.buffer_handler = bme280_buffer_handler,
 };
 EXPORT_SYMBOL_NS(bme280_chip_info, IIO_BMP280);
 
@@ -1054,7 +1234,7 @@ static int bmp380_read_temp_adc(struct bmp280_data *data, u32 *adc_temp)
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP380_REG_TEMP_XLSB,
-			       data->buf, sizeof(data->buf));
+			       data->buf, BMP280_NUM_TEMP_BYTES);
 	if (ret) {
 		dev_err(data->dev, "failed to read temperature\n");
 		return ret;
@@ -1123,7 +1303,7 @@ static int bmp380_read_press_adc(struct bmp280_data *data, u32 *adc_press)
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP380_REG_PRESS_XLSB,
-			       data->buf, sizeof(data->buf));
+			       data->buf, BMP280_NUM_PRESS_BYTES);
 	if (ret) {
 		dev_err(data->dev, "failed to read pressure\n");
 		return ret;
@@ -1384,6 +1564,53 @@ static int bmp380_chip_config(struct bmp280_data *data)
 	return 0;
 }
 
+static irqreturn_t bmp380_buffer_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct bmp280_data *data = iio_priv(indio_dev);
+	s32 adc_temp, adc_press, t_fine;
+	int ret;
+
+	guard(mutex)(&data->lock);
+
+	/* Burst read data registers */
+	ret = regmap_bulk_read(data->regmap, BMP380_REG_PRESS_XLSB,
+			       data->buf, BMP280_BURST_READ_BYTES);
+	if (ret) {
+		dev_err(data->dev, "failed to burst read sensor data\n");
+		goto out;
+	}
+
+	/* Temperature calculations */
+	adc_temp = get_unaligned_le24(&data->buf[3]);
+	if (adc_temp == BMP380_TEMP_SKIPPED) {
+		dev_err(data->dev, "reading temperature skipped\n");
+		goto out;
+	}
+
+	data->sensor_data[1] = bmp380_compensate_temp(data, adc_temp);
+
+	/* Pressure calculations */
+	adc_press = get_unaligned_le24(&data->buf[0]);
+	if (adc_press == BMP380_PRESS_SKIPPED) {
+		dev_err(data->dev, "reading pressure skipped\n");
+		goto out;
+	}
+
+	t_fine = bmp380_calc_t_fine(data, adc_temp);
+
+	data->sensor_data[0] = bmp380_compensate_press(data, adc_press, t_fine);
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
+					   iio_get_time_ns(indio_dev));
+
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static const int bmp380_oversampling_avail[] = { 1, 2, 4, 8, 16, 32 };
 static const int bmp380_iir_filter_coeffs_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128};
 static const u8 bmp380_chip_ids[] = { BMP380_CHIP_ID, BMP390_CHIP_ID };
@@ -1399,6 +1626,7 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.start_up_time = 2000,
 	.channels = bmp380_channels,
 	.num_channels = ARRAY_SIZE(bmp380_channels),
+	.avail_scan_masks = bmp280_avail_scan_masks,
 
 	.oversampling_temp_avail = bmp380_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp380_oversampling_avail),
@@ -1426,6 +1654,8 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.read_press = bmp380_read_press,
 	.read_calib = bmp380_read_calib,
 	.preinit = bmp380_preinit,
+
+	.buffer_handler = bmp380_buffer_handler,
 };
 EXPORT_SYMBOL_NS(bmp380_chip_info, IIO_BMP280);
 
@@ -1546,8 +1776,8 @@ static int bmp580_read_temp(struct bmp280_data *data, s32 *raw_temp)
 	s32 value_temp;
 	int ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB, data->buf,
-			       sizeof(data->buf));
+	ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB,
+			       data->buf, BMP280_NUM_TEMP_BYTES);
 	if (ret) {
 		dev_err(data->dev, "failed to read temperature\n");
 		return ret;
@@ -1568,8 +1798,8 @@ static int bmp580_read_press(struct bmp280_data *data, u32 *raw_press)
 	u32 value_press;
 	int ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP580_REG_PRESS_XLSB, data->buf,
-			       sizeof(data->buf));
+	ret = regmap_bulk_read(data->regmap, BMP580_REG_PRESS_XLSB,
+			       data->buf, BMP280_NUM_PRESS_BYTES);
 	if (ret) {
 		dev_err(data->dev, "failed to read pressure\n");
 		return ret;
@@ -1916,6 +2146,51 @@ static int bmp580_chip_config(struct bmp280_data *data)
 	return 0;
 }
 
+static irqreturn_t bmp580_buffer_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct bmp280_data *data = iio_priv(indio_dev);
+	s32 adc_temp, adc_press;
+	int ret;
+
+	guard(mutex)(&data->lock);
+
+	/* Burst read data registers */
+	ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB,
+			       data->buf, BMP280_BURST_READ_BYTES);
+	if (ret) {
+		dev_err(data->dev, "failed to burst read sensor data\n");
+		goto out;
+	}
+
+	/* Temperature calculations */
+	adc_temp = get_unaligned_le24(&data->buf[0]);
+	if (adc_temp == BMP580_TEMP_SKIPPED) {
+		dev_err(data->dev, "reading temperature skipped\n");
+		goto out;
+	}
+
+	data->sensor_data[1] = sign_extend32(adc_temp, 23);
+
+	/* Pressure calculations */
+	adc_press = get_unaligned_le24(&data->buf[3]);
+	if (adc_press == BMP380_PRESS_SKIPPED) {
+		dev_err(data->dev, "reading pressure skipped\n");
+		goto out;
+	}
+
+	data->sensor_data[0] = adc_press;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
+					   iio_get_time_ns(indio_dev));
+
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static const int bmp580_oversampling_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
 static const u8 bmp580_chip_ids[] = { BMP580_CHIP_ID, BMP580_CHIP_ID_ALT };
 static const int bmp580_temp_coeffs[] = { 1000, 16 };
@@ -1929,6 +2204,7 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.start_up_time = 2000,
 	.channels = bmp380_channels,
 	.num_channels = ARRAY_SIZE(bmp380_channels),
+	.avail_scan_masks = bmp280_avail_scan_masks,
 
 	.oversampling_temp_avail = bmp580_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp580_oversampling_avail),
@@ -1955,6 +2231,8 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.read_temp = bmp580_read_temp,
 	.read_press = bmp580_read_press,
 	.preinit = bmp580_preinit,
+
+	.buffer_handler = bmp580_buffer_handler,
 };
 EXPORT_SYMBOL_NS(bmp580_chip_info, IIO_BMP280);
 
@@ -2133,7 +2411,7 @@ static int bmp180_read_press_adc(struct bmp280_data *data, u32 *adc_press)
 		return ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB,
-			       data->buf, sizeof(data->buf));
+			       data->buf, BMP280_NUM_PRESS_BYTES);
 	if (ret) {
 		dev_err(data->dev, "failed to read pressure\n");
 		return ret;
@@ -2204,6 +2482,36 @@ static int bmp180_chip_config(struct bmp280_data *data)
 	return 0;
 }
 
+static irqreturn_t bmp180_buffer_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct bmp280_data *data = iio_priv(indio_dev);
+	int ret, chan_value;
+
+	guard(mutex)(&data->lock);
+
+	ret = bmp180_read_temp(data, &chan_value);
+	if (ret)
+		goto out;
+
+	data->sensor_data[1] = chan_value;
+
+	ret = bmp180_read_press(data, &chan_value);
+	if (ret)
+		goto out;
+
+	data->sensor_data[0] = chan_value;
+
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->sensor_data,
+					   iio_get_time_ns(indio_dev));
+
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static const int bmp180_oversampling_temp_avail[] = { 1 };
 static const int bmp180_oversampling_press_avail[] = { 1, 2, 4, 8 };
 static const u8 bmp180_chip_ids[] = { BMP180_CHIP_ID };
@@ -2218,6 +2526,7 @@ const struct bmp280_chip_info bmp180_chip_info = {
 	.start_up_time = 2000,
 	.channels = bmp280_channels,
 	.num_channels = ARRAY_SIZE(bmp280_channels),
+	.avail_scan_masks = bmp280_avail_scan_masks,
 
 	.oversampling_temp_avail = bmp180_oversampling_temp_avail,
 	.num_oversampling_temp_avail =
@@ -2238,6 +2547,8 @@ const struct bmp280_chip_info bmp180_chip_info = {
 	.read_temp = bmp180_read_temp,
 	.read_press = bmp180_read_press,
 	.read_calib = bmp180_read_calib,
+
+	.buffer_handler = bmp180_buffer_handler,
 };
 EXPORT_SYMBOL_NS(bmp180_chip_info, IIO_BMP280);
 
@@ -2283,6 +2594,30 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
 	return 0;
 }
 
+static int bmp280_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct bmp280_data *data = iio_priv(indio_dev);
+
+	pm_runtime_get_sync(data->dev);
+
+	return 0;
+}
+
+static int bmp280_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct bmp280_data *data = iio_priv(indio_dev);
+
+	pm_runtime_mark_last_busy(data->dev);
+	pm_runtime_put_autosuspend(data->dev);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops bmp280_buffer_setup_ops = {
+	.preenable = bmp280_buffer_preenable,
+	.postdisable = bmp280_buffer_postdisable,
+};
+
 static void bmp280_pm_disable(void *data)
 {
 	struct device *dev = data;
@@ -2329,6 +2664,7 @@ int bmp280_common_probe(struct device *dev,
 	/* Apply initial values from chip info structure */
 	indio_dev->channels = chip_info->channels;
 	indio_dev->num_channels = chip_info->num_channels;
+	indio_dev->available_scan_masks = chip_info->avail_scan_masks;
 	data->oversampling_press = chip_info->oversampling_press_default;
 	data->oversampling_humid = chip_info->oversampling_humid_default;
 	data->oversampling_temp = chip_info->oversampling_temp_default;
@@ -2414,6 +2750,14 @@ int bmp280_common_probe(struct device *dev,
 					     "failed to read calibration coefficients\n");
 	}
 
+	ret = devm_iio_triggered_buffer_setup(data->dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      data->chip_info->buffer_handler,
+					      &bmp280_buffer_setup_ops);
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "iio triggered buffer setup failed\n");
+
 	/*
 	 * Attempt to grab an optional EOC IRQ - only the BMP085 has this
 	 * however as it happens, the BMP085 shares the chip ID of BMP180
diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index 62b4e58104cf..e5abee15950e 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -40,14 +40,10 @@ static int bmp380_regmap_spi_read(void *context, const void *reg,
 				  size_t reg_size, void *val, size_t val_size)
 {
 	struct spi_device *spi = to_spi_device(context);
-	u8 rx_buf[4];
+	u8 rx_buf[BME280_BURST_READ_BYTES + 1];
 	ssize_t status;
 
-	/*
-	 * Maximum number of consecutive bytes read for a temperature or
-	 * pressure measurement is 3.
-	 */
-	if (val_size > 3)
+	if (val_size > BME280_BURST_READ_BYTES)
 		return -EINVAL;
 
 	/*
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index a3d2cd722760..756c644354c2 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -304,6 +304,16 @@
 #define BMP280_PRESS_SKIPPED		0x80000
 #define BMP280_HUMIDITY_SKIPPED		0x8000
 
+/* Number of bytes for each value */
+#define BMP280_NUM_PRESS_BYTES		3
+#define BMP280_NUM_TEMP_BYTES		3
+#define BME280_NUM_HUMIDITY_BYTES	2
+#define BMP280_BURST_READ_BYTES		(BMP280_NUM_PRESS_BYTES + \
+					 BMP280_NUM_TEMP_BYTES)
+#define BME280_BURST_READ_BYTES		(BMP280_NUM_PRESS_BYTES + \
+					 BMP280_NUM_TEMP_BYTES + \
+					 BME280_NUM_HUMIDITY_BYTES)
+
 /* Core exported structs */
 
 static const char *const bmp280_supply_names[] = {
@@ -397,13 +407,19 @@ struct bmp280_data {
 	 */
 	int sampling_freq;
 
+	/*
+	 * Data to push to userspace triggered buffer. Up to 3 channels and
+	 * s64 timestamp, aligned.
+	 */
+	s32 sensor_data[6] __aligned(8);
+
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
 	 */
 	union {
 		/* Sensor data buffer */
-		u8 buf[3];
+		u8 buf[BME280_BURST_READ_BYTES];
 		/* Calibration data buffers */
 		__le16 bmp280_cal_buf[BMP280_CONTIGUOUS_CALIB_REGS / 2];
 		__be16 bmp180_cal_buf[BMP180_REG_CALIB_COUNT / 2];
@@ -425,6 +441,7 @@ struct bmp280_chip_info {
 	const struct iio_chan_spec *channels;
 	int num_channels;
 	unsigned int start_up_time;
+	const unsigned long *avail_scan_masks;
 
 	const int *oversampling_temp_avail;
 	int num_oversampling_temp_avail;
@@ -459,6 +476,8 @@ struct bmp280_chip_info {
 	int (*read_humid)(struct bmp280_data *data, u32 *adc_humidity);
 	int (*read_calib)(struct bmp280_data *data);
 	int (*preinit)(struct bmp280_data *data);
+
+	irqreturn_t (*buffer_handler)(int irq, void *p);
 };
 
 /* Chip infos for each variant */
-- 
2.25.1


