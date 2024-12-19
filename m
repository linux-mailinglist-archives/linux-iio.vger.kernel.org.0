Return-Path: <linux-iio+bounces-13655-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 559F79F7F04
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 17:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A952188F5C6
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 16:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4024C226551;
	Thu, 19 Dec 2024 16:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="h17mzWmH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B11322653F
	for <linux-iio@vger.kernel.org>; Thu, 19 Dec 2024 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734624686; cv=none; b=p8TbB+dfHtOopGBMJXso1Ez6+lWGDoplaHmsKNrm8htHEoruLlSvYEFTVKGmcGWNqSwHmTyc0c+Q7ovnUjDYfm8RyRKzepYN6hQRzecUbbhbmkNRWI9F0WTk7RJLouG6VyevxGXNSVT8YggtszefVSJePY9RyVRmkjcFjRpVzb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734624686; c=relaxed/simple;
	bh=Wr2CxEysxsiNbJGPZEaJ1MiCCA4wykPi78OmNotxHEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u/yi/KY4+K5qtnGNk8mioDMTo5X15p4ZWxHos2syOkaTKy6MF+G1c2amVhr6b8iJYpt9IsGKg0a88eosVSB+Mqid2bXIaHZo7buQbtzvSdQ1sPf3FPeFbl47qSQ+MpNUxIvhtqm4ehUUOsk1xRSpeqs4GH3NDtE9kUVIPuU17VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=h17mzWmH; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso936202f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 19 Dec 2024 08:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734624682; x=1735229482; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ile9y1+NUkRsRclaOTRKCwy2ACGXh/NkpfaWhfDQtFI=;
        b=h17mzWmHc+qg4stoDDR8tDzrQBy4uQoSJ8DINTkrSrzXtmqLKt0/+EIdjJL8LJeS9w
         wDJMVyqBC2zieeQa0bhgmsPeT8FZuGJhaFpi6BEHcq6DJn8g9OyQicq5OZffzGcpqsb2
         1ByHBFfsuy/EwjrSbnPQahb3s8tPg5nNzWv/8w2pPZm4DA+qFkkJz3K9O5qUpt9Tejoc
         aNrRv8gR0MlVkcHNAO1pr2PuHmWtbnYl6BBB6g4RF6rnyiGMSHBebNHyNdBme0CnNFHA
         lRRpSNiQJb0mHJWysERkYXIPwOVwzR66EgaJkphtB5abDeHFJv8/qwcqtXd6aS6Ee2Cu
         vuyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734624682; x=1735229482;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ile9y1+NUkRsRclaOTRKCwy2ACGXh/NkpfaWhfDQtFI=;
        b=fu+7w4JnOjypUEmmeidsJ5VtEPArX0ci3VAk6xyS8/yC7x/L+etPL9swsaQPsk6PE7
         50ICdstZQ0k5fNuLMkjWfUCbaxTzrNLr96QqV4le7ZhjbxYJqyqzrKRiZFvank08lkjs
         dcZQuv+b4gj0hiOL/qp4sCc9JrzP6x2KRH3xQ8x+dG+eICGNROkEoZxcscgvZA0Q0pcW
         Q7Uci7204stDN2bkJM8xXLD6mrMAvPTs3ur55kpzJPGGXphKtpO5/6XbZqseekokACKw
         aHikp3F4q6o2OAvJfU5PCqQnES0wWh5EhqWI0KfAM4/xI9d0RZAjqT0+txt3g8ULkuct
         tuwg==
X-Forwarded-Encrypted: i=1; AJvYcCUtApgdhtbxFtNkJ5NnONgkIgCu5Q8Wgfm6EbxUZWEOSpHzE0SzBwlRHGgzaotQKsLgVj0lj/q8ZqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDtRMQkRPlTQuJvk8vP+5ENmaxL4W/vAzNu4KwCHP2YMae1JRs
	twDWhjjS+27u5kCWgxDdeGdUUkawWUEQesBZEXgr4WEnQZ2asILZMqH+ZDPx+Do=
