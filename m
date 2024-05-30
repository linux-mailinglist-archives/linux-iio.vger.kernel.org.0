Return-Path: <linux-iio+bounces-5510-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 188128D4EE2
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 17:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61DC3B26ADB
	for <lists+linux-iio@lfdr.de>; Thu, 30 May 2024 15:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E909618308F;
	Thu, 30 May 2024 15:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EqTAk0HD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85AA182D07
	for <linux-iio@vger.kernel.org>; Thu, 30 May 2024 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717082076; cv=none; b=VcExVaAZPSm0uW8f0756PflDUys4urZ3UkO5AzUqkISp1x8FrdcAs+gSphl3EBHLaxDGp40znj4XvIMt/DuVuvnfD9V5eeDZUbbGtmmd2JlZm1t2LP0QylYc3197QyvRxHtxmKxaTGO5PG53D4eoWThF8snBCqEFSInC+II5oEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717082076; c=relaxed/simple;
	bh=y1tnKl81vB9sKRsENdbw7mPcxKNdOM0WJoCUmHL48lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EYubvd6geC2aQ5D1E39YuerllIiJb+9gvMLPTHAEVHT+Wr5irhA2NZxa1SUFDc/Stlbjf+/AozzJRyFcvOb4HHPtvt73Lrpw+vZF37kB2iJOTVuI9+6I8X5D81y7Ibmdp0jI1xfEvgsq8AqTozrtL1RcEwpl613gK7Q1rqnwwvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EqTAk0HD; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6f8e7b6c5dfso29863a34.1
        for <linux-iio@vger.kernel.org>; Thu, 30 May 2024 08:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717082073; x=1717686873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uS+7HdM7gPQMh4nz20sm9gmVe3Fbi635e2p6q2SK0c=;
        b=EqTAk0HDMiog2fdsuYym9oGCwrpLxKI3LnbCXyVjMdINLMz5CAb0lStsSrs1cMCPDQ
         Vx63zYMiksotUfdvd9YG5q5c1isJUH/x6cpB2OgIdg+UBHSq7nmdea/PqtFHrgNNeZ0A
         LcZp/vCcS7sOkIkJyt/rF8Cy8ilOCHaBvCxLMjQKUscOaKHzslOo8/lm7bht8O3mV2Ea
         cI1MjCVF2qkyje/VNXEC+jRapu2twigya0amiEgFZHIiyrREpNRvllN6htoBBoGx99fY
         Y6mQQl3VIfpW9cFlg5C1tg+bGnike9PpIUFItt6VzCsGdBQUgiByB8YHGfz8A5MEzOKG
         MxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717082073; x=1717686873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1uS+7HdM7gPQMh4nz20sm9gmVe3Fbi635e2p6q2SK0c=;
        b=BA3RLyi7xmodkKTwMn7t/CVj/M6cv7u9WUHAn10gSdgjHFZcoaXfaBEPLlPAB/8Pjr
         rkDXCFXxJ+X+He9Vx+2aYqyjHVyJrS0j13iP9Vm89EpPjpB8lUxEXvrGUyl37mg8lQ3D
         y+pSbpo+1m6wtUN0ahIqPkFEcaRGJ9xAvPiTkw1rNzt+/Wh2Se4qR1XizOKU6fut9QyZ
         PVznmybLF/DvD4TT+qOv1uF5er/kv3waR3d5AYYEzo8LssKSq3ax2owhXXYjQgcp4QnA
         RDcu1B5dFEP5EhK3vgWv6YB7FQdBAxDqQKqOTrDu0wJGMkXOsS9C/nPMeu1EO8Dt3STR
         5xHg==
X-Forwarded-Encrypted: i=1; AJvYcCXkct+trGPmPzyGyv4qf+OaJrj8XIKwA8HB2HI6zspbCxgZolDJXCqbh5urWQAO2a5iIlk4Mms57OKTYvbvDBehE3Dqk6hYZyOo
X-Gm-Message-State: AOJu0Yx+1x2reewRjmHYsnac9KI1eP3Wgfo+iSdk7uqloPuHvyknYjIP
	mpFpD1EFVKAYPEo6/gK6Jae7gVUtDeKAqLnJfO4ezgvfmKZl9WDyuOA1j7WXKXQ=
X-Google-Smtp-Source: AGHT+IG/EEmzr4DFqTUvQIOD9G+C1icZCdRmwofW65huY55CffB9nwBvBXn27P+t/Nh+L9qOth1PgA==
X-Received: by 2002:a9d:6d04:0:b0:6f8:f6d4:ba31 with SMTP id 46e09a7af769-6f90aeb073dmr2771912a34.12.1717082072779;
        Thu, 30 May 2024 08:14:32 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f8d0de6314sm2803425a34.41.2024.05.30.08.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 08:14:32 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Julien Stephan <jstephan@baylibre.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] iio: adc: ad7380: add oversampling support
