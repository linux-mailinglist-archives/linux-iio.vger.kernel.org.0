Return-Path: <linux-iio+bounces-7518-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E24792F0EB
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 23:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C6A1C20A74
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 21:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8668D1A0B08;
	Thu, 11 Jul 2024 21:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AD4G0gLD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315CD1A0725;
	Thu, 11 Jul 2024 21:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732589; cv=none; b=G4H7Eo7u5ymGXOGMHBNjOPKjTwRQN2ZneYLyaBbKqF7ozSSPTglz+Uq5PaqMxp45esTwppEtaoUOpG9ImBZU3OLkZk3sRLd+0H2B4CxcA6d7RjtVwlPFzX48gwu9pF4f43JZaXVS+W6qLFHXb3miUnE13wnKt9uAVZYplAtui84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732589; c=relaxed/simple;
	bh=wqVtrgUtnDmwTlfHIFjCyf9iIRUKIg98JHzUq5SJ+jQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ppYos22KgJkg6+hirC/SaTiD/YrM4SmJN8A5kjmU4MWOzi6gykJKxSZBQXlJ8CdGtvebDQXGZptYgRhVfa+pT/FAhKv0eCmMr7qkHBBtis9MBCRaiULvs54O3IGitn+jMNV7HhU7KWTlNGrOM7+l/JfafcEe35eE7lHPdWz3Yfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AD4G0gLD; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-58e76294858so4386733a12.0;
        Thu, 11 Jul 2024 14:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720732585; x=1721337385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HxVh2Sfi+9HqjHvHaFZvSf8nxNpjwkTgMPpFouegvVQ=;
        b=AD4G0gLDIPDgtQ8zEfKqC9YFuUiCJU06IOJ6kriuofiHAI4zGKdBqXSxBEbM4I3JJV
         O/gezkgYEODMBLQS2OAJWq2iNIGnWGEcF4rwPta2LZB8lsr5p7nufIvAxAFnEybQcpbM
         tjjH2YrhdKJyMQayJpuqBOS+JGDqRkB+mo/o7oH7M1SeJzDz+Qc6+CblERs76X+b58Q7
         iWvpIFz7MO8rg4mSLmC1TCmWhrs4qxCAUY0ZVeaHhCUHII9iB867G2y81kfE77e7pv8O
         dxfDHSlxZbaYAXEqk7rY9GFvFA14VP7WhCTl6+hDB9PzNmXDljHMHxEynsae8sJ7W/BK
         2HMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720732585; x=1721337385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HxVh2Sfi+9HqjHvHaFZvSf8nxNpjwkTgMPpFouegvVQ=;
        b=TLb7E9LbeCEm2S6LtlC6UXeAxDhG4md8x+rRPoCjFwHgAdNQFnCT45qt0cXDTYy7lz
         VjeByVOVpnV50cD/lnf/KnZFFAQBS2NwMPSV7m3bmQlTuj9YIIAn+4YOaQpwxjR4eApu
         FPi5jqy8M7YPhD8STWMpPKRxfI5oYw/Y0D07pTxxDoyqiia1eW3/9EDIDJ96/FDeYiak
         6EGEGJg7CSMWNxYkGAT2X7tcEIC+ujl/PRf2jtxbDjGntaCbR6yQ3v2AmOxrlNYtzBtw
         hk4f8yaiUdNSQvbaZSFZ3yOX6wSpYRyCEH3+V6LAryR4qy2NL5JHtGF9TkzyUw43PQzO
         28sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXa+ynsqq+LxqczkzqWX7xZto75Wbr7jjj8AzAIGdPZ6JnChl8VUmO6TvhDUb83aLyJIEFNjHNtPwnn7D8feqW/0tKQE+291DrV5UHR2KoUwqVdhmsv5s+UXxYhIjXV2cbVLGm56HspKrLDWQKsua3K5I+Dj4zTdVUrZZU/lAP7rX7tqg==
X-Gm-Message-State: AOJu0Yweb2fCBY8xDEIlzgzfjqRzPCLxKpQRBMLcGOMNK+iyK96BC1c2
	dOQB5jxabNXSoKB2luuaBfYuFeCNQVE1hPuPdy2HQ0V/PYZLvdf3
