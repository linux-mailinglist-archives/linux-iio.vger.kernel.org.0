Return-Path: <linux-iio+bounces-12228-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9740F9C7D32
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 21:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D444B2740D
	for <lists+linux-iio@lfdr.de>; Wed, 13 Nov 2024 20:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A990E20822C;
	Wed, 13 Nov 2024 20:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gC/VtcRk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A89206E9B
	for <linux-iio@vger.kernel.org>; Wed, 13 Nov 2024 20:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731531190; cv=none; b=ID+IpsqnVQoEB1iiG2+rdOGAF/9ExrKog5lX2oZhDZn/1V612DuJts2DJNJ9k8l9RugdX0yh1vB1x69VYWL5v+PucxKJvSUXDdetQDSwcGKfU/SK8lK6h5ZUO2mRb/CjOVmfjNA5Je71p3jduTsFw0vpPe1+mD7YYLumYTjRj/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731531190; c=relaxed/simple;
	bh=Pz2KKu4E0S8gxWyDYqUJ4IikQCVVFbB/FjvWce4wrK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kb+P+m6vM1TEg75mGESyAwlazeZmmy9eOeo3nOcU63RLEAULIik+d33uQSHfb9xSLg1piq5VXG/EfoLkgoC0ADfsIbuf57uZR2yVHvQoWpj1n4cZlSiYuTvwGKXZNbX3AZBAX4K2pczZWlnhhlPT2C+zvccFPsBC03TJZoLoxBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gC/VtcRk; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3e5f968230bso3408365b6e.3
        for <linux-iio@vger.kernel.org>; Wed, 13 Nov 2024 12:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731531188; x=1732135988; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j973tQMecbg2dQpmCZmqY7EOAwkOr6g0JYqv1pBH+KE=;
        b=gC/VtcRkfFZhaQbcmQr7ADLYv5Zse1Ld928A2/LYMA4jAOTRtG9q/FERlKoEuIOpeO
         zpdMKJn47vszq3BDlDso773+OKxxNoTm7Ewu2oYpg3oIrAl0gj9zYQ3dGH2KL5UhluF8
         32z2GyoG9UYPGaEpWttex5HYNl85mp04sk9/xj3P/QUwPFtcvlMaLUaBgWOpZd66iqos
         ApQIH1vzmU0iErIXrZihQpEXaEPu/FyQ6epE4xR3cPUhvt5Xs++Gve+uTINm/d5Bi+Od
         8bydBFIsOXP7Pvaz7FoJ+m6Ko6NV8Axjv2R4Iz1McFWfGBo8xUSUPFfXJgOkzw3sXlgy
         OlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731531188; x=1732135988;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j973tQMecbg2dQpmCZmqY7EOAwkOr6g0JYqv1pBH+KE=;
        b=GmC3a+pRrFLyI44PIJRE5PBSA9umiF2K/oIoXCSHLokNOBzu4JCG5nuxkYHJzLt7O6
         ubGECQ8HsmY+S3pqCTuMlIipMG1oYfka3gvMZKb04ORyKSHsUOGrq8Sbmebt4pVWhiIL
         JGA19/RtWOdCuQuxJMPXRRR5mP13ss7bAHwOAy4xtmorlA3tZt8r0fbrwq5ufdrFYT6e
         wZeJrE3Iy+Vv6rhVuIS7m8ojHnwLuPjd11szL5C1s9sxHRPQkb8ezNMoC33qqlqLIs2s
         d4OCfZwyHVkiMyYDG/J8ITBXi60UFVj0usYdsXf/QH2630HlHDUNa9JiMB0ekU4aAdDj
         Gseg==
X-Forwarded-Encrypted: i=1; AJvYcCVVZRQz+LNT8HQCBW7UBNr+f59CmDHQ9NU/j+DPQ9WIsF2D2S3zj7nShKuxt/gw/jEge9L4YR9yaCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJqsAfe5d6JWGW2+j+uYK5CpZBAxsLWrxKcBnxr3IJ3dea24hF
	JdKy6FmH5fHYwy+ZUgcTgyAfvf0h+OjV1ucWGeDKb3k/qdZ93diMBG/ofgPylQE=
X-Google-Smtp-Source: AGHT+IG5f7b1sekg4Dycf1CVNaaQ7HdwRKLYHyGVFUKWYUSjmL0f7fHis9LeoVV7mKWpeJQ82PRNnQ==
X-Received: by 2002:a05:6808:21a7:b0:3e6:3777:76a7 with SMTP id 5614622812f47-3e7946af87cmr19038718b6e.23.1731531187576;
        Wed, 13 Nov 2024 12:53:07 -0800 (PST)
Received: from [127.0.1.1] (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3961df2f5sm88829336d6.2.2024.11.13.12.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 12:53:07 -0800 (PST)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Wed, 13 Nov 2024 15:53:00 -0500
Subject: [PATCH v2 3/3] iio: adc: ad4695: add custom regmap bus callbacks
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-tgamblin-ad4695_improvements-v2-3-b6bb7c758fc4@baylibre.com>
References: <20241113-tgamblin-ad4695_improvements-v2-0-b6bb7c758fc4@baylibre.com>
In-Reply-To: <20241113-tgamblin-ad4695_improvements-v2-0-b6bb7c758fc4@baylibre.com>
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
index 4bc800293e60..921d996fff79 100644
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
@@ -1061,15 +1122,14 @@ static int ad4695_probe(struct spi_device *spi)
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
+					&ad4695_regmap16_config);
 	if (IS_ERR(st->regmap16))
 		return dev_err_probe(dev, PTR_ERR(st->regmap16),
 				     "Failed to initialize regmap16\n");

-- 
2.39.5


