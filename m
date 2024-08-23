Return-Path: <linux-iio+bounces-8723-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BEF95D52B
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 20:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A91971F238DC
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 18:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E68A193072;
	Fri, 23 Aug 2024 18:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8iN5prM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318401925B3;
	Fri, 23 Aug 2024 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724437047; cv=none; b=LzT0G+PwRb1TSDWYuWoyZ5zQNnmsFgu6/JyP1vq2DogQ6XpVLFegjg3datkANAfvDNR5jJ0+aZk5mce8YavvZmV5wHyOpie61xtUoHaPy7MxaR+lJPF53+GszzaZBcTOBNzF9PD+Mip9+YAQreQFiKmTDkH7p5Rpbt+ZipfOVCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724437047; c=relaxed/simple;
	bh=ecuhficNmCfQpxSlfvPALIJiHH4vtImAG3pqSQ7YDhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lGATJUOJ1bqcG7/vb/q/07uC6DQcd61ivl04qmuEsc78HPwzma5oIKh3SlZmimAa5aLu8eYorN2MlgL0907P5szi2Mcj4JId1mW2TPudPHwo1TbU0Y3CehpopiLYDyaps7VbLTePkUA9o82/1dZ3ls1EZGvJqbdVf5SfH0p6tw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8iN5prM; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3719896b7c8so1112011f8f.3;
        Fri, 23 Aug 2024 11:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724437044; x=1725041844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCqLHDpZWjOO83Tbb1goX6058h8PiyPnjUYwXZy/ApQ=;
        b=j8iN5prM7sJ479uST8HtWApaciZOZCcZvXm2Z+/hokHRzutBSnCjbzdmjbvCDtsDh4
         QKEwzpXpvHN/iLvUzEb3w+NF7U0nJPmPWf2fOoNLTuu9dg1WgM1L8gSMY0v4ZzYsXl9b
         3hnqChyzZXXpnPSq/VKuI/8VmydcFw/cLEJa1UmcViSPE6pUTJHKkuEUxoipF6vsx9ne
         9BoMbNsyiFApgTBoF2dv5cDwIuPds1Ei5lIRCX8LfCS/brbfIfVdZfvp+fb+wFVZQDGb
         aW43p/ot3hpZsBdyADr3h4CS1FCXRjN6clprHV3XBpCEFaw/vH/M3MqnGPwg4n9R75Wj
         qRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724437044; x=1725041844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oCqLHDpZWjOO83Tbb1goX6058h8PiyPnjUYwXZy/ApQ=;
        b=QH5nfOsCLrd5kTSVzfxOmvqywl0+a78+O+p1QM4DQlw1qa2JbnSTymrozsMnl0zArA
         T9ZsmsYe9T8PXF3Yb3hlibI9m+CeA/G4Xf5CpnY4sEnGZvzIsWEvQn2zyh4+44pQptFV
         8FQI7uVdcHZDkD9/FikimmSvuSlzRLKrs16sDfLwP+VdFRPwfB3Y5lJtcrYlUEEd2lT4
         ann2b/HGYym5z5Nz9spf4SM6wQ8g+StXTWl+uwN9VGRIQnFCj24k0/UHWvrE9ZvWGQ13
         ZrrzDKGCC6sLanDQk1SonUKaVG8gqOJwHox3IUOJ0Dv7OPJdkLOd4mEdN8lb5VufO+a0
         iqzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0iM1xgWUYykZYcxV76/423tgswfjzJilMk1fXVgvQiPwBFBMpML7VWUEu6BM07XtMN27YO2cGkF5M@vger.kernel.org, AJvYcCWR7OUuTgAAAsGS0m2YJ03oyz8x44Ce0WLIurHu+yFHPU0RHSBhe0F64tOFha3wG7I4H5he1+4SDJsn@vger.kernel.org, AJvYcCXdWWUjE1rHXkKvIj8EInf8ccizIzrYuuDtET25AzC1iGErA9stwOXEhWRSqLGn+t+ILenofYgeqrGBKw2D@vger.kernel.org
