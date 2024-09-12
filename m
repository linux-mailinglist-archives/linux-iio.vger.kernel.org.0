Return-Path: <linux-iio+bounces-9478-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 039319775A6
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2024 01:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B571C2421E
	for <lists+linux-iio@lfdr.de>; Thu, 12 Sep 2024 23:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE311C2DCC;
	Thu, 12 Sep 2024 23:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g503qOO0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650D31C4608;
	Thu, 12 Sep 2024 23:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183972; cv=none; b=GKYjfMwru5X9i6InS24eb0IGfEefEDK/PMVs5nsHr1y8SqZueQyonHD/SmIl0lsqKq7JCI0ok8zihXIrL/Zw/sMu6LKK2Nu/KFBto97c17i2xnrjeWr1czpqkZDiza+z/uWUsiWvl39afWqc6DklqK++8Vl/G8luBPhoz8nQg5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183972; c=relaxed/simple;
	bh=IMdK6CM7n2UE2KTXgKXeKu13+AE6eDtegLqiRQZjprs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IvZmMaSrbJj7RRcr8iDgv0y4d6W1hftAxJzUCXHA1NEo61A0wMtQXfTWnDn/ZtjoT1DCw2tW12ZtTEQ8i9jL8MN6R6g4ItqXNB6hPYfZdOwxGvVoia68Gqcx4B1e8wZk0i9XnjOKQvuQyyJEcFNqZ9p5hkEH/hXqVhoSpyanqpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g503qOO0; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so2546188a12.0;
        Thu, 12 Sep 2024 16:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726183969; x=1726788769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqwQ7JL7fOO85Nb8rlmfepwDiK0LjY4ueeTzmShtwSY=;
        b=g503qOO0ukknhvMrtFZxk2ao4lEVWSgpdo0J3UrWMeDMLEvb9h5dUeVVix6HxmeGoE
         TKrvEq+0o7r1EpcF+7N42wQrL9OaQ1EeoL7015pIBHPSu62W+elgiHPbc8R8sHqYRRmp
         GcBzNHuHA1OMP+YcB6solL70NLyBLXHLXQekZxQXXLDCsisgCNlyIA78CZYZln+JNJYp
         Le+5f93qpd59BPBKNrZGmAF8fNJ9SKraaDeixlLuaYnwbsv8QfbpZTZXOGL/aNuFNeIA
         wpgO7sOaRNuaMlN7twbTmSoZZzLvhJlAgvW7++FlOEVOR9UAHNQjegqLT6L4ZdJxarts
         OZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726183969; x=1726788769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqwQ7JL7fOO85Nb8rlmfepwDiK0LjY4ueeTzmShtwSY=;
        b=NswY7n7+PKYwpxTR8Z687wU4pnAw0V+3tSELMPzHTN6d/Cd26qIxt/77Za3tNGgOjc
         bRnsSQWlmVoMVkluMzhy9G2Ts4EDpZ9CgS5BO1ykOu68vTDWSVs/IIQhUMfzT271yzX7
         hoslj0xK/nqGoRvcEGdqHV5eFKnDbaWpM5RGfT/ZaX2WIdkNjiY1hbQg2Xd4q6qg3hON
         qyLx5ZiTRBQP2il5GubgxsnA/pZiJdRdr0Jfqa5GO7QzeKPQilHKHy1LDCa80f5s+Its
         vcuWHuGqeijKs0bNXaUcS3Kb5AfK0LIdciuZ6er1Za11i0YXyODfxB6ogpoTLT5MMKdv
         yD9g==
X-Forwarded-Encrypted: i=1; AJvYcCUDi86BxWOotdUALYYUt3dsLqnQr5Cf+Ebu+eeISVThnkg9iaFhiL1jBavTu+f44xV96+ud0kEtyhXRlOb6@vger.kernel.org, AJvYcCUkPgq9lTIR6V3EWTgiEXXGG71J+Zlx55vv5f7p5WmDyHKQzUX37Rg3ojMwHtym6x5XmznaMacAdqKi@vger.kernel.org, AJvYcCX/pDIakYwg7Xypi1bXOzxQk/sS9aYIdQKfEefJB281omfXn6DjAtiZx8mV9A8Cx3AJQDq7/Flo0K6r@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy6M4QRKlrjk8J0L478ZfGDeg4FCvPUL1WoV4rAq9cVfUogjrc
	Qsx2vdSXe0zkHMH82IiS7JA65thYgAkDpNvwEv95VOMSW6EBNZOS
X-Google-Smtp-Source: AGHT+IHF7VO13uxY63KCiCGO9v9jWvCm9YU2OPyA6MrGU4lyy0vBBEizw18TpccAmE3zjRP/UN/RGQ==
X-Received: by 2002:a05:6402:5c8:b0:5c2:5254:cdc4 with SMTP id 4fb4d7f45d1cf-5c4143874bdmr4320041a12.17.1726183968173;
        Thu, 12 Sep 2024 16:32:48 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:85e4:cf41:16db:65d5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c421aab306sm26693a12.73.2024.09.12.16.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 16:32:47 -0700 (PDT)
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
Subject: [PATCH v6 4/4] iio: pressure: bmp280: Move bmp085 interrupt to new configuration
Date: Fri, 13 Sep 2024 01:32:34 +0200
Message-Id: <20240912233234.45519-5-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240912233234.45519-1-vassilisamir@gmail.com>
References: <20240912233234.45519-1-vassilisamir@gmail.com>
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
index 0edd756ef8da..c949faaf5869 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -3058,13 +3058,16 @@ static irqreturn_t bmp085_eoc_irq(int irq, void *d)
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
@@ -3074,13 +3077,8 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
 
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
@@ -3088,9 +3086,48 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
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
@@ -3262,8 +3299,6 @@ int bmp280_common_probe(struct device *dev,
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


