Return-Path: <linux-iio+bounces-11832-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB979BA043
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 14:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72FA91C2113A
	for <lists+linux-iio@lfdr.de>; Sat,  2 Nov 2024 13:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0787D198E91;
	Sat,  2 Nov 2024 13:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3PCiq2X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4F418B497;
	Sat,  2 Nov 2024 13:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730553211; cv=none; b=uU/2GjCicgwJxtcosz80ZXlZ7g5oG+bere6l+27W/te2KbJVcxImswTETCmcZe92IZV52jIfZlgNVadGhR0FkCLZFpCj7gYLa4gSQwNCMDWRbK3XIycjPNITn7tI1X0hRyAWjxtw61N2S3mr7m/7qHoju+sDF2PIXs8HvzRwXz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730553211; c=relaxed/simple;
	bh=ZBUPc0dVD2pf/HoEzgKaKn3lWwlNkgbcVveKDHLt+2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M79aivIjEQvMKYw7gkA67dIGRuf9tn9L5D7DaAl9hMKvVKVPSuI6ok/YL88ulq+nZ+uIdJkiErr4V0LKBUk5Ni0Zlm4nrCt9yOFmQTpYM9UAqmxCq3+bkc8CscNGln4zTtN9Kf2e0ktNOkejdsVatk9jsO6MQK0SHh/iTRgnXYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3PCiq2X; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315abed18aso22808535e9.2;
        Sat, 02 Nov 2024 06:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730553208; x=1731158008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vttvluHX+R2cAF1FzL6jm9YL5IFUsw8MbaVeOkGyLNI=;
        b=U3PCiq2XKo+hoqcMhxNt5hHSB5RDEvEdNHZMKb1jfjLugeAxGayC9YaC2gKavMo2iS
         25wXcDvWjCL3mMO1M5WIohZAmLmcIihKwL2inj5KmQsd2/b5WISMrt5+IG7szJiNREEj
         2CDmqY8bd5Hh7gaxkzEBG4zY9OhJSnV6lNyobQZxcH2PGs+C+IMJgKgehsRcwLmHo9lj
         XbHv50qFyng8uEkxIuzABUiBF4zCCXkhVF2FtZ3UDSHD+GImdI2VX0Z8umc/l06wM/4V
         Kh0gUsFmsUqMoTmtED/1m3MlP118MZG9gFzXOW1vbPV3C2xSg8zWVzjZINUi4CNTo2IZ
         LIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730553208; x=1731158008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vttvluHX+R2cAF1FzL6jm9YL5IFUsw8MbaVeOkGyLNI=;
        b=Bkie/xtX8876I7RLdW3XJaZoaw+xBMKthb3RTinZenrfQ+plIG0+uqY6hVW4mJkHEe
         yu52hS1mpeyUuFD2qfPO8V7uv3TpFDOqJQ7xq3N/t0soS/Qpt0UefdoF8hTYPQUdPJHw
         +j3VLx56F2RGQTH8Q47tXAMpEs23/LkLcQFrmsg/K1iDjjfYZMMeBJIDUI7GYwr5Mngg
         25gEMdq7PZ6/5JzojdYwxVF9QdZ+YdFaqC25vzLNkGAuVbaWSwK9WjZXUppGH/n20vAm
         qpyeRNRGrhH0cF/Q5n/qL2s8pv6/gvNHKFuiATuN+9bnswCcOkMg85EkYDUSEE5fywTF
         qSIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoHAogpZJmaopUpXcs8JUVU0TlwZNPiRqnWCVbFqRxCyRJYm3e4hn0kKnLs1bfC2G9mmMUok5P2/8JeSlc@vger.kernel.org, AJvYcCVqOdtVI0NsD8YOVNjJ6qW8AVtXZiBnnKVHHbnvSUA8gjMR/unkPw4j7uMlVzN1b6RBRRDgUQj0LCKT@vger.kernel.org, AJvYcCXTlfVuwlVS6DJ+9/wlOZ22pyzNhQmCK09S6exYQm0hmYcvWXh+2ArJ4kVrR4mt9seSu4aWqsfiGSU/@vger.kernel.org
X-Gm-Message-State: AOJu0YzkFgK7GzQ/+KtzeM+7ycfDYA2r+xSBUqDZuZYhJ4PShTqDM3J2
	uRIq8FhnJom8FcF1u1lp0sXjftcqFLLHOHQfn+3X6Tq6G9IMZF2j
