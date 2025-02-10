Return-Path: <linux-iio+bounces-15257-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C65EEA2EA6C
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 12:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AEF51683AB
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 11:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3171E9904;
	Mon, 10 Feb 2025 11:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBQdzRXr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779E31E5B78;
	Mon, 10 Feb 2025 11:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185308; cv=none; b=u1gQ2izf3Qzv+HHe2QZq7mTPkBAufipMlA8QLZrLTGAQnxUn+U8qzVTx/tbEQXC0SfigHZsUj/UjfBM3i3/3MwhKiLlOODdbPqxyptuWE/Rxej2fJA4zipmEKIfujgaaQBk/8UQD96wA9NBYEn4lugNVMKEGmR08cqW8MnUD7c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185308; c=relaxed/simple;
	bh=AxduA5N6RniqLvGPR9UTTrkRiYuO3uiymx8fWSoHcWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J8TNDfFJWD1eP5ptvjUGF1aEsqNItJSrnDAQger54kwWMGqQiI03xpz8nsB6NnLpWt+pj17SWY1k/hfizLjgfsFBsuQpAUalSfacZavgc3PKiM0t8jlqjemoEaXZckBjlwXLCpLwOSkqGu8JViFpbyM6wIpqKP0ZPWY7T6li2AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBQdzRXr; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ab790ca8a87so47704266b.3;
        Mon, 10 Feb 2025 03:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739185305; x=1739790105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLLUSJLHC8M+tnH5MickWN0AxH4wHkhY6ACxanQQxQg=;
        b=kBQdzRXrykQU08arQ/O9Z5obP1uMuUft1Vo1OETDFPZqwCLWwNmGt906iRFiUe4Ku0
         884GtBT8Ka1T40mNMEaSepI9AUUZvev4NeWDRxUY6DFkgtVyMyBn7iehvW08MXcYAxT9
         3/k2IK8Dl9VVsgG8vQY7yYbNV2As1QBcb6YqjFNstMGDlQVK2Fr3qQunywmon6uh00iL
         n668M/E1jrcGFIxNp8n0oxKwp36EK+nZbwogOXe+Da2eCrJmEd+UqO/BqVbXapzzVsUq
         MoWdzrUUz8hzkcqyla1ltze1ZX1rbH8mpBrVVLDaS/0pm3u7fiEM0jkeizQ5bfYjOYIe
         IwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739185305; x=1739790105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLLUSJLHC8M+tnH5MickWN0AxH4wHkhY6ACxanQQxQg=;
        b=lVFfOQDEYijuhs3SI+A3mptCoi2X/dl/Sw5BYX/w7otTzfk2OzskG0yzF9z/oJ4pNd
         ttP6uRX9OA/f5OAgY/ZPqj64wf/ZuzqpV8ywypUs46umUOvwtbe4tMyFDjOx+MEVCLvq
         hRUUV25bw4jW5JP7VGhr3fbvryBYEGPvxZ9UB/bie5M2Gl7YEGLMvvtDinn4YUFcO/XF
         FK1nCEVuaWcOOAQSdfw6EzYI+el21h5wgYKmZ47ovYO9SMTdLFrBM6CUdzsPDcxtPVF1
         685KFN+las9CZGYYYe4H5lAK52MV6l7MoOu0CaqjDcjSjYZwem50AyqSMZtvuAePw4Jd
         axcw==
X-Forwarded-Encrypted: i=1; AJvYcCUKgAnorNztRng+1XjHmJzJJ6d2TmR8rmCqRCOWLe9pqD4zAU92aiYCLlpv+LARVANTzCse6ocp1qgCdSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGVGPRgqhfasJMKQjlRdbBkI3mZsFbwnNibYO9PU/CXV12h1If
	Rvh4a8IEic2DUWsLOnFokVWtb9yyg0amty47hG8GMBS0y9P34d6d
X-Gm-Gg: ASbGncvLI4JTuYlhE4JradNbMzglfKsiMqUdirJ6mJUubPcAyX2ZWSXU1nMlC7a815I
	uO/UFbaeuh+MvwTp27sDGJ/pqWVrcYf0i4yKKiHI4GsSIMDp9XDzI10tvwXx3bCbeSnIZqnnXbv
	3t+b6GNK+nkW2UJLlyvvy5jByqaM7Z5pj40nLaJ69WCu6U4tZa6URRIAPh6Y10BlrvyeGoSa/Sc
	2d9j+/GQaMe35OxhQCP+j/uL3Au2ibwB2eXKz2XnnPN/tzpWirPKVbCAywUw/+3a+Z5XOpGFNqe
	LP7Rfti9bsuqUCyG/7I/eG1HdW4m4JOza8pGkCYYCZKCBrmJVijUmaVBDNQkKyQa31sCGA==
X-Google-Smtp-Source: AGHT+IFgpFy3p7nzaz1msT1PyoA6FpCcQy+53QvjnVfWBhWssskqUmKSu/trOzSipFwhugpqiPE45A==
X-Received: by 2002:a17:906:c146:b0:aae:83c7:fd4e with SMTP id a640c23a62f3a-ab789cb9ee5mr518392666b.13.1739185304452;
        Mon, 10 Feb 2025 03:01:44 -0800 (PST)
Received: from d9dabf0abd47.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7a5a78369sm486987266b.136.2025.02.10.03.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 03:01:43 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v2 10/14] iio: accel: adxl345: add g-range configuration
Date: Mon, 10 Feb 2025 11:01:15 +0000
Message-Id: <20250210110119.260858-11-l.rubusch@gmail.com>
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