X-Google-Smtp-Source: AGHT+IEJZO1U64B255yG15iNqqSRVZ4pq+qt3TdtOudnJyzpR2/Ip7Qa+DJsbJUPOovpmXdtcnzUSA==
X-Received: by 2002:a50:9e66:0:b0:585:2924:1569 with SMTP id 4fb4d7f45d1cf-599609a3be5mr493022a12.21.1720732585378;
        Thu, 11 Jul 2024 14:16:25 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:3e02:47b2:c845:ae3a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bd45a1b6sm3815737a12.60.2024.07.11.14.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 14:16:25 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org,
	biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com,
	semen.protsenko@linaro.org,
	579lpy@gmail.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 07/10] iio: pressure: bmp280: Use sleep and forced mode for oneshot captures
Date: Thu, 11 Jul 2024 23:15:55 +0200
Message-Id: <20240711211558.106327-8-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240711211558.106327-1-vassilisamir@gmail.com>
References: <20240711211558.106327-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds forced mode support in sensors BMP28x, BME28x, BMP3xx
and BMP58x. Sensors BMP18x and BMP085 are old and do not support this
feature so their operation is not affected at all.

Essentially, up to now, the rest of the sensors were used in normal mode
all the time. This means that they are continuously doing measurements
even though these measurements are not used. Even though the sensor does
provide PM support, to cover all the possible use cases, the sensor needs
to go into sleep mode and wake up whenever necessary.

This commit, adds sleep and forced mode support. Essentially, the sensor
sleeps all the time except for when a measurement is requested. When there
is a request for a measurement, the sensor is put into forced mode, starts
the measurement and after it is done we read the output and we put it again
in sleep mode.

For really fast and more deterministic measurements, the triggered buffer
interface can be used, since the sensor is still used in normal mode for
that use case.

This commit does not add though support for DEEP STANDBY, Low Power NORMAL
and CONTINUOUS modes, supported only by the BMP58x version.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 276 +++++++++++++++++++++++++++--
 drivers/iio/pressure/bmp280.h      |  12 ++
 2 files changed, 269 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 9c99373d66ec..fc8d42880eb8 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -145,6 +145,12 @@ enum bmp280_scan {
 	BME280_HUMID,
 };
 
