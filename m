Return-Path: <linux-iio+bounces-16796-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B87A5FCA7
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 17:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E1617DDB6
	for <lists+linux-iio@lfdr.de>; Thu, 13 Mar 2025 16:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F91026BD98;
	Thu, 13 Mar 2025 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YzlWtyhE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F2726B2D4;
	Thu, 13 Mar 2025 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741884680; cv=none; b=bjzd7k7Wbmkp/ceJ6w92QVbI5POTO7SbqKilmwoLujQbx8eo0MnRgp8zKTe8aqSgjPrEpCO5EU4MLU0R03XgYPh29h7rkFHm6kwzI/fGaTnM4ent1Mop2MBL/d27FfSwYCVUvs7B7Kzxlh+RVsr4aq/GKh1dBY34QyrXGp0uoP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741884680; c=relaxed/simple;
	bh=jqNWEBfkLVFk14WdzeEWu7UNooHmZpSCV9iQkkaTLxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t2NkZA7iPRbA6Ozn/0V63NcCrp6KA/t1u91Oev/SDkjtrJvc6hTXV0ZuNHY/lT3ZNOYuuYWFNhkiQ1rbrBls+uOZjZK2CMIYo1WYQQPtDpIngRl9SpE2dsHcAg4jE4+cv4I1ynZoF3KuMi6ir+0hgQ6wnUMr6uQFUr/3s9UsfR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YzlWtyhE; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac30d4ee0f5so15650466b.0;
        Thu, 13 Mar 2025 09:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741884675; x=1742489475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TX68PgRmI1fMEh5Bmh8IcZ3GDbagprHUKDeqzIRqfZI=;
        b=YzlWtyhEy6G0I093t+4ZzN/a1a+ncSyUXomE3V4n9sUZpPB5f53oCazCDxoHg4g5p4
         iRIf6xQwQ7wClFrjQ+1OWAKa4QNkVHwsPY/R/DxqzhsvYbVKWKo7WQpbr22pomXt2Uhi
         D5Yzmvxg6oBMDx/KgXUuxolra1bMeTqrzy+MxwV40IF3+mCy+RRYDQ9RVcfXkstUTYdg
         TJb5aqDLzfyiDieGUnv12lr2ORQFrX4sOzDZ28aV2duAo5OowfiranoyvFEzQgkX5dre
         pWujhrygAJs5bd9e0wNKRP0d9POK2jzLRnyGbLmDHV0SZrsS6a0y+8hlNMdOCfvDlASM
         EJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741884675; x=1742489475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TX68PgRmI1fMEh5Bmh8IcZ3GDbagprHUKDeqzIRqfZI=;
        b=EomoMkFjClmqsBVeMWtZW3zTHyAhXLElv1Xen0glmjCXfpIQZv6Q/cOGLnSF5258K0
         skdoaBRwEEuwGMpfHdoEuh8/uJ+OdHVJskTtE+hMPZhpZy4dvRLfxJ0Z0LTspwFgzm+k
         6THJBN0crYhcnrVR8iZjDxAe46pX6bnZ6Cx3AIpbzu4RJZNgghk3SWQG+5S0xdU+AN+q
         o4WmKKKO/6vt2TJKsPqfrFYgMtw2joZ5oAkeaV3Dk0fT0Fkh/ZVZpLLjwQV43ttkq3pa
         vM2mvE3axLzN1Q179TW69X3f1xXYHBqVZb/ZIysJ5Sp2DjYLyfS5xLbaTOGGMCNCUBXL
         /v1g==
X-Forwarded-Encrypted: i=1; AJvYcCU7GyzAMdHjpNQJgnCiVYVnfy5GLtyAwVBOaCzlOH98h1EVRu4maQL7y6bk5BcoW9P8lC7Vocj/SVmfD4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb++g0kCCNBarJKoN+9GPcW737JyhflowiJ6Dfq0yM4nvRY4wo
	V95in9ned2BSqf3o/nCwKxSbvZKrXskQVmjidaHNFE3xvxku6k0g
X-Gm-Gg: ASbGncsUu6mOxM5NxtH5B8psAmOm2xIJ/FqVcPH9HrxEkUO8H1MZLEnHD28o76gFqSk
	gq2+Ej1swPhCoWJXNnd2Q4hVe6kVAqNfxsajeHxXLQCOLUtFPgnmQNd7DAYggB/Py1sNzf0s62T
	8eunX9SjCfO38pKMjBLwmMcO/F1gjvTEePAjSzRNYJTZ+0h4vwVge4A1R9u/xtxwRLqh9IA6+TK
	vzCaBrRCRQOtB4NNpQ76u58am+HlHea42XAGFf+vI4UPkleXJ5IPS9vE8pn8TvutdbF9IUpaaG6
	RROznzK2rChLH9bN2xROjKSsfgMFvgLgnuTk0Am7E5yjjENmZHlsj7yvyiHn4H4xRITz7IgEKSN
	Bp7xsHFZIfPSV/DaPNbWcOfw=
X-Google-Smtp-Source: AGHT+IF/LzaT7vmd0tTVETJ+e05T3B/0wimsiwvnuVPgHqXHSqHfRqPFeyNn5Wd1DxGgVT7IJpXtJw==
X-Received: by 2002:a17:907:86a5:b0:ac2:6d18:ff36 with SMTP id a640c23a62f3a-ac271594e2amr1009568866b.9.1741884675132;
        Thu, 13 Mar 2025 09:51:15 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147efb0csm101370866b.65.2025.03.13.09.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:51:14 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v4 10/14] iio: accel: adxl345: add g-range configuration
Date: Thu, 13 Mar 2025 16:50:45 +0000
Message-Id: <20250313165049.48305-11-l.rubusch@gmail.com>
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

Introduce means to configure and work with the available g-ranges
keeping the precision of 13 digits.

This is in preparation for the activity/inactivity feature.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 96 +++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 4c5084497def..de9202126f70 100644
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
 	[ADXL345_ODR_0P10HZ]	= {    0,  97000 },
@@ -106,6 +113,33 @@ static const int adxl345_odr_tbl[][2] = {
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
@@ -158,7 +192,8 @@ static struct iio_event_spec adxl345_events[] = {
 		BIT(IIO_CHAN_INFO_CALIBBIAS),				\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
-	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE) | \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
 	.scan_index = (index),				\
 	.scan_type = {					\
 		.sign = 's',				\
@@ -515,12 +550,46 @@ static int adxl345_set_odr(struct adxl345_state *st, enum adxl345_odr odr)
 	return 0;
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
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, ADXL345_REG_DATA_FORMAT,
+				 ADXL345_DATA_FORMAT_RANGE,
+				 FIELD_PREP(ADXL345_DATA_FORMAT_RANGE, range));
+	if (ret)
+		return ret;
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
@@ -539,6 +608,7 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 	__le16 accel;
 	unsigned int regval;
 	enum adxl345_odr odr;
+	enum adxl345_range range;
 	int ret;
 
 	switch (mask) {
@@ -557,8 +627,12 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
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
@@ -590,6 +664,7 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 			     int val, int val2, long mask)
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
+	enum adxl345_range range;
 	enum adxl345_odr odr;
 	int ret;
 
@@ -618,6 +693,15 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
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
@@ -847,6 +931,8 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBBIAS:
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return IIO_VAL_INT_PLUS_MICRO;
 	default:
@@ -1202,6 +1288,10 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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


