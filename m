Return-Path: <linux-iio+bounces-7901-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEE093CB20
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 01:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 812841C20DE3
	for <lists+linux-iio@lfdr.de>; Thu, 25 Jul 2024 23:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C449153838;
	Thu, 25 Jul 2024 23:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2nsvYgo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EBB148FFA;
	Thu, 25 Jul 2024 23:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721949059; cv=none; b=S9D/A1MV8/VpL9l1DSknqNQ+Bqxe2HdBKs09Z9nT7JScjhXQjXtTVQTm1i2CY0mGhAF9bragaWobSmUiR1izw0yD/ec6fBD0WZdPTo+M73pGnyIquCs4YyxGygrhJFyztJvAQcXAs/Z9qcQMCsLK2nUR0EShVKAbmXCZJzADlBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721949059; c=relaxed/simple;
	bh=9D8KeeWQetlsxoUFL1ugZb8b7TzMgt6wdKDF9O+wkAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZDrALFspZnipAlHu9GeorJTuwe2cO/T9SARceKeiIwUgJUuryI87RMKTOBJC3Zuhi5Gbu7msw8G/Vgg9bFQSRAu98aEY6EnPBk3ZY6pkPoKvRaL0IppRfA6un1MM6ByXu8hN5OHPI+2iKvzoT89So9p1W39Aojtx+/7WzSnpP98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2nsvYgo; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7aac70e30dso127594666b.1;
        Thu, 25 Jul 2024 16:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721949055; x=1722553855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yH/r578wFjMh6wCaBg5noMdZdwOXW0ey4GWvjb4wsc=;
        b=K2nsvYgowqdO+JOo6OODgtdmESZybi67/hQY4CKfl/LNE0S7JCtTfH/vSGN4W+OkoA
         13lRouD8YPOlEY/B4P3xFIm1udXZ1s+Tuv/OsPksj65xyin+uGNfQOoVz90P67GtshCB
         7WuE8Hfy7nxiLUj7+zU21na/V49yi3L240oE922mKSDTCB/f9LFk+pAvcvB5YMPs0ljR
         7GjaQcKKw3FSntjFDj2pqITleK704ik8aZahugPORUkecBR+omGn0wB+VV7nil5I9Jzy
         xTt6pB8RldF5GdM2x5RfGkhjg65ypGxQwBPz5qe5GoPesiNgLPbzfsx1R8d2w/8wQJ0l
         mjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721949055; x=1722553855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yH/r578wFjMh6wCaBg5noMdZdwOXW0ey4GWvjb4wsc=;
        b=Wzjcq/XH1fkLgA1iOxA+L+1yRCHGN3hYVlIuDBMguk9HCvTulWsrVdWK4k+qvOL0f9
         JQyJOtjucs9G8quSpLbCQqsVk7Nvgm7Vee3jl98ggeKJEC3VM+RbR+9WYA/Od2weXf7/
         tHnQr5UlDvVN3Dh2WtLeIIzcesW5aBZyAtgDS/NRCbwgLEQJHDD0XfoUu2WICYD3UQm5
         /zi+XizHcdYojytlfrNAQQKV2Ce7LeXRSeDedcuMtjEiWptaoO1k9n1CStcL4Evg7O6t
         Ye2G4yW/+CBDZVQDPLZeoY3vZVhcKdSSYtrQgKHClEOS18RLgVXLqaqbTok1S+v7cA3z
         r1GA==
X-Forwarded-Encrypted: i=1; AJvYcCVUNmHlnQiKeOndw3YH42LfoHyNtFC52RxWeaY1ldt+/r6bW6pAmLS+1YLK6ueQ4ShnbgdhJCHeciJzRbEE57fXHrffI2e/KBjs8d2tuvCTXniKtqxf4GWcwYA0IBWG57K5s2k81HVZRv8UhGOT1zIvRcxGsRor1mEOFuslbF9Wwgpq8w==
X-Gm-Message-State: AOJu0YwZg1rHt4webLxLoMlBTffsd3vMI0mpjY2ZvbQjUH7lNGaedAO0
	gNvBePFXWX8rtql36TxlBYhwLApEP5pxXoIChRTybLlaO3spfksL
X-Google-Smtp-Source: AGHT+IFo2q1MpsO2ErSRtpEkRaKVPUk7wMMO2zAHnU7nDDgYe9DCk22CUlIb5k4Jh/lwhTLoC++d+w==
X-Received: by 2002:a17:907:948f:b0:a77:cf9d:f495 with SMTP id a640c23a62f3a-a7acb4a223bmr286639466b.40.1721949055314;
        Thu, 25 Jul 2024 16:10:55 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4b59:cba2:6db8:9f30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab236e3sm115429266b.25.2024.07.25.16.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 16:10:54 -0700 (PDT)
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
Subject: [PATCH v2 7/7] iio: pressure bmp280: Move bmp085 interrupt to new configuration
Date: Fri, 26 Jul 2024 01:10:39 +0200
Message-Id: <20240725231039.614536-8-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240725231039.614536-1-vassilisamir@gmail.com>
References: <20240725231039.614536-1-vassilisamir@gmail.com>
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
index 4238f37b7805..e4d017358b68 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -3104,13 +3104,19 @@ static irqreturn_t bmp085_eoc_irq(int irq, void *d)
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
@@ -3120,13 +3126,12 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
 
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
@@ -3137,6 +3142,44 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
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
@@ -3308,11 +3351,6 @@ int bmp280_common_probe(struct device *dev,
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
index 754eda367941..1307eda6f283 100644
--- a/drivers/iio/pressure/bmp280.h
+++ b/drivers/iio/pressure/bmp280.h
@@ -529,6 +529,7 @@ struct bmp280_chip_info {
 };
 
 /* Chip infos for each variant */
+extern const struct bmp280_chip_info bmp085_chip_info;
 extern const struct bmp280_chip_info bmp180_chip_info;
 extern const struct bmp280_chip_info bmp280_chip_info;
 extern const struct bmp280_chip_info bme280_chip_info;
-- 
2.25.1


