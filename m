Return-Path: <linux-iio+bounces-21279-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED9CAF6649
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 01:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51D6F1C42B72
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 23:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDBC25487B;
	Wed,  2 Jul 2025 23:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbWeNVR7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D164140E34
	for <linux-iio@vger.kernel.org>; Wed,  2 Jul 2025 23:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751499086; cv=none; b=JEOX3Uciaqo4/sFDjUGluNoAsuOGNJkZRba+BUDbRdjGNNW1/Zli3fD3ttlKx/iVKVeT8NVQ6/wzlZ13mmdnG98bqY+2DVU/Wi2fsOD0hmzX3ccKiRVtocIpbBvCogeOVqkEWP/A7r75oTGl88eun9DR+3o2CNs8oqyDWxRq4SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751499086; c=relaxed/simple;
	bh=L9QY4ZY+NZlfjp+6zJ9Zh0yubN5Tlbcju+8ra9dO3dw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=psEiSNrUXaCI03IZC9BblIrYH7/tOVF5HNSHMs7g0kwuvIAzU1XeUJqQJDuW/9xfhT/ykXTJrMkJ//CSH+kKcVdhTH2EGjuWO/mgH8m38uubsJyoI44Bxn5qVkqXT2be75qzXtHtq1NLg2RBLZdrKMtmWynV5hf+AtK+loYLI44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbWeNVR7; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7d5d0ea6c8dso40222685a.1
        for <linux-iio@vger.kernel.org>; Wed, 02 Jul 2025 16:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751499083; x=1752103883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5P6VEh+TRCFSWLJBNZkHbbemxNDEsDjf6YXet7p1hbI=;
        b=cbWeNVR7Gfb67SzDgvI/oXxf1Gym3eizVnqMZqKZnEGPj03hQK41lBEOTeFl5AQURr
         hJCAvr0Ehlsa+uGM2nbZ3hFmNzquWbXllWc0g94loNKgkzw7Q3giyEyzJxO5EIyHAcpM
         kennPAByE41vwq8K8Wqm7r6zb5uGmSVwn1EtsCpEzTxjg6u101XtrjfQBi6Csp45F1ha
         LHOk369tmXaH/7EXU3qZoATUcpSXU8CpK/FSctv3GOZI5CufnLFm5cq192yUJYdhKgXr
         wLPFY9e50bh92+sw4brPbyOM1mrjTL6VN5G5wRjG20RLl2TMjM/G4UytLP9zKl3ORLeB
         gwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751499083; x=1752103883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5P6VEh+TRCFSWLJBNZkHbbemxNDEsDjf6YXet7p1hbI=;
        b=Eo/BEeFqGlj/i7TaDWggJzWS/fUoLi5vs8YSt5jhGutI4sg7xnd63Zb9RhjkmY39mv
         YOBoc3xfH07VGdMTM5Fy/xEmLYN5f/VxCQMO0uLoNRAvlHEumBb+dwI6Ln2qIXX5KdqR
         PRvjNhreWPs6CJMXGMNL+vWbVe0PPh+8YYlONDZibHD4x6V/lhbH4QokhYXCL5g4OSGd
         gjNe/AYejrCaXOdBRx7nWPLoZy2JoqTsoHMdVst8GLxazd+GAQfavgqCc2tPq8qsEXPM
         LUuhl8acIaJpv2aO7wCuR/YqdEnNDl1yhwFgnTPsBMN5f+piwrQ9A2Qmw2KgudGKHNdT
         7yBQ==
X-Gm-Message-State: AOJu0YzMpCIo8v3Yxk6y5QEV0l7j+4jZCnAsO4JkxhNND+Yp5sTF+yz8
	E9LK+xz5kt9d0D8pN8jLoPJ8lSNSa8M4Y0WyLbM3FV+PORvjMIXkbLIHmUt2jQ==