X-Gm-Gg: ASbGnctBCpL71ZEMWSk94Nx9GZ9/7Lf2IIkcLzS49Jq7mzvcUXEJO86C0UvfDjRXfQu
	UTfUwK25gKjOi8Vqv9/sl8KPsKhXYnpi9tHdgwmAW5wniqVt6KyApBu++QWQrLeJ6+GwFkIfiXD
	nZEduLwz39uc1BZLeGmPgTg9dD22DNi/lsUg/ZqCgOpprVJT/aDjcz4UM/CwGq8s30DCmdolHmW
	1jC7+c5d8nuAoFNDgz5p5wnyc3M0VFf8beYhGkXvbUiH52aCYr/jxP0qG5tLeoUiD7K57RKHOiG
	OJQ8+xIAD5cJw0xIp1R1lVqC1PK0voBbHQe/Ng==
X-Google-Smtp-Source: AGHT+IHbPy0LMv2GrU37Jd0jmicPvA+r8YouB2P41/koyaB+RqDHWlHq+Na5z0yKTgRcnV1qrXvPCQ==
X-Received: by 2002:a05:6000:1a8d:b0:386:144d:680f with SMTP id ffacd0b85a97d-38a19b3cd11mr4282713f8f.54.1734624682344;
        Thu, 19 Dec 2024 08:11:22 -0800 (PST)
