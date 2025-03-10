Return-Path: <linux-iio+bounces-16684-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54277A59FA0
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 18:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 450EB3A7D6D
	for <lists+linux-iio@lfdr.de>; Mon, 10 Mar 2025 17:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C13233D85;
	Mon, 10 Mar 2025 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ky2SD+Xd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F2618DB24
	for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628475; cv=none; b=IAzePGu4NHpdbcATREFEmgK56C/oCktcnPgAhOY/yl7XmzK5kTZ6VR+0Ye6WCNWWN+cUC/YXkPkSsA5IsafMcshXSfIcUv8Jul9twCAMrfwUtoiZ6B0S1defVYlHDgemy3Xn4kxeqBT4DeUlT127D/TembP/4OfLRLDW+U4fkTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628475; c=relaxed/simple;
	bh=/mxbPBPHIikhAFRN8rcn/47DsU2LMelbsUgTvqHEeHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LK2B3HA+OyD41G/IlNXfb//EUX9KXZuXcO9ul0O7PK9HswKoWMb4joC6cg8Rj+CrDD8f37hYDyIAXSULKFMxelv8FPAd/N8XgMTQ5qXBYECAlCmga9wYHGyIeTAWzFTXWDdblGUNAsDJLgo34INK3jzICruSAAcns3saHUGnbFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ky2SD+Xd; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39129fc51f8so3791894f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 10 Mar 2025 10:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741628471; x=1742233271; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FWTl/Il2R/pyB5A61m5+Ru5Ym+TwIMgmhhjaKwbDWLg=;
        b=ky2SD+XdR4A9H8mMMugrTpTQzQhjVLPe1iyebdzSaHPsrep43ujt2nTGnuUju8CtFa
         lNZmakSjwgtoycyXQtDNyCZX8rJXNPUDKxjWuebHnzG6zJLYPT78g9qd8Y6iiXwVAPRQ
         hXUaD2VrisV8aFH1POMy5tEPCRyPpLQ9VQTflLkMnoCHib6tHHRX+FLA+l0FlAqXdgRt
         j1KhxvmykHygPuKDGbJMleV5nnkOCbBD73trp1PJu5+VIaJ1KAj2Jexrs/R9fZ2D6qP9
         DeWKsgo8ELmofDkMF269j5e+G8M3cS/nRTjOSLiC4MNqkTEHVxQbt2o5Q1u6WxEtZ6Yj
         x7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741628471; x=1742233271;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWTl/Il2R/pyB5A61m5+Ru5Ym+TwIMgmhhjaKwbDWLg=;
        b=dmmvX9S42o0Nh06/I2+oZMnGh1cKc5q8ryptB0UeHbNUt45asuGAzgZFBiw5Fqgs6o
         jQTYmtMeOmVASyHZyIy2F2PnN0bKS0obHKGJ1sYGxT+jDVHmRXm/CCC3jGa+p2LeMi0s
         nIHUaOnR+NWNLSshT9y/7THpJBMtUTxPzSV+hlcYUHe+foMd4xlgLtX7Xc7LIAs2AmK9
         h/KpEXk1tTLby+bTrZTxP8E52x7bDTMjGn16m8EqvV54gdyeT62q91o+U8kDb0uuIPlW
         o0+ACYp5S7z0J+H/r7CrIKbpFJ5eN2iIrLOkQdkRkgDIAKt+zGKwcxCGPJBK5e8sP9s0
         C8LQ==
X-Gm-Message-State: AOJu0YxZpj2O2fPDZoemfy0e5O3kBZrhnou9W0u8VzHp613b4DTTYnYt
	FTqA+bGYBxTZfVhNXmYEnKAplQqoQ/Gxs5+nnWV/foYmQyUPnMPNDFPyxo4avzCNQYLQFl+SWVf
	7
X-Gm-Gg: ASbGncsklUIZvOHlUyQdN+/afmHsoZt+Eg60Rxcb5+I+2Kb0EvBEyUPv7YCJ4ZJl1Xr
	SJWcv20PgOZafgIYT/7eiFrqtswb3TwVwD0tztdfPQqZgR9LZwVCNi0ZZ4DbZVjK5TmPQsZl6dv
	0ffvmbW/pzj/ImI+qJdDdVbB5JDsp9C18bWnGxnJbMkzU9AWHrUHQszMBmQ05WLUXt8KP5OsEmG
	ETYwiYFJrZboSTX3bvzMIcxrDdEv59LxVrXyx2wKMnyWQrU+0xAx49GaSpErN2djbG2Cr7n6fR/
	O3zAzk+Cg3598RTwvS6768z9jdNXZkNmeNwULSkp45+t40bBHLbODEMpsKP6lV4X/NWGnHDIGhC
	YCZaV2t+DMtvKwHOQ6fI=
X-Google-Smtp-Source: AGHT+IEU1RH4EHxS7tu91RJngpnPZ7CzTfcAu7+QdvKqdupJct4Dq/I2NslEyt7fmSqzpFtKX7meHQ==
X-Received: by 2002:a5d:47c1:0:b0:391:2bcc:11f2 with SMTP id ffacd0b85a97d-39132d2ac45mr8833354f8f.1.1741628470605;
        Mon, 10 Mar 2025 10:41:10 -0700 (PDT)
Received: from [127.0.1.1] (host-82-56-170-15.retail.telecomitalia.it. [82.56.170.15])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba8a9sm15597038f8f.9.2025.03.10.10.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 10:41:10 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 10 Mar 2025 18:39:52 +0100
Subject: [PATCH v4 1/2] iio: ad7380: add support for SPI offload
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-wip-bl-spi-offload-ad7380-v4-1-b184b37b7c72@baylibre.com>
References: <20250310-wip-bl-spi-offload-ad7380-v4-0-b184b37b7c72@baylibre.com>
In-Reply-To: <20250310-wip-bl-spi-offload-ad7380-v4-0-b184b37b7c72@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2

