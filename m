Return-Path: <linux-iio+bounces-10302-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC34B9937A5
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 21:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9761F23557
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 19:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D62B13698F;
	Mon,  7 Oct 2024 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2mHYAhT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ED51DE3A0;
	Mon,  7 Oct 2024 19:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728330608; cv=none; b=o4JTMGqKCbFHqcIUF7tmKbsHtnvJ4SN3huSzZdl8o+XD8BZJpHn/yzFMK5U77JCU76kpDUFQDcDwArnWiqRPevoWfVQKLXqfT2fqC5efufJQau/wua+aZDhzDAq5RZz2vaSDi/IPpI7hJolCJt+HSqFQ8yZZRgetyKfVshy0jew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728330608; c=relaxed/simple;
	bh=e5aqQiWYjqFkKWJWIUPCPnYaXADocIOOVQXxCIqkaCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MTqVcUNA9ZDZMJ8NTJMgAKpXqONmw1wC8NkGE7MsMBt3Oshu4FC8Z2RfuZUVJUFRVEuw2GvT7qdYfsUMUxQVAXMuG/AZTFERJdytqTaSJgfR9OIHxiP2nfpjAP+V/S5l9tt9rG1RWCv/DCDuAeORaZuTPHN73xzK6TFakJQ8VlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2mHYAhT; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cba6cdf32so49100875e9.1;
        Mon, 07 Oct 2024 12:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728330603; x=1728935403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBviQl+xMENFFhO5gRANysmLURmvqeJEfybZSgzUTSI=;
        b=X2mHYAhTGdA8uAhU+LtxeHFxvyTgeneSvb9JdmWWZ/ZIhELXtTU6NiCeezi8CiGkXS
         am7bShzefUGPnuI+518qX3nePOhB2ee0yW1oxSmDxfAflQPI2FLf2SxLR1IaoHsA+7KX
         TJ2ehaRK5vd0B302KbkR8p9BPVSizt8lcNJJFmQANNQ8Fp4pXAFEfqYX8LPxNPCpWOhG
         6Eqi+oy6ncb03EeWIRX3alw3ohsFMy2q3J/OMdQC6ILjuwj6J0m+bqnYuVkN/iwVh3Op
         4ptXFuvvKMlOeclCnCK1nAa90n8593wCfucQlEwQzzjgFBx3FbKwujAQaUC6emFfl60j
         Skew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728330603; x=1728935403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBviQl+xMENFFhO5gRANysmLURmvqeJEfybZSgzUTSI=;
        b=DWyq0xQ/Sd3MWeoSINrWepJHJHBwvUsyn0FLUr9cGouvXKEol2/ikjXil8ygbXzXan
         f0cghWZGw01GtB8m/5I95mY8SqJe5rcN1A3gukX0F3hBuFO5of5xxIRbN/n4hQgzk/+z
         ntEkBypYquKgfqAAs8bFfOKjUZy7RlpCcYkPo5lxXeIZlUAtnutyzUcKQ0+zQ1rolchk
         lN3buwqLHZsVMA250SOtwFDfrbHKAWIKZCgBWrfiyTrFa7t3MKDTp7uslza+9aXUDxpG
         nyzyTME7xViMPmAWqIg8x5wiF/KVOH6G5erztDssosmIOD4SE/pUkZQDMJ27KkdqT7Vi
         yCZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWF0yYEZyNGZY6Ogu/E0lUlS0YQ1aUhNB+/0DraLqndgB50PkfH1CTWMc/Pi+Vza5nnsoLWauSB8v1@vger.kernel.org, AJvYcCUwr36xUVjZF2T6K3QHRalPFk5o0goWi/Sy9EDi+dWi9qMCtZdi3sxZfEFSUKnpy2sW0gwLNc33iG0R@vger.kernel.org, AJvYcCVYVfKOTLxI56JYkhc8AQ5iVB0QnQ9xgmDG299egW7xkvOOqZJXnvbo2bb2cqhGvVBMBoUUtqZ4mNW6UyMe@vger.kernel.org
X-Gm-Message-State: AOJu0YwP3rdJGNMgkNO42E2M3NvppUg6zo7JvttXOTz8mUdPECcpBTSy
	zNyrnHvZ4vpaghnX5C6ElShM4dJ2PyXkL543Mzw7vbajXZML5BqT
