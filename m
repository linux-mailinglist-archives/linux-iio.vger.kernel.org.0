Return-Path: <linux-iio+bounces-27841-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 78239D27687
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 19:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 89C9A31E050F
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 18:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58893D1CAD;
	Thu, 15 Jan 2026 17:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WUPzUHOf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451413D5233
	for <linux-iio@vger.kernel.org>; Thu, 15 Jan 2026 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768499643; cv=none; b=qpDhgz4sabuikFsAt/4M4ykq7WKWU6eO0QfWQpHGx8UnT9GDzgxw7qRwhf1F5yKSbrqMPio4oaj40hl21IggepmyCeSPlFFsYEFKNrm6kRYNb0JVRat5BiE+PXFy4uCvasgElqaBz/AxlzKoEW6bM6iPWraNoLNViKz6QAkrWJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768499643; c=relaxed/simple;
	bh=YZChUeoZSlclWou2p1AfaRnTBqUP9N75hd9lkgdhGog=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Aq4Rb9TkCLeRByJe1fifEHGnv6dP83+242lm+h+agZZzdNvmdBGXFxyBTNC2yhLpxEHm81OlC4u/bhBOvQdTDx2MqIC55u2BLoqEudgi2bnN9WyORtReZA/Oer7JppUljXiNDkrwq5J9V269W1Z92cKqUfZgAcaaf+ankuxjn1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WUPzUHOf; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8718187eb6so176980666b.2
        for <linux-iio@vger.kernel.org>; Thu, 15 Jan 2026 09:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768499636; x=1769104436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tFuwwtdwwY9t5jaDt+uh7+prGEQmO6XhAru1cfWN/CI=;
        b=WUPzUHOfKrCSgEkR2XykcFCRKGUEtx4UbSjEOPCbLIXDfy1xGu5yzOH6o+IaxX7A4m
         KZccugyiipZFAOkiztNWSSpj1V6EQDjlJJ56JbSE5QC01uo9X6lbAZT/De4h7KmLH/LR
         u1A8fCqVIYJ+Ar5Zui8zABHE5enV4ldKrMzPv3jzqGkRe2Qt4kbP6WfM5ldxhxWpmJzq
         +WbytF2ZBT/FGhTwBSB09FuaCSyqXRPMJqt3udsnznR3RiXKv1NDQlfmslLqMSUu7rMD
         wBqf06+PC7Qn1hb2I28xaS89uNnjzRzU3gZ5IQlOZVc5o2H9KE72JZpqpgy+8HzSLOVG
         BR5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768499636; x=1769104436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tFuwwtdwwY9t5jaDt+uh7+prGEQmO6XhAru1cfWN/CI=;
        b=pFeD4JwK6PxXLUcLR6R8RhinlBRYkzwRYgxxZPL+MX3cscsxEQqbDbRiPGMtVjeUtv
         2IpDKeIArdICcV50xIJeUzBtawBosq3Rm0JXs+qN1UdVUWySFDen+kIM7yNsrpvXzPW+
         8/EKKhhs2u5gwrQ8RspYScKkPcdB8nIgFxHyL6SXkNSpaBtvtnrSLo/TkBdfcseNup1H
         6JrnvC1ptDT8qF/6xVP01kmfEz4PD5A0KN9lLzIbJKYUyfnP0+NK4NsDMrt2/R3VPoRp
         FtONV7b3IGFGaJq0EGeWL+tJS5Z0xxY4Z7Vi5161RCeVoEns2STWn37kHYR6E06e0Z+u
         Nvzw==
X-Forwarded-Encrypted: i=1; AJvYcCVngavZiLqoimkj8QBA764p/yX7TYt15GzZTFhJKMjVv7zeDKdhWgtbND3uM8jgU1XSAEJjlAiQwCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrgPUlzho4CralNZuqLhdJx+7pWFnZBnN4/cuKjmJeAXzdvTLp
	bzqXXrPTx73xJvYB7I6ab3lc3YUjhovXwW5Nf9l2xlCZb2eTwWXK/i9fqR3u3PGEOqo=
