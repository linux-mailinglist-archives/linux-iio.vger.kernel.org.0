Return-Path: <linux-iio+bounces-25070-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF71BDB8DD
	for <lists+linux-iio@lfdr.de>; Wed, 15 Oct 2025 00:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45C784EBB36
	for <lists+linux-iio@lfdr.de>; Tue, 14 Oct 2025 22:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF11C30F53A;
	Tue, 14 Oct 2025 22:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ItHkf7lD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED8930DD28
	for <linux-iio@vger.kernel.org>; Tue, 14 Oct 2025 22:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760479394; cv=none; b=mSPiXwyCa6klZNXSonnRpPGqgdQt3PKD1u7yhVY7rkAcDSTs2Ab54bkouvfbk7XQGJKnmwrywaebtQqMlz1WCkPeRwn6QM8fHzksFyfl44kq8e8BZVDO6f+THghQwk+Nepm/ZVmhUFcsInFeqyZT5X6btyofgztC8yvhgF7DdTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760479394; c=relaxed/simple;
	bh=lFdsA0YqVZdv9LVuQw0SrITN0a033KY7tyPi60ZKk2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xu11j8DJTU37C87HNeLUTwoYI5zOOS/GkBBSxdS9Ltdh+53inCvFuFRodwg1kPy01VzE4t0c+Hcfw06ERxU043lkczCpYVNIFTImf3gN7XPFZ2h9aQBpw9uh6uY4yV9fDH7+mXzyrtgxS863Z958YAY9IxvasM/DrT67YsEAyGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ItHkf7lD; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7c0e357ab51so4914457a34.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Oct 2025 15:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760479391; x=1761084191; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hqolBQIXv5KYau5vWoruyq5XQt42Dg49+iF61Wnk4+4=;
        b=ItHkf7lDevgDrwHZLUeK+xcVv/ts7tvRjm4zyNgfejzP0jZmBGBQHjFk/Zi5KDB3Kj
         pLp+kULXApS9ElWTgAq83xAE/z9rtiqDOrOZiL0UBg6GySJiUEUvKbokWFG6mQK3JGY1
         /JVVNBAb9/eMp9tD32KbCtmyt7fn9DqArTUZCG6+x/Erjpb3b2hl3PL813mnA93NaGze
         4cfG/0mvLtltZVtStScb9vMlUG9DHBv7FJSxCV1FxBhAHacM8OOhKAuvKcV/4qWqYObR
         X6Rgq74M9KjINpfnyVY4PxgIRJUGGbqZ+QxPDQSuhz5Eeps2FLwo1YUCPbQDVnyJlDFU
         L6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760479391; x=1761084191;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqolBQIXv5KYau5vWoruyq5XQt42Dg49+iF61Wnk4+4=;
        b=qV/qgehecwvD9aQHI+/2eMbGN2XlBWGhs2Rc+hX8itkTCJXmqPTVlGT5d/xCca32/f
         VQY9Et8avV/yKPBVcp8PF9WA8LEj99LFQ9kN54nzBV2FPvfjy7QY4nJCeymj5N4gxROX
         beCqeLMzza5YMxEsLW3sUJgcDDDO5hzzTSEairbwFo0t6OTu8M5jzpUEssirVHohqwom
         eM2SctyCfnOtBVzE68LkBfAsLfaNM/5xKIejLcdqSbP+Kl/xAMOuk4XFmGaohfbNyJv9
         NqdYlO8/gzPL7n9nfnOP3jVH4Rn94wa16awNEZbWSpwfm9ZqKutptnaRvuu9sBWSRLdD
         rhCg==
X-Forwarded-Encrypted: i=1; AJvYcCVzgPd8UuAYq3QBacoBlPb30tkoOjn+9RGFjWuw1LkMI6i6gz8TCVqR7lNey6NF93yumc0RFzlqfRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa2Nk+vR89MyM/8xtAxigdpEOjMSzVfRksRp4GpvipLrZzERW9
	bbk0MoJGIkTjfS1Pn4v3eZ5J0ummOVO4pVbMZNXH7mbOhErU0EmUQc8L4mKeWy5tmUE=
