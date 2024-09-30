Return-Path: <linux-iio+bounces-9924-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF2A989EB5
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 11:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F45A1F21C9A
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 09:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3685E183094;
	Mon, 30 Sep 2024 09:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlG8/t4X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3388C127E18;
	Mon, 30 Sep 2024 09:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727689824; cv=none; b=nNe6qqaKOLyQpap7FjSX3ezCs7hQW+TgLlBHzBoTKadFiwPVv8vVS+zWV2Zf5dMn8I3wtiErltq1LqkywtMiCbZIvITXZ6kQbDflzNeGpezw9nBQQxI84Ebcu2zCbU+j1gMeW5VATqqJZprL6nfm5300Tl8nt0hG8DqYvcht7gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727689824; c=relaxed/simple;
	bh=RkPdMvgxUkFqhbWB3a5Cj3yEHJr9T7dZ4+X8m+qY4Y8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qNtsufYADI/2RQDoAcK0RnZWmriYkkGJRFavIRNte3uTN38xC+x+MYjRhBzkYuoKVpLNMkDt0frX1w8vqsHkuh77I/gb/0feN6F2iAIcSGcuFehoSoDOODxfOUuivkultAoGBBwBIcD7K9ollYCZUGG9+oj9LPNjNi/fSqPXcSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UlG8/t4X; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37cdbcb139cso1815773f8f.1;
        Mon, 30 Sep 2024 02:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727689820; x=1728294620; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+24eqgbghlUvwu7rO9VSuPnaXx5QsjTjmV1Ldlr6nbo=;
        b=UlG8/t4XzY3B3qimdTvu0EAXpQ1AZ+71xZfaRAlFn/xB9sl4DR2p2yddWKRz9sBtV8
         ESE67ruLSa5nBLohIG58hZJSWx9t5HqfazelTtdWp9As+rj1RHS5p0RT0x1Qwj0KR6pd
         +GNRgYQXNCCrSWe+0WZKaGpFXyUrYdn3Dzj2ghLFIrN2NaN1U/Hy10zw73kLMIQT6lLg
         yseQvAziJNJVZNlttbSGbym93E/Um+O1DLBXuVEy4fQ2iEl29pPK1ouxhlvaVmFfrnQ7
         UCt+zcL0t5Ve2io8b4ZJiIMIKhrN2BRydMJgs+aU48H7Tgzgy4XITj7NU5SclX1wLXmm
         au2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727689820; x=1728294620;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+24eqgbghlUvwu7rO9VSuPnaXx5QsjTjmV1Ldlr6nbo=;
        b=JeYA8Z2cve+D2S240oCO6R7DixnoHYcf/m9m5vFpw7sNWUSlp249KPgtp3ykvOwrzG
         J3t7kq1phgQLH236yYmap02P6vJdBIin93nummel1npBcncOIuX4DRkKzZOcO7HFzrh1
         R+0WRYpjr1T+yVHJM5ZFQoYt/3u8hMEZvAK/HDYvSewQBfEPW27CRmSf4UOUV6h0wPHj
         R0yEHRIrk+4bXrImAgdxaTjjiCEeSMi/cHz7fIdn1PBgP8Z3Emz5qqxo+86hJNMlKcos
         9EL6MHyqIVlsLLU0Z6hgUozYL3TmrBkyyjyCsuzytaBK/1+Q9krmptZDyJgUrHAG/GbB
         EjbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTJtX11co3Kd0Ge2YqRu3+FbMUA+aA5lhDNAIellUhcDWVdeRm5HLZgff9PYTnbawctAPQ0lu0nWw=@vger.kernel.org, AJvYcCXZy7uPrSXoyy0jrk39WDFdKSWZE3sEKvtmiJ2b0uape3Ps1tJbe0++EUuHC+75JxHPkbHvzkPqsa9LOX7L@vger.kernel.org
X-Gm-Message-State: AOJu0YxhJIR/uduCiqHD5SPCPHUtR5CY/NkDMfHaN96lVWOKXDMstavh
	x1xtxTeoyR8KbTI9meFlT4vPhTPmxG8aVf0C1jvrUJs2D6wopvPl810QkWir
X-Google-Smtp-Source: AGHT+IGMfUFmmh4VDla9csdFOl/WebCI3oO+veH9mD+PtuVxOajo9RidxUIHKg2xbivye8/yc3Axaw==
X-Received: by 2002:a05:6000:d:b0:368:445e:91cc with SMTP id ffacd0b85a97d-37cd5a7ae9bmr6179603f8f.21.1727689820178;
        Mon, 30 Sep 2024 02:50:20 -0700 (PDT)
