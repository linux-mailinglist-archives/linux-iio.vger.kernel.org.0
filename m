Return-Path: <linux-iio+bounces-18474-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50CABA958FA
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 00:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B6DF1754EC
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 22:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBB22236EB;
	Mon, 21 Apr 2025 22:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhMXA5u7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D217B221FB5;
	Mon, 21 Apr 2025 22:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745273224; cv=none; b=oYM4ifCWAWePTMztWtDObnGKzsr0UH5un5yIrrY34lOr7DWxhg9UhVLaJ0FbmxLyC6OiTSHoQJFijnsf68cMQR2XfVrQU7qmNhNDwx7PvUOfZxhwTwvzyqV0D8twNPFTzLWnrH9gRszoBbT9NLeSLvRTfxuHVo1dZyFxLYMPvFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745273224; c=relaxed/simple;
	bh=98aSFRuIai1zdN24TsddkBKPbh6K9Efhft0eKZwYV38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vm/1sYydY8cSU8R1IbaKlwYjbc1d/C9t80AqD0GkC38OK5XkfpXmjjz6gR3rINFzPoGL+VtGeYSDkjNEDN27TOJ5hdvO5UXcO3Rn5ACg10OGXfevLQQwGpjhcksD+YwwFYAX3JNimhZHZ0Bf5OjuRbypfIQ49H3RBfaZcxfJCDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhMXA5u7; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-acba3f5868eso17915466b.1;
        Mon, 21 Apr 2025 15:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745273221; x=1745878021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stjeSv+bIKrTRcusbfwsDYwsujSG2MwGqMzLbZEAMuw=;
        b=WhMXA5u71yhYj48Zs+MQ/txu8ofTcf8LmB7Y5HEqbMDPU0tAiSY96VjGUlSeleD8d0
         n2GHXBPe8JZ9+oo0DkAzJX5EFOzme0I8EJjezeVLiZZsjmRb7JWTzTiV6yfGUdsc+k06
         zs2gl6vaaC6xWMBFAJ9M+feaMrI0CTmmA2W2r5ED1LbvR1CIiI7aYHyQyoWZTU1HszdY
         MwbS5S6i0cXjs6F5R0WlrAPLc21a9LELmnJOQqqIfTOKOg521zJv6KSfo3F0vorRzcWW
         FNPLBRNI1IjIEhRAUQPxRW4K+nChXaUSA/kFQWJpDD8bua0Y4sjJ8KyQCokwsqO7hJzS
         oV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745273221; x=1745878021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stjeSv+bIKrTRcusbfwsDYwsujSG2MwGqMzLbZEAMuw=;
        b=oAtGZdF6my7uE0+z7fbu6lm6fBADd1/gy38J6wGC5eBwHg/4ykCla+PZHc5LbvzcaJ
         /b9C1/cnoQK7CxBwtz5YLfdy1vwO/TOkG71PmirAEQUTBQVfZhSGcnBik/w0u2HwwQMt
         ltT0Oj4cG/AnnDkyFARFm4z9yHVj0CZCsGToCvof37MN5Np2BxHXhkcfTlWhKEuVj7AW
         iEbJmYSSVxntC9c7pmRYTIFyojlVx8AVG3KBxqvHoYlQT+aQyQb4A513HpUKjiiy4CsG
         F1Qg3TBKZW94YnCgk5cYgH6oblxEP1anOchMwVN/DL/hBs5PtQbU/SJI85odDvIBLsU9
         Xexg==
X-Forwarded-Encrypted: i=1; AJvYcCWZsCR+Gb2wh9Ke1/9JKKOEWY5v65Vd3Ydb1M1YgJOdgg958hJFM4yFzz4SMusEYPlQbNlwhA7Gd7+t5WY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKdBnJWnT8urzifs5CzdKW6JuZFOJln/ORAIvPyX4P9E4+qDXt
	VOYWyVnBGsql7KRHJyNesymWGyLui+4AaClSmf9WJf+7dGETDo9k
X-Gm-Gg: ASbGncvydXiuaJNWY6VQ+JMd7hOqOW/8ft3yGQ+CJTvFIc9JfmVa0AA7iyCxSwA/iFy
	VA+AXXI5nGdhMRm2uRDCkSB/Xqp7bQdAVFTG29rcUF5MSuRNXlVtMNw19G9SCh2C9nwb415gMxj
	aaDEctjQxS4XDMSXf6V8DEGZs7E6tS9j/SQCEqMlqpQhD5rKtJsjGwTqDaFR2tnYDsUmZDp7RCd
	x5Us2jb0Z0YjC7P6YxNPNb6eTT/K/GgciaqZj0lezd8fh53p7H2+TQD/WQlnzsKsvZJkJH7xS5v
	ItElKrE2z8EYQPzW/wvmASjy4sF5Um2oZdsWeHSNDJot3VdxLQnyG994oRq3M/yF+XrJxeOlOlZ
	aCP5HtZqC0mTV4mLQvNs=
