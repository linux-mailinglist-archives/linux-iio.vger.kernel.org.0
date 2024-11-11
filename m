Return-Path: <linux-iio+bounces-12137-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2949C4245
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 17:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34341F2574C
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2024 16:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9417A1A0BFF;
	Mon, 11 Nov 2024 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kn3gIP/i"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992AB19F430
	for <linux-iio@vger.kernel.org>; Mon, 11 Nov 2024 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731340789; cv=none; b=GPUxANQx3nQDWSlOsWDsb+1MDKKe9i2b9wQ8GMhz7VHILdn3PjhqCOMxMGrbDJrFA6ybaOsWLj+bk/irAAho+hZQdlBMyMslWB5/RSsfavHPIVi90+muN3l261AlUgDwmtqZA6prV7DQ/GJUF48sLcQXJXG1BH8yI3dZD3Y8WC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731340789; c=relaxed/simple;
	bh=HDcW1VcFC6TUobbEsvgtNwj7T/A2DfMJi7G65Cb9CEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RNn8YoMr9RNz1nvtDWwkMhN2pjI04bglNy/6ZKZWgMgaO+ACt+zGMnSb4g8SYEhBTAmFyIrwTlJnHiuLg0u3twHbiintX4pVnw03BxlPEKSutLeydprPAG2RTqC0jhpRYGGCU6IxVG+r2TjhzngmL1pvfXokbICiNHv8z55m9D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kn3gIP/i; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-83abcfb9fd4so179654339f.3
        for <linux-iio@vger.kernel.org>; Mon, 11 Nov 2024 07:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731340787; x=1731945587; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MRx61QutqkHqE8LsifHeDvLFt2mQ7Pk/J2Li4P0J5EU=;
        b=kn3gIP/iAqIFjThhhJdpY5p+TfBzmvYJuz+/2qolTlJII5mEKK3j7U07QJoL3wSF3p
         jPelUIGdgnhYM50ecJrK8+Pv/8/tuFnv0h+pHKanUQPIUaFsxKSJYnOobzeTkdpSdXq6
         WAKSIhzw7pwP8nbNXiPfqzfsFfhhDfaLwWj1Q6jMhDdebiz1BuEU9tH4WTQcklwnQqee
         FUZdV+8Xq32DcT044rA3HqOe6V3qjYo9jQPTC+AvVdZWPBLqnfpc4HkD1QMtV6Lmzv/F
         Z7Me14w4U3UoVW3VSlUTDO1j9LyDLyk2/3KGSwdfzcEod4P4uVqBHRZbBIuaRLNpJNfT
         mCYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731340787; x=1731945587;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRx61QutqkHqE8LsifHeDvLFt2mQ7Pk/J2Li4P0J5EU=;
        b=EzvJgFLYyt9aU9nVkBsG31HX0YkfFH+649w/pDwnIGHGOUREIVc+ryXCsjerMkzL+Y
         0+Y2lkD4ZuO5Kz5Kshkyd/b8c2lfvlca+YYXUhM146Fbbau5yiY9o/EDeNq/VUN0JC6v
         UXl2y4uslzd5SVu82GbxNEWROkgZaawpaH07UsgVJoEzuOSdF8MZj+fiTU7dzJFsZyOr
         99T4POzYaL8DcDDy5fXqNO5fkOfEautm0TnHaFhGp4COfzUa7jamewmndM9oGp08QWxa
         gLREVQOanNlL1LKdQ7wp+QrYamnD2sFMvV7+u5F8QH3nZvWYGwmHS5sfjL4qTqvoaKek
         WHfA==
X-Forwarded-Encrypted: i=1; AJvYcCVUJDQFre1MvcAiC/bx2qozPmJ/ZEIlIaeAC6k+DLNSP4GY9BdKSodb5eDiA+NCJsP7iJUev4IM/T4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5s/yBz/y2pc1Q6k/0N5qSouAk2mXpcfucNUg0ejTyMGS9Pr+x
	HaUSzc8dtpFikWbVUUadJKP7/UUg4IVNGnTcW6SbPuLTFUGEll92qANiZTk24Jw=
X-Google-Smtp-Source: AGHT+IFz5onGePgbNMaG6Xw/7Xs9ETfUP+zGO0bMsWlJBZyv1Ip2qkVxHrYh9z77fz9YgW2JWKoJmg==
X-Received: by 2002:a05:6602:13d3:b0:83a:acfa:b0ba with SMTP id ca18e2360f4ac-83e032a171dmr1370582039f.1.1731340786793;
        Mon, 11 Nov 2024 07:59:46 -0800 (PST)
Received: from [127.0.1.1] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de787d62c6sm1410986173.81.2024.11.11.07.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 07:59:46 -0800 (PST)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Mon, 11 Nov 2024 10:59:44 -0500
Subject: [PATCH 3/3] iio: adc: ad4695: add custom regmap bus callbacks
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-tgamblin-ad4695_improvements-v1-3-698af4512635@baylibre.com>
References: <20241111-tgamblin-ad4695_improvements-v1-0-698af4512635@baylibre.com>
In-Reply-To: <20241111-tgamblin-ad4695_improvements-v1-0-698af4512635@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.14.1