From: Angelo Dureghello <adureghello@baylibre.com>

Add support for SPI offload to the ad7380 driver. SPI offload allows
sampling data at the max sample rate (2MSPS with one SDO line).

This is developed and tested against the ADI example FPGA design for
this family of ADCs [1].

[1]: http://analogdevicesinc.github.io/hdl/projects/ad738x_fmc/index.html

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/adc/Kconfig  |   2 +
 drivers/iio/adc/ad7380.c | 511 +++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 477 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index b7ae6e0ae0df0f9ecc6023ed4b1b0ebfcd643e7e..6529df1a498c2c3b32b3640b5c3a90d8fff33788 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -228,7 +228,9 @@ config AD7298
 config AD7380
 	tristate "Analog Devices AD7380 ADC driver"
 	depends on SPI_MASTER
+	select SPI_OFFLOAD
 	select IIO_BUFFER
+	select IIO_BUFFER_DMAENGINE
 	select IIO_TRIGGER
 	select IIO_TRIGGERED_BUFFER
 	help
diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index 407930f1f5dd107154a6c34c6afd4429ebb69826..4fcb49fdf56639784098f0147a9faef8dcb6b0f6 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -16,6 +16,9 @@
  * adaq4370-4 : https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4370-4.pdf
  * adaq4380-4 : https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4380-4.pdf
  * adaq4381-4 : https://www.analog.com/media/en/technical-documentation/data-sheets/adaq4381-4.pdf
+ *
+ * HDL ad738x_fmc: https://analogdevicesinc.github.io/hdl/projects/ad738x_fmc/index.html
+ *
  */
 
 #include <linux/align.h>
@@ -30,11 +33,13 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+#include <linux/spi/offload/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/units.h>
 #include <linux/util_macros.h>
 
 #include <linux/iio/buffer.h>
+#include <linux/iio/buffer-dmaengine.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger_consumer.h>
@@ -93,6 +98,12 @@
 #define AD7380_NUM_SDO_LINES		1
 #define AD7380_DEFAULT_GAIN_MILLI	1000
 
+/*
+ * Using SPI offload, storagebits is always 32, so can't be used to compute struct
+ * spi_transfer.len. Using realbits instead.
+ */
+#define AD7380_SPI_BYTES(scan_type)	((scan_type)->realbits > 16 ? 4 : 2)
+
 struct ad7380_timing_specs {
 	const unsigned int t_csh_ns;	/* CS minimum high time */
 };