X-Google-Smtp-Source: AGHT+IHQf5iY4kGMDZZk2O0y38CZ3F1cqzhCn7Nysea5JU0X8GD99x3NLuYPUar+6riJmLwMxTN/ZA==
X-Received: by 2002:a05:600c:44d6:b0:42c:c401:6d86 with SMTP id 5b1f17b1804b1-42f85aea06fmr92311005e9.27.1728330603049;
        Mon, 07 Oct 2024 12:50:03 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:b658:eac0:bb05:9042])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ed922esm84939655e9.39.2024.10.07.12.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 12:50:02 -0700 (PDT)
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
Subject: [PATCH v8 1/4] iio: pressure: bmp280: Use sleep and forced mode for oneshot captures
Date: Mon,  7 Oct 2024 21:49:42 +0200
Message-Id: <20241007194945.66192-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241007194945.66192-1-vassilisamir@gmail.com>
References: <20241007194945.66192-1-vassilisamir@gmail.com>
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

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 296 +++++++++++++++++++++++++++--
 drivers/iio/pressure/bmp280.h      |  21 ++
 2 files changed, 296 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 6811619c6f11..9ad29cf4c2ac 100644
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
@@ -1111,6 +1195,8 @@ const struct bmp280_chip_info bmp280_chip_info = {
 	.read_temp = bmp280_read_temp,
 	.read_press = bmp280_read_press,
 	.read_calib = bmp280_read_calib,
+	.set_mode = bmp280_set_mode,
+	.wait_conv = bmp280_wait_conv,
 	.preinit = bmp280_preinit,
 
 	.trigger_handler = bmp280_trigger_handler,
@@ -1235,6 +1321,8 @@ const struct bmp280_chip_info bme280_chip_info = {
 	.read_press = bmp280_read_press,
 	.read_humid = bme280_read_humid,
 	.read_calib = bme280_read_calib,
+	.set_mode = bmp280_set_mode,
+	.wait_conv = bmp280_wait_conv,
 	.preinit = bmp280_preinit,
 
 	.trigger_handler = bme280_trigger_handler,
@@ -1522,6 +1610,71 @@ static int bmp380_preinit(struct bmp280_data *data)
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
+	      (reg & BMP380_STATUS_DRDY_TEMP_MASK))) {
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
@@ -1582,17 +1735,19 @@ static int bmp380_chip_config(struct bmp280_data *data)
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
+		 * According to the BMP3 Sensor API, the sensor needs 5ms
+		 * in order to go to the sleep mode.
+		 */
+		fsleep(5 * USEC_PER_MSEC);
+
+		ret = bmp380_set_mode(data, BMP280_NORMAL);
 		if (ret) {
 			dev_err(data->dev, "failed to set normal mode\n");
 			return ret;
@@ -1618,7 +1773,16 @@ static int bmp380_chip_config(struct bmp280_data *data)
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
@@ -1714,6 +1878,8 @@ const struct bmp280_chip_info bmp380_chip_info = {
 	.read_temp = bmp380_read_temp,
 	.read_press = bmp380_read_press,
 	.read_calib = bmp380_read_calib,
+	.set_mode = bmp380_set_mode,
+	.wait_conv = bmp380_wait_conv,
 	.preinit = bmp380_preinit,
 
 	.trigger_handler = bmp380_trigger_handler,
@@ -2101,6 +2267,75 @@ static int bmp580_preinit(struct bmp280_data *data)
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
@@ -2171,17 +2406,6 @@ static int bmp580_chip_config(struct bmp280_data *data)
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
@@ -2279,6 +2503,8 @@ const struct bmp280_chip_info bmp580_chip_info = {
 	.chip_config = bmp580_chip_config,
 	.read_temp = bmp580_read_temp,
 	.read_press = bmp580_read_press,
+	.set_mode = bmp580_set_mode,
+	.wait_conv = bmp580_wait_conv,
 	.preinit = bmp580_preinit,
 
 	.trigger_handler = bmp580_trigger_handler,
@@ -2526,6 +2752,19 @@ static int bmp180_read_press(struct bmp280_data *data, u32 *comp_press)
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
@@ -2597,6 +2836,8 @@ const struct bmp280_chip_info bmp180_chip_info = {
 	.read_temp = bmp180_read_temp,
 	.read_press = bmp180_read_press,
 	.read_calib = bmp180_read_calib,
+	.set_mode = bmp180_set_mode,
+	.wait_conv = bmp180_wait_conv,
 
 	.trigger_handler = bmp180_trigger_handler,
 };
@@ -2649,6 +2890,7 @@ static int bmp280_buffer_preenable(struct iio_dev *indio_dev)
 	struct bmp280_data *data = iio_priv(indio_dev);
 
 	pm_runtime_get_sync(data->dev);
+	data->chip_info->set_mode(data, BMP280_NORMAL);
 
 	return 0;
 }
@@ -2819,6 +3061,10 @@ int bmp280_common_probe(struct device *dev,
 			return ret;
 	}
 
+	ret = data->chip_info->set_mode(data, BMP280_SLEEP);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set sleep mode\n");
+
 	/* Enable runtime PM */
 	pm_runtime_get_noresume(dev);
 	pm_runtime_set_active(dev);
@@ -2844,6 +3090,9 @@ static int bmp280_runtime_suspend(struct device *dev)
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmp280_data *data = iio_priv(indio_dev);
 
+	data->chip_info->set_mode(data, BMP280_SLEEP);
+
+	fsleep(data->start_up_time);
 	return regulator_bulk_disable(BMP280_NUM_SUPPLIES, data->supplies);
 }
 
@@ -2858,7 +3107,12 @@ static int bmp280_runtime_resume(struct device *dev)
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
index dc1bf04cb0b5..3babf90ce73c 100644
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
@@ -385,6 +395,12 @@ struct bmp380_calib {
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
@@ -423,6 +439,9 @@ struct bmp280_data {
 	u8 sensor_data[ALIGN(sizeof(s32) * BME280_NUM_MAX_CHANNELS, sizeof(s64))
 		       + sizeof(s64)] __aligned(sizeof(s64));
 
+	/* Value to hold the current operation mode of the device */
+	enum bmp280_op_mode op_mode;
+
 	/*
 	 * DMA (thus cache coherency maintenance) may require the
 	 * transfer buffers to live in their own cache lines.
@@ -487,6 +506,8 @@ struct bmp280_chip_info {
 	int (*read_humid)(struct bmp280_data *data, u32 *adc_humidity);
 	int (*read_calib)(struct bmp280_data *data);
 	int (*preinit)(struct bmp280_data *data);
+	int (*set_mode)(struct bmp280_data *data, enum bmp280_op_mode mode);
+	int (*wait_conv)(struct bmp280_data *data);
 
 	irqreturn_t (*trigger_handler)(int irq, void *p);
 };
-- 
2.25.1


