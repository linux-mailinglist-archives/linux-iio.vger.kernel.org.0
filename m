Return-Path: <linux-iio+bounces-7521-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BEA92F0F3
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 23:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75B511C21B7F
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jul 2024 21:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E271A2C10;
	Thu, 11 Jul 2024 21:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+vA9+1t"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EE71A08C3;
	Thu, 11 Jul 2024 21:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732592; cv=none; b=QmvEGAFU/cCzOmtlb7BB+1NzPlgZxoRvjegP57Lhoaclt07rPrPWEQ52n1iU/5THyqM9vqPacXjGRwXj8ktTC24RfIvEL9SUx+g/xp6KB/abBOFB8bhbAc5NU99xHfDaJfzfLrlT3Exn2/nkZY+yiSU69JroX8j6R87JTFv6G6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732592; c=relaxed/simple;
	bh=aSBhTkkoLHZFWl60nBtEjUz2JQQz1WXc3mxknELd6WE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PPKz2J1l06z0cJwpta8H2P5cENs/1KF2mrSEjPU++7fC3r2QpcHb+jh9TNZ4pqpUOnpegh/BvGuRYCLAgjQ7D9qtiKIFonAcPBdBUZ6W/GcBbZiktPsDecZSe/Tg6deyywBMfNsygL17/n1aos+W5jf0GOXAR8tCBlTWVOP5WXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+vA9+1t; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-595856e2336so2235134a12.1;
        Thu, 11 Jul 2024 14:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720732589; x=1721337389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCKKw6ZGeRpSiHrVmvFeUrR/FKl0FfFZJqKXYoh168A=;
        b=L+vA9+1tHVSIBKtvjlFReVowz8Lggid7v/Rf/i0yJRwIvOcSCZriI57TwrbAZiBsyP
         hPGESLuWuWduru0YnZxkhDdjoEIj3Sx/YvaYXWqFeeh45SQLDQFgvQXtdMPx1Wd2cFjL
         TLuyu5eIUaC65q8MLLvo3uJoGDzuEO9ZSWnXL/guSJ5Fso45cfv/ttOc5hGQqqeEV9mQ
         73sMti52LUVPAGFHC5TLDBO8x/Q9+SjyvFf2YbsJmI8j6ab7ucLKc6QZ3TNI9k+77/yM
         SNKiJHtFVEC7Iglv2LKgikcj+9BjcU4KX7XJBXwclrH6FaGUhATIxSwIDI22wA3klNSW
         bz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720732589; x=1721337389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JCKKw6ZGeRpSiHrVmvFeUrR/FKl0FfFZJqKXYoh168A=;
        b=g6xPyEH+QvPsaflKLy+8m/ulsN1ZPBWGFhixKqwLIDU6hH0iS/Yjjjx5wK1t5rBVFU
         Me5SnWD21NbQCRZcAPLJyJ33RHVtLsuk2h9xY5tyWlRXjDOOjR+/viFN4auQ2LRjbNmi
         AcOIETsI03xiRvykKB/4oFdPB6bGQ0KrGCKjzSQ0nE+PloSXRHo+l+N9YqAx68YNPRyi
         QbEeGRJ+EGw8OJQOE/Cbjm+2RzgxrCRNHq4c5x6QIT3U/9cRBgNhtg/rJu+FVXD6HFsA
         wSXFNvc+uLG4qgH99rLZNPgxeS/UXyNVq4Nxq5dNEYWSmaaF6wwDZeBGvPRzfqPaeGQ+
         awmA==
X-Forwarded-Encrypted: i=1; AJvYcCUtIqwsuLO1rkoqXP2JfjfCF4myasHQEkEEdsK/edjK+hSaLi/X4qBy192PCs52F4b4daXoVKhdiWqIFVXAdR08Q8Trd5siKvefVlAD9JFt2XUKtugg+CtI427OwCMysOb8flM+HvPo5cn5YyO1u3F/ECv4DBIr8TFxAOZT6HrPbdHTog==
X-Gm-Message-State: AOJu0YwDeARt3nFnRfjsHF9N1jwP2SpaDH3QXh/tCH3b5YNPM0Ihi6sN
	Y1GBbW6l1J8Cuerhcxy4rsmQdkU7IlVe380maHa0TEUAv8K2qk4h
