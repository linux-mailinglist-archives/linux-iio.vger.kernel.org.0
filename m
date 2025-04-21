Return-Path: <linux-iio+bounces-18475-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2326A958FC
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 00:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD11E1755A8
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 22:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC1621B9FC;
	Mon, 21 Apr 2025 22:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lw0yForE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC67221FDD;
	Mon, 21 Apr 2025 22:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745273225; cv=none; b=EjqP18ea4TG0MOuu3TJqr/CxCyBN4mGGy76lddExDVsNmFErw9e38Za/0OSYIKUe5FZ1FXtyuI8KLbgpK85E3WZL6q+DJLVryv64Rev+vDIfDMc8pgZvIX3kg9HX0X0aLTrrFtG3xpixHOs0cbX++VF2wmChE3J/t+clP5C9+4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745273225; c=relaxed/simple;
	bh=/OqPkoBfWAuKwsYLkvJU1u0zHSE9W1kE7j7734XlkpU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V5irA50s70HXKUv0VNoyMyAXIsySq9CAE5x4+UUHgpq0lV3StGdBnNVkyoGnfShxqM+OX2SFuU08wd9YhFYKDOlf9erOopDhUgWYhWR/lFMU7mlyo4DJATO7kDWcPWfSC1oPpmMn4A1Kke8yk3WbU+RfeSV5olrIBjXSGxD0p4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lw0yForE; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e8484bb895so1324489a12.0;
        Mon, 21 Apr 2025 15:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745273222; x=1745878022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5b626K7Nkaf57agQTokJNBDI19D5VPDm/uav8QnS+kc=;
        b=lw0yForEZE7kDdGnuC5lCtBc2ZL8pw6/cxlo20theot0slbwWagKu8iI/37b4KyFa1
         PjDG8/bOrUw91ID5WFZfOaEKei8SadKiiQIWFq+/o+aVMekJ9Wdmmk12YapOARP0J/2t
         aq/XJLEY67IYkmhQm7SOBhmuB6didDpaVRN1xz0V0fuV9F3jyFqgCdVoQzzoFMrtGpVE
         j3PgEqYOXek+USlspiPDxlKw1+Uq5NB2ugvim7kQhJXc2F/dZXHRvEmIsw9GCiZhr145
         lgiKgdTgNVxCa8UYupHJ+zHTB/kwOP1uJ8OHQzu/Wf4EIBDID5XI1T0+EU1DAoecHApk
         hGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745273222; x=1745878022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5b626K7Nkaf57agQTokJNBDI19D5VPDm/uav8QnS+kc=;
        b=XIUuw60THbH7TWXV+2FLuhcJqiVp3mXgLoAt9PgzL1t6Hq0jcRYbGQjRVplbLNCtdC
         cGJXePzd0XIgPMSA1WkPMGCEup2nj70Yc5puPLaSpcWlCbUqdGUmtcB/jDfzsJ+Da2j9
         13oTcHIGyXZRCG5hRVCejecdT+MHARQ9p0LdV+1RqN95BWbv5JNtDPDxtgkB2669fZ13
         Hz9NrirCyd9tK/g4XXLCU7m0ChQg4XvY/kCVzxGyx3YghhoNTPcTm/AT5d8I1QtHjayH
         fvWHWq+29uVbGV5CMYndGVXgLarCcRaMmmmy/+xiCBcnyhAuAkKCCX6IOyIsA7vF1PNR
         Nf8A==
X-Forwarded-Encrypted: i=1; AJvYcCVOB7B4prj+FmEDq8Vnyees18WlTA/KvsUmq1PSaydYVnnTFA/DqqRMEMMyPFMo3LDl5IO72iHGWM1d1ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ/AZ5pX8OWDordtVs38i0U/jWKkbVUZVuXrYsguek5kDkSxci
	1sTT5wwevNQfGenLp6ND0nlAECRTnoOPodNdFh/Us3T5IqY4hpe7
X-Gm-Gg: ASbGncsEY7mTdqvaSrFNk2bBDEPp1vMYa/VFjsfnwMGDEQIgNwI+7z/M9bw0XG1j4I+
	HAGXkco4uI3fAe/jd2+l4szUXUNtTHNewrjEK+hn+DaDgCS/XjgPorfuFZCCzIA6FjW7mhta86d
	neLQUY1KysybC9L4Y3rTOfKSMTxqsIGGzGKhuOMtlPfe9nXKjcBPml+GIP/xigz2qnla9cB/kuG
	5vijr9gBsIwBgujU0Mabjh5/iwmr9NC9fmQAzCNS5LSeswbcuuPJ2Lq+lR4MkepLgDa5Co8Mmn/
	w+V2D403EPK8+z9eK2/joNx03G12dQNp0heMkrR7S8IShpX7nBcP47wT7s43Z7rkjnEE8jKgfA4
	5wLvPRqfo/6aXpn8TCb0=
X-Google-Smtp-Source: AGHT+IHEakMIAi6eU5Rae9hTCUTZmtPZyVrg59D9PJXber6SHIEQKdo3XxxLoK7WUTWcshotcL0gkA==
X-Received: by 2002:a17:907:7f0d:b0:acb:583:c63a with SMTP id a640c23a62f3a-acb74dd060cmr337215566b.15.1745273221952;
        Mon, 21 Apr 2025 15:07:01 -0700 (PDT)
Received: from 0e1b0684397b.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acbb8d49fdasm80311666b.67.2025.04.21.15.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 15:07:01 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	eraretuya@gmail.com,
	l.rubusch@gmail.com
Subject: [PATCH v7 07/11] iio: accel: adxl345: add g-range configuration
Date: Mon, 21 Apr 2025 22:06:37 +0000
Message-Id: <20250421220641.105567-8-l.rubusch@gmail.com>
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

Introduce a mechanism to be able to configure and work with the available
g-ranges keeping the precision of 13 digits.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 90 ++++++++++++++++++++++++++++++--
 1 file changed, 87 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 7ed7ee3a8358..80b5b8402ced 100644
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
@@ -147,7 +181,8 @@ static struct iio_event_spec adxl345_events[] = {
 		BIT(IIO_CHAN_INFO_CALIBBIAS),				\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
 		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
-	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE) | \
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
 	.scan_index = (index),				\
 	.scan_type = {					\
 		.sign = 's',				\
@@ -521,12 +556,40 @@ static int adxl345_set_odr(struct adxl345_state *st, enum adxl345_odr odr)
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
@@ -545,6 +608,7 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
 	__le16 accel;
 	unsigned int regval;
 	enum adxl345_odr odr;
+	enum adxl345_range range;
 	int ret;
 
 	switch (mask) {
@@ -563,8 +627,12 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
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
@@ -596,6 +664,7 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
 			     int val, int val2, long mask)
 {
 	struct adxl345_state *st = iio_priv(indio_dev);
+	enum adxl345_range range;
 	enum adxl345_odr odr;
 	int ret;
 
@@ -624,6 +693,15 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
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
@@ -856,6 +934,8 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBBIAS:
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		return IIO_VAL_INT_PLUS_MICRO;
 	default:
@@ -1213,6 +1293,10 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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