X-Gm-Gg: AY/fxX4fTiUw+a8ECxvgTX3VfuImDz0YbEuqeyNK7xQRASwCnYSgC/8FQNOtgDTfdti
	LLbraRJ1vHLpwAmwMfoYppMd3I6yYD1vJMr+ArjLhl59hu1O40My309UI47tdKPJ34ZSHy23MTF
	S4FlWqRKxP8mfm/biztMy5pLj99yEENOBjF8j40AU40CO3jf9mwwWrC1Z7N9+hDtxux5QG8D9qS
	DTicex/P1+/wzOEL/tmxT6Qp8KOlLCtQfaKkbSAlECnpqTEV35eC6pkaQl6XmGOZP6QK/+mNgEz
	ppB69lUvMwjAQcbo9vTxikc67meOCQqn9FCCtqohuLyz0y6hAWN641oWxuszBurcnJnyXeTpn6v
	TM20rYuYGrXMNEsAPVFAEtNnDQrdzsWZwlc2qGW8HfSmqn25E2GXTwEvd/x0mfpllPKZVDGVwi1
	aV
X-Received: by 2002:a17:906:c153:b0:b87:2780:1b1e with SMTP id a640c23a62f3a-b8793243a3amr42716266b.41.1768499636065;
        Thu, 15 Jan 2026 09:53:56 -0800 (PST)
Received: from localhost ([151.43.128.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b879513e735sm5098666b.13.2026.01.15.09.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 09:53:55 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] iio: accel: adxl380: Add support for 1 kHz sampling frequency
Date: Thu, 15 Jan 2026 18:53:50 +0100
Message-Id: <20260115175350.1045887-4-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260115175350.1045887-1-flavra@baylibre.com>
References: <20260115175350.1045887-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7485; i=flavra@baylibre.com; h=from:subject; bh=YZChUeoZSlclWou2p1AfaRnTBqUP9N75hd9lkgdhGog=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpaSmgEzEsXkfvkr08Il5hsaB4QA4cYusdEWLpT //Bw0aRon6JAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaWkpoAAKCRDt8TtzzpQ2 XzH1C/9eJTybGnpw7exYI7UF74mjBVrVFzC0P60Gjw2r5qFoPi93x5eC8xcdEmLWPgpa5wvgeaP Z1+hJI6zFfpawPbAyzEAfRr0QxjwFYXbQRx+egivHZacjZaBMsJrCaCYOBIQf9nFHcsWjisXSn7 K+rWSUirl1RJ5g9r5Hf1in42XZ90KwYL6/mR+mH7gF4xgBNQF/sDBkIFpcTwirBomXXUWSnexkP bqPx/aDGRhWkwdvXl0c2qDHmAShqpPlL0yBLUwZj/86etHb49/PhCch4IxIgIbahootiBvRSjD8 w17mMcuxUTQPrxBJRFqb3MvU1Nft1hpUeZ7aJXM0LKIX8UknTdM34toox7+C6+z9yFXjIrUYDw/ EMtfNyMj6zyKsef6c9ale/0Mn36RcF02qEcCPjmQkwR/otymETbUCfdI7sBXSOK9yNnrq2JHttU bC3XnnrmNXZ2ty3Fx6nnM3/TVLfk5VRlT+TjuEA414ZGAvyJgK8mxaJKGOhCVRPkK9cPg=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

In sensor variants (such as ADXL380 and ADXL382) that support low-power
mode, the SAR signal path allows sampling acceleration data at lower rates;
more specifically, when the sensor operates in VLP mode, the sampling
frequency is 1 kHz.
To add support for the 1kHz sampling frequency value, modify the operating
mode selection logic to take into account the sampling frequency, and
configure the decimation filters only when applicable (i.e. when using a
sampling frequency that relies on the DSM signal path); in addition,
constrain the available sampling frequency values based on whether the
sensor is operating in low-power mode.

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/accel/adxl380.c | 82 ++++++++++++++++++++++++++++---------
 drivers/iio/accel/adxl380.h | 10 ++++-
 2 files changed, 71 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
index b99458a5eae3..7fe94e5cce0f 100644
--- a/drivers/iio/accel/adxl380.c
+++ b/drivers/iio/accel/adxl380.c
@@ -264,10 +264,12 @@ static int adxl380_set_measure_en(struct adxl380_state *st, bool en)
 
 		/*
 		 * Activity/Inactivity detection available only in VLP/ULP
-		 * mode and for devices that support low power modes. Otherwise
-		 * go straight to measure mode (same bits as ADXL380_OP_MODE_HP).
+		 * mode and for devices that support low power modes.
 		 */
 		if (act_inact_enabled)
+			st->odr = ADXL380_ODR_VLP;
+
+		if (st->odr == ADXL380_ODR_VLP)
 			op_mode = ADXL380_OP_MODE_VLP;
 		else
 			op_mode = ADXL380_OP_MODE_HP;
@@ -495,17 +497,22 @@ static int adxl380_set_odr(struct adxl380_state *st, u8 odr)
 	if (ret)
 		return ret;
 
-	ret = regmap_update_bits(st->regmap, ADXL380_TRIG_CFG_REG,
-				 ADXL380_TRIG_CFG_DEC_2X_MSK,
-				 FIELD_PREP(ADXL380_TRIG_CFG_DEC_2X_MSK, odr & 1));
-	if (ret)
-		return ret;
+	if (odr >= ADXL380_ODR_DSM) {
+		u8 mul = odr - ADXL380_ODR_DSM;
+		u8 field;
 
-	ret = regmap_update_bits(st->regmap, ADXL380_TRIG_CFG_REG,
-				 ADXL380_TRIG_CFG_SINC_RATE_MSK,
-				 FIELD_PREP(ADXL380_TRIG_CFG_SINC_RATE_MSK, odr >> 1));
-	if (ret)
-		return ret;
+		field = FIELD_PREP(ADXL380_TRIG_CFG_DEC_2X_MSK, mul & 1);
+		ret = regmap_update_bits(st->regmap, ADXL380_TRIG_CFG_REG,
+					 ADXL380_TRIG_CFG_DEC_2X_MSK, field);
+		if (ret)
+			return ret;
+
+		field = FIELD_PREP(ADXL380_TRIG_CFG_SINC_RATE_MSK, mul >> 1);
+		ret = regmap_update_bits(st->regmap, ADXL380_TRIG_CFG_REG,
+					 ADXL380_TRIG_CFG_SINC_RATE_MSK, field);
+		if (ret)
+			return ret;
+	}
 
 	st->odr = odr;
 	ret = adxl380_set_measure_en(st, true);
@@ -1145,6 +1152,31 @@ static const struct iio_buffer_setup_ops adxl380_buffer_ops = {
 	.predisable = adxl380_buffer_predisable,
 };
 
+static int adxl380_samp_freq_avail(struct adxl380_state *st, const int **vals,
+				   int *length)
+{
+	bool act_inact_enabled;
+	int ret;
+
+	if (!st->chip_info->has_low_power) {
+		*vals = st->chip_info->samp_freq_tbl + ADXL380_ODR_DSM;
+		*length = ADXL380_ODR_MAX - ADXL380_ODR_DSM;
+		return 0;
+	}
+
+	ret = adxl380_act_inact_enabled(st, &act_inact_enabled);
+	if (!ret) {
+		/*
+		 * Motion detection is only functional in low-power mode, and
+		 * this affects the available sampling frequencies.
+		 */
+		*vals = st->chip_info->samp_freq_tbl;
+		*length = act_inact_enabled ? ADXL380_ODR_DSM : ADXL380_ODR_MAX;
+	}
+
+	return ret;
+}
+
 static int adxl380_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long info)
