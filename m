Return-Path: <linux-iio+bounces-8854-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4BA963309
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 22:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769361C23DBD
	for <lists+linux-iio@lfdr.de>; Wed, 28 Aug 2024 20:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC9E1AF4EE;
	Wed, 28 Aug 2024 20:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+LiPNf+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEAB1AED27;
	Wed, 28 Aug 2024 20:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724878307; cv=none; b=P+hiPkPhTMQ+3j9JwdavMbpsG6Hi900JVIJzk0YSsh9kDeYpN41DXasgg02O93N5/5NIcY0Jfy94k4249gpb/PRLgdk7DVe+n8YvwFYk67N1fJMHjWC9xoeNK7K1veTmR27YSqubgoS5P8PEM7JZVPmm61rKb7rzF6e2na2khCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724878307; c=relaxed/simple;
	bh=VreTkHUpnWR7lb3dgZZXyDCzLJCJBO5+ymQLc/S2b7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R1PHXfFUYVezy0Qmnqgi1rxNULQIuJGmQ/d1BoG9NjOGmF+J/8giCPAw4f55KQyCBplEubLeXISOtR6h7Q5z7udPsVNK2AMFWD4t1UroamdAzuJGDhkfjlbr/MSzZ7RVCj2D2gpjcmngk8etdWvVYSn2QR5XvsU43e2JbsgJhXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+LiPNf+; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5bef295a2b4so1955631a12.0;
        Wed, 28 Aug 2024 13:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724878304; x=1725483104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qSJgUF7j/CDv51LHyvaqoomolwU97+ab+ITbPInKXdU=;
        b=W+LiPNf+Nm9u+oUEPMZ0aJDSh9cOxrVxYEn4WvArsWBH1L3OpoXhaLZdLaDIdhH+H0
         I0Oc3i6MlH8pLoTmqEDQ71dyfxHtZXsrT+LH+00NAWOeXjAfFUyL8cmYiw0FILSBVuUj
         weErDRVKsRosDUJA4+0oi2PBQpLsAVrgYrkP5m501ZrFSyDEUJAe5GagZ++QQxwJlUCS
         9XaHzBePftH9olkBIzBIP1rp+1yH/lVNQrKqsglcnt62+WVmLUB+VcE1eXSKhvTW9Sjz
         dFv6vWP/D8fFYDwniudupfpHNP4gAkXiQv9jh50uDJdm7b3F575tWANFVJ4OmG8UHtbo
         jRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724878304; x=1725483104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSJgUF7j/CDv51LHyvaqoomolwU97+ab+ITbPInKXdU=;
        b=Os5ukGv7ZoOqA+ZsMc8+R0KhmWU8V9Ko205hZ4sSZaQhhZ+IYVCIX4Ozn2H3fuCMaR
         e7NAbl008jA9XgV3fKZP9n7TTasNcqlUtX8GHC8tN4tlsiO/DtPTfInMK7ivRog5mkZS
         Sxs/Of2mrBYC5ahUPrvJotZAEvfidGq3C0mFlhJdcGRVpReHFx9gvvbbaU+BTBPIE5l1
         JK6iMBrrzSfagEpwka7m0kdoyjTMWAr6s5y7Bdd9WSk7LXV/mQV0n5wT+hydSQgkggzj
         dLA+b+FIGBtHJErDR+R3u9fbnVFsTEFBnTTWzOJIg+lnPjkU2+ke4csxx8/d6eTcPcdF
         sHhg==
X-Forwarded-Encrypted: i=1; AJvYcCUHgojU+SpfvO/xWkE8Pa32yZ95PEv6WA8lzElwipIGwH9iHE8tvcMJG5n7Oowgu9vuOiNbyZLfSy6i@vger.kernel.org, AJvYcCUj+/kFALZAH2aT/4yITn3/eb9Zu9OVtBm1xpBCgjc94OJ6xTWoLT+AKzCBuD4znYIK+qEiMTLN2ZWJ@vger.kernel.org, AJvYcCWamLGxvHmzDxofq5k+/ECpxGUkUa7335WPM8fbHgHhzfOKSLCHHUn/G0hXAoCedvsaW0a6p0icopemx56D@vger.kernel.org
X-Gm-Message-State: AOJu0YyIwURcAGz++whmsqhMboOKcR0JVROvsEIdE5CfPRLCq0b4J0jY
	U0GEOOGWJKn3jWXBNFWcrSyaJFQgcOztxnLZOjZz2xtJPUtYT4Yd
X-Google-Smtp-Source: AGHT+IF7zUV8JYYcmFlef3xIaxgXgO6mzL3vCdS2v5HnNCXh+nN+nGhJg3NRsYnMOK/7ocUTO3PmOA==
X-Received: by 2002:a05:6402:26c2:b0:5be:c2c8:8631 with SMTP id 4fb4d7f45d1cf-5c220126f2amr423487a12.8.1724878303595;
        Wed, 28 Aug 2024 13:51:43 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:4c6b:aa66:d4d1:a1d2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c0bb1c2f53sm2646566a12.19.2024.08.28.13.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:51:43 -0700 (PDT)
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
Subject: [PATCH v4 7/7] iio: pressure: bmp280: Move bmp085 interrupt to new configuration
Date: Wed, 28 Aug 2024 22:51:27 +0200
Message-Id: <20240828205128.92145-8-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240828205128.92145-1-vassilisamir@gmail.com>
References: <20240828205128.92145-1-vassilisamir@gmail.com>
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
 drivers/iio/pressure/bmp280-core.c | 62 +++++++++++++++++++++++-------
 drivers/iio/pressure/bmp280-i2c.c  |  4 +-
 drivers/iio/pressure/bmp280-spi.c  |  4 +-
 drivers/iio/pressure/bmp280.h      |  1 +
 4 files changed, 53 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index c37c56446183..948d11c6912f 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -3065,13 +3065,16 @@ static irqreturn_t bmp085_eoc_irq(int irq, void *d)
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
+	irq = fwnode_irq_get(dev_fwnode(data->dev), 0);
+	if (irq < 0)
+		return dev_err_probe(data->dev, irq, "No interrupt found.\n");
 
 	irq_trig = irqd_get_trigger_type(irq_get_irq_data(irq));
 	if (irq_trig != IRQF_TRIGGER_RISING) {
@@ -3081,13 +3084,8 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
 
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
@@ -3098,6 +3096,44 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
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
@@ -3269,8 +3305,6 @@ int bmp280_common_probe(struct device *dev,
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


