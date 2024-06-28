Return-Path: <linux-iio+bounces-7023-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC04691C4A1
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 19:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A320A281A17
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 17:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBFE1CD5DA;
	Fri, 28 Jun 2024 17:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcst1dDr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8891CD5B4;
	Fri, 28 Jun 2024 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719595059; cv=none; b=U/VejssK3RG0FwqdvCj7uAzXSz1SAM70Hmhq68NCoFNtBM9OGqUJneTWhke3zoQHyeW/1gjlAnAQx8ojcc3xN+5iFlPvGa2ONhdBBas1xja5WEXm+KuICaDABUDTySKmHjURb8b8T7OVptXkwmoYGGWSCuLaQfL0OkU3yKvF+m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719595059; c=relaxed/simple;
	bh=5M62QRswIlSBVpZrfBtLvJOL6A8JCbWrrZzsexhmRkk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BXMAKHstz9dgom2203dlIM4rnDnBUn+h95uvneukPlSs1Y1edHG5uDZ6IWcbJNkbAZYwlW1ixb5U4e6H/Mq6O2CLjlLq92wrLKsqDvtdkDtnZijV/b1JLzdiR/d8CWrKAVghw60ypaUGChBIpiygzSGbJx92yTrQJlt3h0CBtPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcst1dDr; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57d1d45ba34so1181642a12.3;
        Fri, 28 Jun 2024 10:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719595055; x=1720199855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cCehQV069yytdARyhci2o7huRq7sZhNwoS1TjuOptIQ=;
        b=bcst1dDrnyp//WastySy1kppihXHYVrg1QVqKWqAzKi2+/p+DtnZH7KWmaNCss2JhP
         dl+Gt7Rjj2sF4JrnWd6zlQz97NknYkzOJD3D5bTOSFu68jzfqV40afzTO0bscBo1cBDf
         zVefRtlSmH9qFS8GtWtF1foz+jL4j7QpJHKQxyw/HmXaBK+KTbXTzceKeDkjOqsaqcQi
         F60TXyEegnKCZwsJgLbRT3Bu7JKRrvPePvOzWlnLk5oHH/fedWLAygmZENiCpoulzinq
         Gjf9wZAcFjqA68fwOoMR5z1jQi8o+BG7PDXJ8Q7nX85fybSmDQUKwCwmwuXp8ldY9Oi+
         7cNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719595055; x=1720199855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cCehQV069yytdARyhci2o7huRq7sZhNwoS1TjuOptIQ=;
        b=jh0T5GYsXoXqXarA5DpaE+uXzk85jlhUB6T/d0sOHT9noJHPsLYPDxefU8zogSb5+U
         ekg5YkqxkEBq/UI5lGIuVi3rmFrxUCoe2ythfbBUwalfQfHbCaNDu83ubQtkyvhduTUL
         +wIla4iIARGEcLHFhVDiGB85aA3RLOinlpva7KJPX5z61UsDjDNt+iZGKgZEnE2AmD4M
         aKMABrx83GxBDSKYfAHs/aGBdYeXqc+zllmhVhgl5rHuCYSkF1QfslauPKtDFBCWJF/i
         ETELoF3SNOLfpMj+suiLCjSyPaFOnGlXMY8mg4+kg5ReN94usn2sQmG99SDoPjwjPotp
         ZTbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoR3njZRdWz9AxQK5xGDVHTPNNDofI/D9hA8bCO4kJIR9vsve1CekhqnaH8aMjgbL/OP3dP/9IJFKGtdVpjcEjuuwde4KcB9I74dbx4dc13/MGzxIzTFHIg8EtxTq354ns4ADBF3Lu
X-Gm-Message-State: AOJu0Yz8I0XnoVwdkeH+ius0jLmVn2+3Aiuecs2XP2b6OlE9PXkIAH8m
	A7evDAoGv8IAWm2bPbzxpWZARW+FAY4FyeaEtFA6avIw4EYpAdK+