Received: from [127.0.0.1] (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b3b295sm57526225e9.33.2024.12.19.08.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 08:11:21 -0800 (PST)
From: Esteban Blanc <eblanc@baylibre.com>
Date: Thu, 19 Dec 2024 17:10:39 +0100
Subject: [PATCH v2 4/6] iio: adc: ad4030: add support for ad4630-24 and
 ad4630-16
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-eblanc-ad4630_v1-v2-4-f36e55907bf5@baylibre.com>
References: <20241219-eblanc-ad4630_v1-v2-0-f36e55907bf5@baylibre.com>
In-Reply-To: <20241219-eblanc-ad4630_v1-v2-0-f36e55907bf5@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Esteban Blanc <eblanc@baylibre.com>
X-Mailer: b4 0.14.2

AD4630-24 and AD4630-16 are 2 channels ADCs. Both channels are
interleaved bit per bit on SDO line.

Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
---
 drivers/iio/adc/ad4030.c | 188 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 178 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index ce56a0e8df31097175a31cf9e9664af594807ddf..06e5a32d292e63eaf6f14ac79308a760736f78b4 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -32,6 +32,8 @@
 #define AD4030_REG_PRODUCT_ID_H				0x05
 #define AD4030_REG_CHIP_GRADE				0x06
 #define     AD4030_REG_CHIP_GRADE_AD4030_24_GRADE	0x10
+#define     AD4030_REG_CHIP_GRADE_AD4630_16_GRADE	0x03
+#define     AD4030_REG_CHIP_GRADE_AD4630_24_GRADE	0x00
 #define     AD4030_REG_CHIP_GRADE_MASK_CHIP_GRADE	GENMASK(7, 3)
 #define AD4030_REG_SCRATCH_PAD			0x0A
 #define AD4030_REG_SPI_REVISION			0x0B
@@ -84,6 +86,7 @@
 #define AD4030_MAX_HARDWARE_CHANNEL_NB		2
 #define AD4030_MAX_IIO_CHANNEL_NB		5
 #define AD4030_SINGLE_COMMON_BYTE_CHANNELS_MASK	0b10
+#define AD4030_DUAL_COMMON_BYTE_CHANNELS_MASK	0b1100
 /*
  * This accounts for 1 sample per channel plus one s64 for the timestamp,
  * aligned on a s64 boundary
@@ -113,6 +116,13 @@ enum ad4030_out_mode {
 	AD4030_OUT_DATA_MD_32_PATTERN
 };
 
+enum {
+	AD4030_LANE_MD_1_PER_CH,
+	AD4030_LANE_MD_2_PER_CH,
+	AD4030_LANE_MD_4_PER_CH,
+	AD4030_LANE_MD_INTERLEAVED,
+};
+
 enum {
 	AD4030_SCAN_TYPE_NORMAL,
 	AD4030_SCAN_TYPE_AVG,
@@ -151,7 +161,11 @@ struct ad4030_state {
 		struct {
 			s32 diff;
 			u8 common;
-		};
+		} single;
+		struct {
+			s32 diff[2];
+			u8 common[2];
+		} dual;
 	} rx_data;
 };
 
@@ -469,19 +483,33 @@ static int ad4030_set_avg_frame_len(struct iio_dev *dev, int avg_val)
 static bool ad4030_is_common_byte_asked(struct ad4030_state *st,
 					unsigned int mask)
 {
-	return mask & AD4030_SINGLE_COMMON_BYTE_CHANNELS_MASK;
+	return mask & (st->chip->num_voltage_inputs == 1 ?
+		AD4030_SINGLE_COMMON_BYTE_CHANNELS_MASK :
+		AD4030_DUAL_COMMON_BYTE_CHANNELS_MASK);
 }
 
 static int ad4030_set_mode(struct iio_dev *indio_dev, unsigned long mask)
 {
 	struct ad4030_state *st = iio_priv(indio_dev);
 
-	if (st->avg_log2 > 0)
+	if (st->avg_log2 > 0) {
 		st->mode = AD4030_OUT_DATA_MD_30_AVERAGED_DIFF;
-	else if (ad4030_is_common_byte_asked(st, mask))
-		st->mode = AD4030_OUT_DATA_MD_24_DIFF_8_COM;
-	else
+	} else if (ad4030_is_common_byte_asked(st, mask)) {
+		switch (st->chip->precision_bits) {
+		case 16:
+			st->mode = AD4030_OUT_DATA_MD_16_DIFF_8_COM;
+			break;
+
+		case 24:
+			st->mode = AD4030_OUT_DATA_MD_24_DIFF_8_COM;
+			break;
+
+		default:
+			return -EINVAL;
+		}
+	} else {
 		st->mode = AD4030_OUT_DATA_MD_DIFF;
+	}
 
 	st->current_scan_type = iio_get_current_scan_type(indio_dev,
 							  st->chip->channels);
@@ -493,11 +521,52 @@ static int ad4030_set_mode(struct iio_dev *indio_dev, unsigned long mask)
 				st->mode);
 }
 
+/*
+ * Descramble 2 32bits numbers out of a 64bits. The bits are interleaved:
+ * 1 bit for first number, 1 bit for the second, and so on...
+ */
+static void ad4030_extract_interleaved(u8 *src, u32 *ch0, u32 *ch1)
+{
+	u8 h0, h1, l0, l1;
+	u32 out0, out1;
+	u8 *out0_raw = (u8 *)&out0;
+	u8 *out1_raw = (u8 *)&out1;
+
+	for (int i = 0; i < 4; i++) {
+		h0 = src[i * 2];
+		l1 = src[i * 2 + 1];
+		h1 = h0 << 1;
+		l0 = l1 >> 1;
+
+		h0 &= 0xAA;
+		l0 &= 0x55;
+		h1 &= 0xAA;
+		l1 &= 0x55;
+
+		h0 = (h0 | h0 << 001) & 0xCC;
+		h1 = (h1 | h1 << 001) & 0xCC;
+		l0 = (l0 | l0 >> 001) & 0x33;
+		l1 = (l1 | l1 >> 001) & 0x33;
+		h0 = (h0 | h0 << 002) & 0xF0;
+		h1 = (h1 | h1 << 002) & 0xF0;
+		l0 = (l0 | l0 >> 002) & 0x0F;
+		l1 = (l1 | l1 >> 002) & 0x0F;
+
+		out0_raw[i] = h0 | l0;
+		out1_raw[i] = h1 | l1;
+	}
+
+	*ch0 = out0;
+	*ch1 = out1;
+}
+
 static int ad4030_conversion(struct iio_dev *indio_dev)
 {
 	struct ad4030_state *st = iio_priv(indio_dev);
 	unsigned char diff_realbytes =
 		BITS_TO_BYTES(st->current_scan_type->realbits);
+	unsigned char diff_storagebytes =
+		BITS_TO_BYTES(st->current_scan_type->storagebits);
 	unsigned int bytes_to_read;
 	unsigned long cnv_nb = BIT(st->avg_log2);
 	unsigned int i;
@@ -522,10 +591,23 @@ static int ad4030_conversion(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	if (st->mode != AD4030_OUT_DATA_MD_24_DIFF_8_COM)
+	if (st->chip->num_voltage_inputs == 2)
+		ad4030_extract_interleaved(st->rx_data.raw,
+					   &st->rx_data.dual.diff[0],
+					   &st->rx_data.dual.diff[1]);
+
+	if (st->mode != AD4030_OUT_DATA_MD_16_DIFF_8_COM &&
+	    st->mode != AD4030_OUT_DATA_MD_24_DIFF_8_COM)
+		return 0;
+
+	if (st->chip->num_voltage_inputs == 1) {
+		st->rx_data.single.common = st->rx_data.raw[diff_realbytes];
 		return 0;
+	}
 
-	st->rx_data.common = st->rx_data.raw[diff_realbytes];
+	for (i = 0; i < st->chip->num_voltage_inputs; i++)
+		st->rx_data.dual.common[i] =
+			st->rx_data.raw[diff_storagebytes * i + diff_realbytes];
 
 	return 0;
 }
@@ -540,6 +622,11 @@ static int ad4030_single_conversion(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
+	st->current_scan_type = iio_get_current_scan_type(indio_dev,
+							  st->chip->channels);
+	if (IS_ERR(st->current_scan_type))
+		return PTR_ERR(st->current_scan_type);
+
 	ret = ad4030_exit_config_mode(st);
 	if (ret)
 		goto out_error;
@@ -549,9 +636,15 @@ static int ad4030_single_conversion(struct iio_dev *indio_dev,
 		goto out_error;
 
 	if (chan->differential)
-		*val = st->rx_data.diff;
+		if (st->chip->num_voltage_inputs == 1)
+			*val = st->rx_data.single.diff;
+		else
+			*val = st->rx_data.dual.diff[chan->address];
 	else
-		*val = st->rx_data.common;
+		if (st->chip->num_voltage_inputs == 1)
+			*val = st->rx_data.single.common;
+		else
+			*val = st->rx_data.dual.common[chan->address];
 
 	ad4030_enter_config_mode(st);
 
@@ -874,10 +967,24 @@ static int ad4030_detect_chip_info(const struct ad4030_state *st)
 
 static int ad4030_config(struct ad4030_state *st)
 {
+	int ret;
+	u8 reg_modes;
+
 	st->offset_avail[0] = (int)BIT(st->chip->precision_bits - 1) * -1;
 	st->offset_avail[1] = 1;
 	st->offset_avail[2] = BIT(st->chip->precision_bits - 1) - 1;
 
+	if (st->chip->num_voltage_inputs > 1)
+		reg_modes = FIELD_PREP(AD4030_REG_MODES_MASK_LANE_MODE,
+				       AD4030_LANE_MD_INTERLEAVED);
+	else
+		reg_modes = FIELD_PREP(AD4030_REG_MODES_MASK_LANE_MODE,
+				       AD4030_LANE_MD_1_PER_CH);
+
+	ret = regmap_write(st->regmap, AD4030_REG_MODES, reg_modes);
+	if (ret)
+		return ret;
+
 	if (st->vio_uv < AD4030_VIO_THRESHOLD_UV)
 		return regmap_write(st->regmap, AD4030_REG_IO,
 				    AD4030_REG_IO_MASK_IO2X);
@@ -966,6 +1073,14 @@ static const unsigned long ad4030_channel_masks[] = {
 	0,
 };
 
+static const unsigned long ad4630_channel_masks[] = {
+	/* Differential only */
+	BIT(1) | BIT(0),
+	/* Differential with common byte */
+	GENMASK(3, 0),
+	0,
+};
+
 static const struct iio_scan_type ad4030_24_scan_types[] = {
 	[AD4030_SCAN_TYPE_NORMAL] = {
 		.sign = 's',
@@ -983,6 +1098,23 @@ static const struct iio_scan_type ad4030_24_scan_types[] = {
 	},
 };
 
+static const struct iio_scan_type ad4030_16_scan_types[] = {
+	[AD4030_SCAN_TYPE_NORMAL] = {
+		.sign = 's',
+		.storagebits = 32,
+		.realbits = 16,
+		.shift = 16,
+		.endianness = IIO_BE,
+	},
+	[AD4030_SCAN_TYPE_AVG] = {
+		.sign = 's',
+		.storagebits = 32,
+		.realbits = 30,
+		.shift = 2,
+		.endianness = IIO_BE,
+	}
+};
+
 static const struct ad4030_chip_info ad4030_24_chip_info = {
 	.name = "ad4030-24",
 	.available_masks = ad4030_channel_masks,
@@ -997,14 +1129,50 @@ static const struct ad4030_chip_info ad4030_24_chip_info = {
 	.tcyc_ns = AD4030_TCYC_ADJUSTED_NS,
 };
 
+static const struct ad4030_chip_info ad4630_16_chip_info = {
+	.name = "ad4630-16",
+	.available_masks = ad4630_channel_masks,
+	.channels = {
+		AD4030_CHAN_DIFF(0, ad4030_16_scan_types),
+		AD4030_CHAN_DIFF(1, ad4030_16_scan_types),
+		AD4030_CHAN_CMO(2, 0),
+		AD4030_CHAN_CMO(3, 1),
+		IIO_CHAN_SOFT_TIMESTAMP(4),
+	},
+	.grade = AD4030_REG_CHIP_GRADE_AD4630_16_GRADE,
+	.precision_bits = 16,
+	.num_voltage_inputs = 2,
+	.tcyc_ns = AD4030_TCYC_ADJUSTED_NS,
+};
+
+static const struct ad4030_chip_info ad4630_24_chip_info = {
+	.name = "ad4630-24",
+	.available_masks = ad4630_channel_masks,
+	.channels = {
+		AD4030_CHAN_DIFF(0, ad4030_24_scan_types),
+		AD4030_CHAN_DIFF(1, ad4030_24_scan_types),
+		AD4030_CHAN_CMO(2, 0),
+		AD4030_CHAN_CMO(3, 1),
+		IIO_CHAN_SOFT_TIMESTAMP(4),
+	},
+	.grade = AD4030_REG_CHIP_GRADE_AD4630_24_GRADE,
+	.precision_bits = 24,
+	.num_voltage_inputs = 2,
+	.tcyc_ns = AD4030_TCYC_ADJUSTED_NS,
+};
+
 static const struct spi_device_id ad4030_id_table[] = {
 	{ "ad4030-24", (kernel_ulong_t)&ad4030_24_chip_info },
+	{ "ad4630-16", (kernel_ulong_t)&ad4630_16_chip_info },
+	{ "ad4630-24", (kernel_ulong_t)&ad4630_24_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad4030_id_table);
 
 static const struct of_device_id ad4030_of_match[] = {
 	{ .compatible = "adi,ad4030-24", .data = &ad4030_24_chip_info },
+	{ .compatible = "adi,ad4630-16", .data = &ad4630_16_chip_info },
+	{ .compatible = "adi,ad4630-24", .data = &ad4630_24_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad4030_of_match);

-- 
2.47.0