X-Gm-Gg: ASbGncverj7eT/IbRjg9NvTTuXvq+QW+tXmUcvralPV3tZeDp0mVvrZlljoc382imdA
	ExBaRRpwGUuSXTpfMueIX+s8E+HmK9evZl7yxEndoNtb//He4tEEfgm3lhbbPmCJ0HRC99MUF3A
	6GiP6cN3gTdK6EOPUuJTfcMCvi8ONbVgV6s2CtHLTmKr/nfQiWlw3khsGEv9gsSAxJy0/rMhVLu
	kJHRKVgTHrXbrz4pO0mLXrV20UG2eiavJMp8PLdC2Du3qwXls4DAZAjlVgJ88TNpwpfucuHaHQB
	neaeF6EMfZ00IvxKOh3LsrRhoGMkddoje8SQSBgWIumUfBPf9DDzNa/z0PFS3EnuReVvB5h6mBI
	2pZWFKYF9wtVucMLLvAY752L/Wu1cq5Li4DA088kJJXgWrjiSP2xNNCqsEruXBe2tjos=
X-Google-Smtp-Source: AGHT+IGrKitcoow9K1NN0xlB4OhYZnctfJmK7wCThPVVW2AiUkp2WYlpDF9VUJlzxVhqzh0PkFHHOg==
X-Received: by 2002:a05:6808:308c:b0:43b:5cee:137 with SMTP id 5614622812f47-4417b2d1eb5mr12898814b6e.4.1760479391430;
        Tue, 14 Oct 2025 15:03:11 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:c482:1912:c2de:367e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4419895119bsm3593732b6e.21.2025.10.14.15.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 15:03:11 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 14 Oct 2025 17:02:16 -0500
Subject: [PATCH 6/6] iio: adc: ad7380: Add support for multiple SPI buses
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-spi-add-multi-bus-support-v1-6-2098c12d6f5f@baylibre.com>
References: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
In-Reply-To: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5388; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=lFdsA0YqVZdv9LVuQw0SrITN0a033KY7tyPi60ZKk2I=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBo7siO73aVsUeAFtRWx1v2QqO5Zloc4fMQatLzo
 //Eq6vynoOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaO7IjgAKCRDCzCAB/wGP
 wC8zB/0TaaHlI2BsUjWkcJnrGnaU66GLjfMbbjoNWMo7yzQ2duCojSbMT7KqSMW/5BS2ASZZZSc
 OXCP8mbm5CKcmqFJ+NE5n8+h3Ac2NR90JfZmpiU2lTFrXRP4ukJTmY5ZmtGNr+8VunJWFU3nm+k
 Ust9VySN923SbBcx7l+sYXNsIHnAN96GoS5geOFrBv4L4z7LPyvVAfeU+Ce3+nkSWLUdrWNQ+wY
 mnxEysHbA++cbX6khKgwlfXIcb+cODXE5WSMMvQM/H20G91XODnYEp3JaoxLoNG7iZJ0Rfb7T3j
 COeEgLnk28y+yJxOsz+aW4O9XsEWywzazyvnoFtlH89HoqcI
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add support for multiple SPI buses to increase throughput. The AD7380
family of ADCs have multiple SDO lines on the chip that can be used to
read each channel on a separate SPI bus. If wired up to a SPI controller
that supports it, the driver will now take advantage of this feature.
This allows reaching the maximum sample rate advertised in the datasheet
when combined with SPI offloading.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index bfd908deefc0f40b42bd8a44bfce7a2510b2fdf1..36abe95852006a81f7e31f8034699e59292af79e 100644
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
+			st->chip_info->num_simult_channels / st->spi->num_data_bus;
 
 	return spi_sync_transfer(st->spi, &xfer, 1);
 }
