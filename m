Return-Path: <linux-iio+bounces-8851-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AC09632FE
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 22:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC8F1F23393
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 20:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453381AE85B;
	Wed, 28 Aug 2024 20:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWaBL9f/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32231AE032;
	Wed, 28 Aug 2024 20:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724878304; cv=none; b=P09dQqsCVLuA98Ry0l0uUiO5M3Crn6OkDx54VQE/npAFC/AY59mXlHSSdvcK1apGC3K1Nh1p8mw7ilWGezenvdF35qIRm09xk8myfy0pV/5Dpgs63nGNWw21Arl5/jyJjNpfze16mPBBEmuPscSY8PYxg4tbTf3QYTFn2x3VQ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724878304; c=relaxed/simple;
	bh=NuXoFwvSc7sE4whJmVtv/72jwN/VcygIviN91Xc6XsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cffUbaPftSO9frQbuxpx88QY8QpY4VPPru4pXJhp6j2AfHUe3sQelHl1Gj7LS2YL6wamPhKE0dHx5UpJ50uIG/5DvGJpsdSzNw99OD4Rt2NhGWWfa8WdMO/fz3uIRbxlUZ36tSYqg+pVDba84u9pxEWc/R0Nh7P7Dli9A1OnG2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWaBL9f/; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5bec87ececeso7937540a12.0;
        Wed, 28 Aug 2024 13:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724878300; x=1725483100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYhFTLY6b7f+AMAz39N+orsF7lbeZTKDiBczyC6En4Y=;
        b=HWaBL9f/6beTVz5aAVByL5NZn4MxHWDyz+uqY2pCWSmbKH/g5+4hngfnfwlSxD9lvY
         vjWgpX1nTXDc+PCZUvX4rQYOzpEcp9r/4hJqdQxQHQg+D2SDniFob0UjluqHhy1JEo0a
         F4nJy5C+9s6m6yTq+EL443pGhgAw551zN6mTpMFN7+mnDXGSpOksxZGWpLZJ5H1x8cnj
         Mq7RnNj8fJjsdZoNBY51cVfGne5cAYkRM03tiq+y4MM8M94Z6NXBY7b6gCfnDF+3J+5u
         Pyb9yoehCRY3XnC4CZSM4FyzLYb50WOQLDlpY8Hppe0LPFQ6DtWdeFFdE+xjAKCt4X40
         k6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724878300; x=1725483100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYhFTLY6b7f+AMAz39N+orsF7lbeZTKDiBczyC6En4Y=;
        b=XveIDuUpQPObztqZPe1UzCO9dg721FFfIOzE/yJ/hjnBXq3fJPtBbQ1hP38IrWUsEe
         0b++fMxjqdHmGXqgNbr6O9MNbhZfN1ObjznXIc2WlyWXGmn7aCNZe64AD/01Ol5QNIsf
         J5FPDNfM+mnMJElOGKnFft81tjXY6Nef/iUo3MlFvocrxgFmKGwmtM09e6UL+/bfPFmt
         +OBUxFXuEmnBoiXBR/FF/0TnwKdBG1KVBTBzRoNuJk1cEnSGd18tLN0+UmFp6JtEKodO
         Gww4yYu10AnNNiGukUt7vk114UaDO2QcsP/STo0Al9jP8hn62HNOSNSIIH2dsWFCP80s
         7Z3w==
X-Forwarded-Encrypted: i=1; AJvYcCVK65uEa5Qj6K3ylqZKpfz2UegeHzTSlSXMLkkObHmCODzQe326ZWgyqhXNqpCm5qBU/84MoMBCVedxERMx@vger.kernel.org, AJvYcCVXsFhPJdekhTQaxpySp1gUg92990N5R3xNgT9AeJxIMVT9cAoLAt0vSZUQ4YXn9uR6C8okVrdBzpy3@vger.kernel.org, AJvYcCWpY5HoTJ1MP27avTFrXzJfUvNJ36q5Ax3kdsbUqiErjroCNRBMYpN4r5RzNUIIIRSkNh7L23S1dhl4@vger.kernel.org
X-Gm-Message-State: AOJu0YzVV1pt5lOY8FDd+Q+A5qbAXLiXtuNriB41rfWSvF1gCL/c+7i9
	dc7xV6wnRD90C/Wg3b1wy6XqTIXG4wfZQpo4rTkSXd4ETaoiB13V
