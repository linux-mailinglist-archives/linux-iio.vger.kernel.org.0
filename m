Return-Path: <linux-iio+bounces-15256-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C00A2EA68
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 12:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F7C188B1BB
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 11:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365591E5B9F;
	Mon, 10 Feb 2025 11:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiJcVO17"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD20A1E5710;
	Mon, 10 Feb 2025 11:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185307; cv=none; b=q2u8Kv+MK1L+LxARkWG/KheMaLOpetrnaBosBr/H+3eBBNL7BUDSbuPSlrVx16PllaCgRJBJ4TQ+DveWc0KEykr51xkcVdysqK7Hf+ujhDFeAWIavNW2Sd6aVZ94hx1xT1lVpMto//kBgq6I+bS1Eev8f+Tb2neUMdONA09QhQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185307; c=relaxed/simple;
	bh=C9eyv9H/tjoxiNk52aq4T0byXJgoBJWBuTubeRNVlhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t2zlBKr4XIwje6tWlNeKYHq/kybzNU4ByEBUUIsqvygNB6qvi+st8Xbw8SGPE1GWQw5Kv38LWVa9by1zf/siT4C4kPysqtOczoyrHOZ9zXhGCgiZUQqvrM3dwP0hYOHIvJeSdxO4jofsX6+/fm5yAdlJQxc9TNtKir7ZItpLllY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiJcVO17; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab7c3d44ae1so9271866b.2;
        Mon, 10 Feb 2025 03:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739185303; x=1739790103; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQaAdDh8ES3cUCJoRDugQc2+aAH/Y7nrVOR0pZe6H9Q=;
        b=PiJcVO17cpHXHgAyzEybjgeD1/yQnbdEY6mQwvjQhuLfUSfmyPSEygvsr4uuP23hmr
         rlpgm4uw/1v/ugmSa0tDaVbFvs7ArYTCGLI090tV0KxcnPX6Eb022v4bYC/P8BXRVx8/
         vefS7W8qPckwfqTwfhF+Gs+qA9x2eZMU71PD7SzzFFgqUast5giwOBWGpbxN1A3NHaKn
         zGxca8eWV0XPelZ8EhUWswZQPdyK03p6GK0QSME1i3gzOuWAc+Zb0lBvVB4wVsT3uEMM
         BDyAKjXVm7rK95jDHMK4EyvfJ6vYjS/31CNDEVSfhvZqYQ2KwAL2lWOh1gsIndhQMN1p
         QnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739185303; x=1739790103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQaAdDh8ES3cUCJoRDugQc2+aAH/Y7nrVOR0pZe6H9Q=;
        b=Gwe04ojxMZbJNJQ3Prntc9pL3LeFDCZmDyAyfaW8HF3GNVvDI9ANuaE8+c2TOM6Naa
         gkZHgG5gYw7zKClE78WOfVJ+vcZ6BWCC3omKBJ4UEirgl9244w+rJqy3chdllNx+PSqI
         C6VH9DLTIbiv+7Puk0XKsDbILszD4UiX0/JDsL+uFNmJ1HHBbZrc9gQH35jEK3e4J6qV
         Qqms7Umc0jnLpeVRbX2J+KhArhLPtW2JF03Va+XlvOAZqxWwV/7G8z4HaQSaQSYeYeJH
         2xC/3jhksYcXpZEGVKdKncXQMeHCyc1EM8eIcQrS+PpSy/lVkI5iAp/Ww1hn9z+OxzNX
         SbwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9U7SDzLD81ewzrp4DjtEhJ6xplgP8q69y3pyCFHeS9GLhE3+FtutCbKAR2tR1CRycFj+SFq5z6nOStgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZFZYBRihBC9WBeHeRdiolTHMdyYaFm3IMKeqvuQnCcrJfEjxC
	UHrCyV0lU8YYdRivIlIvfRf6UNsOlNao9NaSdCZex1937YvXpxAUqr9B2A==
X-Gm-Gg: ASbGnctqOXGdmpyu3BQY80sTOEcnGrsvZUpLZAoWFK6qosvSqwR3RDGmkZsX89PEwJ/
	X9xXMBtwcfOY6I8Ldu9GOFcWCxU6r96oLx4gotwRiRKgeHbUZBzLS1CaOPV04OtlkYc+iK6GaZc
	7aKfjlyRYcJD6+gXLd7AXdkM0t0ZqPdW4tkxGGKduu5+tpoaj1bqDJBBtYBHw9/zbjgbC2/zLym
	bo2dheUD3JfFjC+d4HkAfsZbsfJmvShP+R0cYNg0WB39uFCSIQElKpBvxMNfylckYYsJt9nXYoc
	VdIRASsGLObWsvFYkoGRqL8BU2RTlkrWm/4lqADrCkiAgdsDqhbJl5ouBkCiQ5PsapGj+A==
