Return-Path: <linux-iio+bounces-27512-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED18FCFDBCC
	for <lists+linux-iio@lfdr.de>; Wed, 07 Jan 2026 13:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A3F73053830
	for <lists+linux-iio@lfdr.de>; Wed,  7 Jan 2026 12:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944AA319875;
	Wed,  7 Jan 2026 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fmuL1bEo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764C531812C
	for <linux-iio@vger.kernel.org>; Wed,  7 Jan 2026 12:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767789326; cv=none; b=HzbxedZGMCgSnusSQ0oqLb2UqsRYdpwAGMMzjqK5fM0ibwUXpmddX33q5TKvWwVTzj+kKBQHnlNsSOEwMM3jWQQm0grG47cHJ7JS5MwAbpSC+XK6BSA6qbYjoqy4LqAgn691FQLyUF5uI5lMh7MYQIurUJ8Y9OK+a7x5RwpMLcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767789326; c=relaxed/simple;
	bh=0s7F3wx9F8OanhM3tiFMaiQriDANuo8GZ/AwyAxEqkY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kf/8W+4knohgacinYNF/JwBkFhHqnpcg6TVqhK49MbMQH08hmCpgEDcZrQ+vdfcNDXbi4cfLbDEfZVX2TF/JfnSpk6diDgti7UYFc+nK1GMz+DtYaKjoETrp+UwSXeJm7yQ50TjCsrEjj41baaYh7Xa23yZ5JSKF8tEIegtUW3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fmuL1bEo; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6505cbe47d8so3202409a12.1
        for <linux-iio@vger.kernel.org>; Wed, 07 Jan 2026 04:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767789323; x=1768394123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hb9X7ojqs7UxJ/3kF+kDP4GTNw9n7fjfq/OK20F33Hg=;
        b=fmuL1bEoKBUtjPdfkxS+bMHNsrBzKWzOlncCcZW8wbw77YL53D8lwJd7yU2YHaB5Gy
         Cu3YAfjaQCDoJaP070dbstpYlgOkVLJ2yyseeQh3xjXaL/x/GcjVzQCcGFh3Z9qmw9Jd
         /1cEH9i7eRdF7bu9JCHE3RWGiYCB4bGAZrKMuQWyUfT02His9YWnxxyacBSi6OoHZrcF
         ApLUJa8lfGoM6s/I/6S16REgemF9unZc9dDTNxj8Wy7xvlusenAcKjhSA//qo9aAyjmD
         4acv659aWo4cwh0n3L5yKlYnev5ZfnDx7lCla5i2xNQBk4xnPXi7ECqAS4D+QHur6DNe
         xYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767789323; x=1768394123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hb9X7ojqs7UxJ/3kF+kDP4GTNw9n7fjfq/OK20F33Hg=;
        b=OnEvjQlLAU2F3cGsii4Q24JM2/hDkYDFB1zIfkof7RoQeYY1dmnnXsMr/HnO/NllHw
         zV0foJWYQHfVGRbfmK/Da0TosvaBDvj8VJTzzCBt0pYr+4oIvKwbYYoyKXLVaxeKiY/D
         a4LMjF7zam6+M0TukoUKp2MRUB9CrmRW1NHyh45V0WTmx6qghAuLVMyDPgorWV4blLRx
         EjmLM5bUB7xN2ipQ+bAmzHOSYo3tuU128iZBiMojXnuj3JvF0f1BIN0AAvDyPp7+JSm2
         yBnDg9TwPFHE15hPgOeyhp36RhDsw2DjyG9VZ6cjnLSs+i3vgZOAuXTGcrjDuYzb2jZu
         vu4A==
X-Forwarded-Encrypted: i=1; AJvYcCXsM7Os3Tl4JNz2EhdxXZZp1TaQGO5ncj0VwquJpxoKw+mGOdZgy/qubeW/pFIKexM0FD8mYyl+fR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqmaUzcEI9KJDDoZiPKaheBSAKjMIx7Re3pVt18C2M0tTnQNev
	udxUWXlYlgBVLd0DlKFhi4WRUdXIdLHEc6Ps4PrBYjMU690sNO/CzM4mn5UQIjLJRmw=
