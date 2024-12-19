Return-Path: <linux-iio+bounces-13653-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B74A9F7F00
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 17:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03AC5188F5C6
	for <lists+linux-iio@lfdr.de>; Thu, 19 Dec 2024 16:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD145227B82;
	Thu, 19 Dec 2024 16:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ijJ9QYL6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5F6226881
	for <linux-iio@vger.kernel.org>; Thu, 19 Dec 2024 16:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734624686; cv=none; b=DSzgBEMq2PGEsrth9J3P50j7unOoyJ+1IlI8qUP/d7p8sViTzlozbWgmSXJ1e3wg+gBc8mITr9ZNwIBJvoZ4VKTj9e+ybaPamzGi0CE565RCEvY3FoYNIbB+ymc23Wq09JydWGD6sh74cVIK61OBkVuCmrMGs1HkaFa7XvxpSyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734624686; c=relaxed/simple;
	bh=ika3mFi4dHhkYAtYMRNZ07xpOwGRkIDJ7uLoggzq26E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aBBp50avaVz6pRUtsVTyi5sM2Q4PzGtIjt9+6y/4AjTDYXw1EiLTSBtWTY1EHQwCO9I9NfL0aI9KiLMNanKdlBmju5Ulj+IGhmRg4jpfyU/fKLVZuK+ifDxK2dHZWdJSFsKh00MbQDX0Gzb99bLozXonzc6jv3sp/9VAEgvEvk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ijJ9QYL6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-435f8f29f8aso7485695e9.2
        for <linux-iio@vger.kernel.org>; Thu, 19 Dec 2024 08:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734624681; x=1735229481; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=07NGLNL7nok63UKKXTVo95dNEclRfGJXb3rOy/nSXgM=;
        b=ijJ9QYL6J1tLdWgvBGlbkvm10j5XyP3aucZry6m/9TuN9jO++eJHyCLxBb0lDyeHDm
         BjhO9QzvAsKWBcMd3HQd69ITwqGwtQWHQ4+UwropfI+IrH+fvC2NXPfC5uHak6xeT3A0
         A7tEOqbpcdN+6qkkt48N9JbXWo9eqFsG+btyI4Nj1QmjB3ieXHt4QCCYp4BtDC7aOm7K
         XR+GlE0rjiGxoNEumKdiHtc5IYm0r8LkE/bWP4FoCBb4eBL0kWFyMUMKkJ7iFvyOL2/Y
         C+eTAKEQaVV4Yd9qbrmeRtioY7U1Rv4ZLfM2vw91PAZcm+35GlSkXybgaFXPCJD+yH/q
         U2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734624681; x=1735229481;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=07NGLNL7nok63UKKXTVo95dNEclRfGJXb3rOy/nSXgM=;
        b=w/SxYYAKa8MO4ApNdO/F97fPw6kuPUJmQTdcpyyEBfkAPn9y5k/aaF0KViZWgAwBhd
         p9QiK63kL8l5mWHavBuocmh0UyK2+8wDXfU2sCe/q+x1MOo3CcuwFCPOcFV4XfV10LLb
         3G6qjoeN5clmvw6XG8QMdSvwCjWBtwW6NOCuMi1wN9YdyaSGS13W+PBjVx+0lkdT527A
         Iubxs3oYUfs+8O5QubYnLIJYW74K7qbjX7Vll2527351ylEHx8oJck2HsVtMjomlQSk0
         s4g4GrFpgbzSRQXirX4mDA8NI7EdPAjKUmxJxrp2QyYEF2KngDqAgP247qWhPyEe8YaA
         nYvw==
X-Forwarded-Encrypted: i=1; AJvYcCU/shfW4w2ZHOBRvRhj/6KlEmxNxdcHnQuCYLZCbZOTyE5XnwoTnBAsmGr1zOY5Je2wV1LlVwCg56s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAaBLhN7FNWPSenURqTyxltCqTW0bDi+UJNTsmeYS3SS/DNzDw
	rO2ZNVFOzhGi1FMXPBQUDZ8hJAmci3PZcRMZkfXcYMGO0hrqOCgRza+OMjR3+Gg=
