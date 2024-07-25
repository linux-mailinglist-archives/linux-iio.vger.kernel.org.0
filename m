Return-Path: <linux-iio+bounces-7898-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B25A293CB18
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 01:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1ACC1C21759
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 23:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE9B14E2ED;
	Thu, 25 Jul 2024 23:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2tj4Aul"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A3714A095;
	Thu, 25 Jul 2024 23:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721949055; cv=none; b=gQR2ZpOsaF0vORID1JAlEcP+yibdUDql9bCIu0A4/Fua7A00AOtDQY0J1vvoDbUL/EuO3wAC+J2m6J2zvZdN51hTAtnWbFhQkCON+I+V7j6bYgIEwTdWoYlbyuJ8Lc8lH9kI/IgOHu6u9ZA2W2/hc+VST7B7+wclfenumasMzCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721949055; c=relaxed/simple;
	bh=n4Jr4FHuvIMsUk8qx98x71mrho1Na1gQuxe2PAP+lkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RSBeG1PCE6ZSaIaPaOOsz2UHFGlLgjBk0A+ffa5mwurXyigXoWrvtQuN3WjGShhjmW7IFDQUcz512dfYT+OGjv639bMHC/6fbkR/eXPOXmBwOQgHeddEdA4fLD9qpAIcCJXMl+trSau8sjqgwpvTbQw0cR5RS05HNyYIM+M+vV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2tj4Aul; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7b2dbd81e3so140193666b.1;
        Thu, 25 Jul 2024 16:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721949051; x=1722553851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBRTrSWzfMQi2JmatTs2LqqJlIc6oMTOOaK75DRYfgQ=;
        b=m2tj4AulCfmKEOgeDNxVc5w+1KvXg0kF2XD/NmsE9Lu6wyCM5TY8WVGhUlMu/YVFmS
         TEXUC7yPNx22kten3qF7nuRXXC/rwkXLlaRtX1N43sxKDlUWNAJTcT8/6OT7OkL3piIK
         AhTB+1zke8eIaPGUMRr4WOKOWOuUmWR/ieBbl3Fx+7+UBwG+vThLcR3IdJW8Bp4nGF5s
         /bFE/Nc/L9qENJEgHecTz0SjAZ6DwEpfYqGyX2vX1fhhaiqB8PGqbBjseFFQHWdC5G+4
         vb2lvw00XipdUhi5roir1WiCz0M+KSEP6woBcTHC64Sdz8MPBtUTItDbDJCyOjCCD5P8
         R4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721949051; x=1722553851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBRTrSWzfMQi2JmatTs2LqqJlIc6oMTOOaK75DRYfgQ=;
        b=hikJsedpsuj2Yp7KQqPPhDXuNOmvgeq2nDxA/yuRNDWv0YrGmD1imzLARgHKgOt9MI
         l+mi7QruEBCzxgxFe17nbkzqLXbYEVt01SNip4RDuRo1uK9aoC8P1mez0ONxHvsG5WZj
         Am1FYGQ1fZb2/fAurp4/yd97d68INzfz6eb2jQE00xjf178+OEmR35rKD+SLgs2g/FSW
         XPfHo4zB8nsk3uy4xJ33KMsnn9XApXPWAHRwWvfG07gK6VJBoiRhGyareaeYCObCsxk4
         E/EjctenF/SD/66DmfamALFpZbiZVsqYcE2uzsjNY/zjkO1UdGtSn4MQ44BiQTUSRVwv
         3r8g==
X-Forwarded-Encrypted: i=1; AJvYcCW+Spa6duW/suoezV+rLqDxs2kAmygar1FtgMH3nvXaMy0YBNuKZ8ImjDsqwiLkTS8fvwtLYsvbP9R0J49EQBpgniTAZkn8+tp3If6kcwBl9OZHMzJkYQYbpNjD8zKGFf0iORpL3XTwRXpLi+GLehjT5EVAKCOKIypN23O5FXp0sfKsrg==
X-Gm-Message-State: AOJu0YxySRJ3f2WfLjAfIo0PaRddYcOXLeCXjqGrTFwsKWho8AnkypAh
	eD1B3cQLNEAKi4RmxOnz29xDXzCQKblUDceAXhxlDblp4QHiL4zM