Date: Thu, 30 May 2024 10:14:12 -0500
Message-ID: <20240530-iio-add-support-for-multiple-scan-types-v3-5-cbc4acea2cfa@baylibre.com>
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

From: Julien Stephan <jstephan@baylibre.com>

ad7380x(-4) parts are able to do oversampling to increase accuracy.

This chips supports a normal oversampling mode and a rolling mode and
also allows enabling and disabling extra resolution bits when
oversampling is enabled.

We have intentionally left out the rolling mode for now as there is not
a compelling use case for it. User can process a captured data buffer
to get the same effect.

We are also currently not supporting changing the oversampling mode
independently of the resolution bits. The resolution boost feature
can only be enabled when oversampling is enabled and oversampling is
not as useful without the resolution boost. So for now we consider the
features tightly coupled. When oversampling is enabled, the resolution
boost is enabled and when oversampling is disabled, the resolution
boost is disabled.

Since the resolution boost feature causes 16-bit chips to now have
18-bit data which means the storagebits has to change from 16 to 32
bits, we use the new ext_scan_type feature to allow changing the
scan_type at runtime based on if the resolution boost is enabled or
not.

SPI message optimization has to be moved since now some of the xfer
parameters change based on the resolution boost mode.

A few neighboring comments are also fixed up while we are touching this
code.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
Co-developed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v3 changes:
* This is a combination/rework of [1] from v1 of this series plus [2]
  and [3] from v6 of the ad7380 introductory series.
* Fixed comment lengths to ~80 characters.
* Renamed osr_check function.
* Resolution boost is no longer a separate feature from oversampling.
* Convert scan_data to u8[] and use ALIGN to ensure correct size.
* Reworked ext_scan_type to accommodate other revisions from this series.

[1]: https://lore.kernel.org/linux-iio/20240507-iio-add-support-for-multiple-scan-types-v1-4-95ac33ee51e9@baylibre.com/
[2]: https://lore.kernel.org/linux-iio/20240501-adding-new-ad738x-driver-v6-8-3c0741154728@baylibre.com/
[3]: https://lore.kernel.org/linux-iio/20240501-adding-new-ad738x-driver-v6-10-3c0741154728@baylibre.com/
---
 drivers/iio/adc/ad7380.c | 305 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 260 insertions(+), 45 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index 006496807de9..2f9f871a0ae0 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -13,6 +13,7 @@
  * ad7383/4-4 : https://www.analog.com/media/en/technical-documentation/data-sheets/ad7383-4-ad7384-4.pdf
  */
 
+#include <linux/align.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/cleanup.h>
@@ -68,6 +69,9 @@
 #define AD7380_ALERT_HIGH_TH		GENMASK(11, 0)
 
 #define T_CONVERT_NS 190		/* conversion time */
+#define T_CONVERT_0_NS 10		/* 1st conversion start time (oversampling) */
+#define T_CONVERT_X_NS 500		/* xth conversion start time (oversampling) */
+
 struct ad7380_timing_specs {
 	const unsigned int t_csh_ns;	/* CS minimum high time */
 };
@@ -82,22 +86,59 @@ struct ad7380_chip_info {
 	const struct ad7380_timing_specs *timing_specs;
 };
 
+enum {
+	AD7380_SCAN_TYPE_NORMAL,
+	AD7380_SCAN_TYPE_RESOLUTION_BOOST,
+};
+
+/* Extended scan types for 14-bit chips. */
+static const struct iio_scan_type ad7380_scan_type_14[] = {
+	[AD7380_SCAN_TYPE_NORMAL] = {
+		.sign = 's',
+		.realbits = 14,
+		.storagebits = 16,
+		.endianness = IIO_CPU
+	},
+	[AD7380_SCAN_TYPE_RESOLUTION_BOOST] = {
+		.sign = 's',
+		.realbits = 16,
+		.storagebits = 16,
+		.endianness = IIO_CPU
+	},
+};
+
+/* Extended scan types for 16-bit chips. */
+static const struct iio_scan_type ad7380_scan_type_16[] = {
+	[AD7380_SCAN_TYPE_NORMAL] = {
+		.sign = 's',
+		.realbits = 16,
+		.storagebits = 16,
+		.endianness = IIO_CPU
+	},
+	[AD7380_SCAN_TYPE_RESOLUTION_BOOST] = {
+		.sign = 's',
+		.realbits = 18,
+		.storagebits = 32,
+		.endianness = IIO_CPU
+	},
+};
+
 #define AD7380_CHANNEL(index, bits, diff) {			\
 	.type = IIO_VOLTAGE,					\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
 		((diff) ? 0 : BIT(IIO_CHAN_INFO_OFFSET)),	\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