X-Gm-Gg: AY/fxX5wFkF5+QBpUNe8+iVEitt4xs77Mxtb9sE9L95jXHEQdEiO7dLjTGmD2geonQR
	wfdbwXAE6Jjx2eHt/h/8a4IJCcDkbiSqRHujRj5npSy4FavypQ4mA7B0IhxZoDUUaw4TOMeEz8T
	s3disX8zHejJBu6IwTTZtUHovXFCGDEdwRepZUVcpaVJIIMKYQP2aTmKTwR3jkTy+C8u0Jwptr3
	iHqZ+/mE569esQeM+irmtOsTn2hMmvDUF2ukOi3fbvtDWAN0EsxF7xAsxwl7T2vUexIXeTg0AsG
	i2/avN7OZ0Vg4V33JeaS861LKOh3SY8rtmvOH0R6icutrpBk9ai7BRDd7krf6TDJZDsZ5rBT/7g
	LOmo4X1vm+2xbiEQm+l1TfVvGkh7LywBEB3IOD1VIt1Nx2EykakrIRQ0urgZOwK7iSujF9dDbpW
	0xilVZ+pPAQcMmvgy/JRIzCliHKhAy9mtqTqqQRy4=
X-Google-Smtp-Source: AGHT+IHDilfFE4eSHAWVwsGDGF+z/OqbkLKKZXP7CW7m7ovmXEdVaEkBR4XZZ0kGhIy0u76UlatFIA==
X-Received: by 2002:a05:6402:518f:b0:64c:62f7:1ac4 with SMTP id 4fb4d7f45d1cf-65097e717abmr2090092a12.32.1767789322697;
        Wed, 07 Jan 2026 04:35:22 -0800 (PST)
