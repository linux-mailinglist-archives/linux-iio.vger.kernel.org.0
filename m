Return-Path: <linux-iio+bounces-11274-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7859AFF4F
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 12:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7EEC1F2104F
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 10:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A3F1D4615;
	Fri, 25 Oct 2024 10:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MrjrMUym"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356BD1F76B9
	for <linux-iio@vger.kernel.org>; Fri, 25 Oct 2024 10:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850403; cv=none; b=YHt2wQ24HpJYDlT3xoy4a67ADAQAKs7pDpJlcEYFEU7gpNMWLIf09F9frzjO1uKsRQsDLzRvritJ14GdBHV/pgZXwS8HXXAkKgy67RgHvlBHYXTwDISBHfPEoQTZpqiCPnUolEmvpxWaIKZRp8sQg8+8baN8cPsFYtPrKsURal8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850403; c=relaxed/simple;
	bh=ZPKDDOSxbYilgrG4tLmWXDC2qLPxGrrf6mFdnqanB6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qmd0BaXL3jyU1wS5pv1Qb3lKmt2qvgrwZe9cecJvrlrLJ0u29tV4YoXFLXK+ycHjCaelptuJfYCweE42q7YRV1oQb1sxdT2R/QLzpQ4iZG2QalH/ndtnGbBjghqCCq71zCa1z+NzuoWiyYzeEyy/NCN1QAuPx8yE6ys6tQarVhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MrjrMUym; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a99f646ff1bso236459466b.2
        for <linux-iio@vger.kernel.org>; Fri, 25 Oct 2024 02:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729850398; x=1730455198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Z2Cp/0RuXPja2VnWMLGnI6YXRWhekI54aEssV25Ags=;
        b=MrjrMUym/JRNWlmUg1TqXkZ8dy9tnyaP1Z/XjtzVsI9lY77I7LdIezlDzfUsmLcijC
         5Ro4lB3JFgjGD/CidyqGe/rGkjDPH9HzHn/SSMwl4/aRDZqgd1KRZ1JPimYe8z6jWQzN
         84+R99KeNogKm3/dL61kbmzzir6z/B2us/hZoJSpJNSt2hskLC3OG2Qh3qehnjyijQxM
         d4+PiPi925Mu62z5l8Rojux+7W1iQc8t/nclYYP/1R1wq7NYl4OKnh7kUkSAb761KnRA
         eoPVUZC2dd5sJ+7V8i7Q+VwRNObjr8DpCuvuVPH6+Tgk9Y2pW5Q32Xf4WJ9KEGND4TYL
         I89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729850398; x=1730455198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Z2Cp/0RuXPja2VnWMLGnI6YXRWhekI54aEssV25Ags=;
        b=eR20vh7LMUqrXSU+UuzaNEi80bQJcxa76ZJe3q/3sg4OxuePLhDE0FV3HrAw8yF4ZV
         XAEWU20OWBRUM+GZbHkCS6aMKHjEb5LINaefdWehjbU5y2K9yUe8cvCYiE8Kz8sFq+op
         82NJWiG1FMMGPLVWPiFF19I+LaZetvOos14faZbfkCoP1D4oJyHSWWwwuoVN6+4n/iEg
         lY1TRbjFmIWxw0bGcYzcx60FN0EbUmiEOqEL340lCqrubcbBNDpkmhxQIaCtxebmEHkC
         bc/TL0xZQXht1vmFKituui+Za1XAefmTtCLBN/38xxXm53Zu94VqMPU5XU/uji1zug57
         91Bg==
X-Gm-Message-State: AOJu0Yw4LsobdxEwx8QWd6oJy1+6PES3nh5htVc9fvzAFBENo0zqgTyr
	sPYrk3zxUwQQwJoByAFNn/NdTN9dp+z+1CLE1c5pxDsX7pG6JgaRBRw9AblL39k+E7Y3G9EF9FP
	fd5k=
X-Google-Smtp-Source: AGHT+IHo763g2tkSjDl77LlrxX9SC1j1w+RUJ1QYoF0MngkHKTcL+wMwFjjlOSz5xZhNREiseAJRkA==
X-Received: by 2002:a17:906:c148:b0:a9a:3718:6d6 with SMTP id a640c23a62f3a-a9abf964714mr955294666b.58.1729850398115;
        Fri, 25 Oct 2024 02:59:58 -0700 (PDT)
