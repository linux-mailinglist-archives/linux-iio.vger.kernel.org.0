Return-Path: <linux-iio+bounces-9475-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4A297759D
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 01:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E95A281F3E
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 23:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B3B1C3F18;
	Thu, 12 Sep 2024 23:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LX5QAHFp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0791C2DC6;
	Thu, 12 Sep 2024 23:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183966; cv=none; b=srNSbVJGGEU+5ovwgicq5hIKXWaPTEkKA9vpZZEyJr5KN9rYcX8OqZv9tNa80LEIotJHQYb2Fgc6wGrmLH3l9nn9+QMCMBbyoAXD3KrTsxDdxAPZ2qeBL8ORYxnXZ6fSvXp2NbHQAZBQtBdwLGRiQ5yM5qZAR4Kx+/vKpK9cq/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183966; c=relaxed/simple;
	bh=BgIiCofC3RaGzUum7qBwbqVJXuYfDxgH2+7j6Glr94g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l4f3paARU83ZHgfWXmTft8k+sllAPVLfcqTAxRjRcTyUJ6JWObifR6NBE/hhP9/+Q/g7MnZ9vo0PW6oC9lwckwEh295bJg7yMxXs2Q0rJ9gohRIcS8CIcIVu9PwZSKswi0Jvg7gFYxaSWenZZEeKGIfuSGkTVMJJId0i0Zo5DFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LX5QAHFp; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3770320574aso1072526f8f.2;
        Thu, 12 Sep 2024 16:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726183962; x=1726788762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ECxjLgS4v5RwRS/ciOtp4sRRcnbKzclwEX21qyNZC78=;
        b=LX5QAHFpqhHpvbm6HE888kfEZ0jdLfMtQZ5FU39LZlFfAImFxL+mMQxNsYEIGukM7h
         cpfQLStRbaCAS1egTt+kC+1o8LLtag6s/LzsdHU93rk+oCnMWuTnMwXWsXAFK/cLBCVh
         HChU6zd5w+9g/jCyS6AgT/TaB8oI4EwSrQYv/JCnp9HZggIRaUUeF1bxMSuSkAWm6kDc
         bouoFgwHNaBhExg30O5EhAOn9aQvgSU+qVNehVjFRr+tiXyQj0U70izghWhrhleTWNLZ
         6pSghPYhrWE1fW+Z3eJFBDFVjmWBP6f8EPkRfgVGpRp5PAA9++oNepwI7rDNoSIxuWJe
         aqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726183962; x=1726788762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ECxjLgS4v5RwRS/ciOtp4sRRcnbKzclwEX21qyNZC78=;
        b=uQRRaw7hXD+ZXeD65vRINdtKgWo3QRwuf92DajgA7aMEF7mdgxyO0rhTSKzvQ3tDPH
         qTZL8zxFVqyzCvqJvtp9pmsRSYovg3DFfk8wFPTK9IXCwwhfX8d/iRuMDZN3vzxrxuD+
         7mQIF4a/nTLdotq+cDaJeQDS3GPRBTU+B9NSLH++kNVMcAN7qeTQWsuC5hSxUrysMLwp
         kF/ifG0V5xhrs1mijSsmKOY7BG2oKw3tx7Y1iO2F2Kc7YmDs4yqxcgwJhTAbhLYQahQd
         ZEK6M1r9u58oQuanTmlD9umtAmyTE3R7HBMgZb7Y2H7HL4GTldiGYjgUJU38YZ0/u16K
         kyBw==
X-Forwarded-Encrypted: i=1; AJvYcCU1QqrI6Kr1Tb2ZuPEPi3tzfxAdMQnB81q82EszXljMKbBbK6RUuaezpDiYXpiwOoJI8a2KsDG1NxHx@vger.kernel.org, AJvYcCUUxGEP5R9T1+NvoDY+JD51S+Et1jS+bn8M2HHpFv1P4DIJ+uHI6FS+tOlBchQpUnWx4wSuI8UhTXxW@vger.kernel.org, AJvYcCUWc3c50/Qpu9EH418ZFHbtcpYwkJ1PSlvI89I2j/Z+lg5PlakhKI7QNjF4KghOz1P3wepia5kFq3YAxJNb@vger.kernel.org
X-Gm-Message-State: AOJu0YwqSN5kQ5ZyVgCiFv0/11NwKkhdEjEN2RFZivbZVxx1aRiFAvRG
	JbIuWIByzvmNNBsjTYwsZqjs8BMSRNjBS84NLSUORpH2AJ1vXuxF
