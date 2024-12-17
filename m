Return-Path: <linux-iio+bounces-13592-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EEF9F591F
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2024 22:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2867E166625
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2024 21:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A82E1FA829;
	Tue, 17 Dec 2024 21:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oW9z13v9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706951F7580
	for <linux-iio@vger.kernel.org>; Tue, 17 Dec 2024 21:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734472055; cv=none; b=KPiA0K+30qdmybBytNgzX8nVzD4yK2Qg6GgvWe1HwfG3lv5it8E/jm3mdbTGfGFpgeIRlV7EFTXd1hTf2gLxOKGu0i0tnCDqP4VVwwhNwnUB/x7eCC509w2PrzdO9kJtMP0fekGJ1vqWa192kY7JaK4A46sfu4w1CIKgOsuW054=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734472055; c=relaxed/simple;
	bh=oqeFL/ORw+ie3t+bRwC79nTIAlXNo835EkKO/tgfc5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WI3xI3PhKFQ2rv8ZzBRt7NgTZdu9z2aVtsi42SV/aJpHbk0V3nZ+yqFVTRQbDaA8mPDeqqA44WxkYOc0vZFuuvo1Oe5OrKRHibFL5/lwwdltXDNn3WwStFn8ukGZoCeVC9rCLnQf01MCWt5wuQ/9hhAwc4UJSpoVA87+ksi+qMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oW9z13v9; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4679d366adeso1365891cf.1
        for <linux-iio@vger.kernel.org>; Tue, 17 Dec 2024 13:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734472052; x=1735076852; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HmKQKY1UbOy/SYoiYy7M4hB5/sLUFqaMhAPy26EnFkc=;
        b=oW9z13v9nFSOcraZlS7j0nRCxDFS0Knvz7E5fJfLUBCkJxdcMD9N3o6ZCWMHOi6ahZ
         njLlr524jSfx9d1ZLPwCDA0D0uO6gFRtQ65x9+KA0wkkUSn1Oqa+Skzb+qwgW+AbVLjx
         Gl29ghOyTy3VWuR8ibpr8RDGL8dYXNYlT5ONOk4Vqepdk81vO9+0ljIP6enR2Pu5QKSg
         96s/Xqz9w/lSlUmaBXYuGm4M6XF1hNvp12l9PV0wQEOc6Eer/peRSXl0fIlEUJknE4R4
         GrsnyyLgAcZog8Y85w+4aWzfXYrA0WHR4+5LTfagtymImwVX/Z6+P664dKXzdNljAakG
         JXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734472052; x=1735076852;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HmKQKY1UbOy/SYoiYy7M4hB5/sLUFqaMhAPy26EnFkc=;
        b=to1GPM04nyoBcS4Lu2D5NcRh93QymfBkjVWXMNRt7icoqAzDB6KbGy5igkZvf0xGSy
         tIg81CUxHxkJLCmbKmCKAgELu2PVSyitg9Kh3bPvYFm47V3xi/48JZKyCQt9L2c5GeDH
         NVcBmJH6QGZhbXzolPpTw2eXs+ihfsZB5VjOlSrXRaH8PElIDbfpEE/rtLmiXjRmWjco
         Fh6fY0iZMiLdQBbfGoM89WmmAFkYX9o2wFY6ZV0JB3BkpZRXfTL60LqR8CMT59/BLVXb
         Nbg2nM+e4AjknOSWBniMpyP6bHXC6s30VtCM4HSy74qaQsrSe2uuW0VAdpcImdMDWnD2
         y6eg==
X-Gm-Message-State: AOJu0Yz6u4JZHjcF/LRA/i1Q4Fl/vhAIDvps/HbeGsk0LMXhIhG1FD19
	Enpsjposvt2BL9+ORkeAqlVRxUsAQk0TREvfSSZ3bsaD2IeqmEDEKjhXU3M4jWI=
