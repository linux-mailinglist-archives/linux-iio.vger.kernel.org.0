Return-Path: <linux-iio+bounces-14726-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51807A22C3C
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 12:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1289188A101
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jan 2025 11:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F19E1E1027;
	Thu, 30 Jan 2025 11:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BmKXmZX/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1E11DE897
	for <linux-iio@vger.kernel.org>; Thu, 30 Jan 2025 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738235336; cv=none; b=BjxYYps7EMFPZjlaSRT2JLPNzMGpofHjlMeNsn2jJJpIvMlTdq2O+EiKScmpYuBnPt+Br6jEGf/HCTsvcUAz0y1RyvIIXloTqujUiu04/V9cpRq5YiImSsNAC/BzqRRerAIcZxMDIDQvT7ibx/rG3cw84ZrdaYtMG+Zt7M99SMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738235336; c=relaxed/simple;
	bh=9POGhVF6RgiDv0gXZ4MJl273DxuTac/9CT5jeUuEaqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GoZpKpa1aXnP/OCIf4bQmZIoZo8Ik1yWgE2/Awz07dHZj81dBKMzYSjySofALS9RwFDC+84upmS+9t2+12CMvQGeTm3hqZ3RD3Ow+i0yT66JeRr9g85IX88zdx3wpt3NFrgbEnhhrKtYP5K4MOBl6mmJ169cFnl8RX+YKedZDYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BmKXmZX/; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385e1fcb0e1so326160f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 30 Jan 2025 03:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1738235332; x=1738840132; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7YSIPj5RP22cErksXoU0J04Uh0PrH8osxcrrurHALL4=;
        b=BmKXmZX/ze3GJb0vDCt1IRrWua3/VdaO1wxgHRb9FgNHCBjUbed9X7JutuNw6/hXlw
         G9AZ6A4w3i8NCqtOo+Ih3LGiIRgyjgMdWdZSZklfuzHjHZQuyOJ1xgIv5G/woMM6dvTC
         Jra1JlRNONfROYYVc0X5xp0AyTUEvQ3nwwIfMtaAcspsqc+JOCz2AYKjM0ZSToGguPcS
         y8lO9dKSEugWrBoWABfg5inH260+i9zbbibG1FqlowT4aBczoNIjRDGzJnlf+9YOopNA
         Rq9Kc3aueOrjhUUuwMpkTqKf0JYt633qwwhPJTz80fncfgMaj+eCqq+yYLaBlxK4gdRb
         GUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738235332; x=1738840132;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YSIPj5RP22cErksXoU0J04Uh0PrH8osxcrrurHALL4=;
        b=X3TJM6BjwoxusQm0jlJPuxbtFnKJPUfs115JLqm6vKJQNpQoLpGW4yWwJ3w8BjIvob
         3OP/V3jGA2QdblxztIU73eP/3OQnOXYLo3igBDK2cKqi4eYmJaoEF9R2F1iaMhNUgj0T
         rSTRZUNUpWyXB1yjxq1qLYAhQbmf3b66R+EemXnuVSzj+TNT/APAENQpHU5xn08QM9Cp
         Ib5X/Tp3oyxPGToW/RYq3Cj0HwiqRbhvgn1OzGPVUFqLXOAJyY4MpbLiWBWurJ3hVstX
         yFXV8vkgWPKjh7WnCkE7VVpryUrfN1Y2FNGsxOtYNfcC1zRh1iGsLMUEgVd/OuF5ZUPk
         v8ew==
X-Forwarded-Encrypted: i=1; AJvYcCUsgOLyfqicX7RfDHQW24rruRabF9um0zjLllapenEJCimMpaOd6JDbUurOxopNj7CBwd3LgGe0Wqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWimtEQFF4jWx+J6DkXBjLUdkIbfaUVA5FaZt6lnxu5QpYeOgj
	nV1SZfSiXRxobvdx0ITJokCScQODnQkCUCbm9ZclV0FITkoLOxnrrD+sKIxhbHk=
X-Gm-Gg: ASbGncs5NyVl4EVSPSncim/nJ36tJkUjk9qX2gXdrfOtGqXrjtt+uMG3GjCB8Kr1iPG
	lZVSJ7pIt++l4kAEfDC1ViCXZga7s8yTGt+cbs/8/Kh4FGGWRV2YUjwoGDi2TKgaidhQ0H52iRZ
	v6EOEawG7i5oRVpULJ50StHEUHG6yLnjHtfEmcWmpBleInkd8M4G1VtspNQsIQStsiJRg0mPi5b
	E0GWOER1yG548qfi/xHj2q/2vnhT1MndH8GYOYTHKgW2Mnj0E0Pvkg/sfiCIJW60JI/VjEmUbi/
	m7/9pCti/E8Rx5jr
