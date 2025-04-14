Return-Path: <linux-iio+bounces-18112-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9569AA88B95
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 20:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA31F189A9A2
	for <lists+linux-iio@lfdr.de>; Mon, 14 Apr 2025 18:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE11291153;
	Mon, 14 Apr 2025 18:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwDioddn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F5928E61B;
	Mon, 14 Apr 2025 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744656180; cv=none; b=gJsP1sJqQjEajb95zqeYftt5d3AbIzI5VrmGGr7EOFdHN2SfY7BQE8prjnPzIho9I2k4PxsVrv0JD6FuyifhgtaXeJ1x+y69yDycKETWAFz05DJjiwxZNTMQtnS4pjG8j1jEhcIJrGG5EMbiax2i6br1ZaadqSrnTQXJNPAPVo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744656180; c=relaxed/simple;
	bh=p6Zyzr7Iafui86EWzpF6wc+ujlG/FIhDJPDAk7GhMgg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=clsagYupb+kyHZ+AQyLgXFdzjWoJ+jsVLUvI34MUbeSL2iKvBIb9kL3F9leIqdypcGInXVcyNJLKPZxhyTTnbIzDjojRs/t0jTuPnReRpwnxeEPhSwPf+JHRuPwGZbc97Uy3W5qmg9AFEPvewSFG/hhA4rwyzQMZ8QG9CvaMLTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwDioddn; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac3f58b9156so57828166b.1;
        Mon, 14 Apr 2025 11:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744656176; x=1745260976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMyvrRvoIga/Ldzp8FDNTbMMeIXb6zc4cLsiCB1GT08=;
        b=DwDioddntsAMgrC/AMRZ4QELMkuBOZ+Os3DJ/UNhckqigGIIAI2oTFZ5ycptRkLOvv
         wO0EGjUeRvoeLw+FOQJKS5kjROeDSYPR5O/6k48bX8L2h/zIyeW/nYNJbKw9BPWyLNkE
         BqkASMGyU5BfCbWeqewnQgOfSUSwgEJk0mHc9bKunxwNApuA0CVlwzg8TjX5fkNvbIQp
         R1pIUvntCHIFbxWWhQBnPEj4J9kTQs9nN2/+gSn8PkQlNwx97htuRjcPssyAmaTVykjW
         DnblBlTse2kWQePn77nev/aY022YkGTZT9ZXfbH2qQMTiSzeD7IqL/JzFf4PcvI1D27j
         Ho3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744656176; x=1745260976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMyvrRvoIga/Ldzp8FDNTbMMeIXb6zc4cLsiCB1GT08=;
        b=LSRxrRc8h8sxmpAaV+Cs4jMMHPwxsnasIl1DvomZZIW1rgNxhOk5H7etUcO1CpC9a6
         C1dpF0MCgj64gLFa1EFah0aBLVqIE5ZIOJh5JMEZgZ86OKLeVP09zQiyKSSCWgZMbA4y
         HtXqknpyfpWNSensK1+BRKVGx8+QotE7zw0kt4B0SGag7d4DNyRsM2w1p+wbxPDwy0yX
         0wHF8jvR89IFGZAqrwIsgKvMXZu2J3CxhWZsFA2imrbNF+o0wU/5kX5tvlj8DfV5y0gE
         rAuY055lqCi/Su1pLr0xsFHEfn8yUfbi8OfIKLfZfK8IPLxGK1dkfnezbEIE0+KqrmPj
         48qQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5cmKH5uAyKb0iGgc6Gzrq/VlDEc+a1hVQ7DnMd8nwUO2G/mbsYeC1ucmZU9jW3aFkQk5dCQIjie3eoGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2eZ1fU1FpD1elH5izVCGc17bN2ulI8HP4IaXawyB61B2HLMLk
	caCfnGoKL341pK2YiUIt0z6O7PJn0zw6vUiATi7xprzETMhBGQCHCjrxWg==
X-Gm-Gg: ASbGncskAyc2gjLF6ZG0K3s3kr0PC0OqtDm+a1n1u/i+qUE7ogyaBoTJYRjCqZTJkxB
	b5p02nqip2NxL4UisqRviaPx9FdsAZXm/qLZW6OxPCsatGscqS5B2v7ZizUMtfx/8SV65fsdZLd
	UrNu0C/nB2oSXxNYeXzGQlVWuQTM6pCmzchfgNnYtnhSgL8pQ3Gps4l1XNm0P0wETKcWGlr+smG
	wuevdcY/RjHRCk9X1XWGujvt0Hzw7T8x6pKzwj4paIBHb0+JPoEZptDBnJ05GJ+/udZaCsRh+8z
	Oz0fpgJyl9j812sPpo3dLdTaH2GLYsj8YvOYDRC7neQV7YIybbmvY5FT2Fy2XaUBY4wXYe+EljI
	v63ztVFNrQ45zcdM8DT8=
X-Google-Smtp-Source: AGHT+IFUboRuDSmMZjxOJJqTfWaNVHLBly5dp1XNxo0odnszfJFX+okFrvzVfQdru7gGErM/PH4MvA==
X-Received: by 2002:a17:907:c89a:b0:ac3:bd7c:178 with SMTP id a640c23a62f3a-acad35803bfmr409062266b.12.1744656176099;
        Mon, 14 Apr 2025 11:42:56 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bb3172sm946483466b.24.2025.04.14.11.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 11:42:55 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v6 07/11] iio: accel: adxl345: add g-range configuration
Date: Mon, 14 Apr 2025 18:42:41 +0000
Message-Id: <20250414184245.100280-8-l.rubusch@gmail.com>
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

Introduce a mechanism to be able to configure and work with the available
g-ranges keeping the precision of 13 digits.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 90 ++++++++++++++++++++++++++++++--
 1 file changed, 87 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 3db757edfad3..166f549ba375 100644
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
@@ -512,12 +547,40 @@ static int adxl345_set_odr(struct adxl345_state *st, enum adxl345_odr odr)
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
@@ -536,6 +599,7 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 	__le16 accel;
 	unsigned int regval;
 	enum adxl345_odr odr;
+	enum adxl345_range range;
 	int ret;
 
 	switch (mask) {
@@ -554,8 +618,12 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
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
@@ -587,6 +655,7 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 			     int val, int val2, long mask)
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
+	enum adxl345_range range;
 	enum adxl345_odr odr;
 	int ret;
 
@@ -615,6 +684,15 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
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
@@ -847,6 +925,8 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBBIAS:
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return IIO_VAL_INT_PLUS_MICRO;
 	default:
@@ -1204,6 +1284,10 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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