X-Google-Smtp-Source: AGHT+IGE4NWKCAqde8ANroEgTkk0EAevT8quSYx4DopJTl9SwToGdvgXUADw+1bALN6TzndvFNmHhA==
X-Received: by 2002:a05:6402:2107:b0:58c:36e:51bf with SMTP id 4fb4d7f45d1cf-59963bf43a4mr693987a12.3.1720732588654;
        Thu, 11 Jul 2024 14:16:28 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:3e02:47b2:c845:ae3a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bd45a1b6sm3815737a12.60.2024.07.11.14.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 14:16:28 -0700 (PDT)
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
Subject: [PATCH v1 10/10] iio: pressure bmp280: Move bmp085 interrupt to new configuration
Date: Thu, 11 Jul 2024 23:15:58 +0200
Message-Id: <20240711211558.106327-11-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240711211558.106327-1-vassilisamir@gmail.com>
References: <20240711211558.106327-1-vassilisamir@gmail.com>
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
 drivers/iio/pressure/bmp280-core.c | 72 +++++++++++++++++++++++-------
 drivers/iio/pressure/bmp280-i2c.c  |  4 +-
 drivers/iio/pressure/bmp280-spi.c  |  4 +-
 drivers/iio/pressure/bmp280.h      |  1 +
 4 files changed, 60 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index ee9b9676ad10..f0443016a2f7 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -3073,13 +3073,19 @@ static irqreturn_t bmp085_eoc_irq(int irq, void *d)
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
@@ -3089,13 +3095,12 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
 
 	init_completion(&data->done);
 
-	ret = devm_request_threaded_irq(dev,
-			irq,
-			bmp085_eoc_irq,
-			NULL,
-			irq_trig,
-			name,
-			data);
+	ret = devm_request_irq(dev,
+			       irq,
+			       bmp085_eoc_irq,
+			       irq_trig,
+			       indio_dev->name,
+			       data);
 	if (ret) {
 		/* Bail out without IRQ but keep the driver in place */
 		dev_err(dev, "unable to request DRDY IRQ\n");
@@ -3106,6 +3111,44 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
 	return 0;
 }
 
+const struct bmp280_chip_info bmp085_chip_info = {
+	.id_reg = bmp180_chip_info.id_reg,
+	.chip_id = bmp180_chip_info.chip_id,
+	.num_chip_id = bmp180_chip_info.num_chip_id,
+	.regmap_config = bmp180_chip_info.regmap_config,
+	.start_up_time = bmp180_chip_info.start_up_time,
+	.channels = bmp180_chip_info.channels,
+	.num_channels = bmp180_chip_info.num_channels,
+	.avail_scan_masks = bmp180_chip_info.avail_scan_masks,
+
+	.oversampling_temp_avail = bmp180_chip_info.oversampling_temp_avail,
+	.num_oversampling_temp_avail =
+		bmp180_chip_info.num_oversampling_temp_avail,
+	.oversampling_temp_default = bmp180_chip_info.oversampling_temp_default,
+
+	.oversampling_press_avail = bmp180_chip_info.oversampling_press_avail,
+	.num_oversampling_press_avail =
+		bmp180_chip_info.num_oversampling_press_avail,
+	.oversampling_press_default =
+		bmp180_chip_info.oversampling_press_default,
+
+	.temp_coeffs = bmp180_chip_info.temp_coeffs,
+	.temp_coeffs_type = bmp180_chip_info.temp_coeffs_type,
+	.press_coeffs = bmp180_chip_info.press_coeffs,
+	.press_coeffs_type = bmp180_chip_info.press_coeffs_type,
+
+	.chip_config = bmp180_chip_info.chip_config,
+	.read_temp = bmp180_chip_info.read_temp,
+	.read_press = bmp180_chip_info.read_press,
+	.read_calib = bmp180_chip_info.read_calib,
+	.set_mode = bmp180_chip_info.set_mode,
+	.wait_conv = bmp180_chip_info.wait_conv,
+
+	.trigger_probe = bmp085_trigger_probe,
+	.trigger_handler = bmp180_trigger_handler,
+};
+EXPORT_SYMBOL_NS(bmp085_chip_info, IIO_BMP280);
+
 static int bmp280_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct bmp280_data *data = iio_priv(indio_dev);
@@ -3277,11 +3320,6 @@ int bmp280_common_probe(struct device *dev,
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
index 73d0d25ae0f4..1c1e3001efc9 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -522,6 +522,7 @@ struct bmp280_chip_info {
 };
 
 /* Chip infos for each variant */
+extern const struct bmp280_chip_info bmp085_chip_info;
 extern const struct bmp280_chip_info bmp180_chip_info;
 extern const struct bmp280_chip_info bmp280_chip_info;
 extern const struct bmp280_chip_info bme280_chip_info;
-- 
2.25.1


