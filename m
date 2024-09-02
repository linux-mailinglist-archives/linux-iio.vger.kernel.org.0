Return-Path: <linux-iio+bounces-9027-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B1C968DCA
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 20:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DAECB2167B
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 18:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4763DAC00;
	Mon,  2 Sep 2024 18:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQgYtZvw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6BF21C187;
	Mon,  2 Sep 2024 18:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725302559; cv=none; b=kNERde9h0BltJxhsTPjo1RnILOZBbu6rDSEyxV4BdhWJuUuDrjdrbNmSXyszK3Z7n4U6AnVx8XNQoeJuRddi0L8KioOR6Syb2kEOVkP4RDunt2KQWdJv3ClvKdFXA43UGFQIkKRAYo8D4qrp9vEx3N9CMCtJKvvuNZJjQaXQW2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725302559; c=relaxed/simple;
	bh=WWAmhNjah9crhyBMvMVbn/J1Sxemr78dk9V2kbGeanU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q6boGKWJgKnEskJjWbwH2j1ymVFpbOJUuWltiE649pm7KkxZdg9/9243GBCdpzMxB9jggRENn/qO+BNG3qTLpULKCIEtu8Sx8ljY0SFUYQ2ZaqorXgHCwi6SItPwdL4WsbjQ/oFjTPlL2X+v3gY8BQ3nOqRQenLsoEGnR20iDLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQgYtZvw; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-533488ffaf7so6130818e87.0;
        Mon, 02 Sep 2024 11:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725302554; x=1725907354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9ss9HdLsigH+9uZPMqVFlBWKlXTSDUOX9N8A2zmG7U=;
        b=GQgYtZvwgYu8/gkzv2ccmMDjbumu9FU3AADCirGmI4KIv25g2dhn3wgF3fTWtqA7H/
         kbFJDuzhiIJIBrOm2ZjwIh3hZxl5QXBT7uW8nlZcAmx9YGM645QJg4VO9wGHXebxLTQb
         N6s0OLXp5yNhQ5hXFRgl5jgPcMpC528nSngnatr6xUxKjx7j48G2beWGOdtg3lFNItkS
         ewWhKxPdu+JDBfF0c2VNkHB9CbdapR1MMroQhdP0qc2uNdLSq6P7X+jhtFJtknF/8+Os
         04BL/YZh5Yx2oUfvT0CkCMn1t7befFhRyEoGPnEwjrfnBRkDafUgc5ZErNZKBzbQkFxr
         Ia+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725302554; x=1725907354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9ss9HdLsigH+9uZPMqVFlBWKlXTSDUOX9N8A2zmG7U=;
        b=Ob2rjHbmDeidHBOuWOOsPb1ezgmrl0Y4aTGOkYL+hsv/Mj1rPGgRRhzE16garE5Ry1
         vXIiL97K15IE2fkSl5m2R9s+7mo/bybnmhwoILW1ejE28A0CiN5/RnGb5x3hEakJk0bU
         FwytorP7nJvhucv2SZc/zibGHx56/ZJrSFt8jvlGdDmhtcOUpcNNY1uRR3dmFwwBTzTu
         H7EB3HyvbygDy9OSDBHJ4mIcyw0SkwPheqy0wOp88+nOS5Zl1Qr/cA7rYa6Kdufu3gZb
         Fa8uIfSY0kj4658P0+wfQTEwiAPeQJp7fkdYGN+TRdSCsVxLEawgsjHAGDcvQWTh80G7
         VfYw==
X-Forwarded-Encrypted: i=1; AJvYcCUHYNzHPcP+xL7NXlSKDwPYAoBu4AyZWj5KZqcK7ewDOZaMIqDn31QZNyk7eha9h1TVV4tPAa167kUo@vger.kernel.org, AJvYcCUwmjxgVnvKg3LvFizoiOa3im/TQncIR/mgsWD6Fl4iLQNjtvJenUoyC0GatGiRVEK3/3ELXIiXWmBO@vger.kernel.org, AJvYcCVdUwGXU5P2nXkDq0Xq6GbjTLkpVyqwk22FmzrSi/V26KfI9M8b8o9+jswjOt0fd8U6ceaSjIkG8Dk8nO+T@vger.kernel.org
X-Gm-Message-State: AOJu0Yz238Yv0dyBvn+cvbde5U1G4MOeYQva/TQJq+sAzBn80T7muQA0
	Gampjc/cnHux/Iv1112sHwblA361jKvRir3/m0cS6n2yoQjd/EWd