Introduce means to configure and work with the available g-ranges
keeping the precision of 13 digits.

This is in preparation for the activity/inactivity feature.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 92 ++++++++++++++++++++++++++++++--
 1 file changed, 89 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 08ad71875c5e..ea7bfe193d31 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -86,6 +86,13 @@ enum adxl345_odr {
 	ADXL345_ODR_3200HZ,
 };
 
+enum adxl345_range {
+	ADXL345_2G_RANGE = 0,
+	ADXL345_4G_RANGE,
+	ADXL345_8G_RANGE,
+	ADXL345_16G_RANGE,
+};
+
 /* Certain features recommend 12.5 Hz - 400 Hz ODR */
 static const int adxl345_odr_tbl[][2] = {
 	[ADXL345_ODR_0P10HZ]	= {   0,  97000},
@@ -106,6 +113,33 @@ static const int adxl345_odr_tbl[][2] = {
 	[ADXL345_ODR_3200HZ]	= {3200, 0},
 };
 
+/*
+ * Full resolution frequency table:
+ * (g * 2 * 9.80665) / (2^(resolution) - 1)
+ *
+ * resolution := 13 (full)
+ * g := 2|4|8|16
+ *
+ *  2g at 13bit: 0.004789
+ *  4g at 13bit: 0.009578
+ *  8g at 13bit: 0.019156
+ * 16g at 16bit: 0.038312
+ */
+static const int adxl345_fullres_range_tbl[][2] = {
+	[ADXL345_2G_RANGE]  = {0, 4789},
+	[ADXL345_4G_RANGE]  = {0, 9578},
+	[ADXL345_8G_RANGE]  = {0, 19156},
+	[ADXL345_16G_RANGE] = {0, 38312},
+};
+
+/* scaling */
+static const int adxl345_range_factor_tbl[] = {
+	[ADXL345_2G_RANGE]  = 1,
+	[ADXL345_4G_RANGE]  = 2,
+	[ADXL345_8G_RANGE]  = 4,
+	[ADXL345_16G_RANGE] = 8,
+};
+
 struct adxl345_state {
 	const struct adxl345_chip_info *info;
 	struct regmap *regmap;
@@ -117,6 +151,7 @@ struct adxl345_state {
 	u8 fifo_mode;
 
 	enum adxl345_odr odr;
+	enum adxl345_range range;
 
 	u32 tap_axis_ctrl;
 	u8 tap_threshold;
@@ -167,7 +202,8 @@ static struct iio_event_spec adxl345_events[] = {
 		BIT(IIO_CHAN_INFO_CALIBBIAS),				\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
-	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE) | \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
 	.scan_index = (index),				\
 	.scan_type = {					\
 		.sign = 's',				\
@@ -502,12 +538,50 @@ static int adxl345_set_odr(struct adxl345_state *st, enum adxl345_odr odr)
 	return 0;
 }
 
+static int adxl345_find_range(struct adxl345_state *st, int val, int val2,
+			      enum adxl345_range *range)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(adxl345_fullres_range_tbl); i++)
+		if (val == adxl345_fullres_range_tbl[i][0] &&
+		    val2 == adxl345_fullres_range_tbl[i][1])
+			break;
+
+	if (i == ARRAY_SIZE(adxl345_fullres_range_tbl))
+		return -EINVAL;
+
+	*range = i;
+
+	return 0;
+}
+
+static int adxl345_set_range(struct adxl345_state *st, enum adxl345_range range)
+{
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, ADXL345_REG_DATA_FORMAT,
+				 ADXL345_DATA_FORMAT_RANGE,
+				 FIELD_PREP(ADXL345_DATA_FORMAT_RANGE, range));
+	if (ret)
+		return ret;
+
+	st->range = range;
+
+	return 0;
+}
+
 static int adxl345_read_avail(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
 			      const int **vals, int *type,
 			      int *length, long mask)
 {
 	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (int *)adxl345_fullres_range_tbl;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*length = ARRAY_SIZE(adxl345_fullres_range_tbl) * 2;
+		return IIO_AVAIL_LIST;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*vals = (int *)adxl345_odr_tbl;
 		*type = IIO_VAL_INT_PLUS_MICRO;
@@ -543,8 +617,8 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 		*val = sign_extend32(le16_to_cpu(accel), 12);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		*val = 0;
-		*val2 = st->info->uscale;
+		*val = adxl345_fullres_range_tbl[st->range][0];
+		*val2 = adxl345_fullres_range_tbl[st->range][1];
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		ret = regmap_read(st->regmap,
@@ -572,6 +646,7 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 			     int val, int val2, long mask)
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
+	enum adxl345_range range;
 	enum adxl345_odr odr;
 	int ret;
 
@@ -595,6 +670,12 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 			return ret;
 		ret = adxl345_set_odr(st, odr);
 		break;
+	case IIO_CHAN_INFO_SCALE:
+		ret = adxl345_find_range(st, val, val2,	&range);
+		if (ret)
+			return ret;
+		ret = adxl345_set_range(st, range);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -833,6 +914,8 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBBIAS:
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return IIO_VAL_INT_PLUS_MICRO;
 	default:
@@ -1252,6 +1335,9 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	 * undesired behavior.
 	 */
 	ret = adxl345_set_odr(st, ADXL345_ODR_200HZ);
+	if (ret)
+		return ret;
+	ret = adxl345_set_range(st, ADXL345_16G_RANGE);
 	if (ret)
 		return ret;
 
-- 
2.39.5


