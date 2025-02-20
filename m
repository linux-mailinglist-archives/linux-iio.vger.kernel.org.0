Return-Path: <linux-iio+bounces-15837-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFD1A3D721
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 11:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBB587AB3E5
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 10:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D427C1F4739;
	Thu, 20 Feb 2025 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxDrlvyZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AB41F428C;
	Thu, 20 Feb 2025 10:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048172; cv=none; b=fD8bKy4vMyRJhWmKIMfPsJVabtQD60rDRv62WXeriLVtASNlAURYk+QoZnWvXcTMQRy3d9Do97FKHGnYGTdpVxxl2/0TtmTneA0aGIOP7nhIgGRHtgiZwrkFW0ORQ8QkyEOGzCs4hDE+jXtarUvZeq86oSiCuXA+vKXbOgUAww4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048172; c=relaxed/simple;
	bh=lL+hww8qypifEWxDc4Ga7vH211Gpv7Y3QGOVz8+qGkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BVXhVsNsy2eFxSY5SaMd1KQj7EHNWTU9ou+KctzD1REcZnUB8Dclw4Omw/gpLWgORNA94+4Uq2Meu00ztaFoIovzO1AzIngELVvSgbbgqmwMX2kNc+guS7JvoFHXHuwaR3Xt19PGnGiSClvGHLZeH/CfV3r+TiypBsq8ejJMkyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxDrlvyZ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e064eff5daso112560a12.3;
        Thu, 20 Feb 2025 02:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740048169; x=1740652969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUrmgIro4kpHq9lw5fat0MfsUBFGR/sMxiYGfYYR3a8=;
        b=CxDrlvyZdSS6MJZW9cuITYZZEsB+tZSb4ibhyBNrn4/2vKG5niihQxR1p3C/3+8Kf7
         J86fwJ8JMGrFIZc2L6dwHTUmKwwrSxXq4EeBnJIzHealFiG+PyjBIgpNFEFYAI0FJBjx
         vI1LWLun+XBkPYOJxEHr2cupvbuVXe7NYICgmr3gGvsagxJ+8zADY1uLmgVG3fZwYGcP
         SqdNVa3jMKl9vdD3bUXLan2nl2RocFBbhYiQg3hKSnwwQvcy4QvcYEHXPY7EA5zOW9Uw
         9r0ozFDYoshvgcp/dqZP8/IiV1EpDI4I0MAKgwdfzesrQ+AwO/gNzfoXui3jJAHJBccw
         YsWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740048169; x=1740652969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUrmgIro4kpHq9lw5fat0MfsUBFGR/sMxiYGfYYR3a8=;
        b=mbS6qCadxZtSHfXApXuV4ZJISErn+CHl6h1jVOvEP+MOKbT9qD+U8xJd9zyys3aRao
         nKvGwNFLhu2T3WKwmEi9CMnvEN3MTfgbfr9LR7UBZ5/UR3WFxEzEY2RvyY6CCy+19jLI
         o/FTRqy2NOBdwIIWkX3o0Zmt4zPYiv1aArxtolXDymrpQNJV2kNBhxxeSVZBZpdpGn6b
         lXErKnwQ96DTGdIvTy8UwVcc5lL9Z4//Oc5ZS5jcsvJXYZZcVnpSKWlttQyAPDUGNNiR
         NSwUxtWQIMgyERxNwT+1qqXIILac+lZ8H7WGOcQg4vQrhRHZarlRv9MzxYhX+P6AJpZ0
         2JHA==
X-Forwarded-Encrypted: i=1; AJvYcCWsH6+zeAnLEi5RWIyIduCoDvbqt846DbsMcrAVXUatsgfk44Q10adxx1TU8sZGUdFpVVi0bJ9uh7HjPcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhFhn3KXyD49oCWUgsbJUeSFXz0ZNTRaXhuTdOq+m+P5123ZI7
	v1ZeKiDNeK0cMxkLFYbSerc2puqpVh4aTxkR9x/vctlYdOF+5Q1d
X-Gm-Gg: ASbGncuMaE41NibJ7UNe7dtATB+uDVMLziYyvIC1yniyttv7xq8xiSoYonqt3suP07n
	e8k80Zv6APftjeA8gry2ndVyLl48zhv41jpzCjv0/wZAJCHfexQpvIeEVuOfe/3hGlUw/FeFQbj
	9CKYXFsS14Mp91pLZkCqsAeAm6jA/uiFTSKs+hdAg8eE5Sy4vD7HF/eLk3jFaGNc5XlqgiEGLlf
	0/dBHt9t1fTuKVaHSm6Rza4tYCny4XASuKYxsXNIcMAIYm1BG/uBZjmUmWc39G2LoqBw7lmEgRX
	ddTPxGQUvo+qELBOi4RN0ZtqdTvKfPozH76H2YF73iLV1Wxz8GZK0/CHBXjijIRqWsj/cA==
X-Google-Smtp-Source: AGHT+IFQs/AO+xL+HxwjZerlmm6Calnmwm0sJ5il+mi62zDy4q1DngZ1QqR1hnwoZetqouF0aMjGeQ==
X-Received: by 2002:a17:906:6a0c:b0:aba:6055:9ed1 with SMTP id a640c23a62f3a-abb70ab8b8amr843946566b.6.1740048168539;
        Thu, 20 Feb 2025 02:42:48 -0800 (PST)
