Return-Path: <linux-iio+bounces-8085-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AF1942779
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 09:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F7551C22B79
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2024 07:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745EA1A76D5;
	Wed, 31 Jul 2024 07:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ON43Mv3f"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5C61A71EE
	for <linux-iio@vger.kernel.org>; Wed, 31 Jul 2024 07:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722409560; cv=none; b=aLBp2qqTZLta/bf5imSiF74KzbNQXp0z7UyTmoOCzBseNyYzt5Y4ZqVXOhwIATIcYHYPHQXYfUYKP+pxxZ11aR7U/+aqjbin5FRj3Ey9fXiFRpC/iCUxUgVeUJ/ZBdwhNRVH6C3r5Ny5ITl2L2vZrqHXDpjwhjr9z97+IdA5NTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722409560; c=relaxed/simple;
	bh=N+VAsoVMf0kYaOmZRtqmOTy82UerzihLlHhBrWb2ieY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oFpUyLEq3NgAA5kJZwGL8Xf++WFDnh1QKibJ8wJ4dQmIj10WxeTnPSOuQC8dR6quALEapGnkWAcoEaXYhV2G9TX5+B7AUcsstrmZyfmb1LNw61RLngAv5mpSDux+rRZeSYAob5m+0NCcWuUTjALLBwNQRheQ+//mJU22h8jSDPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ON43Mv3f; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-428035c0bb2so3128005e9.1
        for <linux-iio@vger.kernel.org>; Wed, 31 Jul 2024 00:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722409555; x=1723014355; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b3bgQ57CHVc0q9CRE3lnl6yM7nPtiuF3hPunbjRQ+tE=;
        b=ON43Mv3fL0GsOgYV4nI8MiB8r1g8KgNvd/Rn3Ew3q70xFLVPkqduK9BK59BfrRUOy/
         T96PQEn7yXOTopOCdaVNLO4GtkFG5xQmwIlnM/3gXcmyldiGEbhsGDCza8lFibdReUFS
         XgLU3QbAwY95TsPB4ZMUULgN57Zs9gC16vav2YjHtiuk9KQQrdmWo0NDKBWCqjN73/7J
         Pz2yeVVAh7An1CT2JzHqizqVMt1+vZk3SljGNM9mA+9ZFFl3g29zHuET+3WMLOvGoveI
         0zqRJe0q4qVGllbpJiBVozD2QFHXXQs7IT+ZdgIRONa9I3kk9p0d+Qzoq3iFeKY6U6Y0
         ZMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722409555; x=1723014355;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3bgQ57CHVc0q9CRE3lnl6yM7nPtiuF3hPunbjRQ+tE=;
        b=kahB/KTLmi1hBHcBTSMT7HkBzL+14mY+NvyUjhTC2+X0oGmGVip5QEX0cuq7C+EqJh
         8dhKEgCLaErpERjCOd4ItuGUvMMgvyfPxJ1MKi+M7OV5wrQWyPY27wV7XAZczynie0Ca
         FTc4Kmif5bAq+xw6dqK+bWz6TSqx1Q9sDzF2urt194WcyKj6qefv0Erld/FEttuzx014
         PL3k6laAkhP1VIx5M/jcwTeSesz6FNT3kyoeqm28gDBrh4urG2lW6q0xN4Lq04nMplkp
         YRXU6G0pBuvX16Pyx53nwhLeoQKDtvuNjV+wQHSCPsWu906os/vmVYFNo1T8BCkAyXfN
         E9lA==
X-Forwarded-Encrypted: i=1; AJvYcCVmemlde6iLmFet1C/mDUkt8WvB4jby5NdHkN4z+hdXzZ0ZpOdPN0XhIN8IkQ8nx4BDoIUBx9/NrMuQDJBlo0+DfDuR17qffjl7
X-Gm-Message-State: AOJu0Yz0tJhZPVRXpDSZPqFIJdmWu7vySLjPyfVs4a+EsUIn0RjQOLyy
	QmcZRrEZxiZRrn14zjqfG6CsElEX9297hRJa7ceToyqN4MjfUTRW1kDi8kGuZ1Y=