X-Gm-Gg: ASbGncu7DYwOPJQo35lgx1Uq62f41Rusazomgqc4xnuO0dkFff432ovHf5MwlID74IQ
	r3+4o7lMN97zqHX1fZUCOaItyqzMEZcFmg86rDHTdcpTch8NoMB4d9GiEzeTmeqL+wGLFGXtiNz
	PsR0gl5C/m/06O2qzO+qeUomx6Tw8z1ngdqcq6jTg7YoBWfvGvXdfWCZYZu6HzY1Rbzq+skE/3p
	JMp+ezFFKSc70KaNS+S49EAkotqUQX18lyt7JQrT6zk4GsvbyO5Y0bKfugphAl4+G6d/2ES7WrG
	1hyb8u7EFTlPptk2
X-Google-Smtp-Source: AGHT+IHVte31Gj67biWkHxDzyWnTTL0jqqRuzWN4Ql8MYbOrKsQvNiHhcUz+ygxkU9R5WWHSyqX3/A==
X-Received: by 2002:ac8:580d:0:b0:467:6a8d:e01d with SMTP id d75a77b69052e-469090a8af3mr7124131cf.18.1734472052285;
        Tue, 17 Dec 2024 13:47:32 -0800 (PST)
Received: from localhost (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2ca087esm43783041cf.28.2024.12.17.13.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 13:47:31 -0800 (PST)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Tue, 17 Dec 2024 16:47:28 -0500
Subject: [PATCH 1/2] iio: adc: ad4695: add offload-based oversampling
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241217-ad4695-oversampling-v1-1-0b045d835dac@baylibre.com>
References: <20241217-ad4695-oversampling-v1-0-0b045d835dac@baylibre.com>
In-Reply-To: <20241217-ad4695-oversampling-v1-0-0b045d835dac@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.14.1

Add support for the ad4695's oversampling feature when SPI offload is
available. This allows the ad4695 to set oversampling ratios on a
per-channel basis, raising the effective-number-of-bits from 16
(OSR == 1) to 17 (4), 18 (16), or 19 (64) for a given sample (i.e. one
full cycle through the auto-sequencer). The logic for reading and
writing sampling frequency for a given channel is also adjusted based on
the current oversampling ratio.

The non-offload case isn't supported as there isn't a good way to
trigger the CNV pin in this mode. Support could be added in the future
if a use-case arises.

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/iio/adc/ad4695.c | 378 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 348 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index c8cd73d19e86..320f2c1a0877 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -79,6 +79,7 @@
 #define   AD4695_REG_CONFIG_IN_MODE			  BIT(6)
 #define   AD4695_REG_CONFIG_IN_PAIR			  GENMASK(5, 4)
 #define   AD4695_REG_CONFIG_IN_AINHIGHZ_EN		  BIT(3)
+#define   AD4695_REG_CONFIG_IN_OSR_SET			  GENMASK(1, 0)
 #define AD4695_REG_UPPER_IN(n)				(0x0040 | (2 * (n)))
 #define AD4695_REG_LOWER_IN(n)				(0x0060 | (2 * (n)))
 #define AD4695_REG_HYST_IN(n)				(0x0080 | (2 * (n)))
@@ -127,6 +128,7 @@ struct ad4695_channel_config {
 	bool bipolar;
 	enum ad4695_in_pair pin_pairing;
 	unsigned int common_mode_mv;
+	unsigned int oversampling_ratio;
 };
 
 struct ad4695_state {
@@ -306,6 +308,65 @@ static const struct regmap_bus ad4695_regmap_bus = {
 	.val_format_endian_default = REGMAP_ENDIAN_BIG,
 };
 
+enum {
+	AD4695_SCAN_TYPE_OSR_1,
+	AD4695_SCAN_TYPE_OSR_4,
+	AD4695_SCAN_TYPE_OSR_16,
+	AD4695_SCAN_TYPE_OSR_64,
+};
+
+static const struct iio_scan_type ad4695_scan_type_offload_u[] = {
+	[AD4695_SCAN_TYPE_OSR_1] = {
+		.sign = 'u',
+		.realbits = 16,
+		.shift = 3,
+		.storagebits = 32,
+	},
+	[AD4695_SCAN_TYPE_OSR_4] = {
+		.sign = 'u',
+		.realbits = 17,
+		.shift = 2,
+		.storagebits = 32,
+	},
+	[AD4695_SCAN_TYPE_OSR_16] = {
+		.sign = 'u',
+		.realbits = 18,
+		.shift = 1,
+		.storagebits = 32,
+	},
+	[AD4695_SCAN_TYPE_OSR_64] = {
+		.sign = 'u',
+		.realbits = 19,
+		.storagebits = 32,
+	},
+};
+
+static const struct iio_scan_type ad4695_scan_type_offload_s[] = {
+	[AD4695_SCAN_TYPE_OSR_1] = {
+		.sign = 's',
+		.realbits = 16,
+		.shift = 3,
+		.storagebits = 32,
+	},
+	[AD4695_SCAN_TYPE_OSR_4] = {
+		.sign = 's',
+		.realbits = 17,
+		.shift = 2,
+		.storagebits = 32,
+	},
+	[AD4695_SCAN_TYPE_OSR_16] = {
+		.sign = 's',
+		.realbits = 18,
+		.shift = 1,
+		.storagebits = 32,
+	},
+	[AD4695_SCAN_TYPE_OSR_64] = {
+		.sign = 's',
+		.realbits = 19,
+		.storagebits = 32,
+	},
+};
+
 static const struct iio_chan_spec ad4695_channel_template = {
 	.type = IIO_VOLTAGE,
 	.indexed = 1,
@@ -343,6 +404,10 @@ static const char * const ad4695_power_supplies[] = {
 	"avdd", "vio"
 };
 
+static const int ad4695_oversampling_ratios[] = {
+	1, 4, 16, 64,
+};
+
 static const struct ad4695_chip_info ad4695_chip_info = {
 	.name = "ad4695",
 	.max_sample_rate = 500 * KILO,
@@ -519,6 +584,29 @@ static int ad4695_set_ref_voltage(struct ad4695_state *st, int vref_mv)
 				  FIELD_PREP(AD4695_REG_REF_CTRL_VREF_SET, val));
 }
 
+/**
+ * ad4695_osr_to_regval - convert ratio to OSR register value
+ * @ratio: ratio to check
+ *
+ * Check if ratio is present in the list of available ratios and return
+ * the corresponding value that needs to be written to the register to
+ * select that ratio.
+ *
+ * Returns: register value (0 to 3) or -EINVAL if there is not an exact
+ * match
+ */
+static int ad4695_osr_to_regval(int ratio)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ad4695_oversampling_ratios); i++) {
+		if (ratio == ad4695_oversampling_ratios[i])
+			return i;
+	}
+
+	return -EINVAL;
+}
+
 static int ad4695_write_chn_cfg(struct ad4695_state *st,
 				struct ad4695_channel_config *cfg)
 {
@@ -945,10 +1033,18 @@ static int ad4695_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long mask)
 {
 	struct ad4695_state *st = iio_priv(indio_dev);
+	const struct iio_scan_type *scan_type;
 	struct ad4695_channel_config *cfg = &st->channels_cfg[chan->scan_index];
-	u8 realbits = chan->scan_type.realbits;
+	unsigned int osr = st->channels_cfg[chan->scan_index].oversampling_ratio;
 	unsigned int reg_val;
 	int ret, tmp;
+	u8 realbits;
+
+	scan_type = iio_get_current_scan_type(indio_dev, chan);
+	if (IS_ERR(scan_type))
+		return PTR_ERR(scan_type);
+
+	realbits = scan_type->realbits;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -957,7 +1053,7 @@ static int ad4695_read_raw(struct iio_dev *indio_dev,
 			if (ret)
 				return ret;
 
-			if (chan->scan_type.sign == 's')
+			if (scan_type->sign == 's')
 				*val = sign_extend32(st->raw_data, realbits - 1);
 			else
 				*val = st->raw_data;
@@ -969,7 +1065,7 @@ static int ad4695_read_raw(struct iio_dev *indio_dev,
 		switch (chan->type) {
 		case IIO_VOLTAGE:
 			*val = st->vref_mv;
-			*val2 = chan->scan_type.realbits;
+			*val2 = realbits;
 			return IIO_VAL_FRACTIONAL_LOG2;
 		case IIO_TEMP:
 			/* T_scale (°C) = raw * V_REF (mV) / (-1.8 mV/°C * 2^16) */
@@ -1030,8 +1126,26 @@ static int ad4695_read_raw(struct iio_dev *indio_dev,
 
 				tmp = sign_extend32(reg_val, 15);
 
-				*val = tmp / 4;
-				*val2 = abs(tmp) % 4 * MICRO / 4;
+				switch (cfg->oversampling_ratio) {
+				case 1:
+					*val = tmp / 4;
+					*val2 = abs(tmp) % 4 * MICRO / 4;
+					break;
+				case 4:
+					*val = tmp / 2;
+					*val2 = abs(tmp) % 2 * MICRO / 2;
+					break;
+				case 16:
+					*val = tmp;
+					*val2 = 0;
+					break;
+				case 64:
+					*val = tmp * 2;
+					*val2 = 0;
+					break;
+				default:
+					return -EINVAL;
+				}
 
 				if (tmp < 0 && *val2) {
 					*val *= -1;
@@ -1044,6 +1158,14 @@ static int ad4695_read_raw(struct iio_dev *indio_dev,
 		default:
 			return -EINVAL;
 		}
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			*val = st->channels_cfg[chan->scan_index].oversampling_ratio;
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
 	case IIO_CHAN_INFO_SAMP_FREQ: {
 		struct pwm_state state;
 
@@ -1051,7 +1173,11 @@ static int ad4695_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
-		*val = DIV_ROUND_UP_ULL(NSEC_PER_SEC, state.period);
+		/*
+		 * The effective sampling frequency for a channel is the input
+		 * frequency divided by the channel's OSR value.
+		 */
+		*val = DIV_ROUND_UP_ULL(NSEC_PER_SEC, state.period * osr);
 
 		return IIO_VAL_INT;
 	}
@@ -1072,12 +1198,114 @@ static int ad4695_write_raw_get_fmt(struct iio_dev *indio_dev,
 	}
 }
 
+static int ad4695_set_osr_val(struct ad4695_state *st,
+			      struct iio_chan_spec const *chan,
+			      int val)
+{
+	int osr = ad4695_osr_to_regval(val);
+
+	if (osr < 0)
+		return osr;
+
+	switch (chan->type) {
+	case IIO_VOLTAGE:
+		st->channels_cfg[chan->scan_index].oversampling_ratio = val;
+		return regmap_update_bits(st->regmap,
+				AD4695_REG_CONFIG_IN(chan->scan_index),
+				AD4695_REG_CONFIG_IN_OSR_SET,
+				FIELD_PREP(AD4695_REG_CONFIG_IN_OSR_SET, osr));
+	default:
+		return -EINVAL;
+	}
+}
+
+static unsigned int ad4695_get_calibbias(int val, int val2, int osr)
+{
+	unsigned int reg_val;
+
+	switch (osr) {
+	case 4:
+		if (val2 >= 0 && val > S16_MAX / 2)
+			reg_val = S16_MAX;
+		else if ((val2 < 0 ? -val : val) < S16_MIN / 2)
+			reg_val = S16_MIN;
+		else if (val2 < 0)
+			reg_val = clamp_t(int,
+				-(val * 2 + -val2 * 2 / MICRO),
+				S16_MIN, S16_MAX);
+		else if (val < 0)
+			reg_val = clamp_t(int,
+				val * 2 - val2 * 2 / MICRO,
+				S16_MIN, S16_MAX);
+		else
+			reg_val = clamp_t(int,
+				val * 2 + val2 * 2 / MICRO,
+				S16_MIN, S16_MAX);
+		return reg_val;
+	case 16:
+		if (val2 >= 0 && val > S16_MAX)
+			reg_val = S16_MAX;
+		else if ((val2 < 0 ? -val : val) < S16_MIN)
+			reg_val = S16_MIN;
+		else if (val2 < 0)
+			reg_val = clamp_t(int,
+				-(val + -val2 / MICRO),
+				S16_MIN, S16_MAX);
+		else if (val < 0)
+			reg_val = clamp_t(int,
+				val - val2 / MICRO,
+				S16_MIN, S16_MAX);
+		else
+			reg_val = clamp_t(int,
+				val + val2 / MICRO,
+				S16_MIN, S16_MAX);
+		return reg_val;
+	case 64:
+		if (val2 >= 0 && val > S16_MAX * 2)
+			reg_val = S16_MAX;
+		else if ((val2 < 0 ? -val : val) < S16_MIN * 2)
+			reg_val = S16_MIN;
+		else if (val2 < 0)
+			reg_val = clamp_t(int,
+				-(val / 2 + -val2 / 2 / MICRO),
+				S16_MIN, S16_MAX);
+		else if (val < 0)
+			reg_val = clamp_t(int,
+				val / 2 - val2 / 2 / MICRO,
+				S16_MIN, S16_MAX);
+		else
+			reg_val = clamp_t(int,
+				val / 2 + val2 / 2 / MICRO,
+				S16_MIN, S16_MAX);
+		return reg_val;
+	default:
+		if (val2 >= 0 && val > S16_MAX / 4)
+			reg_val = S16_MAX;
+		else if ((val2 < 0 ? -val : val) < S16_MIN / 4)
+			reg_val = S16_MIN;
+		else if (val2 < 0)
+			reg_val = clamp_t(int,
+				-(val * 4 + -val2 * 4 / MICRO),
+				S16_MIN, S16_MAX);
+		else if (val < 0)
+			reg_val = clamp_t(int,
+				val * 4 - val2 * 4 / MICRO,
+				S16_MIN, S16_MAX);
+		else
+			reg_val = clamp_t(int,
+				val * 4 + val2 * 4 / MICRO,
+				S16_MIN, S16_MAX);
+		return reg_val;
+	}
+}
+
 static int ad4695_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int val, int val2, long mask)
 {
 	struct ad4695_state *st = iio_priv(indio_dev);
 	unsigned int reg_val;
+	unsigned int osr = st->channels_cfg[chan->scan_index].oversampling_ratio;
 
 	iio_device_claim_direct_scoped(return -EBUSY, indio_dev) {
 		switch (mask) {
@@ -1102,23 +1330,7 @@ static int ad4695_write_raw(struct iio_dev *indio_dev,
 		case IIO_CHAN_INFO_CALIBBIAS:
 			switch (chan->type) {
 			case IIO_VOLTAGE:
-				if (val2 >= 0 && val > S16_MAX / 4)
-					reg_val = S16_MAX;
-				else if ((val2 < 0 ? -val : val) < S16_MIN / 4)
-					reg_val = S16_MIN;
-				else if (val2 < 0)
-					reg_val = clamp_t(int,
-						-(val * 4 + -val2 * 4 / MICRO),
-						S16_MIN, S16_MAX);
-				else if (val < 0)
-					reg_val = clamp_t(int,
-						val * 4 - val2 * 4 / MICRO,
-						S16_MIN, S16_MAX);
-				else
-					reg_val = clamp_t(int,
-						val * 4 + val2 * 4 / MICRO,
-						S16_MIN, S16_MAX);
-
+				reg_val = ad4695_get_calibbias(val, val2, osr);
 				return regmap_write(st->regmap16,
 					AD4695_REG_OFFSET_IN(chan->scan_index),
 					reg_val);
@@ -1127,15 +1339,27 @@ static int ad4695_write_raw(struct iio_dev *indio_dev,
 			}
 		case IIO_CHAN_INFO_SAMP_FREQ: {
 			struct pwm_state state;
-
-			if (val <= 0 || val > st->chip_info->max_sample_rate)
+			/*
+			 * Limit the maximum acceptable sample rate according to
+			 * the channel's oversampling ratio.
+			 */
+			u64 max_osr_rate = DIV_ROUND_UP_ULL(st->chip_info->max_sample_rate,
+							    osr);
+
+			if (val <= 0 || val > max_osr_rate)
 				return -EINVAL;
 
 			guard(mutex)(&st->cnv_pwm_lock);
 			pwm_get_state(st->cnv_pwm, &state);
-			state.period = DIV_ROUND_UP_ULL(NSEC_PER_SEC, val);
+			/*
+			 * The required sample frequency for a given OSR is the
+			 * input frequency multiplied by it.
+			 */
+			state.period = DIV_ROUND_UP_ULL(NSEC_PER_SEC, val * osr);
 			return pwm_apply_might_sleep(st->cnv_pwm, &state);
 		}
+		case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+			return ad4695_set_osr_val(st, chan, val);
 		default:
 			return -EINVAL;
 		}
@@ -1148,18 +1372,40 @@ static int ad4695_read_avail(struct iio_dev *indio_dev,
 			     const int **vals, int *type, int *length,
 			     long mask)
 {
+	int ret;
 	static const int ad4695_calibscale_available[6] = {
 		/* Range of 0 (inclusive) to 2 (exclusive) */
 		0, 15, 1, 15, U16_MAX, 15
 	};
-	static const int ad4695_calibbias_available[6] = {
+	static const int ad4695_calibbias_available[4][6] = {
 		/*
 		 * Datasheet says FSR/8 which translates to signed/4. The step
-		 * depends on oversampling ratio which is always 1 for now.
+		 * depends on oversampling ratio, so we need four different
+		 * ranges to select from.
 		 */
-		S16_MIN / 4, 0, 0, MICRO / 4, S16_MAX / 4, S16_MAX % 4 * MICRO / 4
+		{
+			S16_MIN / 4, 0,
+			0, MICRO / 4,
+			S16_MAX / 4, S16_MAX % 4 * MICRO / 4
+		},
+		{
+			S16_MIN / 2, 0,
+			0, MICRO / 2,
+			S16_MAX / 2, S16_MAX % 2 * MICRO / 2,
+		},
+		{
+			S16_MIN, 0,
+			1, 0,
+			S16_MAX, 0,
+		},
+		{
+			S16_MIN * 2, 0,
+			2, 0,
+			S16_MAX * 2, 0,
+		},
 	};
 	struct ad4695_state *st = iio_priv(indio_dev);
+	unsigned int osr = st->channels_cfg[chan->scan_index].oversampling_ratio;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBSCALE:
@@ -1174,16 +1420,36 @@ static int ad4695_read_avail(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_CALIBBIAS:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
-			*vals = ad4695_calibbias_available;
+			ret = ad4695_osr_to_regval(osr);
+			if (ret < 0)
+				return ret;
+			/*
+			 * Select the appropriate calibbias array based on the
+			 * OSR value in the register.
+			 */
+			*vals = ad4695_calibbias_available[ret];
 			*type = IIO_VAL_INT_PLUS_MICRO;
 			return IIO_AVAIL_RANGE;
 		default:
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_SAMP_FREQ:
+		/* Max sample rate for the channel depends on OSR */
+		st->sample_freq_range[2] =
+			DIV_ROUND_UP_ULL(st->chip_info->max_sample_rate, osr);
 		*vals = st->sample_freq_range;
 		*type = IIO_VAL_INT;
 		return IIO_AVAIL_RANGE;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			*vals = ad4695_oversampling_ratios;
+			*length = ARRAY_SIZE(ad4695_oversampling_ratios);
+			*type = IIO_VAL_INT;
+			return IIO_AVAIL_LIST;
+		default:
+			return -EINVAL;
+		}
 	default:
 		return -EINVAL;
 	}
@@ -1217,6 +1483,26 @@ static int ad4695_debugfs_reg_access(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int ad4695_get_current_scan_type(const struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan)
+{
+	struct ad4695_state *st = iio_priv(indio_dev);
+	unsigned int osr = st->channels_cfg[chan->scan_index].oversampling_ratio;
+
+	switch (osr) {
+	case 1:
+		return AD4695_SCAN_TYPE_OSR_1;
+	case 4:
+		return AD4695_SCAN_TYPE_OSR_4;
+	case 16:
+		return AD4695_SCAN_TYPE_OSR_16;
+	case 64:
+		return AD4695_SCAN_TYPE_OSR_64;
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct iio_info ad4695_info = {
 	.read_raw = &ad4695_read_raw,
 	.write_raw_get_fmt = &ad4695_write_raw_get_fmt,
@@ -1225,6 +1511,15 @@ static const struct iio_info ad4695_info = {
 	.debugfs_reg_access = &ad4695_debugfs_reg_access,
 };
 
+static const struct iio_info ad4695_offload_info = {
+	.read_raw = &ad4695_read_raw,
+	.write_raw_get_fmt = &ad4695_write_raw_get_fmt,
+	.write_raw = &ad4695_write_raw,
+	.get_current_scan_type = &ad4695_get_current_scan_type,
+	.read_avail = &ad4695_read_avail,
+	.debugfs_reg_access = &ad4695_debugfs_reg_access,
+};
+
 static int ad4695_parse_channel_cfg(struct ad4695_state *st)
 {
 	struct device *dev = &st->spi->dev;
@@ -1240,6 +1535,9 @@ static int ad4695_parse_channel_cfg(struct ad4695_state *st)
 		chan_cfg->highz_en = true;
 		chan_cfg->channel = i;
 
+		/* This is the default OSR after reset */
+		chan_cfg->oversampling_ratio = 1;
+
 		*iio_chan = ad4695_channel_template;
 		iio_chan->channel = i;
 		iio_chan->scan_index = i;
@@ -1408,6 +1706,7 @@ static int ad4695_probe_spi_offload(struct iio_dev *indio_dev,
 	struct dma_chan *rx_dma;
 	int ret, i;
 
+	indio_dev->info = &ad4695_offload_info;
 	indio_dev->num_channels = st->chip_info->num_voltage_inputs + 1;
 	indio_dev->setup_ops = &ad4695_offload_buffer_setup_ops;
 
@@ -1458,6 +1757,7 @@ static int ad4695_probe_spi_offload(struct iio_dev *indio_dev,
 
 	for (i = 0; i < indio_dev->num_channels; i++) {
 		struct iio_chan_spec *chan = &st->iio_chan[i];
+		struct ad4695_channel_config *cfg = &st->channels_cfg[i];
 
 		/*
 		 * NB: When using offload support, all channels need to have the
@@ -1473,6 +1773,24 @@ static int ad4695_probe_spi_offload(struct iio_dev *indio_dev,
 		/* add sample frequency for PWM CNV trigger */
 		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_SAMP_FREQ);
 		chan->info_mask_separate_available |= BIT(IIO_CHAN_INFO_SAMP_FREQ);
+
+		/* Add the oversampling properties only for voltage channels */
+		if (chan->type != IIO_VOLTAGE)
+			continue;
+
+		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
+		chan->info_mask_separate_available |=
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO);
+		chan->has_ext_scan_type = 1;
+		if (cfg->bipolar) {
+			chan->ext_scan_type = ad4695_scan_type_offload_s;
+			chan->num_ext_scan_type =
+				ARRAY_SIZE(ad4695_scan_type_offload_s);
+		} else {
+			chan->ext_scan_type = ad4695_scan_type_offload_u;
+			chan->num_ext_scan_type =
+				ARRAY_SIZE(ad4695_scan_type_offload_u);
+		}
 	}
 
 	return devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev,

-- 
2.39.5