X-Google-Smtp-Source: AGHT+IEZh82wFVycml57sYW9EjDH75PLAm/6vq9KmyEIKeo67tEiWrsneBpFonvrf1Pco33KUqgBRA==
X-Received: by 2002:a5d:670c:0:b0:368:6ab:ba69 with SMTP id ffacd0b85a97d-378c2d11947mr2761845f8f.28.1726183961979;
        Thu, 12 Sep 2024 16:32:41 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:85e4:cf41:16db:65d5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c421aab306sm26693a12.73.2024.09.12.16.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 16:32:41 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: [PATCH v6 1/4] iio: pressure: bmp280: Use sleep and forced mode for oneshot captures
Date: Fri, 13 Sep 2024 01:32:31 +0200
Message-Id: <20240912233234.45519-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240912233234.45519-1-vassilisamir@gmail.com>
References: <20240912233234.45519-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add forced mode support in sensors BMP28x, BME28x, BMP3xx and BMP58x.
Sensors BMP18x and BMP085 are old and do not support this feature so
their operation is not affected at all.

Essentially, up to now, the rest of the sensors were used in normal mode
all the time. This means that they are continuously doing measurements
even though these measurements are not used. Even though the sensor does
provide PM support, to cover all the possible use cases, the sensor needs
to go into sleep mode and wake up whenever necessary.

The idea is that the sensor is by default in sleep mode, wakes up in
forced mode when a oneshot capture is requested, or in normal mode
when the buffer is enabled. The difference lays in the fact that in
forced mode, the sensor does only one conversion and goes back to sleep
while in normal mode, the sensor does continuous measurements with the
frequency that was set in the ODR registers.

The bmpX_chip_config() functions which are responsible for applying
the requested configuration to the sensor, are modified accordingly
in order to set the sensor by default in sleep mode.

DEEP STANDBY, Low Power NORMAL and CONTINUOUS modes, supported only by
the BMP58x version, are not added.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 296 +++++++++++++++++++++++++++--
 drivers/iio/pressure/bmp280.h      |  21 ++
 2 files changed, 296 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 6d7a9bd6e761..8c87f7ef28c9 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -16,6 +16,11 @@
  * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp390-ds002.pdf
  * https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmp581-ds004.pdf
  *
+ * Sensor API:
+ * https://github.com/boschsensortec/BME280_SensorAPI
+ * https://github.com/boschsensortec/BMP3_SensorAPI
+ * https://github.com/boschsensortec/BMP5_SensorAPI
+ *
  * Notice:
  * The link to the bmp180 datasheet points to an outdated version missing these changes:
  * - Changed document referral from ANP015 to BST-MPS-AN004-00 on page 26
@@ -616,6 +621,14 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 
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
@@ -645,6 +658,14 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
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
@@ -991,6 +1012,69 @@ static int bmp280_preinit(struct bmp280_data *data)
 	return 0;
 }
 