Received: from 0f997e1ceb21.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbdfcaed55sm246474866b.137.2025.02.20.02.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:42:48 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v3 10/15] iio: accel: adxl345: extend sample frequency adjustments
Date: Thu, 20 Feb 2025 10:42:29 +0000
Message-Id: <20250220104234.40958-11-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220104234.40958-1-l.rubusch@gmail.com>
References: <20250220104234.40958-1-l.rubusch@gmail.com>
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
preparation for activity/inactivity handling. During adjustment of
bw registers, measuring is disabled and afterwards enabled again.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h      |   2 +-
 drivers/iio/accel/adxl345_core.c | 160 ++++++++++++++++++++++++-------
 2 files changed, 126 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index a2a81caa292a..56db8f8ba032 100644
--- a/drivers/iio/accel/adxl345.h
+++ b/drivers/iio/accel/adxl345.h
@@ -71,7 +71,7 @@
  * BW_RATE bits - Bandwidth and output data rate. The default value is
  * 0x0A, which translates to a 100 Hz output data rate
  */
-#define ADXL345_BW_RATE			GENMASK(3, 0)
+#define ADXL345_BW_RATE_MSK		GENMASK(3, 0)
 #define ADXL345_BW_LOW_POWER		BIT(4)
 #define ADXL345_BASE_RATE_NANO_HZ	97656250LL
 
diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 7f842e7f371a..fa169cac5c05 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -67,6 +67,45 @@ static const unsigned int adxl345_tap_time_reg[] = {
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
+	[ADXL345_ODR_0P10HZ]	= {    0,  97000 },
+	[ADXL345_ODR_0P20HZ]	= {    0, 195000 },
+	[ADXL345_ODR_0P39HZ]	= {    0, 390000 },
+	[ADXL345_ODR_0P78HZ]	= {    0, 781000 },
+	[ADXL345_ODR_1P56HZ]	= {    1, 562000 },
+	[ADXL345_ODR_3P13HZ]	= {    3, 125000 },
+	[ADXL345_ODR_6P25HZ]	= {    6, 250000 },
+	[ADXL345_ODR_12P50HZ]	= {   12, 500000 },
+	[ADXL345_ODR_25HZ]	= {   25, 0 },
+	[ADXL345_ODR_50HZ]	= {   50, 0 },
+	[ADXL345_ODR_100HZ]	= {  100, 0 },
+	[ADXL345_ODR_200HZ]	= {  200, 0 },
+	[ADXL345_ODR_400HZ]	= {  400, 0 },
+	[ADXL345_ODR_800HZ]	= {  800, 0 },
+	[ADXL345_ODR_1600HZ]	= { 1600, 0 },
+	[ADXL345_ODR_3200HZ]	= { 3200, 0 },
+};
+
 struct adxl345_state {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
@@ -118,6 +157,7 @@ static struct iio_event_spec adxl345_events[] = {
 		BIT(IIO_CHAN_INFO_CALIBBIAS),				\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
 	.scan_index = (index),				\
 	.scan_type = {					\
 		.sign = 's',				\
@@ -412,14 +452,61 @@ static int adxl345_set_ff_time(struct adxl345_state *st, u32 val_int,
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
+	enum adxl345_odr odr;
 	int ret;
 
 	switch (mask) {
@@ -455,14 +542,12 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		ret = regmap_read(st->regmap, ADXL345_REG_BW_RATE, &regval);
-		if (ret < 0)
+		if (ret)
 			return ret;
-
-		samp_freq_nhz = ADXL345_BASE_RATE_NANO_HZ <<
-				(regval & ADXL345_BW_RATE);
-		*val = div_s64_rem(samp_freq_nhz, NANOHZ_PER_HZ, val2);
-
-		return IIO_VAL_INT_PLUS_NANO;
+		odr = FIELD_GET(ADXL345_BW_RATE_MSK, regval);
+		*val = adxl345_odr_tbl[odr][0];
+		*val2 = adxl345_odr_tbl[odr][1];
+		return IIO_VAL_INT_PLUS_MICRO;
 	}
 
 	return -EINVAL;
@@ -473,7 +558,12 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
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
@@ -481,20 +571,24 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
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
@@ -747,7 +841,7 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_CALIBBIAS:
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		return IIO_VAL_INT_PLUS_NANO;
+		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
 	}
@@ -760,19 +854,6 @@ static void adxl345_powerdown(void *ptr)
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
 	unsigned int intio;
@@ -1026,9 +1107,9 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 }
 
 static const struct iio_info adxl345_info = {
-	.attrs		= &adxl345_attrs_group,
 	.read_raw	= adxl345_read_raw,
 	.write_raw	= adxl345_write_raw,
+	.read_avail	= adxl345_read_avail,
 	.write_raw_get_fmt	= adxl345_write_raw_get_fmt,
 	.read_event_config = adxl345_read_event_config,
 	.write_event_config = adxl345_write_event_config,
@@ -1098,6 +1179,15 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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
 	ret = regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, 0x00);
 	if (ret)
-- 
2.39.5


