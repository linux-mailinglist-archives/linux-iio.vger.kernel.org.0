Return-Path: <linux-iio+bounces-26613-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6F1C99DC1
	for <lists+linux-iio@lfdr.de>; Tue, 02 Dec 2025 03:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2C674E2366
	for <lists+linux-iio@lfdr.de>; Tue,  2 Dec 2025 02:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D633C26D4CA;
	Tue,  2 Dec 2025 02:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KkxuKSrl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3245A25D546
	for <linux-iio@vger.kernel.org>; Tue,  2 Dec 2025 02:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764642108; cv=none; b=YytWg71WkoyTMxIrOlcdyCkEdZZUEDmrcdl4LH/2XkUmbSPxxnRiTMfKcGlfq2Krk8qpBC1I/TrwDzAOV2yGvQtlXMLP6bwMhptBYf6Q7xLYXJ8rBnc9hmNLjoz/fIXpSbgsVb0i2dkzBK9u+0iYYXxUPCIa9pXjgQOTg3d7Vp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764642108; c=relaxed/simple;
	bh=P7Zu95R4shudqF0Y2/Djiayjsk1c+kPu5LZFjytlCtg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m50NW7oR1bxGgKZGjpEF735PBE59Ff2GstbwRvFjHGnHSK4rGtI2wURWAoku4T+Cy0xomXQ+r+e5x3YQ2cJ+5YsZurAVZzIG41dUYeWOxY/+nc/Mnn5YEy3DIMdHgRkG8506GEXYL1H8l0Qsgb5ambj0FKNv0jxGg5qgViTJhY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KkxuKSrl; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-3e8f418e051so2837100fac.3
        for <linux-iio@vger.kernel.org>; Mon, 01 Dec 2025 18:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764642105; x=1765246905; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y4EezxA3/JoMXd5IhYRmCt2ymoLZqq/rtKAI0zFRlrY=;
        b=KkxuKSrlGpMr4vuREsHzYApesfz8oncTPLIXmnuKipWJwhfQK/n1OwElS0OJ6JcOHD
         TBHC3yvSemM3nEaLQIWER6QxAD++H5NP4gVp6ansDAxK3ZAW10lJEwoYSbL1LsQTDdgF
         urfvKU0YuHrJAY6qPsVTW4CN4Qq4toVfsmp2BBilQoiarAx6agDBZ/iV5vXQ72tc6jbR
         a07bMzbzxhPIlZQ3rmGhrnjBg2MmOOtuI9kcohnlWwgPGp9PPAoGP4OeP5PhUmcie+Fw
         3U6Ez2e6gVuoZwvMaiaG4VNEmV2wNl/LsCwxK59aEnW0BFaWEnSJzldaQrPtcoFePpIN
         Tc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764642105; x=1765246905;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y4EezxA3/JoMXd5IhYRmCt2ymoLZqq/rtKAI0zFRlrY=;
        b=F0I6A5lJpzknUy4BwrLVyIP8/ostugdYC46wDrCpviWtE6+5UTmoKeN15cUbeOkp7O
         5SdKqIguPgmvSTGENt/MiGxNx0V84M8U6S1/JdcAdg4kp7ataI9HmrfMgLe4WlLvZlx7
         eoKGnRTTf5yyGn1xmk178Glsgi5yVHUiivrjRSc2/Jvw4J0cUnNOSanObS9/YLPUdqxH
         Hddf9kGIbs13xNJXnpTFvfKdZQlwVq5U7u2Y7DYYOzHexltCS36jlX1ufWaTzEmjOzLA
         4RJu8M7KXr8FcaQQcQMgj7KiCdTyFqoNPhY8ZajAviQ7OS9dn27bkhX1SGIuUBTguVNq
         VHAg==
X-Forwarded-Encrypted: i=1; AJvYcCVFzEBFVI4zrBOaU/DBnynh47tf+jla4x+BPYVHvmvCMw6woOR4KSgbZttJuuVPK9YHM2/h5CBzjw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUJWygWpuiq0sqwvgOtwVbilBt8r42YTc4Uk8ILdUf7DEwln5G
	To/oGjOgBAViY3kIgqcG+e3s8kXz3GP5ZE3CmgErzQaR6H0y46RbgMUgRWcwUcRGFPM=
