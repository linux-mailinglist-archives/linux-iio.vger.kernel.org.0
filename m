Return-Path: <linux-iio+bounces-10703-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3337B9A316B
	for <lists+linux-iio@lfdr.de>; Fri, 18 Oct 2024 01:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 562A91C24B58
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 23:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E402C200CB2;
	Thu, 17 Oct 2024 23:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/eAMONq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F9B205AD5;
	Thu, 17 Oct 2024 23:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729207842; cv=none; b=k9vkoZiqZmrnXxbqXc7cuSvdZPc9+qYEdgXEKh5G1nmN7LrimXrnTjalSBHSELBzP3Hg7AyECjMEOtMWRshWVyrkRCGdi1QlH/mEGWFGYOtUrpcKAFVcztTHZA0byCd/Nl6oub4ybGBo429L41ILNtlc/feOM3tUJHgRybuvSFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729207842; c=relaxed/simple;
	bh=hKiO/5RQQmD5FWUdZeySdsJxjFc5Ch+XC/c/iVI89+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OatX0q+G4qxLkqvPRc9YerfrjwwQ25aCw4mg42fn9UCdNS4TeZeVZ3b5GXdJcyY8xfTfl30uvXXoX1qWqyFSDjQk3pnmuEAwgLH+eWmZclgYezW2eDWzQ+XkYUGZ40AsQTZYNLHAFw6JN+iwjCFGYnM9nE89dofTaaaPtcD+p1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/eAMONq; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4315baec681so11916065e9.2;
        Thu, 17 Oct 2024 16:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729207839; x=1729812639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DQoEPUhCbdcxhsElGFNYL61baylOpGR0QKhkPlDj1w=;
        b=V/eAMONqoGZX6WURL5BIBHzgFVmxB7b7o8NS5lKoWSa2aRxAZ2t3Z+ZTcXlRTEr6V6
         AfK9EfhuhYO4W8rzMcwAqE1ygvZdp9k7tNFKGUz9RSWd/+RV1JYlnp8AgwDIynLTUASt
         fSg4MitnRNZngngZx8EIqZb7FUaA3Vzo6rHqwonVJzJEjjuoeFJf5pgp0MnfwAv+efiV
         7f7tdo2T/kzgYMJL9fwufdU8Y/UMohzB/DEPBIwZzNwqWyPIZU4rJ1CM7YnqvgdgudL3
         T42qFJ+X2yaFLVC7AZqaEjoEdnL3+wLgQOcMe4K7fI+cfqEd4jdpIqPnnVwSr9IO4UlG
         d98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729207839; x=1729812639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DQoEPUhCbdcxhsElGFNYL61baylOpGR0QKhkPlDj1w=;
        b=S2QIwc3jJVxYsy3aDSSvLYYmCbnYy1fE6KbYmB7Y0YeVG4wCm0FOoc1zY7BhHyQcEB
         p99BSk2pwXaqOwgC+2gc0xVLjNMhKa4hbBlxM/hD09yzCNgrjgsfSosjNlu7L1/3cQN6
         SKd0OJdl+D9xEsMiFDlXRXhONDZ2u7zZuPVDakO8iOCNve/PsDEk8/5H3R6jwjhLZfjh
         0d/1+A51iPBTipmLyjtHscJOu5N7ZoL0tMkvqL6i8AwWeMF9kByQbj20DWPQEuFA3eRT
         nVE0piZOlWjmqrBksBJK0ifsWT78gY6Hbrkhqyht3GcyuI7+92LiIopCwH6ZMB9PyezS
         Z5Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVTm8NI935yWA8gmiUlk1/9Tj80izakDnAR8bSrfAdHYmEgibrse6rEJ1xx+AneBwCKB+VDxaBgK25m@vger.kernel.org, AJvYcCVls1v1RIX1QLDdVTwEAS5AKo8jZvL6a4SOMmK0t+cTOLV6PiI2BGChbUxvaA9IvpWOFq3pmofrMhq0@vger.kernel.org, AJvYcCXGjV0m83mZv7+TvU4/mPBSuKXwqe1MjSXSqVahi1uEoN5R/5PPJyKasYHVHmEf1T5rYGn3RmUdyck7npIM@vger.kernel.org
X-Gm-Message-State: AOJu0YzmESRHwaceK7Zakia0NlD4IfuFPlbe7OyBhklanm20xHLzvvj5
	nd2tCT6zV/BhXgFx9T1jqGqH1nDrP8Jityp5I9ERjVBNfXmMoIlf
X-Google-Smtp-Source: AGHT+IHkNnBRKNWorLhD9+bPoqfN1N6uj6wLi1HJ8yQMJGus+AMP/brEKSZTZXWQR26gwfV5BCjalA==
X-Received: by 2002:a05:600c:1c8d:b0:431:12a8:7f1a with SMTP id 5b1f17b1804b1-4316165d3acmr2705855e9.16.1729207839008;
        Thu, 17 Oct 2024 16:30:39 -0700 (PDT)
Received: from vamoirid-laptop.. ([2a04:ee41:82:7577:8661:df0e:b445:43ef])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37ecf06d3casm306939f8f.48.2024.10.17.16.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 16:30:37 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@linux.intel.com
Cc: vassilisamir@gmail.com,
	ang.iglesiasg@gmail.com,
	ajarizzo@gmail.com,
	biju.das.jz@bp.renesas.com,
	linus.walleij@linaro.org,
	semen.protsenko@linaro.org,
	579lpy@gmail.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 4/4] iio: pressure: bmp280: Move bmp085 interrupt to new configuration
Date: Fri, 18 Oct 2024 01:30:22 +0200
Message-ID: <20241017233022.238250-5-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241017233022.238250-1-vassilisamir@gmail.com>
References: <20241017233022.238250-1-vassilisamir@gmail.com>
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

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/iio/pressure/bmp280-core.c | 63 +++++++++++++++++++++++-------
 drivers/iio/pressure/bmp280-i2c.c  |  4 +-
 drivers/iio/pressure/bmp280-spi.c  |  4 +-
 drivers/iio/pressure/bmp280.h      |  1 +
 4 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index a941423a899a..e5ec8137961f 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -3028,13 +3028,16 @@ static irqreturn_t bmp085_eoc_irq(int irq, void *d)
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
 
 	irq_trig = irq_get_trigger_type(irq);
 	if (irq_trig != IRQF_TRIGGER_RISING) {
@@ -3044,13 +3047,8 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
 
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
@@ -3058,9 +3056,48 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
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
@@ -3232,8 +3269,6 @@ int bmp280_common_probe(struct device *dev,
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
index 12f6e90b3728..2df1175b6b85 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -534,6 +534,7 @@ struct bmp280_chip_info {
 };
 
 /* Chip infos for each variant */
+extern const struct bmp280_chip_info bmp085_chip_info;
 extern const struct bmp280_chip_info bmp180_chip_info;
 extern const struct bmp280_chip_info bmp280_chip_info;
 extern const struct bmp280_chip_info bme280_chip_info;
-- 
2.43.0