Received: from localhost (host-79-19-52-27.retail.telecomitalia.it. [79.19.52.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a36760sm145896985e9.30.2024.09.30.02.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 02:50:19 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Mon, 30 Sep 2024 11:49:01 +0200
Subject: [PATCH v2] iio: pac1921: remove unnecessary explicit casts
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240930-iio-pac1921-nocast-v2-1-cc349e137f75@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAx0+mYC/22NQQqDMBBFryKz7pRMWqXpynsUF2EcdaAaSURax
 Ls3Fbrr8j3472+QJKokuBcbRFk1aZgy2FMBPPipF9Q2M1hjr8YRoWrA2TM5SzgF9mnBkt2NWxE
 2pYM8nKN0+jqijybzoGkJ8X18rPS1v1z1L7cSEnrTuaq9WBKRuh+9Ps8cRmj2ff8A69RhwbQAA
 AA=
X-Change-ID: 20240911-iio-pac1921-nocast-5c98cdeec059
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matteo Martelli <matteomartelli3@gmail.com>
X-Mailer: b4 0.14.2

Many explicit casts were introduced to address Wconversion and
Wsign-compare warnings. Remove them to improve readability.

Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
Link: https://lore.kernel.org/linux-iio/1fa4ab12-0939-477d-bc92-306fd32e4fd9@stanley.mountain/
---
Changes in v2:
- Reintroduce two necessary explicit casts that avoid 32-bit int overflow.
- Link to v1: https://lore.kernel.org/r/20240916-iio-pac1921-nocast-v1-1-a0f96d321eee@gmail.com
---
 drivers/iio/adc/pac1921.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index 4c2a1c07bc399028f0334885fc9cd4552d5892b1..a10b87b409c0149c88d7a5ad6e98e7b273c59a1f 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -241,7 +241,7 @@ static inline void pac1921_calc_scale(int dividend, int divisor, int *val,
 	s64 tmp;
 
 	tmp = div_s64(dividend * (s64)NANO, divisor);
-	*val = (int)div_s64_rem(tmp, NANO, val2);
+	*val = div_s64_rem(tmp, NANO, val2);
 }
 
 /*
@@ -260,7 +260,7 @@ static void pac1921_calc_current_scales(struct pac1921_priv *priv)
 		int max = (PAC1921_MAX_VSENSE_MV * MICRO) >> i;
 		int vsense_lsb = DIV_ROUND_CLOSEST(max, PAC1921_RES_RESOLUTION);
 
-		pac1921_calc_scale(vsense_lsb, (int)priv->rshunt_uohm,
+		pac1921_calc_scale(vsense_lsb, priv->rshunt_uohm,
 				   &priv->current_scales[i][0],
 				   &priv->current_scales[i][1]);
 	}
@@ -314,7 +314,7 @@ static int pac1921_check_push_overflow(struct iio_dev *indio_dev, s64 timestamp)
 			       timestamp);
 	}
 
-	priv->prev_ovf_flags = (u8)flags;
+	priv->prev_ovf_flags = flags;
 
 	return 0;
 }
@@ -329,8 +329,7 @@ static int pac1921_check_push_overflow(struct iio_dev *indio_dev, s64 timestamp)
 static int pac1921_read_res(struct pac1921_priv *priv, unsigned long reg,
 			    u16 *val)
 {
-	int ret = regmap_bulk_read(priv->regmap, (unsigned int)reg, val,
-				   sizeof(*val));
+	int ret = regmap_bulk_read(priv->regmap, reg, val, sizeof(*val));
 	if (ret)
 		return ret;
 
@@ -366,7 +365,7 @@ static int pac1921_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
-		*val = (int)res_val;
+		*val = res_val;
 
 		return IIO_VAL_INT;
 	}
@@ -400,10 +399,10 @@ static int pac1921_read_raw(struct iio_dev *indio_dev,
 			s64 tmp = curr_scale[0] * (s64)NANO + curr_scale[1];
 
 			/* Multiply by max_vbus (V) / dv_gain */
-			tmp *= PAC1921_MAX_VBUS_V >> (int)priv->dv_gain;
+			tmp *= PAC1921_MAX_VBUS_V >> priv->dv_gain;
 
 			/* Convert back to INT_PLUS_NANO */
-			*val = (int)div_s64_rem(tmp, NANO, val2);
+			*val = div_s64_rem(tmp, NANO, val2);
 
 			return IIO_VAL_INT_PLUS_NANO;
 		}
@@ -426,7 +425,7 @@ static int pac1921_read_raw(struct iio_dev *indio_dev,
 		 * 1/(integr_period_usecs/MICRO) = MICRO/integr_period_usecs
 		 */
 		*val = MICRO;
-		*val2 = (int)priv->integr_period_usecs;
+		*val2 = priv->integr_period_usecs;
 		return IIO_VAL_FRACTIONAL;
 
 	default:
@@ -503,7 +502,7 @@ static int pac1921_lookup_scale(const int (*const scales_tbl)[2], size_t size,
 	for (unsigned int i = 0; i < size; i++)
 		if (scales_tbl[i][0] == scale_val &&
 		    scales_tbl[i][1] == scale_val2)
-			return (int)i;
+			return i;
 
 	return -EINVAL;
 }
@@ -553,7 +552,7 @@ static int pac1921_update_gain_from_scale(struct pac1921_priv *priv,
 		if (ret < 0)
 			return ret;
 
-		return pac1921_update_gain(priv, &priv->dv_gain, (u8)ret,
+		return pac1921_update_gain(priv, &priv->dv_gain, ret,
 					   PAC1921_GAIN_DV_GAIN_MASK);
 	case PAC1921_CHAN_VSENSE:
 		ret = pac1921_lookup_scale(pac1921_vsense_scales,
@@ -562,7 +561,7 @@ static int pac1921_update_gain_from_scale(struct pac1921_priv *priv,
 		if (ret < 0)
 			return ret;
 
-		return pac1921_update_gain(priv, &priv->di_gain, (u8)ret,
+		return pac1921_update_gain(priv, &priv->di_gain, ret,
 					   PAC1921_GAIN_DI_GAIN_MASK);
 	case PAC1921_CHAN_CURRENT:
 		ret = pac1921_lookup_scale(priv->current_scales,
@@ -571,7 +570,7 @@ static int pac1921_update_gain_from_scale(struct pac1921_priv *priv,
 		if (ret < 0)
 			return ret;
 
-		return pac1921_update_gain(priv, &priv->di_gain, (u8)ret,
+		return pac1921_update_gain(priv, &priv->di_gain, ret,
 					   PAC1921_GAIN_DI_GAIN_MASK);
 	default:
 		return -EINVAL;
@@ -586,7 +585,7 @@ static int pac1921_lookup_int_num_samples(int num_samples)
 {
 	for (unsigned int i = 0; i < ARRAY_SIZE(pac1921_int_num_samples); i++)
 		if (pac1921_int_num_samples[i] == num_samples)
-			return (int)i;
+			return i;
 
 	return -EINVAL;
 }
@@ -607,7 +606,7 @@ static int pac1921_update_int_num_samples(struct pac1921_priv *priv,
 	if (ret < 0)
 		return ret;
 
-	n_samples = (u8)ret;
+	n_samples = ret;
 
 	if (priv->n_samples == n_samples)
 		return 0;
@@ -770,7 +769,7 @@ static ssize_t pac1921_read_shunt_resistor(struct iio_dev *indio_dev,
 
 	guard(mutex)(&priv->lock);
 
-	vals[0] = (int)priv->rshunt_uohm;
+	vals[0] = priv->rshunt_uohm;
 	vals[1] = MICRO;
 
 	return iio_format_value(buf, IIO_VAL_FRACTIONAL, 1, vals);
@@ -793,13 +792,13 @@ static ssize_t pac1921_write_shunt_resistor(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	rshunt_uohm = (u32)val * MICRO + (u32)val_fract;
+	rshunt_uohm = val * MICRO + val_fract;
 	if (rshunt_uohm == 0 || rshunt_uohm > INT_MAX)
 		return -EINVAL;
 
 	guard(mutex)(&priv->lock);
 
-	priv->rshunt_uohm = (u32)rshunt_uohm;
+	priv->rshunt_uohm = rshunt_uohm;
 
 	pac1921_calc_current_scales(priv);
 
@@ -1168,7 +1167,7 @@ static int pac1921_probe(struct i2c_client *client)
 
 	priv->regmap = devm_regmap_init_i2c(client, &pac1921_regmap_config);
 	if (IS_ERR(priv->regmap))
-		return dev_err_probe(dev, (int)PTR_ERR(priv->regmap),
+		return dev_err_probe(dev, PTR_ERR(priv->regmap),
 				     "Cannot initialize register map\n");
 
 	devm_mutex_init(dev, &priv->lock);
@@ -1191,7 +1190,7 @@ static int pac1921_probe(struct i2c_client *client)
 
 	priv->vdd = devm_regulator_get(dev, "vdd");
 	if (IS_ERR(priv->vdd))
-		return dev_err_probe(dev, (int)PTR_ERR(priv->vdd),
+		return dev_err_probe(dev, PTR_ERR(priv->vdd),
 				     "Cannot get vdd regulator\n");
 
 	ret = regulator_enable(priv->vdd);

---
base-commit: fec496684388685647652ab4213454fbabdab099
change-id: 20240911-iio-pac1921-nocast-5c98cdeec059

Best regards,
-- 
Matteo Martelli <matteomartelli3@gmail.com>


