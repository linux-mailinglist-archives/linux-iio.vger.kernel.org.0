Return-Path: <linux-iio+bounces-9024-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AB7968DBF
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 20:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F8C1F21021
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 18:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5807F2139B0;
	Mon,  2 Sep 2024 18:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wu0UtBXS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C166B205E16;
	Mon,  2 Sep 2024 18:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725302555; cv=none; b=hJ1A25fe5T/+2e7wREpKq0tsaEp9hR12wEPBMLSWBs7FlpoTRSD7gZyFXLO6FIBwY25pYyrhriCW85Lev1AUcwaUU6WLIsUqFxUpXVSdAAoy+eDL3LrlIcQgTSt/r76bVJXH2c+UhWn/SPR6aIoj2VKfD001pcS+qrsChto1Wpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725302555; c=relaxed/simple;
	bh=sI6iMkj20cGbAs8qslhqSpRCc1EK8UHgB/LCX+GhGI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hb1hk6sUBJK8F4QD3hJ78xGfgfoOCWayCBOGh1wU9wwEo8osseD7e8i5eh28rYPy6wN2YwDV8cJ6pMzRaQ2dMpZYa1jhThWavw7DakNN1OdDZS01SS2MfA0rsB2w2UlDhkn5mFanpblG91/FRdmw/EpQ3xRH2O12v6RfyuLhJYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wu0UtBXS; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-534366c194fso4114739e87.0;
        Mon, 02 Sep 2024 11:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725302551; x=1725907351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2TyNBQeitR3XYQX6NhBJE8FJuK2K2Pq4PAQRZivBC8=;
        b=Wu0UtBXS7ZE0l8IHLThSFHEoCZRU2+NwVUa+MWa49+lwY/Fc4Jz1/VuCROtE16lEoi
         J2aXpUYNLAo43a0s6APjlT5HM14Vdvh7hnH3PKWhnQ3AI0xsd/RHjwTENBiWj4bArngf
         wmxOxD7qdGbScJnziRv34CgZbrtQMoeAF/YWlVWDz6eJhmFC9cs1JaNq+4kg0cTW6Frs
         F9+v3ehQfw9aKkkYeUL4JxHyJP/FUPC9/heWggJPBMfoZZbKR8o5PMlB5Ri1ZWybsyfP
         8c4Q2wUiPbDpeayDwvBYXi6AqCcVCC5WoT90xTYKtPhjoRy26+MOcJJjs1H1sdN1s6/L
         lUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725302551; x=1725907351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2TyNBQeitR3XYQX6NhBJE8FJuK2K2Pq4PAQRZivBC8=;
        b=MSBItsO8fLalIUoXGkUDM7UfNYRGrSI2Y5DDWk0xm4Q3OvFZHGVojpQpWeqOuSMmuN
         E4Nop59zbdHEpLhmdAAyt/OW63aMgav+IeX5afMzu+qchMnuwVxI7Z21Y4RWLqQ6QbpP
         xadgZ2yGs2A7z+YsRDsg2GHqCJR3FK4+6fDwIXRKhRQFNGMkMl61TuLIyWjbpLak4aD1
         kXwhl4jdfmp1b0ezroPBVYJ46Y6c9Iu1m6FnMxDfUWFJTg7jPE030oyr04bnS9v7IQez
         yh+NLXmdUcZ0Xf5+QmZYyjb8jx4tf75TFHycd4w+36v2XC0Icp+ZNfsbc4Rrs6r77Utq
         OWLg==
X-Forwarded-Encrypted: i=1; AJvYcCVKGqB+xdzAzAD2Ax0YqU7bdKZxD0Avu/jthNfGUfYXxe7+T2V0wDKcm/SW297fwHDABc+Hypu9EW+F@vger.kernel.org, AJvYcCW2n+Lk+kByeiDTDqMi3lez4WrVy9RpAw8oYfDGbfhMirTIO5uFo/HZxpFH4kMYqiZ1W0oSGK4NvCLkMNC1@vger.kernel.org, AJvYcCXjySGqahV0nchK8laf1iU7IuoDQNWo08z2IrrYQO85rse3ppwalNRdbtjfaAdUMRz8wWkQkTgzeeb5@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+fJRtfiBtdWC3zaMnf3dYWR3UwlPwAoTmGw9xZGANsDWy7o89
	6B1ecVl4c+T/EhIRZGlYzTCc+SipNOK7R+oIpAo2/CGPjbC+cpEl