X-Google-Smtp-Source: AGHT+IEvG6aAsQWI5Tw/ZncjxuPde+5tWIhRizQHOA6cZB2zK1HUQX7NkowjXvIHEe7E69vcO8dbzg==
X-Received: by 2002:a05:6512:2309:b0:52e:9b9e:a6cb with SMTP id 2adb3069b0e04-53546b24bfbmr8207456e87.15.1725302553513;
        Mon, 02 Sep 2024 11:42:33 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:bc14:b544:1196:d1a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898900ec0asm590537966b.53.2024.09.02.11.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 11:42:33 -0700 (PDT)
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
Subject: [PATCH v5 7/7] iio: pressure: bmp280: Move bmp085 interrupt to new configuration
Date: Mon,  2 Sep 2024 20:42:22 +0200
Message-Id: <20240902184222.24874-8-vassilisamir@gmail.com>
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

This commit intends to add the old BMP085 sensor to the new IRQ interface
of the driver for consistence. No functional changes intended.

The BMP085 sensor is equivalent with the BMP180 with the only difference of
BMP085 having an extra interrupt pin to inform about an End of Conversion.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 63 +++++++++++++++++++++++-------
 drivers/iio/pressure/bmp280-i2c.c  |  4 +-
 drivers/iio/pressure/bmp280-spi.c  |  4 +-
 drivers/iio/pressure/bmp280.h      |  1 +
 4 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 74233778df35..2cfe29f7681b 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -3056,13 +3056,16 @@ static irqreturn_t bmp085_eoc_irq(int irq, void *d)
 	return IRQ_HANDLED;
 }
 
-static int bmp085_fetch_eoc_irq(struct device *dev,
-				const char *name,
-				int irq,
-				struct bmp280_data *data)
+static int bmp085_trigger_probe(struct iio_dev *indio_dev)
 {
+	struct bmp280_data *data = iio_priv(indio_dev);
+	struct device *dev = data->dev;
 	unsigned long irq_trig;
-	int ret;
+	int ret, irq;
+
+	irq = fwnode_irq_get(dev_fwnode(dev), 0);
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "No interrupt found.\n");
 
 	irq_trig = irqd_get_trigger_type(irq_get_irq_data(irq));
 	if (irq_trig != IRQF_TRIGGER_RISING) {
@@ -3072,13 +3075,8 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
 
 	init_completion(&data->done);
 
-	ret = devm_request_threaded_irq(dev,
-			irq,
-			bmp085_eoc_irq,
-			NULL,
-			irq_trig,
-			name,
-			data);
+	ret = devm_request_irq(dev, irq, bmp085_eoc_irq, irq_trig,
+			       indio_dev->name, data);
 	if (ret) {
 		/* Bail out without IRQ but keep the driver in place */
 		dev_err(dev, "unable to request DRDY IRQ\n");
@@ -3086,9 +3084,48 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
 	}
 
 	data->use_eoc = true;
+
 	return 0;
 }
 
+/* Identical to bmp180_chip_info + bmp085_trigger_probe */
+const struct bmp280_chip_info bmp085_chip_info = {
+	.id_reg = BMP280_REG_ID,
+	.chip_id = bmp180_chip_ids,
+	.num_chip_id = ARRAY_SIZE(bmp180_chip_ids),
+	.regmap_config = &bmp180_regmap_config,
+	.start_up_time = 2000,
+	.channels = bmp280_channels,
+	.num_channels = ARRAY_SIZE(bmp280_channels),
+	.avail_scan_masks = bmp280_avail_scan_masks,
+
+	.oversampling_temp_avail = bmp180_oversampling_temp_avail,
+	.num_oversampling_temp_avail =
+		ARRAY_SIZE(bmp180_oversampling_temp_avail),
+	.oversampling_temp_default = 0,
+
+	.oversampling_press_avail = bmp180_oversampling_press_avail,
+	.num_oversampling_press_avail =
+		ARRAY_SIZE(bmp180_oversampling_press_avail),
+	.oversampling_press_default = BMP180_MEAS_PRESS_8X,
+
+	.temp_coeffs = bmp180_temp_coeffs,
+	.temp_coeffs_type = IIO_VAL_FRACTIONAL,
+	.press_coeffs = bmp180_press_coeffs,
+	.press_coeffs_type = IIO_VAL_FRACTIONAL,
+
+	.chip_config = bmp180_chip_config,
+	.read_temp = bmp180_read_temp,
+	.read_press = bmp180_read_press,
+	.read_calib = bmp180_read_calib,
+	.set_mode = bmp180_set_mode,
+	.wait_conv = bmp180_wait_conv,
+
+	.trigger_probe = bmp085_trigger_probe,
+	.trigger_handler = bmp180_trigger_handler,
+};
+EXPORT_SYMBOL_NS(bmp085_chip_info, IIO_BMP280);
+
 static int bmp280_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct bmp280_data *data = iio_priv(indio_dev);