X-Gm-Gg: ASbGncubLUxbwb7WMM+8nw83Z9KZfLa3F3xBzjdOkPKFP+vnDsEComB4wH62K022T/A
	MqPhHylnxzgGklcj8FN9VD8Jeon2i9nM7AZzBy6IIflbVFa4vMMEPT664YJFudewKqwvAaI3iq+
	2pG4JEarr9q4r2CkBnNx2zzx1Aj5f3t9ke3lp2RHVCfW5kspo6GNOjdj/SgwNBUjyciRX4+nnAh
	QOFRxo9lHGYcBjwLMOcX0HK+AaQlD3EmhQ19YLftGhEjDCBd3xqtUXDeB6VbpaCejspN131uEXe
	NlnZw287wMoNag+gazJuTjNogPyjcgyj9ey8knC8lQtLBb6Kg6mDCviHq3kwY5XwQnncKW6a5sg
	/ah1VMBNs2X2gEHvNIO30a1gtlS66/krgA7nf8hOKdvJfaNJqA/b4KeRf32Y28rF2KebmhSBXw4
	CYiT6w2L8ccPzoYg==
X-Google-Smtp-Source: AGHT+IGLa/kRMFsAbPE/Eigd6Y5XKbPoiYxL9rHN01gFXvJGr1JZxOcHatgP1958l4Ad0t9SEG3ePA==
X-Received: by 2002:a05:6871:6d10:b0:3ec:307f:a3de with SMTP id 586e51a60fabf-3ecbe2e6928mr17992938fac.19.1764642105282;
        Mon, 01 Dec 2025 18:21:45 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b67b:16c:f7ae:4908])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f0dca0475esm6651747fac.1.2025.12.01.18.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 18:21:44 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 01 Dec 2025 20:20:44 -0600
Subject: [PATCH v3 6/7] iio: adc: ad7380: Add support for multiple SPI
 lanes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251201-spi-add-multi-bus-support-v3-6-34e05791de83@baylibre.com>
References: <20251201-spi-add-multi-bus-support-v3-0-34e05791de83@baylibre.com>
In-Reply-To: <20251201-spi-add-multi-bus-support-v3-0-34e05791de83@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5320; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=P7Zu95R4shudqF0Y2/Djiayjsk1c+kPu5LZFjytlCtg=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpLk0kES0EKCiwOeKL4SPXDs7FnhlPAD4GZT4yK
 YC7V/vVsKiJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaS5NJAAKCRDCzCAB/wGP
 wK2XB/9DbK63Jv0IOWK7e0m+PktWZniXH8kDODIhbzgKWevm1yCnKcWN77FfIGfIT+MkX00kOVP
 4VYwowV3LkUX0LiFkbnYfwbBXK3gFsPLwDeaHn6SNwpoR+YvOSDYojSDLoRZ6NjuYI659T1y3f4
 CH8KJpzBR6anZjRd+CVmB/BsW9R2kTodgekU5zCRtyjHtZRRivt1060EpzHIm6721aBdYG8YxEi
 GmALJC3GgTNDRCYjOkXWKm1acWWEa14w6wRnf2yamiyuWasyru7uV71U7fjrmVdlsIApLzZcWum
 64ZJ6GSetueuIeBggRlbkaQO6ckAuijiqrjTKVW/OSkCZSsv
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for multiple SPI lanes to increase throughput. The AD7380
family of ADCs have multiple SDO lines on the chip that can be used to
read each channel on a separate SPI lane. If wired up to a SPI
controller that supports it, the driver will now take advantage of this
feature. This allows reaching the maximum sample rate advertised in the
datasheet when combined with SPI offloading.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v3 changes:
* Renamed "buses" to "lanes" to reflect devicetree property name change.

v2 changes:
* Move st->seq_xfer[3].multi_lane_mode = SPI_MULTI_BUS_MODE_STRIPE;
  to probe().
---
 drivers/iio/adc/ad7380.c | 42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index bfd908deefc0f40b42bd8a44bfce7a2510b2fdf1..5c4caf31cecc398e5475569b49e0c16c7dcf673c 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -77,8 +77,7 @@
 #define AD7380_CONFIG1_REFSEL		BIT(1)
 #define AD7380_CONFIG1_PMODE		BIT(0)
 
-#define AD7380_CONFIG2_SDO2		GENMASK(9, 8)
-#define AD7380_CONFIG2_SDO		BIT(8)
+#define AD7380_CONFIG2_SDO		GENMASK(9, 8)
 #define AD7380_CONFIG2_RESET		GENMASK(7, 0)
 
 #define AD7380_CONFIG2_RESET_SOFT	0x3C
@@ -92,11 +91,6 @@
 #define T_CONVERT_X_NS 500		/* xth conversion start time (oversampling) */
 #define T_POWERUP_US 5000		/* Power up */
 