+	.info_mask_shared_by_type_available =			\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
 	.indexed = 1,						\
 	.differential = (diff),					\
 	.channel = (diff) ? (2 * (index)) : (index),		\
 	.channel2 = (diff) ? (2 * (index) + 1) : 0,		\
 	.scan_index = (index),					\
-	.scan_type = {						\
-		.sign = 's',					\
-		.realbits = (bits),				\
-		.storagebits = 16,				\
-		.endianness = IIO_CPU,				\
-	},							\
+	.has_ext_scan_type = 1,					\
+	.ext_scan_type = ad7380_scan_type_##bits,		\
+	.num_ext_scan_type = ARRAY_SIZE(ad7380_scan_type_##bits),\
 }
 
 #define DEFINE_AD7380_2_CHANNEL(name, bits, diff)	\
@@ -154,6 +195,15 @@ static const struct ad7380_timing_specs ad7380_4_timing = {
 	.t_csh_ns = 20,
 };
 
+/*
+ * Available oversampling ratios. The indices correspond with the bit value
+ * expected by the chip.  The available ratios depend on the averaging mode,
+ * only normal averaging is supported for now.
+ */
+static const int ad7380_oversampling_ratios[] = {
+	1, 2, 4, 8, 16, 32,
+};
+
 static const struct ad7380_chip_info ad7380_chip_info = {
 	.name = "ad7380",
 	.channels = ad7380_channels,
@@ -230,23 +280,23 @@ struct ad7380_state {
 	const struct ad7380_chip_info *chip_info;
 	struct spi_device *spi;
 	struct regmap *regmap;
+	unsigned int oversampling_ratio;
+	bool resolution_boost_enabled;
 	unsigned int vref_mv;
 	unsigned int vcm_mv[MAX_NUM_CHANNELS];
 	/* xfers, message an buffer for reading sample data */
 	struct spi_transfer xfer[2];
 	struct spi_message msg;
 	/*
-	 * DMA (thus cache coherency maintenance) requires the
-	 * transfer buffers to live in their own cache lines.
-	 * Make the buffer large enough for MAX_NUM_CHANNELS 16-bit samples and one 64-bit
-	 * aligned 64 bit timestamp.
-	 * As MAX_NUM_CHANNELS is 4 the layout of the structure is the same for all parts
+	 * DMA (thus cache coherency maintenance) requires the transfer buffers
+	 * to live in their own cache lines.
+	 *
+	 * Make the buffer large enough for MAX_NUM_CHANNELS 32-bit samples and
+	 * one 64-bit aligned 64-bit timestamp.
 	 */
-	struct {
-		u16 raw[MAX_NUM_CHANNELS];
-
-		s64 ts __aligned(8);
-	} scan_data __aligned(IIO_DMA_MINALIGN);
+	u8 scan_data[ALIGN(MAX_NUM_CHANNELS * sizeof(u32), sizeof(s64))
+			   + sizeof(s64)] __aligned(IIO_DMA_MINALIGN);
+	/* buffers for reading/writing registers */
 	u16 tx;
 	u16 rx;
 };
@@ -329,6 +379,69 @@ static int ad7380_debugfs_reg_access(struct iio_dev *indio_dev, u32 reg,
 	unreachable();
 }
 
+/**
+ * ad7380_update_xfers - update the SPI transfers base on the current scan type
+ * @indio_dev:	IIO device structure
+ * @chan:	IIO channel
+ */
+static void ad7380_update_xfers(struct ad7380_state *st,
+				const struct iio_scan_type *scan_type)
+{
+	/*
+	 * First xfer only triggers conversion and has to be long enough for
+	 * all conversions to complete, which can be multiple conversion in the
+	 * case of oversampling. Technically T_CONVERT_X_NS is lower for some
+	 * chips, but we use the maximum value for simplicity for now.
+	 */
+	if (st->oversampling_ratio > 1)
+		st->xfer[0].delay.value = T_CONVERT_0_NS + T_CONVERT_X_NS *
+						(st->oversampling_ratio - 1);
+	else
+		st->xfer[0].delay.value = T_CONVERT_NS;
+
+	st->xfer[0].delay.unit = SPI_DELAY_UNIT_NSECS;
+
+	/*
+	 * Second xfer reads all channels. Data size depends on if resolution
+	 * boost is enabled or not.
+	 */
+	st->xfer[1].bits_per_word = scan_type->realbits;
+	st->xfer[1].len = BITS_TO_BYTES(scan_type->storagebits) *
+			  (st->chip_info->num_channels - 1);
+}
+
+static int ad7380_triggered_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct ad7380_state *st = iio_priv(indio_dev);
+	const struct iio_scan_type *scan_type;
+
+	/*
+	 * Currently, we always read all channels at the same time. The scan_type
+	 * is the same for all channels, so we just pass the first channel.
+	 */
+	scan_type = iio_get_current_scan_type(indio_dev, &indio_dev->channels[0]);
+	if (IS_ERR(scan_type))
+		return PTR_ERR(scan_type);
+
+	ad7380_update_xfers(st, scan_type);
+
+	return spi_optimize_message(st->spi, &st->msg);
+}
+
+static int ad7380_triggered_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct ad7380_state *st = iio_priv(indio_dev);
+
+	spi_unoptimize_message(&st->msg);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ad7380_buffer_setup_ops = {
+	.preenable = ad7380_triggered_buffer_preenable,
+	.postdisable = ad7380_triggered_buffer_postdisable,
+};
+
 static irqreturn_t ad7380_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -349,17 +462,23 @@ static irqreturn_t ad7380_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-static int ad7380_read_direct(struct ad7380_state *st,
-			      struct iio_chan_spec const *chan, int *val)
+static int ad7380_read_direct(struct ad7380_state *st, unsigned int scan_index,
+			      const struct iio_scan_type *scan_type, int *val)
 {
 	int ret;
 
+	ad7380_update_xfers(st, scan_type);
+
 	ret = spi_sync(st->spi, &st->msg);
 	if (ret < 0)
 		return ret;
 
-	*val = sign_extend32(st->scan_data.raw[chan->scan_index],
-			     chan->scan_type.realbits - 1);
+	if (scan_type->storagebits > 16)
+		*val = sign_extend32(*(u32 *)(st->scan_data + 4 * scan_index),
+				     scan_type->realbits - 1);
+	else
+		*val = sign_extend32(*(u16 *)(st->scan_data + 2 * scan_index),
+				     scan_type->realbits - 1);
 
 	return IIO_VAL_INT;
 }