Received: from localhost.localdomain ([188.27.128.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f02951esm51737266b.71.2024.10.25.02.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:59:57 -0700 (PDT)
From: Alexandru Ardelean <aardelean@baylibre.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	lars@metafoo.de,
	michael.hennerich@analog.com,
	gstols@baylibre.com,
	dlechner@baylibre.com,
	conor.dooley@microchip.com,
	Alexandru Ardelean <aardelean@baylibre.com>
Subject: [PATCH v2 5/5] iio: adc: ad7606: add support for AD760{7,8,9} parts
Date: Fri, 25 Oct 2024 12:59:39 +0300
Message-ID: <20241025095939.271811-6-aardelean@baylibre.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241025095939.271811-1-aardelean@baylibre.com>
References: <20241025095939.271811-1-aardelean@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The AD7607, AD7608 and AD7609 are some older parts of the AD7606 family.
They are hardware-only, meaning that they don't have any registers
accessible via SPI or Parallel interface.
They are more similar to the AD7605-4 part, which is supported by the
'ad7606' driver, and are configurable via GPIOs.

Like the AD7605-4 part, all 3 parts have 2 CONVST (Conversion Start) pins
(CONVST A and CONVST B). But in practice, these should be tied together to
make reading of samples easier via a serial line.

The AD7607 has an 14-bit resolution and AD7608 & AD7609 have an 18-bit
resolution. The main difference between the AD7608 & AD7609 is that the
AD7609 has a larger range (±10V & ±20V) vs the ±5V & ±10V ranges for AD7608.

However, unlike AD7605-4 part, these 3 parts have oversampling which is
configurable (like for the AD7606 in HW-mode) via GPIOs.

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad7607.pdf
Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad7608.pdf
Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad7609.pdf

Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
---
 drivers/iio/adc/ad7606.c     | 104 +++++++++++++++++++++++++++++++++++
 drivers/iio/adc/ad7606.h     |   3 +
 drivers/iio/adc/ad7606_par.c |   6 ++
 drivers/iio/adc/ad7606_spi.c |  42 ++++++++++++++
 4 files changed, 155 insertions(+)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 94756bb87b95..8b2046baaa3e 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -73,6 +73,14 @@ static const unsigned int ad7606_16bit_sw_scale_avail[3][2] = {
 	{ 0, 76293 }, { 0, 152588 }, { 0, 305176 }
 };
 
+static const unsigned int ad7607_hw_scale_avail[2][2] = {
+	{ 0, 610352 }, { 1, 220703 }
+};
+
+static const unsigned int ad7609_hw_scale_avail[2][2] = {
+	{ 0, 152588 }, { 0, 305176 }
+};
+
 static const unsigned int ad7606_oversampling_avail[7] = {
 	1, 2, 4, 8, 16, 32, 64,
 };
@@ -113,6 +121,30 @@ static const struct iio_chan_spec ad7606_channels_18bit[] = {
 	AD7606_CHANNEL(7, 18),
 };
 
+static const struct iio_chan_spec ad7607_channels[] = {
+	IIO_CHAN_SOFT_TIMESTAMP(8),
+	AD7606_CHANNEL(0, 14),
+	AD7606_CHANNEL(1, 14),
+	AD7606_CHANNEL(2, 14),
+	AD7606_CHANNEL(3, 14),
+	AD7606_CHANNEL(4, 14),
+	AD7606_CHANNEL(5, 14),
+	AD7606_CHANNEL(6, 14),
+	AD7606_CHANNEL(7, 14),
+};
+
+static const struct iio_chan_spec ad7608_channels[] = {
+	IIO_CHAN_SOFT_TIMESTAMP(8),
+	AD7606_CHANNEL(0, 18),
+	AD7606_CHANNEL(1, 18),
+	AD7606_CHANNEL(2, 18),
+	AD7606_CHANNEL(3, 18),
+	AD7606_CHANNEL(4, 18),
+	AD7606_CHANNEL(5, 18),
+	AD7606_CHANNEL(6, 18),
+	AD7606_CHANNEL(7, 18),
+};
+
 /*
  * The current assumption that this driver makes for AD7616, is that it's
  * working in Hardware Mode with Serial, Burst and Sequencer modes activated.
@@ -149,6 +181,12 @@ static int ad7606c_16bit_chan_scale_setup(struct ad7606_state *st,
 					  struct iio_chan_spec *chan, int ch);
 static int ad7606_16bit_chan_scale_setup(struct ad7606_state *st,
 					 struct iio_chan_spec *chan, int ch);
+static int ad7607_chan_scale_setup(struct ad7606_state *st,
+				   struct iio_chan_spec *chan, int ch);
+static int ad7608_chan_scale_setup(struct ad7606_state *st,
+				   struct iio_chan_spec *chan, int ch);
+static int ad7609_chan_scale_setup(struct ad7606_state *st,
+				   struct iio_chan_spec *chan, int ch);
 
 const struct ad7606_chip_info ad7605_4_info = {
 	.channels = ad7605_channels,
@@ -215,6 +253,39 @@ const struct ad7606_chip_info ad7606c_16_info = {
 };
 EXPORT_SYMBOL_NS_GPL(ad7606c_16_info, IIO_AD7606);
 
+const struct ad7606_chip_info ad7607_info = {
+	.channels = ad7607_channels,
+	.name = "ad7607",
+	.num_adc_channels = 8,
+	.num_channels = 9,
+	.oversampling_avail = ad7606_oversampling_avail,
+	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
+	.scale_setup_cb = ad7607_chan_scale_setup,
+};
+EXPORT_SYMBOL_NS_GPL(ad7607_info, IIO_AD7606);
+
+const struct ad7606_chip_info ad7608_info = {
+	.channels = ad7608_channels,
+	.name = "ad7608",
+	.num_adc_channels = 8,
+	.num_channels = 9,
+	.oversampling_avail = ad7606_oversampling_avail,
+	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
+	.scale_setup_cb = ad7608_chan_scale_setup,
+};
+EXPORT_SYMBOL_NS_GPL(ad7608_info, IIO_AD7606);
+
+const struct ad7606_chip_info ad7609_info = {
+	.channels = ad7608_channels,
+	.name = "ad7609",
+	.num_adc_channels = 8,
+	.num_channels = 9,
+	.oversampling_avail = ad7606_oversampling_avail,
+	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
+	.scale_setup_cb = ad7609_chan_scale_setup,
+};
+EXPORT_SYMBOL_NS_GPL(ad7609_info, IIO_AD7606);
+
 const struct ad7606_chip_info ad7606c_18_info = {
 	.channels = ad7606_channels_18bit,
 	.name = "ad7606c18",
@@ -441,6 +512,39 @@ static int ad7606c_16bit_chan_scale_setup(struct ad7606_state *st,
 	return 0;
 }
 
+static int ad7607_chan_scale_setup(struct ad7606_state *st,
+				   struct iio_chan_spec *chan, int ch)
+{
+	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
+
+	cs->range = 0;
+	cs->scale_avail = ad7607_hw_scale_avail;
+	cs->num_scales = ARRAY_SIZE(ad7607_hw_scale_avail);
+	return 0;
+}
+
+static int ad7608_chan_scale_setup(struct ad7606_state *st,
+				   struct iio_chan_spec *chan, int ch)
+{
+	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
+
+	cs->range = 0;
+	cs->scale_avail = ad7606_18bit_hw_scale_avail;
+	cs->num_scales = ARRAY_SIZE(ad7606_18bit_hw_scale_avail);
+	return 0;
+}
+
+static int ad7609_chan_scale_setup(struct ad7606_state *st,
+				   struct iio_chan_spec *chan, int ch)
+{
+	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
+
+	cs->range = 0;
+	cs->scale_avail = ad7609_hw_scale_avail;
+	cs->num_scales = ARRAY_SIZE(ad7609_hw_scale_avail);
+	return 0;
+}
+
 static int ad7606_reg_access(struct iio_dev *indio_dev,
 			     unsigned int reg,
 			     unsigned int writeval,
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 32c6f776c5df..998814a92b82 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -237,6 +237,9 @@ extern const struct ad7606_chip_info ad7606_4_info;
 extern const struct ad7606_chip_info ad7606b_info;
 extern const struct ad7606_chip_info ad7606c_16_info;
 extern const struct ad7606_chip_info ad7606c_18_info;
+extern const struct ad7606_chip_info ad7607_info;
+extern const struct ad7606_chip_info ad7608_info;
+extern const struct ad7606_chip_info ad7609_info;
 extern const struct ad7606_chip_info ad7616_info;
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
index 4e729777d373..a25182a3daa7 100644
--- a/drivers/iio/adc/ad7606_par.c
+++ b/drivers/iio/adc/ad7606_par.c
@@ -211,6 +211,9 @@ static const struct platform_device_id ad7606_driver_ids[] = {
 	{ .name	= "ad7606-6", .driver_data = (kernel_ulong_t)&ad7606_6_info, },
 	{ .name	= "ad7606-8", .driver_data = (kernel_ulong_t)&ad7606_8_info, },
 	{ .name	= "ad7606b", .driver_data = (kernel_ulong_t)&ad7606b_info, },
+	{ .name	= "ad7607", .driver_data = (kernel_ulong_t)&ad7607_info, },
+	{ .name	= "ad7608", .driver_data = (kernel_ulong_t)&ad7608_info, },
+	{ .name	= "ad7609", .driver_data = (kernel_ulong_t)&ad7609_info, },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, ad7606_driver_ids);
@@ -221,6 +224,9 @@ static const struct of_device_id ad7606_of_match[] = {
 	{ .compatible = "adi,ad7606-6", .data = &ad7606_6_info },
 	{ .compatible = "adi,ad7606-8", .data = &ad7606_8_info },
 	{ .compatible = "adi,ad7606b", .data = &ad7606b_info },
+	{ .compatible = "adi,ad7607", .data = &ad7607_info },
+	{ .compatible = "adi,ad7608", .data = &ad7608_info },
+	{ .compatible = "adi,ad7609", .data = &ad7609_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad7606_of_match);
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index 44c6031e9e9a..0662300cde8d 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -132,6 +132,19 @@ static int ad7606_spi_read_block(struct device *dev,
 	return 0;
 }
 
+static int ad7606_spi_read_block14to16(struct device *dev,
+				       int count, void *buf)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	struct spi_transfer xfer = {
+		.bits_per_word = 14,
+		.len = count * sizeof(u16),
+		.rx_buf = buf,
+	};
+
+	return spi_sync_transfer(spi, &xfer, 1);
+}
+
 static int ad7606_spi_read_block18to32(struct device *dev,
 				       int count, void *buf)
 {
@@ -325,6 +338,14 @@ static const struct ad7606_bus_ops ad7606_spi_bops = {
 	.read_block = ad7606_spi_read_block,
 };
 
+static const struct ad7606_bus_ops ad7607_spi_bops = {
+	.read_block = ad7606_spi_read_block14to16,
+};
+
+static const struct ad7606_bus_ops ad7608_spi_bops = {
+	.read_block = ad7606_spi_read_block18to32,
+};
+
 static const struct ad7606_bus_ops ad7616_spi_bops = {
 	.read_block = ad7606_spi_read_block,
 	.reg_read = ad7606_spi_reg_read,
@@ -387,6 +408,21 @@ static const struct ad7606_bus_info ad7606c_18_bus_info = {
 	.bops = &ad7606c_18_spi_bops,
 };
 
+static const struct ad7606_bus_info ad7607_bus_info = {
+	.chip_info = &ad7607_info,
+	.bops = &ad7607_spi_bops,
+};
+
+static const struct ad7606_bus_info ad7608_bus_info = {
+	.chip_info = &ad7608_info,
+	.bops = &ad7608_spi_bops,
+};
+
+static const struct ad7606_bus_info ad7609_bus_info = {
+	.chip_info = &ad7609_info,
+	.bops = &ad7608_spi_bops,
+};
+
 static const struct ad7606_bus_info ad7616_bus_info = {
 	.chip_info = &ad7616_info,
 	.bops = &ad7616_spi_bops,
@@ -408,6 +444,9 @@ static const struct spi_device_id ad7606_id_table[] = {
 	{ "ad7606b",  (kernel_ulong_t)&ad7606b_bus_info },
 	{ "ad7606c-16", (kernel_ulong_t)&ad7606c_16_bus_info },
 	{ "ad7606c-18", (kernel_ulong_t)&ad7606c_18_bus_info },
+	{ "ad7607",   (kernel_ulong_t)&ad7607_bus_info },
+	{ "ad7608",   (kernel_ulong_t)&ad7608_bus_info },
+	{ "ad7609",   (kernel_ulong_t)&ad7609_bus_info },
 	{ "ad7616",   (kernel_ulong_t)&ad7616_bus_info },
 	{ }
 };
@@ -421,6 +460,9 @@ static const struct of_device_id ad7606_of_match[] = {
 	{ .compatible = "adi,ad7606b", .data = &ad7606b_bus_info },
 	{ .compatible = "adi,ad7606c-16", .data = &ad7606c_16_bus_info },
 	{ .compatible = "adi,ad7606c-18", .data = &ad7606c_18_bus_info },
+	{ .compatible = "adi,ad7607", .data = &ad7607_bus_info },
+	{ .compatible = "adi,ad7608", .data = &ad7608_bus_info },
+	{ .compatible = "adi,ad7609", .data = &ad7609_bus_info },
 	{ .compatible = "adi,ad7616", .data = &ad7616_bus_info },
 	{ }
 };
-- 
2.46.1


