Return-Path: <linux-iio+bounces-7944-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD8593D5E7
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 17:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C9C28482B
	for <lists+linux-iio@lfdr.de>; Fri, 26 Jul 2024 15:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63B117C7D2;
	Fri, 26 Jul 2024 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xyM8p2mh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1BD17BB28
	for <linux-iio@vger.kernel.org>; Fri, 26 Jul 2024 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722007224; cv=none; b=bh1i9V7LeWAmwVlm7gFFE6ruNrt2g9fQC7ZjPZxCMqp5RhsN98IAkVlonWm6YYNE91iwt5om4X78JOPUBh4nAvsJ5x2LCUWR9VW1v9ch4H6OIqONt4vurMGo+XxPP/B5H7623ScIjUyEZcj/kPGZCuTtm73WyMiqdrd830IM+Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722007224; c=relaxed/simple;
	bh=3Frxf+BtKzz8twoeGB/sHxBl+HPY0FfGXAU2sX9mZSw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d4LvfjxNm1C7FO2UTc8++0LbTKByAb0IUV1UvDGFzCCh3kiLstsYCBtv/X1xDjq+pi8NzpYiSuY2/S8FOnbsARE+No3N8p6d5B4fVo5EkwKgb/eEJ3lcnIxs461k3o/z3pOhdJIeajrX2NzKcv4Lse2rPQAx8wiC/tJS+JonzuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xyM8p2mh; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4280bbdad3dso6666855e9.0
        for <linux-iio@vger.kernel.org>; Fri, 26 Jul 2024 08:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722007220; x=1722612020; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rg7Qt20+BXFzuU8ZM6zveN2ls7JMSHSZefeTyDD0PGk=;
        b=xyM8p2mhDJAiWE31VdMhW4fFTB5QT3nAwTyV+gk+66yephu+jo4f11QlDlZFyA3HG0
         cT4XxssUT5cM8UR3uTYRnJYAJ14WDs/kpADM63dWSzKMihgAQqQdmfWU6opCTm2KYStH
         6wq+1Rw5SzUrR7GEJDQL9VEy8xdM8Fi2n8eHldeDiDtJdxXlgBHjAEitsgrC9e7TElT0
         CgItoo41cXwNYvhxfeXkpuebyJS8MKUORgD/zgA40dg63qreX2ZcegqM0S4yKIeGXEAj
         xS0MBK86Z/jdrRZWA+cAok1nzXHv+jR+WFHKzWxfDHc9ECX1Ogg5NY3Ts1ylapj7OteP
         34Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722007220; x=1722612020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rg7Qt20+BXFzuU8ZM6zveN2ls7JMSHSZefeTyDD0PGk=;
        b=uxmHHzF7vh10h/IQfhzEQhzAn8GmjysDMcuwrnEwnfeNYK6Q+gBbHO9mXzAM54tDgm
         QQ4QhDhr6VWsAhD/rb5gQoiIdaQaRjNoRGYHfyR045rtL6zZojw59nbyTZ96QNPeEJfA
         xIFr1b64zcG3dpKDieCC9zwyAmS9QKmI9pFRHpxUiYHyRGaxknuEXKi5fXNi1Hzk58ZO
         HaLHHUHGARjWVLUiouW70iSSvBuiZ6k1kbWjPYeyA7FwTTdse7ym3JxwBnC+T2o8xPXY
         1cmTnHRpAi0wshcW4pKHjMMJ5urziZjuIsJpX30Ovcn5TJ+E4OubHnvcyZnp8UgQi7gV
         v2Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUyM+Fbodpxq9Uq5Usmigttj2s5VHBTAG8XZ1HpgTcs5ayA8zY/qtBsuF+PyJPjRoZXXmPuS7tK2NQNiJh37r9Ix/tz9xauz0m/
X-Gm-Message-State: AOJu0YybUr3qjwO8gAA2UoudgbGys7f4VJrBNWbnKMs6/avEPBlD19xP
	xBXzWIcHw7Cr0nb9KeGiQI0GgKxW1CCjMDgOsTzeqmc962L9tLdRLew9agZxT1c=
X-Google-Smtp-Source: AGHT+IEB0YZo+uJqWWDxAajxnU74nMzQ0yn8nWOyMlgB+88sk35CqX4hg9tKaqSkWuI8wUiNfyL36Q==
X-Received: by 2002:a5d:54cc:0:b0:367:8c65:3c9 with SMTP id ffacd0b85a97d-36b5cee306bmr31941f8f.2.1722007220108;
        Fri, 26 Jul 2024 08:20:20 -0700 (PDT)
Received: from [192.168.1.61] (2a02-842a-d52e-6101-6f8f-5617-c4b6-8627.rev.sfr.net. [2a02:842a:d52e:6101:6f8f:5617:c4b6:8627])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c0338sm5500985f8f.1.2024.07.26.08.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 08:20:19 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 26 Jul 2024 17:20:08 +0200
Subject: [PATCH 3/5] ad7380: add support for single-ended parts
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240726-ad7380-add-single-ended-chips-v1-3-2d628b60ccd1@baylibre.com>
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
 drivers/iio/adc/ad7380.c | 352 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 310 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index 03bbd561fb23..25d42fff1839 100644
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
+		.endianness = IIO_CPU
+	},
+	[AD7380_SCAN_TYPE_RESOLUTION_BOOST] = {
+		.sign = 'u',
+		.realbits = 14,
+		.storagebits = 16,
+		.endianness = IIO_CPU
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
+		.endianness = IIO_CPU
+	},
+	[AD7380_SCAN_TYPE_RESOLUTION_BOOST] = {
+		.sign = 'u',
+		.realbits = 16,
+		.storagebits = 16,
+		.endianness = IIO_CPU
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
+		.endianness = IIO_CPU
+	},
+	[AD7380_SCAN_TYPE_RESOLUTION_BOOST] = {
+		.sign = 'u',
+		.realbits = 18,
+		.storagebits = 32,
+		.endianness = IIO_CPU
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
@@ -432,6 +645,25 @@ static int ad7380_triggered_buffer_preenable(struct iio_dev *indio_dev)
 	if (IS_ERR(scan_type))
 		return PTR_ERR(scan_type);
 
+	if (st->chip_info->has_mux) {
+		unsigned int num_simult_channels = st->chip_info->num_simult_channels;
+		unsigned long active_scan_mask = *indio_dev->active_scan_mask;
+		unsigned int ch = 0;
+		int ret;
+
+		/*
+		 * Depending on the requested scan_mask and current state,
+		 * we need to change CH bit to sample correct data.
+		 */
+		if (active_scan_mask == GENMASK(2 * num_simult_channels - 1,
+						num_simult_channels))
+			ch = 1;
+
+		ret = ad7380_set_ch(st, ch);
+		if (ret)
+			return ret;
+	}
+
 	ad7380_update_xfers(st, scan_type);
 
 	return spi_optimize_message(st->spi, &st->msg);
@@ -474,20 +706,43 @@ static irqreturn_t ad7380_trigger_handler(int irq, void *p)
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
@@ -664,6 +919,7 @@ static int ad7380_init(struct ad7380_state *st, struct regulator *vref)
 
 	/* This is the default value after reset. */
 	st->oversampling_ratio = 1;
+	st->ch = 0;
 
 	/* SPI 1-wire mode */
 	return regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG2,
@@ -807,10 +1063,16 @@ static const struct of_device_id ad7380_of_match_table[] = {
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
 
@@ -819,10 +1081,16 @@ static const struct spi_device_id ad7380_id_table[] = {
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