+enum bmp280_power_modes {
+	BMP280_SLEEP,
+	BMP280_NORMAL,
+	BMP280_FORCED,
+};
+
 static const struct iio_chan_spec bmp280_channels[] = {
 	{
 		.type = IIO_PRESSURE,
@@ -610,6 +616,14 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_PROCESSED:
+		ret = data->chip_info->set_mode(data, BMP280_FORCED);
+		if (ret)
+			return ret;
+
+		ret = data->chip_info->wait_conv(data);
+		if (ret)
+			return ret;
+
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
 			ret = data->chip_info->read_humid(data, &chan_value);
@@ -639,6 +653,14 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_RAW:
+		ret = data->chip_info->set_mode(data, BMP280_FORCED);
+		if (ret)
+			return ret;
+
+		ret = data->chip_info->wait_conv(data);
+		if (ret)
+			return ret;
+
 		switch (chan->type) {
 		case IIO_HUMIDITYRELATIVE:
 			ret = data->chip_info->read_humid(data, &chan_value);
@@ -984,6 +1006,68 @@ static int bmp280_preinit(struct bmp280_data *data)
 	return 0;
 }
 
+static int bmp280_set_mode(struct bmp280_data *data, u8 mode)
+{
+	int ret;
+
+	switch (mode) {
+	case BMP280_SLEEP:
+		ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
+					BMP280_MODE_MASK, BMP280_MODE_SLEEP);
+		break;
+	case BMP280_FORCED:
+		ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
+					BMP280_MODE_MASK, BMP280_MODE_FORCED);
+		break;
+	case BMP280_NORMAL:
+		ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
+					BMP280_MODE_MASK, BMP280_MODE_NORMAL);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (ret) {
+		dev_err(data->dev, "failed to  write ctrl_meas register\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int bmp280_wait_conv(struct bmp280_data *data)
+{
+	unsigned int reg;
+	int ret, meas_time;
+
+	meas_time = BMP280_MEAS_OFFSET;
+
+	if (data->oversampling_humid)
+		meas_time += (1 << data->oversampling_humid) * BMP280_MEAS_DUR +
+			       BMP280_PRESS_HUMID_MEAS_OFFSET;
+
+	/* Pressure measurement time */
+	meas_time += (1 << data->oversampling_press) * BMP280_MEAS_DUR +
+		      BMP280_PRESS_HUMID_MEAS_OFFSET;
+
+	/* Temperature measurement time */
+	meas_time += (1 << data->oversampling_temp) * BMP280_MEAS_DUR;
+
+	usleep_range(meas_time, meas_time * 12 / 10);
+
+	ret = regmap_read(data->regmap, BMP280_REG_STATUS, &reg);
+	if (ret) {
+		dev_err(data->dev, "failed to read status register\n");
+		return ret;
+	}
+	if (reg & BMP280_REG_STATUS_MEAS_BIT) {
+		dev_err(data->dev, "Measurement cycle didn't complete\n");
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 static int bmp280_chip_config(struct bmp280_data *data)
 {
 	u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
@@ -994,7 +1078,7 @@ static int bmp280_chip_config(struct bmp280_data *data)
 				BMP280_OSRS_TEMP_MASK |
 				BMP280_OSRS_PRESS_MASK |
 				BMP280_MODE_MASK,
-				osrs | BMP280_MODE_NORMAL);
+				osrs | BMP280_MODE_SLEEP);
 	if (ret) {
 		dev_err(data->dev, "failed to write ctrl_meas register\n");
 		return ret;
@@ -1100,6 +1184,8 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
 	.read_calib = bmp280_read_calib,
+	.set_mode = bmp280_set_mode,
+	.wait_conv = bmp280_wait_conv,
 	.preinit = bmp280_preinit,
 
 	.trigger_handler = bmp280_trigger_handler,
@@ -1218,6 +1304,8 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.read_press = bmp280_read_press,
 	.read_humid = bme280_read_humid,
 	.read_calib = bme280_read_calib,
+	.set_mode = bmp280_set_mode,
+	.wait_conv = bmp280_wait_conv,
 	.preinit = bmp280_preinit,
 
 	.trigger_handler = bme280_trigger_handler,
@@ -1505,6 +1593,75 @@ static int bmp380_preinit(struct bmp280_data *data)
 	return bmp380_cmd(data, BMP380_CMD_SOFT_RESET);
 }
 
+static int bmp380_set_mode(struct bmp280_data *data, u8 mode)
+{
+	int ret;
+
+	switch (mode) {
+	case BMP280_SLEEP:
+		ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
+					BMP380_MODE_MASK,
+					FIELD_PREP(BMP380_MODE_MASK,
+						   BMP380_MODE_SLEEP));
+		break;
+	case BMP280_FORCED:
+		ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
+					BMP380_MODE_MASK,
+					FIELD_PREP(BMP380_MODE_MASK,
+						   BMP380_MODE_FORCED));
+		break;
+	case BMP280_NORMAL:
+		ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
+					BMP380_MODE_MASK,
+					FIELD_PREP(BMP380_MODE_MASK,
+						   BMP380_MODE_NORMAL));
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (ret) {
+		dev_err(data->dev, "failed to  write power control register\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int bmp380_wait_conv(struct bmp280_data *data)
+{
+	unsigned int reg;
+	int ret, meas_time;
+
+	/* Offset measurement time */
+	meas_time = BMP380_MEAS_OFFSET;
+
+	/* Pressure measurement time */
+	meas_time += (1 << data->oversampling_press) * BMP380_MEAS_DUR +
+		      BMP380_PRESS_MEAS_OFFSET;
+
+	/* Temperature measurement time */
+	meas_time += (1 << data->oversampling_temp) * BMP380_MEAS_DUR +
+		      BMP380_TEMP_MEAS_OFFSET;
+
+	usleep_range(meas_time, meas_time * 12 / 10);
+
+	ret = regmap_read(data->regmap, BMP380_REG_STATUS, &reg);
+	if (ret) {
+		dev_err(data->dev, "failed to read status register\n");
+		return ret;
+	}
+
+	if (!(reg & BMP380_STATUS_DRDY_PRESS_MASK) ||
+	    !(reg & BMP380_STATUS_DRDY_TEMP_MASK)) {
+		pr_info("Meas_time: %d\n", meas_time);
+		dev_err(data->dev, "Measurement cycle didn't complete\n");
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 static int bmp380_chip_config(struct bmp280_data *data)
 {
 	bool change = false, aux;
@@ -1565,17 +1722,15 @@ static int bmp380_chip_config(struct bmp280_data *data)
 		 * Resets sensor measurement loop toggling between sleep and
 		 * normal operating modes.
 		 */
-		ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
-					BMP380_MODE_MASK,
-					FIELD_PREP(BMP380_MODE_MASK, BMP380_MODE_SLEEP));
+		ret = bmp380_set_mode(data, BMP280_SLEEP);
 		if (ret) {
 			dev_err(data->dev, "failed to set sleep mode\n");
 			return ret;
 		}
-		usleep_range(2000, 2500);
-		ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
-					BMP380_MODE_MASK,
-					FIELD_PREP(BMP380_MODE_MASK, BMP380_MODE_NORMAL));
+
+		usleep_range(data->start_up_time, data->start_up_time + 500);
+
+		ret = bmp380_set_mode(data, BMP280_NORMAL);
 		if (ret) {
 			dev_err(data->dev, "failed to set normal mode\n");
 			return ret;
@@ -1601,6 +1756,17 @@ static int bmp380_chip_config(struct bmp280_data *data)
 		}
 	}
 
+	/* Dummy read to empty data registers. */
+	ret = bmp380_read_press(data, &tmp);
+	if (ret)
+		return ret;
+
+	ret = bmp380_set_mode(data, BMP280_SLEEP);
+	if (ret) {
+		dev_err(data->dev, "failed to set sleep mode\n");
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -1693,6 +1859,8 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.read_temp = bmp380_read_temp,
 	.read_press = bmp380_read_press,
 	.read_calib = bmp380_read_calib,
+	.set_mode = bmp380_set_mode,
+	.wait_conv = bmp380_wait_conv,
 	.preinit = bmp380_preinit,
 
 	.trigger_handler = bmp380_trigger_handler,
@@ -2080,6 +2248,65 @@ static int bmp580_preinit(struct bmp280_data *data)
 	return PTR_ERR_OR_ZERO(devm_nvmem_register(config.dev, &config));
 }
 
+static int bmp580_set_mode(struct bmp280_data *data, u8 mode)
+{
+	int ret;
+
+	switch (mode) {
+	case BMP280_SLEEP:
+		ret = regmap_write_bits(data->regmap, BMP580_REG_ODR_CONFIG,
+					BMP580_MODE_MASK,
+					FIELD_PREP(BMP580_MODE_MASK,
+						   BMP580_MODE_SLEEP));
+		break;
+	case BMP280_FORCED:
+		ret = regmap_set_bits(data->regmap, BMP580_REG_DSP_CONFIG,
+				      BMP580_DSP_IIR_FORCED_FLUSH);
+
+		ret = regmap_write_bits(data->regmap, BMP580_REG_ODR_CONFIG,
+					BMP580_MODE_MASK,
+					FIELD_PREP(BMP580_MODE_MASK,
+						   BMP580_MODE_FORCED));
+		break;
+	case BMP280_NORMAL:
+		ret = regmap_write_bits(data->regmap, BMP580_REG_ODR_CONFIG,
+					BMP580_MODE_MASK,
+					FIELD_PREP(BMP580_MODE_MASK,
+						   BMP580_MODE_NORMAL));
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (ret) {
+		dev_err(data->dev, "failed to  write power control register\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int bmp580_wait_conv(struct bmp280_data *data)
+{
+	/*
+	 * Taken from datasheet, Section 2 "Specification, Table 3 "Electrical
+	 * characteristics
+	 */
+	const int time_conv_press[] = { 0, 1050, 1785, 3045, 5670, 10920, 21420,
+					42420, 84420};
+	const int time_conv_temp[] = { 0, 1050, 1105, 1575, 2205, 3465, 6090,
+				       11340, 21840};
+	int meas_time;
+
+	meas_time = 4000 + time_conv_temp[data->oversampling_temp] +
+			   time_conv_press[data->oversampling_press];
+
+	usleep_range(meas_time, meas_time * 12 / 10);
+
+	return 0;
+}
+
+
 static int bmp580_chip_config(struct bmp280_data *data)
 {
 	bool change = false, aux;
@@ -2150,17 +2377,6 @@ static int bmp580_chip_config(struct bmp280_data *data)
 		return ret;
 	}
 
-	/* Restore sensor to normal operation mode */
-	ret = regmap_write_bits(data->regmap, BMP580_REG_ODR_CONFIG,
-				BMP580_MODE_MASK,
-				FIELD_PREP(BMP580_MODE_MASK, BMP580_MODE_NORMAL));
-	if (ret) {
-		dev_err(data->dev, "failed to set normal mode\n");
-		return ret;
-	}
-	/* From datasheet's table 4: electrical characteristics */
-	usleep_range(3000, 3500);
-
 	if (change) {
 		/*
 		 * Check if ODR and OSR settings are valid or we are
@@ -2256,6 +2472,8 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.chip_config = bmp580_chip_config,
 	.read_temp = bmp580_read_temp,
 	.read_press = bmp580_read_press,
+	.set_mode = bmp580_set_mode,
+	.wait_conv = bmp580_wait_conv,
 	.preinit = bmp580_preinit,
 
 	.trigger_handler = bmp580_trigger_handler,
@@ -2503,6 +2721,16 @@ static int bmp180_read_press(struct bmp280_data *data, u32 *comp_press)
 	return 0;
 }
 
+static int bmp180_set_mode(struct bmp280_data *data, u8 mode)
+{
+	return 0;
+}
+
+static int bmp180_wait_conv(struct bmp280_data *data)
+{
+	return 0;
+}
+
 static int bmp180_chip_config(struct bmp280_data *data)
 {
 	return 0;
@@ -2573,6 +2801,8 @@ const struct bmp280_chip_info bmp180_chip_info = {
 	.read_temp = bmp180_read_temp,
 	.read_press = bmp180_read_press,
 	.read_calib = bmp180_read_calib,
+	.set_mode = bmp180_set_mode,
+	.wait_conv = bmp180_wait_conv,
 
 	.trigger_handler = bmp180_trigger_handler,
 };
@@ -2625,6 +2855,7 @@ static int bmp280_buffer_preenable(struct iio_dev *indio_dev)
 	struct bmp280_data *data = iio_priv(indio_dev);
 
 	pm_runtime_get_sync(data->dev);
+	data->chip_info->set_mode(data, BMP280_NORMAL);
 
 	return 0;
 }
@@ -2795,6 +3026,10 @@ int bmp280_common_probe(struct device *dev,
 			return ret;
 	}
 
+	ret = data->chip_info->set_mode(data, BMP280_SLEEP);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set sleep mode\n");
+
 	/* Enable runtime PM */
 	pm_runtime_get_noresume(dev);
 	pm_runtime_set_active(dev);
@@ -2820,6 +3055,9 @@ static int bmp280_runtime_suspend(struct device *dev)
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmp280_data *data = iio_priv(indio_dev);
 
+	data->chip_info->set_mode(data, BMP280_SLEEP);
+
+	usleep_range(2500, 3000);
 	return regulator_bulk_disable(BMP280_NUM_SUPPLIES, data->supplies);
 }
 
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 02647454bd02..93c006c33552 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -170,6 +170,11 @@
 #define BMP380_MODE_FORCED		1
 #define BMP380_MODE_NORMAL		3
 
+#define BMP380_MEAS_OFFSET		234
+#define BMP380_MEAS_DUR			2020
+#define BMP380_TEMP_MEAS_OFFSET		163
+#define BMP380_PRESS_MEAS_OFFSET	392
+
 #define BMP380_MIN_TEMP			-4000
 #define BMP380_MAX_TEMP			8500
 #define BMP380_MIN_PRES			3000000
@@ -206,6 +211,7 @@
 #define BMP280_REG_CTRL_MEAS		0xF4
 #define BMP280_REG_STATUS		0xF3
 #define BMP280_REG_STATUS_IM_UPDATE	BIT(0)
+#define BMP280_REG_STATUS_MEAS_BIT	BIT(3)
 #define BMP280_REG_RESET		0xE0
 #define BMP280_RST_SOFT_CMD		0xB6
 
@@ -246,6 +252,10 @@
 #define BMP280_MODE_FORCED		1
 #define BMP280_MODE_NORMAL		3
 
+#define BMP280_MEAS_OFFSET		1250
+#define BMP280_MEAS_DUR			2300
+#define BMP280_PRESS_HUMID_MEAS_OFFSET	575
+
 /* BME280 specific registers */
 #define BME280_REG_HUMIDITY_LSB		0xFE
 #define BME280_REG_HUMIDITY_MSB		0xFD
@@ -484,6 +494,8 @@ struct bmp280_chip_info {
 	int (*read_humid)(struct bmp280_data *data, u32 *adc_humidity);
 	int (*read_calib)(struct bmp280_data *data);
 	int (*preinit)(struct bmp280_data *data);
+	int (*set_mode)(struct bmp280_data *data, u8 mode);
+	int (*wait_conv)(struct bmp280_data *data);
 
 	irqreturn_t (*trigger_handler)(int irq, void *p);
 };
-- 
2.25.1


