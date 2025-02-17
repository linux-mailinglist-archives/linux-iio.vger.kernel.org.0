Return-Path: <linux-iio+bounces-15524-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD0AA35D93
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2025 13:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 857827A433E
	for <lists+linux-iio@lfdr.de>; Fri, 14 Feb 2025 12:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D892641E1;
	Fri, 14 Feb 2025 12:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3Oj7a4fr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D44263F4A
	for <linux-iio@vger.kernel.org>; Fri, 14 Feb 2025 12:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739535804; cv=none; b=DBHk/WOmfyC6EtxYvZfO6WjeZsXgUm3O6ehcrh8v/lO5aRqSWO2pAKVMgIUZTrKuXPqorW0QLSyN8ZRG3V2Oq64R4klTYJ+y2XTb/238N3ZxWRglGi/7wNv1SkKEvJ1EFz3zFf+chiHwLXuvJQP0lVRD7SNz0nez7DP+LMGBnnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739535804; c=relaxed/simple;
	bh=W9yMKieEXNBYhbCo5Jvnb/3ZjTot++8G3dNCwWJvpts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RmLxmyGpVISuGs7sPfM5b/IcXLgNY3DfA4CM/QYUkH7Zt64BkNicRsWk6oD4laRI+nymYj3Lu0UzfAt8hDl9makKgzyMhDpbkuS2D4R52eoWD3TNO8Mq5ygXkXtAL6edOmsXztuBpgHglf4aruQHem4x5I2D4qk7HqIb77sMXe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3Oj7a4fr; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4396a82daf5so3758315e9.1
        for <linux-iio@vger.kernel.org>; Fri, 14 Feb 2025 04:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739535797; x=1740140597; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lpVt0ni+2FVUdo6X72Cjhq/6puDDJr6iZ54cPTEPmD4=;
        b=3Oj7a4frtc90yfCON6GkY0DN+WkAXSx0VodZ1jPdpwaf5wiVc32hodAb3iqf7e5BvM
         OEPDfXEd4S0+ZicLp2AdXeusvxSVxagpH1DGkpK6Q/ZI18vXrEvgoBm31tRvPKfKyPtP
         sczJb9qr6yh6qcnIg6KuF5w5Pyqpy2QqhI6/LCztowwOzomYznbyu+48EL7UfRj1gOqb
         wvoPG7aj7f0f56IjZbO64/mrQYBxKcqN0y1XvFJS0LpYMidTKtor1TAmq7vEoKsDaNFw
         sFg1U7SS2R02Zr1C5rkR00yJUi571AElAJXsiEryUb9+7g88JABqmNZaB+NGNlIhX52i
         85xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739535797; x=1740140597;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lpVt0ni+2FVUdo6X72Cjhq/6puDDJr6iZ54cPTEPmD4=;
        b=ERmHGuFybNvOaQ/KKWUhhTodZ7NS+4jHyHdUltXnEqPYOMvgC/rKXkCJkw+6JQisZ3
         J/l0zwq0S+rzth5s402qV0GQxjACZruQPBL0Ls8jmrcAIIKYfeK5qfVoitYNmXCmYft8
         Sic/wKAQP4lUqacKEDT1dSviSwRI/VL+OH6unXMuTmrnBRcPZxKkrlWDrHPgBB3KUIHJ
         tXzW6rH6u24jGHddQlE9RKtUSW7SSCNMjxb5+4Ag1pxW8YxepS8q2j97SpJXuVshN4RQ
         kTeWhv/T5I+qrwGSgMgkx5zaB4GhJJg8vpmDpgakrLfgRlihlM1rvq1TmWpOtQj+Wq2+
         wF/A==
X-Forwarded-Encrypted: i=1; AJvYcCXglIuzeW3E7e8eKn9dXczKXjKMxZ0EOWf2Z3iUTjHNmSvm4bRHqKBjY8aqZDO2cJYzAGLyzQa5uzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPCf04U5o9BnUYi64Ua6rKmMyDJhWsRMsKZhGJI1OS8ILPRxNB
	9MUyZuspeYMORfD6RZg2MvYjlTxgSga7qVXBwHqsOSzVT8snvrfPkYgg1XfNh14=
X-Gm-Gg: ASbGncv7B3lRF3eKhzgc9ribOtEDl5s5uwaGd5jYK+aIAY4BeIhL65nkkDV1LcQho7U
	R/9i1XN6/ZCwBpjjkptb+j9rsc5h74enaZDdHIelVaYl4s2XPw1/qozHCuTU8My43LF+zT4l4eP
	h9wiI9WCC07m4bZRmAV9sG9Op3nljml1fWOdtbWpXNDbRCgYyoy2mONiMVlYdTaER08eIvO1DFA
	gVEqLWHTJyQP9jQXM0v/3SH8sp76aFBQ05ZmfHMcQ+uuT7/2D6gGhv6QiLvA+Xuz40BAFQOGOES
	r0/Lw9TkKEyz0GOcwYISLvvBaYnXBuq5KDTgN4l2tOXriCHpsMoku5FHh+azGF1L/ZY9xLmM
X-Google-Smtp-Source: AGHT+IEo2eWy8FjWbjRUiobCa7fMsyW0SSgMypjbUFM7AXc2ZBqs2NJpv2cjQxhCkYWytklrO/kpVw==
X-Received: by 2002:a05:6000:1f81:b0:38f:2173:b7b7 with SMTP id ffacd0b85a97d-38f2173b9aemr9978221f8f.18.1739535797516;
        Fri, 14 Feb 2025 04:23:17 -0800 (PST)
Received: from [127.0.0.1] (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7b68sm4424654f8f.85.2025.02.14.04.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 04:23:17 -0800 (PST)
From: Esteban Blanc <eblanc@baylibre.com>
Date: Fri, 14 Feb 2025 13:22:34 +0100
Subject: [PATCH v4 4/6] iio: adc: ad4030: add support for ad4630-24 and
 ad4630-16
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-eblanc-ad4630_v1-v4-4-135dd66cab6a@baylibre.com>
References: <20250214-eblanc-ad4630_v1-v4-0-135dd66cab6a@baylibre.com>
In-Reply-To: <20250214-eblanc-ad4630_v1-v4-0-135dd66cab6a@baylibre.com>
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
index ed31a3d1d13b831f46818cb72353e11b1689407d..a5f08522175493b5574144352e71d3e70bb6ad3e 100644
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
@@ -83,6 +85,7 @@
 #define AD4030_MAX_HARDWARE_CHANNEL_NB		2
 #define AD4030_MAX_IIO_CHANNEL_NB		5
 #define AD4030_SINGLE_COMMON_BYTE_CHANNELS_MASK	0b10
+#define AD4030_DUAL_COMMON_BYTE_CHANNELS_MASK	0b1100
 #define AD4030_GAIN_MIDLE_POINT			0x8000
 /*
  * This accounts for 1 sample per channel plus one s64 for the timestamp,
@@ -112,6 +115,13 @@ enum ad4030_out_mode {
 	AD4030_OUT_DATA_MD_32_PATTERN,
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
@@ -150,7 +160,11 @@ struct ad4030_state {
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
 
@@ -514,19 +528,33 @@ static int ad4030_set_avg_frame_len(struct iio_dev *dev, int avg_val)
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
@@ -538,11 +566,52 @@ static int ad4030_set_mode(struct iio_dev *indio_dev, unsigned long mask)
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
@@ -567,10 +636,23 @@ static int ad4030_conversion(struct iio_dev *indio_dev)
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
@@ -585,14 +667,25 @@ static int ad4030_single_conversion(struct iio_dev *indio_dev,
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
2.47.2


