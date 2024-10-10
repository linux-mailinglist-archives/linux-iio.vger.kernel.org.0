Return-Path: <linux-iio+bounces-10428-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA30E999433
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 23:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1391C264F7
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 21:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434DF1EF94F;
	Thu, 10 Oct 2024 21:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXbOclej"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205071EF09F;
	Thu, 10 Oct 2024 21:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728594058; cv=none; b=ZV+34c9uZDANDasAOX8+57xNjtPfWs20kOD8npic+uAXugPCZZvKxRHSLfrhIxeuSZKn0WPHxogJ24/W8rnWcrCChYSMv/N2pD3ovCnafD+E6YsydXseYtWqy3U7oaYrPiBJ6KHap41OjYd8+3MKCNW0u01wt+DlHsAXsLRDvoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728594058; c=relaxed/simple;
	bh=a99UhmFiaPZvfh7b6Ml438pv7HVRosc6MoqVxm76lbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JqKd5tq5k2+KG8qryHo8jdZlzHir+7ozAROBtbSQh4Ln+hFm2MbCo+IMXl5imayeolEGfiY5XqaHy4h2m4+5jQr72WX4E3FRqhWFSdwDrxWcXprvEzKYrSR/fx4saxf7c9TqYQaBvZy/H1lpYYHrFJaXM3thsyWSzKxa8+kktg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXbOclej; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9953bdc341so102594766b.2;
        Thu, 10 Oct 2024 14:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728594054; x=1729198854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rlyfHq2NNG9opqGozCAzEdrmjUAChMJmuDDHTJycLws=;
        b=MXbOclejpWclA+E/0609qcOHjV5rXmzfMyi6dHIDpQL7ll/hNN6j/WY8MvO0Qdq6yJ
         wEfoQ5MJ9QOIDBv5DlQthLf4sujg0xlfXMPp58hrpHg8jassRNovTTBE52UsKKCySrYb
         s+jEnN9xulqL0WpqAD0G9/E7lyyHx7k0vOLkXQpiz5mmk/HupvL98eZzQl93RJ+0re5J
         WbsZ0zJDifYSW+jgORDRcDqrWEMovRojs1t1IG/4GdDdtAJJ79+jZbin/b1YmBPRbtaL
         tA3HwO0T/5d93CnLLVYrw5Ym2ezrI4GMErp+5SgTfWW2jmRVo3sm2Udl3p+QKVAKoJfa
         F1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728594054; x=1729198854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rlyfHq2NNG9opqGozCAzEdrmjUAChMJmuDDHTJycLws=;
        b=xQtm/fFu1yZ7HTjwdpIXl02SdxBNzQw76FJgoXs8mTh0dytkIS43HuvUQEqh0C9MlA
         liDKnHKTx14LtEUUPL722xW/+T5UOhIsGewCqKd1+bAC34gSvhk3CeC5BTthuzfi91O+
         tMowYng3wnYtmP/2OcfyMrUIEBbaCdcCSVnwuQlmPuQ+pNTdup1X885Y9QrvJww6tMnh
         iwzBAxzh8U7sN3CzS4pHYpZ13m82280wb2pgZPB3dmAL9/GU/Lk/QUGRYVfzx5+Z6vnv
         9/vYhpF0aVXrSnB+QZJRbaDFsNlUmYG3+w5Nf37eGXhiwCBafGylhYS55PiVkO8K/cuU
         HZyg==
X-Forwarded-Encrypted: i=1; AJvYcCUEr4dbFsf/CjFMk5D+UQCz0430xl09Z2/1FQIUCbN0nYdtp/0SGrxBWZGl5nfkI3ueYLSJjS+v1aXn@vger.kernel.org, AJvYcCUTYrrZGjuFwedXzdybBqNMJWdNMYpgbUElcnAK6BjAlRTE7HvLT14UDZ4Hr2fMOrVIEGFPU7nBV+IMq4nv@vger.kernel.org, AJvYcCWhg4WzlmBR2pdy4izMdqpWnTUO6YN/4J0gB7BO95hh8Ak9kKEmfo+AgMTON9OxubJrmEShh6lizjVW@vger.kernel.org
X-Gm-Message-State: AOJu0YzqZBpIMoRN1Y1yhNGG6R0i3gn0bdQ3YNSKvuJt5RdMP7adJleY
	7XvbNeXdu0aMDBFOjjhLnVvvDVTZDckMRJNZdP2K+M3As5hOZO37
