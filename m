Return-Path: <linux-iio+bounces-3803-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C866D88B35E
	for <lists+linux-iio@lfdr.de>; Mon, 25 Mar 2024 23:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FC001F64370
	for <lists+linux-iio@lfdr.de>; Mon, 25 Mar 2024 22:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F8D7173A;
	Mon, 25 Mar 2024 22:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Eqmuq35q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E596570CB3
	for <linux-iio@vger.kernel.org>; Mon, 25 Mar 2024 22:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711404276; cv=none; b=S9ucvJl7gyJ/7PmqU9nEXJJtujgMqj043yLvpkv6m0wmd55jCeIaZwXMo3LbjGbbitBjNERpeTQgqNxYK3s1mEVKkGw5lR8Ju0dJOlny89zPgh3iQgVAs5RKlT5UkLux7P+b8JFLYGbvfQ3TasSOZ9/W6fTykc1xgtFLJhAfUno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711404276; c=relaxed/simple;
	bh=yF1sq2YPQ2TPw93z5U5pn/DAoF1k8JLyhryca4ogEM0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C0+ppNcOE/lsa+FwP/Um8RLSOc0nA7BQpvwvj1PCc3ChI9tRpgBq+84HkGL2YYDAegrP5RGOcGB2/edVq2Mdre8piRkK6A4klJynYUVCoYLLrYAOfFM84zV/0Wau7RQKiYox6Es2jqhkMeFjtUASKREcgFOfAKWBOiqP9tHPCgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Eqmuq35q; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-221816e3ab9so2082803fac.2
        for <linux-iio@vger.kernel.org>; Mon, 25 Mar 2024 15:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711404272; x=1712009072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CjXGYJw5dXwvdxus40r7I6gcFP0lejncjGW57vGc8Lc=;
        b=Eqmuq35qekxgZtz09HAEFEyRBROy109UwcW1ONFRVGNfdGZZCJvqAtQ5Gu02uYZk4j
         3CBDoD5I7tlTqlVEyvhAvhW2UjhBPFQER/gX8Z0grsRmxzcGQGqDpkgV1ALgEdFyOb6m
         xHcWwxb0qVIvXnWMsNVk3SwMQBHCG7j5mxdI6XlWohOks8Qr1Ai9BZoo4M3jwpwV2EfQ
         OL4IxILvpLy5+E2+G7kPJoUPZoESBgZFS5OMJ9BTRhUfEzZquznaSTmnCr68yUDEY6ha
         9p+jf1fwLndXqyYrYwfmMmWZuzRpJ31gngpOssds0PWoo2iijg/7mtjWaT/E+sq2jNF5
         vUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711404272; x=1712009072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CjXGYJw5dXwvdxus40r7I6gcFP0lejncjGW57vGc8Lc=;
        b=n15IygBOzAsxfJ3T/b7Z62OJtJzwEQw0Uw3LmtVFyA3qW9m2b36/HL2PEbeiIIFDNE
         pwqFGLbmR9J85Rk1IB3dQ8QMxc9my0SQyJc5rMfbhV/DKI9ifiJv03SJGt9ofpDryH0h
         ITYwDluJYu7PolQBBIRchmlYzt4sE1aLOCoCodHYq1CbL9JotSIqgPhPDsOLFf84UzYl
         mWgXwYl11oUN32efBt5oZBXNux84zkitavNgkphj7kjS5b/nz5R+QGdq7zY6CviSYeDI
         Y1ifBOUMnAt5rOK5CRw4koA+EYjSLTeSPp+h467P54LIlfRzP9f6/DCjDT7VcNDCLXxw
         xZyw==
X-Forwarded-Encrypted: i=1; AJvYcCVLIlMFhEj/St8636f0/JHlnl75fwTI94+exF2UgO8J6T3y4944sYDySuekS1emB9g9PH0fMt3gKpJ74/Rjgkk/+u1YjCLzPoTP
X-Gm-Message-State: AOJu0YwIHJQJwenKTjH0r5nOmMPNE0jdkB+84mi7QAiUs2jK4phNLxHd
	OIJqjnhIcXcJqfdpz9Y14/8W0/TS+svVWXxPdYdvSMXyeeUp2bf/OGBYU82dmuY=
X-Google-Smtp-Source: AGHT+IE1gsXGo3HHr2b05fM533KZAA1WTWHmTgSSj4HJQufRdPPcaGIZuIqAuE1QzTHLdkeVhD0mAw==
X-Received: by 2002:a05:6870:8997:b0:22a:5690:f056 with SMTP id f23-20020a056870899700b0022a5690f056mr2112618oaq.44.1711404271848;
        Mon, 25 Mar 2024 15:04:31 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id qa17-20020a056871e71100b0022a05f6647asm1791991oac.24.2024.03.25.15.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 15:04:31 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: ad7944: use spi_optimize_message()