X-Google-Smtp-Source: AGHT+IGaIqXUMz2N/lGTrB8JTtq8kIpwXeSPIiAdPHsYA55XQ4Vk4KX+mVxUqOV71SQDiQynF4QCFg==
X-Received: by 2002:a17:907:72c5:b0:a6f:6b6a:e8d0 with SMTP id a640c23a62f3a-a7ac4d9d2a1mr304671466b.7.1721949051324;
        Thu, 25 Jul 2024 16:10:51 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4b59:cba2:6db8:9f30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab236e3sm115429266b.25.2024.07.25.16.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 16:10:50 -0700 (PDT)
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
Subject: [PATCH v2 4/7] iio: pressure: bmp280: Use sleep and forced mode for oneshot captures
Date: Fri, 26 Jul 2024 01:10:36 +0200
Message-Id: <20240725231039.614536-5-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240725231039.614536-1-vassilisamir@gmail.com>
References: <20240725231039.614536-1-vassilisamir@gmail.com>
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
 drivers/iio/pressure/bmp280-core.c | 264 ++++++++++++++++++++++++++---
 drivers/iio/pressure/bmp280.h      |  18 ++
 2 files changed, 263 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 431fbe9f3ee9..4a8d2ed4a9c4 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -615,6 +615,14 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 
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
@@ -644,6 +652,14 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
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
@@ -989,6 +1005,67 @@ static int bmp280_preinit(struct bmp280_data *data)
 	return 0;
 }
 
+static const u8 bmp280_operation_mode[] = { BMP280_MODE_SLEEP,
+					    BMP280_MODE_FORCED,
+					    BMP280_MODE_NORMAL };
+
+static int bmp280_set_mode(struct bmp280_data *data, enum bmp280_op_mode mode)
+{
+	int ret;
+
+	switch (mode) {
+	case BMP280_SLEEP:
+	case BMP280_FORCED:
+	case BMP280_NORMAL:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_write_bits(data->regmap, BMP280_REG_CTRL_MEAS,
+				BMP280_MODE_MASK, bmp280_operation_mode[mode]);
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
+	/* Check if we are using a BME280 device */
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
@@ -999,7 +1076,7 @@ static int bmp280_chip_config(struct bmp280_data *data)
 				BMP280_OSRS_TEMP_MASK |
 				BMP280_OSRS_PRESS_MASK |
 				BMP280_MODE_MASK,
-				osrs | BMP280_MODE_NORMAL);
+				osrs | BMP280_MODE_SLEEP);
 	if (ret) {
 		dev_err(data->dev, "failed to write ctrl_meas register\n");
 		return ret;
@@ -1105,6 +1182,8 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
 	.read_calib = bmp280_read_calib,
+	.set_mode = bmp280_set_mode,
+	.wait_conv = bmp280_wait_conv,
 	.preinit = bmp280_preinit,
 
 	.trigger_handler = bmp280_trigger_handler,
@@ -1223,6 +1302,8 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.read_press = bmp280_read_press,
 	.read_humid = bme280_read_humid,
 	.read_calib = bme280_read_calib,
+	.set_mode = bmp280_set_mode,
+	.wait_conv = bmp280_wait_conv,
 	.preinit = bmp280_preinit,
 
 	.trigger_handler = bme280_trigger_handler,
@@ -1510,6 +1591,68 @@ static int bmp380_preinit(struct bmp280_data *data)
 	return bmp380_cmd(data, BMP380_CMD_SOFT_RESET);
 }
 