+static const u8 bmp280_operation_mode[] = {
+	BMP280_MODE_SLEEP, BMP280_MODE_FORCED, BMP280_MODE_NORMAL,
+};
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
+		dev_err(data->dev, "failed to  write ctrl_meas register.\n");
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
+	unsigned int reg, meas_time_us;
+	int ret;
+
+	/* Check if we are using a BME280 device */
+	if (data->oversampling_humid)
+		meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
+				BIT(data->oversampling_humid) * BMP280_MEAS_DUR;
+
+	/* Pressure measurement time */
+	meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
+			BIT(data->oversampling_press) * BMP280_MEAS_DUR;
+
+	/* Temperature measurement time */
+	meas_time_us += BIT(data->oversampling_temp) * BMP280_MEAS_DUR;
+
+	/* Waiting time according to the BM(P/E)2 Sensor API */
+	fsleep(meas_time_us);
+
+	ret = regmap_read(data->regmap, BMP280_REG_STATUS, &reg);
+	if (ret) {
+		dev_err(data->dev, "failed to read status register.\n");
+		return ret;
+	}
+
+	if (reg & BMP280_REG_STATUS_MEAS_BIT) {
+		dev_err(data->dev, "Measurement cycle didn't complete.\n");
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 static int bmp280_chip_config(struct bmp280_data *data)
 {
 	u8 osrs = FIELD_PREP(BMP280_OSRS_TEMP_MASK, data->oversampling_temp + 1) |
@@ -1001,7 +1085,7 @@ static int bmp280_chip_config(struct bmp280_data *data)
 				BMP280_OSRS_TEMP_MASK |
 				BMP280_OSRS_PRESS_MASK |
 				BMP280_MODE_MASK,
-				osrs | BMP280_MODE_NORMAL);
+				osrs | BMP280_MODE_SLEEP);
 	if (ret) {
 		dev_err(data->dev, "failed to write ctrl_meas register\n");
 		return ret;
@@ -1108,6 +1192,8 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
 	.read_calib = bmp280_read_calib,
+	.set_mode = bmp280_set_mode,
+	.wait_conv = bmp280_wait_conv,
 	.preinit = bmp280_preinit,
 
 	.trigger_handler = bmp280_trigger_handler,
@@ -1229,6 +1315,8 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.read_press = bmp280_read_press,
 	.read_humid = bme280_read_humid,
 	.read_calib = bme280_read_calib,
+	.set_mode = bmp280_set_mode,
+	.wait_conv = bmp280_wait_conv,
 	.preinit = bmp280_preinit,
 
 	.trigger_handler = bme280_trigger_handler,
@@ -1516,6 +1604,71 @@ static int bmp380_preinit(struct bmp280_data *data)
 	return bmp380_cmd(data, BMP380_CMD_SOFT_RESET);
 }
 
+static const u8 bmp380_operation_mode[] = {
+	BMP380_MODE_SLEEP, BMP380_MODE_FORCED, BMP380_MODE_NORMAL,
+};
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
+		dev_err(data->dev, "failed to  write power control register.\n");
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
+	int ret, meas_time_us;
+
+	/* Offset measurement time */
+	meas_time_us = BMP380_MEAS_OFFSET;
+
+	/* Pressure measurement time */
+	meas_time_us += BMP380_PRESS_MEAS_OFFSET +
+		     BIT(data->oversampling_press) * BMP380_MEAS_DUR;
+
+	/* Temperature measurement time */
+	meas_time_us += BMP380_TEMP_MEAS_OFFSET +
+		     BIT(data->oversampling_temp) * BMP380_MEAS_DUR;
+
+	/* Measurement time defined in Datasheet Section 3.9.2 */
+	fsleep(meas_time_us);
+
+	ret = regmap_read(data->regmap, BMP380_REG_STATUS, &reg);
+	if (ret) {
+		dev_err(data->dev, "failed to read status register.\n");
+		return ret;
+	}
+
+	if (!((reg & BMP380_STATUS_DRDY_PRESS_MASK) &&
+	    (reg & BMP380_STATUS_DRDY_TEMP_MASK))) {
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
@@ -1576,17 +1729,19 @@ static int bmp380_chip_config(struct bmp280_data *data)
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
+		/*
+		 * According to the BMP3 Sensor API, the sensor needs 5000us
+		 * in order to go to the sleep mode.
+		 */
+		fsleep(5000);
+
+		ret = bmp380_set_mode(data, BMP280_NORMAL);
 		if (ret) {
 			dev_err(data->dev, "failed to set normal mode\n");
 			return ret;
@@ -1612,7 +1767,16 @@ static int bmp380_chip_config(struct bmp280_data *data)
 		}
 	}
 
-	return 0;
+	/* Dummy read to empty data registers. */
+	ret = bmp380_read_press(data, &tmp);
+	if (ret)
+		return ret;
+
+	ret = bmp380_set_mode(data, BMP280_SLEEP);
+	if (ret)
+		dev_err(data->dev, "failed to set sleep mode.\n");
+
+	return ret;
 }
 
 static irqreturn_t bmp380_trigger_handler(int irq, void *p)
@@ -1705,6 +1869,8 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.read_temp = bmp380_read_temp,
 	.read_press = bmp380_read_press,
 	.read_calib = bmp380_read_calib,
+	.set_mode = bmp380_set_mode,
+	.wait_conv = bmp380_wait_conv,
 	.preinit = bmp380_preinit,
 
 	.trigger_handler = bmp380_trigger_handler,
