Return-Path: <linux-iio+bounces-10304-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E0B9937AB
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 21:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48AEEB229CD
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 19:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D991DE3C9;
	Mon,  7 Oct 2024 19:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgodtPZm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BE41DE4E8;
	Mon,  7 Oct 2024 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728330613; cv=none; b=dsnRBvYSC+sUe/9gxQ3M55aSjp2y3SZqh8pTjC8QcHrxy6jBfohPhSzb5ArKG4R6GQPf3ey6rueCcrR443nD9ZSX8aZYdpHeQl5kPdpQ70TjoDHiNH6ZWeSF9t84Bym9BzG6fv+2Ebb8VnEMvEGYKSt/i8wXVcAUTx24VQ4DofE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728330613; c=relaxed/simple;
	bh=tFrcW5d+M/kISjk43174v7igvL9U7AcDJkDm/U23KrA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f5Mg2t++ypEEcGcJzOHhExxfBR+FMVtuuly+1BzbCsLWVbVWmqSeTrH0Rcj+y3KPjlEoIaOReH8RH3P3Eqs16jbrnayswM1GFFeUJIAHB3uB3rrOtiNcCaeu5d/iKw+MEkKLyoc3gkjI/XlPknrs88Ybjx9Np482k8SRBj/Nb6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgodtPZm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cb9a0c300so44746455e9.0;
        Mon, 07 Oct 2024 12:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728330610; x=1728935410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcV5nc6g7ztCaCXsHL5P5H5wDsK3QY9ven0Gcatgh24=;
        b=GgodtPZmQ+9kbANb1Zr3OuV2yF3l/oHBZT7Ba4KIK2GqjyFuNNxxsoli5xYaCSKva4
         h68+jQrTFhLZ+K9vT2bcYNpXMUM0VR3suAfavyxlPHHxNRacqs9dNpoWtgywhSj/s9zc
         yyrCoXnOwmpEtHqxWC7ZF7JBI+vjkZbNoBue5U7KvA0QflemAgWx61bNuGsYW92QAb8c
         HIsSJz51QVmV9lclvmshF+azq0/4MzxSuui/wQRoY7Z++oUYJ1iQhF2IAcSoK/FTJCoS
         8s+GDf9NQI6ok5vZgS+4HyKZmQmRJhw9mWPkTjshWI6W0/W2UE7HvpeRVwRRHVjl+wyt
         pZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728330610; x=1728935410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CcV5nc6g7ztCaCXsHL5P5H5wDsK3QY9ven0Gcatgh24=;
        b=xL/ophGqL8QSV9gH2G+wIs8+FyN0QKQkd8f+Zjv0rBPhf37/qD0VjvPTGk2pNCHtgi
         cJal8JQ0T8ov2sWzAjSYFAIx2eHsiv/FuGyH4sjrJZSqvj/xr8DARZyfTWbzRpK7llUR
         IP8T/t/5k4udcxXmIEBiIKt/SUW9TG91TO8LwpzMVtYYgQBEZvOfaf7aaJJfOyE8X4hK
         756UGcIycpc+COyC5nmodXQucaMQPEt1UyPw9HefwVNhJp2ILHUgetQNWQQxhqzq9E1L
         3LnNa0WHfGBgxxx5FYIO51obFPpYBsLAxEotCPlKMOi3UBvGPW/y3MEqTe4lOtkY/t2J
         ho0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWe2f3ixxUBFUPpph/d4bFoNOz+eGQBcEIN8hVOB+tccjlZ13I551IoXrcB80pL3KkJUxgV5InZGEhS@vger.kernel.org, AJvYcCX5V3bLT001AKK8Nl15/Pzw7kY1gEqwZPkBf+bh7Lou2Yo3Odzc+Qa7UvofiRrxxtycq7Q48ukZ6c5aBuav@vger.kernel.org, AJvYcCXJJsVyyMKHVabWSMXdnRCLLZFfhXYMx632nlRArFY4+5ypHzrz40HPnMxqDrU4sQpzd19Og3iQQ9/a@vger.kernel.org
X-Gm-Message-State: AOJu0YwBTMf9ZLnrDEZS10N8/xn5IBm/dbO5s5bBUQu0Qev4oCFVbHpN
	buoMND25XnjNnra4/9cU6rZ3z1Z8gdfyIxCNkinheKEnENNCsgMx
X-Google-Smtp-Source: AGHT+IF8YOahGsBOIEgvzA6NcPaGblkbMEYW+U8h/tSg6gqbzFGf+1LYGrlTNeLMDB5iX5YwVQmI2Q==
X-Received: by 2002:a05:600c:190b:b0:42c:be90:fa2f with SMTP id 5b1f17b1804b1-42f85af4582mr96309255e9.25.1728330609833;
        Mon, 07 Oct 2024 12:50:09 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:b658:eac0:bb05:9042])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ed922esm84939655e9.39.2024.10.07.12.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 12:50:08 -0700 (PDT)
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
Subject: [PATCH v8 4/4] iio: pressure: bmp280: Move bmp085 interrupt to new configuration
Date: Mon,  7 Oct 2024 21:49:45 +0200
Message-Id: <20241007194945.66192-5-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241007194945.66192-1-vassilisamir@gmail.com>
References: <20241007194945.66192-1-vassilisamir@gmail.com>
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
index 5779e1977a7a..da7ae7e3164c 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -3070,13 +3070,16 @@ static irqreturn_t bmp085_eoc_irq(int irq, void *d)
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
@@ -3086,13 +3089,8 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
 
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
@@ -3100,9 +3098,48 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
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
@@ -3274,8 +3311,6 @@ int bmp280_common_probe(struct device *dev,
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
2.25.1