X-Google-Smtp-Source: AGHT+IEyiBHANSxnM8M6Ms+efcn6Q7cLR15tirTjQ6OhkHx2rqxZshdBQkMOGJ1E4WsYjI9a6HmBsg==
X-Received: by 2002:a50:9f87:0:b0:57c:a4d5:4d04 with SMTP id 4fb4d7f45d1cf-57d4bd71030mr10847451a12.17.1719595054896;
        Fri, 28 Jun 2024 10:17:34 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:b996:e85b:4fbf:5c89])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58612c838casm1271039a12.4.2024.06.28.10.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 10:17:34 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: petre.rodan@subdimension.ro,
	mazziesaccount@gmail.com,
	ak@it-klinger.de,
	vassilisamir@gmail.com,
	ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org,
	tgamblin@baylibre.com,
	ajarizzo@gmail.com,
	phil@raspberrypi.com,
	579lpy@gmail.com,
	andriy.shevchenko@linux.intel.com,
	semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 3/3] iio: pressure: bmp280: Add triggered buffer support
Date: Fri, 28 Jun 2024 19:17:26 +0200
Message-Id: <20240628171726.124852-4-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240628171726.124852-1-vassilisamir@gmail.com>
References: <20240628171726.124852-1-vassilisamir@gmail.com>
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
 drivers/iio/pressure/bmp280-core.c | 393 ++++++++++++++++++++++++++++-
 drivers/iio/pressure/bmp280-spi.c  |   8 +-
 drivers/iio/pressure/bmp280.h      |  21 +-
 4 files changed, 405 insertions(+), 19 deletions(-)

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
index f709ad8a54e1..2fc5724196e3 100644
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
@@ -190,6 +236,51 @@ static const struct iio_chan_spec bmp380_channels[] = {
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
+	},
+	{
+		.type = IIO_TEMP,
+		/* PROCESSED maintained for ABI backwards compatibility */
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
+	},
+	IIO_CHAN_SOFT_TIMESTAMP(2),
+};
+
+static const struct iio_chan_spec bmp580_channels[] = {
+	{
+		.type = IIO_PRESSURE,
+		/* PROCESSED maintained for ABI backwards compatibility */
+		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
+				      BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
+					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 24,
+			.storagebits = 32,
+			.endianness = IIO_LE,
+		},
 	},
 	{
 		.type = IIO_TEMP,
@@ -200,7 +291,15 @@ static const struct iio_chan_spec bmp380_channels[] = {
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 24,
+			.storagebits = 32,
+			.endianness = IIO_LE,
+		},
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(2),
 };
 
 static int bmp280_read_calib(struct bmp280_data *data)
@@ -316,7 +415,7 @@ static int bme280_read_humid_adc(struct bmp280_data *data, u16 *adc_humidity)
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, BME280_REG_HUMIDITY_MSB,
-			       &data->be16, sizeof(data->be16));
+			       &data->be16, BME280_NUM_HUMIDITY_BYTES);
 	if (ret) {
 		dev_err(data->dev, "failed to read humidity\n");
 		return ret;
@@ -362,7 +461,7 @@ static int bmp280_read_temp_adc(struct bmp280_data *data, u32 *adc_temp)
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
-			       data->buf, sizeof(data->buf));
+			       data->buf, BMP280_NUM_TEMP_BYTES);
 	if (ret) {
 		dev_err(data->dev, "failed to read temperature\n");
 		return ret;
@@ -423,7 +522,7 @@ static int bmp280_read_press_adc(struct bmp280_data *data, u32 *adc_press)
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
-			       data->buf, sizeof(data->buf));
+			       data->buf, BMP280_NUM_PRESS_BYTES);
 	if (ret) {
 		dev_err(data->dev, "failed to read pressure\n");
 		return ret;
@@ -874,6 +973,16 @@ static const struct iio_info bmp280_info = {
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
@@ -901,6 +1010,53 @@ static int bmp280_chip_config(struct bmp280_data *data)
 	return ret;
 }
 
+static irqreturn_t bmp280_trigger_handler(int irq, void *p)
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
@@ -914,6 +1070,7 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.start_up_time = 2000,
 	.channels = bmp280_channels,
 	.num_channels = ARRAY_SIZE(bmp280_channels),
+	.avail_scan_masks = bmp280_avail_scan_masks,
 
 	.oversampling_temp_avail = bmp280_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp280_oversampling_avail),