X-Gm-Gg: ASbGncsdkTsI2QzaV0N061/IBtfD6H6pJwRGPA+/erz/M9SU0qzKM5RtcOlGCI6wpQ3
	8e7rVW4r+D/WjQfWkCE7W7rWf9kfSPxSpzllD19O8ArCpuxXONcpsdOylUlv0xOFNZU8/Mf/1fV
	HBbALhTCGRMWRIUMgaoSlv1R6MzZjYeKkaWfuTwl21VLmEdzwLE8dvUDWBj70wAt8vk04yYI2vJ
	Oo4s1Cx60Rc9knsFx9AC1v2d+9J/HbLm3opgG9pwgKrxNIgkhiPBlcOZLbYGG53TKFVdCVuKifN
	W/SffcGTKljomKJ6WxhuGcCwVTffQw/Yd06n/8kPuO+2NazcQJwIonCHSnwOsTyC6RRVoCz1wr7
	A39mzwygsRpE=
X-Google-Smtp-Source: AGHT+IEONMjAlv6SE7PBhpueWGE0WlNcqZPzgSSuMfalVSw2qauJOWgIvvuDmNgYrai9w7+//nMFqQ==
X-Received: by 2002:a05:620a:1a1c:b0:7ca:f40c:c1c6 with SMTP id af79cd13be357-7d5c47ba45cmr719240285a.44.1751499082669;
        Wed, 02 Jul 2025 16:31:22 -0700 (PDT)
Received: from eijiuchiyama-Dell-G15-5530.. ([187.10.131.129])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44320572dsm1010604985a.69.2025.07.02.16.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 16:31:21 -0700 (PDT)
From: Lucas Eiji Uchiyama <lucaseiji54@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Lucas Eiji Uchiyama <lucaseiji54@gmail.com>
Subject: [PATCH] iio: dps310.c: Remove duplication in functions
Date: Wed,  2 Jul 2025 20:31:07 -0300
Message-Id: <20250702233107.93975-1-lucaseiji54@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consolidate the following functions into shared implementations:

- dps310_get_pres_precision
- dps310_get_temp_precision
- dps310_set_pres_precision
- dps310_set_temp_precision
- dps310_set_pres_samp_freq
- dps310_set_temp_samp_freq
- dps310_get_pres_samp_freq
- dps310_get_temp_samp_freq
- dps310_get_pres_k
- dps310_get_temp_k

These were replaced by the following unified functions:

- dps310_get_precision
- dps310_set_precision
- dps310_set_samp_freq
- dps310_get_samp_freq
- dps310_get_k

Each now takes an additional `mode` parameter indicating whether the
operation applies to temperature or pressure.

All call sites were updated accordingly. To improve readability, new
macros PRESSURE and TEMPERATURE were introduced and passed to the
shared functions.

Additionally, a new macro was defined for:

  BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
  BIT(IIO_CHAN_INFO_SAMP_FREQ) |
  BIT(IIO_CHAN_INFO_PROCESSED)

since this combination was used twice in the same struct.

Signed-off-by: Lucas Eiji Uchiyama <lucaseiji54@gmail.com>
---
 drivers/iio/pressure/dps310.c | 182 +++++++++++++---------------------
 1 file changed, 69 insertions(+), 113 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 8edaa4d10..99188bf4a 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -56,6 +56,8 @@
 #define DPS310_RESET		0x0c
 #define  DPS310_RESET_MAGIC	0x09
 #define DPS310_COEF_BASE	0x10
+#define PRESSURE 0
+#define TEMPERATURE 1
 
 /* Make sure sleep time is <= 30ms for usleep_range */
 #define DPS310_POLL_SLEEP_US(t)		min(30000, (t) / 8)
@@ -65,6 +67,11 @@
 #define DPS310_PRS_BASE		DPS310_PRS_B0
 #define DPS310_TMP_BASE		DPS310_TMP_B0
 
