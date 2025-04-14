Return-Path: <linux-iio+bounces-18111-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6285EA88B96
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 20:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDCA47A3523
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 18:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334D728BA8A;
	Mon, 14 Apr 2025 18:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXNBOfZA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D32628E60E;
	Mon, 14 Apr 2025 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744656179; cv=none; b=SugIIIcliTC3lnxcESWmSalcUDTHeLvnjueE+yMbaAnQWQZketW5nNxWCDKhNjNCmH5Ube0zf5WDY07eteHzRfkBaXiMdiRtHNSjzwa71Ipx51gK3VlrztDSrEBJMFL/B9t+RcTb7P/z/1+2RNQd1RQHogcRkHwowLtXMRCBlEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744656179; c=relaxed/simple;
	bh=fHwXgbeTUx55u7qQiE27sU7Pm7D/CJPjxJSy0vTc3GA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T5jIvUWOnOYssYx+/LjRC6SSsz0n69ucxg0vRlMdoKwOpO7D3GDIi8L3jkSY/uvgX0Kb1Z0IXk5nAp1RkFiLqZKIdXHaJh4BuUJlj7FhOhDTAGbBCLXvIZaUZSrj1Di/fiF3DPH0Bka2KlDR4OxzjKZVmOrM5Iny/yiksCS48/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXNBOfZA; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac8128270f3so86848666b.0;
        Mon, 14 Apr 2025 11:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744656176; x=1745260976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBuMDPL8y3kIgNjvfFIK/7ctpt/vRvY4qU5++88fPtI=;
        b=BXNBOfZArBHj4fIFd9TgiU9gU1KeHkzIif1Ugx9BsPBbOC8HaEYpw/9L4B/HZLGnUb
         i2sGvnic1UeCj0xddqpl+JinI6aO0Wu5roGyoIlOX6FbXFfIE+uMCCBwil4tEUARJT2q
         BHgm+dJCVUaSaT0H+wUA4bDBgV8yPm2ro5ssuaLGHY/I9dsQDs4+pJZ1anXK1iUZ+rgs
         o/Dx3st1cksPrbxtfVfHAMiSG/xNnFWNou0JHsb0vlfDxnDXE8qUrtfu4YJsfsvxBpCo
         O6fWM+LRGNGZ33/xy5VUC5d+TuW/2E02tA9qt8Tm2r/8w/+BdcsRL/euQjBGLFFD/kub
         cr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744656176; x=1745260976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBuMDPL8y3kIgNjvfFIK/7ctpt/vRvY4qU5++88fPtI=;
        b=w97+TbDxWZeoFU/MQn/R87qLa4SyFErm2vLxBE08BEXO7Xz0bwpaY6WtpuawYKk9Y0
         DdpPuSHsNjuGC/C3Ww68CFNZUNIAE6ZNXjG4xOfqNqYNq3AITbZdkFxHelSQLJD5Aegh
         QdYsak7h5MkpHI8+9DH8Po21+q9ZInqX1Suiy9szhEdgnr/sA8D4Y/rGE0UNRlGeoQ1c
         e7+E8eqiwycniN/XJqTaHeka2WmacR6vVWVImFtPBDRPXI3DDRJT8nIJxG9QOgFC6Jlo
         RaP9Fyf2A5+Gp+lzUWVkVBw9rcAAVtQ8NgCe2/M8Xv1clgGgVonOO1u3Wm88bqNIFQSX
         MJZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXavGB67UtYwg3oSkaEqSx1rQd/XhLpMrDHz8OQECYQt9ybODvc5/KltpNPSA3bPWmSj3HWviI/Ab12+oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIbi1uJHA4xC2WyyJhsTbgx8rylUQQLs9WW4UmD0hWz3lnxIiQ
	RBMhdREeWYRvYeofYjnaLwgm5v2IRNnLn92QmqxMRAbw0jzicPj0J06jMg==
X-Gm-Gg: ASbGncsuEmbALnxqnuH/JPVoGOPZ1pXHC7Ig81BCIw58YpVh8FOZ5cnJQjq7C7gewbB
	txwmfx7UZlx2c578J0ih7ioZv4HVNCy/VNId+Bb+Ys7/j+gh/TbxWjBWKgFv2U8xRMXRcfBK/wQ
	64UudKin3Nhbf79GiDo9dpSJ+VhY6JLr2AT6XE1pEKLMN7x3IQMj4VwKdL+qR4nWcelK67VyoA1
	rmw3zUtLK3CmUQGbAxQEdz2asNUemSfaixyEVJXunPnM2zA4maLLydG6bmzd9B1WavBj0yLpQfe
	CLMB+lCESpCesJAv5UsKJKO8TGyHkHlI4wPFV0lD8nfDS0RUEXp3YMe7e6kOJCNPzgb4Id4X7+H
	ZP7CldzD9jIyKE42/uXA=
X-Google-Smtp-Source: AGHT+IGtG0xb95YaJvCuO28eKltbb7/qiwxfEyQc99Or+Q9jVEPCZylKx2xIUYhisbSP/9vwq2mN8Q==
X-Received: by 2002:a17:907:7f8b:b0:aca:fcb3:f0c5 with SMTP id a640c23a62f3a-acb1409c4e6mr16079466b.16.1744656175223;
        Mon, 14 Apr 2025 11:42:55 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bb3172sm946483466b.24.2025.04.14.11.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 11:42:54 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v6 06/11] iio: accel: adxl345: extend sample frequency adjustments
Date: Mon, 14 Apr 2025 18:42:40 +0000
Message-Id: <20250414184245.100280-7-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414184245.100280-1-l.rubusch@gmail.com>
References: <20250414184245.100280-1-l.rubusch@gmail.com>
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
index ae02826e552b..3db757edfad3 100644
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
@@ -116,6 +155,7 @@ static struct iio_event_spec adxl345_events[] = {
 		BIT(IIO_CHAN_INFO_CALIBBIAS),				\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
 	.scan_index = (index),				\
 	.scan_type = {					\
 		.sign = 's',				\
@@ -449,14 +489,53 @@ static int adxl345_set_ff_time(struct adxl345_state *st, u32 val_int,
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
@@ -494,12 +573,10 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
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
@@ -510,7 +587,12 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
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
@@ -518,20 +600,26 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
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
@@ -760,7 +848,7 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_CALIBBIAS:
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		return IIO_VAL_INT_PLUS_NANO;
+		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
 	}
@@ -773,19 +861,6 @@ static void adxl345_powerdown(void *ptr)
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
@@ -1048,9 +1123,9 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 }
 
 static const struct iio_info adxl345_info = {
-	.attrs		= &adxl345_attrs_group,
 	.read_raw	= adxl345_read_raw,
 	.write_raw	= adxl345_write_raw,
+	.read_avail	= adxl345_read_avail,
 	.write_raw_get_fmt	= adxl345_write_raw_get_fmt,
 	.read_event_config = adxl345_read_event_config,
 	.write_event_config = adxl345_write_event_config,
@@ -1120,6 +1195,15 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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


