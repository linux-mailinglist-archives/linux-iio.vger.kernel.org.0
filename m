Return-Path: <linux-iio+bounces-14066-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8F3A08017
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2025 19:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B8B3A70ED
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jan 2025 18:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB491ACEB2;
	Thu,  9 Jan 2025 18:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Bkw3mPu0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BDF18DF64
	for <linux-iio@vger.kernel.org>; Thu,  9 Jan 2025 18:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736448454; cv=none; b=YtfWhYyf87+qbhS8uuGq/Zh9yzsVzIMZQHoFMtSjAwEG1RTy7MZ6PxHWZdgsniW/xljE/aXU8u0JiExKr3a723n97bbsIlEOYqUtIA1rRHEYBH5qysvmVles7D0MJn2UhFFdJvTyXUk4+MkSPsWDrRi0b5szYdJBSJBJcwHN9wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736448454; c=relaxed/simple;
	bh=QmH0Jc72rrT2gr4U8hmdsQYBPxGKHbyfRYPHUZgVFqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kMfInh3UbR0OTaEFvxXjMnLiYDOA0v//uGwD9qed8aY2LsJTf8wW+nWgI+xXz9F8abjLwkJ8MB9bUjncIJNTNgWmar26nU92lzF+Zy01OZiGycVjhiuDpoYdA9jiNOp0ICl2hAACqq1U6haTOwV1LAsC5NJr1P3M9ne3/VjglLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Bkw3mPu0; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6dd43aa1558so10797426d6.0
        for <linux-iio@vger.kernel.org>; Thu, 09 Jan 2025 10:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736448449; x=1737053249; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I4KWrfzRSS8QmcuEP2dOjMn5pYIFnCrNTWoZpvWG0b0=;
        b=Bkw3mPu01dur6twEZ9zS9DPq6wi9edgpi5MI1HyJbmjOSimjSwIylzO3WsVkrMGf8/
         vV1u4kLwryAyzjp6ZL9f9b4x0eJzfT+8loxMCdXxU7ByMnN3EYryiqO5DfzM82jRyVPe
         sh5xpkrh0EpZ+N+Nh3wxjGChoDgaxdAQRkfgCczTC+XhP/HnLvTAwk6gMeHJBlV2ItbI
         pJzsfTP0jqNgSqZG3JA3pv7/ed3ad8fGpGT/YCH1sBisihYBQQ1f4LFFp9O2+vdVXYcI
         sFYJTREESTgCFhH8FTxZMlYh8ESs88mUMP6BJF2jKnji0gRUaSFjSdylorO9Sj18pJVq
         t9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736448449; x=1737053249;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4KWrfzRSS8QmcuEP2dOjMn5pYIFnCrNTWoZpvWG0b0=;
        b=ZAORw3T1if7pzLHscOkWEnqaIpV/3sSucKKPjYdICdWlp3G6rT5QGeYR+HSN2ETJ6k
         XHOdrDOAnhiTJdzPBTNMgJdp2BlULHaYC09WMjp8wdSFsiVwecgvYcFEr2yH0jpaXswB
         6/B+zH5kb/KHu/+x/omFK9yoCLbkcud8aYT5HAbfAy4cUEjMqUTHqTTVwK68DFOdwUij
         NlKEFBOcmWENtw+bJHYuX4uFB+iNFT3o7QRdNmP1TItJpasaF7Io+zK7f8ZEK/Dnt8IL
         SmVvRL4TrmAOe01IDoTm/Fl8n/A2Hp8b71pOmAv/RARfulVWIKCB2R6faEYljbBQUSIR
         Va7w==
X-Gm-Message-State: AOJu0YwAEP0VekHvppqs9CgQC3cu7vf8lBA7DHFCmIz17w1vEx4F9tXD
	cSXPDTdj3RZSbVDZfyQpxVMWuyqFSf3KV5vO2wy2G2qUfiYMtVxLJM8MoFnKHcQ=
X-Gm-Gg: ASbGncs5hVf/auNJgTCaU/tRf9In8/qkrCWn5e3Na1aPyv8cR2PtKvWOLPoSrb7ABt2
	BY3a+cNnVpun4RP6ls2DjA6pJS78FHKjVKpX7XFwzDkT0v01Aa7bsPXHnDYJ4L8QdmboSAc/uV/
	NuoMMdqdcURX89Pk8rTpQQHKkBS/iaMmFl4m6uG8auDRSpzw5yv+nKBqM/UxLvg8K8i+ng2bIzX
	gE39yx9DQkXBh+QMLa5q8/VyNU/XAhTnY0fgdj99LE7ArPR1lnI0fZaTIHMdL+4V9dFyjz0YXDr
	InpmOROf4JquC0oZ