Received: from localhost (mob-176-245-211-45.net.vodafone.it. [176.245.211.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf6d5absm4503713a12.33.2026.01.07.04.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 04:35:22 -0800 (PST)
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
Subject: [PATCH 2/2] iio: accel: adxl380: Add support for 1 kHz sampling frequency
Date: Wed,  7 Jan 2026 13:35:18 +0100
Message-Id: <20260107123518.4017292-3-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260107123518.4017292-1-flavra@baylibre.com>
References: <20260107123518.4017292-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5746; i=flavra@baylibre.com; h=from:subject; bh=0s7F3wx9F8OanhM3tiFMaiQriDANuo8GZ/AwyAxEqkY=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpXlMAoKv/PJe5nKgcmvrGJrBmMoq0oNO0XUSSY 1jAe2v0pFeJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaV5TAAAKCRDt8TtzzpQ2 X8GwC/49A2LyU02o9MyMvyYV2QNhlFAaB1sELziezLeqxbamqmd7pBuN+9qsVnIiFysCCH5FPd3 /KRYI9jNt2+espGVDOTTIwEncncKX3ZOAX0+SxSF2E3gwDB/l7qt2wgrLx2SsMK9wdd4yHwYjAQ EcGQuevaKUwGxcDutPHy2f2+L8TrZvGQhsiEAKdXM73+Z11pRkQSwTcePIpBRpTSN8i+albIOe3 pTnK7YgvJiTv1SJ6TS9zLAK1nkVNRlVaImiYguJMzJe8LJMR/M6k/hUk5by84OpPF3Cazgos4Hd Blc4Ogw6S3HuaFtTo+CwnJk8gUyF+oGMe4qL1pCs019UxpAWZ1qoTyXoGyRoApx1MKndYvVw+M9 95IbJQ70NeMoWQrxMl60f8ldeONLpy3rAPz+ON23C58+q4veAjoxiXe7KJRe3b9UO7TPdKjXNLd Vt2oRjfZTdJDu/jvt0TnE0uKgqOsQUSu+nMk4FsD+mFugN7CIik2uSfMFhsgHkdzdNsJE=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

In sensor variants (such as ADXL380 and ADXL382) that support low-power
mode, the SAR signal path allows sampling acceleration data at lower rates;
more specifically, when the sensor operates in VLP mode, the sampling
frequency is 1 kHz.
To add support for the 1kHz sampling frequency value, modify the operating
mode selection logic to take into account the sampling frequency, and
configure the decimation filters only when applicable (i.e. when using a
sampling frequency that relies on the DSM signal path).

Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/accel/adxl380.c | 49 +++++++++++++++++++++++--------------
 drivers/iio/accel/adxl380.h | 10 +++++++-
 2 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/accel/adxl380.c b/drivers/iio/accel/adxl380.c
index bbf1f88ca781..a6919dfce2e9 100644
--- a/drivers/iio/accel/adxl380.c
+++ b/drivers/iio/accel/adxl380.c
@@ -245,12 +245,14 @@ static int adxl380_set_measure_en(struct adxl380_state *st, bool en)
 
 		/*
 		 * Activity/Inactivity detection available only in VLP/ULP
-		 * mode and for devices that support low power modes. Otherwise
-		 * go straight to measure mode (same bits as ADXL380_OP_MODE_HP).
+		 * mode and for devices that support low power modes.
 		 */
 		if (st->chip_info->has_low_power &&
 		    (FIELD_GET(ADXL380_ACT_EN_MSK, act_inact_ctl) ||
 		     FIELD_GET(ADXL380_INACT_EN_MSK, act_inact_ctl)))
+			st->odr = ADXL380_ODR_VLP;
+
+		if (st->odr == ADXL380_ODR_VLP)
 			op_mode = ADXL380_OP_MODE_VLP;
 		else
 			op_mode = ADXL380_OP_MODE_HP;
@@ -478,17 +480,22 @@ static int adxl380_set_odr(struct adxl380_state *st, u8 odr)
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
@@ -1219,9 +1226,14 @@ static int adxl380_read_avail(struct iio_dev *indio_dev,
 		*length = ARRAY_SIZE(st->chip_info->scale_tbl) * 2;
 		return IIO_AVAIL_LIST;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		*vals = (const int *)st->chip_info->samp_freq_tbl;
+		if (st->chip_info->has_low_power) {
+			*vals = st->chip_info->samp_freq_tbl;
+			*length = ADXL380_ODR_MAX;
+		} else {
+			*vals = st->chip_info->samp_freq_tbl + ADXL380_ODR_DSM;
+			*length = ADXL380_ODR_MAX - ADXL380_ODR_DSM;
+		}
 		*type = IIO_VAL_INT;
-		*length = ARRAY_SIZE(st->chip_info->samp_freq_tbl);
 		return IIO_AVAIL_LIST;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
 		*vals = (const int *)st->lpf_tbl;
@@ -1611,7 +1623,7 @@ const struct adxl380_chip_info adxl318_chip_info = {
 		[ADXL380_OP_MODE_8G_RANGE] = { 0, 2615434 },
 		[ADXL380_OP_MODE_16G_RANGE] = { 0, 5229886 },
 	},
-	.samp_freq_tbl = { 8000, 16000, 32000 },
+	.samp_freq_tbl = { 0, 8000, 16000, 32000 },
 	/*
 	 * The datasheet defines an intercept of 550 LSB at 25 degC
 	 * and a sensitivity of 10.2 LSB/C.
@@ -1629,7 +1641,7 @@ const struct adxl380_chip_info adxl319_chip_info = {
 		[ADXL382_OP_MODE_30G_RANGE] = { 0, 9806650 },
 		[ADXL382_OP_MODE_60G_RANGE] = { 0, 19613300 },
 	},
-	.samp_freq_tbl = { 16000, 32000, 64000 },
+	.samp_freq_tbl = { 0, 16000, 32000, 64000 },
 	/*
 	 * The datasheet defines an intercept of 550 LSB at 25 degC
 	 * and a sensitivity of 10.2 LSB/C.
@@ -1647,7 +1659,7 @@ const struct adxl380_chip_info adxl380_chip_info = {
 		[ADXL380_OP_MODE_8G_RANGE] = { 0, 2615434 },
 		[ADXL380_OP_MODE_16G_RANGE] = { 0, 5229886 },
 	},
-	.samp_freq_tbl = { 8000, 16000, 32000 },
+	.samp_freq_tbl = { 1000, 8000, 16000, 32000 },
 	/*
 	 * The datasheet defines an intercept of 470 LSB at 25 degC
 	 * and a sensitivity of 10.2 LSB/C.
@@ -1667,7 +1679,7 @@ const struct adxl380_chip_info adxl382_chip_info = {
 		[ADXL382_OP_MODE_30G_RANGE] = { 0, 9806650 },
 		[ADXL382_OP_MODE_60G_RANGE] = { 0, 19613300 },
 	},
-	.samp_freq_tbl = { 16000, 32000, 64000 },
+	.samp_freq_tbl = { 1000, 16000, 32000, 64000 },
 	/*
 	 * The datasheet defines an intercept of 570 LSB at 25 degC
 	 * and a sensitivity of 10.2 LSB/C.
@@ -1906,6 +1918,7 @@ int adxl380_probe(struct device *dev, struct regmap *regmap,
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