@@ -3260,8 +3297,6 @@ int bmp280_common_probe(struct device *dev,
 	 * so we look for an IRQ if we have that.
 	 */
 	if (irq > 0) {
-		if (chip_id == BMP180_CHIP_ID)
-			ret = bmp085_fetch_eoc_irq(dev, name, irq, data);
 		if (data->chip_info->trigger_probe)
 			ret = data->chip_info->trigger_probe(indio_dev);
 		if (ret)
diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
index 5c3a63b4327c..2f7b25984c7b 100644
--- a/drivers/iio/pressure/bmp280-i2c.c
+++ b/drivers/iio/pressure/bmp280-i2c.c
@@ -27,7 +27,7 @@ static int bmp280_i2c_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id bmp280_of_i2c_match[] = {
-	{ .compatible = "bosch,bmp085", .data = &bmp180_chip_info },
+	{ .compatible = "bosch,bmp085", .data = &bmp085_chip_info },
 	{ .compatible = "bosch,bmp180", .data = &bmp180_chip_info },
 	{ .compatible = "bosch,bmp280", .data = &bmp280_chip_info },
 	{ .compatible = "bosch,bme280", .data = &bme280_chip_info },
@@ -38,7 +38,7 @@ static const struct of_device_id bmp280_of_i2c_match[] = {
 MODULE_DEVICE_TABLE(of, bmp280_of_i2c_match);
 
 static const struct i2c_device_id bmp280_i2c_id[] = {
-	{"bmp085", (kernel_ulong_t)&bmp180_chip_info },
+	{"bmp085", (kernel_ulong_t)&bmp085_chip_info },
 	{"bmp180", (kernel_ulong_t)&bmp180_chip_info },
 	{"bmp280", (kernel_ulong_t)&bmp280_chip_info },
 	{"bme280", (kernel_ulong_t)&bme280_chip_info },
diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
index d18549d9bb64..49aa8c2cd85b 100644
--- a/drivers/iio/pressure/bmp280-spi.c
+++ b/drivers/iio/pressure/bmp280-spi.c
@@ -114,7 +114,7 @@ static int bmp280_spi_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id bmp280_of_spi_match[] = {
-	{ .compatible = "bosch,bmp085", .data = &bmp180_chip_info },
+	{ .compatible = "bosch,bmp085", .data = &bmp085_chip_info },
 	{ .compatible = "bosch,bmp180", .data = &bmp180_chip_info },
 	{ .compatible = "bosch,bmp181", .data = &bmp180_chip_info },
 	{ .compatible = "bosch,bmp280", .data = &bmp280_chip_info },
@@ -126,7 +126,7 @@ static const struct of_device_id bmp280_of_spi_match[] = {
 MODULE_DEVICE_TABLE(of, bmp280_of_spi_match);
 
 static const struct spi_device_id bmp280_spi_id[] = {
-	{ "bmp085", (kernel_ulong_t)&bmp180_chip_info },
+	{ "bmp085", (kernel_ulong_t)&bmp085_chip_info },
 	{ "bmp180", (kernel_ulong_t)&bmp180_chip_info },
 	{ "bmp181", (kernel_ulong_t)&bmp180_chip_info },
 	{ "bmp280", (kernel_ulong_t)&bmp280_chip_info },
diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
index 0c32b6430677..e0e47bf22472 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -535,6 +535,7 @@ struct bmp280_chip_info {
 };
 
 /* Chip infos for each variant */
+extern const struct bmp280_chip_info bmp085_chip_info;
 extern const struct bmp280_chip_info bmp180_chip_info;
 extern const struct bmp280_chip_info bmp280_chip_info;
 extern const struct bmp280_chip_info bme280_chip_info;
-- 
2.25.1