-/*
- * AD738x support several SDO lines to increase throughput, but driver currently
- * supports only 1 SDO line (standard SPI transaction)
- */
-#define AD7380_NUM_SDO_LINES		1
 #define AD7380_DEFAULT_GAIN_MILLI	1000
 
 /*
@@ -1084,7 +1078,7 @@ static int ad7380_set_ch(struct ad7380_state *st, unsigned int ch)
 	if (oversampling_ratio > 1)
 		xfer.delay.value = T_CONVERT_0_NS +
 			T_CONVERT_X_NS * (oversampling_ratio - 1) *
-			st->chip_info->num_simult_channels / AD7380_NUM_SDO_LINES;
+			st->chip_info->num_simult_channels / st->spi->num_data_lanes;
 
 	return spi_sync_transfer(st->spi, &xfer, 1);
 }
@@ -1113,7 +1107,7 @@ static int ad7380_update_xfers(struct ad7380_state *st,
 	if (oversampling_ratio > 1)
 		t_convert = T_CONVERT_0_NS + T_CONVERT_X_NS *
 			(oversampling_ratio - 1) *
-			st->chip_info->num_simult_channels / AD7380_NUM_SDO_LINES;
+			st->chip_info->num_simult_channels / st->spi->num_data_lanes;
 
 	if (st->seq) {
 		xfer[0].delay.value = xfer[1].delay.value = t_convert;
@@ -1198,6 +1192,8 @@ static int ad7380_init_offload_msg(struct ad7380_state *st,
 	xfer->bits_per_word = scan_type->realbits;
 	xfer->offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
 	xfer->len = AD7380_SPI_BYTES(scan_type) * st->chip_info->num_simult_channels;
+	if (st->spi->num_data_lanes > 1)
+		xfer->multi_lane_mode = SPI_MULTI_LANE_MODE_STRIPE;
 
 	spi_message_init_with_transfers(&st->offload_msg, xfer, 1);
 	st->offload_msg.offload = st->offload;
@@ -1793,6 +1789,7 @@ static const struct iio_info ad7380_info = {
 
 static int ad7380_init(struct ad7380_state *st, bool external_ref_en)
 {
+	u32 sdo;
 	int ret;
 
 	/* perform hard reset */
@@ -1815,11 +1812,24 @@ static int ad7380_init(struct ad7380_state *st, bool external_ref_en)
 	st->ch = 0;
 	st->seq = false;
 
-	/* SPI 1-wire mode */
+	/* SDO field has an irregular mapping. */
+	switch (st->spi->num_data_lanes) {
+	case 1:
+		sdo = 1;
+		break;
+	case 2:
+		sdo = 0;
+		break;
+	case 4:
+		sdo = 2;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	return regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG2,
 				  AD7380_CONFIG2_SDO,
-				  FIELD_PREP(AD7380_CONFIG2_SDO,
-					     AD7380_NUM_SDO_LINES));
+				  FIELD_PREP(AD7380_CONFIG2_SDO, sdo));
 }
 
 static int ad7380_probe_spi_offload(struct iio_dev *indio_dev,
@@ -1842,7 +1852,7 @@ static int ad7380_probe_spi_offload(struct iio_dev *indio_dev,
 				     "failed to get offload trigger\n");
 
 	sample_rate = st->chip_info->max_conversion_rate_hz *
-		      AD7380_NUM_SDO_LINES / st->chip_info->num_simult_channels;
+		      spi->num_data_lanes / st->chip_info->num_simult_channels;
 
 	st->sample_freq_range[0] = 1; /* min */
 	st->sample_freq_range[1] = 1; /* step */
@@ -2010,6 +2020,8 @@ static int ad7380_probe(struct spi_device *spi)
 	st->normal_xfer[0].cs_change_delay.value = st->chip_info->timing_specs->t_csh_ns;
 	st->normal_xfer[0].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
 	st->normal_xfer[1].rx_buf = st->scan_data;
+	if (spi->num_data_lanes > 1)
+		st->normal_xfer[1].multi_lane_mode = SPI_MULTI_LANE_MODE_STRIPE;
 
 	spi_message_init_with_transfers(&st->normal_msg, st->normal_xfer,
 					ARRAY_SIZE(st->normal_xfer));
@@ -2031,6 +2043,10 @@ static int ad7380_probe(struct spi_device *spi)
 	st->seq_xfer[2].cs_change = 1;
 	st->seq_xfer[2].cs_change_delay.value = st->chip_info->timing_specs->t_csh_ns;
 	st->seq_xfer[2].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
+	if (spi->num_data_lanes > 1) {
+		st->seq_xfer[2].multi_lane_mode = SPI_MULTI_LANE_MODE_STRIPE;
+		st->seq_xfer[3].multi_lane_mode = SPI_MULTI_LANE_MODE_STRIPE;
+	}
 
 	spi_message_init_with_transfers(&st->seq_msg, st->seq_xfer,
 					ARRAY_SIZE(st->seq_xfer));

-- 
2.43.0