X-Google-Smtp-Source: AGHT+IHaNgJ9qJUDwpfCS2bmF3oSur6kZVjB8NRZNOTRFu6mqp0yrMIwSz+MHZqNTQXGtQuHInyg3Q==
X-Received: by 2002:a05:6000:d01:b0:362:4679:b5a with SMTP id ffacd0b85a97d-36b8c8e99ebmr2991645f8f.16.1722409554646;
        Wed, 31 Jul 2024 00:05:54 -0700 (PDT)
Received: from [192.168.1.61] (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net. [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b8a2593sm9953215e9.4.2024.07.31.00.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 00:05:54 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 31 Jul 2024 09:05:46 +0200
Subject: [PATCH v2 5/7] iio: adc: ad7380: add support for single-ended
 parts
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-ad7380-add-single-ended-chips-v2-5-cd63bf05744c@baylibre.com>
References: <20240731-ad7380-add-single-ended-chips-v2-0-cd63bf05744c@baylibre.com>
In-Reply-To: <20240731-ad7380-add-single-ended-chips-v2-0-cd63bf05744c@baylibre.com>
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

Adding ad7386/7/8 (16/14/12 bits) unsigned, dual simultaneous sampling,
single-ended compatible parts, and the corresponding ad7386-4/7-4/8-4
4 channels.

These parts have a 2:1 multiplexer in front of each ADC. They also include
additional configuration registers that allow for either manual selection
or automatic switching (sequencer mode), of the multiplexer inputs.
This commit focus on integrating manual selection. Sequencer mode will
be implemented later.

From an IIO point of view, all inputs are exported, i.e ad7386/7/8
export 4 channels and ad7386-4/7-4/8-4 export 8 channels.

Inputs AinX0 of multiplexers correspond to the first half of IIO channels
(i.e 0-1 or 0-3) and inputs AinX1 correspond to second half (i.e 2-3 or
4-7). Example for AD7386/7/8 (2 channels parts):

          IIO   | AD7386/7/8
                |         +----------------------------
                |         |     _____        ______
                |         |    |     |      |      |
       voltage0 | AinA0 --|--->|     |      |      |
                |         |    | mux |----->| ADCA |---
       voltage2 | AinA1 --|--->|     |      |      |
                |         |    |_____|      |_____ |
                |         |     _____        ______
                |         |    |     |      |      |
       voltage1 | AinB0 --|--->|     |      |      |
                |         |    | mux |----->| ADCB |---
       voltage3 | AinB1 --|--->|     |      |      |
                |         |    |_____|      |______|
                |         |
                |         +----------------------------

When switching channel, the ADC require an additional settling time.
According to the datasheet, data is valid on the third CS low. We already
have an extra toggle before each read (either direct reads or buffered
reads) to sample correct data, so we just add a single CS toggle at the
end of the register write.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 351 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 309 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index 04cc1ef18131..820df04b9eb2 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -8,9 +8,11 @@
  * Datasheets of supported parts:
  * ad7380/1 : https://www.analog.com/media/en/technical-documentation/data-sheets/AD7380-7381.pdf
  * ad7383/4 : https://www.analog.com/media/en/technical-documentation/data-sheets/ad7383-7384.pdf
+ * ad7386/7/8 : https://www.analog.com/media/en/technical-documentation/data-sheets/AD7386-7387-7388.pdf
  * ad7380-4 : https://www.analog.com/media/en/technical-documentation/data-sheets/ad7380-4.pdf
  * ad7381-4 : https://www.analog.com/media/en/technical-documentation/data-sheets/ad7381-4.pdf
  * ad7383/4-4 : https://www.analog.com/media/en/technical-documentation/data-sheets/ad7383-4-ad7384-4.pdf
+ * ad7386/7/8-4 : https://www.analog.com/media/en/technical-documentation/data-sheets/ad7386-4-7387-4-7388-4.pdf
  */
 
 #include <linux/align.h>
@@ -49,6 +51,7 @@
 #define AD7380_REG_ADDR_ALERT_LOW_TH	0x4
 #define AD7380_REG_ADDR_ALERT_HIGH_TH	0x5
 
+#define AD7380_CONFIG1_CH		BIT(11)
 #define AD7380_CONFIG1_OS_MODE		BIT(9)
 #define AD7380_CONFIG1_OSR		GENMASK(8, 6)
 #define AD7380_CONFIG1_CRC_W		BIT(5)
@@ -81,6 +84,7 @@ struct ad7380_chip_info {
 	const struct iio_chan_spec *channels;
 	unsigned int num_channels;
 	unsigned int num_simult_channels;
+	bool has_mux;
 	const char * const *vcm_supplies;
 	unsigned int num_vcm_supplies;
 	const unsigned long *available_scan_masks;
@@ -92,8 +96,24 @@ enum {
 	AD7380_SCAN_TYPE_RESOLUTION_BOOST,
 };
 
-/* Extended scan types for 14-bit chips. */
-static const struct iio_scan_type ad7380_scan_type_14[] = {
+/* Extended scan types for 12-bit unsigned chips. */
+static const struct iio_scan_type ad7380_scan_type_12_u[] = {
+	[AD7380_SCAN_TYPE_NORMAL] = {
+		.sign = 'u',
+		.realbits = 12,
+		.storagebits = 16,
+		.endianness = IIO_CPU,
+	},
+	[AD7380_SCAN_TYPE_RESOLUTION_BOOST] = {
+		.sign = 'u',
+		.realbits = 14,
+		.storagebits = 16,
+		.endianness = IIO_CPU,
+	},
+};
+
+/* Extended scan types for 14-bit signed chips. */
+static const struct iio_scan_type ad7380_scan_type_14_s[] = {
 	[AD7380_SCAN_TYPE_NORMAL] = {
 		.sign = 's',
 		.realbits = 14,
@@ -108,8 +128,24 @@ static const struct iio_scan_type ad7380_scan_type_14[] = {
 	},
 };
 
-/* Extended scan types for 16-bit chips. */
-static const struct iio_scan_type ad7380_scan_type_16[] = {
+/* Extended scan types for 14-bit unsigned chips. */
+static const struct iio_scan_type ad7380_scan_type_14_u[] = {
+	[AD7380_SCAN_TYPE_NORMAL] = {
+		.sign = 'u',
+		.realbits = 14,
+		.storagebits = 16,
+		.endianness = IIO_CPU,
+	},
+	[AD7380_SCAN_TYPE_RESOLUTION_BOOST] = {
+		.sign = 'u',
+		.realbits = 16,
+		.storagebits = 16,
+		.endianness = IIO_CPU,
+	},
+};
+
+/* Extended scan types for 16-bit signed_chips. */
+static const struct iio_scan_type ad7380_scan_type_16_s[] = {
 	[AD7380_SCAN_TYPE_NORMAL] = {
 		.sign = 's',
 		.realbits = 16,
@@ -124,50 +160,87 @@ static const struct iio_scan_type ad7380_scan_type_16[] = {
 	},
 };
 
-#define AD7380_CHANNEL(index, bits, diff) {			\
-	.type = IIO_VOLTAGE,					\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
-		((diff) ? 0 : BIT(IIO_CHAN_INFO_OFFSET)),	\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
-		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
-	.info_mask_shared_by_type_available =			\
-		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
-	.indexed = 1,						\
-	.differential = (diff),					\
-	.channel = (diff) ? (2 * (index)) : (index),		\
-	.channel2 = (diff) ? (2 * (index) + 1) : 0,		\
-	.scan_index = (index),					\
-	.has_ext_scan_type = 1,					\
-	.ext_scan_type = ad7380_scan_type_##bits,		\
-	.num_ext_scan_type = ARRAY_SIZE(ad7380_scan_type_##bits),\
+/* Extended scan types for 16-bit unsigned chips. */
+static const struct iio_scan_type ad7380_scan_type_16_u[] = {
+	[AD7380_SCAN_TYPE_NORMAL] = {
+		.sign = 'u',
+		.realbits = 16,
+		.storagebits = 16,
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
+#define AD7380_CHANNEL(index, bits, diff, sign) {				\
+	.type = IIO_VOLTAGE,							\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |				\
+		((diff) ? 0 : BIT(IIO_CHAN_INFO_OFFSET)),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |			\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),				\
+	.info_mask_shared_by_type_available =					\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),				\
+	.indexed = 1,								\
+	.differential = (diff),							\
+	.channel = (diff) ? (2 * (index)) : (index),				\
+	.channel2 = (diff) ? (2 * (index) + 1) : 0,				\
+	.scan_index = (index),							\
+	.has_ext_scan_type = 1,							\
+	.ext_scan_type = ad7380_scan_type_##bits##_##sign,			\
+	.num_ext_scan_type = ARRAY_SIZE(ad7380_scan_type_##bits##_##sign),	\
 }
 
-#define DEFINE_AD7380_2_CHANNEL(name, bits, diff)	\
+#define DEFINE_AD7380_2_CHANNEL(name, bits, diff, sign)	\
 static const struct iio_chan_spec name[] = {		\
-	AD7380_CHANNEL(0, bits, diff),			\
-	AD7380_CHANNEL(1, bits, diff),			\
+	AD7380_CHANNEL(0, bits, diff, sign),		\
+	AD7380_CHANNEL(1, bits, diff, sign),		\
 	IIO_CHAN_SOFT_TIMESTAMP(2),			\
 }
 
-#define DEFINE_AD7380_4_CHANNEL(name, bits, diff)	\
+#define DEFINE_AD7380_4_CHANNEL(name, bits, diff, sign)	\
 static const struct iio_chan_spec name[] = {		\
-	AD7380_CHANNEL(0, bits, diff),			\
-	AD7380_CHANNEL(1, bits, diff),			\
-	AD7380_CHANNEL(2, bits, diff),			\
-	AD7380_CHANNEL(3, bits, diff),			\
+	AD7380_CHANNEL(0, bits, diff, sign),		\
+	AD7380_CHANNEL(1, bits, diff, sign),		\
+	AD7380_CHANNEL(2, bits, diff, sign),		\
+	AD7380_CHANNEL(3, bits, diff, sign),		\
 	IIO_CHAN_SOFT_TIMESTAMP(4),			\
 }
 
+#define DEFINE_AD7380_8_CHANNEL(name, bits, diff, sign)	\
+static const struct iio_chan_spec name[] = {		\
+	AD7380_CHANNEL(0, bits, diff, sign),		\
+	AD7380_CHANNEL(1, bits, diff, sign),		\
+	AD7380_CHANNEL(2, bits, diff, sign),		\
+	AD7380_CHANNEL(3, bits, diff, sign),		\
+	AD7380_CHANNEL(4, bits, diff, sign),		\
+	AD7380_CHANNEL(5, bits, diff, sign),		\
+	AD7380_CHANNEL(6, bits, diff, sign),		\
+	AD7380_CHANNEL(7, bits, diff, sign),		\
+	IIO_CHAN_SOFT_TIMESTAMP(8),			\
+}
+
 /* fully differential */
-DEFINE_AD7380_2_CHANNEL(ad7380_channels, 16, 1);
-DEFINE_AD7380_2_CHANNEL(ad7381_channels, 14, 1);
-DEFINE_AD7380_4_CHANNEL(ad7380_4_channels, 16, 1);
-DEFINE_AD7380_4_CHANNEL(ad7381_4_channels, 14, 1);
+DEFINE_AD7380_2_CHANNEL(ad7380_channels, 16, 1, s);
+DEFINE_AD7380_2_CHANNEL(ad7381_channels, 14, 1, s);
+DEFINE_AD7380_4_CHANNEL(ad7380_4_channels, 16, 1, s);
+DEFINE_AD7380_4_CHANNEL(ad7381_4_channels, 14, 1, s);
 /* pseudo differential */
-DEFINE_AD7380_2_CHANNEL(ad7383_channels, 16, 0);
-DEFINE_AD7380_2_CHANNEL(ad7384_channels, 14, 0);
-DEFINE_AD7380_4_CHANNEL(ad7383_4_channels, 16, 0);
-DEFINE_AD7380_4_CHANNEL(ad7384_4_channels, 14, 0);
+DEFINE_AD7380_2_CHANNEL(ad7383_channels, 16, 0, s);
+DEFINE_AD7380_2_CHANNEL(ad7384_channels, 14, 0, s);
+DEFINE_AD7380_4_CHANNEL(ad7383_4_channels, 16, 0, s);
+DEFINE_AD7380_4_CHANNEL(ad7384_4_channels, 14, 0, s);
+
+/* Single ended */
+DEFINE_AD7380_4_CHANNEL(ad7386_channels, 16, 0, u);
+DEFINE_AD7380_4_CHANNEL(ad7387_channels, 14, 0, u);
+DEFINE_AD7380_4_CHANNEL(ad7388_channels, 12, 0, u);
+DEFINE_AD7380_8_CHANNEL(ad7386_4_channels, 16, 0, u);
+DEFINE_AD7380_8_CHANNEL(ad7387_4_channels, 14, 0, u);
+DEFINE_AD7380_8_CHANNEL(ad7388_4_channels, 12, 0, u);
 
 static const char * const ad7380_2_channel_vcm_supplies[] = {
 	"aina", "ainb",
@@ -188,6 +261,48 @@ static const unsigned long ad7380_4_channel_scan_masks[] = {
 	0
 };
 
+/*
+ * Single ended parts have a 2:1 multiplexer in front of each ADC.
+ *
+ * From an IIO point of view, all inputs are exported, i.e ad7386/7/8
+ * export 4 channels and ad7386-4/7-4/8-4 export 8 channels.
+ *
+ * Inputs AinX0 of multiplexers correspond to the first half of IIO channels
+ * (i.e 0-1 or 0-3) and inputs AinX1 correspond to second half (i.e 2-3 or
+ * 4-7). Example for AD7386/7/8 (2 channels parts):
+ *
+ *           IIO   | AD7386/7/8
+ *                 |         +----------------------------
+ *                 |         |     _____        ______
+ *                 |         |    |     |      |      |
+ *        voltage0 | AinA0 --|--->|     |      |      |
+ *                 |         |    | mux |----->| ADCA |---
+ *        voltage2 | AinA1 --|--->|     |      |      |
+ *                 |         |    |_____|      |_____ |
+ *                 |         |     _____        ______
+ *                 |         |    |     |      |      |
+ *        voltage1 | AinB0 --|--->|     |      |      |
+ *                 |         |    | mux |----->| ADCB |---
+ *        voltage3 | AinB1 --|--->|     |      |      |
+ *                 |         |    |_____|      |______|
+ *                 |         |
+ *                 |         +----------------------------
+ *
+ * Since this is simultaneous sampling for AinX0 OR AinX1 we have two separate
+ * scan masks.
+ */
+static const unsigned long ad7380_2x2_channel_scan_masks[] = {
+	GENMASK(1, 0),
+	GENMASK(3, 2),
+	0
+};
+
+static const unsigned long ad7380_2x4_channel_scan_masks[] = {
+	GENMASK(3, 0),
+	GENMASK(7, 4),
+	0
+};
+
 static const struct ad7380_timing_specs ad7380_timing = {
 	.t_csh_ns = 10,
 };
@@ -245,6 +360,36 @@ static const struct ad7380_chip_info ad7384_chip_info = {
 	.timing_specs = &ad7380_timing,
 };
 
+static const struct ad7380_chip_info ad7386_chip_info = {
+	.name = "ad7386",
+	.channels = ad7386_channels,
+	.num_channels = ARRAY_SIZE(ad7386_channels),
+	.num_simult_channels = 2,
+	.has_mux = true,
+	.available_scan_masks = ad7380_2x2_channel_scan_masks,
+	.timing_specs = &ad7380_timing,
+};
+
+static const struct ad7380_chip_info ad7387_chip_info = {
+	.name = "ad7387",
+	.channels = ad7387_channels,
+	.num_channels = ARRAY_SIZE(ad7387_channels),
+	.num_simult_channels = 2,
+	.has_mux = true,
+	.available_scan_masks = ad7380_2x2_channel_scan_masks,
+	.timing_specs = &ad7380_timing,
+};
+
+static const struct ad7380_chip_info ad7388_chip_info = {
+	.name = "ad7388",
+	.channels = ad7388_channels,
+	.num_channels = ARRAY_SIZE(ad7388_channels),
+	.num_simult_channels = 2,
+	.has_mux = true,
+	.available_scan_masks = ad7380_2x2_channel_scan_masks,
+	.timing_specs = &ad7380_timing,
+};
+
 static const struct ad7380_chip_info ad7380_4_chip_info = {
 	.name = "ad7380-4",
 	.channels = ad7380_4_channels,
@@ -285,12 +430,43 @@ static const struct ad7380_chip_info ad7384_4_chip_info = {
 	.timing_specs = &ad7380_4_timing,
 };
 
+static const struct ad7380_chip_info ad7386_4_chip_info = {
+	.name = "ad7386-4",
+	.channels = ad7386_4_channels,
+	.num_channels = ARRAY_SIZE(ad7386_4_channels),
+	.num_simult_channels = 4,
+	.has_mux = true,
+	.available_scan_masks = ad7380_2x4_channel_scan_masks,
+	.timing_specs = &ad7380_4_timing,
+};
+
+static const struct ad7380_chip_info ad7387_4_chip_info = {
+	.name = "ad7387-4",
+	.channels = ad7387_4_channels,
+	.num_channels = ARRAY_SIZE(ad7387_4_channels),
+	.num_simult_channels = 4,
+	.has_mux = true,
+	.available_scan_masks = ad7380_2x4_channel_scan_masks,
+	.timing_specs = &ad7380_4_timing,
+};
+
+static const struct ad7380_chip_info ad7388_4_chip_info = {
+	.name = "ad7388-4",
+	.channels = ad7388_4_channels,
+	.num_channels = ARRAY_SIZE(ad7388_4_channels),
+	.num_simult_channels = 4,
+	.has_mux = true,
+	.available_scan_masks = ad7380_2x4_channel_scan_masks,
+	.timing_specs = &ad7380_4_timing,
+};
+
 struct ad7380_state {
 	const struct ad7380_chip_info *chip_info;
 	struct spi_device *spi;
 	struct regmap *regmap;
 	unsigned int oversampling_ratio;
 	bool resolution_boost_enabled;
+	unsigned int ch;
 	unsigned int vref_mv;
 	unsigned int vcm_mv[MAX_NUM_CHANNELS];
 	/* xfers, message an buffer for reading sample data */
@@ -388,6 +564,43 @@ static int ad7380_debugfs_reg_access(struct iio_dev *indio_dev, u32 reg,
 	unreachable();
 }
 
+/*
+ * When switching channel, the ADC require an additional settling time.
+ * According to the datasheet, data is value on the third CS low. We already
+ * have an extra toggle before each read (either direct reads or buffered reads)
+ * to sample correct data, so we just add a single CS toggle at the end of the
+ * register write.
+ */
+static int ad7380_set_ch(struct ad7380_state *st, unsigned int ch)
+{
+	struct spi_transfer xfer = {
+		.delay = {
+			.value = T_CONVERT_NS,
+			.unit = SPI_DELAY_UNIT_NSECS,
+		}
+	};
+	int ret;
+
+	if (st->ch == ch)
+		return 0;
+
+	ret = regmap_update_bits(st->regmap,
+				 AD7380_REG_ADDR_CONFIG1,
+				 AD7380_CONFIG1_CH,
+				 FIELD_PREP(AD7380_CONFIG1_CH, ch));
+
+	if (ret)
+		return ret;
+
+	st->ch = ch;
+
+	if (st->oversampling_ratio > 1)
+		xfer.delay.value = T_CONVERT_0_NS +
+			T_CONVERT_X_NS * (st->oversampling_ratio - 1);
+
+	return spi_sync_transfer(st->spi, &xfer, 1);
+}
+
 /**
  * ad7380_update_xfers - update the SPI transfers base on the current scan type
  * @st:		device instance specific state
@@ -432,6 +645,24 @@ static int ad7380_triggered_buffer_preenable(struct iio_dev *indio_dev)
 	if (IS_ERR(scan_type))
 		return PTR_ERR(scan_type);
 
+	if (st->chip_info->has_mux) {
+		unsigned int index;
+		int ret;
+
+		/*
+		 * Depending on the requested scan_mask and current state,
+		 * we need to change CH bit to sample correct data.
+		 */
+		ret = iio_active_scan_mask_index(indio_dev);
+		if (ret < 0)
+			return ret;
+
+		index = ret;
+		ret = ad7380_set_ch(st, index);
+		if (ret)
+			return ret;
+	}
+
 	ad7380_update_xfers(st, scan_type);
 
 	return spi_optimize_message(st->spi, &st->msg);
@@ -474,20 +705,43 @@ static irqreturn_t ad7380_trigger_handler(int irq, void *p)
 static int ad7380_read_direct(struct ad7380_state *st, unsigned int scan_index,
 			      const struct iio_scan_type *scan_type, int *val)
 {
+	unsigned int index = scan_index;
 	int ret;
 
+	if (st->chip_info->has_mux) {
+		unsigned int ch = 0;
+
+		if (index >= st->chip_info->num_simult_channels) {
+			index -= st->chip_info->num_simult_channels;
+			ch = 1;
+		}
+
+		ret = ad7380_set_ch(st, ch);
+		if (ret)
+			return ret;
+	}
+
 	ad7380_update_xfers(st, scan_type);
 
 	ret = spi_sync(st->spi, &st->msg);
 	if (ret < 0)
 		return ret;
 
-	if (scan_type->storagebits > 16)
-		*val = sign_extend32(*(u32 *)(st->scan_data + 4 * scan_index),
-				     scan_type->realbits - 1);
-	else
-		*val = sign_extend32(*(u16 *)(st->scan_data + 2 * scan_index),
-				     scan_type->realbits - 1);
+	if (scan_type->storagebits > 16) {
+		if (scan_type->sign == 's')
+			*val = sign_extend32(*(u32 *)(st->scan_data + 4 * index),
+					     scan_type->realbits - 1);
+		else
+			*val = *(u32 *)(st->scan_data + 4 * index) &
+				GENMASK(scan_type->realbits - 1, 0);
+	} else {
+		if (scan_type->sign == 's')
+			*val = sign_extend32(*(u16 *)(st->scan_data + 2 * index),
+					     scan_type->realbits - 1);
+		else
+			*val = *(u16 *)(st->scan_data + 2 * index) &
+				GENMASK(scan_type->realbits - 1, 0);
+	}
 
 	return IIO_VAL_INT;
 }
@@ -664,6 +918,7 @@ static int ad7380_init(struct ad7380_state *st, struct regulator *vref)
 
 	/* This is the default value after reset. */
 	st->oversampling_ratio = 1;
+	st->ch = 0;
 
 	/* SPI 1-wire mode */
 	return regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG2,
@@ -807,10 +1062,16 @@ static const struct of_device_id ad7380_of_match_table[] = {
 	{ .compatible = "adi,ad7381", .data = &ad7381_chip_info },
 	{ .compatible = "adi,ad7383", .data = &ad7383_chip_info },
 	{ .compatible = "adi,ad7384", .data = &ad7384_chip_info },
+	{ .compatible = "adi,ad7386", .data = &ad7386_chip_info },
+	{ .compatible = "adi,ad7387", .data = &ad7387_chip_info },
+	{ .compatible = "adi,ad7388", .data = &ad7388_chip_info },
 	{ .compatible = "adi,ad7380-4", .data = &ad7380_4_chip_info },
 	{ .compatible = "adi,ad7381-4", .data = &ad7381_4_chip_info },
 	{ .compatible = "adi,ad7383-4", .data = &ad7383_4_chip_info },
 	{ .compatible = "adi,ad7384-4", .data = &ad7384_4_chip_info },
+	{ .compatible = "adi,ad7386-4", .data = &ad7386_4_chip_info },
+	{ .compatible = "adi,ad7387-4", .data = &ad7387_4_chip_info },
+	{ .compatible = "adi,ad7388-4", .data = &ad7388_4_chip_info },
 	{ }
 };
 
@@ -819,10 +1080,16 @@ static const struct spi_device_id ad7380_id_table[] = {
 	{ "ad7381", (kernel_ulong_t)&ad7381_chip_info },
 	{ "ad7383", (kernel_ulong_t)&ad7383_chip_info },
 	{ "ad7384", (kernel_ulong_t)&ad7384_chip_info },
+	{ "ad7386", (kernel_ulong_t)&ad7386_chip_info },
+	{ "ad7387", (kernel_ulong_t)&ad7387_chip_info },
+	{ "ad7388", (kernel_ulong_t)&ad7388_chip_info },
 	{ "ad7380-4", (kernel_ulong_t)&ad7380_4_chip_info },
 	{ "ad7381-4", (kernel_ulong_t)&ad7381_4_chip_info },
 	{ "ad7383-4", (kernel_ulong_t)&ad7383_4_chip_info },
 	{ "ad7384-4", (kernel_ulong_t)&ad7384_4_chip_info },
+	{ "ad7386-4", (kernel_ulong_t)&ad7386_4_chip_info },
+	{ "ad7387-4", (kernel_ulong_t)&ad7387_4_chip_info },
+	{ "ad7388-4", (kernel_ulong_t)&ad7388_4_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7380_id_table);

-- 
2.45.1