X-Gm-Message-State: AOJu0YybnwYK7kkOBXU4JYPAntWyBtRDkL+ttjMwtG0U8Mp2tbX3JCzK
	a2esbDjvEq7HbKp+Hj5EkU29DgZIzhRoYJ1jaEQ1m07F7RB62ZGg
X-Google-Smtp-Source: AGHT+IFB8a0D684LPnadIEylwBRPe4KC/ikeT7obSo2BkTIM2325DYTarIv74BoCJS37586khJV2Bg==
X-Received: by 2002:adf:ecd0:0:b0:371:9121:5642 with SMTP id ffacd0b85a97d-3731186390amr2042610f8f.30.1724437043114;
        Fri, 23 Aug 2024 11:17:23 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:f90d:5a72:8d56:a041])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730814602asm4677939f8f.44.2024.08.23.11.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 11:17:22 -0700 (PDT)
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
Subject: [PATCH v3 4/7] iio: pressure: bmp280: Use sleep and forced mode for oneshot captures
Date: Fri, 23 Aug 2024 20:17:11 +0200
Message-Id: <20240823181714.64545-5-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823181714.64545-1-vassilisamir@gmail.com>
References: <20240823181714.64545-1-vassilisamir@gmail.com>
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
 drivers/iio/pressure/bmp280-core.c | 277 ++++++++++++++++++++++++++---
 drivers/iio/pressure/bmp280.h      |  21 +++
 2 files changed, 278 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 736a1f4fd5dc..e1336aeceec0 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -617,6 +617,14 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 
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
@@ -646,6 +654,14 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
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
@@ -989,6 +1005,69 @@ static int bmp280_preinit(struct bmp280_data *data)
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
+	data->op_mode = mode;
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
@@ -999,7 +1078,7 @@ static int bmp280_chip_config(struct bmp280_data *data)
 				BMP280_OSRS_TEMP_MASK |
 				BMP280_OSRS_PRESS_MASK |
 				BMP280_MODE_MASK,