Add a custom implementation of regmap read/write callbacks using the SPI
bus. This allows them to be performed at a lower SCLK rate than data
reads. Previously, all SPI transfers were being performed at a lower
speed, but with this change sample data is read at the max bus speed
while the register reads/writes remain at the lower rate.

Also remove .can_multi_write from the AD4695 driver's regmap_configs, as
this isn't implemented or needed.

For some background context, see:

https://lore.kernel.org/linux-iio/20241028163907.00007e12@Huawei.com/

Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/iio/adc/Kconfig  |  2 +-
 drivers/iio/adc/ad4695.c | 74 +++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 6c4e74420fd2..e0f9d01ce37d 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -51,9 +51,9 @@ config AD4130
 config AD4695
 	tristate "Analog Device AD4695 ADC Driver"
 	depends on SPI
-	select REGMAP_SPI
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
+	select REGMAP
 	help
 	  Say yes here to build support for Analog Devices AD4695 and similar
 	  analog to digital converters (ADC).
diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index f36c1a1db886..180a0fd4f03c 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -150,6 +150,8 @@ struct ad4695_state {
 	/* Commands to send for single conversion. */
 	u16 cnv_cmd;
 	u8 cnv_cmd2;
+	/* Buffer for storing data from regmap bus reads/writes */
+	u8 regmap_bus_data[4];
 };
 
 static const struct regmap_range ad4695_regmap_rd_ranges[] = {
@@ -194,7 +196,6 @@ static const struct regmap_config ad4695_regmap_config = {
 	.max_register = AD4695_REG_AS_SLOT(127),
 	.rd_table = &ad4695_regmap_rd_table,
 	.wr_table = &ad4695_regmap_wr_table,
-	.can_multi_write = true,
 };
 
 static const struct regmap_range ad4695_regmap16_rd_ranges[] = {
@@ -226,7 +227,67 @@ static const struct regmap_config ad4695_regmap16_config = {
 	.max_register = AD4695_REG_GAIN_IN(15),
 	.rd_table = &ad4695_regmap16_rd_table,
 	.wr_table = &ad4695_regmap16_wr_table,
-	.can_multi_write = true,
+};
+
+static int ad4695_regmap_bus_reg_write(void *context, const void *data,
+				       size_t count)
+{
+	struct ad4695_state *st = context;
+	struct spi_transfer xfer = {
+			.speed_hz = AD4695_REG_ACCESS_SCLK_HZ,
+			.len = count,
+			.tx_buf = st->regmap_bus_data,
+	};
+
+	if (count > ARRAY_SIZE(st->regmap_bus_data))
+		return -EINVAL;
+
+	memcpy(st->regmap_bus_data, data, count);
+
+	return spi_sync_transfer(st->spi, &xfer, 1);
+}
+
+static int ad4695_regmap_bus_reg_read(void *context, const void *reg,
+				      size_t reg_size, void *val,
+				      size_t val_size)
+{
+	struct ad4695_state *st = context;
+	struct spi_transfer xfers[] = {
+		{
+			.speed_hz = AD4695_REG_ACCESS_SCLK_HZ,
+			.len = reg_size,
+			.tx_buf = &st->regmap_bus_data[0],
+		}, {
+			.speed_hz = AD4695_REG_ACCESS_SCLK_HZ,
+			.len = val_size,
+			.rx_buf = &st->regmap_bus_data[2],
+		},
+	};
+	int ret;
+
+	if (reg_size > 2)
+		return -EINVAL;
+
+	if (val_size > 2)
+		return -EINVAL;
+
+	memcpy(&st->regmap_bus_data[0], reg, reg_size);
+
+	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
+	if (ret)
+		return ret;
+
+	memcpy(val, &st->regmap_bus_data[2], val_size);
+
+	return 0;
+}
+
+static const struct regmap_bus ad4695_regmap_bus = {
+	.write = ad4695_regmap_bus_reg_write,
+	.read = ad4695_regmap_bus_reg_read,
+	.read_flag_mask = 0x80,
+	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
+	.val_format_endian_default = REGMAP_ENDIAN_BIG,
 };
 
 static const struct iio_chan_spec ad4695_channel_template = {
@@ -1040,15 +1101,14 @@ static int ad4695_probe(struct spi_device *spi)
 	if (!st->chip_info)
 		return -EINVAL;
 
-	/* Registers cannot be read at the max allowable speed */
-	spi->max_speed_hz = AD4695_REG_ACCESS_SCLK_HZ;
-
-	st->regmap = devm_regmap_init_spi(spi, &ad4695_regmap_config);
+	st->regmap = devm_regmap_init(dev, &ad4695_regmap_bus, st,
+				      &ad4695_regmap_config);
 	if (IS_ERR(st->regmap))
 		return dev_err_probe(dev, PTR_ERR(st->regmap),
 				     "Failed to initialize regmap\n");
 
-	st->regmap16 = devm_regmap_init_spi(spi, &ad4695_regmap16_config);
+	st->regmap16 = devm_regmap_init(dev, &ad4695_regmap_bus, st,
+					&ad4695_regmap_config);
 	if (IS_ERR(st->regmap16))
 		return dev_err_probe(dev, PTR_ERR(st->regmap16),
 				     "Failed to initialize regmap16\n");

-- 
2.39.5