X-Google-Smtp-Source: AGHT+IHJ+/LrdriPOjnip6Vxig9V9tRIs83pf6duEYGUGecYxAY8wGsyMTfoT2vj0iHJOSUVfvqLpg==
X-Received: by 2002:a17:907:3e9f:b0:acb:6337:4923 with SMTP id a640c23a62f3a-acb74d85650mr388898666b.11.1745273220886;
        Mon, 21 Apr 2025 15:07:00 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acbb8d49fdasm80311666b.67.2025.04.21.15.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 15:07:00 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v7 06/11] iio: accel: adxl345: extend sample frequency adjustments
Date: Mon, 21 Apr 2025 22:06:36 +0000
Message-Id: <20250421220641.105567-7-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250421220641.105567-1-l.rubusch@gmail.com>
References: <20250421220641.105567-1-l.rubusch@gmail.com>
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

Replace the old static sample frequency handling. During adjustment of
bw registers, measuring is disabled and afterwards enabled again.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345.h      |   2 +-
 drivers/iio/accel/adxl345_core.c | 150 ++++++++++++++++++++++++-------
 2 files changed, 118 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
index 7d482dd595fa..6c1f96406136 100644
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
index f42c861100cd..7ed7ee3a8358 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -64,6 +64,45 @@ static const unsigned int adxl345_tap_time_reg[] = {
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
@@ -108,6 +147,7 @@ static struct iio_event_spec adxl345_events[] = {
 		BIT(IIO_CHAN_INFO_CALIBBIAS),				\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
 	.scan_index = (index),				\
 	.scan_type = {					\
 		.sign = 's',				\
@@ -458,14 +498,53 @@ static int adxl345_set_ff_time(struct adxl345_state *st, u32 val_int,
 	return regmap_write(st->regmap, ADXL345_REG_TIME_FF, min(regval, 0xff));
 }
 
+static int adxl345_find_odr(struct adxl345_state *st, int val,
+			    int val2, enum adxl345_odr *odr)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(adxl345_odr_tbl); i++) {
+		if (val == adxl345_odr_tbl[i][0] &&
+		    val2 == adxl345_odr_tbl[i][1]) {
+			*odr = i;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int adxl345_set_odr(struct adxl345_state *st, enum adxl345_odr odr)
+{
+	return regmap_update_bits(st->regmap, ADXL345_REG_BW_RATE,
+				 ADXL345_BW_RATE_MSK,
+				 FIELD_PREP(ADXL345_BW_RATE_MSK, odr));
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
@@ -503,12 +582,10 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 		ret = regmap_read(st->regmap, ADXL345_REG_BW_RATE, &regval);
 		if (ret)
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
@@ -519,7 +596,12 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
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
@@ -527,20 +609,26 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 		 * 8-bit resolution at +/- 2g, that is 4x accel data scale
 		 * factor
 		 */
-		return regmap_write(st->regmap,
-				    ADXL345_REG_OFS_AXIS(chan->address),
-				    val / 4);
+		ret = regmap_write(st->regmap,
+				   ADXL345_REG_OFS_AXIS(chan->address),
+				   val / 4);
+		if (ret)
+			return ret;
+		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		n = div_s64(val * NANOHZ_PER_HZ + val2,
-			    ADXL345_BASE_RATE_NANO_HZ);
+		ret = adxl345_find_odr(st, val, val2, &odr);
+		if (ret)
+			return ret;
 
-		return regmap_update_bits(st->regmap, ADXL345_REG_BW_RATE,
-					  ADXL345_BW_RATE,
-					  clamp_val(ilog2(n), 0,
-						    ADXL345_BW_RATE));
+		ret = adxl345_set_odr(st, odr);
+		if (ret)
+			return ret;
+		break;
+	default:
+		return -EINVAL;
 	}
 
-	return -EINVAL;
+	return adxl345_set_measure_en(st, true);
 }
 
 static int adxl345_read_event_config(struct iio_dev *indio_dev,
@@ -769,7 +857,7 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_CALIBBIAS:
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		return IIO_VAL_INT_PLUS_NANO;
+		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
 	}
@@ -782,19 +870,6 @@ static void adxl345_powerdown(void *ptr)
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
@@ -1057,9 +1132,9 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 }
 
 static const struct iio_info adxl345_info = {
-	.attrs		= &adxl345_attrs_group,
 	.read_raw	= adxl345_read_raw,
 	.write_raw	= adxl345_write_raw,
+	.read_avail	= adxl345_read_avail,
 	.write_raw_get_fmt	= adxl345_write_raw_get_fmt,
 	.read_event_config = adxl345_read_event_config,
 	.write_event_config = adxl345_write_event_config,
@@ -1129,6 +1204,15 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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