@@ -369,11 +488,18 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long info)
 {
 	struct ad7380_state *st = iio_priv(indio_dev);
+	const struct iio_scan_type *scan_type;
+
+	scan_type = iio_get_current_scan_type(indio_dev, chan);
+
+	if (IS_ERR(scan_type))
+		return PTR_ERR(scan_type);
 
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
 		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
-			return ad7380_read_direct(st, chan, val);
+			return ad7380_read_direct(st, chan->scan_index,
+						  scan_type, val);
 		}
 		unreachable();
 	case IIO_CHAN_INFO_SCALE:
@@ -384,7 +510,7 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
 		 * where N is the ADC resolution (i.e realbits)
 		 */
 		*val = st->vref_mv;
-		*val2 = chan->scan_type.realbits - chan->differential;
+		*val2 = scan_type->realbits - chan->differential;
 
 		return IIO_VAL_FRACTIONAL_LOG2;
 	case IIO_CHAN_INFO_OFFSET:
@@ -392,17 +518,118 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
 		 * According to IIO ABI, offset is applied before scale,
 		 * so offset is: vcm_mv / scale
 		 */
-		*val = st->vcm_mv[chan->channel] * (1 << chan->scan_type.realbits)
+		*val = st->vcm_mv[chan->channel] * (1 << scan_type->realbits)
 			/ st->vref_mv;
 
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*val = st->oversampling_ratio;
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad7380_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*vals = ad7380_oversampling_ratios;
+		*length = ARRAY_SIZE(ad7380_oversampling_ratios);
+		*type = IIO_VAL_INT;
+
+		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
 	}
 }
 