@@ -942,6 +1099,8 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
 	.read_calib = bmp280_read_calib,
+
+	.trigger_handler = bmp280_trigger_handler,
 };
 EXPORT_SYMBOL_NS(bmp280_chip_info, IIO_BMP280);
 
@@ -964,6 +1123,62 @@ static int bme280_chip_config(struct bmp280_data *data)
 	return bmp280_chip_config(data);
 }
 
+static irqreturn_t bme280_trigger_handler(int irq, void *p)
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
 
@@ -975,6 +1190,7 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.start_up_time = 2000,
 	.channels = bme280_channels,
 	.num_channels = ARRAY_SIZE(bme280_channels),
+	.avail_scan_masks = bme280_avail_scan_masks,
 
 	.oversampling_temp_avail = bmp280_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp280_oversampling_avail),
@@ -1000,6 +1216,8 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.read_press = bmp280_read_press,
 	.read_humid = bme280_read_humid,
 	.read_calib = bme280_read_calib,
+
+	.trigger_handler = bme280_trigger_handler,
 };
 EXPORT_SYMBOL_NS(bme280_chip_info, IIO_BMP280);
 
@@ -1054,7 +1272,7 @@ static int bmp380_read_temp_adc(struct bmp280_data *data, u32 *adc_temp)
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP380_REG_TEMP_XLSB,
-			       data->buf, sizeof(data->buf));
+			       data->buf, BMP280_NUM_TEMP_BYTES);
 	if (ret) {
 		dev_err(data->dev, "failed to read temperature\n");
 		return ret;
@@ -1123,7 +1341,7 @@ static int bmp380_read_press_adc(struct bmp280_data *data, u32 *adc_press)
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP380_REG_PRESS_XLSB,
-			       data->buf, sizeof(data->buf));
+			       data->buf, BMP280_NUM_PRESS_BYTES);
 	if (ret) {
 		dev_err(data->dev, "failed to read pressure\n");
 		return ret;
@@ -1384,6 +1602,53 @@ static int bmp380_chip_config(struct bmp280_data *data)
 	return 0;
 }
 
+static irqreturn_t bmp380_trigger_handler(int irq, void *p)
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
@@ -1399,6 +1664,7 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.start_up_time = 2000,
 	.channels = bmp380_channels,
 	.num_channels = ARRAY_SIZE(bmp380_channels),
+	.avail_scan_masks = bmp280_avail_scan_masks,
 
 	.oversampling_temp_avail = bmp380_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp380_oversampling_avail),
@@ -1426,6 +1692,8 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.read_press = bmp380_read_press,
 	.read_calib = bmp380_read_calib,
 	.preinit = bmp380_preinit,
+
+	.trigger_handler = bmp380_trigger_handler,
 };
 EXPORT_SYMBOL_NS(bmp380_chip_info, IIO_BMP280);
 
@@ -1546,8 +1814,8 @@ static int bmp580_read_temp(struct bmp280_data *data, s32 *raw_temp)
 	s32 value_temp;
 	int ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB, data->buf,
