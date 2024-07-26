Return-Path: <linux-iio+bounces-7945-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D1993D5EB
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 17:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5A3284822
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 15:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633B517C9F0;
	Fri, 26 Jul 2024 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jI90uXG8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C357F17C227
	for <linux-iio@vger.kernel.org>; Fri, 26 Jul 2024 15:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722007225; cv=none; b=SdfW969jg5KtSlerCVS8JKuthPHHpwGkj168l8jT5ub+rpTVXG6T3hC+SpnBGFmNgWqNbR3Aru6Scs9L0nsSXH0pBt/1tkvxY1xiiAS6Pvu2NFpY0n4cr7bHc3Uk5dVfTd9EJUtUQK90dGb5z3vVS7aqPQbeNPqkdQdV0LrnneE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722007225; c=relaxed/simple;
	bh=nmdjHXU3vu46Z0MeVM1/u5fR4Xs38bVuo5Mc6i4wpMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E6qx2LOuTMpd9C9x2slIeWDuucqpDfLZjFx9hhjy45iSQWbJH0jFZfT0CZIGdBDAhmLO2B028tEMCGy09eJU/ti/YmG6fpnyxegGsyW3daSBwCoEdLHNB+NsPbtqvULI8NwXFca5fYl6LzTiGMTsY76f/IkA4fPVUlbF/Grfh6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jI90uXG8; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3685afd0c56so1329035f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 26 Jul 2024 08:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722007221; x=1722612021; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=meaoaCvhx6jXwqh+aHKOvkRMUNV6asMO6RpX+WPqXKM=;
        b=jI90uXG8f3EMl1+yJ4UM9XOfLSHHVJ/azbSAbO44Nq5KXSW+HlQcB5ym6mSjfXoVhr
         0pv4h4ydrHi7qZbVGhWNbPVfpF42ZsKEs6cjqoYT8KReDTl9vm9lZdGWsb0MH3xgP2aP
         DAkaSwoI9bJwQNGKTzWNzZfYYof+jFAWO4ooyJruv2OL+KVAPqhhVlhTZZNDeaRWu/DR
         m67gk+VASGU/EJJzS2ZXYiCVc3mhHieStAT2jydKWRIMBdfheIihDU8zH6ae1nknpWHW
         VSTIC16qejs47c80ulBIHeqKsVW4NutUIFTtJxGKXzA/LS8X7qY06rb+BDU7HsEu7IpI
         p4Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722007221; x=1722612021;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=meaoaCvhx6jXwqh+aHKOvkRMUNV6asMO6RpX+WPqXKM=;
        b=RHsm7jmcYWm2Q9oKmM+L8tgArweCN6YVf4dEW6Kv1nwMqggVhoypvgvuNiEFo8zvYc
         0+jmRijMdSDSF526+unDd8jkvdjglvbN/I4Ck2T+WxXxo2/h61rL3MdrDSbzzeiUWQ+B
         fUKEmXjvIYGFqO1nFVmlRzEiTSWg9O1s5ddfEBWTWGzX8+1crI5lGJFccjYo/VJD54o1
         oUpdVkpvHRALBVuM1tY0CkkONwssnMTtY4PA8yXrTM1+GtcLwJhCZN7pJ/4YII3vj1+s
         K6eJZpHcLTPU+8lelVdObGfK36q3gLghXijM1QjXQ8J/S4d2msQQhsdZDSn2STgzYiT8
         y5hw==
X-Forwarded-Encrypted: i=1; AJvYcCVzaoGpXnW+5lGdRDPoCGxJQ1KQbv/YoObzUZU+X23oZU1YX00m8A3ECgLhEez9txMVzmoCA0MMZwcImLJxuz6kSzgIs99nTNoe
X-Gm-Message-State: AOJu0YysddkP1GXaIxt+7c3c9RmLM4DsTdMRlMRf4+Sx/x7uazyh850u
	xDlY+HrnihyNh1Scn4jehMFe68jOoOSCOLwvXcyCKr7TbU77uQnLfmbtygkNM/c=
X-Google-Smtp-Source: AGHT+IGJMrSXo+BoWjFD3YZaTDCDQ7RZ07Jdzue0BczQcFCAYdhG5ujMcuI8oUqi7AnH9+EQw3ZCUg==
X-Received: by 2002:adf:f986:0:b0:368:65a0:a423 with SMTP id ffacd0b85a97d-36b5d03c2eemr14195f8f.27.1722007220833;
        Fri, 26 Jul 2024 08:20:20 -0700 (PDT)