@@ -1113,7 +1107,7 @@ static int ad7380_update_xfers(struct ad7380_state *st,
 	if (oversampling_ratio > 1)
 		t_convert = T_CONVERT_0_NS + T_CONVERT_X_NS *
 			(oversampling_ratio - 1) *
-			st->chip_info->num_simult_channels / AD7380_NUM_SDO_LINES;
+			st->chip_info->num_simult_channels / st->spi->num_data_bus;
 
 	if (st->seq) {
 		xfer[0].delay.value = xfer[1].delay.value = t_convert;
@@ -1124,6 +1118,7 @@ static int ad7380_update_xfers(struct ad7380_state *st,
 			AD7380_SPI_BYTES(scan_type) *
 			st->chip_info->num_simult_channels;
 		xfer[3].rx_buf = xfer[2].rx_buf + xfer[2].len;
+		xfer[3].multi_bus_mode = xfer[2].multi_bus_mode;
 		/* Additional delay required here when oversampling is enabled */
 		if (oversampling_ratio > 1)
 			xfer[2].delay.value = t_convert;
@@ -1198,6 +1193,8 @@ static int ad7380_init_offload_msg(struct ad7380_state *st,
 	xfer->bits_per_word = scan_type->realbits;
 	xfer->offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
 	xfer->len = AD7380_SPI_BYTES(scan_type) * st->chip_info->num_simult_channels;
+	if (st->spi->num_data_bus > 1)
+		xfer->multi_bus_mode = SPI_MULTI_BUS_MODE_STRIPE;
 
 	spi_message_init_with_transfers(&st->offload_msg, xfer, 1);
 	st->offload_msg.offload = st->offload;
@@ -1793,6 +1790,7 @@ static const struct iio_info ad7380_info = {
 
 static int ad7380_init(struct ad7380_state *st, bool external_ref_en)
 {
+	u32 sdo;
 	int ret;
 
 	/* perform hard reset */
@@ -1815,11 +1813,24 @@ static int ad7380_init(struct ad7380_state *st, bool external_ref_en)
 	st->ch = 0;
 	st->seq = false;
 
-	/* SPI 1-wire mode */
+	/* SDO field has an irregular mapping. */
+	switch (st->spi->num_data_bus) {
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
@@ -1842,7 +1853,7 @@ static int ad7380_probe_spi_offload(struct iio_dev *indio_dev,
 				     "failed to get offload trigger\n");
 
 	sample_rate = st->chip_info->max_conversion_rate_hz *
-		      AD7380_NUM_SDO_LINES / st->chip_info->num_simult_channels;
+		      spi->num_data_bus / st->chip_info->num_simult_channels;
 
 	st->sample_freq_range[0] = 1; /* min */
 	st->sample_freq_range[1] = 1; /* step */
@@ -2010,6 +2021,8 @@ static int ad7380_probe(struct spi_device *spi)
 	st->normal_xfer[0].cs_change_delay.value = st->chip_info->timing_specs->t_csh_ns;
 	st->normal_xfer[0].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
 	st->normal_xfer[1].rx_buf = st->scan_data;
+	if (spi->num_data_bus > 1)
+		st->normal_xfer[1].multi_bus_mode = SPI_MULTI_BUS_MODE_STRIPE;
 
 	spi_message_init_with_transfers(&st->normal_msg, st->normal_xfer,
 					ARRAY_SIZE(st->normal_xfer));
@@ -2031,6 +2044,8 @@ static int ad7380_probe(struct spi_device *spi)
 	st->seq_xfer[2].cs_change = 1;
 	st->seq_xfer[2].cs_change_delay.value = st->chip_info->timing_specs->t_csh_ns;
 	st->seq_xfer[2].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
+	if (spi->num_data_bus > 1)
+		st->seq_xfer[2].multi_bus_mode = SPI_MULTI_BUS_MODE_STRIPE;
 
 	spi_message_init_with_transfers(&st->seq_msg, st->seq_xfer,
 					ARRAY_SIZE(st->seq_xfer));

-- 
2.43.0