+#define INFO_MASK_SEPARATE \
+	 (BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) | \
+	 BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
+	 BIT(IIO_CHAN_INFO_PROCESSED))
+
 /*
  * These values (defined in the spec) indicate how to scale the raw register
  * values for each level of precision available.
@@ -95,15 +102,11 @@ struct dps310_data {
 static const struct iio_chan_spec dps310_channels[] = {
 	{
 		.type = IIO_TEMP,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
-			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-			BIT(IIO_CHAN_INFO_PROCESSED),
+		.info_mask_separate = INFO_MASK_SEPARATE
 	},
 	{
 		.type = IIO_PRESSURE,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |
-			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
-			BIT(IIO_CHAN_INFO_PROCESSED),
+		.info_mask_separate = INFO_MASK_SEPARATE
 	},
 };
 
@@ -256,57 +259,24 @@ static int dps310_startup(struct dps310_data *data)
 	return dps310_temp_workaround(data);
 }
 
-static int dps310_get_pres_precision(struct dps310_data *data, int *val)
-{
-	int reg_val, rc;
-
-	rc = regmap_read(data->regmap, DPS310_PRS_CFG, &reg_val);
-	if (rc < 0)
-		return rc;
-
-	*val = BIT(reg_val & GENMASK(2, 0));
-
-	return 0;
-}
-
-static int dps310_get_temp_precision(struct dps310_data *data, int *val)
+static int dps310_get_precision(struct dps310_data *data, int *val, int mode)
 {
 	int reg_val, rc;
-
-	rc = regmap_read(data->regmap, DPS310_TMP_CFG, &reg_val);
+	if (!mode)
+		rc = regmap_read(data->regmap, DPS310_PRS_CFG, &reg_val);
+	else
+		rc = regmap_read(data->regmap, DPS310_TMP_CFG, &reg_val);
 	if (rc < 0)
 		return rc;
 
-	/*
-	 * Scale factor is bottom 4 bits of the register, but 1111 is
-	 * reserved so just grab bottom three
-	 */
 	*val = BIT(reg_val & GENMASK(2, 0));
 
 	return 0;
-}
-
-/* Called with lock held */
-static int dps310_set_pres_precision(struct dps310_data *data, int val)
-{
-	int rc;
-	u8 shift_en;
-
-	if (val < 0 || val > 128)
-		return -EINVAL;
-
-	shift_en = val >= 16 ? DPS310_PRS_SHIFT_EN : 0;
-	rc = regmap_write_bits(data->regmap, DPS310_CFG_REG,
-			       DPS310_PRS_SHIFT_EN, shift_en);
-	if (rc)
-		return rc;
 
-	return regmap_update_bits(data->regmap, DPS310_PRS_CFG,
-				  DPS310_PRS_PRC_BITS, ilog2(val));
 }
 
 /* Called with lock held */
-static int dps310_set_temp_precision(struct dps310_data *data, int val)
+static int dps310_set_precision(struct dps310_data *data, int val, int mode)
 {
 	int rc;
 	u8 shift_en;
@@ -314,32 +284,29 @@ static int dps310_set_temp_precision(struct dps310_data *data, int val)
 	if (val < 0 || val > 128)
 		return -EINVAL;
 
-	shift_en = val >= 16 ? DPS310_TMP_SHIFT_EN : 0;
-	rc = regmap_write_bits(data->regmap, DPS310_CFG_REG,
-			       DPS310_TMP_SHIFT_EN, shift_en);
-	if (rc)
-		return rc;
-
-	return regmap_update_bits(data->regmap, DPS310_TMP_CFG,
-				  DPS310_TMP_PRC_BITS, ilog2(val));
-}
-
-/* Called with lock held */
-static int dps310_set_pres_samp_freq(struct dps310_data *data, int freq)
-{
-	u8 val;
-
-	if (freq < 0 || freq > 128)
-		return -EINVAL;
+	if (!mode) {
+		shift_en = val >= 16 ? DPS310_PRS_SHIFT_EN : 0;
+		rc = regmap_write_bits(data->regmap, DPS310_CFG_REG,
+				DPS310_PRS_SHIFT_EN, shift_en);
+		if (rc)
+			return rc;
 
-	val = ilog2(freq) << 4;
+		return regmap_update_bits(data->regmap, DPS310_PRS_CFG,
+				DPS310_PRS_PRC_BITS, ilog2(val));
+	} else {
+		shift_en = val >= 16 ? DPS310_TMP_SHIFT_EN : 0;
+		rc = regmap_write_bits(data->regmap, DPS310_CFG_REG,
+				DPS310_TMP_SHIFT_EN, shift_en);
+		if (rc)
+			return rc;
 
-	return regmap_update_bits(data->regmap, DPS310_PRS_CFG,
-				  DPS310_PRS_RATE_BITS, val);
+		return regmap_update_bits(data->regmap, DPS310_TMP_CFG,
+				DPS310_TMP_PRC_BITS, ilog2(val));
+	}
 }
 
 /* Called with lock held */