Received: from [192.168.1.61] (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net. [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c0338sm5500985f8f.1.2024.07.26.08.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 08:20:20 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 26 Jul 2024 17:20:09 +0200
Subject: [PATCH 4/5] ad7380: enable sequencer for single-ended parts
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-ad7380-add-single-ended-chips-v1-4-2d628b60ccd1@baylibre.com>
References: <20240726-ad7380-add-single-ended-chips-v1-0-2d628b60ccd1@baylibre.com>
In-Reply-To: <20240726-ad7380-add-single-ended-chips-v1-0-2d628b60ccd1@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.13.0

ad7386/7/8(-4) single-ended parts have a 2:1 mux in front of each ADC.

From an IIO point of view, all inputs are exported, i.e ad7386/7/8
export 4 channels and ad7386-4/7-4/8-4 export 8 channels. First inputs
of muxes correspond to the first half of IIO channels (i.e 0-1 or 0-3)
and second inputs correspond to second half (i.e 2-3 or 4-7)

Currently, the driver supports only sampling first half OR second half of
the IIO channels. To enable sampling all channels simultaneously, these
parts have an internal sequencer that automatically cycle through the
mux entries.

When enabled, the maximum throughput is divided by two. Moreover, the ADCs
need additional settling time, so we add an extra CS toggle to correctly
propagate setting, and an additional spi transfer to read the second
half.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 164 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 121 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index 25d42fff1839..11ed010431cf 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -33,7 +33,7 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
-#define MAX_NUM_CHANNELS		4
+#define MAX_NUM_CHANNELS		8
 /* 2.5V internal reference voltage */
 #define AD7380_INTERNAL_REF_MV		2500
 
@@ -52,6 +52,7 @@
 #define AD7380_REG_ADDR_ALERT_HIGH_TH	0x5
 
 #define AD7380_CONFIG1_CH		BIT(11)
+#define AD7380_CONFIG1_SEQ		BIT(10)
 #define AD7380_CONFIG1_OS_MODE		BIT(9)
 #define AD7380_CONFIG1_OSR		GENMASK(8, 6)
 #define AD7380_CONFIG1_CRC_W		BIT(5)
@@ -290,16 +291,22 @@ static const unsigned long ad7380_4_channel_scan_masks[] = {
  *
  * Since this is simultaneous sampling for AinX0 OR AinX1 we have two separate
  * scan masks.
+ * When sequencer mode is enabled, chip automatically cycle through
+ * AinX0 and AinX1 channels. From an IIO point of view, we ca enable all
+ * channels, at the cost of an extra read, thus dividing the maximum rate by
+ * two.
  */
 static const unsigned long ad7380_2x2_channel_scan_masks[] = {
 	GENMASK(1, 0),
 	GENMASK(3, 2),
+	GENMASK(3, 0),
 	0
 };
 
 static const unsigned long ad7380_2x4_channel_scan_masks[] = {
 	GENMASK(3, 0),
 	GENMASK(7, 4),
+	GENMASK(7, 0),
 	0
 };
 
@@ -467,11 +474,14 @@ struct ad7380_state {
 	unsigned int oversampling_ratio;
 	bool resolution_boost_enabled;
 	unsigned int ch;
+	bool seq;
 	unsigned int vref_mv;
 	unsigned int vcm_mv[MAX_NUM_CHANNELS];
 	/* xfers, message an buffer for reading sample data */
-	struct spi_transfer xfer[2];
-	struct spi_message msg;
+	struct spi_transfer normal_xfer[2];
+	struct spi_message normal_msg;
+	struct spi_transfer seq_xfer[4];
+	struct spi_message seq_msg;
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
 	 * to live in their own cache lines.
@@ -609,33 +619,47 @@ static int ad7380_set_ch(struct ad7380_state *st, unsigned int ch)
 static void ad7380_update_xfers(struct ad7380_state *st,
 				const struct iio_scan_type *scan_type)
 {
-	/*
-	 * First xfer only triggers conversion and has to be long enough for
-	 * all conversions to complete, which can be multiple conversion in the
-	 * case of oversampling. Technically T_CONVERT_X_NS is lower for some
-	 * chips, but we use the maximum value for simplicity for now.
-	 */
-	if (st->oversampling_ratio > 1)
-		st->xfer[0].delay.value = T_CONVERT_0_NS + T_CONVERT_X_NS *
-						(st->oversampling_ratio - 1);
-	else
-		st->xfer[0].delay.value = T_CONVERT_NS;
-
-	st->xfer[0].delay.unit = SPI_DELAY_UNIT_NSECS;
+	struct spi_transfer *xfer = st->seq ? st->seq_xfer : st->normal_xfer;
+	unsigned int t_convert = T_CONVERT_NS;
 
 	/*
-	 * Second xfer reads all channels. Data size depends on if resolution
-	 * boost is enabled or not.
+	 * In the case of oversampling, conversion time is higher than in normal
+	 * mode. Technically T_CONVERT_X_NS is lower for some chips, but we use
+	 * the maximum value for simplicity for now.
 	 */
-	st->xfer[1].bits_per_word = scan_type->realbits;
-	st->xfer[1].len = BITS_TO_BYTES(scan_type->storagebits) *
-			  st->chip_info->num_simult_channels;
+	if (st->oversampling_ratio > 1)
+		t_convert = T_CONVERT_0_NS + T_CONVERT_X_NS *
+			(st->oversampling_ratio - 1);
+
+	if (st->seq) {
+		xfer[0].delay.value = xfer[1].delay.value = t_convert;
+		xfer[0].delay.unit = xfer[1].delay.unit = SPI_DELAY_UNIT_NSECS;
+		xfer[2].bits_per_word = xfer[3].bits_per_word =
+			scan_type->realbits;
+		xfer[2].len = xfer[3].len =
+			BITS_TO_BYTES(scan_type->storagebits) *
+			st->chip_info->num_simult_channels;
+		xfer[3].rx_buf = xfer[2].rx_buf + xfer[2].len;
+		/* Additional delay required here when oversampling is enabled */
+		if (st->oversampling_ratio > 1)
+			xfer[2].delay.value = t_convert;
+		else
+			xfer[2].delay.value = 0;
+		xfer[2].delay.unit = SPI_DELAY_UNIT_NSECS;
+	} else {
+		xfer[0].delay.value = t_convert;
+		xfer[0].delay.unit = SPI_DELAY_UNIT_NSECS;
+		xfer[1].bits_per_word = scan_type->realbits;
+		xfer[1].len = BITS_TO_BYTES(scan_type->storagebits) *
+			st->chip_info->num_simult_channels;
+	}
 }
 
 static int ad7380_triggered_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct ad7380_state *st = iio_priv(indio_dev);
 	const struct iio_scan_type *scan_type;
+	struct spi_message *msg = &st->normal_msg;
 
 	/*
 	 * Currently, we always read all channels at the same time. The scan_type
@@ -646,34 +670,62 @@ static int ad7380_triggered_buffer_preenable(struct iio_dev *indio_dev)
 		return PTR_ERR(scan_type);
 
 	if (st->chip_info->has_mux) {
-		unsigned int num_simult_channels = st->chip_info->num_simult_channels;
+		unsigned int num_simult_channels =
+			st->chip_info->num_simult_channels;
 		unsigned long active_scan_mask = *indio_dev->active_scan_mask;
 		unsigned int ch = 0;
 		int ret;
 
 		/*
 		 * Depending on the requested scan_mask and current state,
-		 * we need to change CH bit to sample correct data.
+		 * we need to either change CH bit, or enable sequencer mode
+		 * to sample correct data.
+		 * Sequencer mode is enabled if active mask corresponds to all
+		 * IIO channels enabled. Otherwise, CH bit is set.
 		 */
-		if (active_scan_mask == GENMASK(2 * num_simult_channels - 1,
-						num_simult_channels))
-			ch = 1;
+		if (active_scan_mask == GENMASK(2 * num_simult_channels - 1, 0)) {
+			ret = regmap_update_bits(st->regmap,
+						 AD7380_REG_ADDR_CONFIG1,
+						 AD7380_CONFIG1_SEQ,
+						 FIELD_PREP(AD7380_CONFIG1_SEQ, 1));
+			msg = &st->seq_msg;
+			st->seq = true;
+		} else {
+			if (active_scan_mask == GENMASK(2 * num_simult_channels - 1,
+							num_simult_channels))
+				ch = 1;
+
+			ret = ad7380_set_ch(st, ch);
+		}
 
-		ret = ad7380_set_ch(st, ch);
 		if (ret)
 			return ret;
 	}
 
 	ad7380_update_xfers(st, scan_type);
 
-	return spi_optimize_message(st->spi, &st->msg);
+	return spi_optimize_message(st->spi, msg);
 }
 
 static int ad7380_triggered_buffer_postdisable(struct iio_dev *indio_dev)
 {
 	struct ad7380_state *st = iio_priv(indio_dev);
+	struct spi_message *msg = &st->normal_msg;
+	int ret;
+
+	if (st->seq) {
+		ret = regmap_update_bits(st->regmap,
+					 AD7380_REG_ADDR_CONFIG1,
+					 AD7380_CONFIG1_SEQ,
+					 FIELD_PREP(AD7380_CONFIG1_SEQ, 0));
+		if (ret)
+			return ret;
+
+		msg = &st->seq_msg;
+		st->seq = false;
+	}
 
-	spi_unoptimize_message(&st->msg);
+	spi_unoptimize_message(msg);
 
 	return 0;
 }
@@ -688,9 +740,10 @@ static irqreturn_t ad7380_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ad7380_state *st = iio_priv(indio_dev);
+	struct spi_message *msg = st->seq ? &st->seq_msg : &st->normal_msg;
 	int ret;
 
-	ret = spi_sync(st->spi, &st->msg);
+	ret = spi_sync(st->spi, msg);
 	if (ret)
 		goto out;
 
@@ -724,7 +777,7 @@ static int ad7380_read_direct(struct ad7380_state *st, unsigned int scan_index,
 
 	ad7380_update_xfers(st, scan_type);
 
-	ret = spi_sync(st->spi, &st->msg);
+	ret = spi_sync(st->spi, &st->normal_msg);
 	if (ret < 0)
 		return ret;
 
@@ -920,6 +973,7 @@ static int ad7380_init(struct ad7380_state *st, struct regulator *vref)
 	/* This is the default value after reset. */
 	st->oversampling_ratio = 1;
 	st->ch = 0;
+	st->seq = false;
 
 	/* SPI 1-wire mode */
 	return regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG2,
@@ -1021,21 +1075,45 @@ static int ad7380_probe(struct spi_device *spi)
 				     "failed to allocate register map\n");
 
 	/*
-	 * Setting up a low latency read for getting sample data. Used for both
-	 * direct read an triggered buffer. Additional fields will be set up in
-	 * ad7380_update_xfers() based on the current state of the driver at the
-	 * time of the read.
+	 * Setting up xfer structures for both normal and sequence mode. These
+	 * struct are used for both direct read and triggered buffer. Additional
+	 * fields will be set up in ad7380_update_xfers() based on the current
+	 * state of the driver at the time of the read.
 	 */
 
-	/* toggle CS (no data xfer) to trigger a conversion */
-	st->xfer[0].cs_change = 1;
-	st->xfer[0].cs_change_delay.value = st->chip_info->timing_specs->t_csh_ns;
-	st->xfer[0].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
-
-	/* then do a second xfer to read the data */
-	st->xfer[1].rx_buf = st->scan_data;
+	/*
+	 * In normal mode a read is composed of two steps:
+	 *   - first, toggle CS (no data xfer) to trigger a conversion
+	 *   - then, read data
+	 */
+	st->normal_xfer[0].cs_change = 1;
+	st->normal_xfer[0].cs_change_delay.value = st->chip_info->timing_specs->t_csh_ns;
+	st->normal_xfer[0].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
+	st->normal_xfer[1].rx_buf = st->scan_data;
 
-	spi_message_init_with_transfers(&st->msg, st->xfer, ARRAY_SIZE(st->xfer));
+	spi_message_init_with_transfers(&st->normal_msg, st->normal_xfer,
+					ARRAY_SIZE(st->normal_xfer));
+	/*
+	 * In sequencer mode a read is composed of four steps:
+	 *   - CS toggle (no data xfer) to get the right point in the sequence
+	 *   - CS toggle (no data xfer) to trigger a conversion of AinX0 and
+	 *   acquisition of AinX1
+	 *   - 2 data reads, to read AinX0 and AinX1
+	 */
+	st->seq_xfer[0].cs_change = 1;
+	st->seq_xfer[0].cs_change_delay.value = st->chip_info->timing_specs->t_csh_ns;
+	st->seq_xfer[0].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
+	st->seq_xfer[1].cs_change = 1;
+	st->seq_xfer[1].cs_change_delay.value = st->chip_info->timing_specs->t_csh_ns;
+	st->seq_xfer[1].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
+
+	st->seq_xfer[2].rx_buf = st->scan_data;
+	st->seq_xfer[2].cs_change = 1;
+	st->seq_xfer[2].cs_change_delay.value = st->chip_info->timing_specs->t_csh_ns;
+	st->seq_xfer[2].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
+
+	spi_message_init_with_transfers(&st->seq_msg, st->seq_xfer,
+					ARRAY_SIZE(st->seq_xfer));
 
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;

-- 
2.45.1