X-Google-Smtp-Source: AGHT+IFd45jwcTjneTVYvr2DbIkbE+GOyxpG/xYKfnGIBhcM3z2w08F2r/G2oqQ8Jr+bPH5eSD32hQ==
X-Received: by 2002:a05:6512:3a8a:b0:530:c1fb:5192 with SMTP id 2adb3069b0e04-53546b335b3mr8002292e87.16.1725302550025;
        Mon, 02 Sep 2024 11:42:30 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:bc14:b544:1196:d1a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898900ec0asm590537966b.53.2024.09.02.11.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 11:42:29 -0700 (PDT)
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
Subject: [PATCH v5 4/7] iio: pressure: bmp280: Use sleep and forced mode for oneshot captures
Date: Mon,  2 Sep 2024 20:42:19 +0200
Message-Id: <20240902184222.24874-5-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902184222.24874-1-vassilisamir@gmail.com>
References: <20240902184222.24874-1-vassilisamir@gmail.com>
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
 drivers/iio/pressure/bmp280-core.c | 291 +++++++++++++++++++++++++++--
 drivers/iio/pressure/bmp280.h      |  21 +++
 2 files changed, 292 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index ba77c428042d..b8a55de78616 100644
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
+				(BIT(data->oversampling_humid) * BMP280_MEAS_DUR);
+
+	/* Pressure measurement time */
+	meas_time_us += BMP280_PRESS_HUMID_MEAS_OFFSET +
+			(BIT(data->oversampling_press) * BMP280_MEAS_DUR);
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
+		     (BIT(data->oversampling_press) * BMP380_MEAS_DUR);
+
+	/* Temperature measurement time */
+	meas_time_us += BMP380_TEMP_MEAS_OFFSET +
+		     (BIT(data->oversampling_temp) * BMP380_MEAS_DUR);
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
@@ -1612,6 +1767,17 @@ static int bmp380_chip_config(struct bmp280_data *data)
 		}
 	}
 
+	/* Dummy read to empty data registers. */
+	ret = bmp380_read_press(data, &tmp);
+	if (ret)
+		return ret;
+
+	ret = bmp380_set_mode(data, BMP280_SLEEP);
+	if (ret) {
+		dev_err(data->dev, "failed to set sleep mode.\n");
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -1705,6 +1871,8 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.read_temp = bmp380_read_temp,
 	.read_press = bmp380_read_press,
 	.read_calib = bmp380_read_calib,
+	.set_mode = bmp380_set_mode,
+	.wait_conv = bmp380_wait_conv,
 	.preinit = bmp380_preinit,
 
 	.trigger_handler = bmp380_trigger_handler,
@@ -2092,6 +2260,70 @@ static int bmp580_preinit(struct bmp280_data *data)
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
+	meas_time_us = 4 * USEC_PER_MSEC + time_conv_temp[data->oversampling_temp]
+			 + time_conv_press[data->oversampling_press];
+
+	/* Measurement time mentioned in Chapter 2, Table 4 of the datasheet. */
+	fsleep(meas_time_us);
+
+	return 0;
+}
+
 static int bmp580_chip_config(struct bmp280_data *data)
 {
 	bool change = false, aux;
@@ -2162,17 +2394,6 @@ static int bmp580_chip_config(struct bmp280_data *data)
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
@@ -2268,6 +2489,8 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.chip_config = bmp580_chip_config,
 	.read_temp = bmp580_read_temp,
 	.read_press = bmp580_read_press,
+	.set_mode = bmp580_set_mode,
+	.wait_conv = bmp580_wait_conv,
 	.preinit = bmp580_preinit,
 
 	.trigger_handler = bmp580_trigger_handler,
@@ -2515,6 +2738,19 @@ static int bmp180_read_press(struct bmp280_data *data, u32 *comp_press)
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
@@ -2585,6 +2821,8 @@ const struct bmp280_chip_info bmp180_chip_info = {
 	.read_temp = bmp180_read_temp,
 	.read_press = bmp180_read_press,
 	.read_calib = bmp180_read_calib,
+	.set_mode = bmp180_set_mode,
+	.wait_conv = bmp180_wait_conv,
 
 	.trigger_handler = bmp180_trigger_handler,
 };
@@ -2637,6 +2875,7 @@ static int bmp280_buffer_preenable(struct iio_dev *indio_dev)
 	struct bmp280_data *data = iio_priv(indio_dev);
 
 	pm_runtime_get_sync(data->dev);
+	data->chip_info->set_mode(data, BMP280_NORMAL);
 
 	return 0;
 }
@@ -2807,6 +3046,10 @@ int bmp280_common_probe(struct device *dev,
 			return ret;
 	}
 
+	ret = data->chip_info->set_mode(data, BMP280_SLEEP);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set sleep mode\n");
+
 	/* Enable runtime PM */
 	pm_runtime_get_noresume(dev);
 	pm_runtime_set_active(dev);
@@ -2832,6 +3075,9 @@ static int bmp280_runtime_suspend(struct device *dev)
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmp280_data *data = iio_priv(indio_dev);
 
+	data->chip_info->set_mode(data, BMP280_SLEEP);
+
+	fsleep(data->start_up_time + 500);
 	return regulator_bulk_disable(BMP280_NUM_SUPPLIES, data->supplies);
 }
 
@@ -2846,7 +3092,12 @@ static int bmp280_runtime_resume(struct device *dev)
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


