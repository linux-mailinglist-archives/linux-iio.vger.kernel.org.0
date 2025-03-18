Return-Path: <linux-iio+bounces-17063-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45363A6808E
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 00:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272C2425E50
	for <lists+linux-iio@lfdr.de>; Tue, 18 Mar 2025 23:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40CB214A93;
	Tue, 18 Mar 2025 23:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCn7RKH/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917D12147EA;
	Tue, 18 Mar 2025 23:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742339346; cv=none; b=P5I8FxNle3TVAWZCVbedq7VufQMz4s3sNSWvue87uEyaFDnNzinoXkrzd6SYiHvwymWq1Yb2lnRDJxhT9Qf6Ucgb5Dq1o5UcrAf7MVOWV5sRYVhKaA+fEU1osm+W/X/Qlfw8cRKdKW8pHEk3PSSm9hsNv2jrbxtmOjkGD7iDH0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742339346; c=relaxed/simple;
	bh=LrgfFaazNtPCpvrYbWwd696COe/34Tg2puXK+eCx3qU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AqBKtX/CflHbdTKjCzPcdTEx+RO4/GW9CdXxzjT+RnIfKiSWi2RunPGb31+SoiWMXj4O1A1QL1i0VAVwjdXgZjz5hx3vnCgXS+qHjXs0oSkhns3vDAyaecZdNn3e04OMLbIa/pwmroa316s4YkaIaYf/B/nPWkpJqXg5doDcPwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCn7RKH/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43ba8bbeae2so5301125e9.0;
        Tue, 18 Mar 2025 16:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742339343; x=1742944143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ny2foABWhgHXyPlG+cE6a95cgoCM9zCjuNRfX70Qcfc=;
        b=eCn7RKH/FGgxU8Ipf9iPr1jGFPNsBmDZktRfELYDH7lZZCdK2PCGDs58sFhDeQMqxt
         X7KtVdA1uyk5yRABQTb1uD7BX243BZGwBBlmyJF8uFNWSm/qkB/wKKZFRR49jolLCeO1
         WukJi/pGhsDWlL0FtZpLMjW81qxMUQfqVB6peQkqKn49N9GQDoco7IzPcotFaaz3tByK
         COlOjnqLQ7fWBKPpaGO+LLZo2upHVBcNch5ndpdg6dYw+r2jQNIZkOJFsmAO49rDC55r
         ifCitOJ7kWedrmOUBhtAx/T353cOxWlnMMrRQGslA9bQQikt4fMQFA5nS8zzBeRDRLu8
         bNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742339343; x=1742944143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ny2foABWhgHXyPlG+cE6a95cgoCM9zCjuNRfX70Qcfc=;
        b=PbyBlUERye5mYGZ2tOg7hQygGoSfScGb62O/RyDPfibaIR/mFSlpCc342ppw3NpPNu
         Md50CIXX/7eH9g2Bdk1gl7WMMeCJi7nH5a9vy3/NqQWRgK75Zl4R5pBCRoMpnoa+KslM
         VGKuyML1cMgPtSHrGcA7LQhASB7gCxpmXfIJkc/YWEAHPWMDdyWYS+Irkkpcie17/e+0
         pfV9G0jzu0bBLm9e9VEaEIyy4U48LgD2ofOBp4Ey0dBW1/s6aI4fciIP1stLAZMl59dC
         qejX7MdpCEhOx3gyPsRCMM9tjiZ/yIF9Tl3PcLseQkDqSaFurRlskE6qOpT6NMolYjxm
         sJnw==
X-Forwarded-Encrypted: i=1; AJvYcCVzLCL2ZjWyR9suKiOumdo1xQE2i6RPa/xo2bGokh0GoktH1vBbJ+7+AK/wg1AUZPl1AUgBH/NX7dk+i8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfy/fEn4ozD+4sun0HanjHLstbfDUejlLXMUi7+vM4jBaYnuFV
	yc8BaRqE6FigsKCVIbFQTpgI208jfxugO1dFPsmnYFKuwOcVnd3m
X-Gm-Gg: ASbGncuq7FUnMAKrVxOW2cNcVPSv9c1VpcgnXBN1bHLb7J9GXHJcjZ+cje2fP4NEqGQ
	lY0LsJI5faMvTCvVZOwIxgNfXKsqklGYfu2qFmGnq01v5HbKJLQKsNip3XIEcxrE9L00SjZLmz5
	YqbFdoOa3va2h1/qLpiD8kpnSS+GFu5TysS6ZckJE+hEWug2NoHULRz55sU3RmWovwDLSS7FEnO
	WzJn4Gy8wekPP0GS75fylSYF8FLi9X9UPVuFfBMcHeGj4PSWOSXhtgRbLrtarlcrS7RM+ZLFzBo
	Tcll3DaTUYYwdsvn/Mkajr00hMwBlQE3/S27HEldnowVldhHvQnZvRKOTiGqwoZCDnVMEwa0JMA
	ZfhP7oeSyZuBVQzD7PxaWRg80IASPUlnMbA==