X-Google-Smtp-Source: AGHT+IHAcgCetDeoMMlJSmmFSuFU9vPt/zepxaowJz5oLKkdH2KFiDoNP+eYtecSrEbS29NF8yJGkA==
X-Received: by 2002:a05:6000:4185:b0:381:cde6:4ced with SMTP id ffacd0b85a97d-381cde64d44mr2493230f8f.45.1730553207758;
        Sat, 02 Nov 2024 06:13:27 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:b243:5cd3:bfdd:a16e])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-381c113e5cbsm8081570f8f.80.2024.11.02.06.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 06:13:27 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	anshulusr@gmail.com,
	gustavograzs@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/7] iio: chemical: bme680: Add triggered buffer support
Date: Sat,  2 Nov 2024 14:13:07 +0100
Message-ID: <20241102131311.36210-4-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241102131311.36210-1-vassilisamir@gmail.com>
References: <20241102131311.36210-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add triggered buffer and soft timestamp support. The available scan mask
enables all the channels of the sensor in order to follow the operation of
the sensor. The sensor basically starts to capture from all channels
as long as it enters into FORCED mode.

The bulk read, reads a total of 15 registers from the sensor, 0x1D..0x2B.
Even though some of those registers are not reported in the register map
of the device, this is how the BME680 Sensor API [1] proposes to do it.
This allows to have one bulk read instead of multiple ones.

Link: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L1200
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/Kconfig       |   2 +
 drivers/iio/chemical/bme680.h      |   3 +
 drivers/iio/chemical/bme680_core.c | 137 ++++++++++++++++++++++++++++-
 3 files changed, 141 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
index 6c87223f58d9..330fe0af946f 100644
--- a/drivers/iio/chemical/Kconfig
+++ b/drivers/iio/chemical/Kconfig
@@ -50,6 +50,8 @@ config BME680
 	select REGMAP
 	select BME680_I2C if I2C
 	select BME680_SPI if SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Bosch Sensortec BME680 sensor with
 	  temperature, pressure, humidity and gas sensing capability.
diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
index 77136b55e7f6..a0a7794543c8 100644
--- a/drivers/iio/chemical/bme680.h
+++ b/drivers/iio/chemical/bme680.h
@@ -66,6 +66,9 @@
 /* Datasheet Section 1.1, Table 1 */
 #define BME680_STARTUP_TIME_US			2000
 
+#define BME680_NUM_CHANNELS			4
+#define BME680_NUM_BULK_READ_REGS		15
+
 /* Calibration Parameters */
 #define BME680_T2_LSB_REG	0x8A
 #define BME680_H2_MSB_REG	0xE1
diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index ea1ee9964870..6df87383c243 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -16,8 +16,11 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #include <linux/unaligned.h>
 
@@ -101,6 +104,13 @@ enum bme680_op_mode {
 	BME680_MODE_FORCED = 1,
 };
 
