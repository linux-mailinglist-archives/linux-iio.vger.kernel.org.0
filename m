Return-Path: <linux-iio+bounces-15838-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C633BA3D71A
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 11:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A7D23B96B3
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 10:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEFA1F5429;
	Thu, 20 Feb 2025 10:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLx37zRl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F6C1F4615;
	Thu, 20 Feb 2025 10:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740048173; cv=none; b=JmPG1hYffDNRNta7zqOhdLY+nkruFI9EAaY9m/oa2A7qrahsGMoBSRUd3nwWn+NgqzCHqypUWqJANESyooedvXQT7gIfB7PySrV2aBDwPpldcaLleG7A8/Iiqjh37cN+NKwdIkVXMW8a6aXAA0EoPszR6TlHvOz+NS1fp9uL4x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740048173; c=relaxed/simple;
	bh=LxtIrUFteDDKmKcX/ZnsaTUAF/4mrLvV0rdrAa2Bqjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R+puiIFWPCtf10XLn84LoU2DW0Ijlg89wr3q9/T9b9KhXW3CN2BMNABZ/eKtI6H3+CIErGRzHW97SB5EvBDK5R3p+QjVf6Ki8wnygRmtkFRCShwZzl/45RVPrDEGygWZOzvWtaLskYdqQMf3Qu/PyMZZH+Q4x0UiAUSsU4xqCMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLx37zRl; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e02e77ea3cso114310a12.1;
        Thu, 20 Feb 2025 02:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740048170; x=1740652970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+S7zYlGYeCjAulnCrofN1PfLY/a3p/8tfgmUZCm9Ol8=;
        b=jLx37zRlAf/8N7Glx1v3IoT+F6VUIpYieGGXN1qmyAmY3nG2e1oNvEXkc1y6f77l77
         YEgVZZy8uUPyuJjNMiP46UDsNDkMCs5buklRm7dJ5j9P0DHL3h+3BIYL2RxvTt70DrFK
         1Eg4JaTRDl2pzhwpkkGJr7h/9jdmSJwHmyRO9L9NeMLDh0gJ0/T0tdr22fFTYRT9f09D
         WO/zMwTJIXPwSapRUSEOklH5/rTvPgY8cmuiHTi4gWJk/KmM5MT006P8K8QVuKGqXgdX
         6YACn0dHUD9MmWddjLchcRxcwlTcDJp0sHLvDvDu5gQ6A+lqaRqficavR6PKeu8F2roc
         BqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740048170; x=1740652970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+S7zYlGYeCjAulnCrofN1PfLY/a3p/8tfgmUZCm9Ol8=;
        b=GTijNjWvkW38kLI8JbziZPkVlp8IY1YAiuWfNnvBxB7Y9we0OQsp7M6qf6b+ZnCG1b
         f+YiJyqkYpqDpsH+5IAhMh9JZpLgubgIi1kQkoXjZuxMrmaBwZF590s8DbzTTTy8Jqf8
         WBvuBaZbMu4HiQYZGibnHLKkJcr3FO8rjaLSYAPrteydm0YaXYuKY4UOZ8LOleZGrTfN
         /u/S+5hK8ryqcj/hIoXzMLE+GHkoMnkZJH+Y3jM2UoTMuvwT7TEho+t2Sw+9tpj1UbZZ
         1YJzzhYLUC9pwy0nArZkwgpOiyuB2w5spunS3xT7I8vBOXsGl6L5WzyXHW1IYXZsHQfe
         oWyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUovfBslzHg25GEhFXgSi/10vd5pg1VpspV6sddc3t3LH7gABaL04dbNGtvESUJZgGsv3Yf03kL74aPhhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1D+UNnH3WZ61u7MtQhV09d9dGkLgOmaRhsHv65gk2pjy0m3Zr
	xAbmazVqYltZE3NUUpSs59NLMrQq8ecniiarEkBFxzKB1bAbCExF
X-Gm-Gg: ASbGncuooKh79Yhdx++MuzEOMEZgVBunIn8n/r8efcp/DKGRk9OsxaNmdwFAfLr3Flp
	R9W7Z1/ODeLt7rVXMddIG+GbJVEZT39Y7oKd8i078ar7OLk1cY/f+Tej/Zm+TQAgC3VLItfC0hE
	M+QJu4DZ8rYsGC5P03YTJ4nVyp4/cz4nR40uMj4SE+CWjhx638di9b6r0WG6lFix0CkIcsFbAej
	kihGtnA1bigr3EPjHUC4YzfIhcdZbcZvMpg0tFeIfHHWkZ65Na7fXD3+BSXj1AnTBAhUHyiCi5q
	mi8Zkx3mplNd0VUhSfiUsaw/auvM3uN9Yl5mKqyc3VegJF6BZp26tGoOPqE2CqjGk9fNnA==
X-Google-Smtp-Source: AGHT+IF6+xN3/oIAflY+Ife4FcQq4ki50NzVMFwj8uXxU3DGU6xQPyEwAsfz9uqcuVi4Gev3p+wObw==
X-Received: by 2002:a17:906:3ca:b0:abb:e7b0:5449 with SMTP id a640c23a62f3a-abbe7b05ba2mr103453066b.11.1740048169532;
        Thu, 20 Feb 2025 02:42:49 -0800 (PST)
Received: from 0f997e1ceb21.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbdfcaed55sm246474866b.137.2025.02.20.02.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 02:42:49 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v3 11/15] iio: accel: adxl345: add g-range configuration
Date: Thu, 20 Feb 2025 10:42:30 +0000
Message-Id: <20250220104234.40958-12-l.rubusch@gmail.com>
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

Introduce means to configure and work with the available g-ranges
keeping the precision of 13 digits.

This is in preparation for the activity/inactivity feature.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 91 ++++++++++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index fa169cac5c05..ab1ab09f348a 100644
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
@@ -157,7 +191,8 @@ static struct iio_event_spec adxl345_events[] = {
 		BIT(IIO_CHAN_INFO_CALIBBIAS),				\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
-	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE) | \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
 	.scan_index = (index),				\
 	.scan_type = {					\
 		.sign = 's',				\
@@ -483,12 +518,48 @@ static int adxl345_set_odr(struct adxl345_state *st, enum adxl345_odr odr)
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
@@ -507,6 +578,7 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 	__le16 accel;
 	unsigned int regval;
 	enum adxl345_odr odr;
+	enum adxl345_range range;
 	int ret;
 
 	switch (mask) {
@@ -525,8 +597,12 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
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
@@ -558,6 +634,7 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 			     int val, int val2, long mask)
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
+	enum adxl345_range range;
 	enum adxl345_odr odr;
 	int ret;
 
@@ -581,6 +658,12 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
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
@@ -840,6 +923,8 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBBIAS:
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return IIO_VAL_INT_PLUS_MICRO;
 	default:
-- 
2.39.5