X-Google-Smtp-Source: AGHT+IHkPSQRzV4ucWVfwfbAq7agyi8SYS2XEJCXewQiNqeMcGCepJ4DEb9vFwl5SKpRsP5CsHokeA==
X-Received: by 2002:a05:600c:4f8b:b0:439:88bb:d00b with SMTP id 5b1f17b1804b1-43d4454b03bmr245705e9.5.1742339342682;
        Tue, 18 Mar 2025 16:09:02 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d440ed793sm1113455e9.39.2025.03.18.16.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 16:09:01 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v5 07/11] iio: accel: adxl345: add g-range configuration
Date: Tue, 18 Mar 2025 23:08:39 +0000
Message-Id: <20250318230843.76068-8-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250318230843.76068-1-l.rubusch@gmail.com>
References: <20250318230843.76068-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a mechanism to be able to configure and work with the available
g-ranges keeping the precision of 13 digits.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 90 ++++++++++++++++++++++++++++++--
 1 file changed, 87 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index d9d786e15156..2ba77f31c3a0 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -83,6 +83,13 @@ enum adxl345_odr {
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
 	[ADXL345_ODR_0P10HZ]	= {    0,  97000 },
@@ -103,6 +110,33 @@ static const int adxl345_odr_tbl[][2] = {
 	[ADXL345_ODR_3200HZ]	= { 3200, 0 },
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
+	[ADXL345_2G_RANGE]  = { 0, 4789 },
+	[ADXL345_4G_RANGE]  = { 0, 9578 },
+	[ADXL345_8G_RANGE]  = { 0, 19156 },
+	[ADXL345_16G_RANGE] = { 0, 38312 },
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
@@ -155,7 +189,8 @@ static struct iio_event_spec adxl345_events[] = {
 		BIT(IIO_CHAN_INFO_CALIBBIAS),				\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
-	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE) | \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
 	.scan_index = (index),				\
 	.scan_type = {					\
 		.sign = 's',				\
@@ -506,12 +541,40 @@ static int adxl345_set_odr(struct adxl345_state *st, enum adxl345_odr odr)
 				 FIELD_PREP(ADXL345_BW_RATE_MSK, odr));
 }
 
+static int adxl345_find_range(struct adxl345_state *st, int val, int val2,
+			      enum adxl345_range *range)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(adxl345_fullres_range_tbl); i++) {
+		if (val == adxl345_fullres_range_tbl[i][0] &&
+		    val2 == adxl345_fullres_range_tbl[i][1]) {
+			*range = i;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int adxl345_set_range(struct adxl345_state *st, enum adxl345_range range)
+{
+	return regmap_update_bits(st->regmap, ADXL345_REG_DATA_FORMAT,
+				 ADXL345_DATA_FORMAT_RANGE,
+				 FIELD_PREP(ADXL345_DATA_FORMAT_RANGE, range));
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
@@ -530,6 +593,7 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 	__le16 accel;
 	unsigned int regval;
 	enum adxl345_odr odr;
+	enum adxl345_range range;
 	int ret;
 
 	switch (mask) {
@@ -548,8 +612,12 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 		*val = sign_extend32(le16_to_cpu(accel), 12);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		*val = 0;
-		*val2 = st->info->uscale;
+		ret = regmap_read(st->regmap, ADXL345_REG_DATA_FORMAT, &regval);
+		if (ret)
+			return ret;
+		range = FIELD_GET(ADXL345_DATA_FORMAT_RANGE, regval);
+		*val = adxl345_fullres_range_tbl[range][0];
+		*val2 = adxl345_fullres_range_tbl[range][1];
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		ret = regmap_read(st->regmap,
@@ -581,6 +649,7 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 			     int val, int val2, long mask)
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
+	enum adxl345_range range;
 	enum adxl345_odr odr;
 	int ret;
 
@@ -609,6 +678,15 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 		break;
+	case IIO_CHAN_INFO_SCALE:
+		ret = adxl345_find_range(st, val, val2,	&range);
+		if (ret)
+			return ret;
+
+		ret = adxl345_set_range(st, range);
+		if (ret)
+			return ret;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -841,6 +919,8 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBBIAS:
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return IIO_VAL_INT_PLUS_MICRO;
 	default:
@@ -1198,6 +1278,10 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
 	if (ret)
 		return ret;
 
+	ret = adxl345_set_range(st, ADXL345_16G_RANGE);
+	if (ret)
+		return ret;
+
 	/* Reset interrupts at start up */
 	ret = regmap_write(st->regmap, ADXL345_REG_INT_ENABLE, 0x00);
 	if (ret)
-- 
2.39.5