@@ -2092,6 +2258,75 @@ static int bmp580_preinit(struct bmp280_data *data)
 	return PTR_ERR_OR_ZERO(devm_nvmem_register(config.dev, &config));
 }
 
+static const u8 bmp580_operation_mode[] = {
+	BMP580_MODE_SLEEP, BMP580_MODE_FORCED, BMP580_MODE_NORMAL,
+};
+
+static int bmp580_set_mode(struct bmp280_data *data, enum bmp280_op_mode mode)
+{
+	struct device *dev = data->dev;
+	int ret;
+
+	switch (mode) {
+	case BMP280_SLEEP:
+	case BMP280_NORMAL:
+		break;
+	case BMP280_FORCED:
+		ret = regmap_set_bits(data->regmap, BMP580_REG_DSP_CONFIG,
+				      BMP580_DSP_IIR_FORCED_FLUSH);
+		if (ret) {
+			dev_err(dev, "Could not flush IIR filter constants.\n");
+			return ret;
+		}
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
+		dev_err(dev, "failed to  write power control register.\n");
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
+	 * characteristics.
+	 */
+	static const int time_conv_press[] = {
+		0, 1050, 1785, 3045, 5670, 10920, 21420, 42420,
+		84420,
+	};
+	static const int time_conv_temp[] = {
+		0, 1050, 1105, 1575, 2205, 3465, 6090, 11340,
+		21840,
+	};
+	int meas_time_us;
+
+	meas_time_us = 4 * USEC_PER_MSEC +
+		       time_conv_temp[data->oversampling_temp] +
+		       time_conv_press[data->oversampling_press];
+
+	/*
+	 * Measurement time mentioned in Chapter 2, Table 4 of the datasheet.
+	 * The extra 4ms is the required mode change to start of measurement
+	 * time.
+	 */
+	fsleep(meas_time_us);
+
+	return 0;
+}
+
 static int bmp580_chip_config(struct bmp280_data *data)
 {
 	bool change = false, aux;
@@ -2162,17 +2397,6 @@ static int bmp580_chip_config(struct bmp280_data *data)
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
@@ -2268,6 +2492,8 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.chip_config = bmp580_chip_config,
 	.read_temp = bmp580_read_temp,
 	.read_press = bmp580_read_press,
+	.set_mode = bmp580_set_mode,
+	.wait_conv = bmp580_wait_conv,
 	.preinit = bmp580_preinit,
 
 	.trigger_handler = bmp580_trigger_handler,
@@ -2515,6 +2741,19 @@ static int bmp180_read_press(struct bmp280_data *data, u32 *comp_press)
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
@@ -2585,6 +2824,8 @@ const struct bmp280_chip_info bmp180_chip_info = {
 	.read_temp = bmp180_read_temp,
 	.read_press = bmp180_read_press,
 	.read_calib = bmp180_read_calib,
+	.set_mode = bmp180_set_mode,
+	.wait_conv = bmp180_wait_conv,
 
 	.trigger_handler = bmp180_trigger_handler,
 };
@@ -2637,6 +2878,7 @@ static int bmp280_buffer_preenable(struct iio_dev *indio_dev)
 	struct bmp280_data *data = iio_priv(indio_dev);
 
 	pm_runtime_get_sync(data->dev);
+	data->chip_info->set_mode(data, BMP280_NORMAL);
 
 	return 0;
 }
@@ -2807,6 +3049,10 @@ int bmp280_common_probe(struct device *dev,
 			return ret;
 	}
 
+	ret = data->chip_info->set_mode(data, BMP280_SLEEP);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set sleep mode\n");
+
 	/* Enable runtime PM */
 	pm_runtime_get_noresume(dev);
 	pm_runtime_set_active(dev);
@@ -2832,6 +3078,9 @@ static int bmp280_runtime_suspend(struct device *dev)
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmp280_data *data = iio_priv(indio_dev);
 
+	data->chip_info->set_mode(data, BMP280_SLEEP);
+
+	fsleep(data->start_up_time);
 	return regulator_bulk_disable(BMP280_NUM_SUPPLIES, data->supplies);
 }
 
@@ -2846,7 +3095,12 @@ static int bmp280_runtime_resume(struct device *dev)
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