X-Gm-Gg: ASbGncsXizleJdHxecjbfVVd+ejMnYTxAVSYrKiCY1wdg19elO3+taa41utDn9ESvlc
	eLLX7ZixON9mJlM6kd4oAOdBD0xzJd1LdWsGqdo5UkV/Me0ir6T0tbAEu6LPh44QLIM7eUmdHl9
	282sSOK5yMxfuqu3kE7nnOU7fDEed0/Gl+xQyYzvuCmSn7gggX7ASVGsiPupyl9tIXgFqzr9HHf
	MNK0NAGF5yQciQrXr2mMAl8ksCxbEnFlwTAZZCPW8VU0uyzhdSPP1tObfSeBycQM0cr2hvQa4W7
	tfM+8wy1IGcDHzojmtoofnXwEiuqlshyOiDHBQ==
X-Google-Smtp-Source: AGHT+IEtJ0+q9w2rXJas7j8Us42CTBygJyjQbRM3zvJeyajJ/EwN+o3MNc7+mkCVgweCtkPVghZd1A==
X-Received: by 2002:a05:600c:4b94:b0:434:fe3c:c67c with SMTP id 5b1f17b1804b1-436553feef4mr55270855e9.26.1734624681378;
        Thu, 19 Dec 2024 08:11:21 -0800 (PST)
