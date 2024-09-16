Return-Path: <linux-iio+bounces-9611-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B01897A121
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 14:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C49F286159
	for <lists+linux-iio@lfdr.de>; Mon, 16 Sep 2024 12:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870BF158214;
	Mon, 16 Sep 2024 12:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OWOnDfwE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6DE157E9F;
	Mon, 16 Sep 2024 12:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726488211; cv=none; b=FAh/zfnA20IPCS9DcyHuB0oWGu6FFxe3oisUYWUluOi79eH3cSk5th+E8cTJDIW6jk1LmkqkxIEZ/vGe/nVImLoHq1YHa5JG+bji2G3ymbmZaT/o6QAda/re6a1XsnyKxjyePyf0SOkZByTmxFKPrtsLqnKW0+v9n1CFp2zjdAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726488211; c=relaxed/simple;
	bh=aHadeGUkjHAVTilEnzf8JCrKBU9lqGeBd1x1b5xFxC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eRO2ztJdFWKRRX1cKed8eQ77enK9EC9nQCrWF5BBmERlgwWXVne9TegNlFsf4oZLvNkDA/7HoiMpeQ7NLtSaOY9fkpod43bLXlkPbauaHcV+yct6kLBhSEJkdINJinE+8iRPGt36n9iSzvSDPuwOhf93JK5RdFwC6Y2Xa+Vy9lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OWOnDfwE; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-374bd059b12so1931651f8f.1;
        Mon, 16 Sep 2024 05:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726488208; x=1727093008; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j7rhiN0cwffHbbzhzNEaKmIKxR7usCqkEQIorTMTnxI=;
        b=OWOnDfwE+UvJu6jWIgTra0hLZSdg9la1Tpq7rK8yjYOA95kF4aoITUekwVQ3Wdc4dn
         X+tFB+O2QX1L+mFv5D3YSZxPzxkVDpla0MPoAPLr1nbGI2z1zAPHnzHwn3Rs5hibH+B9
         +4becn88PfrxM4i+rVAwNL6Nz5W4dpsCan9tDQSVcCLX8AIHaA1uwEbfXebVLXjTsd6A
         fGPsZWwp+jLxSHdtuwqO9xsAsJ+NcJYMWocIzAAR+P83n0jLNvzbmitOthoRZ1BezLhO
         CUMqj8wykNbXd7jAawMvgiL/+4nt5r+tnByJjh/OpGYcSrzE3KP39THZoV5+3sCshd/Q
         VkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726488208; x=1727093008;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j7rhiN0cwffHbbzhzNEaKmIKxR7usCqkEQIorTMTnxI=;
        b=WV7YOKqNmOfhLKi29vAUGnwqN1eODK/g8BWTrqVy3/jShDEmabZw21RVi6M9sSCA0I
         brdUG6l8f4NxlxlpfPWN7+SqTGt3A0dhaZ1GxzQhxLZ3fPi6fblsSmYK6dauk/QiaFV5
         CId0LwGGsIhIiOj1WMv1YQ1R8p5FpgM0M7QEub6v0oG3wQbgte4oOrw/lsFXi+f/8JPh
         5k1PXS542jQZNLfmMujPFDUVN5tFGPFAU+98WOBEd2Yt+v1jdTl8CJ+jetEnpdHLHA5K
         Q6n0AHzy2nkZoGgojfa1bIKM2HqXFBwh0meseqCgsmDrmekclQd8XowNwd05Vq4afrl6
         /LhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFn66lLfOjqa598Zu8ToXBO/VPS5+d1KtfEO0q0xXaUTJtzPjD8Vd2aiNz+TCcEEHiawqT9WuH3/1wlU8e@vger.kernel.org, AJvYcCV0wnr1ObEOwBOcWhna1PTjCPl0a73FnvTgRCU4UZ8ceiLufoVZCsWtZUsj38E3SmJt6OptSgdHmsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLKQZTC/c0q/+YGUtXqIk7BYuPVtW/0uBQePJBKI+SAznlhFGD
	vz0EQQW9UarAAN54Rc1vuE0rEcxzc1Ip4CWouUPNqdXGuBKurfs2
X-Google-Smtp-Source: AGHT+IElm0k84RKTk7MnXnflcV7uakeyrdC7fcFKyQ5BT8hUrQaeNzkZCNd4OygZK2uzW9kFMTCI4A==
X-Received: by 2002:adf:a302:0:b0:376:274c:c8b3 with SMTP id ffacd0b85a97d-378d61d4d81mr6536181f8f.5.1726488207226;
        Mon, 16 Sep 2024 05:03:27 -0700 (PDT)
Received: from localhost (host-80-104-176-42.retail.telecomitalia.it. [80.104.176.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f9a17sm7066603f8f.64.2024.09.16.05.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 05:03:26 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
Date: Mon, 16 Sep 2024 14:00:05 +0200
Subject: [PATCH] iio: pac1921: remove unnecessary explicit casts
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240916-iio-pac1921-nocast-v1-1-a0f96d321eee@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMQd6GYC/x3MMQqAMAxA0auUzAaaomC9ijiUGDVLK62IULy7x
 fEN/1coklUKTKZClluLpthAnQE+QtwFdW0GZ11vPRGqJjwDk3eEMXEoFw7sR15F2A4eWnhm2fT
 5p/Pyvh+GbNPXZAAAAA==
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matteo Martelli <matteomartelli3@gmail.com>
X-Mailer: b4 0.14.1

Many explicit casts were introduced to address Wconversion and
Wsign-compare warnings. Remove them to improve readability.

Fixes: 371f778b83cd ("iio: adc: add support for pac1921")
Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
---
Link: https://lore.kernel.org/linux-iio/1fa4ab12-0939-477d-bc92-306fd32e4fd9@stanley.mountain/
---
 drivers/iio/adc/pac1921.c | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index 4c2a1c07bc39..de69a1619a9e 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -240,8 +240,8 @@ static inline void pac1921_calc_scale(int dividend, int divisor, int *val,
 {
 	s64 tmp;
 
-	tmp = div_s64(dividend * (s64)NANO, divisor);
-	*val = (int)div_s64_rem(tmp, NANO, val2);
+	tmp = div_s64(dividend * NANO, divisor);
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
@@ -397,13 +396,13 @@ static int pac1921_read_raw(struct iio_dev *indio_dev,
 			int *curr_scale = priv->current_scales[priv->di_gain];
 
 			/* Convert current_scale from INT_PLUS_NANO to INT */
-			s64 tmp = curr_scale[0] * (s64)NANO + curr_scale[1];
+			s64 tmp = curr_scale[0] * NANO + curr_scale[1];
 
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