+static const u8 bmp380_operation_mode[] = { BMP380_MODE_SLEEP,
+					    BMP380_MODE_FORCED,
+					    BMP380_MODE_NORMAL };
+
+static int bmp380_set_mode(struct bmp280_data *data, enum bmp280_op_mode mode)
+{
+	int ret;
+
+	switch (mode) {
+	case BMP280_SLEEP:
+	case BMP280_FORCED:
+	case BMP280_NORMAL:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
+				BMP380_MODE_MASK,
+				FIELD_PREP(BMP380_MODE_MASK,
+					   bmp380_operation_mode[mode]));
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
+		dev_err(data->dev, "Measurement cycle didn't complete.\n");
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 static int bmp380_chip_config(struct bmp280_data *data)
 {
 	bool change = false, aux;
@@ -1570,17 +1713,15 @@ static int bmp380_chip_config(struct bmp280_data *data)
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
@@ -1606,6 +1747,17 @@ static int bmp380_chip_config(struct bmp280_data *data)
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
 
@@ -1698,6 +1850,8 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.read_temp = bmp380_read_temp,
 	.read_press = bmp380_read_press,
 	.read_calib = bmp380_read_calib,
+	.set_mode = bmp380_set_mode,
+	.wait_conv = bmp380_wait_conv,
 	.preinit = bmp380_preinit,
 
 	.trigger_handler = bmp380_trigger_handler,
@@ -2085,6 +2239,64 @@ static int bmp580_preinit(struct bmp280_data *data)
 	return PTR_ERR_OR_ZERO(devm_nvmem_register(config.dev, &config));
 }
 
+static const u8 bmp580_operation_mode[] = { BMP580_MODE_SLEEP,
+					    BMP580_MODE_FORCED,
+					    BMP580_MODE_NORMAL };
+
+static int bmp580_set_mode(struct bmp280_data *data, enum bmp280_op_mode mode)
+{
+	int ret;
+
+	switch (mode) {
+	case BMP280_SLEEP:
+		break;
+	case BMP280_FORCED:
+		ret = regmap_set_bits(data->regmap, BMP580_REG_DSP_CONFIG,
+				      BMP580_DSP_IIR_FORCED_FLUSH);
+		if (ret) {
+			dev_err(data->dev,
+				"Could not flush IIR filter constants.\n");
+			return ret;
+		}
+		break;
+	case BMP280_NORMAL:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = regmap_write_bits(data->regmap, BMP580_REG_ODR_CONFIG,
+				BMP580_MODE_MASK,
+				FIELD_PREP(BMP580_MODE_MASK,
+					   bmp580_operation_mode[mode]));
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
 static int bmp580_chip_config(struct bmp280_data *data)
 {
 	bool change = false, aux;
@@ -2155,17 +2367,6 @@ static int bmp580_chip_config(struct bmp280_data *data)
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
@@ -2261,6 +2462,8 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.chip_config = bmp580_chip_config,
 	.read_temp = bmp580_read_temp,
 	.read_press = bmp580_read_press,
+	.set_mode = bmp580_set_mode,
+	.wait_conv = bmp580_wait_conv,
 	.preinit = bmp580_preinit,
 
 	.trigger_handler = bmp580_trigger_handler,
@@ -2508,6 +2711,19 @@ static int bmp180_read_press(struct bmp280_data *data, u32 *comp_press)
 	return 0;
 }
 
+/* Keep compatibility with future generations of the sensor */
+static int bmp180_set_mode(struct bmp280_data *data, enum bmp280_op_mode mode)
+{
+	return 0;
+}
+
+/* Keep compatibility with future generations of the sensor */
+static int bmp180_wait_conv(struct bmp280_data *data)
+{
+	return 0;
+}
+
+/* Keep compatibility with future generations of the sensor */
 static int bmp180_chip_config(struct bmp280_data *data)
 {
 	return 0;
@@ -2578,6 +2794,8 @@ const struct bmp280_chip_info bmp180_chip_info = {
 	.read_temp = bmp180_read_temp,
 	.read_press = bmp180_read_press,
 	.read_calib = bmp180_read_calib,
+	.set_mode = bmp180_set_mode,
+	.wait_conv = bmp180_wait_conv,
 
 	.trigger_handler = bmp180_trigger_handler,
 };
@@ -2630,6 +2848,7 @@ static int bmp280_buffer_preenable(struct iio_dev *indio_dev)
 	struct bmp280_data *data = iio_priv(indio_dev);
 
 	pm_runtime_get_sync(data->dev);
+	data->chip_info->set_mode(data, BMP280_NORMAL);
 
 	return 0;
 }
@@ -2800,6 +3019,10 @@ int bmp280_common_probe(struct device *dev,
 			return ret;
 	}
 
+	ret = data->chip_info->set_mode(data, BMP280_SLEEP);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set sleep mode\n");
+
 	/* Enable runtime PM */
 	pm_runtime_get_noresume(dev);
 	pm_runtime_set_active(dev);
@@ -2825,6 +3048,9 @@ static int bmp280_runtime_suspend(struct device *dev)
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmp280_data *data = iio_priv(indio_dev);
 
+	data->chip_info->set_mode(data, BMP280_SLEEP);
+
+	usleep_range(2500, 3000);
 	return regulator_bulk_disable(BMP280_NUM_SUPPLIES, data->supplies);
 }
 
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index a9f220c1f77a..f5d192509d61 100644
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
@@ -384,6 +394,12 @@ struct bmp380_calib {
 	s8  P11;
 };
 
+enum bmp280_op_mode {
+	BMP280_SLEEP,
+	BMP280_FORCED,
+	BMP280_NORMAL,
+};
+
 struct bmp280_data {
 	struct device *dev;
 	struct mutex lock;
@@ -485,6 +501,8 @@ struct bmp280_chip_info {
 	int (*read_humid)(struct bmp280_data *data, u32 *adc_humidity);
 	int (*read_calib)(struct bmp280_data *data);
 	int (*preinit)(struct bmp280_data *data);
+	int (*set_mode)(struct bmp280_data *data, enum bmp280_op_mode mode);
+	int (*wait_conv)(struct bmp280_data *data);
 
 	irqreturn_t (*trigger_handler)(int irq, void *p);
 };
-- 
2.25.1