-			       sizeof(data->buf));
+	ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB,
+			       data->buf, BMP280_NUM_TEMP_BYTES);
 	if (ret) {
 		dev_err(data->dev, "failed to read temperature\n");
 		return ret;
@@ -1568,8 +1836,8 @@ static int bmp580_read_press(struct bmp280_data *data, u32 *raw_press)
 	u32 value_press;
 	int ret;
 
-	ret = regmap_bulk_read(data->regmap, BMP580_REG_PRESS_XLSB, data->buf,
-			       sizeof(data->buf));
+	ret = regmap_bulk_read(data->regmap, BMP580_REG_PRESS_XLSB,
+			       data->buf, BMP280_NUM_PRESS_BYTES);
 	if (ret) {
 		dev_err(data->dev, "failed to read pressure\n");
 		return ret;
@@ -1916,6 +2184,38 @@ static int bmp580_chip_config(struct bmp280_data *data)
 	return 0;
 }
 
+static irqreturn_t bmp580_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct bmp280_data *data = iio_priv(indio_dev);
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
+	memcpy(&data->sensor_data[1], &data->buf[0], 3);
+
+	/* Pressure calculations */
+	memcpy(&data->sensor_data[0], &data->buf[3], 3);
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
 /* Instead of { 1000, 16 } we do this, to avoid overflow issues */
@@ -1928,8 +2228,9 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.num_chip_id = ARRAY_SIZE(bmp580_chip_ids),
 	.regmap_config = &bmp580_regmap_config,
 	.start_up_time = 2000,
-	.channels = bmp380_channels,
-	.num_channels = ARRAY_SIZE(bmp380_channels),
+	.channels = bmp580_channels,
+	.num_channels = ARRAY_SIZE(bmp580_channels),
+	.avail_scan_masks = bmp280_avail_scan_masks,
 
 	.oversampling_temp_avail = bmp580_oversampling_avail,
 	.num_oversampling_temp_avail = ARRAY_SIZE(bmp580_oversampling_avail),
@@ -1956,6 +2257,8 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.read_temp = bmp580_read_temp,
 	.read_press = bmp580_read_press,
 	.preinit = bmp580_preinit,
+
+	.trigger_handler = bmp580_trigger_handler,
 };
 EXPORT_SYMBOL_NS(bmp580_chip_info, IIO_BMP280);
 
@@ -2134,7 +2437,7 @@ static int bmp180_read_press_adc(struct bmp280_data *data, u32 *adc_press)
 		return ret;
 
 	ret = regmap_bulk_read(data->regmap, BMP180_REG_OUT_MSB,
-			       data->buf, sizeof(data->buf));
+			       data->buf, BMP280_NUM_PRESS_BYTES);
 	if (ret) {
 		dev_err(data->dev, "failed to read pressure\n");
 		return ret;
@@ -2205,6 +2508,36 @@ static int bmp180_chip_config(struct bmp280_data *data)
 	return 0;
 }
 
+static irqreturn_t bmp180_trigger_handler(int irq, void *p)
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
@@ -2219,6 +2552,7 @@ const struct bmp280_chip_info bmp180_chip_info = {
 	.start_up_time = 2000,
 	.channels = bmp280_channels,
 	.num_channels = ARRAY_SIZE(bmp280_channels),
+	.avail_scan_masks = bmp280_avail_scan_masks,
 
 	.oversampling_temp_avail = bmp180_oversampling_temp_avail,
 	.num_oversampling_temp_avail =
@@ -2239,6 +2573,8 @@ const struct bmp280_chip_info bmp180_chip_info = {
 	.read_temp = bmp180_read_temp,
 	.read_press = bmp180_read_press,
 	.read_calib = bmp180_read_calib,
+
+	.trigger_handler = bmp180_trigger_handler,
 };
 EXPORT_SYMBOL_NS(bmp180_chip_info, IIO_BMP280);
 
@@ -2284,6 +2620,30 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
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
@@ -2330,6 +2690,7 @@ int bmp280_common_probe(struct device *dev,
 	/* Apply initial values from chip info structure */
 	indio_dev->channels = chip_info->channels;
 	indio_dev->num_channels = chip_info->num_channels;
+	indio_dev->available_scan_masks = chip_info->avail_scan_masks;
 	data->oversampling_press = chip_info->oversampling_press_default;
 	data->oversampling_humid = chip_info->oversampling_humid_default;
 	data->oversampling_temp = chip_info->oversampling_temp_default;
@@ -2415,6 +2776,14 @@ int bmp280_common_probe(struct device *dev,
 					     "failed to read calibration coefficients\n");
 	}
 
+	ret = devm_iio_triggered_buffer_setup(data->dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      data->chip_info->trigger_handler,
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
index a3d2cd722760..0933e411ae2c 100644
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
+	irqreturn_t (*trigger_handler)(int irq, void *p);
 };
 
 /* Chip infos for each variant */
-- 
2.25.1