X-Google-Smtp-Source: AGHT+IEpv5+bOXaCpTptpUwXlX7KKWV6Qzehza4URQJ2BfSrICFm4+6FUJ4Px3hdQ/xQ5jDU8HblEA==
X-Received: by 2002:a17:907:940e:b0:a99:4152:1cb4 with SMTP id a640c23a62f3a-a99b9585801mr18808566b.42.1728594054162;
        Thu, 10 Oct 2024 14:00:54 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:7eab:ec9d:62da:64f5])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a99a7f25f4dsm135692566b.68.2024.10.10.14.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 14:00:53 -0700 (PDT)
From: vamoirid <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: vassilisamir@gmail.com,
	anshulusr@gmail.com,
	gustavograzs@gmail.com,
	andriy.shevchenko@linux.intel.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 12/13] iio: chemical: bme680: Add triggered buffer support
Date: Thu, 10 Oct 2024 23:00:29 +0200
Message-ID: <20241010210030.33309-13-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241010210030.33309-1-vassilisamir@gmail.com>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vasileios Amoiridis <vassilisamir@gmail.com>

Add triggered buffer and soft timestamp support. The available scan mask
enables all the channels of the sensor in order to follow the operation of
the sensor. The sensor basically starts to capture from all channels
as long as it enters into FORCED mode.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/chemical/Kconfig       |   2 +
 drivers/iio/chemical/bme680.h      |   2 +
 drivers/iio/chemical/bme680_core.c | 168 ++++++++++++++++++++++++++++-
 3 files changed, 171 insertions(+), 1 deletion(-)

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
index 95d39c154d59..e7eed2962baa 100644
--- a/drivers/iio/chemical/bme680.h
+++ b/drivers/iio/chemical/bme680.h
@@ -64,6 +64,8 @@
 
 #define BME680_STARTUP_TIME_US			2000
 
+#define BME680_NUM_CHANNELS			4
+
 /* Calibration Parameters */
 #define BME680_T2_LSB_REG	0x8A
 #define BME680_H2_MSB_REG	0xE1
diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 7d6f4d8c5fe4..df6ae4355902 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -18,8 +18,11 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #include <asm/unaligned.h>
 
