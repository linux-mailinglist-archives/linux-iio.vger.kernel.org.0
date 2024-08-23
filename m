Return-Path: <linux-iio+bounces-8726-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B831695D533
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 20:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BEEAB20EE3
	for <lists+linux-iio@lfdr.de>; Fri, 23 Aug 2024 18:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCF5194089;
	Fri, 23 Aug 2024 18:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jII/dAvy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A711191F64;
	Fri, 23 Aug 2024 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724437050; cv=none; b=iemphswloqPrflXxy2LBrOn4bX0SCchygrTZhX8E8EV8g0Zp55BV8/EWclBmbcrhmV9KtrIgIFOyjUCfpwmqOPN1PQTflO7b+jkz5aW7zUlLxaB45fDx4noA6TRFFp0DphiVrwfPWwpkXOfbeFyy05FS+pmheshTHHBGCm6dLvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724437050; c=relaxed/simple;
	bh=VqZ7aNHjQnz9CcP+r4qLOzHuM6HL3rFgPOdK5GOcS7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k+lWNL2QHHGO8p829KQfM3xMuNzmnx0FHUoVgUArf+yRH7BLN1k/cmIwpH73+TntUpBt7qkxfJOvqJ4noYEq/C4LVAhklPqxViyqc9vkQK5IOgP2J1db6ipXdY5WDnNY13RrFZjuCQw655A8rqqXBwktTnlsPaSiT9kWPkoutsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jII/dAvy; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-371a92d8c90so1135213f8f.3;
        Fri, 23 Aug 2024 11:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724437047; x=1725041847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A5/2QyWRZZHfgqy3T++OUbtEdcV7A9JzQS0OF1wredA=;
        b=jII/dAvyG+V2TwKMarHOeyEoRA1dU7BaUCmuxmRHV3VC9zYHSOHCGlPxTyKc4ji/3a
         ej5Oba5KJkWnbWXOlIRmK0sOWB1uuT3rugy2qS3zZMeTi0xnTr6HyzkuXEbaDg5NHRkx
         o7Znuwa9ZQrSroqmPMClcCob1wZYW3v4jH70+MEn8hx4aj4XzmqJFbV951dQ98lnxR2I
         nqfZybgbTYc4yWQ62JW/gt4oLdWo4ULpGCfIhB8CXYCcOyOxUErQs6L0lBXZ4uhk2E9f
         t41oSgmlDD3JT+ohid/NTWcx7QhKcqTI63olFU+iUtgPQwoJJgilMnQlPjLX6G0H0Tj+
         ONkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724437047; x=1725041847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A5/2QyWRZZHfgqy3T++OUbtEdcV7A9JzQS0OF1wredA=;
        b=msLpfmQ73I9cFPpZXA8p8aXMdWQZo+APUMRsr88cyXIyfRwmtl/wfXZSJCMWzTOxkl
         AXwMmTUOskiLoDOOw0rXxlths2HHlmf+3N8hsNZLJsgHFwxlI+OfKgzG1/3pXwZkAxVi
         BhyAKrRzELZ/fehgE/s1wF3emw6PYA7nOX9UpIN3e01oLru6B4M9+RU4nykPRCGTimuZ
         KSaDTYvXkE8Ds61qwJ6hbN2wHXH5GuBpzv0BvtZuitX7OI2jE1eVBzwXeWufZs1BesQ6
         jWQsTPs6jcvtm8DbrjZZVqvI9YYyMGHlLzUctiOjUWZTVK+ZLY5DZ/Jow1tRENlV7fdt
         RyIw==
X-Forwarded-Encrypted: i=1; AJvYcCUn5YPiB87fG+4uGYv9dI324WemOaXZ2jbcb5mYNHIt3LYqS2PjgM1T8VH3eSnY66ZR2SVKH4DNAdprnfJk@vger.kernel.org, AJvYcCVNAO4UL/Uu1hAlaIaT6Cxdi2SzEbKcpXEIS1ta3nk7+APcXd1eKOby/zSYPmSBPjvzV9fG/TWDJSTp@vger.kernel.org, AJvYcCWA/hWTI+mZdJs9/LxSNRV7wiQ6ctgDonpuURLPaKl34TMBuWymqSj14EoPbKrdX57XJO6KfhbbYL0l@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5sxG7cJZdnvZ2n52bLX3gWes7oJnkZg2hpaTColBz0tEEePU7
	w+y7GK04yrhIScqJCOwBooy+GSSaggaQ4db/tUfmrPqmSkDOsjen
X-Google-Smtp-Source: AGHT+IFPQKxcftU84dhm0fkb1SNgKD2EAJn7TvWPiUzYwBNh/RAU+o9AnxfXRexWrzsEQDadMchCaw==
X-Received: by 2002:a05:6000:1810:b0:368:12ef:92d0 with SMTP id ffacd0b85a97d-373118fb7e7mr1771367f8f.51.1724437046167;
        Fri, 23 Aug 2024 11:17:26 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:f90d:5a72:8d56:a041])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730814602asm4677939f8f.44.2024.08.23.11.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 11:17:25 -0700 (PDT)
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
Subject: [PATCH v3 7/7] iio: pressure: bmp280: Move bmp085 interrupt to new configuration
Date: Fri, 23 Aug 2024 20:17:14 +0200
Message-Id: <20240823181714.64545-8-vassilisamir@gmail.com>
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

This commit intends to add the old BMP085 sensor to the new IRQ interface
of the sensor consistence. No functional changes intended.

The BMP085 sensor is equivalent with the BMP180 with the only difference of
BMP085 having an extra interrupt pin to inform about an End of Conversion.

Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 68 ++++++++++++++++++++++--------
 drivers/iio/pressure/bmp280-i2c.c  |  4 +-
 drivers/iio/pressure/bmp280-spi.c  |  4 +-
 drivers/iio/pressure/bmp280.h      |  1 +
 4 files changed, 56 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index f5268a13bfdb..1d27777d8a2c 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -3058,13 +3058,19 @@ static irqreturn_t bmp085_eoc_irq(int irq, void *d)
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
+	struct fwnode_handle *fwnode;
 	unsigned long irq_trig;
-	int ret;
+	int ret, irq;
+
+	fwnode = dev_fwnode(data->dev);
+	if (!fwnode)
+		return -ENODEV;
+
+	irq = fwnode_irq_get(fwnode, 0);
 
 	irq_trig = irqd_get_trigger_type(irq_get_irq_data(irq));
 	if (irq_trig != IRQF_TRIGGER_RISING) {
@@ -3074,13 +3080,8 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
 
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
@@ -3091,6 +3092,44 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
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
@@ -3262,11 +3301,6 @@ int bmp280_common_probe(struct device *dev,
 	 * so we look for an IRQ if we have that.
 	 */
 	if (irq > 0) {
-		if (chip_id == BMP180_CHIP_ID) {
-			ret = bmp085_fetch_eoc_irq(dev, name, irq, data);
-			if (ret)
-				return ret;
-		}
 		if (data->chip_info->trigger_probe) {
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