X-Google-Smtp-Source: AGHT+IFDC7rIlcgDwmIIAdPjA7xvlXdAlxcfk6Jv1zCVxgeLuXNVfv7bhRviIiT2omQUAPzNhHHOqg==
X-Received: by 2002:a05:6000:1446:b0:38c:5d95:305a with SMTP id ffacd0b85a97d-38c5d953273mr1045039f8f.26.1738235332090;
        Thu, 30 Jan 2025 03:08:52 -0800 (PST)
Received: from [127.0.0.1] ([2a01:e0a:448:76e0:2c72:cd2d:79b2:82ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c102bb2sm1689225f8f.34.2025.01.30.03.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 03:08:51 -0800 (PST)
From: Esteban Blanc <eblanc@baylibre.com>
Date: Thu, 30 Jan 2025 12:08:28 +0100
Subject: [PATCH v3 4/6] iio: adc: ad4030: add support for ad4630-24 and
 ad4630-16
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250130-eblanc-ad4630_v1-v3-4-052e8c2d897d@baylibre.com>
References: <20250130-eblanc-ad4630_v1-v3-0-052e8c2d897d@baylibre.com>
In-Reply-To: <20250130-eblanc-ad4630_v1-v3-0-052e8c2d897d@baylibre.com>
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
index ef76f077feb0b995938b7acdddf3d45c990ea8ef..45d99152d84aeb878c7554edfdc32d3a1295e9c4 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -33,6 +33,8 @@
 #define AD4030_REG_PRODUCT_ID_H				0x05
 #define AD4030_REG_CHIP_GRADE				0x06
 #define     AD4030_REG_CHIP_GRADE_AD4030_24_GRADE	0x10
+#define     AD4030_REG_CHIP_GRADE_AD4630_16_GRADE	0x03
+#define     AD4030_REG_CHIP_GRADE_AD4630_24_GRADE	0x00
 #define     AD4030_REG_CHIP_GRADE_MASK_CHIP_GRADE	GENMASK(7, 3)
 #define AD4030_REG_SCRATCH_PAD			0x0A
 #define AD4030_REG_SPI_REVISION			0x0B
@@ -85,6 +87,7 @@
 #define AD4030_MAX_HARDWARE_CHANNEL_NB		2
 #define AD4030_MAX_IIO_CHANNEL_NB		5
 #define AD4030_SINGLE_COMMON_BYTE_CHANNELS_MASK	0b10
+#define AD4030_DUAL_COMMON_BYTE_CHANNELS_MASK	0b1100
 #define AD4030_GAIN_MIDLE_POINT			0x8000
 /*
  * This accounts for 1 sample per channel plus one s64 for the timestamp,
@@ -114,6 +117,13 @@ enum ad4030_out_mode {
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
@@ -152,7 +162,11 @@ struct ad4030_state {
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
 
@@ -511,19 +525,33 @@ static int ad4030_set_avg_frame_len(struct iio_dev *dev, int avg_val)
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
@@ -535,11 +563,52 @@ static int ad4030_set_mode(struct iio_dev *indio_dev, unsigned long mask)
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
@@ -564,10 +633,23 @@ static int ad4030_conversion(struct iio_dev *indio_dev)
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
@@ -582,14 +664,25 @@ static int ad4030_single_conversion(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
+	st->current_scan_type = iio_get_current_scan_type(indio_dev,
+							  st->chip->channels);
+	if (IS_ERR(st->current_scan_type))
+		return PTR_ERR(st->current_scan_type);
+
 	ret = ad4030_conversion(indio_dev);
 	if (ret)
 		return ret;
 
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
 
 	return IIO_VAL_INT;
 }
@@ -882,10 +975,24 @@ static int ad4030_detect_chip_info(const struct ad4030_state *st)
 
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
@@ -974,6 +1081,14 @@ static const unsigned long ad4030_channel_masks[] = {
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
@@ -991,6 +1106,23 @@ static const struct iio_scan_type ad4030_24_scan_types[] = {
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
@@ -1005,14 +1137,50 @@ static const struct ad4030_chip_info ad4030_24_chip_info = {
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
2.47.2