+/**
+ * ad7380_osr_to_regval - convert ratio to OSR register value
+ * @ratio: ratio to check
+ *
+ * Check if ratio is present in the list of available ratios and return the
+ * corresponding value that needs to be written to the register to select that
+ * ratio.
+ *
+ * Returns: register value (0 to 7) or -EINVAL if there is not an exact match
+ */
+static int ad7380_osr_to_regval(int ratio)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ad7380_oversampling_ratios); i++) {
+		if (ratio == ad7380_oversampling_ratios[i])
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int ad7380_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int val,
+			    int val2, long mask)
+{
+	struct ad7380_state *st = iio_priv(indio_dev);
+	int ret, osr, boost;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		osr = ad7380_osr_to_regval(val);
+		if (osr < 0)
+			return osr;
+
+		/* always enable resolution boost when oversampling is enabled */
+		boost = osr > 0 ? 1 : 0;
+
+		iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
+			ret = regmap_update_bits(st->regmap,
+					AD7380_REG_ADDR_CONFIG1,
+					AD7380_CONFIG1_OSR | AD7380_CONFIG1_RES,
+					FIELD_PREP(AD7380_CONFIG1_OSR, osr) |
+					FIELD_PREP(AD7380_CONFIG1_RES, boost));
+
+			if (ret)
+				return ret;
+
+			st->oversampling_ratio = val;
+			st->resolution_boost_enabled = boost;
+
+			/*
+			 * Perform a soft reset. This will flush the oversampling
+			 * block and FIFO but will maintain the content of the
+			 * configurable registers.
+			 */
+			return regmap_update_bits(st->regmap,
+					AD7380_REG_ADDR_CONFIG2,
+					AD7380_CONFIG2_RESET,
+					FIELD_PREP(AD7380_CONFIG2_RESET,
+						   AD7380_CONFIG2_RESET_SOFT));
+		}
+		unreachable();
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad7380_get_current_scan_type(const struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan)
+{
+	struct ad7380_state *st = iio_priv(indio_dev);
+
+	return st->resolution_boost_enabled ? AD7380_SCAN_TYPE_RESOLUTION_BOOST
+					    : AD7380_SCAN_TYPE_NORMAL;
+}
+
 static const struct iio_info ad7380_info = {
 	.read_raw = &ad7380_read_raw,
+	.read_avail = &ad7380_read_avail,
+	.write_raw = &ad7380_write_raw,
+	.get_current_scan_type = &ad7380_get_current_scan_type,
 	.debugfs_reg_access = &ad7380_debugfs_reg_access,
 };
 
@@ -426,6 +653,9 @@ static int ad7380_init(struct ad7380_state *st, struct regulator *vref)
 	if (ret < 0)
 		return ret;
 
+	/* This is the default value after reset. */
+	st->oversampling_ratio = 1;
+
 	/* SPI 1-wire mode */
 	return regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG2,
 				  AD7380_CONFIG2_SDO,
@@ -437,11 +667,6 @@ static void ad7380_regulator_disable(void *p)
 	regulator_disable(p);
 }
 
-static void ad7380_unoptimize_msg(void *msg)
-{
-	spi_unoptimize_message(msg);
-}
-
 static int ad7380_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
@@ -532,32 +757,21 @@ static int ad7380_probe(struct spi_device *spi)
 
 	/*
 	 * Setting up a low latency read for getting sample data. Used for both
-	 * direct read an triggered buffer.
+	 * direct read an triggered buffer. Additional fields will be set up in
+	 * ad7380_update_xfers() based on the current state of the driver at the
+	 * time of the read.
 	 */
 
 	/* toggle CS (no data xfer) to trigger a conversion */
-	st->xfer[0].delay.value = T_CONVERT_NS;
-	st->xfer[0].delay.unit = SPI_DELAY_UNIT_NSECS;
 	st->xfer[0].cs_change = 1;
 	st->xfer[0].cs_change_delay.value = st->chip_info->timing_specs->t_csh_ns;
 	st->xfer[0].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
 
 	/* then do a second xfer to read the data */
-	st->xfer[1].bits_per_word = st->chip_info->channels[0].scan_type.realbits;
-	st->xfer[1].rx_buf = st->scan_data.raw;
-	st->xfer[1].len = BITS_TO_BYTES(st->chip_info->channels[0].scan_type.storagebits)
-				* (st->chip_info->num_channels - 1);
+	st->xfer[1].rx_buf = st->scan_data;
 
 	spi_message_init_with_transfers(&st->msg, st->xfer, ARRAY_SIZE(st->xfer));
 
-	ret = spi_optimize_message(st->spi, &st->msg);
-	if (ret)
-		return ret;
-
-	ret = devm_add_action_or_reset(&spi->dev, ad7380_unoptimize_msg, &st->msg);
-	if (ret)
-		return ret;
-
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 	indio_dev->name = st->chip_info->name;
@@ -567,7 +781,8 @@ static int ad7380_probe(struct spi_device *spi)
 
 	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
 					      iio_pollfunc_store_time,
-					      ad7380_trigger_handler, NULL);
+					      ad7380_trigger_handler,
+					      &ad7380_buffer_setup_ops);
 	if (ret)
 		return ret;
 

-- 
2.45.1