-				osrs | BMP280_MODE_NORMAL);
+				osrs | BMP280_MODE_SLEEP);
 	if (ret) {
 		dev_err(data->dev, "failed to write ctrl_meas register\n");
 		return ret;
@@ -1106,6 +1185,8 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
 	.read_calib = bmp280_read_calib,
+	.set_mode = bmp280_set_mode,
+	.wait_conv = bmp280_wait_conv,
 	.preinit = bmp280_preinit,
 
 	.trigger_handler = bmp280_trigger_handler,
@@ -1227,6 +1308,8 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.read_press = bmp280_read_press,
 	.read_humid = bme280_read_humid,
 	.read_calib = bme280_read_calib,
+	.set_mode = bmp280_set_mode,
+	.wait_conv = bmp280_wait_conv,
 	.preinit = bmp280_preinit,
 
 	.trigger_handler = bme280_trigger_handler,
@@ -1514,6 +1597,70 @@ static int bmp380_preinit(struct bmp280_data *data)
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
+	data->op_mode = mode;
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
@@ -1574,17 +1721,15 @@ static int bmp380_chip_config(struct bmp280_data *data)
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
@@ -1610,6 +1755,17 @@ static int bmp380_chip_config(struct bmp280_data *data)
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
 
@@ -1703,6 +1859,8 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.read_temp = bmp380_read_temp,
 	.read_press = bmp380_read_press,
 	.read_calib = bmp380_read_calib,
+	.set_mode = bmp380_set_mode,
+	.wait_conv = bmp380_wait_conv,
 	.preinit = bmp380_preinit,
 
 	.trigger_handler = bmp380_trigger_handler,
@@ -2090,6 +2248,66 @@ static int bmp580_preinit(struct bmp280_data *data)
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
+	data->op_mode = mode;
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
+	static const int time_conv_press[] = { 0, 1050, 1785, 3045, 5670, 10920, 21420,
+					42420, 84420};
+	static const int time_conv_temp[] = { 0, 1050, 1105, 1575, 2205, 3465, 6090,
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
@@ -2160,17 +2378,6 @@ static int bmp580_chip_config(struct bmp280_data *data)
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
@@ -2266,6 +2473,8 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.chip_config = bmp580_chip_config,
 	.read_temp = bmp580_read_temp,
 	.read_press = bmp580_read_press,
+	.set_mode = bmp580_set_mode,
+	.wait_conv = bmp580_wait_conv,
 	.preinit = bmp580_preinit,
 
 	.trigger_handler = bmp580_trigger_handler,
@@ -2513,6 +2722,19 @@ static int bmp180_read_press(struct bmp280_data *data, u32 *comp_press)
 	return 0;
 }
 
+/* Keep compatibility with newer generations of the sensor */
+static int bmp180_set_mode(struct bmp280_data *data, enum bmp280_op_mode mode)
+{
+	return 0;
+}
+
+/* Keep compatibility with newer generations of the sensor */
+static int bmp180_wait_conv(struct bmp280_data *data)
+{
+	return 0;
+}
+
+/* Keep compatibility with newer generations of the sensor */
 static int bmp180_chip_config(struct bmp280_data *data)
 {
 	return 0;
@@ -2583,6 +2805,8 @@ const struct bmp280_chip_info bmp180_chip_info = {
 	.read_temp = bmp180_read_temp,
 	.read_press = bmp180_read_press,
 	.read_calib = bmp180_read_calib,
+	.set_mode = bmp180_set_mode,
+	.wait_conv = bmp180_wait_conv,
 
 	.trigger_handler = bmp180_trigger_handler,
 };
@@ -2635,6 +2859,7 @@ static int bmp280_buffer_preenable(struct iio_dev *indio_dev)
 	struct bmp280_data *data = iio_priv(indio_dev);
 
 	pm_runtime_get_sync(data->dev);
+	data->chip_info->set_mode(data, BMP280_NORMAL);
 
 	return 0;
 }
@@ -2805,6 +3030,10 @@ int bmp280_common_probe(struct device *dev,
 			return ret;
 	}
 
+	ret = data->chip_info->set_mode(data, BMP280_SLEEP);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set sleep mode\n");
+
 	/* Enable runtime PM */
 	pm_runtime_get_noresume(dev);
 	pm_runtime_set_active(dev);
@@ -2830,6 +3059,9 @@ static int bmp280_runtime_suspend(struct device *dev)
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmp280_data *data = iio_priv(indio_dev);
 
+	data->chip_info->set_mode(data, BMP280_SLEEP);
+
+	usleep_range(2500, 3000);
 	return regulator_bulk_disable(BMP280_NUM_SUPPLIES, data->supplies);
 }
 
@@ -2844,7 +3076,12 @@ static int bmp280_runtime_resume(struct device *dev)
 		return ret;
 
 	usleep_range(data->start_up_time, data->start_up_time + 100);
-	return data->chip_info->chip_config(data);
+
+	ret = data->chip_info->chip_config(data);
+	if (ret)
+		return ret;
+
+	return data->chip_info->set_mode(data, data->op_mode);
 }
 
 EXPORT_RUNTIME_DEV_PM_OPS(bmp280_dev_pm_ops, bmp280_runtime_suspend,
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 73516878d020..c9840b8d58b0 100644
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
@@ -424,6 +440,9 @@ struct bmp280_data {
 		s64 ts __aligned(8);
 	} buffer;
 
+	/* Value to hold the current operation mode of the device */
+	enum bmp280_op_mode op_mode;
+
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
@@ -488,6 +507,8 @@ struct bmp280_chip_info {
 	int (*read_humid)(struct bmp280_data *data, u32 *adc_humidity);
 	int (*read_calib)(struct bmp280_data *data);
 	int (*preinit)(struct bmp280_data *data);
+	int (*set_mode)(struct bmp280_data *data, enum bmp280_op_mode mode);
+	int (*wait_conv)(struct bmp280_data *data);
 
 	irqreturn_t (*trigger_handler)(int irq, void *p);
 };
-- 
2.25.1