-static int dps310_set_temp_samp_freq(struct dps310_data *data, int freq)
+static int dps310_set_samp_freq(struct dps310_data *data, int freq, int mode)
 {
 	u8 val;
 
@@ -348,54 +315,43 @@ static int dps310_set_temp_samp_freq(struct dps310_data *data, int freq)
 
 	val = ilog2(freq) << 4;
 
-	return regmap_update_bits(data->regmap, DPS310_TMP_CFG,
-				  DPS310_TMP_RATE_BITS, val);
+	if (!mode)
+		return regmap_update_bits(data->regmap, DPS310_PRS_CFG,
+				DPS310_PRS_RATE_BITS, val);
+	else
+		return regmap_update_bits(data->regmap, DPS310_TMP_CFG,
+				DPS310_TMP_RATE_BITS, val);
 }
 
-static int dps310_get_pres_samp_freq(struct dps310_data *data, int *val)
+static int dps310_get_samp_freq(struct dps310_data *data, int *val, int mode)
 {
 	int reg_val, rc;
 
-	rc = regmap_read(data->regmap, DPS310_PRS_CFG, &reg_val);
-	if (rc < 0)
-		return rc;
-
-	*val = BIT((reg_val & DPS310_PRS_RATE_BITS) >> 4);
-
-	return 0;
-}
-
-static int dps310_get_temp_samp_freq(struct dps310_data *data, int *val)
-{
-	int reg_val, rc;
-
-	rc = regmap_read(data->regmap, DPS310_TMP_CFG, &reg_val);
-	if (rc < 0)
-		return rc;
+	if (!mode) {
+		rc = regmap_read(data->regmap, DPS310_PRS_CFG, &reg_val);
+		if (rc < 0)
+			return rc;
 
-	*val = BIT((reg_val & DPS310_TMP_RATE_BITS) >> 4);
+		*val = BIT((reg_val & DPS310_PRS_RATE_BITS) >> 4);
+	} else {
+		rc = regmap_read(data->regmap, DPS310_TMP_CFG, &reg_val);
+		if (rc < 0)
+			return rc;
 
+		*val = BIT((reg_val & DPS310_TMP_RATE_BITS) >> 4);
+	}
 	return 0;
 }
 