Date: Mon, 25 Mar 2024 17:03:13 -0500
Message-ID: <20240325-ad7944-spi-optimize-message-v1-1-cded69b9e27f@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This modifies the ad7944 driver to use spi_optimize_message() to reduce
CPU usage and increase the max sample rate by avoiding repeating
validation of the spi message on each transfer.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7944.c | 177 +++++++++++++++++++++++++++--------------------
 1 file changed, 103 insertions(+), 74 deletions(-)

diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index 261a3f645fd8..c767401712af 100644
--- a/drivers/iio/adc/ad7944.c
+++ b/drivers/iio/adc/ad7944.c
@@ -51,6 +51,8 @@ static const char * const ad7944_spi_modes[] = {
 struct ad7944_adc {
 	struct spi_device *spi;
 	enum ad7944_spi_mode spi_mode;
+	struct spi_transfer xfers[3];
+	struct spi_message msg;
 	/* Chip-specific timing specifications. */
 	const struct ad7944_timing_spec *timing_spec;
 	/* GPIO connected to CNV pin. */
@@ -130,6 +132,88 @@ AD7944_DEFINE_CHIP_INFO(ad7985, ad7944, 16, 0);
 /* fully differential */
 AD7944_DEFINE_CHIP_INFO(ad7986, ad7986, 18, 1);
 
+static void ad7944_unoptimize_msg(void *msg)
+{
+	spi_unoptimize_message(msg);
+}
+
+static int ad7944_3wire_cs_mode_init_msg(struct device *dev, struct ad7944_adc *adc,
+					 const struct iio_chan_spec *chan)
+{
+	unsigned int t_conv_ns = adc->always_turbo ? adc->timing_spec->turbo_conv_ns
+						   : adc->timing_spec->conv_ns;
+	struct spi_transfer *xfers = adc->xfers;
+	int ret;
+
+	/*
+	 * NB: can get better performance from some SPI controllers if we use
+	 * the same bits_per_word in every transfer.
+	 */
+	xfers[0].bits_per_word = chan->scan_type.realbits;
+	/*
+	 * CS is tied to CNV and we need a low to high transition to start the
+	 * conversion, so place CNV low for t_QUIET to prepare for this.
+	 */
+	xfers[0].delay.value = T_QUIET_NS;
+	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
+
+	/*
+	 * CS has to be high for full conversion time to avoid triggering the
+	 * busy indication.
+	 */
+	xfers[1].cs_off = 1;
+	xfers[1].delay.value = t_conv_ns;
+	xfers[1].delay.unit = SPI_DELAY_UNIT_NSECS;
+	xfers[0].bits_per_word = chan->scan_type.realbits;
+
+	/* Then we can read the data during the acquisition phase */
+	xfers[2].rx_buf = &adc->sample.raw;
+	xfers[2].len = BITS_TO_BYTES(chan->scan_type.storagebits);
+	xfers[2].bits_per_word = chan->scan_type.realbits;
+
+	spi_message_init_with_transfers(&adc->msg, xfers, 3);
+
+	ret = spi_optimize_message(adc->spi, &adc->msg);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, ad7944_unoptimize_msg, &adc->msg);
+}
+
+static int ad7944_4wire_mode_init_msg(struct device *dev, struct ad7944_adc *adc,
+				      const struct iio_chan_spec *chan)
+{
+	unsigned int t_conv_ns = adc->always_turbo ? adc->timing_spec->turbo_conv_ns
+						   : adc->timing_spec->conv_ns;
+	struct spi_transfer *xfers = adc->xfers;
+	int ret;
+
+	/*
+	 * NB: can get better performance from some SPI controllers if we use
+	 * the same bits_per_word in every transfer.
+	 */
+	xfers[0].bits_per_word = chan->scan_type.realbits;
+	/*
+	 * CS has to be high for full conversion time to avoid triggering the
+	 * busy indication.
+	 */
+	xfers[0].cs_off = 1;
+	xfers[0].delay.value = t_conv_ns;
+	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
+
+	xfers[1].rx_buf = &adc->sample.raw;
+	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits);
+	xfers[1].bits_per_word = chan->scan_type.realbits;
+
+	spi_message_init_with_transfers(&adc->msg, xfers, 3);
+
+	ret = spi_optimize_message(adc->spi, &adc->msg);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, ad7944_unoptimize_msg, &adc->msg);
+}
+
 /*
  * ad7944_3wire_cs_mode_conversion - Perform a 3-wire CS mode conversion and
  *                                   acquisition
@@ -145,48 +229,7 @@ AD7944_DEFINE_CHIP_INFO(ad7986, ad7986, 18, 1);
 static int ad7944_3wire_cs_mode_conversion(struct ad7944_adc *adc,
 					   const struct iio_chan_spec *chan)
 {
-	unsigned int t_conv_ns = adc->always_turbo ? adc->timing_spec->turbo_conv_ns
-						   : adc->timing_spec->conv_ns;
-	struct spi_transfer xfers[] = {
-		{
-			/*
-			 * NB: can get better performance from some SPI
-			 * controllers if we use the same bits_per_word
-			 * in every transfer.
-			 */
-			.bits_per_word = chan->scan_type.realbits,
-			/*
-			 * CS is tied to CNV and we need a low to high
-			 * transition to start the conversion, so place CNV
-			 * low for t_QUIET to prepare for this.
-			 */
-			.delay = {
-				.value = T_QUIET_NS,
-				.unit = SPI_DELAY_UNIT_NSECS,
-			},
-
-		},
-		{
-			.bits_per_word = chan->scan_type.realbits,
-			/*
-			 * CS has to be high for full conversion time to avoid
-			 * triggering the busy indication.
-			 */
-			.cs_off = 1,
-			.delay = {
-				.value = t_conv_ns,
-				.unit = SPI_DELAY_UNIT_NSECS,
-			},
-		},
-		{
-			/* Then we can read the data during the acquisition phase */
-			.rx_buf = &adc->sample.raw,
-			.len = BITS_TO_BYTES(chan->scan_type.storagebits),
-			.bits_per_word = chan->scan_type.realbits,
-		},
-	};
-
-	return spi_sync_transfer(adc->spi, xfers, ARRAY_SIZE(xfers));
+	return spi_sync(adc->spi, &adc->msg);
 }
 
 /*
@@ -200,33 +243,6 @@ static int ad7944_3wire_cs_mode_conversion(struct ad7944_adc *adc,
 static int ad7944_4wire_mode_conversion(struct ad7944_adc *adc,
 					const struct iio_chan_spec *chan)
 {
-	unsigned int t_conv_ns = adc->always_turbo ? adc->timing_spec->turbo_conv_ns
-						   : adc->timing_spec->conv_ns;
-	struct spi_transfer xfers[] = {
-		{
-			/*
-			 * NB: can get better performance from some SPI
-			 * controllers if we use the same bits_per_word
-			 * in every transfer.
-			 */
-			.bits_per_word = chan->scan_type.realbits,
-			/*
-			 * CS has to be high for full conversion time to avoid
-			 * triggering the busy indication.
-			 */
-			.cs_off = 1,
-			.delay = {
-				.value = t_conv_ns,
-				.unit = SPI_DELAY_UNIT_NSECS,
-			},
-
-		},
-		{
-			.rx_buf = &adc->sample.raw,
-			.len = BITS_TO_BYTES(chan->scan_type.storagebits),
-			.bits_per_word = chan->scan_type.realbits,
-		},
-	};
 	int ret;
 
 	/*
@@ -234,7 +250,7 @@ static int ad7944_4wire_mode_conversion(struct ad7944_adc *adc,
 	 * and acquisition process.
 	 */
 	gpiod_set_value_cansleep(adc->cnv, 1);