X-Google-Smtp-Source: AGHT+IFkFyuADZbI3PqrkCFeUDbWGNEMMmwFHP8Y+Tm72cLSBIcumS6DBEJQQEH2hMfwS4zT11E+7w==
X-Received: by 2002:ad4:5d61:0:b0:6d8:916b:1caa with SMTP id 6a1803df08f44-6df9b254201mr132489596d6.27.1736448449401;
        Thu, 09 Jan 2025 10:47:29 -0800 (PST)
Received: from localhost (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dfade72af8sm1062836d6.75.2025.01.09.10.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 10:47:27 -0800 (PST)
From: Trevor Gamblin <tgamblin@baylibre.com>
Date: Thu, 09 Jan 2025 13:47:23 -0500
Subject: [PATCH v2 1/2] iio: adc: ad4695: add offload-based oversampling
 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250109-ad4695-oversampling-v2-1-a46ac487082c@baylibre.com>
References: <20250109-ad4695-oversampling-v2-0-a46ac487082c@baylibre.com>
In-Reply-To: <20250109-ad4695-oversampling-v2-0-a46ac487082c@baylibre.com>
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
 drivers/iio/adc/ad4695.c | 333 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 303 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index c8cd73d19e86..0caaeaa310ed 100644
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
@@ -1072,12 +1198,69 @@ static int ad4695_write_raw_get_fmt(struct iio_dev *indio_dev,
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
+	int val_calc, scale;
+
+	switch (osr) {
+	case 4:
+		scale = 4;
+		break;
+	case 16:
+		scale = 2;
+		break;
+	case 64:
+		scale = 1;
+		break;
+	default:
+		scale = 8;
+		break;
+	}
+
+	val = clamp_t(int, val, S32_MIN / 8, S32_MAX / 8);
+
+	/* val2 range is (-MICRO, MICRO) if val == 0, otherwise [0, MICRO) */
+	if (val < 0)
+		val_calc = val * scale - val2 * scale / MICRO;
+	else if (val2 < 0)
+		/* if val2 < 0 then val == 0 */
+		val_calc = val2 * scale / (int)MICRO;
+	else
+		val_calc = val * scale + val2 * scale / MICRO;
+
+	val_calc /= 2;
+
+	return clamp_t(int, val_calc, S16_MIN, S16_MAX);
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
@@ -1102,23 +1285,7 @@ static int ad4695_write_raw(struct iio_dev *indio_dev,
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
@@ -1127,15 +1294,27 @@ static int ad4695_write_raw(struct iio_dev *indio_dev,
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
@@ -1148,18 +1327,40 @@ static int ad4695_read_avail(struct iio_dev *indio_dev,
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
@@ -1174,16 +1375,36 @@ static int ad4695_read_avail(struct iio_dev *indio_dev,
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
@@ -1217,6 +1438,26 @@ static int ad4695_debugfs_reg_access(struct iio_dev *indio_dev,
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
@@ -1225,6 +1466,15 @@ static const struct iio_info ad4695_info = {
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
@@ -1240,6 +1490,9 @@ static int ad4695_parse_channel_cfg(struct ad4695_state *st)
 		chan_cfg->highz_en = true;
 		chan_cfg->channel = i;
 
+		/* This is the default OSR after reset */
+		chan_cfg->oversampling_ratio = 1;
+
 		*iio_chan = ad4695_channel_template;
 		iio_chan->channel = i;
 		iio_chan->scan_index = i;
@@ -1408,6 +1661,7 @@ static int ad4695_probe_spi_offload(struct iio_dev *indio_dev,
 	struct dma_chan *rx_dma;
 	int ret, i;
 
+	indio_dev->info = &ad4695_offload_info;
 	indio_dev->num_channels = st->chip_info->num_voltage_inputs + 1;
 	indio_dev->setup_ops = &ad4695_offload_buffer_setup_ops;
 
@@ -1458,6 +1712,7 @@ static int ad4695_probe_spi_offload(struct iio_dev *indio_dev,
 
 	for (i = 0; i < indio_dev->num_channels; i++) {
 		struct iio_chan_spec *chan = &st->iio_chan[i];
+		struct ad4695_channel_config *cfg = &st->channels_cfg[i];
 
 		/*
 		 * NB: When using offload support, all channels need to have the
@@ -1473,6 +1728,24 @@ static int ad4695_probe_spi_offload(struct iio_dev *indio_dev,
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