@@ -108,6 +111,13 @@ static const char *const bme680_supply_names[] = {
 
 #define BME680_NUM_SUPPLIES ARRAY_SIZE(bme680_supply_names)
 
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
@@ -122,8 +132,11 @@ struct bme680_data {
 	struct regulator_bulk_data supplies[BME680_NUM_SUPPLIES];
 	int ambient_temp;
 
+	u8 buffer[ALIGN(sizeof(s32) * BME680_NUM_CHANNELS, sizeof(s64))
+		  + sizeof(s64)] __aligned(sizeof(s64));
+
 	union {
-		u8 buf[3];
+		u8 buf[15];
 		unsigned int check;
 		__be16 be16;
 		u8 bme680_cal_buf_1[BME680_CALIB_RANGE_1_LEN];
@@ -160,6 +173,13 @@ static const struct iio_chan_spec bme680_channels[] = {
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
@@ -168,6 +188,13 @@ static const struct iio_chan_spec bme680_channels[] = {
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
@@ -176,11 +203,26 @@ static const struct iio_chan_spec bme680_channels[] = {
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
@@ -997,6 +1039,121 @@ static const struct iio_info bme680_info = {
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
+	u32 adc_temp, adc_press, adc_humid, comp_press, comp_humid;
+	s32 *chans = (s32 *)data->buffer;
+	u16 adc_gas_res, gas_regs_val;
+	s32 t_fine, comp_gas_res;
+	s16 comp_temp;
+	u8 gas_range;
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
+		dev_err(data->dev, "failed to burst read sensor data\n");
+		goto out;
+	}
+	if (data->buf[0] & BME680_GAS_MEAS_BIT) {
+		dev_err(data->dev, "gas measurement incomplete\n");
+		goto out;
+	}
+
+	/* Temperature calculations */
+	adc_temp = FIELD_GET(BME680_MEAS_TRIM_MASK, get_unaligned_be24(&data->buf[5]));
+	if (adc_temp == BME680_MEAS_SKIPPED) {
+		dev_err(data->dev, "reading temperature skipped\n");
+		goto out;
+	}
+	comp_temp = bme680_compensate_temp(data, adc_temp);
+	t_fine = bme680_calc_t_fine(data, adc_temp);
+
+	/* Pressure calculations */
+	adc_press = FIELD_GET(BME680_MEAS_TRIM_MASK, get_unaligned_be24(&data->buf[2]));
+	if (adc_press == BME680_MEAS_SKIPPED) {
+		dev_err(data->dev, "reading pressure skipped\n");
+		goto out;
+	}
+	comp_press = bme680_compensate_press(data, adc_press, t_fine);
+	pr_info("comp_press: %d\n", comp_press);
+
+	/* Humidity calculations */
+	adc_humid = get_unaligned_be16(&data->buf[8]);
+	if (adc_humid == BME680_MEAS_SKIPPED) {
+		dev_err(data->dev, "reading humidity skipped\n");
+		goto out;
+	}
+	comp_humid = bme680_compensate_humid(data, adc_humid, t_fine);
+	pr_info("comp_humid: %d\n", comp_humid);
+
+	/* Gas calculations */
+	gas_regs_val = get_unaligned_be16(&data->buf[13]);
+	adc_gas_res = FIELD_GET(BME680_ADC_GAS_RES, gas_regs_val);
+	if ((gas_regs_val & BME680_GAS_STAB_BIT) == 0) {
+		dev_err(data->dev, "heater failed to reach the target temperature\n");
+		goto out;
+	}
+	gas_range = FIELD_GET(BME680_GAS_RANGE_MASK, gas_regs_val);
+	comp_gas_res = bme680_compensate_gas(data, adc_gas_res, gas_range);
+	pr_info("comp_gas_res: %d\n", comp_gas_res);
+
+	chans[0] = comp_temp;
+	chans[1] = comp_press;
+	chans[2] = comp_humid;
+	chans[3] = comp_gas_res;
+
+	/* Push to buffer */
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
+					   iio_get_time_ns(indio_dev));
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
+static int bme680_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct bme680_data *data = iio_priv(indio_dev);
+
+	pm_runtime_get_sync(data->dev);
+
+	return 0;
+}
+
+static int bme680_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct bme680_data *data = iio_priv(indio_dev);
+
+	pm_runtime_mark_last_busy(data->dev);
+	pm_runtime_put_autosuspend(data->dev);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops bme680_buffer_setup_ops = {
+	.preenable = bme680_buffer_preenable,
+	.postdisable = bme680_buffer_postdisable,
+};
+
 static void bme680_regulators_disable(void *data)
 {
 	struct regulator_bulk_data *supplies = data;
@@ -1032,6 +1189,7 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->name = name;
 	indio_dev->channels = bme680_channels;
 	indio_dev->num_channels = ARRAY_SIZE(bme680_channels);
+	indio_dev->available_scan_masks = bme680_avail_scan_masks;
 	indio_dev->info = &bme680_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
@@ -1088,6 +1246,14 @@ int bme680_core_probe(struct device *dev, struct regmap *regmap,
 		return dev_err_probe(dev, ret,
 				     "failed to set gas config data\n");
 
+	ret = devm_iio_triggered_buffer_setup(data->dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      bme680_trigger_handler,
+					      &bme680_buffer_setup_ops);
+	if (ret)
+		return dev_err_probe(data->dev, ret,
+				     "iio triggered buffer setup failed\n");
+
 	/* Enable runtime PM */
 	pm_runtime_get_noresume(dev);
 	pm_runtime_set_active(dev);
-- 
2.43.0