X-Google-Smtp-Source: AGHT+IEWhktb1mX1G6Pqp9P8f7zZAqhyn0TB5qODywow6LwAYB0fbla+6onmu/7QvFUB15AdAqCTBA==
X-Received: by 2002:a17:907:9414:b0:aa6:9407:34e4 with SMTP id a640c23a62f3a-ab789c7f38emr477394266b.12.1739185302801;
        Mon, 10 Feb 2025 03:01:42 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7a5a78369sm486987266b.136.2025.02.10.03.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 03:01:42 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 09/14] iio: accel: adxl345: extend sample frequency adjustments
Date: Mon, 10 Feb 2025 11:01:14 +0000
Message-Id: <20250210110119.260858-10-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250210110119.260858-1-l.rubusch@gmail.com>
References: <20250210110119.260858-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce enums and functions to work with the sample frequency
adjustments. Let the sample frequency adjust via IIO and configure
a reasonable default.

Replace the old static sample frequency handling. The patch is in
preparation for activity/inactivity handling.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h      |   2 +-
 drivers/iio/accel/adxl345_core.c | 163 ++++++++++++++++++++++++-------
 2 files changed, 127 insertions(+), 38 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index bc6d634bd85c..0a549d5898c2 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -69,7 +69,7 @@
  * BW_RATE bits - Bandwidth and output data rate. The default value is
  * 0x0A, which translates to a 100 Hz output data rate
  */
-#define ADXL345_BW_RATE			GENMASK(3, 0)
+#define ADXL345_BW_RATE_MSK		GENMASK(3, 0)
 #define ADXL345_BW_LOW_POWER		BIT(4)
 #define ADXL345_BASE_RATE_NANO_HZ	97656250LL
 
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 56c5a4d85d71..08ad71875c5e 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -67,6 +67,45 @@ static const unsigned int adxl345_tap_time_reg[3] = {
 	[ADXL345_TAP_TIME_DUR] = ADXL345_REG_DUR,
 };
 
+enum adxl345_odr {
+	ADXL345_ODR_0P10HZ = 0,
+	ADXL345_ODR_0P20HZ,
+	ADXL345_ODR_0P39HZ,
+	ADXL345_ODR_0P78HZ,
+	ADXL345_ODR_1P56HZ,
+	ADXL345_ODR_3P13HZ,
+	ADXL345_ODR_6P25HZ,
+	ADXL345_ODR_12P50HZ,
+	ADXL345_ODR_25HZ,
+	ADXL345_ODR_50HZ,
+	ADXL345_ODR_100HZ,
+	ADXL345_ODR_200HZ,
+	ADXL345_ODR_400HZ,
+	ADXL345_ODR_800HZ,
+	ADXL345_ODR_1600HZ,
+	ADXL345_ODR_3200HZ,
+};
+
+/* Certain features recommend 12.5 Hz - 400 Hz ODR */
+static const int adxl345_odr_tbl[][2] = {
+	[ADXL345_ODR_0P10HZ]	= {   0,  97000},
+	[ADXL345_ODR_0P20HZ]	= {   0, 195000},
+	[ADXL345_ODR_0P39HZ]	= {   0, 390000},
+	[ADXL345_ODR_0P78HZ]	= {   0, 781000},
+	[ADXL345_ODR_1P56HZ]	= {   1, 562000},
+	[ADXL345_ODR_3P13HZ]	= {   3, 125000},
+	[ADXL345_ODR_6P25HZ]	= {   6, 250000},
+	[ADXL345_ODR_12P50HZ]	= {  12, 500000},
+	[ADXL345_ODR_25HZ]	= {  25, 0},
+	[ADXL345_ODR_50HZ]	= {  50, 0},
+	[ADXL345_ODR_100HZ]	= { 100, 0},
+	[ADXL345_ODR_200HZ]	= { 200, 0},
+	[ADXL345_ODR_400HZ]	= { 400, 0},
+	[ADXL345_ODR_800HZ]	= { 800, 0},
+	[ADXL345_ODR_1600HZ]	= {1600, 0},
+	[ADXL345_ODR_3200HZ]	= {3200, 0},
+};
+
 struct adxl345_state {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
@@ -77,6 +116,8 @@ struct adxl345_state {
 	u8 watermark;
 	u8 fifo_mode;
 
+	enum adxl345_odr odr;
+
 	u32 tap_axis_ctrl;
 	u8 tap_threshold;
 	u32 tap_duration_us;
@@ -126,6 +167,7 @@ static struct iio_event_spec adxl345_events[] = {
 		BIT(IIO_CHAN_INFO_CALIBBIAS),				\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
 	.scan_index = (index),				\
 	.scan_type = {					\
 		.sign = 's',				\
@@ -427,13 +469,61 @@ static int adxl345_set_ff_time(struct adxl345_state *st, u32 val_int,
 	return regmap_write(st->regmap, ADXL345_REG_TIME_FF, min(regval, 0xff));
 }
 
+static int adxl345_find_odr(struct adxl345_state *st, int val,
+			    int val2, enum adxl345_odr *odr)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(adxl345_odr_tbl); i++)
+		if (val == adxl345_odr_tbl[i][0] &&
+		    val2 == adxl345_odr_tbl[i][1])
+			break;
+
+	if (i == ARRAY_SIZE(adxl345_odr_tbl))
+		return -EINVAL;
+
+	*odr = i;
+
+	return 0;
+}
+
+static int adxl345_set_odr(struct adxl345_state *st, enum adxl345_odr odr)
+{
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, ADXL345_REG_BW_RATE,
+				 ADXL345_BW_RATE_MSK,
+				 FIELD_PREP(ADXL345_BW_RATE_MSK, odr));
+	if (ret)
+		return ret;
+
+	st->odr = odr;
+
+	return 0;
+}
+
+static int adxl345_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type,
+			      int *length, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = (int *)adxl345_odr_tbl;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*length = ARRAY_SIZE(adxl345_odr_tbl) * 2;
+		return IIO_AVAIL_LIST;
+	}
+
+	return -EINVAL;
+}
+
 static int adxl345_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
 	__le16 accel;
