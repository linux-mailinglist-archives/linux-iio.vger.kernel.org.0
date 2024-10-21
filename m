Return-Path: <linux-iio+bounces-10901-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C22C9A9055
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 21:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D27311F217B3
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 19:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D1E1FEFBE;
	Mon, 21 Oct 2024 19:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KY4tN9Sl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B30A1FEFA5;
	Mon, 21 Oct 2024 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540423; cv=none; b=MwSDLy/Ru1pq21Tqj6Ndmqp4tFEN13hODgX+dzEd1KzeMcNVT8rdQ2iitWR+18Bi3JGOV5JO2pUtOAT0N7p2EMyGja5DqP8JpqpieFN6kkU2xFp0w60zalgEVjumSzZOMmDjwTaV1lEitEzE8TRxlO8jHZGS3NfAuS9JYAN68ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540423; c=relaxed/simple;
	bh=oqS/CWlkq1CAqDRmK9a4lGF4lA0kvg0ZX9DDaiRvWPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VyQ+IUQi5SOdYpRYT9JSiJxdKR/9F8/7tguo9oeg0ob0iHhTSPV+35sVSYHbiT/FNTTsXCDiza34iWQJYe5VXn1XN7f0HNZXYdeWYQohh3XKMMh/ip6t8TlPNfwMIisTiXMHEn7YFyGdXmimYRq6g6WNjYNlgPyi/kTZ+MD6XfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KY4tN9Sl; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d6ff1cbe1so3773109f8f.3;
        Mon, 21 Oct 2024 12:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729540420; x=1730145220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AgVYWAOh4OZE6jDzhMNTVLWtFaiOvfGB5liHZ7UsGg=;
        b=KY4tN9SlfKkds2vrgSm61eE+2WUQqqTlMtX1vC125D5HoCEhUjso/EE2l/iPKp6QyU
         wBy0ax11a65a8FornLwj7lg7AJRkZDlzMk8Z0siEuFa3cBL9UrxUeTMwX6FjhohjuSjS
         /CesBrV0oj9FCefXxHtrqSDgKCSouQ0B/x+jLJnU7ftpTW+GYXA/6XcCTZnSrCYsshsg
         CKjq97234b/NNcfgwt8Jejn/ZKI3j/5rBX5roND+iep99Qoj9qMG5segykrr7bYHSW0J
         647SfDk0Ex0lc5YbwAbEPmEJ4H7Ck2V76QtINfsfYcRrBvcqbok9fu/3Wze//vvUumCD
         hNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729540420; x=1730145220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AgVYWAOh4OZE6jDzhMNTVLWtFaiOvfGB5liHZ7UsGg=;
        b=tt3fNoGE2J9ul1OtcgDT2eu65v/7jp1vEpOSYkQoA0ShbuePQ3Sh+hmQpiec3DN3K/
         xbFQU1tVOs4aYMuRbSfNokbWtp++X1WXt+R9uJENlSLB5gB0GbAfMtkRdaCygWlRGcWr
         6g03v6Z6R/O0YlxDATVrwPdGYCRj7x8EAU57j3w7YvTX9k5Z1Q3LVS6wTPqN7P5lkFQw
         Xx9jU7suPrV9siFKgMQ05BnWRzWnUWJCfc/fpCHkV+iKEFWQ2Gl1+wKoOWpI0m5Ga5Po
         7En8O9PZSucS64B6F+CIuoLtgecxbSwPVXI3K6P6PxSEZJ6zK4MJePyfZRLrfUtzKHWp
         DiUw==
X-Forwarded-Encrypted: i=1; AJvYcCWNoe0gpVNXIPuX/6pzXv1+/+dW8ynjGFblOR5zNoWfpXkBoz+XQ7tfUYR8V437fppPXFR7yo92I3iV@vger.kernel.org, AJvYcCWdfViRatt6GnXUH5st6aGQc3TdtBcOiW0XExOpdQ92KdM80A3tGDr+z1M4+4XQGY0/QF2FgXjUCElLZuX8@vger.kernel.org, AJvYcCXKkiyQZ/VYJpU+Mq9M8quEiiDbmZOvv7W0Tvnis4mT7ZCOckh/MGQY5c00VkYRfY5M3qrNNiLOWiT5@vger.kernel.org
X-Gm-Message-State: AOJu0YxbNuoHUQcpfzjQ3hNbta00zPQu7+Gd6OiyvbvMCvPAdq+1u9Kk
	lVS9NYzXmEnUnFNaUmfehREf2j//e3FKGz9HxsfzQelLwap6K4hf
X-Google-Smtp-Source: AGHT+IEk3AOkFtkTJM3iIZPPQ5GO2ijKd1TbSZS8qM6BzW+q4A6HmEM7X075sRP6IG1pdCR3dR0yGg==
X-Received: by 2002:a5d:504c:0:b0:37d:4e5:bac7 with SMTP id ffacd0b85a97d-37ef2133c1bmr169506f8f.11.1729540419679;
        Mon, 21 Oct 2024 12:53:39 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:9cf6:f1e5:ce2b:ea6b])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b12dsm2338702a12.77.2024.10.21.12.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 12:53:38 -0700 (PDT)
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
Subject: [PATCH v2 09/13] iio: chemical: bme680: Add triggered buffer support
Date: Mon, 21 Oct 2024 21:53:12 +0200
Message-ID: <20241021195316.58911-10-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021195316.58911-1-vassilisamir@gmail.com>
References: <20241021195316.58911-1-vassilisamir@gmail.com>
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
index 678a6adb9a75..447b205f57bd 100644
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
index f5be4516dde7..574877bc51c5 100644
--- a/drivers/iio/chemical/bme680.h
+++ b/drivers/iio/chemical/bme680.h
@@ -68,6 +68,9 @@
 /* Datasheet Section 1.1, Table 1 */
 #define BME680_STARTUP_TIME_US			2000
 
+#define BME680_NUM_CHANNELS			4
+#define BME680_NUM_BULK_READ_REGS		15
+
 /* Calibration Parameters */
 #define BME680_T2_LSB_REG	0x8A
 #define BME680_H2_MSB_REG	0xE1
diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index e8098754a85f..7bf4daa35ba5 100644
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
 
@@ -100,6 +103,13 @@ enum bme680_op_mode {
 	BME680_FORCED,
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
@@ -110,8 +120,13 @@ struct bme680_data {
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
@@ -148,6 +163,13 @@ static const struct iio_chan_spec bme680_channels[] = {
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
@@ -156,6 +178,13 @@ static const struct iio_chan_spec bme680_channels[] = {
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
@@ -164,11 +193,26 @@ static const struct iio_chan_spec bme680_channels[] = {
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
@@ -918,6 +962,88 @@ static const struct iio_info bme680_info = {
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
+	ret = bme680_set_mode(data, BME680_FORCED);
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
@@ -936,6 +1062,7 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->name = name;
 	indio_dev->channels = bme680_channels;
 	indio_dev->num_channels = ARRAY_SIZE(bme680_channels);
+	indio_dev->available_scan_masks = bme680_avail_scan_masks;
 	indio_dev->info = &bme680_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
@@ -978,6 +1105,14 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
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