@@ -100,6 +111,7 @@ struct ad7380_timing_specs {
 struct ad7380_chip_info {
 	const char *name;
 	const struct iio_chan_spec *channels;
+	const struct iio_chan_spec *offload_channels;
 	unsigned int num_channels;
 	unsigned int num_simult_channels;
 	bool has_hardware_gain;
@@ -112,6 +124,7 @@ struct ad7380_chip_info {
 	unsigned int num_vcm_supplies;
 	const unsigned long *available_scan_masks;
 	const struct ad7380_timing_specs *timing_specs;
+	u32 max_conversion_rate_hz;
 };
 
 static const struct iio_event_spec ad7380_events[] = {
@@ -217,6 +230,91 @@ static const struct iio_scan_type ad7380_scan_type_16_u[] = {
 	},
 };
 
+/*
+ * Defining here scan types for offload mode, since with current available HDL
+ * only a value of 32 for storagebits is supported.
+ */
+
+/* Extended scan types for 12-bit unsigned chips, offload support. */
+static const struct iio_scan_type ad7380_scan_type_12_u_offload[] = {
+	[AD7380_SCAN_TYPE_NORMAL] = {
+		.sign = 'u',
+		.realbits = 12,
+		.storagebits = 32,
+		.endianness = IIO_CPU,
+	},
+	[AD7380_SCAN_TYPE_RESOLUTION_BOOST] = {
+		.sign = 'u',
+		.realbits = 14,
+		.storagebits = 32,
+		.endianness = IIO_CPU,
+	},
+};
+
+/* Extended scan types for 14-bit signed chips, offload support. */
+static const struct iio_scan_type ad7380_scan_type_14_s_offload[] = {
+	[AD7380_SCAN_TYPE_NORMAL] = {
+		.sign = 's',
+		.realbits = 14,
+		.storagebits = 32,
+		.endianness = IIO_CPU,
+	},
+	[AD7380_SCAN_TYPE_RESOLUTION_BOOST] = {
+		.sign = 's',
+		.realbits = 16,
+		.storagebits = 32,
+		.endianness = IIO_CPU,
+	},
+};
+
+/* Extended scan types for 14-bit unsigned chips, offload support. */
+static const struct iio_scan_type ad7380_scan_type_14_u_offload[] = {
+	[AD7380_SCAN_TYPE_NORMAL] = {
+		.sign = 'u',
+		.realbits = 14,
+		.storagebits = 32,
+		.endianness = IIO_CPU,
+	},
+	[AD7380_SCAN_TYPE_RESOLUTION_BOOST] = {
+		.sign = 'u',
+		.realbits = 16,
+		.storagebits = 32,
+		.endianness = IIO_CPU,
+	},
+};
+
+/* Extended scan types for 16-bit signed_chips, offload support. */
+static const struct iio_scan_type ad7380_scan_type_16_s_offload[] = {
+	[AD7380_SCAN_TYPE_NORMAL] = {
+		.sign = 's',
+		.realbits = 16,
+		.storagebits = 32,
+		.endianness = IIO_CPU,
+	},
+	[AD7380_SCAN_TYPE_RESOLUTION_BOOST] = {
+		.sign = 's',
+		.realbits = 18,
+		.storagebits = 32,
+		.endianness = IIO_CPU,
+	},
+};
+
+/* Extended scan types for 16-bit unsigned chips, offload support. */
+static const struct iio_scan_type ad7380_scan_type_16_u_offload[] = {
+	[AD7380_SCAN_TYPE_NORMAL] = {
+		.sign = 'u',
+		.realbits = 16,
+		.storagebits = 32,
+		.endianness = IIO_CPU,
+	},
+	[AD7380_SCAN_TYPE_RESOLUTION_BOOST] = {
+		.sign = 'u',
+		.realbits = 18,
+		.storagebits = 32,
+		.endianness = IIO_CPU,
+	},
+};
+
 #define _AD7380_CHANNEL(index, bits, diff, sign, gain) {			\
 	.type = IIO_VOLTAGE,							\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
@@ -238,48 +336,123 @@ static const struct iio_scan_type ad7380_scan_type_16_u[] = {
 	.num_event_specs = ARRAY_SIZE(ad7380_events),				\
 }
 
+#define _AD7380_OFFLOAD_CHANNEL(index, bits, diff, sign, gain) {		\
+	.type = IIO_VOLTAGE,							\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |                          \
+		((gain) ? BIT(IIO_CHAN_INFO_SCALE) : 0) |			\
+		((diff) ? 0 : BIT(IIO_CHAN_INFO_OFFSET)),			\
+	.info_mask_shared_by_type = ((gain) ? 0 : BIT(IIO_CHAN_INFO_SCALE)) |   \
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |				\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),					\
+	.info_mask_shared_by_type_available =					\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |				\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),					\
+	.indexed = 1,                                                           \
+	.differential = (diff),                                                 \
+	.channel = (diff) ? (2 * (index)) : (index),                            \
+	.channel2 = (diff) ? (2 * (index) + 1) : 0,                             \
+	.scan_index = (index),                                                  \
+	.has_ext_scan_type = 1,                                                 \
+	.ext_scan_type = ad7380_scan_type_##bits##_##sign##_offload,            \
+	.num_ext_scan_type =                                                    \
+		ARRAY_SIZE(ad7380_scan_type_##bits##_##sign##_offload),		\
+	.event_spec = ad7380_events,                                            \
+	.num_event_specs = ARRAY_SIZE(ad7380_events),                           \
+}
+
+/*
+ * Notes on the offload channels:
+ * - There is no soft timestamp since everything is done in hardware.
+ * - There is a sampling frequency attribute added. This controls the SPI
+ *   offload trigger.
+ * - The storagebits value depends on the SPI offload provider. Currently there
+ *   is only one supported provider, namely the ADI PULSAR ADC HDL project,
+ *   which always uses 32-bit words for data values, even for <= 16-bit ADCs.
+ *   So the value is just hardcoded to 32 for now.
+ */
+
 #define AD7380_CHANNEL(index, bits, diff, sign)		\
 	_AD7380_CHANNEL(index, bits, diff, sign, false)
 
 #define ADAQ4380_CHANNEL(index, bits, diff, sign)	\
 	_AD7380_CHANNEL(index, bits, diff, sign, true)
 
-#define DEFINE_AD7380_2_CHANNEL(name, bits, diff, sign)	\
+#define DEFINE_AD7380_2_CHANNEL(name, bits, diff, sign) \
+static const struct iio_chan_spec name[] = {	\
+	AD7380_CHANNEL(0, bits, diff, sign),	\
+	AD7380_CHANNEL(1, bits, diff, sign),	\
+	IIO_CHAN_SOFT_TIMESTAMP(2),		\
+}
+
+#define DEFINE_AD7380_4_CHANNEL(name, bits, diff, sign) \
+static const struct iio_chan_spec name[] = {	\
+	 AD7380_CHANNEL(0, bits, diff, sign),	\
+	 AD7380_CHANNEL(1, bits, diff, sign),	\
+	 AD7380_CHANNEL(2, bits, diff, sign),	\
+	 AD7380_CHANNEL(3, bits, diff, sign),	\
+	 IIO_CHAN_SOFT_TIMESTAMP(4),		\
+}
+
+#define DEFINE_ADAQ4380_4_CHANNEL(name, bits, diff, sign) \
+static const struct iio_chan_spec name[] = {	\
+	 ADAQ4380_CHANNEL(0, bits, diff, sign),	\
+	 ADAQ4380_CHANNEL(1, bits, diff, sign),	\
+	 ADAQ4380_CHANNEL(2, bits, diff, sign),	\
+	 ADAQ4380_CHANNEL(3, bits, diff, sign),	\
+	 IIO_CHAN_SOFT_TIMESTAMP(4),		\
+}
+
+#define DEFINE_AD7380_8_CHANNEL(name, bits, diff, sign) \
+static const struct iio_chan_spec name[] = {	\
+	 AD7380_CHANNEL(0, bits, diff, sign),	\
+	 AD7380_CHANNEL(1, bits, diff, sign),	\
+	 AD7380_CHANNEL(2, bits, diff, sign),	\
+	 AD7380_CHANNEL(3, bits, diff, sign),	\
+	 AD7380_CHANNEL(4, bits, diff, sign),	\
+	 AD7380_CHANNEL(5, bits, diff, sign),	\
+	 AD7380_CHANNEL(6, bits, diff, sign),	\
+	 AD7380_CHANNEL(7, bits, diff, sign),	\
+	 IIO_CHAN_SOFT_TIMESTAMP(8),		\
+}
+
+#define AD7380_OFFLOAD_CHANNEL(index, bits, diff, sign) \
+_AD7380_OFFLOAD_CHANNEL(index, bits, diff, sign, false)
+
+#define ADAQ4380_OFFLOAD_CHANNEL(index, bits, diff, sign) \
+_AD7380_OFFLOAD_CHANNEL(index, bits, diff, sign, true)
+
+#define DEFINE_AD7380_2_OFFLOAD_CHANNEL(name, bits, diff, sign) \
 static const struct iio_chan_spec name[] = {		\
-	AD7380_CHANNEL(0, bits, diff, sign),		\
-	AD7380_CHANNEL(1, bits, diff, sign),		\
-	IIO_CHAN_SOFT_TIMESTAMP(2),			\
+	AD7380_OFFLOAD_CHANNEL(0, bits, diff, sign),	\
+	AD7380_OFFLOAD_CHANNEL(1, bits, diff, sign),	\
 }
 