-	ret = spi_sync_transfer(adc->spi, xfers, ARRAY_SIZE(xfers));
+	ret = spi_sync(adc->spi, &adc->msg);
 	gpiod_set_value_cansleep(adc->cnv, 0);
 
 	return ret;
@@ -395,10 +411,6 @@ static int ad7944_probe(struct spi_device *spi)
 		adc->spi_mode = ret;
 	}
 
-	if (adc->spi_mode == AD7944_SPI_MODE_CHAIN)
-		return dev_err_probe(dev, -EINVAL,
-				     "chain mode is not implemented\n");
-
 	/*
 	 * Some chips use unusual word sizes, so check now instead of waiting
 	 * for the first xfer.
@@ -491,6 +503,23 @@ static int ad7944_probe(struct spi_device *spi)
 		return dev_err_probe(dev, -EINVAL,
 			"cannot have both chain mode and always turbo\n");
 
+	switch (adc->spi_mode) {
+	case AD7944_SPI_MODE_DEFAULT:
+		ret = ad7944_4wire_mode_init_msg(dev, adc, &chip_info->channels[0]);
+		if (ret)
+			return ret;
+
+		break;
+	case AD7944_SPI_MODE_SINGLE:
+		ret = ad7944_3wire_cs_mode_init_msg(dev, adc, &chip_info->channels[0]);
+		if (ret)
+			return ret;
+
+		break;
+	case AD7944_SPI_MODE_CHAIN:
+		return dev_err_probe(dev, -EINVAL, "chain mode is not implemented\n");
+	}
+
 	indio_dev->name = chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ad7944_iio_info;

---
base-commit: 526f7f17b651c78ead26fea7cea20948c00e47a5
change-id: 20240325-ad7944-spi-optimize-message-82debaa2a5a7