+enum bme680_scan {
+	BME680_TEMP,
+	BME680_PRESS,
+	BME680_HUMID,
+	BME680_GAS,
+};
+
 struct bme680_data {
 	struct regmap *regmap;
 	struct bme680_calib bme680;
@@ -111,8 +121,13 @@ struct bme680_data {
 	u16 heater_dur;
 	u16 heater_temp;
 
+	struct {
+		s32 chan[4];
+		aligned_s64 ts;
+	} scan;
+
 	union {
-		u8 buf[3];
+		u8 buf[BME680_NUM_BULK_READ_REGS];
 		unsigned int check;
 		__be16 be16;
 		u8 bme680_cal_buf_1[BME680_CALIB_RANGE_1_LEN];
@@ -149,6 +164,13 @@ static const struct iio_chan_spec bme680_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.scan_index = 0,
+		.scan_type = {
+			.sign = 's',
+			.realbits = 16,
+			.storagebits = 16,
+			.endianness = IIO_CPU,
+		},
 	},
 	{
 		.type = IIO_PRESSURE,
@@ -157,6 +179,13 @@ static const struct iio_chan_spec bme680_channels[] = {
 				      BIT(IIO_CHAN_INFO_RAW) |
 				      BIT(IIO_CHAN_INFO_SCALE) |
 				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
+		.scan_index = 1,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
 	},
 	{
 		.type = IIO_HUMIDITYRELATIVE,
@@ -165,11 +194,26 @@ static const struct iio_chan_spec bme680_channels[] = {
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
 	{
 		.type = IIO_RESISTANCE,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
+		.scan_index = 3,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 32,
+			.storagebits = 32,
+			.endianness = IIO_CPU,
+		},
 	},
+	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
 static int bme680_read_calib(struct bme680_data *data,
@@ -920,6 +964,88 @@ static const struct iio_info bme680_info = {
 	.attrs = &bme680_attribute_group,
 };
 
+static const unsigned long bme680_avail_scan_masks[] = {
+	BIT(BME680_GAS) | BIT(BME680_HUMID) | BIT(BME680_PRESS) | BIT(BME680_TEMP),
+	0
+};
+
+static irqreturn_t bme680_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct bme680_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
+	u32 adc_temp, adc_press, adc_humid;
+	u16 adc_gas_res, gas_regs_val;
+	u8 gas_range;
+	s32 t_fine;
+	int ret;
+
+	guard(mutex)(&data->lock);
+
+	ret = bme680_set_mode(data, BME680_MODE_FORCED);
+	if (ret < 0)
+		goto out;
+
+	ret = bme680_wait_for_eoc(data);
+	if (ret)
+		goto out;
+
+	/* Burst read data regs */
+	ret = regmap_bulk_read(data->regmap, BME680_REG_MEAS_STAT_0,
+			       data->buf, sizeof(data->buf));
+	if (ret) {
+		dev_err(dev, "failed to burst read sensor data\n");
+		goto out;
+	}
+	if (data->buf[0] & BME680_GAS_MEAS_BIT) {
+		dev_err(dev, "gas measurement incomplete\n");
+		goto out;
+	}
+
+	/* Temperature calculations */
+	adc_temp = FIELD_GET(BME680_MEAS_TRIM_MASK, get_unaligned_be24(&data->buf[5]));
+	if (adc_temp == BME680_MEAS_SKIPPED) {
+		dev_err(dev, "reading temperature skipped\n");
+		goto out;
+	}
+	data->scan.chan[0] = bme680_compensate_temp(data, adc_temp);
+	t_fine = bme680_calc_t_fine(data, adc_temp);
+
+	/* Pressure calculations */
+	adc_press = FIELD_GET(BME680_MEAS_TRIM_MASK, get_unaligned_be24(&data->buf[2]));
+	if (adc_press == BME680_MEAS_SKIPPED) {
+		dev_err(dev, "reading pressure skipped\n");
+		goto out;
+	}
+	data->scan.chan[1] = bme680_compensate_press(data, adc_press, t_fine);
+
+	/* Humidity calculations */
+	adc_humid = get_unaligned_be16(&data->buf[8]);
+	if (adc_humid == BME680_MEAS_SKIPPED) {
+		dev_err(dev, "reading humidity skipped\n");
+		goto out;
+	}
+	data->scan.chan[2] = bme680_compensate_humid(data, adc_humid, t_fine);
+
+	/* Gas calculations */
+	gas_regs_val = get_unaligned_be16(&data->buf[13]);
+	adc_gas_res = FIELD_GET(BME680_ADC_GAS_RES, gas_regs_val);
+	if ((gas_regs_val & BME680_GAS_STAB_BIT) == 0) {
+		dev_err(dev, "heater failed to reach the target temperature\n");
+		goto out;
+	}
+	gas_range = FIELD_GET(BME680_GAS_RANGE_MASK, gas_regs_val);
+	data->scan.chan[3] = bme680_compensate_gas(data, adc_gas_res, gas_range);
+
+	/* Push to buffer */
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
+					   iio_get_time_ns(indio_dev));
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
 int bme680_core_probe(struct device *dev, struct regmap *regmap,
 		      const char *name)
 {
@@ -938,6 +1064,7 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->name = name;
 	indio_dev->channels = bme680_channels;
 	indio_dev->num_channels = ARRAY_SIZE(bme680_channels);
+	indio_dev->available_scan_masks = bme680_avail_scan_masks;
 	indio_dev->info = &bme680_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
@@ -980,6 +1107,14 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 		return dev_err_probe(dev, ret,
 				     "failed to set gas config data\n");
 
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      bme680_trigger_handler,
+					      NULL);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "iio triggered buffer setup failed\n");
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(bme680_core_probe, IIO_BME680);
-- 
2.43.0