X-Google-Smtp-Source: AGHT+IHj8Zlz/50MX/gPQYnqyr7TSqnZE+01Wu7GkCSlraWov9R1l2BBQ1iw7jJY9Jmor8PGzCDbZA==
X-Received: by 2002:a05:6402:430f:b0:5c0:ad36:b38f with SMTP id 4fb4d7f45d1cf-5c21ed4e422mr501829a12.18.1724878299481;
        Wed, 28 Aug 2024 13:51:39 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4c6b:aa66:d4d1:a1d2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb1c2f53sm2646566a12.19.2024.08.28.13.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:51:39 -0700 (PDT)
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
Subject: [PATCH v4 4/7] iio: pressure: bmp280: Use sleep and forced mode for oneshot captures
Date: Wed, 28 Aug 2024 22:51:24 +0200
Message-Id: <20240828205128.92145-5-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240828205128.92145-1-vassilisamir@gmail.com>
References: <20240828205128.92145-1-vassilisamir@gmail.com>
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
 drivers/iio/pressure/bmp280-core.c | 294 ++++++++++++++++++++++++++---
 drivers/iio/pressure/bmp280.h      |  21 +++
 2 files changed, 294 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 2ca907771d42..e716bcb1dc96 100644
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
@@ -617,6 +622,14 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
 
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
@@ -646,6 +659,14 @@ static int bmp280_read_raw_impl(struct iio_dev *indio_dev,
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
@@ -994,6 +1015,70 @@ static int bmp280_preinit(struct bmp280_data *data)
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
+
+	/* Check if we are using a BME280 device */
+	if (data->oversampling_humid)
+		meas_time += BIT(data->oversampling_humid) * BMP280_MEAS_DUR +
+			       BMP280_PRESS_HUMID_MEAS_OFFSET;
+
+	/* Pressure measurement time */
+	meas_time += BIT(data->oversampling_press) * BMP280_MEAS_DUR +
+		      BMP280_PRESS_HUMID_MEAS_OFFSET;
+
+	/* Temperature measurement time */
+	meas_time += BIT(data->oversampling_temp) * BMP280_MEAS_DUR;
+
+	/* Waiting time according to the BM(P/E)2 Sensor API */
+	fsleep(meas_time);
+
+	ret = regmap_read(data->regmap, BMP280_REG_STATUS, &reg);
+	if (ret) {
+		dev_err(data->dev, "failed to read status register\n");
+		return ret;
+	}
+
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
@@ -1004,7 +1089,7 @@ static int bmp280_chip_config(struct bmp280_data *data)
 				BMP280_OSRS_TEMP_MASK |
 				BMP280_OSRS_PRESS_MASK |
 				BMP280_MODE_MASK,
-				osrs | BMP280_MODE_NORMAL);
+				osrs | BMP280_MODE_SLEEP);
 	if (ret) {
 		dev_err(data->dev, "failed to write ctrl_meas register\n");
 		return ret;
@@ -1111,6 +1196,8 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
 	.read_calib = bmp280_read_calib,
+	.set_mode = bmp280_set_mode,
+	.wait_conv = bmp280_wait_conv,
 	.preinit = bmp280_preinit,
 
 	.trigger_handler = bmp280_trigger_handler,
@@ -1232,6 +1319,8 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.read_press = bmp280_read_press,
 	.read_humid = bme280_read_humid,
 	.read_calib = bme280_read_calib,
+	.set_mode = bmp280_set_mode,
+	.wait_conv = bmp280_wait_conv,
 	.preinit = bmp280_preinit,
 
 	.trigger_handler = bme280_trigger_handler,
@@ -1519,6 +1608,71 @@ static int bmp380_preinit(struct bmp280_data *data)
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
+	meas_time += BIT(data->oversampling_press) * BMP380_MEAS_DUR +
+		      BMP380_PRESS_MEAS_OFFSET;
+
+	/* Temperature measurement time */
+	meas_time += BIT(data->oversampling_temp) * BMP380_MEAS_DUR +
+		      BMP380_TEMP_MEAS_OFFSET;
+
+	/* Measurement time defined in Datasheet Section 3.9.2 */
+	fsleep(meas_time);
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
@@ -1579,17 +1733,19 @@ static int bmp380_chip_config(struct bmp280_data *data)
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
+		 * According to the BMP3 Sensor API, the sensor needs 5000ms
+		 * in order to go to the sleep mode.
+		 */
+		fsleep(5000);
+
+		ret = bmp380_set_mode(data, BMP280_NORMAL);
 		if (ret) {
 			dev_err(data->dev, "failed to set normal mode\n");
 			return ret;
@@ -1615,6 +1771,17 @@ static int bmp380_chip_config(struct bmp280_data *data)
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
 
@@ -1708,6 +1875,8 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.read_temp = bmp380_read_temp,
 	.read_press = bmp380_read_press,
 	.read_calib = bmp380_read_calib,
+	.set_mode = bmp380_set_mode,
+	.wait_conv = bmp380_wait_conv,
 	.preinit = bmp380_preinit,
 
 	.trigger_handler = bmp380_trigger_handler,
@@ -2095,6 +2264,70 @@ static int bmp580_preinit(struct bmp280_data *data)
 	return PTR_ERR_OR_ZERO(devm_nvmem_register(config.dev, &config));
 }
 
+static const u8 bmp580_operation_mode[] = {
+	BMP580_MODE_SLEEP, BMP580_MODE_FORCED, BMP580_MODE_NORMAL,
+};
+
+static int bmp580_set_mode(struct bmp280_data *data, enum bmp280_op_mode mode)
+{
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
+			dev_err(data->dev,
+				"Could not flush IIR filter constants.\n");
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
+	 * characteristics.
+	 */
+	static const int time_conv_press[] = {
+		0, 1050, 1785, 3045, 5670, 10920, 21420, 42420, 84420
+	};
+
+	static const int time_conv_temp[] = {
+		0, 1050, 1105, 1575, 2205, 3465, 6090, 11340, 21840
+	};
+
+	int meas_time;
+
+	meas_time = 4 * USEC_PER_MSEC + time_conv_temp[data->oversampling_temp]
+		      + time_conv_press[data->oversampling_press];
+
+	/* Measurement time mentioned in Chapter 2, Table 4 of the datasheet. */
+	fsleep(meas_time);
+
+	return 0;
+}
+
 static int bmp580_chip_config(struct bmp280_data *data)
 {
 	bool change = false, aux;
@@ -2112,7 +2345,7 @@ static int bmp580_chip_config(struct bmp280_data *data)
 		return ret;
 	}
 	/* From datasheet's table 4: electrical characteristics */
-	usleep_range(2500, 3000);
+	fsleep(data->start_up_time + 500);
 
 	/* Set default DSP mode settings */
 	reg_val = FIELD_PREP(BMP580_DSP_COMP_MASK, BMP580_DSP_PRESS_TEMP_COMP_EN) |
@@ -2165,17 +2398,6 @@ static int bmp580_chip_config(struct bmp280_data *data)
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
@@ -2271,6 +2493,8 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.chip_config = bmp580_chip_config,
 	.read_temp = bmp580_read_temp,
 	.read_press = bmp580_read_press,
+	.set_mode = bmp580_set_mode,
+	.wait_conv = bmp580_wait_conv,
 	.preinit = bmp580_preinit,
 
 	.trigger_handler = bmp580_trigger_handler,
@@ -2518,6 +2742,19 @@ static int bmp180_read_press(struct bmp280_data *data, u32 *comp_press)
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
@@ -2588,6 +2825,8 @@ const struct bmp280_chip_info bmp180_chip_info = {
 	.read_temp = bmp180_read_temp,
 	.read_press = bmp180_read_press,
 	.read_calib = bmp180_read_calib,
+	.set_mode = bmp180_set_mode,
+	.wait_conv = bmp180_wait_conv,
 
 	.trigger_handler = bmp180_trigger_handler,
 };
@@ -2640,6 +2879,7 @@ static int bmp280_buffer_preenable(struct iio_dev *indio_dev)
 	struct bmp280_data *data = iio_priv(indio_dev);
 
 	pm_runtime_get_sync(data->dev);
+	data->chip_info->set_mode(data, BMP280_NORMAL);
 
 	return 0;
 }
@@ -2810,6 +3050,10 @@ int bmp280_common_probe(struct device *dev,
 			return ret;
 	}
 
+	ret = data->chip_info->set_mode(data, BMP280_SLEEP);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set sleep mode\n");
+
 	/* Enable runtime PM */
 	pm_runtime_get_noresume(dev);
 	pm_runtime_set_active(dev);
@@ -2835,6 +3079,9 @@ static int bmp280_runtime_suspend(struct device *dev)
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmp280_data *data = iio_priv(indio_dev);
 
+	data->chip_info->set_mode(data, BMP280_SLEEP);
+
+	usleep_range(2500, 3000);
 	return regulator_bulk_disable(BMP280_NUM_SUPPLIES, data->supplies);
 }
 
@@ -2849,7 +3096,12 @@ static int bmp280_runtime_resume(struct device *dev)
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