-static int dps310_get_pres_k(struct dps310_data *data, int *val)
+static int dps310_get_k(struct dps310_data *data, int *val, int mode)
 {
 	int reg_val, rc;
 
-	rc = regmap_read(data->regmap, DPS310_PRS_CFG, &reg_val);
-	if (rc < 0)
-		return rc;
-
-	*val = scale_factors[reg_val & GENMASK(2, 0)];
-
-	return 0;
-}
-
-static int dps310_get_temp_k(struct dps310_data *data, int *val)
-{
-	int reg_val, rc;
+	if (!mode)
+		rc = regmap_read(data->regmap, DPS310_PRS_CFG, &reg_val);
+	else
+		rc = regmap_read(data->regmap, DPS310_TMP_CFG, &reg_val);
 
-	rc = regmap_read(data->regmap, DPS310_TMP_CFG, &reg_val);
 	if (rc < 0)
 		return rc;
 
@@ -474,7 +430,7 @@ static int dps310_read_pres_raw(struct dps310_data *data)
 	if (mutex_lock_interruptible(&data->lock))
 		return -EINTR;
 
-	rc = dps310_get_pres_samp_freq(data, &rate);
+	rc = dps310_get_samp_freq(data, &rate, PRESSURE);
 	if (rc)
 		goto done;
 
@@ -523,7 +479,7 @@ static int dps310_read_temp_raw(struct dps310_data *data)
 	if (mutex_lock_interruptible(&data->lock))
 		return -EINTR;
 
-	rc = dps310_get_temp_samp_freq(data, &rate);
+	rc = dps310_get_samp_freq(data, &rate, TEMPERATURE);
 	if (rc)
 		goto done;
 
@@ -590,11 +546,11 @@ static int dps310_write_raw(struct iio_dev *iio,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		switch (chan->type) {
 		case IIO_PRESSURE:
-			rc = dps310_set_pres_samp_freq(data, val);
+			rc = dps310_set_samp_freq(data, val, PRESSURE);
 			break;
 
 		case IIO_TEMP:
-			rc = dps310_set_temp_samp_freq(data, val);
+			rc = dps310_set_samp_freq(data, TEMPERATURE);
 			break;
 
 		default:
@@ -606,11 +562,11 @@ static int dps310_write_raw(struct iio_dev *iio,
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		switch (chan->type) {
 		case IIO_PRESSURE:
-			rc = dps310_set_pres_precision(data, val);
+			rc = dps310_set_precision(data, val, PRESSURE);
 			break;
 
 		case IIO_TEMP:
-			rc = dps310_set_temp_precision(data, val);
+			rc = dps310_set_precision(data, val, TEMPERATURE);
 			break;
 
 		default:
@@ -645,11 +601,11 @@ static int dps310_calculate_pressure(struct dps310_data *data, int *val)
 	s64 kp;
 	s64 kt;
 
-	rc = dps310_get_pres_k(data, &kpi);
+	rc = dps310_get_k(data, &kpi, PRESSURE);
 	if (rc)
 		return rc;
 
-	rc = dps310_get_temp_k(data, &kti);
+	rc = dps310_get_k(data, &kti, TEMPERATURE);
 	if (rc)
 		return rc;
 
@@ -717,7 +673,7 @@ static int dps310_read_pressure(struct dps310_data *data, int *val, int *val2,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		rc = dps310_get_pres_samp_freq(data, val);
+		rc = dps310_get_samp_freq(data, val, PRESSURE);
 		if (rc)
 			return rc;
 
@@ -736,7 +692,7 @@ static int dps310_read_pressure(struct dps310_data *data, int *val, int *val2,
 		return IIO_VAL_FRACTIONAL;
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		rc = dps310_get_pres_precision(data, val);
+		rc = dps310_get_precision(data, val, PRESSURE);
 		if (rc)
 			return rc;
 		return IIO_VAL_INT;
@@ -752,7 +708,7 @@ static int dps310_calculate_temp(struct dps310_data *data, int *val)
 	s64 t;
 	int kt, rc;
 
-	rc = dps310_get_temp_k(data, &kt);
+	rc = dps310_get_k(data, &kt, TEMPERATURE);
 	if (rc)
 		return rc;
 
@@ -775,7 +731,7 @@ static int dps310_read_temp(struct dps310_data *data, int *val, int *val2,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		rc = dps310_get_temp_samp_freq(data, val);
+		rc = dps310_get_samp_freq(data, val, TEMPERATURE);
 		if (rc)
 			return rc;
 
@@ -793,7 +749,7 @@ static int dps310_read_temp(struct dps310_data *data, int *val, int *val2,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		rc = dps310_get_temp_precision(data, val);
+		rc = dps310_get_precision(data, val, TEMPERATURE);
 		if (rc)
 			return rc;
 
-- 
2.34.1