-	long long samp_freq_nhz;
 	unsigned int regval;
 	int ret;
 
@@ -469,15 +559,9 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		ret = regmap_read(st->regmap, ADXL345_REG_BW_RATE, &regval);
-		if (ret < 0)
-			return ret;
-
-		samp_freq_nhz = ADXL345_BASE_RATE_NANO_HZ <<
-				(regval & ADXL345_BW_RATE);
-		*val = div_s64_rem(samp_freq_nhz, NANOHZ_PER_HZ, val2);
-
-		return IIO_VAL_INT_PLUS_NANO;
+		*val = adxl345_odr_tbl[st->odr][0];
+		*val2 = adxl345_odr_tbl[st->odr][1];
+		return IIO_VAL_INT_PLUS_MICRO;
 	}
 
 	return -EINVAL;
@@ -488,7 +572,12 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 			     int val, int val2, long mask)
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
-	s64 n;
+	enum adxl345_odr odr;
+	int ret;
+
+	ret = adxl345_set_measure_en(st, false);
+	if (ret)
+		return ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBBIAS:
@@ -496,20 +585,24 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 		 * 8-bit resolution at +/- 2g, that is 4x accel data scale
 		 * factor
 		 */
-		return regmap_write(st->regmap,
-				    ADXL345_REG_OFS_AXIS(chan->address),
-				    val / 4);
+		ret = regmap_write(st->regmap,
+				   ADXL345_REG_OFS_AXIS(chan->address),
+				   val / 4);
+		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		n = div_s64(val * NANOHZ_PER_HZ + val2,
-			    ADXL345_BASE_RATE_NANO_HZ);
-
-		return regmap_update_bits(st->regmap, ADXL345_REG_BW_RATE,
-					  ADXL345_BW_RATE,
-					  clamp_val(ilog2(n), 0,
-						    ADXL345_BW_RATE));
+		ret = adxl345_find_odr(st, val, val2, &odr);
+		if (ret)
+			return ret;
+		ret = adxl345_set_odr(st, odr);
+		break;
+	default:
+		return -EINVAL;
 	}
 
-	return -EINVAL;
+	if (ret)
+		return ret;
+
+	return adxl345_set_measure_en(st, true);
 }
 
 static int adxl345_read_event_config(struct iio_dev *indio_dev,
@@ -741,7 +834,7 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_CALIBBIAS:
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		return IIO_VAL_INT_PLUS_NANO;
+		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
 	}
@@ -808,19 +901,6 @@ static void adxl345_powerdown(void *ptr)
 	adxl345_set_measure_en(st, false);
 }
 
-static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
-"0.09765625 0.1953125 0.390625 0.78125 1.5625 3.125 6.25 12.5 25 50 100 200 400 800 1600 3200"
-);
-
-static struct attribute *adxl345_attrs[] = {
-	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
-	NULL
-};
-
-static const struct attribute_group adxl345_attrs_group = {
-	.attrs = adxl345_attrs,
-};
-
 static int adxl345_set_fifo(struct adxl345_state *st)
 {
 	int ret;
@@ -1094,10 +1174,10 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 }
 
 static const struct iio_info adxl345_info = {
-	.attrs		= &adxl345_attrs_group,
 	.event_attrs	= &adxl345_event_attrs_group,
 	.read_raw	= adxl345_read_raw,
 	.write_raw	= adxl345_write_raw,
+	.read_avail	= adxl345_read_avail,
 	.write_raw_get_fmt	= adxl345_write_raw_get_fmt,
 	.read_event_config = adxl345_read_event_config,
 	.write_event_config = adxl345_write_event_config,
@@ -1166,6 +1246,15 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->num_channels = ARRAY_SIZE(adxl345_channels);
 	indio_dev->available_scan_masks = adxl345_scan_masks;
 
+	/*
+	 * Using I2C at 100kHz would limit the maximum ODR to 200Hz, operation
+	 * at an output rate above the recommended maximum may result in
+	 * undesired behavior.
+	 */
+	ret = adxl345_set_odr(st, ADXL345_ODR_200HZ);
+	if (ret)
+		return ret;
+
 	/* Reset interrupts at start up */
 	ret = regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, st->int_map);
 	if (ret)
-- 
2.39.5