Received: from [127.0.0.1] (amontpellier-556-1-148-206.w109-210.abo.wanadoo.fr. [109.210.4.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b3b295sm57526225e9.33.2024.12.19.08.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 08:11:21 -0800 (PST)
From: Esteban Blanc <eblanc@baylibre.com>
Date: Thu, 19 Dec 2024 17:10:38 +0100
Subject: [PATCH v2 3/6] iio: adc: ad4030: add averaging support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-eblanc-ad4630_v1-v2-3-f36e55907bf5@baylibre.com>
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

This add support for the averaging mode of AD4030 using oversampling IIO
attribute

Signed-off-by: Esteban Blanc <eblanc@baylibre.com>
---
 drivers/iio/adc/ad4030.c | 130 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 114 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index feb98a0fdbeb3e48cd356d817a5dda6d23f5ed3f..ce56a0e8df31097175a31cf9e9664af594807ddf 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -113,6 +113,11 @@ enum ad4030_out_mode {
 	AD4030_OUT_DATA_MD_32_PATTERN
 };
 
+enum {
+	AD4030_SCAN_TYPE_NORMAL,
+	AD4030_SCAN_TYPE_AVG,
+};
+
 struct ad4030_chip_info {
 	const char *name;
 	const unsigned long *available_masks;
@@ -128,10 +133,12 @@ struct ad4030_state {
 	struct spi_device *spi;
 	struct regmap *regmap;
 	const struct ad4030_chip_info *chip;
+	const struct iio_scan_type *current_scan_type;
 	struct gpio_desc *cnv_gpio;
 	int vref_uv;
 	int vio_uv;
 	int offset_avail[3];
+	unsigned int avg_log2;
 	enum ad4030_out_mode mode;
 
 	/*
@@ -185,7 +192,11 @@ struct ad4030_state {
  * - voltage0-voltage1
  * - voltage2-voltage3
  */
-#define AD4030_CHAN_DIFF(_idx, _storage, _real, _shift) {		\
+#define AD4030_CHAN_DIFF(_idx, _scan_type) {				\
+	.info_mask_shared_by_all =					\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
+	.info_mask_shared_by_all_available =				\
+		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE) |		\
 		BIT(IIO_CHAN_INFO_CALIBSCALE) |				\
 		BIT(IIO_CHAN_INFO_CALIBBIAS) |				\
@@ -199,15 +210,16 @@ struct ad4030_state {
 	.channel2 = (_idx) * 2 + 1,					\
 	.scan_index = (_idx),						\
 	.differential = true,						\
-	.scan_type = {							\
-		.sign = 's',						\
-		.storagebits = _storage,				\
-		.realbits = _real,					\
-		.shift = _shift,					\
-		.endianness = IIO_BE,					\
-	},								\
+	.has_ext_scan_type = 1,						\
+	.ext_scan_type = _scan_type,					\
+	.num_ext_scan_type = ARRAY_SIZE(_scan_type),			\
 }
 
+static const int ad4030_average_modes[] = {
+	1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384,
+	32768, 65536
+};
+
 static int ad4030_spi_read(void *context, const void *reg, size_t reg_size,
 			   void *val, size_t val_size)
 {
@@ -433,6 +445,27 @@ static int ad4030_set_chan_calibbias(struct iio_dev *indio_dev,
 				 st->tx_data, AD4030_REG_OFFSET_BYTES_NB);
 }
 
+static int ad4030_set_avg_frame_len(struct iio_dev *dev, int avg_val)
+{
+	struct ad4030_state *st = iio_priv(dev);
+	unsigned int avg_log2 = ilog2(avg_val);
+	unsigned int last_avg_idx = ARRAY_SIZE(ad4030_average_modes) - 1;
+	int ret;
+
+	if (avg_val < 0 || avg_val > ad4030_average_modes[last_avg_idx])
+		return -EINVAL;
+
+	ret = regmap_write(st->regmap, AD4030_REG_AVG,
+			   AD4030_REG_AVG_MASK_AVG_SYNC |
+			   FIELD_PREP(AD4030_REG_AVG_MASK_AVG_VAL, avg_log2));
+	if (ret)
+		return ret;
+
+	st->avg_log2 = avg_log2;
+
+	return 0;
+}
+
 static bool ad4030_is_common_byte_asked(struct ad4030_state *st,
 					unsigned int mask)
 {
@@ -443,11 +476,18 @@ static int ad4030_set_mode(struct iio_dev *indio_dev, unsigned long mask)
 {
 	struct ad4030_state *st = iio_priv(indio_dev);
 
-	if (ad4030_is_common_byte_asked(st, mask))
+	if (st->avg_log2 > 0)
+		st->mode = AD4030_OUT_DATA_MD_30_AVERAGED_DIFF;
+	else if (ad4030_is_common_byte_asked(st, mask))
 		st->mode = AD4030_OUT_DATA_MD_24_DIFF_8_COM;
 	else
 		st->mode = AD4030_OUT_DATA_MD_DIFF;
 
+	st->current_scan_type = iio_get_current_scan_type(indio_dev,
+							  st->chip->channels);
+	if (IS_ERR(st->current_scan_type))
+		return PTR_ERR(st->current_scan_type);
+
 	return regmap_update_bits(st->regmap, AD4030_REG_MODES,
 				AD4030_REG_MODES_MASK_OUT_DATA_MODE,
 				st->mode);
@@ -456,9 +496,11 @@ static int ad4030_set_mode(struct iio_dev *indio_dev, unsigned long mask)
 static int ad4030_conversion(struct iio_dev *indio_dev)
 {
 	struct ad4030_state *st = iio_priv(indio_dev);
-	const struct iio_scan_type scan_type = indio_dev->channels->scan_type;
-	unsigned char diff_realbytes = BITS_TO_BYTES(scan_type.realbits);
+	unsigned char diff_realbytes =
+		BITS_TO_BYTES(st->current_scan_type->realbits);
 	unsigned int bytes_to_read;
+	unsigned long cnv_nb = BIT(st->avg_log2);
+	unsigned int i;
 	int ret;
 
 	/* Number of bytes for one differential channel */
@@ -469,10 +511,12 @@ static int ad4030_conversion(struct iio_dev *indio_dev)
 	/* Mulitiply by the number of hardware channels */
 	bytes_to_read *= st->chip->num_voltage_inputs;
 
-	gpiod_set_value_cansleep(st->cnv_gpio, 1);
-	ndelay(AD4030_TCNVH_NS);
-	gpiod_set_value_cansleep(st->cnv_gpio, 0);
-	ndelay(st->chip->tcyc_ns);
+	for (i = 0; i < cnv_nb; i++) {
+		gpiod_set_value_cansleep(st->cnv_gpio, 1);
+		ndelay(AD4030_TCNVH_NS);
+		gpiod_set_value_cansleep(st->cnv_gpio, 0);
+		ndelay(st->chip->tcyc_ns);
+	}
 
 	ret = spi_read(st->spi, st->rx_data.raw, bytes_to_read);
 	if (ret)
@@ -563,6 +607,12 @@ static int ad4030_read_avail(struct iio_dev *indio_dev,
 		*type = IIO_VAL_INT_PLUS_NANO;
 		return IIO_AVAIL_RANGE;
 
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*vals = ad4030_average_modes;
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(ad4030_average_modes);
+		return IIO_AVAIL_LIST;
+
 	default:
 		return -EINVAL;
 	}
@@ -572,6 +622,8 @@ static int ad4030_read_raw_dispatch(struct iio_dev *indio_dev,
 				    struct iio_chan_spec const *chan, int *val,
 				    int *val2, long info)
 {
+	struct ad4030_state *st = iio_priv(indio_dev);
+
 	switch (info) {
 	case IIO_CHAN_INFO_RAW:
 		return ad4030_single_conversion(indio_dev, chan, val);
@@ -582,6 +634,10 @@ static int ad4030_read_raw_dispatch(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_CALIBBIAS:
 		return ad4030_get_chan_calibbias(indio_dev, chan, val);
 
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*val = BIT(st->avg_log2);
+		return IIO_VAL_INT;
+
 	default:
 		return -EINVAL;
 	}
@@ -620,6 +676,9 @@ static int ad4030_write_raw_dispatch(struct iio_dev *indio_dev,
 			return -EINVAL;
 		return ad4030_set_chan_calibbias(indio_dev, chan, val);
 
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		return ad4030_set_avg_frame_len(indio_dev, val);
+
 	default:
 		return -EINVAL;
 	}
@@ -671,12 +730,21 @@ static int ad4030_read_label(struct iio_dev *indio_dev,
 	return sprintf(label, "common-mode%lu\n", chan->address);
 }
 
+static int ad4030_get_current_scan_type(const struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan)
+{
+	struct ad4030_state *st = iio_priv(indio_dev);
+
+	return st->avg_log2 ? AD4030_SCAN_TYPE_AVG : AD4030_SCAN_TYPE_NORMAL;
+}
+
 static const struct iio_info ad4030_iio_info = {
 	.read_avail = ad4030_read_avail,
 	.read_raw = ad4030_read_raw,
 	.write_raw = ad4030_write_raw,
 	.debugfs_reg_access = ad4030_reg_access,
 	.read_label = ad4030_read_label,
+	.get_current_scan_type = ad4030_get_current_scan_type,
 };
 
 static int ad4030_buffer_preenable(struct iio_dev *indio_dev)
@@ -702,9 +770,22 @@ static int ad4030_buffer_postdisable(struct iio_dev *indio_dev)
 	return ad4030_enter_config_mode(st);
 }
 
+static bool ad4030_validate_scan_mask(struct iio_dev *indio_dev,
+				      const unsigned long *scan_mask)
+{
+	struct ad4030_state *st = iio_priv(indio_dev);
+
+	/* Asking for both common channels and averaging */
+	if (st->avg_log2 && ad4030_is_common_byte_asked(st, *scan_mask))
+		return false;
+
+	return true;
+}
+
 static const struct iio_buffer_setup_ops ad4030_buffer_setup_ops = {
 	.preenable = ad4030_buffer_preenable,
 	.postdisable = ad4030_buffer_postdisable,
+	.validate_scan_mask = ad4030_validate_scan_mask,
 };
 
 static int ad4030_regulators_get(struct ad4030_state *st)
@@ -885,11 +966,28 @@ static const unsigned long ad4030_channel_masks[] = {
 	0,
 };
 
+static const struct iio_scan_type ad4030_24_scan_types[] = {
+	[AD4030_SCAN_TYPE_NORMAL] = {
+		.sign = 's',
+		.storagebits = 32,
+		.realbits = 24,
+		.shift = 8,
+		.endianness = IIO_BE,
+	},
+	[AD4030_SCAN_TYPE_AVG] = {
+		.sign = 's',
+		.storagebits = 32,
+		.realbits = 30,
+		.shift = 2,
+		.endianness = IIO_BE,
+	},
+};
+
 static const struct ad4030_chip_info ad4030_24_chip_info = {
 	.name = "ad4030-24",
 	.available_masks = ad4030_channel_masks,
 	.channels = {
-		AD4030_CHAN_DIFF(0, 32, 24, 8),
+		AD4030_CHAN_DIFF(0, ad4030_24_scan_types),
 		AD4030_CHAN_CMO(1, 0),
 		IIO_CHAN_SOFT_TIMESTAMP(2),
 	},

-- 
2.47.0


