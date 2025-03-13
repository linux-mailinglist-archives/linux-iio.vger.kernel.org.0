Return-Path: <linux-iio+bounces-16795-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D439A5FCAA
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 17:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A12F3BC56F
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 16:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA6F26B97D;
	Thu, 13 Mar 2025 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBavY/Ar"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEE526A091;
	Thu, 13 Mar 2025 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884679; cv=none; b=kmveaTH1oBsAqmpvb774+VfV/DvB+3YT20IZUaOmt6BEjKcx8tOMRX1lasoBpGpYtzi+RMq/luREo5z4cv1z6l5DmXLf+w9HBKGKdbxcOLxSP7Bl94+wZLD8LjnjWmoV/Nl3Kt5c2JtGI5kfSpfAEvZgtx/VKHYHLF1sxegz2Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884679; c=relaxed/simple;
	bh=WDMnfz2lrKlD97BGdcJfElEY9mv6VWuliK7cOcXCBBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gt/eTmwCXzJkpWyR4RXXIs98mDt/Pkf9DkiuQe1lKOLUZgL6PYYhHQyF0c4QArC7Zb4qKOI3bEw1hKUCb1OoPKvL8AXc+S6xPDJB67i+yYSV8REUxIPnJtygeW1OEdOTmDoXapV1BugX5wwD8hcnNhEZWK6dplqUPuiFMvK2RX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBavY/Ar; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e8484bb895so103064a12.0;
        Thu, 13 Mar 2025 09:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741884674; x=1742489474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqlCbLOC3QTaQS/vmCmZmcBwbGU9HBbdt6rGZi4UwZE=;
        b=eBavY/ArppC5kCHWhzioNtoQ43aM3cqUyKNFU0URDtZOfmFa7+d2ZxgZm9CJbSYq5V
         LNAJFSSbwWxgWmzNG5Frj5MBaSnI96hxaQF8f+ezthhQfES2DC3yxQNdo53vBUXnGUdD
         wFFxMtEJqrxGfggUaPYlf5fIU4pC/Mc1B/CO9/Wp7UV0AnNmvstbhFyniRtjrTzQhpO3
         AYChAoLcfoRCkNome+JMyAnX4xC4Cjd1OMyNxMMoj43wkvxMLVT+0hBaqZNZtNm/+cJc
         YQzY0jo4IVI/uJ9WCUn1XKLyRM6ZCUVsSG3j48kt1ymb7swqUiX5KbEaBzCQhuewX+Rn
         Hb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741884674; x=1742489474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqlCbLOC3QTaQS/vmCmZmcBwbGU9HBbdt6rGZi4UwZE=;
        b=Ryodk625B5BOZS5nkYIP0H2BNwn4yEPPpOzZ7WHQHBjuWaa1EgB2uPT/XDdWZf9bCY
         oGi9FPsiGhL3A4PmGeu3AxYwhTASGMU0oye4HlOZ0ltlh2w3g7XbJs/8rcolphnwXwOj
         bEm1+7fdoUaxM+hL16sk2UgoCm0g2DKziIElLOz/j9ITJQne9B9ejQqwCDJ7oPTqk++3
         20OwuZ//xS8XI9sA4chswJ1ZTXpxC5sBBERaYWf9RsRToUpwOamFpL0ZWE8wBN1bG+nM
         lEFaWu8m4Vw4u/rUzzmpSIr8FQCcMbXzgnpXdc6pflOUe1JAsPqRW4ai2mtFI3bmkp8+
         FVKg==
X-Forwarded-Encrypted: i=1; AJvYcCWiUzIwB9XG2VIHWYeZUsE6RNu76r1qQ3yStT1QZbWGsvu1svEmnrim57NkWMczBbb+VeDzZzUY9qb29no=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvJXmzKQbInrPXcsBExPpdIvNQSmYm7QwXJbh+FHhSwrAcKLQ6
	KgTrIqVNF9i4Ax/EF9k3OWSVBWMvhvUsFtPb/nmunvJAEa7glVCY6CXVqB40
X-Gm-Gg: ASbGnctl+fwD8JkbQn2Erq6gp78bO28ijdcR7JROQhMJcQkF2AHsrn2t1P8rqqBUFE4
	oj7Vxv6n+GktGNXQVBz8KNacTPysamIbhlbKlcKi71smqS7VKozw5VMei5vS2m6lwkoMmF7kvM+
	chqrFj/DGbGOkiP2pQw8oTIPRQrEezwPt7WsrsUxu87d/wCdrG+yk/tn7esync0i+QL8ipc8nIw
	TEwj7RO/37QfkSMRsyETJMt0PAW6/+VSZMHrQ/ndLYZ8CGmw0cbG3dOyJ8MM9ZQQlKI2tuhztbU
	qhyxVTMqa1ePUtmv4KYabvUIII6pWb40hUCBqkfBS0YhlPAcjGPt4vtkxo0tJnPaNbgWn5XGaO1
	7RdSSFXmBjqM4MitG1diHUKk=
X-Google-Smtp-Source: AGHT+IEZ6EujTvVNuOm3xDoQYokBsKC2xYQzoaOyZl/HM3zu5wgxhTcyVax7PTxjpX2oAxcd3LCjUA==
X-Received: by 2002:a17:906:f5aa:b0:abf:7a26:c45a with SMTP id a640c23a62f3a-ac2b9e55560mr634227466b.11.1741884674226;
        Thu, 13 Mar 2025 09:51:14 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147efb0csm101370866b.65.2025.03.13.09.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:51:13 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v4 09/14] iio: accel: adxl345: extend sample frequency adjustments
Date: Thu, 13 Mar 2025 16:50:44 +0000
Message-Id: <20250313165049.48305-10-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313165049.48305-1-l.rubusch@gmail.com>
References: <20250313165049.48305-1-l.rubusch@gmail.com>
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
 drivers/iio/accel/adxl345_core.c | 156 ++++++++++++++++++++++++-------
 2 files changed, 124 insertions(+), 34 deletions(-)

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
index 1a2bf0c630c9..4c5084497def 100644
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
@@ -119,6 +158,7 @@ static struct iio_event_spec adxl345_events[] = {
 		BIT(IIO_CHAN_INFO_CALIBBIAS),				\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
 	.scan_index = (index),				\
 	.scan_type = {					\
 		.sign = 's',				\
@@ -446,14 +486,59 @@ static int adxl345_set_ff_time(struct adxl345_state *st, u32 val_int,
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
@@ -491,12 +576,10 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
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
@@ -507,7 +590,12 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
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
@@ -515,20 +603,26 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
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
@@ -754,7 +848,7 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_CALIBBIAS:
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		return IIO_VAL_INT_PLUS_NANO;
+		return IIO_VAL_INT_PLUS_MICRO;
 	default:
 		return -EINVAL;
 	}
@@ -767,19 +861,6 @@ static void adxl345_powerdown(void *ptr)
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
@@ -1040,9 +1121,9 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
 }
 
 static const struct iio_info adxl345_info = {
-	.attrs		= &adxl345_attrs_group,
 	.read_raw	= adxl345_read_raw,
 	.write_raw	= adxl345_write_raw,
+	.read_avail	= adxl345_read_avail,
 	.write_raw_get_fmt	= adxl345_write_raw_get_fmt,
 	.read_event_config = adxl345_read_event_config,
 	.write_event_config = adxl345_write_event_config,
@@ -1112,6 +1193,15 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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