@@ -1225,6 +1257,7 @@ static int adxl380_read_avail(struct iio_dev *indio_dev,
 			      long mask)
 {
 	struct adxl380_state *st = iio_priv(indio_dev);
+	int ret;
 
 	if (chan->type != IIO_ACCEL)
 		return -EINVAL;
@@ -1236,9 +1269,11 @@ static int adxl380_read_avail(struct iio_dev *indio_dev,
 		*length = ARRAY_SIZE(st->chip_info->scale_tbl) * 2;
 		return IIO_AVAIL_LIST;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		*vals = (const int *)st->chip_info->samp_freq_tbl;
+		ret = adxl380_samp_freq_avail(st, vals, length);
+		if (ret)
+			return ret;
+
 		*type = IIO_VAL_INT;
-		*length = ARRAY_SIZE(st->chip_info->samp_freq_tbl);
 		return IIO_AVAIL_LIST;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		*vals = (const int *)st->lpf_tbl;
@@ -1261,12 +1296,18 @@ static int adxl380_write_raw(struct iio_dev *indio_dev,
 			     int val, int val2, long info)
 {
 	struct adxl380_state *st = iio_priv(indio_dev);
+	const int *freq_vals;
+	int freq_count;
 	int odr_index, lpf_index, hpf_index, range_index;
+	int ret;
 
 	switch (info) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		odr_index = adxl380_find_match_1d_tbl(st->chip_info->samp_freq_tbl,
-						      ARRAY_SIZE(st->chip_info->samp_freq_tbl),
+		ret = adxl380_samp_freq_avail(st, &freq_vals, &freq_count);
+		if (ret)
+			return ret;
+
+		odr_index = adxl380_find_match_1d_tbl(freq_vals, freq_count,
 						      val);
 		return adxl380_set_odr(st, odr_index);
 	case IIO_CHAN_INFO_CALIBBIAS:
@@ -1628,7 +1669,7 @@ const struct adxl380_chip_info adxl318_chip_info = {
 		[ADXL380_OP_MODE_8G_RANGE] = { 0, 2615434 },
 		[ADXL380_OP_MODE_16G_RANGE] = { 0, 5229886 },
 	},
-	.samp_freq_tbl = { 8000, 16000, 32000 },
+	.samp_freq_tbl = { 0, 8000, 16000, 32000 },
 	/*
 	 * The datasheet defines an intercept of 550 LSB at 25 degC
 	 * and a sensitivity of 10.2 LSB/C.
@@ -1646,7 +1687,7 @@ const struct adxl380_chip_info adxl319_chip_info = {
 		[ADXL382_OP_MODE_30G_RANGE] = { 0, 9806650 },
 		[ADXL382_OP_MODE_60G_RANGE] = { 0, 19613300 },
 	},
-	.samp_freq_tbl = { 16000, 32000, 64000 },
+	.samp_freq_tbl = { 0, 16000, 32000, 64000 },
 	/*
 	 * The datasheet defines an intercept of 550 LSB at 25 degC
 	 * and a sensitivity of 10.2 LSB/C.
@@ -1664,7 +1705,7 @@ const struct adxl380_chip_info adxl380_chip_info = {
 		[ADXL380_OP_MODE_8G_RANGE] = { 0, 2615434 },
 		[ADXL380_OP_MODE_16G_RANGE] = { 0, 5229886 },
 	},
-	.samp_freq_tbl = { 8000, 16000, 32000 },
+	.samp_freq_tbl = { 1000, 8000, 16000, 32000 },
 	/*
 	 * The datasheet defines an intercept of 470 LSB at 25 degC
 	 * and a sensitivity of 10.2 LSB/C.
@@ -1684,7 +1725,7 @@ const struct adxl380_chip_info adxl382_chip_info = {
 		[ADXL382_OP_MODE_30G_RANGE] = { 0, 9806650 },
 		[ADXL382_OP_MODE_60G_RANGE] = { 0, 19613300 },
 	},
-	.samp_freq_tbl = { 16000, 32000, 64000 },
+	.samp_freq_tbl = { 1000, 16000, 32000, 64000 },
 	/*
 	 * The datasheet defines an intercept of 570 LSB at 25 degC
 	 * and a sensitivity of 10.2 LSB/C.
@@ -1923,6 +1964,7 @@ int adxl380_probe(struct device *dev, struct regmap *regmap,
 	st->dev = dev;
 	st->regmap = regmap;
 	st->chip_info = chip_info;
+	st->odr = ADXL380_ODR_DSM;
 
 	mutex_init(&st->lock);
 
diff --git a/drivers/iio/accel/adxl380.h b/drivers/iio/accel/adxl380.h
index e67c5aab8efc..d2c260c8b2fa 100644
--- a/drivers/iio/accel/adxl380.h
+++ b/drivers/iio/accel/adxl380.h
@@ -8,10 +8,18 @@
 #ifndef _ADXL380_H_
 #define _ADXL380_H_
 
+enum adxl380_odr {
+	ADXL380_ODR_VLP,
+	ADXL380_ODR_DSM,
+	ADXL380_ODR_DSM_2X,
+	ADXL380_ODR_DSM_4X,
+	ADXL380_ODR_MAX
+};
+
 struct adxl380_chip_info {
 	const char *name;
 	const int scale_tbl[3][2];
-	const int samp_freq_tbl[3];
+	const int samp_freq_tbl[ADXL380_ODR_MAX];
 	const struct iio_info *info;
 	const int temp_offset;
 	const u16 chip_id;
-- 
2.39.5


