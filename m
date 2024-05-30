Return-Path: <linux-iio+bounces-5508-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D75C38D4EDC
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 17:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FCA71F25C44
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 15:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE9B182D18;
	Thu, 30 May 2024 15:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MG+qVzYY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE4917F503
	for <linux-iio@vger.kernel.org>; Thu, 30 May 2024 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717082074; cv=none; b=AuXm9Mb5Cmuw6Wk1JC1Rh7m8xXBuiOlMTpZXvioGgJdodt7CHcEnUMwTOljFS3wtWhA6dOho/R0qVHrIa6TTTZwsXgcqFW4Q2llgJ8YUo8QYrOZ78w+LTsODQ5nS8xYxJAPpxdjEy5paNh0gUj8VekJu9WsCJ0xMjK238ODned8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717082074; c=relaxed/simple;
	bh=Xoa77mLrBZvVx2uEYxjsfkSdZpI7/EICencdXSVB99M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AITT79+JtX+8c9es1scPc5qsi7ZbKZoCkSOXK+J/GABSoNfVzUSPHzAWVLPo3nyYbSxz5ISdfM44HQt8Jsfoq6/Ll8XMZxsdNGMLVQJYS6nVobYd9aQ6aXxHJvD1rIU89d+r/K7/7dIKF+Ip93ZFHtZHLw0ZiN6GTpLT6MLR+sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MG+qVzYY; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3d1b33e9ac6so509882b6e.1
        for <linux-iio@vger.kernel.org>; Thu, 30 May 2024 08:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717082072; x=1717686872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/68b/SzzuRQNI8g1rtkBQU2w+J/r1CLstX409XeBLE=;
        b=MG+qVzYYuGx6G7CBzoctIegCW9hgw2hIxGIQjuqpKWsAPGOwQW9NH5XvYkCu4qG+Wf
         pc4yduUIq5RgKQ2eo3Z+QeDDt6yVBNiAEn/8o1eL6ORMIseOXDxiXP43/y2DUkoF4bM2
         EXfMCgnkhFRyhivOLTpfwVvXhagbkJqCTUbJ4FHvBmKJAou7eRPek32SZBC9MCqtSayV
         ki5uvyS0HqZrX1yGiQTD5kWr/JJZGNhnl/HWC8vRtwLmHi4jStnwkFyOR2+uBOoiiOlF
         qFoGEzwLKo32wSO/OnFaf6COZC757Z/8U66lJfVKLL2DPMdS20hsg3uG8xJmkvK0rKb7
         TRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717082072; x=1717686872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/68b/SzzuRQNI8g1rtkBQU2w+J/r1CLstX409XeBLE=;
        b=dlQbjkwWb3UdHZrDkUleFDws+cKUl99xdEJFjlTh5FrqMO2lfN6bCt6cj47qUufn3j
         kOeKERiuANVHcV+XpaWhUZvia1FoXJ0wPecdMMOgLSbqfLIrvxJkzI7+MutwBjfM00T9
         xrUvl0+x57BmJtyzp/QF8F2udSO475y9fzdfOEOX+gecD2G9rqDILgQ8ttYVrlnrzekP
         +2IQVGTzChhGEPNkFgyjg2++RljxKOCKTWed00IDPKmDhbrkk7zeksb6y57MHtsebpmf
         KTYBDlFkoyptXpyNPljGATdK0KrCUOXlDeF70asB00cJqA1+OZNDAaiih5yZHxVlhBId
         3+IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMvyNEKcNP/RDC5zV7dxxihzsshQuX/RFBrS4hM9aMuEvaIgFHG6dZSfeMxoQ4P5ng7y9HZwEK4ROKQ8BG3JQuOhDrZEfETD/z
X-Gm-Message-State: AOJu0Yx5Ju3WN88cESrqI4WIhHW4FieHqxheozIRcKvtbLKdZN9E5lm0
	SJvRwuTNydg3K3Pzrd29F9skKBVIyxzy6Dro4jlBclHGyiNCtE0b3bV3h7fQIBQ=
X-Google-Smtp-Source: AGHT+IHL6d3EZT2jTd7bfKSK4pIy4e6GYOcsZNBh9G51hqhfnpXKdBnKgN9f0yHfcfUpHGZbi+jj2g==
X-Received: by 2002:a05:6808:2013:b0:3d1:e059:feb2 with SMTP id 5614622812f47-3d1e05a02d2mr388238b6e.20.1717082071844;
        Thu, 30 May 2024 08:14:31 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f8d0de6314sm2803425a34.41.2024.05.30.08.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 08:14:31 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] iio: adc: ad7380: use spi_optimize_message()
Date: Thu, 30 May 2024 10:14:11 -0500
Message-ID: <20240530-iio-add-support-for-multiple-scan-types-v3-4-cbc4acea2cfa@baylibre.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530-iio-add-support-for-multiple-scan-types-v3-0-cbc4acea2cfa@baylibre.com>
References: <20240530-iio-add-support-for-multiple-scan-types-v3-0-cbc4acea2cfa@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This changes the AD7380 to use spi_optimize_message() to optimize
buffered reads.