-#define DEFINE_AD7380_4_CHANNEL(name, bits, diff, sign)	\
+#define DEFINE_AD7380_4_OFFLOAD_CHANNEL(name, bits, diff, sign) \
 static const struct iio_chan_spec name[] = {		\
-	AD7380_CHANNEL(0, bits, diff, sign),		\
-	AD7380_CHANNEL(1, bits, diff, sign),		\
-	AD7380_CHANNEL(2, bits, diff, sign),		\
-	AD7380_CHANNEL(3, bits, diff, sign),		\
-	IIO_CHAN_SOFT_TIMESTAMP(4),			\
+	AD7380_OFFLOAD_CHANNEL(0, bits, diff, sign),	\
+	AD7380_OFFLOAD_CHANNEL(1, bits, diff, sign),	\
+	AD7380_OFFLOAD_CHANNEL(2, bits, diff, sign),	\
+	AD7380_OFFLOAD_CHANNEL(3, bits, diff, sign),	\
 }
 
-#define DEFINE_ADAQ4380_4_CHANNEL(name, bits, diff, sign)	\
-static const struct iio_chan_spec name[] = {			\
-	ADAQ4380_CHANNEL(0, bits, diff, sign),			\
-	ADAQ4380_CHANNEL(1, bits, diff, sign),			\
-	ADAQ4380_CHANNEL(2, bits, diff, sign),			\
-	ADAQ4380_CHANNEL(3, bits, diff, sign),			\
-	IIO_CHAN_SOFT_TIMESTAMP(4),				\
+#define DEFINE_ADAQ4380_4_OFFLOAD_CHANNEL(name, bits, diff, sign) \
+static const struct iio_chan_spec name[] = {		\
+	AD7380_OFFLOAD_CHANNEL(0, bits, diff, sign),	\
+	AD7380_OFFLOAD_CHANNEL(1, bits, diff, sign),	\
+	AD7380_OFFLOAD_CHANNEL(2, bits, diff, sign),	\
+	AD7380_OFFLOAD_CHANNEL(3, bits, diff, sign),	\
 }
 
-#define DEFINE_AD7380_8_CHANNEL(name, bits, diff, sign)	\
+#define DEFINE_AD7380_8_OFFLOAD_CHANNEL(name, bits, diff, sign) \
 static const struct iio_chan_spec name[] = {		\
-	AD7380_CHANNEL(0, bits, diff, sign),		\
-	AD7380_CHANNEL(1, bits, diff, sign),		\
-	AD7380_CHANNEL(2, bits, diff, sign),		\
-	AD7380_CHANNEL(3, bits, diff, sign),		\
-	AD7380_CHANNEL(4, bits, diff, sign),		\
-	AD7380_CHANNEL(5, bits, diff, sign),		\
-	AD7380_CHANNEL(6, bits, diff, sign),		\
-	AD7380_CHANNEL(7, bits, diff, sign),		\
-	IIO_CHAN_SOFT_TIMESTAMP(8),			\
+	AD7380_OFFLOAD_CHANNEL(0, bits, diff, sign),	\
+	AD7380_OFFLOAD_CHANNEL(1, bits, diff, sign),	\
+	AD7380_OFFLOAD_CHANNEL(2, bits, diff, sign),	\
+	AD7380_OFFLOAD_CHANNEL(3, bits, diff, sign),	\
+	AD7380_OFFLOAD_CHANNEL(4, bits, diff, sign),	\
+	AD7380_OFFLOAD_CHANNEL(5, bits, diff, sign),	\
+	AD7380_OFFLOAD_CHANNEL(6, bits, diff, sign),	\
+	AD7380_OFFLOAD_CHANNEL(7, bits, diff, sign),	\
 }
 
 /* fully differential */
@@ -303,6 +476,28 @@ DEFINE_AD7380_8_CHANNEL(ad7386_4_channels, 16, 0, u);
 DEFINE_AD7380_8_CHANNEL(ad7387_4_channels, 14, 0, u);
 DEFINE_AD7380_8_CHANNEL(ad7388_4_channels, 12, 0, u);
 
+/* offload channels */
+DEFINE_AD7380_2_OFFLOAD_CHANNEL(ad7380_offload_channels, 16, 1, s);
+DEFINE_AD7380_2_OFFLOAD_CHANNEL(ad7381_offload_channels, 14, 1, s);
+DEFINE_AD7380_4_OFFLOAD_CHANNEL(ad7380_4_offload_channels, 16, 1, s);
+DEFINE_AD7380_4_OFFLOAD_CHANNEL(ad7381_4_offload_channels, 14, 1, s);
+DEFINE_ADAQ4380_4_OFFLOAD_CHANNEL(adaq4380_4_offload_channels, 16, 1, s);
+DEFINE_ADAQ4380_4_OFFLOAD_CHANNEL(adaq4381_4_offload_channels, 14, 1, s);
+
+/* pseudo differential */
+DEFINE_AD7380_2_OFFLOAD_CHANNEL(ad7383_offload_channels, 16, 0, s);
+DEFINE_AD7380_2_OFFLOAD_CHANNEL(ad7384_offload_channels, 14, 0, s);
+DEFINE_AD7380_4_OFFLOAD_CHANNEL(ad7383_4_offload_channels, 16, 0, s);
+DEFINE_AD7380_4_OFFLOAD_CHANNEL(ad7384_4_offload_channels, 14, 0, s);
+
+/* Single ended */
+DEFINE_AD7380_4_OFFLOAD_CHANNEL(ad7386_offload_channels, 16, 0, u);
+DEFINE_AD7380_4_OFFLOAD_CHANNEL(ad7387_offload_channels, 14, 0, u);
+DEFINE_AD7380_4_OFFLOAD_CHANNEL(ad7388_offload_channels, 12, 0, u);
+DEFINE_AD7380_8_OFFLOAD_CHANNEL(ad7386_4_offload_channels, 16, 0, u);
+DEFINE_AD7380_8_OFFLOAD_CHANNEL(ad7387_4_offload_channels, 14, 0, u);
+DEFINE_AD7380_8_OFFLOAD_CHANNEL(ad7388_4_offload_channels, 12, 0, u);
+
 static const char * const ad7380_supplies[] = {
 	"vcc", "vlogic",
 };
@@ -409,28 +604,33 @@ static const int ad7380_gains[] = {
 static const struct ad7380_chip_info ad7380_chip_info = {
 	.name = "ad7380",
 	.channels = ad7380_channels,
+	.offload_channels = ad7380_offload_channels,
 	.num_channels = ARRAY_SIZE(ad7380_channels),
 	.num_simult_channels = 2,
 	.supplies = ad7380_supplies,
 	.num_supplies = ARRAY_SIZE(ad7380_supplies),
 	.available_scan_masks = ad7380_2_channel_scan_masks,
 	.timing_specs = &ad7380_timing,
+	.max_conversion_rate_hz = 4 * MEGA,
 };
 
 static const struct ad7380_chip_info ad7381_chip_info = {
 	.name = "ad7381",
 	.channels = ad7381_channels,
+	.offload_channels = ad7381_offload_channels,
 	.num_channels = ARRAY_SIZE(ad7381_channels),
 	.num_simult_channels = 2,
 	.supplies = ad7380_supplies,
 	.num_supplies = ARRAY_SIZE(ad7380_supplies),
 	.available_scan_masks = ad7380_2_channel_scan_masks,
 	.timing_specs = &ad7380_timing,
+	.max_conversion_rate_hz = 4 * MEGA,
 };
 
 static const struct ad7380_chip_info ad7383_chip_info = {
 	.name = "ad7383",
 	.channels = ad7383_channels,
+	.offload_channels = ad7383_offload_channels,
 	.num_channels = ARRAY_SIZE(ad7383_channels),
 	.num_simult_channels = 2,
 	.supplies = ad7380_supplies,
@@ -439,11 +639,13 @@ static const struct ad7380_chip_info ad7383_chip_info = {
 	.num_vcm_supplies = ARRAY_SIZE(ad7380_2_channel_vcm_supplies),
 	.available_scan_masks = ad7380_2_channel_scan_masks,
 	.timing_specs = &ad7380_timing,
+	.max_conversion_rate_hz = 4 * MEGA,
 };
 
 static const struct ad7380_chip_info ad7384_chip_info = {
 	.name = "ad7384",
 	.channels = ad7384_channels,
+	.offload_channels = ad7384_offload_channels,
 	.num_channels = ARRAY_SIZE(ad7384_channels),
 	.num_simult_channels = 2,
 	.supplies = ad7380_supplies,
@@ -452,11 +654,13 @@ static const struct ad7380_chip_info ad7384_chip_info = {
 	.num_vcm_supplies = ARRAY_SIZE(ad7380_2_channel_vcm_supplies),
 	.available_scan_masks = ad7380_2_channel_scan_masks,
 	.timing_specs = &ad7380_timing,
+	.max_conversion_rate_hz = 4 * MEGA,
 };
 
 static const struct ad7380_chip_info ad7386_chip_info = {
 	.name = "ad7386",
 	.channels = ad7386_channels,
+	.offload_channels = ad7386_offload_channels,
 	.num_channels = ARRAY_SIZE(ad7386_channels),
 	.num_simult_channels = 2,
 	.supplies = ad7380_supplies,
@@ -464,11 +668,13 @@ static const struct ad7380_chip_info ad7386_chip_info = {
 	.has_mux = true,
 	.available_scan_masks = ad7380_2x2_channel_scan_masks,
 	.timing_specs = &ad7380_timing,
+	.max_conversion_rate_hz = 4 * MEGA,
 };
 
 static const struct ad7380_chip_info ad7387_chip_info = {
 	.name = "ad7387",
 	.channels = ad7387_channels,
+	.offload_channels = ad7387_offload_channels,
 	.num_channels = ARRAY_SIZE(ad7387_channels),
 	.num_simult_channels = 2,
 	.supplies = ad7380_supplies,
@@ -476,11 +682,13 @@ static const struct ad7380_chip_info ad7387_chip_info = {
 	.has_mux = true,
 	.available_scan_masks = ad7380_2x2_channel_scan_masks,
 	.timing_specs = &ad7380_timing,
+	.max_conversion_rate_hz = 4 * MEGA,
 };
 
 static const struct ad7380_chip_info ad7388_chip_info = {
 	.name = "ad7388",
 	.channels = ad7388_channels,
+	.offload_channels = ad7388_offload_channels,
 	.num_channels = ARRAY_SIZE(ad7388_channels),
 	.num_simult_channels = 2,
 	.supplies = ad7380_supplies,
@@ -488,11 +696,13 @@ static const struct ad7380_chip_info ad7388_chip_info = {
 	.has_mux = true,
 	.available_scan_masks = ad7380_2x2_channel_scan_masks,
 	.timing_specs = &ad7380_timing,
+	.max_conversion_rate_hz = 4 * MEGA,
 };
 
 static const struct ad7380_chip_info ad7380_4_chip_info = {
 	.name = "ad7380-4",
 	.channels = ad7380_4_channels,
+	.offload_channels = ad7380_4_offload_channels,
 	.num_channels = ARRAY_SIZE(ad7380_4_channels),
 	.num_simult_channels = 4,
 	.supplies = ad7380_supplies,
@@ -500,22 +710,26 @@ static const struct ad7380_chip_info ad7380_4_chip_info = {
 	.external_ref_only = true,
 	.available_scan_masks = ad7380_4_channel_scan_masks,
 	.timing_specs = &ad7380_4_timing,
+	.max_conversion_rate_hz = 4 * MEGA,
 };
 
 static const struct ad7380_chip_info ad7381_4_chip_info = {
 	.name = "ad7381-4",
 	.channels = ad7381_4_channels,
+	.offload_channels = ad7381_4_offload_channels,
 	.num_channels = ARRAY_SIZE(ad7381_4_channels),
 	.num_simult_channels = 4,
 	.supplies = ad7380_supplies,
 	.num_supplies = ARRAY_SIZE(ad7380_supplies),
 	.available_scan_masks = ad7380_4_channel_scan_masks,
 	.timing_specs = &ad7380_4_timing,
+	.max_conversion_rate_hz = 4 * MEGA,
 };
 
 static const struct ad7380_chip_info ad7383_4_chip_info = {
 	.name = "ad7383-4",
 	.channels = ad7383_4_channels,
+	.offload_channels = ad7383_4_offload_channels,
 	.num_channels = ARRAY_SIZE(ad7383_4_channels),
 	.num_simult_channels = 4,
 	.supplies = ad7380_supplies,
@@ -524,11 +738,13 @@ static const struct ad7380_chip_info ad7383_4_chip_info = {
 	.num_vcm_supplies = ARRAY_SIZE(ad7380_4_channel_vcm_supplies),
 	.available_scan_masks = ad7380_4_channel_scan_masks,
 	.timing_specs = &ad7380_4_timing,
+	.max_conversion_rate_hz = 4 * MEGA,
 };
 
 static const struct ad7380_chip_info ad7384_4_chip_info = {
 	.name = "ad7384-4",
 	.channels = ad7384_4_channels,
+	.offload_channels = ad7384_4_offload_channels,
 	.num_channels = ARRAY_SIZE(ad7384_4_channels),
 	.num_simult_channels = 4,
 	.supplies = ad7380_supplies,
@@ -537,11 +753,13 @@ static const struct ad7380_chip_info ad7384_4_chip_info = {
 	.num_vcm_supplies = ARRAY_SIZE(ad7380_4_channel_vcm_supplies),
 	.available_scan_masks = ad7380_4_channel_scan_masks,
 	.timing_specs = &ad7380_4_timing,
+	.max_conversion_rate_hz = 4 * MEGA,
 };
 
 static const struct ad7380_chip_info ad7386_4_chip_info = {
 	.name = "ad7386-4",
 	.channels = ad7386_4_channels,
+	.offload_channels = ad7386_4_offload_channels,
 	.num_channels = ARRAY_SIZE(ad7386_4_channels),
 	.num_simult_channels = 4,
 	.supplies = ad7380_supplies,
@@ -549,11 +767,13 @@ static const struct ad7380_chip_info ad7386_4_chip_info = {
 	.has_mux = true,
 	.available_scan_masks = ad7380_2x4_channel_scan_masks,
 	.timing_specs = &ad7380_4_timing,
+	.max_conversion_rate_hz = 4 * MEGA,
 };
 
 static const struct ad7380_chip_info ad7387_4_chip_info = {
 	.name = "ad7387-4",
 	.channels = ad7387_4_channels,
+	.offload_channels = ad7387_4_offload_channels,
 	.num_channels = ARRAY_SIZE(ad7387_4_channels),
 	.num_simult_channels = 4,
 	.supplies = ad7380_supplies,
@@ -561,11 +781,13 @@ static const struct ad7380_chip_info ad7387_4_chip_info = {
 	.has_mux = true,
 	.available_scan_masks = ad7380_2x4_channel_scan_masks,
 	.timing_specs = &ad7380_4_timing,
+	.max_conversion_rate_hz = 4 * MEGA,
 };
 
 static const struct ad7380_chip_info ad7388_4_chip_info = {
 	.name = "ad7388-4",
 	.channels = ad7388_4_channels,
+	.offload_channels = ad7388_4_offload_channels,
 	.num_channels = ARRAY_SIZE(ad7388_4_channels),
 	.num_simult_channels = 4,
 	.supplies = ad7380_supplies,
@@ -573,11 +795,13 @@ static const struct ad7380_chip_info ad7388_4_chip_info = {
 	.has_mux = true,
 	.available_scan_masks = ad7380_2x4_channel_scan_masks,
 	.timing_specs = &ad7380_4_timing,
+	.max_conversion_rate_hz = 4 * MEGA,
 };
 
 static const struct ad7380_chip_info adaq4370_4_chip_info = {
 	.name = "adaq4370-4",
 	.channels = adaq4380_4_channels,
+	.offload_channels = adaq4380_4_offload_channels,
 	.num_channels = ARRAY_SIZE(adaq4380_4_channels),
 	.num_simult_channels = 4,
 	.supplies = adaq4380_supplies,
@@ -586,11 +810,13 @@ static const struct ad7380_chip_info adaq4370_4_chip_info = {
 	.has_hardware_gain = true,
 	.available_scan_masks = ad7380_4_channel_scan_masks,
 	.timing_specs = &ad7380_4_timing,
+	.max_conversion_rate_hz = 2 * MEGA,
 };
 
 static const struct ad7380_chip_info adaq4380_4_chip_info = {
 	.name = "adaq4380-4",
 	.channels = adaq4380_4_channels,
+	.offload_channels = adaq4380_4_offload_channels,
 	.num_channels = ARRAY_SIZE(adaq4380_4_channels),
 	.num_simult_channels = 4,
 	.supplies = adaq4380_supplies,
@@ -599,11 +825,13 @@ static const struct ad7380_chip_info adaq4380_4_chip_info = {
 	.has_hardware_gain = true,
 	.available_scan_masks = ad7380_4_channel_scan_masks,
 	.timing_specs = &ad7380_4_timing,
+	.max_conversion_rate_hz = 4 * MEGA,
 };
 
 static const struct ad7380_chip_info adaq4381_4_chip_info = {
 	.name = "adaq4381-4",
 	.channels = adaq4381_4_channels,
+	.offload_channels = adaq4381_4_offload_channels,
 	.num_channels = ARRAY_SIZE(adaq4381_4_channels),
 	.num_simult_channels = 4,
 	.supplies = adaq4380_supplies,
@@ -614,6 +842,11 @@ static const struct ad7380_chip_info adaq4381_4_chip_info = {
 	.timing_specs = &ad7380_4_timing,
 };
 
+static const struct spi_offload_config ad7380_offload_config = {
+	.capability_flags = SPI_OFFLOAD_CAP_TRIGGER |
+			    SPI_OFFLOAD_CAP_RX_STREAM_DMA,
+};
+
 struct ad7380_state {
 	const struct ad7380_chip_info *chip_info;
 	struct spi_device *spi;
@@ -629,6 +862,13 @@ struct ad7380_state {
 	struct spi_message normal_msg;
 	struct spi_transfer seq_xfer[4];
 	struct spi_message seq_msg;
+	struct spi_transfer offload_xfer;
+	struct spi_message offload_msg;
+	struct spi_offload *offload;
+	struct spi_offload_trigger *offload_trigger;
+	unsigned long offload_trigger_hz;
+
+	int sample_freq_range[3];
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
 	 * to live in their own cache lines.
@@ -848,7 +1088,7 @@ static int ad7380_update_xfers(struct ad7380_state *st,
 		xfer[2].bits_per_word = xfer[3].bits_per_word =
 			scan_type->realbits;
 		xfer[2].len = xfer[3].len =
-			BITS_TO_BYTES(scan_type->storagebits) *
+			AD7380_SPI_BYTES(scan_type) *
 			st->chip_info->num_simult_channels;
 		xfer[3].rx_buf = xfer[2].rx_buf + xfer[2].len;
 		/* Additional delay required here when oversampling is enabled */
@@ -861,13 +1101,139 @@ static int ad7380_update_xfers(struct ad7380_state *st,
 		xfer[0].delay.value = t_convert;
 		xfer[0].delay.unit = SPI_DELAY_UNIT_NSECS;
 		xfer[1].bits_per_word = scan_type->realbits;
-		xfer[1].len = BITS_TO_BYTES(scan_type->storagebits) *
+		xfer[1].len = AD7380_SPI_BYTES(scan_type) *
 			st->chip_info->num_simult_channels;
 	}
 
 	return 0;
 }
 
+static int ad7380_set_sample_freq(struct ad7380_state *st, int val)
+{
+	struct spi_offload_trigger_config config = {
+		.type = SPI_OFFLOAD_TRIGGER_PERIODIC,
+		.periodic = {
+			.frequency_hz = val,
+		},
+	};
+	int ret;
+
+	ret = spi_offload_trigger_validate(st->offload_trigger, &config);
+	if (ret)
+		return ret;
+
+	st->offload_trigger_hz = config.periodic.frequency_hz;
+
+	return 0;
+}
+
+static int ad7380_init_offload_msg(struct ad7380_state *st,
+				   struct iio_dev *indio_dev)
+{
+	struct spi_transfer *xfer = &st->offload_xfer;
+	struct device *dev = &st->spi->dev;
+	const struct iio_scan_type *scan_type;
+	int oversampling_ratio;
+	int ret;
+
+	scan_type = iio_get_current_scan_type(indio_dev,
+					      &indio_dev->channels[0]);
+	if (IS_ERR(scan_type))
+		return PTR_ERR(scan_type);
+
+	if (st->chip_info->has_mux) {
+		int index;
+
+		ret = iio_active_scan_mask_index(indio_dev);
+		if (ret < 0)
+			return ret;
+
+		index = ret;
+		if (index == AD7380_SCAN_MASK_SEQ) {
+			ret = regmap_set_bits(st->regmap, AD7380_REG_ADDR_CONFIG1,
+					      AD7380_CONFIG1_SEQ);
+			if (ret)
+				return ret;
+
+			st->seq = true;
+		} else {
+			ret = ad7380_set_ch(st, index);
+			if (ret)
+				return ret;
+		}
+	}
+
+	ret = ad7380_get_osr(st, &oversampling_ratio);
+	if (ret)
+		return ret;
+
+	xfer->bits_per_word = scan_type->realbits;
+	xfer->offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+	xfer->len = AD7380_SPI_BYTES(scan_type) * st->chip_info->num_simult_channels;
+
+	spi_message_init_with_transfers(&st->offload_msg, xfer, 1);
+	st->offload_msg.offload = st->offload;
+
+	ret = spi_optimize_message(st->spi, &st->offload_msg);
+	if (ret) {
+		dev_err(dev, "failed to prepare offload msg, err: %d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ad7380_offload_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad7380_state *st = iio_priv(indio_dev);
+	struct spi_offload_trigger_config config = {
+		.type = SPI_OFFLOAD_TRIGGER_PERIODIC,
+		.periodic = {
+			.frequency_hz = st->offload_trigger_hz,
+		},
+	};
+	int ret;
+
+	ret = ad7380_init_offload_msg(st, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger, &config);
+	if (ret)
+		spi_unoptimize_message(&st->offload_msg);
+
+	return ret;
+}
+
+static int ad7380_offload_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad7380_state *st = iio_priv(indio_dev);
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
+		st->seq = false;
+	}
+
+	spi_offload_trigger_disable(st->offload, st->offload_trigger);
+
+	spi_unoptimize_message(&st->offload_msg);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ad7380_offload_buffer_setup_ops = {
+	.postenable = ad7380_offload_buffer_postenable,
+	.predisable = ad7380_offload_buffer_predisable,
+};
+
 static int ad7380_triggered_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct ad7380_state *st = iio_priv(indio_dev);
@@ -998,7 +1364,7 @@ static int ad7380_read_direct(struct ad7380_state *st, unsigned int scan_index,
 	if (ret < 0)
 		return ret;
 
-	if (scan_type->storagebits > 16) {
+	if (scan_type->realbits > 16) {
 		if (scan_type->sign == 's')
 			*val = sign_extend32(*(u32 *)(st->scan_data + 4 * index),
 					     scan_type->realbits - 1);
@@ -1079,6 +1445,9 @@ static int ad7380_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = st->offload_trigger_hz;
 		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
@@ -1090,6 +1459,8 @@ static int ad7380_read_avail(struct iio_dev *indio_dev,
 			     const int **vals, int *type, int *length,
 			     long mask)
 {
+	struct ad7380_state *st = iio_priv(indio_dev);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		*vals = ad7380_oversampling_ratios;
@@ -1097,6 +1468,10 @@ static int ad7380_read_avail(struct iio_dev *indio_dev,
 		*type = IIO_VAL_INT;
 
 		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = st->sample_freq_range;
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_RANGE;
 	default:
 		return -EINVAL;
 	}
@@ -1166,6 +1541,10 @@ static int ad7380_write_raw(struct iio_dev *indio_dev,
 	int ret;
 
 	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val < 1)
+			return -EINVAL;
+		return ad7380_set_sample_freq(st, val);
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		if (!iio_device_claim_direct(indio_dev))
 			return -EBUSY;
@@ -1395,6 +1774,53 @@ static int ad7380_init(struct ad7380_state *st, bool external_ref_en)
 					     AD7380_NUM_SDO_LINES));
 }
 
+static int ad7380_probe_spi_offload(struct iio_dev *indio_dev,
+				    struct ad7380_state *st)
+{
+	struct spi_device *spi = st->spi;
+	struct device *dev = &spi->dev;
+	struct dma_chan *rx_dma;
+	int sample_rate, ret;
+
+	indio_dev->setup_ops = &ad7380_offload_buffer_setup_ops;
+	indio_dev->channels = st->chip_info->offload_channels;
+	/* Just removing the timestamp channel. */
+	indio_dev->num_channels--;
+
+	st->offload_trigger = devm_spi_offload_trigger_get(dev, st->offload,
+		SPI_OFFLOAD_TRIGGER_PERIODIC);
+	if (IS_ERR(st->offload_trigger))
+		return dev_err_probe(dev, PTR_ERR(st->offload_trigger),
+				     "failed to get offload trigger\n");
+
+	sample_rate = st->chip_info->max_conversion_rate_hz *
+		      AD7380_NUM_SDO_LINES / st->chip_info->num_simult_channels;
+
+	st->sample_freq_range[0] = 1; /* min */
+	st->sample_freq_range[1] = 1; /* step */
+	st->sample_freq_range[2] = sample_rate; /* max */
+
+	/*
+	 * Starting with a quite low frequency, to allow oversampling x32,
+	 * user is then reponsible to adjust the frequency for the specific case.
+	 */
+	ret = ad7380_set_sample_freq(st, sample_rate / 32);
+	if (ret)
+		return ret;
+
+	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev, st->offload);
+	if (IS_ERR(rx_dma))
+		return dev_err_probe(dev, PTR_ERR(rx_dma),
+				     "failed to get offload RX DMA\n");
+
+	ret = devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev,
+		rx_dma, IIO_BUFFER_DIRECTION_IN);
+	if (ret)
+		return dev_err_probe(dev, ret, "cannot setup dma buffer\n");
+
+	return 0;
+}
+
 static int ad7380_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
@@ -1566,12 +1992,24 @@ static int ad7380_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->available_scan_masks = st->chip_info->available_scan_masks;
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
-					      iio_pollfunc_store_time,
-					      ad7380_trigger_handler,
-					      &ad7380_buffer_setup_ops);
-	if (ret)
-		return ret;
+	st->offload = devm_spi_offload_get(dev, spi, &ad7380_offload_config);
+	ret = PTR_ERR_OR_ZERO(st->offload);
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "failed to get offload\n");
+
+	/* If no SPI offload, fall back to low speed usage. */
+	if (ret == -ENODEV) {
+		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+						      iio_pollfunc_store_time,
+						      ad7380_trigger_handler,
+						      &ad7380_buffer_setup_ops);
+		if (ret)
+			return ret;
+	} else {
+		ret = ad7380_probe_spi_offload(indio_dev, st);
+		if (ret)
+			return ret;
+	}
 
 	ret = ad7380_init(st, external_ref_en);
 	if (ret)
@@ -1636,3 +2074,4 @@ module_spi_driver(ad7380_driver);
 MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD738x ADC driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");

-- 
2.48.1