This changes both direct reads and buffered reads to use the same
spi_message. This has some (welcome) side effects. The first is that
in buffered reads, the timestamp will now correspond to the same sample
rather than the previous sample. The second is that direct reads now
use the same SPI bus speed as buffered reads.

This reduces CPU usage of the IRQ thread from around 25% to around 20%
when sampling at 10 kHz on a ZedBoard.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v3 changes:
* New patch for this series
* A similar patch was sent at [1].

[1]: https://lore.kernel.org/linux-iio/20240219-mainline-spi-precook-message-v2-5-4a762c6701b9@baylibre.com/
---
 drivers/iio/adc/ad7380.c | 70 ++++++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index 6b0b1b0be363..006496807de9 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -232,6 +232,9 @@ struct ad7380_state {
 	struct regmap *regmap;
 	unsigned int vref_mv;
 	unsigned int vcm_mv[MAX_NUM_CHANNELS];
+	/* xfers, message an buffer for reading sample data */
+	struct spi_transfer xfer[2];
+	struct spi_message msg;
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
 	 * transfer buffers to live in their own cache lines.
@@ -331,15 +334,9 @@ static irqreturn_t ad7380_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad7380_state *st = iio_priv(indio_dev);
-	struct spi_transfer xfer = {
-		.bits_per_word = st->chip_info->channels[0].scan_type.realbits,
-		.len = (st->chip_info->num_channels - 1) *
-		       BITS_TO_BYTES(st->chip_info->channels->scan_type.storagebits),
-		.rx_buf = st->scan_data.raw,
-	};
 	int ret;
 
-	ret = spi_sync_transfer(st->spi, &xfer, 1);
+	ret = spi_sync(st->spi, &st->msg);
 	if (ret)
 		goto out;
 
@@ -355,33 +352,9 @@ static irqreturn_t ad7380_trigger_handler(int irq, void *p)
 static int ad7380_read_direct(struct ad7380_state *st,
 			      struct iio_chan_spec const *chan, int *val)
 {
-	struct spi_transfer xfers[] = {
-		/* toggle CS (no data xfer) to trigger a conversion */
-		{
-			.speed_hz = AD7380_REG_WR_SPEED_HZ,
-			.bits_per_word = chan->scan_type.realbits,
-			.delay = {
-				.value = T_CONVERT_NS,
-				.unit = SPI_DELAY_UNIT_NSECS,
-			},
-			.cs_change = 1,
-			.cs_change_delay = {
-				.value = st->chip_info->timing_specs->t_csh_ns,
-				.unit = SPI_DELAY_UNIT_NSECS,
-			},
-		},
-		/* then read all channels */
-		{
-			.speed_hz = AD7380_REG_WR_SPEED_HZ,
-			.bits_per_word = chan->scan_type.realbits,
-			.rx_buf = st->scan_data.raw,
-			.len = (st->chip_info->num_channels - 1) *
-			       ((chan->scan_type.storagebits > 16) ? 4 : 2),
-		},
-	};
 	int ret;
 
-	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
+	ret = spi_sync(st->spi, &st->msg);
 	if (ret < 0)
 		return ret;
 
@@ -464,6 +437,11 @@ static void ad7380_regulator_disable(void *p)
 	regulator_disable(p);
 }
 
+static void ad7380_unoptimize_msg(void *msg)
+{
+	spi_unoptimize_message(msg);
+}
+
 static int ad7380_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -552,6 +530,34 @@ static int ad7380_probe(struct spi_device *spi)
 		return dev_err_probe(&spi->dev, PTR_ERR(st->regmap),
 				     "failed to allocate register map\n");
 
+	/*
+	 * Setting up a low latency read for getting sample data. Used for both
+	 * direct read an triggered buffer.
+	 */
+
+	/* toggle CS (no data xfer) to trigger a conversion */
+	st->xfer[0].delay.value = T_CONVERT_NS;
+	st->xfer[0].delay.unit = SPI_DELAY_UNIT_NSECS;
+	st->xfer[0].cs_change = 1;
+	st->xfer[0].cs_change_delay.value = st->chip_info->timing_specs->t_csh_ns;
+	st->xfer[0].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
+
+	/* then do a second xfer to read the data */
+	st->xfer[1].bits_per_word = st->chip_info->channels[0].scan_type.realbits;
+	st->xfer[1].rx_buf = st->scan_data.raw;
+	st->xfer[1].len = BITS_TO_BYTES(st->chip_info->channels[0].scan_type.storagebits)
+				* (st->chip_info->num_channels - 1);
+
+	spi_message_init_with_transfers(&st->msg, st->xfer, ARRAY_SIZE(st->xfer));
+
+	ret = spi_optimize_message(st->spi, &st->msg);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&spi->dev, ad7380_unoptimize_msg, &st->msg);
+	if (ret)
+		return ret;
+
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 	indio_dev->name = st->chip_info->name;

-- 
2.45.1


